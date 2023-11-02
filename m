Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFEA7DF4AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376764AbjKBOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:11:58 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FA2130;
        Thu,  2 Nov 2023 07:11:53 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 85B50186AD92;
        Thu,  2 Nov 2023 17:11:50 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 360raSQFcQ7t; Thu,  2 Nov 2023 17:11:50 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 2C583186AD72;
        Thu,  2 Nov 2023 17:11:50 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g0_ELJrllrsB; Thu,  2 Nov 2023 17:11:50 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.237.131])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 42ED2186AD74;
        Thu,  2 Nov 2023 17:11:47 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lvc-project@linuxtesting.org
Subject: [PATCH 2/4] Remove redundant return value check
Date:   Thu,  2 Nov 2023 17:11:33 +0300
Message-Id: <20231102141135.369-2-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231102141135.369-1-adiupina@astralinux.ru>
References: <20231102141135.369-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

media_entity_pads_init() will not return 0 only if the
2nd parameter >=3D MEDIA_ENTITY_MAX_PADS (512), but 1 is
passed, so checking the return value is redundant

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/media/i2c/rdacm20.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
index f4e2e2f3972a..ed249ade54e0 100644
--- a/drivers/media/i2c/rdacm20.c
+++ b/drivers/media/i2c/rdacm20.c
@@ -611,9 +611,7 @@ static int rdacm20_probe(struct i2c_client *client)
=20
 	dev->pad.flags =3D MEDIA_PAD_FL_SOURCE;
 	dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
-	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret < 0)
-		goto error_free_ctrls;
+	media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
=20
 	ret =3D v4l2_async_register_subdev(&dev->sd);
 	if (ret)
--=20
2.30.2

