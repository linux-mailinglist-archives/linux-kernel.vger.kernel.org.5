Return-Path: <linux-kernel+bounces-108147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5638806AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEAA1F21A89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22D3FBB1;
	Tue, 19 Mar 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QScIt/mn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10FE3FB99
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883268; cv=fail; b=LpaBWDfMRSplhNd0mhrzGaPkZH/m+X+TsRuVh8n5tByZu2nZuGezK3mpSPSs+TJij7RTfqMfEFUSWLE1xqbJ6k40WgYLGB68bvRj20A+voFPMO8rn1VrlAEJ1glQzGAgIz/c7k72ENvzWhfIIprhn0yttqMBPBtqAyN8z2V4Ud8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883268; c=relaxed/simple;
	bh=fxzy48VCYwr2h0XJoHTuMixGL2g/Eh9My2tVKDVEpGM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rsl8rqYdayGaSjRB9fUijSYmmS9ygdyBoZoGeD7oF4oU121bObIg92S9offonUibtWI3L7QyC1qSjfINi+luw0njgbN38nrbZe1ogk4YACF8LxkTvy3gmO9zqGm25JhnTNKXBwtszl6b7A9oktTuIf3SgN7BXawzRupsEgQ9NB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QScIt/mn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710883266; x=1742419266;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fxzy48VCYwr2h0XJoHTuMixGL2g/Eh9My2tVKDVEpGM=;
  b=QScIt/mnPP6/+NGa2Kw3xfhKUHYJ1ExEC4X5K7EVR8w2eOBbMC0pjXIz
   0qjrqUAvOpzBPZ8Qv+Jm7rBl8J0BJ1utGqmPJqCLBDFF4Mx+nvzGibYsf
   03sZ6kTS3rianiMpHe3cgzVeOCc5wNcs+mfDS1No+tmVqTufgAAncy99W
   HX/T3T+r2+kCVGklpmEFit9p0vCDrsc0uRsbeipprXSnvpz13USMOlDAz
   dL2BC+sHe0WS9QIUlyalqsNdf01PCgz6C0V7AkKEQ+S3Rizzqb8a+4Ig+
   pakSZaKRMD+iL3l3Cr3vAwz6vuk+zmtSw1NZvNE6D7yxNtQ5JZbcpSMpj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5661437"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5661437"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:21:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="14009488"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 14:21:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 14:21:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 14:21:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 14:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVvahcziwlHeI9oooJZLSquI0oDuchGPaREvPrjuKG8aXm/zFR4jXbsRGVlzjs/74ZjpvV5tq62AyAGPhKifF6p1AqB/mpyx1hS0MxtZyIZzsBC4MyJPq3Z7iHHoHbEtu2nEL85MX37LFx3FLFVQGi1YfzfGkIlJO2hXxJ0uksMe667tgFqB7Ew3H+U3Rfxoh8GmsYNc5maRMDaRxWpg9OqE7+mE+aeebkUwnAuubKmHPVxik9BCIrVLTyrmKla6nZ3d8quDO2VIqFVq3P4+EhgXGa9FPRrcl8Au2SRbrxuRAuhE8I/fgEAJ57sZLmqKeESN/PiWd9ahSnvRrcv2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdPbuUt6mvpe57VeKh3Ngl0FLnCUUj4B3OgaW0hNBZk=;
 b=b14f7vzKhgHEk4au0kz045tj7NcQ+/+YCT2Xajkn+6Sq2xDDh6kzVKzNCcRqNwBxMZr8rwOfD8iVTnDAlnu+xSBP1+BIN+QABSMKIWguz6lWf7uwO3V0STOE4ZHK+KxPX5/aFeDMWZShvU8uBvHWQ5YiDCTmGJuxBSLEoaCRRyDC5Y7uzSpCv7Ir8dTPqYi4yz5nCP1aVg0Rj8hfShX7wCTRjLz78drlBtCnhki8edqCoy0BTEhin2Z7UzVtbdSUq0+gQAyTuM8k5q2WsvyL/oTGUq5Ad+irIDRC3xithbkYXpDokMxGz+ZINTgdcqcYUMWjFRt40P2A2ff1tfGmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Tue, 19 Mar
 2024 21:21:02 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 21:21:02 +0000
