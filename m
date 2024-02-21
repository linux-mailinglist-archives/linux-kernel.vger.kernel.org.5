Return-Path: <linux-kernel+bounces-74106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A685CFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5CE1C23269
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A34E3D0CA;
	Wed, 21 Feb 2024 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UhQFNMtJ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7C3CF6C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494217; cv=none; b=KPk0fnRD6QW2lI94H2bLGjgGhe793t4vI3/wCUotTyVqW/e+Hb+ILHRkQs6ifd3143Mhw9ub5RTlvlwmYiKc60uZHzOsHLmEpKwDlQ3/LIB5T/bWJiptRnqczq6ozqocWb5ZRoMGY3NyYlawfJ2V+qjYqRld0dpDDnCPV2vRCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494217; c=relaxed/simple;
	bh=w2mKAUpjDefBH8ZRTYVpf6wUaoHL7tLPKvgNGeP/7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTsEGKeBol5R8edRpHguD+Dyn314/eV+OKyEho6cmk/OBc8s2Lcrdgp4DZ8PXBFe9r5+v6dIpxho1mT0Xsrh/nU9JFKIag/N0GLWViu9Xhwv1lORw7hbjaQR9zQvvsoXZjvh5DOkUqfL0LLpOMITJpahYhF4APrynYq5XU3jA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UhQFNMtJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708494214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJ4oP9M3Q0IijgdCm1rTjm/2Zq88g2zw/bm3B6utCQw=;
	b=UhQFNMtJMJzvESlIIp0h2831VVZci4irnCeQlhWnqIopdwDfPiffDEsl1FdQD/dUj82J4M
	ai73hWEqta6WhHvDHXn6FLl1i57BCdfuXEx6luFE3soK+eVjBFfYjSCh9j3BoY4wgq0fDC
	cziW4XfD063WKUDH4KIEB9TmWsv5rVM=
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
Subject: [PATCH v4 08/10] KVM: arm64: vgic: Rely on RCU protection in vgic_get_lpi()
Date: Wed, 21 Feb 2024 05:42:51 +0000
Message-ID: <20240221054253.3848076-9-oliver.upton@linux.dev>
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

Stop acquiring the lpi_list_lock in favor of RCU for protecting
the read-side critical section in vgic_get_lpi(). In order for this to
be safe, we also need to be careful not to take a reference on an irq
with a refcount of 0, as it is about to be freed.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic.c |  9 ++++-----
 arch/arm64/kvm/vgic/vgic.h | 14 +++++++++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 3fedc58e663a..76abf3d946fe 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -63,15 +63,14 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 	struct vgic_irq *irq = NULL;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	rcu_read_lock();
 
 	irq = xa_load(&dist->lpi_xa, intid);
-	if (irq)
-		vgic_get_irq_kref(irq);
+	if (!vgic_try_get_irq_kref(irq))
+		irq = NULL;
 
-	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	rcu_read_unlock();
 
 	return irq;
 }
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 8d134569d0a1..f874b9932c5a 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -220,12 +220,20 @@ void vgic_v2_vmcr_sync(struct kvm_vcpu *vcpu);
 void vgic_v2_save_state(struct kvm_vcpu *vcpu);
 void vgic_v2_restore_state(struct kvm_vcpu *vcpu);
 
-static inline void vgic_get_irq_kref(struct vgic_irq *irq)
+static inline bool vgic_try_get_irq_kref(struct vgic_irq *irq)
 {
+	if (!irq)
+		return false;
+
 	if (irq->intid < VGIC_MIN_LPI)
-		return;
+		return true;
 
-	kref_get(&irq->refcount);
+	return kref_get_unless_zero(&irq->refcount);
+}
+
+static inline void vgic_get_irq_kref(struct vgic_irq *irq)
+{
+	WARN_ON_ONCE(!vgic_try_get_irq_kref(irq));
 }
 
 void vgic_v3_fold_lr_state(struct kvm_vcpu *vcpu);
-- 
2.44.0.rc0.258.g7320e95886-goog


