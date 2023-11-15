Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F457EC9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjKORiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjKORhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:37:53 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25ABD6A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:40 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-778940531dbso429996485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700069858; x=1700674658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xReHSzApaFWYK7/D7xuGCs8slM1yGD2PO+yQfeDqI34=;
        b=QQIiXkDDREiKYzoha2vEoi0pEJvt6uxEtnmCMbfElZXjchqMra9ydKlM8naapJA4EZ
         NmZ69lzbAlHT2AWNb0KtvjCM2xhMROGNhXVXDp538QpX8QbOi2gNbmeQab5KCzwPsV3l
         19xigslpyXrNJBlhPwbSFLOARNOGX4jSOStXdKUmhGcTB5fil4DvFNjTgY3LtW9iBMeF
         ezw9J8Mv0Tmn4eqCtq8fQoCtNvidUUB5MLZR0+ViHENWaO4PAmy4Wgh7YI+4pyYq08c1
         VnfJHubn3Ea9px64JXiI5iTUf9oZ26HyfnYLuA+dqDWAwTjn3bsJc92x8fYK2B6jlICc
         1+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700069858; x=1700674658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xReHSzApaFWYK7/D7xuGCs8slM1yGD2PO+yQfeDqI34=;
        b=EASduukFl8766SKHG/A6VX0Xggs7v8jfpI1x78AXsPssovlGnItN6RzszTpvjXSwr5
         RJmjiIyc+U/zoPPdb02V7EXHimsuBi/UIxLNfnU7DOUvW3XyX7/F5frkoMWjsvd8yO61
         7GjtvyXBBovHTyiVp1ixfBEF5GMBWiFMooYvGKOwaNtM3j9DQwcWw8SNn1AeQzSqVTTU
         RXiEMPjL8Q9iGlgpYC3Hbw7b8U/US0VjSpkNfMm1i89iIpKsLJA+7oYQA163/VfIJ78r
         C4RAncdBBQn0LxyuSBpleJAk8vtGpW0NoUVfsxjk/53ZgYRuh4WfDBG5hITmOIIcnwqp
         QM2g==
X-Gm-Message-State: AOJu0YzukQCOLR09qCgEf8iH2wcuGFdpeIP3Cyqg6ws9aXN0+2RPQE2D
        R0cSEq2QjkFgjWWcv+48jqdk4gF/gQ==
X-Google-Smtp-Source: AGHT+IGPE9obzWO8K9sGVIqKBZ2smTQ1773aqiUlD2q2gxu38kLTvubuGlOPY1A5pPrtaFe5tQ2ZlA==
X-Received: by 2002:a05:6214:9c1:b0:66f:b8a2:521a with SMTP id dp1-20020a05621409c100b0066fb8a2521amr5632326qvb.17.1700069858535;
        Wed, 15 Nov 2023 09:37:38 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id x20-20020a05620a0b5400b0077bda014d8esm3260099qkg.87.2023.11.15.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 09:37:37 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>, David.Laight@aculab.com,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 10/14] x86/percpu/64: Remove fixed_percpu_data
Date:   Wed, 15 Nov 2023 12:37:04 -0500
Message-ID: <20231115173708.108316-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115173708.108316-1-brgerst@gmail.com>
References: <20231115173708.108316-1-brgerst@gmail.com>
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

Now that the stack protector canary value is a normal percpu variable,
fixed_percpu_data is unused and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h | 8 --------
 arch/x86/kernel/cpu/common.c     | 4 ----
 arch/x86/kernel/vmlinux.lds.S    | 1 -
 arch/x86/tools/relocs.c          | 1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 73fa9d4d2e16..f84c8d3ca75d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -393,14 +393,6 @@ struct irq_stack {
 } __aligned(IRQ_STACK_SIZE);
 
 #ifdef CONFIG_X86_64
-struct fixed_percpu_data {
-	char		gs_base[40];
-	unsigned long	reserved;
-};
-
-DECLARE_PER_CPU_FIRST(struct fixed_percpu_data, fixed_percpu_data) __visible;
-DECLARE_INIT_PER_CPU(fixed_percpu_data);
-
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
 #ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b5b1d95b1399..a7792479ebe1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2059,10 +2059,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
 EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
-DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
-		     fixed_percpu_data) __aligned(PAGE_SIZE) __visible;
-EXPORT_PER_CPU_SYMBOL_GPL(fixed_percpu_data);
-
 static void wrmsrl_cstar(unsigned long val)
 {
 	/*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 57a83fb2d8a0..efa4885060b5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -488,7 +488,6 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_CPU_UNRET_ENTRY
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index ef355242a8d8..3b0cfddd8b27 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -817,7 +817,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-- 
2.41.0

