Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA58F7A5D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjISIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjISIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAB9CC1;
        Tue, 19 Sep 2023 01:52:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C10AC433C7;
        Tue, 19 Sep 2023 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113537;
        bh=jiyKASpXi6MYcdCnNOZJbf6KGqt7M6RZbaUycBdsb4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuz9riijm9i2tr9t/zbMSGKMyNRmUuZXGe12qbYLf/5NZ3CSKZo7CPAcl09oGiEgn
         ggylnD2lTgc1o2umsq1e9ogvZIPuGVWVDLF0S7R1E11DRsX/9uh9LA5jEChRaV/rJ2
         uRDGeLlFlYk/KRy9iyRA4FaWtmsHIWzoeQLo9yHaqgdHy62V6u5HltyE8QnpFojqO2
         RXN4dYPodKMwnFRrWw2bmZhPZrh0xJeH5XNcCI19YRhwy1087TeCa5bKYKJAmi2i2w
         qrEy23AkD+n8bu8AezBncMhDnhabL5YgroLBlesFgiJ0xMOfNXx/D+awwOUGFdIJnX
         mAu2M7tS57mIQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 12/15] tty: convert THROTTLE constants into enum
Date:   Tue, 19 Sep 2023 10:51:53 +0200
Message-ID: <20230919085156.1578-13-jirislaby@kernel.org>
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

And make an explicit constant for zero too. This allows for easier type
checking of the parameter.

Note: tty_struct::flow_change is kept as int because include/tty.h
(tty_struct) doesn't see tty/tty.h (this enum).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty.h       | 13 +++++++++----
 drivers/tty/tty_ioctl.c |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 50862f98273e..93cf5ef1e857 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -41,15 +41,20 @@ enum {
 };
 
 /* Values for tty->flow_change */
-#define TTY_THROTTLE_SAFE	1
-#define TTY_UNTHROTTLE_SAFE	2
+enum tty_flow_change {
+	TTY_FLOW_NO_CHANGE,
+	TTY_THROTTLE_SAFE,
+	TTY_UNTHROTTLE_SAFE,
+};
 
-static inline void __tty_set_flow_change(struct tty_struct *tty, int val)
+static inline void __tty_set_flow_change(struct tty_struct *tty,
+					 enum tty_flow_change val)
 {
 	tty->flow_change = val;
 }
 
-static inline void tty_set_flow_change(struct tty_struct *tty, int val)
+static inline void tty_set_flow_change(struct tty_struct *tty,
+				       enum tty_flow_change val)
 {
 	tty->flow_change = val;
 	smp_mb();
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 42c793e9d131..4b499301a3db 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -104,7 +104,7 @@ void tty_unthrottle(struct tty_struct *tty)
 	if (test_and_clear_bit(TTY_THROTTLED, &tty->flags) &&
 	    tty->ops->unthrottle)
 		tty->ops->unthrottle(tty);
-	tty->flow_change = 0;
+	tty->flow_change = TTY_FLOW_NO_CHANGE;
 	up_write(&tty->termios_rwsem);
 }
 EXPORT_SYMBOL(tty_unthrottle);
-- 
2.42.0

