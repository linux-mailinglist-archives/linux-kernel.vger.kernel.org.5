Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A9777417
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjHJJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjHJJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D326AB;
        Thu, 10 Aug 2023 02:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2247C654D3;
        Thu, 10 Aug 2023 09:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004D2C433CA;
        Thu, 10 Aug 2023 09:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658937;
        bh=kbnu6b3hLQjWdfnuwr7SeXr3exMSU6M7+jqx7zQJd3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfijH1FwDoxzGj1CXeU8p4mDVBdq8oeaMH4aJuVSLiuDhUR3X5lOC+f9d47Rg8vPl
         pysjNfmG9qAKraPtDuHnv585nnRC9bXUvSUHKeFD3UYSrX6KLYV9+wJg6ZK3aTYuTl
         qPH5Xh7AKYJ96e5jcKwiadEy4oUMkjEmFyIBzoqzFgpM7CseZB7hXyXns+yeeSma7Q
         JulPMfYJCHS4zli+NO9vqERnpwLWBwj17/3oLFmcBtRDtb+CzETUSWoAElafUIz6sy
         HyAFY4Ap1J/coWzhy2JaWYiSP3Z+6m/caH5vd4dHHO1oGTEOj/cpZU7DNG0X3/xBvX
         CQs1v1M6Jtr8Q==
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
Subject: [PATCH 13/36] tty: can327: unify error paths in can327_ldisc_rx()
Date:   Thu, 10 Aug 2023 11:14:47 +0200
Message-ID: <20230810091510.13006-14-jirislaby@kernel.org>
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

Create a label with can327_uart_side_failure() and spin unlock. And jump
there from all three fail paths.

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
 drivers/net/can/can327.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index ee8a977acc8d..05e9c035e8f6 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -905,11 +905,7 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 		if (fp && *fp++) {
 			netdev_err(elm->dev,
 				   "Error in received character stream. Check your wiring.");
-
-			can327_uart_side_failure(elm);
-
-			spin_unlock_bh(&elm->lock);
-			return;
+			goto uart_failure;
 		}
 
 		/* Ignore NUL characters, which the PIC microcontroller may
@@ -925,10 +921,7 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 				netdev_err(elm->dev,
 					   "Received illegal character %02x.\n",
 					   *cp);
-				can327_uart_side_failure(elm);
-
-				spin_unlock_bh(&elm->lock);
-				return;
+				goto uart_failure;
 			}
 
 			elm->rxbuf[elm->rxfill++] = *cp;
@@ -941,15 +934,16 @@ static void can327_ldisc_rx(struct tty_struct *tty, const unsigned char *cp,
 		netdev_err(elm->dev,
 			   "Receive buffer overflowed. Bad chip or wiring? count = %i",
 			   count);
-
-		can327_uart_side_failure(elm);
-
-		spin_unlock_bh(&elm->lock);
-		return;
+		goto uart_failure;
 	}
 
 	can327_parse_rxbuf(elm, first_new_char_idx);
 	spin_unlock_bh(&elm->lock);
+
+	return;
+uart_failure:
+	can327_uart_side_failure(elm);
+	spin_unlock_bh(&elm->lock);
 }
 
 /* Write out remaining transmit buffer.
-- 
2.41.0

