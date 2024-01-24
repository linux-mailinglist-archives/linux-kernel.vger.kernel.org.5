Return-Path: <linux-kernel+bounces-37068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D510E83AAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F62FB29448
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696AD77F1E;
	Wed, 24 Jan 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+R78qre"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1C977F0D;
	Wed, 24 Jan 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103098; cv=none; b=hgAbmOhUHGJJKC5m+DNnR/tjCjKTSw8KPYDaSxzRawWaunsEmSFcMPUtM7PnVy7M4Ksht4nmxeFZzdkVTaePn+FKw/f14mhLgQf3nLsFBMnS4jb3+WdegmDBfSGKmLNj+iIxkQRNanf1oDwyPBVnXrP3zqtVvnUMlUFTRHh+pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103098; c=relaxed/simple;
	bh=vTeFrkOg9VeXj0cMMVSOTlbnmK4O1Tdyk176shwolH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcBlkO40l9faC4axd3ER3HpeaV1AKCqjEbrF876OIhMd5sr+FvEy/xbw/eeCLYF3HbLu+CeyekMzZmPIH6e6bZtfenXpQjoT1s1TMjVOtoMmMHgrHaegi4MSxxsgxyFi3ndO4O7fqrPrkoFECDmjqGK2jiJgf2pJz5bfwaASAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+R78qre; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cf108f6a2dso21443861fa.3;
        Wed, 24 Jan 2024 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706103095; x=1706707895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yh0FSpthPEg0z6Y9MyFNxP4OPN7yLXd22973nZlpFgs=;
        b=Q+R78qrezgwnW1kOUcm2wn7EiSCIWzueEdRGt945JDCNif07NgXY0nHXDYtN1y6LDi
         FjE5/tzIL0ssxcZAGfgqLsUfXGrmiaO/hEJ952oB8tLFDhz8BYDiHL0W8N6ZOYBjKBdO
         pJUN3u5qZyqtQ2mA5s8xknvzsh22Bx1UzJ89oQO9rq8sMk9PVNDy3f3KUssDlDoWyyJq
         CqTTwpqrkrnm6aEDOjCLiw3/7UNnUNg8s6eKbguuqp7GDCmxfhKaVsdKt4AoNGth6XmM
         1+1HtpdCoPbtVQ6fFlIzrooCPnDCIIokoZ9URrKonYsEEisieb9lFQDxfvwEyBlfd+RH
         19Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706103095; x=1706707895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh0FSpthPEg0z6Y9MyFNxP4OPN7yLXd22973nZlpFgs=;
        b=DfwGQqqeJJ4IdnBXXWGalx5zd9vLXLde5UNVkVVNYNdf410J7EP/E1cy3ianFi8gdf
         SQ6qfB5BW26f3PYQMBJgLmqH5kbJqe19EKH3bNrTcVzIn/O8FpYU00nSr9x9gTJ1NUGd
         Yc7ndnNqOZa4civSXAxPJ0JBOlHFNMG7xYpp6pWcbwQwnvZvEajEgnIwgYUg419KFlg6
         r/Hqq0mnO3Y1uU74sCv2KMSTImrrvSVYvDRoN0dMu+98jUFY/gcueSsK9vm3T7oySERq
         7cTdUoWSjPnB5W5FvhhQJhkMM4thV1bs9bEp8n+zeUzFED+OSWt2KKRBLUZ3RtxBLAWc
         X09w==
X-Gm-Message-State: AOJu0Yy4iRut40HflRnp7rrZBxcFfhv6iWLV+zKwQ3+T18R5M4llNj/c
	qiEPfcX9jI/7ZF+Ca/IfmTVLR4IflAsbaGN80v0PjNDgWMZLuDks
X-Google-Smtp-Source: AGHT+IEQ/+uLqbt+Yrb1ZZ6gaA4VtLtXFNiOrQMfZBodzHf8/XDgyTVyYYUU7vCAj5wx35icDs5adg==
X-Received: by 2002:a2e:8691:0:b0:2cc:7157:4e7f with SMTP id l17-20020a2e8691000000b002cc71574e7fmr726122lji.57.1706103094620;
        Wed, 24 Jan 2024 05:31:34 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k4-20020a2ea284000000b002cca7ee7375sm2555389lja.136.2024.01.24.05.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:31:33 -0800 (PST)
Date: Wed, 24 Jan 2024 16:31:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH net v3] net: stmmac: Wait a bit for the reset to take
 effect
Message-ID: <ddwtgxbtzy6vtc2bn5gvuskpco7mhmsmakt4gqk6ksppkmmtp2@w7eti3prlpke>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <AS8P193MB1285A810BD78C111E7F6AA34E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285A810BD78C111E7F6AA34E4752@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>

On Mon, Jan 22, 2024 at 07:19:09PM +0100, Bernd Edlinger wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.
> 
> Add a wait for 10 us before continuing to be on the safe side.
> 
> > From what have you got that delay value?
> 
> Just try and error, with very old linux versions and old gcc versions
> the synopsys_id was read out correctly most of the time (but not always),
> with recent linux versions and recnet gcc versions it was read out
> wrongly most of the time, but again not always.
> I don't have access to the VHDL code in question, so I cannot
> tell why it takes so long to get the correct values, I also do not
> have more than a few hardware samples, so I cannot tell how long
> this timeout must be in worst case.
> Experimentally I can tell that the register is read several times
> as zero immediately after the reset is de-asserted, also adding several
> no-ops is not enough, adding a printk is enough, also udelay(1) seems to
> be enough but I tried that not very often, and I have not access to many
> hardware samples to be 100% sure about the necessary delay.
> And since the udelay here is only executed once per device instance,
> it seems acceptable to delay the boot for 10 us.
> 
> BTW: my hardware's synopsys id is 0x37.
> 
> Fixes: c5e4ddbdfa11 ("net: stmmac: Add support for optional reset control")
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks for taking all the notes into account. No objections from my
side:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> v2: rebased to v6.7, retested and updated the commit message
> as suggested Serge Semins review comment:
> https://lore.kernel.org/lkml/b4mpa62b2juln47374x6xxnbozb7fcfgztrc5ounk4tvscs3wg@mixnvsoqno7j/
> and retained Jiri Pirkos Reviwed-by from:
> https://lore.kernel.org/lkml/ZT+Zq4j9iQj1+Xai@nanopsycho/
> 
> v3: addressed review comments.
> 
> 
> Thanks
> Bernd.
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a0e46369ae15..b334eb16da23 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7542,6 +7542,9 @@ int stmmac_dvr_probe(struct device *device,
>  		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
>  			ERR_PTR(ret));
>  
> +	/* Wait a bit for the reset to take effect */
> +	udelay(10);
> +
>  	/* Init MAC and get the capabilities */
>  	ret = stmmac_hw_init(priv);
>  	if (ret)
> -- 
> 2.39.2

