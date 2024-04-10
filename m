Return-Path: <linux-kernel+bounces-138032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D44489EB4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EEB28332B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E24913AA4E;
	Wed, 10 Apr 2024 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r8S446fT"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2129.outbound.protection.outlook.com [40.107.241.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FFE273FE;
	Wed, 10 Apr 2024 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732019; cv=fail; b=N2Ln9CsfYRzckH+kaKLUKt+R1WavlwM3lSvOWLHkZ6jnRrlSEuZTaz2PSI/+5IHQzPjQzWmDcZzJap45DhIP37D+XIfhc+XrXGE6hzWpK/0UJRLjCIFiUSj4r5z+ur8D2shifSsJ8G+7MDL6pWbYZ/nW7GhKNzW7uhv1X9o5B2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732019; c=relaxed/simple;
	bh=oWmIZERJzu+7jV8XHxIy1v2CzqA2LRG+t0busAJrch0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CgDC/LojL8bKgLDVsFpW7AbVhhrnWQR+JJBt8rXVCWNnvXWTrSLNgWzdTbmw5OI0qjHXLgAQ46tNiVTwR4Hf7sTgC6ep2ZRlKpGS7MbSgpOaYMnS0y5WE11sNIhZpSL0iLEL09/PYOm8ovEzV+ziP0rOj4ixCcm1Dsg32rPdNgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r8S446fT; arc=fail smtp.client-ip=40.107.241.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZItkwqN92UQDpKIT5pXSc9i0LFA2D+oDrFw2LURKUg+SFIsOhvOApoRuigfADOIv80isBOsLd/D4GLMIICFWgPbE+kP5pwd/olA2Hxv1zdez8J5Ez8mMyrPUMQ3oBCtCjUZt9mqEb4D00/rcRFSLp8xGJNozF+Jh0DlbJQ1++y1YKubTF0BKjFF/ikPoaHWBIETog7ngRZON1mCIqznqbC0LrDsCwenv2sL/2qDzjqdK3ch35KdBAqr+EbJM9BZ3BD+Pl3n9krpK7hvrM4edMX8EGgqFM2yKdgyagk7ewe2nsCQamu72TUdD9eLA32wQjICwu0qsgqJK/vgUPoNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=F8GZOwBBvvJ1MDYb5alcUi6a8SY7Od4qq5+ZmUEEIbsEqy2WQlPOZcT/A4lSpjCpt65qBIQzkpy/Zf/LqUsIHIjxOIJ8PA92UDkBRNJCKrY/MCLsWR342LQGh5ePPv+qCPgOm7DwpMemjzcCll8qoFKatvKNR2lOdzgvLiie+bz4PvQwK9UCpt7sI1jn8MmTIEyl/1Aoq5LsPE6Dfp8EcwBP7Tdxz/ICF1oc6cxbFC0ik0J2gRuTckAjEeXDVjMOffgO4Cx3hzairBhGncT+u/kdJV4Go0OXGsWnuZ1/8QMWcM+HEQfR8M8SAsmK3rjbppLZE/HtFFcnHkj4PjWvpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=r8S446fTHCXBS2XqVSH2kkS3sT9blBqSoPEhzvsn5oAbLCYbulWZAmnpJslghxD1jTCXFCuz+Lzseu4MWA+Y+J47EtL2hV+4XdOqe0uqWrnIt7vNcMU/desQ73g7Ve1m+xMRWh854K9X7bs+6iY0zeeX+KVMcR9lMLGXO3unPJ4=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 06:53:33 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:53:33 +0000
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
Subject: [PATCH v3 0/1] Add rtc PCF2131 support
Date: Wed, 10 Apr 2024 15:01:27 +0800
Message-Id: <20240410070128.1506555-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB8010:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0lM0PaStBeLTgUyRoFDYbwq7peiCHrncLFigH3puZ3YctO5BlxNp4mSqqZq6uDK6xtr9gapinS7J9dum/HUNsxgx0r23kP4Ep4tFTfUqg6CG+DKXVmH4/vQ+jBFOYKL2gEU3eRQ6Ot3YFvBxV86lLCHFeowVmlMVN4e38Mib7nMEqLr8VM6xe3ROyi6S40zT++WzVxwaWX2FLaEFJWBYGsidaog+4DKmKiP+YsPkB71KCxHnbicOhaorPoxoO/xnuo2sCJWNK6ZQo72LVVZsLo9q/jX79l/7nbQW15tv5/1ulrNu0XGWB3UpCaLSdL5LEcyw1cGXpSouVfIUovI+nj/6wZKAfqtX//+EM7eGu8/eXhBL8AWqcCO5ndDPT94mvF2JbWTGam2IOtP12F5mBB0+BJLw7S2+xIofE7NMm4M2kX2kZZ9j8ZS5qjf7fYfCZEYNJtY0j6gsPevaFiUzYHYqQRsIaxkP8aXSkAzcNvg6osf8mplREEaLz6kKTIDqjXwAXjc0vAt9oNw0ShrZ0syMPAlukCDddDcsjiZ4sxddxRjpQUiSpCsxxaAjT9QnZCZCGZlh/OrKiQBcgETaxMR9SePSgC0any9PKdhlVtSwgCMndH4isYvpKP20N5jPG/+p7twkTfcsVTNyEv0DBjb2xEb1Qm1acz6afZLh7lItMwsRXPZGnkaMnEA3XQJ/ECUaYYIVXfk3ASKn/JFdupclYIQVIAw1ZIqKn+zRp+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9bHknEq1Jw+Z7UCR/VfBnN0oG90EY38PA4vReG4CrCqU8ZCQFnC0UUqLPaJH?=
 =?us-ascii?Q?qtLu8OEv6mgA9mfpukwSngLhw5fA2XzKINYM4NuM6tAsNAwvTwaJeZfFnrM9?=
 =?us-ascii?Q?WYiXqCZNGHIKrThyPLJ8hicZLBHzPBr7C2PLJCoJsqOR3ujshmRxZWEd+cGB?=
 =?us-ascii?Q?JWKWWCwEo0JJHEr4VTrEpJ9eUb0fLH6dNaaANdf/vmuM+FYNj3welDlzGRWu?=
 =?us-ascii?Q?E6m8kbo1vh+82C7EcQm4uRKzs4v4mOLh3ZkhkELN2K6urM9jhLfv9GhqizJe?=
 =?us-ascii?Q?IpmdmNLNmLAaNFCdW8r4W6EW8+y+HF3xwVUcpwIudKuaLcEqceZlPPVoWRwo?=
 =?us-ascii?Q?V6gF3cFlr2fwIdJ+81FPKrWKAy2Xw56eFVHNHdJhVnBGDF7rryyaTAA7qpym?=
 =?us-ascii?Q?eJls5h2f9VGYXf8/NySKAx2k/AENlarLKuNN5zWSQZSL//ajPq/LvMxpxEsZ?=
 =?us-ascii?Q?t8w5Lxs55zjAQVRy/v9h/OgLwbtcv9jsRu+E2I0zZl413NoYkQi2FD/3ap3+?=
 =?us-ascii?Q?VGOL2JpMvjX7GWzUt+SKmm9qyzAqS+A6scAouom0PC5OdhQF2tc5b0L79577?=
 =?us-ascii?Q?v8LeNdMR4WvjOlrksJ4qXDvjWidwZEVJ/kEn8qqHSy5hKqz8m+FZpvPrOr+5?=
 =?us-ascii?Q?K1nnEhMqRP6Cj2gUOotCXZurJB1nQxsp1hrTsm3Zdv/KzJD+u7xBdhTcl1Lw?=
 =?us-ascii?Q?tYMT//oDTcR11ECXRSDCEQbzqWJfZLMEsbAppCL0xVA8m16OBzqdMwucp8VH?=
 =?us-ascii?Q?srXg9hGY8oJ1Z/2uBSRVnkfswSNJHqDpjd5A/TwOTUXJevJUJD0UrqmUGgoh?=
 =?us-ascii?Q?gyrwIZpddsP1QrMOd2SFLpZhJPEUJRD2UvTsYI7i2WfBciuyfdYoEWGj+TYi?=
 =?us-ascii?Q?WvBGq4/cCMKVUKf9/yV17eQGd+2MUUqJVEI3KWN5l+7igB18VEa0aD+tCooU?=
 =?us-ascii?Q?1IERESRSM2TtApKRngo805uRJnivXBBgfvHgFpb3Yz5G8dQNI4heX3JgHxcy?=
 =?us-ascii?Q?krG3ls05Iftz/k5bg32c6RUY5Ryml3P65q2dylSAFO4A3bNPpkbCPImXfILG?=
 =?us-ascii?Q?2eVm0sExIEiqHwW01PNHWsNenGALo0hePX6Qz5alN/YXvcux8n+tN3ecvh0V?=
 =?us-ascii?Q?Hi+K0/NnsamY5aXQZBxhXvlFaZ7HM+6mNRe8fw2YQ3KSVqEOU+nF9ELA6yE4?=
 =?us-ascii?Q?TOEtEjk/W+/5437OUp+ESC/DZA295GRmXIYmRvC9pP9MVzGeT3W8jrcHuaJd?=
 =?us-ascii?Q?nZBpOOaJ46HjfakE520fO8YpnLUOt/G2+H2/ZSghQga7ANCtfnOcFAdw/Wrm?=
 =?us-ascii?Q?hMzxhCK6coFj8pqGdX2T2e4yojNI7j4DLAEEgMXfl/Xo9lpJsuE7KPK1XQZo?=
 =?us-ascii?Q?1qvQPQXvr6pliefuYIv3T+gzAS4iRmX+B3+BsK8QoV8U7hMM7f/kupug4LSu?=
 =?us-ascii?Q?J3f/4PN/2ghySOI1GN1218GvBg0lcaSpkaCUEsvIXF+0Y7gQidhJQomXZ3tJ?=
 =?us-ascii?Q?olix1goGdYsH4TTYtG8NdgCbket78R+TN82LYI1Wjj87E0X4wht9rFthBNIn?=
 =?us-ascii?Q?mD4o8XN1bW6FY57JsFaJRb0ylclW8mZsqgZFatTJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e63ddef-33af-461a-3bdd-08dc592af03b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:53:33.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGcrAwxUAaXjvdWzUox1AZW/qcv3GFpw0xEpwn2fCiq6qMzFuiSRRzzmeC8p2f4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010

The patchset supports RTC PCF2131 on board dts.
For the details, please check the patch commit log.

Joy Zou (1):
  arm64: dts: imx93-11x11-evk: add rtc PCF2131 support

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.37.1


