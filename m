Return-Path: <linux-kernel+bounces-132895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19938899BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84BFDB2327A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DA16C45B;
	Fri,  5 Apr 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CA3un0XU"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D121CD2B;
	Fri,  5 Apr 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315592; cv=fail; b=rsjsRhrWwkFPjKu1KhOYPHbYq7I07nn7+XfA0E0ySUoX4VNdg20TKXj2Ie83jI2pEmNxh5Zm/Rw6jrGG/GA3Dr9tai8aSR+6hQ0gBqLuWxNeMbWCAQbFc5FSf1vjsVehSHlF/ajxeF7P+RSURRew8v8gL0kFhj0KIvTm1q+tOeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315592; c=relaxed/simple;
	bh=xN8iTysxSIsY8l0FOVg1UF6VK1mXaDq+QofUED0ZV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMo4oJeNBXyfOPDn5W/pXtV4W13RP2UUnNJf6RdWITYWlKbSMflXgmJFZRzHuEgOwEVzGmfqHz5DGyG5lpjOBqjGQ1ow8HZA5xOv+pJkBeL7FKCu3xSsQomBvmz6BdZIftsZBPTCp6xEuG03ZrE8RkqEfX3+uyg4Fn2hoRhwQvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CA3un0XU; arc=fail smtp.client-ip=40.107.223.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1FQn9AB3NT2w5H0UHRRJ0inV/oHCFp4RkZcRPXkQtd6F+FxOo+tQsIhSlV4LAe63u/uQBQBjaDS5WadlPJrnCGWTKpaIVVlIMDpFEVFDmOBGIAlhG0zYmiIKYdRCjvxOmdAWbtws6/yksZ7Nbtm/x26GrfKNipSORyqHpUYoSFs7RNYvWvrCvXCkALghPJY/TGzkYnQ8ojOo7EEssUrPVpQ5A61EkH86DF/68/jYFWHgU00igkyduy5CcQtggMEgl3InQV2mVEIyh9eblqo6Vlc3oQqWlXGHfyyhUuyv84uXnBHswboohIJHThwatVwoBhOVCQbkRECdpFhKudCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcLOhhqcF0QaObmX3dP6pNg2dpCc66605bO61xGNF6E=;
 b=fP0FolBjjo4IkbC3HMCVaBj/o9Rj5mIsQWEtoAgThUalyxmmiRCHFj9yn9hJElMu5s/hvZsDrbHcB4z6C+UfUU+Vn8R0zLTi/KYYhza3NDRCFWpbQai1wE6+RLdVq2bMacpUtYMxhLzE2DKAQxpq428/dTpHQbhw7bgnGzJJ+nZNu1bArgvKB3fJxDADj+pm0cDw4K+CROFoT+h3X2r0CckIit9O+34ho2Y6BiZlO1pUXHTSyzfw3llDvkpFupfcahKM/Ipyt25FAD47saSEORCgpjlA95PFzAVkaYLqD8wBeOm2YE2YqvDjBelwoV9nYFnvPMOKEdtQCIItR6zAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcLOhhqcF0QaObmX3dP6pNg2dpCc66605bO61xGNF6E=;
 b=CA3un0XUE2vdt3N2HrU5zj8noXrmbC+B4N0u+mEqqFFmE3vC16zDr393j6pFEUvphIvyMAIPuXhj+XLsZ8nvkAXl/lrWWnpmzRChoTxhb6JM8wvA8wUvqjLeh9Smtll76YeCgRwJACzVf7zVOyL2XDxG39GjZlR0Js3ZHjcEvMW56lM1rbEsP2G4iLUf4MtRlboS3kmpQuVr6aobWlFtpKx7Enfs1l0bgGUoIETHKLLja5GRUdl+kd4YR4opOIhF0R3OfDn/oNTWpPeHiV2NW1JmjcNlYAJtOAZoEqT0LQM9SjFOKlAgrKoNea+FtIWUAM8oW15zkKMlFObc6RyM/Q==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 11:13:08 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 11:13:07 +0000
