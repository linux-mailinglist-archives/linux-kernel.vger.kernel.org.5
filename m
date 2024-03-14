Return-Path: <linux-kernel+bounces-103283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBB487BD74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874AA1F21E24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD96D1CE;
	Thu, 14 Mar 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gMPRZkdu"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762895D8E0;
	Thu, 14 Mar 2024 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422252; cv=fail; b=tniINbuvPwz4dTQduYC3x10CpMCQauyvGvKVhcQghesUi3uR3ll0r8GGMzkUwWfuowat8/jKiswG1+qgqmna6o8AP405gmPRpsweFDaz/Ch6w79iUEGWx6h4W41lZfD/zrq++6P68RHK21xzdwJW/RlwI2uGtzgUerKHa6VX/aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422252; c=relaxed/simple;
	bh=tPu4pe/a9f9123M+d6FMhMhltm6F8QNItTOtX+36WjI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=h5JjXTeoKBBVq+lDJ9x/fTLOnOtAbfhc79Fxf11WO22CySHFgt8IJnHM7Zzeyugs85HiF4s/v8Rrk1laAZ92fXdMHSv+ooMFDPtBhZkgT/n0GIParAWFR0n19ChkxkVdwLb8kDqUZW+4lmjCZyK9wr1DWzu0QpSJZqecH37HI5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gMPRZkdu; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlsiPitxYgH+gjenUiDH0KgOdwOGoj3GRSnxdSRJjenLekG/tV8k7rJJx76afAmpGTyaj0Fwi7WCQZdQmrJYbLcf0C4XIJYiu6As5kHMefOG5ky+z9+e9ACAsC7RdGY7DB0MPtGZIu0vTaTSMGszuqQqFYvVkgI5jJOlBMvZGzyeEwB6k5bQl71gnDAWalSfSayQ1L+l8MyU4pC1RccVym+ggX2aIB0N5t8DCr5t9rgH1a88g07oZtxw6PY6jrvCTnwGL++jfb68vho2GYc4vImcz4rNtyV6uRUsYbrTZ3reWADpHEQtoh6I02IH0ePqzScFoOkP701PoQH0id2SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HIlyKelq6JYQD5GkQYalhNknJXytacVDoFJV5aMkqU=;
 b=YWhzysp3tV4wsui4sw+7ir/xmZjibqwKLOZXkfcdtFbgt86UxTtNQN4jSPZwegd5RDSFDD9485wBRtXlqbEYpR1wBj0m1Co90wLPADwcepFKKcNJfQGXuNPXiynUBq4jVCHpxykXRHmMDZ0BHrzDaeu/ANYDwxh+jFbLC+wXFCJAp2NaKiB+KK8D1x1MpN7iSLM/hg22gkVxjAyLJqObKv/yg+1xpPwtUg7ixNgSg9JVBtYEpk3axT1trHdK46lZ0jpAIv/0B5qum+OJdWaz2HCJkYl/Z8BR6aQnew3NW4Vje2MpTpNwqEIqmLRjK3hD9RbgdNosT74i1XPBCBpkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HIlyKelq6JYQD5GkQYalhNknJXytacVDoFJV5aMkqU=;
 b=gMPRZkduhZ5nTr/puG1mu85xExRDftzM6uOryiUvmR/gsFroodn34Q/aeYsaIYRlzIOSG+6sUKfPI70izHBgPFZTITZQ0LyjMPYfZRJmsPooUULe4622bTKlKxqvGR61ImtvI8G71XlaL7p0pWYFqZIYqnqal1E4JJMPKKI+c2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 13:17:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:17:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/6] Add support i.MX95 BLK CTL module clock features
