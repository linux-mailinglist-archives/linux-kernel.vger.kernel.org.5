Return-Path: <linux-kernel+bounces-48329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90C845A73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9151F2A3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F575F472;
	Thu,  1 Feb 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOeXwTSl"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8192B9AC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798557; cv=fail; b=tQhY5n7F76V+4HhLoLfxJOZW2qt9v2iCXjGHd/QseRTkmrt8ViVqZ8KGIplMAmDF0Gjjaf/+lnIJqNJlf3ezMYBA67077a/UDF5Gn60WTGS6pzVxRTfHYDVvzbRCq0SM6OcjKxQdQBl71uxLvETdfKJb0J74bHYqULddw1L+YU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798557; c=relaxed/simple;
	bh=81We0XjufO3+61KSWqO0o1HNIWM7zgjci792wpK7IPI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fr2/tOEVRfDyQm4NY63S7Z502nisFwWPhnR4XKZqu6GkKWEXPd7OJG0ZJo2URURu3+yEy32HXsuxU79a5h9+fqEYIRhjnVhhZ5o3xP1bSP+d1IB8lnQgfE6iuVck0AUJ2yx/ty/tEDpq5lq+ACF9TdWor8ASIV8ls2fPz2ZxK4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOeXwTSl; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798555; x=1738334555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=81We0XjufO3+61KSWqO0o1HNIWM7zgjci792wpK7IPI=;
  b=OOeXwTSlh2R4MkR/622OS6fsxpQskWxj3h6MLqPvY7OvzwVOYpG5JJnw
   84cX+cYfzvoLcL29FTfLmWk/AeLTIOX9e6dbvTLHA7h/EprWzyiv5hd4f
   70dnPirQOcHuRai02ZniCfROQkMU5X0VX8n+zUYAVs1JS+2uOrWGKNHx4
   /8GgThB9O4qkz9mHo8MWWtP2HqtpgTIkpdNrQt8gB7Olq7eCUdljUSh7d
   geNZxy8/V+ueGAo5Xv/2/n/dyD8Hzd4BYnabGmpCuE00YZL6/wU5yMO+u
   Vedb4+RTpZDB2MjCTHKMoHa9GBMTgPWiVtXw+MxcvhfJ1XcLx1/pYqDUD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468140338"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468140338"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961933591"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961933591"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:42:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:42:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:42:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws1jBQqnD6AB6EYntm/6aND7rn78vvKEPxc1J9I3yHgCo1GwrHw1CIUuAVQqCoTTXgr5Jbi7zYM8n9aSVOBFgR8nZs0mvnbVv+b2Ptd5Vn1t+oJKWZd5EavPr8jCk9WRnjd41hqBMZorLo66O5pVpn57Q+QZVbRyprdnyz/aENe1psWy5+weT0RYUiScS8kCn6I2j/bcCA25MFfOg8qw1FVirAl/k+ewdKqqHuD87MJBWS2ygBGxZwHtp46/763kt/g1brKU1/eBEneoWxsPtVmd4ymqEai6idg6cR5FPmLpNQwPxnpAGT62B6CLuuslG8NCRC6f99AjM3tK4Txogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cldVaVXSc6WuTZ+d8CqDum9BJCTePJqpxfEnZpVkW+E=;
 b=Tb5kw0PqUi+U+ALHVvnaVUmQQDpDAhFpYS4r8umWxeHZnDuKMSdWsY50ZfA0pn67SyjRlc1eW4ZdrZY8LPguizvMBV7rwRoRPMz6rVrHx73LPI+9zaAUOI+KFgQKhF4ssXwVj6LrOYsA3Z5cdJAYjLLPArF5lYeifiA0A7kJUPWWaWgQW5rzaCHHrny034UTiKob9B9iUjfiRyFj2J+Tb7LxwTaWUrdsPOv5YU0k5WdomXH04q597ony+vohi1dfAnHB+vhlBLwNrfpGLuoJvLmfvjIe3FBRaW+RRt7p2KgW52NaxSPJYjyvzcfA2gAKlvZOgFySxFS9VsuHBxPCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Thu, 1 Feb
 2024 14:42:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 14:42:31 +0000
