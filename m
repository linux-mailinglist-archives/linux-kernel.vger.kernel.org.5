Return-Path: <linux-kernel+bounces-144624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C111F8A487D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A80280FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B46200DE;
	Mon, 15 Apr 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="et+Y+WYJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F095F1BC46;
	Mon, 15 Apr 2024 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164246; cv=none; b=QTMCCRe0z7ZbA87Ifw4ENbFYd15xELbcIl/x63MnDQyIIUmrESVlIcOafGW5yZSWmxXgAzhOYkITS2gLMRiIBegK0TAzDjR6DYvBQKmqNBX+6f+f03s6sjeh2yXqS6dCefMFC3jLkMyKvojYMLLsg0haTBNDzbpIi3Tc5dzv6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164246; c=relaxed/simple;
	bh=kp9SZdqu6FXz7Y+uk+Nkkh38Y5CNMrzWvIioBS1u7Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZizdC8KOXg+3ZFwsf3k8DnuH+ujjTZ4af+14c/fL0ax5trir/VQYgjpdd5EjpOMN27wmCAPOjwwIdizJd578QaQM0j9cwpuGJoWmbWNQlk4SqunjLz2OQN619xygbsIn0kdIApFezT2YyhkUNOqPJeu2wo2TncFWP9bbGz7PJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=et+Y+WYJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F6uuEi080497;
	Mon, 15 Apr 2024 01:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713164216;
	bh=NdjuQJ+BBEBh/Ujjsk+4RlDODoYVfYEtT/fVGYfVWks=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=et+Y+WYJHPR1X58rYhWYN8jMldMLvl9qKMwihGAX4/NEmCh5SKaG0ANOFz+zuxE92
	 8xvhlLVwx3zck/oJilULopChx5kahqkUuYgbm+0uzs4mSZ/HZ99ANnsSdIVPfKSB1B
	 M0rwcBOijXLS2Cqxq67769tlK9GKtylnGL9VV0Go=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F6uux9007585
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Apr 2024 01:56:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 01:56:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 01:56:56 -0500
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F6unjD106034;
	Mon, 15 Apr 2024 01:56:50 -0500
Message-ID: <bc0e05c5-11a8-4519-b50d-04dabd6e5999@ti.com>
Date: Mon, 15 Apr 2024 12:26:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware
To: Andrew Davis <afd@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
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
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <cb13da4a-13c9-409a-a813-0ac852062163@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 4/13/2024 12:22 AM, Andrew Davis wrote:
> On 3/27/24 6:40 AM, MD Danish Anwar wrote:
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
>>
>> Example assuming ETH1 and ETH2 as ICSSG2 interfaces:
>>
>> Switch to ICSSG Switch mode:
>>   ip link set dev eth1 down
>>   ip link set dev eth2 down
>>   ip link add name br0 type bridge
>>   ip link set dev eth1 master br0
>>   ip link set dev eth2 master br0
>>   ip link set dev br0 up
>>   ip link set dev eth1 up
>>   ip link set dev eth2 up
>>   bridge vlan add dev br0 vid 1 pvid untagged self
>>
>> Going back to Dual EMAC mode:
>>
>>   ip link set dev br0 down
>>   ip link set dev eth1 nomaster
>>   ip link set dev eth2 nomaster
>>   ip link set dev eth1 down
>>   ip link set dev eth2 down
>>   ip link del name br0 type bridge
>>   ip link set dev eth1 up
>>   ip link set dev eth2 up
>>
>> By default, Dual EMAC firmware is loaded, and can be changed to switch
>> mode by above steps
>>
> 
> This was asked before, maybe I missed the answer, but why do we
> default to Dual-EMAC firmware? I remember when I was working on
> the original ICSS-ETH driver, we started with the Dual-EMAC
> firmware as the switch firmware was not ready yet (and EMAC mode
> was easier). Now that we have both available, if we just use Switch
> firmwar by default, what would we lose? Seems that would solve
> the issues with re-loading firmware at runtime (configuration loss
> and dropping packets, etc..).
> 

We can start the driver with either Dual-EMAC firmware or SWITCH
firmware. But the problem lies in switching between these two firmwares.
For switching to / from Dual-EMAC and switch firmwares we need to stop
the cores and that is where we previously used to bring down the
interfaces, switch firmware and bring it up again. But as discussed on
this thread, I can now do the same without bringing interfaces up /
down. We'll just need to stop the cores and change firmware this will
also result in preserving the configuration. There will be packet loss
but that will not be a big concern as Andrew L. pointed out.

Currently we are starting in Dual-EMAC mode as by default the interfaces
are not needed to forward packets. They are supposed to act as
individual ports. Port to port forwarding is not needed. Only when user
adds a bridge and starts forwarding we switch to Switch mode and load
different firmware so that packet forwarding can happen in firmware.
That is why currently we are starting Dual-EMAC mode and then switching
to firmware.

If we use switch firmware by default, we will not be able to use
individual ports separately and any data sent to one port will be
forwarded to the second port.

I will be posting v4 soon and I will describe all the details on how to
use and switch between different modes in the cover letter.

> Andrew
> 

[ ... ]

>>     static const struct prueth_pdata am64x_icssg_pdata = {
>>       .fdqring_mode = K3_RINGACC_RING_MODE_RING,
>> +    .switch_mode = 1,
>>   };
>>     static const struct of_device_id prueth_dt_match[] = {

-- 
Thanks and Regards,
Md Danish Anwar

