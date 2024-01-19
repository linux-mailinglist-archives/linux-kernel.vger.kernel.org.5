Return-Path: <linux-kernel+bounces-31490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0939E832EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371E31C240F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D620B10;
	Fri, 19 Jan 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfaV85ex"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630E2112;
	Fri, 19 Jan 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705689186; cv=fail; b=MGJXIuXj4rwNg+TYZc7+Japjs2XZX0RFmI2OYp5FecAztaFUNkSdVtFv0JUxhz5fpRPgrTfmaBnjBEJZM/ADnsplLIu7x1Ph9rdXCF67I5oe5f0Ll9LA0V/KzbHRG5oKlG2vx+JW7e2auTXAC5AnHOuPmjU53f4Zlf2fJaldGHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705689186; c=relaxed/simple;
	bh=33+YkFXusdX66li2OPTqKT6VfudK8+EtnU/TqFQXmPg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DgZwdEjKb1osioRVdIiQZ2TXK4Ztf6SRHeeKwD2E93syqVumXUECUPYOJFscsAus34Us8Uip2OipXIH9sWh92KQblHs421wNp1Lyns2MLS7dat8subNEB3hU5nOq+tTYXnC7i+G26U4RaEbULC5pNPx9W6I3O6iLcqjedvY37z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfaV85ex; arc=fail smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705689185; x=1737225185;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=33+YkFXusdX66li2OPTqKT6VfudK8+EtnU/TqFQXmPg=;
  b=OfaV85exBWZ5yr8XNWPqu9B7tOtwPYFslLKOqDZQ9sb1+sNe9UF1FZxh
   bphcwW2hLrw/V+LnO4/As/vVW93oWWf7Awjdyhkv5XQJ10ca9lkJuwqjt
   m/7JDipv3b+nhl3uW6gS/7gkQWDwFCgro9ppcnLdy6tSFeMWcAp8JDJa8
   gezvjFQWWUFcjGTH61baK8FBSJup17JBcaRX6uZDGFW2G/8pgoqBJ6vkO
   Ju9CaQSfkvjnZe+7I4f1UL/uNyukFmB3IXFCIaZ8TfSMNQcE5Tt118xHb
   Wq+1ayKCkyvky8lBTzzJ14nWKLN/SMC9wzxcZIFq0JQAUkuN9owWFg25T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="467180452"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="467180452"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:33:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="785126443"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="785126443"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 10:33:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:33:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 10:33:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 10:33:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTCsKN10j/JR7ayfDJ5zfXk1qk7ig491YhS7h1wUEHkZNK5eWqYtbemN7yo8tf3gX8Sb09PZwnwtCn6HL6PHJD2pVnTpKLV5r9PmFC67GlljUIdHni0qpY0pLWo+Rcg0lgaVAXt/0mLqDmXpJfpKDEaHWuWeRQwRysgcIzWKOrawsm39PBlwgYCGD9ZU9L5WB3r+QObU15wiIttgYhL95NwZ7zfWOsYYgHwL2lhqU92tCBFbf2z9/o3y6NsLq79xr98lQ/bo/NQ1oZ4eGjhuewOtiHDRTrjm2FfCBUAsN5NHB3K5babdbC9M/z3Zsb6HycBCNZdWyVWxOpNsEjRgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aefCIjasdohr5B66JAR9nBP6NRyAQm4vld1AiRUV1lA=;
 b=iats6XRa8AZb9xT+S3Cl9c4YBX92TiDP70DbXYCM09m6yJTG4iA+7exkuHKd80tXUMKbVZeFZ6VzYqZixhul+JefwIl+7s1IiPWbIZCmVvfcRgpxx1EZOP/rKBIp4QSPakqG1H67EDglICj2K4aTcS3nNXd4W4Fb7cQA4dLv8JQaQHI3MVMMLSh18yPJdNaVVd8xJwmWaSBzoGk6KQPoGzO63Q5MAk/50twjTTkCCs0kY3twEyM6nfkEjU2J9T+9u2PIWsvL+dE/FKD6wofz33Kkl1EmfZJFQ7agfgS/wZtDuhvD7m+wr691Cu34rzab1TWEcJmPNPmf6d8IMLOfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:32:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Fri, 19 Jan 2024
 18:32:58 +0000
