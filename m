Return-Path: <linux-kernel+bounces-54108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBCF84AAE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89751F2640C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B611A4A99C;
	Mon,  5 Feb 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA8CcTIU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612C550240;
	Mon,  5 Feb 2024 23:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177372; cv=fail; b=qXtJ22PPiKVcX2bPhjwffoyete5fhNZIXeLHKw/nu+qU7z+9iM7RR2InUkgq7FuOT4zMCexnwY6hfze8wdR9ASbNWAX8T3iuKTlY2I5x+Y2MJvXIowCPANlv2VsIuLRqPT79ocdjZbsz9mgPvySZdlzhIQz2M3H7JXOvwWT4Kco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177372; c=relaxed/simple;
	bh=bqkoTBEn2L70KAHgW/IzuPVb/FUGyHCm3T/GMILjMaI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XqLJ75clb8FaTryfLqn9kOxu4xyHvuUHA3sN9cvVsSdJWll6TVSsdyrWMrujDtEQQcFpahU/VznLeTSyVI4M1d0/zR0tEXexQXEfg+nSzCQ3PK4c3bHPSTH1gQ9HRe0utFm3R7ElIUFFlVEGGpsXCrM+KMY7r/NhZHgvtMpx1nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA8CcTIU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707177371; x=1738713371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bqkoTBEn2L70KAHgW/IzuPVb/FUGyHCm3T/GMILjMaI=;
  b=AA8CcTIUNCdrTOh6a/QaqMsqKETfqjHTYHGfZc7dtfwky3iZziwTndMW
   43LJM/leezaieVaoqrsaZ3VLzC+YtmlBfxZBWyhLjZxKcFn+VLFQK8DiV
   0N9vDnuAP6yqEweS87ZlJpOcg2VkvkqH+ZfgTYGB7Y/pWoiGJo5bKvD7a
   S//2ZGZOHKa29H8WvwdTsEUS99/SnD8KeO50+U2IZPxb3prej+ZZ0BASX
   2OuYjCmYFi/oK5S/NMk1TpVB9N5Rn2hXvY77fXcxviA/ZPxs/iivnTmZc
   oEqDWz2336XDPHSP4kqjJ8FBLWaYrwoFiLB+lToAimLfzn4bQkNtqlbWl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18058701"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18058701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5609631"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 15:56:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:56:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 15:56:08 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 15:56:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxThLRmvq/tkOtbhvIRd1Yep4vEjlMGU96M+MQeIrr5q5XFDuOHbXJvGJOE/rM1+FYhttIg/oDQDAxxwQUmPto/uK1HZ2K1nYnA9DvuLYqvgevXzF3pVYQtd8W1Xxln8f6vEyWYuDN9cEAP3xzFoxSmnNcGfm+hSWUehjov/NhC80znKKVsLqnoQebOLOogWutr76bHk8dLEpIoX9nVZqYeUy8oKrdwEHDrSKL8UJC9Dx9QXtzLKtBrk1fKzMxXXDZgw3YeJFcMT14Que2Zikjo1fEY9SKqd18ETvKZZDcNMncxYlAj+VfgHU5gasNYDdqgQSarp5l4T/sEB1Mo/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX0GDs/cc4e40zxw6ZCYYHmj2EzmcT3DpcXmvY4XMrU=;
 b=hDD2JMB1aYF+EIkdVTTFwoKwXRsYIAXx21s2ccQk4sJ6WiltILdEDWgF5PD0yuY3K96He79yP4vdYJyh5zvU9ZlfC/LyEE8tHu6PEsblbZFDzdmAxYcbAhCh0r4IdiqZ9Adn6hP5Bb9bdQdk6ZdA5PnqfGo/4NAdciFymHbv1ptGaa+LhEvPMvL8Q95pEwvbz3jaxMzzopEdqUaROfjd7CYh1eQ7OolgzLoeZ8oHAdXJlVZ3JvMSYg7MX8F+VIxdDIl6aqydKFkGl450gCXCeIHs+lVVR6tpvuzcemlg/sTg1Vcc9oXBhUJKaV8jmlKShhrAriksYEbC/4vKsDddng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:56:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 23:56:06 +0000
