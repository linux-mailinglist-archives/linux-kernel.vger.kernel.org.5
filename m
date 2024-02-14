Return-Path: <linux-kernel+bounces-64696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD7854195
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572E32902B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB74B669;
	Wed, 14 Feb 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tHaQvRcF"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2019.outbound.protection.outlook.com [40.92.21.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FEB64A;
	Wed, 14 Feb 2024 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707878700; cv=fail; b=RV5OAdD8YVf+nl7JKeUHOVMqIwn9GYfYAXTqCQAWM+j4l2HjIsITa4c0xEq0Cm/GrvonWBBl/NOyemCwe9oW3wWNjy/WWOXdeP2RVgQeD42UazkijKXGZDjKz9c+OOPVaIwoXzaIEIlQNnLkDNDaOdcHdyeLS4wwbEluRzgbSRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707878700; c=relaxed/simple;
	bh=FL07OiEBzAHCcLGwY9P4n956HkCfzmdu4g026jaepcw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YfTa4iFdBgh6UFB27HssJzWlg+iN34RThWYWzq7QzWu5jzsKhxjy1gkdKXW44MVuUTRToMCP23JKBAA5FziWl5aX/nG8xnlpTB9iZmMCn9EvjZ4990GQI4JW1b4DmQ2uvqtdh+S3t03TpGbQ1b3SE/GNQBFaTqdv2homiakQIZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tHaQvRcF; arc=fail smtp.client-ip=40.92.21.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjV3ubEII8KEtKcILPS+pYn3n72uTkFlxXfRVuJXosImuuP05+1nUOrxezM+/0Kk/aFI/HPvIbZyuG2PziCHP+LF32Ua3G9m90ygH6UzGr6yIljYQhtl3EDa1N0xiNwhDKoF/cgly724Yd9NLxuUdObLJQqjQip5smVCZP1xakI4inMV94hfTPWHCSPBzr/auJnbwuACu+2Eawzzx0ZsAF3yyGRhKg2SOLWBppTlDCDBAfR8Efoijit+ctkQRYhPT7XLWuFIizYeYnlG1Mbx6oF11Ilu7pvXKc0jZ+rxbxhGbsfclN8/cqngTwkCG1M37UojBBe2ZBlyQumfM4u+lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ2M+DysXepoDTezNl6s4nOqMkjh0T3KRNnpm9ct2ww=;
 b=Ni7xIAaT2Ake12gOzT8IBy2LE21nG4maEE0jDUXpPOtWFq/w+fYemsUGgoCnztfE5vCJ5F3vk+wolgJA9nEWHRpxmcHlB4P2pOPG9a46baD93yJep4DqKEanECWVxXGcN5D0AbU048gcaMSvhN6b0dS/dSr03jWPcvKyaRfZGIrfovmXTWdspPUxjOoipbTaIUSP7svj2LhsGmrNFMqbXF8jpLM2ZB7vx7hxe5VoLTUfWlD8K1l978yMCUawH9os4I053zVjTTTYhmERHDcak8WkLzp5VsPhYlt5yxVxpV6BGlzCksLZwR6QQdoCc1JT16sE9hhCpiIjsDKUn4UusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ2M+DysXepoDTezNl6s4nOqMkjh0T3KRNnpm9ct2ww=;
 b=tHaQvRcFp7RycbI/3eqcU6ImF8+eSaenWA+USpYRCYNj65Mrjw3M9UOkvc+E0hz7psNJRpLeC48zshc3YsM8HrmWzhwoPWglXJZ4Vn9WFTp2wzl2/Hq9vEQH2HQPXkrREO7+SLGlea3uJqvKITwqNSdpySaPC/6NhGcvimaO/pHgMJn8NIeVQlba4CpVjinSZrCb7WkVAPRuYfrhs1NtpZcdc3K3j2cx+cWlgHmWwlt4ehoLHFzP4dK0kK7Fd01CaWPaPBG7gicBzbg+iHLdDlnxwKC8m0f+gZs5oQTXnI4ycN10VRIoZH27KmiYbdrMkDJt6EpEIxcuGGO3cMT/FA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH0PR20MB3788.namprd20.prod.outlook.com (2603:10b6:610:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 02:44:56 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 02:44:56 +0000
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
Subject: [PATCH v2 0/2] riscv: sophgo: cv18xx: add top misc system controller
Date: Wed, 14 Feb 2024 10:44:59 +0800
Message-ID:
 <IA1PR20MB4953C0B48F84A3F3A500253CBB4E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [a1dOetuf2yDh/pv/U1jbvvsRBwsqn0bRMtjcw6q0sBjdm16znKuxYclS6y9355o4]
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240214024500.292723-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH0PR20MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ef5f2f-7617-4623-5495-08dc2d06ed99
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dqMkPWhRvajgHCTMt4nURKlQe0NOYznlHuQNrHMlIjOb8jrnRyEJDvTBs0uzIeFKIrbcijVGfUTi57gkc3mQywOyQFU4i9yNS5oEOzP6PGrdHFSZ8TOKN13PEBAaIBIROk2qo4AtgI222BQhgrKVsrQpHIrMmTOwwvwFq83/UH7nKN0bZc4ml6Wrm7WnOgAUl/d97Lh3MHVrP3PQsPKrg1pfKAETQYalDNF7XIqRLofwgs2jNmZoAScu38H0ASEttWl2J6ify0RXCaX7Npb4YJtbWHxQUUeMGWROLqfzERVYuD3kWa6JodtZuVix/nov9YjtKZXNX8LESqflQ+P6inEeUHByvLw6cOqFeDFdeqVcjpTWboUWMSBxq0zMA97c8emPhKCxFFslhuRPEbVh9mYBq5rYc9otayK6gLLOlC0XlgK0HOkKUK/sKNTkXJULTtbI2AkO325EvTYwW6fUQVbf7rnJ5tgH2Li5u56Y6sk+WOTW+wsVJYpr1SycYc85P+5LhxL5S+MlhbcovvRlEkKb57ku74f8aJjksZ2erxaPW72tmQVBKGGw0huR7c/8Q34/MS8GlRgqDWYKKKAa4pEqfQW/7hLrqaDk8wEcGRw4Sk+RV0r6iVDGexERuO+p
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4moU8CW4BD0A5huzYihGCtIuisHKHddklLdaC2p8J5dOyV/jOn8d57zg6mXh?=
 =?us-ascii?Q?yygtl/D42/96A/2Zkcsb1I+3yCmAkRD133dvmoEMpvyqn4NcsBgYTXfVrJUq?=
 =?us-ascii?Q?pF+AlPG9xrXmiVTBRB05cUfsfl73n5guvaLOEIwJ7N5P46W8lsBYU1fetuDj?=
 =?us-ascii?Q?E7uDmxc2cimQ/nzjpxTdGNOmMRlcoSb5DozyY8KBsBxQrfb1O5Coq/neQTVb?=
 =?us-ascii?Q?XF71ibxMkPX6fbNUMLFVONzLwXUfUQB9Lq3oHfMVMDPMc/XbUkn7k+DKPV48?=
 =?us-ascii?Q?bJHUp2japQ+k1Zfcf1WJoTQ7PdOLrjADS52MUgFN1Qzkhx6Ns18IuqvLpW8m?=
 =?us-ascii?Q?gqR9Ix576HXG3VFmgzbcxrLwl6vjRu63loQ7+jZos+3LowV7KnIzWpML93ZW?=
 =?us-ascii?Q?xWLd26CVWsBZCvBfKw2Y8+05Goo2Dxd01Jei95QNPu0GjS/wokG+QPoz7bzS?=
 =?us-ascii?Q?GeDqIB0rJRAqHHstkJ/kkKCReW0WMxTWR5PxnSnvxJOvSwW5Sw1+C8TAoXy2?=
 =?us-ascii?Q?Q6/MdSfm3IT4VOjuEhSjpcfDcUhcPxaJ0N2ScwcdDG4cPkS8nlKuMftMMf5y?=
 =?us-ascii?Q?TW1oln4K2tsvqVKzbsIzBlyOt+FC80dL6VJvV+0PCdMzgNeKiu/N6wqqVaTG?=
 =?us-ascii?Q?heoGRQQOJw5BGs31pVSK/oBHV4YvrEygD1lNkqci0gOQqzgm/zXs/m0xG4Nv?=
 =?us-ascii?Q?BiUN3iw1m/70LTQY28PTyWX4rCmnnBH9t1ZuyCNw6zIkNagh242r/HNDMzcd?=
 =?us-ascii?Q?7Zs643ffgsDuzCyXyD/j/dOE62xr+HZl72fQjknRHiTMuyFyquRyRjE/3W/m?=
 =?us-ascii?Q?gIp+Xl7WeF5mmiLMevM83FRzL3FYS64wBIZ7APioCCAsjHXArLfUPw+vzcot?=
 =?us-ascii?Q?q9E54T/vDmQQO0nB5n3M3+PO8Fa0x7b/NDU7ZDkNNPb48uUxm5gaSvCXATZH?=
 =?us-ascii?Q?6Yx4RSgHj1uo1j+aHzg4aGkNnuMsRuM0aKThur9nAc0vbpe/J/DGNSuLpBSf?=
 =?us-ascii?Q?2Ipie0oEbCKwGGrgliqYdnSJBAaStwf6hKAidgPy2cQfmM0UPsBY4OPjimLt?=
 =?us-ascii?Q?v6aQbguZRuOMQTwvnck/UAC+fy/BIBj56evWkaN46cxDgpEFvwb/+WL8F0dA?=
 =?us-ascii?Q?kEq0MFgVlQ19/DvaOKFWqWuPLS0BYOh71QpPkchVVHlH8fPW6PJa73IC1FBc?=
 =?us-ascii?Q?NM/G83AJ2vfoR976ahrxt0pjA7R5VkwECtAE6Nm5LnTc2z9pN3WTD4RaKVmv?=
 =?us-ascii?Q?QJJsequytakJ41gsaLoiasXdnehYQqQk6vsTUoZiRq1riw2I+RyvJPCacKCM?=
 =?us-ascii?Q?QCY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ef5f2f-7617-4623-5495-08dc2d06ed99
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 02:44:56.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR20MB3788

Add top misc system controller to CV18XX/SG200X series.

At least for now, this topctrl dt node has no related driver, because
it only contains register for other devices, or the subdevice for some
other purposes. The patch is submitted for providing potential common
dependency for watchdog, sdhci, usb phy and maybe etc.

Changed from v1:
1. fix linting issue.
2. remove #address-cells and #size-cells in the dtb.

Inochi Amaoto (2):
  dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X
    series SoC
  riscv: dts: sophgo: cv18xx: add top misc system controller

 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 41 +++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi        |  6 +++
 2 files changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

--
2.43.1


