Return-Path: <linux-kernel+bounces-71474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948085A5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7FB21041
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE7374EE;
	Mon, 19 Feb 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3wIp3nq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A723714E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352696; cv=fail; b=Ytru2ye8oTa8cGbrlmPGzlCmraY5Hyb5LCfjjuClsztoX7lXKOd1Mtzw91jLucAl6q7ilL8r1ccMxfker1Pq3gKOHcxuSqtPslQEVRlDFLBnRtWQDysiFlBmqt/cSEKXZX1//3ubmF64w/8n0QlBlZ8cb3TlogUtyyT6J00phTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352696; c=relaxed/simple;
	bh=j+WLjYG1DpNLCumaCAx7gwu8miX7yrvX9wfnwPslVbg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNLmb5HR/hyhkP82oadDf72en6Sh477GbUydAi+qFs4gGOl+WgnPk6G1kp4b4HnioMRAxUXfCwf6e9QJ//dWhyYj2IMlXNsXPZe+ShmCqzKJ8heN2QyMYb07iAQwV8ns5ccuvUpNbiN9KdWsDFbtLKYCRFSy3gqiZBMzET2ZJWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3wIp3nq; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708352694; x=1739888694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=j+WLjYG1DpNLCumaCAx7gwu8miX7yrvX9wfnwPslVbg=;
  b=m3wIp3nqe3SV2wGPlNMnePeOIsOpHkNyFtk60mbzEDSYIILgikFfKTOt
   DEPaNGCT1MR41HmBAccKGF5OX1izd2Z5wz2Wp4eSSDCWDtu84BkJO9gfg
   wWy2Dk1j/Yd3RBX3N98VobqkJ9BbWgSk1ELRtogT93wWQSND/o+xe62Yx
   +vxd0TMQvBCC65E415DlUGGVJCcfPOqZ6gi9+cmIRbEAf8RiRCL6cS49U
   SsEXTiBtiQLF23hRaOadQQUMtww7IcMjU98XSEq4GjYnNYudUvCcBT9CW
   dP7UxdQ9dA/+yV1lFdnS/sBQC1k0gEyQZMfHtRJW+H2mUVf8ZJ151KL2O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="6209448"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="6209448"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 06:24:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="9187889"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2024 06:24:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:24:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 06:24:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 06:24:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Feb 2024 06:24:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzOZNZfsgrrTKTD+6hjE7LOc7u4Hvsu4kK+pPyhUK+X8/foyccfS/CWEKYFfDN9BCFIrY2HyKhly/jjRjCyR9TZBaDkbmb7H/JVmwVe+sjtZ8bf80N/g6ZicSqoh5iEIEJvu26sngJqg01DMoBpGcETb9W3OaCQQqgvXHcju0rVLhfL1W50hzI564AaOiAg5YOxhhX/8E0lW3lryQfSSIjM+cxCYfPvrXi7L6EDxnjVV3J3eUa9ioZufidLellKaFYLy4o0peIatkMNgW75McpAe2jqXVqDrw3vRZ8eKx+JIFHtKr+lgtntGLueWvvrd+0EOLMaYvi4uHO0l2HbopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj4Odu+DeOUKjgMLD6JZKPHxKpnuMBn4/bp3DWe3c+w=;
 b=IF0e7lZGfuFGe3+NkaoWE2OyeFKudi97nG9rt9rp+OArWdV+l5G3TyIiFUakd0GGiuAXh4gJRo8C1DpTt9LpCMt097dSB0oWtocPf+HutdAstbgQJhdz9bwh1eN0ORBjBwy+AmO4y+utgsxkjslkWSFbUlQtFI8WtPGK9/v9ED30NUJX8NMswv95tE6M+SgjtlY9OGJm0e702YEO1ou6MJ7Aoto3vSxqPRSAynsQanP4GeM4RDMIcQgLDqCWiNmi11diyfdUPxOixEMFwxYrUTQVn5cr//DabUzF5Ge91ZGejduN2SsMvW6uUcLAQv7XwON7A3eL7LmWtTQeLvYWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY8PR11MB7169.namprd11.prod.outlook.com (2603:10b6:930:90::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.39; Mon, 19 Feb 2024 14:24:50 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:24:50 +0000
Date: Mon, 19 Feb 2024 22:24:39 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Hillf Danton <hdanton@sina.com>
CC: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Mel Gorman <mgorman@suse.de>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] sched/fair: do not scribble cache-hot CPU in
 select_idle_cpu()
