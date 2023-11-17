Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54687EF4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjKQPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:15:16 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2053.outbound.protection.outlook.com [40.107.239.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FA1AD;
        Fri, 17 Nov 2023 07:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy9/0tYVUtnj+r1d3oVl5Kxcq2MOY2hGIa2c3MANCMTmpMrQrQL66CvQZsdCGod2l+piS2HOMTaCCHw9Hn77cHc0dmAEFWA4s0vMrfwwtDEAcLa62puK8ZEhBNMloP1q3iCG8cdv/wwATzKe82Kn3h2bVIhJ+Sfx7Cbeu3KF3sQJLsNxxwTb3ChKjiXJqMGd/clszI3idAIUT05n9cQpMxwXEPrdWb2V8rrtz3+IF4jx7wd2CPnWLDBWKnqVG1cykKb3mbuOZ8ur0+8E2dU8ZbW6lyUNLAsHlJB62u0VaIs8/dHCvrwalfxR1YFfYFdn5oauoFau1XolTFn7Gi8H2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kh9Z7YFYeIr+wiaF06edyZIupZ/aibF5Fp3wKEC5nLs=;
 b=Kmz2UflkwwoD+yFeKydjupXOHY9NrWCJQbGamQjr1Ob7SgMsW6eSPJ+mmmElkh7BHjRYYi7xVaHZovK6pT8hiKHNWQ8JC6G77N1dgTxdqGFpYxjhK6UzOwIaCdCid/2YsE5Hg1gNhfus14MGjy6lFm7nmV92c9atVDhoX66tLntweMNTjgJuOC/gZfnNTtlUjYbPODMLzZuuC79ZNSaBiOB0aoZe+8o1CLPtyipVwmVJEgsGQwz56kwrblzAJnnMsY0k9p4aSC5nbLwosw5F17v5hb7XzW+OPIKXOFyDxHZhJLsG7236BUOY8+9BpBl4XSD5ErYTtCHeVyYagyVchw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8::12)
 by PN3PR01MB6710.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:82::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 15:15:08 +0000
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924]) by MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924%3]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 15:15:07 +0000
From:   Hiten Chauhan <hiten.chauhan@siliconsignals.io>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hiten Chauhan <hiten.chauhan@siliconsignals.io>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] Added tilt interrupt support in inv_icm42600
Date:   Fri, 17 Nov 2023 20:44:46 +0530
Message-Id: <20231117151446.49738-1-hiten.chauhan@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAXPR01MB4118:EE_|PN3PR01MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d96780-e158-480c-a93a-08dbe77ffbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGXo8+xkVzbHI9KpqDm63mnhlBRnaaDGMJ7y425U7piGOpkyP4yRypUrt6e6z+hVanlA7v8ulcyBhSRxTrohgOmlCdgVu4DBkOKoSKAyfeOV4EAKCMPa2i9yzj1X+0gwVD222IY1U4F1sEp5uMOhiQW3ilqYqw1RHgFfMHLAqH4/4J+nh7DUQomaW9nLsIxx0NisYqt3GMxPPy7JUIJ0JSgtkSb7p3QeDAEDU6kzQxcr2afPPaIkVyUZ2A4U3uz9kcpmqDc24T9cbQvIOL5nKEKz3ELvUGnBjpcmRsUVZVusP55lg+mbHbTmNo50L7rYMTxYfiWouBwcVfXCDXg7nZpS2woYSvNg6rEZ26VZhZbPlxNao0bwogvu2FCndzhOeZ1F7kb7yGeFAwi0LOik7zgDLjWqVHKuTFVFFFxQuSH4340TTGfbyLk8ap9kCyEfc/e+ca5QIwVv236Rs0rEXq66yIeTzJBRIUrb5PN9Hyy8luUj3uhnvO0d8Hw4lqQjqQSlBrBD7mgKBvl1PMI5rijkxl9pYG/NUeA4+AfRYPrqj0/El53t/BB7Sy1Mg0FUWm4sqbqraXHqXadmAQ/ezDKSnbAqDTcZorWQLzEYCwQL6K3iNf9urqGy5hANjMSh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39830400003)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66946007)(66476007)(54906003)(66556008)(86362001)(26005)(1076003)(38100700002)(8676002)(8936002)(3613699003)(44832011)(5660300002)(4326008)(38350700005)(36756003)(2906002)(83380400001)(966005)(6512007)(6486002)(478600001)(6666004)(6506007)(52116002)(41300700001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VLWi0P5ZE8jLpOa82woya9RC4QsRZ2oQNNd5SoBVShFQHRyFhBbRK7bbr9Sw?=
 =?us-ascii?Q?tk9Zm1UaIu4Z3GfazW7zqgHgFvehAR51wtIed3AuSRHt6GMn3Uny6KGIKtn2?=
 =?us-ascii?Q?fbZtEXlUnVZbCPvYmx8ZeTFwj1DXthKf2fFs9qUQhn7gNpxdv1niIA65Y5or?=
 =?us-ascii?Q?lv8UTGtwtxWNHkAE4oLleWKBXWx6VgPXW8XcTv4JS9KwOlMSpBmpkNZ50cRP?=
 =?us-ascii?Q?Uyd/CTPynu/ZkOoRup8UCxAJVBwGi+K4o9M8IgJCK9gweK73CETIwxh3R2bf?=
 =?us-ascii?Q?iiFo2c1UI2g3FpH0EhX+otM8YjqRP2XctFAZlc/kloMzQ6sJhT4GdP6RwQJL?=
 =?us-ascii?Q?+S+qjceTx55LTmwcbKcYdg2qQy3VdAJEDc8N7tg8vMQLEQpJ7/m/yocNtEpb?=
 =?us-ascii?Q?52x+/P1gDoRYyUf9XdKEnbCML8glxa32vReGIG2ZnA9YMdVB0kZP6LUInlAh?=
 =?us-ascii?Q?U3Np5IF+sryK4i3HUvNsqD1j+GdK9ZqGM7ooNUEqcTITFzV1AJ2RKzRGjn8i?=
 =?us-ascii?Q?MnhW92+/PYtTUpvUahpMyfp75s2G7jHGl4Jhi2Itr0NA+I6woHkfyWtYyovp?=
 =?us-ascii?Q?+DWX3qXbebWjJhhys9DSs1vgHjppGGQeXy2LFYczeIEUHmFupygcBlNqUpWk?=
 =?us-ascii?Q?ohrbXa1gCOlD/ZWl7bT9jIKeLnkPZ5TcbIx6wkfbdh5qozR3yWX56xIpz69E?=
 =?us-ascii?Q?TQQfYp85ydUKXQySE+HpLSc0q00ixQNEn4hOhNm+VY2RwWc5jKVOeHaKyXw5?=
 =?us-ascii?Q?zX2GIG38Kw4jw9gnkxo1WqlQUcliD2cK+tP9bnWm+0Et1FM0nHa2XjBz3Uc4?=
 =?us-ascii?Q?JMqg49OpnfUl6G5f5X8BAgJ199RmXg7Ff3tsb0i72H1MxrpPWrM4Ofmo1CUC?=
 =?us-ascii?Q?EY1JxgxCoZsNJMriHP+Zb2XPlJ9XP5Z4ALM23KLVNm1AxJJFJUqoFi0zxTf2?=
 =?us-ascii?Q?nbaqwG72IQou0RM8EJU/F/nnaEoOzpGUk0yTwSIgmJbg83Yoq84uIncTgg8Z?=
 =?us-ascii?Q?fWAlb87CXz2ZJvkiG6+RZXH/mzJI/0sYynX4RtyExnj83lMXkHwn52u/qgto?=
 =?us-ascii?Q?hw6mYgnWraL9rHIyTyin90qLKl5RwUd6t3cqSSLJlOmn5zoQhOtIU4NYTMHg?=
 =?us-ascii?Q?7/PJde4T0W98SFdJMPHygf6D8sA7Lm9rKUcYXWBV6/kCEoCAP50sZ2+KJIEt?=
 =?us-ascii?Q?YTHFYzIombY2p/COdxB6TznxVQaph8Rc3xhPGb3yH7UVTduE/RSQGAwo5q2+?=
 =?us-ascii?Q?QF7VtaOHHIjaZLaMzVkmHFejCGZJ2iDdtPhUC/mHhjv7Vd1Eg5iz/i69TpvA?=
 =?us-ascii?Q?dE3X34TOTsckPkLEGP7UPPdTSPFksnSQOzCRAb8Hi+yIKj9O1iXdGhWoPVW0?=
 =?us-ascii?Q?7HVPBn5xkp2MZULZsYQo0yLfZL28BGvlCu2wI281m5hWCE2tji9vL/3VZlP4?=
 =?us-ascii?Q?JKETcMuk8hOnvl42yS8i8noWZGi/ofgGRUyv3BE3pEfejsHUPvP4AjD2TWpA?=
 =?us-ascii?Q?2fMKtMDJXauuAqC2ZbaY1+5chQvAlL7YbZjmaC4JRLCrxG4rJNjmPG2EZlgy?=
 =?us-ascii?Q?mKXXxggS493pZByXUrxJF1/prCi/blvrtqeWZ4VSYq0iGVBZbl7am/6uLrG/?=
 =?us-ascii?Q?9TJfWxjYLqTcY0C/Zw/WL00=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d96780-e158-480c-a93a-08dbe77ffbbd
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 15:15:07.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbfqW5Amyb7SPwAf0SyXyWaPurNdmxlBIDHNERXYsSBztHwYxz8quc7ZIDdFJuMQW5Dnm0DfqsXtjqubhILHjVKxiovMQMQGx5Z+9TsDzU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6710
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
Add new device attribute to enable and disable
Tilt interrupt from kernel user space

Signed-off-by: Hiten Chauhan <hiten.chauhan@siliconsignals.io>

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311170235.HaVJnmWa-lkp@intel.com/
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  24 ++++
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 129 ++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0e290c807b0f..39ed39e77deb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -187,6 +187,8 @@ struct inv_icm42600_state {
 #define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL		\
 		FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2)
 
+#define INV_ICM42600_REG_MASK        GENMASK(7, 0)
+
 /* all sensor data are 16 bits (2 registers wide) in big-endian */
 #define INV_ICM42600_REG_TEMP_DATA			0x001D
 #define INV_ICM42600_REG_ACCEL_DATA_X			0x001F
@@ -239,6 +241,7 @@ struct inv_icm42600_state {
 #define INV_ICM42600_REG_PWR_MGMT0			0x004E
 #define INV_ICM42600_PWR_MGMT0_TEMP_DIS			BIT(5)
 #define INV_ICM42600_PWR_MGMT0_IDLE			BIT(4)
+#define INV_ICM42600_PWR_ACCEL_MODE			BIT(1)
 #define INV_ICM42600_PWR_MGMT0_GYRO(_mode)		\
 		FIELD_PREP(GENMASK(3, 2), (_mode))
 #define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)		\
@@ -306,6 +309,21 @@ struct inv_icm42600_state {
 #define INV_ICM42600_WHOAMI_ICM42622			0x46
 #define INV_ICM42600_WHOAMI_ICM42631			0x5C
 
+/* Register configs for tilt interrupt */
+#define INV_ICM42605_REG_APEX_CONFIG4                  0x4043
+#define INV_ICM42605_APEX_CONFIG4_MASK                 GENMASK(7, 0)
+
+#define INV_ICM42605_REG_APEX_CONFIG0                  0x0056
+#define INV_ICM42605_APEX_CONFIG0_TILT_ENABLE          BIT(4)
+#define INV_ICM42605_APEX_CONFIG0                      BIT(1)
+
+#define INV_ICM42605_REG_INTF_CONFIG1                   0x404D
+#define INV_ICM42605_INTF_CONFIG1_MASK                  GENMASK(5, 0)
+#define INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN      BIT(3)
+
+#define INV_ICM42605_REG_INT_STATUS3                   0x0038
+
+
 /* User bank 1 (MSB 0x10) */
 #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
 #define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE		BIT(5)
@@ -364,6 +382,8 @@ typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 extern const struct regmap_config inv_icm42600_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
+extern uint8_t inv_icm42605_int_reg;
+
 const struct iio_mount_matrix *
 inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan);
@@ -395,4 +415,8 @@ struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
 int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
 
+int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st);
+
+int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index b1e4fde27d25..311f6ea09e64 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -47,6 +47,8 @@
 		.ext_info = _ext_info,					\
 	}
 
