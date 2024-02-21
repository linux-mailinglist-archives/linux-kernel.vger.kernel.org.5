Return-Path: <linux-kernel+bounces-75135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E37B85E3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C912BB242C6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816382D9E;
	Wed, 21 Feb 2024 16:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNXbIvGx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDD82D7B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534153; cv=fail; b=r7pVCeU41AnDzJJHylYn9rQnPHpsr2UX1UmX7m6l996t0vMsc1ELa/dDRELVI9QPIYW3fljVYHyy6onZFvqNxyxz9a85RT78BKpZ9ALxOvV1MNIWJemlrIwwI9oyhNZWaGVrPniAGc0AoDuM3cZqCxHTSrvPaT7txx05qmTrGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534153; c=relaxed/simple;
	bh=7kkWo4MCHBmyINZZ/e6AKO8rSWxNIeLYm7nhOivHbdM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncoKWrZ/oNrp6gSxjqoJWKV1XwhxEK2bj/j1ZtybLdV3sFuVz7u5YhxZyR+xR9Gr749SamYFe/k6xuzTuGqkYIuHM8tPx+fZvCnf20nRkDr6n0kn8pnXREvt50gct+zNrD3I59w1ICkwdk23a3J9f1rT6arSiziNvEogKLueRVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNXbIvGx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708534151; x=1740070151;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kkWo4MCHBmyINZZ/e6AKO8rSWxNIeLYm7nhOivHbdM=;
  b=PNXbIvGxOIT+yDBuUaQScqojpuYHo1k4p2PAwHYeLrKUSDo9nhXMwwyZ
   I1A0Z6a75m3ClUBr3o+KKO3PuuFk3+cKWxEPcEpDXX46FLVdjeZpo6dhM
   RP3XtmWSVM9Fnqw+UdC8DQ30krMJPrSNEniKDTkXUaUUfmyZV0cNJqhK6
   Ghy7tBasCGO//v+DNCUzmixV29K7bTPLSncn3UKref0frSrwN1fOpir/m
   gyLfZOuQVgOFmKKfF1warqvW1F7LMmiSjWtnaIDr8wSaGcfMOFGwKOzFt
   d6gqs7Sd9xUDoZEY8K0ruy9RozqpKrYjXisdMwtSJqzGeQFM6REo3BoGu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6480586"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="6480586"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:49:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5128342"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 08:48:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 08:48:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 08:48:50 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 08:48:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqj/QkOIi4aFiRCaAkkbdd5EkXQbMxI80obCEILuRlNPGmM4NLqhPYVUcppORq9DdfmisJ3L8mwjjXkJkPgkTZhMvrzZoq2ub818OWrTjIXvwViC7vTN2FMENT+DEhQjjtNABg1/0mu3kldRTdAYxsuTkrEhTY0ysPyRA6mpiMNxIG5oITwmPRWn5nKYrCScOFk88rezMketfOqRNVBxhviq0ZgmaMa3kZWOyxUI0qjy86n1F86XnIHuxHPCiglzd9wuqe/5zfCAR+VYWtNpSFLzIUhBpmbCvNH13rFC9N+9WdGxq8X/vIsHTpMpjkJfUUU0KfNld3wQTNKRB4eKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA24U9yTHgIc1Ac1GbhL6QElXXUB4l3QpgXvjLk6yUM=;
 b=GVkE7/ISVd/GmcxLThO+8XvlHXF6sHrXOxa9sHSZP8Zqi6sCwo+Ay9lx14o3V8X6sKKsFTDT1F26su0N7nSXfcc6L1e2VB2BkGa2eMZeVzVnteHYc9na362CecBFTFQUINQqE2yVW9gFYzwzUQ6OuMiYHsgGT+ADreI0Ligakv5zkN8PsQethvY1opFwqgzzNDAmLPwwf17jy2NiX9CLWJCTx58CX0oUKJiTv6YjYEJFuTdtobgS/UMkoArhWspegES6EvS8HvBY+CFydVYQI5ji1DTL2c2o3vcdx3eyMriMd8VTFJBgDSkqVDjTIWL+QnRQ4PE9KUmv/ed8oRYJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 16:48:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 16:48:48 +0000
