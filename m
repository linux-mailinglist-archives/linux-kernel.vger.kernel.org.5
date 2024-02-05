Return-Path: <linux-kernel+bounces-53136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC9884A120
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC7C1F239CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8E45035;
	Mon,  5 Feb 2024 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WjTA6q73"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18744C6E;
	Mon,  5 Feb 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155022; cv=none; b=XHOkrS9HkOt4XzfUx2PN7//7SJ06q3paWaEWEpjMBMNX2c09YiWbMcusE9Uw93KF1SxlCobAG3YE+Vb23P+JNTHcDWL+kdlcQZMtAFPkecUFkaRtUlIlURbD6kvyi1I+fjRLX/fNh6067bKk6OvCCKQaLZ9nEgoFKAz+pSbHvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155022; c=relaxed/simple;
	bh=g5tFIE4bbZl6hqHj/2jztyCexUFqHcKzJjBktvcR3W4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FO6emSc7ddE0qy1ouVGpdHbt8QH7NnUDPoy4AlwztrscSaZR3T3MzO02Cy8qiW93p5h71GN0mrDCsFJUREJMafOxW+jVNmI9yfdwO1VyrM+sSLhQbEIdyIvX6f7W5j38nGTTBDerErA2upA4WkOQnScmu+phspEe9ek2QZDIMQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WjTA6q73; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415HhVYI104548;
	Mon, 5 Feb 2024 11:43:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707155011;
	bh=Bk8CRp6djVeLbT1NZuaOgiiL8lttc8Bxb3XPkXb//WA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WjTA6q73OabpiujxgpW1+J7fSxN0nsyBe8VpFUFNAdqK3MYT/YOb3OBDsomNqVHvS
	 XxPKuPj5+PBjzJ44U+unilUWd87BSDDIxyxBI0jzhcyhFXGPRUQwF1fOBSVKzCoJMb
	 toblwYchyAF124QobSFJn6o9fB+rvZlTEHyM0GeI=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415HhVa4066771
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 11:43:31 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 11:43:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 11:43:31 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415HhR62124607;
	Mon, 5 Feb 2024 11:43:28 -0600
Message-ID: <5a17f3dd-a27a-49d3-9e54-a0022333abe2@ti.com>
Date: Mon, 5 Feb 2024 23:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
To: Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <vigneshr@ti.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240205044557.3340848-1-u-kumar1@ti.com>
 <20240205140459.orjvjqqtiugmyosc@obscurity>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240205140459.orjvjqqtiugmyosc@obscurity>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/5/2024 7:34 PM, Nishanth Menon wrote:
> On 10:15-20240205, Udit Kumar wrote:
>> Most of clocks and their parents are defined in contiguous range,
>> But in few cases, there is gap in clock numbers[0].
>>
>> Driver assumes clocks to be in contiguous range, and assigns
>> accordingly.
>>
>> New firmware started returning error in case of
>> non-available clock id.  Therefore drivers throws error while
>> re-calculate and other functions.
> What changed here? started returning error for what API? also please fix
> up 70 char alignment -> there extra spaces in your commit message.


will address in v2

>> In this fix, before assigning and adding clock in list,
>> driver checks if given clock is valid or not.
>>
>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
>>
>> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>> Section Clocks for NAVSS0_CPTS_0 Device,
>> clock id 12-15 and 18-19 not present
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Original logs
>> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-original-logs
>> Line 2630 for error
>>
>> Logs with fix
>> https://gist.github.com/uditkumarti/de4b36b21247fb36725ad909ce4812f6#file-with-fix
>> Line 2594
>>
>>   drivers/clk/keystone/sci-clk.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
>> index 35fe197dd303..d417ec018d82 100644
>> --- a/drivers/clk/keystone/sci-clk.c
>> +++ b/drivers/clk/keystone/sci-clk.c
>> @@ -517,6 +517,8 @@ static int ti_sci_scan_clocks_from_dt(struct sci_clk_provider *provider)
>>   	int num_clks = 0;
>>   	int num_parents;
>> [..]
>> -					num_clks++;
>> +						ret = provider->ops->get_freq(provider->sci,
>> +							   sci_clk->dev_id, sci_clk->clk_id, &freq);
>> +					} while (ret != 0 && clk_id < max_clk_id);
> take clock ids 0 1 2 3 -> Say 2 is reserved.
> num_parents = 4
> while(num_parents) Loop 1 ->  clk ID 0 is valid, list_add_tail
> while(num_parents) Loop 2 ->  clk ID 1 is valid, list_add_tail
> while(num_parents) Loop 3 ->  clk ID 2 is invalid.. so we scan forward
> 	to clk ID 3 -> list_add_tail
> while(num_parents) Loop 4 ->  clk ID 4 is invalid.. but 5 is out of
> 	range, so we break off loop. sci_clk is still devm_kzalloced ->
> 	but since clk_id > max_clk_id, we jump off loop, and we dont add
> 	it to tail. so one extra allocation?

Thanks for catching this.


> If we have multiple reserved intermediate ones, then we'd have as many
> allocations that aren't linked? Could we not improve the logic a bit to
> allocate just what is necessary?

Sure, will change in v2.

to check clock validity first and then allocate, add


>> +
>> +					sci_clk->provider = provider;
>> +					if (ret == 0) {
>> +						list_add_tail(&sci_clk->node, &clks);
>> +						num_clks++;
>> +					}
>>   				}
>>   			}
>>   
>> -- 
>> 2.34.1
>>

