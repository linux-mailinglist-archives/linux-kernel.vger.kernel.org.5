Return-Path: <linux-kernel+bounces-72677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157285B71D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18F91F254AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CB6088A;
	Tue, 20 Feb 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akeiW4KQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9BE5FDA4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420684; cv=fail; b=Q4rNHjJExPcr6tE+mGRiMDF+cLZoTa0pWeyZhhDs1WerHTTkFogGj+PBTsT49pVI6IqPkdg8yD8BBt+ragg55HNU+riqKL8uPLt7QcbCxwHDH5KUQLpgTtC2ZT2HDFj3Lp9dWX1W15D8w4X3ss4TMEZ893x6/7OnYKeNKphvCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420684; c=relaxed/simple;
	bh=S7NgNSbBdwNZUIq3yxz8eaDwFWkBU98ed5DhspZV/n8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDc+xvKI9k/nph42JDlj7aepp0zglEo5f1AcHszOvd+CqiEJs80EzvVMn3PkGlvdhYO/guzKa652UnVGj4AlpQ6LbfBrX3+8BKP4RLzIbmrmm9RrtqUJJYA2yhP7hIZo7zzBoHBNdCvDYbhLQJwi08QehVtffjYDY1jCEayA1yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akeiW4KQ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708420683; x=1739956683;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S7NgNSbBdwNZUIq3yxz8eaDwFWkBU98ed5DhspZV/n8=;
  b=akeiW4KQVI/oxPdE0opVZB/V0KZVnNsNYbxidaRBZk2wwXvMcTpRKuzr
   0o4O39mtsWNL9fQNFXR4hzw6J11Znz/hgKDcJP0erIU49ZmpB2HIw4yAo
   OnwdcVFDBUXf+bjAEAV+qLrDlzQqhk72DDkd72k50sWpVYdsr4XZCYyIK
   tVbLTjtPnchFoYNXnbzOrQVBpBP1Kly5nbiJuBAGSZ8vbRXRuHeNSHluT
   gg7PVJy/sLTCdC2RuUpkSWU/Ua7qztecFp/++S1O5Hpo3yuxB9Mz3wmUY
   4lTxcugOdo/8NV7Pu06OEFwIFqCoUiE0td34cCMWuN3AaGHxbY3Ghi6+n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6330917"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6330917"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 01:18:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9386082"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 01:18:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:18:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 01:18:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 01:18:00 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 01:17:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1yAnpTuLndWlDYf0o3pWPtdLCtLaSCUe1MpFf2EmbNVjgP2S9PzIaokDAUEb0BhbaqM6I+0o40+Px/osmclPEmsAs1tztXmtg8WSIkapUUQmlD0XF2NkP8QId4OHz94sUJiN6cIvTSnqu2MtNwcOoyrCM2mEiqHHMiLsjYwBqBQqyHakBMIu6+QMVgUBCksNG5tz5s1fyeMA6ar6g5L5seGOWOPpmHtgu/JRn3l7FinptpRjG/NhCgNokWci6yWv3IqWXg5UTAiJPvsM/8bJV+9GjOg2lv7ctzGwRerTQRVyYxkaGT1q+FkGOyOKkzVhHrjLx6AEcwG1733hPzEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOrT/57iMJhDlN2VsC/1I5Fp0UjLF7IiQiJyMX2pKgA=;
 b=Fco4ohigwmawPs7ZQlF2giaAsWLQSWtQgQoInJd/0n5/OfvsAK+lrfGI9jmmeonPVsnTisD/el019WbRiUWnN1hsF9J2esk+QMKRGJqfvBHdiKXXSoweocvO9GpK8DXbxBvk1OML1ABMtwBVFbbZbwZHNT3IyoyFSMn2VdeUC2ZAlYKWBiezb3ooZ3N+9onF7jKNrcXRAUxt5zDncGtFq4cuzo3TmZm8wPseIu6iKmG8oD8r1mqmkk8ilCtZDh5f2YQnkDzkKJ5NhBh+7cE+a7dbMjlc2T4dONEX/+GMXLFSqw8IMxa+bP7F2g8wjpwLMgsCZw+qDVftwyUzPfveEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Tue, 20 Feb 2024 09:17:57 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 09:17:57 +0000
Date: Tue, 20 Feb 2024 17:17:45 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Abel Wu <wuyun.abel@bytedance.com>
CC: kernel test robot <oliver.sang@intel.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, <aubrey.li@linux.intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Aaron
 Lu" <aaron.lu@intel.com>
