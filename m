Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F002E778032
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjHJSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHJSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BE8128;
        Thu, 10 Aug 2023 11:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80EF9665C4;
        Thu, 10 Aug 2023 18:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A025C433C7;
        Thu, 10 Aug 2023 18:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691691881;
        bh=czylyOg9wVKVXz+1ynqLtwzRuhlhf3XOTcyXD0fa8gw=;
        h=From:To:Cc:Subject:Date:From;
        b=jW7AsVU+LdkOSneIGoW9k+7Wt+lS8Cc+SW2VXuTppoScN/vOq8cUpkwJuoOUbGAsx
         5S6amd7/YaMWHm2BFfFMqXFmUVam1CrKcx7CJ0UERNwMre1q68fKlrspsmdsKpyvQ6
         sMobct+rslQquiz9jStWof0YztZ6hJ34Xaf53kA7ePA4xi0ODTgm1PlPM/4j1hqkyr
         FJRyctepqSFNNNh+Gdjm4fAI+eXUvWCnAMaetGIKpTEkx8UXOo/qNewJ/8sdXiaUYx
         Z6/5gqW9gpuVlgl8YcVSaHWOnBtyXdOoll5Mf6ord86z6zgUwt0nGGFrOz4UEPtgan
         kWVwH0TiqqjNw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, stable@vger.kernel.org,
        "Takashi Iwai" <tiwai@suse.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/tpm_tis: Disable interrupts categorically for Lenovo
Date:   Thu, 10 Aug 2023 21:24:33 +0300
Message-Id: <20230810182433.518523-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By large most of the entries in tpm_tis_dmi_table[] are for Lenovo laptops,
and they keep on coming. Therefore, disable IRQs categorically for Lenovo.

Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: "Takashi Iwai" <tiwai@suse.de>
Closes: https://lore.kernel.org/linux-integrity/87il9qhxjq.wl-tiwai@suse.de/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
This will be included into v6.5-rc6 PR, as long as Takashi ack's it. I'm
planning to send tomorrow morning (GMT+3).

BR, Jarkko
 drivers/char/tpm/tpm_tis.c | 34 ----------------------------------
 1 file changed, 34 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 3c0f68b9e44f..dd0f52d35073 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -132,42 +132,8 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 	},
 	{
 		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad T490s",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkStation P360 Tiny",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad L490",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L490"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkPad L590",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L590"),
-		},
-	},
-	{
-		.callback = tpm_tis_disable_irq,
-		.ident = "ThinkStation P620",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P620"),
 		},
 	},
 	{
-- 
2.39.2

