Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A527180A5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573980AbjLHOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573958AbjLHOhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:37:09 -0500
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA9173B;
        Fri,  8 Dec 2023 06:37:15 -0800 (PST)
Received: from lela.futurama.org (localhost.localdomain [IPv6:::1])
        by rhlx01.hs-esslingen.de (Postfix) with ESMTP id BD6342A00646;
        Fri,  8 Dec 2023 15:37:10 +0100 (CET)
Received: from dcbf.. (unknown [192.168.1.149])
        by lela.futurama.org (Postfix) with ESMTP id A40548032518;
        Fri,  8 Dec 2023 15:37:10 +0100 (CET)
From:   Adrian Reber <areber@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2] tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE
Date:   Fri,  8 Dec 2023 15:36:56 +0100
Message-ID: <20231208143656.1019-1-areber@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The capability CAP_CHECKPOINT_RESTORE was introduced to allow non-root
users to checkpoint and restore processes as non-root with CRIU.

This change extends CAP_CHECKPOINT_RESTORE to enable the CRIU option
'--shell-job' as non-root. CRIU's man-page describes the '--shell-job'
option like this:

  Allow one to dump shell jobs. This implies the restored task will
  inherit session and process group ID from the criu itself. This option
  also allows to migrate a single external tty connection, to migrate
  applications like top.

TIOCSLCKTRMIOS can only be done if the process has CAP_SYS_ADMIN and
this change extends it to CAP_SYS_ADMIN or CAP_CHECKPOINT_RESTORE.

With this change it is possible to checkpoint and restore processes
which have a tty connection as non-root if CAP_CHECKPOINT_RESTORE is
set.

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Adrian Reber <areber@redhat.com>
---
Changes in v2:
- replaced "if (!capable(CAP_SYS_ADMIN) && !capable(CAP_CHECKPOINT_RESTORE))"
  with "if (!checkpoint_restore_ns_capable(&init_user_ns))" as suggested
  by Christian Brauner
- v1: https://lore.kernel.org/linux-serial/20231206134340.7093-1-areber@redhat.com/
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 4b499301a3db..85de90eebc7b 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -844,7 +844,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios(&kterm,
@@ -861,7 +861,7 @@ int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 			ret = -EFAULT;
 		return ret;
 	case TIOCSLCKTRMIOS:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!checkpoint_restore_ns_capable(&init_user_ns))
 			return -EPERM;
 		copy_termios_locked(real_tty, &kterm);
 		if (user_termios_to_kernel_termios_1(&kterm,

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0

