Return-Path: <linux-kernel+bounces-137861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA26889E869
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD14EB23562
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD835BA39;
	Wed, 10 Apr 2024 03:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKOxwWvj"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2090.outbound.protection.outlook.com [40.107.8.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE34C94;
	Wed, 10 Apr 2024 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719507; cv=fail; b=uJizemVNRQVv67eSX/1FdGBqcg8jM07hdKw997GSOxyfzaHQPg7NlS/QB6WF1GEHJRCS4eUQjc5LHzjFHpPvu3o6vIiqYjUi2OEj/zApg/UzsvmdX/MeqeOxT7QMpVUaKHcrZ+Awjebch0NJZWSlioZkoQ/XSzl75x4cB2eYyvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719507; c=relaxed/simple;
	bh=oWmIZERJzu+7jV8XHxIy1v2CzqA2LRG+t0busAJrch0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lum1yAHLjhMGzoou9G+5VeHFbWWFKqMuwlUBxhv+XchpCRtUQdM7luPEqP4akwr2n/nZHzdnRYE5xFBKfX5id/Bvm3/BItegjSQTWx2Zjwvmli6QIdVuIYpiiyU03wLP4ZZuuWkGVn7LR4QXWc6sJEJkX1q7CurE05VEzX5eUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKOxwWvj; arc=fail smtp.client-ip=40.107.8.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8Bfji4RlVgALxiffaFoEtAibWCQNfte+eos3qAJv4n5rj9xtEOERYLWfrslkULOfFWTG3Mpl5aRmQNXxeYAJnqj58EiIuZM4LjidPBL5Trvkh8uzaha3WY92PfI/Y0GVBODJES7fUrnQ+mx7gUmVhP+7Qi98ZM6hqjcCok/1J2vduJI6Xf7mfjkCislDdfF08wQukP7l/XmkHb6sgxVGloh8QvrT1Ygg+UyxpP//9An85jQ8Ti37CRrb0xrqG//ohgAXz0w70CEh5VhtoJe4cSVxZEzp10fI6GDs3oY2G3jaN4mq9Jkhze4Ebo/Y5Ck7nYe2yGXyGmLMHZ6gkyeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=ARhXWOg3CmApLeFC86o7GqbAH6qu+192ddGc0NPuqB1yqs9sfuxpA2Mx3+ogsGtifUno8neFaIHdWamxsWzY+bnSlJ/EDInrF/+VtwMdOuPy8iz8FsPvjpIFQzmPEboS51O5KWuUcIzDiko+JjMR9sAmscV/dhAOe+bsN/ls/XCDvBtueCSGiQlG1jp5Qu4pQGoKK0MNHUGuqlwV5METJUyE6KDbqMR9WEuzXh7TmfqHxSXLun59fwBTSkzSVWoy7EUTBf9N/5ZaBkKMJWGHxkjXhxieLB7Ho/y6OA/ODzkSKxzq/XWK4f9zKJQlwoJs2uMaXZE/1hvIijp9/6Mh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ghx55F2OHxFSJQhOzvypfCz61hkQNVngQuoC5On2A=;
 b=IKOxwWvj0GROmHaOE+2/fzUOLf3zoiw5rdySyPnyKkwoeyjHVs3K8igqZ05nWklIRdxZTcIFsRbZ5G2JN5H193nFOqVYYRySQ7uggaZty/tLd42lj9boHLKfnvjOXy1VgFJ7O5HL1vf396+5mMuOa2Ir3VTrX/u3pGO+uqqj65E=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8684.eurprd04.prod.outlook.com (2603:10a6:20b:43f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 03:25:01 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 03:25:01 +0000
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
Subject: [PATCH v2 0/1] Add rtc PCF2131 support
Date: Wed, 10 Apr 2024 11:32:55 +0800
Message-Id: <20240410033256.1341662-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	loMToj2kbHXYOFWuozTZGrtc4Nx2HxHo19FisTHhF1z/q8uWZypwjTDBzvNzxEOa3GxFekQffbK3qlqsn8zWE0A00ZkCfmAf4yFM7UjDi8qyPj/zzcD1adbSGsQV+F18rUwoZ/7+aCKWzi/MAV1j13NBDGkGj6ZtlPMiyrsNQ1Y7A2Yy0uiRuv5EEvzA2tB8KXo5m3fr/9ZtVvxeJQlYyqEWxrhBGOswymtxYtuij/9ZAklSD4aFRpELSlBlz7TM5X+C7j5hFrDvCjKw7qlKx7GNB+3Z7uoXVBrs7MTnG5wbHUQTlOArRSQb/J2hzXnu77J0M5JcLNxyo3mO2DMHKbNCPcXtJkXkPEvT2FhlHpkR8tVkdrnPs5YdaQVBWTzY36KdNwBzxGBUWXoHgS9pI3hk8xydIHqIqpSemM34BzTwcUcoz5gyIZWkakqI3q1JkPZzmBNIUUHcqQ/Wwu3DtxYhHUQxaoYV/XF8oBFDMRoenob8/a3rT76VASHOcC7SVKBa/8zhrsiGeS4Fo1vVP/1hOjOReIQVMJPLy5zjNP7UxYyvJZGDFQ117tLyIixi/YbyVgChKrAadT1Z6fYTeZnuO82A2ZK63adBBcl2UdsanXA0NaaF1+fJtyo5LCwkvw4CNI5P5i1pnfhaZL27D+HdmFX+y8DQ6rvMl0WHVb3ZnEMJxmKPG1asjzKRFNrAyS4O/3xfQKiowxIXN2zlJ/e+SN+lXn5fGahhWVp6wxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y4tXduH+aOoCuIfOifpFnD0PAWNeImf2ToxTDlsI6fFbgLx5eNsbEFWhglu5?=
 =?us-ascii?Q?/qcwM5pCBjsoVrHnOvht9d45wN7wbZxKOtJC127vtvMYv8Wgi987FSNDAG+Y?=
 =?us-ascii?Q?F7ou4gav4dH9GhqZazjJHcNN2530NGT0o2HhZyxzvaRa5KrBK38Dd/VatXjP?=
 =?us-ascii?Q?uLJYWEYSJof/qfc0pgqWLFAfd8ClP5slHXJ4IJSmo57fvrV80r6uF5DcMZ1h?=
 =?us-ascii?Q?yzwutF4BefRszAAeU8jhHF+iM/BjHIAmF/+Cz7W7ARhFihmsEcnFvoIX8Gsv?=
 =?us-ascii?Q?Uj6RvYWTk2O4QWY9Xxeg3Ujjh4RybDHVIRzzXoFZwAug+HauhKt0RJVwzc8u?=
 =?us-ascii?Q?ecEPd1DyGBl50UcRhoscgMwp8el5ou1VIDZCRnpoOvq4qwUqwRZPBgOYFIJR?=
 =?us-ascii?Q?TfQLbE2Tgmal/1TKNf7Jo1vYUdO5mZrTCKtAi2OzHY3BJkwcA/croKFCRE4O?=
 =?us-ascii?Q?sfkYWt28gH45DOgQb6RrPmYJSPvBN9BLikCjhpRbKHg4E1aPRTfefxa3pAFo?=
 =?us-ascii?Q?eI0MD7HaX96UhRx8MCOjed3hIGO/UX375KhPJ2AFDfKiG88eCTyExXc6yihc?=
 =?us-ascii?Q?+8u2I+oaA4ekBuq8FC62z9m9pLIRWgKoc2ru1CoklBLBGF95QDGmEO5lFiTP?=
 =?us-ascii?Q?b3VQOy9AR00osHm/sAwaHX1gAu2GdOkg1J6gQjtwSyln3iewLl+JRjqHMWsT?=
 =?us-ascii?Q?e963elbUe+fW5D5xeMACiGkyksXiV9QRcDOpW8qUMGGUdvkX+/sdzk31Ho9Z?=
 =?us-ascii?Q?uIzvPJDpwXAkS5yBDcmLnAgD9cLp+vRYzpgAtYA4Fz+rYq9AF+tvShIDwNEu?=
 =?us-ascii?Q?+VQjEsvOAzTJ8CuHGabpbSkDhjMynoljNjW+Wh7jFi9Qx1eGHCnw7OqiHMaw?=
 =?us-ascii?Q?P0OI3qu0l0WwTls8X1jLItZcMOWNnGqk2ktrE1mHMq/8fdYDCHi3G6ydKl8q?=
 =?us-ascii?Q?7yv83mVuGkPyNnmF7R5dwDHrKKT61RVWwrgkkZp9MKhsOfOBBYTNLsFGJtB2?=
 =?us-ascii?Q?Hw3oocirzZ+ZCkydBhD7X2hvVqfpzko1cbK+ag9fcptc5HLhuQuBeaq8aojg?=
 =?us-ascii?Q?ilyVAjiH8y8qvqaKtqz2gCw6DpkSdX9eh/VD+14SHeRi7Mv75NcV3jGE5iDN?=
 =?us-ascii?Q?nkUF89aibqDP1hirpJcLjCRwnJOSNVjhkidM6BAMsFd3keKOERmCDAM+QMSA?=
 =?us-ascii?Q?ENiUG6BXBOi+XppH2LQo09CNJVhoI/gh51D9sro5C+uvZ+3VZB2lfk5MPRVH?=
 =?us-ascii?Q?223dWGsBcb9mFSjaYGGubd66MQvJB8BVf5jjW62QpYFQ1DSPKjuiVpmVDiCn?=
 =?us-ascii?Q?3TUl7wYZaCYorF6r4Rv7jXnF4pcXuHq2hBDODC7girHkkHln/6FvUMP9oQce?=
 =?us-ascii?Q?+qeoZXNe6cI4V5fbYzGRy2FT9tsL7q5r42N+L/qIpGSbfUJc8LYBJCLmCRgp?=
 =?us-ascii?Q?+PFtY3tZ/yBzd0wMB7HlmlXZB8D98oXYJ/n7LcgOdctMz7XyYnD+uykrdXUx?=
 =?us-ascii?Q?DVMCQD0aa9Cqfjs8sERl+iypxh7Lq1N59Dz+HxDdJEFPUOnv6Out4341ii1j?=
 =?us-ascii?Q?Y1FVqguPjdI4a22o604vTW0CpTCMMq/lVBK2K6qe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6f9586-8083-48fb-33d4-08dc590dce65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:25:01.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsrVKTn2Neb1Dy4UNFTKRhNPTc7pKjySK9QHgo5uEW2rh+OKl5KoXvpnWmv+nCo4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8684

The patchset supports RTC PCF2131 on board dts.
For the details, please check the patch commit log.

Joy Zou (1):
  arm64: dts: imx93-11x11-evk: add rtc PCF2131 support

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

-- 
2.37.1


