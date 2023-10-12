Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFA7C77C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442713AbjJLUSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbjJLUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:18:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8ECA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b275afb6abso536715766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697141877; x=1697746677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALeoGKxiNsNupqhZSQanqEeTZk7gDRiZ8s33h27zT00=;
        b=VjQQA2i+25ld5AjYxv18h+nEEzlPthMa1EMjkm+7Kkh8436osYa2j+xkzg1+NFy8W0
         Wum2QXGXs2oF+EGm/k5OZ6nPtowqYCbumneeYaBq9+wx1CwSdAwCnQrmNP+x2IiMFcoC
         LrgYoZXka3SWlCmHe7dFTQ1eTj7hrVduJZh6ijIhwXS6P0iRAxl44ZF3O36AIh5A7Jid
         Y4oHaH9p8B/bUDPYf8OPFs/50Cgg2Z3kt21jTrtax4bDSxmDgXP0czP4SMTAMybMSsbq
         ASONUuUUY/Fe77y8yPbnrLxQk5MmqCD9pA1/MuoY2sez9Y7Z4q8z/UxqWbuoHEk8a3Q0
         sCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141877; x=1697746677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALeoGKxiNsNupqhZSQanqEeTZk7gDRiZ8s33h27zT00=;
        b=j1YQfYFg7rj6Nq1e5TD+zsynYpn9Ij4x2HJg3lFSh/45MlXX8nToyh4LJK9xqUH7vP
         eLUyGzekCetfzDZvXO76eBD2HeRGkDLWB12f5yq9TMnX4xuId8qLL4uoX9HmE2oXGkug
         0A9vkEP3+qNo65lITWqSzkYwTrX+96aDV/TLBtSv7epkyAg1QSWzxmYQZ7mqRmrxx13j
         FlIEBehUnVQXAtEXMmbs4nHxj+KY8csSllwTkyI2vlVZHeV1e+HQKvFllQnQ5QexcOyp
         cqcgLza7i3WhVEMTifqtHLEg2rOgUVLZxLNrbZgZsNCz3esosNlRx3hxpef6oahY0cni
         w8hw==
X-Gm-Message-State: AOJu0YyWbAGiNyF+SE4+Re0DBsr+zLqFYWLCKlkdVccKun/OYOZmdo6R
        PrUVKkEcdMi3FlAEv3Dle6w=
X-Google-Smtp-Source: AGHT+IGL/aK1BGpYJaP/mMy11SXb55Cywvjox0gtbzUH0yanedqIAwh6/5blT0OJLYZSBuGZJQt9Dw==
X-Received: by 2002:a17:907:9715:b0:9ae:705a:8451 with SMTP id jg21-20020a170907971500b009ae705a8451mr21130335ejc.25.1697141877018;
        Thu, 12 Oct 2023 13:17:57 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm11692552ejv.14.2023.10.12.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:17:56 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 4/4] x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR macro
Date:   Thu, 12 Oct 2023 22:12:07 +0200
Message-ID: <20231012201743.292149-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012201743.292149-1-ubizjak@gmail.com>
References: <20231012201743.292149-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce x86_64 %rip-relative addressing to PER_CPU_VAR macro.
Instruction with %rip-relative address operand is one byte shorter than
its absolute address counterpart and is also compatible with position
independent executable (-fpie) build.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 83e6a4bcea38..c53c5a7f8e78 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,19 +4,21 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
+#define __percpu_rel		(%rip)
 #else
 #define __percpu_seg		fs
+#define __percpu_rel
 #endif
 
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_SMP
 #define PER_CPU_ARG(arg)	%__percpu_seg:arg
-#define PER_CPU_VAR(var)	%__percpu_seg:var
+#define PER_CPU_VAR(var)	%__percpu_seg:(var)##__percpu_rel
 #else /* ! SMP */
 #define PER_CPU_ARG(arg)	arg
-#define PER_CPU_VAR(var)	var
-#endif	/* SMP */
+#define PER_CPU_VAR(var)	(var)##__percpu_rel
+#endif /* SMP */
 
 #ifdef CONFIG_X86_64_SMP
 #define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
-- 
2.41.0

