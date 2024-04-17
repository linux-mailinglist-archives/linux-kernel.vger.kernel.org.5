Return-Path: <linux-kernel+bounces-147949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A768A7BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6781F2461F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F87524C6;
	Wed, 17 Apr 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rzdQKg5l"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB3F516;
	Wed, 17 Apr 2024 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713330951; cv=none; b=IROLPOnYc1A9If/K3Jvn9ZgK9bg+c+953nkPFnRHwz6/OFMs1XUuaGZF7orHy0kKqJjEtJpfyaTS50UNR19kEm3gL1mNvSO67CNiJMh1dPiTmtKCri02gZ2iP7OAA57Aw53ZKJPvg7Y8y0EUl0OmQXPMQ+mJ75JHbRwUEzOr4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713330951; c=relaxed/simple;
	bh=xl5Ie0fhJpQqVcqkI3YRZyUMdgGsowrcOdwyU3nze48=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PpofRSZvngkyjF6403p6r3ipGevyCUJAAuw/9KnyT4tYfB6tbHiG9j4Lnf05D4qN4aD31QW+s8NZvDeqKyTAwxcrtTtjuqwFm2dPchTModybKH9Ke474bAjirllslHN8Qa7WHydEH3GoqPO/VgUD94BNBzHnCuWLaZZk3frZBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rzdQKg5l; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43H5FArm111187;
	Wed, 17 Apr 2024 00:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713330910;
	bh=Fo8TQ5AxW91DWwN2mHnILU3BPi2jl2Q4yLOHSsngmzA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rzdQKg5lE/klDnuCRHiqCt75Ykt6E3d6vblK83mOgxL6ufSa5LPED4HZrsb1OUeJG
	 t/7JTKoInHCyl2VQ0u142S5r02Qg3QboYMyHXygbIJ045XQX5DcBBQlwLklPLQ7rNk
	 rHzBgSG/3QlUW8PQOfa60AXFT4WeGwPY89Gakb+o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43H5FAim043081
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 00:15:10 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 00:15:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 00:15:09 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43H5F2rA065474;
	Wed, 17 Apr 2024 00:15:03 -0500
Message-ID: <57d78d3b-dadf-488f-87dc-08a07759fb3e@ti.com>
Date: Wed, 17 Apr 2024 10:45:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, "Anwar, Md Danish" <a0501179@ti.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
 <cb13da4a-13c9-409a-a813-0ac852062163@ti.com>
 <bc0e05c5-11a8-4519-b50d-04dabd6e5999@ti.com>
 <f4a91360-bf31-4dd0-a00d-cd4b7464160e@ti.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <f4a91360-bf31-4dd0-a00d-cd4b7464160e@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 16/04/24 10:49 pm, Andrew Davis wrote:
