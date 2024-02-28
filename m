Return-Path: <linux-kernel+bounces-84808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F6286ABD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2736D1C2197B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3119364C7;
	Wed, 28 Feb 2024 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JInmPBuU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C6364A0;
	Wed, 28 Feb 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114734; cv=none; b=IC7aYSepugaZOW3+xvJaGxJvrVQCgs2yGvy5nh4NCWcfjOM+ApaLydtThCRkYACES5LCmKNkA5OeW6ULoN3oDLWBUZiY8BHnJSBUdUyC2bctc4lkESw6KjuYVZrgliTZuYsz347dZ4zFCEmxbBSgeBUOMZO79VeuG9oAyJlwr1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114734; c=relaxed/simple;
	bh=It59g4eBAk0nx1AhPC3trrgLHBIRRxxpweL7YTHYkjc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NH8ZLDuuqnu3cRg00hVhJ0NASG2OjzD6hM9IdsYDzv70wzZyCrL4Q6bIeT0Bo7FWsGBgKoE+zqJ8+0PWrIcS0Hgf13trqBlR57cV2zWQ0Xo4DgD09srk5JDOORQe4Nsm7eQ33ZAK+fsXnh1KSTVDnnAxrOHjRnN5VFjhpCxc2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JInmPBuU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SA511N098292;
	Wed, 28 Feb 2024 04:05:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709114701;
	bh=6T6cKKdRNMBzP6cURWBTF7KjRvrDSRlHckGPQHccD4Y=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=JInmPBuUtfiWwpwnhr42tUk8g8Q3jXMjHS2A8fvZNSSIBCLLImyUQIoqlLQ8anAKU
	 xzyRZK2gJBm0jaNQLRHRMs7umCSW8jLlR8ffb05OtYHZJepFPq8UojsLY5q0M8VhIZ
	 HQV7qt3w9AEe1kX9GDBjthNX2r0m4x+ZXqerd5PU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SA51x9008488
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 04:05:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 04:05:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 04:05:01 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SA4uvJ002441;
	Wed, 28 Feb 2024 04:04:56 -0600
Message-ID: <49e531f7-9465-40ea-b604-22a3a7f13d62@ti.com>
Date: Wed, 28 Feb 2024 15:34:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <andrew@lunn.ch>,
        <vladimir.oltean@nxp.com>, <hkallweit1@gmail.com>,
        <dan.carpenter@linaro.org>, <horms@kernel.org>,
        <yuehaibing@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for
 Switch VLAN Aware mode
To: Jiri Pirko <jiri@resnulli.us>
References: <20240227082815.2073826-1-s-vadapalli@ti.com>
 <Zd3YHQRMnv-ZvSWs@nanopsycho> <7d1496da-100a-4336-b744-33e843eba930@ti.com>
 <Zd7taFB2nEvtZh8E@nanopsycho>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <Zd7taFB2nEvtZh8E@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 28/02/24 13:53, Jiri Pirko wrote:
