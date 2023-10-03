Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CD7B71E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbjJCTjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjJCTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:39:37 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233549E;
        Tue,  3 Oct 2023 12:39:34 -0700 (PDT)
Received: from [192.168.1.103] (178.176.73.165) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 3 Oct 2023
 22:39:29 +0300
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>
CC:     "lee@kernel.org" <lee@kernel.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230725201952.2f23bb3b@kernel.org>
 <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
 <607f4fe4-5a59-39dd-71c2-0cf769b48187@omp.ru>
 <OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <872cf8d7-3bd6-b11a-82ac-a9f4c82d0a02@omp.ru>
Date:   Tue, 3 Oct 2023 22:39:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <OSYPR01MB53341CFDBB49A3BA41A6752CD8F9A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.73.165]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 10/03/2023 19:21:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 180331 [Oct 03 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.165 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.165 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;omp.ru:7.1.1;elixir.bootlin.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.165
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/03/2023 19:25:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/3/2023 4:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Concerning the subject: I doubt that UAF acronym is known to
everybody (e.g. it wasn't known to me), I think we should be able
to afford spelling out use-after-free there...

On 9/20/23 5:37 AM, Yoshihiro Shimoda wrote:
[...]

>>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>>> index 4d6b3b7d6abb..ce2da5101e51 100644
>>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>>> @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pdev)
>>>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>>>  	const struct ravb_hw_info *info = priv->info;
>>>>>
>>>>> +	netif_carrier_off(ndev);
>>>>> +	netif_tx_disable(ndev);
>>>>> +	cancel_work_sync(&priv->work);
>>>>
>>>> Still racy, the carrier can come back up after canceling the work.
>>>
>>> I must admit I don't see how/when this driver sets the carrier on ?!?
>>
>>    The phylib code does it for this MAC driver, see the call tree of
>> phy_link_change(), on e.g.
>> https://elixir.bootlin.com/linux/v6.5-rc3/source
>>
>>>> But whatever, this is a non-issue in the first place.
>>>
>>> Do you mean the UaF can't happen? I think that is real.
>>
>>    Looks possible to me, at least now... and anyway, shouldn't we clean up
>> after ourselves if we call schedule_work()?However my current impression is
>> that cancel_work_sync() should be called from ravb_close(), after calling
>> phy_{stop|disconnect}()...
> 
> I also think so.
> 
> ravb_remove() calls unregister_netdev().
>  -> unregister_netdev() calls rtnl_lock() and unregister_netdevice().
>  --> unregiter_netdevice_queue()
>  ---> unregiter_netdevice_many()
>  ----> unregiter_netdevice_many_notify().
>  -----> dev_close_many()
>  ------> __dev_close_many()
>  -------> ops->ndo_stop()
> 
> ravb_close() calls phy_stop()
>  -> phy_state_machine() with PHY_HALTED
>  --> phy_link_down()
>  ---> phy_link_change()
>  ----> netif_carrier_off()

   Thanks for sharing the call chain, I've followed it once again... :-)

> The patch will be the following:
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7df9f9f8e134..e452d90de7c2 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2167,6 +2167,8 @@ static int ravb_close(struct net_device *ndev)
>  			of_phy_deregister_fixed_link(np);
>  	}
>  
> +	cancel_work_sync(&priv->work);
> +
>  	if (info->multi_irqs) {
>  		free_irq(priv->tx_irqs[RAVB_NC], ndev);
>  		free_irq(priv->rx_irqs[RAVB_NC], ndev);
> ---
> 
> If this patch is acceptable, I'll submit it. But, what do you think?

   I think it should do the job. And I suspect you can even test it... :-)

> Best regards,
> Yoshihiro Shimoda

[...]

MBR, Sergey
