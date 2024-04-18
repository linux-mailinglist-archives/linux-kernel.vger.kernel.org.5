Return-Path: <linux-kernel+bounces-150814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A4F8AA4DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB944284034
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDC9199E89;
	Thu, 18 Apr 2024 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="A+SRjdQ9"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BD194C95;
	Thu, 18 Apr 2024 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476883; cv=fail; b=plsaLq4i4kiBMZkEwT1OwkaaIo4sn1zkOGckhLw+qeDCY6nIxMk7mBC4VwQRsKf4YLyNlcFtvdxZkYy3LfNL0lGzMRNo6NWqZOlnciTnZbCVynhF/ofYBrYvwD95ZRrO7/2UwMVN/PJdnJ4/P1hY3865qudRLf/+HFOxxKQojI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476883; c=relaxed/simple;
	bh=xFSh2DbDu6yE21sRDsOGdxN9r3MhVlmpZcg8qQh8dzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OeMvoBy70SX/XaJVrRrVk+i9ac1q8GoOU/mxH96y9dp0E8T765GZtvPz+D08Xz7Sxg+drRk51NxS51WyNf+MVRLw+JP4WgPDdfZuU5+MtB7KQd85buDe3fTaJUGsl2eE02jsayhJXlsGE1O9eiCPHABc8kXKpauc4Plz4nqjoMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=A+SRjdQ9; arc=fail smtp.client-ip=40.107.20.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr82GjcEThBCQ6EVKhE0vlBphs0cxFdz7QZ1OasFhRXIgzDHH/6SDBeN1clfBQ8lruox11XmjYchQ5AQdgaLNelcgcK5UevPOzpckNgmMJNd4O6BJ3StZ42RvO4F7XT5uhibwV+JQT8/tQCDvJhwZS0LOlqKlqOp5iE+JgPOzbNSmYUpH3DV0LSoDH+9Dnme4DBlz7QDySF8BDNyyHa7rvLWqf5joveQe1r5uPgGcYVD6XDF1iINTLZVSjNpH6u3ERuitQbj3T6ZtWb3r4aRQwnEYRv6AgfYJkwsDB6FE98+VvFxTZqjxqi/bcnxl+Y/nZnBEf03zvtkhDR4MIRe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoIqZuUiB4wQE9VPsDGbRAAwtBPjN4FlMgcnEcfobgw=;
 b=lS84WoMLKVKOo4Ui94MnvVWF0lNCf7NquauiQ8EeLniRS1Fy1TtKg5NFO7KexOO34houc1KbQQ4JLry7CbduyRevEqS9Q2ZVWXz5VffU5DlXH0r/M2VkOhtyFBmYAqb1llbkhEIWoQBtJVy5kap/Gd2ZkN27bVau3WtYhUim5+l1G7TUs002oUqIL34MSfRR4ZQTAJFWE4v0osBMqA9eliUeB5PPP95mMIQvpFKajQANrx9ZAmiRZIwtPunENv/8/kOArgcFskKDmr7IzEat8KJ6IcyHgHfJIe7ugVg4LJ+WFl/tGTqa0NUqIlqS8qyKs5tQba0hXJhzwg94HEhwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoIqZuUiB4wQE9VPsDGbRAAwtBPjN4FlMgcnEcfobgw=;
 b=A+SRjdQ9NTUQAwGw26zWIeK1vEtPfZDV7aFny4HbhFsxGTvd1ljwdOIBMK0mJ7zDB08UFzUkbs00XAuBjRK27Q2H8JyvkK0flQDk6SnAGQ36aZrxUXSQpC8w3dmF7KWVamz0o+88s5qGOjGSoSMYbuTkw86kFw4KP3CnGnsQpOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 21:47:42 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 21:47:42 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v2 1/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Thu, 18 Apr 2024 22:47:25 +0100
