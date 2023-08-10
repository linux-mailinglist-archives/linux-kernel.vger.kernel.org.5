Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DA277742F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjHJJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbjHJJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDA4217;
        Thu, 10 Aug 2023 02:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE469654E4;
        Thu, 10 Aug 2023 09:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198C2C433C8;
        Thu, 10 Aug 2023 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658971;
        bh=QDlkbg/XjjV1JQTv+v4tOKhuklg84nOntdoPJSBb49U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtaPOKlNdeBah/3fSrLlWGSJHX809u1IYyauk7w0NKl+RR6Y+eWlLUiP74nA5Ab0u
         5badqARukKrbjW7jeJ8ljnnk81EHFpC0jIsJKjzLe2HPklHxnq6S26qVosNA80av6j
         +0bO2DVIg6l/qMslJU8+gaC5Fe7L5+HyE0DWn/cAmw40AL1WmM3pBqnxRCNDp5QsRp
         wh8Mb9dcdXTcAm0LAT17KzEaL/7DVA3Gj5JH7cFa/dzdafyTl+a8zfzuVziKPQzZlv
         V3sL6x+yo0s2knFyAkOSxYPRBxQuWtRzI4TRn7nB4/gLtV33UVV5aQhhle54WUYLBw
         irLYFtPIN+tng==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 25/36] tty: switch size and count types in iterate_tty_read() to size_t
Date:   Thu, 10 Aug 2023 11:14:59 +0200
Message-ID: <20230810091510.13006-26-jirislaby@kernel.org>
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

ld->ops->read() returns ssize_t. copy_to_iter() returns size_t. So
switch the variables ('size' and 'copied', respectively) to the
corresponding types.

This allows for use of min() in the next patch.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e8248773e3f0..7cfa99fbbb62 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -850,10 +850,10 @@ static ssize_t iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 	unsigned long offset = 0;
 	char kernel_buf[64];
 	ssize_t retval = 0;
-	size_t count = iov_iter_count(to);
+	size_t copied, count = iov_iter_count(to);
 
 	do {
-		int size, copied;
+		ssize_t size;
 
 		size = count > sizeof(kernel_buf) ? sizeof(kernel_buf) : count;
 		size = ld->ops->read(tty, file, kernel_buf, size, &cookie, offset);
-- 
2.41.0