Message-ID: <ea03f9db-91f1-4f59-b94c-cc351f0bcc29@intel.com>
Date: Fri, 19 Jan 2024 10:32:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>,
	<seanjc@google.com>, <jmattson@google.com>, <leitao@debian.org>,
	<jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, James Morse <james.morse@arm.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d57d5a-8db6-473e-d2cd-08dc191d0f57
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eGyEUmQHQjPdoZwt2gIg6So036/X+k0QOREpvN1Uc9zQzueJttG0/JaJ15JLKZcKJp6ZjNs97duasKRs2RERK4vk0t2LvVb8Iotb7S6VbRGIr6aoRgvoSY+O+h78gtwDNKEhXmF32/6KZoFB2WMRXljeTbgq3k3zDV6KUDdzcabKe/DpHsv20Swvm1zDuo9CSP3nEXL+IQWntFiY7e+jCucNKYOgz2qNBqfVE2ZklK4OhRBMgxfkE4fzNCgjkwHgLUvKMqa0D00Gn1zyfs4R9D3D/ApINu3KuQTyN4rnh+HvVdA5AWqfMbwqtilGTQHnGys3uURcjrK9H1zbKui0H7nCfEFnb2zf22z4JgF7rOA4Zz8gpUnTKCEoeKTgwQ0tRvze/K99Rea8nwyo8V+bIbONKhYzJlg1T/v6n6uhNIZKvzbiYGEROSD+gihhU1uQQoZMR8pJCVLlnMV5RP6+lzoBxB1XXPUm5ENJfdM8IIjVEIuctFgbO9IkbA0cIk2I0yVxmgWi6HlFGlNOOI5ImBVEqheGNF1h5xv21G6acgFylD/KtHJzOlwzlyzktu0hUk+TQpLyAd+BKevgfANY/norvr/GMksLiBXWdlubT4S3G9gSl4fxpy2itijtOVbX/gcWvBdEdkast2jYfdSPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6666004)(6512007)(6506007)(53546011)(26005)(2616005)(8676002)(4326008)(36756003)(8936002)(86362001)(316002)(7416002)(44832011)(2906002)(7406005)(558084003)(5660300002)(66476007)(31696002)(66946007)(66556008)(6486002)(41300700001)(478600001)(31686004)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlljQk9DUGU5U3FQeHJFOXFtQjNWbXF0TXdCdTVETVRFOU1tNzNPd3NTQ0tt?=
 =?utf-8?B?OUFaS3FTaWtycU1PeVZjakhoNTgrRXYxNDEvSHI2QkI0Q3NrNWdMbmpNcEFh?=
 =?utf-8?B?eXd6UWExN0EzNUVJd3dqWUxFdjB0VkVTU3J5U2phbmxKYVlZQjFEaXhhZlJO?=
 =?utf-8?B?WUgzQWNUK3hGRVFocWRrR0tyZkdRZVdjSVhtRjdRcGNISTNiVzlZVXRUdFp4?=
 =?utf-8?B?czRyNFgyUnRKYW9pVnkwczljcHZzK2lIRDRaUnZGamNuTTZta1NLdnBmSElW?=
 =?utf-8?B?S3JGYmJLbENxUUtnOTFLalIzcVlEMGd6bXFISkx3amtxVHBUK0poR2gzaGh3?=
 =?utf-8?B?aDRFNFdlNHVJL2hiZ2l4ZnBUeGVJMVNHTjV0dnlheXJTNzlGTnJVaG5XemU3?=
 =?utf-8?B?Ti81UEY0L3dmMzFTazNzSFczd0J1cXYvL0QzYlA1VWhlb0x3a1U3SEU2U2h4?=
 =?utf-8?B?SDR1UU4xSVo0c2Y4TUdNaU1TTjZEYzFyUnE3VVZ2Myt5dUVyQTgvZkEydi90?=
 =?utf-8?B?bHNRelFEcktqRVBmNWFxTlZ1cUJXeTdiaVBFWG5IWURiQnpKM1RsVWRzY1Rk?=
 =?utf-8?B?WUV1Y21rZTRBS1FVWU93WGcyY3EyNC80VHVZcTBxRjVldkhOejhWU2paWHVn?=
 =?utf-8?B?ZktvYWVFd1Y0b3BPT0kxeDlhYXFFS2d1N3BCSHFKaEVMUzhxRHJPNk93YlJB?=
 =?utf-8?B?TVMvRU95ajBtSWU2MkdxU0hZdTk1c2lBT1U2YXUzYVR1MTdvL043YXJEc3J0?=
 =?utf-8?B?clIyYlRvZlgwbS9VMkp1MUkrdmNVaVZuSWVtTlV1VWxLMmpoZFF6OHN2SUxh?=
 =?utf-8?B?Q3R3NEhHdFZ1elg1a2VmbnB6V2l5L0MvNFlHWlhxL1RTWmcwTW5qMlZMMHdU?=
 =?utf-8?B?WFc2YUJaa3cwZ1dCK3pqNElpYzdhMW11aExabjlSRXJuZUM5TVZjN1c5eURB?=
 =?utf-8?B?aGt1N0ZqMloxb2hyS3BPejlZYzlpTWpUTStOU2Y4ZlE1d3FKMFJpM2sxTUdC?=
 =?utf-8?B?WmVRaVQyVVBXb2RjdDNmdjFSTFdtSUlQNkl3QlVQNVNCYkM1MnRlYkZQc1d3?=
 =?utf-8?B?UDRndVRSZjFhSW01SllZWmlaUTRVZGNLN2t3MnJKTW9DMmNWcmZuUjV0cUYv?=
 =?utf-8?B?OUIxeHZEWUJISktQYTRxSDNpaUlmNjBRS295cXlrVXEybzlpTjdaZ25KeXNZ?=
 =?utf-8?B?QUdQZVhjWjFVNGoxYnRDWWNrRGpqdlJFU3ZGbmdaRCtzUHpCa2MyRHJvT2lq?=
 =?utf-8?B?ZkxqdXdLazdZZ1cyMCtHQ20wY2s1a3ZLOWJGSEpVMUxOdHk5RkxqVDZJcGFS?=
 =?utf-8?B?Tjl0dXcwRFY0N3ljM1VWQ0kxMDVEVEN1M0sreFZrR3hVOTBzTEgwNWltOWZH?=
 =?utf-8?B?dlhPQWJtWDlmdE5TZG9xL1M2WTc4Y2NjSUhvcGc3MEtDTVYzSGZJNjc4NVU4?=
 =?utf-8?B?VkUrUUFYcUpzWjc0cXdLT2lsU0dYKzM2d3RhKzIyU1dHY1NEQ01iNGc4L3hJ?=
 =?utf-8?B?Si9pVVdOZU5QY3JiaDFrZGFpOUZ3eEIydmhKaWQ1Y0pSa3IvS2l5MVY2dlFE?=
 =?utf-8?B?alMxdkI0QStzQnd3ZEY5Z0NlRTl2UCtvQ1hBVktMODhEbjFTU1VEUUptMDFO?=
 =?utf-8?B?akJsSTYzcEdyMVNZK3JGQklTd2FZL1FqNEh2QlJNcjdHcUVEUHV2bElwdjls?=
 =?utf-8?B?a1gwRUV1K284VzRIZ01yc1RrWDJDZzJybGJaMy9IRDdtSjMrQVVpd3NWakxF?=
 =?utf-8?B?V2p1VHpCbGtzbXJQRHd2VVZBUDB3WkY1RXk2clIxS1gwSHlvWlUrL2hMay9z?=
 =?utf-8?B?WlNUTStDbi9COG4xb0NCV3dBa1Z3THRobzU1SnBjbWtVQnJqaUwxdzdvaVR5?=
 =?utf-8?B?Zm9BWHRXZFp5N0dsRGkzQWx4bnJleUd4aDY5MWZkWnk0Ryt4bzE4WDJ1L2tF?=
 =?utf-8?B?bjcrOGUrbkEyVCtvdHNxTjRJclBiTFhwUnA5VGkwWGNSaHNSak1qb1RvSDQ5?=
 =?utf-8?B?NTlleWpoVXkxN29IVjF1ZFl6eU5XcEM1ZlBCaHh5U3cvY2szdVh1cnRReExD?=
 =?utf-8?B?WXB0MUFzQXNQWU8zQ1RUbHd2dFZKM3UzZ3pjYkJXSjhrZmRLU2FvaVBucnRF?=
 =?utf-8?B?UWt1QzdoV1dQNkNMb0ZMWUNBOEt0TG1DbFJYdjV2dWIzUExFRFNPMENWeEM0?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d57d5a-8db6-473e-d2cd-08dc191d0f57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:32:58.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ku/pnUluq2mfdyH9Qezw9puF3vBbiveO5jmWZyn+W6oc43sTzBDR5hVGJVwE0iVrj/CRDsvjM/PivsA+ymkI8l/vtW5W9njEeuvJ5kd08w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com

+James

On 1/19/2024 10:22 AM, Babu Moger wrote:
>  
>    f. This series is still work in progress. I am yet to hear from ARM developers. 

Please at least include James in your submissions to make Arm aware of this work.

Reinette

