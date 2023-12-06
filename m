Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9B8068C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjLFHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377045AbjLFHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:39:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B7171B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:38:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65774C433CC;
        Wed,  6 Dec 2023 07:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848288;
        bh=3eus7b0hNQLg9OdX0asU6mkvYB2JyWIitlAf+oIxR5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfFcnbkmDiij/dWO7x1l2NreAxAGYK8c7pNds67o8kla1HnMw7WBsFVng3mNKy9fr
         8TcwF688b3caLdyzVQ1NUcVlMicbFb8Jeyhp7m5jQD2OWWvcPna8bjA/mMj1QH8v7j
         Ofbd/oT2evbpvLP6xVFS4TrVrKoew3ZuMjUL3Y6XsMRQi+kp1HgyM0Ddj8magOdams
         ETYTKjlOdvTIjuVzC9WGjN+E58T/m2facWY7CRD/eMzKNJt0vuFspTcyhr+E7lfPJI
         Eaq2dzWVUZbt+6U7Fk0777+StnzGCSEfihjlqEEGMZ64TiHnOzljPwlZJ9CQYhh/KA
         v5UqLRHUmgYcw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/27] tty: ttyprintk: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:37:10 +0100
Message-ID: <20231206073712.17776-26-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
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

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ttyprintk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 5af804c17a75..4c806a189ee5 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -40,7 +40,7 @@ static struct ttyprintk_port tpk_port;
 
 static int tpk_curr;
 
-static char tpk_buffer[TPK_STR_SIZE + 4];
+static u8 tpk_buffer[TPK_STR_SIZE + 4];
 
 static void tpk_flush(void)
 {
@@ -51,9 +51,9 @@ static void tpk_flush(void)
 	}
 }
 
-static int tpk_printk(const u8 *buf, int count)
+static int tpk_printk(const u8 *buf, size_t count)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < count; i++) {
 		if (tpk_curr >= TPK_STR_SIZE) {
-- 
2.43.0

