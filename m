Return-Path: <linux-kernel+bounces-75717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBEC85EDE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5241B284E7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA206A927;
	Thu, 22 Feb 2024 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GA+HmyA9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DEA28F0;
	Thu, 22 Feb 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708561270; cv=fail; b=RD4euV/U5zQJEP6raUOrKCBxE9UNBi0i2nDlfyiEFsN1cukvZ07CxTzyyRMZSxF7LAvN2CeQVqBhcudUJR06aPmg/KjUZGayhvxUKMQ8NffwhA6R22k/Hyn/zgVOtmg5SE7CDEsT3uP7Gy5lTx4P2v4Ych+ytj070zShvjbnk3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708561270; c=relaxed/simple;
	bh=J9m6PD7CrILvJpZpbd1AR8eKraTyuogHwISffSkDjn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EPckUgBnCnP+cLPdfEzXAHxWRf35MB0IrAChsfiBuIFW5KIpgJ7tSyJnU2mtHvTxuSIw+9cI6EtJ4Fp9Rzg+b94aydxnU60Mx0Izas/lef0hQAp2J8I6nw07JLzPme3pbFt52x1dWaiZAunrXmk0Hd24sD86qH9ag96Ej7zn8Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GA+HmyA9; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708561268; x=1740097268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=J9m6PD7CrILvJpZpbd1AR8eKraTyuogHwISffSkDjn4=;
  b=GA+HmyA9tUNvwoS2iEtY/9E7JeSnEA3sukTI3DwTuP6/53BKdcP+BwEC
   742aiVBaMlmz8pYOzCgIF57yvGeO48vuvtuwb9XRcdOAGaQVJXKZBXqRH
   EyOb53IsRx+Dc3Xtf/CPONzrSubR8djElppE+OUIio8maWAeCI6rXZy8w
   RB7x5EGJryaaeoRf2eaDglIN+p1fk8IazCmTi5pdPpZcA6aC8RK3ATBRe
   cGqlqZfSA8DhYWjkzWwg7jcxeYwxiKuqn1jQJslkD8KnF/nuchymttxhJ
   5mGxXwql6JrYk3sXJRy0I0j1l0IOuoXQMXfwQ0wWnAOAlJp2t3XZzz+dp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3246025"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="3246025"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 16:21:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36305588"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 16:21:07 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 16:21:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 16:21:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 16:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as4OG1/uL9LkR0kYFuwsejHYFaDfHg0PxZkaFIyxId7gzoVINFPrpvJ+k6vCYw+fvbPt2+mrPB4YmdgGm9Ym9kOn3AER63JVQgyI7eUPSexDOCPt9Hw6XY4tD7spJHL2OR07vRVPbdAEjXWVSRGo7srs2MifEpWKFnqalBOWmubuRZA+vdRge3/vbcC6E48CraAaDXPDptiio5eojbt3puhBy9FZSMo2AiHzSxdGIzJay8ge+taFkBf/RNB0vs6uUVNj8XQac8CPpimYR1MP6vk5yKcUHbmdZq2S/XCbVvJiYj3htwWtZfSLvlQM0yo5MZuO7WnUYKsDBloThg+3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzFp5HQr7UD0+/Kr7p325O8QIFU4SHs1PNatY6OO8bA=;
 b=QJWmAkIYoaVQZd2aMc6GqjZ/ELgydsyxnW/Z/BRHf4PJOEMDO1CHf+AilA3QVJX51JffbPZ2qtmRySd0qB0chm3b4989RK4ytag4p0Wa19epReT4N3c7jZM/z1JMQD8JXF/mw5nxmfyTNV8EkeIqsTfwacGZ+LZHBTQQYxJD+7a9ekf83y9voZM2zkL2T3OTLhV6PX7h713cLsVQm0Xl7CuDLkcQbwMURY88FnmELM/BD1ALPcDaz8VoNt5rOiaXQIRmaxHBJv7byJCZw5WrvICXaw563BbmsT9346bWzbI1iQLt4UYE1PbH+rYfkAXsuVuqeO3W6b1oSv/LMPuQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 00:21:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 00:21:01 +0000
