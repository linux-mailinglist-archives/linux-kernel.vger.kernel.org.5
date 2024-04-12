Return-Path: <linux-kernel+bounces-142192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B788A28A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EDF1F22D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8A4EB31;
	Fri, 12 Apr 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lut6OKEf"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44017487A9;
	Fri, 12 Apr 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908963; cv=none; b=aePQ1c9336eXRoPCy5FH98JcNYeFu2RiIEII5DHCK382Q8Y7732HbmSHSJoDMSEs6fGK4Df9ju5GzxIofLQ5+4tekNnnT8Ix4fNE3NzzuSNMpR1LDp5kSMRkt7agxtmGg460URJljXZNgy2Am4IHgZo/v8e03zVIJt4BpJkl8SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908963; c=relaxed/simple;
	bh=HypH+HFfZe7sG9jT4MifVrW0ikey/sQI93jaxO2O35g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NCgFUik+d4/ecNtWw5KaXPZKFs5Ghx5GcrMarARM6SKXpnRMQMkRMYXzufUnOcOIcOKoTdL55ynCqIgyWYliXEem02SCT0Cm7qkzaU4nFdsKwX7h5lPX3A3fs6NJ28vBa//dX/zX1pcBwtLlM5nAQODX4iCvrWjYexMviC4w580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lut6OKEf; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C81s5s124910;
	Fri, 12 Apr 2024 03:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712908914;
	bh=VX0Xcvc7mqlW39h0bWx5qdbe1UgbFfhzdFxCTgi5tYs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lut6OKEfEAifrJR0p1WxIxVaFKsg/KVIlAAEdNX55Nx2WeGQbqPMSQHQ+3CGzqc/a
	 dj/0kzRP71mPFk8fT+WWjxsvyRxkRO/ZU8/3bfUy+PWCFPDESChQPeDCwQ7DXuIyz/
	 Uge4C9c/GOJBFuO1A6nXkgblmxcIlwG5zCRRFAqE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C81sa4079143
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 03:01:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 03:01:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 03:01:54 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C81j69086571;
	Fri, 12 Apr 2024 03:01:47 -0500
Message-ID: <cae18a4a-0085-493d-93a1-1e3127a0bd64@ti.com>
Date: Fri, 12 Apr 2024 13:31:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
To: Andrew Lunn <andrew@lunn.ch>, MD Danish Anwar <danishanwar@ti.com>
CC: Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240327114054.1907278-1-danishanwar@ti.com>
 <20240327114054.1907278-4-danishanwar@ti.com>
 <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
 <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>
 <cca25c3d-a352-4531-a8ae-5a0fb7de44df@lunn.ch>
 <ff567495-d966-42c9-9015-ba0ba0dbe011@ti.com>
 <0039b9d9-9dc5-4b88-99f0-92f275b0b4d3@lunn.ch>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <0039b9d9-9dc5-4b88-99f0-92f275b0b4d3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/10/2024 6:12 PM, Andrew Lunn wrote:
>> I have been working on this and have found a way to change firmwares
>> without bringing the interfaces up / down.
>>
>> By default the interfaces are in MAC mode and the ICSSG EMAC firmwares
>> are running on pru cores. To enable switch mode we will need to stop the
>> cores and reload them with the ICSSG Switch firmwares. We can do this
>> without bringing the interfaces up / down.
>>
>> When first interface is added to bridge it will still run emac
>> firmwares. The moment second interface gets added to bridge, we will
>> disable the ports and stop the pru cores. Load the switch firmwares on
>> to the cores, start the cores and enable the ports. All of this is done
>> from the driver.
>>
>> The user need not to bring the interfaces up / down. Loading / Reloading
>> of firmwares will be handled inside the driver only. But we do need to
>> stop the cores for changing firmwares. For stopping the cores we will
>> change the port state to disable by sending r30 command to firmware.
>>
>> As we are not restarting the interfaces, the DRAM, SMEM and MSMC RAM
>> doesn't get cleared. As a result with this approach all configurations
>> will be saved.
>>
>> Please let me know if this approach looks ok to you.
>>
>> Below will be the commands to enable switch mode now,
>>
>>      ip link add name br0 type bridge
>>      ip link set dev eth1 master br0
>>      ip link set dev eth2 master br0 (At this point we will stop the
>> cores, reload switch firmware, start the cores)
>>      ip link set dev br0 up
>>      bridge vlan add dev br0 vid 1 pvid untagged
> 
> This sounds a lot better.
> 
> Note that the bridge interface br0 might already be up when the
> interfaces are added. So that is a different order to what you showed
> here.
> 

Hi Andrew, I have tested with that sequence as well and forwarding
works. Even if the second interface is added to bridge after bridge is
up, the forwarding works fine.

> There will be some packet losses when you swap firmware, but it
> probably is not that bad. When interfaces are added to a bridge
> packets are dropped anywhere while spanning tree determines the
> network topology. It will just appear your device is slow at doing
> that.
> 

Yes there will be packet losses for a slight amount of time but that's
something we can't avoid.

I will post the next revision with these changes soon. Thanks for the
review.

> 	Andrew

-- 
Thanks and Regards,
Md Danish Anwar

