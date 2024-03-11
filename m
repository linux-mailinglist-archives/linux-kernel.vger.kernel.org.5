Return-Path: <linux-kernel+bounces-98749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E111F877EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118AA1C20CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633483D986;
	Mon, 11 Mar 2024 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="k3aJhzFV"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2133.outbound.protection.outlook.com [40.107.94.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2D3D556;
	Mon, 11 Mar 2024 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710155680; cv=fail; b=q3O1Tk9VsOAvcjy4fLpcx99TfuOWQJDQZ6532GZBJODsecDzScWzHNXMH1h/Sy1wVfWbktERsNFrdUzGCmOmKIa8aeKs8HfswVZQo+yLFBhnglBTip837ZCUyIsd5fDyKaPRH3IGNjrmXwc6+g+NDd/eK6vfbUgVjgM8UU7ua8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710155680; c=relaxed/simple;
	bh=LqZxRBu72sZ5DtA6tqfahM0Zsk7K+kpu0T/sAawRyPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STRXfSjyZ6mx9Wgwt5sd25SOMVxc7Rb/EUO4NfandrmDjTTXrSM944TcJ7rVw0Zr3KuZG7UXbBDSjmyeGL4l2QfbDyJx3lfE3S2YS9IklBeH6+XotXJ1leX4i9ENvv9hGGgknm3prfHdNN4/5GCYApBOuQjUW/34u3jAuMEy5zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=k3aJhzFV; arc=fail smtp.client-ip=40.107.94.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+RALAhWGdWmtwbPJSUjeoGOKJ8p7qFSVb+SCREveH+Lk3pCkRT5eUEGvVR7rcRZ28gdTxgjdnE6lgFOfeSDZVxhtc2grojYG1ViW405nsYEqoxpPiud9Ji01PqSTPZtzrveII2yh0iLZo0kiFANkhqUedHCvDeYKy1huulJBUrFBxcT22R74YDY2wcwOJX2irtV+3hXhD9B0Zn/isBWP50CNgTBZbTlERuKCRZ97s9ZUWHMmA55HnlSYbzOEX98PF+Fax1cRjKL8tWM2dh45sGXZrhxCknU3VV67vnaMCRtMVLm/rF6dXOShrgk7RRraQOaF4ocYNdX4xQGFJpNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0u40wOJfOwoU4DKcUXVHsuNz8t8DGXO0rERZzjej3E=;
 b=PJvDroDVvrF3Mr4d2kiU9owGQkCqJG3Pk9PVEPWUyQ2disdY1cD78okH/cvdxoMAPbl8coD6QZCEKCdPPJAMWujSZ4StMYbXVhedY5kuJGo2zSwXw3Set4vUtmcOoV3Zp4b4x8EGrHqk/Wg2KZZjjVPUxSQwbKEk9XnheJMS5c6+Q3CC15VMl5viHeM7VxUPh0i120B2zItkDro+QWr1wb1lDO1uNbNaZlGWmOrh5dAzxfmrQADkNjRbO79Isb5K5STGTd9nIBIZE5AqY3zY92gs+aPogZFKZZ3BZuybssud9hGyCKMkjeu+06fpEfxN3fRI0CrkXyFl7fXRw339zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0u40wOJfOwoU4DKcUXVHsuNz8t8DGXO0rERZzjej3E=;
 b=k3aJhzFVv4h3FT0dkNfOuG9xUJPfp1JCscWRpsoh4uvJjmwvjb69BmS9iPB0Qs3CVLiaCEkJ2v4Ea8bW7KN/4Ad9DOtha7Rd9jm0RX+wu70xz7FHpZlRGtrU0Yx3RTNMOZnrngeGOERC813IHwCCHbv5Yqzrb5ldDoQuuDR6BT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 CO1PR01MB6741.prod.exchangelabs.com (2603:10b6:303:f2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 11:14:36 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 11:14:36 +0000
From: Chanh Nguyen <chanh@os.amperecomputing.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Justin Ledford <justinledford@google.com>,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
	Thang Nguyen <thang@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Chanh Nguyen <chanh@os.amperecomputing.com>
Subject: [PATCH 2/3] hwmon: (max31790): Support config PWM output becomes TACH
Date: Mon, 11 Mar 2024 18:13:46 +0700
Message-Id: <20240311111347.23067-3-chanh@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240311111347.23067-1-chanh@os.amperecomputing.com>
References: <20240311111347.23067-1-chanh@os.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|CO1PR01MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: da385cf0-3817-4bc1-6637-08dc41bc6fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WfsU27adHcRdXAKZcrfNjjsPccytwwdugpig6Qhy/8em//icqzmxU4Hg0z3iHK3pix1ARI+tVNpHvb+Qj8uE2QZfb77kBVOpTGcq4Dkboykgj2i8ZO98XAEagTEckAChryq7vmb56vyAP4dAua8/fyQTIr/2yQvNgjnxeZPLrcyPSF13JUAFcjKHtXLKpMZfV0WmCZAp6QNALxPvHF5prwEhRCkeJEGh9Ez9CNwcGCEf4wR9Kli8e9grTgnATdWpOAuidYTjnwFA+k3zOaefxWyzkrccSNrRJsA+Ayt5rgkBV4rpp6jVyjO/HyrHD3qohF/D6m1JldTAancuBR89IdoZ68G51xLW3qnlByaxjitYwH7w6lO8hrYmHX7t5DlfjixeKY00wn1BYrOsTb4dXu0NcMkYJiesxF1zU0jk6ymqLEnh3H/JDK9tOER9l4Dc7xcQU8ek2tivVKuDpAu8Rk4RGr0hiiaUeKjghM2JQXAc9dHLneQ09numaLFmMYuWPVj3c8tnJeM9Fjg2L8wFOGFMhjIIYIhUpYgSqCSY4Sxat78wpDutCGTDExEKEohJsWfdf3FeMlAJGDcxu5yBu/M35mhfcodh+pFy8/46s4HmUVd88vTRfDE5jJ10Lv7QH95CZvbNloW5GfvTg2u+TkU4/BASrHTB/T6HAJBdP8xRQPyxPCYt7e47lCaCnCIgHGF55zTf9qQWEv0VGu0fX77TcmZaxONJUcTahvsl8kU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tj8yy3k1htddNRIYszg9O5MvkKU5CFeYBNPlneH+ScfQAEihxgLsgsuDCuk4?=
 =?us-ascii?Q?7soO20w7PD88KXObcwEntOX1ZWiKOxM6U9TOiEt1NUAhUMR/nWI/IpwlZarf?=
 =?us-ascii?Q?Y/KPHuoHXbfNkc8+gLcJyJ1DY1Y9vZt8C/Rc8yAK//NTdVPo7unPOJXsI3vS?=
 =?us-ascii?Q?inCukDh6VltWG3cc8wu+3kVYBpcNQ3eRq/QQxWV6kp4Gzor9wFj/aNe7oRqY?=
 =?us-ascii?Q?B/WRNHGYUvDJWzhljy+ptrR8Xky/tPxjvNRXeiPFJh+9UEYWbvPBAmPC2sdp?=
 =?us-ascii?Q?N2NhDhq3CPyvCrvc9GGjyx2SH3+WPJfMzZxYhkgY7J0IiwA9P676nMhf1UQ0?=
 =?us-ascii?Q?Ai+J8x1bUAlijAxvDo+n1TySy7fTW6gUgvJrzyObLrfFUtOlNZFF41INAz0b?=
 =?us-ascii?Q?WqxvvI5Np8jh46pjLDx/NxTEbXo4wW2bI6sjpKAD6yjWXCmuisjeeD6NciCY?=
 =?us-ascii?Q?aqNSyYfJfWDG53Tcax6bHOMc0sU+uFfxRT3OL1tN9miJHb8eNWEW1sBQOVT3?=
 =?us-ascii?Q?BhhGwL06adPuNN+XcSbJGWj8BD8WLgrT3cTUkXIvF2lActj1sonlJzb6NGBE?=
 =?us-ascii?Q?ZJ5kw4WqT1vgWEXxusG3FmWtRJKli+CVhj1VUkP6vIE+sz6TrSyEzBtgf7IQ?=
 =?us-ascii?Q?hvcDUlWgtz5P9drQWXAL3ENQjkyaBjKq9sGaRz6tM6akj1j+q7msPpXHSi6/?=
 =?us-ascii?Q?YT3uS/nsSAjZewvLvub8ADlNZBuJhA+c2yZb3tbaMmZ8PqaKw/lx3iETZUr1?=
 =?us-ascii?Q?3B8x8oJehGYZ8cFK09weL4inGkuVOwrRRWhlzqv5xn7qm9H2G9YL/UCeSQrX?=
 =?us-ascii?Q?2tSSgT0V3QgyDnnX2PfLuIBdgrLtgM6RFneHPz5Qp5HgYxqbpcnN8hXy1R0m?=
 =?us-ascii?Q?OAlLrIw0Y+x3jlPF5wcFDM5hVKptme955tu7zoKqOlSf7OVV5ZTHEJfR6d8O?=
 =?us-ascii?Q?DHhEnxS9xLp3rYMUXTHBMZEG1ZiE+RDutrwqY3Ft/KbxycbfkVeCHICReFHq?=
 =?us-ascii?Q?uNrvZD+1w7A54bD0rR+4GFaSoqsTetUFWh5MM4OSZOvdgtfrwoo1UrrHXaCd?=
 =?us-ascii?Q?odToK9xQaoxkou+SnNWSBIE+pFRyud+r7Bq69oq0yS+YQgXsIuvaKqcmq8JL?=
 =?us-ascii?Q?RewilZ8PwJ22U+eWalZC+juDY26UtHVUU1pTZfPqNuTRZkoQyjppLhfZfR+Z?=
 =?us-ascii?Q?POLYEwA24xY0Fkgn7/xl/VvAGFC2h+3T/RoOY3GDiDCl/xOIfPYzdYOdd7p3?=
 =?us-ascii?Q?GV6deHB/qYy0AL+6ljqEjzeI/syF8TKNRAT8/FUgj/Hzrt/ybb0pOrLCkeyU?=
 =?us-ascii?Q?OIuyyL3ZGKq3bp2WnC8cySYH7yUuer7pA0LmtsP3K5C2Lxhjet2BnmrcY++A?=
 =?us-ascii?Q?BvFoYskBpKEtUwx8Z/NIA576KGeeSoK05+rVn6oaDEl97GlLXihRFWgFx0V3?=
 =?us-ascii?Q?Bn/RAfdwOI0y53y93oMtWLa4dYcC1cNeO65rMlmFKS6tqYuio/Fsn4X/Ton3?=
 =?us-ascii?Q?7kqCc0pHf4BS3sWR0ZbBI9hQTa5BmkgeZtakY0Tm8uTjLlj42p8mvHvpCct4?=
 =?us-ascii?Q?FKVRwAmOUt8LG5/xj6Gv0cAhJHhXRqF8Go1txw0UKYvBPSjQcIpli34EX9wg?=
 =?us-ascii?Q?XW0Nke2Scrc7K8P9UYC3cXo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da385cf0-3817-4bc1-6637-08dc41bc6fac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:14:36.6883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH7hqo8vO/dENqX/ZBAiniDmvvDKl1jEYt9mXE5e6mTJTAEIfw+b9MruQMrD7Pdro36iLM4apm3p0jY2R1COiZL3No9pKzTGmXKwn+gl543GZ44QI1qahFeuZl+7I8qa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6741

PWMOUT pins on MAX31790 can be configured as a tachometer input pin by
setting bit[0] in the Configuration Register. When the bit[0] of a channel
is set, the PWMOUT pin becomes the tach input pin for the channel plus six.

This commit allows the kernel to set those pins when necessary if the
pwmout-pin-as-tach-input DT property exists.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 drivers/hwmon/max31790.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hwmon/max31790.c b/drivers/hwmon/max31790.c
index 3dc95196b229..33ca8d1721c0 100644
--- a/drivers/hwmon/max31790.c
+++ b/drivers/hwmon/max31790.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 /* MAX31790 registers */
@@ -506,9 +507,12 @@ static int max31790_probe(struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
+	u8 pwmout_to_tach[NR_CHANNEL];
 	struct max31790_data *data;
 	struct device *hwmon_dev;
 	int err;
+	u8 tmp;
+	int i;
 
 	if (!i2c_check_functionality(adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -528,6 +532,33 @@ static int max31790_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	if (device_property_present(dev, "pwmout-pin-as-tach-input")) {
+		err = device_property_read_u8_array(dev, "pwmout-pin-as-tach-input",
+						    pwmout_to_tach, NR_CHANNEL);
+		if (err) {
+			/* The pwmout-pin-as-tach-input is an array of six values */
+			dev_warn(dev, "The pwmout-pin-as-tach-input property exist but malform");
+		} else {
+			for (i = 0; i < NR_CHANNEL; i++) {
+				tmp = data->fan_config[i];
+				if (pwmout_to_tach[i])
+					data->fan_config[i] |= MAX31790_FAN_CFG_TACH_INPUT;
+				else
+					data->fan_config[i] &= ~(MAX31790_FAN_CFG_TACH_INPUT);
+
+				if (tmp != data->fan_config[i]) {
+					err = i2c_smbus_write_byte_data(client,
+									MAX31790_REG_FAN_CONFIG(i),
+									data->fan_config[i]);
+					if (err < 0)
+						dev_warn(dev,
+							 "Fail to apply fan configuration at channel %d",
+							 i);
+				}
+			}
+		}
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data,
 							 &max31790_chip_info,
-- 
2.17.1


