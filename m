Return-Path: <linux-kernel+bounces-151925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB138AB5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4D2830DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7813CA99;
	Fri, 19 Apr 2024 20:04:12 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4664F;
	Fri, 19 Apr 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557052; cv=none; b=i8dzbL0w5GT+k0zfJqkYhd2KEJ6fBWooVa1t0D2GdBqy5HVGKHs4lK+HqH9JWpyNubSW3Alon3yvtEpB1RCNw9nnJNZwasglnGppFdg7TYkUuf3YrpjjHMd18hQv8x9DI/5S3Veh/mrMgX3SQJEga29fsQL6+1EFrHpURdPiIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557052; c=relaxed/simple;
	bh=bsb0pjSgW6p7yJQGVT/QL4oxCfiTFKHKZH7qTYMV7TY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fh6YCUTghn1M0/GrIxhADWZhz+cHGSmd1fz53rI99p61D0N9Nt2/s8RXbTuKjlHmdKSo7Gkfd1j/AzI2IWROX2Jj5mPnvnCN7D4U60M0Wb0haOLWZ40pZjfarW8knErMq2411AW3qedo2GD4z55Cw6CuNIkLldHnjakKIDuq1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 19 Apr
 2024 23:03:52 +0300
Subject: Re: [net-next RFC v3 4/7] net: ravb: Refactor GbEth RX code path
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>
Date: Fri, 19 Apr 2024 23:03:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/19/2024 19:43:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184817 [Apr 19 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.253 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.253
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2024 19:47:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/19/2024 5:31:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/15/24 12:48 PM, Paul Barker wrote:

> We can reduce code duplication in ravb_rx_gbeth() and add comments to
> make the code flow easier to understand.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 70 ++++++++++++------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index baa01bd81f2d..12618171f6d5 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -818,47 +818,47 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  				stats->rx_missed_errors++;
>  		} else {
>  			die_dt = desc->die_dt & 0xF0;
> -			switch (die_dt) {
> -			case DT_FSINGLE:
> -				skb = ravb_get_skb_gbeth(ndev, entry, desc);
> +			skb = ravb_get_skb_gbeth(ndev, entry, desc);
> +			if (die_dt == DT_FSINGLE || die_dt == DT_FSTART) {

   No, please keep using *switch* statement here...

> +				/* Start of packet:
> +				 * Set initial data length.
> +				 */
>  				skb_put(skb, desc_len);
> +
> +				/* Save this SKB if the packet spans multiple
> +				 * descriptors.
> +				 */
> +				if (die_dt == DT_FSTART)
> +					priv->rx_1st_skb = skb;

   Hm, looks like we can do that under *case* DT_FSTART: and do
a fallthru to *case* DT_FSINGLE: after that...

> +			} else {
> +				/* Continuing a packet:
> +				 * Move data into the saved SKB.
> +				 */
> +				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
> +							       priv->rx_1st_skb->len,
> +							       skb->data,
> +							       desc_len);
> +				skb_put(priv->rx_1st_skb, desc_len);
> +				dev_kfree_skb(skb);
> +
> +				/* Set skb to point at the whole packet so that
> +				 * we only need one code path for finishing a
> +				 * packet.
> +				 */
> +				skb = priv->rx_1st_skb;
> +			}
> +
> +			if (die_dt == DT_FSINGLE || die_dt == DT_FEND) {

   Again, keep using *switch*, please...

> +				/* Finishing a packet:
> +				 * Determine protocol & checksum, hand off to
> +				 * NAPI and update our stats.
> +				 */
>  				skb->protocol = eth_type_trans(skb, ndev);
>  				if (ndev->features & NETIF_F_RXCSUM)
>  					ravb_rx_csum_gbeth(skb);
> +				stats->rx_bytes += skb->len;
>  				napi_gro_receive(&priv->napi[q], skb);
>  				rx_packets++;
[...]

MBR, Sergey

