Return-Path: <linux-kernel+bounces-7401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208881A769
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8343285D37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B54879E;
	Wed, 20 Dec 2023 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOwYDh6W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA148788
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703102024; x=1734638024;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fusXxqdIIQEHSeYEvu5VurNbKw7Ux7p1OrkBigjK1nI=;
  b=FOwYDh6W2OUl9c7k/hx+9MgSYziQAO6TIxR7ymjS/vCoiGlJHcXwL3nZ
   PEkZatKwiWkbj658qz5qqmdKyRKIruDquPtbVqH9xc65tNktJu6FZwJbt
   I3G1N2RDc2boH05/ht8gYAKI+Zba8i6qUwGHHNmJy+XQS/JtmphngWCGf
   QhaPy7L+AZmqG/x/zJ6st/DU1lkcjqfl7qO/7iCCGrFJp4ddv6cdcev+B
   qy51m/zUWf2N/yrRXKO58mACNdqswKvMyUAkC0dznMMQob7tlio2hcyO7
   XXNwcIOJIVc6uXBAZZyNaAmczwbqQyH8MGlaCWa8EmniNraB56tkmRNDy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460208582"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="460208582"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 11:53:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920073011"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="920073011"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 11:53:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 11:53:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 11:53:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 11:53:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZ9bmi1ilWThKZDFs0z5GOdRfxQlUQQ8S52MzzVtI1fcAThnh8hrNXzS5ylD14pXg8SvL2VOZbRmFFS7OeyL0KhOMnjqcvj3dhEV7Ef3k0FXxUHc/88E2G3OwG5RIo+1/7q67i1ORPDuJGNbr/cgj2EXX2wyY4baiankEywQt62UlTycRaiQVjO5rGcqcpStOK61MrdlFw0TIcu/BOTtSOhtsqHgeZAGZYsgg5/Vi7WTJoOoasDODl+5ndkUypaNpJ5FX4trPaQWQOWbxVA7MLMGlP3shOdaEkJ0a8rpKH1WGc0A2/0ezXfBw2MJZ9ek+Di4tm7JmGE6WZpggblSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjjoG4XrI8TO9AHnXlN9htLYZerlKEu7S6spLJb/IU4=;
 b=lMNvcNyG1AJV3TuUOV7/eKl7MaFooECtntTgasBsbjOl9Eq30ojcSfHWDE1Uiu+TZlbA7rdMcVkzTwMQezTf/Ww7tjkqt9PZu3ipwcKla4SpF8ShBac9dhmKB/DYk4AjmJtvkg+6v2QMKtaAx//d0jOepoq2MIya5Ksxz1I78uBbDXDemCLcaIJ8Dfa4UIOCD5O2+NK2aN1MPTIV71WBcTi9jb9fQpVgv9zssTwkAsjkkkhXQbqFp06UBLg8Lmw/DEcIdiiQhD9hpGyvb9cwy8Cso+syfhh/2yUsAYXV9hOL6Bjo4HwyFEK4zXIYbhsxORt+bUGbc7yFWAWxQpTFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 19:53:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 19:53:40 +0000
Date: Wed, 20 Dec 2023 11:53:34 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	"Andrew Morton" <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Message-ID: <6583463e8de5c_30a94294fb@iweiny-mobl.notmuch>
References: <20231215084417.2002370-1-fabio.maria.de.francesco@linux.intel.com>
 <657fbdb5db945_126a129483@iweiny-mobl.notmuch>
 <4255260.irdbgypaU6@fdefranc-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4255260.irdbgypaU6@fdefranc-mobl3>
