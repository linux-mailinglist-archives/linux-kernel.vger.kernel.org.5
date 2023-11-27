Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0DB7F9FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjK0Mhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjK0MhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:37:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810951AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:37:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66801C433CA;
        Mon, 27 Nov 2023 12:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701088645;
        bh=YEcN7xVfBtrK+FblMlBykMvweHvzn9kzb4wK1dvK3OA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfiiKcF7wg6jSD089smxUC6qcRrqWjYR9e97Uxy/bWCbylV6UdyFen/ls5Q0t33OB
         VEXTl9ShFBx2CFvV8VoRjmlN3TNC/O/5r1fufng6Bx07DQbqeuGR5u0K+CFWfsgeZD
         o6jQwXWxWB9bUcpxKGVQyAQ/TdkOJ7PKEQniLAlBZQC1EGDPAQwiALmdcNelwwhM9g
         c2oRKnN6jFwX7ctFqnqnT45gLXnyoTifbPJaV0gxafnlJnLXXmxMREZFhLQi9H/zAa
         r03By8tvaykNobPbwXuGiDzHN7rYY4EtVSUtx8tMIlKcv4plPWLbg/FuGLQzOsFLUp
         5nFj0HnYGqqSg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 5/5] tty: srmcons: remove 'str_cr' and use string directly
Date:   Mon, 27 Nov 2023 13:37:13 +0100
Message-ID: <20231127123713.14504-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231127123713.14504-1-jirislaby@kernel.org>
References: <20231127123713.14504-1-jirislaby@kernel.org>
MIME-Version: 1.0
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

'str_cr' contains a single character: \r. There is no need to declare it
as array. Instead, pass the character (as a string) to callback_puts()
directly. This ensures the string is in proper .rodata (const) section
and makes the code more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
---

Notes:
    [v2]
      pass "\r" directly to callback_puts() as Richard suggests
      spell correct \r in the commit log as Ilpo noticed

 arch/alpha/kernel/srmcons.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index c6b821afbfd3..42deea53beab 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -91,7 +91,6 @@ srmcons_receive_chars(struct timer_list *t)
 static void
 srmcons_do_write(struct tty_port *port, const char *buf, int count)
 {
-	static char str_cr[1] = "\r";
 	size_t c;
 	srmcons_result result;
 
@@ -119,7 +118,7 @@ srmcons_do_write(struct tty_port *port, const char *buf, int count)
 		}
 
 		while (need_cr) {
-			result.as_long = callback_puts(0, str_cr, 1);
+			result.as_long = callback_puts(0, "\r", 1);
 			if (result.bits.c > 0)
 				need_cr = false;
 		}
-- 
2.42.1

