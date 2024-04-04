Return-Path: <linux-kernel+bounces-132109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C9898FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391A2B24E95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8C13AA3B;
	Thu,  4 Apr 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjjWcY/n"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2136.outbound.protection.outlook.com [40.107.212.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5A1BF40;
	Thu,  4 Apr 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263503; cv=fail; b=tBgV3Lq8W4SfxNXr87/Syl8HbWv9PS6cJfom2hTe989XiEHMEaITnQKZI3AMZzsZQIIN7FhBMwCUKA2KW+fhPCVZflz7plit1xtBa1cAlr7WFjtTNKjN3+CcjAKrEwvQA5L1a+V4H9rSCePvWY8DzlnnQL9dNu4zdKFfSFyBB4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263503; c=relaxed/simple;
	bh=Ml7mikj0ix+0fi6DYAc3oIsJ4tcl3DlaW1iAwNOhi4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BEIJcuS8zA3CT26F+Ve8/ooU4y9f6VDCY8hhv/eULxWwO0MyzOJt7oM86jJ3A2sjH6Y2LFrQXNIeL4r1fCjOq+z++QbtsLDKPixRggNnCWm+HZ39sZbovKdlQkWYA1G35nHu08cYgu0Rtd/Uzn0Rhih+6eejrNOQ8ntvimUl0OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjjWcY/n; arc=fail smtp.client-ip=40.107.212.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMekzsQIlo3DeHpVZJUsdiNsIWjTgi7fDc1IkPLrwxKLYsiti5xfUKcHblJ/KVseqFyzA+dL1tiBjvpCiu+5DFLPL3FY6DjcIiyJJZBSKD9OFbjJEPlZpO0Hkxn0n6VrI6ckxTezXmtZInKRF3p1eXNgCSzCIUzT5trnZ/GEsp05jmNNT4AWaFB5qARc3aYuLWw+3owfmIAhcGmJc3aYYOV4kTSkRQVFOal0vb2L4aXAXwWljJqM560eVUDJt+X4aTRTKI+VZfPim+kDmBpuzhqhg8mbHzNEyDpVMOtI3cMjrod4jV60qalpmZoBR9nJbhrBHlG9CMGyDq6aGwOkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOjC3zmd3oZh4TWJU4uB3gyrf15ISM429YVF6jx7fEE=;
 b=EjAO1OeK9vOckIn6JDMspW1DxzcahTtPIxkK/GUXVj4GqSazs1exrWL10ssqMDm3E+ZAJW/JMKGY059GKqBjt0Cs4JjZ5qDhWc91j2dPP7v0aHRFNFxdwMli9XNIdudOs8umQfVhsGk29fBJYotg+LUUbTf5QYAF7jUUUzKPSWjTUegOuOF/88XBi/8EUclcAdG4VQaot+roNdpgF7Y1k2fqlJrZ58o14saKBG39S92/+wr6/Lue9gBGO89Lw6pBvLBNYbB/28xwNCeUB2bT7eyk+bJMFI+3FXT6Qp4ti7SjZYFhg2Kev7nu6cwZPbhOu2Mgy8r5yXtzmfO7u28nRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOjC3zmd3oZh4TWJU4uB3gyrf15ISM429YVF6jx7fEE=;
 b=jjjWcY/nmtF8RkpjfeX4Q9xI8OwfrQj+dOe33cH8OerxxbyBrcm5dcoOvEP9Oo4HBKCdPVxnyO9yHKOrK6wyFu+U3hMjXa0dRxyPAVHk3RitmIY1Xcm6xqDH/a7UgZTsQG5n/Slf1AiK7uaz03dwfJeb9FvAvEExZ6nkoVeL5Jj+2tVbVFN6vfb9N3KD/geRkjQcBitFRwfc/MTcdVBZPmeeY34omEY0iaVh8FQ/qb2zGN8/LHuV9eDjVhPiPEZdBTn5HY92nqxtdd7lpZ2L6bp+YZUx01CYBkNY0PX0TW4Rr0oOncHqviQ89vh4W3fGTxe7bZU47X3uRZEfhKxyEA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 20:44:56 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 20:44:56 +0000
Date: Thu, 4 Apr 2024 17:44:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, David Ahern <dsahern@kernel.org>,
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
Message-ID: <20240404204454.GO1723999@nvidia.com>
References: <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
 <20240404125339.14695f27@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404125339.14695f27@kernel.org>
