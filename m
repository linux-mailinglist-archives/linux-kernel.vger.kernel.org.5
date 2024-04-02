Return-Path: <linux-kernel+bounces-128319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6900A89594A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87081F22760
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3371714AD25;
	Tue,  2 Apr 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="KOZRcQCv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9E140E4D;
	Tue,  2 Apr 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074125; cv=fail; b=krFvI8QpBCoXtHL2fLy2DeYccQ/o7Lpqrn7PN4kNG5gqbT1RMjIg2y1QQ2eSk0X1HAHQVRX7RzeOsU2HNb6uvVXhjAIH38mx9FJIz0kPA1Jg9Xf9otbmpvAzkK2NjfBnks5USoU5Qfp7Hjhmf2wx/j1jVW5gD4D2HEH6XNxBs8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074125; c=relaxed/simple;
	bh=tgLTm57QGE8SJAPJ1JgkK8laWHq7cdKvCR4cNXsbdtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzT2BzWAIpHGEqgM5gKTnkDcyRDanSkxOq9y6PC9LXBJ0TyI2hcXKWcnenn8DenQMGiXiNp3WFei4RNMGaGDLOU9dhpIfaAcUjtgTLuQTtf6nI3EY76wOeF2v4zwNxg7rhvopoKGc5/vpeDzX3rUYctCQLC5VP6S4C9je0hNLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=KOZRcQCv; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOgU8muW1x2p3fYCtPN91h4cB80oUIpGyi0q2CB4mH2RVR2K69JepjHhY/kkNL2Ic0MxI7Ho/1EdzdvY9oit/lDmRVrFFO9RoYMPYuOYPdJ5i+FAB36cNT4cHhIckGaPGuNsqkxApWrLVA72+AyG8Ae2i71WSResSqMst7Df5KUlFBH5cHEYJNJhu2yHm1UUqIPqUX/ENqQ1N0mepZDR+l6nvG203nxaVFlV6fhiZ8asc2h+CsN5tA4GxJZCWaRSz9v45+ia1yjB4ZB+yQwOFe0lJmjXhmtMds19XtzDqfxslHfmULW6hcUChC2YVEpha1szYbwEjSW0dev1pyE9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BD253/K701T94Xjw9dJ17c0sqoQX0TlRIJeudpfwkI=;
 b=J6XCijJ+00K+Ijiqy/9Bq4NnEsLi/R+AqGXezTQfLHo8MLvIuqoi+YIJFKduW0ihfKVnMq5F99EJbyXe47o42ngEz1TrjeL5JTGibHDb82mWTbRJzcDkaFEhf7x0ZO/pK58l9+aR0R8kOYkoYVW8RwXOP/0VLQdh78ODNAdNg8HywmqpdvmvUvrlv3XkBzE6c7dic2ceBprviesIfeED7ItlmkUEyxaSlFI0zk4lI2cLb3wY+MQA/JLbgYzbkxvPr1SDznw+qs34InMasvYASlD/4kIGA1u1ketgeQ1Ee/NHeaA6+SLq07TEKUzn2jL3tJ64Qrv+RTVaRZf1d16a4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BD253/K701T94Xjw9dJ17c0sqoQX0TlRIJeudpfwkI=;
 b=KOZRcQCv9XXz+/iPJGT0RWpXEOABqg1DIRhAHCuOpkMToZBkF6dNO4P88kWTxQmL/TT4Cz15JaUpPiwyzFX9NScB4O2S3J8d9tHFL/IaP9sPvDf6LY/w4K7iAnVRYrsLtDwr4nq44zqkiU4cX6JbwhJcmosiEIdMeGzu1o7yq38=
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by PH8PR22MB4097.namprd22.prod.outlook.com (2603:10b6:510:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 16:08:38 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 16:08:38 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 1/2] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Increase CAN max bitrate
Date: Tue,  2 Apr 2024 09:08:24 -0700
Message-Id: <20240402160825.1516036-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402160825.1516036-1-nmorrisson@phytec.com>
References: <20240402160825.1516036-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:610:b1::16) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|PH8PR22MB4097:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XL+XXSc01E7YuWbLAOq86o6vOybWIRHdNAhk5/mXeELP8l3cOKQqZ5pNotzkZJ7sMUfPqi6VigNlmVc/FYjYwFNQFDaq4OySpO9R/988vPS7dWPn/rX7eBYZJ3kzeLaI+Y9OuPT2Mfr554AEgIbA5KTKRjYR4LhLTDmnW5QNUWszCL4vft08XPgsHghX6aWnTIy0UAQHAmtss0h/bdrfoeAHAsxNkCOHo4hYkEWTbrLyI4Ki18y7S9P0g5ML1ziK3iHFvYLJUxwOibO+oX32h4EFE3svLDUxy8fq2zdM4U0DgwkLzLe8aigWgsGQpTipHW5nrOCWo8V1fltvShf6sNRUMFKuxLOwOT6K14XOE1RfjPv8ymW1TcL4JHY3v6tOlsOmlH3UoTUSDnaRUGem9yqEOCRYE/TGgfdlb5YkcJ87yLnospHwnGe4F6wc/gMH8m4eTBZtbSeHDbByyKtUCnVliqo6XBSylsHjiGaKrOhJhs3Kp3TKbA5ksmpmkiciP3nWOgylgNb/hRMSzjwcETSZa9Fio0ITw9zFOG3f30LF77sIi+R3bPIlimY/PW8WTbgCCwHrzJc+i9LbPgjflMFejpqqf/0pXomV3lbdihqqSzhtmntpjQXFIOxDwsziseWb0Q4oNkin917yEbyW1rz0sVDNr33lQQwM8TTR06dmJIqtSJEIpnPlqt120NUG4n+/p+haxf/qvo1gaShpMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QR7AZLD0Gf5lyRjvvCdlwzdEFt5veK+VWv0EQhT3xiVWi8gqIACqWlk8Jy6r?=
 =?us-ascii?Q?V8oaGCCm/5yA1Emg9UFE/a+rQAN91Jq5CCVuylSYfUfI9ezimD1NDFiQlG6S?=
 =?us-ascii?Q?onJs9ntk6P17EQmGPfOjgE+idErp0E+zEpK20PtIjh0j7iYRBHjQKKQNg6LG?=
 =?us-ascii?Q?fazo8Ucfnm5II/5iXZMHX/HuAlbMNgAuIIpBcviwcUUN7d5HLP0TImH7XIPL?=
 =?us-ascii?Q?McU/nUyg0gb7wwQ4KIk1RCiBiYAOeDsbxGFkKs+vIJhakcIJxl+KgIAOwxsq?=
 =?us-ascii?Q?jDKcS4KxYYH07G7Fy8tBKRgp2DGXPJzhEodYzSa6pAOsmpiqTHaDmnORK7ES?=
 =?us-ascii?Q?9vpB9PdIiHDCP9kzTJJK+HIN4L1D0zygi1QFUzM5ZeICWZL9U1APbv4mUD9Z?=
 =?us-ascii?Q?JFHdTc2ytoTkYK3zFal+froJaMdLceSVIJVtNQQB310OYhZhvsxDJM8YkW/8?=
 =?us-ascii?Q?Q5Z2eLRbL1MvHYYP1K7sfGrzB3LmPQVsemc2a2NtFqVFpIM1BIHL9JfROE9w?=
 =?us-ascii?Q?FTcS1PcU2VypVguToeKNc6lErKD728S5jI0OuYzBbrh4kEHUgT6/KZcnB5CS?=
 =?us-ascii?Q?Yagm8ATMbaKx+AGfE0CeTZJhzMe7LnDaCTmyqUY6IU2ajSkxU6QRv9HvtxWC?=
 =?us-ascii?Q?8XWCpFxkpsRD7G/OJ8ANsTWDS3TSgNjHsj+kMKjVjZ1LW0JfZVTRTQxZuS5R?=
 =?us-ascii?Q?Wuc7BxUYegSG8bOt/cLT3+8quyYlnrmt1K8k11sfSfOnbj3Vqh/6Fs4Kklu5?=
 =?us-ascii?Q?tL251YfPnnBtOCyZF2E4x+tlgDI7C4ebw57vejyyj86HxnRf64FtnQespjTi?=
 =?us-ascii?Q?BqgWEHrLMp9LnQa0RRzSVWKF50FQvNdkgFdqMfgoJyeva32avuPhtEpfjgI8?=
 =?us-ascii?Q?zleTRRvKNW6sQ7zmfZesuSy+8JaNLTPwgpG7ES47pj76Ut+/1LggFO8BQq+G?=
 =?us-ascii?Q?1Jnlqng2ucNNzQ1syNR3XSFCFJeRajIuvzu2j8mIItKnhTvceVRSA5LQbpHV?=
 =?us-ascii?Q?UnoJv0YTTL8v5APx1yJq0bUqJUVI+EdLBZ5ZK8+CjzIEcX0dN+2mRCRb/l8S?=
 =?us-ascii?Q?l/Xh2l2DFYc4rIGL6PE0mKYMkf1zNBw+MmlwspqYzogLTS3gpojCjnbYrtwl?=
 =?us-ascii?Q?aKD/qyBZzrXa8gbHOZ8FmpBb8l0uQPGEwmWni3+EARWb5JeEbEvV7ACZYLcw?=
 =?us-ascii?Q?brFfWVeyev5u9zix5al/Sn0H73eOGU2q2+fspFCyP8yWGSGtYLwSmiX1+Ewr?=
 =?us-ascii?Q?+dZr25aWYoofnxWZGTUwUjicZae1RiV3fOuEhF0PPWOONUc96FWlvNj5xc1B?=
 =?us-ascii?Q?EIwxkkuZ0MLYdbC2fvMrzLXGow8g12UbyZrRNv1ZMnzXjrhrHUbAp0RyZqtY?=
 =?us-ascii?Q?0wlZWG3THKcNTx7K3cw7BQZreFGOMha+mR8hS54LHu2VIr/QXBgc+G4ZnjGs?=
 =?us-ascii?Q?IkFCOETF7iC3kbasBnPtyu3WhrzwYm+EB4exw/IHi8waL9sb9l7JbGj3/wMV?=
 =?us-ascii?Q?9Qh/Ua1r/0iiRlT5sljCV+ghNhADe13loG1/+U1v1/2Ss3c2ZydWz/z3ghOK?=
 =?us-ascii?Q?PrTMhaYodJ2RP0u+rScjqiwyo5UH+UmXiE8Fs4jE?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6779b89c-6875-439c-c1bb-08dc532f283c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 16:08:38.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDPcuLMPyULa4zqT0FNTU7CEu8ZliFzPG2uCQMdyl6Y8nkV9g1geGC0gT2tCtaT8A1t394PsyUIKH9pkNBAbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR22MB4097

The phyBOARD-Lyra has one TCAN1044VDD CAN transceiver which supports
CAN FD at 8 Mbps.

Increase the maximum bitrate to 8 Mbps.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index a83a90497857..e225d76d02c8 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -31,7 +31,7 @@ aliases {
 	can_tc1: can-phy0 {
 		compatible = "ti,tcan1042";
 		#phy-cells = <0>;
-		max-bitrate = <5000000>;
+		max-bitrate = <8000000>;
 		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
 	};
 
-- 
2.25.1