Subject: Re: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZdRuOQazh0KkK8CD@chenyu5-mobl2>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
 <9d8cf754-86ad-491f-9c3b-cca9efb2f5b2@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d8cf754-86ad-491f-9c3b-cca9efb2f5b2@bytedance.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8536a2-60c8-419e-fa55-08dc31f4d3c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYdZTzfr/RtxLw9orvQhrI7gWaZuoqWfifBbs8GxtJkbv8uuCFepui/rpUz/HpXGNJRZ7y1XGrkVuDgW+kf0LJzQMSBeOEpqjN1sH/Yrk7ha+WENaKEBIi0NjvmMbwnjjngfXYY0BZk3BQ247PXCs7OdOEGrHznXxvGvpDQBG6mhciOLt62IY/t4deoTA+tarhlOnADttzOLMgKntFmWHdtgS67Z4YiKBE33nUlX/JCbeOUFjJnYeMbuMLp+fbFuP8mcPBwuKxk9fQGCNlmW+pkdpByEuFORWDyGgoYNV7Eggxb6BAY3gQAbbNYRFC5e6WZf2vOt3pdtzl0ncOlDKoRaExERxz0Gx76l6F6okwXf1UaNyrWK5DuOZCn46otHl1ODE2g6/WECLuncaYhxu+3SqJp+zHpQfqi5xOAqGedYcQ1lnEXwYBbHtT7Gi39YAiJCZs+MdOcq9/IGadX9ViHCKCB/rQWt4ETQIu081V4L3vJ+oUT+Wg1vIFFvLGxi5vGWtGDPZxyie6WoljQ+cnQEgIF4ssUX1d21/M2jOCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QSi4e9Rq9keIlQlcUPI5PPmMO/6G+U/0B52hAgxP4he59s/g0kuKBti43s2G?=
 =?us-ascii?Q?FBSgYp/0VPsaRvXxN5I/8V7ioKNChq95K5xnuAnBl/nnqqvPAXdlmZTxIojQ?=
 =?us-ascii?Q?UdFrNfLE366MP/R19AXsFuA7DmfuUEBBZkMb433bVg1I9OjX0OMeb3bxhqvc?=
 =?us-ascii?Q?LIbylG88AxfE0TG2dk/PmGKe5fTwwriryIpnSWa6cPlGzzNMGjYweZNo1ALH?=
 =?us-ascii?Q?xQx2cvM33hVt3hIJ7dklWjxgNaCbFyG+FxVcE3yiymn+OGtoSms1OCLql8FE?=
 =?us-ascii?Q?KxG8CiS7GNuA8BjOr3sXdiwVby92H7mi7q7BgJMhB7GMx32xks2YYwldGQZC?=
 =?us-ascii?Q?d5mhMn8SlZwbBhGfmiIiJniQ4poOal1lTCO5hSkxFlmSJNJOFLd6GgsOdIYI?=
 =?us-ascii?Q?j/jB03MnMZSgaFNAefSSnoYCGOIDFB9t5oVDM6Zi9QIfAj7QdetOHgB9Smb/?=
 =?us-ascii?Q?OSZy0C0cnmOT4bMHU2F2pS3PA0jBoYz1i5Fw/oMMwcYVUjoIxwIUrVbpFfAc?=
 =?us-ascii?Q?sLCOl9euZEgYLM+tk+wOYj4OHSjTdKd8a9WR8RNSc2lkfC180x8iFoZ1dXtr?=
 =?us-ascii?Q?KEKJC078RrgbNIHoopQNR6gOlbYjYQX9Qj+kUMGz7AkZMNB6vujIxDTFPIKg?=
 =?us-ascii?Q?4kjcqAP02beNgKvR7Db/iBBTrqxaP6CkyK04aa6ivmgCqb5eoLt4+bEhRWGT?=
 =?us-ascii?Q?5PAvFB4N4Gth6WFe5df5XLI1uVXS82Hmtqur/0Vp//w2xZA20waRPRssW+aQ?=
 =?us-ascii?Q?ULzhGMj98vPQLk8gliy2NqUicy/+cmSK0VTgqvAw/NtF85/VqQkvPQ0IrbcW?=
 =?us-ascii?Q?aYp+AWDbR+07vMXpUbfnFfDrHEYFhibWb4hJHWCvkb8CKn/K7hztL3003v0t?=
 =?us-ascii?Q?7aZKCObJX49J+tzOSe0e867+XYGM9mBP3fu6Uepifqicn61GQLrredC5ELn9?=
 =?us-ascii?Q?GI2kHTrGNuQm7zoSMQ+Hd4qbWk1kUR0OhdHsj0/TRdJVgTDDANiBajl4vrUm?=
 =?us-ascii?Q?0NBtZffo7M7ixqWYiz7XMHWkvcLhLFERXdB5btJ0SEu+s1SIlcAfth19zKcc?=
 =?us-ascii?Q?4igDmatH088tjU80jx2XL+ZBU8DRcKHBAkKyqWnF0AOSxYv/T5nt0qvWGnxB?=
 =?us-ascii?Q?d6uMvX6F0pTfdtC0sIAG5mYdFy1+CZ+JrApwPSv9ZtN/DN0wzG18l/936d2U?=
 =?us-ascii?Q?78Ph2hD6ENLTr82u2muQQ8kJqGsW61begqili9fXsljgrSkY8djqitAZ0MD0?=
 =?us-ascii?Q?EWW4weKZjxhSVJhkZ77Izqjd7LnYiEeZaFGd1wL+H/6Ywji2Otu+J7xYoro4?=
 =?us-ascii?Q?w4BkQDrYw8Zj53Zi1qQupXX0FLg1Ki1lpb4jLCfaKpOtfH/9EDTQT0e2M4Vi?=
 =?us-ascii?Q?GgIxH+0OwmhGGpIzPOoQuL6IgZKgN/8JU+tQmCxlkKJ1RhvoSxZMIvmZqIrs?=
 =?us-ascii?Q?UOsXbaACQv5IfnPdxgFf8Y4ssU6Ktv3y6RBBvR5ah390IuIYgxksC2zlv91v?=
 =?us-ascii?Q?xcY36MDQvJmfPa0GJGOVfyXGT8tZzj+aif1v05SmlmkLz9MuiXloVbx4DgTU?=
 =?us-ascii?Q?qWfqrqKecGDfKaNOg8nWuV5jSKF3r4jhMVRLkBZ0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8536a2-60c8-419e-fa55-08dc31f4d3c3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:17:57.5365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxW3azawAcz9+1w/Ydx+IHAjDdqJh0pVO7ms9L/dSZ96Ihv6pYEvZM+QG7SUCwkuTcPFPvIBNjfZPyyHCGcfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com

