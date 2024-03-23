Return-Path: <linux-kernel+bounces-112159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F6887660
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E31283E02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A929138A;
	Sat, 23 Mar 2024 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAL2kEDq"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AA5A31;
	Sat, 23 Mar 2024 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711157623; cv=fail; b=IJwVtOdNTGsQ8GsCoprPp0kh/9XFX09Zv3iTWeICZRLhayYhuJlRZvC8nJncRoELTo6pUXRNDCBjGXJcmkwOouz8gfcPWyBd5dF3ukJp6dNXvLGmlB+bLZ7NDI6PreqZ4RjnYedZjna9HfcmDmmWqdFmrth/JqmZCws8mure5xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711157623; c=relaxed/simple;
	bh=0aWLV7nvZuAF8kVLkp4cgOFJ4FL7xsYZB/YVYR9Mwew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OP8cKm51gQmCba/wwxZsRM7bdwq6HNDkx3xoqID0v/6KlxK8cCVscyOnDaKWHW4mubZNzUT3Ztg+IAx1OmUJAHRU72sJsJ9V5tcMU8qe8SKhqfwX9CVJY0g2Ye+WlG5WVX8QGnQ/0PWbSGFvgbqFTKaF3ZhkQUKjj4Ym3byZUPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAL2kEDq; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GyAbR1nuCuyobIwBFcAOYktBiB5ibX9DaAv7jrzr90LFR4nI+SjbN6gJcmdQAVHpJU4pDCu88XL2z6qt1cNKCSRLuMgtqz6POPp3ZaIGCn177IiGTyaF8qOTCTo2HAQKZYY5RrUfmZ4F2FbNNfvGr5iefWZc06erU/tifwF+xlaZQ+KSDJxPibEtmtvW7BpIwW0Cc1TqWeTbZIvijrthcrNqx+ngQOmwU+QdMFU3zr7Nl4rqHH27CREPctir84eDY/fENqIBSnKuvtmRRhdIYA2NQLRnqGLJsZDTmhfSrPh9b+zVoVmudWP+THnirjlkTicgDzJ0H74wfLkSjsl6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4wUUMwbSsRPJolLX+8n+JwKQx0peEaRFN6wGdU+SCs=;
 b=JiJuZ8gXCm6gS5OflS9ijLywa1LDM2R6pD6b2PGm0aPWuV/R8Am7+Zwp8p/GzUmpuyewG3DToQlKNba5XRGaAVDrfTu95TlHuQOyig1vkix8a45e1/dLPdvpAyVB7225INKSew8KifLm0MfMwYpxRiET1pwU6sAblA4TUV+pW9JuNHM6/kDmy4kcnqzv3oq9474JYod+/EdzQkQeUfQql501jpP1tdLnmY3Y2u2C4HqK8yKQJ/Q3qY4c/1tIDrWOuugBQZmgZZbWEpfe41Q6rGMRAqrNUYntMizRucn8VPiCElR8PId5fODAKhPn3ILnaWb6FoLmZdpSob+OAjNCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4wUUMwbSsRPJolLX+8n+JwKQx0peEaRFN6wGdU+SCs=;
 b=AAL2kEDqpDqQQEI/vls/IPYAW4QuCsRwZZLkeoXCKc6uV9fxqBiBEOAvjT+fQsiA1DZRRxX25zKDeNi5pZUcpPqbYcdQIQZBHhcJmP/2v6gqeCLpP5gRkMUmtD7LmHZeSKtJkOQtIlOzGs1PMA2AWwFKuA7a30RC4cpQuXi511k6AsjsDnuxnl+//2b9VWU3/Tc3f3PYxsOJ1uMns/Qhg5Tc9tG+ZudXeoLE4Fgu5Plcr1r1KN++Pv+B7upn9WJyRVvfN1DcOrrk/WmilDboyk2Qs/+cXL073K6sCzJqE6OBU5UUxCtC7nah1kWnffdiCGi5+YnDgSoFgjKNDr/C1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Sat, 23 Mar
 2024 01:33:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.026; Sat, 23 Mar 2024
 01:33:37 +0000
