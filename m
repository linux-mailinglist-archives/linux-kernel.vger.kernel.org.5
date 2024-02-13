Return-Path: <linux-kernel+bounces-63383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E427F852E85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDD2829B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AB2BB1B;
	Tue, 13 Feb 2024 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TCW9CGgc"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B50324A13;
	Tue, 13 Feb 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821907; cv=none; b=bycuai6A0Ws8TmW2OjdB1vR8U3G5r2h3KvYS/6AZeJmmEcMfWohiIg/tXyHHig4ZLNQEFP0bXTkOO+/99EkqqpBLfGnMhV/w1wz5DXfiMO7gVln4SSsW4ePorqg0PDJ/j4UpoyXlGvA3JrbFSfGSv/7Fu9sVq1/IdCkhu+smcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821907; c=relaxed/simple;
	bh=DkmNN2TR9PP6pKKqv0h6BR/pP/ta6VTX45fWrn5btZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GTbGN12MombZytVCgzq5ff6KnJnIPfZf24nUqfXhnorvJB+DqxPl1WiZ69x09LLvsLUM8RuuQQdNKThWRZ8aEf0SBdqjZJbAIFN8X5i7RCHDQ5hjF1cXF3yLtbctoNjPJoDVPkA9n2+r4srlsS7w5oxf7+KKS7d0eYSiwAytnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TCW9CGgc; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D7H0KQ028796;
	Tue, 13 Feb 2024 11:58:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=gUYosoA8j7mHWQIdEE+8Wty/qpa9vCO8sbMml7llxww=; b=TC
	W9CGgc23PaS5vqcWF3914GI2mhrnsbymvEmGJ6lEpav3eaqQTGezBUWbhhrPlFzZ
	jv6fv0j1bP+9B83xB/UKOPXqQweTBb5UVeQhLhCo9TSHJRhb2/g9UwGBfHWiOGEk
	bOkp0V+HpzeTFjQ3ieoBQ1Q+UUYxoi7l658at/PXI5e2gxKKVYYqwTIW3N5t5F/T
	vKLNcUSmorwU8+prkFyvJXyJCuYgzxWdGA1fYMR+k8i6MEuH+/qxqVLtMd/8icPT
	1zrFXSU2wjvVON+zCpNOB3DSloVC9L4atO209G6QE10YJwyckGDhqnzdux+aVmmG
	2mwJWbepWQiHokL+BI0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62jsafxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:58:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4004440047;
	Tue, 13 Feb 2024 11:58:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9B42D22D199;
	Tue, 13 Feb 2024 11:57:20 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 11:57:19 +0100
Message-ID: <c57b8094-be08-4ae4-ba85-f48522e5d2a8@foss.st.com>
Date: Tue, 13 Feb 2024 11:57:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: memory-controller: st,stm32: add
 'power-domains' property
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-3-christophe.kerello@foss.st.com>
 <20240212-chemicals-skinny-18eda1cfe781@spud>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240212-chemicals-skinny-18eda1cfe781@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02



On 2/12/24 19:33, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 06:48:12PM +0100, Christophe Kerello wrote:
>> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>
>> On STM32MP25 SOC, STM32 FMC2 memory controller is in a power domain.
>> Allow a single 'power-domains' entry for STM32 FMC2.
> 
> This should be squashed with patch 1, since they both modify the same
> file and this power-domain is part of the addition of mp25 support.

Hi Conor,

Ok, I will squash this patch with patch 1.

> 
> If the mp1 doesn't have power domains, shouldn't you constrain the
> property to mp25 only?
> 

As this property is optional, I do not see the need to constrain the
property to MP25 only, but if you think that it should be the case, I
will do it.

Regards,
Christophe Kerello.

> Cheers,
> Conor.
> >>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>   .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml         | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> index 12e6afeceffd..84ac6f50a6fc 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> @@ -36,6 +36,9 @@ properties:
>>     resets:
>>       maxItems: 1
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     "#address-cells":
>>       const: 2
>>   
>> -- 
>> 2.25.1
>>
>>
>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/

