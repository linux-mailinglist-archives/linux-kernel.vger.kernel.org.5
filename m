Return-Path: <linux-kernel+bounces-53805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAB84A6BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672601F28372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468F752F82;
	Mon,  5 Feb 2024 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XhsCnt2i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660052F71;
	Mon,  5 Feb 2024 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160445; cv=fail; b=kL0mZ0uhcPK5q419bkXoCiyCchhjl7YokLSU4ZDXhDrH6LGki/epxnJm9IZm3GX0AiAKZs8aMrk/axAObDjmLYt0/0k7ubW1/DbCQX4tnutzIF4IRqjqVS9Vrh7i3xezCgcXYV4P3kaQzUPUAbWvDXxeyoLdatkdQGt5zqWc8JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160445; c=relaxed/simple;
	bh=dbzpiRfJhkAFNKbisXLloT3Qwu3mUHn7/EN8YHk6Y4s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e4/H8/5pfh5ZfhvO6NqUrFX6C+JJFoA3bZ4JqjG7qrES1xFWUIMk4InY/fdVpZsX7dk+rfvXONkp6J46104QsJ2r3Pgiah6q8hJMuqVRetHdm1KL/yi6S6XBglNDbYDCuUOgLHhP9/E5cDQsBkHozBBUs1G8qcSlL8TPELNtAO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XhsCnt2i; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160444; x=1738696444;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dbzpiRfJhkAFNKbisXLloT3Qwu3mUHn7/EN8YHk6Y4s=;
  b=XhsCnt2ipmjvjKbqZMFW2XjZ3UVCnoIb5APwOSLlwLLVnh2H07k4lt2y
   7kGh2d/inqaaRp7CsEZEHYUUGcasOmETXfY+kVQaOvBoFpm9U8+F7HnkL
   LPbwA4ABqMNM7SwS8iBvfCx9699NasEifc/hBh53C5n+01hU/aJeimmED
   ZbkFXqT0KyP/px2ud7Bb2Uv8bmD7It41GQ4tWyFBr+y7+PAFPlVVZXDZ0
   Z5xzEvhJ3R8VVr+A7S2CRte4SD81ATcA0LGPO9lzoEE3vBW+sZFfJ29Hw
   m+VCec6NP2+ln4fLIgcEwL7AgrFYFrT5Ykf2bCa6eRHWZcTscESOnom79
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="739299"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="739299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:14:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1136773"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 11:14:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:14:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 11:14:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 11:14:01 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:14:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtxLmG0QicXV2lx3TuE+Q4tyrF7v3nfjxIrqn2o/TM3SnpHXXFANSUzGKwQWkaYf4BsAduEQuFtTeq9xKHEV8YjUYhTykVeo1Q2o6Ez9+T91IJktaagVHk7a8+hJ/LjvvTu059uOtvOEf/irWE1kkBAEtP5PDVkjKhjFw2hIlTG9KZyPqbPxjDLp1t/3PImG+ihQ8aFlUUZ3RK74GZYX+myR1Xt0kLAXiOGfB5OIEDtDIKQtP0Ed2XUSgRz2nKQplLPnohlPKb4AAtt/gv8xGwtBMV2BkMcOYi4HAEsdsoF140tD3v7B87cbF0dvp/of9leIm1ZKQQTBV14OyszWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xymbRhY7r+yEhnyIzN2CAz2eSeYWT8I2BGCuPvqNtvo=;
 b=oQzjmW6hc4jgGP8TG2BZ0G8N6XoHtdKDAcS2lPfvpVr5h5OKc8BBz/vscOjJq3PFhXCTyMoSZ0YSd1qY1BjO18ScpqpqDn/WqmvM1b4ARcpB+q8TuLH22WcS+z3a8Pay1eT+bTzL/lwyGh1gAJ6Xp57XRmnMsnhPp3H5NclB/ExlVGDgOrdQSyI3JoTMOlCzUatj0Ccwn+Cus6pzb4ksWVoxm8G8hws0LG3yN69JcLZxIC8fTwKnxluoK+wNmXHxjzru9hpuOH0bl/cvYpPxglRIXo0opf9zqWD7jOJ3QOeJEitVp/2z1nmKwxmb9gGaSqrmL9vMiytbcVXk1mWYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Mon, 5 Feb
 2024 19:13:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:13:59 +0000
