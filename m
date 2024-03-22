Return-Path: <linux-kernel+bounces-112043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C1887486
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35A81C2120E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8680BFF;
	Fri, 22 Mar 2024 21:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eW6uLznW"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4800A8005F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143871; cv=fail; b=avzGr+sCmtuQKnJsk58NLV2zgVL+/u+8w6s/ityef8wmqCvRwDrKedoJn4ZYTSfztukcqUUGQ2Gq1iBeL409ynbgDrc73Z4bxUzeUyFcPcFRr6zHIEkdriRZFy6TnHXOmGLpSfiBna5joFl7k4cBhg6GrQopmk4DowxqKojZHc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143871; c=relaxed/simple;
	bh=1bDX7vu5AO90jd5AewIYFzZFnkKlM3B4kcwb3/oFshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pwtIMyviEIJqBEVPCHcY/24kzgCJE+6ZXFkALCei1ItUHoCpVklJrT0cbOT08qnKZxU3gnwDoF6Sln+ODWd/X0EO67MJ5Zh36ENJdFoAhTmpeDJSnv/kb23dQUZURl9NMijhsA7wUPMX2N6s0Z1JZ6l4+KU5hHhE0ZNEcIv9e9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eW6uLznW; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo/rH4HOG4vyU+4dbP5/a8ZeySuw76BBfhukc23B/pKFdBwpv7oYGh2E7pzVNZF/LCX0y+Nz0WDmeJjqrqShp7WujTPYjcL1UrT7ZAt1Nk4z5g3M1swNZC04bSOrPLKCVhFSIMGVY+xmrUjZqTLiMf4a7AaHFFiYH/BgI10vGx20daZEektbPgeMqeVj8gYeYn3VEmzAHUKF5vDK7u1D34ukIar91kMtnqvtW5uXR3yuG2yCuS3BgpaTtJ6FMN+BgxzFF8rp5fyhKP+6zzR8XbKx3Nh3ml853MRMxSB/TEVBZLUL2t4+NolVlM9AeBit8/hXVUjt3u5kfpE1VdFShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqQIEaPMSD7rwHDHPm3t1fPFov61vmzXilCzzxo/yAo=;
 b=fzxtO4xuS/mRQbB7VI2Rv6qZvI7nrfNgCTgxLrCobr9no0Vt5mp6yhbEEsMd9JPlXTWOPmwGd9ig72LqJQbNIwthzRGoUaO5spcRL7I8owDTl5p9szxczaPO6xnJQEzwFuEnjs/4Kc4fFcCWQ69kIPBAllqO1FU16MR073V4P4s5dTJnYwau1UdzTenti/CqeKzQMDgO1u22QrDLO46lLBGb4zSNDy9G3LXylKoj3bNsJwo8mRgguQ85Pe9xfvI/1viOKljwaeZ7rTdR8Tay1qPu+TYE5CjUvXB9Q2KsJ9KM1IIxBsINEtC9e3P7aSRqilqhF0a+wy49zRZKzGwXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqQIEaPMSD7rwHDHPm3t1fPFov61vmzXilCzzxo/yAo=;
 b=eW6uLznWwzF/rJpHTbqdICruC5dpN2vqrGv8PI5OLdy3vKZlcg2AjOl0FRhRUEY+XVRQylz6S9Nhara5ODr0fmMZ5kzxRM1p5enhs38Yc9eNRVJ9T0+R5S+j6fz8HJUVyfx3OeKEb9wKZm/AgQB8jOAwxIcmhK+3Vo2Leb+/QCMhvVcg1rH1jTUnR3flAujnNtOSBEFPnCnPn4k3bU4MBDne8Ci3ybF5t7Gx09paWjEMPx0QdgjdfyXdb/myXeGzGkMijDtKlsyi7EPbGjEMvxzS8U/eYtVcM+BLqmr4I7BRkz/QbHonLi4ayv4fnNvL2D9NjUpBSPxJFaLcf8BalA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 21:44:26 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 21:44:26 +0000