Message-ID: <ZdNkp5DP8aKnsYGt@chenyu5-mobl2>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <20240219115014.1333-1-hdanton@sina.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219115014.1333-1-hdanton@sina.com>
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY8PR11MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c124f-b96c-44a3-c9c3-08dc3156884b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54D4wrSlUqgY85k8FEOtiHRSpKeFSO9bMDz4aLyxS13xNEoB1ydW/Z7Yu1uCAEYgdSmZex02vXHQC6SG7vr1wYE6KdUvaDWZ+G3Wf+cpokLdtaOjF+SED53SMaB/doaxFUZUNbixE8qVdeJimAJ2eyqCZMsmJhjEU2azUWaXiYJ415plcNHhNRsh43oyVD/PmAjhKFkpHTqrs6JrH2kS1r7xDxJj29LQ4y7hlfI7PTzQo6FzQdBXgbrcBxlBYj4YkyVA0H/VR/eRKrYEC05Q2yGXKte9Gkn3GuambXt7BQcLrc8ASoOPkMA5YoPO88dPdbqcV4E4OXjtLAPkoJQj/7ud92bloc9zpeo63lW9mku8MFlDu/mcQBD4dcvuxdQT65qGWLMq7rDyypcK2zZDic6dy3WkmmHtjHeihHWjwcmO32X2TRSBo3nCkW+Qlokad6jokb4U0ftwRjFLCNi4dkFGOcB3tvqyIDjwbMqgiAxqZKKXQDSzVEo/7MXt2Hp6IRbmmUt4XMJM8XxXeCM8fk3VqWax0rzNjhJe7SRJQEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TpqwfekDaOScb3oyU/V/uTpzWGFMywJvS1ayqc7bInoEHrknhIIvocwkyP1q?=
 =?us-ascii?Q?4D5297m8ug6mcKVLduRAnSufrXG5HFCwGYBtCKt44aImZ/ChLMsUH144R/Rc?=
 =?us-ascii?Q?9Q/38gkVAHXHpzU7piMhij8y2/tkc7/akFKlz7IfNXd+mU9iI3NCG4J9bEZN?=
 =?us-ascii?Q?66XzrwxhbmzQM6f/mNBIZMu4oP0MEzVYOQmi7sVAASDMEykRUXoOsoQttmlh?=
 =?us-ascii?Q?iAo8Gs2u7Lcot/QiBUKAZBFamDVmnp28DjpzS9V7L3JUo53+BYSBcFBEZ3iY?=
 =?us-ascii?Q?w2c6OyQfE3jhSnPUC/v0JtXcJvyUb6N616daQKJyciJT5kwWemnhaL9tYTlY?=
 =?us-ascii?Q?SYtH3TfUijG6a3P+hvYUT9dkS/4K5TBPs4j0klITrz+tgzCtq/cGtcxIfZp5?=
 =?us-ascii?Q?exPAMfFcUJl07bUu033hGKsSmAu3kzx+1vCydmaYd7IRNJlMg2AIhmdMESJ+?=
 =?us-ascii?Q?Zd9AzH1r7io1cimhm71I2vYx30bAgb+d9BTnGKGDNFU5iFz+YlL3gK2soTJ1?=
 =?us-ascii?Q?u8g/2rWh7+pQOL+uyHEkusuu0IkVjAZcJF0wHGCE2AF80a+Kw3Ct4sNZpvop?=
 =?us-ascii?Q?73IkQ3Dcg0uPaYsFgCDkKhgfCNAy5vLWXeecIjvu+Y/IIUq58l2mWaoTAeqI?=
 =?us-ascii?Q?2jEReBK1h4etEXuHOx7tNQ/SD8R20bUGx+oEiOT78qyi7aXqs2/fcuuAtqGz?=
 =?us-ascii?Q?/LaK+b7T2Hj0dsU4bYOhGDu0wZGzZsDMKS3KnaJgEREpubB/NR3tJ5z20IZX?=
 =?us-ascii?Q?rmZ6a7K2+E0WfOKAo9JVAdHCrlaKNK5rmP6bGtGdSG3iDsbGf1m/5+Vxi4es?=
 =?us-ascii?Q?b5l3b8ATLz7DRpYBXUtbwtia8uNLwjlWlE/7I3uZ5LQv4v8L6bEbGsWtvu/g?=
 =?us-ascii?Q?azOChsIcNWO9PYXPtG247aSoyYvbzuMrBAD3xlU9RT5XX6GSJSknnD1xf7Is?=
 =?us-ascii?Q?N5Vdf/vRoR5w+TEGA8PMBFVCGb8zIBFh0aXIN63yD/u8kpNdpnDT6qcOj2Sb?=
 =?us-ascii?Q?THywKBH2DNInd9Li9nnEWDaTm+cuUgD13IWad833qjLScH0bz2PmODDGaJRa?=
 =?us-ascii?Q?s8b9sE7T1fy5n0gNykmDdkOPe0Ka79CJ8EedEdVUIDf30C3HsQL3JPC7xNku?=
 =?us-ascii?Q?RMtTb61tY+yxtuWs5SSGjeyl3G7evrKiZYD1ZhbFtlZUjLxTgQjFJFveXlmz?=
 =?us-ascii?Q?9Lz0QVC9WEkaHjYwrc4ov+e134ctbvxWtUT4njqm6ipErx7F4qbhoyDhBbp9?=
 =?us-ascii?Q?eZ9LPq7N9N9olz75xC9nLRLGkTjb0OLY8HaWlXq5sLz1sGqYiQEbyAIFYZJd?=
 =?us-ascii?Q?ixWvUB2VSoio4NEatY9YtcCW0HCbTA1HcfGllf9KxOF78+Bi4opgxLJV7w8S?=
 =?us-ascii?Q?SGLkjFt6dh/vDHDdIGbrNdb0eKnD32hlK7JbaMz1TKeU0H6vOq5no6Q/7+6V?=
 =?us-ascii?Q?Ax5gWduXsS6EYPGlZUuwxUbWFyUyYmI8hWcgSnIlno2N2g6Q/9juGZURNkLF?=
 =?us-ascii?Q?Hgvb2N6fbMus0XjhEP7jvHNcL79AAG6Rd+3gTHRzE6S7X3BpdsaC3bsO0CPS?=
 =?us-ascii?Q?jhfAbFpsEbpJUQT1dLWydTrOHTo31U93CaNOlL1s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c124f-b96c-44a3-c9c3-08dc3156884b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 14:24:50.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kq2UmlRv2I9HyhZRgmkTjkNAFFRum5LBVqC0pYc1zJC27BkiiKknQ+1mpG2jcLFiPio99Vo835D69y38cybdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7169
