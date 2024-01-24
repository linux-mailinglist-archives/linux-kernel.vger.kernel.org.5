Return-Path: <linux-kernel+bounces-37039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56983AA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE361C26D95
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F277F01;
	Wed, 24 Jan 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaS7l749"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0C7764C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101148; cv=none; b=tvbv5ShKyaCA9rPzsQeaCOeqSqxGgkKWN90RZtFHy3SBCeiotOi9a2OAdZTWoavyq4Qq4YRuPZ+5WneP/CgxnAVYu9XZEPkNq9AM5FSfDgOc+EhMW2q0CZXHMj+MnZk0HP+YBTTGqNVbXVO7vQMeYQBJSXZOagfT92+Lf97FQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101148; c=relaxed/simple;
	bh=S6F/Ky7eP00etA13aVi6LSez70wEvbCqE2JWP4lJSJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqq/dH8hvOuU+8/05LYASVBwN1cxMJrlkBC5v24VEeTpR/0r486M/AZdQLel+SYxc/1JmiA3qCVJ2w5OAg/BaALHUSQqzAY3mwIjakK62LdZDW6zbO0ENJtaa9G+OTv2owaKlHOibZpMZ6Yhq77vSdvG5g506PhzHq5MtcN7KTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaS7l749; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101146; x=1737637146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S6F/Ky7eP00etA13aVi6LSez70wEvbCqE2JWP4lJSJ4=;
  b=MaS7l749X3/vP1jrQPzVafgoQQHmBJF7POwuc5BOe5e9mWrB8kzvYRf2
   YOJk2RiuORQxGEvtFYuLWyVcAmHjFCvkSTicw3JD9RfdNpz5BXQzKu7oC
   biN+5svn1+FMPqoR97Mx1HfJ2m21HbHK1PuvunyxPMgF5TxtB924gIJvd
   cMzlGh9Jrw61hjqZ0IADZD0s7dVd4DFndVcJhJ5yAe3osXikIo9iEP/dx
   M7VqmJysRVGm/Lv6yx9HIS84P8tGJnZ1PCZDvlbVSHABTCDuL1xft7Yni
   vaVNwxKDIL6GBD72s5i0f9EsOjtKfa118A3Mf6H1s29Oz6s9XYJW9/XPX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110877"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110877"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924193"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924193"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:58:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 21B765E8; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
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
Subject: [PATCHv6 02/16] x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init
Date: Wed, 24 Jan 2024 14:55:43 +0200
Message-ID: <20240124125557.493675-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
during ACPI MADT init and never changed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 7f164d38bd0b..cf79ea6f3007 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -6,10 +6,10 @@
 #include <asm/processor.h>
 
 /* Physical address of the Multiprocessor Wakeup Structure mailbox */
-static u64 acpi_mp_wake_mailbox_paddr;
+static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
 
 static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
 {
-- 
2.43.0


