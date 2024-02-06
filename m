Return-Path: <linux-kernel+bounces-54643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E084B1E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4646D286375
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65812E1C9;
	Tue,  6 Feb 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PAMHxqr4"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C412C7E1;
	Tue,  6 Feb 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213885; cv=none; b=sklkRAHcZjFe8kmLJNnF9a05pshrByiOZVYFo5bl8M9FnBC3CjbsEfv0ZC5parMEBtxZhpDVkNdDM14uzWdHNNasoyMSPo8lVg9g/D0tHSs7y1nr75KziFe9wAg+QHMxVgtTWDriXaPE+7xswTIvpi6ysscrORwi/INrwGiPimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213885; c=relaxed/simple;
	bh=aavDWnk6//c/Ub+nrQ0I1UAI5F+LCVH+chmlRSbpFx4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4c7aCr2y4+ni9426sYaFhLnL1RJ1AlGH1dpaeM9RKjgyWlFStgwm+c9M3DuM6+wRnizYSsNtmtabYKqxFH9IL8hbeXtztAEfNN859/5hgBjVSOZxXtPngxC8a326s65Z9MGoVxRK/gf0dnshxaRalvx7+7MbHfYc5H/IX1t2xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PAMHxqr4; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164p8Bf011574;
	Tue, 6 Feb 2024 04:04:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=uPUFH7eDTg7/caX
	3/YYHyrwvuZijGhOyQY2h4OtQApg=; b=PAMHxqr48BmEQnxAFkzb87smOGK99mJ
	Kj4UKHiW81B6PtnP+G8OtT5jp7g8jBfdSuA6983a0MRdn4PRyxz+A2XhmPCR1pb3
	M8OgeVUCqKEllRphB274vk9ZNxXOIoLOLDWVwlIH3SvdqHtsYRliw4DlyUdzTZqo
	DXjEmbUGw9/ihSxp83mCfJEUKMkfChgkVnWPPGKUvUhzz7puvmyRbbSwDdhzN7zo
	Y8/IVP2YA0EsdRYutWzW9I5Zm+YKYGJTGLupwZwnYCzeKH3NjoY5K5ZEDSZV+6Aq
	MVOI0eShWi4M2QEHB//snLM7ErBPHj04SZxU0vtQYu0JAJHXxVUjoWQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2b7uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 04:04:10 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 10:04:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 6 Feb 2024 10:04:08 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 97273820241;
	Tue,  6 Feb 2024 10:04:08 +0000 (UTC)
Date: Tue, 6 Feb 2024 10:04:07 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bo Liu <liubo03@inspur.com>
CC: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
        <support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
        <rf@opensource.cirrus.com>, <mazziesaccount@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/18] mfd: wolfson: convert to use maple tree register
 cache
Message-ID: <ZcIEFxh76TTXBTiT@ediswmail9.ad.cirrus.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <20240206071314.8721-11-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206071314.8721-11-liubo03@inspur.com>
X-Proofpoint-GUID: ovCDYOzOk03aaOgaUtGd9-ILGLhAAQBp
X-Proofpoint-ORIG-GUID: ovCDYOzOk03aaOgaUtGd9-ILGLhAAQBp
X-Proofpoint-Spam-Reason: safe

On Tue, Feb 06, 2024 at 02:13:06AM -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  drivers/mfd/wm5102-tables.c | 2 +-
>  drivers/mfd/wm5110-tables.c | 2 +-
>  drivers/mfd/wm8350-regmap.c | 2 +-
>  drivers/mfd/wm8400-core.c   | 2 +-
>  drivers/mfd/wm97xx-core.c   | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)

The change looks good, but whilst it won't cause any problems, it
seems a bit weird not to convert wm8997, wm8998 and cs47l24.
These are part of the same driver as wm5102 and wm5110.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

