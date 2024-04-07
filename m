Return-Path: <linux-kernel+bounces-134173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4E89AEA1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97E31C220A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D5E5CA1;
	Sun,  7 Apr 2024 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="reQvJJFV"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2090.outbound.protection.outlook.com [40.107.105.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2117C9;
	Sun,  7 Apr 2024 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712466702; cv=fail; b=XQq/7kJxuOuqkPnROT4eYDqYx5EcE0Zs5nJDeIpmOPaz0C2jagKjp03NMLCHyfzcl8tUwu2GkgkaPYqeSUf+CFo1Poz1GP0SAICWHB1lJffBHBB6yxw/NUMt/rYNokb2VG59KQ2bbxHstMhOsRx4R6ybClXvUyWRe18tu+C0btc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712466702; c=relaxed/simple;
	bh=H0GCSDdN3/+WlZ5+r1lnrPvA+KcpAokeNFGQ6Vk1N/M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h+/DOQuz3rDQkXGmrrZQ1iJIERWrsjo7Rsy01bKcz+hFiEmAnqPjwNqAyczfT/BhjD8gzD4uIDJHxKBbqI765TvoLuNNB/5omlYg+vwO9eGMKScd+ymDmi/l6e4PW1zt0eqPbFZgZW6z92IUfyqB7paDmtU8nA5ZQros5jnGVHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=reQvJJFV; arc=fail smtp.client-ip=40.107.105.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYqXcQxdEjqVbVKpfrOCmP/ZPwm90CaYWzNo1CgMbUeBDIrSqtliZmK4q65RN6nrL9OPV7WuOTAHdEl9SrrEFiD7Gst2XOMF3QGUtkXIfGk0ZYuQNax7fnXx2LbiFKk8QwQqoRdxd8D4j/QKJ32u1fTlN+wsXBLOiKGAzKQ/SHTHMOgTo+TcltwGbydJpMyO9jwzUQ3ZtyupSoolaZOfaevE3Vaav4fucNr9Nsm7qhLD85XR7e8OIELOmC5g1JSCH9B9P/MSoid5cOniX7RE4zjbkOQ0Orj71STMh9WQ0NME0s823PRFGrl90p1XDxXje4Tg2vnZ+Dl7j3eZWoaOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQNvXzFVNvfFRf/ueFJjwxrmKrGS6aO5gyA17M+3m8w=;
 b=n1pndl+f0xOnSiwYl4VkM2UdW4Z6XTTp+lqyT6Tmc9RHn+mDYuP1p/k6X34kn/YRcmfKA1G1zkepQXkJN8vo0EHm2ppmFIDvFZLJIkvbqVKQcT6hK8I5DKyHdtQbdud6Yd3tLiT32miocJEEol9aWI60iRFerk3WMTMEZVhCgHD74pcWFM3rbvif4SQEaWF8quY9aKlskTtcM/DheQe7J9562GCdsVtPZ/T3ZBD9qKhM2eq/nIkRnw1a5jFHW9AGdETcJUsjh4dSdP4JBMqZ1HqxBSqfVJiCdfQGTRwj1lZ65iAdBAWVl8qqLHcI5/R4nO77nYTwKDz5hoGWaGONrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQNvXzFVNvfFRf/ueFJjwxrmKrGS6aO5gyA17M+3m8w=;
 b=reQvJJFV0Y1wRjm94nZcNjd2SvkbFGoGUA8zYbPqRoXv/kpGaTcyAtYpUWYJYY+8/JKuoACrPpXKt3TvtMMuo5HXPnSZKJtjCb7X8QWNB0JNtKPcO9/ZuNs4YBG9s7RCk3UfWGu45UCbXUZEdMBY9foGi9pELyMPZYPY9/wZnvQ=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 05:11:36 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 05:11:36 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] Add rtc PCF2131 support
