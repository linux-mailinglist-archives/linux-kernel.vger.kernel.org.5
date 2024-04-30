Return-Path: <linux-kernel+bounces-163655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3568B6E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB531C22B72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D901BED6F;
	Tue, 30 Apr 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTDuMjfW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5541A0AF9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468733; cv=none; b=PmSFhhuRFypeaXLIL2HUDkkyjIuiqfD3rpcxEJqmBMRQA2FWyAfnBOOG4UMdbVPILnqcSL7gPWO+Y4IotorBqLg5xnqI4IdW2F20rFnnwP2/WRAhTgx9hL4zJnKOf2u8nxePuO70vxuCxYiGVBVTbJgCAfuexTjthbw+Lf8vw4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468733; c=relaxed/simple;
	bh=yzAOc6IgPr0Vk1N6O1Mc2R9ZBQ7o1IAvTNs87xxba+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtciNgoQ9vrqp2eekew4efhIZOLxGv/K2YWtKFJdoThDluKMkXzb7HY0f0871gJo9/sCbu2SIMMhVszK/pCPcUcw5fhvN5nZgFosFRMVyEuwHn5QefM4tOC/gNDFgWNeR5GrfFq5D0x7yR0YsP0DyvQ8KD8KT5ieHWfHQA6Gi8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTDuMjfW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41b4ff362a8so50040815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714468729; x=1715073529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccImkqCG6/R3elWT5YA+XOLGgQwwcOOmKHy66GQ0wX4=;
        b=gTDuMjfWYPOV5bpMADnXMKPtiCgl2JiMdTS9prhqSzIpD5hPDK7WyJG+PkeZ9YiV6l
         WSKqGRH1TzrrgSi+EV7SQ0dNunn8TQrPrCkexPtVwyh3/SqkmRLyVcrQH/u+XfeQMiZH
         pJQfLw43/9odJEuL8MFNQN8oWyConmZMJVD8WjKKCA0BQGAlv60YPwK2Bkd+hsmsVMSy
         ULRr+erqIdPPEpikPVlOpZ6TNeAHmeomKZyxi8a5xlunuRZ8o1f6oGpdF7pOxHttfIbH
         uQqdyuUeHDlqVh3bAZBoYkdCOriAMlDivvgxxZD2U9xhkOwLTlDAPG3gi+xUCPzdzUfC
         9QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468729; x=1715073529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccImkqCG6/R3elWT5YA+XOLGgQwwcOOmKHy66GQ0wX4=;
        b=gR3hmqxb4vDSSOkB7VAIQnRJ8Cc6n6c9No56SfJQnZ60X24TPxLAA5q9Rc2sWdOD5L
         NmAeOJywfRzSLkrskLmydGdUYMZQrv7LEVY6Q+0JLfYjxZmeJTTy1F3ftP2Zvo3T6rPn
         vff7h/Pc+tiqgpq7y430j/dKB0qNRKEA1CoyXnUb46tAVsRVxtmjtAWgn+Tn1MTQPFcF
         hWM80p+I8qXaVXHCXGpyE7kjZJ+GHqLYoDqRa7T0Z26avi4HD0MpUFrl+c8YW1TvtmnZ
         AyzSJjk+ARW2Z0JwgzPFL76gn4ymHi815Mtl24MMNqktFaiL6HlxU1vwwO5lAsdnoiN8
         k4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv4x9Ias6JBHuooljUNsR1WE0HCQk0Jar0SEbfydCl82ZvWEoaVvY2SJ3Nfah6RMU00QfecJydPTnE/8tPyj0rEIyHZiW/N1G9AsXr
X-Gm-Message-State: AOJu0Yxbhu8E09YPkddcxUUOwe0aJOPmCxP/Q/EVr7LJtcQUFUirRIX4
	VbxfsRteuBwQc8f63A1V/LXilzKLvSGlnBYs3eX22uHbebfnclck4JO2l7J5
X-Google-Smtp-Source: AGHT+IESvqe4Xw4PCvAX4p3gUSQFjfPpgkYlEDvh+3b6KdrHg5WD9HSeaSK/Uu31q8GQID0WTBfe7A==
X-Received: by 2002:a05:600c:3546:b0:419:a3f:f4f6 with SMTP id i6-20020a05600c354600b004190a3ff4f6mr12713041wmq.8.1714468729361;
        Tue, 30 Apr 2024 02:18:49 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c314300b0041abdaf8c6asm26324458wmo.13.2024.04.30.02.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:18:48 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH -tip 4/5] x86/percpu: Introduce __raw_cpu_read_const() macro
Date: Tue, 30 Apr 2024 11:17:23 +0200
Message-ID: <20240430091833.196482-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430091833.196482-1-ubizjak@gmail.com>
References: <20240430091833.196482-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce __raw_cpu_read_const() macro to further reduce ifdeffery
and differences between configs w/ and w/o USE_X86_SEG_SUPPORT.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index f360ac5fccde..d20255138426 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -156,6 +156,8 @@ do {									\
 	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
 } while (0)
 
+#define __raw_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
+
 #else /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define __raw_cpu_read(size, qual, _var)				\
@@ -180,6 +182,12 @@ do {									\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
+/*
+ * The generic per-cpu infrastrucutre is not suitable for
+ * reading const-qualified variables.
+ */
+#define __raw_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
 #define percpu_stable_op(size, op, _var)				\
@@ -470,16 +478,7 @@ do {									\
 #define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
 #endif
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-#define this_cpu_read_const(pcp)	__raw_cpu_read(, , pcp)
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
-
-/*
- * The generic per-cpu infrastrucutre is not suitable for
- * reading const-qualified variables.
- */
-#define this_cpu_read_const(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
 
 #define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
 #define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
-- 
2.44.0


