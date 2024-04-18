Return-Path: <linux-kernel+bounces-149620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC08A938A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C15F282472
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07814376E4;
	Thu, 18 Apr 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qDdDA+xm"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2022.outbound.protection.outlook.com [40.92.99.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2831B94D;
	Thu, 18 Apr 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423110; cv=fail; b=TZpCQJP+LB9A2ktz/CIYeURhcsb7LxdEz2TwQaHQwAGwFEeRcCOG2F67m1fLEuPIFkRFTitEERM6m2F1BiuPR4msQMvSCsxHCDpkScUGAbnpRTnkW+jlANY0DOtxDAwBzyfhJPZfK3YbooZCMVtVcR4LOnk0UvmqOeYfQl+o3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423110; c=relaxed/simple;
	bh=3KIbvt/yBeEIQEagAtgbeKA91IPxBERr312FLDgPwtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zqm412OnLhEfzjz96DtSYgKWk32QwHlbWPinZp3FbmSuD4dbmSFMulT54B7dFn5jyS9MUB9hYHYt71Y71aj3AegsJeoNSgRLp+RuCMiao0HFAR1u2hkOHYdvANSGPvMx3nELGiKK8jlu/UwhM6zWQAPTO164YlqdHauYfvRSsCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qDdDA+xm; arc=fail smtp.client-ip=40.92.99.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPDKMBzTywU7SzFlRNHLhmq7BguFgWeCmWM4A77A/kYOVy8lk6j6nEA1jnsDytTqaZKYw7KB638dB+ofHb1FH4nD3aVraew3TA/I2ylc0KKomaOkd5kgeN7fqg9lShZsMmDotsJQ3Cbs4W0jtdIX8cXbRHTo0UMt4En8yfID5FAxbinyjt+Tv8xfV547ijSjYIRcdqlOEdmNpzifcq2fQFPlMUjBxI0jUGsinid4Uo0TGfF7dNJctJWKY6wlYZUJ6G1622J/PL/O7guHwzsuKUIVxPN0rknJ53mZhBjQ9okQbldC0OpOFSxX0yTF3wUEPVGdmJJg4Bv04y4Ls5ozuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KIbvt/yBeEIQEagAtgbeKA91IPxBERr312FLDgPwtY=;
 b=QUKlo7vexOydqXsNHVWs4PQIMV2EimiSJbE1giOtiwJ2WSWxt2+OVJ8fj43p208n+Bc1ktYQ+U75TgPUrU/U9zjKR1euAV6T95ifjo+GEokDWwJ+bFG6vN1l2EBTSOtrqCbBtc3YlWnEixWkO/HwiSdLafnkSVxDLCgPCh52BPrujb1Hu6GGOzxyjM8n3doumn4AUIs3+aHSqxskBBDEFqQ3Cyqik8UJWE0yudRxa7eUHD7SsUvw+BbNzMAkftzSh6xgpY/7DwVx8ZuUlN/yqBnAmDNZuDmv+06ZIqwwelrlweMCZfQTwmk6tcw23Q3jyXRX7uuKu57uOUU7LaNQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KIbvt/yBeEIQEagAtgbeKA91IPxBERr312FLDgPwtY=;
 b=qDdDA+xmlF6DMBJmtXyd2D2QMnFOZhBIqPHhiyPV28Su8W8jp0Ka8/QlNKkbmfixhR1HhXN4nVwz1V/mVaQDpSnaG7lNgXFfV9nmdU79sNT5RksOGACccK4GwqUPqprotPXoCsgHgjn7uVai5rVIoTtYqmbBV4isbSiMPQIko+YC785FoSiLQeIhvQts+z/zBOQme/7ZXC0/xpteEjz+EbVEMb6iHItjuQN0z+Q16sBQh+4DpIZQtZrB2SYgFIslkCT0WxYpiA1uzj81TD3eYDxJZ0KgOGgNs/BRf7+1Eoxy7qjNZEyUTqwpb68CGancWMPNlMbVBU/zDgm63mKeYg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYWP286MB2022.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:164::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Thu, 18 Apr
 2024 06:51:45 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 06:51:44 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: arcticlampyrid@outlook.com,
	sbinding@opensource.cirrus.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	stable@vger.kernel.org,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: Re: RE: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 14:51:31 +0800
Message-ID:
 <TYCP286MB253552395B3EBF5625586070C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [O0tY2i/PLt7oh+cW7hi002JnTTXZEhd64B/CVJRGWzqZ1uAiH/ed5w==]
