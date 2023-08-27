Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D301789BD4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjH0HnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjH0HmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370FCF4;
        Sun, 27 Aug 2023 00:42:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E0960FC9;
        Sun, 27 Aug 2023 07:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B414C433C8;
        Sun, 27 Aug 2023 07:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122124;
        bh=CyV8weJLILusp2I2nJU1+46zjl9TJ9Z4e2qXVYCVh68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejZj4KfqgCT22S0AfCUErj/ngRst0e/WO1aU7bm6kKFTdwaobnVyjDLDfFSo47X/S
         kNqkCTTh6/QAQ6QejJAc7ywkj1gE5Fna1N1FInsnedRVJLOvfwkDgbURb7lpAj5NNN
         q88w1RdVIa9KRqGbb80aX3us/E1ssqnosCBTB+yOS/dHDWGT5FM61UPgiEcnjucyED
         eQrCBq86wBBpbXj2QBm742bWTS/ySr//7PJAKJB0FpdRXTDOZKsjt2i/RIBl4JcKms
         IiYXVtGQAC9uRcWKA3DOW02e2731Em3jvEUHlFsIaFGc/dDZyjInRA1+qyBkAYXuMM
         69dkaqXZ01mxg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 09/14] tty: n_tty: remove unsigned char casts from character constants
Date:   Sun, 27 Aug 2023 09:41:42 +0200
Message-ID: <20230827074147.2287-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We compile with -funsigned-char, so all character constants are already
unsigned chars. Therefore, remove superfluous casts.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 632516d7b487..369f5dd9cc4b 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1347,7 +1347,7 @@ static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 		 * XXX does PARMRK doubling happen for
 		 * EOL_CHAR and EOL2_CHAR?
 		 */
-		if (c == (unsigned char) '\377' && I_PARMRK(tty))
+		if (c == '\377' && I_PARMRK(tty))
 			put_tty_queue(c, ldata);
 
 		n_tty_receive_handle_newline(tty, c);
@@ -1409,7 +1409,7 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 	}
 
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 
 	put_tty_queue(c, ldata);
@@ -1444,7 +1444,7 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		commit_echoes(tty);
 	}
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
-- 
2.42.0

