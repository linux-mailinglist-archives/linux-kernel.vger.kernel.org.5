Return-Path: <linux-kernel+bounces-74104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E085CFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A5728611C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388613C689;
	Wed, 21 Feb 2024 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JOdXlq8W"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9663A8E5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494213; cv=none; b=d+Z4cmhnQhNpublbzzYzu0larUrgdDx1Mib9O0iLJk/I9PWPbOlI6H0pHBJNGR2Avm3GNCjf+vMeVPjvv5FteY+5QnuxwDZnsW64zta9npmz9E/FUqDAU/60dIZ+Tg/T4w+UgXz9fHJOmfafv60S44gt5etiaxtuPp3qtqupjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494213; c=relaxed/simple;
	bh=i1Z17y1L2zZUqDCMRJDQXDFZa8iLbDZzznncMJH6hZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6csHFl7jWTbDhq2ulvowNe5WvT97dqwLDH3NwDJB/DGm17RnLCxF7ZKaHXoYPkWkuPjK/uboNgPTlVpapS2pWQkPavODgzyeDUak/QU2WHUC1nIbKBUbj4HhDqMaLkl2zkGP9VHXKJRdjRdCiK/fbyRZD2J0x7VZaYuv6jBlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOdXlq8W; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708494210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSxryl4GJz7jglvRnwO6HB5bazTdcs2fEdVdtMmeB8s=;
	b=JOdXlq8WUZfIK0n17nGijHUe5mPeuDqw2JyGKCciNDJMECFQT4kEAYdfH3vwhxjHvWm+Qb
	pb7a+3tuYFEeojv3/zOuWw6jNPAcD0AK+UZkb4eA8f0unN752nf2as6SvuFCUq9uK7Omv5
	pcjH9bPZKe2pu2gtm7P8FjZrjXkjBb0=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v4 06/10] KVM: arm64: vgic: Use atomics to count LPIs
Date: Wed, 21 Feb 2024 05:42:49 +0000
Message-ID: <20240221054253.3848076-7-oliver.upton@linux.dev>
In-Reply-To: <20240221054253.3848076-1-oliver.upton@linux.dev>
References: <20240221054253.3848076-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch to using atomics for LPI accounting, allowing vgic_irq references
to be dropped in parallel.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-debug.c | 2 +-
 arch/arm64/kvm/vgic/vgic-its.c   | 4 ++--
 arch/arm64/kvm/vgic/vgic.c       | 2 +-
 include/kvm/arm_vgic.h           | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index 85606a531dc3..389025ce7749 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -149,7 +149,7 @@ static void print_dist_state(struct seq_file *s, struct vgic_dist *dist)
 	seq_printf(s, "vgic_model:\t%s\n", v3 ? "GICv3" : "GICv2");
 	seq_printf(s, "nr_spis:\t%d\n", dist->nr_spis);
 	if (v3)
-		seq_printf(s, "nr_lpis:\t%d\n", dist->lpi_list_count);
+		seq_printf(s, "nr_lpis:\t%d\n", atomic_read(&dist->lpi_count));
 	seq_printf(s, "enabled:\t%d\n", dist->enabled);
 	seq_printf(s, "\n");
 
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 3d0208162bcd..0be3c33676c3 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -96,7 +96,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 		goto out_unlock;
 	}
 
-	dist->lpi_list_count++;
+	atomic_inc(&dist->lpi_count);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
@@ -346,7 +346,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 	 * command). If coming from another path (such as enabling LPIs),
 	 * we must be careful not to overrun the array.
 	 */
-	irq_count = READ_ONCE(dist->lpi_list_count);
+	irq_count = atomic_read(&dist->lpi_count);
 	intids = kmalloc_array(irq_count, sizeof(intids[0]), GFP_KERNEL_ACCOUNT);
 	if (!intids)
 		return -ENOMEM;
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 6240faab0127..15dbd17b3a9e 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -123,7 +123,7 @@ void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq)
 		return;
 
 	xa_erase(&dist->lpi_xa, irq->intid);
-	dist->lpi_list_count--;
+	atomic_dec(&dist->lpi_count);
 
 	kfree(irq);
 }
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index aeff363e3ba6..71e9d719533b 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -273,10 +273,10 @@ struct vgic_dist {
 	 */
 	u64			propbaser;
 
-	/* Protects the lpi_list and the count value below. */
+	/* Protects the lpi_list. */
 	raw_spinlock_t		lpi_list_lock;
 	struct xarray		lpi_xa;
-	int			lpi_list_count;
+	atomic_t		lpi_count;
 
 	/* LPI translation cache */
 	struct list_head	lpi_translation_cache;
-- 
2.44.0.rc0.258.g7320e95886-goog


