Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B897B798BB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245577AbjIHSAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245545AbjIHSA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:00:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D142106;
        Fri,  8 Sep 2023 11:00:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0B2C433D9;
        Fri,  8 Sep 2023 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196020;
        bh=mTMTjLCVSSPXywgTnKqEW6R5YhoMVuBHHhb2Yf9zVZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUhdjSLPYpmLNW7erjHrrvhUWM9J2Ffjwg0EY69pUNlsswbyIxSWSPJdT2vKi1w11
         e6/iyoKuVnYgDDc2i7bJJA+j77hRbFGAOV55uaiPxWWuNz/njWPA52f5q+v3B8lbmP
         I8ARU7akuYlVl9hSBQcwRQEx+BaaoYN1Z0RsBd3Njj+tYpZuMxgiO2Wsm+3vQ6updb
         m1mOQwcRrnY/NK1eIbJWN3H6nbWcELKr1C/csmv2dkbKGWk4clswMBhlhNhda23vdR
         ULlFPd2VHiHAApgJNbl5EPGEulP68hQgYTkoztG54CXdno1AqEoEg4f9Q8l6MQ1jr5
         xDl0cGUetSOsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Barnes <robbarnes@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, bleung@chromium.org,
        chrome-platform@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 06/16] platform/chrome: cros_ec_lpc: Remove EC panic shutdown timeout
Date:   Fri,  8 Sep 2023 13:59:43 -0400
Message-Id: <20230908175953.3457942-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908175953.3457942-1-sashal@kernel.org>
References: <20230908175953.3457942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Barnes <robbarnes@google.com>

[ Upstream commit f2d4dced9a584612b25adb559c1350243d2bb544 ]

Remove the 1 second timeout applied to hw_protection_shutdown after an
EC panic. On some platforms this 1 second timeout is insufficient to
allow the filesystem to fully sync. Independently the EC will force a
full system reset after a short period. So this backup timeout is
unnecessary.

Signed-off-by: Rob Barnes <robbarnes@google.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50e0cf51b3e961@changeid
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 500a61b093e47..356572452898d 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -327,8 +327,8 @@ static void cros_ec_lpc_acpi_notify(acpi_handle device, u32 value, void *data)
 		dev_emerg(ec_dev->dev, "CrOS EC Panic Reported. Shutdown is imminent!");
 		blocking_notifier_call_chain(&ec_dev->panic_notifier, 0, ec_dev);
 		kobject_uevent_env(&ec_dev->dev->kobj, KOBJ_CHANGE, (char **)env);
-		/* Begin orderly shutdown. Force shutdown after 1 second. */
-		hw_protection_shutdown("CrOS EC Panic", 1000);
+		/* Begin orderly shutdown. EC will force reset after a short period. */
+		hw_protection_shutdown("CrOS EC Panic", -1);
 		/* Do not query for other events after a panic is reported */
 		return;
 	}
-- 
2.40.1

