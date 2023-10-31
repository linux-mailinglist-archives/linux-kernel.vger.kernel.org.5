Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6E7DC73D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbjJaHZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343781AbjJaHZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:25:40 -0400
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 00:25:21 PDT
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B87AFD69;
        Tue, 31 Oct 2023 00:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SJWU5
        tnjso1vDAK736GkMoFEm3BXg8uhBy9G73LcJvU=; b=J9Q0LIkiiwv/VssVaKp3e
        vXr/+9DXZSnlshaZwntbXD0UtypAGWdOLzJG001ilaLfHUIT9x+pGVNED2Aei0fJ
        HZWPhCNKzECaAxBQT9tYmDejmv2RA+Qq0n4htosaxWi9BAqlfv1M/pW+PdpJHUhd
        9TTo8OhyXPGGXNrMwXD1iI=
Received: from leanderwang-LC4.localdomain (unknown [111.206.145.21])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wDXP+6wq0Blv5KVAQ--.8863S3;
        Tue, 31 Oct 2023 15:24:32 +0800 (CST)
From:   Zheng Wang <zyytlz.wz@163.com>
To:     dmitry.osipenko@collabora.com
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org,
        Zheng Wang <zyytlz.wz@163.com>
Subject: [PATCH v2 1/3] media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to  avoid the crash of multi-core JPEG devices
Date:   Tue, 31 Oct 2023 15:24:27 +0800
Message-Id: <20231031072429.21448-2-zyytlz.wz@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031072429.21448-1-zyytlz.wz@163.com>
References: <20231031072429.21448-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXP+6wq0Blv5KVAQ--.8863S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4rtF48tF1UJF4fZr4xWFg_yoW8Gr45pF
        WfK348CrWUGF4qgryDAa47ZFy5Gwnaya40gr47uwn2q393XF47t34jya4FqFWxXF9rCFy3
        tF1FvryfWF4jvFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNBMNUUUUU=
X-Originating-IP: [111.206.145.21]
X-CM-SenderInfo: h2113zf2oz6qqrwthudrp/xtbBzhQaU2I0bIocowAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverts commit c677d7ae8314
("media: mtk-jpeg: Fix use after free bug due to uncanceled work").
The job_timeout_work is initialized only for
the single-core JPEG device so it will cause the crash for multi-core
JPEG devices.

Fix it by removing the cancel_delayed_work_sync function.

Fixes: c677d7ae8314 ("media: mtk-jpeg: Fix use after free bug due to uncanceled work")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
v2:
- put the patches into a single series suggested by Dmitry
---
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 7194f88edc0f..60425c99a2b8 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1403,7 +1403,6 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
-	cancel_delayed_work_sync(&jpeg->job_timeout_work);
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
-- 
2.25.1

