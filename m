Return-Path: <linux-kernel+bounces-82566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F686866B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDB41F21B99
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEF748A;
	Tue, 27 Feb 2024 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBaZ3Qwl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEDC2916
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998688; cv=fail; b=MuMsDnSgLU+E88UWRmOwMetCmv6gFKnZKN+c+JYOg8hy3jXN552KXP0E2D4PzozQ0Ya+R1dzUWkbBHm4XFhOMRBtTCEQ16N9cM9TQb+NrNTNPMx8t+oJt3iDpRTkkTC+9rrdUdtiuZ9Dg7ZClCebqAPN7YWtWY03kP13+kdW0VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998688; c=relaxed/simple;
	bh=efgUkltL6c55Mij62rxXM81og/PZH+sjhJ2ZMq82aSE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dk8HMSoe1m0qTUqXPno1FJBcUXoH8Du9WFqWGlJHVL4nFtcpgsSQJQkYNP5tLNvC/+3bRdp8XmDC0nO/A7wOZ/YGxlXYPp174+hDq04HzxqSvznaYlHH7gQlmsByWGCiVd3bilvWv8iuMAyc8aSDHOJFsrCtfNwHRNiNBcuhQSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBaZ3Qwl; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708998687; x=1740534687;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=efgUkltL6c55Mij62rxXM81og/PZH+sjhJ2ZMq82aSE=;
  b=JBaZ3QwlN8zl/yQSxd049Kr5RYDRkpwBkXl/WySVLXKp6wNEQ877SZOb
   gvQArQ3rBNPPS8mS3xyu/8AA1Y9o00MyBbzMDuMIVDXhaiQnyyqFHJ4Gv
   xD9RTJ+3vlA3VDZibM43JByrI0Zi8j/H5qvkjmdIfo7Ka1n4P61ljJU4d
   nh+czNmA1it5HJSofTkyWxCPl9GD9WIKEqQkkFGNG9P4pby4bdy5QR3HU
   uY2meMJTHpGXJsulc5OH0u1xGxFlAJ42ZKM2fSoC7QmqxP70yx29tIVYj
   6gVDQoWpm+RyRBS06dU3zii++hduLL2j9fOxe0u1NqWDnrlN1/eMMrt+v
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14759393"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="14759393"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 17:51:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7078833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 17:51:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:51:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 17:51:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 17:51:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbmYzWD+/huxre07MAMK9gsfj22Xn1IgVxvjweS8mU3GDTQyEIY5NcH1NAmi1eQNlQY38RhuymFI9wrnZ4WZYYN2e4DdnQU6k01e6dqifcEnDkD3AdvHc6qMs5n+Wp18u8/kYL06zKzTAK/wXsdDBb9EEswFaSxO7bqom3ypAcmI9UBnHb9ZUPNwv9iBBdUHVxmEMkPeTd2dUVlfz2K8MUv/cwdmuzSQUJ+8uoZP/jbMmDzEwoXTjlvHkVRhoNOeS2oeQG3GEP5YbQvuLXXqQ92jpUI5NwAotuWBO7/R36wn9/NvwXwetvuo2SMhoyP0FZ9AsKbb1CtH9+O+cDlUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXKpaHYTNLn9syb15EjvshEfO3hidvfFr62+UOvyl+o=;
 b=fmaDpEb/aVgoYAY5+RfktqaEYc9GvSR+so8+98rPJO5wZjjtcdZK9YrppL2WR1CyTz1r3s5UYNITRrGxjC+W3EsqlKLwKFlJpBBdR9gl8jf576FeYspax4eVT5WGBssCnnbfmevcXtnsbtMpMIS/R+A8AHqq5Wqwp77QHnqHVJboNcfsWR5lWorsiT5BMuU7xyFs8y4WPVIepW4ozu418xuYFIrPYltO3y9x+y38D7SARPPeE7FgHYX1atlkI0oCxrHFAkIMHUZY5l/6JfTxX/1r2B4VuUgllhUO3geJO5ZU6VcEb3a5PbwZHL7c7DjlRmOr/zgTNgrzvr7HDH3Sxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6186.namprd11.prod.outlook.com (2603:10b6:930:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 27 Feb
 2024 01:51:21 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 01:51:21 +0000
Message-ID: <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
Date: Tue, 27 Feb 2024 09:51:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: Lance Yang <ioworker0@gmail.com>, David Hildenbrand <david@redhat.com>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mhocko@suse.com>, <minchan@kernel.org>,
	<peterx@redhat.com>, <shy828301@gmail.com>, <songmuchun@bytedance.com>,
	<wangkefeng.wang@huawei.com>, <zokeefe@google.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com>
 <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::36) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: e9220ffd-120e-4d86-f41f-08dc3736991f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJB+77ynKQWL4cHT+razCMELaCVpgNX15DLVkvRi66SWC8kCXnPsIXz2+0jib/o1oqZPF5L9Gt0EM35S6aRdrj3/Gi+Sjh3KnzoBQwyISNoenICJCMxSuuFvdSUYGAwyJ+rG6W1AK+Ph+UohR1GwTJDlFo5eIgjGAtjnWdIJu/Qc3sOjeNpmm2RtdMg60Hzs60Z4s1PwzA760ua/1QUb3y1elzU9QQt1OoJZSPbyeFqdI4u/lY5awY0kzt6NEyHhfwgcWnA1zFtgPyyc8rQL4IgElx8o21FU0pl8EQLo60IBxmAeN3yAt0WD/3N0SiyunpoltyIGZtIMjeQDE5eLFCCNFIg4HCglrYXjPW3Or2ySwSRF+5xRCq4XG735UP2yiExuh0iaZ8pvD2LaC6qNhqptNMzYZGzKbtGhiw5ooHf0B19qkaod77c/re2lavEcNKbg1UmPLfYhIYqYTDVMI31pYu+xTqGUZNKd9+K6pWP+LenIaE9Jb6snwpyVqDtIHpbv/FFb6BQR4GEJLwbvTyhkVfFQzhdbyzNKRzNxFR+DWZoWmegTGLIG/e7F6ADMmDtlHsszAzvWDM8rUPHNahhHaSOf7TO/xZ2qU45kZyRiweCzxJca74XDgka/t18H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpSa3RBamlDdldUSzBFUVQrODc5MWJEd1hIUzFjNE5UYlBRQ1hqNEx3UjBw?=
 =?utf-8?B?NGFaVXFWQmZKZklzaS85c1M4Ri9qQnA0WDB1ZmhCQkdUQ25vcHdHalp6YjQr?=
 =?utf-8?B?SDJhMWFSOVZtTnNUY0pWRGxvdXhpMGpzQ1plc1RBcDArOVV1d29hZS9tcGs4?=
 =?utf-8?B?Sk5TYXY1QlFvU05ySXR2YTZYNTNsb2FrZTBSSUhLdWdzOEVhZm9LckRSZEhq?=
 =?utf-8?B?c2xsNG9KTXBuWFNnQ1c0Z3FuNEtZbnNoVUpzclNsSDZZYTV5Nzk0VmRSTDBD?=
 =?utf-8?B?d05qWndSVnhqTW9IQjNwTUgva094THRnenFkc1lwaWZvZmkwSThvRTBtQVRE?=
 =?utf-8?B?UDkrL0tRSkhXdWpJVFAxTG1IWDBmQmYzazN1cmJ0ckdnZHhDZnU0QmFRM2JB?=
 =?utf-8?B?SzV1MDZrelR5QTdhNGY5Smt6RCtvU3hMUWpYaGV6VlJHTWgvaVVtQ0dRWnRN?=
 =?utf-8?B?Yk1uekpTVXdienBKSTFnY2Zyei9BK1FYZnlISWluZklvRGhvTk42NjR1eTBZ?=
 =?utf-8?B?VXhGYUhMSUJYNlM2Z2k2TjRFY3FSZFhTQVp5aGdWaTl6QjRXMkpVaXJUVHda?=
 =?utf-8?B?R2cveSs2ZWN6RGNhUnZPQTFpbi8xUVBES2JQY3pzbi9FNGJGS0JBdTVNUG5W?=
 =?utf-8?B?L2pWdzQzNE1vTitBemRhYW1FNTFhNGZCdWgwRERwLzdpTnpKZldvZmlKUHVt?=
 =?utf-8?B?WmM2UHRrcks5Z2s4V0wxK1pTNHNsblhKWFdCK2s0aE94anZDaml0NlhvT0FQ?=
 =?utf-8?B?V1FuUitMeVI3NXVWUVJ5am1DcGNqNnFucEpXZjRhdTRuVVdtQW5EYTZVanUw?=
 =?utf-8?B?YWQ0d2Q1UlJyck5PcTkzT2ltMnRiWnBCNUdMWFdyTElxeVpRbHdBKzNtcUow?=
 =?utf-8?B?Z1RaeDVLY045a0hnZnZJUzFnbUNwUkRFbVVYRDFDN2hFcFAxQU9FdFJtMUVi?=
 =?utf-8?B?WG5jS3FONGsrNUhGODNNYzZhbXcyUDliQ3p3RGY4d3pxeDZQbEhJcFErN3hM?=
 =?utf-8?B?cmxqdXRZcTBYeUNuV3dJSS9IS1J2SW1RQ3BWVHRDTTBPV2RESUlCdThDbVBn?=
 =?utf-8?B?NGxRMERNVkZ0aHBSQVUzZGtybDdxUlRBTURxUE5LQ0FDZmQ4blJoVFdQanhC?=
 =?utf-8?B?SHlLVWcxQklGMkFzYjV6cWxjOEViRGNsWGdxMm9kbHBvRFhUYlB5RmVOQ1dC?=
 =?utf-8?B?aTd3WEhtQngvclpjN2huU09jZ3BscXF4Zms2K0lpdnAyVWlIUHJkSW5qQkN6?=
 =?utf-8?B?RlhhTlZNTlFFcW56OFFWMUJSUmJMTlVKZDJicGlqeXpGRkNvTXFiRTJHd3lw?=
 =?utf-8?B?c1hwaUVGNWxHdkdTUE02bTQ5aUttSFVqRk1UZHZIV2x2M3hIZWtsOUhZMTVC?=
 =?utf-8?B?b2VsYnlIK0cwZWFyTlVBN1FCWjhYaGhKa3BURVhTSm9XRHBYSkl3MlE1dE9w?=
 =?utf-8?B?eEh0bTMzRTFzMmkvWXV3b0J6dnljWldRZ1FvNmdzaGFiMnBlRXBJRllqc3hF?=
 =?utf-8?B?NXVWdFcvUWVLZ09VaTQwSUQ0OFVaaVh3K3gvUkFCeHcwQ25NZStZcE5SSVNo?=
 =?utf-8?B?Z0J0ZmJ5b0hCOFRwV2UyL0RiK3BVcHhRVDhIc3UyMmFuWjltWnl6VFZyVVBo?=
 =?utf-8?B?eFg5clZTOXBsK2xuY3JGdDVtdDZjYkUrbE9JRjNZQWx1RXc1UFVpQ2x3VjRF?=
 =?utf-8?B?Y1FZUWo2dFFpd3cvVS8wdzBKeXY4Qkg5aHJBTDVieEhxL25ZYkJ1U1BDN1k3?=
 =?utf-8?B?S1BDZDdkT3ozbFV2ZkQ5c1VaN2tRUTU0WERIV2VhZFN5bzMrcWUrRnFVeUN1?=
 =?utf-8?B?QUlpdk80bjIyck43eFhwUk9SMUdiNlgzZVB0SElhTFdQMTdqbXpPcjJ3N2lh?=
 =?utf-8?B?aThnUkpXYy9RZDVTcEpuSGQ3Q24xL0JkWlllcFNxQjFxd0JUS2JUU1dEUzdZ?=
 =?utf-8?B?enFIMWNCbTd2UjlrSUFDei83N2Z1eDA5RlJXdTgzb0ZvbTJyakdUWE81emNT?=
 =?utf-8?B?YmtRM3NhK0xSMXo1aEt0UDBLMHJHK21DWXczRDJWMGVCK2tONXJUdlVyb3BQ?=
 =?utf-8?B?RjRUUTZPaWFiQmRmNm1YWlMwcTVHeVhjNUowajBiMDlMQnZ5WktFRGVoTVpN?=
 =?utf-8?Q?fMp1/2gLu1JmjoUJW1v+8pWoP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9220ffd-120e-4d86-f41f-08dc3736991f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:51:21.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUpOu/d0NQq2K6c9zGgyq4BU1/av7UoLDUDUdkRhw6qWVrrtPw3kvHYS37pbwnSWnG1uMoBMV1nlGmGFVh/JNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6186
