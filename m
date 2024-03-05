Return-Path: <linux-kernel+bounces-91597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3EB871415
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40122837CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5529429;
	Tue,  5 Mar 2024 03:04:34 +0000 (UTC)
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 891991865C;
	Tue,  5 Mar 2024 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607873; cv=none; b=u1h44mBfRKffhqOpliaMv0f6XI2ywa0/RhotA0fBYqZQR+Z3skpagc3eVG5EurCSrq73ysfMOZp5OYVwHhDOQAoA/3OL5sr21lgqLKlrheANgGVgQE+GsYKCkoIfluGOjtcU7HJyDY8E0W9D5G8sd+19y3azucWEN9Vp2lOD5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607873; c=relaxed/simple;
	bh=7Hnw9hlX+4zSjf4KQl6x8LEy3mDpM4USWbEat1p4VjY=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j5owLFYXOPbam41LQ0/8X5d6ImusjUQGTmNz+v+JKEkWePLkUvaXG/WIzk9AnqkyED0R0ohwEM6bxTvESut0C7X9wX+GRztob61lo/SZou7KBDC3sqGa+G8G5pQDUsWd6hKZyTXJzQuiQEh+shU2BzVGA1/mWiQXslH4dE+TIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.12])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id A4B0E1858BE7AE;
	Tue,  5 Mar 2024 11:04:22 +0800 (CST)
Received: from didi-ThinkCentre-M920t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 11:04:22 +0800
Date: Tue, 5 Mar 2024 11:04:17 +0800
X-MD-Sfrom: fuyuanli@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From: fuyuanli <fuyuanli@didiglobal.com>
To: <edumazet@google.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>
CC: <mathieu.desnoyers@efficios.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<fuyuanli@didiglobal.com>
Subject: [PATCH net-next v3] tcp: Add skb addr and sock addr to arguments of
 tracepoint tcp_probe.
Message-ID: <20240305030358.GA13138@didi-ThinkCentre-M920t-N000>
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
calculate transmit latency between layer 2 and layer 4 by ebpf, but which is
not available in tcp_probe, so we can only use kprobe hooking
tcp_rcv_established to get them. But we can use tcp_probe directly if skb
addr and sock addr are available, which is more efficient.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
---
v3
Link: https://lore.kernel.org/netdev/20240304034632.GA21357@didi-ThinkCentre-M920t-N000/
1) Fix some errors of spellchecking in commit message.

v2
Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkCentre-M920t-N000/
1) Add printing about those two addresses.
2) Target "net-next" in the title of patch.
---
 include/trace/events/tcp.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 7b1ddffa3dfc..efb651683781 100644
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
@@ -285,14 +287,18 @@ TRACE_EVENT(tcp_probe,
 		__entry->ssthresh = tcp_current_ssthresh(sk);
 		__entry->srtt = tp->srtt_us >> 3;
 		__entry->sock_cookie = sock_gen_cookie(sk);
+
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
 	),
 
-	TP_printk("family=%s src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx",
+	TP_printk("family=%s src=%pISpc dest=%pISpc mark=%#x data_len=%d snd_nxt=%#x snd_una=%#x snd_cwnd=%u ssthresh=%u snd_wnd=%u srtt=%u rcv_wnd=%u sock_cookie=%llx skbaddr=%p skaddr=%p",
 		  show_family_name(__entry->family),
 		  __entry->saddr, __entry->daddr, __entry->mark,
 		  __entry->data_len, __entry->snd_nxt, __entry->snd_una,
 		  __entry->snd_cwnd, __entry->ssthresh, __entry->snd_wnd,
-		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie)
+		  __entry->srtt, __entry->rcv_wnd, __entry->sock_cookie,
+		  __entry->skbaddr, __entry->skaddr)
 );
 
 #define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
-- 
2.17.1


