Return-Path: <linux-kernel+bounces-24102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C582B6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068A51C2429F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF758215;
	Thu, 11 Jan 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiYdRoPB"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F34B5AD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705010485; x=1736546485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eLH1GiMele3IL7Epq4+SISlRADBujFLFwfHQqNAsrOM=;
  b=iiYdRoPBpqRJbdZQUEwzBx2v1uTQ9cylC7LwOnBp/Eg/mKtsV3SrFnYX
   Kj+T2m587fJN1HWfhra+3aZ7w6J3xvnX300sLu8XxteMIEcjkMXEk7/3f
   cbF9c7RuJVd22U892Lbq+tZ/bmTgLCQHzYwf64NliwZu2k/UOGqTXozgE
   adMugIJ+5rTZfoMz7kGqugXQA70fknKjwuE8BcsfyjTLqzmdTkfKpgn6y
   AZE7MShqbS2BopzqErxWDDW3Vwi40mT25pHGnI4Y5lAC5lac49amF66gS
   PRHTxlUe5jpx2MP7sNXE9jd+RtjQyVXuWQt9HMKGdZtYymQf28sZjWCrL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="389450596"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="389450596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:01:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="24792538"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 14:01:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 14:01:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 14:01:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 14:01:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/D4zSB/OSBylO0douz4rVT3ipxgbt9cC/OzmsxW1Mk6WzSOsoVrgYH91+t1hxGF28AYpOx0YvrCVQ6I6JHJ/4EouBAZuSM7xXboycpEQGOLCA1r2WpSbGZKH0ymTN/jmHcIbBpUdlKxqcNA+53rrOk4WJFNH67tFcWILOrkn4CF/ws1ouPFbUZkNfQmQ5pPkQ351S7y0jQ3y5zQmkQYqnyrJT0HnAwj1K8hTN5Q6UVrDvadEowQoZzYPx3wSxYDjBxdy6kaz7nWH1w41ND1pJCtRQfp/uezUkugZy8Z4Jst8KZvsQQWOhtdjfWUKm99eqpiH3U59JEYXYTaH3kQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEVp8Aqt5KLR1HmHh3kqyUBBPBmzmTIa5ZfQOdjZrMA=;
 b=QvBtPe3QzViR5lDVRQC7KGzT7rTAZJJ7zf1siPz+8Z4e1vRhWGzF7wYQlrBLtlPr3JC4htC9ykpIU0I4gXy2IGrPpBWJBMt5MjVTF/xpPxuSWDIK1Dj035YlBEjNXY0BFLK6sFekU+g5MJHcLr9+HeQwTsHmQGdgkk8Q3oIel92x67ILEX8K5ih4MvS832S1QKSUgle+spNey8tnEvvXyyJWqwR4JMVLp1ra1PFBFFg+bQHxDiKHRSVkDyL2mheIWFj8acWYBz23cqY85wFX2A/L0MaOnErbsUJ86sTN+Rd3jmAJDvBgncsRTQS+2yrnQ+Vw12CBpgfD/Q+G3GFukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 22:01:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 22:01:14 +0000
Message-ID: <1daadc08-57e9-40b6-9a34-cfe47d368348@intel.com>
Date: Thu, 11 Jan 2024 14:01:12 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Peter Newman <peternewman@google.com>
CC: Amit Singh Tomar <amitsinght@marvell.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fenghua.yu@intel.com"
	<fenghua.yu@intel.com>, "james.morse@arm.com" <james.morse@arm.com>, "George
 Cherian" <gcherian@marvell.com>, "robh@kernel.org" <robh@kernel.org>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>
 <ZaBgUOQ3iWs3hLrb@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZaBgUOQ3iWs3hLrb@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB7424:EE_