X-OriginatorOrg: intel.com



On 2/27/24 04:49, Barry Song wrote:
> On Tue, Feb 27, 2024 at 2:04 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 26/02/2024 08:55, Lance Yang wrote:
>>> Hey David,
>>>
>>> Thanks for your suggestion!
>>>
>>> On Mon, Feb 26, 2024 at 4:41 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>> [...]
>>>>> On Mon, Feb 26, 2024 at 12:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>> [...]
>>>>>> On Mon, Feb 26, 2024 at 1:33 AM Lance Yang <ioworker0@gmail.com> wrote:
>>>>> [...]
>>> [...]
>>>>> +static inline bool pte_range_cont_mapped(pte_t *pte, unsigned long nr)
>>>>> +{
>>>>> +     pte_t pte_val;
>>>>> +     unsigned long pfn = pte_pfn(pte);
>>>>> +     for (int i = 0; i < nr; i++) {
>>>>> +             pte_val = ptep_get(pte + i);
>>>>> +             if (pte_none(pte_val) || pte_pfn(pte_val) != (pfn + i))
>>>>> +                     return false;
>>>>> +     }
>>>>> +     return true;
>>>>> +}
>>>>
>>>> I dislike the "cont mapped" terminology.
>>>>
>>>> Maybe folio_pte_batch() does what you want?
>>>
>>> folio_pte_batch() is a good choice. Appreciate it!
>>
>> Agreed, folio_pte_batch() is likely to be widely useful for this change and
>> others, so suggest exporting it from memory.c and reusing as is if possible.
> 
> I actually missed folio_pte_batch() in cont-pte series and re-invented
> a function
> to check if a large folio is entirely mapped in MADV_PAGEOUT[1]. exporting
> folio_pte_batch() will also benefit that case. The problem space is same.
> 
> [1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.com/
I am wondering whether we can delay large folio split till page reclaim phase
for madvise cases.

Like if we hit folio which is partially mapped to the range, don't split it but
just unmap the mapping part from the range. Let page reclaim decide whether
split the large folio or not (If it's not mapped to any other range,it will be
freed as whole large folio. If part of it still mapped to other range,page reclaim
can decide whether to split it or ignore it for current reclaim cycle).

Splitting does work here. But it just drops all the benefits of large folio.


Regards
Yin, Fengwei

> 
>>
>>>
>>> Best,
>>> Lance
>>>
>>>>
>>>> --
>>>> Cheers,
>>>>
>>>> David / dhildenb
> 
> Thanks
> Barry

