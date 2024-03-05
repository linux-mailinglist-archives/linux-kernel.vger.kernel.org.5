Return-Path: <linux-kernel+bounces-92535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB618721CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1428B086
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F686AD4;
	Tue,  5 Mar 2024 14:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R99UqG6Q"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638E8663A;
	Tue,  5 Mar 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649791; cv=none; b=ClpreLiwP85FjMzPKmCMP/Gr76XpbmPymvJVJB+13gj/3ldXwSJg5Ntk28z9wv2rYhrIa+whx1BOVUuIwMLlCbDtVcw7+PIu/v/jbsCzdDg7+t9hWhHMjHST5+8ssBZQ9KXs7M+CKpEqWNDwX9gGxUzRgmlrCYQpiGllTUhYnNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649791; c=relaxed/simple;
	bh=/PhlOnmbeHoBdA1OxTwHCaySbDcZFamjy5RrHUoJbVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QhngjWsT1TsU9p3JKoPFXSsooA5JTYOzJDfrUri78XaY7YeTRy7qyph6j6Qz0loxbqorKSz64l5W11xz+aLyI53BG1MFLgbR1uiQGqiGwUQwoMBuj+f3/hajDF68O0YOJbECl8Ir+rGyTbuPYkILcQ9wOAEPpZ7Pk94cHVJoikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R99UqG6Q; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425EgwqH115585;
	Tue, 5 Mar 2024 08:42:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709649778;
	bh=AKhuDWIm1BPr27gwl174Fb5zsGzliY8/tG4oNFZpEp4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R99UqG6Qxvk50QEyvsofdsFZevatbPcW6izpcrVAl2VcTwxxh8UcAkJwxHvZ8NcK3
	 Hlf87106eRLLHe0EzaNtxRIUEqUQqu/c+za1LkyGPpG/Q8P/FvoVB4tI/jSIftar3q
	 A6K6ojr+ZxsFPWYSj0i3UOlMuZgsCFslgnjjdCp0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425EgwjP030270
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Mar 2024 08:42:58 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 08:42:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 08:42:57 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425Egv2K130222;
	Tue, 5 Mar 2024 08:42:57 -0600
Message-ID: <1fe44306-b507-4017-8f47-598a76d9dbee@ti.com>
Date: Tue, 5 Mar 2024 08:42:57 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Markus
 Schneider-Pargmann <msp@baylibre.com>
CC: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240206143711.2410135-1-msp@baylibre.com>
 <20240206143711.2410135-3-msp@baylibre.com>
 <20240206184305.GA1875492-robh@kernel.org>
 <z56fiu2jpokp57sjvnrdcbfy7brpq2ag4yxpektqlhtidecx4n@vc7dsurhxorb>
 <cb75c098-521e-4eed-bc3e-7237f8a6498f@linaro.org>
 <ut63wrhsewkpfdgaatd6hqmj5upvyamjhf2rsecju2v2o3hdod@kyi5sezcggl7>
 <48902771-5d3b-448a-8a74-ac18fb4f1a86@linaro.org>
 <sowpixx2u4d5alj4udzr3qt47zevylukhpwkw3pfwnogqjse5w@xrxcozzvog6v>
 <620a2dca-1901-43d4-8b2b-7ae823705a6e@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <620a2dca-1901-43d4-8b2b-7ae823705a6e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/5/24 8:11 AM, Krzysztof Kozlowski wrote:
