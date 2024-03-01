Return-Path: <linux-kernel+bounces-88709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5240786E5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66091F26710
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9755879E2;
	Fri,  1 Mar 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q1PCh+MO"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F983FDC;
	Fri,  1 Mar 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310753; cv=none; b=hS5KbHCqG961mvZe53cfVnSjO48dIIYnD07rJRg2FLdLpFsWm9WsiDryoyUsrQLXIb0ZbVZYIp5FSF53nTlPmIutIlHpfW/KeVF7h2PnkFmW1HkfFU3phoPDjEHd27J3eegOnBomHcMp3Xebkn/+Dp1gZaJ7D6Ht852DJgPoS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310753; c=relaxed/simple;
	bh=XyxMUOWRCr05XpfJyPDBVL+KWHm9XPrcyRo1t+9KIv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JngypBkUmbVuLTC8TO2BxDwoCxs46va6Xzt35Bdae9WYaMXAF0FcGoPqQBXmkvW/13r/RYavIxdTw2YiWVjtQLM9YezsSPUmpY2dfUgMfDDKC87Z6R7Z3S6dJYTPCkf7ATuB1OES8TqDrldOnUebmhW2kBZbDpzkLf3BcoEk3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q1PCh+MO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 421GWBbF072770;
	Fri, 1 Mar 2024 10:32:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709310731;
	bh=+kWCT/YztkXZashp8t8cNtiEodOKyDTatSusbK1sHQo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Q1PCh+MOt0XB1rkuwp72Bky0zeSAygNlceeuUcObCQwlq8iTFPyA0gcKAYCYRitzC
	 AWaZ345TA+BymfM2cNNW780oDob45eElnh/heeGzw47FjRArT2kCbxLiJuapDHX4eW
	 x7O3dGpMGaMXcOXeWM94AnaV7ryfY3QjlMx3yBCM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 421GWBZW005837
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Mar 2024 10:32:11 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Mar 2024 10:32:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Mar 2024 10:32:11 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 421GW4k5051965;
	Fri, 1 Mar 2024 10:32:04 -0600
Message-ID: <eff7080b-42e9-19ae-6022-bfbcc337b4a0@ti.com>
Date: Fri, 1 Mar 2024 22:02:03 +0530
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
 <7a83fe91-5afa-6aee-a8a4-44f6e3d713c2@ti.com>
 <20240229133046.64h2f4n27emvdhnq@basti-XPS-13-9310>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240229133046.64h2f4n27emvdhnq@basti-XPS-13-9310>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Sebastian,

On 29/02/24 19:00, Sebastian Fricke wrote:
> Hey Devarsh,
> 
> On 29.02.2024 16:50, Devarsh Thakkar wrote:
>> Hi Sebastian,
>>
>> Thanks for the review.
>>
>> On 29/02/24 15:56, Sebastian Fricke wrote:
>>> Hey Devarsh,
>>>
>>> On 28.02.2024 19:41, Devarsh Thakkar wrote:
>>>> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
>>>> as stateful V4L2 M2M driver.
>>>>
>>>> The device supports baseline encoding with two different quantization
>>>> tables and compression ratio as demanded.
>>>>
>>>> Minimum resolution supported is 64x64 and Maximum resolution supported is
>>>> 8192x8192.
>>>>
>>>> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
>>>> Link: https://www.ti.com/lit/pdf/spruj16
>>>>
>>>> Co-developed-by: David Huang <d-huang@ti.com>
>>>> Signed-off-by: David Huang <d-huang@ti.com>
>>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>
>>> hmmm when did Rob give his reviewed by on this patch? (As this is not a
>>> DT binding I find that odd)
>>
>> [PATCH v6 1/3] media: dt-bindings: Add Imagination E5010 JPEG Encoder : This
>> is indeed the dt-binding patch. Also As shared in version history it is at V4
>> where Rob Herring added a Reviewed-By as seen here [0]
>>
>>> And where is the Reviewed by tag from Benjamin that he provided on V5?
>>>
>>
>> As captured in patch version history here [1] I thought to remove the
>> Reviewed-By since the Reviewed-By tag was on V5 and with V6 the driver got
>> updated with some changes to handle reported sparse warnings and so I have
>> asked Benjamin to check the range-diff and help with a quick review again if
>> possible.
>>
>> Kindly let me know if I missed something or anything needs to be done from
>> my end.
> 
> Yes thanks I was a bit too swift to write here, sorry for the noise.
> We'll have a look.
> 

