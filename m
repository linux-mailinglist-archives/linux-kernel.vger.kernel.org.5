Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E987F9FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjK0MhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjK0MhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:37:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB48182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:37:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1141FC433C9;
        Mon, 27 Nov 2023 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701088636;
        bh=mjtY/xAfKON0Sp8E15Yo20j/7gC9ke0H9DYO5Gi6kng=;
        h=From:To:Cc:Subject:Date:From;
        b=flvhiYUVDrOcHMdF6FadIoQqk17m6TgN0YPF81bj0/kz2dvflay3khtQ+4X4QFiS2
         1apEOkDMKFP/5DLIS2ZvqDfCoYZ8A2tPG8ATPw2qHKWPfY0+iK7hoTb+P80enOQl7f
         +0vcseQ8nbRgeF6/KzBjZca6Y5ahKnwDZXbRXaw2L+oEYDjGsa+aidpGYcZXk2X9FV
         tt2kxJfBGM60aCxAJ8laEYDNNFlcvHlZaXQEL/dKWG9j+ey5gxZOgz1OdBEOCcSwJ/
         P9rlcTox09DDRXE5S8srjmkLVLtPY03NIOqT1cRixXS7+L34EXWhlXefNsbVlxBnhF
         sVkNu3UTZT98Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/5] tty: make tty const in tty_get_baud_rate()
Date:   Mon, 27 Nov 2023 13:37:09 +0100
Message-ID: <20231127123713.14504-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 87888fb9ac0c ("tty: Remove baudrate dead code & make
ktermios params const"), the 'tty' parameter is only read in
tty_get_baud_rate(). Therefore, we can make 'tty' accepted in the
function 'const' for clarity.

The "the terminal bit flags may be updated." part of the
tty_get_baud_rate()'s kernel-doc is dropped as it is no longer true.
Because of the same commit above. And it was misplaced anyway.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/tty.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7625fc98fef3..e96c85f4f91e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -440,10 +440,9 @@ void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
  *
  * Returns: the baud rate as an integer for this terminal
  *
- * Locking: The termios lock must be held by the caller and the terminal bit
- * flags may be updated.
+ * Locking: The termios lock must be held by the caller.
  */
-static inline speed_t tty_get_baud_rate(struct tty_struct *tty)
+static inline speed_t tty_get_baud_rate(const struct tty_struct *tty)
 {
 	return tty_termios_baud_rate(&tty->termios);
 }
-- 
2.42.1

