Return-Path: <linux-kernel+bounces-105902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038087E638
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04001C21597
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C02C84C;
	Mon, 18 Mar 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IUNv2e7k"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A912C6B0;
	Mon, 18 Mar 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755324; cv=fail; b=b/x+LYNh15ywB0A9vkut1ACrhH8pS6EaWflK6jTO65YWYauF0zFqJGsdFIn2lBWIilJpiNlPPFueVzTu3/ZQIVoMzi+tOIfhF1JjhzWyzgMie/g5Z1GsfJyxkWg60Z7/s25KDpb0dH2Sf4Ft7X05fh5SWrmZLfE3k2D7f1RBB2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755324; c=relaxed/simple;
	bh=uvz8Tn9wLJ+OIzukXTQFaExe9WpHb6/mo92/Rqi8PL0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cGgp59igoTH8F8nPtu8zWVewdO5h3YNVlSRmGEpbKxMXtKLn7yzO1y4C6EY8fAHkNeXK6LlLoPnw72z/KOB92NdfVNe8qhrJh6S2w5NGqtlY8f+QxZUmZjmnCTqmwog6ePAtHiYEf57p+hrcS1nrAl0jFGsuIzBXts3PQYETqqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IUNv2e7k; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuC+A3FAot9MeAq51PJXywQud08C3k+GsDvKd7Vyeo3WjF3j/LRuFJ2+Z62QBD7k4131aOYj7w4eMzR0FzTzk+XYzb52SB9ld3vc+mE9OgVhtsoNOrvy6BDpVLunpl5KAs9pru/gkvoGcE5GvK7FRdyq2v5nqQbAT8WF5rCGf+6ERDnF7VLb1KVJpaRHNDs0fgV+Ad2bCEMH0v1tlgDN3gMguG2Fq/LPAObqOofNzt3FPjckUHOnpfZpnoA6cmIl8TFVn1NDPNMaJEXY4/thIQr9RN4c12wa8nnt146807LIdb76ynkTxGoXo6obo7eVa+dz8svKDLKbGcgZMM2Gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sldrU3Vb9IJMnFl5q8BjB1Btb0n3uEHHyUSaqKK7qec=;
 b=M/6TYrHppqEptlaiJnlTJcaH51+aGky5+SNeqnWjzKoohMDWl767EOi5908eseHGtw6Wd32JCC4MN7c47v+tKmKX9HoG4O1Phs4WzKsPEajpiRRBlboB//SZXhxuYm2DKE7N/EmP+2r1oKi1x1mVWR7wu2qkNEG8ulHUn+xSwrkzddp2e8fK8IDkT4WzcslyxHpP3q7bYg0QxOhfcYaSf8XV5CCQ5B7sNX05U+i3X7n0xLVH0ko6pFDvYwhglWRoJrLHD5cBoCEHjJfZSnGg6BVGjK+4lf+z+LVmol7hDFJzuoH185QJgzYEvftiru5g5FBFliMKtKro0Lfpk4iKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sldrU3Vb9IJMnFl5q8BjB1Btb0n3uEHHyUSaqKK7qec=;
 b=IUNv2e7kWXesIQRPJWMujWDf0pPw/aU9p/jf2FSPVNoS+kgoP+ZSANvkzrm/h/ZT6JXQEv3CbgnSKxBqTX/MfxbHdQyn+YNk7q6WCgmfjI/j5XC7ClqwYhHoJ8nDFuPXU/W0NLGG7++CgeEKMG4jsJc9a+pmW4V0+G0Nm33bdqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 09:48:39 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 09:48:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 0/3] add pmic pca9451a support
