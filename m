Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576BB771068
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjHEQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEQCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:02:06 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4AE70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 09:02:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vp3juXZ_1691251304;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0Vp3juXZ_1691251304)
          by smtp.aliyun-inc.com;
          Sun, 06 Aug 2023 00:02:00 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     akpm@linux-foundation.org, dianders@chromium.org, pmladek@suse.com
Cc:     liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog/hardlockup: set watchdog_hardlockup_warned to true as early as possible
Date:   Sun,  6 Aug 2023 00:01:44 +0800
Message-Id: <20230805160144.121875-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we want to ensure only printing hardlockups once, it is necessary
to set "watchdog_hardlockup_warned" to true as early as possible.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 25d5627a6580..c4795f2d148c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -180,6 +180,8 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 		/* Only print hardlockups once. */
 		if (per_cpu(watchdog_hardlockup_warned, cpu))
 			return;
+		else
+			per_cpu(watchdog_hardlockup_warned, cpu) = true;
 
 		pr_emerg("Watchdog detected hard LOCKUP on cpu %d\n", cpu);
 		print_modules();
@@ -206,8 +208,6 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
 
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
-
-		per_cpu(watchdog_hardlockup_warned, cpu) = true;
 	} else {
 		per_cpu(watchdog_hardlockup_warned, cpu) = false;
 	}
-- 
2.19.1.6.gb485710b

