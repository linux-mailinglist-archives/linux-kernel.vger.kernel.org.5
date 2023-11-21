Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B347F28CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbjKUJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjKUJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D412C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18901C433CA;
        Tue, 21 Nov 2023 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558599;
        bh=9PpdhyBVsu45ZCI81VGErhQfiGGxB/f1DEh5vaZ3fm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdBxAV7TZbxSuBj60zoJAneC4IgZRVvo2sHh/6D4pz5ADsXfKZA5QMskKPFDr2B21
         oCKJ9/YwuqeOpqa83og/tUyjhUgQ9RgHZr3yuB7eG9hMig0QjfE0URzhU8WtjVkiVe
         KZHyJz/eH3hNcqfJSyBj9Y8XnN6uvO1RpyhN9Eg4kRSbhA/pmUM4/sGe7KRGmtbogo
         PmVVy5nHHmDbXaJgmjishZYFwYdirQmhuX1FArM1mQeLSOLt11wJV9VYxUlluFLwOk
         JIZ+KunqutGepha4LK3HN10iz7yCPOb6IJqMDNheXVqW9IHM7Ei4CfHFetByJn0AOW
         c1eoOhGTjT2gQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 09/17] tty: hso: don't emit load/unload info to the log
Date:   Tue, 21 Nov 2023 10:22:50 +0100
Message-ID: <20231121092258.9334-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
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

It's preferred NOT to emit anything during the module load and unload
(in case the un/load was successful). So drop these prints from hso
along with global 'version'. It even contains no version after all.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/net/usb/hso.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index 83b8452220ec..48450fe861ad 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -363,7 +363,6 @@ static int disable_net;
 /* driver info */
 static const char driver_name[] = "hso";
 static const char tty_filename[] = "ttyHS";
-static const char *version = __FILE__ ": " MOD_AUTHOR;
 /* the usb driver itself (registered in hso_init) */
 static struct usb_driver hso_driver;
 /* serial structures */
@@ -3231,9 +3230,6 @@ static int __init hso_init(void)
 	int i;
 	int result;
 
-	/* put it in the log */
-	pr_info("%s\n", version);
-
 	/* Initialise the serial table semaphore and table */
 	for (i = 0; i < HSO_SERIAL_TTY_MINORS; i++)
 		serial_table[i] = NULL;
@@ -3285,8 +3281,6 @@ static int __init hso_init(void)
 
 static void __exit hso_exit(void)
 {
-	pr_info("unloaded\n");
-
 	tty_unregister_driver(tty_drv);
 	/* deregister the usb driver */
 	usb_deregister(&hso_driver);
-- 
2.42.1

