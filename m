Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DAB75154B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjGMAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjGMAan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:30:43 -0400
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9B1FF5;
        Wed, 12 Jul 2023 17:30:41 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689208234; bh=OqvMagDHrs9sGhzHEnKv1/CpHc2sIgYQxc++nItrEtU=;
        h=From:To:Cc:Subject;
        b=gXGkKF+F71ogzf/2taKOshImmn61+Rct6eaD8Yuijekx/aj2OLxUtOkoVC2Z5d4V+
         kiw0OsAKWaYsk+obUhQCC9bfhmn4dl0JN95FW6zzyEW0J+NXGXJVaFDof5jKhrirDh
         ozH58IGZthpyx2F3WNSkG67GVV0/WBkvISTOLXPb6Ht7nBTZt5G2J0RezJ4TIXv5xm
         douxSHt++6oxFHUEzz2Rx1eluNhgAcjJF8iFT30fGrTAWqORCBfLgG1N6zcPObpoSM
         Yykwqy+6aw+5HY+uYuRUR9C+sbRVLpkC8RVBKAAiqxwfxpcKg8arJMINdSEaxMi66d
         kU8MSWoDsqBo39kkFtnlmPPvbGPOIII8EImwce6liR7qWKZdbEk7wJ913sbNnIdYuL
         iZs1cNHLIqg/fReYAPn4TfTHhzpYvh2XrOFSmHcZz2Lo/BkR3wG1sxXQistFXqHCRQ
         +te1ekxYxJgq9eIXYteq3zER5n3jjadkyKeyrZxu+jaIvpRbYKSDwmqwOMn6FeMOMW
         oXa7UgilBbRmL28Tj3FY3JVcRXKbtNBrc3EGy9kL4L0j1lHa43YMWBh6nzxqddNQqM
         dNqDnxKBQDIg3rrlwTdwqTr38SLTTH3i3HghLrnersA+zHch8MTUjjxL2KYmm78UYB
         0vSe4cPKRjHEIkjtbf9zCZCI=
To:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Thu, 13 Jul 2023 02:28:34 +0200
Message-ID: <5690549.31r3eYUQgx@alexpc>
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
- Use of error codes instead of true/false. 
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/
st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..1a4752c95601 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct device 
*dev,
 static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
 					  struct iio_mount_matrix 
*orientation)
 {
-	return false;
+	return -EOPNOTSUPP;
 }
 
 #endif
@@ -2767,11 +2767,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int 
hw_id,
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




