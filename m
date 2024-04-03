Return-Path: <linux-kernel+bounces-129906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BE8971E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC87628E0D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7350A1494B5;
	Wed,  3 Apr 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDQIQFCO"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B8148FE2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152930; cv=none; b=CZON1c9SZ6+QMdIJMFZqrPTGUo7CGiYxfCjDTFmU7M11tL9LYpDDVrG9UmY9fIeI8BPQYS8OqCAG13dBVRk0AT+88TT1/TcyDXDhoKS1k/PV+pieJrmT2gDqfKyKxrJY0f9Zq0/yx9lvvH79IsEp1RiEc8zBIZGRA4+4rJBYev0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152930; c=relaxed/simple;
	bh=Y5Dn9Fd4EB4EWBfI88YVSh04hMDr/aGsoMsXck1I/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPHzyGG4ZlylHIe9CCA+/un2QAQs5zKzS1dIqGQJBRAQ1BJYCptZPNnZM1FyFNU3jEeioBvNvnHAMFkE1h7b1wCS2JUH3z8WWU4BoNUBgkqNutUN11ZV89YTxFbifzq3rKAqgQaDcUoZK9s3GfZU0rR4Yp7lubfLpnNVU5E5ScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDQIQFCO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4950326a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712152928; x=1712757728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+OWKGCRxxuHkjgq8bKkM7MPiUiZxEk5XhM7XokHDRk=;
        b=WDQIQFCOe+aovShjgkumNfvRIMNibeWHsEh6PnhoJYW+2SiIlFluNBeBbnGGnRCcvf
         MjjiFjQMPbF4iBSoK3cEVvzQrzoBf4eYZzlk6Ut+aU5mNogxS1ApIOIT/QZEL4nLA7J2
         VwO/fqXUOx99a0/AlQCLAl1Oz1IDc1NZ2T70fDjmL6stolek63UZ4329EVMSO2IuUro4
         aEe9KGGEedtvUkGp6MR/9ELxmSGq1RYFKMdd1taP4jqY0vpsMX/kGYTMiV9yGuok8Nti
         0ZRhTLCxpS897sFY2Mpp7xlk+8L16Png3Ms0WUkQE6ue+MUs3lssF3MNwAZL34tTccmP
         qnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712152928; x=1712757728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+OWKGCRxxuHkjgq8bKkM7MPiUiZxEk5XhM7XokHDRk=;
        b=BOZD/5H2TNkATLj8AO/e7jQX2kuBuS3cz2VWgQlZfCb1U60FtCmGsvmc9Y05nG+Fef
         mgn5KW8AlFMUSuciGNCfCE/rT7O3Ed+Uix7EGNe37H64vgw3SDYarHTzDn3GZ5iZFEpa
         uWPSREIlq0qRvLGgIZ+DIyiMfoyAQl2P/0SFj+YRzAukBQAmYkW+A0hBbTOekvoW1v+a
         44lbfpq8ge4r8zjCF5hd/mTsX3SUZsCkTq4OdyjGTWsAoBD6TmuI09dJDHsNaBEG2gzs
         4uek6YEePLcZkW7jzc5Iiuz+VVLYBeO83cGjIp+j8Fl1sKAeIuf+D3p97RND2bZ+odOA
         Qr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXprjn/nEnfRFMoJzzAlhVAMZoZj947ovz7ShHGJ8C11G7nKjDw0KDrZTsfiM1Tdy9eiV/hbmvrylcbf4k0zyYz++K/mXfeONjyJ0Wi
X-Gm-Message-State: AOJu0YxU7QO6Uk6ke4AFonmCQ6hAGTEhZNh/Oc83N4YBSGDSruLSMcbo
	qaTxfR9I/5UBdLjr1K2eSSF8AZjtOppXTe2Mqh95YHjxh6HWEK3G
X-Google-Smtp-Source: AGHT+IGYKadsQ+KkVMxA7y6AiiAReUeV+Bib8nq5elmQzHuPu7Qphz9GfV9eiUAo+J/9nU0Zg+ZdeA==
X-Received: by 2002:a17:90b:11d2:b0:2a2:7a00:f101 with SMTP id gv18-20020a17090b11d200b002a27a00f101mr2301093pjb.47.1712152928305;
        Wed, 03 Apr 2024 07:02:08 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id o2-20020a17090a168200b002a0383de8cfsm12625669pja.38.2024.04.03.07.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:02:07 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/fpu: Allow nested in-kernel use of FPU
