Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C0A80438B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjLEAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343693AbjLEApa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:45:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C26A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701737136; x=1733273136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/WHs4jb2k1fyD6oT320fhQc0wtdLRiTKuUWbSP8aYs=;
  b=WKISbf+hEU7czwXPrDDeSg/IZZzV/rYH9B9wnom8GiSCzZ6bhRHl/AKL
   0pACJNwQTVh1GU5DuFLYpbF7ytqUxypSJknXxrYcBjutH2HmYv9HPTNNO
   VWpnYt1Fk55raoXEAHXLaGOjPEsK3wkfz2kJ8BlfDOqAe0dXB58ywCH6o
   13T70juYR9lEtgSrh908y01g/fu/xpsNR5COAk1juLtek6pUvMqZdmo6T
   W6F5+fsmGMIjSltBD48b24pCRLYaZE8z65F0mwiND9F5EwheVtjrzDyK2
   RiIWIKmpKRwjNUNhz8P6XGI3wXjJR6GuMxEKQWl/uyg2GRHNnHMEY80oi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="392688687"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="392688687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="888704411"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="888704411"
Received: from abijaz-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.61.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 16:45:30 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B75CB10A450; Tue,  5 Dec 2023 03:45:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 13/14] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date:   Tue,  5 Dec 2023 03:45:09 +0300
Message-ID: <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
kexec: the second kernel won't be able to use more than one CPU.

Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
The acpi_wakeup_cpu() will use it to bring up secondary cpus.

Zero out mailbox address in the ACPI MADT wakeup structure to indicate
that the mailbox is not usable.  This prevents the kexec()-ed kernel
from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
only be able to use the boot CPU.

This is Linux-specific protocol and not reflected in ACPI spec.

Booting the second kernel with signle CPU is enough to cover the most
common case for kexec -- kdump.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 386adbb03094..5d92d12f1042 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -13,6 +13,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_afte
 
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
@@ -78,6 +83,23 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	cpu_hotplug_disable_offlining();
 
+	/*
+	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
+	 * It limits kexec: the second kernel won't be able to use more than
+	 * one CPU.
+	 *
+	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
+	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
+	 *
+	 * Zero out mailbox address in the ACPI MADT wakeup structure to
+	 * indicate that the mailbox is not usable.  This prevents the
+	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
+	 * makes the kexec()-ed kernel only be able to use the boot CPU.
+	 *
+	 * This is Linux-specific protocol and not reflected in ACPI spec.
+	 */
+	mp_wake->mailbox_address = 0;
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
-- 
2.41.0

