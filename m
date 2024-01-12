Return-Path: <linux-kernel+bounces-25025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8AE82C64A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0BCB22E20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3916435;
	Fri, 12 Jan 2024 20:15:56 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9781E16410;
	Fri, 12 Jan 2024 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.79.58) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 12 Jan
 2024 23:15:34 +0300
Subject: Re: [PATCH] net: ethernet: ravb: fix dma mapping failure handling
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6e5150c8-452a-f794-dbf4-18b64bcae206@omp.ru>
Date: Fri, 12 Jan 2024 23:15:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/12/2024 20:00:31
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182617 [Jan 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.79.58 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.79.58
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/12/2024 20:04:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/12/2024 7:08:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/12/24 8:06 AM, Nikita Yushchenko wrote:

> dma_mapping_error() depends on getting full 64-bit dma_addr_t and does
> not work correctly if 32-bit value is passed instead.
> 
> Fix handling of dma_map_single() failures on Rx ring entries:
> - do not store return value of dma_map_signle() in 32-bit variable,

   This one is on the TX path, in ravb_start_xmit()... :-/

> - do not use dma_mapping_error() against 32-bit descriptor field when
>   checking if unmap is needed, check for zero size instead.

   This one is on the RX path indeed...
   I suggest that you split this patch to the RX/TX path patches, as it fixes different issues.

> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

   You forgot to specify the Fixes tag (we'd need two of those,
one per patch)...

> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 8649b3e90edb..4d4b5d44c4e7 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -256,8 +256,7 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
>  	for (i = 0; i < priv->num_rx_ring[q]; i++) {
>  		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
>  
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> +		if (le16_to_cpu(desc->ds_cc) != 0)
>  			dma_unmap_single(ndev->dev.parent,
>  					 le32_to_cpu(desc->dptr),
>  					 GBETH_RX_BUFF_MAX,
> @@ -281,8 +280,7 @@ static void ravb_rx_ring_free_rcar(struct net_device *ndev, int q)
>  	for (i = 0; i < priv->num_rx_ring[q]; i++) {
>  		struct ravb_ex_rx_desc *desc = &priv->rx_ring[q][i];
>  
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> +		if (le16_to_cpu(desc->ds_cc) != 0)
>  			dma_unmap_single(ndev->dev.parent,
>  					 le32_to_cpu(desc->dptr),
>  					 RX_BUF_SZ,

   For these hunks it will be:

Fixes: a47b70ea86bd ("ravb: unmap descriptors when freeing rings")

> @@ -1949,7 +1947,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct ravb_tstamp_skb *ts_skb;
>  	struct ravb_tx_desc *desc;
>  	unsigned long flags;
> -	u32 dma_addr;
> +	dma_addr_t dma_addr;
>  	void *buffer;
>  	u32 entry;
>  	u32 len;

   And for this hunk it will be:

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")

MBR, Sergey

