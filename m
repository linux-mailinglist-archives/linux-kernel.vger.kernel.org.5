Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55275DE83
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGVU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:26:58 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA778E58
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:26:54 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NJBjqtestHI6nNJBjqoPCR; Sat, 22 Jul 2023 22:26:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690057613;
        bh=/NfZHk2r0r5O3/cXEnU1+UoN/5FO53TePxKwYDuLCpA=;
        h=From:To:Cc:Subject:Date;
        b=PKe1cTqqVlcZfB/XOHKLcypj0NEfxBin5w2lxtP0qdd4RRKgRGSxn/m4HCEafiOkV
         TUI6F7smKn+oyoepr6K6HVUqdlW/NEgK/AaehZR2ODes5kzkTSUhYlIoflc1pjEQu/
         mhqu55prWGfKSkBv/caL88GXasi9SxAQPXloIq7RDUPgXv7dNIPzV8NpbtCjN/GJLW
         lDa+uVb+19stEJXPiOl0oV9PVu2ce6MDSG0dkKTGVAfMAHIFG/enr10b3QvpoCMAwC
         VyxXO398snf6NIaQhN+OLXknMzgVjSKnFmQQ1BWxV5QiMYMRB6heVSh/fxxL6vHJPz
         tlt5G/3UEFAQg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 22 Jul 2023 22:26:53 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org
Subject: [PATCH] leds: ns2: Slightly simplify a memory allocation
Date:   Sat, 22 Jul 2023 22:26:49 +0200
Message-Id: <560b8f140c19a7da40f5e9540c3ef312969b0dc4.1690057595.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kcalloc() instead of devm_kzalloc()+array_size().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/leds/leds-ns2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 1677d66d8b0e..f3010c472bbd 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -247,7 +247,7 @@ static int ns2_led_probe(struct platform_device *pdev)
 	if (!count)
 		return -ENODEV;
 
-	leds = devm_kzalloc(dev, array_size(sizeof(*leds), count), GFP_KERNEL);
+	leds = devm_kcalloc(dev, count, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
 		return -ENOMEM;
 
-- 
2.34.1

