Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F93A7A5CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjISIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjISIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71300102;
        Tue, 19 Sep 2023 01:52:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F31AC433C7;
        Tue, 19 Sep 2023 08:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113527;
        bh=OjwKIBmFPVUbsZin5q6xLKXnnlWzbN3in7M3kjyOOwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhAfZq9aAM+DqMYLnxK4AQzV0iit37kY24wGkl6tBr386M+RHgG5r7gctFeka/q27
         jXIL6cHNzfzhf6yeVKWiW+tUfvn5DiKUSm8rDcWouhipBDn6Qv1N/4ixOh9+fuyEwL
         63N7ZrVIkZ0h8PYG8lrMEmE5wkjRCN1qcuwPoEE3nH7uHbaaaUgKT4BnX1CRcP80FC
         Lo+zi+gXB5J6qbKg9p9KwL4or57Tle7itLfqKmqMxSlYydKWGwgM4YmdGP5jAKxAyu
         /MpOIOiZ9CL1OxohhWpZiNMgd+W8CoA2ODuyRLraCtEjf1mqCvXa7y3iuG3GSyDD7W
         zJn5Na/RmvHYg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/15] tty: n_tty: use do-while in n_tty_check_{,un}throttle()
Date:   Tue, 19 Sep 2023 10:51:46 +0200
Message-ID: <20230919085156.1578-6-jirislaby@kernel.org>
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

This change gets rid of the complicated exit from the loops. It can be
done much easier using do-while loops.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 922fb61b587a..b34e6612aef6 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -249,15 +249,12 @@ static void n_tty_check_throttle(struct tty_struct *tty)
 	if (ldata->icanon && ldata->canon_head == ldata->read_tail)
 		return;
 
-	while (1) {
-		int throttled;
+	do {
 		tty_set_flow_change(tty, TTY_THROTTLE_SAFE);
 		if (N_TTY_BUF_SIZE - read_cnt(ldata) >= TTY_THRESHOLD_THROTTLE)
 			break;
-		throttled = tty_throttle_safe(tty);
-		if (!throttled)
-			break;
-	}
+	} while (tty_throttle_safe(tty));
+
 	__tty_set_flow_change(tty, 0);
 }
 
@@ -279,16 +276,14 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 	 * we won't get any more characters.
 	 */
 
-	while (1) {
-		int unthrottled;
+	do {
 		tty_set_flow_change(tty, TTY_UNTHROTTLE_SAFE);
 		if (chars_in_buffer(tty) > TTY_THRESHOLD_UNTHROTTLE)
 			break;
+
 		n_tty_kick_worker(tty);
-		unthrottled = tty_unthrottle_safe(tty);
-		if (!unthrottled)
-			break;
-	}
+	} while (tty_unthrottle_safe(tty));
+
 	__tty_set_flow_change(tty, 0);
 }
 
-- 
2.42.0

