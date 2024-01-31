Return-Path: <linux-kernel+bounces-45539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66A843228
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB14288E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF873641;
	Wed, 31 Jan 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUSTmTcO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7BE367
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661798; cv=fail; b=mu2w/21ImhjJd1Q8qiZcrRrPaMZ0exXy3iWiUtZjnVhBq69y/C75KrTDDrfznHgsaITuUZYWBSk8pZIbUtzFsZbsKQpZmPctNI1E/uzokIpkxAtv7rzhLNQ+3/4JIA0Di0Tor4Rrs80sWl8+9aLOP1ne9Q7Zk5md8euc87h7+t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661798; c=relaxed/simple;
	bh=qAD4KVqS9we0aN7ho3PkyW//tR21SrhxH5DPsTHj7nQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RayNDh0Yv8eE6YEictlO2fmFXdk1VK0NAgMvMM7KSro0O1MOw8msHCWCLXzN7OKfT9K+pKYm7vLQ/5HfgSoFroZG+tUkadnxahNoMZrm3Grw0X7NSsKd220NdwkwoW1vz+vHnAiilHJBStnr9mOuNzZs6k/F6q4JKe3susykieE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUSTmTcO; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706661797; x=1738197797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qAD4KVqS9we0aN7ho3PkyW//tR21SrhxH5DPsTHj7nQ=;
  b=QUSTmTcOh1pelZfzVtXNJAId1miK/QpXdvLm9Js7uyGv5l5QDkMhEUDF
   IPNh8sr/aM0RLgGj1G2PilOsgr2iFS29AHLkftJFJIr5OtWt6cv9bk/0T
   4o4sr0o7eBl+0JwINn48aOxjNeDd/n6DIPvKcW+lldSM0hjnheSeSL2Qt
   2St4k4qA5h2WbIsIYtFQWvmX4Ea6BfWQKZSH9RhOv//IzIxkUe6fyOCqG
   t1Cx3kfTT7+kKpjOJmklPjkUaDEM02aKCg5Aj6VwCAmtnK1zfWTOryMyx
   ZMT7vjFJBAhga/MKtPYnZRXXqoEi79EAPRVTuLMwZ4xFCAfzOPL86+xw0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2385393"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="2385393"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 16:43:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878627609"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878627609"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 16:43:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 16:43:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 16:43:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 16:43:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 16:43:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj9XCyLCNM7M1vD9TDx8QcF7AQ2ZnWSaNhFEvmEqAjL8dVnbtoN54dNV9v01vNa9hx8JLaAW8XEPVj+Rp/pn6p3zlsHTnGvT1sgYdHMou1dF/6xZYJhDErAVIPcYMdIG8O8H3Wl7pIHg/x91JZiaqvtup5Ujp/WecMJ+ZYRYWBcScqv9rGZbVa5nbOaNOnYZ/k76+AQAnRVTk1rGtCR+EzppxUYNEiHTRCY1irpiV7ORjUmZowsDi6+3c3j3QupLEI1qANtkrHZIa2d08BNmHqQnsQGAjLL1MUB2oVg1xeKbR+p63js4e1I5MpwmGPR9Hxx6tM38Rit7XSZZMkYCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Cip7qK+PbhycHtABHXQpSf8+2UkEDbqA2OGXU8fp4=;
 b=D9imVGq5zR1zSMvDpFGudFdBDfQYeFMwHZrC78HNiQu6UeG87cEuC4dCllesFv42daXc39HZP2ne/638kRwbOSBGxg/U0a092e/RL2oF+q7oGwYFfbISKdI8U9EfakfwQVve79z8qFoLPhQddQ9Zy6bZUra4N6tBtO3Khyf1W3zGpwZfxTx2rK3vy07xPdkCDiLC23YzbgZLbOqsMv4qgLrsgHt02eBNXfudVj0APutTUETTQuqq/Fc+PKPzfKop81wVbSP6kxQSxaNWd2S/GCnCyZdxdFlsLk7g+P3444uaFIWNffK6wFKl3j2VJdGsDF+zdel9Bv6kdmJKkD6SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4602.namprd11.prod.outlook.com (2603:10b6:303:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 00:43:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:43:07 +0000
Date: Tue, 30 Jan 2024 16:43:04 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b9979895a8e_5cc6f2942f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b9434712b57_2d455e294a8@iweiny-mobl.notmuch>
 <65b948987e865_5cc6f294df@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b98e8d4f405_2f26102943c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b98e8d4f405_2f26102943c@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:303:b8::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 4518c7cc-5bcb-4f4b-21d2-08dc21f59748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5pa6IWCpPWfbZfokdk/wEit0IHtKhVodQIuLWOHTw5XvMcr/cJbbvRQ+dk5LP3hL6rRVY28JwUwalK9aXnF89fmk8iZLqTUsHU2g0QhcJyljQX2G5CJGWw+aDxQnhPJbGupP1lEMzjNFZTUcjpRELDtM9g4udUtT7baf1lFcJUWNwNmcP6GAjBjNF8pHqODWhHGHRDmka5tJ//I8ls9F09PBS/aorAmZNb+Xp/L8ofsfNfqMdzVmgZLk9Z2m2gSl+c/UvMPkBmStTOBpJW5xzBWRkkGXTf/on8X0AHtAbFnaJhWjlpRnFsEJdk0u/vQtK6GTPetfS4P77rjunj1Y7iM2XdUC51L4NyW2p/klat8p6ISwsFPdrRjS/yLhHU3zHrs0doLtH6nOmlIwkjPnlRn0FtLR0m4aiaZeRKJy7xF3q9I1Z/Txlu/QwE9PPeJQUjbIarzhOPMrUw5SKM/1wK/QUWzgEyYPNtAmBfar5kGNqBb6ox1VZUMMT4p5P0MYU4bYiaGqc0AJWv1Lx5ET8Qv5D1g0frFchG0/aknPYutYp68udCcX2ImR3Uyq/8U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(110136005)(54906003)(66556008)(38100700002)(8936002)(316002)(66946007)(4326008)(8676002)(6486002)(2906002)(66476007)(6506007)(86362001)(5660300002)(82960400001)(41300700001)(83380400001)(26005)(6512007)(9686003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iFEt3bm2xaNKTPca46yDc4MFOO0g5UKYfRnHtTG0oxcHSFg1esj6nI0C6Y8B?=
 =?us-ascii?Q?X3YA4/fPGDlDRe6AYVmpjSjQ6hI2ViK73SNdY/xKVkPLytW2fNI5bjyBk24S?=
 =?us-ascii?Q?UgH/37NOnDub4qYWCHWor/1d5eR+epj8v4hahiEbQDyPgrNQN/WeDoKdABxt?=
 =?us-ascii?Q?xV7HpNC1a3JWt2GGD6vkcdP22vFMEUfNJ9bXLftIr9GOOUImReNHH4rF0ONo?=
 =?us-ascii?Q?TO9jFazAPUKTXDZqZaNVgW9xqLIwCvCHLwpydxnEmU25Pxw96HBOZQFgabHA?=
 =?us-ascii?Q?QswzjRccFei/WYw7YbGS668ROxeFk0VaTKFh44hxvxyqMAtZvpoEx9Y1HCFs?=
 =?us-ascii?Q?m8zP1dNxdeX8S1B04g5PGo1PriFHIrk3B+5oKgtj24ioVRHRPUQPdSZ0a8/g?=
 =?us-ascii?Q?mtPElPlcihdzbKHwhxT+J/yYIKMNLpT7lsQQ2Nsv1/chVxm6izfh/XHZXoc6?=
 =?us-ascii?Q?JkRXSd7f68+3kn3L2nMrS+Bs9ccH+26H2VTXrEqTWUoZBJelPCX9++BGfYvh?=
 =?us-ascii?Q?77aThCOiluW9d+T0C0DZaBDn8VCYY57KOfndQxY/jde3px+++2m5oxlezUkv?=
 =?us-ascii?Q?luFKTpae6JyGZXHEsZnulkskWvskT+s05mwWtT8rVZiEKQ6kHOyP3d7RFGcx?=
 =?us-ascii?Q?Q1rQU7Z+Y6+npFRdsR4X3Wfn+J31lZqktcY93eKm6gr7Qh/pgp3ze7uJv557?=
 =?us-ascii?Q?Yz/Dp5lSoQYHg13xwwjbjkvwGfaWStyrpp8nVy3cBfAomVlbEcXDQkAiB9zu?=
 =?us-ascii?Q?LudTsziwPfdvByLiTZ9ZsZ+kbvWsLBiVC6RCRZ4Zf7ME0Bya8DLClWa2AlBL?=
 =?us-ascii?Q?1Y467O39lZaylGDqvX+9A7t3p3w3iCMymboPb2LRzbPv/HILL+g+1l5k15/t?=
 =?us-ascii?Q?krwa3UyiCtHOoY5NVL3FdsS5vkI86Qp771G1dlCA7PkSgYoDcQYH8I5VHjVt?=
 =?us-ascii?Q?I7ZWcpeM9wioybo4KEcT5hw7y5BlnH3Uj0ow3Y73hH256DHnTSxGlWz4yB/6?=
 =?us-ascii?Q?eFN5q0tMY9YP7pq6tqHEK7rUJAnthLG2nT10gCHvmNxAO9HGhiz2f5chEzzU?=
 =?us-ascii?Q?5TzTPZkOK7HNp8K/ko9Rbzn83+WeaiSah5jHoA4lJ6GQw0vYUIQwbZGlIYz5?=
 =?us-ascii?Q?l/6hctlSxpvMMTFB+MVENMDiTjMlDyPCMpZWNjGqorUnMMVNfFo3J5UkTihc?=
 =?us-ascii?Q?PHwp6VIGeMKQTEWfMgMYY3obeKVvEci9feOdPZdVgfpcTSyu5EZ6jjdfp8pF?=
 =?us-ascii?Q?Ulj1xiu/kPMoxvKg0DDW6uOUgS8ybc3ydq8PFC1ZW3VLen82ouOwyDt247x5?=
 =?us-ascii?Q?5rI8eoo1FcVSOVX5L0uxUIF6h4aEAmIrCfYRhH2hpEEd4yLpTLXl2okydF/P?=
 =?us-ascii?Q?JycjEXXYki7Nx4TeNM3zjd6jwL0MVx+4sz3yGhCYeHAuAT7PZRjtBtcSf9Z3?=
 =?us-ascii?Q?TiG6XuROky0kfrODZp+wgWOHBbVP7tmGbN+/ZkyvqeLkN78VZc5svYRxPtNW?=
 =?us-ascii?Q?+YSk7d3ycVuEav5jS3Rl83ppVNiaq3bYM2OH/BQ6VO/f0ruL5uekR8CQdPx1?=
 =?us-ascii?Q?kmQuXtx9Ezx7+NqvSg4l0g24bHZ1t2IFC/WUH9pqJ8B/qkDpo81bZMCdb9pp?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4518c7cc-5bcb-4f4b-21d2-08dc21f59748
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:43:06.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryJkS4sLLEDLaop+kWGx+AYoIWMgpj7dEFCSRJnVvpK0Jgj4n0/hvvvb1FaA++yRqsf9ShAX/QZsae8so1Cxcsei2rxyTwflVKCPcyBEDSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4602
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> > > Dan Williams wrote:
> > > > Fabio M. De Francesco wrote:
> > > > > Add cond_guard() to conditional guards.
> > > > > 
> > > > > cond_guard() is used for the _interruptible(), _killable(), and _try
> > > > > versions of locks. It expects a block where the failure can be handled
> > > > > (e.g., calling printk() and returning -EINTR in case of failure).
> > > > > 
> > > > > As the other guards, it avoids to open code the release of the lock
> > > > > after a goto to an 'out' label.
> > > > > 
> > > > > This remains an RFC because Dan suggested a slightly different syntax:
> > > > > 
> > > > > 	if (cond_guard(...))
> > > > > 		return -EINTR;
> > > > > 
> > > > > But the scoped_cond_guard() macro omits the if statement:
> > > > > 
> > > > >     	scoped_cond_guard (...) {
> > > > >     	}
> > > > > 
> > > > > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > > > > to handle the failure case:
> > > > > 
> > > > > 	cond_guard(...)
> > > > > 		return -EINTR;
> > > > 
> > > > That's too subtle for me, because of the mistakes that can be made with
> > > > brackets how about a syntax like:
> > > > 
> > > >  	cond_guard(..., return -EINTR, ...)
> > > > 
> > > > ...to make it clear what happens if the lock acquisition fails without
> > > > having to remember there is a hidden incomplete "if ()" statement in
> > > > that macro? More below...
> > > 
> > > I sympathize with the hidden "if" being confusing but there is already
> > > precedent in the current *_guard macros.  So I'd like to know if Peter has
> > > an opinion.
> > 
> > What are you asking specifically? The current scoped_cond_guard()
> > already properly encapsulates the "if ()" and takes an "_fail" so why
> > wouldn't cond_guard() also safely encpsulate an "if ()" and take an
> > "_fail" statement argument?
> 
> Maybe I misunderstood you.  I thought you were advocating that the 'if'
> would not be encapsulated.  And I was wondering if Peter had an opinion.
> 

Last I sent to Fabio was this:

>> You can steal the embedded "if ()" trick from scoped_cond_guard() and do
>> something like (untested):
>> 
>> #define cond_guard(_name, _fail, args...) \
>>         CLASS(_name, scope)(args); \
>>         if (!__guard_ptr(_name)(&scope)) _fail; else /* pass */;


> But if you are agreeing with the direction of this patch regarding the if
> then ignore me.

I disagree with the proposal that the caller needs to understand that
the macro leaves a dangling "if ()". I am ok with aligning with
scoped_cond_guard() where the caller can assume that the "_fail"
statement has been executed with no "if ()" sequence to terminate.