Date: Fri, 22 Mar 2024 22:33:35 -0300
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
Message-ID: <20240323013335.GM159172@nvidia.com>
References: <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
 <20240214175735.GG1088888@nvidia.com>
 <20240304160237.GA2909161@nvidia.com>
 <9cc7127f-8674-43bc-b4d7-b1c4c2d96fed@kernel.org>
 <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG>
 <20240322135826.1c4655e2@kernel.org>
 <20240322214423.GL159172@nvidia.com>
 <20240322152924.64be7ec4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322152924.64be7ec4@kernel.org>
X-ClientProxiedBy: BL1PR13CA0101.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 3990ba83-db3a-4b5f-5a26-08dc4ad942dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aPPBGzvnSn99y8Dyays7wvmVLW3otElSxC+7t/+xj4eprN/jMaF8wv1oQ0CLV97ZRxDrYYhQPSCkufcI+o1XPwUUgNIOPSgW3Yr5CfPyFCEOx/Zr5kGFJLP3oiTfvV5RcmyIlUbKO5/j5zb1SAto5Yt/KPPmDVTxha/igUwQb3M1H9HTeAXmkZ1oxgMYCqEOyGkqU0tDZCkGwfJgoaqocDIS2yzP7CIcdpLMXDkauXQo+js9wP+XwNQdrrKcHVYPoV0s9q52W/hueKB60rDVHVjErSE2FccgXDf9qPz0REbYLRVlJadvfOcY9fw1Ia7jLbcmbSY4PXSmiWu15rHTinezqjbk69hJgypOVCk6j0qvQsA7LwkgIuIc4PlKtOo95Su+0zRSiWQ0LOWQbHYmnjIlO8AlQNGjf/fIXu9cgM3MixCLXrhWqATeoJOtjkXhP81LT/v47jaEs0wjalVTE8wRS8qm3T42nIGrUrcj8bsZH7xOR6vHXLBJoYOlePpnLvhooyhv6WLcnmjnrZkSZy3LHZjDAij5PUp5NdmVX0NSeaLbkRnZq8rmRk0zrsb9fRSi7doBPy/ahFoog47p+K+mP1LbzWLiI+QIaIk+sR9AOPGcrHRo0lfIdXodySglSZbv0959uqKxZtVIAPf++SQ8iDGNJI/wiACwm/Kj7vA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hs/RFWIbaFw26jwk8SfvVWo2zMd3Or/MVUMy7WtvZcR7CmiPw8Bv5FKwX6aa?=
 =?us-ascii?Q?YkoPCER582Ji9NzrTjkqOs58XPhQ/ctM3yLYz74YyZ0pFSlCZHQoQvavB7vp?=
 =?us-ascii?Q?TNgmAQhnnOtDNm9UHN6Ed+yhxWeRi0iC8bFPdKNqhDnjn6u57v6j4N3LepNM?=
 =?us-ascii?Q?PbYWZ+yoeRQwqtRs2mL/z5lBl8Q1Bg1HN/tSKmxcLO6CCtFWkQZucaZ6RqIt?=
 =?us-ascii?Q?CrkvGKqbIdPINZLwvd272Vb/WBf2IcBMy1y0AdfJfeRxC/FWCBiFNX0CcLdy?=
 =?us-ascii?Q?Qy/9uINYqYYzFKx/qZL0N2OSrw5hJfY4wqcxKDFlY7DFC+btltdTrL3eEnpb?=
 =?us-ascii?Q?xN3Iz6qo0je4BpGuT1zijXgmpI/LvbJIAnWMTZgGE+ncIzG6YGoCzfCL9fae?=
 =?us-ascii?Q?jIPX5TL+gyGBuMRnTPxJZBEpMd8X0UrKW3qc3i8iFJ0KpZt4Q+sESalz2ZgA?=
 =?us-ascii?Q?7FD9LddUjoL5zFGfFhEAu7hTGrou2L2+J2J1pd4CysXcLxieUL3fg2MXI+6z?=
 =?us-ascii?Q?Ie/TE5uVlKTUQFaMyp9RYgCqkLq/C7Idb3GK51S3XIgD4XFQy36Vuv66PBDR?=
 =?us-ascii?Q?2tiaup58hxh2Ax14jMYmCQaw/X7dt7KTkiqD0jbQIPu+Bsu0pVrcCWKEFjOR?=
 =?us-ascii?Q?cIsF+sD138YTwhWaIcmoV0EL0DdXf6kLDvFw7gsG5TKzXUace1AGuVjSD0cI?=
 =?us-ascii?Q?zdXQbF+AvGjC5xBs8HrldfzgmO4GfWq9wJgNdtpsm9b/iah1IZmzxsuOns+2?=
 =?us-ascii?Q?waUflmrSpCGE2coy3dIQSNDmyZlyl1Zi8RISjbM6pnFNQ6RY0pP9NVJjdB/S?=
 =?us-ascii?Q?n2G3fPGrI6xBg8zJTLzElutKfojCT3TxGyTbXPeaK/XWnfojU94Sli1tMMcH?=
 =?us-ascii?Q?BDMuxTzDoZejugFAsRxLPnOnMuPG5RDlLFuiBeYZUSy8qnqBJepUs2iYDrh2?=
 =?us-ascii?Q?HO5f2RSzmyeCup/qLH9jIiO4SkxH/+idbaf71wPS5u8NkG3F3QPcMXfzVqoP?=
 =?us-ascii?Q?ZUT9C+Q4uigBtw9gzI7y4O77tnBsDLEmFRrgY37Ott+r7kGrdJUdWY4905Tz?=
 =?us-ascii?Q?//d5EX/BfmPAFWILWKtUUK4B4AFW+VEdJN8TDuLAj7YUbGl0qRThq0F9pQCw?=
 =?us-ascii?Q?FgZgXx7Qid2k1BqeJHpSuwymnEJDf8pwwxuwacuDkRgbZ97Faiar0RVGeN6M?=
 =?us-ascii?Q?f6Ns7wYpO6xLGnrCCy7Az042XyG4H3t7yMnDScjeOdN8SLpz7vEQJAROGzfP?=
 =?us-ascii?Q?l5cRVGubfI7DCtDumIrk7jLfn7sAM1JOkkI9RSvJ0hcdFDb4UQhafL0A0Gg8?=
 =?us-ascii?Q?jnNSi3Pk3D/qHSRQD357XTVSTSyFfH/sTPxrQrMJysB5zABQdJwAN/ev2thk?=
 =?us-ascii?Q?Np/y0OWjr60sR/4wYYe2OenMhQkZ+6fyiIubAiIW0g6tZ060Wn/5pXEhuo+D?=
 =?us-ascii?Q?y/VHc+TAnA8+QDmzFlE/W126UAxlZkJOqS/gcUTWYAyGXT1bzyCaG7ndm0eJ?=
 =?us-ascii?Q?QuVKCYAUuiq2FMHzkrutBohAJWgm2U1+k7LJOqzzbiD8WPCRrGzQAkR2Ruec?=
 =?us-ascii?Q?F3+Z5M9u7YIKm+xdsvsz9kI4khhPDvyW4jDYIlnq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3990ba83-db3a-4b5f-5a26-08dc4ad942dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 01:33:37.1201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ey/UvT9GkK68ETRcj+Va0zIzT2VYskvAw7EUSjUlMEPLw2EIKROZlkf+Fer8zmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954

