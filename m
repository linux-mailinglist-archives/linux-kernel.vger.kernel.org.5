Return-Path: <linux-kernel+bounces-89843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8486F665
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FC31F2113A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CE76418;
	Sun,  3 Mar 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="LuZ6KfNs"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7087605C;
	Sun,  3 Mar 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709486523; cv=none; b=XcygHWcUi+raM/orxzVwoItn2asVZ/dtrECl3ITM7UQ+IkkgJy5BsbckpnfzI1SLZ4fASUq6bAS9dhd/o2a7W7S1Kesacf3aQS+YtOcEYqsE5ltox0N2zh11/5Ofh009k0I9Hy2X+IFacWFDFkUIQ7bg/jKSz9KfbL/1wR05WEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709486523; c=relaxed/simple;
	bh=dXR448fFLUi3c8D39FTZdjizZb2q+kwA8oENxPj5zig=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sYw8fv2V+7ncPfiKmBOG1KpGNatK8Kal45cp3KXYWHkFKrrHL/vqAaBx32fQXdX8dXynDRWcE7SNp3qwkDe9qWB4NZU5HnbH6g4gf2Q74BHCbO/MhGXRs/0MXQ0cFx07iOZ4pMhNGK05ZEHPtDLckQgUaKaUlhqpIfDgZErbnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=LuZ6KfNs; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id CF91C9C53A7;
	Sun,  3 Mar 2024 12:21:58 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 8IGxb9hf7w43; Sun,  3 Mar 2024 12:21:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C39B69C53A8;
	Sun,  3 Mar 2024 12:21:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C39B69C53A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1709486517; bh=X6z60N3ACA8IZvH3DAutfNtSvNMdf/cqZv1EWMeZFp8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=LuZ6KfNsatHWX0Xw339nJ0GCdVDLBxwNICLWskMqZx8Z2FpywSvLXMaNexTuB3rVO
	 6bnwPHmfEzflBBg5csGvFZ4+IjpP4e3qewoX8VLFaMMqjZZXV6XDUAwdipnXBLSwv6
	 qlXvb09dwo2MC8m59K4NtIIlr8IzoSEc633xSZEE5E8AiXEvn+jFJ4n05ZmGcjWdkN
	 ZJPju8Nrp+PsL5tI0jCXEoplmMVeDkQTNodtW7E5unYZ8BqbtMEk9SGCXhtI5tanBq
	 DnHxWD/9kKjxjjEyaVViweDyL1+PoEzavhW49Cs7q7C8ScUkpamBAgYpvbIVyS1WUj
	 iCrWTAeb/kz4w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id OLUM838hYjhr; Sun,  3 Mar 2024 12:21:57 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 984849C53A7;
	Sun,  3 Mar 2024 12:21:57 -0500 (EST)
Date: Sun, 3 Mar 2024 12:21:57 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, yilun xu <yilun.xu@intel.com>
Cc: mdf <mdf@kernel.org>, Allen VANDIVER <avandiver@markem-imaje.com>, 
	Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>, 
	Tom Rix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com> <20240221195058.1281973-3-charles.perry@savoirfairelinux.com> <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF123 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
Thread-Index: HnW++BP3eG91lJsFnUADYrmozr5KCw==

On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:

> On 21/02/2024 20:50, Charles Perry wrote:
>> Document the SelectMAP interface of Xilinx 7 series FPGA.
>> 
>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>> ---
>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>  create mode 100644
>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> new file mode 100644
>> index 0000000000000..08a5e92781657
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>> @@ -0,0 +1,86 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx SelectMAP FPGA interface
>> +
>> +maintainers:
>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>> +
>> +description: |
>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>> +  parallel port named the SelectMAP interface in the documentation. Only
>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>> +  the clock, with the MSB of each byte presented to the D0 pin.
>> +
>> +  Datasheets:
>> +
>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>> +
>> +allOf:
>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - xlnx,fpga-xc7s-selectmap
>> +      - xlnx,fpga-xc7a-selectmap
>> +      - xlnx,fpga-xc7k-selectmap
>> +      - xlnx,fpga-xc7v-selectmap
>> +
>> +  reg:
>> +    description:
>> +      At least 1 byte of memory mapped IO
>> +    maxItems: 1
>> +
>> +  prog_b-gpios:
> 
> I commented on this and still see underscore. Nothing in commit msg
> explains why this should have underscore. Changelog is also vague -
> describes that you brought back underscores, instead of explaining why
> you did it.
> 
> So the same comments as usual:
> 
> No underscores in names.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Yes, I've gone full circle on that issue. Here's what I tried so far:

 1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
    doesn't like it.
 2) Different gpio names for new driver only: Makes the driver code
    overly complicated, Yilun doesn't like it.
 3) Change gpio names for both drivers, deprecate the old names: Makes
    the DT binding and the driver code overly complicated, Rob doesn't
    like it.

I think that while the driver code shouldn't be the driving force for
the DT spec, it can be a good indication that the spec is unpractical to
implement.

In this case, there are two interfaces on a chip that uses the same GPIO
protocol, it would only make sense that they use the same names, this
discards solution #2.

That leaves us with #1 or #3, which is to ask if the added complexity to
the driver code and DT binding is worth it for a gain in naming
convention.

There might also be another solution that I haven't seen.

Regards,
Charles





