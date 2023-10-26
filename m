Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D813E7D7948
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjJZAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZAUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:20:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D750A10E;
        Wed, 25 Oct 2023 17:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698279628; x=1729815628;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJ+GlWUF9KQoO82K8l7rP8XoL76tSzuMTXyVfP6jimw=;
  b=NSXKpg/bJlymPbTTCaT0rnbEOq2GNZ7eNjk+ZYuIORNGR4tjQyKJfgEd
   oGCD4p78DxgCShoXOgU3rRTwkJU3aFUp//cVzVKfHph+X+rm4c2RC5X7E
   hqpp5613Z2xZThgyeMF8bgBu6hU2I9IptaRVSjIT3XCCDL7Bx0k2Ep6RV
   1ycl5fxkFyLBwIGMXEh8lydXxoplgn9Bcoy4dOsygjZkTmhEeasO60bpl
   1mhG3qs+JaAQw9TzZEQMRwtbgs1Yhtj36+osD3cLoQeP/UrjaIM4thAAG
   +4nTntE13xX4N2yf3wYPbjdS7q9cm4NSogamfY1tJffxfn5L9LnYFoZor
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390285440"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="390285440"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 17:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762625076"
X-IronPort-AV: E=Sophos;i="6.03,252,1694761200"; 
   d="scan'208";a="762625076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 17:20:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 17:20:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 17:20:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 17:20:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 17:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erMVVDnjtSadyPJsDQlAYsEF/1b3har0WGiJSu3rlivbYN7vMsGEZL2wnParNHVrBSVqGFk710m4jJeIiQcmwSdEG0PTDlPX23z/gsxkQVoUCTnhHBMWDkoZgqp+Wg0vyjtAR2EcaZ//ZHHUQvEEocAFlDkj43AA+ZVwhruI4b6aCc3XrkW2Ll3SS0lKzLgL/ZXgpC+SdZsxjNBVAneqhtZeiq/oqQYraABf7SwIbjf/1k9h8G1ZeM7yatQVGg5MMBON8PDUsDGZNVPbeDDPr+ed9VcHp5yMwxRQcLOwBgxxMZoUMaZ+or0To/IRQLT0MiHHcB0+PIinfqd/+8JmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6CnOH4jDprdyxRTxT3zreqosuKUyUb7jE1etPiSn6k=;
 b=oc/6uMKwPpNuY4a7nDizRGY6kzKs3ic8WAr1Kj8rgi2ybE2YNyL30Bu1MzQfm71sXGiT162ITADjr4ElvjfqSg7hRzN5atAsgMVOnglvj/UDT/nGfo6dJl9WyROEw7Ha5ZdvzTt3doTpGx92719VivSlT3QSwju1eYGd9IxTctccjoQahiav6qwgK3kURDeK/tePUHpTGAHOkyqCDIqFfJKU6QDrvD8vNR7dQZf+BpiZzHG9Bi9mZ9mPxCEbNeaVbVN0m0ec3lmA/fc3WG+amf2tQFvHWV/WD+Vga5v0d3RQ0w7DHepnh6aMCLrTsBXW4HOzHSuAnkvPoHfsCFPuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8333.namprd11.prod.outlook.com (2603:10b6:208:491::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 26 Oct
 2023 00:20:05 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 00:20:05 +0000
Message-ID: <6d12707c-4666-40ac-9c8e-79b65f011263@intel.com>
Date:   Wed, 25 Oct 2023 17:20:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>,
        Wojciech Drewek <wojciech.drewek@intel.com>
CC:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
 <ZTkHJ6IP4tj3EmCV@nanopsycho> <ZTkIH68kCzb+4VME@nanopsycho>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZTkIH68kCzb+4VME@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:303:16d::22) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: cff095cf-90e0-4380-46f7-08dbd5b94dea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEftvsAWdagz3wJVyIJIkfyg4iCU4Q7lYT4siKHin9PpoRoN9EtRF81RymKVgqcWE9BQG6a/QnE0LXjRRYzHGNQG3TsQXgjgZJIWs1dRYcKU3PbwggOit9BkqjVrb2AYkwtQQb41OvoKKtClvND6LeLgHBC5AKJ1OU8kSPpozAayGijdGjnbNwFcKGtBn04Yt1aVD8wcO5K8SuAKaCUvRkXOj9HIMuh4TjZkLLJi7eb2yVkTKqyBI+pFhw6tPb+I5OQyGyhTWQFqWvGjW5aJ8DyzcUxFc8zFdGXtbrBYqXhR9cZFGT3PaGUeKi3lHIvRNiFhkuZYp7sLGvhDg/TQ/9VP5dX+xf/mkyG4mzL9osK5Cyg9908wzxl482s8Dmhn4KCxUuWiCAtlovFvz/rJe7m8ezuTrXWqeqHX7l0GmDXmMuEN5QeHFrRcijdeDKvIzWb4XIckuOUQgcq0aZTipzRgefOVC8oPcqALFxQ+PuXmgiHkbMHRYGBbjKq3AN7ywfgvoBhXJ/1hufhZia+XQLyve1sVIuvnnMGWZiXKRGDY9H8GpSEFYK/wk/iRVePPS412KlP1UqZY/lJMxIZZvEZRKeAMH+x06Pj9m1HbTOf0m6n9/MfxJrrmhe3eNlZpRPZ/kSTaAIiKS6eGMDTVgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(478600001)(6486002)(66946007)(66476007)(82960400001)(38100700002)(86362001)(2616005)(83380400001)(36756003)(31696002)(26005)(316002)(31686004)(110136005)(6506007)(53546011)(6636002)(66556008)(6512007)(2906002)(6666004)(54906003)(41300700001)(8676002)(5660300002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRMOUF4WUtBdlFXdmFBUmZyL2kzQ0ZwdU55OU1RLzJXRDE5T0xOT2ZOZ2NU?=
 =?utf-8?B?Nmxhd3RHM2s4ZmFNVkdtczR1UUNLaVkra3RnK0RNQWhuem1oYysydTV1V1ha?=
 =?utf-8?B?UUw1WnZkeTk1Nk5OcjM5WlV6T1ZWMWlvRDBpUkozRjBjVzdXSm1mNVkwTnJp?=
 =?utf-8?B?NXhQRHE4RlJ6dWFLa3FZcHZRSm1jdXIwUFBOR1dYWW14R25iRm9wQUJQZml1?=
 =?utf-8?B?ZGRkNnpsOHBTOURvTUxmeUVoY3NIY21FQW9mTDFjcDZKcjl6Z0d2ejNwUHFF?=
 =?utf-8?B?NEwzTld2R1pPUEsrcU53YmEzVk5WVU5YQmRlSjNVT3JxN1FvNTJTcU14V3lV?=
 =?utf-8?B?eG9MS2Z2M01UUGk1c2ZxZXU3WTdBYjdGVEhWK3ZMRitObm5lTzVzNDh1Wm12?=
 =?utf-8?B?WGdhNWR0OWlObEZhNjFhalowNEZqZVVjaXQzK2wvOG5teWoyL0ViK2NqOW1E?=
 =?utf-8?B?YWNobkhGY0lQWUp2TFdEb1FxUWo1dldLbzdtakxVclpmOUhVY3d4cmlCcGhu?=
 =?utf-8?B?VndaMVVueXNPTUxKWFIrVitaT1hBdHRYN2hnMndUR1hUQllyMW9rQy9yQnFw?=
 =?utf-8?B?RWtJbDdkZFdyRE1IOThnOEN0UmxwQWUvbDVvSWhUVjdtSzNYcDdRRkdyOUlr?=
 =?utf-8?B?Q0ZNbGZ0SDV5dHNsbWhsR2tEQmxFelpGK0FFc2NaS1QzUE1JODg1dnU3aXJs?=
 =?utf-8?B?bTZwbnJCS283b0hyVDh2WHZxR1VseTFtdld0cHVob1lwaklUNTI5NmxTNFR0?=
 =?utf-8?B?VDVlaGFNcFJZWmx1ZUdIbTc4dzFrSDhpRlIyNjZqMFl0Z1VYWm1COE01Z3dV?=
 =?utf-8?B?b2NlSXdrNFFEZkYyWEhRaXpqOUxlUTVIbmk1N2ZhMitOMFE5TWtMM2pGSXhU?=
 =?utf-8?B?UHI1ZXJ6cnJBZVVUbDI5MWpYTk1waW5ibGtUOHVJR3pPclZ4VU9hRklpVGpU?=
 =?utf-8?B?bWJ3U3o4QUJDQUlkNFNFTzUzS2NzRXVqb0NnUkVQYmJ4cHF6cGdFYlg5cWJl?=
 =?utf-8?B?NkpNcTNMV0NZNExVTHZiY3JKZEhmTE84T3ZnVkdnOTArK0lKZzVDTVB1OTY5?=
 =?utf-8?B?dWZTdW5ZdXEyRTMzQUdMd2V6OHpZdjQvdkI3QStGWmFXZGlpbGo0S3RvOG5G?=
 =?utf-8?B?N3NNNUZUdjVHM1VIb3VIL2VPU25EOWVZU2srMzBVTlBJNyt0ZklRQzREdUlV?=
 =?utf-8?B?MTd1ZklrcDFRejFnSmFUYjdubWU5RkZFaTdqMnB4SjQyUlY5TjJhMUlycTdP?=
 =?utf-8?B?ZmNHY25XaVRFVDBQZ2FLN2JBWUphcFhFVWY4eW5za0ZoNUh5QmVuTmd3OFd2?=
 =?utf-8?B?SUhQWnFtcENvK1hHbG0yM3VtcjJEWkpVOHlkd1p6Skt5eDNlckZEb1RXZ201?=
 =?utf-8?B?YWNmS01RSXFtcjk1ZEdKTGtWSkZocDZpQktoVHNpb2t0ZHBXdDk4cXIveEI2?=
 =?utf-8?B?NGZoYUhwZ1crMjRBZVFiQjFzdEVtOXk0emJrbnFIcUZTQ2NIaG5hTFpFc0VS?=
 =?utf-8?B?MXRXd2VYUUVyclVSU1Vqc3lTM2V4L2pZMTFiR0FYNVQ1OGZSNG4waVdXZ25q?=
 =?utf-8?B?TjY1a29EbzlFK3EvalVoSit5NUx0THd2cDNVQmEwQmlueU1NaC8xWEZ4SWlx?=
 =?utf-8?B?cFpTYUtKUHBiWGpHN0xjQmtqQTcyeEtBbm5SdGQvelJMVGdpZ3F2bCt2WVNa?=
 =?utf-8?B?MDJKUmJ0S3czN3FJNWhQZ29oeGg0VGhsK21adlpKSFdydW1mWTFSUW5DK2tC?=
 =?utf-8?B?M1IwQXNxQW16OTZralFoUjVOODFlSFVHWlZWZzh6L0FZckRzZGI3YjVsYk1j?=
 =?utf-8?B?aTdZK3FYcGxVdEFrSHBhUDNQRzI3dUw3enFwWlRPWEJDcW5OV0pGNnpZYUxy?=
 =?utf-8?B?UFBMUDZtNlBPMkExMmhZQjJrMzBYYi9Tcm1tclk1VGFveHFNbUxINzNINHg0?=
 =?utf-8?B?REd0UmZyNjVRVWs1OVM1ekpOOGFjVnVuV3podDF3R05NejBCL1lHNVVIendy?=
 =?utf-8?B?YlZHWlg1U08wNFRDNWpWa0p0c3hNWVdQTGZzOXNRdm16UzczRm5XTFlHdllp?=
 =?utf-8?B?dWtLMWhaWVVZOVBoMWtYa0JHVS8ycUQ2Wm9heUc2NkNPOVMxNm5uY0xWMEls?=
 =?utf-8?B?dmxtQUFMWmJWd1ZueTZKU3o1bWJJQitQQjlJRHRUQTZxemkwcFR5T05mRFBL?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cff095cf-90e0-4380-46f7-08dbd5b94dea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 00:20:05.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtBU8vlfocR5CxvD+CZ6Dkqpldr13iuW+WuHio09Lh2xCyA1sXk18FGHcuk5EEXFgYuryBuiTLNAwqUJY5H1JhAwzWJoN86raqHBAGLwh0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 5:20 AM, Jiri Pirko wrote:
> Wed, Oct 25, 2023 at 02:16:39PM CEST, jiri@resnulli.us wrote:
>> Wed, Oct 25, 2023 at 12:48:37PM CEST, wojciech.drewek@intel.com wrote:
>>>
>>>
>>> On 25.10.2023 12:33, Ivan Vecera wrote:
>>>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>>>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>>>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>>>>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>>>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>>>  2 files changed, 10 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> index 29fc46abf690..896c43905309 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>>>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>>>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>>>  {
>>>>  	/* set head and tail registers in our local struct */
>>>> -	if (i40e_is_vf(hw)) {
>>>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>>>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>>>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>>>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>>>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>>>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>>>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>>>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>>>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>>>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
>>>
>>> What about removing those I40E_VF_* defines?
>>> This is their only usage here, right?
>>
>> Wait, do you suggest to use the values directly? That would be
>> wild even for i40e :)
> 
> Ah, sec. This is duplicated in
> drivers/net/ethernet/intel/iavf/iavf_register.h. That confused me.
> 

Its possible the iAVF code could be cleaned up too... Historically the
i40e and i40evf duplicated quite some code.

