Return-Path: <linux-kernel+bounces-98188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3087763A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 12:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470EA1F21271
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB381EB52;
	Sun, 10 Mar 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzicIIED"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED91EB23
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710069717; cv=none; b=bU97BDQvARJHmn+fOL4Cl5fAfeGFtkW+PdHG3u8Br2+HZWbei+2tV9p4kJyA71ASaHF+ANwBQEF3ZKrjKDObu03O/ZcyoeO68epa4eVfuKG+m6NTMdrTIgGPM/WaVsDT1b8+ojpY0wCFGuwimMgCWR68brhZILrwxZfx2nrQb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710069717; c=relaxed/simple;
	bh=fJX7SNlyxXTuJOiq0rTDaoI8T9zWS4yZQ9PVya9yaD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ2ytpiAD604nQc9ze0yxM59Craj/N4JJVCkjs35xyeNDaq4/SunR5Sezbhq1BpQs8SQ0Qn7zkl0a57KuMfmkhkIYK/K1El1je580awsD4sAmqCgSU47qNnJh1IfXRYoPKrLGbG4WTLYOGGQyhaRSEsFYVjCzmc5FPgIzVyxCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzicIIED; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413287eb997so1093745e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710069714; x=1710674514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYLKnCQ+boTnvHIesYL7Tn/a9S/O0zd748SDOPYnP/0=;
        b=WzicIIEDsaKH3Shu36ulwEYVwnYGP8uUARXOeFpW1un+KZ9TLY1VtKfE3f/mTlhcDk
         szhBjd+LTO5GdcJ1/nBy9IRLpN1DUdVhGEhnx+wEbD1jBQxgGkHG0NgCBAS+yrmq7T+G
         qKVaTseG8FA6UsVqWEs89BqRpvM5aETBuWFSA33OKlikUIscILSzR48i4iUWz1v7aORi
         7zpRbMw1z+RFFJsfHQ/YeqO4d1iPV2gnRI/4A0Xe/pVJL44Q+Wxn++guZPPa8p31S+Je
         3ViQDKxjKwk8n0BSyGCLcWzzeDWxAA0F3nUo1VFMHPDMxPNkixS6s5ea6/hR4opgIl51
         9nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710069714; x=1710674514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYLKnCQ+boTnvHIesYL7Tn/a9S/O0zd748SDOPYnP/0=;
        b=v8Glz4Cx6IObxatodXgnWWgcCTqsxgjoZPosAXjzQKKbjv76wVK6sKYrufDrchyIvs
         37HqIFyfkr476AnU9lT4UU4VDv50PMt5nWoIMkSS+K29fV7YeHTMOf0OSt77gQXmUH4l
         /uMSoX7bWkuOFpMxfwFgzXtN69C96mwg6Oa+C6OjEwapJMe81w4/MT29SwpypvpWE2eK
         jJUay625/0LvrNAySUDx2pi01kS2QDMDjRz7TvmShSAMzX1fp8nOLD6WdmiOEeHnxYS9
         qwj8pr4LEEZmUWtvKh14CeIh3Dg7ExDwEuaBiOFEo+USczCQKA+MvBRJFAEcBFB47fIR
         ixXg==
X-Gm-Message-State: AOJu0Yy4X83nYDid1lYFs7V7qBRzC89ojBAX9rO/farJV5sNrlClmlpa
	eISu9bOc4AQ8fK3uuYJX2VoUaslDPWv2t5UUvkLr2Z2lLem8ktJ4C23ItCQ+5sQi/A==
X-Google-Smtp-Source: AGHT+IESTdbtcJfx38eBuDs4OoN6CRhqQNHqQYLxjQ2Qu5Q+ItfkC7K28QXNPe4PiZTsTend2glLjg==
X-Received: by 2002:adf:e98d:0:b0:33e:7029:96bf with SMTP id h13-20020adfe98d000000b0033e702996bfmr2860785wrm.58.1710069713316;
        Sun, 10 Mar 2024 04:21:53 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600012cf00b0033ce727e728sm3788144wrx.94.2024.03.10.04.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 04:21:52 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Remove unused asm/signal.h file
Date: Sun, 10 Mar 2024 11:21:26 +0000
Message-ID: <20240310112129.376134-1-shorne@gmail.com>
X-Mailer: git-send-email 2.41.0
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
---
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
2.41.0