Sorry for the back and forth, but on the hindsight and re-looking at the
kernel patch guidelines [0] they suggest that Reviewed-By tag should only be
removed if substantial changes were made in further revisions.

So looks to me in-fact it was a mistake on my part to remove the Reviewed-by
considering the change made in the following patch series was not a
substantial one as seen in the range-diff [1].

Considering this, just wanted to check with you if it's possible for you to
consider the Reviewed-by tag :
`Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com`
if it helps consolidate things faster to get this series in given we are close
to final RC's ?

[0]:
https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes:~:text=changed%20substantially

[1]: https://gist.github.com/devarsht/c89180ac2b0d2814614f2b59d0705c19

Regards
Devarsh

> 
> Greetings,
> Sebastian
> 
>>
>> [0] :
>> https://lore.kernel.org/all/170716378412.295212.11603162949482063011.robh@kernel.org/
>> [1] : https://lore.kernel.org/all/20240228141140.3530612-4-devarsht@ti.com/
>>
>>
>> Regards
>> Devarsh
>>>> ---
>>>> V2: No change
>>>> V3:
>>>> - Add vendor specific compatible
>>>> - Update reg names
>>>> - Update clocks to 1
>>>> - Fix dts example with proper naming
>>>> V4:
>>>> - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
>>>> - Update commit message and title
>>>> - Remove clock-names as only single clock
>>>> V5:
>>>> - Add Reviewed-By tag
>>>> V6:
>>>> - No change
>>>>
>>>> .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
>>>> MAINTAINERS                                   |  5 ++
>>>> 2 files changed, 80 insertions(+)
>>>> create mode 100644
>>>> Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>> b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>> new file mode 100644
>>>> index 000000000000..085020cb9e61
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>> @@ -0,0 +1,75 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Imagination E5010 JPEG Encoder
>>>> +
>>>> +maintainers:
>>>> +  - Devarsh Thakkar <devarsht@ti.com>
>>>> +
>>>> +description: |
>>>> +  The E5010 is a JPEG encoder from Imagination Technologies implemented on
>>>> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
>>>> +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
>>>> +  8Kx8K resolution.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: ti,am62a-jpeg-enc
>>>> +          - const: img,e5010-jpeg-enc
>>>> +      - const: img,e5010-jpeg-enc
>>>> +
>>>> +  reg:
>>>> +    items:
>>>> +      - description: The E5010 core register region
>>>> +      - description: The E5010 mmu register region
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: core
>>>> +      - const: mmu
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - reg-names
>>>> +  - interrupts
>>>> +  - clocks
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +
>>>> +    soc {
>>>> +      #address-cells = <2>;
>>>> +      #size-cells = <2>;
>>>> +      jpeg-encoder@fd20000 {
>>>> +          compatible = "img,e5010-jpeg-enc";
>>>> +          reg = <0x00 0xfd20000 0x00 0x100>,
>>>> +                <0x00 0xfd20200 0x00 0x200>;
>>>> +          reg-names = "core", "mmu";
>>>> +          clocks = <&k3_clks 201 0>;
>>>> +          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>>>> +          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>>>> +      };
>>>> +    };
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e1475ca38ff2..6b34ee8d92b5 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -10572,6 +10572,11 @@ S:    Maintained
>>>> F:    Documentation/devicetree/bindings/auxdisplay/img,ascii-lcd.yaml
>>>> F:    drivers/auxdisplay/img-ascii-lcd.c
>>>>
>>>> +IMGTEC JPEG ENCODER DRIVER
>>>> +M:    Devarsh Thakkar <devarsht@ti.com>
>>>> +S:    Supported
>>>> +F:    Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>> +
>>>> IMGTEC IR DECODER DRIVER
>>>> S:    Orphan
>>>> F:    drivers/media/rc/img-ir/
>>>> -- 
>>>> 2.39.1
>>>>

