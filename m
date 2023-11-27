Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99947F9789
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjK0CdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0CdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:33:06 -0500
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874592
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:33:11 -0800 (PST)
X-QQ-mid: bizesmtp64t1701052377tsjca7qc
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 27 Nov 2023 10:32:54 +0800 (CST)
X-QQ-SSF: 01400000000000103000000A0000000
X-QQ-FEAT: CR3LFp2JE4lYlGZyt7s4Y2ErgzYu/i1VV9Xrg9Ot17hS0sZN4+BeicMF5VMkA
        boSUhErVjzKfj68SY7KvmYQK8jxsKVFlnBTCI3e22iIVQvlcW2rrQlLjCk8yr3kzLTWQo6T
        vDf5Aj5EOOJvaG8Hdm8w3iPApU+5vxAAH3875ZjfDTYId9QIkZ2JxD4FTXes+KKPv7TC6XQ
        AU6ysOaOytRKx9ugXKYWzO3vOE57p4XEFGeMgqQXnMcTGcArtGhFLtcIthhszqd2buHvppz
        QP3gxDvuvOXwTp7HVmQyScJeC7S7MRGEEbO/4WGZuU5PpMniuixJqr59OlQ0V/CZPMvglOu
        4yXyTHUDW4w0mERxPsra1GFbQxbe9MOMEuOHvBrzY+YDxp+f+HIa5lr8k7Ae6aM+zSPZJZx
        8GgbSAZFwgYIumQhd6tgHQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16950061229270955396
From:   Luming Yu <luming.yu@shingroup.cn>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH] powerpc/powernv/pci: Do setup dev PE in pnv_pci_enable_device_hook
Date:   Mon, 27 Nov 2023 10:32:39 +0800
Message-ID: <041F99FBF8A508A2+20231127023239.4157-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after hot remove a pcie deivce with pci_dn having pnp_php driver attached,
pci rescan with echo 1 > /sys/bus/pci/rescan could fail with error
message like:
pci 0020:0e:00.0: BAR 0: assigned [mem 0x3fe801820000-0x3fe80182ffff
64bit]
nvme nvme1: pci function 0020:0e:00.0
nvme 0020:0e:00.0 pci_enable_device() blocked, no PE assigned.

It appears that the pci_dn object is reused with only pe_number
clobbered in the case. And a simple call to pnv_ioda_setup_dev_PE should
get PE number back and solve the problem.

Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
---
 arch/powerpc/platforms/powernv/pci-ioda.c     |  11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c | 215 ------------------
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h |  46 ----
 include/soc/arc/aux.h                         |  59 -----
 4 files changed, 9 insertions(+), 322 deletions(-)
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.c
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/aux.h
 delete mode 100644 include/soc/arc/aux.h

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 28fac4770073..9d7add79ee3d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2325,11 +2325,18 @@ static resource_size_t pnv_pci_default_alignment(void)
 static bool pnv_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct pci_dn *pdn;
+	struct pnv_ioda_pe *pe;
 
 	pdn = pci_get_pdn(dev);
-	if (!pdn || pdn->pe_number == IODA_INVALID_PE) {
-		pci_err(dev, "pci_enable_device() blocked, no PE assigned.\n");
+	if (!pdn)
 		return false;
+
+	if (pdn->pe_number == IODA_INVALID_PE) {
+		pe = pnv_ioda_setup_dev_PE(dev);
+		if (!pe) {
+			pci_err(dev, "pci_enable_device() blocked, no PE assigned.\n");
+			return false;
+		}
 	}
 
 	return true;
