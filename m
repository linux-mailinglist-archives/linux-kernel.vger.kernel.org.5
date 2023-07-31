Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649187690F3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjGaJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGaJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B0E0;
        Mon, 31 Jul 2023 02:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDAE860DFF;
        Mon, 31 Jul 2023 09:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBB9C433C9;
        Mon, 31 Jul 2023 09:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794011;
        bh=koPLOXpSKm8PLNO/WcSVGaP713T9jox+3iKwaWka9XI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOF/8lLKzsmsN3VeOBvafYS3/82sJF7zj7BOg9Dg9rwqWIk1unPCX2WwYyQpskZFJ
         3x5XBLwN1FThAAt6r2RATPWfFy8f+HJts9itx+QU4lF2uxxon9kaG1fTEv+rL2vrLO
         pqcJGr0vhGjxDb2RniJEm3GMNbH34sHjUtICcfVlYxeHdFZ0Xhp6AOceE+aZ9mCGCp
         cV98SHnULawaB3+XFyyhQORoncvQqHYQj62mkz+VeZhruu/qLzxLTsO8llzvLROiPA
         iX0UOc+ehHAhgCqa1lOkbwn6AodHMYM7MDhkX9Bty5BF9ADoZ352xEhUl+R0YM2cS9
         lNitkD0kr3ugw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/7] tty: synclink_gt: drop info messages from init/exit functions
Date:   Mon, 31 Jul 2023 10:59:59 +0200
Message-ID: <20230731090002.15680-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred NOT to print anything from init and exit functions of a
module. (If everything goes fine.)

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index a8716a81ac74..4a93e0e48156 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3628,8 +3628,6 @@ static void slgt_cleanup(void)
 	struct slgt_info *info;
 	struct slgt_info *tmp;
 
-	printk(KERN_INFO "unload %s\n", driver_name);
-
 	if (serial_driver) {
 		for (info=slgt_device_list ; info != NULL ; info=info->next_device)
 			tty_unregister_device(serial_driver, info->line);
@@ -3671,8 +3669,6 @@ static int __init slgt_init(void)
 {
 	int rc;
 
-	printk(KERN_INFO "%s\n", driver_name);
-
 	serial_driver = tty_alloc_driver(MAX_DEVICES, TTY_DRIVER_REAL_RAW |
 			TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(serial_driver)) {
@@ -3701,9 +3697,6 @@ static int __init slgt_init(void)
 		goto error;
 	}
 
-	printk(KERN_INFO "%s, tty major#%d\n",
-	       driver_name, serial_driver->major);
-
 	slgt_device_count = 0;
 	if ((rc = pci_register_driver(&pci_driver)) < 0) {
 		printk("%s pci_register_driver error=%d\n", driver_name, rc);
@@ -3711,9 +3704,6 @@ static int __init slgt_init(void)
 	}
 	pci_registered = true;
 
-	if (!slgt_device_list)
-		printk("%s no devices found\n",driver_name);
-
 	return 0;
 
 error:
-- 
2.41.0

