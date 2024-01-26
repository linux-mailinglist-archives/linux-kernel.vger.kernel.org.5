Return-Path: <linux-kernel+bounces-40116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3379283DA78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EE21C209D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A5A1B7FC;
	Fri, 26 Jan 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="IN36Wbo+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880271B7EF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706274155; cv=none; b=PZn5Y93V86U5uY3/WIQ91BKuLYSPgbiG9H1H3GkkUPGN25YYZy3cq1zSbXgv7FmwZS/a1oef/54jQ9BFL/FFvLhtGAG3lzAP68t8rGwarbzrWUxHCr5VD0CWPh2CVuJwb7Zr+vpIQwMociGAKVLv9vU3P3WeB1gA2yw0fJh8JA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706274155; c=relaxed/simple;
	bh=EDXuefEciKTCME/A2dMElXxs/lWJf3XhIt3Ju7eSQVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xn/eBE76sT6IN8Bd5zIIVNru2gAuJludflq02amXdNRnUU1o3QUdvkJT5sKwWJHv/hz7edU/ML/HCClmnUZf/LuahfRHjUcgvMdSeiIe8kyMvJoNMLZywGoQfQ1CrSaAV28+LNtKr/ElWaFlR/hi5LY+uCGutRFlfr2oV/+qSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=IN36Wbo+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71cb97937so1993415ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 05:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706274153; x=1706878953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t9J/yZkugauITzzzeewJF5kZsPK6ngxJQMvu/7HtZ40=;
        b=IN36Wbo+zE4QyaVLyrQTO4zpB+Mo8mKUqWPAZcgvh4P7M/Lk+BYGt76PRcpEeGDkcX
         GBn6efG2esUlMf5IbsCe0BTohJa+8kYt3u7EZcagk5oscE8nUucK/ygNjx2jywfUcPgw
         cgQ8if2RaxrrMgnjTAYqIqWUNPi4isntG+zTG37M1tWh0FT8LAZiUokDLGfjuOcft88k
         gBzJY6MgpbFhJ8J0NOsxU5ktuV/3DDFC34rLwAaid5E5ZoBog+Z1ga8WCR8dNWJNXC2i
         DboLFg0PdD56VYKYXT45v9FsdEngjCpEDCzBuks95l8aYlmaFzsI4cjGc/4EkSDWc4xk
         s4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706274153; x=1706878953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9J/yZkugauITzzzeewJF5kZsPK6ngxJQMvu/7HtZ40=;
        b=SQTrIqYGVBwFgJcNSYnFCxygJ211B4/xTZ9bDKXf6QBMpO6nTDBRnlIQne4b/xMzTq
         HQCwipgronLkmlpDq4EbGhWOCXwFIb4sqgbekXi9ilDMvailwJKau5ngEOyih4NJPEU8
         YZeAW9l0vMsi5fxgR0eVPTh7yU+n4LRs11GWQm+xLOIEHpb4nld89bITLN1uNBQlgTYI
         V6mo3WtgqEeOpXfrDZLqp+tEIN2BoH0bDlmfjttgOkCcgy4jF6iXTLTygwH8PHdRmn3+
         57q1mbFAb2Yg33sGDm/+7skBjFXWsaSaKigxRQhetqE0DwRQwpW2Y3vJV9PsRbKrramN
         gvaA==
X-Gm-Message-State: AOJu0Yzz7tiTIjWmkH9ZnU9bFf8jkNKhbpinLs+BZFbED9bKp2Xowcs9
	s+HAvDhHrB/VWR4E3sPbT/Eq6EbvD9Dx2r9tQ7IJ38Z7gJ9WU/2lw6cH4qi7vSY=
X-Google-Smtp-Source: AGHT+IF8YOXQY78u8Ud9V14+ScFszVUf3XLLG4GU9m9SRZM6QnSj1wvcbZNaDKsexFkB7TTg2bpNzg==
X-Received: by 2002:a17:902:ee4c:b0:1d7:3adf:b103 with SMTP id 12-20020a170902ee4c00b001d73adfb103mr980734plo.114.1706274152811;
        Fri, 26 Jan 2024 05:02:32 -0800 (PST)
Received: from ubuntu-haifeng.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id s22-20020a635256000000b005ca0ae17983sm1020098pgl.8.2024.01.26.05.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 05:02:32 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	james.morse@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH] x86/resctrl: Add tracepoint for llc_occupancy tracking
Date: Fri, 26 Jan 2024 13:02:13 +0000
Message-Id: <20240126130213.159339-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If llc_occupany is enabled, the rmid may not be freed immediately unless
its llc_occupany is less than the resctrl_rmid_realloc_threshold.

In our production environment, those unused rmids get stuck in the limbo
list forever because their llc_occupancy are larger than the threshold.
After turning it up, we can successfully free unused rmids and create
new monitor groups. In order to acquire the llc_occupancy of rmids in
each rdt domain, we use perf tool to track and filter the log manually.

It's not efficient enough. Therefore, we can add a new tracepoint that
shows the llc_occupancy of busy rmids when scanning the limbo list. It
can help us to adjust the resctrl_rmid_realloc_threshold to a reasonable
value.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
 arch/x86/kernel/cpu/resctrl/Makefile        |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c       |  5 ++++
 arch/x86/kernel/cpu/resctrl/monitor_event.h | 30 +++++++++++++++++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/resctrl/monitor_event.h

diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 4a06c37b9cf1..0d3031850d26 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
 obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+CFLAGS_monitor.o = -I$(src)
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..a6f94fcae174 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -24,6 +24,10 @@
 
 #include "internal.h"
 
+#define CREATE_TRACE_POINTS
+#include "monitor_event.h"
+#undef CREATE_TRACE_POINTS
+
 struct rmid_entry {
 	u32				rmid;
 	int				busy;
@@ -302,6 +306,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			}
 		}
 		crmid = nrmid + 1;
+		trace_rmid_llc_occupancy(nrmid, d->id, val);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor_event.h b/arch/x86/kernel/cpu/resctrl/monitor_event.h
new file mode 100644
index 000000000000..91265a2dd2c9
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/monitor_event.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_TRACE_MONITOR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MONITOR_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(rmid_llc_occupancy,
+	    TP_PROTO(u32 rmid, int id, u64 occupancy),
+	    TP_ARGS(rmid, id, occupancy),
+	    TP_STRUCT__entry(__field(u32, rmid)
+			     __field(int, id)
+			     __field(u64, occupancy)),
+	    TP_fast_assign(__entry->rmid = rmid;
+			   __entry->id = id;
+			   __entry->occupancy = occupancy;),
+	    TP_printk("rmid=%u domain=%d occupancy=%llu",
+		      __entry->rmid, __entry->id, __entry->occupancy)
+	   );
+
+#endif /* _TRACE_MONITOR_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE monitor_event
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.25.1


