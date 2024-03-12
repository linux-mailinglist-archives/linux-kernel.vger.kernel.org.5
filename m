Return-Path: <linux-kernel+bounces-100298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9787953D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056311F23EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0577A72F;
	Tue, 12 Mar 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsFv99gt"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF995B1E1;
	Tue, 12 Mar 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250918; cv=none; b=V3YH6NNAzbKvKuk5g1aitiffYsUhnpDydhYR+oRQZaXirwTXdBAiN0iG0zjcGL8FOZw63cUrkA8NwHpBnAd1JTyOxgfe2A+U7bhEtRz2LEhzIPWjY7wml6evVsP2pXIAutopfC9QuvwEX94wSmHCCUZf/UcqPvaVXwlXcLT4hf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250918; c=relaxed/simple;
	bh=e0tD6pX6xwZoiwXkNmdHyZiDqoGTK5swzwTMQ0e4R40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHkAKf+Pgaqv9M188Xu2INAnVKAR+9Zb57pmPO+nwIGXDREtvKMv67EbogPrHsTNCXsMu2TGWeugLcPytLL0FMcXYfZebFBbcLT7ymKwWmYq/+E6JiK6dT5VTG2HdvDA3Wu1q7a8tJMlubH7MmaHH5UrSwB1vRHZTC9RTLPWOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AsFv99gt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=xa8JQ3KvRA3TOgaBHWeRGuMMjhi7suQa/WUm17VoCcg=; b=AsFv99gt9tiVB4IvPWpp0zhn/q
	yAbrTW80SEAlzDGcnxg0eIauLDMd8Ueell+LxV1jgKPF6ZeEHtxE95I4up6xl7/iYxoR+E4PbscFS
	+UKnA2/qIyCqV3MF1qK3cHd7Ga86D01o45mEWZJYrJCtP3dPc57wEz85CqU/DQ7FdAyoK2Xzr+xOA
	lc08WumNg6hxdL2/7cf6dYDCvBqBGk5/WMCu2n4/5DIZhidooDV9qS9CdjA0WHKMGaYl8sZrPs1Al
	9yNGbz6L5ql2Ubj5V3bvOM24V/9i7h58oz/wSqcZ5nkqkWPI2BQUaR0BzstRC23MOlPJRUqwNECAT
	VAq7uKSw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk2O5-00000009UzB-2mNO;
	Tue, 12 Mar 2024 13:41:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk2O4-000000033FJ-0PsV;
	Tue, 12 Mar 2024 13:41:48 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	mediou@amazon.de,
	alisaidi@amazon.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH 1/2] ACPICA: Detect FACS even for hardware reduced platforms
Date: Tue, 12 Mar 2024 13:41:46 +0000
Message-ID: <20240312134148.727454-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

ACPICA PR https://github.com/acpica/acpica/pull/933

The FACS is optional even on hardware reduced platforms, and may exist
for the purpose of communicating the hardware_signature field to provke
a clean reboot instead of a resume from hibernation.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/acpi/acpica/tbfadt.c  | 30 +++++++++++++-----------------
 drivers/acpi/acpica/tbutils.c |  7 +------
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 44267a92bce5..3c126c6d306b 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -315,23 +315,19 @@ void acpi_tb_parse_fadt(void)
 				       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
 				       NULL, FALSE, TRUE, &acpi_gbl_dsdt_index);
 
-	/* If Hardware Reduced flag is set, there is no FACS */
-
-	if (!acpi_gbl_reduced_hardware) {
-		if (acpi_gbl_FADT.facs) {
-			acpi_tb_install_standard_table((acpi_physical_address)
-						       acpi_gbl_FADT.facs,
-						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-						       NULL, FALSE, TRUE,
-						       &acpi_gbl_facs_index);
-		}
-		if (acpi_gbl_FADT.Xfacs) {
-			acpi_tb_install_standard_table((acpi_physical_address)
-						       acpi_gbl_FADT.Xfacs,
-						       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
-						       NULL, FALSE, TRUE,
-						       &acpi_gbl_xfacs_index);
-		}
+	if (acpi_gbl_FADT.facs) {
+		acpi_tb_install_standard_table((acpi_physical_address)
+					       acpi_gbl_FADT.facs,
+					       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+					       NULL, FALSE, TRUE,
+					       &acpi_gbl_facs_index);
+	}
+	if (acpi_gbl_FADT.Xfacs) {
+		acpi_tb_install_standard_table((acpi_physical_address)
+					       acpi_gbl_FADT.Xfacs,
+					       ACPI_TABLE_ORIGIN_INTERNAL_PHYSICAL,
+					       NULL, FALSE, TRUE,
+					       &acpi_gbl_xfacs_index);
 	}
 }
 
diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index bb4a56e5673a..15fa68a5ea6e 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -36,12 +36,7 @@ acpi_status acpi_tb_initialize_facs(void)
 {
 	struct acpi_table_facs *facs;
 
-	/* If Hardware Reduced flag is set, there is no FACS */
-
-	if (acpi_gbl_reduced_hardware) {
-		acpi_gbl_FACS = NULL;
-		return (AE_OK);
-	} else if (acpi_gbl_FADT.Xfacs &&
+	if (acpi_gbl_FADT.Xfacs &&
 		   (!acpi_gbl_FADT.facs
 		    || !acpi_gbl_use32_bit_facs_addresses)) {
 		(void)acpi_get_table_by_index(acpi_gbl_xfacs_index,
-- 
2.44.0


