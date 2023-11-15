Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611887EC982
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjKORR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjKORRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:17:18 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12FD50
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:11 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b59662ff67so9158107b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 09:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700068630; x=1700673430; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCmrW40F76i5JztVQV1SbSI81TwYB1s24Z+PnC9WnV4=;
        b=AmeChbNhKTm7edLxYyybawjHEfRVGxssTYS7nlSs0KTrolwJr3y4U0YvxftxoF1w+E
         q1zfrGEezUieTaUS7jKRfH7AFh8zP5jc25bnqIouAWfrHLARh6jP8n3ndhTnu9/WK1Jc
         2j//Oarqec4ngFM1/hq54pI0KrjCYazSQ8Wn3qyw08jywLDRq9BeFLVtJp9JlnVdbS+l
         JgqTNWz6/djAsJtts0P3BpnG2XMD16NcWAaZb3lLMeq5vJtxMXadTpZuxlamnyheL87t
         hi6M2AaQyNOzjF8a7/RthaAwKQirBO+UAfx3l2MX8gvmjl7Pnroo5KoZ6C+wZ4iBS90n
         2OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700068630; x=1700673430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCmrW40F76i5JztVQV1SbSI81TwYB1s24Z+PnC9WnV4=;
        b=rUwh5SFSAYkQVoTdKI+s5OtE7wwlHDOGH6iP4AZkP5UcvB6ecEbYurMlhif30ZzgoQ
         wm5XDl0Dq7PwM0sxW5wQArQdoRKiTQ+kBcHk/WlFU7Lbs64EXDg13f3u6VXFXAmRX+WV
         wd4BCp3WWu+6fXbZAlHFURnQJrEym01hqszd89m4/iO6XsN4dM/TTXYb9WLJvwY+M1Vm
         Se33xQgBSNThiu/ANFRbt8vvjaQeb3LaUUQbwWQk/l1vrLmV0msQ/IklpiJxwdF8VR73
         HrgfR32lLkzoycDeAog0Dl0wOawzux0YNR0eaNSQSi3/VH5OJFEWY0TTwncc+auLXlr6
         bBsA==
X-Gm-Message-State: AOJu0YzqjhF0F1Bbl3M4tnEMD+BhxmWpuRBHXPB5iIB8i5sf4ss8mFHU
        3GDi9pjSM6Y8LOnV3Vf869NDo5lAcl/ijxuwSu4=
X-Google-Smtp-Source: AGHT+IELfUQoq3/g4kbIGiBRU7VsMlUAs35EiaE420fomxFsRN5Mm1Zx4hWdYOb+MaGSa4SgHhjdvgBzYWcJ8schaZk=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a0d:c046:0:b0:5be:9742:cc3e with SMTP
 id b67-20020a0dc046000000b005be9742cc3emr200344ywd.2.1700068630474; Wed, 15
 Nov 2023 09:17:10 -0800 (PST)
Date:   Wed, 15 Nov 2023 17:16:37 +0000
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20231115171639.2852644-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231115171639.2852644-9-sebastianene@google.com>
Subject: [PATCH v3 07/10] arm64: ptdump: Parse the host stage-2 page-tables
 from the snapshot
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

Add a walker function which configures ptdump to parse the page-tables
from the snapshot. Define the attributes used by the stage-2 parser and
build a description of an array which holds the name of the level.
Walk the entire address space configured in the pagetable and parse the
attribute descriptors.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/mm/ptdump.c | 157 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 0b4cb54e43ff..9f88542d5312 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -86,6 +86,7 @@ struct pg_state {
 	bool check_wx;
 	unsigned long wx_pages;
 	unsigned long uxn_pages;
+	struct ptdump_info_file_priv *f_priv;
 };
 
 struct prot_bits {
@@ -174,6 +175,66 @@ static const struct prot_bits pte_bits[] = {
 	}
 };
 
+static const struct prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN,
+		.set	= "XN",
+		.clear	= "  ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R,
+		.set	= "R",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W,
+		.set	= "W",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "FnXS",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT,
+		.val	= PTE_CONT,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW0,
+		.val	= KVM_PGTABLE_PROT_SW0,
+		.set	= "SW0", /* PKVM_PAGE_SHARED_OWNED */
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW1,
+		.val	= KVM_PGTABLE_PROT_SW1,
+		.set	= "SW1", /* PKVM_PAGE_SHARED_BORROWED */
+	}, {
+		.mask	= KVM_PGTABLE_PROT_SW2,
+		.val	= KVM_PGTABLE_PROT_SW2,
+		.set	= "SW2",
+	}, {
+		.mask   = KVM_PGTABLE_PROT_SW3,
+		.val	= KVM_PGTABLE_PROT_SW3,
+		.set	= "SW3",
+	},
+};
+
 struct pg_level {
 	const struct prot_bits *bits;
 	const char *name;
@@ -286,6 +347,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			delta >>= 10;
 			unit++;
 		}
