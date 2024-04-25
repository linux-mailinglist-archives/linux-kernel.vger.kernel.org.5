Return-Path: <linux-kernel+bounces-158486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9C8B20CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C871C21117
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3832F12B159;
	Thu, 25 Apr 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dng4M3qQ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A885274;
	Thu, 25 Apr 2024 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046254; cv=none; b=FtqB1zgeKCRDfXdk08w1Jb7lhVtF2qoenHIOEpfEvozDuMN9U4X/1yYbitHo/fB+xqXkn0TNXZaNmDOMQM5qdXowDp9E3XlEd1kiQ60w4hy97+Ypg3e0VjcYNUajcPdYljd7tblolcdn5m2tBA6pnHrMtyGQu3YqTmQ3Zvfg5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046254; c=relaxed/simple;
	bh=7uq2uY0Ys0ivugvgfajawnQtub7+oSvzDAS77t/I1q0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=XN80PuVsfFVdsPSobqXoROQ6PgcdvW2PME5HH085WFQay6B4m2cmY7PesLCx0IxngYrJtTjJr3FIu645XwmqMS1of1bqgllbbXWNHNH2RWcRq8wlves4HjyXRLFiuS949AOyIB46zZCJtS2fO+RsEn5piZwYwurrzoFiT+ltIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dng4M3qQ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PBv9BN013919;
	Thu, 25 Apr 2024 06:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714046229;
	bh=XGs43/u3uem7yqAA7OT6OEKLkrxr4H8yBUmDsRcElWI=;
	h=Date:From:Subject:To:CC:References:In-Reply-To;
	b=dng4M3qQpKNEVq8Hm+zrJciDoVBMaV3lyh3OtM9/5Hallu0VxqCqtIYh1ldiB67pF
	 oH4tVZKifqrq7dqySNqQm/HQMQNF8bb2R+sQpDT2B/jXDiH5webJ+69km4hZEiFocq
	 bjfk9wW9VodNydnUoCpwmM8FActCpxQBgqH6k7YI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PBv9IF001210
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 06:57:09 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 06:57:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 06:57:08 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PBv3nQ038298;
	Thu, 25 Apr 2024 06:57:04 -0500
Message-ID: <e311f2c9-f396-41ae-b78b-7bf8efafe066@ti.com>
Date: Thu, 25 Apr 2024 17:27:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: MD Danish Anwar <danishanwar@ti.com>
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <20240118012714.gzgmfwzb6tuuyofs@skbuf>
Content-Language: en-US
In-Reply-To: <20240118012714.gzgmfwzb6tuuyofs@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18/01/24 6:57 am, Vladimir Oltean wrote:
> On Mon, Jan 15, 2024 at 12:24:12PM +0530, MD Danish Anwar wrote:
>>> I believe the intention is for this code to be run before any taprio
>>> offload is added, correct? But it is possible for the user to add an
>>
>> Yes, the intention here is to run this code before any taprio offload is
>> added.
> 
> Then it is misplaced?
> 

Where should I move it then? Perhaps to end of prueth_probe()?
If this is moved to prueth_probe() then it will mean it's always called.
If user adds an offloaded Qdisc even while the netdev has not yet been
brought up, it will not result into any error

>>> offloaded Qdisc even while the netdev has not yet been brought up.
>>> Is that case handled correctly, or will it simply result in NULL pointer
>>> dereferences (tas->config_list)?
>>>
>>
>> In that case, it will eventually result in NULL pointer dereference as
>> tas->config_list will be pointing to NULL. To handle this correctly we
>> can add the below check in emac_taprio_replace().
>>
>> if (!ndev_running(ndev)) {
>> 	netdev_err(ndev, "Device is not running");
>> 	return -EINVAL;
>> }
> 
> What is the reason for which the device has to be running, other than
> your placement of icssg_qos_tas_init()?
> 

Yes, I only suggested this check for that. If icssg_qos_tas_init() is
handled correctly and called before user adds qdisc, this cheeck will no
longer be needed.

