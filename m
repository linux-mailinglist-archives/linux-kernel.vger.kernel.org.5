Return-Path: <linux-kernel+bounces-102610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE23487B48A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC58B21357
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9093F5E080;
	Wed, 13 Mar 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7qoBznf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6388E5E066;
	Wed, 13 Mar 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370010; cv=fail; b=cSqctTbXTdEoSqTRBc4R5m4p3nD/0MJuYZFtiem9nVL0cWtrEdV5tRhaUApcNcbdwHT2QA2xqxQyxrnRnaWN0/0hYhthJ85X1aZvw2waQoiSaIVQaj4O0UdALSDg/0rFpANZeOBScV8QQxExP1ZoDjcENUHMMNQuYjdkS7LeGD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370010; c=relaxed/simple;
	bh=LE0U3mRtz7Pyxf9yKVCxHcv7c5abDUe3BjwUCz4rBZY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fvoOb2hF/UPa/qzK/ForHk3lyhoBgn5DDrphTeqWSWcLSGGlT+9S+i1pJnVtBuUtlUy4s7WX9yzDDK62Lb7a+5Vova3MeNWdXz1B31Lr9/9d4qmZAhhMyD0DjFKGW+AU2c/KLAFwcTgftfj1ZL8J93LJEyRtdLq0O7lCtliGOpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7qoBznf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710370008; x=1741906008;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LE0U3mRtz7Pyxf9yKVCxHcv7c5abDUe3BjwUCz4rBZY=;
  b=M7qoBznfIFUo+KU2cBj51RUXHMiwYsIe7nkhSGESwz4whpsP36nLAi3+
   aXPfDkwHDP+fskVQv6aGcK/pfZnhhXF/JaerJgAr00Fema5Ec34uvCzRF
   u1fADooAEw5pR9yH7BZ3Da/sSaz1lBX1ANeEdTT2GWs8yD/CtVEdt3y75
   2CjKUSdq+DjMHUzzIgforOYfUjwibUb9yRx150IrmWaJJzMaA5NY+X8vV
   uFmmhJhra9uEQj2zn/ZgEiQA4hJ0BQ36SX2GTpHUuCBPq1jThMAdpRmfK
   Chm548J6wzwGJwac5XoYxejJ4X1OKiV3WV6lkKtmQu57a6Tzn/qCE2Dw6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5021643"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="5021643"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 15:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="49527863"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 15:46:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 15:46:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 15:46:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 15:46:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 15:46:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aH1WUQsKdwrXqn7RJp6doZcofeN5QKmEkh99TNJFGNuj0IoqkFBRho+L0g8Ba6iQssmnh2MwEe+uzT9hCWGWR3mC72ap4rgLyKyTXk0m/epexDc/RkKZbMptM+jNSmOtkSHc4/2lLuZ6+5VOAbv8Oh1QQIaW1O8PCdgMDajcmJoPDVUeWXz24w2jtT551M3y2iLu9nICYCKoa91iDS5D8iVtXhA6BQF+P0dm7DN0qtMgf5QvthpwSf4T4hmq5wr7O1LpgidQebmgFD99FUnrhREazmSmeHqAnX76JU5rZS+ESNWVZUixik6YAR4yUjmGP34i6nZJ9ZkGtXpNSTUoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU/celcJMICE1VsaQKOamxqui8C3lIMgAXs1oz+VSjs=;
 b=EbFjhvn3MCvYH+HzHdhL+PIjPOHeRWgtQ6GtG31YYDtPP64evnbpu23y3KSaipI99YZi6vId9R1PVYgcLB0o3ebKLMWno00OpYL8G06ughhuTjq1HUtRiFIBJalMoMnzlPsHvOUP1hzx7uaU8AXOSixwVcJ3TuJe3v29HI/F/szRv5MpJnwjckiW6tiHyUoBoChj1SLN1tzrpORqavnD939WXvTR6nA6c6fVjILgh2YC9sSQVkJUqfVHfEIUOP7tQTqZxRfuGR+NbMvGUqxF8zxvj4wqTbBnmHKeMjXqf07B9+trEIIEhHzb4gu22IVi+Ix73M3LG+vu4THKeAAB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6140.namprd11.prod.outlook.com (2603:10b6:930:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Wed, 13 Mar
 2024 22:46:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 22:46:37 +0000
Message-ID: <f1fd3dbf-a4a3-419e-9092-ff7f9302c874@intel.com>
Date: Wed, 13 Mar 2024 15:46:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>, <james.morse@arm.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <peternewman@google.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20240308074132.409107-1-haifeng.xu@shopee.com>
 <20240308074132.409107-2-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240308074132.409107-2-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:303:2a::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b29c1cd-db65-4a6d-d6f2-08dc43af7112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3ufG1Mt8KpSL6LSH2ZRRmp6xdmXVlNSd5ZOKagC+KP8Oe09A5Tihik4/j25pO5fwe0Q7/CsTimEPo7Oem+RYd9ElkOQn35nr6gRkqDA8wtoyUxTMnzcjRZcSFn5KFtxzvWgeXqwR2m//YmVbGA43RintD6cYD7mHwODLWvVO/1mcfIgXczKBC/skq5Om1NNwEPvOmW6Gg6li+mdT3SEOTO7Rbf3l3sDlPYsTJFK7zLkOhs0HrAKbopHpcp1ofGLzECBvhXHYBdXsyADFVH+NNPgRxQ+PLK/c/eheQmAN/7DaxobZyKAdwYk6qGL17GW0DmWJT81sgPZ/cVuoossGJY0AoCmVJqfLkmNDqKYGPcpa9GVB0g+myvjaPPtm2IfCuFy/YBmt+7MlCusFX0ZIweekdJo+fD9Uzv6JlzxBW/F+e96zy9AvSwfP2IML640t8cCuBnurefgr8RwyZT3tLDEwo8/bDHqiY9CVdjMpOLUHmVD3qi/Qayqxx8EfzS+4LRhFFR3UUAmieq6fEf463ZBN+FX2vmMMeEVpkRH/5gPakY0Cvz8A7TGdRAc3KwAzA3fpbEsuhUO9av7vWx+8W7jZxCEXhSGvG22aL+i1lmYTT6m9+9nNk0io1qW//xsYfPEVd5gDBzgTI+iKoT1zBtC2AS9biotqJ9NrkMVvoo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJ5VFJvb09UNnpsMHhleUpDdys2M2dLeDBsMkI3K21OQ0V6NENVWmd1UHNE?=
 =?utf-8?B?dWlPZ0U1V3VxckRCSjIzRE9TcUM4K28xR3FHUnV6bG52dnFNQ2NZWEs1bnFJ?=
 =?utf-8?B?MDdNNjlaakJPdG9JS21MZEw5c1RmdDlxUWRUNGFBYkhqY0hVNEl0ZGJydk5Q?=
 =?utf-8?B?aWowdTd2dHNBeVd1YUNtZWFEb3VUWUNheTBjRmp4bFFUR0FKUGR3UmhuM2tz?=
 =?utf-8?B?OTlGUW5ucXhhK05YYnpadXcvTzIrTVhwMG96dG91NVFiSHNETEx6b3FpQllR?=
 =?utf-8?B?VnUzbUxDNEFwRzdNcUZlbnJpYmp0UzR2N0oveENxSXFMZjgrOG1tRzFjWElI?=
 =?utf-8?B?MDFWbWw0L29PVVhJbDdFUWkwdG0xNWZzTURJbDY3c25nSnBJNmQ1d2VZZTk3?=
 =?utf-8?B?eTFyMzlZYzdMNGJNcysvNGhUVFdLL0ZuTUVSKzZFaitWWDVSZlNSeFJOZkh4?=
 =?utf-8?B?ZWZsdTRhYkh6Y0UyZFB3c3gzQjhUd0dIZHlyaHh4bExyeFVqS0pncWVTRFAz?=
 =?utf-8?B?MFdXRmFQY1N4c0VNd2tPSXp2cUM1MmVsSTd1VEUwaHQxWm4wTVNPSGdVZmhD?=
 =?utf-8?B?VnAxL0U1UkFKMHhaYU80cThneFlRbGxrZTVBL21lcml6M0NDQVowZlpLYkdI?=
 =?utf-8?B?ZWNOZ1N1Y3kxZlJmQXpveUtjR0Z3TGtPUWVaK3pKN1NSdDhHdFpnQXBRVkk1?=
 =?utf-8?B?SGcyS2RpcW9mOHVzM2Jwd1FOaExEc0sybnZHKzh5SjNQSlp3K3hFUjZjMzFv?=
 =?utf-8?B?ek9DZ3JjS1FTUE8yTjlBdWhMcm1ZSUR4N2RmZEcxWW4rb0wxS2F5WkNVMWVR?=
 =?utf-8?B?amZtNlJneDZnMFkvQkhCZCtTbWR4dnVTVEk4NmdpeFgxeXRsN3RxWnU1WG1Q?=
 =?utf-8?B?TVQrSFVKWkNvdzF3L1UwdnVUcU9uT1llS1dTdFVqYjJLZGdJbkJVL2l3c21t?=
 =?utf-8?B?MlorWFFyUHhXbXlIZUduWUdMbVlEU09MZFFNd25aSVFZZVRnRjFOTGtxcnd1?=
 =?utf-8?B?UGhnNGRncWx1OENlL1JkdTVJR3R3Zjh1SE8vRUhzemFjTWcwU0hzR1pNSkJy?=
 =?utf-8?B?NjU1ZHdYQUp1U1QzVDErNjhTUzJuemJ3TGR5azNPMjRHem9pb3BuSTQ4UXQz?=
 =?utf-8?B?S2Q4ekVUdW5yVzYrdmdRcWR6UHIyOTdDR1NiSm5FTUFxZjBvU1QycVplckFV?=
 =?utf-8?B?RzMzcW9NWEJFTStJZWNwcDA0VEVwaWFtRmtPazRFOHNrRmdaVUExUFF5M0Fx?=
 =?utf-8?B?ejFkYTh2VWRHOFJuN1YrMzNud3h2YUxteGNvekp0NjQ1eWZzaGg1dlNIUGx5?=
 =?utf-8?B?c2lqYmdOTXUyUTF1ejhMYkFLMkI4UnppR1YrbjN4blo2NWxOdVdQWUhNczdZ?=
 =?utf-8?B?QVg4TXBzVVNQU252WlIxSDQwc0tsZDR5NVN5VitkdENOWENEdFhzNmZFRGdS?=
 =?utf-8?B?Z2xyREt6WlViK2s4TllMYWttTC9EaHFndkJ1ZmdjZmhDZDdIdnRCckhoMWNr?=
 =?utf-8?B?dEZvekJ6VTBCNFpSZlBLS3FLUTFieitMWlNSclNlbnQ2b09HQnVGTWpOK3hF?=
 =?utf-8?B?SVhiZWo2WVA1R1V0dURkTGlwRDhweXhKb3Nnb1dBcXFCbzhNTXA4RjN2ZGpD?=
 =?utf-8?B?NUpjdXc4T1ppMnozU29IODRGSVYveEVBSFBRWDlFN2NSZGxLSDlaNGpEVkRG?=
 =?utf-8?B?M2ExMjUrZFRiRTNvRjduM0NlQzRSUG5WNzl3YTdEMFRwOHVLN2J0SEtSNHVt?=
 =?utf-8?B?WnFTc0lnNWVBb1ZRRStTL1owN0J2Y2NzWW1ERk8yRll2ejNVYWVYQ0ExM2tv?=
 =?utf-8?B?Y0FwMnBTRXVPN3RkRU1VUFg5d0h3cDNVclg3SVhDZWVDNnhsSVQvWHpMV2c3?=
 =?utf-8?B?MnR4eWpvS2NRMmhhaHEzOUczekVVa0JwWUdLYitBVDdmMnA4aGd5VHE5Yko1?=
 =?utf-8?B?L0puUzFoSWFYT1cyOXFlbHIvZ3ZzdTMrWk11dEZGRndPTFRuRUk3QmZ2VTg3?=
 =?utf-8?B?eXgyRGZrR0MybEFwQnN4aTdPSnlEVjF3dGwrcGc1UGhkSHhVeUJHck1uWG1F?=
 =?utf-8?B?bUx2aFR1cmtMTytzZUFLek9QYTZ2VzQyMUpzNlF2QkpWenJ5d242Ui9VZEd0?=
 =?utf-8?B?MkJ6NU9xRDNleXBVWWhIU0NwVVRhY3BqRXFBSVhzVTVQSU9oaWc3OTkvMk5L?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b29c1cd-db65-4a6d-d6f2-08dc43af7112
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 22:46:37.6964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD/r2aGzWxTmXsb6WMJ5YICmW+Q71eO4nN5uCHArLSyenzS5citUAAWh6zNryfL1fxuc0m+EviTqnoipcgmW0eSwALuqsEw/jPClkt6nGJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6140
X-OriginatorOrg: intel.com

Hi Haifeng,

On 3/7/2024 11:41 PM, Haifeng Xu wrote:
> Now only pseudo-locking part uses tracepoints to do event tracking, but
> other parts of resctrl may need new tracepoints. It is unnecessary to
> create separate header files and define CREATE_TRACE_POINTS in different
> c files which fragments the resctrl tracing.
> 
> Therefore, give the resctrl tracepoint header file a generic name to
> support its use for tracepoints that are not specific to pseudo-locking.
> 
> No functional change.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c                   | 2 +-
>  .../x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>  rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (88%)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 884b88e25141..492c8e28c4ce 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -31,7 +31,7 @@
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> -#include "pseudo_lock_event.h"
> +#include "trace.h"
>  
>  /*
>   * The bits needed to disable hardware prefetching varies based on the
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/trace.h
> similarity index 88%
> rename from arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
> rename to arch/x86/kernel/cpu/resctrl/trace.h
> index 428ebbd4270b..ed5c66b8ab0b 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
> +++ b/arch/x86/kernel/cpu/resctrl/trace.h
> @@ -2,7 +2,7 @@
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM resctrl
>  
> -#if !defined(_TRACE_PSEUDO_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
> +#if !defined(_TRACE_RESCTRL_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_PSEUDO_LOCK_H

The above #define should match the new name also.

>  
>  #include <linux/tracepoint.h>
> @@ -35,9 +35,9 @@ TRACE_EVENT(pseudo_lock_l3,
>  	    TP_printk("hits=%llu miss=%llu",
>  		      __entry->l3_hits, __entry->l3_miss));
>  
> -#endif /* _TRACE_PSEUDO_LOCK_H */
> +#endif /* _TRACE_RESCTRL_H */
>  
>  #undef TRACE_INCLUDE_PATH
>  #define TRACE_INCLUDE_PATH .
> -#define TRACE_INCLUDE_FILE pseudo_lock_event
> +#define TRACE_INCLUDE_FILE trace
>  #include <trace/define_trace.h>

The rest looks good.

Thank you.

Reinette

