Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53A7FB212
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbjK1Gnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Gnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:43:53 -0500
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D98A113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:43:55 -0800 (PST)
X-QQ-mid: bizesmtp87t1701153823tkqoz2a2
Received: from HX09040029.powercore.com.cn ( [58.34.117.194])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 28 Nov 2023 14:43:40 +0800 (CST)
X-QQ-SSF: 01400000000000302000000A0000000
X-QQ-FEAT: rZJGTgY0+YO7EsZrHxvcRIiveH2oXURd51CPdA8OFs/LdrcmP73El4CyEsk7G
        0UiLBZ1Ds5Wq5Q13fzaCSpl9pdPE1lEMBROXPWcM75KL+QgnIuEfcmwhqSV2nHwaH86tNce
        BvRnVEuCkkkVZ6UQHSnu6mc95UjMs/g761i9Qz2s0ZIo3Y3QSptb8TXlOPuMQtkJVCCN6yK
        xlzM3a7t5+eOxC6jDxKLY0ZE5CRHhpP4jdD+XLuXg9y+c/zRqJ+Oc4arnzi2SCNjzsVuvoD
        RSecDodBqIhbgFlh7lyY/nLH2WM2OaoinLhbP8jWQ076A26jU8z05ywe+cLWFZBU0PqkzfA
        AaGSvLTK8GOQ3p4WI9mB4LFljniCi5DVZfmCnn50r2PzXKeB1j90fayy5IJ348j15XIuNec
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10265059360266172005
From:   Luming Yu <luming.yu@shingroup.cn>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     luming.yu@gmail.com, ke.zhao@shingroup.cn, dawei.li@shingroup.cn,
        shenghui.qu@shingroup.cn, Luming Yu <luming.yu@shingroup.cn>
Subject: [PATCH v1] powerpc/powernv/pci: fix PE in re-used pci_dn for pnv_pci_enable_device_hook
Date:   Tue, 28 Nov 2023 14:43:38 +0800
Message-ID: <7E99D8C8296BB626+20231128064339.5038-1-luming.yu@shingroup.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
v0 -> v1:
-clean up garbage leaked in git format patch that stems from git clone and checkout 
-conflicts of files in local windows filesystem with weird cases and names quriks.
---
 arch/powerpc/platforms/powernv/pci-ioda.c     |  11 +-
 1 files changed, 9 insertions(+), 2 deletions(-)

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
