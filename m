Return-Path: <linux-kernel+bounces-310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2941813F25
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A1CB21EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE45804;
	Fri, 15 Dec 2023 01:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnLDOlsG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E736F;
	Fri, 15 Dec 2023 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702603477; x=1734139477;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MeLaZ2Bm8PtxXE+ZLY92NDpOOtgHsx0gRcBYsLzrC04=;
  b=JnLDOlsGF25F6GCqqhWZJC7AeT3H35UsOL8nUJbKRxdeaW1RCAyhdQn5
   WBgx+Z8Ox1xyBcFS4SB6b2oN+3+tpN9GffFSYK7pwixdVXVUtF2U0Y29e
   ytNHHf6ukEgMFerVoT1j2Ou6hHWos7y1+HRAp6AtgH9euHXYQiT2AwSZm
   RmQV8Qnp56cMn6l7MHy2/4rYEK0e0aab+56yqJgBM/AfBqngsOpsjp/8A
   iwxj5DZpYuwt1gyxq6GEiO6EBGclfSIy7/e5QGI1Hlbsr7FpHRvl3Y/TK
   Ox5joLRlTqQdgNxeNIgAv7BfJcUWOos/sidAyGiHogTvzUT0+3aGQuXAJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392389723"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="392389723"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892705368"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="892705368"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 17:24:26 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 17:24:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 17:24:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 17:24:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 17:24:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNt6Gr82w5ynzacxCsKZmFXyxwkYMyh5GmP5nlAkyVHF0ovk93816bnT6PCF6Vmf1iG58F8xJsGDpqNE0zaOz3JPf4Q9nAX+5wTc42hcSIWXSHTZOZUK7X7mjnC1zSbB/vHEY8ES8SvoMTaCzZ7vItcRGg0PyxY3Qs+Kq2vySVtnr11uIe2Las9lO2v70ML3fJDxXZi0gHaQcdlsp0ElEibUDuZsMSaV0CN97v3evsg8d83NzY3EJxGSnnuTlTo7ZrQ7K6Rn2MONqQt0YOV9F+aEoi+F52CTdqX4xuwpcDTs/ImK+UOwFP9UjUxvosELQpvXcwTGouLh0QEYJTiTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH9i9DuQnAHdFAgNkOIoz9gygHa+nsKMES1NKkog3sw=;
 b=LzrJv5orff5TO01YUw6JzMgyWdjhGO7o3PtQOtsXmXr8N8IFSzV+Lh4+eaUJrUSjFyPhbsyaIldP+vUSOPwOlkBxj38YjnFLKou3nnhwbNVF1zb6GVZ0C9XQWkjKwi5c1RtOqDHoYxhnyoR7hMIpUdEMusSlJkwcOaL1kum3RD1wFgqedjxwFPVWPHB3WMMF2d5aDKCiex3uW1FEq8aT1Ulq64isvUvj+/wrvXM/RPmB5vGjX5HMYldQqZCBxg4C9om7F8NqueixXxK23HRD0fvm2LZdGF2V9UH4U14JlqEQ8sRiWxbzDZGAZwGn+tleba3LICOyftyrhQursBOsTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 01:24:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 01:24:21 +0000
