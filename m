Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562E7F28D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjKUJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjKUJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA031701
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B03C433A9;
        Tue, 21 Nov 2023 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558609;
        bh=yT8k5oROMwqMcM21ujTXVO6pmxLHQflyqFgQxsTik/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cz76iEMEWa2wZDM8a7P/JAxgC86aIOrdBrehYNup2d1+hTJGyIr97bk405j66mQNf
         Lc82FOLTgK3QmTisWpcx/FtuOrg+i38nQWH12pXlEveToSPpAZCc6hg2UZSPe6CeCc
         K+FRLykFfguYlWGgQ+hphLflfXsuYa1MQkckcOufp8t13ITwe+0ePlCH6fBcOkm5xJ
         2ADFc9i2KtcVu2P740mGhe/XGTV6O3IAKVH3LODupbyNsXL835Vbjo1bcUD+eErE4V
         p8KnOjwTZdcjrZrgbuV7BZvxKs+1czEcHwsvsQMzFtE1KjNhsAwZy8HsejS4TfeX/N
         1CXNNHV3YMy3A==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 14/17] tty: srmcons: use 'count' directly in srmcons_do_write()
Date:   Tue, 21 Nov 2023 10:22:55 +0100
Message-ID: <20231121092258.9334-15-jirislaby@kernel.org>
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

Similarly to 'buf' in the previous patch, there is no need to have a
separate counter ('remaining') in srmcons_do_write(). 'count' can be
used directly which simplifies the code a bit.

Note that the type of the current count ('c') is changed from 'long' to
'size_t' so that:
1) it is prepared for the upcoming change of 'count's type, and
2) is unsigned.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index b68c5af083cd..8025e2a882ed 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -92,24 +92,24 @@ static int
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
 	static char str_cr[1] = "\r";
-	long c, remaining = count;
+	size_t c;
 	srmcons_result result;
 	int need_cr;
 
-	while (remaining > 0) {
+	while (count > 0) {
 		need_cr = 0;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
-		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
+		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
 				need_cr = 1;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
 			c -= result.bits.c;
-			remaining -= result.bits.c;
+			count -= result.bits.c;
 			buf += result.bits.c;
 
 			/*
-- 
2.42.1

