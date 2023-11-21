Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6977F24BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjKUEBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 23:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUEBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 23:01:03 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD0BE;
        Mon, 20 Nov 2023 20:00:59 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AL40cih051202;
        Mon, 20 Nov 2023 22:00:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1700539239;
        bh=NpKEUHQuhk1S1PC4cZuWT6Fcnm4AYXb8QD+XB4CAJEo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=y2ONs/Q2VVSDEuzJxacMm+mDAvaZmrtunUuuhV5Ed15/tv6Pi/BSSnmP5Fo8MTzA2
         KoAbkojWA5o5b9h2SxJ0aOxSRL2GR7cqbVaY9tEWggwY1V8X/NY/L6HA1n9swuIwoe
         1deC1t68Q+RW6BMidJVgqsFVg2ZKipCgl9BkacWk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AL40c1o068392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Nov 2023 22:00:38 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 Nov 2023 22:00:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 Nov 2023 22:00:38 -0600
Received: from [172.24.227.94] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AL40ZVO123866;
        Mon, 20 Nov 2023 22:00:36 -0600
Message-ID: <0f3277cc-0e4a-42c9-920c-87e1e6d6c0ca@ti.com>
Date:   Tue, 21 Nov 2023 09:30:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] watchdog: rti_wdt: Use managed APIs to handle runtime
 PM
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     Tero Kristo <t-kristo@kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>,
        <n-francis@ti.com>
References: <20231110100726.2930218-1-vigneshr@ti.com>
 <20231110100726.2930218-2-vigneshr@ti.com>
 <40590367-0a38-4c4c-a608-1174a5ecd5ae@roeck-us.net>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <40590367-0a38-4c4c-a608-1174a5ecd5ae@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/11/23 20:33, Guenter Roeck wrote:
> On 11/10/23 02:07, Vignesh Raghavendra wrote:
>> Switch to devm_pm_runtime_enable() to simplify error handling in driver
>> probe.
>>
> 
> This also replaces the call to pm_runtime_resume_and_get() without
> explanation.
> Worse, the next patch conditionally re-introduces pm_runtime_put_sync()
> on the probe function.
> 
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>   drivers/watchdog/rti_wdt.c | 30 ++++++++----------------------
>>   1 file changed, 8 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
>> index 8e1be7ba0103..163bdeb6929a 100644
>> --- a/drivers/watchdog/rti_wdt.c
>> +++ b/drivers/watchdog/rti_wdt.c
>> @@ -236,12 +236,8 @@ static int rti_wdt_probe(struct platform_device
>> *pdev)
>>       if (wdt->freq < 32768)
>>           wdt->freq = wdt->freq * 9 / 10;
>>   -    pm_runtime_enable(dev);
>> -    ret = pm_runtime_resume_and_get(dev);
>> -    if (ret < 0) {
>> -        pm_runtime_disable(&pdev->dev);
>> -        return dev_err_probe(dev, ret, "runtime pm failed\n");
>> -    }
>> +    devm_pm_runtime_enable(dev);
> 
> devm_pm_runtime_enable() returns an error code. I don't think ignoring it
> is a good idea.
> 


Oops, yes...

>> +    pm_runtime_get_noresume(dev);
> 
> Is this functionally identical to pm_runtime_resume_and_get() ?
> That would require further explanation. Why is it not necessary
> to resume here ?

include/linux/pm_runtime.h ::
 pm_runtime_resume_and_get - Bump up usage counter of a device and
resume it.

vs

pm_runtime_get_noresume - Bump up runtime PM usage counter of a device.

During probe, device is already active. Hence, there is really no need
to call driver level runtime_resume() callback as there is really no
context to resume from. Driver currently doesnt have runtime_pm calls
which I intend to add as a later patch. I guess, its probably better to
move this patch to same series.

Also, missed a call to pm_runtime_put_noidle() in the error path.


So for now I will respin 2/2 as standalone fix and repost along with
runtime_pm support.

Apologies, for the delayed response!

-- 
Regards
Vignesh
