Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75F799496
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbjIIAjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjIIAjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6807926BF;
        Fri,  8 Sep 2023 17:38:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4309AC433CD;
        Sat,  9 Sep 2023 00:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219901;
        bh=8Y9/Q46EDXsYGJ9s+d4vStc40jj5nKadX33sDIrDYM8=;
        h=From:To:Cc:Subject:Date:From;
        b=s7exa4SNWsAUMO0LjsoApVQndOuksmd9cvscDQXvb8h0WjXcnBgCl9/mRfhdzbLnH
         /PpCP6SsPprBZDyWrhjmddJTOLINSq2pa7WoyvvtjpErpLQlx6KI8dCf3blix5b7Ic
         82A1yS0zUK7tG2aimT3RHj03LVF3lTSX9vcfE4eE+uuXPr0IO7dF5Eeym/9XQRIH9F
         Vpd2OCq16zXD/RaH79EhD9H26hXgb0QiITa/tTgvFeNC9azDCUDuYwJaSGJ/e5YyLC
         +JOBdljilVt2jf5nHcYzle3VWEfZY5fh9gqHZ85gShUOF7QY3tmDFvM+cJ1EA4sX0v
         ncFelbNL1l6DQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        krzysztof.kozlowski@linaro.org, sunke32@huawei.com, drv@mailo.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 01/24] media: mdp3: Fix resource leaks in of_find_device_by_node
Date:   Fri,  8 Sep 2023 20:37:53 -0400
Message-Id: <20230909003818.3580081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit 35ca8ce495366909b4c2e701d1356570dd40c4e2 ]

Use put_device to release the object get through of_find_device_by_node,
avoiding resource leaks.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index 7bc05f42a23c1..9a3f46c1f6ba3 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -775,11 +775,13 @@ static int mdp_get_subsys_id(struct device *dev, struct device_node *node,
 	ret = cmdq_dev_get_client_reg(&comp_pdev->dev, &cmdq_reg, index);
 	if (ret != 0) {
 		dev_err(&comp_pdev->dev, "cmdq_dev_get_subsys fail!\n");
+		put_device(&comp_pdev->dev);
 		return -EINVAL;
 	}
 
 	comp->subsys_id = cmdq_reg.subsys;
 	dev_dbg(&comp_pdev->dev, "subsys id=%d\n", cmdq_reg.subsys);
+	put_device(&comp_pdev->dev);
 
 	return 0;
 }
-- 
2.40.1

