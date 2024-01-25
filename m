Return-Path: <linux-kernel+bounces-38685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FE83C418
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1661C22C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562E35B5D5;
	Thu, 25 Jan 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9rcO6IE"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0485B1F9;
	Thu, 25 Jan 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190585; cv=none; b=mTtUmQQngsxsp73zG7k0Q924I4aj313xjKc+QRMpe+SiGp6fmZ2SSlNgJGld5ez3n0mTjXBck/LzMfdrNTTmQwV6jVneUq56E8GTDbvq5IjzNAIxhlfg4OeoXXwRkLAR3e79TEfFuhEyDb5k4+KiEBQg3ZDpOg9lLiXkXv0klqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190585; c=relaxed/simple;
	bh=yGNOmnDJxlEoKfmzz9bPYdG5B6zwyOq3WC6O45Ufx+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nskUNkQsWEuYDGza4R7QU5BOrFQ/A6enmoLzQglR/b0tEIaErhfFgso3hX3DnbmkpCZkMStFpWR4a0ARu8uCzlYt6TRGYTXSGAp7V8WFP91WCXfqZweCMHdgYlPv/heDEsdxbgISj3S32QWwnSxvQRfScYGPwDDhIriU9Q/lmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9rcO6IE; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21424f34003so2306369fac.1;
        Thu, 25 Jan 2024 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706190582; x=1706795382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5zLmz5limB5T/RaXHxI3PBpBEFhJR8fb52PyOjDet0=;
        b=d9rcO6IE35YU2EcPTmLR+CV1g7dMC7hA4NvPo3UK7H3G95q2DQAUDxy0EVNvlb/5gK
         xfvxQtgSEdEz/0hhJWU657diM+E21jJJ6tfG44ZzPJI/oOrR4DBEG7EAPq03+5yHafZU
         iEwxioSKBszCBxBSulB8LaycZEUPONXfZAtDyifHld0EKIT2Mjv8DoWwp7/1UK7comRu
         T64kjcOn9XrL6jAvdB/0Lu2p+iHDoCQfmGafSd6SL3rkOxXU9DE+Oxm5NAxdnjwWsLZq
         9D5cAYdGFI8eaqvUUuQp5T0aYUbGS9JldqzTYcca2QcRlC3QXaKLTEqy0QNQfMWrBwY6
         mtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706190582; x=1706795382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5zLmz5limB5T/RaXHxI3PBpBEFhJR8fb52PyOjDet0=;
        b=KdFF8mpnV14s7PCZIis2VvBWkdSTbKUP7rAFV3+ZToUJv7KPN16NdPk5RrwTzHgFFq
         DI0yYMrCU1MQ97ObkybP1MP3cN9sglc6gwFOUn3iLWpCHeeyeovW3EbbjN0/TJp8HD+5
         c5zsWRu+/REywk6IJDMD3pt2rweteXOEYvzvDHJaypb9eie5vSs7SICYv3pGGVpA2Hsf
         V+uggW6j2zwzFllSKiAXgRdioDpKxuCp9W0ULdvyXUrG6uih4XN+QiuJ+GQPW41u2K6R
         3DAZnrAiqz5ffEjuHjH2yTpt9MvyYlqxqujLo1aZMusbB6PkKr0lzTliLWaYz1eFz7XX
         uHmA==
X-Gm-Message-State: AOJu0Yx0OYluJ0h5S1G1e1Yiqqw3vOhp2LE8lbMdOd7q/CD/z9h49mej
	kCmMPjeP4P5qSRRuNQee2aJxGvuKQr31TkQ+KDi2P/TsguYXMJVm
X-Google-Smtp-Source: AGHT+IGdl/wWokm3TKWEqUJl+/NlvONfIicnWU6Edqz8orp0V65hIqEqiIFlnc0gJhz1xq2CA886tQ==
X-Received: by 2002:a05:6871:7994:b0:210:aec0:e8ed with SMTP id pb20-20020a056871799400b00210aec0e8edmr967948oac.73.1706190581456;
        Thu, 25 Jan 2024 05:49:41 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id br24-20020a05622a1e1800b0042a6e6792basm273066qtb.69.2024.01.25.05.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:49:40 -0800 (PST)
Date: Thu, 25 Jan 2024 16:49:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net] net: stmmac: xgmac: fix safety error descriptions
Message-ID: <fv2hz76ypsbuhdyahb5ib5l434brqzjlu3tbtg6h3mcekoay5c@lb4aeuddo3tl>
References: <20240123085037.939471-1-0x1207@gmail.com>
 <ii3muj3nmhuo6s5hm3g7wuiubtyzr632klrcesubtuaoyifogb@ohmunpxvdtsv>
 <20240125103454.0000312a@gmail.com>
 <4coefc2fqtc2eoereds3rf7vudci5l7ahme2wydocjepk2wrwy@ncgwl3j3koyu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yzsxdcglf65ip2ra"
Content-Disposition: inline
In-Reply-To: <4coefc2fqtc2eoereds3rf7vudci5l7ahme2wydocjepk2wrwy@ncgwl3j3koyu>


