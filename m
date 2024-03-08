Return-Path: <linux-kernel+bounces-96459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB3875C73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0FC1C214C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665428E0B;
	Fri,  8 Mar 2024 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LYs2U4SY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C02D044
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865962; cv=none; b=pmFZ1Tyy6yokSsHIqD6k2LXlpNxI1qzcpmUSKqFru5ZjeJQpDzlMS6GsNhltqh8gAuCXTm00Zh4elVZOyxDUU56MTN6AdLJhDen5xl3bXDERNgPkAiJS7cgZeEGxNOVlXXAhyVO4yrNRWUGPf4y68DjZEYpRi1BZQDlowRKvfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865962; c=relaxed/simple;
	bh=mBf6wZN0cIO/N0wB3JaiYh3xHh0wn1kXf+UEavA0MRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJQR8OwncnU/fMJlsCsyn+/TKQETv9ju4VRkSqoqmllTM2VNUWGCIjRdvrJInpzavEBzAquTDhlkpamgcC3AJB97tIaUdi3wPaY2XLrb7lm+AHmF+KrpJ7KtF3B9Xkp9s2iHiXxCDoY6pFk9pI2fVAQ4RtumYWg5iuYmYYCqWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LYs2U4SY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc139ed11fso19417145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709865961; x=1710470761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ptT0otTY0d8yLPVMZk8S5EDz2pvO8mJ9CtUPG2vMjQ=;
        b=LYs2U4SYBKlmapChzsUbq6fG7abnk8Nafk/CNlgtXWApONCJAmbnxEME0BT905dSTB
         EdoHN9kA3Yj7txygENvK6QruG7psv0bI9EmjOrmDuXw2q0RvPh7qP6By/ee0GNlaTbKV
         trFe/pKo78D7ZuVEm65X0fszYZPvz/OsWZsNFgqJe/worq66JCixVeWOfkyfDvFZL+T+
         6CE/NQtoqMLy1jHqQ9ocMaufx2Q0Ecb7uHfI364S004KGWYCLs3eEllt71RDGVmK9bW1
         dySNohvcxEOomTYhcgmXv/6H/M4iq8NONmHiJjz66nDW1ODLM4DMhFKyKSwlnrj0upwP
         MeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865961; x=1710470761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ptT0otTY0d8yLPVMZk8S5EDz2pvO8mJ9CtUPG2vMjQ=;
        b=oho+W59ZSKJWCyDnToXmaKOPpdtLZG1sG+aLIIm5+5Xvd+sxNPpiEfxAcF0Yk6/UcX
         EAFUBJHt0h5pgXkuVWOdeIg4v9Vh2scIzlxu78TLELphIncpM4HOXWNP38XOOY4MUOwb
         xgHG790ZlWEdpNMBR3SEThGMpTLbF4XIoYdKkZbKBhGUVdt9ptq33WXKkc9hYyfiQY43
         8lArL7gi+qBEg85gqiEWgCeVZElEMdkwUnCLvXrrgrpCBMPIoSwTzjMhoq8ZoalK4Vba
         B/NFHiimTsrFtpGrNyTFzpb8ktPHyUYaI8z+gkaiVy5Wi5lqs5weEi7Yq1IBqUcPtqch
         iiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG+TSkRjNZn4KT1n0Fz8D5rr6IJQCBKtiMIO93PsoJsFGBO5Vq7g+tFgi4bPqV2F9uENQ58dQeDWMVsSR+fT/WQdNVQ9Zc5/FzPESn
X-Gm-Message-State: AOJu0Yx626x+JLkoYGWxwcYC0OKeFjgs220Y+YTOsLFhhTRpS2oZ79xi
	9L2RpWcDnFAYAlo+l8oiit9HviZKQfKKkCT1IVNC0j8c7Ze8JTmKqo4XaSChgMA=
X-Google-Smtp-Source: AGHT+IH98yvTHUjCSYM6deOHYjr5XTXnTEoRju38ZkDPxmkx6JLywzxp0Fs1hzEgGHkFkNdTX5WqMA==
X-Received: by 2002:a17:903:2307:b0:1db:b96f:4a50 with SMTP id d7-20020a170903230700b001dbb96f4a50mr5119705plh.14.1709865960807;
        Thu, 07 Mar 2024 18:46:00 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([2001:c10:ff04:0:1000:0:1:4])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902b10900b001d8a93fa5b1sm15244360plr.131.2024.03.07.18.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 18:46:00 -0800 (PST)
From: Rui Qi <qirui.001@bytedance.com>
To: bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de,
	hpa@zytor.com,
	jpoimboe@redhat.com,
	peterz@infradead.org,
	mbenes@suse.cz,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alexandre.chartre@oracle.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	yuanzhu@bytedance.com,
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH v3 3/3] x86/speculation: Support intra-function call validation
Date: Fri,  8 Mar 2024 10:45:18 +0800
Message-Id: <20240308024518.19294-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240308024518.19294-1-qirui.001@bytedance.com>
References: <20240308024518.19294-1-qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER
 to work with objtool") does not support intra-function call
 stack validation, which causes kernel live patching to fail.
This commit adds support for this, and after testing, the kernel
 live patching feature is restored to normal.

Fixes: 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool")
Cc: <stable@vger.kernel.org> # v5.4.250+
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/x86/include/asm/nospec-branch.h | 7 +++++++
 arch/x86/include/asm/unwind_hints.h  | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c8819358a332..a88135c358c0 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -13,6 +13,8 @@
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
 
+#include <linux/frame.h>
+#include <asm/unwind_hints.h>
 /*
  * This should be used immediately before a retpoline alternative. It tells
  * objtool where the retpolines are so that it can make sense of the control
@@ -51,14 +53,18 @@
 #define __FILL_RETURN_BUFFER(reg, nr, sp)	\
 	mov	$(nr/2), reg;			\
 771:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	772f;				\
 773:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;		\
 	pause;					\
 	lfence;					\
 	jmp	773b;				\
 772:						\
+	ANNOTATE_INTRA_FUNCTION_CALL;           \
 	call	774f;				\
 775:	/* speculation trap */			\
+	UNWIND_HINT_EMPTY;                      \
 	pause;					\
 	lfence;					\
 	jmp	775b;				\
@@ -152,6 +158,7 @@
 .endm
 
 .macro ISSUE_UNBALANCED_RET_GUARD
+	ANNOTATE_INTRA_FUNCTION_CALL;
 	call .Lunbalanced_ret_guard_\@
 	int3
 .Lunbalanced_ret_guard_\@:
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 0bcdb1279361..0fd9a22b2eca 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -101,7 +101,7 @@
 	".popsection\n\t"
 
 #define UNWIND_HINT_SAVE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_SAVE, 0)
-
+#define UNWIND_HINT_EMPTY
 #define UNWIND_HINT_RESTORE UNWIND_HINT(0, 0, UNWIND_HINT_TYPE_RESTORE, 0)
 
 #endif /* __ASSEMBLY__ */
-- 
2.20.1


