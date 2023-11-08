Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC917E54D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjKHLP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjKHLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:15:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D632119B3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:15:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E732C433C8;
        Wed,  8 Nov 2023 11:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699442154;
        bh=9vSG7HGCOMlTVvwxD3z5KGQGOs/uBAQpqQz6PsNzUOc=;
        h=From:To:Cc:Subject:Date:From;
        b=KELedhSb1ggZIE5lSHcxdyePAcQohLzvKDPj1AfkXtcO+iEvN41Z56Tsiie86P1s6
         YXyTaRL/8dV2BNl/ECqEPUvQuXNVv90Oaffelbsp/MMJFDv2TJw2uL4vuXzUCKtnNo
         7iSoAGbC73dffDoE7zOD0YFbad5D9uvgackPTs0iUrq/MWEevnRdILKBspDQufTUdN
         gVFJRNCIJcFtbWtSOOY01/IicBipWofNuij+tzQ46LGKap1imtzYD7SB3+G1hLGfGT
         WcM3z8ZVg9x9n3CJ42bPf34mShn8O67Ur64PvLG4jvfPoBPBGclczSM35acpyU+owq
         9sl7FFTTDWS2w==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] firmware: arm_ffa: Fix ffa_notification_info_get() IDs handling
Date:   Wed,  8 Nov 2023 12:15:49 +0100
Message-Id: <20231108111549.155974-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To parse the retrieved ID lists appropriately in
ffa_notification_info_get() the ids_processed variable should not
be pre-incremented - we are dropping an identifier at the
beginning of the list.

Fix it by using the post-increment operator to increment the number
of processed IDs.

Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 07b72c679247..ccf91a795c3d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -782,7 +782,7 @@ static void ffa_notification_info_get(void)
 			if (ids_processed >= max_ids - 1)
 				break;
 
-			part_id = packed_id_list[++ids_processed];
+			part_id = packed_id_list[ids_processed++];
 
 			if (!ids_count[list]) { /* Global Notification */
 				__do_sched_recv_cb(part_id, 0, false);
@@ -794,7 +794,7 @@ static void ffa_notification_info_get(void)
 				if (ids_processed >= max_ids - 1)
 					break;
 
-				vcpu_id = packed_id_list[++ids_processed];
+				vcpu_id = packed_id_list[ids_processed++];
 
 				__do_sched_recv_cb(part_id, vcpu_id, true);
 			}
-- 
2.34.1