Message-ID: <d9f3d23d-aba7-4229-bddb-5d6801b22f27@intel.com>
Date: Thu, 14 Dec 2023 17:24:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
	<kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <170240414535.760665.1609957728181418569.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:303:b7::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ac3d5f-25bd-44ba-06d7-08dbfd0c90fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGkZ3GzZggTTn4ASBtpyOuLBuPMWuUG+9piVkzaSJjgNZfdvcAmhucWemhQEXMeS0qFWOAcVpNTcoUXpHwiejvoTUNfqCE3RZTgdx3AKI8upCWabHU9oDtu3IURgHJ5XOFX5V0cOscXbXHFi38bXFe7S4igVZgfOhpmA28FzX8MTYI+Pv98Dy/UaGQRltZmPZG3sFVqiCXn9Ia1DIS59P1ONIIU40FSEM1EGkEi+d0LI/wYVt/C5Szndk9k67yPxNJZ1vD7uJUwzHSFOr+dDC74h77JVVj0rzOR1R7g4xlQGHRi9G6L6YyPEg3Po4GPtGddUVvIKwmxHzOepWJ6Ly2xruPrvXRIe4BjBZ/cKIryb1IyW7PsH9IgPUZdG0DcN2pdIqxOhokCwqzyBaH6PmyWmclivG29n8wz8ZriYG/u1zPXaQjtl9MRjVbJFHrN9j3AatLqsiiZbYdByYmSt9+L4G/qbjIVgibH2bEJatNJ+K4JkSbKxSalHbvlaPKeoX6/D8klznir8wDSEX4esW9d0K5QT+/6EYPLLq0itfWiQQDniVaAeoc9KqE+3GPMyjbGiM+LZOoP8ZQIFmyDeYymfhVQuEJLv7PJMQ3i8Y6RJo5hX+bi1KtnksjDW1tFHJAC50fX17GkpQ2zPXaDuAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(53546011)(41300700001)(83380400001)(38100700002)(7416002)(5660300002)(478600001)(44832011)(6512007)(966005)(6506007)(2906002)(6666004)(6486002)(82960400001)(316002)(66476007)(66556008)(66946007)(31686004)(8936002)(4326008)(8676002)(86362001)(26005)(2616005)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlArQVpqTTNXU2pkNVVZYmZoQUt3c2I4cHNKeHNaVDY0TVBFMnU0Nm54VE9S?=
 =?utf-8?B?MU5LdlZDZW1mdGZONkorZlFLbFRmV2RMNDlxWm9ZV1cwWmZSZk9OOWhwNnBq?=
 =?utf-8?B?TmM2Vzk2eTBqK2FGSndpRDk4MmF1ZU9XdW9zbVJTWEdQTzhSWGZZK2RaVWMy?=
 =?utf-8?B?OEZMZ0NOWWNZanpWZ25PSFk3N3NkVlhmay9Rc0pQbmhXVEw2SURaYVlhZTJ3?=
 =?utf-8?B?NmJmcUgrWUg1Q2xib3ExblBld0ZBZGwwSTduVFJwdDN5Zy9ETmhaTVNoanVB?=
 =?utf-8?B?Qzg1QzZFTTFNTDA0WGRyaHZYSGhENUlqK3Bva0s2WUZFSzE4SnFiV3p0cUN5?=
 =?utf-8?B?MGFzWElRMGx0c0VVU2VOSzNLUHR3SDFxdGVoNVlPODBLUUV4cDNFVUlyVkEr?=
 =?utf-8?B?TGppbklaWmpSZ0Z3bDFGWkpqN0djN1JDanJlMk5pYThXQ1hDVjdTRUJEMXZE?=
 =?utf-8?B?SU8wTVlZMHM3L0hyR0lkWkJFZ3dqNTQxODhMUVN3dXRrV3JkNHRpVXdZY0xw?=
 =?utf-8?B?OTQ4b05BTWtSb0RHTTU3bGl0TTdjbE9nc3ltUEJQdzhmaU0vL2t6Ym9DdjFV?=
 =?utf-8?B?TFRXQys5amtrcWhsaEY3UEFqMWxZVVNhZEw3czhGakQyQ2FFWWlLSlNlZmJB?=
 =?utf-8?B?QWxTN2EzYmdqd3JyQlNjSkpZb01Rb2xKYS9KOGljQTdSVjdtMkR0aUhNK0ta?=
 =?utf-8?B?Q29rYTNOK1RUMHFGTlA4WWRWMFMyZTRRd3ovVlpXNzNuU2NlUC9DbVdJTlhy?=
 =?utf-8?B?VGlpZzQ4L0hHaEJTOTBIbC9PMzR4Y2ZLN3B3enRUQ2FUQ0gxVTJ0ejl6R0Rq?=
 =?utf-8?B?ZXdiL1czWit3LzZaRmsxZUNtTkJlcDBkRVpjcURDUkdQMmhVZFA0WWxwTlBi?=
 =?utf-8?B?NG5zWkRwZ0pqRmJwWnlYN1luWThHQ0sxWFNSWS9wNVNHNDB1ajFQMnpWb2xn?=
 =?utf-8?B?SGFPNTZ2SGpGS0p2MlJhSVVsNDhESUc1b0dzRjNrVUN1ZU1aQnRMV1RvVk9s?=
 =?utf-8?B?T3hOSmdRY2l5VXA5bHVqT1VYL1V6STZ2ZTVvbXdadTJiTHZycHN0c3g3TzM2?=
 =?utf-8?B?SjJBSVpKeDVmYjJvOE55ajFNWmZzWTRqVDZqbXI2Nk81b2llMHNhZm1maVhv?=
 =?utf-8?B?Z3J5VGkwWXYzSFpVbTViOHN6cS9LWnZSTVNzakQ0dXlsK1hXSC93V2dBTExM?=
 =?utf-8?B?MTBQQTJXWlNRQ2FiNzlabU51anRXN0F1Ty96d0hiRnNjYjlyUTcrUGtrcm15?=
 =?utf-8?B?azY0WGZOVzhianpUdmVjdzFsbm9abEQwQTgzcERSVmMzY2JMZDRnU1Mvc1N0?=
 =?utf-8?B?UFd2YmwxK1VXelk3N3ErODM0bHJQY1RtZGVWaUdEVmU3NWtwTkJLTUx2UXNI?=
 =?utf-8?B?RXRtbXlDQmZXS2tLdXdGWGhqUHBKTmg0b2NPaVo2TUlwUXRwOC9mRUlEdWxR?=
 =?utf-8?B?T0tPKy83VU1kb2Qrak9RU3ZvSkp6dHh5VFM5MFBLRDR1YkdtVERYZnhheGMx?=
 =?utf-8?B?OVJtNnV3NklHSzcydStDbUFObG9zaEpVVDgzOTJFSTY0bFpuUkdXYjgxMnBa?=
 =?utf-8?B?WWV4UGhHSnExS2lIUkRObmxiOTV0M1k2b21lSnd5c0d4ZE1lV3ZvZ3phOXR1?=
 =?utf-8?B?elViQ2Rab0UvcWJQR0VrVTZNNWVROHBKbm1FVXBmb0hGbnY5OWh1UThLeFZr?=
 =?utf-8?B?eUlKZFNHZ2NQS2UrdEt5aDZ3dXBXd1hjQjRQMU1NS25jSitOL1g3MThyVFdv?=
 =?utf-8?B?Q1BLVEJWSzQyaXQ4R0FhOW9oZ2kwK1R2WGVtbnYxaHJJZDlaMEwvVndGVFVG?=
 =?utf-8?B?SjJOTDl5TnViSm5GUnJDa0ZVVDNoY2h0K3JSYk5qanJpdEZlL25KSGpXZENa?=
 =?utf-8?B?SUhuay9RVS96TnpNcmhsS2M2c1RYWEJ3K2Noc2UxYktjM3BnSTFnd2NpSzFw?=
 =?utf-8?B?ZmYyeXFsQ0Q0WEFrd1VyZm1UZ0ZSTnltd1NiSnZEY3NFL3dvM0JKaWNJaXlq?=
 =?utf-8?B?MHZFdlhOVlg4bTN4QzdaRXJXS2JiNjh5blpkYWZ0ODlRL1VPRkx5M3BnZXFH?=
 =?utf-8?B?OERjcGJTMzg3UVFpU1B1MittQUxjcEJrekJmZjI1UjFXSlN0OFI4Z3NhNWZZ?=
 =?utf-8?B?Y09ubVNoMVUzZDBUZlFVNTZZamN0U0hpdHJYdGpNZm5VNjR3MDRFOFlwSzQz?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ac3d5f-25bd-44ba-06d7-08dbfd0c90fd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 01:24:21.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpcL++MwPqk4G7IPOnCniRNbiUQfntcDM5L5ruOTZt/X1bIrLK+HO997FYpO27WRMbS1ZIHlvnxkdcUfMEAFvsHthjcYJTVshrEyLeuWdkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com

