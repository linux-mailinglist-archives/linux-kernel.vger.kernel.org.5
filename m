Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5E7DFF10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjKCGPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C94CA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso1656441a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 23:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698992105; x=1699596905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L780/51HQsKf2bbe0SqnoEuuYH93sTzkhOgadEqARME=;
        b=eaJcSuFdDjv63+8aQvRBP48FGq4CFRSArGJjgsgFEWXn4whJIAYFCr5ntmwPhLMjkt
         Nm0YAN5rnIUmBcmn/krqn+MV3cs7swfVRspuu8vt+hpUCCPCFm0nLrnRRgVFHbkxcIHS
         ejfrYaWkeakoOpqhbhio6hCJ+1fGLbH9FYC74kqjQUmzi2NqRChhonQwcZfbquWI24Ow
         axLMRMYN8a2NWpeEPZQVdoqTGGBXIn5XfKv98g5qrpd9zcBFF4ZHcRWxqUzidK/73LN4
         aiXARjN79VMURdx0Yx0gURZrID6/W62JlHp4kScKhHGHfRJWJr480DfWDfFW8zcl4e5b
         wV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698992105; x=1699596905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L780/51HQsKf2bbe0SqnoEuuYH93sTzkhOgadEqARME=;
        b=kYydgXucSGkCl4zhRUQ73Yef6n4h4oNgBfcD/BOQZgvYMOCsg4U7ho7TdXfKT4S1VP
         ocetkOBxAfPUIvmf6JFeIypNABZMuNitBItvJ03GfADncw6BH4XFn2BeMsFPoZFUuBtG
         PJ+q6ffIIt/sXU9HMtQ7e0HSQWbP1busoWS+iCIYjcb5ZoAUvcdUabQDwDmnc91a9GCe
         eB6dQ4E2sFLLwrx5hlGqiJr20eWh62kNCyxTmm3B2vMLRZo8YLKAGlzlqHE9Ww2sucfT
         EjV5FqPRiuPFaSEIgLUr0BtpKHH1Ya4viXnabh5Wal3M8FDx8CANkY88v2U8SbKmK7vK
         Ar9A==
X-Gm-Message-State: AOJu0YwcrQ5RfcUWgKfIeo2M4n+LfZ/tBdX33wn7Opz+RjDx3iarRi9w
        ytFUO7q3z98AHZ/M0v80iBPfA0roKZ3f7Q==
X-Google-Smtp-Source: AGHT+IGnnoYc0Xsv6YVqSHY5z0JQx/hdxYOfLjTjihB+OuQuRD3s0q1EkSlevkodRaO3TrDXz70Atg==
X-Received: by 2002:a17:90b:1885:b0:280:1b83:e45e with SMTP id mn5-20020a17090b188500b002801b83e45emr16633080pjb.39.1698992104599;
        Thu, 02 Nov 2023 23:15:04 -0700 (PDT)
Received: from localhost.localdomain ([211.251.170.145])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090abb9400b002807ec010e3sm716050pjr.48.2023.11.02.23.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 23:15:04 -0700 (PDT)
From:   Dongmin Lee <ldmldm05@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dongmin Lee <ldmldm05@gmail.com>
Subject: [PATCH] kernel/reboot: Explicitly notify if halt occurred instead of power off
Date:   Fri,  3 Nov 2023 15:14:48 +0900
Message-Id: <20231103061448.68118-1-ldmldm05@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,
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
 kernel/reboot.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 395a0ea3c7a8..dd33b07cc2f1 100644
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
+int poweroff_fallback_to_halt = 0;
+
 /*
  * Temporary stub that prevents linkage failure while we're in process
  * of removing all uses of legacy pm_power_off() around the kernel.
@@ -297,7 +304,10 @@ void kernel_halt(void)
 	kernel_shutdown_prepare(SYSTEM_HALT);
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
-	pr_emerg("System halted\n");
+	if(poweroff_fallback_to_halt)
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
+		poweroff_fallback_to_halt = 1;
 		cmd = LINUX_REBOOT_CMD_HALT;
+	}
 
 	mutex_lock(&system_transition_mutex);
 	switch (cmd) {

base-commit: bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
-- 
2.39.3 (Apple Git-145)

