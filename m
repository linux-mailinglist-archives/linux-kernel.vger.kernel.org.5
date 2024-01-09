Return-Path: <linux-kernel+bounces-21138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7F828A91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA42843AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98F3A8DB;
	Tue,  9 Jan 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eq/QDNlm"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED753A1D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704819526; x=1736355526;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Re4qdDKlYZ1CnGJdzH05SRJeU18BsOJeOFyua+ZqBQk=;
  b=Eq/QDNlmFroZXTTP+d8I+82o6gGmYI0KnUWa41zvHRLLIY/8uX7ZTTuz
   V81mAX2noB4QJG2GPuPiWxkNyhuv2nS9nfIDr88q6WTUvat5GH6Ba31Tb
   vxPvGNc4Xun0X6JvPUShXaeqsvN7TdM99WgIBpjRlaO+8zyZzBINC7yWX
   3B+9O4DokFjnQbe6NF2toDps+ish3IYBMaZLmm8kymmuQb6YKv2CA5TkZ
   q7eZxUPEwzxjtEN7WvURX2Vs4otox69Y5ienB+M+bg5qNB+C9spC0EgwS
   Xsz0tmqK+hqR1kY13eR6jzOY04dQp3hi2crcm29f5fNqjY/NWn42UKYSe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397955371"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="397955371"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 08:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="816040228"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="816040228"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 08:58:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 08:58:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 08:58:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 08:58:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FImqcHil4mgeWxQP8foEu0SHcGVEs4v53BTaOzidnHIf6K4ACnSz1p+sx5wdQC3xzDyUhbYjJRifcR3iFwuuXrKotgPP4llT7Xu5BVwyPikNmwhj6KxJUfB+DK5XNVROb5HqmvRCB/FAIDebIaSSU2X5InI5tRaB53mPQhDe7XM9V7ztoAlSYRoWkcgsKCPjsvjIAnBS9Pg4cTKyfRvJXQvv3qDG4gkp4HMpRZwuPRxPpbvDPHg+MNfckc75Xy4w0GF8etyAPeP0Jk0v1PIEorDJHUjfUJW55jZIjAKTzxyRxbGWnDV76ffUxDUZe1S7i/De3vvs2PNNJdDAmHMubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2cVDHZrSgQNwk8G2YoZ80DIX+avNR9437/XiWXC5TY=;
 b=NMDNYQGMitJjOGRbEYFNSoqLuy5iHixc0wea0D6QXsm9WQTeTGVQxe+87XGoJ9pQyNmIoQOrPuDyqrNuocD5WRmYopu3hN3fBBRdOiN+jbr1zPjRb5WT2F62PwSvlORrdFeE+QeMqYFZ06r29ZM35tXEvJpsfzwb6SQLRze6G8Qz9HLVT8Jg3OY9SmQJ9TH/O/9HMwPeU1gXKqkCgG8PPtvz6hD6wW45i+7UGsC0/qbbiaiA23t99fbFz3HQKp8ttVg7JPt9mJJCwGshweCa280iOIRLB4DQQhxg7TTJAgqhhgDvBK7UrG+9DJebwZN0ogUVlg0yPqGuwfouHgL04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6955.namprd11.prod.outlook.com (2603:10b6:510:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Tue, 9 Jan
 2024 16:58:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 16:58:42 +0000
Date: Tue, 9 Jan 2024 10:58:40 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, <lucas.dimarchi@intel.com>,
	<linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
 <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
X-ClientProxiedBy: BYAPR01CA0023.prod.exchangelabs.com (2603:10b6:a02:80::36)
 To CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: f43dcb76-db7f-4002-f83a-08dc11343bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lU0D7gSplSPxbi8I1gLaoPYEKRmhRg4+AdsipdoaiOhC+m3veZCiiG95e/bW7M1ax4RovMq57/d87BAA2aKjR8kXs53uLYSOea5SiYXBYd9LJyurT8wH+Rdrh4sZZepr/3Jo3xgISBmOrEVyKn0pZlavwiSgroKMhzymeOifLbkh1/plh0PMjW8KhwZ9uY7LqoJM3woiwXfl1aoJ9/Fu4dz3ERy6hasNdYTwVXtKhEs0t0B3SeJD3WSrjHjSJKxXKcxOqRHA+8NScWwGOhTeWgu02QIMbpORgINTAI11EXXy4ZjtfXHCQc/G7B7vHf/nx3TDC94+cb3FOKsp8uqaYqTjRknzAzb0oyV+47wFzbXR9FXCLyReGwqd31kjEgkOhicGWaw7t9Ciuj5W3+7qd9iZR8DPZ1tMRlQnTWzjdyewTCjhkCwtbuUL24NNsq2aHQjbXWv2X2f9R/zHJzgpyShUyv+AbB5kQLaJ5o0VixLY3sZqdvep8rzFDnC4+IRFMdBkk2Gqzy5lxPrKCiLpKxh8AufB3k1pMrcIJ1VHbVyvaIZbUcm4AUjo0IWCeOO9URNNlU5n8Ck/9uQVcNGJryfZs10NCXlp0WCuZmpFkfAS9c1zAT3VC3BjleohxcjR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(966005)(478600001)(4326008)(41300700001)(8936002)(316002)(66946007)(66556008)(66476007)(6916009)(82960400001)(38100700002)(6486002)(8676002)(6512007)(9686003)(6506007)(86362001)(33716001)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1QZGFMcDVXUEJuRVAvNVZLb09Bdno5V3ZId2tLN1YzYlVXY21RSkc4MS91?=
 =?utf-8?B?Q01makxTOE8rOFI4dDB6ZFQ1bjNteHVGM2kwcTlobDdNVmV3UkNlcTdUSkxq?=
 =?utf-8?B?NnR4UHJFbGRaMlhlanRZNndzTFVjcjI3eG5MZXdCcEdraUJrK240RzVaQWVr?=
 =?utf-8?B?UHVac25oZzdIR1VWN21hajVoTHpzWnRXb2xDay9XSVd3UnY3Z2RhRzVzVTVn?=
 =?utf-8?B?K2Z3OUtlZG8yVFNZZ2RhVkdtenVVUGxIdG5OOGlLK1duOFI4MnpFZnBBd3Zm?=
 =?utf-8?B?SkhBTVhxeHM1RlhodlVkVVlZT2VkWkYvOEhSQ1ZYcm5ZQkVveGl5Y2gwZkho?=
 =?utf-8?B?SWZVRnUyQmFMbW9Xams4Qm5qa0dFNVlFMHFMMU9OeGNIMEdXQWd6QkpYYlY1?=
 =?utf-8?B?UGpsMFNnTXI1QVlBazVzTkhOWjZ3Z0hxNVl6eXBPa3pVM0dLKys0MGI3NEQz?=
 =?utf-8?B?bHVjTGVtQ1JQdTBkbXdqSEd0OHg3RU1MOGJ1WkF3T1JQczZtMGZWbFFkK0FX?=
 =?utf-8?B?R3Rkd2J3V2lPTzdwNHF1eUoxVWt3NXpERWdURnFrTEdVTXlrdnFSRmVoMytR?=
 =?utf-8?B?UTY1TUx1aGIxNS90bEtXejRVc1pGRlFjSFJYV0E5ODJMbmNXcmtrVjJGclRZ?=
 =?utf-8?B?U0pidytZUzlBZTA2OW0vTVh1ZWcrNGRNTGJ0OWdidW56YzFNcm8wNUNMdmtw?=
 =?utf-8?B?RXo1OUtUSmxRajVMVkl6U0hmV2kvalltZUdWNnFrNGFPYkZIMnFscE91Uk44?=
 =?utf-8?B?TmtXakFPbzExZ1Q4QkdXd3JPLzFxOUJsdUx6ekZYOXR5L05NM3l4WDB6My91?=
 =?utf-8?B?K1d0TDcxSjl3Zk9tRGRoTVNmcFV6Q1Z5bE9jVk9HVnJBekxCS0tDNnBCU05o?=
 =?utf-8?B?NzBHV0FRSXBuUVp4Y2l5dDVuOGxVdERLOE1sRXRySXBVS1U2eHZSNnE2RU95?=
 =?utf-8?B?bG52c3JOL29EdGhoM3MyNmVWNlU0bFdEQlpxVWFnRHR0c2Vmajh6NFhVZzN6?=
 =?utf-8?B?M0o5WTRjWkw3MEVaSjV4N25ycjdXRXdpOUM4RyswdXhHU25WYkw3TGhtNkZU?=
 =?utf-8?B?ckIrcURudjZpWG5XWkFTYU5CRU44THd0K0FPYVZ4bFNqVFcvdUg0UEM5enZ3?=
 =?utf-8?B?aWJ0NkkvUU9uV3htY3o4WEhFY1FkY2d3Q0w0WGxSVTE3YXhKdnJQMjdubTc2?=
 =?utf-8?B?OW5taDV4UXE4UklKVlpMeUFRY2gvTFhBamdKRWN3NDJvTUJMZElUelB4SVVZ?=
 =?utf-8?B?ZDJtKzQrZzZXYWdUdDZ1Y0p1eVFneTR5UUZTaUx2cml3Y0JZTDJBWWs4S2tW?=
 =?utf-8?B?WjJOMDM1c3VNZ3I4MTRPcnlFMzA1a1BHVnJPNUVYMi9xeW9LeVdPT1VrVjg2?=
 =?utf-8?B?Y0l0eUsxcWVRM0R4aWczVktFdnVIdzRFTU52K24yZ3UrZHdGN1BIdVFsZkY2?=
 =?utf-8?B?Tm15emY1ajJkVk9ORC9ZdUpaNFRUcFQ0M2VrYWUzRkM5RzZsQWJNU3JSZi9M?=
 =?utf-8?B?VmtwZmQ1YUk5YndlWW9xZnlrWUczOXRtVnRZZEd2NkxXOGZvbk9xdEpuSysw?=
 =?utf-8?B?SjZWVGlGcmNLR1loeXZ5aWVTMXFvNkxRMnZweEtqdHBWTEJFOFZVbHFrUUhs?=
 =?utf-8?B?ME9qR1FjUkh1UnRxc0lvSGhWeEplQjl0ditNd2VqQ0MvWDhmZC83Tmt5MVdS?=
 =?utf-8?B?cFR3bitUVGxBSFpTY2o4OWxlcG4ramJFa2dXQWU1MnhUZUwwR0NzZllwVG5P?=
 =?utf-8?B?bnVNU0RIK29tbXl6TXQyZzh2SXJMbVhWWUhJdkZCUU0vWU02Y2NUVkh5cTQ2?=
 =?utf-8?B?UTZ6eDA1YzlpRTU3T2NjZ0dUOURDMkpmV2RRdzlZREZkRnFsSzhNZnZlQWJy?=
 =?utf-8?B?SXN4Y2tsZEJOREpibnRDanFyeG1zaE9aSHcyQ2R6S2VzYTI1bDh2dVE0Si9E?=
 =?utf-8?B?QlBORzQ0U29Xais1WWplNkl5M0NBZzlZRjZlcEM1VlZRUDUwVmtGcURiS2NL?=
 =?utf-8?B?L1dmNWljTkJQeFhsSVlXUDlxa3Z5NkYxR3RGS3huL2pJekNJejdNUzR1b05C?=
 =?utf-8?B?ZER0cFRpS09tbnVYc0dyYlE5WG80ekNUeEFqOWRWYXJTZ3BOMXBETjJtZFI5?=
 =?utf-8?B?L1loUng4QytLQmR5N1lNaXd0WmhRK1l0SVIxZ2FQMjlJWUtVUXF2ckpkU3Iy?=
 =?utf-8?B?enc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f43dcb76-db7f-4002-f83a-08dc11343bfa
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 16:58:42.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX04c32ZoLG+QhNpk853gRcHAiEV/EqzL9eGqHE3L881QM51T/8oTwOWu2QLluvFXDph5qIzJ2RkKjrlhV+tA9dSNr0I1o/G1X5m1uxmDJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6955
X-OriginatorOrg: intel.com

On Mon, Jan 08, 2024 at 03:15:23PM -0800, Paul E. McKenney wrote:
>On Tue, Jan 09, 2024 at 09:57:57AM +1100, Stephen Rothwell wrote:
>> Hi Paul,
>>
>> On Mon, 8 Jan 2024 13:33:36 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> >
>> > Recent -next trees get the following build error for allmodconfig builds:
>> >
>> > ------------------------------------------------------------------------
>> >
>> > drivers/gpu/drm/xe/xe_gt_pagefault.c: In function ‘xe_guc_pagefault_handler’:
>> > ./include/linux/fortify-string.h:57:33: error: writing 16 bytes into a region of  size 0 [-Werror=stringop-overflow=]
>> >    57 | #define __underlying_memcpy     __builtin_memcpy
>> >       |                                 ^
>> > ./include/linux/fortify-string.h:644:9: note: in expansion of macro ‘__underlying_memcpy’
>> >   644 |         __underlying_##op(p, q, __fortify_size); \
>> >       |         ^~~~~~~~~~~~~
>> > ./include/linux/fortify-string.h:689:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>> >   689 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s, \
>> >       |                          ^~~~~~~~~~~~~~~~~~~~
>> > drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of macro ‘memcpy’
>> >   340 |                 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
>> >       |                 ^~~~~~
>> > In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
>> >                  from drivers/gpu/drm/xe/xe_vm_types.h:16,
>> >                  from drivers/gpu/drm/xe/xe_bo.h:13,
>> >                  from drivers/gpu/drm/xe/xe_gt_pagefault.c:16:
>> > drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 265324] into destination object ‘tile’ of size 8
>> >   102 |         struct xe_tile *tile;
>> >       |
>>
>> Which architecture?  What compiler and version?  Anything special in your build
>> setup?  I do x86_64 allmodconfig builds all day with gcc v13.2 and I don't see
>> this failure.
>
>Good point!
>
>I am using gcc version 11.3.1 20230605 (Red Hat 11.4.1-2) on x86_64.
>I see the same behavior on gcc version 8.5.0, which for all I know might
>be too old.

I could reproduce it with allmodconfig and gcc 11.4.1 from rockylinux,
but not with gcc 9.3 or 12.3. Also it's not reproduced with gcc 11.4.1
when using defconfig + CONFIG_DRM_XE  (even if  -Wstringop-overflow is
still added).

I don't see a bug in the code, even if it inverts the head/tail
convention.

Searching around showed this which may be relevant: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101854
At least I can reproduce the same issue as in the snippet provided
(https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101854#c7) with the buggy
compiler.

So, maybe the best thing to do for now is to disable -Wstringop-overflow
for gcc < 12?


------8<-----
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 6952da8979ea..0433a3c6cbfd 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -17,7 +17,7 @@ subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
  subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
  subdir-ccflags-y += $(call cc-option, -Wformat-overflow)
  subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
-subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)
+subdir-ccflags-$(call gcc-min-version, 120000) += $(call cc-option, -Wstringop-overflow)
  subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
  # The following turn off the warnings enabled by -Wextra
  ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
------8<-----

and if we are tweaking the warnings, then do similarly in scripts/Makefile.extrawarn
so it doesn't show up again with W=1 builds. Thoughts?

Lucas De Marchi

>
>							Thanx, Paul