X-ClientProxiedBy: BYAPR01CA0054.prod.exchangelabs.com (2603:10b6:a03:94::31)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: bb85b2b8-d30b-4e89-c399-08dc01955cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QavEmPpYluONOUa/yzDIIWxrIkDa98NnZjDw03w2PAQ7/wcAH0E2dnf2FM69ru0qRGwzsbskYNGYEzdMuR4NlpkN2PfEfWlsVUsQs0tvmDF0f/u+4uSmhAzM8sPmxkMD3IrhT4v4K46imp73yMFPaLMrj+QD5hNldOnaBgw5I3D7r8Qj1WZCLzAho3jluBQ0frxQ9NKqKgx7Zljfd6WPIxB4WdsJ85a75Bty03dqbI0ASPu4sf9GTEu9RFZ5SlP8/Z+OoUgzVb63w0cyz9i9l3OUr0+noomYB5kPHFu8meg/9AmrKoWPuuPGodDxZTOVloEHlKCpXs7Fa8STxJcSKTvyhbSLULpG4S9s4/MkgL99Mw3JM0DqLCVmBrohfedWStJCmvHGEHfGHsDi+65DXxNgjTHGXWbempVgCeiqQgMh2QKdNFBT3jEuUYMQdfwKDQTIKvIKD9qK1PDeCPC8yxzMyh21d/eW1WlnLXngT6VRqBhMo7ascjWu/K30G0OvDBoxEZIAS7v6guhbA7eqNHLXodQMjPtVpnYwmcPcqh5Re+H1V+M5qkcBdFjJhJQJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(478600001)(6486002)(41300700001)(6666004)(316002)(110136005)(83380400001)(9686003)(6512007)(86362001)(66556008)(66476007)(66946007)(8676002)(82960400001)(8936002)(38100700002)(2906002)(5660300002)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1A+Js4ucjDmMEJ/Q8jAz21viY4eukhXhM+/+abW/xuASjwE6vUjAmA+0BlBp?=
 =?us-ascii?Q?nYwg7Z20a7saF7mJIJdv4KfnELVFmSQk1vx5JDllsfScnAl0dU9AIdj4D28r?=
 =?us-ascii?Q?dX3uutV4FzvunykH9ekVRJQuqXFRXzN2Td+nQSYnUx1i2DWf6l/hU3nbxcKs?=
 =?us-ascii?Q?kjEy7QTNjhriq9Sbr5YrLG5r62sNQ8zdozpVWGH1hfqIdIPCZIq59UPvIyt6?=
 =?us-ascii?Q?og77OCl55JosFSjtCpRwZUENu1+phlISANYuVbu8BYhi9ev5r+fECWPL/IJJ?=
 =?us-ascii?Q?/TXkHQX2Tg5+xDYSGrrnkpI/h7NbLrSpg6/gjrfmeTx1+LI2BBi2ZxPB2dTu?=
 =?us-ascii?Q?9ynMtoBj6wI8aWuNmeCpG83jxmDLBWYIp/li8iO1PgrHScK1PcP7NDbX9F6H?=
 =?us-ascii?Q?hsP29apqV17q0R9ogzkkmyx4qTUqI2ro2VwuKbSArKmFe6cfpM4nT/vCMnMa?=
 =?us-ascii?Q?1ACfsA+T4ulwFTCg1jmGvhSFR4YKsIq4Mi6cPasV7tZFWwhDNpbcv7Yfc/xB?=
 =?us-ascii?Q?LKOYvHEsWszuJg2i9fVMWsxhdfHID19++9EO9ifH1/lRLNqoDE2Sc1xxGPfn?=
 =?us-ascii?Q?w1yp2l7LFt9r0vwaYCI7ow0Vb69Vtj6ODgwJrG9/ZUtg1U2OLE4AEJ/1yxub?=
 =?us-ascii?Q?iYyUpRDcBFuYvYpWhI0jXk1rEGmjWYgqJ1PLBi56hjynMcAVKkmBCO2ZJM4s?=
 =?us-ascii?Q?kLP3iVnrecqfNdx6YEa8CIpeAIU/Aj4g/42atwWQvHzqmBe6h3dTzNKO6acC?=
 =?us-ascii?Q?skEJfUla6MD9qfh7euHK2VXSKAMPZF6wV19jY41qE6kN0A7HxE8zKJ3HNs8h?=
 =?us-ascii?Q?Qe+vJEC1HqgKVTJkknQdE2WjyD6x63313prbXjh9zpNvUigPuGbN27ZOfviw?=
 =?us-ascii?Q?brzwAnN+Y2d1JEhiJCGaoUXNvRVszj/30Q8r74vDhaDvwIQaStm9hFttc/xd?=
 =?us-ascii?Q?iZTKiAOSeZm3Zr9inyMSBF2JZaslbwLgxFOH2Z4v3Fjzj557Ty90sMCvcKVP?=
 =?us-ascii?Q?vgyj7rXRSu+okUul2P6s6nuhJ2YPtou+VGzWiFzbTiCUF9DFGAEnFuPvMp2l?=
 =?us-ascii?Q?QKxXgvCblq48CJFkrqoN7MOZiktImnmEe8YkKQsa3EsbBKvubvMJvHzjHRBs?=
 =?us-ascii?Q?j22ko/mzSNwBF36XXT0WwxHwg3jJIa1oVjMlEcSLDB6y4CQwzuf/DiKflpm5?=
 =?us-ascii?Q?yFOLLk/ua9c6IXD+dIsVFrJLt8cN0SCHl+mMEjQVByYVX5zP7xPg/Bok6Uyb?=
 =?us-ascii?Q?2gLN+ohCxpIlbABbqIP4n0WVhASXzBCrXfdzAzHludiSwYIV806EQCyWReYr?=
 =?us-ascii?Q?nL+vT2xJWhxO5gPR3AQ3tEFJYZQuiFo5Cu9NE9W65CWd/XGMmg8Uxp2JLrpK?=
 =?us-ascii?Q?tL52zJ3NkeOTWQOnjwi5/rNV/pN/5u3oc34b6MCLYn4K8XvRLx9rIQfD1xot?=
 =?us-ascii?Q?dV5WsTfWBrf03e6sLLQWAdPrxSb6EEgrOXXGDsj2TWP+E4UJ1W5+ryy+r7p+?=
 =?us-ascii?Q?Bo/20Xjblcw4k6WfIEHDb+REQXqiUFhYVU6qJaIldlpYc5I71sgVbVezJDmT?=
 =?us-ascii?Q?Yw60nhPJ1oyd2pEQj8O9QJXcTAf2xmynOIOsJEwfydeNP9GAw/FqAc5Lz8oV?=
 =?us-ascii?Q?XEq+qVZppU3tBqtTk8L3H4wZkf8VJcf7cUpKbuNH5Col?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb85b2b8-d30b-4e89-c399-08dc01955cd0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 19:53:40.0769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh06Whh52GhfizYth6IC8xZbZC4Dp/S6ptwYAWE+057O42Sg2y0xYyPrPJbqmepjNS8c13tZehqSuxKs0nI8TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> On Monday, 18 December 2023 04:34:13 CET Ira Weiny wrote:
> > Fabio M. De Francesco wrote:
> > 
> > [snip]
> > 
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco
> > > <fabio.maria.de.francesco@linux.intel.com> ---
> > > 
> > >  mm/memory.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 7d9f6b685032..88377a107fbe 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5852,7 +5852,7 @@ static int __access_remote_vm(struct mm_struct *mm,
> > > unsigned long addr,> 
> > >  			if (bytes > PAGE_SIZE-offset)
> > >  			
> > >  				bytes = PAGE_SIZE-offset;
> > > 
> > > -			maddr = kmap(page);
> > > +			maddr = kmap_local_page(page);
> > > 
> > >  			if (write) {
> > >  			
> > >  				copy_to_user_page(vma, page, addr,
> > >  				
> > >  						  maddr + offset, buf, 
> bytes);
> > > 
> > > @@ -5861,8 +5861,7 @@ static int __access_remote_vm(struct mm_struct *mm,
> > > unsigned long addr,> 
> > >  				copy_from_user_page(vma, page, addr,
> > >  				
> > >  						    buf, maddr + offset, 
> bytes);
> > >  			
> > >  			}
> > > 
> > > -			kunmap(page);
> > > -			put_page(page);
> > > +			unmap_and_put_page(page, maddr);
> > 
> > Does this really have the same functionality?
> > 
> > Ira
> 
> Do you have any specific reasons to say that? 
> 
> The unmap_and_put_page() helper was created by Al Viro (it initially was 
> put_and_unmap_page() and I sent a patch to rename it to the current name). He 
> noticed that we have lots of kunmap_local() followed by put_page(). 
> 
> The current implementation has then been changed (Matthew did it, if I 
> remember correctly).
> 
> My understanding of the current implementation is that unmap_and_put_page() 
> calls folio_release_kmap(), taking as arguments the folio which the page 
> belongs to and the kernel virtual address returned by kmap_local_page().
> 
> folio_release_kmap() calls kunmap_local() and then folio_put(). The last is 
> called on the folio obtained by the unmap_and_put_page() wrapper and, if I'm 
> not wrong, it releases refcounts on folios like put_page() does on pages.

This is where my consternation came from.  I saw the folio_put() and did
not realize that get_page() now calls folio_get().

> 
> Am I missing something?

Nope, I just did not have time to trace code yesterday.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

