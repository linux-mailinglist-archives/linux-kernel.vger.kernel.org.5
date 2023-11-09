Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB867E6CC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjKIPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjKIPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:00:50 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03735325B;
        Thu,  9 Nov 2023 07:00:46 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 5E9311868B41;
        Thu,  9 Nov 2023 18:00:44 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Twr-pb2i9k6j; Thu,  9 Nov 2023 18:00:44 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id EA2C7186505E;
        Thu,  9 Nov 2023 18:00:43 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6HsWk-nAyshQ; Thu,  9 Nov 2023 18:00:43 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.14.192])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 6F18D18633F8;
        Thu,  9 Nov 2023 18:00:42 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     stable@vger.kernel.org,
        "Greg Kroah-Hartman ." <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        lvc-project@linuxtesting.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10/5.15 1/1] media: atomisp: add error checking to atomisp_create_pipes_stream()
Date:   Thu,  9 Nov 2023 18:00:01 +0300
Message-Id: <20231109150001.22891-2-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231109150001.22891-1-abelova@astralinux.ru>
References: <20231109150001.22891-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 798d2ad739da5343122eff386578f259278f2594 upstream.

The functions called by atomisp_create_pipes_stream() can fail,
add error checking for them.

Link: https://lore.kernel.org/linux-media/20220615205037.16549-35-hdegoed=
e@redhat.com
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 .../media/atomisp/pci/atomisp_compat.h        |  2 +-
 .../media/atomisp/pci/atomisp_compat_css20.c  | 20 ++++++++++++++++---
 .../staging/media/atomisp/pci/atomisp_ioctl.c | 13 ++++++++++--
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat.h b/drivers=
/staging/media/atomisp/pci/atomisp_compat.h
index c16eaf3d126f..75c978c4e6f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat.h
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat.h
@@ -242,7 +242,7 @@ int atomisp_css_input_configure_port(struct atomisp_s=
ub_device *asd,
 				     unsigned int metadata_width,
 				     unsigned int metadata_height);
=20
-void atomisp_create_pipes_stream(struct atomisp_sub_device *asd);
+int atomisp_create_pipes_stream(struct atomisp_sub_device *asd);
 void atomisp_destroy_pipes_stream_force(struct atomisp_sub_device *asd);
=20
 void atomisp_css_stop(struct atomisp_sub_device *asd,
diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/d=
rivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 99a632f33d2d..f64d73b4c4b7 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -795,10 +795,24 @@ static int __create_pipes(struct atomisp_sub_device=
 *asd)
 	return -EINVAL;
 }
=20
-void atomisp_create_pipes_stream(struct atomisp_sub_device *asd)
+int atomisp_create_pipes_stream(struct atomisp_sub_device *asd)
 {
-	__create_pipes(asd);
-	__create_streams(asd);
+	int ret;
+
+	ret =3D __create_pipes(asd);
+	if (ret) {
+		dev_err(asd->isp->dev, "create pipe failed %d.\n", ret);
+		return ret;
+	}
+
+	ret =3D __create_streams(asd);
+	if (ret) {
+		dev_warn(asd->isp->dev, "create stream failed %d.\n", ret);
+		__destroy_pipes(asd, true);
+		return ret;
+	}
+
+	return 0;
 }
=20
 int atomisp_css_update_stream(struct atomisp_sub_device *asd)
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/=
staging/media/atomisp/pci/atomisp_ioctl.c
index b7dda4b96d49..06bb1c87c814 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -2243,8 +2243,17 @@ int __atomisp_streamoff(struct file *file, void *f=
h, enum v4l2_buf_type type)
 		dev_err(isp->dev, "atomisp_reset");
 		atomisp_reset(isp);
 		for (i =3D 0; i < isp->num_of_streams; i++) {
-			if (recreate_streams[i])
-				atomisp_create_pipes_stream(&isp->asd[i]);
+			if (recreate_streams[i]) {
+				int ret2;
+
+				ret2 =3D atomisp_create_pipes_stream(&isp->asd[i]);
+				if (ret2) {
+					dev_err(isp->dev, "%s error re-creating streams: %d\n",
+						__func__, ret2);
+					if (!ret)
+						ret =3D ret2;
+				}
+			}
 		}
 		isp->isp_timeout =3D false;
 	}
--=20
2.30.2

