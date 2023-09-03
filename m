Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36F4790B70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjICKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjICKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 06:11:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DAF10C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 03:11:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ck4Sq0Dlhv5KTck4SqU8l5; Sun, 03 Sep 2023 12:11:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693735876;
        bh=pYSxdLERm6FegRN8OPQImJFFHzRLF2IYwebwjAKvv44=;
        h=From:To:Cc:Subject:Date;
        b=lU56k2SraqBFtjnPVVg8n3TRO2AETyZ8PZ4ZsOtXQ9jlEQ7NzBjETYeyloHBTlseE
         Kw1Q1aUFASROqv/CNJxZY4qi8A5BWp+GNcxWhqrNJXqLZASE1EfBe/7QSYUvaFVsz/
         jpAsIzyUJyCjmHrTJPjkqKgtG6F/F2TylX+QybouB+H9eAn0aiP6PbzqcpLE7SFDB+
         AgbHF0w9TmvoL3oEioO3Kaks6KPCK3Pjd/OEcmG82JMhxHo4zn1W5Qb2muC6FXOVQ9
         3w/FZx2yotk3MON9BzBkmLucNWX2oO/+aqs0XoIDWv2mKix7Qcca2ATgO9rHC2KgrB
         ueXdOyY9nKaYw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 03 Sep 2023 12:11:16 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] phy: sun4i-usb: Fix a W=1 compilation failure
Date:   Sun,  3 Sep 2023 12:11:06 +0200
Message-Id: <0bc81612171baaa6d5dff58c8e009debc03e1ba8.1693735840.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 12.3.0, when this file is built, we get errors such as:

drivers/phy/allwinner/phy-sun4i-usb.c: In function ‘sun4i_usb_phy_probe’:
drivers/phy/allwinner/phy-sun4i-usb.c:790:52: error: ‘_vbus’ directive output may be truncated writing 5 bytes into a region of size between 2 and 12 [-Werror=format-truncation=]
  790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
      |                                                    ^~~~~
drivers/phy/allwinner/phy-sun4i-usb.c:790:17: note: ‘snprintf’ output between 10 and 20 bytes into a destination of size 16
  790 |                 snprintf(name, sizeof(name), "usb%d_vbus", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because of the possible value of 'i', this can't be an issue in real world
application, but in order to have "make W=1" work correctly, give more
space for 'name'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index ec551464dd4f..e53a9a9317bc 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -782,7 +782,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 
 	for (i = 0; i < data->cfg->num_phys; i++) {
 		struct sun4i_usb_phy *phy = data->phys + i;
-		char name[16];
+		char name[32];
 
 		if (data->cfg->missing_phys & BIT(i))
 			continue;
-- 
2.34.1

