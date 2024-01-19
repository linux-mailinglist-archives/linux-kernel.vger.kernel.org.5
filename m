Return-Path: <linux-kernel+bounces-31167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B850832A03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA0E1F23CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5B53E21;
	Fri, 19 Jan 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ALxbKBhC"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C45380D;
	Fri, 19 Jan 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669364; cv=fail; b=O7lxR9x1QOmJT7J/WOISFkxOOZ/PeH8DoTjG6Wu8LwHxwTNkc/6zFJVtqTZjqdvp+8sdncMfg9Z9vdkLkhnoRWt1eAZqShHbqFrb/RRQDbTCVn8lB9VHWNBAd13oHFmFzBkDwbCLeXF5xT49R2ysNs+3Do3wU7GHoIYtxcQMQ1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669364; c=relaxed/simple;
	bh=owM400jdyr+b8w2fxNSe1bzd5sT3MroswCtCIcUxZB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OpCaSNSyo7RA4OOOWTMY2yp+y8lYyVq26PKrpYjD65aHsCbOcCK5BExmR9t8j9m7oMA7Grwxfg+HjfZGFEEmKIQ+FWQXWFL3S2krMd9pn88omvXS5zVOYw2kPwau038y9Gifwq/s64+OF9FudDKSMzChM19/dh26aEyp3GEsMZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ALxbKBhC; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lipKdFn3dHxRE9ShwhTN2e2KWEzE9jvnWKCGKNdDuW9L0h4PTN5TjtAvwkAq8cXtZrObFuNsdln9HQBC0dT5hTxCAUYzuR2p7fTRvb7/3s9/bfqbDN+mtPdIuF4VLX7LD1x58/feGWWpFb83Gyj/7Um+AygRLhywUQcsddIzijRDMt6nNbCNb9Ma/o00pxP8jO68+QWKjfElc65/XM+7MrQ1vLWcXhEH9pzpdlRi18npRVfZK19XMwdyFsmgQuJ3nso7J+gdl7b7usBV/ZYUnCEXkOccqy8jtV5aZyatF5Zym99HVdoetLdmwhFUPjHkn+HFup5EpwOB4zk+lEFCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JspRvcx7IjRvQ6wwG30FVad2Nry6nndFcu+3riyTVqk=;
 b=VrAXQxpWgUXwMKchb+lgxpmv3kPcy31mQrAKd0TAa1gYtgerwLpgDYQXlWp+5QFbfRan/VHow8A3ucxdJIk8D19li8f5SSALWGzIlMN0ltSCSSQVPRmGhgTt2W9PIlsgT5AScQqRp+OOvh3OnuJPCa94bPDUPA8k6rcI8IVGwxRy1v+et+cxSDDPxMQwv2K1m3HdVJhJ4GtDYttdPhWNa/8fTmf4At1soZcBS7KuF3m0SHI0bfldlTPFApQ8+paxl9n8cVEZ5kskY8ESOWTbuokmZ2p3J1YK5fnki0p/OJH+By6RC7sCc0UNcjYmZCGTyDxKac1RO10++w8enx2RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JspRvcx7IjRvQ6wwG30FVad2Nry6nndFcu+3riyTVqk=;
 b=ALxbKBhC602xexiOT5s8DbkVxs2EaMqD6sZBgh35Kd7jTzSlOR1XZW3ozKqj1cXxMuNz68YGea9qSZf1assSzCNKuASb/oL8pnoUiCG1NNlZIuLiDI1jLJcg3BaTMFy8UbskWDgIyCIxwEG/E6/KvSJLd1Q7rpdoT669Oh59N9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 13:02:37 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 13:02:37 +0000
