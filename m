Return-Path: <linux-kernel+bounces-87991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857986DBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AD7B25EA4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF069316;
	Fri,  1 Mar 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rl+16JRd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4752F7A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276879; cv=fail; b=KLGOcOKFzwR+PxQfrDUAb3Z4y+QWfQy7waMtVzqutPuVGvYFIVvRJkhLceb29n2pUnbQbBSuvFp1JsYKZnDPi3xGMHcLT32HrmcN/7NZLY9aZQKLTUFasDmqmD6bSaFfmElVoYiIsq29Tse9Pj5381k9B7w1k+CnlNVS6Fh/HHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276879; c=relaxed/simple;
	bh=U1MGe4JtOWKmqfRiz5lk267mADnMWLoIq2l6KJBL7sg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rlSHYmJGO7DUN9W08xRMq7/6Zy4hIFPlqEliP7WI7U1O8n/7zLba9qohVORBNWseRJzzYPlBUcMOb+yDXgfmYSNj0j6FpkmU/6pjr3vTomdTkLIqJ1/KOQZlNUoaoeRfOtgd4xK9omeqqz5JdPT0LhEAZhkxLDrwzxqZay8LCSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rl+16JRd; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709276877; x=1740812877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=U1MGe4JtOWKmqfRiz5lk267mADnMWLoIq2l6KJBL7sg=;
  b=Rl+16JRdRrrfVqIY2AJkPCEcJ5CaW98f1s0BtAWt4iHCfRuGeFEsya82
   0rnqkhtOpRcUa8uFaRQvN4R/cqWVHqNbcWn/RFRUSxBM8ukjlhXSwlEXu
   47oPPMY2alFPxHhXtNhUQlYyrBhk17glCN9BceEho/bFzoDgrXJmjI8ls
   T92+qIzQyU6pf03SeOdOPW1xqZKlQyemVY/v3hpaYUE+TMOgODqN0zZA5
   cAumY5gjSQ4mr8m+JY/BbE7xstUU90R7Xaa5JZ1v2hLzyPycVHxy7bQRq
   xymawlJqYX0JdaAKsKAbl7hWnuEGIMHBH1LwkNnHv6UN3WnOrfIfgsWhg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="29226836"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="29226836"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 23:07:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="12649824"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 23:07:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 23:07:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 23:07:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 23:07:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 23:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nu4LKOUIJIiw4M7JJ0783IpRILHuX+vuwJJrzysYpPNVvnazu/9/SYItD6UK4lELs5ZiVKRr2gle7B26Ct9kBDg4RuMDqfr2e9EXwn+aOIjEU5nOs0RSDZaF7pY3tPL7oVC8suUk9yS0GnU865COiUnPyZIAsnHpYVGJkQaquXXwI6A+JaYa3Vrt+8mvPqPjhragsUCKbouVQ41kZaP6Q9nov2C2F9oMNafvsMjbQR451F/Guww/JshxFdtODeYEstGCeD44rSYCnFmDIcujH08iCxkAROVSZYqA4Igem4E/2mVZARk42c/JmoE+OPN9fI0W1eDf7TtsnNpMBYnuqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhkqRCloRS90C8z6jgh0VNolkv5XXiZd9FFadyVknfU=;
 b=lTAcwGL/YQ2B0dO6PJKWtp51mZYC4nj5iWf89UnzA9khAklszjqLkX8B1L9bAbT0nicc6EzYs8bsr56/1EIpzV4eu/otRvt8/DdrMDGACQxNmzv8hiZu7NzIdlJ8erfp/uHCsBKnevbsK2K1qOKIYdhtCD+qBMcss3JJsJL8BP1tf70kq7aKy4cdiYVfZ4XL3ro0+PW7r0Cr55ogNkI2dr4gxQ9p4BurWGyn1D3vy47coU8BqEP3fOSkTL1YF/Qot5Y5y5nbdlN7Uk6rNhsdo6m53wuZ3PNo8CesRlT37OUinO+9TBwTMfnVwQvOv1DzgxPMKifkeitSNTYGEtgDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Fri, 1 Mar
 2024 07:07:52 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 07:07:51 +0000
