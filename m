Return-Path: <linux-kernel+bounces-135699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37589C9EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8C11C24866
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD8142914;
	Mon,  8 Apr 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mfEGeqUi"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2136.outbound.protection.outlook.com [40.107.237.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378C14264D;
	Mon,  8 Apr 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594481; cv=fail; b=q4VJYLds4AvZ/JFtiRqpfOk7ayPRLosWn/qSFezEuxQF40iG4Ez3PnzZx6pH//MLVf4lPlcrgGOHtSQmi3ITH4z+k7AHded+VOu2SwXAsjJaGuC3YLDqFrvEUeTt+DVoqw3zdMwnsvpBn/Fqd7jWcfyJ/kHRSlU+lxD9qxznxYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594481; c=relaxed/simple;
	bh=scUPF97Eex/Y9VE1ahuP3dghjUMJY/BMI5lSGcpEu2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mJzScIhwVuGM5Ctfd08+rRzMABXfzvoNT6grBIc6CsN28fMWqJvZ40MExTEJsu87Yw/bPNw+pJcswCR1qyB4vgUArfNtJgbaAeTKMEWtnwFxx3ET/g0317TeB7qqmu1cCCrkRMWQ04XU1p1fooAiBZjSGOxEKeyxaTrSLevO+pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfEGeqUi; arc=fail smtp.client-ip=40.107.237.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4i3jdAWuTs0QANguk8a88/ESi3gxTEqfB+glQSfT74VFmK+pnk3FGFsPT2hYAK6zPwJMMFXLhKdp5mPNTFK8R+Utz1qKOp2tmmn/luRxk5uoPiYdKT/m/tw8waCROyKflmpWfZAdqGMeenMlDEoWCvCP8fGKBCTb4cU20actGvWGapgx2VoGbUScGlGtnfwsGjLJp0wOfwRUFyWdLx4HkC/+efyMysnAeh3CxNitkVue5ERFnBe8OWzv45zJqeqFYi65hgI8rmGegHVZ3smF4lOxS+jOoeBBqjfMTcrBoozUJuO2KWGpvq5Y3V14T5l5RT/jzC07aSyt1gJ9EtTQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb5qO82ZqKIZHXYJx0Usk6MboBWjYq8sgE9m7AwT4A0=;
 b=BhNakUheXFwv0dqMpMoKfuhDqZhIxTFlhctLMjFkubsDhkyFRxX8j+fA+EhShPsxayN+2pHNkqnXKa5EtjnxW1KC58dLnQYDz0mp4isq3rMXx62lbeca+njHPlSgTALZSXYkOeTlZhjL+1xDRsRs9MADgr3z0HVc4Bdvz9+mgzuDJtTkXHVEid+2fvtJ4wHJfLKc+vAsc7rzq9wuC0fQLead58kIWfrctTYfr8jQKo2/uW9TGOEK+P+JdNFRce4jGbbMIdSnYgeM9vOA/oRcG1obBT0HEGX7ZTKO1Dub54Jl4m0GAwD+Iah2UemDYzzIOAh7i6lyvnTGeSiDA77TLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb5qO82ZqKIZHXYJx0Usk6MboBWjYq8sgE9m7AwT4A0=;
 b=mfEGeqUiymiDWtPqFxaVnx5w0XOPGvJNChMU1qmi63M3HyGuOasFeL3enU9E31Eta3MCTyQ25mTypBHBrfk0YS9oU3mCE60tuB5sV3iMQkZujFXFrn0+bYtDtL6lB0nrBirA775f9RXicwqxOHzW3eKZpkuaqAJD4tvZiUxyeSgaD9zokVF3/pKqWeXRWyOYuGm13F0YR79D4G2N5nTMUAoZNZV2pY4soOq+KSkYJ3kOWJpKcJS8R630CqZYuZN89mKJsOHevLeCQuUlf7u10AjV9lAWjaTF4L3tz4u7f77/kR7Nr88XttSZ+zGGiN87Lrc2kmN0OvGzbYWkpqq3kw==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 8 Apr
 2024 16:41:15 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 16:41:15 +0000
Date: Mon, 8 Apr 2024 13:41:14 -0300
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
Message-ID: <20240408164114.GP5383@nvidia.com>
References: <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184055.GP946323@nvidia.com>
 <83025203-fefb-d828-724d-259e5df7c1b2@gmail.com>
 <20240404183305.GM1723999@nvidia.com>
 <20240404125339.14695f27@kernel.org>
 <20240404204454.GO1723999@nvidia.com>
 <20240404143407.64b44a88@kernel.org>
 <20240405111306.GB5383@nvidia.com>
 <20240405083827.78cc1b20@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405083827.78cc1b20@kernel.org>
