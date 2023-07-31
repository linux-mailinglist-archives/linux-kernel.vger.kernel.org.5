Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5A768F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGaIG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjGaIEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329321726;
        Mon, 31 Jul 2023 01:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7E8D60F30;
        Mon, 31 Jul 2023 08:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D742FC433C7;
        Mon, 31 Jul 2023 08:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790585;
        bh=T3RQZEVjTUZC7k/WLvQaJ7ITDbA5hvLXPQp0OeU6JrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNwYGjhcyLi8C4NJpFWurdq5mW5ku7Ny666lC5umnleK884pj1POi11FdwHUEZGuD
         HUJa6+IIstHWyakiconglNzRx9ZcGO9fbyShhH6R3cnJIBWTWM0T6Ay70nFuC0mRK4
         K7exCSnkq9/P3FqcG80Kfk/05TqPFEi+ma29tggvBoI5lE9pgflhbue5b50Y9i0GPu
         sMgJcn7mCbJoxmLm55bzdJPABvG/0r8PGPtzZh5oafDauSgxbLfO4MeyKLaHd51nmg
         M1RhAyFZldrdqvlIm9qm+EAZ0jvU5aCzZUgQaJCpx3ev49E3I5UGQ8awZZGkXeyaTa
         BYnLqoovmVzzg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/10] misc: ti-st: remove ptr from recv functions
Date:   Mon, 31 Jul 2023 10:02:43 +0200
Message-ID: <20230731080244.2698-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080244.2698-1-jirislaby@kernel.org>
References: <20230731080244.2698-1-jirislaby@kernel.org>
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

ptr is the same as data, so use ptr directly as a parameter and drop the
useless local variable.

Likely, the two were introduced to have a different type. But 'char' and
'unsigned char' are the same in the kernel for a long time.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 4 +---
 drivers/misc/ti-st/st_kim.c  | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 389901276ce3..e2add50b191c 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -224,9 +224,8 @@ static inline void st_wakeup_ack(struct st_data_s *st_gdata,
  *	CH-8 packets from FM, CH-9 packets from GPS cores.
  */
 static void st_int_recv(void *disc_data,
-	const unsigned char *data, long count)
+	const unsigned char *ptr, long count)
 {
-	char *ptr;
 	struct st_proto_s *proto;
 	unsigned short payload_len = 0;
 	int len = 0;
@@ -235,7 +234,6 @@ static void st_int_recv(void *disc_data,
 	struct st_data_s *st_gdata = (struct st_data_s *)disc_data;
 	unsigned long flags;
 
-	ptr = (char *)data;
 	/* tty_receive sent null ? */
 	if (unlikely(ptr == NULL) || (st_gdata == NULL)) {
 		pr_err(" received null from TTY ");
diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index f2f6cab97c08..8c801897ffa2 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -128,15 +128,13 @@ static inline int kim_check_data_len(struct kim_data_s *kim_gdata, int len)
  *	tty_receive and hence the logic
  */
 static void kim_int_recv(struct kim_data_s *kim_gdata,
-	const unsigned char *data, long count)
+	const unsigned char *ptr, long count)
 {
-	const unsigned char *ptr;
 	int len = 0;
 	unsigned char *plen;
 
 	pr_debug("%s", __func__);
 	/* Decode received bytes here */
-	ptr = data;
 	if (unlikely(ptr == NULL)) {
 		pr_err(" received null from TTY ");
 		return;
-- 
2.41.0

