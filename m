Return-Path: <linux-kernel+bounces-125686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF4A892AAC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00244B21B81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C32BAF6;
	Sat, 30 Mar 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHC+QdJd"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50C17745
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797210; cv=none; b=bYvvjkwdPX4SQ5Wu70fGGTfejSNRuGwEh5kVS2rKQ5vdL3Ev8cazhOJFOKvDeDIVzM66QcRrJ5G+bpnIx2ovUwPt6QfApMrOeJss+86MTXja4k5rEaSKBEMmbtQt8TtRsDkGvx9e86lw9mop65a0LvflGt01nkV90oCKitCU/v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797210; c=relaxed/simple;
	bh=ueQEYRowh1BG76XkysAtD6hzJ57Be1g4QyrGkEtHUFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIxJaylN6GvV45iVxq0HQN77JU+viJTaCy6vH9ZI5o0rwC0TA43gR7sMYaZGSjG24nYNZ38Kcl1zF1iKOiZYB3YbfbjoHKXFywNJ6r221218BR0+QdRlUkxPDe3k8hzyIYzyrcdOHPoKBwV0i7ZQjSBI43biOijSelBaEhzCKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHC+QdJd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4155bdc0bc5so722335e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797206; x=1712402006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGpbD78cy/B/Wyutkg4e7jIuut8zfsGFclJfJk2FLE0=;
        b=eHC+QdJdAWhT9JBj+jZ2RYhdaAgwBuSWa4VTE/fuLfHnBR/IrNf1qpNIn44ThHJ1SP
         LlPJdpkvtEQ/Agy8F6x1LI9d1BP/1WDgrE2AUuDveoaMmfzRpaOqNY5jQ5T3lg2H77ZY
         lQPRYdj9e+f41ggucXqCXLwM3icY5UmGH04bn3354wwUeV/ezCvEF2+aj6sE4cRWf0wv
         zOc/rfLC6Nr1HPhJxg373Eim1LAEhSsnOM08yi1aXkiZj2CBwon+Mu6xgfjyCH2fXfMt
         +pM2gjlojFrs2D5LD79/WTA22JTZLlWlmzod6pKEno0CJXC8HzUka6ToxHYmzpS6c/Pa
         Bzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797206; x=1712402006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGpbD78cy/B/Wyutkg4e7jIuut8zfsGFclJfJk2FLE0=;
        b=qpkdJunDBNqKeCuexdYIBlF43HaD4asx/VBt0lS3CvQkUBw2bZvBPngEVF9qOTFLp6
         ff7Fk5KH3+BsDNt2kvYSHTBWzL4fnaoUrayfd7vCwT1GoVxl7Pam9yA5ROE4KfwFg8Fc
         3iiqKxFLoTIEKNK61dcnKj0mxgXkwKLyVqG4/+yW3L4otJbAUJt9DcKV91uimcgsxa+7
         XM7qyqCaV10s9iuvGEUyYL4kA5Zqn54Hd21rJzRmzwXArDrpqRdey8euN2KgNo4JLHj5
         M7+23lWTj0V1LBimCPCQr4ixCKkJQf4aFHIqdIC0xzgqfZCWbeewP4CSrd8jG3D5jYZz
         rmYw==
X-Gm-Message-State: AOJu0YyTLV8auJs5he26wgniQZ12I5vFuf2JtdZ1EO0d5sari1CjUgIg
	0ToWDX/5YLJsXdI17A0/SH44X65djb3sEQhYE/CZzbaOTwoeBYzL9EW4MHa8h/w=
X-Google-Smtp-Source: AGHT+IGmDWnORx0RBtHiMxbOf2bpkh7ue7o9cHmK67DxnOZd8Su14ZYemdeLPqvUgOXN0iVund05vg==
X-Received: by 2002:a05:600c:b55:b0:414:73c7:a8d8 with SMTP id k21-20020a05600c0b5500b0041473c7a8d8mr3340049wmr.24.1711797205724;
        Sat, 30 Mar 2024 04:13:25 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b0041409cabb39sm11280288wms.18.2024.03.30.04.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:13:24 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2] riscv: Remove unused asm/signal.h file
Date: Sat, 30 Mar 2024 11:13:05 +0000
Message-ID: <20240330111308.2053965-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When riscv moved to common entry the definition and usage of
do_work_pending was removed.  This unused header file remains.

Remove the header file as it is not used.

I have tested compiling the kernel with this patch applied and saw no
issues.  Noticed when auditing how different ports handle signals
related to saving FPU state.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
Resending with reviewed-by.

 arch/riscv/include/asm/signal.h | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 arch/riscv/include/asm/signal.h

diff --git a/arch/riscv/include/asm/signal.h b/arch/riscv/include/asm/signal.h
deleted file mode 100644
index 956ae0a01bad..000000000000
--- a/arch/riscv/include/asm/signal.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef __ASM_SIGNAL_H
-#define __ASM_SIGNAL_H
-
-#include <uapi/asm/signal.h>
-#include <uapi/asm/ptrace.h>
-
-asmlinkage __visible
-void do_work_pending(struct pt_regs *regs, unsigned long thread_info_flags);
-
-#endif
-- 
2.44.0


