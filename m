Return-Path: <linux-kernel+bounces-136870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E13E89D93D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B192AB22E85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6D12DD9A;
	Tue,  9 Apr 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gvHfaFp7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2076.outbound.protection.outlook.com [40.92.18.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348D1A5A2;
	Tue,  9 Apr 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665813; cv=fail; b=H6Fss4N06YENJiLXPpNNgDizQiLSyba23i3/B+ogrz8RaykEgShfQQPmbCx7I+U0DAiFAaXYYwsWcXNYkJyfrw4oDqkJa3KFaYv+sFhTzB6cRbIORMjouuJ63krVOcYiDr+fg2X/cqkl4nylSI0CNLwpqA2aoexT0fxI02gjQkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665813; c=relaxed/simple;
	bh=dA75wik3hzNxUobCcL8mfl/sPXTkv4I+yyrqiT0yOSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tUUGsB6BcNkLP/mMnVOZA0XUqrBuibIAHW3KEHFmw+YFyu2q/o82ETFdT7/DD2nzffN+ubXUGEM9KGFZHdLqosiCnHpihVT8m4DIMtRZLgbayWifyFldfyB9krnnMNuEfyEf4K49hlzEua2RqQmG6Fp7nosqaXks7pZKwp3ySjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gvHfaFp7; arc=fail smtp.client-ip=40.92.18.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQ8ppOoGzWkcGieCAE4C/L0RFl1rEYh6ncqIHJuNaJ9QkmttTe/pPktIVc0YKQUyC6xJrRjIqTvr3U+/zbG9w2n6qhBe/7EAq1eAwUMywAJnaozr9MoBv0ruLKYNhyJiSyWJK+wCtKNI5zIEqi1Yzif+qtm1CIZNj6d7IKn1J2B2bzOZviM3lDhVRlDT5UXpl/ngUA2q5pArt0uJvAbtMjOulAB8yGB7LMGBvalFtAtLz3DWto5B38QG6uGSlaqUYf4FVtTnAZzaL7trLnwFg2qI2CGWhcyiJ72CG6Mn0CR89oAYwtRyvw4zT9uCDjclU9WxmLoIR8Ntyjzpm2nWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuJF5EMOuf8ejSmiesQFpO5UCeuehdqeLU2GEf9h2pg=;
 b=WtYu+i/EihZaFaYE94VkGmMFSDsSx6Y2A9lvlMnKLBrvm2y6e0zn8zz5bcbs4hydl2eHgTa2k6nzlYttDYg6D0JhwWP/zkGhGt0+JJmQihg+TmoQgzicy9FeBxBSr8iIB9m8t5OFOBMKB9yhBVRUHQ4/sVvEDiIjWoGVeprBE8uMmCJnFeoTqJEBAtZ7MLEZRj/N2mRBHlOGXbhRoHmr80Ymi2ZRw8iJmBVo4qEmiM0KJGZKTthASnOsUNntNbEBu2aK7CDkxflmqkjx8VUOG82MMuUgqPb1UVMKYENVNNKHFATVAS23gsh+mdU1tywyi/OmXMPQIdUVspQ2nmLTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuJF5EMOuf8ejSmiesQFpO5UCeuehdqeLU2GEf9h2pg=;
 b=gvHfaFp7wzYJUMmOc6LF0JIfvesnn5uYV0wrEh4DjRXol9ycBIxJaw+m1NnjUa3wjhUauQKpwRCAwCheLmBs3sFOTq7+QhuiFA5QD+LQ0VEocPs5G9k2wCp5jMqnXr/nQAL/7InJDq9UayEY7qDZM+6iKudIIFN1KL+DuA4zA/oXsn6s1zucabdjmDuBpD8iA15nieKH7u9Ft0yKL6cE5Iv1AGl6raltllpyIkj0frueYlHKdfkQSCm+/O7dnkfxEpiE+wZniDEA/NtbuU1uS+9bZyeOjsuA/U6EIS56uqgflcVqYJfUxJlHZTUfY6FiJWmxrkcNf8EL3g0AOy1CYw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5728.namprd20.prod.outlook.com (2603:10b6:8:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:30:08 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 12:30:08 +0000
Date: Tue, 9 Apr 2024 20:30:26 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: michael.opdenacker@bootlin.com, Inochi Amaoto <inochiama@outlook.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree
Message-ID:
 <IA1PR20MB49534DC28F291E319FC0130CBB072@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
X-TMN: [CwIu38956w3+lQGOnNczl+GRmV73qJ3yYIlm/RdREtU=]
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <mx6frhxuvzu7a3pbqdqgkgpstlxjedxcczxfwkfd5agkgostcd@s56xzbriytsb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 15deeec3-2cc8-4729-7b0b-08dc5890cb16
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tgAeT7rWJaO2QvVZvAf4VXEZvj6e2HzlNWRdms8Rx2xygsxwhGGx8LE4GgkTAIshDeYx3eELoEeBV62SzUEwxsRQR5Rmu90G9aY87xhzFCdpwE5FtVRXaCr/TGEjdUqAwicyKV8Gm2qrPwaJU6TIsWQCly+edDW9+jVkmS1Jai/PUdALcDH1myxRIxNpnC09oGsmJb8pJb2KF02sEFEyvnL2RWbUyCRBoUmJHxdU1AP5edKmvk4ao2dktl7oKG4WRaB58L0qs/ImCLC3rdMcURFNpk9CDkwC/ETp55aEbj2/L/tTjzbb1R9ZJk89QHTe93vNPg+2kHzN4WaB/0tl//Qy1LGMAgZcXFTE0OjZNYMTJIXZYz6bd/Bl9kHfRGTaxgIEvj5BiWiEFKGQ/3Z1mcnZzOBILdEt55PyEsHkN0wH8JyOiOpp9oaUrHuOhexEB9UlaOG4JoEMnZPOHVqHTH3Wvg6JME76IqOf3tY1KJyGz5u7S227Xedm5/qr2enFZfTqslBQgw4ycKhe9WosIFdngleaOtA8U9yaRcmb4cNpmUkN/0aXbKTTt2pYwIiI6cESQPoXbVxcyZ1jg23aqfU/5atmY/iNnSkS7E+dkFMqAK0NQZodVmb7SVtoEgbiOrZy4mJgDLh17C0/+Vt0FHiPvg8hWNOvztGrhDaUo/R9eioJE+EdXJjcTL+aJyb9eScxzfzlzXPCY00/2wSfYQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtoLpXHcebI4JOebWFe4KUywlRLkDGDpBOgYLVJ7QN3hvBlWta+ag2dNQKOz?=
 =?us-ascii?Q?MHCLXdvew9Gq3NCOMWDvKRD1RYIxVFeUVNEisXFt+zthaT4g0bkTr0tF3Pcs?=
 =?us-ascii?Q?o1vKzKxv9B+b7tuuX8ll3ALVKxRlAHCv9r/q+7b12xZ5fdhJJ//ZTPjzPlDp?=
 =?us-ascii?Q?27+tugSRjbe80FnkRhOe4TnigQ44/BdTutfft9EXMcthg3b2yXll1CDqFzup?=
 =?us-ascii?Q?iWC/TKLigZMeawxjrotsNhVr27kjo9yS5HY9iW1rQAo8bnGMvlgnccRUG0dB?=
 =?us-ascii?Q?8fkHgHuY77nnBW0eyoSjVWZUAGcLuNMkvxopQYPer/+bfIsz6RHohlOa8nac?=
 =?us-ascii?Q?d5WPLplVsvaviKujQoEACSVCpx0IS+OgLeLRYjFen92ZClJgAmZIbf9Go3Fy?=
 =?us-ascii?Q?jSc5TJpwZyfOmFBb0paYxCv8J0OEXIRjRnLR4D/PW9Mnxab2cnPpouLZuRAh?=
 =?us-ascii?Q?3gmU3aHFsgIDgnQMmIDxdchqk7Uz1KI2GKfKMlPRJJt8FMXHOrRgk9pVICTc?=
 =?us-ascii?Q?3STf2cqLmdUqOtXASAoiwm2080nzS2JX28cIkrZFgXTq14vNT9FE1GC4YDYC?=
 =?us-ascii?Q?23HErSqSIsthcVnCB/3SoF1H/nOinJcFwItuslVJkkBXcI/uGjJwUuswjIsH?=
 =?us-ascii?Q?tHEbKFN7mUdPPOGAtYAaQdSOVOPljo0dp+JJ3d9rYq5U/9BotfkGncFxlVk/?=
 =?us-ascii?Q?SUDZ32m194PesfuOjW+4svnH10jTIb2gMpdd5QxiU0k4sdy8AENlOYYX6Db7?=
 =?us-ascii?Q?dyFo6NZYU+SPmBONjF9tmuJ3E1f+UtWOJJkJuJFy1UXGTc3YZhO153v/gysO?=
 =?us-ascii?Q?9EjMqj0/cCs0vk7FZKZnU9fXCNEZ2ElWUsiHSdWjiyq7IWW4bKd9YWxAa20c?=
 =?us-ascii?Q?Uhv8lmGyNjyHPOfJzRVrcItKc71VR7XKN6qHs6JZsuz59ZQx9PW/5moBPy0w?=
 =?us-ascii?Q?zw4PXrnGHGEL+9Lk7PTf3xPWeNniOPanrczbZlliiP+Lpn0O/GHI8XkBcXE/?=
 =?us-ascii?Q?mAkjXtmbjXByxsbyvgdbb9KDCrFeLd2aCCP2EbwhGZWs3hTvSV366ajgF7u6?=
 =?us-ascii?Q?dIOMz4H6a9kzXjPG9V155hcQQUAll8aKnNS4RA50Kjx8AsK7u1yO5DiwuQko?=
 =?us-ascii?Q?k/4HJTdWEJ5C9cgeRGRT868wFQbi5jBGLP4L7aT9/5JBZFWVtfnZrTyfnUE+?=
 =?us-ascii?Q?kz/JK46DqCF+luZxZyaBdMILRlb2GC2P3Y5GzHNJEDMLqxsLVGL4eHv+yZpU?=
 =?us-ascii?Q?TeMaO9DijFqHp0Jw9OE0?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15deeec3-2cc8-4729-7b0b-08dc5890cb16
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:30:08.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5728

On Tue, Apr 09, 2024 at 08:27:59PM +0800, Inochi Amaoto wrote:
> On Tue, Apr 09, 2024 at 01:13:32PM +0100, Conor Dooley wrote:
> > On Tue, Apr 09, 2024 at 03:17:35PM +0800, Inochi Amaoto wrote:
> > > On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com wrote:
> > > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > > 
> > > > This adds initial support for the Milk-V Duo S board
> > > > (https://milkv.io/duo-s), enabling the serial port and
> > > > read-only SD card support, allowing to boot Linux to the
> > > > command line.
> > > > 
> > > 
> > > Hi Michael,
> > > 
> > > I think your patch losts the board binding and have wrong compatiable. 
> > > Also, the SD can have rw support with proper property. See link [1] 
> > > (need 'disable-wp').
> > 
> > [1] doesn't go anywhere useful.
> > 
> 
> This is my fault, I copied the wrong url. The right patch is
> https://lore.kernel.org/r/20240217144826.3944-1-jszhang@kernel.org.
> 

FYI, Michael. This is the right url for sdhci dts. The previous 
is wrong.

> > > I suggest you resubmitting this patch after applying clk patchs. 
> > > This could reduce some unnecessary change. For now, you can just 
> > > use the dts for huashan-pi (with changed memory size).
> > 
> > Why would using patched huashan-pi dts be more suitable than carrying
> > a local patch for duo-s devicetree? What am I missing?
> > 
> > Cheers,
> > Conor.
> > 
> > > 
> > > [1]: https://lore.kernel.org/linux-riscv/IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> 
> I think you miss nothing. Using huashan-pi dts as a temporary 
> solution is just because they are both CV181X series. Since
> only a few peripherals are supported, it is also OK to use duo 
> dts with local change. They're not significantly different.
> This is also the reason I did not prepare any patch for the 
> new board. (such as lichee RV NANO, duo 256).

