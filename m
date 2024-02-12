Return-Path: <linux-kernel+bounces-62286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B8851E11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF901C21D58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471D4D59E;
	Mon, 12 Feb 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFRbd2EX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0384D599;
	Mon, 12 Feb 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767065; cv=fail; b=lcme8Cn6B3jrJoAVTo9XPUwJlsBOSwczCvPrcs0nQROt7OhZsrAMm1tkLekMAtZnjE++SNCvC4eNSk9iFkUfVXx6H/q+iE+rjhpoeiH1gSoiYdDBLHvVafPXg31blZwjlUiYKrisO4W6KM2+J1fGDtEbFYasXbQ0RHkS1hFweeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767065; c=relaxed/simple;
	bh=5gJABqQ5Dlmjo2PfsgOppjylSZNgWyXQZC3jzboC4QQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ea6qXrJVh4gWGizIe1UfoBhoRYh6TPJKbw84yQkVdC/ilDzQnInjfqyzoeUrX8+x8rLW55zUqmzhsdw1U5SjGMdbApUC859yKZzPuAdvOYQXr6iDTkvR6DTQuclzmJNzhYpZUfqDpI9zNYa4smC+dHhCeXcwdvYDUBfHtD6O/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFRbd2EX; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707767064; x=1739303064;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5gJABqQ5Dlmjo2PfsgOppjylSZNgWyXQZC3jzboC4QQ=;
  b=WFRbd2EXlCLLUBbEfwx53djWp6PJK/I/wzaCDMPhHCts9ZSELE50uiiu
   WhECKIE9oNWJjEekjfwHtYLTf4B9i61VVvHqFcpmnVXyTxdj4vzxJnu0V
   /1EJvWJJs/TCFOYVhVDqb4A94PzaDkOeHJfpkgyRM0A2EXWoWyR2UsZ7b
   s0p/bkrU9v15yAtDxEHEiAS2DVj9fV3bXj7ve4IM/t2+wawImZixIYn0C
   ypfF+DlH+kYmt/ezDwllNqXBusIwFQdZmjdNwQpvjZfrXOR4z5l5x2owP
   ENWi85bfGEYrgEYpMBd9UA3Np8L6l7fr2frA7GqwJkZQEYUdPTtB7sDJ2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19172146"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="19172146"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 11:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2856285"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 11:44:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 11:44:21 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 11:44:21 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 11:44:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwVJUm7cX0tl9vRrQ7/UPxOA3DRhjX6DV5uNgw5+D3heyYFnpAOnaye2F4pFwMgg5ddzEwDm4ElT9ygRIMCAJp9nwD1INO+UZby4FQIrOo3KV3EuuszVEi59xADNziH8Carb9kyMAWy4yEU4ZqZyvDZ8mMkqkVwgwhg+w54euioAI8VwIQHxylPlbXUIe4eQB00Hb2B9xmWbWpCdenQHGDMMYIA0j/+QRWajXz1DTD4AApX+f3qJVjijP+DT/H7uCVkiGh7xm2KtahaRWxlVu4P/M3AYYy29q8MYj1z+uhBSMxmVZ2Sbgqw5tNATk5jzsb1o0a6Jj/iCgoOaEpgtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gJABqQ5Dlmjo2PfsgOppjylSZNgWyXQZC3jzboC4QQ=;
 b=TN1XFm/zV0sRVPAcBMHncAnz9UyIQUbe7Jxg24BDcqfbYdBJa90nkfMujmZ01KJrfHTRDfPoU91Qp84iE58uBScvXcVb1QD3dLh3Mm7Hb35sn19p2V43Mh/nzcXbHRx+oeRoOz1mvRwCB3r6RCPYZPkASyPbcOpOEpc4d+MXrZTDiD+436AfumBPpCOfZh8W1Iayp/wrofqvIC8c+pKoYgtgVxIwaKysMhEUHr1a8uL+RlNWaWsvva7RKW5RW+y3Zf4bOf5OM2njDSAbRSv6M1gWjDsFPa8ei4KXy6NO/7RjDhaL3rgkSANA7Bu6nEhUStLIkqm0nxJZA/Jp4UlADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 19:44:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7270.031; Mon, 12 Feb 2024
 19:44:16 +0000
