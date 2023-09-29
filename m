Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27E27B2A44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjI2CMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI2CMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:12:20 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF51A19F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:12:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79f96f83270so437473739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695953538; x=1696558338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqq4K4J4v3GU1zpra4AFU6+X76RkkP22ZNAXzHknflA=;
        b=N63ntl2JnuOvbniZltySw41zVfW6TYu0zK/8h9YxrKGH/+KM0WH1rfBuWQrTmWG6dn
         mVVH7OKN4+AqlRvdSP14TgYSpF2pkOWiDOggMBVYiMXhJUcpT5nOT5wBbv5JG/ydnhbi
         LpYw3j1pObAa31eigGv38hDuTbKxJa0GREC5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695953538; x=1696558338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqq4K4J4v3GU1zpra4AFU6+X76RkkP22ZNAXzHknflA=;
        b=ZKhyqr5NQYLrpo2S6q+EevS8I49j1y/Njjf03S5C4yQf4SgN0CZgaI6y5Gs0ljz/u4
         Tj3v8TuEGoGtTHwG+NVmRFrlNAwdKI27iPkJqxhQxpbP+IiyYt4GEINRP+evbom7drSM
         cj7VomS207xK35bvnywwmqQLt0e0lr8BK+8n50k/T4nfOKSbunG5qGWaiQ2M4a9C6+A1
         b09oE/j8nm+p+9JTOcEzxXCMwf0ZWSy+8cbL5X7RWifWMdYHshCpMbQn/4z2QG2mXsvZ
         jeMlRGjqV1YbSla0m6s7Qguffq1knKpKc0mT3VtZA1hVCJUQH+WBje9RA4UZ38NFuUd4
         v1kQ==
X-Gm-Message-State: AOJu0Yy+3kS4hgtVm9sbcOv55vhjX20frl8zTUdX3X9xXMfdubyUIl6r
        ZSttYGuGEhtpWOyZM6E52IdFVWe8I1cZACxPGQs=
X-Google-Smtp-Source: AGHT+IEai1UK0aHYmKd2wVeivdN2wmsYyz+oQOdL6LbVDKwokuooeNmu4Sjc7PYclcGvO3aCbuUCRw==
X-Received: by 2002:a05:6e02:152e:b0:351:5acb:271 with SMTP id i14-20020a056e02152e00b003515acb0271mr3427556ilu.1.1695953537852;
        Thu, 28 Sep 2023 19:12:17 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id g6-20020a02c546000000b004290f6c15bfsm4937018jaj.145.2023.09.28.19.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 19:12:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
Subject: [PATCH] kexec: Fix reboot race during device_shutdown()
Date:   Fri, 29 Sep 2023 02:12:12 +0000
Message-ID: <20230929021213.2364883-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During kexec reboot, it is possible for a race to occur between
device_shutdown() and userspace.  This causes accesses to GPU after pm_runtime
suspend has already happened. Fix this by calling freeze_processes() before
device_shutdown().

Such freezing is already being done if kernel supports KEXEC_JUMP and
kexec_image->preserve_context is true. However, doing it if either of these are
not true prevents crashes/races.

This fixes the following crash during kexec reboot on an ARM64 device
with adreno GPU:

[  292.534314] Kernel panic - not syncing: Asynchronous SError Interrupt
[  292.534323] Hardware name: Google Lazor (rev3 - 8) with LTE (DT)
[  292.534326] Call trace:
[  292.534328]  dump_backtrace+0x0/0x1d4
[  292.534337]  show_stack+0x20/0x2c
[  292.534342]  dump_stack_lvl+0x60/0x78
[  292.534347]  dump_stack+0x18/0x38
[  292.534352]  panic+0x148/0x3b0
[  292.534357]  nmi_panic+0x80/0x94
[  292.534364]  arm64_serror_panic+0x70/0x7c
[  292.534369]  do_serror+0x0/0x7c
[  292.534372]  do_serror+0x54/0x7c
[  292.534377]  el1h_64_error_handler+0x34/0x4c
[  292.534381]  el1h_64_error+0x7c/0x80
[  292.534386]  el1_interrupt+0x20/0x58
[  292.534389]  el1h_64_irq_handler+0x18/0x24
[  292.534395]  el1h_64_irq+0x7c/0x80
[  292.534399]  local_daif_inherit+0x10/0x18
[  292.534405]  el1h_64_sync_handler+0x48/0xb4
[  292.534410]  el1h_64_sync+0x7c/0x80
[  292.534414]  a6xx_gmu_set_oob+0xbc/0x1fc
[  292.534422]  a6xx_get_timestamp+0x40/0xb4
[  292.534426]  adreno_get_param+0x12c/0x1e0
[  292.534433]  msm_ioctl_get_param+0x64/0x70
[  292.534440]  drm_ioctl_kernel+0xe8/0x158
[  292.534448]  drm_ioctl+0x208/0x320
[  292.534453]  __arm64_sys_ioctl+0x98/0xd0
[  292.534461]  invoke_syscall+0x4c/0x118

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ricardo Ribalda <ribalda@google.com>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Ricardo Ribalda <ribalda@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kexec_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..6599f485e42d 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1299,6 +1299,12 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		error = freeze_processes();
+		if (error) {
+			error = -EBUSY;
+			goto Unlock;
+		}
+
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-- 
2.42.0.582.g8ccd20d70d-goog

