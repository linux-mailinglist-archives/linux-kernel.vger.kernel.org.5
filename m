Return-Path: <linux-kernel+bounces-139887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E508A08E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9167D282306
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729D013DB8D;
	Thu, 11 Apr 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvNxYyjs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A063D;
	Thu, 11 Apr 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818516; cv=none; b=aapPD4F7sH2+26H+pmEjPGOwMeWc511JkC5wsk2ZTMz0G/jmcz1eIwYEEzIrLJ9NDonJ3lgIh0OMvjhwr8oQ1Mj5zOOmoD4wr+mTOu2IogYZZOax+gkiNZCMZ1LyxuqwszVxfkv/aE0MSkY5xyd7maCSxm4tDiLT7PZEMP44Ifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818516; c=relaxed/simple;
	bh=g5uFzpLBD5mMvoeBx8hAdujf+J4m8llZ6LvgrHfw/qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq0Qop138Q7x/7X0ILv2SYOypie2nFIJy5hC2j0qHfZwdtM4go/3BB0BZ6U0rh1bTdO/bCPWyt+Hjcch07tOLdUsplQmcgjMaOQBgvm/f9ZHEaioeIoBlGaFYUFGrHbLYCdSuTkuh68IZyNMbiH9/ipXZQH0tpwjw/Ygp2krH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvNxYyjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F3AC433C7;
	Thu, 11 Apr 2024 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818516;
	bh=g5uFzpLBD5mMvoeBx8hAdujf+J4m8llZ6LvgrHfw/qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvNxYyjsAvCfq31BNCEVkvEyXMKqXg17zoo7EoJSAq2MhkmyRtqBo2DG+2Ssxh0TN
	 0mtKRf7SNGnt4dwLynbgqlfJ2dgqXrwu52VMW6bXvShCdH7WF89v9WoNW3hj0nIzba
	 jffDoK1d5Fp3YmDVOciJfQQlJ7HDJTgcCy4GQEHNv6vh9TR9kBTl3ngPRT5G69VI85
	 MXgiWEZTCbnWSyzbZzKDdGh/+g/HuUsPq6nz2DqeYu2PtRF7nf5GCpJGY6aUJJGuUN
	 QU9Fww/Ln77Q3okVcn7v0WKeIXxi5fKU2aDYHErN5KaEOfszOylPhdAl1U8b3PPGjD
	 72xWSWZmp3Wig==
Date: Thu, 11 Apr 2024 07:55:11 +0100
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>, pavel@ucw.cz, matthias.bgg@gmail.com,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, peterwu.pub@gmail.com,
	cy_huang@richtek.com
Subject: Re: [PATCH] leds: mt6360: Fix the second LED can not enable torch
 mode by V4L2
Message-ID: <20240411065511.GB6194@google.com>
References: <d1d1419bb322e2b0f40d34edd3a66979015b668c.1712657386.git.chiaen_wu@richtek.com>
 <c98ea7c9-6c9b-466d-bc49-ec76874ac6da@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c98ea7c9-6c9b-466d-bc49-ec76874ac6da@collabora.com>

On Tue, 09 Apr 2024, AngeloGioacchino Del Regno wrote:

Not sure why, but this mail was sent unthreaded from the original.

> Il 09/04/24 12:21, ChiaEn Wu ha scritto:
> > V4L2 will disable strobe mode of the LED device when enable torch mode,
> > but this logic will conflict with the "priv->fled_torch_used"
> > in "mt6360_strobe_set()". So after enabling torch mode of the first
> > LED, the second LED will not be able to enable torch mode correctly.
> > 
> > Therefore, at the beginning of "mt6360_strobe_set()", check whether the
> > state of the upcoming change and the current LED device state are the
> > same, so as to avoid the above problem.
> > 
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> >   drivers/leds/flash/leds-mt6360.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
> > index a90de82f4568..1b75b4d36834 100644
> > --- a/drivers/leds/flash/leds-mt6360.c
> > +++ b/drivers/leds/flash/leds-mt6360.c
> > @@ -241,10 +241,20 @@ static int mt6360_strobe_set(struct led_classdev_flash *fl_cdev, bool state)
> >   	u32 enable_mask = MT6360_STROBEN_MASK | MT6360_FLCSEN_MASK(led->led_no);
> >   	u32 val = state ? MT6360_FLCSEN_MASK(led->led_no) : 0;
> >   	u32 prev = priv->fled_strobe_used, curr;
> > -	int ret;
> > +	int ret = 0;
> 
> I prefer that you leave ret uninitialized here, and...

What's the reason for this?

> >   	mutex_lock(&priv->lock);
> > +	/*
> > +	 * If the state of the upcoming change is the same as the current LED
> > +	 * device state, then skip the subsequent code to avoid conflict
> > +	 * with the flow of turning on LED torch mode in V4L2.
> > +	 */
> > +	if (state == !!(BIT(led->led_no) & prev)) {
> > +		dev_info(lcdev->dev, "No change in strobe state [0x%x]\n", prev);
> 
> ...that you do here, instead
> 
> 		ret = 0;
> 		goto unlock;
> 
> With that addressed,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collaobra.com>
> 
> 

-- 
Lee Jones [李琼斯]

