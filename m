Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E317EC980
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKORRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbjKORRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE44D41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a541b720aso8346234276.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068628; x=1700673428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQSSCNEgEIVwDuGH6x1IyDnQkcpfK9nBZRdIMr0v9JQ=;
        b=Qu3DLHb3ouHpCg8U+1oU+w8cAfai7IpygHBgCzatM4m0rI3MWezdGkBtvFq35ziLkU
         9aEHW+L753bqjWflWVZqVVR/khUcKv4g//0CtIw9ONMd6W0BYiQIDZKf7hD0LTbN/UZZ
         7wfOe5Kkxt251KoHYKJILmE7RV2EuYGp1LpfZ4NxSnvrE9Luw6FTU/i/ob6YyDskb62j
         e3+zY3qxz4DeK4Y1UyUJgTwzOBWvPX/jNeEhEqgJsCDKrDoG+FkGfgh8PNQsXqWJIs4X
         h2tEpxt6nZcpvTNK/x7SYm9AK7OeVJDEX4eGGctIR6f6/Z2eP5pOCalLVUBEapbsR4+O
         N1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068628; x=1700673428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQSSCNEgEIVwDuGH6x1IyDnQkcpfK9nBZRdIMr0v9JQ=;
        b=G8Q8MeWVeBS+vsdx4StiIKfyu5c6Enovp94m2+rLCZI86mWW50ec6XZYv1jXABkXqg
         pJfcu3eVKD6WpYUV6vIov0L+YDi20U4gXB4IMWxA4Ea1mQjs+OZteB1G9z1wou3eLs5x
         HwmJMrV2fgdv8aMS7tVmauT+TnPdTYw2RKlcAfp3ay+bRzdn2m/AytMkuTzrATTu1B5c
         yLDRMGg0lAgceEmIqmbXhkx+HmD/WYD94PLG6D0UHXnEDusWLI7WgfIGiNbNoKBiSYzH
         GYdnImqarT7TNacko1+HfU1G6hKGoKKpuNiaVxY+bt32nOe+uLufi4ulPLoiWKf0fwk2
         j//A==
X-Gm-Message-State: AOJu0Yxe3A/+pQQfyRAQvvJJpjSLGan5XBFUJtnRnE+eDhYeoVP2WH6B
        VytYiVaI/u0qS086a77I29bzx+CR0fHRJG6qLt0=
X-Google-Smtp-Source: AGHT+IErn3bzCF0DX9XJB6QzS6DBzs7DLSSORQ60b11cbij8ap/mm1M6uedlPRtG3MZC6j1NjkHThkYCWTUAznPoE6k=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:4:b0:d9a:68de:16a1 with SMTP
 id l4-20020a056902000400b00d9a68de16a1mr369425ybh.0.1700068628077; Wed, 15
 Nov 2023 09:17:08 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:36 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-8-sebastianene@google.com>
Subject: [PATCH v3 06/10] arm64: ptdump: Register a debugfs entry for the host
 stage-2 tables