--yzsxdcglf65ip2ra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 04:48:27PM +0300, Serge Semin wrote:
> On Thu, Jan 25, 2024 at 10:34:54AM +0800, Furong Xu wrote:
> > On Wed, 24 Jan 2024 17:25:27 +0300
> > Serge Semin <fancer.lancer@gmail.com> wrote:
> > 
> > > On Tue, Jan 23, 2024 at 04:50:37PM +0800, Furong Xu wrote:
> > > > Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> > > > XGMAC core") prints safety error descriptions when safety error assert,
> > > > but missed some special errors, and mixed correctable errors and
> > > > uncorrectable errors together.
> > > > This patch complete the error code list and print the type of errors.  
> > > 
> > > The XGMAC ECC Safety code has likely been just copied from the DW GMAC
> > > v5 (DW QoS Eth) part. So this change is partly relevant to that code too. I
> > > can't confirm that the special errors support is relevant to the DW
> > > QoS Eth too (it likely is though), so what about splitting this patch
> > > up into two:
> > > 1. Elaborate the errors description for DW GMAC v5 and DW XGMAC.
> > > 2. Add new ECC safety errors support.
> > > ?
> > > 
> > > On the other hand if we were sure that both DW QoS Eth and XGMAC
> > > safety features implementation match the ideal solution would be to
> > > refactor out the common code into a dedicated module.
> > > 
> > > -Serge(y)
> > > 
> > 
> 
> > Checked XGMAC Version 3.20a and DW QoS Eth Version 5.20a, the safety error
> > code definitions are not identical at all, they do have some differences,
> > about more than 20 bits of status register are different.
> > I think we should just leave them in individual implementations.
> 
> For some reason you answered to the last part of my comment and
> completely ignored the first part which was the main point of my
> message.
> 
> Regarding the Safety Feature support implemented in QoS Eth and XGMAC
> STMMAC modules. You were wrong in using the statement "at all". Except
> the optional events enable/disable procedure introduced in the commit
> 5ac712dcdfef ("net: stmmac: enable platform specific safety
> features"), there aren't many differences: at least the errors
> handling and report are identical, MTL and DMA error flags match, even
> MTL and DMA ECC/Safety IRQ flags match. The only difference is in the
> MTL/MAC DPP (Data Parity Protection) part which can be easily factored
> out based on the device ID should we attempt to refactor the safety
> feature code. See the attached html-diff for more details of what
> match and what is different.

Grrr, forgot to attach the html-file...

-Serge(y)

> 
> Anyway I am not insisting on the refactoring. That was just a
> proposal, a more preferred alternative to simultaneously patching two
> parts of the drivers looking very much alike. Such refactoring would
> improve the code maintainability. The main point of my comment was to
> extend your patch for DW QoS Eth safety feature implementation too
> since some of the changes you introduced were useful for it too, and
> in splitting the patch up since your patch added new flags support
> which was unrelated change.  Thus your patch would turned into the
> two-patches patchset like this:
> [Patch 1] would provide an elaborated errors description for both DW
> QOS Eth (GMAC v5.x) and DW XGMAC.
> [Patch 2] would introduce the new ECC safety errors support.
> 
> See my further comments about the respective changes.
> 
> > 
> > > > 
> > > > Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> > > > Signed-off-by: Furong Xu <0x1207@gmail.com>
> > > > ---
> > > >  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 36 +++++++++----------
> > > >  1 file changed, 18 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > index eb48211d9b0e..ad812484059e 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > > > @@ -748,29 +748,29 @@ static void dwxgmac3_handle_mac_err(struct net_device *ndev,
> > > >  }
> > > >  
> > > >  static const struct dwxgmac3_error_desc dwxgmac3_mtl_errors[32]= {
> 
> > > > -	{ true, "TXCES", "MTL TX Memory Error" },
> > > > +	{ true, "TXCES", "MTL TX Memory Correctable Error" },
> 
> Applicable for both IP-cores
> [Patch 1] +QoS, +XGMAC
> please apply this change to dwmac5.c too.
> 
> > > >  	{ true, "TXAMS", "MTL TX Memory Address Mismatch Error" },
> 
> > > > -	{ true, "TXUES", "MTL TX Memory Error" },
> > > > +	{ true, "TXUES", "MTL TX Memory Uncorrectable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> 
> > > > -	{ true, "RXCES", "MTL RX Memory Error" },
> > > > +	{ true, "RXCES", "MTL RX Memory Correctable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "RXAMS", "MTL RX Memory Address Mismatch Error" },
> 
> > > > -	{ true, "RXUES", "MTL RX Memory Error" },
> > > > +	{ true, "RXUES", "MTL RX Memory Uncorrectable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> 
> > > > -	{ true, "ECES", "MTL EST Memory Error" },
> > > > +	{ true, "ECES", "MTL EST Memory Correctable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "EAMS", "MTL EST Memory Address Mismatch Error" },
> 
> > > > -	{ true, "EUES", "MTL EST Memory Error" },
> > > > +	{ true, "EUES", "MTL EST Memory Uncorrectable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 11 */
> 
> > > > -	{ true, "RPCES", "MTL RX Parser Memory Error" },
> > > > +	{ true, "RPCES", "MTL RX Parser Memory Correctable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ true, "RPAMS", "MTL RX Parser Memory Address Mismatch Error" },
> 
> > > > -	{ true, "RPUES", "MTL RX Parser Memory Error" },
> > > > +	{ true, "RPUES", "MTL RX Parser Memory Uncorrectable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 15 */
> 
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 16 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 17 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 18 */
> > > > +	{ true, "SCES", "MTL SGF GCL Memory Correctable Error" },
> > > > +	{ true, "SAMS", "MTL SGF GCL Memory Address Mismatch Error" },
> > > > +	{ true, "SUES", "MTL SGF GCL Memory Uncorrectable Error" },
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 19 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 20 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 21 */
> > > > -	{ false, "UNKNOWN", "Unknown Error" }, /* 22 */
> > > > +	{ true, "RXFCES", "MTL RXF Memory Correctable Error" },
> > > > +	{ true, "RXFAMS", "MTL RXF Memory Address Mismatch Error" },
> > > > +	{ true, "RXFUES", "MTL RXF Memory Uncorrectable Error" },
> 
> This introduces the new flags support. Please move this change into a
> separate patch (Patch 2):
> [Patch 2] +XGMAC only.
> 
> My DW QoS Eth v5.10a databook doesn't have these flags defined. If
> your 5.20a HW-manual have them described then please add them for DW
> QoS Eth too.
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 23 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 24 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 25 */
> > > > @@ -796,13 +796,13 @@ static void dwxgmac3_handle_mtl_err(struct net_device *ndev,
> > > >  }
> > > >  
> > > >  static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
> 
> > > > -	{ true, "TCES", "DMA TSO Memory Error" },
> > > > +	{ true, "TCES", "DMA TSO Memory Correctable Error" },
> 
> Applicable for both IP-cores
> [Patch 1] +QoS, +XGMAC
> please apply this change to dwmac5.c too.
> 
> > > >  	{ true, "TAMS", "DMA TSO Memory Address Mismatch Error" },
> 
> > > > -	{ true, "TUES", "DMA TSO Memory Error" },
> > > > +	{ true, "TUES", "DMA TSO Memory Uncorrectable Error" },
> 
> [Patch 1] +QoS, +XGMAC
> ditto
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 3 */
> 
> > > > -	{ true, "DCES", "DMA DCACHE Memory Error" },
> > > > +	{ true, "DCES", "DMA DCACHE Memory Correctable Error" },
> > > >  	{ true, "DAMS", "DMA DCACHE Address Mismatch Error" },
> > > > -	{ true, "DUES", "DMA DCACHE Memory Error" },
> > > > +	{ true, "DUES", "DMA DCACHE Memory Uncorrectable Error" },
> 
> AFAICS applicable for XGMAC only
> [Patch 1] +XGMAC only.
> Once again, My DW QoS Eth v5.10a databook doesn't have these flags
> defined. So if your DW QoS Eth 5.20a HW-manual do have them described
> please add them for DW QoS Eth with the elaborated description in the
> framework of the Patch 2.
> 
> -Serge(y)
> 
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 7 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 8 */
> > > >  	{ false, "UNKNOWN", "Unknown Error" }, /* 9 */
> > > > -- 
> > > > 2.34.1
> > > > 
> > > >   
> > 

--yzsxdcglf65ip2ra
Content-Type: text/html; charset=us-ascii
Content-Disposition: attachment; filename="sfty.html"

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>diff</title>
<meta name="Generator" content="Vim/9.0">
<meta name="plugin-version" content="vim9.0_v2">
<meta name="settings" content="whole_filler,use_css,no_foldcolumn,prevent_copy=,use_input_for_pc=none">
<meta name="colorscheme" content="none">
<style>
<!--
pre { font-family: monospace; color: #ffffff; background-color: #000000; }
body { font-family: monospace; color: #ffffff; background-color: #000000; }
* { font-size: 1em; }
Folded { color: #00ffff; background-color: #808080; padding-bottom: 1px; font-weight: bold; }
PreProc { color: #8080ff; font-weight: bold; }
Type { color: #00ff00; font-weight: bold; }
Statement { color: #ffff00; font-weight: bold; }
Comment { color: #00ffff; font-weight: bold; }
Constant { color: #ff40ff; font-weight: bold; }
DiffText { background-color: #ff6060; padding-bottom: 1px; font-weight: bold; }
DiffAdd { background-color: #8080ff; padding-bottom: 1px; }
DiffChange { background-color: #ff40ff; padding-bottom: 1px; }
DiffDelete { color: #8080ff; background-color: #00ffff; padding-bottom: 1px; font-weight: bold; }
-->
<!--
table { table-layout: fixed; }
html, body, table, tbody { width: 100%; margin: 0; padding: 0; }
table, td, th { border: 1px solid; }
td { vertical-align: top; }
th, td { width: 50.0%; }
td div { overflow: auto; }
-->
</style>
</head>
<body>
<table id='vimCodeElement'>
<tr>
<th>drivers/net/ethernet/stmicro/stmmac/dwmac5_sfty.c</th>
<th>drivers/net/ethernet/stmicro/stmmac/dwxgmac2_sfty.c</th>
</tr><tr>
<td><div>
<pre>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MAC_DPP_FSM_INT_STATUS		</span><span class="Constant DiffText">0x0000014</span><span class="Constant DiffChange">0</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MAC_FSM_CONTROL			</span><span class="Constant DiffText">0x0000014</span><span class="Constant DiffChange">8</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MTL_ECC_CONTROL			</span><span class="Constant DiffText">0x00000c</span><span class="Constant DiffChange">c0</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffText">#define MEEAO				BIT(</span><span class="Constant DiffText">8</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define TSOEE				BIT(</span><span class="Constant DiffText">4</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define MRXPEE				BIT(</span><span class="Constant DiffText">3</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define MESTEE				BIT(</span><span class="Constant DiffText">2</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define MRXEE				BIT(</span><span class="Constant DiffText">1</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define MTXEE				BIT(</span><span class="Constant DiffText">0</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MTL_SAFETY_INT_STATUS		</span><span class="Constant DiffText">0x00000c</span><span class="Constant DiffChange">c4</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffText">#define MCSIS				BIT(</span><span class="Constant DiffText">31</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MEUIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">1</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MECIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MTL_ECC_INT_ENABLE		</span><span class="Constant DiffText">0x00000c</span><span class="Constant DiffChange">c8</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">RPCEIE	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">12</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">ECEIE	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">8</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">RXCEIE	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">4</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">TXCEIE	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MTL_ECC_INT_STATUS		</span><span class="Constant DiffText">0x00000c</span><span class="Constant DiffChange">cc</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffText">#define MTL_DPP_CONTROL			</span><span class="Constant DiffText">0x00000ce0</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffText">#define EPSI				BIT(</span><span class="Constant DiffText">2</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define OPE				BIT(</span><span class="Constant DiffText">1</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffText">#define EDPP				BIT(</span><span class="Constant DiffText">0</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">DMA_SAFETY_INT_STATUS		</span><span class="Constant DiffText">0x00001080</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MSUIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">29</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">MSCIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">28</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">DEUIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">1</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">DECIS	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">DMA_ECC_INT_ENABLE		</span><span class="Constant DiffText">0x00001084</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">TCEIE	</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">DMA_ECC_INT_STATUS		</span><span class="Constant DiffText">0x00001088</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_error_desc {                                                                                                                                                 </span>
	<span class="Type">bool</span> valid;
	<span class="Type">const</span> <span class="Type">char</span> *desc;
	<span class="Type">const</span> <span class="Type">char</span> *detailed_desc;
};

<span class="PreProc">#define STAT_OFF(field)		offsetof(</span><span class="Type">struct</span><span class="PreProc"> stmmac_safety_stats, field)</span>

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_log_error(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev, u32 value, </span><span class="Type DiffChange">bool</span><span class="DiffChange"> corr,                                                                                                </span>
			       <span class="Type">const</span> <span class="Type">char</span> *module_name,
<span class="DiffChange">			       </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_error_desc *desc,                                                                                                       </span>
			       <span class="Type">unsigned</span> <span class="Type">long</span> field_offset,
			       <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	<span class="Type">unsigned</span> <span class="Type">long</span> loc, mask;
	u8 *bptr = (u8 *)stats;
	<span class="Type">unsigned</span> <span class="Type">long</span> *ptr;
<span class="Folded">+--  8 lines: ptr = (unsigned long *)(bptr + field_offset);----------------------------------------------------------------------------------------------------------------</span>

		<span class="Comment">/*</span><span class="Comment"> Update counters </span><span class="Comment">*/</span>
		ptr[loc]++;
	}
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5_error_desc dwmac5</span><span class="DiffChange">_mac_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                             </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATPES&quot;</span>, <span class="Constant">&quot;Application Transmit Interface Parity Check Error&quot;</span> },
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TPES&quot;</span>, <span class="Constant">&quot;TSO Data Path Parity Check Error&quot;</span> },
<span class="DiffChange">	{ </span><span class="Constant DiffChange">true</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;</span><span class="Constant DiffText">RDPES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Read Descriptor</span><span class="Constant DiffChange"> Parity Check Error&quot;</span><span class="DiffChange"> },                                                                                                           </span>
<span class="DiffChange">	{ </span><span class="Constant DiffChange">true</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;MPES&quot;</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;MTL Data Path Parity Check Error&quot;</span><span class="DiffChange"> },                                                                                                              </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;MTSPES&quot;</span>, <span class="Constant">&quot;MTL TX Status Data Path Parity Check Error&quot;</span> },
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ARPES&quot;</span>, <span class="Constant">&quot;Application Receive Interface Data Path Parity Check Error&quot;</span> },
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;CWPES&quot;</span>, <span class="Constant">&quot;CSR Write Data Path Parity Check Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ASRPES&quot;</span>, <span class="Constant">&quot;AXI Slave Read Data Path Parity Check Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TTES&quot;</span>, <span class="Constant">&quot;TX FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RTES&quot;</span>, <span class="Constant">&quot;RX FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;CTES&quot;</span>, <span class="Constant">&quot;CSR FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATES&quot;</span>, <span class="Constant">&quot;APP FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;PTES&quot;</span>, <span class="Constant">&quot;PTP FSM Timeout Error&quot;</span> },
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;T125ES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;TX125 FSM Timeout Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                                     </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;R125ES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;RX125 FSM Timeout Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                                     </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;RVCTES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;REV MDC FSM Timeout Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                                   </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;MSTTES&quot;</span>, <span class="Constant">&quot;Master Read/Write Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;SLVTES&quot;</span>, <span class="Constant">&quot;Slave Read/Write Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATITES&quot;</span>, <span class="Constant">&quot;Application Timeout on ATI Interface Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ARITES&quot;</span>, <span class="Constant">&quot;Application Timeout on ARI Interface Error&quot;</span> },
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">false</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;UNKNOWN&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Unknown Error&quot;</span><span class="DiffAdd"> }, </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 20 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                    </span>
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">false</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;UNKNOWN&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Unknown Error&quot;</span><span class="DiffAdd"> }, </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 21 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                    </span>
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">false</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;UNKNOWN&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Unknown Error&quot;</span><span class="DiffAdd"> }, </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 22 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                    </span>
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">false</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;UNKNOWN&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Unknown Error&quot;</span><span class="DiffAdd"> }, </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 23 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                    </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;FSMPES&quot;</span>, <span class="Constant">&quot;FSM State Parity Error&quot;</span> },
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">false</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;UNKNOWN&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Unknown Error&quot;</span><span class="DiffAdd"> }, </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 25 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                    </span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 26 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 27 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 31 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                    </span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_mac_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                                 </span>
				    <span class="Type">void</span> __iomem *ioaddr, <span class="Type">bool</span> correctable,
				    <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + MAC_DPP_FSM_INT_STATUS);</span><span class="DiffChange">                                                                                                                    </span>
<span class="DiffChange">	writel(value, ioaddr + MAC_DPP_FSM_INT_STATUS);</span><span class="DiffChange">                                                                                                                    </span>

<span class="DiffChange">	dw</span><span class="DiffText">mac5_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;MAC&quot;</span><span class="DiffText">, dwmac5</span><span class="DiffChange">_mac_errors,                                                                                               </span>
<span class="DiffChange">			STAT_OFF(mac_errors), stats);</span><span class="DiffChange">                                                                                                                      </span>
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5_error_desc dwmac5</span><span class="DiffChange">_mtl_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                             </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXCES&quot;</span>, <span class="Constant">&quot;MTL TX Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXAMS&quot;</span>, <span class="Constant">&quot;MTL TX Memory Address Mismatch Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXUES&quot;</span>, <span class="Constant">&quot;MTL TX Memory Error&quot;</span> },
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 3 </span><span class="Comment">*/</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RXCES&quot;</span>, <span class="Constant">&quot;MTL RX Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RXAMS&quot;</span>, <span class="Constant">&quot;MTL RX Memory Address Mismatch Error&quot;</span> },
<span class="Folded">+-- 22 lines: { true, &quot;RXUES&quot;, &quot;MTL RX Memory Error&quot; },--------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 31 </span><span class="Comment">*/</span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_mtl_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                                 </span>
				    <span class="Type">void</span> __iomem *ioaddr, <span class="Type">bool</span> correctable,
				    <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + MTL_ECC_INT_STATUS);</span><span class="DiffChange">                                                                                                                        </span>
<span class="DiffChange">	writel(value, ioaddr + MTL_ECC_INT_STATUS);</span><span class="DiffChange">                                                                                                                        </span>

<span class="DiffChange">	dw</span><span class="DiffText">mac5_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;MTL&quot;</span><span class="DiffText">, dwmac5_mtl_errors</span><span class="DiffChange">,                                                                                               </span>
<span class="DiffChange">			STAT_OFF(mtl_errors), stats);</span><span class="DiffChange">                                                                                                                      </span>
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5_error_desc dwmac5</span><span class="DiffChange">_dma_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                             </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TCES&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TAMS&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Address Mismatch Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TUES&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Error&quot;</span> },
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 3 </span><span class="Comment">*/</span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 4 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                     </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 5 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                     </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 6 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                     </span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 7 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 8 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 9 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 10 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 11 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 12 </span><span class="Comment">*/</span>
<span class="Folded">+-- 15 lines: { false, &quot;UNKNOWN&quot;, &quot;Unknown Error&quot; }, 13 -------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 31 </span><span class="Comment">*/</span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_dma_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                                 </span>
<span class="DiffChange">				  </span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr, </span><span class="Type DiffChange">bool</span><span class="DiffChange"> correctable,                                                                                                  </span>
<span class="DiffChange">				  </span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats)                                                                                                       </span>
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + DMA_ECC_INT_STATUS);</span><span class="DiffChange">                                                                                                                        </span>
<span class="DiffChange">	writel(value, ioaddr + DMA_ECC_INT_STATUS);</span><span class="DiffChange">                                                                                                                        </span>

<span class="DiffChange">	dw</span><span class="DiffText">mac5_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;DMA&quot;</span><span class="DiffText">, dwmac5</span><span class="DiffChange">_dma_errors,                                                                                               </span>
<span class="DiffChange">			STAT_OFF(dma_errors), stats);</span><span class="DiffChange">                                                                                                                      </span>
}

<span class="Type DiffText">int</span><span class="DiffText"> dwmac5</span><span class="DiffChange">_safety_feat_irq_status(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                                 </span>
<span class="DiffChange">				  </span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr,                                                                                                                    </span>
<span class="DiffChange">				  </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">int</span><span class="DiffChange"> asp,                                                                                                                        </span>
<span class="DiffChange">				  </span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats)                                                                                                       </span>
{
	<span class="Type">bool</span> err, corr;
	u32 mtl, dma;
	<span class="Type">int</span> ret = <span class="Constant">0</span>;

	<span class="Statement">if</span> (!asp)
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;

<span class="DiffChange">	mtl = readl(ioaddr + MTL_SAFETY_INT_STATUS);</span><span class="DiffChange">                                                                                                                       </span>
<span class="DiffChange">	dma = readl(ioaddr + DMA_SAFETY_INT_STATUS);</span><span class="DiffChange">                                                                                                                       </span>

<span class="DiffChange">	err = (mtl &amp; </span><span class="DiffText">MCSIS) || (dma &amp; </span><span class="DiffChange">MCSIS);                                                                                                                              </span>
	corr = <span class="Constant">false</span>;
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_mac_err(ndev, ioaddr, corr, stats);                                                                                                          </span>
		ret |= !corr;
	}

<span class="DiffChange">	err = (mtl &amp; (</span><span class="DiffText">MEUIS | MECIS)) || (dma &amp; (MSUIS | </span><span class="DiffChange">MSCIS));                                                                                                          </span>
<span class="DiffChange">	corr = (mtl &amp; </span><span class="DiffText">MECIS) || (dma &amp; </span><span class="DiffChange">MSCIS);                                                                                                                             </span>
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_mtl_err(ndev, ioaddr, corr, stats);                                                                                                          </span>
		ret |= !corr;
	}

<span class="DiffChange">	err = dma &amp; (</span><span class="DiffText">DEUIS | </span><span class="DiffChange">DECIS);                                                                                                                                       </span>
<span class="DiffChange">	corr = dma &amp; DECIS;</span><span class="DiffChange">                                                                                                                                                </span>
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">mac5</span><span class="DiffChange">_handle_dma_err(ndev, ioaddr, corr, stats);                                                                                                          </span>
		ret |= !corr;
	}

	<span class="Statement">return</span> ret;
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_error {                                                                                                                                         </span>
<span class="DiffChange">	</span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">mac5</span><span class="DiffChange">_error_desc *desc;                                                                                                                              </span>
<span class="DiffChange">} dw</span><span class="DiffText">mac5</span><span class="DiffChange">_all_errors[] = {                                                                                                                                                  </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">mac5</span><span class="DiffChange">_mac_errors },                                                                                                                                             </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">mac5</span><span class="DiffChange">_mtl_errors },                                                                                                                                             </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">mac5</span><span class="DiffChange">_dma_errors },                                                                                                                                             </span>
};