From: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	ghennadi.procopciuc@oss.nxp.com
Cc: NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Date: Fri, 19 Jan 2024 15:02:28 +0200
Message-ID: <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 146b7399-2749-4901-2abe-08dc18eee905
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3SZRtueAIjX9gLRtpDi4yhl/4UgWrQAfdOmwHG21flFpt+ul5L5dmLmYaV9n9TRX7nAOBuy/Tn3LVRhovUb5O/nCWfO0e8IthA7K7BD8wADOzBhM2NWUdm7NFVjPQWLdjwGMKCNY7rM/MMAJ6AM35RV3jq0sPDscu3iG00rLR6uilFoci8VowhpZs5sPlvjsDajvkWdxj2yWjmfPDUKm9i/VWJC2ifAPF7MkL5PWW3IzoLUyNMaofG0UVCnBfJwxlDVHpRQ2Zu1p1zzaJJnwP6V/CDBNA1zeGiFoOW/OoUur9xwlTalgq+SUo8UO8BfElUyRvGBTlD+IR8Kc6QRURAGM2z2O/NgrmME4pCSFt1RNYClMQeSpTKgbXIoFr3UBtkaqUZ5jYVibxY6PuaBQSru6JtBXg1NdXPZtiO9FV3c6xCr31dfukZpTLWZcac9hTo2sIIUxLbWFj7BYF3HIMLZS7GRnCYXL+CgHjmdku6HWFJByZhNGDarg6vK05k8UJVBM0B+FOOK6R5YBtUWGArLQeZiDaejOi8XOq0NfcIk4R9G0sEKg2bq9brDD/cVFv+LK0pGp7tThmQd8uEKk536qmAOs/k0WALy9eEarWG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6666004)(6512007)(1076003)(26005)(2616005)(38100700002)(86362001)(8676002)(6486002)(2906002)(83380400001)(41300700001)(4326008)(110136005)(5660300002)(921011)(8936002)(478600001)(7416002)(66946007)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKBqTVpLkNzDq0oLtUuepLUcQrmfDvhNgJWqyOKQ0hWB40dIVeeOV8MFHFzz?=
 =?us-ascii?Q?ehNXELhliN63TEIs0zxVLGMwDkNjhQ8rlsht4AouX7md7fsurZOhVONBOlhq?=
 =?us-ascii?Q?OfyfelXdXsOGWMPOumGNkHJUybFuoxhegptALUOFuSFKstf3CpM+LknD253Q?=
 =?us-ascii?Q?F0E8S6ZOSnCNIGHNWk41lMP5mSSH/txYE4Rs5p0BVDiHxyoighNfvtFfDPlu?=
 =?us-ascii?Q?E+hYRxwZFKDm+B1n8IpiCMB2ZVkjNnJqDc/Jm3QEP9lH/TQUZk4AoDdrh1wC?=
 =?us-ascii?Q?NeACj+zssHo3oAsDBK5wr3ApVeeosSjE8xddbmp99FgVF6gSopmso2DSVgXN?=
 =?us-ascii?Q?zeGdJ8qnWCqCzWCAKodyEgjHmgCx9Gk2KOyAb06pq2CxULSXwUINk+MXrSee?=
 =?us-ascii?Q?OEGXLOXewmDksGWdc4HJjYkqQQ14IvxR0o2e27fv/zKIWt8sTdk7//AaiqIG?=
 =?us-ascii?Q?uW8e++acOAaeJmmUf8H8VWKVZThXslDfqxzAneJC2JnF3KowZyVwQTnctNIw?=
 =?us-ascii?Q?qNP/DgrUXJUivWHj6Wjfl4xHOeejpaPufOXVkQsNp6TlvN1hM4LpDZFohNq7?=
 =?us-ascii?Q?MNO5/k7tvO6wTkKZlGGUOZ+GsYVziDQj1AKMQw/OSciwY7Wox8dR8cS83fT5?=
 =?us-ascii?Q?WztBJQAh2OGB5o9GpJbMiNMSDDgCakulQEbcAUY6ygIHR0eFxM7+qUbBdJeb?=
 =?us-ascii?Q?7IBAA7eJ6icZOm0eTa95iFkeei31DeYM6Ci+PKq2954NHxrtDw9IxKyLB9H+?=
 =?us-ascii?Q?CMthC9mu4l5IgufPjM+HnlhS/W8CcGTMGrNgEHjZkGMIeds2+7qBBqF6uTKx?=
 =?us-ascii?Q?6Fk2f00w4nzDUk2fwgY7x1s8SchTdjbk5jcmdTas7XA5zEWAxKd9OiVTRXJN?=
 =?us-ascii?Q?ldaN2rKYNnDvNoZFhGnw68gRNOHP0A1MugYOeUIQHuwQnJr8A1t1EE8dnsHd?=
 =?us-ascii?Q?mpVsMHHbbg9883m0Kj3LUsFf6YLmu96XwZNVZ21ktV0HP+h+XjUXfzQkOxzw?=
 =?us-ascii?Q?0UXBlbnE5wHGIs9SZkXakkNg3EAnFZ+OJklXVKSnOHn7ajmjD2hPotDbbDmu?=
 =?us-ascii?Q?94fV2LfL6FdMYzBrjIsjnGIJCk27LLJc/OiZkDKIlWjXbTXuayRJoKoX4DJY?=
 =?us-ascii?Q?J9JNkscxhvyNewtVDZChNOZX+3GuG7YPP+nKWqyzeYel9aTHG24+EinFAvO+?=
 =?us-ascii?Q?vo/1dx29EIkE03Q8acZYR8WZkzJHHnc9A2UQx5zMxdwLvL0VhS4cJ98DZq19?=
 =?us-ascii?Q?QtIKmBm0jewrayAcr+4deSzlWtOg0MvJD9cRn/gJNd5A+yXz4FvvSBlLBwqN?=
 =?us-ascii?Q?EgtTiw5GZkd/zXmUY6g3fIlOhNqhEZocolt6jadcb8w+3xJdZ/+v/ExBmP+p?=
 =?us-ascii?Q?HyV5CwRRCk5OwRLn19MRVgm3xaPeP8hHJbPBdwhXvq58J/1AKtKX8CRGypyQ?=
 =?us-ascii?Q?kZ3TDGdVmEAyNcxVgFXhVAZCrCoLtQntULhz9u0hGrl67Sm/aZz5lQrYL2ua?=
 =?us-ascii?Q?DAqReLGJBI8EJv3DanEfR5JQfONjc6PstEGuIaUyZwtYt8SKH8HKBT4rM1bQ?=
 =?us-ascii?Q?tcd102B3vsgACD0rJh/ElbNLc1lqtQa2yjs7V5UasvGrEvDkSoD5bfVhXQPt?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b7399-2749-4901-2abe-08dc18eee905
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 13:02:37.7081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dlpe4MytH9cBD7mTxOOWoX0X6DGtGCsmVb/wTCeTk+JUQFecUIKsxk/DcqfKyD//FFk9F1aqTRHq2p27y/R5QFFtvItl7tAhJnURPNl/kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Add the SCMI clock IDs for the uSDHC controller present on
S32G SoCs.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
---
 include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h

diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-bindings/clock/s32g-scmi-clock.h
new file mode 100644
index 000000000000..739f98a924c3
--- /dev/null
+++ b/include/dt-bindings/clock/s32g-scmi-clock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright 2020-2024 NXP
+ */
+#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
+#define _DT_BINDINGS_SCMI_CLK_S32G_H
+
+/* uSDHC */
+#define S32G_SCMI_CLK_USDHC_AHB		31
+#define S32G_SCMI_CLK_USDHC_MODULE	32
+#define S32G_SCMI_CLK_USDHC_CORE	33
+#define S32G_SCMI_CLK_USDHC_MOD32K	34
+
+#endif
-- 
2.43.0


