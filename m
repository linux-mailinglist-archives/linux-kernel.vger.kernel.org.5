Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967B7D5139
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjJXNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJXNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:16:58 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 06:16:53 PDT
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8CC2;
        Tue, 24 Oct 2023 06:16:53 -0700 (PDT)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1698152956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hXmr2tFx6UpqbD02yGf2BN9YhkOrEZYGzBXYckcZFSs=;
        b=L8xQxTygCr/5WGn6hUiQF+9uJAo1fbJO4Qqu9OIoSozVN/Fiuoaw3vA+mrkeUXSuKChb4p
        IUNB0Z8sVPN1vvf9RrosmqdifQ44gJinOEoArbp0P9wan8uRVgtgpJJq/TUULhbJCwHnpL
        yMLFN5NE+d1hIANTIfl2BQ4pPVjxy4Q=
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] media: marvell: Added function return value check clk_prepare
Date:   Tue, 24 Oct 2023 16:09:16 +0300
Message-Id: <20231024130916.19419-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Return value of function 'clk_prepare', called at mcam-core.c:905,
	is not checked, but it is usually checked for this function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/media/platform/marvell/mcam-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/marvell/mcam-core.c b/drivers/media/platform/marvell/mcam-core.c
index 66688b4aece5..afb7f4009d96 100644
--- a/drivers/media/platform/marvell/mcam-core.c
+++ b/drivers/media/platform/marvell/mcam-core.c
@@ -901,9 +901,10 @@ static void mcam_ctlr_power_down(struct mcam_camera *cam)
 static int mclk_prepare(struct clk_hw *hw)
 {
 	struct mcam_camera *cam = container_of(hw, struct mcam_camera, mclk_hw);
-
-	clk_prepare(cam->clk[0]);
-	return 0;
+	int ret;
+
+	ret = clk_prepare(cam->clk[0]);
+	return ret;
 }
 
 static void mclk_unprepare(struct clk_hw *hw)
-- 
2.25.1

