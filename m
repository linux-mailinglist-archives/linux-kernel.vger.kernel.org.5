Return-Path: <linux-kernel+bounces-74108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40885D003
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85A31F21309
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB93D579;
	Wed, 21 Feb 2024 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RK/jSFpK"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6953A268
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494222; cv=none; b=rkxGO46GGPCPs0qzZGOiNODYZZx22qMabdPc4HwP0dOQ/hbrBWLzelgJAT5vrwUwnV5vEZfUsyRCkNnG7c9iesz3Ortpl1BfpEIatNrco/koE9xibaMFi8FmrvNjoZGGxrfv1nnPtkoFJM3PdI7fQTx6A+1iLrS3OZtjbG8OYJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494222; c=relaxed/simple;
	bh=huN1PqJtmqytpL0vyqUMZqGEJFXVuxAo91FZdlEJvZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANrTd1w0r8MGB6wJu2cg3bWDC+q9JOtrD3YWHLUpRLR0z3pFx2XNV1lsOrqeUIvX1kAFTC/W1pHOmTvCu18afoZXnj+y5ToRTlGN9sDxP+ImaX8uGcgLSNaMfrPlmtrtHWntasxslp7zkZ1QUbiZoNxgGUDar+H67Rj9F2GYWmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RK/jSFpK; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708494218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7uZnxcLXKLqyPCNevo5l7NpGLhMeejXcsQuYRK9QxO0=;
	b=RK/jSFpKYJqpDZ2ouKFiZ2I/rdOcsLx5lKza9bI7O/DEvmkWAWOwRt7MBFuz/AgkDXmv1z
	1DsW4AldOgmJ72zxrmxbd18hjzeuCR1L2nPxHUhyTOjfZ4E7Nnk5ArYF9wBFEWr2ZBsot/
	q64aIxAUJxhWVqMsKVznWHHqpDmDvVA=
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
Subject: [PATCH v4 10/10] KVM: arm64: vgic: Don't acquire the lpi_list_lock in vgic_put_irq()
Date: Wed, 21 Feb 2024 05:42:53 +0000
Message-ID: <20240221054253.3848076-11-oliver.upton@linux.dev>
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

The LPI xarray's xa_lock is sufficient for synchronizing writers when
freeing a given LPI. Furthermore, readers can only take a new reference
on an IRQ if it was already nonzero.

Stop taking the lpi_list_lock unnecessarily and get rid of
__vgic_put_lpi_locked().

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-its.c |  4 ++--
 arch/arm64/kvm/vgic/vgic.c     | 28 +++++++++-------------------
 arch/arm64/kvm/vgic/vgic.h     |  1 -
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index dad6f0ee7c49..f6025886071c 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -649,7 +649,7 @@ static void vgic_its_cache_translation(struct kvm *kvm, struct vgic_its *its,
 	 * was in the cache, and increment it on the new interrupt.
 	 */
 	if (cte->irq)
-		__vgic_put_lpi_locked(kvm, cte->irq);
+		vgic_put_irq(kvm, cte->irq);
 
 	/*
 	 * The irq refcount is guaranteed to be nonzero while holding the
@@ -686,7 +686,7 @@ void vgic_its_invalidate_cache(struct kvm *kvm)
 		if (!cte->irq)
 			break;
 
-		__vgic_put_lpi_locked(kvm, cte->irq);
+		vgic_put_irq(kvm, cte->irq);
 		cte->irq = NULL;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index df9e1aa1956c..f963f410788a 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -111,22 +111,6 @@ static void vgic_irq_release(struct kref *ref)
 {
 }
 
-/*
- * Drop the refcount on the LPI. Must be called with lpi_list_lock held.
- */
-void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-
-	if (!kref_put(&irq->refcount, vgic_irq_release))
-		return;
-
-	xa_erase(&dist->lpi_xa, irq->intid);
-	atomic_dec(&dist->lpi_count);
-
-	kfree_rcu(irq, rcu);
-}
-
 void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
@@ -135,9 +119,15 @@ void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
 	if (irq->intid < VGIC_MIN_LPI)
 		return;
 
-	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
-	__vgic_put_lpi_locked(kvm, irq);
-	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	if (!kref_put(&irq->refcount, vgic_irq_release))
+		return;
+
+	xa_lock_irqsave(&dist->lpi_xa, flags);
+	__xa_erase(&dist->lpi_xa, irq->intid);
+	xa_unlock_irqrestore(&dist->lpi_xa, flags);
+
+	atomic_dec(&dist->lpi_count);
+	kfree_rcu(irq, rcu);
 }
 
 void vgic_flush_pending_lpis(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index f874b9932c5a..0c2b82de8fa3 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -180,7 +180,6 @@ vgic_get_mmio_region(struct kvm_vcpu *vcpu, struct vgic_io_device *iodev,
 		     gpa_t addr, int len);
 struct vgic_irq *vgic_get_irq(struct kvm *kvm, struct kvm_vcpu *vcpu,
 			      u32 intid);
-void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq);
 void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq);
 bool vgic_get_phys_line_level(struct vgic_irq *irq);
 void vgic_irq_set_phys_pending(struct vgic_irq *irq, bool pending);
-- 
2.44.0.rc0.258.g7320e95886-goog


