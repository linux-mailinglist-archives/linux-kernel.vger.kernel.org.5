Return-Path: <linux-kernel+bounces-35691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA47839544
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04590B2B9AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91D88615D;
	Tue, 23 Jan 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9x0ZUqW"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E08613F;
	Tue, 23 Jan 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028189; cv=fail; b=dKi3P9bSbw2k4wh2jgycb5foXQQO5qLINrX07WWQzhJqEm7BG72KgtgiiH5hByGenpdx6WWk8RN9huCIneRh82Igsic25sZ5brWqrOQB3txQk0+rpvgnzdmTY0G+bWO9pbNF2LQJ0CzB+lHcGv4T8PUKZGlNa0BR+tt0d5jQFuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028189; c=relaxed/simple;
	bh=QW8sn+VQ/3fwnaQ31eT8VGBdDK7MJ46DE1RzDubC/bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szj5qr66ElHMI8JaqzpEtpsQMhgcqfj3A6cgeUX5cWhxGbU8O0oQY8zVqaBjLyEHr9UZshJ8XoZadv42vx9+3t5O4d+bmemxnM/DEDoB3K2TvWil9MVvrLtKiJ7nQkfF5DVpY5hLJ/mw5CawGlfRbZveFRyAkgvu656lUbHiGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H9x0ZUqW; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBStMt2th+BsCvC6hIO/00b7N1+YZvzlMa/6V2tD8FU2/MIuKgOQzpGtpkais21O/X/FS81Mk9MkDdLoCP9ViFhYjsQeL6TjvhPKs4LlKNssBPv2ntZPC09R9eYzOBpn28h4XIS3TCEZiVZJU5mftXcbJWJV6im8Wv3vyEOdWa65NycqSVba/q91cp5Fyx1NEERhDEnnvZO95+Gx06fVdItskiWQGRD/j3aDHB6FfDO0LfsmKMBnl0STTElHP/XAxQH4CCWwb5/Mwo1g+xH7jLWotCn8GmrzoKP+8MN7uKdo93fymfoQxvtn7U5bb2aZ6Svm8GH48Pn3Lwq4hRWJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kPmnKpcvuhnrqH1o3P/DoLtZPg2O4Dnl52Ecnuv6nI=;
 b=mlgUHbmKORcyNaE2lAW5FJ5FMZa6USHWqRYUOd99VeSYdvwYudy0IweJppeK9fYTXkHQk7c9apt54SBTsMWV52Fp9G5BDl6MlwbZ2+u2Li2JUpB5COCs4+N9BoDqre20IBxvAggpanEerIHzpTN6MNKs75EiXNozEiZ5Fr2PqJCOP9re2/S0JwaI1OSHN7cr9rEG7RgHfgyUvZGB3tocv4iW0PWhwo30W7ZdnBjGusy/BRxQTtfCY1y8lHtwZG0uJWHgKo7T+wk+hbmAgqgQMnYg9I7tm6c9VtxoZgPpGMkD3gPFwEIlejZ9Iz5PdKu0EXWgKzk09A3vNxL/BB47jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kPmnKpcvuhnrqH1o3P/DoLtZPg2O4Dnl52Ecnuv6nI=;
 b=H9x0ZUqWItUC5HxzBOLu+kDy6IFKz9dwQ46xf0mNbkQ0I/GYo5paiKKPZz8W7wdE/ZrRbtLPcw0WyKYtXSX6fQmggUtQFXk+vX28r6Yb/NXSxPj1iXKLFYv7ggWaiM6a6reKctZxqEy3pszIvihi4cUgJHFdOPK2pOOAnuzY6Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:43:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:43:02 +0000
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
Subject: [PATCH v3 1/3] XHCI: Separate PORT and CAPs macros into dedicated file
Date: Tue, 23 Jan 2024 11:42:39 -0500
Message-Id: <20240123164241.3689109-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123164241.3689109-1-Frank.Li@nxp.com>
References: <20240123164241.3689109-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b34c18-b857-46e8-e4f1-08dc1c325d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E3tP0dWaybuY6zKsrLhKkPW/mq2y4APYLM8BhsXBIv6HVewzjgWCFVzOibN7lrRkQAa2ByTRAQOB4vZ+sIqEphozTzBguDszC4HgAroyt6jSuQ8I9n3T1tcDTB+F9JK/aGDveVFTuvSp6RfcAKVjI9b3wl6O3K9qdY2Pov52735EceUdZyCZcyCPy/psmFnprr5GXiRGrl3YF69hRzZECRZOu0V8qZozobgA3inX8WFWJPtfIRCH/8OuY1yzFrnnBdAkO4Xd4G9TO3RfbWJ7t8uW8QnxIK1Ffi6zYSAv5RmfJewpYDbrEPxb3dKBPONA+8pFTROUN5JpDKbUFnP2qhy+pxivoULUGqrxIr23bwzAux5uSLmQ90K+Wv/0q4qzca7z+I8NRXfTbiegPAfDG5vclzWrGXllSDgbU+x4h4mPeEG9EBpEFstc1iPXvIa0f+dLbjU38prDsIVzcXh0+EALy2sEzBjTYjxCPrZl7KJ3Er9NzBzDRPsQ3W5G/o9B3Uy/fn6nYTYXt/VXi27/+D+M6DMrA5o5X79ncCpEb8NfznWRxAoKd4qNvHVu5nwqFo6bSnHtUNU/5lPKGrwY4Xvju+RlAjGZ1SKYkaej7WGvHQYfPzTfudzNQDLeEgCL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(4326008)(8936002)(8676002)(30864003)(2906002)(5660300002)(7416002)(41300700001)(38350700005)(2616005)(6666004)(6506007)(52116002)(6512007)(83380400001)(478600001)(1076003)(26005)(66946007)(316002)(66574015)(6486002)(66556008)(66476007)(6916009)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4T1BA2lP/4+e/Sg7CI60w9aijz5kSCpgCqVwkIwrdizMU/kcG2hZYkw7Balu?=
 =?us-ascii?Q?2a/IExTCv9EF0lj2y9ewBweWvWgXIuEAr1CY5qXRThsuIHmYJv0bSg88hKKT?=
 =?us-ascii?Q?zTs9VemZQJ6J8MRfnrxR0n5fQVj9gi5TEFOebizJWIgyzAQ9R7kK09f7dELe?=
 =?us-ascii?Q?lv/BLbVI9f0E5Fgl07RCpd9cCxYYn03+48QxuW0HHxCl0+zzUXOsmZNXmDeD?=
 =?us-ascii?Q?LKv8/BQjmRuJ+tv63r5JCBfOsYVBF5W2bM1t7m03t4/occ9S3D4FHO2Bawp1?=
 =?us-ascii?Q?6XwCN1VjkooGw39eNF/lRfIC8ycbwdD6JNeQ7bdGn/Q2FqhoNn6oHtAx3K+u?=
 =?us-ascii?Q?EqXweV3D5NnsAeN5g0cJRsOe9eTuC9O6FjSXonrbjCYku3fbur4y4xKhx4gv?=
 =?us-ascii?Q?8EyiqxXLJymkcazcomdIwanWpthTTdgrJwMlIsHpqdEBHP7L1LniZht8edAC?=
 =?us-ascii?Q?gPfcq5XJwvBxbYczdUhLECmcOO1EPecfYaJ/PTPX8/RD9qNN1jO2RmmUnnLe?=
 =?us-ascii?Q?Y3MAcqhH1pr+Q6/pqityrrSM17fx7ZyzjDxT5MOtwrF8f/6ucZC8eKJNkW09?=
 =?us-ascii?Q?LOU2t+oFTjubf1KcBnupP4XVNgwStH1ZzxZl572LKSf77T5ZSoBMhKauq5iR?=
 =?us-ascii?Q?XAretdxFCLBNDYZ3DKJOApfC6gD6aZ5b/USmcJKD8uuU+5TUeDmp78HYYul6?=
 =?us-ascii?Q?MdBwYJumeF1J5XOuVkscNJ0Zv7z5ASELPPj1Fr6rNB1a2H/w1BFx2FxoCmhS?=
 =?us-ascii?Q?NVAFixMqkm8okrLYF/izEiAw+oehOkpIZzExyU7yiVQWEjek5tVKFo3meGUg?=
 =?us-ascii?Q?Dv8YUMK1uYwq/NKTf/ckh7D9BkKF458/zoJaHed7U1AOkDHzcCVWo7uSL8wc?=
 =?us-ascii?Q?E2VM53+xfFnU6iILcH4iuvkgER84QtgmnS03w2UqP4up+6einjgojTuG3txh?=
 =?us-ascii?Q?a/wm9Lj0625RVR6/rah0/pPZ26eRFKSdPygqoMUEr9IWVQoyQbm7VLTYDtGi?=
 =?us-ascii?Q?4PL62at3MmL9ltrfqzpzOlsi97HLKjeVyh9tW+PkmnQETst3HjuCurPijl1k?=
 =?us-ascii?Q?IaWIm5TXE+TsDTlP0Hasr6tVmit+LWTwzjbTuht4qaZExflixuxtBpevapzM?=
 =?us-ascii?Q?EJWAJXWYX4L8I+Xn5IGM0zdBynH5mcj+PSBX1MqdWlfoSV65uhSaXhCrnCUT?=
 =?us-ascii?Q?z60bRmbVUg3K946mH0jkemaHGs1HBg+YjF3NpTIa7r3Ug+RzbPFrAgTa1/Ir?=
 =?us-ascii?Q?df74rn0EwLYjSkTnCdW54ZONl/UVo5/HZFHpDfLj9Mi7HUiIhNpvLsijBmje?=
 =?us-ascii?Q?H5qCYvNTQCOzJ029Wah6Gef/xDAYDRvbaDkVHalL4Y2bEGo9+Q05VmEdM+K5?=
 =?us-ascii?Q?hARJ7kVomRvpcTgbGltGdXOANNEmegcZISJw0X6vQ4DsXRPFNiefiw9Sic8x?=
 =?us-ascii?Q?SyiuQ2nuSZ8XYlajbPa/DVdvx3X1XeInJu3ZUOkW3ExIHm6ZW66zQengPPEq?=
 =?us-ascii?Q?8A8WR0ntISqOWj8nt8h1AGo8bmxd8yhkMCG69zper/Wy7Q7FO82aT2VjPqkg?=
 =?us-ascii?Q?PpLIgIlkvn/O/QfTR8g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b34c18-b857-46e8-e4f1-08dc1c325d9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:43:02.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6P4TCaqxC9AM2bmXl/tuWlH/F4ogzYcBd+7Iy13UnskWrJetvdC6fDpwU6ZfC+UooPb4/Js0mQXOtKy1y0Caw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

