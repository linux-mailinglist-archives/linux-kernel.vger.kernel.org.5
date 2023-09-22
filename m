Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335807AAB83
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjIVIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjIVIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:05:35 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA000E55
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=WAAxDZzPxYcCGm21BNyqSjh4x8SKsO8gvU5+0ZgsA/8=; b=T0UiFe
        q1th/GBTpGw+oKYS2+mS4LDfO9FUIzWlVBdF9TuuuVVP/qtjLSD41biuOPvvs+jn
        kEM74tbnZhqk1R44Nuk3Ap7SF+Gpim+aVxCl254VJe+dxzHAFFgqFcLidWWMtrzg
        F2rD8oq8dYrowr2XWsN+xOhjSHVz/Pol2tiJtt0AM9SXRf5CinVLQyl7rFgD54HL
        qErJ9iAml7MI4+RJdslcVhoiTDVsMnh8vlClBpqv0FJR2TUR+TTKxieo/vbHNrnA
        TpGkb1aaYAPhoP+x81twW0AOadF7Bps6jRCdNLHHvYQO/Jr5G/9WjnYxX112rQSC
        FjRgIk8qD/0e59dA==
Received: (qmail 1310933 invoked from network); 22 Sep 2023 10:04:28 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 10:04:28 +0200
X-UD-Smtp-Session: l3s3148p1@GEnEDu4FdMIujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] media: i2c: drop check because i2c_unregister_device() is NULL safe
Date:   Fri, 22 Sep 2023 10:04:19 +0200
Message-Id: <20230922080421.35145-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to check the argument of i2c_unregister_device() because the
function itself does it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Build tested only. Please apply to your tree.

 drivers/media/i2c/rdacm20.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index f4e2e2f3972a..b4647bda8c21 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -625,8 +625,7 @@ static int rdacm20_probe(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&dev->ctrls);
 error:
 	media_entity_cleanup(&dev->sd.entity);
-	if (dev->sensor)
-		i2c_unregister_device(dev->sensor);
+	i2c_unregister_device(dev->sensor);
 
 	dev_err(&client->dev, "probe failed\n");
 
-- 
2.30.2