Date: Wed, 21 Feb 2024 16:20:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<dan.j.williams@intel.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<david@redhat.com>, <Vilas.Sridharan@amd.com>, <leo.duran@amd.com>,
	<Yazen.Ghannam@amd.com>, <rientjes@google.com>, <jiaqiyan@google.com>,
	<tony.luck@intel.com>, <Jon.Grimm@amd.com>, <dave.hansen@linux.intel.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
	<james.morse@arm.com>, <jthoughton@google.com>, <somasundaram.a@hpe.com>,
	<erdemaktas@google.com>, <pgonda@google.com>, <duenwen@google.com>,
	<mike.malvestuto@intel.com>, <gthelen@google.com>,
	<wschwartz@amperecomputing.com>, <dferguson@amperecomputing.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<kangkang.shen@futurewei.com>, <wanghuiqiang@huawei.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: RE: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240215111455.1462-1-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 866d4238-d346-46e9-d267-08dc333c2678
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNcoJNbgHv+u+yhWWe8OepR7XnlV9F4TOLJLEEPOfGXaSggkx31DcBJrsY0F5ksvYmO5OSSrF21Mn9L2ngaDQO/i57UDj0arpyZ35qVLOx3srhhNx0ljpOPb9cqlGT5BF4+/EDTqTf25iPW6YODOTOXtuy6z3MUp5pUFMa2SCWrU+cEnONG0bwgZyVDx6B1hvuxWbvYM9SD1xjsLbIy3c7aMqFNbk9LQ6SgtYXElaYmk5J+dQ00RndDwQ0qnWY/56dx2kEIkdJKnmvRX+zQWEpiEiuZfUlAXpXpY5oDuAEd3FnodnhYlUxM1Ji36VJicw/hybeCRY7kGvKvzXZP8qQc/x0KXF4iY4ukPSfgV+AI5jg85NhZGh+QPn/MK79gMd5CFJd1YEx6m6ti47YRRbV/BVANzr5fwoN4AnZ9ZYj0EqMgGmYXww4gamvXJfhS2MllbXq8XHfKuHRVVDXL+cB6ZA0gx583X/sUBYbgp/RVOlW3qhQHELeyz3yu1RMrB+jdSjHGfqtnMlsHs7ZHBn969gxtsSizJt0JwR+Nf+WJgFP/u/YC6aDcximgPg+CGt2m6iR1sQa8HJw/ZfyD90M/AGrA+fx1W+iOcA8CM0T8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpvbccEJLAVpZwE7tyx4lzZq3oJJ3VNJaymVepFoCUKvsE3apSUKeA5rVhGc?=
 =?us-ascii?Q?4mw5pKIl6WgqeQT9tv+316GSLM6p8G5ZVj25FcrRIybzoXBXyEOdhSfEGci3?=
 =?us-ascii?Q?Ie/2pm9Y9Ge0w2CKOiC1suyHbxT0UHZkBsLQ4o3Y1m+rfBFfCrAeajtXmX3m?=
 =?us-ascii?Q?CjHjIAaVDZEUSbGHkkQAd0UocJOCSES2qlY3VHtD8f40iSnJEB9RXYWw/mur?=
 =?us-ascii?Q?zBbcl1ohW2Ic+ES1o4llSBioOqNpD9yEaY8ehNhFFihcVA4n7a7C3xEaoH7l?=
 =?us-ascii?Q?5ZolsZkzGrHLAi4nfsFNy/2Jos9vRG1VC+xxQ1WSSVfgEE/qcm0SGo9iCDKr?=
 =?us-ascii?Q?0t+yFQGkolq8NRJ8CzjtfvEnAMONcTXGweqgVlUZfMo4+QRfQIH4j1H4DR3M?=
 =?us-ascii?Q?XImMU+a1DU2AMOGiYnAENWWbqM70OOCkg+fkdAp817nMh/sanVar55nj/wXO?=
 =?us-ascii?Q?6Z3WvQ38rxoc7B3Jo++bW3ID9YrQG3so64dPR1tbm7fJrpLEww2SfUAQGtjW?=
 =?us-ascii?Q?CGprH76OTnwjK12P7kSZlHJ1rQxP5xZlsVvBlZcI6Q8zen+L9PNNVRxejYny?=
 =?us-ascii?Q?ArNpiH3CIp6sYS4r/6PtLM6MTnrc+AocMYjj+kZArJdkV3r45DJ0UVtIi3C4?=
 =?us-ascii?Q?RMvNfM8VzV6kpr62u+4culjYeNDTvx6wJIvuEEEfoMlcxKRQxD+RLEejwpBH?=
 =?us-ascii?Q?Cf7Y5nEO2/O14EdV0LQ12zS2Ct6YjWOa+7P/EnO+ditjolr1FHl+KEe7RytB?=
 =?us-ascii?Q?kTq1GXdAdkvRSmScPVZTVvUtQ1q9HdfBistTtILb26xTVXOjVS5LAen8nzWI?=
 =?us-ascii?Q?wUtz1dWdHRAWUk/UYsJHZHxgpHxvLKtKv3T8a5mlIY4uN+Zf0aFy7tMiVgSv?=
 =?us-ascii?Q?yHBiDdv9bTFH8pCDIj3C2UjmIjaL9pbGO9YHkeaCvylH7nAsUJTWgtTORZHL?=
 =?us-ascii?Q?QBeyH4QoXFAmIHI72MQkTsvgnyEDWo9RxjrZriWkC8gB6bRbaMhvpxGNoMzq?=
 =?us-ascii?Q?e/WeJsvoxhCZZ4jNAsBeqJ2FPYmbYoOeXgvh6IgbTt/mbfWX03vWo6Z/CA5M?=
 =?us-ascii?Q?96PlZTKD/p/+SAFNi/seVnUDZaDFnipZxyfcP4CJNMt12K5Mb32kHeXdrUH6?=
 =?us-ascii?Q?KkdUpW+zlXrJaRF7MdeGn486qrYwefuw14wtZBmreVqh/3liVoAhmwQhR5ex?=
 =?us-ascii?Q?mPgJ3RCKZ5lmYvXVeX9pfdlRnD5tI3InBMvJuThqhNY7lTpun2WeqgO6Ypy5?=
 =?us-ascii?Q?1L7vYNPhN5ydTFlzFRsgEjkpFshNmJrAb6MzruN3eAGZL6susItlJyFYUvk+?=
 =?us-ascii?Q?QUh9e4tIhYhAAmzdMCKDkve4N53RWNKTE5/CXktjacQsMu6ASulQcqMAHINH?=
 =?us-ascii?Q?9SCVtprHPJxx9PFD6/zopeFJeGgTWvmBg0IP7zz5RJ12aGVx+tK7RDB282++?=
 =?us-ascii?Q?oCvNpoBcB2M/DFJJNYB8KDufV90sOPvGp9WFwn3LnVCFVr0pFzKzSDI7nda6?=
 =?us-ascii?Q?LvyxyNVVgP3T4mAPtzlEwsrdjj/AGOh2NQuunhoFSZOgqYeJIFCcj1oOKTFJ?=
 =?us-ascii?Q?mq4fUl1CIJqBgQLgF+WIuSuRFof5vXMOVAehYp1ip2gCdZ48A3vFfneMZcwB?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 866d4238-d346-46e9-d267-08dc333c2678
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 00:21:01.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibRpuLehPJFuS3CdQjAIf2mWmOcFuyrotbN8iZ6Osl15XMb/1kaY8sVbkX9GtiEkYKO5iGtBOL1xBSMORrdpb2eBJe55vgxT4zsiv7zx6dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> 1. Add support for CXL feature mailbox commands.
> 2. Add CXL device scrub driver supporting patrol scrub control and ECS
> control features.
> 3. Add scrub subsystem driver supports configuring memory scrubs in the system.
> 4. Register CXL device patrol scrub and ECS with scrub subsystem.
> 5. Add common library for RASF and RAS2 PCC interfaces.
> 6. Add driver for ACPI RAS2 feature table (RAS2).
> 7. Add memory RAS2 driver and register with scrub subsystem.

