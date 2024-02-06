Return-Path: <linux-kernel+bounces-55090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E284B790
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B051F26750
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D70131E47;
	Tue,  6 Feb 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dn2d2Nia"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCEB13174B;
	Tue,  6 Feb 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228904; cv=none; b=rYoAuof0In+G9vPYJhw1iKEGl4LC7zm+I9l3l3BYbp+SSLThf54Yf0Jn+XRZOdfMCqf3FJ9gs1gu0DCvIzS+wPf7D3Q6Her20lnNLTvOdcZoKDaKcgjg3n0QPH0AsMLgQ8MLC0eo1XXUYUewnGVgoBAjsdY7ciI+ceElwzT1IHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228904; c=relaxed/simple;
	bh=Plv67jbPS91cn3uSzCkU0RO/zCmrQiQNalEpFTSZGAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bfmb/pU3658my0BnygbHfnfAUGe1kc7RiJHGydvTQHeFKAnp+ds47ewrPGVuDKhSfzveYu0ghuQYijHvraRSZmE4yOUoaGrOflb/AScrsD/QOFbiibtGD+/n6lBbkXUWgvBnHpAvRG4yCOw0h1gEBkkP1g2JiUsODXufKMt8qaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dn2d2Nia; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416EEt2I043435;
	Tue, 6 Feb 2024 08:14:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707228895;
	bh=gAM+/PAHQStjyd4FbnM8s6JPxj4OKiqD4h6+SRruMKg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=dn2d2NiahWSvo8MojIEoh/rYszIzRN8xRwaTOQOnLB3MxRyGxLrbDJrB3r7ROh/Ad
	 LKh2GTq271Htoks6EwXaqbDCDhwua9lksOG3igb3jvxTQGldjalqbmPPHUR4RbO5N9
	 akn9ANnQ7oNOZfaPQOILopJSVrL4b2h61mWMZ3yM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416EEtWY087070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:14:55 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:14:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:14:55 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416EEpAe120665;
	Tue, 6 Feb 2024 08:14:52 -0600
Message-ID: <a0249265-255b-40d7-b609-c1ab6a789d46@ti.com>
Date: Tue, 6 Feb 2024 19:44:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <vigneshr@ti.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240206131420.wtitflgav23jto2q@verbally>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/6/2024 6:44 PM, Nishanth Menon wrote:
> On 16:13-20240206, Udit Kumar wrote:
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
>> Logs with fix v2
>> https://gist.github.com/uditkumarti/94e3e28d62282fd708dbfe37435ce1d9
>> Line 2591
>>
>>
>>   drivers/clk/keystone/sci-clk.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> index 35fe197dd303..ff249cbd54a1 100644
>> --- a/drivers/clk/keystone/sci-clk.c
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -517,6 +517,7 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>>   	int num_clks = 0;
>>   	int num_parents;
>>   	int clk_id;
>> +	u64 freq;
>>   	const char * const clk_names[] = {
>>   		"clocks", "assigned-clocks", "assigned-clock-parents", NULL
>>   	};
>> @@ -586,16 +587,23 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>>   				clk_id = args.args[1] + 1;
>>   
>>   				while (num_parents--) {
>> +					/* Check if this clock id is valid */
>> +					ret = provider->ops->get_freq(provider->sci,
>> +						sci_clk->dev_id, clk_id, &freq);
> get_freq is a bit expensive as it has to walk the clock tree to find
> the clock frequency (at least the first time?). just wondering if
> there is lighter alternative here?


Let me check , if we have some other alternative here

>> +
>> +					clk_id++;
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
>> +					sci_clk->clk_id = clk_id - 1;
>>   					sci_clk->provider = provider;
>>   					list_add_tail(&sci_clk->node, &clks);
>> -
> 	Spurious change.

I think, you meant by deleting the line ?

If yes then will address in next version


>>   					num_clks++;
>>   				}
>>   			}
>> -- 
>> 2.34.1
>>

