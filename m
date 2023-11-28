Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0367FB3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344059AbjK1IPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjK1IPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:15:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB15BB0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:15:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52388C433CA;
        Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701159324;
        bh=zQr1xBOtXgf76hvY3IaRnRFWQ2A+yIS/Y/GYRlcI1+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbg6Wp9WUsqKZ/go1Xy9CpNUUL5gGB+L9as+dv+nZXUrIo9TRY0hfg8h0t8wJUiqA
         y8pqgLchu0CwQpioQQciJqoagJ0k1BFdLLCfY0YDjWEo2KZs3XaKSH1DAx8guKnXGH
         44B+/b3B+6BDBDOeq9dpGHs/dqUbtRpd7K2Bq0uPnUBeotFvBp0TvhLAMYOWGFNbm0
         zr3s4TQsCgcCGd0Qz/ICu51hl2iYCLXCokjtq6uHuS0n/QjopHSEafFy7V8jnV++Ly
         Nf3Tbt4m31SAfFFS9yX+GqVx+KwkporAobnNs+QSkxPq2NVpXogaGX2DSSZKZJEGwc
         0lSOjZbR/fNIw==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r7tG4-00053x-2h;
        Tue, 28 Nov 2023 09:15:52 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/6] PCI/ASPM: Clean up disable link state parameter
Date:   Tue, 28 Nov 2023 09:15:11 +0100
Message-ID: <20231128081512.19387-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the current 'sem' parameter to the __pci_disable_link_state()
helper with a more descriptive 'locked' parameter, which indicates
whether a pci_bus_sem read lock is already held.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 5eb462772354..d7a3ca555cc1 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1041,7 +1041,7 @@ static struct pcie_link_state *pcie_aspm_get_link(struct pci_dev *pdev)
 	return bridge->link_state;
 }
 
-static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
+static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked)
 {
 	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
 
@@ -1060,7 +1060,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		return -EPERM;
 	}
 
-	if (sem)
+	if (!locked)
 		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	if (state & PCIE_LINK_STATE_L0S)
@@ -1082,7 +1082,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 		link->clkpm_disable = 1;
 	pcie_set_clkpm(link, policy_to_clkpm_state(link));
 	mutex_unlock(&aspm_lock);
-	if (sem)
+	if (!locked)
 		up_read(&pci_bus_sem);
 
 	return 0;
@@ -1090,7 +1090,7 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
-	return __pci_disable_link_state(pdev, state, false);
+	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
 
@@ -1105,7 +1105,7 @@ EXPORT_SYMBOL(pci_disable_link_state_locked);
  */
 int pci_disable_link_state(struct pci_dev *pdev, int state)
 {
-	return __pci_disable_link_state(pdev, state, true);
+	return __pci_disable_link_state(pdev, state, false);
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
-- 
2.41.0

