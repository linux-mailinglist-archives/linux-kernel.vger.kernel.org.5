Return-Path: <linux-kernel+bounces-86621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D686A86C7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CD41C2111E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986D7B3F5;
	Thu, 29 Feb 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M4bEXrYR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9864A9B;
	Thu, 29 Feb 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205663; cv=none; b=IwCO5emBoflFXdn0MkPmdchxJVLeiSTwovXDkqXd41s6r+Rt4UxomvHLlSuOn6CvCtwxCNdIGzUsgismmaZ3bclexQwyOkgumke8pWY7xUIQ0jLl1WvApT81c+/qRJNyEWL31hOyqfwiCnrUBeUh/MZVh6yZVEJtc9xb3jhygIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205663; c=relaxed/simple;
	bh=HdspKmySgyiroiAYzlGt40P665iw545abFyHhuJz8ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TErbFDRQz5axjEZ6Njr+lX1uvcCbx3o8gB0jT5rBlpcfAbAejjlUHd+b0NfP2LNXimqGwG7hVtjie5IoI47dFmu6owxxmqZdE65t6CmKEvwxkxmgVHvUlC2+lk0+O+B2TLxJ/qvlnhx2WkmE5t2HI3aeKjlDVSqN0aIWRbFX22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M4bEXrYR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41TBKkkF004012;
	Thu, 29 Feb 2024 05:20:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709205646;
	bh=JkBFq8xJSuzGW0iZAfO9iPQEBKS1+WYKIh8tLyGsD/U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=M4bEXrYRbmrT8Yz7WDTSLjU3A7XnJrLeijIQ6bSBP+9x6t15iQcBEjL8u0xd8gQAb
	 R8Pywsp9MykZQKw7A2nbUc+8/UhrG+bl4gZam6EWbNpngiqC0NG6Tzk8s4tlLXh+Ku
	 DblSv+a1Mv+U21dKgpkcPw2acOyPUcPYlMcK3Udc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41TBKkh6043592
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Feb 2024 05:20:46 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Feb 2024 05:20:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Feb 2024 05:20:46 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41TBKd19112484;
	Thu, 29 Feb 2024 05:20:40 -0600
Message-ID: <7a83fe91-5afa-6aee-a8a4-44f6e3d713c2@ti.com>
Date: Thu, 29 Feb 2024 16:50:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
Content-Language: en-US
To: Sebastian Fricke <sebastian.fricke@collabora.com>
CC: <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@collabora.com>, <laurent.pinchart@ideasonboard.com>,
        <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <b-brnich@ti.com>, <detheridge@ti.com>,
        <p-mantena@ti.com>, <vijayp@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>, <afd@ti.com>, <milkfafa@gmail.com>
References: <20240228141140.3530612-1-devarsht@ti.com>
 <20240228141140.3530612-2-devarsht@ti.com>
 <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240229102623.ihwhbba4qwzvxzzq@basti-XPS-13-9310>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sebastian,

Thanks for the review.

On 29/02/24 15:56, Sebastian Fricke wrote:
> Hey Devarsh,
> 
> On 28.02.2024 19:41, Devarsh Thakkar wrote:
>> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
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
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> hmmm when did Rob give his reviewed by on this patch? (As this is not a
> DT binding I find that odd)

[PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG Encoder : This
is indeed the dt-binding patch. Also As shared in version history it is at V4
where Rob Herring added a Reviewed-By as seen here [0]

> And where is the Reviewed by tag from Benjamin that he provided on V5?
> 

As captured in patch version history here [1] I thought to remove the
Reviewed-By since the Reviewed-By tag was on V5 and with V6 the driver got
updated with some changes to handle reported sparse warnings and so I have
asked Benjamin to check the range-diff and help with a quick review again if
possible.

Kindly let me know if I missed something or anything needs to be done from my end.

[0] :
https://lore.kernel.org/all/170716378412.295212.11603162949482063011.robh@kernel.org/
[1] : https://lore.kernel.org/all/20240228141140.3530612-4-devarsht@ti.com/


Regards
Devarsh

> Greetings,
> Sebastian
> 
>> ---
>> V2: No change
>> V3:
>> - Add vendor specific compatible
>> - Update reg names
>> - Update clocks to 1
>> - Fix dts example with proper naming
>> V4:
>> - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
>> - Update commit message and title
>> - Remove clock-names as only single clock
>> V5:
>> - Add Reviewed-By tag
>> V6:
>> - No change
>>
>> .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
>> MAINTAINERS                                   |  5 ++
>> 2 files changed, 80 insertions(+)
>> create mode 100644
>> Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
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
>> +  The E5010 is a JPEG encoder from Imagination Technologies implemented on
>> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
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
>> index e1475ca38ff2..6b34ee8d92b5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10572,6 +10572,11 @@ S:    Maintained
>> F:    Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
>> F:    drivers/auxdisplay/img-ascii-lcd.c
>>
>> +IMGTEC JPEG ENCODER DRIVER
>> +M:    Devarsh Thakkar <devarsht@ti.com>
>> +S:    Supported
>> +F:    Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> +
>> IMGTEC IR DECODER DRIVER
>> S:    Orphan
>> F:    drivers/media/rc/img-ir/
>> -- 
>> 2.39.1
>>

