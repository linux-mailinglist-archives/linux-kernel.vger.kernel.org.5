Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0E80F9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377572AbjLLVqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377559AbjLLVqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6BDB0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:46:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AEDC433C9;
        Tue, 12 Dec 2023 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417582;
        bh=uKOZ4tqE+zOqk+xylv9VfF6p9YlzZn6ohPRKk8Y2X50=;
        h=From:To:Cc:Subject:Date:From;
        b=JGxQ0xXv10OO7D5bOuEt6d/1gKRvFb7jeN2cajBxU+GNhXY7Ik3e+2WqrBLzlg430
         D9pNgRhJEweZ+LRIVWO5JoXhFSOGLj7ERi8MUrW9YTUP2wGvclr+9UZzZcHzk+YUa+
         /h+p4GhYCYko0P/oV8aM3DloACuaBM1yOvjO6l/CjcVp//Mgn90m0jFTPRxhmp4GOu
         1KDmB9KOiQOihznxc4uNB/ug8cy/SSnzTmhtcmafjZZL7JEmE5xxponkaqaFgIbJTh
         TGf9qACj9UB/RluCdNyeyBr8RSpx7BU1jA5kpekyKW7737ONE07ZTIOtLaorGUFPKD
         TAncofhG+FFSQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: ep93xx: fix error handling during probe
Date:   Tue, 12 Dec 2023 22:46:07 +0100
Message-Id: <20231212214616.193098-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

When the interrupt property fails to be parsed, ep93xx_timer_of_init()
return code ends up uninitialized:

drivers/clocksource/timer-ep93xx.c:160:6: error: variable 'ret' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
        if (irq < 0) {
            ^~~~~~~
drivers/clocksource/timer-ep93xx.c:188:9: note: uninitialized use occurs here
        return ret;
               ^~~
drivers/clocksource/timer-ep93xx.c:160:2: note: remove the 'if' if its condition is always false
        if (irq < 0) {
        ^~~~~~~~~~~~~~

Simplify this portion to use the normal construct of just checking
whether a valid interrupt was returned. Note that irq_of_parse_and_map()
never returns a negative value and no other callers check for that either.

Fixes: c28ca80ba3b5 ("clocksource: ep93xx: Add driver for Cirrus Logic EP93xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/timer-ep93xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
index bc0ca6e12334..6981ff3ac8a9 100644
--- a/drivers/clocksource/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -155,9 +155,8 @@ static int __init ep93xx_timer_of_init(struct device_node *np)
 	ep93xx_tcu = tcu;
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == 0)
-		irq = -EINVAL;
-	if (irq < 0) {
+	if (!irq) {
+		ret = -EINVAL;
 		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
 		goto out_free;
 	}
-- 
2.39.2

