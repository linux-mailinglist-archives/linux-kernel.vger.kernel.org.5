Return-Path: <linux-kernel+bounces-47095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBB284490D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286C628FDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C23839F;
	Wed, 31 Jan 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QNici0k+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3720DE0;
	Wed, 31 Jan 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733704; cv=none; b=Ik1c32Jyn6IR98YlEhskW7mX9DsyEUcgzs4CzWOnRRBGTsIkiVYjh9t8FlDcjIj9cmw/xWvlhvzCvlP5LvSrth/gX3V7uoNktYNK/Zuj3qaucX9ztnF/gomnfSUvyi1bSd6aq+Op/g+Gb6sD3DUF7D/BINOg2L+MYGVlbEDLE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733704; c=relaxed/simple;
	bh=i8BK1vul/D0h0q8NumttG0fZUxs7TYr/KsMBcuAt20o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qz2G5JGOBdvThzMnF/ODo4Pc0gX24y7h1YjWuNjzuOZsGIg5uD9DvOaGDNvPI8DvjBOy6NPKDBG1SWd/b7jVspJdWuaYcfiOuJXSmqLHuTT9Qg8Zz3nCS46KsE20in4vLb8kFDggFp5DcjrlEfhs/cnuzZhm1A4VcLX0AhzM6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QNici0k+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VKfVJQ112558;
	Wed, 31 Jan 2024 14:41:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706733691;
	bh=MrbmAMsWZQgSlGEY4D41Ts6E5MpC5FPSiof4n6JfF0I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QNici0k+CZKoPLY1PbTFlYxWjOyml3wH/fCyP4h5jo/2Vv5YwUML3kmKl9RtI+MhO
	 ELYsImRPtZ8XFYtybmFS/Rf25Rg/W52w8MILkGw6DQSRCK8bCVFYnzjePQkMvjLiNH
	 RcPhxaqQhxuLc+a8GBRzk+MpKSZZpw5GrqGmzYPI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VKfVgL008187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 14:41:31 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 14:41:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 14:41:31 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VKfV0l099440;
	Wed, 31 Jan 2024 14:41:31 -0600
Message-ID: <989bcf17-114a-4f6c-84b9-1ff443cb01dc@ti.com>
Date: Wed, 31 Jan 2024 14:41:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Add tuning algorithm for delay chain
Content-Language: en-US
To: "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Andrew Davis
	<afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <5e03e867-b45f-482b-b734-7949e28fc97e@ti.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5e03e867-b45f-482b-b734-7949e28fc97e@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/31/24 7:35 AM, Raghavendra, Vignesh wrote:
> Hi,
> 
> On 1/31/2024 6:07 AM, Judith Mendez wrote:
>> This patch series introduces a new tuning algorithm for
>> mmc. The new algorithm should be used when delay chain is
>> enabled. The ITAPDLY is selected from the largest passing
>> window and the buffer is not viewed as a circular buffer.
>> The new tuning algorithm is implemented as per the paper
>> published here [0] and has been tested on the following
>> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
>> EVM.
>>
>> The series also includes a few fixes in the sdhci_am654
>> driver on OTAPDLYEN/ITAPDLYEN and ITAPDELSEL. There are
>> also device tree node fixes for missing mmc nodes,
>> modifying DLL properties, and fixes for OTAP/ITAP delay
>> values.
>>
>> MMC0/MMC2 nodes are introduced for AM62ax in this series.
>>
>> This series is sent as a RFC mostly to get some feedback
>> and/or comments on the new tuning algorithm implementation.
>>
>> [0] https://www.ti.com/lit/an/spract9/spract9.pdf
>>
> 
> 
>> Judith Mendez (11):
>>    drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
>>    drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
>>    drivers: mmc: host: sdhci_am654: Add missing OTAP/ITAP enable
>>    drivers: mmc: host: sdhci_am654: Add ITAPDLYSEL in
>>      sdhci_j721e_4bit_set_clock
>>    drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing
> 
> These patches needs to have Fixes: tag as they are bug fixes IMO.

Understood, will add.

> 
>>    arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
>>    arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
>>    arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
>>    arm64: dts: ti: k3-am62p: Add missing properties for MMC
>>    arm64: dts: ti: k3-am6*: Remove DLL properties for soft phys
>>    arm64: dts: ti: k3-am6*: Reorganize MMC properties
>>
>> Nitin Yadav (2):
>>    arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
>>    arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
>>
> 
> Can the driver changes be merged independent of DT changes? Or are they
> meant to go together? Latter would be problematic as it creates cross
> tree dependencies.

The driver changes can be merged independently.

> 
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  57 +++--
>>   .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   5 -
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  45 +++-
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  27 ++-
>>   arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     |  44 +++-
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |   7 +-
>>   .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |   4 +-
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  17 +-
>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   4 +-
>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   2 -
>>   drivers/mmc/host/sdhci_am654.c                | 215 ++++++++++++++----
>>   11 files changed, 321 insertions(+), 106 deletions(-)
>>