<span class="Type DiffText">int</span><span class="DiffText"> dwmac5</span><span class="DiffChange">_safety_feat_dump(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats,                                                                                                             </span>
<span class="DiffChange">			    </span><span class="Type DiffChange">int</span><span class="DiffChange"> index, </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">long</span><span class="DiffChange"> *count,                                                                                                               </span>
<span class="DiffChange">			    </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">char</span><span class="DiffChange"> **desc)                                                                                                                             </span>
{
	<span class="Type">int</span> module = index / <span class="Constant">32</span>, offset = index % <span class="Constant">32</span>;
	<span class="Type">unsigned</span> <span class="Type">long</span> *ptr = (<span class="Type">unsigned</span> <span class="Type">long</span> *)stats;

<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (module &gt;= ARRAY_SIZE(dw</span><span class="DiffText">mac5</span><span class="DiffChange">_all_errors))                                                                                                                       </span>
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;
<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (!dw</span><span class="DiffText">mac5</span><span class="DiffChange">_all_errors[module].desc[offset].valid)                                                                                                                 </span>
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;
	<span class="Statement">if</span> (count)
		*count = *(ptr + index);
	<span class="Statement">if</span> (desc)
<span class="DiffChange">		*desc = dw</span><span class="DiffText">mac5</span><span class="DiffChange">_all_errors[module].desc[offset].desc;                                                                                                       </span>
	<span class="Statement">return</span> <span class="Constant">0</span>;
}

<span class="Type DiffText">int</span><span class="DiffText"> dwmac5</span><span class="DiffChange">_safety_feat_config(</span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr, </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">int</span><span class="DiffChange"> asp,                                                                                                      </span>
<span class="DiffChange">			</span><span class="DiffText">      </span><span class="Type DiffText">struct</span><span class="DiffText"> stmmac_safety_feature_cfg *safety_feat</span><span class="DiffChange">_cfg)                                                                                           </span>
{
<span class="DiffAdd">	</span><span class="Type DiffAdd">struct</span><span class="DiffAdd"> stmmac_safety_feature_cfg all_safety_feats = {                                                                                                              </span>
<span class="DiffAdd">		.tsoee = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                                </span>
<span class="DiffAdd">		.mrxpee = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                               </span>
<span class="DiffAdd">		.mestee = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                               </span>
<span class="DiffAdd">		.mrxee = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                                </span>
<span class="DiffAdd">		.mtxee = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                                </span>
<span class="DiffAdd">		.epsi = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                                 </span>
<span class="DiffAdd">		.edpp = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                                 </span>
<span class="DiffAdd">		.prtyen = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                               </span>
<span class="DiffAdd">		.tmouten = </span><span class="Constant DiffAdd">1</span><span class="DiffAdd">,                                                                                                                                              </span>
<span class="DiffAdd">	};</span><span class="DiffAdd">                                                                                                                                                                 </span>
	u32 value;

	<span class="Statement">if</span> (!asp)
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;

<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (!safety_feat_cfg)                                                                                                                                              </span>
<span class="DiffAdd">		safety_feat_cfg = &amp;all_safety_feats;</span><span class="DiffAdd">                                                                                                                       </span>
<span class="DiffAdd"> </span><span class="DiffAdd">                                                                                                                                                                          </span>
	<span class="Comment">/*</span><span class="Comment"> 1. Enable Safety Features </span><span class="Comment">*/</span>
<span class="DiffChange">	</span><span class="DiffText">value = readl(ioaddr + </span><span class="DiffChange">MTL_ECC_CONTROL);                                                                                                                           </span>
<span class="DiffAdd">	value |= MEEAO; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> MTL ECC Error Addr Status Override </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                           </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;tsoee)                                                                                                                                        </span>
<span class="DiffAdd">		value |= TSOEE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> TSO ECC </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                              </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;mrxpee)                                                                                                                                       </span>
<span class="DiffAdd">		value |= MRXPEE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> MTL RX Parser ECC </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                   </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;mestee)                                                                                                                                       </span>
<span class="DiffAdd">		value |= MESTEE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> MTL EST ECC </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                         </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;mrxee)                                                                                                                                        </span>
<span class="DiffAdd">		value |= MRXEE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> MTL RX FIFO ECC </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                      </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;mtxee)                                                                                                                                        </span>
<span class="DiffAdd">		value |= MTXEE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> MTL TX FIFO ECC </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                      </span>
<span class="DiffAdd">	writel(value, ioaddr + MTL_ECC_CONTROL);</span><span class="DiffAdd">                                                                                                                           </span>

	<span class="Comment">/*</span><span class="Comment"> 2. Enable MTL Safety Interrupts </span><span class="Comment">*/</span>
