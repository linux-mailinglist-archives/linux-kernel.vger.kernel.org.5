Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C457F3625
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKUShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbjKUShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:37:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9FD69
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26020C433C7;
        Tue, 21 Nov 2023 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700591821;
        bh=BaGWM0t7GEAWEpUYJDFz7JhqqKSR40f2L/PBdVsOqng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0E2vShEm0XpMfllM8eRTNna8gzh8qprsuaKY3mDojSp438x8KtB0OFjl6eDraFt+
         h0NIwXDIdzQ/ExAxjCmrOiPIKeb0DV6fkbqrkbZPyUD12dFb9Ry0C1YhAOYWG5b3o9
         5NMedbICDnQQOcHNCrcX+62sj57QcBQtYTuqNVt8R8hLaW/AxGVr4ORgApFCy0gHLj
         LwWUur4ZX/eKEDmoFQRlUIBtWFgFCAk6QBql7VJsq4Ug380g4vBeX+tSUNKjnBpIm9
         wd4TPRA6eOKOX1uixpfOQYDJ1FCg9kfishS3jzDD0t1C12hrOgICyR9Hnj0Zqaebfb
         A9aVTx2vMx9+w==
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
Subject: [PATCH 6/9] x86/pci: Rename pci_mmcfg_check_reserved() to pci_mmcfg_reserved()
Date:   Tue, 21 Nov 2023 12:36:40 -0600
Message-Id: <20231121183643.249006-7-helgaas@kernel.org>
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

"pci_mmcfg_check_reserved()" doesn't give a hint about what the boolean
return value means.  Rename it to pci_mmcfg_reserved() so testing
"if (pci_mmcfg_reserved())" makes sense.

Update callers to treat the return value as boolean instead of comparing
with 0.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 91fd7921d221..b36c10e86505 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -512,8 +512,8 @@ static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 	return true;
 }
 
-static bool __ref
-pci_mmcfg_check_reserved(struct device *dev, struct pci_mmcfg_region *cfg, int early)
+static bool __ref pci_mmcfg_reserved(struct device *dev,
+				     struct pci_mmcfg_region *cfg, int early)
 {
 	struct resource *conflict;
 
@@ -567,7 +567,7 @@ static void __init pci_mmcfg_reject_broken(int early)
 	struct pci_mmcfg_region *cfg;
 
 	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
-		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
+		if (!pci_mmcfg_reserved(NULL, cfg, early)) {
 			pr_info("not using ECAM (%pR not reserved)\n",
 				&cfg->res);
 			free_all_mmcfg();
@@ -796,7 +796,7 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
 	if (cfg == NULL) {
 		dev_warn(dev, "fail to add ECAM (out of memory)\n");
 		rc = -ENOMEM;
-	} else if (!pci_mmcfg_check_reserved(dev, cfg, 0)) {
+	} else if (!pci_mmcfg_reserved(dev, cfg, 0)) {
 		dev_warn(dev, FW_BUG "ECAM %pR isn't reserved\n",
 			 &cfg->res);
 	} else {
-- 
2.34.1