X-ClientProxiedBy: BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::7) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH2PR12MB4230:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tgg/qqQM3qeC4z0zMnizoKl1NmixVgw3N4zTrYwO3mcCtaYqETbK0ci5k0s8yNe6SJHHIIuQ1QDGYAjnF0LZynV5Y9G39gxxUSr6GBHT0OezDgCkuBGAU0HeuBZvy1+U4s6JfwsIkCuOv7agu3HQ3rX3eHj3+x/Zgw60h8AUqv9pJNM9G8RyWiTXlLtmSJTDNH1a8SToZTITPQQXa5R3OECni5KYGAc0dL/c3hxW8LucZaBJKZJ7GSjioPqj+TFiNxzJPSlmjJnrBuszSQ9RVR3hn/4RF9YVEhPavuPWXkCBu/PWYo9vLXRSmQ7YghDqCW5p8QzYW3RoEcXFxgGQVPLLD0sgtRkRkzF44sKhR3beMOH8a8BNnQ1G4V5+Ia+MAPdX/CTSDpzYHHz11XqmkRL8gF6L5fDBMfwb0+1+AemYinjiDnkiH3APug9T/ILa3kT6YA0cyHh4pMfHVR7aXuCcDz2Rwt2WePaXZYqf2NaEGjbVL3igEd6Ik2Uqqe4h0cCeqUiAKj4GPmZ+92dGKXTix8WOxiRJTeIH9gcBwY1fqjFwbHKfgWMBtroy/8uA9x+gTing+yym7XJ5Xja74dhANoTJG7LV6j/Y3WAvzasvZ4B5VHoGok0kt1e0Y8D911GJqSKHn2VTjus7LhMSENliGkinzmhVx37uYtRVUwo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkw29uIAomV8FcdYNRzbD5US0S1GIPVNTjcmGqxV5kcVJI6NOqBxQe6IPeC6?=
 =?us-ascii?Q?GUz6gSuMGF9Oplqwp/MJfU8pPPEZ+p7jRNn/yR+ugch5RhjYYcXZFa1nAk/L?=
 =?us-ascii?Q?0HUos6d+IMiH22J1c1CId75IgnPUWpNnun2tSTTADQan9lE7cd3ltudOR7JI?=
 =?us-ascii?Q?B58p0PAmlJ70NEPy15RbS9KXImd6IesU8Bb//XbnRa9s2fNmIYPEO7XGPAsZ?=
 =?us-ascii?Q?vF8Pjb+eGdjqyW0O5Vb3oErepGiCzreis9FTtac5RvnPvgcFG7uo/rHQjZ6u?=
 =?us-ascii?Q?g3YiKCm2XwPXgVX8b4Lix7uRjPKr8hAlmxMHpmf0DHG017fPmBBQVPS1H3dJ?=
 =?us-ascii?Q?FDaMkli8LqEjzT+PNIQJEM5i5vsRdVCmeQYjukLUF3+W0BiZbJvxDcWqvH/q?=
 =?us-ascii?Q?TUsH3eeGzUPI0MNns/rL9R+w9vgkKafJYMNn0bro2N8bChWt6WDJS5cKeix+?=
 =?us-ascii?Q?mRILaWTuKnyVzsLE/0i3cAUo+wAor7Xfx/JSET/mKnWbnFs2Y9/aO9MLS8I3?=
 =?us-ascii?Q?Gm+lr7kHJaEh7S+RViHueKGLFbYdUZvmrW/87xmlfdP2dYeXDVbnAF13iFBl?=
 =?us-ascii?Q?KQjCYYKlITBfmqvcN9iiEBAm2OZYq7e/xcKZwn7I3pbsYkvZxtRWEB2mcDs6?=
 =?us-ascii?Q?fsmI8o0KN6dsVas0nozrZ7Ln0OLnPYT0rziC1M2AoId8RYUIkYJe6IE7+BMd?=
 =?us-ascii?Q?hOf9kCdo//KcZpXTZrI7lt6syrt7YEOUlDhG9yM+OXHU/PSEWvbaROPX/46X?=
 =?us-ascii?Q?jUMHAd3JYRTW5WbqHJmd+4gXKgdA9soEFQ2gvBAHOg6Judw+ZqSL0oc5Rp6R?=
 =?us-ascii?Q?fYOv07qseNgwm5qXAp+mDSAzEr3e4cpzoeAtWhLLs1CJmLLK7/WzJF1pA7qZ?=
 =?us-ascii?Q?9gQ64yapQIyoKy8uuIUFiEqihBUZl0FS/1H+UU4/fe3Ls+mDIAMvvivPxFAS?=
 =?us-ascii?Q?p67R6UoGHstvjgwh01fSspwMAZeUXVdVNoAFKf675Z+do2NO/QCe+4VMtVX2?=
 =?us-ascii?Q?0nz5rRlSmfzHEASxtZh4bNp8wvsUBCtt1U41MshgIrxQQ4mqArrk8mkg7Qdg?=
 =?us-ascii?Q?Irvczsz4RLTYLD2CCATbYWXWZ2/9JRqnKadHT7+0env8HRyf3SrQla1uzWr1?=
 =?us-ascii?Q?zXS4qbbFym6I2cmqu0mj/9NzHC2Qk35UZDZ6jINWjIDr+UnZ2PouQTtY2pZN?=
 =?us-ascii?Q?VmdAsuETu5Vx/jbHtJowhnCXXWKcNfeRAkuFvJqisQdlqYx8F5QG40r602aE?=
 =?us-ascii?Q?wv7aomgxuWep9QbMs07bowMU5EFfeTvH5d+8Eqp9JUzB0TwWnlnjtXz/0H4d?=
 =?us-ascii?Q?gAenzFFTnCMbezut/8UgZPzaQmP4uUrfmWyHTCVxUyiWmxj3Yr2yrCEJt5f4?=
 =?us-ascii?Q?Fei4shg0zmNHQDvqVIbKfBx/CpvBA3+KQ1k6DoB9umirddJQf/ZrWUCHwWsz?=
 =?us-ascii?Q?itZxG8Fewo7GxarGWmKZJHK9C1MHOMVRryobdTCjeOEu4fRxCcEjs0OpIztk?=
 =?us-ascii?Q?213VhxIK2n6nR8F8oVzVDyumIL2fXniJ+UBr2mZhqu0fIQiFEwoJMzvPUxS4?=
 =?us-ascii?Q?2LNSonDOTTwYDGphLkw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd60da2c-9b8f-4758-8982-08dc57eab52e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:41:15.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BHU988g3xfnaCtNHHcYdd+BwsK3Q8a1AYxR65SujLots/+JPI5Y/RORph0tZJdyd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230

