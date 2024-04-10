Return-Path: <linux-kernel+bounces-138568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37E289F3C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B728DBCE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B115DBC4;
	Wed, 10 Apr 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kuiF+ddo"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2067.outbound.protection.outlook.com [40.92.98.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2928BE8;
	Wed, 10 Apr 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754861; cv=fail; b=cJh8tJIRtScOIFkiMIStTSA/em9uFycdqZ0qHML5VAUOq6TnTZOKxdJP4zm2xTDqkOhgdWLh92lEo5780c4jirYJtfgI9+hl3t4NNIbE2EaVpvKxnKuGDtn7g/BUyXCJo2zrEUXFAu0PNPCqKrWpZ1JlKeypZXNTtPez8568tfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754861; c=relaxed/simple;
	bh=QmnEMCgM4hVQST50qmJPtuyWMEJocxOQ2zHaF+siy4M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AxYvqQCvnnbY9Uf98jGAwSfpONAndXGuxgjhvaUq4nwmIUU5zDV6WkZoXQ/jYUf1HBjthkNXTQPJhBBAbyj9yokSoA9vyywVpXLPFU5F60YqPYS7QO3v42zi3/V204uLWSXZBrOv973VK0LtpM4EWdI3HprY8w5uWgqtr+yhKks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kuiF+ddo; arc=fail smtp.client-ip=40.92.98.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqAt4clPuE/dWAZrzGiJzdjnkfLR7y+AB9b9geanpGcbCk4TXNyVqWilO5BABPxldHqfQB+qLv5avN34YVaB8hitipbqMRaqfVpZm3ylFFohqvA6h7nSBSOQkW+9Zx9C5Xwwt4HOrXxQoENwM/UvC8CwIugzWVbacDxIqkVgiOvxSRqMgiNz6G3bKjw2lOiFT/eDnFh72mIkyh5u/hRdtT6qO/7fwawswWNOMeG68bK2leG9elEksiCtZy+6RaJP9ALz+WnLb3VVg8uTzUg7frOaSqnOyiny+XzWc2C5qr5w0vyz7jQaJTf+zdQL1uQAwOfjckLeBqdcShWa0JinVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+ft6SMVC4p95cIMPSX0HaZbO8mr81+ul8zYJ1LDcSk=;
 b=hSHqehYwD7MFwmE60RtmIjfQkWXsZBIAwOIRSowEINvfyfsJibS6QSUdvsReTbq9WlhDeXETLyn/vsaZwvi2jhogOjyRbTAtAeUm1c5qJlRm8KiuzMCYMbJLySV3k9sByZ6zxP7Bu6ddrSY7Of54D//QYvaAYTJ/HVy+CLo+ccOvevpKcXhysso2UsIxRQkMREShO2MmPsh5+YkRhWXml+3zRks9WzQ6ZpF6ItLZNFQZNPnSv9h2QSyoaAOVrLz1qccn0xOGW6h1tSahVmIIrwYUhmMa+4tjTCUTwoeG02WTlcqWKW67R1LZFppBYs5+qYVCT3nOon1q44+g42cd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+ft6SMVC4p95cIMPSX0HaZbO8mr81+ul8zYJ1LDcSk=;
 b=kuiF+ddovAmc1ceCe/dP3ZHE5h0yix9RfRgEkBeISeq2/RCUInynxdDGqxprOHyzSC6Q2l8MRL6j+p/7ZU3C0Tpy1JEkm21zTUhgLIyRq6buhEeXgNSiTZn6zzJoM+QlZJ93FJzL8s6uDOLtTv1XjOJ3AE3EVXV2Rf2qQHGPRw5PWY7BBMfymEJltWtZQ6VLTo/yO57qjGLELsdyl5mxBSO1zkLzA4z2wmmzkq8qRWLdWzywc+2sc2S8ceyobuvnRJCKzubVj8q1wQLfblOd8S4E3IsFpeoFxD3WrjILAhQx4S10yLkh8sCfKK8dYzmCisgZugxhj0U5TCaXmo1nRw==
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39d::8)
 by OS7P286MB3808.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 13:14:16 +0000
