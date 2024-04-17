Return-Path: <linux-kernel+bounces-148380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEA8A81C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DDAD285C53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47B13C905;
	Wed, 17 Apr 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tZ6r5h47"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2098.outbound.protection.outlook.com [40.92.22.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615B13C80E;
	Wed, 17 Apr 2024 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352343; cv=fail; b=cDik5uYHaX1D4DzrE7Pw9kCmmZmyBZ1tv67u265xvd5XVZBGqkKa6jWxWEjpZN/5pv1d9C8xx05RbHmv79x9KlBxlGpQu2xVUtg6PkfuSMectBroTcVsfaQHeCOptgVsEOzxpcivEGEHPEWwHW+szTIir3KtMjewJdg3Igj4s1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352343; c=relaxed/simple;
	bh=pfta4osw1X1IgEP629tYYOhPC+QnqXjbmgjGVV9aW8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ux59p1Tf/WpgH4mycXIGz7+yiu+pmdzRfCoC4svyFQUo5eBW4zAUsh+ikmPIYAqPV/66U5lmJ8gfxWaHhzGhoeqQ+0hU1f8lQPP7DmfsuVobFZDOld983/G96qqhYUMzLY9bU7Y2BYaX37RY80Hc2suo+ST90QzVtq38U8p/FZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tZ6r5h47; arc=fail smtp.client-ip=40.92.22.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhM65pNmtZYoj/uKIgFuPvhYML/TIT7hubs82WKxKNdT7890z9pd7n2k+eG8kkA+21zsJYqon3MfJnMfBhaenH+8jZvo2ayy8bz2ihgddmedfmwIED3f5WrvKeNGejldbqNHa3Irj7lidPrrreNk7zC072UP7DYEnpacpaTSxmWIlUYBkqvFgUTWg9tem0nkSEi7L/19p7SyA6vEozpJ/jQIPEd9JKPCsy3mM5mHmhu1O1ud/UAvf6j7hvwuguKDT5BrxBFS83ty/LT1I8oma2my4aEX8ReOMVZ4zvyFWlSjNjggv4rm/3e3JRKSMRr/0H96ZUxFPviWYjxBy6yT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGU83zTtgGjBeJ6YbnyK+0PaFi3OE2n+ZYPsRVMOfbg=;
 b=kqGHJ2jGxnAHSZHdq3jR2G+zTMiVdGIdiDE41uZdA3AU1TnNlLaw6XxGED34LTdlcO252BEkWkodSw8tY4KivwHjnSxcrmvU9LJagJcBAFahmDqF4qrW7+lswaePGJjjlw1CH92gu4EPfvEJBf/kciRFBC1vxvzWIxtTdgTVgX8n6558v8WwUOYO0p8pbWiXPhETAOa9V+Nf+gL+UgdemRAcRqOaiWgG7P5LSc/VddZQh0W4gbSOVGLdPRm3faJP789uVJ9mE/XicXSiPLbAVVpU+mMZPou1WnKr+EbRRNyaDrcNbPkY5SCazvytYl5vPHVM2hOcZ0v5ZEp9rl5YGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGU83zTtgGjBeJ6YbnyK+0PaFi3OE2n+ZYPsRVMOfbg=;
 b=tZ6r5h47LP7wCn4RxtNYjQEE0amvqvbN9BZ1HTa22MchQuyDE2MRVrtcj6+PDqlnRu/1U9et+SbPnYbjMV0SMIQJ4qSyvJ3493tAxTFY6pc7r1Vc6IBaaonyIkDo+VHUr7h5UQ92s+Mfue9C1R4Sm2cMqsB1xRT8vwiP6KDWvYdgQzbGK1aM49wIxZTToK2/gfhZadjiK859vO7xqQLmJxfRManq72R+Ry1vhwe4GchF1HNALsYZ4mHS9UPJ4OVAuY8u2ZwH/igrihzW/E673uDM4vYnChY3g3KuczeTq9VsE1dZRfPi+1iAoHnMbDjlpkx9T4LF0BMHTw/iD/R+wQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH8PR20MB5266.namprd20.prod.outlook.com (2603:10b6:510:1c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Wed, 17 Apr
 2024 11:12:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:12:19 +0000
Date: Wed, 17 Apr 2024 19:12:42 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Arnd Bergmann <arnd@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sophgo: avoid open-coded 64-bit division
Message-ID:
 <IA1PR20MB4953FA5F47CDD0BFF0E64557BB0F2@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240415134532.3467817-1-arnd@kernel.org>
 <IA1PR20MB49532CE01992005D3DA0FD17BB092@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532CE01992005D3DA0FD17BB092@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [yXKWCcZ1EAqkot+Jss7Fce59DXgq3SWYNHI3Ri8wT4w=]
X-ClientProxiedBy: PS2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:300:55::29) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <zwbkhbsrxkecinkc5pp27dvpbvdz24xbnnoltnpxcdfy4wbh2x@u5jepeapq3bl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH8PR20MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: c6be3b4d-25b8-4bec-86e8-08dc5ecf3f40
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bpFl4aHMndQIZaUcAYQ2w85MUMbvS1n/u+noRpIF/AeHDaVb6UOOZQj8pt4OCYQTDlckViabhxLXh7lPpjIoQLRtjzCkkJiNgGIppiUJZj3txXNTBuuzTDyu+e7aKzUTidw7AiCFGa632kYJYyChf/85OHaNc8KRZmk0W08VYRDXrsq3YaVNKdF5yhRJWksJmfbEAM0CYOcR/ZX4UHUjgpE2skA1IfRjcQUpgHqMPzQXHEi4kJmlcsagwbPa5DJz1CqKa3a3W+TPCPHlDcHMWjrG0eqe+AKxX2em6E9DKNlCbjoLoxeAoZg+cXSpR0WEnI8MtWA6/vSRzidTEfOd6u4NwVJI+TFLOQzKiCnqm5Ap0/RDJNY5TuKQkdOfFqeFneaQEERCY1uzaY2/gP1bmPNKkvdXAmBqpbBshrxLHO1WZ/UjRKLylpAOkX7DzmlDX79EsLsa08W173bo2p4xBew47FeeuA38rHzt+R7bypB/tKF5gpcbRnswA4K84bPB7yQM7dRZnm7pomMsr77pgeaZjX6xif8KUGFE/U//juXXWYrngt4fuIzhBaFdkFHjMg1gDnaHjZ77mt8FW9PYAYLr7aMcUO/Pe8RXjb6Mgi5UxqydRGYoJP2nvPeQS39AaIsJk4RnlK1KCCX0nyMgMi+96xlTnbYm0NDNcZNT463Hc5WK0yrt0S9F7jQFCFXJrMvtFrW+n8av/63iH61kPsvtsTT5POyNYKBsiQIzjmKwiK9RGVWNeUU8QZdBPKa/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y8abW5JFN5K8BsUZDbpyHZs33YFf23FpLH7eqHjYGcmt+7VmWR6sTxQOaWM8?=
 =?us-ascii?Q?2Ui35jbwxqPAoYmDHKkEQM0csNC+di6nwCEuGg7AgX2+sEKW4YL4wFL6nbss?=
 =?us-ascii?Q?IlDDqBEQZNSsb9ixaGDP1kzGuyN+V8V/4iKtReftX/VweLRG06GzrkbwnMh2?=
 =?us-ascii?Q?dHTSYuC3OwPm4HFLpk9y8+v0fjo1p/Ojuv8MsvhZnEY0h6jlNk39dtqzzd9t?=
 =?us-ascii?Q?FaeMaLfd4Kii1MTrjyuU9l0I6JuGRGvoMV7JM8ezB1Eke+RKHJ/1pqvAiGFO?=
 =?us-ascii?Q?4EeS8H1xydSkSQ92YgD2ktm1JmXapzP6X96x7lItUI0qqZEHwGff86/1Pel4?=
 =?us-ascii?Q?I9I9RRIBs7Krqdk3gnwt7Mm8qCioiJJJ3NLXBawTmHcvqSgrxhQjFHYG+WBM?=
 =?us-ascii?Q?h+dLi8h4MBCEAQqxVIE5+z/zm2fRKcwKlMXHRJfdLCDXEX4Egig55y/kyc7B?=
 =?us-ascii?Q?G3ZC8H+oYeGQYKffXUaQbGdtOIj6JXT2+C+fMD4cwcbw8+YC+oNQn7IlKwMB?=
 =?us-ascii?Q?Sn7RdSGtDrjQZ1puyGHNfSyRmrWaSFNj/ZZrOkgj+Yv3VCz/mVAM5X+es8EV?=
 =?us-ascii?Q?1QIobwibia/QTl5GuiS4nDHJzq04qmJ3RtfvQ3GUtbTNHLBI3yZl4Uo0rT9t?=
 =?us-ascii?Q?Wjwg6xbb48y1yhisWx/geGakosMdVmLS1EqGwcLh+C3Qq/3UhBZrNSdRUFT4?=
 =?us-ascii?Q?w5HU7Q01B3d7g0Qc/Ta3Os5BPqzTTbFhFK5zxOmpAcysHqXtpasXljKR9moQ?=
 =?us-ascii?Q?a+Fhl89R/m8SewtXaBKhEz1WdprUFuiykyvK3s10tKHtdVYXvm/kN4AeJTzz?=
 =?us-ascii?Q?MbnqdqknzwGbBCF8Fu/PnqUglv9Xwripc7h/VpMson/3hUEJDV0+B2bsumME?=
 =?us-ascii?Q?EZqddYLt+Cx2fwU49BDyd56YnqIHQ6ALzcoawhbbv0jjR82z+UKFHOLEMW92?=
 =?us-ascii?Q?ekN/4N+KHEbjUljrmvKlpBfyN3d7Qotb4QxTVaL3fIOW9/uvvxcSeWgb0eKP?=
 =?us-ascii?Q?j1aMOVF8yDx9aviv5DzbYDKfctEmiDIREZ7lKt0uO1k21iAfKtVouhv1lxmH?=
 =?us-ascii?Q?Y3L+sA0dk8OAwtQMUz8wn+XDjwj8ZKUJRCSvc+RlGvc0zTlb0BV8Szb/4TEC?=
 =?us-ascii?Q?glqzJraCVotm6aJBXsgAvzlfI1SY2Nda4JkGi20vr+WgMcg7/30LYRQQnwS5?=
 =?us-ascii?Q?2jteM+ZNSyq0l2GBTCNSvXd/UBN/ZKZ3TvXdMEbexJK6B7NvQ4SgrzeRE56u?=
 =?us-ascii?Q?xElKlGJVYpRg1QukiK17?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6be3b4d-25b8-4bec-86e8-08dc5ecf3f40
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:12:19.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5266

On Tue, Apr 16, 2024 at 06:30:42AM GMT, Inochi Amaoto wrote:
> On Mon, Apr 15, 2024 at 03:45:20PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > On 32-bit architectures, the 64-bit division leads to a link failure:
> > 
> > arm-linux-gnueabi-ld: drivers/clk/sophgo/clk-cv18xx-pll.o: in function `fpll_calc_rate':
> > clk-cv18xx-pll.c:(.text.fpll_calc_rate+0x26): undefined reference to `__aeabi_uldivmod'
> > 
> > This one is not called in a fast path, and there is already another div_u64()
> > variant used in the same function, so convert it to div64_u64_rem().
> > 
> > Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> There is already a fix patch:
> https://lore.kernel.org/all/IA1PR20MB4953CB4FCCDE82AB25F6880EBB0B2@IA1PR20MB4953.namprd20.prod.outlook.com/

Hi Arnd,

I have looked your patch again and think your patch is better
than mine. So I decided to drop my patch and favor yours.

LGTM. And there are some necessary tags.

Reviewed-by: Inochi Amaoto <inochiama@outlook.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404122344.d5pb2N1I-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202404140310.QEjZKtTN-lkp@intel.com/

