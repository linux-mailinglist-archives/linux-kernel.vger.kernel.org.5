Return-Path: <linux-kernel+bounces-148142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE4F8A7E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E591C21B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADD781ACC;
	Wed, 17 Apr 2024 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="bFeAC0E+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2020.outbound.protection.outlook.com [40.92.49.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DC471745;
	Wed, 17 Apr 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342535; cv=fail; b=eQ2JIV/lFbnV75LQ1DtkaGQJRQbUEBt8g13L274o8a+a1K4261di9RTiN/Qbb5Q6QQg8oI7ats0tDnRTGotrXUS7721QvVKgbTSTycl9ieRP76+zVw+Ws/31xEo65PN+GWNPpOv+kAFYDIdR1Sw1MLWJxLvd774rQC/2zKzg6Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342535; c=relaxed/simple;
	bh=VynyJXt755Dxpo7WRKrn+jcF9IewEGhj8v9gNWqGTR0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DBrpEH6KVINWkOyjbQx+EAnn7wRVFIIawnvvNmLbyhEfAJ35sb6W/1gsQRuZHYSiuv8QsVyYi4EtueG4ZKihQSp/Ane4F3LTf87VVyBG3tQdeqSbXjynBtkwc8jgIvhvZ6srNa+AxO60f+LucDBzfVji/hUffk18gzfoF9pmpBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=bFeAC0E+; arc=fail smtp.client-ip=40.92.49.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abhtHigOx5tJR5AjwyQHiE7ULprgR4foSF70T6tPz9CYIg2l4QcwEAx7lznaenwaqQnQbBvubmpIjtxvKSuNZmrSCSZF/Ccw9UE2aQ5cr0hPQqLX+1bVuvh4S9Taj+6g6Nk6eY5MbYF+4o4NeH7eUBnQeO10jIw14TbhcUkqFZRMBEObREJcreJDeO0tv2yDgK5tIlwcZGALaoeFotxh/NumJENEtIhll3VweoP4ojYmeyYzubdZUbEojAxvzLItXfT5We1rgtSgX3sRfsfhOfG4BU47LGdqyw15VYi4GgJ3Z+w2v3iktgGFcOW5qRSYE3rMUxCDYWgQzdoMfSUM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvx1NaugaQ9N8zcp5bfZzMnYgcjw5R4DROHj25Md/vQ=;
 b=ZR0Bwzdb/C1jnxMZ+jBEbwgAEOLrJ0G8b4j/NhGDqfG6LRZrdsXIy8fik7briWRuA6DfLSWvlVuQ9lC5VjTaBN46GIRGbOVoiJ/1HP9/83Fv6i0UnPhooDF5qKgTYfaBJK+QebgSbhStEjYyJv0phxbqfpL9931/7SvrzJE8a+HM+ke/emRkjJpBNUCTNM2VZzfisAa9y40ZIMNmLsCG7zbaPTeaqCwWdPeAz6PnitXeLulR/ZF35Y0rePLqrGx2SgevoUF4blDpcqpAQMLnbPZQp22y/O3KrT0abU9PQud0BZ1DJ5RLTW3amEog7DAHpY4qYr0Numt6bNApz5vIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qvx1NaugaQ9N8zcp5bfZzMnYgcjw5R4DROHj25Md/vQ=;
 b=bFeAC0E+YHQK1GUj20S5JkoCWCTzP5SIT9KdcvwNZM02GgON6likOppAYU3dGf/dUQklOA2ry7EZStMbhldHL4V+Cv9imTuGD5Rul+bpupEHbYzKawwau8Src5byhVnKdZAv5qlU215R0cK4yMLRTg0vkGinPh5tGx7p4nSuGtCcTxP0xNCOcCG/L7cKkl2xZKHpWvZam9p4e89/1md3cwW1G8uJ3VAG2rOLLAxNynNDIkog7mxvJ1YRGXGqcg1ocjX4sz5GJDxsySaxQr0x6Ei1lkxNv+J3hb5BerFeVMUfFd/oTi1pLPWEZNOfByhBzhssmA2sC7MdrnUL4BIRGg==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DU2PR09MB5376.eurprd09.prod.outlook.com (2603:10a6:10:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 08:28:49 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 08:28:49 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH] iio: accel: adxl345: Added buffered read support
Date: Wed, 17 Apr 2024 10:28:34 +0200
Message-ID:
 <AM0PR09MB26757E9F7575A2357E318C50950F2@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0UnCOzmPjNVmSnwga0l3Ph/BQKldzA7xIpAGj9RfPy3RowUswCrFmgMT6M9X3xNZ]
