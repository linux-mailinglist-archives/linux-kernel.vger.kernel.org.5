Return-Path: <linux-kernel+bounces-84070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2914286A1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1FB25CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CC14F979;
	Tue, 27 Feb 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASTqAjiV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7444DA0C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070515; cv=fail; b=bGGeChXJR9CQa3gztO9Ur61oj9bbE8eB9p/HFNYPSUsQdpXxDd1BH8thtrE+ruGnSir5xzcnxDenChfUkvPbhHz6N5riPjjw0d/HbP5gS2h3Z5CH7XMqUWjU0xdVXQxka2LLtvUJeU6sJc+ly8YhB2rQahSimwAdq8LoVCLMYN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070515; c=relaxed/simple;
	bh=M+a/pH8eizchR3vr7endqDImmAoTPWgkxdSqYhrmYBE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kiw3C+LEmxeW1yC/2xISzb6gB5edMpeGHf/P9V5kFoTOPRt6pp93HIp4gDHAk5/P/lpmJoGZIQCfy35lv7zgCeX54xt8J7wNMcBjETtk52DInIEHnZv6rXvcRWosUCjlMnKA+IeHyVfpwrCiwqTt7XRLDRbIqjVMUHvr68QEkfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASTqAjiV; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709070514; x=1740606514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M+a/pH8eizchR3vr7endqDImmAoTPWgkxdSqYhrmYBE=;
  b=ASTqAjiV22dTwktMl3rjxTGTW+eDT7Vo1FbM5Uwu29BZgFVcFf8wnmhp
   Hgjwkcy5lqazK5rR80MWgdhDU+iSqvabJZA1oRdPIecZqP/KPe5Nfhu1g
   t5bqEaO8U9oUVzfZOfCgoSdSp3Ga0o5AzlsHlnGGKu5+BDGXAZahdupoW
   iWJvEu7eCKMmEse11dlL8Euaiq0X2emok3+Jl87/MGicBAK1JYhO5PsKg
   7tNRuO6MukmnawFx1ODzPNA9EBayic2SIdcGB2Fxmyc+t3u+sYvdEkveA
   ULooOcaPX3hZ4UsginSNVhqBNnl7f31iS71IygbMyOzvNuJZUDlwvwJF+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="28875203"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="28875203"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:48:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7138742"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 13:48:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 13:48:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 13:48:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 13:48:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 13:48:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVyEeRqRHG/iCLawOqg2UwvVIOfr2WD/Ob8y2NmD9MZKXga1L59RY1p77lgKmKJX1goASEhaopClLspkrNa4AXKYUMS5eF/6bMMxFIZXuIbafKq6TXvYcIO8ZNKh1hUJHPhz2v7bMwv1YHp56rQBKyNrii7AtytUeJaZSG0U29HFIXKS+XZ2t9MPr5akMNdZ6lEbPlpOVWMgcQfNiEh+jhcETnCDbCg6OmJnCemBkkPjabqITS95jItnqf8ZIZsFxYKzc6JpVkWWTXW26sPsDwMjGOo+LHuz7taK9IrjjHwIrO930Ic2uCfcMMc/hqWBMcYqfPmx5u91kzXasKyJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUZmNAh/TSKC1iOBgv41NIU6MHUF/NtWDmI1FQQMCLo=;
 b=D+q+HHtTRPetX4r46CETVPuGMmX152cKWJkTqqD3EU/rL3DZhUKH09HSneJrz5QfOECkQRHAAbP6jMvaPbQ3LOMDxR/PU/X9vxDZQ7YV8SAqXwAx4xSru1XFTJP0cYa5Ph5wJE+5WmYBCCXJA9kAjfvGQypq87Kz316C9d67hLnhXSHNpSWjvsI2xKQ2ln6wuOvKsGQo5O6JUNGKoOl8EKx7dsgfggjWIlG7LPptX4a0IRlMPSQvbbU48GGYkFIUaPAUgCjcwvbmJFyMNJHz5mrJ8iEXIHbcd5f5caSfYs1l2BYixLsCmW/PKHVce/WvpxTTB6qEyD9QKtzg5u/Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 21:48:28 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 21:48:28 +0000