Message-ID: <3c132975-a516-4386-8b60-35b5f600f1ab@intel.com>
Date: Wed, 21 Feb 2024 08:48:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Content-Language: en-US
To: James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
	"Thomas Gleixner" <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <e4dcc9b4-afa0-46c7-988f-19fd7509e608@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <e4dcc9b4-afa0-46c7-988f-19fd7509e608@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:302:1::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 159a1546-71ce-43af-3a13-08dc32fcf9a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I1+NeRvZE7TEWOZiS57C2jWIkAQyWdvXlKlI9CfU19yW9mRI2EOhQnXNcfS2E1kLMRUkqKh5JoyKNQN5bxtPy0LmkMS33jGpz7209cmiylx//G/GtQpRta5OP08sE0am5MSJLV5wuqVgNGFaTM/FcLmBfReRYR6A5mIA0evpOHEe8zMEmwSm+gaEz8QFrzdf3iUvM8oJMKSfrek2vevd4oa2QyKwMHJuW2A9DY7N5beonSLqfud0Xw98NSawOUyhjRWVEf5/ctCZBMLU7B7/MQ8vkJd/9p0EHQ78AcCnXlIJ0tAJTubvC4S7xPyCjSfv38dgatPFHzylHXshXXEnPZtYeLAo0O013N/WybxLEjFhJLuAD23ZWo8V2viEaH9p9S8lq0AlIDHvKo07kAFSuzZo/bKzCH+TlHM9aNCFw0FDtU3J2DYnBAOqRVP6boufgwjs3CCjKOYHoIo9lPSdR0A7IZu6n7rtyTKxkpbiWyuI6a8rDUTNjGSGJuaGjKVtjIq6Q/plVY+96YhU/JKmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzIxdVpnejNYK05WaWN0ZE4yQkRrY1lSNHEzK0VMRHB0NE51Y1dJOHY4eWVE?=
 =?utf-8?B?cWt4clNUS0lCT2phUFl2UTNYREh0b09lL1RmSGNXZkI2NitkSlpsTk9kaFFL?=
 =?utf-8?B?R0hZOGx3c2N6Yll6bnFKM3JQakxXUkZjS1dsd2hwODBVd2FDRjJqeS9iSXNq?=
 =?utf-8?B?RnI0Nks0UjIwdW40REdXSjg0Q2premp4em56TlJLQ0M1dEdKWkhNa3JEQklT?=
 =?utf-8?B?QjRaRTN2ZDJMUUtGZW5OOHVGaS9kdHdadTNLWGVVeVA3NGd3djU2ZVNKbkZU?=
 =?utf-8?B?QkZrU1hOS1kxa3pGTVplcmk5UmdEVG5hQzNVT1RvOWI4UnYxaVlhTUg1ZEJX?=
 =?utf-8?B?dEc4ME91clRYQWV0U0M1YlVMbU9FeGg3YWh3QTFrRmgvUng2TzVXazJmSmZP?=
 =?utf-8?B?bDZCNUNQSWk2cnNxMThIZUVUcnF1M2xVK2xHdlNib2dlTGZDTklhNG5mMW02?=
 =?utf-8?B?TG56RHAvb3cwVTZXVThnUjM3WDR5azZQLzFnOXVmVVJKdVV5S2lZK0NzNTJK?=
 =?utf-8?B?T3ZlM2JuY2xZcUI0bkN3UDErSFU2OUN4VUlHNHpTWnVGK3hCcWpkWmxjR01N?=
 =?utf-8?B?dEVUTEpVNmErMko1ZUxTYkJmaEdyZGM4NTIwdkFXWGx6YVRNd3NLWDEyYS9r?=
 =?utf-8?B?Mzk1MjYrcTE4aEx0NEVEcFpTdXk0aDNjWW1nOW5KazZ1d3ZFcnJROW03aCtS?=
 =?utf-8?B?aEwzYzFlS0RodWcyYTRDWUp0Z3JsWStuNHAybFdIVWZmRW1SZVVNelk5TnpX?=
 =?utf-8?B?N1pJMWNTekVzaG9MTGI4VGp2SS9sV3VWWFFNNEllWGZpeVpKM1hsaVZRZ1Z2?=
 =?utf-8?B?cUg0QW5kcXRmK0Z0dUxVREV2SzJmZldLSUsvNnlidnhIV1MyNC8zd0FZbFFH?=
 =?utf-8?B?WFBIUlhZZzlKUWIvZzRMMjJHL1dWbjZpSzA2MGdOU1ZVM3BKZ1o2VE9Da2ts?=
 =?utf-8?B?aUoyWncwc2tFV0ZNVXcyR3FWTkJOVXJFNDN6TnBhYVRVZVRsbWpEc1pVN1JU?=
 =?utf-8?B?UC9QSE5YakhBSWtaL2JEeVhGRUlxdVNDRmZxZWFpZWlxL3FrczBWNjZKdkpu?=
 =?utf-8?B?K0lFNVhLKzZaMWZXd2dQdkNQWFRBMUo2OFZsRVNiNkJzb3hzZnJFZWFZY0Vl?=
 =?utf-8?B?NllyNnRmbkplRFNhQUFRa3dDcnV6ZWZKUldFazNmUHNuV29vNFBxb0dYZWxq?=
 =?utf-8?B?djhmcFpUQ0VrbHAzbGU5UGJPTjdsRHNyQ1FPalVwSnppRzBacWlGa2RBOHow?=
 =?utf-8?B?WXM0QUREV0xxZjIzSlRhaUlZcUphZ2hSTU9WWlFWT1VyTFcwY3lGeUxTaCtZ?=
 =?utf-8?B?V3dmWFhaaWVrNUxDZFArdmw4djVBSE5iUzdzMVAwRFlkMEFvdlp1d0xxY1hy?=
 =?utf-8?B?dzVBUzVNTFloZC9QUVRiZFQ2ZWttZHkyVW9YbVBGY3lEbWpKdGZtSHVHcXlN?=
 =?utf-8?B?U1pGZmVHcExwZWZXUURYV1dWdXZ2M25FSFpmY2tCSXlwQ2xLemVWcnhqa3R1?=
 =?utf-8?B?T0ZOdVJRaDcyeDFZTUhhWTFkaEk2d295U2xIWUZ3M3hiWWJsTGtnbEVjNjJu?=
 =?utf-8?B?WnEzMjA1R2I4VGlZT00wSWxDM2JoR2x1dS9HbjVRZm0wL1drTnFQUS9PRWdI?=
 =?utf-8?B?V0MwczAvNHY2QUpya3M4VzR6ZThsU3BlNU5idlNGallWYmlpMmJyRHJPYVo4?=
 =?utf-8?B?dW5hLzJiTFdMNWNYWU1SVzdyb2haWlZ6cy95a1hmQlNFYitVVXp6Z1N6bi9D?=
 =?utf-8?B?dW1vMHI4RFNtYmhkZnlwU3pra2E2UUZhTEpCV0l0YzlzUmMxSWNOMENXdThu?=
 =?utf-8?B?WU1BOUNYSWJTMWpEcFZLczJuMjg0dHRudGJwbzFJUnNiTmNjZjJ0VzMwR09N?=
 =?utf-8?B?d0tTMmZZYUVDT0JFU0RqZ0xCK09WWjBrTmQyM0hyRHpxWTU4YWREdXlVUDFl?=
 =?utf-8?B?dGt0YmdmRUc3bWgzSWhmZlZid3NDNmFjS21LeGpKSzBvVjBmZ1V2RGs0ZWxX?=
 =?utf-8?B?WmdsVTE0VE5XVHFBS1hyV0JObTYzeTFFekxhM09udzJJWEUxYkVvcnRWaTls?=
 =?utf-8?B?K1p1bXlLTDl2N3VTakVzbGdOanB0ME52RExoQTdRVHM1MFAxQjVMczd0R01q?=
 =?utf-8?B?Q1A4ZXVvQ3AyVzdzWHBkK0VoUWxDcitDcENuUVpMY2o0a1JOQUg1WlRTWU9T?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 159a1546-71ce-43af-3a13-08dc32fcf9a2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 16:48:48.2450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drSoCD3w4hlDej3zfPTcSWcOCBoSmqNLLTQzFRfRK2hcgx5keWBfHaLCPDmW1SGC3QpjSkJEAFaU+ebaw847iAINTqTwNrZWihdkqrzRfrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com

