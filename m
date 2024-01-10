Return-Path: <linux-kernel+bounces-22390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2B829D11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28857289EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D804BA8C;
	Wed, 10 Jan 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnbnq+bB"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264584BA85
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704898824; x=1736434824;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=c2AgaMatOxLHJf1ASW3MyqqDyg91U9I7FbcR4IdEJyM=;
  b=lnbnq+bBLMbqzUDk6z/R97km6QvvHS6kQC7Xi0HY2F/IToUdxcu25A+t
   OumloP2/MmpsS3K0fjefDIHduEqpt0BQvkw83qRoTKS5SO5TCyeUncTht
   aWf3Jgby/4vsES3UCjVNnMni7ghv0+EbHSs+xwCnZZ9lQnB9LtnOw0q3w
   +ZvC85hGRAdrpkjYsQknGoriRL/yJFXROEjcW+pk433kZQgmEIOugAUDX
   cQt2kIZievqeu5sa9QSV+QBurVpQWwfm0LygWnJUoPkTcnzAVdVnPHxtp
   oAX3EGxZQBPXjqu4FepRGCRev573dK7tViAtRfFk+/j89mdYThxko7/l2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="388981289"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="388981289"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 07:00:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="816373051"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="816373051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 07:00:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:00:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 07:00:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 07:00:10 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 07:00:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvYSRXaXS+TshOykgfFZgis+XjC0ptuXhsrBqs3cN3U0vMm7FMKoiELQbVnnw8XRl2GwFFmqKn97ieC/k1qwSrbbtj2EjTtTel9ixoBCMHu/ghg0pVTu19me9st/Ig7MC6h4jnbVLQ4BRUCttBc9SGeQFJUl4JvDcHlkPL1DwakrTdb7whiNEAcLdabD47PUlVCSoGsD4Mj3KqBw+ygb662kOthfKigb0ysHaUsAG8Qu+bgvJ/6xhkql9lroRtIPiO+veBslekWZX4mtN3O2oaN7HSX3P/NAyy429wOqkESu3W+GaM4cFk2sJMG9br19DYPh79zYKjH9oCv1yMk0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT7ENK8U+wzfarw8DP2I6NGhuo+B1Woyd0bzZN3D8sw=;
 b=agmDdRODzFaLabRIQeUR01VYIBN9Ul5hXwkKFUNXNplcwjH1zHDCkLIfQnrt4eDsw1arnOlyFgq3VdUDzJ7YfxQpHlfvyxqh0UYWg46MyZLz9tjtuLaMtEOM1gZpw5C7XcmmPAlbSKXB2I+Sv6UDhKxH7MmDvVZtTEtVdJu38zszkB+525bpgHwSCr6il44f+2La70VsYXUN58zjBkVnTByuVJ/Nc14f8EeBsQhCebfUBjiBt5qyoRjoR389hYPBoYpfMtGqwROia6cbFJbagPfOIfGSefhFznIYf0jSHoLfUZcZHMwEH7pQjGMx6ubbUSSc5grB4/+GcLs/oHTfDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6652.namprd11.prod.outlook.com (2603:10b6:510:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 15:00:08 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:00:08 +0000
Date: Wed, 10 Jan 2024 09:00:06 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <6r2zjqbs2g3hkt3uhnglwpboalwck5ye34b6gxzmhe4gae77g7@3bzqt4s7i2qb>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
 <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
 <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
 <20240110081155.48bb0cbd@oak>
 <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
 <20240110095822.3ba3d979@canb.auug.org.au>
 <3d14049c-d44c-4b33-9933-0f96055b8a70@paulmck-laptop>
 <20240110160335.2bad7d54@oak>
 <3a10ef2b-acbe-4d80-805a-e947e15e5db3@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a10ef2b-acbe-4d80-805a-e947e15e5db3@paulmck-laptop>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3418eff1-6a70-4b0b-9003-08dc11ecd62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7V12Qs0DRrOQfzK77m339utflhiQfUlT17Zb7gENKLgeiZuryrlua/o/6Qhb+NpXFsKst7nku4oSZssSNcfoqltgzVJWhBeBDujXmPwsaJSmnphtVZAYOpHYhlKH4f1NsfwgnylSrujQYCitMo2uKbrqzHZmMw7gvHX391EP8JI/atXtMfSOW+2G0i9m0AGh7rBXGv2pybQu3+YH9YBMdwlZYowrbiQ0qTM8V0KYgaQ+cx07NUxD0isQYwN0JUpyA2sU1ecNTv47PHlNWCUMYgE2XvMz9U+VJBJZ9dX1Ic6jesKMbR1XmnTkrBS3waM/GITCzhv8hdXhMZT0kHJd6a5ZtQCdBFCQ0/EGS06EHS/VAtkzzqUbCzrjhAeSMT1D/dTPG7vQQDgoCRGc7QkJt8s2mlm4pJA+Q95dggqujQAffMELuJpClkzuC/VVkeiDN1TQEHCmsxCPp+xuU1XB8uDeKKSkzRxKHeAV9pCpKtyURSeyyfmiODm2/FIPGzI07O6Rpt5rUh0GhXSifrIy0aGvRgTdQcmkqFeI7szOBnG/DdDS8hPNPQvFHVDfXxvn5BT/33PgaeLoWC37cYrXRCbhfP6LVRmAW9botTndSTvD8eyt+HGvszNUoWI+HQnr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(2906002)(5660300002)(478600001)(4326008)(6916009)(66476007)(41300700001)(8936002)(66556008)(54906003)(8676002)(316002)(66946007)(6486002)(86362001)(33716001)(6512007)(9686003)(6506007)(83380400001)(26005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtsY2UzRG1yT1p4VHdJOVdiRmtvaDNYS1RCVmIyRUtubGZxSmNsUlgzVnJo?=
 =?utf-8?B?d280aHJ4OFhWb3RDbGdpQktQS3pXbFRuQlpSRXZOSFBJYk1nY2hwdEp6ZTBn?=
 =?utf-8?B?cTA3MEx4VTFuK0hFQVpsUTU1aVlVSjdIcGNtenlmN0g0Y1VSQmFQeEw0VTNX?=
 =?utf-8?B?SDhSV2NKMFgyeXZCb1F3VEZxelVvcHNVclhsbXBlV0Jlb0hYT1JOa1dWL2x0?=
 =?utf-8?B?MWFVODhzYldDY3pPdjRIWE1XdW05SXE0aWpRZlAxNE5ibm95WEpLVTFiY1NX?=
 =?utf-8?B?bGhkcEZhQ3drZ1VsaURRSFE4R3R3Q2ExTENmNDlVdmxYbGdjdHRmMjhlWjNQ?=
 =?utf-8?B?Y1VEbGM3OXdNRnYxanFNUGxQMW5vU3VVcjlGdVpselRsVlB5Tkh0a3NhMS9U?=
 =?utf-8?B?YWJpeVlzSnZzZW8yNUcxTDlRbkdVUVVmY0dnODJKRFMxMkNzc1pxUHRiV3JX?=
 =?utf-8?B?bW5XMktYQVN5aVJTSEhWdXMrcytzTE9pbnpmbytYcWF0YmhBUmVnMXVxaHRH?=
 =?utf-8?B?WG4rNUNJNWlMaUwzZm9SV2pzZHl4VWdsTGtKRTBPcyt6Qjl3T21JRnpJOFdN?=
 =?utf-8?B?UkdUYjNqYlY4bUdrcVlMZGgvQ2x1OXJDdyszQ0JydTFEOVk3WDlzYnFhbjJX?=
 =?utf-8?B?Z0FrajlIQkN3OFYvQVBwS09wVHRPT1NaNVlySElRQ2ZZWkJnSjVwcTQ4bGEx?=
 =?utf-8?B?eTdTSDM0WGJyUmp5RmZ1d1VHMnFwbitzd1BIQ1BsalhOM2w0b2dvckRJM080?=
 =?utf-8?B?VjRNdkpEVlVsUDg2TW5OSkIwLzdRTEpYWUNPb3ZEc3NDdDVGdlk3Y0tVcGRX?=
 =?utf-8?B?Ky9CMWZ1U3JEdlEycnhXZkFBMkhtaWQ3TU5QSzl0Q2JPdjg1amZDWS9BaHZm?=
 =?utf-8?B?VWVLNExyQ29nTjdiVXNuWHZkWFFpUzkzOW9IbFhRN2dLb0I4OVpYaWtJU3hn?=
 =?utf-8?B?SVc0K0prZGZDd3RIbnJ1N205TDQ1SnNRSHd4ZVMyWjhvZ1JuNzZXMXJiOXdi?=
 =?utf-8?B?d0lEUUdQRXZ4cFR2REJQY1hJNzlaaEk3MERzaHp1OWdvUExtUUtwYXAxcWJj?=
 =?utf-8?B?TWJ5b0RPMW05RmUrQktUZ0lZckNId3ZUY0txWVRsOW9iQk9KbXVwUHJQb3Ux?=
 =?utf-8?B?RlplQTk2SHM3eTU3dUFpbjVLSkdya1J6dXRuZU5nbGxlanQ0ZndqYWd0OXhm?=
 =?utf-8?B?L1hMaTdpdHo1YlAvSkh0TmNhSjdLRXh0bWdXdTNVQ3VXWm5pQ1ZZaTVmcEdn?=
 =?utf-8?B?L1ZTeUN4Ymdybnc2cW1XTWE5UUo2bUxrMkxuUGNWREtyVGpyZHFncFVHcU1P?=
 =?utf-8?B?TFlGbDVSTHkydkRGQmRSa0RDa0NjZ2lUd00rdEpuRnlIMXBJeFFxNXVVb2tH?=
 =?utf-8?B?WEZ4V3NCeHBtS2c2OGNYVGZ3WE9NcnBvNStjSi9nWFIvTDI4ZkdHdys5eGVl?=
 =?utf-8?B?L3F0bFlUbXJhbklJaTMzcVFJZmx3VG5YQURDSmc4SjV2Qmw5RHdOSXliQXY2?=
 =?utf-8?B?WCtBMEt6TU1uRVRHV3lrR05NUmptM2JBQXVpSndjMzhhdGUzRDkyZ2VLR0Zu?=
 =?utf-8?B?U3UzVHdteVdSdTdQeVhtb2RYN2doMDRxblZuUExMaFh6WFJtM3FmeFdRUEUr?=
 =?utf-8?B?Y2ZJSHlSR0l6WGJXWDVvbnFnemhyTmFrSHgyNDZzVk9KM2J4bmpxTDcyR2Nr?=
 =?utf-8?B?dzBkRGVNWTVaR0FwbFlUWnpEQ0hTbnNodEJDZ1JBWGc2emlOaFRrTUJDN1JW?=
 =?utf-8?B?MVRpalBid2ZuUWVFN2tKL01vMEdYeFZJcUtoVlY4NGdOeUJzN2E1VE1FaUo2?=
 =?utf-8?B?OW5PSkw1cTBwM01xaGVkQkUyUWVQKzZLQkpFZm5CRjJ1dXZzMGczTldvbjMy?=
 =?utf-8?B?ZEQrSFh0Y0JRbU5hdkxXeFcyMExYdktqZFltMnV5NGcrRGl0Z29pZFRPMDhu?=
 =?utf-8?B?bHVMSG5SVUlWKytPWCtTSk8rSVB0elAxMjFoMkVCOG5oZGY5SnlvV1h1SXVE?=
 =?utf-8?B?dlc4YVdKcXZVUEpPaEZPaTU4aGdzY0ZmSkhrZnVPZDdHa042emxkQ1dSVnpX?=
 =?utf-8?B?SkcrdGtMMFIrbXZ2dXlnTmVZZVYzUjJnT2t4dlIydlFJTzZxYXVXZUxWOWJP?=
 =?utf-8?B?MnVZekJyTlRHY01YYW9kdXBYazEzUEljYTQ4akJxS0xETnFQeTVRSS9GM0xo?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3418eff1-6a70-4b0b-9003-08dc11ecd62e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:00:08.6516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSQjrQMnlr4YNuMpwU/3LEu1wf7iFrlTP59NIo2Ul62QUKbV5ZB+E63cZJx0bySa5rpEkCUXMeE9xDnSIm4I5qJAo+h2lKqd5v3xhkzZqJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6652
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 02:26:54AM -0800, Paul E. McKenney wrote:
>On Wed, Jan 10, 2024 at 04:03:51PM +1100, Stephen Rothwell wrote:
>> Hi Paul,
>>
>> On Tue, 9 Jan 2024 19:46:27 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> >
>> > On Wed, Jan 10, 2024 at 09:58:22AM +1100, Stephen Rothwell wrote:
>> > >
>> > > Maybe that line "subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)"
>> > > should just be removed as the setting of that option has been moved to the
>> > > normal C flags in the top level Makefile (out of Makefile.extrawarn).
>> >
>> > If you meant like this, no joy.  :-(
>>
>> Actually I meant the one in drivers/gpu/drm/xe/Makefile
>
>Like this?  That does work as shown below, thank you!
>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>drm/xe: Fix build bug for GCC 11
>
>Building drivers/gpu/drm/xe/xe_gt_pagefault.c with GCC 11 results
>in the following build errors:
>
>./include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of size 0 [-Werror=stringop-overflow=]
>   57 | #define __underlying_memcpy     __builtin_memcpy
>      |                                 ^
>./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
>  644 |         __underlying_##op(p, q, __fortify_size);                        \
>      |         ^~~~~~~~~~~~~
>./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>  689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>      |                          ^~~~~~~~~~~~~~~~~~~~
>drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro ‘memcpy’
>  340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
>      |                 ^~~~~~
>In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
>                 from drivers/gpu/drm/xe/xe_vm_types.h:16,
>                 from drivers/gpu/drm/xe/xe_bo.h:13,
>                 from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
>drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object ‘tile’ of size 8
>  102 |         struct xe_tile *tile;
>      |                         ^~~~
>
>Fix these by removing -Wstringop-overflow from drm/xe builds.
>
>Suggested-by: Stephen Rothwell <sfr@rothwell.id.au>
>Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

[ This particular warning is broken on GCC11. In future changes it will
   be moved to the normal C flags in the top level Makefile (out of
   Makefile.extrawarn), but accounting for the compiler support. Just
   remove it out of xe's forced extra warnings for now ]
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

would you mind if I extend it to drivers/gpu/drm/i915/Makefile
in the same commit or would you prefer a separate one?


Lucas De Marchi

>
>diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
>index 53bd2a8ba1ae..efcf0ab7a1a6 100644
>--- a/drivers/gpu/drm/xe/Makefile
>+++ b/drivers/gpu/drm/xe/Makefile
>@@ -17,7 +17,6 @@ subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
> subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
> subdir-ccflags-y += $(call cc-option, -Wformat-overflow)
> subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
>-subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)
> subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
> # The following turn off the warnings enabled by -Wextra
> ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)

