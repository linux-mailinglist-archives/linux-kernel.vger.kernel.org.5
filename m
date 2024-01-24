Return-Path: <linux-kernel+bounces-37245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94D83AD38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F771F231EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551157C0BC;
	Wed, 24 Jan 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mCFO1zh8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641837A709;
	Wed, 24 Jan 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109946; cv=fail; b=bSMM15CZ6pqU+YRTPDg3sMTV0/ssEN1XLdzjwrb1XYA+hmqHXXNPjreFWDWlIWolePX5mW0Y1ah//5N5IkzB/qhcbvjzw94x+Ph7jpp5KafKhY8Sshu826opNVEP18rezCIjuDP8kI6H3dtlvDhY3t0M5uoLNyluVKWAzRVbzmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109946; c=relaxed/simple;
	bh=mxcHtkuXf26AVKUZaU+qLwz5dPyB2PaNogj4EjGEECU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d2Pj/6f4XDnuig+btktQdHxBFdECw/I7dSiDbnSP3da1IyA/I2q+lQBvBFPywo/LUt6sXD7Gbjfp+641ZkHEKtzCyzeECaGXBBNZWULO1onQrwimaGZlCMBGlKns85qJUHJ9oMLgxjogdqtLJdj2zNNJRJbrIsmO/uiUNXC59j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mCFO1zh8; arc=fail smtp.client-ip=40.107.22.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajmDmu9R+0szrMFrnQ4TopEDUV1SMIkVpOMEg8gguYiOu+s9yXu1wLBUu8tvzzxUYowBubR5yW5/oMU8OnlIQK4y4prYcnb8JPdRumoB/VpWEFNxjdA9QhOavaWt0YcYNgzUiO7Ay4OwdkD2kFMzJpU89l08n8wyDZwypiyc2jw+LVdXt/ffo52qi191enkEC/YMPEBpUF0zqyKEbX2ipYgflkLbBRWmGpS1qsxEJxjhibvTAPeW/DB0SvOTeV5fB5bLHp2L+NY+0r2VzP+sR+a4ck8+OPkjyY924a38HMRsIop6IAbR0Br4pC9Bd3FiQQOonUPDb1guSI1f0/4NdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oX3gDW2DtgtAqALYPPOYNP0q9o2+DhzDRbXP2yhukv0=;
 b=i50UDDeYjlBxultmVUwZI8bG1vbeTxjoW7zaYyF1sJ/7VYJVjQxNktEcVMPJqdlKIXhpatf892TpWzECxuvBOK7BQ91cf5gY4RhcqP7Nbrxog2M5poS3+NWEgJOwgVEGvav2TTxXRT1/H7GS19hmhN9R3orW7trxstvu/0IBRUBl33YWMsxy+5TFjr23PPsFZOlkbigH9cJQm0/vDfpoBBccX74ogoYuZlgfOuf63ataxX89BnFKLXaTuvTpweCMNDgLwk/G/2rRmGmCt+nkqKTsQq8aCfC1sTts3gvu2nxjqTrkigw86Dzv0S3KajNo36Y9p+y/nuGUVdsFWc4gFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oX3gDW2DtgtAqALYPPOYNP0q9o2+DhzDRbXP2yhukv0=;
 b=mCFO1zh8CHMLa55yDphfHDBGAix3WRU69EJJAb5oBrMeM5WGdbLHLaVcxYaxJLJq/tMJe4v1E8HP1ZWC//kHsSg/GCltMwQpRZRh9TRH/87LGH+MntW6rZphT1wI4i4euIv9whfXT7jgC9yPoC/Sh0Wms7hX7x8rDogViEE1XOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:25:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 15:25:41 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com
