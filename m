Return-Path: <linux-kernel+bounces-21925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1B8296AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF4E1C22FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A03F8E4;
	Wed, 10 Jan 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tjiGsheS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFE3EA9C;
	Wed, 10 Jan 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A9dklx009461;
	Wed, 10 Jan 2024 10:54:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=SMY/YRkrLa8qTKcLx39OUdusAyLog8eoCTO/ymESOn4=; b=tj
	iGsheSbWzimarjEDpbU+QobiMrSVJmIgPKAo/DWYJhD7pxYKNE56lMoEUWTRUKO/
	ba9JdiKknjytZ4Q9iU43t9r38h1O7AvCv12V+D0BTpMZBq3kSI6AQYk2pVCVRKZA
	4/wkm1NewSIaeykN1KIFMWFCMl1Fqxi8CINWCZPbSaAkS24NQ3n62pDjCUIAtyBY
	P1Nk5rDK/ONiOn36/EtndXk3vtmpZ8+B+e3AJyz2uxoXMRa7gB5eWAbfQMc8kbUT
	BoyfMpxd0Vs/YMDua8YXPo1JegglE/O0SG8S0NVrVThbomT6bRBGzWeZhRnF0pzU
	40eFLUw9P1Cn1zNLv2Xw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexmffm6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:54:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C1DE610002A;
	Wed, 10 Jan 2024 10:54:29 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D812257A9B;
	Wed, 10 Jan 2024 10:54:29 +0100 (CET)
Received: from [10.252.22.30] (10.252.22.30) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 10 Jan
 2024 10:54:26 +0100
Message-ID: <74a39554-a514-42f3-a2ab-d436d4fee474@foss.st.com>
Date: Wed, 10 Jan 2024 10:54:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: Fix an error handling path in
 stm_drm_platform_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Yannick Fertre" <yannick.fertre@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20fff7f853f20a48a96db8ff186124470ec4d976.1704560028.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20fff7f853f20a48a96db8ff186124470ec4d976.1704560028.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Hi Christophe,

On 1/6/24 17:54, Christophe JAILLET wrote:
> If drm_dev_register() fails, a call to drv_load() must be undone, as
> already done in the remove function.
>
> Fixes: b759012c5fa7 ("drm/stm: Add STM32 LTDC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This was already sent a few years ago in [1] but it got no response.
> Since, there has been some activity on this driver, so I send it again.
>
> Note that it is untested.
>
> [1]: https://lore.kernel.org/all/20200501125511.132029-1-christophe.jaillet@wanadoo.fr/
> ---
>  drivers/gpu/drm/stm/drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
I tested it against stm32mp157c-dk2.dts.

Thanks for your submission.

Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>


Regards,

Raphaël Gallais-Pou


