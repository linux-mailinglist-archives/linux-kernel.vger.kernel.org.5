Return-Path: <linux-kernel+bounces-93399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FC872F3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9CFB26442
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1385C5F7;
	Wed,  6 Mar 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lf3ZjmMm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E534D9EA;
	Wed,  6 Mar 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709708818; cv=fail; b=MB47URYh0na2CdSGpR+hib0tBL6AIBfcNxeXkzpYpZH5fzlkVjZVPKoCsMcG9/0i497aUh8xJSkzzY0zZC5CNTwxJoiLISwJsIvQaqzZG6wqh6q3h3yZ+Tsc705OHkjgeJ0cnDeJjrs40qGbjmnZEnuqAgKBOAW2REqS5QHgZ4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709708818; c=relaxed/simple;
	bh=bxr+CktvMwMMBUAevqcKe+EKV5GXqA9mY95Fx93p7Q0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mD3veMgSVvDHy1cIQm+SFrTG/Spf/iz9/AnvXGIoOkENmkbPEu5l/Wb+Y3EM5KKjwq2Ku/9fvtQDZZIypHj41kfvNViRO6YlxW64BZKP07PoTsji+qfza4uKxnVzj/Krt2p8z0yJnLLv8ty45diolx2iuUUPEhNvUgLzE/5UQz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lf3ZjmMm; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709708817; x=1741244817;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxr+CktvMwMMBUAevqcKe+EKV5GXqA9mY95Fx93p7Q0=;
  b=Lf3ZjmMmPCAUf0BGG8zZFi9QHHgRHIRi5/xVm9JADSyG0z0m4waBqn8k
   we/EI+0JPPJoRNY3NKdBgNmOs9Ax9XlYcQs9ar5Oxz0TGFDM4aT5/Apwy
   uPMJD6O4naNUNHYKh5oVzgu5K6tJyImRGrifsc+9JHKxaKJpadTaWqdzL
   tbUmHiA8ZHnvjXnptfEE4xmR0pSGJOuEs4V8vV7aS1FXu8iUz7OTWIrvx
   RKJEC2ZxpslQoZ3Oy0OF57ixIRCmrAl1lgzhhk3jq09jnpoKPCZsFN1jw
   T/qZ9F5Vhmc6HW/e7cQgItXCISZfAxdXvHDr6ik4UhiZQJmjVReVxQvb8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4886992"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4886992"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 23:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="10057760"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 23:06:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:06:52 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 23:06:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 23:06:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCO2pfNYprgLndR2CtGluI6A7xAH/XsVTx0T2ZazLjG6jcYy6t7k3Etat6ETWjNKIK9o716fBN/Q0gl6dnIfKtvqpucr+Nq+nWw3FUWCWNgXeyRgWYoeiNMB8x7uSz0VDN03T7GcMj+KQhMvfICKvMZ/Dky2/MOmftuwtjocHnxVeW/PZbSvN5G4JWC/TGBpHa2W07nSow7t1k7KqEMlau8AOga1efwG2gi6IREMMa33Hfbpy7bIuhr/sfD+oA1JLCrmmZzfEr60SEBIYXgERyUasJq2KN3jyvZnzNKS5+2nwxTZQAAFKlR0NANugzaVczSIuOGb17qY6IBy/2ZE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEV2+nG46cBNyqkGam3TipNWxS9DTHtOnKEAQHNAWqc=;
 b=EhcPcGIB/w81z54wMbXU/YV0B2tTm3PZy750/1T7BlF+VUDH6POJTH28+DwU7ae8pBq1YnDqh0yKOA0u+g8EiPIfGitoLyn/zG7pjM2sftlTw3Y518ADUXjfL5pqVc8TZiKc/48GZhbu5P4aHv/fIBkmcv0zHDziqljPWkMofO7RL17SXE71u1JtWfbw2aPc2rYCrcpNz7OLcRfuCZkXwY1vN1mFCSQXY8TtP7ouiBKAzeHIgiLV9sa0zUWY7INNM7j0YMKHyDkkG5f38Qw2h+wYaqA+8VU9dLcN3FaAToiQ2LM/Qks5WAGQCbX/f/jr5RwTPIZpAcgerdgL0mkiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 07:06:44 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 07:06:38 +0000
Message-ID: <bd21f7dc-9f89-40ee-895e-601c80165225@intel.com>
Date: Wed, 6 Mar 2024 08:06:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] overflow: Change DEFINE_FLEX to take __counted_by member
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook
	<keescook@chromium.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
