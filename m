Return-Path: <linux-kernel+bounces-56018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE21C84C4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38BA1C2386D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FF21CD39;
	Wed,  7 Feb 2024 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bKEuXDjB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAE1CD1B;
	Wed,  7 Feb 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707287343; cv=none; b=mCvTAFHggpYjivWbKc1X/1ExCsGDsi4yQonpMHED8jaxggXV+VsqKwTjwHOLKvcxU+QyNXIxwA0+o4r4lAjx8KzwPn49ifG6CG3X1SyFQxjJLCaRWUvRQVQDmY+x3I9Miw/hZa4Z5OnGUyjIOL17ZP2vnu6K30eO1agI0azmQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707287343; c=relaxed/simple;
	bh=jqksEA9y9Uu/DtYt8MagMMZG9Uyn1gsiHL7G7mml4Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UFgqo6s47l1g9FlLXRSNFA4S3GdILal4eIR9+SI4w1d55RxmvyDDIs+Vj9nljcw4Y+WT7GO6WF6/n2m5PAC3z26ROivG/QQsBQyXUtMeILFzJ6xr9icTiYtIWast2NEOqLzvV4RmWk82wCFEmyhW4FtOuVMgYupaziWDYAi7lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bKEuXDjB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4176ScPv025845;
	Wed, 7 Feb 2024 00:28:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707287318;
	bh=dPN8HYL6/Leds5zhIyEMYejbsYiwTQnRSCDFX8U4/yk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bKEuXDjBbYhl1UX7iaNcbA9qazN6HBLDzEzRpqwjfYq6eKctYd5psUaz4aYM7CBO0
	 iIWdvtO76tuSzzoSqG+CHP6B0D/8tDroMwTTMvH25f4hxEij+SrSo/Ueu1zC6YW0TI
	 oPFX4PRJZzNQ74otbMsON1EQsb/eGUFcgFqhDnoY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4176SciP029857
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 00:28:38 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 00:28:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 00:28:38 -0600
Received: from [10.249.128.48] ([10.249.128.48])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4176SUCx061775;
	Wed, 7 Feb 2024 00:28:31 -0600
Message-ID: <6994957a-9bc6-84fd-da05-d8fbc8356456@ti.com>
Date: Wed, 7 Feb 2024 11:58:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
To: Andrew Davis <afd@ti.com>, <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <andrzej.p@collabora.com>, <nicolas@ndufresne.ca>
References: <20240205114239.924697-1-devarsht@ti.com>
 <20240205114239.924697-2-devarsht@ti.com>
 <b98a3cb1-ad0d-4f7e-872e-b6381e57ec4a@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <b98a3cb1-ad0d-4f7e-872e-b6381e57ec4a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

Thanks for the review.

On 06/02/24 03:22, Andrew Davis wrote:
> On 2/5/24 5:42 AM, Devarsh Thakkar wrote:
>> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is 
>> implemented
>> as stateful V4L2 M2M driver.
>>
>> The device supports baseline encoding with two different quantization
>> tables and compression ratio as demanded.
>>
>> Minimum resolution supported is 64x64 and Maximum resolution supported is
>> 8192x8192.
>>
>> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
>> Link: https://www.ti.com/lit/pdf/spruj16
>>
>> Co-developed-by: David Huang <d-huang@ti.com>
>> Signed-off-by: David Huang <d-huang@ti.com>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: No change
>> V3:
>> - Add vendor specific compatible
>> - Update reg names
>> - Update clocks to 1
>> - Fix dts example with proper naming
>> V4:
>>   - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
>>   - Update commit message and title
>>   - Remove clock-names as only single clock
>>
>> Link to previous commit:
>> https://lore.kernel.org/all/20230816152210.4080779-2-devarsht@ti.com/
>> ---
>>   .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 80 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml 
>> b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> new file mode 100644
>> index 000000000000..085020cb9e61
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> @@ -0,0 +1,75 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Imagination E5010 JPEG Encoder
>> +
>> +maintainers:
>> +  - Devarsh Thakkar <devarsht@ti.com>
>> +
>> +description: |
>> +  The E5010 is a JPEG encoder from Imagination Technologies 
>> implemented on
>> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and 
>> YUV422
>> +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
>> +  8Kx8K resolution.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: ti,am62a-jpeg-enc
>> +          - const: img,e5010-jpeg-enc
>> +      - const: img,e5010-jpeg-enc
>> +
>> +  reg:
>> +    items:
>> +      - description: The E5010 core register region
>> +      - description: The E5010 mmu register region
>> +
>> +  reg-names:
>> +    items:
>> +      - const: core
>> +      - const: mmu
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
> 
> "resets" seems unused.
> 

resets is an optional property. The E5010 IP as such supports reset 
signal interface, but it is not mandatory to use it as IP also supports 
register based reset too.

Regards
Devarsh

> Andrew
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +      jpeg-encoder@fd20000 {
>> +          compatible = "img,e5010-jpeg-enc";
>> +          reg = <0x00 0xfd20000 0x00 0x100>,
>> +                <0x00 0xfd20200 0x00 0x200>;
>> +          reg-names = "core", "mmu";
>> +          clocks = <&k3_clks 201 0>;
>> +          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>> +          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +      };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8999497011a2..d0f8c46d3ce9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10461,6 +10461,11 @@ S:    Maintained
>>   F:    Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
>>   F:    drivers/auxdisplay/img-ascii-lcd.c
>> +IMGTEC JPEG ENCODER DRIVER
>> +M:    Devarsh Thakkar <devarsht@ti.com>
>> +S:    Supported
>> +F:    Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> +
>>   IMGTEC IR DECODER DRIVER
>>   S:    Orphan
>>   F:    drivers/media/rc/img-ir/
> 

