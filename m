Return-Path: <linux-kernel+bounces-62109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A13851B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA6A1F21EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C01D3F8DE;
	Mon, 12 Feb 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cs6s5zXo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF033CF4C;
	Mon, 12 Feb 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759231; cv=none; b=OpEWZZPOFQog3z4Hx2daCCoa9g8EAzvrvjzp7l1EcMC+hdjle000lWWCwP/ILZDr2+NRvU+qvGqiCZDsy7UNJ27jTJiFFOj72ciw1X+tSgk5Hiv6auL6C++nQ1sPAs26X5wJTWxEpDO9jji+frGEFiOZ1g4gcfu6o8gZnvN8ntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759231; c=relaxed/simple;
	bh=iRJ7tAGOQgkVUq7M6rHvy9JC7/8rL0PgRJi9YiFRE/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xfyb6Ut5yRFp7EuQtLk8JYtxVDa9JZRtb3wYf1QAntnSP6URey8zwBKgCKAUAZqz+CSx3zHs2Hwu43u8FXPtWmAIsoCx+Mpa2QW2mrahKX1ki8BDAdZ7Q9I2EsuqMgNbGVO7BsU5ZHVJQw3f1lMzpjS8UpOYCVxXnpPSpfsR3VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cs6s5zXo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CHXlLP075758;
	Mon, 12 Feb 2024 11:33:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707759227;
	bh=35DUwFLWme+hzB8+q74QL3X6NF4TbGrC9LI3N1F7HDc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cs6s5zXoHkP+USPh68w5JtiX4EKRDgEngF1H4jLKwBaOSop3UK8ynWiHUd0WvB6jm
	 aF9gVJuByGyyBKFFmuOIb5f/Mx6QOFsEzLB1+KXRUKsnFKOrTahcxOKYw5XJ8uQEe2
	 S1m4PkmRG83BBsvrBEPzonfWZxuHn2BPZWWNmj3w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CHXleD125248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 11:33:47 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 11:33:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 11:33:47 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CHXl19077794;
	Mon, 12 Feb 2024 11:33:47 -0600
Message-ID: <a663ce39-d522-484d-a717-22ebd99a7d01@ti.com>
Date: Mon, 12 Feb 2024 11:33:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
 <ccd51fa3-d944-42c3-9915-6c4fbe2b78a6@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <ccd51fa3-d944-42c3-9915-6c4fbe2b78a6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 2/12/24 11:13 AM, Andrew Davis wrote:
> On 2/6/24 7:15 PM, Judith Mendez wrote:
>> For DDR52 timing, DLL is enabled but tuning is not carried
>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>
>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed 
>> modes")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changelog:
>> v1->v2:
>> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>>   instead of sdhci_am654_setup_dll()
>> ---
>>   drivers/mmc/host/sdhci_am654.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> See how much easier this patch is this way :)

Thanks for your review. :D It does look simpler.

> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c 
>> b/drivers/mmc/host/sdhci_am654.c
>> index 2c66a965c225..b50db5d4a452 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct 
>> sdhci_host *host, unsigned int clock)
>>       if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>           sdhci_am654_setup_dll(host, clock);
>> +        sdhci_am654_write_itapdly(sdhci_am654, 
>> sdhci_am654->itap_del_sel[timing]);
>>           sdhci_am654->dll_enable = true;
>>       } else {
>>           sdhci_am654_setup_delay_chain(sdhci_am654, timing);


