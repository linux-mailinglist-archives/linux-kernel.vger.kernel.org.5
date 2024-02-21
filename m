Return-Path: <linux-kernel+bounces-74103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CC085CFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0DB28312D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26393A1BD;
	Wed, 21 Feb 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kWM4CnAI"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B93BB47
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494212; cv=none; b=UJq65WB7uYXm0IzJTvggq2sytX4SrVfB9Vx15mCFbaU/oYPg75U/Fs95lM1Pls+oYxK17XorP71SorJwUotXcU/cV5Vy2gB9h5VjK0qxlB4TqiN+k+fBV6qbHe32VUUf240eTOU2qdydrteK8DNKUzZVfJ9L299bh5+Sk+lMFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494212; c=relaxed/simple;
	bh=2nkDTHcHmB33a/QQu7UDTZHWtSxxacimi3tTiZ9a1sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXFcI0h8Kid3AswO8iAgnQgGdW1nIz/Mxp4Cn1ELEEfNjmYJpZQcW8sbH9uu2Rvah300aqkoXPAPZuhkBXUuKcVl4PRLpcvgihu3L+tCY800DG+6OI12uKKTPW31HkuJbep3tyuqRbEaGq7hgExbEDGUOoUXsRKF5fG1CBkzdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kWM4CnAI; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708494208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8nd2SXFQ1C1LlktYqUUc4CI4OG59iyq71GzSyfZOU20=;
	b=kWM4CnAIhzzDn6hcA5UWEWtiSn+E/I2Euqe4c3srTEF4gOULTNs5ApWtlcLfPBFH8QZZ7I
	3Zvffct7NXAKoZXaEN6FPXMNl+/PinjhM/iFTxpVAUNvJCWvLZv9aJMYYAbWSXFDcfTRsh
	dCaDPDNwqHphtjV5ajguseu6IlopyMY=
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
Subject: [PATCH v4 05/10] KVM: arm64: vgic: Get rid of the LPI linked-list
Date: Wed, 21 Feb 2024 05:42:48 +0000
Message-ID: <20240221054253.3848076-6-oliver.upton@linux.dev>
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

All readers of LPI configuration have been transitioned to use the LPI
xarray. Get rid of the linked-list altogether.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-init.c | 1 -
 arch/arm64/kvm/vgic/vgic-its.c  | 8 ++------
 arch/arm64/kvm/vgic/vgic.c      | 1 -
 include/kvm/arm_vgic.h          | 2 --
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index 411719053107..e25672d6e846 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -53,7 +53,6 @@ void kvm_vgic_early_init(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
-	INIT_LIST_HEAD(&dist->lpi_list_head);
 	INIT_LIST_HEAD(&dist->lpi_translation_cache);
 	raw_spin_lock_init(&dist->lpi_list_lock);
 	xa_init_flags(&dist->lpi_xa, XA_FLAGS_LOCK_IRQ);
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index b9874dc04608..3d0208162bcd 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -58,7 +58,6 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 		return ERR_PTR(ret);
 	}
 
-	INIT_LIST_HEAD(&irq->lpi_list);
 	INIT_LIST_HEAD(&irq->ap_list);
 	raw_spin_lock_init(&irq->irq_lock);
 
@@ -74,10 +73,8 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	 * There could be a race with another vgic_add_lpi(), so we need to
 	 * check that we don't add a second list entry with the same LPI.
 	 */
-	list_for_each_entry(oldirq, &dist->lpi_list_head, lpi_list) {
-		if (oldirq->intid != intid)
-			continue;
-
+	oldirq = xa_load(&dist->lpi_xa, intid);
+	if (oldirq) {
 		/* Someone was faster with adding this LPI, lets use that. */
 		kfree(irq);
 		irq = oldirq;
@@ -99,7 +96,6 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 		goto out_unlock;
 	}
 
-	list_add_tail(&irq->lpi_list, &dist->lpi_list_head);
 	dist->lpi_list_count++;
 
 out_unlock:
diff --git a/arch/arm64/kvm/vgic/vgic.c b/arch/arm64/kvm/vgic/vgic.c
index 7d17dbc8f5dc..6240faab0127 100644
--- a/arch/arm64/kvm/vgic/vgic.c
+++ b/arch/arm64/kvm/vgic/vgic.c
@@ -122,7 +122,6 @@ void __vgic_put_lpi_locked(struct kvm *kvm, struct vgic_irq *irq)
 	if (!kref_put(&irq->refcount, vgic_irq_release))
 		return;
 
-	list_del(&irq->lpi_list);
 	xa_erase(&dist->lpi_xa, irq->intid);
 	dist->lpi_list_count--;
 
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 795b35656b54..aeff363e3ba6 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -117,7 +117,6 @@ struct irq_ops {
 
 struct vgic_irq {
 	raw_spinlock_t irq_lock;	/* Protects the content of the struct */
-	struct list_head lpi_list;	/* Used to link all LPIs together */
 	struct list_head ap_list;
 
 	struct kvm_vcpu *vcpu;		/* SGIs and PPIs: The VCPU
@@ -277,7 +276,6 @@ struct vgic_dist {
 	/* Protects the lpi_list and the count value below. */
 	raw_spinlock_t		lpi_list_lock;
 	struct xarray		lpi_xa;
-	struct list_head	lpi_list_head;
 	int			lpi_list_count;
 
 	/* LPI translation cache */
-- 
2.44.0.rc0.258.g7320e95886-goog


