Return-Path: <linux-kernel+bounces-63216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BB852C64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18255281C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20191250FE;
	Tue, 13 Feb 2024 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m39rFo3b"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9D487B6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816816; cv=none; b=bz854QMqMne67P48FemRx/txDZLmCoLc3rsLD0UM4NEu5Sf3s9S1Y6N3L8hHPLFqRlxRuxR3qq6Chq4mnRXqGq5CXanRENSYQzhP5N8JCugOVexatPMfhaQ0E8Rsg0Zd346xumoSmR/cZG+MonB6p3liI5DgSRhfJAYBbmMvEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816816; c=relaxed/simple;
	bh=AMfprxM0/ut1EJb/0zCW90BuRmzW+XprxTWpT1Elo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afnPKU/osgFWl03695mo+7B/YxVh9ig/Io4FtlR2ksFxOdKxHJPhrsvnL+vqygBrCK6Druc6xhAmu7VO2zK+kjJw9fpLDuQDucMyRhAFLiqipSyHsVjvBheij9uCs6xGNiz2EHN2ggYKnpoSF6OpJOO5t1tyWxg4xpaE9l/79f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m39rFo3b; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707816812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/NKiyUPOAHZp+4seCuTeFdtHdSqB+Sryj+FB70LZ6SE=;
	b=m39rFo3bZXhcOOKgVqA1OtqG/2d1pFKH3ESY4PlhbvCQIcBN54j3NLFr67rLVEi8hX3kPX
	+q0pAZguXIU08yRGInEPzoZMrySX58rpD1cqqK0rjeppMroPaI6tLWSaEP3gEVq7FbS382
	U6z1mj8LlFCVXClGb2NJU7VJE0DhZlw=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v2 11/23] KVM: arm64: vgic: Don't acquire the lpi_list_lock in vgic_put_irq()
Date: Tue, 13 Feb 2024 09:32:48 +0000
Message-ID: <20240213093250.3960069-12-oliver.upton@linux.dev>
In-Reply-To: <20240213093250.3960069-1-oliver.upton@linux.dev>
References: <20240213093250.3960069-1-oliver.upton@linux.dev>
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
 arch/arm64/kvm/vgic/vgic.c     | 21 ++++-----------------
 arch/arm64/kvm/vgic/vgic.h     |  1 -
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 6b9634cec77f..50a9addebeed 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -650,7 +650,7 @@ static void vgic_its_cache_translation(struct kvm *kvm, struct vgic_its *its,
 	if (cte->irq) {
 		KVM_VM_TRACE_EVENT(kvm, vgic_its_trans_cache_victim, cte->db,
 				   cte->devid, cte->eventid, cte->irq->intid);
-		__vgic_put_lpi_locked(kvm, cte->irq);
+		vgic_put_irq(kvm, cte->irq);
 	}
 
 	/*
@@ -688,7 +688,7 @@ void vgic_its_invalidate_cache(struct kvm *kvm)
 		if (!cte->irq)
 			break;
 
-		__vgic_put_lpi_locked(kvm, cte->irq);
+		vgic_put_irq(kvm, cte->irq);
 		cte->irq = NULL;
 	}
 
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 2a288d6c0be7..c8208f81fdc8 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -110,13 +110,13 @@ static void vgic_irq_release(struct kref *ref)
 {
 }
 
-/*
- * Drop the refcount on the LPI. Must be called with lpi_list_lock held.
- */
-void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq)
+void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
+	if (irq->intid < VGIC_MIN_LPI)
+		return;
+
 	if (!kref_put(&irq->refcount, vgic_irq_release))
 		return;
 
@@ -126,19 +126,6 @@ void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq)
 	kfree_rcu(irq, rcu);
 }
 
-void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
-{
-	struct vgic_dist *dist = &kvm->arch.vgic;
-	unsigned long flags;
-
-	if (irq->intid < VGIC_MIN_LPI)
-		return;
-
-	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
-	__vgic_put_lpi_locked(kvm, irq);
-	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
-}
-
 void vgic_flush_pending_lpis(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
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
2.43.0.687.g38aa6559b0-goog


