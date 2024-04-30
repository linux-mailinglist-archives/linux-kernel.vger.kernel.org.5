Return-Path: <linux-kernel+bounces-163353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4748B69BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E282E1C21E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6917C95;
	Tue, 30 Apr 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JhcXc03K"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8451798C;
	Tue, 30 Apr 2024 05:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453853; cv=none; b=uBgxGzVmqFinXo69DfKTVBeKZKtaVBj++5sH5GWd1CZ4pNrB1g2MxWoon7cF1V+RRjZNDVld70DhRw7zUw4+OX1NLRvXh4sJZIuI/ktj5gWvlVYGBPCfpZC7hmZGh8ty75e/7o1MNpihexH8kwwUaFTb5YjNImH0dAMRogskfoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453853; c=relaxed/simple;
	bh=d/b4zlbqpIEY9DLFq4hSauJ4swz+iTTcDpUDBrY2dIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qMPT2K+/VR4EyoA0v3hi+cium650zOoeeMSMUSIsfyQnzI5M3v3OFSUhMOug6SzEHPtDj9LxuKl0SL/PkAfBea5cIpNyf+kujnm2atQZK9BBD25rpAeUAkjz2oZea8A9iZwKkVgYVlBLx0pVbnoJY4P1nghk5fh+Vjbi0sUE9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JhcXc03K; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U5Aafj037952;
	Tue, 30 Apr 2024 00:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714453836;
	bh=tkSk8wJzJEVYrw0AlW1nQjgNmnwnpS8NgdvNoTuoYos=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JhcXc03KP1fF0I7PCNuZIJl0uIrnLxgXMxv1byRI2Pdviip2mRj41lfWsDYD87OlM
	 CSDjh/c2ltRuIaZ1y3r1uyMIM9TDwUsyt4tfdxiW6E57lAfibT9jPQXy7gNfZiN+Vv
	 ykJQofBqWwIz6li8Tb02CVEy0fr1Hn4Ta48XnQRo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U5AajI003539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 00:10:36 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 00:10:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 00:10:35 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U5AUcF008960;
	Tue, 30 Apr 2024 00:10:31 -0500
Message-ID: <579faebd-1dd3-4665-b5d7-6939d9cc1ad4@ti.com>
Date: Tue, 30 Apr 2024 10:40:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240429071501.547680-1-danishanwar@ti.com>
 <20240429183034.GG516117@kernel.org>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240429183034.GG516117@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 30/04/24 12:00 am, Simon Horman wrote:
> On Mon, Apr 29, 2024 at 12:45:01PM +0530, MD Danish Anwar wrote:
>> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
>> driver, which can be enabled by ethtool commands:
>>
>> - RX coalescing
>>   ethtool -C eth1 rx-usecs 50
>>
>> - TX coalescing can be enabled per TX queue
>>
>>   - by default enables coalesing for TX0
> 
> nit: coalescing
> 
> Please consider running patches through ./checkpatch --codespell
> 
>>   ethtool -C eth1 tx-usecs 50
>>   - configure TX0
>>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>>   - configure TX1
>>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>>   - configure TX0 and TX1
>>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
>> tx-usecs 100
>>
>> Minimum value for both rx-usecs and tx-usecs is 20us.
>>
>> Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
>> to enable IRQ coalescing for RX path separately.
>>
>> Benchmarking numbers:
>>  ===============================================================
>> | Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
>> | ==============================================================
>> | Default Driver           943 Mbps    31%      517 Mbps  38%   |
>> | IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
>>  ===============================================================
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>> Changes from v1 [1] to v2:
>> *) Added Benchmarking numbers in the commit message as suggested by
>>    Andrew Lunn <andrew@lunn.ch>. Full logs [2]
>> *) Addressed comments given by Simon Horman <horms@kernel.org> in v1.
> 
> Sorry to be bothersome, but the W=1 problem isn't entirely fixed.
> 

I'll check with W=1 and fix the warnings. I'll repost it soon.

>>
>> [1] https://lore.kernel.org/all/20240424091823.1814136-1-danishanwar@ti.com/
>>
>> [2] https://gist.githubusercontent.com/danish-ti/47855631be9f3635cee994693662a988/raw/94b4eb86b42fe243ab03186a88a314e0cb272fd0/gistfile1.txt
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> 
> ...
> 
>> @@ -190,19 +191,37 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>  	return num_tx;
>>  }
>>  
>> +static enum hrtimer_restart emac_tx_timer_callback(struct hrtimer *timer)
>> +{
>> +	struct prueth_tx_chn *tx_chns =
>> +			container_of(timer, struct prueth_tx_chn, tx_hrtimer);
>> +
>> +	enable_irq(tx_chns->irq);
>> +	return HRTIMER_NORESTART;
>> +}
>> +
>>  static int emac_napi_tx_poll(struct napi_struct *napi_tx, int budget)
>>  {
>>  	struct prueth_tx_chn *tx_chn = prueth_napi_to_tx_chn(napi_tx);
>>  	struct prueth_emac *emac = tx_chn->emac;
>> +	bool tdown = false;
>>  	int num_tx_packets;
>>  
>> -	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget);
>> +	num_tx_packets = emac_tx_complete_packets(emac, tx_chn->id, budget,
>> +						  &tdown);
>>  
>>  	if (num_tx_packets >= budget)
>>  		return budget;
>>  
>> -	if (napi_complete_done(napi_tx, num_tx_packets))
>> -		enable_irq(tx_chn->irq);
>> +	if (napi_complete_done(napi_tx, num_tx_packets)) {
>> +		if (unlikely(tx_chn->tx_pace_timeout_ns && !tdown)) {
>> +			hrtimer_start(&tx_chn->tx_hrtimer,
>> +				      ns_to_ktime(tx_chn->tx_pace_timeout_ns),
>> +				      HRTIMER_MODE_REL_PINNED);
>> +		} else {
>> +			enable_irq(tx_chn->irq);
>> +		}
> 
> This compiles with gcc-13 and clang-18 W=1
> (although the inner {} are unnecessary).
> 
>> +	}
>>  
>>  	return num_tx_packets;
>>  }
> 
> ...
> 
>> @@ -872,7 +894,13 @@ int emac_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>  	}
>>  
>>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx))
>> -		enable_irq(emac->rx_chns.irq[rx_flow]);
>> +		if (unlikely(emac->rx_pace_timeout_ns)) {
>> +			hrtimer_start(&emac->rx_hrtimer,
>> +				      ns_to_ktime(emac->rx_pace_timeout_ns),
>> +				      HRTIMER_MODE_REL_PINNED);
>> +		} else {
>> +			enable_irq(emac->rx_chns.irq[rx_flow]);
>> +		}
> 
> But this does not; I think outer (but not inner) {} are needed.
> 
> FIIIW, I believe this doesn't show-up in the netdev automated testing
> because this driver isn't built for x86 allmodconfig.
> 
>>  
>>  	return num_rx;
>>  }
> 
> ...
> 

-- 
Thanks and Regards,
Danish