Date: Sun,  7 Apr 2024 13:19:12 +0800
Message-Id: <20240407051913.1989364-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VI1PR04MB7008:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eX0ksH3QYvcxJyS9KdCGEjLi7jpuALxfl23jZKteYOxdgnn8eLBk6uoX1JSlz7tDaCczQW/xM9Ro8LN6xSaNIbqSnOXrbHq2X7KGz360NrTbpxs7gUkTVAJZMeCq/Q8X4uOlLvClR9XPXGk6urQYLVECSiIR9PHy1D05vqkARISxKMLJ6LOoeevh2wpjtrXfmySD6BiWIXlyrgEAnn9XJOD+sO5i04sAvcPEaFdUKJbsSYZsnI3ie6Z6w0dJ4ww81Km+/6ZI57Wn0I6hJJU3gaUw5L+o5X/3JukRt3YzdL4MvwvLqp5hlQ2ATgGglwsnwlQsM6oHSiniAu9Nu2HvMRLQ0vnvNMYBONmQCmV96ve70kH/GIfxV+ecut1+Cy2HPlhIM+LrK+UG9lpcMZ/qa+YZ4euhNhmor8hyJ4irr43KYqjuw1Sp+p5ImzBipuft8kA6JTaBTw31TMn9NIWfXZEOco2gmn7wrU4n0i1sY3HVPwtr43fmTegEPHaqY8jZ7ahNKXwSV3SwK4sQCVRqo4JupzNytcST9s06L/+0/LzVIYay3oPi+PvAg1Pi18F18XAHzNBr7SPHxkA4Q3LQeKD3QZJLCJl8MhTtXCSvbyiUdhmVcaAXWiU7LvP8KDYBjeTIFpSPX8+xM6k68ao5Mk17d8eflNdgKeLEejFS25XC6yneS0yZvNDS2/ue++2ovb7azpv/qm1ZEl0NkrnWFphWRTevPrKnA/IGBTXOEXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMVPZxgj2Aj7a9VskDq7c3CWJ/tzeHu9XROHoMRHfAF8D1ZQ2mlyIaZE2xTi?=
 =?us-ascii?Q?huGv0zXBYH0VPnOZ+gQT1Xu8egUgUAO0tVHoamUyybozn0r46+5kPKaMAvLT?=
 =?us-ascii?Q?T4TJi+6t3Yu59hmi5wEQtxIFs4hcjx8z9oPrDlLMIxYOU7SibtR/FI6yya0E?=
 =?us-ascii?Q?2PRI4B9UYUHJhKloCclIwtnUn5pymVqQ13iO62Znul0eIndIM84jAWCdY3o2?=
 =?us-ascii?Q?4hw6aC7jJCUxefYAQebCYhZqRWreAMVJ7p2f0lxC4YpWEmTSkmk5RbbrDjI9?=
 =?us-ascii?Q?ASxCsU1xI1iOI3bTkytIYuBS3oBgZwk9BdwxlDkyHvEW1CmNpZyFLElivOUX?=
 =?us-ascii?Q?ZJZlvCyj7h7lXRlmtOO03X+UM4EZdFRHSJ8g+i0YpVb4CGi/mbcmutrMeeJf?=
 =?us-ascii?Q?NomMM0mHqycnombaGDUyrCrQroviyS2otO0AdH4T1HmxpTQ0V0ZXGnq3Ci4n?=
 =?us-ascii?Q?pfrG3CLgVyaDfiBIs2czJH6WWCEv5KhEBY3CaOrhRfTGaTE/NwZn0szUnAM6?=
 =?us-ascii?Q?bsebZav9UEn82O5RRUXdMwA3kmp/JgH7L4Wkz4H5LtngzZSJL2Y5d+aRmvEW?=
 =?us-ascii?Q?f28RYUzc2rGoRTTQav64UAsoH/FQ9JZ1PRGuFnAEOibzBJS1AKyYGAsaTBGv?=
 =?us-ascii?Q?OWcy2giN6zxGJdFZBmDSuIiBQDDNBptw1tMWpHuO/nsvr9q/6OPtT6raDgwz?=
 =?us-ascii?Q?o/IiUNX/m6EnmiDkTS4knKkBnagszbMRBhzzdV3h96/7fun4IE+1uhC/Q1zp?=
 =?us-ascii?Q?rkiCX8CBbWVGIsnsBR61D9trVyrFwH0Qk1Bb+NV1GSbWvcxdx2VlIDmrZqKo?=
 =?us-ascii?Q?np4oH+IPRbCf8aP6xyvOTlXGMFBkXVi7SmR5ktcuyBlb4YDFbrFMSEGgi+p1?=
 =?us-ascii?Q?6vWX7dh98dnTEbUrqnVkf5eDKrlG91jpM7km9qXP042fhGTn1qyZGjiwpSNj?=
 =?us-ascii?Q?eoxA4VuptrOKvCHPW8u38laVcuMPkcxPjumPTKqP75uzR/SJTD3k/lue2yeL?=
 =?us-ascii?Q?15ocQz4O3F3YyQLUyO9I0qaRmlAEGh3di9UIFvNvi32Vi/uqXzenUec2EWBh?=
 =?us-ascii?Q?thxQmB/ckeVco81mM/dGPKutyoznT8dOm9SYhzqYNfddRu2xsE/8dGQ3nVyn?=
 =?us-ascii?Q?Vr+crigxo3oKlLnXpQKOsKTQ6O+RYu54FZlYp8We3aruUyqAWgJmJqJowY/F?=
 =?us-ascii?Q?8jM6UG2bRRnQE3tl76O9dh/xVB9DV+z2Hc6BAVK/BFCzoVyG7G6gjnrWcrkE?=
 =?us-ascii?Q?EH3x5/ze3/oknUvO5sOZIY18AtQzUogbILKv1bh34eKvWHPm/6MtVW2FXAto?=
 =?us-ascii?Q?/3KYwsF9HrID0pWOV4L72oVc0evcemt59z/CyN7gYdajk6uq9GEpZNfCjTWr?=
 =?us-ascii?Q?ZTJy66B9MClwbBcn0/SF2csXEouRM8YLbHaO3EVmF0y9o+WznNG78v4KUAoO?=
 =?us-ascii?Q?f0utsc52LAhjEFi0VfQgvl1bIUUo5fP0NtTScSPDl/AqNPx9M4nn7/ZMZl6M?=
 =?us-ascii?Q?4YfnNi+tmY5bbZF4ud6IMgbh5460kH4jLyqVl6Yk7RL1daoKh8QdZlBdUrtT?=
 =?us-ascii?Q?Zj1tEPCsYh4u1qr0kbE/AlZtXkjOy1eRC2JQ9uXW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279dd45c-8232-4a75-a935-08dc56c132d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 05:11:36.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3rbPau/Gi6NYmacBfKPAW6qKvdGkzoOwT4yoewpwjFfHxNGhT2QTJQAAGZwA8mp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008

The patchset supports RTC PCF2131 on board dts.
For the details, please check the patch commit log.

Joy Zou (1):
  arm64: dts: imx93-11x11-evk: add rtc PCF2131 support

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.37.1