X-ClientProxiedBy: AS4P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::8) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20240417082834.29301-1-paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DU2PR09MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ee3ecd-4b3f-4c0d-1392-08dc5eb8682b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vpxT8HoVelufQFKBtDYaYKBfCk7yMhTgA7nvIYlg/srUhMsyg+agsMs9UfZiVkQobeczCAeE0THPb+IdlLt9X2z4C9KXwl4g1rgt1DnEyugFBw8nIXG2VdfHkiV7lKHEIXQsHS2lezRNEmciawRPaYueJ/j9o4VoTQ5QPhGC44WpvDHrmge41+fpQm2pd09vjsKSB4UvCU8jehT3MQ7SK3kUZPlK4DfYTYUerxzEUEsZ5i9sF+fDG3GFdo9vKvV+549/H8bcU75d+cwTWFc6sS92b+tDuYaO2fCjV/vedJx2g1MFl8DBA/zz0Kr8Q9+QIgClPvAE0t7noLHdc7NVoJqkdsjzzDia+UyL3JOJjGlxs7EYQX8oDL1gjcBKVVeCpnpEtm4kCPL77V/Fnnznz1lKWaBLC1aSNDFbK2JYLJ8t0O8COIzeddnDJL+NQmn2qT3aq12ed/MoFdc2aAdWVbJvG0L+tltArLzLlh6DI71UIwxW33b99zq3sOS60iDne/kAPD1gUKWz7I5R9VPOdkRgu/BhaJoJXhANkNMyOEEJEmsfFZrq9NXdWnui4A2ryfg9ow/GVa3OwJHG65FnVHdstfntFpCnZ6daOswa1zBHotQxijsaNDMoNXS9/9/U
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ojs761KaNgbwGT17BsO9ZkFxbQqGFXE4+ge6ZgrGM1Q45QkK/U3z94Uulcq5?=
 =?us-ascii?Q?IEi0wpKhAFernvOeAB5Ms/8VKyLuz0/Zg4Sy7TDMkheDjrKOlLD3PBEPf57/?=
 =?us-ascii?Q?FYTQqNe2RqeSCVt7oM8rS11SS6zS6VGPVm8+iHf9dxb4qbORPe/EzCpB4FYP?=
 =?us-ascii?Q?ZaiYoahtKbxyOicaCgnJXNWr/tuQZ/3G/QRH0tYIZDCZ8AMPGK/jqL+nFzlU?=
 =?us-ascii?Q?rfAxRLT/BYFMDzoTiXhXKJLw+zAxV1TS6OC4W281dp8ZO9SKNuftZk5K2IzH?=
 =?us-ascii?Q?AiDJHyCft9j3MLuqcJLMQQ1ic1GQycsa6J4wBcFR3+mGAIhK6pTL5PyxG87C?=
 =?us-ascii?Q?h4MVODhV9EI2k7UeEs44Z9eAUXuUB44wFyQRmE1UKlTxqAIaypDBeHJfYXWT?=
 =?us-ascii?Q?ivIhWnvbymC4qRD/xJGpsGemw9Q3Vvt+8LzBX6GNT4sDbeq+vgOECTLmGbQ0?=
 =?us-ascii?Q?R9M/NrPn98GT2pwBQFN9wFccl1WKYOsPvm2Rk790xmRJuIlWlX4TttV1rft0?=
 =?us-ascii?Q?1LnlJmyMUAi1DXPLgvOe9CSl1oqHq+X62a6zlmDY3HLc7BT9gki0+X9AKsLH?=
 =?us-ascii?Q?qjA6Zqd0m3Kwsj0HUJ6O2PpT4VJ10zw6skE7x28xEIcP/nJFMIPgdWKacf1Q?=
 =?us-ascii?Q?7ronoAeiGsax2DF0Jv9V+HH31k0AcrA3VWvCoivj9akjPnDTGK402SjOdILT?=
 =?us-ascii?Q?Ci/XP0czokkQxKp64B8ndC4E6didVutzJTN9ygAi7crE8RxVPktmKbDXPrLY?=
 =?us-ascii?Q?LmwGoyrJ0vt4HDr5qWa+ckZl3yq98KNtXzvYDpW5GAIunfvtvmyEYasR5RPM?=
 =?us-ascii?Q?Vg3H0lL1ERef4+I+1raxvY6jWnYCy/caLNDEkVm8zNsSEYjOk5NMvLlB98dN?=
 =?us-ascii?Q?tB5gYr09vsM2zHCz5aFbb+Xihi5z7tcaJaJ4Z7SFWfsxcLYALBYR7OkrE/Ze?=
 =?us-ascii?Q?UUcNX+pqkf+GvZXmVZxpr0fb+JND9fy8DuMPDVr3E8fMcjIB34pNexR+P5K+?=
 =?us-ascii?Q?DoQPCtE1FGsC6O5UxmRZ0870eImvBFakoGUHE++JhexU4bSyQe0iGf530q1/?=
 =?us-ascii?Q?HXIQxpsPngWDecFaIx62Hzow9rNWEeuxdNTLjpJUlg3pB/jJBNaTgFavU/cT?=
 =?us-ascii?Q?LnLWarqU6zAulgkOQupPraAxcx6gkGjicaeZzg627+GyDvmDbML7kJJ4M+Di?=
 =?us-ascii?Q?aK1/2Z5UxoUjLoRXcibJDUrkL8mQdi6TbbBJTS7dIpDcNfMrqqalpWAYRXY2?=
 =?us-ascii?Q?b8tTd2zk6afwTZyz/RmBc0MfgFwsHEDz0UY8GAvo434EUoZPbkcrdg3iNq6f?=
 =?us-ascii?Q?tLI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ee3ecd-4b3f-4c0d-1392-08dc5eb8682b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 08:28:49.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5376

