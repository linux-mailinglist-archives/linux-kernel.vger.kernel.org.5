Return-Path: <linux-kernel+bounces-35484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C18391EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B051CB23871
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F025FDD7;
	Tue, 23 Jan 2024 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W0PNdcMX"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED035F858;
	Tue, 23 Jan 2024 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022080; cv=fail; b=mtKvPZBbFZuFrWwZvWNkQ2mxAYjHq42KH7xtHEfQ+SiGhU0amCzHL3U3544q9ArV/LQD8cF7Z9AFmt4krzPUidOHhCixp6yTiXE4fE7qfUopjN2KId17RqAbd+1w7xC4lUPJrZAYhDUZLzj+j5AkDqomcZYmgObyCS/xMhr+X+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022080; c=relaxed/simple;
	bh=7hHhaRuwupvs3BHJ6rMwp9zwFOnT3lbO4aJmyo3JnQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LkgwJ+Hb52sIiZ7q2puLxrwRrkSAWfmO9wQr/8jr5JVnf9mpgV4RS8tSv2/n3UF7XwDIA6gPj3zYSwSBotyMLJdsyCYKgoozIrbkN19HdYjdaNVP6JTleDYaYVJAbfNHk/lEF+HiSWGFzRtetsVSpk7W8/Rqn2XOBD10hXibzjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W0PNdcMX; arc=fail smtp.client-ip=40.107.8.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue4dMQL55S8jDHXaUiWeO5ju1SV1GspoxK19aZoDX3Vf0AmP0CIB8gXjKXlmQbEGrYM/oMqjUczKkN4e33ve6nVxhT+Y+M3RcnOyl6VRMMLgGFgjaD3CNqI7+VCuKqghiycDG5LzYDJUFiFgbEX0KWUvJdEdl1i6zOQTVt0fckt/Aaiaz2WepcaiVpuQ9uz7ASeZNxLI81tOWyOuwamk4i7Xc1DGclX/2ADCa2eiAIAH7Ys8CN3LYk3GD0q/HXeUOoLiPFAkpcsonpnYzmf4ulTqHnrusPnnwNMk+x7SLQ7SKTmI82qtwFut4Ob9E0M+mMqBIEkLT/cTMbniWpT0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW/sdQzcVeDQSnN31LPu9sk0KQTieifK2+Nxq8QrttY=;
 b=MoVIs0I+8M32UkbDTSAXywsl7OLpUV81stjYDdfZqF1UFbg3fm/4PG7rjEj6QMHRWtiaQx4txZGo8DobGzUFif8rJd9Bs8OcbH3E7mYINCwlw4TzrSoZJIHsUnkASB22pR7fdu731ihd5YHnGfVWu/HEvA31dyAkF043urU0XEbMUBPV0KC5GFg5Xy3oYn3nkr4kdgBiN0oGOZD8uNhyZQ46hksEQcolWGbqLIxSJ8YAuydgvpVTuoSOsNHNoX3RK9roxCNwnO3UQaXQnN1tioKN2XNW5WBvDJ1sncXcBK7l748rCmpH6fd6V3RlAhIql0LdmU3C+3fOY7zn6k7Pcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qW/sdQzcVeDQSnN31LPu9sk0KQTieifK2+Nxq8QrttY=;
 b=W0PNdcMXv0lSt12MFey9FawKLWOUkoxUjVr3Sb0VF09RjQaFh1pYDJf3msetHMuG0hjSBEmb4SaXJT8gk3clVRRT0A0IpN1rPna7XM6CRaiWyl89I1REtvOIy2J3KlzvdE1/KPfst5CRDkrMfJBE2neni/6J+URGKeMGqfrAgp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9206.eurprd04.prod.outlook.com (2603:10a6:20b:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 15:01:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 15:01:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] hwmon: scmi-hwmon: implement change_mode
