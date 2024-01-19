Return-Path: <linux-kernel+bounces-31439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5C9832E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45098B234E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAF5677E;
	Fri, 19 Jan 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5Zdy+6X"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7356769
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686503; cv=fail; b=H6DoyUNPtCTV2LMPzuwwb/IozN5PrAaHgBw/EPphvjXIhINU3WobKkEVAYg5TgO7OZRcCszSC8eOLBOtPLtdkSZTITC2f/rC/jcqk+WzHZsXovtsjv+/jW2aTsDEVfSM1C1KF3M1qfOSKonxOfs5Xfsj4SQrA2hq56+5TMA+/Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686503; c=relaxed/simple;
	bh=Fw2Nxfj3E1rnrfhToU/xmgyB2kO7yz+EIaUqOPa3Vio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Opd2Y6z793gITxw2FE58VcdEquKVEJleg4/UPXhvvHIZ2IekxOuvJNGpBaJ7VdcIYSReGdWHcgkkG6p05fJ5T+ivt+3Wtjw7DSSOwtPirt7mhVSGRWGKAsD6lq74SuZVVw4VPdsjJ6/c63lXmYWc5Z0VPYOti3j/agdVNfKYnZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5Zdy+6X; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705686501; x=1737222501;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fw2Nxfj3E1rnrfhToU/xmgyB2kO7yz+EIaUqOPa3Vio=;
  b=M5Zdy+6XNTy+XF4P7JtqPWsSApxAXWw+Bk3/HGmxPQcUYjgeqJaUlRlR
   Q90heZwnDYkw3IHrb3jH0GQejksp12AFyXI6kerAQNwrKfxJA63D6rvUH
   RkijdekzqId7/MVEB2fxXmgAEnZLCsSx0Ruxy87oAPPdJuifj7ZqUFH4j
   O9Z4RmEH0kTPUS25F2OdS/MelDlnc1Di4pW07TYcfF9RPCTup/4i04d1K
   n8/Vo04aPvG0U07aYq7SYHyZxe9mcX+k8bntgeze7/6UWyTrNzDCHnQyC
   bbR6m9K4LvCRi5FKj9i1zzLav/CdgpN3iY0e/SX0A8thnrN3a+mdwNt7S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="397965489"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="397965489"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1116296523"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1116296523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 09:48:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 09:48:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 09:48:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 09:48:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiiePgUwHAuWRjT//LQEOvHYN4/w1mg8kBKAJRU83MHXtWGdJsHKleO+7HMgWVL3HhYuiZ0Uepf0+YXvKWvFuP7ItWfmM0JIC234UDJyb9sOrlOAaLZVUrt0V0XJP0Wk2j1upNsz4QuJJAzMxBC0NAZTCFY5f2fsNeX+NPBRzm2TeRuhyeie/2j29OyEtui6HXFrfqLsBBkcbduMCbV3pj4n8g2vYNhPCwQTYcR67mPb4pls0lqzgTSL7CRt9kZO2BntxEcm4NEwqM6/7rBZAqirLhl0PhseIHYFXcEFXC+70yko2boulllxLvmWE/On3pyiyVxRcwzzGhPU+pWrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJN+FRIPsTO4ATuYedaXT29RdKqfrJDI3CDv6ZOCuUg=;
 b=RIno+D93xPvK4xIL79PNqNVciGPqPUJx8mrOvpynLPSQR1ukDtL5s7CJC4IEoVtqJfnpgmRw1BfX5b8HQdNFQK4l7PYgxKto4PL/JlUI/1Uboat1cA21xTyJXUwZL95sLtjAdNCOka839B38c3c8SVLNEP/lc4dSDIC96P3pud2zxIy7rnPc6C+65zFBZoNM7H6z8J3KSST40XPOESZRL+YUKaBjm6ZEQMuk7ae+V04KvcLLSHdBqPVPQ5KtLweVLj2EgQpgsXVGH2AsumC5toCg9xdaVwuWKY3cVyf/8oIGtElu3swe1Wtt6MHUM4Gp6SFxObgop+8HG7VlVjFjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:48:16 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 17:48:16 +0000
