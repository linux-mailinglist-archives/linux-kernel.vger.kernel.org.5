Return-Path: <linux-kernel+bounces-105705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4284F87E30B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713BA1C20981
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADCB22339;
	Mon, 18 Mar 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S91cuFL6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B3421A06
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739497; cv=fail; b=ofrMRiIy3qSh/uHRpDiiyWwGe/y8G/YS6Ex/87N8bAGaMPNb95NN91LHjjYQVEoomJd4xvvidyOlazoKC3j5QTWpevVQaWix0yxRLEaZQUAyu+SYocehe805DwHZKIM9tEz3WG6RZZPkIrYVC+PmeEYAm2KK09GidanssfMZYuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739497; c=relaxed/simple;
	bh=Bt9wy0LJC5PUmPHZ+J+PxExOH/DwQrcnlp+bDuK5Gag=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UQlF4BUj2qdKd9tjxX9A0QaDMMXsmU+C1MdTN+VVBoU8zz7Eiv5I8E+wrV+DUFlyTTq7/YLBE4HVqFioUFOa26xGVpQtLgiaRBbc1hac0YxBtY8Iav8jEsgcMwU1VwTMHmQuCE6+7GxIkqvevxa//0GLVDB1Uy59gpXWZfXrZhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S91cuFL6; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710739495; x=1742275495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Bt9wy0LJC5PUmPHZ+J+PxExOH/DwQrcnlp+bDuK5Gag=;
  b=S91cuFL65S8ES4jdHFBEXzunG7P+41IeJqzVXpfgYCxPTHuvXEmlYFV4
   7tU7DUh3cxkMSEt9mLWCkN5WjzHyI8CpOyU5pDE86jrlkbxer3cENCu7d
   r2rT5b3Mw1/GbuT4mSK+fBq4p/VVeVeiider4o6u+0QIL0eVlClLqrqpG
   7AXX47Eb6ZfQzX1oAX+7WYES6EqfF+wLUv05l+BYIE6KzG8xdkrq82X5+
   P6lBlBjho2ztWp6Wo59y+2RzXQKw3YfRrjf25JYDBv4vYbWvThdhkLwar
   qGYuTqUaTer5KthHh6UnoTRJNpxCYw8COe0rgI9jGfVIa2iclbb1tazi9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5743633"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5743633"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 22:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44288164"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 22:24:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 22:24:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 22:24:53 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 22:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnaLozrKuPfn4bKp83f7oYJWki56Ay0HjirxDX53YhK7B6dgMIqP0hwXhWYOsRi6V1rBvZ8d1kNtAHoLzezsFmftfltfjvAhn2XYWWwJixDtO2NcfT3yP1eGGZi4/nbhLZjyZojPuyud9Utyr+czdkQaOEmvXOFgwIeiouFvnF3MY+vYPSrEd/SWLVed8kKt3XYfpecpDA/LhukdNhC0hYiFWCITssQyvPY0yiEZ4DmQ5cQS6ioZHrqdG3YUnhiVAA12/izmTv7AzmhWZEytIWSgaLj4XEuWWykvV3nz73KziYGofSX5Qli21naIBIrUQP/ZfQS3aEXjOzrVlKWPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOp5Oi2zZOj7ueu0zVz1g7m6zK9ZQXqSAoz2D/EqY5k=;
 b=Y14vFIzIDejMLlxZbihLT+3pvgcVXusCVywEgIeha7Ty5+bOdp0zLM38bbXEnqb7AOrJrQsPq0tYelhxUKZltl+FFcZlcZNhCfR83J0RFrrZIZjJJQ9jcHFSb8SBC0bVnrP89fo/XlDLZyvU71XyWOtui+pspJUfE1QEBW6lTPxiUMlk9Z/2X3+4laIlgbnqRxFpxehAWiSDj131cZbOnn+tDKo621rhpPqkHQBdi9HPtW6Bsu5Hs3yckh90fT/NHk59VIGqqgLbVuDupuiqswzSkOrF67xZfAkuUtgZwaPIsQRbOvIg2Qem+oToLsDZVwGxIAMAIjL/5LTlU47gNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 18 Mar
 2024 05:24:51 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e7c:ccbc:a71c:6c15%5]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 05:24:51 +0000