Message-ID: <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
Date: Mon, 12 Feb 2024 11:44:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: <babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:303:b4::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 840de286-74bd-4252-aa70-08dc2c02ff17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNyOJW31iheM4Md4Dfg8tEsjsTIePtoicuHKIVZw2LJNync3U9ZWKoZLxGRABTpPcmUgM6Al+ecUKvYIK2WC6DhrY89twSG77qN7U4cggzEGXBLrQBuu3LqLuIaQJV7ooQl29G0dF6y+QMxfxlSwB2sQHvxK/k237jiyUcyGDcU9CNf6W+NzaoBzhNTNv+Arna393VVUmPkQSlyXLeJVzh+G8MFOKh4PSWrZxooMpkWTPtAEHNv7oDybaZQd3fco0J0bRgjVgY9FItQ6rC/A4n7WzBZ5PbcCQId6tNa/Glbm8br3eD8hjs93fcpuKxx/BWTdNgtJsRmQsFaBITtjDHd0Fx1s3utHRiJCkJQFnm8Na5DXoXetaAqx+wWUuDkbb1Uz1aNg3EVJXjg1pj87lIiVii6LUJUkXN3L1VwbWP28iKe4QYqwkp2pFUpdkU0DsJf/o1qlVdfVVLxkiVKojfjWT3OCahge66Ppq8w8v7xQqcBQT71S96rkBnDyYOMWtEJm9ktKip63i4Z68viXx3DVszhGgMLLI5CPRM2Hj5eoOUr/m8GfVPFiJU77iW9p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(558084003)(316002)(54906003)(66476007)(6486002)(110136005)(66946007)(66556008)(4326008)(8676002)(44832011)(8936002)(53546011)(38100700002)(26005)(86362001)(6666004)(31696002)(478600001)(6506007)(6512007)(82960400001)(2616005)(5660300002)(41300700001)(7416002)(31686004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGtaZkpsQzUrWEI0UjEwOFliakE1YkRxQ1N6QldjdFRWTzhFalBONXZlY0dj?=
 =?utf-8?B?dzFOLy9TTmZKWE1qVk9tdS9jNW00ZlVIS2VQcllGSEttMU5RbHlUb0JXNGI5?=
 =?utf-8?B?Z3dkQncwOGpKK0VLQlFIdE0vTGNqV3pZeHhXODZ4YnZtS1ZXVUl0Q1QrdHZJ?=
 =?utf-8?B?VVljL0VJaUpMWEt6QTNZN3hIVWYrK3NuWDhjdmlzNnpNbVR0VFFXUFRIZDE3?=
 =?utf-8?B?ME9hYUl1VnZrWmhqdnZSZklld1pYcDdoMFlkSnAxRGR3WmphMUtEajNzQmwx?=
 =?utf-8?B?S3NUWFk3V2FLeEdDa2NuRWhPR2RndU1VZmk1SXdpUmxCY2pJbjZLVENpc2xj?=
 =?utf-8?B?d1g2dWVXc2NRdzk2blFsT255ZWFxRG1WUmVwdW9QOWV1SmQxaVB2eGh6Nk5v?=
 =?utf-8?B?S3I3alRoK1Y0SFl5dlYyOGlkcDJkY0tQcG1wd2c2ck9ZckhTMWtsZ3RYdTIz?=
 =?utf-8?B?c3ExOXZocnBZb0NYK1Q2bm0raWFPeWI3UWxWalIxenQ2cVlYckFhVkVpdFE5?=
 =?utf-8?B?WHg5eW1tUHBNd0hrRjcrUExBd0ZmQlh1S0wybFZZbDFVbzN4SjUza1VUM0hY?=
 =?utf-8?B?R0ZGZzZpaWE4ZWNWNTAxMGg1djd4dGQydUtPZFRSazF0V3NUeGY0L2pqd0FS?=
 =?utf-8?B?SkFvZkNjNlJkVkM4WXplVEJUVkRyOHltNit1eTlhWWp6dERMYXF6ZEUzRjV2?=
 =?utf-8?B?RXRrWkNPMXB2Sk12WC9VZUR1Z0c5ekI1TXZtcUN5akhjQ1RNZHBpbjJ6MXZo?=
 =?utf-8?B?c0ZqYmJkOW1yTDdwY2RJa2JTbWQvSlpERFhFY212eDRiVlhncXhrZC9IYlFC?=
 =?utf-8?B?b3Btc0NCNEVJN0JGaFhza1ZycnBQV0daL0ZXOVNyR0RuMDZMMVhJRFdGWWxU?=
 =?utf-8?B?eWgzMHlxSGU0aDlaMGloNVJreXV5OFVUK2tURTVDSFcza2puQkdRNUF1WFFW?=
 =?utf-8?B?Wlczbmd2T3dJQVFGaXVicmlra3M5aSthVGRDSCtLakRRR2phVy9INkY2bjA5?=
 =?utf-8?B?elpNMTNiTUh4ZUhCTU8yVVRHWXRDc0s2eU9BaHNvemZmc21oUnc2MlhnY2lR?=
 =?utf-8?B?b1hra09uVmdxOGlLRDR5MXNHVTZqbytkakZmZTdVUkFxN1ZHOFB6V0wrWDZz?=
 =?utf-8?B?aGtpQ0FXZDM5cXpxMkRqd1I4aTN6YXdmRm80aVdtQkovcEdZYklhZDlKTDAv?=
 =?utf-8?B?UjlPN3FVR3EyY09HTDJLVkNiN1ZQcThUQ21xWjhIMkNBVndRSDBEanJ4c2tn?=
 =?utf-8?B?bEc2LzI5UERoVXFQc2N0ZmZoQmhETXQ1d3VaajdybmIxaDZ5STd1KzBpdHdl?=
 =?utf-8?B?VitJZDZIZ2Zwb0RPRTZHSmlaZnJub2cxeW5nMjNqOFQ3TWxHOE9iZmtyaE1y?=
 =?utf-8?B?WU0xY0ludy9jenhJQU5nNGUyVzF6WUpWNkFLdExDSGg5d3hFaUdFUW9lbXZJ?=
 =?utf-8?B?ZEd0S09QeFVkM1hqQ2wrYXRsR2ZQWnBoQXVaTFIwdnp5OGRaaWtoV1Q5ak1v?=
 =?utf-8?B?UEFBdFJ4SHRtaStwR1U3clQyc0ZJRlNQOUhDV0VJVERiTWpQTmtqOW1vd2xr?=
 =?utf-8?B?Skp4SWloZDNoclUzSjVINHoyQUtzV1pUZ3dnWFl0eWxvWlliZE5tNEJla1Q1?=
 =?utf-8?B?ckJZVWtPdjQxMERYV21NQTFwZTZiQlJmV09jelA4aUFHQ1g3a0VldEN4NEpR?=
 =?utf-8?B?ZXVXcTd6bVFxU0N6dndyY29LU0lRSmhjMWhvU0liUXN1M0UrWlpOL3dDQzRZ?=
 =?utf-8?B?OE53MnkrTUVCWWFKL2FYWG0yYjdUVVp3WTJXZVdpdEpHUFlnL3BGLzFRTmQ1?=
 =?utf-8?B?VHdBeS9ZWkNOK042WmxsNjdwNlZxN0V2SjVmeEhITXFUUGJZbmtlUG5SaVln?=
 =?utf-8?B?QkMwYXlzM3oyYUV1T0dXbTAxQ3RBdUwxNW02eXJBazNWUjhNdVI2UFlkdXli?=
 =?utf-8?B?b2NVZXVFajBQOXNiL1NHMVBtcG8yYmpPSHp3Q0pDb0wxcjdnbmZEZm5nUnhU?=
 =?utf-8?B?NFZEUlpvVWo4NVdWTFEwZGUzd1BuSlRZQWwrRmVhR3JEdzBrendYZUREZVl1?=
 =?utf-8?B?RHl3T3A1bFZSRDQ4YVZLVGZOZFdXQmpLKzYvT3dpMUZUZ1E3TmsvZEhJeGd2?=
 =?utf-8?B?VGY5MXNnbFprNGlhVG1EUE1RbVJtSFBsRmhISk1EdllSTVNkZXFNVkw1am4z?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840de286-74bd-4252-aa70-08dc2c02ff17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 19:44:16.2626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZ6c3fku7qK9kO5m12YhCvKEXAEovEKpXdZz4MO4b/xXXjPrIX2vu5gmxQQCuh1ijBCIgQwJ2ffD0qg/kkU7tz6ds2QduVKLuKrfCJsgmlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com

Hi Babu,

On 2/9/2024 7:27 AM, Moger, Babu wrote:

> To be honest, I like this series more than the previous series. I always
> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.

Would you prefer that your "Reviewed-by" tag be removed from the
previous series?

Reinette

