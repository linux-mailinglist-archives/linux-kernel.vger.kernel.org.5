Return-Path: <linux-kernel+bounces-140415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506D8A1416
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF256285CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050D14B067;
	Thu, 11 Apr 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Mw8Og5v7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2051.outbound.protection.outlook.com [40.92.23.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5FE14AD2E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837593; cv=fail; b=ByH7aLqE3ILpi99c0X7T8CR47rAeI3jnZvYByJyX9+CyXhCdhTljf3sEWF2oy12AAe/E5vWExQkkOOEz7970OvIGVdz+YuMWmjqrefWbzurrA569l6dvrXDPeoP9i4WHRB81qkxa2JqMlkAp06uxLX5wDiFNiRDihFchqv08rVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837593; c=relaxed/simple;
	bh=mPx/N8rxKhVUhvWYM2HYh5edCTCX6ZRLCyHUbIkw/ps=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HymTt6mEf27A9JXsutBXLU1sAsTQNTS0pdRCJ+fUvKt3adtZYBJ0iNBHap9w7tJjkzNk+B75N069T3r9buW7wssWN0gH4oH9PUVJ5T2HwiK2KBFu1L+1NLHHWp5H64nrN0XKXGEc9qapghoU01UYhbqKs3Dqi8Dp3Ew26KPJ7SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Mw8Og5v7; arc=fail smtp.client-ip=40.92.23.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey3M7S56M2EBbzHBLV1WctuoffkH0m0n8tDad32TwnZNVKHmcR4uXn/5ItMxAr3NBmqSohXU71TRtx6Th0SqBCQ1BpblS7lzLEoByXiKVLu835ORy0MsD+HEnBQGIe1attazKFQK2rJ20FyKP4jEY4ZdQuhZnM83wTv5mLV8tU63dBPwAqRY44pR+nvKCnOcuqgSIvCoVi6VgjDhVTi5RIxhaeO8rHXQXyMOPkwG1VXOhJpiagTtYJnp2IwoVEky32wopIVPtIEKzkDMB9Ry8E8WF5/rxb6SLHXI/UhUY/bJUNzIGwbmRFkFoLdpoJsW8zi6OgGsTpQMKjFvdjI/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPx/N8rxKhVUhvWYM2HYh5edCTCX6ZRLCyHUbIkw/ps=;
 b=lfo4Y49rfY5VTYpS4jYHK463SCda2vt3AbfV13rH9pS1sqsn913aJ65uEkfN+WwykANZ/ymmAs9rjbwtRP+w28yVeWB9bUvN40SrqzuUFu+lTqf1lW7iaD9X8Lv+cO8k37hqkryPIlPsKTXcFuvhNNf5ym9REx26p9J5PUsqvhJUKzsD/ANDVHdQUX8D2nK5iFXeI6xZRpo0sMDcY1HlSmgYfPhFt81aimaYJ4If68RiraQjJDDeqDpSsulZUoDZy4I8Jk2A2iuTfCKOSpcX2T++s638ECLO9erXpA8U4dYQyFzqHQTSfpT5az/1m7+tQnx65jg5vL8f13hBKB+Fhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPx/N8rxKhVUhvWYM2HYh5edCTCX6ZRLCyHUbIkw/ps=;
 b=Mw8Og5v7yc3NPy0sZfaXmo6dd1JHSvfI+wE+kzgqzmeKcbT+XJKrcou4LJPBaW+o8ggzEqaSy26gvRLQIGdeKKfvYvkURNYsMb4DHqISZmTAxGPRtB60gSOVl6eYdb9tQxH3IaECMzUjeL1UMK/GzJcvEXGWfjNfAa50Si579gSAqTaohe4PkIO4htDHMdZUSUgXDMEJSCKJOff/FP4MozuM4ef7ITA0kKXqCqADY6xvpPZDHb5ov02cc7JTSt81GDzQaJLxjBdAgQNdoD9Bg0lZeKkZatIIrnI+2X++RmuPg+YgtCGfSHHtHVoi0I8v7QE8lybGlC3JsXq8DL1oVA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by MN0PR20MB7552.namprd20.prod.outlook.com (2603:10b6:208:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 12:13:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 12:13:08 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Sven Joachim <svenjoac@gmx.de>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH] riscv: defconfig: Enable CONFIG_CLK_SOPHGO_CV1800
Date: Thu, 11 Apr 2024 20:12:40 +0800
Message-ID:
 <IA1PR20MB49537E8B2D1FAAA7D5B8BDA2BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Y4DSgkAXPTHFRrqTMgUqInKXDcsgxFiz8jUEv1ffrF0=]
