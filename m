Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4375E811
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGXBhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjGXBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C272690;
        Sun, 23 Jul 2023 18:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813B460F13;
        Mon, 24 Jul 2023 01:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC11C433CC;
        Mon, 24 Jul 2023 01:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162315;
        bh=eMxvVRosH6ZazwMWDYUo3hTwAqM4bw0NindcI86L55g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaZ/cuzBcoFp/GIQ5z1T8dFzR3cg9C6hmqMUT21+gB04BTXhHND57czWuVhgH671L
         zdsKkO1vdXBGnZ1USpwSK75qPcTpoimfmLYIK/emFbcPpQ8HXjdzvMTI9vsC5iTufs
         Q/2ETeML/zfVHWDsh3ydFMzgpA92MyfgKgMYdSW1FKiK2EoDBRH9D0FL4fbJF6QdTB
         Z/rT1TT8vWuOPJxTzbSuXOcOhF2XlxhtGYeohnvTKQ4Tpc+FTk5zG3IyjewTmYqSoh
         MOyt0REzKp1GJg1hSeu2ypNS3mo+azUv4dziFInwoA3Ap9xomP6TiiKZRRieaqxnfX
         P6RlWldbpsbcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, mathias.nyman@intel.com,
        matthias.bgg@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/40] xhci: get rid of XHCI_PLAT quirk that used to prevent MSI setup
Date:   Sun, 23 Jul 2023 21:31:10 -0400
Message-Id: <20230724013140.2327815-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 0a4776205b16d038ec6fedef2094951fcb6f441b ]

The XHCI_PLAT quirk was only needed to ensure non-PCI xHC host avoided
setting up MSI interrupts in generic xhci codepaths.

The MSI setup code is now moved to PCI specific xhci-pci.c file so
the quirk is no longer needed.

Remove setting the XHCI_PLAT quirk for HiSilocon SoC xHC, NVIDIA Tegra xHC,
MediaTek xHC, the generic xhci-plat driver, and the checks for XHCI_PLAT
in xhci-pci.c MSI setup code.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <20230602144009.1225632-5-mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-histb.c | 12 +-----------
 drivers/usb/host/xhci-mtk.c   |  6 ------
 drivers/usb/host/xhci-pci.c   |  7 -------
 drivers/usb/host/xhci-plat.c  |  7 +------
 drivers/usb/host/xhci-tegra.c |  1 -
 drivers/usb/host/xhci.h       |  2 +-
 6 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/usb/host/xhci-histb.c b/drivers/usb/host/xhci-histb.c
index 08369857686e7..42749ba2e2f85 100644
--- a/drivers/usb/host/xhci-histb.c
+++ b/drivers/usb/host/xhci-histb.c
@@ -164,16 +164,6 @@ static void xhci_histb_host_disable(struct xhci_hcd_histb *histb)
 	clk_disable_unprepare(histb->bus_clk);
 }
 
-static void xhci_histb_quirks(struct device *dev, struct xhci_hcd *xhci)
-{
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT;
-}
-
 /* called during probe() after chip reset completes */
 static int xhci_histb_setup(struct usb_hcd *hcd)
 {
@@ -186,7 +176,7 @@ static int xhci_histb_setup(struct usb_hcd *hcd)
 			return ret;
 	}
 
-	return xhci_gen_setup(hcd, xhci_histb_quirks);
+	return xhci_gen_setup(hcd, NULL);
 }
 
 static const struct xhci_driver_overrides xhci_histb_overrides __initconst = {
diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 90cf40d6d0c31..a6d3c5238bdde 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -418,12 +418,6 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	struct xhci_hcd_mtk *mtk = hcd_to_mtk(hcd);
 
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT;
 	xhci->quirks |= XHCI_MTK_HOST;
 	/*
 	 * MTK host controller gives a spurious successful event after a
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 79b3691f373f3..3a9f907394a25 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -108,9 +108,6 @@ static void xhci_cleanup_msix(struct xhci_hcd *xhci)
 	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
 
-	if (xhci->quirks & XHCI_PLAT)
-		return;
-
 	/* return if using legacy interrupt */
 	if (hcd->irq > 0)
 		return;
@@ -208,10 +205,6 @@ static int xhci_try_enable_msi(struct usb_hcd *hcd)
 	struct pci_dev  *pdev;
 	int ret;
 
-	/* The xhci platform device has set up IRQs through usb_add_hcd. */
-	if (xhci->quirks & XHCI_PLAT)
-		return 0;
-
 	pdev = to_pci_dev(xhci_to_hcd(xhci)->self.controller);
 	/*
 	 * Some Fresco Logic host controllers advertise MSI, but fail to
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index b0c8e8efc43b6..be2b5b786352e 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -78,12 +78,7 @@ static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
 
-	/*
-	 * As of now platform drivers don't provide MSI support so we ensure
-	 * here that the generic code does not try to make a pci_dev from our
-	 * dev struct in order to setup MSI
-	 */
-	xhci->quirks |= XHCI_PLAT | priv->quirks;
+	xhci->quirks |= priv->quirks;
 }
 
 /* called during probe() after chip reset completes */
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index c75d932441436..ebfbd547b2ec6 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -2662,7 +2662,6 @@ static void tegra_xhci_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
 	struct tegra_xusb *tegra = dev_get_drvdata(dev);
 
-	xhci->quirks |= XHCI_PLAT;
 	if (tegra && tegra->soc->lpm_support)
 		xhci->quirks |= XHCI_LPM_SUPPORT;
 }
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6b690ec91ff3a..42444d9b47c9d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1874,7 +1874,7 @@ struct xhci_hcd {
 #define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
 #define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
 #define XHCI_AVOID_BEI		BIT_ULL(15)
-#define XHCI_PLAT		BIT_ULL(16)
+#define XHCI_PLAT		BIT_ULL(16) /* Deprecated */
 #define XHCI_SLOW_SUSPEND	BIT_ULL(17)
 #define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
 /* For controllers with a broken beyond repair streams implementation */
-- 
2.39.2

