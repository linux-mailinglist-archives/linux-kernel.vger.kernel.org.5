Return-Path: <linux-kernel+bounces-167039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E65A8BA3C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2B01C22D92
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97F1CAA1;
	Thu,  2 May 2024 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Lp6w0flr"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECE482DA;
	Thu,  2 May 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691333; cv=fail; b=WN6V6ahhWJedippKSZVjPHShoKdpwL7Bv+zMug6aBS81S8cL43x4RfgraLvRRaaTbtXHXTV9OTVCiEH5Bb1S8++IMnHh0iIscv5bAbW18PMkftp4XFfD2MmhPVzbBPVuitmYyVom2cjbQT5/xBXi2UCPv2HxjMinkT5KM3GRAfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691333; c=relaxed/simple;
	bh=h0WD+YKZJ+BkY6/2Img/rT+RmMIHKViJIiHNQrkaymc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oww9xFQLI0CRR2Oss4ogfqot1RxI0OMPW20fB9eFGxGLDIRSmNkFKzIbrIkq7Dvtn/fZCvaRTHBGpaawgUIBLQu2HP6yNVSjrlAaTMYDZpY6W1QT6KiZ+ZPO1wP1jXqwNZiD5KnJwS9cFGdAeytNDxoCrqS9ufnTfm5iQvSazpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Lp6w0flr; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1pLG7MyTaZYPdkqku59Nx85jBa8qpYFkRrVKiH51QXSdX0YCzJMyhjc67K5u4cYPuWDPEF+h3txnmlDv+O0VrV87VvYJ6ai7ZyJBqYQsYno/y1omPmPEx/zgv0Z6tHG5pQLoNLg25NjUdYn2KMbWJagNP0Y92zyL4issrr7JrTBCIKpqKylZXC69ozwLIOcvJiBUwIHtyOx9T8x79KeiVFhlHX7uWQIUPHNSBFTWMOBt/Lt12/EHKQjTUclELD8dctObgF3oJyXbrQECMCiCJy0rzhdzEpinjT6oEJtNWkDehgXh9NklzGVMsIVuI02U3toIJ/nOGSNX8ziCvaxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms0u21kTtj5NAUk6YlnMwJHrpvYOptO+lCoRz5s2i+A=;
 b=WrGgqEfmc9i52Z9SEVmtVZiCCg95H64HZeRZhzjkhFILyU3xtay6TEwX/iSBo+pWfnZUI67abwISKCZOS3qgvTw0PlpMBgifMUSEXK3iFDn4uf4/vH7nGfA+ulX+2FOZR2q9f6JugyaPkm1I404IyrtmEsce9nh/F2rCZLsl9r6Duenret69WkyKT5VOvGguCzlxWYWrgs/OEoyvOuqqCS2CpHFGAbIMZqlyU9BWiZ60yOuiahs/GBNhAJ8ZECOkMZUUz+UQuLKFSPToB6gQrQI4ZQIuBw0+rF2ALLov8xrAvY+1zlFZ6tSj4SkV0wNU7BlnenTtP3KNhEuZlPoP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms0u21kTtj5NAUk6YlnMwJHrpvYOptO+lCoRz5s2i+A=;
 b=Lp6w0flryWbxpJAF/rGZItGVCjVoIq13I+c9LKTe6/+jNe6ONuleQI3AYYLSgvnw6WaDhNssoa+XgXGPsLFm4MU1HT6G+n/oRrUdLuF5MwYoLQoSh3vsYq7aC6aiaoxRdHLA3HnydxRdF0+9WySyUxeEOXo3Delibr9SJEq5l7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CH4PR22MB5918.namprd22.prod.outlook.com (2603:10b6:610:232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 23:08:46 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:08:46 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 4/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
Date: Thu,  2 May 2024 16:08:29 -0700
Message-Id: <20240502230829.1983678-5-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502230829.1983678-1-nmorrisson@phytec.com>
References: <20240502230829.1983678-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|CH4PR22MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 35007b15-dbb2-4786-5695-08dc6afcd190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hY/RcSGS3v5tEpTWfAI5sX9woeX+HfYcGXvKmvq7zS0uDEEUSO3sju//qZxA?=
 =?us-ascii?Q?eY3qMQD2bvZBGLCF1sSUqtsPqIQju9aqLnqsqGzaQkNElUdtxfGYjEWRbTz1?=
 =?us-ascii?Q?ow+wc+ExkXUvq+LcbIN2cNX5ee4OA/v4T8oPvivd01JPgac7i1heo97s/OlG?=
 =?us-ascii?Q?3FBI+JIV7DoSmZeaI8eaPHSd0bRX9Fi0G2S4vxeWCyMfeMPKPxXGLWtWVPBE?=
 =?us-ascii?Q?87nZkM3JS2Jl4S2wAnEjAN3LW1m+EqehpnEHkrB6/LCifYVZvZtOJ5PdwOmI?=
 =?us-ascii?Q?s3HCNSFpswHxAV0TVun/v5qcMGs+2L665wD9CiDjBFEqZQjv0uL10d/87VOC?=
 =?us-ascii?Q?974NR9v3O9ZpAvX/7RjgBmkoFmxP05rlB741gxJsw8vt6KcgeuHt0ioLXbTH?=
 =?us-ascii?Q?R1vH1mjvfFrfPG9xrmeJ6RK+UnIP5JVSu0AtFFCM7HlfOJ3A0PCHbykYSaVa?=
 =?us-ascii?Q?O/E3LR2x/UxPJjeSJIyUkNE8+JC5S1FDtGVRIgi7PrJp90kNufUyxQXDcQ/+?=
 =?us-ascii?Q?wNjlqnCTPTdU+d7K9dsjlQKFhWEKracG6WGqy726MXC3/siAFpKRNqfLdY/0?=
 =?us-ascii?Q?lA6rO6zCAEIR81eMvm50kwaEAReuPF8spPQgDai9pS7q1TUQEtpF8lXHc47j?=
 =?us-ascii?Q?JQrkr3Gk6ldAkoZwmc8NJfaARr5MgPhuM0bbkcDJUVLzSedN+t+NKw2PDOV6?=
 =?us-ascii?Q?qnMyAuz8KIkqxY+rVdXbzEvJj0bHJnWjOHwGaQbSswVlSYK1QZmCI7lwaSf/?=
 =?us-ascii?Q?ZGZ5oaQe7F1TiC05WdWxMRohyKmNSFwyYU48DiYaFVcR8fy+H1IHrPvFHOXh?=
 =?us-ascii?Q?UiIgFKV4jwKTEa0vBYx7ZEZKRX+TA4r02OsTN+w5YMPvxVErky8jLX0SE6a8?=
 =?us-ascii?Q?45xKGIA2p0MWhzBgW9mZ7uYOGuRyv7mnVxBV60ePf5U+mx2yOhvzwNcprQ93?=
 =?us-ascii?Q?p2ledCR/VOJ0YQBkuyiEWhZ3JR8tlW+Xc2kCaO6K+flh478Ff9syuaCuYHUM?=
 =?us-ascii?Q?ISxSvoSX7PWsP+EuNsIQdMxUoY61zyrYz8uPqWX1EmXjuyqG1jNFcblkKb4Z?=
 =?us-ascii?Q?gGk3hs42MdbkotGklW/ES/zahkvr2DwRaWl71GlUkYKn7hxXg7SAPy/Uu4WY?=
 =?us-ascii?Q?j7zDMxsrqvGZ/ysmVYclJnlmdFSj+YFtWVP51ZHbogR+WeDqJXbqQvoN7c+Z?=
 =?us-ascii?Q?eTktTcGseUtxF83SVi2D4g5JEWw6zxhJgu8Y9L/Gn/7qXc3QDdVGqxH3V6tP?=
 =?us-ascii?Q?9ccoz6Fq8oS8ht41ZQCmYhkrhzzv3VGfa9XA/xMnnVlDPiiiXEmENxkYGCEM?=
 =?us-ascii?Q?K+J5EfYhzy5JeGpodyK146JkPUu+34lC584tTu4SOISU5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZvWxRB1a1xtgjVuRjIfFJkm864Z7vv6q59ALOMZUdzNplOnWFlu7wk4I388?=
 =?us-ascii?Q?vqikp5zUrJR+9rFaePtqJ8nv5Y3Hmrk1D056BWug0nAJEKkV4NyasV00p/pk?=
 =?us-ascii?Q?A0huACCMCwTgpPME4aeWXKLap2Aaknlv4RxcsCAFTnttCXwcpLjsOn57pXH/?=
 =?us-ascii?Q?98mQzvveNPDlfDH8/Ynk03wpbckV+rjWjFTKvQBybTO0j2bojCYf0EwgoPQM?=
 =?us-ascii?Q?6IHocsUYmvIf9cyt/MdIVyM1jZPDDdxHuIzP0wLAbjHQNZlJd7sLMSC1BoSF?=
 =?us-ascii?Q?rKIroOYXRnREYC63EzHgj9jVcGvK1wAnS6EJvOG2nmZPwJ2HPnmTmxFYQOX2?=
 =?us-ascii?Q?WlxETuzsEdpkiPjLsSb/NC2hyE8AEg9HqXdvqnU2hgv/Hy8KyBXTrBHM+DTd?=
 =?us-ascii?Q?4Jps0SDrUYKFLKZelId4WrwG2oF93WwhUFf1qIDJ+J5hMM2lR9JjtfZTKS8V?=
 =?us-ascii?Q?tSgUBQZYCi25sum+PtEhpB//eX+inuAbQvY5Op+6jckWIQqu5W9xWXWYMcFP?=
 =?us-ascii?Q?7LUlmvLwb4Yt8ki/axDi67Jr4JkFFpZ0VhiFPbMSbpvdZVR4JU0/TzhmM5yH?=
 =?us-ascii?Q?+NZ775nAGeLYag0mGyzU0Fs086fVpwPsoKtdhYYacEgQghVLgEKQuOxg7r7J?=
 =?us-ascii?Q?tYHpWB7fVi0NkQ8PbDazsv7BDS65lwCwaDzxTFnJTCbapdDTaQrCu2VDI6nC?=
 =?us-ascii?Q?y+fBFZAu1W9yi12YgzCQKFprAz9bgjhBYLC9V4xAI7m8rt1GwcRWRI6UbVrZ?=
 =?us-ascii?Q?PL5TcL9t6TbdWlbYUNuE18+7en90UzsmRRkt/bJuxRmci7LEhB3/eTPM//yx?=
 =?us-ascii?Q?/YVEEyJ4sWZjrqneO7wPJtiGSvZSewq4RC4ZP8QHWehXPnHrUl+UJy/Uu9zV?=
 =?us-ascii?Q?e9r8j09ltDuUtFeaAAqEsfgQcRNdwtWyH/+N6YJjQZQsJOqHqEwskj5E0Uk2?=
 =?us-ascii?Q?ljA0uszTlsNimXPZlDzrtPDQKE0jfcljYqLHs5DapfOkasV8jO2QJQ356nPN?=
 =?us-ascii?Q?Q2nZWU1GrlXt6Spm2fbaoNbqR649oT/T9DcUf/2mupSCnudSRbW+uvIDW5ug?=
 =?us-ascii?Q?1+UgF6ry7BnMGtYSgRw5r1PKw/sZfFIOhCfYLoVX0U/mJbGStm+wR5cGTgGm?=
 =?us-ascii?Q?1d6nKB0jOy79ndAkwmV7fOkfiLsDsfIB8A/eTilmcq6jYYRKKVyxvo2xFk40?=
 =?us-ascii?Q?dQxmJH/2wRMvFaxlEAUInbF2pyycu4RVUEZyjOM9wwdnkSApGpLImIfwbqlO?=
 =?us-ascii?Q?6LcdBgXQEUPMVunxTvggkD4+7saJvBfuoi/cMRCR01LsVmicos/G+RChd9Xg?=
 =?us-ascii?Q?xd0NTS3dsQC4IyA8nw0wgX8jYp1ZdSVvZlvmTslVtDoga5nEQtC/x+Qgiw2h?=
 =?us-ascii?Q?SmDZSljJJXsZO1UGLeuplUnhmay4UZ57NiumRxdH1BZb7IiwrMy0MvY8nz3B?=
 =?us-ascii?Q?A48eFrstxnXY6V1nNsBhCM+qcJEldthPeWt+I5yy1neOAKVwFoCgWNB//dIl?=
 =?us-ascii?Q?q08ZtrVYCMuNqrQGVEyVfAMyOMti1uESJ3bcl8ZWmLs9bP9JLjvpPcORyC+L?=
 =?us-ascii?Q?5URzXCZhN1lYSUpAbSPhulY2fGRP5/aMCd8x4DHp?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35007b15-dbb2-4786-5695-08dc6afcd190
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:08:46.1151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+AHVfr5EgfGdA/c7566WZ9Udnt0h/UI0ecx5BnuUoXf+EX43Xn405AHcMMV2Iz+twgfdMTkxcdvROQBN7jmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5918

Add an overlay to disable the spi nor for all am6xx-phycore-som
boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile                   |  1 +
 .../dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 83a108eb4a3d..01e5f3a83996 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 # Common overlays for the phyCORE-AM6* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-spi-nor.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
new file mode 100644
index 000000000000..cc0cf269b6e4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 PHYTEC America, LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&serial_flash {
+	status = "disabled";
+};
-- 
2.25.1


