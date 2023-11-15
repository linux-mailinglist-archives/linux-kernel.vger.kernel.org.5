Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D639C7EC8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjKOQjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjKOQjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412C181
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D4CC433C8;
        Wed, 15 Nov 2023 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066368;
        bh=exKYJcOqE7PAuCguPkuv8mAJu56vWsUJCYEBl4ctl6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3HR+gVGFqu0vVmFFLsLi6cHtZ8Jb2lvPyuWJmDx9KCYdiSnWppVoyrZdcX/xOoio
         xhK1BicgbAqrEjdyI8x95IuviXOVX8ZeRGn5eBjumWTtXODIuNpZkEKg17Bkr7t41Z
         mrX7Bf5mPU+j/ZbD715h7vd0Bi5lYFWNNiKSSbPSxww6r/K6+5TrcuonS8zyUmMQm8
         zMJgongjUWJsXNCMYaunSPZEUSLQKQEN3riWs111z1cFYCE0Y70TEvrLCOl1DErBaj
         Aj80uJgu2mBoCXNztCZa4TgMyls1nu2cVD4ZGZl/CQOJhp0GNEg4h6LQL7TtMDj1C8
         yDuBVdDL7I1HA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/10] accel/habanalabs: set hard reset flag if graceful reset is skipped
Date:   Wed, 15 Nov 2023 18:39:09 +0200
Message-Id: <20231115163912.1243175-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

hl_device_cond_reset() might be called with the hard reset flag unset,
because a compute reset upon device release as part of a graceful reset
is valid.
If the conditions for graceful reset are not met, hl_device_reset() will
be called for an immediate reset. In this case a compute reset is not
valid, so it will be replaced with a hard reset together with a debug
message about it.
This message might be confusing, as it implies that a compute reset was
requested when it shouldn't. To prevent this confusion, set the hard
reset flag in hl_device_cond_reset() if going to an immediate reset.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 6bf5f1d0d005..a365791a9f5c 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2040,7 +2040,7 @@ int hl_device_cond_reset(struct hl_device *hdev, u32 flags, u64 event_mask)
 	if (ctx)
 		hl_ctx_put(ctx);
 
-	return hl_device_reset(hdev, flags);
+	return hl_device_reset(hdev, flags | HL_DRV_RESET_HARD);
 }
 
 static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64 event_mask)
-- 
2.34.1

