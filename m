Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8077C99EC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjJOQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjJOQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:10:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE02A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99de884ad25so599942166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697386247; x=1697991047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNuYyWEUkCBUvaAXEq0aoPImcZWnaX/wCmiSUbk6m0g=;
        b=Emrdan8k0oYm2wwcalRywL3i1NJ2U70CbIblQXFyKcA2lMOl8Ez9bqpQ+NSHEIr6Rc
         6dyL/2cAGCjAmZU+mPLMX0eQXfixq+IzhH5Xe3QZjhXsVV73a99vxQ2eNWqmDjCjMZ/I
         OUwV/lucjk8+flrRbEoL+MtM6zdYEvIIlM2SZpsJPlqve00PvTiJgZRVK4psMbWWq5a7
         rYESetDbad+K8OcOSdQme104VNSg6kdw/fHgVolE9qKC9agua6qXIw/+PZ5jqmr7TLe5
         YBFdlJ0jrXdphqYAkUijWqA9GhW1TFXfMQDoHf7wyezuQ8DP57QEXvRdK9ifZMfQ+jRH
         DFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697386247; x=1697991047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNuYyWEUkCBUvaAXEq0aoPImcZWnaX/wCmiSUbk6m0g=;
        b=R+RsxEkCoB8Ks86kndC8qSCsaQFV6m97tLZATu+ErfQM6+yA3q/o/Uk7+/nScwRfwt
         16q/kmr9s92c4cDNr/UXsuWidjNAZ9xAXX6M2Jz0kUuE3m4v5b0oWNnqNFdOURIZIdwD
         BFUalkH19rTJzdr33NgoJdRd+9GBLRN9Ah1ADQcvJDYPbnA5/6rgTzn0YIyAkkGzyx9A
         +0CafkaLMoTgVjePErqpl/KUEpSZ7bE5+omvUDrika68KR2TlebQnYZRQJBTihL/ztbr
         rUB/u/dcPbEhODWbUNM7sV/PbXyJuLmp08+RVzVRbhreW+mdY4PDBC/GGhO5GqwrAtXU
         5kpA==
X-Gm-Message-State: AOJu0YwOJE3k4ZnxjpYtr5hyQLAXaR8ckIJbXhYDdwjN5W4DVWmxO0Se
        7Wo1eMy9YP0JQnGZEwd4Afs=
X-Google-Smtp-Source: AGHT+IHzwRGoTsq2ot/pkjlspwnV7I6UAUsPnchXAv4bHUoDdbyDL6cBAAa+K2qzJnSDEzRDgK0gbw==
X-Received: by 2002:a17:907:9450:b0:9bd:e3ae:ef57 with SMTP id dl16-20020a170907945000b009bde3aeef57mr5115780ejc.60.1697386247417;
        Sun, 15 Oct 2023 09:10:47 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id rh14-20020a17090720ee00b009b947f81c4asm2421863ejb.155.2023.10.15.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 09:10:46 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 2/2] x86/percpu, xen: Correct PER_CPU_VAR usage to include symbol and its addend
Date:   Sun, 15 Oct 2023 18:08:56 +0200
Message-ID: <20231015161036.39689-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231015161036.39689-1-ubizjak@gmail.com>
References: <20231015161036.39689-1-ubizjak@gmail.com>
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
Inconsisten usage is currently harmless, but needs to be corrected
before %rip-relative addressing is introduced to PER_CPU_VAR macro.

No functional changes intended.

Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
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

