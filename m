Return-Path: <linux-kernel+bounces-100297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A13987953A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B28C1C21D69
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732FA7A707;
	Tue, 12 Mar 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYlrYsh7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4412AE66;
	Tue, 12 Mar 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710250916; cv=none; b=i3lW++PtpueyNLFMX48P8WA1XKtKgDio0mGBjDaeYIs2KyM/5grCOP1OjfMWquEzYtpVRnZ62rHNDNXVDNkT528FxsG+CRkluhKI1JJzrv7uuWTH+ATMHcVxEbZm3ZDXcR7x+WJkNRE8mhTIiwTxQ+vIyBPHPDFowYldnSu5m/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710250916; c=relaxed/simple;
	bh=FxDY+kZRT1RApJ1t6STPTz8JjYr743x0+SzzLlFAsTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUdH0s99N3MhsleaJlr2HiRtEnz1xM1ym70CrpEHlBrztklQCkAyqkyq62aYFk48X3O5EN+7dls3jt7K1t4A1Y+sWAY91iJvF2cWghI1sogzk30ZaFQGy2Kuf4bmgz5TzPn00vSh1YezAQN1AeAgtgdYaSyuAJhWKPR79SZRzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rYlrYsh7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=afNcz38ZHur08T8xK+zgfWPGvMN0cnA27BpXSiLWcYI=; b=rYlrYsh75MAHk+v6ElXVZKnHIB
	71X829QiPdMXkKz3CfWeKyp4JEnwNoA6w/LT0YNu3LWXp7BmQLzRl4jUZfHN3YMM/FH1J8+7X4KHg
	MPPPil6RUPzOBsUELC7PlKyCIfFb6nHKiC047G2WcUhhutnwZuH90A+ewM0gluxdwIb0HU+B8crce
	wC4TwPKywtPWSzVBHwQMRn1uH6xM+vVNE25O6MvriYODW8wAnvx3jbhLWIHJ4WXAkij6A/xy/ehU7
	tSe/LnsV2HZ6NEj1vWeVMgrzkSLcEXNtpNfQW08GfhfSmC+3DmlkKyGVGkoyT15P/riUDpe+KK1SR
	SFZKgYrQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk2O4-000000037rM-23j8;
	Tue, 12 Mar 2024 13:41:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk2O4-000000033FM-0fbO;
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
Subject: [PATCH 2/2] arm64: acpi: Honour firmware_signature field of FACS, if it exists
Date: Tue, 12 Mar 2024 13:41:47 +0000
Message-ID: <20240312134148.727454-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312134148.727454-1-dwmw2@infradead.org>
References: <20240312134148.727454-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

If the firmware_signature changes then OSPM should not attempt to resume
from hibernate, but should instead perform a clean reboot. Set the global
swsusp_hardware_signature to allow the generic code to include the value
in the swsusp header on disk, and perform the appropriate check on resume.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/kernel/acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index dba8fcec7f33..e0e7b93c16cc 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -26,6 +26,7 @@
 #include <linux/libfdt.h>
 #include <linux/smp.h>
 #include <linux/serial_core.h>
+#include <linux/suspend.h>
 #include <linux/pgtable.h>
 
 #include <acpi/ghes.h>
@@ -227,6 +228,15 @@ void __init acpi_boot_table_init(void)
 		if (earlycon_acpi_spcr_enable)
 			early_init_dt_scan_chosen_stdout();
 	} else {
+#ifdef CONFIG_HIBERNATION
+		struct acpi_table_header *facs = NULL;
+		acpi_get_table(ACPI_SIG_FACS, 1, &facs);
+		if (facs) {
+			swsusp_hardware_signature =
+				((struct acpi_table_facs *)facs)->hardware_signature;
+			acpi_put_table(facs);
+		}
+#endif
 		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
 		if (IS_ENABLED(CONFIG_ACPI_BGRT))
 			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
-- 
2.44.0