Hi James,

On 2/21/2024 4:06 AM, James Morse wrote:
> Hi Tony, Reinette,
> 
> On 20/02/2024 22:58, Reinette Chatre wrote:
>> On 2/20/2024 12:59 PM, Tony Luck wrote:
>>> On Mon, Feb 19, 2024 at 05:49:29PM +0100, Thomas Gleixner wrote:
>>>> On Sat, Feb 17 2024 at 11:55, Borislav Petkov wrote:
>>>>
>>>>> On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
>>>>>> Hello!
>>>>>>
>>>>>> It's been back and forth for whether this series should be rebased onto Tony's
>>>>>> SNC series. This version isn't, its based on tip/x86/cache.
>>>>>> (I have the rebased-and-tested versions if anyone needs them)
>>>>>
>>>>> The set applied ontop of tip:x86/cache gives:
> 
>>> Testing tip x86/cache that WARN fires while running
>>> tools/tests/selftests/resctrl/resctrl_test.
> 
> I evidently need to build a newer version of that tool.

There has been a lot of changes in the last few cycles. You can find the
latest version on the "next" branch of the kselftest repo [1] where most recent
enhancements are queued up for inclusion. If you are interested, there is one
more series [2] pending merge to the kselftest repo, it adds a new test for
the recent non-contiguous CBM support.

Reinette

[1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
[2] https://lore.kernel.org/lkml/cover.1708072203.git.maciej.wieczor-retman@intel.com/

