Return-Path: <linux-kernel+bounces-118361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939388B97F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702B7B2286E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BE174BEB;
	Tue, 26 Mar 2024 04:46:46 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134385B1E6;
	Tue, 26 Mar 2024 04:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711428405; cv=fail; b=oLRYmMaXmI3hK4L3Ni8A5zwsWHv+ghTGVnPWV/8tqayg+1X+UjYAK6yE7gaYcfA4bOB80XavBXEQH4WELIuEz1P87vwNtpIriR45lHzR8lF8TykjKEA+eOPZQ8AfGcXcyLQtPvfk55nBVoCQhK5XbQpW2rFX5JZjOzLV3SpEk2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711428405; c=relaxed/simple;
	bh=7vP3Gc+Ho6xyy1bUk973u2WS+gFUP7mWhupOiH231tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7bpbpxRN9x3k1UrU5X9AFFwBDLFYUL6YEA+svPCsAji+I+Mj1p0wKJQD3WtyuQzr9GgLii8ILhMgzStt9TOEUdAZCoALAnLJUIjroFPS+Tt7rkQ33GECruPV+ohEuoQmBI/CHEjffxlzQDHl5zcfZwJG9PU4hby8KFAVcstTEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2XAinq8k9VhKKeYMPe8AZHDP21noauL0ivLKUcO33cRzUsI01FaeekIPv5WFCSxlDGrDrsz9nAV0gSKHWGCYmja3z8Y+C8sbXgQyopp9rXibNeHRMlS52+XY2mzMCwR4kc2MjY8sqje5y+KhZS8qJ6Ge01w0pjzxRfewUeC8D9cVJcfSCXXFMi1ABpCBVZb4IYfTmSrrgadvVcNkKCEYo4oG3zuSxXBIXG+ZKDH5+OVNn6N6Sh3DEkaWbE8D6UMQ50kqicNx/PIrDTeEc7qC3KS5xYHhLDIPPfC/bKAivQdimdPw3cf3Izyb3XaWDOq1v2IpKYEEy13t0ahMwzKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1y4Od0XhZZgH2wkf0U7a9cpksgvilO8PHN0vxOHNkk=;
 b=Tjzb+LdTerc0HJ4yxxu2n7rkvCaIJj7Qsh7LiMJ+LrUpqEc1ZfYIop2KP4hPoEIdU60/WYPkgSckihQAc4h+yW9Hb01XQA4PnfLzQa1dki0njss/Xon5HanEw2vqXXjhGX669On9CoUw0+kpaIqLpPwXHFT/1tBBhgOjyv/mp1Yav4wDYacAJ7JjsVPVxgkBYOjlakALikp1qytJWXW3MvG+PNgHUW/z5HHZaLQM9OSqOrzx8nmSgR+GAO7ZbF8YnHddnxxJ2uI/ZxF+7JK/79ReKFUhkiZq2R0lf9Xi0mYKQNfrlkvm9LYFZAoTgE0lbzCHNbkpdX8X1R2hRY3EXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 03:12:47 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 26 Mar 2024 03:12:47 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jayshri Pawar <jpawar@cadence.com>,
	Jai Luthra <j-luthra@ti.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 1/4] media: cadence: csi2rx: Support runtime PM