Split the PORT and CAPs macro definitions into a separate file to
facilitate sharing with other files without the need to include the entire
xhci.h.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/host/xhci-caps.h |  85 ++++++++++++
 drivers/usb/host/xhci-port.h | 176 +++++++++++++++++++++++
 drivers/usb/host/xhci.h      | 262 +----------------------------------
 3 files changed, 264 insertions(+), 259 deletions(-)
 create mode 100644 drivers/usb/host/xhci-caps.h
 create mode 100644 drivers/usb/host/xhci-port.h

diff --git a/drivers/usb/host/xhci-caps.h b/drivers/usb/host/xhci-caps.h
new file mode 100644
index 0000000000000..9e94cebf4a56d
--- /dev/null
+++ b/drivers/usb/host/xhci-caps.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* hc_capbase bitmasks */
+/* bits 7:0 - how long is the Capabilities register */
+#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
+/* bits 31:16	*/
+#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
+
+/* HCSPARAMS1 - hcs_params1 - bitmasks */
+/* bits 0:7, Max Device Slots */
+#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
+#define HCS_SLOTS_MASK		0xff
+/* bits 8:18, Max Interrupters */
+#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
+/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
+#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
+
+/* HCSPARAMS2 - hcs_params2 - bitmasks */
+/* bits 0:3, frames or uframes that SW needs to queue transactions
+ * ahead of the HW to meet periodic deadlines */
+#define HCS_IST(p)		(((p) >> 0) & 0xf)
+/* bits 4:7, max number of Event Ring segments */
+#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
+/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
+/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
+/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
+#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
+
+/* HCSPARAMS3 - hcs_params3 - bitmasks */
+/* bits 0:7, Max U1 to U0 latency for the roothub ports */
+#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
+/* bits 16:31, Max U2 to U0 latency for the roothub ports */
+#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
+
+/* HCCPARAMS - hcc_params - bitmasks */
+/* true: HC can use 64-bit address pointers */
+#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
+/* true: HC can do bandwidth negotiation */
+#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
+/* true: HC uses 64-byte Device Context structures
+ * FIXME 64-byte context structures aren't supported yet.
+ */
+#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
+/* true: HC has port power switches */
+#define HCC_PPC(p)		((p) & (1 << 3))
+/* true: HC has port indicators */
+#define HCS_INDICATOR(p)	((p) & (1 << 4))
+/* true: HC has Light HC Reset Capability */
+#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
+/* true: HC supports latency tolerance messaging */
+#define HCC_LTC(p)		((p) & (1 << 6))
+/* true: no secondary Stream ID Support */
+#define HCC_NSS(p)		((p) & (1 << 7))
+/* true: HC supports Stopped - Short Packet */
+#define HCC_SPC(p)		((p) & (1 << 9))
+/* true: HC has Contiguous Frame ID Capability */
+#define HCC_CFC(p)		((p) & (1 << 11))
+/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
+#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
+/* Extended Capabilities pointer from PCI base - section 5.3.6 */
+#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
+
+#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
+
+/* db_off bitmask - bits 0:1 reserved */
+#define	DBOFF_MASK	(~0x3)
+
+/* run_regs_off bitmask - bits 0:4 reserved */
+#define	RTSOFF_MASK	(~0x1f)
+
+/* HCCPARAMS2 - hcc_params2 - bitmasks */
+/* true: HC supports U3 entry Capability */
+#define	HCC2_U3C(p)		((p) & (1 << 0))
+/* true: HC supports Configure endpoint command Max exit latency too large */
+#define	HCC2_CMC(p)		((p) & (1 << 1))
+/* true: HC supports Force Save context Capability */
+#define	HCC2_FSC(p)		((p) & (1 << 2))
+/* true: HC supports Compliance Transition Capability */
+#define	HCC2_CTC(p)		((p) & (1 << 3))
+/* true: HC support Large ESIT payload Capability > 48k */
+#define	HCC2_LEC(p)		((p) & (1 << 4))
+/* true: HC support Configuration Information Capability */
+#define	HCC2_CIC(p)		((p) & (1 << 5))
+/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
+#define	HCC2_ETC(p)		((p) & (1 << 6))
diff --git a/drivers/usb/host/xhci-port.h b/drivers/usb/host/xhci-port.h
new file mode 100644
index 0000000000000..f19efb966d180
--- /dev/null
+++ b/drivers/usb/host/xhci-port.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
+/* true: device connected */
+#define PORT_CONNECT	(1 << 0)
+/* true: port enabled */
+#define PORT_PE		(1 << 1)
+/* bit 2 reserved and zeroed */
+/* true: port has an over-current condition */
+#define PORT_OC		(1 << 3)
+/* true: port reset signaling asserted */
+#define PORT_RESET	(1 << 4)
+/* Port Link State - bits 5:8
+ * A read gives the current link PM state of the port,
+ * a write with Link State Write Strobe set sets the link state.
+ */
+#define PORT_PLS_MASK	(0xf << 5)
+#define XDEV_U0		(0x0 << 5)
+#define XDEV_U1		(0x1 << 5)
+#define XDEV_U2		(0x2 << 5)
+#define XDEV_U3		(0x3 << 5)
+#define XDEV_DISABLED	(0x4 << 5)
+#define XDEV_RXDETECT	(0x5 << 5)
+#define XDEV_INACTIVE	(0x6 << 5)
+#define XDEV_POLLING	(0x7 << 5)
+#define XDEV_RECOVERY	(0x8 << 5)
+#define XDEV_HOT_RESET	(0x9 << 5)
+#define XDEV_COMP_MODE	(0xa << 5)
+#define XDEV_TEST_MODE	(0xb << 5)
+#define XDEV_RESUME	(0xf << 5)
+
+/* true: port has power (see HCC_PPC) */
+#define PORT_POWER	(1 << 9)
+/* bits 10:13 indicate device speed:
+ * 0 - undefined speed - port hasn't be initialized by a reset yet
+ * 1 - full speed
+ * 2 - low speed
+ * 3 - high speed
+ * 4 - super speed
+ * 5-15 reserved
+ */
+#define DEV_SPEED_MASK		(0xf << 10)
+#define	XDEV_FS			(0x1 << 10)
+#define	XDEV_LS			(0x2 << 10)
+#define	XDEV_HS			(0x3 << 10)
+#define	XDEV_SS			(0x4 << 10)
+#define	XDEV_SSP		(0x5 << 10)
+#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
+#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
+#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
+#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
+#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
+#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
+#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
+#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
+
+/* Bits 20:23 in the Slot Context are the speed for the device */
+#define	SLOT_SPEED_FS		(XDEV_FS << 10)
+#define	SLOT_SPEED_LS		(XDEV_LS << 10)
+#define	SLOT_SPEED_HS		(XDEV_HS << 10)
+#define	SLOT_SPEED_SS		(XDEV_SS << 10)
+#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
+/* Port Indicator Control */
+#define PORT_LED_OFF	(0 << 14)
+#define PORT_LED_AMBER	(1 << 14)
+#define PORT_LED_GREEN	(2 << 14)
+#define PORT_LED_MASK	(3 << 14)
+/* Port Link State Write Strobe - set this when changing link state */
+#define PORT_LINK_STROBE	(1 << 16)
+/* true: connect status change */
+#define PORT_CSC	(1 << 17)
+/* true: port enable change */
+#define PORT_PEC	(1 << 18)
+/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
+ * into an enabled state, and the device into the default state.  A "warm" reset
+ * also resets the link, forcing the device through the link training sequence.
+ * SW can also look at the Port Reset register to see when warm reset is done.
+ */
+#define PORT_WRC	(1 << 19)
+/* true: over-current change */
+#define PORT_OCC	(1 << 20)
+/* true: reset change - 1 to 0 transition of PORT_RESET */
+#define PORT_RC		(1 << 21)
+/* port link status change - set on some port link state transitions:
+ *  Transition				Reason
+ *  ------------------------------------------------------------------------------
+ *  - U3 to Resume			Wakeup signaling from a device
+ *  - Resume to Recovery to U0		USB 3.0 device resume
+ *  - Resume to U0			USB 2.0 device resume
+ *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
+ *  - U3 to U0				Software resume of USB 2.0 device complete
+ *  - U2 to U0				L1 resume of USB 2.1 device complete
+ *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
+ *  - U0 to disabled			L1 entry error with USB 2.1 device
+ *  - Any state to inactive		Error on USB 3.0 port
+ */
+#define PORT_PLC	(1 << 22)
+/* port configure error change - port failed to configure its link partner */
+#define PORT_CEC	(1 << 23)
+#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
+				 PORT_RC | PORT_PLC | PORT_CEC)
+
+
+/* Cold Attach Status - xHC can set this bit to report device attached during
+ * Sx state. Warm port reset should be perfomed to clear this bit and move port
+ * to connected state.
+ */
+#define PORT_CAS	(1 << 24)
+/* wake on connect (enable) */
+#define PORT_WKCONN_E	(1 << 25)
+/* wake on disconnect (enable) */
+#define PORT_WKDISC_E	(1 << 26)
+/* wake on over-current (enable) */
+#define PORT_WKOC_E	(1 << 27)
+/* bits 28:29 reserved */
+/* true: device is non-removable - for USB 3.0 roothub emulation */
+#define PORT_DEV_REMOVE	(1 << 30)
+/* Initiate a warm port reset - complete when PORT_WRC is '1' */
+#define PORT_WR		(1 << 31)
+
+/* We mark duplicate entries with -1 */
+#define DUPLICATE_ENTRY ((u8)(-1))
+
+/* Port Power Management Status and Control - port_power_base bitmasks */
+/* Inactivity timer value for transitions into U1, in microseconds.
+ * Timeout can be up to 127us.  0xFF means an infinite timeout.
+ */
+#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
+#define PORT_U1_TIMEOUT_MASK	0xff
+/* Inactivity timer value for transitions into U2 */
+#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
+#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
+/* Bits 24:31 for port testing */
+
+/* USB2 Protocol PORTSPMSC */
+#define	PORT_L1S_MASK		7
+#define	PORT_L1S_SUCCESS	1
+#define	PORT_RWE		(1 << 3)
+#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
+#define	PORT_HIRD_MASK		(0xf << 4)
+#define	PORT_L1DS_MASK		(0xff << 8)
+#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
+#define	PORT_HLE		(1 << 16)
+#define PORT_TEST_MODE_SHIFT	28
+
+/* USB3 Protocol PORTLI  Port Link Information */
+#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
+#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
+
+/* USB2 Protocol PORTHLPMC */
+#define PORT_HIRDM(p)((p) & 3)
+#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
+#define PORT_BESLD(p)(((p) & 0xf) << 10)
+
+/* use 512 microseconds as USB2 LPM L1 default timeout. */
+#define XHCI_L1_TIMEOUT		512
+
+/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
+ * Safe to use with mixed HIRD and BESL systems (host and device) and is used
+ * by other operating systems.
+ *
+ * XHCI 1.0 errata 8/14/12 Table 13 notes:
+ * "Software should choose xHC BESL/BESLD field values that do not violate a
+ * device's resume latency requirements,
+ * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
+ * or not program values < '4' if BLC = '0' and a BESL device is attached.
+ */
+#define XHCI_DEFAULT_BESL	4
+
+/*
+ * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
+ * to complete link training. usually link trainig completes much faster
+ * so check status 10 times with 36ms sleep in places we need to wait for
+ * polling to complete.
+ */
+#define XHCI_PORT_POLLING_LFPS_TIME  36
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index a5c72a634e6a9..c6349e7e1e957 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -22,6 +22,9 @@
 #include	"xhci-ext-caps.h"
 #include "pci-quirks.h"
 
