Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E4179AF98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359659AbjIKWfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbjIKMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:42:56 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC93ACEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694436171;
  x=1725972171;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=iRWKgzYyApFXq9hIJlEr7x3MLl9rxdsbG3Nqgvq7fM4=;
  b=Pg2NjzVMf5xIU9kjje5DOQIAYpmuT0HXyONHVokdYME0Zah87IWOOiBi
   35RVqE7OJHvFUJU/YK0QNg4iZUfxma4MTV9rba3F6ZlynaFh6+KAHmmYy
   pEiDKXKzLBiC17+7lOuwtwM9QzoQV2vIaraJ12kTzE2EofwlMvfa+3H6A
   MdkMFbumAB9jB2IEH+F6JBHd7ljo9Olr5zmx1AVqa5wP7OhrSUyVZIv4j
   bU9gyU7tqY8p1Eij1lvDxNYsHREW307huoXkl6859UJBl7KB8sMf+J1L7
   8S5PiydxyYU2oGMIZE4f7etYWmXrR4dX+KvXtqrU8mO1klamVOufL/EHh
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 11 Sep 2023 14:42:47 +0200
Subject: [PATCH] regulator: Fix voltage range selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230911-regulator-voltage-sel-v1-1-886eb1ade8d8@axis.com>
X-B4-Tracking: v=1; b=H4sIAEYL/2QC/x2MQQqAMAzAviI9O2gnIvoV8TC2qoXhpFMRxL87P
 AaSPJBZhTMM1QPKl2RJWwGqK/Cr2xY2EgqDRdtgT2SUlzO6I6m5UjxcETJH03rCQD6g7RBKuyv
 Pcv/fcXrfDz1qBzVnAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct field to fix wrong voltage range selection on regulators
such as tps6287x since the blamed commit.

Fixes: 269cb04b601d ("regulator: Use bitfield values for range selectors")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 5ad5f3b3a6b5..d49268336553 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -197,7 +197,7 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	sel += rdev->desc->linear_ranges[i].min_sel;
 
 	range = rdev->desc->linear_range_selectors_bitfield[i];
-	range <<= ffs(rdev->desc->vsel_mask) - 1;
+	range <<= ffs(rdev->desc->vsel_range_mask) - 1;
 
 	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
 		ret = regmap_update_bits(rdev->regmap,

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230911-regulator-voltage-sel-5c10d1cd0270

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

