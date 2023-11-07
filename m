Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0AC7E4543
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjKGQDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbjKGQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:03:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CB1BE5;
        Tue,  7 Nov 2023 07:54:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E33C433CC;
        Tue,  7 Nov 2023 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372455;
        bh=D2ifMf8weUkab998trSoLuaVweCIqkI1KaVlq6HwFyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubIQpORKGiOCBnZHFEff3kx8EPqWLs+2JxAviNCpsW0xhb0q56tPNNGTLibRRgzC2
         0Y7C+8jx5Fsm/soOz5MfnAzO+rvS/Z8hMcV2vRt/PRB2MDmdcAMzXteyayT5dVZ1y4
         x/eFcvAuXgg6X8Bv/1mdcbY3WP8ct9G1AXbhdiT3bqXdq4Hqg1u9kVbEAjsfpQxTCa
         IB5rSG0RNqYBL/aPa6tV23GL3Qtno6fRY7weudc1r0vXetNY+9VYz0YA4NIpQHNNZj
         ScypKfUHr1b2sLwcsgUstS6PTN5DZ3yF9z0BR4FINvKlgq6DqR+ALwuCaZMhrvBkwo
         fZ2W8oJwH+FHQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, 3chas3@gmail.com,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 10/12] atm: iphase: Do PCI error checks on own line
Date:   Tue,  7 Nov 2023 10:53:28 -0500
Message-ID: <20231107155343.3768464-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155343.3768464-1-sashal@kernel.org>
References: <20231107155343.3768464-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit c28742447ca9879b52fbaf022ad844f0ffcd749c ]

In get_esi() PCI errors are checked inside line-split "if" conditions (in
addition to the file not following the coding style). To make the code in
get_esi() more readable, fix the coding style and use the usual error
handling pattern with a separate variable.

In addition, initialization of 'error' variable at declaration is not
needed.

No functional changes intended.

Link: https://lore.kernel.org/r/20230911125354.25501-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/atm/iphase.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 46990352b5d3f..bfc889367d5e3 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2290,19 +2290,21 @@ static int get_esi(struct atm_dev *dev)
 static int reset_sar(struct atm_dev *dev)  
 {  
 	IADEV *iadev;  
-	int i, error = 1;  
+	int i, error;
 	unsigned int pci[64];  
 	  
 	iadev = INPH_IA_DEV(dev);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_read_config_dword(iadev->pci,  
-				i*4, &pci[i])) != PCIBIOS_SUCCESSFUL)  
-  	      return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_read_config_dword(iadev->pci, i * 4, &pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	writel(0, iadev->reg+IPHASE5575_EXT_RESET);  
-	for(i=0; i<64; i++)  
-	  if ((error = pci_write_config_dword(iadev->pci,  
-					i*4, pci[i])) != PCIBIOS_SUCCESSFUL)  
-	    return error;  
+	for (i = 0; i < 64; i++) {
+		error = pci_write_config_dword(iadev->pci, i * 4, pci[i]);
+		if (error != PCIBIOS_SUCCESSFUL)
+			return error;
+	}
 	udelay(5);  
 	return 0;  
 }  
-- 
2.42.0

