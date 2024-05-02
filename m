Return-Path: <linux-kernel+bounces-166296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E58B98B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D7D1C22526
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307A58228;
	Thu,  2 May 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RfLdXnh0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EB56B73;
	Thu,  2 May 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645284; cv=none; b=RLGgId0ZxsswH1W6ICLXGqdCMlVgir95dwDqvhDTV4lPbjRChHDWKdfd98h15KsPCRHZSu8yzioI+4+riwCRIWQAdiDnlsTCt+5+I7/NBPk37/BspBmDbYl0LuWgGh3CF7+ejVIDyhwoiHXVbKoQhex1+ZEd6DFH2v6kUsPfBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645284; c=relaxed/simple;
	bh=Uu8k1Y2EqX4OzuTvC+/1Fe63HhtOPHkpZYGeEgvWJ44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZLQIsh1dknQ+1xKloHw6qYZwCahPiNV3YC7VDsKV4GqHalqdnTbShluW+w81154WxKXuxyLq1VatXiCqOSoKjittxJ8MRmV/oXCdONCZn4QEj5ZR9RzPjeFzJJPZo0mMtq/InS0V4siwfAEm2FuteaByvdBix4Z2VeU9So31kPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RfLdXnh0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 442AKoMU112356;
	Thu, 2 May 2024 05:20:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714645250;
	bh=frYcCDaItIA9BuawKlzNsoAiSO+Svo4MUn6Yuai0x7A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RfLdXnh0NZo7iAYvStFvR0Tsb3fpuOtinvVHsYBn1ugyvK270RTbJvBASBqYm10NC
	 egB1o2FiuX5xsBFRAIkRpWzf5wPwIUphftZlTbv5RHIqpexeHuSFTI4OnV3MfN9zez
	 N3E5ZVr2FCX/DC1qk5PGKdpthmFOxDnJEdG0ZF80=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 442AKomr028630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 May 2024 05:20:50 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 May 2024 05:20:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 May 2024 05:20:50 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 442AKi08019243;
	Thu, 2 May 2024 05:20:45 -0500
Message-ID: <c420b47b-acb9-4055-9e5f-78deee1b575f@ti.com>
Date: Thu, 2 May 2024 15:50:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix reg ranges for main_pktdma dma-controller node
To: Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <bb@ti.com>, <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240430105253.203750-1-j-choudhary@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240430105253.203750-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Jayesh

On 4/30/2024 4:22 PM, Jayesh Choudhary wrote:
> The dma-controller node 'main_pktdma' has few memory regions with
> wrong sizes.
>
> DMASS0_PKTDMA_RINGRT is marked as 4MB region when it is actually a 2MB
> region. Similarly, DMASS0_PKTDMA_TCHANRT is marked as 256KB region but
> the actual size is 128KB as shown in TRM in the section for Main Memory
> Map (Table 2-1)
>
> Fix these region across AM62, AM62A and AM62P (which is also used in
> J722S)
>
> TRM:


For series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> AM625: <https://www.ti.com/lit/pdf/spruiv7>
> AM62A7: <https://www.ti.com/lit/pdf/spruj16>
> AM62P: <https://www.ti.com/lit/pdf/spruj83>
> J722S: <https://www.ti.com/lit/zip/sprujb3>
>
> Changelog v1->v2:
> - Add main_pktdma node name in commit message for more clarity about the
>    dma-controller and mention the table for memory map in TRM in each patch.
>
> v1 patch:
> <https://lore.kernel.org/all/20240405085208.32227-1-j-choudhary@ti.com/>
>
> Jayesh Choudhary (3):
>    arm64: dts: ti: k3-am62-main: Fix the reg-range for main_pktdma
>    arm64: dts: ti: k3-am62a-main: Fix the reg-range for main_pktdma
>    arm64: dts: ti: k3-am62p-main: Fix the reg-range for main_pktdma
>
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 4 ++--
>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)
>