References: <20240306010746.work.678-kees@kernel.org>
 <9c2990f0-7407-49c6-9e3a-b92de82ea437@embeddedor.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <9c2990f0-7407-49c6-9e3a-b92de82ea437@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA0PR11MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7ab7f6-7ee5-4819-eac1-08dc3dabf754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+txxnnWe2Tsmy8uiN0iOxIat67qN2Tsk6IwWWSa+qDfVEWvFn1Sgteud2jQPSeTQ56e7yzG3J19ug4QWd7HM2RGdy1e7w/Js3Ew6M7pvTZiyIWGabsbizFciaTSXYUiRQSUAf64aT+jsCm9dzvd65bXIsW+tKutmaqvJitaxth3U/jpKpKuXXcviYWSVc58zJTzLlwkc2yuTleR72Exd7KF5se/o/PMdXgd9lk7lwWj9wJur8GHWyH2FYU6DpVn0SU43MmX1Lk84yd8l8S7ddJJUiV3jZDUkrGJVoZl9pgA5lnclH7TZgwYQZnUfkRtV1LVLngXvN40Q3Le3nnS0qu3ngEsiGsR672zp86Nrilc97rb+R0hSAdOoUpF7/tnMTbGditi7p2CdwfFYY/FD0VTdwXobODX+gHeubXk2neY+Vk3TLC6aiufeoCj2R/Uay8zWxWvITiI9YaWm1WuRv4HBIxrXhrb53ULEFnEjeYXIHQUYqMSuOjmkFFStfcAxqyKStmOCHuS9ZAZMJFO6ysAOtKVPhZMjaNUNrJKdb6mNu/rLswe6rXL31uXz6AtMww4y4RTTWNCGwNFYw/j+5ddne3n4ZQQgwgLAC26HcWt78OxWz6tPtekfgyPyRjiN5T73Fwmu/bDt39Zt5cnv6KoCzMD8M34POSuzf/sHXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNocjRPOW9PU2E5WnArZDNucUxwcVd6SFNvVXhvNkwyTFBkdTVyVkVvVGRU?=
 =?utf-8?B?enZOaEl6di9id09WWnQvdkVVWVo5R0V3dGw3dWdNOSt5eFQvQms3cmRlcmtY?=
 =?utf-8?B?aE95ZytVWmY1ejlucHZHcUV6K0NyWjFPQzBucnBudGJ5MzV3bGx1VjJmN3BP?=
 =?utf-8?B?a2FGb0oxU21kcSsyTi85cnB4NE95b3VOZWdEdjNSQTMvdlMwY0N2VjRqWng4?=
 =?utf-8?B?REpJRFJNT3RuMjZ1Ty9pTTQ1aEZkUENQL2JLZVBqNWtUZnpGVm1PM2lYWUtz?=
 =?utf-8?B?U0tWSDZHNXNSUEZlcHY4NFhabXZWZDlTYjlteDFCRDUrdjRoWTNVNExha081?=
 =?utf-8?B?ekZScVVxOEVMMEZuUlVNMmlsbFdodWFIRFZaSURKSFl1QUlGVHlNTmFlRGNR?=
 =?utf-8?B?eEJyZHdoT2FSbVk0NXduS1ExYVhBTi9Qb0tXQ1Z3Q1NBS2t6czZvOVZXVW5Z?=
 =?utf-8?B?YWFUNXZvRUNCUTJOSnlvRzRiVzArREMwNnZHbGY2MnNRT2dtWWtPd3R2Vkdi?=
 =?utf-8?B?TkNLZmZjWDNzMlBORmU0UEhxcUFRU3hXZVQyYUI0bXFPdnREQnk2cmhqV0J6?=
 =?utf-8?B?N3U1T1dEN0NtdUFrc1JyRUxZbHhFdjcvWHNlTGF5VGJxSGlKWWZHQnVtR0pJ?=
 =?utf-8?B?SkJPbnNSM0dJU0NCNHJsZDBxbERGSFpGYkVEalVBUzc1RC8xZk84a0h5YklW?=
 =?utf-8?B?NUxiL1BCZnA4THBmR2tYbW5EaWFNT3FqanBJZDFWNW5PMzdUVUl4UTlsd3py?=
 =?utf-8?B?bCtrbG1CcktaTDlSQ241TFU5MDdURXNFQVFFWWtubkxZN0pBNDl5cHJMcUwv?=
 =?utf-8?B?bko5ckREVEFkdHAzMmFxS08xVldlaDR3RXd4VnpRUVRTZXJuVzF4NnZKWXdi?=
 =?utf-8?B?aEdzQ2cvb1VaZEpCMk5PWDVoNEREdFhrbDVSc041ZFUzcXYwd1pOcWlSNFZM?=
 =?utf-8?B?TVdqUnl5ZURkS0ZrMVI2dklMaGhyeHRQZTJibFZBNkdJL09vOFZVTWhaQ29z?=
 =?utf-8?B?SDBkaUg3VVIzUi90KzQ4bThVRjZROWVDQW1kNHFCK3h6V2hPeWlxQ0lPblA0?=
 =?utf-8?B?RGxSSk9GajVVak5RN2hCTk5XUElkN2NxTGZQRnovRXdFZWl4Y1o2Qzk1RGJi?=
 =?utf-8?B?VkZvdU90UUNqVVZ3NmdPSjlnOVFYekpqbWZ2WjZYQmtxQml4d0VoaURrbE41?=
 =?utf-8?B?dnlVV2pESWdWZ1ZnTFppd0xjM3ZxL21tVWNJU1pSL0x4NCt2TWFaSjFLSjVx?=
 =?utf-8?B?WEVmSzJqTFJreGtXVjBEZTZsNEpwb0xpOVBnK285dktrN0FjU000bXk5V2hC?=
 =?utf-8?B?TStkTGhhTkgzQnh4SXZ2SzNYSWlaTmR0NWRHdGZRQUlOOUdpcVVFWmxJbmRV?=
 =?utf-8?B?UE1qOUw2OHJEdWJaa0t6Wms3ajVzMmZpeUZ6QWFmM3ZjMVhLSU8xWDFVUUlo?=
 =?utf-8?B?M3Yya3dFekJxMDdLZHI4czk2WEYwNHk1cWp4eDRSWURFdnNENTVaeWFtekJw?=
 =?utf-8?B?RDFTbGgwTnJ2emRMMzNySFc3aFFkYXVrZ0s1ZHJudnBDZllTa3dxdENQTEIz?=
 =?utf-8?B?M3hpS1BqWGlNWjlEb3BpbGlncytpcHozNEpwTE9xckl2UWRKamhPRHBNZVJS?=
 =?utf-8?B?QUVURFZXTUp0SGJxMGQ5UWZscktyV2FkdlUxZWpLN1dNM2VtK3cyWStPQS9M?=
 =?utf-8?B?S3BGcUZrQzE5d2owQWZMZ0VPSEJudW1JeFl2cVNNdElZMklGeTJ6RHczN2k1?=
 =?utf-8?B?TlAycU0rZjNSVS83LzFvM0gzRW9lVTJxVFZVZlVHb210WW5JeEhNN1ljQy8r?=
 =?utf-8?B?RC9mRHFhSHMyZVdSZFQyUnFUSFhDbXlRYkc2dFY5V2dsS21NVTRia1RCL01l?=
 =?utf-8?B?eVEyRklFdlZWUGdUc1ZVTzJjMzB5ZnF5cmJUWHMxUEdtU3lpUGFHY2ZDUFBO?=
 =?utf-8?B?VHV0dGRBM0s0NGZtMjJWQU5jajVwdk16b0hobUZyRnB1UHBpU2FxMXdHeDNy?=
 =?utf-8?B?UjBqeUI5d0g3bVhqSUVPZHhzWjR4UURBMzQxbXdER0RTZEhZTkc0aDg0dUlO?=
 =?utf-8?B?ZGRBcEZiRlFKb09LNjNBYU9jcFEvdVlkZXJkWFo5RTFlN0ZIQjNNWUF0WVRI?=
 =?utf-8?B?TURodW1sam9xa2hnNmFKSk5yRkI1QzJnanVnMWNuVjJsMG85TDRrN2lPeEgw?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7ab7f6-7ee5-4819-eac1-08dc3dabf754
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 07:06:37.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z79nPhBMTQGN2Vw92b6p2SPoEax/SGyt5PfcdxqlGrDoD0fUe2aghIq3+y5QzyQ9XCHw9q3R3O5+XTSnzaNeKArqxc7g52OCa+NQIdQvsoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com

