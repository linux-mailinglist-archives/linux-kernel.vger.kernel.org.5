Return-Path: <linux-kernel+bounces-50501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473B8479F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1731C22BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B180633;
	Fri,  2 Feb 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="F2PNnK/d"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4A8061F;
	Fri,  2 Feb 2024 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903592; cv=none; b=nwOvG5ap1f7k7sLCb3QIa9p19+PMC0WcpNT/NeD2cBHQXRomfxUo3hU6MNM8I2ewLua86pjdSxWnkVgNK9dlXOy6Y0g2g0RRiBKMnltQUHbE23UvAAoFXBX5IrZXjcAT7JpBisthXtCV+3h10Y0BFBN8UYA2b64fcJhcNe+0gJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903592; c=relaxed/simple;
	bh=Cx6EG8vypPzndLS7Ci2U+EWqhOBaSrbMRb5+d5MjE6I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=e+uITd0vRg5KLERTNO1u9v/SrlsdrT/b67Mj6QcU38tcqTS667PHq8+74wPocI0EdWvFLmfxP55836oBwd4vTr7pbbXbbqo6cHFmPUUaRj/Tdn43QIQg0loH/eL1Wb1746wa+nc61DKYKJKlbllQwTiuXDSYpfpCZZsPy0L+ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=F2PNnK/d; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C76729C162B;
	Fri,  2 Feb 2024 14:53:00 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id rkkg6uFupPcq; Fri,  2 Feb 2024 14:53:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0D8899C427E;
	Fri,  2 Feb 2024 14:53:00 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0D8899C427E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706903580; bh=4J2a0QDfP718AuLxSl1uhB7/kdY3eNQeApKcDVE9S54=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=F2PNnK/dsBbkjCtf5H2Lp6KgituxClJLhXm03ci6+bOq0PXrvkcd/BYeyDPQebno9
	 S9IHEGOzikotcsKqf2shrU4IbMJVH6j12c2MDtxUDT+rdRgxk6TBseFnXQ6xnMCAPZ
	 +BfWeS0IhU/qCTR/lgDQxPHU50ACI8WGRd/fXTD1YCg4m4KH0U1lUsopj+YwmbPbw7
	 wTn3HaeVhD0zyLDKv7WHL7cA+Rjx4BDmbhYpEpZCj7Qb+WaZ1u2bCcksmLSKgNlcAE
	 RW+rqM0uSxQWlf4djF+Djz11YiwuQOUchVqMTLjOeOTI4HufnkUKAk6hZHG/f+neVR
	 BFeyXha/Q84Fg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 59U-PZUrHrqJ; Fri,  2 Feb 2024 14:52:59 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BC1499C162B;
	Fri,  2 Feb 2024 14:52:59 -0500 (EST)
Date: Fri, 2 Feb 2024 14:52:59 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <689519725.467683.1706903579718.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <4e9360cf-2952-45e9-8c85-caa4c0d92175@linaro.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-1-charles.perry@savoirfairelinux.com> <20240131230542.3993409-3-charles.perry@savoirfairelinux.com> <d5fe1ec2-b647-4902-a599-fb866e96e9cf@linaro.org> <1391244934.434321.1706811892834.JavaMail.zimbra@savoirfairelinux.com> <4e9360cf-2952-45e9-8c85-caa4c0d92175@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Thread-Index: IIdIVNrNF28klyCh7vYGkBY0dXzlUw==


----- On Feb 2, 2024, at 5:49 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:

> On 01/02/2024 19:24, Charles Perry wrote:
>> 
>> 
>> ----- On Feb 1, 2024, at 3:07 AM, Krzysztof Kozlowski
>> krzysztof.kozlowski@linaro.org wrote:
>> 
>>> On 01/02/2024 00:05, Charles Perry wrote:
>>>> Document the slave SelectMAP interface of Xilinx 7 series FPGA.
>>>>
>>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>>> ---
>>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 83 +++++++++++++++++++
>>>>  1 file changed, 83 insertions(+)
>>>>  create mode 100644
>>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> new file mode 100644
>>>> index 0000000000000..c9a446b43cdd9
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>> @@ -0,0 +1,83 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Xilinx SelectMAP FPGA interface
>>>> +
>>>> +maintainers:
>>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>>> +
>>>> +description: |
>>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>>> +
>>>> +  Datasheets:
>>>> +
>>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - xlnx,fpga-selectmap
>>>
>>> Your description mentions "7 Series" which is not present in compatible
>>> and title. What is exactly the product here? Interface usually is not
>>> the final binding, so is this specific to some particular FPGA or SoC?
>>>
>>>
>>> Best regards,
>>> Krzysztof
>> 
>> This is specific to the FPGA, the 7 series encompass the following part
>> family:
>>  * Spartan-7 (XC7S6, XC7S15, ... XC7S100)
>>  * Artix-7 (XC7A12T, XC7A15T, ... XC7A200T)
>>  * Kintex-7 (XC7K70T, XC7K160T, ... XC7K480T)
>>  * Virtex-7 (XC7V585T, XC7V2000T,
>>              XC7VX330T, XC7VX415T, ... XC7VX1140T,
>>              XC7VH580T, XC7VH870T)
>> 
>> 
>> The configuration guide of Xilinx [1] tells us that all those devices
>> share a common programming scheme.
>> 
>> I do agree that having a mention of "7 series" in the compatible name
>> would be beneficial as Xilinx has more FPGA than just the 7 series.
>> The name was inspired from "xlnx,fpga-slave-serial" which is the compatible
>> for the serial interface.
>> 
>> What about "xlnx,fpga-xc7-selectmap" ?
>> 
> 
> I am not sure what xc7 is and how Xilinx numbers it products, but
> compatibles are supposed to be device specific, not family. Common
> programming model could be denoted with generic fallback, but then the
> fallback could be device-specific as well, which usually we recommend.
> 
> Best regards,
> Krzysztof

XC7 is the common prefix for all 4 families of the 7 series.

Then we have XC7S, XC7A, XC7K and XC7V as the prefixes of those 4 family.

Following that is a number denoting the number of logic element, e.g.
XC7S6, XC7S15, XC7S100, ... I don't think that should be part of the
compatible.

Finally there will be another set of letters and numbers for the
temperature grade and physical package, but those are usually not part
of a compatible string.

I'll change it to four compatibles: "xlnx,fpga-xc7[sakv]-selectmap" so
that the driver can do device specific things if anomalies are found in
one of them.

Thanks again for the review!

Regards,
Charles