On Fri, Apr 05, 2024 at 08:38:27AM -0700, Jakub Kicinski wrote:
> On Fri, 5 Apr 2024 08:13:06 -0300 Jason Gunthorpe wrote:
> > As I answered to Anderew, a lot is functional behavior not so much
> > "tunables". The same way many BIOS settings are not all tunables but
> > have functional impacts to the machine. Like enable SRIOV, for
> > instance.
> 
> Thanks, SRIOV is a great example:
> https://docs.kernel.org/next/networking/devlink/devlink-params.html#id2
> Literally the first devlink param on the list.

It is too basic to be really usable, unfortunately - recall my earlier
remarks that a site needs to configure everything, not just the 2 SRIOV
related values in that take. Those are nice generic ones, but others
are not.

> The only "tunables" I'm aware of were for the OCP Yosemite platform,
> which is an interesting beast with 4 hosts plugged into one NIC,
> and constrained PCIe BW. Which is why I said the "tunables" are really
> about the server platform not being off the shelf. Updating NIC FW
> to fix server compatibility is hardly unusual.

I don't think it is appropriate to go into details of all the stuff
that happens in the commercial relationship between Meta and
NVIDIA.. There is lots of history there.

My main point is, for others reading these threads, that taking a COTS
device like mlx5 and essentially forking it for a single user's
special requirements is pretty much standard operating procedure
now. Some people enjoy this with custom devices and custom FW, some
people have to run standard FW and customize it at provisioning time.

Edward accused this all of being "hacks", but I strongly
disagree. Having device specific customization and parameters that
make sense for the device architecture is not a hack. Functional
changes are not the same was weird performance tunables.

> > So please don't use that as a justification to pull up the ladder so
> > nobody else can enjoy even a semi-customized device.
> 
> So in this thread I'm pulling up the ladder and in the fbnic one I'm
> not (as I hope you'd agree)? One could hopefully be forgiven for
> wondering to what extent your assessment of my intentions is colored
> by whether they align with your particular goals :(

I'm not sure what your position is on fbnic TBH. I said mine, I think
it would be fine to merge that series - but I'm pretty moderate in my
views of what should be accepted to Linux for ideological reasons.

Jason

