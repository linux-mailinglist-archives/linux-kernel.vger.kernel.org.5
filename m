Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306867F6407
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjKWQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:37:27 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB078DD;
        Thu, 23 Nov 2023 08:37:32 -0800 (PST)
Received: from [192.168.1.103] (178.176.78.136) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 23 Nov
 2023 19:37:28 +0300
Subject: Re: [PATCH 06/13] net: ravb: Let IP specific receive function to
 interrogate descriptors
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
 <20231120084606.4083194-7-claudiu.beznea.uj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b626455a-f7a4-2684-725c-c679dd75a515@omp.ru>
Date:   Thu, 23 Nov 2023 19:37:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20231120084606.4083194-7-claudiu.beznea.uj@bp.renesas.com>
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
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 181514 [Nov 21 2023]
X-KSE-AntiSpam-Info: Version: 6.0.0.2
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.78.136
X-KSE-AntiSpam-Info: Rate: 0
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 11:45 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> ravb_poll() initial code used to interrogate the first descriptor of the
> RX queue in case gptp is false to know if ravb_rx() should be called.
> This is done for non GPTP IPs. For GPTP IPs the driver PTP specific

   It's called gPTP, AFAIK.

> information was used to know if receive function should be called. As
> every IP has it's own receive function that interrogates the RX descriptor

   Its own.

> list in the same way the ravb_poll() was doing there is no need to double
> check this in ravb_poll(). Removing the code form ravb_poll() and

   From ravb_poll().

> adjusting ravb_rx_gbeth() leads to a cleaner code.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 588e3be692d3..0fc9810c5e78 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -771,12 +771,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>  	int limit;
>  
>  	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> +	desc = &priv->gbeth_rx_ring[entry];
> +	if (desc->die_dt == DT_FEMPTY)
> +		return false;
> +

   I don't understand what this buys us, the following *while* loop will
be skipped anyway, and the *for* loop as well, I think... And ravb_rx_rcar()
doesn't have that anyway...

> @@ -1279,25 +1282,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	struct net_device *ndev = napi->dev;
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> -	bool gptp = info->gptp || info->ccc_gac;
> -	struct ravb_rx_desc *desc;
>  	unsigned long flags;
>  	int q = napi - priv->napi;
>  	int mask = BIT(q);
>  	int quota = budget;
> -	unsigned int entry;
>  
> -	if (!gptp) {
> -		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> -		desc = &priv->gbeth_rx_ring[entry];
> -	}
>  	/* Processing RX Descriptor Ring */
>  	/* Clear RX interrupt */
>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
> -	if (gptp || desc->die_dt != DT_FEMPTY) {
> -		if (ravb_rx(ndev, &quota, q))
> -			goto out;
> -	}

  I don't really understand this code (despite I've AKCed it)...
Biju, could you explain this (well, you tried already but I don't
buy it anymore)?

> +	if (ravb_rx(ndev, &quota, q))
> +		goto out;

   This restores the behavior before:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3d4e37df882b0f4f28b7223a42492650b71252c5

   So does look correct. :-)

MBR, Sergey
