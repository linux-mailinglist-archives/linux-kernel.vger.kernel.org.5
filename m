Return-Path: <linux-kernel+bounces-30882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E5832573
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5E61F21CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0BBDF6C;
	Fri, 19 Jan 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1GJpxsh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A7E24B2C;
	Fri, 19 Jan 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651804; cv=none; b=Q+Ii7B06WPpPUHYej/rIc9y5csrPyQbr0tWcwuRQPXMNw9GAHOS/GBhjX1NPQAzguDSHkxctR4UrdnN2V1O/byynEF8NPuJLoEcjvN/ZB5nsslvmlozbZ5zis4x8SFWE7HDlM7x5K+xHarFO6TfzDtIxrGfaRKJAiQVaqATEuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651804; c=relaxed/simple;
	bh=sweX0lH8wV/qg+9x/p+aQgBhduMihO9OquglHodEy6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/28jlak8t5V1qwbz5/ldOIFqLa6XvlxkE16vmGfkq6jrGgBtHeE9JmTx9iv29ycRNpR7xubwx6rZ3cDN56IQGXjZJWoNg8fO7DIcTW+Vfpayj4RjUCLvA59rnrIAj4rMXr7hi6g3oU6LMnbaoIBcWE7z9MaX0UWUOmYlyxwB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1GJpxsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED20C433F1;
	Fri, 19 Jan 2024 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705651804;
	bh=sweX0lH8wV/qg+9x/p+aQgBhduMihO9OquglHodEy6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1GJpxshVNXbcnh+rHok44XHEi1GbciwMQyriaMljWZFwGl4NuvANC2ciTKw6Q9cE
	 hwlcSSozhnAvGMVhQpmBpaIIa7gknJZyCgOznuRK52AWLr+Wq3azpdsofOO/1WoYj7
	 h354lyLNSg7ewFAH3Vbgdz4gQNifLukLdqTmIHC3KbWVwS/lBrGkSAAILf1AA5ESFk
	 RDlrxeExrwTtT+aleDaGhX4sxKYlXyAOCVT+yH45ChkypZaIBM3rgMCRSmtbCxgt1Z
	 h0N9d4RqiTT8gmzQkYknAJBH7NioLfYjp1wIrRKHVjK9ydtBcZISqi0eW68RAGeajL
	 pRbtzTGNveEbg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjx7-0004be-0S;
	Fri, 19 Jan 2024 09:10:13 +0100
Date: Fri, 19 Jan 2024 09:10:13 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ASoC: codecs: lpass-wsa-macro: fix compander
 volume hack
Message-ID: <ZaouZXdxWv3oahDl@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-5-johan+linaro@kernel.org>
 <6d8f77e2-7257-4a6c-96de-fd3f1c821b51@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d8f77e2-7257-4a6c-96de-fd3f1c821b51@linaro.org>

On Fri, Jan 19, 2024 at 07:45:45AM +0000, Srinivas Kandagatla wrote:
> On 18/01/2024 16:58, Johan Hovold wrote:
> > The LPASS WSA macro codec driver is updating the digital gain settings
> > behind the back of user space on DAPM events if companding has been
> > enabled.
> > 
> > As compander control is exported to user space, this can result in the
> > digital gain setting being incremented (or decremented) every time the
> > sound server is started and the codec suspended depending on what the
> > UCM configuration looks like.
> > 
> > Soon enough playback will become distorted (or too quiet).
> > 
> > This is specifically a problem on the Lenovo ThinkPad X13s as this
> > bypasses the limit for the digital gain setting that has been set by the
> > machine driver.
> > 
> > Fix this by simply dropping the compander gain offset hack. If someone
> > cares about modelling the impact of the compander setting this can
> > possibly be done by exporting it as a volume control later.
> > 
> > Note that the volume registers still need to be written after enabling
> > clocks in order for any prior updates to take effect.
> > 
> > Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> > Cc: stable@vger.kernel.org      # 5.11
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   sound/soc/codecs/lpass-wsa-macro.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> > index 7e21cec3c2fb..6ce309980cd1 100644
> > --- a/sound/soc/codecs/lpass-wsa-macro.c
> > +++ b/sound/soc/codecs/lpass-wsa-macro.c
> > @@ -1584,7 +1584,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
> >   	u16 gain_reg;
> >   	u16 reg;
> >   	int val;
> > -	int offset_val = 0;
> 
> TBH, as discussed in my previous review we should just remove 
> spkr_gain_offset and associated code path.

I don't understand what you are referring to. Are you talking about the
"ear_spkr_gain" perhaps?

I left that hack in place for now, as it's not currently an issue. It
could perhaps be removed later.

Johan

