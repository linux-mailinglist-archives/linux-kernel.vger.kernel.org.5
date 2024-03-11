Return-Path: <linux-kernel+bounces-142205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84A8A28D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266092859A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72A535B7;
	Fri, 12 Apr 2024 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiUuUVgq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CF355774;
	Fri, 12 Apr 2024 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909072; cv=none; b=sRZMDDOlBO9WqCHSilgFg0UFwVVjCgD1xDQKeUan9+i8onVToNx4vhGte2k9fohKk0RNCcM81RxvOyqAY8DAefLZG99bFNQ2dnwJ6jfOMKj+rP7mNyZ5F5o9oaR7kWc6IBUfdLlNQWPSF/GEhCFuDQjzQU2Y0w04QZLrBtJ+dHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909072; c=relaxed/simple;
	bh=d7cFxhCB3YkupKziFZ26ogRn5cKTA+vaajWjvO+U5mw=;
	h=In-Reply-To:References:Message-Id:From:Date:Subject:To:Cc; b=Ev8cWZaZc7GorpT9qiVN5rhqyZerCE9USkwZgwgKzlJeFrjfKKWY3cvI5KQZqIQ7wlJ/1bNTzie5+6oj4m5t81TxkT5Juk9cHcZP+ggvE1DZWo24BbVLU3D19Fj3y26v7NGbmlbGdmXMDsbS8c74R77iV/vAoTrZ59TKudYqfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KiUuUVgq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Cc:To:Subject:Date:From:
	Message-Id:References:In-Reply-To:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GHkEo0uIXHettMVCbsHimID5bYVEU0q/Ed8abuN0cqo=; b=KiUuUVgqBsUbNnmujmNFQgElNs
	vZoxYrB+KxLxZM8vSWCv7Wb/4/fiOLou9IESxOTDVSW30YLzoQxzONYa02q7gx7TiixdWhtDBq++9
	yq/3xK4KOCRAcA9fYeJjAeHU5N3GxU0wNz3+IAN+UHgLPhbdsS9i08JWzSYOhksV/7AZ6wTFiPax2
	YGyRJ3Micen4JqhKU5U8SWSj2d60wZPf23KPTBm06XzvUqggj5PN5qy/UJ4NmnLzeG7Y1uek29ekF
	WtsqJPMJCp0V6rjjByZKuwzsXP/FU/3YxkR2mF//E7u1c3Mm1aB2vY9jTvZeecIGFqEcHejpBn0es
	F3Xa3sYQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtV-00000008izc-39VM;
	Fri, 12 Apr 2024 08:04:21 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvBtV-00000009KTB-0quC;
	Fri, 12 Apr 2024 09:04:21 +0100
In-Reply-To: <20240412073530.2222496-1-dwmw2@infradead.org>
References: <20240412073530.2222496-1-dwmw2@infradead.org>
Message-Id: <20240412073530.2222496-3-dwmw2@infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 11 Mar 2024 13:04:07 +0000
Subject: [PATCH v2 2/2] arm64: acpi: Honour firmware_signature field of FACS,
 if it exists
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: David Woodhouse <dwmw@amazon.co.uk>

If the firmware_signature changes then OSPM should not attempt to resume
from hibernate, but should instead perform a clean reboot. Set the global
swsusp_hardware_signature to allow the generic code to include the value
in the swsusp header on disk, and perform the appropriate check on resume.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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