<span class="DiffChange">	value = readl(ioaddr + MTL_ECC_INT_ENABLE);</span><span class="DiffChange">                                                                                                                        </span>
<span class="DiffChange">	value |= RPCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> RX Parser Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                          </span>
<span class="DiffChange">	value |= ECEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> EST Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                 </span>
<span class="DiffChange">	value |= RXCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> RX Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                 </span>
<span class="DiffChange">	value |= TXCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> TX Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                 </span>
<span class="DiffChange">	writel(value, ioaddr + MTL_ECC_INT_ENABLE);</span><span class="DiffChange">                                                                                                                        </span>

	<span class="Comment">/*</span><span class="Comment"> 3. Enable DMA Safety Interrupts </span><span class="Comment">*/</span>
<span class="DiffChange">	value = readl(ioaddr + DMA_ECC_INT_ENABLE);</span><span class="DiffChange">                                                                                                                        </span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>

<span class="DiffChange">	value |= TCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> TSO Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                 </span>
<span class="DiffChange">	writel(value, ioaddr + DMA_ECC_INT_ENABLE);</span><span class="DiffChange">                                                                                                                        </span>


<span class="DiffChange">	</span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> </span><span class="Comment DiffText">Only ECC Protection for External Memory feature is selected</span><span class="DiffChange">                                                                                                     </span>
<span class="Comment DiffChange">	 *</span><span class="DiffChange">                                                                                                                                                                 </span>
<span class="Comment">	 </span><span class="Comment">*/</span>
<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (asp </span><span class="DiffText">&lt;= </span><span class="Constant DiffText">0x1</span><span class="DiffChange">)                                                                                                                                                    </span>
		<span class="Statement">return</span> <span class="Constant">0</span>;