On Fri, Mar 22, 2024 at 03:29:24PM -0700, Jakub Kicinski wrote:
> On Fri, 22 Mar 2024 18:44:23 -0300 Jason Gunthorpe wrote:
> > On Fri, Mar 22, 2024 at 01:58:26PM -0700, Jakub Kicinski wrote:
> > > > Well said, David.
> > > > 
> > > > I would totally support doing something like this in a fairly generic
> > > > way that could be leveraged/instantiated by drivers that will allow
> > > > communication/inspection of hardware blocks in the datapath.  There are
> > > > lots of different ways this could go, so feedback on this would help get
> > > > us all moving in the right direction.  
> > > 
> > > The more I learn, the more I am convinced that the technical
> > > justifications here are just smoke and mirrors.  
> > 
> > Let's see some evidence of this then, point to some sillicon devices
> > in the multibillion gate space that don't have complex FW built into
> > their design?
> 
> Existence of complex FW does not imply that production systems must
> have a backdoor to talk to that FW in kernel-unmitigated fashion.

I think we've been over this endlessly, production systems require a
solid debugging story for all software in the system, including the
device FW.

> As an existence proof I give you NICs we use at Meta.
> Or old Netronome NICs, you can pick.

I wouldn't pick those, they don't meet the multi-billion gate
criteria.  ie expensive chips built on the most cutting edge and
expensive process. Smaller chips on non-cutting edge process have
different economics. Startups have different economics.