On 3/6/24 04:25, Gustavo A. R. Silva wrote:
> 
> 
> On 05/03/24 19:07, Kees Cook wrote:
>> The norm should be flexible array structures with __counted_by
>> annotations, so DEFINE_FLEX() is updated to expect that. Rename
>> the non-annotated version to DEFINE_RAW_FLEX(), and update the few
>> existing users. Additionally add self-tests to validate syntax and
>> size calculations.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
> 
> [..]

Just a note that ice changes are purely mechanical, so this seems ok
to go via linux-hardening tree. And changes per-se are fine too :)

> 
>> +/**
>> + * DEFINE_FLEX() - Define an on-stack instance of structure with a 
>> trailing
>> + * flexible array member.
>> + *
>> + * @TYPE: structure type name, including "struct" keyword.
>> + * @NAME: Name for a variable to define.
>> + * @COUNTER: Name of the __counted_by member.
>> + * @MEMBER: Name of the array member.
>> + * @COUNT: Number of elements in the array; must be compile-time const.
>> + *
>> + * Define a zeroed, on-stack, instance of @TYPE structure with a 
>> trailing
>> + * flexible array member.
>> + * Use __struct_size(@NAME) to get compile-time size of it afterwards.
>> + */
>> +#define DEFINE_FLEX(TYPE, NAME, COUNTER, MEMBER, COUNT)    \
> 
> Probably, swapping COUNTER and MEMBER is better?

right now we have usage scenario (from Kunits):
	DEFINE_FLEX(struct foo, eight, counter, array, 8);

> 
>      DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)

usage would become:
	DEFINE_FLEX(struct foo, eight, array, counter, 8);

which reads a bit better indeed, with the added benefit that we
go from broader to more specific:
whole struct -> array -> array size variable -> given array size

so +1 from me for the params swap

> 
> Thanks
> -- 
> Gustavo


