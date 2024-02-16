Return-Path: <linux-kernel+bounces-69110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACA8584BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92371B21BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB4F133995;
	Fri, 16 Feb 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Xzqy8X/Y"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D412FB3F;
	Fri, 16 Feb 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106456; cv=none; b=Dw8XgS+os8nwsOPFbcA2yq3qxP1mQ7QVQcbRp6+QTTSmE9mFUUL2OASnMQLmSMMzlstV8CicHIURjIH2uSw6UiYu7BlnNts9NhcXSch/L0Fi+KcsSQo5I6GXEbdXOjFkrkS+hzHaPaoZwkiGJxG8eLE4ENxKzG9ytcXGMFCK774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106456; c=relaxed/simple;
	bh=ZAosGOA5suCb8SlRfj72vMGRr1ok4VubPM72huT6/Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=alfIi5n3baCAVdQjExG0F+RietJuo9fhbEDUZIBzbpRbB/td4o2Mt+2CM62VTC8l7eTW4qR4xeASB/bjcB8JCyluBP8QYeTJDonrBNC8yMUpOSeyJyVau6e43PoQYg4tm2SeZJbXzw3bghsWb2bZ8IzETL56A3qxuxo9hL7ofu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Xzqy8X/Y; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GFVavx008758;
	Fri, 16 Feb 2024 19:00:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jJ5ftO6qA0bAbkgyUfXtwPro3bnB89V6hMXoFA1fX/0=; b=Xz
	qy8X/YaHt/8k33pAAt7aZRhVsgVFL3Me4tcPqydMkRXJNewjP8V4MmwnP63N82Au
	jEZPPAyiTU0nbkgT9PBSMU+tHiHt879JqklHFkUSnV/2LSoTA1IRjmD49jbthIxQ
	HMMowLqc67S9ONoxnIqhqltbXdtZ5jl5g8NPD7PlZsO8h/2aS36JNvqRC79CI+fQ
	WtNuO6+MBb8Uby4QrRxGzK3YSXqa0dm3EQyovHV42YGiMMRNBb490h1KkBwVm2EJ
	xSGNSf3CCO2c0OXjc7s8DuInLSFy2xAQreAKn8ZGtlK1P5RoowG/n0mucZIWZWf/
	od4yDgDDQHFSe6PSvGEg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wa124k49t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 19:00:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D02CB40045;
	Fri, 16 Feb 2024 19:00:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 535432951A1;
	Fri, 16 Feb 2024 18:59:35 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 16 Feb
 2024 18:59:34 +0100
Message-ID: <90e6e7a2-97fd-41dc-bde9-43949168f9cd@foss.st.com>
Date: Fri, 16 Feb 2024 18:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Add MP25 FMC2 support
Content-Language: en-US
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240212174822.77734-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_17,2024-02-16_01,2023-05-22_02



On 2/12/24 18:48, Christophe Kerello wrote:
> Add MP25 SOC support in stm32_fmc2 drivers:
>   - Update stm32-fmc2-ebi driver to support FMC2 revision 2 and MP25 SOC.
>   - Update stm32_fmc2_nand driver to support FMC2 revision 2 and MP25 SOC.
> 

Hi Miquel,

Don't waste time reviewing this first patchset because I rewrote the 
NAND part.
Patch V2 will be sent next week.

Regards,
Christophe Kerello.


> Christophe Kerello (11):
>    dt-bindings: memory-controller: st,stm32: add MP25 support
>    memory: stm32-fmc2-ebi: add a platform data structure
>    memory: stm32-fmc2-ebi: add MP25 support
>    memory: stm32-fmc2-ebi: update the driver to support revision 2
>    memory: stm32-fmc2-ebi: add RIF support
>    memory: stm32-fmc2-ebi: add runtime PM support
>    dt-bindings: mtd: st,stm32: add MP25 support
>    mtd: rawnand: stm32_fmc2: use dma_get_slave_caps to get DMA max burst
>    mtd: rawnand: stm32_fmc2: add a platform data structure
>    mtd: rawnand: stm32_fmc2: add MP25 support
>    mtd: rawnand: stm32_fmc2: update the driver to support revision 2
> 
> Patrick Delaunay (1):
>    dt-bindings: memory-controller: st,stm32: add 'power-domains' property
> 
>   .../memory-controllers/st,stm32-fmc2-ebi.yaml |   7 +-
>   .../bindings/mtd/st,stm32-fmc2-nand.yaml      |  58 ++-
>   drivers/memory/stm32-fmc2-ebi.c               | 445 ++++++++++++++++--
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c        | 108 ++++-
>   4 files changed, 547 insertions(+), 71 deletions(-)
> 