Message-ID: <8936e2c6-93b8-417e-9151-041c5f2e1102@intel.com>
Date: Fri, 19 Jan 2024 09:48:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<kirill.shutemov@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<antonio.gomez.iglesias@linux.intel.com>, <rick.p.edgecombe@intel.com>,
	<alexander.shishkin@intel.com>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA1PR11MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eb60d4-fa9f-41c5-e75f-08dc1916d0ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDppHuj7jNKsNr0VogyPEwT2/06e2/KS66/YmQ9wvQs0E8tMUTedy8izpEtA2SzbzMNU1sgP4xQ/N4lwr+rFztBauz+4Hc9fG5YyJmSSxhn6JipIB8+sntaccL1OPDjCV6M2Xb8VZnZn03ov6s1WRn/KuWnevbn3d3vO6eaJKCYZoWE4q65SadJTe267Mlh9MCNtuvo8HJtYT8uWGARu9p1mcgB3j+VD9u3H2/cOaxcF0WSLlIjla495yNkbnCLpYd1U28wPSyssilorxhaSGfllqbNYdlUJ7CWbJfXDJT/oQ0yuJasXs2/PPVL2lfxabEadsJXNvG1lu/fBAeSGsk4K80KEfWYsJVOmx3/eYVeFOMJxfk5+xjSYGGrd9AKefzERfqHtMegcnmSYv8g31tJ2ZoUaw5F+Hlc1bC3HucEwxpDwtaMk59iB2sHcd5Ae/H6ln8m/pFmTEDGW4i0xizIiCJiYyExRcXnevemubK3ICjshppZPNrO3nQLn9UmQdb3ioB2p3tw83mCNHjbsLcr1d1SG0XQSC0L49PDLRVX4PpKXjbFbjWCfPhRJN1jccDfPGTSDIp83gIexFncv2XMP+y//igV8M8sBhpCLyrpYJJllVdOqjFCuMWE3hnyVfnFI6i/bhhdzYHyHCGGpHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6506007)(26005)(6512007)(2616005)(41300700001)(4744005)(7416002)(5660300002)(4326008)(44832011)(2906002)(6486002)(478600001)(316002)(8936002)(110136005)(66476007)(66946007)(66556008)(8676002)(53546011)(31696002)(86362001)(36756003)(38100700002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy8yRDdrcnY1SXZmQ1NBZlA4MFRnTE5PTlhJUk9NVWUwZGtNYzdZMmp5UG1i?=
 =?utf-8?B?aURBYktBbWVCNkZmUzl6R09QaWVzeHhGVlk4Rm1IY0pKLzJhMEpMMENkWi95?=
 =?utf-8?B?eGNhR1VKblJiRDhMMlFsK1k2WldPMmlOb3ZvR1NlR1g0VXV0R2s1blc3enBY?=
 =?utf-8?B?b2IzdzVxdnJYem9oejU3TmVLV2JIb3RBa0tLelc3cEkvLzBjcDQ4bnoweDZG?=
 =?utf-8?B?SUs1UWEyZUFpZk1RQnBYK0R5L1RnUTl5SmNoWHhuRCtUMnNDUkpWeHFqLzRr?=
 =?utf-8?B?WGp1NXJJV3h3QkNDdGp0dCtMR1Fsbkx0cHJiYkNzMFpQd2F4NWJLMjgwaXJw?=
 =?utf-8?B?MmhxdEh6RFdQME84MS9iTGp5VEpCaFJvNkp5Rm9CR2tnMi9SVWlZRHVmSkRY?=
 =?utf-8?B?WmFJS2l5dnZPa01tNDlKMkl4UVliTkxsc0VrTUNVWjRvOENORzBCYWNMOW41?=
 =?utf-8?B?YkNaTk9ySm1HbENwaHlaVXVSV3J1ajBmeVRYTHlqcTFKbUJjVVFNVHdoS1BI?=
 =?utf-8?B?OUE0NjRCSEJPeVl1bFJKayt3NW5tL0F5eVE1LzVKeWxqV3I2dlBiTklISk55?=
 =?utf-8?B?alRTRFQwdnRqdjFKTEdIR1NTVy9xbFJkWC9FS3NBc0xLaWtEYmRqMVNYWFY1?=
 =?utf-8?B?T3ZLRU5EYURmZDVNbG1iM0hPWC9rSVVkOFNEWXNqOGd6RXJvYVI3dUgvUzYr?=
 =?utf-8?B?bUZMc1dkTHR4Y1d2ZU5nbENxUnN4cGlKMllwRlk0YUlSQ2kza3NMdUk4MmN1?=
 =?utf-8?B?RU5GeUNqTlgzcWVHWDNxVVBUQ1lVTkFtQnI0QW9sOFNtSTQ3TnRPVFhsb3Rk?=
 =?utf-8?B?bkZDanRUZTZuZjlyWW85MjFrVVBRaS8vWDUzR1VVQkFuQXJFMlFqVXNhZkJh?=
 =?utf-8?B?WTdXTjlBdlJRY3Y4M00wVWZFcmp0aWZ5K3psVHNOdmdDQm5zY29yWHA1RXly?=
 =?utf-8?B?N0d0Z1A4Umh0QkppZUExSFYrSG9mUFNTRWFRd2I1QmQydjRjZHA1bytMeTEv?=
 =?utf-8?B?U0ZIb282ZGR6QlN6U2laOExkTHJrSTVxcDAwWlF4MXpxdlVSai9tOGtwUWw0?=
 =?utf-8?B?WWFaQlBCclFJUmQyTFl4amQvd0phcFBMaTlJYU91NmFPVVhlMEJFYmRoYkdn?=
 =?utf-8?B?VElRVzJ4ZS9kODlpVVRUU1NiQnFqMmd6YStYS2M1QnNSdFljNWY3WTk3QUpH?=
 =?utf-8?B?YkVLaFBmSmlSZmJSUEJLRW4rN0xYRVdvU2p6S0Fud2l1VzZlL2pieWFRVHNL?=
 =?utf-8?B?TjRoNzFNMjlxeEZUR0dpTWhkQXhBcmphNUpvWDdzanltRUJ0V1ZtTDgyS1RD?=
 =?utf-8?B?dFVjTkZMQzBBbkJ5VGNwQlB1RVVxQmdJaDhvOHB3NkhPVEFFNk9lSnh2OWZJ?=
 =?utf-8?B?VzZTSElZWlNCQjVKdzE5aWRtaFZnVkhvbjFmUXV3emdjM1BXUm1KcXBWazhx?=
 =?utf-8?B?bmxlVE05MzE5MWVRMTdrOFBHU2NvY1cvUTJnYkNycjQ4V2pKN0ZzZitCOXk3?=
 =?utf-8?B?cERxcmI2VmlzUU1MNUxjemZ1YUoyOHo3T3lONlZ5ZUt4VXhtM3gxanZUT0F5?=
 =?utf-8?B?ZEE0a284bUJoTWdBN1MxNC9FU2RKTENOMCtnRzlVYzBiemdyNGJSclhQUTh6?=
 =?utf-8?B?dHF3KzY1eEpLNW8wMU9HTnU3RDltSDdwbnhva3ByYU1RNW9ORFdtanorcmZT?=
 =?utf-8?B?b1gzNGdWQlhFUEdFak5Xb2hacTJycWljSmQxVG5HdzRkQTNsQkJkUmRTS25W?=
 =?utf-8?B?djVDTnhyZkNvYVpjVXp2WkE5VXRqbzdnU0dFYm5FR2VxNitncGlnZC9hUjFU?=
 =?utf-8?B?Q0J2RVRWTlY4MUFzQjBzbWI4Z1dDbWRMa2dXZzYrTEhGdUNic1E5MDZjR2ZM?=
 =?utf-8?B?TDZjbFJDZWNjK3JBWGZYdWxOYzB2M1NSL3BvVzVYN0hLODZBbVNsektIN0k3?=
 =?utf-8?B?SkpMNHduZ0daM2VzMkRyUHJTQXN5N080OHJyMmowYmttZTl4S0JTT3A3Z0p0?=
 =?utf-8?B?cDRDbDhFQmtmVjBOckQ4VzVudnJxQ1BBdGI0TFF2UGw3YUIyVGt3RDNrYjhH?=
 =?utf-8?B?Nk5iYk1JSktLb2ZFanJOVGNQR04raERhRHNkcXFnR3FnR2ZOeWNrS3hCV1JQ?=
 =?utf-8?Q?janLrqGIK1673EBZekggPypDz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eb60d4-fa9f-41c5-e75f-08dc1916d0ba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:48:16.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVArC7tnZMz1xb8V5rtxoE5JBs4fPZg9yNnWZvEHrcHtbR+ycUob0Wkc6mCLOWoIcyk/l34Ztn/CK2x8GF2BKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-OriginatorOrg: intel.com

Hi Pawan,

On 1/18/2024 6:35 PM, Pawan Gupta wrote:
>  arch/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1566748f16c4..794517df8068 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2270,6 +2270,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
>  config ADDRESS_MASKING
>  	bool "Linear Address Masking support"
>  	depends on X86_64
> +	depends on COMPILE_TEST || !SPECULATION_MITIGATIONS # wait for LASS

I was wondering if the COMPILE_TEST dependency here is a bit redundant.

Having ADDRESS_MASKING depend on just !SPECULATION_MITIGATIONS might be
enough to get the LAM code compile tested through various configurations.

I don't have a strong preference here. Mainly looking to understand the
reasoning. Other than that the patch looks fine to me.

Sohil

>  	help
>  	  Linear Address Masking (LAM) modifies the checking that is applied
>  	  to 64-bit linear addresses, allowing software to use of the



