Return-Path: <linux-kernel+bounces-142511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8D28A2C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECA41C23B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E9E5491B;
	Fri, 12 Apr 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mbw/2gVH"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C583CF79;
	Fri, 12 Apr 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918368; cv=fail; b=ch/sNIWz9zcaqddluJwLu9n58D5JIX6dcZy0Qq9OK3/gpsvlqT0enH0QOHFBKvjJdMnVYs0AfWx+4QnS5SwYAtYj2cqszLjOpNA45GzAt5YPYDM/wfLAkmb6lMJiXHO8pcMKHsY0huWTf1/rRcLRjKyud+0KJKJqp9QxsgYdtys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918368; c=relaxed/simple;
	bh=Pv6FbF/1tuFsRyFZD5XM1/4ygDzddXPKHOtYRpuQV1E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WWee28CbmldL8RJxe5q/xEQOCELVOVTzjxmkc989zbJ6fOUd3gupkYBTu5vmoAlvJcsVmwKFE/YZbKDpcwc20znALTH/YdSmtIAauzJYJ+cBQu/O7ehrlZu7N29ldMY0LEf6aae1aT6f49/Wj06RObk4okB0hghDKI7xy5QoMMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Mbw/2gVH; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNNgR1ZBb9LEShufrMuz4kwbdF5TEbwP7TF/gZaHvuyOg/RU21Ogd5Z7K2VGaVl1I7WVUBu2fCX2HTSw5x5W8KxWFvTbsKSlWqeqsYyMAyKPcCSBndiX64xzae34pab/gGgzut/i0WnMohHdgXjT4FRGOZd9e2WBXUbV/z37iIgG5hmPgUiRtGLrVkr5wFN4XEH2oPQKKOV8/0h5qF2izBvxvdsdP1RDPKk+BNW8r2MtVd9rq5jywBJd38HzV0QU373uhJv4EF0UyyTD0SM6lbCLvx8gCXU3Gxkys+6tQLnbP0z6DjofIZIxl32/xj6HjWCpNBo5jQzABAtwqKY4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2gl1Sp6ayVBbajmw1IMfR+FqAfWlcMNAdiZatq5fI8=;
 b=Hy+vNE1TpYyLSk0TZ5TBjK6CJsbQTRU4FJZ6jUHmGGd8Iuc+mXj9i1rLu+FjBY4Ym72mjQ+mzEySGuGRk6T+5dVfPzdp6HZRCwhCbhi6gEDGhPNBvWjpN1BAF2q06p5l0pIdDg3AAs0xE/EPZmD3AxsbUG1dRyCmztZwkxsa1X0Iq0BCoggZwRRgJL0LIZNJGx35kC2PaAJLUDf06LE3NVAJz81jBChzORWcDctQi8txH5p9cSalapNXGTLLAimCO0qnQNcWp7ugV7hR/rXQN8vcY1tyNTT0UY3fhsXiIW2stMNbOo+n6HVyPvgncGa8/Ys8Rd5qhqUTzebXw4Q0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2gl1Sp6ayVBbajmw1IMfR+FqAfWlcMNAdiZatq5fI8=;
 b=Mbw/2gVHzu0u6zDv9km+qxJfI+7L8Tf9YS2cgJ3GqHMHKSvWm6cYE9EPueJMRdyTYs6VxUbEFkmwDx6L7FLHHS/qEyGMD1OX6ZftJGEP7BxR7UQEfOSaFp5LPO62hJUfFKBCTi1hThkROY7dXGvkYhxRuOvo+SoW7oxZQMPqXy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by VI2PR04MB10147.eurprd04.prod.outlook.com (2603:10a6:800:21e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 10:39:20 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 10:39:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 18:47:07 +0800
Subject: [PATCH v3 1/6] Documentation: firmware-guide: add NXP i.MX95 SCMI
 documentation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx95-bbm-misc-v2-v3-1-4380a4070980@nxp.com>
References: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
In-Reply-To: <20240412-imx95-bbm-misc-v2-v3-0-4380a4070980@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712918849; l=55803;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=fyjiPW7i3Esi/kVBE11tRQYjEUzJGakaE7Z+lYybjKY=;
 b=mOOVFcgtk5dQwc0kC/sJvbdZYvb/jWhoOSHsT6rCUetTehe+EvbLkqXDGXrlCEjcdj/ZRq6W0
 yfmA10uaBv1B60EMqRF82hUrJF8lUL29ZAjcOCTtsqZmBbk3vg40/3b
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|VI2PR04MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f30bd9-6d5a-4ab0-416d-08dc5adccfbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pz5kTqeyyy1uU+LmpRXQbw6rDpkV9uTIU3W+SpAi5gCcPTj6vazZnI7jbqD4/U0xajtx8HzXd2hcfxQb1H9zKLnlWO8MOCy4wATrj1urj6+RakQ+W44VFR/dLytQjTG9fS+bpOM/P4wqJCUeaQB8MyPBZmXam5uPOxyyHl30TjSvLzt3+APcAS9ptwzcGgeKq35lZK3CmHqULvvh1KZnlSckZE0OTggdhJI5NpCvWbRnZauTF26EBgu5Y53h8Rqla/24I6/CWiWg07aCAHcm0RF4/KPG4jpUyqFGpmLB/KjwJ86OLXbSI+wAMwEO8LAI68RO7T9qQLJmY8C0lgWtbNETaUXcYtDItvcHbnNbi5llgQ8quGhBPDFcKipjVbv3535tjIcFDg7Lx+YWet4n1UXBwSefwLsLjmRfaSKlhtMNUk0eWmoBEGjTN6/ymFi8whBP+09JJSprMcJsl+TMAGG84u9NAGRw529FZ0IaxGfwyBOZuAHKNtr/TdoL3/6DLhSq15jGbE5sshWb4gqkqIvX4C2fE+eZ9NF6fKJ5QxYndZ+Jnh1SEsg90OcHBftdVKX6qCMEpRXmDV1xgEu+So8RwHXFc0PX4hTyFo4gwca0adw9AbSSBMgv2RkJINlOGvyqtaVqK3n5stK3MANS26she5yqVwi+AKMGlMLO5xiP9R1U9TuCf9V08Y5hz0L8rg1NqXWjMyRYhu2q+dhwQgwHgyhtg6qzRXtJl8gM+Tc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlsblJENFFyWnMwSG9GMXA5WWVsTGlndk9mNVp1NWRrMG9yeGxQdTBwLzdE?=
 =?utf-8?B?S1BVcWU5RGlZQi9tMEZlS1U1NDNwaE5McGt2aCtZTTdZaWFOZlZVYU1zY2Uv?=
 =?utf-8?B?MWRaNEV3bFU4S0RNd0ZweVNpL2hzejl5WU1CU1lzSGJWbVhlSGp6VlNGOE8y?=
 =?utf-8?B?cU1rM0JwVlhEb09mWGVhSXB1RHVJVytKWWw3a084dHlzOXl4aVpQNExjUTY3?=
 =?utf-8?B?Y2xyRHB3MTd0bktheFdlTEU0R01RUmxNSHREbTI2My91cWdIa1dsVGhnVXJh?=
 =?utf-8?B?Y2pNZEowZGVhQ2dLclh2VEROOU5KQ0lnVUYxM3pTamw4OXNnVGRiME9GbTkw?=
 =?utf-8?B?Nk9vdElHNFJ5MWZxTTlpZG5OVWFNNko3ZzVIUVpxVFM5d2RVQ2NsNm43dEpE?=
 =?utf-8?B?ZGpmZ3ZCeEhPS0QwOWxLbXRtZWVXSno1NnNRSDR3NGVVRUM5emxveXEwWnE3?=
 =?utf-8?B?aGpqZSsxTWpzMkY1WW83ZGwwbmMzWEcvOHdEdkVXUmNvME1Td3R2djQxU3Y0?=
 =?utf-8?B?SEQ1ZVJ0RFhTYUNEU01SWS9iL09TZ3VPUWY3bGptNlUzenVOR0pzanIwMUVX?=
 =?utf-8?B?YWlVc1VDUEdKN1JBblZ4bVp0THh4bmVJcWtVN1p0S0U0bkdSZC9jdzE2U3hI?=
 =?utf-8?B?ZFBmdTVLZVRhV3Z2MGIxd0drMGhqZlRQZ0FhT2ZmSTVZbzhyYmZsbCtyOTJM?=
 =?utf-8?B?ZHJZV1llc0NrMjU1NXIvbVBaeFBoV3JXS1hRQXZXZkJXUUtXQ0Z2ZXZ6bEFq?=
 =?utf-8?B?N1VKZWN0cWY3YlR3UFVVSnF5OVhvOGVwaFJ6UUFTNFN6SC9vMGZwa1preEpH?=
 =?utf-8?B?cVNSQS9IUTVZZUdoNXpCY0xPaUQ4UFB6TW41dEg2aEdoME1DN0lZMi96OEMr?=
 =?utf-8?B?dGYzSVh2OU55b2laRVBkaWtmSFdJQ1k4VzlqK0JKb3JIY2htdGx1Q3kvUVVy?=
 =?utf-8?B?ZVpBTzE0Q3h6NFo3TnV5NnNsTjVDNDZxY2xtMDM2RVpsQzdFdUp6eGVjdWpv?=
 =?utf-8?B?cTFNckoyZzhlaE1QTHZxNy9KalNEbUMwMHNoSGpRNFp3OVZYZnJFY05aL1NE?=
 =?utf-8?B?T1h0Qm82WXdsa3BieGJ1REFUdm04R0ZYYW1ZVXI5dXBKSVFFYkF3L1NXemVl?=
 =?utf-8?B?L2l0S1F6cVdDTmxPczkwVHBHM2xac0o4REJ4K0luTWVEZG40Vm1iY3NwSTRV?=
 =?utf-8?B?QXIrUk41NEVqUjVBMXR4Q2lZVEI1d0c4Qyt1VXQxa29OQmRrRENIK1o0clFz?=
 =?utf-8?B?UkIrbXpwSENMN1MxeEVrVXpBYjBOOWJYREJ1V2FSWEZIbVVUVHROR0ZsL1pa?=
 =?utf-8?B?NmRWTWNRQlZlUVBWdkk5TjdhNHdxZ3pBb1NoV1ZGVm4zYlpCdVFiSTY4YU1y?=
 =?utf-8?B?WExrL0N5NlpNeGNnVWFtcmhybXRPSXFwemJBRlFNSHU0U2JjZjAvSTdaMjk3?=
 =?utf-8?B?S0NKMWQ3YWduMDBnV0pxK2JKS1dJbW1SWnVDMVpWNFhLcHZ2UmpmTDhvMjFm?=
 =?utf-8?B?S1RjZFBSV2czL2g4akhZZFNnN1crM2pmY2hxWkRSVmRRSm9DdFpHeTVZK2wx?=
 =?utf-8?B?ajNLRkRiM1hTTTRVTDNYUEJFdytYRkd4LzQzQXNrTzgyVlJnc0RRSTg5N2Fz?=
 =?utf-8?B?ZHFHRzRGYXk1ejNBT3d0N2NaZEVFWnFSbUZpU0o0cEtWQU1laW5MT0VrQWF4?=
 =?utf-8?B?QW82TTlMNjJEMTdvcFNtaDB3V3ZWQkRLbitFdGx0cjNLUGtKWlA5VXlRSVdS?=
 =?utf-8?B?Tm9xZ1F1NWNneGVjZjJyTmFWdnduZjA1ZzIvSXFqY1FqQlJET2FtVUZvTDIy?=
 =?utf-8?B?Vk15S3YwUTh1K3M4SXVaZXFxcCtZdWNRUlptWmk4U2hMTjdaVncybzFRTnFn?=
 =?utf-8?B?Z2JIeWRyalkyN2o5cVdzMzdwemhETmc5TVJRZWdRN1dsN250d2VNejBuVjFu?=
 =?utf-8?B?eDg4ajZGVWU2WVNDaHlvOVJhMjhBRUhYcnY5UzNCOVU2NHYrM2VOcktwNUx1?=
 =?utf-8?B?blBWNklxNWw1L29KWXR6bElLdFZYV3ZGeC9tdm1GMXlxVW11TThZVkJmY3ps?=
 =?utf-8?B?NnVDSEVYellUQjlLSkwwbmNEUUNac05hdzM1YXRyaFU4OVpkR1MwRDE2cm00?=
 =?utf-8?Q?IL2VLNbWpv447nbi+c3HpAStf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f30bd9-6d5a-4ab0-416d-08dc5adccfbf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 10:39:20.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0ezFm/Q3Jj0zOG4/JygGn/EA6Q0oUIlCTsstoIOLPRDOF1fmsK58zPTPl1GEUnbyKi9/MeiyNChfag0wXs5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10147

From: Peng Fan <peng.fan@nxp.com>

Add NXP i.MX95 System Control Management Interface(SCMI) vendor
extensions protocol documentation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/firmware-guide/index.rst          |  10 +
 Documentation/firmware-guide/nxp/imx95-scmi.rst | 877 ++++++++++++++++++++++++
 Documentation/firmware-guide/nxp/index.rst      |  10 +
 3 files changed, 897 insertions(+)

diff --git a/Documentation/firmware-guide/index.rst b/Documentation/firmware-guide/index.rst
index 5355784ca0a2..8f66ae31337e 100644
--- a/Documentation/firmware-guide/index.rst
+++ b/Documentation/firmware-guide/index.rst
@@ -4,6 +4,9 @@
 The Linux kernel firmware guide
 ===============================
 
+ACPI subsystem
+==============
+
 This section describes the ACPI subsystem in Linux from firmware perspective.
 
 .. toctree::
@@ -11,3 +14,10 @@ This section describes the ACPI subsystem in Linux from firmware perspective.
 
    acpi/index
 
+NXP firmware
+============
+
+.. toctree::
+   :maxdepth: 1
+
+   nxp/index
diff --git a/Documentation/firmware-guide/nxp/imx95-scmi.rst b/Documentation/firmware-guide/nxp/imx95-scmi.rst
new file mode 100644
index 000000000000..bd87a961e4a5
--- /dev/null
+++ b/Documentation/firmware-guide/nxp/imx95-scmi.rst
@@ -0,0 +1,877 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===============================================================================
+i.MX95 System Control and Management Interface(SCMI) Vendor Protocols Extension
+===============================================================================
+
+:Copyright: |copy| 2024 NXP
+
+:Author: Peng Fan <peng.fan@nxp.com>
+
+The System Manager (SM) is a low-level system function which runs on a System
+Control Processor (SCP) to support isolation and management of power domains,
+clocks, resets, sensors, pins, etc. on complex application processors. It often
+runs on a Cortex-M processor and provides an abstraction to many of the
+underlying features of the hardware. The primary purpose of the SM is to allow
+isolation between software running on different cores in the SoC. It does this
+by having exclusive access to critical resources such as those controlling
+power, clocks, reset, PMIC, etc. and then providing an RPC interface to those
+clients. This allows the SM to provide access control, arbitration, and
+aggregation policies for those shared critical resources.
+
+This document covers all the information necessary to understand, maintain,
+port, and deploy the SM on supported processors.
+
+The SM implements an interface compliant with the Arm SCMI 3.2 Specification
+with vendor specific extensions.
+
+SCMI_BBM: System Control and Management Interface Driver (BBM)
+==============================================================
+
+This protocol is intended provide access to the battery-backed module. This
+contains persistent storage (GPR), an RTC, and the ON/OFF button. The protocol
+can also provide access to similar functions implemented via external board
+components. The BBM protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Read/write GPR
+- Discover the RTCs available in the system.
+- Read/write the RTC time in seconds and ticks
+- Set an alarm (per LM) in seconds
+- Get notifications on RTC update, alarm, or rollover.
+- Get notification on ON/OFF button activity.
+
+For most SoC, there is one on-chip RTC (e.g. in BBNSM) and this is RTC ID 0.
+Board code can add additional GPR and RTC.
+
+GPR are not aggregated. The RTC time is also not aggregated. Setting these
+sets for all so normally exclusive access would be granted to one agent for
+each. However, RTC alarms are maintained for each LM and the hardware is
+programmed with the next nearest alarm time. So only one agent in an LM should
+be given access rights to set an RTC alarm.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
+|               | code definitions.                                            |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification v3.2 section 4.1.4 for status  |
+|                  | code definitions.                                         |
++------------------+-----------------------------------------------------------+
+|uint32 attributes | Bits[31:8] Number of RTCs.                                |
+|                  | Bits[15:0] Number of persistent storage (GPR) words.      |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x81
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+BBM_GPR_SET
+~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of GPR to write                                      |
++------------------+-----------------------------------------------------------+
+|uint32 value      |32-bit value to write to the GPR                           |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the GPR was successfully written.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to write     |
+|                  |the specified GPR                                          |
++------------------+-----------------------------------------------------------+
+
+BBM_GPR_GET
+~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of GPR to read                                       |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the GPR was successfully written.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to write     |
+|                  |the specified GPR.                                         |
++------------------+-----------------------------------------------------------+
+|uint32 value      |32-bit value read from the GPR                             |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: returned the attributes.                          |
+|                  |NOT_FOUND: Index is invalid.                               |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Bit[31:24] Bit width of RTC seconds.                       |
+|                  |Bit[23:16] Bit width of RTC ticks.                         |
+|                  |Bits[15:0] RTC ticks per second                            |
++------------------+-----------------------------------------------------------+
+|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
+|                  |describing the RTC name                                    |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_TIME_SET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC time format:                                    |
+|                  |Set to 1 if the time is in ticks.                          |
+|                  |Set to 0 if the time is in seconds                         |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
+|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |INVALID_PARAMETERS: time is not valid                      |
+|                  |(beyond the range of the RTC).                             |
+|                  |DENIED: the agent does not have permission to set the RTC. |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_TIME_GET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x7
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC time format:                                    |
+|                  |Set to 1 if the time is in ticks.                          |
+|                  |Set to 0 if the time is in seconds                         |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds/ticks.    |
+|                  |Upper word: Upper 32 bits of the time in seconds/ticks.    |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_ALARM_SET
+~~~~~~~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] RTC enable flag:                                    |
+|                  |Set to 1 if the RTC alarm should be enabled.               |
+|                  |Set to 0 if the RTC alarm should be disabled               |
++------------------+-----------------------------------------------------------+
+|uint32 time[2]    |Lower word: Lower 32 bits of the time in seconds.          |
+|                  |Upper word: Upper 32 bits of the time in seconds.          |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: RTC time was successfully set.                    |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |INVALID_PARAMETERS: time is not valid                      |
+|                  |(beyond the range of the RTC).                             |
+|                  |DENIED: the agent does not have permission to set the RTC  |
+|                  |alarm                                                      |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_GET
+~~~~~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the button status was read.                    |
+|                  |Other value: ARM SCMI Specification v3.2 section 4.1.4.    |
++------------------+-----------------------------------------------------------+
+|uint32 state      |State of the ON/OFF button                                 |
++------------------+-----------------------------------------------------------+
+
+BBM_RTC_NOTIFY
+~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of RTC                                               |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags                                         |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[2] Update enable:                                      |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[1] Rollover enable:                                    |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[0] Alarm enable:                                       |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |NOT_FOUND: rtcId pertains to a non-existent RTC.           |
+|                  |DENIED: the agent does not have permission to request RTC  |
+|                  |notifications.                                             |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_NOTIFY
+~~~~~~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags                                         |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Enable button:                                      |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |DENIED: the agent does not have permission to request      |
+|                  |button notifications.                                      |
++------------------+-----------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x81
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+BBM_RTC_EVENT
+~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |RTC events:                                                |
+|                  |Bits[31:2] Reserved, must be zero.                         |
+|                  |Bit[1] RTC rollover notification:                          |
+|                  |1 RTC rollover detected.                                   |
+|                  |0 no RTC rollover detected.                                |
+|                  |Bit[0] RTC alarm notification:                             |
+|                  |1 RTC alarm generated.                                     |
+|                  |0 no RTC alarm generated.                                  |
++------------------+-----------------------------------------------------------+
+
+BBM_BUTTON_EVENT
+~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |RTC events:                                                |
++------------------+-----------------------------------------------------------+
+|                  |Button events:                                             |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Button notification:                                |
+|                  |1 button change detected.                                  |
+|                  |0 no button change detected.                               |
++------------------+-----------------------------------------------------------+
+
+SCMI_MISC: System Control and Management Interface Driver (MISC)
+================================================================
+
+Provides misc. functions. This includes controls that are misc. settings/actions
+that must be exposed from the SM to agents. They are device specific and are
+usually define to access bit fields in various mix block control modules,
+IOMUX_GPR, and other GPR/CSR owned by the SM. This protocol supports the
+following functions:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Set/Get a control.
+- Initiate an action on a control.
+- Obtain platform (i.e. SM) build information.
+- Obtain ROM passover data.
+- Read boot/shutdown/reset information for the LM or the system.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x84
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification v3.2 section 4.1.4 for status     |
+|               | code definitions.                                            |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |See ARM SCMI Specification v3.2 section 4.1.4 for status   |
+|                  |code definitions.                                          |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:24] Reserved, must be zero.                        |
+|                  |Bits[23:16] Number of reasons.                             |
+|                  |Bits[15:0] Number of controls                              |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_SET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the value data in words                            |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the control was set successfully.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to set the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_GET
+~~~~~~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the control was set successfully.              |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to get the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the return data in words                           |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_ACTION
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of the control                                       |
++------------------+-----------------------------------------------------------+
+|uint32 action	   |Action for the control                                     |
++------------------+-----------------------------------------------------------+
+|uint32 numarg	   |Size of the argument data                                  |
++------------------+-----------------------------------------------------------+
+|uint32 arg[8]	   |Argument data array                                        |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the action was set successfully.               |
+|                  |NOT_FOUND: if the index is not valid.                      |
+|                  |DENIED: if the agent does not have permission to get the   |
+|                  |control                                                    |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the return data in words                           |
++------------------+-----------------------------------------------------------+
+|uint32 val[8]     |value data array                                           |
++------------------+-----------------------------------------------------------+
+
+MISC_DISCOVER_BUILD_INFO
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the build info was got successfully.           |
+|                  |NOT_SUPPORTED: if the data is not available.               |
++------------------+-----------------------------------------------------------+
+|uint32 buildnum   |Build number                                               |
++------------------+-----------------------------------------------------------+
+|uint32 buildcommit|Most significant 32 bits of the git commit hash            |
++------------------+-----------------------------------------------------------+
+|uint8 date[16]    |Date of build. Null terminated ASCII string of up to 16    |
+|                  |bytes in length                                            |
++------------------+-----------------------------------------------------------+
+|uint8 time[16]    |Time of build. Null terminated ASCII string of up to 16    |
+|                  |bytes in length                                            |
++------------------+-----------------------------------------------------------+
+
+MISC_ROM_PASSOVER_GET
+~~~~~~~~~~~~~~~~~~~~~
+
+This function is used to obtain the ROM passover data. The returned block of
+words is structured as defined in the ROM passover section in the SoC RM.
+
+message_id: 0x7
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the data was got successfully.                 |
+|                  |NOT_SUPPORTED: if the data is not available.               |
++------------------+-----------------------------------------------------------+
+|uint32 num        |Size of the passover data in words                         |
++------------------+-----------------------------------------------------------+
+|uint32_t data[8]  |Passover data array                                        |
++------------------+-----------------------------------------------------------+
+
+MISC_CONTROL_NOTIFY
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 index      |Index of control                                           |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags, varies by control                      |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: notification configuration was successfully       |
+|                  |updated.                                                   |
+|                  |NOT_FOUND: control id not exists.                          |
+|                  |INVALID_PARAMETERS: if the input attributes flag specifies |
+|                  |unsupported or invalid configurations..                    |
+|                  |DENIED: if the calling agent is not permitted to request   |
+|                  |the notification.                                          |
++------------------+-----------------------------------------------------------+
+
+MISC_REASON_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x84
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 reasonid   |Identifier for the reason                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid reason attributes are returned           |
+|                  |NOT_FOUND: if reasonId pertains to a non-existent reason.  |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Reason attributes. This parameter has the following        |
+|                  |format: Bits[31:0] Reserved, must be zero                  |
+|                  |Bits[15:0] Number of persistent storage (GPR) words.       |
++------------------+-----------------------------------------------------------+
+|uint8 name[16]    |Null-terminated ASCII string of up to 16 bytes in length   |
+|                  |describing the reason                                      |
++------------------+-----------------------------------------------------------+
+
+MISC_RESET_REASON
+~~~~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 flags        |Reason flags. This parameter has the following format:   |
+|                    |Bits[31:1] Reserved, must be zero.                       |
+|                    |Bit[0] System:                                           |
+|                    |Set to 1 to return the system reason.                    |
+|                    |Set to 0 to return the LM reason                         |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: reset reason return                             |
++--------------------+---------------------------------------------------------+
+|uint32 bootflags    |Boot reason flags. This parameter has the format:        |
+|                    |Bits[31] Valid.                                          |
+|                    |Set to 1 if the entire reason is valid.                  |
+|                    |Set to 0 if the entire reason is not valid.              |
+|                    |Bits[30:29] Reserved, must be zero.                      |
+|                    |Bit[28] Valid origin:                                    |
+|                    |Set to 1 if the origin field is valid.                   |
+|                    |Set to 0 if the origin field is not valid.               |
+|                    |Bits[27:24] Origin.                                      |
+|                    |Bit[23] Valid err ID:                                    |
+|                    |Set to 1 if the error ID field is valid.                 |
+|                    |Set to 0 if the error ID field is not valid.             |
+|                    |Bits[22:8] Error ID.                                     |
+|                    |Bit[7:0] Reason                                          |
++--------------------+---------------------------------------------------------+
+|uint32 shutdownflags|Shutdown reason flags. This parameter has the format:    |
+|                    |Bits[31] Valid.                                          |
+|                    |Set to 1 if the entire reason is valid.                  |
+|                    |Set to 0 if the entire reason is not valid.              |
+|                    |Bits[30:29] Number of valid extended info words.         |
+|                    |Bit[28] Valid origin:                                    |
+|                    |Set to 1 if the origin field is valid.                   |
+|                    |Set to 0 if the origin field is not valid.               |
+|                    |Bits[27:24] Origin.                                      |
+|                    |Bit[23] Valid err ID:                                    |
+|                    |Set to 1 if the error ID field is valid.                 |
+|                    |Set to 0 if the error ID field is not valid.             |
+|                    |Bits[22:8] Error ID.                                     |
+|                    |Bit[7:0] Reason                                          |
++--------------------+---------------------------------------------------------+
+|uint32 extinfo[8]   |Array of extended info words                             |
++--------------------+---------------------------------------------------------+
+
+MISC_SI_INFO
+~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: silicon info return                             |
++--------------------+---------------------------------------------------------+
+|uint32 deviceid     |Silicon specific device ID                               |
++--------------------+---------------------------------------------------------+
+|uint32 sirev        |Silicon specific revision                                |
++--------------------+---------------------------------------------------------+
+|uint32 partnum      |Silicon specific part number                             |
++--------------------+---------------------------------------------------------+
+|uint8 siname[16]    |Silicon name/revision. Null terminated ASCII string of up|
+|                    |to 16 bytes in length                                    |
++--------------------+---------------------------------------------------------+
+
+MISC_CFG_INFO
+~~~~~~~~~~~~~
+
+message_id: 0xC
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: config name return                              |
+|                    |NOT_SUPPORTED: name not available                        |
++--------------------+---------------------------------------------------------+
+|uint32 msel         |Mode selector value                                      |
++--------------------+---------------------------------------------------------+
+|uint8 cfgname[16]   |config file basename. Null terminated ASCII string of up |
+|                    |to 16 bytes in length                                    |
++--------------------+---------------------------------------------------------+
+
+MISC_SYSLOG
+~~~~~~~~~~~
+
+message_id: 0xD
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 flags        |Device specific flags that might impact the data returned|
+|                    |or clearing of the data                                  |
++--------------------+---------------------------------------------------------+
+|uint32 logindex     |Index to the first log word. Will be the first element in|
+|                    |the return array                                         |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: reset reason return                             |
++--------------------+---------------------------------------------------------+
+|uint32 numLogflags  |Descriptor for the log data returned by this call.       |
+|                    |Bits[31:20] Number of remaining log words.               |
+|                    |Bits[15:12] Reserved, must be zero.                      |
+|                    |Bits[11:0] Number of log words that are returned by this |
+|                    |call                                                     |
++--------------------+---------------------------------------------------------+
+|uint32 syslog[16]   |Log data array                                           |
++--------------------+---------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x84
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+MISC_CONTROL_EVENT
+~~~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x81
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 ctrlid     |Identifier for the control that caused the event.          |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Event flags, varies by control.                            |
++------------------+-----------------------------------------------------------+
+
diff --git a/Documentation/firmware-guide/nxp/index.rst b/Documentation/firmware-guide/nxp/index.rst
new file mode 100644
index 000000000000..b38c980a50c6
--- /dev/null
+++ b/Documentation/firmware-guide/nxp/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+NXP Firmware Support
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   imx95-scmi

-- 
2.37.1


