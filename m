Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41517EC985
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjKORRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjKORRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:30 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DA11B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:19 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9e5e190458dso38646566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068637; x=1700673437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrwZCdoLZEaizVhQil7JgumATiKs+C+flcugI0w/XAk=;
        b=ilaHSqDQ5bh0Ymcf6aEog7jgYtJflF17F5Juuav/YzOzQEn1y7Z5C/2bDzQPbsgFWD
         TXapbLxAth4ruLN5P7kBZezRU5Io6lMb83N+ed/48kKSNCRvq0PM65DWNTzTOvQSpkWA
         6vu7ftwE6fOnLXU9VfdHFQeZgfSTnn8oBVFGRG1XkO1yaPN39pOaZLqK3Z/ut3kXoLqe
         1LEFbKSxPsZsgcGV/dQcoNboMiwqdgHq4v+ELt0akb6HQTfVISixxyq3nS+HKRRzcwiW
         /G2sTi4GR5YT9x0zZWzuK1knRARU5TLSwRn6iwD60h6PBCSNchMXObMGKEf2jTyU/FaZ
         a79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068637; x=1700673437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrwZCdoLZEaizVhQil7JgumATiKs+C+flcugI0w/XAk=;
        b=oKG8Yyovtcde3w8zPgvDZUSZJ4Wn76dltr8kCSSoLRsVmtiKqFMWao+lp8wlqWdXCP
         9OI4tkb3pHGtziY0PoQs1dJSDOrrpavXuQFYGtV1xwl2hqAfRpiu8clc9ZpmdPzp1WPR
         wVwFfZfJ2xjcUju9IkL/UBRWSEO/tvHcoSn5pDhCMmO3dg7//bUysCgKzRVY7Ie3OVk9
         RBZLuXiQUdRHbdZwd8pJNCjDfANvNQpwpwPtp9RcBQcDWuYN/iFGoTJmwPSGhPyBYnXf
         SKgdsiC3tX91PUfqLz8EmT24/eCjLroAxf/wXEz0nfFd6gjXt3c+EV+8ke7QIF1dybOk
         z5hw==
X-Gm-Message-State: AOJu0YzrEw+Wag1KmSxd18KBNosEMZoCQ1Gu8EKFv/9uf//Nil+lMjTU
        QMPVGCR7qgohNXqn0kESrgrDxjqbU9O/WyX2Mjs=
X-Google-Smtp-Source: AGHT+IEfryolzdoKiOEYL1phXIKFgud/D2FyZuB7+BdH9E+NUl2GoRL9m1zLD32m+IOZddXrx7GWlUokfDnIsB2IKDc=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a17:906:a00f:b0:9f3:6556:bc79 with
 SMTP id p15-20020a170906a00f00b009f36556bc79mr19663ejy.0.1700068637537; Wed,
 15 Nov 2023 09:17:17 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:40 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-12-sebastianene@google.com>
Subject: [PATCH v3 10/10] arm64: ptdump: Add support for guest stage-2
 pagetables dumping
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a debugfs file on guest creation to be able to view their
second translation tables with ptdump. This assumes that the host is in
control of the guest stage-2 and has direct access to the pagetables.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  7 ++++
 arch/arm64/kvm/debug.c          |  6 +++
 arch/arm64/kvm/mmu.c            |  2 +
 arch/arm64/mm/ptdump.c          | 68 +++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index de5a5a0c0ecf..21b281715d27 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_PTDUMP_H
 #define __ASM_PTDUMP_H
 
+#include <asm/kvm_pgtable.h>
+
 #ifdef CONFIG_PTDUMP_CORE
 
 #include <linux/mm_types.h>
@@ -23,6 +25,7 @@ struct ptdump_info {
 	int (*ptdump_prepare_walk)(void *file_priv);
 	void (*ptdump_end_walk)(void *file_priv);
 	size_t				mc_len;
+	void				*priv;
 };
 
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
@@ -48,8 +51,12 @@ void ptdump_check_wx(void);
 
 #ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
 void ptdump_register_host_stage2(void);
