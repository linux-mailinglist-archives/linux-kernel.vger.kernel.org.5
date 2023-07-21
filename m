Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6575C1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGUId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGUIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:33:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EAD2D4C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689928401; x=1721464401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bZTQfFErD83ZpeUe8f6tUjcWK8u+2HNM0QEJ6Cyo2s=;
  b=LpwguBTAWKOjNwnYG27VHqlnx5ZPbc8zw12789NNPJo9noS1yB1c8QjQ
   xGmHpknYGDVW4nwEpHFbW1cF/QLVKbxj+MY76+hqkq2heHDfmHRvB0f6C
   55TbxX1CCJRf5TUtO/4EpV8CJDFp9gKMlUAEkkq9BjoekZnF9widRPUcB
   GxG1xC1EEwn9cexnWCBN37r8+Ayv7gM1fqtCDIY4Pe5EAs/h/+EaCc5vo
   BJwYxF0kRic4q2DvkYw6a3oPNRZ9oxfiLhxkmkVUJFZJ6/jSTY/fIG7nA
   u5t2irfb8lj61KCJFoBmU1kwBMgTQY0ydjgOrTl3ifxdrd9onMIagqqK/
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684792800"; 
   d="scan'208";a="32048649"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2023 10:33:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 267F0280078;
        Fri, 21 Jul 2023 10:33:19 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND 1/2] drm: fsl-dcu: Use dev_err_probe
Date:   Fri, 21 Jul 2023 10:33:13 +0200
Message-Id: <20230721083314.1190614-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl_dcu_drm_modeset_init can return -EPROBE_DEFER, so use dev_err_probe
to remove an invalid error message and add it to deferral description.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index a395f93449f3..90cbd18f096d 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -103,10 +103,8 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
 	int ret;
 
 	ret = fsl_dcu_drm_modeset_init(fsl_dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to initialize mode setting\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev->dev, ret, "failed to initialize mode setting\n");
 
 	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
 	if (ret < 0) {
-- 
2.34.1

