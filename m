Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC557A5D00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjISIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjISIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8412E;
        Tue, 19 Sep 2023 01:52:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC7C433C8;
        Tue, 19 Sep 2023 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113528;
        bh=ZSeRU/J9vOcRgycVzT++vhk9dRRkV/hU87U+8mdV2zI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSkQCk2aWWRAJBU7+hY1DaVrqtoJcJgLtaF6RZCMlcLkASGNr8Ta3RC0W1MAXNUe7
         fiatGtAZkrVuRGI4DlmejZ2vmQnuwuw46F8uiQEPYclrjiRCJj/vHoOpv3I+xLZsn4
         DJgwBtGkmDmEbmP+guVImbr1D4JGBXJZrv3qeAKmt7dAzerI6/780gCme4Q6xgmtJe
         r0CIDN84H8S4hu0s14XeGPuX9E6ySsOYBtYotXPce21m1rmQQlUCdAQeVjGs3hsEUa
         IiQhEWUnfEV9r05ygb5EEjA+2IokWFGMmZO5lwt1cGefQ4Q124D15J6upEqVWBuBnX
         JY8IhF4fLj2gA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/15] tty: switch tty_{,un}throttle_safe() to return a bool
Date:   Tue, 19 Sep 2023 10:51:47 +0200
Message-ID: <20230919085156.1578-7-jirislaby@kernel.org>
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

They return 0 or 1 -- a boolean value, so make it clear than noone
should expect negative or other values.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_ioctl.c | 18 ++++++++----------
 include/linux/tty.h     |  4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 7958bf6d27c4..ba60fcf518e0 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -124,17 +124,16 @@ EXPORT_SYMBOL(tty_unthrottle);
  *	conditions when throttling is conditional on factors evaluated prior to
  *	throttling.
  *
- *	Returns 0 if tty is throttled (or was already throttled)
+ *	Returns false if tty is throttled (or was already throttled)
  */
-
-int tty_throttle_safe(struct tty_struct *tty)
+bool tty_throttle_safe(struct tty_struct *tty)
 {
-	int ret = 0;
+	bool ret = false;
 
 	mutex_lock(&tty->throttle_mutex);
 	if (!tty_throttled(tty)) {
 		if (tty->flow_change != TTY_THROTTLE_SAFE)
-			ret = 1;
+			ret = true;
 		else {
 			set_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->throttle)
@@ -155,17 +154,16 @@ int tty_throttle_safe(struct tty_struct *tty)
  *	unthrottle due to race conditions when unthrottling is conditional
  *	on factors evaluated prior to unthrottling.
  *
- *	Returns 0 if tty is unthrottled (or was already unthrottled)
+ *	Returns false if tty is unthrottled (or was already unthrottled)
  */
-
-int tty_unthrottle_safe(struct tty_struct *tty)
+bool tty_unthrottle_safe(struct tty_struct *tty)
 {
-	int ret = 0;
+	bool ret = false;
 
 	mutex_lock(&tty->throttle_mutex);
 	if (tty_throttled(tty)) {
 		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
-			ret = 1;
+			ret = true;
 		else {
 			clear_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->unthrottle)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index f002d0f25db7..59d675f345e9 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -416,8 +416,8 @@ unsigned int tty_chars_in_buffer(struct tty_struct *tty);
 unsigned int tty_write_room(struct tty_struct *tty);
 void tty_driver_flush_buffer(struct tty_struct *tty);
 void tty_unthrottle(struct tty_struct *tty);
-int tty_throttle_safe(struct tty_struct *tty);
-int tty_unthrottle_safe(struct tty_struct *tty);
+bool tty_throttle_safe(struct tty_struct *tty);
+bool tty_unthrottle_safe(struct tty_struct *tty);
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
 int tty_get_icount(struct tty_struct *tty,
 		struct serial_icounter_struct *icount);
-- 
2.42.0

