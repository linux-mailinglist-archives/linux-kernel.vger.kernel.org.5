Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA90A751836
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGMFfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjGMFfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:35:41 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36028213F;
        Wed, 12 Jul 2023 22:35:35 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689226533; bh=4LTcxescAGUMISMo0T83v/Ys4ejJ82HRtYMuCrAcpIg=;
        h=From:To:Cc:Subject;
        b=DzxzUh4WtWT3aHqRB7tyvUyKNZvoZEdSmfYDBQfKPkdda6ApOoCzVb+cBNt4pUXk0
         xFdrjernAUpocDlewGMbwRA+Fz2aWaUtNSEXXei30yII3uo5N33jRRLz0icirRkNM+
         kHiS0PQRomejx118qC5ulP1S92+LVgnPJevzw101AGJp2L9UN3EicmJ1en/iHabhnK
         9aPxop00w0LS6O+yDfA8F+XugVRoWCsdgub/1Y2Ez3iMU8ngZvYgjbSh+UqggYNm+T
         rFr9kvrej+MTZWttvwd8dlsZ5Ff0Sgm7Q93S3liln81nosRHhe3Gv32M5Ou0gR6QRS
         080sD3TYtFUIzkL54uIbMyLFH1SpcAriUhVgFq9gcZ0sNiiW0wUCLi5Jvix5SwTXP7
         mmjM+Ih2L7k/Ffli64kOY/6KXoRruSsRPCV2Y2dN/6h8PBAVBRXpttzmCFVUnSS5ua
         ZzVlBlh9VGyU7SDP8nQ5paV/vLeHntlxcHJ4QbLS2sXzH6H2PL6/Gz8IIf/q3fZHDT
         iIfoNrPvZmsgmuannaFMi2UIdGhiAIpPXzNUwsW2cnemjYIZZmJMK42tqdHtIeefol
         zSTD+abgNs3lDW9ev9jAxZhjsBOAUb6Gxoq+b+nfUAYYICVq4n+Uso7eltr4Jnt3Fp
         rD8yL+j0TY/IvCEQzbxbOgvM=
To:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [RESEND PATCH v2] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Thu, 13 Jul 2023 07:35:29 +0200
Message-ID: <4847336.31r3eYUQgx@alexbook>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function lsm6dsx_get_acpi_mount_matrix should return an error when ACPI
support is not enabled to allow executing iio_read_mount_matrix in the
probe function.

Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieval")

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
Changes in v2:
- Use of error codes instead of true/false

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..1a4752c95601 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
 static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
 					  struct iio_mount_matrix *orientation)
 {
-	return false;
+	return -EOPNOTSUPP;
 }
 
 #endif
@@ -2767,11 +2767,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 	}
 
 	err = lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
-	if (err) {
+	if (err == -EOPNOTSUPP)
 		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
-		if (err)
-			return err;
-	}
+
+	if (err)
+		return err;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
-- 
2.41.0







