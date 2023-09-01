Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA40078FCCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349309AbjIAL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjIAL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:59:39 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCDB5;
        Fri,  1 Sep 2023 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=82s4PgqqjkSaAV1kmPay2gHbf4LxcU+PhERxGRXglyY=; b=tZ4P3rFMqyggZouvB0nG1W9bbB
        xn5W+66060KAOKAaojla1xNETgR6Ds57R27A4C0eYmYMwIqSdKZSzI5aNUDWVgpspUTLs1XUI332r
        W1WH8e480Ct88HehCUMAk0+sJtSfHiU5/ssAPBdyH25TGIdPuscn+X5dQGvi0OuRCskKzgvt83l2Z
        6ckwgtZnhqLGb5Q97PxnqivqDf/jXIl7W4zpolThUOveUbReNqlCVmHJ+PUFDoFdpY41pnMO3vK1f
        fYj4FJRdNEo2wW3tA43PvHGUWe+fZ7JhrKZjahbB+y7T7f8h0we7BjPoFqoYnqWisx9Axb5V/sD8d
        MluTxiZw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <cyndis@kapsi.fi>)
        id 1qc2oG-008yBF-06;
        Fri, 01 Sep 2023 14:59:32 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Johnny Liu <johnliu@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpu: host1x: Correct allocated size for contexts
Date:   Fri,  1 Sep 2023 14:59:09 +0300
Message-ID: <20230901115910.701518-1-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johnny Liu <johnliu@nvidia.com>

Original implementation over allocates the memory size for the
contexts list. The size of memory for the contexts list is based
on the number of iommu groups specified in the device tree.

Fixes: 8aa5bcb61612 ("gpu: host1x: Add context device management code")
Signed-off-by: Johnny Liu <johnliu@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/host1x/context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index a3f336edd991..955c971c528d 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -34,10 +34,10 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	if (err < 0)
 		return 0;
 
-	cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
+	cdl->len = err / 4;
+	cdl->devs = kcalloc(cdl->len, sizeof(*cdl->devs), GFP_KERNEL);
 	if (!cdl->devs)
 		return -ENOMEM;
-	cdl->len = err / 4;
 
 	for (i = 0; i < cdl->len; i++) {
 		ctx = &cdl->devs[i];
-- 
2.41.0

