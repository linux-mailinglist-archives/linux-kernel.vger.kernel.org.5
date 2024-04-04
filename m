Return-Path: <linux-kernel+bounces-131200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B389845C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C7E1C27621
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C435D76049;
	Thu,  4 Apr 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHgD3Rsh"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1374BF8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223749; cv=none; b=Vhy217W0b7yHdfPJGDXFY1RUjtKVfGHUmBYwLhex2/PumbHWJKBaQeqdc4Tetq1Wtj+oPHHg4f9rN8Lss5CaAB3z6PVZQJd+o07c+D6JYnK4icYSpZRWRZy8yuN6821N9yQeB3GzdjM78vuuDXW6Tl4nWg5ZwKtB01R92bwg2xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223749; c=relaxed/simple;
	bh=nCa4wWZIE/bKjdwddAGwJ6Rddk0t05Y3HUs5ddU3FTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt0yAinOvv5wGTSMb1vcurOiV3fZhIZlL27Mzudxc2ftID4LV3HZDNiq8zQgFa1t8yl76NNg60f2XQjZ5cZ8BcFsA4hNfYQfoAhnoOX7gVAPqk+lEGtsBJsGSGXvW302jwTQaDQtiv/4PljfOxno80Q8jHr9LjnHFEHMVSO5MEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHgD3Rsh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a387ff7acso94181866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223745; x=1712828545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtiztdDG91Vgo1e9jisrgiJ3wj1csMHfbZFB6F2zutY=;
        b=QHgD3RshpT197mjdd5xZiENoaAFpB5/tVpDZcDArxq2tF4cryquBHxbnbg6gOAi7hs
         8ZPxJSlc+iKhpOcDhf6SKIDECpRD+rzm/llNSlfMBznrTxVnlD9xnXe3bihLsNNl50NT
         hVXsEd8eoRWW/qFtub+w3ql4+qaXzSvuDF7NF6XxsK+sM0/B+6GB2HBfEjThdazcGsLb
         GVvyerAnb4R6wX31DeHnDebrWlJe7uRHM+c9LjG4gVUcrC1rm6otoBXA0hFsEvP4Bs9s
         86LOnHAoMB8DtP9DF6N/nqZHbmXfEv7/aXVKpSAWVuO+YGF91XUnWsCgASf8a0yxsfHw
         0GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223745; x=1712828545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtiztdDG91Vgo1e9jisrgiJ3wj1csMHfbZFB6F2zutY=;
        b=gF9hC60RZk3SbDSOWI1WTYuV4gF0cPeB1Ma2BWsOHNx/Z0aAXYEGo+Gzfd/QLUOCan
         yjTybKjqFmOlRYDKQmQdx7W46Do3zKTMF+HIRbr0OcnMB/mtuUMzZpvALAvlninaoUSg
         enwJ/3dF3gzpdipUwgpoYP1+0PRbcg3HcgDR/kPuPdKyknw2C4BLw1D/YlX8IluhtJD/
         /YZBfJvjRrBbQB+i58XeOOHX/LbQP1lTzwz/7vn3ASSR/4Ztyr/AEHT+rYO+LdPMq3DU
         Ds85/l99gkHE3HHbZJ+9fu3DeoLTsjATahmo1/+byR6uPa9bgKIWD8C0lTKNVvcPUAgI
         3CfA==
X-Forwarded-Encrypted: i=1; AJvYcCUw5YI0DBcfv/EBd0731e7P8sRMrIiM9bAXW2lWMCwpBLVFC4AywIlI5oi+a4nEMHgHdi6ANznCmIY4lsc9cYer7yLX7NgjA2zfd1MY
X-Gm-Message-State: AOJu0Yz5pC9eJz1Z4LFDU/xt33JwQk1hiJwDJMUqL8ZIc1nSPILLNexC
	Ix+ntJTShkXQ+p8cMBg6YHUm+FOEeTkGIVljSYidRxgbaw7VvUEV
X-Google-Smtp-Source: AGHT+IGOmN8eyGFqlo/dekfIk85eSs3lY0kdXvfjHVK79pV1pXKMOl7/7ajr2e85VZnBpwxkpsrgIQ==
X-Received: by 2002:a17:906:2591:b0:a4e:2a07:5450 with SMTP id m17-20020a170906259100b00a4e2a075450mr1174202ejb.35.1712223745423;
        Thu, 04 Apr 2024 02:42:25 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709061c4100b00a5194b5b932sm62362ejg.16.2024.04.04.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:24 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 3/3] x86/percpu: Introduce raw_cpu_read_long() to reduce ifdeffery
Date: Thu,  4 Apr 2024 11:42:03 +0200
Message-ID: <20240404094218.448963-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404094218.448963-1-ubizjak@gmail.com>
References: <20240404094218.448963-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce raw_cpu_read_long() macro to slightly reduce ifdeffery
in arch/x86/include/asm/percpu.h.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
---
v2: Merge the patch with the rest of percpu series.
---
 arch/x86/include/asm/percpu.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index d6ff0db32209..3bedee1801e2 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,12 +59,6 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_X86_64
-#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
-#else
-#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
-#endif
-
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -76,7 +70,7 @@
 #ifndef BUILD_VDSO32_64
 #define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off); \
 	tcp_ptr__ += (__force unsigned long)(_ptr);		\
 	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
@@ -563,9 +557,13 @@ do {									\
 #define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_8(pcp)
 #else
 /* There is no generic 64 bit read stable operation for 32 bit targets. */
-#define this_cpu_read_stable_8(pcp)    ({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+
+#define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
 #endif
 
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
-- 
2.44.0


