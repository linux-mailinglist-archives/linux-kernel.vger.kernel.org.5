Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE667D3D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjJWRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjJWRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:19:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59D10C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:19:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CB2C433C8;
        Mon, 23 Oct 2023 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081571;
        bh=S6VuZnLSrjB5GxMU65GonpVOh47WLEVeBa6XDjELS4M=;
        h=From:Date:Subject:References:In-Reply-To:To:From;
        b=KGx+UTzryt2yWBCGZgcgR6SPzPmwFnPRxyrEL7Qh1zvkvSntPPblbRPCx8Xp4QOb8
         zxD2c6BSsER1OuMxYQ6kH+k4whWXXcjjzcPtWG+HOU21K17pJB911FMhMLTi9h5atb
         jWf2Pqv6Kp/6s2j8OCsaUIeHk0nLs3J//1gXbqhnQjeGsVa1U0dwCAV3eK6MIR5Kh6
         /W0AhNQq1QyqjksWIoyGztVnniXq+urERkF5ghB7HTTOOpfBiIrft5Heu3tFU6GHcm
         MOpLSO0JYtqhtDAsgVuLfOquJr58O4K8gno3MTWfVODMWWHTU4g772BMiVVoU6NJ6K
         tMClt8EvxsZRQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 18:19:11 +0100
Subject: [PATCH 1/2] regmap: kunit: Fix marking of the range window as
 volatile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-regmap-test-window-cache-v1-1-d8a71f441968@kernel.org>
References: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
In-Reply-To: <20231023-regmap-test-window-cache-v1-0-d8a71f441968@kernel.org>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S6VuZnLSrjB5GxMU65GonpVOh47WLEVeBa6XDjELS4M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNqsfoZp58flKey7+MNE8OVpvex5Y6IGYHlV3cF0t
 jy8nn0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTarHwAKCRAk1otyXVSH0G9rB/
 4l6u83a+dxSe54Kyc7q9BUTDK/o65tuxt6+JAKssNvf0V/+sITnyEGPBrqapm+UON7qyrOUoQhNcrZ
 5ssT26YQsa2L623yTlL7Slw3mLoNYCJWwyVqZdVSsIcT+8PrXGCMuxo87VNszZElpdsvgP346hGJRR
 UihorRYBlfvc1RnT4lkkdBPPB0oNmlz4IEi9aiedBNy0IyQuq7G+T1CJw5JzYgfBMwN3xZ0Wz0FItq
 DM5skn4Uq28TciqRpkZX+NALckJgP8xGndDM+UNyLDJgelCgcSL6smQklwQzj53dBYQb7ptDURcj4k
 y2wW/g7Ua1wOtoZZ9TFV05Vccecnjh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason the regmap used for testing ranges was not including the
end of the range of paged registers as volatile since it found the end by
counting from the selector register rather than the base of the window.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-kunit.c b/drivers/base/regmap/regmap-kunit.c
index 264d29b3fced..f79fd5ec187e 100644
--- a/drivers/base/regmap/regmap-kunit.c
+++ b/drivers/base/regmap/regmap-kunit.c
@@ -445,7 +445,7 @@ static struct regmap_range_cfg test_range = {
 static bool test_range_volatile(struct device *dev, unsigned int reg)
 {
 	if (reg >= test_range.window_start &&
-	    reg <= test_range.selector_reg + test_range.window_len)
+	    reg <= test_range.window_start + test_range.window_len)
 		return true;
 
 	if (reg >= test_range.range_min && reg <= test_range.range_max)

-- 
2.30.2

