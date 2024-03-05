Return-Path: <linux-kernel+bounces-92777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD028725D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2CE1C22C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA21758F;
	Tue,  5 Mar 2024 17:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZsesKOzP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471915491;
	Tue,  5 Mar 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660504; cv=none; b=QtMP2Y3IJQ31ku6urkhKCGnsdL0ItflIFkjjroVNYaQCBuC70fi/MLhz0staVvbCqOrqTUsjOWrc9fOS5/Nzmg+SDlRnROOdnCccSt1xZO4E6S84YSGEE8bY3PDTVUzAVWMTmAIT7p47dg4cStxzNVfqKIuB+syFMCUHWqFmGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660504; c=relaxed/simple;
	bh=dEOcX7ts0CpeQ5mnGZH9/CVe2nv0JFPTsHKcVUs7UNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SdePfT35E2Y3RPP4PXtdHJ6u/LV1L83csgYkoK1GtGxHmLA0igG3efRI5eYoBWMvIiwOTSEpcdPp1SnviL4tJH/d0ufxs90/bucLOuidAzTtJKqDXR7P43TB0jmmr97El3yNCsgE/1+eobj/ny88oPfMuGRI+JZtstCxathJ2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZsesKOzP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425HfWMm027513;
	Tue, 5 Mar 2024 11:41:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709660492;
	bh=JCWjl0BkOxGw1vEMjrhJgcRX6D+KAW5pA9teZ2XhUwY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZsesKOzPCzNZi1kPpvs9r2axQCC131f1yEz6kNeMTb0LzaFZP2G+GoGk8B59b3d/N
	 fW+oPKreHFebvoI14+ow3ODVeqN4DfMraHrCpdqtyDIZe6lDlXY9RKuz8xRYfAX/hs
	 kLdEfWJPloA6ue+pIprHcH8x5819TL5boM/Qoky4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425HfW1D041037
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Mar 2024 11:41:32 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 11:41:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 11:41:31 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425HfVFd000416;
	Tue, 5 Mar 2024 11:41:31 -0600
Message-ID: <e7114cb4-e24f-4e78-a89f-4e2e2e704b8a@ti.com>
Date: Tue, 5 Mar 2024 11:41:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: hwinfo: ti,k3-socinfo: Add nvmem-cells
Content-Language: en-US
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
 <1fe44306-b507-4017-8f47-598a76d9dbee@ti.com>
 <44c5d664-e738-44b4-bafe-06f2e1fc1fe7@linaro.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <44c5d664-e738-44b4-bafe-06f2e1fc1fe7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/5/24 11:01 AM, Krzysztof Kozlowski wrote:
> On 05/03/2024 15:42, Andrew Davis wrote:
>> On 3/5/24 8:11 AM, Krzysztof Kozlowski wrote:
>>> On 05/03/2024 12:17, Markus Schneider-Pargmann wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On Tue, Mar 05, 2024 at 08:43:03AM +0100, Krzysztof Kozlowski wrote:
>>>>> On 04/03/2024 11:36, Markus Schneider-Pargmann wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Sat, Feb 17, 2024 at 03:25:30PM +0100, Krzysztof Kozlowski wrote:
>>>>>>> On 14/02/2024 10:31, Markus Schneider-Pargmann wrote:
>>>>>>>> Hi Rob,
>>>>>>>>
>>>>>>>> On Tue, Feb 06, 2024 at 06:43:05PM +0000, Rob Herring wrote:
>>>>>>>>> On Tue, Feb 06, 2024 at 03:37:09PM +0100, Markus Schneider-Pargmann wrote:
>>>>>>>>>> The information k3-socinfo requires is stored in an efuse area. This
>>>>>>>>>> area is required by other devices/drivers as well, so using nvmem-cells
>>>>>>>>>> can be a cleaner way to describe which information are used.
>>>>>>>>>>
>>>>>>>>>> If nvmem-cells are supplied, the address range is not required.
>>>>>>>>>> Cells chipvariant, chippartno and chipmanufacturer are introduced to
>>>>>>>>>> cover all required information.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>>>>>>>>> Reviewed-by: Andrew Davis <afd@ti.com>
>>>>>>>>>> ---
>>>>>>>>>>    .../bindings/hwinfo/ti,k3-socinfo.yaml        | 23 ++++++++++++++++++-
>>>>>>>>>>    1 file changed, 22 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>>>> index dada28b47ea0..f085b7275b7d 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
>>>>>>>>>> @@ -26,9 +26,24 @@ properties:
>>>>>>>>>>      reg:
>>>>>>>>>>        maxItems: 1
>>>>>>>>>>    
>>>>>>>>>> +  nvmem-cells:
>>>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>>>>>>>>> +
>>>>>>>>>> +  nvmem-cell-names:
>>>>>>>>>> +    items:
>>>>>>>>>> +      - const: chipvariant
>>>>>>>>>> +      - const: chippartno
>>>>>>>>>> +      - const: chipmanufacturer
>>>>>>>>>> +
>>>>>>>>>>    required:
>>>>>>>>>>      - compatible
>>>>>>>>>> -  - reg
>>>>>>>>>> +
>>>>>>>>>> +oneOf:
>>>>>>>>>> +  - required:
>>>>>>>>>> +      - reg
>>>>>>>>>> +  - required:
>>>>>>>>>> +      - nvmem-cells
>>>>>>>>>> +      - nvmem-cell-names
>>>>>>>>>>    
>>>>>>>>>>    additionalProperties: false
>>>>>>>>>>    
>>>>>>>>>> @@ -38,3 +53,9 @@ examples:
>>>>>>>>>>            compatible = "ti,am654-chipid";
>>>>>>>>>>            reg = <0x43000014 0x4>;
>>>>>>>>>>        };
>>>>>>>>>> +  - |
>>>>>>>>>> +    chipid: chipid@14 {
>>>>>>>>>> +        compatible = "ti,am654-chipid";
>>>>>>>>>
>>>>>>>>> This isn't compatible if you have a completely different way to access
>>>>>>>>> it.
>>>>>>>>
>>>>>>>> Thanks, it is not entirely clear to me how I could go forward with this?
>>>>>>>> Are you suggesting to use a different compatible? Or is it something
>>>>>>>> else I could do to proceed with this conversion?
>>>>>>>
>>>>>>> What you claim now, is that you have one device with entirely different
>>>>>>> interfaces and programming model. So either this is not the same device
>>>>>>> or you just wrote bindings to whatever you have in driver.
>>>>>>>
>>>>>>> Nothing in commit msg explains this.
>>>>>>>
>>>>>>> What you should do? Depends. If you just write bindings for driver, then
>>>>>>> stop. It's a NAK. Instead write bindings for hardware.
>>>>>>>
>>>>>>> If the first choice, just the hardware is somehow like this, then
>>>>>>> explain in commit msg and device description, how this device can be
>>>>>>> connected over other bus, not MMIO. You can draw some schematics in
>>>>>>> commit msg explaining architecture etc.
>>>>>>
>>>>>> Sorry the information provided in the commit message is not very clear.
>>>>>>
>>>>>> The basic access to the registes is still MMIO. nvmem is used to have a
>>>>>> better abstraction and cleaner description of the hardware.
>>>>>>
>>>>>> Currently most of the data is exported using the parent syscon device.
>>>>>> The relevant data is read-only and contained in a single register with
>>>>>> offset 0x14:
>>>>>>     - Chip variant
>>>>>>     - Chip part number
>>>>>>     - Chip manufacturer
>>>>>>
>>>>>> There are more read-only registers in this section of address space.
>>>>>> These are relevant to other components as they define the operating
>>>>>> points for example. For the OPP table relevant are chip variant and chip
>>>>>> speed (which is in a different register).
>>>>>>
>>>>>> Instead of devices refering to this whole register range of 0x20000 in
>>>>>
>>>>> Whaaaaat?
>>>>>
>>>>>> size, I would like to introduce this nvmem abstraction in between that
>>>>>> describes the information and can directly be referenced by the devices
>>>>>> that depend on it. In this case the above mentioned register with offset
>>>>>> 0x14 is instead described as nvmem-layout like this:
>>>>>>
>>>>>> 	nvmem-layout {
>>>>>> 		compatible = "fixed-layout";
>>>>>> 		#address-cells = <1>;
>>>>>> 		#size-cells = <1>;
>>>>>>
>>>>>> 		chip_manufacturer: jtagidmfg@14 {
>>>>>> 			reg = <0x14 0x2>;
>>>>>> 			bits = <1 11>;
>>>>>> 		};
>>>>>>
>>>>>> 		chip_partno: jtagidpartno@15 {
>>>>>> 			reg = <0x15 0x3>;
>>>>>> 			bits = <4 16>;
>>>>>> 		};
>>>>>>
>>>>>> 		chip_variant: jtagidvariant@17 {
>>>>>> 			reg = <0x17 0x1>;
>>>>>> 			bits = <4 4>;
>>>>>> 		};
>>>>>>
>>>>>> 		chip_speed: jtaguseridspeed@18 {
>>>>>> 			reg = <0x18 0x4>;
>>>>>> 			bits = <6 5>;
>>>>>> 		};
>>>>>>
>>>>>> The underlying registers are still the same but they are not hidden
>>>>>> by the syscon phandles anymore.
>>>>>>
>>>>>> The device that consumes this data would now use
>>>>>>
>>>>>> 	nvmem-cells = <&chip_variant>, <&chip_speed>;
>>>>>> 	nvmem-cell-names = "chipvariant", "chipspeed";
>>>>>>
>>>>>> instead of
>>>>>>
>>>>>> 	syscon = <&wkup_conf>;
>>>>>
>>>>> syscon allows you this as well - via phandle arguments.
>>>>>
>>>>> nvmem is for non-volatile memory, like OCOTP and eFUSE. This is not for
>>>>> accessing regular MMIO registers of system-controller, regardless
>>>>> whether they are read-only or not (regmap handles this nicely, BTW).
>>>>> Although probably Apple efuses and few others can confuse here. It still
>>>>> looks like you convert regular system-controller block into nvmem,
>>>>> because you prefer that Linux driver abstraction...
>>>>
>>>> The above mentioned data is set in the factory. There is other
>>>> non-volatile data, like device feature registers, in the same address
>>>> region, as well as OTP data like MAC and USB IDs. But it is not a pure
>>>> non-volatile memory region. The data is copied into these registers by
>>>> the ROM at boot.
>>>
>>> Still entire block is MMIO IP in your SoC, not a efuse/OTP hardware.
>>> nvmem is not for regular MMIO registers which are sometimes R, sometimes RW.
>>
>> Most eFuse/OTP hardware is accessed via MMIO, not sure what that changes.
> 
> Just check exiting NVMEM drivers, except Apple I think most if not all
> are not syscon blocks.
> 

We don't want it to be a syscon block either. Syscon is just another Linux
interface for accessing MMIO areas that found its way in to DT. NVMEM
is another way, which as a DT construct is more "correct" as the area
we are describing here *is* a non-volatile memory. Not a "syscon"?? whatever
that is.

> Following such approach, each hardware block, even USB or PCI, which
> exposes a read-only register with some fused value, e.g. version, should
> be nvmem?
> 

If those fused values are grouped into a region then yes, why not. Wouldn't
that be more correct to describe them as they actually are instead of
hiding them behind a "syscon" block?

>>
>> This "block" is a whole bunch of smaller logical chunks of registers,
>> some are actually mapped to eFuses like our MAC addresses. Regions
>> like factory fused MAC addresses are exactly what nvmem does well[0].
>>
>> Yes, we *could* just have this whole area be one massive blanked syscon
>> region that every driver just manually pokes into with syscon phandles
>> everywhere. But that is hacky and hides details, it is not how DT normally
>> looks. We would like to correctly model our device now with nodes for each
>> "reg" region. We took the syscon shortcut before, and we want to correct
>> that mistake.
> 
> Wait, you now mix up hardware description with Linux interface.
> Describing each register as nvmem field is not a better way of
> describing hardware. It is unnecessarily too granular and results in
> huge and unmaintainable DTS. It is however convenient because it is nice
> API for other devices. 

It is not convenient. How we have it currently as a blanket syscon node
that each driver can simply poke whatever address it wants is much easier.
We are now trying to do the more difficult (but more correct) thing here by
modeling our non-volatile memory areas as they are as nvmem nodes.

> But claiming that MMIO register block is better
> represented as nvmem is not correct. It is still MMIO block with
> registers, like everywhere else in every other device.
> 

Everything is MMIO on these SoCs, we don't have any sideband band
IO ports. Following that to its logical conclusion we should just
make the entire memory space reg = <0x0 0xffffffff> one big syscon node
then have all other driver phandle into that for their MMIO access.

>>
>> So what are our options? Is the objection here that this is a new nvmem
>> way of modeling this region changes the compatible "ti,am654-chipid"? If
>> so then would you be open to us adding a new compatible that uses the
>> nvmem nodes? We could then convert over one by one and keeping full
>> backwards compatibility while we do it.
> 
> Switching from MMIO to nvmem for chipid is a different interface, so as
> Rob pointed out devices are not really compatible. You claim that
> devices are compatible, because there is *NO REAL NVMEM* but MMIO
> wrapped in nvmem. So do you see the logic here?
> 

If the interface changing means it is not compatible then that is
fine, we would use a different compatible string to identify the
interface to be used.

This is not uncommon, the example that comes to my mind is "gpio-leds".
We used to just have named GPIO pins for our LEDs, now we can
put "gpio-leds" on top to better represent what is going on in HW.
Even though physically nothing changed, we just now have a better way
to model that HW in DT.

Andrew

> Best regards,
> Krzysztof
> 
> 

