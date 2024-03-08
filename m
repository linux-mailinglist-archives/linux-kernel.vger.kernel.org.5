Return-Path: <linux-kernel+bounces-97379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7C8769C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03A1280617
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1F4F213;
	Fri,  8 Mar 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KI/u7vPw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EB57880;
	Fri,  8 Mar 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918487; cv=fail; b=OdjrkpQ1EEMB5BUBoIRsSkg2vAOA1BrGHa2ornFNRY7JrnUm9cFFjn7KxIX3rXVCV/NIfHJXHuAEoBGqpE7YAZRY+j0m3Qkc6tw6zW1chuNGg/N/9AgWMVPgALGPv06N4MkUjRMPh0X95aNVkRCpjW9N2nEQD8Fh1pZUhrEhWi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918487; c=relaxed/simple;
	bh=QmH+LNqEyekRwRMiipm9u7+6+SzsLL+R4eQa83ret/8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mcxq9EvqYNlfAmdOp0LJF7yN/gBe7ClM5wFNlVjoEyGvoFo6+FOUftsl9ZqbAnqm0fwEUew3KsPFRX/lWxXQMnAZFgjQQPcHUqhkDjW1CZlt9wnILYW6H+6+b1dK4V0Czrf/yFsWn0/Gt+6EoGR6IH7zJPSjsHMZKJ6HUPu3t+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KI/u7vPw; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709918485; x=1741454485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QmH+LNqEyekRwRMiipm9u7+6+SzsLL+R4eQa83ret/8=;
  b=KI/u7vPwu9XNubAyVug+1QJcET7WTN6mp517LtwGKFBcxiMoB3F7acTN
   W3rioaLENCmWzwBunitIKLayyoKn14JudCmcra2rupfYIt+j4E2vy3AIG
   rr8gpGF5gQzZ6FD7Kdx0siHfYr4OHYxWT6qI5o8iACQLplbTpyXtxdAtV
   tIiqrpnAmWmQFom7Dk1W5253lSxItKY6iUq1p7Z1u4OGK6jVRSkZP9w7v
   FNYnq5NVSc/1JCRI8+nsKfbTUEAXUOJwjdU7n82DBeGzaHoI09MOqJLP7
   pTiXV4c5dK992kxLBcCfMeduEgQKt2a83L1Ha7HYFjEXN16CJXBu8KnV8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="8399486"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="8399486"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 09:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="15186800"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Mar 2024 09:21:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 09:20:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Mar 2024 09:20:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Mar 2024 09:20:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YK5f1H9LqtSTSJJnW28ePR+61PkSBBflXB8wHg7KOTlvfGtQ911S7OxkwYLCWGyxFB4jRnbgNcphTuT3PyJFixPg/pz3MfIf3ElMFVzMY3ibe30Be13EKrCy4xRzcuBCGwJhjCPAeOKcJKGnRjqTbc1dQG7w0v3OEZhsLgITkjC2X2xz2zNGvSqzvdU5DiL9dT2ZlCDUZ5LIeOE73HdSGiuVuqGxaeavId65sv3iiicBdpLpiwMlYjudEqnQeo6neeIzdSDo4exjyyIk1Dk2j8t+9qv5iMC7PIQp0EQUEivmWVSFZJC5gBGMKhE4qz9vT4tRrUMX52HhG59yTwYz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSGorpb5JSY2DIFJmLRN8iXEAcDmkaGNsKJjj55pDSk=;
 b=BumaE6jyIfrwt5e3tCHNvQ+CwKWfgNm7p8SSDqdFu6wemRrmFPS5eevvKjUFNUyo+ygqtctfC0I6r7YFIvmzD0ALagk9TvL/Fl5vX0apu/9M5H0SFKynIjbPECKnNIsypukCepJ7VBf2ljDtEF3UrTbU7T/Qo63fqG7FD+vtRjWCHY3kU0rE9cpTULHTwI3U8p5gzEkq4b1iC5e8vcBYm5bMD1ppwLr9pRd5O+jscTp3EewrOwqRQ4StqSJt7IizKoMigHk9FH5/Ap31vh9x2EqOY93lfnb0VgjPUGO76XH90L6wauRkxSCFiskrjw9moEB3TtIHycr/y49I8sS6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.12; Fri, 8 Mar
 2024 17:20:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Fri, 8 Mar 2024
 17:20:36 +0000
