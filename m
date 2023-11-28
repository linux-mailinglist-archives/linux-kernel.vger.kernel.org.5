Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAB7FB3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbjK1IPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjK1IPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE40CE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:15:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B476C433C7;
        Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701159324;
        bh=hZl0Zl2shFZ9nd3i3exKHPLcrEYuE5Q2dGx/0v/2UmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHUCTUN8GpfK2qw9YG3t3WUpZ9OZZSAgsODxI7qZCH9vzISzi1F8eC0qa1rW5f6Sz
         alWD3mRUTC9KjJpB7dC6VmfJiQVnEDyR+FM3y+r44EVKNAe4imgDRToE4wMRMg9+2y
         UjsOlhGo0e9M6QqzwuTYr+aWI0ikhFWMYPlNdNiICzSd+ClUWMPv4Pv0Ex7kxwCsgT
         UqrXJKK1RcWvnrMaYvxA/7lBqafpUrydIE8HvK8lnG6+8dn9LVJPrAIySV4NdkwgC5
         iEbVty5i6hi2WP3/RgfLY1r6g4NDNHN6eXkJS4NN1W1i5nZkIrZmQpCQ/TEpa94/Da
         zA2Vsjp4h0AeQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r7tG4-00053r-1s;
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
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/6] PCI: vmd: Fix deadlock when enabling ASPM
Date:   Tue, 28 Nov 2023 09:15:08 +0100
Message-ID: <20231128081512.19387-3-johan+linaro@kernel.org>
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

The vmd_pm_enable_quirk() helper is called from pci_walk_bus() during
probe to enable ASPM for controllers with VMD_FEAT_BIOS_PM_QUIRK set.

Since pci_walk_bus() already holds a pci_bus_sem read lock, use the new
locked helper to enable link states in order to avoid a potential
deadlock (e.g. in case someone takes a write lock before reacquiring
the read lock).

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Cc: stable@vger.kernel.org      # 6.3
Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94ba61fe1c44..0452cbc362ee 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,7 +751,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-- 
2.41.0