This implements buffered reads for the accelerometer data. A buffered
IIO device is created containing 3 channels. The device FIFO is used for
sample buffering to reduce the IRQ load on the host system.

Reading of the device is triggered by a FIFO waterlevel interrupt. The
waterlevel settings are dependent on the sampling frequency to leverage
IRQ load against responsiveness.

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
 drivers/iio/accel/adxl345.h      |   2 +-
 drivers/iio/accel/adxl345_core.c | 387 ++++++++++++++++++++++++++++---
 drivers/iio/accel/adxl345_i2c.c  |   2 +-
 drivers/iio/accel/adxl345_spi.c  |   2 +-
 4 files changed, 363 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387ce69..269ce69517ce 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -28,6 +28,6 @@ struct adxl345_chip_info {
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq);
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23ed3b..1f38d2287783 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -11,28 +11,50 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
+#include <linux/irq.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "adxl345.h"
 
 #define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_THRESH_TAP 0x1D
 #define ADXL345_REG_OFSX		0x1e
 #define ADXL345_REG_OFSY		0x1f
 #define ADXL345_REG_OFSZ		0x20
 #define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
 #define ADXL345_REG_BW_RATE		0x2C
 #define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_INT_ENABLE   0x2E
+#define ADXL345_REG_INT_SOURCE   0x30
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_DATAX0		0x32
 #define ADXL345_REG_DATAY0		0x34
 #define ADXL345_REG_DATAZ0		0x36
 #define ADXL345_REG_DATA_AXIS(index)	\
 	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+#define ADXL345_REG_FIFO_CTL		0x38
+#define ADXL345_REG_FIFO_STATUS		0x39
 
 #define ADXL345_BW_RATE			GENMASK(3, 0)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+#define ADXL345_MAX_RATE_NANO_HZ	(3200LL * NANOHZ_PER_HZ)
+#define ADXL345_MAX_BUFFERED_RATE	400L
+#define ADXL345_DEFAULT_RATE		(100LL * NANOHZ_PER_HZ)
+
+#define ADXL345_INT_DATA_READY	BIT(7)
+#define ADXL345_INT_SINGLE_TAP	BIT(6)
+#define ADXL345_INT_DOUBLE_TAP	BIT(5)
+#define ADXL345_INT_ACTIVITY	BIT(4)
+#define ADXL345_INT_INACTIVITY	BIT(3)
+#define ADXL345_INT_FREE_FALL	BIT(2)
+#define ADXL345_INT_WATERMARK	BIT(1)
+#define ADXL345_INT_OVERRUN	BIT(0)
 
 #define ADXL345_POWER_CTL_MEASURE	BIT(3)
 #define ADXL345_POWER_CTL_STANDBY	0x00
@@ -43,12 +65,30 @@
 #define ADXL345_DATA_FORMAT_8G		2
 #define ADXL345_DATA_FORMAT_16G		3
 
