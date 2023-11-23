Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459F7F670C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjKWTTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWTTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:19:21 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4AD5A;
        Thu, 23 Nov 2023 11:19:26 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 23 Nov
 2023 22:19:17 +0300
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
To:     claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <p.zabel@pengutronix.de>, <yoshihiro.shimoda.uh@renesas.com>,
        <geert+renesas@glider.be>, <wsa+renesas@sang-engineering.com>,
        <biju.das.jz@bp.renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <sergei.shtylyov@cogentembedded.com>,
        <mitsuhiro.kimura.kc@renesas.com>, <masaru.nagai.vx@renesas.com>
CC:     <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
 <04cb07fe-cccc-774a-f14d-763ce7ae7b07@omp.ru>
 <b3456a4d-336c-434d-9fd5-4c87582443cb@tuxon.dev>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9af21eb9-6fe1-de3a-f2eb-4493778ebb32@omp.ru>
Date:   Thu, 23 Nov 2023 22:19:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b3456a4d-336c-434d-9fd5-4c87582443cb@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.78.136]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.0.0, Database issued on: 11/21/2023 23:48:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 181514 [Nov 21 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.78.136 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.136
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/21/2023 23:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/21/2023 8:06:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 8:04 PM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>>> RZ/G3S supports enabling/disabling clocks for its modules (including
>>> Ethernet module). For this commit adds runtime PM support which
>>> relies on PM domain to enable/disable Ethernet clocks.
>>
>>    That's not exactly something new in RZ/G3S. The ravb driver has unconditional
>> RPM calls already in the probe() and remove() methods... 
>> And the sh_eth driver
>> has RPM support since 2009...
>>
>>> At the end of probe ravb_pm_runtime_put() is called which will turn
>>
>>    I'd suggest a shorter name, like ravb_rpm_put() but (looking at this function)
>> it doesn't seem hardly needed...

   Does seem, sorry. :-)