Date: Fri, 5 Apr 2024 08:13:06 -0300
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
Message-ID: <20240405111306.GB5383@nvidia.com>
References: <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
 <20240404125339.14695f27@kernel.org>
 <20240404204454.GO1723999@nvidia.com>
 <20240404143407.64b44a88@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404143407.64b44a88@kernel.org>
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB6326:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lxw9Pxd0C3OJ4TLxUcMK7iPpM3AqGkkQDbi63RE0gzzdwtRwhYjc5MItkbTySQs7Rl3XF/Va1ljd9i85W/aZrED+WCTg6ZuvOmPUy8Nks/DvE+SdpWz0SdXXL4vmWDEhIieSwJj3TlUsPjE3HMtzf91p5RDWl54kmMzqN0tzp6a2w4d67VFXW3LN8wPfjoRK6MAFzn92VuodTZoCvCrLUYzaAqc8IRFhry/28RvzISdl+Bbvwu/4qm+LUu+qFMQvyIJgvup646Iydc3FqVQjzorHmyTrtoqyfSFV5WHWLupcEWH6EnxASeDkSjgT/ze5CksDzawDULNBdrWipvfVE21bgjthQv/DWValnS4KwGB8cHnGUQHX5dsSFo9S/g2/06TJlDgRgMFpAa4PEHJaiApny91LH+p++7P7EpY6joiq+SnQ5NQM2GlE7Tu6qR1sXqiXvrG9FUmVhIq4hL4geF3+xA8a+4iaiJ1ElMh1Wdum9rm0ge0UVry+ILgu5q7aE6Pad/kORtYGpcsSnHtyNWEU04LxqDr7ZVAEjQnU+k5kVzt+NIG7V+i7htXY3R6CcUg8aHVEZzzRWd8U7Y7rcEZn03FYadJ1vfuhg0pS2AMJmIo5Vo/Orjre6ZhJw90mB9qb0Yiy8xzgYq971Q+ANLXIFwAa/WfIOT/pMMtED3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5KX73K4WMZBHH1Z+YgETReDDoiAOKDZkyLBudf1Cwcq+G1FwfzQP8r9gzUQv?=
 =?us-ascii?Q?K00yjbQhwSH6bp2WfbHcGYEnEkdy0nwk+9EmhHTTtIBNs+/LBiRJezsRyEpf?=
 =?us-ascii?Q?puwRyyv9FFZn7m6CfzMmQzAKlfKOiNDwOQDJcsthbCZISZm65R2VmbFbkOCe?=
 =?us-ascii?Q?iSpK8zlZZa/el+HB9hYoP4uQpAXNwb/E9mvxbREE+N1FOPbQ+c2QgdB42JIM?=
 =?us-ascii?Q?vryEULZHvrEzY2LAgn5FRuYl0Om06MhUazkg5+/b1D/O27tB6VPS0Uj81a9t?=
 =?us-ascii?Q?qz7qXM7Hq/kFLNt4fTzBLxjj89xo/tXa6cNgIi3PiFrrH0ZMP68Q7jy+bZoH?=
 =?us-ascii?Q?u0HiGQVYOBRduX92GB11+wDiwuwa4pXRCB90NS37jPdrnoiDTVJtkqaAiVjp?=
 =?us-ascii?Q?6JoyaLdV7pCaZMDFArsyrGTDy+EJbM1SgijCANqgtm05OqEcXV2GU/lIyvX+?=
 =?us-ascii?Q?u2/AGGrt1sw0vX2DChVJSMDXH04pabHsv5JrPl+mkbmOquXOX9mUjwvIODoW?=
 =?us-ascii?Q?aFLV0Fm/7I7oePMVpk4NhVKtURiibf8xtbur8LibYDloMUnSd7kr2yRglzkU?=
 =?us-ascii?Q?SZ391MFs+XpXnJerU8byY/IvgBIgtTRM57VwnMw9Rm1wIAu6Qr9Hybp/6hOW?=
 =?us-ascii?Q?uRx/s7H/5rB95y38OhMrySr2Dq5MhAsIpvjB79HOBOtt0ESs3ZoOpe4OiuFh?=
 =?us-ascii?Q?89ifbhR1oT6ke+osItTs74EbDezqWHcM6ZtRzSUgogKn5Tayc0w5akdpORbZ?=
 =?us-ascii?Q?O4KUz1Lj7C8RmNPd8XfdnX0ypIuz5fDCOZb+aMG12yMrvLGuep7gXiGAAeWH?=
 =?us-ascii?Q?s03XXYn9xVfATI7D5wwn/sxjYO38+FPkLrLfPsJzova30MGuUo4o0NrRgjcn?=
 =?us-ascii?Q?u111e+bK91Y9W+75s2isTCMca3GCCEFjeB2uony/G5k3HQZ3CFDaykdY1qml?=
 =?us-ascii?Q?k4i0TaEK8yGi+wXUPYgUgDvZzHICJd7VvQy319dyNxCBYhyfh5RQStLI4v47?=
 =?us-ascii?Q?QdNsO6B/4L/LY5b+KjOFUxXmvqUGrCeDaVUm3o+bBi4aarI54k8xhsrdj5rK?=
 =?us-ascii?Q?7kdP8wVeA8GNqS8FEPGEfHqVyyu+rUvol+zzol1mC5pg1crOfSfQKUcX3DA7?=
 =?us-ascii?Q?TSliwl1re18npG5kSV4tpqpurXrc4rjBeZclS5QlQfT1Dj1gAFltS7JqMkU+?=
 =?us-ascii?Q?yxK+3Bj7f+1uNix49eTGNM/2ktUcMgbmjGGfUyPkLO3sLZBpHcrDjGJAMy3n?=
 =?us-ascii?Q?MkF2cwCekotU2Cs2xhRTR1FRvJmairHnIPqfd9TAHPzzk42h0uzTStfNP41q?=
 =?us-ascii?Q?/NiurHDo4SdLR3klAF4aO8QT25DEs/XC1Hq1g/Oavc4yp5efBrGAIMGNuDvQ?=
 =?us-ascii?Q?aHdBlVfTKIAeo8FItS1JTNopxbFQWOH7BAaQQuEdyVjOgUavSSKXamyxGyms?=
 =?us-ascii?Q?0r0ZZlc8/4Vu1UClIIEFtfe5x7noK/dSKRDCSK9wp0jLUuJhKAsPmB76PjXo?=
 =?us-ascii?Q?tZvS4QD8iRXXRxQ7i0CxnlgHOkmoMawg54yJ7ejCQMEg9EP+43lnFITIHtmj?=
 =?us-ascii?Q?pkpnmiS1EW0kK9MqQ7OuqnwWvevYB7QkrhxeEdi2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4e4bc3-7ebf-487b-44c0-08dc55615f20
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 11:13:07.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWhEDUjRnn5LN7wNCQWih73o9esqEeqj6ZclJmlP+OgQbuFb58MylQ3qYmk4InQV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

