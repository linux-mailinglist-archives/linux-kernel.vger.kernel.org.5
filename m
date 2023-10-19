Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0897CFD15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346183AbjJSOl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346274AbjJSOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:10 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E2E12A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:02 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-325a78c806eso4096892f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726461; x=1698331261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJmkGO5U4r+mD7otVz2tQyDmcZmvcXpFwejzcRHVYpw=;
        b=WsJGL2Fswg/vOBaSm8tzcEvZ7jDyXFd/HRggbbWT7YqxQPHMllVIK88N/SfQEz9aHC
         ZumNc+IQr7fZ0RbgeUCzpTCOAGjPCF1IP2hQYEV6AuCVegvnswiydecUuq4h2Ib8Ru4C
         Z0SMFxrtxfzPyohvhCIMpuzrMYH/KML9iUX8Hi96mZPZcmFktx5Ga3ihBfj3j64VL51n
         pIF4COcMS+dIciDLaJRjVWab25/JcbYNiWrJUiN8SQ0HLZaFWEMKQcFW7TzlpohiPXVb
         VnJgZRkmN/p3AD6PR5/ReEW/admQocuoZIx544o+NQ8QtWw7jX0YcjdxFnZoZTlSmbBz
         qtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726461; x=1698331261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJmkGO5U4r+mD7otVz2tQyDmcZmvcXpFwejzcRHVYpw=;
        b=suFurHvKp/WiOwNHuH/EbwE3W33R/Cffmz1CoE6uR4eK5iReZuOI4EDhL732JDhiLD
         p9Y450bntDHC8hiGShgiNb3UDOXZ/eJqCZ6HWo2a37GGI5wyqJaZF8dG+TuvOZI0hs+G
         log6AM2mB1RSn+ldejPF1s6rshRxY90Xf/Or64emFzUDjhqcueKUhbeeAKsbTYQ515kK
         nDzj/xigxSSAE3kSXKxUqVOovxn84jiCxdtvjK4ns8HzpdASk0wk1K9ZPhWsvOCFpwep
         0qIc/82BaFRAaN0eCSXkZvhmJLWf85iCEaEPyN1bs/wZdjVpuqzJvRC55j2+vzp8zZWK
         usSQ==
X-Gm-Message-State: AOJu0Yzg9i/4jbKXCK0gjFjUZiWAAzIiMQ/vXu8ckWoRhltnL0mg1rRW
        letA1tO5Gxsswbn6aizdYdfB/QNW6N0owNX7KiI=
X-Google-Smtp-Source: AGHT+IGqbx6iYGP+EpvwEdp/BMgDhteThNohvJ4szVaFgl3qs4h1dc83XvtOMzUVKD7OB/AmSajyYG2XUK5I1qtQdXo=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a5d:4e47:0:b0:32d:d785:e457 with SMTP
 id r7-20020a5d4e47000000b0032dd785e457mr20381wrt.8.1697726460839; Thu, 19 Oct
 2023 07:41:00 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:29 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-9-sebastianene@google.com>
Subject: [PATCH v2 07/11] arm64: ptdump: Register a debugfs entry for the host
 stage-2 page-tables
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, vdonnefort@google.com, qperret@google.com,
        smostafa@google.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize a structures used to keep the state of the host stage-2 ptdump