Date: Fri, 22 Mar 2024 18:44:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	David Ahern <dsahern@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240322214423.GL159172@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322135826.1c4655e2@kernel.org>
X-ClientProxiedBy: MN2PR19CA0030.namprd19.prod.outlook.com
 (2603:10b6:208:178::43) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY8PR12MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a915b58-5a1c-4a08-9579-08dc4ab93dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T+TXGHgMU39Ka8fJTMzD3bxMej6Req933Ke9J6niPKwtKm5jDWwdhAdMKHd0Z290HgMbbF801mQFu6cOvg1WdrsBbEwVg7u6qsNtzVvkuuZp4607mKLbfsWJ79eaOKeUC+hKE9hoaczV5pCF7jBGP/QEqh8kAjO8U5E2a3soEbCfKY7NNseCW/Y2lLCl7baRtf8OwAIpvmf+0HL4uZoLphrXulDAxZ2SV6hTotHngWAKD83L12KRpQyIu1re2A69leyWG/CbeRCXLENjK+xSNCRQJMxqx2khgllcmnl/pBFeaixvlwM4hcsq/ojA0VD0HJ9rd5hJ/HeZQrMVQZCq9gLq3LUf4d54JacmrofSFwbhmLEo/zEjGnbKxtfcNJrZgccd+adn8uFaiyISvgEFvBGejSOybyo5LhWU3Q+OLdNqVIO1yOBUu9E42p9nP343+fUM8X10xhu8qfAQxfxWAZaCMaBLfO3KkzCVfxYx5WJ8u59Ao9z9CpyWYtV3FLhQn+y3DPMlpCVzHoGNqt0q5+cEF59Zgx/UcPowBCKEsMsAejRr2fZJaOTSxf7G9QlvQVrPibTg/oKZxRtNIq84K2VJ3EYYmpPduWMzSxVFVJ+rBO3muL2VzRLIn/MzMXy9OKLX3syis0kgMisRrRFPlr7VCWdFz2W+UGeFD+96diU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXDHZFFi5he7ZYoXvATDL0NW+8ebAtVL1fSslZSWxxzSHxxwpKlK79rkAi9w?=
 =?us-ascii?Q?6Zms/MpVakj1EnSyy0zIQJD/sB9zCZerIkINKvSiLSwymzgcqdLWSDZCOGzh?=
 =?us-ascii?Q?a9557b+lhRz3N2iBgXyIGPONmoE1h8XWzSagVs10rF9Rqpc+RejpsaPR5Ffo?=
 =?us-ascii?Q?vlxbeL37oTVrBiBWr9BJJeGdLK3og34TuZT7FO/yB9LuJPfaEVOHSFxVYpBF?=
 =?us-ascii?Q?sQWSqWmkros13xo1PAd9N8MDWIkJhdnkXqlTgUJVSlF+m4sasBvkthi3F9Z3?=
 =?us-ascii?Q?I0rTBW82RZDlQVmh/eP46wlCysAW4fHQe3PyVun01X/qsUI/u5AJmNeo7qnF?=
 =?us-ascii?Q?1GrjkSO+7Il4Pj8mB1CrIff9ou14mnPYtAiQ4nkOmqKCWW/FIaQarPzEUqMD?=
 =?us-ascii?Q?3yqTBkokPp7qdKoBLqIwu0AAvYkYomjgnF/CkRZVGqvdHf/6Rw2X/mf34HR5?=
 =?us-ascii?Q?NfFK3DRe1Npzs60rLpu+bNKv/JxpT9Gd5IhiJ69JXsLj/gGK9FkxUMSA4aBW?=
 =?us-ascii?Q?Vdz70Uj5q8kUBhZSl3Qi6FMI3AxM5bX/8Hu+vpGxWVcuzdLMDWC8aATA7R6A?=
 =?us-ascii?Q?tTDhu1jJm48QLIK67WJm+95S5hdt+EPylUkPwqSYFHThMfyz4O43pZ1WKQU5?=
 =?us-ascii?Q?Po8uWL3eBfBjDVdXJaPjqzNT45UjWl/zpxjygI4yMdyR6xkqdOevLH4FiQPz?=
 =?us-ascii?Q?s6+nsrFK+1mZLfoO2ZA3vncL2j0p8xoO7WMj6m6IpQhtC5kyTT8z9F0XHzru?=
 =?us-ascii?Q?k5mWAjHYFt18/LUPwQ7Tk8vdcdfTAOWRZbe3K2lwQCxi4Qg2B57l5lilQQZd?=
 =?us-ascii?Q?ULMcDw6x6j5dkj6cPJ9chOVFOc5dxHg1nYuuNM1Z4IrnkGNcPBnpehGeKrir?=
 =?us-ascii?Q?VLgF2S66Zl585N9MYXrNLSFGg48HZ/2dR5XX9lAbIWDx8PGFSFgxfDEhk5BD?=
 =?us-ascii?Q?oXO63uuJnlAAhgBD4Mv8HwzbWvuG/m/5h/ug8xfHBIcbm1uzRWqX38k/0qaz?=
 =?us-ascii?Q?8e5MU3+gDJ/Zi2VFEigEJqBdleXZa1Fz2t3hwqBHyE3P+EKvzIUxphIKBgrk?=
 =?us-ascii?Q?Uiem/AuAP6sGcmuYQAsYmidzJ4B3gbVDQxFOoIoKD1ERSrCUVTW3UQ/yCx3P?=
 =?us-ascii?Q?dNDmbyoMGsLRaNO48Zqoc7sKaQOizcM+tU3iLnQMGFU+kDZwqjCbzqiojP/s?=
 =?us-ascii?Q?WZXpmcAkvCS+RhUHKizTrW8IspCm7x1pVASa7Xr+NryOrYYiNshJavh3sJq0?=
 =?us-ascii?Q?qG/0EadRJWM2WjH896IlHLs/DdHa+kVRBrS9w5eGWJh5/gtH4zg9hdAvTLKp?=
 =?us-ascii?Q?/KyRGaKAxjgpzobRBj8BQd7YtM8FmcYr9h8hsP4e3D0yTzIIisZAyH6WYl0c?=
 =?us-ascii?Q?IbFifQfsuNYFcKXIc4rpxcBnBEocn++B5eRpnTEBIF0smz+eXBJ2k01qmWi+?=
 =?us-ascii?Q?OUYqpsZJfuxfXPeVw3Mjex0RysgiIuTNO7Wv8Bn9tK2tJ3yJj+Pg5cTvGlMt?=
 =?us-ascii?Q?vsRKec3O77ShaMpbKAP87z7GGt8fS8z/+MntOwHayDr704OwKxiZFoMtw+LC?=
 =?us-ascii?Q?51SVF8MKUwHB/2nG1iB2eZTwj7dhP2NsaGksszZf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a915b58-5a1c-4a08-9579-08dc4ab93dd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 21:44:25.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tB3eH7m1b6/VTD5UawmEt5mg1NQn9SbH+1EDTMH1noWvEnYwP0W4EaeRU+lSMlHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657