X-OriginatorOrg: intel.com

Hi Hillf,

On 2024-02-19 at 19:50:14 +0800, Hillf Danton wrote:
> On Tue, 21 Nov 2023 15:40:14 +0800 Chen Yu <yu.c.chen@intel.com>
> > Problem statement:
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases, the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Proposal:
> > Introduce the SIS_CACHE. It considers the sleep time of the task for
> > better task placement. Based on the task's short sleeping history,
> > tag p's previous CPU as cache-hot. Later when p is woken up, it can
> > choose its previous CPU in select_idle_sibling(). When other task is
> > woken up, skip this cache-hot idle CPU when possible.
> > 
> > SIS_CACHE still prefers to choose an idle CPU during task wakeup,
> > the idea is to optimize the idle CPU scan sequence.
> 
> Could you specify why the currently selected cpu fails to work in the
> scenario described above?
>

Thank you for your review.

I assume that "currently select cpu" means "target". First, the "target"
could be chosen by wake_affine() -> wake_affine_weight(), which can
return non-idle candidate CPU. That is to say, when we reached below code,
the target and the prev could both be non-idle. Second, when target and
prev are both non-idle, select_idle_sibling() has to traverse the other CPUs
to find an idle one. What we do in SIS_CACHE is to increase the possibility
that the prev is idle and return directly in below code path.

Say, task p1's previous CPU is CPU1, and p1 is sleeping. With SIS_CACHE,
when another task p2 is woken up in select_idle_sibling()->select_idle_cpu(),
p2 tries to find CPU2 or CPU3 or CPU4... but not CPU1. This makes it easier
for p1 to find that CPU1 is idle when p1 is woken up, and choose CPU1 when
possible.

thanks,
Chenyu
> 	/*
> 	 * If the previous CPU is cache affine and idle, don't be stupid:
> 	 */
> 	if (prev != target && cpus_share_cache(prev, target) &&
> 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> 	    asym_fits_cpu(task_util, util_min, util_max, prev))
> 		return prev;

