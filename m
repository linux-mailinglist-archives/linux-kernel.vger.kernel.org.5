Return-Path: <linux-kernel+bounces-151934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF4E8AB5FC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D09EB222E0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFB13CFAC;
	Fri, 19 Apr 2024 20:26:18 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA6D137C5A;
	Fri, 19 Apr 2024 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558378; cv=none; b=BMW+XNrO8oab4m/FmIoCTOQYbsIszj30hMaE3N7szEBhZ6NxnOZA2+jOSOf0maCTlYwpRDDOfrpeiexx1aRxGB23gWHZjjzNtrdRaB23NV5CcaxHw5KRYI0q7pv43+ZBWTGh6DGhf2SUtqwkI0ZSd64a+x9uWB/GWsENxCHYzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558378; c=relaxed/simple;
	bh=tvsdpL1EtpDQPfPCU5AtidQHVL1qB+Gvt0nWGI4JnGY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eTvWySyF7h6AQiKyQjTZX/j4PXZTHk+yjhsHnIn9mDPBVSGEmol1VWSSh5j3LZcbB3C01stRWlqnPIVqbSwh2Zj9EvLRi98fpMbuoD2gFY0g3YwMRSnppxxOrsqyCGLHQsYsBGANLsMuWon4LNzsn+Hd2hjetXQiSbTKg+AERZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 19 Apr
 2024 23:26:06 +0300
Subject: Re: [net-next RFC v3 5/7] net: ravb: Enable SW IRQ Coalescing for
 GbEth
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-6-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <fb0912c7-46d1-e5eb-5329-ddfe16495b8a@omp.ru>
Date: Fri, 19 Apr 2024 23:26:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240415094804.8016-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/19/2024 20:13:24
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
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 04/19/2024 20:17:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/19/2024 5:31:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/15/24 12:48 PM, Paul Barker wrote:

> Software IRQ Coalescing is required to improve network stack performance
> in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
> GbEth IP.
> 
> This patch gives the following improvements during testing with iperf3:
> 
>   * RZ/G2L:
>     * TCP RX: same bandwidth with -6% CPU load (76% -> 71%)
>     * UDP RX: same bandwidth with -10% CPU load (99% -> 89%)
> 
>   * RZ/G2UL:
>     * UDP RX: +4200% bandwidth (1.23Mbps -> 53Mbps)
> 
>   * RZ/G3S:
>     * UDP RX: +425% bandwidth (1.23Mbps -> 6.46Mbps)
> 
> The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
> RZ/G3S) is particularly critical.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index 71de2a7aa27c..9c6392ade2f1 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1054,6 +1054,7 @@ struct ravb_hw_info {
>  	u32 rx_max_desc_use;
>  	u32 rx_desc_size;
>  	unsigned aligned_tx: 1;
> +	unsigned needs_irq_coalesce:1;	/* Needs software IRQ coalescing */

   Perhaps something shorter, like coalesce_irqs?

[...]

MBR, Sergey

