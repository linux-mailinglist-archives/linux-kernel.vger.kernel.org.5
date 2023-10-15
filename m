Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F07C9B6A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjJOUZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJOUZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:25:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF6C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9be02fcf268so289564466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697401534; x=1698006334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b31YTUQEfZpOY+PzyS5wCBrwfTvZYZf58DeFB/h6Ek8=;
        b=YHiM0Jdt3Ptd77vKD6c/DnEOSQPaKS++jQed4Shg6isVepl0d7hPQk44UlmtIBAfva
         oJEKLNZ6GhUp5qwH+DoWeKOp/a0WliMFMCv6n4D0wOF7H/RZsH4mtdH7frQxlXb+owTU
         HHQxROeTBR+45v6C9puk8G58l7TTGZQKuNznJpS5v71oxGdNaY9vCdTB0Z3wEfx9ZBtv
         A3RPIJg1hd5+7u2Pi3Q+LaxqIMHF76VGtdwqSo2RASZKGhijRlrTB08nLvm6cFOqiZfw
         4lM24ny8PooIcRcY5ZlEGrwcc743xRbw/gELUKxRkSUfRv63QEJ8sylNlZj6jkjAKCox
         Vvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697401534; x=1698006334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b31YTUQEfZpOY+PzyS5wCBrwfTvZYZf58DeFB/h6Ek8=;
        b=GXG5DKgA+xnY5KWR7PVW5w6HZa+UHFPcLdyqCnCbrZalHpj/K+VDZRKYnpOXZ3g6ra
         1NSNTHkBwNm1T+Frx9wQW/sTA6NZB4Wl3bMEoA9vX9UkOZZiVrhEY8suaA1mdq76f0Mw
         c34pzK3uVSEQy5btHMIGjonDA0RQAAiyWrRctmFhALPu5r08pfx1TvqQ9KRzEt/VBw5K
         xVHjZrc17OKQPYmZrc1jQosfqgBs3223AQCXTh8UQ8356fHdmP2VS9lXqUKObpkDZV6H
         hwaLb4dIMJOscZCh26axkQdwIpgI7nKIamdKn7/jOxS/XZ3rLPlf+HkY9y3xPBT69KMB
         bsMw==
X-Gm-Message-State: AOJu0YzikPI2+TttyEEyS7kGWsX4oASce7ziJT1Uoss1Po1LzQggS9Sa
        IFhm5683iuDy1Jmg7TWSJWM=
X-Google-Smtp-Source: AGHT+IHH8INqDJpXYzQJFSUGF4OwYlV74tetttmJKbeu5tqhQUhAPfM5yI/+HBshFv+tuQ+7gK8Efg==
X-Received: by 2002:a17:907:724b:b0:9b2:b9ff:dc35 with SMTP id ds11-20020a170907724b00b009b2b9ffdc35mr33586268ejc.70.1697401534174;
        Sun, 15 Oct 2023 13:25:34 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b009b97d9ae329sm2686943ejo.198.2023.10.15.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 13:25:33 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH -tip 1/3] x86/percpu: Rewrite arch_raw_cpu_ptr()
Date:   Sun, 15 Oct 2023 22:24:39 +0200
Message-ID: <20231015202523.189168-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Implement arch_raw_cpu_ptr() as a load from this_cpu_off and then
add the ptr value to the base. This way, the compiler can propagate
addend to the following instruction and simplify address calculation.

E.g.: address calcuation in amd_pmu_enable_virt() improves from:

    48 c7 c0 00 00 00 00 	mov    $0x0,%rax
	87b7: R_X86_64_32S	cpu_hw_events

    65 48 03 05 00 00 00 	add    %gs:0x0(%rip),%rax
    00
	87bf: R_X86_64_PC32	this_cpu_off-0x4

    48 c7 80 28 13 00 00 	movq   $0x0,0x1328(%rax)
    00 00 00 00

to:

    65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
    00
	8798: R_X86_64_PC32	this_cpu_off-0x4
    48 c7 80 00 00 00 00 	movq   $0x0,0x0(%rax)
    00 00 00 00
	87a6: R_X86_64_32S	cpu_hw_events+0x1328

The compiler also eliminates additional redundant loads from
this_cpu_off, reducing the number of percpu offset reads
from 1668 to 1646.

Cc: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 60ea7755c0fe..915675f3ad60 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -56,9 +56,11 @@
 #define arch_raw_cpu_ptr(ptr)					\
 ({								\
 	unsigned long tcp_ptr__;				\
-	asm ("add " __percpu_arg(1) ", %0"			\
+	asm ("mov " __percpu_arg(1) ", %0"			\
 	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
+	     : "m" (__my_cpu_var(this_cpu_off)));		\
+								\
+	tcp_ptr__ += (unsigned long)(ptr);			\
 	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
 #else /* CONFIG_SMP */
-- 
2.41.0