Cc: Frank.Li@nxp.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	mathias.nyman@intel.com,
	pku.leo@gmail.com,
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH v4 0/3] USB: dwc:  Add workaround for host mode VBUS glitch when boot
Date: Wed, 24 Jan 2024 10:25:22 -0500
Message-Id: <20240124152525.3910311-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c184d-0698-42c9-195a-08dc1cf0b96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Moc7YhRTM1Kdz2RDNwk9jMOLQlnBrk5bgC+K7/225WnYgoQLE1ebujx+FqA6tibfHmwgynzQhpDqWAvoiaDf3XHlKvSlcuxIWG5pePp9/SsuBotWmrHnXdopV9cltbBssCqRfDAUOE+PDKr+nKtJOoBCPUXq/+RLem2WVnoHhziVlX/qigKlxHDQ0n4U6DIA8vO1QLlNXEYqAfr/3x/xqqbbzvabYc48UvDUnEHzg371563reQ5bKpnYJzhGIBCbBo6ofvou9R8Qw6+Mn978UP3IVE/6g3GRui8OTEnLfbhcGydizuKyMDsH3hevRQeMCYKAnguzztpkVuEZc8aExcTUP6b3/dKaRQMcaEiyfYVIv/etJqbJ8pc4DicHsMGQxJGcaoEhXyunFtm7VqDEI6nhkpzG29qg/Ak8n0fodQlz0MPNMkm1c7G9U8mRltvcd7FH+0Q6dv8EhD9YpettnSCVcln7PHpunB3hpQJGs/ADwkDwVbAnGAxRAwuSkrh1KeMXX1OkTG7Zsa3FMPtfl42SMFUZyUXIdLOn7KLRL6UVKBJo1Vd0Ri6PrhVvpzUfC45L7coPRFG3yPJZKmVUcLMP92KdQJAQDVhTFqmDK5wd3pXdfoALWLwDCPy6tHaZEsWPanLEe/zxyozNciOlO6h+7zhrXjuRnofAYFECJys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(5660300002)(8936002)(66556008)(66946007)(316002)(66476007)(6916009)(2906002)(38350700005)(36756003)(86362001)(41300700001)(7416002)(38100700002)(52116002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/CGpcufWqzV+CcTaiKgCF7BP8u+p+oYyypQU9ODJZ+4v1XtjzrXC2lZUCrZg?=
 =?us-ascii?Q?jpsFiPtq4lkIM9WIOgSLLPL+LlwJFY+uc+ROcxqt7zs4rZyO+dTsdHiClgtX?=
 =?us-ascii?Q?7fyeb15L+s+3DW8gzboYFfhzVkuqwJyGBaO05E5LspKFKopjaTmhaqjkVhaz?=
 =?us-ascii?Q?ja2vtMMflC999vnyyV6qVFvS8XlIegUncVnucTurIsUyO90CCXuwVuNMVdQC?=
 =?us-ascii?Q?DI96PC+pRirnsO0DSJuqUe4BA4WLyp6Nu58/YlYyW8UmNDtFtjayMtDREEV2?=
 =?us-ascii?Q?Kxrw7r2K2LY0c9+qmsd+3+q4OHD0GQlcStQRAo2CVf7RgIkDfHst7NQFxlH8?=
 =?us-ascii?Q?LbWgnxnTBDF05ZMRK5LFA03mJ2BfE+PSn00dZXJAvwqmw0AjMv0/+wULlpZt?=
 =?us-ascii?Q?x2x5x74DFVG47OUxLufpzRONcGIivw/GoAXPV14HiRcAssvTd/POGidHPRjY?=
 =?us-ascii?Q?orhmM+cgOnmI71rT7lV4rweUE739j4dBQevBxLnSw340fmcEtYpGJSWRZqM0?=
 =?us-ascii?Q?Ka0Qy7BZn0YDv3uBzOJb2IewuNWL+UPYRDRv5wrRVfDXbaGDwalKHxUmR/Ez?=
 =?us-ascii?Q?jTTHyFKF13XLKvwYZP6lEeRZo5Rj24lTXFsfObtY6PvWaI6atm6ZxifwlACJ?=
 =?us-ascii?Q?J18RUQNbt3YvvzX9nzgM6aNPOmKZxF4qGdjNSIPB7rUTJgKUeE1XI8MHPF3X?=
 =?us-ascii?Q?XhneqLDgTv5wnUsu1h31KBfnBXm304d4ALkDS1QwuPbloQwOAixlSdCwZtQ4?=
 =?us-ascii?Q?/IYZoR4rGx9RY2HcnqWReR1BT+mMuL42bzjnTnx5xVlDxDKdV8plhUfO3krf?=
 =?us-ascii?Q?9UWOnyHA6nHpaMlnyujgaIYik3bbtWQTrbJ/NxB+pn4h5P2hK6kL6KxNrzBP?=
 =?us-ascii?Q?jVEwxXh5xl0G/Wjd62NB3V77MZcsAaxVF0vKJH1Xsf+uwPqIRZvxy42e+fkL?=
 =?us-ascii?Q?j273BthXRpeRiny0nd6Zt/jUL+HUFJ3UW43MBntffzqSaqmPN+WXTpHsUHm6?=
 =?us-ascii?Q?nb+c9/+jR6kpo6mbvg//2JUzwKR3NUaJHbHe8INvogurgnzJ1lU1u+XlcS53?=
 =?us-ascii?Q?Mfg1ozX3OzvjtcUh+kX3Fulk0HMr7W1jWCvk+qjgeuGD6/+rZtslRR58wiLN?=
 =?us-ascii?Q?L05fbNpjXu8RM+54CEtc4zG+Isx3ahh33VZWE0snIYzC8nrUhCuV2YDlgvHu?=
 =?us-ascii?Q?TfaXc+aTYd52WaOF0LFIkGV8ofKq8yu7YHR0R3inE3DSF0VB7T6NTkHEYVFB?=
 =?us-ascii?Q?cTUJJOtbaFxPKEdHcN1OcYXCYtEmF+8d2iqDZW9vtNJ/agUMSAL2guB9oIx1?=
 =?us-ascii?Q?8fh9rQnWLZTfB/mT4XSYjsJE5er7ZXdlErOMV3sYXaZ7pHAjhTk4TWfgNtHU?=
 =?us-ascii?Q?vMuqvlPGBaFyNkzxhFkoY832VgbI8F+3lpbzw+pNeXZTFzv+IyUqqw6/POZD?=
 =?us-ascii?Q?T8XGDCLi1L8ve0Y6R3GiHbpuXWK/AjViLKpEreJQ14sT01w/QzR5rNCDajt4?=
 =?us-ascii?Q?D0TkvMwXJkRSDPdQF6wU5lwHos7dlsd1ZEc7xSjJ+l6/M79j9yHMRFkwVosg?=
 =?us-ascii?Q?WoeoT1XPRi1mJTT+kAA/MPEC0daPAtRO9UWidMe1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c184d-0698-42c9-195a-08dc1cf0b96e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:25:41.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SVu2TQorZNupDOPQJp2fVY3Nl2e44u5wxbR9MBS9X2Qtwhqhysw4PnKE4AMPc6UL/UkZM+cA77CRfwgMjLT43g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001

Chagne from v2 to v3
- see notes at patch

Change from v1 to v2:
- splite xhci.h to xchi-port.h and xhci-caps.h to shared marco.
- add quirk subfix
- fixed checkpatch error with --strict.

left one warning to align existed code style.

CHECK: Alignment should match open parenthesis
+	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
+				"snps,host-vbus-glitches-quirk");

Frank Li (1):
  XHCI: Separate PORT and CAPs macros into dedicated file

Ran Wang (2):
  dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus
    glitch
  usb: dwc3: Add workaround for host mode VBUS glitch when boot

 .../devicetree/bindings/usb/snps,dwc3.yaml    |   7 +
 drivers/usb/dwc3/core.c                       |   3 +
 drivers/usb/dwc3/core.h                       |   2 +
 drivers/usb/dwc3/host.c                       |  51 ++++
 drivers/usb/host/xhci-caps.h                  |  85 ++++++
 drivers/usb/host/xhci-port.h                  | 176 ++++++++++++
 drivers/usb/host/xhci.h                       | 262 +-----------------
 7 files changed, 327 insertions(+), 259 deletions(-)
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h

-- 
2.34.1


