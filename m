Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C3768F84
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjGaIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjGaIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E57A2133;
        Mon, 31 Jul 2023 01:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A0560F73;
        Mon, 31 Jul 2023 08:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8000C433CB;
        Mon, 31 Jul 2023 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790568;
        bh=+zO7FyhxfQpim+6aXiX4wyEaVl0osOo9Jvm1XcJ4UJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWAi6/awhedagqhtUxkRfSFEcBp0m21vHP4yhbx1qdtbAYNtOaRV/42d3dD1ffs0J
         psw77i3kD1b6CspYgk+bxW6errj/WJ7o9HB7HHIx0uRUS+TXY4AShCup9tUxr1lXgq
         xQM172uelQ+mpcZU10nsf84+1nSg1miWa1fMygDxHWMAXFp1U4avA+b7WPd9NL/tUw
         XaCNHxvYHelZb7cnWSjY+4fJUynuU1/fgQu6+kcZc9FFWvvYycDmCeQVcFn/pMWSUZ
         /apXW0/CLyQ8MToM0R8AzCurEw5nH91+l0S+2YJXKuEsgQJro/XXKFwQoBqX4AGmC1
         QV8leulMcBx3w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/10] serial: move WARN_ON() in uart_write() to the condition
Date:   Mon, 31 Jul 2023 10:02:35 +0200
Message-ID: <20230731080244.2698-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
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

uart code currently does the following in uart_write() and
uart_flush_buffer():
  if (cond) {
    WARN_ON(1);
    return;
  }

It can be rewritten to more obvious and more readable:
  if (WARN_ON(cond))
    return;

Do so.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 306ea1a560e6..e31c9b6bd8ab 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -593,10 +593,8 @@ static int uart_write(struct tty_struct *tty,
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
-	if (!state) {
-		WARN_ON(1);
+	if (WARN_ON(!state))
 		return -EL3HLT;
-	}
 
 	port = uart_port_lock(state, flags);
 	circ = &state->xmit;
@@ -659,10 +657,8 @@ static void uart_flush_buffer(struct tty_struct *tty)
 	 * This means you called this function _after_ the port was
 	 * closed.  No cookie for you.
 	 */
-	if (!state) {
-		WARN_ON(1);
+	if (WARN_ON(!state))
 		return;
-	}
 
 	pr_debug("uart_flush_buffer(%d) called\n", tty->index);
 
-- 
2.41.0

