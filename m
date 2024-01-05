Return-Path: <linux-kernel+bounces-17415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E5C824CDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9B028696B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74545443E;
	Fri,  5 Jan 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OctYVJJB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFBC4403
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704421241; x=1735957241;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=t/PEUu5pkVsFayLoQ7HbCYNhwv9BsrfMXx4c07WgFRg=;
  b=OctYVJJBbvZ1TjQd79AQjDr3ZWu2ZOqBNA/PPXxlSSrHq2l6f6ZIbJVi
   Ua88O/4MHhYvT5CYliUFPBI3QKd9GR9wB6e6jngVCszIU1RsxUNIwYSr6
   kJ6E7HEXlowI9uwSTpSOsWZy3Yq745A86OQUcOCBT4gYxbFKJARSBUM9H
   u6KxEu4L9WA79476YW0EMOz6xll3Z3lHMKeAfrjV7On4ENN6kQbHOe0sn
   KJG3sMothXbZ1eTOXIrrcUR8rSLcE9pwR2zZ3OTTGZ+lUJRPBr1xm8C9X
   1CfmabI+9dbtMEHTUNl+0MarPfUPu+ZeFeNUNWQNLQUvDNjqqCz+owgmb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="376904879"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="376904879"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 18:20:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871115637"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="871115637"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 18:20:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 18:20:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 18:20:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 18:20:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 18:20:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edgG4cuGZT2qE8JiMX+4EiMilFEJOFaFmtv0hbz5jYqy2x/d705hSy5JrlFmRdKr8usxJWQH4S7HAaw3tcn53+Z5by1UMcKZeWvOOe9IvjSdd+fo511qO3axvl/76Yrgs9OroyiiAkXeqG2zKmr6VK0tTLIgOfupcnD+kFfecwNTOO1llItJk+eMLdnJoiH51KwF3D4Ur/Foxj3x8/zPVVjko678XJwgGtxeh9QaDSE02IbQqV4RTbcK+l0WToXUoTFCdRZ/FLuL51S3WHH7dVyAS/L8wVLUkSIrQk8e0L5Y1VV7/2rbbGt2u2aGbYrQkw6ZegfwzBSa3IeiGCTSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGS4iVkUlKYm0SdJ0N8DQO29pXeorwv55vd23vJeo3A=;
 b=bAHFDFQ+VYrSeUZmVXB1c7NbLGQ6GpfFkgdO+e90J5cbcX62Jcsa26I54Tq/zS+jzlM8MS0c5Z97kqyaKA0ZRcw9Aut3+ecgy6ryxX2Q5gaq+tArVpCd5z4aVepT/ZrrO8KH3px6s2C4SzIuaL+RSG5DIJrtrOgoU70/XdhkD2ax1G5k73I75VRqeW+derEO/Murlot6cOFLvQjulHfBdGlEhq+ORZHxTTZGz1CZuEwf+J1Kp3InI7p+9OFhgAebAWuo6nYqa5VGIUYg8ytbuPx0Kk+74wwi3d6ybmPX/Eq0ameifwDbiYTdx5IzTYR2HP0g/ppUNNyMSmAaHaV6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA2PR11MB5180.namprd11.prod.outlook.com (2603:10b6:806:fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 02:20:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 02:20:38 +0000
Message-ID: <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
Date: Fri, 5 Jan 2024 10:20:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, syzbot
	<syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <ryan.roberts@arm.com>,
	<syzkaller-bugs@googlegroups.com>, Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA2PR11MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b36ab9e-2070-4f70-8307-08dc0d94e7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xhKqik+RXwuHu7/YT4Tujv175AiQHUxeLMED9IFx1ZaSeoqf9TSuxVUgMOIxocyeU+7prkJtTlqAWVTu68XzbLTCuGx+im4IXY5/dzbZSW2KfKHXDFx0EwMScyjbOw5svsRxZfTYLDTZ0hGgz+4k23hedit2cpD0WKQ92KZv/yuOaID3jXLgt7aGUdO36CuiLs7gv5o7nEWrP8JAUDRie8u8l/Htck4Iu3hY5sAXihWUDKzrfw7+FwVvgh4SDhSxS1xaHO7acx7DafM5DcpS5V//yRh1L82JkJUE4EADMCI+v+NAeh/dq9sDfedQPwpQpgf0+XuAy4HIqwpjc9STigYkm4RXY3jWvT0FdZkNpLdnxknPHTCEwe6aEvlVPLjI+jopKBQKAHqLR+AdF9LdIj+OmnrOAB3fvviLmtJ5fgB/eAoy0Lp+LV19+kioYFLm2P/cEmu3uVcT6jIcsjEwibSyeKMRfsSzA++IK7SMh1oNPfo8RuqSNOfBqZv3peS3A0HxJwCzLc8/l5jqMohgRuAzJWAGICWey15O6TU+cogm0Qj1YMc4mQy7hDkWA9aQaEETD35FHUzt3f93LFYP+DNFVLt71R329QqGeU9kYdqZjemaZsMwefnwR5Ol9uguFeGUZ9BuQZp6AmBUASGKfronFKllDGyHzrGwHRzcvH03VPFjxpzSGt5QQQFHO8ov4s1/MGfFordQptZcLSa7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(45080400002)(6666004)(966005)(478600001)(53546011)(66556008)(6512007)(66946007)(6506007)(66476007)(8936002)(8676002)(110136005)(316002)(6486002)(26005)(2616005)(83380400001)(41300700001)(5660300002)(2906002)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmkxQTZWeEpkc3d1V3BWakhiS3BzempDK2pZVjF0cm5VRVJwaFdXaWE1VDFl?=
 =?utf-8?B?bldjeGhobW93Mm90Lzl1VThLWEFCYWoxVEEycTVjdUxZbzBXUWh6TXZaZmdI?=
 =?utf-8?B?Y1pKTmNjWXVSTzB1SEFCL3JBRnZTbE5Gd1BicUZydkUxYU13dlRvc1Y1dG5Q?=
 =?utf-8?B?b2V4eUVDZFR5REsvbFFSREw5K3NQUnRSK0M0NTlrU0tuUkxPb0dXVE9RTXNV?=
 =?utf-8?B?am9FbnpZeE51YUJEVGFkUDR0U0xvNHYxbE8yTFhHUDB2cjVUR1NBN0JUZnlV?=
 =?utf-8?B?TGJvbVNrQU5oMG15MXJHQWo2SmtjRXJYd0l6dHVIODg1M3BFWXc5ZmhkQUNH?=
 =?utf-8?B?cU1PdTdIdlJhazZiMWJSdm5NNkMveUFFV05NM2d2bUxJZ3U2Rk5lWitlb1gx?=
 =?utf-8?B?cVVyZXBZZFMvYlBtVFBZUjNveC9mcGhjbnRzWHROM0xzNkRrMmI0NGZQbU9m?=
 =?utf-8?B?VEVKdks3SmdXMk5GT3hkQ2ViS0NJUUdISFJYZHRJWTB5UEJ1azh5R2gzODJL?=
 =?utf-8?B?WXVGTkxoYW03R0ZOdTNHaXpwRHZJdC81MnFrcmoyeE9lcTVTSUJCamQ4em5r?=
 =?utf-8?B?L29QRGgxR25va3g1Mld0bWsxbUtQN3hZV1Bsbi9ENlE0ZW5tRDFKUlhjRmFI?=
 =?utf-8?B?Vmd2TWZ4aGpLQTNrTUFrK2szTXBCc2NHRG0rRnk2RnFLMWs1Ly9ub3hZYVRR?=
 =?utf-8?B?aUMydUJjdHpWdGhEYWlEbEdpUG5uUGpLcjJVN2x3NTQ4dDBrOEY5K0gyRGVM?=
 =?utf-8?B?aEtiQjNIL1JkU0tNNHUxQVNYYW5zNDhXVjA1cytOQ3ozc0Q4NHcxOUYveStt?=
 =?utf-8?B?djVPZWovZmkyVlB2VUdxbTkvc3Z2VDhJeEMybXFvSEVtYlNpNE53NXlRWTBi?=
 =?utf-8?B?c2NkK2hTcUcrb28yNnVpUHBrMjdBa1JoOE1sY0JDYmcwTnZHOENmYWpkNmcw?=
 =?utf-8?B?RktMVUowdVRIN0MzWDNiU2lEenduRkZ0TmlFQnVwSjliQU4xMkwrQlNpbTZl?=
 =?utf-8?B?VDlzbUdlNVgvcmlmby9SYzkyUU42Ym05MzJ3MjVnaDhEL0FFcE5SQlJ4WjRq?=
 =?utf-8?B?bTVEQjk4b3pGY3dLRlBMMk1TY2tEYWQ0dFhnUDRUNmx4ZHA1NHY0STczMXZZ?=
 =?utf-8?B?UU1ock16bWNxYUhKdVRCOHB1WkRjNjVoeGttR3lhNTUrZGJnWlJhcEh6NDFy?=
 =?utf-8?B?eHR4clNLQnp2SHZ5aEV2SWIweHpiNVNMaU9iSktNRFhYaE03YXB4ak1BSy8w?=
 =?utf-8?B?YnoxV0dBK3NGK002OW9oL2wxU1gwaERuQnlsOC8zREpUYmsyY3BUM2V4aDha?=
 =?utf-8?B?aG9sL1RhVFBmQ0w0dElSTlBmN3VaTHV6dGlFRkxwOUFQNjNsbmpreWxPZ0wx?=
 =?utf-8?B?M3I1V0p1SWRYb1BaS3FrenF2eTZEQyt2YmNwUEVBVzFVaU5RblM5NUlFbjJ4?=
 =?utf-8?B?Q2w3NE5pOU9tS1dWbCtMOEZnU0lHN2JFZGdONlhJT1FpTjl3eFg2ZE1uMWF4?=
 =?utf-8?B?NTF6TEhERHdudEJJYytuUjhWWXBLYVFEOWoxa2ZVU2IwT1BBZ2hkbVY5Z3Rk?=
 =?utf-8?B?SERnRzFKVGcrTjB5SWZoa1E3QUVodFg0OGErTDl6a3hLM0x6bU90azhoZjFh?=
 =?utf-8?B?UExRdGRCT0syWmhpNjdNYmE3RHEvVG1SRUNDbm1pUHpRSUMrVHFPZ1VKTGVD?=
 =?utf-8?B?SEl5b25RTTVzNWRZVEdMVlZIYVVyZE13czVrWFo3a3hRVGpLdmM5S3JPV01I?=
 =?utf-8?B?RitBS3dwWUdtQmFhUkhiZ0o2SGhZMmhBa3BZcHduOW9Ta0tqSUJNQXJBWG05?=
 =?utf-8?B?cEwreEZzVUNWT21jS3M1SklycVJ2NTBFd2g4QVh6UmpEN1lTMU1ubnoxdm94?=
 =?utf-8?B?L2FJdndVU1h4N2Jxa005K2dJQkMwTXdhOGpTbE9UcmkrNGRLVFZhNUIxOWNS?=
 =?utf-8?B?Smg5eXdpOHBzL2IzMXVjaGl2cjg0dmEyQmFKZk1PZ0RaVkwrUFNZZFB2VnIy?=
 =?utf-8?B?bnptQlhRUG9haDN4RFZ4bGphRmpvSUVCekU4M0dkZHNaUFVhM0lHaVZLTzFG?=
 =?utf-8?B?RXo4K1l0RDQyOTJ1WmlidnhtRG9kakhLUzZhRUcwRWk1RVdUUjhPOXBxdFVU?=
 =?utf-8?B?Ulk1T3hTTlpUMjd6U2hxSDQ0N3Qxby9DV0ZBZEtSaGVaVm16c2ljNStkaVFk?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b36ab9e-2070-4f70-8307-08dc0d94e7e4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 02:20:37.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQNiuG+bvtlSHLOSrBHzzQrb+jHk3TsFvYNoXavrjF11VuUdhjSCQ1wJFCH58jsfNur25BmkyArkXUuO4gXrOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5180
X-OriginatorOrg: intel.com



On 2024/1/5 05:36, David Hildenbrand wrote:
> On 03.01.24 15:16, Yin, Fengwei wrote:
>>
>>
>> On 1/3/2024 8:13 PM, David Hildenbrand wrote:
>>> On 03.01.24 12:48, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot found the following issue on:
>>>>
>>>> HEAD commit:    ab0b3e6ef50d Add linux-next specific files for 20240102
>>>> git tree:       linux-next
>>>> console+strace: 
>>>> https://syzkaller.appspot.com/x/log.txt?x=17be3e09e80000
>>>> kernel config:
>>>> https://syzkaller.appspot.com/x/.config?x=a14a6350374945f9
>>>> dashboard link:
>>>> https://syzkaller.appspot.com/bug?extid=50ef73537bbc393a25bb
>>>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils
>>>> for Debian) 2.40
>>>> syz repro:
>>>> https://syzkaller.appspot.com/x/repro.syz?x=14e2256ee80000
>>>> C reproducer:   
>>>> https://syzkaller.appspot.com/x/repro.c?x=17b57db5e80000
>>>>
>>>> Downloadable assets:
>>>> disk image:
>>>> https://storage.googleapis.com/syzbot-assets/4e6376fe5764/disk-ab0b3e6e.raw.xz
>>>> vmlinux:
>>>> https://storage.googleapis.com/syzbot-assets/7cb9ecbaf001/vmlinux-ab0b3e6e.xz
>>>> kernel image:
>>>> https://storage.googleapis.com/syzbot-assets/2c1a9a6d424f/bzImage-ab0b3e6e.xz
>>>>
>>>> The issue was bisected to:
>>>>
>>>> commit 68f0320824fa59c5429cbc811e6c46e7a30ea32c
>>>> Author: David Hildenbrand <david@redhat.com>
>>>> Date:   Wed Dec 20 22:44:31 2023 +0000
>>>>
>>>>       mm/rmap: convert folio_add_file_rmap_range() into
>>>> folio_add_file_rmap_[pte|ptes|pmd]()
>>>>
>>>> bisection log:
>>>> https://syzkaller.appspot.com/x/bisect.txt?x=10b9e1b1e80000
>>>> final oops:
>>>> https://syzkaller.appspot.com/x/report.txt?x=12b9e1b1e80000
>>>> console output: 
>>>> https://syzkaller.appspot.com/x/log.txt?x=14b9e1b1e80000
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the
>>>> commit:
>>>> Reported-by: syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com
>>>> Fixes: 68f0320824fa ("mm/rmap: convert folio_add_file_rmap_range()
>>>> into folio_add_file_rmap_[pte|ptes|pmd]()")
>>>>
>>>>    kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:283
>>>>    __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:324
>>>>    kasan_slab_alloc include/linux/kasan.h:201 [inline]
>>>>    slab_post_alloc_hook mm/slub.c:3813 [inline]
>>>>    slab_alloc_node mm/slub.c:3860 [inline]
>>>>    kmem_cache_alloc+0x136/0x320 mm/slub.c:3867
>>>>    vm_area_alloc+0x1f/0x220 kernel/fork.c:465
>>>>    mmap_region+0x3ae/0x2a90 mm/mmap.c:2804
>>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 1 PID: 5059 at include/linux/rmap.h:202
>>>> __folio_rmap_sanity_checks+0x4d5/0x630 include/linux/rmap.h:202
>>>> Modules linked in:
>>>> CPU: 1 PID: 5059 Comm: syz-executor115 Not tainted
>>>> 6.7.0-rc8-next-20240102-syzkaller #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>>> BIOS Google 11/17/2023
>>>> RIP: 0010:__folio_rmap_sanity_checks+0x4d5/0x630 
>>>> include/linux/rmap.h:202
>>>> Code: 41 83 e4 01 44 89 e6 e8 79 bc b7 ff 45 84 e4 0f 85 08 fc ff ff
>>>> e8 3b c1 b7 ff 48 c7 c6 e0 b5 d9 8a 48 89 df e8 5c 12 f7 ff 90 <0f> 0b
>>>> 90 e9 eb fb ff ff e8 1e c1 b7 ff be 01 00 00 00 48 89 df e8
>>>> RSP: 0018:ffffc900038df978 EFLAGS: 00010293
>>>> RAX: 0000000000000000 RBX: ffffea00008cde00 RCX: ffffffff81687419
>>>> RDX: ffff88807becbb80 RSI: ffffffff81d06104 RDI: 0000000000000000
>>>> RBP: ffffea00008cde00 R08: 0000000000000000 R09: fffffbfff1e75f6a
>>>> R10: ffffffff8f3afb57 R11: 0000000000000001 R12: 0000000000000000
>>>> R13: 0000000000000001 R14: 0000000000000000 R15: dffffc0000000000
>>>> FS:  0000555556508380(0000) GS:ffff8880b9900000(0000)
>>>> knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 00000000200000c0 CR3: 0000000079000000 CR4: 00000000003506f0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>    <TASK>
>>>>    __folio_add_rmap mm/rmap.c:1167 [inline]
>>>>    __folio_add_file_rmap mm/rmap.c:1452 [inline]
>>>>    folio_add_file_rmap_ptes+0x8e/0x2c0 mm/rmap.c:1478
>>>>    insert_page_into_pte_locked.isra.0+0x34d/0x960 mm/memory.c:1874
>>>>    insert_page mm/memory.c:1900 [inline]
>>>>    vm_insert_page+0x62c/0x8c0 mm/memory.c:2053
>>>>    packet_mmap+0x314/0x570 net/packet/af_packet.c:4594
>>>>    call_mmap include/linux/fs.h:2090 [inline]
>>>>    mmap_region+0x745/0x2a90 mm/mmap.c:2819
>>>>    do_mmap+0x890/0xef0 mm/mmap.c:1379
>>>>    vm_mmap_pgoff+0x1a7/0x3c0 mm/util.c:573
>>>>    ksys_mmap_pgoff+0x421/0x5a0 mm/mmap.c:1425
>>>>    __do_sys_mmap arch/x86/kernel/sys_x86_64.c:93 [inline]
>>>>    __se_sys_mmap arch/x86/kernel/sys_x86_64.c:86 [inline]
>>>>    __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:86
>>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>    do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
>>>>    entry_SYSCALL_64_after_hwframe+0x62/0x6a
>>>
>>> If I am not wrong, that triggers:
>>>
>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>            !folio_test_large_rmappable(folio), folio);
>>>
>>> So we are trying to rmap a large folio that did not go through
>>> folio_prep_large_rmappable().
>>>
>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>>> suspect it's simply some compound allocation.
>> Looks like:
>>    alloc_pg_vec
>>      alloc_one_pg_vec_page
>>           gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>                             __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>>
>>           buffer = (char *) __get_free_pages(gfp_flags, order);
>> So you are right here... :).
> 
> Hm, but I wonder if this something that's supposed to work or is this 
> one of the cases where we should actually use a VM_PFN mapping?
> 
> It's not a pagecache(file/shmem) page after all.
> 
> We could relax that check and document why we expect something that is 
> not marked rmappable. But it fells wrong. I suspect this should be a 
> VM_PFNMAP instead (like recent udmabuf changes).

VM_PFNMAP looks correct.

I do have another question: why do we just check the large folio
rmappable? Does that mean order0 folio is always rmappable?

I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.

There is not warning because we didn't check order0 folio rmappable.


Regards
Yin, Fengwei


