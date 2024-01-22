Return-Path: <linux-kernel+bounces-32869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3583836125
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3F1F2369C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621F3D549;
	Mon, 22 Jan 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gbxtwbdr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3263D548;
	Mon, 22 Jan 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921748; cv=none; b=db0GTuHAfmWD0ebfiTX9bbYA0XsLPET8ResaRCt06Y7vDsKjAuD55wv+ZyT71YuoGdJG9PEi0BesAZcm27FU9SXDk37oGILNq8ws521dKkp3rf8giepv66DUBhMhQ0k8S/JFkAgoHc3GrFHQ69wIi7viVTch+YvIp5m/sJlQifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921748; c=relaxed/simple;
	bh=eeltPZ2NiT0CfWaOvBWJTcc8YkSM0Sit2VAouO0viHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q1A4NFsplEcb2KlbzbvoIxL5WsL22EgokFyrMbtzWjajLFMPpGA23lipCPthm+scyfNNV74LhaBRCX595esNuTZW+RmrOO1/jpGse83wOM4e6s5oA+cDM67+X4ckCEu1m+LEN70to1jYP5yufi9oO18X2PiI9ZIbjE1fxhEtZXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gbxtwbdr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40MB8fP4011812;
	Mon, 22 Jan 2024 05:08:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705921721;
	bh=70+2QivnfENxsqhg9qEX9Q5T8tBv+T64OCDj1isNU1w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GbxtwbdrPyBC/1R14U/6xhMyFjkqrZArlx00siNnbrGE8aMqgmpRV6tZh9CXXE5sn
	 2ENCDOX/pEGfZNNGNYPMx0tSE9sLkuAoA5S92tHw7M2Uf4Fnt1cEFXOJs1gsd2BHVT
	 WycanLTvFQAren9t+AOnAGjcnYIYtkmm2aXSOAEs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40MB8fEk076694
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Jan 2024 05:08:41 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Jan 2024 05:08:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Jan 2024 05:08:41 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40MB8ZHe087837;
	Mon, 22 Jan 2024 05:08:36 -0600
Message-ID: <e7328eaa-ac76-4fe9-9173-0ff92c312815@ti.com>
Date: Mon, 22 Jan 2024 16:38:35 +0530
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
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <3ea8934e-c41f-4366-a0c4-1894ed4e3d7e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 19/01/24 7:42 pm, Andrew Lunn wrote:
>> +static int prueth_switchdev_stp_state_set(struct prueth_emac *emac,
>> +					  u8 state)
>> +{
>> +	enum icssg_port_state_cmd emac_state;
>> +	int ret = 0;
>> +
>> +	switch (state) {
>> +	case BR_STATE_FORWARDING:
>> +		emac_state = ICSSG_EMAC_PORT_FORWARD;
>> +		break;
>> +	case BR_STATE_DISABLED:
>> +		emac_state = ICSSG_EMAC_PORT_DISABLE;
>> +		break;
>> +	case BR_STATE_LEARNING:
>> +	case BR_STATE_LISTENING:
>> +	case BR_STATE_BLOCKING:
>> +		emac_state = ICSSG_EMAC_PORT_BLOCK;
>> +		break;
> 
> That is unusual. Does it still learn while in BLOCK? It might be you
> need to flush the FDB for this port when it changes from BLOCKING to
> LISTENING or LEARNING?

ICSSG firmware supports four different states,
1. ICSSG_EMAC_PORT_DISABLE - port is in completed disable state and no
traffic is being processed.
2. ICSSG_EMAC_PORT_BLOCK - All traffic is blocked except for special
packets (eg LLDP BPDU frames)
3. ICSSG_EMAC_PORT_FORWARD - Port is fully active and every packet is
being processed. The port will also learn the mac address.
4. ICSSG_EMAC_PORT_FORWARD_WO_LEARNING - Port is fully active and every
packet is being processed but the port will also learn the mac address.

We don't have any state where we only learn and not do the forwarding.
So for BR_STATE_LISTENING and BR_STATE_BLOCKING I think state
ICSSG_EMAC_PORT_BLOCK is OK. For learning I am not sure what should be
the state. If both learning and forwarding is OK then we can set the
state to BR_STATE_FORWARDING.

> 
>> +static void prueth_switchdev_event_work(struct work_struct *work)
>> +{
>> +	struct prueth_switchdev_event_work *switchdev_work =
>> +		container_of(work, struct prueth_switchdev_event_work, work);
>> +	struct prueth_emac *emac = switchdev_work->emac;
>> +	struct switchdev_notifier_fdb_info *fdb;
>> +	int port_id = emac->port_id;
>> +	int ret;
>> +
>> +	rtnl_lock();
>> +	switch (switchdev_work->event) {
>> +	case SWITCHDEV_FDB_ADD_TO_DEVICE:
>> +		fdb = &switchdev_work->fdb_info;
>> +
>> +		netdev_dbg(emac->ndev, "prueth_fdb_add: MACID = %pM vid = %u flags = %u %u -- port %d\n",
>> +			   fdb->addr, fdb->vid, fdb->added_by_user,
>> +			   fdb->offloaded, port_id);
>> +
>> +		if (!fdb->added_by_user)
>> +			break;
>> +		if (memcmp(emac->mac_addr, (u8 *)fdb->addr, ETH_ALEN) == 0)
>> +			break;
> 
> ether_addr_equal(). Please review all the code and use these helpers
> when possible.

Sure.

> 
> So you don't add an FDB for the interfaces own MAC address? Does the
> switch know the interfaces MAC address?
> 

Interface's own mac address isn't needed to be added to FDB. Switch
already knows the interfaces mac_addr as during emac_ndo_open() we do
write the interface's mac_addr to MII_G_RT register [1] and adding the
mac_addr to MII_G_RT register is enough to let the firmware know.

In case we want interface to have more than 1 mac_addr, the the extra
mac_addr needs to be added to FDB.

>        Andrew

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/ti/icssg/icssg_prueth.c?h=v6.8-rc1#n1329

Thanks for the reviews and comments on all the patches. Please let me
know if more changes are needed in this series.

-- 
Thanks and Regards,
Danish

