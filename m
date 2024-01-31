Return-Path: <linux-kernel+bounces-46537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB08F844111
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6349B28DB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAC80C11;
	Wed, 31 Jan 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wgy0a8Fa"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802C80BF3;
	Wed, 31 Jan 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709211; cv=none; b=eCrkEVm1Czy4J8PqHQVE0fjtj8ex8u5YQh/w5NvQcQ/FniFSIXNuDvDf3I0cbw1F4I0U7NLabdup7X7nEFWkmss6yJyC4dSnG7w5q3ZGGEAgnuQK0eDA5NlBE6rpMZ/gfHJy99NAPFWcSRptb1JxpONRfs7k4RE7z5eXBguvVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709211; c=relaxed/simple;
	bh=nIh+VBvA5QaoBvbJWfkPWYfU4t9UMfIsZhyh56Fwv40=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cMl8zHpKDYuRWy3cs9ZdUpyaaHREb9NUHa5csJknN1/zJxVX47gSETEcop36mogHwxB1YDebXQiWC8pdx38mtQmtUu8+4UwT5pO3qStBX98H89yhwYiM+Z8VcoNralnol3YyjHw+b13D/jlN7qEZQPOPoSvS+iseiI20dovrxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wgy0a8Fa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VDrHFc122613;
	Wed, 31 Jan 2024 07:53:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706709197;
	bh=6jFxPGh7FYjhWra5jERW4b2ZMjUvYI+KXftnz72P4FI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Wgy0a8FaufRMLzrIp2MqX+5w8eSWbk3xY5h2mwrlnarVOvSfVxBnHCvBnKcItYo8O
	 wezdOO5S6KvCZZWiRlmrFnLaEdwuau+QpRh1SQb0XbS1BM0MmK5fsDHhr2lkZPKDXR
	 ZLxAanx+m9oZGcC4R99fp4qNeLRRIqX7PRCaFrVY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VDrHq3025637
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 07:53:17 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 07:53:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 07:53:17 -0600
Received: from [10.249.142.56] ([10.249.142.56])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VDrBDB126727;
	Wed, 31 Jan 2024 07:53:12 -0600
Message-ID: <52b14b42-6e42-4435-b391-c3f48470e56c@ti.com>
Date: Wed, 31 Jan 2024 19:23:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Add tuning algorithm for delay chain
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Judith Mendez
	<jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Andrew Davis
	<afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
 <5e03e867-b45f-482b-b734-7949e28fc97e@ti.com>
 <37af5a30-0e47-41f9-8d9f-f09a38d05fa5@linaro.org>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <37af5a30-0e47-41f9-8d9f-f09a38d05fa5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 1/31/2024 7:11 PM, Krzysztof Kozlowski wrote:
> On 31/01/2024 14:35, Raghavendra, Vignesh wrote:
>>> Judith Mendez (11):
>>>   drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
>>>   drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
>>>   drivers: mmc: host: sdhci_am654: Add missing OTAP/ITAP enable
>>>   drivers: mmc: host: sdhci_am654: Add ITAPDLYSEL in
>>>     sdhci_j721e_4bit_set_clock
>>>   drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing
>>
>> These patches needs to have Fixes: tag as they are bug fixes IMO.
>>
>>>   arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
>>>   arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
>>>   arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
>>>   arm64: dts: ti: k3-am62p: Add missing properties for MMC
>>>   arm64: dts: ti: k3-am6*: Remove DLL properties for soft phys
>>>   arm64: dts: ti: k3-am6*: Reorganize MMC properties
>>>
>>> Nitin Yadav (2):
>>>   arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
>>>   arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
>>>
>>
>> Can the driver changes be merged independent of DT changes? Or are they
>> meant to go together? Latter would be problematic as it creates cross
>> tree dependencies.
> 
> DTS cannot depend on driver changes, because that would mean hardware
> description is not really hardware but OS. So the answer to your
> question must be "yes, can be merged independently".
> 

Normally yes, but here I see update to tuning algorithm and timing
paramaters to the algorithm. DT updates seem to be nature of bug fixes
where in parameters have been refined due to more HW char
data/understanding being available.

I get nervous when anyone posts both driver and DT changes in a single
series, because they may not have tested driver changes standalone and
may have broken the DT backward compatibility

> Best regards,
> Krzysztof
> 

Regards
Vignesh

