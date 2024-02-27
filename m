Return-Path: <linux-kernel+bounces-84096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE27D86A227
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B8C282364
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFDF14F9D9;
	Tue, 27 Feb 2024 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQfopNCI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D030651009
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071738; cv=fail; b=eSyAp/Ij/QBMZiQo+aejtENiPLMsDdLePyLzJswGhCKItzBDg/tAyjlHze7niilDUePS/SlMOKjZMXKtIx239vfEX1jNwGc0Jrg2iu0Wt/DOm6o4CFlhorVXkdierEe/imxxety1KewjQa20k2Eml9XbA7lSAnGkotGF4XLOmbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071738; c=relaxed/simple;
	bh=4tuSUa3bUqiHeXCxKPnfeDwPfgTapCnPwZBIBsqVBVA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFnxvVBr/IjORFoYIcNi1ZFd/ZNDHoGhHRfD79ePvzW/JfS+BoU1NB4JzJmaiRrVFt+ierE29V8sBvVm9PgMNRo95JupvYrjqcECJuSYiMx1Wt+xhDypEePQS4Hou0KqocwtGwUv2+jus9rP7EMrbgrFrrMc+i/OJQu+nC/n2es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQfopNCI; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709071736; x=1740607736;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4tuSUa3bUqiHeXCxKPnfeDwPfgTapCnPwZBIBsqVBVA=;
  b=hQfopNCIYcaoJtjxrHHCUwyTLGImvHuirdbzHoGw/8y8X1HNe1PvUkzA
   DAxRoUIgwn27WPTuQvVYrF7HHCyTrGw5aP/iOmZT+WiCuJu9sc6tbS5cg
   B+XEf4jdpBP0Plb1N3gV3MBD+njndhnFLrgdyHJs2jnDIzt+DxfqFw8l0
   eYeiX5rmbRYo7fZrQrcxv0xg0GpiziWJJeJdx9srP4sKXUkYYY1TkjmU5
   2OE21mQphYieK2M2ieP1yT3+Pj/fHGg6Ih1l3wOmhrTNTLydFUz5lnf6D
   KvLjd6hcxIquaxfUCSXG/UQkPuBAgkhcA4/Edlfy6fkTqZeZ/Kasw6tDQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3289483"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3289483"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 14:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11939979"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 14:08:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:08:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:08:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 14:08:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 14:08:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/sSZ4t6JuSnqlFV3jW1L+JkbRjwHD7xteUr/FViHxV5eFlRN1qFTrJzsvUE5vb4D1TUqjDCDJzC+ne8xjdGXELHOlFAK/IbPPpd5twHIqnFmCFsF1TWPClxr1tr811ftQlijBwm3PJ9PFyrWiqpM2YpOj/s2uFrLIwb6iFF7nEo52IxOiki2O2iMtF3QIL+HgfHBNpJPvtYBQ7VPSVTlgo6D3KWqhU6iV5B8sVmnfjghtbwiO/H5vp6/4GxNP/d5fi3q+zbL4sTQcX1otY0QXZR23bvUQCn9sTCrjGCZhKDnvZmnXifIF8pMwLqXvqhbqJUmUGlIWbply2wDMMnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBIudPUKNc8OSq4Jx7ftdi4yob9LtbqoLAoHLAeZOkA=;
 b=Og/AekViGHI+n//OKnWmzk2QTmRDL6oAjaMQCFuvdxCFT63+XdLYNNO6r4KnnwKUkX6Py1Prfgcl5VIsIcXqSE7S7MnaYR4n4gmHNzDn7wOfm+5LXupEEERKSzip61dBCIZUOtQJDAprXuqhIRNubU0z2Q72Qmx5TSQjtvskZ/zoMlcsmH1gsmOxxJj8H2GozU7g0vjfPaJ2zji2bemiAKPGHgjjew7jaKAsbeywLczAK7HN3BcC6iOzCb1Wcaa0fVCdFM7//KIFaaH6Jemg31NJb4IqX9jCxDhFIK43loP+3jl6iA6XOVc6rft7EbxuPRrc2TOR3Xhhh2SMqEDpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 22:08:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 22:08:51 +0000