Hi Babu,

On 12/12/2023 10:02 AM, Babu Moger wrote:
> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
> supported, the bandwidth events can be configured. The maximum supported
> bandwidth bitmask can be determined by following CPUID command.
> 
> CPUID_Fn80000020_ECX_x03 [Platform QoS Monitoring Bandwidth Event
> Configuration] Read-only. Reset: 0000_007Fh.
> Bits	Description
> 31:7	Reserved
>  6:0	Identifies the bandwidth sources that can be tracked.
> 
> The bandwidth sources can change with the processor generations.
> Currently, this information is hard-coded. Remove the hard-coded value
> and detect using CPUID command. Also print the valid bitmask when the
> user tries to configure invalid value.
> 
> The CPUID details are documentation in the PPR listed below [1].
> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: dc2a3e857981 ("x86/resctrl: Add interface to read mbm_total_bytes_config")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> ---
> v2: Earlier Sent as a part of ABMC feature.
>     https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com/
>     But this is not related to ABMC. Sending it separate now.
>     Removed the global resctrl_max_evt_bitmask. Added event_mask as part of
>     the resource.
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    5 ++---
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   18 ++++++++++--------
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index d2979748fae4..3e2f505614d8 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -50,9 +50,6 @@
>  /* Dirty Victims to All Types of Memory */
>  #define DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
>  
> -/* Max event bits supported */
> -#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
> -
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
>  	bool				enable_cdpl2;
> @@ -394,6 +391,7 @@ struct rdt_parse_data {
>   * @msr_update:		Function pointer to update QOS MSRs
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
>   * @mbm_width:		Monitor width, to detect and correct for overflow.
> + * @event_mask:		Max supported event bitmask.

This is a very generic name and description for this feature. Note that in
resctrl monitoring an "event" is already clear (see members of enum resctrl_event_id)
so a generic type of "event_mask" can easily cause confusion with existing
concept of events. How about "mbm_cfg_mask"? Please also make the description
more detailed - it could include that this is unique to BMEC. 

>   * @cdp_enabled:	CDP state of this resource
>   *
>   * Members of this structure are either private to the architecture
> @@ -408,6 +406,7 @@ struct rdt_hw_resource {
>  				 struct rdt_resource *r);
>  	unsigned int		mon_scale;
>  	unsigned int		mbm_width;
> +	unsigned int		event_mask;
>  	bool			cdp_enabled;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..30bf919edfda 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -813,6 +813,12 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		return ret;
>  
>  	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
> +		u32 eax, ebx, ecx, edx;
> +
> +		/* Detect list of bandwidth sources that can be tracked */
> +		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
> +		hw_res->event_mask = ecx;
> +

This has the same issue as I mentioned in V1. Note that this treats
reserved bits as valid values. I think this is a risky thing to do. For example
when this code is run on future hardware the currently reserved bits may have
values with different meaning than what this code uses it for.

>  		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
>  			mbm_total_event.configurable = true;
>  			mbm_config_rftype_init("mbm_total_bytes_config");
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..8a1e9fdab974 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1537,17 +1537,14 @@ static void mon_event_config_read(void *info)
>  {
>  	struct mon_config_info *mon_info = info;
>  	unsigned int index;
> -	u64 msrval;
> +	u32 h;
>  
>  	index = mon_event_config_index_get(mon_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX) {
>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>  		return;
>  	}
> -	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
> -
> -	/* Report only the valid event configuration bits */
> -	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);

I do not think this code needed to be changed. We do not want to treat
reserved bits as valid values. 

>  }
>  
>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> @@ -1557,6 +1554,7 @@ static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mo
>  
>  static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
>  {
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct mon_config_info mon_info = {0};
>  	struct rdt_domain *dom;
>  	bool sep = false;
> @@ -1571,7 +1569,9 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  		mon_info.evtid = evtid;
>  		mondata_config_read(dom, &mon_info);
>  
> -		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);
> +		/* Report only the valid event configuration bits */
> +		seq_printf(s, "%d=0x%02x", dom->id,
> +			   mon_info.mon_config & hw_res->event_mask);
>  		sep = true;
>  	}
>  	seq_puts(s, "\n");
> @@ -1617,12 +1617,14 @@ static void mon_event_config_write(void *info)
>  static int mbm_config_write_domain(struct rdt_resource *r,
>  				   struct rdt_domain *d, u32 evtid, u32 val)
>  {
> +	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct mon_config_info mon_info = {0};
>  	int ret = 0;
>  
>  	/* mon_config cannot be more than the supported set of events */
> -	if (val > MAX_EVT_CONFIG_BITS) {
> -		rdt_last_cmd_puts("Invalid event configuration\n");
> +	if ((val & hw_res->event_mask) != val) {
> +		rdt_last_cmd_printf("Invalid input: The maximum valid bitmask is 0x%02x\n",
> +				    hw_res->event_mask);
>  		return -EINVAL;
>  	}
>  
> 
> 

Reinette