<span class="DiffChange">	</span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> </span><span class="Comment DiffText">5</span><span class="Comment DiffChange">. Enable Parity and Timeout for FSM </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange">	value = readl(ioaddr + MAC_FSM_CONTROL);</span><span class="DiffChange">                                                                                                                           </span>
<span class="DiffText">	</span><span class="Statement DiffText">if</span><span class="DiffText"> (safety_feat_cfg-&gt;prtyen)</span><span class="DiffChange">                                                                                                                                       </span>
<span class="DiffChange">	</span><span class="DiffText">	value |= </span><span class="DiffChange">PRTYEN; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> FSM Parity Feature </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                  </span>
<span class="DiffText">	</span><span class="Statement DiffText">if</span><span class="DiffText"> (safety_feat_cfg-&gt;tmouten)</span><span class="DiffChange">                                                                                                                                      </span>
<span class="DiffChange">	</span><span class="DiffText">	value |= </span><span class="DiffChange">TMOUTEN; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> FSM Timeout Feature </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                </span>
<span class="DiffChange">	writel(value, ioaddr + MAC_FSM_CONTROL);</span><span class="DiffChange">                                                                                                                           </span>
<span class="DiffAdd"> </span><span class="DiffAdd">                                                                                                                                                                          </span>
<span class="DiffAdd">	</span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> 4. Enable Data Parity Protection </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                             </span>
<span class="DiffAdd">	value = readl(ioaddr + MTL_DPP_CONTROL);</span><span class="DiffAdd">                                                                                                                           </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;edpp)                                                                                                                                         </span>
<span class="DiffAdd">		value |= EDPP;</span><span class="DiffAdd">                                                                                                                                             </span>
<span class="DiffAdd">	writel(value, ioaddr + MTL_DPP_CONTROL);</span><span class="DiffAdd">                                                                                                                           </span>
<span class="DiffAdd"> </span><span class="DiffAdd">                                                                                                                                                                          </span>
<span class="DiffAdd">	</span><span class="Comment DiffAdd">/*</span><span class="DiffAdd">                                                                                                                                                                 </span>
<span class="Comment DiffAdd">	 * All the Automotive Safety features are selected without the &quot;Parity</span><span class="DiffAdd">                                                                                             </span>
<span class="Comment DiffAdd">	 * Port Enable for external interface&quot; feature.</span><span class="DiffAdd">                                                                                                                    </span>
<span class="Comment DiffAdd">	 </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                                                                                                </span>
<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (asp &lt;= </span><span class="Constant DiffAdd">0x2</span><span class="DiffAdd">)                                                                                                                                                    </span>
<span class="DiffAdd">		</span><span class="Statement DiffAdd">return</span><span class="DiffAdd"> </span><span class="Constant DiffAdd">0</span><span class="DiffAdd">;                                                                                                                                                  </span>

<span class="DiffAdd">	</span><span class="Statement DiffAdd">if</span><span class="DiffAdd"> (safety_feat_cfg-&gt;epsi)                                                                                                                                         </span>
<span class="DiffAdd">		value |= EPSI;</span><span class="DiffAdd">                                                                                                                                             </span>
<span class="DiffAdd">	writel(value, ioaddr + MTL_DPP_CONTROL);</span><span class="DiffAdd">                                                                                                                           </span>
	<span class="Statement">return</span> <span class="Constant">0</span>;
}
</pre>
</div></td>
<td><div>
<pre>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MAC_DPP_FSM_INT_STATUS	</span><span class="Constant DiffText">0x0000015</span><span class="Constant DiffChange">0</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MAC_FSM_CONTROL		</span><span class="Constant DiffText">0x0000015</span><span class="Constant DiffChange">8</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MTL_ECC_CONTROL		</span><span class="Constant DiffText">0x000010</span><span class="Constant DiffChange">c0</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MTL_SAFETY_INT_STATUS	</span><span class="Constant DiffText">0x000010</span><span class="Constant DiffChange">c4</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MEUIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">1</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MECIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MTL_ECC_INT_ENABLE	</span><span class="Constant DiffText">0x000010</span><span class="Constant DiffChange">c8</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_RPCEIE</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">12</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_ECEIE</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">8</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_RXCEIE</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">4</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_TXCEIE</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MTL_ECC_INT_STATUS	</span><span class="Constant DiffText">0x000010</span><span class="Constant DiffChange">cc</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_DMA_SAFETY_INT_STATUS	</span><span class="Constant DiffText">0x00003064</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffText">#define XGMAC_MCSIS			BIT(</span><span class="Constant DiffText">31</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MSUIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">29</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_MSCIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">28</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                            </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_DEUIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">1</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_DECIS</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_DMA_ECC_INT_ENABLE	</span><span class="Constant DiffText">0x00003068</span><span class="DiffChange">                                                                                                                         </span>
<span class="PreProc DiffText">#define XGMAC_DCEIE			BIT(</span><span class="Constant DiffText">1</span><span class="PreProc DiffText">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_TCEIE</span><span class="PreProc DiffChange">			BIT(</span><span class="Constant DiffChange">0</span><span class="PreProc DiffChange">)</span><span class="DiffChange">                                                                                                                             </span>
<span class="PreProc DiffChange">#define </span><span class="PreProc DiffText">XGMAC_DMA_ECC_INT_STATUS	</span><span class="Constant DiffText">0x0000306c</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_error_desc {                                                                                                                                               </span>
	<span class="Type">bool</span> valid;
	<span class="Type">const</span> <span class="Type">char</span> *desc;
	<span class="Type">const</span> <span class="Type">char</span> *detailed_desc;
};

<span class="PreProc">#define STAT_OFF(field)		offsetof(</span><span class="Type">struct</span><span class="PreProc"> stmmac_safety_stats, field)</span>

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_log_error(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev, u32 value, </span><span class="Type DiffChange">bool</span><span class="DiffChange"> corr,                                                                                              </span>
			       <span class="Type">const</span> <span class="Type">char</span> *module_name,
<span class="DiffChange">			       </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_error_desc *desc,                                                                                                     </span>
			       <span class="Type">unsigned</span> <span class="Type">long</span> field_offset,
			       <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	<span class="Type">unsigned</span> <span class="Type">long</span> loc, mask;
	u8 *bptr = (u8 *)stats;
	<span class="Type">unsigned</span> <span class="Type">long</span> *ptr;
<span class="Folded">+--  8 lines: ptr = (unsigned long *)(bptr + field_offset);----------------------------------------------------------------------------------------------------------------</span>

		<span class="Comment">/*</span><span class="Comment"> Update counters </span><span class="Comment">*/</span>
		ptr[loc]++;
	}
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3_error_desc dwxgmac3</span><span class="DiffChange">_mac_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                         </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATPES&quot;</span>, <span class="Constant">&quot;Application Transmit Interface Parity Check Error&quot;</span> },
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">true</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;DPES&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;Descriptor Cache Data Path Parity Check Error&quot;</span><span class="DiffAdd"> },                                                                                                 </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TPES&quot;</span>, <span class="Constant">&quot;TSO Data Path Parity Check Error&quot;</span> },
<span class="DiffChange">	{ </span><span class="Constant DiffChange">true</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;</span><span class="Constant DiffText">TSOPES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;TSO Header Data Path</span><span class="Constant DiffChange"> Parity Check Error&quot;</span><span class="DiffChange"> },                                                                                                     </span>
<span class="DiffChange">	{ </span><span class="Constant DiffChange">true</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;M</span><span class="Constant DiffText">T</span><span class="Constant DiffChange">PES&quot;</span><span class="DiffChange">, </span><span class="Constant DiffChange">&quot;MTL Data Path Parity Check Error&quot;</span><span class="DiffChange"> },                                                                                                             </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;MTSPES&quot;</span>, <span class="Constant">&quot;MTL TX Status Data Path Parity Check Error&quot;</span> },
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">true</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MTBUPES&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MAC TBU Data Path Parity Check Error&quot;</span><span class="DiffAdd"> },                                                                                                       </span>
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">true</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MTFCPES&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MAC TFC Data Path Parity Check Error&quot;</span><span class="DiffAdd"> },                                                                                                       </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ARPES&quot;</span>, <span class="Constant">&quot;Application Receive Interface Data Path Parity Check Error&quot;</span> },
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">true</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MRWCPES&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MTL RWC Data Path Parity Check Error&quot;</span><span class="DiffAdd"> },                                                                                                       </span>
<span class="DiffAdd">	{ </span><span class="Constant DiffAdd">true</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MRRCPES&quot;</span><span class="DiffAdd">, </span><span class="Constant DiffAdd">&quot;MTL RCC Data Path Parity Check Error&quot;</span><span class="DiffAdd"> },                                                                                                       </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;CWPES&quot;</span>, <span class="Constant">&quot;CSR Write Data Path Parity Check Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ASRPES&quot;</span>, <span class="Constant">&quot;AXI Slave Read Data Path Parity Check Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TTES&quot;</span>, <span class="Constant">&quot;TX FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RTES&quot;</span>, <span class="Constant">&quot;RX FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;CTES&quot;</span>, <span class="Constant">&quot;CSR FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATES&quot;</span>, <span class="Constant">&quot;APP FSM Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;PTES&quot;</span>, <span class="Constant">&quot;PTP FSM Timeout Error&quot;</span> },
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 18 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                    </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 19 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                    </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">false</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;UNKNOWN&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Unknown Error&quot;</span><span class="DiffText"> }, </span><span class="Comment DiffText">/*</span><span class="Comment DiffText"> 20 </span><span class="Comment DiffText">*/</span><span class="DiffChange">                                                                                                                    </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;MSTTES&quot;</span>, <span class="Constant">&quot;Master Read/Write Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;SLVTES&quot;</span>, <span class="Constant">&quot;Slave Read/Write Timeout Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ATITES&quot;</span>, <span class="Constant">&quot;Application Timeout on ATI Interface Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;ARITES&quot;</span>, <span class="Constant">&quot;Application Timeout on ARI Interface Error&quot;</span> },
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;FSMPES&quot;</span>, <span class="Constant">&quot;FSM State Parity Error&quot;</span> },
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 26 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 27 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;CPI&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;Control Register Parity Check Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                            </span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_mac_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                               </span>
				    <span class="Type">void</span> __iomem *ioaddr, <span class="Type">bool</span> correctable,
				    <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MAC_DPP_FSM_INT_STATUS);                                                                                                              </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MAC_DPP_FSM_INT_STATUS);                                                                                                              </span>

