Return-Path: <linux-kernel+bounces-84043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9486A1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA591F2C9E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F115A480;
	Tue, 27 Feb 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6qeOqOV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D4158D9C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069118; cv=none; b=pzdAyBDAPKH87BnC3kyCev2UsVB3II7NenMRwgOICBE5afN4fIUCm4+zGW0jXyyATLQI7GHQ+bNag+uO3etfJq4ymzeqZLvmazG0yWuhWi7A/AdwffAVWbxAGajH8rQLfo3siKWtHk6fy2Zaiu//MnlrQ0hMG/+FXqhVeZth7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069118; c=relaxed/simple;
	bh=pJgXfq63C3arXvCjRGyfK5PtseQeqyNecMgpXB9cqPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pK7PW2qaEYp2mrvmdDCDiQ7XZ8YDBDNCucVBK+Ipx5RNqDkpa4IrCKbhhmIZtmvYGR8ATTcoLtYXJWZHComLJbDg9ZR5AZ0FtLW37GAkojwbdTy+zeHoVvXj6N1IY82GeUAy0oimia5IeDGuiAZ/KBNpKYz8b6HMGQ+/IoYqZfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6qeOqOV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069117; x=1740605117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pJgXfq63C3arXvCjRGyfK5PtseQeqyNecMgpXB9cqPk=;
  b=G6qeOqOVvKITllVGcTyrGD4mog8VP58gl67fdYrdCW9nXZhQ5Nhezks/
   /UUos3M7kMTtmMPKK5a00SCtPYMTkS+iPNFtOyWUltbDc+8J5CLQrCh8l
   PXG+X2ISRBAvrNMp+A9YNbXpfZVzOribuPmhvMP/VLwU/A8hG23uKLLyT
   lUkkiqWeZIcbLA3UrPGNo+Wiyw8xhR3knx6rUb2KOejPGQ90U3mdJIKGv
   z/mU72R8R/oU3uiSynMP9R/GZSqcS0i+uaDB4qUHyorAbTS2gZuv/DaII
   f21x9W/NJk90j3QZbYS12bHILwpYiNmbHuXbk1yd2jxx7oGiKhIE/llRw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3567063"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3567063"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032916"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032916"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:25:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 83282EFB; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
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
Subject: [PATCHv8 12/17] x86/acpi: Rename fields in acpi_madt_multiproc_wakeup structure
Date: Tue, 27 Feb 2024 23:24:47 +0200
Message-ID: <20240227212452.3228893-13-kirill.shutemov@linux.intel.com>
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

To prepare for the addition of support for MADT wakeup structure version
1, it is necessary to provide more appropriate names for the fields in
the structure.

The field 'mailbox_version' renamed as 'version'. This field signifies
the version of the structure and the related protocols, rather than the
version of the mailbox. This field has not been utilized in the code
thus far.

The field 'base_address' renamed as 'mailbox_address' to clarify the
kind of address it represents. In version 1, the structure includes the
reset vector address. Clear and distinct naming helps to prevent any
confusion.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 include/acpi/actbl2.h              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d222be8d7a07..004801b9b151 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -75,7 +75,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
 
 	cpu_hotplug_disable_offlining();
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 9775384d61c6..e1a395af7591 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1117,9 +1117,9 @@ struct acpi_madt_generic_translator {
 
 struct acpi_madt_multiproc_wakeup {
 	struct acpi_subtable_header header;
-	u16 mailbox_version;
+	u16 version;
 	u32 reserved;		/* reserved - must be zero */
-	u64 base_address;
+	u64 mailbox_address;
 };
 
 #define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE        2032
-- 
2.43.0