Look at something like an Intel/AMD GPU or Habana labs device. Lack of
FW creates a very opaque driver that is twiddling megabytes of
register mnemonics that is incomprehensible without HW
documentation. A win for code availability, but it hasn't actually
crossed into being usefully open.

> > Despite all of those having built devices like this well before the
> > "AI gold rush" and it being a general overall design principle for the
> > industry because, yes, the silicon technology available actually
> > demands it.
> > 
> > It is not to say you couldn't do otherwise, it is just simply too
> > expensive.
> 
> I do agree that it is expensive, not sure if it's "too" expensive.
> But Linux never promised that our way of doing SW development would
> always be the most cost effective option, right? Especially short
> term. Or that we'll be competitive time to market.

By "too expensive" I mean the vendor cannot produce a chip at a price
that is salable. Or a startup goes out of business because it can't
afford to respin.

Linux promises community collaboration where the community members
broadly should be driving the priorities. When TTM matters and is
agreed it is done. See for instance the various massive security
fixes.

> > > RDMA is what it is but I really hate how you're trying to pretend
> > > that it's is somehow an inherent need of advanced technology and
> > > we need to lower the openness standards for all of the kernel.  
> > 
> > Open hardware has never been an "openness standard" for the kernel.
> 
> I was in the meeting with a vendor this morning and when explicitly
> asked by an SRE (not from my org nor in any way "primed" by me)
> whether configuration of some run of the mill PCI thing can be
> exposed

"run of the mill PCI thing"? Does this thing already have devlink
knob? Usually "run of the mill PCI things" are configured through the
PCI subsystem, not devlink.

> via devlink params instead of whatever proprietary thing the vendor was
> pitching, the vendor's answer was silence and then a pitch of another
> proprietary mechanism.

Our team was very excited about devlink when it first came about. But
now we have so many devlink parameters that have been kept out of
mainline I see that the excitement has died.

> So no, the "open hardware" is certainly not a requirement for the
> kernel. But users can't get vendors to implement standard Linux
> configuration interfaces, and your proposal will make it a lot worse.

I don't agree. If you can't get your vendor to implement the thing you
want on devlink right now today, this fwctl isn't going to change that
one bit. You already have the vendor tool and the vendor telling you
to use it. It makes no difference at all how the existing vendor tools
reach the device.

Indeed, counting on lockdown to break all the existing vendor tools
and render them permanently unusable seems to me to be straining one
of the few hard full project rules Linux actually has: don't break
existing userspace.

Think bigger, maybe your SRE will be happier if as part of this we can
get the vendors to agree on some common userspace tooling for device
configuration! Wouldn't that be a great big ecosystem improvement!

Frankly, there are many forms of common interfaces and many paths to
get there. I don't view your very restrictive approach to be helpful
to growing this space. It hasn't delivered a working ecosystem, and I
don't think it ever will. Instead, as this thread is showing, we have
a bunch of unhappy community members and poor upstream support for
devices.

Jason

