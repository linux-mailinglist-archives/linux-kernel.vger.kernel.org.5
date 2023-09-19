Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940C07A5D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjISIx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjISIwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D26102;
        Tue, 19 Sep 2023 01:52:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B557C433C8;
        Tue, 19 Sep 2023 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113540;
        bh=DHSUENlyJd4uiUZGKQE8nkqG9haGv3P+QdL7CmU1Hf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQn08LAlbbz6RAgVL829tUjtjxoeZzG+Lm2yVb1SKAWDqex4ewLDs9jHvVcIgAvai
         1cSpctU0XnIcwe2Ait94+n/9AVqmkLDh33EsLGJrXwxzWuDGxgtb3/L3mkFWI1OFPC
         VWU1KisqRD9ycP3D8G/HD+FXNcH8ozkTqMM5YBN/asOz7cOtwHIoiNfMmHKhqk4CY5
         IuKEbjLBjtILUuU+KWNfqduu1F44MweAupMkNnJ+9ZhcKgkUXijkjKkyk1DsHclNuI
         lbTmkiO07wnH5+9nrFU8rGWixSvKflIzn4bux8W6CKqV+D6arvV0pqpnESUuNs0eF3
         6PJM5Pd7mo2Lg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/15] tty: don't check for signal_pending() in send_break()
Date:   Tue, 19 Sep 2023 10:51:55 +0200
Message-ID: <20230919085156.1578-15-jirislaby@kernel.org>
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

msleep_interruptible() will check on its own. So no need to do the check
in send_break() before calling the above.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 87bb5094e0bb..24833b31b81c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2484,8 +2484,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 	retval = tty->ops->break_ctl(tty, -1);
 	if (retval)
 		goto out;
-	if (!signal_pending(current))
-		msleep_interruptible(duration);
+	msleep_interruptible(duration);
 	retval = tty->ops->break_ctl(tty, 0);
 out:
 	tty_write_unlock(tty);
-- 
2.42.0