Date: Mon, 5 Feb 2024 15:56:03 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c175935b175_386155294e4@iweiny-mobl.notmuch>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
 <65c130d7c4c52_4e7f5294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <65c15b025484f_3744792942a@iweiny-mobl.notmuch>
 <65c16b16de625_d4122941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65c16b16de625_d4122941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b73a5b2-c320-4c07-9105-08dc26a60484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hB1DkA44NCi+VbcPhYMH8YBCZGgYV0/SFp06fIvfQuCvx1809JHxSzpP1GTA/5KBHogMGbR7HbfOB3zQ64hdsmwgmL7ymUJ0B58C3oimarEtm0DSgoqMhS2JQFoaIfWQas2VwCKFIE+2p6EQAsGP4WgbREGAOQqJiVjaSdpmXbKBPYH06aFhMRRmiLdlNVFVZEVyPpY6gFkMhqqqMNwlhs3qCkFIwjwAQAjCg12mzVvAspSHpd4DljM+hIURUgWqzafSDiCA6PFTI1kyfUDKOSMwXlRdNxNmPfG1jqWOpLbrV5WhlE78WJoToyD7E54w9PartCJZ5eSctp8YC6+SIkFA762MR1LqsRwqpFW7oedGksV6oKDIrgyh98l9w32PR8k7Fl/8WpPKUfgR2k9fdY1qu8+3z2i4Drw/CHKngrE3+hO54VSXu1VvSVF/ZROIRnMV+ICYsWK1EV2scduMShWSnDZJghIS6LTtq3pK9LuJlpnQLZYhDLej8mOJHgxU1+xwxgCevcbUiLPFZI0VFEbxLdJHqIsGbBicXNExCFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(82960400001)(44832011)(83380400001)(26005)(6486002)(966005)(86362001)(6506007)(6666004)(478600001)(9686003)(6512007)(54906003)(110136005)(316002)(8676002)(66476007)(41300700001)(66946007)(66556008)(4326008)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E+EQVuxR/KUECRi+PJ4NmK9lrAAV6cO2Zy+G7IyMi3Hau0/UyNqnEjRmK1BJ?=
 =?us-ascii?Q?gh7J0DpJJoKshb1lQ/tG7rCCImkPnlLq68VeRlYle381cDuV07YtfT8nbE9f?=
 =?us-ascii?Q?QUr6PG3sbj23waUqBSkShREIjFOFQSOZ68zXR229+WlsUuZopc8AEbMjibP5?=
 =?us-ascii?Q?uTFh04XxUAJ4PNO8UR9Jaj5JEwql+T1AqBWZSCYMVftondL+TsVPQg+mjucF?=
 =?us-ascii?Q?z+XrB4QvOmDtepyR8LwJkDzEed0NCd1OlnKTHvlM8FgW6/G0m++dUUv14rbA?=
 =?us-ascii?Q?5Mld7IUpdPHfkHCnfp3frjUMmNM6RjNzkC6eo0DUAWeYNB71drY8sM+4KME+?=
 =?us-ascii?Q?GzgdhsSlCSjMgKfKmH0wJ1s36LOJ1ykU1BcX/yFE8DhHiU4lCqM5r0tZa5KS?=
 =?us-ascii?Q?WYjTOqHYmH2CkNvY0n43WMcrysBatPSOI9skB1gdA942NibDG8I7wkobCdn5?=
 =?us-ascii?Q?UDygEbkH3UXKfsVqo1O78ZNI4E1WdqQqSNd/TgeouKYaImhrS/l57FBDbdEf?=
 =?us-ascii?Q?SF+Fe8bx3O7ieBwZeKbtHOSCxlyklAKf1vvqwQrTkFrOqRsv6sgwoM98jzjT?=
 =?us-ascii?Q?D9V6jJMOksATFg0pjP+auDfUw2sLAmjjwAY4HF2+rqAC1CIvqZHxqW+2I03y?=
 =?us-ascii?Q?0rea1cuKdRnc3dMyQvJvtOpueI7uoxoOuK8dvtk1vbE5sklpwp2Oqf8pfZN4?=
 =?us-ascii?Q?PGq+/w++PLid29pN7Hin38jFqTruDDJtMXAAUuusP8YsExUIJw5hZJMxRrhg?=
 =?us-ascii?Q?KngTca7kNYfs4bXI2lPLDZAJYifmMmhu8G+UrVl/8gjCzcJszOVBb2oIhgtJ?=
 =?us-ascii?Q?NUmffIxtQVstETRm83i5Qgbgd+qp7wOkQc0iYoXQOvvtHK42cHr2n9zIJAEf?=
 =?us-ascii?Q?CtVG0faMfwGJS98OGuuxyHGYhkxGprxl5QsTKuCz4lvVXjjOApxPDTJXEYW9?=
 =?us-ascii?Q?yDczInVaAULRA/GLKXjU9PsuvaHcWhvNF8rYXBLNPgIsy5GIrpanO9kTHsCc?=
 =?us-ascii?Q?n7zvOAoNPLyyxQNvsR1Jqh5VQ1eFUeodNJrY5NnlqRrmoChwo0nOJlkCel5M?=
 =?us-ascii?Q?Qke66SZ5+H5N8KW5at9h4gYjJhDPmaIDJ2ZDpWHyuDSUfGtlnrXir3acHyUy?=
 =?us-ascii?Q?GnYrjl7rKuZMVs353EfD2/AXcJQgDpSDB8nB93UXjlHZRbPpd7GR3R016hkj?=
 =?us-ascii?Q?07rZfuEoI9v2xlNzl4weuXajdt1gH6L9JW7e7zv+4crc5fGJUzwYvp5V7RHg?=
 =?us-ascii?Q?srew6b7VV8UfuJBi1yku3ECwi0B1sazZ2s69QCITEkfheHVUUV6O/iqXc3Lf?=
 =?us-ascii?Q?Vnag1rj46bnT+oUey5mvc0qvuIFsHGtD1nUPGP3XNGHv3CZWfShnHG4yALmY?=
 =?us-ascii?Q?61JwETGs8qOLUw6sNeJp6tjG/RPomLCpZgVmtXp45fk0Dszy6qFOeiGWGOJM?=
 =?us-ascii?Q?o4RZ/sgNPEru+QP3mwpkHly6iIBRYeauAOt84oy1kHsQDLXmLYUK8MlPggHC?=
 =?us-ascii?Q?0bnoZY3/Gt+V1/3ij6RVVaagMbUrRME8AWauxpnlv8r57lgs6q4uX+t31UhE?=
 =?us-ascii?Q?STNQT2eLbn5NYOIuZyEWshdlkOsqEMupadrjM5OU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b73a5b2-c320-4c07-9105-08dc26a60484
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:56:06.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcGq5jl7zRao+kxbVOpKTUZJ83dP9X74kP7Blqa59xEb7yrD4EI4gL9A6jKytm50OI7B86KsqYsqlgNbtvvdNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Fabio M. De Francesco wrote:
> > > > Add cond_guard() macro to conditional guards.
> > > > 
> > > > cond_guard() is a guard to be used with the conditional variants of locks,
> > > > like down_read_trylock() or mutex_lock_interruptible().
> > > > 
> > > > It takes a statement (or more statements in a block) that is passed to its
> > > > second argument. That statement (or block) is executed if waiting for a
> > > > lock is interrupted or if a _trylock() fails in case of contention.
> > > > 
> > > > Usage example:
> > > > 
> > > > 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > > > 
> > > > Consistently with the other guards, locks are unlocked at the exit of the
> > > > scope where cond_guard() is called.
> > > > 
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> > > > ---
> > > >  include/linux/cleanup.h | 14 ++++++++++++++
> > > >  1 file changed, 14 insertions(+)
> > > > 
> > > > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > > > index c2d09bc4f976..88af56600325 100644
> > > > --- a/include/linux/cleanup.h
> > > > +++ b/include/linux/cleanup.h
> > > > @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > > >   *	an anonymous instance of the (guard) class, not recommended for
> > > >   *	conditional locks.
> > > >   *
> > > > + * cond_guard(name, fail, args...):
> > > > + *	a guard to be used with the conditional variants of locks, like
> > > > + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> > > > + *	statements that are executed when waiting for a lock is interrupted or
> > > > + *	when a _trylock() fails in case of contention.
> > > > + *
> > > > + *	Example:
> > > > + *
> > > > + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > > 
> > > That _fail argument likely needs to be a statement expression for the
> > > multi-statement case.
> > 
> > You mean ({ ... }) as discussed here?
> > 
> > https://lore.kernel.org/all/65c1578c76def_37447929456@iweiny-mobl.notmuch/
> 
> Yes.
> 
> > > > + *
> > > >   * scoped_guard (name, args...) { }:
> > > >   *	similar to CLASS(name, scope)(args), except the variable (with the
> > > >   *	explicit name 'scope') is declard in a for-loop such that its scope is
> > > > @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > > >  
> > > >  #define __guard_ptr(_name) class_##_name##_lock_ptr
> > > >  
> > > > +#define cond_guard(_name, _fail, args...) \
> > > > +	CLASS(_name, scope)(args); \
> > > > +	if (!__guard_ptr(_name)(&scope)) _fail
> > > 
> > > No, as I stated before this is broken for usages of:
> > > 
> > >     if () cond_guard() else if ()
> > > 
> > > The 'else' in the definition is critical, this builds for me (untested):
> > 
> > I did not test Fabios work directly but I don't understand this example.
> > It seems like your suggestion does nothing useful.  The cond_guard()
> > becomes a single statement like...
> > 
> > 	if ()
> > 		cond_guard();
> > 	else ...
> > 
> > ... And can't protect anything.
> 
> A sequence to acquire and drop a lock is sometimes a barrier semantic.
> Is it typical, no, is it possible, yes. I otherwise do not understand
> the need to include the subtle side effect.

