Return-Path: <linux-kernel+bounces-25241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695482CAED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012051C217A4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF91841;
	Sat, 13 Jan 2024 09:48:00 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F817E8;
	Sat, 13 Jan 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.83.83) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 13 Jan
 2024 12:47:49 +0300
Subject: Re: [PATCH] net: ravb: Fix wrong dma_unmap_single() calls in ring
 unmapping
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
	<u.kleine-koenig@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240113044721.481131-1-nikita.yoush@cogentembedded.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c40ebf74-e7a7-4fa6-098c-42341a030bb5@omp.ru>
Date: Sat, 13 Jan 2024 12:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240113044721.481131-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/13/2024 09:34:15
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182619 [Jan 13 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.83 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.83 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.83
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/13/2024 09:38:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/13/2024 6:00:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/13/24 7:47 AM, Nikita Yushchenko wrote:

> When unmapping ring entries on Rx ring release, ravb driver needs to
> unmap only those entries that have been mapped successfully.
> 
> To check if an entry needs to be unmapped, currently the address stored
> inside descriptor is passed to dma_mapping_error() call. But, address
> field inside descriptor is 32-bit, while dma_mapping_error() is
> implemented by comparing it's argument with DMA_MAPPING_ERROR constant
> that is 64-bit when dma_addr_t is 64-bit. So the comparison gets wrong,
> resulting into ravb driver calling dma_unnmap_single() for 0xffffffff

   It's dma_unmap_single(). :-)

> address.
> 
> When the ring entries are mapped, in case of mapping failure the driver
> sets descriptor's size field to zero (which is a signal to hardware to
> not use this descriptor). Fix ring unmapping to detect if an entry needs
> to be unmapped by checking for zero size field.
> 
> Fixes: a47b70ea86bd ("ravb: unmap descriptors when freeing rings")
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 0e3731f50fc2..4d4b5d44c4e7 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -256,8 +256,7 @@ static void ravb_rx_ring_free_gbeth(struct net_device *ndev, int q)
>  	for (i = 0; i < priv->num_rx_ring[q]; i++) {
>  		struct ravb_rx_desc *desc = &priv->gbeth_rx_ring[i];
>  
> -		if (!dma_mapping_error(ndev->dev.parent,
> -				       le32_to_cpu(desc->dptr)))
> +		if (le16_to_cpu(desc->ds_cc) != 0)

   It's not that != 0 or le16_to_cpu() are necessary here but we're on
the little-endian platforms anyways...

[...]
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

MBR, Sergey

