Return-Path: <linux-kernel+bounces-67415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D8A856B17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE371F2547D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8C136674;
	Thu, 15 Feb 2024 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yl217RKq"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69071369AA;
	Thu, 15 Feb 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018412; cv=none; b=EjR5PksbKxJegZqEJFRyT/5LaeFb9I0olQrwHm+PXRRBoKQshn+U8jLXkwgHL1J5Ka5IyiVOlU5q9JnCKCPAOXGzZLx0GNIuvLRAT50qVxWjhkDZkI/O26ysJRmuSun0xKQFkht1fIvWKcKLt6D9ZuZOhHa/aRB89cJspmPVZ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018412; c=relaxed/simple;
	bh=p31H8uOEp0HuhwRG30YTgQDQ++yGEhc75SspKNi/tkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ADVrckUghSb/ghHz4Dkqh9Riw6od+v8c6zAk2CsDtKMHAB+NUVbNtfpFh16y4ORnHpY3EhXF390OvoP0x4+loWHoAtg21phdpcmec/e/bbcjJuwbSCgd2XdQGAOdf+duJElc2fCPmjkJWAfgoWsSDTFZ2+JrP0AXVzAEpuizZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yl217RKq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FHXLg1077311;
	Thu, 15 Feb 2024 11:33:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708018401;
	bh=3m5CY2TlNVkh9N5ta1BmX3oJiLnGhcLpO2VHPGpYWkY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Yl217RKqVk4A83gphfnfFFEKlw0qJ5vK9VGDNU/2cODSHuF39kSFE1Tk4r0X+5Uaq
	 JSFoOEmXvDwmi3FSVFQJE+jlYMpBLVQN68OJPfseNCK9IaydUny3MSZXDeZjNOYtFl
	 AlhB13AV2ioEumDI8PxX4hVjK+fG8YVyp2NniZvU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FHXLhU032488
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 11:33:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 11:33:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 11:33:20 -0600
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FHXGhL074623;
	Thu, 15 Feb 2024 11:33:17 -0600
Message-ID: <7b99b3c2-d0dc-4092-9090-5b960ba12738@ti.com>
Date: Thu, 15 Feb 2024 23:03:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay from
 ICSSG nodes
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240215105407.2868266-1-danishanwar@ti.com>
 <71adaabd-bb24-4181-9fdf-f7191e93edb5@kernel.org>
 <4ef87f6c-caa8-45a8-8649-422806ec6eb2@ti.com>
 <a0dc9fb7-2124-4f0d-a136-fc16a2301b0d@lunn.ch>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <a0dc9fb7-2124-4f0d-a136-fc16a2301b0d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 2/15/2024 10:53 PM, Andrew Lunn wrote:
> On Thu, Feb 15, 2024 at 10:26:59PM +0530, Anwar, Md Danish wrote:
>>
>>
>> On 2/15/2024 9:27 PM, Roger Quadros wrote:
>>>
>>>
>>> On 15/02/2024 12:54, MD Danish Anwar wrote:
>>>> Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
>>>> property is no longer used by ICSSG driver.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
>>>>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
>>>>  2 files changed, 6 deletions(-)
>>>
>>> What about the DT binding document?
>>>
>>
>> Now I am only removing the property from device tree. Once this proprty
>> is removed from all DTs, in the 6.9-rc-1 I will remove the binding as
>> well so that net people can merge that without getting any errors /
>> warnings.
> 
> Did the binding have the property as mandatory? If so you are probably
> doing this the wrong way around. You should first modify the binding
> to mark it as optional and deprecated. Then modify the .dts{i} files
> to remove it.
> 

No the binding is optional that is why I am removing this property from
DTs first.

>    Andrew

-- 
Thanks and Regards,
Md Danish Anwar

