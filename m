Return-Path: <linux-kernel+bounces-20480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE4827F83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA1F1F272AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5FEC129;
	Tue,  9 Jan 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6pZuIfo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C62BE47
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704785568; x=1736321568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DEE49VJSlCBjE5ZasrHofsqdeob1e5Uo0HLiVK3Jukg=;
  b=i6pZuIfo1mZmBrb9WWfTJQ/xeMzpZYpXOGEtUbdCou/F7ChHY9ywxkk5
   u2IZxE+R+36M9PuMsimmLEB1V8J4H0M1OxEIRosGSIaQf6keSg26tjCn7
   pzZvKpQWQOa4TDacp3CqaTtKfO7FrfBWyfwoc6Veq6Eb64s0epPz1pedZ
   cwVBbjwvz6NRMvlMLI9BMeoVUb8J0HKXbkO9LYwC9xWOCGXC1iH03gHR0
   tFNsA427/63J0wlF7xtiQA0oYmZdfDd1JhUVebtQF0M0bv4rFCyi0jJmF
   P3tdf/nBSI4K2Q3kMo65Uknu3DPlq8V9aE/mAfWY83oDWuGhY47eRlG9l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="464512153"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="464512153"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 23:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="1028666080"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="1028666080"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 23:32:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 23:32:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 23:32:47 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 23:32:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO28A7CxtL/DGLEtgoJ3zWJonnvT6FpmruXMs/OpCe1gGoEBlGTGrXrqxMwPNx251s1oUPPmnFYK31DQd/GS2lxn6s0/i4kUOs+2ZTA1tvILMciQVE2FPMUJnxtuIjgV28jqwz4WyPFNmsp9Hnv3bfHrrwQivyXA3nfvARQipgmC9aq2t0W8MfeniuOqlhPFMQdD5qZ2cv+lz20/dZzCv83Um4EG2ryqXNtwKt4+d+HmgmmbANL531OIzY4Zlzvvz3q4nOo2xg2boH4m24Z1ylA5EyYx+io7sTe2qMK0sD0vnEYYrtCoPuymoVxUOyy+h/5kZY4OFAPxeQz0xKDcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgMXkmRkxKwdcMyaDuv4voHPGmj+sjmAfBgtD/aRXtI=;
 b=MX3l2NWNSQ0OMraN3+gACZ0s13PcZluffy+jd5BHiTT7aB1oDrP22jslPqeUnpaD0naH1qTKbVOD56Izu12X/E88vaCX+VEoOt7fWmfw/0JSIgrxftzV0z7NmfURogC0t41rnMKfV5FsDdS5h4fYutMgsJcvfOFUpCTW6i3cNDvZJQFfzk3cabj5Uu4++HkmzW+fvpVc5rJy5BtGtzYZezoi33vl+NZUMK1mIiNo9lPQYQR0o4B07nTuYcUztQZspnSNQ0GcXeJp05ts5kLiRw8See/033rCvoXu248FaPGCH94Ivc7AK1YH9ZQmunP9L1lkVC/IKad5j6KVSjBeNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Tue, 9 Jan
 2024 07:32:11 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::3c98:e2b:aeff:5041]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::3c98:e2b:aeff:5041%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 07:32:11 +0000
Message-ID: <e117917b-6897-4209-82af-7757a93cf078@intel.com>
Date: Tue, 9 Jan 2024 08:32:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] checkpatch: don't complain on _Generic() use
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	<linux-kernel@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>, Dwaipayan Ray
	<dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, "Rasmus
 Villemoes" <rasmus.villemoes@prevas.dk>
