Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92A7F28D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjKUJY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjKUJXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE11723
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4831DC433AD;
        Tue, 21 Nov 2023 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558614;
        bh=jNbLNG352qLl5DsDvu9XIk5DhjEuWNeT8bITasbQfSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTApM2Yz3k5LHdAR4SR/rf/9Gl3mNc2Hvoyj2G8mZC5bTs6jO4B3AkehK6TERw/jE
         dDjyGKGTipA9BQhnJhEIGUb0+kIsTZIqdO4/YRRp7wqpBIBDT5nWmRyR06iLZtUSKj
         PDOnO6UOlVtXDmLVy3viFS3QM/97XIKizEL4wNWTLXpSBHU210Fpd8OAWEevVUsKLa
         xNthtXLGxffbib6PvfmVJ7prxCG1fHdQum+Nr6EtOd8/OGKIQK7sNrbXQFbHPG8xMx
         jwpECnt8xBCUm7KzirZOLUZKz9cVMN3Nr74msXOp1g5ULl3Ld8u5Vwn+QpaT1wLqc6
         OHWaHpuGEE9Xg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 16/17] tty: srmcons: switch need_cr to bool
Date:   Tue, 21 Nov 2023 10:22:57 +0100
Message-ID: <20231121092258.9334-17-jirislaby@kernel.org>
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

'need_cr' is a flag, so type it properly to be a 'bool'. Move the
declaration into the loop too. That ensures the variable is initialized
properly even if the code was moved somehow.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---
 arch/alpha/kernel/srmcons.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 32bc098de7da..c6b821afbfd3 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -94,17 +94,16 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 	static char str_cr[1] = "\r";
 	size_t c;
 	srmcons_result result;
-	int need_cr;
 
 	while (count > 0) {
-		need_cr = 0;
+		bool need_cr = false;
 		/* 
 		 * Break it up into reasonable size chunks to allow a chance
 		 * for input to get in
 		 */
 		for (c = 0; c < min_t(size_t, 128U, count) && !need_cr; c++)
 			if (buf[c] == '\n')
-				need_cr = 1;
+				need_cr = true;
 		
 		while (c > 0) {
 			result.as_long = callback_puts(0, buf, c);
@@ -122,7 +121,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		while (need_cr) {
 			result.as_long = callback_puts(0, str_cr, 1);
 			if (result.bits.c > 0)
-				need_cr = 0;
+				need_cr = false;
 		}
 	}
 }
-- 
2.42.1

