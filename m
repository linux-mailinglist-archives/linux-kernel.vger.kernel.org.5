Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8027993B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbjIIAhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjIIAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:37:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E542698;
        Fri,  8 Sep 2023 17:36:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DD3C433C7;
        Sat,  9 Sep 2023 00:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219767;
        bh=guUZwgwpptycEhh1UBHNkj0x7bnqCz7pkwBOOnAQXcs=;
        h=From:To:Cc:Subject:Date:From;
        b=lps+1660wPoW5Noj5R6wns2MCbjAaVEQoUfyntA4jxAzVf02vUE13GvUoyv0rdttc
         pOm2xZuQMW0gSn9W9xS9beH+kf71qusDQ4FQoCo1e++o8VYi904R77APd5sfCrsBWT
         p/LfOIDEydOMa6Hv2o+4sXaz4pbyrH9/sc6murhs3W1gMEoOR4VMjepXAYwM0aXFbM
         +uGYOv01zalup7fgJZoC+VIvzt0rv5ECH3h1MayzP+SGx1uk4EN7jb/HeicK3uuYTD
         YZ19se4gzV9PkL+2wowpL1/QIGLoxxhitvcx7WFfWRgFNsC8C7v0GhA+hqWfaPMK2v
         Zs4h/CVS3xG1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        sakari.ailus@linux.intel.com, sunke32@huawei.com, arnd@arndb.de,
        drv@mailo.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 01/28] media: mdp3: Fix resource leaks in of_find_device_by_node
Date:   Fri,  8 Sep 2023 20:35:35 -0400
Message-Id: <20230909003604.3579407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index a605e80c7dc36..b0ca2b3a8a739 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -892,11 +892,13 @@ static int mdp_get_subsys_id(struct mdp_dev *mdp, struct device *dev,
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