+#include "xhci-port.h"
+#include "xhci-caps.h"
+
 /* max buffer size for trace and debug messages */
 #define XHCI_MSG_MAX		500
 
@@ -62,90 +65,6 @@ struct xhci_cap_regs {
 	/* Reserved up to (CAPLENGTH - 0x1C) */
 };
 
-/* hc_capbase bitmasks */
-/* bits 7:0 - how long is the Capabilities register */
-#define HC_LENGTH(p)		XHCI_HC_LENGTH(p)
-/* bits 31:16	*/
-#define HC_VERSION(p)		(((p) >> 16) & 0xffff)
-
-/* HCSPARAMS1 - hcs_params1 - bitmasks */
-/* bits 0:7, Max Device Slots */
-#define HCS_MAX_SLOTS(p)	(((p) >> 0) & 0xff)
-#define HCS_SLOTS_MASK		0xff
-/* bits 8:18, Max Interrupters */
-#define HCS_MAX_INTRS(p)	(((p) >> 8) & 0x7ff)
-/* bits 24:31, Max Ports - max value is 0x7F = 127 ports */
-#define HCS_MAX_PORTS(p)	(((p) >> 24) & 0x7f)
-
-/* HCSPARAMS2 - hcs_params2 - bitmasks */
-/* bits 0:3, frames or uframes that SW needs to queue transactions
- * ahead of the HW to meet periodic deadlines */
-#define HCS_IST(p)		(((p) >> 0) & 0xf)
-/* bits 4:7, max number of Event Ring segments */
-#define HCS_ERST_MAX(p)		(((p) >> 4) & 0xf)
-/* bits 21:25 Hi 5 bits of Scratchpad buffers SW must allocate for the HW */
-/* bit 26 Scratchpad restore - for save/restore HW state - not used yet */
-/* bits 27:31 Lo 5 bits of Scratchpad buffers SW must allocate for the HW */
-#define HCS_MAX_SCRATCHPAD(p)   ((((p) >> 16) & 0x3e0) | (((p) >> 27) & 0x1f))
-
-/* HCSPARAMS3 - hcs_params3 - bitmasks */
-/* bits 0:7, Max U1 to U0 latency for the roothub ports */
-#define HCS_U1_LATENCY(p)	(((p) >> 0) & 0xff)
-/* bits 16:31, Max U2 to U0 latency for the roothub ports */
-#define HCS_U2_LATENCY(p)	(((p) >> 16) & 0xffff)
-
-/* HCCPARAMS - hcc_params - bitmasks */
-/* true: HC can use 64-bit address pointers */
-#define HCC_64BIT_ADDR(p)	((p) & (1 << 0))
-/* true: HC can do bandwidth negotiation */
-#define HCC_BANDWIDTH_NEG(p)	((p) & (1 << 1))
-/* true: HC uses 64-byte Device Context structures
- * FIXME 64-byte context structures aren't supported yet.
- */
-#define HCC_64BYTE_CONTEXT(p)	((p) & (1 << 2))
-/* true: HC has port power switches */
-#define HCC_PPC(p)		((p) & (1 << 3))
-/* true: HC has port indicators */
-#define HCS_INDICATOR(p)	((p) & (1 << 4))
-/* true: HC has Light HC Reset Capability */
-#define HCC_LIGHT_RESET(p)	((p) & (1 << 5))
-/* true: HC supports latency tolerance messaging */
-#define HCC_LTC(p)		((p) & (1 << 6))
-/* true: no secondary Stream ID Support */
-#define HCC_NSS(p)		((p) & (1 << 7))
-/* true: HC supports Stopped - Short Packet */
-#define HCC_SPC(p)		((p) & (1 << 9))
-/* true: HC has Contiguous Frame ID Capability */
-#define HCC_CFC(p)		((p) & (1 << 11))
-/* Max size for Primary Stream Arrays - 2^(n+1), where n is bits 12:15 */
-#define HCC_MAX_PSA(p)		(1 << ((((p) >> 12) & 0xf) + 1))
-/* Extended Capabilities pointer from PCI base - section 5.3.6 */
-#define HCC_EXT_CAPS(p)		XHCI_HCC_EXT_CAPS(p)
-
-#define CTX_SIZE(_hcc)		(HCC_64BYTE_CONTEXT(_hcc) ? 64 : 32)
-
-/* db_off bitmask - bits 0:1 reserved */
-#define	DBOFF_MASK	(~0x3)
-
-/* run_regs_off bitmask - bits 0:4 reserved */
-#define	RTSOFF_MASK	(~0x1f)
-
-/* HCCPARAMS2 - hcc_params2 - bitmasks */
-/* true: HC supports U3 entry Capability */
-#define	HCC2_U3C(p)		((p) & (1 << 0))
-/* true: HC supports Configure endpoint command Max exit latency too large */
-#define	HCC2_CMC(p)		((p) & (1 << 1))
-/* true: HC supports Force Save context Capability */
-#define	HCC2_FSC(p)		((p) & (1 << 2))
-/* true: HC supports Compliance Transition Capability */
-#define	HCC2_CTC(p)		((p) & (1 << 3))
-/* true: HC support Large ESIT payload Capability > 48k */
-#define	HCC2_LEC(p)		((p) & (1 << 4))
-/* true: HC support Configuration Information Capability */
-#define	HCC2_CIC(p)		((p) & (1 << 5))
-/* true: HC support Extended TBC Capability, Isoc burst count > 65535 */
-#define	HCC2_ETC(p)		((p) & (1 << 6))
-
 /* Number of registers per port */
 #define	NUM_PORT_REGS	4
 