X-MS-Office365-Filtering-Correlation-Id: e5699fd0-ed9f-402a-2410-08dc12f0d48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCjAyRntFR7DK41ur6xZ0QonEn4TajsVm0KYK4spD8dugIGe6DKGAyWp2e7twBsljw3q6DIePDX51H7Nyf0mJCmG0Hjzh+qpO8s7ofxT4A+obsNEHaDQAV3ASRiwuc3M4Otu7yYQZarHoU88c+Fzc+PzbOa8qOyTTCxSGfVMyGAI3X8mj2wcmFSuT5yU8VQKLVeCPUotjBegqa9rco8zVLcg5jdftHM/8YVvmwzCiEjm4IhvKXuqIHAJVIPV3Dy1kfQ6j8HasbmT5O+q8p6PETuN7tt7x/REPXRNCsi3RQyha1z1lFvjtkT5+CieUbEpHli9zGx+/nT9VxM4+4tr8HX10jip67sDPt+2c6EsDPvxte5a8tzW7E6XbWoX9tnUU7UbsM8iBltoxIgbAxECIKypEtZlGBoX7X0Iom7xTkl6zMUwmx23svVhW6m/ovRmJXZ8MFQcnZbHb8nxr4bFKC+11UCurT0OOLjEIF7/H3sy0qET+zkwSZd5+g+KXy47+aeaedchSJYmUEteGxZAP8M15bYTNtKLSmLO2iDhzzEFLOkQMVFsm73KrVWUEFJQVSDz2hdItYV7Wbgm3oNJzUQYILiCd5XpM+X8G5e3km5/3p+B7wWWXlThyPYSVNqCFU35nzRdctT1+cX2aLiTBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(53546011)(2616005)(26005)(44832011)(6506007)(4744005)(4326008)(8936002)(8676002)(2906002)(66556008)(38100700002)(6486002)(5660300002)(66476007)(54906003)(478600001)(110136005)(41300700001)(316002)(66946007)(36756003)(82960400001)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURRSWZrb3NxQWlhZkJ1RDcxUlJDWmNxMy9UN0F5dU96Y0lObmpyT1piY1VU?=
 =?utf-8?B?U1Q3Y1Jvdk01dDFra0o4a0s3d3B4bzhiOXFBb3R0MWlYLy9FMUViYnJFUkNU?=
 =?utf-8?B?QWhzUnF1UzZLajRYelhsVE9FNlB0MmpIMmQrdEozU3ZJdzl3VzI1STFabk4v?=
 =?utf-8?B?WndKRWQwVmJMWkM2NWRNMGV2TksxK2FGNSttSUpCMURhcmJHbVJwbk5SQmdo?=
 =?utf-8?B?M0RkR01mb1M4eDVyRU5hVjYyQ01od0ZmN21hOFBxNEcwRUZCRzhpSzhxUnpQ?=
 =?utf-8?B?TXphWE1VZnM4ajdqMFhVekFZQW0xTzl4U0NKcGJKL1lyMk9oVjh1bU9PUTNJ?=
 =?utf-8?B?d01tRDltRW93VjA1dmdIbVZJWjVFYTdHMjNQMWdvbnhWOU85MG9EMWpnQ2Ju?=
 =?utf-8?B?cGZ0RlZjYjJ2ZklKNWZqV2U5clNsQUVsOWZOZXljdHNhSzdvN0x2Y0diL3BI?=
 =?utf-8?B?QitrbWdQVC9yRzhVWU56Y05hVE1oNnRnSzBpcFk1YmtLdE9BZE9lRDRKSUhO?=
 =?utf-8?B?MnN1YVZaODRJL0duekRoTjd2WW4zOFRNRTRkQkpJNHZMd2U2R21qZldkV0g1?=
 =?utf-8?B?YVRqWlJhZ3ZQK1JOazFPQXdMSUdNRE5jOWdVQTFZdENweDVUTHJvUWVGWWNZ?=
 =?utf-8?B?L2Y3bkJwNHU4SCtTdEhvNjhtUi9jMzhiSUt3RXN0UEtDKzViQUFzM3ZjVm5j?=
 =?utf-8?B?TG5VVkZkOVFwbmc2LzNYUlFOR2pNMUZSWnM3YjhlTG9JOUxCMnJOajBwbGds?=
 =?utf-8?B?WXVnT09jM3RzYjlYd3ZuOEM2MXRWeDRLR2k5Yjl1NGwwN2xLdEZGYnoxWnRz?=
 =?utf-8?B?Qjl5N2VnT21HQStyQmQ4OXZiTG5OcjNRRlJBMC90SXI4bjVNdWxRbUxEd0RM?=
 =?utf-8?B?RU00d3k0ZzFqSFV4L2xzTnN3REthb2FxSE8rMk5FQ3JWTUd5OHA4MUNXeWJz?=
 =?utf-8?B?S0ZjaTk3cjZPdlVKdWV5bndVcUtvSDVRZkRXRSttNm5sV1VlWlh6b0F3dDN2?=
 =?utf-8?B?NDFrQjZVbStUY05MYXVwc3R4Wmt1azJobG9LVm5TUmEzb29yMmhaeUVjQ0RC?=
 =?utf-8?B?OFhRdUtiN0ZMWjZJMU5ReUVkcTRIWGdWREZIRjBmZkhlMzI5RG0vem4xNXdo?=
 =?utf-8?B?SjYrMnc4S0ZkTTVyRXpTNkc4eVQxcC91NHRza2dWeGV4b1RPbFlRTGMydU9S?=
 =?utf-8?B?T0txVjhZYVJBRnJyMEJrdkh4YUhZUWNvSm1odndDSTNoWjFqbys4dk1vWnRo?=
 =?utf-8?B?bnViR3oyMDlmNFN1TjZrdUtJdU1kYkR3R0p5Q2VNdnNQeTA3czRocitFS0ZY?=
 =?utf-8?B?aThhaUg1d2hYR2FScFNYWCtIUnpGSVNSYXg4TXpIQXFkUzVNTHVNciszZjRH?=
 =?utf-8?B?enNOYVJXVERDalVoTnlVdUdyVGVwUlVEZ1d2OTh5aWE1WEtjV08xRjkwWk96?=
 =?utf-8?B?MVpwM2VjLys1emR0ZGR0RHBVdVppY3IxbHMzaVRqL25DT2MvMkRmUytKazNv?=
 =?utf-8?B?akRSTHQya1I4T3gxbjZNRlErUkhWOXVBdDhjWEhBT0lkUlZxTFRRc01MU25y?=
 =?utf-8?B?cS8vWEdaZ014YUVuMU1JUEkvejRCazNNUEFCMjZTZXE5RVh6U2hsdEoxNVlK?=
 =?utf-8?B?RXp0NUl3MTkvQklhbE5SRnJ5U2RlUDdiQW1uQUVwSmJzMVFYc21ZNUdPZXA1?=
 =?utf-8?B?SkNyb1RKL0wrV0hkYitwenlqbm9uZWNoWHhGVzh1a3FrVlZTUlhuMDJpQ0Vp?=
 =?utf-8?B?aXB1endYSm1NUTF2RFQ2dkg1UHpzMVViODJjd3Frajg2dGtZanE1bmNPUUVU?=
 =?utf-8?B?Q1NyMHRmQkhLYmtCeFZNQm1yUEZUTjdQYWw4ekJ5UkY2WWdKRDRHditab3Fa?=
 =?utf-8?B?UDh5Mm8zMjFYcUFUZ25XRVM1SUxHaUhyL01NKy9remUvV0tPTXYxRjgybjIw?=
 =?utf-8?B?U0tPOTNaeC9aOVkxMHZVSUMzZUhqbzdXekRWU0Zjc0lBZ2FPNzJQeWNORUhY?=
 =?utf-8?B?MFpueE1MdHpoTGxUWjlpc1YwVGk1elI4KzQyYXBPOXZoaXUvbXNHdSs1U2tW?=
 =?utf-8?B?cDZCS3ZJS3pIdDR0YUNtT0M1SlExU3RUQTdJSThmYTZKQ3hLZnEzVTYwMnRk?=
 =?utf-8?B?bHV6Y1ZzWWRjWVVuSnE1RVBjVjBzNEhmbVZXTFAxZXh2QkNKK1JFRTlnYzhR?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5699fd0-ed9f-402a-2410-08dc12f0d48d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 22:01:14.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pvfbsx7ZlkJPPeWTgDOG2ej2cG4U2gHgWDeald9FHUr5wsCjmOcf64vEY5c3Dxh9rY3JqIIC7mmoae3fG4borIpo6nlIY/v1KN2p+Y54zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com



On 1/11/2024 1:40 PM, Tony Luck wrote:
> On Thu, Jan 11, 2024 at 12:56:34PM -0800, Peter Newman wrote:
>> Hi Amit,
>>
>> On Thu, Aug 24, 2023 at 1:52 AM Amit Singh Tomar <amitsinght@marvell.com> wrote:
>>
>>> 2) Second approach that we discussed internally is to have schemata for CPOR, and PPART separated by new line as mentioned/suggested by Peter, But it may require to tweak
>>>    the ARM MPAM device driver a bit. It was kind of toss-up between 2nd and 3nd approach :), and we went with the 3rd one.
>>>
>>>    L3:0=XXXX
>>>    L3:0=PPART=X
> 
> I'm not sure having multiple lines for the same resource makes anything
> clearer.  I preferred one of the earlier proposals like this one:
> 
> 	L3:0=XXXX,PPART=X,CCAP=X;1=YYYY,CCAP=Y

This assumes that all tools (public and private) that currently parse the schemata
file will be able to handle this additional information seamlessly.

Reinette


