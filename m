Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD42777404
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHJJPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbjHJJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71245268E;
        Thu, 10 Aug 2023 02:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 053CE612F0;
        Thu, 10 Aug 2023 09:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4DCC433C8;
        Thu, 10 Aug 2023 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658923;
        bh=XHiSm7fyHktEOt8LKQ030hOTo0nKBj8nbSwtdoWaBYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGeF9MPjaocz2AU4PwKqcf10Id/Znp6tJtB2pCuf/LQ92ae6s9NUcdTnriBMjwIHf
         Nzqqz1Mqkqm15AQ2gBAQLeZJXOPYyLP0OrTRUpQ1Os1Kyc6uc4DYw50B8f5oCDZZ7w
         Z0VNJEDzhi5PqXw1NBRaeC9MTPSyHgeJlCwlLoIOFKervKAGOdeqRgoC/+PIkWsi8h
         6dQfkdmuO16o5qCnIuWl8DqvDvlCtG3tksjxUvxVMBTG69iXYZHeCLzBnZdagw50uv
         SweMDOEn+r0JUdAc38i7jiWm6DqdJEyjQQRNyweGMojwp2dPV7r+kZBsT9TQQ4nYg6
         0DlIPRFkujOnA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/36] tty: change tty_write_lock()'s ndelay parameter to bool
Date:   Thu, 10 Aug 2023 11:14:39 +0200
Message-ID: <20230810091510.13006-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
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

It's a yes-no parameter, so convert it to bool to be obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty.h       | 2 +-
 drivers/tty/tty_io.c    | 6 +++---
 drivers/tty/tty_ioctl.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index 89769a1f1f97..2751ac3946e7 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -63,7 +63,7 @@ int tty_check_change(struct tty_struct *tty);
 void __stop_tty(struct tty_struct *tty);
 void __start_tty(struct tty_struct *tty);
 void tty_write_unlock(struct tty_struct *tty);
-int tty_write_lock(struct tty_struct *tty, int ndelay);
+int tty_write_lock(struct tty_struct *tty, bool ndelay);
 void tty_vhangup_session(struct tty_struct *tty);
 void tty_open_proc_set_tty(struct file *filp, struct tty_struct *tty);
 int tty_signal_session_leader(struct tty_struct *tty, int exit_session);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index eb4e2e0e300d..54036a20a102 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -946,7 +946,7 @@ void tty_write_unlock(struct tty_struct *tty)
 	wake_up_interruptible_poll(&tty->write_wait, EPOLLOUT);
 }
 
-int tty_write_lock(struct tty_struct *tty, int ndelay)
+int tty_write_lock(struct tty_struct *tty, bool ndelay)
 {
 	if (!mutex_trylock(&tty->atomic_write_lock)) {
 		if (ndelay)
@@ -1160,7 +1160,7 @@ int tty_send_xchar(struct tty_struct *tty, char ch)
 		return 0;
 	}
 
-	if (tty_write_lock(tty, 0) < 0)
+	if (tty_write_lock(tty, false) < 0)
 		return -ERESTARTSYS;
 
 	down_read(&tty->termios_rwsem);
@@ -2486,7 +2486,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 		retval = tty->ops->break_ctl(tty, duration);
 	else {
 		/* Do the work ourselves */
-		if (tty_write_lock(tty, 0) < 0)
+		if (tty_write_lock(tty, false) < 0)
 			return -EINTR;
 		retval = tty->ops->break_ctl(tty, -1);
 		if (retval)
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 2e88b414cf95..e3e1318f53fd 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -507,7 +507,7 @@ static int set_termios(struct tty_struct *tty, void __user *arg, int opt)
 		if (retval < 0)
 			return retval;
 
-		if (tty_write_lock(tty, 0) < 0)
+		if (tty_write_lock(tty, false) < 0)
 			goto retry_write_wait;
 
 		/* Racing writer? */
-- 
2.41.0

