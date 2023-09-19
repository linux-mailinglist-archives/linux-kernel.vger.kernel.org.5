Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1F7A5D03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjISIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjISIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9C13E;
        Tue, 19 Sep 2023 01:52:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4AC433CB;
        Tue, 19 Sep 2023 08:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113530;
        bh=T0UlL4dJ7nKnPYDQUpzwfarotHSS6h+uw/UVfPjepWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PE6RZu4E2pHbBCyV6pom97I/g08Z5+9CF0+PhG4Sd9PnLRqDq8H8zZ3/UvP5E2yms
         PZGunZIKGSXoHRbR74wzns9/QL+snkgYWuTzdMfp30wIgtPoMsklFb/pBdA1sBXq3p
         UrKIbIpcyUxyQce0X2qfi5LLzl1+3GteLzz9pEoZX0i0/0vNVI1R4SS11tfBmF11gd
         aV4gjNsg8F0sSU8DSvaeIjuPBr6aziz0tGieVfhrwd6ubAiNGKFRUXvineKNRl843m
         FozkykZ+Tlw7cO76HFdzg8uS6J9Jh2ckIIrIxi+RnLpNkulXq503LbnZsu6xgRR/m7
         wCldGiQyJo2Nw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/15] tty: invert return values of tty_{,un}throttle_safe()
Date:   Tue, 19 Sep 2023 10:51:48 +0200
Message-ID: <20230919085156.1578-8-jirislaby@kernel.org>
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

If tty_{,un}throttle_safe() returned true on success (similar to
*_trylock()), it would make the conditions in callers more obvious. So
perform the switch to these inverted values (and fix the callers).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c     |  4 ++--
 drivers/tty/tty_ioctl.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b34e6612aef6..f252d0b5a434 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -253,7 +253,7 @@ static void n_tty_check_throttle(struct tty_struct *tty)
 		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
 		if (N_TTY_BUF_SIZE - read_cnt(ldata) >= TTY_THRESHOLD_THROTTLE)
 			break;
-	} while (tty_throttle_safe(tty));
+	} while (!tty_throttle_safe(tty));
 
 	__tty_set_flow_change(tty, 0);
 }
@@ -282,7 +282,7 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 			break;
 
 		n_tty_kick_worker(tty);
-	} while (tty_unthrottle_safe(tty));
+	} while (!tty_unthrottle_safe(tty));
 
 	__tty_set_flow_change(tty, 0);
 }
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index ba60fcf518e0..fb2f1ac5172f 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -124,16 +124,16 @@ EXPORT_SYMBOL(tty_unthrottle);
  *	conditions when throttling is conditional on factors evaluated prior to
  *	throttling.
  *
- *	Returns false if tty is throttled (or was already throttled)
+ *	Returns true if tty is throttled (or was already throttled)
  */
 bool tty_throttle_safe(struct tty_struct *tty)
 {
-	bool ret = false;
+	bool ret = true;
 
 	mutex_lock(&tty->throttle_mutex);
 	if (!tty_throttled(tty)) {
 		if (tty->flow_change != TTY_THROTTLE_SAFE)
-			ret = true;
+			ret = false;
 		else {
 			set_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->throttle)
@@ -154,16 +154,16 @@ bool tty_throttle_safe(struct tty_struct *tty)
  *	unthrottle due to race conditions when unthrottling is conditional
  *	on factors evaluated prior to unthrottling.
  *
- *	Returns false if tty is unthrottled (or was already unthrottled)
+ *	Returns true if tty is unthrottled (or was already unthrottled)
  */
 bool tty_unthrottle_safe(struct tty_struct *tty)
 {
-	bool ret = false;
+	bool ret = true;
 
 	mutex_lock(&tty->throttle_mutex);
 	if (tty_throttled(tty)) {
 		if (tty->flow_change != TTY_UNTHROTTLE_SAFE)
-			ret = true;
+			ret = false;
 		else {
 			clear_bit(TTY_THROTTLED, &tty->flags);
 			if (tty->ops->unthrottle)
-- 
2.42.0

