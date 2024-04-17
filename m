Return-Path: <linux-kernel+bounces-148753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E91488A8700
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9D0283AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E5146A95;
	Wed, 17 Apr 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="VxzZEGHg"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2091.outbound.protection.outlook.com [40.107.122.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D0141995;
	Wed, 17 Apr 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366406; cv=fail; b=ESkKkbjeTnF7vPPLpQv7FrDSfbPkERJUj3SlAD5tq5yR3aBSOLRajep9E0NcuRraNjUmUXoQzlgHR4fJVUpWlxBsjr/LgfnS5ZssrYabgEcaogQ1UKCjFrv80ilnzRd9TBhtBuPLbKV3NldVsEXktCSnrFFySpRnVNAijMGUqIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366406; c=relaxed/simple;
	bh=odwy+n4Akagy1pgcxT8BQDWypceEtA4hBZA9vnwZkho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNxIERl7E2w37/Aj3jBm3MfKsOkh3pSJNQFtz312GRpfsjT9LcwQo1twDHhC5kZFXeDZdTIQ8CWRYVVPPMiKtmjeyGyV8DPgHM+5TFu19oEbkwDfvuEqZOgXpOUzOxrGiVZ16SIlmPzl+pvMTF/I130pS9q6lvqsN0NouvKj0DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VxzZEGHg; arc=fail smtp.client-ip=40.107.122.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsvcnoFAAEPgZsUEFbeWvSz+7lzVyHxxxiVPSJHpXIkvYi5AwlQGMDowTbJqsKIsQWuNhoVyaEMkW/XWX43igYVvnfm4KhnSCozCUdrFem3SkLfQ7q8K22PacU9CfE/49IBZ1OORA5xrbCAoNLgC/A1Wh2ERsR6ycR50vVR95nmexuDFneP4AeWGksuTWOASpceXLGdDY46EEE5cjPSI8Hh8MLrT8u9VYekjOVMpuk1PljUguoGIbgMUod7FAAnnnpIa+6BkeJ8Pt0TOT5v5IPz2XD/BiZ+WVotSnOQdV3NMdndBMiLhKXFBQAsbvsNKLLJpRlfOCxW4UbEm2mlXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK25UUzvQusCoRdtU5HVehq/ur0HDodN10Y0Mmo0bTM=;
 b=SqTCFBnF2GEyp7tS7Mkar0+N8kbqOrvxJxvvkrqeRzjm/rpzjtv6mzrAJZV3c2Z3PeqQ+OtTknkHRSZjUJ7ANvomc+3sK/ith9PY5QGAOYOLT/dPKfYkHSifuwJXsHsuhZiGWvp7TGSgICvISAlAfS0pkr7P/njhHt7ncKH3plc2nAO9Fe4ZNc/C04UmMJSHAKAfM2lHWKjfR8+T+VdV/EqY4/ST+PD6UeEQYpdcvBDE37VO+1Vdv5J+AjHg+K3MavZvlDDbYcW3kk8ew0JDuljE09GqJSFnLmARvCnYS/fsOJeHf0yBh/XqGAfyO1wH9Ttvly/w+H2jM/jh8uYwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK25UUzvQusCoRdtU5HVehq/ur0HDodN10Y0Mmo0bTM=;
 b=VxzZEGHgkoHeNP0X6hnhwtYJ/jQ5nYUFY/jAU5DZUDRBYjrJWLN7gUfYhkUYxW2aAchxU8z/O6bZK7KJvIsJMYuRrAW0Tfd8czNnhzKs432FyV2N81AmxQgr6hlReMHPrz9d0JZpynHPdJ3487gHzXqUwlFuRfH6iJZP8LP/OH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1992.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:81::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 15:06:38 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 15:06:38 +0000
Date: Wed, 17 Apr 2024 16:06:36 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg
 <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin
 Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: init: change the generated name of guard
 variables
Message-ID: <20240417160636.0e649b68@eugeo>
In-Reply-To: <ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me>
References: <20240403194321.88716-1-benno.lossin@proton.me>
	<Zg3IHZfYVEOh7nc4@boqun-archlinux>
	<ef1400ae-ba9e-4656-98db-a882ac720c1e@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afc39a4-b374-4e57-f9c0-08dc5eeffb51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cRYzGJ7r4h5uUHJzGXs/rZJCqQEDYNUurd28iAWLwTTi7pIMqBnU9XOB/m6A4vyBOu/xar9rpuPLval6FrKMqZvJaP/gJWuKDhO/Knd2pg5nKH5F+rbKGIXqYOGJRTiUq6brzBVL03ceAHX+ZdRwQa6QX718y9qZnShn/pwWwgKc48VuagbfR4IxFAisxKMstYKVHWbSIGOarnrbhCppabBSq6TTJok8yLw8qdbOt3ctC2xZi1XGuG5jqvmgFX11GbvshLjkN40byz5BMoqqhVkHmM7Lozn1IUtfXHBiv6s/fCmn6xG0mlbtoGgrRhq2XpozoV7vj+aljJiLycBim5rWYpvaZPhLqFZd3gQfPi2IpE8BD3gpT/g42Yyft+CjCwJlzzzQA0Tmilbja6cGjtZPEW8neMjVDec+GHaV5KyjhrZdi49pOkWn8xthJu0saBZDuc8ApBOkO4FgDmR2hUpvaR8Pe51gxrSmpOm6FBNixnyNgolNqyzViQQfZOholj8fthBaWe9Xmzv/Fb6cU0C6LxW0SbLaBAlM8bXnb5bnchmuW8Pd1HgMaRFbgK0NZntdbZXCImwwQrASnLPftYxnvYbuoKHhwpM1hebWWtOGZY/HWmz0vDhW8UerwM/4CWkaFkrdFr83fi9hVnHNqH+SdYuTjPIJLPUEcvE9OV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QeGGWxZjcqea65UM6rny2FrIwGi2n2IOFW4BGS5BcO2Y94oTKid2IZuj6svx?=
 =?us-ascii?Q?0miMTfwbDL8WUylgdsXrTFvgSpdb9FLxVZG3oPiUYLImxL2CQYqozEwcg7QZ?=
 =?us-ascii?Q?AXy1qYh0xfZyoI3t1QqG1awUloVtBgdcoGh9z6KnkspD1ljTdoqi+ym/wLqA?=
 =?us-ascii?Q?qHF8yQvNoAGRWl8HI7FmNSwCSqvv6YPWAahObnr6swT10FWPsJ1LwwTXVmC3?=
 =?us-ascii?Q?E5cPlbCPCMxdVHFd700L7bB8j3FS/KVY5ybkoQt6L8iy9tjF9YwM7F2t4XEf?=
 =?us-ascii?Q?dmRNckqfGIVJSDf4Vu716bFwYo72ezR4xkmw+5X7eB6LuWpIBQcgV5DXMLdR?=
 =?us-ascii?Q?Wqq9k/OUcCEQcpE0Ml4IkQul6AChFgFDqEG10WpNDq2oyyjUc0gWw6/gMwmx?=
 =?us-ascii?Q?fMqt4SPZNiHF+8TJkBOiPy8XlxQAPvOKlqB9KJyQxoQ+N5BqPdX9nEfRmMbI?=
 =?us-ascii?Q?R2hU8wT4hKbYbB55Tb2Y2Pv4xNOcYmail90/MjCjYDXXnksgg9YtxRwuBwue?=
 =?us-ascii?Q?cZoo58t1hNd0DE66hTlwEOyQTXVDJWsAe4zxBNO6jyWalBt2rtsQ3Aqw7KGX?=
 =?us-ascii?Q?ArOjgrrsWVkR8mc+fY6mDzLGvGvQpOcNLeTRQGkdH16+0xw7y+zZomUqTPVD?=
 =?us-ascii?Q?w1nzV8pZgU1uu8EgOjuVilMSwlnVIzyzGR46OAIfIoanlImyHpo5YbTOsR4h?=
 =?us-ascii?Q?BRv48O0zHoJRpkD7IChrilHxX3EaGtFF/4RYY7t4Dau7W7R2Ym5H/vroODTV?=
 =?us-ascii?Q?sTUQ7YLS1uNbqKLf+SQMBu7FWdtYYPZyI/LJC03Nmu82Mk22dCPUNQp1AyPi?=
 =?us-ascii?Q?rullP3XweBlxGRpLVsmVhk85WZMOk8pZatwuFp4th1frFQKB3OS3PqzNK9r8?=
 =?us-ascii?Q?ImG9uRwqcafO9ps+SLUaM9ehNhZ1SOD9tdbImRgBvHPpr03wicqe/B54egQk?=
 =?us-ascii?Q?bab+6I1eMApsxFeLW9DpMvhh9AggzBeRySE676Wpdqbc4G7lDdV/viQ4GCt8?=
 =?us-ascii?Q?bYv584CypPS/mz8Fz56JGoPzFLSBRt2Xq0ZpYqnmUqgZtWYdXXB9oZSOtPfm?=
 =?us-ascii?Q?zFdMKl15WWfbxRzvzE+bJ2R0xn0xexm0T4Yyor2W/grs6jRhn7S6wN9zOJI8?=
 =?us-ascii?Q?e+FVJvOpzYCH8l5rmJmRp22mlms4G9e0eNeb+D7KVGe71UlbXsLIh723iFWe?=
 =?us-ascii?Q?hnrlzA87yEY/MKrncFoew6cNBzt0Lc/TzQUCdhfCm0CNwNuHYyMcOfN22+3b?=
 =?us-ascii?Q?p1f0c2om55Zl83hblKnjZorX+mApLpAle9/OAklka6n2dpuFe2drPT31sWwW?=
 =?us-ascii?Q?muDrfi49rFSAcYDCYTYqpQ+qVd8B0qo/E/HKvhBKZ1JJ7QF75Y/CPQpe87rD?=
 =?us-ascii?Q?3/4YRbHguQtaBKtZ6FpXBoqJT0QfpMriLniQwBj+SLB5IzDC/6/zQNSj80Ge?=
 =?us-ascii?Q?FjykyaGQ25Ed+jggX/RuPPdHl8X0Kh2ieRqMX8An0yXvco8DWng/DS8F1WWF?=
 =?us-ascii?Q?N+mPWMIzhMtq779VUbk/FuMnavgopZRlXbAERkANhwObPisAOwJOSOa6UIIJ?=
 =?us-ascii?Q?25gEzhAgs8Iwq7Q1BSx0QoHa/CHRDYwBU6dQQsCu?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afc39a4-b374-4e57-f9c0-08dc5eeffb51
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 15:06:38.7837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNKY6V3XsPDtZheX48fR/tkJk7rtt/Ayrn54Y3FK9kfUP++Hf1G+gzWgCr+yEEQKtKvhSGteOfewIYB17yEJBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1992

On Wed, 03 Apr 2024 22:09:49 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 03.04.24 23:20, Boqun Feng wrote:
> > On Wed, Apr 03, 2024 at 07:43:37PM +0000, Benno Lossin wrote:  
> >> The initializers created by the `[try_][pin_]init!` macros utilize the
> >> guard pattern to drop already initialized fields, when initialization
> >> fails mid-way. These guards are generated to have the same name as the
> >> field that they handle. To prevent namespacing issues when the field  
> > 
> > Do you have an example of this kind of issues?  
> 
> https://lore.kernel.org/rust-for-linux/1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me/
> 

Here's the simplified example:

```
macro_rules! f {
    () => {
        let a = 1;
        let _: u32 = a;
    }
}

const a: u64 = 1;

fn main() {
    f!();
}
```

The `a` in `f` have a different hygiene so normally it is scoped to the
macro expansion and wouldn't escape. Interestingly a constant is still
preferred despite the hygiene so constants escaped into the macro,
leading to the error.

Would your change regress error message when `pin_init!` is used
wrongly? Personally I would say this kind of error is niche enough
(given the casing of constants and variables differ) that we probably
don't really need to care. So if error message would be affected then
we'd better off not making the change.

Best,
Gary

