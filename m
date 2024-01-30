Return-Path: <linux-kernel+bounces-45483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A0D84314C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC77C2883E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBA79957;
	Tue, 30 Jan 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="XbUNHyDS"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED6E7EEFD;
	Tue, 30 Jan 2024 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657543; cv=none; b=bX4JFNjJFaQckUDPFWtSawUkjqIq098gRBqNRsEHmTLgK9eSnaXsrBqneJctCYVDKq1jO+HOwQ32Dr7MlyHcxKbjl9U18R2mHwpZxcek1D3CznRCgRYu/4eJkKgtSO/yTvxro8sMWMA4ByyhwiAbycpckOzIxzOc4gY8cFrgMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657543; c=relaxed/simple;
	bh=LNLe7G+sUEBgyWggG7WM7RWLo2yZedbsnX7Ohqrkqa4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mq469gZV+yYE/+U39hFMkTY5/j9BBfvGQ26ZzV8cOTr8UJQAuWsj53yl6Ol6qwkw6Tc+catinJ8Sn2OU/XqM747PszteM4RLvaEasUhqPwMMdbtkzOomNmBP44ub7TI6zYKTg2KGoPMmyyCQjUos8+axpL+6jjqVbmYoPZdladg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=XbUNHyDS; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BED8A9C47A8;
	Tue, 30 Jan 2024 18:32:12 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ihIR16aTfH4Y; Tue, 30 Jan 2024 18:32:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0B4FF9C47AB;
	Tue, 30 Jan 2024 18:32:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0B4FF9C47AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1706657532; bh=BA4JQridKzT3Qj0Bblif/Dl05zQNFxAGDsMmT6xiiWA=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=XbUNHyDSl0gBsr4cCsjFR4BlqmGJ5WErUDf2j384p7TLk7L0IPzhdQldARfor5h3B
	 xOCshe42bzEydP0Yyl4VZpsUedUnQxI8Cl/T+h/LQLABxp2OipfJw04WMssHnzULPj
	 7QwtEDEZuU7n+tfXVG5HPRklYF80zhVFpor2xyTSGGSb9iSrIP53Q8/ogWUzzJEFN0
	 EoVfgVqJdq/oLkLTZ5CMgySGNht7JuRJ6MzEhq4dpR3bwenCJvFgLI48h6/aHbJQYx
	 7EOB6VTMzn3AI9Ir6l+bpwk6PBQXM8o7tQTOPv4qo3zL8uuEXujtbYkUV4GFq9Q/kD
	 mv/BF4CVMwTrQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id VukIkSh6H6CV; Tue, 30 Jan 2024 18:32:11 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D49819C47A8;
	Tue, 30 Jan 2024 18:32:11 -0500 (EST)
Date: Tue, 30 Jan 2024 18:32:11 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mdf <mdf@kernel.org>, hao wu <hao.wu@intel.com>, 
	yilun xu <yilun.xu@intel.com>, trix <trix@redhat.com>, 
	krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>, 
	Brian CODY <bcody@markem-imaje.com>, 
	Allen VANDIVER <avandiver@markem-imaje.com>, 
	linux-fpga <linux-fpga@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1723200717.393172.1706657531814.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <cee1ca11-03bf-4a0b-9ff3-490457f9fbe8@linaro.org>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com> <20240129225602.3832449-2-charles.perry@savoirfairelinux.com> <f3cfffa0-5089-4bf7-b424-d5e949e36d67@linaro.org> <1489222458.382780.1706629544559.JavaMail.zimbra@savoirfairelinux.com> <32669bc7-90b5-48d9-8845-2e072a477c6e@linaro.org> <154341320.386005.1706634341891.JavaMail.zimbra@savoirfairelinux.com> <cee1ca11-03bf-4a0b-9ff3-490457f9fbe8@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add
 DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4581 (ZimbraWebClient - FF120 (Linux)/8.8.15_GA_4581)
Thread-Topic: dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT schema
Thread-Index: bDEku0F6XFcq/uoMeZdjacG4xvsqgA==


----- On Jan 30, 2024, at 12:58 PM, Krzysztof Kozlowski krzysztof.kozlowski=
@linaro.org wrote:

> On 30/01/2024 18:05, Charles Perry wrote:
>>=20
>>=20
>> ----- On Jan 30, 2024, at 11:05 AM, Krzysztof Kozlowski
>> krzysztof.kozlowski@linaro.org wrote:
>>=20
>>> On 30/01/2024 16:45, Charles Perry wrote:
>>>>
>>>>>> +
>>>>>> +  reg:
>>>>>> +    description:
>>>>>> +      At least 1 byte of memory mapped IO
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  prog_b-gpios:
>>>>>
>>>>>
>>>>> No underscores in names.
>>>>>
>>>>
>>>> This is heavily based on "xlnx,fpga-slave-serial.yaml" which uses an u=
nderscore.
>>>> I can use a dash instead but that would make things inconsistent acros=
s the two
>>>> schemas.
>>>
>>> Inconsistency is not a problem. Duplicating technical debt is.
>>>
>>>>
>>>>>
>>>>>> +    description:
>>>>>> +      config pin (referred to as PROGRAM_B in the manual)
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  done-gpios:
>>>>>> +    description:
>>>>>> +      config status pin (referred to as DONE in the manual)
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  init-b-gpios:
>>>>>
>>>>> Is there init-a? Open other bindings and look how these are called th=
ere.
>>>>>
>>>>
>>>> No, the "-b" is there to denote that the signal is active low. I think=
 its
>>>> shorthand
>>>> for "bar" which is the overline (=E2=80=BE) that electronic engineer p=
ut on top of the
>>>> name of the
>>>> signal on schematics. It comes from the datasheet.
>>>
>>> Then just "init-gpios"
>>>
>>> ...
>>>
>>>>>> +required:
>>>>>> +  - compatible
>>>>>> +  - reg
>>>>>> +  - prog_b-gpios
>>>>>> +  - done-gpios
>>>>>> +  - init-b-gpios
>>>>>> +
>>>>>> +additionalProperties: true
>>>>>
>>>>> Nope, this cannot bue true.
>>>>>
>>>>
>>>> Ok, I'll put this to false but I'm not quite sure I understand the imp=
lications.
>>>>
>>>> My reasoning behind assigning this to true was that the FPGA is an ext=
ernal
>>>> device on a bus that needs to be configured by a bus controller. The b=
us
>>>> controller
>>>> would be the parent of the fpga DT node and the later would contain pr=
operties
>>>> parsed by the bus controller driver.
>>>
>>> Which bus controller? MMIO bus does not parse children properties.
>>> Anyway, if that's the case you miss $ref to respective
>>> peripheral-props.yaml matching your bus and then "unevaluatedProperties=
:
>>> false".
>>=20
>> This one:
>> https://elixir.bootlin.com/linux/v6.8-rc2/source/Documentation/devicetre=
e/bindings/bus/imx-weim.txt#L56
>=20
> Eh, ok, so after fast check WEIM looks like some memory interface bus,
> so the bus bindings should be moved to memory-controllers and converted
> to YAML. Then you add child node properties to own schema and reference
> in mc-peripheral-props, which is then referenced in your binding here,
> as I mentioned.
>=20
> Best regards,
> Krzysztof

Thank you for pointing that out, mc-peripheral-props.yaml seems to be
exactly what I was looking for.

Regards,
Charles

