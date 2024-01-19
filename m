Return-Path: <linux-kernel+bounces-30867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6193832549
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4788FB24F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439DDDA0;
	Fri, 19 Jan 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZardnbwE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6248D51A;
	Fri, 19 Jan 2024 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650554; cv=none; b=jWFPVZQe2ccQ1KYJCGQUKvAoYC760uWoVrH+B+d6mW5wUYVZDKrKJluKM1c5+PY3HPuQCAbKUhqr68asN+xE93a+fPzjM3tif1/Lau34kG97DXlKctY5N3pkBQDhVcVBKKOTgeYtQQv35+MEE/VcdR2aHGv2hJ/+tzVhJJIECMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650554; c=relaxed/simple;
	bh=H3Uf7Js0UOTDnU9yKusaLcwDSQM/Nh+Ict3ZoBItJfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9cUIcQD6S8KeGz9YZ3V+XXh99dIbS+BH2Ux3weLXyf4L4gYsDfmddziMprcK5YvL2wizPJTKIhzlwjjEy7sNriMNvP1Q5YBwkrgMrU9zaZdVEEhmUmnRbR8k0QUTTPnnTllUp/ADT8sefxtKGbbjw5FJ49L3KV6j5Fdig+jX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZardnbwE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636ADC433C7;
	Fri, 19 Jan 2024 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705650553;
	bh=H3Uf7Js0UOTDnU9yKusaLcwDSQM/Nh+Ict3ZoBItJfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZardnbwEoHWHVe1huoYuqGjGy5RMTQ2xqcP/ggeD/uYY40AHqvma5Q8pJRCDUHTbT
	 +NBWsSD4TRLpUKaainwQgZUqyhdKENDQriHmg5bNwAlh84Kx04wpUac6uxAq+p91CE
	 WOgNClmK7U+Bt5q2VKlDMfxxHxsvZm3dsjw2e+cM+LOTrg7eCjqqL0bc7GpHDusHu7
	 mwFza30HiIXeORgiJK6rpPlF0wU4j2Msx4bCK57AkIdN4BSe7SXNw8oBfIyqX6uHO4
	 mEHvr5bCZbgDAoUwrS6QnBkJYTbwSEQqtfFU5NufqDwYGaNMESR8ezW9+oRQMuoCOs
	 4llD1WaH6oxzw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjcv-0004VT-38;
	Fri, 19 Jan 2024 08:49:22 +0100
Date: Fri, 19 Jan 2024 08:49:21 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: codecs: wsa883x: fix PA volume control
Message-ID: <ZaopgcKTV0ePamsC@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-2-johan+linaro@kernel.org>
 <3494d23f-2a56-4f13-a619-e240d208d300@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3494d23f-2a56-4f13-a619-e240d208d300@linaro.org>

On Fri, Jan 19, 2024 at 07:14:03AM +0000, Srinivas Kandagatla wrote:
> On 18/01/2024 16:58, Johan Hovold wrote:
> > The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
> > in fifteen levels.
> > 
> > Fix the range of the PA volume control to avoid having the first
> > sixteen levels all map to -3 dB.

> TBH, we really don't know what unsupported values map to w.r.t dB.

I've verified experimentally that all values in the range 0..16 map to
the same lowest setting, and only at level 17 is there a perceivable
difference in gain.

And the datasheet you have access to describes the range as -3 to 18 dB.

> > Note that level 0 (-3 dB) does not mute the PA so the mute flag should
> > also not be set.
> > 
> > Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
> > Cc: stable@vger.kernel.org      # 6.0
> > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   sound/soc/codecs/wsa883x.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> > index cb83c569e18d..32983ca9afba 100644
> > --- a/sound/soc/codecs/wsa883x.c
> > +++ b/sound/soc/codecs/wsa883x.c
> > @@ -1098,7 +1098,7 @@ static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
> >   	return 1;
> >   }
> >   
> > -static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, -300);
> > +static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, 0);
> >   
> >   static int wsa883x_get_swr_port(struct snd_kcontrol *kcontrol,
> >   				struct snd_ctl_elem_value *ucontrol)
> > @@ -1239,7 +1239,7 @@ static const struct snd_soc_dapm_widget wsa883x_dapm_widgets[] = {
> >   
> >   static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
> >   	SOC_SINGLE_RANGE_TLV("PA Volume", WSA883X_DRE_CTL_1, 1,
> > -			     0x0, 0x1f, 1, pa_gain),
> > +			     0x1, 0xf, 1, pa_gain),
> 
> gain field in register is Bit[5:1], so the max value of 0x1f is correct 
> here. However the range of gains that it can actually support is only 0-15.
> 
> If we are artificially setting the max value of 0xf here, then somewhere 
> we should ensure that Bit[5] is set to zero while programming the gain.

Good point, but the reset value for that bit is 0 so we should be good
here.

I'll also update patch 2/5 so that we explicitly set this register on
probe in the unlikely event that something else has left that bit set
before Linux boots (and the powerdown at probe isn't sufficient).
 
> Whatever the mixer control is exposing is clearly reflecting what 
> hardware is supporting.

No, not at all. The range exported to user space is all wrong and this
breaks volume control in pulseaudio which expects the dB values to
reflect the hardware.

If changing the range is a concern (as Mark mentioned), we at least have
to fix the dB values.

And if this is something that may differ between the WSA883x variants
currently handled by the driver then that needs to be taken into account
too. I only have access to wsa8835 (and no docs, unlike you).

Johan

