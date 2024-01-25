Return-Path: <linux-kernel+bounces-39274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9083CDF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055C31F276E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFA1386D2;
	Thu, 25 Jan 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HO2A3qPC"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981027468;
	Thu, 25 Jan 2024 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216596; cv=fail; b=jAsOKTLAFD9KItgfvg0jP4b/dzPr3VNe+jLRSND2Ny+XfpnAf5ZxV8VYeFb7H18hoCRnHj+xkfGdJz0xVC8xREJi5osiAoKmdOoBSIndj2NwL/1/H1r12ISDWXamo4RKtAEVM/tjo/ki4IZBUDW25eGLvqmSoPuglOG8s87PkK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216596; c=relaxed/simple;
	bh=iOqbu3sHTO19eqsfa+LuX2t/u3fLIw8FzDF8leak0xQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwqrCnVPXa7R2wQ80jNLuJDQYl13jeGVFhh9JgZbrZnXozQUf3S85FyFRoWwFgAXXBOMf/X/LZ7As70r8ILFtnkCeYZIpNePiavlTHo5n4x8lgUFcJvjWx25IUkvxFeMZRFeSErBjyjIUdqhsBDBAHs7/4/Km60xucHZoMEk9YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HO2A3qPC; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706216594; x=1737752594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iOqbu3sHTO19eqsfa+LuX2t/u3fLIw8FzDF8leak0xQ=;
  b=HO2A3qPCH2pAMp8XaCssfatFDeabDPFnS2Hwu3VbjLSf7jnpAimWKv49
   lV3O3bK/rnp85zyyqDdLM1MsoJQD0dijGaNRYt9J6GOiblOQ0nJ9amGPs
   zWqMrORUt9qVW46T/JlzgNKBZJUHn6fYY2S3wM08qm8FN45ui2WwzB1Bp
   EvDH4QxQjSNACR5dXtH2WL3hyFlk47u5n+GEF2O6sDGqD39c2b8au8b1M
   QKxs6LyjsTIAHw34kErQBkm8WHqx4+b3+fI8ceuLaouHFMOCADG5VrYXF
   L3VCuXFIx33NGt1l5b/8g6MTDbV/d5ZeKoxkH/ayGxr4b4L8OrHFUs7WG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="433454143"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="433454143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:03:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="959995200"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959995200"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 13:03:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 13:03:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 13:03:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 13:03:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 13:03:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMQVKceb3bqQv+Q3BChD5LTJfJRaC7ngvSawg0RtlRnrrl6KBWhXiSrHkvbrRtGBEBC0B448A63g8umh/9W8InFNPQF7gI0DZ3OlKq54YhmgfOuB/D6VbCFnpSfXlZgcrMlkmBSild7ZK9i94rqoXFWNPlfciNBYFNRAXssWP26ZJ1JlH061REKJatYoBICTeXoAS1QUHylZ+FnIwcTdzRWLlmkhcKFdFadpIAGQaIEOtNq//EC5OW8Eoj2pd2HB15NNtxh8x5F7tKpEs6NQrlf80uvnuJRJ3PFbULLl18gzAB4nuWvFKd68JeDymkn5pprwrt+vvePH43M41NNCrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=angtyveXERsDoyTVEgMJiz5q6f73ZmExMJOWHtquvuQ=;
 b=bYQn29e5/4FzPf9+66u9BwouCRmLbyTv6B2bV0/Kmvs+XI50mynHogJ/tI+QcBR8mbM91IJMSdp5f2uwUForIZhkiGz6T6g83+uIEpef0vYnEbwvwJOG8pKyiNUNzL21d5IxxcxBxhPOKkWlvNvPlM5HcZ4RStJsGnZy+fXMUI+ignIgfY2s8lWyEgtpFLw6mg/1mpeOh9lVASvLvPOfz1rN7DJOl/g0aiSqqmGggFGktEreK5JljmCD8olbFOgFz9bmr5V7U0U+VbHiScjGM0NPSDol2KpOHOx5vrr/0Hh0tfW7dBZ7SePNLC03TPwfJbLq0j/VGnpyRF+pLuAF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SN7PR11MB7089.namprd11.prod.outlook.com (2603:10b6:806:298::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Thu, 25 Jan
 2024 21:03:08 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 21:03:08 +0000
Message-ID: <1792a925-172f-4a9e-ad59-dea474bc7cda@intel.com>
Date: Thu, 25 Jan 2024 13:03:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Content-Language: en-US
To: Avadhut Naik <avadhut.naik@amd.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125184857.851355-3-avadhut.naik@amd.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240125184857.851355-3-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SN7PR11MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ff989f-4ae4-41dc-69e2-08dc1de90814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MqcQLS5Y2l4SMbwgdEC9Ga1ACM0zpz4IwUTor5lP3U1IleTJ9ElI4ZmBVfNMjL0GwLIkMDSsU/VG+1lX42phgYdLNikt/9p+Tnjmz1tJiGQz4So0X1Z2IKG8V061iSLkjHqNMbBRcgd/LqT0ECZAHL5CJi2igNLY8J+roN7GohsSfUdq9LzlBAtYqAxUHi4unAQrtAmRyUlp759+C1WFN0b9zTWduIzvh5IYf22Ur5aiha75cgbCId2owpsVoQClH0JtUBtzoLGnZdWEzHKvgdL0+cCJAG5ck1XJ/J6Zw36C1oBAP/TSukx21vmMG0Cyo7WfmlwkKUkJQBy96LZQycr2W5y3kc/UXDEGXs0S1w/9P2HWt5yBo4WAwC5rNz/J7BtvssI8zW44ylOksgxBdCKaLClMInY9XBiuUHoblmPONEkFHZaE5n35EDt2PPNr/Mvr7jCru/WBVZhoQ1IyNf/s0YX3vhW3VZ0yMFjre6zFHvj0yR6mdhPXBHfYWY90E+ulKkKOtk2237+nrkiQIAFMDuKxTDNMLzVCneA2EqzuPXVCtD7IINtDODbaW1FVMLGcnoJfX38o1sAoNLrtvGQ/Ba9zr8vW0oYh1zX+5XwZ/aJpDfPYbx2O6b1s2kZAJ9/JRta2pKXmygY7cX40iUWAMspS1O9WkxdJPx3GRh7MtsJgPchZHaQF4G8M+hq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6512007)(8936002)(6506007)(53546011)(26005)(5660300002)(44832011)(2616005)(6486002)(66556008)(2906002)(8676002)(4326008)(66946007)(478600001)(316002)(66476007)(86362001)(36756003)(82960400001)(38100700002)(41300700001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdXNXhxeFZWUjJ6MzdEdElxUjM2aVVNbmNwQ3NxWjhPNEMxSmtSYWFnOWsy?=
 =?utf-8?B?ZDY5aTVnNmQzaEt1eFZzd1d6RXIrd1FVbkg5ZnIxcTNEU0k5ZG9PdEQyZE9i?=
 =?utf-8?B?WmhHellNcUh5emZYWkVMbmVPNGRxcEFmeFk0dDFzUXVMWFpTWDFTMVpQaUVh?=
 =?utf-8?B?UTBPNWhtQlVOZHJNTHJTZTFxUE9kVzFwUk1kUm44M1ZkSjR0Y1gyQlZzMHE0?=
 =?utf-8?B?YXVodlFueFFDdGRQSmZ0b29SVU00SjBQUHBRSUoyNldCbFZ3Y0l6TnZvTnpq?=
 =?utf-8?B?OVdjZW1JdjRQYW9YOURwZktlN3NYRk9temF3UTg1aGo4My91Z1NmNmtPbW1H?=
 =?utf-8?B?QWlkYjM4M3k1OXdxK09ubnkyam9ZZ0F4SkdyVktzdHJiL1BCN3VqMHZHUlFN?=
 =?utf-8?B?b08ySHdENGd6d3ZwSVIyMTN6NjhsNHl3MFdnQi9EV0ZCUkNibWM1T1hkanlZ?=
 =?utf-8?B?L1FubW1zeWh3Ukt1c3VNekFIWlhQb3lLNFp4SURmNzU2cEEycHdIeFJZUGpK?=
 =?utf-8?B?UzdzMy8yOEV2N055ZVY5RHV5RWZTWXVIZVRRTU53NEd4WE0vVUJNaDUycmdE?=
 =?utf-8?B?dFVRWk5Sb2FzYkYxM2V3WFdLQm1vMGhsQ0IxK2xnYWw4eDQrM0EvYnVFV0VJ?=
 =?utf-8?B?MDdFLzE3bjRsY25OSzBNRmJpcVlyQnRiSFBrQVIvYkxOMlhYTlVFb1YwVkxr?=
 =?utf-8?B?ZHJrejdNd2tmNklWT1F5amM4UWdKZjZqM1RhVVhmWGFYdVkya3YrQ05YT3Yx?=
 =?utf-8?B?TXV0NVNsTW5rVHpZMTZJemljaEticnhwdFNUNzFCM25rNUg0enBvUVNwd09m?=
 =?utf-8?B?elFTUnAwVWI2Mno1aVpDNDBxcTJ5a0s4OTBuTWFyMTBxeURnNndPbXBDWldY?=
 =?utf-8?B?cEtaN3U5RUZaaXJ2dGw0dzY3MEE2ZFJubUovTnlXZ01VY0kvTVYvZUE4V0Rk?=
 =?utf-8?B?aVd3bU1NVGNMdVRVcURsWHJWdURDaVkyaWhnOVRhYkZUSmwyTzR4eHhzY1Fm?=
 =?utf-8?B?UTBjRVB1OS9ENW5Zam5YL0hCd1A5c2NJT1dVcEZIekFvVWVQQjFUUGxvVms1?=
 =?utf-8?B?bUtnckswVkhyOGZVMTRqanBtdlVJbXZDMkdsWXRQMk11MmpCcmNtTDhqQkM3?=
 =?utf-8?B?bmUvbGtnTU5tdmF2KzJhQ2k4Wm5yT01xazhGeWZjVUV1SzFac2dNNjFWOWEr?=
 =?utf-8?B?QjlqYWxtSmVLWDR0dDRiWWVWM3d2c21sZzZRTHRZM0J2cm42N0hhU3ZtQzlo?=
 =?utf-8?B?QXlIRkUzU0NLQ3BrRVJjMEVlQUI0REJpNzU1S25NbmVYMFpQK0U4U1NlNklB?=
 =?utf-8?B?d29UMVhuUTJ5YnlEY1Z2ZERSSXYzSlZaRjBhS0lYaU9VbU1rbm9aQVE1WGlr?=
 =?utf-8?B?c09OeitRUDVseGg0TWdkOEZISnJmNEc5aklPQ2ZKS2JEdDJxbEIwVEh4eWdn?=
 =?utf-8?B?bkhRcUlreWVUYnNSK3B5QnIwZnBicm5NU3U1K0RvUWtJRTgrNUs2d2xkaUtK?=
 =?utf-8?B?bkpub0xZcW52elA3SmYzUC9PWEZUUXQ4TjVpdlhPSVFaTXp3OW5XNWF3MTdP?=
 =?utf-8?B?MDJNdEZEeEVQRFlKeDd3RHd1djlsYnRuWEFRakRBSzhscFFYdWhqcDlvOVZM?=
 =?utf-8?B?VkEyS1dCdExYNU42bkZwQmE2UGVhYTNsZ0JLcGk5dUZISnJ6enBENllHRmZU?=
 =?utf-8?B?SmhEK1JFdDVITjFqWlFaa3FkaTRCNXdtTG9Pd0NiUUpvVVZFWUhrQjBQUVJz?=
 =?utf-8?B?MExtTUVMQmlGMkJqRzE1R1c5OVE5TWJlcFVDQzFwUG04YlJWa1JtWVlRY2h6?=
 =?utf-8?B?YUwvTXJwTzc0R3AxR0VLSVZQemZRNWZ1OVNPcmc5ZXY4TWRWM1dvbXR5T2xR?=
 =?utf-8?B?WU80NEFhU3Mya3lEQ2xpZ3FTSFltcTZyWlFlcThXbEpVNDI2b2JUUXIwTXMw?=
 =?utf-8?B?aUV1amxWSVYrZmNLTlVidnp0eGYvNFhId01qREwwSC9pbUwrZkF6NTZXZTFp?=
 =?utf-8?B?VWpkdTc4RU4xVmptM29IYzNJSnZTZjgwR3lXajM2d3RBSkZ1YmI3WCs1NG10?=
 =?utf-8?B?SEhzZzlUQ0F3UzVudERVYTg4Zk5TNFhXWHpVTTlJVDgzTXlxcnM1QmVNSmI3?=
 =?utf-8?Q?M9QY0LFniPWVKFMWuhfLG8yFK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ff989f-4ae4-41dc-69e2-08dc1de90814
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 21:03:08.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFiw5lDnE72qX1Mhfgsy4qfPqFZV2XJlSmiZmCEdkDc/VtZ8+16iJwRijgbOeaf+4AVTq/RigMhxffPDt6sCZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7089
X-OriginatorOrg: intel.com

On 1/25/2024 10:48 AM, Avadhut Naik wrote:
> Currently, the microcode field (Microcode Revision) of struct mce is not
> exported to userspace through the mce_record tracepoint.
> 
> Export it through the tracepoint as it may provide useful information for
> debug and analysis.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---

A couple of nits below.

Apart from that the patch looks fine to me.

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

>  include/trace/events/mce.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 657b93ec8176..203baccd3c5c 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -34,6 +34,7 @@ TRACE_EVENT(mce_record,
>  		__field(	u8,		cs		)
>  		__field(	u8,		bank		)
>  		__field(	u8,		cpuvendor	)
> +		__field(	u32,	microcode	)

Tab alignment is inconsistent.

>  	),
>  
>  	TP_fast_assign(
> @@ -55,9 +56,10 @@ TRACE_EVENT(mce_record,
>  		__entry->cs		= m->cs;
>  		__entry->bank		= m->bank;
>  		__entry->cpuvendor	= m->cpuvendor;
> +		__entry->microcode	= m->microcode;
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %u",

Should microcode by printed as a decimal or an hexadecimal? Elsewhere
such as __print_mce(), it is printed as an hexadecimal:

        /*
         * Note this output is parsed by external tools and old fields
         * should not be changed.
         */
        pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x
microcode %x\n",
                m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
                m->microcode);




>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
> @@ -69,7 +71,8 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor, __entry->cpuid,
>  		__entry->walltime,
>  		__entry->socketid,
> -		__entry->apicid)
> +		__entry->apicid,
> +		__entry->microcode)
>  );
>  
>  #endif /* _TRACE_MCE_H */