X-ClientProxiedBy: TY2PR0101CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::11) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240411121241.766521-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|MN0PR20MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf47366-8700-4f74-11f0-08dc5a20bfe9
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3hNW/QzN4bhXInBglfd1vi3ZicbJMk2jJ+lDt3Kp6+ICYsfDmt0dFPKKYQm+flPC2EVFDKQV1fvboymWKyvq7pSkaR+Rb3jDp/cRGtDZFnernmtWPD8jicr/8RAV1x0BEUxFQo8d5IoWabnNMvQhvh9lSQ0SAyqHeLAYOlOf/HXFSaZ1jqGKE000t3gbXZVT28+Zq36twHWRLv5FRo5QbbjiejoWrCSSkftqSDMy7cg3Mi/UwNs8FHhHu0C1Wx0AmYTUdRXd9sI4b8mkygnnS21RzMwxtiKXSoNG9uI8tQULCKieM85uxhv0HOqbKEGlCNMlARXXT43XSJ4HLXEdZB6pBavDXk3YmDmLJVRLqGM6zpMb3Iw4myB6Cnzh1DfjaTUjtryxQv12keUi7mjH4pNlM9fDcNsfXG4E+rGkbJEVowDvl7vHU+jA8UMQDhyYDbRSfi6lqaJLgFB4iv3XmG1EUnu2q/W/YEF4Uqi3OYFJtHNsTgGXId3brdu8qGyunV2TF0gQoYyxtKwFzmFTj5W+fCyUqISO4EkfOinjlgYHL12NmeNDO8u8eYS+w7TNdr4uKNAl5EmvvTIuK0Y5oURpnbQaNcPbHyPYRFXSg0D5Y/hBYJxdrD/FLefdxlZxOs3MsbpFtqbWLaKWiCeDy8GUPrIh6dOsgbcj68sIycmopqrcDGeA0uiS00PJob7e5tNUpZreSpJZW69GMlFRWo4qSPhZ4TZU7RASCU1yy1fbltsr9qfNqk56wwMHF0lStUodpTkd2OiKq3oaiPZ5KKa45oETftu4Xk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4YAE5qHL5AVldFyDlLMSgPNzCDGhXYrU9T5kv7ByZ8ywtbXTuaIQl9A+b8gfPuTloHkC2hsZa7U6FBe76LCj+kJlXSkIueTe50GtsgIEdwsrGwwpcOX87ZoPa3HpZU3nxBY8QU7XB0yVCdG5Mm5sn6Lc51O+uDRS6pYF5r+/LydWboEv8YXHylr4z9rli9AAPQbDkjTk/BH5G2b/Ob/UdKAFCILliQnxZlpN73xsq6e0co+hmipsIQ82CLyBf6pcuYdfYt0XsNONtZYs9gYUFNyUorIkBDhC1gtvUOsFAedqNVWXs+I0EOTBoqcFLqzgQQQHyLXUbEdhPfuLjcDohFs9c3q1gk0KwshRM/kz3RMW/vrWqP1vhK+W7UKNltwTdD3S9WTwcTA9SCLzYwK+dWZLTrMz9gFD2I6Z6qpKumSwx00HpABnIY7TJttFtEUZMRkOnVXiyHmD5ExN08j4G/fzl7pty7h0ATscYmPm8noIicu9irVAp7itLbyGxUZQouocFcBmtpfJLs7qRFNVI6H7lmZGoPNGV1btRhhqp8HssOHX0eMN98rc+zLZp2Mn5kSbIwt2m9TW2baK6EXkRDmJnrxqQPe9U322MMnMUhyz+K7rVb7xidIR0LIfbkgK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEnY8fkNlBEzp1wtlH8bS/TOHKRKeoL5XKcREOURK7ebX1qiLqq8SpHkxmw9?=
 =?us-ascii?Q?ONkFgD/mxV/aw4Ze3dN1pkZj2quj0Rr0hJs6WArgfb8Igb3W7QorSW1Icsij?=
 =?us-ascii?Q?yxdpSrs5rsyhg96U9pJivdYmH522xK0IGXlai4uoXKYCbebawiHIRaFmOrKA?=
 =?us-ascii?Q?jTGBNOBHngHvwu8Z3R6mlpFj1ZjLpjyRCGbAOmwiygnrYkK8jEdyhEMWBHhY?=
 =?us-ascii?Q?ldkIU+QGQHpu0iNxnMalHjbZpccdQYei+QuI6shTv+bkngX18XsiF1HX707i?=
 =?us-ascii?Q?1yT2TbyOOKl0/EKLi/am07dMygH6+fxxdsqgcZbznWmv6ITadn6QTyMWVV8Q?=
 =?us-ascii?Q?Wx1fndb5+uEHEjLm8aLvUhugzcLG1cKpn1IiZPElm7wgii8o1p1vBmCjSGoV?=
 =?us-ascii?Q?gzS/BTXgPNPCBl6BcnLz8Nk9H7YFAUIQqdpn3rCCLs6ErfYtd7oK2L432erH?=
 =?us-ascii?Q?hCQPZD6Zii564N8zLtYgWL7v7Bp60MAMiU1ByD2ElwrU5BVXWRz69/EbqOrO?=
 =?us-ascii?Q?F1gr7PHMcxKWdgF2TULLyqDkCp0cmHcFscthExGIl5ipzEnD4PnF/QsgvTft?=
 =?us-ascii?Q?2kAr/430k9b/Eqx05HF/0hYEmp+nCHkH3Ij6l+OpGwP/wLhqxueZC7jIqBmq?=
 =?us-ascii?Q?yjq5/+tb5I3GOTxX9juQZZ1L0XtENeZvwk3ORDFuYfVc44CVOAwlFR3C5hCI?=
 =?us-ascii?Q?fFm4Qz2JZO5V2TvL8agfJblpMrx7evuwkAOt7X41LTQVlOYEqP4n9J8Dt5J6?=
 =?us-ascii?Q?sFXxw9gBNwXOlN6yzm2TwPOa7enTMuRMqdRJooNA6/rCdSYicw1oA+yAmyox?=
 =?us-ascii?Q?ziqYk63p3KLaJKqAhgkxjgcZ6gMH+8i7PzXyXPAkRbpm9/jNz33YU9Ca/dtP?=
 =?us-ascii?Q?2SPlzchNRNl0v844b9vdN8AJFb8tqiuOmL4d/31HwP2b8cNxQN4u3oLV1mPy?=
 =?us-ascii?Q?7MiqlHx+ucUHFXRoLMVfzU3/p8upcxnwH8yMEOVobEQZ5XH3exp5If2IB3hm?=
 =?us-ascii?Q?0EWjxPwIfvxyNiW1Ddui3Utl57AiBP8PeR3PMZ2Bs8ejbrSYG/TY9aVTgLYx?=
 =?us-ascii?Q?4rnYv9KscS/jbVcGfZXgNK7rOkfQX5XYRiBD2/lfEqiJm9LnDUzt95drFcEm?=
 =?us-ascii?Q?TnxJUhy9urZFGOYIJ5VMrhQwcwdt1oohrZ0fSiBgmJgcCaMepfx0/EFA6g7Z?=
 =?us-ascii?Q?CDzs2zzszpAiNGByFAOI1xlJuQMKV5G6MUHuqTZKRDfpmL+if/4t1f+v9wNc?=
 =?us-ascii?Q?v4Uakx6x1k9MUdWh31Xw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf47366-8700-4f74-11f0-08dc5a20bfe9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:13:08.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB7552

CONFIG_CLK_SOPHGO_CV1800 is required when booting the minimum
system for CV1800 series board.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc0ec2ee13bc..8c8a77f8eac2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -233,6 +233,7 @@ CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_RENESAS_OSTM=y
+CONFIG_CLK_SOPHGO_CV1800=y
 CONFIG_SUN8I_DE2_CCU=m
 CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
--
2.44.0


