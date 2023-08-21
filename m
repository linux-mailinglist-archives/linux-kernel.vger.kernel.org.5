Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B58782EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjHUQ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjHUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CB6EC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:08 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hfk7wx7rkgxelonxycb8MCpnw9RBuyAaD503qHDPo0M=;
        b=B/K8RKqUCTSPvLcL78EES4YcR7BonH+ckjP+Jii/e/zzt9JbM2s0gR7LelLPF50qK7Cbiw
        BanQKqVLQ3ANK/W/PDm3/dcRK5JiSjNAQL/fVu3FbcOLFhR2itzkJqbwIHJ8SQYRmVVvVL
        ODQ2PoSfeF7P+AWEi5VLFsh8nbBDcf5SupnLKDqcIhbYH6Vtkd1MZpqB6UK5OwNAmM5jx+
        KNbDqE55Dr/zgQXYs1+GOWFJmMQPWlDjKvbgciCQvpzX77u9hHUEaCIalqMGvnDQ/PRvw6
        NZSgH80PQWyMOGQBnhx4xeA+knyCUnKv3aHS2QgisWhhma08yBOb27SP7L2V/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hfk7wx7rkgxelonxycb8MCpnw9RBuyAaD503qHDPo0M=;
        b=RSQBgd2D/owvjUpAMgRYHDhR+g1FQOExVr7cphv3eE3MUCVA8qd58tCLuDOyhEtWm1MZHt
        wiIeWvwWRGRkGlCw==
From:   "irqchip-bot for Ruan Jinjie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-pruss-intc: Do not check for
 0 return after calling platform_get_irq()
Cc:     Ruan Jinjie <ruanjinjie@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20230803083452.4085650-3-ruanjinjie@huawei.com>
References: <20230803083452.4085650-3-ruanjinjie@huawei.com>
MIME-Version: 1.0
Message-ID: <169263708522.27769.3271465709855853965.tip-bot2@tip-bot2>
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

Commit-ID:     d0afed833970808f141ed52fcc591998087f3a26
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d0afed833970808f141ed52fcc591998087f3a26
Author:        Ruan Jinjie <ruanjinjie@huawei.com>
AuthorDate:    Thu, 03 Aug 2023 16:34:52 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:42:00 +01:00

irqchip/irq-pruss-intc: Do not check for 0 return after calling platform_get_irq()

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230803083452.4085650-3-ruanjinjie@huawei.com
---
 drivers/irqchip/irq-pruss-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index fa8d89b..ee69e8d 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -565,8 +565,8 @@ static int pruss_intc_probe(struct platform_device *pdev)
 			continue;
 
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
-		if (irq <= 0) {
-			ret = (irq == 0) ? -EINVAL : irq;
+		if (irq < 0) {
+			ret = irq;
 			goto fail_irq;
 		}
 
