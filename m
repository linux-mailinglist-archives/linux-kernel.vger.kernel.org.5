Return-Path: <linux-kernel+bounces-106916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF787F55F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCFC1F21EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084D657A7;
	Tue, 19 Mar 2024 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsP+kiZR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0639651BB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710814852; cv=fail; b=kNrGcgbfoCJjMm2VB9RRaZPz/yg9XYLSSi4F6gha655Oz0nTNuu3Wra1S48J8iPcL9tVACLq5ihsCmYQisMl6Q+ySeHtrGCLh4ex8TCAdMYQvSxaN13cq5Zsl5b0rV6GeALuhuwCTsVYWgrUxslh6NHAeF/OrhHZRCYr/UFThxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710814852; c=relaxed/simple;
	bh=iRQEF5ZOSdfh1+vmsjNFyr7WdPKkOy8UwnDzuk1Atdo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jYHgQsBi7/sfu6m0u7tafVlpVnQ3+kn9mS/p4FU44lJNsweMhlSmvs5vwjOWkoki51zZqvwdOEvakfxB3vTsM7QsFgBWXoEWHxyJqd0Sv/M9DE7o38KtGwY46YchuOzrnzxN6OM3ukMSi3JQgO5fkMALhcW2DdItB9djyHmvQ40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsP+kiZR; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710814851; x=1742350851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iRQEF5ZOSdfh1+vmsjNFyr7WdPKkOy8UwnDzuk1Atdo=;
  b=LsP+kiZRV8XEjn4DHU/5G01zldxrTH7htELt1ok0DM+tIzEM6ZZq76+L
   tb0lnyh5wBqFry3YY8tmcck/XpkKVUk2tdlT7iawD+RAAsX8PI9sS5KPD
   S9oMckeVXSIaY+MCOfxcLNDoTQp+aojmd+fAUW07TRZRcLPSj8VDQQpld
   WkMVf7wwbUXpaM3ZbzWkUviXzH2BjcCvy9tKoskzMv7fjd4+ugqFgV+rt
   Eh085OXk2lLj9fRCwKUOdbDVXqbt/UiCIYd+9+iDrNxScpwZ/LprrjKSJ
   +4ou7RVfWe3vpMYhOokycvnv/dfHBmFEJiNu9ZeQIODr9CqnoZKeH6qTI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16301582"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="16301582"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 19:20:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="18238304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 19:20:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 19:20:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 19:20:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 19:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWJxDNgB4CaA0m6XIDaHdzGLKaJZv/og+oC2/CPKrI+IOeL3BQ84j7PK4qnaIdK+rS8eErhao+0xmbvVsbMZQzdI5hBTDD/ohzx5TrXy+bBB5nFiVGKNbDE5Tmio8K6tZHKeYRINj0qnlNHqCw4G8p/moNbSZOMiGk5cySFrlKhP+TOeB+t343mTJDW0vas7egsxkcGhvSHd4Y6FBy+6ixNpi5xFhduO7dkvDuOUg/4B5lczFOkmcUGyc53a5lDv3u1Cr1ywvhjjlBpNLa5fLSMqeELwAJEdJ82hKl/EiHk+VD70XOwAq8WVTegG7iakaPJ2niEi+UY4arFmcLGhdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLC4x43O6ezcQyRKKLcn+tL0pnMKKIwFNyQAxver2ws=;
 b=YKTJWPFf4HCvWeUJ6R910H4iJsZuPpV/O9j66PhZ1gAALB7hxVE1Ck9XcHlQ0xalwQQsHU1gI2bNL2BHYYVJVed3daEnUWQmlgwe1/XBhYOXUR1okhqYLYd/y8ZKURS0jcSuq/j3rA0i5XeRUXJIJYhhV2+yXZQE3k59dzmXZTs8+gMT+qBipLzYFXBrpmEb18i8nw+GCrwrvp6xpdQHY4MGCRIsahhn/QINBGNq6t+sa9eP9LqLVcXVHKu3NMR2oYNN1Q92BSLVMVYBcPKiPDB/AEtZmZgFo/zXWAty/zOaknHQdK692rtayNVns0CLYzpxouEnp+WglxZ6k6Jsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB7021.namprd11.prod.outlook.com (2603:10b6:510:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Tue, 19 Mar
 2024 02:20:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.016; Tue, 19 Mar 2024
 02:20:45 +0000
Message-ID: <29f06352-d234-4f4d-b804-9560816ed055@intel.com>
Date: Tue, 19 Mar 2024 10:20:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>, Yu Zhao
	<yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko
	<mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song
	<21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
 <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
 <caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
 <5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com>
 <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <a75ea34a-7512-4169-b987-95f11a7f3dd0@intel.com>
 <b084270d-6c7a-400c-8f4b-0797d2ae5fa6@redhat.com>
 <a99bd601-7599-4bb5-811d-efcb94ce8938@arm.com>
Content-Language: en-US
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <a99bd601-7599-4bb5-811d-efcb94ce8938@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB7021:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGfl1KShzE9WesiEqEgo+gY6bv9FenHsRZxcRjYluBUCqKN32pJMklrUoFf3SitdqKA9uO7oQ7i34zsJREEuyepUIdm955IC11yZfSo7lwLhreoj/pyOM3Ydz9mzevYlazXOxp6WplfHwjOkS8tgOqlJd0/gvjJigWMOfoVDNVn2s+anYLcsJgNlmV0YJnT5H/4RDq1blO7CiJsHDETNwTwCNOuJoXsEylgQXwiQBWzp6mHvTTh4IfYvGzV7yfQr/MB8OT0Q9q+VrE/3wmaRGodNGHdUTHOW/GpIHKUUdp5MhXNM1ajhcYnxFf0fMyZgo+D2VF/gNlBu0iJ09GZU5GDir1s3piBffE6vH+vNWDEq/spFeck1QZdPocAJV8XEnT2PooOhL9H1QwpJSwHDqEYwLak6JHMWC4vmY7iuAe+pKSahd4ctX+XY3JPQDGzRV/kUYqBbfDmQazVKd5ybZlwTBYlns+Slyn3PAtYdwz2+Xs1Ch2fr9iXocikF7IJc7EwVku4lTgloBPeNgk/b9NeTyYy7ue+4+EOCzT0Z0gEkUzkdKgTT7tSv++c0+3fWTI3/cHDS1H8Um7Fsx3g/wlL1Dts/bPTCW5QxIT3NIes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRIZFN5d3hmNVhlWVlpT0p3NmVraS9PMXlXNVRUcFhqZXBSbjljWGsrbG1I?=
 =?utf-8?B?b2hVR0Mxc3FEbGVoYXE2Q0NVY1NOcW5waE4xTTRYeVNoNUh1MDhrUkQ4Mlpa?=
 =?utf-8?B?YUlpSk9wVWU4djVTR09lWmsvN1RycENQeittZXZEaE9ia2ppazJHdlJBVlpF?=
 =?utf-8?B?VG5xbUViVHNPNlplelhsaFVydjdUTnFkR2dSU2FLckRKS0tvQTFnTFlpYVFa?=
 =?utf-8?B?TWpNWXVndUxkcHFoTGxlVHh5WUppWDZsQ2ZhMWMrUkdPTzh6ZEZOWE43d3Bo?=
 =?utf-8?B?d2J6R0xIczYySEx2U2JMV2ZyZDdwNThMY0VFQmlrVGhqWitlanJjNndnL002?=
 =?utf-8?B?cWN3V1N3UE5TcWt5bkRtY3d0QlhSbktjOWh4NmNuRDBKWXg3RG83dGVUUG0y?=
 =?utf-8?B?SnZGTDdaalVkSjFVOTc1MEVCVkpDNll4VnNmOXI3U3VpY2xBVEgxVWZxeWxM?=
 =?utf-8?B?WXA0VEQxQjJlQ2Y5OG9LMUVGWVkxQWVNUmRNWHhaTFRUY2tUTG5ZUWh0dkNL?=
 =?utf-8?B?dW9QenRuSnQvNGFLT1pkcFpJVjFvMkFDdHVuendWQUlacFJCZGpRb1o5MmhF?=
 =?utf-8?B?bVNuV3VDNmp2OFNycGV1a1BOYmFoZytqUGNKTXhDQ3RTVWpNa0J6ZmtuS3ZY?=
 =?utf-8?B?dVFRdGx6d3lxN0p1K25Rc01OQmtEY3pGaFU4S1VtaThmYm1KTnpWeXMvUVk0?=
 =?utf-8?B?Y05MdUsvOGgvVFJLaERhcDdPR2ZyRzkxZWlBalVOdnZrWGQwelFONS9jSUxo?=
 =?utf-8?B?ZnpSbW5XVjA0OEVTVTlrR1p0aDR2aWZEdi9COWZ0MTF5Q3MyYkJJazVNaFlJ?=
 =?utf-8?B?YUY5ckZPVDc1ZE95V2JVcGhycW5hd2xHMjRRbThVemxOcXB3UnpESy9iV0xJ?=
 =?utf-8?B?QnBwNXFuYVF0M05uRUJ0bUFPTHFXSTY3UnpYNEhaUkcxU09LWEZhMzQrcDdS?=
 =?utf-8?B?clBTU1BZbnM2em5Uemt1ZTlKZnY4bkZyUm0wNUpscmJVZUhOUWVCTTk5SW5R?=
 =?utf-8?B?UGF4bHliaHNKcXUvclpCbGt3YzRlRVB1R2E0ZmE1UlE5K09GS1Jjalhla2JI?=
 =?utf-8?B?Zy9menJ2QnJzZ2YwaXVGZFA2d09DcUxmL1FFdWdnV2lOVEJ4SzhoWnRmRFZQ?=
 =?utf-8?B?SmlGYW1ZcFllRVlBSkVWZDNuQjlMalJXQXk3cmFSTG1GUnp2WnBVbk02RHVy?=
 =?utf-8?B?NDdXVXhONnhGZXVDNkZUZlVxbUJWYUZibG9lT3pWSFg4UnA5YnAxeDREVDZP?=
 =?utf-8?B?bzhMOE5vdzNVblBIeXRsa3h4Q0pUKy93V2hLMmlFWW1pZ0JrVUt6eXk0Yk9M?=
 =?utf-8?B?bXlIOUJ2WnNKWFB2V05GUVc1VmVuKzBnK3dDZGpMQjdVdE9CakJOMDdGc0c2?=
 =?utf-8?B?bzk3cG1zOVZqbDhUREk3YnY0ZE9majBROGJUcSthcDdSTkJYUllUQkpDdk1i?=
 =?utf-8?B?U1lYNGxWMmFhSHk2VXB2RFRyMnZXR1IvUUVzeHVyR3p6eFBJU3FzV1QvQ005?=
 =?utf-8?B?MmFLVnVLSWFXZ0hZanZhcmtvQUg3VXFlZzArTUxWNFpCRys0dklGZ2FRYnVB?=
 =?utf-8?B?VWZ6cVpuY0M0TVFyeHJrSzczdExJQjdWbDZUK0pOOTBFbGRIemVISTZGaFhE?=
 =?utf-8?B?VzlNc2drMDA0Zkwzd1ZxME5RYk9aVmxQUWJUM0hxWkg0dnV5VXo2MDZBM3o0?=
 =?utf-8?B?c2NjZVNZeFREdzlMNXNDWnBVZ1hDT2ROaVZ4Vm9HVnNERlA4SjRoZmZqYk1Z?=
 =?utf-8?B?ckJnbk1lNUxGaE1BVXlIQU9qcHhXMTJ5TkM2b0p1TzBKZ0N4WmI3Z1RXbmNQ?=
 =?utf-8?B?eldwVWM5c1ZQWXpDSFdMalMxNFc1alRoVjdMV0JVeXRRY3dGcDdGN3VEclNo?=
 =?utf-8?B?U3dtdFh1NzZPUVZQQnJ0eHVoTmc1eWdsZWxyTFE3UGs2QXFKaFZMVDR3UXBV?=
 =?utf-8?B?eURSZ3UrS1R1VFBubmI2RG0yaXBLZGNjeHpNTUhLT3RFQTBFWFJYTzQ4Z20r?=
 =?utf-8?B?aEtMYTFvVGhJSk9QM2NQTXBHTUZXMVNrTjZKWjdmb2NsZXJHcDdwV0xSb3J4?=
 =?utf-8?B?U0p1cm9JQTF1NzNMYzZZNHlnOGFia1FmSCtrSDNwMXhuTEVnOHJCQ00xNEZE?=
 =?utf-8?Q?38pRh+FcS0Qg3l/lebq/MxXDb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82442813-cc5b-4dc8-aaab-08dc47bb2ee8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:20:45.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdZskNIo+b4bGrCQcPYDWUA2xhVgn6EujoaMogHCM1LodoogMnMzGMMdOO2MrxzWCNqQphk80/0EoTLAgHSRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7021
X-OriginatorOrg: intel.com



On 3/18/24 23:35, Ryan Roberts wrote:
> On 18/03/2024 10:05, David Hildenbrand wrote:
>> On 18.03.24 11:00, Yin, Fengwei wrote:
>>>
>>>
>>> On 3/18/2024 10:16 AM, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> Hi Yin Fengwei,
>>>>>
>>>>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>>>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>>>>> up for swapping in large folios in a future series.
>>>>>>>>>
>>>>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>>>>> uneccessarily.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>> ---
>>>>>>>>>      mm/vmscan.c | 9 +++++----
>>>>>>>>>      1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>>>>> --- a/mm/vmscan.c
>>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct
>>>>>>>>> list_head
>>>>>>>>> *folio_list,
>>>>>>>>>                          if (!can_split_folio(folio, NULL))
>>>>>>>>>                              goto activate_locked;
>>>>>>>>>                          /*
>>>>>>>>> -                     * Split folios without a PMD map right
>>>>>>>>> -                     * away. Chances are some or all of the
>>>>>>>>> -                     * tail pages can be freed without IO.
>>>>>>>>> +                     * Split partially mapped folios map
>>>>>>>>> +                     * right away. Chances are some or all
>>>>>>>>> +                     * of the tail pages can be freed
>>>>>>>>> +                     * without IO.
>>>>>>>>>                           */
>>>>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>>>>                              split_folio_to_list(folio,
>>>>>>>>>                                      folio_list))
>>>>>>>>>                              goto activate_locked;
>>>>>>>>
>>>>>>>> Not sure if we might have to annotate that with data_race().
>>>>>>>
>>>>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>>>>> response. There are examples of checking if the deferred list is empty
>>>>>>> with and
>>>>>>> without data_race() in the code base. But list_empty() is implemented like
>>>>>>> this:
>>>>>>>
>>>>>>> static inline int list_empty(const struct list_head *head)
>>>>>>> {
>>>>>>>       return READ_ONCE(head->next) == head;
>>>>>>> }
>>>>>>>
>>>>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps
>>>>>>> not
>>>>>>> sufficient for KCSAN?
>>> I don't think READ_ONCE() can replace the lock.
> 
> But it doesn't ensure we get a consistent value and that the compiler orders the
> load correctly. There are lots of patterns in the kernel that use READ_ONCE()
> without a lock and they don't use data_race() - e.g. ptep_get_lockless().
They (ptep_get_lockless() and deferred_list) have different access pattern
(or race pattern) here. I don't think they are comparable.

> 
> It sounds like none of us really understand what data_race() is for, so I guess
> I'll just do a KCSAN build and invoke the code path to see if it complains.
READ_ONCE() in list_empty will shutdown the KCSAN also.

> 
> 
>>>
>>>>>>
>>>>>> Yeah, there is only one use of data_race with that list.
>>>>>>
>>>>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>>>>> deferred list").
>>>>>>
>>>>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>>>>> that it is not actually required.
>>>>>>
>>>>>> If not required, likely we should just cleanup the single user.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>>>>
>>>>> Do you have any recollection of why you added the data_race() markup?
>>>>
>>>> Per my understanding, this is used to mark that the code accesses
>>>> folio->_deferred_list without lock intentionally, while
>>>> folio->_deferred_list may be changed in parallel.  IIUC, this is what
>>>> data_race() is used for.  Or, my understanding is wrong?
>>> Yes. This is my understanding also.
>>
>> Why don't we have a data_race() in deferred_split_folio() then, before taking
>> the lock?
>>
>> It's used a bit inconsistently here.
>>
> 

