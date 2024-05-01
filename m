Return-Path: <linux-kernel+bounces-165012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9AF8B8676
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA851F230A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DB4F881;
	Wed,  1 May 2024 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mzt2Z2qS"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF54D9FD;
	Wed,  1 May 2024 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714550060; cv=fail; b=mlWQz2UqRyyIJz/QJHMJDvxndQoW4pDoBeiTUfkxRLv5Fe5YSKy3xSrJFKrATisuMM0kOrlmb4sF2bQrlSPt/uw4GUV6NUeVAgeNroLq4Bul+m+EitDXDYRsRPvf+U5pxL+in09uXlUao7eFwcH9oH3ZB8PEcET4IIEjqyX1xoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714550060; c=relaxed/simple;
	bh=bomAKge42TX+iDs1CTk73HICPJkzMe4cgJR+cRTRkw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGnA2K8UNrfOh+cZmflfLdc3jmtEaIy0guNv8BB06/1gE+9Iiv2i+Kr9/Ps4LiJTURo20+qxR1PlFz3GuSd0qSUmmHTPXLsKNoq+LBsR58GZvSpVOXA8RvECDOToe3+25Rii8SaDvq68u8tYWQKibz2+xzVK4HxAXfarEn6iKQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mzt2Z2qS; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OT7Ys2CQCqRLr+LyY6ReqbCV6aRh7BCF/ho0e7qObXfCXsn94fyIim/NIfg0QfV+w4BXBCsCX7Hqv1iclKqIrfIEJC4Tld3DkpfRTUDhVxLy4zTuzbm4aeYorJE94RpIzoWohLXwrWyPHRvalFDfiC8f2xCi3Wgm9oPnGK/S9yJqq7J9qNQHilT9K348LzpStO8N/4I/6hnN3oSNo9GS/REWe5EpDnaeC6kp/nxiNPqn1ayNlW7Hu0wl/qWuVC1zCiZc814P5jbxM59Th1t/JGimFM/eX2DDKqzHaFZlJ1wQdZgoXLMmafWAUorarKwDLdjPxHYfIbYI4eaW076Khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgqVPDFlg122cJYmzVcy57rBqQPoSoVtZiIW7U2ERFk=;
 b=ZT5MawL4W9njdDfv2xKp9hh5Sum8xIckOGX7OylyuNYpT/4u5e5gYj3fjCT+qEOj/E7oPD7C133drDQk/ODlFCFaIRKOIBo8twvk5+qbhBBpFTG7nLYkl9WmJU9nvgnkfDCkpLPdEYORKVheMGPnG3kgQaCOTwBoInBEnq+5nwKZKudXA63JXYdQIQSavcoBrfMJqCzvK5p33hJlJEI59imZLsEp6s09JZXSzHTmTnyr3PhasM7+3nKd/oN+syDYNRb2xyR4HEETeJIKveHMtr+xwjM/RI/6teKqRwTLTtUnbicZdseT20+31BBzHko8Yj+AaG2+IF9YTj8xb7wsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgqVPDFlg122cJYmzVcy57rBqQPoSoVtZiIW7U2ERFk=;
 b=Mzt2Z2qSbGoQsFk1/0uasRD0pE1/ZyXHWDashYDjnfO2Uc8e45XCKD95F8j2wkNyza7LGwST0y5OQevTG/XIZY8AIylMOt8UZvc/2BPYC2NhkGmk3Y/C+Nsq2bGqYChT0yScwGM8nXk/SdVBrL4aJDZa/hsfqSMjCij3AuDc3bacr4+GcZ5XuAMjZlWxdAXbuhqJGu21Yw/46nKMCAFYAg31YJZZybwkNzODaZSaIHEhisAAyDUSqhHFePYHpBUjnGnwQimKGtCmVIfysIcARet4OVLvXZUbNUw3tG1UETkhSjkFQneOAvNOwmSFn1SJSwr+IyATz8RySkqbIwmg4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 07:54:15 +0000
