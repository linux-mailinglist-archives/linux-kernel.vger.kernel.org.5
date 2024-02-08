Return-Path: <linux-kernel+bounces-57880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700384DE8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF251C23EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261CC1DFCE;
	Thu,  8 Feb 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="klLR/prC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC52E3F3;
	Thu,  8 Feb 2024 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389071; cv=none; b=nKGkkF1Ix/9oEk5dagCTQb0thoulcsYU9NVKJJRjG9uFGwqWVvFn2Xbdf/3M7QOEM0Kf1tCCrWVZkqXq7i9R7zgLWjd2a1zD1mV+i4IJcrT3rM0GY2qUuIHb6a8C4Ej+SZAT3SP6b8cmKCQxqZ5BF8Ji3fRE27QPiCQLyJ5X2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389071; c=relaxed/simple;
	bh=uh5I1vTwdWglo9t57/duSNUZWmgQ/paQyN9iHWMOv+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AtpmORj5VAvJ9qpYepnyn8vcrGRaYMUXbAgdWn6NUifJSyvBcTVi9497sKWwWWEc7MSL/Z8rWamaRw6wTX7LP3pHqul9krXxZ0vyoA+CUnfXNZDCHW36mafj4khK4GG7OxEMpImMi5bcOg2oyeZZbeXGDEHklIMsL9y+6PaQ0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=klLR/prC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418Ahu2Q048042;
	Thu, 8 Feb 2024 04:43:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707389036;
	bh=QIVpJjLRBXJ5BvMfK4/+Zqa96LkHCKp00pb2V1eWwOU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=klLR/prCQP23R/BGxgetq1J5VyxmI4qhzbmObDd43QxIaey3nP8AShgfBs7Lxm4ql
	 SyoSYNk900vLyzWEtFEJExVEjPOcogDnxGiG2bQzfpgvn35nKvXl2+mJpq02DNG4cb
	 2HG7jL8IDQIG1vJjNWe07ZUgRDrvrnKzf3vLZSmQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418AhuCU029283
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 04:43:56 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 04:43:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 04:43:56 -0600
Received: from [10.250.146.202] ([10.250.146.202])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418AhnLP066574;
	Thu, 8 Feb 2024 04:43:50 -0600
Message-ID: <96af9fac-aad6-747d-dd89-295c7309f535@ti.com>
Date: Thu, 8 Feb 2024 16:13:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: ti,am65x-dss: Add support
 for display sharing mode
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <praneeth@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>
References: <20240116134142.2092483-1-devarsht@ti.com>
 <20240116134142.2092483-2-devarsht@ti.com>
 <20240117201342.GA3041972-robh@kernel.org>
 <57805224-f4f9-7773-03e3-4bdff8936c9c@ti.com>
 <CAL_JsqKVMs92DkzVTmOuJzxzcm90SGOmwQXdk=kydBa5S_ySmg@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAL_JsqKVMs92DkzVTmOuJzxzcm90SGOmwQXdk=kydBa5S_ySmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Rob,

Thanks for the review.

On 19/01/24 19:25, Rob Herring wrote:
> On Thu, Jan 18, 2024 at 7:59 AM Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Hi Rob,
>>
>> Thanks for the quick review.
>>
>> On 18/01/24 01:43, Rob Herring wrote:
>>> On Tue, Jan 16, 2024 at 07:11:40PM +0530, Devarsh Thakkar wrote:
>>>> Add support for using TI Keystone DSS hardware present in display
>>>> sharing mode.
>>>>
>>>> TI Keystone DSS hardware supports partitioning of resources between
>>>> multiple hosts as it provides separate register space and unique
>>>> interrupt line to each host.
>>>>
>>>> The DSS hardware can be used in shared mode in such a way that one or
>>>> more of video planes can be owned by Linux wherease other planes can be
>>>> owned by remote cores.
>>>>
>>>> One or more of the video ports can be dedicated exclusively to a
>>>> processing core, wherease some of the video ports can be shared between
>>>> two hosts too with only one of them having write access.
>>>>
>>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>>> ---
>>>>  .../bindings/display/ti/ti,am65x-dss.yaml     | 82 +++++++++++++++++++
>>>>  1 file changed, 82 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>>> index 55e3e490d0e6..d9bc69fbf1fb 100644
>>>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>>>> @@ -112,6 +112,86 @@ properties:
>>>>        Input memory (from main memory to dispc) bandwidth limit in
>>>>        bytes per second
>>>>
>>>> +  ti,dss-shared-mode:
>>>> +    type: boolean
>>>> +    description:
>>>> +      TI DSS7 supports sharing of display between multiple hosts
>>>> +      as it provides separate register space for display configuration and
>>>> +      unique interrupt line to each host.
>>>
>>> If you care about line breaks, you need '|'.
>>>
>>
>> Noted.
>>
>>>> +      One of the host is provided access to the global display
>>>> +      configuration labelled as "common" region of DSS allows that host
>>>> +      exclusive access to global registers of DSS while other host can
>>>> +      configure the display for it's usage using a separate register
>>>> +      space labelled as "common1".
>>>> +      The DSS resources can be partitioned in such a way that one or more
>>>> +      of the video planes are owned by Linux whereas other video planes
>>>
>>> Your h/w can only run Linux?
>>>
>>> What if you want to use this same binding to define the configuration to
>>> the 'remote processor'? You can easily s/Linux/the OS/, but it all
>>> should be reworded to describe things in terms of the local processor.
>>>
>>
>> It can run both Linux and RTOS or for that matter any other OS too. But yes I
>> got your point, will reword accordingly.
>>
>>>> +      can be owned by a remote core.
>>>> +      The video port controlling these planes acts as a shared video port
>>>> +      and it can be configured with write access either by Linux or the
>>>> +      remote core in which case Linux only has read-only access to that
>>>> +      video port.
>>>
>>> What is the purpose of this property when all the other properties are
>>> required?
>>>
>>
>> The ti,dss-shared-mode and below group of properties are optional. But
>> if ti,dss-shared-mode is set then only driver should parse below set of
>> properties.
> 
> Let me re-phrase. Drop this property. It serves no purpose since all
> the properties have to be present anyway.
> 

