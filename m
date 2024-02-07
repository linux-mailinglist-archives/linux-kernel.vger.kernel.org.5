Return-Path: <linux-kernel+bounces-56613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE3084CC93
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4961C25518
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F52B7C6C0;
	Wed,  7 Feb 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qXR1AY9q"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8191E499;
	Wed,  7 Feb 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315849; cv=none; b=gR8xZ/OVO4wCwQ7bxUQF+2pPvit2r3+7qm0DH4Vot/eVeS1OlM2LQQZ59KnEnEr+3t7liS4HtAFn+a0vVnfBggZYhRcgNW0OwFYodYd7ErSBCNDjBm4EjbYwf40JwvpYsC/W7jdwaaI6VBJKe216W1NdjeoCz+5GPQj3xoBkBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315849; c=relaxed/simple;
	bh=6GhGXticMljWrT/NZCnDjjorJdfZUqKuvwA0lZ/rou4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aRpzdHOH27+MaKlvJ/uIoIpn0PNQ6wK0+fTUba+GIC3ESqBGIYX0eXqXousIEYPsvpc4668KQAelldBCaxG2BdAe+pc2aw+Gng5rp8TP2QCJiwo66QsR8uK0uQ+Vg1ZASstAz5FoUdOlhUw+YDnCfHCPNEPmw7ZS+T0wr3q8sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qXR1AY9q; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417EO0P5001571;
	Wed, 7 Feb 2024 08:24:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707315840;
	bh=Hzju3fhfS5w0f7c7/suS95Oe7Wd/KEzuWc+3V4lvURU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qXR1AY9qZfIOv7VPo53DOAS4/eVn0DJTc10wNCxw95a2BGJ6gbyQVmXRE1KjV3/Nz
	 4fG3IbcC+VNtm/txbZ39HUWI7KWFDEYhkAOtpLIapflBFEkmAKMJWcR1986gqzoRfo
	 GLF1luFMYvSt5Eg+58I43H36hCEM6Gy7/nUunMzk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417EO0vm013788
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 08:24:00 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 08:23:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 08:23:59 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417ENtgi041071;
	Wed, 7 Feb 2024 08:23:56 -0600
Message-ID: <3a7c4a18-5463-414f-82df-39aaed861148@ti.com>
Date: Wed, 7 Feb 2024 19:53:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
To: Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <kamlesh@ti.com>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240207125410.r2q3jcplvif7dvt2@tumbling>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240207125410.r2q3jcplvif7dvt2@tumbling>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 2/7/2024 6:24 PM, Nishanth Menon wrote:
> On 14:41-20240207, Udit Kumar wrote:
>> Most of clocks and their parents are defined in contiguous range,
>> But in few cases, there is gap in clock numbers[0].
>> Driver assumes clocks to be in contiguous range, and add their clock
>> ids incrementally.
>>
>> New firmware started returning error while calling get_freq and is_on
>> API for non-available clock ids.
>>
>> In this fix, driver checks and adds only valid clock ids.
>>
>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
>>
>> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>> Section Clocks for NAVSS0_CPTS_0 Device,
>> clock id 12-15 not present.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Changelog
>> Changes in v3
>> - instead of get_freq, is_auto API is used to check validilty of clock
>> - Address comments of v2, to have preindex increment
>> Link to v2 https://lore.kernel.org/all/20240206104357.3803517-1-u-kumar1@ti.com/
>>
>> Changes in v2
>> - Updated commit message
>> - Simplified logic for valid clock id
>> link to v1 https://lore.kernel.org/all/20240205044557.3340848-1-u-kumar1@ti.com/
>>
>>
>> P.S
>> Firmawre returns total num_parents count including non available ids.
>> For above device id NAVSS0_CPTS_0, number of parents clocks are 16
>> i.e from id 2 to 17. But out of these ids few are not valid.
>> So driver adds only valid clock ids out ot total.
>>
>> Original logs
>> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
>> Line 2630 for error
>>
>> Logs with fix v3
>> https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9#file-v3
>> Line 2586
>>
>>
>>   drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> index 35fe197dd303..31b7df05d7bb 100644
>> --- a/drivers/clk/keystone/sci-clk.c
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -516,6 +516,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>>   	struct sci_clk *sci_clk, *prev;
>>   	int num_clks = 0;
>>   	int num_parents;
>> [..]					/* Check if this clock id is valid */
>> +					ret = provider->ops->is_auto(provider->sci,
>> +						sci_clk->dev_id, ++clk_id, &state);
> A bit too nice coding ;) => I had been confused momentarily by clk_id = args.args[1]
> change just above till I saw that you are pre-incrementing
> clk_id - Is there a harm in leaving the original clk_id increment logic
> alone (it was much simpler to read up)?

No warm in using original code but want to avoid, two statement for 
increment in case of failure and success.

Let me know, if i need to add few comments around this

or if you think, code is confusing I can move to original one



>> +
>> +					if (ret)
>> +						continue;
>> +
>>   					sci_clk = devm_kzalloc(dev,
>>   							       sizeof(*sci_clk),
>>   							       GFP_KERNEL);
>>   					if (!sci_clk)
>>   						return -ENOMEM;
>>   					sci_clk->dev_id = args.args[0];
>> -					sci_clk->clk_id = clk_id++;
>> +					sci_clk->clk_id = clk_id;
>>   					sci_clk->provider = provider;
>>   					list_add_tail(&sci_clk->node, &clks);
>>   
>> -- 
>> 2.34.1
>>