> On 4/15/24 1:56 AM, Anwar, Md Danish wrote:
>> Hi Andrew,
>>
>> On 4/13/2024 12:22 AM, Andrew Davis wrote:
>>> On 3/27/24 6:40 AM, MD Danish Anwar wrote:
>>>> Add support for ICSSG switch firmware using existing Dual EMAC driver
>>>> with switchdev.
>>>>
>>>> Limitations:
>>>> VLAN offloading is limited to 0-256 IDs.
>>>> MDB/FDB static entries are limited to 511 entries and different FDBs
>>>> can
>>>> hash to same bucket and thus may not completely offloaded
>>>>
>>>> Switch mode requires loading of new firmware into ICSSG cores. This
>>>> means interfaces have to taken down and then reconfigured to switch
>>>> mode.
>>>>
>>>> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
>>>>
>>>> Switch to ICSSG Switch mode:
>>>>    ip link set dev eth1 down
>>>>    ip link set dev eth2 down
>>>>    ip link add name br0 type bridge
>>>>    ip link set dev eth1 master br0
>>>>    ip link set dev eth2 master br0
>>>>    ip link set dev br0 up
>>>>    ip link set dev eth1 up
>>>>    ip link set dev eth2 up
>>>>    bridge vlan add dev br0 vid 1 pvid untagged self
>>>>
>>>> Going back to Dual EMAC mode:
>>>>
>>>>    ip link set dev br0 down
>>>>    ip link set dev eth1 nomaster
>>>>    ip link set dev eth2 nomaster
>>>>    ip link set dev eth1 down
>>>>    ip link set dev eth2 down
>>>>    ip link del name br0 type bridge
>>>>    ip link set dev eth1 up
>>>>    ip link set dev eth2 up
>>>>
>>>> By default, Dual EMAC firmware is loaded, and can be changed to switch
>>>> mode by above steps
>>>>
>>>
>>> This was asked before, maybe I missed the answer, but why do we
>>> default to Dual-EMAC firmware? I remember when I was working on
>>> the original ICSS-ETH driver, we started with the Dual-EMAC
>>> firmware as the switch firmware was not ready yet (and EMAC mode
>>> was easier). Now that we have both available, if we just use Switch
>>> firmwar by default, what would we lose? Seems that would solve
>>> the issues with re-loading firmware at runtime (configuration loss
>>> and dropping packets, etc..).
>>>
>>
>> We can start the driver with either Dual-EMAC firmware or SWITCH
>> firmware. But the problem lies in switching between these two firmwares.
>> For switching to / from Dual-EMAC and switch firmwares we need to stop
>> the cores and that is where we previously used to bring down the
>> interfaces, switch firmware and bring it up again. But as discussed on
>> this thread, I can now do the same without bringing interfaces up /
>> down. We'll just need to stop the cores and change firmware this will
>> also result in preserving the configuration. There will be packet loss
>> but that will not be a big concern as Andrew L. pointed out.
>>
> 
> Yes I saw that and understand all this, but that is not my question.
> 
>> Currently we are starting in Dual-EMAC mode as by default the interfaces
>> are not needed to forward packets. They are supposed to act as
>> individual ports. Port to port forwarding is not needed. Only when user
>> adds a bridge and starts forwarding we switch to Switch mode and load
>> different firmware so that packet forwarding can happen in firmware.
>> That is why currently we are starting Dual-EMAC mode and then switching
>> to firmware.
>>
> 
> Same, I see what we do here, this doesn't give me the "why".
> 
>> If we use switch firmware by default, we will not be able to use
>> individual ports separately and any data sent to one port will be
>> forwarded to the second port.
> 
> So this seems to almost answer the question, but I still do not see
> why we could not use the ports separately when using SWITCH firmware.
> 

This was discussed during v1 of this series [1]. Andrew Lunn also
commented asking for a single firmware that can do both. But the problem
is having a single firmware to do both Switch and EMAC operation will
require additional check in firmware to check whether we are in switch
or mac mode based on that firmware will forward the packet to the other
port or host. I had talked to firmware team regarding this, this
additional check will result in consuming alot of extra cycles and the
performance will be degraded substantially. That is why we decided to
stick with two different firmwares as combining them in one has a very
big penalty.

Such firmware doesn't exist as of now. Furthermore, we are also working
on hsr mode for ICSSG driver and this will also introduce new hsr
firmware. In future their could be more different modes. Now combining
all this firmwares into one will consume all the budget cycles and that
is why firmware team has decided to have split firmware.

While switching modes, stopping and restarting the PRU cores after
changing firmware works fine and it's completely abstracted from user.
For a user it's same as a software bridge. There will be some packet
loss but as Andrew Lunn pointed out, even in sofware bridging there are
some packets losses.

> Why not have a filter/rule set by default to each port so that they
> do not forward packets automatically but instead always forward
> to the host port? That would result in the same functionality as
> the Dual-EMAC firmware, but without all the mess of runtime firmware
> switching based on usecase (simply update the forwarding rules when
> in bridge mode).
> 
> Andrew
> 
>>
>> I will be posting v4 soon and I will describe all the details on how to
>> use and switch between different modes in the cover letter.
>>
>>> Andrew
>>>
>>
>> [ ... ]
>>
>>>>      static const struct prueth_pdata am64x_icssg_pdata = {
>>>>        .fdqring_mode = K3_RINGACC_RING_MODE_RING,
>>>> +    .switch_mode = 1,
>>>>    };
>>>>      static const struct of_device_id prueth_dt_match[] = {
>>

[1] https://lore.kernel.org/all/92864bda-3028-f8be-0e27-487024d1a874@ti.com/

-- 
Thanks and Regards,
Danish

