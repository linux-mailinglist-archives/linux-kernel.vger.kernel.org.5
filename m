Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D837A0160
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjINKPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:15:37 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8011BE3;
        Thu, 14 Sep 2023 03:15:33 -0700 (PDT)
Received: from [192.168.1.103] (178.176.78.252) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 14 Sep
 2023 13:15:30 +0300
Subject: Re: [PATCH] usb: musb: Get the musb_qh poniter after musb_giveback
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Xingxing Luo <xingxing.luo@unisoc.com>, <b-liu@ti.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xingxing0070.luo@gmail.com>, <Zhiyong.Liu@unisoc.com>,
        <Cixi.Geng1@unisoc.com>, <Orson.Zhai@unisoc.com>,
        <zhang.lyra@gmail.com>
References: <20230914015656.20856-1-xingxing.luo@unisoc.com>
 <8365ba2a-8ecd-d055-e962-3a7f2bfdbfb0@omp.ru>
Organization: Open Mobile Platform
Message-ID: <22c3a910-0c16-fe94-06e6-28650cf0e634@omp.ru>
Date:   Thu, 14 Sep 2023 13:15:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8365ba2a-8ecd-d055-e962-3a7f2bfdbfb0@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.252]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 09/14/2023 10:01:12
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179856 [Sep 14 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.252 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.252 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.252
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/14/2023 10:07:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/14/2023 9:01:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 1:06 PM, Sergey Shtylyov wrote:
[...]

>> When multiple threads are performing USB transmission, musb->lock will be
>> unlocked when musb_giveback is executed. At this time, qh may be released
>> in the dequeue process in other threads, resulting in a wild pointer, so
>> it needs to be here get qh again, and judge whether qh is NULL, and when
>> dequeue, you need to set qh to NULL.
>>
>> Fixes: dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
>> Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
>> ---
>>  drivers/usb/musb/musb_host.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
>> index a02c29216955..9df27db5847a 100644
>> --- a/drivers/usb/musb/musb_host.c
>> +++ b/drivers/usb/musb/musb_host.c
>> @@ -321,10 +321,16 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
>>  	musb_giveback(musb, urb, status);
>>  	qh->is_ready = ready;
>>  
>> +	/*
>> +	 * musb->lock had been unlocked in musb_giveback, so somtimes qh
> 
>    Sometimes?
> 
>> +	 * may freed, need get it again

+	 * may be freed, need to get it again

   Overlooked it in the 1st review, sorry...

[...]

MBR, Sergey
