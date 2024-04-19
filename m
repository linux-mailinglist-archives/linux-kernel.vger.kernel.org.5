Return-Path: <linux-kernel+bounces-151935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F18AB601
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8CD1C21113
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C01119F;
	Fri, 19 Apr 2024 20:32:29 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A0C101C5;
	Fri, 19 Apr 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713558749; cv=none; b=uu8Xcv8CTeRkdPMmFJuxujbCGqxBc+eTlgU1r6nISBg9p6HGQC0PRD46FKImkSz25ClysL7uRIpUGtYs6B/y4MO8bzw3UFgsFt/rAXLQdEVeg9bEtwHprjD4jVQNfpW0Xi79eE71Q7oc48P1LrN3KwaiyLXNMfO6rMgZFUZzN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713558749; c=relaxed/simple;
	bh=iIpahAw5PpHy24asSke5uHmNqC/cfIbo+GffosFW+yU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kNAsLDkcZsM+vgLxmJ1ZNlXMHa4yFoNGHTRODtknFtHdXT6KJGTFhyGUBiRfwyGWt6ihDSkAHzd8z7b67/8Hb+cSfeVEfwvX6ybIIjLy9Zd/3JR52WhHKDmhucB+sGColeQYeM3xnKJ8IKl+pC4HicX1uyh82VrjiQKYKj3yf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 19 Apr
 2024 23:32:17 +0300
Subject: Re: [net-next RFC v3 6/7] net: ravb: Use NAPI threaded mode on 1-core
 CPUs with GbEth IP
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-7-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <66667ef2-2e0b-3c31-66ad-d6d6514919c7@omp.ru>
Date: Fri, 19 Apr 2024 23:32:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240415094804.8016-7-paul.barker.ct@bp.renesas.com>
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

> NAPI Threaded mode (along with the previously enabled SW IRQ Coalescing)
> is required to improve network stack performance for single core SoCs
> using the GbEth IP (currently the RZ/G2L SoC family and the RZ/G3S SoC).
> 
> This patch gives the following improvements during testing with iperf3.
> 
>   * RZ/G2UL:
>     * TCP TX: +32% bandwidth (638Mbps -> 841Mbps)
>     * TXP RX: +8.8% bandwidth (667Mbps -> 726Mbps)
>     * UDP RX: +104% bandwidth (53Mbps -> 108Mbps)
> 
>   * RZ/G3S:
>     * TCP TX: 29% bandwidth (529Mbps -> 681Mbps)
>     * UDP RX: +1290% bandwidth (6.46Mbps -> 90Mbps)
> 
>   * RZ/Five:
>     * UDP RX: Test no longer crashes (0 -> 20 Mbps)
> 
> This patch gives the following reductions in performance in the same
> testing:
> 
>   * RZ/G2UL:
>     * UDP TX: -7.5% bandwidth (594Mbps -> 549Mbps)
> 
>   * RZ/G3S:
>     * UDP TX: -5% bandwidth (625Mbps -> 594Mbps)
> 
> These losses are considered acceptable given the benefits shown above.
> If UDP TX bandwidth must be maximised for a particular use case, NAPI
> threaded mode can be disabled at runtime via sysfs writes.
> 
> The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
> RZ/G3S) is particularly critical.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

