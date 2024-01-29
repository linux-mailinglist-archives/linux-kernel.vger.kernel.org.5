Return-Path: <linux-kernel+bounces-42514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B6C84026C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC99D2811BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287755E52;
	Mon, 29 Jan 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1tAI/TY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2073.outbound.protection.outlook.com [40.107.104.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F3557864;
	Mon, 29 Jan 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522901; cv=fail; b=hwQDbkSjPZ/3HYR3vCQJ9PLShdYEfr7G+JQ/wb2sKoBaX9Df6VSEvD3Wb84pA/nEcTwQVc2ogFWnF+VyxLFNP4W2WQrfPx5TIxfLyX2ArPjyK18vcre7d0Xc9llL6qbr1iSY9gc0fNThTN1zoiYv0MTvrCd2WvGs3H/uqJI1WKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522901; c=relaxed/simple;
	bh=vvG1jlQ6kg3VFdlM7c4/SggZ1QoqEwdoY39IWjqF/XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+ReT/3DvPfqnd1CnqL4pVDad1uuXPOFC7MnrT0OQRNGFE2CKONbG/g0HVbYdfE1vMN9b6OVz953S88ndEK0a4gVp3EVob/ZSwJ8f7tg36N3RO6oLuSYEltRPor9hr3FWXivsiejUmEWKiQ/LBdXNm4oOxiePsO8uN0dJ5ojBW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y1tAI/TY; arc=fail smtp.client-ip=40.107.104.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4mICb/tn9llVb4mysWWgt/E5dQC+LhXZFHZMKtouvL+NDszRSpfTbZEs4D+2a0/eQb3xT3G7TeFK0LsL0/Sd4CzEh8ybEoTh9zPL+oYQLy0sHmWHufaosU2vCRnd0u0VYyQWIDvAIDsrvPdkYPlgw5y81+UhQFuj2kJve7gtKlRc8Hq7Z2LOvzkaBMBdogI5VJp7NuQN2HWmUx3WBLhR8fpuoZUu+TX1wnO17dVjZM4u2ZFr2zb8rJw1SAzwUnzy5k+ZU+hEilab9NgEkK1LOVYuVyLBC3EUqFBWA6TpttShCI3sir3SmllArRTxYjsfj8JmJSxdWfv9tu9zbqE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcV4L2AuPS5ya8we7aYyzaEEs3OfhXE1fuEppBT6FJQ=;
 b=eetzxv3qt9msjdJUqAPoAhdyf0R80AdbHsyJU0jvm5RkfXAEf+9TPaGDgFMhUsb4QVsb/Q9G8aO68+VR2lswoAeQpXwleyVHNBpqz23cJZJFa/kK/Id4Aytgxp1LgH0+3S6RshVIesIFpEGWkrywiLiKht+jWCzH5ei/cRVFw9vIZDDD4YrxhFZbRkgQ581t32IcnB5YurM0B7rFfgMMWRkY/9lXlyBoiNTMsb+0MNpRWXng8k6ROoGd7JIIo+2EZXOwcMf2KaCFvAo1TpA4b0yiqxI/2yL8zt78TFb2YJ3Oio9E2SesQP3cn2wx3jvRzjnAXiMUVAMRzECqX0ilow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcV4L2AuPS5ya8we7aYyzaEEs3OfhXE1fuEppBT6FJQ=;
 b=Y1tAI/TYXBiK2DB1vRqswcmddNqysgc0HMbC9lS9vf7x8udlMJ8XwlXrxtf46f0QzQz2yzPPO99kpaQ9b5vsqVKVvuRRXsVQpbuExrkpxWIoDq4n7B3AUmPCmiL25uh46tlod2jWFNDk5/qHZ3Rs3JJtLoRGKRSfYFQfC8CFMSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:08:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:08:14 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: linux-imx@nxp.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	xu.yang_2@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 2/4] perf: imx_perf: add support for i.MX95 platform
