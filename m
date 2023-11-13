Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28F7EA69E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjKMXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjKMXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:04:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5804D48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:04:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2347CC433C9;
        Mon, 13 Nov 2023 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916667;
        bh=zgSX9vFpMcVmLhIltMi1/nDB0fG5nWoN7nvBlrOL3Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbmSPI1TV4hBxHa2KF+uRqVs2yo10cDmJCzCLje51pQnkTzElZIZM8haLdDzME93C
         WWmwflRqfGZdXRNegu4QZw5f74WKJ6ac88cmJbRpQzKVg8NLlZmNB6OqpAEHxrCSrk
         /jPZwH8aNDSq9xs9xofZslzy25Q961wqKxtSd88rxoJ2WShNV0Z2/wyyn29/dWmW7V
         HbyuthL6pxPzN3JIuNewxKffGVTS6MeH2KLEWrOa2i0q0W5RSj06t46PJTj31Bh+iX
         lrwnoY/DMM9lysA6HCODWewyL2pXO/FIv8opY44rmG5ow8+4gjaq1pvQoSfft+X+x9
         UMpUFpFUXweJQ==
Received: by mercury (Postfix, from userid 1000)
        id 335341063240; Tue, 14 Nov 2023 00:04:22 +0100 (CET)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] media: v4l: async: Drop useless list move operation
Date:   Mon, 13 Nov 2023 23:57:24 +0100
Message-ID: <20231113230421.226808-6-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113230421.226808-1-sre@kernel.org>
References: <20231113230421.226808-1-sre@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2_async_unbind_subdev_one(), which is called in the line
following the list_move() operation contains list_move_tail()
for the same entry and overrides anything list_move() did.
Thus it can be removed.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 8cfd593d293d..3ec323bd528b 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -876,9 +876,6 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 	if (sd->asc_list.next) {
 		list_for_each_entry_safe(asc, asc_tmp, &sd->asc_list,
 					 asc_subdev_entry) {
-			list_move(&asc->asc_entry,
-				  &asc->notifier->waiting_list);
-
 			v4l2_async_unbind_subdev_one(asc->notifier, asc);
 		}
 	}
-- 
2.42.0

