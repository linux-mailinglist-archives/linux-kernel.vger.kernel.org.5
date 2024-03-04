Return-Path: <linux-kernel+bounces-90095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69086FA44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A916280F92
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9562125A5;
	Mon,  4 Mar 2024 06:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="ATPZWgAh"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A611CAE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535179; cv=none; b=d98eXMfZzZIFglga/rHY0XRRRnWTcIhsj+XD5ZMruX405cCTFlXD9U9t4RdKk+/zuJe74aoZvkFY5UG9hyEZp5e6bsxno1YUOIIfasmemEFyJggJdphm10Un0gI6oMWDGE47ldOKyUwE9RmWFme5A+OQgczg02gt0Rwcvu3gBvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535179; c=relaxed/simple;
	bh=MA0DxG8bRrDPES7N5MFpH/L+LhBYNxe9zPtGQO6dSek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/rmX/qSCaTf6zbRwPibTRbIrNlIHq33M2iB4aAwfMph+3rFe3xnILNt5iLILXSQp+C+ehKfNX769jOWnohXIAvrm/b6qUCVXowRxwzq57vPml7PpJENUZmg+hQ/XD6WIzjR+DFWBDO5PXvcfsUWJMJ3HRbzsXSKl4R3+jutFGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=ATPZWgAh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de3141f041so2581359b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709535177; x=1710139977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfomRvH8ULPC5eeUCXao/k9/srrLuDto1N2pX2K7uu0=;
        b=ATPZWgAh3Zoh1ScahENVK7XPylXN2KJ0nzdLbOKo7Tu4+Sn5FvteqW06nvepzL9eYZ
         i5sZN8IK0JBgnBpDUbaoeSEh4cCedm/uC0kEHX0Sr8xB3xQiT+VAAQ+A8GolC4WdfoZL
         cRLHEAXPGLit/nggWrsxb1QBLHCiyXEmZToeAIVcNFpw/bf58CkXTQVLJ+Sgiz930xGP
         gNvcZNY/NneSA5Bh/YGefLsMwYFc1fYpqz7zPv0gRhKAwVu8MbX26vXdfl4AFSnaur5K
         vJcT6hS3dp+tiqnDwUmoa1D462+zyUo6+zXaFT70ryGEdneD1CFWDQFY6kXxYlnRYCRm
         JVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535177; x=1710139977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfomRvH8ULPC5eeUCXao/k9/srrLuDto1N2pX2K7uu0=;
        b=Bk9L5ybyK+U5yevNcuZMQa8/pgUbewnCiZGylJ2pmvSrAzyftwCxIs+vMHulUqrryc
         ohiiyHbWI88EZOmu7T5r4CI6+Qcd7WBvKWDUPB/eOqL5jvC99MhPqMK/a+IA46Ol7bmQ
         G7Ia+gio9H14vWODD5CvglVX8XCa4/yNflMjQoFY/W3y07VILWxrKTvgE3Z2ZFH8sGNV
         ppCdSfTRGpVDtvbiu9j9ZNqOeVQcb2PSqB5/tidtxkh+dzlRusreRTAV3DpQVypg5jkX
         pZcQcVjtYSPPhXOrcuu4GakNToHxDUrkUYPyjPJWASQ+b4JYLCQyNfxxhVUYLLRhxOCC
         arqA==
X-Forwarded-Encrypted: i=1; AJvYcCUFJhA1Ebp4hrIng76GstPxiq+k+zCRvPk75iWjqIOkRihzG2Cjyv/LTvn4y1IWuXSwzQj2xxDZbRzzy3UB7I/3C6WiUejXv9XOGNNp
X-Gm-Message-State: AOJu0YzwJwRf8k8FJn1/MLuCY6yzIBZkyg42y51ZTsVdEHXL7SyaP3R2
	20h5r5yI3fsI934VubY0P7V2rwX2wTK/PEDTrdnHzuMKBm0UvVa5fXGoCLuUF9E=
X-Google-Smtp-Source: AGHT+IHq01yhFcxM+Ys+burCeKb/S2tHJ4gorNVk0H6QB7243MKMLmukDxVUF1XzQYYwFrfXJt3Fdw==
X-Received: by 2002:a05:6a00:9294:b0:6e5:56b5:606a with SMTP id jw20-20020a056a00929400b006e556b5606amr9211060pfb.11.1709535176943;
        Sun, 03 Mar 2024 22:52:56 -0800 (PST)
Received: from seacloud.vm ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id o26-20020a056a001b5a00b006e4766d31bcsm6554740pfv.184.2024.03.03.22.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:52:56 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v4 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Date: Mon,  4 Mar 2024 14:52:35 +0800
Message-Id: <20240304065236.281877-2-haifeng.xu@shopee.com>
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

Now only pseudo-locking part uses tracepoints to do event tracking, but
other parts of resctrl may need new tracepoints. It is unnecessary to
create separate header files and define CREATE_TRACE_POINTS in different
c files which fragments the resctrl tracing.

Therefore, give the resctrl tracepoint header file a generic name to
support its use for tracepoints that are not specific to pseudo-locking.

No functional change.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                   | 2 +-
 .../x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (88%)

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
similarity index 88%
rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/trace.h
index 428ebbd4270b..ed5c66b8ab0b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/trace.h
@@ -2,7 +2,7 @@
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM resctrl
 
-#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_PSEUDO_LOCK_H
 
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


