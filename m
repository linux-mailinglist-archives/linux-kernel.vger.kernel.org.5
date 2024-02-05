Return-Path: <linux-kernel+bounces-53138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31FC84A125
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C9A2844A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23E744C94;
	Mon,  5 Feb 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qYa11oAr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11144C6E;
	Mon,  5 Feb 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155061; cv=none; b=sJ3NPn6oxmpsE7RUwQzUGYRn9GlfOOVRl2tAfoVHGZnTaS8AtG/7EHk59IZvSVAfDEecAOYdzuFKVtq22olry8ma9C7Sqp20Tc3NUg5U5+eWqx7FP6rkXpnnybon5RQle48BWN0P/gAm1EOxZsAG9GiIhIKb+1AxBmKj4acyFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155061; c=relaxed/simple;
	bh=shmRZRZMdyP1TZEZPI2SLd/wrE2/uiXcQS4CP6XJC88=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i/XMqzhKrf4VJVVUMCv44/D6Ln1R+THqCVauyjqmJ8y5L74gds2sew8V5Vp/CGfs9qDZsmb3EkykQAO795Y/fncZdEWAbMZJCKPLoHXVSXxnkhoyFXOkmS9XeI8blRgyhk+Uszt1Pm9z8/X24k4vsQJLwYiu8tG9C5rSSGSI8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qYa11oAr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415HiDWR104615;
	Mon, 5 Feb 2024 11:44:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707155053;
	bh=si6pclXFQlE/WBOZYOAisqq7cXqmSV1WJqBUKZccLkY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qYa11oArMOfaTXSSNl9+Zq0wtS1AGOjxkt/kzu508X0KDzakYlkLG6zw/g2FCbcUG
	 St4xHR8jW8Scornrj0XoBeoIRqGuDEM4UekFfOkdhgaIClfxGILBS2hidP2B/wu91F
	 DRG9uY+ecaRsRoCpTLSwQm2HgHr3goBzFQiYvGhw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415HiDYu067439
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 11:44:13 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 11:44:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 11:44:13 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415HiD4u125497;
	Mon, 5 Feb 2024 11:44:13 -0600
Message-ID: <cacd8a60-3006-4e16-b0ad-1d194ef0d70b@ti.com>
Date: Mon, 5 Feb 2024 11:44:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl
 compatible
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240130195128.58748-1-afd@ti.com>
 <a50c5731-b328-4bf1-9449-ad15eb0f9ea6@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <a50c5731-b328-4bf1-9449-ad15eb0f9ea6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/5/24 8:05 AM, Vignesh Raghavendra wrote:
> 
> 
> On 31/01/24 01:21, Andrew Davis wrote:
>> Add TI SERDES control registers compatible. This is a region found in the
>> TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
>> SERDES clock and lane select mux.
>>
>> [0] https://www.ti.com/lit/pdf/spruid7
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 084b5c2a2a3c2..d8679a2ad4b10 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -73,6 +73,7 @@ properties:
>>                 - rockchip,rv1126-qos
>>                 - starfive,jh7100-sysmain
>>                 - ti,am654-dss-oldi-io-ctrl
>> +              - ti,am654-serdes-ctrl
>>   
>>             - const: syscon
>>   
> 
> This needs to go via mfd tree (or at least need an ACK). Please cc
> appropriate maintainer  (Lee Jones <lee@kernel.org>). So, I recommended
> to split 2/2 out into separate series and post once this patch is merged.
> 

Sure, will send this patch standalone, then post the dts changes later.

Andrew

