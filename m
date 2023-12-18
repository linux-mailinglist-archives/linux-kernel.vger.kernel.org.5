Return-Path: <linux-kernel+bounces-3205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14319816924
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB851F22B59
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F011C95;
	Mon, 18 Dec 2023 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jehA85YU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C70111AA;
	Mon, 18 Dec 2023 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702890208; bh=gXF4zwPtrzbsMvzl/OG/KlHSiLQN4XqG8q1rytTusLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jehA85YU9WcbUoRVBvQQxScipzxMzPY/w9KZfL8dL0jEdc4grQY/dzJ9r6pzDBhaP
	 T/u++SErVxB09yqNG+QldWap8LSCGZCbualEWsuuFpGrn/6e6Nea+N2aJi5T5iX04o
	 6htm44WrCVg4cICcuuXCx6Y8i4TiC5JpAcjrLAX4FpYCnji60vittpFlXz6JgV5Owr
	 kkK3gCWFlr3Ehyt/KTrJ/0f5kfEueBriNTjLCv+RPD05UcMxHoINLL+dPfPVQjyWzs
	 BY9O6chbSue2t/O7PcPPwvZO4JQuFy7wI0aL8QFnDNyCS6fHfJO3Bd4JvMXIENXXY2
	 PNjmIQVMKUruQ==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id A984110029E; Mon, 18 Dec 2023 09:03:28 +0000 (GMT)
Date: Mon, 18 Dec 2023 09:03:28 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] pwm: Make it possible to apply PWM changes in
 atomic context
Message-ID: <ZYAK4HaWsChgJE12@gofer.mess.org>
References: <cover.1702369869.git.sean@mess.org>
 <57f48330eb606356e86be17f85253f0e3d6ab104.1702369869.git.sean@mess.org>
 <20231212114812.afzgjiunzc6druov@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212114812.afzgjiunzc6druov@pengutronix.de>

Hello Uwe,

On Tue, Dec 12, 2023 at 12:48:12PM +0100, Uwe Kleine-König wrote:
> On Tue, Dec 12, 2023 at 08:34:03AM +0000, Sean Young wrote:
> > +/**
> > + * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
> > + * Cannot be used in atomic context.
> > + * @pwm: PWM device
> > + * @state: new state to apply
> > + */
> > +int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
> > +{
> > +	int err;
> > +
> > +	/*
> > +	 * Some lowlevel driver's implementations of .apply() make use of
> > +	 * mutexes, also with some drivers only returning when the new
> > +	 * configuration is active calling pwm_apply_might_sleep() from atomic context
> > +	 * is a bad idea. So make it explicit that calling this function might
> > +	 * sleep.
> > +	 */
> > +	might_sleep();
> > +
> > +	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
> > +		/*
> > +		 * Catch any drivers that have been marked as atomic but
> > +		 * that will sleep anyway.
> > +		 */
> > +		non_block_start();
> > +		err = pwm_apply_unchecked(pwm, state);
> > +		non_block_end();
> > +	} else {
> > +		err = pwm_apply_unchecked(pwm, state);
> > +	}
> > +
> >  	/*
> >  	 * only do this after pwm->state was applied as some
> >  	 * implementations of .get_state depend on this
> >  	 */
> > -	pwm_apply_debug(pwm, state);
> > +	if (!err)
> > +		pwm_apply_debug(pwm, state);
> 
> It's easier to keep that in pwm_apply_unchecked(), isn't it? Then
> pwm_apply_atomic() also benefits from the checks.

Good point.

> I'm not so happy with the function name of pwm_apply_unchecked(), but I
> don't have a good suggestion either. Probably I'd have chosen
> __pam_apply(), but that's probably subjective.

That is more consistent, fixed in v9.


Sean

