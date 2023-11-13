Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6C7EA696
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjKMXEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKMXE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:04:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D7BD68
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:04:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DBBC433C7;
        Mon, 13 Nov 2023 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699916664;
        bh=PtRFUSAAq48UomziqLaEJ6jUBMz1qgN3VFvFSPG959c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQsGB/JEWouZgDVrFnuKdeYzo1Gx2/PmNRF4qV41wqSwUXoEqKa04vRPz5u5b+oUu
         Zu++Z4jlLOzlUdgIX7N5qLB+3pQkXQFoPp7H5EHYo28gGrETC2w8aBtxe5sxEwaZ4J
         KZVYaGkKR4jn4kdmtJuwv9odSCaqn6pPlTX4HgAOBUV2C+jU6+gim+3q5PCkwBxW95
         HcI/j1tBTF0XxkQ/V102K4T66l9GHs3Z76i1hcgVyAJVnR7LGM1gqsqOc59LF2AEco
         jaUqkNsdOENTk140215smcZmxWt6Sz170Jl2RBeuPC8+7pMI9MW60qEKkd+ka9kxSE
         A4oMO+B0B7w0Q==
Received: by mercury (Postfix, from userid 1000)
        id 30730106323F; Tue, 14 Nov 2023 00:04:22 +0100 (CET)
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
Subject: [PATCH v4 4/6] media: v4l: async: Fix duplicated list deletion
Date:   Mon, 13 Nov 2023 23:57:23 +0100
Message-ID: <20231113230421.226808-5-sre@kernel.org>
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

The list deletion call dropped here is already called from the
helper function in the line before. Having a second list_del()
call results in either a warning (with CONFIG_DEBUG_LIST=y):

list_del corruption, c46c8198->next is LIST_POISON1 (00000100)

If CONFIG_DEBUG_LIST is disabled the operation results in a
kernel error due to NULL pointer dereference.

Fixes: 28a1295795d8 ("media: v4l: async: Allow multiple connections between entities")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 091e8cf4114b..8cfd593d293d 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -880,7 +880,6 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 				  &asc->notifier->waiting_list);
 
 			v4l2_async_unbind_subdev_one(asc->notifier, asc);
-			list_del(&asc->asc_subdev_entry);
 		}
 	}
 
-- 
2.42.0