I was not trying to include a subtle side effect.  I was thinking that the
else block would be the only block covered by the lock.  I've looked at
the preprocessor output again and I now see what you are saying.  Also I
see I was thinking incorrectly.  The else will be an empty statement and
the rest of the outer block will be covered by the lock...

Sorry for not seeing this before.

> > cond_guard() as defined, the ';' must be used as part of cond_guard() and
> > should complete the internal macro 'if' statement.
> > 
> > I think this would work:
> > 
> > 	if () {
> > 		cond_guard();
> > 		... do locked stuff ...
> > 	} else ...
> > 
> > > 
> > > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > > index 88af56600325..665407498781 100644
> > > --- a/include/linux/cleanup.h
> > > +++ b/include/linux/cleanup.h
> > > @@ -142,7 +142,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > >   *
> > >   *	Example:
> > >   *
> > > - *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > > + *		cond_guard(rwsem_read_try, ({ printk(...); return 0; }), &semaphore);
> > >   *
> > >   * scoped_guard (name, args...) { }:
> > >   *	similar to CLASS(name, scope)(args), except the variable (with the
> > > @@ -177,7 +177,8 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > >  
> > >  #define cond_guard(_name, _fail, args...) \
> > >  	CLASS(_name, scope)(args); \
> > > -	if (!__guard_ptr(_name)(&scope)) _fail
> > > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> > 
> > Building on what I found for scoped_cond_guard() this should be
> > 
> > > +	if (!__guard_ptr(_name)(&scope)) { _fail; }
> 
> That's still a dangling if () statement.
> 
> > 
> > And drop the else.  The else needs to clearly be part of an outside if in
> > your example.
> 
> Please just rely on a statement-expression for the odd multi-statement _fail
> use case and include the else in the definition to remove any room for
> confusion.

Yea ok I see it now,
Ira

