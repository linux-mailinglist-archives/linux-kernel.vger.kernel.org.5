Return-Path: <linux-kernel+bounces-44874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B93842860
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816BB1F27438
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556A82D8A;
	Tue, 30 Jan 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djAWnCEN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEC823D3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629802; cv=fail; b=IM+oFK88H4eEC7ySbKEZBUeW84+e8n+pqwvaIm2mMWhkRlLWXbqIO0ZaheLroMprtNV2nFSxkANq4FMvKR6UkT4IIqQrNfkW/ejXdfzIqbKqZVdLSVeTP3q0EJueXT0jRDu8k1oYJv/ZFETMydtvEuzIO2E1TK55oajijw0emHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629802; c=relaxed/simple;
	bh=tIg5iSxbschwaF2QeHXe3m9Mc3Z5fmJbef4NCtAFpeg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tMSCkSc+69/emi8dAhTaqKzrdU7Gz4CMEJEUX9AfzNEJdP08RWFx8ikwx2peIXcrGz2DWsyZTD4Vb2TB9/kVn4jLRPRZ9ZHOGkojwO05SXuVnotB6vUorvMfrvx5iC9+wus93cCC0CSs1MyN2bAJca9l0AGdx+q6gPcSOy8mOoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djAWnCEN; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706629801; x=1738165801;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tIg5iSxbschwaF2QeHXe3m9Mc3Z5fmJbef4NCtAFpeg=;
  b=djAWnCENbDJDgAyIdxYObMlTqbpEJKfExjrcYmT3MIMhidnAbwGBaa7K
   muR9FQPdK71Fyyw+VFnTuYMJl7qiWXTs2OBbCrulS5/S2mqTsVOvJcAMr
   Yzh9eZzzFW7jtZm2rBhNrWmYJhqOB4niGuaeQpvE8M5fb4xMHVXTJmx76
   ruAxMGnKhhOhVctlfQCgWTlyJ7Q+3I3S06Ea98o8Vlp4ICd7tEhSberq3
   gcDhi+tTcj4gSKCa9oMzT4+fUqFIW/phtGoDPYf8WOcK8HfsCSQO0QbMr
   I82htZ/1Zj7GEnTf+qgXYPDBLAs3MWB2X+vVAqVHn97hgOVX0L7qbHm+H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10694326"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10694326"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:49:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788238446"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="788238446"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:49:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:49:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:49:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:49:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIJB0QA5hj9vMoPzCzd+1hhcxKDeDqPIWNO64Utt89fxiKlHaAtxUQ9gq5bcaP1fVM4wVW/0DJMlH2AOrcatO+AEnwiSAloGlaP1yfGgL4lz8JhZV5fBs8vguD+QmhVfwC/r+Cnl+Nd4JpYkAo8+CfNyWuo8K+C3kEUukoHIkvo+4UqynIbMGoJizoSfWI8ba9LyukBgCN/F8DvXahd70doxp3rjYbJM67qO3eZgmXt+yPc1eCDg0qA8SAHEZRpNvItsLc2TeSCYpC8B06BEuJtmR2Lclnw57KAhN/o4abM3ddW/G5J8dl67MNvTG93BXilmYObaMKGUGYYuwQocCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmp7/6FTxKWVPxs669QCGbAw6af8d7gT/r7ovErCTW8=;
 b=C3YVz93KUfKdcA5X4wGtC5TBhVyyJpA6mXoo+hn42azyfIL34JDFl+tYU3JZk44KtystSwe39Ch7DobjBqjqole+4erb2Ioc5UcVJhErultXe4xJb/siNy6MnBWhc8roI2z4VBI7bKjUFIcfXv+DM3K+MvLjuKJlCBhK/Mph9B4DhggDOCTucP7vbWP72tqep+mARwiNSJxopvH/zm8Xe12CJaIuZJRwQeMmIOsC0hjZNVH9OlnWvrPEJncQ9F81wpXHAwLFUpL5B7TC+6/rfvBNBlohIQNnx+4X4caA4aTIFpXkhXPwTbTvWpEqs0zBZCrXzsiN9qNNzEdEGWftNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 30 Jan
 2024 15:49:43 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:49:43 +0000
Date: Tue, 30 Jan 2024 10:49:37 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-kernel@vger.kernel.org>, Jose Souza <jose.souza@intel.com>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] devcoredump: Remove devcoredump device if failing
 device is gone