+uint8_t inv_icm42605_int_reg;
+
 enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_X,
 	INV_ICM42600_ACCEL_SCAN_Y,
@@ -60,6 +62,68 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	{},
 };
 
+static ssize_t tilt_interrupt_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->map, inv_icm42605_int_reg, &val);
+
+	if (ret != 0)
+		return ret;
+
+	snprintf(buf, PAGE_SIZE, "Read reg %x value %x\n", inv_icm42605_int_reg, val);
+
+	return strlen(buf);
+}
+
+static ssize_t tilt_interrupt_store(struct device *dev,
+		struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	int ret;
+	int value;
+
+	if (!st)
+		return -EINVAL;
+
+	if (kstrtoint(buf, 10, &value))
+		return -EINVAL;
+
+	inv_icm42605_int_reg = INV_ICM42605_REG_INT_STATUS3;
+
+	switch (value) {
+	case 1:
+		ret = inv_icm42605_generate_tilt_interrupt(st);
+		if (ret != 0)
+			return -EIO;
+		break;
+	case 0:
+		ret = inv_icm42605_disable_tilt_interrupt(st);
+		if (ret != 0)
+			return -EIO;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(tilt_interrupt);
+
+static struct attribute *icm42605_attrs[] = {
+	&dev_attr_tilt_interrupt.attr,
+	NULL,
+};
+
+static const struct attribute_group icm42605_attrs_group = {
+	.attrs = icm42605_attrs,
+};
+
 static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
 				inv_icm42600_accel_ext_infos),
@@ -702,6 +766,7 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
+	.attrs = &icm42605_attrs_group,
 };
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
@@ -791,3 +856,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
 	return 0;
 }
+
+int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state *st)
+{
+	int ret;
+	int val;
+	char sleep = 10;
+
+	ret = regmap_update_bits(st->map, INV_ICM42605_REG_APEX_CONFIG4,
+				 INV_ICM42605_APEX_CONFIG4_MASK, 0);
+	if (ret)
+		return ret;
+
+	val = INV_ICM42600_PWR_ACCEL_MODE;
+	ret = regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	val = INV_ICM42605_APEX_CONFIG0;
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	val = INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET;
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET, val);
+	if (ret)
+		return ret;
+
+	msleep(sleep);
+
+	val = INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN;
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET, val);
+	if (ret)
+		return ret;
+
+	val = INV_ICM42605_APEX_CONFIG0_TILT_ENABLE |
+	      INV_ICM42605_APEX_CONFIG0;
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
+				 INV_ICM42605_INTF_CONFIG1_MASK,
+				 INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
+			INV_ICM42605_INTF_CONFIG1_MASK, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.25.1