Date: Mon, 25 Mar 2024 20:12:34 -0700
Message-Id: <20240326031237.25331-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
References: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa20edf-6693-4f3b-c6d1-08dc4d429c7a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4dnXPHYogcaxAhlXTfsp9cNKtOxik/sUYU8usq7GBIScUCyGcqdfiBFfeknLFN0tuVjf3ZQyGq1YXAjL7Nmro+yqw5QYixPa7trLZIh54snzEFE7xNfvFoskLPcazvp4UZfZVhE3XZqa81/OcBTubUKudQm9cZ7fxlE3VAIVY2KttNg7643mp6YEc779vfL5HWuKvjcVyAlp54cJ8Wa7DNx91gFCN1gFt/EpLKWLRGtZJfVLx/PycMlfJzf1ijCaL207HyqegPYAqC6E34NEn3d50Ll39EN+18j2S5asMeKInOSLBLxYblYVgqBsQ0PTx6AAYLDygih6PGrViOBmKT2Kzg4uuSydT2LNhXA/eQ1Y5ORHn+RTt6j4NQYgDZoS3PanqHNlyf2UbawyGHRLmrvZtQ2N+vpQZADUo78Lp1ncxNR/YMTDgrQ9tiTEulib5WUcCVrdvSQ3ybMLQiRASQPTpAJVovoq6I/ESavtsjA0FiAopA16xB8pRxyv/TxVgbWe9pIQKHuBEbvg2UxWC5Knj3OUr9ESH84V/JLSBzF7wVJATsv4g66jyV3Mk6mKJ78pR2kJ2wJOYames2piTv9LHCBwc7nExk4+uJpdIl3B3cqzAUTUyDm634TDoABq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(41320700004)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etQA1UgOAA7rRBOjY1Ts05X7LpVpQ1wSrTXhwpdiEioWaBQcCzFx+4ZrqDNr?=
 =?us-ascii?Q?igkN1y1ArlHKhI96xcr4SwsOAI6bA3vOqQX0GYQ6aSGHV/dHXIqN66NhmjX/?=
 =?us-ascii?Q?Spho8xbi9kW1LPGMTHryoqkWgG3ODZ+vF3UKPh/uiteC8vopeDD+ayxsxZ3y?=
 =?us-ascii?Q?2G/b8MrF631PQu71+gs6ArG0HuW5rVjGOAl6K0rTzMTG8MhZSzFZ8WiVkblc?=
 =?us-ascii?Q?yusLX9pTqgRWSVL8PlRR6xi6L2vbmmoIwaBY0KIAbwtiBhWDY5VrUJqaacCm?=
 =?us-ascii?Q?TXsAtdO9coIJDMH0N6nsWSsHujDd/fqYO0KO0ObxyavyCP8Sa2gm3hksdSIf?=
 =?us-ascii?Q?Z/bONHE8WbEYo1Jj/61U5+BQDpw2Iki0+t779MhJBdBn801dIYO5DQEoZRXv?=
 =?us-ascii?Q?lN4/6gxz68eNO5pjR9bulpp+LNbX8e7I5Qx85maP2WT8MtR7yTPEKG6kLqJG?=
 =?us-ascii?Q?utVqS6x/yFCvf/ceKC0+brrcMbqdqOPdFP45Ldla4ThTP+hgTbYj69F7oIDP?=
 =?us-ascii?Q?TSruUmObhnj5IzxdrFIngfVrWvtdawlrvn6VGXXtiznmU1defg3R2ei6SlS6?=
 =?us-ascii?Q?Y0YqSb4RDKIGPyFGFMrxbe9weOZoqIcZgSkLbSVH3V1dptTJp0O+JhBCuE5v?=
 =?us-ascii?Q?Hqdj7PpYvigpjKn+7+j0KREQBmJ3WqlGpuIk51yRt9FtLYJRV5fAdXG5etQl?=
 =?us-ascii?Q?DidKsuxOwgIQsb5H3mKmXLQl7UeTFBZBKdtSuLvvrroOL4n03hmjKIN4VpsT?=
 =?us-ascii?Q?nbY3Cno8sFmItVjw4wHDYWpJU4u1x9UaTLDPERZWsW3xVn8w3Z2RFxHO+j2w?=
 =?us-ascii?Q?V0bYVxEZ8KAPV0Y857dBdSzxLICO3I0SCdDWQgtNDgvFQc27Dyi0682zGR2a?=
 =?us-ascii?Q?evoIleYqNLOZXFuXJ9S5XzXUyvictyLRzvIhmg5mZnRYF9AnvRx9n8lXoSrH?=
 =?us-ascii?Q?TSpSQhCRg6rfYKlDOqSeIp1Mty9/lAvTWykbDQIFRpSKnTPpa/r5JXcaMysq?=
 =?us-ascii?Q?JEFxhMvSK4j026slP6GBB2i6tRfo4btOot8yORl6NxCOeOJyRyTFlfWoUPZF?=
 =?us-ascii?Q?3Dsshl7q3Ik9AQC2SXFGwHbOYKeLUX8m9OnXanWzjS/BaiM3YqAl/Cy3ZFxt?=
 =?us-ascii?Q?skvOJ0jyhWYFzSgcNS3YgaBGV+msPIQBVvkJxT+VvLgj7nnjLHx+MToCWB0a?=
 =?us-ascii?Q?r+isALl3jbFfCN4fWNDmzPt1hcaId9G1CriMlVvMhPY1zQPJzAosdTlstQRq?=
 =?us-ascii?Q?cLC5nuOtQOfpl7QKAxBEYSwZqLn00x16N1wFvND1cMe1Vmwm72oH8Ijes4sI?=
 =?us-ascii?Q?YlrqBt3dICCcWXx3qpTA4e7N36HT1FP79LjkRDmC3OLAnC+lX+AsAcWzSCHm?=
 =?us-ascii?Q?0hFvZtgqFykiH1NHo8OssqeKV2k/osD+Yr5UUqcF4oVMuU6cbFmzG91yA6K2?=
 =?us-ascii?Q?9ReZ7Kw7QDkPBFJ6Fx/fWvRRACD+op3lLREHt1WySUn6isTz5gkoHjubS7+j?=
 =?us-ascii?Q?f9pEoKgcBLoxCCOJgnJT7CmduWmsX4zFNWFYuTqnI3jzc9ley+wvJK1E4QEL?=
 =?us-ascii?Q?GQS38d9k/kzubU28hChRhmw2fIrB8GRjZ/+w439nbfdje+2N1AW5rDVfiGc+?=
 =?us-ascii?Q?kRLKL+g7DHduue1x9P7AOrg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa20edf-6693-4f3b-c6d1-08dc4d429c7a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:12:46.9486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co0MiNhgEwktfsSY5W7wpctxtKnHBx7Si7e0+4uKsV2mh4Bo07GZdFoK+XNlPGff2+I8zqEXkiWg+F7J5qPUDZo3QWFFnlk6Ychl1RRqSvzt9haUjxqPv/BJvMhK6lv1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

