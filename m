Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439C27E446C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjKGPxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343843AbjKGPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:52:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD51F26BF;
        Tue,  7 Nov 2023 07:49:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F34C433BD;
        Tue,  7 Nov 2023 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372178;
        bh=HoAiKJ3p4tgxhXDwoMT+dz43fNXsybvgZvNEbokcZTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP9QJoZ4Otuj0TGJZSCOuMUjOUsaZXQB0E5SsU6zXRUcTue8ZnnBxtrGpW4RM8RxS
         fNOhlv5a6aDGe88UCPDJhPsnu8OJpQg+cF0MNkOATu+j8r5xcNxETBLkyRx16A4z5j
         2PYE87k0FNOn5yAZhrl/WcQQSfhan+vYNyRFFMIxvcdzTCIZutKY/R/HYAlR3umfH+
         65Iqoams3WqcqAi9cdkf22KZYA3fKg8JXmJElrDaY4NsaDEYECR2Hy1vCjpwV2dG7A
         cof5RvgfmFiWew+hfffbv/Fgm8ahKBQbIRQdZjLY8ds/dtVbHKa6GirHZdoTr94Bxk
         Va4LUi4fYd67g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, thomas.petazzoni@bootlin.com,
        pali@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 19/34] PCI: mvebu: Use FIELD_PREP() with Link Width
Date:   Tue,  7 Nov 2023 10:47:59 -0500
Message-ID: <20231107154846.3766119-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107154846.3766119-1-sashal@kernel.org>
References: <20231107154846.3766119-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 408599ec561ad5862cda4f107626009f6fa97a74 ]

mvebu_pcie_setup_hw() setups the Maximum Link Width field in the Link
Capabilities registers using an open-coded variant of FIELD_PREP() with
a literal in shift. Improve readability by using
FIELD_PREP(PCI_EXP_LNKCAP_MLW, ...).

Link: https://lore.kernel.org/r/20230919125648.1920-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index c931b1b07b1d8..0cacd58f6c05e 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -265,7 +265,7 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 */
 	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, port->is_x4 ? 4 : 1);
 	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
-- 
2.42.0

