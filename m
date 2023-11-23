Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACF7F6882
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKWUgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWUgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:36:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A97FD48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:36:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40790b0a224so8340925e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700771784; x=1701376584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tC3W5L1+J/toPEO34eKzGWK4uyGHbvsRdlp8wN/BqN4=;
        b=J0ajDLKL+FGoXCiW+VQTvHVIhqzcE26YW9JxlAW0AYfqtiYgZINONbPjM8m8nxNkV1
         0IS1aOjA3sr7As+1gnTNJkgQ7ras6c1AUg39MQAuvGrv4xQOj5LH4E6a13c5XQCZAM6N
         TZ5vsIxGu3V4Mb222A4VUEMAhpdLSVLmt0qeOAmLMk0uMokK8MYWjmscxWr5/kqx4kXc
         WJhr95kEuINQXCqo4Mim7/tfDfIg5WGyflPTutZJ0RRGRkyTVYm2IREQJ46CRVFAuMgw
         idX8LKWZKWKF0H3htaW9Jhi8bjsQeV6pUCyb7yyrADiwXTDxFLGQnTxEl9HQvYENoQZP
         h8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700771784; x=1701376584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tC3W5L1+J/toPEO34eKzGWK4uyGHbvsRdlp8wN/BqN4=;
        b=T3yWB1Vdiz7Fmp8SCoHzQz0FfHNXqJg9hK8ULMxX8f+JUHD6vu535LcUm6/qpfIXPw
         prfhSGJd6q+hiXSG+pqg8t5oH5foW8XZgIbd2L/1o3mKGeL4WFg3QWcFmHlLTPpDtt5Q
         WU/QQKyM91BnHmGgPRmPbhi3rJb7chPuFN+IiA+7LCC3Xkd8nz/NqqedVJr8KnoO9XMF
         zkDcWx2ReXZJUuaVlQuUUwcEDwttGzxk22fdXlWXBIfcQnmZuB16nbhWA8Lu6oQ6OJaW
         wzxmfp3O9gXvwYCjCE8JnEnkkIlISIsvrLb3vsIXw/hT5hKbt6L1+oOPsg0tvvmAZug0
         AoZw==
X-Gm-Message-State: AOJu0Yxke1YU8edZYkyXLiDUXRY+nuXRihjYJ23x6KU0z6hDTv6uz02S
        Kb/Oi6sytvHwICjGCBL5eDCU9iW6cunGoA==
X-Google-Smtp-Source: AGHT+IH/FOTnwg0YToqGZmtMTbLw0haIuR9qmANjgXuhECpWpKrTIhjE09Tac27rEe01zm/Uf9fnsw==
X-Received: by 2002:a05:600c:3c82:b0:40b:3820:acf4 with SMTP id bg2-20020a05600c3c8200b0040b3820acf4mr546808wmb.3.1700771784316;
        Thu, 23 Nov 2023 12:36:24 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c3b8800b0040b398f0585sm493028wms.9.2023.11.23.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 12:36:24 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/2] x86/smp: Move the call to smp_processor_id() after the early exit
Date:   Thu, 23 Nov 2023 21:34:22 +0100
Message-ID: <20231123203605.3474745-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_processor_id() accesses the per-cpu variable, so the compiler
is not able to move the call after the early exit on its own.

Also rename "cpu" variable to a more descriptive "this_cpu".

No functional change intended.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Split from v1 patch.
---
 arch/x86/kernel/smp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96a771f9f930..97f6f0cbb43a 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -148,14 +148,15 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int this_cpu;
 	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
 	/* Only proceed if this is the first CPU to reach this code */
-	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+	this_cpu = smp_processor_id();
+	if (atomic_cmpxchg(&stopping_cpu, -1, this_cpu) != -1)
 		return;
 
 	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
@@ -186,7 +187,7 @@ static void native_stop_other_cpus(int wait)
 	 * NMIs.
 	 */
 	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
@@ -210,6 +211,8 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
+			unsigned int cpu;
+
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
-- 
2.42.0