Date: Fri, 1 Mar 2024 15:07:37 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <ZeF+uc/jMohokNRb@chenyu5-mobl2>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: bd52ada4-6722-4b2d-f7fc-08dc39be4f52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwzgNEhTgTW3LRyv+Puc8OYJnm3HXFO1yz6U+31xczGbQG6RxSRiUwgm3Kxa38aeywk2t02j2DoofUgmUlDQnYrdFNeZVWqGma2+qVgFPJZY7MR2PErLEZJJlZ2IuEBU1lMT0rt8VN2QnEuusBNzgjqrMkY8XxSS4DhW7jKr5oydYj9pVsbxTedj5/HvnpZzvSp4TGyEwdcM8kV+Z/reNP85d2i5UQbE7Xl/ExGAAeaftS5x8vSDGwt+LJoQ040ZjNlnt9rkhtbtbz4l+WI5g5iDNHUv6r8ucsSfxVAizQuMj1SecoeJrc35OBw3344Zq3/dYy23UwgE3ocJIDmYRHNl0QxNmUTmeesZlhkJ6CgEplVZ/WjROA0tES3sBkDEj3H6Vkto/8lB4oV37xajQU5ZgQyta3XXc2G5+fGUEBRZ5/iTtlEeAi6r+xKSJReYv95TCwStyJWDl5LjuzasAkKWxKeNuCIFXoL0OtIcxb+wRCt0PhbqOvlpFs9Guuq8xfuuPf8ZuqxC+XeTG1W6XkFj6I9v+UaZawx+7ZfQGWKQTD+FgQ2+SP1VnpAWTCZ4SZwO3fL06J5IEkoFhPCJtqMDiKSpy1T9CR+FPwSYJvckOh5Kde63tW6i58DCmqA2xKownlLdoT1iCvOIhMJdtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jojD7NY0feEtMDY7iPsokPMSqIuKANgSS5FPL4UoJBG85q0F4xSCS0uJW+1x?=
 =?us-ascii?Q?LSMeAsTgwvBvTMdLB5wZwJ86yVEJa5NYvzutEoCtNwtgdDVMAvkbZ16BvFmN?=
 =?us-ascii?Q?ipUKRUI8reXwceO/LOHD/kYJaNeRGGYrgYpqHTD0Z2h0Nvw7G/DfH66/H73u?=
 =?us-ascii?Q?MNCWA9n5rFftmRjh9KKBLa98rcVddYdePdjDYhX82+Uldj70xBlLXysHmyY/?=
 =?us-ascii?Q?Z6oGCgZvwqKd0NaUCe5BfKGBkIoNPCMhqF/CJb9a/e0sh/ViXnIsaMbUnkqu?=
 =?us-ascii?Q?KdGfFFtcQrrBofRFlFM5paFKuL6i9GC+1iSTlJiGAvXB/0YIMYLI0PBoEKiV?=
 =?us-ascii?Q?mH97QIcGx3nIkc4OGF1Cx0TZD9TwrAQAWM+nOez/mP8HZSb3z33AzsA758KE?=
 =?us-ascii?Q?8lb4EIeR58kl9mchkKjmnc0EUMyVVvHDwly07Tw01JCLrl+qvKq+b+bXTa2E?=
 =?us-ascii?Q?4q9RiQSOazq9aT3sMuttWGeDAaIq7qpmm12oQT2L5lL+4UrJUwxIr4XC7IXQ?=
 =?us-ascii?Q?7Vql1d33KTeZAGcULxJjbUYwT0J/NCE37F4YAQ5D+u4rC9yYJ45xqYGUOsyO?=
 =?us-ascii?Q?OW7ltoJulSV7BCQIxCQz2Y+/xAdTQeGJp95RvPu4Km5mRu2vqghenIomGnjD?=
 =?us-ascii?Q?5rdZjax8oyWvF0Disd51BJo4TTra2VdOkyMEoKd38H300Tz5k2ghxkaIpaBK?=
 =?us-ascii?Q?c+wULVsBQJmpH8ULWLjInJemuMUe5mqGaMX0e7exE6Rcr6Y2KAMKo1bhyBnh?=
 =?us-ascii?Q?s8/wRT6WrMVr8YDSHPB1c9oqhKlxNca1/1KFCbVvxhIOG/ceoTtkbnnXIUUs?=
 =?us-ascii?Q?wQR3pQDxz1lYxRRDnetuwKINAsPrcZ/RA1aNcfrptLzBR2vnd1hc1zbZUl3u?=
 =?us-ascii?Q?STmGjmjeuudq72ezReBUeTIOYKd+gp341KgI3vre5cHgfE0+5pO4o/YVxUKB?=
 =?us-ascii?Q?JzpZtkssEzHdKUFQlx6p917k4QEs/ChScen2oWDU0LnrXLYWS7KZxqy3w88t?=
 =?us-ascii?Q?g+dGw4ZDSpLfhhw487iJYxv+08qRx4oxMekOKQ2/6naPPWKYQOts3VDXqHK4?=
 =?us-ascii?Q?4l+HPahG+4qnLGxuAymVcHMseeL1Ui03iM880Gk+Vw3i1MQpS7Gp3M/SNvZR?=
 =?us-ascii?Q?FMAd1tPj+JpoaonVC1BHFsvNSDy0/jI5RSx63KLT43ckbSF7b+SrENUk7agf?=
 =?us-ascii?Q?y9opPEYZdfB3O/a2e7IynuDQgfQrzqrgqiAn85A5MNsEtXXOEdNCDXfRr/7b?=
 =?us-ascii?Q?wwfzEzO0hF3irFeVrlb5RSjkKYOG8PKn3Rdhxgz6edP1/Pkaa0pDu6ihzz8b?=
 =?us-ascii?Q?TclE3z+UhqzLuagQnnm6izBNBAUsZdHJa8ihyIcaUsgAk0taUDSAke+jlP5I?=
 =?us-ascii?Q?kQjorkD6Qglj3vpQddKkM8AuASEtQIKkbCXI2UzZL0vN9dIqxFJTvbrHKfUV?=
 =?us-ascii?Q?ugOh3uG/Ktw2q+EbaSebjajpBsD15L/sOsl6Nkg2Xi7jiLfABWobQo9TU7PO?=
 =?us-ascii?Q?uzHOOzduyL4oeL7Vz1jJ8GgPxutwrCLGxTXBSHWo9BftzXmo1Psv4BQDNthD?=
 =?us-ascii?Q?yVN65MnAp7+fODAVKuNOpAWPtcROQ/xAL/tYdKlL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52ada4-6722-4b2d-f7fc-08dc39be4f52
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 07:07:51.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ9glBhtZsrrh/otrtk3Uwk8Imf/r/Xv7mQ691xYZ2tC9AWspWa/7Eco62itABe5f4G5mTngdEXH6aVZiH/MAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com

