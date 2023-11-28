Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7497FB3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbjK1IPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbjK1IPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAA100
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:15:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1DFC433CC;
        Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701159324;
        bh=ldSxVLm151+9Q08xzcfgehlwNmHacduIvn8mLdpw3MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KePGVFYkKCg+fXwzHWo2HnyjhX9Zr2jHkmy1eiykrci56JAFiNLHSHkkizTcxo6eR
         uV0uD5HK0PstpCYwy9pmIUtUF5y29g+cvKeBILu5wlhdTCUa9W1cazuJSw8mi5eWLP
         /AN5grugmjvSA13X9F2lbf2ThCiNRQXxQ+pLo+A/7idYbx1GVcXs7pBpepX7aY0hk0
         MrRzhRjdR7dcz1dBvDcOxRdD6dliCErptS7/zOTehlO1g/C1CHzmsKZsC9Pb73EI5P
         EpJpJoiD7TctTPQO4SHuVY5TcDNc+3fK9GvCZvqRVAjS095HAK8WgTlbJFPqsj2fNN
         TxIQQDR1TthLQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r7tG4-00053t-2C;
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
Subject: [PATCH v2 3/6] PCI: qcom: Fix deadlock when enabling ASPM
Date:   Tue, 28 Nov 2023 09:15:09 +0100
Message-ID: <20231128081512.19387-4-johan+linaro@kernel.org>
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

The qcom_pcie_enable_aspm() helper is called from pci_walk_bus() during
host init to enable ASPM.

Since pci_walk_bus() already holds a pci_bus_sem read lock, use the new
locked helper to enable link states in order to avoid a potential
deadlock (e.g. in case someone takes a write lock before reacquiring
the read lock).

This issue was reported by lockdep:

   ============================================
   WARNING: possible recursive locking detected
   6.7.0-rc1 #4 Not tainted
   --------------------------------------------
   kworker/u16:6/147 is trying to acquire lock:
   ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_enable_link_state+0x74/0x1e8

   but task is already holding lock:
   ffffbf3ff9d2cfa0 (pci_bus_sem){++++}-{3:3}, at: pci_walk_bus+0x34/0xbc

   other info that might help us debug this:
    Possible unsafe locking scenario:

          CPU0
          ----
     lock(pci_bus_sem);
     lock(pci_bus_sem);

    *** DEADLOCK ***

Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ce3ece28fed2..21523115f6a4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -971,7 +971,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
 	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
 	pci_set_power_state(pdev, PCI_D0);
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
 }
-- 
2.41.0