Message-ID: <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
Date: Wed, 20 Mar 2024 10:20:50 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <dave.hansen@intel.com>,
	<bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<luto@kernel.org>, <peterz@infradead.org>, <rick.p.edgecombe@intel.com>,
	<ashish.kalra@amd.com>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|CH3PR11MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: c052df86-268d-419f-c1fa-08dc485a7ade
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fyhpn4GuWlFhu6uETFFgVU/M4KPV3rg3ZSKw6nhCPwUvacGv6ui+UF+i8YZzJ5AKm/u6kKBaTubFq2XY6K/uhBkM8lSPj43nQ5sXXGc2roFX7a4lbITdsvaImBLv1Aam7Nm0oPNifRZkRUD9exq/p59lAv1A/Xm+H4DTknhM4j6ANuncpfbG1qZOiQzaMNCd8OBSke+jos8kPknX/8VXMUqLeWRPwn4yOLSWX0/EpxmTElBQy5anzhIPf5wcaM4lbCWMNxAkDGAMJugb4n1Jz/E2pnTACTiY02RzQeZNW4RgWNklAkjJSBAax2hFniSlhzxriGshgLNL/q2gIPESK2WytpL6mpQVL1UMDwPAHIGhjy53RUNR9qmN5n0xlyeR+OkmH6bvtfcdWQ08Zbu+b1OXI9NyNaKELCQtDJFno4M1IyMpfDPaHnChgOh8fjg2G5OP9AbofZjRDXiLDgaZDBBT7GLwBgBtZ1H9y7SdIJmUsy7cZUDiMskQW4/bjM2MHhBUexSCC22JSkDZaT5yymswhuqXBYYrZx7O/cL/lb6i0DEwxgSjho3C8S7hwjlArkXN6gdcqLokwr7M/Y4NcZGIg+EeeWaW8CRxxL0WcNz/QxvvJUSG0CcPmS5QqmhthbqhVnIk2Mq81e6xVE5SexJPRRaTAGduXS5atiJ8Umc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG85cXZkS0dsREFWMC92eXVmdHVoUUpXelhDTUZqc1FLZGk3SGJDa0t2R1lw?=
 =?utf-8?B?ZWwzaXArdEVPMjNDUVJ4UmJkdFlvb3pQUlgwVFo2ZHViWkVGZHRobmViUXdD?=
 =?utf-8?B?clRLVVhzREZETmFweG4zdFUwL1IzbmZWMVEvdmZRbnJhNkp3aCtXdDJ5ME94?=
 =?utf-8?B?OGFyaXpwWEtzaWdCQ09sZzdIam5neEU0aVBCUTQ4OU5VajhTWDBwZG1WWGoy?=
 =?utf-8?B?VnhReldnMDF6VCtYK0VnSUJXNElsaGNQSFlucnZhR1RNUzdnM0NWcnJRdFVp?=
 =?utf-8?B?ZkNmUGc3NEhMa1RiNHo0RTVla3Vlbm53STE3SitHNUU4NWtVV3VZV1ozTGpt?=
 =?utf-8?B?cHNjUlN1eThaVGJyQ2hka0Y3U1FHN2dqcjVSYUVBSGdVRlAxSzUvZEU2blc5?=
 =?utf-8?B?V29URUJLWDI5WndZTU9wcVdvR2VoeDJpaHJEd1VaSGhHOEZob1VkOWdzNGcr?=
 =?utf-8?B?Skg1WUZNTTBQYzloS0NUdUdpNnFnekZQMGRCTm9LSGJ3NzdxenJhNDlEMW9B?=
 =?utf-8?B?encvSG9IUlk3aEo0Ti8zdjN5bERDOHNQSDFvVi9XUThFYllXa2ZUVTVPeXNT?=
 =?utf-8?B?MGNGWkdMR1FMeUpIUzBMeHczLzVPVzhYbS9rN3g4U3F6eVplWW9nSkV2OGh3?=
 =?utf-8?B?U2I5NXF1OEsyenQ5Ty9Md1J5KzYwYVNkZ3N6aHZQZW9XM1QwcDBKd2Rqc2ox?=
 =?utf-8?B?UVBHRkFJNW13VnNGdk95MzF5WGVsZ1dLdE90Y3dQREZNTGtIMktjNytkYkJ1?=
 =?utf-8?B?amFyN29QQkhMcTlFZGNWbDZIWkF1dldOOE1PUURqcWRZRENRWk1EdE9WT2dN?=
 =?utf-8?B?YnN3U0hSYkFhVUNwVncvTHNEUHQzR0s4ZHhNNnR2bngwNE94cFczMUUzNWt6?=
 =?utf-8?B?T3U4bm54cWhHVStoK3hNLzQvYklrZko2QktUMmVyS2ZrOW53c1RoZTU0Uloz?=
 =?utf-8?B?bzltQ0M4dktqOG1uenYxRXpoRXk0WGtLTnlIT0ViZkdQaEhEWHpEZXptM3FQ?=
 =?utf-8?B?WUlYTTZlWVhPTVlNUXpma09jd20wOGNKdDNyZkZTL3dYRVRpUXZpdEVaMnVF?=
 =?utf-8?B?b0dGS1Q0dXk2VzhTVWlqL0RBbXhFa01mTmc4Uk5VTHZUQlovblJWOUtHYjd3?=
 =?utf-8?B?QmRKdEZHMVdsK2RnanFqLzVGbWtzdEhSQ0dHZGgwckQyaW93MTNRNjlmNlpG?=
 =?utf-8?B?WGoyNitqMTJjWE95TUtHM0VCd242bmhIUmlxaDhuUzhwZEFpOHgrQ0lZb09a?=
 =?utf-8?B?NU5TaURvNkhkSGdsdTlyTFl5R1o5RzdOSG40TFAwWThTcnFJMzgwU2pTTVNJ?=
 =?utf-8?B?UWFpaVc5R1dSUE1yOUxWNVBxNVBqQytLdnorSnVrR3VWYUM0bmtad1JMZ2ZG?=
 =?utf-8?B?ZHpmRFlZUlNvOVpWbk43QUhzTzlySmlHNmMyMTE5clpDS29VNnJMaEJ1Nm54?=
 =?utf-8?B?S1FrNU5oNE1jczVBajE4UnpYNkNBWUhGQkhqdENONXJ4SC9jY0NQenlkczRw?=
 =?utf-8?B?QkUvWTQ3RzhLYnBWR3hwQ3IrZ2ZRSDUybUFub0d1eENiTzJ1Y1pNQmxYdEpR?=
 =?utf-8?B?SHhvb1h6SEZSOUxNTC9SbW96Y2JaQTFqY21wWTNUc1Jnd1hHN1BNWllCZVlq?=
 =?utf-8?B?VytoZFhOcjlwalFiU2JTN3VIRk9GNG9UMDgzQ2MvZExRTjREb1VxVVNQcDE1?=
 =?utf-8?B?NkVkaitFclZ6QUtweGFBaXJWNm5yMzNhdjY2NS9YR2ZjMUFmd3RuS0dHSGVt?=
 =?utf-8?B?eGhpc2FlREVjY0hDMmFZdm1qMFZIOTUyd3B5RVZjY0wrVHhRQzE5enZqckVn?=
 =?utf-8?B?bWxHM3A2T2lSaWtCbDVVZzg5bS9LVzR6L0RydkV6dEVNaFowMFoza29MZlMx?=
 =?utf-8?B?ZmNmL0oyRmlyejhNNENaNHVJU3MveUU3SlRpVGJVL283RXZYME0wY2VqdHoy?=
 =?utf-8?B?Ky85Uzc3TlZTSlh4bTllcUw1ZWdtR3A5bUovNFZnQTEwNlQ5Y2NQemt0NEl3?=
 =?utf-8?B?bDFhYWZlSnBnY0w1akMzeWhCeGltOFVWQmlLMnFGQWpHNGNKSVpmNVBtZTVC?=
 =?utf-8?B?TUI1d013R0ZVd1dadlJNZ0dwRHR4aFkwSWpTUGNrNWtSYnZPbnlDNndjY25R?=
 =?utf-8?Q?LMECNKTWP1aWIzkDrne+BsZLL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c052df86-268d-419f-c1fa-08dc485a7ade
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 21:21:02.7471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4UPrq3sBnXi/pMvwoH8TwMBaGlzFBkp0o7Anq1RAEVBRaOV5F3R06LEaktP4r+/vgUBXpuB/l2lfKIYlY2A9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com



On 20/03/2024 3:38 am, Tom Lendacky wrote:
> On 3/19/24 06:13, Kirill A. Shutemov wrote:
>> On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
>>> Both SME and TDX can leave caches in incoherent state due to memory
>>> encryption.  During kexec, the caches must be flushed before jumping to
>>> the second kernel to avoid silent memory corruption to the second 
>>> kernel.
>>>
>>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>>> remote cpus when they are being stopped.  For SME, the WBINVD in
>>> relocate_kernel() flushes the cache for the last running cpu (which is
>>> executing the kexec).
>>>
>>> Similarly, for TDX after stopping all remote cpus with cache flushed, to
>>> support kexec, the kernel needs to flush cache for the last running cpu.
>>>
>>> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
>>> and TDX.
>>
>> Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.
> 
> Ditto for SEV-ES/SEV-SNP, a #VC is generated and crashes the guest.
> 

Oh I forgot these.

Hi Kirill,

Then I think patch 1 will also break TDX guest after your series to 
enable multiple cpus for the second kernel after kexec()?

Hi Tom,

I am not aware of kexec() support status for SEV-ES/SEV-SNP guests. 
Does patch 1 break them?

