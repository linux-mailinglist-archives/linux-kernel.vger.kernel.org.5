Return-Path: <linux-kernel+bounces-68744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD29857F54
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6321C22EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90F512D74E;
	Fri, 16 Feb 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUdOEy67"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB07484;
	Fri, 16 Feb 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093639; cv=fail; b=PR5rq4jx+Ra8p/3+DoYyzafbjKlrlojcibP6sqDpbRQR68HKITVRNoUmfE5IAkGumkpto49IoZxfWkh/rDJhz3AibvGF0pulVAUeXgl88oH+ObUzD6SecCrQzC7f7ECeBEhqu3/V/nw+8wsUnOb/Xb0qEcZ+YYUsRVHLAniDLVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093639; c=relaxed/simple;
	bh=5/u8G4IXNLkj6rz8+ieExSCK2hwXmLMl1D5bKhj5Yw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dJnkjiacutmKlIBFMidDRB3aEYafunawsBc5ODZQqOtOxVAuhKW1x6cWHN+Rph9U2zhfA5AEID6HGFEoknUp9Rh8HllpG+6PXdtvA0lJn/Iczi9m/0umjku3kGsoo4QrWrCdWou6UUG88SGzfASq1+aDotD+ic6X6FvLaU+M9JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUdOEy67; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+5ueFcghgtOadSY6Jl+aAJ0US8PZl5LBjiEa1+PTg3wWgBoTqehyF541xC73W27HTiWNG396H+x+T3ENNb5GJ4Lhd25bSTn9k8k43EziiRXSz+nL4vGTWUCc2NzquhgABU8/16KF5uK0kiXN7Fa3T7geWuoqP9jBPscCeTWtzeXXpVjpCQVpUbukdsjunwBo8PSWd0yumAu4HtemVmXOznunsVc201PkchscyWxlfBWmoUvqqxAtd7zkcAz1Ikn9iIuzPZQcg84815f/JUA0/O8ImXi7kqw2vwCkgzBlo1/1TqeAnlM1tHIqG/lF4jLQb+u8+bCPrH4VSZZOsPAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VF7FAkSdWmCfS8t6MpUPl94EIlzOEJO/HysL2hU4RU=;
 b=GvEqclJ0fZsHsUwegEPz5+2xke4a9AHNSU9Wtm+uviuSN5YfSwj41v8xqYummjXLOopHhH/ok+Am1AhfuimSLTEs9jw6CkGjGoRVqsPy7aLxPlHQzEi6CyTgdfuoDdC7BqKlaT4eYoRMpX7jVxX2DL2OzOz5VPGaWuZnr8yroVgyS9P0jZVaBp7GqAf9bDMcurWzY3gDcmcC+4czQEU6xLoiETttVTY8L170lgKkfg05ckok5eXc5jfHdZ8EnawxYRx0c7zYSPLMC1YPTk2o5iw2WMkFe2EZpO2SBqIdYo4PYXTPNxopqK2pUPXvbFwwi9SchfjOs4V38VIknnbUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VF7FAkSdWmCfS8t6MpUPl94EIlzOEJO/HysL2hU4RU=;
 b=YUdOEy67tg61EthcNauc3+owr98mfw7g1xIQpNjDOA4qZIdmQBM9+pzKtrzYgLEAQ6rgYprGwrn44FmewxLm684qLu4nSG1X2dYpTYfCNroJi6iCFKjgaUL2Nh9UtIDQ/qt8uz5YkD+uvRYjtDTE2oGLG8sIfseIGVvxAJfOAalbL+8ynRtQ5STmFj2d/gWJZU+pFYnu0hcluo/fqa80q1tHpTeeotkoD43bZ2R8fSatzJaRe2jboG64g6b9d/9IWTu1du+vu6WFIJDHNGNOYmhkB37Lm+ALFBQ2qxedID6AiSkYv++N6C3S+t8Dyntdj4YYf1Nf0A1jKUzlkjUaMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.30; Fri, 16 Feb
 2024 14:27:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 14:27:14 +0000
