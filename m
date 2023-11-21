Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3477F3624
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjKUShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKUShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:37:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EC118C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:36:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA9CC433CB;
        Tue, 21 Nov 2023 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591819;
        bh=ks9s3ODzJPgxlrZ34fpMdEf9kOaOEvMAaQEGGAEQrtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uwt2R144vun2y7PN5CRe6Kc/nrvVoO5JerX2sRIJ/2APNdfidyj1Y3Hx87T/VAoNN
         wgLL46K7seOlNSRQ5p0o7QcFDTg+14KqqeW9SsKKH+nzv6CPZutqVrsBzSr62pFQi+
         CCqFNky92FqTQr7ZpTxNOS0tQsAu+vBjv0aJiENTIxpxsKKY7hKET+TdS1fuwXzoXO
         9CcUzr+G6X5Qvo1Om4pOhB3ZirUSTardxrB+atcxCZZdcFB6vL+Xn3Z6uB6of2H5uw
         NgE82W22Io4RT4kyCC0aXAihXfa3eYQBvWeqWIGrMu365JMVE+cK0ghJFAKWxbA498
         8YfO6tobt2+VQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Tomasz Pala <gotar@polanet.pl>,
        Sebastian Manciulea <manciuleas@protonmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/9] x86/pci: Rename acpi_mcfg_check_entry() to acpi_mcfg_valid_entry()
Date:   Tue, 21 Nov 2023 12:36:39 -0600
Message-Id: <20231121183643.249006-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121183643.249006-1-helgaas@kernel.org>
References: <20231121183643.249006-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

"acpi_mcfg_check_entry()" doesn't give a hint about what the return value
means.  Rename it to "acpi_mcfg_valid_entry()", convert the return value to
bool, and update the return values and callers to match so testing
"if (acpi_mcfg_valid_entry())" makes sense.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 896cc11013bd..91fd7921d221 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -576,22 +576,22 @@ static void __init pci_mmcfg_reject_broken(int early)
 	}
 }
 
-static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
-					struct acpi_mcfg_allocation *cfg)
+static bool __init acpi_mcfg_valid_entry(struct acpi_table_mcfg *mcfg,
+					 struct acpi_mcfg_allocation *cfg)
 {
 	if (cfg->address < 0xFFFFFFFF)
-		return 0;
+		return true;
 
 	if (!strncmp(mcfg->header.oem_id, "SGI", 3))
-		return 0;
+		return true;
 
 	if ((mcfg->header.revision >= 1) && (dmi_get_bios_year() >= 2010))
-		return 0;
+		return true;
 
 	pr_err("ECAM at %#llx for %04x [bus %02x-%02x] is above 4GB, ignored\n",
 	       cfg->address, cfg->pci_segment, cfg->start_bus_number,
 	       cfg->end_bus_number);
-	return -EINVAL;
+	return false;
 }
 
 static int __init pci_parse_mcfg(struct acpi_table_header *header)
@@ -622,7 +622,7 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
 	cfg_table = (struct acpi_mcfg_allocation *) &mcfg[1];
 	for (i = 0; i < entries; i++) {
 		cfg = &cfg_table[i];
-		if (acpi_mcfg_check_entry(mcfg, cfg)) {
+		if (!acpi_mcfg_valid_entry(mcfg, cfg)) {
 			free_all_mmcfg();
 			return -ENODEV;
 		}
-- 
2.34.1

