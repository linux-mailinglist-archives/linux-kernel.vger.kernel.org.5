Return-Path: <linux-kernel+bounces-82679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ADB868836
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3B71C2268A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5770B4DA0B;
	Tue, 27 Feb 2024 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dpq+4pku"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5841EEEA;
	Tue, 27 Feb 2024 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007915; cv=none; b=Sa8eS59fzHL5jK0KpVzdQhK9MQe/Eoo7w05Bn4k9ZQpDR4GUdMuLMQeFVh9ibnphKnzhkHiJGMTKTW/Oefcz9n/Ym6JBSDJbXv7oa2dRpfrOItIlkQr1wjFOjy8pluam10NMwXfQwaqdgQ2GYkDiffz0qMgRsyCJs3LEObof2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007915; c=relaxed/simple;
	bh=FKx34NGx56OfaqqlnsM4Id57tKe3ZjT0UUYkPNqbYHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JtrWRpvVSB2kJioHjSANSg+DxO3mh4CWyv9BhTKsoMW8sRzFtOg5pA4vOk6fiRE1GYhxp4t/ph/Lt0JwZkH2z9KmOB8Dv5xBPppxzMuNhKmjXnTtw84kk8rmWTNskvlCnxIA3jy/MlviUgh4HzdQrXFU2yoOizUC3EbKQI8woXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dpq+4pku; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R4OdoS033202;
	Mon, 26 Feb 2024 22:24:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709007879;
	bh=lLf2MHGq1G+iPHOKjhL3F0LbLV6mSmAfmkVSCh2uWNk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Dpq+4pku6oqrWEHcenPaq4SqrU18W/ebYfWi9ZY1axN7c6e8AyQtHItaBVQmvuQ9P
	 ffpBvmc0+00mKNxWWjkDpbAN/CCGUtOp0Xq5ULCfuDUO8a4k7nunOOBkvRnRDgRTvv
	 D5u2h63VZ591yN06t5HMJgx3JLATF1FxgRzn1df0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R4Odgu004999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Feb 2024 22:24:39 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Feb 2024 22:24:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Feb 2024 22:24:39 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R4OWTk077058;
	Mon, 26 Feb 2024 22:24:33 -0600
Message-ID: <37ab0886-0cd1-4188-9177-8b7ef0ad9eca@ti.com>
Date: Tue, 27 Feb 2024 09:54:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: usb: ti,j721e-usb: drop useless
 compatible list
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Peter Chen
	<peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>, Nishanth Menon
	<nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?=
	<gregory.clement@bootlin.com>,
        Kevin Hilman <khilman@kernel.org>,
        Alan Stern
	<stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-1-b41c9893a130@bootlin.com>
 <20240223-clarity-variably-206b01b7276a@spud>
 <CZEXXXQDZZWB.1M5CTZAFVO4YP@bootlin.com>
 <20240226-portable-rockslide-e501667a0d9a@wendy>
 <CZF33W51MC4M.3GUBZFQXT39DB@bootlin.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CZF33W51MC4M.3GUBZFQXT39DB@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/02/24 20:05, Théo Lebrun wrote:
> Hello,
> 
> On Mon Feb 26, 2024 at 12:56 PM CET, Conor Dooley wrote:
>> On Mon, Feb 26, 2024 at 11:33:06AM +0100, Théo Lebrun wrote:
>>> Hello Conor,
>>>
>>> On Fri Feb 23, 2024 at 7:12 PM CET, Conor Dooley wrote:
>>>> On Fri, Feb 23, 2024 at 05:05:25PM +0100, Théo Lebrun wrote:
>>>>> Compatible can be A or B, not A or B or A+B. Remove last option.
>>>>> A=ti,j721e-usb and B=ti,am64-usb.
>>>>>
>>>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 9 +++------
>>>>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>>>> index 95ff9791baea..949f45eb45c2 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
>>>>> @@ -11,12 +11,9 @@ maintainers:
>>>>>  
>>>>>  properties:
>>>>>    compatible:
>>>>> -    oneOf:
>>>>> -      - const: ti,j721e-usb
>>>>> -      - const: ti,am64-usb
>>>>> -      - items:
>>>>> -          - const: ti,j721e-usb
>>>>> -          - const: ti,am64-usb
>>>>
>>>> Correct, this makes no sense. The devices seem to be compatible though,
>>>> so I would expect this to actually be:
>>>> oneOf:
>>>>   - const: ti,j721e-usb
>>>>   - items:
>>>>       - const: ti,am64-usb
>>>>       - const: ti,j721e-usb
>>>
>>> I need your help to grasp what that change is supposed to express? Would
>>> you mind turning it into english sentences?
>>> A=ti,j721e-usb and B=ti,am64-usb. My understanding of your proposal is
>>> that a device can either be compat with A or B. But B is compatible
>>> with A so you express it as a list of items. If B is compat with A then
>>> A is compat with B. Does the order of items matter?
>>
>> The two devices are compatible with each other, based on an inspection of
>> the driver and the existing "A+B" setup. If this was a newly submitted
>> binding, "B" would not get approved because "A+B" allows support without
>> software changes and all that jazz.
>>
>> Your patch says that allowing "A", "B" and "A+B" makes no sense and you
>> suggest removing "A+B". I am agreeing that it makes no sense to allow
>> all 3 of these situations.
>>
>> What I also noticed is other problems with the binding. What should have
>> been "A+B" is actually documented as "B+A", but that doesn't make sense
>> when the originally supported device is "A".
>>
>> Therefore my suggestion was to only allow "A" and "A+B", which is what
>> we would (hopefully) tell you to do were you submitting the am64 support
>> as a new patch today.
> 
> Thank you for the in-depth explanation! It makes much more sense now,
> especially the handling of historic stuff that ideally wouldn't have
> been done this way but that won't be changed from now on.
> 

IIRC, idea behind adding new compatible for AM64 even though register
map is very much compatible is just being future proof as AM64 and J721e
belong to different product groups and thus have differences wrt SoC
level integration etc which may need SoC specific handling later on.

I don't see any DT (now or in the past) using

compatible = B,A or compatible = A,B

So do we really need A+B to be supported by binding?

Also, note that AM64 SoC support was added long after J721e. So ideally
should be B+A if at all we need a fallback compatible.

Regards
Vignesh
-- 
Regards
Vignesh

