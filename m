Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0415F7897CB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHZPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHZPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3EE19AE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB80621EF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C752C433C7;
        Sat, 26 Aug 2023 15:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693064647;
        bh=6yWhPECgcUGQ5JtYMmktOSLpS0LUf06+NSiTp8Vohoo=;
        h=From:To:Cc:Subject:Date:From;
        b=DcEiS45l04OgUcdiZTtE4q2/1NA695sO9rOuZ7VvMeA5pbpxtvK2e/k6x/neKTj3E
         jP6TX0IntedLpZJuBUBj0uL8U4/y1HX/RuCdwHUXgWgqVgsoUfuaBf1dO/BZLy63IZ
         7RC5pvKLigxraIpEOcmjwPLrHMreCG8JvllMioUdDIWrsVIxQRtC0MFX5hWwBlhvon
         B/EEZ1sRx1IERWcnLQrQ1SdL8V9p2lGQTDKshDLdw+quvib885BwVe8Zbd1PhnDhpq
         geRNNOSQ1SN/BHk36tO3gnebDqUcEYqf0xOI091YIpAC/Qdvuw43T2Zonm+5lx+EAn
         JDqEHvEocPeQA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qZvSJ-0000O6-2G;
        Sat, 26 Aug 2023 17:44:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH] genirq: Fix software resend lockup and nested resend
Date:   Sat, 26 Aug 2023 17:40:04 +0200
Message-ID: <20230826154004.1417-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The switch to using hlist for managing software resend of interrupts
broke resend in at least two ways:

First, unconditionally adding interrupt descriptors to the resend list
can corrupt the list when the descriptor in question has already been
added. This causes the resend tasklet to loop indefinitely with
interrupts disabled as was recently reported with the Lenovo ThinkPad
X13s after threaded NAPI was disabled in the ath11k WiFi driver. [1]

This bug is easily fixed by restoring the old semantics of
irq_sw_resend() so that it can be called also for descriptors that have
already been marked for resend.

Second, the offending commit also broke software resend of nested
interrupts by simply discarding the code that made sure that such
interrupts are retriggered using the parent interrupt.

Add back the corresponding code that adds the parent descriptor to the
resend list. Note that this bit is untested, but I decided to include it
to avoid having to revert the offending commit and the maple tree
conversion that depends on it.

[1] https://lore.kernel.org/lkml/20230809073432.4193-1-johan+linaro@kernel.org/

Fixes: bc06a9e08742 ("genirq: Use hlist for managing resend handlers")
Cc: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Hi Thomas and Marc,

This patch fixes a severe regression in the resend code in 6.5-rc1 that
breaks machines like the Lenovo X13s and which ideally should be
addressed before 6.5 is released tomorrow.

I hesitated about including the fix for nested interrupts as I've not
had time to test this bit, but I ultimately decided to include it to
avoid having to suggest a revert of the maple tree conversion. Let me
know if you prefer to go this route and I'll post a (prepared) revert
series instead.

Johan


 kernel/irq/resend.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index edec335c0a7a..5f2c66860ac6 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -68,11 +68,16 @@ static int irq_sw_resend(struct irq_desc *desc)
 		 */
 		if (!desc->parent_irq)
 			return -EINVAL;
+
+		desc = irq_to_desc(desc->parent_irq);
+		if (!desc)
+			return -EINVAL;
 	}
 
 	/* Add to resend_list and activate the softirq: */
 	raw_spin_lock(&irq_resend_lock);
-	hlist_add_head(&desc->resend_node, &irq_resend_list);
+	if (hlist_unhashed(&desc->resend_node))
+		hlist_add_head(&desc->resend_node, &irq_resend_list);
 	raw_spin_unlock(&irq_resend_lock);
 	tasklet_schedule(&resend_tasklet);
 	return 0;
-- 
2.41.0

