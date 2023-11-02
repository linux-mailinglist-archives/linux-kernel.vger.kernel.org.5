Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F7E7DF4AC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376770AbjKBOMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjKBOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:11:58 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642EB7;
        Thu,  2 Nov 2023 07:11:52 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 92E0C186AD7F;
        Thu,  2 Nov 2023 17:11:47 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Fb5gFKlPjCnD; Thu,  2 Nov 2023 17:11:47 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 2C2A6186AD7D;
        Thu,  2 Nov 2023 17:11:47 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NxnAeH7SuxPo; Thu,  2 Nov 2023 17:11:47 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.237.131])
        by mail.astralinux.ru (Postfix) with ESMTPSA id C627C186AD74;
        Thu,  2 Nov 2023 17:11:45 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH 1/4] Remove redundant return value check
Date:   Thu,  2 Nov 2023 17:11:32 +0300
Message-Id: <20231102141135.369-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
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

Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 4 +---
 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 6 +-----
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 --
 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 --
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers=
/staging/media/atomisp/i2c/atomisp-gc2235.c
index 9fa390fbc5f3..f10931a03285 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
@@ -840,9 +840,7 @@ static int gc2235_probe(struct i2c_client *client)
 	dev->ctrl_handler.lock =3D &dev->input_lock;
 	dev->sd.ctrl_handler =3D &dev->ctrl_handler;
=20
-	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret)
-		gc2235_remove(client);
+	media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
=20
 	return atomisp_register_i2c_module(&dev->sd, gcpdev, RAW_CAMERA);
=20
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c b/driver=
s/staging/media/atomisp/i2c/atomisp-mt9m114.c
index 1c6643c442ef..b7a940fdbd0a 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
@@ -1581,11 +1581,7 @@ static int mt9m114_probe(struct i2c_client *client=
)
=20
 	/* REVISIT: Do we need media controller? */
 	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret) {
-		mt9m114_remove(client);
-		return ret;
-	}
-	return 0;
+	return ret;
 }
=20
 static const struct acpi_device_id mt9m114_acpi_match[] =3D {
diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c b/drivers=
/staging/media/atomisp/i2c/atomisp-ov2722.c
index 6a72691ed5b7..922774293bf4 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
@@ -993,8 +993,6 @@ static int ov2722_probe(struct i2c_client *client)
 	dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
=20
 	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret)
-		ov2722_remove(client);
=20
 	return atomisp_register_i2c_module(&dev->sd, ovpdev, RAW_CAMERA);
=20
diff --git a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c b/=
drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
index 460a4e34c55b..8d5b74fb5d9c 100644
--- a/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
+++ b/drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c
@@ -1733,8 +1733,6 @@ static int ov5693_probe(struct i2c_client *client)
 	dev->sd.ctrl_handler =3D &dev->ctrl_handler;
=20
 	ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
-	if (ret)
-		ov5693_remove(client);
=20
 	return ret;
 out_free:
--=20
2.30.2

