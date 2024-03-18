Return-Path: <linux-kernel+bounces-106371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB587ED44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E62E1C21994
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995AA52F6E;
	Mon, 18 Mar 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="K6TTDt2R"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B443535C0;
	Mon, 18 Mar 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778652; cv=fail; b=I0xbyzo+OJwdIxZfAIl8A/eMrbYKJ3vhLJDEd5aGStKFk3TNGxRBSbxgo3ps74vbQCIVR+xw89o9x8W40ELdJZw84SXtWr7bvNBDM+obN0CxS8NnGRgnMEYEystcPEhIR93ZJc2u5nB8GvEOTjXaPM6TM7p1rNJwPxBY1ZQ3K+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778652; c=relaxed/simple;
	bh=MXZOkpBcZ7wVVMyjsgUFVKnjkIIKHMml7EBSE49b/MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrL2YWVdhllWSvhFp8w/dgmLjyqq2qMyU8G3fHaj4LTFoTmLsHNhsPOrspEro+tkJqHHVDqnbcEml5E9RROrva1UVqDnEIwweuZZWgmB7CTLfHVSDudjEvAny8q2+rkyMJ3g7AAxnu9xs/wa3SFcZpVp5P9/wvSyDlyXsoEKW0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=K6TTDt2R; arc=fail smtp.client-ip=40.107.212.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjliZ2wjDzUcxsWSjhWAT3GD1Yw+e11+5+tAWBVJIGtZ6eFv2XMWNWfRfRBkVXmDlnlmHHouN5hxjuJ6zMnwmNkDoLksC65QcOL2omeghmEqJz0ISw2iAn0hG6gEgtAO0tpywuY+NykAfdz/pBopYIHJ62Gr+NYcNK8yLmc3+eE4aMywU8ul4rM++22Nfpzou0rHpkEJqN6f++ennLXVMp1468r/l1ePYG/gB8vorFM3ol0npsEFd1pD/9px0+u1ssRfqT7pIN20f1ZnxmVdF/5iDO36d+A5IuwcKx/NTRZaQKhI+nFl/4t4qZagckNghJF8cUg+zqjRs/q2wlznGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBL2LU10Nu68/Zcjr+eUKKLvc9DaE68xyjHdvsdOzLA=;
 b=Q9iyMHw+1pl41tgxjgossk2zyznOBQZkyIm7s+Ga3XwRI/bu/BfwJtwNeMCfuVVQO4VJUA8G6dxuVcfC+mlHTIizHk2qFKyxjPB1KBlxqwVCh21cCNPYsYSHqfxv/1RW65FDl9R7l3fVi8E5/NunJdYndl9cAYFAgCXNUUdaGs0C+Zia4u7d4S+h+PMA8wyF8376dQTcThThkJ4EDh5sx3MhL65el+Ws799W2PpC3gpj7LbQge2u0AXBvbqgbG7cElIctTNYN4R/rxAjndzmZ5bZcauFct54uxtRajkvPCN8GC8p7j+Z3vZ6cLj1tHjNY4HGN9gxe3ILZH5VEy4a2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBL2LU10Nu68/Zcjr+eUKKLvc9DaE68xyjHdvsdOzLA=;
 b=K6TTDt2RBrttiMCsQrGaxZa+DUeCSfbYCPWVBo0Oqk0NZS1xWlVgjsOrzjm61jwHhtRbqnxq1uWjC7F+2DJBly57lhpYLXzOXy7HZA/CHCh0g54K2HE3TLyJ6b0hKV/RVDG82C3dwaZpVn4pEiDG4CowtJF+7EdODtA1rM43T94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MW4PR22MB3715.namprd22.prod.outlook.com (2603:10b6:303:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:17:27 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:17:26 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com
Cc: w.egorov@phytec.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] drm/panel: simple: Add POWERTIP PH128800T006-ZHC01 panel entry
Date: Mon, 18 Mar 2024 09:17:08 -0700
Message-Id: <20240318161708.1415484-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240318161708.1415484-1-nmorrisson@phytec.com>
References: <20240318161708.1415484-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:610:e6::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MW4PR22MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e378082-4652-419c-a27e-08dc4766e706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e7TRDS7JfqXOFxzIeiP4jE4Ie4ts9ScM8h/AKnC4dJUC6tn+OwQzJ9H7kjoMFNeI9PAbVecvrd5lDcYNyE/pdmKqRdKRF2nKgZHLylsIxjMqwoqYAPqpqD3e18M1PxUfkoFnStZYWjIjXa1PsjzcgQtK9aOeSG8lOgsTDbNcA8tOS1iVYHO8MQSMLJF5mDlAiOeB3ebBNkftX9iztZkAt02du2o2eZpgF+cFXpsCrAF9Lb30CN2FWCjw0MzfyHkxs0MnzVIqSkd3is3exVtCt0PZGTe9WRN7fJiIOJT/6SFirdH/1BXpbvIW0pdNOmlkulRqJzoKlwETn9oNMOn5zTY8qFoRW0kobrMX2qr3P5FK7e+ep50VgKxla7FPcG4Dmm9nrlCgjgz6SVRclI9Sx+EpgTTIV21iAZ6L2vT9kipruCMbhjqCzsEdm+mbJ6b+1TyNkCiu9iDEBqSDpMIYTdmJvnjDBtXIuBO70WS+cpJDoY6bRAk1WfNQgUPIthjJSbK0EmrwcBQX39m6SjF0kO+g/2FmcWjnjT/v/u/mtwUf7EKKAoT1q6wLgZn45e2F3eQNqgC2q0xXgu5qSSvxOcxmY9SVtDV3q19PP9oPitkqRMeR9DGcQoIzH8YpQmyx2iW7ylEBSQmKer6G5FAjH10C+cqWcprSNN7fmasqpe30vbfn6pm2ybvc5alecIAVSQ8yUXMWItW2xZDvgirmLadt0zrR8i7EOPlJUNzG6FU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pirDlMFXaVZ/AYaWROgyo92g+QC6qxe23B4qTdq6yNwWsKnd7GJjWF/Afznh?=
 =?us-ascii?Q?WCqhImkOOHZ91zGi1YM/Y3NdhBxPwBiVnGZEE1OiBLHK5g5sfCQMz7a1ormY?=
 =?us-ascii?Q?2SsI6yt0Qok1jFTVmDtOEW9/jO54a4nzQaJm1OnBXicjhHdNBBsZ6ukkmuOu?=
 =?us-ascii?Q?hueoT6YgFuBhSy84wYRjNtY8VIdWHm5cFRPWmsFqog7zqADaqfIy8+xWeWDV?=
 =?us-ascii?Q?iFCSZ+87Qx34bHmR8qchqrD2jVOCxMWgVCE23ZWKNw4WhGvCg3uJXsqjqnnv?=
 =?us-ascii?Q?rsaJUep/P43xCkrDs/9VLyNRGAibP5flPtfw7LwOLjCGzsfH8y0h8FcKVQZc?=
 =?us-ascii?Q?S2ZLfMHxfcVEcVLxJWyWltQI4SVryJ6zf5MOWRmQfF37B6fC9/qUjKreCeaX?=
 =?us-ascii?Q?sTtCCkEsP15R2HEr4GxJzGFOrDB4/baTahjWfBmoKzcy12l5ZyujksgFTU6m?=
 =?us-ascii?Q?XcanP+eImFL4H+KVTiEarnClOeb9fO0w1WQ1+YO7YvVcemiBtBREBsK2BnBv?=
 =?us-ascii?Q?KhKPBjkQfL8uOl5Bx6VSUVB0EiSTOE3pX6wcoaQlI5a80BLxmAVt56nda+sO?=
 =?us-ascii?Q?O3SRm5mpTms70AWPKetotJ3EfRR05qA4WnKHXsEvwir1nwvWHJllluEP2sYD?=
 =?us-ascii?Q?5SzHhczKBTyVUPI1RRb8R/zyta/INEOzCgVKLmnh+iDVu/f4bsxaRulzpC4G?=
 =?us-ascii?Q?BbW8mZGxNhTcKeeXGPsRfGEoU1zYEjdZl2UPPbB/xFvylMOmhm/g1KFFkAkB?=
 =?us-ascii?Q?GXt0/MQUJ0pYX4QSi9kREUFI/5i2jUzPeoHVWCirnTR0u7X/J4pbCrNvpOBJ?=
 =?us-ascii?Q?OkmdNZsDBu+6gMD4Ce6DFg4T/KUBsHb9cN9Ye9G3KvNEbT3pT1JW1qx/Bwyn?=
 =?us-ascii?Q?7HvR65lKi7FXRd1kysXIwN4Q7kxJIU3Y6dJaAyTDg3+ycULb2/xDLMewc6x2?=
 =?us-ascii?Q?sKRhZR4Opz9ZsOclXrS1mMBZW4F3gCo8eMxlKLK19jlonQExDO+SL9y91LvH?=
 =?us-ascii?Q?0+EHVBhsobEEstgRYbLk6bT29+0G2XqflsYK/gNjrp0QcIJnMEB+V9yDJCqT?=
 =?us-ascii?Q?6iCehXeQtUdAO1dbTST1fVRDQs5smUrQpvyolsYoCXZjlRIK+hz4y0w+tONt?=
 =?us-ascii?Q?lyrxU1wUd9GTTmsy/x4G0Zbvgv5KVySOzRKs16KiojsRW2iRqeKHxnao1e1M?=
 =?us-ascii?Q?0UghKV+DFqvfAQ7WfQc+BkihDlaxgHRp55p5p6/xtjpPwXl8F5dV8o4xogBb?=
 =?us-ascii?Q?s4pLt2aziXxYP5JaBR/QYfNfX/0NzbmrtFvD2MQGaBmuZ58TAJ+gIFpR7hUe?=
 =?us-ascii?Q?kKf2sLSIcPc181dQnO7yQZCw4FBP9cg1THsFBvDefd2DJF3mPEoiWgL1edrY?=
 =?us-ascii?Q?vHm7qzf9nn8xZM4ElZ+rG5NWG5sUAa39QWun0G1q5MDqpkMA/ze5LnRZjF2u?=
 =?us-ascii?Q?3lro2K1erYUosyz/SkHv17dLFY/o5Z64JbqCVraXEw4tffecIvVcm1VBBa9j?=
 =?us-ascii?Q?zghyg68n+XG4yekf1uICfvvUORNXqjOMEK9wz8WqQYdQH/TX+DBS7/QKUml0?=
 =?us-ascii?Q?Iqp8+Gh0De5sVhGUnUKHglt27U49tSUzvdPaL7n8?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e378082-4652-419c-a27e-08dc4766e706
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:17:26.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jn1iYHMJ9hRWxhw4kW5ffo3ohJvS5HY2+3e/rcTxF72Tluuzl4qi5pc2bNo/GryHuCD8MYjrzTn1pMA/cqvcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB3715

Add support for the POWERTIP PH128800T006-ZHC01 10.1" (1280x800)
LCD-TFT panel.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 20e3df1c59d4..02d238123753 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3465,6 +3465,32 @@ static const struct panel_desc pda_91_00156_a0  = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode powertip_ph128800t006_zhc01_mode = {
+	.clock = 66500,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 12,
+	.hsync_end = 1280 + 12 + 20,
+	.htotal = 1280 + 12 + 20 + 56,
+	.vdisplay = 800,
+	.vsync_start = 800 + 1,
+	.vsync_end = 800 + 1 + 3,
+	.vtotal = 800 + 1 + 3 + 20,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc powertip_ph128800t006_zhc01 = {
+	.modes = &powertip_ph128800t006_zhc01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 216,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
 	.clock = 24750,
 	.hdisplay = 800,
@@ -4639,6 +4665,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "pda,91-00156-a0",
 		.data = &pda_91_00156_a0,
+	}, {
+		.compatible = "powertip,ph128800t006-zhc01",
+		.data = &powertip_ph128800t006_zhc01,
 	}, {
 		.compatible = "powertip,ph800480t013-idf02",
 		.data = &powertip_ph800480t013_idf02,
-- 
2.25.1


