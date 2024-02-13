Return-Path: <linux-kernel+bounces-63318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1790D852D90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A61C28A6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B022F0A;
	Tue, 13 Feb 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVHtuQSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD195225D5;
	Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819133; cv=none; b=pILWZN2DfGZzqQMwlyn4ospe/lWE/+6Rmk2rn2gwJyNAaqZrel1BLHDvBlbkIoF2S4hyjcXSnxCB9mD1DrZBB7EGr43tx/E7kWyfQwgKgawGCDykLqKYJ6JoKjG44lRE6c+OW4XAGGCSy9H43fM1tusaOjvQ/iDRKy+THjAWWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819133; c=relaxed/simple;
	bh=mMMxy/y9GolMEAEGUBmVL1XVh2uwo1cUPLjZV/60nHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Is4VShz02+FMk8PVLPhfHLyEnPxWpNJh8wPDIn/57wskv+emKcu3neIpivA4NKMRD1lUwwT6COWjq+vxF0kc5Qm/9a18bsVRW4zMDaYYlhuek2MKtKrSyIBTlcY0GZEJJ6pfbqySwlvgCLqlhHL49D3dbadqTsQSvSlOZxAduJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVHtuQSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72445C433B1;
	Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819133;
	bh=mMMxy/y9GolMEAEGUBmVL1XVh2uwo1cUPLjZV/60nHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVHtuQSS5rAbZ1AVPeHYrpxwnfcRK7mrTyqmOX+JCeYl70dD1z2PApTqhGHYevjO5
	 N3K2/evL/evnJP6U0fIerZuDwbV62Mut9wppUt1iB7KOHNpYXq1mj4jNrAbIMQ2E/O
	 bqaGQEjAdZftbh4sh+lzDSQzbxJaKFuluhC9yyAluDfRPxJBlKxjOA9gI5IOG+qNzR
	 0ilHFl59zQZGIFg0HFmi16PkNxPqgrcKEg/OBkpCeC59Zlz4+smmvsrhmqAdv9M8xR
	 XloDmzKogJbl5rD2j4qiqkATI63NHX71toptdVRjNUsXU0mtEFpihjwu9G2DO3FgmI
	 VJpqC1Qszz61w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rZplr-002j7r-AO;
	Tue, 13 Feb 2024 10:12:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update
Date: Tue, 13 Feb 2024 10:12:06 +0000
Message-Id: <20240213101206.2137483-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213101206.2137483-1-maz@kernel.org>
References: <20240213101206.2137483-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jiangkunkun@huawei.com, lpieralisi@kernel.org, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

When updating the affinity of a VPE, we currently skip the VMOVP
command if the two CPUs are part of the same VPE affinity.

But this is wrong, as the doorbell corresponding to this VPE
is still delivered on the 'old' CPU, which screws up the balancing.
Furthermore, offlining that 'old' CPU results in doorbell interrupts
generated for this VPE being discarded.

The harsh reality is that we cannot easily elide VMOVP when
a set_affinity request occurs. It needs to be obeyed, and if
an optimisation is to be made, it is at the point where the affinity
change request is made (such as in KVM).

Drop the VMOVP elision altogether, and only use the vpe_table_mask
to try and stay within the same ITS affinity group if at all possible.

Fixes: dd3f050a216e (irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP)
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 250b4562f308..53abd4779914 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,8 +3826,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int from, cpu = cpumask_first(mask_val);
+	struct cpumask common, *table_mask;
 	unsigned long flags;
+	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3843,19 +3844,22 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
 	 */
 	from = vpe_to_cpuid_lock(vpe, &flags);
-	if (from == cpu)
-		goto out;
-
-	vpe->col_idx = cpu;
+	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
 	/*
-	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
-	 * is sharing its VPE table with the current one.
+	 * If we are offered another CPU in the same GICv4.1 ITS
+	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
-	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+	if (table_mask && cpumask_and(&common, mask_val, table_mask))
+		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (from == cpu)
 		goto out;
 
+	vpe->col_idx = cpu;
+
 	its_send_vmovp(vpe);
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
-- 
2.39.2


