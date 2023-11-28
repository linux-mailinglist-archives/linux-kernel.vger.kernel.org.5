Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029C7FB3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjK1IP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjK1IPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED299E1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:15:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58596C433C9;
        Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701159324;
        bh=i/EHkRtVuPQPs5OIMVcI6ZSMpjBbo9UrT0fH07edjzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gc8TG5UyJ9xcrTjk67G3eNwL38tdLdf5NMSifIzV8q+o4CpN5IWL2j9WEJcMiqMIs
         pcqQ6UBN8X9Ft6teNQegKrQL5sKl1e0bKPOvO77pHIMTL/F9O8lSVFeSYS6JlCmzqQ
         4bLqpW5F30uN8aiYqvyBBV6x2ESrOt/mR4KRWJVUCWdzFdhtSlqvPcnAObwVJPzwHO
         iSctaJFdrns5imocLhcx3C/3aGH14F8A1OTx5kYkJmVEfuJUcmG2P8aWx5DbcTWGJm
         OgFx07/0N80angxPUpx2esF8c33jk14HftNEJUzZvfScYx0d87nyNyoOC7z2LxEE+q
         RlKwAeE3Vo5qQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r7tG4-00053z-2x;
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
Subject: [PATCH v2 6/6] PCI/ASPM: Add lockdep assert to link state helper
Date:   Tue, 28 Nov 2023 09:15:12 +0100
Message-ID: <20231128081512.19387-7-johan+linaro@kernel.org>
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

Add a lockdep assert to the locked disable link state helper which
should only be called with a pci_bus_sem read lock held.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/pcie/aspm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d7a3ca555cc1..5dab531c8654 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1090,6 +1090,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool locked
 
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 {
+	lockdep_assert_held_read(&pci_bus_sem);
+
 	return __pci_disable_link_state(pdev, state, true);
 }
 EXPORT_SYMBOL(pci_disable_link_state_locked);
-- 
2.41.0

