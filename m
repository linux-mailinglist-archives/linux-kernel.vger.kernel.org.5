Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263F9764449
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjG0DXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjG0DX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:23:28 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB11FFC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 20:23:26 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBGHh59x2zLns3;
        Thu, 27 Jul 2023 11:20:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 11:23:23 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <robdclark@gmail.com>, <quic_abhinavk@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <marijn.suijten@somainline.org>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <quic_jesszhan@quicinc.com>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] drm/msm: Remove redundant DRM_DEV_ERROR()
Date:   Thu, 27 Jul 2023 11:24:07 +0000
Message-ID: <20230727112407.2916029-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to call the DRM_DEV_ERROR() function directly to print
a custom message when handling an error from platform_get_irq() function
as it is going to display an appropriate error message
in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 1 -
 drivers/gpu/drm/msm/msm_gpu.c            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index b6201ae5b42e..700df4040e9a 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -417,7 +417,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		DRM_DEV_ERROR(dev->dev, "failed to get irq: %d\n", ret);
 		goto fail;
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 52db90e34ead..8a9bacc920eb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -897,7 +897,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->irq = platform_get_irq(pdev, 0);
 	if (gpu->irq < 0) {
 		ret = gpu->irq;
-		DRM_DEV_ERROR(drm->dev, "failed to get irq: %d\n", ret);
 		goto fail;
 	}
 
-- 
2.34.1

