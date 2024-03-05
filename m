Return-Path: <linux-kernel+bounces-92745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E731E872572
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 556CDB29B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1414F64;
	Tue,  5 Mar 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rOz3LM8Z"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2051.outbound.protection.outlook.com [40.92.98.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77839DDAE;
	Tue,  5 Mar 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658738; cv=fail; b=J116aYGVFXike3SJzNHAF4O93wJWBo4dfKc3T2miVz5o/PujZ/m8uUgdsZQ/NpHPHDX46OZGWkxKGicwMbgw8GDr7X37CI/a6z5F6sqPTWv+n5whHgJZoW46cxdeqzNxngAoTwU4zuShtdz7LRwLGJMO+uLCql/Imxeu5EsOlJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658738; c=relaxed/simple;
	bh=aLMS3WccyNS3QtaAdGYNfe7X098Xmt2GTD+/bHBVZNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y4em3qUzX3EZpJqN5XYuEz5V0BZRCmu2AkW+alvXfMWmhLsXVMj6ufLTU85VMzmPBM7Hr8wQfs3Z20q30bSh6wqhYN9V/HGRZewC+3iWg8caJVnXnd8uvIaPh6rK4UMJVAafvdWH9SmvDg5IV4gaWzfc6vr1ufAVBpE0F2dXonQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rOz3LM8Z; arc=fail smtp.client-ip=40.92.98.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuvVJNwyyULhhswCllfwO/AvAknFKJ9AbiQkTK2Pe933HzMQ3eu0T7JC128yeJT2kOnIlvVrrtOJrF6Zw6bZU2CZlES34+pEyPbGzC3PmstSmrFcPTbVJFdJRq9tTqDL5ruaZdJ1iuhFEtv7H5x0042BVRyA2slGy2FIcpoHjWmZLIgpPcKij8YkYorqJx8IHk892IK+VgJWDMem9lNVwH/w9AGuqNG12ESvrqUnmvO58GOw1Gl1Jk8h7ojYdsJQUL1Umt2sUDyS120cfGIRhg7K0POJruxOLyyDWyouT8ESfGcjbSmZFiNvyQCreZsJQkbYuelwL9jV/1YP6Ck3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC34xXFEVTT4H1SXjDaCdDjPKcnsfvXpqRoIzd4dDOs=;
 b=WdT5HNXprz2TapJ1tW9MOzJ1Z1uGMkNKR0R56LC36JrP9YFU+IEj9AZVHFVCklxCnfnHhOUXTZo1X7VpMTaq0Y4hxO8LLur4apqY/WJqja44p/9OVM3P1lHfrzSZosG1aqYshPSj1LkQH9kC8S36lBfZbNHrcN+bG4lQzag/Vh8RUM7CJ5luIB1olek32z4C2dQUmKA5Vh43YnSNxv1oMjRv15gIXaYnJ8GeaS/TSmlrHrUnu1rHUUrHJWzCKeIxCH3dCRHL6BpUuWA+bZiJHjFXNQe6i5GBrQvwruw7GBGoU47mVVIbExAp+KkP6oxFcrfsuayk9mGS+pYKJQxssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC34xXFEVTT4H1SXjDaCdDjPKcnsfvXpqRoIzd4dDOs=;
 b=rOz3LM8ZWpBGtIIUXumrCgZmeSYkqXvIRoBfMnQ52CEO9ogoah2TjcOAvyFk5WzrSLAmm6oPhXbFFZnc8yMrqVtxI6qu4pbbpYUjHdNBeL81EPlPjAXJF9uyCKXjiq6tzkgvq1MH4QMaEVzevTo+mFPN/NxmuI56kUVPG840adf7iV712Wtiin3albwUpsw3Wgeve/jJInGcBZWmVVKZcHfEn7NI/gZJdI5Vpx+S64x9aZxf2pUJbmwGu/WsDJY0IYYqCmPeFzWlAIqkQTo/9vhxUFaIyxtqx3iqaFLkWzhNuzjdde6507EWM6YtYISxFLh3FTb56DlCT/6+4qr8Sw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TY3P286MB3455.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Tue, 5 Mar
 2024 17:12:10 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::58f5:1590:22a9:6f6%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:12:10 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: ganboing@gmail.com,
	kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	lee@kernel.org,
	andre.przywara@arm.com,
	jernej.skrabec@gmail.com,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
Date: Wed,  6 Mar 2024 01:11:50 +0800
Message-ID:
 <TY3P286MB2611C5F5833F3E3E1AE838CA98222@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tKBi5BbeYBV+myFWcrlbnJ5gZ6FT8als]