Date: Fri, 16 Feb 2024 10:27:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240216142713.GC13330@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240214101126.0c3681ee@kernel.org>
 <20240214183755.GH1088888@nvidia.com>
 <20240215174034.34817c31@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215174034.34817c31@kernel.org>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6843b7d0-0791-45be-056e-08dc2efb5f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4LcH2v9D9FaXKsKzfqyYf11dsToE7cB+HEH6rLUjeegtOJh3X1K5DbUIklaUtgtWwPHtu/Ec4/wE4iT+STTWMPg9xsRgO3J2RBzXoVISD/7hYVmcMEYnEcWzQzug/fXaxHzw0RuGRqNtjvKxOEqlR5oIUvjoysn10LVkNkKsP8ll4ib8AtWu+a6cpkkiXsKpwcYFlEQwysZnxREbTkiTNtUWeLoOoBWJ8RQDaTGZkaQ6GEDiReub67kEPL/CzYGYS3651neIWqEoyYnMhEOUWwosU1WDSGyJpEFDmtUrE9TfnJ0xsKDTEzkzcOmePfCkSFAcrRbyW8rYbMwBkbOhIWCRFTb8SPZeLsB3EBWE9N1j7p5qChXNZ7oLyHVSJI+NVgJAYCRg30uNE0LHvJa2JpIhXO9dTxkuBHq6A1UIShx6Dj4H5AOBeQ8ZY7+1mJGWTqGjWsD3x1fpwCNCK/qYWU5Ty/Qg640h2BT1ICRDUFa1ByVyccbk1yDdONDpmQV0NsUG9Wq+AYLDYrgsshzHEUFgOlL3d62InVbocqCrfqTe6sMdKkjGyCFn8H2ziiH5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6512007)(6486002)(478600001)(41300700001)(66899024)(4326008)(66556008)(5660300002)(7416002)(8936002)(2906002)(8676002)(66476007)(6506007)(66946007)(54906003)(6916009)(316002)(2616005)(83380400001)(86362001)(26005)(38100700002)(33656002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ydF8l6FotckfIEpitbGug+UaSmY5yhlI2vvwge2BFiYVWyhylzxFjaO3fQ4B?=
 =?us-ascii?Q?JXKREItMy/26PaXAvomqiPMLWl/Bub1HFCriqV5MTtL0mA9WXGaYRTzHb1DB?=
 =?us-ascii?Q?Ehrh3qMKElJLMB2FXyTFqDfo4OOJESkeGE6kz738sgaA8KnZ2PmXvFdk90PP?=
 =?us-ascii?Q?cZjl05if8NLypIcXWuDgWNZNKroMg/V4oYvnXJ/zdoQlBBt6qBDFWcLRZxSk?=
 =?us-ascii?Q?6oef2NEU5E/GaZyBpokjBVjQBfDcuCDQTSqljrKtx52l2j+OdKIb/tVeh70e?=
 =?us-ascii?Q?0wQz/ELOJPZ4/vLmY/1q1I58/kdJM9DdkFfhyGo4MqZfiqC3kPa5bM4AAPT/?=
 =?us-ascii?Q?0pVsgevpzT+ZXUjshpV7TEkVBFjFsnxd/3dqZZCAZEboTca/O/toCMIvajw/?=
 =?us-ascii?Q?ac++4wfIVwkj40fuzdOueD0e4F6hQrJC/m/xoiREjKsJy+Oif1slHBAU3y8i?=
 =?us-ascii?Q?lwL6JnVs4Gnyf6AAewajiOtNbpiTKna5iTuV2jLYz0HxAwU3mj9U2fj9yMQv?=
 =?us-ascii?Q?uGUyzaskpVZxizNIxr3JaeP5HwevAnzKlQiHddNwq10DHOeygZ0kmWobqbnN?=
 =?us-ascii?Q?qqbI6vdK4nIb9N56lwwI73IAmkS99MM5ALN/oh2TQCSeQghRxAMBC4/5K1R+?=
 =?us-ascii?Q?dQbK6mu8kRZczrsaXO26kyboR8mgXpvN42xrAk21ShV2CwWyBqRvOhVS0Sxz?=
 =?us-ascii?Q?/+mbDdvR4p8v/EOKQpk0viXfb8ljaheBHNx/tay/jZrLQKTTlYc6HoU5Lf+2?=
 =?us-ascii?Q?6fsp8B1EVIlHYSzVAjB8CfN4Iw9RVbMTvC1nNzD+yzEyTdVcsuKbj3TvXbH3?=
 =?us-ascii?Q?NVVrkeVKCnhEnIN7KzaoPyafLnlKvO963P1GC6qplGC2m038syJkDJ3Ds5su?=
 =?us-ascii?Q?ROT3/0rgU53jxVIhL3z+nhAJ/nnZOLU6uaG4YeVqjlJ5/en3DW/qxoArjgRw?=
 =?us-ascii?Q?MGl2NfiGrZMiwMiPZZ0HGmB+7eb/i38zRemRddK2+HXFXxR/shcl+dyKC7w+?=
 =?us-ascii?Q?G6iasHxbGLagVmEvDMbiCVBStn0NbM9xwS7aSwbxqH0+hHa/byqBpfXqN7+X?=
 =?us-ascii?Q?VhggjreUL1VM4cc9xtCK3bNV//UFTqFANtOLl43awWZML3WCgaxrRmgqSOxP?=
 =?us-ascii?Q?nXWU8imnPJLK6QJBRkwtPyVp1TjlKJEdHPh7dlKrWQ112uTXAOfXQE5e9w8O?=
 =?us-ascii?Q?gdGMFaAM1yMo475MEV+cFAvd5YjFIP2TLOQjIN9OSZbsDSFOvJfRDpfK8LV5?=
 =?us-ascii?Q?YSk4Sk/1fRE6yGCC7Vu7BMG1CKkYVVBEw5z0Ak1x7ocBCsGjPFMFAQ4l+ezO?=
 =?us-ascii?Q?F74b9iTo3gpfhtspTfwE4/euBB+STDMcki1khQMT3WuhJZ4A+3bkfcXNKQNw?=
 =?us-ascii?Q?VKOQ4gCfcxzXGkBFeh5i5SELckNLrPf3kqZ22YG4oimJkDoWCEGhqdX6qTHu?=
 =?us-ascii?Q?tw9Kas59rDC8VntIX4ja8GQYk1IQaVa1nKQUM4UZeVn4uu4e1d7tR00LRvLF?=
 =?us-ascii?Q?PWZxYepYviARyb96KSgFNqJhdFycy9p/rgCi0BUGQ0NFycM9mpmgObl8LDVU?=
 =?us-ascii?Q?lV4/skNhcViD+izpoBr/7P6tWFKsMPHoFALS3Cbi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6843b7d0-0791-45be-056e-08dc2efb5f01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 14:27:14.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksXltZlPmH0e0V9DO1zXEUkpVqHAiFq2PLzBvWYYrNr/XjTjlvVa4mUr7HNJbBSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761

On Thu, Feb 15, 2024 at 05:40:34PM -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 14:37:55 -0400 Jason Gunthorpe wrote:
> > On Wed, Feb 14, 2024 at 10:11:26AM -0800, Jakub Kicinski wrote:
> > > On Wed, 14 Feb 2024 13:57:35 -0400 Jason Gunthorpe wrote:  
> > > > There is a clear split in my mind between:
> > > >  - inspection debugging
> > > >  - invasive mutating debugging
> > > >  - configuration  
> > > 
> > > Yes there's a clear split, and how are you going to enforce it on 
> > > an opaque interface? Put an "evil" bit in the common header?  
> > 
> > The interface is opaque through a subsystem, it doesn't mean it is
> > completely opaque to every driver layer in the kernel. There is still a
> > HW specific kernel driver that delivers the FW command to the actual
> > HW.
> > 
> > In the mlx5 model the kernel driver stamps the command with "uid"
> > which is effectively a security scope label. This cannot be avoided by
> > userspace and is fundamental to why mlx5ctl is secure in a lockdown
> > kernel.
> > 
> > For example mlx5's FW interface has the concept of security scopes. We
> > have several defined today:
> >  - Kernel
> >  - Userspace rdma
> >  - Userspace rdma with CAP_NET_RAW
> >  - Userspace rdma with CAP_SYS_RAWIO
> > 
> > So we trivally add three more for the scopes I listed above. The
> > mlx5ctl driver as posted already introduced a new scope, for example.
> > 
> > Userspace will ask the kernel for an appropriate security scope after
> > opening the char-device. If userspace asks for invasive then you get a
> > taint. Issuing an invasive command without a kernel applied invasive
> > security label will be rejected by the FW.
> > 
> > We trust the kernel to apply the security label for the origin of the
> > command. We trust the the device FW to implement security scopes,
> > because these are RDMA devices and all of RDMA and all of SRIOV
> > virtualization are totally broken if the device FW cannot be trusted
> > to maintain security separation between scopes.
> 
> You have changed the argument.

I explained how the technical bits of a part work, you clipped out my
answer to Andy's concern.

> The problem Andy was raising is that users having access to low level
> configuration will make it impossible for distro's support to tell
> device configuration. There won't be any trace of activity at the OS
> level.

I responded to that by saying the answer is to have robust dumping of
the device configuration and suggested a taint bit if changes are made
to the device outside that support envelope and can't be captured in
the dumps.

This first part is already what everyone already does. There is some
supported configuration in flash and there are tools to dump and
inspect this. The field teams understand they need to look at that,
and existing data collection tools already capture this stuff. I don't
view we have a real problem here.

The step beyond Andy was talking about is the hypothetical "what if
you touch random unsafe registers directly or something" Which
probably shouldn't be allowed on a lockdown kernel, but assuming a
device could do so safely, my answer was to trigger a taint.

Then you asked how do you trigger a taint if the kernel doesn't parse
the commands.

> To which you replied that you can differentiate between debugging and
> configuration on an opaque interface, _in the kernel_.

I did not say "_in the kernel_" meaning the kernel would do it, I
meant the kernel would ensure it is done.

The kernel delegates the differentiation to the FW and it trusts the
FW to do that work for it.

> Which I disagree with, obviously.

I don't know why? How is it obvious?

> And now you're saying that you can maintain security if you trust 
> the firmware to enforce some rules.

Right. The userspace sends a command. The kernel tags it with the
permission the userspace has. The FW parses the command and checks the
kernel supplied permission against the command content and permits it.

We trust the FW to do the restriction on behalf of the kernel.

The restriction we are talking about is containing the userspace to
only operate within the distro's support envelope. The kernel can ask
the FW to enforce that rule as a matter of security and trust the FW
to do so.

Jason