On Fri, Mar 22, 2024 at 01:58:26PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 11:46:27 -0400 Andy Gospodarek wrote:
> > > > It's the middle of the merge window, not much we can actually do and
> > > > this patch series itself couldn't be applied as-is, so it's hard to see
> > > > what could have happened on my end...
> > > 
> > > The proposal was sent a week before the end of the last development
> > > cycle, and I believe the intent was to motivate discussion around a
> > > concrete proposal to converge on an acceptable solution before sending
> > > patches.
> > > 
> > > On your end, what would be helpful is either a simple yes this seems
> > > reasonable or no you don't like it for reasons X, Y, and Z.
> > 
> > Well said, David.
> > 
> > I would totally support doing something like this in a fairly generic
> > way that could be leveraged/instantiated by drivers that will allow
> > communication/inspection of hardware blocks in the datapath.  There are
> > lots of different ways this could go, so feedback on this would help get
> > us all moving in the right direction.
> 
> The more I learn, the more I am convinced that the technical
> justifications here are just smoke and mirrors.

Let's see some evidence of this then, point to some sillicon devices
in the multibillion gate space that don't have complex FW built into
their design?

> The main motivation for nVidia, Broadcom, (and Enfabrica?) being to
> hide as much as possible of what you consider your proprietary
> advantage in the "AI gold rush".

Despite all of those having built devices like this well before the
"AI gold rush" and it being a general overall design principle for the
industry because, yes, the silicon technology available actually
demands it.

It is not to say you couldn't do otherwise, it is just simply too
expensive.

> RDMA is what it is but I really hate how you're trying to pretend
> that it's is somehow an inherent need of advanced technology and
> we need to lower the openness standards for all of the kernel.

Open hardware has never been an "openness standard" for the kernel.

Jason

