Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED49B77D941
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241699AbjHPDsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241801AbjHPDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:48:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7AF3A81
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:40:14 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565f24a5c20so277842a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692157214; x=1692762014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPu9EybHcv+f53uItq5HW0DqxX8IdZv8teFDMaig/ZU=;
        b=GAaINHUgKkTiffbKFeyXGI3ArOVCLgHFwm6+07G8C/STkypzCHvDKQ56rHHIqsMPXN
         PwL04sykxFggY55dLFzQONd53BheUBhhUEjJJiBzdR82K1yjSRhF00bZVxgtTP1MvCol
         jZsFJrssJmRleYvplUDv4i8FbAXE5eCRC2tgNF/nEZSj9Vd4xUoIjJesdmKxrFdv7Cij
         Xo74xb8lxqSKUVCioIvLDw9mfG/wS74O90H2PvUWmEM12+GFUdRpY68eeeK+cIiZJsDf
         hfgnV/QEdapc5qO+rP39B5ynQKZND0jQlhmXy629b6hkosSvumrfO5CVogxgimUp3sAI
         5VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692157214; x=1692762014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPu9EybHcv+f53uItq5HW0DqxX8IdZv8teFDMaig/ZU=;
        b=K4wE31IxooYunw8jDV99sQf+yu8inftoqxNu51NiCQD9PYI9MC/1IuaeRVF3emnzEW
         mpZBu39pyLcBhzt+bO4HIh6PB+NjO/m65kuYx4RMd9XsE0gg8KBqDweztZ8smcCThjKE
         DE0NCfcfBNooGwsW0mvygepemJMoN9cgFoMrsb2BaOIu08g9DgKXSF+n58ujpX43W/UL
         r5d9sOdEI7tbS76jvnWE95HEkisBIkx8FG5YUbB7M8DPsT5uV3PCWCpwsVb7bShmnC8o
         uuaZOZB6kdU2MeWfH7nQZbx5EQioJT0NGxDEtA72iDjb0w954We6KzdL7b0Aq68Ks5W5
         xoCQ==
X-Gm-Message-State: AOJu0YxmsRiBvz5xQVlLyeVpZK9zPDyUdB10pHWrIBX/xymTF63L4ol8
        BcEAC/AtnWS9ZYD4B7S2EMCb8w==
X-Google-Smtp-Source: AGHT+IHmH/xVr3Y8BUiUQjbv9iZDetSovCsqgNIWzDlt/MkeMZW5ou45NWSH/+8kp3BkeiVBk9d/GQ==
X-Received: by 2002:a17:90a:9386:b0:26b:69c1:9a6a with SMTP id q6-20020a17090a938600b0026b69c19a6amr4775690pjo.20.1692157214230;
        Tue, 15 Aug 2023 20:40:14 -0700 (PDT)
Received: from work.. (1-161-171-111.dynamic-ip.hinet.net. [1.161.171.111])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902868e00b001b9dab0397bsm11796274plo.29.2023.08.15.20.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 20:40:13 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     nick.hu@sifive.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ajones@ventanamicro.com,
        mason.huo@starfivetech.com, jeeheng.sia@starfivetech.com,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH] riscv: suspend: Add syscore ops for suspend
Date:   Wed, 16 Aug 2023 11:40:09 +0800
Message-Id: <20230816034009.2614866-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save and restore the FPU and vector states when system suspend. If a
task is the one who performs the suspend flow and it also do some
floating or vector operations before the suspend, we should save and
restore the FPU states and vector states for this task.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/suspend.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 3c89b8ec69c4..ff69ff8a1974 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -4,9 +4,14 @@
  * Copyright (c) 2022 Ventana Micro Systems Inc.
  */
 
+#include <linux/cpu_pm.h>
 #include <linux/ftrace.h>
+#include <linux/thread_info.h>
+#include <linux/syscore_ops.h>
 #include <asm/csr.h>
 #include <asm/suspend.h>
+#include <asm/switch_to.h>
+#include <asm/vector.h>
 
 void suspend_save_csrs(struct suspend_context *context)
 {
@@ -85,3 +90,43 @@ int cpu_suspend(unsigned long arg,
 
 	return rc;
 }
+
+static int riscv_cpu_suspend(void)
+{
+	struct task_struct *cur_task = get_current();
+	struct pt_regs *regs = task_pt_regs(cur_task);
+
+	if (has_fpu()) {
+		if (unlikely(regs->status & SR_SD))
+			fstate_save(cur_task, regs);
+	}
+	if (has_vector()) {
+		if (unlikely(regs->status & SR_SD))
+			riscv_v_vstate_save(cur_task, regs);
+	}
+
+	return 0;
+}
+
+static void riscv_cpu_resume(void)
+{
+	struct task_struct *cur_task = get_current();
+	struct pt_regs *regs = task_pt_regs(cur_task);
+
+	if (has_fpu())
+		fstate_restore(cur_task, regs);
+	if (has_vector())
+		riscv_v_vstate_restore(cur_task, regs);
+}
+
+static struct syscore_ops riscv_cpu_syscore_ops = {
+	.suspend	= riscv_cpu_suspend,
+	.resume		= riscv_cpu_resume,
+};
+
+static int __init riscv_cpu_suspend_init(void)
+{
+	register_syscore_ops(&riscv_cpu_syscore_ops);
+	return 0;
+}
+arch_initcall(riscv_cpu_suspend_init);
-- 
2.34.1