X-ClientProxiedBy: SA9PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:806:23::21) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6317:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYocWtvvbCzZeKYCw502TtKGnz46aGIGk28+oN6qs3IfKaUwtdNcbwYJT3f0LpJz0ukwLkGw2HuPdaW8Wah3RvGLfYeYij9GZF8qOU2iA4FjgNm4Ov9Q/Z4IFh8MmqfMaeCHxr41vJ54eUP8+ZiR/KPFfIj05SZtLAC9hJHKOk/davJj196xUh2wC6F3Yzlv8BjWc7+diJMU+quVCtJBjKPoWlzAMxGIHqEQUdYqeoRSTZthi7g0HfGoTmsdPOvG0cuiHo8bUujF5JHTa2CandTO7HywN0pIRPcRwn6i1VMdMYLUJXjsWjdwH95arLb4CXdggyI7ydG08YHTcj6gVSS1/oHfvRV348euxdRqCkg/PtKDdMs3bIx1Cwv+7guzfTizt0AHbQduaXRp09dq03TRJ2ZT4DueZkFme2v5WTfbsSNYAXxC5M+4M4bR8p59n/PMT22QGnZ9VgzyJaEDOsY4utToi77w3IhZFr3SmRzx8IIv01Uy5SCNyMfWGu8Cxqfkq3mhj2qBvwNfyX5CdQpV71g2x7NOznzjM3WJKSBOPM9zMuOhowfXH54aghV8RRGj0Mf7o00PoBEYFXyjw2NZn3tswonsIUqtNnrZ3L1ZmiPUfgAzpZU4xOtQHr+IJIvKnTfmxuLHMqiurx5p9vJpxQQvFW9tlZ9xa/3Ko88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RV7qd6cJAwKg9WQG4HNiy0vypXz/ZDNtQ1eWoBfOpqRsmfnSVPGm5dHBQOC6?=
 =?us-ascii?Q?XPiPScUnXyBfV/talf2Gs2W66MIuD8xamjCEKiq+sDVlhr5cmHnxK3kdfhYM?=
 =?us-ascii?Q?f5XDdGNSPjNxy6faoPQjz2LsRMBiuFJMVGz+mzCEMhSLaTMUgoKS10EXvM7D?=
 =?us-ascii?Q?3tQaI7Ybk+8tyO1Avyy/UH/BnSjh0C/WudWNMWRKmR/enc+1A1HVqNhHe5z/?=
 =?us-ascii?Q?9nJCffyizZ4Qt0ztHHaBrAg72j91cu9FjCJaFz+uw32tcwjQ8vpfLa7cxAKE?=
 =?us-ascii?Q?RMLuDw+M7HRoJ367tC4r9C0BVtywGdTezHZHtdCkf14oC3pU7d3SRhbwb6oQ?=
 =?us-ascii?Q?O2FMYa5y64nzvsbb/JxuJgSdEmxR/FRIV76IGNOMrylzljMK/WjV5CX/PYTk?=
 =?us-ascii?Q?KGBg9bDdELpNv1AHQJmHuoiaHAmXVkwKBlR8BgoWlldPVxhgtoxKZSx0INJZ?=
 =?us-ascii?Q?Nu4NbXUFIql5r74CT21j6rVOO1ShLbJwmrIbXitLeFqJEKlsYLZqZ8VXpBlb?=
 =?us-ascii?Q?VkX2TVuqWVxSln4KQ85nqe+N7uvfECPn3t0izRD6/K3FNSMA5i2v/obbPbSL?=
 =?us-ascii?Q?+nc/VXoHPLlXmc9UEzjQsNdf6mkyN2JxwL0X922vWpjyjcZTXn+ux1atvX8z?=
 =?us-ascii?Q?PYGP1VVGi7CVrHHw8feN86a6lgMnOGNDrQHiLZXDEdnbJiGOyZqUyxfOcRku?=
 =?us-ascii?Q?7AMPs7ibZhaODFRThZcaDC1RVxa+EnfAQxtrdaactHW6AQPTZgKPCtc1PK4D?=
 =?us-ascii?Q?U5ROkM/rQrFMpo+br5SGJ1ipkbtgSIKQWcMtJkKpXhyyqln9Z+Vb37VDDnPD?=
 =?us-ascii?Q?aUHbZIiZUtZhjR06bBF1LcvuryYF7D4FWjpP1UljTsbKsev4SQzr5+bFgD3V?=
 =?us-ascii?Q?8dtBekM4Fv4raEJPY+XYdtBzNAaHQ975nPGtLz2jBgwADFtInaQQD5NBTgsx?=
 =?us-ascii?Q?y4nDOc9d7+sZxpwEoRsVIWWPINn5xu+FUomSdCO6Sa3rfJu58GITKGdt4aB9?=
 =?us-ascii?Q?DHRDd/ZI60Y0XDr89jWEYPJCCvpOm7unp33v/Cf7PleOCCJCjMIXeqXev6VP?=
 =?us-ascii?Q?BIEEdyIqAYs3KO8323+qsVLArE2i7AUFHs72nRPEWIsW/AzhgSfDC+DcuBSw?=
 =?us-ascii?Q?95FIDeUxBw+hcwyrmlu2ta3wZc25rzBkPJnPvirpXcl4AuV5OApydtAdGOvc?=
 =?us-ascii?Q?TxEn9D9+542RJMBuEFV2v+jkN9RyEbzXrINh1omQTtoqv6kU5ExAcu3G2h5P?=
 =?us-ascii?Q?pliLmN+TPXPivmd3P8k/uR1izfrEuS30IDBXZsnvt2PO+pLNDX0LC1kMBJTM?=
 =?us-ascii?Q?Nm9jZgR/VMfMwkjR2ScNfKECyy5EFlBDCM+Lx+bQSJCXJvEQKHoPbXTnrYSz?=
 =?us-ascii?Q?hTP8L4yN+eJ5n4gpNPM+8gZDrIjU5wSLAogQckNZ8andPkhrVgD0DnbgVXqf?=
 =?us-ascii?Q?FGxXhGOmtbkOHt+gF1zPIWPVAu7LTgueDsn5MozPe6EMwGfValvmSQQ+NidP?=
 =?us-ascii?Q?OPcIP9nad3GGxD5D9d3v6kirlII+Nwz9ScLjIJ+7gkpVmCjjsvGZLBRVmtrv?=
 =?us-ascii?Q?7gh7cEC6F/ow6gBDBrR3/Mrlxcs6BMB5gieED06x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71215c48-14a5-4d12-b10e-08dc54e81617
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 20:44:56.1382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2+BJcGbtrXO+usbmQ8WWG1dKbSak7mc5xTRyKKot81RITD4YhEluAvTkw7VQcIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