Message-ID: <20240418214727.10658-2-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418214727.10658-1-mohamed.ghanmi@supcom.tn>
References: <20240418214727.10658-1-mohamed.ghanmi@supcom.tn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb6d456-aeac-40e3-cf10-08dc5ff12c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eWtgpJWdFkcBRUXqkbKn9eUyZw1fxQcFPWmwhJXlLRPT1qB5pj9Bil0Czv6LMDPFNgGMzRvj3aBpzK8rs8Ih6/wDXEGeRw1E5fcG5kMArIZGDsQbaNmJpjiLEhliROg6H1S2vfi4nvJ7ROh9tthAJKculaDAwBpSa5M4vm1zV573kxiaQpad4Sa816Pd+iqH8jpTWfc8y+XHgC2F60MR8DhmAJTLA5gXEOuTCgWS7i22cdaBSQuOMinNFnUWIfE+TgnKfGPDyVWE9BH62G1qSCw/neTDqcoGu8SLkbh42hq73IuHmcwf+ezfQ1S+LwMK/RMLzfwlFX+RAh7XUtQS8yV/6ym7a8RNmDSj+wsgRI/KENrh3hLVPIsbakDUZLMNwBkYPAGzaSOeuwuyzshPsi0EIr81H63CHKTweavG6oLRnq5WJtQP0gtXIqXxoTOwZZ2JiJjUjbBUJdWCdYt513wqgaxAydLPvC6a4nidvVlUjZf8chRNNyJwSzBjGZzi+LjrDlibQSyjYxGDwIIIarlPVxmofoU9ZI2+oMLVamB1PHzc7WnAT0en5cftQOqVyJUqxClw2Qy3CkfIgeowwb73EoLzsGadu/3mDXAjLCIUp/Ic0KrpRngK/B+PXcwczaP2LDmzyk7PYwYZTAAnqbVhdan7p0RaWKDa1DA4AuJfYS6ENAwp3vuo8e+xw/LCEEKKqGQd6fmavXxDbv0bcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjc4Y3NlaWgyU3VFYVpvYlVuOVQ2ak5naTVSYUR0SkxJYmxSaEs4NFdwZFlK?=
 =?utf-8?B?c2NKakpWdE4zOWxVZ250S0VJZzF6b0NvSTVVTjVGZ3lvaGVORFN1ckVlN2ND?=
 =?utf-8?B?NVFVT09FYnN5ZEtQMFhCKzFnNk9LSkRQaHNlK0Vna2FSbXpUUzVFL0lJb1V2?=
 =?utf-8?B?d0VUSGRMdXhqUWRMMGlka1NmeFZ5ZVIrbEJ0RXF5anNPcHYrQ3V3dE9lemUr?=
 =?utf-8?B?Qm1yT0UvK0lrRVhtSGQvYWRnVGxaV2h2YlY1NHpsZ1ZtaEhxRXhSbkVpZ1Rm?=
 =?utf-8?B?YWVpK3NCZFB6cW9RYy9yYUdNQTE0Mm82Ui9tOStidWlaU016YUhURDdabVBE?=
 =?utf-8?B?RDIzcHNtZXR6eGRZUFhYWGhSV285Y1NVMjdYUGhZcDFuRlJuMnlMQXkrYWZ6?=
 =?utf-8?B?cldpcVNGVEY2cngvdStrdGVJbjBFVmNoQ211SldMcUU1dVZ4NjRxNS9mK09S?=
 =?utf-8?B?MUdHaVVFcTU2ZEJPb3NzdzZrZXN4d3BjQkxVdjV2cVNzYmEyMG00UDN3bHNw?=
 =?utf-8?B?cnFERmJWblRmaDJHUHc1b1FOS3c1Ymd6eEEvNXhFSzdJRzd2ZDVjNVJuVFBM?=
 =?utf-8?B?MW5HMmJJZ2hOWUZoREowNXlyS2xQUmtXenlkZmJVTDlXOXUwYWJlUlc0cmJp?=
 =?utf-8?B?MnRtQXJ0aFV0Nzd4UGhOajU0OGlKR29LRG1Ga0NLcGhrUFNlRmRxejNsRHYw?=
 =?utf-8?B?MnB1R0lHd0Frb25NWkZqRUZRUzhWd2drSkFKU1NVaStzTk91dWJPT1VaWVpJ?=
 =?utf-8?B?WGdKWU04d1JpbDZ1WjgybmQvQmRXcmNTb1JkK2tCV0lITlgwM0FhMFQ4bzQ1?=
 =?utf-8?B?NkdmcGhZeEhWM1RGM1E4NFNLeEhjVlY4K0Y2TTR0SlA5VFNkZlU2Z3R4NHQy?=
 =?utf-8?B?Z0wwUTVCQ0JNcVMxczcxWEszQStEckxGYkcrbmJCVXZONnJibEdldjdwdnN4?=
 =?utf-8?B?UkRQQ1RoWnpZT0JLWktlYTltK3kyYmY5MHJpL0ZBVnQzUC9DUzE5Snlhd2lu?=
 =?utf-8?B?d1c4bCtvYWhpZmRLa2g0d3oyY2d3WEFQRmVkblJpSmRDdE10d1NGdnRZQjNC?=
 =?utf-8?B?NG1RdFdyYkNpWFh6QzE1dXR4SU1PWmMzbk1ZK0U2N01IU3RiU1hKcTh5Qysv?=
 =?utf-8?B?TUZKZjg0dy9lM2lmNU16RDZRWCtCcVMxME1lKzNzaGNuUnE4c1Q4eUlQcXhk?=
 =?utf-8?B?SmVGMmVDdHltTU5TSlVkNEQzQXFlcVBzZ1hyOE4zZDhPZ1dLdWpPSTVuSjZ0?=
 =?utf-8?B?WUVESW12WHU4ZnMrbi9wNTljd1NJQkx3aDNtWWFEdkJCNHhJZFlpcDcwYUxS?=
 =?utf-8?B?VFZ5OW1ybXoxY09maVkwUjB3c2krMU8xcTdFdnZZYmJlU1RWcFZYbVhjMlQ0?=
 =?utf-8?B?OUZ3dHhVTmppYWtGU2dPMU5QdlZEamgxUGptT2pRaEpXcUljc2xtM0VwR1Vn?=
 =?utf-8?B?dUdRdXFKeXJoNU5vOHpSWmVqOGhJWkMxdGhCeGdOb3FyMVRXb2U0NVBveHRi?=
 =?utf-8?B?ZjVJa255VG9HaVdEd09jTUlCcWovL3BHVll1aDRQbDFaZTdnaTdzcUFzenl1?=
 =?utf-8?B?U3p6Y0hhMjhJRGFDSGJxcm9lYXUwSTZ2VDB1aUJYQTByYWhZVzYvOHJKNDBv?=
 =?utf-8?B?Sy9GTGF4YnZOQlo2c3ZzaHRCcEtlbGI3YjkxSy9NWDUvKzFMVThEV25YV0Rq?=
 =?utf-8?B?bnUvUEV3MkYzMStRWjlTNTYrQU8rb2d1UU5KZStTT2pKMVlBMDUrcGlXaGR4?=
 =?utf-8?B?QUxUVldTbXVQbm5Nc2xUZjZMYjYrUTJrZXRkZ3JRV1I0cEROTDMxdE1YSThS?=
 =?utf-8?B?NlZGNVRwZCt5SFBobjVEaGtqKzlnMkIvSU4zR1VYZGFaOXg1eHBwU2dvSjY5?=
 =?utf-8?B?MGQzTExJcUp1clNnMlpEcTV2ZTgrY3VGUUkxZE82Z2pCQktuS1g5NTNvRVVQ?=
 =?utf-8?B?dWlBV2dzUldRTDJpREN0T3k4NTBxRWtJK2ZJMU02MXdrdlQ5NU5tRTJyZGhu?=
 =?utf-8?B?OE1BUUNmUUNrNm9aRG5mYXpDOFlORElqOURnNklDcUh0S0kyQkd2L0s2QUs5?=
 =?utf-8?B?RkpLazdIb1ZFU2kxc05KZG5PTU15S3l3MW9ITzN2ZStkbUNSaXZOa2QrWnFa?=
 =?utf-8?B?Y1dMaVVLN0VLL1YyWG5MaC9KQ29KZFdtdktlZzNzaXRrSE5wS3FoTVAzeVFl?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb6d456-aeac-40e3-cf10-08dc5ff12c9d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 21:47:42.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYgCM3yJaNezXALknHXGin78XS2I1GCk0THVatigxM2J+IG24AgzRpStNcC+jBmQVd0Bexrz69HGxZhJZZvcCbXKdyKEmkXNP0TmHJhNoQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
