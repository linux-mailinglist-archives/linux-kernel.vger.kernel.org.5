Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52060760D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjGYIcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjGYIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:32:47 -0400
X-Greylist: delayed 1836 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 01:32:46 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C4F10CC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ByrEm1GEP6Pto5Qfd0Av8mnGlhq3HLawewGUcZoBqWg=; b=qnKtBzndkWiwr08ddY1CvlgIan
        hkLK0Am/nbg/K1pN0RJnbMtuNnIIpB6mIT8S8W8Jub5RDMwcPaGf/6qOQQmCmL7uiKnuzJLd/VyoY
        BY6mKEeTU6GH5VlEuxAX9S46ZomtnPcQM5/LnS89iKCu+p7l+xSHqy1CihlK1EOwFhleNE3ERq/8P
        GeDjXbekrVj90JkJdLwXT5JhviD/93BNmAM0ZXkdNnDmRgKC/iQaaKu4oNvbxJw+T7m4PfbHAlRmZ
        WWkL76pEPPTubJIwyL7sSdsjouuSmvO3Q6xxX5Vughr/pqthDSwiThfSn9Pcd74F/oCU2CQQSh+RI
        Ctn74S+A==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qOCl1-008eKy-1S;
        Tue, 25 Jul 2023 10:46:59 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma_buf/sync_file: Enable signaling for fences when querying status
Date:   Tue, 25 Jul 2023 10:46:11 +0300
Message-Id: <20230725074611.3309115-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

dma_fence_get_status is not guaranteed to return valid information
on if the fence has been signaled or not if SW signaling has not
been enabled for the fence. To ensure valid information is reported,
enable SW signaling for fences before getting their status.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/dma-buf/sync_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
index af57799c86ce..57f194b8477f 100644
--- a/drivers/dma-buf/sync_file.c
+++ b/drivers/dma-buf/sync_file.c
@@ -267,6 +267,7 @@ static int sync_fill_fence_info(struct dma_fence *fence,
 	strscpy(info->driver_name, fence->ops->get_driver_name(fence),
 		sizeof(info->driver_name));
 
+	dma_fence_enable_sw_signaling(fence);
 	info->status = dma_fence_get_status(fence);
 	while (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) &&
 	       !test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
@@ -307,6 +308,7 @@ static long sync_file_ioctl_fence_info(struct sync_file *sync_file,
 	 * info->num_fences.
 	 */
 	if (!info.num_fences) {
+		dma_fence_enable_sw_signaling(sync_file->fence);
 		info.status = dma_fence_get_status(sync_file->fence);
 		goto no_fences;
 	} else {
-- 
2.40.1

