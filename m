Return-Path: <linux-kernel+bounces-90096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E985286FA45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60749B20C4F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF612B60;
	Mon,  4 Mar 2024 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="AjeIpzkT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC0125B7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535182; cv=none; b=g89wCxREDMHRgBoNF4aw4axE90jcrnl09QCAkgXGsOyRHE0uymYgNR3nNejA3ffKSz0W3LI/OEC/nT0WzskgOHRcLqFyY8U7ktLtYmXTPQ5fTKBJc9uHoll4VAWZPYnSdViY6BwQ0UzmF0UQezUI8CuWFOV4NcrsxdehocyjDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535182; c=relaxed/simple;
	bh=Aey2x/rUGCSiWROvyFZizw1j1BOYN6tFEPW7hjLZbQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoTFk/YNyeLjCe2QI2A8TASmP/DCuOtBcrQwdbDJnkEeo8RfEeFLjkZDAKOcSdw/RhrGMYeaLT3sV3JFY60a8OX9Z95c049eK4RvUcbm3v+mFbIEdo71mxRSKICz7j2ofVZRxPiPKMQjBX4PAKEM7Sz7HAIrK+AAVjZAjq37xwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=AjeIpzkT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6de3141f041so2581390b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709535180; x=1710139980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc+akXbOIA4nrC6QlU/+zOxMss2MQbVBlurGWMYKMdo=;
        b=AjeIpzkTb2mlqnQbqzK6u/2sY+2/kotjmgwAaBhFl/eISXEOHD0FJ3txGyhHs9Nsrg
         9YmuO346/TVlf5Xe3CiiHdhe00RrRrrZRrK+9oKWmQY2dVHEN2pVkZeDdUKFN0GMy2/w
         9HuXIzlHbjtR44sSR8dp7udYz96ZY7gCV+3oyVcpzjFdeHlxeGBWD3uBZVZMiDcFPvz/
         0It0+u0N2aKydhU3tl+QDuFd05KNmZ6LVtA0bTvQoyCH5d82kpjCwLxruKqxFKHVu9DU
         KhVKcASNY3ucsADBAcdUr1Y7IuqYcw4IUH63ibk6LfqFVyBIL5c+WxnwRQodaU/t+JOc
         suuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535180; x=1710139980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc+akXbOIA4nrC6QlU/+zOxMss2MQbVBlurGWMYKMdo=;
        b=DqFFYYdQEgtxWfq0pilluwcwbwsVyrWb2ufbwqkY8ULREmktuFrqOtSOl4sJlZdceM
         FDz3RfvjzCj4B4ofGZnUGqc8wngl+Um4/MsjbvgvKjIkyVd/wgDbrW6mTXkB32SLKk0h
         comrNRP3X04cQE/O6f6aQMcChWpOjFs9qBMk2RtIeS4FDpjpFITmBQzGviTaXH+ZH7JB
         u25ZxdbpdPpcbxrw5L6Dn9d44gvnDmximpEZYpPGyTgj4JDisY3KWsoawDxHgHaTRn3B
         6kFQs3Nyj3sFpkdAbr77Xlhrst5dBiicYovwJ6LRN0TD4uA9uhYx6MkzlgXhTSLngQWY
         0Aeg==
X-Forwarded-Encrypted: i=1; AJvYcCWy/l6WLGixr4XD/L2N7dIkVHkg/dkBORTkWSXhttAYFqlBFXAY4JTey7UMHFanZ1SndUqWdjkDbc6gUgcFebvhUHRzhbP7gYKjlyDo
X-Gm-Message-State: AOJu0YwmGCh6Ot89Zi80X493C85TBlidgTlmPS1V4mHmDkqbGxKjPoR2
	c46SrokEnZCuhT2KcNOsW0Mds6swHqOmA0Sv4gAMSpA227dsMCmgWAOD7dpO/gI=
X-Google-Smtp-Source: AGHT+IHLiExh9oImBud++i4oYMjchZ/644AAxWBTcSKZ+4o7NBR6WesFQRVGwl8UjoUBs5lFmde/Dg==
X-Received: by 2002:a05:6a20:8f0c:b0:1a1:4e6b:185f with SMTP id b12-20020a056a208f0c00b001a14e6b185fmr1709400pzk.25.1709535180207;
        Sun, 03 Mar 2024 22:53:00 -0800 (PST)
Received: from seacloud.vm ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006e4766d31bcsm6554740pfv.184.2024.03.03.22.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:53:00 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v4 2/2] x86/resctrl: Add tracepoint for llc_occupancy tracking
Date: Mon,  4 Mar 2024 14:52:36 +0800
Message-Id: <20240304065236.281877-3-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304065236.281877-1-haifeng.xu@shopee.com>
References: <20240304065236.281877-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, after removing monitor groups, those unused
RMIDs get stuck in the limbo list forever because their llc_occupancy are
always larger than the threshold. But the unused RMIDs can be successfully
freed by turning up the threshold.

In order to know how much the threshold should be, perf can be used to
acquire the llc_occupancy of RMIDs in each rdt domain.

Instead of using perf tool to track llc_occupancy and filter the log
manually, it is more convenient for users to use tracepoint to do this
work. So add a new tracepoint that shows the llc_occupancy of busy RMIDs
when scanning the limbo list.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Suggested-by: James Morse <james.morse@arm.com>
---
 Documentation/arch/x86/resctrl.rst    |  8 ++++++++
 arch/x86/kernel/cpu/resctrl/monitor.c |  9 +++++++++
 arch/x86/kernel/cpu/resctrl/trace.h   | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..dd3507dc765c 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -478,6 +478,14 @@ if non-contiguous 1s value is supported. On a system with a 20-bit mask
 each bit represents 5% of the capacity of the cache. You could partition
 the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Tracepoint - mon_llc_occupancy_limbo
+------------------------------------
+This tracepoint gives you the precise occupancy values for a subset of RMID
+that are not immediately available for allocation. This can't be relied on
+to produce output every second, it may be necessary to attempt to create an
+empty monitor group to force an update. Output may only be produced if creation
+of a control or monitor group fails.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c34a35ec0f03..60b6a29a9e29 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -24,6 +24,7 @@
 #include <asm/resctrl.h>
 
 #include "internal.h"
+#include "trace.h"
 
 /**
  * struct rmid_entry - dirty tracking for all RMID.
@@ -354,6 +355,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			rmid_dirty = true;
 		} else {
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
+
+			/* x86's CLOSID and RMID are independent numbers, so the entry's
+			 * closid is a invalid CLOSID. But on arm64, the RMID value isn't
+			 * a unique number for each CLOSID. It's necessary to track both
+			 * CLOSID and RMID because there may be dependencies between each
+			 * other on some architectures.
+			 */
+			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->id, val);
 		}
 
 		if (force_free || !rmid_dirty) {
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
index ed5c66b8ab0b..b310b4985b94 100644
--- a/arch/x86/kernel/cpu/resctrl/trace.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -35,6 +35,22 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupancy_bytes),
+	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
+	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
+			     __field(u32, mon_hw_id)
+			     __field(int, domain_id)
+			     __field(u64, llc_occupancy_bytes)),
+	    TP_fast_assign(__entry->ctrl_hw_id = ctrl_hw_id;
+			   __entry->mon_hw_id = mon_hw_id;
+			   __entry->domain_id = domain_id;
+			   __entry->llc_occupancy_bytes = llc_occupancy_bytes;),
+	    TP_printk("ctrl_hw_id=%u mon_hw_id=%u domain_d=%d llc_occupancy_bytes=%llu",
+		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
+		      __entry->llc_occupancy_bytes)
+	   );
+
 #endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1


