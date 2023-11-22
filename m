Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561AA7F4C50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjKVQ0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKVQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:26:05 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC758BD;
        Wed, 22 Nov 2023 08:26:00 -0800 (PST)
Received: from [192.168.1.103] (31.173.85.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 22 Nov
 2023 19:25:49 +0300
Subject: Re: [PATCH 13/13] net: ravb: Add runtime PM support
To:     Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
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
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <04cb07fe-cccc-774a-f14d-763ce7ae7b07@omp.ru>
Date:   Wed, 22 Nov 2023 19:25:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231120084606.4083194-14-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.85.136]
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
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.136 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.136
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 11:46 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> RZ/G3S supports enabling/disabling clocks for its modules (including
> Ethernet module). For this commit adds runtime PM support which
> relies on PM domain to enable/disable Ethernet clocks.

   That's not exactly something new in RZ/G3S. The ravb driver has unconditional
RPM calls already in the probe() and remove() methods... And the sh_eth driver
has RPM support since 2009...

> At the end of probe ravb_pm_runtime_put() is called which will turn

   I'd suggest a shorter name, like ravb_rpm_put() but (looking at this function)
it doesn't seem hardly needed...

> off the Ethernet clocks (if no other request arrives at the driver).
> After that if the interface is brought up (though ravb_open()) then
> the clocks remain enabled until interface is brought down (operation
> done though ravb_close()).
> 
> If any request arrives to the driver while the interface is down the
> clocks are enabled to serve the request and then disabled.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb.h      |  1 +
>  drivers/net/ethernet/renesas/ravb_main.c | 99 ++++++++++++++++++++++--
>  2 files changed, 93 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index c2d8d890031f..50f358472aab 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1044,6 +1044,7 @@ struct ravb_hw_info {
>  	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>  	unsigned refclk_in_pd:1;	/* Reference clock is part of a power domain. */
> +	unsigned rpm:1;			/* Runtime PM available. */

   No, I don't think this flag makes any sense. We should support RPM
unconditionally...

[...]
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index f4634ac0c972..d70ed7e5f7f6 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -145,12 +145,41 @@ static void ravb_read_mac_address(struct device_node *np,
[...]
> +static void ravb_pm_runtime_put(struct ravb_private *priv)
> +{
> +	const struct ravb_hw_info *info = priv->info;
> +	struct device *dev = &priv->pdev->dev;
> +
> +	if (!info->rpm)
> +		return;
> +
> +	pm_runtime_mark_last_busy(dev);

   Not very familiar with RPM... what's this for?

> +	pm_runtime_put_autosuspend(dev);

   Why not the usual pm_runtime_put()?

> +}
> +
>  static void ravb_mdio_ctrl(struct mdiobb_ctrl *ctrl, u32 mask, int set)
>  {
>  	struct ravb_private *priv = container_of(ctrl, struct ravb_private,
>  						 mdiobb);
> +	int ret;
> +
> +	ret = ravb_pm_runtime_get(priv);
> +	if (ret < 0)
> +		return;
>  
>  	ravb_modify(priv->ndev, PIR, mask, set ? mask : 0);
> +
> +	ravb_pm_runtime_put(priv);

   Hmm, does this even work? :-/ Do the MDIO bits retain the values while
the AVB core is not clocked or even powered down?
   Note that the sh_eth driver has RPM calls in the {read|write}_c{22?45}()
methods which do the full register read/write while the core is powere up
and clocked...

[...]
> @@ -2064,6 +2107,11 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  	struct net_device_stats *nstats, *stats0, *stats1;
> +	int ret;
> +
> +	ret = ravb_pm_runtime_get(priv);
> +	if (ret < 0)
> +		return NULL;

   Hm, sh_eth.c doesn't have any RPM calls in this method. Again, do
the hardware counters remain valid across powering the MAC core down?

[...]
> @@ -2115,11 +2165,18 @@ static void ravb_set_rx_mode(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	unsigned long flags;
> +	int ret;
> +
> +	ret = ravb_pm_runtime_get(priv);
> +	if (ret < 0)
> +		return;

   Hm, sh_eth.c doesn't have any RPM calls in this method either.
Does changing the promiscous mode have sense for an offlined interface?

[...]
> @@ -2187,6 +2244,11 @@ static int ravb_close(struct net_device *ndev)
>  	if (info->nc_queues)
>  		ravb_ring_free(ndev, RAVB_NC);
>  
> +	/* Note that if RPM is enabled on plaforms with ccc_gac=1 this needs to be

   It's "platforms". :-)

> skipped and

   Overly long line?

> +	 * added to suspend function after PTP is stopped.

   I guess we'll have to do that because RPM is actually not RZ/G3
specific...

> +	 */
> +	ravb_pm_runtime_put(priv);
> +
>  	return 0;
>  }
>  
> @@ -2636,6 +2699,12 @@ static int ravb_probe(struct platform_device *pdev)
>  	if (error)
>  		return error;
>  
> +	info = of_device_get_match_data(&pdev->dev);
> +
> +	if (info->rpm) {
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, 100);

   Why exactly 100 ms?

> +		pm_runtime_use_autosuspend(&pdev->dev);
> +	}

   Before calling pm_runtime_enable()?

>  	pm_runtime_enable(&pdev->dev);
[...]
> @@ -2880,6 +2950,8 @@ static int ravb_probe(struct platform_device *pdev)
>  	pm_runtime_put(&pdev->dev);
>  pm_runtime_disable:
>  	pm_runtime_disable(&pdev->dev);
> +	if (info->rpm)
> +		pm_runtime_dont_use_autosuspend(&pdev->dev);

   After calling pm_runtime_disable()?

[...]
> @@ -2908,6 +2985,8 @@ static void ravb_remove(struct platform_device *pdev)
>  			  priv->desc_bat_dma);
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> +	if (info->rpm)
> +		pm_runtime_dont_use_autosuspend(&pdev->dev);

   After calling pm_runtime_disable()?

[...]

MBR, Sergey
