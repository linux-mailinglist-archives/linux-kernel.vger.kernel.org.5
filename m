Return-Path: <linux-kernel+bounces-64222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A19B853C27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F6FB21EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B560B95;
	Tue, 13 Feb 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWmWoK1W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFC63D5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855827; cv=fail; b=Zt8wm2DzpJYwOppcDkEvOxlGz2BcNR+ex1rp/EmrOr7z7yes4ZG2MqBEXuEEt4yJj1Zs2+V6BsQKjrVxTrqcsqXCCAWCQE1XaZGrx8e01bUnZdFeGcAfkLLt2CpLnQWvwt30Dsy1OELv/PJBMcaMWmWTdCw1+h3SOqagEVyrXJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855827; c=relaxed/simple;
	bh=8t7N1UeRUJqX7w8VL8HRKZtEDKMVG/UMDq/sSMYVYf4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rJpmJG2/1UzWMcrDeJsImaGdRX8QG72oQd5oLI4gU9d3vo02E2NrVeOPEIDM7bZV1Ww9p6vIK93V/3AhQZENVwsdSFKfY38Oq8fov+wCCvSO7I1yip28TOeIiPmylW3A3pUOy4b+xGAZ7VuKfgChr5VeUevpgFGxhnZecQ9a6UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWmWoK1W; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707855826; x=1739391826;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8t7N1UeRUJqX7w8VL8HRKZtEDKMVG/UMDq/sSMYVYf4=;
  b=VWmWoK1WVIjouQXJNAP1s23IhRmJN8yD+Mx40lixQydCdKjsCvC1xFwv
   l1XC8gImchSY1SdHslhhmMcrWW/S52YS8Xz1tEnNgS+91K92JGdHxvn8j
   E0wK3X91Qs8REgAjanHRqdVTa97laS1Uvx/DfaVgpEFsuSbwk6P9grLsQ
   /gIlumqJyC032W1e1Sd54pbodbFcEqTBzlSwURP/A6iInu5HmKOpJAbRi
   QGIwcM4henlT1U8sGhTaXZds4sRQYBTjd4PDTwxmZFSbuERDrJAZFblNN
   o2Wnnns5Dzqf/Bc/Uv1NzX781gavd3Xv31GnGzzO+OWye/TMbTxeV7j/q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13267999"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="13267999"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 12:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7630401"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 12:23:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 12:23:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 12:23:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 12:23:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 12:23:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjhbusBKp7JxXSLNLGRNdSkhngF6tC1SCy/QHmDV4Vv1xJGe1qqeaQIOkBeVejfCrnuGaQgLkuPEweeuYp3RYBlcnJACpCNqILro6fqIlg/dyEjJB2X5TJ9MAZkR4cF/cw3Brlyki4WcQVcAGisEaHgmT7YN4Rnc+MUqfLd20kXvPsnBEdXSpLTvTjmY7/1qMtXbx/gwvqnuvGJ+mwYuKqpoZ6xIf/8T9yX1ksvP+VSiMZ6CxPH+sBKonkPrV0t+V5uVH3sviUXIgirrl0HNn+S9e6nanwShPDBnlWVUXsUir4fQTsGh+SJ8IJ1wDig1u9GE7Y6mswNEh6aOfWFGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmC+2GMwmvkTsiZ5eqC8WRdUuYYnKqOepxCYomNPE4w=;
 b=mmeT84BSj+vzCwfp+ehQ3EPA5PN955QBYclAt0MpVMtYsnVddjtQSuGgnCbKHO8Xxxwgl7r1jxaPZMzuHz3XCYKcie82l8SDzooXtYQiSVopyCgDmYkTjd3qCVm8k0qApZ4u8x262kXfYotbVFgak8zAV09G2E+QaaiZlPop2ypx+Wx2K925gDoF0xOOC0D6ALyXCFXfOJAHE1FPAtNTzLGfU8hQhb/s6f7tNkm4hYb1OdUaUlA6Ezjiv9wyFSm0XyNFXe+zhWhfwN84W71VmGqv9pUQNeBHiFF9mgMTSMTbFco80ccd4oyHwDL+MhpCZkQmxZpzia7hIw9QDGTC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Tue, 13 Feb
 2024 20:23:35 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 20:23:35 +0000
Message-ID: <bb59cbaa-3c83-4445-9db0-652224c3f84a@intel.com>
Date: Tue, 13 Feb 2024 12:23:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch v2 21/30] x86/cpu/topology: Use topology bitmaps for
 sizing
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, "Zhang, Rui" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Raj, Ashok" <ashok.raj@intel.com>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>,
	"ray.huang@amd.com" <ray.huang@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
	"Tang, Feng" <feng.tang@intel.com>, "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>, "jgross@suse.com" <jgross@suse.com>,
	"andy@infradead.org" <andy@infradead.org>, "x86@kernel.org" <x86@kernel.org>
