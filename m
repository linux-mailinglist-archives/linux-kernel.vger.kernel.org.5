Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD830778A70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjHKJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHKJ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:57:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158EB273E;
        Fri, 11 Aug 2023 02:57:05 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMfKh6b0SzTm5q;
        Fri, 11 Aug 2023 17:55:04 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:57:02 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <yuehaibing@huawei.com>,
        <jean-baptiste.maneyrol@tdk.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iio: Remove unused declarations
Date:   Fri, 11 Aug 2023 17:57:01 +0800
Message-ID: <20230811095701.35372-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0f3a8c3f34f7 ("iio: Add support for creating IIO devices via configfs")
declared but never implemented iio_sw_device_type_configfs_{un}register().
Commit b662f809d410 ("iio: core: Introduce IIO software triggers") declared but
never implemented iio_sw_trigger_type_configfs_{un}register().
Commit a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
declared but never implemented fxls8962af_core_remove().
Commit 8dedcc3eee3a ("iio: core: centralize ioctl() calls to the main chardev")
declared but never implemented iio_device_ioctl().

Commit d430f3c36ca6 ("iio: imu: inv_mpu6050: Use regmap instead of i2c specific functions")
removed inv_mpu6050_write_reg() but not its declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/iio/accel/fxls8962af.h            | 1 -
 drivers/iio/iio_core.h                    | 3 ---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 1 -
 include/linux/iio/sw_device.h             | 3 ---
 include/linux/iio/sw_trigger.h            | 3 ---
 5 files changed, 11 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
index 9cbe98c3ba9a..6eaa2803b26f 100644
--- a/drivers/iio/accel/fxls8962af.h
+++ b/drivers/iio/accel/fxls8962af.h
@@ -14,7 +14,6 @@ enum {
 };
 
 int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
-int fxls8962af_core_remove(struct device *dev);
 
 extern const struct dev_pm_ops fxls8962af_pm_ops;
 extern const struct regmap_config fxls8962af_i2c_regmap_conf;
diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 501e286702ef..1a38b1915e7a 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -30,9 +30,6 @@ struct iio_ioctl_handler {
 		      unsigned int cmd, unsigned long arg);
 };
 
-long iio_device_ioctl(struct iio_dev *indio_dev, struct file *filp,
-		      unsigned int cmd, unsigned long arg);
-
 void iio_device_ioctl_handler_register(struct iio_dev *indio_dev,
 				       struct iio_ioctl_handler *h);
 void iio_device_ioctl_handler_unregister(struct iio_ioctl_handler *h);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index ed5a96e78df0..95f548235de7 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -464,7 +464,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type);
 int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en,
 			      unsigned int mask);
-int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
index eff1e6b2595c..0f7fe7b522e3 100644
--- a/include/linux/iio/sw_device.h
+++ b/include/linux/iio/sw_device.h
@@ -51,9 +51,6 @@ void iio_unregister_sw_device_type(struct iio_sw_device_type *dt);
 struct iio_sw_device *iio_sw_device_create(const char *, const char *);
 void iio_sw_device_destroy(struct iio_sw_device *);
 
-int iio_sw_device_type_configfs_register(struct iio_sw_device_type *dt);
-void iio_sw_device_type_configfs_unregister(struct iio_sw_device_type *dt);
-
 static inline
 void iio_swd_group_init_type_name(struct iio_sw_device *d,
 				  const char *name,
diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index 47de2443e984..bc77f88df303 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -51,9 +51,6 @@ void iio_unregister_sw_trigger_type(struct iio_sw_trigger_type *tt);
 struct iio_sw_trigger *iio_sw_trigger_create(const char *, const char *);
 void iio_sw_trigger_destroy(struct iio_sw_trigger *);
 
-int iio_sw_trigger_type_configfs_register(struct iio_sw_trigger_type *tt);
-void iio_sw_trigger_type_configfs_unregister(struct iio_sw_trigger_type *tt);
-
 static inline
 void iio_swt_group_init_type_name(struct iio_sw_trigger *t,
 				  const char *name,
-- 
2.34.1

