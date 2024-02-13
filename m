Return-Path: <linux-kernel+bounces-63210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9B6852C57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB36B25AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2036AEF;
	Tue, 13 Feb 2024 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHo0sLNa"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16F1B273
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816806; cv=none; b=iWr79amWeJOiuuobV4vXnmdZSGgR4PmNSrWT0ZVKOtVfjA5Ens7R8YsT2r7U0FPCRWG65aDkbUkzcZhBJ2Lsxv71ccxlncfODPJ0ohCpB1vun6TgwZnODoV3nfd/VAaURmW7X9nEzXTABXc3k+Hx667go/OzD1EzKY6tX78MIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816806; c=relaxed/simple;
	bh=7gCAtwCAzOxOThnwdigYSe669AuhD7GmWusCH1zdeDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOqw+WmP7d0mvb/zkPDsw5LnFHIg4HYP8pGOWdC2OQQHyhpb/8RwVlKdbNJQhINqXyUwsM6QVAs7O4yyu6+53D2UxzQ/pZW7/i7Xh3XB+Um/U2HUEi8CY6junaITtwihh23VUop5uJylNN/csJiF4PTULOh4ilTSelIRZMsnoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHo0sLNa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707816801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7DiWlMgiNfAagj80AqXky3JLRxK4Eu9kOYloGceSKs=;
	b=tHo0sLNacpdzPwUWnZwC01vVZXsuonkEzA+krHUVpDXM46Dk5TLIcH3L7wPG0wRCGJl+OF
	l3em5KbB5DskRHC5tKe+SwvpKj7CqjkXoLykd9bUfbnijUkt/J79Nw1w0B2/1VsduejFDq
	DXas+JptrfVm6c8f9wt1uhKnDhAFIqQ=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev
Cc: kvm@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH v2 05/23] KVM: arm64: vgic-its: Walk the LPI xarray in vgic_copy_lpi_list()
Date: Tue, 13 Feb 2024 09:32:42 +0000
Message-ID: <20240213093250.3960069-6-oliver.upton@linux.dev>
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

Start iterating the LPI xarray in anticipation of removing the LPI
linked-list.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 0265cd1f2d6e..aefe0794b71c 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -336,6 +336,7 @@ static int update_lpi_config(struct kvm *kvm, struct vgic_irq *irq,
 int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	XA_STATE(xas, &dist->lpi_xa, GIC_LPI_OFFSET);
 	struct vgic_irq *irq;
 	unsigned long flags;
 	u32 *intids;
@@ -354,7 +355,9 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 		return -ENOMEM;
 
 	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
-	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+	rcu_read_lock();
+
+	xas_for_each(&xas, irq, INTERRUPT_ID_BITS_ITS) {
 		if (i == irq_count)
 			break;
 		/* We don't need to "get" the IRQ, as we hold the list lock. */
@@ -362,6 +365,8 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 			continue;
 		intids[i++] = irq->intid;
 	}
+
+	rcu_read_unlock();
 	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	*intid_ptr = intids;
-- 
2.43.0.687.g38aa6559b0-goog


