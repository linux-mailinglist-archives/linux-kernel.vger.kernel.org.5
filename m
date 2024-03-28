Return-Path: <linux-kernel+bounces-122616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19588FA6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6A01F28585
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29947BB1B;
	Thu, 28 Mar 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="qLMtLBgU"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A2651AB;
	Thu, 28 Mar 2024 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615949; cv=none; b=dlXab0CJgUKJJgjMmDjsmLcOuAiLiEdnVk7TJrdzAYrVlFLP8hHAhb9TWAjt8+Cf5VEVuBZv6GhWA6iODgqfp6OL1caDCIl1iD4KhQd0MzKRHF7g80Ht6pY1PBo5DOLrhu7PgOv3nReGRIJSNQAEIChGjM+9FSGO5sTpR2JVEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615949; c=relaxed/simple;
	bh=dsKxujkndwuIXXBgJmltW299ZElFVf2kBrZ2ot/Sd3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBcPfmRw/wP+51uG/Em5whhD+vw9BFPJpnyqObuJ4RBFYDlOovh8jp9reBVahDHLha/o2nBxEiRUFx9NAyp5hh59ssapH60bzFllg3M3G91u560hVtMm2mjHD/6VjqEa02nR5nZVqOT15FNdKXTUSVS/OdrfxGw6FpOBiJ1Mcls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=qLMtLBgU; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1711615937; bh=dsKxujkndwuIXXBgJmltW299ZElFVf2kBrZ2ot/Sd3M=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=qLMtLBgUyLgoz9elITROY3qv7nsVk9kkjyeA7hgjLP88rrbIKJo4w037UezGlX+4q
	 qsLE6CCNy9EwLhvU2Mol0QwwTUzfkEEin6DGPlixWDqoYlK3sFxi6PXobZrVUMogrq
	 FvL4AafmQLdbZ/NZyEyTFo9EqIT/0jYsOlxaHl+w=
Date: Thu, 28 Mar 2024 09:52:17 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH] ASoC: sun8i-codec: Fix build with
 CONFIG_SND_JACK_INPUT_DEV disabled
Message-ID: <mr4oqcufxojw2jocj3hbjz6m6sthoauby5ggbps7ahy7hgxh75@2ztouzzmso4n>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240327080542.3649840-1-megi@xff.cz>
 <1785985.VLH7GnMWUR@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1785985.VLH7GnMWUR@jernej-laptop>

Hello Jernej,

