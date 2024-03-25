Return-Path: <linux-kernel+bounces-116862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5888A478
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789391C3999B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD31BF208;
	Mon, 25 Mar 2024 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X54ZwAxi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15DA14D456
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363225; cv=none; b=gb8P/JBVNSpSh2NoLZtUyyFJIwWsN8odPJbZGoxmF/817RGvJf7HMA2ypceTFy8/QQQ1OPQGbEMQz/A++9p4IkJ7lcKbrohyqHCU1KxnQYGYygO5sYpBRSASFeFkcUutoOGliz02unBKB07/a7z70IVB6ojwzGlymgPdpziLA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363225; c=relaxed/simple;
	bh=4OahAA5tbkCWt5kWDDzHkciJDRb/0EhPa8AF3hktH9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPxIVm87xvzdyGDyELpK2mZvnG38fLuddmF2uKjUrBoRpinDtsb1+AxfINdvDofxk8fwzVjzy6uUvNpfcGx8TEN6zM78s9vLwmb9nZ9hsKn7O5fsxvpEGGZKJ/xjJY+L1b2SMJVoyncAXC+SuFcbrHDOAZhCly4Q3ua3HKsYWFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X54ZwAxi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363220; x=1742899220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OahAA5tbkCWt5kWDDzHkciJDRb/0EhPa8AF3hktH9I=;
  b=X54ZwAxi2iMQ0RUgHUGbLrYDqVA0TzHe5xf5j2yQ2C7jtjRcr0lnLs+1
   sDaKfqXNHBdhzYBUAvspqSrtqwixg87kp3eAl9CFqr54mDMnjWpXDXNPD
   BC+w1eiKHn9MhE5y1xDBXPt4FyE7SCC0xAMQTsymyXjlIReRoXIl6MGz7
   9JmSoJg1Pxs1hGOSQCM/+1+86gPIq1V/W4Rmvh5MVcaz5udyKfWl/J9Mj
   D4/CrIrhfUuP/VdZBKu4FzrWJSxTKoEJXSHaknIEU7oWh49dcvD9VAKNo
   rOLLv7snKC3exv6AjD5x4giMyR4CphHhFf3l9E+4n8dJ4bzkUTAQgywFA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561390"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561390"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070155"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070155"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 97035F4F; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
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
Subject: [PATCHv9 13/17] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date: Mon, 25 Mar 2024 12:39:07 +0200
Message-ID: <20240325103911.2651793-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
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


