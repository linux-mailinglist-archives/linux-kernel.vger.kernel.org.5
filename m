Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B52779B7A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbjHKXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjHKXkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:40:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F4610FE;
        Fri, 11 Aug 2023 16:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DFBC67BF6;
        Fri, 11 Aug 2023 23:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A79CC433C7;
        Fri, 11 Aug 2023 23:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691797213;
        bh=R2sg8Db9dBVponQJLVp+BrZA8E82CBv1tB6TGddHoN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uq3xkCyExr0bAf02PkbcC409sZ8cxS1DxQ077j7t81RnQrHuQWGqD61Kjzbw4iGAy
         osnXYnbQPKkDkRocy0dLSsE6g4mjgplWyvHTfps1/yHrMuU8l12yd4Jz06l3UhBRta
         Lz3HVMqZUAYcUKgn3fLDdfFven/MjaKgJ4N3VasBaJ0c+zXi0GC02JwGlczDokgzuY
         aT9jG+99ppj8P1wT0HzIeoCRUHsVyhTzibT6OE0IBgoKSOMrtf/MUSU7DgsAGFBfJ6
         ZmFnkf8mDDQwnOmR19JQTfEmfnXGht80yA+CfvAjtdX0+deKZTbdM7sN5Aqwj72Xm2
         eWGx9fpgBsk9g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tpm: tpm_tis: Fix UPX-i11 DMI_MATCH condition
Date:   Sat, 12 Aug 2023 02:40:01 +0300
Message-Id: <20230811234002.2656180-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811234002.2656180-1-jarkko@kernel.org>
References: <20230811234002.2656180-1-jarkko@kernel.org>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

The patch which made it to the kernel somehow changed the
match condition from
DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
to
DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL")

Revert back to the correct match condition to disable the
interrupt mode on the board.

Cc: stable@vger.kernel.org # v6.4+
Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11")
Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@linux.intel.com/
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ac4daaf294a3..3c0f68b9e44f 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 		.ident = "UPX-TGL",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01"),
 		},
 	},
 	{}
-- 
2.39.2

