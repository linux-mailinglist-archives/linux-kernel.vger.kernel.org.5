Return-Path: <linux-kernel+bounces-104500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E54787CEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE39F286C49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54301376FB;
	Fri, 15 Mar 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JT0oytOB"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9883FB09;
	Fri, 15 Mar 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512739; cv=none; b=G6TAcXxl8eG1JanRK8bCd6iJhPiFe0P5Isyahyl4nUjcUXui6xQWV42NI7eODBmIJZElRblfcIQDvuQ69qkLCR+LfWReWKnUhwi+N/M0rzatJXOWnKqVZE07ASqpcRGYA2MB3kENMngIvxuyRrRQ5brwgJBGcR2dcxLYXwjse9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512739; c=relaxed/simple;
	bh=J0t62LSPNxuLQ8sAlR7A5CJjOjk4klD5rEJ4FkcqdBw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skDvW86FH+Pz2n2v6XIi/1lJid28frvcfuJfvVpAzCopAKAVn6IToepmKB3ayuTfbY1v4tfCRusYrrbtX0cXvJfsC/Kpgj7HCuSjRM4HrektEwMpc4rkUJ3vTd3yW7BKZYJdBRafSWnwg++FB6hidDYQzdyrluAMfuyxuQgUgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JT0oytOB; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42FECB36029813;
	Fri, 15 Mar 2024 09:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=eqTBeVAurXibsXw
	108ThltF9NYSzH+Wv/Sjzq+Ilm38=; b=JT0oytOBaYyUGB+7yGFb5N+9897XESK
	pxIFgfl2gdhmSjrGzuTupIaKpVrQZe6rvYkfewuc48/ih4/wZDVRkATz5NBNXRH+
	8zQFyMvZ7JRlr5YWYSk07HcxSuVvod7spbW3LxM+dErHCgCrHNcEnNwKv6xUJkAR
	w8hu46m34z/b2Vkh4Tk2ru07qDrejrwWmnLoGq8Ej3GIefOFLOKAemFIElwk3WRE
	IziSxAbnO20pGgJ5LhOk0Pi9xMb5HwoA2sFuXJU1fzL/Pxu9PZtExIfHa8tZtB5p
	H1vxHUoXzHrTCZgvqe/JBUaX9D9FnRupLu1Tgs7FroCmtRlJ/3BTUJA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wv9xp8pwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 09:25:20 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 15 Mar
 2024 14:25:18 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Fri, 15 Mar 2024 14:25:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 385E382024B;
	Fri, 15 Mar 2024 14:25:18 +0000 (UTC)
Date: Fri, 15 Mar 2024 14:25:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
CC: Jai Luthra <j-luthra@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: dahlia: fix audio clock
Message-ID: <ZfRaTcDSSy+5zqeb@ediswmail9.ad.cirrus.com>
References: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315102500.18492-1-andrejs.cainikovs@gmail.com>
X-Proofpoint-ORIG-GUID: JZSfResCCk8C2VAuxk8LCH2kvc2Y0cnN
X-Proofpoint-GUID: JZSfResCCk8C2VAuxk8LCH2kvc2Y0cnN
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 15, 2024 at 11:25:00AM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> In current configuration, wm8904 codec on Dahlia carrier board provides
> distorted audio output. This happens due to reference clock is fixed to
> 25MHz and no FLL is enabled. During playback following parameters are set:
> 
> 44100Hz:
> 
> [  310.276924] wm8904 1-001a: Target BCLK is 1411200Hz
> [  310.276990] wm8904 1-001a: Using 25000000Hz MCLK
> [  310.277001] wm8904 1-001a: CLK_SYS is 12500000Hz
> [  310.277018] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [  310.277026] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> [  310.277034] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
> [  310.277044] wm8904 1-001a: LRCLK_RATE is 35
> 
> Deviation = 1411200 vs 1562500 = 10.721%
> Also, LRCLK_RATE is 35, should be 32.
> 
> 48000Hz:
> 
> [  302.449970] wm8904 1-001a: Target BCLK is 1536000Hz
> [  302.450037] wm8904 1-001a: Using 25000000Hz MCLK
> [  302.450049] wm8904 1-001a: CLK_SYS is 12500000Hz
> [  302.450065] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [  302.450074] wm8904 1-001a: Selected SAMPLE_RATE of 48000Hz
> [  302.450083] wm8904 1-001a: Selected BCLK_DIV of 80 for 1562500Hz BCLK
> [  302.450092] wm8904 1-001a: LRCLK_RATE is 32
> 
> Deviation = 1536000 vs 1562500 = 1.725%
> 
> Enabling wm8904 FLL via providing mclk-fs property to simple-audio-card
> configures clocks properly, but also adjusts audio reference clock
> (mclk), which in case of TI AM62 should be avoided, as it only
> supports 25MHz output [1][2].
> 
> This change enables FLL on wm8904 by providing mclk-fs, and drops
> audio reference clock out of DAI configuration, which prevents
> simple-audio-card to adjust it before every playback [3].
> 
> 41000Hz:
> 
> [  111.820533] wm8904 1-001a: FLL configured for 25000000Hz->11289600Hz
> [  111.820597] wm8904 1-001a: Clock source is 0 at 11289600Hz
> [  111.820651] wm8904 1-001a: Using 11289600Hz FLL clock
> [  111.820703] wm8904 1-001a: CLK_SYS is 11289600Hz
> [  111.820798] wm8904 1-001a: Target BCLK is 1411200Hz
> [  111.820847] wm8904 1-001a: Using 11289600Hz FLL clock
> [  111.820894] wm8904 1-001a: CLK_SYS is 11289600Hz
> [  111.820933] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [  111.820971] wm8904 1-001a: Selected SAMPLE_RATE of 44100Hz
> [  111.821009] wm8904 1-001a: Selected BCLK_DIV of 80 for 1411200Hz BCLK
> [  111.821051] wm8904 1-001a: LRCLK_RATE is 32
> 
> 48000Hz:
> 
> [  144.119254] wm8904 1-001a: FLL configured for 25000000Hz->12288000Hz
> [  144.119309] wm8904 1-001a: Clock source is 0 at 12288000Hz
> [  144.119364] wm8904 1-001a: Using 12288000Hz FLL clock
> [  144.119413] wm8904 1-001a: CLK_SYS is 12288000Hz
> [  144.119512] wm8904 1-001a: Target BCLK is 1536000Hz
> [  144.119561] wm8904 1-001a: Using 12288000Hz FLL clock
> [  144.119608] wm8904 1-001a: CLK_SYS is 12288000Hz
> [  144.119646] wm8904 1-001a: Selected CLK_SYS_RATIO of 256
> [  144.119685] wm8904 1-001a: Selected SAMPLE_RATE of 48000Hz
> [  144.119723] wm8904 1-001a: Selected BCLK_DIV of 80 for 1536000Hz BCLK
> [  144.119764] wm8904 1-001a: LRCLK_RATE is 32
> 
> [1]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1175479/processor-sdk-am62x-output-audio_ext_refclk0-as-mclk-for-codec-and-mcbsp/4444986#4444986
> [2]: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1188051/am625-audio_ext_refclk1-clock-output---dts-support/4476322#4476322
> [3]: sound/soc/generic/simple-card-utils.c#L441
> 
> Fixes: f5bf894c865b ("arm64: dts: ti: verdin-am62: dahlia: add sound card")
> Suggested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

