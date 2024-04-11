Return-Path: <linux-kernel+bounces-141353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279F58A1D27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5809A1C23EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1409F47F51;
	Thu, 11 Apr 2024 16:50:34 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6847A40;
	Thu, 11 Apr 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854233; cv=none; b=JqxAfIEPJAsSXTnSBLJdAMbtpHbI8DpPtSZWloIKrSFDScgdY5on+BVCbivnxdXX5BSCDymhC0iaxkyN9daDNsgFDJrwS1fOGfYOqvBhFiJ2XK2/ssPLsxbWcciOdGe3ONhSwKqkW7bDZdmKHHgJZpHuqwPWXtdXC/rUIIne01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854233; c=relaxed/simple;
	bh=nrMuPIFuCVO7sj/iecEjqXTHll+3KKDW+NZvU4wMcGU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UxdPmQkGQvL49U2vvzpqcv+nOgSLsaIzOb+5KFew2Mkd7HJOJwFHiOXTGr3L+12j/nlk6xdzxIsh4RR4/Pgq1ErQ8YriZ5SL6kSPh7mPos6X1H9q9fti87SLPHzchiBFDoyrmsPD/G3ii5TMDQQY26dnSJ94QeIzS988G2IRS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.224) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 11 Apr
 2024 19:50:25 +0300
Subject: Re: [PATCH net 3/4] net: ravb: Fix GbEth jumbo packet RX checksum
 handling
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-4-paul.barker.ct@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <c9c624c0-cd26-bceb-e011-7debce338493@omp.ru>
Date: Thu, 11 Apr 2024 19:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411114434.26186-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/11/2024 16:32:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 184677 [Apr 11 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 16 0.3.16
 6e64c33514fcbd07e515710c86ba61de7f56194e
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.224
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/11/2024 16:36:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/11/2024 10:51:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/11/24 2:44 PM, Paul Barker wrote:

> Sending a 7kB ping packet to the RZ/G2L in Linux v6.9-rc2 causes the
> following backtrace:
> 
> 	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127 skb_trim+0x30/0x38
> 	Modules linked in:
> 	CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.9.0-rc1-00222-gde11614025b1 #3
> 	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
> 	pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> 	pc : skb_trim+0x30/0x38
> 	lr : ravb_rx_csum_gbeth+0x40/0x90
> 	sp : ffff800080003d40
> 	x29: ffff800080003d40 x28: 0000000000000400 x27: ffff00000d0f0000
> 	x26: 0000000000000001 x25: ffff800080003e84 x24: 0000000000000e52
> 	x23: 0000000000000000 x22: ffff00000d0f0960 x21: 000000000000ffff
> 	x20: 000000000000f6ff x19: ffff00000cf4cb00 x18: 0000000000000000
> 	x17: ffff7ffffdd4f000 x16: ffff800080000000 x15: e7e6e5e4e3e2e1e0
> 	x14: dfdedddcdbdad9d8 x13: 0000131211100f0e x12: 0d0c0b0a09080706
> 	x11: 0000000013121110 x10: 0000000000000000 x9 : 0000000000000001
> 	x8 : ffff800080003cf0 x7 : 0000000000000000 x6 : ffff00007faf4590
> 	x5 : 000000000010000b x4 : a1a8362deecb53ea x3 : 0000000000000080
> 	x2 : 00000000ffff0000 x1 : 000000000cf4ccfc x0 : ffff00000cf4cb00
> 	Call trace:
> 	 skb_trim+0x30/0x38
> 	 ravb_rx_gbeth+0x56c/0x5cc
> 	 ravb_poll+0xa0/0x204
> 	 __napi_poll+0x38/0x17c
> 	 net_rx_action+0x124/0x268
> 	 __do_softirq+0x100/0x26c
> 	 ____do_softirq+0x10/0x1c
> 	 call_on_irq_stack+0x24/0x4c
> 	 do_softirq_own_stack+0x1c/0x2c
> 	 irq_exit_rcu+0xbc/0xd8
> 	 el1_interrupt+0x38/0x68
> 	 el1h_64_irq_handler+0x18/0x24
> 	 el1h_64_irq+0x64/0x68
> 	 default_idle_call+0x28/0x3c
> 	 do_idle+0x204/0x25c
> 	 cpu_startup_entry+0x38/0x3c
> 	 kernel_init+0x0/0x1d8
> 	 start_kernel+0x504/0x5f0
> 	 __primary_switched+0x80/0x88
> 	---[ end trace 0000000000000000 ]---
> 
> This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
> wrong skb for a packet which spans multiple descriptors. To fix this,
> use the correct skb.
> 
> Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

