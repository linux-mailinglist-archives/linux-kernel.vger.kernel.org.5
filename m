Return-Path: <linux-kernel+bounces-74391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D785D359
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EC91C2088A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B243D97F;
	Wed, 21 Feb 2024 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="HhxJb+vT"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DDF3D57C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507285; cv=none; b=D9BukGxlY7+DgHsqVsJDxznN9CGyiExnCWCEsloJFUKtI7NYh1/Ztc1Ya4w4nsdMxVKIIFxtOOn63a8ald14+AjLpsTEJRmJRRgVJA8uStR52Q1l0puDGbN4rXVsesjbKnpqCTHqiEcJZgiGWnTT/96IWcIXuOgoFYg3Gab9Gzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507285; c=relaxed/simple;
	bh=VQVoynihUNEqC9r/aF3NGmo8XLBshhI/46fFNwRwyXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Le0PKGBgn8SHwqBSVGK9s8y4R4sYDk1uL3RiFhg8oFw6bk90s0PmlC5X7SFiNpDs0QnwAC3BQf/qrcqqNxfGkf1LvcUP4eISUFrtO02u9x6IYysrFb/G3qmxRI1NX2QQaqELPA9XvWn8B4TgCtS7tv9AkN8SN/hJaD2/kt7PT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=HhxJb+vT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-299c11b250fso1753538a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1708507282; x=1709112082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwEx9D6igCSX4sGVX9ELHEDN97/zM/LJ3/CzONsYs0o=;
        b=HhxJb+vTA+ImmmKFynJ//bTxzn5juzTc4MxVfICx2JN4bVS0GIkprP7zwsx9qd4x8e
         U/g9BtxOPFXmgJCi5lC+egPjriAkFFiMQLhhU07h4LJuvG1zP9IYefpQp5l5OICeom9j
         mMT7sZYcjjD8/LhWn+SgoxNGTns8beTsHnBUenfkbzqKCVtnFH3WtwkN2iXi7S+7VAej
         0d6mFrEGddY0n9pMAe9oRvrdh8dxYtI81V7c0vGHB8EPhDCCPzcTzsGc5b2FOmhshN/K
         PZcS5e+TbjT/inxxms9nsSx3dS38ZZa6FVNbLIkzFsnluueaJ8ifVwcL8RiCfqYopyrl
         EeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507282; x=1709112082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwEx9D6igCSX4sGVX9ELHEDN97/zM/LJ3/CzONsYs0o=;
        b=ATVfL5PsDkbGCJopCRKbaI5lp76AIUhtpgBZKhyyDhCVxpdDbDeGKUazkhfIYEoFLv
         BDfC7RCVcML9B/SPjtrWQDE9i/o3m5za6dg6mP1rCFr6qCc9ymxMd2V0U7KK99Xmlg0s
         yjmEP0Zg8/UNDCz2wszyb0HzaxjtAkl4vPJaXsvJw7uJbDrB5kzbP7atOG9JEsWUPnQ+
         Qkdli03NdUtqfa0cfsjzJK4ggI89tWNR7lp17WX6ddiOB9ECfTpXPyOx5rRmUaUfuHhU
         PtQMK9/pborpyvPV6d1wVW6Y0OJ6AXL0LEHDQidk5g+noGmiBBLt1c1gqvK9CHrJtviz
         d3xg==
X-Forwarded-Encrypted: i=1; AJvYcCXU9kgewuPdiTRF8mgZMZWh3xbjhCywlsI79jvIYIpBUspSboYvOUOKfSSD1tWNmb+M8MCM6Pd4mR3v340MLpSL9aOCOEcc150BI2b8
X-Gm-Message-State: AOJu0Yz1dInJ/iOFik1xzA+mnGBfoZiDhOM0wn5kh6zB+K0i8VgZ2HN9
	Vn4ZTAn76VrAy4hdr1Wv3zBBMBUCWbzfJchzDJ6Oad3av1t8vtMRdGy/wdS78W4=
X-Google-Smtp-Source: AGHT+IESlS6hjNr7/HWJxudGxHsT6OSPmfCM5y8SLFloym7msY40sXuHxfGZwCmniJk97ypwNFiK0Q==
X-Received: by 2002:a17:90a:d48d:b0:299:2214:5398 with SMTP id s13-20020a17090ad48d00b0029922145398mr13731626pju.13.1708507282711;
        Wed, 21 Feb 2024 01:21:22 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002995babd9b0sm8461290pjt.10.2024.02.21.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:21:22 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 2/2] x86/resctrl: Add tracepoint for llc_occupancy tracking
Date: Wed, 21 Feb 2024 09:21:01 +0000
Message-Id: <20240221092101.90740-3-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221092101.90740-1-haifeng.xu@shopee.com>
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
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

In order to know how much the threshold should be, the following steps can
be taken to acquire the llc_occupancy of RMIDs in each rdt domain:

1) perf probe -a '__rmid_read eventid rmid'
   perf probe -a '__rmid_read%return $retval'
2) perf record -e probe:__rmid_read -e probe:__rmid_read__return -aR sleep 10
3) perf script > __rmid_read.txt
4) cat __rmid_read.txt | grep "eventid=0x1 " -A 1 | grep "kworker" > llc_occupnacy.txt

Instead of using perf tool to track llc_occupancy and filter the log manually,
it is more convenient for users to use tracepoint to do this work. So add a new
tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
list.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c |  2 ++
 arch/x86/kernel/cpu/resctrl/trace.h   | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..1533b1932b49 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -23,6 +23,7 @@
 #include <asm/resctrl.h>
 
 #include "internal.h"
+#include "trace.h"
 
 struct rmid_entry {
 	u32				rmid;
@@ -302,6 +303,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 			}
 		}
 		crmid = nrmid + 1;
+		trace_mon_llc_occupancy_limbo(nrmid, d->id, val);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/trace.h b/arch/x86/kernel/cpu/resctrl/trace.h
index 495fb90c8572..4bf95b7b4db8 100644
--- a/arch/x86/kernel/cpu/resctrl/trace.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -35,6 +35,19 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 mon_hw_id, int id, u64 occupancy),
+	    TP_ARGS(mon_hw_id, id, occupancy),
+	    TP_STRUCT__entry(__field(u32, mon_hw_id)
+			     __field(int, id)
+			     __field(u64, occupancy)),
+	    TP_fast_assign(__entry->mon_hw_id = mon_hw_id;
+			   __entry->id = id;
+			   __entry->occupancy = occupancy;),
+	    TP_printk("mon_hw_id=%u domain=%d llc_occupancy=%llu",
+		      __entry->mon_hw_id, __entry->id, __entry->occupancy)
+	   );
+
 #endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.25.1


