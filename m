Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C687F3628
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjKUSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjKUShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:37:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD9E12E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:37:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8D0C433C9;
        Tue, 21 Nov 2023 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591827;
        bh=C6m0QxEEEagkK0ogkwO9p1q1S1UTNszLjTNwB5ZbW2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYxBaRDnE5422oa0tSYk6ckiko3rH9YAi6UgUhSK63hSS79pUTTmAbz3duI5LgPXL
         xUmWNDGVqEUZirq7hvviy1DhoHjE9wyGi6o+V4djOx9guALh5RmKqI/Pyogzd7A4WL
         xJ8Vi/+n1jLv3C0HQ2y4tOBuffpM6onr7Mwg//wmIiYMwb7UDuR9IC2/wbe5UmOfc5
         sFk5ZS9+omU7vx0BT4N00pPVFEimorsZQNEZcDddZsIpcG4e51iHO+B6HEwdQ1zqEz
         WpCVQIho4E3i+mUgNCxea9M7C5INUvUmTsjLroxI6WMtdwwR7QgkEMBOt1NUWyDiQD
         fpO85TRmUbsJg==
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
Subject: [PATCH 9/9] x86/pci: Reorder pci_mmcfg_arch_map() definition before calls
Date:   Tue, 21 Nov 2023 12:36:43 -0600
Message-Id: <20231121183643.249006-10-helgaas@kernel.org>
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

The typical style is to define functions before calling them.  Move
pci_mmcfg_arch_map() and pci_mmcfg_arch_unmap() earlier so they're defined
before they're called.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig_64.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
index dfdeac0a7571..cb5aa79a759e 100644
--- a/arch/x86/pci/mmconfig_64.c
+++ b/arch/x86/pci/mmconfig_64.c
@@ -111,6 +111,25 @@ static void __iomem *mcfg_ioremap(struct pci_mmcfg_region *cfg)
 	return addr;
 }
 
+int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
+{
+	cfg->virt = mcfg_ioremap(cfg);
+	if (!cfg->virt) {
+		pr_err("can't map ECAM at %pR\n", &cfg->res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
+{
+	if (cfg && cfg->virt) {
+		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
+		cfg->virt = NULL;
+	}
+}
+
 int __init pci_mmcfg_arch_init(void)
 {
 	struct pci_mmcfg_region *cfg;
@@ -133,22 +152,3 @@ void __init pci_mmcfg_arch_free(void)
 	list_for_each_entry(cfg, &pci_mmcfg_list, list)
 		pci_mmcfg_arch_unmap(cfg);
 }
-
-int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
-{
-	cfg->virt = mcfg_ioremap(cfg);
-	if (!cfg->virt) {
-		pr_err("can't map ECAM at %pR\n", &cfg->res);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
-{
-	if (cfg && cfg->virt) {
-		iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
-		cfg->virt = NULL;
-	}
-}
-- 
2.34.1

