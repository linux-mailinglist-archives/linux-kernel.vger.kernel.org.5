Return-Path: <linux-kernel+bounces-163717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798B8B6EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFE11F22E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE84E128832;
	Tue, 30 Apr 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iUK3XQOI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AB0FC02;
	Tue, 30 Apr 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470207; cv=none; b=NbFQipzfLCyKY9FeFIMRmqpigfZFXZ+g2A6DUY7UwTJ4n0L65CF9nAEufGCSnredazVG7ngGcMgp9P1lLoYb0QL0xEJvqpZf71chgL/OYgYUCJ9M4hlClAwsn9osU/8eoLyMGAStpj8Duo8KI55W/ltflQNXLCTRNUwCq/78D4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470207; c=relaxed/simple;
	bh=nNKDIj70f3OJGWN1Jm4FkGhksBWfcRNnPzERl/P+L04=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=As52lV9IpIQYbhQOAKXrP8cpfrQL0oH6KQPq5yDhakdlGTLTPdhhAPQ4w1R9t7YFW8SU+7+WZWKkpZuMVjrQ9/9QHNa6L+2TaBZQ35Fvoth/McDumjRyDvJbTmetPicv4fWzCB/DPC8wRK980le6n9f+efYb/54qUAu87IJfPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iUK3XQOI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43U9h4RO117308;
	Tue, 30 Apr 2024 04:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714470184;
	bh=+IMEMRV4HyNtb8jDdykw1iuOP3rGaHot5KjqWPyTFWU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iUK3XQOIrpBS+qF6c8ScfbmCK2GhgKKB1XdNkodMkDnm2eSKPpY4+guqzg/yOlma/
	 d1XQxvxn80nwMBvXFzPr7iJk3UiZ77WzMnOkxyHcD+jHW9pP5dQINke6UazV65lCEb
	 I9jX5ORczEt3bQNX3NrPp3UZnYrNdl0JDVpWnXys=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43U9h4d4110151
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 04:43:04 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 04:43:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 04:43:04 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43U9gxu1031409;
	Tue, 30 Apr 2024 04:42:59 -0500
Message-ID: <5b7cf22a-ca91-4975-bd26-c76a16781ad7@ti.com>
Date: Tue, 30 Apr 2024 15:12:58 +0530
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

Simon,

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

[ ... ]
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

For both of these if checks, by having {} for outer if I am not seeing
the warnings anymore. The braces don't seem to be neccessary for inner if.

For both of these ifs I'll keep both inner and outer ifs in braces as
this will help readablity as Dan pointed out.

I will post v3 with this change.

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

