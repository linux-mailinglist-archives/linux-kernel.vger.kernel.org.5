Return-Path: <linux-kernel+bounces-84042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076B686A1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06141F2D0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25315958B;
	Tue, 27 Feb 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaeI+QjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F54158D99
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069117; cv=none; b=MNYeErTxQ8ff1AQHsIghf1qGikJXZyST5nsqB3KGV9cLJ7YaUo2rlBkI86CX7lJ8QJ219oo5ty+iW565Y4dmmKNfNX6HLad9AYStqUaAl+hXdpNVVUz6AbB3PBQfLJKyDy5Oey3QQ+xQ4nlI9ngWGoRoxd8T9sklAfN1XSolt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069117; c=relaxed/simple;
	bh=4OahAA5tbkCWt5kWDDzHkciJDRb/0EhPa8AF3hktH9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpTeHu+PK4Hd7AFPKumM/bdK0qAk62tCa/k3PpGkS5H5oAj3UY+vEW5tgEVKdsWv6itSctDv7aVdS6c7Htr97nASgaKiqS+5IIeMrRAZAprEcmPlf783Km5uFcokc1/qNG+hkPUlHPWB5ZMXmX0ejp6vQDLUdQgLbCAdSgK2+l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaeI+QjV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069117; x=1740605117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OahAA5tbkCWt5kWDDzHkciJDRb/0EhPa8AF3hktH9I=;
  b=YaeI+QjVzbuMKqzfJYi/0W4Ha0jhhlnDENaJBftPVVOL9G0CmCG/3GsB
   kjaM+zZNQiEzhttFeSllo1youkNJD0P/DvJNLz/ZZ7SX21kUOW5sNP5IY
   bC8ViRO/Kx8+LhbY+KQmc8IB4O+CjKwTgKDN2qzGRgPqGpZDEswsbxmA8
   95H/blNxGXsCUtElOnl4JB7v9kCwXk8oTdtv012/fkkdAGJub05XiQALf
   Z1ZOV9ZYw79KLbt+f7u+y0eaEO7xay70qdGBTB6/KgRFiZBxRZ9wAdW7C
   loRGwy5oBmPI19+WmLehw/CSMffkewl8BJCl8bvUwkI5BnE09tvTKENw1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3567067"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3567067"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032918"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032918"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 90B3BF27; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 13/17] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date: Tue, 27 Feb 2024 23:24:48 +0200
Message-ID: <20240227212452.3228893-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI MADT doesn't allow to offline a CPU after it was onlined. This
limits kexec: the second kernel won't be able to use more than one CPU.

To prevent a kexec kernel from onlining secondary CPUs invalidate the
mailbox address in the ACPI MADT wakeup structure which prevents a
kexec kernel to use it.

This is safe as the booting kernel has the mailbox address cached
already and acpi_wakeup_cpu() uses the cached value to bring up the
secondary CPUs.

Note: This is a Linux specific convention and not covered by the
      ACPI specification.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 004801b9b151..30820f9de5af 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -14,6 +14,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_afte
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
 	 *
@@ -64,6 +69,28 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 	return 0;
 }
 
+static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
+{
+	cpu_hotplug_disable_offlining();
+
+	/*
+	 * ACPI MADT doesn't allow to offline a CPU after it was onlined. This
+	 * limits kexec: the second kernel won't be able to use more than one CPU.
+	 *
+	 * To prevent a kexec kernel from onlining secondary CPUs invalidate the
+	 * mailbox address in the ACPI MADT wakeup structure which prevents a
+	 * kexec kernel to use it.
+	 *
+	 * This is safe as the booting kernel has the mailbox address cached
+	 * already and acpi_wakeup_cpu() uses the cached value to bring up the
+	 * secondary CPUs.
+	 *
+	 * Note: This is a Linux specific convention and not covered by the
+	 *       ACPI specification.
+	 */
+	mp_wake->mailbox_address = 0;
+}
+
 int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 			      const unsigned long end)
 {
@@ -77,7 +104,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
-	cpu_hotplug_disable_offlining();
+	acpi_mp_disable_offlining(mp_wake);
 
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
-- 
2.43.0


