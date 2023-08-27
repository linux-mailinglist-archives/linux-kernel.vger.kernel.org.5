Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045AC789BCD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjH0HmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjH0Hl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3556CFA;
        Sun, 27 Aug 2023 00:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5ADC61CA0;
        Sun, 27 Aug 2023 07:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30227C433C9;
        Sun, 27 Aug 2023 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122115;
        bh=7uzVRu3zjsOugrgpYZpRz5z59LsS9NkcVLqU8KlS9Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rv6fZ1DiKr59uZ49wDv1cv5G9pLCeIBwbRp9XGxEahOUsPXS+peCt+48NwMXPw761
         Fwdi1HUOQ7mCf4KpaOLwt/HA4UjCkYMtwSOzzEsWJylLHeJwI1nVTU6BZrkq9GAX3n
         DHuJ+EaeMPArfK5vhAWosTCvp7g+u553qfYgKg6atOo0pL1g7y1CkyOB7BLB8pr6jr
         X4MTBS9f0WL9sqctIqlJdC0NfdLJmbYLF7En6ZFVR/mhsO3YKDQIjH2qEsNiknauRF
         73ONOfGmxhYh4xogYOMyxwBl12UmbMl1/jSPkOjnyuoxZT9h22Mo3B9LRT3tHJepeX
         ZsxsL2m0RkF4A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 03/14] tty: n_tty: use 'num' for writes' counts
Date:   Sun, 27 Aug 2023 09:41:36 +0200
Message-ID: <20230827074147.2287-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a separate misnomer 'c' to hold the retuned value from
tty->ops->write(). Instead, use 'num' already defined on another place
(and already properly typed).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v2] use 'name' instead of 'retval' as Ilpo suggests

 drivers/tty/n_tty.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f6fa4dbdf78f..7f9fee4cf7cf 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2335,8 +2335,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 {
 	const u8 *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int c;
-	ssize_t retval = 0;
+	ssize_t num, retval = 0;
 
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
 	if (L_TOSTOP(tty) && file->f_op->write_iter != redirected_tty_write) {
@@ -2362,7 +2361,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		if (O_OPOST(tty)) {
 			while (nr > 0) {
-				ssize_t num = process_output_block(tty, b, nr);
+				num = process_output_block(tty, b, nr);
 				if (num < 0) {
 					if (num == -EAGAIN)
 						break;
@@ -2384,16 +2383,16 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 
 			while (nr > 0) {
 				mutex_lock(&ldata->output_lock);
-				c = tty->ops->write(tty, b, nr);
+				num = tty->ops->write(tty, b, nr);
 				mutex_unlock(&ldata->output_lock);
-				if (c < 0) {
-					retval = c;
+				if (num < 0) {
+					retval = num;
 					goto break_out;
 				}
-				if (!c)
+				if (!num)
 					break;
-				b += c;
-				nr -= c;
+				b += num;
+				nr -= num;
 			}
 		}
 		if (!nr)
-- 
2.42.0

