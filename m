Return-Path: <linux-kernel+bounces-90496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECC870017
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA0AB22DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D3B39FDB;
	Mon,  4 Mar 2024 11:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="icR5Z+87"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7139FC4;
	Mon,  4 Mar 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550939; cv=none; b=l5z0ukPl7MJOCxbE/SDtDZZHV5sEfRhOmHWHikwSxR6KUjpdZpYemXfasII5AfZRrX02iW03cfj/bDRjtVCmpSTRhKOmGf2BDYghrLYUZ6J3jBCgM1slNzNj8PYdRZu0kHMDIiRMZMok82/pBMhbF7jG+ZmwTjeImP3WQX9OxLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550939; c=relaxed/simple;
	bh=e3sh3aDosYeA1iHG1drBRdjdLStEy/OjONJWhWLF3Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJQxH9fFAbvnwSoWgwpVbOBdyeYZAPZK4Qk/pkjx1UatYXPZZi5SKOLD1z2Kb9NbS2V1drozNupuEf9Tdke3cU0EzzOIKT5y3/aLQD++1AU4Jzg6ljov6nkbmVBlQDQNjmGpFmCOOLD/qCyRJV9excXO9yUSI0Mqa/DXsD6Z3hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=icR5Z+87; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709550929; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5x6wjIws3NlUgT6bvmSAzJDarpxw7P8YG0B+1I4jW60=;
	b=icR5Z+873M19s6GWyKICbcOYucUq3tOpn9M7wk8nfKGioF+0WIkqxCl6mvJI7XwBX0SUTaVo4tOt9VA/V/t0xxcLOG6LKEvdTnXvWB0s9rT4jXcQIONeV0a2Ca2hdY1RsTcnLvfFtnEkQ/ymrUUUmJFimMZ5D7Lw0EL0JM3Oc3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1oM1eo_1709550927;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W1oM1eo_1709550927)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 19:15:29 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Tyler Baicar <baicar@os.amperecomputing.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH 2/2] trace, ras: add ARM RAS extension trace event
Date: Mon,  4 Mar 2024 19:15:17 +0800
Message-Id: <20240304111517.33001-3-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
References: <20240304111517.33001-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tyler Baicar <baicar@os.amperecomputing.com>

Add a trace event for hardware errors reported by the ARMv8
RAS extension registers.

Signed-off-by: Tyler Baicar <baicar@os.amperecomputing.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/acpi/arm64/aest.c |  5 ++++
 include/ras/ras_event.h   | 55 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/acpi/arm64/aest.c b/drivers/acpi/arm64/aest.c
index be0883316449..75b829dc85eb 100644
--- a/drivers/acpi/arm64/aest.c
+++ b/drivers/acpi/arm64/aest.c
@@ -15,6 +15,8 @@
 #include <acpi/actbl.h>
 #include <asm/ras.h>
 
+#include <ras/ras_event.h>
+
 #undef pr_fmt
 #define pr_fmt(fmt) "ACPI AEST: " fmt
 
@@ -153,6 +155,9 @@ static void aest_print(struct aest_node_llist *lnode)
 		pr_err("%s  ERR%uMISC2: 0x%llx\n", pfx_seq, index, regs->err_misc[2]);
 		pr_err("%s  ERR%uMISC3: 0x%llx\n", pfx_seq, index, regs->err_misc[3]);
 	}
+
+	trace_arm_ras_ext_event(lnode->type, lnode->id0, lnode->id1, index,
+					&lnode->regs);
 }
 
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index cbd3ddd7c33d..6003cab65ae4 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -338,6 +338,61 @@ TRACE_EVENT(aer_event,
 			"Not available")
 );
 
+/*
+ * ARM RAS Extension Events Report
+ *
+ * This event is generated when an error reported by the ARM RAS extension
+ * hardware is detected.
+ */
+
+#ifdef CONFIG_ARM64_RAS_EXTN
+#include <asm/ras.h>
+TRACE_EVENT(arm_ras_ext_event,
+
+	TP_PROTO(u8 type, u32 id0, u32 id1, u32 index, struct ras_ext_regs *regs),
+
+	TP_ARGS(type, id0, id1, index, regs),
+
+	TP_STRUCT__entry(
+		__field(u8,  type)
+		__field(u32, id0)
+		__field(u32, id1)
+		__field(u32, index)
+		__field(u64, err_fr)
+		__field(u64, err_ctlr)
+		__field(u64, err_status)
+		__field(u64, err_addr)
+		__field(u64, err_misc0)
+		__field(u64, err_misc1)
+		__field(u64, err_misc2)
+		__field(u64, err_misc3)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->id0 = id0;
+		__entry->id1 = id1;
+		__entry->index = index;
+		__entry->err_fr = regs->err_fr;
+		__entry->err_ctlr = regs->err_ctlr;
+		__entry->err_status = regs->err_status;
+		__entry->err_addr = regs->err_addr;
+		__entry->err_misc0 = regs->err_misc[0];
+		__entry->err_misc1 = regs->err_misc[1];
+		__entry->err_misc2 = regs->err_misc[2];
+		__entry->err_misc3 = regs->err_misc[3];
+	),
+
+	TP_printk("type: %d; id0: %d; id1: %d; index: %d; ERR_FR: %llx; ERR_CTLR: %llx; "
+		  "ERR_STATUS: %llx; ERR_ADDR: %llx; ERR_MISC0: %llx; ERR_MISC1: %llx; "
+		  "ERR_MISC2: %llx; ERR_MISC3: %llx",
+		  __entry->type, __entry->id0, __entry->id1, __entry->index, __entry->err_fr,
+		  __entry->err_ctlr, __entry->err_status, __entry->err_addr,
+		  __entry->err_misc0, __entry->err_misc1, __entry->err_misc2,
+		  __entry->err_misc3)
+);
+#endif
+
 /*
  * memory-failure recovery action result event
  *
-- 
2.33.1