From: Jayshri Pawar <jpawar@cadence.com>

Use runtime power management hooks to save power when CSI-RX is not in
use. Also stop/start any in-progress streams, which might happen during
a system suspend/resume cycle.

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Co-developed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 43 +++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 2d7b0508cc9a..a8b86369e34f 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -364,6 +364,12 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
 	int ret = 0;
 
+	if (enable) {
+		ret = pm_runtime_resume_and_get(csi2rx->dev);
+		if (ret < 0)
+			return ret;
+	}
+
 	mutex_lock(&csi2rx->lock);
 
 	if (enable) {
@@ -373,8 +379,10 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 		 */
 		if (!csi2rx->count) {
 			ret = csi2rx_start(csi2rx);
-			if (ret)
+			if (ret) {
+				pm_runtime_put(csi2rx->dev);
 				goto out;
+			}
 		}
 
 		csi2rx->count++;
@@ -386,6 +394,8 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 		 */
 		if (!csi2rx->count)
 			csi2rx_stop(csi2rx);
+
+		pm_runtime_put(csi2rx->dev);
 	}
 
 out:
@@ -659,6 +669,29 @@ static int csi2rx_parse_dt(struct csi2rx_priv *csi2rx)
 	return ret;
 }
 
+static int csi2rx_suspend(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+
+	mutex_lock(&csi2rx->lock);
+	if (csi2rx->count)
+		csi2rx_stop(csi2rx);
+	mutex_unlock(&csi2rx->lock);
+
+	return 0;
+}
+
+static int csi2rx_resume(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+
+	mutex_lock(&csi2rx->lock);
+	if (csi2rx->count)
+		csi2rx_start(csi2rx);
+	mutex_unlock(&csi2rx->lock);
+	return 0;
+}
+
 static int csi2rx_probe(struct platform_device *pdev)
 {
 	struct csi2rx_priv *csi2rx;
@@ -705,6 +738,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	pm_runtime_enable(csi2rx->dev);
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
 		goto err_free_state;
@@ -719,6 +753,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 err_free_state:
 	v4l2_subdev_cleanup(&csi2rx->subdev);
+	pm_runtime_disable(csi2rx->dev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -737,9 +772,14 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
+	pm_runtime_disable(csi2rx->dev);
 	kfree(csi2rx);
 }
 
+static const struct dev_pm_ops csi2rx_pm_ops = {
+	SET_RUNTIME_PM_OPS(csi2rx_suspend, csi2rx_resume, NULL)
+};
+
 static const struct of_device_id csi2rx_of_table[] = {
 	{ .compatible = "starfive,jh7110-csi2rx" },
 	{ .compatible = "cdns,csi2rx" },
@@ -754,6 +794,7 @@ static struct platform_driver csi2rx_driver = {
 	.driver	= {
 		.name		= "cdns-csi2rx",
 		.of_match_table	= csi2rx_of_table,
+		.pm		= &csi2rx_pm_ops,
 	},
 };
 module_platform_driver(csi2rx_driver);
-- 
2.25.1


