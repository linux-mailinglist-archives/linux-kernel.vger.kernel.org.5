Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2F7809A0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573005AbjLHDIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbjLHDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:08:08 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB5A30DC;
        Thu,  7 Dec 2023 18:57:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vy1bwwH_1702004224;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vy1bwwH_1702004224)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 10:57:05 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: [PATCH v12 3/5] PCI: Move pci_clear_and_set_dword() helper to PCI header
Date:   Fri,  8 Dec 2023 10:56:50 +0800
Message-Id: <20231208025652.87192-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clear and set pattern is commonly used for accessing PCI config,
move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
In addition, rename to pci_clear_and_set_config_dword() to retain the
"config" information and match the other accessors.

No functional change intended.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/pci/access.c    | 12 ++++++++
 drivers/pci/pcie/aspm.c | 65 +++++++++++++++++++----------------------
 include/linux/pci.h     |  2 ++
 3 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 6554a2e89d36..6449056b57dd 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
 	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
 }
 EXPORT_SYMBOL(pci_write_config_dword);
+
+void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
+				    u32 clear, u32 set)
+{
+	u32 val;
+
+	pci_read_config_dword(dev, pos, &val);
+	val &= ~clear;
+	val |= set;
+	pci_write_config_dword(dev, pos, val);
+}
+EXPORT_SYMBOL(pci_clear_and_set_config_dword);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1bf630059264..9dbc4d3c2591 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -423,17 +423,6 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 	}
 }
 
-static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
-				    u32 clear, u32 set)
-{
-	u32 val;
-
-	pci_read_config_dword(pdev, pos, &val);
-	val &= ~clear;
-	val |= set;
-	pci_write_config_dword(pdev, pos, val);
-}
-
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l12_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
@@ -494,10 +483,12 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
 
 	if (pl1_2_enables || cl1_2_enables) {
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_L1_2_MASK, 0);
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_L1_2_MASK, 0);
+		pci_clear_and_set_config_dword(child,
+					       child->l1ss + PCI_L1SS_CTL1,
+					       PCI_L1SS_CTL1_L1_2_MASK, 0);
+		pci_clear_and_set_config_dword(parent,
+					       parent->l1ss + PCI_L1SS_CTL1,
+					       PCI_L1SS_CTL1_L1_2_MASK, 0);
 	}
 
 	/* Program T_POWER_ON times in both ports */
@@ -505,22 +496,26 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
 
 	/* Program Common_Mode_Restore_Time in upstream device */
-	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
 
 	/* Program LTR_L1.2_THRESHOLD time in both ports */
-	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
-	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
+				       ctl1);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
+				       ctl1);
 
 	if (pl1_2_enables || cl1_2_enables) {
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
-					pl1_2_enables);
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
-					cl1_2_enables);
+		pci_clear_and_set_config_dword(parent,
+					       parent->l1ss + PCI_L1SS_CTL1, 0,
+					       pl1_2_enables);
+		pci_clear_and_set_config_dword(child,
+					       child->l1ss + PCI_L1SS_CTL1, 0,
+					       cl1_2_enables);
 	}
 }
 
@@ -680,10 +675,10 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 	 */
 
 	/* Disable all L1 substates */
-	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_L1SS_MASK, 0);
-	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_L1SS_MASK, 0);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, 0);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, 0);
 	/*
 	 * If needed, disable L1, and it gets enabled later
 	 * in pcie_config_aspm_link().
@@ -706,10 +701,10 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 		val |= PCI_L1SS_CTL1_PCIPM_L1_2;
 
 	/* Enable what we need to enable */
-	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_L1SS_MASK, val);
-	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-				PCI_L1SS_CTL1_L1SS_MASK, val);
+	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, val);
+	pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				       PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8c7c2c3c6c65..72b0fb82a820 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1213,6 +1213,8 @@ int pci_read_config_dword(const struct pci_dev *dev, int where, u32 *val);
 int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val);
 int pci_write_config_word(const struct pci_dev *dev, int where, u16 val);
 int pci_write_config_dword(const struct pci_dev *dev, int where, u32 val);
+void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
+				    u32 clear, u32 set);
 
 int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val);
 int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val);
-- 
2.39.3