<span class="DiffChange">	dw</span><span class="DiffText">xgmac3_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;MAC&quot;</span><span class="DiffText">, dwxgmac3</span><span class="DiffChange">_mac_errors,                                                                                           </span>
<span class="DiffChange">			</span><span class="DiffText">   </span><span class="DiffChange">STAT_OFF(mac_errors), stats);                                                                                                                   </span>
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3_error_desc dwxgmac3</span><span class="DiffChange">_mtl_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                         </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXCES&quot;</span>, <span class="Constant">&quot;MTL TX Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXAMS&quot;</span>, <span class="Constant">&quot;MTL TX Memory Address Mismatch Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TXUES&quot;</span>, <span class="Constant">&quot;MTL TX Memory Error&quot;</span> },
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 3 </span><span class="Comment">*/</span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RXCES&quot;</span>, <span class="Constant">&quot;MTL RX Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;RXAMS&quot;</span>, <span class="Constant">&quot;MTL RX Memory Address Mismatch Error&quot;</span> },
<span class="Folded">+-- 22 lines: { true, &quot;RXUES&quot;, &quot;MTL RX Memory Error&quot; },--------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 31 </span><span class="Comment">*/</span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_mtl_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                               </span>
				    <span class="Type">void</span> __iomem *ioaddr, <span class="Type">bool</span> correctable,
				    <span class="Type">struct</span> stmmac_safety_stats *stats)
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MTL_ECC_INT_STATUS);                                                                                                                  </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MTL_ECC_INT_STATUS);                                                                                                                  </span>

