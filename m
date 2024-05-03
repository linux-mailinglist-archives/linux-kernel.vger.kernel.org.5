Return-Path: <linux-kernel+bounces-168370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924578BB7A5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7481F23D97
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E537B126F1B;
	Fri,  3 May 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="cZPA/Km1"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2109.outbound.protection.outlook.com [40.107.237.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E75BAD7;
	Fri,  3 May 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775771; cv=fail; b=ejfT0HaofTC1P1BLIxsU5eaEJzB6tAfkLwDCu6YhHD6NMXnFInFhl6xSH06sDjdWGNB55D411sI0Ln/XrJ0XniksFBMd3J7CQzka4zGu3aDRa0L9z8LEAeRay1kPDNvmwyrdZLYE+BLTNJhchtpB3G8mN7mRlu3PQ4+ZB3ZRwIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775771; c=relaxed/simple;
	bh=2j81aihRaJJB8EQkxt8OgDQWx9Z0Ta8cAFhuLNow3wk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z/FOAy3u2FfOWXEPLxiuvAWIxtiFDd8Y6HgJ0GEUP2YREa/V6ToiauP4/2pZspPUQuiryKJQjSwX9aJw2HtdGZ16Re1c5fmlo5B4U401VjxG8W95tNac/1gwLJLdXwdKCRg4+Wevl2JB6ybxE+8oQID5LIINE5EhKy4/Sgnc6kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=cZPA/Km1; arc=fail smtp.client-ip=40.107.237.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6tOVNJkw1fp/UnRVkzS0per2AmwRrZQbO8XNomMfLtwpZbSo61Jd8EK4oV/rZntV+gSSv9dmm/GcH30Q2uXRI6wakm69WxUERMqMmI5oNfpxqtaORB2TDLWTFNWvI1faGnLjx7Kx/smWRmMypx5d4W/BVglFVXUyL2lxnAnCILBSWseU1MR6IHsGTS/Z61U3oZ2pmYdp+qTpfp+ZIyRks3VPkZzXgC1RfyeqfXDEgyovm9nQcqjPTVGYZjvAkTC4XfzlgLBIBRhEG+0VhfLQBzQYM/ECaGZsGNn6gidatljeNDWeuWxEYoM2fzqb+WQrSBEhlUBoEXVjhZ5N9wEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKQrlyPXzE9+9vX0eWk6MgoYl5zBaiI9HuWbpwjvpqg=;
 b=ErFsGh5ucr2IwYX+Z0R6CghlJ+4SbTAecmnSFXEs5xZAtbAYj7aquM7YcXVh3G4SBPsEHsDIAm0k8xyPuqGdyQnxDE9gMEeAMq1+K7Y3pqxQn37cUrkTCWiTLT5rdjVBapKXkctFarecEtHsmgUQCTaVdFX5u7sKTVkEr3xb5iq9agbiVrp4VYTgHe7+yhqG5FPPbKBtimOP5LQQ1bFBWOJ+qPjnnNnDWE7/mXVYPqBEYrz9ViVGpttcKscBz+MCnUEcElBXSYQAM1ydd8Cui79nh8glS5QCvWueXG/22s+CFT1bWoW4ESDwpi/8gcxTjliMrsc9/beOsoYFXBCQCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKQrlyPXzE9+9vX0eWk6MgoYl5zBaiI9HuWbpwjvpqg=;
 b=cZPA/Km1T7WK7koUlbC4OdWsQF4BjbLQFzBaSpKynKI39Q1ubelvmwZghaIx0uQ4F82NwdTI8fPX+iaDiajmXg3IjfBVs+CGjhyVrMPqnma3fL5JPY9JmzxTvEKBtKt3cufs09EhDNIRVoclvqskfpy9zPD7VPkGk2gL2JA1FiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SJ2PR22MB5070.namprd22.prod.outlook.com (2603:10b6:a03:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 22:36:06 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 22:36:06 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 0/2] Add PCIe overlay for am642-phyboard-electra
Date: Fri,  3 May 2024 15:35:50 -0700
Message-Id: <20240503223552.2168847-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:610:77::31) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SJ2PR22MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: ef826664-239e-464a-a017-08dc6bc16bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|7416005|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vN2FOtjm+rwYaIpGFGcXMBVJZIPcaQWD6WxvAnFzWi77Orevsug+QiB9EwCg?=
 =?us-ascii?Q?ZPoQJ8e1hdjYzVq3ou5OAZi+IMYq9OUnbybVJiXbJidziEc7Ixej44pg0FTv?=
 =?us-ascii?Q?w7tkty/sE5J9qLk0/qbY2DrYHCNwdCwCcGdjAtOXJQaBe5IxPgT3fHn/ifyb?=
 =?us-ascii?Q?o1mzB0LRc1Ee8KFD7he2dJaWTU9iLBmYUxD3x9MaOWU9nHe+Z1oEX7Ud+DtZ?=
 =?us-ascii?Q?OUos1jllygXIk7kSZXW+79vSsRREd4eoPhS+6RqdOBD9u8qH+gdZOYGLgy6E?=
 =?us-ascii?Q?XfZy5Njk9ubKashT15BHLOZXaHHcAVvuutigajwioTr/fR9VTH09ba0c/Da8?=
 =?us-ascii?Q?GkKD9XEllWgWXpfGddqSGph9yhV7Gi7mciWnKT9+isNwDHw+eFwrLA7/bSws?=
 =?us-ascii?Q?6nvq5f0CRGkk/ivTSLXclAgeoYFpNwX6CbV+ZWDunh+i0q1HvAIIQBgdpYhT?=
 =?us-ascii?Q?jIGd/iT/K66Rc4dW87vi10Oq1Zt0AQrg7+e2lw2FLkqmJHwHgu8WftiM8LX6?=
 =?us-ascii?Q?CPY6PGDKE+1DLx/SJ6Voy+TtiHvVi3OtyIDxpczxMBYxKFWTncIItaE0+5CI?=
 =?us-ascii?Q?/aQccrA34b2CDVhXL1VYrvv6tJzgRmSQBX2Mx0ik880UA+AnpttzX/mg6CWq?=
 =?us-ascii?Q?pTVzHTKQ49W0LXluI6kmH6ES5qp0A9HPec3cPnzktMS6cCf4xozbWOLiK3Lq?=
 =?us-ascii?Q?E3uu9a235YugCbYo+WzhjRL4+h1fPs8GHWg70bh8v/3ya+OzewiBEfJNsV82?=
 =?us-ascii?Q?351HR/jnTY0/z2GszavS6tyODHBPNlDfiRFztJh6IBsTwnjhfqs0CLQkMF53?=
 =?us-ascii?Q?55Ub2GGRFDZTNLtfE78ZolR1kKlHf5DdACZb+mZYm5J0V5v0PbVmgvDoPS6n?=
 =?us-ascii?Q?LkR8tiLe+zbRZlrmVuUsCtgbCGUIxvleG85mu1bgVxN3FfZ8TIpzwLibtfxV?=
 =?us-ascii?Q?GUzJyBQtgX4AQBRJb2mI5gKah7Snah6TgbqX59xkieg/lODmKUyifCkr8zty?=
 =?us-ascii?Q?kK7Vp7kTQ3ovGyHm9mvfiMglhCejL4MM0UG4gYC7kT9rNc5+GLdh2eFohnri?=
 =?us-ascii?Q?GoGz78H9knl7aScW+HAX47Ps1VFYR3liqRFZsWkQ9m+Ua3NNMFY1ZHvz3jx4?=
 =?us-ascii?Q?OnBsgTEKrGNu3O4oMROb1SM+sQygbTovxL0L0pADjGKmvbROYMCAJqnCqIio?=
 =?us-ascii?Q?Xl4Hfcc2qFIX5qHtmVmHkHgp1rH6Cuib8fCcMTuZjqIXFwy4bAL2/SLa5F3G?=
 =?us-ascii?Q?I1hmnP5CFbZa+chgyXYzrsa6Tj7lUQAosbsi9VXC9Gzte/wEalap1FUvcuQS?=
 =?us-ascii?Q?1gcCRPEyXDh0GJkrgGe+iLhXsU7/iTgqH528WB2WkMu2Ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUQ8l1m62m0oc8icFQL+ccCFXOjUqMfyCVW9gJENRTFmLGH11RJ234XwhK2Y?=
 =?us-ascii?Q?jkhnG97Xj8VHd8Ma+bOoaiDFxH0D/yJqMOu7DTPoSVYjm0kCUvIALkrSUO7+?=
 =?us-ascii?Q?heZaVQ8k/FH52spaUf+JgyRersasWtmf0juBmkfcIPYp74SelZG9c7bkHx+k?=
 =?us-ascii?Q?MijzG8rU+LdRLcm80QIHcOzYjauC522yxlqWaMvTEGygu6S0BbvTzC4DoJWu?=
 =?us-ascii?Q?/RDu/GvveaA8g+ODL+/LJkRvN59fE9YE2BYfZhLReVtcHAmsN0638Dh0TX1W?=
 =?us-ascii?Q?ipqvRw/zer9iNOjLWxt1FJcAbw8ulAfsAMVHtrQNHbHJo9hT637r933xIfy5?=
 =?us-ascii?Q?tJTN5sslvHSbnRW/JeQ9ArkQ/LnIM2gsvrGyEW/Gh5Ux3RwQdIUJKi9P8HQ8?=
 =?us-ascii?Q?U/hqQKrNgsxqkRNyRBRBFsuxKtGG4AyvOVKiyFwr41ggM3KDLdRWM3tps5iy?=
 =?us-ascii?Q?fQuxMUDSmfJAon+73ewiDFFU2i92+Tca5SDv05kntKmPvqQY5M714tHdIkFM?=
 =?us-ascii?Q?U2DOUR0RXPy32dqKv6D5ahRYCYR+TAU9OwljoOPPz1sehYSGsWRXLBjdLH8J?=
 =?us-ascii?Q?7RD6/O8UKMvmP4D+KPYKrI/ii2nSG0HPiD8vL48LHdFZ3VBeOO0ZeIKqD+5B?=
 =?us-ascii?Q?9o4Bquo2s1ckgkEy/TlDuipcUcfR2LSYRfOiPP9SZqG2nHUGs9P0DvBFbUUl?=
 =?us-ascii?Q?p1lBqOpE4gSTnUt1v1px3c4rN1HyDBlggzWbNNcp18KCuykj5PZWOgtkHmp5?=
 =?us-ascii?Q?RZ3e2TI+ws3nXFwTlOsjVRXvsUX4RB3iKM/RWSeD0AB7nZf3bRxohwIMc9qo?=
 =?us-ascii?Q?sRdt3L+rLwu+RbhK083I/qrS0dJu/ZSsf+oDQ/USOUdNp7WrVUhb7SrEVT5b?=
 =?us-ascii?Q?5eHbtHRsOK1i0s5dPJ7FofFJF/eu0FTpFDXdq2EZ/Kj0cAsZ4eNmoTQ8944b?=
 =?us-ascii?Q?YwF4pWUhqa2SOX4PMkx0fhN7zQQwhKBzNjSS8i5eKucZELp4SISB8SaWCfe/?=
 =?us-ascii?Q?uVW0hI5mbzbHX8pvZUOZ+XTfb60XhzsauELIfZDhpky62jAN9n8E1QDAxG+G?=
 =?us-ascii?Q?TuIsqX0vpAvP4IkTo57rmMWyKt+RxUpD96zLeftxZGPbrX/R1cedK92HvLFd?=
 =?us-ascii?Q?lAz9q+VMCT//LyV5VkqUK29fOIbGX8AH9Hm70ds4RYdtfwnw4sKUih9ohP5c?=
 =?us-ascii?Q?Y96ll7t0xMV4S1XwEC3PzvMAGo8svjD62cPpkW0QsfB9YVA3Sho16L8XYU54?=
 =?us-ascii?Q?YGBNjq1BxHNBkasxU8swkHFmKBsjWr5O1lCV2YOWHIh9vrggRPVjLDYkxphM?=
 =?us-ascii?Q?TzLeBs5A3/HmfQyjWAJ3QEeyDkVY45saLGH5WPpTGry9jfJOxpkQqHjQ/SXW?=
 =?us-ascii?Q?05/6duDbr9ACjP9J+qs4N9GyuJZ+FVdfbW/NECiglTprhKBAuIyywsMGKglT?=
 =?us-ascii?Q?86pDwRUVnbhr9ENShBBIHBuSDZ6yYkZxUz5X4YK+FBfXTyOnyDnZutCDnBpV?=
 =?us-ascii?Q?Epnky/cFw00m0ahQkM5I2jr369WoeJIzHOukZm6gV18KMMCZGsfypU4ieIxP?=
 =?us-ascii?Q?Idbc0lJzlxTQ2DLLhogt/Tw7hb3440bfQbTjCv+/?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef826664-239e-464a-a017-08dc6bc16bba
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 22:36:06.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a21Dc0pq7uR+2OQ6a4SYINwdmUWw14xPOjm14v+x+/9KKQvlxoe6GjLPr9XWGBFzQnT3ooS0z3KoH8tqaQQRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB5070

Remove PCIe pinmuxing from the am642-phyboard-electra device tree and
provide an overlay to mux and enable PCIe.

Nathan Morrisson (2):
  arm64: dts: ti: am642-phyboard-electra: Remove PCIe pinmuxing
  arm64: dts: ti: am642-phyboard-electra: Add overlay to enable PCIe

 arch/arm64/boot/dts/ti/Makefile               |  3 +
 .../k3-am642-phyboard-electra-pcie-usb2.dtso  | 88 +++++++++++++++++++
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 12 ---
 3 files changed, 91 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-pcie-usb2.dtso

-- 
2.25.1


