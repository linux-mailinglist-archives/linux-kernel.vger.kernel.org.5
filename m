Return-Path: <linux-kernel+bounces-47822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E9845359
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42081F21446
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836215AACE;
	Thu,  1 Feb 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IqBTviCZ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B809115AAC5;
	Thu,  1 Feb 2024 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778139; cv=none; b=lHZsIiiTcw5JZIGysAX8jTiT5XRJ+3zTe0ukZjRDZ1OoCcDvfHqzYofNZCEFmEuJ8Bo8OzYsPXB2vZuBehTjC9N8LHX2QJCRtLO3Vwa5pNmQ42ASYQhsMa9vE7hSJ5VzumBpilT4oxfNW9O6t7jREKC829TQqkxoqdG0SaPu9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778139; c=relaxed/simple;
	bh=m3zj+c1KrXuTtL/Cv8kjsXgJxATsEHRBlKH9xRAhBcE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KvHd4tpxHJs/4rOz5Yb33kXJhJ/26YhvoTGing9f+seFTg5sL0iX+rCRVHwhnIJvuQ3YRCvRboqcJK9IOcwSy6ziJVhV84pyuaqhMjLtJ8mTnNjak7UmUzs4EZAvrxAa2FJLhPz41nbGIohz39/ZkYcF5GOIKLI8eTexV3OdOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IqBTviCZ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411929q4043826;
	Thu, 1 Feb 2024 03:02:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706778129;
	bh=ZSk5SbQ8C5SsybIUiqh6RtM8sEDGplVl9FiGywesWJI=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=IqBTviCZmKusrwayxJbxj/VgNThcRbghjdcO+w/lHaOFMYLXcMNGO3b6eOhEFh4yq
	 pJUa3K+VRjRMQn9re/u8J+04L05ZQDlEEMCCDCnEjgc4BkZORxTxlV6zxgFIeZ66bC
	 IDFQH+lV/v8qaPBNBeN+omGi3y3pmcAzMNdh2PMA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411929qq014862
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 03:02:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 03:02:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 03:02:09 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4119252Y011889;
	Thu, 1 Feb 2024 03:02:06 -0600
Message-ID: <42d2afa0-27f6-457d-bf95-690c83ed42d5@ti.com>
Date: Thu, 1 Feb 2024 14:32:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Andrew Davis <afd@ti.com>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,k3-pcie-ctrl compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240131112342.1300893-1-s-vadapalli@ti.com>
 <be60e695-894e-4281-a62c-b77e45680293@ti.com>
 <91737281-8249-4fcb-b5bf-750c015b7c24@ti.com>
 <2824fd42-d588-4a0b-b6f9-1e9cb6055d6a@linaro.org>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <2824fd42-d588-4a0b-b6f9-1e9cb6055d6a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Krzysztof,

On 01/02/24 13:01, Krzysztof Kozlowski wrote:
> On 01/02/2024 05:48, Siddharth Vadapalli wrote:
>> Hello Andrew,
>>
>> On 31/01/24 21:43, Andrew Davis wrote:
>>> On 1/31/24 5:23 AM, Siddharth Vadapalli wrote:
>>>> The PCIE_CTRL registers within the CTRL_MMR space of TI's K3 SoCs are
>>>> used to configure the link speed, lane count and mode of operation of
>>>> the respective PCIe instance. Add compatible for allowing the PCIe
>>>> driver to obtain a regmap for the PCIE_CTRL register within the System
>>>> Controller device-tree node in order to configure the PCIe instance
>>>> accordingly.
>>>>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>
>>>> This patch is based on linux-next tagged next-20240131.
>>>>
>>>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>> index 084b5c2a2a3c..da571a24e21f 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>>>> @@ -73,6 +73,7 @@ properties:
>>>>                 - rockchip,rv1126-qos
>>>>                 - starfive,jh7100-sysmain
>>>>                 - ti,am654-dss-oldi-io-ctrl
>>>> +              - ti,k3-pcie-ctrl
>>>
>>> This might not be the same for all K3 devices, you should use
>>> the name of the first device which uses this, so:
>>>
>>> ti,j721e-pcie-ctrl
>>
>> It is the same for all K3 devices so far. However, since the convention appears
>> to be the first device that it is applicable to as you pointed out, I will post
>> the v2 patch for this accordingly.
> 
> This was repeated so many times... so one more. Compatibles are specific
> to SoC, not to family.
> 
> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Thank you for reviewing the patch and sharing your feedback. I will make sure
not to repeat this in my future patches.

-- 
Regards,
Siddharth.

