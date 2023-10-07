Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE07BC606
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbjJGIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJGIV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:21:59 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A38B9B9;
        Sat,  7 Oct 2023 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jpLE4
        H32ThsJyUmBiuptNCfeV0xPsEphlDRUqHMRYvc=; b=Ujga6X0Th/MtrUeG0zEFw
        LZs5JZ8JfQjoPhg3XGGsiE05UceS6VG8rRMTqAJNuBn8nsFPo1JxK8pH5plfNLeU
        AZE6rmwnbK/5ttj9z0RoIchKjZ24YvFzHn1HoPhSAEi8/cS6oTcoREIuBmrbS3t6
        8xIVTEl+XuseLNpiflp5jI=
Received: from localhost.localdomain (unknown [39.144.138.241])
        by zwqz-smtp-mta-g2-2 (Coremail) with SMTP id _____wA3cIwFFSFls7Y9EA--.51861S2;
        Sat, 07 Oct 2023 16:21:26 +0800 (CST)
From:   Xing Tong Wu <xingtong_wu@163.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        xingtong.wu@siemens.com
Cc:     jan.kiszka@siemens.com, tobias.schaffner@siemens.com,
        cedric.hombourger@siemens.com, gerd.haeussler.ext@siemens.com
Subject: [PATCH] watchdog: wdat_wdt: Add timeout value as a param in ping method
Date:   Sat,  7 Oct 2023 16:21:25 +0800
Message-Id: <20231007082125.4699-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wA3cIwFFSFls7Y9EA--.51861S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW3uFW8XrWrKw47GFyDWrg_yoW8GrWfpr
        Wjkr15CryUtr48CFWxJwn7G39rCwnrZrW7XFykCw1Fv3s8KF15Ja1kt3srK34DKrZ3GFyY
        ga4xKry8Aayjyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhyCJUUUUU=
X-Originating-IP: [39.144.138.241]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiOwsC0GC5nsxYpwAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xing Tong Wu <xingtong.wu@siemens.com>

According to the WDAT spec that states about WATCHDOG_ACTION_SET_COUNTDOWN_PERIOD:
"This action is required if WATCHDOG_ACTION_RESET does not explicitly write a new
countdown value to a register during a reset."
And that implies, WATCHDOG_ACTION_RESET may write a countdown value, thus may come
with a WATCHDOG_INSTRUCTION_WRITE_COUNTDOWN, thus need the timeout value as parameter
or would otherwise write 0.
The watchdog for SIONCT6126 need a entry WATCHDOG_INSTRUCTION_WRITE_COUNTDOWN for
WATCHDOG_ACTION_RESET action, I send this patch to support it.

Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
---
 drivers/watchdog/wdat_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 0ba99bed59fc..650fdc7996e1 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -269,7 +269,7 @@ static int wdat_wdt_stop(struct watchdog_device *wdd)
 
 static int wdat_wdt_ping(struct watchdog_device *wdd)
 {
-	return wdat_wdt_run_action(to_wdat_wdt(wdd), ACPI_WDAT_RESET, 0, NULL);
+	return wdat_wdt_run_action(to_wdat_wdt(wdd), ACPI_WDAT_RESET, wdd->timeout, NULL);
 }
 
 static int wdat_wdt_set_timeout(struct watchdog_device *wdd,
-- 
2.25.1

