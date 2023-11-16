Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B127EE1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjKPNqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345125AbjKPNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:46:01 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2046.outbound.protection.outlook.com [40.107.239.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E2AF;
        Thu, 16 Nov 2023 05:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLts0S2yiPxBxwuU2HTkeyC3l+dfMlT5VtUDsvjtKx7m980tHYErGLmMoJMG7OguPX5htiik0rbYhdLPMcGACmxsejyBnXi1V71XRmCBSX56P27m55CnXw64NuQfZdpLlW50iLD+39aqVCqoESrlAEeejf1IcQL+FufV+WuYyj/9xKBvK3soYrRh52js0etr4zv1avJBdvnUGaA19ck4evXeum2al/nTGkkINd9j6Sm6XSPUX3sPPWzSkfGr4J9li67ws66QN6Dte2exutE5RzPVnLc08VvTUJn0lYQY1StHaqd/MU1HIyOijlOU6irpMKRX+WXsq+H67mPi0JBdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFX9lePbbMmSwUMQqQVoRzTYbFzPpW1WsyNnIEDw8Ic=;
 b=Q7JLPoCDGdqjML/uoaI3LO2AxT1ss0PoqecG4MTD8NBMfu1xk45KrYEKjTuhDdYkcKGAsfMI1bB3NOeYhHULZ15m1kDhvupM2KrTEoCe6Oyt8d5oXJ99pu0LvSxlbeYpCvKkK1vmCxQn05ht/AKgwHcFfE04O+CB1faPf4wA0aH6Nd0+gi8Kz56icwreSU3RAMccyZl5uv+T5HyfSTPFFzJjh1cAGhELz/Od6Iwsni3QRrBP1RlnAAI5KpRp3jCaUB5cT1Em66oRna3GO2diKLOlwJRtv3LzhDqmiNHZOgp7l8AQkqqKxIoq5c8AfHrVLclLYkhfWiIYjvvmlUV8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8::12)
 by PN3PR01MB7096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 13:45:53 +0000