Message-ID: <0a633c22-8426-42cf-9572-7812ffc75d0a@intel.com>
Date: Wed, 28 Feb 2024 11:08:38 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 17/17] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is
 parsed
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Elena
 Reshetova" <elena.reshetova@intel.com>, Jun Nakajima
	<jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>,
	"Sean Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-18-kirill.shutemov@linux.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240227212452.3228893-18-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0116.namprd04.prod.outlook.com
 (2603:10b6:303:83::31) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8d1581-0ebd-4eb0-53c5-08dc37e0ae5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtN86lv8iINqEpMVcIuuV1oWfc8wrtpLWMeO7+syfXNf1zGfVT+RNsLUjzD1Ao/igYerk3Aar3murQqSGkpfoHutTe6vVFAJ8zZwMZgPWox1WMH/CVhKj/S+sSkMPfp0fFfF6a6rNEw2i5ut+UZ3A/5YWajYlJGxaEOZiIvHvyN7cAMrfjSMXw6ujigvbkFBz3OZM0L/kT5w32IEYU+voKOb4BCCGfyTcYnUAIvG0FS+aAtYNUzB9upJke34FvRoVn+6Rb3gcASYluUIs2ZCJnCEN37sfM0NFXymxl/e03cWNmEQJQVKXjV/HYRFAk6QRGdv/hw4YZwc/N9QB/EZVRUaS6nKRu/rjnxyhZVBSHTMXLxE4VGo84snea9XS8L4GVBolQg2MWpGA38VwYcaTxD6sFuLTowBGwOa6uOl6Nhrlp1/EaxpjBNXqs5zNYe9uqiw4nuyS8lyOle60FptyXchr/O40ZhLwG1ASBi+ZbGt/1Xl2MWDjrAYLJuSPrbqQ1znDbXesvN2eYS7rQEJ1WIU2pbXecwz92hlNGuqwGBdZMmPvzYuHOZPwGpY97Ze6kCdgp/w2I7Azgl83Tls8sadjRR2jNIDGpGBuxDy8El3hUqKHUfk0WA1XQGaQW15I11eXCPNCDUg5pEkj5B6oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2hSUDVFbkowOW5FMGsxYkRFTE9mOVViL0dmT2FadWp6eENqdHZHMEl3Sndk?=
 =?utf-8?B?dFkxSHJ6MjR5WmVDS0d2UWIwNFhFdHNteHR5blMrSUJuZi82QjJWWVpIRXkz?=
 =?utf-8?B?cWVudWZMd3UwTUx0aVAzZkNBL1MyQmFlVXVYQVl3d082M3ZLc3hONSs3UytT?=
 =?utf-8?B?NjlOOXlFckZCdzdVYUtaNU9DWDZKSjd5Tmx2ME1VVFdXZ3ZFaW1nV0xWV1lq?=
 =?utf-8?B?MkI5a3lNSmE3TlhpRHFzdTE3YTNMejVpNXlLRjJZTFhESjk0VFJnZG8yL05u?=
 =?utf-8?B?dkNyQ2ZWV1V4Z3VWNmJwTjNyT01HdnV2bHNWNVB5bXE5SHVQRTRId21tdFQ2?=
 =?utf-8?B?emMwNVRONXpndjcrRnl1Nmg2TUdoSkNiRTBTeXJ1clBUYkxHS043WjVhZ2dy?=
 =?utf-8?B?UlNCMG9uL091SnBZcDNqVnJDcytmcm56NTZyL25LSUlmancvakVzbFlZTi9C?=
 =?utf-8?B?T25ONEpkekJKOCsvbXhpZ2xSVmRjdzV3NVUyWTVlVWtJaUFjZDQ4N1hZTUhu?=
 =?utf-8?B?eXlkbUhYQWhkOGUwZVFxOG51Rjg1ZTcrQUdQNE9icTJzOWpmUjZGUW0wS2JN?=
 =?utf-8?B?MTFXNk9VaTZxZWduS2JNSWdQQ2hFcTNPZkJnYjFlMTRvMHg1VHUrcFpkRU5S?=
 =?utf-8?B?WVg1d0tLeHRFYzJsMkk1bklaNklrN3gvbGsxQVAvSndJTnBxdHpsSkdEeHlB?=
 =?utf-8?B?bjJGL09hWHlWQ2RxR3lMRm43dGMvbklaK1hldmV4c05UNno1ckJudXQyMUJI?=
 =?utf-8?B?dDlwUno0UTF0SHdSSStqRGUvVVVqbEsxQjNhUklrTmorV0NjdkFQbkdhd1lS?=
 =?utf-8?B?aGRYR3o3MDZ6U3ExczZGNm1tdTYrZjMzYk9RTy8zZklzK0pJZHlBb0VCSjBF?=
 =?utf-8?B?Vnd6UWRyYU4xZnJLZ3pHcnhYbWVjNjNWK2lsNG53dTd4OFBDOU9TVW1hUWdt?=
 =?utf-8?B?ZFRnRGtHNzFkb0lMdmI2MklGNzhMZzdDVE1zRlpZT05ZSlh4Q0tjeEdKTVlp?=
 =?utf-8?B?eVpRaU5reHNQMXh2Ry9VczhYYkFxTkhncGpCRnNnajcwaUhKbCtUc1dOQzgy?=
 =?utf-8?B?NHFkbVF0OS9aZ3Fsc09zWGtCbTJDblFxY3JYa0NFNDQ2Q1hyT0EyY09ERS9v?=
 =?utf-8?B?RGVEdlBkYVNYTGZlM0NmcjQ0QThSazNTMy9RZUFsM0oxaENOOTc3emFmcGRF?=
 =?utf-8?B?a1VMSHUrRDFzNytoTzBiWWJhMGZiRGNZdkVVb1JsQ0R6cjc5S1hBMFFYNjFt?=
 =?utf-8?B?aXVENW4yeFB4Q0ZYN3ZtUHhSMkJaelZ3V2d5cW5CdkpUekFMczc4ODRzZ3pu?=
 =?utf-8?B?ZHdGY0I4TFNBeEg5NEF0dnFQN1o0bjJ4NndCU3dPZ0dYbXZOY2xNdmFMQmh5?=
 =?utf-8?B?SDFzUjJhVmJRVTh0b1pOVDYvcWpVcUs0a2kzL0s1bXJlOHgrMGNaOHNnMENM?=
 =?utf-8?B?My9maGRiRUdxOGNnb2Q2V2lmUkp6VnBYY0RJVG02UGxDQnhDY3B4UFY1WTJt?=
 =?utf-8?B?TmxRU01tbmN1MHdhVWdZRjZOa0laSzRNMlh1d0F6REFYRkF5eHJaTVQ2aEdu?=
 =?utf-8?B?d0FlWm5nTlllc1BsaHRaeWV0UUF4SDBmbkZxZGhHcERBeCtjTXoxM3dHU1lt?=
 =?utf-8?B?WnExL0RjbTBmY3pYcnd5SGJGSmkrbFZ5NjNETE1BNUg3cjJJa05SbmpnSTVt?=
 =?utf-8?B?UllQb1FMdTZ1bTkwYVY4bW1OZi9UN1RZSWRGUmlTK3U0YVNtUlpVR2I2bXV3?=
 =?utf-8?B?R1FNY01rUzdlcEVwTEg3emM0bGdjdGUyOE5yVU1SK1hoS09QT0lOV2ZTSjFu?=
 =?utf-8?B?cXpXV2ZMNTNXWG1KcjhkeG1EczV6eUxPek0wYy96aEdaL2ZFemVESjJmY01o?=
 =?utf-8?B?NkZER1VkWk5CcEl5bUwzRFBLUTEva1A4NHRiRTYrTVd0TDQvZlFablo4U3Mv?=
 =?utf-8?B?WU9teGZKc1BpblFlaVBGb0VxN1JEOGNHQmFBZ3BSSWFlaGFnSC9CQmRQZFVS?=
 =?utf-8?B?ZDU4ZGN0TGl1WHQ2T1hrVWcrK3VrZWpLS1BSWUx6WExnOGM0RmNCekpEZnBQ?=
 =?utf-8?B?QTJ0aVpIbDdya1lCLzVNWVZWV1UzMEQwQktRRlRpMGs3MnhtTC8veSs1UHN1?=
 =?utf-8?Q?IxAek8LFMrMaz1TsdOszB8x/E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d1581-0ebd-4eb0-53c5-08dc37e0ae5a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:08:51.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTgD3HSsdYyeiFIyveHSbJp3a0J7Ufqw7K3f8ZRw9I2jbfxgPJCvhJ6RDj+9Cxngo+A7ec5Acj52M8Lpy9LkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com



On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> When MADT is parsed, print MULTIPROC_WAKEUP information:
> 
> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
> 
> This debug information will be very helpful during bring up.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Baoquan He <bhe@redhat.com>
> ---
>   drivers/acpi/tables.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b07f7d091d13..c59a3617bca7 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>   		}
>   		break;
>   
> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +		{
> +			struct acpi_madt_multiproc_wakeup *p =
> +				(struct acpi_madt_multiproc_wakeup *)header;
> +			u64 reset_vector = 0;
> +
> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> +				reset_vector = p->reset_vector;
> +
> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> +				 p->version, p->mailbox_address, reset_vector);
> +		}
> +		break;
> +

Hmm.. I hate to say, but maybe it is better to put this patch at some 
early place in this series w/o mailbox version and reset_vector, and add 
incremental changes where mailbox/reset_vector is introduced in this series.

The advantage is in this way someone can just backport this patch to the 
old kernel if they care -- this should be part of commit f39642d0dbacd 
("x86/acpi/x86/boot: Add multiprocessor wake-up support") anyway.

But I guess nobody really cares since it just prints some dmesg, and 
nobody really noticed this until this series.

So, up to you, and feel free to add:

Acked-by: Kai Huang <kai.huang@intel.com>

