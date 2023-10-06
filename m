Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB497BB910
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjJFN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:26:58 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF8683;
        Fri,  6 Oct 2023 06:26:56 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 197301007F8; Fri,  6 Oct 2023 14:26:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696598815; bh=UXwmvyfcz7+G6k1Eio3GnnTX/uptDTtBSTC2steX08w=;
        h=From:To:Cc:Subject:Date:From;
        b=jmQs7Ss/peRiRt886mq2geyLW8byTP0ykuahAlIny14b2PeJppNMX8iP8sHogLCqv
         5fj4MzrTWK4jujeczzIG5iC+x7QDHSnGjKpsuPsupY4HIRZ03NXjbdrnqrv9EHDotj
         NFAkNcIjhGTlmZjACLkhxd/sxGIf5cDmAXOdr/YsNLXns6KE3PGb8fqH+2sCBZBB6o
         +IxwnA1i30+zGYaRCm42qiIUPaLc8S2S6OYPb/PYVNiSGeh9H4fIFdUIZtOguKUsIr
         ura4CgF9NfgUUTC5jNEKE24QIsNa6yDC7va70NjqXatWp7KvdqSYkmD/AHecCPG/BZ
         wWtkrvOxr6vOA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id F3209100057;
        Fri,  6 Oct 2023 14:26:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1696598814; bh=UXwmvyfcz7+G6k1Eio3GnnTX/uptDTtBSTC2steX08w=;
        h=From:To:Cc:Subject:Date:From;
        b=ldpy4Gh0DGhTVX2j5z/b7p2QSlULiXt5MhhXKKoKNjjvk+5VKTJQtxrmQe7d+f+oD
         9UIl+F9KE7hDIqwN1gjYbQ/Ss/6CWot1tMxRVqZcmQs/Gp5y4TxBRixReBHbyR28kT
         dOx6cQ0vJDqBODXIAKXDaXuUH9nCfva82wFjQvm0xZhwIq97ZGO7Bl1h/ywF3/ZGcO
         yDM9w93M8MTpPVu+6Jc8anpmuu3nd6hiJ4fHlLcXLRJy/RIDBoLGfkTtPBFR3eZ35+
         UUNQZEBlYmshaKxBPOF81A52SpMcAPwwtcSKxD9iiFkbbvu9HCGawLTAfyQwX+fElc
         5M4XLSQink4mA==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Joe Ferner <joe.m.ferner@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] media: sharp: fix sharp encoding
Date:   Fri,  6 Oct 2023 14:26:30 +0100
Message-ID: <20231006132631.216231-1-sean@mess.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sharp protocol[1] encoding has incorrect timings for bit space.

[1] https://www.sbprojects.net/knowledge/ir/sharp.php

Reported-by: Joe Ferner <joe.m.ferner@gmail.com>
Closes: https://sourceforge.net/p/lirc/mailman/message/38604507/
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/ir-sharp-decoder.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/ir-sharp-decoder.c b/drivers/media/rc/ir-sharp-decoder.c
index 3d8488c39c56..3311099cbd57 100644
--- a/drivers/media/rc/ir-sharp-decoder.c
+++ b/drivers/media/rc/ir-sharp-decoder.c
@@ -15,7 +15,9 @@
 #define SHARP_UNIT		40  /* us */
 #define SHARP_BIT_PULSE		(8    * SHARP_UNIT) /* 320us */
 #define SHARP_BIT_0_PERIOD	(25   * SHARP_UNIT) /* 1ms (680us space) */
-#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680ms space) */
+#define SHARP_BIT_1_PERIOD	(50   * SHARP_UNIT) /* 2ms (1680us space) */
+#define SHARP_BIT_0_SPACE	(17   * SHARP_UNIT) /* 680us space */
+#define SHARP_BIT_1_SPACE	(42   * SHARP_UNIT) /* 1680us space */
 #define SHARP_ECHO_SPACE	(1000 * SHARP_UNIT) /* 40 ms */
 #define SHARP_TRAILER_SPACE	(125  * SHARP_UNIT) /* 5 ms (even longer) */
 
@@ -168,8 +170,8 @@ static const struct ir_raw_timings_pd ir_sharp_timings = {
 	.header_pulse  = 0,
 	.header_space  = 0,
 	.bit_pulse     = SHARP_BIT_PULSE,
-	.bit_space[0]  = SHARP_BIT_0_PERIOD,
-	.bit_space[1]  = SHARP_BIT_1_PERIOD,
+	.bit_space[0]  = SHARP_BIT_0_SPACE,
+	.bit_space[1]  = SHARP_BIT_1_SPACE,
 	.trailer_pulse = SHARP_BIT_PULSE,
 	.trailer_space = SHARP_ECHO_SPACE,
 	.msb_first     = 1,
-- 
2.42.0