walker when pKVM is enabled. Create a new debugfs entry for the host
stage-2 pagetables and hook the callbacks invoked when the entry is
accessed. When the debugfs file is opened, allocate memory resources which
will be shared with the hypervisor for saving the pagetable snapshot.
On close release the associated memory and we unshare it from the
hypervisor.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |   2 +
 arch/arm64/kvm/Kconfig          |  12 +++
 arch/arm64/mm/ptdump.c          | 161 ++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 88dcab1dab97..35b883524462 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -23,6 +23,8 @@ struct ptdump_info {
 	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
 	void (*ptdump_end_walk)(struct ptdump_info *info);
 	struct mutex			file_lock;
+	size_t				mc_len;
+	void				*priv;
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..4b1847704bb3 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -71,4 +71,16 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config NVHE_EL2_PTDUMP_DEBUGFS
+	bool "Present the stage-2 pagetables to debugfs"
+	depends on NVHE_EL2_DEBUG && PTDUMP_DEBUGFS && KVM
+	help
+	  Say Y here if you want to show the stage-2 kernel pagetables
+	  layout in a debugfs file. This information is only useful for kernel developers
+	  who are working in architecture specific areas of the kernel.
+	  It is probably not a good idea to enable this feature in a production
+	  kernel.
+
+	  If in doubt, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index fe239b9af50c..7c78b8994ca1 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -466,6 +466,165 @@ void ptdump_check_wx(void)
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
 
+#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
+static struct ptdump_info stage2_kernel_ptdump_info;
+
+static phys_addr_t ptdump_host_pa(void *addr)
+{
+	return __pa(addr);
+}
+
+static void *ptdump_host_va(phys_addr_t phys)
+{
+	return __va(phys);
+}
+
+static size_t stage2_get_pgd_len(void)
+{
+	u64 mmfr0, mmfr1, vtcr;
+	u32 phys_shift = get_kvm_ipa_limit();
+
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	vtcr = kvm_get_vtcr(mmfr0, mmfr1, phys_shift);
+
+	return kvm_pgtable_stage2_pgd_size(vtcr);
+}
+
+static void stage2_ptdump_prepare_walk(struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot;
+	int ret, pgd_index, mc_index, pgd_pages_sz;
+	void *page_hva;
+	phys_addr_t pgd;
+
+	snapshot = alloc_pages_exact(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!snapshot)
+		return;
+
+	memset(snapshot, 0, PAGE_SIZE);
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp, virt_to_pfn(snapshot));
+	if (ret)
+		goto free_snapshot;
+
+	snapshot->pgd_len = stage2_get_pgd_len();
+	pgd_pages_sz = snapshot->pgd_len / PAGE_SIZE;
+	snapshot->pgd_hva = alloc_pages_exact(snapshot->pgd_len,
+					      GFP_KERNEL_ACCOUNT);
+	if (!snapshot->pgd_hva)
+		goto unshare_snapshot;
+
+	for (pgd_index = 0; pgd_index < pgd_pages_sz; pgd_index++) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
+					virt_to_pfn(page_hva));
+		if (ret)
+			goto unshare_pgd_pages;
+	}
+
+	for (mc_index = 0; mc_index < info->mc_len; mc_index++) {
+		page_hva = alloc_pages_exact(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
+		if (!page_hva)
+			goto free_memcache_pages;
+
+		push_hyp_memcache(&snapshot->mc, page_hva, ptdump_host_pa);
+		ret = kvm_call_hyp_nvhe(__pkvm_host_share_hyp,
+					virt_to_pfn(page_hva));
+		if (ret) {
+			pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+			free_pages_exact(page_hva, PAGE_SIZE);
+			goto free_memcache_pages;
+		}
+	}
+
+	ret = kvm_call_hyp_nvhe(__pkvm_copy_host_stage2, snapshot);
+	if (ret)
+		goto free_memcache_pages;
+
+	pgd = (phys_addr_t)snapshot->pgtable.pgd;
+	snapshot->pgtable.pgd = phys_to_virt(pgd);
+	info->priv = snapshot;
+	return;
+
+free_memcache_pages:
+	page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	while (page_hva) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+		free_pages_exact(page_hva, PAGE_SIZE);
+		page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	}
+unshare_pgd_pages:
+	pgd_index = pgd_index - 1;
+	for (; pgd_index >= 0; pgd_index--) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+	}
+	free_pages_exact(snapshot->pgd_hva, snapshot->pgd_len);
+unshare_snapshot:
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+				  virt_to_pfn(snapshot)));
+free_snapshot:
+	free_pages_exact(snapshot, PAGE_SIZE);
+	info->priv = NULL;
+}
+
+static void stage2_ptdump_end_walk(struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	void *page_hva;
+	int pgd_index, ret, pgd_pages_sz;
+
+	if (!snapshot)
+		return;
+
+	page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	while (page_hva) {
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+		free_pages_exact(page_hva, PAGE_SIZE);
+		page_hva = pop_hyp_memcache(&snapshot->mc, ptdump_host_va);
+	}
+
+	pgd_pages_sz = snapshot->pgd_len / PAGE_SIZE;
+	for (pgd_index = 0; pgd_index < pgd_pages_sz; pgd_index++) {
+		page_hva = snapshot->pgd_hva + pgd_index * PAGE_SIZE;
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+					virt_to_pfn(page_hva));
+		WARN_ON(ret);
+	}
+
+	free_pages_exact(snapshot->pgd_hva, snapshot->pgd_len);
+	WARN_ON(kvm_call_hyp_nvhe(__pkvm_host_unshare_hyp,
+				  virt_to_pfn(snapshot)));
+	free_pages_exact(snapshot, PAGE_SIZE);
+	info->priv = NULL;
+}
+#endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
+
+static void __init ptdump_register_host_stage2(void)
+{
+#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
+	if (!is_protected_kvm_enabled())
+		return;
+
+	stage2_kernel_ptdump_info = (struct ptdump_info) {
+		.mc_len			= host_s2_pgtable_pages(),
+		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
+		.ptdump_end_walk	= stage2_ptdump_end_walk,
+	};
+
+	mutex_init(&stage2_kernel_ptdump_info.file_lock);
+
+	ptdump_debugfs_register(&stage2_kernel_ptdump_info,
+				"host_stage2_kernel_page_tables");
+#endif
+}
+
 static int __init ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
@@ -474,6 +633,8 @@ static int __init ptdump_init(void)
 #endif
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+	ptdump_register_host_stage2();
+
 	return 0;
 }
 device_initcall(ptdump_init);
-- 
2.42.0.655.g421f12c284-goog