Message-ID: <ZbkakWFtV5iQrfLP@intel.com>
References: <20240126151121.1076079-1-rodrigo.vivi@intel.com>
 <d57dc34fa8b0e25cec014b8001dcd0527d1c1013.camel@sipsolutions.net>
 <ZbgYyra1Ypa0nf6u@intel.com>
 <33df6c78c4c47a8f57a1c2bfe835065becb5a253.camel@sipsolutions.net>
 <ZbkSvcEtRgTXuzgJ@intel.com>
 <8681168464fa85061db4a7234f89cead65cb0261.camel@sipsolutions.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8681168464fa85061db4a7234f89cead65cb0261.camel@sipsolutions.net>
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|PH7PR11MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1167c6-239d-4865-66b8-08dc21ab134b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWWerCH5F8Z4t59mLsWUY1vo2N7YfkxqWRqVzxnSdcEqhWsvN40LlRR0O0iB1ZccMILbn/hRhacuWt1ae2lC18GanvGLdbutNuTTyG3lsvHE/mzIDOUpauRN/IGYBmlbQ03RWoUeoRqCF0otDcnXWhhUGaLHY9X5h40UKUXuUBFT4bQ84RMqDxveBe15adMO56WXMmugtkLldFrh23z/nY9Y7W+7ppsdsBBa7a+UfMKIh9oI+T9770Rbuod8JTf2dnOlz5ACFb/SAdSyqdXpYYnXB6Gu/INR5TkeeUBYeClDPy7H0HyiWfLKLT0B+ZTqs2s0nrMC8Y49KOysoHCcKZuwcuedn7kP9EauZeNlcfVRflU4TK43XhykOUnObjeXXaR0agIPhOPqwCS6saWahVAJKvB609qrxYTgS471fguWvaAmbZ6WSJEtkdt5vQ9xDW6y0yPhK34bwpquPswuFwjk/GBKvN3m2xcSJJK1nN13hs16lcb0TcnGJ6EQ7sRd3FwUu0KyIolSyau6HMpTKYDuP2Yiuj7j3J0UFduVF5WqaqWpbRw5F4LWg4382v6B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(38100700002)(66946007)(316002)(6506007)(54906003)(6916009)(8676002)(66476007)(6486002)(8936002)(44832011)(6512007)(5660300002)(2616005)(86362001)(478600001)(4326008)(26005)(2906002)(6666004)(36756003)(66556008)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f48G/0ux5kFzMIpQK0n3I8YtUjx12bYVwWJsqBdtNqjdLdh4KxL3jLcELONh?=
 =?us-ascii?Q?H28KK5utPTkbd3CYidHb4lPb4HC0VF7KNVtORGKEyYfZlB8ACQXHoId7ap7d?=
 =?us-ascii?Q?AyNl/6HGgCovjmfFZ642zs1pI1voO28de1NPWD0/rPC+fkvZ9tBkRSTAs5fI?=
 =?us-ascii?Q?FsXdcSIc+E2kICo7+gXp1hASI+m2wxFpGXlgazeqQwH0fb7hPxqDSD+6WX8e?=
 =?us-ascii?Q?03u7F/OCJEOKqKw4idWJb4ztxuGpZTRDCBLAr4IEW5RmM8RD62hUEnOEXw47?=
 =?us-ascii?Q?PBmtpICefN6M7nvIZyCYROIVV2j1JyfVu54otej9k3O3oKj9rfP5TRWWwt0q?=
 =?us-ascii?Q?OguCRu8znxM03P4AS65sAzKK3R1eV+JakH32THFeOlzOX1Ip3uW6IShnBfvI?=
 =?us-ascii?Q?YFLYPaZ0BfTVhbO+4hN1Plv37n/uO5ar/aKNeqTMfLVuycKE57M1K5TJYVue?=
 =?us-ascii?Q?tNh6AwkI8LCSI7x0nZipot7f8I0C9qRVmzu5/PYUspvOWv6QMxNG8rYQufM6?=
 =?us-ascii?Q?6LeX8+tgzV4xk/5N9WmcHqEkmdmVy14RkQhxrUINup0xTsu8F7FJG4T/BH8W?=
 =?us-ascii?Q?o87AjEy1drjrHdzuw2vHXGbEU9bbCBAb1QbAItJPvbsd605AIorSq5qCXfjJ?=
 =?us-ascii?Q?2A8WuPv16cIvE4KoVxdiCUtZfTxMDpt552dcfeNcfPowuXVLSfPPK6xmPKiL?=
 =?us-ascii?Q?NuDkSpvONsz/9aS/pqdJUe/vlb8mL+UWlPpZMOqvW+xKRzYzIbCIachme+ee?=
 =?us-ascii?Q?TIwDPD5kmjDsoiRI/4+unALJxSzZEF6j30lVudy6KCNpex/kplSTBefReOIE?=
 =?us-ascii?Q?lGnRzIa7IOA7p9WRUnWruBlm4bPI70MTKicIkRHbl8jHYrHG+ojMDyMuxfEx?=
 =?us-ascii?Q?hRN3/3Hn42weO88nymjGWAcJtWO/sRcvLjKCoSyFoQfA2E3LbwffdFLTPyAf?=
 =?us-ascii?Q?4xBVrpsXziqL+YyGEKNoVGm1MXndTTPbf9go8wdBdzllz52sLDy9pksYic/e?=
 =?us-ascii?Q?KAU+n4gsxcdyQ8l2rm0cvA2AVFLAm4LucEdmks0YLs30WLIFt8ojXsuz6so6?=
 =?us-ascii?Q?q9ZgMCfsRInbykdbdFNqGEsUZD3xxXOScHUxlqGuNp8bKY2mCaqPsbGQnd8V?=
 =?us-ascii?Q?IwJo2hX49QBiotE4k6hpDMQ/0YsuNS7jFIva8+LbeFdhRqnFAzsYWw4EhQWd?=
 =?us-ascii?Q?G8O3gswHagsbfNoWMVQ6DAxgoDO7CoR8XxIDoXVJ/yPZcRjqb6Ct4xX5hCbC?=
 =?us-ascii?Q?AiElSrdJd/HHg1/LXRzdk8OmbWaN6C48LIxnofLc2bVvM6uBf3mjwRvb+Lud?=
 =?us-ascii?Q?03pbzOkfX1pHIcOH/Jgb0qFV4HNQ/P0Zckt9kYBlxHZf27Hfu5gSEQNsi6J3?=
 =?us-ascii?Q?fIfO6ZsYThRO6jwDUsHXA24L7+iBgkuA5XSiDcxhlsq+wh3N28+nNInQM/Y6?=
 =?us-ascii?Q?nsib8BzJTQfztiYbwd/wUV9cOSCW2BRJg6phA+KPY/9+v3NkMgoKvOJim/1s?=
 =?us-ascii?Q?LH3nKWj7uOEVltt/3I/XIvjKOn8pZM92XIX0zU6gaSS1p5ChBQG0cMdMAXC+?=
 =?us-ascii?Q?wZsCC9nxvfunZL05WRWUdjcNusZ/46j0OLimKXT4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1167c6-239d-4865-66b8-08dc21ab134b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:49:43.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpOr2t9IC7NEoso1CwS0UINi0hp4zQkyHtuMLueOsU7A9VNIwqUG15MiV+McGAD997Z00fnRyEuxz5vOWf3PoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com

