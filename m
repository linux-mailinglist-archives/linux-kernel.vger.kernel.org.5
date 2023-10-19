Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323647CFD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjJSOlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbjJSOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:41:21 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F5ED7F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:11 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id ffacd0b85a97d-32da87eac93so2996129f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697726470; x=1698331270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZQaWaMMDpRzuXNNy9jw27XP1P5ogxswbyoIw1t3Xt4=;
        b=wYlX3HJSv4M5BAiaIToFrO8gL49ACGr+p6JRZGHahKem8y9TkvJJa8/KCeenosBogo
         ASDTS8+Av1785KGCSd4xXHGjcUz9A/j97FtfQRNAArCRqq1VkeVVRTjDwCXytTakPXcq
         HvGqli9E8X5Pzq19gVmTnESkni8n9l5e89aPx7tZMe67yVe1gpM8zCMt1W32yRh2att5
         5Pg0zcOnq/WGfQasBfue7UEBM0bFfNv/f8ApBIo77SuoWCHjp7WY9FHBfJAOVSlFxgLK
         ak/9cOI8+WA9rafq5ZDWg+QFrNAza3VVWDoGn/cEG8MCE6hCAWK3pjYbQeRQjJ5rFoej
         VRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726470; x=1698331270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZQaWaMMDpRzuXNNy9jw27XP1P5ogxswbyoIw1t3Xt4=;
        b=T3DC2/weKPniJc94Tt2VgzQNCcbCjEJ7mJmuB9S7zkG+b0UVeryNl6tnTGzh/TSTUH
         EPcGuibu4g5/zetuw4mIISha2qnxCMwrxFoIWSMgCcXKfuj0MAz1UDZMC12M2eHw0CND
         kd3WgO3QJTN19UIHdVgbm4CPIAX6RYA38BrzTojczZtvvo1NEuKxW+NvZLFN+gpLvWgh
         y6B1Zs37YnfLG5EGh5hUom0QYIX0CFoV+2rXb8gAhGBHKSFSIsOKUi2Qajq319Uu5ETL
         w7OZaV1/YjzIELhe3R7KROtdcd88cOKX2v/wdbposGf0eznPEgH3e4V9EydsGNTl+y82
         A3ww==
X-Gm-Message-State: AOJu0YxondQvNwuMyhnQLuDiV0ndZttdhzDrHRg+r3va9BeOqNO62KVb
        hS9gy4EMIA2y2W+D8CG+DKLUFnns/WQQvWYQXtM=
X-Google-Smtp-Source: AGHT+IHm/YPb6RDXSSOgrhEsZk0YOvHrgtDHnuFNWAhiH6G8cDKgjYCVmKppyzugBPhyHZ6uqpnOMhmCTRKSAsqjgiw=
X-Received: from seb.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:31bd])
 (user=sebastianene job=sendgmr) by 2002:a05:6000:1b08:b0:32d:6e24:79e8 with
 SMTP id f8-20020a0560001b0800b0032d6e2479e8mr20116wrz.12.1697726470227; Thu,
 19 Oct 2023 07:41:10 -0700 (PDT)
Date:   Thu, 19 Oct 2023 14:40:33 +0000
In-Reply-To: <20231019144032.2943044-1-sebastianene@google.com>
Mime-Version: 1.0
References: <20231019144032.2943044-1-sebastianene@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019144032.2943044-13-sebastianene@google.com>
Subject: [PATCH v2 11/11] arm64: ptdump: Add support for guest stage-2
 pagetables dumping
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

Register a debugfs file on guest creation to be able to view their
second translation tables with ptdump. This assumes that the host is in
control of the guest stage-2 and has direct access to the pagetables.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h | 21 +++++++--
 arch/arm64/kvm/mmu.c            |  3 ++
 arch/arm64/mm/ptdump.c          | 84 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/ptdump_debugfs.c  |  5 +-
 4 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 35b883524462..be86244d532b 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_PTDUMP_H
 #define __ASM_PTDUMP_H
 
+#include <asm/kvm_pgtable.h>
+
 #ifdef CONFIG_PTDUMP_CORE
 
 #include <linux/mm_types.h>
@@ -30,14 +32,27 @@ struct ptdump_info {
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 #ifdef CONFIG_PTDUMP_DEBUGFS
 #define EFI_RUNTIME_MAP_END	DEFAULT_MAP_WINDOW_64
-void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
+struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
+				       const char *name);
 #else
-static inline void ptdump_debugfs_register(struct ptdump_info *info,
-					   const char *name) { }
+static inline struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
+						     const char *name)
+{
+	return NULL;
+}
 #endif
 void ptdump_check_wx(void);
 #endif /* CONFIG_PTDUMP_CORE */
 
