Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCABB7E0F1E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjKDLd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjKDLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:33:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F46D49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:33:51 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a92727934eso107131839f.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699097631; x=1699702431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1unSOhmm2Wdrkotg5oMVcVzXjBgM2cS465ES0k4jZY=;
        b=a8XDPYXknBpOFgcKsYK/xH5zEv6ctXN9PrjvOixHPPzYRkL7BscUGZIFt4GpvOrfRa
         5/FP4S26WnQUCKQ6gSDuhxFwvd5v1B4ZJ1u3X8QZiV23bYzVBvUFT6ng5Eawg2NGoxRm
         Agsufr1mcD0KZO4e23Cxbya8Q4joPUHft3t+thros5ncPKY3MtMx12D1afqB2U6v0BH7
         4ipm+hdRnEx1b85lx4lxyiFqLfrq5JmuKhldwNfo5n7OedzXo5rID3PbKCJ7g7yO7fkQ
         noOzDo/gdTaHTcGZKAVMJQWP5dTzy/I5ODPBpcSPG7li9FHvUTPQIfByacQEAs4nC98T
         vQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699097631; x=1699702431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1unSOhmm2Wdrkotg5oMVcVzXjBgM2cS465ES0k4jZY=;
        b=IRrVSxqOUExVWmviEOjdEtX3IRSFjMInviWKroyXAlmlKjW/BDxscakgZ4Qe6PxAHf
         HoPdtwHDBvV3SuPWyhjUR1FID161UNpKmuWBEA4LGeYJy9VFa0zKnnATZ7dwF9JSjhjh
         L9//ztazO4yhvANcYIbv+Vdq2TEm2xebey2w5KkTjjTxd4+XE4sjWGPUMdSNFuJ9N/zS
         mSK2asoqN++tqRRkLekxcB+g9IUYTVtzieYbPje8aGHRgUNm0CThkTVSXXVg8wuy1tii
         3hqB5vbgwcy4TuqVERG+ptYr4mUkI03Fg2Xwb1FQMzQGWq0lypBbHQpDBbYFPVenV+wi
         2jjg==
X-Gm-Message-State: AOJu0YwstaTO7k76zOx3Eaybhlz+pQXZHDOkkaKz5WAI5S5FqKdyffh9
        9/QKcTUgMPqm4oK0JMTGYj4=
X-Google-Smtp-Source: AGHT+IHfkBqDHcaXI13I92jFq4qe3R1jf5ec6iYP0G/J/Ox9Y1sauYyZzUUWFb+D/sypQGu+WI6viA==
X-Received: by 2002:a05:6602:2acf:b0:787:ff98:c38c with SMTP id m15-20020a0566022acf00b00787ff98c38cmr32189338iov.10.1699097631080;
        Sat, 04 Nov 2023 04:33:51 -0700 (PDT)
Received: from localhost.localdomain ([182.225.11.211])
        by smtp.gmail.com with ESMTPSA id v10-20020a62c30a000000b00692cb1224casm2921823pfg.183.2023.11.04.04.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 04:33:50 -0700 (PDT)
From:   Dongmin Lee <ldmldm05@gmail.com>
To:     akpm@linux-foundation.org, lkp@intel.com
Cc:     ldmldm05@gmail.com, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Subject: [PATCH v2] kernel/reboot: Explicitly notify if halt occurred instead of power off
Date:   Sat,  4 Nov 2023 20:33:20 +0900
Message-Id: <20231104113320.72440-1-ldmldm05@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <202311040832.yiyrijgk-lkp@intel.com>
References: <202311040832.yiyrijgk-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel_can_power_off() returns false, and reboot has called with
LINUX_REBOOT_CMD_POWER_OFF, kernel_halt() will be initiated instead of
actual power off function.

However, in this situation, Kernel never explicitly notifies user that
system halted instead of requested power off.

Since halt and power off perform different behavior, and user initiated
reboot call with power off command, not halt, This could be unintended
behavior to user, like this:

~ # poweroff -f
[    3.581482] reboot: System halted

Therefore, this explicitly notifies user that poweroff is not available,
and halting has been occured as an alternative behavior instead:

~ # poweroff -f
[    4.123668] reboot: Power off not available: System halted instead

Signed-off-by: Dongmin Lee <ldmldm05@gmail.com>
---
v1->v2:
 - changed new variable poweroff_fallback_to_halt to static bool as per
   kernel test robot's sparse warning notification.
 - fixed minor coding style issue

 kernel/reboot.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..34ea519e3d94 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -58,6 +58,13 @@ struct sys_off_handler {
 	struct device *dev;
 };
 
+/*
+ * This variable is used to indicate if a halt initiated instead when
+ * reboot call is invoked with LINUX_REBOOT_CMD_POWER_OFF, but system
+ * cannot be powered off. This allowes kernel_halt() to notify that.
+ */
+static bool poweroff_fallback_to_halt;
+
 /*
  * Temporary stub that prevents linkage failure while we're in process
  * of removing all uses of legacy pm_power_off() around the kernel.
@@ -297,7 +304,10 @@ void kernel_halt(void)
 	kernel_shutdown_prepare(SYSTEM_HALT);
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
-	pr_emerg("System halted\n");
+	if (poweroff_fallback_to_halt)
+		pr_emerg("Power off not available: System halted instead\n");
+	else
+		pr_emerg("System halted\n");
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_halt();
 }
@@ -732,8 +742,10 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	/* Instead of trying to make the power_off code look like
 	 * halt when pm_power_off is not set do it the easy way.
 	 */
-	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !kernel_can_power_off())
+	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !kernel_can_power_off()) {
+		poweroff_fallback_to_halt = true;
 		cmd = LINUX_REBOOT_CMD_HALT;
+	}
 
 	mutex_lock(&system_transition_mutex);
 	switch (cmd) {

base-commit: bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
-- 
2.39.3 (Apple Git-145)

