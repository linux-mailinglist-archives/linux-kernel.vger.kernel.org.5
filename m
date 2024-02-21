Return-Path: <linux-kernel+bounces-74390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA6385D358
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F7CB212F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECF3D56F;
	Wed, 21 Feb 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ZJNEdJ+Z"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C46B3D552
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507281; cv=none; b=HMxDbHxKbU/o3kN2+e5WzZr2jgsCv6SWv9tAirgAsAISbLxim330E1lRlQHWBN8Y+xWwLyq1GzAwtxGKgBf3F5e98zMQDuFQevJ8sp32P+l+HtggkIkWwClyp9B0BvIAC45xt6pN+8eIAmp2puJTYAsGAhSC2th3M/yA+xQjVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507281; c=relaxed/simple;
	bh=XHF39z07VXmChXD7WwSbh0F2Lcy03KFOlyCamZ/p3Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnIRnqiIevNHsakGKRXBRRouJpnenXK9qFzZudxdijijSH7wYNwmr0vpPGZGkSza58bItUAAyKgUUruDa9oUr/kC/WJ1M8UrHmr2nokjMMIK12zwTwZ7pJcr15eMAcimlaUhKMcy0SVHa8AaBh1z+d2QZWwGaXJhJ8i5iJnGPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ZJNEdJ+Z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dbb47852cdso2852935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1708507279; x=1709112079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CjEzdhpZHdcVGRJEfgybjakx/XonNKkgn7ygZfYQWg=;
        b=ZJNEdJ+ZqLlwBlX3mivFaho86B38TGAueRckoUHh2iUUQdGj4/DIKyX0MueFsds1A2
         SkbpeVGGM+zvSXofL+Kv2kBhDzcNsRoWYP3bbW4LS415fZIpWzNgT0GzPWU42GYAulTs
         Bdq6NGBTVdxjSPVSa9m0HCtSYZvqYO7uPighqyUmCJVGON8Fs7dWUGfzaxKrRiocXOhv
         oTnaQWJ4MvCH0FuCf/1/8Y8sy+8TMcotLIioc/BubMdCMOD4zse1eHuvShzK0DuCKCod
         mjZV90+H4pJTmZHqEcADB1XqP0s9seBFVGiDvC89UnI2nuYHVObxtGzXHn7MKIIB8g4S
         cesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507279; x=1709112079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CjEzdhpZHdcVGRJEfgybjakx/XonNKkgn7ygZfYQWg=;
        b=mkC0SxPLiJ8Yt3Wgz8KKkhXvKC2ns2pA8yTBo46B8cIIEOIuL5ku/sycYFF9K4NkkG
         9casCVbv1WnWtPhCPg3uUtLNFGRbsjr81boInR7v9Dvp9s03tQEduIW4TYXg/brTPCaU
         vvEAkXk9S1b9ttPk2kycqz22uj6u3LGwfnwIn+/ngLOXjKmd954wrF3WQj3LDC/O+rqg
         p2LsatfsL/PUR8OlkAozufmvVXhA/5bP6qyCs9LItPaGnS+ZSpE13x37jE1FxoDVft53
         F9KYKhob67wmWBy9mVjbVkpiHtUT6nZmAmW5ly1+yRqamnqZ75b+IqHKxADDNp9lD2EV
         BedA==
X-Forwarded-Encrypted: i=1; AJvYcCXI3BUhf48uAyluMqHx6eb6sQDE8ZSq9OWcMPdwUs4NvztN3Zi7cIVuyM9gJrQinfADZ0iFSd2tntv6+0kVRGhzIWOOFvTFbzNqGjGb
X-Gm-Message-State: AOJu0YwOK97DfmI0Z3Ek7Rxrkg5aODmK58FlH8IrUX3q43MbijAoMuuW
	9KYnty0lDUFxfFhrfIkTFzbVBgB7QqIb4j0/vRvsROg/c2Zl9mIUA5OJjulpLag=
X-Google-Smtp-Source: AGHT+IHvXOLOYWolRt1qnSbm1LYrpdNjDPHXE+p0MHweG8Qm+l7EECb/N8TA0x0hwfa3ALMArhhGlQ==
X-Received: by 2002:a17:90a:128d:b0:299:1f93:237d with SMTP id g13-20020a17090a128d00b002991f93237dmr12996848pja.4.1708507279512;
        Wed, 21 Feb 2024 01:21:19 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b002995babd9b0sm8461290pjt.10.2024.02.21.01.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:21:19 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Date: Wed, 21 Feb 2024 09:21:00 +0000
Message-Id: <20240221092101.90740-2-haifeng.xu@shopee.com>
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

Now only pseudo-lock part uses tracepoints to do event tracking, but
other parts of resctrl may need new tracepoints. It is unnecessary to
create separate header files and define CREATE_TRACE_POINTS in different
c files which fragments the resctrl tracing.

Therefore, the new tracepoints should be placed in the same header file,
and the header file needs a more generic name.

No functional change.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                 | 2 +-
 .../kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h}   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (86%)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 8f559eeae08e..e7bcf8287312 100644
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


