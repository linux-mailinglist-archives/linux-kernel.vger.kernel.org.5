Return-Path: <linux-kernel+bounces-135139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FFA89BB8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530B21F22C71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5FB45951;
	Mon,  8 Apr 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="MQmMR9nS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F9481AE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568249; cv=none; b=oMuIylU6xmbIXKGh/WaT40Gx+UL0cwNkM4fu0TgGECotDkVD39dnEka1f/hkQlAEM/cFwTICbilHz7KUWsULWqdwLLurez0MyJasIFR9Lds/5aHpJBnF6aws3npjLH3uiy1KEf/kH5CT56S6Tu5HM7bKE6TFqnN9Ab6oy5Ss/Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568249; c=relaxed/simple;
	bh=lvSCRNzDMjtm1a4BWcR4oxxB8t+kIagLBh943bKziic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbIPu9+onC8aikCm7+znUV7g8eEjj0dpB81u9RBEdbtVe5BC5VB8KKq237cFwSWfE81PgJwMKWxc3I7yBSkxj62rSiyq8W7/MVXOBa0VRdjSsHyarB5uQJB0nIgSMdjxYo7pUUYuHu7l2Fc5/37PvDewtU1saN+pW4hEJ52VG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=MQmMR9nS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so3415937b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712568247; x=1713173047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud/4dKvVTvJxkMnpuu6C/rtBFl2GqA46+ZTkzkTshV0=;
        b=MQmMR9nSHou9oWHp1t5KyjYZoqURsRx5fYpl8UMJO9APEhO/bdUsbYVX90J6HqmRHo
         P5d7zR8T2Zk0c/dzscG9B+MoRxufRcQA1uFG4XlaOfipqBLXVKfcCqCaXPwtGzHLq2hR
         JsXe0732VERocKxlZhewHScu36wiQJKYVLZf1z6Ff5wUXMFdg3HuvWiNJWPhFWpmPWrO
         BValxPcnVB9GRnoDx5XEJfAaW8dw3lxbLrqHFvZhsWkbOZ0j2tO2n/hTKQvxqxvYVNCv
         IZDYDi2nrdCLesYBTZjmjNXD85yUMdTwd9UZM2hU6FtvjWzZuz95/8cbH7yAwfClxib2
         43iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712568247; x=1713173047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud/4dKvVTvJxkMnpuu6C/rtBFl2GqA46+ZTkzkTshV0=;
        b=m9XN6t8qAdll8q/WLxYwjcbSY1aLn8EBxc06jYomd9ZLHQotJJhjSFUxIWJABKBF+D
         8FQXWAuATKltSHT113XOIVG60UDR/fYrKhKCdb9I+Wi+OvAKEkxlMArDOe/BOIK1rtbV
         bBGuhX18P/AXauRMOzkrYzm8PfL4lq9aASiOkmKoE47JT7raiyov6Z7FKt0fNARfRjYp
         0Fz1OyGtuo76Wy83EM/TBf/MUwWMRHFJXleAQ5Q0hNfjD1MUq8I5nnYqbS3n7filU48W
         QyXqHNAtlaK7cvGZLZoFzndxyh5mOG9FMPS20j6k3Y9uh2tQUIyWmQtyiTTukDYUesVj
         cpxA==
X-Forwarded-Encrypted: i=1; AJvYcCWbvFrruM+AYfOvCVE4lyMfkAPsOFLSfp+cOpInE/7NADxRIhmHZpUqaeY53yz2cjncHYJpSN//xwjDNeAOlwtySmG/H+NiIDVXOO6M
X-Gm-Message-State: AOJu0YwDatbDLunPg0zR9jPRBtp5tARghRuF8jcY5dCF1oIzaiBF7Rv/
	2ja868SXiOx+Dfa/8vrxI1GC9wuluOC+1WZEXHjooZjELtukQe/RuuVhwUJKTzo=
X-Google-Smtp-Source: AGHT+IEM2TciEBN2m76ipXlkAr/04+I+9N6HIsbXGDoM9e0kNVqEpjRu2OGdK6iQNZh2PZjBJltiZA==
X-Received: by 2002:a05:6a20:6a12:b0:1a7:47ff:5f3e with SMTP id p18-20020a056a206a1200b001a747ff5f3emr7769202pzk.9.1712568247183;
        Mon, 08 Apr 2024 02:24:07 -0700 (PDT)
Received: from seacloud.vm ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b001e293b16d8dsm3258731ple.1.2024.04.08.02.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 02:24:06 -0700 (PDT)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	bp@alien8.de,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v7 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Date: Mon,  8 Apr 2024 17:23:02 +0800
Message-Id: <20240408092303.26413-2-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240408092303.26413-1-haifeng.xu@shopee.com>
References: <20240408092303.26413-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now only pseudo-locking part uses tracepoints to do event tracking, but
other parts of resctrl may need new tracepoints. It is unnecessary to
create separate header files and define CREATE_TRACE_POINTS in different
c files which fragments the resctrl tracing.

Therefore, give the resctrl tracepoint header file a generic name to
support its use for tracepoints that are not specific to pseudo-locking.

No functional change.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                 | 2 +-
 .../kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h}   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (86%)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e25141..492c8e28c4ce 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -31,7 +31,7 @@
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
-#include "pseudo_lock_event.h"
+#include "trace.h"
 
 /*
  * The bits needed to disable hardware prefetching varies based on the
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/trace.h
similarity index 86%
rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/trace.h
index 428ebbd4270b..495fb90c8572 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -2,8 +2,8 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM resctrl
 
-#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_PSEUDO_LOCK_H
+#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RESCTRL_H
 
 #include <linux/tracepoint.h>
 
@@ -35,9 +35,9 @@ TRACE_EVENT(pseudo_lock_l3,
 	    TP_printk("hits=%llu miss=%llu",
 		      __entry->l3_hits, __entry->l3_miss));
 
-#endif /* _TRACE_PSEUDO_LOCK_H */
+#endif /* _TRACE_RESCTRL_H */
 
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE pseudo_lock_event
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
-- 
2.25.1


