Return-Path: <linux-kernel+bounces-85282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B57186B36E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1570128426B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231615F308;
	Wed, 28 Feb 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H1B1Gfz7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CB15E5BE;
	Wed, 28 Feb 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134838; cv=none; b=jlIobV6X1evQhQv5nlbYgCGuF9b7fLj5+oiEy4jHDPelnanCriKD0BFxYdrdvqb6fYXtKfd9OFCA+kpSbd9lbnj6b1SCuSAXP5TcejXKdpwc/a9eLHGvR6G1XGzpwzVdS4xEkmWafBQTiQsHG6iEabEy5tml0mP3t3uaj9lZA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134838; c=relaxed/simple;
	bh=zyIIWb0GCEnzMyCT8n8PGJZ9AoaWZ7Oll+935gGnsNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QY3CfzyRU4bjYufwe2S1rCOPlwEti+1wWzzyFfs19uiz+TyvdorjsowXBjzfg2NTTxmb4nVSZrAiJFYtR8VZAFWJA8IUesAaNKBIu8LjzolqThcdAkusqt+2Cwuda0718+/szF1fUzADhZ7TEC0fHl3VDA5qyk/SqXO+RNieqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H1B1Gfz7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SFeYlB066187;
	Wed, 28 Feb 2024 09:40:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709134834;
	bh=1BBQ7G18oMa6KhbFSSaEGSGl2+04hap3uYZJbm/Bzqc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H1B1Gfz7+tw/DNrbs4+e0G+TcpVW63vITREhCTEHcsmIBx6/JiOPrhgevKKuG/eJB
	 55lmPZHOss2VjwOF3A4gJOnQENcQqpPpMQgh3iQta3vWBnQX03zKFmYlI9H8rYMdKD
	 RPpP4+hiA0A3BPWw5GxYFA9N7SnFLHXiHLhha7kg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SFeYd7077920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 09:40:34 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 09:40:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 09:40:33 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SFeXwb122716;
	Wed, 28 Feb 2024 09:40:33 -0600
Message-ID: <34864935-2cf0-4a9f-aa52-bc6dd89da26b@ti.com>
Date: Wed, 28 Feb 2024 09:40:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Content-Language: en-US
To: Adrian Hunter <adrian.hunter@intel.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ulf Hansson
	<ulf.hansson@linaro.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240207011520.3128382-3-jm@ti.com>
 <82463a28-822b-4612-aed5-1be21c13acf4@intel.com>
 <b8b9a7d2-6b1c-4cb1-a41e-55a2e31c25f5@ti.com>
 <00d4a5fe-2a9d-41c6-8f40-df657fd277d8@intel.com>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <00d4a5fe-2a9d-41c6-8f40-df657fd277d8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Adrian,

On 2/28/24 7:21 AM, Adrian Hunter wrote:
> On 20/02/24 23:05, Judith Mendez wrote:
>> Hi Adrian,
>>
>> On 2/16/24 11:09 AM, Adrian Hunter wrote:
>>> On 7/02/24 03:15, Judith Mendez wrote:
>>>> For DDR52 timing, DLL is enabled but tuning is not carried
>>>> out, therefore the ITAPDLY value in PHY CTRL 4 register is
>>>> not correct. Fix this by writing ITAPDLY after enabling DLL.
>>>>
>>>> Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
>>>
>>> Note that the Fixes tags make a different ordering
>>> than the patch order i.e.
>>>
>>> Patch    Fixes        in version
>>> 1     13ebeae68ac9     v5.10-rc1
>>> 2     a161c45f2979     v5.7-rc1
>>> 3     8ee5fc0e0b3b     v5.7-rc1
>>> 4     8ee5fc0e0b3b     v5.7-rc1
>>> 4     a0a62497f6aa     v5.10-rc1
>>> 5     fe52e2fbc6ef     v5.9-rc1
>>> 6     1accbced1c32     v5.3-rc1
>>> 7     a161c45f2979     v5.7-rc1
>>>
>>> That might make backporting these patches more challenging.
>>
>> Are you suggesting to remove the fixes tag here?
> 
> No, it is just something to think about if you intend to
> backport these patches to older kernels.

Thanks, Ill keep this in mind for v3.

> 
>>
>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>> Changelog:
>>>> v1->v2:
>>>> - Call sdhci_am654_write_itapdly() in sdhci_am654_set_clock()
>>>>    instead of sdhci_am654_setup_dll()
>>>> ---
>>>>    drivers/mmc/host/sdhci_am654.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>>> index 2c66a965c225..b50db5d4a452 100644
>>>> --- a/drivers/mmc/host/sdhci_am654.c
>>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>>> @@ -299,6 +299,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>>>>          if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
>>>>            sdhci_am654_setup_dll(host, clock);
>>>> +        sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
>>>>            sdhci_am654->dll_enable = true;
>>>>        } else {
>>>>            sdhci_am654_setup_delay_chain(sdhci_am654, timing);
>>>
>>
>> ~ Judith
> 


