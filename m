Return-Path: <linux-kernel+bounces-6764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99BB819D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1802E1C2573C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E6421370;
	Wed, 20 Dec 2023 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nKc3wCmh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A321365;
	Wed, 20 Dec 2023 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703068855;
	bh=yxdr2wDLPdmFNUpT4t9Rg2dNzZa1R0tQMe3QdGqlyXg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nKc3wCmhLEun3qNedKeJslBGCJrJaaVylZOdZUcGG0amBvOOgmOF15atthRaWnJy0
	 Ycqx9UBr0bX4bIb9VwyLgheVyAhqpnxdhhlr2CW0hTdSCBz5GfiY7RHg4UZ29THzTx
	 Pi9KrzRqCZ13tap6puo3rJlBkwjXDk/f5jYo2tWLTeYKSR1RijWKKkl1eJ5sIRBZoS
	 dIbZ8tvM3Zm2/hBkwc3MDlwdkdGQZAibRXJAOfyI90yigEaY3ySicUSc81iW8HJAdj
	 DFvgDk2+HMxVJlqn+u5zWOoN9vHrtEWxcfhGXJ1lotRMGoaJtoYunpQdMwmH7YzOAp
	 VZGPKCauPkaJg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D903337810CD;
	Wed, 20 Dec 2023 10:40:54 +0000 (UTC)
Message-ID: <4117de24-75fd-4355-9ffb-7d1bc0167295@collabora.com>
Date: Wed, 20 Dec 2023 11:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eddie Hung <eddie.hung@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
 <c3d372f0-3d21-4500-96cd-9c88aaf5ce89@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c3d372f0-3d21-4500-96cd-9c88aaf5ce89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/23 08:38, Krzysztof Kozlowski ha scritto:
> On 20/12/2023 03:58, Chunfeng Yun wrote:
>> For Gen1 isoc-in endpoint on controller before about SSUSB IPM v1.6.0, it
>> still send out unexpected ACK after receiving a short packet in burst
>> transfer, this will cause an exception on connected device, specially for
>> a 4k camera.
>> Add a quirk property "rx-fifo-depth" to work around this hardware issue,
>> prefer to use 3k bytes;
>> The side-effect is that may cause performance drop about 10%, including
>> bulk transfer.
>>
>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>> v3: add fifo depth unit, change the value range from 0-3 to 1-4
>> v2: change 'mediatek,rxfifo-depth' to 'rx-fifo-depth'
>> ---
>>   .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
>> index e9644e333d78..9478b7031796 100644
>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
>> @@ -124,6 +124,18 @@ properties:
>>         defined in the xHCI spec on MTK's controller.
>>       default: 5000
>>   
>> +  rx-fifo-depth:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      It is a quirk used to work around Gen1 isoc-in endpoint transfer issue
>> +      that still send out unexpected ACK after device finish the burst transfer
>> +      with a short packet and cause an exception, specially on a 4K camera
>> +      device, it happens on controller before about IPM v1.6.0; the side-effect
>> +      is that may cause performance drop about 10%, include bulk transfer,
>> +      prefer to use 3 here. The unit is 1K bytes.
> 
> NAK. Read comments on previous submission.
> 
> Best regards,
> Krzysztof
> 

Chunfeng, I think the discussion was not clear for you, so I will try to give
you a different explanation: this should be expressed in bytes, so 1000, or 1024,
2048, 4096, etc, and not 1/2/3/4/5/n.

The driver shall then validate and map your bytes number to hardware register
value and subsequently write to the registers.

Cheers,
Angleo

