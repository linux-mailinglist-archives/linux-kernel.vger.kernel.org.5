Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD077EB519
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjKNQoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjKNQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:44:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064D11D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:44:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f87b1c725so4042192f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699980267; x=1700585067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpdezhDPEqhtB7SZt0xZhm1topcNCcCV8z1dKB+mAIY=;
        b=CBxcliuf53QIl1HxHjIRurINlLx4cKoNZ2axNXkRWgzvldLaT3592BQF1xAmO3NpYJ
         96WTTEWDlhdUuNNMPfTMckwrEtZgExZjM+87FVPd8eLDQIIAbzovPZYhf2HJSsa2QX4K
         vOfcWiCI2vANxzOUhCVD1y+YpRxfhiuHUUMI0NyVYn1QG0SP66OZWBo8s1e2QGxlHe3o
         CYjy323E0OLRgGeNuuOFbbnAdEBWmE4xu04Vi/25mRGJsLWqevo3airkKPqWeLKpIb7I
         hf9/sadX6XjNWC41ma2Ou8cqWoVoNUhwnqQ3Gr6+Rbuz3EHbuJBTYYOytMW3U+b8MX5o
         QB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699980267; x=1700585067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpdezhDPEqhtB7SZt0xZhm1topcNCcCV8z1dKB+mAIY=;
        b=Wq3kxaE9zZ+CmqZlPN0jeofBsjERlSS1y3w45QoQAmtgSazYQ5YM2Uqn6GpFrsoGJD
         0EjLGGlcjcaYmiumVQVj8scO2A20+R9AfjlhGHDqfg1bmBaJwQJHj4OxKg4xElXv0bWa
         A6z6NxVACTcWie4DEHv5k3ebufJObEe9QWQasVHh7QiMUuUxQKPi7GPq4l94QLBKbHj3
         dZhoNzRPdlaZ1r21C/4uhGBSIXYJB9LvapJbSCQ/5frd9NMEgEr8Rb6rQixtlcEWH9LR
         ytJ3z5gpOzDYVUoc0exJIvaN4aidw1fG3oN38JVsLxouyECerPM0LK1lGXMpzWXTRcT9
         NeCw==
X-Gm-Message-State: AOJu0YwwMBPZTIIoM/P5/aI+SL+ArZH7E/tx/ATZbEXcohYHGMi0lgBz
        uB9RaeiRerAK8Y4WSCSOQnE=
X-Google-Smtp-Source: AGHT+IESNbQsZK0rVetMDFvSdHXOoT9tZEz0TI0btQ7KW13e+F3gMNIdf2uRepSxQxmmMLBzs4Io/Q==
X-Received: by 2002:a05:6000:549:b0:331:4e4e:cb63 with SMTP id b9-20020a056000054900b003314e4ecb63mr3779446wrf.28.1699980267179;
        Tue, 14 Nov 2023 08:44:27 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6441000000b0032f7f4d008dsm8270755wrw.20.2023.11.14.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:44:26 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH] x86/smp: Use atomic_try_cmpxchg() to micro-optimize native_stop_other_cpus()
Date:   Tue, 14 Nov 2023 17:43:46 +0100
Message-ID: <20231114164416.208285-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old
in native_stop_other_cpus(). On x86 the CMPXCHG instruction returns success
in the ZF flag, so this change saves a compare after CMPXCHG. Together
with a small code reorder, the generated asm code improves from:

  74:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax
  7a:	41 54                	push   %r12
  7c:	55                   	push   %rbp
  7d:	65 8b 2d 00 00 00 00 	mov    %gs:0x0(%rip),%ebp
  84:	53                   	push   %rbx
  85:	85 c0                	test   %eax,%eax
  87:	75 71                	jne    fa <native_stop_other_cpus+0x8a>
  89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  8e:	f0 0f b1 2d 00 00 00 	lock cmpxchg %ebp,0x0(%rip)
  95:	00
  96:	83 f8 ff             	cmp    $0xffffffff,%eax
  99:	75 5f                	jne    fa <native_stop_other_cpus+0x8a>

to:

  74:	8b 05 00 00 00 00    	mov    0x0(%rip),%eax
  7a:	85 c0                	test   %eax,%eax
  7c:	0f 85 84 00 00 00    	jne    106 <native_stop_other_cpus+0x96>
  82:	41 54                	push   %r12
  84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  89:	55                   	push   %rbp
  8a:	53                   	push   %rbx
  8b:	65 8b 1d 00 00 00 00 	mov    %gs:0x0(%rip),%ebx
  92:	f0 0f b1 1d 00 00 00 	lock cmpxchg %ebx,0x0(%rip)
  99:	00
  9a:	75 5e                	jne    fa <native_stop_other_cpus+0x8a>

Please note early exit and lack of CMP after CMPXCHG.

No functional change intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/smp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 96a771f9f930..2908e063d7d8 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -148,14 +148,16 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int old_cpu, this_cpu;
 	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
 	/* Only proceed if this is the first CPU to reach this code */
-	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+	old_cpu = -1;
+	this_cpu = smp_processor_id();
+	if (!atomic_try_cmpxchg(&stopping_cpu, &old_cpu, this_cpu))
 		return;
 
 	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
@@ -186,7 +188,7 @@ static void native_stop_other_cpus(int wait)
 	 * NMIs.
 	 */
 	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
@@ -210,6 +212,8 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
+			unsigned int cpu;
+
 			pr_emerg("Shutting down cpus with NMI\n");
 
 			for_each_cpu(cpu, &cpus_stop_mask)
-- 
2.41.0

