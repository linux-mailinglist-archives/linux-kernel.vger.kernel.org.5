Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A17E6D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbjKIPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKIPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:30:32 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2074.outbound.protection.outlook.com [40.107.239.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B69187;
        Thu,  9 Nov 2023 07:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9SdhEuqTmvTRg0gZcrNfXpX7eoVBEadV8hvXz9j8m7FS1hA/YtEO667YPVnTWEaZt0af1R9/lcYXjUNtVMypIFOIxdMVnDpDaneMixI1flc88i8OLboQL7kman3JTDvXLs5+uL73kOMTIE/GLpI3JMSnkxl9u2cDeOaklC997YJdA5dYRR4GopJoMNZxtx9cbPNdb2Etkwj6pEfdodakn5xlzo/qe9SZdakzuWN3+JXYNcD+NJ/CRYGc5rIkH2IPjad/KizOz9EEz8auFTGktCHRjRsCUb0mZ5C4eqczwJ6Dki7uN3r6nvGmdViUlygz7Dx7zwvOv8NxnmidVTDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE69vXZKQQ9WXn48IB8HITcujG4H9VmNVVA4hOz15Ow=;
 b=C1h83Ok3Ye3tO8XjHfUi3+vgS+ODoPVMvrxwsD89qZG9nGRDPfRRP76tGwJOFuVOFZ2xk0xQ3dV3yHh6/x5YmU1MWS5Yf9cleGehCeiCQJUumop3ew8yVwRTfp2PfH0TBfYUmugkgmujgIyMKhEzWTgViw7YKqMIHTgP9teo4Ijd7GEn0uxsyDmrPVNZNyivWSRgt/zML8KnqgnUsdC+kSSFl1cqtwWt6DZ9HouM1MvMD8DqhPwWNtV0veTQPOs8P5syfxABELtXaK13VvzBNfrlptfdGWz3SoTfQcerhm9YeD5Fv+j6pFPVp5tbRhv96uab8TQSRTkYyrW6XM9xHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8::12)
 by MAZPR01MB8039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 15:30:25 +0000
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924]) by MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924%3]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 15:30:24 +0000
From:   Hiten Chauhan <hiten.chauhan@siliconsignals.io>
Cc:     hiten.chauhan@siliconsignals.io,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: Add tilt interrupt support for inv_icm42600
Date:   Thu,  9 Nov 2023 20:59:49 +0530
Message-Id: <20231109152949.66809-1-hiten.chauhan@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAXPR01MB4118:EE_|MAZPR01MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: f5956d37-8ab1-4cd6-a8d3-08dbe138cb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hgCdFzZ+39F2ZK7ArkXMaqLv6H2m8XjDCnjDT4IjBaME8WEGyJJhZWRP2p0kpDIa+k+vcpVYSQ2qvJqsyVvgx3bmj/xf3ahNW9YnpHJ/u3hv328XF6RvIWcasYFe+Fv4Xf2E/sq7PwHzyMVh7i/ovRemBvxddEf80gUKD3nBaVt7kVnEIzryUI1NMsxc8z7ytM0UlZweHuSgduv3ZZ9E8i3GGDVlnjLhNV2sbOLuNOjjfKV2J89xzQqWYy15egu/5fBJOxsO0AUV29fpMLC5Nt7wjXSFLPUybKKdVFUxv1AAMLp1A908MaBBR1npELgBKd/cavEHfgBaEx7jA/3tUsaND6KjCdoEmSfuBqlIbq7cA/Fyt3VZlY7SH6Piit0CUb120laZzy1/gFaLVxZuhxevbS/JbdwdBNwsx3s4xScnh8i6ItPN62RMmVqYExX0m5P2x9GlUaEPbPjCSNifn1d78A7Tuwz5MRxdRUad3bI80CnT+WuTtVHb//GzcIiufucbP+hLVReWDaMAB464HQrymFC31Z/3qK3B0F8AQzfDI6Uu7fG5ASGPPdvflGSWjCk5KY6A5WIgklGnqO4ec9apKE6enWDzdT1Mv2Eu5LQ4TboSgLnhgv0dE40OYTF1/UpZbAVdJH31Un2RK2mebZKAnUnZgpjnHZf/67TFls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39830400003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(109986022)(2906002)(44832011)(6512007)(41300700001)(2616005)(6486002)(4326008)(8676002)(8936002)(5660300002)(86362001)(66946007)(38100700002)(1076003)(66476007)(26005)(66556008)(316002)(54906003)(83380400001)(478600001)(52116002)(36756003)(38350700005)(3613699003)(6506007)(6666004)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G+RmV5ujucOz7lIioajEijL6pIpp1s1vje/sFt1UxtdtE+OCd21WZ0qzQJHA?=
 =?us-ascii?Q?xltQy/byIJkgZ2kjaYaXgVVCF/GNM7ylJPOIWrzywfjZCKu+/LWG3gv8aTao?=
 =?us-ascii?Q?qb+WUGsSXVu4l9Rt6Ghu6h13Y2L3bvGv9h3ka677cIpjy7nY7PyxI23nYIM6?=
 =?us-ascii?Q?Brh637CxeH3mit8vwc396+8+Hi8uryXVFbFp24J01er2aaCrCCMcqr6sxVPL?=
 =?us-ascii?Q?B0V9kbrZq+HfMS9g7t+cvK/0z5/WgYTWmP+nr9J1lQshyBOICaNWWTYGG3xK?=
 =?us-ascii?Q?s02GpBBh2ZVboYn1kfOibIvLEgLVwZgXZC/T2OwQUMRz5LPJUT8cXbjK67qI?=
 =?us-ascii?Q?cgFoh7bcDYgQjj4tUPKcUqPEyZPm9fQ+e/J7YdxC6fWsYK9rkx61kDbh/Ypm?=
 =?us-ascii?Q?5gl9mXZPoRi30ojgzkFVNh0f1vpzLB7p6G/IY5ecKsHPV12b1N4btMG1WY8j?=
 =?us-ascii?Q?lkfFpRGfXNq8xJ8hRf4xTkoEPKLy3H8lAe8fjjB557G0foqmXHR0jlbOF7F7?=
 =?us-ascii?Q?8cPr9z83dlCtQ0CzvUEX4H9+JCOFsmaEXi3PW4sl5hMjt9FynyuD8b1uaPPP?=
 =?us-ascii?Q?DMMz8nX9of9JUWRRHu7lB8pX21gA2cwc6eTMDaHF9dpv0lQN8itAlkMuIjdo?=
 =?us-ascii?Q?b5Z+PrkN8NIZC2YCr6DkEBw+9V5ARcdDlOCU3J6N2feLx0HqKoU8NsIZkcaa?=
 =?us-ascii?Q?5YlnhCuOUFghBB2WafcLWMN2Df5+6Cn7/TIGA8YMx4PCJhzYmVMz2sY8F6VJ?=
 =?us-ascii?Q?EkHVws+H3ELkCVf0iUumWn0Kyb7iBfIUzOVJzzLo1wqU8moWuZNCVimlAvOj?=
 =?us-ascii?Q?afAxvN28Sy3qmfPYppVhpeJJVbLYBjQ4UMKJaUbF0AdtA/+EdN9em1Q7bA/q?=
 =?us-ascii?Q?2T4AuQQ5UkGe+5Rr4OWAnofVcFe2RHdjYUkwwKUsIZ4ivN4QaMS0zMkapd3i?=
 =?us-ascii?Q?Sg1ZmVj66GyffzW0ypaeLFc/nVwZdy3oVwNqPIlYJekQKvho1lt0ovaFlukD?=
 =?us-ascii?Q?z+jgxUJg4eNNTfhZKWouZp5tKLgdnvT3hW229Sq9HMvsBWkFCNADiY2KSfcy?=
 =?us-ascii?Q?o3d4lVp891PHyJtKrSnYUjT3sKRDv7g2+cleVbZWN4rLJpR+nnyZGm4RRyly?=
 =?us-ascii?Q?Bs4nNblfPkoRIjuqa2qBTCi5Zkx21+AijbRnbQeIgTC/eUJ7Wd24Qyqf/1Pv?=
 =?us-ascii?Q?yWOqEgdks3sfP1HLqwRVOi1pkEbfGNtbMh+oIHlVIijuaI9aTZdsvy5dSqjW?=
 =?us-ascii?Q?3AdYMyCUPoLWzcehxopu6gCitxFQEepzndanZ+JBHfqciSjIkObube1i3+7m?=
 =?us-ascii?Q?gBec0C9YhLUcbvce0T2pCOBPFQ/epnmVRT4O4JmPel6UJGEqWXOgpANjbf2a?=
 =?us-ascii?Q?/M42hLWa0dHtaET+1W2fw+sqLdmVgAAwih+RFPbOhcwIoRlEG1Y7eSHdkopc?=
 =?us-ascii?Q?I+M6OkNlnVoZwV5ErFZqy4B6IgdDJnPkiEQ6w8F2/GO96/gb1GX7DUWZkhY9?=
 =?us-ascii?Q?AfF7rweXPYXpAivwUFmI7ksjjNhjGFWh1IJ2JhsDKa0LXARa3VpLwBIsz14u?=
 =?us-ascii?Q?ZOVvvLPCMrHVDxvhLBtntww+qKpV9v9ICROvd9s9nH43IYTBERJ+/zU/zjsX?=
 =?us-ascii?Q?RA2/C5a2+7fVV1FaBM7/vU0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f5956d37-8ab1-4cd6-a8d3-08dbe138cb0c
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:30:24.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DS8JFyEPaBDX+gvGbPNT7qrpsGdHwdl2PAjosUZsJVZJzMKPfg+fiTAr6kQM3/OVxMp5CLEdiIaYuQpa0cTtPHC//XV3P7bDrP0JGkNxbY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8039
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added tit interrupt support in inv_icm42600 imu driver.

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 0e290c807b0f..9865155b06c4 100644
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
+#define INV_ICM42605_APEX_CONFIG4_MASK                 GENMASK(7,0)
+
+#define INV_ICM42605_REG_APEX_CONFIG0                  0x0056
+#define INV_ICM42605_APEX_CONFIG0_TILT_ENABLE          BIT(4)
+#define INV_ICM42605_APEX_CONFIG0                      BIT(1)
+
+#define INV_ICM42605_REG_INTF_CONFIG1                   0x404D
+#define INV_ICM42605_INTF_CONFIG1_MASK                  GENMASK(5,0)
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
index b1e4fde27d25..2afa38547f52 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -47,6 +47,8 @@
 		.ext_info = _ext_info,					\
 	}
 
