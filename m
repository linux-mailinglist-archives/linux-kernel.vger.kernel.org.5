Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DC7C722A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbjJLQNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379465AbjJLQM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:12:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D7C6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9f139cd94so184952566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127170; x=1697731970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSHi5/2cUoPsahCtfSXb7KL8cBzud0m2fEvRiojl9UE=;
        b=HBrqdyQ6Bi+M81SeywaNr2vf2WxITqUWLBfSV4eEuvUaDPWm/BT5Bow1NEno8I9YAX
         P8fkOKMzc7cRycd7wZMY11SWJLz5JqjLX/bmSQaJvi8KpAqCGMISo5TNOH1UJqbRK9F0
         rI1zX9HZ7gsTQp6emG5+7mDpCcTXOhDkKjl6W4De2PfPRF9SinIV8i8a9pawul2o3VL6
         TdprD8CzZTQOw8XF0q5FokKSPcvJFZZmIhNqKEXebTbjGzU791O0izkHmBQgCkKWnSB6
         n4oZnJ74rwI/o8JOP1RYLOnskbIVpdY3iJcHBKJK2RImutJ/Qpv5luvp10nNorHpuE7z
         544w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127170; x=1697731970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vSHi5/2cUoPsahCtfSXb7KL8cBzud0m2fEvRiojl9UE=;
        b=G1Ihaqur5t80QocaGH+N6sNN1kBQ3D5odvjZUiGRkeRrCjMebsPAcrjLfQu9O/6IpH
         tkBswz1xyw3wNEkd2w2U6S92yjqxeI++d3F91/3aJtL7H77aQ9PaRDUfbRPI8QFt4izg
         hurdo53icCrxWHCEU4yAhJPVLZeg1AWlCaiEJd77rbRzRxP5xRHPaPy/TC3ByjXumHbr
         ILBCv79ikW1pE/gJqPiJfsMpXLdeHJYE4GSlv42G/TpN8r0MrDa6GSc6jsXuwORYzcha
         dNz+75ITa4Q7Z3jIC8nosPukCmMia5sNJM/z4ek6oPX5uPcSTW/1DalG4OOeowQzpO1r
         TQNw==
X-Gm-Message-State: AOJu0YxZpZqwyqnYNKtVoK3OT3H62FQpxcHCiIbNfNvZPmcDXpciXNWI
        qey7keGZ/M3Vt+fFzjw8e+M=
X-Google-Smtp-Source: AGHT+IFpYi1blV2KJsYt/+b2deArMIbm7cJzAsEuhn9TEMfBcKQAcEqKVR0HJV8k5hdf8tw21y1uTg==
X-Received: by 2002:a17:906:76cf:b0:9b7:303b:1ecb with SMTP id q15-20020a17090676cf00b009b7303b1ecbmr22078486ejn.61.1697127170254;
        Thu, 12 Oct 2023 09:12:50 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm11414461ejb.141.2023.10.12.09.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:12:49 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/4] x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR macro
Date:   Thu, 12 Oct 2023 18:10:39 +0200
Message-ID: <20231012161237.114733-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012161237.114733-1-ubizjak@gmail.com>
References: <20231012161237.114733-1-ubizjak@gmail.com>
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
 arch/x86/include/asm/percpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d730463..9a5f1896c5ef 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,16 +4,18 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
+#define __percpu_rel		(%rip)
 #else
 #define __percpu_seg		fs
+#define __percpu_rel
 #endif
 
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_SMP
-#define PER_CPU_VAR(var)	%__percpu_seg:var
+#define PER_CPU_VAR(var)	%__percpu_seg:(var)##__percpu_rel
 #else /* ! SMP */
-#define PER_CPU_VAR(var)	var
+#define PER_CPU_VAR(var)	(var)##__percpu_rel
 #endif	/* SMP */
 
 #ifdef CONFIG_X86_64_SMP
-- 
2.41.0