<span class="DiffChange">	dw</span><span class="DiffText">xgmac3_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;MTL&quot;</span><span class="DiffChange">,                                                                                                                </span>
<span class="DiffChange">			</span><span class="DiffText">   dwxgmac3_mtl_errors, </span><span class="DiffChange">STAT_OFF(mtl_errors), stats);                                                                                              </span>
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3_error_desc dwxgmac3</span><span class="DiffChange">_dma_errors[</span><span class="Constant DiffChange">32</span><span class="DiffChange">]= {                                                                                                         </span>
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TCES&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TAMS&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Address Mismatch Error&quot;</span> },
	{ <span class="Constant">true</span>, <span class="Constant">&quot;TUES&quot;</span>, <span class="Constant">&quot;DMA TSO Memory Error&quot;</span> },
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 3 </span><span class="Comment">*/</span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DCES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DMA DCACHE Memory Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                                       </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DAMS&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DMA DCACHE Address Mismatch Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                             </span>
<span class="DiffChange">	{ </span><span class="Constant DiffText">true</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DUES&quot;</span><span class="DiffText">, </span><span class="Constant DiffText">&quot;DMA DCACHE Memory Error&quot;</span><span class="DiffText"> },</span><span class="DiffChange">                                                                                                                       </span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 7 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 8 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 9 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 10 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 11 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 12 </span><span class="Comment">*/</span>
<span class="Folded">+-- 15 lines: { false, &quot;UNKNOWN&quot;, &quot;Unknown Error&quot; }, 13 -------------------------------------------------------------------------------------------------------------------</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 28 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 29 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 30 </span><span class="Comment">*/</span>
	{ <span class="Constant">false</span>, <span class="Constant">&quot;UNKNOWN&quot;</span>, <span class="Constant">&quot;Unknown Error&quot;</span> }, <span class="Comment">/*</span><span class="Comment"> 31 </span><span class="Comment">*/</span>
};

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">void</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_dma_err(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                               </span>
<span class="DiffChange">				  </span><span class="DiffText">  </span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr, </span><span class="Type DiffChange">bool</span><span class="DiffChange"> correctable,                                                                                                </span>
<span class="DiffChange">				  </span><span class="DiffText">  </span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats)                                                                                                     </span>
{
	u32 value;

<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DMA_ECC_INT_STATUS);                                                                                                                  </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DMA_ECC_INT_STATUS);                                                                                                                  </span>

<span class="DiffChange">	dw</span><span class="DiffText">xgmac3_log_error(ndev, value, correctable, </span><span class="Constant DiffText">&quot;DMA&quot;</span><span class="DiffText">, dwxgmac3</span><span class="DiffChange">_dma_errors,                                                                                           </span>
<span class="DiffChange">			</span><span class="DiffText">   </span><span class="DiffChange">STAT_OFF(dma_errors), stats);                                                                                                                   </span>
}

<span class="Type DiffText">static</span><span class="DiffText"> </span><span class="Type DiffText">int</span><span class="DiffText"> dwxgmac3</span><span class="DiffChange">_safety_feat_irq_status(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> net_device *ndev,                                                                                                        </span>
<span class="DiffChange">				</span><span class="DiffText">	 </span><span class="DiffChange">  </span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr,                                                                                                           </span>
<span class="DiffChange">				</span><span class="DiffText">	 </span><span class="DiffChange">  </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">int</span><span class="DiffChange"> asp,                                                                                                               </span>
<span class="DiffChange">				</span><span class="DiffText">	 </span><span class="DiffChange">  </span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats)                                                                                              </span>
{
	<span class="Type">bool</span> err, corr;
	u32 mtl, dma;
	<span class="Type">int</span> ret = <span class="Constant">0</span>;

	<span class="Statement">if</span> (!asp)
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;

<span class="DiffChange">	mtl = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MTL_SAFETY_INT_STATUS);                                                                                                                 </span>
<span class="DiffChange">	dma = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DMA_SAFETY_INT_STATUS);                                                                                                                 </span>

<span class="DiffChange">	err = (mtl &amp; </span><span class="DiffText">XGMAC_MCSIS) || (dma &amp; XGMAC_</span><span class="DiffChange">MCSIS);                                                                                                                  </span>
	corr = <span class="Constant">false</span>;
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_mac_err(ndev, ioaddr, corr, stats);                                                                                                        </span>
		ret |= !corr;
	}

<span class="DiffChange">	err = (mtl &amp; (</span><span class="DiffText">XGMAC_MEUIS | XGMAC_MECIS)) || (dma &amp; (XGMAC_MSUIS | XGMAC_</span><span class="DiffChange">MSCIS));                                                                                  </span>
<span class="DiffChange">	corr = (mtl &amp; </span><span class="DiffText">XGMAC_MECIS) || (dma &amp; XGMAC_</span><span class="DiffChange">MSCIS);                                                                                                                 </span>
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_mtl_err(ndev, ioaddr, corr, stats);                                                                                                        </span>
		ret |= !corr;
	}

<span class="DiffChange">	err = dma &amp; (</span><span class="DiffText">XGMAC_DEUIS | XGMAC_</span><span class="DiffChange">DECIS);                                                                                                                           </span>
<span class="DiffChange">	corr = dma &amp; </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DECIS;                                                                                                                                          </span>
	<span class="Statement">if</span> (err) {
<span class="DiffChange">		dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_handle_dma_err(ndev, ioaddr, corr, stats);                                                                                                        </span>
		ret |= !corr;
	}

	<span class="Statement">return</span> ret;
}

