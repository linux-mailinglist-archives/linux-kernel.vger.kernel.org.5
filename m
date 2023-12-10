Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8980BD53
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjLJVOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjLJVOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:14:20 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCEFDB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:14:26 -0800 (PST)
Received: from [192.168.1.104] (178.176.74.216) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 11 Dec
 2023 00:14:16 +0300
Subject: Re: [PATCH] f2fs: data: fix possible overflow in
 check_swap_activate()
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <20231025202019.5228-1-s.shtylyov@omp.ru>
 <e2167506-2b0a-a0f5-c0e9-0e8b6139c69e@kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5769c4fa-3112-3582-00a0-2b17757d8cab@omp.ru>
Date:   Mon, 11 Dec 2023 00:14:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e2167506-2b0a-a0f5-c0e9-0e8b6139c69e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.176.74.216]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 12/10/2023 20:52:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181999 [Dec 10 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 6 0.3.6 62f5a4619c57459c9a142aa1486ed27913162963
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.216 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.216 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.216
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/10/2023 20:58:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/10/2023 7:07:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Sorry for replying a month later than I should -- I got distracted by the
other Svace reports... It took a significant part of the weekend to swap this
stuff back in... :-/

On 11/7/23 6:29 PM, Chao Yu wrote:
[...]
>> In check_swap_activate(), if the *while* loop exits early (0- or 1-page
>> long swap file), an overflow happens while calculating the value of the
>> span parameter as the lowest_pblock variable ends up being greater than
>> the highest_pblock variable. Let's set *span to 0 in this case...
> 
> What do you think of returning -EINVAL for such case? I assume this is a
> corner case.

   I don't know the code well enough but I got the impression that iff
we have a file containing a single page, we'd have one successful call
of add_swap_extent(). Am I missing something?

>> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> ---
>> This patch is against the 'master' branch of Jaegeuk Kim's F2FS repo...
>>
>>   fs/f2fs/data.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 916e317ac925..342cb0d5056d 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -4047,7 +4047,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
>>           cur_lblock += nr_pblocks;
>>       }
>>       ret = nr_extents;
>> -    *span = 1 + highest_pblock - lowest_pblock;
>> +    if (lowest_pblock <= highest_pblock)
> 
> if (unlikely(higest_pblock < lowest_pblock))

   Well, Greg KH says we shouldn't use unlikely() unless we can prove
that it indeed improves things...

>     return -EINVAL;
> 
> *span = 1 + highest_pblock - lowest_pblock;
> 
> Thanks,
> 
>> +        *span = 1 + highest_pblock - lowest_pblock;
>> +    else
>> +        *span = 0;
>>       if (cur_lblock == 0)
>>           cur_lblock = 1;    /* force Empty message */
>>       sis->max = cur_lblock;

MBR, Sergey
