Return-Path: <linux-kernel+bounces-53247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2637084A2A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538211C20A14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35E487A9;
	Mon,  5 Feb 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t7vvPXVD"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5B48799
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158623; cv=none; b=jFNUw5iPTgiSTUK3+iGwOtjkPYUGSOK0zfSmqx+S1fhEDw0/W9hRjxUsCt3ZzvLQZqGYBBCui0XdM73EQbyurtQSc0nClXHU6vLhPViWWaiRML8igByeVubDBv8IVs8vSJJCCuQhYKPFv7dD50EIkt+wNIbDKDzQSQ7S63FLhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158623; c=relaxed/simple;
	bh=nmTgukHgTcZ/pZA80eYQ+M9fO2HDt9ms9ZXkd1+gOI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nXoXyjGj+QG86iv4kBXv5P79lfkX7iAGRv9A0/NNbsS3HrTUGRfVAfJJRIpDUiSnsrdyTEn2B1ENjz1IZV21jkSBTOOu07FpLc4P7Jhmkv0VrDTKbyAdA+m0RJW3s7KraUQckgoskZqYifUdasrDzmVRcmw+6YRVot8tQZumpOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t7vvPXVD; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707158621; x=1738694621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n0UiRQIDwXPhO89gFc7hLFAJlLuRhv/umCxdj84c8o0=;
  b=t7vvPXVD0XXwX6DX6nZjuNeze+0e1hVjieo69BH8ohs7td2PnFE9dhWv
   zMfvVi0dKltnxX5tMJagvKd8z6/QhEYPqCVpHW61ZLftc4bCxpDiiYXM2
   12HtgDyNubWWonL48stICQX4cIyDf/UHRBILWJx6zSpbjedNcwewi33FP
   o=;
X-IronPort-AV: E=Sophos;i="6.05,245,1701129600"; 
   d="scan'208";a="63862469"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:43:39 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:27241]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.8.155:2525] with esmtp (Farcaster)
 id f9ee6ae2-72b7-46e1-a0c5-bc63b12df20d; Mon, 5 Feb 2024 18:43:38 +0000 (UTC)
X-Farcaster-Flow-ID: f9ee6ae2-72b7-46e1-a0c5-bc63b12df20d
Received: from EX19D031EUB002.ant.amazon.com (10.252.61.105) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 18:43:38 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19D031EUB002.ant.amazon.com (10.252.61.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 18:43:37 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 5 Feb 2024 18:43:35 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
CC: Saurav Sachidanand <sauravsc@amazon.com>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] [RFC] KVM: arm64/vgic: Populate GICR_TYPER with Aff3
Date: Mon, 5 Feb 2024 18:43:26 +0000
Message-ID: <20240205184326.78814-1-sauravsc@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

According to spec, bits [63:56] of the GICR_TYPER register are supposed
to contain Affinity level 3 (Aff3) bits of the Processing Element (PE)
associated with its GIC redistributor. Linux guests on boot match PEs
with their redistributor using all four Affinity level bits from this
register.

Currently, vGIC populates GICR_TYPER with just the first three Affinity
levels of a vCPU's MPIDR. This works fine for a Linux guest that boots
with KVM's default vCPU MPIDR assignment, which also only populates till
the first three Affinity levels.

However, a hypervisor can override KVM's default MPIDR assignment by
writing directly to a vCPU's MPIDR_EL1 register. If such a hypervisor
were to populate Aff3 bits for a VM, a Linux guest booting there would
fail to match vCPUs with their vGIC redistributors, since their virtual
GICR_TYPER registers would be missing the respective Aff3 bits.

To change that, let's populate GICR_TYPER using Aff3 bits [39:32] from
the vCPU's MPIDR.

Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index c15ee1df036a..26bc838ce14c 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -324,6 +324,7 @@ static unsigned long vgic_mmio_read_v3r_typer(struct kvm_vcpu *vcpu,
 	u64 value;
 
 	value = (u64)(mpidr & GENMASK(23, 0)) << 32;
+	value |= (u64)((mpidr >> 32) & GENMASK(7, 0)) << 56;
 	value |= ((target_vcpu_id & 0xffff) << 8);
 
 	if (vgic_has_its(vcpu->kvm))
-- 
2.40.1




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




