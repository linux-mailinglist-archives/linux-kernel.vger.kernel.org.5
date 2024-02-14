Return-Path: <linux-kernel+bounces-64786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141628542D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0291288B24
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744911715;
	Wed, 14 Feb 2024 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="LKU/C/MT"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2070.outbound.protection.outlook.com [40.92.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DE111A4;
	Wed, 14 Feb 2024 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892406; cv=fail; b=lqUD8kdYXWKeJUTO0NZXbhVj2IWt2fSvJImBOSGLbV3IhOa7B+KAOo1VZAhiLQOtiQKNIJJ3jyhEoOK1ME5YLOKEsgNKh/DaqVvW56XAZg+XA5eEDu+ovwsFlbAoyCObYvxnX9NdgP4fEDTapbuS7wcpoYPjmMYXu0XRD7Qzq5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892406; c=relaxed/simple;
	bh=OIMbOhFsCD9M+V3iY/T947GfH8E84t8lcFWZd8s+sao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WcpxuvhHboAInodxGpwK5VsluaZmLyvV9lVw5bJWh/vgQHZeBVcSj65fYQTRuM64QeYmfERQWwL1sy2M7ZLv6zjoVZGGlNmxsrB4Qi/IG3hR6vsve6wo/FrUWM5m7lO+7eVEhSrs8i8PDL3gfgKCA+AJBNMRoXvHPBn3gehljg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=LKU/C/MT; arc=fail smtp.client-ip=40.92.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlHgw70XjHGZ2OuYKxRt4wF0GFAElVZQRNw94UXNnHIpoQgP0wypwuAec/1McJE5Otd4JNsd/liCR5vNmW4n1Z4Cpb5BWGFZ4s3eJIBdBvm6g5mAIKlc3M/riz5KuqahG87ahqtfWjEJfTOO+fZ7x1CtZeC2Y6gRqhFQv4WcmFjwcYc9XD6UeDfabNG3xf9XlhcpAhosubpUzujG5wCu+4WHrINn4qxKANUpvDQUz5HctjmE+No36H2S9rmHMPgQ6cdSw2e6FDCrJBhBMOlovpk96Yy28CULmRB9O7pjoJco2+1MOPgkziwBsuKqwQQeJDBZPkZPV2MM0dtxKOvoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94k3JfKWEls+7907kp1nt5YO2OSY2Jh6iUZUYZw86ug=;
 b=VPYjtBH38PyP275UIewS4t3PhsHSNDptn6eJxXqqrG3SbdnNLCJXnPQ+hRzTOes4qDsWdY3Ix8oGRsoGJHZCVZceWRQvazTQkDaG8jMD59taPPAqUxqQs0TORD0AoIxxgDbFPFfqgV864HcG09TVKB3hVsqQ4gTVImrk1SC8iFjN71rBBMtBDVBj6HLi/qPWEc3v6eecIz1udb5JjRbMrxjFvQH+wjkApWIVKl6ZJ3TZvWR2vdWCdYITUn/b+oiDDVPa4bRrVOimzf+i2RmZ0Mgr70xkKvXvftQHkrgOqUqGs6MTfcG3ibAEDc1xHnHReIowQtoSbcJG744ievypmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94k3JfKWEls+7907kp1nt5YO2OSY2Jh6iUZUYZw86ug=;
 b=LKU/C/MT7rCY3+jOCkBHYZJBOTe9qAoKEyZFcX3N9BnOPpnYRHfIqiB1DJF82srLD1nUd/3qt5PbPJsOEI3IyXC59lvw7sWyKH5xSkVG1px6GXfi4yBuUDwZKh6kGSQHCGJ/OPjUo0Fj2C9ckBmCjGNP8ryBfa1pYA7b9/b/zTue/gZdU1KgCoSJjKfHRYFZgXzARwbnahBnpTc97uKNunWO+7RqtOYj0qh74tKl2eX6f3IfZwQMJ0nDRCINhxGAB0v/QAqbPP30Agwdt6lKV7Z2fFy5qk6cmkorw9kruWv1ayR/Jr84HkrPQ8Uho8xxWrZc6rdvy672ch4fTABHmQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by DM4PR20MB5063.namprd20.prod.outlook.com (2603:10b6:8:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 06:33:22 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:33:22 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 2/2] riscv: dts: sophgo: cv18xx: add top misc system controller
Date: Wed, 14 Feb 2024 14:33:15 +0800
Message-ID:
 <PH7PR20MB4962D7791717C6D579BC1CCFBB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB4962F822A64CB127911978AABB4E2@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [UxZAobAUWuHp2W/lXBdaEJTm0JaeaJyKwwv37isfItbkEbuQ7DrhVNgf1rLvZ0Z/]
X-ClientProxiedBy: TYCP286CA0285.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::20) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240214063316.435254-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|DM4PR20MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: c2235895-6631-4e45-ec9b-08dc2d26d73a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S1EtiNx+boA6qNGE8NPtLRRHgQWOgyIRsMydalGCLEaIBrKb9fZPN4StXnjxFuUJnJwdXu3tvMce0PXQj+nDg46xV8AyWcv7lfkVaM/wrT3Q02Mxkfta1JscxKZ5K5Ozo5LhfbGx+MVamltv2307+c9oshSCU1hzzdcQAB8rfwZaK3MYuExKduWKb+P5FHKy6ry9gof8FaDuOjOm86evmUk3S3CZ+4b87RmsfO7qoJlCvxbmWZOOZAaw6O2+OUFUepgg9OfpXqdOAF5tD1aJQ/6aMp4WBdgp+qUF83RUKi9/2c4910NyYVyn7lUHAgr4hhwzk9rnSF51lpR9neXUmLpd2cTZMcq44GxDBxSNU6QQLMJr5xZnGYFfgFUeJQcfGVakgd4/3xefprko6yiMadZaCUlxJfComPRZCaxwShAt7ZJIDBSss+Y3ueGQ/dN+j5xGQ1ZUA4DCOCxunL0G/3oPVgsUET41mkJYaZpoXpPB+z72b+bXXIz3HK38BlI1RIkcRo/E3Rtc/3Gnm7Cwmc+/g6sYaRa9K4cf2c7btXFPWlZgHcMviNq0Zn/cqvyt+Fz/ihvdcluFTAFBjV9qogfseMk9cwKLuEP+DYb0c4Q=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HYs1e1GaU797hXOToU1cM1F0SRSmsJBttu+Bdt4X2yiB+vQmB5d98PKs3fGf?=
 =?us-ascii?Q?rvHpxMf089x7SdQ9h267fUosq33Y5L+Mh8qr5wZz1RTZgDRL0THhvhZD4f45?=
 =?us-ascii?Q?dlUlEcEgLga71rC/8DIYCr4VU1QLgx596v4W2/MDpb2yM1ZCMNHFqeaxPDeh?=
 =?us-ascii?Q?3pHvGJhjvSANtpA3DX2nOtHF60NlVZeMSydLfnnF7uLEBCMLef90+ABwVhfP?=
 =?us-ascii?Q?B/gYFaENI//7L8scdYY23l3NIgHtFmoKyGlNyVngFVxB3pDM7Ms37HL4u0EH?=
 =?us-ascii?Q?sqM48uFR5VoBiLd3VrPnRlSrh9udAUrLc6taTIwvXHzMAZ0jEWSDHAYcMl8q?=
 =?us-ascii?Q?U2y6I3S6fHgEcHMI2c6Aa4dbO1F+9AtTqz+0EdPjGbvGnQz2EGwhx/LRWTgM?=
 =?us-ascii?Q?0HUa16SGBfC4aMLn+a2NC6KnCqy1+DxZKLFakAZBGK+khRNeDCORo0e/vxD2?=
 =?us-ascii?Q?VogzsgJ59qkEcVwPoDerWNYYfd7pnyPooWupPNvWCzcBNoZnlx1OqvMMqpDw?=
 =?us-ascii?Q?PttNQZ0IK37cKTDcbIQYKVtqBH8RwvKuPgzkFwey7vvilqH5a2HLnq3ihyly?=
 =?us-ascii?Q?qJ47BIN0veNoQEaQakav1F7/EDR+4huS4axdgwfXEXwby7ITG4znat/OQjGl?=
 =?us-ascii?Q?NeSfpcJMCiPoE9BlK/KQtSyRFAzK7xq42qT1lTtbazsyG4neuS2qLHzIb/7N?=
 =?us-ascii?Q?vP0Jz4+peFgFsru9AyIWPTnO9vgi1FHF01U6ZODEqm9SzK4WDzQ+fzXnuawZ?=
 =?us-ascii?Q?0IGVGUxfvVKKRnLqKz8esWMVVYXEsAwFF4G8k3VJyT7LQGEwGUnDYTk5kVXA?=
 =?us-ascii?Q?E6MCtT+AdU9+zXzt6iWoq6szJA0lw98stnDoTNOP13NtB7qX62OL5qKR+EbC?=
 =?us-ascii?Q?8ccTvZ2DBYkURHZMsRC1pmaJO6BA71/WFtExJBbBHOthCyyNRXvlSk3k3XU/?=
 =?us-ascii?Q?LBQgTGWgEzkd4AOkPyBORFnpG6GRRmBQ/7Cbaen0Fs/XTG78SSgr6Dsd8hw3?=
 =?us-ascii?Q?YQUT4rIFqGKKXJTnfyLp899jjbI3k174VjDmywXZ8tXubRrH4wKy7dJQ0euR?=
 =?us-ascii?Q?PR2Jdn2IMuDW9mtXUaPgdqdm3x8FzKkRlVBTwAhilYQXelFLXFzxx3HX4Rhr?=
 =?us-ascii?Q?kco4Tgq2UySZgkJbVNKXUl7nSK99Rc6ElheVfSUV5mODpc1PcR0CFAkk8aKh?=
 =?us-ascii?Q?/tO/76FdT+LlgiIaRxD3XxnSgkpBQS6xBKY4IfKaNwIOpviJ1Tap/dIqSwSk?=
 =?us-ascii?Q?sisQUhIOIb2h0ADswUybFZjYZexx/nf4NDJU3w8vpmvIyGnluWhdORvIhuJQ?=
 =?us-ascii?Q?K8E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2235895-6631-4e45-ec9b-08dc2d26d73a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:33:22.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5063

Add top misc system controller dt node for CV18XX/SG200x.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 2d6f4a4b1e58..908d858a63ab 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -53,6 +53,12 @@ soc {
 		dma-noncoherent;
 		ranges;

+		topctrl: syscon@3000000 {
+			compatible = "sophgo,cv1800-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
--
2.43.1


