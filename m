Return-Path: <linux-kernel+bounces-63214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D48852C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D9282565
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81241C76;
	Tue, 13 Feb 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIbqeW1Z"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB939AF0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816811; cv=none; b=AUfY8G2jaoI/zZAwVL9nVQ09pnVee5P9vmMDGGcOeosEBKBN+kYCLpcIT5ICPdrmlpU7dZH+qhzPJwVplDBGVX/BkF5JGOR136CRn9R1/hZ04jouH35o/++sHc1JEqg8GPBz0sPD62LvdrW5UqNHdlS+wEc5NL55TaGBFF3XvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816811; c=relaxed/simple;
	bh=0T2ru6MMuxoS0lW+UfmGEtA3Xi3gFhDd6hkRlTBsx60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cdf+tNhNKjKiBvX5k0IxNJPymGQ1swQOEpdpPKQFS0SU6MKfeHr27S7OgF+Ouozyd2cTOwpAxgV8RFi+5weaxxK1ztpr8WHxMhIUTPMk7994vh0e2K6n+/muLDOf0qpaD/wj79lrs6XUHuYV8YdlOvOdVp0QZZxjb8+Kp4TAJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIbqeW1Z; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707816808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+sE7IWb8cyeSXhM2SoQx6feQUCncZFMKiDi8i8kQuog=;
	b=fIbqeW1ZtUZ68xNmBl0T2oKjxtonR+jlZ0zOZVCkvVUyb9G8iY3hNpGjdaSwnBzT25HlJu
	aTq0LUmN+pDqwuA4EwzAsaCusVYF+CmVzZ7Cy6egs0n+XFNiTk5KKapqAkptc3AoQoEGOs
	MFPfZbxRvSMakWrZbH07OLbdPfSuMRY=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v2 09/23] KVM: arm64: vgic: Rely on RCU protection in vgic_get_lpi()
Date: Tue, 13 Feb 2024 09:32:46 +0000
Message-ID: <20240213093250.3960069-10-oliver.upton@linux.dev>
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
index be3ed4c5e1fa..128ae53a0a55 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -62,15 +62,14 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
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
2.43.0.687.g38aa6559b0-goog


