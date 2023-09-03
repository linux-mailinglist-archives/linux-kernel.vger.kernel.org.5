Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B4790B03
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 08:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjICGN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 02:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbjICGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 02:13:28 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48DD1B8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 23:13:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id cgMMqubDxIQx7cgMMqJ4sJ; Sun, 03 Sep 2023 08:13:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693721603;
        bh=Ah00WuGELkeIZdCrdZYVintNpevWzDVLlBUMTDJqm00=;
        h=From:To:Cc:Subject:Date;
        b=UQ+24zXdZjFIgmQh9kSHqzBbDISooD8Q1GyC3q15aAsy+Vmyr9vUZ2g20l6SdWdD/
         vyqeQfp5WA5Zdq6EQ2ENVQ2fSZR1buRhi8Vu00iLaYhbcXcP+9F7iuqwd7izV6TRrz
         yc+b+48EMD00XbtCtsqA4T1PiKVi5JxUXOG79b6qeqVCXn/poJvdJT3U0j/FWcX+4s
         B01e9E9Ckw7m0g5Z+c7tjm6Fah86REgmjATlkN9Q5cqSBDyT93KDE9yr+0wxkW+A3p
         g2/LrIVHN5ECGt+JeXp/p9PsfjQb7zFAL5gUcuQQGE87G0zrWHOa+S0HTHLSh/WpNq
         wKODpgU9YNj4A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 08:13:23 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        galak@codeaurora.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
Date:   Sun,  3 Sep 2023 08:13:21 +0200
Message-Id: <ceeda269bceee1c805f148bcbc628abc9d42601a.1693721348.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful irq_domain_add_linear() call, it
should be undone by a corresponding irq_domain_remove(), as already done
in the remove function.

Fixes: c6ce2b6bffe5 ("gpio: add TB10x GPIO driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpio/gpio-tb10x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 78f8790168ae..f96d260a4a19 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -195,7 +195,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -209,6 +209,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
-- 
2.34.1