+#ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
+void ptdump_register_guest_stage2(struct kvm_pgtable *pgt, void *lock);
+void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt);
+#else
+static inline void ptdump_register_guest_stage2(struct kvm_pgtable *pgt,
+						void *lock) { }
+static inline void ptdump_unregister_guest_stage2(struct kvm_pgtable *pgt) { }
+#endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
+
 #ifdef CONFIG_DEBUG_WX
 #define debug_checkwx()	ptdump_check_wx()
 #else
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 482280fe22d7..e47988dba34d 100644
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
@@ -908,6 +909,7 @@ int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long t
 	if (err)
 		goto out_free_pgtable;
 
+	ptdump_register_guest_stage2(pgt, &kvm->mmu_lock);
 	mmu->last_vcpu_ran = alloc_percpu(typeof(*mmu->last_vcpu_ran));
 	if (!mmu->last_vcpu_ran) {
 		err = -ENOMEM;
@@ -1021,6 +1023,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	write_unlock(&kvm->mmu_lock);
 
 	if (pgt) {
+		ptdump_unregister_guest_stage2(pgt);
 		kvm_pgtable_stage2_destroy(pgt);
 		kfree(pgt);
 	}
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 4687840dcb69..facfb15468f5 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -26,6 +26,7 @@
 #include <asm/ptdump.h>
 #include <asm/kvm_pkvm.h>
 #include <asm/kvm_pgtable.h>
+#include <asm/kvm_host.h>
 
 
 enum address_markers_idx {
@@ -543,6 +544,22 @@ void ptdump_check_wx(void)
 #ifdef CONFIG_NVHE_EL2_PTDUMP_DEBUGFS
 static struct ptdump_info stage2_kernel_ptdump_info;
 
+#define GUEST_NAME_LEN	(32U)
+
+struct ptdump_registered_guest {
+	struct list_head		reg_list;
+	struct ptdump_info		info;
+	struct mm_struct		mem;
+	struct kvm_pgtable_snapshot	snapshot;
+	struct dentry			*dentry;
+	rwlock_t			*lock;
+	char				reg_name[GUEST_NAME_LEN];
+};
+
+static LIST_HEAD(ptdump_guest_list);
+static DEFINE_MUTEX(ptdump_list_lock);
+static u16 guest_no;
+
 static phys_addr_t ptdump_host_pa(void *addr)
 {
 	return __pa(addr);
@@ -740,6 +757,73 @@ static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 
 	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
 }
+
+static void guest_stage2_ptdump_walk(struct seq_file *s,
+				     struct ptdump_info *info)
+{
+	struct kvm_pgtable_snapshot *snapshot = info->priv;
+	struct ptdump_registered_guest *guest;
+
+	guest = container_of(snapshot, struct ptdump_registered_guest,
+			     snapshot);
+	read_lock(guest->lock);
+	stage2_ptdump_walk(s, info);
+	read_unlock(guest->lock);
+}
+
+void ptdump_register_guest_stage2(struct kvm_pgtable *pgt, void *lock)
+{
+	struct ptdump_registered_guest *guest;
+	struct dentry *d;
+
+	if (pgt == NULL || lock == NULL)
+		return;
+
+	guest = kzalloc(sizeof(struct ptdump_registered_guest), GFP_KERNEL);
+	if (!guest)
+		return;
+
+	memcpy(&guest->snapshot.pgtable, pgt, sizeof(struct kvm_pgtable));
+	guest->info = (struct ptdump_info) {
+		.ptdump_walk		= guest_stage2_ptdump_walk,
+		.priv			= &guest->snapshot
+	};
+
+	mutex_init(&guest->info.file_lock);
+	guest->lock = lock;
+	mutex_lock(&ptdump_list_lock);
+	snprintf(guest->reg_name, GUEST_NAME_LEN,
+		 "%u_guest_stage2_page_tables", guest_no++);
+	d = ptdump_debugfs_register(&guest->info, guest->reg_name);
+	if (!d) {
+		mutex_unlock(&ptdump_list_lock);
+		goto free_entry;
+	}
+
+	guest->dentry = d;
+	list_add(&guest->reg_list, &ptdump_guest_list);
+	mutex_unlock(&ptdump_list_lock);
+	return;
+
+free_entry:
+	kfree(guest);
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
+			debugfs_remove(guest->dentry);
+			kfree(guest);
+			break;
+		}
+	}
+	mutex_unlock(&ptdump_list_lock);
+}
 #endif /* CONFIG_NVHE_EL2_PTDUMP_DEBUGFS */
 
 static void __init ptdump_register_host_stage2(void)
diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 14619452dd8d..356753e27dee 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -49,7 +49,8 @@ static const struct file_operations ptdump_fops = {
 	.release	= ptdump_release,
 };
 
-void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name)
+struct dentry *ptdump_debugfs_register(struct ptdump_info *info,
+				       const char *name)
 {
-	debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
+	return debugfs_create_file(name, 0400, NULL, info, &ptdump_fops);
 }
-- 
2.42.0.655.g421f12c284-goog

