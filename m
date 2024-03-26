Return-Path: <linux-kernel+bounces-119949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248E88CF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080B4327426
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A76512B14B;
	Tue, 26 Mar 2024 20:46:08 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58217591;
	Tue, 26 Mar 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485967; cv=none; b=WVahVDNKRP6vSdh6UDZib8p5SWQvmm9Ixjxr2f0AuM5r59Hl9ccA4gmqpuUqKM9nU9HhM0agLBCiCfbvb+aCx//Vgd17Q4YcfzhcpRXDX3X7Ih5gZ5fbQw4yh1Ucyx5lM0bDqF/2KYLtH6iI0T9fqzXvuoMqdiZhXmbnVSoF8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485967; c=relaxed/simple;
	bh=I+m323qrScoplgD7tgJEKjUTCwMNgAWsVZh3d6BG38Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RZOIShHPCgVyT45CUl/TCzu6Q3IURmLmmS1TGt28hALNVNkiVl19FoL/z6u0lW1dEsix9VSxVG+u7FTLANVpuaMjn+AvkldUw9X5xjmWjJsYFi9WsrNEMhKh1GlnwwbrxE1R8XBaHfykFiWXC3BHjO9FxlhWsfONWsx1JyJTfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.80.118) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 23:45:46 +0300
Subject: Re: [PATCH 2/2] net: ravb: Always update error counters
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	<netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
 <20240326083740.23364-2-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b2594458-0819-9b92-26fb-7cd5e8725e60@omp.ru>
Date: Tue, 26 Mar 2024 23:45:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326083740.23364-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/26/2024 20:26:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184430 [Mar 26 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 12 0.3.12
 d1a01b14eb3fc102c904d35fe6c2622ed2d1c16e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.118 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.80.118 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.80.118
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/26/2024 20:34:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/26/2024 6:28:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 3/26/24 11:37 AM, Paul Barker wrote:

> The error statistics should be updated each time the poll function is
> called, even if the full RX work budget has been consumed. This prevents
> the counts from becoming stuck when RX bandwidth usage is high.
> 
> This also ensures that error counters are not updated after we've
> re-enabled interrupts as that could result in a race condition.
> 
> Also drop an unnecessary space.

   Which one? I'm seeing one intact... :-)

> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")

   As have been already said, it's wrong... :-/

> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 4f98e4e2badb..a95703948a36 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1339,6 +1339,15 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	netif_wake_subqueue(ndev, q);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> +	/* Receive error message handling */
> +	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;

   So you missed this extra space...

> +	if (info->nc_queues)
> +		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
> +	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
> +		ndev->stats.rx_over_errors = priv->rx_over_errors;
> +	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
> +		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
> +
>  	if (!rearm)
>  		goto out;
>  
[...]

MBR, Sergey