Date: Mon, 18 Mar 2024 17:56:30 +0800
Message-Id: <20240318095633.4079027-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 77975863-49a5-48ff-6852-08dc473096be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	usfufK/D0H72GmsBxpxsXafg52pCfcpJ/J1XmJwhNIVR03rP3bNtA5HzCrCmnqmPNiqHqALBaKak70sb+JTAPCjW23ZzF+scgJhO9HR4qoiw1a/uJZLmskeH0KsMYjla+AIxhwg2Eioa+fz/9uLMsEdJYLHgvJzQ3hVkbTjukf6Yo2UclsVoUuCpJGZ3/cubU6QN51IndhAv3uD9+8J9yyK+MMtTB6Qc40N3kn6vkTTfcXr2GHX5lUYxRPMRr1JUuhGrBPgLdWMf+0Uxz7L17G1JnFRKWcFdKxCVAhC5JiLtjT2VN2EX5SAFF28FEHvTq1M2r5ixm+d5OOmCSbKRczFTU0DVuMZIOrSL6z9/xB381Ob8wtaUkaTiyXmYh2FqE18LlIuIUzS+x0diOciuFCrYOWxX8g07Ccs7yJXglFwG2gAeAnlaiqLFUkDnWyCXz0WCf4+gOcBLtpXaIwIkT4+Gg+L+beaUbOomeSmipHHdsdc+Q8vEKKFMHKG7xXeh0VbeZFvtE5le8QuC1keSNb4PSnznv3551ZHLOC8rneUF+MNZDlSavNGhOrIARqcUe9719XvMaybJqQJ1pkR/akvYGZE1os4jLzCb7DB/Pxjsi7R8Nknbgn7SjzkTWI6M9TBwGfGOu0b8F7aiwDnchB/5lv4iFjzMnL3IdTKPLbWzZXyi4FE/kuE8iPph0YP+AdoiB7sl/FP8FfjTl62Ur494g6OSacJWrCJSS38yJ4A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTwf/La/E5xExAAahZzpE74ZfFPhAGLJjULA1mQvy0V6D+XwU6H6I2K2AbRc?=
 =?us-ascii?Q?hNZtT6oiLC7CH9FTKG0DvlQM9nTTYLuKdXlqy+gHE46RluzkhZr9R0mIqk81?=
 =?us-ascii?Q?JwL8Ef2pFZttetdiLDWEUW1OX1gYyMAZFfTuLotLw7Xx2fgEswh2pbozHOOf?=
 =?us-ascii?Q?zLWYgMylZx1PWoKsldeQNerW3Gf97SSI8mFm6Y9TJ94iO8T9zIyFCNBn8EkH?=
 =?us-ascii?Q?yWrezxYfWlbTwlWLZS20lAz/oFxspyq1JMA0KlU3OCwKZfhPP4e76Cj2GW5M?=
 =?us-ascii?Q?hHGviX4AZEsKwHE4Z+TD35JdXWDvmqwsTvt9ncfa46UzYL94D8dUnJFMfNc1?=
 =?us-ascii?Q?2BM2vrFepxyrDR+revKDI7Vp0lhiR0CWtu7DezS/byZBp+1Z5jBWwLKAMvdO?=
 =?us-ascii?Q?yxOYQ9aRW31Dd07b6TS0VDdGO/dnIoh0S1KWt6y6RzGECkOQyKP2RwiNOpJv?=
 =?us-ascii?Q?iyConTCQauS0R9VZeD/gGxfhB+OA62B0dK+1RrrzG7bo8DOwY0CZg0IB0Sm9?=
 =?us-ascii?Q?146sG596K7Z03c0DuntqoJFFBTfbmW8P+gqbfMEW1Cd6luvXJh7dP+LXtCEJ?=
 =?us-ascii?Q?3Rx7WbZ7Ch88cgKtaqBA9hayp80nn4WlNuy+6VDA2nDMwWixjm0nWlYtcBd2?=
 =?us-ascii?Q?OMQxzggnMwzSiK6ttuu8xs0wJt8FcptZ6BZSSlC1tViSAjKWR6BsOK/AbbAl?=
 =?us-ascii?Q?WVWe5gL2zfUbnpmnF1hUXrAlP3sGP2nT2fjt8b1LHK752ld9laob6BkPxAaA?=
 =?us-ascii?Q?2kwwb5wF6bnuHVg87jYzYfK8HlPK4i24n6d6ASVAldZyRfegIf9B1jQqWcoD?=
 =?us-ascii?Q?c4cR9pDuRuBXVVtBAXIFHNwURimxmCmJYX0KJMA0PzUXGwG8JNaICiwBHSz6?=
 =?us-ascii?Q?zMkNSaD0l/RWk/SShf5Fzu7Zl0jvap4rP2FHa1+P6JZcFqW3fyw/yuYMSwj3?=
 =?us-ascii?Q?ZG2HFJ3v4f9rkZPir0SnIJm77Jree7uGmaGOfWZcOLk945sPa9a6pny2dQrg?=
 =?us-ascii?Q?yTPfS9WzixEg4JJyHSqCUCow7k5lESjGznK/+qdogeA2qK++2LfRh+lLhu0N?=
 =?us-ascii?Q?Bj5VIwEjBFNNsB6w56a6NYtVqnBXRzGN084FwZIOG6ai0XbH5a/iU6Q8BJpG?=
 =?us-ascii?Q?PWhOOF4Hyrv7ACfwOEMtukpgK1rE2+mco6YvDR4iagiqFsI2pjHv8e3M5gaa?=
 =?us-ascii?Q?yhvIVBUUeuDzsA5yj5R8XsWQWm+yPSv25G2r6YaiCfJU1h0Kdr3vHaegQy2v?=
 =?us-ascii?Q?VLdOsMWdAoqDU9ID5eQcBHiRCkC33fVvAg5aAr3LhgmP0qk40/o4hDDvjlAA?=
 =?us-ascii?Q?Gk5W8q6BtJTicpVy86U3sYIbIzyN5LNO3KYcf9N1DTMyiqZ6hk0E6jyEGsu6?=
 =?us-ascii?Q?O7LEOUxeyVIuoief5gT4zha5frVQ2dRBCyCrqP+metTJC81nQPdkEhWFgmyk?=
 =?us-ascii?Q?IYtErKElOICemdywKVFUxOzxtfawqEr9gwQh1xMQdtD2eRiQUh1PclbbBLyu?=
 =?us-ascii?Q?Gwp1EDr7aAT/tH4iFwykc57EPbnVdJNhqshELhnpYNZrUZ2aNZ8DLvn4J2Ha?=
 =?us-ascii?Q?SZ1i2E0v7C44XO2MIFqc+u9e+k5LsSmwJGdvjyEU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77975863-49a5-48ff-6852-08dc473096be
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:39.6517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmFwweoS4G0Rivc7mhaUsUHzsoHoVpErA4fU+Zvlayn/sEt6NDEvQ8RneAxq1Cei
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

---
Changes in v5:
- adjust gpio@22 to the front of pmic@25.

Changes in v4:
- modify the comment for uSDHC but not i2c.

Changes in v3:
- modify the dts voltags constraints.
- remove unnecessary changes in driver code.
- modify commit message.
- add tag for dt-bindings.

Changes in v2:
- drop old part support.

Joy Zou (3):
  regulator: dt-bindings: pca9450: add pca9451a support
  regulator: pca9450: add pca9451a support
  arm64: dts: imx93-11x11-evk: add pca9451a support

 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 194 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   1 +
 4 files changed, 305 insertions(+), 2 deletions(-)

-- 
2.37.1