Received: from MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924]) by MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1848:62aa:1da4:1924%3]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 13:45:51 +0000
From:   Hiten Chauhan <hiten.chauhan@siliconsignals.io>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hiten Chauhan <hiten.chauhan@siliconsignals.io>
Subject: [PATCH v2 1/1] Added tilt interrupt support in inv_icm42600
Date:   Thu, 16 Nov 2023 19:15:28 +0530
Message-Id: <20231116134528.21467-1-hiten.chauhan@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAXPR01MB4118:EE_|PN3PR01MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 1940d450-8449-4783-53cb-08dbe6aa58fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iSHYeUQRaX2rz3ut7cAn7g3mdF07sRh3wG04s5HNX6a5lvRHpPjoyM/BAkYKi0k+bCkJU7Zm7b7E+EMx1RRlavEL/dHhZCkIs1ptvfJ360Uqdm4iEUR0QKjVDwB5FNJwx15w/DzEGxD23EOvwTP6vDOEbg4LB0ux3c2KkU/vSqU/d81ByiZ7Rx1YKBL9BrxMcxOgiH+rBSeGkYcw5oEO3OL5dCRtO62G0zGolPyQqiPY+6VJ1VOF5yltisb/Hbb/bZLkIwApqy9XTsYW9OsmvKmyBtLoT6YJLwbYHsieUQYhFHt88XQmRr9Mmw+is6oVd+c34I/CWkAYHXTc3PuiwM/xHTZUCvq94B5oMXicNX9XULhJuJK8vFD+3cw3ayLz61YjZrMsixrugV2fnm1dcKZMrxKgeBmZdlJcBlfyzbsQQZ/aKyMwjqHl/sc4Efe1vQ6ZiTkPmTn/SL+237bLxgIC9CXonYXv50HjTBNwKVjMHFDLQGSdXY4ClKrKoTNl3OjK5ie6CkkUgSB3oFjnSptEcGHLhG4VKFyQIIOqLiPvOmAuj9MGxUzMJIP+BJRnvArOliD3Y1ZGcTirPQ+mvqemPtE4UVQRl1YQSfe/c+Zw1wKAyglePEvRJDWVpXK35wLXQ4XgYl6A8Q0paHiwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(136003)(376002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(38100700002)(86362001)(5660300002)(4326008)(44832011)(8676002)(8936002)(83380400001)(41300700001)(1076003)(107886003)(6486002)(2616005)(36756003)(316002)(6512007)(66946007)(66556008)(66476007)(26005)(6666004)(6506007)(38350700005)(478600001)(52116002)(3613699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cqzlVZXwOk4VNDaEQLcMSt9zkgjXE0cBtoEnX5HUuasTss4f9IxKjMqzssrP?=
 =?us-ascii?Q?LDwIrqIfUQSkEyLIlVoCm9S47aOoKpAHIhf287kYE10Hlog7trTq+bZNJHUK?=
 =?us-ascii?Q?2xwH1rjYYKnqvRlobxjrigWzIWyIh0njvhuDRLtxst8gwj8yOhRpK57M+vdI?=
 =?us-ascii?Q?862S0y88NK4PAA0XaLfa/cxqjcya4S0XR0525SeENOxtiNH5CfbOYcVdAzDR?=
 =?us-ascii?Q?NbNBE7g8pDVTyATOtWBy2D8i3HQRZ0B60OjGj9tqAX1jzKFkzKnAEq/+O81q?=
 =?us-ascii?Q?HxUBdz1U8P3/FT/mJBQaQk3lRh1Mw5rQ6DDT4cWYIZjc+3RBxvTDReNMYwza?=
 =?us-ascii?Q?+qOhoGkv4lxZTaP8mYh818qyXg6Lx6L13m7s58JT4tZbeLQgH8wS6AdDwT+W?=
 =?us-ascii?Q?Xp08EkvJ48UoiI1434tsj4sScIXgXeVokjrym6dt5dCIelx3SaDWNBwaFQXj?=
 =?us-ascii?Q?CxuHscZTMezAzasHGjwj4cosMQkIQmHZ58qYN1t4x4WJ2it2D4GTwqt2h38R?=
 =?us-ascii?Q?ALuUvuOR72ouQYos9yPOFWFEw3amY3ubA1ZUbtX2KHF4bjqtnJbOmnvG1D1+?=
 =?us-ascii?Q?OJ1FpEZJ5mYiemzvEwtQVWB5k4n8ocQPxCCeA8LBKYs8bO6m+elmW3VjuXDA?=
 =?us-ascii?Q?bM/EMjbLLAWv7Yq8f7GkPZk+KXhZ+IAmof1TEKGtcDfgjOyE9+c+EATTp2SI?=
 =?us-ascii?Q?oo7Gn2tr6H5dmHOP2MXGQoS+shyoknEtpTsOYPa7VZJdd0At/Dj2a21wV9Qo?=
 =?us-ascii?Q?LwbtLoLdgZ1PGOR5JAdtEh42Oq8HY1wWVuC94Lclow8VfAvwqqCMRdzGylOO?=
 =?us-ascii?Q?ZC+yPM5qRG687fPqDFv2hcbJChRQVxRMm77MvJL20DJaBdFD5PfQZf3Bz/qv?=
 =?us-ascii?Q?tqwAIl/fpka2ldAwZCK4Ga0XkxCw3lU2OnWVwnSm9O4aijWCuhm5TetVHRnJ?=
 =?us-ascii?Q?LQ+86Xcv1ng0WQdT8MJ/PqBEC8F/Od6so4ZSQyRkgiX0r4LhuY81XZfFHqyJ?=
 =?us-ascii?Q?QEeBRp5fqxkHW3gKeE2v2P1JxDYEprX8qJXG1259/oGSffw/vWdYH/LfrmfJ?=
 =?us-ascii?Q?MYx5fKRpr4lWxB1fQdabR7UhUTSIvjr+if70W2tzozOE2OUSNNMvgkLa3Pck?=
 =?us-ascii?Q?QrgxOaLEzpF3PfVxmSaOWu3vaf9/fAkq0kYx332LKYPrh1nWCoNDTLmXqEWI?=
 =?us-ascii?Q?TlTMZw/M6tmcO4FRZDB8S0YgH2+T/6XghjSRAKt+muZ6SvnzicpB/Hu/19VI?=
 =?us-ascii?Q?mU3wgbYyAUXQS56p7KRShp8I7oy1UY2/+IGVveRIv4C05jnlhTEq3DlRmmHh?=
 =?us-ascii?Q?DVgMThrrxZxwEXdNvitKTqgKK7MP2JBYiV5t6YOUtldvIga0tJNYjC/8WGSk?=
 =?us-ascii?Q?M7LVm9DX7frZO9R1cUTLSEX1wPgmH3qWfbKKtLMA7Bv4x39Nr8moVrpFQKcV?=
 =?us-ascii?Q?xocIsbfmHa1/cY72IVimc45etDXhCTaq6JgyaCkY6nNjD4bBmHatfDuY3sUU?=
 =?us-ascii?Q?OCBOK/iVz0zK6lyKPsy94NlDcr4WxBwcs3ABzlsb1imrAq5JBXpIYPvKpzrz?=
 =?us-ascii?Q?YorLMruEJnzMr2Z5nDvNQ4U49NlR9DPZiszPi3nZ62G7E4Dh7p0oY04HwjH9?=
 =?us-ascii?Q?RMIAxiLMVsudGB6HIcpiKLc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1940d450-8449-4783-53cb-08dbe6aa58fd
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 13:45:51.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGr9PyhjG9V5tHCBTtve4VDkY26ydEpP03cQ1CvUxJj8MdJ58rcps31aFv5ucxiSDTPywVbwXHa/jIja1iWM2CSyZZ5wR1dy0n2dgtZUjqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7096
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
Add new device attribute to enable and disable
Tilt interrupt from kernel user space

Signed-off-by: Hiten Chauhan <hiten.chauhan@siliconsignals.io>

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
index b1e4fde27d25..7140ac967d88 100644
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
@@ -60,6 +62,69 @@ static const struct iio_chan_spec_ext_info inv_icm42600_accel_ext_infos[] = {
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
+static DEVICE_ATTR_RW(tilt_interrupt, 0644,
+		   tilt_interrupt_show, tilt_interrupt_store);
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
@@ -702,6 +767,7 @@ static const struct iio_info inv_icm42600_accel_info = {
 	.update_scan_mode = inv_icm42600_accel_update_scan_mode,
 	.hwfifo_set_watermark = inv_icm42600_accel_hwfifo_set_watermark,
 	.hwfifo_flush_to_buffer = inv_icm42600_accel_hwfifo_flush,
+	.attrs = &icm42605_attrs_group,
 };
 
 struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state *st)
@@ -791,3 +857,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 
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
-- 
2.25.1

