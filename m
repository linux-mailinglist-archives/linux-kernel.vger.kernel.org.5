Return-Path: <linux-kernel+bounces-61279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A5851047
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51AB7B25044
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7F18026;
	Mon, 12 Feb 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LWzQNVJn"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446D17BBE;
	Mon, 12 Feb 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732211; cv=none; b=oyhC3faMFGsPqY/skv5NjH5cJMhPWaNw53BO0C3DOqNr6SWrnu0YfNZ9ecKspZzIFILiSVQ+i6i1W0tZzjFGiuaahaUYW8b/B2TdZXgldlDYPQLbHw8TAKocE5MPCX9bUb4aJkR+/fHZ+9e9ekX/E5yxcl2IiUFmTuOMdv+dXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732211; c=relaxed/simple;
	bh=EUaMkEUqz4qgROvxBCIDolmNlZRkFxJ7hUO/k+Lveu0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut4W3DEFOcsvv8fjCktwAQ3YrjXi5ruUdp3GBIY2+k5G3XEjATiSvnSOnCKCVnGOH2KjchQv7CRtFtMcNULBsQvHQXee3qAA6LCGeorQSGRFuUGiUw1b20blwzkZWNj8596oK6lGyS6wmucyLpAN2y5SCgeBBn1FeXuxOGG3t/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LWzQNVJn; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41C7sVo4016307;
	Mon, 12 Feb 2024 04:02:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=WLF2X+j3Bn92Q1D
	DaV05/unswsO5ahBS+1WWPqaApW4=; b=LWzQNVJn8q7dcq0Bd+TtMxT1lIBoGiw
	yD0TsejCsoABuy8AggRDJW06Q1z2xJlky/ztkU9ADIkffObtOL0UuCQv3Beh4nhA
	Put6Ypu2vVivviEJ6Oil+cEfW1Q27QM+O9ltZ623dvQO4anhr/dZNovMzxP3lw+a
	LhOj5jub+y3fjAvlvXTHjliMbTrYlMFuhJHFxHorIs5Vl5GjaGvKHU61HqyF2Ni8
	oMyxoPUphkMgU1KFNxi+kfuEZzYoo4jyVm3Qy64lf8Glce+CGjlLDllqFwliGFC9
	RTpYBk2a8X7avMhCql6FZ7NmoU/tVg544Z1TluPmt36M8g8y3w06Uow==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w67e21nee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 04:02:21 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 10:02:18 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Mon, 12 Feb 2024 10:02:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 70E1F820242;
	Mon, 12 Feb 2024 10:02:18 +0000 (UTC)
Date: Mon, 12 Feb 2024 10:02:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan
	<peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter
	<jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Russell King
	<linux@armlinux.org.uk>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        NXP Linux Team
	<linux-imx@nxp.com>,
        <linux-amlogic@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] clk: constify the of_phandle_args argument of
 of_clk_provider
Message-ID: <ZcnsqaIftZXcNaUA@ediswmail9.ad.cirrus.com>
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
X-Proofpoint-ORIG-GUID: NzDJLMtFiatrdGDskmwX3IMPmG4MYizJ
X-Proofpoint-GUID: NzDJLMtFiatrdGDskmwX3IMPmG4MYizJ
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 08, 2024 at 05:37:10PM +0100, Krzysztof Kozlowski wrote:
> None of the implementations of the get() and get_hw() callbacks of
> "struct of_clk_provider" modify the contents of received of_phandle_args
> pointer.  They treat it as read-only variable used to find the clock to
> return.  Make obvious that implementations are not supposed to modify
> the of_phandle_args, by making it a pointer to const.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/clk/clk-lochnagar.c                   |  2 +-

For the Lochnagar bits:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

