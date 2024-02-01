Return-Path: <linux-kernel+bounces-47633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4B845081
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCBB1F22765
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77143C08D;
	Thu,  1 Feb 2024 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="K2AEv6BW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500B43BB3D;
	Thu,  1 Feb 2024 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762927; cv=none; b=G52xmbd9VAXuGMYkw/b19hvFJndtRJtTspAZ8bUYdOYeUFrg7JdNXfPxiEHjcI3j8Zuf0mlmakFWA1xqav9Uz47vk3tmsS+x5T/9ArSLRveZMr6aC95Om/JcR7TfyXjzdYchgpJjQDwZHrxZmNDlCfxvgcqojiZ2ZJ70cgsAeQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762927; c=relaxed/simple;
	bh=xL0nyKVhrIcxuqV0BG6FMGU+ell3gSDDFs4QRYJiaCc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rMLlkNwBoi/1q48QRCG46zrPO7Hc30DMthuu/7824rqmC0ShV5p/mCg1DiN5gxhMNTTsttbWnSvbVwq5XbVa5GmR85dqj8q/BuDFutfAfJROoyvQH6I/0TjrSlxiHKS/TH9d3sLOQtYCY2b5StjSfckZj1uWv0qSHub2wu4HvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=K2AEv6BW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4114mb0x107740;
	Wed, 31 Jan 2024 22:48:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706762917;
	bh=EIKilEn6zEi1dZ781Pbh1VH1L78d33wt2fu321g7goo=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=K2AEv6BWjxxm8nZLsB5rHmfEIlRoTZFgBVUHvGJqJq42bRGJdKRaRPNKVKL6SDmFP
	 U6npScF4ampBbDkQg9EsabUDITwfPWB32qPfd5za4QQuhVn5Y4WsJa+U0gZkMmOTI0
	 OfWtxGWhMLbBCBBTmEcCgXzUltj0zz63UplNHILw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4114mbXZ094131
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 22:48:37 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 22:48:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 22:48:36 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4114mXP4041142;
	Wed, 31 Jan 2024 22:48:34 -0600
Message-ID: <91737281-8249-4fcb-b5bf-750c015b7c24@ti.com>
Date: Thu, 1 Feb 2024 10:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: Add ti,k3-pcie-ctrl compatible
Content-Language: en-US
To: Andrew Davis <afd@ti.com>
References: <20240131112342.1300893-1-s-vadapalli@ti.com>
 <be60e695-894e-4281-a62c-b77e45680293@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <be60e695-894e-4281-a62c-b77e45680293@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Andrew,

On 31/01/24 21:43, Andrew Davis wrote:
> On 1/31/24 5:23 AM, Siddharth Vadapalli wrote:
>> The PCIE_CTRL registers within the CTRL_MMR space of TI's K3 SoCs are
>> used to configure the link speed, lane count and mode of operation of
>> the respective PCIe instance. Add compatible for allowing the PCIe
>> driver to obtain a regmap for the PCIE_CTRL register within the System
>> Controller device-tree node in order to configure the PCIe instance
>> accordingly.
>>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> This patch is based on linux-next tagged next-20240131.
>>
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 084b5c2a2a3c..da571a24e21f 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -73,6 +73,7 @@ properties:
>>                 - rockchip,rv1126-qos
>>                 - starfive,jh7100-sysmain
>>                 - ti,am654-dss-oldi-io-ctrl
>> +              - ti,k3-pcie-ctrl
> 
> This might not be the same for all K3 devices, you should use
> the name of the first device which uses this, so:
> 
> ti,j721e-pcie-ctrl

It is the same for all K3 devices so far. However, since the convention appears
to be the first device that it is applicable to as you pointed out, I will post
the v2 patch for this accordingly.

-- 
Regards,
Siddharth.