I stepped away from this patch set to focus on the changes that landed
for v6.8 and the follow-on regression fixups. Now that v6.8 CXL work has
quieted down and I circle back to this set for v6.9 I find the lack of
story in this cover letter to be unsettling. As a reviewer I should not
have to put together the story on why Linux should care about this
feature and independently build up the maintainence-burden vs benefit
tradeoff analysis.

Maybe it is self evident to others, but for me there is little in these
changelogs besides "mechanism exists, enable it". There are plenty of
platform or device mechanisms that get specified that Linux does not
enable for one reason or another.

The cover letter needs to answer why it matters, and what are the
tradeoffs. Mind you, in my submissions I do not always get this right in
the cover letter [1], but hopefully at least one of the patches tells
the story [2].

In other words, imagine you are writing the pull request to Linus or
someone else with limited time who needs to make a risk decision on a
pull request with a diffstat of:

    23 files changed, 3083 insertions(+)

..where the easiest decision is to just decline. As is, these
changelogs are not close to tipping the scale to "accept".

[sidebar: how did this manage to implement a new subsystem with 2
consumers (CXL + ACPI), without modifying a single existing line? Zero
deletions? That is either an indication that Linux perfectly anticipated
this future use case (unlikely), or more work needs to be done to digest
an integrate these concepts into existing code paths]

One of the first questions for me is why CXL and RAS2 as the first
consumers and not NVDIMM-ARS and/or RASF Patrol Scrub? Part of the
maintenance burden tradeoff is providing a migration path for legacy on
the way to adding the new thing. If old scrub implementations could be
deprecated / deleted on the way to supporting new scrub use cases that
becomes interesting.

[1]: http://lore.kernel.org/r/20240208220909.GA975234@bhelgaas
[2]: http://lore.kernel.org/r/20240208221305.GA975512@bhelgaas

