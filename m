Return-Path: <linux-kernel+bounces-128512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B10895BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B35C1C22CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F815B13A;
	Tue,  2 Apr 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBHE1ZlJ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2117.outbound.protection.outlook.com [40.107.243.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C118495;
	Tue,  2 Apr 2024 18:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083262; cv=fail; b=nCawCNyUnlnIJKiExyi/aVAyMu5NdY0Q02L4kUYh/ZfWivl9ECVldnX9reMVRSoKp8ObfH5tkPh9x5tXeuEt2Awj58b4j8+zhO3RXmFb9vOoHUbPxGqCj+nVmeeWI75elWjJFOxtNaw6jQsbYo3IUWyqPekM1mVIz4Ar+7hEB/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083262; c=relaxed/simple;
	bh=cGijKsiUGcX/IyukZ+E7VhMWyXXXqhpjF4Vm4gkFA8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BavQDh+WVGA4QUt50C6PkjH2X6WK3Vrw6QHi07Igs4aKPa4P7RHXQb5sRxASDVMt7idtUvGnWOb+V/KZQFXAFZP4EwBbDnPb0nEY4mo8NrEtAh4mUVQTi7dHeTB3S1x+eqnjkYDJzH38eg7Te1G1FLSLr2eIDqP2kX27kX117r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rBHE1ZlJ; arc=fail smtp.client-ip=40.107.243.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqcXGueH7IDIen+eT/dkPrTPxOcErYY9qE+VeWXKIyNpFhecqdT+CMmJWaH6qBDY+9lbb7qR8mIRBfrKNMIuoFlMJEi7Bh3YOyQvQjbLH1JFMc7N16VBAcTxfJ3np0f9GiIwDxYSyKvMlZcBdJi/22OdLASZ2+A+uGMl3gXpiVKG2bVHF13d3Lb9Q6TwET0P5ZLnVD/Z3D25F55daxvDfC3WyIzfOVak/Sx597cr3KiqxjgfvDfJ3YLJlC4SaITCU5Ek7EqcZNMN/44TF+laB1OP6CzUleKE7g+J+4SY7z2/bvT2HH9oLIt7csFyDrwCSTC+EPBYC3eFxVD7oUlCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEFg0zxaYuz35Sh/pmZfmm2c9rR/9UqCAq/yLHk1IIU=;
 b=cbXe6GgMqxzyAK8V+d3JGzQiDHZ07FRa2FGfpMUlYJSv+QDazggcIVFFxmCf3Ma2vZwRCx9NHzAxluIyrNcqLxhkMgdvSbI3bN06qAot168DPRS+MpxxXZtRwfv2SM8fGuZLQkMvjiegfW4cWiqtZe9WDCyBQ8LrBfgEPYx0ggpC65lgip3ef0WcxyMnHOmy/zJvI3ujrj7rUhI7j0OXjoQ4YLiuA0vYfeobKRkPSIBex4KZc3SpVGVbYIt1m2Jn8wobKJpYKUlHVn1AGW22i2WmjKxB88lnAjLnwZmTGIjIF0WDWVWekixpOs56UTUNO2VZFWbJ29QVpfFgKhciqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEFg0zxaYuz35Sh/pmZfmm2c9rR/9UqCAq/yLHk1IIU=;
 b=rBHE1ZlJgg1mH7qabuJGLXgkLQBX/mprMUS9KFCPd+LseywiZ89a6NxSUZV0H0kbCU9K8xthbgqgbYfMVeB1PgiNav/6qNyuFwLbCT6dRhBJXW3CaKuV3s5q9Xnf2gtQ05EMP9YQPyHhc1Co1ks//h49JzUDL4UP4Ho/iNme5C5S+BEC2f4+TyqWgZuSwhztOUVqmfSFAWvW1eUF9vcPxnbEADjAv6fz9U65dA3ymgxLlYGxE8/Fkq8/bfEFM6dZtkBrUbLaLcK9HIVzDIAt/CMLrb8a+OfnHUZYf6mQm68rKIus/Tf6qndXUaMFCVo5/m5g6nwQ9pakH423MpqU0w==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 18:40:58 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 18:40:57 +0000
Date: Tue, 2 Apr 2024 15:40:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240402184055.GP946323@nvidia.com>
References: <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB7695:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fTMZVhgWa7qFVzjgXBKtaBpCjqchfxZ/zf6YBxUqRtkf5bOATMj1dW+sQvGKgwup4PxrPtilsUqPxoxclCVRH2XWJz9Sh8oRL4o7GkrfsrSFIK4IlOU5RrFTDddoWC9VpS34+2bECf3sqUO6MCrGQK5xQaL87pcCexbjyDZTQ7n3dKey+y3UmbmdUXzIe1S8LeBZW+8cB0/73ulqGur7DwB/wiLKha68FXWWcV9n8bQHeFSygtqM+6BY9HpIfN8fWEioJbHYVVBBG8CLFBoYHVSo6GXe6ZpZ5Cc7h45ED8MGWGgXwQNgJViZm4DOlJrAqWok4977rdOyA0F4k/DZtomUI9HZztNzWVm474+RqeTiUGSsPnLblDgf/hyW1YT9EY1/e9tI8BLuZJ+QoqcFYhtfoKOEOzruiH7Gk4lR+qINvXvcL4Wf1tziAt6mNp7JUjNVaHTTvMzcMKqeF0tDmpb+Ut/KAhDUb+5rkXL5VozO6YXRUa28yT8x0WRceubCdjzQ90B1xRlcBZZITdWjiuZtnyQZ0mRm2z6jK7OG4yt+6c6JKyqYleDkQLxsuclSqQjCMSIX1coTsfDma6vVqtFT4fsAclB5cETSXYwevYAevFg5spm75RYdZ1uGJHACrSEsIGYKkGO2oZw0OFqRuGAiDEDQy3tKgU2oUBns/wA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0huRWRlRDB2Y1RRYUh3MzBVcFFPeXhIczBKT0I0L0RRKzl6dElrdThLLzV3?=
 =?utf-8?B?QlNqS0FqaXdSRW1qWStDbGEwMm85Qis0KzY1elhnRUt4TGlZOU56SWlZbmlo?=
 =?utf-8?B?MUY1RmwvbFZ5N3p4SXlzQ1RncXl2UXR3NWlTb0NpYk9YeDZWTkNBemN3WXdO?=
 =?utf-8?B?Z3Q3VGx6YWNnYVpiRHdEdEhuSW0xSW1OK2ZuMmtoQWh1QzA5SUhSRDEyMDlO?=
 =?utf-8?B?SWdYSmd6dWpkUDBadzRRNHc0WDZ3RXRHNURWc3c2UHVoV3JacEI2WWwxb212?=
 =?utf-8?B?RVVwdWRKZkliUW5FbTRrdTJRVmVxY1YrYVhwWWkvTzl5cGRVajRZZmtaMllD?=
 =?utf-8?B?ZWt1YzNOeWYxL1M0Wm9UZVB0U21LM1pnMDI1MWdzZFUwaHJGd2ZrKzB6K1ll?=
 =?utf-8?B?YmtUaUEzajdtOUU4MWp1cHloVi9POGNqUFJ1Tjc4UUtUQ1YyYU1mdnhiVHdi?=
 =?utf-8?B?SUpBZWZzYm5aN1R5bHExUlIyTVdXaWdadk5reTNBc2tTN0hwR0FkVk1RdklC?=
 =?utf-8?B?VzFsNDEzYno2dFR2c1hIdUdCRnZWRCtTU0xNckErZWkvdnNZMUdkZ0FSekht?=
 =?utf-8?B?RkllZndlaVJqVlBJbzk0dVBxRVFEUERqeXBrTG8xTXpYRUxrZEYyMGxuRE5Q?=
 =?utf-8?B?RzE0UmJQYVNJejJNTG0wODJmNmhvbDcrNjRuSnhxNU1tdkVVdlJxamxMZ3dn?=
 =?utf-8?B?clAvSTBWeWhVeFNQNERDYmNJV2VBWTBKbUhPV3NsSStreG5vRmo5S0xweFJw?=
 =?utf-8?B?SktDYmR0Mk1IS3lVR0ZENWtmbXpHWFRyRUFLZlc0MkZwd3ljSnN2VXJaUzhQ?=
 =?utf-8?B?MXdrNGlzS3UyRmFEbnE3MkFSSlVxWHZPem5VNWJFWkkvdkM2THh4RG14Mjhs?=
 =?utf-8?B?OWkvcWsrT3pjV3dNZzdLVDd1eXZad05nL3A4NFNGd0lYa0VJUWxVVDZpVFhM?=
 =?utf-8?B?TXRrdEpsQVNtTEF4YWZMMG92dlErN0IzVk1MMkdGM3o4VVVackdqOEVXLy9m?=
 =?utf-8?B?QlFWcGV4U0NNbUlDZzhPLzRzL0hHQ3JTL1VYOEg2bHpNNFUzOFJ5Q1pYbDlr?=
 =?utf-8?B?RHNvdUR6Q2V6dTZqeW9zZ3lkQVZJczBuYlJpZFYrWExQMWh1TWZ2ZTZuTEZo?=
 =?utf-8?B?Uzd5bE9SVUhxRWRKanQ1VmxGMFI4cTNUZU1GaUZJQWZRRUVlK3M2VlpJVGFv?=
 =?utf-8?B?THhLVE12MXdkUlBrWHZua1hpTXprSWluVmRNYW5HdGVsaVVRODJOSExFRXhG?=
 =?utf-8?B?OXl2MnRpaWhpcTMwNlp0QUs5ejZibklNT29tRGk4a0FFeDJyRm1jVWErc0JW?=
 =?utf-8?B?ay9xYldHdmxvd3JTa3pXMHBGQjVZNisxN2JSV1BvczdRQll0YmZ0R3hTUmVT?=
 =?utf-8?B?dUdwVDVzdW4vVndDdEY2QmxkaHk1dFdBS2V1QXNpMnBJdTRTTytHRkt5OXJ2?=
 =?utf-8?B?Yk5rNjNlL1hrVktROVJaRHNOOEoyTkhiVjVyVFM3bkRLL3BTSGxobUdMUjRm?=
 =?utf-8?B?aHBtOER0a0NLTXJWc3RGZHRVeVZTNjFqSWlHV09OanpnbmZtY3FVN3h6anNi?=
 =?utf-8?B?M05xWDg4NW5HMjFoVFMrL0RLbjhFdXQzU3VXb2EwT0d3M1JvUkdYRDFHTkEy?=
 =?utf-8?B?WUd5Z21xQlpGVUh2ZENLdy82SmNnSDVQb1pVaXdobG04WkVBWEZJdDlnQTU1?=
 =?utf-8?B?Q2ZheXVYUTZIamRvZTlsZVQvMk4xeGx3WUFiRXZaSGZPaFd4UEY3d1p5N2Vz?=
 =?utf-8?B?WlRXczFVeVBVdE50a2xhdzFSNmlrWjd2Nk1ZMS9QTnF4NjIyTUhCMlJabkVD?=
 =?utf-8?B?ckNjU0VZRFFUMC9QUTRBYXh3R0p6M3BGY1RQTlRPbE81UnloQzlqWFVYSFRx?=
 =?utf-8?B?dEpRK3lZbmp6dFdzdTZuU20vUDN6U1NwN29rQVRkN2UyZGxHV3RTVGFrMk5m?=
 =?utf-8?B?b1YxdlJLTktMMUdISkpxNW5qRkRuZ21Zak8rWHM0TWo0ZVNMRUU0MWRrL0Yv?=
 =?utf-8?B?NUFFZFJRejVVMW1jQXBvQlBnby9sVmE0Q1hNWnVPYmhXcHFTeWFURTBTVWRo?=
 =?utf-8?B?ekx3S1ZTenlzZmVPUmZaZTkwVXZMc2hsaFdaZm5wblZvTnlGUnExaFhMSHcw?=
 =?utf-8?Q?i+PIbyF56oHJO0D0dFS4qo55D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b726fff-9cc2-4f2f-22e0-08dc53446f24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 18:40:56.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m86/2qtgj6buVbISr0h08NwL/ba6QE1SCuhguUEHUUYjqD5Di3M30fFZu7yvfDp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695

On Tue, Apr 02, 2024 at 05:32:44PM +0100, Edward Cree wrote:
> On 26/03/2024 14:57, David Ahern wrote:
> > The proposal is an attempt at a common interface and common tooling to a
> > degree but independent of any specific subsystem of which many are
> > supported by the device.
> 
> [ Let me prefix this by noting that I'm speaking personally here, and
>   not representing the position of my employer. ]
> 
> You can't have a "common interface" and yet be "independent" of anything
>  that could give semantics to that interface.  What you have is a common
>  *transport*, used to connect to a *vendor* interface.
> If you can't even bring yourself to be honest about that, it's no wonder
>  you're getting maintainer pushback.

I think this was covered in the doc I posted, it is unapologetically a
common transport.

I have some ideas for different "common interface's" built in
userspace. I think others will have good ideas too.

It is 'independent [of subsystems]' because it is manipulating *the
device* not the subsystem software.

> Do we need to go all the way back to operating systems 101 and point out
>  that one of the fundamental jobs of a kernel is to *abstract* the
>  hardware, and provide *services* to userspace rather than mere devices?

Except that isn't even true! That is a very naive and simplistic view
of what an OS should do. If we took that tonnes of interfaces in Linux
should just be purged.

A fundamental thing the OS exists to do is to arbitrate, secure and
multiplex access to hardware. There are many levels where people can
put a stick and say 'common interface', and it is not some 'wrong
architecture' for the OS to delegate the 'common interface' job to
userspace, or even say direct access is fine.

This is not an exclusive situation, fwctl doesn't mean future OS side
common interfaces are somehow blocked.

> Frankly, this whole thread reads to me like certain vendors whining that
>  they weren't expecting to have to get their new features *reviewed* by
>  upstream — possibly they thought devlink params would just get rubber-
>  stamped — and now they're finding that the kernel's quality standards
>  still apply.

Oh please. "quality standards" is not the issue here. This is a
philosophical disagreement on OS design and, as Jakub pointed out, a
second argument about who gets to have power in our community.

> Complaining that devlink params "don't scale" is disingenuous. 

Saeed's remarks mean the review process doesn't scale. There are
something like 600-800 configurables in mlx5, I assume other devices
are similar. You can't fight over commonality bit by bit that many
times and ever get anywhere. Everyone will get exhausted well before
it is done.

> If all the configuration of these Complex Devices™ goes through fwctl
>  backdoors, where exactly is anyone going to discover the commonalities
>  to underlie the generic interfaces of the next generation?  What would
>  configuring plain vanilla netdevs be like today if, instead of a set of

It would be *exactly the same as today* because today everyone with
these devices uses the vendor tooling to configure them. Where is the
screaming? Where has the concrete demands for common interfaces on
some of the knobs been all these years? Where has keeping blessed
support out of the kernel got us?

If there was a real industry consensus to make commonality here it
would be done. In my view there is not industry will because it is not
actually an important problem that needs solving. When you buy this
kind of complex HW you need to ensure the flash is configured for your
site. You will work with the vendor and either get devices with flash
preconfigured, or you will work with the vendor to get a suitable FW
version and configurable list for your site. Then the job is simple,
userspace needs to confirm and fix the device to have the target flash
state.

The actual benefit of common names for the individual configuration
values is pretty tiny. Unless 100% of the configuration is covered by
common names it is not going to be meaningful in practice.

In my view there is alot of benefit to have a common tool to take
descriptions of devices target flash states and then enforce
it. Something that is common to many devices and could work for
everything, not just some useless subset of aruged-to-death-blessed
items.

> These commonalities are key to allowing a product category to
> mature. 

Uh no. Alot of this configuration stuff is to serve niche customer
interests where the customers have no interest in publishing and
commonizing their method of operating because it would give away their
own operator secrets. The vendor's created it because their big
customers demanded it.

eg there are configurables in mlx5 that exist *soley* to accomodate
certain customer's pre-existing SW.

Stuff is like this because the *industry* doesn't want to fix it,
don't dump everything on the vendors like they are the source of the
problem.

And, as before, this message is talking about configuration and
devlink, but there are many more problems fwctl will solve with these
devices including debugging/etc that inherently can't be solved in an
abstract way.

> > It is obvious to everyone that in the AI era, everyone needs
> > customization
> 
> It's always possible to argue that the New Thing is qualitatively
>  different from anything that went before, that these "multibillion
>  gate devices" need to be able to break the rules.

What supposed "rules"? Read my post again, this is well trodden ground
in the kernel. Delegation is fairly normal Linux design - try to
minimize the kernel footprint is also a well accepted design axiom.

Jason