From:   Sebastian Ene <sebastianene@google.com>
To:     will@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
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
 arch/arm64/include/asm/ptdump.h |  12 +++
 arch/arm64/kvm/Kconfig          |  13 +++
 arch/arm64/kvm/arm.c            |   2 +
 arch/arm64/mm/ptdump.c          | 168 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/ptdump_debugfs.c  |   8 +-
 5 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 9b2bebfcefbe..de5a5a0c0ecf 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -22,6 +22,7 @@ struct ptdump_info {
 	void (*ptdump_walk)(struct seq_file *s, struct ptdump_info *info);
 	int (*ptdump_prepare_walk)(void *file_priv);
 	void (*ptdump_end_walk)(void *file_priv);
+	size_t				mc_len;
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
@@ -33,13 +34,24 @@ struct ptdump_info_file_priv {
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+void ptdump_debugfs_kvm_register(struct ptdump_info *info, const char *name,
+				 struct dentry *d_entry);
 #else
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
+static inline void ptdump_debugfs_kvm_register(struct ptdump_info *info,
+					       const char *name,
+					       struct dentry *d_entry) { }
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_PTDUMP_CORE */
 
+#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
+void ptdump_register_host_stage2(void);
+#else
+static inline void ptdump_register_host_stage2(void) { }
+#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
+
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()	ptdump_check_wx()
 #else
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 83c1e09be42e..cf5b7f06b152 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -71,4 +71,17 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config PTDUMP_STAGE2_DEBUGFS
+	bool "Present the stage-2 pagetables to debugfs"
+	depends on NVHE_EL2_DEBUG && PTDUMP_DEBUGFS && KVM
+	default n
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
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e5f75f1f1085..987683650576 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -28,6 +28,7 @@
 
 #include <linux/uaccess.h>
 #include <asm/ptrace.h>
+#include <asm/ptdump.h>
 #include <asm/mman.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
@@ -2592,6 +2593,7 @@ static __init int kvm_arm_init(void)
 	if (err)
 		goto out_subs;
 
+	ptdump_register_host_stage2();
 	kvm_arm_initialised = true;
 
 	return 0;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index d531e24ea0b2..0b4cb54e43ff 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -24,6 +24,9 @@
 #include <asm/memory.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
+#include <asm/kvm_pkvm.h>
+#include <asm/kvm_pgtable.h>
+#include <asm/kvm_host.h>
 
 
 enum address_markers_idx {
@@ -378,6 +381,170 @@ void ptdump_check_wx(void)
 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
 }
 
+#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
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
+static int stage2_ptdump_prepare_walk(void *file_priv)
+{
+	struct ptdump_info_file_priv *f_priv = file_priv;
+	struct ptdump_info *info = &f_priv->info;
+	struct kvm_pgtable_snapshot *snapshot;
+	int ret, pgd_index, mc_index, pgd_pages_sz;
+	void *page_hva;
+	phys_addr_t pgd;
+
+	snapshot = alloc_pages_exact(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
+	if (!snapshot)
+		return -ENOMEM;
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
+	if (!snapshot->pgd_hva) {
+		ret = -ENOMEM;
+		goto unshare_snapshot;
+	}
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
+		if (!page_hva) {
+			ret = -ENOMEM;
+			goto free_memcache_pages;
+		}
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
+	f_priv->file_priv = snapshot;
+	return 0;
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
+	f_priv->file_priv = NULL;
+	return ret;
+}
+
+static void stage2_ptdump_end_walk(void *file_priv)
+{
+	struct ptdump_info_file_priv *f_priv = file_priv;
+	struct kvm_pgtable_snapshot *snapshot = f_priv->file_priv;
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
+	f_priv->file_priv = NULL;
+}
+
+void ptdump_register_host_stage2(void)
+{
+	if (!is_protected_kvm_enabled())
+		return;
+
+	stage2_kernel_ptdump_info = (struct ptdump_info) {
+		.mc_len			= host_s2_pgtable_pages(),
+		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
+		.ptdump_end_walk	= stage2_ptdump_end_walk,
+	};
+
+	ptdump_debugfs_kvm_register(&stage2_kernel_ptdump_info,
+				    "host_stage2_page_tables",
+				    kvm_debugfs_dir);
+}
+#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
+
 static int __init ptdump_init(void)
 {
 	address_markers[PAGE_END_NR].start_address = PAGE_END;
@@ -386,6 +553,7 @@ static int __init ptdump_init(void)
 #endif
 	ptdump_initialize();
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
+
 	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 3bf5de51e8c3..4821dbef784c 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -68,5 +68,11 @@ static const struct file_operations ptdump_fops = {
 
 void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
+	ptdump_debugfs_kvm_register(info, name, NULL);
+}
+
+void ptdump_debugfs_kvm_register(struct ptdump_info *info, const char *name,
+				 struct dentry *d_entry)
+{
+	debugfs_create_file(name, 0400, d_entry, info, &ptdump_fops);
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog

