Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77988799561
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjIIBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjIIBOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:14:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E3D2695;
        Fri,  8 Sep 2023 18:13:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD0EC433B6;
        Sat,  9 Sep 2023 01:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221984;
        bh=s7UGrDwp2Fbn1/Oq5TSE/75H8fK01vSD0DcAQNFWpLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8vQbFWMMBCzENoxYfMp8Vc7W09HgWYbOJESgTgDL52LTsG1rwvJ16j5J+6kw4RgL
         M8HFbZ3TqUuQeoYqzPDgV9DzbEUqCuBdlrPR5NGznHNS8ezZBYiDKSQVkV6GdEJji0
         kWr6n+V8BTJueuM4qzc5Ej91+46A42ZrxQ61HCv8uyXNTuea6FiZIGywMrUYDpNsCr
         AMtj7z/nCVFu1FnoZX75O5QZSjP6w/4K4It855qVxsQGg528yyFHVlKRt2Do1m2z7r
         mj/dF1GJ67LLmjgks5sgUSFtR8kGTBnBZkRIqQTCfImPJLWC+xTt52dx/LrM3gIcUc
         9L9YZPmDe+ULg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rafael@kernel.org, wens@csie.org,
        samuel@sholland.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 6/6] thermal/drivers/sun8i: Free calibration nvmem after reading it
Date:   Fri,  8 Sep 2023 21:12:54 -0400
Message-Id: <20230909011254.3581788-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909011254.3581788-1-sashal@kernel.org>
References: <20230909011254.3581788-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

[ Upstream commit c51592a95f360aabf2b8a5691c550e1749dc41eb ]

The sun8i thermal driver reads calibration data via the nvmem API at
startup, updating the device configuration and not referencing the data
again.  Rather than explicitly freeing the nvmem data the driver relies
on devm_ to release it, even though the data is never referenced again.
The allocation is still tracked so it's not leaked but this is notable
when looking at the code and is a little wasteful so let's instead
explicitly free the nvmem after we're done with it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/sun8i_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b388..af3098717e3c1 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -286,7 +286,7 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	size_t callen;
 	int ret = 0;
 
-	calcell = devm_nvmem_cell_get(dev, "calibration");
+	calcell = nvmem_cell_get(dev, "calibration");
 	if (IS_ERR(calcell)) {
 		if (PTR_ERR(calcell) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
@@ -316,6 +316,8 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 
 	kfree(caldata);
 out:
+	if (!IS_ERR(calcell))
+		nvmem_cell_put(calcell);
 	return ret;
 }
 
-- 
2.40.1