-#define ADXL345_DEVID			0xE5
+#define ADXL345_FIFO_CTL_MODE_FIFO		BIT(6)
+#define ADXL345_FIFO_CTL_MODE_STREAM		BIT(7)
+#define ADXL345_FIFO_CTL_MODE_TRIGGER		(BIT(6) | BIT(7))
+#define ADXL345_FIFO_CTL_SAMPLES_MASK		GENMASK(4, 0)
+#define ADXL345_FIFO_CTL_SAMPLES(n)		((n) & ADXL345_FIFO_CTL_SAMPLES_MASK)
+#define ADXL345_FIFO_MAX_FREQ_WATERLEVEL	20
+
+#define ADXL345_DEVID	0xE5
+
+#define ADXL345_SCAN_SIZE	(sizeof(__le16) * 3)
 
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
+	int irq;
+
+	struct iio_trigger *drdy_trig;
+	/*
+	 * This lock is for protecting the consistency of series of i2c operations, that is, to
+	 * make sure a measurement process will not be interrupted by a set frequency operation,
+	 * which should be taken where a series of i2c or SPI operations start, released where the
+	 * operation ends.
+	 */
+	struct mutex lock;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -60,6 +100,13 @@ struct adxl345_data {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = index,					\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 13,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
+	},								\
 }
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -68,6 +115,98 @@ static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(2, Z),
 };
 
+static const unsigned long adxl345_available_scan_masks[] = {
+	/* Only allow all axis to be sampled, as this is the only option in HW */
+	BIT(0) | BIT(1) | BIT(2),
+	0, /* Array should end with 0 */
+};
+
+/* Trigger handling */
+static irqreturn_t adxl345_irq_handler(int irq, void *d)
+{
+	struct iio_dev *indio_dev = d;
+	struct adxl345_data *data = iio_priv(indio_dev);
+	int regval, ret;
+
+	ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &regval);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent, "Broken IRQ!\n");
+		return IRQ_HANDLED;
+	}
+
+	if (regval & ADXL345_INT_OVERRUN)
+		dev_err(indio_dev->dev.parent, "FIFO overrun detected! Data lost\n");
+
+	if (regval & ADXL345_INT_WATERMARK)
+		iio_trigger_poll_nested(data->drdy_trig);
+	else
+		dev_err(indio_dev->dev.parent, "Unexpected IRQ! Source: 0x%02X\n", regval);
+
+	return IRQ_HANDLED;
+}
+
+static int adxl345_get_sampling_freq(struct adxl345_data *data, s64 *freq_nhz)
+{
+	int ret;
+	unsigned int regval;
+
+	mutex_lock(&data->lock);
+	ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		return ret;
+
+	*freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
+			(regval & ADXL345_BW_RATE);
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int adxl345_set_sampling_freq(struct adxl345_data *data, s64 freq_nhz)
+{
+	int ret, waterlevel;
+	s64 n;
+
+	/* Only allow valid sampling rates */
+	if (freq_nhz < ADXL345_BASE_RATE_NANO_HZ || freq_nhz > ADXL345_MAX_RATE_NANO_HZ)
+		return -EINVAL;
+
+	/*
+	 * Trade-off the number of IRQs to the responsiveness on lower sample rates.
+	 * sample rates < 100Hz don't use the FIFO
+	 * 100<>1600Hz issue 100 IRQs per second
+	 * 3200Hz issues 160 IRQs per second
+	 */
+	if (freq_nhz < ADXL345_DEFAULT_RATE)
+		waterlevel = 0;
+	else if (freq_nhz < ADXL345_MAX_RATE_NANO_HZ)
+		waterlevel = (freq_nhz / ADXL345_DEFAULT_RATE);
+	else
+		waterlevel = ADXL345_FIFO_MAX_FREQ_WATERLEVEL;
+
+	n = div_s64(freq_nhz, ADXL345_BASE_RATE_NANO_HZ);
+
+	/* Disable the IRQ before claiming the mutex to prevent deadlocks */
+	if (data->irq)
+		disable_irq(data->irq);
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
+				 ADXL345_BW_RATE, clamp_val(ilog2(n), 0, ADXL345_BW_RATE));
+	if (ret < 0)
+		goto out;
+	ret = regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
+				 ADXL345_FIFO_CTL_SAMPLES_MASK,
+				 ADXL345_FIFO_CTL_SAMPLES(waterlevel));
+
+out:
+	mutex_unlock(&data->lock);
+	if (data->irq)
+		enable_irq(data->irq);
+	return ret;
+}
+
+/* Direct mode functions */
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -80,26 +219,35 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret < 0)
+			return ret;
 		/*
 		 * Data is stored in adjacent registers:
 		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
 		 * and ADXL345_REG_DATA(X0/Y0/Z0) + 1 the most significant byte
 		 */