On Thu, Apr 04, 2024 at 12:53:39PM -0700, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 15:33:05 -0300 Jason Gunthorpe wrote:
> > Uh no, mlx5 already has an excellent in-tree driver, thank you very
> > much. The configuration is not changing the driver, it is changing the
> > device.
> > 
> > Consider, I can ship unique devices pre-configured for each site's
> > special needs. They still work with the same inbox driver.
> > 
> > In fact that happens already for certain large customers. It is why
> > Jakub recently pointed out that Meta doesn't need any
> > provisioning/mlx5ctl/misc driver. They just buy different devices than
> > everyone else.
> 
> > Further it is really rude and inappropriate to say that some customers
> > should not be able to enjoy intree drivers because of your aesthetic
> > opinion of hacks in a device's design.
> 
> To my knowledge the "customizations" are mostly around fitting into OCP
> servers.

Nope. I understand it is significant. If Meta had to work with a COTS
environment like a HP/Dell customer then Meta would have a list of
flash configurables to set. I think you greatly underestimate the
privilege of being at a hyperscaler and having vendors create custom
products just for you..

> Those unfamiliar with how hyperscalers operate can mentally
> replace $hyperscaler with HP or Dell in your message. Minus all the
> proprietary OOB management stuff those guys also provide.

A significant Dell customer will get a server pre-populated with a NIC
with some generic Dell configuration. In most cases the customer will
have to then program the flash to match their needs. Set a specific FW
version, set site specific configurables, etc.

Similar to how a Dell customer will have to change the BIOS settings
in the Dell to match their needs.

> Discussion is about mlx5ctrl not "the device" as much as you'd like
> to equate the two.

I view mlx5ctl/fwctl as a window into the device.

Jason

