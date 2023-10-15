Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B6C7C9B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjJOUZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOUZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:25:38 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F6B7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9bda758748eso334651566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697401535; x=1698006335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrkrxsPn2IZuqVMHhvR4XZKurOwbK1OYZ2ExToejPfA=;
        b=mpB4g77PyxW3ScX1NhmCWpeCneVRrX1aEGac/yxeBPTCjHJTp5s98nTuiM1uSVXW4t
         ofVQB41HZeUg8pdHl3wAl9jRBg4xzt5nteCQmlBj5MB4Gl8BsH1M3B6yUsHCwC3uvbl4
         8bccaEjQSs4OgW6ujqwJg1kRAFlgqihNW54uXq70Kw69UbqPsufGnDgalVs2S+BgFEL5
         dhP+Gw5184rrhNJoluVXQWpbxUKXkc3RZtXS9tbXKf1xYjQLUh/H90nbzNR7fLmj2woD
         cMIiXYBdlIFAn9BjzsrUjgwzgiCscHOHHphNShp2oieG5Gpf4mR2q11HSjZtNn0svfS2
         9I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697401535; x=1698006335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrkrxsPn2IZuqVMHhvR4XZKurOwbK1OYZ2ExToejPfA=;
        b=Ip6rJGiu6TqgAgH91iwOwZ8GuzUYfVklcImo2/pJ3n8+gnwbzMxuS2qX2OwLCVpisL
         C2n0RuU+Iqkf/AunwQz3ZTOW/qXdxV0cMdHZxD+uUnRwsJKx4ekjjBsBjbEehmeXqk/p
         ppKSRdysWDaNK4mN/UtU4dyhGVsCmx9igTmz2oCujHmAoJH9kh3O09X+JrZNCHBQS+nc
         ColKT9MdsmU8dZJpMPMIMzr24jiTH35zogTgxylST+xWMhRZZlZz9GO79tqBAb0SGFmx
         2mb+TOvzAFh812357mQRoCBTKQL+TANaeXLb/BUkBt34TnBLHKqguu8giNnI56uNwIjL
         e9Fw==
X-Gm-Message-State: AOJu0YxJtygNh8t16etfEr/y7C1tZQPLsL/IG/1S04E6rGX4ttIno/wG
        KAH98iHtoQvqd3roRkb8huU=
X-Google-Smtp-Source: AGHT+IGFxlv4etb0uyC9OGMkhlDc1Ei3Qej722yLsq9WAvPsAK9ZqiYiGDWpUUx/UtPC7byBwJwCDA==
X-Received: by 2002:a17:907:5c6:b0:9c4:6893:ccc5 with SMTP id wg6-20020a17090705c600b009c46893ccc5mr375301ejb.57.1697401535225;
        Sun, 15 Oct 2023 13:25:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b009b97d9ae329sm2686943ejo.198.2023.10.15.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:25:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH -tip 2/3] x86/percpu: Use C for arch_raw_cpu_ptr()
Date:   Sun, 15 Oct 2023 22:24:40 +0200
Message-ID: <20231015202523.189168-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231015202523.189168-1-ubizjak@gmail.com>
References: <20231015202523.189168-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement arch_raw_cpu_ptr() in C to allow the compiler to perform
better optimizations, such as setting an appropriate base to compute
the address. The compiler is free to choose either MOV or ADD from
this_cpu_off address to construct the optimal final address.

There are some other issues when memory access to the percpu area is
implemented with an asm. Compilers can not eliminate asm common
subexpressions over basic block boundaries, but are extremely good
at optimizing memory access. By implementing arch_raw_cpu_ptr() in C,
the compiler can eliminate additional redundant loads from this_cpu_off,
further reducing the number of percpu offset reads from 1646 to 1631.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Use CONFIG_USE_X86_SEG_SUPPORT to handle
    cases where KASAN is enabled.
v3: Split the patch to the part that introduces MOV with
    tcp_ptr__ += (unsigned long)(ptr) and the part that
    introduces named address spaces.
---
 arch/x86/include/asm/percpu.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 915675f3ad60..54746903b8c3 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -49,6 +49,21 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+/*
+ * Efficient implementation for cases in which the compiler supports
+ * named address spaces.  Allows the compiler to perform additional
+ * optimizations that can save more instructions.
+ */
+#define arch_raw_cpu_ptr(ptr)					\
+({								\
+	unsigned long tcp_ptr__;				\
+	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+})
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
@@ -63,6 +78,8 @@
 	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
-- 
2.41.0