> Wed, Feb 28, 2024 at 08:06:39AM CET, s-vadapalli@ti.com wrote:
>>
>>
>> On 27/02/24 18:09, Jiri Pirko wrote:
>>> Tue, Feb 27, 2024 at 09:28:15AM CET, s-vadapalli@ti.com wrote:
>>>> The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
>>>> VLAN Aware or VLAN Unaware modes of operation. This is different from
>>>> the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
>>>> results in the addition/removal/replacement of VLAN tag of packets during
>>>> egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
>>>> the AM65x Technical Reference Manual available at:
>>>> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>>>> In VLAN Unaware mode, packets remain unmodified on egress.
>>>>
>>>> The driver currently configures the Ethernet Switch in VLAN Aware mode by
>>>> default and there is no support to toggle this capability of the Ethernet
>>>> Switch at runtime. Thus, add support to toggle the capability by exporting
>>>> it via the ethtool "priv-flags" interface.
>>>
>>> I don't follow. You have all the means to offload all bridge/vlan
>>> configurations properly and setup your hw according to that. See mlxsw
>>> for a reference. I don't see the need for any custom driver knobs.
>>>
>>
>> Thank you for reviewing the patch. Please note that the "VLAN Aware mode" being
>> referred to here is different from ALE being VLAN aware. The hw offload of
>> bridge/vlan configurations is already supported in the context of the ALE. The
>> Ethernet Switch being VLAN Aware is a layer on top of that, which enables
>> further processing on top of the untagged/VLAN packets. This patch aims to
>> provide a method to enable the following use-cases:
>> 1. ALE VLAN Aware + CPSW VLAN Aware
>> 2. ALE VLAN Aware + CPSW VLAN Unaware
>>
>> All hw offloads of bridge/vlan configurations are w.r.t. ALE VLAN Aware alone.
>> Currently, only use-case 1 is enabled by the driver by default and there is no
>> knob to toggle to use-case 2.
>>
>> I am quoting sections of the Technical Reference Manual mentioned in my commit
>> message, in order to clarify the CPSW VLAN Unaware and CPSW VLAN Aware terminology.
>>
>> CPSW VLAN Unaware:
>> Transmit packets are NOT modified during switch egress.
>>
>> CPSW VLAN Aware:
>> 1. Untagged Packet Operations
>> Untagged packets are all packets that are not a VLAN packet or a priority tagged
>> packet. According to the CPWS0_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the
>> packet header the packet may exit the switch with a VLAN tag inserted or the
>> packet may leave the switch unchanged....
>> 2. Priority Tagged Packet Operations (VLAN VID == 0 && EN_VID0_MODE ==0h)
>> Priority tagged packets are packets that contain a VLAN header with VID = 0.
>> According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>> header, priority tagged packets may exit the switch with their VLAN ID and
>> priority replaced or they may have their priority tag completely removed....
>> 3. VLAN Tagged Packet Operations (VLAN VID != 0 || (EN_VID0_MODE ==1h && VLAN
>> VID ==0))
>> VLAN tagged packets are packets that contain a VLAN header specifying the VLAN
>> the packet belongs to
>> (VID), the packet priority (PRI), and the drop eligibility indicator (CFI).
>> According to the CPSW_ALE_FORCE_UNTAGGED_EGRESS_REG[1-0] MASK bit in the packet
>> header, VLAN tagged packets may exit the switch with their VLAN priority
>> replaced or they may have their VLAN header completely removed...
>>
>> I hope that this clarifies that CPSW VLAN Unaware/Aware is a layer on top of the
>> hw offload-able bridge/vlan configuration.  Please let me know if there is
>> anything specific that could enable this without requiring the "priv-flag" based
>> implementation of this patch.
> 
> I have no clue what "ALE" is. But in general. User provided

ALE is Address Lookup Engine.

> configuration, using ip/bridge/etc tools/uapi. According to this
> configuration, kernel is bahaving. When you do offload, you should just
> make sure to mimic/mirror the kernel behaviour. With this in mind, why

What if there is no kernel behavior associated with it? How can it be mimicked
then? This patch isn't offloading any feature that is supported in software. It
might not be possible to offload features which act on the forwarding path of
packets entirely in Hardware within the Ethernet Switch.

Please consider the following:
Untagged packets sent from Software via the corresponding VLAN interfaces will
be tagged which is the expected behavior. However, if this is offloaded, it will
imply that even untagged packets that are simply forwarded in the Ethernet
Switch and never get to software will also have to be tagged by the Ethernet
Switch. This is not allowing the choice of leaving untagged packets as-is on the
Ethernet Switch's forwarding path. This patch attempts to allow configuring
something quite similar to this, where it is possible to *choose* whether or not
to tag packets being forwarded.

> can't you do it without adding additional knob? And if you really need
> it because the know does some internal hw/fw tuning, priv flag of netdev

The feature can be turned on or off depending on the use-case. Is it acceptable
to have build configs scattered in the driver code? I don't suppose that is
acceptable, due to which it will be preferable to have a runtime configuration
option, which is what this patch provides.

> is most probably not the correct place to put it. If it is, make sure

Please suggest an alternative if this isn't the right place. Otherwise, I can
only assume that there isn't one.

> you advocate for it properly in the patch description.
> 
> pw-bot: cr
>

-- 
Regards,
Siddharth.

