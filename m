Return-Path: <linux-kernel+bounces-155938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA5B8AFAB3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EDC1F2978A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD814A4D2;
	Tue, 23 Apr 2024 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IdJnfCLh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D4148315;
	Tue, 23 Apr 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908749; cv=none; b=PZ5FqvwAYWkR8h8PDv5XIDqLDKeq2i4rLJdJRpyWrKx2DV137Fpj6sr46pI1pKt1EMMTQKehOCH/KljWW6vl5gS+Ebd8c4TIWzRc9DKq9V87itzqQ4qeRHcJD4nUcD5nrdLqs+aR03B6EhMjo6DIs2SAqjIMTcoHCOg+2kWTrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908749; c=relaxed/simple;
	bh=25oEvb/uJC2kZD/+Y3JfUUxisf+IUQOCeL4y/WsXjyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s+mEJohbdHBmJDKbrzbpzSv7aziBhrKzOcBsyG+kLXiEMi8PjmgwQLkO9UAnlRhMrXER6CjcS16gJMLnibtX3LKSNfVSAblI89ye8PTCByTwwPDYAhkcY+9YWo7k1xCBvh3aBa6smFuQuyyMiUzERVSvspwTdhoUxlbzr3BwJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IdJnfCLh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NLiKoT062866;
	Tue, 23 Apr 2024 16:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713908660;
	bh=rWREzdQPslSCnH1+XsYIGLoX2cePDbx5j1SDdTKRMYE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=IdJnfCLhfCWVBGbz1O32Y9B1qGc7/dyf1yttW0m6tQKHOdrjGG/fswzFNH/CzWTpY
	 IhGxkp2Sp27c7QSu/Ux0kBzpwMKCHaYUVDPwQUlh+EW+JnGTUveNaM2+sJRYBUyai7
	 OnutljaGt3H2jbvW5H45iKIqJD+JGdGR/iTrloqM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NLiKNR048023
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 16:44:20 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 16:44:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 16:44:20 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NLiKun073509;
	Tue, 23 Apr 2024 16:44:20 -0500
Message-ID: <fdfc78b4-611e-4491-9055-8ad3fbe67aae@ti.com>
Date: Tue, 23 Apr 2024 16:44:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: Robert Nelson <robertcnelson@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Jared McArthur <j-mcarthur@ti.com>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Deepak Khatri <lorforlinux@beagleboard.org>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
 <1a5e719f-efa0-4c60-8add-ef7c0464d1ce@ti.com>
 <CAOCHtYjHhH2M_+7md-e2vh_d_3H2r66OhXEp2acd0D+6O+uwcg@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAOCHtYjHhH2M_+7md-e2vh_d_3H2r66OhXEp2acd0D+6O+uwcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/23/24 2:48 PM, Robert Nelson wrote:
> On Mon, Apr 22, 2024 at 3:57 PM Andrew Davis <afd@ti.com> wrote:
>>
>> On 3/28/24 2:12 PM, Robert Nelson wrote:
>>> This board is based on ti,j722s
>>>
>>> https://beagley-ai.org/
>>> https://openbeagle.org/beagley-ai/beagley-ai
>>>
>>> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>>> CC: Rob Herring <robh@kernel.org>
>>> CC: Nishanth Menon <nm@ti.com>
>>> CC: Jared McArthur <j-mcarthur@ti.com>
>>> CC: Jason Kridner <jkridner@beagleboard.org>
>>> CC: Deepak Khatri <lorforlinux@beagleboard.org>
>>> ---
>>>    Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> index 52b51fd7044e..ca23b7e6a35e 100644
>>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>>> @@ -134,6 +134,7 @@ properties:
>>>          - description: K3 J722S SoC and Boards
>>>            items:
>>>              - enum:
>>> +              - beagle,j722s-beagley-ai
>>
>> Recommend "beagle,am67-beagley-ai". The "J722s" is the family
>> name, the part used on this board is the AM67. We do the same
>> for the SK boards, for example, the SK-AM69 uses the AM69
>> part from the J784s4 family, so it is called k3-am69-sk.dts
>> with compatible = "ti,am69-sk", "ti,j784s4";
>>
>> This would otherwise be the first board with a specific part
>> attached but uses the SoC family name instead of that specific
>> part name in the DT file/name. Only the EVMs should have the
>> family name since we sell versions of those with all the different
>> parts swapped onto it. I don't imagine you will be selling
>> BeagleY's with TDA4VEN, TDA4AEN, DRA82x, etc.. All your
>> docs and other collateral use "AM67", using the same here
>> would help avoid confusion.
>>
>> Andrew
> 
> Andrew, would you like us to model this just like the AM69-SK? and
> also rename the device tree? or just the bindings..
> 
> k3-j722s-beagley-ai.dtb -> k3-am67-beagley-ai.dtb or even the am67a
> k3-am67a-beagley-ai.dtb ?
> 

Yes, rename binding and dtb name would be great. Better now then have
the name confuse folks forever.

AM67A is more correct than AM67 (which is the spin without AI), given
this is an AI focused device I'd imagine you'll be using the "a" version.

Andrew

> Regards,
> 

