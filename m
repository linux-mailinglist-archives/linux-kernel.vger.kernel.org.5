Return-Path: <linux-kernel+bounces-157020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7918B0BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5011C2225F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBC15EFCC;
	Wed, 24 Apr 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuwtFUAv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DD415EFA8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966888; cv=none; b=mWOF0o9huT336RcfhbkXOInxflPd6kOFkrKu+WCKy/KXp1+NAyWPneiYT/xgz73fHCg6rfQ/5wGJnoRqnDDwRev+TYx4t5Y1egYlm2sFSUL2lxeKFRlTChSaJoc/Ofk60HZRXDSNfGKJoXpzf3Rww9MeYqtbj0+Z+BCBKM7WOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966888; c=relaxed/simple;
	bh=psco6awsRgaMV9T/niM4W2JCE6T6vm6u5bIdA5YcY4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXUfqy6Co23TaH6S+MLMGkWjsb4MZdWPbv6KyzyF6Nwxkpc4HRoQrz0Q3vMUWhxFaLz0Wtjf6dzY3mNK0ZZsW62HIUx5NvCu6Qn1EWZ53zj2+uWrbZafZSApK9b2+R6mSFyodcYlI+Fdcj18vlgEHpUMY6L7vWdyBEuW/Kw6cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuwtFUAv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80uJMF+CJMwXdgnnjS23JUC2Vtnpylf1OILSwz1dwGo=;
	b=DuwtFUAvP3/hIFdfWE0Y9jpYJxfrFNs/f5UZq0zTweb0LR/NrqRlgN1ykLa9cOmDE1XRnA
	2edAEtLK2pQ/l4gEVnwaUkCOX0nDl/x4ONm8fuw76ay88OAdyIYJq+Mh7WK23ESo1LwYGe
	Cx9p+k8EEzsq3KePJeWNI72Cgf/541k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-T36Ifq7pMmir5GN6AExaSw-1; Wed, 24 Apr 2024 09:54:41 -0400
X-MC-Unique: T36Ifq7pMmir5GN6AExaSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 222911839FA0;
	Wed, 24 Apr 2024 13:54:41 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CCB21C060D0;
	Wed, 24 Apr 2024 13:54:39 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/8] net: psample: add tracepoint
Date: Wed, 24 Apr 2024 15:50:51 +0200
Message-ID: <20240424135109.3524355-5-amorenoz@redhat.com>
In-Reply-To: <20240424135109.3524355-1-amorenoz@redhat.com>
References: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Currently there are no widely-available tools to dump the metadata and
group information when a packet is sampled, making it difficult to
troubleshoot related issues.

This makes psample use the event tracing framework to log the sampling
of a packet so that it's easier to quickly identify the source
(i.e: group) and context (i.e: metadata) of a packet being sampled.

This patch creates some checkpatch splats, but the style of the
tracepoint definition mimics that of other modules so it seems
acceptable.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c |  9 +++++++
 net/psample/trace.h   | 62 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 net/psample/trace.h

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 476aaad7a885..92db8ffa2ba2 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -18,6 +18,12 @@
 #include <net/ip_tunnels.h>
 #include <net/dst_metadata.h>
 
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#endif
+
+#include "trace.h"
+
 #define PSAMPLE_MAX_PACKET_SIZE 0xffff
 
 static LIST_HEAD(psample_groups_list);
@@ -470,6 +476,9 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 	void *data;
 	int ret;
 
+	if (trace_psample_sample_packet_enabled())
+		trace_psample_sample_packet(group, skb, sample_rate, md);
+
 	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +
diff --git a/net/psample/trace.h b/net/psample/trace.h
new file mode 100644
index 000000000000..2d32a846989b
--- /dev/null
+++ b/net/psample/trace.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM psample
+
+#if !defined(_TRACE_PSAMPLE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PSAMPLE__H
+
+#include <linux/skbuff.h>
+#include <linux/tracepoint.h>
+#include <net/psample.h>
+
+TRACE_EVENT(psample_sample_packet,
+
+	TP_PROTO(struct psample_group *group, struct sk_buff *skb,
+		 u32 sample_rate, const struct psample_metadata *md),
+
+	TP_ARGS(group, skb, sample_rate, md),
+
+	TP_STRUCT__entry(
+		__field(u32, group_num)
+		__field(u32, refcount)
+		__field(u32, seq)
+		__field(void *, skbaddr)
+		__field(unsigned int, len)
+		__field(unsigned int, data_len)
+		__field(u32, sample_rate)
+		__field(int, in_ifindex)
+		__field(int, out_ifindex)
+		__field(const void *, user_cookie)
+		__field(u32, user_cookie_len)
+	),
+
+	TP_fast_assign(
+		__entry->group_num = group->group_num;
+		__entry->refcount = group->refcount;
+		__entry->seq = group->seq;
+		__entry->skbaddr = skb;
+		__entry->len = skb->len;
+		__entry->data_len = skb->data_len;
+		__entry->sample_rate = sample_rate;
+		__entry->in_ifindex = md->in_ifindex;
+		__entry->out_ifindex = md->out_ifindex;
+		__entry->user_cookie = &md->user_cookie[0];
+		__entry->user_cookie_len = md->user_cookie_len;
+	),
+
+	TP_printk("group_num=%u refcount=%u seq=%u skbaddr=%p len=%u data_len=%u sample_rate=%u in_ifindex=%d out_ifindex=%d user_cookie=%p user_cookie_len=%u",
+		  __entry->group_num, __entry->refcount, __entry->seq,
+		  __entry->skbaddr, __entry->len, __entry->data_len,
+		  __entry->sample_rate, __entry->in_ifindex,
+		  __entry->out_ifindex, __entry->user_cookie,
+		  __entry->user_cookie_len)
+);
+
+#endif /* _TRACE_PSAMPLE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../net/psample
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.44.0


