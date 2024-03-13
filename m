Return-Path: <linux-kernel+bounces-101042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31687A156
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893B22810CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD60BA2D;
	Wed, 13 Mar 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D35fWEUJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024CB652
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710295638; cv=fail; b=TokhM2RICGERbY1rsS7lOjzawvbTpd2ve295vNcxxjM9jU8PJoSPfkODRPyMMYxx3CVmWEn7KpfYqZAe5wcWaSk3UKWPyaXFesVewO7n9a+kDij71oMLAF3rGiD7lihPBitaSsxUjDbhLWo6HPbiiNAUTAsYBOR/nbu7iZE1gn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710295638; c=relaxed/simple;
	bh=c8A4azXRT5uvzyf58fXP23ebHdrT2p20/2ciUuHbHfs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EzyNASUhfFByaCT6uZbgUEFd7xd39n3xzYEi0A7bCe/LeBu6+/nJj6yrip7V3K3usDCMoN/7hLPmh9wRh5HlA6wOcd7GT2kW0CQp1Y0o9lOSDxxEuYbAD/GLpXs1Mzh9B3h292O5GPrOGA1EjyiYg62tMWnVlAMaYdb0lCJ2U4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D35fWEUJ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710295636; x=1741831636;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c8A4azXRT5uvzyf58fXP23ebHdrT2p20/2ciUuHbHfs=;
  b=D35fWEUJDfQEwDZ3zFSlUhig2K4fk1GrKAUyOHS1SXiKfEpi7TmrulIl
   p0J24zDFKXk6F0YwnqyaK113XTTooky/mV8xYgwt31hLg1oX/+fyEmmzo
   TI+BDblRt5FKEX6dYIFBBfAkj3wsXnGjlYj1Tt7F2qTdwLr48dojEMwRE
   NsOxDAgi3FvA6m0zR46hAEYufp4vIZ8Ub66mS8yGlztyDOiYjb5EpCyq/
   SUhrf03ytvPmDTGt3cA44l7GGj+znvj2JCbd97A0RJ+mXowoiRfLXNE5L
   4VWUX2FrGq137Rwq5VJT7bAVQSdYxPjbIF7LoTx4k71P/QEu7J7XDtV70
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15764039"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15764039"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 19:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16469003"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 19:07:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 19:07:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 19:07:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 19:07:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqPU+ZjE1+kT1QcomIGupZTqfRGgE1Rf1C6IFi1yFUHbeeJKY4H+VMNJKhT/+0vcnBGx92qO26o5AKCbv45nED1Q6CWt02+YvOPaaojY7aKnB7vWhh3fCKZOwYIOAETQ7ZXVMd6CrFS9zjUDCYwugLSrbT1HZ+XiAuR/aXGPtM3pb79rHKDh03K+jOJvxE+9DH3mryzjFzANtFEm1xlAbNjwv+QpRPNXrlweoZeTHE7ycK4UbJHPjYTutHW+s6JTtScO+7P5n8Abb/2TCo0eFmfFMx7eaS9FI94JTJd00v42eFmhbXtmPYSQfstgCuZmu2EmBtq6o5lpgpeJLWdZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJf1MCp0S3RgYzPUuLV5BNyQpLHohO1KA/CdAJuNtKI=;
 b=jHH7qaaAyckzF429Fcv8WW8/ErcLl69+HQBITG/xAiSe7Dzu71Y3SDTKrxDA0pA3PwLvSjwSitUN/8A+7jh5fZ/5aKvQshLcVV9flQY1LaCOIE+jqmpKwHv6Mq+edEAybDtsn4TZ3eKJU4jtmirE2kHXPWNxS5Q1hiq93g47v6HoZenrl8ln7L3KFbQN8jaM8VYkl1IvF91RlHE50AFiA+5J2KcvRDy2swCsvmxdVJ51d1q4MKEOGGOx0Nx+3yebLgUIyuADsiMVCPQPyDwpGMm8mqC9OxkANg0CLn0Q7nKkKhD1+7+xXZyOEoHlC1XtMqabOqN4XoyxNxN34ecSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CYYPR11MB8431.namprd11.prod.outlook.com (2603:10b6:930:c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 02:07:12 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 02:07:12 +0000
Message-ID: <b5017375-d43b-44f9-b931-3046ebead9cf@intel.com>
Date: Wed, 13 Mar 2024 10:07:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Yang Shi
	<shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Ryan Roberts
	<ryan.roberts@arm.com>, <linux-kernel@vger.kernel.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
 <ZfCFCGkrLVpySa6X@casper.infradead.org>
 <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>
 <ZfCi7kvLoBvUnARz@casper.infradead.org>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZfCi7kvLoBvUnARz@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CYYPR11MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e28125-fdaf-4532-e5b6-08dc43024c12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kj8MQbufKed4lCo7Bq9JjWgmvYP6rQpR6LsnxN5tkCEpFQrKOHQzGf2SwWLa7QV5S3G3NCArTnOUSpt2gVWLwP7JoI0ves+mYkLrhn3clMS/nH106oyu1bjE2eAF/JkcHaNvfTNW9WFB6BeiWkvHzWdUy5aDIWahTJQ8l4D3raHWVSgzRqJzoq/RNk32a9FUKVQO1RtDw3wdaC3Ha+4uZ1CM4zRhlDEoJnp39xzW8FtPPj0iYvJ+XLcAf/j0dc6Ot3OhKvr6TTj5oZepxMSdeVjFbljDcQeMR+rZ8HaQ9c8WLOMTF0LWXmS38+OIlllw2ATPvvC0sYCh6xybzVNtD6xGuNLSjocWTE68NLkvVgJ7arl1HL9bxtspTil1vAhIgSBZdHHOWiKAiyp/BeqXg0Rt5pD18yr50zwEJncDFdpXtyA2PuXQW0muPn7kLINQ6e3Z3V6skJmfYtW640hG2sRlxKRJRJyBMZy2/S0ByrUI/SlYUlacU4vndLXCok1gp0x722kVFjKjDS0lrnDAGmnvXHztbK2D5r54WdHGmOTmkn4mTtqF/IidR+47BPKta8MgSwK/wOeHTXxnweu5ayvbtajs+xRKfCBV+rP0Bj2LsgsPBmDoQ7P9Pe6BRMq6sim9lxVLyqYDX9NnaaHR9a7T+sPMmleL18UdHokgu8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajFSekZmR1g4UmlWSDBHN0xYdXVhUE9UQUVMOUphVW9TQWxCdHJTanF4elJu?=
 =?utf-8?B?T0puMW14L0JZNkZ0WDN5c0ZIQjdCMFBpQ0VaelRGd2QvazByZVBrQlpSczdu?=
 =?utf-8?B?QzdRNEI4THhrZmFKOW1NaUhjaUNVWXRaMVZXSXM3K001aUpPR0FMT1k5ZFRq?=
 =?utf-8?B?WGE3OC9XRDRNRzJuVUh5bVZiZkZVMUZyallnTGl5Rmk0TzRTTUx3MzU2TXVa?=
 =?utf-8?B?emZ1YytxSUU5Z0tvNFNYM3kwdEFDTW01ZkxDVEJXZ3NTV3VlTmJjdEtGZURL?=
 =?utf-8?B?UzJZK0tBaVZDMG96RDU5WmZuQkFLd3B6Y1ZBL3Urbi9oQXlzQmt0YzE0MVh1?=
 =?utf-8?B?cDFaZDJHczJzNlN4ZHY1SkdhS2UrZ3g3UWpmVTF2ZElNT1BGS3pUbnpHSVpY?=
 =?utf-8?B?bCtpaUh1NkdKUTNNRmJRRituVGFtUUxZc0pPVlJTcjQrWERRbGVuL2x2b3FP?=
 =?utf-8?B?L25IVzRKeVZaS2p4eXB3dHFyTlR6V2QrRDk1VzdDM0xGMTJFWGd3K2NncWdy?=
 =?utf-8?B?WlJzeWo4Tm9ZeVZsNGIyVXVtb3RwdHhDenp6SE1KTldudTFGU09LTzR4emlo?=
 =?utf-8?B?VDY3UFZMM0xNbGxLNXdSRkhJNVlEL3RLMkJlb0QrWk9kaVR4TnlkN084RUVO?=
 =?utf-8?B?Nmp6cTR2MTdLcWRRNUkrQnVYWjNtQmZRbHkvNFpIWTU0aFlTSElGSmJGZ1p5?=
 =?utf-8?B?QkM4bDhsU1FrQUhSaHlPSEZlY3E1RC9CNERIY0p3cndIZkZMT0xySjVtRkR5?=
 =?utf-8?B?RW5LRkhNRmlnbk83YmFRSlYxdHR5ZWlBTnpveE9sUXRTc242NXhDVzJja2hV?=
 =?utf-8?B?STA5cDYrT3lnVnR1aEN4YTFDRkM1VEtVazg1SDVWYjdtUjdyNmxmbWZ6RWNx?=
 =?utf-8?B?V1pCYUFVa0REalFWakxSRENqLzlZTDdtVXNjc29lVmw1dkI3akFCTGt6Z25S?=
 =?utf-8?B?YlN3Y21TSnVjdm5FakRlT0hQeFdJMlJzQmNLNFdobmcyejBhNHVJNnhPY1l0?=
 =?utf-8?B?MWVXelg1anRtSkMyYUVDODVZOFFQNHNoNjZYQjNYTzJjRE1zODA4a1Q1Ynlh?=
 =?utf-8?B?c21JR1pZaHNDWWU3Sy9HR21EcG5ETTN6dWlpTHo3YkdmWGhxMEg3bjRHbVox?=
 =?utf-8?B?MjF5RGcyVFFzck4yR1JNenE4QTV0MkYvWHAwOE94T1FaeWdyZ3hadWRNWVJT?=
 =?utf-8?B?OTVYMjNmSUJzVEdwNy95UFUxRFJScmd3KzhtZVpFeUE3VmxldWw2MEhibHhH?=
 =?utf-8?B?SWJLUkkxb0x5K1kyS1lDR3NlUEVSeXNVWUdUZTd1Tmc3clg0b2dnOVFDQ0dC?=
 =?utf-8?B?MWI1Sk91SHJ6S1lvNEl6UzFpYWFRNkdKb1FkSnNzSzF5SHR4b3hENWE2bzRa?=
 =?utf-8?B?RVoyZHAyMTFRQklXWW9yL1dLZ1d5LzVObDZaMlg3Q1ZMeEdVVTZsUGRUVU5K?=
 =?utf-8?B?a0VkMHZTeVJEYzN5MDBsZXBEMXZ2dzg5L21idDlZMFI3dlh1YjB6MmdwMG9H?=
 =?utf-8?B?RTB3STNkS2crdGNOTDVnZWkwTkpwZW1xSnZQT1FKSnBranhXY3g4NTA3SUg4?=
 =?utf-8?B?d20xVHZQekxPSWo2c2ltQkJnYmRUOW1Oa0hqNEhXem8yUG4zSzdVeW9wbS90?=
 =?utf-8?B?TXdGWTlGelB2OUpJZm8rOFpjZTFtdU5QeGVHSjdzbDBBclVwS1hBOTNDOUoy?=
 =?utf-8?B?SFk4TXhKYi9YZERqWG5iRXkxQzBrckVvQW43TnpOZ1Zqc2d4eGR0eUJrcDI3?=
 =?utf-8?B?cnVWR3l1cVROWkZLdE1yWUtiTWtuS1d2Z0ZlVFZIOUpkSEgySmFCcENxRzVt?=
 =?utf-8?B?RjdJTWZXQy9lTHpUYyszNmJCYnZnWkN6ZkVSK2pVSmZGdStCdXhaRmwycmla?=
 =?utf-8?B?VVJhTjhsSTR1NnBwU084TEwwWFFUTnNyZlZDeWVDSVRLME9HcUlsMDUxcXcz?=
 =?utf-8?B?NGVyVmJDNVpEV2NVbXBOTjNxN1lCWHFIS1AzQVozZTJ0eWRsSis3WHVJYXZt?=
 =?utf-8?B?c2kxRWsxZnJtV1FGeU1QcTRoZDMxRzM4ZjFXT1JoQS90bUtkbGwvWHIrSnFN?=
 =?utf-8?B?WWxIMWJ5Nk5BL3ZzWU9wUmhlckRJb1hBdXN1djJFaUo3UjRYSTdrVjFESE90?=
 =?utf-8?B?VzVDb0R3NnhHUUpzTGt2bXZmNzRBY0lDUTFJYk1La1I3TU5WbmlXVTVIV3JH?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e28125-fdaf-4532-e5b6-08dc43024c12
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 02:07:12.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keH0YhqVdGdQynMnd7FhZNg+WA+Ihk8VK6ESf27vaD51VNnaAdPfWLXgM3Pc61gwJ1U6pLKjGuYvFzZqhjMWZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8431
X-OriginatorOrg: intel.com



On 3/13/2024 2:46 AM, Matthew Wilcox wrote:
> On Tue, Mar 12, 2024 at 02:32:43PM -0400, Zi Yan wrote:
>> On 12 Mar 2024, at 12:38, Matthew Wilcox wrote:
>>> Folios with a positive refcount are
>>> removed from the per-node or per-cgroup list _at which point there is
>>> an undocumented assumption_ that they will not be removed from the
>>> local list because they have a positive refcount.
>>
>> But that sounds very subtle if not broken. As an outsider of
> 
> I merely deduced this requirement; I didn't come up with it ...
My understanding is that this requirement is because of just local
list in deferred_split_scan().

Using fbatch instead of local list here as your created for that
issue debugging can eliminate this subtlety?


Regards
Yin, Fengwei

> 
>> deferred_split_scan(), only !list_empty(folio->_deferred_list) is checked.
>> The condition can be true if the folio is on split_queue or
>> local list of deferred_split_scan() with elevated refcount. In that case,
>> the folio cannot be removed from the list (either split_queue or local list)
>> even if split_queue_lock is held, since local list manipulation is not under
>> split_queue_lock. This makes _deferred_list a one-way train to anyone
>> except deferred_split_scan(), namely folios can only be added into
>> _deferred_list until they are freed or split by deferred_split_scan().
>>
>> Is that intended? If yes, maybe we should document it. If not, using
>> split_queue_lock to protect local list, or more explicitly folio->_deferred_list
>> might be better?
> 
> To be fair, the folio can be split by anybody as
> split_huge_page_to_list_to_order() is careful to only manipulate the
> deferred list while the refcount is frozen at 0.  I'm still trying to
> figure out where to document this behaviour of the deferred list that
> someone (for example, your good self) would actually see it.
> 
> 
> 

