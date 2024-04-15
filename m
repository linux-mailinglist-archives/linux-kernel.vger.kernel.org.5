Return-Path: <linux-kernel+bounces-145974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E448A5DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7A42822AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F71581FE;
	Mon, 15 Apr 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CwPHJQh7"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2088.outbound.protection.outlook.com [40.92.23.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080141C64;
	Mon, 15 Apr 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220222; cv=fail; b=nTOuyvjh+tl3W0NpdRmoNX767qCeTc9YbeeS8kUnxzCwfi00nVQi0oQSyUOgct/cHanvGss7gbBbad94LpLtWN2eC+CaMW4Hay0wlIznxm1PeGEl0Tj+IJr5dxSSSkT+ToZn5gdUmPgYvjImjOcmmOsYiYSorReLtk2L+pKhHXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220222; c=relaxed/simple;
	bh=TJEfDwkdmxuvosjNFpFaUy05O6/IiPaf4zisI+eps0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ofcPG4xTy7AtezU2iGJBCZq21CHvOBc76EvPUCmfASYbhruKj85I1Vz1k4SkeCuC7UcrSng5S8xr1W7nDmV8J3i8XGjWBAtkYV/Md/V8HSGf64K5rciFlhBCxWk/OAQ8Fk47mcrct9sSPgS1fpaKgpL8X9x9sen3qJPik4zcGzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CwPHJQh7; arc=fail smtp.client-ip=40.92.23.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUGMaIYolP2I234g1AgE2lA7dCsyNdC/L5f3kkcL4B0AH8s3mCJxz/9PTkR6coNXtUSqYtlPddJqvNY/7bSHLHlbOm6mLZ1aqUDZVk2wby+L2U/cnRCFh5s6srf5wQRIjOaK3aRG7bU1NFD8h0bAPRVE6eyIoH2HnnDrKQvNT9eYQtQlR8Pa8DnJGpdkzI4jUc2mtIXDmioMr+chob7GwRtYa32pjzeFnQw6A3Q8nYhHlzc+Skt7l2IDJd377hWAEUlAAOBeXykSVBCA6r13JfdddYI6Aq45SWfNLPlWhwFzuGnF14/U+rarTa4NK/tWlgorrzxCfKE+7d3W7kwstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpZ/26nglu0d4YPzsSq6Z8z4C5vSHlyVaMSZ/GuKj0k=;
 b=QL2OtL67pRy/Tat8Mn7N5G9NLM2YvW7cg+6MAGAA5Cm7j+g6op8tQFR5I3qu28AYfW0kb5eaMq85jnqBt+R4K5RVe/7NUAoGu+Lrd5gGM+9tyVlHcbZrA4+WNDufqlgU3Xj9jsbC3XeSdlohznXa5uQnjFPiw+DUWA6RlCANNxPBoMA+dsPLT0ckSWamvtr1ZR/acDBqkShSZJAH1s0SoJbUlUnv3HYo2VoK3MaANcHG1dzLnmIFnTX7y/O3I0vEAVln4D4p29ec6EZvwRNR8lCTp4g9wPUs0IOKhCrRYaDj6fSYCLA9qikakmQOT4bGHKF5RGoICXcR0uEiqlZ0jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpZ/26nglu0d4YPzsSq6Z8z4C5vSHlyVaMSZ/GuKj0k=;
 b=CwPHJQh7KawOu3JvuiHV1xJ14TZDbrI8bGBr41ikGDjBgWlyDjgIy+NChag9CTuBBajhh5vAKOGoPLInEpaN8CxVO4UQVLf3Z6pDcOXyGAh1KuqzVbN1IjleFR7M20WuYuvvel7yjw6t2Q6gW+1AnT3zTFk9KeTPm/L+H7shMfSNgyalQ6e0zXxtMLd62jzGI9cNv0oRv5N6ou9jlCeY5OVNGRXfxj+dFf0WMc8LRcCsiBTp3Uma4zgdJ+Vo9baJ3S5YlmqIzucx1Xe3RRo9P01SEBQLQKIGGaqxrpQiafFcVC6OsGFYhl38gMKsmd8K7QZVFJCpoGUYbSsdfiu9XQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ2PR20MB7156.namprd20.prod.outlook.com (2603:10b6:a03:575::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 22:30:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 22:30:19 +0000
Date: Tue, 16 Apr 2024 06:30:42 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Arnd Bergmann <arnd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sophgo: avoid open-coded 64-bit division
Message-ID:
 <IA1PR20MB49532CE01992005D3DA0FD17BB092@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240415134532.3467817-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415134532.3467817-1-arnd@kernel.org>
X-TMN: [JG1qWL3XE+S6RqK4R2MIUnAvUkOxjll2ixaqCFSUFp4=]
X-ClientProxiedBy: PS2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:300:5c::30) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <jnfq4evoodyakatzt6ozjqxfvafulrgv7jczyv65fezqvnbmx5@u4fuhm4a2abj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ2PR20MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: a4960e48-404f-472f-f618-08dc5d9ba13e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5olC0qsESMKhihHtM8uuERvBg1P4fz5K3exihcsmNlEXBKTUyCkswCs/d5iF5Fs4JGJ24TclEDnXAoXq2McCW6Ii3T8IhAiU5WER0MSFhV8jbZg2x4xzY2ENTg3bb5QFAaNZf/VVpZffS80TMBTExB5IGatT/Z9l7zZsIikZOM0nnC1GGBeVccoUj6O9DVDNA4zqAkMk2D9Ygkk36Z5LXpovEEeDe5mPnmWF2t478fUtEDaYNGpTQqOCYLbgvtbIPhWOVrQ9H5q15U8DWxts/r2pfjm3wdJJQiiEl/+WVuCyZSi6ODmkVRlyK1XjqCjlojYnI9IDvQYAf8ukezK/2wzV4gBAIFc5bnJ+XYKR/wx1ZC4wkVjUWs3KrQO2A1ljol1N2sFOIqVOxDIps730o0v93MNwz91wWZr4Wu2gMxWZKbMTsD4SV5dnozZqWIGvQ87sLArmDxVMLygSn0w77Or3WkY2/jAp0UouBQ/Kx2FUZBbudi+gln5C3Xon1IwKBxe7hHJHVrML9wBEdHzP35xMN/rOMp9Ixj8l31oUX2u4vQWHBUWn/qen/o9bkbTlRW6Y8bolEnqVPxhiT8sx5VX/1T5stGn4WpDxHGwRSFxDdEq8+G2sKPErZVDvgRovqITpuIKqP2vmGjNxmZGrr08yUO17qIxCD0pWkmn4UWz1ptizIxOkfi7hPM+369Oz12cM0kOlXSJvtzk71Hl3aiZJ9IBmH1cvng2+AlALxzo9ZeMd2/IenmrYbmdJQSI8
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PrdPKUuUwrnTHQ2e20omrFwi4M0s0K0hEcnDXMwhvCKjsmy3jKJRiCuGTLyD?=
 =?us-ascii?Q?21xymc+yVy8pcPkzm0M6AaqYP8SL0guSqIjTnjg76mnOY4mActzk0QissDMg?=
 =?us-ascii?Q?4N4TDfWst3qW1rropauYAThNAQ65LzvDAUcxd8FCty854Dt9XbbuB282+UkZ?=
 =?us-ascii?Q?BBH66znEFHfzQfRqc2jShs84mSt7ivQvf2yV+oQPUf7pmGf0Xc6Rtg59ftRb?=
 =?us-ascii?Q?mM4HGO6nHmDqcbhro0NPqfkdnYRsMFCYU/J97fFIG8DaMm2TGiW80srkg5DC?=
 =?us-ascii?Q?QhySkU1NTL9a293fHNR9lhjhnLQlImkbLT95yE0b74xU62eVzEK/LF0OIObY?=
 =?us-ascii?Q?rnDZiZbegbLnto0GmWLvgPyh1qlJ6DKXkRV3AJeRykIw0iUSMEFufXdGjAms?=
 =?us-ascii?Q?CtD7pPgll8M1iI8VQxd/kkcKvC3uBZi6RdbZDq51O7gitk+visJW2I4tSUff?=
 =?us-ascii?Q?oygB+buvK0S4vXcudrhGvWzp2Gj5/rpMzI9pzyhvF/gXzD9wmdrii8DhNyKW?=
 =?us-ascii?Q?a0fosSrLW1VLoI2/pzwoCTUcxnk1Xg3PGsqJmxvw6uYYqiC5R4X6xw0yLEBE?=
 =?us-ascii?Q?XENGnQllT9csC/t2npaYWFVra7s3DAUHbclKgjgNZ6Q+iujJhEHICaWT5g+I?=
 =?us-ascii?Q?io8/Mxfgtk76vDI/tM3ns7Vz5lrTWU8tTWjcxkNeVZGoDonCKEEhSgs4jQk7?=
 =?us-ascii?Q?tRpcSle7RbB1fHLeq8i0G7vrXaRzzH8pBtGJHlQzDFcCvPibUcuPn7wHYST/?=
 =?us-ascii?Q?zgDqn2pDUlUjJFkUWjPYIWPfmXy1Puaj3fy9LdMVhACa96ImNMv6SHux6jq7?=
 =?us-ascii?Q?vIoaLRAieRNXCz83xa1GGccctxbd8OcSq+SoLOEpeVk7EX8/MNIqcqzBqOEQ?=
 =?us-ascii?Q?PI8FKedeDU/lorlHA88MlaHp6wYMF0W+cWgZMD3xkdSgh2kPMujB4Tw9IyGP?=
 =?us-ascii?Q?eZB/qGBgnQayVMsfh5baZ4O0xAZvv9tw9wJpLSoU1z5k68D045u5MbCaloQG?=
 =?us-ascii?Q?b2m7t0Em/qTB2NDRywSH8LuSaKlewDPwtHTIty7VgLZuePYT5jxGb/O/Z+zn?=
 =?us-ascii?Q?YnOCVQpO158Xdz9XljIZk9pQ8zqlRao/eqJyb1inNMLO7zxEbMr34YKdlKlE?=
 =?us-ascii?Q?OhVzZx8YGwjQNuwXEiWyBhcavCU4ZuyMV+r9iWK2P0NDhRY2CRTgBuo0L+v9?=
 =?us-ascii?Q?7o2ksJrK57OMoY2wMUKdKamZJr4FVfevNmSuRfbL9yh6c+y6lWft7A31poGR?=
 =?us-ascii?Q?pO9X7reJAdOkCHQOxQrd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4960e48-404f-472f-f618-08dc5d9ba13e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 22:30:18.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR20MB7156

On Mon, Apr 15, 2024 at 03:45:20PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit architectures, the 64-bit division leads to a link failure:
> 
> arm-linux-gnueabi-ld: drivers/clk/sophgo/clk-cv18xx-pll.o: in function `fpll_calc_rate':
> clk-cv18xx-pll.c:(.text.fpll_calc_rate+0x26): undefined reference to `__aeabi_uldivmod'
> 
> This one is not called in a fast path, and there is already another div_u64()
> variant used in the same function, so convert it to div64_u64_rem().
> 
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

There is already a fix patch:
https://lore.kernel.org/all/IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com/

