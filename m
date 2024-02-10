Return-Path: <linux-kernel+bounces-60528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B0850620
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016E01C23DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7A05F57B;
	Sat, 10 Feb 2024 19:36:30 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DF5C5FB;
	Sat, 10 Feb 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707593789; cv=none; b=OHOZJ3XNjwLftKWmDpJP4xNWHe8g5A19C1ScIld6j2CMKlnEWSQrXyMC75w4HD1bJ/V6SQJYArQzJliW4Mi795n74Jy+8G+plPwDopfT7BtCntYopkzlPmVCjhtlrvCEUmGhhYQQqmvhmSGuNhqygKAbxXbdkOXr+AQlo+i5U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707593789; c=relaxed/simple;
	bh=0qbldKDZWrl0zrtYJIqLSmDpMmwTQAdCo6zSGyVHVJ0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VvaJZSWcv2K+5/MYcG9bQBgaEXhhwMf/e82cmdgH3r7EnhJJdaLHgvSjN9dBYHEme3VDs+eFRKFp8daFVUGh7mBtPfiHZmklkJiZkyvLVXUhhEUo5nsVAbI92vRWWSlYPHxM7PeRD6opByZf9SRJjZEgClWJf2/s3/oxnb/LZlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.86.126) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 10 Feb
 2024 22:36:17 +0300
Subject: Re: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas
 RZ/G2L and related SoCs
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
Date: Sat, 10 Feb 2024 22:36:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/10/2024 19:22:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183344 [Feb 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.126 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.126 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 02/10/2024 19:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/10/2024 2:13:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/6/24 12:19 PM, Paul Barker wrote:

> This series aims to improve peformance of the GbEth IP in the Renesas

   You didn't fix the typo in "peformance"... :-/

> RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along
> the way, we do some refactoring and ensure that napi_complete_done() is
> used in accordance with the NAPI documentation for both GbEth and R-Car
> code paths.
> 
> Performance improvment mainly comes from enabling SW IRQ Coalescing for

   And in "improvment" too... :-/

> all SoCs using the GbEth IP, and NAPI Threaded mode for single core SoCs
> using the GbEth IP. These can be enabled/disabled at runtime via sysfs,
> but our goal is to set sensible defaults which get good performance on
> the affected SoCs.
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

   So this is a real figure? I thought you forgot to erase 10... :-)

>         1.06Mbps is what prompted this work.
> 
>   * RZ/G2N CPU usage and Ethernet throughput is unchanged (tested as a
>     representative of the SoCs which use the R-Car based RAVB IP).
> 
> This series depends on:
>   * "net: ravb: Let IP-specific receive function to interrogate descriptors" v6
>     https://lore.kernel.org/all/20240202084136.3426492-2-claudiu.beznea.uj@bp.renesas.com/

   This one has been merged now, so you can drop RFC...

> To get the results shown above, you'll also need:
>   * "topology: Set capacity_freq_ref in all cases"
>     https://lore.kernel.org/all/20240117190545.596057-1-vincent.guittot@linaro.org/
> 
>   * "ravb: Add Rx checksum offload support" v4
>     https://lore.kernel.org/all/20240203142559.130466-2-biju.das.jz@bp.renesas.com/
> 
>   * "ravb: Add Tx checksum offload support" v4
>     https://lore.kernel.org/all/20240203142559.130466-3-biju.das.jz@bp.renesas.com/

   These two have been merged too...

> Work in this area will continue, in particular we expect to improve
> TCP/UDP RX performance further with future changes to RX buffer
> handling.
> 
> Changes v1->v2:
>   * Marked as RFC as the series depends on unmerged patches.
>   * Refactored R-Car code paths as well as GbEth code paths.
>   * Updated references to the patches this series depends on.
> 
> Paul Barker (7):
>   net: ravb: Simplify poll & receive functions

   The below 3 commits fix issues in the GbEth code, so should
be redone against net.git and posted separately from this series...

>   net: ravb: Count packets instead of descriptors in RX path
>   net: ravb: Always process TX descriptor ring
>   net: ravb: Always update error counters

[...]

MBR, Sergey