@@ -291,181 +210,6 @@ struct xhci_op_regs {
 #define CONFIG_CIE		(1 << 9)
 /* bits 10:31 - reserved and should be preserved */
 
-/* PORTSC - Port Status and Control Register - port_status_base bitmasks */
-/* true: device connected */
-#define PORT_CONNECT	(1 << 0)
-/* true: port enabled */
-#define PORT_PE		(1 << 1)
-/* bit 2 reserved and zeroed */
-/* true: port has an over-current condition */
-#define PORT_OC		(1 << 3)
-/* true: port reset signaling asserted */
-#define PORT_RESET	(1 << 4)
-/* Port Link State - bits 5:8
- * A read gives the current link PM state of the port,
- * a write with Link State Write Strobe set sets the link state.
- */
-#define PORT_PLS_MASK	(0xf << 5)
-#define XDEV_U0		(0x0 << 5)
-#define XDEV_U1		(0x1 << 5)
-#define XDEV_U2		(0x2 << 5)
-#define XDEV_U3		(0x3 << 5)
-#define XDEV_DISABLED	(0x4 << 5)
-#define XDEV_RXDETECT	(0x5 << 5)
-#define XDEV_INACTIVE	(0x6 << 5)
-#define XDEV_POLLING	(0x7 << 5)
-#define XDEV_RECOVERY	(0x8 << 5)
-#define XDEV_HOT_RESET	(0x9 << 5)
-#define XDEV_COMP_MODE	(0xa << 5)
-#define XDEV_TEST_MODE	(0xb << 5)
-#define XDEV_RESUME	(0xf << 5)
-
-/* true: port has power (see HCC_PPC) */
-#define PORT_POWER	(1 << 9)
-/* bits 10:13 indicate device speed:
- * 0 - undefined speed - port hasn't be initialized by a reset yet
- * 1 - full speed
- * 2 - low speed
- * 3 - high speed
- * 4 - super speed
- * 5-15 reserved
- */
-#define DEV_SPEED_MASK		(0xf << 10)
-#define	XDEV_FS			(0x1 << 10)
-#define	XDEV_LS			(0x2 << 10)
-#define	XDEV_HS			(0x3 << 10)
-#define	XDEV_SS			(0x4 << 10)
-#define	XDEV_SSP		(0x5 << 10)
-#define DEV_UNDEFSPEED(p)	(((p) & DEV_SPEED_MASK) == (0x0<<10))
-#define DEV_FULLSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_FS)
-#define DEV_LOWSPEED(p)		(((p) & DEV_SPEED_MASK) == XDEV_LS)
-#define DEV_HIGHSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_HS)
-#define DEV_SUPERSPEED(p)	(((p) & DEV_SPEED_MASK) == XDEV_SS)
-#define DEV_SUPERSPEEDPLUS(p)	(((p) & DEV_SPEED_MASK) == XDEV_SSP)
-#define DEV_SUPERSPEED_ANY(p)	(((p) & DEV_SPEED_MASK) >= XDEV_SS)
-#define DEV_PORT_SPEED(p)	(((p) >> 10) & 0x0f)
-
-/* Bits 20:23 in the Slot Context are the speed for the device */
-#define	SLOT_SPEED_FS		(XDEV_FS << 10)
-#define	SLOT_SPEED_LS		(XDEV_LS << 10)
-#define	SLOT_SPEED_HS		(XDEV_HS << 10)
-#define	SLOT_SPEED_SS		(XDEV_SS << 10)
-#define	SLOT_SPEED_SSP		(XDEV_SSP << 10)
-/* Port Indicator Control */
-#define PORT_LED_OFF	(0 << 14)
-#define PORT_LED_AMBER	(1 << 14)
-#define PORT_LED_GREEN	(2 << 14)
-#define PORT_LED_MASK	(3 << 14)
-/* Port Link State Write Strobe - set this when changing link state */
-#define PORT_LINK_STROBE	(1 << 16)
-/* true: connect status change */
-#define PORT_CSC	(1 << 17)
-/* true: port enable change */
-#define PORT_PEC	(1 << 18)
-/* true: warm reset for a USB 3.0 device is done.  A "hot" reset puts the port
- * into an enabled state, and the device into the default state.  A "warm" reset
- * also resets the link, forcing the device through the link training sequence.
- * SW can also look at the Port Reset register to see when warm reset is done.
- */
-#define PORT_WRC	(1 << 19)
-/* true: over-current change */
-#define PORT_OCC	(1 << 20)
-/* true: reset change - 1 to 0 transition of PORT_RESET */
-#define PORT_RC		(1 << 21)
-/* port link status change - set on some port link state transitions:
- *  Transition				Reason
- *  ------------------------------------------------------------------------------
- *  - U3 to Resume			Wakeup signaling from a device
- *  - Resume to Recovery to U0		USB 3.0 device resume
- *  - Resume to U0			USB 2.0 device resume
- *  - U3 to Recovery to U0		Software resume of USB 3.0 device complete
- *  - U3 to U0				Software resume of USB 2.0 device complete
- *  - U2 to U0				L1 resume of USB 2.1 device complete
- *  - U0 to U0 (???)			L1 entry rejection by USB 2.1 device
- *  - U0 to disabled			L1 entry error with USB 2.1 device
- *  - Any state to inactive		Error on USB 3.0 port
- */
-#define PORT_PLC	(1 << 22)
-/* port configure error change - port failed to configure its link partner */
-#define PORT_CEC	(1 << 23)
-#define PORT_CHANGE_MASK	(PORT_CSC | PORT_PEC | PORT_WRC | PORT_OCC | \
-				 PORT_RC | PORT_PLC | PORT_CEC)
-
-
-/* Cold Attach Status - xHC can set this bit to report device attached during
- * Sx state. Warm port reset should be perfomed to clear this bit and move port
- * to connected state.
- */
-#define PORT_CAS	(1 << 24)
-/* wake on connect (enable) */
-#define PORT_WKCONN_E	(1 << 25)
-/* wake on disconnect (enable) */
-#define PORT_WKDISC_E	(1 << 26)
-/* wake on over-current (enable) */
-#define PORT_WKOC_E	(1 << 27)
-/* bits 28:29 reserved */
-/* true: device is non-removable - for USB 3.0 roothub emulation */
-#define PORT_DEV_REMOVE	(1 << 30)
-/* Initiate a warm port reset - complete when PORT_WRC is '1' */
-#define PORT_WR		(1 << 31)
-
-/* We mark duplicate entries with -1 */
-#define DUPLICATE_ENTRY ((u8)(-1))
-
-/* Port Power Management Status and Control - port_power_base bitmasks */
-/* Inactivity timer value for transitions into U1, in microseconds.
- * Timeout can be up to 127us.  0xFF means an infinite timeout.
- */
-#define PORT_U1_TIMEOUT(p)	((p) & 0xff)
-#define PORT_U1_TIMEOUT_MASK	0xff
-/* Inactivity timer value for transitions into U2 */
-#define PORT_U2_TIMEOUT(p)	(((p) & 0xff) << 8)
-#define PORT_U2_TIMEOUT_MASK	(0xff << 8)
-/* Bits 24:31 for port testing */
-
-/* USB2 Protocol PORTSPMSC */
-#define	PORT_L1S_MASK		7
-#define	PORT_L1S_SUCCESS	1
-#define	PORT_RWE		(1 << 3)
-#define	PORT_HIRD(p)		(((p) & 0xf) << 4)
-#define	PORT_HIRD_MASK		(0xf << 4)
-#define	PORT_L1DS_MASK		(0xff << 8)
-#define	PORT_L1DS(p)		(((p) & 0xff) << 8)
-#define	PORT_HLE		(1 << 16)
-#define PORT_TEST_MODE_SHIFT	28
-
-/* USB3 Protocol PORTLI  Port Link Information */
-#define PORT_RX_LANES(p)	(((p) >> 16) & 0xf)
-#define PORT_TX_LANES(p)	(((p) >> 20) & 0xf)
-
-/* USB2 Protocol PORTHLPMC */
-#define PORT_HIRDM(p)((p) & 3)
-#define PORT_L1_TIMEOUT(p)(((p) & 0xff) << 2)
-#define PORT_BESLD(p)(((p) & 0xf) << 10)
-
-/* use 512 microseconds as USB2 LPM L1 default timeout. */
-#define XHCI_L1_TIMEOUT		512
-
-/* Set default HIRD/BESL value to 4 (350/400us) for USB2 L1 LPM resume latency.
- * Safe to use with mixed HIRD and BESL systems (host and device) and is used
- * by other operating systems.
- *
- * XHCI 1.0 errata 8/14/12 Table 13 notes:
- * "Software should choose xHC BESL/BESLD field values that do not violate a
- * device's resume latency requirements,
- * e.g. not program values > '4' if BLC = '1' and a HIRD device is attached,
- * or not program values < '4' if BLC = '0' and a BESL device is attached.
- */
-#define XHCI_DEFAULT_BESL	4
-
-/*
- * USB3 specification define a 360ms tPollingLFPSTiemout for USB3 ports
- * to complete link training. usually link trainig completes much faster
- * so check status 10 times with 36ms sleep in places we need to wait for
- * polling to complete.
- */
-#define XHCI_PORT_POLLING_LFPS_TIME  36
-
 /**
  * struct xhci_intr_reg - Interrupt Register Set
  * @irq_pending:	IMAN - Interrupt Management Register.  Used to enable
-- 
2.34.1


