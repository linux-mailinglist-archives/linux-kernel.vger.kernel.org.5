Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3560178C6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbjH2OFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbjH2OEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:04:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348BCD9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1693317873;
  x=1724853873;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=WD26gmABzoJ++0sx9qo1Iw0ukCA0Y7iDO6UmetUh1E4=;
  b=UDOtgofB4Q5s1I7Bnay1bGvJdWoZdJFv03Ve21vp/ChQ9bifOLOWXUAU
   gQ3cpfvxLN+022oARn3ddi5CezubxJxuWC2iAcrMjkdxRdQX0hqHi/TMW
   wG2LM2vclAlJQDk1lcXAkoqjc6ZU6oKfVDoOIu8ivzX4jaa5jhT+rxg3c
   JXscsntuo5EjRwhE9Nzx+Hl0BFyYx286Wt/oqYcGfzcLoyDlIaLk0gdA0
   HqI/0joFuj3HVnVdcchyxBeIycF4xBg7p0MkVFxeI7trr3uWyx6t/Qswl
   aaENdumWWLBPGFMqFzo4EYC3Mnawg+fFGk7RUjpQLXeR0E+A6fnBJH6io
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 29 Aug 2023 16:04:12 +0200
Subject: [PATCH] regulator: tps6287x: Fix n_voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230829-tps-voltages-v1-1-7ba4f958a194@axis.com>
X-B4-Tracking: v=1; b=H4sIANv67WQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyNL3ZKCYt2y/JySxPTUYt00Q0tLy0RLAzPzZBMloJaCotS0zAqwcdG
 xtbUAYQJQql4AAAA=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Axel Lin <axel.lin@ingics.com>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 256 possible voltage settings for each range, not 256 possible
voltage settings in total.

Fixes: 15a1cd245d5b ("regulator: tps6287x: Fix missing .n_voltages setting")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/tps6287x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index b1c0963586ac..e45579a4498c 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -119,7 +119,7 @@ static struct regulator_desc tps6287x_reg = {
 	.ramp_mask = TPS6287X_CTRL1_VRAMP,
 	.ramp_delay_table = tps6287x_ramp_table,
 	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
-	.n_voltages = 256,
+	.n_voltages = 256 * ARRAY_SIZE(tps6287x_voltage_ranges),
 	.linear_ranges = tps6287x_voltage_ranges,
 	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
 	.linear_range_selectors = tps6287x_voltage_range_sel,

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230829-tps-voltages-f1999a9067c4

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

