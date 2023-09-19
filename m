Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DB7A5CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjISIwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjISIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B11115;
        Tue, 19 Sep 2023 01:52:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871DCC433C9;
        Tue, 19 Sep 2023 08:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113522;
        bh=G9M97eO3CGXGTSXO+0/2OlKFcuUp/E1ELuqJbqNhEGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJQll1ZmauxeJU4pKgcDlD9rkOF/GzfxVwwWk5QHvDrGkRFAPLBvRh0ztgj8f6wRO
         5r3+MJWp4UI1M5bXxrptPZMDsdAGuA/40twKpUGHiWJJeLrjQQlpZcjcm4/dBFPLHQ
         cfF2jDWFortZ7UC+wfaYvFya8RTu2hh8SLj1+m9GA0HPzoLjt7/wkBqBIvQjgeXGM0
         wOhBp3ePQlLHOaCv5mihegcPO2GkEugER1OmTU9rN46CKUNZGrLPhFRRD9+nI7I02W
         bAEHMYKhaEzcyqbW2NViQaM1cjYQMSiIHxachukp7oemNS2q4IceBxQ2iiA0pi6BvP
         IgBZOKvU9dAbg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/15] tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
Date:   Tue, 19 Sep 2023 10:51:43 +0200
Message-ID: <20230919085156.1578-3-jirislaby@kernel.org>
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

The value stored to the current 'retval' is number of characters. It is
both obtained and put to user as unsigned. So make its type unsigned.
And provided it's not a "return value" per se, rename it to 'num'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 71aa898b077a..e917faa0b84c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2498,7 +2498,7 @@ static int n_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
 	struct n_tty_data *ldata = tty->disc_data;
-	int retval;
+	unsigned int num;
 
 	switch (cmd) {
 	case TIOCOUTQ:
@@ -2506,11 +2506,11 @@ static int n_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	case TIOCINQ:
 		down_write(&tty->termios_rwsem);
 		if (L_ICANON(tty) && !L_EXTPROC(tty))
-			retval = inq_canon(ldata);
+			num = inq_canon(ldata);
 		else
-			retval = read_cnt(ldata);
+			num = read_cnt(ldata);
 		up_write(&tty->termios_rwsem);
-		return put_user(retval, (unsigned int __user *) arg);
+		return put_user(num, (unsigned int __user *) arg);
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
-- 
2.42.0

