Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E0765BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjG0Stl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG0Sti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:49:38 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF719A4;
        Thu, 27 Jul 2023 11:49:04 -0700 (PDT)
Received: from [192.168.1.103] (31.173.82.161) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Thu, 27 Jul
 2023 21:48:42 +0300
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
To:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     <lee@kernel.org>, <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <richardcochran@gmail.com>,
        <p.zabel@pengutronix.de>, <geert+renesas@glider.be>,
        <magnus.damm@gmail.com>, <yoshihiro.shimoda.uh@renesas.com>,
        <biju.das.jz@bp.renesas.com>, <wsa+renesas@sang-engineering.com>,
        <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hackerzheng666@gmail.com>,
        <1395428693sheep@gmail.com>, <alex000young@gmail.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
Date:   Thu, 27 Jul 2023 21:48:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.82.161]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 07/27/2023 18:34:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 178910 [Jul 27 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 526 526 7a6a9b19f6b9b3921b5701490f189af0e0cd5310
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.161 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.161 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.161 in (user) bl.spamcop.net}
X-KSE-AntiSpam-Info: 31.173.82.161:7.4.1,7.7.3;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;elixir.bootlin.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {iprep_blacklist}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.161
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2023 18:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/27/2023 3:20:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/27/23 11:21 AM, Paolo Abeni wrote:
[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 4d6b3b7d6abb..ce2da5101e51 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>  	const struct ravb_hw_info *info = priv->info;
>>>  
>>> +	netif_carrier_off(ndev);
>>> +	netif_tx_disable(ndev);
>>> +	cancel_work_sync(&priv->work);
>>
>> Still racy, the carrier can come back up after canceling the work.
> 
> I must admit I don't see how/when this driver sets the carrier on ?!?

   The phylib code does it for this MAC driver, see the call tree of
phy_link_change(), on e.g. https://elixir.bootlin.com/linux/v6.5-rc3/source/...

>> But whatever, this is a non-issue in the first place.
> 
> Do you mean the UaF can't happen? I think that is real. 

   Looks possible to me, at least now... and anyway, shouldn't we clean up
after ourselves if we call schedule_work()?However my current impression is
that cancel_work_sync() should be called from ravb_close(), after calling
phy_{stop|disconnect}()...

>> The fact that ravb_tx_timeout_work doesn't take any locks seems much
>> more suspicious.
> 
> Indeed! But that should be a different patch, right?

   Yes.

> Waiting a little more for feedback from renesas.

   Renesas historically hasn't shown much interest to reviewing the sh_eth/ravb
driver patches, so I took that task upon myself. I also happen to be a nominal
author of this driver... :-)

> /P

MBR, Sergey