Received: from IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded]) by IA1PR12MB6163.namprd12.prod.outlook.com
 ([fe80::210:5a16:2b80:6ded%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 07:53:56 +0000
Date: Wed, 1 May 2024 10:53:48 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <ZjH1DCu0rJTL_RYz@shredder>
References: <20240424133023.4150624-1-danieller@nvidia.com>
 <20240424133023.4150624-5-danieller@nvidia.com>
 <20240429201130.5fad6d05@kernel.org>
 <DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20240430130302.235d612d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430130302.235d612d@kernel.org>
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6163:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 340797cf-a6dc-4e41-67d3-08dc69b3d907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rtAiv6vGr7CQ4g6kVOM5pPOzh3gKt0mMaiAAcM6a7kINtwTzPTJEu+CGUDuN?=
 =?us-ascii?Q?LMoCs9k6CAcbhAylOf8TEAzQMEJcNXuFiSzbvsljZWV2541y57BPCE05x+sC?=
 =?us-ascii?Q?jp+iCkZDJ4uLXUAx0TCictb6ILWPIh8nILiaOGDTruKljifwG1mhPYHrb1BP?=
 =?us-ascii?Q?IiRWg2qwHa0/eJWxIrNicoOWwyTO2tfVG5U+rwjOy3Z8mHkonGjnflKUsSnA?=
 =?us-ascii?Q?/dMkSRnTjH0qMxooIT1Dv392JDGVidXDWWot7GxSG7wXEhn/YIwt2Hv+JbeI?=
 =?us-ascii?Q?cB9ylcORezt2o7p82/3p8tNMUNU+FFFw5NnoasnckDLt5KFvCVIw65VvTFvN?=
 =?us-ascii?Q?QDKPCjst4DMaKlxumabBRSk6yks7rEFP5htmEV53ZIfZpBpEPLrYH1BRAryl?=
 =?us-ascii?Q?70DaXKuM9bUBlxIS9O0DSAajeZE1F1BqyhTto+AE5oSKdbjS025USvHlUdb1?=
 =?us-ascii?Q?QH1KKvqpoV2QaQ1mabOg05E+Y/gjm816yhJqZ1CBJHaZyli9xvNLBp00M8qL?=
 =?us-ascii?Q?WYdoBB8btRkDlAdaOevU2c8i9GSYzIBHbvQjTKmYr+bRp0AMnhZyc+htTNyM?=
 =?us-ascii?Q?8Oy1rxLw9fO/5yGNqBthLE+SV2h7AAd9lAhkWnRtipmsbjMd92Ob4aX4+EbK?=
 =?us-ascii?Q?75vW0yNfXMYCeTRZexGn29dNYsi9kJYY0R+H6qjHOjIu21oGOqaH1riEB443?=
 =?us-ascii?Q?trV5SwqjlK8mpJu6D27LKbmjMUKaoJksNC2CRX7Y1NZIyGPEg+p1CVuiYF5y?=
 =?us-ascii?Q?ZOVS8ppPDbYRaxoW4yUhbtHgiUi5xlIemzmhL8SXw833Ewb+Ag2m4/6HV4ZL?=
 =?us-ascii?Q?bNTDo1LmRIUhp7jxvjdBZqBQJq7+adCa7kbzc3ljDxP2wjzQ+V2u0EY9yB7W?=
 =?us-ascii?Q?voRdv5cb2XvUBHSmA7k136fuzpMeUK8VGIeQILf4WU+gi6jKipjkfUVm2xfc?=
 =?us-ascii?Q?kINr8Iv3KABZnSR0W5cBeEfOLSTk2FnrqGn71J7aKbym1/jxFzyYWVxmYUM2?=
 =?us-ascii?Q?0oM7mlAi8RcEga4USSENDbNtgUnrvAtHI0YM5oCnRYB0CDueGx4ftQb+XVo5?=
 =?us-ascii?Q?qTK6YVyzVUtCR6okHfL9qp8A52Kk+gTBgdps+ozbzn+RrjCqSkP0SgO5UFPf?=
 =?us-ascii?Q?f+3vDnIRwF28b0hatpe6VNsc3kwPLFbOUBgwPZvzZ7Me75EwkpaXgOW72g3O?=
 =?us-ascii?Q?+D6RYCEPjtYjrxKKmCgVz7oyuM09SLFZnNlYJuEAW48PjYLrNqGi7BqlixzD?=
 =?us-ascii?Q?peBuT9VYOgpuKvXG2lgs6rYeV6YZA5b/SV8h7uknaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMQI/qSR3p4GxTjzW457Vyjko9JYJJk8Sffw5A7AsM20iFHweGYis+GtBcuD?=
 =?us-ascii?Q?7klKfW/OvWZlbBJKBpsdhMNzTENFwRqbQh6mUZc31sJfd1VvxNjVXclMIm2X?=
 =?us-ascii?Q?sre53Jdh8tAKmpxL/Uf8aTtA1akVRqp/9rF2yqpND7EcH7yxXrHFprgf2jnl?=
 =?us-ascii?Q?25K+F4NKfW3Tq6x/geOACPVoNeNGvFOzrrn9QgredgdbBvNSJzPDCAwNkNv9?=
 =?us-ascii?Q?jgdIS9OcJKakpPYKwDR+Qy/NANo2/9D00XJymE88i79GZ9JQjqN50zF5lzPO?=
 =?us-ascii?Q?MyM9KtS5BgnW4LrNq59Gpg2Gj3vrHW5v5jYKVnADck72DVSkLAagS5DzrnBI?=
 =?us-ascii?Q?jIxz/bP2XK22oXC2IBukWBezin/woUmZkV9IKQQjtTpWfM/voF9YkOxbRdin?=
 =?us-ascii?Q?elLFT1YqmUAU/jJVBoanjj5xs6fhH692EERTG7pqb2qSs2kfQ7LQkTjlBtWH?=
 =?us-ascii?Q?3OJn9Kl0707C7WVAPyn7fblFF3BLwvQqFoFN6MWYDSXlbIlQs3rbl82JMuNR?=
 =?us-ascii?Q?g/ylT2qWHdDpzKTU3L6fBdm0FLApZVJb9TfGZGvRn3Y7rMQHSBK2/womf0D/?=
 =?us-ascii?Q?CxFd21G4gfV1diLQjZdQlLnm4Q9WLKQnSw0uBlCgpRi0tax4/EZMcNzoCI6C?=
 =?us-ascii?Q?KswZA7HDFmMwpy1OotvlM/f4+9naCm33FXGs29/M/AkmmltHnWb6OrbxoCbS?=
 =?us-ascii?Q?uHkDaK0ivckcmKvQpEz9tBDSaVGP/65UvAvr+mLNvSBYoigSaDLKZBw0CJjt?=
 =?us-ascii?Q?4d+ibwpFpXx9Byq/WI0j6zaeptPS4SuUiVb6s2syrRSOl2EmjsyfDfky6zU9?=
 =?us-ascii?Q?m5AxjYMIJFMZx6S4Z0Q+9W8tp7139726sMsi+WYs2FNz6RE1/yVsIhsGSt4b?=
 =?us-ascii?Q?IG29ai/dolnXmxIwmBCV2/bQr1rq5Foj+i51OQO3ti8dw+EMUfa7c9NAFmxv?=
 =?us-ascii?Q?thh3H220D5fvaS7OSGuzhaqB85d5OwPQvGiUD1/34bzUkPlkS1rHnalz8MT/?=
 =?us-ascii?Q?uxN15ZUW2xj5EyXdhU0ZoFi4q904MHlL1SonJaJk+6e5fpHSgniug4fEbgHL?=
 =?us-ascii?Q?o6GbtG4uhnlCf+LWlt/NUgsOWbHZrTetEnY/9Wujif39xbs+fOSzKijKJ2l0?=
 =?us-ascii?Q?MiLVEN0+uGeHcLiqziP4p+bJFU/LjoHgBmfJahmsO4+c0jPANi8Y4yyAzOps?=
 =?us-ascii?Q?OWUPmLmGatXRg3WUussAWQiXGySUIemN6w1mrz2MQNAF4LT/I4gtEoqqbBFM?=
 =?us-ascii?Q?HEcatW+2ysL6VKqlzZPNH3GouVNb7aSrCv1d3DlJJmuACblF+MmPPDBAxdbp?=
 =?us-ascii?Q?jeIj47dHMB01bJx7N+PxthlEfVouodo5D8+0oC1h4FyhPf7Acewamo45BtR1?=
 =?us-ascii?Q?rlYoFTm8lYMjH7PRMJZwO7rTOS2lUlOEklOGuzqnDP8BbgzvqphfmnooY7r6?=
 =?us-ascii?Q?3PoVqCKMGWMYLPEfcYzM+nogupDL4FTrM8Fkg16LMDu8cDitnsQhWpMqXU6Y?=
 =?us-ascii?Q?LdPBw5riy42ZFB+GIcBVkge2f7SDqWXW8lzTnR2NOyYg5UdiY/ClQRzxFiaS?=
 =?us-ascii?Q?DmECkIxuAP0i+X5ZiXZ4EyVbchL8MiN2pIi5TIJ4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340797cf-a6dc-4e41-67d3-08dc69b3d907
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 07:53:56.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po0bdkXovr+M9paw/Rvck9eUZkC2niScOSmyvbueoFME5jAEZJ7g2HVvePuZa/C8X7zM6yfY40rSoNu903Hrvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

On Tue, Apr 30, 2024 at 01:03:02PM -0700, Jakub Kicinski wrote:
> On Tue, 30 Apr 2024 18:11:18 +0000 Danielle Ratson wrote:
> > > Do we want to blast it to all listeners or treat it as an async reply?
> > > We can save the seq and portid of the original requester and use reply, I
> > > think.  
> > 
> > I am sorry, I am not sure I understood what you meant here... it
> > should be an async reply, but not sure I understood your suggestion.
> > 
> > Can you explain please?
> 
> Make sure you have read the netlink intro, it should help fill in some
> gaps I won't explicitly cover:
> https://docs.kernel.org/next/userspace-api/netlink/intro.html
> 
> "True" notifications will have pid = 0 and seq = 0, while replies to
> commands have those fields populated based on the request.
> 
> pid identifies the socket where the message should be delivered.
> ethnl_multicast() assumes that it's zero (since it's designed to work
> for notifications) and sends the message to all sockets subscribed to 
> a multicast / notification group (ETHNL_MCGRP_MONITOR).
> 
> So that's the background. What you're doing isn't incorrect but I think
> it'd be better if we didn't use the multicast group here, and sent the
> messages as a reply - just to the socket which requested the flashing.
> Still asynchronously, we just need to save the right pid and seq to use.
> 
> Two reasons for this:
>  1) convenience, the user space socket won't have to subscribe to 
>     the multicast group
>  2) the multicast group is really intended for notifying about
>     _configuration changes_ done to the system. If there is a daemon
>     listening on that group, there's a very high chance it won't care
>     about progress of the flashing. Maybe we can send a single
>     notification that flashing has been completed but not "progress
>     updates"
> 
> I think it should work.

We can try to use unicast, but the current design is influenced by
devlink firmware flash (see __devlink_flash_update_notify()) and ethtool
cable testing (see ethnl_cable_test_started() and
ethnl_cable_test_finished()), both of which use multicast notifications
although the latter does not update about progress.

Do you want us to try the unicast approach or be consistent with the
above examples?