Date: Tue, 23 Jan 2024 23:05:26 +0800
Message-Id: <20240123150526.3615901-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c97c1a9-dd97-4610-4157-08dc1c242235
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	twLi7Ef0qEhAcIorvnhaZ9+OrepcQv9pcNQg7De5cWOZKYXJLXJeBQfLq6Yi6D+y2K07L98lOR4xlLG3JDhH99HBpnpOnA6fmEToBQfVIvCNAdTvzu98PbWGPwUeaqi7WjDFbn1JsXDNz+4/NdAwKHr268vqWfYnl4fXO9YIgd4K8ix2KwH6XCx7mmW5nKNR71A4IfjAjZ7r6Sku3mws6GJ4UfVnFghTOB4tZY8+mwqsRd6cR93fsScuT+b9DFTlrU1S6nND9ska1D48AZQFD79ea7MzeW+FZta5fYtU4tikXoOqmaE9huOW4UdUAApzB8C6gkC+O7rpeFWffRceJwS5Z558Qi+khqZij+zZXqLtG4wPfQuuyyGKRTgEN5ZwsyHLq+n8/szljj5CkNAbChsDFKhXdpdNNGGZkTPcGfWIXgglLH8g0IIMLX9rgMQDBSOTQVnwkA3TOigXgvoXqSjaU+GboWYX7o6wuAnX3ObH0HvtjbeMCXDRbwi0B0uSDSSR56ompUBqS11qtPiRiQrSr5+JdYMUhlNuFisP1yBvW7eu8jx661cnZ49LzG9XOW+U39Z6OKF2ZNC8cyKeKqihf/lFeUYvb2uhLvXbw1kvqVF6+QcFlUqMmcdE1O7e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(1076003)(83380400001)(26005)(4326008)(8936002)(8676002)(5660300002)(66946007)(66556008)(66476007)(316002)(86362001)(38100700002)(478600001)(6486002)(2906002)(6512007)(2616005)(6506007)(52116002)(38350700005)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHOQqHHCr467MIRzCrR1HMLrtUXPx/5JsHA0NqDmLpeNUYtL0PwHwHBXINu8?=
 =?us-ascii?Q?lw1K3jI1Z8jQxvy67gQw9M/u8hQSgFoXhQqzC+evw4SAHK1ofUE1BSuXy77l?=
 =?us-ascii?Q?aAqj03HlAtyvc5MUjxAzjNMzGqSdSLf/xuqKlmXqPAc1XTg8Zr/iV+U5WS2X?=
 =?us-ascii?Q?ILBJdoai5YspF4C3p94UgF3a0CTmzt4Hun/qXjCrY0edn3irZSnDoBrGl+Pk?=
 =?us-ascii?Q?HE1F5YN4r8tZNTCIshk2GJe+7paZwsw8lqQf3Aw9wLIDorsPkebi4hXcBg9k?=
 =?us-ascii?Q?07o08k1sjTQ6vh6Ch7dTdCSXSTWUh4uqlo0VNZ/la0tF1hD9H2AEFLBDUo3o?=
 =?us-ascii?Q?GdMjt3HbnDIjiGO98S5Ac1JC2TKp+IPZCZ+RGe0OX6p8uMLIqxRoTJqFendM?=
 =?us-ascii?Q?tdTo6hlA1e4ey7GE0JGMAQSmcw46DYasj/RtGQzMAwajQJlQ8cDRKeGmUA/k?=
 =?us-ascii?Q?gptx9mg2RIbHwcYT2oXv1QFw8VWXjEwEvQWu3WjobYO4U7pp0loYCgGV0gsF?=
 =?us-ascii?Q?5ymsvCLExCqUnAruKrffZQPfzMSFtispDYjC36H9y9Gy2kNXEMip6f7xf7Bn?=
 =?us-ascii?Q?aSTuQ8bozL3BE0PGtQ/i8gC1aJYWBALVezq8Q9zEbRN0ZtwQUbo2j7CCV+HA?=
 =?us-ascii?Q?CT1ABmRsXKVPtBDI9heybpwd2L2U5p1d78rkx2D3o/zM9wuk4u/w1UHdWW5N?=
 =?us-ascii?Q?hP9BAJvb6y2M1oGGOg/LqdVQwYTvzztjZroWMM3+asWfqZX2xdcxPep+ZR6L?=
 =?us-ascii?Q?b2FDMw32dNf0/MvKCC0oS5aakKr5GzVvFsyN9rEAZG0+povrd5yZfq0JIJPk?=
 =?us-ascii?Q?kEp1i4HL89WuiMjbimnPrM7VRh/JPxcWxgFQwV6wsJJ14X947QoSJ0FatXZS?=
 =?us-ascii?Q?GWtzhvPYbAoZHjyIwLaGvqmYpDsWPNVjKzvBOmIEju36som4f6gCHt+ac9wj?=
 =?us-ascii?Q?iaZPVHXdgcXJ+3aue7QBFPyj21tnoDApelFy7x+/74P28fbjnbeSv0Au6MmJ?=
 =?us-ascii?Q?eJ1Jgj9OFoCykLzFAgagYshCjVpForkfe3Hf/JBsMlMoVJgw4pZedJ8FZ0En?=
 =?us-ascii?Q?r2mjnZZjmIxcx8Yz25FcUmtRbGc3uu0Yk7nAixT6TRccIiaJcCAMWMEzTsMv?=
 =?us-ascii?Q?dAPKZoIQ86heiXZrAg26Gl8h/HX7dqFMezWuk9lnyDpTzVBTpjXpHDhXMlT3?=
 =?us-ascii?Q?3FUky5snES8hk3x+IotBevQh43f1nUijcI0eYtTZvMfRn79IabMT6x3yrMeO?=
 =?us-ascii?Q?4j5jvdaMkrCLx8agok3UPefwSi5kXzSjWdqIIRFsykvcOvW+hKJnkoZaeT6T?=
 =?us-ascii?Q?TXBBnt6RKSxj4HKTVTGEaL+bPsRamYqVGcAI+mQ8hydsKIM1reD29Ef6U6JN?=
 =?us-ascii?Q?OPWWCjUaUL5N1aVrKf3Na8sYBuYJeLTl8rNGyd7sjKWupRKG6kzl/TOHynam?=
 =?us-ascii?Q?X4hUB239Kl5Y7y6hL3EYOwMuveaVTacL7O9xSYHACZBQi3cp/S/IUtQZlSdl?=
 =?us-ascii?Q?7ST9Jz3dzV+NmCdKIiMRWsNqKZK+IkjwQiZEuLU3YTjr2Bx458TMf2X2FRPv?=
 =?us-ascii?Q?VjWFsK1JVKPsBRsnb5k7TKLS+Imvm8mEM1VdrbZX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c97c1a9-dd97-4610-4157-08dc1c242235
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 15:01:10.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmU7V+pO3neIX91TTdWnUCAu8mZfJrT3ooHXlh1DLv9qrIlaZNhwgtaOYRxjU80hZoPySRQu7ElEvf0F8qDp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9206