+uint8_t inv_icm42605_int_reg = 0;
+
 enum inv_icm42600_accel_scan {
 	INV_ICM42600_ACCEL_SCAN_X,
 	INV_ICM42600_ACCEL_SCAN_Y,
@@ -60,6 +62,74 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
 	{},
 };
 
+static ssize_t tilt_interrupt_show(struct device *dev,
+                               struct device_attribute *attr, char *buf)
+{
+	struct inv_icm42600_state *st = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->map, inv_icm42605_int_reg, &val);
+
+	if (ret != 0) {
+		return ret;
+	}
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
+        int ret;
+        int value;
+
+        if (!st) {
+                return -EINVAL;
+        }
+
+	if (kstrtoint(buf, 10, &value)) {
+            return -EINVAL;
+        }
+
+	inv_icm42605_int_reg = INV_ICM42605_REG_INT_STATUS3;
+
+	switch (value) {
+            case 1:
+                ret = inv_icm42605_generate_tilt_interrupt(st);
+                if (ret != 0) {
+                    return -EIO;
+                }
+                break;
+            case 0:
+                ret = inv_icm42605_disable_tilt_interrupt(st);
+                if (ret != 0) {
+                    return -EIO;
+                }
+                break;
+            default:
+                return -EINVAL;
+        }
+
+        return count;
+}
+
+static DEVICE_ATTR(tilt_interrupt, S_IRUGO | S_IWUSR,
+                   tilt_interrupt_show, tilt_interrupt_store);
+
+static struct attribute *icm42605_attrs[] = {
+        &dev_attr_tilt_interrupt.attr,
+	NULL,
+};
+
+static const struct attribute_group icm42605_attrs_group = {
+        .attrs = icm42605_attrs,
+};
+
 static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
 	INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN_X,
 				inv_icm42600_accel_ext_infos),
