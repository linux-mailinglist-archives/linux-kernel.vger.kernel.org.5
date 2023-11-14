Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AA7EAFDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjKNMag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjKNMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:30:35 -0500
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8590E13D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:30:31 -0800 (PST)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id 2C964180251;
        Tue, 14 Nov 2023 13:30:29 +0100 (CET)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     jeff@labundy.com
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, tomas.mudrunka@gmail.com
Subject: [PATCH v6] Fix freeze in lm8333 i2c keyboard driver
Date:   Tue, 14 Nov 2023 13:30:23 +0100
Message-ID: <20231114123023.95570-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <ZF53JVcb8UJQFmfP@nixie71>
References: <ZF53JVcb8UJQFmfP@nixie71>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LM8333 uses gpio interrupt line which is active-low.
When interrupt is set to FALLING edge and button is pressed
before driver loads, driver will miss the edge and never respond.
To fix this we should handle ONESHOT LOW interrupt rather than edge.

Rather than hardcoding this, we simply remove the override from
driver by calling request_threaded_irq() with IRQF_TRIGGER_NONE flag.
This will keep interrupt trigger configuration as per devicetree. eg.:

	lm8333@51 {
		compatible = "ti,lm8333";
		interrupt-parent = <&gpio1>;
		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
		...
	}

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
---
 drivers/input/keyboard/lm8333.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 7457c3220..c5770ebb2 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -179,7 +179,7 @@ static int lm8333_probe(struct i2c_client *client)
 	}
 
 	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
-				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				   IRQF_TRIGGER_NONE | IRQF_ONESHOT,
 				   "lm8333", lm8333);
 	if (err)
 		goto free_mem;
-- 
2.40.0
