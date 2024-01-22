Return-Path: <linux-kernel+bounces-32780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF02836001
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 015E31C24CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00173A1DC;
	Mon, 22 Jan 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DgCnjRPn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7793AC01;
	Mon, 22 Jan 2024 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920359; cv=none; b=udvWDTW0AsUggy6Sz9+Ti6QEtsGKVrD3mmfMK1AVihZWp98XV91gHxU3bq4Oqv3+m4VtY8ihfydRp5zEP2GcYpDY67ZzTemiZ8kOirUt1FRsQoG9pedHMt9Yg0hLYGDL/Et8HSI4qeF0uDOlaY62+gNe2fGnyTUcDTTXB7cdOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920359; c=relaxed/simple;
	bh=dxK6xX54LO28WOHrMLPwhZoBtVYi0SL/2VZN36oVJgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AP/5RIBGaktZIdaUg/mSgnosPDn8M0IWGxgK7emhoAEJcYniur7ByfkK/VR3RXKd/qURXrI6Zezx/dRP3z1uueR7p41Xt1j/Yaw3cx5ZFFSHqtiSItzqLE/dtSBuRwJOSUzRZJZPVRBkWLCNTCMt3UUgaFlYXAfdB7FA9o6yjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DgCnjRPn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MAjZ6n115528;
	Mon, 22 Jan 2024 04:45:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705920335;
	bh=Z+InRGOw9IUgj0Bto1XEMQ32j8fuEMOKDMNGsBAdoDY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DgCnjRPnmTIfx8ARr49dbJlmOVNTPmxHUmNSabCwOvKbkZ/uaIguJvhLm8hbj2MZ1
	 idMVVdpdsO1FkTkG1lPjZpreLnIyppaHdfk7ZTvhMssE7d25fQyPdUmv96vQmmUSRu
	 hZD27jP8S0S6nhbEmjVvKkngbMiST0PLDvefk+TU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MAjZTJ007887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 04:45:35 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 04:45:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 04:45:35 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MAjTX7070753;
	Mon, 22 Jan 2024 04:45:30 -0600
Message-ID: <a48fcb4f-8157-4d20-9a19-e583dc9a9e95@ti.com>
Date: Mon, 22 Jan 2024 16:15:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Introduce switch mode support for ICSSG driver
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <f3d75103-c1ca-448d-b5aa-736496d00342@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <f3d75103-c1ca-448d-b5aa-736496d00342@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18/01/24 7:31 pm, Andrew Lunn wrote:
> On Thu, Jan 18, 2024 at 12:40:02PM +0530, MD Danish Anwar wrote:
>> This series adds support for switch-mode for ICSSG driver. This series
>> also introduces helper APIs to configure firmware maintained FDB
>> (Forwarding Database) and VLAN tables. These APIs are later used by ICSSG
>> driver in switch mode.
>>
>> Now the driver will boot by default in dual EMAC mode. When first ICSSG
>> interface is added to bridge driver will still be in EMAC mode. As soon as
>> second ICSSG interface is added to same bridge, switch-mode will be
>> enabled and switch firmwares will be loaded to PRU cores. The driver will
>> remain in dual EMAC mode if ICSSG interfaces are added to two different
>> bridges or if two differnet interfaces (One ICSSG, one other) is added to
>> the same bridge. We'll only enable is_switch_mode flag when two ICSSG
>> interfaces are added to same bridge.
>>
>> We start in dual MAC mode. Let's say lan0 and lan1 are ICSSG interfaces
>>
>> ip link add name br0 type bridge
>> ip link set lan0 master br0
>>
>> At this point, we get a CHANGEUPPER event. Only one port is a member of
>> the bridge, so we will still be in dual MAC mode.
>>
>> ip link set lan1 master br0
>>
>> We get a second CHANGEUPPER event, the secind interface lan1 is also ICSSG
>> interface so we will set the is_switch_mode flag and when interfaces are
>> brought up again, ICSSG switch firmwares will be loaded to PRU Cores.
>>
>> There are some other cases to consider as well. 
>>
>> ip link add name br0 type bridge
>> ip link add name br1 type bridge
>>
>> ip link set lan0 master br0
>> ip link set ppp0 master br0
>>
>> Here we are adding lan0 (ICSSG) and ppp0 (non ICSSG) to same bridge, as
>> they both are not ICSSG, we will still be running in dual EMAC mode.
>>
>> ip link set lan1 master br1
>> ip link set vpn0 master br1
>>
>> Here we are adding lan1 (ICSSG) and vpn0 (non ICSSG) to same bridge, as
>> they both are not ICSSG, we will still be running in dual EMAC mode.
> 
> This is going in the right direction, thanks for the changes.
> 
> What features does the dual EMAC firmware support which the switch
> firmware does not?
> 

Feature wise, there is no major feature that EMAC firmware supports and
switch firmware doesn't.

The major difference between EMAC and switch firmware is that switch
firmware can do forwarding between ports which EMAC firmware can't. Data
is directly forwarded to DMA in dual EMAC mode. Whereas switch firmware
forwards the data to DMA as well as the other port depending upon the
configured rules. The forwarding path between one port to other is not
present in dual EMAC firmware. There are additional checks in switch
firmware to decide forwarding which also results in consuming extra cpu
cycle.

In dual EMAC mode, data is directly forwarded to DMA and a lot of checks
are removed resulting in less cpu cycle consumption.

> If such features are in use, you should not reload firmware to the
> switch firmware, since it will break whatever has been
> configured. Keep with bridging in software.
> 

There are no such features so I think it's safe to reload the switch
firmware when two ICSSG interfaces are added to the same bridge.

> Similarly, what features are supported by both firmwares? Does feature
> configuration survive a firmware reload? Or is it necessary to pass
> all the configuration to the firmware again?
> 

Some configurations doesn't need to be passed again. Any changes to MSMC
will still be valid after firmware reload. But FDB, r30 commands will be
lost and will be needed to reconfigured. So all FDB entries and r30
commands will need to be run again.

>     Andrew

-- 
Thanks and Regards,
Danish

