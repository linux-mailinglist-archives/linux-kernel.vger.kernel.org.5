Return-Path: <linux-kernel+bounces-111820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDD6887152
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C220EB23ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65D1605DD;
	Fri, 22 Mar 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX44u9Et"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DAF605C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126382; cv=none; b=KpnVpTp71CHM689eGsN5By9yBFoMR6BkURHdEgpnrE8c01pKoddPGoXyMUYG+pwVGQ1Qqz9WftfJ4wGxncRGsvOBndPWlCJGn3Hdr6HFOA0uO+Yah1Tyw9KcVTqDo1fWmQ7MYJAIjnZsGFR87vAXqOZpd25pE8gypkrKC4oAN6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126382; c=relaxed/simple;
	bh=avYapo0EFqaCq2WtjSTlPyiOsoi1q9qa0+9WdAJqEy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqcwna5OBLfOi4XGWEs2Ay7swd5zB3U7WElCtu62u50ykVJjQtb4tZW8KpO3hGeWt+bIQC7WNxwkZ8bjp6X54zRXGlhWCYbJobKuJ4cKX2YUcebpnDm1yxa8bC9mvVdm2k0uyy1S8kz2GlzHrI3MmqajyFufnQEhz6BqiqB+0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX44u9Et; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a2093cd44so187344485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126379; x=1711731179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0pfakbWaglqIoATRtXvgwUhPasnZ0G2B+uvX65Dwq4=;
        b=bX44u9Et+WQQ7YgLCEFOZZZx3mljnf8qoMXBkacOQwBYKDm5hr+RnN0VY/3dPrj3Qm
         PA7OR7bUSGvVB0YDOWOSnCAeAHXWbZ1pfEX3iXGd4YH/mC8bdUAy6kbOZLc11QdcY7Xz
         UqYV1pBsAhg2tMc1ZjJ4YCmTm+JuUeBY2AxdpIz9Xxfg6GtOmp+n/w3aT89kk8UZq6Rc
         GuwmbC5vrs2d1hVn4u+G6OmrhELZMHNQobn/p4bKv7rkZiEGuKiJJ0t9VrHjKr5E8H7D
         I9vtiOGgN8rvu9yI4IIye3fZ2xnQ9qHsW4mXsLC8bniI08Osg/Uug7YJPwP8ntkRFsMM
         Ntqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126379; x=1711731179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0pfakbWaglqIoATRtXvgwUhPasnZ0G2B+uvX65Dwq4=;
        b=k192oLZILwXI6n10hjrVr1g20ERQwt6PLBTc8VtUJUvQCO1mFw0EPkEZhKV/dp8E21
         LANlOw6tf4Wvo9cvqA8YWf+JQnk+fT038GlVORWOzil2VI8+1mOVTSXolaBvYTsJ9wYm
         bYbhNsEdRrtb1oSfBHDKEpv+jGoofbjhIO3nc5NqYZOSecYhzZVCx0A96uVwHnyrMuNc
         SGrspNfFjG5NwKuFbx/5ABDaRt1dQmIz2aEGALyJljAuXz7TKTywl0ZCRNbPBfkFyPFR
         YDeL2RXxz5PEewhME6IDtKbZ4J0FlLGL/yvYnPn31EySoNBpcOzilTO2dnoaoogbM6UY
         coEw==
X-Gm-Message-State: AOJu0YwePNK29HuuR3M9O1AcHOYNUtKTiQFwXpjMcmyJfK+zE3AXzUnt
	txaxoL2Zjocnc7sPmziLeMSn2JO4qCC8UZFCmUp64H1emCJBVCxGIYeYWsU=
X-Google-Smtp-Source: AGHT+IF0AAdlE4uIoVz7sxvN8rbXVr8QSHh1wK0otrEBF/dPfTo3pmBesRKuaCdH27sU11LYp/AlUQ==
X-Received: by 2002:a05:620a:a1d:b0:789:d43b:3702 with SMTP id i29-20020a05620a0a1d00b00789d43b3702mr2598412qka.59.1711126379139;
        Fri, 22 Mar 2024 09:52:59 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:58 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 10/16] x86/percpu/64: Remove fixed_percpu_data
Date: Fri, 22 Mar 2024 12:52:27 -0400
Message-ID: <20240322165233.71698-11-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 40d6add8ff31..1f15a7bee876 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -386,14 +386,6 @@ struct irq_stack {
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
index f49e8f5b858d..395a8831d507 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1997,10 +1997,6 @@ EXPORT_PER_CPU_SYMBOL(pcpu_hot);
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
index 0b152f96c24e..667202ebd37f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -473,7 +473,6 @@ SECTIONS
  */
 #define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
-INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 016650ddaf7f..65e6f3d6d890 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -834,7 +834,6 @@ static void percpu_init(void)
  *	__per_cpu_load
  *
  * The "gold" linker incorrectly associates:
- *	init_per_cpu__fixed_percpu_data
  *	init_per_cpu__gdt_page
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-- 
2.44.0


