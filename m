Return-Path: <linux-kernel+bounces-48759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B278460DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917FCB278E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7138528B;
	Thu,  1 Feb 2024 19:23:00 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2012FB11;
	Thu,  1 Feb 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815380; cv=none; b=ZUA12az45n8DIKEDRraoUFUaL2mYwvjw2ELe/wLrGk0Gcq4Sog089OuXKn/dYuRDrikzFLn4gUUVrKtgirB78qRitHksj0ul6rsKA5Whkm7qcl6qKObrx37bIirPDUmRHoUVCoySTYiCkRBYgGS644HnQsvvaVTAM+GQKIYv6C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815380; c=relaxed/simple;
	bh=NokxQZ6kiNXIYprq8Mysenzkd0RWRCEMpBAfJ30F1Cw=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uNdjcuiGtviwz/l6VmIfI9LHXXnYYTWpx2qHXa3j6PHQKFQJ4b0Vq/Pyhupc1asQJqjcCzuyUPjVfW4DvtrQUhG8z1uOZ032AMDDF7IdcMALOpM21uj+opnAdAYw5EyST4eRGv/dgiy6QylPz7xElCWWbM9aFjpeCeLzijMBvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.82.6) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 1 Feb
 2024 22:22:39 +0300
Subject: Re: [PATCH net-next 0/8] Improve GbEth performance on Renesas RZ/G2L
 and related SoCs
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <a428e75e-32b7-e94e-24c3-f87097951470@omp.ru>
Date: Thu, 1 Feb 2024 22:22:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/01/2024 19:05:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183133 [Feb 01 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.6 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.6 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.6
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/01/2024 19:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/1/2024 5:08:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/31/24 8:05 PM, Paul Barker wrote:

> This series aims to improve peformance of the GbEth IP in the Renesas

   Performance.

> RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along
> the way, we do some refactoring and ensure that napi_complete_done() is
> used in accordance with the NAPI documentation.
> 
> Performance improvment mainly comes from enabling SW IRQ Coalescing for

   Improvement.

> all SoCs using the GbEth IP, and NAPI Threaded mode for single core SoCs
> using the GbEth IP. These can be enabled/disabled at runtime via sysfs,
> but our goal is to set sensible defaults which get good performance on
> the affected SoCs.
> 
> Changes are made specific to the GbEth IP, avoiding potential impact on
> the other Renesas R-Car based SoCs which also use the ravb driver. This
> follows the principle of only submitting patches that we can fully test.
> 
> The performance impact of this series on iperf3 testing is as follows:
>   * RZ/G2L Ethernet throughput is unchanged, but CPU usage drops:
>       * Bidirectional and TCP RX: 6.5% less CPU usage
>       * UDP RX: 10% less CPU usage
> 
>   * RZ/G2UL and RZ/G3S Ethernet throughput is increased for all test
>     cases except UDP TX, which suffers a slight loss:
>       * TCP TX: 32% more throughput
>       * TCP RX: 11% more throughput
>       * UDP TX: 10% less throughput
>       * UDP RX: 10183% more throughput - the previous throughput of

   10183%, really? 8-)

>         1.06Mbps is what prompted this work.
> 
>   * RZ/G2N CPU usage and Ethernet throughput is unchanged (tested as a
>     representative of the SoCs which use the R-Car based RAVB IP).
> 
> This series depends on:
>   * "net: ravb: Let IP-specific receive function to interrogate descriptors" v5
>     https://lore.kernel.org/all/20240131084133.1671440-2-claudiu.beznea.uj@bp.renesas.com/

   So this is based on yet unmerged patch?
   Dave, Jakub, et al., the series should be considered RFC then.

> To get the results shown above, you'll also need:
>   * "topology: Set capacity_freq_ref in all cases"
>     https://lore.kernel.org/all/20240117190545.596057-1-vincent.guittot@linaro.org/
> 
>   * "ravb: Add Rx checksum offload support" v2
>     https://lore.kernel.org/all/20240124102115.132154-2-biju.das.jz@bp.renesas.com/
> 
>   * "ravb: Add Tx checksum offload support" v2
>     https://lore.kernel.org/all/20240124102115.132154-3-biju.das.jz@bp.renesas.com/

   Those 2 are not finalized yet...

> Work in this area will continue, in particular we expect to improve
> TCP/UDP RX performance further with future changes to RX buffer
> handling.
> 
> Paul Barker (8):
>   net: ravb: Split R-Car & GbEth poll functions
>   net: ravb: Simplify GbEth poll & receive functions
>   net: ravb: Count packets in GbEth RX (not descriptors)
>   net: ravb: Always process TX descriptor ring in GbEth poll
>   net: ravb: Always update error counters
>   net: ravb: Align GbEth poll function with NAPI docs
>   net: ravb: Enable SW IRQ Coalescing for GbEth
>   net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
> 
>  drivers/net/ethernet/renesas/ravb.h      |   3 +-
>  drivers/net/ethernet/renesas/ravb_main.c | 103 ++++++++++++++++-------
>  2 files changed, 74 insertions(+), 32 deletions(-)

MBR, Sergey

