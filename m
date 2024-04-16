Return-Path: <linux-kernel+bounces-146583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD68A679C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E889BB22FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E73126F03;
	Tue, 16 Apr 2024 10:02:35 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74918664C;
	Tue, 16 Apr 2024 10:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261754; cv=none; b=NweeCxB1PezywmQV43LRPCbQoRs6DJ3ZgXIPLuV1bEzu999o/EeU1in0W2nE/fA8NFsvZPtJYfvRA63nzmNp7LKweFFAFbbFfi2keSujbzW79Q6DEKRmJ791Boc4kHWlNf3aJl9Ah7g2yAepDlph7PA4ErGFmPSXTFfNVdeuACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261754; c=relaxed/simple;
	bh=apbdStBkpWbe9AW+IH08+glDBEysUgLIAGoqEQX+quQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP808350J3QJi/RTVOiiEBvdUeJNtxsStGyXw9BWIjuOzGU56R+CT3HVSoTuzpOyOveLmO5WuvMs2Vhzg2GkAUQYOJVx17ajqLifBgoKxLqkwN4cjxOJxk5HMbL8GXIL2yIhIbL0Gf/kn6fmjWCTl/mNTflT7M8TNmKcOOd0j2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9AD7D40E02A5;
	Tue, 16 Apr 2024 10:02:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JmD6dkakvZkF; Tue, 16 Apr 2024 10:02:19 +0000 (UTC)
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA5E640E00B2;
	Tue, 16 Apr 2024 10:02:11 +0000 (UTC)
Date: Tue, 16 Apr 2024 12:02:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 01/16] x86/mce: Define mce_setup() helpers for common
 and per-CPU fields
Message-ID: <20240416100206.GEZh5MnlDJMeaERfQ5@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404151359.47970-2-yazen.ghannam@amd.com>

On Thu, Apr 04, 2024 at 10:13:44AM -0500, Yazen Ghannam wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index b5cc557cfc37..7a857b33f515 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -117,20 +117,32 @@ static struct irq_work mce_irq_work;
>   */
>  BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
>  
> -/* Do initial initialization of a struct mce */
> -void mce_setup(struct mce *m)
> +void mce_setup_common(struct mce *m)

Since we're touching this...

mce_setup() is a perfectly wrong name for what it does. So let's clean
it up. Diff ontop below.

* mce_prep_record() - the name says what the function does.

* mce_prep_record_per_cpu() - "per_cpu" as this is a common kernel
concept and we do use per_cpu data in there.

Please do this in two patches:

- the first one renames mce_setup() only without adding the additional
  functionality

- the second one does the split

Thx.

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dfd2e9699bd7..491f3d78c46a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,7 +221,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-void mce_setup(struct mce *m);
+void mce_prep_record(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..14bf8c232e45 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -780,7 +780,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.status = status;
 	m.misc   = misc;
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309ff67d0..8f509c8a4e98 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -44,7 +44,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
@@ -97,7 +97,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.extcpu = -1;
 	m.socketid = -1;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c0ce2de7fb51..a89508327b0d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -117,7 +117,7 @@ static struct irq_work mce_irq_work;
  */
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
-void mce_setup_common(struct mce *m)
+void mce_prep_record_common(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 
@@ -128,21 +128,21 @@ void mce_setup_common(struct mce *m)
 	m->time		= __ktime_get_real_seconds();
 }
 
-void mce_setup_for_cpu(unsigned int cpu, struct mce *m)
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m)
 {
-	m->cpu			= cpu;
-	m->extcpu		= cpu;
-	m->apicid		= cpu_data(m->extcpu).topo.initial_apicid;
-	m->microcode		= cpu_data(m->extcpu).microcode;
-	m->ppin			= cpu_data(m->extcpu).ppin;
-	m->socketid		= cpu_data(m->extcpu).topo.pkg_id;
+	m->cpu		= cpu;
+	m->extcpu	= cpu;
+	m->apicid	= cpu_data(m->extcpu).topo.initial_apicid;
+	m->microcode	= cpu_data(m->extcpu).microcode;
+	m->ppin		= cpu_data(m->extcpu).ppin;
+	m->socketid	= cpu_data(m->extcpu).topo.pkg_id;
 }
 
 /* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+void mce_prep_record(struct mce *m)
 {
-	mce_setup_common(m);
-	mce_setup_for_cpu(smp_processor_id(), m);
+	mce_prep_record_common(m);
+	mce_prep_record_per_cpu(smp_processor_id(), m);
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
@@ -448,11 +448,11 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
 	/*
-	 * Enable instrumentation around mce_setup() which calls external
+	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
 	 */
 	instrumentation_begin();
-	mce_setup(m);
+	mce_prep_record(m);
 	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e86e53695828..43c7f3b71df5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -261,8 +261,8 @@ enum mca_msr {
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
-void mce_setup_common(struct mce *m);
-void mce_setup_for_cpu(unsigned int cpu, struct mce *m);
+void mce_prep_record_common(struct mce *m);
+void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

