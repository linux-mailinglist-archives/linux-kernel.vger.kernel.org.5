Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB53B786B25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjHXJIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbjHXJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:08:12 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527F1986;
        Thu, 24 Aug 2023 02:08:05 -0700 (PDT)
Received: from lvc-arm12.ispras.local (unknown [83.149.199.126])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2597C40737CA;
        Thu, 24 Aug 2023 09:08:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2597C40737CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1692868083;
        bh=N5XlzFD3k304KFtxa7uCO2r9TkozkPaaQCH42q5I3xM=;
        h=From:To:Cc:Subject:Date:From;
        b=T6FZae99E62YsU3dODYMieXJSIX781qxj33KxFJlFuoRGxwC2ixI9FPkCvvqblU32
         8bwtg+/a+wfoisq+G153i13m+TGgTUNZhZAKKoeczFbTeXnhwm7HO534IFBt3Qg6Gq
         ky1pP9pzfscU9Ttomz4oTAgRLx+7ep+EfRUp9BYg=
From:   Katya Orlova <e.orlova@ispras.ru>
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc:     Katya Orlova <e.orlova@ispras.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] media: s3c-camif: Avoid inappropriate kfree()
Date:   Thu, 24 Aug 2023 12:07:25 +0300
Message-Id: <20230824090725.28148-1-e.orlova@ispras.ru>
X-Mailer: git-send-email 2.30.2
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

s3c_camif_register_video_node() works with video_device structure stored
as a field of camif_vp,
so it should not be kfreed. But there is video_device_release() on error
path that do it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
---
 drivers/media/platform/samsung/s3c-camif/camif-capture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s3c-camif/camif-capture.c b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
index 76634d242b10..79c8ee845c38 100644
--- a/drivers/media/platform/samsung/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
@@ -1172,7 +1172,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
 err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
-- 
2.30.2

