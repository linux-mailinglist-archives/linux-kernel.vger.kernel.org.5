Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E400A7DB130
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjJ2XaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjJ2X3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:29:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDF22700;
        Sun, 29 Oct 2023 15:59:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4FAC116B1;
        Sun, 29 Oct 2023 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620296;
        bh=YqgL3JlI9PcctTEnavZMjyjn+ScP9k7hZzFJc+ccac8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFl7Lqx0k2aC/oRAKXBNmSZeRxxUFK7Z9zDu3Uh/JnxFqMQs795Liene1saaFvPuy
         EDipw9LFZvwYvKtcJNhnsKS5ZgC02nS2v1q5gkGiq0ybMNY4qoRpc/7/ZrX0GrNq+z
         0kwWiGp32+kqo4N+qmAZl2CcdMS8igaO4EzfAjO3YezEf0N5cyBybg881KtNeP4eEm
         1zQJAfF7l8tORzbbKSmI3lBwiy+T0IMZEXuJpaOll3zLdtgm1PkTBtufyiSP8LRZYY
         xT7ymzdCgo87KVtajddzSrNKhgH5LfzJotXU58wIjh3pDO+U7MF8eoLcGWY0XMelPH
         LojzMDs3O7mKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        sam@ravnborg.org, tzimmermann@suse.de, xu.panda@zte.com.cn,
        u.kleine-koenig@pengutronix.de, mielkesteven@icloud.com,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 23/39] fbdev: omapfb: fix some error codes
Date:   Sun, 29 Oct 2023 18:56:55 -0400
Message-ID: <20231029225740.790936-23-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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
index 17cda57656838..5ea7c52baa5a8 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1643,13 +1643,13 @@ static int omapfb_do_probe(struct platform_device *pdev,
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