On Thu, Apr 04, 2024 at 02:34:07PM -0700, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 17:44:54 -0300 Jason Gunthorpe wrote:
> > > To my knowledge the "customizations" are mostly around fitting into OCP
> > > servers.  
> > 
> > Nope. I understand it is significant. If Meta had to work with a COTS
> > environment like a HP/Dell customer then Meta would have a list of
> > flash configurables to set. I think you greatly underestimate the
> > privilege of being at a hyperscaler and having vendors create custom
> > products just for you..
> > 
> > > Those unfamiliar with how hyperscalers operate can mentally
> > > replace $hyperscaler with HP or Dell in your message. Minus all the
> > > proprietary OOB management stuff those guys also provide.  
> > 
> > A significant Dell customer will get a server pre-populated with a NIC
> > with some generic Dell configuration. In most cases the customer will
> > have to then program the flash to match their needs. Set a specific FW
> > version, set site specific configurables, etc.
> > 
> > Similar to how a Dell customer will have to change the BIOS settings
> > in the Dell to match their needs.
> 
> I can only guess that you are again thinking about RDMA/HPC.
> Flashing tunables is not a workable solution for extremely varied 
> and ephemeral TCP/IP workloads :|

As I answered to Anderew, a lot is functional behavior not so much
"tunables". The same way many BIOS settings are not all tunables but
have functional impacts to the machine. Like enable SRIOV, for
instance.

Even for dataplane tunables - you know there are micro-architectural
performance tunables set in the special Meta NICs that are wired just
for Meta's special use case? Apparently that is actually perfectly
workable.

It is really strange to hear you act like "Meta doesn't need
provisioning or tuning" when the NIC Meta uses is *highly* customized
specifically for Meta to the point it is an entirely different
product. Of course you don't need provisioning, alot of other people
did alot of hard work to make it that way.

So please don't use that as a justification to pull up the ladder so
nobody else can enjoy even a semi-customized device.

Jason

