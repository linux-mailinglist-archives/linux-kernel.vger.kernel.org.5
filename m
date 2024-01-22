Return-Path: <linux-kernel+bounces-32483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203FE835C35
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42FCC1C2401F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34360182DC;
	Mon, 22 Jan 2024 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wux7hChM"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57117C68;
	Mon, 22 Jan 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910431; cv=fail; b=XscHBRFAcRBpEmCw+4wp7l7Qhe0v70AI9B3TLTEmW1rNa8WAJfyPy+SNQyIilRpA4Upb9gm20Q8d7RO5lTpscGR3EI6/RMr4HjNYq9NS31CoGXKzgAeueaShmjH8bY9BXJ97XZbdimrXfsVbTmd5csNLWRHygou+DLnRTtWe/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910431; c=relaxed/simple;
	bh=26Ah53ogv1RuFrHV72FthULZUHBDgAlP66A+g2KntIg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CS4PSz9PnZRVAD/v/udm5n+o1UR4sdvcY54mKG/mPumQZ/6867v9/AN4Hco7TLiw3x/BCguaMCvjTEplAQI+AgQ+ogD0eJJ3yhnoaf89Qd3Uv0lhr6M2gD/Zf1mNP8tGTZsN6R3bdKYkuavMYonA7o/IbkRPJWEQqagTOwDiRvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wux7hChM; arc=fail smtp.client-ip=40.107.15.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkXzRXX3QYPoRXg/Bm3D13EIoL1klRN55u177xwAK5OKJTW1iS7bBc5OTBJJ79BVloD2gOvF6LqYXUF4ljZeovFfLydkZCVpl4cQa+ua1TjXE37N5mQZKgQZ9iQKZey9lHdeybfMAWQqk87OaxennJ4uu1UeYQvQxGZ+JELU9KzDz+YSXKbk6BUeynsIU6tYxNRHEOynioqlZyF4bkHjvgLTHnb18RS1s3KplOJFEJ2UQI8+eU8XZyPfqSvcFSgt1a1CqyjnKmQ9Z7zKwY3kVgQncmHxHGLbshPcwofwXkdcU3viMusxlAoI01NW9xEqASIQ8uIS0c6RW4F2OJwNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9kmDS80mo593DsrjqavbETC0IgjsyOsNnaCt6c156E=;
 b=fOUH37Xv4TNWH8b21OJNJrnZeEyvfjv36jw9pU3JIXdE0NCSa5RpVtk0AReC413YpLHLX0j5yWWMMRFTfeNuwFVBzyOhHdI0/0SlQOl6MJAPLT6YAC+a6XTPSR3p4Y853LbaugS2mHvQgoUweXxQdqRGtXHwHbAd9F4kUKyAz2GV39SW22W4elAP3PyEt2GyWjMFmfyDPNR5PBZ2c3RFjShkCB7y3ikD23zCpw3LtLXqRT7S8rgTOaovm8iqGQoxNmZcta55vFcOkpiPEV979qYYHOuGsDkyHvam1xg1HGgy4pWeAt79AFh93pThLPjRYOrNpwG78VfqQ+dMVl+Wow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9kmDS80mo593DsrjqavbETC0IgjsyOsNnaCt6c156E=;
 b=Wux7hChMsVZxEpwjd3UGZqtx5xu+XQBoTbZsWu5UHdQSWO9xl4Ew+48OZ6UQy69FhXQ+Dy3DKnS8TV3GybmwtITM/PCMZVwtP2uupMejB9h7Cnd12T6O+rAvZuiSE7sqUorJKQSt4YF1YppV8aBEAkXMrtyxld2bPezjqo5/30U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7313.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:00:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:00:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] hwmon: scmi-hwmon: implement change_mode
