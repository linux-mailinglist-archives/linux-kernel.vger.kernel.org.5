Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC67E45B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjKGQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjKGQRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:17:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B917DAD;
        Tue,  7 Nov 2023 07:52:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D34C433CC;
        Tue,  7 Nov 2023 15:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372343;
        bh=69BpB42a+Uhc1LwWwPzW3d6ynRqk0g1AebpJiCPFhMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXvA69Ug0U7mKflxjmn8KeuzziC70RtPr+DPZ5/bEgc23panv0lsOTJrdHcrZCfc1
         aQT4pAMi6cH+N9rP1cc/dOE+4ivF3VCpKREahLug8DSIT2WHwM37FZkechR6EKUL6y
         UuF0O6a3Hu+3tGTY/op+H3+3/+8Q8+dXfbguvTlfxG8m0JL2DoT0FVzaAXJumi6kqx
         ZBGEZo4HRDaTJg9KKFRJZfnAD1kwTQ4qiTj72DTZbySwKQ9oao2lLS20OV2+WcgIAH
         lmP6edqCUR4hVMJk7CAChNHFWSiyymwEcs8jhhnxuKkPeDpblumQQ1HA8PbwryaNhU
         mPfokvHdHuD8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, 3chas3@gmail.com,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/22] atm: iphase: Do PCI error checks on own line
Date:   Tue,  7 Nov 2023 10:51:23 -0500
Message-ID: <20231107155146.3767610-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index bc8e8d9f176b2..ce56306eeb6ce 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2293,19 +2293,21 @@ static int get_esi(struct atm_dev *dev)
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