+		mutex_lock(&data->lock);
 		ret = regmap_bulk_read(data->regmap,
 				       ADXL345_REG_DATA_AXIS(chan->address),
 				       &accel, sizeof(accel));
+		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 
 		*val = sign_extend32(le16_to_cpu(accel), 12);
+
+		iio_device_release_direct_mode(indio_dev);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
 		*val2 = data->info->uscale;
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
+		mutex_lock(&data->lock);
 		ret = regmap_read(data->regmap,
 				  ADXL345_REG_OFS_AXIS(chan->address), &regval);
+		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
 		/*
@@ -110,15 +258,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, ADXL345_REG_BW_RATE, &regval);
-		if (ret < 0)
-			return ret;
-
-		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
-				(regval & ADXL345_BW_RATE);
+		ret =  adxl345_get_sampling_freq(data, &samp_freq_nhz);
 		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
 
-		return IIO_VAL_INT_PLUS_NANO;
+		return ret;
 	}
 
 	return -EINVAL;
@@ -129,7 +272,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_data *data = iio_priv(indio_dev);
-	s64 n;
+	int ret = -EINVAL;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -137,20 +280,17 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
 		 * factor
 		 */
-		return regmap_write(data->regmap,
-				    ADXL345_REG_OFS_AXIS(chan->address),
-				    val / 4);
+		mutex_lock(&data->lock);
+		ret = regmap_write(data->regmap,
+				   ADXL345_REG_OFS_AXIS(chan->address), val / 4);
+		mutex_unlock(&data->lock);
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		n = div_s64(val * NANOHZ_PER_HZ + val2,
-			    ADXL345_BASE_RATE_NANO_HZ);
-
-		return regmap_update_bits(data->regmap, ADXL345_REG_BW_RATE,
-					  ADXL345_BW_RATE,
-					  clamp_val(ilog2(n), 0,
-						    ADXL345_BW_RATE));
+		ret = adxl345_set_sampling_freq(data, (s64)(val * NANOHZ_PER_HZ + val2));
+		break;
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
@@ -197,7 +337,149 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+static int adxl345_flush_fifo(struct regmap *map)
+{
+	__le16 axis_data[3];
+	int ret, regval;
+
+	/* Clear the sample FIFO */
+	ret = regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);
+	if (ret < 0)
+		goto out;
+	while (regval & ADXL345_INT_DATA_READY) {
+		ret = regmap_bulk_read(map, ADXL345_REG_DATA_AXIS(0), &axis_data,
+				       sizeof(axis_data));
+		if (ret < 0)
+			goto out;
+		ret = regmap_read(map, ADXL345_REG_INT_SOURCE, &regval);
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+static int adxl345_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	/* Disable measurement mode to setup everything */
+	ret = regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+	if (ret < 0)
+		goto out;
+
+	ret = adxl345_flush_fifo(data->regmap);
+	if (ret < 0)
+		goto out_enable;
+
+	/*
+	 * Set the FIFO up in streaming mode so the chip keeps sampling.
+	 * Waterlevel is set by the sample frequency functions as it is dynamic
+	 */
+	ret = regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
+				 (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK),
+				 ADXL345_FIFO_CTL_MODE_STREAM);
+	if (ret < 0)
+		goto out_enable;
+
+	/* Enable the Watermark and Overrun interrupt */
+	ret = regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, (ADXL345_INT_WATERMARK |
+			   ADXL345_INT_OVERRUN));
+	if (ret < 0)
+		goto out_enable;
+
+	/* Re-enable measurement mode */
+	ret = regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+	goto out;
+
+out_enable:
+	dev_err(indio_dev->dev.parent, "Error %d Setting up device\n", ret);
+	/* Re-enable measurement mode */
+	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+out:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int adxl345_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct adxl345_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->lock);
+	/* Disable measurement mode and interrupts*/
+	regmap_clear_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+	regmap_write(data->regmap, ADXL345_REG_INT_ENABLE, 0x00);
+
+	/* Clear the FIFO and disable FIFO mode */
+	adxl345_flush_fifo(data->regmap);
+	regmap_update_bits(data->regmap, ADXL345_REG_FIFO_CTL,
+			   (int)~(ADXL345_FIFO_CTL_SAMPLES_MASK), 0x00);
+
+	/* re-enable measurement mode for direct reads */
+	regmap_set_bits(data->regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
+	.preenable = adxl345_buffer_preenable,
+	.postdisable = adxl345_buffer_postdisable,
+};
+
+static irqreturn_t adxl345_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adxl345_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	u8 buffer[ADXL345_SCAN_SIZE] __aligned(8);
+	int ret, data_available;
+
+	mutex_lock(&data->lock);
+
+	/* Disable the IRQ before reading the FIFO */
+	if (data->irq)
+		disable_irq_nosync(data->irq);
+
+	ret = regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent, "Could not read available data (%d)\n", ret);
+		goto done;
+	}
+
+	while (data_available & ADXL345_INT_DATA_READY) {
+		/* Read all axis data to make sure the IRQ flag is cleared. */
+		ret = regmap_bulk_read(regmap, ADXL345_REG_DATA_AXIS(0),
+				       &buffer, (sizeof(buffer)));
+		if (ret < 0) {
+			dev_err(indio_dev->dev.parent, "Could not read device FIFO (%d)\n", ret);
+			goto done;
+		}
+		iio_push_to_buffers(indio_dev, buffer);
+		ret = regmap_read(regmap, ADXL345_REG_INT_SOURCE, &data_available);
+		if (ret < 0) {
+			dev_err(indio_dev->dev.parent, "Could not push data to buffers (%d)\n",
+				ret);
+			goto done;
+		}
+	}
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	/* Re-enable the IRQ */
+	if (data->irq)
+		enable_irq(data->irq);
+
+	mutex_unlock(&data->lock);
+
+	return IRQ_HANDLED;
+}
+
+int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	struct adxl345_data *data;
 	struct iio_dev *indio_dev;
