Return-Path: <linux-kernel+bounces-142204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDE8A28D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834C91F249EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC7C54F87;
	Fri, 12 Apr 2024 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oyRWCkpB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35195026B;
	Fri, 12 Apr 2024 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909062; cv=none; b=PTEO34UcD7laUrc+0B8VXDYHqVz4EHQhY3DscptqG60/uio1q3tFPLNDc6fS0SYWN117jwqAByNIrpOawT04V9ATCnYAW76EoO67P8XjlfNPsT6yrmTf/j5tBMe4IaPv8DzabB+Ijp7BseZyDsSrtVH+VZHWnyQ21hci1DjydzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909062; c=relaxed/simple;
	bh=oDDRDOX0rARG/d79EVFbhFUsJY5ISutnMkd4KXGt5QI=;
	h=In-Reply-To:References:Message-Id:From:Date:Subject:To:Cc; b=DJWw+jcoG4PyYB8ZdfOJbEP3pX7TEuckLMS41/dtD7tunLoOIuyNOzTQpK5pZm2shwWQa8AfCmJDjR4dcjaUojxtFg+uUQQGrZLvtYfdLBqvjtLn9QmM49kRmOgqluBitqEbnk+6SwBbgrhSDYketie5DDm6/et/TVvvETHu1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oyRWCkpB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Cc:To:Subject:Date:From:
	Message-Id:References:In-Reply-To:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LA9H/eqQ3lA2kMt4RACHsdsipUNelRXWxmYww27ZE+g=; b=oyRWCkpBqEeoK84MFBcO1qR0Id
	KoNAhcGT9XqMHthfd06OAwMAToy/Ii2wvAFjlXMYJtEDl7XnpuhALxCS0k6Xt7V8A8c/+DIb8urX2
	j1r5raqhXsg0LSeKPp3I34QVotLLvWvR1vu3chgCqPHNgBzbgZKKrX6ulkzpevx1l1l+LloO96QBc
	UkEmD97XegHMeTap6AM9ioZDE3OM42552dFvHyHFeJoM088fAWen90g9SOfiZ27jdl++aCPWWLGrh
	jNwDahv0Tz5TrkCggZQUnzOykNpq7siBXOXrYMStvmpM690Ud9boKebMj2MHSlWOUFsT4VMe9avtq
	CRhkczlw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtP-0000000926r-2kcE;
	Fri, 12 Apr 2024 08:04:16 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtO-00000009KT4-42mn;
	Fri, 12 Apr 2024 09:04:14 +0100
In-Reply-To: <20240412073530.2222496-1-dwmw2@infradead.org>
References: <20240412073530.2222496-1-dwmw2@infradead.org>
Message-Id: <20240412073530.2222496-2-dwmw2@infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 11 Mar 2024 12:19:14 +0000
Subject: [PATCH v2 1/2] ACPICA: Detect FACS even for hardware reduced
 platforms
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

ACPICA commit 44fc328a1a14b097d92b8be83989e4bf69b6e6cb

The FACS is optional even on hardware reduced platforms, and may exist
for the purpose of communicating the hardware_signature field to provoke
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


