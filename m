Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FD7FED5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345131AbjK3KzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345051AbjK3KzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:55:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB8910DB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:55:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83373C433C8;
        Thu, 30 Nov 2023 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341717;
        bh=I6SFA46IuAEaiFe3yLVvcqPKp8gUZZ0H2L9FiYb6dRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODfZqyvsllTcjm4eCiviYTFS9NmmCY4xpKqBkTrGWQ11pzC3k/u7EJKu7gnow+HLD
         W85Lbo+2NpiarQYU15HIEFe4/VpooV82LNHT4T9ODoCqfOttbCST6L/OSP16CMi47P
         D+sk//y9F+L+Inr5RB/ovdaJyIlJfU5yN6DUOz88/QUD3IIxNIhG/5yX88mlmgIjOg
         I2myg9l9zz2tuaunyntzJ4TYi8zqlQxUW13hi8gVKk1P49u90TmebAhmgDvRiKKX4l
         +1tDauDAmREIua845WZ7QZYEAtWrm39g+qxKLVH9XDYZyfhYX7641iMDAl8yFp4ky6
         bMvVtb+cWhNlA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yuan-Hsin Chen <yhchen@faraday-tech.com>,
        Feng-Hsin Chiang <john453@faraday-tech.com>,
        Po-Yu Chuang <ratbert.chuang@gmail.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/5] usb: fotg210-hcd: Replace snprintf() with the safer scnprintf() variant
Date:   Thu, 30 Nov 2023 10:54:37 +0000
Message-ID: <20231130105459.3208986-4-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231130105459.3208986-1-lee@kernel.org>
References: <20231130105459.3208986-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

The uses in this file both seem to assume that data *has been* written!

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yuan-Hsin Chen <yhchen@faraday-tech.com>
Cc: Feng-Hsin Chiang <john453@faraday-tech.com>
Cc: Po-Yu Chuang <ratbert.chuang@gmail.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/fotg210/fotg210-hcd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
index 929106c16b29b..b2f8b53cc8ef5 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -404,9 +404,9 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 			else if (td->hw_alt_next != list_end)
 				mark = '/';
 		}
-		temp = snprintf(next, size,
-				"\n\t%p%c%s len=%d %08x urb %p",
-				td, mark, ({ char *tmp;
+		temp = scnprintf(next, size,
+				 "\n\t%p%c%s len=%d %08x urb %p",
+				 td, mark, ({ char *tmp;
 				switch ((scratch>>8)&0x03) {
 				case 0:
 					tmp = "out";
@@ -424,17 +424,13 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
 				(scratch >> 16) & 0x7fff,
 				scratch,
 				td->urb);
-		if (size < temp)
-			temp = size;
 		size -= temp;
 		next += temp;
 		if (temp == size)
 			goto done;
 	}
 
-	temp = snprintf(next, size, "\n");
-	if (size < temp)
-		temp = size;
+	temp = scnprintf(next, size, "\n");
 
 	size -= temp;
 	next += temp;
-- 
2.43.0.rc1.413.gea7ed67945-goog