@@ -702,6 +772,7 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
+	.attrs = &icm42605_attrs_group,
 };
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
@@ -791,3 +862,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
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
+                                 INV_ICM42605_APEX_CONFIG4_MASK, 0);
+        if (ret)
+                return ret;
+
+	val = INV_ICM42600_PWR_ACCEL_MODE;
+	ret = regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, val);
+        if (ret)
+                return ret;
+
+	val = INV_ICM42605_APEX_CONFIG0;
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
+        if (ret)
+                return ret;
+
+	val = INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET;
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET, val);
+        if (ret)
+                return ret;
+
+	msleep(sleep);
+
+	val = INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN;
+	ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET, val);
+        if (ret)
+                return ret;
+
+	val = INV_ICM42605_APEX_CONFIG0_TILT_ENABLE |
+	      INV_ICM42605_APEX_CONFIG0;
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, val);
+        if (ret)
+                return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
+                                 INV_ICM42605_INTF_CONFIG1_MASK,
+				 INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN);
+        if (ret)
+                return ret;
+
+	return 0;
+}
+
+int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state *st)
+{
+	int ret;
+
+	ret = regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0, 0);
+        if (ret)
+                return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42605_REG_INTF_CONFIG1,
+			INV_ICM42605_INTF_CONFIG1_MASK, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
-- 
2.25.1

