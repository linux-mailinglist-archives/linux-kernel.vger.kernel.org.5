Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829667F6881
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKWUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 15:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjKWUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 15:36:21 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133FD48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:36:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso8394595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700771786; x=1701376586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvAaA3Q6o70anR4fOOtdChYIk/DBeFPv4ujSnCFXB64=;
        b=cl/m6fiUf1/tBRtWqKEmW3PGEAu/HtipLjopUPNhiT6l+TjHHPho0SccEkTTj2ekgI
         SuK8liIK+Gx1q20FCX/e4Hk+YbtYAiBXSAw79N7tm29brGx8la7SsIKBrcThWTro6vgy
         WXIALhM4Ye6wewRHXHz2fpTndYrXoR1CY0g6s3Fok64QvzHXTTx672gIDVTql2D4hOB2
         zI5Tl539viVUX3mVZjoxQadWLEjwnKI8nuYYEwL3SlSIkrDybOzkJJNCit3OmZaUCske
         0u0ppIKVFQcSG5QFT0RhOQ3ZrlsswsRw4w1xBbfgSh/jeqAwTL8tyoI8EqLQcawg8Tan
         JXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700771786; x=1701376586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvAaA3Q6o70anR4fOOtdChYIk/DBeFPv4ujSnCFXB64=;
        b=dMHri86dpC6LDdwWbzPCw0CVA1OMcqVUu4SpVKhRR7o9mkToBvNmei5h9sYoI5OFpE
         UEyIgN4+uDv9BMSZS+S9SFr1tALx/4l/BpNEX/NUaY3skkAIZkqbfydaOMrNtQG7pToC
         10eRHGN5fui8FWJXMmu9goSCmhEtfsx2U1thuDwYdOy6EkFKmj+Zcr30gaD2734GmgzX
         cE5361GFkUORp3p6j8+JwSRTMngKSn2eMdwwceRwXXGT9XFXLNtXmXL2T/rNh3xJ0oU7
         QZbaL19sPzLbc49XIE2mlpAgXgWyAxB40N1GKbWZweDCONVv7QvmkYLAUAJPOtOv8jcE
         QQVA==
X-Gm-Message-State: AOJu0Yxi35FFHxAAyBzUaxMnOCARTYvoQ36xpTR1I0tHSXekVqa5Ytqz
        MOnK9/XgBCW0BGgsNeAYP6TL7FFPcAvGMw==
X-Google-Smtp-Source: AGHT+IFMb80+oFOwT9z0aOfeRn6ziAAaWRySvnmUty/YOc+9Q1qx5YNiK4g9Ftbi86oPwU7znedZzA==
X-Received: by 2002:a05:600c:484f:b0:40a:767a:7248 with SMTP id j15-20020a05600c484f00b0040a767a7248mr507520wmo.22.1700771785936;
        Thu, 23 Nov 2023 12:36:25 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c3b8800b0040b398f0585sm493028wms.9.2023.11.23.12.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 12:36:25 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/2] x86/smp: Use atomic_try_cmpxchg in native_stop_other_cpus()
Date:   Thu, 23 Nov 2023 21:34:23 +0100
Message-ID: <20231123203605.3474745-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123203605.3474745-1-ubizjak@gmail.com>
References: <20231123203605.3474745-1-ubizjak@gmail.com>
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

Use atomic_try_cmpxchg() instead of atomic_cmpxchg(*ptr, old, new) == old.

X86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after CMPXCHG.

Tested by building a native Fedora-38 kernel and rebooting
a 12-way SMP system using "shutdown -r" command some 100 times.

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
v2: Split from v1 patch.  Simplify commit entry and state
    how the patch was tested.
---
 arch/x86/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 97f6f0cbb43a..2908e063d7d8 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -148,15 +148,16 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned int this_cpu;
+	unsigned int old_cpu, this_cpu;
 	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
 	/* Only proceed if this is the first CPU to reach this code */
+	old_cpu = -1;
 	this_cpu = smp_processor_id();
-	if (atomic_cmpxchg(&stopping_cpu, -1, this_cpu) != -1)
+	if (!atomic_try_cmpxchg(&stopping_cpu, &old_cpu, this_cpu))
 		return;
 
 	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
-- 
2.42.0