Message-ID: <d2474522-9e0d-4e72-af82-e849146f1541@intel.com>
Date: Thu, 1 Feb 2024 22:42:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/virt/tdx: Advertise the
 CC_ATTR_HOST_MEM_INCOHERENT for TDX host
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <thomas.lendacky@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <ebbc67eb2c6052dd56fda31cd22bb830d3d290ef.1706698706.git.kai.huang@intel.com>
 <ccc94ede-4934-407f-883a-cd47079d2318@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <ccc94ede-4934-407f-883a-cd47079d2318@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM6PR11MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c067007-9972-4981-160e-08dc233404c3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbG9VN+zoA2PTG/Chg1amwVBchdxEneC+Kf5evCSAHmZaRA+Lc3jB29BUQvw/Cqpk0iom3Tjl8/Co0rIxPyHB8KouQEwk84K+Px+ovVHowNF9EbbYWucVAoWHj7W+KFrCQpl8/kgZQUM3IeQl9yEuzUsYNFQelSV4Vpc21vesdzTH2CsjwXZwmILRfXuZuoDbEWDixB5qeMVT64XvOoW2tHgwXDue7PMD3a9ip5I9aigGlwNGqJVcMeAL+HbqVRQoSHHX5yQ4w2Ru2b3j6Htzxfr3k8XvjLVaidQfERXBVrIpi4531XOR9D14PnQqWF1xcKIULGP8/TPbl/wyG53242bUnOcCbAjKb25PRNvmNue87uQSdhcMC2sjR2YoomxIiZeU7secqra+FduYh0frQNy/TAjkqdGr64wlkNVj/yNKxf/tp6JTpZ0UX/vrNC/KLQgRsRnv7OBOvUfaNdWKMFlsyZyiDDsD5xwfvsMS2MPn/kBXCK4XW6ddGxELY0jLdbFFTOelc56rsC05LKS39MzwGl52x9KlDEj8CLkx5Ze1RQ5TwhNBTGQNAFYtSvhWXhOMWRu5Dhak5WVGk5q5GqDE0AhWeKEv+23QR0EjRSoFrf/dL/lWO+mx8YR98caTpxHJ5MkXFgNM/KP4jp0kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(66899024)(83380400001)(36756003)(86362001)(31696002)(82960400001)(41300700001)(2616005)(26005)(38100700002)(6512007)(6486002)(6506007)(2906002)(478600001)(66946007)(66556008)(316002)(66476007)(53546011)(6666004)(4326008)(5660300002)(7416002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhuNVI4c05GLzd4L1RCZ2VTMXVYNCt4U0taY21OUVIzd3dSSVJCQXE1dlV2?=
 =?utf-8?B?cVphZVJidGJaTW02aFFvM0MraXdhRnl3SlFENE00c2hFQUtlSFZ5R2d3YzBh?=
 =?utf-8?B?eStjTk9IS1c5S0ZvenhEN2IveFlwWkZ6Tmt1NHFNNUZIdWQ4RDFBT3o5b2h3?=
 =?utf-8?B?a1JKdFBTN1M0bE15M0p5UUhLS1ZWS1VQVlllWUJDZ2xTRWpJeVpVc2NrY2hn?=
 =?utf-8?B?eUdYcG9xb3NvV3Yyekh1WTFjM1pOUStPSmMrckx5SGJvSGlSK1BFUFBLZDFM?=
 =?utf-8?B?SHovMTZkbDl2MWhWTi80ZmRBdnZlN0ZyUVJmb2VxNGFsUkExK1RWQnFkNFJq?=
 =?utf-8?B?NzdSVHlWY3p3TW1KOENrazNkU2VqaDJRSm9UNUZYaGtUenNFK2k3WmRHeCtI?=
 =?utf-8?B?WkRpbk9xbHpBeHpULzBySWl4VUMvSFlxOW40YXVTZStXaVF6SEhZSkJySG1h?=
 =?utf-8?B?ZUpoQlZWNElYeTJUNXZlb3BZeFM3L0hkYmljQlFwRXFYUUtJdnZYSnYxNnkx?=
 =?utf-8?B?N0p4OGpaQTJFUTJ6Y0Q1Zk5POHBpTnNqcCtnbjJEZCt6eFNQZ3JIbnlQTjJt?=
 =?utf-8?B?bk9wR2xMMFBGcEk5clpWc29mTjJpVTNXTE9nMzBjVzVJdjJsYkxMTHZDTTlU?=
 =?utf-8?B?OXpROFhHNUU1QXdqWU9hcWFMVW1qNFhOOVBIRE5kUGo1OUMwVnYxempPTFN3?=
 =?utf-8?B?RFhLTnByeGsvS0pqV1NMdVJCSW5BUDNUTGUwUi9GWjZIKzZBSDYrL1hwelZl?=
 =?utf-8?B?MHVEYjMrdEM3ZHUxdjRrMkhWS0ozUWF3ZDZra1ltb0dGTjRjcHlTQnd1K1Vm?=
 =?utf-8?B?eGUvME01aFV5UUF2MHhnREZlaDI2UDdHQ1IwU29OOXpzUWxTcEhobWxHRE5F?=
 =?utf-8?B?VWprRHdJaEFCTGdpYkU3UU1idEhBTkZaNy9LWk15UUpkamhMWUhGMFpTUTVE?=
 =?utf-8?B?UmJYcTlRcXdPcThvM1JDOStBeUNtWkkrQllySTd3eU1RaWpna3ovcVVML01E?=
 =?utf-8?B?eVJkTnJtTmhRSVVSRzVsNnEwZTZPQWdXSVdQYUpwL0MzUVViMnZvb1haMERP?=
 =?utf-8?B?VkZ4bTdYaXBUeUN5YnBFODRPSEV1Q0MxNEFwWkc5OERpQUo5NVBJT1ZJWHN6?=
 =?utf-8?B?N1RDS0hadTh0NnpJck5pOUJKMDB0WlFXWU1QWGlzc1I2YnUzYTJwSHF4VmRY?=
 =?utf-8?B?MnFtcFA5L25QTkZYR2FCNElmTVhBVWZmUDc1TmN5SXZjSC9RU3NxVVBPLzIx?=
 =?utf-8?B?dzU5TnZBdURNaDZoR21ZMDgxWld6eUlKNU01bXNhNDAxYU81U0EwVE9mSXYw?=
 =?utf-8?B?VnVVK0ZuWWs5MlUzSnFaWUE0WjB0cFF1dGFUOWRxQ1p2V0k0RXVlcGVVNEF5?=
 =?utf-8?B?bzB1MzY3dGdtMVdCMFhIRDErZzBQd3Z6WXVXZWJoVWw1ekpBQkp2bUZ1cG5C?=
 =?utf-8?B?Wi9HSEpMOHVIVkZhbUhjelc3U3RLdDR2REVWTE1BR2N0TFNUSy9xSWM2L3BV?=
 =?utf-8?B?NWJES0ZtRG5xdEpaWi9rSHRjV01OVjlCeWhCcjVwUjdYZ1ZvRlYxdmVnOWFm?=
 =?utf-8?B?bmxuK2laVmcwaEd2cmxnUkxpTEp6YStkclUwcHBaK2diNjA0a3ZwUmM2dENo?=
 =?utf-8?B?TzVnZ21YQUlvYlVIN2NPR0xSUGRmUnRBRGdOZEwyLy9kOTNhMFNNa1hDNnpJ?=
 =?utf-8?B?T2NyZy9aQkNVVTYxZENlNUVRMnh0WDRPRnRyYjhGNmgrZlNHTUJPUVkvWHRh?=
 =?utf-8?B?eW1yYVp0RFhzWEVoQmRGOXcyTFFiMVVOMzVxaFhEaFlGMHAwYzRZS2VBN25O?=
 =?utf-8?B?d2I5V2FqbmxPNWNCVE1BUXFrUVkrNlpKOW1ScHFscEtxOU5NbGlldlAvTkZt?=
 =?utf-8?B?MDVEMjFoQUh6TW5PTFVXS0xpQW5Bb1FRVTVtRlFZcjNDWWYwUEh0eG1BeEpx?=
 =?utf-8?B?d0dlUGpvdk8zVWt6Q0JOdkdQZmFpejlFZzNFWFBpcDVFY2c4aTdoaTNRbENB?=
 =?utf-8?B?Mm1yRE1hS3lwTmJNQ1Qza0NKVlQxeEZuaFI0bFErdlBkRmE3cmpZL3VIVlBl?=
 =?utf-8?B?WXRpcG0xdmppWDRLTitSSXphcnJvWkpJekliRVdpeUh0YktuM1JXUHR4TTF4?=
 =?utf-8?Q?Nrkd7Fr/sEDUEg6IZNDDCwERO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c067007-9972-4981-160e-08dc233404c3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:42:30.8699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwn8Q1N6cQ8/5UBoZdCGV7K+ruRripEUWbrxTW4smqaHQBCfw1aEsMvzE1BJJen57r7PCETHdL9/OwoPeklMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com



On 1/02/2024 1:11 am, Dave Hansen wrote:
> On 1/31/24 03:31, Huang, Kai wrote:
>> From: Kai Huang <kai.huang@intel.com>
>>
>> On the TDX capable platform, during kexec() the old kernel needs to
>> flush dirty cachelines of all TDX private memory otherwise they may
>> silently corrupt the new kernel's memory.
>>
>> Advertise the new introduced CC_ATTR_HOST_MEM_INCOHERENT attribute for
>> TDX host platform so the cache will be flushed during kexec().
> 
> So, you're setting a new bit, CC_ATTR_HOST_MEM_INCOHERENT.  The way I
> like to deal with these is to go back and look at the definition of
> CC_ATTR_HOST_MEM_INCOHERENT and see whether the changelog here convinces
> me that CC_ATTR_HOST_MEM_INCOHERENT is being set appropriately.  Bonus
> points if this changelog uses the same nomenclature as the comment
> describing CC_ATTR_HOST_MEM_INCOHERENT.
> 
> How well does this match the comment above CC_ATTR_HOST_MEM_INCOHERENT?

I will try to improve the changelog: explain what does 
CC_ATTR_HOST_MEM_INCOHERENT mean, and why it is suitable for TDX host.

Please let me know if you have more comments.  Thanks.

> 
>> Note theoretically cache flush is only needed when TDX module is
>> initialized, but the module initialization is done at runtime so just
>> advertise the CC attribute when the platform has TDX enabled.
> 
> I find this really hard to parse.  Here's a rewrite, as usual:
> 
> 	A TDX-host-capable system might not actually have any incoherent
> 	memory.  This can occur if a TDX module was never initialized or
> 	if the caches have been flushed since the last time TDX was
> 	used.  Ignore that case.  Eliminate the need for any locking and
> 	assume that any TDX-host-capable system might have incoherent
> 	memory by always setting CC_ATTR_HOST_MEM_INCOHERENT.

I appreciate, as usual.  :-)

