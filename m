Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42232777418
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjHJJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHJJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874BA2D71;
        Thu, 10 Aug 2023 02:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 263A8654CD;
        Thu, 10 Aug 2023 09:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BA6C433CC;
        Thu, 10 Aug 2023 09:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658940;
        bh=/6gBp59IIeAJu6gxv5VKOtBckU5nQfxa5DEsbTV9E6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFwAREQpZ/lAxISpilmXwfEfwiUtf047Qrgajcf6NYSCE2Z57lCQmkCsdr1S7JA+o
         kckZFTcaZhxk8Mup8VpG8PZpzQuoJXimVvcH06NXH4jXMRPppi8jDftkrkhfNtXeCT
         jX5tiJugfgwWcGn07n1T+0IQ0C/Nl5fWrv4A1uvFDZ99Y2l9iLnfbBAKtvz05YTW36
         X9zgHtoyDa7AD+mWmElBJ12FGQFBruDCy1YI7lkjqZmBc+xwmJv8nJ/BO8qZr00xUs
         vd/8phH85v3cwFLZE2XMyvJkGCeqy82qjDajro5YmIIwZDL9DTbmXu8hPr7Zhn7JQT
         wq0icwaUGgWhw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Max Staudt <max@enpas.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org
Subject: [PATCH 14/36] tty: can327, move overflow test inside can327_ldisc_rx()'s loop
Date:   Thu, 10 Aug 2023 11:14:48 +0200
Message-ID: <20230810091510.13006-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
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

The 'count' is going to be unsigned and the 'count >= 0' test would be
always true then. Move the condition to the loop where this is easier to
check.

It looks as is easier to follow after all too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org
---
 drivers/net/can/can327.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 05e9c035e8f6..4533dc00f215 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -901,7 +901,13 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 	 */
 	first_new_char_idx = elm->rxfill;
 
-	while (count-- && elm->rxfill < CAN327_SIZE_RXBUF) {
+	while (count--) {
+		if (elm->rxfill >= CAN327_SIZE_RXBUF) {
+			netdev_err(elm->dev,
+				   "Receive buffer overflowed. Bad chip or wiring? count = %i",
+				   count);
+			goto uart_failure;
+		}
 		if (fp && *fp++) {
 			netdev_err(elm->dev,
 				   "Error in received character stream. Check your wiring.");
@@ -930,13 +936,6 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 		cp++;
 	}
 
-	if (count >= 0) {
-		netdev_err(elm->dev,
-			   "Receive buffer overflowed. Bad chip or wiring? count = %i",
-			   count);
-		goto uart_failure;
-	}
-
 	can327_parse_rxbuf(elm, first_new_char_idx);
 	spin_unlock_bh(&elm->lock);
 
-- 
2.41.0

