Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9C758A89
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGSA7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:59:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D83F1;
        Tue, 18 Jul 2023 17:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E02BA615F8;
        Wed, 19 Jul 2023 00:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB324C433C8;
        Wed, 19 Jul 2023 00:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689728344;
        bh=m+DQXW5oOBBKiDq+gqnKrZk+GHqHZgupJCPrOePrckM=;
        h=From:Date:Subject:To:Cc:From;
        b=n1x+oYfzNnx9aUiCysKEHFobDcDr4Rg8FBVHYbKKgGjw1eA0amX9CDQSbWFbcW1l6
         MRpxyj6VU17Ymgzan6vIympW5XZ5rI7KBJ6ogrlB6qw0hSTYWbBHh8m1PQtq3vQlmg
         1SvenkkIGROm+l8lP9i5fDHl3Pe8IA+bzz0aqhOfcPbib1rfk5psWQpDg5Rv5jm6E8
         qBZAOmHuYUZn1aOZHrUAt4wXj8ybfDFUbBdNY48N07T4KeYbwVwUydqrAA33Q84+pE
         /9pmaNyooiG/alZVXiVwbJDx1SiVOKlUAPepH6nv4YCuf8o8PhRRkP+yQAKEwW0UGj
         CQsa00oqxtPgg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 19 Jul 2023 01:58:54 +0100
Subject: [PATCH] thermal/drivers/sun8i: Free calibration nvmem after
 reading it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-thermal-sun8i-free-nvmem-v1-1-f553d5afef79@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE01t2QC/x3MywqDMBBG4VeRWXcgF2jVV5EuRP80AybKxEpBf
 HdDl9/inJMKVFCob05SHFJkzRX20dAUx/wBy1xNzjhvXrblPULTuHD55lY4KMD5SEjs0cFZb57
 woJpviiC//3p4X9cN1Am1wWoAAAA=
To:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m+DQXW5oOBBKiDq+gqnKrZk+GHqHZgupJCPrOePrckM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktzVTom85+f/CsiB3tDq5aRty+QLY7GiyI2QXE
 45eZI49muaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLc1UwAKCRAk1otyXVSH
 0NPMB/sGvVdLD3D+bb6SkCXEGskTVhY3pzkBBDYQpA9CssD24JsbsElftzoztvE8sNMWNOTB9IL
 ZdzrPxjPkpJhNOxUee+uMML6eg0lVtsSIobZe1fWidnN8/B4EE4IzywkOXiQdpiDSFlGgDJ23FX
 Yrto56HDP/bE4eFMxQmixvC2sQ3ZsnSrbfU90AiDkJAs6cxrh6GaTKvZ8PUOxSd5PTGHsHnGgKY
 beBzLXkLBl62wFZXghrfoIOVPRwJpwOaaObPnrTiBt3agCEF6hKDWLLVpSYe4YU4I+9l5Xz1Lmp
 HMup7rGvqY+EJincYrtBcOQ0fwDXCmsJPnsoHr5iOj2KdsAs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sun8i thermal driver reads calibration data via the nvmem API at
startup, updating the device configuration and not referencing the data
again.  Rather than explicitly freeing the nvmem data the driver relies
on devm_ to release it, even though the data is never referenced again.
The allocation is still tracked so it's not leaked but this is notable
when looking at the code and is a little wasteful so let's instead
explicitly free the nvmem after we're done with it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/thermal/sun8i_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..af3098717e3c 100644
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
 

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230718-thermal-sun8i-free-nvmem-3e9e21306e3e

Best regards,
-- 
Mark Brown <broonie@kernel.org>