Date: Thu, 14 Mar 2024 21:25:09 +0800
Message-Id: <20240314-imx95-blk-ctl-v4-0-d23de23b6ff2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALX68mUC/33MSw6CMBSF4a2Yjq1pL0XBkfswDtrbW2nklUIaD
 GHvFibGgQzPSb5/ZgMFTwO7HmYWKPrBd20a6nhgWOn2SdzbtBkIUAKg4L6Zypyb+sVxrHlJrkD
 pUCEAS6YP5Py09e6PtCs/jF14b/ko1/dfKUoueGlyTRlKZYvs1k79CbuGrZ0IuxaSdc5ciJw5W
 7S/Ntu1WbJKIBktpAYpv3ZZlg+rwQ21IAEAAA==
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710422742; l=2072;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tPu4pe/a9f9123M+d6FMhMhltm6F8QNItTOtX+36WjI=;
 b=X0DXT91twUIzZa7VNrSLGxWWALA2gC6aatKNlqZ08r2ISH1e0702joPcy6aD92ikrA8hHJEBy
 z1UDqVvyetbCK9+Brj462fKzISWqTjIP9QVVwEKzHYRHNqFa6lPS4cO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0130.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::34) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1c9e3a-29de-4799-1590-08dc44291643
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m8GrdkwQOxbtg7abyUTVsrtblXU3+e/Gw8e0kMmYH7YTc6N3IJz5kEMX/vXgTCVZzQzBer+4bag405JZbtB54wMMZIKKrg12itc+ZccT0ZB2OkYys+XaBmJGvZ3oJqQnqUzaox+L/c+pWJxl8gMeaXbMGL9VmIYBShrD78xZM1weVlOsmIwGN21Ympw+Vu3Mu1FFN1Y8rWm1kk+j5VXjI/TFO3nhwmVdAVjecfAwFNV8PYLSs6to8VE204YUYWFR5Deg8/jMhqiFxgw7hmzW/9Ya8RGiQxt28bjtNRx7tlzGRLlfX0osIxsTvZfB7Lh388nBhUN/ODrt4INq/wtHlAsDZ5JvFW/zeXH7fzDXwALupAWlF03Dy/y2Q7i3her0fmDe0CfH6n9eff5DMg0z0XLs8EhkaSjOSIPKokVz1ky/2RvZCkiNXaoHax7bJUargaGogvsErklEeCV58qwoqjCroGmrxshmiCH7FxxC08KRLnqzB1ujnyOof/qx5W9I1+qCiD7wP6EZl24LBqAiNe2I0iBGZE87y6Vx8I7OH0xNXi9mzbjl1QAGBo4dXjGAwTILyBxB48k7RYC9XsEOd0Jz4Ue4Rv5/Lv2LdgYfPzqras3BxSlHwFvwTfD0EKdBcScXFS5ef9/k0/YeK/qTIS/4TGRaQIuzZyZ35wq4aoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNGNUZzREtWVElXbEdvbWVmZS82dyswQXhXMXRpaGxjZDBPU1hSNy9ZK3lB?=
 =?utf-8?B?N1ZNT1pBYWV1Y0Fya1dNMSs0UUxyV3l3NE1nRTZrRUxDSnpDdnJVRjNINEY5?=
 =?utf-8?B?VmUvR1k0M1BJL2NBM2gyQ2RyZjhkMkx6YWxweldiMlFwVmNyNFRPYmZpMEl1?=
 =?utf-8?B?SHd1MkVuSkdwb0FDT0xpN2s3eDlvWllQcngxcHE1UlNna3JCdjIvd2FqUlpX?=
 =?utf-8?B?c2N0QkZKY2o1THBVVS9MQ1hGY0xObEtZVkgwUm41QTVTQkdjTTRjOGxTVi9E?=
 =?utf-8?B?eDdjbGplaUUrZEtiZzF3Tmw3QmhIblpZY0JzL0RZZFRQOXNKS0JXZ3lXa2Fr?=
 =?utf-8?B?MEJ2THF6bCtUaDh1NzBYb0U3MTljbjR2bWk4T3pMeVJ5VkNscmpNTlJ4WXpG?=
 =?utf-8?B?S0cwNzI5aXNwcmtmN0MveVlWSzhGbndOMkE2V1BWUXgvcTRaMTJlSXFWeStN?=
 =?utf-8?B?VTE2NitVdkNEdzRyNXJ3d292NXgzcGdBTW1zazVwUDM1QnhyKzR1dkpJNXYw?=
 =?utf-8?B?dVR0eGM5M3BkN1F2MXZCS1NKTUtjZEJUeDdJTkI2VnNXWnk4RUNnRXppaTdj?=
 =?utf-8?B?UWhoVFhMOEpaY3QzS1YvV3JQQUlLRjVaNms0ek4zR3FaU3o2Y01tYmg0OGdv?=
 =?utf-8?B?eHF0MnFkKzZybm5nUVducG5kMUtHWEpPSnJKQzhZdXQ1U2ZSTWJnZG9WVVVn?=
 =?utf-8?B?Y0E1dFIvbW5QelpZMTBHaXFyMmQwZFN2RHVDTTEwb3FFcmFVZklPUkdQMlFJ?=
 =?utf-8?B?dUR3Z2ZyUlBzTGxaVWZ2cVdSNjF5UXJTamE0dXpqa3R3cVVwUVdZYkF0WVBG?=
 =?utf-8?B?ZzlyS2ZvdDFkQ1ZxRzJPUVlrVlN1cU1qK092eEh6Y2QwSVVPV1lqeEN4RE5Z?=
 =?utf-8?B?ZDhFUG5mdEJHdHdENzlROWhNVFQyUEFCclBkOG03NVl6QllyaFllQUZuSExy?=
 =?utf-8?B?dlpQay81c0NZa3BaU0lVR3lSbnc0c3ppT0ROTXQ4UlBjZGpQR3RzVitFUDh1?=
 =?utf-8?B?Yk84cE1WY0tKbFJJQmZldXVSRWNQNXVaNWY1Y1BzcFBlSnlUcGxKa2xCNkdB?=
 =?utf-8?B?b29oNCsxM3JtSzBTc2NNYnZlQ04vWjhZaCtSRlVwQzBzeG5FY2REWkxKaGlS?=
 =?utf-8?B?VVg2Q3drOWZENjB2Slc4ZzlKSmxqa1k0QU9YanNMVFB5RXpla09iN0pQdGI5?=
 =?utf-8?B?L2R5ODZ2aTRJQTZES3BiNFFPS2pnMkJFYXlFMTB5N0FFT3cwd2MzNEk3a3JY?=
 =?utf-8?B?VW1XMks0VUwwOUk1b1dtYnphNHJQTHdDQ0JaZk9rZjZTMVN1Z3BTWWZleGRM?=
 =?utf-8?B?ZHVKVlZEa3dLWUhYSk4rdU5wV0lMSGozYXlCUml0Zi9xeTBjQ2l3TFRTMUxE?=
 =?utf-8?B?bngwM3I0RGQrcU9RS2U1N2dTVjJjNkhISVZnRlE4K3NxWUN4MFZGR0hTV2ps?=
 =?utf-8?B?clJnZXdTOEFkajJDNWJWdmxiNVVFNE1PQUJlQU5CS0hqOWMwQjV6UUp1R0Qx?=
 =?utf-8?B?OUpWNE92VFBzM0I0bjMzYzdrWml1MU9RaXdYU3hxZVlSSXY2RmF4bFk3dS9W?=
 =?utf-8?B?VyszRjg4c1Z6Yk83RjkwYmdpL1VzRmN0WllOd1hDOWoxdkp6U3ZjdE1vQjFi?=
 =?utf-8?B?anNkK0VwbzBDRFYrVEc2ZzIxUVZQVytJUjNLKzI5S2pQRDB3NVR6V2thQ1dy?=
 =?utf-8?B?NHJHbjZhbzVsaUdpM1ZEdStCZFFUblJ6WnkyTENGSEdJTzRDNHN6YVhJYVV0?=
 =?utf-8?B?azFia0VkZVU1Z29mNXFMSEV2M3RqRXNGUVJkUnpmSjA1K00zbjlmRDQ1VnQ3?=
 =?utf-8?B?ZTIvYWNXVGZUZnZ6VVBZejVBblR2aFlFOE1IV29KK2NEVGtWalJCMHV0WmxV?=
 =?utf-8?B?b20yOVd1U1NjNUhaRzdmVU9DMS9hTmdvWXAyUGNWRFBVWk04V253bEh2cFp4?=
 =?utf-8?B?MzNEbVNQU0pYSlZtdWtWWm93Q0o2Vm1jNjlQbmkvQnBJcW9CUHN0enVIaFJh?=
 =?utf-8?B?VlV3ZEhuN1puVnNydi9QU0FEdG9pbGhsaWFtT0ZSelhhZVJzZ0dsRWVIakhR?=
 =?utf-8?B?bFB5a3lyWUs5bTlMaWlQVjVGYlJDUGQyeVRZcklDL2l4ckV4c2xVSDhwbjNP?=
 =?utf-8?Q?2WhnRzy8A+7DB3UZ3ZB6nxsHS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1c9e3a-29de-4799-1590-08dc44291643
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:17:25.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLK7l2DBDbLW3mIwpffu+KstswtqHOEqky1TFx6gexPYTPqDui8p91qPf62fwAo7VMCyRKdYU00IxSsyu+azZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