Noted.

>>>> +  ti,dss-shared-mode-planes:
>>>> +    description:
>>>> +      The video layer that is owned by processing core running Linux.
>>>> +      The display driver running from Linux has exclusive write access to
>>>> +      this video layer.
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    enum: [vidl, vid]
>>>> +
>>>> +  ti,dss-shared-mode-vp:
>>>> +    description:
>>>> +      The video port that is being used in context of processing core
>>>> +      running Linux with display susbsytem being used in shared mode.
>>>> +      This can be owned either by the processing core running Linux in
>>>> +      which case Linux has the write access and the responsibility to
>>>> +      configure this video port and the associated overlay manager or
>>>> +      it can be shared between core running Linux and a remote core
>>>> +      with remote core provided with write access to this video port and
>>>> +      associated overlay managers and remote core configures and drives
>>>> +      this video port also feeding data from one or more of the
>>>> +      video planes owned by Linux, with Linux only having read-only access
>>>> +      to this video port and associated overlay managers.
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    enum: [vp1, vp2]
>>>> +
>>>> +  ti,dss-shared-mode-common:
>>>> +    description:
>>>> +      The DSS register region owned by processing core running Linux.
>>>> +    $ref: /schemas/types.yaml#/definitions/string
>>>> +    enum: [common, common1]
>>>> +
>>>> +  ti,dss-shared-mode-vp-owned:
>>>> +    description:
>>>> +      This tells whether processing core running Linux has write access to
>>>> +      the video ports enlisted in ti,dss-shared-mode-vps.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1]
>>>
>>> This can be boolean. Do writes abort or just get ignored? The latter can
>>> be probed and doesn't need a property.
>>>
>>
>> Although we have kept all these properties as enums, but actually in driver we
>> are treating them as array of enums and using device_property_read_u32_array.
>>
>> The reason being that for SoCs using am65x-dss bindings they can only have
>> single entry either vp1 or vp2 or 0 or 1 as there are only two video ports. So
>> for them the device tree overlay would look like :
>> &dss0 {
>>
>>         ti,dss-shared-mode;
>>
>>         ti,dss-shared-mode-vp = "vp1";
>>
>>         ti,dss-shared-mode-vp-owned = <0>;
>>
>>         ti,dss-shared-mode-common = "common1";
>>
>>         ti,dss-shared-mode-planes = "vid";
>>
>>         ti,dss-shared-mode-plane-zorder = <0>;
>>
>>         interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_>;
>> }
>>
>> But we also plan to extend these bindings to SoCs using
>> Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml where there are
>> multiple video ports. So in that the driver and bindings should support below
>> configuration :
> 
> What are you waiting for? In that case, all these properties need to
> be in a shared schema file and referenced here. Otherwise you will be
> defining their types twice (and different types too if some are
> changed to arrays).
> 

Noted, thanks for suggesting this, shared schema file indeed looks like
a better idea.

>> &dss0 {
>>
>>         ti,dss-shared-mode;
>>
>>         ti,dss-shared-mode-vp = "vp1 vp2";
>>
>>         ti,dss-shared-mode-vp-owned = <0 1>;
>>
>>         ti,dss-shared-mode-common = "common_s1";
>>
>>         ti,dss-shared-mode-planes = "vid1 vidl1";
>>
>>         ti,dss-shared-mode-plane-zorder = <0 1>;
>>
>>         interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_>;
>> }
>>
>> As I am using device_property_read_u32_array in driver I thought to keep this
>> as uint32 in enum for am65x.yaml which works well with the driver.
> 
> The type and what accessor functions the kernel uses should match. I
> plan to add (debug) checking on this. Debug only because as there's no
> type info in the DTB, it all has to be extracted from schemas and put
> into the kernel.
> 

Yes, with the shared schema it should be array instead of integer.

>>>> +
>>>> +  ti,dss-shared-mode-plane-zorder:
>>>> +    description:
>>>> +      The zorder of the planes owned by Linux.
>>>> +      For the scenario where Linux is not having write access to associated
>>>> +      video port, this field is just for
>>>> +      informational purpose to enumerate the zorder configuration
>>>> +      being used by remote core.
>>>> +
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1]
>>>
>>> I don't understand how 0 or 1 defines Z-order.
>>>
>>
>> As there are only two planes in total so z-order can be either 0 or 1 for the
>> shared mode plane as there is only a single entry of plane.
>> For e.g. if ti,dss-shared-mode-plane-zorder is 1 then it means the plane owned
>> by Linux is programmed as topmost plane wherease the plane owned by remote
>> core is programmed as the underneath one.
> 
> Please reword the description to make all this clear. The index is the
> plane number and value is the z-order with 0 being bottom and N being
> the top. I guess this should be an array as well.
> 


Yes, this was kept as uint32 since with am65x-dss only one plane was
available for sharing, but with the shared schema this too should be an
array instead of integer.

Regards
Devarsh

> Rob
> 

