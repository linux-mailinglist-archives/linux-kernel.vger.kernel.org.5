Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2397FA7D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjK0RQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjK0RQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:16:06 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867DBAF;
        Mon, 27 Nov 2023 09:16:12 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.85) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 27 Nov
 2023 20:16:03 +0300
Subject: Re: [PATCH 6/6] net: ravb: Keep reverse order of operations in
 ravb_remove()
To:     Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
        <yoshihiro.shimoda.uh@renesas.com>, <geert+renesas@glider.be>,
        <wsa+renesas@sang-engineering.com>, <robh@kernel.org>,
        <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <mitsuhiro.kimura.kc@renesas.com>, <masaru.nagai.vx@renesas.com>
CC:     <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
 <20231127090426.3761729-7-claudiu.beznea.uj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <716b433e-5e0c-4353-ea39-12cb4f3d50c4@omp.ru>
Date:   Mon, 27 Nov 2023 20:16:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231127090426.3761729-7-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.85]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/27/2023 17:01:00
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181625 [Nov 27 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.85 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.85
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/27/2023 17:06:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/27/2023 3:21:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 12:04 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> On RZ/G3S SMARC Carrier II board having RGMII connections b/w Ethernet
> MACs and PHYs it has been discovered that doing unbind/bind for ravb
> driver in a loop leads to wrong speed and duplex for Ethernet links and
> broken connectivity (the connectivity cannot be restored even with
> bringing interface down/up). Before doing unbind/bind the Ethernet
> interfaces were configured though systemd. The sh instructions used to
> do unbind/bind were:
> 
> $ cd /sys/bus/platform/drivers/ravb/
> $ while :; do echo 11c30000.ethernet > unbind ; \
>   echo 11c30000.ethernet > bind; done
> 
> It has been discovered that there is a race b/w IOCTLs initialized by
> systemd at the response of success binding and the
> "ravb_write(ndev, CCC_OPC_RESET, CCC)" instruction in ravb_remove() as

   s/instruction/call/, perhaps?

> follows:
> 
> 1/ as a result of bind success the user space open/configures the
>    interfaces tough an IOCTL; the following stack trace has been
>    identified on RZ/G3S:
> 
> Call trace:
> dump_backtrace+0x9c/0x100
> show_stack+0x20/0x38
> dump_stack_lvl+0x48/0x60
> dump_stack+0x18/0x28
> ravb_open+0x70/0xa58
> __dev_open+0xf4/0x1e8
> __dev_change_flags+0x198/0x218
> dev_change_flags+0x2c/0x80
> devinet_ioctl+0x640/0x708
> inet_ioctl+0x1e4/0x200
> sock_do_ioctl+0x50/0x108
> sock_ioctl+0x240/0x358
> __arm64_sys_ioctl+0xb0/0x100
> invoke_syscall+0x50/0x128
> el0_svc_common.constprop.0+0xc8/0xf0
> do_el0_svc+0x24/0x38
> el0_svc+0x34/0xb8
> el0t_64_sync_handler+0xc0/0xc8
> el0t_64_sync+0x190/0x198
> 
> 2/ this call may execute concurrently with ravb_remove() as the
>    unbind/bind operation was executed in a loop
> 3/ if the operation mode is changed to RESET (though

   Through?

>    ravb_write(ndev, CCC_OPC_RESET, CCC) instruction in ravb_remove())

   s/instruction/call/, perhaps?

>    while the above ravb_open() is in progress it may lead to MAC
>    (or PHY, or MAC-PHY connection, the right point hasn't been identified
>    at the moment) to be broken, thus the Ethernet connectivity fails to
>    restore.
> 
> The simple fix for this is to move ravb_write(ndev, CCC_OPC_RESET, CCC))
> after unregister_netdev() to avoid resetting the controller while the
> netdev interface is still registered.
> 
> To avoid future issues in ravb_remove(), the patch follows the proper order
> of operations in ravb_remove(): reverse order compared with ravb_probe().
> This avoids described races as the IOCTLs as well as unregister_netdev()
> (called now at the beginning of ravb_remove()) calls rtnl_lock() before
> continuing and IOCTLs check (though devinet_ioctl()) if device is still
> registered just after taking the lock:
> 
> int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
> {
> 	// ...
> 
>         rtnl_lock();
> 
>         ret = -ENODEV;
>         dev = __dev_get_by_name(net, ifr->ifr_name);
>         if (!dev)
>                 goto done;
> 
> 	// ...
> done:
>         rtnl_unlock();
> out:
>         return ret;
> }
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

   Sorry for overlooking this race (and other bugs) when prepping
the driver for upstream!

MBR, Sergey
