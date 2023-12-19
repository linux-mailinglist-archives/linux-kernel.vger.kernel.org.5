Return-Path: <linux-kernel+bounces-5056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFC8185FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349E11C239C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38A617752;
	Tue, 19 Dec 2023 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+/RZlXq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804915AE3;
	Tue, 19 Dec 2023 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702983755; x=1734519755;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kMYjrHIWX4Ib6+5xfs4RKpxKCN36DccfaWe2QHFaHb8=;
  b=a+/RZlXqDzxyDJqMhFBXTJAvvhQB4jGycYueiCWv/jVwctO1xIRDyXTq
   AmqXpGLJgJ/Q4Q4rs4+6FO5sLbp/y1eI3479Bt3D2DIFONgJBnrqb+a5u
   siWdibOaIvuikMCLbjQKvXaDfRnDI+ycR/yNt5YjyL13X6RsP2wGuTHEl
   Yt2nHVReqes7szN5wQnkxTByZUGRU6oRsyfDp2o4vVPTI+1ajZM7f7tJI
   1lGmhu6WldkxKj03EWNwmsI9Fwuj13bzlBGovC+qJ8gjaQ9PWu6z9eBNA
   D1kU4tBRK1ymamqEexk3ZiPyc9LExQ+ucm1g1SLj9WFlj7yDypkmUIeMV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="481831325"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="481831325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:02:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17566261"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 03:02:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 03:02:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 03:02:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 03:02:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV2GLqZvp1fRdBJCPFVs4lu6cLeehvwXkp8B3EyB6g0udKborY2MAyywomsPcG3y4QaqLyyZVUWaPkkcTu2/ow+wEhsw5V8ur2BTvEM+qTDHEU/ziGSuh9W++i6xTBkRyH6A7GBLyJOuF5eduRg5mIfXu0y4iJA2zAyQSdYDrbTVJXFRxwx4iLTSLxnN+AyeosbzxPjr8ZQNo9wPsXd492WEwBeXE8D+5B1xNo1XJ5hhH7uRymUSaiA6b6KYpQnL5qKwxVloVX04a+0UzYXU53B+MbwO2Erd3NZKrodlLSwj1WhRJYQ709AnJ0JI+7DjM9AEGwZ1JoLzwpgWnMpbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXwwcx4SPPXnlq5g2z06ipF3qJujCfRDprSJASgxc0E=;
 b=bKKLb3F1qolmQkvqEqiAOXsAwUcO+17Iqrhsd9Z4w3lCRvLACeSoogJhpY6GI+7t77YPz139vPcIU4Pd4Gdyc87sZMcSlbZEAXPea2d6hxp2qG/Xt2eKtbhOGVU//x5arAg/elz5RXimC1ZLNuVXInZJ5gqAqp1VLWlSpmxq1p/NP8nDyTChosKmp6m4V256CaszYeihQUzUR0MHMX2CCoo8ZnGCyTe4XL5G5GeqAQ+YXCl39uuACs1M5dyJ0Ge2iSoSYBxmEB6uI1GaLfGm4QMjyRZPgY2jTGWulJVSBZz1zXWvW2phAZ8EBlCUYkgtme9tpBfnlJvlYCKrsNN1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7903.namprd11.prod.outlook.com (2603:10b6:8:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 11:02:22 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 11:02:21 +0000
