Return-Path: <linux-kernel+bounces-64522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B662853FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2841C27E51
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A863109;
	Tue, 13 Feb 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBZMNkYQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B051A63099
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866088; cv=fail; b=g88QNiLayVIOJhFGttjL0Z//dlFwmJX/3pc12YUx8AN71w+rXFeqPm/nLq8v0Qagf5PM9cP2bAcpUTG1zdISvEIhxQ1pzpdUt7tXLHiD9ow2Ka+PpwvyICXpvaW0KzU0/LPSYDgqdw7DfdCV9i+ROE9S0UT1cyDwtmvmshzhgeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866088; c=relaxed/simple;
	bh=YvC7JlYHBpEx6X6PpIAKlPKJCDT8EdjJYBV6Zr+y2fU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ItilqPp236hOgUPAK18oSoTu+VZGhCvCH+y4dNVz/izOKfnzzSxT3IVeiunbKtocTKcxFawilXnE02vAlMbccAQyT8AmYQ5mUOpoLt2hdAsaN9KoHCTNQLnERpcWgi+foWZcDyaM2s/60qLDGT8ArpX09SiynYPLq8YSd4fp7tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBZMNkYQ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707866087; x=1739402087;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YvC7JlYHBpEx6X6PpIAKlPKJCDT8EdjJYBV6Zr+y2fU=;
  b=MBZMNkYQbh9T3DY6THaDAyAWvwOzF7UPo4qxighey5gDco8gCxlcpb/T
   rxFgwbEKbqRqfZEvurdnxWyb9FoG/NtQh9+cekwny0rwj/Ai3t3s73i5+
   peROsm2gixmFGrasUvY9w2taY2pbPwWeq2qlMxQBFTouvTjZU6mALYEMw
   UHz2dt+ax+B17l28NdfST+sgbXB/oFMo/iUDbRZWgg5qH/aGyBBBSK7kq
   c1a459EhvExUfhPWeFZcQFJuQ/1Vsru2d3azCYKBrOl/jFgZhSnKvpCDt
   wTpesbcG9JNJnYxqaYl7Zc2VMoEHP5/tdCJr+FV7IaZPA8tvMhxNtdTQD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5732494"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="5732494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 15:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="3194445"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 15:14:45 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 15:14:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 15:14:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 15:14:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGzii6XtBq5Atg8dcKlKY/KHIX6u1hKwJSjLHIe/ysP5NovbBsEO8l4h9VGQMbNWA47+eddbCQQG2B2ck1ZXGfNL3cTICHwF72Bbpt5dChf1ku5BqKzi8TCFbMSdai93Aw1xmhwnUoc8hc/U7vUDA2cNOJviVO7CdftbdbxG+WHzcD+zA6Er/cd5pWH5ZqPN7OH9YRpsITe/teFDNQwwRmXkG2wsx/0VT9CDJ4YA1E82qYztBYOq6rIHEfKuIi4jRL9iIc0rubxkzpcCS5ftQGhEpDh0EZ5c94QT9saVwl5joMkENN4hq5ctiF9DmQhd7S44w0Xm6GrSMK3ldAEXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y01/TdhJs3Zu8XF1CqjRXPdmUbJU/Fnj20pfl3HpM/Q=;
 b=G53mKDQn0VIbunQLlL6HaKtfnhwT4KXguJzRkWw91+d3rJJYeMajEh+qDHyfkdEg3Q2uKYEqcFhtpZ9oymhiBTYrns55bhhhyo5FmMKJ/khUrgrLKDuKbpR3LUkqnmVxZ1zJf7HC8GlJJSJKC7tQ5l5q2Qz7rLWCy7JdCXMR5piAd2hspQYDEZhZVJu11vvvzQHk2KZXJ7OZz7WqpnQjBU0/tlJHr2QCFHpnllvJbdImJqyzXwj1+Zv4aBiXrAJYxvsW+A4qvCh5q/6LjgGFHzY+FxbevbUjuJ40QxRyuzXYMSQkbRNu7cOFyViu/Kt8S8h+aOKqAfloTSYFbMskYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6253.namprd11.prod.outlook.com (2603:10b6:208:3c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Tue, 13 Feb
 2024 23:14:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Tue, 13 Feb 2024
 23:14:43 +0000
Message-ID: <d587fdcb-776a-4464-a5e0-dc9491504ae9@intel.com>
Date: Tue, 13 Feb 2024 15:14:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240213184438.16675-3-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240213184438.16675-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef1fc4b-07e8-4127-9746-08dc2ce98fae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcO2/Cv1uTAEDf89hGCScVdan0k6CM4sj7sJ+gsSGgu4IxgDexH6wSOOVGW0el62xBbDxQQ9cX1b90+pCoSOq1h+wzc35V3fkMiG2QnpE5SqjWsJ/SwbvSphFWGqOULXhxJq0MblspXYVyZ5UbCdrJ+OsCkR9sV3JS9JbnZqWwJOKdNCVMHyf+7MWiAVbD/ad02DMejl3MqBFbBh30v1bH06hW/ISGTlc9RYQvdCWZLSCOyb77wYgPnvKjWnCINnfvs6g074eh0xbDvxpgqwTb93BVAhzC1NRtMEBuGRWXIrXfM0So9kR9n/yBSJ4NQ06qOZseO6YwfJoAGO3phuHjVLq/4bV4zcyUJ1hQELp1rXCV9ShNLanexCQyKLnrx41m6dOKbISDYzGXwa5sJSZ+OIM2FK/AJejSRTJamtNd4CRDNXCRt3EAsV2QTtvOIrT2rV3djdwUaQD6hHOMWRozPDUT5XwQ9A+98qjJcgIk/+LXfsYi/2dmENHDDWpYxGdYdggl+/8JPM8khCxr0O3Pz1bOI6ou2AiBHGeSsrBKty5jiYfEtcCyOXO9bJP4o3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8676002)(8936002)(44832011)(7416002)(66556008)(66476007)(66946007)(5660300002)(2906002)(4744005)(4326008)(31696002)(36756003)(82960400001)(86362001)(38100700002)(316002)(478600001)(6512007)(6506007)(54906003)(53546011)(6486002)(2616005)(26005)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5WOWtQN3VOVWc4UVM3Z1R6MWhIK2g2M2w2SE5IeTJpOG1HY0MyTHRQMEtV?=
 =?utf-8?B?K3dqbzhxR0ZHOFhraFpmb2ZlcUpPK3RUaFpsaG01YVdNa1JVWnZscVBuRldr?=
 =?utf-8?B?aUtaek00bkdsQ0ZlNy9WcHR5MHp2TzcyYXNaNUpURk15K3hoVUE3NDlaMld4?=
 =?utf-8?B?K2lmd2VKM1RhMzRDYit6Nmt5QmRMY00weENLVkhqaVZyVExrdGxXNlFmb0NR?=
 =?utf-8?B?cTB5U3N1RFdjcnluQnF1dERiOEJXbnJXQXBITHBkQUtpc2hCNTVEWXczOC9x?=
 =?utf-8?B?ejFjb2h6YkQyNDF4elhjYVJEdS9hR0dOSnZjMzkrckVTb3Z5ZGJoTVJvK2Ni?=
 =?utf-8?B?QnBnZ2cwM3RFaEhjZ2ZSb0pQTEpWakxvOGduMVQzdFZBZGF5bThpd1BiRGtK?=
 =?utf-8?B?dkdsa1Z6V1NOeVBpcDNPL2U4Tjc4Q3Rnd2xEZGtZanM1MThOanZEcXJJR1VQ?=
 =?utf-8?B?ZzAzOFdQQmtTQVNMcnp3WVBsT3lGNmVyQ0F6ckl6N3kzMHJYMngrdG4zelJP?=
 =?utf-8?B?am1ndTlQMUs0MHl6MXd0VXF2cVNjOGI4dW5Qb0JkWE9BdW0vVkM1ZjRlc0Qw?=
 =?utf-8?B?UkJ2eEN3QlNpS1lhNk8wVHg5K2d0dXJvQUs2ajZOSnIwRXR5V25aaTFtdkVL?=
 =?utf-8?B?N0l6bk1saE0reDRmWEh1cFMvSG5zRjNhU1JMKzdIY1RKdmx3WnEzeHNKc0NU?=
 =?utf-8?B?MUVZcEtFMk1aV0lqbXNSVWFlWlhOWXZTUDMvSjk4SjczNEg2cGhaU3oyVGxn?=
 =?utf-8?B?QzN2bVl1cWNJUFMxNVoxYm5aaVc3Y0ErUC9JU1ptNjNrc3BlRDl2YlNNMTQr?=
 =?utf-8?B?UExmTWtCTUdZSnVJSFQ4cEdvRkJZR0xTS0c4UWhlZ3M2VDFrMnNuK3Z3NGl6?=
 =?utf-8?B?STdoOGlRRDBydWlGclUyaUpqNm94L2JhSnVjSk1TT09ScTN3U0cvWmw0QzBk?=
 =?utf-8?B?YUFwTENaVnRUTWdsek5YcWNHOGhJb045cW1wZVpoa3grd1RHZjhERzU5UWEx?=
 =?utf-8?B?cHFidVN6MzlxcE5sMEhYK1c4NG9JeDNNZ0krQWZsSm1VK0Vtby9sNU9Damlk?=
 =?utf-8?B?MzRkYjEvM2ZUSzR0U1g4SXdheTkvazFmaU10QWFqb2kraVA4WjREb2FYdWpV?=
 =?utf-8?B?R3lYZDBjeDJadXFxUThXR0Y3ZGpKbkh3bEpEbEFMUEh4OW1IRlVKNzI5dTZW?=
 =?utf-8?B?M3VuZndoTjE5SVo0N0dlbHdOcWh3TUZEOGFNOEpGNEVXUHM1MHN1ZkRJbTh2?=
 =?utf-8?B?TURzRnliZ2tkZUZicFJNZFM0UnR2eE0rd0dWNDZyaXlMVkdqMXVkay92Vmx4?=
 =?utf-8?B?WjNMQlJadVRpZEtld1BZSWVTNGo5VzJTSWk5OFJnZS9Da3FWUmhKYWhHVTIx?=
 =?utf-8?B?NkRIVkZXTlNSVVorYmhTdEdzWXJGc2tDRGdkMFhLNk9jdjVhK3BWRGJGS1RZ?=
 =?utf-8?B?b0x5MTQrdTZNOWVMcmM5OXJvY2w1Mkh1UUsrSlZqK2c3M1RHUGt6dHFJUGs0?=
 =?utf-8?B?RVdHbXByblZHR0wzcklQOW9PY2U4SXJiL1pIZEt3SW83M0ZDNG05N09EMTlz?=
 =?utf-8?B?RzFUeWM5M2VGbUlUQjl2VldMSHpOWTVlS3N1cTZJSVB4QWd2RmtrcU5PNk9N?=
 =?utf-8?B?OXFBV0o1anRxek54UlRWalk2RDJqTlU5RkE3TGpGTFFtaHNOVTZDZEtvMmQ0?=
 =?utf-8?B?dDVaem1Bd1hJZGVSZFBsUnhBaGhtbVo4b3dMaHJSY3JRZTJlVXhPRFdMT3ps?=
 =?utf-8?B?WU1GN2lYbWxNNVVkVWlGZGVZNFhDaXhVMStLd2RVRHc0b3pmN3dtSkpLUlZP?=
 =?utf-8?B?QU1QV2pMbWNvYTZmd0hTazVJbitWd3dWc3Vpek91dzBOSWhCRlh5RURyWlM3?=
 =?utf-8?B?dzZlN2IrMHErUFlyZnRoZnEyRW94cVF5OGRGVmhBamJKSm4yS0hSY01IOEFi?=
 =?utf-8?B?b0dWUnZNVjJBdzI3cXhwMzVqeVhFOWYrWm9VVlhJK0VONFFCZzRJMndUYU9x?=
 =?utf-8?B?KzVkbDQxQ0hVSlgvTTlmT0IvbmlzUjBmOVF6ZnFCdlpNdTFLbDdwM3dFSm4y?=
 =?utf-8?B?amFUZUJzcjN4MkZGNjkzNStWbzVPU1pTNlZLOXFpWWlOeHpNVlh1b0F0dVlV?=
 =?utf-8?B?WmU0OEtZWVc5MlFwQ0NWa1AvQjR1WHZaOXBuRkR2UGFQMUJheGhmd1ZjT2hT?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef1fc4b-07e8-4127-9746-08dc2ce98fae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 23:14:43.1050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CZjIjP8ZPZW1fa/z+csrO63cML66HknSAQvRCFVIfz+/6z59jqUoEtAH8BzsXKcL0aZGeRPHwzDWpQea0UJ5Gy3BLIIXd4YvcgDltTlPIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6253
X-OriginatorOrg: intel.com

Hi James,

On 2/13/2024 10:44 AM, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_put_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().
> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Reviewed-by: Babu Moger <babu.moger@amd.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