i.MX95's several MIXes has BLK CTL module which could be used for
clk settings, QoS settings, Misc settings for a MIX. This patchset
is to add the clk feature support, including dt-bindings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Separate binding doc for each modules, I still keep the syscon as node
name, because the module is not just for clock
- Pass dt-schema check
- Update node compatibles
- Link to v3: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com

Changes in v3:
- Correct example node compatible string
- Pass "make ARCH=arm64 DT_CHECKER_FLAGS=-m -j32 dt_binding_check"
- Link to v2: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com

Changes in v2:
- Correct example node compatible string
- Link to v1: https://lore.kernel.org/r/20240228-imx95-blk-ctl-v1-0-9b5ae3c14d83@nxp.com

---
Peng Fan (6):
      dt-bindindgs: clock: nxp: support i.MX95 VPU CSR module
      dt-bindindgs: clock: nxp: support i.MX95 Camera CSR module
      dt-bindindgs: clock: nxp: support i.MX95 Display Master CSR module
      dt-bindindgs: clock: nxp: support i.MX95 LVDS CSR module
      dt-bindindgs: clock: nxp: support i.MX95 Display CSR module
      clk: imx: add i.MX95 BLK CTL clk driver

 .../bindings/clock/nxp,imx95-camera-csr.yaml       |  50 +++
 .../bindings/clock/nxp,imx95-display-csr.yaml      |  50 +++
 .../clock/nxp,imx95-display-master-csr.yaml        |  62 +++
 .../bindings/clock/nxp,imx95-lvds-csr.yaml         |  50 +++
 .../bindings/clock/nxp,imx95-vpu-csr.yaml          |  50 +++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   1 +
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 438 +++++++++++++++++++++
 include/dt-bindings/clock/nxp,imx95-clock.h        |  32 ++
 9 files changed, 740 insertions(+)
---
base-commit: c9c32620af65fee2b1ac8390fe1349b33f9d0888
change-id: 20240228-imx95-blk-ctl-9ef8c1fc4c22

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


