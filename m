Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FFF7AB15E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjIVL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjIVL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:56:55 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923CFFB;
        Fri, 22 Sep 2023 04:56:49 -0700 (PDT)
Received: from lvc-arm12.ispras.local (unknown [83.149.199.126])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2AFB240F1DD0;
        Fri, 22 Sep 2023 11:56:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2AFB240F1DD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1695383806;
        bh=SE6fA2idjLIZRf601bVOTNV7dILKGQcrW7n3pawq5Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YL1IYvbHC4mavQvedeRBKW1LDWAdc/HOnv/hn+8nhNRO+J/InbHmmR7FrNKMf+ypi
         tz0XVQJA+QhcDfMeyoU5362ClLqTb3HONeMQdWb5TvU/UKNCFZo0tvDvNW7JMe17bC
         7DPdpS3S6noddRHESh1waEiX+p/OvxD6dit0WlPA=
From:   Katya Orlova <e.orlova@ispras.ru>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Katya Orlova <e.orlova@ispras.ru>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH v2] media: s3c-camif: Avoid inappropriate kfree()
Date:   Fri, 22 Sep 2023 14:55:06 +0300
Message-Id: <20230922115506.30024-1-e.orlova@ispras.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230903202336.qjdg6zw6otig2qdv@zenone.zhora.eu>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s3c_camif_register_video_node() works with video_device structure stored
as a field of camif_vp, so it should not be kfreed.
But there is video_device_release() on error path that do it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
---
v2: Get rid not only of video_device_release(), but of the entire
"err_vd_rel" goto label, as Andi Shyti <andi.shyti@kernel.org> suggested.
 drivers/media/platform/samsung/s3c-camif/camif-capture.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/samsung/s3c-camif/camif-capture.c b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
index 76634d242b10..0f5b3845d7b9 100644
--- a/drivers/media/platform/samsung/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
@@ -1133,12 +1133,12 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 
 	ret = vb2_queue_init(q);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	vp->pad.flags = MEDIA_PAD_FL_SINK;
 	ret = media_entity_pads_init(&vfd->entity, 1, &vp->pad);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	video_set_drvdata(vfd, vp);
 
@@ -1171,8 +1171,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 	v4l2_ctrl_handler_free(&vp->ctrl_handler);
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
-err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
-- 
2.30.2