On Wed, Mar 27, 2024 at 08:43:31PM +0100, Jernej Škrabec wrote:
> Dne sreda, 27. marec 2024 ob 09:05:34 CET je Ondřej Jirman napisal(a):
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > When CONFIG_SND_JACK_INPUT_DEV is disabled, struct snd_jack doesn't
> > have 'type' field. We can't rely on this field being always present,
> > so store the jack_type in the codec driver itself.
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202403261243.kcXCPAYs-lkp@intel.com/
> > ---
> > This is a followup for https://lore.kernel.org/lkml/2vhd45kylttgonosdcfn7ugwyy2vx56gijwf3ealz4tel65iqr@cs3kxrl6d2hh/
> > 
> >  sound/soc/sunxi/sun8i-codec.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> > index 43795362fed0..b5dafb749c3f 100644
> > --- a/sound/soc/sunxi/sun8i-codec.c
> > +++ b/sound/soc/sunxi/sun8i-codec.c
> > @@ -232,6 +232,7 @@ struct sun8i_codec {
> >  	struct delayed_work		jack_work;
> >  	int				jack_irq;
> >  	int				jack_status;
> > +	int				jack_type;
> 
> Where is this variable set? Below I see just usage of its value.

It's going to be set in probe function, once generic DT bindings for jack-type
are figured out. This is mentioned in the v3 cover letter for
https://lore.kernel.org/lkml/20240302140042.1990256-1-megi@xff.cz/

I plan on sending support for generic property mentioned here
https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-component.c#L288
but it may need several iterations, and fail to get merged for various reasons
and I may need to fall back to vendor DT property, then.

If you want to test/use the jack detection on some A64 board now, what's needed
to enable this is to add:

  scodec->jack_type = SND_JACK_HEADSET | SUN8I_CODEC_BUTTONS;

  (or just SND_JACK_HEADPHONE, depednding on jack type)

to probe function and add get_jack_type callback to sun8i_soc_component:

  static int sun8i_codec_component_get_jack_type(struct snd_soc_component *component)
  {
	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(component);

	return scodec->jack_type;
  }

Then detection will get enabled on A64 SoC based boards that use simple-audio-card.
(if codec is in simple-audio-card,aux-devs)

Simple card iterates through aux devices and adds jacks for the ones that return
something from component's get_jack_type() callback:

   https://elixir.bootlin.com/linux/latest/source/sound/soc/generic/simple-card-utils.c#L822

kind regards,
	o.

> Best regards,
> Jernej
> 
> >  	int				jack_last_sample;
> >  	ktime_t				jack_hbias_ready;
> >  	struct mutex			jack_mutex;
> > @@ -1352,7 +1353,6 @@ static void sun8i_codec_jack_work(struct work_struct *work)
> >  	struct sun8i_codec *scodec = container_of(work, struct sun8i_codec,
> >  						  jack_work.work);
> >  	unsigned int mdata;
> > -	int type_mask = scodec->jack->jack->type;
> >  	int type;
> >  
> >  	guard(mutex)(&scodec->jack_mutex);
> > @@ -1363,7 +1363,7 @@ static void sun8i_codec_jack_work(struct work_struct *work)
> >  
> >  		scodec->jack_last_sample = -1;
> >  
> > -		if (type_mask & SND_JACK_MICROPHONE) {
> > +		if (scodec->jack_type & SND_JACK_MICROPHONE) {
> >  			/*
> >  			 * If we were in disconnected state, we enable HBIAS and
> >  			 * wait 600ms before reading initial HDATA value.
> > @@ -1376,7 +1376,7 @@ static void sun8i_codec_jack_work(struct work_struct *work)
> >  			scodec->jack_status = SUN8I_JACK_STATUS_WAITING_HBIAS;
> >  		} else {
> >  			snd_soc_jack_report(scodec->jack, SND_JACK_HEADPHONE,
> > -					    type_mask);
> > +					    scodec->jack_type);
> >  			scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
> >  		}
> >  	} else if (scodec->jack_status == SUN8I_JACK_STATUS_WAITING_HBIAS) {
> > @@ -1417,17 +1417,17 @@ static void sun8i_codec_jack_work(struct work_struct *work)
> >  		if (type == SND_JACK_HEADPHONE)
> >  			sun8i_codec_set_hmic_bias(scodec, false);
> >  
> > -		snd_soc_jack_report(scodec->jack, type, type_mask);
> > +		snd_soc_jack_report(scodec->jack, type, scodec->jack_type);
> >  		scodec->jack_status = SUN8I_JACK_STATUS_CONNECTED;
> >  	} else if (scodec->jack_status == SUN8I_JACK_STATUS_CONNECTED) {
> >  		if (scodec->last_hmic_irq != SUN8I_HMIC_STS_JACK_OUT_IRQ_ST)
> >  			return;
> >  
> >  		scodec->jack_status = SUN8I_JACK_STATUS_DISCONNECTED;
> > -		if (type_mask & SND_JACK_MICROPHONE)
> > +		if (scodec->jack_type & SND_JACK_MICROPHONE)
> >  			sun8i_codec_set_hmic_bias(scodec, false);
> >  
> > -		snd_soc_jack_report(scodec->jack, 0, type_mask);
> > +		snd_soc_jack_report(scodec->jack, 0, scodec->jack_type);
> >  	}
> >  }
> >  
> > @@ -1491,7 +1491,7 @@ static irqreturn_t sun8i_codec_jack_irq(int irq, void *dev_id)
> >  		if (scodec->jack_last_sample >= 0 &&
> >  		    scodec->jack_last_sample == value)
> >  			snd_soc_jack_report(scodec->jack, type,
> > -					    scodec->jack->jack->type);
> > +					    scodec->jack_type);
> >  
> >  		scodec->jack_last_sample = value;
> >  	}
> > 
> 
> 
> 
> 

