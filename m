Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B087D293C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjJWEGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:06:21 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4FCCBD52;
        Sun, 22 Oct 2023 21:06:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0C07460106CE6;
        Mon, 23 Oct 2023 12:06:10 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Jonathan.Cameron@Huawei.com, jic23@kernel.org, lars@metafoo.de
Cc:     Su Hui <suhui@nfschina.com>, jean-baptiste.maneyrol@tdk.com,
        andy.shevchenko@gmail.com, chenhuiz@axis.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw
Date:   Mon, 23 Oct 2023 12:05:52 +0800
Message-Id: <20231023040551.68902-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
true value rather than only return IIO_VAL_INT.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - fix the error of commit title.
v1: 
 - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 29f906c884bd..a9a5fb266ef1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 
 		default:
 			return -EINVAL;
-- 
2.30.2

