Return-Path: <linux-kernel+bounces-60520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958A7850600
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327B31F23B37
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2D5F544;
	Sat, 10 Feb 2024 18:42:44 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF861E484;
	Sat, 10 Feb 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707590563; cv=none; b=GHmKOmuAKa2bU6SjxKZi5BOZuJcdrzdzAtuqAunfgSzslkmi8kKFcWvywQ5lwBz2iGFBDw0vVwKahYG+gUu1jVeQVKJj+0TgH8hb2vVeuwg4llok6DKcz2CwaF0Vb9azkEUSiarFk/ekTmM4m/W4gmy375EGmyxlq+nNsTCrPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707590563; c=relaxed/simple;
	bh=X9SV1tC7rjZhp8FTyywbWyvX4t8GzqLyBGr/yf6plqU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FJFHslUvne8cab4X5bsRFccVPobpaOITHsnOCeO79Ak29t12vonfPUFXQshQSId7sbrE13Hr0Bfvr4vvDRHwvN+2rslXG1WPKJw4YcJ4oggwCxaO8Yk+2uL0jddejyqcRvpE4Fc5nOBcAp5Kq4zqm9vLN5TjCo2tlQQRqFIboic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.86.126) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 10 Feb
 2024 21:42:28 +0300
Subject: Re: [RFC PATCH net-next v2 6/7] net: ravb: Enable SW IRQ Coalescing
 for GbEth
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <20240206091909.3191-7-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2251fe66-11b7-2f30-c905-7bc1b9a57dab@omp.ru>
Date: Sat, 10 Feb 2024 21:42:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240206091909.3191-7-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/10/2024 18:29:50
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183344 [Feb 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.126 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.126 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.126
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/10/2024 18:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/10/2024 2:13:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/6/24 12:19 PM, Paul Barker wrote:

> Software IRQ Coalescing is required to improve network stack performance
> in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
> GbEth IP.
> 
> For the RZ/G2L, network throughput is comparable before and after this
> change. CPU usage during TCP RX testing dropped by 6.5% and during UDP
> RX testing dropped by 10%.
> 
> For the RZ/G2UL, network throughput is greatly increased by this change
> (results obtained with iperf3):
>   * TCP TX: 2.9% more throughput
>   * TCP RX: 1.1% more throughput
>   * UDP TX: similar throughput
>   * UDP RX: 41500% more throughput

   Wow! 8-)

> For the RZ/G3S we see improvements in network throughput similar to the
> RZ/G2UL.
> 
> The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
> RZ/G3S) is particularly critical.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 55a7a08aabef..ca7a66759e35 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1078,6 +1078,7 @@ struct ravb_hw_info {
>  	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
>  	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
> +	unsigned needs_irq_coalesce:1;	/* Requires SW IRQ Coalescing to achieve best performance */

   Is this really a hardware feature?
   Also, s/Requires SW/Needs software/ and s/to achieve best performance//,
please...

[...]

MBR, Sergey

