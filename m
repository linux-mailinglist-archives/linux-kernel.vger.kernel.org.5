Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3C7DAF3F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjJ2W6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJ2W5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:57:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA32D46;
        Sun, 29 Oct 2023 15:56:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB375C433CB;
        Sun, 29 Oct 2023 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620154;
        bh=92atpQovPf8dUEyPgtOqbb4csWrmpJaDoIHvo6WYpNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2l269XNEiRwoZ1blLTJ38RxlqH9ZnG4UnyybdO/8l3fV60TUoNvRc7zda65thKIU
         +3TDqMuLbVIfwM5h7dqpX3Km7ySo6YWNoVutSHY4jFSkcMmiAeEkyDUJ1Bra9eiMqj
         aeEuVe66RmfRj7UtoZDElDWWdAYxcpJbsb3BJ9rWpR+qmSnXETRxn8cDqkRLHS0raH
         g3uFRqBuyCi2W9LmM90dzlslkUCT5/TjbyiMSe7hKND+vZF8Bi6Ca46XdnGh+yn/AD
         wS1upwby3h7FgMnOMsFCDHXQgYToHEt+hwdGaCkJDPgfT2NOU+jWMMxeFYLYHl8VFm
         K8AfssMMnwJkw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        sam@ravnborg.org, tzimmermann@suse.de, xu.panda@zte.com.cn,
        mielkesteven@icloud.com, u.kleine-koenig@pengutronix.de,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 32/52] fbdev: omapfb: fix some error codes
Date:   Sun, 29 Oct 2023 18:53:19 -0400
Message-ID: <20231029225441.789781-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit dc608db793731426938baa2f0e75a4a3cce5f5cf ]

Return negative -ENXIO instead of positive ENXIO.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/omap/omapfb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index ad65554b33c35..0be95b4e14fdb 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1648,13 +1648,13 @@ static int omapfb_do_probe(struct platform_device *pdev,
 	}
 	fbdev->int_irq = platform_get_irq(pdev, 0);
 	if (fbdev->int_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
 	fbdev->ext_irq = platform_get_irq(pdev, 1);
 	if (fbdev->ext_irq < 0) {
-		r = ENXIO;
+		r = -ENXIO;
 		goto cleanup;
 	}
 
-- 
2.42.0