On 2024-02-20 at 12:04:33 +0800, Abel Wu wrote:
> On 2/19/24 8:49 PM, Chen Yu Wrote:
> > 
> > While looking at pick_eevdf(), I have a thought.
> > Currently the sched entity is sorted by their deadline. During task
> > pickup, the pick_eevdf() scans for an candidate sched entity with the
> > smallest deadline. Meanwhile this candidate sched entity must also be
> > eligible.
> > 
> > The scan is O(lgn) on average, and O(1) at best case. How about making the
> > average scan even faster by sorting the sched entity not only by deadline,
> > but also the eligibility? The idea is that, the eligible sched entity with
> > smaller deadline is sorted at the front the tree. Otherwise, if the entity
> > is not eligible, even if it has a smaller deadline, it should be sorted
> > at the end of the tree.
> 
> Eligibility is dynamic due to the nature of weighted average vruntime.
> IIUC if doing so like above, update_curr() should take the responsibility
> to re-sort the tree which seems to be O(logN).
> 
> > 
> > After the change, pick_eevdf() get the leftmost sched entity at O(1) on
> > average. Besides, it is guaranteed to return non-NULL sched entity in
> > pick_eevdf(), which prevents suspicious NULL pointer exception in pick_eevdf().
> 
> It is guaranteed when doing pick that the rbtree is non-NULL, and given
> that rq lock is held, I don't think the bug is inside pick_eevdf().
>

That's true, my suspect is that although the tree is not NULL, the eligible
check might return false negative thus no candidate is chosen, and pick_eevdf()
is the victim of that. Previously commit 8dafa9d0eb1a ("sched/eevdf: Fix min_deadline
heap integrity") did similar thing to fix the min_deadline. Without this change,
the tree might be traversed incorrectly and found a NULL candidate. And this is
why I'm thinking of printing the whole tree when NULL entity is chosen in
pick_eevdf().

thanks,
Chenyu

