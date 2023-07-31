Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5FD768F92
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGaIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGaIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABD2696;
        Mon, 31 Jul 2023 01:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 312DC60F70;
        Mon, 31 Jul 2023 08:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63489C433C7;
        Mon, 31 Jul 2023 08:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690790572;
        bh=CFCUO1q2jsK74UC2bwVz7miuEtn6Vz1wrsnbjpoYBoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zxkxs5HlsQ22+uk6HxRfSnXVnkXQrgnRL0xYAU9zOhLxxVwnTltHXn3xkW5TIMaVA
         s2/ZkpjZZrsy8Yg47g2Yf6J1CiFdQWjIc8LClZCxbWSWsIx4BJBwYCTFv++rMjad0T
         bHa+WlPcEaoyuTPupPQn+KQzuiUUJlUe85LatZEg8/M7dVgtlx5YSXL2fBjUXkCtGR
         EeZxkxnt3IiL1s2w3nP4JNwjGIP/y34/uWg1PvxyRzGHy6wyoIRPcvYu2IFVYnJvdK
         Mm7KNXDq6EX4oP1juDpt5FVQYe8qiOOzMV4TeS1zxXzR4gLmFiHzfb0/A9xEBtChFX
         qmetPBluQldWA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/10] tty: hvsi: remove an extra variable from hvsi_write()
Date:   Mon, 31 Jul 2023 10:02:37 +0200
Message-ID: <20230731080244.2698-4-jirislaby@kernel.org>
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

'source' is the same as 'buf'. Rename the parameter ('buf') to
'source' and drop the local variable.

Likely, the two were introduced to have a different type. But 'char' and
'unsigned char' are the same in the kernel for a long time.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index a200d01eceed..c1b8a4fd8b1e 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -905,10 +905,9 @@ static unsigned int hvsi_chars_in_buffer(struct tty_struct *tty)
 }
 
 static int hvsi_write(struct tty_struct *tty,
-		     const unsigned char *buf, int count)
+		     const unsigned char *source, int count)
 {
 	struct hvsi_struct *hp = tty->driver_data;
-	const char *source = buf;
 	unsigned long flags;
 	int total = 0;
 	int origcount = count;
-- 
2.41.0

