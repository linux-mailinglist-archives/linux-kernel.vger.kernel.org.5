Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588197F28D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjKUJYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjKUJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96FB10E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841C4C433AB;
        Tue, 21 Nov 2023 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558607;
        bh=A+gwjfR1YZFEn//O7QquhnOOdPgWP51q1cNT1xEbGz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCcVQCueYuWyDY4P/DEB7ksJqQttXRDIPuOZ7d1S9t+TY1NrMTLU+chfM1S6vlv+p
         WBd57pcx7EOKaym2OQcNLU7UHsd+qb/aAAsDtIkFG6hIChg838AvK6hstPgL1gFiLN
         FiXQmY6zoCqEKQPuyPESrYNhXJ6NsQb1ojKzz50bJUjUKJxAXZW0fYqvLaFHkEjCBp
         LSTeR5/RUtifDRKwQmwM+896CIvlaUn8mg8TS0FPcDdLxOxd+K9Lo7jqqeytBxSkHY
         qaJn/aoW6NRZPIMKquDInl67DpFnQFfRKdSx15MeAGPSiwYZxY8lvB2AnsUOJ8XAyb
         +0Nmw/Pstmt6Q==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 13/17] tty: srmcons: use 'buf' directly in srmcons_do_write()
Date:   Tue, 21 Nov 2023 10:22:54 +0100
Message-ID: <20231121092258.9334-14-jirislaby@kernel.org>
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

There is no need to have a separate iterator ('cur') through 'buf' in
srmcons_do_write(). 'buf' can be used directly which simplifies the code
a bit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index d6139dbae4ac..b68c5af083cd 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -94,24 +94,23 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 	static char str_cr[1] = "\r";
 	long c, remaining = count;
 	srmcons_result result;
-	char *cur;
 	int need_cr;
 
-	for (cur = (char *)buf; remaining > 0; ) {
+	while (remaining > 0) {
 		need_cr = 0;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
 		for (c = 0; c < min_t(long, 128L, remaining) && !need_cr; c++)
-			if (cur[c] == '\n')
+			if (buf[c] == '\n')
 				need_cr = 1;
 		
 		while (c > 0) {
-			result.as_long = callback_puts(0, cur, c);
+			result.as_long = callback_puts(0, buf, c);
 			c -= result.bits.c;
 			remaining -= result.bits.c;
-			cur += result.bits.c;
+			buf += result.bits.c;
 
 			/*
 			 * Check for pending input iff a tty port was provided
-- 
2.42.1

