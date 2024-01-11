Return-Path: <linux-kernel+bounces-24135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7800382B812
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2694428ADAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA25159B68;
	Thu, 11 Jan 2024 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jP38c7d6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17C59B65
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705015914; x=1736551914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=quRErw4mstFG7uCEYoQGvC6aDjFMrZv4NI6RwmHYI3w=;
  b=jP38c7d62mg+PKu7qSEGPnpjiHiSt6iiZPFnemwrFUG7iEofaiNoRGNj
   /mXyUm1aoiiqT4Qwfu15xSY7DJhO4+eu/Aaydmrzqhp0f+Qr67uIlqTPP
   6cKZhslGc671cx/o//lJP1bfB4xmY8m9q2XCXqvyKdVrgPNaXz8d8dRCN
   QeMPTkQdE6Gd1pXFOJWVVqGz4FMkjXtwmgckgBamgdGuDUSDEbh/GGFvL
   N+nv61QlXsjKQcFaKQVyf1yPE1m7HfNnxncfJ2+sCNJPaFW9rhRIFpwgh
   msPnuGCuqPuzHCp98p7AWPjQ4KdPlnQsYARm8z7Gte/eroY6EcLQzCamx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5792357"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="5792357"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 15:31:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="758939418"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="758939418"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 15:31:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 15:31:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 15:31:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 15:31:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 15:31:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCRyy9iz8pmyxhzXAmERKuBXUbzoyNOc8RZkhA+Ec0wP3a6mbWpBPirYfgc2ub2HP4FBvC0yjsLR364q/LcMyAMYtKBjs0xlnTA1lQx0WgIAbky/g1+dt8OepgOjZGxUYtlOtmnRTBOiJO3pAyfL7JwEOJ8Fo10MG4e0h5oNjcLbjmIKzG35T76YOPuH68GBOrZqj5lZA1+lvay5++1Az5Lp1v3Z9jFS0fJtv+c2teBaLuisW54/0agSIIDCEM4cL1y/Ne4xIslgakbOhTwquuoaSOivepUdfvmA818KzITCE++ieBMdhMgJq+OzntLLHLVm/qMYmTag+r93+5Q5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I7ulyUtmAHisrgJj1z8zIWeq0V4TXkdEfK2NQBqfMo=;
 b=nDdKSjDdTEB428XJEwWwEOaL2a3jkj+uXJYRHdRpLjkVTUyGv1I4tXHDnjHDzKc9wK5UCwJXiLW9qOBH6jFF2+9eX4X3X3CXuArer5vp4h4CXlAbEAks1wwIj1aLkc6fgulYSPF/VgULXFsjNOTQZy2NA3FB+rvWZl12yMs34uBVpyZbbY+jgKePtK86ZGQvVKM/+V8Qmu/ccuiLvRG/4rImrrhVJz4Nqklk81uo7ir4tIZwEZO8VYoDlC6Oe3zp84jCYXzJa0nZXda7gr/0bl7l24xfRJlzLIWIrDc4rMXGXOlpuYj7WSOdJw57vahd6b7wfmVZRqtNlkfHZnzWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4560.namprd11.prod.outlook.com (2603:10b6:806:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 23:31:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 23:31:44 +0000
Message-ID: <30593e56-d575-4e40-8b78-b2a75a7eb822@intel.com>
Date: Thu, 11 Jan 2024 15:31:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: Amit Singh Tomar <amitsinght@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>, George Cherian
	<gcherian@marvell.com>, "robh@kernel.org" <robh@kernel.org>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>
 <ZaBgUOQ3iWs3hLrb@agluck-desk3>
 <1daadc08-57e9-40b6-9a34-cfe47d368348@intel.com>
 <SJ1PR11MB60839C1BA84823B44376B90AFC682@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60839C1BA84823B44376B90AFC682@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:303:8e::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: d959c607-88fb-4b86-df97-08dc12fd78c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhV5sN+q0gJVMEo2yvyywGvFAuKJfyHO7a2vALgYXVVbEOmtkTvYbFsj8DlOKPccp3893ky0iRWYgZzhHdAl2TzLVV32DGeL5wv2yrTb9qDli0te9y3huHj3k+CcNhU7kr4NNfy618bv3CYaavKkEbWaxo2aKEjUetFCOfcARSgUdHibtQ2JIfxBQdhPmcIhs6ulvTSFbvQVbRdwRNfTOexGz5FnDKYke5n4KmAjyY/kwCAsn/Ny0wxZ67lpXkpXBm6KK7oH8OblnRAnbnEEt/WlvY5VPqCGvfFHf60AwhHKYXtVJ5d2dRTa9qySLCdXGOUh8ZReoxHgd9amdWLrEDLSywkQ6bbU7xxpLry/DlxmGL+LJehY/ofCAwcSlSdMQoQV6z8TXMTKzNr8gz0zrALemxc26uxA3nVfn20/E8062kQywOQHbiAVTEqPHoZmv3CZukIFJUiBOhmUW7yF9HEEYSWA5Gr3nkd7WTApv6mfGZn0qZbXqWkTOSfzmnn7BtQYLileDdtS+uqbMumb/NSH0yIbJ34ZRj3ON671UxCAA1z1CKe3D6fARbU8kWd4rT1MHtDBoDliMaT2+iYL4D607Tb7TlJXyXILRCk3oojay8U9UUeRMbzrCnpYQ5z7AejFo59q84iEIJ+1oK8sUFF8MjjbqGlbI8hJlyhk1zTn9ElQe58vSXDqYe31NDnp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(966005)(478600001)(86362001)(2616005)(6486002)(53546011)(6506007)(6512007)(31696002)(8936002)(8676002)(36756003)(316002)(41300700001)(66556008)(6666004)(66476007)(66946007)(54906003)(110136005)(26005)(38100700002)(4326008)(82960400001)(31686004)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1R0RkhaQWVIT1BDOEw5V1AyT29vaUE2OVFTUHFOWVNhNVNFS0ZxbnBFM0Jq?=
 =?utf-8?B?QVJpaFYrUzlYTFBJaXR5bnJyOEZhRG1YQXRTZ05TQjg4dnI0SzI5U0tJWWpV?=
 =?utf-8?B?d2F6TVdXQzZRbFpZSHhYYXMrWHpCYjF6RlBmelROR1NmVjZnRGJ2QkFwdm01?=
 =?utf-8?B?WkVhc3lEUEJKYW9xK0FXOFhuMzBiZkRqM0ZuVEovOXNLRU8zNnEvTW1aV0VS?=
 =?utf-8?B?VEpjWXVjNUE2elpnUFJwKzJzTTlJNXZDWjRrL3RsWjlJdkF2Szd1QUphSEl6?=
 =?utf-8?B?anVTek1nMklVQWFuVWM5SGpnVDZ3Y0RLeDZzUFJ6aDBYbzM4YUtlWkwwUmdE?=
 =?utf-8?B?Wm41R3d6d0FSSW5JNjZYMjNCcjJZWWs1Z2dibGJSL3pFdGxuamE5d2QxZ1pQ?=
 =?utf-8?B?Z2FoRGIweEhyUTZETkF3QnM0bTBCUXYyMjc1dHFDUnFpMllRamljVEZIL0Y1?=
 =?utf-8?B?Q2d5TENJdmw2aGtpS0RPM3VwNCtpUmUyU0wyTDdHWHYvMVY4b05NNzNKTWh4?=
 =?utf-8?B?MEVkY1I1QUwwN3VSZ3VoYmpPOTVPTzdzQUpENHdhSmFrT3BvdjNscFFJdzZi?=
 =?utf-8?B?L0Fvb2tSY0NzNjU1ZGpjeUJyOFJvaGdzbnpIQ0IwcFJMM3h0K2NGTGtWdERj?=
 =?utf-8?B?WGs3WTErMldvOU5Qc2p3QkNnYS83a21ROTNVbTBaRFpsMWRobkY1SnNxU1BG?=
 =?utf-8?B?eUlPbmgxMnlsdno1WEhhbityVnlaRG9QN1NMVFVQRlp5UnJDTWFGcmxHL3VR?=
 =?utf-8?B?YldsRlRFdlE0UEVSOW1qbG5TK0FhQ21kak1yZEZNVmpVRHVuTi8walhaQVhz?=
 =?utf-8?B?THdlNnAyekowU2tzVUdLUUpJVzRQa3JOOUhsbWJNMkJ5aWtZYzN1SXRIdlRv?=
 =?utf-8?B?Qjc1RHkyaWxwSGxJSWxldlAwclVYckxReW1ML1FGWDcvV01acm50ZzYzV2xJ?=
 =?utf-8?B?ZHp4dlpTemgxb1pmWk1mQWwxVVZHL0hOZk9jUExwTmRKNXlnS2owVHRZRWJH?=
 =?utf-8?B?WHdHK1o5QXk3R1BZMzlYQTVzRGk4cGlIYUlMK2h0OThFL0tQU3BGNmROMEdq?=
 =?utf-8?B?czlPSnVFa2JEUHA0ZGlSeGY4Z1FDZHNBeWtNcVBick1la2pUN05qREs2ekoz?=
 =?utf-8?B?dGhaSGcxZTh6djJaODRtQTZnUGdpcUxBdnk2bDdGdFdFdkxNVFVXMDBTYW1R?=
 =?utf-8?B?RHF3K2hiMmhqT1loMjRuYUFyU3NtcTg5T1FjN1FJTXBpRUdXOVdreVhDMHoy?=
 =?utf-8?B?Y003bjNLQkNQUmlQYWM3d0kzb0JjWTlmZUlUc3lsanZiOFArQXdyK1lrc2lB?=
 =?utf-8?B?NUpUOTM4WlZnVm1QaVMvZlc4d0tmdllXNkZ2bWJqck92TGhSVTRyemlnTGtE?=
 =?utf-8?B?dWZ3VTdvR3lNT1hTMFp2bGNuTXM5dGVMMVo0YlVxTnBhMkJoMm5UYkVYcmVk?=
 =?utf-8?B?ckFIai80R0U4QjNiQnZKbFZJUi9wRUVENEhsOTl0N1h3WGxsTjl4WnhOR0lL?=
 =?utf-8?B?TWt5eDM0VEJGWC9DWVE3R2lrZ2tjMWg0K0NqczNzazFoVHVIMzg5TGFIRHZB?=
 =?utf-8?B?cXRwREorNWRrcytMd2JUQmsxNFROMkxaS1BWaTI2cG1JS0t6dU1ONi9lRWt1?=
 =?utf-8?B?S1BaNmJJWlltOTNVVm1FZGVEc0dqdUtjQzJCVG9ZWVhUTEdQdng2Z0xZTXY3?=
 =?utf-8?B?OHE5RnBwV3F1OWZ0eWhyYWVVa1JmNE80V2hjY0gya3NQOUVZd21sb1NqNDlN?=
 =?utf-8?B?MjNKYkJvWlRmcUsvRjdmNlFJV2l1MkhzdEhiRUhwZDlEbStzSWFhR2dMRHVp?=
 =?utf-8?B?aGxnMU9UT1BzNEZiVUN0MW94dWQ1V2JJUE81dENORFNGbUlGcUJlR1M5V0J2?=
 =?utf-8?B?a0czYXZuZjBCS2pvNndMOElTMjBqYXhLQmRIYmIxK0FJSjF6OEIrZ2ZrTith?=
 =?utf-8?B?RG13bktjenRCcEgxSisvL3h2ckhqSjdadmxWbks1VldUVVp2R2tNNSsrOHdC?=
 =?utf-8?B?SVpZVmFlaGNrOHg0enZmMENGVVo4ekJhdEdsNWpva1RYb3JISHlNOVQ5ZG9I?=
 =?utf-8?B?Ym9VbE4xdXZRd1BXSGk3bFgzOHhpdURnMkZYS2Z2THloZXlvdkhsTkN1OXd6?=
 =?utf-8?B?NkdYZStlY01qdXZsZ21WSzd4RDlxRzZLemoyb1luQzJtOWwwV1JRK0cxRGRS?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d959c607-88fb-4b86-df97-08dc12fd78c0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 23:31:44.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Kp7BLiW2Uk8ZkQ5XhEe/ddnY9gKet/lvNWiLoGNcpYOUVO2XSznM+A8MTTCvLXLj/6RvzpvzBo2Z0qnR07Zd+4VJ/fNg1uBolRQDcB25gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4560
X-OriginatorOrg: intel.com

Hi Tony,

On 1/11/2024 3:14 PM, Luck, Tony wrote:
>>> I'm not sure having multiple lines for the same resource makes anything
>>> clearer.  I preferred one of the earlier proposals like this one:
>>>
>>> 	L3:0=XXXX,PPART=X,CCAP=X;1=YYYY,CCAP=Y
>>
>> This assumes that all tools (public and private) that currently parse the schemata
>> file will be able to handle this additional information seamlessly.
> 
> Reinette,
> 
> Yes. If there are tools that *read* schemata files, they will be surprised by this extra information.
> 
> But that also applies if the "extra" information is moved to a second line that also begins with "L3:".
> 
> Tools that *write* schemata files should be OK as long as the kernel will still accept:
> 
>   # echo "L3:1=fff" > schemata
> 
> E.g. the Linux selftests in tools/testing/selftests/resctrl/ should still run without
> any modification.
> 
> The "separate line" option could work if the prefix isn't "L3:".  E.g.
> 
> L3:0=XXXX;1=YYYY
> L3PPART:0=X
> L3CCAP:0=X;1=Y
> 
> If these options are asymmetrically available on cache instances, these extra
> lines won't have every L3 cache instance listed.

I think we are going in circles here. I shared my concern about user space
breakage a while ago [1] in response to your previous proposal and this new proposal
seems to match where this thread ended [2] last year.

Reinette

[1] https://lore.kernel.org/lkml/be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com/
[2] https://lore.kernel.org/lkml/20230901160451.00001f75@Huawei.com/