>>>> +
>>>> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
>>>
>>> Details? Doesn't this make the phase alignment of the schedule diverge
>>> from what the user expects?
>>
>> 4ns is needed to compensate for IEP wraparound time. IEP is the clock
>> used by ICSSG driver. IEP tick is 4ns and we adjust this 4ns whenever
>> calculating cycle_time. You may refer to [1] for details on IEP driver.
> 
> What is understood by "IEP wraparound time"? Its time wraps around what?

IEP clock runs at 250 MHz, 1 tick of IEP clock = NSEC_PER_SEC /
iep->refclk_freq i.e. 1000000000 / 250000000 = 4ns.

Thus 1 tick of IEP clock is 4ns.

> It wraps around exactly once every taprio cycle of each port and that's
> why the cycle-time is compensated, or how does that work?
> 

Yes, it wraps around exactly once every taprio cycle and to compensate
for that we adjust 4ns. Instead of hardcoding I will use a varaible here.

It is a hardware errata but it is not public yet.


>>>
>>>> +	base_time = admin_list->base_time;
>>>> +	cur_time = prueth_iep_gettime(emac, &sts);
>>>> +
>>>> +	if (base_time > cur_time)
>>>> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
>>>> +	else
>>>> +		change_cycle_count = 1;
>>>
>>> I see that the base_time is only used to calculate the number of cycles
>>> relative to cur_time. Taprio users want to specify a basetime value
>>> which indicates the phase alignment of the schedule. This is important
>>> when the device is synchronized over PTP with other switches in the
>>> network. Can you explain how is the basetime taken into consideration in
>>> your implementation?
>>>
>>
>> In this implementation base_time is used only to obtain the
>> change_cycle_count and to write it to TAS_CONFIG_CHANGE_CYCLE_COUNT. In
>> this implementation base_time is not used for anything else.
> 
> So there is zero granularity in the base-time beyond the number of cycles?
> That is very bad, because it means the hardware cannot be used in a
> practical TSN network where schedules are offset in phase to each other.
> It needs to be able to be told when the schedule begins, with precision.
> Not just how many cycles from now (what does 'now' even mean?).
> 

Currently base_time is only used for calculating number of cycles.

>>> Better to say what's the hardware maximum, than to report back num_entries
>>> as being not supported.
>>>
>>
>> Sure, I'll change it to below,
>>
>> if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
>> 	NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %ld is more than maximum supported entries %ld in taprio config\n",
>> 				       taprio->num_entries, TAS_MAX_CMD_LISTS);
>> 	return -EINVAL;
>> }
> 
> Keep in mind that NETLINK_MAX_FMTMSG_LEN is only 80 characters. Also, \n
> is not needed in netlink extack messages. And indentation also looks off.
> 

Sure.

>>>> +
>>>> +	emac_cp_taprio(taprio, est_new);
>>>> +	emac->qos.tas.taprio_admin = est_new;
>>>> +	ret = tas_update_oper_list(emac);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
>>>> +	if (ret)
>>>> +		devm_kfree(&ndev->dev, est_new);
>>>> +
>>>> +	return ret;
>>>> +}
>>
>> Below is how the code will look like.
>>
>> 	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
> 
> emac->qos.tas.taprio_admin can also hold an old offload, which is leaked
> here when assigning the new one ("tc qdisc replace dev eth0 root taprio").
> 
>> 	ret = tas_update_oper_list(emac);
>> 	if (ret)
>> 		return ret;
>>
>> 	ret = tas_set_state(emac, TAS_STATE_ENABLE);
>> 	if (ret) {
>> 		emac->qos.tas.taprio_admin = NULL;
>> 		taprio_offload_free(taprio);
>> 	}
>>
>> 	return ret;
>>
>> Please let me know if all of these changes looks ok, I'll resend the
>> patch once you confirm. Thanks for reviewing.
> 
> Hard to say from this snippet. taprio_offload_free() will be needed from
> emac_taprio_destroy() as well.

Sure. I will do that too. I will be sharing a next revision soon. Thanks
for reviewing.

-- 
Thanks and Regards,
Danish

