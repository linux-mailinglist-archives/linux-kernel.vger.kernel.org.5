Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84C877DFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbjHPLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244410AbjHPLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9CA2D70;
        Wed, 16 Aug 2023 04:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 061A3665EE;
        Wed, 16 Aug 2023 10:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDF2C433C7;
        Wed, 16 Aug 2023 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183525;
        bh=0qQF4RO9wzHWQ+t9jAmzN2X8pLXu/bil8u2foxNEB5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHFk/vlcR+hy2TfJwNTfa0zchK3sa0tswlYaI2UjAoCKSttFfxkS9auLVdKqrgn8x
         cU/xced03uDAbgHFTqFroPKyuODJhGFTi8VYF9Ji4pGm1K/AE4GmFnVC0IZBk9n8ms
         gh6bUt4eG7loUSZ948+rc6Y+PAaa47BreW/D+85V0tBAyelOAgtk4aqw4RYHlO4cIR
         feanH4TcpnQTDFnqqlMjCvFl5DEfpSsZancXFw0jKJOOHA0SJbEGLKqG5/JABfc2B0
         0lpDD99AqZw6f4tR8UKSw1WKAWkYb2BNe2ozRJXLt4gXpXaMPlkowdE4EME7OqCL+u
         BE+HHBe6QPEjQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/14] tty: n_tty: remove unsigned char casts from character constants
Date:   Wed, 16 Aug 2023 12:58:17 +0200
Message-ID: <20230816105822.3685-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
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

We compile with -funsigned-char, so all character constants are already
unsigned chars. Therefore, remove superfluous casts.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ab3e7c20fbef..875a2bbb51c3 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1347,7 +1347,7 @@ static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 		 * XXX does PARMRK doubling happen for
 		 * EOL_CHAR and EOL2_CHAR?
 		 */
-		if (c == (unsigned char) '\377' && I_PARMRK(tty))
+		if (c == '\377' && I_PARMRK(tty))
 			put_tty_queue(c, ldata);
 
 		n_tty_receive_handle_newline(tty, c);
@@ -1409,7 +1409,7 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
 	}
 
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 
 	put_tty_queue(c, ldata);
@@ -1444,7 +1444,7 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		commit_echoes(tty);
 	}
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
-- 
2.41.0

