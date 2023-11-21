Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852C7F3619
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjKUShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbjKUSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:36:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF99E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:36:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8415DC433C8;
        Tue, 21 Nov 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591815;
        bh=/+1z4n3zLSsLOEPahOuM6VrEokGId5zDDG9/K1UTAz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7hbOnQqY7I3WIux2m3nvTz/eLyhtxQNfOgreGyCDVB1agYh5RVhSlvc+5ajPkjSe
         jwP1WpG+GDZCO5Mz6l8PZUL+2uOcL5wGB2SR4x5f+CNi7SnPdin/f2btbDn+w1W7Do
         2pU38PhGVUAW9DQcd/1ASXXINLp9E3lm30eI3a3fHcjH4njL+TYaABQcC7IcAlzKJr
         OtsbRQfKQKp4BmdGXipWVSNn93kWlPb0z3ZMur9+RNg49WsS/RIiqAv8YVHWfxg85k
         t5CUocz5OqO2JU3+ouBJagdGrhzT+FOfNHns1Chzp1gZg/tKohY9FmpX6DuPgs9KaL
         zla8VOcHqdPbQ==
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
Subject: [PATCH 3/9] x86/pci: Add MCFG debug logging
Date:   Tue, 21 Nov 2023 12:36:37 -0600
Message-Id: <20231121183643.249006-4-helgaas@kernel.org>
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

MCFG handling is a frequent source of problems.  Add more logging to aid in
debugging.

Enable the logging with CONFIG_DYNAMIC_DEBUG=y and the kernel boot
parameter 'dyndbg="file arch/x86/pci +p"'.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c            |  3 +++
 arch/x86/pci/mmconfig-shared.c | 23 ++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index ea2eb2ec90e2..55c4b07ec1f6 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -283,6 +283,9 @@ static int setup_mcfg_map(struct acpi_pci_root_info *ci)
 	info->mcfg_added = false;
 	seg = info->sd.domain;
 
+	dev_dbg(dev, "%s(%04x %pR ECAM %pa)\n", __func__, seg,
+		&root->secondary, &root->mcfg_addr);
+
 	/* return success if MMCFG is not in use */
 	if (raw_pci_ext_ops && raw_pci_ext_ops != &pci_mmcfg)
 		return 0;
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 64c39a23d37a..bc1312d920da 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -579,7 +579,8 @@ static void __init pci_mmcfg_reject_broken(int early)
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
 		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
-			pr_info(PREFIX "not using MMCONFIG\n");
+			pr_info(PREFIX "not using MMCONFIG (%pR not reserved)\n",
+				&cfg->res);
 			free_all_mmcfg();
 			return;
 		}
@@ -676,6 +677,8 @@ static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
 
 static void __init __pci_mmcfg_init(int early)
 {
+	pr_debug(PREFIX "%s(%s)\n", __func__, early ? "early" : "late");
+
 	pci_mmcfg_reject_broken(early);
 	if (list_empty(&pci_mmcfg_list))
 		return;
@@ -702,6 +705,8 @@ static int __initdata known_bridge;
 
 void __init pci_mmcfg_early_init(void)
 {
+	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+
 	if (pci_probe & PCI_PROBE_MMCONF) {
 		if (pci_mmcfg_check_hostbridge())
 			known_bridge = 1;
@@ -715,6 +720,8 @@ void __init pci_mmcfg_early_init(void)
 
 void __init pci_mmcfg_late_init(void)
 {
+	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+
 	/* MMCONFIG disabled */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return;
@@ -735,6 +742,8 @@ static int __init pci_mmcfg_late_insert_resources(void)
 
 	pci_mmcfg_running_state = true;
 
+	pr_debug(PREFIX "%s() pci_probe %#x\n", __func__, pci_probe);
+
 	/* If we are not using MMCONFIG, don't insert the resources. */
 	if ((pci_probe & PCI_PROBE_MMCONF) == 0)
 		return 1;
@@ -744,9 +753,12 @@ static int __init pci_mmcfg_late_insert_resources(void)
 	 * marked so it won't cause request errors when __request_region is
 	 * called.
 	 */
-	list_for_each_entry(cfg, &pci_mmcfg_list, list)
-		if (!cfg->res.parent)
+	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
+		if (!cfg->res.parent) {
+			pr_debug(PREFIX "%s() insert %pR\n", __func__, &cfg->res);
 			insert_resource(&iomem_resource, &cfg->res);
+		}
+	}
 
 	return 0;
 }
@@ -766,6 +778,8 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	struct resource *tmp = NULL;
 	struct pci_mmcfg_region *cfg;
 
+	dev_dbg(dev, "%s(%04x [bus %02x-%02x])\n", __func__, seg, start, end);
+
 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
 		return -ENODEV;
 
@@ -810,8 +824,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 				 "%s %pR\n",
 				 &cfg->res, tmp->name, tmp);
 		} else if (pci_mmcfg_arch_map(cfg)) {
-			dev_warn(dev, "fail to map MMCONFIG %pR.\n",
-				 &cfg->res);
+			dev_warn(dev, "fail to map MMCONFIG %pR\n", &cfg->res);
 		} else {
 			list_add_sorted(cfg);
 			dev_info(dev, "MMCONFIG at %pR (base %#lx)\n",
-- 
2.34.1