Date: Mon, 5 Feb 2024 11:13:57 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@kernel.org>, <linux-cxl@vger.kernel.org>, "Fabio M. De
 Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH 1/2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c133751a7_4e7f52946@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com>
 <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204173105.935612-2-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: b67175ce-2157-40be-d526-08dc267e9b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaW/10TeXWFIPDW3pTwop3+shOMDBPr+Pb8p8RU5mhNyfVmd9zekC9zB2Cho0OBp1gmaV/NrrnKwy7ZxmMltoDIOEmfbL9+bxFyW8S0iGRgZ2wKRopyDbPkBMInqFv3Ai4RNarKqu5+78gxkIpalEhL58LwjJCAmZiaa096fUO08jTmfpGUx5nf8SyalpEhIlUgij8C0HJG+Cun0oWCxGZ9AoAvyCbq2N27B7EgzteChOnp2qABRaUMuWOsDgbpS3TNIeOWepVVvXxyXF0m2g8vSVJk4l/IhboTBkdpd6BYLQFokN+LLXPYkqggKVN5O+WdlnW8PyYi0KKT7mP9dOzD0ofw+REEVFZ7BlAEhzTqqCK797jdMYBbRU+O1l+q0xA7ELGbK96qoex0/hmi3cS6c7v15bk6t2MjAWNoC8thZN/PHl+njEyd42QF8NKeynMsoVR1Id+tFwmU2k8yYOGF7o7Na/oxNWo/7Noc+juszfaoizL9Xbu/7QmaO8Nryi9CGR6JRTeN/PU0fXCOyINgobAd6KN3bdaBMQHQq5fWXy/VGbzDgwA5lRCYSzmgE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(66946007)(66476007)(316002)(110136005)(54906003)(2906002)(8676002)(6486002)(9686003)(4326008)(6512007)(478600001)(6506007)(41300700001)(5660300002)(86362001)(26005)(82960400001)(8936002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m9foP7Hv+xIJ0Ua+SSv8/a6tkbe42v2Ih65LQtxytoen3HMmjcsLU3TCtNMI?=
 =?us-ascii?Q?p0QBtJxAmSTfKyMqN9Tx5fMd99rsiCdKgzmOHldxKiWTG59aJv4ACVwC2TK+?=
 =?us-ascii?Q?C4ICuUdwfgtRx57Q+tY60141RubErFL+Vt2+DYk8yWqtP/QC17jRvQGMNchS?=
 =?us-ascii?Q?l07VigNWECFjUYS6bwLtXkduMeDr+16P99y05vgFZYRObv7976bjvq3v7XQv?=
 =?us-ascii?Q?VEO7FJQ0JELY/dkrg3PxDQ27fb7x9Yh2XPuQhyceA3Tj6QiL7mJ9GGP+AYvB?=
 =?us-ascii?Q?mvsJjkFJLKzJDebDKTZbYngDV2DzsKyRMjYe7PuEzdaQpF10vJZY9EqrCmZL?=
 =?us-ascii?Q?ZB9wq0DaD36mYzTjO4OQsQyWMHFb6DUY6InFcIJQKFucm7pkCiBcKqHQQT7x?=
 =?us-ascii?Q?0WC1oOGLkPDXei1zz5Tqr5ci2VKAPYkoWmk9PuCgAqR+wIV8FazLs0u+mYw8?=
 =?us-ascii?Q?jPcu1Bsu7DWaT+qZUKoN32b18jGEAByiQ5JHV6npaMgUQCngKBEi9ZJfdJ56?=
 =?us-ascii?Q?lrR4A6Dc/7EYRN/X+YX5zag9gaGvSWhI0AQnujH73TczCc+NJ6NVFZ1hSqlA?=
 =?us-ascii?Q?nZfzRKDsQkdHhxqMaZxhskJe1jspV/iQ5e275QkvOhpypXwR1AAWj68hPUn8?=
 =?us-ascii?Q?YxfOeUYJbOZswfs7+aNnjlrmPgGaagTuHtJk57GJAQjHI5VConTq5l+47Pa/?=
 =?us-ascii?Q?bdoS9ggJnGdfcoNj6nWac+ZkVy7UG2AyE2SaxcUNTaT/8r9zOTFuoBCtn2gi?=
 =?us-ascii?Q?sxRKIZWFBIspkWXTLLDlf/GSuFm+k+zU3rJ7jwNKeBJT1AoKImXatXV4vo51?=
 =?us-ascii?Q?gdFzZUW10uk/BIFwtIAeLk5BJ9Z11qR0blZCN6tDbyRS0E98Rj3ruBMnevw+?=
 =?us-ascii?Q?SKOSTjn6iI1U4+xZan+blvYVk6W1mzMR2kynPVsVrYdwvqKqcpv/kjEyTQ6P?=
 =?us-ascii?Q?gYiznP1luAQUrRANPFBOclms2rDBF1TNomosFFVKjAcJPLTrT1mM6r7v/7RF?=
 =?us-ascii?Q?I2gBvi6eI+IuCYsky15BzUxRWQw6HfjC7wwxNWW94pSzZNJXe+xeLnFywUv0?=
 =?us-ascii?Q?XcG7Vwpcqh5GdPFraKkn/xbI8NrJhMAz3SPvCeRqNAUnBHn5+qncpnCKAbVU?=
 =?us-ascii?Q?VBkJ1PKXXgzcISemHz/2DhOMbJh0jkW8Ej+fDOL999DCpVV+SJu+aDqpOQgE?=
 =?us-ascii?Q?fDJFtb+ZYVYxKgDRPuxO8GWHVwmadttQX18KwLIS9TcmEFFveqlyWlTzzimi?=
 =?us-ascii?Q?PhioA2SbKVtGJ82ThWb+Fhgi/iUa3yAU9s1iaDVGyramE6bbaB64P2Vot5wm?=
 =?us-ascii?Q?sPb2AGB5asOYmfFsdfmLCctoVqJMq8H+2/DnpsvPAGty9xR2C7SquGoR+8yC?=
 =?us-ascii?Q?hxC+slGPdFHIDyP43fN+uvTtvOOpL4B3IgfFAF80eh7JBYdP1K/4NxeTSWl/?=
 =?us-ascii?Q?zglIGbdP7nlGxWv2AE7s312KKKP1sI/ivcgGKKJRqD6aCCpUkCwaIbiwztpa?=
 =?us-ascii?Q?IJbIjZlDJaq1wk70kNWbu8Pk4j1gpOMYWd8fzEnqzAAyojwpmDXJcDP2+IBX?=
 =?us-ascii?Q?2VYIDIBYYJ5PxarxWpDWx99b+2bye+csXBIiWJguZo2LEhz+CPrGsGD0D2Ys?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b67175ce-2157-40be-d526-08dc267e9b18
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:13:59.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhmlZqSbd1MnF4J0UvYmuaKKI6R/5ym1nsWGF9KT4OZf/h6+752DJgoCt8WUjAI9q0RU1ZPJfq08yZFdUYjuGFPkZJQTWF6QXC2lykITAqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Add cond_guard() macro to conditional guards.
> 
> cond_guard() is a guard to be used with the conditional variants of locks,
> like down_read_trylock() or mutex_lock_interruptible().
> 
> It takes a statement (or more statements in a block) that is passed to its

s/or more statements in a block/or statement-expression)/

s/to its/as its/

> second argument. That statement (or block) is executed if waiting for a
> lock is interrupted or if a _trylock() fails in case of contention.
> 
> Usage example:
> 
> 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);

Missed commenting on this in the last posting, but multi-statement fail
cases that print and return 0 are unlikely to ever be the common case. I
think the most simple to understand example is an interruptible lock
that returns -EINTR on failure:

	cond_guard(mutex_intr, return -EINTR, &mutex);

..and then maybe mention that _fail can be a statement-expression if
needed.

> Consistenly with the other guards, locks are unlocked at the exit of the

s/Consistenly with the other guards/Consistent with other usage of guard()/