X-ClientProxiedBy: TYCPR01CA0121.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::8) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240305171150.13755-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3455:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc42375-0bfd-42b6-c194-08dc3d3764e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xfYjMz9AAVsbA/VbzbP1wYwue4Y+sGITcYhCHi0odP7Hj+MmtBRMSVNlBB0D+H/OE8okvK8nqb3bf3i9L9Yt7um0FBAzRqEBzOAgwqFif6SyVQwObeiBQuYesCYZrVNHB4CHFuY9pTORFcoBI5ULLZKivniG9LIbERLqccvq2QOXHivxleTvzrwCG4TAHeAh3+quOyMcMAKuD2Z8Brh0z/0UVH9PIWbWeIXskQnJ5ujDszDofP1InuTA3CLFljJaWM9pRuhlna1tc7ZynfuC4S/9k0gmyVouxdN9L8SB1O/ZpBCOUBpEl/kunT/TqXpitfj+GT6VAFwD3bAfKBidqfNh0LMBNyRvIShRcAPQVG8lhkwBF4QI+bdLhybSOQizlLfbGkL8eYSFwpyk+gGlamxsTzqbX1AZXvc1MfSaKQJMN8818r3TRlDi73LiZ3gbZPdbdHWIeuxY04QvxOkZzSyvCDEzz9rXWqVllyeBrOErUSjNRuFMSe/G8ACGr55Hktj/DioIWMHx8mFcDapmvjm0QURcOu7LyixAi6b9dmxtvsma6Vunllng+qUMl3NNV3BIcMKeKBZkSTk7oo2YykJNOocmR8lWk1H5WUIK0BPUoxtQFiV/Uv75rB2L4z/y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y5NxXv1c2n60D8/yG30FhBeN9LQ82wQQkzz2pSzb2Z9xfavioLpoyRTx7IPC?=
 =?us-ascii?Q?9akr6hdrFt19KIo/W/C5C4cXZf8/vuRS4sOLthxQR+NyRDQWXvelUN1xiZsR?=
 =?us-ascii?Q?Hpl5iu0VoDtyJKkp+n4PGfOD6+vazCPI240FRzwDcmexPNSFf3Ro+JDLyqZL?=
 =?us-ascii?Q?iSwXwc85f6xy5tyJSuWFB4QPRxrvp1q2Zk96FBCWwEtGLEksZsCArYndW1UE?=
 =?us-ascii?Q?6E2caANcjiPcDCEWm1WhbXKdNpTY/6XEeTKsPaC0F+j+kpokf3JXGX7pKNlL?=
 =?us-ascii?Q?h/4C8cHSXMiaOc7SDAyaLv/fPE8IJIby9Y9vtYPWTHdLwJoP/zaeH7fgCrPV?=
 =?us-ascii?Q?HBnD2pm6b0L5tqSE2J8OIe2l0B7NuYBkVAMHZEc2xFizGjZbM/3SVrVSahVQ?=
 =?us-ascii?Q?gaoIcimzeLfdhuPoHDLDbpGKC13cMCxYetMBI9Ig0MWfjBHK9pMbnBvSMKfw?=
 =?us-ascii?Q?+OwhtWiX/sQh7/85/RF0TFeo1vtQpPxFT9uCZ9gT3UHIHP6ODhCN4u9+ZYL8?=
 =?us-ascii?Q?snkr31Y6pM7Km6YzkhGhUEXHRuud++9vLht+EV2GW4A9s0P5fH5YQwu1JaKe?=
 =?us-ascii?Q?r1oexOs0WZxIlikU2rM5MrtOUWucWG6urVJp1fFIjFTfcOzDQDdHW6hV9Sn5?=
 =?us-ascii?Q?5S5OUeypFwn+34fNwXaOT3PLZ7dc9LB/yU4NyaAOzsTKxw8K51mEeuSsg/WE?=
 =?us-ascii?Q?pQoQfhMQ0leX962yPe+PTAipwivGCiboaAoUqrns1VPC+YMmxpELspCcRUmZ?=
 =?us-ascii?Q?k2g/mKz4qPzoIkd3PyjOK9gWkYMDYVuCIinP1e+ZqUqbXQHm747TB7u1BfgC?=
 =?us-ascii?Q?TIaCDxstVbBGfGwUgM+LJqNBGoNvOzd/G/7c36wfo3AXjbKfmBa9WmI5Pt+P?=
 =?us-ascii?Q?u9iKa7EkYqaIC3uLcOop5GW/k7Hgwp94XsL3J17tO84JWope//2aBFPbZRpS?=
 =?us-ascii?Q?8Uz7bW+C9EDoybMMpWmavBTwkyoNP2F6ApcPw7rE+pIx27ArRq6torTVEW20?=
 =?us-ascii?Q?x9wsHVrRk1yxW0wAdoKM6+ol74rIk39nZ38Hf7D5HJrD0rBrueXccybW1XFC?=
 =?us-ascii?Q?UrS+f+ESZCh2ScYUXvnWgSSWn5ky+gKRCv8/aNJiChA086rOBoC+Akjrf9EE?=
 =?us-ascii?Q?j68GbvGF/dHcGZNQgtA7c2MEq5uJyJ9ePWrIh/YgKuXKFlnG/qbN4t5g8E5W?=
 =?us-ascii?Q?Kb0Tae4juQ35CvvfZC5IrWcUTWXVzh98Yce3MwezxBdkv6A8OFg2t5L/dRc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc42375-0bfd-42b6-c194-08dc3d3764e8
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:12:10.7724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3455

Since commit b2cb2ae22278f1918f7526b89760ee00b4a81393 ("mfd: axp20x:
Generalise handling without interrupt"), interrupt info part for the
AXP15060 PMIC is not needed anymore for Statfive Visionfive 2 board.
And this would cause kernel to try to enable interrupt line 0, which is
not expected. So delete this part from device tree.

Cc: stable@vger.kernel.org
Fixes: b2cb2ae22278 ("mfd: axp20x: Generalise handling without interrupt")
Reported-by: Bo Gan <ganboing@gmail.com>
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..6bebabe3fa37 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -189,9 +189,6 @@ &i2c5 {
 	axp15060: pmic@36 {
 		compatible = "x-powers,axp15060";
 		reg = <0x36>;
-		interrupts = <0>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
 
 		regulators {
 			vcc_3v3: dcdc1 {
-- 
2.39.2