>>> off the Ethernet clocks (if no other request arrives at the driver).
>>> After that if the interface is brought up (though ravb_open()) then
>>> the clocks remain enabled until interface is brought down (operation
>>> done though ravb_close()).
>>>
>>> If any request arrives to the driver while the interface is down the
>>> clocks are enabled to serve the request and then disabled.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>  drivers/net/ethernet/renesas/ravb.h      |  1 +
>>>  drivers/net/ethernet/renesas/ravb_main.c | 99 ++++++++++++++++++++++--
>>>  2 files changed, 93 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>> index c2d8d890031f..50f358472aab 100644
>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>> @@ -1044,6 +1044,7 @@ struct ravb_hw_info {
>>>  	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
>>>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>>>  	unsigned refclk_in_pd:1;	/* Reference clock is part of a power domain. */
>>> +	unsigned rpm:1;			/* Runtime PM available. */
>>
>>    No, I don't think this flag makes any sense. We should support RPM
>> unconditionally...

   If RPM calls work in the probe()/remove() methods, they should work
in the ndo_{open|stop}() methods, right?

> The reasons I've limited only to RZ/G3S are:
> 1/ I don't have all the platforms to test it

   That's a usual problem with the kernel development...

> 2/ on G1H this doesn't work. I tried to debugged it but I don't have a
>    platform at hand, only remotely, and is hardly to debug once the
>    ethernet fails to work: probe is working(), open is executed, PHY is
>    initialized and then TX/RX is not working... don't know why ATM.

   That's why we have the long bug fixing period after -rc1...

[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index f4634ac0c972..d70ed7e5f7f6 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -145,12 +145,41 @@ static void ravb_read_mac_address(struct device_node *np,
[...]
>>> +}
>>> +
>>>  static void ravb_mdio_ctrl(struct mdiobb_ctrl *ctrl, u32 mask, int set)
>>>  {
>>>  	struct ravb_private *priv = container_of(ctrl, struct ravb_private,
>>>  						 mdiobb);
>>> +	int ret;
>>> +
>>> +	ret = ravb_pm_runtime_get(priv);
>>> +	if (ret < 0)
>>> +		return;
>>>  
>>>  	ravb_modify(priv->ndev, PIR, mask, set ? mask : 0);
>>> +
>>> +	ravb_pm_runtime_put(priv);
>>
>>    Hmm, does this even work? :-/ Do the MDIO bits retain the values while
>> the AVB core is not clocked or even powered down?
> 
> This actually is not needed. It's a leftover. I double checked with
> mii-tools to access the device while the interface is down and the IOCTL is
> blocked in this case by
> https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/renesas/ravb_main.c#L2266

   Have you tested with ethtool as well?

>>    Note that the sh_eth driver has RPM calls in the {read|write}_c{22?45}()

   s/?/|/,

>> methods which do the full register read/write while the core is powere up

   Powered.

>> and clocked...
>>
>> [...]
>>> @@ -2064,6 +2107,11 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>  	const struct ravb_hw_info *info = priv->info;
>>>  	struct net_device_stats *nstats, *stats0, *stats1;
>>> +	int ret;
>>> +
>>> +	ret = ravb_pm_runtime_get(priv);
>>> +	if (ret < 0)
>>> +		return NULL;
>>
>>    Hm, sh_eth.c doesn't have any RPM calls in this method. Again, do
> 
> In setups where systemd is enabled, user space calls this method in
> different stages (e.g. at boot time or when running ifconfig ethX, even if
> interface is down). W/o runtime resuming here the system will fail to boot.
> 
> The other approach I wanted to take was to:
> 
> if (!netif_running(dev))
> 	return &ndev->stats;
> 
> But I didn't choose this path as there are some counters updated to nstat
> only in this function, e.g. nstats->tx_dropped += ravb_read(ndev, TROCR);
> and wanted an opinion about it.

   Have you seen the following commit (that I've already posted for you on
IRC)?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fa2955ff70ce4532f144d26b8a087095f9c9ffc

   Looks like the RPM calls won't do here...

>> the hardware counters remain valid across powering the MAC core down?
> 
> The power domain that the Ethernet clocks of RZ/G3S belong disables the
> clock and switches the Ethernet module to standby. There is no information
> in HW manual that the content of registers will be lost.

   That's what your current PD driver does... isn't it possible that
in some new SoCs the PD would be completely powered off?

[...]
>>> @@ -2115,11 +2165,18 @@ static void ravb_set_rx_mode(struct net_device *ndev)
>>>  {
>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>  	unsigned long flags;
>>> +	int ret;
>>> +
>>> +	ret = ravb_pm_runtime_get(priv);
>>> +	if (ret < 0)
>>> +		return;
>>
>>    Hm, sh_eth.c doesn't have any RPM calls in this method either.
>> Does changing the promiscous mode have sense for an offlined interface?
> 
> I've added it for scenarios when the interface is down and user tries to
> configure it. I don't know to answer your question. W/o RPM resume here
> user space blocks if tries to access it and interface is down. I can just
> return if interface is down. Let me know if you prefer this way.

   Looking at __dev_set_rx_mode(), the method gets only called when
(dev->flags & IFF_UP) is true -- but that contradicts your experience,
it seems... However, looking at net/core/dev_addr_lists.c, that function
is called from the atomic contexts, so please just return early.

>> [...]
>>> @@ -2187,6 +2244,11 @@ static int ravb_close(struct net_device *ndev)
>>>  	if (info->nc_queues)
>>>  		ravb_ring_free(ndev, RAVB_NC);
>>>  
>>> +	/* Note that if RPM is enabled on plaforms with ccc_gac=1 this needs to be
>>
>>    It's "platforms". :-)
>>
>>> skipped and
>>
>>    Overly long line?
> 
> Not more than 100 chars. Do you want it to 80?

   Yes, it's not the code, no need to go beyond 80 cols, I think...

[...]

MBR, Sergey
