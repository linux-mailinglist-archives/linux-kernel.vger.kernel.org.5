Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B17CC8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbjJQQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjJQQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:28:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FC1101
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so9995188a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560114; x=1698164914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACjTlp17z+YNibGqC8x+geAURHF1Kan1uHKDOj47eKE=;
        b=CwtjkKXj2flzI1cSiT5aDybKin44gv7hSr1rcYlrWBmr1/5WPHEB/7Z2Jui26Ia9bI
         ohUEgByRaEKXOffmn2PRsAkgvz5n5iYFj/isU5YYa5cDs/3TyQpBajsUqGgpIwdxFscW
         tf5Jh1kTpg+AmnS4wuxfsMjyy2PIuncIhbBUGtrRSXGFWyB9pxYoCKibJUzXZ2bUX551
         klNTGLOJ9920juvbOcMnySzIacjpknJJqOkTvSUylOxHZmLGtAHqEFPp9Qx61zgMezck
         vu1QSMLJafnsZdkhK8xmW6zuWqVZmgoZ/rIMD/rGBueFlZqExc6R4L0ADqxkX4PrQ4VV
         5ivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560114; x=1698164914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACjTlp17z+YNibGqC8x+geAURHF1Kan1uHKDOj47eKE=;
        b=EV5XPb3tf0V8C1+SHwHPcozi1iela9o42JvRCo0kvCTqIGle2ZX4YieCVml6fjfTNT
         pqQmzEKta5fXJHl62frJKdMPi5Tkwit/3kxptUMCytK/jgbFY651AdhDZc8zLH4q54KS
         8MtbpJr/zLqJiFop/XMo4naOwt62EqrSD5cpxOFdoajpERboFl8xQ+iUV5nvGYt7lHoK
         cPa4WVQzf52WeQtBr0qTVfhndmduW+BXhG2zDNFDLBTuj7qMjvBxLwxGRRoC37mNNyn1
         1x5lptcH1aUdhK0W/EMvs6/SygEx+2143j1C9xhlS7P4njPgeyc7k7+/IYgbYvTWcQj1
         PGgg==
X-Gm-Message-State: AOJu0YyV2evLHYLTtrKoFAkAwTedHSZfmpe6GRnlxFxeXgfLmLSmmF0e
        ApK61xvgiuCOEHlbPaSyh7/Am+ISTA0hAvxm
X-Google-Smtp-Source: AGHT+IHDOoG54XbWT0w4HYKSIqNwfcnUP1l4hxV6R0suamSju/kc2UdPTin8Cao44o+9eCfjSpu0mg==
X-Received: by 2002:a05:6402:350b:b0:53e:2c49:8041 with SMTP id b11-20020a056402350b00b0053e2c498041mr2333292edd.8.1697560114667;
        Tue, 17 Oct 2023 09:28:34 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b0053e43492ef1sm1515759edf.65.2023.10.17.09.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:28:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH -tip v3 2/3] x86/percpu, xen: Correct PER_CPU_VAR usage to include symbol and its addend
Date:   Tue, 17 Oct 2023 18:27:33 +0200
Message-ID: <20231017162811.200569-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017162811.200569-1-ubizjak@gmail.com>
References: <20231017162811.200569-1-ubizjak@gmail.com>
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

PER_CPU_VAR macro should be applied to a symbol and its addend.
Inconsistent usage is currently harmless, but needs to be corrected
before %rip-relative addressing is introduced to PER_CPU_VAR macro.

No functional changes intended.

Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/xen/xen-asm.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 9e5e68008785..448958ddbaf8 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -28,7 +28,7 @@
  * non-zero.
  */
 SYM_FUNC_START(xen_irq_disable_direct)
-	movb $1, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	movb $1, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	RET
 SYM_FUNC_END(xen_irq_disable_direct)
 
@@ -69,7 +69,7 @@ SYM_FUNC_END(check_events)
 SYM_FUNC_START(xen_irq_enable_direct)
 	FRAME_BEGIN
 	/* Unmask events */
-	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	movb $0, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 
 	/*
 	 * Preempt here doesn't matter because that will deal with any
@@ -78,7 +78,7 @@ SYM_FUNC_START(xen_irq_enable_direct)
 	 */
 
 	/* Test for pending */
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_pending)
 	jz 1f
 
 	call check_events
@@ -97,7 +97,7 @@ SYM_FUNC_END(xen_irq_enable_direct)
  * x86 use opposite senses (mask vs enable).
  */
 SYM_FUNC_START(xen_save_fl_direct)
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	setz %ah
 	addb %ah, %ah
 	RET
@@ -113,7 +113,7 @@ SYM_FUNC_END(xen_read_cr2);
 
 SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_BEGIN
-	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
+	_ASM_MOV PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_arch_cr2), %_ASM_AX
 	FRAME_END
 	RET
 SYM_FUNC_END(xen_read_cr2_direct);
-- 
2.41.0