+int ptdump_register_guest_stage2(struct kvm *kvm);
+void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt);
 #else
 static inline void ptdump_register_host_stage2(void) { }
+static inline int ptdump_register_guest_stage2(struct kvm *kvm) { return 0; }
+static inline void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt) { }
 #endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
 
 #ifdef CONFIG_DEBUG_WX
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..555d022f8ad9 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -13,6 +13,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
+#include <asm/ptdump.h>
 
 #include "trace.h"
 
@@ -342,3 +343,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 }
+
+int kvm_arch_create_vm_debugfs(struct kvm *kvm)
+{
+	return ptdump_register_guest_stage2(kvm);
+}
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d87c8fcc4c24..da45050596e6 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <trace/events/kvm.h>
 #include <asm/pgalloc.h>
+#include <asm/ptdump.h>
 #include <asm/cacheflush.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
@@ -1021,6 +1022,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	write_unlock(&kvm->mmu_lock);
 
 	if (pgt) {
+		ptdump_unregister_guest_stage2(pgt);
 		kvm_pgtable_stage2_destroy(pgt);
 		kfree(pgt);
 	}
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index ffb87237078b..741764cff105 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -27,6 +27,7 @@
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_pgtable.h>
 #include <asm/kvm_host.h>
+#include <asm/kvm_mmu.h>
 
 
 enum address_markers_idx {
@@ -519,6 +520,16 @@ void ptdump_check_wx(void)
 #ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
 static struct ptdump_info stage2_kernel_ptdump_info;
 
+struct ptdump_registered_guest {
+	struct list_head		reg_list;
+	struct ptdump_info		info;
+	struct kvm_pgtable_snapshot	snapshot;
+	rwlock_t			*lock;
+};
+
+static LIST_HEAD(ptdump_guest_list);
+static DEFINE_MUTEX(ptdump_list_lock);
+
 static phys_addr_t ptdump_host_pa(void *addr)
 {
 	return __pa(addr);
@@ -757,6 +768,63 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
 }
 
+static void guest_stage2_ptdump_walk(struct seq_file *s,
+				     struct ptdump_info *info)
+{
+	struct ptdump_info_file_priv *f_priv =
+		container_of(info, struct ptdump_info_file_priv, info);
+	struct ptdump_registered_guest *guest = info->priv;
+
+	f_priv->file_priv = &guest->snapshot;
+
+	read_lock(guest->lock);
+	stage2_ptdump_walk(s, info);
+	read_unlock(guest->lock);
+}
+
+int ptdump_register_guest_stage2(struct kvm *kvm)
+{
+	struct ptdump_registered_guest *guest;
+	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
+	struct kvm_pgtable *pgt = mmu->pgt;
+
+	guest = kzalloc(sizeof(struct ptdump_registered_guest), GFP_KERNEL);
+	if (!guest)
+		return -ENOMEM;
+
+	memcpy(&guest->snapshot.pgtable, pgt, sizeof(struct kvm_pgtable));
+	guest->info = (struct ptdump_info) {
+		.ptdump_walk		= guest_stage2_ptdump_walk,
+	};
+
+	guest->info.priv = guest;
+	guest->lock = &kvm->mmu_lock;
+	mutex_lock(&ptdump_list_lock);
+
+	ptdump_debugfs_kvm_register(&guest->info, "stage2_page_tables",
+				    kvm->debugfs_dentry);
+
+	list_add(&guest->reg_list, &ptdump_guest_list);
+	mutex_unlock(&ptdump_list_lock);
+
+	return 0;
+}
+
+void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt)
+{
+	struct ptdump_registered_guest *guest;
+
+	mutex_lock(&ptdump_list_lock);
+	list_for_each_entry(guest, &ptdump_guest_list, reg_list) {
+		if (guest->snapshot.pgtable.pgd == pgt->pgd) {
+			list_del(&guest->reg_list);
+			kfree(guest);
+			break;
+		}
+	}
+	mutex_unlock(&ptdump_list_lock);
+}
+
 void ptdump_register_host_stage2(void)
 {
 	if (!is_protected_kvm_enabled())
-- 
2.43.0.rc0.421.g78406f8d94-goog