Message-ID: <b32cdda4-5cca-4608-b403-30ab6ce668de@intel.com>
Date: Wed, 28 Feb 2024 10:48:19 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 11/34] x86/cpu/intel: Prepare MKTME for "address
 configuration" infrastructure
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<pbonzini@redhat.com>, <tglx@linutronix.de>, <x86@kernel.org>, <bp@alien8.de>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
 <20240222183941.7CB634A5@davehans-spike.ostc.intel.com>
 <z52bbgqxtr7wpa3yqqgbwurb6vx6i7gpddae2rrbxkjasuhnuk@7zsudlb4tw6s>
 <b01f92b3-65ea-474b-8dc9-f2e1ca6ae0af@intel.com>
 <wtdmrkjfvlf4b5mkpqw537u6xuxkdajix2knbo5ivanjzzpvvg@qqlw7gaetujj>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <wtdmrkjfvlf4b5mkpqw537u6xuxkdajix2knbo5ivanjzzpvvg@qqlw7gaetujj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:303:b6::14) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2d59bc-2578-4014-20dd-08dc37ddd51f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVGebdsucPVULQ7UOegyXk9bKwfas4PkRb4RytHOaFtN03xUSzOUcyhcnC10iyAyBjc9i6AzNGuR0QPhEZiF1Qqbb2vP3uU4pNqFJoNJe5S3jPkVJVXwYOPNZEjbwb5Drs1NMvYNb/5DZ/GGbrdsG4Sa0I3u1uYvczXzIY+blpX6oFD4cP62Rg9ond/e+6nkS7DCZrKZ1MAxZsxhRFiFW1HvhnVCcrptpZfEB8Yd9cJhyJzrJ9LBmjp4K3uVJHvmO7K4ddA+3Q86IBE4j5aXKpEjBEJtpAJvv2nZCupxfsDqUqV8fCaCOUunCZlGdAqFc7qOGjvR7f/f6rN/Y7BxjkGZ8L+azvxwCifNveHF6QzRAXqMSylaVU+w0Nv9lhuRMkAB1ZL/Q7LCk8E9sfSKOo0nrRQSoZvqSU7LxGTE274U/nuyt54b7Arsbl5vBhgAGbGowSYlLEHocNtDUv45A/g+MPcA6Q+Qo3YVGdRdvncCyGbgtOyJks/XBsFDP2RtvMniQU/jAHtroXOfOluOHncCxEzBXnrp95NjZLnobL/B8Ln5EC21UL7TMR4qu04425f+ciOheERUgwggD1rMrRiMeuu6BO2eSSUoI2kTfY4vUP3Ga9H5zM3Y3kkhCXZn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ri90NkUwYmloakxOY3lyQzFocVptZWU5VUFtWkpNdEFGMjFFZ25MaDl0UThW?=
 =?utf-8?B?dmNMeGZGZ3Z1bTlSaHA4WklBTmFCNEpob2VONzJmNUNSOG9xQUs2dEZPZ0Vx?=
 =?utf-8?B?eHVRMmtFV2tVUzV0SzRYQ0pYZ3pTbzk0cDZYaHk2U3Fid1hIRmdZdE9sRWFU?=
 =?utf-8?B?SzZwMEcveHU0dGlMVDg2eDJxbUQxenVOUmZ3bTlpa2theUpzdThIT25XSUlx?=
 =?utf-8?B?R05yRnkxSnNoazFQVm1MaWdUV3pCaDk2eEx1REY4MkFPTzYzVlBOVCsxdUw1?=
 =?utf-8?B?Ukk5b25pdVlTWDVCeXBkYnBDVmFLT1dpWllJdmRlRnlpdWViS0htbTB1cTN2?=
 =?utf-8?B?T2w5c092Y01vUUg0ZEczMXorYXFsMmh6Zk9XMUJ2aHFFbWlIWElyT3VQQUVj?=
 =?utf-8?B?SkhBU2JCZkFZYUFCMlpPaFhXeHlibDRnTnU4OHJCMGZuSFcxU1dnS3dzdnZP?=
 =?utf-8?B?ZmdHS2J4ZWVEdmVENWFQOWpqOUMrQS9NT2RRTUxZcHFHRjBwT0wwRkJ1Q1Ba?=
 =?utf-8?B?VEFDdmxqS0ZNb1VkTGxIMWxNR3NZREprMm5qcGF2VE1tWE1YZHZZcVZKa29X?=
 =?utf-8?B?YmIyc1hQSjhYMzl6NkhIbW1HR21zZXlwdTEwWkM5Y0xiNk9SNlhPR1JHbHhH?=
 =?utf-8?B?MlpSWXlJeEYxdEdSc3M5SkZrako1TUVHT3ZyTVlPS2VlUDlUR0FtOWtJVHB0?=
 =?utf-8?B?TUF0TG5xRHFzS1ZpQWhTa0ZkQlQ2d1FCTVhPUjZlRi9JWmlLV0hRWkU1MkFO?=
 =?utf-8?B?bytGRnBpVFNwaHA2SlViTDJKZG5BcVROV3pKN2JndGN0b1gyaHlpMUpvenAr?=
 =?utf-8?B?aENzcGtycXBBU0hrYXBwMzV3NXA2ZHdPNUh0VTV0QmRkY2tpd21DUSttVlI4?=
 =?utf-8?B?WnZtVk1IdHF4Nlh6bU1kNG5PeFdjYk1CdmVpS1pCMTJ1NDYzNi9ENDJHaE5W?=
 =?utf-8?B?NEZjQjVmQjJtRy9GVW9yWmdsQW1WRzZWNlRBeXJvNERqWC9YWGNTL0tNYlVt?=
 =?utf-8?B?MTJObGhjRFVMc051dWVBaENZK0FNRERQQlhaMjA2U0pWSFJxTnpiSnpsVVNa?=
 =?utf-8?B?UkJoakg3YlhYUWcxMHdCb05vYnlhZFVWb3dvek1BdzY0alFvKyt4VEs1RzFR?=
 =?utf-8?B?OHlHdndKZ2VoOTl1TmJMTXlhbStxKzVYT1pKdnk0RjNxRVVjWG8vVG10WFRz?=
 =?utf-8?B?TnpWekcrLytNUm92OUVmc1BYV2VyVFNkOWRMNFpSc25UeFQ2anBwb1lwZm8x?=
 =?utf-8?B?RkxFQkQwL2NBUXIxb3NFVFNNYjUrMmRpdHNyeGV0Yms3aFBZUmJpK21FSWVl?=
 =?utf-8?B?cG5jSHhMSXRhQm5VazR6UUdMNGZ0a0RGVkNKRzM1Z2NjWDAwZ1lhUko1UnlN?=
 =?utf-8?B?VEZMZTJ0aThlQTdiNmE0UE1ZNkJtanhjV2JBNXY5dCtFNUlLeVhidW1xd2Uv?=
 =?utf-8?B?NW44OFRvUTAzUmlLQ2ZmNVllQVRFVGdOSXNZWjZEQU9NeUIrUmpzb1JGMGxu?=
 =?utf-8?B?ZCtlRHNwa3JTTk9WSndFWElYZ0w2cHpGVnhyMWd5RkZlSW84U0RXOEtEKzln?=
 =?utf-8?B?MHVhc0ZtK3k2YzcwL1pOQWNVK2F4anQ1ZmREZldIZzVIdEJ5YTBkR1FlSDRH?=
 =?utf-8?B?eFgvYjRmTUR2NHp6VjM3cFU2QUxRK0RlRDJmYUNoUytZRUJIQzFGckRJMzla?=
 =?utf-8?B?VjBBend4WjBCNzA1QjRIb0hVQXBwVmRQbU9TeklsaDkwUEV6d0U2dFh6N1Zm?=
 =?utf-8?B?ODZMcjlzVU45MTROays2ekh5MW9QVmRyVVF2ZkFnZ0YvYm5hdWhZZGNhQnh2?=
 =?utf-8?B?cFMzQ2N2MFVuL2hYSnhGWGN6WlJXZlZocGlaMVZyUWlPRmFlQUY0aVZ3S1Zq?=
 =?utf-8?B?SHRuV2Q4ODYyRDJiSEtxVEoyYWZpakxsd3J3d1IvRzVwS3ZVUXp1Z0RtVU5m?=
 =?utf-8?B?dnNQaEFYQnNIR01Nd1NpZW93YkJ6aktuL2NGNWJFd3ZEMnlPSy9sOUc4ZDcw?=
 =?utf-8?B?eXpDVEJZenlVM0wzOXA2cWFEMExQRHZFQkNTNVBRVTBOdFBWWVNrRXFHbHlH?=
 =?utf-8?B?TUtsTlIrbGdVNGJQRUwrRW1WdEtqRm9uUHpxQmVkSFlvbXRHaEQ0WUdZRnFD?=
 =?utf-8?Q?b/yBpv/TIP4BN9xVmfeS6fwKn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2d59bc-2578-4014-20dd-08dc37ddd51f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:48:28.4167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGWe05dE6wZWAaLWrX0SB1w8BDaud+3zDsFFBdtdF+XxiXfj/57KqTDmfHyCwGIr6O+80yd+5lNCvmsOQws7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-OriginatorOrg: intel.com



