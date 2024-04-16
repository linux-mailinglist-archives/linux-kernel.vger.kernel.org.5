Return-Path: <linux-kernel+bounces-146759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28BF8A6A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDCFB210F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881212A163;
	Tue, 16 Apr 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAL+717C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1C12AACA;
	Tue, 16 Apr 2024 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269723; cv=none; b=UrFm/NOTVNse0HQL22Ft0JHkaa+dj69J6kiPDO9UCGpQPY/urYTUFeJIA094UjB4cWsNLWbLomzrHis3ffIbQawqHRA1JE6KGcH3hIT4rGzTuS70F2Lq3+LjGpmKWGVc321yL2EyYrLN4ZnjTS9UoEcSCrjdH2CMQCIZptFOP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269723; c=relaxed/simple;
	bh=Pn2alMweH9AQ/4nJwvXEDdpqKLi+Ur2nCRL4Qlf1KC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2Msh5JmTfhLuK53D8m1CrYD8L4XE0YV0boINHhi2ZygMTaNhTRdEKYMDGp/o+/PKpWGjJAYKe2G/nfUxnpRk+3LDjCW/emnBEBf9aBuQUMNckp7DqqZVyhqBZ3p1tuVBVz1gHjnYgZnihsHL+BLiZSGLEa8cx++ZA3Rr/R5D18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAL+717C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8351C113CE;
	Tue, 16 Apr 2024 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269723;
	bh=Pn2alMweH9AQ/4nJwvXEDdpqKLi+Ur2nCRL4Qlf1KC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAL+717Cp96qKDTmVR1p8gTgJLTXDR+pZ7qM9UmfwPrP9qjDZhfocycKBAc0HzXbv
	 ZJrGRocKM5Gk2VdTrhCjKTS9TqVbRwEwCnXLMMWXQ4nE6bR/D5FeadFUb7wOHplYAW
	 ed/QFXjaArF/gjiZ/iWNYhfmXkEj9OQeHkOql7tntP/TXeUNn4c1kVtx/2PQA50yfX
	 sTk4jNZ2cKhK0EJQnEji/o7w3ww8hgzOu3o3O4KjfYadow93fD4EziL/EOVMK1Eajs
	 +6KiWWNkX0qqjSn5gLifarM/nazrJ/zovC3l5BEBkFa1f47ShMyHoi0CtQXTtbBbre
	 gJ+K9bfV5NLMw==
Date: Tue, 16 Apr 2024 13:15:19 +0100
From: Lee Jones <lee@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] stm32mp1xx based targets stopped entering suspend
 if pwm-leds exist
Message-ID: <20240416121519.GS2399047@google.com>
References: <5da6cf8a-4250-42f6-8b39-13bff7fcdd9c@leemhuis.info>
 <2vbwacjy25z5vekylle3ehwi3be4urm6bssrbg6bxobtdlekt4@mazicwtgf4qb>
 <256e3d3c-d43f-4bd6-9a7b-50fc870e75e4@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <256e3d3c-d43f-4bd6-9a7b-50fc870e75e4@leemhuis.info>

On Tue, 16 Apr 2024, Linux regression tracking (Thorsten Leemhuis) wrote:

> On 06.03.24 09:18, Uwe Kleine-König wrote:
> > On Wed, Mar 06, 2024 at 08:05:15AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>
> >> Uwe, I noticed a report about a regression in bugzilla.kernel.org that
> >> apparently is caused by a change of yours. As many (most?) kernel
> >> developers don't keep an eye on it, I decided to forward it by mail.
> >>
> >> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> >> not CCed them in mails like this.
> >>
> >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218559 :
> >>
> >>> Commit 76fe464c8e64e71b2e4af11edeef0e5d85eeb6aa ("leds: pwm: Don't
> >>> disable the PWM when the LED should be off") prevents stm32mp1xx based
> >>> targets from entering suspend if pwm-leds exist, as the stm32 PWM driver
> >>> refuses to enter suspend if any PWM channels are still active ("PWM 0
> >>> still in use by consumer" see stm32_pwm_suspend in drivers/pwm/stm32-pwm.c).
> >>>
> >>> Reverting the mentioned commit fixes this behaviour but I'm not
> >>> certain if this is a problem with stm32-pwm or pwm-leds (what is the
> >>> usual behaviour for suspend with active PWM channels?).
> > 
> > I'd assume the following patch fixes this report. I didn't test it
> > though.
> 
> Jakob confirmed it helped in the bugzilla ticket. But the patch since
> then didn't make any progress afaics -- or did it and I just missed it
> in my search?

[...] 

> > ---->8----
> > From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > Subject: [PATCH] leds: pwm: Disable PWM when going to suspend
> > 
> > On stm32mp1xx based machines (and others) a PWM consumer has to disable
> > the PWM because an enabled PWM refuses to suspend. So check the
> > LED_SUSPENDED flag and depending on that set the .enabled property.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218559
> > Fixes: 76fe464c8e64 ("leds: pwm: Don't disable the PWM when the LED should be off")
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/leds/leds-pwm.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> > index 4e3936a39d0e..e1b414b40353 100644
> > --- a/drivers/leds/leds-pwm.c
> > +++ b/drivers/leds/leds-pwm.c
> > @@ -53,7 +53,13 @@ static int led_pwm_set(struct led_classdev *led_cdev,
> >  		duty = led_dat->pwmstate.period - duty;
> >  
> >  	led_dat->pwmstate.duty_cycle = duty;
> > -	led_dat->pwmstate.enabled = true;
> > +	/*
> > +	 * Disabling a PWM doesn't guarantee that it emits the inactive level.
> > +	 * So keep it on. Only for suspending the PWM should be disabled because
> > +	 * otherwise it refuses to suspend. The possible downside is that the
> > +	 * LED might stay (or even go) on.
> > +	 */
> > +	led_dat->pwmstate.enabled = !(led_cdev->flags & LED_SUSPENDED);
> >  	return pwm_apply_might_sleep(led_dat->pwm, &led_dat->pwmstate);
> >  }
> > 
> > base-commit: 15facbd7bd3dbfa04721cb71e69954eb4686cb9e
> > ---->8----

Did you submit this?  I don't see it in LORE or in my inbox.

-- 
Lee Jones [李琼斯]