References: <20231205110524.16561-1-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231205110524.16561-1-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: b77e5f74-8e4a-4d6e-017d-08dc10e517c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6qeeL4TBL5zhUE5317jsLgR9Yk3qx/uOQi/3+alJGdxfrdc3xMZcz/623EVWy1ewF7PjvbJPemJSiJIFP0p3JsfnRUV6eZ1O+Q7JFnBUhGUlVcqqSS+1GYbhbv83J7lld9c7/vBKLOP7j7zi2jAyxQhhT581g2CYij9L5b90LHimFK4SzjXaHbLK1Hl6KVsDdHiPDhCPOO2sR/zYkWf2ua8TDkUVnITTNQajPmMwhMMFsg9MZcdlAE6F8CDSKa8W85Doko95c0C6rXvPXMBcHqVaKRzDdJn/A20jG26s1DMKgQLHCMue4q/lbnPVAsv1kp2h3XVz5vXXW3vfXhG/H96w2iB/SiOb1et+2iqlPV0mdXeGhlGOZwXpR7Z5zkH0Z1DYbmsYEv7BJBJmapyFaDVC9rGGKcwC/Bf+hoxbqwQlmXQfMsVxnpJUbh6zTg/KtW49gLrelqzQVvHTX2gH4ehHMRSJHHXi63f6MFPHnFGvi5Fmdf37Gqha9bxIBYIEOVJu7Suqq1bcc9cNP7og+SroFLeTmrvBmV27ZYfm27IDnG+zT1ruaKZ1n88xAhiQMzQEnsNF1lpjhW6ezGxJYO5IUhWoEFH9IUDcuTkugdoYlqtQ6F478zpljBH0r00210r5fUaNk4YWEEMrZ2bcAUrgIwFIWN+VZ4fPszc2pc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(2906002)(6486002)(2616005)(66556008)(66946007)(66476007)(41300700001)(31696002)(86362001)(31686004)(6666004)(4326008)(5660300002)(36756003)(26005)(966005)(316002)(110136005)(54906003)(53546011)(6506007)(6512007)(478600001)(82960400001)(8936002)(8676002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9hRk5HSUpHWGRCa0pmSSszQTE2ZHQ4ZDlKcmtPVWJmaEpQVHVpN1dacnpn?=
 =?utf-8?B?dlVFZ0RROURMQWZMRndnSVovSUNvd2ZJQ25XVUlkcVdaaC9zYUNMdXZUYVNO?=
 =?utf-8?B?eGtDVXpMZTZJbVQybWtkaGxJM1BOekxxbWdnU1ZqWHdmWFpjTG5CRW5jYUNC?=
 =?utf-8?B?cXh5akM2TGhhcVNPb2l1ZDFOWXJSd05JNTFNYS9GOXhBWnZZcVRadmNyTERm?=
 =?utf-8?B?U0l5bVF0YzZSYWhHWmRVOG4yVHBTVVNIWHdBUVJrZ1dVZUkwSmEzaVNUd3Nn?=
 =?utf-8?B?YmF2Y2N4WkxMVjJPWXo1OEVjb2ROY1VTRU12ZDVRNmUvVk04SVlCTEIxL3Zx?=
 =?utf-8?B?NGJmMnlxSDhsNmtJaUJsNTBsL1YrU2w0NmoybGtyTnMwdjRSaTdJaUd4TEFl?=
 =?utf-8?B?UkhSSForTUFYWUpqU0ZVVWRvajN4ZjJ1eit1dXhod05nVUpydHBvZE0rZldU?=
 =?utf-8?B?a0hyVzBjeXhGeWRLaFJBMzhMRVBjQkFpU1A1dmxmRFhmS1J5QXJxVklYckpr?=
 =?utf-8?B?NUY4c2xzaTVrcmRDVm81OHd0T1lqTFBDbjhBM3FnOGt6RXJtbE1uS3dFRUsv?=
 =?utf-8?B?RTdIeTUwYUdUVFdVa2pCd0VlMHloZGFQY3g1YWU3ZDA5Um5lRm1CM0F2enQ1?=
 =?utf-8?B?L3dTbldORlVwcFdhTHhVenMrZVRQUldhQUtxeUVkendSQ2UyZTlIa09INEZF?=
 =?utf-8?B?c3JXNVJqaCtaUTB5d1o2QXRVUGFaVTBSRTdwcTBjK3EyQmtZUWtvSUlpV2Za?=
 =?utf-8?B?YUFkSFZwR2lpMTYyZS9EaEM1NlFHZnIrL0JSMzNHWnZTdlgwQkN4YUtaNEEr?=
 =?utf-8?B?ajh1aHpoNGkrRVBNb0YrblEzS3dFcEVXWjVJYW5GQW1jK1B1c2Q4NmFNUzFS?=
 =?utf-8?B?bkFNVlBONjN2czVuVkxmVGZ1SGRzSnJvbm9EWUtBbWpucWNhRGllQzZleG9T?=
 =?utf-8?B?bUNweUU1K1RST0FFcGNJa1JTRExhdWFEZ095VUhzajA0cFluM1I1K3A4K0tU?=
 =?utf-8?B?dnoyOWNBM2g2YWwzVmwyZEhFWFlXQURCMzNtS2k1M2UwYkNxaXA1Szdmekdj?=
 =?utf-8?B?RzVJMmI4SXZ6ZW5EQkJjUkU5eTFkKzQ0L201aXVrQU5DVm9TYnF2Rlc4MGxn?=
 =?utf-8?B?bHlVVzUxc01LRkZ2SXRCREN1LzB4NkYvc3A0T1VTN0lPRG5WSDZQekcxNmQ5?=
 =?utf-8?B?dE1CSGkvZDRiMVZWT2ovYjYycVVTU1gzTWlRYitPOWg5cmo1dzVXN29Fejg4?=
 =?utf-8?B?VEVDVEhRUlVxSnhOSnVDZit3MDltK1BsTWEvanVTNm5FaDkxMUh4Q09BSkpO?=
 =?utf-8?B?b2x1bjdDUVdEWE9BSk91eVhLNkVxa2sydHRXV29hNnp3ZWQydlcyYXc0V2FB?=
 =?utf-8?B?czQ0MUtVbGxPaVMzN0RzaFJrbXkyV3FFMGduNzdQTnd2bjJFRHJzcVcvVUFX?=
 =?utf-8?B?Ty9wdjBWeDJlTFlNdWZObXBnOFFGZVFCaWwyc09tWmZKWHU5Q0xvRUhSRThn?=
 =?utf-8?B?Wi82MjZXQllEVWNZMVBZczN2eHBjMHVvVTRsblh0cWtZVHoxMTZ0NVZGdmlV?=
 =?utf-8?B?Zkl1aVhMTnlJVmVSNmJsL1JteE9LRTJPZTdwR1pVWm9wV1lIalJwblljNy9h?=
 =?utf-8?B?T3JnVHdEdHFvWnhNellvdHJNdHdiUWFjSUtkN2tWbDU3Q2NnZ3EzWlZsd0JL?=
 =?utf-8?B?ZzZwRVRmeDQ2VXNKZWJKT0pGTERQNk9rOEVBZGhiRWs4K3YvNzZaZjUwUUVm?=
 =?utf-8?B?S3RrY2hpbEpvTG9uSEpBY25WU2dUS3RCc3p0MjZhcXk5dEpzYmpmdE03NzBv?=
 =?utf-8?B?RGI1YkppbHdqTzNSZHM1ZzFTT0ovc2hWZzlMbnpzY1hxQUNXTjBNUTJPTm10?=
 =?utf-8?B?S01BeWpSYmVXM0lUZ0xtQUo5ZXJoUDhncmxmZXFQMStOVFpwU2FwWWZNKzcw?=
 =?utf-8?B?dmhxbEs5R3VFVzNweVQ4QndybjVocVFsSlJsamtudGhLeWtUYjk3SENCSXB1?=
 =?utf-8?B?dlk1SGU4TjgvaFNkSTBFV0tzRXR6YlFDMEFYcUxSRlZmNmJTbk1TcGhGQW0y?=
 =?utf-8?B?TU90bUF2NjNQakFOcjExTWdOR3pndmtQeVkrdTUrYzJ3OWdRTVQzUlNCb1Ri?=
 =?utf-8?B?V0RyWUhFYzZYS1IzZmsrdWZZdkgyalg5TkV3NUxRSlBVTGtGU0JXbGhwTFdN?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b77e5f74-8e4a-4d6e-017d-08dc10e517c4
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 07:32:11.4132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRiXbcgjNHLRthUvZFENTtb1PqSZo0rogRblPYipE7jzvDu8Eocm5q/CR0Og+IPOHeGTRVBclijksnGncKWl7dl13zcXodZXKmK3W1Paj0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com

On 12/5/23 12:05, Przemek Kitszel wrote:
> Improve CamelCase recognition logic to avoid reporting on _Generic() use.
> 
> Other C keywords, such as _Bool, are intentionally omitted, as those
> should be rather avoided in new source code.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: _Static_assert dropped from the scope;
>      whole word match.
> 
> v1 link: https://lkml.org/lkml/2023/11/27/1055
> ---
>   scripts/checkpatch.pl | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..1370f426949d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5839,6 +5839,8 @@ sub process {
>   #CamelCase
>   			if ($var !~ /^$Constant$/ &&
>   			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
> +#Ignore C keywords
> +			    $var !~ /^_Generic$/ &&
>   #Ignore some autogenerated defines and enum values
>   			    $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/ &&
>   #Ignore Page<foo> variants
> 
> base-commit: 3706f141e5639d3034bd83448e929b8462362651

Hi,

could I do anything more to have this patch applied?

Przemek

