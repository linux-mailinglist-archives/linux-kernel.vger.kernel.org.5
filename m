Return-Path: <linux-kernel+bounces-150618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEE28AA1D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF21B23132
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6861779A4;
	Thu, 18 Apr 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="cyxnEpMM"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2100.outbound.protection.outlook.com [40.107.104.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA460178CE8;
	Thu, 18 Apr 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463885; cv=fail; b=cskuVrEwBcyC+SswCvLQnJCiTxb18uDGLrMxRusNJ9FJ93NGqfsluVUrnaiBInjD7mZNot5m4OYyrU9Tg0vSDtyaXcgORQ2JF3Njn/IkQF+snm3TTY7omqpwA9dDI9jinrAmVdQ9H0G6lWNRKscdVUabV2taXLAAJfcp66JrkPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463885; c=relaxed/simple;
	bh=3Pca5NhACjPgETnbs+czGSqrj5okY/4y/NuJTvlrCBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFvD8SB7A3fE5u+zlWwwzw5xf9goRqmh02bKHMnkutJ35PexxQYBUwou3ybNcVidHzTWZgAVVV3wTOL18BlTmloAPTXZG/d8+guLRIgvuZkc/+wIfFEiKdqosVPIqBHIfxOIm/PToCX83u0A9CsFCJI7jd7lqIiZGsKIEqQIYls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=cyxnEpMM; arc=fail smtp.client-ip=40.107.104.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXKVVXPsXiOiY2cghU7mivfZ41Vm/QkiOKr2mbSDU8iIMijyxT2eeDkeIYhq4EJ9nIMphVEIxtf9rSC8NJx9eJzf6uia3Hobr13RVaHx3g7DoISAXywfxQuowSZjROzjQvqD3pJM44N7EhGo41tJ4K/6fZXGUZ/ISj+IFxIIc473stE0Q4A4gWKGmFa+pgSxEjeYQNE6NTLi+GJiJ+n015T10ku6FGhDi5Yt8bvUJ75dXXJdt1rgu4JGGor21vwEhPLzNTQe0DeQwq5RV5SZ2VxP/52HApl+JzvlzFjnacrZf/CqfZXniX6GVapo8y+KdxWIasnvwZRYKRiE6hBdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnmTR3XSjhIiLF8DMUyvdmUuZCoVRv/u3UAYA4B4r/w=;
 b=XZqEsKs1no05DtkDDxd4TA7E+ACyioXiLE8Vr9Wm0ZlIeobTbbTKzRmfG2Tbt/h2WagQDIQreXZUlki6xsg5mhtmwknilneLd/KKN9jtwGw32oq06S19DpD76DN86BdfUITC5ga1Cbc9TBPMChOrQxAukQeMNNev24IehjjkHAhDv6/19/2nC9bCHq6v5ad9j3HvR8fww3146te7xlZVdPkHsN0ZXgl/u16Q/KMPpknNcwWBJdtKaNQ9BzawParAgXwq4Ndn9DE2bz+a5SlrH7DN3K1qJUC5FMJp728sJ+l5WxM2RfBgb4NootXV2q7tlQ02cdjS8BXaCkLlgNmeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnmTR3XSjhIiLF8DMUyvdmUuZCoVRv/u3UAYA4B4r/w=;
 b=cyxnEpMMRd3xlbnpLKL1kVkEHA7liyArnoQ5OGsfQC9K7a4ceNuLMqoe7ok6CUo4IIj+L8uuAnyeoE6OvrAAsEidQjNstpJORz8OkTi628Kb99w3pKmspwEPouG0CsfWUxg5muwqcxLbEB3nn/L/7KThW2m1VsQUZ4KLxYaklC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (2603:10a6:208:b::23)
 by VI1PR04MB6848.eurprd04.prod.outlook.com (2603:10a6:803:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 18:11:09 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::eb9a:367f:6384:7d62%4]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 18:11:09 +0000
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: hdegoede@redhat.com
Cc: corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: [PATCH v1 1/1] platform/x86: asus-wmi: add support for vivobook fan profiles
Date: Thu, 18 Apr 2024 19:10:57 +0100
Message-ID: <20240418181057.2688-2-mohamed.ghanmi@supcom.tn>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418181057.2688-1-mohamed.ghanmi@supcom.tn>
References: <20240418181057.2688-1-mohamed.ghanmi@supcom.tn>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3905:EE_|VI1PR04MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: 229e184a-d1ed-4591-0e88-08dc5fd2ec5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YhbHNyx/fdHMGpBCqrb2GFwyCWVXAWpd5hs9n92/eqUraYY+J3hlp6RNeoFiQ4lTjSSaeWXfSdlhEdXO9gPZiS4nTevIE2toLwH1IFqBW545yUAUbbJhdV9jTiND6eTlvvoTvUWvtlyZScUhUsREjfU50Dv5g/9AV3EhMiofTSx+gsK3C4DfNgwpx2V8h1+NTQTDn0SZXeY0979+QQmoYmu5w4QKR0gF+rhSId/XUHqu3gr2+J5xBHUWrbaNTC25W/vFEOAAfxqHcBMQEy88JvYJwdEtTtIvf1SZvwLoHqgITH23K4J+s2/QNpawcY1nYM/0gjrV4bNxc1Jplft25YE5ok3j66kV4sCV8+nV3x5mH6Zz2nsqBMpOQC6QAQASqFaJWW8L6bTFou5HzFAxKlltXBgFu5Uji3/XF6dnBD10ftVmw0E0CgOe/DalvrENsazVTkCSdAJBSqY5uo6j+wL5oeCM5wLs86zKAAUm4+BuNlGlWj6PCmhUdLZEHkxXHzStcPYoWE1X5XD2BhSjCByEqIzkfSjDTTf5RlJ00ePec4QGLsyzUP3+GHuoo9rADkwRZUterk2Q9nVqPC81lRl2dSKunPI9EeETNcWkWQRwsVuP7/4L8Yrc0Gc9HvMKRKcW4D92u4x+hYWo/Eu1tZmfre82bWsZrU6bXSqq3WoRTEtuuVJVGtWNLw7ngVHKt6NDFmpQ7RSIJ0JD9pWeJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(41320700004)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0jrTs6b693EB3k+OUIkJO2Cm7fvxMvNdZOxIw2r0Dt493sxhjP5MZrV7lv2c?=
 =?us-ascii?Q?FRiiw8qQYWBhpkB/61SxdIM6M/05+d5KhnbFI3mDL5bzX3CuLbbUkjx+zv6m?=
 =?us-ascii?Q?cDc66M3/aDec8b4flJuJ0XlZmBsorEyPbBN5nLkczhd8E9Zd8F2srsbNGvst?=
 =?us-ascii?Q?DlPMuYxlv8ALhPI3+4a7QFDqcDddU33C8aJIo2qfzljKVgHCPqvghslvT76l?=
 =?us-ascii?Q?n/fafDhDC/UMEA7rwk7V9677fywrTsm2A951lV7b4cDW3+qHTCv2hP8o1W4X?=
 =?us-ascii?Q?Po1kefu+r61wXhBdDqnPSR3w4qOiX+ccLTBSSnyQQ1EucBvRoFPm0AgQLPUX?=
 =?us-ascii?Q?yd4Sn70AqiEkIwk8D+iVApqNaF+GaxCenADj2gsN77z8rEa+xiUll8Gj+6xX?=
 =?us-ascii?Q?1jtYNzCD6tY5COgqWAfdH9IUrao+KRD454RaBy7ZW70o694Umtt99YGBo/Tl?=
 =?us-ascii?Q?ejV+JXnMbBPXz3De61q0QYqc3XvgRQYV0HqS03T5AkVU66ZWUaXhXBlXs5Hh?=
 =?us-ascii?Q?RzYGagrvBX1BesPwuQ875UhCO3k0k+ntYVAyNEqqLGXOdE0bkH2fIJL4B0mQ?=
 =?us-ascii?Q?2rp4NlblBOz7QXiy3mDt2l1abP06c8Y2Pu4R0CvRAcleDEG9HcMbLz/G9/2p?=
 =?us-ascii?Q?U38cbyWKR3FUlPrhGxX26a6oQ75AOqI6NhXWsNPsbeFgeiyt1NKK/UUbHBVY?=
 =?us-ascii?Q?cDgd5MhYtMplgS50zcU6u2dNS9/6ArS8zsEBxmdYUa1aiaBFzRT8K7oTqj/F?=
 =?us-ascii?Q?793wakgPaSO2rXjvCWbLYn6bHik5h2UwjVEIr9EScKeqWvnnaS9DfQ5I3fE2?=
 =?us-ascii?Q?m9wK/ezwd6oah+c+1ReiI3nacQsDN5Kq1ynYprc+QjICFaSCZW7Z8rzqL0MN?=
 =?us-ascii?Q?Q0/b+zx7+/GTpve2pva08H8RLX0+q+Pb8K+zktBdkroe7/uada+xaLZFGQKp?=
 =?us-ascii?Q?0VhpDe+CUjn7/XnZ9053R65nB1WVXsH0ixfWB1wfH7PmB0qhc79dVOGF74vy?=
 =?us-ascii?Q?Fe4i2wJiuaD8b6FdILltYfjA2pc47yFHVYNOu3ZILtVM1aCXcuI4uruhphCY?=
 =?us-ascii?Q?IrSN0s6UyV0eGMN84F7SvtyJqaPZedGMGLDhtKg5qGkIgplzjqiOjqzr5dT9?=
 =?us-ascii?Q?L5v+/+q370T0rUMJaFFdD5GbpwCQG+sim0+srlbDctdjFjpl7F/RdVmaMtkA?=
 =?us-ascii?Q?+qJQSMpQ9EF6SpHiBo2pJ2Y4XIZTIxU8OAMc0eKgNAnpxWDT9mOZcqvv5eof?=
 =?us-ascii?Q?k1DoUT7Hmcehj8khkkrq46z18DzhFz6m3BvjwHvKQl6egigOXK3W2rzN7nn8?=
 =?us-ascii?Q?pPlp11usJOZBIK/q0oaaIZH7MwLRkm2oRiuJlZd/bJk9jTI+U/ROK/9xKesG?=
 =?us-ascii?Q?4zsoHiB8HUf2IO8kA0KzkiLC6ZzHrmKCwSnf+2HqPj68u4H7eQuI3MlKQeR0?=
 =?us-ascii?Q?UBfSkA6AZcEDYUI/di7aSKn38JssySmV9fuNJIJCEIxlrVDcIyeRhUiblrdO?=
 =?us-ascii?Q?lalYnkCe/IpxSrGybHyrZgxQya7THUXTVYyZyxm0xXS+xj4sTgyQEJkni3Ft?=
 =?us-ascii?Q?J8mcnnUxVwCaF5M+t3HvDvF+1ylF2FNf9+TTq9Gr0jMd+PuR4lC57rd7pLbe?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: 229e184a-d1ed-4591-0e88-08dc5fd2ec5f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3905.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 18:11:09.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: em/ihMVTNycAywgy58MrOCoI+ThOU/PiDy0fWEQqryO/6VqdaV+r1vW+va5+KUzmgtJbXvdU0tN2/HGbBD/CoEcIFv0eLI5ZMMzUlVysqB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6848

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
---
 drivers/platform/x86/asus-wmi.c            | 92 ++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3c61d75a3..d8efceda1 100644
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
@@ -3618,38 +3623,38 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
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
+	if (asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO) {
+		return ASUS_THROTTLE_THERMAL_POLICY_FULLSPEED;
+	} else {
+		return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
 	}
-
-	if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
-		asus->throttle_thermal_policy_available = true;
-
-	return 0;
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
@@ -3679,7 +3684,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
 
 static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 {
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
@@ -3689,9 +3694,10 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
 static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
 {
 	u8 new_mode = asus->throttle_thermal_policy_mode + 1;
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	int err;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3721,6 +3727,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
+	u8 max_mode = throttle_thermal_policy_max_mode(asus);
 	struct asus_wmi *asus = dev_get_drvdata(dev);
 	u8 new_mode;
 	int result;
@@ -3730,7 +3737,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	if (result < 0)
 		return result;
 
-	if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
+	if (new_mode > max_mode)
 		return -EINVAL;
 
 	asus->throttle_thermal_policy_mode = new_mode;
@@ -3747,7 +3754,10 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
 	return count;
 }
 
-// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+/*
+ * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
+ * Throttle thermal policy vivobook : 0 - default, 1 - silent, 2 - overboost, 3 - fullspeed
+ */
 static DEVICE_ATTR_RW(throttle_thermal_policy);
 
 /* Platform profile ***********************************************************/
@@ -3813,7 +3823,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	 * Not an error if a component platform_profile relies on is unavailable
 	 * so early return, skipping the setup of platform_profile.
 	 */
-	if (!asus->throttle_thermal_policy_available)
+	if (!asus->throttle_thermal_policy_dev)
 		return 0;
 
 	dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
@@ -4228,7 +4238,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
 		if (asus->fan_boost_mode_available)
 			fan_boost_mode_switch_next(asus);
-		if (asus->throttle_thermal_policy_available)
+		if (asus->throttle_thermal_policy_dev)
 			throttle_thermal_policy_switch_next(asus);
 		return;
 
@@ -4436,7 +4446,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 	else if (attr == &dev_attr_fan_boost_mode.attr)
 		ok = asus->fan_boost_mode_available;
 	else if (attr == &dev_attr_throttle_thermal_policy.attr)
-		ok = asus->throttle_thermal_policy_available;
+		ok = asus->throttle_thermal_policy_dev != 0;
 	else if (attr == &dev_attr_ppt_pl2_sppt.attr)
 		devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
 	else if (attr == &dev_attr_ppt_pl1_spl.attr)
@@ -4745,16 +4755,15 @@ static int asus_wmi_add(struct platform_device *pdev)
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
@@ -4849,7 +4858,6 @@ static int asus_wmi_add(struct platform_device *pdev)
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


