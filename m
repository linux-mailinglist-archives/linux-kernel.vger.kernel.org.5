Return-Path: <linux-kernel+bounces-157905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7975D8B186E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A7B1F2182B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA86F9F0;
	Thu, 25 Apr 2024 01:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="am8HRrpH"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A595240;
	Thu, 25 Apr 2024 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714008457; cv=fail; b=d/pF0CUzcUKw6DSLKO9F0RR4y1mXSwPtCtunW3+4qGXVD/7/Bj5l35AWf1z8lbVvrDmtAdhfTEGNjaVTCm+/wADE5/WABHHqLu+QV9Vub3GvDRdoa5EaUmtuQ+rfOxZbriqBz7HDfQsGuozOASfHqghR2Jx3Z2iNRi/gI8ZxksQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714008457; c=relaxed/simple;
	bh=8wwtbrTjKXJHZi8SvQyy3JlY5gooeIEbp23htY1/ILk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pzgKPLii9xKxg6ysSEypr37Leer5Y6vPot5bCRfcG/7/AdQGq+PIDk7dawlGMzBSIF1sIJ65ehCUPx5ugX2mxhUKF3S4qe8TNHVMhmthIY7vY4nWJD+G7ogYs6RmYWPR0FkcTC5IrnZIelOTh8QuGANH5fz318/FUuCCHJoSJ6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=am8HRrpH; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6ZGIQwFOEuv1W9v17ixQ1+Xv/86Ca5Wf7P9xe2Jh0XYwmB0XMQ7wR2gJTqr/DddqjHb8I16gyUNQ47AsbsCvpxLOQ+80s1TIuIXrl4hyfrt4pvvBAQkD/IulEaVStPvtjY0dnbW/cDSVZ+lVPBkQ4ImU5qdIuf+FJw9i24AmqO5+HZ3euCuCFM3y+AdoQ8JLsKXf4BP8+V6K1kbuOkIGBJ8Y0DlAiQDPmqH9T5OKcLK07B4sGkaO9M9N3CVvsk08Q066F9lm0ED+AQBW1tFPpDJOWDtPJHtY/JfceiHjH9feuY9esnte/duSKJ0gi47oxv/cB3j57QvUZvyME4x3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2vjy6cbrSjiWVW8OxsSeoimpnYFhGcAtRPiT6YKZ3o=;
 b=ZJUFMakOLtoPuci2faYq4kirTUqaTnlJGElkNuLMwmRPrb8gcZgGnQdIW5o0PoCMO7lGgatgJb9Jj5UIy86fbdyDsrnIZS0Ws8Z4RrstWdwo3fICBw0/v8w8P2wAknbLNKZR50dskQbV5sW3IC9FCXYBQIxZloYbOtGqbdzVgKvPB+nfuT9mBON2KcmZf+ddoi02Ujd7ueu/LMoimyeBQBhbzNhoD0EUWi8LAE06S7na8H3PjcmRzREhAup5SCqRtujM2fJKO/G3q5Ba+kHe3JTuToH6Y+wjhwM7M2hZdevUSmplneJ7e2azwE/o/MBtNc1ciQHcotYA+W9wfZ4mXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2vjy6cbrSjiWVW8OxsSeoimpnYFhGcAtRPiT6YKZ3o=;
 b=am8HRrpHktKAQ8C/2rXIR7eQ3Udn5dsatcQnUC4TQgwS8NqfL3Adh3nfgeB4Z58eE8Xn4JroAwstzyRDj3WWxqONPhTdhcQ6I0agdlqXZGMNat/6+UqehbWeIujvAgxH3HMVq48vxz0LXqMysU0ofryHBHAoT1JjrG7rjinzu7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by VE1PR04MB7277.eurprd04.prod.outlook.com (2603:10a6:800:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 01:27:32 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 01:27:32 +0000
From: Joy Zou <joy.zou@nxp.com>
To: m.felsch@pengutronix.de,
	frank.li@nxp.com,
	ping.bai@nxp.com,
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
Subject: [PATCH v5 0/1] Add RTC PCF2131 support
Date: Thu, 25 Apr 2024 09:35:06 +0800
Message-Id: <20240425013507.2840128-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|VE1PR04MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7205d1-c4f2-41d9-4c11-08dc64c6e0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|7416005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWv3FKJN5WVAdlncSA5VmSkdhkTkxhW5aRNDQ0GpQL7vlXTqkpIfmcuTAvf6?=
 =?us-ascii?Q?lm0D0Ve59kYi3rQUvmGyy+zcRINUm208iYmvQsRLi8SbzOBteLD3L4eNpw/e?=
 =?us-ascii?Q?wzFU3l8yYv/4p7bk2QVNKXMr86H3w2nr5psmqTLhlEgDlerSUQgscrQjhMNw?=
 =?us-ascii?Q?TWFQVfegkWdNh5513Pzhk+rSTlcJo7D83hh6Wp130lklMlkwipRNHB1VAGSW?=
 =?us-ascii?Q?W/lVHcT0+qX29G4sGG4FfShUTfaVD3WTiCf/AXbQ1APmw9vAJ6LQUz9yZkYi?=
 =?us-ascii?Q?ZfXNhsnOjI3ZEYPRTCyBGmSjCREAubFRIuR3OSHxxNxbKJIkmMwEgiq6bF/2?=
 =?us-ascii?Q?ZYercrhya9/jMZYtleJ01WlNCJ+7IvcP66GXv61J8I9CSHMCFdcogQz6jrm4?=
 =?us-ascii?Q?VVD2szt1QHQwX0c0Nhjils7Jwxk+iWJv2vO2q1Wm92XqyWK9pXhmEgJ5Aeca?=
 =?us-ascii?Q?aOi/FvR/1xtbbYnAaOBadYJvfxIoAvKpstNLKX1aDk6X308Bb4ujKf5FyNWK?=
 =?us-ascii?Q?z0BIO1zioYygmE1nFrLUFefIm8oeisFdKZrBiTvpj1ObE2djbtzyqs6sMzNn?=
 =?us-ascii?Q?HKzLjQxtEak5M5J8OUsaHWEPCldadIfLqDyEvsLii9qG03bhCOqZyHZp9Mpe?=
 =?us-ascii?Q?0xDZj3MxgN55yZitImsUcPjPbf6+JjG1b5CTejCybEmnfNcoCgA7knaVcFKG?=
 =?us-ascii?Q?Gd2wQbMMJ2s/e2obOtX4SsfgYHQHFggDAAY6WRTo+uf1ejt99M5MfJHZyCtF?=
 =?us-ascii?Q?5+VuUGR22AB5ak6Kjb8zEZm8rIHsNd/dEoV2gr48z3GkLY7yS2FhMUzNG20z?=
 =?us-ascii?Q?uOiJ2M0S38sjlRxxX9jyr+0gGYna9GYULKY+OxcqeoGIeYvbWIaRAUfR/Uiy?=
 =?us-ascii?Q?KlWIEl6h9VGILiY15rbmBMXtLvw5WUO376rvH2feE57hA82B5H/NtJgnTGXC?=
 =?us-ascii?Q?WL4CJzT/tctINzr4/r4gwW1ltgjDAoJIvyFUIBuJVUoa9o0jWdCZebcBWDFE?=
 =?us-ascii?Q?Pe5cj4hOymei+OInxfgcMT6Nil6PN/UZmATMobuP4BfjiSMaSuWVqjK3S4d+?=
 =?us-ascii?Q?+aY9N2Rc0nuNbWOulHBHqjg2RCbnPrxVvXQ+IX/oarngqfbKxB7gWtJrHUPn?=
 =?us-ascii?Q?bOAk+tBll6nlJ9P+RZF/iykrhvQ4nzQ6JJzWH5apbAAlrp2mUgjV6454vyK3?=
 =?us-ascii?Q?ia4aclA2p3JECpzpAKBmFg3ejOemTKRmeKO5OLdJoISRbcJMVLlfIQ95wZNd?=
 =?us-ascii?Q?ZyeW8sbhFaT01Y46LflJjrTihGB5RRWP1SsbmnEWXG79CqDVND49z+y2aiw0?=
 =?us-ascii?Q?2EsBQ94Ppbhi0bg+CD/yeEtrbNOd0SbEpYRXCfP/lvP04w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JAjrDDVGa+X+uhKTTkV9bf2ES78xGzc5aO0/RAaugjwnwhXQ5codjD8qFBBq?=
 =?us-ascii?Q?xJSll5iNXr3m4pO8YGxc39DfNhNl9o/NoBM2xU+27579uIDuhd56NWLlKGRc?=
 =?us-ascii?Q?ZZZr2Hs3U7rLCzZGKxqT5ED4BBpNyuVl+Dn0ft/W1u9clsYZq3JWWCwfhTnM?=
 =?us-ascii?Q?fj7lit8LD/AgXmul+MH5tRN8OtvaM9ehajRUlvzeAYGSCtyTKRCEAMbvFW3I?=
 =?us-ascii?Q?6AReGE0lI+yRJmtFK1Ky4S83TuyLcqs2tcwBbKtLQsOMztU0QUZHVM9Zy8/n?=
 =?us-ascii?Q?/RHi/6whMQ4PMkxBwiQZkjhZE5wYg2WNRvrM59pK7UrgcqJI8aPobyADcHo7?=
 =?us-ascii?Q?bwnu1p8hkAGg/FAcUuxvCFFGYIUP9Sf+BjRd9RmORFzcoYXxx2IA3icg31xF?=
 =?us-ascii?Q?+uWRaoAchcRw8oIvyayUsl9M0OvzvCItC9LDeZ3tckVatz3iYawsT8cqxY6O?=
 =?us-ascii?Q?2qVkHPKNyCXgSVbBWLZBfIRE7LFl82yK5iF9QiDNXKNMn236bPm/cFDYPiQW?=
 =?us-ascii?Q?kJDelBdUJTHr9IJfG3+NXcZCDuZ/BYbDmN5wMbp9YCi1AqCAUH4VCWLKzYcy?=
 =?us-ascii?Q?AiX85DRhMkKp8k/b4s8gdWPs7ybwubjEEHwvYUDa6CF76izyAhyw8e2rStqm?=
 =?us-ascii?Q?7HBuyzKeak3lLgGzu0e91gE2/pZYP9uo7hB8hHm2pMTP4yx1xJEFbvLWEtql?=
 =?us-ascii?Q?sQc7gMlYrjZtSc4zEK19w+9xa6sSdM6X6qui5jTSKT0bemkXJJCBydmh3Ipk?=
 =?us-ascii?Q?Ix8Sepq1Q+es7dzyQl3geQqu+fibmO1GZdkqB378GhW9pUN+DekWt5NkVIk1?=
 =?us-ascii?Q?0jc2FPq2U0joyhcHharYXARtdTogrbBZdFYG+b8+xN87gWq04KSYrqSf2xJl?=
 =?us-ascii?Q?GbTMlCkc7B1FdPSI62P1OpRGwN8+LpXU+VO+XUUI6usUuxpZbpgmwJETK8Vj?=
 =?us-ascii?Q?CXv2Wt/nUiy3qC0FqG+ex5hJYkhK7Enf+PZ1xeQL/HCoUWh9+tJrc3Hc1j5y?=
 =?us-ascii?Q?sdp1XmwtwUnXUIwRPET/+msgu6q+vO4/dhjyKpAhhevN9aQRuqTqW43Ahsum?=
 =?us-ascii?Q?CwzXfzvkxCnfvk4KNFD5x7JsyVDX3jX/a2zLb4hPDIPt4epzYzZ12/zCpau8?=
 =?us-ascii?Q?Gc69h+nLYrAwg7pVkzvCO9C5PG9KpKpGenA/KJndDLY303xdOhGYUMCEeEco?=
 =?us-ascii?Q?7+G9oUDLKIZeTNejOnr8/c4tKvS6rCPT08VHoQh1xet9UhzrubkbP31K9Yu/?=
 =?us-ascii?Q?XrCHdPuK0GfLaY/E4idQy5M/kKlmqAO+CROdqGJ2y7HQ9cle5GaDfolB4NCp?=
 =?us-ascii?Q?uNCMuNssh/Eozpr1+5gMKbRCiH9Gu1R0HvHwcByk/PR3mBySjSeNLZx/7gth?=
 =?us-ascii?Q?i7L5NysQLdbXCc9+80weBr2TwFb2OHWIavZTNBUH+MJoiY63SHk7mh702elM?=
 =?us-ascii?Q?lBwEn4ZIZsAwEoOjfXRh5aORqm/OVDkdv5h7SqVnKKi5LrFBORzOw222efoW?=
 =?us-ascii?Q?Mhq4s6x5i8lX3mCIICZwQqAtZoB/B3T1tzcYzPgZxFcwkc8XvF92Hd+jUwvC?=
 =?us-ascii?Q?4OGdbzfaduite9bGsY1j4PBuK7mShZbjOfHSwGjS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7205d1-c4f2-41d9-4c11-08dc64c6e0e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:27:32.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdeKblc8/gqhI9OitCG0evbAC37Dsz9mjjQrrcAPvMad9s86DAVn6wkgakfCkfno
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7277

The patchset supports RTC PCF2131 on board dts.
For the details, please check the patch commit log.

Joy Zou (1):
  arm64: dts: imx93-11x11-evk: add RTC PCF2131 support

 .../boot/dts/freescale/imx93-11x11-evk.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.37.1


