Return-Path: <linux-kernel+bounces-150594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C58AA165
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E391E284B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343321779A9;
	Thu, 18 Apr 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="dR1AH/e9"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32D3168B06;
	Thu, 18 Apr 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713462658; cv=none; b=QF6xlZwM0wlt36le8IEhSSCjMF5MEHDK1tKtnslE98zQbogJB3f3SHrGhoMdwchm+nFBidncFUfI+3ET/QXhvGMldzTYULptHdMRwCQTZEYvmKIE6tTl4qT10i3bfPocrlR3oJTEzymHmQIpIoOU5No3c5ZDB42L2CFwzxYkjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713462658; c=relaxed/simple;
	bh=rNe8Fy7Y8K2hLaFXzMJJFlHwm2uFh2o7gtVK7iibMas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi+rUf/bPmCQ5HVbtgTSotIG1D2NFTpy2LMzVFJ40gy5iVFsrt7vIFK+Pt2/ARRbfEZkF+RkJcv3AnkXre81X+jVFkw3hpZIzKLvF+Fz9anA7gUQpQIdgsmrdSCSloO4mMWOkIDi28z+LJUgEXxQch8KvsN8hMlD07W8fPqbB10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=dR1AH/e9; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 56A0444E48;
	Thu, 18 Apr 2024 17:50:54 +0000 (UTC)
Date: Thu, 18 Apr 2024 13:50:52 -0400
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, phone-devel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH 2/4] iio: light: stk3310: Implement vdd supply and power
 it off during suspend
Message-ID: <fvuaq2yo4jh6jc3cklkvatr5r5du2jzmqblvvkpkpmxdt7e2ys@345lrhtnipfw>
References: <20240414175300.956243-1-aren@peacevolution.org>
 <20240414175716.958831-1-aren@peacevolution.org>
 <20240414175716.958831-2-aren@peacevolution.org>
 <CAHp75VdZavToGYqLYnkKYt53HXoQxXnRER5Cn5b2==gWTvkAWQ@mail.gmail.com>
 <xxeg3as5m5vmmu6fbjujcnvchrerxs2rr42nloirwsktbv4r57@vpxtxblxmspl>
 <CAHp75Veoibnk2pYuAY-T+u=8t7ackQ8zBjxSHcWb1AeHnq84yQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Veoibnk2pYuAY-T+u=8t7ackQ8zBjxSHcWb1AeHnq84yQ@mail.gmail.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1713462655;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=CpuYA2U5zadpTrpInLy8Sg85CTz03F2QsvGOdLrnGeA=;
	b=dR1AH/e9KzKYSyF/GUm1Q6nVED2/EsOuZ8Eg5UhDFIPVJCfWquLu9qcFxv4fT5yrlV+xzm
	ojtYymcNuCN6xCcAxKJDRHfnSRZQX8u4hFFQQCvSlHIUfPI4922XfZoe92YYAWUBmUogiU
	w+yBRCWIPEw/51bWz81gYO3NGCwo6XU=

On Thu, Apr 18, 2024 at 06:56:09PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 18, 2024 at 6:06 PM Aren <aren@peacevolution.org> wrote:
> > On Mon, Apr 15, 2024 at 05:04:53PM +0300, Andy Shevchenko wrote:
> > > On Sun, Apr 14, 2024 at 8:57 PM Aren Moynihan <aren@peacevolution.org> wrote:
> 
> ...
> 
> > > >         stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
> > > > +       if (data->vdd_reg)
> > > > +               regulator_disable(data->vdd_reg);
> > >
> > > I forgot to check the order of freeing resources, be sure you have no
> > > devm_*() releases happening before this call.
> >
> > If I understand what you're saying, this should be fine. The driver just
> > uses devm to clean up acquired resources after remove is called. Or am I
> > missing something and resources could be freed before calling
> > stk3310_remove?
> 
> I'm not objecting to that. The point here is that the resources should
> be freed in the reversed order. devm-allocated resources are deferred
> to be freed after the explicit driver ->remove() callback. At the end
> it should not interleave with each other, i.o.w. it should be
> probe: devm followed by non-devm
> remove: non-devm only.

I think what you're describing is already the case, with the exception
of parts of the probe function not changed in this patch mixing
acquiring resources through devm with configuring the device.

I hope I'm not being dense, thanks for the clarification
 - Aren

