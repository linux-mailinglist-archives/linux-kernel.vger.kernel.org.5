Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EAA753EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjGNPdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjGNPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:33:47 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0542D79;
        Fri, 14 Jul 2023 08:33:44 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689348822; bh=tLyxCNmWIwYWdSdGf5y1A1OsDIoHBB6G7QnsWU5njsY=;
        h=From:To:Cc:Subject;
        b=QdOmk1/qtN3GaspEr5GT9PDVJxrE7ymkcV5fDpBmsF+pqmUPtdSLglfqzSBDwEbq5
         KqX0pOM+TMoNuiHkXFCQCEMYLQPMPKS/4wKFuW7TDnELC/m4Nmkyqp7SfWUMjY/gkR
         YIx/WGqu1Qny/tXkzp2ca78sG7z7RXT+h+5bNQe+zmnT9vwK6or+F7fclH5V8ybBaG
         2zBix2Y+QjIxw1KnVmrMfNJBcrFn2R7rUEmLrC1Rhvv1nbtFzp7U59nKLyNVCzmI+I
         4pAOSMXqELFVpwJ7W6ODJ3DPhxx+1H20w6Yk22X08Az2P8DntdRjFEpu1q9qz2tKZ8
         26XMf4xYTgnZ5mX1icafnMohlY5z5nGfn8UzTXDp+50qlVw0eXj4/2mGcrXMZlW3ZK
         yieSuRpmsK05rGeUe9PiffsJnjnEYGG7utdpV33SUoYO1wkvpJaCZBFytRSaAGrPAT
         5Ca/3Rlv/MD+f7BdLDHqebFq4Y3/oZ+HhN24tV/tFXfDrESil8aRpGikSfaaHCyjgE
         4AjEcNrd+O8GAouvjkIr8odKTcbLBIcKJ2NehUvAzAAVIaueblDgCW3aV5j0QYL/AZ
         eLU2LKTOxeye3CIutTJRCkUuWImVISqSYAblP+5zx53ILNrubrkRVTzXGsn7IdNDCH
         N0+RC67o0LM71HFBOWkgud/o=
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Fri, 14 Jul 2023 17:31:26 +0200
Message-ID: <20230714153132.27265-1-atafalla@dnyon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v3:
- Removed unneeded check for err == -EOPNOTSUPP.

Changes in v2:
- Use of error codes instead of true/false

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..b6e6b1df8a61 100644
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
-- 
2.41.0

