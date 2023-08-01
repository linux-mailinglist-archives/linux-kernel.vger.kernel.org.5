Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAA76A8E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjHAGXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjHAGWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA7219AA;
        Mon, 31 Jul 2023 23:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21FA361483;
        Tue,  1 Aug 2023 06:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CFC4339A;
        Tue,  1 Aug 2023 06:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690870970;
        bh=kuEWnL9p9BoO9qyiypu88WnOmaK1A5r5Av53wC58X/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTAaCdjqqtaGw4jXqE8Zp1B4A46QbjBp0dXr631H/PgNlLVBuyCklYAGke2Wh0SrB
         V3LiY5YC3HRiuHhVcgPq7e69TY1EfVP0ql+l85qpEBSMzhf5uQV4tFTSYFr0fOcbD8
         YijqLZynDBoU/TqXA6ioHSRUf0zg2cPEPkzDJ9f3wj9kVA8/uPOlBzgCkQGQN9i6Pw
         MPgq4IbGoM20r5r/j6iwS46RTzkeZJdGrcnUb/gBr559dRO7FmwyUfLNRKW9oHmcfA
         G8TOEodJKvNN7nvplCEH4mTmHxXpQvq9abVmp9aoVl+hf+yq/awLxqUl2ijo8ewb5h
         wIgfwLXTr1gpA==
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
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/2] net: nfc: remove casts from tty->disc_data
Date:   Tue,  1 Aug 2023 08:22:37 +0200
Message-ID: <20230801062237.2687-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801062237.2687-1-jirislaby@kernel.org>
References: <20230801062237.2687-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty->disc_data is 'void *', so there is no need to cast from that.
Therefore remove the casts and assign the pointer directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Max Staudt <max@enpas.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 net/nfc/nci/uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index cc8fa9e36159..082f94be0996 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -172,7 +172,7 @@ static int nci_uart_tty_open(struct tty_struct *tty)
  */
 static void nci_uart_tty_close(struct tty_struct *tty)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	/* Detach from the tty */
 	tty->disc_data = NULL;
@@ -204,7 +204,7 @@ static void nci_uart_tty_close(struct tty_struct *tty)
  */
 static void nci_uart_tty_wakeup(struct tty_struct *tty)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	if (!nu)
 		return;
@@ -298,7 +298,7 @@ static int nci_uart_default_recv_buf(struct nci_uart *nu, const u8 *data,
 static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 				 const char *flags, int count)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 
 	if (!nu || tty != nu->tty)
 		return;
@@ -325,7 +325,7 @@ static void nci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 static int nci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 			      unsigned long arg)
 {
-	struct nci_uart *nu = (void *)tty->disc_data;
+	struct nci_uart *nu = tty->disc_data;
 	int err = 0;
 
 	switch (cmd) {
-- 
2.41.0