to adjust power limits.

These fan profiles have a different device id than the ROG series
and different order. This reorders the existing modes and adds a new
full speed mode available on these laptops.

As part of keeping the patch clean the throttle_thermal_policy_available
boolean stored in the driver struct is removed and
throttle_thermal_policy_dev is used in place (as on init it is zeroed).

Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Co-developed-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c            | 93 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3c61d75a3..ae7b43c5d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -97,6 +97,11 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
 
+#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO	0
+#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO	1
+#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO	2
+#define ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED		3
+
 #define USB_INTEL_XUSB2PR		0xD0
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
 
@@ -293,8 +298,8 @@ struct asus_wmi {
 	u32 kbd_rgb_dev;
 	bool kbd_rgb_state_available;
 
-	bool throttle_thermal_policy_available;
 	u8 throttle_thermal_policy_mode;
+	u32 throttle_thermal_policy_dev;
 
 	bool cpu_fan_curve_available;
 	bool gpu_fan_curve_available;
@@ -3152,7 +3157,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
 	int err, fan_idx;
 	u8 mode = 0;
 
-	if (asus->throttle_thermal_policy_available)
+	if (asus->throttle_thermal_policy_dev)
 		mode = asus->throttle_thermal_policy_mode;
 	/* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
 	if (mode == 2)
@@ -3359,7 +3364,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
 		 * For machines with throttle this is the only way to reset fans
 		 * to default mode of operation (does not erase curve data).
 		 */
-		if (asus->throttle_thermal_policy_available) {
+		if (asus->throttle_thermal_policy_dev) {
 			err = throttle_thermal_policy_write(asus);
 			if (err)
 				return err;
@@ -3576,8 +3581,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
 __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
 
 /*
- * Must be initialised after throttle_thermal_policy_check_present() as
- * we check the status of throttle_thermal_policy_available during init.
+ * Must be initialised after throttle_thermal_policy_dev is set as
+ * we check the status of throttle_thermal_policy_dev during init.
  */
 static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 {
@@ -3618,38 +3623,37 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
 }
 
 /* Throttle thermal policy ****************************************************/
-
-static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
+static u8 throttle_thermal_policy_max_mode(struct asus_wmi *asus)
 {
-	u32 result;
-	int err;
-
-	asus->throttle_thermal_policy_available = false;
-
-	err = asus_wmi_get_devstate(asus,
-				    ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
-				    &result);
-	if (err) {
-		if (err == -ENODEV)
-			return 0;
-		return err;
-	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
+	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO)
+		return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
+	else
+		return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
 }
 
 static int throttle_thermal_policy_write(struct asus_wmi *asus)
 {
-	int err;
-	u8 value;
+	u8 value = asus->throttle_thermal_policy_mode;
 	u32 retval;
+	bool vivo;
+	int err;
 
-	value = asus->throttle_thermal_policy_mode;
+	vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+	if (vivo) {
+		switch (value) {
+		case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
+			value = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
+			break;
+		case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
+			value = ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
+			break;
+		}
+	}
 
-	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
+	err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
 				    value, &retval);
 
 	sysfs_notify(&asus->platform_device->dev.kobj, NULL,
@@ -3679,7 +3683,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3689,9 +3693,10 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3721,6 +3726,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 new_mode;
 	int result;
@@ -3730,7 +3736,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3747,7 +3753,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - overboost, 3 - fullspeed
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
@@ -3813,7 +3822,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4228,7 +4237,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4436,7 +4445,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4745,16 +4754,15 @@ static int asus_wmi_add(struct platform_device *pdev)
 	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
 		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
 
+	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
+	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
+		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
+
 	err = fan_boost_mode_check_present(asus);
 	if (err)
 		goto fail_fan_boost_mode;
 
-	err = throttle_thermal_policy_check_present(asus);
-	if (err)
-		goto fail_throttle_thermal_policy;
-	else
-		throttle_thermal_policy_set_default(asus);
-
 	err = platform_profile_setup(asus);
 	if (err)
 		goto fail_platform_profile_setup;
@@ -4849,7 +4857,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_input:
 	asus_wmi_sysfs_exit(asus->platform_device);
 fail_sysfs:
-fail_throttle_thermal_policy:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
 	if (asus->platform_profile_support)
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index 3eb5cd677..982a63774 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -64,6 +64,7 @@
 #define ASUS_WMI_DEVID_SCREENPAD_LIGHT	0x00050032
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.44.0


