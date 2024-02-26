Return-Path: <linux-kernel+bounces-81096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA5686701D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805641F27F68
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5D6341F;
	Mon, 26 Feb 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XL/J4snT"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130563405
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940995; cv=none; b=mBkH/tvGddRlo/5CBlkjL1eUONrfRypERb9uODJNQ5n5yKCqDlFI8a0tXcxhwhQcN8/o51c5244/NLKhaUys6LDvNxfYlORrRvVnK0k2Bj9zJLXzMI/Fbw6zMxdW1hXRNU3RT04QCAjk3Q5neUDBcrA5aToUr0e9j2v/qIIZk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940995; c=relaxed/simple;
	bh=M/UuqL9yNB3YF1HtldRq/T2nYA0slbNy46LBdPsUNaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUH6zXeLIlZQZyJ3lPWZ7/7FE+eRq7AUR2Xr08JfDt+/BnmpjfpYsj4Y+rcMNbqW1z4ceu9aCdlMRsMCjD4IYMFOCZC+URrphFoHX/2uBhEscsYRhajHkBn4Oe2aOX/1CzKsuuOtXI1z+CFkPxFmpfngMyW3194F3l3imD0KzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XL/J4snT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2542536a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708940993; x=1709545793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoOMBp9MzLd3f62Ny862YOxP5jt6oFE+bwUjv1x9+1Q=;
        b=XL/J4snT3B/RN17t+c08z5978ntp2Z62yUxUAjk4+UC260iIs22/n0n3Bc69G81MZ5
         FZKqVdAIn1n1OuHGMxDyAratZ/QyhQG0+eiA+gbZoWeneV+Q6Fgchmebvw+3+CWL/G/R
         e68ks+B2f0t8SVtwjOSDPlsLcmzYdG80twE4uwlm336w2HRe+KCG2icDkTMBi8pDeFiK
         1D9fn4a2fl6U7b9IM6AyP+ZCt9Z+2mYEC1VjZwIVxuaZ4Y1M5roEh01/2FOHfetdSnCF
         gT3Ni96X2spWDycAlWi9C4K8HJ+VsFnb29Q16Y1y6bmKMAeKm3hYYQhAF/c8tt3QMIUx
         PFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708940993; x=1709545793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoOMBp9MzLd3f62Ny862YOxP5jt6oFE+bwUjv1x9+1Q=;
        b=pIKsULHU1UD1WJUGbW1YCWemJKKTtTyKT+nuQGWq4dGEjCXV2fNoYD0MmzCgaFF1Q0
         di7CGiSkYlcnZcEeN9s2rcD98vyWcVG05ELYJmbs7SeTVM9CNj4VfzYHE0QR/pJXo0Z7
         z7Ulw7cfx8nofUC6hp0gzDF4FZUkQP/tzmNUP/CuHva4BSgpqnNB24NCZT2onwQY3wNs
         4Y4RGJ0orDmUdysxqfx2ewX27bIaTO7TkEKDbU/sanvsoNCB/8ocySpTT5ef8jN+ueQ/
         jM/e9Ec7uOUAtlCgh0SkngNNlj8PVWBEWA5dedsq2KBRgAtGPZZOE3MUEuEwh7wJmkLZ
         9Y8g==
X-Forwarded-Encrypted: i=1; AJvYcCXZYagqj1K1B0S/HJJ6Py1gvhpUZc0Cjcn//3WMg1BLy65djDA3/ugC4p+hPIUXeiSd8qpzQFd6zAIvaj8x3ePc5l2+/MuQDNOXYadt
X-Gm-Message-State: AOJu0YwkyQfEnawehuFKOlro2hEVwGjMiD2VaHBFzwsfnfQEhY6OPUs8
	1TgL5OkVsNNzXqD3VCwIHhafeMJzZ+mvOkgIcZLvx3s6y+0Tuq6bKfOS7bkh9Ok=
X-Google-Smtp-Source: AGHT+IHul6aRLApmw3jPJIer158Sp/EzC8J+955d9ZFtw0CpgtlQEcErh5DaqgZxXHaAtY9wYMPNfA==
X-Received: by 2002:a05:6a21:2d0b:b0:1a0:e59d:1dc4 with SMTP id tw11-20020a056a212d0b00b001a0e59d1dc4mr11855842pzb.11.1708940993010;
        Mon, 26 Feb 2024 01:49:53 -0800 (PST)
Received: from C02CV19DML87.bytedance.net ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090ab01300b002990d91d31dsm5934779pjq.15.2024.02.26.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:49:52 -0800 (PST)
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
	Rui Qi <qirui.001@bytedance.com>
Subject: [PATCH 3/3] x86/speculation: Support intra-function call validation
Date: Mon, 26 Feb 2024 17:49:25 +0800
Message-Id: <20240226094925.95835-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240226094925.95835-1-qirui.001@bytedance.com>
References: <20240226094925.95835-1-qirui.001@bytedance.com>
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

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 arch/x86/include/asm/nospec-branch.h | 7 +++++++
 1 file changed, 7 insertions(+)

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
-- 
2.39.2 (Apple Git-143)