Date: Mon, 18 Mar 2024 05:23:03 +0000
From: Matthew Brost <matthew.brost@intel.com>
To: wangxiaoming321 <xiaoming.wang@intel.com>
CC: <lucas.demarchi@intel.com>, <ogabbay@kernel.org>,
	<thomas.hellstrom@linux.intel.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/xe: Failed getting VMA cause display stuck
Message-ID: <ZffPt/ww2+/TTMQ+@DUT025-TGLU.fm.intel.com>
References: <20240318041244.1239610-1-xiaoming.wang@intel.com>
 <ZffGYCzt7dUe9Ox9@DUT025-TGLU.fm.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZffGYCzt7dUe9Ox9@DUT025-TGLU.fm.intel.com>
X-ClientProxiedBy: BY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::15) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aac6540-8e4f-4c20-0309-08dc470bbc81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rq4GAMCweFf9kdkJK9QGXzWxclX3E/nXbzls9tbwXrrqzHOBcpdDfk8/P8TNI/cXd44N7mtalK6Zy2V6w4n/WsxTmUA7ENPBSPC8gmy/RmSls5AQEs10WJUu9ywAmoLp2nrnBNyri4Yuv7pPphARemClzWFysjS1nhuX6UDY01chYS34RTKfyJUgUhzBYVId51V9aHWyK6MuTtiBBIIw/hPPBxje5d4K1g1ZoAKfvBo20r2gW8kC5MzEtjc1u6eyeU8yFJjlidPZsz3RrWp23EUCXtTKN/zHsXp9sbjpEbpvT2YyzX/Dm9TyCh0weADk1jFwGYPCzr7cCsNbnPiUjcwd56MkahJejsm6ay5oOe0+xTOhyw9uc/KNPkbeAJZSqcZ9ujMhbTIsCLmJb8f72KT7fmeKIkdNrGLqSfHMoUte3bcQhQP9e/Na5wNbfcqwxs2QTzrFWr6FAYLFJSo5Rjm7uyA9egkU6jhoJ1n11J/Ef4BAoFFb1TiJV7Axg1oCvTvZNmOlwbhSqtm/RhClgafAfI+tPFP0sfV8nRawGKVOlRba9pKzLvpn6vp99LKwDfGSkQO+jTtA/ZhNHiA2KHVnRpZXkniGuPvQ8VkoedZG56UFGJ+ZYcJcKnl6OVaRTXU9OJMIm48LKFPG0fSISjzA3vQorTYfuV8YP/qHbhA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYn5r6VtHmKPwRPFgpp/fkW+DCOKykQv4OOkz09MdTmwr0cfj/G/SI6LsCgm?=
 =?us-ascii?Q?9/s/9aTNkDKPvrPH3uDP6DpY4Ocg/ewCXwm5f4iOeRAnx3GePB9MYJxugXbb?=
 =?us-ascii?Q?PRsDw7NKaO3D3cKvBap0tsP42CMLFkFPr+x9VaISxGFxTfgxYCqCri96q+Rj?=
 =?us-ascii?Q?GOqOVIKwcDYuS/7TfQf8dmela/g5kfrpoqOxkjjhZGoVQMm0NH1XnngZZU+c?=
 =?us-ascii?Q?wweY0BoZJjJkYJjPd5eBNMsFcclBk3b5acfIwfE9LjG8HKD9auOT4JBHQiCw?=
 =?us-ascii?Q?KMUDQXSG69NTdC2N0lnEQ18wCTi5PLcOwbI9hyxrt4FRG9AuuxW/DZaIpCVm?=
 =?us-ascii?Q?R65+qkKcGv9qhYca8MXDvGtYkl9/l5QwGy1pHTIf9fhBJLQVR34Za5TpO/TW?=
 =?us-ascii?Q?UHbDPliQg1CMYkaI/sATjQt82rljDp+hza/HD8ACWSn8xD21E4o1BE/YoQU8?=
 =?us-ascii?Q?zG+wKEetrbc3cbDnAkhFztuLxzzSvQaZHfItdBlbgUw40+edpkrkCQfjU3zL?=
 =?us-ascii?Q?789rxsi6/3+By2vIyD14B5PPz8SOjIUn5FzmQ7yWPh9TLoFqKn9kp0tyUqJP?=
 =?us-ascii?Q?l5HGVn+I0Wm17Dt8a2arnOTUb2WIyuS9UqarBtn/JYZtFP/HE+8v+FKBbqaP?=
 =?us-ascii?Q?ojzH38tw7SLJ6ZepiptY2JTC2OC1iyNJapN9CTHm5VVtbTkovf4aGjGbM/uj?=
 =?us-ascii?Q?CWih4/sgCEReuw+kV1k3gTsXAcfqHCTKzbxIvmYuv+U3At1i5S+wVD99De9j?=
 =?us-ascii?Q?ib5d150eLna+HZGHa++71UOcSAC06eS6pCZ+STkI/+Mb1ci8jwfuC8vqs2F/?=
 =?us-ascii?Q?66/4m1rIEcokD7UTSFz5rVdsqe51TUu3VoOvYazLiArzl9qSQKVTfFMJBhzo?=
 =?us-ascii?Q?1RysVCU5ScrDTPe6RuWKsPw4St4Begd2+jLZwPSZaA7E3wour+ylgwUlpOPC?=
 =?us-ascii?Q?hxci6PyuP6JHIJ0aXGht6hytE1NS9jhhcNvxsLNHBordMXXpiNH/DbA2OUdp?=
 =?us-ascii?Q?p7L2hx9l+oExZyHx65S+D48ju1RkenS0XC2MBmB/2U5AAprd1dHVLPlpPLHQ?=
 =?us-ascii?Q?gxLoXXdNkeKZ2L+D/UzN2lBhTNS8GSayZZl6GKZ+6GkwT39Q7g7DiHT5p4jT?=
 =?us-ascii?Q?umlPyytCrgCd9bNEq+wtVXjGJF4uCH7/jsaPJo7AVfrsjF4LFd9PADOak+Rb?=
 =?us-ascii?Q?hfRqpylDAiAZQQhUEwmqOJugU+ToNNDRR1z3alkN0bnwV0QjoaD2il0K73FG?=
 =?us-ascii?Q?fmMiVsG7AjpCE9AqGswROX6UXS+2pj7lKrSd19qnpeTPOEVpA8EDG4bj3/i1?=
 =?us-ascii?Q?NoyLOyn114xo9vLNmHK7zw6sMqdq3D2JltkyBs/GIqQdoFI3si1BZ+bfFG7O?=
 =?us-ascii?Q?Jg1kALJAkxPfGvZ00PBopj76tWrx+Ks9sRWA/ToPx9iBLCIQl2Y9u9+yWZbA?=
 =?us-ascii?Q?P1r93m00zjgz1BsfjqTOSQj1M5aA3Yx4yq7L2mpJch3tCGBtDpPEvjC9wgIA?=
 =?us-ascii?Q?OXhcNDq2rHr9jh1W7D+TqzcUWNrErQDqQ01bb4kqBgY3U9UqjcyuTuoEwefw?=
 =?us-ascii?Q?L+Y+OeOUGM7xslyxhGHZJyFDyeVMximZt8szaq1eFdrApoz2pZCpL0aYyPSG?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aac6540-8e4f-4c20-0309-08dc470bbc81
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 05:24:51.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHtncHRhvj+qlJn5aSt9fwdXN96awIW6kRLqckF2V2bJC/O1nU6AooqxjkRWS6it0ZzNBTSPyxtX9ur1sU+q9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 04:43:12AM +0000, Matthew Brost wrote:
> On Mon, Mar 18, 2024 at 12:12:44PM +0800, wangxiaoming321 wrote:
> > The failure of binding VMA is duing to interrupt,
> > So it needs to retry while return fail.
> > 
> > Signed-off-by: wangxiaoming321 <xiaoming.wang@intel.com>
> > ---
> >  drivers/gpu/drm/xe/xe_vm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> > index 99aa5ffb0ef1..d33476b631e1 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -2621,6 +2621,9 @@ static int __xe_vma_op_execute(struct xe_vm *vm, struct xe_vma *vma,
> >  	}
> >  	drm_exec_fini(&exec);
> >  
> > +	if (err == -ERESTARTSYS)
> > +		goto retry_userptr;
> 
> This doesn't look right. If the user presses ctrl-c we'd restart?

Typo above. s/restart/retry.

To be clear this patch seems incorrect. This is traced to
dma_fence_wait_timeout, if it is interupted, that function return
-ERESTARTSYS which would should returned to user space via the IOCTL
failing. That is what the exisiting code should be doing.

Matt

> 
> Matt
> 
> > +
> >  	if (err == -EAGAIN) {
> >  		lockdep_assert_held_write(&vm->lock);
> >  
> > -- 
> > 2.25.1
> > 