@@ -218,22 +500,29 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
 	data->info = device_get_match_data(dev);
 	if (!data->info)
 		return -ENODEV;
 
+	/* Enable full-resolution mode */
 	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
+			   ADXL345_DATA_FORMAT_FULL_RES);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to set data range\n");
 
+	/* Set the default sampling frequency */
+	ret = adxl345_set_sampling_freq(data, ADXL345_DEFAULT_RATE);
+	if (ret < 0)
+		dev_err(dev, "Failed to set sampling rate: %d\n", ret);
+
+	mutex_init(&data->lock);
+
 	indio_dev->name = data->info->name;
 	indio_dev->info = &adxl345_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
+	indio_dev->available_scan_masks = adxl345_available_scan_masks;
 
 	/* Enable measurement mode */
 	ret = adxl345_powerup(data->regmap);
@@ -244,7 +533,51 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 	if (ret < 0)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
+	if (irq) {
+		/* Setup the data ready trigger */
+		ret = devm_request_threaded_irq(dev, irq, NULL, adxl345_irq_handler,
+						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret < 0) {
+			dev_err(dev, "request irq line failed.\n");
+			return ret;
+		}
+		data->irq = irq;
+
+		data->drdy_trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
+							 indio_dev->name, iio_device_id(indio_dev));
+		if (!data->drdy_trig) {
+			dev_err(dev, "Could not allocate drdy trigger\n");
+			return -ENOMEM;
+		}
+		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
+		ret = devm_iio_trigger_register(dev, data->drdy_trig);
+		if (ret < 0) {
+			dev_err(dev, "Could not register drdy trigger\n");
+			return ret;
+		}
+		/* Set the new trigger as the current trigger for this device */
+		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+	} else {
+		dev_info(dev, "Not registering IIO trigger as no IRQ has been specified\n");
+	}
+
+	/* Setup the triggered buffer */
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      NULL,
+					      adxl345_trigger_handler,
+					      &adxl345_buffer_ops);
+	if (ret < 0) {
+		dev_err(dev, "Error setting up the triggered buffer\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		dev_err(dev, "Error registering IIO device: %d\n", ret);
+	else
+		dev_info(dev, "Registered IIO device\n");
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(adxl345_core_probe, IIO_ADXL345);
 
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a3084b0a8f78..b90d58a7a73c 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap);
+	return adxl345_core_probe(&client->dev, regmap, client->irq);
 }
 
 static const struct adxl345_chip_info adxl345_i2c_info = {
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 93ca349f1780..ea9a8438b540 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -33,7 +33,7 @@ static int adxl345_spi_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
 
-	return adxl345_core_probe(&spi->dev, regmap);
+	return adxl345_core_probe(&spi->dev, regmap, spi->irq);
 }
 
 static const struct adxl345_chip_info adxl345_spi_info = {
-- 
2.20.1


