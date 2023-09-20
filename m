Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7973C7A8C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjITTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjITTL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415A8F;
        Wed, 20 Sep 2023 12:11:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso108928e87.1;
        Wed, 20 Sep 2023 12:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237079; x=1695841879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR1JE8m9yIb2GrY6VQKOZhC73Jk1qxOxRizbrOmDB5o=;
        b=YAkqtH/5XLK5BSea5moSW8AkhzpXd5e3zEVjaukVZj7LjK+YeaoAUueQh5LrgXcNQy
         6j5NWG1gsm1cqh7A8qQoOQzyKh92Bdn1af7Y4n/WUI+R3DrWpBiBc6fYKxintReG5J+R
         7/rLMabfLLOiWoyVKl7RXQFj2TYwqyBYSsaPltNFQ+JHX29/yGO4R86Cpg9An6hqxlyv
         dFTF1vZ5bdzFXrMMtETyPyWQhFuNoXuWU3wdtzFgKPhE9j6ZU9qY8ONK7BrBMzwUQ6MT
         E1W6YMp7T6HjJN4pTE6mO0zW/DKOrf25VnSXlx72i/C+b7PLVrUfH79hk4VkG/+MrVwg
         N11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237079; x=1695841879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR1JE8m9yIb2GrY6VQKOZhC73Jk1qxOxRizbrOmDB5o=;
        b=fcyNY6pknrkKXPaKA3iqNKbpfp3qUjZrCmhiRN3tyXZpkvxvnpV8CNpgWG7SmF6a3e
         RGx/5PwLSkj0x3r4XKaIbj1yfzRQsFfVgT4IIksMOXTnUq4Mek9XMmmcDV7SBmCLB/0D
         wy7jiw7Y8dPVCWDh/KqITdlCFjJtqNm1Yi06OR+I4a0unvoxgrgZcvbcOd9boko792a4
         f09ffNCzNSgZ1mnz7/GLqd/gH+L9IuNIi+CQxubIJCuQU8cmAM0/+1dnhsQHrG5bY7td
         ROc47jl6RCO0uFsepezSlXPEQQ917soPByKyhl8HrjTUnwYkUQIGovLR19a4Bw7LUpX4
         6LAQ==
X-Gm-Message-State: AOJu0YxMFQJSuaSiaoPaccDpciUHw53NtHn6mTxB5O1QF3JOZTHHXaZU
        5DqHB1nnxs9w5Ek3Nh7k9clDMR5OjLQ=
X-Google-Smtp-Source: AGHT+IG6GeZvz2KK7DDBg0fy99LGIWGIHeZjOEx66NYKlsdP58EJ7i/40rhVTU3icepvkciFRDsIaQ==
X-Received: by 2002:a05:6512:12ca:b0:503:16ec:7153 with SMTP id p10-20020a05651212ca00b0050316ec7153mr2473011lfg.31.1695237079028;
        Wed, 20 Sep 2023 12:11:19 -0700 (PDT)
Received: from localhost ([85.140.0.168])
        by smtp.gmail.com with ESMTPSA id j28-20020ac253bc000000b0050424698d62sm57962lfh.249.2023.09.20.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:18 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 01/20] EDAC/synopsys: Fix ECC status data and IRQ disable race condition
Date:   Wed, 20 Sep 2023 22:10:25 +0300
Message-ID: <20230920191059.28395-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The race condition around the ECCCLR register access happens in the IRQ
disable method called in the device remove() procedure and in the ECC IRQ
handler:
1. Enable IRQ:
   a. ECCCLR = EN_CE | EN_UE
2. Disable IRQ:
   a. ECCCLR = 0
3. IRQ handler:
   a. ECCCLR = CLR_CE | CLR_CE_CNT | CLR_CE | CLR_CE_CNT
   b. ECCCLR = 0
   c. ECCCLR = EN_CE | EN_UE
So if the IRQ disabling procedure is called concurrently with the IRQ
handler method the IRQ might be actually left enabled due to the
statement 3c.

The root cause of the problem is that ECCCLR register (which since v3.10a
has been called as ECCCTL) has intermixed ECC status data clear flags and
the IRQ enable/disable flags. Thus the IRQ disabling (clear EN flags) and
handling (write 1 to clear ECC status data) procedures must be serialised
around the ECCCTL register modification to prevent the race.

So fix the problem described above by adding the spin-lock around the
ECCCLR modifications and preventing the IRQ-handler from modifying the
IRQs enable flags (there is no point in disabling the IRQ and then
re-enabling it again within a single IRQ handler call, see the statements
3a/3b and 3c above).

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Cc: Sherry Sun <sherry.sun@nxp.com>

Changelog v4:
- This is a new patch detached from
  [PATCH v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
- Rename lock to reglock (Borislav)
---
 drivers/edac/synopsys_edac.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f7d37c282819..014a2176c2c1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -300,6 +301,7 @@ struct synps_ecc_status {
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
  * @baseaddr:		Base address of the DDR controller.
+ * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
@@ -314,6 +316,7 @@ struct synps_ecc_status {
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
+	spinlock_t reglock;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
@@ -409,7 +412,8 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
+	u32 regval, clearval;
+	unsigned long flags;
 	void __iomem *base;
 
 	base = priv->baseaddr;
@@ -453,10 +457,14 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 out:
-	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
-	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	clearval = readl(base + ECC_CLR_OFST) |
+		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
 	writel(clearval, base + ECC_CLR_OFST);
-	writel(0x0, base + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 
 	return 0;
 }
@@ -516,24 +524,41 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 static void enable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(DDR_UE_MASK | DDR_CE_MASK,
-		       priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(DDR_UE_MASK | DDR_CE_MASK,
+	       priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+
+		return;
+	}
+
+	spin_lock_irqsave(&priv->reglock, flags);
+
+	writel(0, priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
 /**
@@ -577,8 +602,6 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	/* v3.0 of the controller does not have this register */
 	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	else
-		enable_intr(priv);
 
 	return IRQ_HANDLED;
 }
@@ -1360,6 +1383,7 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	spin_lock_init(&priv->reglock);
 
 	mc_init(mci, pdev);
 
-- 
2.41.0

