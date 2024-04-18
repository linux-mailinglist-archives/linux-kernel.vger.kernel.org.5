Return-Path: <linux-kernel+bounces-150161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984C8A9B25
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD841C22A46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83111465BA;
	Thu, 18 Apr 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UWFbh6LA"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2043.outbound.protection.outlook.com [40.92.99.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B215FCFB;
	Thu, 18 Apr 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446505; cv=fail; b=AXgh2RpbZIOwkgGyX17oCXQbSftptX0YNW/VwetasbWxhUqVc/bj1u6wbz1mcrpdBJoGVvubidtjbN2VTWhhBiZWThUEXvOm3sb5ib54W0fea2d6Ks/LAwgBweUPJPNQGknXeb6nOuxf9tdmFW3l6bJNOmccpVh5qpmj5CkuoXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446505; c=relaxed/simple;
	bh=ADIR+9Ku3mm0J06oief9gIePole6FIIpNQBUuR7iv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sOlsyjQnz4A7+7zPaHg71OErhMlu1bKU75Kt/wbXjCqcvg+GM82TP1ACAg7ni5rkvmYusRX90lZovVs8ubsK+LdC7xztUoPSY29nMx8P4uN6hLFhlO+lWQLWjDwjCc+OGqFRA8Zv6bHse+kSaijiIbutjxz0X/Goft2jJfMSWOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UWFbh6LA; arc=fail smtp.client-ip=40.92.99.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPPUqtHfxBwvykTZ7SYMKRHU/p8B1QqDQhyjHWeawruPSZsImS297y9fhSoIyVask6i8GyHuQGuWD7kUnXOH4TI+9SqkTPWgkOmJRbLXa5f20SmWSD4NNGoJ5DMPn2rq9N2dflrg7y6hTAQDsOihsDOq//PQcweluuuhXA2jnfLRpg8zoILlWVwTvLgp27euF/BgMy5QeyBqOMMts+xNrqF3jmh/Bsr64YkldTXs8CY4P6J5rO8iTzkwb5ckJ0qjGGgajVQx717iu/zAQY0r3jxlMezE1Ls5CF87Z5fcdz7Dlj7hFclVX46b1movRP69F0c/IavQYpBYx6gPhgo+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADIR+9Ku3mm0J06oief9gIePole6FIIpNQBUuR7iv0Q=;
 b=k/v/hAPjtBja4vqtacGEGHsE4OBVHXGN/3GkAZIe0smt/WNCIdJt1Z97cxYPWn9hx2GVBatPOSo+ZQXfhC13/lYtFxJ7kVGIuBBIGj19e8Xuq6hyXQOQrmO/n9JiLy/3JUtP5cGiJaPe02jqpcsT4uWkjYv9SqZeQkXMHisOO8hr7f6EPqDNvGuB/znxLM+MbTdO5RSmsxqLSBxTX+Vr7upcOkLZtyxxZcUIMjg22pSyswmnytSIT9tCflCY/puoiypfpytkF3dFpchTkFNoxFcOeN6pyXfcHN7DFYCCYs6uMVJBgLpk5fd+L1Aco8U+uQQH3WSKtiBXHNG0ZudQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADIR+9Ku3mm0J06oief9gIePole6FIIpNQBUuR7iv0Q=;
 b=UWFbh6LAsvJrw9C77BYvI9oWSMDkn1d2Yq5KVf0LSmdH+A9VRAmnRVrnO6xbKCIhr6ZKk//J3OsBBtfq3NSNbd8PySZA4rnen7mNlFAphYBEms/1wbsR1IUJ1vAFCIggxeAuXuyj2djrOAp5rNqg+SeRDmep6uUyyabH02PUis4AJmXzQwfRC6nGnAav1KHxhjH3zyxrs/f1C3RTH7I5iMR/ansnyRgH+dOjA9YgfvtKd7yReClvtvdIYNNXDJbINiRs6+/EGbNcOyymT1l9pHEwjhE8mvqM2o2sJJEVs6VzxwRwSxYdHzO6DX+Xe7VCIC7onPtJ+ccVU4Gf1FXGQg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYWP286MB2794.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:21:40 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:21:40 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: ArcticLampyrid@outlook.com,
	sbinding@opensource.cirrus.com
Cc: david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 21:21:26 +0800
Message-ID:
 <TYCP286MB25350DBE9597E25E48965360C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [jwE6gPhcTb0sa3NhfLg6PkdwPFVf/A6oZ6jeW8Mp8nxNcNKRgS9LVg==]
