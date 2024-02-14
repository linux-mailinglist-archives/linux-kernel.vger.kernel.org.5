Return-Path: <linux-kernel+bounces-64698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B678785419A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 403C51F23E22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84783B66B;
	Wed, 14 Feb 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XXk/v/g8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2023.outbound.protection.outlook.com [40.92.21.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5BB642;
	Wed, 14 Feb 2024 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878757; cv=fail; b=Cto7idk0eqWfkU7WcDYy8V0NhVuj0C3m0H2IwVidE4wDxXmcLcm6INMxQv557voihrBteKKYJs9zBQghMTEeXMuSJmm8xocF2oLgJgCIoZwqkfTkiHWl1F079CRLnANuyIQqmVyDZsNpu/79B5Y72p6tXOXPSvE8JvVfzsG5H/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878757; c=relaxed/simple;
	bh=OIMbOhFsCD9M+V3iY/T947GfH8E84t8lcFWZd8s+sao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k1+t8rAjiItkjKfySF2VIdov8JmyV/aBjP4zO5bc8LJN3rEJYggP60mL0m7HyP7JqHZ3dCoHKY0+1w/UQDBeCVEHtyVh3JlEGEp+dn+XIv9vFg2Y2LFRQH8Vvrxe+qVFSTupUuBhRHlymjdAXUTU3G3eL6OeY3+5iQcGR3o2g9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XXk/v/g8; arc=fail smtp.client-ip=40.92.21.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESn6CGUx8OIOFocFyf5NBfqpv1GsdivDLNS82LeqwkPjyeZxuUwSU8XG6dpPPoGMtPbooUps1SLSC0pHQ9ytfohm9KJYvggT4VEc+/RRerncbwHBH8oXxIYj8D0OYeU5HuKq5dVhJnw23t7IRxGCR9sWq2U0qOXTJKJkjg1h/f2PFgW8t+YiFEBaWqWOSa4F7+E0KIAWGd20q2gbjIw7PcT/tai+CP7sBmA5toyVHbpeYzJqJqh0vr5awxKCmSpZrinoohBlzXvgDh34bnAC7/x6WSYuqfDi571ZYSRnOpVQ0ZZhWbf933vmMLJo1iA8M+KbxOCfxGHVBlHU0RVLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94k3JfKWEls+7907kp1nt5YO2OSY2Jh6iUZUYZw86ug=;
 b=hJJYHTEZ8HQb6bB7xZR0ABTuhCELu1DiP30m2O09+00i3i4bhLXusBh5JoxZmTFSCif1BJkF29R9xHWj1qZM8NlPS8sHwxI0f96ejPR4oYKp+nhQEzJN+DxWPQ5YKp9CGg2g5IJv2siPxb3OE5MVTVk41c7LNwnXQ8MMxWz3ZPg/sXZWLiv90wizPSaIUc/N5NkeFMK/PkMvZp0B1sPFJKJBGd4bHSQzIz04341aX/cv+dfx99rLqSTnzsGWgCOZCtJoGoMyTGe3v3ivkBenM5pq9mgrtg21wJp17E+o2UaQmig/Rkrwl964UwKxCjHL5nnKvxaHmwFtqTNm16C8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94k3JfKWEls+7907kp1nt5YO2OSY2Jh6iUZUYZw86ug=;
 b=XXk/v/g83oUdQM0eBx6Ufv1JbrIzwmLdChAgP3YeUZXVZjATi50nnHPDMzh/2+PQ5Izf9+XcqTNlPUes4kJ8MeDWp6n3DzAP27BkB/UGlZQUBBMhkwy6rf3cOwD3Ta/EYO5f6nN6Y0ryW2A62lD6TylT2a6S56Q/ww+dHPgVC9+dyyjfQf4cZEWGnI2vcEe/s0rzPfNQWUh4f91NrjEQNeicwp2Yu+DymFWgeITt6dPKefUaCPjr2EnQDgvOwczPi3/qwIGaenfJT3GJ+z87Wjh3ew+LvAof9aFiwKAa7rh+lPEqB1bBXZ9KOZkCeJYuCb8g9oX0UmPBsrPSFm0vDQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3788.namprd20.prod.outlook.com (2603:10b6:610:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 02:45:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 02:45:54 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
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
Subject: [PATCH v2 2/2] riscv: dts: sophgo: cv18xx: add top misc system controller
Date: Wed, 14 Feb 2024 10:45:50 +0800
Message-ID:
 <IA1PR20MB49537FD67EC96F611360D3FEBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <IA1PR20MB4953C0B48F84A3F3A500253CBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953C0B48F84A3F3A500253CBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [DblxDWTvrU+sBLIxCjTPQhDfMPe4pwVMsxFfDfoysKjJ7M4FXcNI4lK42MhMVyiY]
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240214024551.292853-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2fc80b-6c43-425d-4adb-08dc2d07101a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GI8haswNMnIhU+Ux2mr8UbA37vczA/b1GaZCQ1Vi07zIny3t3U0vpc+Q5YbHtv+pyEQcDODgT0IP3IJAtJTNp7jeMNo04B+B/STDlYmPUfaanLX+DzV5Lu9dTFT0fUzABoltofM2XRRFzxK3gqgsvipG5zqV4wej8YxYhTkHzZX2A/6/P/TvH6oDnUf8WLwjjTRg8M79lLqfxREhdYb/ogIgp7WSKiYcN0YwZ3GiyWbNih34cnDbo8RGPIk4jztBgi32JcsqVImSLL7plO7G+Waaa5F0BFed0v2VAcm/abvi/NjMMJ2fma5GBY4MJTGrT9FDCLW7Uwm7r9efEUq8Q6xXH084Z2BpBa6hwzHn0Z70VSmarkviD7tpq7rIsyZdUaZL5HZvPizyg0Sf4BqJkl+W0+51sg8hCQ1Jk6Jp6muuOaA9qmrHzIP514z55oF9QRwlLpPmkWLIixSnGFwdwAN471GmMelcldnj9mltnKjn3KxMQuXHfEItHR6mUo+C/pB1wd4k6ZwaoU7AeLjzaLvXFj9o8Fqv7rjW0x9USzYpJASyZUfa8UvLSIuNXZGR9ALHBw5MfYqGENaApzmJJ4HGIrGU67KxuPwsQiihFbU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1Nx98l+NmUfbNlK4pqj/EHBqmYFAdIhF57DS9s/rr8tLTyf/JCSEVVKGxFP?=
 =?us-ascii?Q?9tl/Dgkr8iJgJ10G3LWCxtMUQjg9qaEJxd6t4z/SI1TBXQHce5IRhJ4Ge9SW?=
 =?us-ascii?Q?BRSAOSwFbE0At5MgYGuJ/gwCBszz/K865h02rBLPAyx2vn8ISJI9JGXDu11b?=
 =?us-ascii?Q?tFfqmbFN/MgnO1dLuEQV88xsz0VWGvQJAlfJo1l9ZapicZ0xH06b8ZdK8wjd?=
 =?us-ascii?Q?CMYWpjmZqKOQNhCOo98LpW36b3EuuiBBL6oAqjZkqWdreX6U/QjEPrpreo3G?=
 =?us-ascii?Q?8TMo4cv995qAMi8Gcr1mYzgLoGOt1bC8m26hesKxbGLqwLCZyTP/ZxNrH52A?=
 =?us-ascii?Q?2dXFJAQHPMA4R2rcaqSg4UDikh8J896LOUZB/Xb8hIzn7zlMBCoCjxSSNzN3?=
 =?us-ascii?Q?meY4Gjc+xpFwFnetK74g8Dc0btB7VGfVWCgJWbHgOfMsr+37u1HUHYs99Ij+?=
 =?us-ascii?Q?cQXE560wJmo0VEzq9ULLoohZyPDnxd1bgHpbTwH0CVVG6q8dWaEH8J5RR1R3?=
 =?us-ascii?Q?mFXAKEDQjMsau6+JNx9N1O7dGg75cZt4zsaNQIbiETKL2bXKzTe76tbern12?=
 =?us-ascii?Q?dAq1/bTdSpcCfgRlhlo+cdnU6/+UxtMspREqWR+eQiSUg7PR3NguQ0YnCtnj?=
 =?us-ascii?Q?TMSi4QL5WwlG9BWGvnDswXFKAZ4Vjgyu7+el78lIMrN2VhI/b6dljbKxmwbq?=
 =?us-ascii?Q?+qw+F/h+dLxxQpi6MvkASZuDZJq/LANUPfvkg/EvUJZT3PBO0EWpFuKlf5Pz?=
 =?us-ascii?Q?F613FeRXIAY+nPu+i/qK6sW7hPMCGOEOQZqeTkj3zSnHHfqKGxiIk5FTTp0N?=
 =?us-ascii?Q?5n4MKhDcMROWTBwUEKdWDH9fiMJB4CdBlhcTQ3+e8B+R4hqPSgnVLdGxzXYX?=
 =?us-ascii?Q?9Qy3wR/XNAU5rOJXk5RDZ5l9ocVfIWvLqlTpxaxIjODUVVCbqZzjrzkNM5/l?=
 =?us-ascii?Q?klDG3tBdQGHYAP6JO/q8wz+1Sq6cblwmMbIPqPywG/HtAhnsNTx1AOFP0FFq?=
 =?us-ascii?Q?7XQgtGkI3YH2aCPTAxkft3lx1twXQOM57irft32V0Fl4j01lc0pQ8bqqmevY?=
 =?us-ascii?Q?ko/QRr4TIdJqLR8b3wS+rGI+Bc0srdVPVMkReGN2dd8zfixCmEjBZMQ78M8O?=
 =?us-ascii?Q?Z0hfJa/Jo2GauWIwAoyESwFDcVm6qPtZC2x1pEQ+PPF4slt/FX09kasnNKln?=
 =?us-ascii?Q?wKxIa0fQADcjjVulCySJhZYUb8iy0UNQIbukc+GCgSy3fKKrKIRs6qUsqgya?=
 =?us-ascii?Q?yaZH+Dt1IqunzW1SzWvx55kbV2x1YRIYBBFR2gxz529DdSHr420I57y6wbOH?=
 =?us-ascii?Q?7YE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2fc80b-6c43-425d-4adb-08dc2d07101a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 02:45:54.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3788

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


