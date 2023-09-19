Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2707A5D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjISIxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjISIwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB114CD4;
        Tue, 19 Sep 2023 01:52:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F4EC433CA;
        Tue, 19 Sep 2023 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113539;
        bh=sBYy4MCg26JYrXy0gwZ0Nr1JdsECrLQpru6I38p6zcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYkkm6up1ylExFiI7/fEXdVEtiLaRZAtvTfHMM0jUnd54djsYGgh/j0kY71BgBuM+
         CufdJShWc8N/K0MQgl1iJPbZ02JXEE7Dc/r35sUQdAfIIcFdSjyfWM6do/yUUGlt+8
         nh6xYujPTbU36RYph2odRjjhlIuU67bR4WmzVOfVo+Uzc50r0OpS2fme3JCn/7pTA4
         d1vzjRb3yIbdN7BfRdhT+oNYYNlT24PN3BTvt1x8vqFc3ncTaL6tmD1cfc99eYXVHf
         zAj+YvGrMje156QwQv5vW8wDPJDvZC3DaGmVSsmSSicrotN6BnlAzC5m/Tf9s9+7j8
         C2aCGHM3Vb+dA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 13/15] tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
Date:   Tue, 19 Sep 2023 10:51:54 +0200
Message-ID: <20230919085156.1578-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
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

If the driver sets TTY_DRIVER_HARDWARE_BREAK, we leave ops->break_ctl()
to the driver and return from send_break(). But we do it using a local
variable and keep the code flowing through the end of the function.
Instead, do 'return' immediately with the ops->break_ctl()'s return
value.

This way, we don't have to stuff the 'else' branch of the 'if' with the
software break handling. And we can re-indent the function too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 2ed12ca7c832..87bb5094e0bb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2475,22 +2475,24 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		return 0;
 
 	if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK)
-		retval = tty->ops->break_ctl(tty, duration);
-	else {
-		/* Do the work ourselves */
-		if (tty_write_lock(tty, false) < 0)
-			return -EINTR;
-		retval = tty->ops->break_ctl(tty, -1);
-		if (retval)
-			goto out;
-		if (!signal_pending(current))
-			msleep_interruptible(duration);
-		retval = tty->ops->break_ctl(tty, 0);
+		return tty->ops->break_ctl(tty, duration);
+
+	/* Do the work ourselves */
+	if (tty_write_lock(tty, false) < 0)
+		return -EINTR;
+
+	retval = tty->ops->break_ctl(tty, -1);
+	if (retval)
+		goto out;
+	if (!signal_pending(current))
+		msleep_interruptible(duration);
+	retval = tty->ops->break_ctl(tty, 0);
 out:
-		tty_write_unlock(tty);
-		if (signal_pending(current))
-			retval = -EINTR;
-	}
+	tty_write_unlock(tty);
+
+	if (signal_pending(current))
+		retval = -EINTR;
+
 	return retval;
 }
 
-- 
2.42.0

