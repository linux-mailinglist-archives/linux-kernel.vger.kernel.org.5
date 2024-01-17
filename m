Return-Path: <linux-kernel+bounces-29539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA518830FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9723E28BF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3974E2C6AC;
	Wed, 17 Jan 2024 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vUICiNvY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327725620;
	Wed, 17 Jan 2024 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705532841; cv=none; b=nWN7/aN8xWpoZtJxVs0W5I612Y7Z10nanoac9kn843RdJaVEOe/ok5g1Gej1F1kjcpLuXFPzKDqjeKyr1vLPb+RDZyThkqFPvJPNYbXJYIvw0FNwRHw8L70znRLOITnZlJvb0zyu903rwB8hWkPdNsJu1B8z48tJP2S8a+BtFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705532841; c=relaxed/simple;
	bh=c7veDcJwfWEy2ceKhYMeTOZaPgtM+ubfAmWRTM5uF/g=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=JNwcbWeCpoiOU5AouKM9hnI3kN0D5SBjcc6oOECQ1gRVX5mTvnVV72eQcPyu5r4xE+oOYGVMdvM4CiZNA9WnuFoo6yO8caEJ334l7FFIujvp3L4CFKMsFybPnaSs0a0IRqNKgA+qnpP+mgUAmoFKyX7b6bshabVGpo4aHd8bmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vUICiNvY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cMT/514E7BqW1l00hy1a7ZbFa058U0qT/SeW8KWVYfY=; b=vUICiNvYk2UTbA5YYdaPLFh/iq
	fwqIKZm8DRYR4XQTzieARAlxkfsfUd84g7qpVHdkHFWdWPN6vJYjE6zTqhFeTt8fA8ezY5FzWfvey
	NpTjwquz/xkpsDTLnnmevlTPT4yS2cCIQHFRc2WvaRunwRO9AJ9w+6zTuDautMr/r8fQFe5weS1AN
	PfSOgNW7AfMIv4XQqjKblU/8+XQ6xEAI3V2P6JPmL/xv/CYpnBxt1CF/AUrppWFI8tfk9IoN5MnoW
	IcoRyB/eRktNPZl0Ij9Ij8qm3k4X2xnYUQd1oxdYUpkzbsr3pTElJigz8V+evp4Uk2jZ+7jd0+bja
	9zP+FKag==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQF0B-0011su-2b;
	Wed, 17 Jan 2024 23:07:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 06/10] KVM: arm64: PMU: fix kernel-doc warnings
Date: Wed, 17 Jan 2024 15:07:10 -0800
Message-ID: <20240117230714.31025-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117230714.31025-1-rdunlap@infradead.org>
References: <20240117230714.31025-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change 2 uses of "/**" on non-kernel-doc comments to common "/*"
comments to prevent kernel-doc warnings:

arch/arm64/kvm/pmu-emul.c:423: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
arch/arm64/kvm/pmu-emul.c:494: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * When the perf event overflows, set the overflow status and inform the vcpu.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/pmu-emul.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -419,7 +419,7 @@ void kvm_pmu_sync_hwstate(struct kvm_vcp
 	kvm_pmu_update_state(vcpu);
 }
 
-/**
+/*
  * When perf interrupt is an NMI, we cannot safely notify the vcpu corresponding
  * to the event.
  * This is why we need a callback to do it once outside of the NMI context.
@@ -490,7 +490,7 @@ static u64 compute_period(struct kvm_pmc
 	return val;
 }
 
-/**
+/*
  * When the perf event overflows, set the overflow status and inform the vcpu.
  */
 static void kvm_pmu_perf_overflow(struct perf_event *perf_event,

