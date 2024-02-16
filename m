Return-Path: <linux-kernel+bounces-69191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C977185858D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016081C229F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE01487D5;
	Fri, 16 Feb 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLxdkdtb"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FEC146912
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108947; cv=none; b=CHmiclOoAkWP923z5vcbSMwyrTR5syGmEPmfklcX5yZuGb5q9ZvlfxMo8rAchqilRAQ3bWwN3HgsvVquWLSGYLOWviAFaPTH/AeXJgGg8RJObmAB8ukkRAUWD4+4rZpAYyDwEj6XeeI1BMs27jBZwOLQUQMmgFlDzz8lJ1wNf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108947; c=relaxed/simple;
	bh=YOt99fgiOeGafpp1nEhSIUqA34CgCiK6op8GicPElws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6cL/+krNqC6ZHADvOpE+9t9GJwdBOllN0Ya0Yt+Lo9Zl0N9i8PX0P427XgVE6sPNMcUk0SD1+f/TFx6T5se5d25JxGbncLDgHuCIVXVr44iHl3WO8s8u8RPo4JuZ47kYAaz4VWNBUnWqtqelVz32ByeKkyCY64R4K1E3M6ToTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLxdkdtb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708108944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6/2b6cdY93cfhwg+wgl1iJpv6T7icr8cPzff5WRiiM=;
	b=DLxdkdtbNwcuA4gLo4jd1yD05qIOD+omQNvakwfPpgTo6UMoTeIbl9XzhWZhJZwtRffA+j
	S6COGILK/oPKkNX85TmWz314nYUf1N7NFk3Rob9ONKeUXrHUuFrI9W4PpXWgZer+wkhrb/
	NjTdniGek0pEoQhqcV0ARz6GeS0cHrQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v3 10/10] KVM: arm64: vgic: Don't acquire the lpi_list_lock in vgic_put_irq()
Date: Fri, 16 Feb 2024 18:41:53 +0000
Message-ID: <20240216184153.2714504-11-oliver.upton@linux.dev>
In-Reply-To: <20240216184153.2714504-1-oliver.upton@linux.dev>
References: <20240216184153.2714504-1-oliver.upton@linux.dev>
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
index c3d1bca0b458..d84cb7618c59 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -647,7 +647,7 @@ static void vgic_its_cache_translation(struct kvm *kvm, struct vgic_its *its,
 	 * was in the cache, and increment it on the new interrupt.
 	 */
 	if (cte->irq)
-		__vgic_put_lpi_locked(kvm, cte->irq);
+		vgic_put_irq(kvm, cte->irq);
 
 	/*
 	 * The irq refcount is guaranteed to be nonzero while holding the
@@ -684,7 +684,7 @@ void vgic_its_invalidate_cache(struct kvm *kvm)
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
2.44.0.rc0.258.g7320e95886-goog


