Return-Path: <linux-kernel+bounces-56654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00E84CD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6080D1C20A10
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17E77D3E6;
	Wed,  7 Feb 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1XFynHfn"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF427F7F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317369; cv=none; b=NMbN0VMMjdFIuyt+rZGgiPZ5Lth6Hab8zI3nGFeGyYvD9Ek57OkzPcyzQxXUJyvOmu+O49OPIkcykxCedgSgKfDQp0Vjx6sRoCE5jg5vOYlyYeQVPZsko2hW9WQ9K/YXVn373tbEVcVIHZCvb55Q3Z397cB5QKf180H+AQf36dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317369; c=relaxed/simple;
	bh=WW5SKAuytyWeorL93MuaOawok6QGUPzmoldTAJow+n4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZLxF/Ws+RrBG2BsAACsFhxb70OXcVln13TSDJ6bhn5pJcu3FORsFS7IQHqtY2To3LR4uu7HLHNZ2rxU8S/3r8EmdCkDXFDI+Pbl0mvbdB6uoCPhMdNZlF6I6BhNzj9ZFXq0eOZvP7Chb5j/roOLePlah7DJQArzY8ygdrSSAqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1XFynHfn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41024549a9fso725305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707317366; x=1707922166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hjt2/pLXLGVmY8in0C2dCgK4OmxemqDeWqGIHoWM86A=;
        b=1XFynHfn3hb7oLspH/59RWg6bFRAZK5eOySp/R6iCuGWxuQ4kEEIE1E0wl24aQmvYz
         ljAtYwaUQmLg8udyxzpTKpMx3hlFQ0lG9zb3MGuCPWlN5zLkrhHL9t+/tCfuzYg1by31
         4vTwj2nwPtO6zZ8XHR0S1PT9RyjTq4mQbZ3JO+s1mqFXEYnUgaLGpn14JxdEFODTRHjf
         WbjrEr7MBYxrzgRPv7sLWRLHW85am8QgzJnOuaT98fF+cw6IMGhAUdPj+Xb5JJlRklQ1
         FHImrrZ400LAnUI7xVPqQ2x+f4dD8aJUwYGSYCdKYyMq70tsiFrbbGH8V9b8CwNBioHc
         scyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317366; x=1707922166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hjt2/pLXLGVmY8in0C2dCgK4OmxemqDeWqGIHoWM86A=;
        b=Irm/L1HgNNKsGCsn2kKPXL4x/JeqXg7AuGOVOO1QWfWk6e+/Cd7iyNg4FtM6yGRwuo
         SWjM+YFICnKX3MPDa1YfcQ+FQjytkNJCW/7PXNp2Y7nsxPFlJ2vrtwndRm5ToNU5WFPf
         CSubjFd1A25A8aGr5dYZpc49oYP2qeKILm+lHneIFhrSMCYeDGhvQgeeoE60gevFUEZy
         /GIz4Q+okEKbcYUcV98cJBRFq5dY+9SMUHUF9883gpieIRNNihcaqfQ3PA5Rx/67DSjw
         onIr38gipbplbgnnN+Z/Mkn1WzLyTfTn6LpQPRVQ06lB2saqcjEL8hf5m06mVqlGnAwW
         Ksfg==
X-Gm-Message-State: AOJu0Ywm1LSehkG6AYkut2J7tMByOhVkVtrV0fRo41fqBJ9LTi87d6LE
	gbESsK8fzVsBqMkPpUQjWXh9qBi5eUi0Ign4C6KsvaZmgD0MNt9Ddx9OdL6tVIDj+ORbffNunns
	qzPdH235blHZr55IsVBEVlzmgbw==
X-Google-Smtp-Source: AGHT+IGS0S84nWWPeysL+mFOFap3NjMcgT1vbRmpG1ZnvwANgcD7I9rDqiPadoprZ3xgO/+lEX4pEIHtW1Yj6kYgmrQ=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:5644:b0:40f:df1e:ff56 with
 SMTP id js4-20020a05600c564400b0040fdf1eff56mr25678wmb.6.1707317366436; Wed,
 07 Feb 2024 06:49:26 -0800 (PST)
Date: Wed,  7 Feb 2024 14:48:33 +0000
In-Reply-To: <20240207144832.1017815-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207144832.1017815-2-sebastianene@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207144832.1017815-6-sebastianene@google.com>
Subject: [PATCH v5 4/4] KVM: arm64: Initialize the ptdump parser with stage-2 attributes
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com, 
	mark.rutland@arm.com, maz@kernel.org, oliver.upton@linux.dev, 
	rananta@google.com, ricarkol@google.com, ryan.roberts@arm.com, 
	shahuang@redhat.com, suzuki.poulose@arm.com, will@kernel.org, 
	yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, vdonnefort@google.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Define a set of attributes used by the ptdump parser to display the