Received: from TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::12f8:ae5e:96cd:21cf]) by TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 ([fe80::12f8:ae5e:96cd:21cf%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 13:14:16 +0000
From: Dawei Li <set_pte_at@outlook.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] watchdog/wdt-main: Use cpumask_of() to avoid cpumask var on stack
Date: Wed, 10 Apr 2024 21:13:59 +0800
Message-ID:
 <TYTP286MB3564B037A81DAAE1AC3A16F3CA062@TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cvcm1DdHhFApAHmG8guPahqOkvN+PA0p]
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:39d::8)
X-Microsoft-Original-Message-ID:
 <20240410131359.3379-1-set_pte_at@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYTP286MB3564:EE_|OS7P286MB3808:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2a24e6-6725-45c4-3c89-08dc59601fbf
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicAfKI//0yoNlkeQDymwpEbTmGzQXC7VM48SfY5opAxjn8OMDCsEzQff97ou1P28TX048Q2M6MDGD1wEy5snxP7596o3ok+IoRbs1KhdWh0EJ3QN+nFccCz3VbILNrWjDScudTvXuCrx4T4jMM07HVy+ynonmy4KomeysS2AvdE7aWXfeKNjUmcq4H7K1hLqBVQSt4wyh6QlOd2hAPkx9ht3HEQNnJCuMGCURUZowy3H+0r4KnYif5N6SuR1nD+sDpdkhgrpassc6Sz1bJx4D4wEMX4K/PsQMgBT2z2DapCCv0Z+Wm6nn+r1kEXOAaLZd0eCzNmkaqaaJ6gZ5iHJKcO4W+dj6c16KYA9WlnfJgXOT7qSML+lfestHTMvV3m33vl0av9hjqdRP7dW398Hv91rF1dQTbbOR5HF6Lu09s20kze+8PeltXnia+ICoSCEcICuElTf0olHskjIpByuRnVPJLnehfctgIMkMvR8COSRhStBoo0rixPcwSEFEQ3JHoynqej/ZWyzff6Clp/BaPOAm/+GwqU1Ev2K1OXt6Jf7ge0KnMSa2IllgGFk+FmCVTW72sFJXr8nWhsosMgP5X58FaW0TbFNY/1xmv7KdYvaZLPA3ytSglnwWv7/D2m/7rkK92z0RWce4f7FMAcafPRy/j9LDA3JUxBJwZZ3t2qZW5nSefw/sFKRnEvl2n8bYf7+9wz732EUZXqhRwRFPTlEjlclFQnfoTw3q50h8f8ujA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U1G7OiwgVW3o4cqmBJy8ZZTvnfSE4kzxLwTTizBCZVT/QlwqyjPNDgJDeI2pjwXMjKlpV80KpTXjqOmwjn728cQkLjBsubptDylzTfSeI8CCD6wJGjfCnV6gWx/AD9CMK/xfgftWmEfVSKTXBCPwqXG3/aLgCYhbHSYN4kTG3Z3msGKwK16/JcoqWjbXGuz6WsfLOFdIUlW9XsUIpyAVLCrJEXAu1RkvZbumGqjYMq++Kv83ISBfyn2M3bdiXuOumwH5y8Oo6mMQu7ajmeHLwl9WPekZPZUWR96ZfAFl/kkiJZJjtOaLV0PxiKMnHAzRewG4+p6DRohNfAGNXQJ/tvBlrMwaiSDqEk+xNcFdAicaMVBzS0+ZuRElZ8qrBCtsAcMPiv/BvjBDZDTv8ytgeRf0rMGRXaZCZzcGcKXMopz7h2CYGA0CqNpGiko9DLP9FpPM6kXjXzxb9//v9kzw0eU155T6RvXC79YD8nl0Wglrk3UC+wyLkH8wchmHJEgv88WtaYTKjug4a60bH/LYFzpcM1ycQmBH6emonZ1PNrf8kkt6qmhp6F4ISf8c5KWV5xNRYAFgXQz8rtXjd+vE8ShXubGqrHYjFTHRMrYTD8Sk2ZnHDc3kJHp/1S3t/W/a
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mEFvO6uH8bMz9FRmF97n+bvCn38zkG4VFI6B/n18yupt0BN/TUluORPIFtfc?=
 =?us-ascii?Q?WpivrJZmxuQoiystlzn9FfM4mbOdiyz+TmGU+4BdOCYU2iTwiN3IvmDOQge0?=
 =?us-ascii?Q?Msm5Tpe6rOdjGF9nwdK5M6yB2A9fMyTyyQ8S0cvpEdVwATjxLbh1JOlXA2iE?=
 =?us-ascii?Q?TGoafkIcqOgm+sddhimRxFsdtFkYhoVjhgESqVZpybIV/2gE2tOm7fgSDwvj?=
 =?us-ascii?Q?88pn7MLT4L/ibLgqGgv086PbsgZBYnpuT1UpfgCgESuP2xpaKQ9ymYC40KWK?=
 =?us-ascii?Q?pYNfck73QWAoufhb88NvfrZWKc4iBApCCB++EoyfW9gUccNUr03qKQ9ZcU8Q?=
 =?us-ascii?Q?Un7EbEKQlneU2CgZH/ASlfU024TqF/h/8ENxgEdxp4qb3Z2yYFkLn3Lb92cp?=
 =?us-ascii?Q?bikR2m7INUUKOIbr8xB/dC2CTZxBcDsm0v2DFBwQOfzvS9RvxNv6GyN+mUlw?=
 =?us-ascii?Q?zsWn36zPe9Xomo4d2kVLPX79qQJSB/LDbZ3oQYbx2MtbbXzg0uZh1c6IvCuh?=
 =?us-ascii?Q?X64TykY3aoNUbHl8GyAH23iD4iwH0O/cYvglF6mn1OYYGL0JhoHyDwWwy4Co?=
 =?us-ascii?Q?B9V19dVGmAHnzS01ZUgJDPCuGvDl3MI1TUCKbga3DB1uj8sC+uZsWvroj3O9?=
 =?us-ascii?Q?1c7XYeYi2PXCE+irHM9aVdtCJBkVDS0OuWyehzZP/3ElLiewGC1HJHPz09gH?=
 =?us-ascii?Q?AtWGyY4r3Q+TPO+vcQq7mzFnIa4xHA9VtTIvbQZCRbe6WUGv3hiJEer2N3Ut?=
 =?us-ascii?Q?MO0myuuhhMS88aCYMUSk5y/b1Cmz0LRmRp42VSFntQI/FwqFeJxeoiVKFV2S?=
 =?us-ascii?Q?5UrxyI/NCFCK0zYuWm2za8d/USuRaLisCofLscgSIgCxvA0JU7Ah1mlem60G?=
 =?us-ascii?Q?DgTXNpV4FBiaUlpa+Zmmwl2rJV+1IN5TqSJj4A+b2VnYPEKWQeOssXT9+oBC?=
 =?us-ascii?Q?SPxURyGjyR/TXDzp/McJ7eC0vgznbrbTYsjnvvWdwnDnCvAVpPI5uQdtcOkN?=
 =?us-ascii?Q?OqH16RoRXiCiQVIn9rQH7/kodY2Ttyw3t7s4/j8RUhnl6y40LLyU60XlOpP+?=
 =?us-ascii?Q?O2ycIdpANKs4QoSSwtOdKGTuHdKAgDqdtPYG5YGW9w6Fd9yeoS6rThMM80/z?=
 =?us-ascii?Q?qM92DAguR+TVkn7WzRRQDhBxkG2ofAj61YtGQoBayph9PUsy2euQN1lFfCuH?=
 =?us-ascii?Q?DXjW2NR3SSyU6dZkPz6rlPlnehfXORswxeedb4QkUPtcAqwezSGcRRQBW/A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2a24e6-6725-45c4-3c89-08dc59601fbf
X-MS-Exchange-CrossTenant-AuthSource: TYTP286MB3564.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 13:14:16.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3808

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_of() to avoid the need for a temporary cpumask on the stack

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 drivers/watchdog/octeon-wdt-main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 0fe71f7e66d5..52d49e4e35a0 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -381,11 +381,7 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
 
 	/* Must set the irq affinity here */
 	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
-		cpumask_t mask;
-
-		cpumask_clear(&mask);
-		cpumask_set_cpu(cpu, &mask);
-		irq_set_affinity(irq, &mask);
+		irq_set_affinity(irq, cpumask_of(cpu));
 	}
 
 	cpumask_set_cpu(cpu, &irq_enabled_cpus);
-- 
2.25.1