> On 05/03/2024 12:17, Markus Schneider-Pargmann wrote:
>> Hi Krzysztof,
>>
>> On Tue, Mar 05, 2024 at 08:43:03AM +0100, Krzysztof Kozlowski wrote:
>>> On 04/03/2024 11:36, Markus Schneider-Pargmann wrote:
>>>> Hi,
>>>>
>>>> On Sat, Feb 17, 2024 at 03:25:30PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 14/02/2024 10:31, Markus Schneider-Pargmann wrote:
>>>>>> Hi Rob,
>>>>>>
>>>>>> On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
>>>>>>> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
>>>>>>>> The information k3-socinfo requires is stored in an efuse area. This
>>>>>>>> area is required by other devices/drivers as well, so using nvmem-cells
>>>>>>>> can be a cleaner way to describe which information are used.
>>>>>>>>
>>>>>>>> If nvmem-cells are supplied, the address range is not required.
>>>>>>>> Cells chipvariant, chippartno and chipmanufacturer are introduced to
>>>>>>>> cover all required information.
>>>>>>>>
>>>>>>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>>>>>>> Reviewed-by: Andrew Davis <afd@ti.com>
>>>>>>>> ---
>>>>>>>>   .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>>>>>>>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>> index dada28b47ea0..f085b7275b7d 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>> @@ -26,9 +26,24 @@ properties:
>>>>>>>>     reg:
>>>>>>>>       maxItems: 1
>>>>>>>>   
>>>>>>>> +  nvmem-cells:
>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>>>> +
>>>>>>>> +  nvmem-cell-names:
>>>>>>>> +    items:
>>>>>>>> +      - const: chipvariant
>>>>>>>> +      - const: chippartno
>>>>>>>> +      - const: chipmanufacturer
>>>>>>>> +
>>>>>>>>   required:
>>>>>>>>     - compatible
>>>>>>>> -  - reg
>>>>>>>> +
>>>>>>>> +oneOf:
>>>>>>>> +  - required:
>>>>>>>> +      - reg
>>>>>>>> +  - required:
>>>>>>>> +      - nvmem-cells
>>>>>>>> +      - nvmem-cell-names
>>>>>>>>   
>>>>>>>>   additionalProperties: false
>>>>>>>>   
>>>>>>>> @@ -38,3 +53,9 @@ examples:
>>>>>>>>           compatible = "ti,am654-chipid";
>>>>>>>>           reg = <0x43000014 0x4>;
>>>>>>>>       };
>>>>>>>> +  - |
>>>>>>>> +    chipid: chipid@14 {
>>>>>>>> +        compatible = "ti,am654-chipid";
>>>>>>>
>>>>>>> This isn't compatible if you have a completely different way to access
>>>>>>> it.
>>>>>>
>>>>>> Thanks, it is not entirely clear to me how I could go forward with this?
>>>>>> Are you suggesting to use a different compatible? Or is it something
>>>>>> else I could do to proceed with this conversion?
>>>>>
>>>>> What you claim now, is that you have one device with entirely different
>>>>> interfaces and programming model. So either this is not the same device
>>>>> or you just wrote bindings to whatever you have in driver.
>>>>>
>>>>> Nothing in commit msg explains this.
>>>>>
>>>>> What you should do? Depends. If you just write bindings for driver, then
>>>>> stop. It's a NAK. Instead write bindings for hardware.
>>>>>
>>>>> If the first choice, just the hardware is somehow like this, then
>>>>> explain in commit msg and device description, how this device can be
>>>>> connected over other bus, not MMIO. You can draw some schematics in
>>>>> commit msg explaining architecture etc.
>>>>
>>>> Sorry the information provided in the commit message is not very clear.
>>>>
>>>> The basic access to the registes is still MMIO. nvmem is used to have a
>>>> better abstraction and cleaner description of the hardware.
>>>>
>>>> Currently most of the data is exported using the parent syscon device.
>>>> The relevant data is read-only and contained in a single register with
>>>> offset 0x14:
>>>>    - Chip variant
>>>>    - Chip part number
>>>>    - Chip manufacturer
>>>>
>>>> There are more read-only registers in this section of address space.
>>>> These are relevant to other components as they define the operating
>>>> points for example. For the OPP table relevant are chip variant and chip
>>>> speed (which is in a different register).
>>>>
>>>> Instead of devices refering to this whole register range of 0x20000 in
>>>
>>> Whaaaaat?
>>>
>>>> size, I would like to introduce this nvmem abstraction in between that
>>>> describes the information and can directly be referenced by the devices
>>>> that depend on it. In this case the above mentioned register with offset
>>>> 0x14 is instead described as nvmem-layout like this:
>>>>
>>>> 	nvmem-layout {
>>>> 		compatible = "fixed-layout";
>>>> 		#address-cells = <1>;
>>>> 		#size-cells = <1>;
>>>>
>>>> 		chip_manufacturer: jtagidmfg@14 {
>>>> 			reg = <0x14 0x2>;
>>>> 			bits = <1 11>;
>>>> 		};
>>>>
>>>> 		chip_partno: jtagidpartno@15 {
>>>> 			reg = <0x15 0x3>;
>>>> 			bits = <4 16>;
>>>> 		};
>>>>
>>>> 		chip_variant: jtagidvariant@17 {
>>>> 			reg = <0x17 0x1>;
>>>> 			bits = <4 4>;
>>>> 		};
>>>>
>>>> 		chip_speed: jtaguseridspeed@18 {
>>>> 			reg = <0x18 0x4>;
>>>> 			bits = <6 5>;
>>>> 		};
>>>>
>>>> The underlying registers are still the same but they are not hidden
>>>> by the syscon phandles anymore.
>>>>
>>>> The device that consumes this data would now use
>>>>
>>>> 	nvmem-cells = <&chip_variant>, <&chip_speed>;
>>>> 	nvmem-cell-names = "chipvariant", "chipspeed";
>>>>
>>>> instead of
>>>>
>>>> 	syscon = <&wkup_conf>;
>>>
>>> syscon allows you this as well - via phandle arguments.
>>>
>>> nvmem is for non-volatile memory, like OCOTP and eFUSE. This is not for
>>> accessing regular MMIO registers of system-controller, regardless
>>> whether they are read-only or not (regmap handles this nicely, BTW).
>>> Although probably Apple efuses and few others can confuse here. It still
>>> looks like you convert regular system-controller block into nvmem,
>>> because you prefer that Linux driver abstraction...
>>
>> The above mentioned data is set in the factory. There is other
>> non-volatile data, like device feature registers, in the same address
>> region, as well as OTP data like MAC and USB IDs. But it is not a pure
>> non-volatile memory region. The data is copied into these registers by
>> the ROM at boot.
> 
> Still entire block is MMIO IP in your SoC, not a efuse/OTP hardware.
> nvmem is not for regular MMIO registers which are sometimes R, sometimes RW.

Most eFuse/OTP hardware is accessed via MMIO, not sure what that changes.

This "block" is a whole bunch of smaller logical chunks of registers,
some are actually mapped to eFuses like our MAC addresses. Regions
like factory fused MAC addresses are exactly what nvmem does well[0].

Yes, we *could* just have this whole area be one massive blanked syscon
region that every driver just manually pokes into with syscon phandles
everywhere. But that is hacky and hides details, it is not how DT normally
looks. We would like to correctly model our device now with nodes for each
"reg" region. We took the syscon shortcut before, and we want to correct
that mistake.

So what are our options? Is the objection here that this is a new nvmem
way of modeling this region changes the compatible "ti,am654-chipid"? If
so then would you be open to us adding a new compatible that uses the
nvmem nodes? We could then convert over one by one and keeping full
backwards compatibility while we do it.

Thanks,
Andrew

[0] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml#L16

> 
> Best regards,
> Krzysztof
> 
> 