<span class="Type DiffChange">static</span><span class="DiffChange"> </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_error {                                                                                                                                       </span>
<span class="DiffChange">	</span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">struct</span><span class="DiffChange"> dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_error_desc *desc;                                                                                                                            </span>
<span class="DiffChange">} dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_all_errors[] = {                                                                                                                                                </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_mac_errors },                                                                                                                                           </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_mtl_errors },                                                                                                                                           </span>
<span class="DiffChange">	{ dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_dma_errors },                                                                                                                                           </span>
};

<span class="Type DiffText">static</span><span class="DiffText"> </span><span class="Type DiffText">int</span><span class="DiffText"> dwxgmac3</span><span class="DiffChange">_safety_feat_dump(</span><span class="Type DiffChange">struct</span><span class="DiffChange"> stmmac_safety_stats *stats,                                                                                                    </span>
<span class="DiffChange">			</span><span class="DiffText">	 </span><span class="DiffChange">    </span><span class="Type DiffChange">int</span><span class="DiffChange"> index, </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">long</span><span class="DiffChange"> *count,                                                                                                      </span>
<span class="DiffChange">			</span><span class="DiffText">	 </span><span class="DiffChange">    </span><span class="Type DiffChange">const</span><span class="DiffChange"> </span><span class="Type DiffChange">char</span><span class="DiffChange"> **desc)                                                                                                                    </span>
{
	<span class="Type">int</span> module = index / <span class="Constant">32</span>, offset = index % <span class="Constant">32</span>;
	<span class="Type">unsigned</span> <span class="Type">long</span> *ptr = (<span class="Type">unsigned</span> <span class="Type">long</span> *)stats;

<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (module &gt;= ARRAY_SIZE(dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_all_errors))                                                                                                                     </span>
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;
<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (!dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_all_errors[module].desc[offset].valid)                                                                                                               </span>
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;
	<span class="Statement">if</span> (count)
		*count = *(ptr + index);
	<span class="Statement">if</span> (desc)
<span class="DiffChange">		*desc = dw</span><span class="DiffText">xgmac3</span><span class="DiffChange">_all_errors[module].desc[offset].desc;                                                                                                     </span>
	<span class="Statement">return</span> <span class="Constant">0</span>;
}

<span class="Type DiffText">static</span><span class="DiffText"> </span><span class="Type DiffText">int</span><span class="DiffText"> dwxgmac3</span><span class="DiffChange">_safety_feat_config(</span><span class="Type DiffChange">void</span><span class="DiffChange"> __iomem *ioaddr, </span><span class="Type DiffChange">unsigned</span><span class="DiffChange"> </span><span class="Type DiffChange">int</span><span class="DiffChange"> asp,                                                                                             </span>
<span class="DiffChange">			</span><span class="DiffText">	       </span><span class="Type DiffText">struct</span><span class="DiffText"> stmmac_safety_feature_cfg *safety</span><span class="DiffChange">_cfg)                                                                                       </span>
{
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	u32 value;

	<span class="Statement">if</span> (!asp)
		<span class="Statement">return</span> -<span class="Constant">EINVAL</span>;

<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	<span class="Comment">/*</span><span class="Comment"> 1. Enable Safety Features </span><span class="Comment">*/</span>
<span class="DiffChange">	</span><span class="DiffText">writel(</span><span class="Constant DiffText">0x0</span><span class="DiffText">, ioaddr + XGMAC_</span><span class="DiffChange">MTL_ECC_CONTROL);                                                                                                                       </span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>

	<span class="Comment">/*</span><span class="Comment"> 2. Enable MTL Safety Interrupts </span><span class="Comment">*/</span>
<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MTL_ECC_INT_ENABLE);                                                                                                                  </span>
<span class="DiffChange">	value |= </span><span class="DiffText">XGMAC_</span><span class="DiffChange">RPCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> RX Parser Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                    </span>
<span class="DiffChange">	value |= </span><span class="DiffText">XGMAC_</span><span class="DiffChange">ECEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> EST Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                           </span>
<span class="DiffChange">	value |= </span><span class="DiffText">XGMAC_</span><span class="DiffChange">RXCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> RX Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                           </span>
<span class="DiffChange">	value |= </span><span class="DiffText">XGMAC_</span><span class="DiffChange">TXCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> TX Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                           </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MTL_ECC_INT_ENABLE);                                                                                                                  </span>

	<span class="Comment">/*</span><span class="Comment"> 3. Enable DMA Safety Interrupts </span><span class="Comment">*/</span>
<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DMA_ECC_INT_ENABLE);                                                                                                                  </span>
<span class="DiffAdd">	value |= XGMAC_DCEIE; </span><span class="Comment DiffAdd">/*</span><span class="Comment DiffAdd"> Descriptor Cache Memory Correctable Error </span><span class="Comment DiffAdd">*/</span><span class="DiffAdd">                                                                                              </span>

<span class="DiffChange">	value |= </span><span class="DiffText">XGMAC_</span><span class="DiffChange">TCEIE; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> TSO Memory Correctable Error </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                           </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">DMA_ECC_INT_ENABLE);                                                                                                                  </span>


<span class="DiffChange">	</span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> </span><span class="Comment DiffText">0x2: Without ECC or Parity Ports on External Application Interface</span><span class="DiffChange">                                                                                              </span>
<span class="Comment DiffChange">	 *</span><span class="Comment DiffText"> 0x4: Only ECC Protection for External Memory feature is selected</span><span class="DiffChange">                                                                                                </span>
<span class="Comment">	 </span><span class="Comment">*/</span>
<span class="DiffChange">	</span><span class="Statement DiffChange">if</span><span class="DiffChange"> (asp </span><span class="DiffText">== </span><span class="Constant DiffText">0x2</span><span class="DiffText"> || asp == </span><span class="Constant DiffText">0x4</span><span class="DiffChange">)                                                                                                                                      </span>
		<span class="Statement">return</span> <span class="Constant">0</span>;

<span class="DiffChange">	</span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> </span><span class="Comment DiffText">4</span><span class="Comment DiffChange">. Enable Parity and Timeout for FSM </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                         </span>
<span class="DiffChange">	value = readl(ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MAC_FSM_CONTROL);                                                                                                                     </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange">	</span><span class="DiffText">value |= XGMAC_</span><span class="DiffChange">PRTYEN; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> FSM Parity Feature </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                    </span>
<span class="DiffChange"> </span><span class="DiffChange">                                                                                                                                                                          </span>
<span class="DiffChange">	</span><span class="DiffText">value |= XGMAC_</span><span class="DiffChange">TMOUTEN; </span><span class="Comment DiffChange">/*</span><span class="Comment DiffChange"> FSM Timeout Feature </span><span class="Comment DiffChange">*/</span><span class="DiffChange">                                                                                                                  </span>
<span class="DiffChange">	writel(value, ioaddr + </span><span class="DiffText">XGMAC_</span><span class="DiffChange">MAC_FSM_CONTROL);                                                                                                                     </span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>

<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
<span class="DiffDelete">---------------------------------------------------------------------------------------------------------------------------------------------------------------------------</span>
	<span class="Statement">return</span> <span class="Constant">0</span>;
}
</pre>
</div></td>
</tr>
</table>
</body>
</html>
<!-- vim: set foldmethod=manual : -->


--yzsxdcglf65ip2ra--

