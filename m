Return-Path: <linux-kernel+bounces-77306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB05860393
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD52C1C22AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B853671728;
	Thu, 22 Feb 2024 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="i1dtVq+j"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6A6E60E;
	Thu, 22 Feb 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708633091; cv=none; b=cnOIit0d+Sy28/7Jm0HzpMoBi6LVSaipuv5CSkDolXgNcmjpSGUnmm4f91NXonUcVhxGtrDbLCcChJFngAhS/bqAl4qrAPf2Ako22682yu8AF3t2L7x/GOvQ1+jx9kDyM+eI+z/+DjabVSkZLt7vJHXB7qJNZs/5haF8NvLyp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708633091; c=relaxed/simple;
	bh=EiUKoJgFF8oMypTNd3c6JPLCRhgmvWHjSm7jz6q9M+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+KLQBFXomyExzbyZa8IjsuLbMQqdiCJUVzpOmTPldUkF+bKo6+a/sXH+LU5chY2qmtQ0saYVEoLXAlYNU23VCVdTeRU3m16CPco7VqJPqeASHTsoZwoVKeSnrmRkEfonzI3EHG9F6PUESsIWv6q1zcNohuoWTVTsvdyx4De4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=i1dtVq+j; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708633080; bh=EiUKoJgFF8oMypTNd3c6JPLCRhgmvWHjSm7jz6q9M+s=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=i1dtVq+jo6ykSMcJvbLZEq52v7fc+zMoNxFGgWEUcNmnMtOh9qZj6CG30t3bojQ+Q
	 vi0DRONkalTi7/8SPOBqJMed+f8XTY9mJMSTXvfoOmpUvIdIRcVq1WvicVNvobfdNv
	 yMm3SW4kiWVCUVCOgdnYl+yphmyUU5wyokGm/grw=
Date: Thu, 22 Feb 2024 21:18:00 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] ASoC: sun8i-codec: Implement jack and accessory
 detection
Message-ID: <vmi3fkm47wf7cbfakubbye4ce7ol5kjpg3edkrati2lhsl6qej@57uir6fjjzq2>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240222181851.3398254-1-megi@xff.cz>
 <20240222181851.3398254-5-megi@xff.cz>
 <0c351386-f1df-443f-a997-261f5c60c852@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c351386-f1df-443f-a997-261f5c60c852@sirena.org.uk>

Hello Mark,

On Thu, Feb 22, 2024 at 06:41:13PM +0000, Mark Brown wrote:
> On Thu, Feb 22, 2024 at 07:18:47PM +0100, Ondřej Jirman wrote:
> 
> > +static struct snd_soc_jack_pin sun8i_codec_jack_pins[] = {
> > +	{
> > +		.pin	= "Headphone Jack",
> > +		.mask	= SND_JACK_HEADPHONE,
> > +	},
> > +	{
> > +		.pin	= "Headset Microphone",
> > +		.mask	= SND_JACK_MICROPHONE,
> > +	},
> > +};
> > +
> 
> The jack being a headset jack is going to be system specific isn't it?
> Some systems might have separate headphone and microphone jacks.  I'd
> not expect to see any pin handling code at all in a CODEC driver, that
> belongs in the machine driver.

Yeah, the only reason this and the card reference seems to be here is to
check whether jack detection should be enabled and in what capacity.

Looks like there's some set_jack component callback for that. :)

I'll look into that.

kind regards,
	o.

> >  static int sun8i_codec_component_probe(struct snd_soc_component *component)
> >  {
> >  	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> >  	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(component);
> >  	int ret;
> >  
> > +	scodec->card = component->card;
> > +
> 
> The fact that you're needing to look at the card here should be a bit of
> a warning sign there.



