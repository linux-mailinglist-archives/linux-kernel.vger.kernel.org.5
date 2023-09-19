Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706557A5D10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjISIxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjISIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:53:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502D1CED;
        Tue, 19 Sep 2023 01:52:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FF4C433C7;
        Tue, 19 Sep 2023 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113542;
        bh=7UoeuQSc61iexVhpiA9OIZHl2gZTKMqiBLJ5FoPV2xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeWUWhVAi9S3XdxAdbNO7sAK5hMkVsAqMrVWbaNvxJ0mhN/otAEI9OKSuns7zvmD+
         U3h3PB2aa7EkDgi2R1w0iYUkai8W3Qg1ADkOPyyH/TNshv+/pOiUGenfG+3UkuIkqv
         dEWLQyenySZpDxTsy93hXuPclq6kOlTS9ct1EweJUyVZJS9dmfZuhpPe+jmY7n1tfP
         IYVb7oQwPS4QQl3dJKdDSlp9wDS/Kk1NXsDlpatBKVLdSvzkQ7c8/duEmLmlnEWs9I
         +X1SLwxxJjHXOLMcHIb+/uhbTe1ofrgUBn1zT5owaxmoFpeBgysn5K7+Wupj6v8JLi
         2XYz9NenJZ5Yw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/15] tty: use 'if' in send_break() instead of 'goto'
Date:   Tue, 19 Sep 2023 10:51:56 +0200
Message-ID: <20230919085156.1578-16-jirislaby@kernel.org>
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

Now, the "jumped-over" code is simple enough to be put inside an 'if'.
Do so to make it 'goto'-less.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 24833b31b81c..378257c4c41a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2482,11 +2482,10 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		return -EINTR;
 
 	retval = tty->ops->break_ctl(tty, -1);
-	if (retval)
-		goto out;
-	msleep_interruptible(duration);
-	retval = tty->ops->break_ctl(tty, 0);
-out:
+	if (!retval) {
+		msleep_interruptible(duration);
+		retval = tty->ops->break_ctl(tty, 0);
+	}
 	tty_write_unlock(tty);
 
 	if (signal_pending(current))
-- 
2.42.0