Date: Mon, 29 Jan 2024 18:14:31 +0800
Message-Id: <20240129101433.2429536-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129101433.2429536-1-xu.yang_2@nxp.com>
References: <20240129101433.2429536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c4795b-7b5d-4d0b-cb21-08dc20b234ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xg9szAyF33m03OqmR1hpH5ItZkxZG3w9o99t+jZ5vQEgIswShpvQg596leSLZOx3CIY0qiNuOqX/PVVTdA7IGA36dGO72+adKnXxIa6VOs7cBxhnnXoRFSBlGP4NYDzIKv1rJjAa+n3urSluwHWaFIhwtnFK4xhcdsUBLs2JOZpPv56bvjHuGv4B1nnp/XRi4575K5A2YQis1PEx1Gdf1jAmFTLDA3vBfC03PRgauEDbxroMyjGz3iEmnfyUlYERPPWdDp3gTB2yqJWsYRTTQ7/AnoROvSnMGDqkdlEAy8vMwa+P2EwStw9Xzi4MiLGJg6tKZM+i2s7GZvvf9gahnWDNO+qJop7UnwoQODgeUz5e/nYF5SKHnJWdarsYiMqlk+lTsBP47+IAnEz04ipSJYSqXLScTpUm6vueTXIOOzCye+jABHgnudflSVZAngmw8hLq7K9WyhsVK/iNzrkvTagxtKDImResyXN8UeZpnvVkCbfUcEDb6Et04h5BmgCCqV0aqsoq3sb8FURLvB+fM5MjKrePj6Ah92/DidGPqjLZ4MywSbe1R31L/Xk0Qovctvx3dbEVLyKoQh/v9w5nmYT3ONsGrTqJG8dVry1pGFR9lssKLNEalRGpPkifuHt7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(8936002)(8676002)(4326008)(30864003)(2906002)(7416002)(5660300002)(86362001)(66946007)(66476007)(316002)(38350700005)(36756003)(38100700002)(52116002)(6506007)(6512007)(478600001)(83380400001)(6486002)(6666004)(2616005)(1076003)(26005)(41300700001)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlOxjGCRQR25b4Ji777m4iGI30tY/ydvUiep8cy19oe/iZ9nhzMuOjDQIavu?=
 =?us-ascii?Q?UOplOc6+y6mUq6tRQJOsBw9MFYGpvj7AoNh/dQkqz8RvmXIGoBTlTbxtieEf?=
 =?us-ascii?Q?Ndu2j0DcOXNRCZa+1cTj8eUfzFjBGYAxetJdORorBtenUxR/yEIlqyai4IMc?=
 =?us-ascii?Q?e1U7TCsyv4FxyEKGRyNzK+WK00ows+PNSVPvwzr1/PwIQr+uJFczZizc0mkF?=
 =?us-ascii?Q?A5BJJ1cixvlHi4JHovVw07lpYMEGNdImDsDIqyqUancOblxIDw6Ery1eiiLx?=
 =?us-ascii?Q?SsTluPzP2U3uFQxN39vQaSwWkbWlQ3hfjikw7M+Xo/N/dLCg5KJOzeUc55Lj?=
 =?us-ascii?Q?ngwHAx9hCcqYkn8YmAx/uLlbcNVTyIlbdH9or+IkDwnvIZ1CuC5wy0g+OLpz?=
 =?us-ascii?Q?qMKCbHwUHUAVUQoDLtSnDvOibQ4oYdLkVASJhb+xBa69aLquMxb2KOPcH8Qb?=
 =?us-ascii?Q?1RgcYZUk5EQCX51DQeE+QxaQRAmN88b7Kidwocvqq2PAxyA1FIgNtJRciGA6?=
 =?us-ascii?Q?5cRfQuH6gglqMiYrixqaPTH/8PaXOkdNV3IzzrRWmIxMjmGfAUwvnyxpbqhi?=
 =?us-ascii?Q?O7cgMj1JDvan8T+b6j1Gg3d06kl6F3fG8TTORCzKTwQoyY2qG1XPFRIlB8fJ?=
 =?us-ascii?Q?ETpR+P+OxMO1ri6VwiuX51BBh6HfUQFqR8nXURXYLa4IkeQVm2lmuDvKmdpZ?=
 =?us-ascii?Q?lawA1UzMgjbaIDWn5k4YgTnLMmBcv64wZINSr0LAOhD/p9GiYJbeBaW3g6Nk?=
 =?us-ascii?Q?fJFMkAmE6rVKO2x44llK2xSckN7yTdS4Go78YxIHoWsYmz29uQ1eA7K86GEL?=
 =?us-ascii?Q?oCo0DwPQGMt4eLhLUOahgrMA3gFA1LxQCAcIi4T3TJ69DXT9Bt0hCQB2VXS9?=
 =?us-ascii?Q?NMuxGyDmx0uCTw03VjgvXTDCdSxnbVJorGojfSeL4KUNCledkc3LKM9ClN1u?=
 =?us-ascii?Q?8y6sBbdkMIjqBHnO0MiqygxQUk1YarLM2RqDoypn2CQ1EwIZf5DSAdl/YP+g?=
 =?us-ascii?Q?R35sr98p9sbK36WLX83qTa9nVCCfcGBkCxUloObd45zurlgV3nldytd1zjPb?=
 =?us-ascii?Q?KJIytm9RHcDPqxWdQsIqD+O0KM6o4fL8I3fYDqBwRhygO3Kv33WQCEUa8ay4?=
 =?us-ascii?Q?G5g/40VNdLWCA8ldmcu1PemsyNIgkjJvaD131YW9fx3i5q430QF0BUJCTrC3?=
 =?us-ascii?Q?KW+Kvc7X2O71L4v5NRG+9L3jnLTPEYtjSZgoySlWcZMBWo2btC1xd43yFtDT?=
 =?us-ascii?Q?nlgbiRCYh27YBaDqvPs0tpyEbKsLfmpZbzP3fbMNJ80SybgzUjmSq1hiJbqH?=
 =?us-ascii?Q?Wm9r4LzCHenYmQZTLVaV1yJAc8md7RvHwpo5/hEPN/VjOCvm+E+/5RZUb0ux?=
 =?us-ascii?Q?Mj4GLUUL4uWis5Puz/wkGaAoRTc4yE1yO57sZ0HJvMwPNkS4Y1UM+ok+iTiO?=
 =?us-ascii?Q?LHrUrjFHSYXKLlrzIZKZWdhIIL+IniKIt7fEuMLF/HwJc/wk6J+htokFx/B2?=
 =?us-ascii?Q?dI/3cmvHKlFteOASLM39SeftgZCkyVz/mCKkut/EnMKNdjsqe1sgp7HrcnyR?=
 =?us-ascii?Q?ZCS2kutKNw5OtepwSUH34y1yxKeUFHd7Nc6smdUr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4795b-7b5d-4d0b-cb21-08dc20b234ec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:08:14.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYhnIy2E/nBGzqCk00nnbfgmd8qtQQOCQh0WX20ImZhTtuZSpBNvHY/4LG0cABk3KOoeV5xLromJBALuiSd7EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to franks suggestions.
 - adjust pmcfg axi_id and axi_mask config