X-ClientProxiedBy: TYCP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::15) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418065131.15033-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYWP286MB2022:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bf2ba1-e354-499d-ffac-08dc5f7402a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b42q9HloLo9d46i2pXmHbPOP7sAfyWL46zUOiV4DWe4Z1wigIuFu6GVvvVNDn2e08tU2G7FGj4gxOdtdhxJ5DmSQXGD3OWG5T6xn8ktVJpB6tx/XdDxhwo/PodUbCIIGmhcn1DfFK6nRsx8mJAUMfeBXeKfAAu/+a3r101D1zzLG0RJJIWNgxJHGABdxMc+pOCq1odnULVTiU2yN2WAJzfVT50CzTUrZfT4zgEGfi/qyVsY3JnGcYcHSaaf7E9Kdr/Qs6GY08uGINUyxjz5pTXcXdRjsg1Rsn80Z0Ev3Uf9JBKp5glbp70wdr60W61Z7awEfXu9BCf0U4OwXZKKawYUP9npMEYaDlOPiIL1oIRFwIk0dq/lsjH1o6ikfDOKkC1BNg1Tp/fLPlM2e2LIcu12s5kPUdDbXdI+qJev+a6q1PFKjwN20mUQ8mXU78/2+gGmhw3rWeVR4KkoK/fz1XsdTkKn8Ln81FUtx8toqJYZtkVLdU0e1oD6LqU8rUc9VgNLcTy4dUZQVIaVuHGjStJ0B1fNZeh7RD7OCZnzDTC/GHjD10QyGKkWh5Xj1UC6gNlX+5LQwlIepiOlXmxsvOWi0VLIGDg4Iwy8N5EKWe0gBLreGUZ+BnmJ1kNWtp8txHwCjLqYUcNyK/6266GYkRb6kxAHYhxBDAAedaWcY7isopEnn7ueuMAONiGdIMvd/syeEOuP0q7chpZ/saoZxsw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKWSBz8BNcbi7mMvze7FF6LpvbLstfX/FhDaocVRMjvUcI0xZO9aSFPE0ge3?=
 =?us-ascii?Q?7AZPKdo+nGXHPApLXmi9MnI94DAmtpkRHoRr2Z2+iqrJd5MeAY2RBZDELqPl?=
 =?us-ascii?Q?1lifdmyw5QDBgV/XwQhr+AxO1cR+q6uwGv9JtTqfUNN3OVwbQ2nMtfgQbJMx?=
 =?us-ascii?Q?BDJA2Unke2hbu+PF1MVHswayzzrtG/Ph6g5pTah6aro8O8FGpDpo2V81Uyd4?=
 =?us-ascii?Q?X0zq7HZ975HKdpfvs6bMfMEyjLePKaG5Qw2DHLTeFKIj7Abob46CRGMQWA5b?=
 =?us-ascii?Q?hF1ZKtATLRcw79D08RRhRG670Hj+8cjWWALe0dui1SPQ0CUVWcaV2R4CpA+e?=
 =?us-ascii?Q?KPLcNNkhfSbkKuNRP7B6Ho2xgbn/s27vvv9BSHU9bIS7lNVQcwLX/BGBTy1w?=
 =?us-ascii?Q?n7J/EagSJSBaefvnli3xKXI/Ft4bVn3Jw3U4UhC7Ny1Ied6Rbyqjt/CJVE3L?=
 =?us-ascii?Q?9AqS2O6KTT1Df27IssilsZ877KPpi+u2/X3jHcD/sKJQi7JDFNxA5zhIusSg?=
 =?us-ascii?Q?rpK6PbNBDoDKGQjnEQM4emBNeS1/S62+25leTezFl+7SYpKDnkNoMPbmnYix?=
 =?us-ascii?Q?H9r45FPvIuEZ6w02bHDs04cZSvrzfp2qk/aH1Afgu/WeUsfeA9980WdRrJ1N?=
 =?us-ascii?Q?BJ+CBdyxhJ89BYpvmUm0QAwR0QFtxZO2v2qZI9TZZbNeY5X1lWSqnv8B2WAL?=
 =?us-ascii?Q?QJMXvHtZGVZaBUu09IV8NyPX2HmnAdxJDn1pPTkOaqYs9KKGhBPBBwDAXkbr?=
 =?us-ascii?Q?J+9lXJSUv48UYtqTuHgJHd0Iy600QzRCUhyM3hYxDzREDpvwZ5Ml+fP5a1LU?=
 =?us-ascii?Q?OmE8XerKzcLoIMK3OVg/e6NQs7MBES08XEJecdG7srDLVpCXKiuz1m0vC8Py?=
 =?us-ascii?Q?s3FojdsWlktvkvWFDAIc5jhJP9auaUwu63s2Pax81h+Zh8XLrbdDdDAL4i7O?=
 =?us-ascii?Q?AM5OVxUMxROSLcz+s5M3aF6cmy2R/vx+WYzo9FBgbCqJ3mDmNk6PIR6RpTXJ?=
 =?us-ascii?Q?l3ssTA9RHRisKHcsqYusNhFPJp01rsNvf44cFQn7xUIjhd4s54G6EvdFI9S0?=
 =?us-ascii?Q?Lqa0wYbiztuJKq0fcijEgYUmA+uxY51fXlH92Im/dqKjst0BtPxN9NeMAKOH?=
 =?us-ascii?Q?gOm/7EgDW1Py7Bra+Oarli/qy1gKk+/18KYdMjiIGrFmRr7fpIIj5rI/4xbJ?=
 =?us-ascii?Q?8xqDhz/pCQoyC1Qw7+jpGr3t06f53pTz0J7gZc+llrapMjQ56Yy+Offa7n3R?=
 =?us-ascii?Q?NTP3NFU48D/st0JjeWTTpzcbkSQQHy8xhouxwcWWkQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bf2ba1-e354-499d-ffac-08dc5f7402a2
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:51:44.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2022

I've sent a new patch (v2), which enables interrupt well.

Link to v2: https://lore.kernel.org/lkml/TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T

