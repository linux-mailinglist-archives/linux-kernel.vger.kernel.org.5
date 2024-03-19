Return-Path: <linux-kernel+bounces-107324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE6787FB14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CEB1C21C07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EA7D3F3;
	Tue, 19 Mar 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m8wbKzAe"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299937D083;
	Tue, 19 Mar 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841839; cv=none; b=WJE7NW0tQtndTyLzxGBfaflkOMcVCfFgrg69y8J0wF0HhP06H8tR7iKIi9a+R2mgoJVpT46E41iJplzF/LEQ/sWGwj8Cng0HCg/ctlbewTnZJsERuBl0ALTczrAOkvaVV80jJ2IIFSmjcQiwI0NPxeRWSz3tUDwm2kyXA2bCo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841839; c=relaxed/simple;
	bh=uog1aCHo9X59jBP1k+H/l+t8LVVbeyBEUoASSwQnj1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=CTWIecK7iwchPhwchTWsIkBpbOAnMMp8TH7ExW5peygu11QpMLriVYm16fCZwJjDjAhr6xAfR13aVjI6EBOr3hKGEdpWymuOrA5gavER2yaJDC2bo1mO+WvK/PkJTjAijKvRQmAJcKFBJPOr4uHgXaw06vP16iaLeUen8pJnofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m8wbKzAe; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42J9nqjX067000;
	Tue, 19 Mar 2024 04:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710841792;
	bh=/VL50LnMLdQzwi7rjdcIJajEpjs6k07UPACDYymnBLU=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=m8wbKzAemnQ9g5FWiQO6TYuX7XirEpsFNvh4/aHlMV8eRM3/JXac8oHNHdrXTid+Z
	 uOWowNYgE3+9+0E2aeNcPHj++6rBf71GT/XJUll95bdHfU+4PKmAmuxPh7O5LP9VW0
	 8FWMJlf6mATcpci8Flhh8V61Q0ULDW2lvLendhH4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42J9np9m020640
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 04:49:52 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 04:49:51 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 04:49:51 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42J9nh3m034183;
	Tue, 19 Mar 2024 04:49:45 -0500
Message-ID: <80b30fb7-48fe-47c0-ba1e-fd3e207909df@ti.com>
Date: Tue, 19 Mar 2024 15:19:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] net: ti: icssg-switch: Add switchdev based
 driver for ethernet switch support
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
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
 <20240118071005.1514498-3-danishanwar@ti.com>
 <3ea8934e-c41f-4366-a0c4-1894ed4e3d7e@lunn.ch>
 <e7328eaa-ac76-4fe9-9173-0ff92c312815@ti.com>
In-Reply-To: <e7328eaa-ac76-4fe9-9173-0ff92c312815@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 22/01/24 4:38 pm, MD Danish Anwar wrote:
> 
> On 19/01/24 7:42 pm, Andrew Lunn wrote:
>>> +static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
>>> +					  u8 state)
>>> +{
>>> +	enum icssg_port_state_cmd emac_state;
>>> +	int ret = 0;
>>> +
>>> +	switch (state) {
>>> +	case BR_STATE_FORWARDING:
>>> +		emac_state = ICSSG_EMAC_PORT_FORWARD;
>>> +		break;
>>> +	case BR_STATE_DISABLED:
>>> +		emac_state = ICSSG_EMAC_PORT_DISABLE;
>>> +		break;
>>> +	case BR_STATE_LEARNING:
>>> +	case BR_STATE_LISTENING:
>>> +	case BR_STATE_BLOCKING:
>>> +		emac_state = ICSSG_EMAC_PORT_BLOCK;
>>> +		break;
>>
>> That is unusual. Does it still learn while in BLOCK? It might be you
>> need to flush the FDB for this port when it changes from BLOCKING to
>> LISTENING or LEARNING?
> 
> ICSSG firmware supports four different states,
> 1. ICSSG_EMAC_PORT_DISABLE - port is in completed disable state and no
> traffic is being processed.
> 2. ICSSG_EMAC_PORT_BLOCK - All traffic is blocked except for special
> packets (eg LLDP BPDU frames)
> 3. ICSSG_EMAC_PORT_FORWARD - Port is fully active and every packet is
> being processed. The port will also learn the mac address.
> 4. ICSSG_EMAC_PORT_FORWARD_WO_LEARNING - Port is fully active and every
> packet is being processed but the port will also learn the mac address.
> 
> We don't have any state where we only learn and not do the forwarding.
> So for BR_STATE_LISTENING and BR_STATE_BLOCKING I think state
> ICSSG_EMAC_PORT_BLOCK is OK. For learning I am not sure what should be
> the state. If both learning and forwarding is OK then we can set the
> state to BR_STATE_FORWARDING.
> 

I have got confirmation from firmware team regarding "Does it still
learn while in BLOCK?"

ICSSG does not learn in BLOCK state. Learning will be done in Forwading
mode only. The ICSSG firmware doesn't support any state where "the port
will accept traffic only for the purpose of updating MAC address tables."

We only learn in forwarding mode where the packets is forwarded as well.

So, this will be the handling of different states by ICSSG firmware.

	switch (state) {
	case BR_STATE_FORWARDING:
		emac_state = ICSSG_EMAC_PORT_FORWARD;
		break;
	case BR_STATE_DISABLED:
		emac_state = ICSSG_EMAC_PORT_DISABLE;
		break;
	case BR_STATE_LISTENING:
	case BR_STATE_BLOCKING:
		emac_state = ICSSG_EMAC_PORT_BLOCK;
		break;
	default:
		return -EOPNOTSUPP;
	}

I will make this change and other changes requested in this series and
post a v3 soon. Please let me know if you have any question.

>>
>>> +static void prueth_switchdev_event_work(struct work_struct *work)
>>> +{
>>> +	struct prueth_switchdev_event_work *switchdev_work =
>>> +		container_of(work, struct prueth_switchdev_event_work, work);
>>> +	struct prueth_emac *emac = switchdev_work->emac;
>>> +	struct switchdev_notifier_fdb_info *fdb;
>>> +	int port_id = emac->port_id;
>>> +	int ret;
>>> +
>>> +	rtnl_lock();
>>> +	switch (switchdev_work->event) {
>>> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
>>> +		fdb = &switchdev_work->fdb_info;
>>> +
>>> +		netdev_dbg(emac->ndev, "prueth_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
>>> +			   fdb->addr, fdb->vid, fdb->added_by_user,
>>> +			   fdb->offloaded, port_id);
>>> +
>>> +		if (!fdb->added_by_user)
>>> +			break;
>>> +		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>>> +			break;
>>
>> ether_addr_equal(). Please review all the code and use these helpers
>> when possible.
> 
> Sure.
> 
>>
>> So you don't add an FDB for the interfaces own MAC address? Does the
>> switch know the interfaces MAC address?
>>
> 
> Interface's own mac address isn't needed to be added to FDB. Switch
> already knows the interfaces mac_addr as during emac_ndo_open() we do
> write the interface's mac_addr to MII_G_RT register [1] and adding the
> mac_addr to MII_G_RT register is enough to let the firmware know.
> 
> In case we want interface to have more than 1 mac_addr, the the extra
> mac_addr needs to be added to FDB.
> 
>>        Andrew
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/ti/icssg/icssg_prueth.c?h=v6.8-rc1#n1329
> 
> Thanks for the reviews and comments on all the patches. Please let me
> know if more changes are needed in this series.
> 

-- 
Thanks and Regards,
Danish