Date: Wed,  3 Apr 2024 22:01:32 +0800
Message-ID: <20240403140138.393825-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a softirq preempts a task which has kernel FPU in-use, it's not
allowed to use FPU in current implementation. This has performance
drawbacks, e.g. on SIMD crypto algs.

To enable nested in-kernel use of FPU, the preempting softirq or hardirq
saves kernel FPU state to a per-cpu variable when entering
(kernel_fpu_begin_mask) nested FPU section and restores it on exit
(kernel_fpu_end).

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---

We observed a performance drop when testing IPSec AES crypto with aesni driver.
When FPU is not available in softirq, crypto_simd puts the cipher to async mode
in cryptd, causing throughput drop from ~600Mbps to ~200Mbps on our testbox.
And it couldn't recover from this state until the queue gets drained. This
patch is intended to improve the performance in such cases.

Referenced implementation for arm64, see

    aefbab8e77eb ("arm64: fpsimd: Preserve/restore kernel mode NEON at context switch")

The main difference is that FPU is allowed in hardirq on x86, and FPU context
is saved in per-cpu variables so not to bother with task_struct.

 arch/x86/kernel/fpu/core.c | 49 ++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 520deb411a70..7f21e70fcceb 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -43,9 +43,15 @@ struct fpu_state_config fpu_user_cfg __ro_after_init;
  */
 struct fpstate init_fpstate __ro_after_init;
 
-/* Track in-kernel FPU usage */
+/*
+ * Task can be preempted by softirq or hardirq even when kernel FPU is in use.
+ * The flag in_kernel_fpu tracks such nestable kernel FPU usage.
+ */
 static DEFINE_PER_CPU(bool, in_kernel_fpu);
 
+/* Save/restore fpstate when beginning/ending a nested kernel FPU section. */
+static DEFINE_PER_CPU(struct fpu, kernel_fpu);
+
 /*
  * Track which context is using the FPU on the CPU:
  */
@@ -60,10 +66,6 @@ bool irq_fpu_usable(void)
 	if (WARN_ON_ONCE(in_nmi()))
 		return false;
 
-	/* In kernel FPU usage already active? */
-	if (this_cpu_read(in_kernel_fpu))
-		return false;
-
 	/*
 	 * When not in NMI or hard interrupt context, FPU can be used in:
 	 *
@@ -423,14 +425,28 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 	preempt_disable();
 
 	WARN_ON_FPU(!irq_fpu_usable());
-	WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
 
-	this_cpu_write(in_kernel_fpu, true);
+	if (this_cpu_read(in_kernel_fpu)) {
+		struct fpu *fpu = this_cpu_ptr(&kernel_fpu);
+
+		/* Cannot be preempted when kernel FPU is in use. */
+		WARN_ON_ONCE(in_task());
+
+		if (unlikely(!fpu->fpstate))
+			fpstate_reset(fpu);
 
-	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
-	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-		save_fpregs_to_fpstate(&current->thread.fpu);
+		/* Save kernel FPU state begin nested FPU section. */
+		save_fpregs_to_fpstate(fpu);
+	} else {
+		fpregs_lock();
+		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
+		    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
+			set_thread_flag(TIF_NEED_FPU_LOAD);
+			save_fpregs_to_fpstate(&current->thread.fpu);
+		}
+		if (in_task())
+			this_cpu_write(in_kernel_fpu, true);
+		fpregs_unlock();
 	}
 	__cpu_invalidate_fpregs_state();
 
@@ -445,9 +461,16 @@ EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
 
 void kernel_fpu_end(void)
 {
-	WARN_ON_FPU(!this_cpu_read(in_kernel_fpu));
+	/*
+	 * When returning from nested kernel FPU section, restore previously
+	 * saved fpstate.
+	 */
+	if (!in_task() && this_cpu_read(in_kernel_fpu))
+		restore_fpregs_from_fpstate(this_cpu_ptr(&kernel_fpu)->fpstate,
+					    XFEATURE_MASK_FPSTATE);
+	else
+		this_cpu_write(in_kernel_fpu, false);
 
-	this_cpu_write(in_kernel_fpu, false);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.44.0