Message-ID: <4d4e488d-45d6-4496-b165-c349c67d4f11@intel.com>
Date: Tue, 19 Dec 2023 16:32:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/callthunks: Fix some potential string truncation in
 callthunks_debugfs_init()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <8c2b24df3c077e55b2a4d91a7ffd08fa48e28d0a.1702803679.git.christophe.jaillet@wanadoo.fr>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <8c2b24df3c077e55b2a4d91a7ffd08fa48e28d0a.1702803679.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::18) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ad3ead-eb1e-440f-9ba6-08dc0081f942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OJVVam95nIjKoqbEYe5WGWHIbN6p8hEY+DQxQ7Nj+lqt9y+Yi76CisWfNT1oXD5PvFm1h86Km4P8u82ccHD1UXRTY+TZvjeUaRH6qUT74MXzrS8nJ6OA+SP8TtzfYE1P3pLaSLTXJXJjiZiHOi+Y1JsYdaIslvYTP1SL6DOyw4ECbboHbdlaCZsYkHpT/eFdz1iM2luNIN+ifP19PSysKOQqbkO66LCPJxdPAPo/6zzYEYhChzCIu5+Ghu2z5Ha7LHacsexrmfoPuPhVlT+OnZgmPGa+1bUptdGP03QIH0dWA6m0yIkcSmA86MNcHppjnhEFTdz4gCbTWjNDqBgrb4ZVyMCUezLgy3Tl+MkSsP8+s3yPqlHL25kpMlX/sS0x8RX9u9xLVJFsLDU2d2/ZcI4+mYrDao693binfPLtO8NyxapPDqHESJi1yMhlvtFPcgdoKP5YT0BS7jHXqgiL0vZUR8wlNZO4I0soPibC+sIfz88CC57TzhiMYOQvif9QOmFz/Rl5UwPNyXnk0B1Pbg3xeMMxEGtcxCs2nb9LHya9Nfl+UxJvW6gIhVUI52gNh1uHKHXfeOR3unwx238OkvFlmMskL1wb8qt97IEF7yicyn/ACixTdLF60/0fp8pO947A4yX0Oia8sllECAMBHbe/WMbn4QudS9cBBl3EK8x0L9QgSE/wlWiIztURUyuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(31686004)(82960400001)(36756003)(2906002)(5660300002)(83380400001)(6666004)(6506007)(53546011)(38100700002)(26005)(6512007)(2616005)(66556008)(478600001)(66476007)(66946007)(6486002)(41300700001)(8676002)(86362001)(8936002)(110136005)(4326008)(31696002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytEMDhLRXEwZHJ2WDQ5Y1FodHVYWnJkQ0pJMG5SMWs0ZFBzNEVtTXllUVMy?=
 =?utf-8?B?b21ReTRGTnpVV25ZaXViUlp3Mi9CVXF4MG4yM3hBYUY4clNSamVieHNHa0xI?=
 =?utf-8?B?aTFtU2VRcjd2YVhKL0NFeHk5blFOczE0c2ZzNWVrbGpMR01DZW9VYS9hcnll?=
 =?utf-8?B?Qi92L2xiQktVNnBKR3o0MDZ6ZXN6V2haSk1GSzIzT2ZydlJWWUZVZ2tsWnVy?=
 =?utf-8?B?YWkyZHV4WFhhYWc3dEZFaDhUZmpUVGlMMXVVM0wvRFlsNDdCUDI4cEdsaS9i?=
 =?utf-8?B?S05qNlNwY1oybW5yUElwQmwzZUltaGg1RmNaYzl5a1d0ZWJnaFNMdFg2T284?=
 =?utf-8?B?VFZpVGxGUk1jZHFZNEx6K050KzRsQ0RONzZySEltSXpQdlBGVENtdVlvZUdH?=
 =?utf-8?B?VmZxdWs4Z05vNElvWVhzOUttSFEvWjNmUVQrZFZQdy9VbzFGSVdUNFhkSG1n?=
 =?utf-8?B?L0pMYnFkSm5nd2JTbElMUUJROHVrVGc4RzRFc0N5UnBLQ1BsenlSWWp2YkxJ?=
 =?utf-8?B?bWhJNEtEWXN5YlYyd3J3M0VLQ0MwSW0wZGpkMVljMUZqNGxSWFh3a3RTZmdU?=
 =?utf-8?B?U2hPYSsxVjhxMHFoZDlnUndQMWNKY08zWmVZVUdkVjdsQWRMSURIZlhqM1Fz?=
 =?utf-8?B?aEpwMUJJSGFGdFVlZTZxazdzTDlCcFJhZFlpNTE0WW9KKzF1cWR5QVphZWQv?=
 =?utf-8?B?ZW5WcyswamgzT1UxUGtLQUNBMGNDWEFkdXJiVjY2QVI0Y0JrL0oyZ0dobGls?=
 =?utf-8?B?dEsxZVREUFZ6ak9qdE1QVlcvTmdmRWx4Y1lNT1ZjZUwwMmxhbHBHL3BLdEVt?=
 =?utf-8?B?S0tPVUErM3FZWkpsL2RocVVaK1JId0lJZ0wrQzFWUmZBS1UwUlNvbnU5Qkp0?=
 =?utf-8?B?S21pekFER3NDM2t1RS9adE9WaVFnM05QZ2RBTEFOakpLLzVtUmlLWjZoZEh0?=
 =?utf-8?B?T2pzTHdHWU1DTGNudEl1TlJMSWJvNTBJZUNPVjgrMFo5b3RRREJxTkNSRFp4?=
 =?utf-8?B?RUpodzk3SCtNNXlkWnhacE5ocEtKSTRpUkdIb1lPeS9CV3RaSlNwQVZGbm1q?=
 =?utf-8?B?dEl1M0tEZlZaVGVHRmdwQThoWWpXZ2l1bEtXM2dYZVo0R2NFbUVTcmx5SFlQ?=
 =?utf-8?B?ei9PYks4QmFzUllkMkVWOUJKdmJ4UEErQkxKRnY4L3hPVW5IbkNVTVVrYnhY?=
 =?utf-8?B?VjdycDREUkFmbHBBYlV1M0VsYlpYSGhwSW03UEZDamtIaTBsNTRjUlZMc204?=
 =?utf-8?B?bkVlemFRaFZxNFBLelBOd1ZZRllZcHYvMTdhMGRmb1RleHVhNzNrdGdsMWJN?=
 =?utf-8?B?RE1GbmQzMkt4dnVlSkh5YStoNGlKRkNZbkhqenIybG1EcTdYRFoxQmo0aGFG?=
 =?utf-8?B?U3ExYW9pMUE0RGUyeHZpUjc1N28rOHBpM1N0REE5bE5ldmM3Mzk4czlXRDFy?=
 =?utf-8?B?a2duK3l4WjNiYUJaSWtyWlQ5UVBmbHRuRmJsVTJqeFd6OW9IQUt6TUNaYm9a?=
 =?utf-8?B?VkdSL2xlOXJSaHNqVzI4L2dha2h5UzE5dXByTTU1ZldIaHg5L0M4QUxpb2Jx?=
 =?utf-8?B?RFlOUDRlUGx4MUpXVjRiODZEeXVMNTFYQmVCKzNSdEdDMUsrRytMRDBqeG83?=
 =?utf-8?B?Q3ZQRmpOYWJXZWRXcXVhR3VocEFtL2JOVnZDYzFuRlJxbDdtY3R4M0loVDZw?=
 =?utf-8?B?K2p4eFlLZXVUaFlML0h0RzdhdXZaQURXS1hlRHlpdWdJcWhHZVRKNDY2TW96?=
 =?utf-8?B?RVh0KzVWa1UzUVZ6ZW9kY2I1M01Td1NXdEdUQ1JwblpiOGVQVklqamJNdjNs?=
 =?utf-8?B?Nk91N05RaFpObll2OEhLdnFyOWRSUzdCSURMaDl1SWl0SDQ0L1VFdXA2dERL?=
 =?utf-8?B?WVJ6MUNZZ0p2Z1ZabWxjZUgwcVV3TEVaV05ZQUlSU0JJMGZVV0lBdHU4S2x5?=
 =?utf-8?B?T2M4Y2hJOVBUWWFSbEpJUDF1dnJrN2IxQXBhR3MxOUVHWXZkM1lQZittemxM?=
 =?utf-8?B?cGlzWXN1YnVzOFpsaW91QmhTREcwRHNJM29ORTl4SHBiOU1jSWxTNS9sVWpQ?=
 =?utf-8?B?SUNjL2I0bTVjNDEvTTVvTVZ0ano3UjZqcCtqZzJ6dnVzSUMzc1J6djk1ZDl1?=
 =?utf-8?Q?FtQD+/mBS5zRT7ZSMh0UXVNBP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ad3ead-eb1e-440f-9ba6-08dc0081f942
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 11:02:21.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woj1cUXqoXghg6inkk3CV78j4l8ZB5y1ux2xMWnk2oaxtzefczB0jDTczfCR2vS/jOlKNwekB9zhvaInziuv2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7903
X-OriginatorOrg: intel.com

On 12/17/2023 2:31 PM, Christophe JAILLET wrote:
> When compiled with W=1, we get:
>   arch/x86/kernel/callthunks.c: In function ‘callthunks_debugfs_init’:
>   arch/x86/kernel/callthunks.c:394:35: error: ‘%lu’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
>     394 |                 sprintf(name, "cpu%lu", cpu);
>         |                                   ^~~
>   arch/x86/kernel/callthunks.c:394:31: note: directive argument in the range [0, 4294967294]
>     394 |                 sprintf(name, "cpu%lu", cpu);
>         |                               ^~~~~~~~
>   arch/x86/kernel/callthunks.c:394:17: note: ‘sprintf’ output between 5 and 14 bytes into a destination of size 10
>     394 |                 sprintf(name, "cpu%lu", cpu);
>         |
> 
> So, give some more space to 'name' to silence the warning.

It might be useful to specify that "some more space" hasn't been
arbitrarily decided. It took me a few minutes to figure that out.

With the max cpu number being 4294967294 with 10 characters, a total of
14 chars would be enough to print "cpu%lu".


> (and fix the issue should a lucky one have a config with so many
> CPU!)
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/x86/kernel/callthunks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Apart from that, please feel free to add:

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index cf7e5be1b844..26182a7d12b3 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -388,7 +388,7 @@ static int __init callthunks_debugfs_init(void)
>  	dir = debugfs_create_dir("callthunks", NULL);
>  	for_each_possible_cpu(cpu) {
>  		void *arg = (void *)cpu;
> -		char name [10];
> +		char name[14];
>  
>  		sprintf(name, "cpu%lu", cpu);
>  		debugfs_create_file(name, 0644, dir, arg, &dfs_ops);


