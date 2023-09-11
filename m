Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C89179B09E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378782AbjIKWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbjIKLQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:16:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605DC1A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:16:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC056C433C8;
        Mon, 11 Sep 2023 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694430989;
        bh=O0faahUdqQERokNfZ+EUmG8INIrHP3lcwn9a1BQUUMs=;
        h=From:To:Cc:Subject:Date:From;
        b=L0cVj2WuHg3B0CGXWNUxoqjjcW+4HTa8vGmAffD5C/SBv14TyYtmaiHFR2LJPgEWM
         YidFmDOaYt+Q9OXh/CsuBLaUD5G/hzRtUg2s/djnySLcSQApiSITicoZxMfB51alYP
         TNDj4QBdYh2B8QaXRmklgjVw40dgr2D1uuYqgkqwzHJAaY1RzTHAMHh7YKSevIoI4+
         pYXVgMMJbydnMb75aWwpkdxuwRcJ9Q40GcjPDaRoNzr0EQfZFJnCAFdzpfkKTGiOE9
         6V09P1HI9YK25UcHxQ1OyQM5HSIhajT+pxtML0Pz4/ll5SEPP8r87HknPg18/YfbG4
         4qq2U1QXku48g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: cs42l43: use modern PM macro helpers
Date:   Mon, 11 Sep 2023 13:16:15 +0200
Message-Id: <20230911111623.705640-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The old SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS macros required enclosing
the function definitions in an #ifdef or marking them __maybe_unused:

drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
 1138 | static int cs42l43_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
 1124 | static int cs42l43_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
 1106 | static int cs42l43_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
 1076 | static int cs42l43_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

Use the modern replacements to avoid the warnings without those annotations.

Fixes: ace6d14481386 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae823..7b6d07cbe6fc6 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
-	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
+	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
 };
 
 MODULE_DESCRIPTION("CS42L43 Core Driver");
-- 
2.39.2