References: <20240118123127.055361964@linutronix.de>
 <20240118123649.739960607@linutronix.de>
 <7c8874d971c69fb4c22c1b771983f8d5109a9387.camel@intel.com>
 <87fryjhmjs.ffs@tglx> <87mss5k54b.ffs@tglx>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <87mss5k54b.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0095.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::36) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 98692f88-476a-440e-d94d-08dc2cd1a78a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEFCqNLB8YW52t1OPPc9JCucUI1sfrXtfTUYGjyeWDR8H/cBx6SZM2cgXAmPxeGHG1/49XDYb7ZXtdNk78YzLdFBsQC24kiNXIH3ZNbr5wo4/DAf+Ki4RlE9K7WpP00LonMCaw3h5pVxwMWYBNDXqB7I8UeVVxAQWAa0HrRv0Tbi0R/a2xv5IQERwUuZk6a5qkNP3rB8c4phzA2TpNMOcfcY6eUJ0gFJZOJpnTKISR0PEVJOSvGSEkvAtmtnSUdMTBJ4bYlnB0wWln01N4AnpSeOE269pZzOoI1OF38ei1Lqj/65vWwLTACAbFGl1Q6EU8H5mu5axJWe3UUMIvu/oJpRW9BlUxeCKzrKfWwIak9F+ACRktTfo7EhS39YFcgLiLa548857rbM2y2LjTTaMGsPP3MTPkq/EeEQD1Qhf7OtYADt57L05cvVpYy5UrYrmpcd9/ucXugHE0PXvNOkreSmabHIyL+m0YyJOEUfTxnpYT6Ims5sfaWLiDfvZ6i0OD0NWhdcWg7+ZHW+jvgILbSoLbaDGjfTd5KLTjAT7/0wYx72wihuWGuE26amZnYP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7416002)(5660300002)(8936002)(44832011)(8676002)(66476007)(66946007)(66556008)(2906002)(4326008)(4744005)(36756003)(82960400001)(86362001)(38100700002)(110136005)(31696002)(316002)(478600001)(53546011)(54906003)(6512007)(6506007)(6486002)(26005)(2616005)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNhK0RCWkpuZ1FwYUpSVDhBemlGS09LelQ4aXh0T0Q4QlkrUWJHZEJuZ1ZN?=
 =?utf-8?B?SkVtUEh0ejBvK0RsMlFycVVnakhMbWtRU0t1N0Q0MmZXYXpjK1pEVEw4U05Y?=
 =?utf-8?B?NDNjWWp1Tk9iZlE4azczbzVKWVFmMGpQcnJVVW9JeUFzNVk4amliSnU0dTRq?=
 =?utf-8?B?R1BndGVyMC9MMDNYTTJERjZVNTVUQkJXWU95TkJCK0N0TVc5aFFvNUgwU0dj?=
 =?utf-8?B?OGYxT0NFM0Q4djJpZ3Jqd2lGVjZ0QThNanNkVlpLTUwwV0FaQUVWTUtEUmNa?=
 =?utf-8?B?dnhSNVF4ajNrbWFUVnRLUnBhaGszVXQxd3E1ck03TS95SlluanNUYzZLYzVN?=
 =?utf-8?B?SFFaenJDOEJEb1R3dWpQUFcyOEt5V016SVhCS3pYakJnNitwdllJS3ArZzJU?=
 =?utf-8?B?K1BWM0ExV3ZoTVBFc0JVdWxHVnBlYXBVZ3ZzL0FSSjFZNHV2cFR0Zk5xemxT?=
 =?utf-8?B?TkQ2cGVua2NvZW9xUmlrem5JYXJqNTB2TmJ3VWJPa2JEN1hYVGg3MTZMYlE5?=
 =?utf-8?B?REp6VVVrM3BKWGU0VlRKa2JwU1pSTkhsVUJsZFFUUWRxMENwN2llRnJha0xT?=
 =?utf-8?B?bzlYbEh4bmxnUHRCVlFYUUtOWXdSTC9adUh4ZDYxWXFwbjlXWitoNTVIVUlQ?=
 =?utf-8?B?M3BsV21COFlIZGh5ZG1PNTdwNzhEaGorZXZKOXg5VUJsTk1vOHA3cHVVSnNG?=
 =?utf-8?B?OEJsV2NYVVBFamlHenhsU3VVdHZUTlJpVUpuaXlVLzdjeEt0RGhUUU1pTkdn?=
 =?utf-8?B?c1hXOUl3aHFOSFpLeWcyelpNa3VCUk5tbjdOZHdIeXNSb2Nqd2RoN040Q2Vv?=
 =?utf-8?B?SlFrY3p0S2xEeDJJRkZUOTFNbDZuZUNMb2FRbW9VYTN4cTVDSGtHK0VxcGdj?=
 =?utf-8?B?N3E4ZE5sUXJaMFR3UEpmaUczWnFPYXdrRDNPOXJQSW4yMzF1T01vUERQdjdI?=
 =?utf-8?B?Y0ErK2RCQUxqaURqVjJSbWpxK1RYRkNDOG9iN3g5UGxYK1NNOHh6b0JZZWwz?=
 =?utf-8?B?S2EwclJEdVA2T1Z2YjdrQ09KeGFMVWRFZHFBUzhOQTEyWUJ0eFFQS3dBMlUw?=
 =?utf-8?B?dmU1N3ZnOUhkT3Z5V1RGcUthdWlOdGgxcWN3S3lwcGRHK2dDdmxaYkNpTU9V?=
 =?utf-8?B?K3lNY0J2VC9Zei94c2xxdmhaSVVOVEFJUTgzZlVqRXFTbFlGK0NnVWp3QWpv?=
 =?utf-8?B?UG5rc3h4eTBOSGdMajRETVRVaTBJNVBPODkzcmlZV3htN0ZXZ0l5aUNTUW1r?=
 =?utf-8?B?ekJpSmxkTHhCMUljNlFwd3lObnRRUlhTcGNWL3ZJSEZmbE9yUm5OdDlKQUFh?=
 =?utf-8?B?czRFK0VWMkx0M1dSRFp2VHp5NTA4RzljbnA5QlI4cXVLM2Y2WnJQWThNNXBH?=
 =?utf-8?B?UXppMWVGRnRsdE5IRHZld214bkJ0NDBaUnFYVldSdXFRaXpoNkhzRlZnZW9R?=
 =?utf-8?B?VFdxVWpGZEI0YmJuMkJjMDFtQWZQT3JpKzRDZDY4VExLN2duMm9EK3RpNTNN?=
 =?utf-8?B?c25qNkVpRHJwQnd1Smlkb1RyT2U5NDZLMXY3VHlKT0pydHlydUxZVnlZMEZB?=
 =?utf-8?B?TldHZWpjaTlLc25qbE5udFRpNmF6dnBrQXoxZk9uQjl0Q0FwTWRkellCY0Mz?=
 =?utf-8?B?clJhYjdjaGdXNk5rRHlDNTl3WmdtWmxsOXlSMCsrdUNBczB4ajg1ajE4aERJ?=
 =?utf-8?B?em1LUWM3QzJyMEZxclBRWVZ3aEZqa2hGUFYzcEdvT3RWYWh2eVVHaDhNWUpk?=
 =?utf-8?B?d3FhQTIwOElHSURKcXJieXp2OE42ejh4RURLUktXNWVldFRUM0xQa1o4R2ts?=
 =?utf-8?B?NmphemNSV0xRQTdQRXJNQTVpbGVRNWp2eVZTNUdHQlk3T1NwYnlhNkJLRXhN?=
 =?utf-8?B?ZlZZdXQrVlRqRGF4cnJleUJEdE9SL1ExTFhIOGUyWTJKZjg0SlZmZy9aZWIw?=
 =?utf-8?B?UXNEekNaMHN1OHRGVFhqejJnTVhVR2F5T0pHR2VtTVJFV0J4OTlrS3N0M3NK?=
 =?utf-8?B?VExTNjlEMWN1dXUxa3QzOWMxQWVSVHErVWR5NElReEdwMmRHampzaFliWmRL?=
 =?utf-8?B?VUtjT1ZIYnJQMENDSmE5dlJqUDhlRkhZVExveXNpY0VGQUt3WGRNaTk4bFhk?=
 =?utf-8?Q?VIEoVQQu8RgkWp/ephj18e6u+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98692f88-476a-440e-d94d-08dc2cd1a78a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:23:35.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IDFbBZmj/1MPE7uVS69nuAZ9ZuoGDSFXEK++JS9zgWXhzdQa0IF7jItZEemYULnLszeSuAUN4hIDxZqicyovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

On 2/12/2024 8:40 AM, Thomas Gleixner wrote:

> I pushed out a new version which addresses this and also the fallout
> Michael and Sohil reported:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-full-v3
> 

I see the nr_cpus=1 issue resolved as well with the above set.

Please feel free to add:

Tested-by: Sohil Mehta <sohil.mehta@intel.com>

Sohil

