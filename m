Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381F7D2BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjJWHtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjJWHtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:49:06 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E2DED7F;
        Mon, 23 Oct 2023 00:49:05 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 17C5880BB;
        Mon, 23 Oct 2023 07:49:01 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Mikko Rapeli <mikko.rapeli@linaro.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy MacLeod <randy.macleod@windriver.com>
Subject: [PATCH] serial: core: Fix runtime PM handling for pending tx
Date:   Mon, 23 Oct 2023 10:48:54 +0300
Message-ID: <20231023074856.61896-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard reported that a serial port may end up sometimes with tx data
pending in the buffer for long periods of time.

Turns out we bail out early on any errors from pm_runtime_get(),
including -EINPROGRESS. To fix the issue, we need to ignore -EINPROGRESS
as we only care about the runtime PM usage count at this point. We check
for an active runtime PM state later on for tx.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Randy MacLeod <randy.macleod@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -146,7 +146,7 @@ static void __uart_start(struct uart_state *state)
 
 	/* Increment the runtime PM usage count for the active check below */
 	err = pm_runtime_get(&port_dev->dev);
-	if (err < 0) {
+	if (err < 0 && err != -EINPROGRESS) {
 		pm_runtime_put_noidle(&port_dev->dev);
 		return;
 	}
-- 
2.42.0