X-ClientProxiedBy: PS2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::18) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418132126.33043-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYWP286MB2794:EE_
X-MS-Office365-Filtering-Correlation-Id: 027096d4-2ca5-4086-fc40-08dc5faa7b7d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O6VGZfZIkViVrl+s79cV0bAQ2ldTl9vJI1QG9tE85M0Mardqa3CgZK1kicJJrL0hI/wREUk1OYye7FHCgBt0u2Es3ibh5ntxETXUrBUDSroM/efQK26hqpjtn+oDNNwSI9oAafRl4MBjAvrYB+8rpTviNtysSQyg11SSVHsfNdo9NE7KuiCPIlnPZHvWArludvOv17Bq+/k50lPXH2j29c7XYCY6aeXyLx6wF+o8LUn8yvbsdQ3/XIMVzSMmODyVGcy4J1EBm7DoMCa6v7Sco5LCSgNf7Q/zGYcp34ERPGznV0YAai49ZPR4f6PH2jh7zR/+et29cv1EzXJKaNM7xIG1R7G/QSPeqAsBpsOItoDuoujqRpqI1Cdt/TurPuBbKnoIsqFMge4ZW2DYF1ZiPR6cFDqPnIPGozOm6qJENqDdDfHhNNb6ZTILJv43ODy+zcJzJTsMz6q2gQvzVnW2jjXrYArfg5k2GrqX/35RIRxyjrS26qg3x33gBV6oISD4d/O6ZaZohjtqv5mR3YqPa9kx0507IfwgcCoSOUllRV7LNe6vtE+7j/EfdbwD0UsjD/krqUBXOqUSRrDDHvY4ZQhRIedw8PWojqznE1f/gsTW4Mxgw8Ii/3tAWmqvGA8nklVFmkl1GQZl3ycg/x52ITDxx9OuIEt8WWaj++FppkigpRECCVPiZm6T+VN/LdDHhW/8ofM1rcQQB33oiUjjgA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IyGO+JyX2ac3Em/K0/QtGhyAnMv5NI22IOgzTuO0U5XEWhiBENhxkG8ckO0U?=
 =?us-ascii?Q?MldbR/ew3qIlOb/pNAGUocveMqvpMNGhoNvZgr89GKhCDKe0xSc8OV1G6cbI?=
 =?us-ascii?Q?c9qa9KN1pmwjsaOXPSDY7NStFiMLXy/3Yo15iTlOOpFLGSTdzISVPu+aMkuU?=
 =?us-ascii?Q?S47j260djLxu3GobLG5oi8P83nJnH4tHG62Q+hdkl6EYDiFVhA282Tbpi7Ji?=
 =?us-ascii?Q?cMv2Sm0SeiICQ0yRCfG2+OaTkwVn0KHsHbm0mM7hqSqIOJIc0+9yve8ysN0t?=
 =?us-ascii?Q?ADspVaFjrt92814GO1PIWjUEwSIxfkRsW1sLMCef0eOBewc16Bvp4JD3sye6?=
 =?us-ascii?Q?zEL76lzJiP7QaMSXJk87AyQ2xSx35N2So//xqtbr6W/zdiCCmbyjmNqkcK8K?=
 =?us-ascii?Q?81t7bxxmpaEaAaiNlAr5Bw+sG8lX/vzcrIQTHLTVA5Sz7RroYs/ffii5aKvh?=
 =?us-ascii?Q?6uWKkRnimNFO2VJvB7x9tRs+bEEUMdHYoXO9aElJvH4hICNIT/PpcU3gBY9k?=
 =?us-ascii?Q?0MtZmctn1+QMiIbiLLnpUpdVYrEuupOpMbj22vzAxoYkAzkNTIoOjeksdirS?=
 =?us-ascii?Q?FMZ/85vd5daCwxof3G1/ZsdGPi0GMA/5wQUvg5atCcVFuEKJo+N62uvJbT3x?=
 =?us-ascii?Q?SrB1p6rYJqTtzJVqxg2d3YeJI1nSXhHJEX5SbzSyxEEBIR9rM0XIO+cfGNBi?=
 =?us-ascii?Q?30IF8QEaSqyjtumORxJdTtPZICe+Eb7Gv6Qn2EKA2u0ZLJJLJGlFaqgQ7q0f?=
 =?us-ascii?Q?P4WvJsrXINfofFFNiF0WKG5oOh/mpKl8eM3D5WR2OcpVUyFMnBfwxV1OHm0m?=
 =?us-ascii?Q?lTPkEZ8wy+/CJrOyNbBuABaue6sC1mm/+AyOhazG2adaZS0oZO/agjNse6cp?=
 =?us-ascii?Q?BVwPJFNz4Bb/B3fb3nwPxG+mVGOQRPjz3XxTFaa4kWuiR6IPo+VxkgVdH2KT?=
 =?us-ascii?Q?F/6eqifzDJn4Bza8emfLKxq4MdH634sEZdadsSUbihG0/wVdvGk2T7V/xZON?=
 =?us-ascii?Q?TJ0bUW5YQFujkNFMeuQk8seYV0+eab2jOHrUU0mRNmrN3A8Q6AzJhAwZdW35?=
 =?us-ascii?Q?ObvSe1+Y91ftVUlNB29EEEFuOVi40oI3TsJT+GRPTD/Ls+PuYi6HNdtBWWml?=
 =?us-ascii?Q?jqEpaP9smXAfBuqIi5UQT2tjBG0PSQxPQFWKRPnC3sJAHaNMecbdLx3cT13O?=
 =?us-ascii?Q?yndFLrWsfPa5x3+OZRu6CxwYa6IhORA/gwTlrV8jnDdSRwIJkk10786TRo5Q?=
 =?us-ascii?Q?LdcZJr93O+WjRuscnbH+6LHGSwFlVeEYulti/vkquQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027096d4-2ca5-4086-fc40-08dc5faa7b7d
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:21:40.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2794

spkid index is corrected in v3

Link to v3: https://lore.kernel.org/lkml/TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/