Date: Mon, 22 Jan 2024 16:04:41 +0800
Message-Id: <20240122080441.1957022-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d393467-ac53-4c44-faa8-08dc1b202fff
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7rW6dfvRHvtiQ8r0K0ozpzF5ae+AHNzaCmwy9qEAa6j+qgOyGkiwvqpjYak2PG2YOUp2FlZqGpnFJZTlA1gbBdx3cO0paJamfw58gU6uUcNzZgykVmTI4Qsr1UtrAp5CYaLC5jbVpYQJ07+QFNET6HSzSvaYq0oP66bXrus3pqu/6vZ5A3oTnfdVBv+KkxAGrls/wfLNsTYxl1m3FcutSJzQ49XycyRcQUyB5zhyMCbf5l5KzdeZ1RfQ6TfoFAKe33K8EeZa8hDA/YBiyQC+aC4MDjai0biPBWnPqvUaR5xClU/koyIlflVY5Je0pX1DQJcaMjaDFwiETWy9LKCDLGA1pw7T7msClM5iy15exkFJ2mI88+e5vggsXwJenyeLFroaY2S9uRWbAnrjNj7giEbPEWACh//dgho+0X7Ktng4nzhlfafX0Xy1vC9whLKWaIfH1dl6ty3FmCekrLtzOAaXe6I2iRo8w7dOa34nWBX6Jpu3+832e1wWTVgTeXA3GONx2JNTKUs+JpmDOrPjoCzrAUSzSAmK++wwoMczGMvqSD06usIJyZdkXwTyKVVmlc5qHE2x30o73Nl/g5E7PRYwVmi3pP0RGiDdqbDTiSxNgbgYcg5h4hzKbP0ee7xZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(1076003)(26005)(38350700005)(6506007)(478600001)(52116002)(2616005)(6666004)(83380400001)(38100700002)(6512007)(6486002)(66476007)(316002)(66946007)(66556008)(86362001)(5660300002)(8676002)(8936002)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qrBRvoxnAYlD6pz9ntoy2SvfP7b44IplU+VskmRKUL0ztJxebDLfPrLQc4H?=
 =?us-ascii?Q?w84ej1juNmVlOHVpJN5ANwG8EkDtinbaaCpQJL0BwiHzTs1mBX8kaHrtLVlA?=
 =?us-ascii?Q?hHwpcClACgVWaEnL+3N6pVSyUCqF48B9RhAAw9GH8M8eDJ3gVMPOKTvXXFfz?=
 =?us-ascii?Q?7NDFJCVKoRUeBRnkcT7ma+GJQ2kw1Noc14UuIta+XLAbvlCzGzViW88pwqZ6?=
 =?us-ascii?Q?R7be6xEZPSzSpEkjByf+O8sp1UYVg7DnUWI5xZb+Jv2El8dZWNJSA8RZvI1y?=
 =?us-ascii?Q?jwAsVTQdih0UV/8PEAHoYJKRrdh/3ocyuaRtfsE3RocbZjEFkUpn6RNM8TpL?=
 =?us-ascii?Q?FU7pTTERSLllGfYR5qfLFKTCa8S4YYbMEXnurMMlGfQSNbQkObVQO3pBqQWJ?=
 =?us-ascii?Q?A+ns552Nb1JYZERQGiPhFaROyPquu0nGIXvrUIVW1keyo70lYVgKUlqV8/ES?=
 =?us-ascii?Q?jBxmXd7HdKUn5uGc8JKIbLIDC+w6kjEQ1woh/cCOHXOXeII+Y02WczJPx/WS?=
 =?us-ascii?Q?Y9G4/N7wlQX9+KtgOrZVX1QKPMLVPioxQ2q51zVxqnTk8P//0O+JRX7qMWaN?=
 =?us-ascii?Q?pa1aREcEh8fCfKBrlZwofRfR46VVMzbE2ZpTjSDfL5lfIq7tvIoTWeKtueFl?=
 =?us-ascii?Q?cTqqqqQtEsCBqzToyN8vr1AsHAqE0rVxxuwTmabUdGGFYtld+xldIaJvGmAW?=
 =?us-ascii?Q?PyQpMJEQVTliJVDH/DC5aPDIpp+R3u8enBTlWGX6lqfBhFGZ3CGepTBs2YTM?=
 =?us-ascii?Q?tfYb9AklNKRt8jHPyUtcqMIecgemXVkFcrmkueOt9ixZw8m7bJ2vdc6bixqI?=
 =?us-ascii?Q?MoCqyzLo4O3rSfFAQLjRlEurKSvdLPy+huyePDkCoy8CwX9Tvw/PBEVqUWWS?=
 =?us-ascii?Q?AVFoR49BBzdNg3cOFaQfBwvfmPZRvSmWTBhO0UQqMSYeBgzNqPKyIgiXuP6x?=
 =?us-ascii?Q?2Ig30HrznnLjdDZKhNA+rXJFZwwNNb1PEdD9e7ukHXedEisgBBhabt0Xritq?=
 =?us-ascii?Q?js2vvTWj0WW7/pbjqAPkavUJvITECZG48MEDhVyGZIDH6kx6mGWKe0mCAygt?=
 =?us-ascii?Q?dochnGCh89kQoutzjbkO8Bb/oQZo8r3F1BYkq+y/xW6WJ1Wtuiu/oKmuVARG?=
 =?us-ascii?Q?PxKBd5iAvJm343APPPSCSMsgflsULUBexn7DeCNL7eLIemBRWCYGNSxXEkPo?=
 =?us-ascii?Q?aSUqFL3a9KuIBR/2yXF2B0kDLc0mRNBn81MHksAhE10FaO+fuLCHrMoCpysF?=
 =?us-ascii?Q?gNSBIzrY9xI/9RR0zoxuROL4T2EAx8EdNjKJmg8yWE+UYuYlhhsUYieBF9mB?=
 =?us-ascii?Q?nHsPMyEMym8w2D16nxWsKYWYD99D9iwybmgORzXsgNdsDMnoystJGcvcrlwv?=
 =?us-ascii?Q?Oadiyg/xdgq4G2NjIw9gKmJtCTWJODOieLblr4vjs6kRpOfyzTN4d3c5bYx/?=
 =?us-ascii?Q?3ADhwbRYaZBaneWYR4gA6oXIXy1yniW2TgIY15SbFwiXSBIH7QKL68MKpFm0?=
 =?us-ascii?Q?KvMZDeVJ7Rl9QGMuYgXX0eDNOyO8lp2GFN1HQhzSiiLEejum/DUvUm4gLKZG?=
 =?us-ascii?Q?BlImLYNMUf065ghp304wjjpESdnr6EWxQP/h01za?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d393467-ac53-4c44-faa8-08dc1b202fff
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:00:24.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MC85hmU5e1YXe+nGSDucCKahsOGauiF7rTwRsu4JXy4SyyK+w+6NXma0CNwgWSGOW3j5EJhN+69WVgn1YGRUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7313

From: Peng Fan <peng.fan@nxp.com>

The sensor maybe disabled before kernel boot, so add change_mode
to support configuring the sensor to enabled state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/hwmon/scmi-hwmon.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 364199b332c0..f7bd63d52d15 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -151,7 +151,36 @@ static int scmi_hwmon_thermal_get_temp(struct thermal_zone_device *tz,
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
+	if (config & BIT(0))
+		cur_mode = THERMAL_DEVICE_ENABLED;
+
+	if (cur_mode == new_mode)
+		return 0;
+
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


