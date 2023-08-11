Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F707778798
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHKGnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHKGnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9802D41;
        Thu, 10 Aug 2023 23:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEFD865416;
        Fri, 11 Aug 2023 06:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6678C433C8;
        Fri, 11 Aug 2023 06:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691736224;
        bh=Ls2zMPANCq4n8zcJeSklRLY1qQY2H5Ysy9vX31ySfT4=;
        h=From:To:Cc:Subject:Date:From;
        b=XZu5TEFPZdnjEgq64XK4X+7flyOxSLEOspoKVljn28erlKLykZx3CH1jcrR4kUYIx
         3qk34mHOa7MkqBWaBW9RwipcwtdbFPSBHQPqMuBd6C/oehqRAAaPOh6u/Fbt0sV2qH
         nXiBx3KmiloGJ5gbB0nqfySWPdopNpIeByYW9MJpVCL0RdglwtbfK1PH+6FcbjO5TD
         pKFCGEOEd8ZNLDAKykyk98JR0RA3AZUKp+VivaZBmPbNwZtG2OV/h7iEGwpv7/SQk3
         FOmz4YwTnDSZopSYli2YAzQb+DX9Q4kH0zGAo/YU2AM6h+vQnf9Sl4/HsCmxrkvSAm
         mtEVx3UNtDJ/g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH] serial: 8250: drop lockdep annotation from serial8250_clear_IER()
Date:   Fri, 11 Aug 2023 08:43:40 +0200
Message-ID: <20230811064340.13400-1-jirislaby@kernel.org>
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

The port lock is not always held when calling serial8250_clear_IER().
When an oops is in progress, the lock is tried to be taken and when it
is not, a warning is issued:
 WARNING: CPU: 0 PID: 1 at drivers/tty/serial/8250/8250_port.c:707 	+0x57/0x60
 Modules linked in:
 CPU: 0 PID: 1 Comm: init Not tainted 6.5.0-rc5-1.g225bfb7-default+ #774 00f1be860db663ed29479b8255d3b01ab1135bd3
 Hardware name: QEMU Standard PC ...
 RIP: 0010:serial8250_clear_IER+0x57/0x60
...
 Call Trace:
  <TASK>
  serial8250_console_write+0x9e/0x4b0
  console_flush_all+0x217/0x5f0
...

Therefore, remove the annotation as it doesn't hold for all invocations.

The other option would be to make the lockdep test conditional on
'oops_in_progress' or pass 'locked' from serial8250_console_write(). I
don't think, that is worth it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Cc: John Ogness <john.ogness@linutronix.de>
Fixes: d0b309a5d3f4 (serial: 8250: synchronize and annotate UART_IER access)
---
 drivers/tty/serial/8250/8250_port.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ecfdc4534123..f59328e1c35d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -703,9 +703,6 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 
 static void serial8250_clear_IER(struct uart_8250_port *up)
 {
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&up->port.lock);
-
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
 	else
-- 
2.41.0