+
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
 				   pg_info[st->level].name);
 		if (st->current_prot && pg_info[st->level].bits)
@@ -394,6 +456,11 @@ static void *ptdump_host_va(phys_addr_t phys)
 	return __va(phys);
 }
 
+static struct kvm_pgtable_mm_ops host_mmops = {
+	.phys_to_virt	=	ptdump_host_va,
+	.virt_to_phys	=	ptdump_host_pa,
+};
+
 static size_t stage2_get_pgd_len(void)
 {
 	u64 mmfr0, mmfr1, vtcr;
@@ -528,6 +595,95 @@ static void stage2_ptdump_end_walk(void *file_priv)
 	f_priv->file_priv = NULL;
 }
 
+static int stage2_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
+				 enum kvm_pgtable_walk_flags visit)
+{
+	struct pg_state *st = ctx->arg;
+	struct ptdump_state *pt_st = &st->ptdump;
+
+	pt_st->note_page(pt_st, ctx->addr, ctx->level, ctx->old);
+
+	return 0;
+}
+
+static void stage2_ptdump_build_levels(struct pg_level *level,
+				       size_t num_levels,
+				       unsigned int start_level)
+{
+	static const char * const lvl_names[] = {"PGD", "PUD", "PMD", "PTE"};
+	int i, j, name_index;
+
+	if (num_levels > KVM_PGTABLE_MAX_LEVELS && start_level > 2) {
+		pr_warn("invalid configuration %lu levels start_lvl %u\n",
+			num_levels, start_level);
+		return;
+	}
+
+	for (i = start_level; i < num_levels; i++) {
+		name_index = i - start_level;
+		name_index = name_index * start_level + name_index;
+
+		level[i].name	= lvl_names[name_index];
+		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
+		level[i].bits	= stage2_pte_bits;
+
+		for (j = 0; j < level[i].num; j++)
+			level[i].mask |= level[i].bits[j].mask;
+	}
+}
+
+static void stage2_ptdump_walk(struct seq_file *s, struct ptdump_info *info)
+{
+	struct ptdump_info_file_priv *f_priv =
+		container_of(info, struct ptdump_info_file_priv, info);
+	struct kvm_pgtable_snapshot *snapshot = f_priv->file_priv;
+	struct pg_state st;
+	struct kvm_pgtable *pgtable;
+	u64 start_ipa = 0, end_ipa;
+	struct addr_marker ipa_address_markers[3];
+	struct pg_level stage2_pg_level[KVM_PGTABLE_MAX_LEVELS] = {0};
+	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
+		.cb	= stage2_ptdump_visitor,
+		.arg	= &st,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	if (snapshot == NULL || !snapshot->pgtable.pgd)
+		return;
+
+	pgtable = &snapshot->pgtable;
+	pgtable->mm_ops = &host_mmops;
+	end_ipa = BIT(pgtable->ia_bits) - 1;
+
+	memset(&ipa_address_markers[0], 0, sizeof(ipa_address_markers));
+
+	ipa_address_markers[0].start_address = start_ipa;
+	ipa_address_markers[0].name = "IPA start";
+
+	ipa_address_markers[1].start_address = end_ipa;
+	ipa_address_markers[1].name = "IPA end";
+
+	stage2_ptdump_build_levels(stage2_pg_level, KVM_PGTABLE_MAX_LEVELS,
+				   pgtable->start_level);
+
+	st = (struct pg_state) {
+		.seq		= s,
+		.marker		= &ipa_address_markers[0],
+		.level		= -1,
+		.pg_level	= &stage2_pg_level[0],
+		.f_priv		= f_priv,
+		.ptdump		= {
+			.note_page	= note_page,
+			.range		= (struct ptdump_range[]) {
+				{start_ipa,	end_ipa},
+				{0,		0},
+			},
+		},
+	};
+
+	kvm_pgtable_walk(pgtable, start_ipa, end_ipa, &walker);
+}
+
 void ptdump_register_host_stage2(void)
 {
 	if (!is_protected_kvm_enabled())
@@ -537,6 +693,7 @@ void ptdump_register_host_stage2(void)
 		.mc_len			= host_s2_pgtable_pages(),
 		.ptdump_prepare_walk	= stage2_ptdump_prepare_walk,
 		.ptdump_end_walk	= stage2_ptdump_end_walk,
+		.ptdump_walk		= stage2_ptdump_walk,
 	};
 
 	ptdump_debugfs_kvm_register(&stage2_kernel_ptdump_info,
-- 
2.43.0.rc0.421.g78406f8d94-goog

