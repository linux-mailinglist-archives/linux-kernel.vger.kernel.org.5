Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8B8068A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376783AbjLFHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjLFHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0D10C7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C2C433D9;
        Wed,  6 Dec 2023 07:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848252;
        bh=1JMsbibgL+koo57Qg90X/yljRQK0lCI9j2/54D8BLQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F9lyJr8gR2xeB12ZCu6+xxyLMvX+7v9xLxohJzx8unyb4QSgkyZ1v9cWggNjMYQmi
         MVUoc+TiWLlvN5oonNBGV3GwvFR8PQwdBq0rF17Sx28cA6pNod2GfHsBmNqWANmRsd
         d+YvHDv128K3cNACr7QtrDJJCBDrkU+LqW0PX/J+XSWIXkfIVvN4ILlB/j/Bzhk3VN
         CkHL6OI97iBsiNOMR6j3bOivNyBgLZSzz6vzVB5C935C5xjvMdDhwqtn42bJ+m+yDW
         CPOF4oZPxi2/3cdyhHy+3IXSNn1rhVh1uqskK2oluKbvDFmaSWGV8A9yfTvaZjCjzw
         /6m6SlV2YS9ag==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/27] tty: ami: use u8 for characters and flag
Date:   Wed,  6 Dec 2023 08:36:51 +0100
Message-ID: <20231206073712.17776-7-jirislaby@kernel.org>
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

Switch character types to u8. To conform to characters in the rest of
the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/amiserial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index a30dc054ffbf..7716ce0d35bc 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -81,7 +81,7 @@ struct serial_state {
 	int			quot;
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
-	int			x_char;	/* xon/xoff character */
+	u8			x_char;	/* xon/xoff character */
 };
 
 static struct tty_driver *serial_driver;
@@ -178,7 +178,7 @@ static void receive_chars(struct serial_state *info)
 {
         int status;
 	int serdatr;
-	unsigned char ch, flag;
+	u8 ch, flag;
 	struct	async_icount *icount;
 	bool overrun = false;
 
-- 
2.43.0