Message-ID: <ec15db92-24bb-46eb-963c-e872ff2ac9e3@intel.com>
Date: Fri, 8 Mar 2024 09:20:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-US
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: James Morse <james.morse@arm.com>, <corbet@lwn.net>,
	<fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<tj@kernel.org>, <peterz@infradead.org>, <yanjiewtw@gmail.com>,
	<kim.phillips@amd.com>, <lukas.bulwahn@gmail.com>, <seanjc@google.com>,
	<jmattson@google.com>, <leitao@debian.org>, <jpoimboe@kernel.org>,
	<rick.p.edgecombe@intel.com>, <kirill.shutemov@linux.intel.com>,
	<jithu.joseph@intel.com>, <kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <1ae73c9a-cec4-4496-86c6-3ffcef7940d6@amd.com>
 <32a588e2-7b09-4257-b838-4268583a724d@intel.com>
 <088878bd-7533-492d-838c-6b39a93aad4d@amd.com>
 <9b20589b-6220-4ae7-bfc4-4a826b7114b1@intel.com>
 <5ddb7031-a828-4001-bfdf-5477cb85e9ed@amd.com>
 <1738493b-3248-4c9e-82a8-1599a033440d@intel.com>
 <369ab28a-f3fa-4359-8e73-4dcf214c9b6e@amd.com>
 <54687d59-d0e4-4fe7-b25f-dc1fead01ea1@intel.com>
 <11487a31-908e-d474-50c6-65617d417deb@amd.com>
 <c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com>
 <55b545fd-2851-0d0f-ac37-ec59838fb4b4@amd.com>
 <1f366890-d9ff-4ac4-9af9-1ea3128a87fc@intel.com>
 <41ca7504-c3fb-ddb6-e149-4ff82019d678@amd.com>
 <CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com>
 <1d3e8b68-28fa-419b-b129-0c39df34f718@intel.com>
 <CALPaoChJPkfrMgFDhtZqwK7O8=A71CKLzQjEMG6LbgB9RhdzvA@mail.gmail.com>
 <e90ce54c-a830-4ba5-8b28-aeef06705d01@intel.com>
 <46065d68-8334-4b76-bc68-c2695e7b98de@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <46065d68-8334-4b76-bc68-c2695e7b98de@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:303:83::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4760:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ae9be0-4df8-4714-7e19-08dc3f9411c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wt14IrHaLsKd77L3ZZ6s56AHpRDjiQZiHdNAbJqbIu3oTwT932n2IU4Q8WDx5vJY1klOQHR8fGFpxl7z5Hc97Y7WiSV6wDzCp8QTBKy+ofrHsnIZpN/tRXjCzAHPbedf18OGmXkg+ihpMxWr19fPmcCjLzW1CGa6Pn8aUBw0cZCtX/PDbA9PU11UYx/1x3+Bfyf7cpINY6VSfK6xIDQXtzJCLLtxICXXXPdQHHMVeqpW4BLCuhcKTxL94w4C6w6fiWH0PH+JVPNvfJGaFxXY6/rsDh3xD/6CfwnSE4AIHu6khvourZTy/YeceEStSLW0lNUYMQIOQ2HJkqMqv18ZbG0jSbciMrtgQDME5QmJefsnnZmEt4ZT0zPqkyzNC5lbknNw2Vq4HGO9NP5fdAWobo4YOfUe23U1yGLB/DYlUvh9wDk4UdB423NAV2o6OBaYbpxpfpu8ZHtzv/rSzbI04Rx+6HrCdORlhpsGQKtPFQB7CG1Ovjdhjf/et8NaHI4/NIpMvF2ZHZpo841bcnKnjfi5ogvrYZvIsVXLlqHynTputyNd08wwG3HbyPJlL1GZMR1x5AKByg3nXILM/TZEB50OIhhgbWbaBhRG/Cx/waB7bbCBggcPvbkRkgqdrvP+MLSMXsxWVKn7ZoUX5Qg/x2aZ+jJXKlBYAkGzrGEKck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnlvTTQrbzA4REV0ZlpuRkVCMXFEekdXV2IyNnJRTm5oTWJrSk1iWGpSazNt?=
 =?utf-8?B?SzhhYWpWV25IVnJnVkFEenRIK1VYdEF1d3F2Y0ZRdWphYXl0VGgxazRudi8y?=
 =?utf-8?B?dnYrOUZUVEptdUJRd3ZqT21BbENFalhBSk9lNGJ6VHRUNHB4U2k0TFJYazlI?=
 =?utf-8?B?cWFLcGlrSENUYXBEd1BDRUZUY1dKaXlTYTBMTWdQVGt1ZzhSN2NTNEUwNzg4?=
 =?utf-8?B?M3BQK2FsUmFlbld5OFcvTDNrVVZKbWtCeUpRK1BLaVJlZmRZUXJoY0VvMFNx?=
 =?utf-8?B?QVhQM3hMTGFDY0tGOVVTclh3c1I4V0lubkk5VktFb1JVdnBiZWV3Qy92V3FN?=
 =?utf-8?B?ZjIrdGtFL2U2cU44Ujc2WDBHeFdTTzdsaVlXUG5LN0J1SkVWZ29qWDArVjZE?=
 =?utf-8?B?VzYxUzF0NWxvWlZ5TUFxYzZkeEJ3RFRTTGhITmVSVDdka0RPS09oOGhGOEpX?=
 =?utf-8?B?WnNjeGRjY3BWd2lkUVRmV3Y2aUptZytaY2tHSGMwR0kvNjNZVTFwSXBhM0ZN?=
 =?utf-8?B?THNGUmFteWdlWDR1eEdGY1l2ZEpDWkZuR2ttVnE2OEJESWoyNWRoMnNUcWdZ?=
 =?utf-8?B?THcwd2xoOXY1cmQvbVFTZmtXVUlOVXJQVkRNK2lWR29nemFMV2UyMEhQdVF5?=
 =?utf-8?B?UHA0SWsvajg5WlpEbmZQck11cDVTQk8xaS8wMnRQeG1ObkhKL3h6a245UG9w?=
 =?utf-8?B?LytWMG85bk1yYXcvcUZuWTl3QldaMkpZTmV4aEUrUHBUVnQ2dFAwejFYRGdR?=
 =?utf-8?B?d3I1ZGpsUHJCTkVtanU3bDI2c0pVcUduMi96QjUybWQ0VDJmT01yOTd0aTcv?=
 =?utf-8?B?V2NiemNoWllLTU5URjhMZk9LcGUwVVd4UFU2RDNNNkxiVUNKMnpRSlRUWVhr?=
 =?utf-8?B?ZmNXOElZamc0dEZLVlAxT1dZNGFPS1pnWExkaEtxUHk4RExwVjBGLzVPWHRG?=
 =?utf-8?B?Wk16QTFnL2trWktRTlltdnJsUERaUklmTXBMNkhkSmdWOFRlZ0hzdXJZOTJp?=
 =?utf-8?B?QndScERpeHppWVVIYmszbEo1NmczS0theUcyU2dkQ3YvZUNCYXZtNE9hNWkx?=
 =?utf-8?B?OVlnc0FaR0VWYkVwUTREQ3crNmw3cWR6dTY1eXZUZlk0ajVzM2V6QU9KanE3?=
 =?utf-8?B?NTRPeDM1MXNscFR4am1odyt6cHk1WGFEZ2VOejE5cFFuOFBMN211cDNiQ3hz?=
 =?utf-8?B?Q1hKNitLZithcWdNWlpzMkFaOUg0NDRuSGRaSlVIUTRQMkNWV21JeC9uK21z?=
 =?utf-8?B?U09ud1lvdEUzRUhUMDR1aDBiTjFpQk5tZmFxN1dEdmJrcjRHNTZuYWlieHQ2?=
 =?utf-8?B?d2QzYlpGdW11Q3FiaXlHK2Nyd2QzZE0zVTB5dnhqUzkxT1FSRXJxWXIxNGVS?=
 =?utf-8?B?c2VvSXRVM0hNWnZ2d21qbmNYZEY4WjV5aDcxa2NhdFFTNzRHQjFqL01QQnMw?=
 =?utf-8?B?UndZcFJRZDREZytwVmY0Uk0zVGRDNUVlOUVLZ2Y0NGZkZ0wydnV1YkpETGdQ?=
 =?utf-8?B?L1B3K3A1N3pDVk9JUG5qMG56K2U1UG5OWnJsVnhpNFZVWEVnRlI0M3M3OU9m?=
 =?utf-8?B?eXZEMzhLdzkrVHoxZnRibTZKN3I1c0tpd2FlRFVKL2t6L1hFMjJHYStHdjh6?=
 =?utf-8?B?b3FoVVVaYVlEbUhheXh5K09xWE0zOXBaK3B4Nko4c2VnNTk2WCsvRk5aMDJD?=
 =?utf-8?B?NzJsa1VKTXBpdDhLWHVPTERRN0RpWisxV1BuZW5UM1oxaEQ0RGl3RDhnbW9V?=
 =?utf-8?B?TlRzMFQ2QitkVzYzZFZVVGptM1hNNjJkYklsNmRZSDhPdlRFN0hhVDhmdUpm?=
 =?utf-8?B?Y3dwdS9FVVp4TmFQT2ZpRmRNSVV5UjgxekN6L0hFUTh4Y0RmM2tKcEVYTWVy?=
 =?utf-8?B?amQ0SUJYZlNXNStSOXNLSGd2d3p5WElqOWQ5SjZoR09IOGhaQVlXTTltZklB?=
 =?utf-8?B?OC9WaXVxNkpST0NxbUx0UzBiNUg2TXl6Vkd5Z1JVN0JTL0ZqZUszMGRqbDVy?=
 =?utf-8?B?a2wzWmxDMFlWSHRMV3hQYVMzS3NCRnljbW9yaWtoOTVoMllIN0lHQ1I5SFRS?=
 =?utf-8?B?V1Q0SUl3YWpSVU1QaTAwRlc3RkhBNGY4elpqcnpOazJZanlNVGJLVEs4VDQ4?=
 =?utf-8?B?K1NPZldFcGVheVVuUGhFVzR5aUJ3UmRWcTBYZGw3dmFTMWl2YkVScG1XYWty?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ae9be0-4df8-4714-7e19-08dc3f9411c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:20:36.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuwfwMhCM8dDOccAXJ3Kaa00jggwIfyjFppV+bU3giTMM4/Jq7W5BvifhGa762DLMsbdd5OTfg0RIIgKOZ4iPj3fyES6ZgVWQ+ycjpTOKus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com

Hi Babu,

On 3/7/2024 7:50 PM, Moger, Babu wrote:
> I am also thinking about replacing the newline requirement for multiple
> groups. Domains separate by "," and groups separate by ";".
> 
> Something like this..
> 
> "/c1/m1/00=_,01=_;/c1/m2/00=_,01=_;/c1/m3/00=lt,01=lt"
> 
> Thoughts?
> 

I would prefer that resctrl uses as consistent interface as possible
between the different files. There are a few files that already
take domains as input (schemata, mbm_total_bytes_config,
mbm_local_bytes_config) and they all separate domains by ";".
I thus find it most appropriate to stick with ";" between domains.

Regarding separation of groups, in schemata file for example it is
already custom to separate groups (resources in that case) with "\n".

Reinette


