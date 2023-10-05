Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA12B7BA19A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjJEOoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbjJEOiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:38:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9656621
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514684; x=1728050684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nsB0LfqQYj2RZjcPwh1MZGMdJcZ9TNW2jF9KJqnidVg=;
  b=OUxVtQKWMIP+g0iMP+8oPId3F+iUQC87X6IfZeAjARd8yoUQBpNgyzlK
   4AsTFlBdaGkqIGdttsMV6cEhLEPgeazCryncFxooaFRYqIjLQJNVaVjdX
   UXVdUK2xzCb/5lj0hSuP7OMlFzuwEL61yPrn5IiBgjbAvWqNADx3Yfus0
   W0B4RIGLuuYWrRrNomoARfx/Ys6z1YUNSF9PlFtbHZ2v4vaNRrn2to6x4
   gUFP5uTCmUO5vuTICuXuQsxwVDIS38ml2z/js9/t4R3iEwecJHN5E7rDr
   W4UW3o+noL2ZIdg3buBqrSumOAc50tjO9hRCSvfMyMyHmsqeAVabU76GB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380767194"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380767194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="728449270"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="728449270"
Received: from skwasnia-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.222.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 06:14:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8835310A157; Thu,  5 Oct 2023 16:14:14 +0300 (+03)
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
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 12/13] x86/acpi: Do not attempt to bring up secondary CPUs in kexec case
Date:   Thu,  5 Oct 2023 16:14:01 +0300
Message-ID: <20231005131402.14611-13-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI MADT doesn't allow to offline CPU after it got woke up. It limits
kexec: target kernel won't be able to use more than one CPU.

Zero out mailbox address in the ACPI MADT wakeup structure to indicate
that the mailbox is not usable.

This is Linux-specific protocol and not reflected in ACPI spec.

Booting the target kernel with signle CPU is enough to cover the most
common case for kexec -- kdump.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 15bdf10b1393..4e92d1d4a5fa 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -9,6 +9,11 @@ static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
 static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
 {
+	if (!acpi_mp_wake_mailbox_paddr) {
+		pr_warn_once("No MADT mailbox: cannot bringup secondary CPUs. Booting with kexec?\n");
+		return -EOPNOTSUPP;
+	}
+
 	/*
 	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
 	 *
@@ -78,6 +83,18 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 	/* Disable CPU onlining/offlining */
 	cpu_hotplug_not_supported();
 
+	/*
+	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
+	 * It limits kexec: target kernel won't be able to use more than
+	 * one CPU.
+	 *
+	 * Zero out mailbox address in the ACPI MADT wakeup structure to
+	 * indicate that the mailbox is not usable.
+	 *
+	 * This is Linux-specific protocol and not reflected in ACPI spec.
+	 */
+	mp_wake->base_address = 0;
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
-- 
2.41.0

