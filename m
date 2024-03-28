Return-Path: <linux-kernel+bounces-122455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8088F7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E029CAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC024F5FC;
	Thu, 28 Mar 2024 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A+l+pys6"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3061CAAC;
	Thu, 28 Mar 2024 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606221; cv=none; b=chK5rQkxyIEcanavR4KjB0Y60E5bgQsmhtbaDyzFaG2siT4rWL+XQUxPmAhL8tewoGxKqGiEuUbAY/EwoIZratKiPC/fozl83Eilmbf6Yk+IiJJCEfor8/XRQl4+AKasNSlbzsb2neLZPBoHm7M5Lu1hOCFQC9Hli6nDME561Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606221; c=relaxed/simple;
	bh=f827W552AcLk4Fd3qgu2RaZ4mLJcPreNh8vnCtreCcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HuTE7gERrl2tFuedWCrRLVaaiBytmCrjLJio04XS7vxlWTIcLChTO9SUVmYk2dE0UzldNC4H/HiYRw7ZnVFbSiAr4FMN8yFVXGPx4+jnHyPWMJLtaKQiSO+PsILIgXa1OPlGuw95YHo7Zlk6KzvVSMr6kqOTmZwwuH8+uQQaY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A+l+pys6; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42S69g9i000766;
	Thu, 28 Mar 2024 01:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711606182;
	bh=JrzMOdxfOHPP/UN6vNlxvG+mwBhM9McFbLhDU4FrLFE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=A+l+pys6wcMdSU+uzmQmZGuBV3PX4uct+U6yF2clBsdxOR6gyqaQkDAHTfi3brfPp
	 DuJq36vLp+MOWOAfEtN+qvAOJ+OjgdSfyCMG+uJ/O2kvgIUmRuldjAAbummf2t/c1/
	 QaYfV0eIqpGQNm8WAcVqvUUtCpbmzqcGJ2zAZeS8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42S69gZn016311
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 01:09:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 01:09:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 01:09:42 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42S69YaD029568;
	Thu, 28 Mar 2024 01:09:34 -0500
Message-ID: <c94815f8-798a-4167-8f69-359b9b28b7ce@ti.com>
Date: Thu, 28 Mar 2024 11:39:33 +0530
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
To: Andrew Lunn <andrew@lunn.ch>
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
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <27d960ed-8e67-431b-a910-e6b2fc12e292@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 27/03/24 6:05 pm, Andrew Lunn wrote:
> On Wed, Mar 27, 2024 at 05:10:54PM +0530, MD Danish Anwar wrote:
>> Add support for ICSSG switch firmware using existing Dual EMAC driver
>> with switchdev.
>>
>> Limitations:
>> VLAN offloading is limited to 0-256 IDs.
>> MDB/FDB static entries are limited to 511 entries and different FDBs can
>> hash to same bucket and thus may not completely offloaded
>>
>> Switch mode requires loading of new firmware into ICSSG cores. This
>> means interfaces have to taken down and then reconfigured to switch
>> mode.
> 
> Patch 0/3 does not say this. It just shows the interfaces being added

I will modify the cover letter to state that.

> to the bridge. There should not be any need to down the interfaces.
> 

The interfaces needs to be turned down for switching between dual emac
and switch mode.

Dual Emac mode runs with ICSSG Dual Emac firmware where as Switch mode
works with ICSSG Switch firmware. These firmware are running on the
dedicated PRU RPROC cores (pru0, rtu0, txpru0). When switch mode is
enabled, these pru cores need to be stopped and then Switch firmware is
loaded on these cores and then the cores are started again.

We stop the cores when interfaces are down and start the cores when
interfaces are up.

In short, Dual EMAC firmware runs on pru cores, we put down the
interface, stop pru cores, load switch firmware on the cores, bring the
interface up and start the pru cores and now Switch mode is enabled.


>> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
>>
>> Switch to ICSSG Switch mode:
>>  ip link set dev eth1 down
>>  ip link set dev eth2 down
>>  ip link add name br0 type bridge
>>  ip link set dev eth1 master br0
>>  ip link set dev eth2 master br0
>>  ip link set dev br0 up
>>  ip link set dev eth1 up
>>  ip link set dev eth2 up
>>  bridge vlan add dev br0 vid 1 pvid untagged self
>>
>> Going back to Dual EMAC mode:
>>
>>  ip link set dev br0 down
>>  ip link set dev eth1 nomaster
>>  ip link set dev eth2 nomaster
>>  ip link set dev eth1 down
>>  ip link set dev eth2 down
>>  ip link del name br0 type bridge
>>  ip link set dev eth1 up
>>  ip link set dev eth2 up
>>
>> By default, Dual EMAC firmware is loaded, and can be changed to switch
>> mode by above steps
> 
> I keep asking this, so it would be good to explain it in the commit
> message. What configuration is preserved over a firmware reload, and
> what is lost?
> 
> Can i add VLAN in duel MAC mode and then swap into the switch firmware
> and all the VLANs are preserved? Can i add fdb entries to a port in
> dual MAC mode, and then swap into the swtich firmware and the FDB
> table is preserved? What about STP port state? What about ... ?
> 

When ports are brought up (firmware reload) we do a full cleaning of all
the shared memories i.e. SMEM (shared RAM). [1]

Vlan table and FDB table are stored in SMEM so all the configuration
done to VLAN / FDB tables will be lost.

We don't clear DRAM. DRAM is used for sending r30 commands [see
emac_r30_cmd_init()], configure half duplex [see
icssg_config_half_duplex()] and configure link speed [see
icssg_config_set_speed()]. r30 commands are used to set port state (stp).

Now when the interfaces are brought up (firmware reload) r30 command is
reconfigured as a result any changes done to port state (stp) will be
lost. But the duplex and speed settings will be preserved.

To summarize,
VLAN table / FDB table and port states are lost during a firmware reload.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/icssg/icssg_prueth.c#L1321
> 
>> +bool prueth_dev_check(const struct net_device *ndev)
>> +{
>> +	if (ndev->netdev_ops == &emac_netdev_ops && netif_running(ndev)) {
>> +		struct prueth_emac *emac = netdev_priv(ndev);
>> +
>> +		return emac->prueth->is_switch_mode;
>> +	}
>> +
>> +	return false;
>> +}
> 
> This does not appear to be used anywhere?
> 
>      Andrew

-- 
Thanks and Regards,
Danish