From: Peng Fan <peng.fan@nxp.com>

The sensor maybe disabled before kernel boot, so add change_mode
to support configuring the sensor to enabled state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use SCMI_SENS_CFG_IS_ENABLED & clear BIT[31:9] before update config(Thanks Cristian)

 drivers/hwmon/scmi-hwmon.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..913acd1b137b 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -151,7 +151,39 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
 	return ret;
 }
 
+static int scmi_hwmon_thermal_change_mode(struct thermal_zone_device *tz,
+					  enum thermal_device_mode new_mode)
+{
+	int ret;
+	u32 config;
+	enum thermal_device_mode cur_mode = THERMAL_DEVICE_DISABLED;
+	struct scmi_thermal_sensor *th_sensor = thermal_zone_device_priv(tz);
+
+	ret = sensor_ops->config_get(th_sensor->ph, th_sensor->info->id,
+				     &config);
+	if (ret)
+		return ret;
+
+	if (SCMI_SENS_CFG_IS_ENABLED(config))
+		cur_mode = THERMAL_DEVICE_ENABLED;
+
+	if (cur_mode == new_mode)
+		return 0;
+
+	config &= ~(SCMI_SENS_CFG_UPDATE_SECS_MASK |
+		    SCMI_SENS_CFG_UPDATE_EXP_MASK |
+		    SCMI_SENS_CFG_ROUND_MASK);
+	if (new_mode == THERMAL_DEVICE_ENABLED)
+		config |= SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+	else
+		config &= ~SCMI_SENS_CFG_SENSOR_ENABLED_MASK;
+
+	return sensor_ops->config_set(th_sensor->ph, th_sensor->info->id,
+				      config);
+}
+
 static const struct thermal_zone_device_ops scmi_hwmon_thermal_ops = {
+	.change_mode = scmi_hwmon_thermal_change_mode,
 	.get_temp = scmi_hwmon_thermal_get_temp,
 };
 
-- 
2.37.1


