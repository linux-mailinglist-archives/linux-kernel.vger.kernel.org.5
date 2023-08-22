Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987CE783977
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjHVFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjHVFrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:47:47 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8AD7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:47:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso25515205ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692683265; x=1693288065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9JssbzQX9VFHAc9E36F93tbDb41jway9Jc+dLt1MhU4=;
        b=f5qyb62EomFMuXfeRcS7JOgD2JnPA6D1D4Dkp2HxO/cqufRxiZdybYvpiil06eviJS
         5IJ24PgSA8jUMrt0C7Re5s9JJsglRhoT7RAJgc0dD3hOXKUJvigaIeIMSbVhOHXwJUI+
         mRcB4S5VRAGhHyqCR+vXS7DI0oT4TYY3XKl+XBjyu54j6cskt/p87Wk1j0ebnirci+Fw
         qijHvni9PmxWJinn+ZUYCPqm3wOme+ND601xFUNJDljkX0jkVPHv0qcsBi7E9CDR7QMZ
         qTbgWNjv+B5oBBP0b1l1vVPj6nUsGoAp+fY1OQJG+LWkUg4Bakj1/E85hZFWZ+sXa03n
         IYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692683265; x=1693288065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JssbzQX9VFHAc9E36F93tbDb41jway9Jc+dLt1MhU4=;
        b=EzKMRSPHDg1xC1AxkQoAl2hXpCqgyQDdutcADKxCODG1OH8k6nh2lHqIVH3Vx3G993
         qUz+xRYJzP4M0juh1ZwHMYkOFLJgyRqBYOjJeU/VzEN1XSdVAbbUQwL6FdvdxcAqacfK
         u+2XihzxqgkGU7ZrNc7anY606PTCbLx6dKKRLFnbzvdpIZP8u9yBbT6sTfmBckhSsUe7
         AVPz4/ulHrM+9GIZ+kcoTMTR73TdfALrquZTw24DLMFUUWmpd7z3Xh0APCOXWxlFHw84
         8W3IdkdcDVQERPj8CnCttRgb9iH8ZUniVF5HYiJ80OM63VXl9x3VFNI6j0yofHs78CEd
         c4DQ==
X-Gm-Message-State: AOJu0YzkS1PPdwGhb6NBSAz9ujwHDAPee2rFjwQzEi+5cgc2ltY/mwWs
        CXTdu/ddJLFu6kc6Wg3q3Cbt4A==
X-Google-Smtp-Source: AGHT+IGcfw+6MOZHdD4U2hB0gH3hptIg8rcq2NQYs+I+XfPKAPiSEgcJIG5E87JSML6WFF6YydVXYQ==
X-Received: by 2002:a17:902:bd45:b0:1b8:28f6:20e6 with SMTP id b5-20020a170902bd4500b001b828f620e6mr5446680plx.34.1692683265524;
        Mon, 21 Aug 2023 22:47:45 -0700 (PDT)
Received: from work.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001bbd8cf6b57sm8199960plb.230.2023.08.21.22.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 22:47:45 -0700 (PDT)
From:   Nick Hu <nick.hu@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, conor.dooley@microchip.com,
        jeeheng.sia@starfivetech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, nick.hu@sifive.com,
        zong.li@sifive.com
Cc:     Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v2] riscv: suspend: Add syscore ops for suspend
Date:   Tue, 22 Aug 2023 13:47:39 +0800
Message-Id: <20230822054739.33552-1-nick.hu@sifive.com>
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

If a task is the one who performs the suspend flow and it also do some
floating or vector operations before the suspend, we might lose the FPU
and vector states when it goes to the non-retention system suspend state.
Add syscore ops to save and restore the FPU and vector states of the
current task to fix the issue above.

Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
Changes in v2:
a) Add Co-developed-by and adjust the order of signed-off
b) Rephrase the commit message

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

