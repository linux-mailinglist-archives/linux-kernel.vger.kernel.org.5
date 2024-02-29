Return-Path: <linux-kernel+bounces-86136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D770E86C03D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155B51C21271
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6103A8F7;
	Thu, 29 Feb 2024 05:31:46 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 192CA3A28D;
	Thu, 29 Feb 2024 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184706; cv=none; b=PFI/jDW9ISHqKRptjXoJM8KIjP1JlKhuClsm8yuP2Eh/KZgExR7eamvN9QWvkXfcvAx8ZHy6SfMSZ82/qa6XC94Ybnlpudowz3ECF5bmCBfoEdO68F7UtnMH8MPBVCCTXhyPlsrAOUi58wwmfyhC6/4pdMiJPD4SX2jVqY7+8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184706; c=relaxed/simple;
	bh=ItNNI5PI2/YfqekAfeRz73Do4tEfWpAAJlwE9t9osO4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l5a/Y35iPu3p5DXLRl7KueenygWiVQnbUFUtbhBjFgcw8sijHxMmrdCwKI+6zEv95js3+xDuIfOUxS/JXEX/tXD3Eybxs+dKoK62+rd4ssFYWLJ1R6L7jKi1JIafpXBSxkgQCokGDq8EWr8ZLHQ+bQhqxePG0MwAmPaEnw7ZcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 6D60D1875C42A1;
	Thu, 29 Feb 2024 13:28:31 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 13:28:30 +0800
Date: Thu, 29 Feb 2024 13:28:22 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: <edumazet@google.com>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<fuyuanli@didiglobal.com>
Subject: [PATCH] tcp: Add skb addr and sock addr to arguments of tracepoint
 tcp_probe.
Message-ID: <20240229052813.GA23899@didi-ThinkCentre-M920t-N000>
Mail-Followup-To: edumazet@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, fuyuanli@didiglobal.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)

It is useful to expose skb addr and sock addr to user in tracepoint
tcp_probe, so that we can get more information while monitoring
receiving of tcp data, by ebpf or other ways.

For example, we need to identify a packet by seq and end_seq when
calculate transmit latency between lay 2 and lay 4 by ebpf, but which is
not available in tcp_probe, so we can only use kprobe hooking
tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
addr and sock addr are available, which is more efficient.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
 include/trace/events/tcp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..096c15f64b92 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -258,6 +258,8 @@ TRACE_EVENT(tcp_probe,
 		__field(__u32, srtt)
 		__field(__u32, rcv_wnd)
 		__field(__u64, sock_cookie)
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
 	),
 
 	TP_fast_assign(
@@ -285,6 +287,9 @@ TRACE_EVENT(tcp_probe,
 		__entry->ssthresh = tcp_current_ssthresh(sk);
 		__entry->srtt = tp->srtt_us >> 3;
 		__entry->sock_cookie = sock_gen_cookie(sk);
+
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
 	),
 
 	TP_printk("family=%s src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
-- 
2.17.1