On 27/02/2024 1:14 am, Kirill A. Shutemov wrote:
> On Fri, Feb 23, 2024 at 08:22:16AM -0800, Dave Hansen wrote:
>> On 2/23/24 03:33, Kirill A. Shutemov wrote:
>>> On Thu, Feb 22, 2024 at 10:39:41AM -0800, Dave Hansen wrote:
>>>> From: Dave Hansen <dave.hansen@linux.intel.com>
>>>>
>>>> Intel also does memory encryption and also fiddles with the physical
>>>> address bits.  This is currently called for *each* CPU, but practically
>>>> only done on the boot CPU because of 'mktme_status'.
>>>>
>>>> Move it from the "each CPU" ->c_init() function to ->c_bsp_init() where
>>>> the whole thing only gets called once ever.  This also necessitates moving
>>>> detect_tme() and its entourage around in the file.
>>> The state machine around mktme_state doesn't make sense if we only call it
>>> on boot CPU, so detect_tme() can be drastically simplified. I can do it on
>>> top of the patchset.
>>
>> That would be great.  Looking at it again, the (tme_activate !=
>> tme_activate_cpu0) block is total cruft now.  It probably just needs to
>> get moved to secondary CPU startup.
> 
> I have never saw the check to be useful. I think it can be just dropped.
> 
> The patch below makes detect_tme() only enumerate TME and MKTME. And
> report number of keyid bits. Kernel doesn't care about anything else.
> 
> Any comments?
> 
>  From 1080535093d21f025d46fd610de5ad788591f4b5 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Mon, 26 Feb 2024 14:01:01 +0200
> Subject: [PATCH] x86/cpu/intel: Simplify detect_tme()
> 
> The detect_tme() function is now only called by the boot CPU. The logic
> for cross-checking TME configuration between CPUs is no longer used. It
> has never identified a real problem and can be safely removed.
> 
> The kernel does not use MKTME and is not concerned with MKTME policy or
> encryption algorithms. There is no need to check them.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/kernel/cpu/intel.c | 44 ++-----------------------------------
>   1 file changed, 2 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 4192aa4576f4..60918b49344c 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -329,55 +329,20 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>   #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
>   #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
>   
> -/* Values for mktme_status (SW only construct) */
> -#define MKTME_ENABLED			0
> -#define MKTME_DISABLED			1
> -#define MKTME_UNINITIALIZED		2
> -static int mktme_status = MKTME_UNINITIALIZED;
> -
>   static int detect_tme(struct cpuinfo_x86 *c)
>   {
> -	u64 tme_activate, tme_policy, tme_crypto_algs;
> -	int keyid_bits = 0, nr_keyids = 0;
> -	static u64 tme_activate_cpu0 = 0;
> +	int keyid_bits, nr_keyids;
> +	u64 tme_activate;
>   
>   	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
>   
> -	if (mktme_status != MKTME_UNINITIALIZED) {
> -		if (tme_activate != tme_activate_cpu0) {
> -			/* Broken BIOS? */
> -			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
> -			pr_err_once("x86/tme: MKTME is not usable\n");
> -			mktme_status = MKTME_DISABLED;
> -
> -			/* Proceed. We may need to exclude bits from x86_phys_bits. */
> -		}
> -	} else {
> -		tme_activate_cpu0 = tme_activate;
> -	}
> -
>   	if (!TME_ACTIVATE_LOCKED(tme_activate) || !TME_ACTIVATE_ENABLED(tme_activate)) {
>   		pr_info_once("x86/tme: not enabled by BIOS\n");

Since now detect_tme() is only called on BSP, seems we can change to 
pr_info(), which is used ...
> -		mktme_status = MKTME_DISABLED;
>   		return 0;
>   	}
>   
> -	if (mktme_status != MKTME_UNINITIALIZED)
> -		goto detect_keyid_bits;
> -
>   	pr_info("x86/tme: enabled by BIOS\n");

.. right here anyway.

>   
> -	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
> -	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
> -		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
> -
> -	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> -	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
> -		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
> -				tme_crypto_algs);
> -		mktme_status = MKTME_DISABLED;
> -	}
> -detect_keyid_bits:
>   	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
>   	nr_keyids = (1UL << keyid_bits) - 1;
>   	if (nr_keyids) {
> @@ -387,11 +352,6 @@ static int detect_tme(struct cpuinfo_x86 *c)
>   		pr_info_once("x86/mktme: disabled by BIOS\n");
>   	}
>   
> -	if (mktme_status == MKTME_UNINITIALIZED) {
> -		/* MKTME is usable */
> -		mktme_status = MKTME_ENABLED;
> -	}
> -
>   	return keyid_bits;

Other than that the code change LGTM.

Reviewed-by: Kai Huang <kai.huang@intel.com>