On 2024-02-29 at 17:00:18 +0800, Abel Wu wrote:
> Hi Chen, thanks for detailed analysis.
> 
> The title of this patch sounds a little weird to me, since any
> non-empty cfs_rq should have at least one eligible entity.

My understanding is that, current + cfs_rq's tree has at least one
eligible entity, as the current running entity is not on the tree.
In vruntime_eligible() check, we consider all the entities on the
tree, plus the current running one. So, it could be possible that
all the entities on the tree are not eligible, while the current is
eligible, no?

> Besides, choosing the leftmost entity which could be non-eligible can be
> sub-optimal, anyway this is only a workaround..
>

Yes, it is a workaround to show the possible scenario to bring NULL exception,
and it was not root caused yet.
 
> On 2/26/24 4:23 PM, Chen Yu Wrote:
> > There is occasional report from lkp that the kernel hits the NULL pointer
> > exception:
> > 
> > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > [  512.082337][ T8305] *pde = 00000000
> > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W
> > [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> > 
> > This is caused by NULL candidate returned by pick_eevdf() as Abel analyzed.
> > After
> > commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > the NULL candidate would trigger the NULL pointer exception. While before
> > this commit, there would be warning.
> > 
> > This NULL entity issue was always there before above commit. With debug
> > patch to print the cfs_rq and all the entities in the tree, we have the
> > information when the issue was reproduced:
> > 
> > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048 min_vruntime:763383370431
> > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852013562231446
> > 			min_vruntime:18437121115753667698 vruntime:18435852013561943404, load:629
> > [  514.536772][ T8390] Traverse rb-tree from left to right
> > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > [  514.538539][ T8390] Traverse rb-tree from topdown
> > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 min_vruntime:763383370431 vruntime:763383370431 non-eligible
> > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 min_vruntime:763760947228 vruntime:763760947228 non-eligible
> > [  514.540340][ T8390] Found best:0x0
> > [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address: 00000074
> > 
> > We can see that non of the entities in the tree are eligible, neither is
> > the current entity on this cfs_rq. As a result, curr is set to NULL:
> > if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > 	curr = NULL;
> > 
> > and the best is set to NULL, which caused the problem:
> > if (!best || (curr && entity_before(curr, best)))
> > 	best = curr;
> > 
> > The cause is that, the curr is eligible, but vruntime_eligible()
> > returns false. And the false negative is due to the following
> > code in vruntime_eligible():
> > 
> > return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
> > 
> > According to the log, vruntime is 18435852013561943404, the
> > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > thus:
> > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> >      delta * 2677 = 7733399554989275921
> > that is to say, the multiply result overflow the s64, which turns the
> > negative value into a positive value, thus eligible check fails.
> 
> Indeed.
> 
> > 
> > So where is this insane huge vruntime 18435852013561943404 coming from?
> > My guess is that, it is because the initial value of cfs_rq->min_vruntime
> > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> > seldom scheduled in, its vruntime might not move forward too much and
> > remain its original value by previous place_entity().
> 
> So why not just initialize to 0? The (unsigned long)(-(1LL << 20))
> thing is dangerous as it can easily blow up lots of calculations in
> lag, key, avg_vruntime and so on.
> 

Usually the min variable is initialized to a very large value, so later
the real min can overwrite it easily. The 1LL << 20 was introduced decade ago
in 67e9fb2a39a1, and I don't know why it is this value.


> Say during this pre-life, which is about 1ms for 1024-weight entity,
> there is only one entity running in this cfs_rq. Now another entity
> with funny lag joins in, being placed somewhere at 0+ vruntime, so
> cfs_rq->min_vruntime needs to be adjusted accordingly which leads to
> the breakage of cfs_rq->curr's key as you showed above.
>

Yes, this is possible. 

> > 
> > The proper fix should deal with the overflow of entity_key() * load, but
> > I don't have much clue on that, so propose this conservative method to
> > restore the previous behavior before the mentioned commit.
> 
> Inspired by Xuewen's proposal, will it work if limit the key?
>

Yes we can, let me think about some debug code to demonstrate the scenario
you described above.

thanks,
Chenyu 