properties of a guest memory region covered by a pagetable descriptor.
Build a description of the pagetable levels and initialize the parser
with this configuration.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 156 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index a4e984da8aa7..60725d46f17b 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -14,6 +14,69 @@
 #include <kvm_ptdump.h>
 
 
+#define ADDR_MARKER_LEN		(2)
+#define MARKER_MSG_LEN		(32)
+
+static const struct prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
+		.set	= "XN",
+		.clear	= "  ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
+		.set	= "R",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
+		.set	= "W",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "FnXS",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT | PTE_VALID,
+		.val	= PTE_CONT | PTE_VALID,
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
 static int kvm_ptdump_guest_open(struct inode *inode, struct file *file);
 static int kvm_ptdump_guest_show(struct seq_file *m, void *);
 
@@ -52,6 +115,94 @@ static int kvm_ptdump_show_common(struct seq_file *m,
 	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
 }
 
+static void kvm_ptdump_build_levels(struct pg_level *level, u32 start_lvl)
+{
+	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
+	u32 i = 0;
+	u64 mask_lvl = 0;
+
+	if (start_lvl > 2) {
+		pr_err("invalid start_lvl %u\n", start_lvl);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
+		mask_lvl |= stage2_pte_bits[i].mask;
+
+	for (i = start_lvl; i <= KVM_PGTABLE_LAST_LEVEL; i++) {
+		level[i].name = level_names[i];
+		level[i].num = ARRAY_SIZE(stage2_pte_bits);
+		level[i].bits = stage2_pte_bits;
+		level[i].mask = mask_lvl;
+	}
+
+	if (start_lvl > 0)
+		level[start_lvl].name = level_names[0];
+}
+
+static int kvm_ptdump_parser_init(struct pg_state *st,
+				  struct kvm_pgtable *pgtable,
+				  struct seq_file *m)
+{
+	struct addr_marker *ipa_addr_marker;
+	char *marker_msg;
+	struct pg_level *level_descr;
+	struct ptdump_range *range;
+
+	ipa_addr_marker = kzalloc(sizeof(struct addr_marker) * ADDR_MARKER_LEN,
+				  GFP_KERNEL_ACCOUNT);
+	if (!ipa_addr_marker)
+		return -ENOMEM;
+
+	marker_msg = kzalloc(MARKER_MSG_LEN, GFP_KERNEL_ACCOUNT);
+	if (!marker_msg)
+		goto free_with_marker;
+
+	level_descr = kzalloc(sizeof(struct pg_level) * (KVM_PGTABLE_LAST_LEVEL + 1),
+			      GFP_KERNEL_ACCOUNT);
+	if (!level_descr)
+		goto free_with_msg;
+
+	range = kzalloc(sizeof(struct ptdump_range) * ADDR_MARKER_LEN,
+			GFP_KERNEL_ACCOUNT);
+	if (!range)
+		goto free_with_level;
+
+	kvm_ptdump_build_levels(level_descr, pgtable->start_level);
+
+	snprintf(marker_msg, MARKER_MSG_LEN, "IPA bits %2u start lvl %1d",
+		 pgtable->ia_bits, pgtable->start_level);
+
+	ipa_addr_marker[0].name = marker_msg;
+	ipa_addr_marker[1].start_address = BIT(pgtable->ia_bits);
+	range[0].end = BIT(pgtable->ia_bits);
+
+	st->seq = m;
+	st->marker = ipa_addr_marker;
+	st->level = -1,
+	st->pg_level = level_descr,
+	st->ptdump.range = range;
+	return 0;
+
+free_with_level:
+	kfree(level_descr);
+free_with_msg:
+	kfree(marker_msg);
+free_with_marker:
+	kfree(ipa_addr_marker);
+	return -ENOMEM;
+}
+
+static void kvm_ptdump_parser_teardown(struct pg_state *st)
+{
+	const struct addr_marker *ipa_addr_marker = st->marker;
+
+	kfree(ipa_addr_marker[0].name);
+	kfree(ipa_addr_marker);
+	kfree(st->pg_level);
+	kfree(st->ptdump.range);
+}
+
 static int kvm_ptdump_guest_show(struct seq_file *m, void *)
 {
 	struct kvm *guest_kvm = m->private;
@@ -59,10 +210,15 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *)
 	struct pg_state parser_state = {0};
 	int ret;
 
+	ret = kvm_ptdump_parser_init(&parser_state, mmu->pgt, m);
+	if (ret)
+		return ret;
+
 	write_lock(&guest_kvm->mmu_lock);
 	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
 	write_unlock(&guest_kvm->mmu_lock);
 
+	kvm_ptdump_parser_teardown(&parser_state);
 	return ret;
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