Changes in v3:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 203 +++++++++++++++++++++++++------
 1 file changed, 169 insertions(+), 34 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 9685645bfe04..fd118773508d 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,24 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
+
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -51,6 +61,7 @@ static DEFINE_IDA(ddr_ida);
 
 struct imx_ddr_devtype_data {
 	const char *identifier;		/* system PMU identifier for userspace */
+	struct attribute **attrs;	/* AXI filter attributes */
 };
 
 struct ddr_pmu {
@@ -67,16 +78,6 @@ struct ddr_pmu {
 	int id;
 };
 
-static const struct imx_ddr_devtype_data imx93_devtype_data = {
-	.identifier = "imx93",
-};
-
-static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
-
 static ssize_t ddr_perf_identifier_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -178,7 +179,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -190,7 +190,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -202,7 +201,6 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -242,6 +240,28 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
+static struct attribute *imx93_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	NULL,
+};
+
+static struct attribute *imx95_ddr_perf_events_attrs[] = {
+	/* counter2 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),
+	/* counter3 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),
+	/* counter4 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),
+	/* counter5 specific events */
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),
+	NULL,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-7");
 PMU_FORMAT_ATTR(counter, "config:8-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
@@ -268,6 +288,28 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static const struct imx_ddr_devtype_data imx93_devtype_data = {
+	.identifier = "imx93",
+	.attrs = imx93_ddr_perf_events_attrs,
+};
+
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+	.attrs = imx95_ddr_perf_events_attrs,
+};
+
+static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
+
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static void ddr_perf_clear_counter(struct ddr_pmu *pmu, int counter)
 {
 	if (counter == CYCLES_COUNTER) {
@@ -361,7 +403,7 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
 {
 	u32 pmcfg1, pmcfg2;
 	int event, counter;
@@ -372,30 +414,80 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
 	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
 	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
 
 	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
 	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
 
 	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
 	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+		pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, cfg2);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, cfg1);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+	int event, counter;
+
+	event = cfg & 0x000000FF;
+	counter = (cfg & 0x0000FF00) >> 8;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (counter == 2 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+		offset = PMCFG3;
+	} else if (counter == 2 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+	}
+
+	if (counter == 3 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG4;
+	} else if (counter == 3 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 4 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG5;
+	} else if (counter == 4 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	if (counter == 5 && event == 73) {
+		pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+		offset = PMCFG6;
+	} else if (counter == 5 && event != 73) {
+		pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+	}
+
+	writel(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+				FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
+				FIELD_PREP(MX95_PMCFG_ID, cfg1));
+		writel(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -476,12 +568,16 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	else
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
 
-	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
-
 	return 0;
 }
 
@@ -596,6 +692,39 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+static int ddr_perf_add_events(struct ddr_pmu *pmu)
+{
+	int i, ret;
+	struct attribute **attrs = pmu->devtype_data->attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (!attrs)
+		return 0;
+
+	for (i = 0; attrs[i]; i++) {
+		ret = sysfs_add_file_to_group(&pmu_dev->kobj, attrs[i], "events");
+		if (ret) {
+			dev_warn(pmu->dev, "i.MX9 DDR Perf add events failed (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ddr_perf_remove_events(struct ddr_pmu *pmu)
+{
+	int i;
+	struct attribute **attrs = pmu->devtype_data->attrs;
+	struct device *pmu_dev = pmu->pmu.dev;
+
+	if (!attrs)
+		return;
+
+	for (i = 0; attrs[i]; i++)
+		sysfs_remove_file_from_group(&pmu_dev->kobj, attrs[i], "events");
+}
+
 static int ddr_perf_probe(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu;
@@ -666,6 +795,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	if (ret)
 		goto ddr_perf_err;
 
+	ret = ddr_perf_add_events(pmu);
+	if (ret)
+		dev_warn(&pdev->dev, "i.MX9 DDR Perf filter events are missing\n");
+
 	return 0;
 
 ddr_perf_err:
@@ -683,6 +816,8 @@ static int ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
+	ddr_perf_remove_events(pmu);
+
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
 
-- 
2.34.1


