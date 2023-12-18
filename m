Return-Path: <linux-kernel+bounces-3516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B2816D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F151C2348C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3111A72F;
	Mon, 18 Dec 2023 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FAqWeajB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0751A5B9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702900678; x=1734436678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lFdi1AGynYF0Hu2aa5q+BRjdk1RkCEJLGTo5LdYQ3c8=;
  b=FAqWeajB8xCK88+0V+2inDryl9HiYiX+Lord/BUw0JyiUlM/Lp2Dnh0S
   +0ZjultBPopNkpypMx4ISDSF+i1gbadV3SXK/l/W0mzdTWq+6qCguIAxn
   HiYTLUSsybzjDIaPUvy6xNYvIDK9pQHnUzu7EJQFBjzg+wjhsohVoAzKS
   gO6KUex8Qwbsg8HgaVZodiyRIQ/F3lFEVclhPSDdGw/wmhXXahFjchwEO
   EVV91qTnunTpztdtCKhv/KEiI+XDNhQuFr8FmzfJ3HsqusqYPgP7aav9/
   c7q4D1RPhthnEezEC9Zbmcuz+TBMSEpd+9qKO2dkebVa2uW5RBikwbrRS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="385919061"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="385919061"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 03:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768817978"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="768817978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2023 03:57:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Dec 2023 03:57:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Dec 2023 03:57:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Dec 2023 03:57:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOB0bsOeMztYGySFF9qp8zssVSxQgZh6PpFOszOxnR4lm/jERWX4BeV+cnMK79OT3PJafaV/8vhZKyMxqIIfXloYDVdNTg2CGxWW5n9wTarxmHp4cN1KHH2hdRsX0xKj8F/Ff8MF9C+wsbxQHs9hiKbZ8O0eb4nlvTtn6DxEs32updbIwS8eJdOMco5bvnCaYIWaNexgwiofvYFLrf656Y9Mqoyw6BhMj9GvJTe55piWmCGDbMq+MAwsacd5s5VRFrdmgeNY8zf/cwcnArqd9MJyfPo6wKwxNLz4a1yAd46FBTKUhsvp7F+N94t9LCirvXhiIOYJSCZh0UG5EXFlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/DhcqhbQwKxsdA4ZO0kBPiTwjcBjNRy+m4c6tDS8Fo=;
 b=btBo+VyZX4H+3gzUw83+AmF0Rkk2XA6eRaQ1VXJIEEloJwHOdCmJ9qcxJRIa+POhoash+IKsjBxsYvFWwfp62izPNf4UzfA/iR4dyMbIXBmLVjsEgi9Pb3+EUJ1HV8KFG2URb4f/ioBiROLi335I+ygbcy528oNFVLNKq45Ivvau88KkZzzQ7fhCw3boWFrVBehYKswJHYQlRwcKIy+dOsp/dYdLIDIHajyCzKNnwdyX77UWcmt+3PCdMg+/jca2ozfYlu/MSofVL+WD0SXeLM/dlhVcJ5I+LnRKUpc9vd5NwhMAJmhBXOrt3wOsq06/EcCLJTPEPjqrZ+TmTDo4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA3PR11MB7488.namprd11.prod.outlook.com (2603:10b6:806:313::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:57:55 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:57:55 +0000
Message-ID: <16028dde-261a-4403-8165-f0a8b70f13fa@intel.com>
Date: Mon, 18 Dec 2023 17:27:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/setup: remove duplicated including
Content-Language: en-US
To: Wang Jinchao <wangjinchao@xfusion.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>
References: <202312151755+0800-wangjinchao@xfusion.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <202312151755+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA3PR11MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: a4486f59-820f-4d7b-3859-08dbffc091ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBPmse5JcM+sFf0B/VBiRLNqNgZNn3zGTnup6q0GscHcWoXxPQKFxg0GzIshz4CCRIGxnNOYebpvrK9KfP8H+PJMF6v5h0TEbfz5Fu/kG/7GwayUewSQJFv5YEZbtwlyyCu6bsfOWFzcErVdO6sg4j2bKEOOYNXSUxkaO40DA6UhZkGowRZ4Er4lrBYXkWr+BPSD9Bd5lfTPR8y2U7Ys7ANrEjCFztQgG3RbNlNr1MGpwNcFYBH/FdGI3MJIcqpyjbucFENnFYMLdbU3s0aveP1AW6xkyVKqZJ9A9XGEDaCChKP+KqwF67YnbXEVyk/Dah0uA+tQUMJgHtd5x07jWqecSmWRBzxZbnP5yVeS8vY5Hxs702bQrDQgpxn1tdAuh+tcEFCXlWWFyYNwhgQiJTixJoCsXBZITJwVZeoaHZl8RGt/HPyy+y22QZreFyhtlQk19NiS+N2uZiT/ADqkJ0TQNuOXNdr5REoZHKPs+hVl6QY6aZuFYDn16Sla9h9s9xA7O+09t/VRUjuJ1l7qCItOcD81F3bLjSAyWPLppu+Tum3Ouci7328UMMawuaAqwZo9yIn3nBjzQ26vHROd7jfOGOGCMN4jhunq3DqBB4fnoalyypP38OQhj4SoEweQSEmgfAXBLXSLHkXFQlAwvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(36756003)(316002)(83380400001)(66946007)(110136005)(66476007)(66556008)(2906002)(38100700002)(4326008)(8676002)(8936002)(5660300002)(44832011)(53546011)(6506007)(6512007)(6666004)(26005)(31686004)(478600001)(6486002)(2616005)(31696002)(86362001)(41300700001)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG85WTNDaWJra0hFTkZvUDBJTDF3Z3lMa2NiaUQyTlJyaDk0ditqYkdQRitj?=
 =?utf-8?B?azNxRjdVeE5kMkxYYytsN0hYajRMMUVPOFRHeDExMVdxNCtuOUsvOElBNVBq?=
 =?utf-8?B?M0YveTNCNVdndGNVWFh1MlNMcll2RDhrWnhETzY1VW9jajkrajBNazZKVk45?=
 =?utf-8?B?bkwrc3FJbGpTNlZSejluaGRnZFpTLzFFOUo4ME5UOFFNK01zY3ZJUjlDNHh4?=
 =?utf-8?B?MENRTVoxMEhYU0hOYS9GVjZsUGd5QWxrbGdEVTJPbFJhK2lnR3pGZmZTYkJJ?=
 =?utf-8?B?RWdPcVNOZmFLVUNOUi9Hb2JKN2RtYmVGSUQrK2grblRMd0c3Nm95WUZHcnV1?=
 =?utf-8?B?TG1oU0t0TjBueHZzK21VYXBFOGUyeVZ0Q0pSandlY0toUjk5NFA3TEdwNENx?=
 =?utf-8?B?UEpVcnFnOGl5SVEzUEhQU0tBVitucmZRa0hUUGRxdGVkZXNCWmNheWgyNnlm?=
 =?utf-8?B?Z3pEd0VFWUVPVHBmenBScURFRXVRL1R2MlpxcjI1dHNxT052ZFI5OVc0T0NQ?=
 =?utf-8?B?clhuV0V5WjIxSVdZU3Y4NGMxRjF5UkRkWjliWXFoaVB3YStlLy9XSkhFbzVy?=
 =?utf-8?B?WWw0cnk0aFhyRCtueVRvcEU2cGxwYkFjU2VMR0hhZ1NCeG91bmx1V2MxekJ6?=
 =?utf-8?B?Q3JkTjM1TENSTDR2bEtQS2pZSm8rQ2Z4aEpZWnNPS05CTFdlczdRV3AzdjJ2?=
 =?utf-8?B?cFhaUGhCbHltNUNVRDdPRnYyYVAwV2JIZFBHK2RQQVE5eVQrWkdZT1BxMzVk?=
 =?utf-8?B?aTFQYTVVL3RYeTZ6YWw5T1IwWjZ6RDBpME9UUWRvS0x5VjBJZCtNVkc2Vndi?=
 =?utf-8?B?dkRaYjVDcHQ2SStuaHlGcVc3bElPTzZobzN6cVZZaSsyaDZwMGVFUFh0Zy9Q?=
 =?utf-8?B?UldheDRJRVUvajFyMlQrVVVsY040SExydUk2NVFLdVFGNEVReUVKOEY5Qndi?=
 =?utf-8?B?MkhoU2MzNkR3VkpTR2R6ZUpnRExSM0hLNi9BQ3dmMTlWOWxjaVg2NVl2Kzlx?=
 =?utf-8?B?eUFzWTkyUDNKdVZiZmJad213RXE3c2FEaC9rSmMvSDYwY2daMStXTy83WmFH?=
 =?utf-8?B?dW0yc0hScTkyUEVHWHl2M0oyTjBpNDJWbmZOU2w4eE10VElXaXFabGdMTnVo?=
 =?utf-8?B?bkt1K2ZQRlZxdk9BZHNIMGZPWGZqRTZ3OFdxT1RoTndNWEE0RVJnMk5Jc3pi?=
 =?utf-8?B?UnlvTVlmUytlVWJtMFFKeEM0M2ZkYjU3WHcwQm9QdUM5eWd5ME94TVhiQVJO?=
 =?utf-8?B?cENDamlZNDVvUk1SdkI4UTE1cTZBd1llRmxGNWlJQlNmNGdzQ2Q2NGROOUx5?=
 =?utf-8?B?b1M2R2ExOVdscjVOaXRUbkVsM1ZGb0cyZHUrQXQ2UFN6citxMUNrL2lWMy93?=
 =?utf-8?B?SEJVbFhOZzFhZndJRm1hWWZxWk5GODFSTm1EWFZUVkU1T284MFRUak1WbFo3?=
 =?utf-8?B?KzFYQmFMdXNCa0laVkl0VXh6NGpsL0tFaXJ2M0ZEd1lBS2FkT3I0d0srVFZr?=
 =?utf-8?B?LzFyblFkL3VTQXlaMmlFY3ZVZ3NOUUNlTS9TL3EvNDVoL0pOdmEyV0FTek0x?=
 =?utf-8?B?Y2d0dS9oYWhsMjdrdmlmb1FyWjA5MUNwajhKZGRPakdEZXNlN3NVdmVxeGtH?=
 =?utf-8?B?aDQxbEdoVFVLc0lHdzh6V0xBSUNIdmJJSDVnckkxMWN6SHNpMFdXVHdoWTBm?=
 =?utf-8?B?UEhlYThrcEYrZnlGcStpbEJWMWR0eDRGVjk4TmhSY1d0Wm9Yc0FVVW5PSE1P?=
 =?utf-8?B?NTg1czRHR1FjZDVPdWJtVFVoZ0VVYy9maDZHcElkaVZiV3poSVNiMWdUNVYw?=
 =?utf-8?B?QXNzMlhLdUppZzR6MzRMZzBQQ3JSc0I1cERmeGNuWXNmd1VVSWUwQ09IZE9L?=
 =?utf-8?B?RFJVN3RMY2FyamxhYUVmSUNrc1dRZnp4R1B5V010bW5wYXZXczByeTdwbnJ5?=
 =?utf-8?B?UU9BVUp3N2hlTlFGenBFSzdkTjFSVVJ1VnZnMEZOdUxwV1NnUzd2Nm52V2dU?=
 =?utf-8?B?N3orSlRlck13YlB3V3dPbVBpZkh4RnBJMDdwYzlqc08rYWExYWlNdlBDZ01H?=
 =?utf-8?B?UjlQMi9PeVMvTW12ZWsyWFVBNzZjMnJwNFNhU3dWNjBtUStueU1wZnVRdjlh?=
 =?utf-8?Q?MvpI6xrP3DAZmU8CrEr6LHpyU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4486f59-820f-4d7b-3859-08dbffc091ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 11:57:55.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnElU85fazUfiFyXXcb9bL765cAJWNW9irVaf1SgOLX5uDO0qY9Hc5dqHPnt4k8U8OHj3wjzY4Xa/IYzyGKGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7488
X-OriginatorOrg: intel.com

How about rewording the above to?

"x86/setup: Remove duplicate header includes"

On 12/15/2023 3:25 PM, Wang Jinchao wrote:
> rm the second #include <asm/efi.h> in setup.c

> rm the second #include <asm/spec-ctrl.h> in smpboot.c

Actually, these two lines are evident from the diff itself. You can
remove both of them. If you really want to have some text in the commit
message you can probably just say:

efi.h and spec-ctrl.h are included twice. Remove the duplicate entries.

> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>  arch/x86/kernel/setup.c   | 1 -
>  arch/x86/kernel/smpboot.c | 1 -
>  2 files changed, 2 deletions(-)
> 

With the above changes, please feel free to add:

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1526747bedf2..f6152c6b139a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -37,7 +37,6 @@
>  #include <asm/bugs.h>
>  #include <asm/cacheinfo.h>
>  #include <asm/cpu.h>
> -#include <asm/efi.h>
>  #include <asm/gart.h>
>  #include <asm/hypervisor.h>
>  #include <asm/io_apic.h>
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 2cc2aa120b4b..45057860e034 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -87,7 +87,6 @@
>  #include <asm/hw_irq.h>
>  #include <asm/stackprotector.h>
>  #include <asm/sev.h>
> -#include <asm/spec-ctrl.h>
>  
>  /* representing HT siblings of each logical CPU */
>  DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);



