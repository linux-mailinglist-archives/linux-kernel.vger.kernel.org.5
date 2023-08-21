Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA779782EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjHUQ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbjHUQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4FED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K713/+YzNhCBus2Dn+vC69pQ981WC6LB+rJ5/0ddg74=;
        b=RxikGcxQ7oHQPWpeH+1cTiTTLsuDlvhU76hwZ1A/BDelv3H1NeGDe+YBRa02YypzYDqyIx
        ZK8gQiW6WaOT2D1n+sHHCptlYI2irBr8JKixPvo+0bS1c2HoqBH602rP3YRV0M7tdu2j+9
        kuedkivSgiafQdE8zhTlOuaro2YJYu5HPJQpgqt36nS8O2eesyHb9itH5IlUEJ4GbcNNnO
        6exsa7vojo17liPnajsQZYjKF/S4TiMHTAzu4KzWDEtkvuzeyCU7dDSGaB/aTMF7tN77Rs
        uWixKOYbqm1dFOUPQtCfaovTVV72cCFcNX79Z6yXo71BeULTuWSLqiFKok4SRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K713/+YzNhCBus2Dn+vC69pQ981WC6LB+rJ5/0ddg74=;
        b=gmqNwjrs6BX6cazC49EECh4eW8/+cw5pSCTXj+Qx8QKUTa79XXaA5M+iVFbJsehQYt/1zp
        Xt02XLmrPuERM4Bw==
From:   "irqchip-bot for Ruan Jinjie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/imx-mu-msi: Do not check for 0
 return after calling platform_get_irq()
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230803083452.4085650-2-ruanjinjie@huawei.com>
References: <20230803083452.4085650-2-ruanjinjie@huawei.com>
MIME-Version: 1.0
Message-ID: <169263708570.27769.11175640997927949490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2f54db449b6185024ef884fd3083802e1eae6921
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2f54db449b6185024ef884fd3083802e1eae6921
Author:        Ruan Jinjie <ruanjinjie@huawei.com>
AuthorDate:    Thu, 03 Aug 2023 16:34:51 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:42:00 +01:00

irqchip/imx-mu-msi: Do not check for 0 return after calling platform_get_irq()

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230803083452.4085650-2-ruanjinjie@huawei.com
---
 drivers/irqchip/irq-imx-mu-msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 229039e..90d41c1 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -339,8 +339,8 @@ static int __init imx_mu_of_init(struct device_node *dn,
 	msi_data->msiir_addr = res->start + msi_data->cfg->xTR;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	platform_set_drvdata(pdev, msi_data);
 