On Tue, Jan 30, 2024 at 04:19:18PM +0100, Johannes Berg wrote:
> On Tue, 2024-01-30 at 10:16 -0500, Rodrigo Vivi wrote:
> > > 
> > > But I'd rather not, it
> > > feels weird to have a need for it.
> > 
> > We could change or CI and instruct our devs to always write
> > something to 'data' to ensure that devcoredump is deleted
> > before we can reload our module. Maybe that's the right
> > approach indeed, although I would really prefer to have
> > a direct way.
> 
> That's not really what I meant :-) I think we can agree that it's wrong
> for the kernel to be _able_ to run into some kind of use-after-free if
> userspace isn't doing the right thing here!
> 
> What I meant though is: it's weird for 'data' to actually depend on the
> struct device being still around, no? Whatever you want 'data' to be,
> couldn't you arrange it so that it's valid as long as the module isn't
> removed, so that the 'data' pointer literally encapsulates the needed
> data, doesn't depend on anything else, and the method you pass is more
> like a 'format' method.

I'm sorry for not being clear here. I totally agree with you.

I will make changes to our driver to make the 'data' a standalone memory
that devcoredump will free. this ensures no uaf and no null deref.
data could be read even after unbinding the driver.

What I meant to userspace 'writing to 'data'' was to ensure that
on our CI we run something like

if /sys/.../device/devcd<n> exists, then
echo 1 > /sys/.../device/devcd<n>/data
before attempting the rmmod <driver>

our rmmod cannot get stuck or our CI is blocked, but then ensuring
the devcd is gone with module_put happening is the only current way
of not blocking the rmmod.

> 
> johannes

