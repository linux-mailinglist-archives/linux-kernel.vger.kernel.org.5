Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F618777409
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjHJJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjHJJP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768C52700;
        Thu, 10 Aug 2023 02:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D20612F0;
        Thu, 10 Aug 2023 09:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C2BC433C8;
        Thu, 10 Aug 2023 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658926;
        bh=zHa3PXKIEH54GgY+R1eXwduesS3j83ceqDEy55gq1po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4JDTjbZIY8YtcSnD9vNlkljLsDKWJ5A6kwyvYl92XcbxQvPUpsYwXdA/KhnGvU31
         V9guFzglx2loNINCMRk9Yso+4v1OUUZ6mD8l6p8vn2C3jaeIlhu8GSTUN/4O/Fp4sB
         9KNmlXfCszfwp7v/h1du1xYEBC9L45Pe5XcZqHjD+JRaGjQdjvMbmN8DdDzhTLCVlL
         VYM94cYNf2nJLaMW7iHT2c7TrYl3NkJX0iNiXwFRo684B7RhcmX1KGLr+k5P+7jxe+
         j5ywTTBeuUwR3KXAw4MHYss+JX8gXWyoLIReYR3o1Bppa88jr2kfu4e3KmxLhR/nKH
         uZr3ElcZlvJ5w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 07/36] tty: drop tty_debug_wait_until_sent()
Date:   Thu, 10 Aug 2023 11:14:41 +0200
Message-ID: <20230810091510.13006-8-jirislaby@kernel.org>
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

It's a nop for everyone as TTY_DEBUG_WAIT_UNTIL_SENT is never set.
Provided, we have better debugging/printout mechanisms nowadays, remove
this mechanism.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_ioctl.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index e3e1318f53fd..f63e8b1b9e40 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -28,14 +28,6 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#undef TTY_DEBUG_WAIT_UNTIL_SENT
-
-#ifdef TTY_DEBUG_WAIT_UNTIL_SENT
-# define tty_debug_wait_until_sent(tty, f, args...)    tty_debug(tty, f, ##args)
-#else
-# define tty_debug_wait_until_sent(tty, f, args...)    do {} while (0)
-#endif
-
 #undef	DEBUG
 
 /*
@@ -198,8 +190,6 @@ int tty_unthrottle_safe(struct tty_struct *tty)
 
 void tty_wait_until_sent(struct tty_struct *tty, long timeout)
 {
-	tty_debug_wait_until_sent(tty, "wait until sent, timeout=%ld\n", timeout);
-
 	if (!timeout)
 		timeout = MAX_SCHEDULE_TIMEOUT;
 
-- 
2.41.0

