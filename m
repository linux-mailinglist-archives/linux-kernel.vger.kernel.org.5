Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4151675A051
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGSVFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGSVFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:05:03 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D705B1FC0;
        Wed, 19 Jul 2023 14:05:01 -0700 (PDT)
Received: from [192.168.1.103] (178.176.79.158) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 20 Jul
 2023 00:04:53 +0300
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
To:     Yunsheng Lin <linyunsheng@huawei.com>,
        Zheng Hacker <hackerzheng666@gmail.com>
CC:     Zheng Wang <zyytlz.wz@163.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <1395428693sheep@gmail.com>, <alex000young@gmail.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
 <57f6d87e-8bfb-40fc-7724-89676c2e75ef@huawei.com>
 <CAJedcCy8QOCv3SC-Li2JkaFEQydTDd1aiY77BHn7ht0Y8r1nUA@mail.gmail.com>
 <43a4a617-2633-a501-6fd1-b2495aed90f7@huawei.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <10f72b0a-663b-7f71-06c2-7315bd0bf368@omp.ru>
Date:   Thu, 20 Jul 2023 00:04:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <43a4a617-2633-a501-6fd1-b2495aed90f7@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.79.158]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/19/2023 18:09:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178730 [Jul 19 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 524 524 9753033d6953787301affc41bead8ed49c47b39d
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.158 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.158 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;178.176.79.158:7.1.2,7.7.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.158
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/19/2023 18:16:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/19/2023 5:01:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/13/23 6:32 AM, Yunsheng Lin wrote:
[...]

>>> On 2023/3/12 2:06, Zheng Wang wrote:
>>>> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
>>>> If timeout occurs, it will start the work. And if we call
>>>> ravb_remove without finishing the work, there may be a
>>>> use-after-free bug on ndev.
>>>>
>>>> Fix it by finishing the job before cleanup in ravb_remove.
>>>>
>>>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>>>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>> ---
>>>> v3:
>>>> - fix typo in commit message
>>>> v2:
>>>> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
>>>> add an empty line to make code clear suggested by Sergey Shtylyov
>>>> ---
>>>>  drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 0f54849a3823..eb63ea788e19 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -2892,6 +2892,10 @@ static int ravb_remove(struct platform_device *pdev)
>>>>       struct ravb_private *priv = netdev_priv(ndev);
>>>>       const struct ravb_hw_info *info = priv->info;
>>>>
>>>> +     netif_carrier_off(ndev);
>>>> +     netif_tx_disable(ndev);
>>>> +     cancel_work_sync(&priv->work);
>>>
>>> LGTM.
>>> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>
>>> As noted by Sergey, ravb_remove() and ravb_close() may
>>> share the same handling, but may require some refactoring
>>> in order to do that. So for a fix, it seems the easiest
>>> way to just add the handling here.
>>
>> Dear Yunsheng,
>>
>> I think Sergey is right for I've seen other drivers' same handling
>> logic. Do you think we should try to move the cancel-work-related code
>> from ravb_remove to ravb_close funtion?
>> Appreciate for your precise advice.
> 
> As Sergey question "can ravb_remove() be called without ravb_close()
> having been called on the bound devices?"
> If I understand it correctly, I think ravb_remove() can be called
> without ravb_close() having been called on the bound devices. I am
> happy to be corrected if I am wrong.

   Yes, correct. It's ravb_remove() that calls unregister_netdev()
which results in calling ravb_close() on the opened devices...

> Yes, you can call *_close() directly in *_remove(), but that may
> require some refactoring and a lot of testing.

   No need to do that I think, as it's called anyways...

> Also, if you found the bug through some static analysis, it may
> be better to make it clear in the commit log and share some info
> about the static analysis, which I suppose it is a tool?

   Agreed. :-)

>> Best regards,
>> Zheng

MBR, Sergey
