Return-Path: <linux-kernel+bounces-63316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B58852D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2061F21771
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BE2260B;
	Tue, 13 Feb 2024 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ0LpLUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C88225A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819133; cv=none; b=Ur7wSYb5olNG3Y8mWZXT0y7pGTC3xVJd4GXiT4QwgpkkinO31gLXJv+mjlQLGaW2CULx74edipNiZGcQY7wey2j17tPHtg0E53aP2ibU5VguOUoJ1Q+5ohxnx94dKHXyN3FYBjAsnnnyzuR2Cc0LiCkaRXiy96+Ggw5iga6tGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819133; c=relaxed/simple;
	bh=y6fOsCJvWITZP3N0edq1izJAfFOb77a1S9SDSCyM6wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gi54KEnYiWxzKIeLv0sphVlW7wLHHbiF3lJ0BmSt+sbiIDuOXB4Ywh6hWl0Vt0EuDyA8hu+WB2+6Rb6kxfBezkO6qig+c3/n0WtiGbRl6Ty0Aif4bzJCxgW5Xj0tjyDa56LW+4sgDsi+h0A1TFqI0KOjEVADUHUJQ4BMGclhjfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ0LpLUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7200C433F1;
	Tue, 13 Feb 2024 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819133;
	bh=y6fOsCJvWITZP3N0edq1izJAfFOb77a1S9SDSCyM6wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJ0LpLUr63UODRUhWz1ZbnYp3RArl4C4JFIPR6YNtfFjeKb99s3F712N1VrsbRe7W
	 Ny315lBS9w7sLBMdvWvy1plBsF8kv6CIIlvV9fxzEy85MMHCS2loEC+vw9okIWsDOK
	 07UEdH3z7WNC373CcSSYPoFy1uU1/vmSJg2ReB8df16n5lD2pgUGlUzKFblYyv6Ulc
	 E4OjnzrjZFOD3PKcHrKddqgmoilc1NqSyGGf80+SAFAYAxRDt54O+We20tMNl+sZAN
	 UZ1ONZBDQhndJccDrT19N4nSRIpcPcVrxUXsAyTIxP+p+Uh14qQnw/RPwHwyqzlJTe
	 akVVFK+NNdi/g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rZplq-002j7r-Uv;
	Tue, 13 Feb 2024 10:12:11 +0000
From: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kunkun Jiang <jiangkunkun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
Date: Tue, 13 Feb 2024 10:12:04 +0000
Message-Id: <20240213101206.2137483-2-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: tglx@linutronix.de, jiangkunkun@huawei.com, lpieralisi@kernel.org, yuzenghui@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Although the GICv3 code base has gained some handling of systems
failing to handle the shareability attributes, the GICv4 side of
things has been firmly ignored.

This is unfortunate, as the new recent addition of the
"dma-noncoherent" is supposed to apply to all of the GICR tables,
and not just the ones that are common to v3 and v4.

Add some checks to handle the VPROPBASE/VPENDBASE shareability
and cacheability attributes in the same way we deal with the
other GICR_BASE registers, wrapping the flag check in a helper
for improved readability.

Note that this has been found by inspection only, as I don't
have access to HW that suffers from this particular issue.

Fixes: 3a0fff0fb6a3 ("irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing")
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 37 +++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d097001c1e3e..fec1b58470df 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -207,6 +207,11 @@ static bool require_its_list_vmovp(struct its_vm *vm, struct its_node *its)
 	return (gic_rdists->has_rvpeid || vm->vlpi_count[its->list_nr]);
 }
 
+static bool rdists_support_shareable(void)
+{
+	return !(gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE);
+}
+
 static u16 get_its_list(struct its_vm *vm)
 {
 	struct its_node *its;
@@ -2710,10 +2715,12 @@ static u64 inherit_vpe_l1_table_from_its(void)
 			break;
 		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, addr >> 12);
-		val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
-				  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
-		val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
-				  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		if (rdists_support_shareable()) {
+			val |= FIELD_PREP(GICR_VPROPBASER_SHAREABILITY_MASK,
+					  FIELD_GET(GITS_BASER_SHAREABILITY_MASK, baser));
+			val |= FIELD_PREP(GICR_VPROPBASER_INNER_CACHEABILITY_MASK,
+					  FIELD_GET(GITS_BASER_INNER_CACHEABILITY_MASK, baser));
+		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
 
 		return val;
@@ -2936,8 +2943,10 @@ static int allocate_vpe_l1_table(void)
 	WARN_ON(!IS_ALIGNED(pa, psz));
 
 	val |= FIELD_PREP(GICR_VPROPBASER_4_1_ADDR, pa >> 12);
-	val |= GICR_VPROPBASER_RaWb;
-	val |= GICR_VPROPBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPROPBASER_RaWb;
+		val |= GICR_VPROPBASER_InnerShareable;
+	}
 	val |= GICR_VPROPBASER_4_1_Z;
 	val |= GICR_VPROPBASER_4_1_VALID;
 
@@ -3126,7 +3135,7 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
-	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+	if (!rdists_support_shareable())
 		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
 
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
@@ -3153,7 +3162,7 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 
-	if (gic_rdists->flags & RDIST_FLAGS_FORCE_NON_SHAREABLE)
+	if (!rdists_support_shareable())
 		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
 
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
@@ -3880,14 +3889,18 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val  = virt_to_phys(page_address(vpe->its_vm->vprop_page)) &
 		GENMASK_ULL(51, 12);
 	val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
-	val |= GICR_VPROPBASER_RaWb;
-	val |= GICR_VPROPBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPROPBASER_RaWb;
+		val |= GICR_VPROPBASER_InnerShareable;
+	}
 	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
-	val |= GICR_VPENDBASER_RaWaWb;
-	val |= GICR_VPENDBASER_InnerShareable;
+	if (rdists_support_shareable()) {
+		val |= GICR_VPENDBASER_RaWaWb;
+		val |= GICR_VPENDBASER_InnerShareable;
+	}
 	/*
 	 * There is no good way of finding out if the pending table is
 	 * empty as we can race against the doorbell interrupt very
-- 
2.39.2


