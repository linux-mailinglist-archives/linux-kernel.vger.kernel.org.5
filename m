Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DFA76E5EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjHCK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHCK4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:56:51 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E145B30E4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691060208; x=1722596208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EZFgK8rDWPW4wtnMlu8TPcMYXnSF2tjVk3AMxMz80rs=;
  b=m+kEnxzzqa6cPfY2d7rUSkCMYCRP1a2+/nwZO7G3iVlx2wmseOwcIVPk
   sYUpaAUvMklPazOG9XJLM8xVdn2InQ0T6YulK59RndFL9/ApU5HB0mazH
   SnoM2nP8d//YLTPjLHazmcaMnvCtbvZze1T24ZIIYgCgXsuUs+dxp4RKs
   DZ6QHQJOMnKtnjlZrcP/pBaDckCmpFyGu2UFTmIh5owvZ5DkPwrU45svs
   NYica6bif/hzUTLI1V4Wv2azEuTwEpKUJIofizUURTZBdYJlgbA1UaPJ3
   m0Wt6K9oJYNTcT8ovpOKz/3k96otWoF7Z2RD087hP8KkR730biOUEAnoj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359881083"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="359881083"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="976029599"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="976029599"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 03:56:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:56:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 03:56:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 03:56:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 03:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK4FQwrt37MJ/nomVa6kG27vHsumJPZtKIjam4feZcNd5XSXuyoIuckeF/aU0yulJc4nixUas8bjaCoqY0ApQvVZRbTVrUwOEPADQp19aYZm0k4x9k4zYdu6FjYz9/3BKvphG61PwuZrmBT3qfv13BXR7bIUsqTfC/qcFOsG4W0W/X2FEOEqGbOWH1tbrge8cp2VDqdo82Qem9ZF/t7xRqC6Td8EZFBKkB/Ynoi1omwsUi2zDxIuFxtCkEGJ9Dc+zm33R91fBUp5H9cEOWATl1K1PeusH4iR2GPnJ4eY6+7PxSQWGXuUPyxU3sx91aVasUwQTusaiRIRgPMlS/Gx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tzmPB+6xsmnRiWySccCfutG8JTLqXQXje3RNPWDaKw=;
 b=gVGYCmFDUZ0xZPbNGpkcYJywyn+IYOHpMhexoiJg2zDBkI446pA/gHT6uhISf+Bp3NXwaH464amY5BhtCI2BSLZR3/51j4NA+IEy/ij6GEfZCUuN4bmLn5rZzrYwKjOrWxDhSlKeMS4ZTkRv+h694lOzEsisrbBnkEPgikmLzvGkKEYsRcuziqH4X28xWC2+X3EvSsifi4C6XuAXQux8AEw9wf7Oawmb9O08rl8BAzVf67uQVCp/auyNlqwQOuFWJVaQG6scAqC7EIyRUWqbI+E/ylb9wBWUf9OOpvL2kUiC6gF4gWHARC4VZJLoRBYvY17RXu8HtwRlQK4lrG4jfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 10:56:30 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 10:56:30 +0000
Message-ID: <3b05ee9c-e77d-9249-12ce-69c29d5c088e@intel.com>
Date:   Thu, 3 Aug 2023 18:54:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
 <49142e18-fd4e-6487-113a-3112b1c17dbe@arm.com>
 <2d947a72-c295-e4c5-4176-4c59cc250e39@intel.com>
 <cf71f899-e302-0e60-c21a-6af65205cd39@arm.com>
 <07d060a8-9ffe-16c1-652b-7854730ea572@intel.com>
 <fb12d5bd-de74-a4da-8a38-db64cfb3e5d3@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <fb12d5bd-de74-a4da-8a38-db64cfb3e5d3@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 70284d6f-16f1-44c6-e88f-08db94104b34
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhWKmNNP9PfquxZJtZ6zU3P4r535LUeVu/1F1GexTHXIXz5Jjv9tcCVPFfrouoiaxnwyCSWu7Y9t3IpMGniFzlzXTqtAlqvCUrRjqloHtS3OKSxg3CYSvc/S9uKnDGGSkAd1KLidJhT6I/leqBJSezdgkViQjL185ntNKhTUXDU9rc8egAocZn2DPxRHwkgrdScrn2O+uU4nzafXpDa3D7FMsyc9tfMaPAMwWO7AjoMH3HFQRJbVkzEINXC4l6l6KZ6F3S6lL0OqJtyYHqqYhJUmNmCbTm19FH+xAT31F1CGyhxlAHOgjlOuybLhDAqqQPi38lFaWmxKHoAOX4WBcVYKDVgNx/bACrkvlamlqjvveFAc4cgtnyukdydnIuEpcmvXiTbng0m+bEMRbWQjujGehxgtWx/PSZXKtuGRpBPfdS/yRrOw8fuf9xqsZfyNMUwLwapyec5ISv/pGSmiedkBF3dL0FyS0w6IrqAU6triAqOZDJES//Yqp35ZTpwTsEznPLK+o1t/MKRTAiQ/Jfsu+dvkXChsDgis/+YE4cDgmtpHupsIosTWJ+NwVxH9Kf45xRnxUL9YTiM/Y+0kMBoLgRqyMEYVLC9ZUUHS2xy9RYaw/hGGI3Vll9dIQ7CSOgsRjA4yNZT/aFDaXdIfnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(82960400001)(66556008)(66476007)(66946007)(4326008)(316002)(83380400001)(38100700002)(6666004)(54906003)(6486002)(6512007)(110136005)(478600001)(5660300002)(31696002)(41300700001)(86362001)(36756003)(8936002)(8676002)(7416002)(2616005)(53546011)(6506007)(186003)(26005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZOSlZyUXMzcWFhWXRyaXRCanRFQlFLZmhSeWNmU2J2b0dVb29uVXFTUWpn?=
 =?utf-8?B?Ymd2N3pQazI3aVZ3SGJKTHUvWVlic0kybVE5OGN3cHJrRHA1QlgyU2lSOUpq?=
 =?utf-8?B?TTg3QVUveXptRnRzbnZmczNPOGE4TldKMDBSUElkazRLb1hlM01ycnNnOW5l?=
 =?utf-8?B?WGFHNHBqV2x6TktDYjRkR09USGRzSzRKSnpaNW1mYldDT2hmVHdxYldsL2Fl?=
 =?utf-8?B?UURQVW1sMUw5OUkwSS80YURmekRZdUo2V2hXS1N4RGM2Mm5MQXg1RnE3bTJB?=
 =?utf-8?B?MVhZcllQclFFMFFQbVdENXNTSEJmczBLQ040RnRyVXJWaiszZHViMFJWYjNK?=
 =?utf-8?B?Vnk0V05xVlgvYnFGcWJYaVRIL2tJWndmT3A2dWVuaXhiTUpUNjJZT3NncU1G?=
 =?utf-8?B?TFlJcytpY3NRbkFOMW00MU5SUnJLNGlxOVkyV253aTY0WUd1Sy9yd24wTzht?=
 =?utf-8?B?S3ZBSHhTVk1DUU9CYnpNMGc0SERRSjVJQXpNYm1xazAyL1lFTk1QMHVlZXVB?=
 =?utf-8?B?dU8wcjZFa085SCtwaGRrM1pvOTlZRElnMjRRdndRUC9ERkRTRDFqWVVlVWRM?=
 =?utf-8?B?OGxJeFZOQTNQYVNpSHJCdmxteWFXN25semZDeFNiR1QxbWJyUzUwdG9vODgr?=
 =?utf-8?B?M1IwRVF1NzF4Vkd4WGd2aWNUSmhrRnU5VUhTYi9DTHhUV2o1Wi84TG05QitI?=
 =?utf-8?B?a1lOQW0yWEVwWHFDd0F3OVp5WTQ1eUp4U0g1T3JKb0M1Qmk1Y2gzSTdUaURJ?=
 =?utf-8?B?WnFpUlhkUEtIL3VsaUFxYnFRc2x3cTA4L0FRUzdVTVRrTjlSODdLWHdmMmFu?=
 =?utf-8?B?alBVY29TVzVYQTl3N2JXTndGa0lTUjFwbjVjdGNVeWdlZjFOV2s0bjMyRk53?=
 =?utf-8?B?YmpySEU2T0h1UzV0UlFSZEpYdllRT2U5THUwZkc5N0JFNzA4SVluSzB0Mkda?=
 =?utf-8?B?Q2NpTGVTQkhNRFB4YTJEc3lvWVhMVmpJVGxyOGJwYmZSSldFTE12M3hnbk9i?=
 =?utf-8?B?RkdINXFyWlN3MndDNkNDWEpXWkc0bWd3R0hxNHZaVDg5REdoYWwwWVVGZWo3?=
 =?utf-8?B?MHZ5S2plcktHTk9OTEJPKzhJd1puRmsrR3FsL250MGVScHcrOTQrdTZneHZi?=
 =?utf-8?B?NVJWcTh2L0NYRXlxaytPbUNnU1RCeDlVUjQ2TkVKVjJZMkpyYjhuY201cHJw?=
 =?utf-8?B?aUpWa3lJVEpiRFFLWDVYcEFmSGR6YjRNMHJ5cnJ0c1ZhTHdlSkZFbUxmK0kx?=
 =?utf-8?B?eEUvSC91UkFHQkl5QUF1djVGNUVka05UdDBHSlhMSnRmT3grZ3Vkc0JWS2Nk?=
 =?utf-8?B?RUhjQ01FZHN0TmJVeGd6Vkt6VHMxL1FiREV4NHprT0g5Q3JIdVBoWmN0WHFm?=
 =?utf-8?B?a2RxZTIrTnlGMDQrYkJWK0l1V2I4aFBBdnNGVmNrNG9VMy9hcG4xdEx3ZUV0?=
 =?utf-8?B?M1dxQkREUWIrc1ArbWZWZThEdncrMm5CWlJCd25qMVNlbjdpemtTNnpuTkRM?=
 =?utf-8?B?MytITFBZRGl5Vmcza3BodXNSRUpEV3hySEY5WWl1YnFudjZvWDE4cGpZNmRs?=
 =?utf-8?B?YWlhai9iVVpwKzFDTDBnTVZQZHpZUGxTb09KMWFwVXhVcVlvaU8rdDF4MlNF?=
 =?utf-8?B?V0NhbTljUkNkdjBCVE1VemxTUW1aMWxtUmJnZFRubkhLWGZxVUdFYUFUR0Y5?=
 =?utf-8?B?bDRHOXQwNVp5Y3YwczZxOURyN0pYUXozQzYwMGNvK2JuZEQwNHlZY3ArdnFj?=
 =?utf-8?B?R2hPTDh3ZmVvS2Z2Wmo2SUN6NUFsUkNrdmJMb2hTVmVMU1lNR2FMVDBTbWRn?=
 =?utf-8?B?RjBTcThWajVNazl3UlNTM1RRTVAxQWNSeEs5djRBRVZlUituRFFRcmZ4dWlZ?=
 =?utf-8?B?eHdSWHJicEZIVFZGZk1acWVQbTRrSy80K29YRXlNN1BlYk95TDJqaFh5dHZW?=
 =?utf-8?B?elFDeXIxR0NsL1B2V1I0a0VPanAwZWU1aHZnZ3RQOEZJWFVmalRBOXJnODNT?=
 =?utf-8?B?Wis0YmpGWkRuclRXdjlFYWhlRFd1Y1Bac1lKN2lGSURHc1BDWWRYVGxWbUhs?=
 =?utf-8?B?TS9jTTVmY09HdHF3ejRVTGRWY0xGVFF6VnFiOERWYlROa1VwNVYySGN5UW1V?=
 =?utf-8?B?VzgyYit6OHNqbk52b2tyc2hJOFBPdk9LNEl5djIzTmxQdkhNNDVvUmQyc2JO?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70284d6f-16f1-44c6-e88f-08db94104b34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 10:56:30.7766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGyKk2WvJBE2fKlELQ9ty1z686zLmGPCkAxJwSQOJ8LwqZHHP6Os3S+fSm5TrWmd/W/5fK7uTiReKLF1mEnZ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 18:27, Ryan Roberts wrote:
> On 03/08/2023 10:58, Yin Fengwei wrote:
>>
>>
>> On 8/3/23 17:32, Ryan Roberts wrote:
>>> On 03/08/2023 09:37, Yin Fengwei wrote:
>>>>
>>>>
>>>> On 8/3/23 16:21, Ryan Roberts wrote:
>>>>> On 03/08/2023 09:05, Yin Fengwei wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>>>>>>> the peak memory usage is big-ish, but I'm confident this still captures the
>>>>>>> central tendancy well:
>>>>>>>
>>>>>>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>>>>>>> |:-------------------|------------:|------------:|------------:|:------------|
>>>>>>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>>>>>>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>>>>>>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>>>>>>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>>>>>>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>>>>>>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>>>>>
>>>>>> Here is my test result:
>>>>>>
>>>>>> 		real		user		sys
>>>>>> hink-4k:	 0%		0%		0%
>>>>>> hink-16K:	-3%		0.1%		-18.3%
>>>>>> hink-32K:	-4%		0.2%		-27.2%
>>>>>> hink-64K:	-4%		0.5%		-31.0%
>>>>>> hink-128K:	-4%		0.9%		-33.7%
>>>>>> hink-256K:	-5%		1%		-34.6%
>>>>>>
>>>>>>
>>>>>> I used command: 
>>>>>> /usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig all
>>>>>> to build kernel and collect the real time/user time/kernel time.
>>>>>> /sys/kernel/mm/transparent_hugepage/enabled is "madvise".
>>>>>> Let me know if you have any question about the test.
>>>>>
>>>>> Thanks for doing this! I have a couple of questions:
>>>>>
>>>>>  - how many times did you run each test?
>>>>      Three times for each ANON_FOLIO_MAX_ORDER_UNHINTED. The stddev is quite
>>>>      small like less than %1.
>>>
>>> And out of interest, were you running on bare metal or in VM? And did you reboot
>>> between each run?
>> I run the test on bare metal env. I didn't reboot for every run. But have to reboot
>> for different ANON_FOLIO_MAX_ORDER_UNHINTED size. I do
>>    echo 3 > /proc/sys/vm/drop_caches
>> for everything run after "make mrproper" even after a fresh boot.
>>
>>
>>>
>>>>>
>>>>>  - how did you configure the large page size? (I sent an email out yesterday
>>>>>    saying that I was doing it wrong from my tests, so the 128k and 256k results
>>>>>    for my test set are not valid.
>>>>      I changed the ANON_FOLIO_MAX_ORDER_UNHINTED definition manually every time.
>>>
>>> In that case, I think your results are broken in a similar way to mine. This
>>> code means that order will never be higher than 3 (32K) on x86:
>>>
>>> +		order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
>>> +
>>> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>> +			order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>>
>>> On x86, arch_wants_pte_order() is not implemented and the default returns -1, so
>>> you end up with:
>> I added arch_waits_pte_order() for x86 and gave it a very large number. So the
>> order is decided by ANON_FOLIO_MAX_ORDER_UNHINTED. I suppose my data is valid.
> 
> Ahh great! ok sorry for the noise.
> 
> Given part of the rationale for the experiment was to plot perf against memory
> usage, did you collect any memory numbers?
No. I didn't collect the memory consumption.

Regards
Yin, Fengwei

> 
>>
>>>
>>> 	order = min(PAGE_ALLOC_COSTLY_ORDER, ANON_FOLIO_MAX_ORDER_UNHINTED)
>>>
>>> So your 4k, 16k and 32k results should be valid, but 64k, 128k and 256k results
>>> are actually using 32k, I think? Which is odd because you are getting more
>>> stddev than the < 1% you quoted above? So perhaps this is down to rebooting
>>> (kaslr, or something...?)
>>>
>>> (on arm64, arch_wants_pte_order() returns 4, so my 64k result is also valid).
>>>
>>> As a quick hack to work around this, would you be able to change the code to this:
>>>
>>> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>> +			order = ANON_FOLIO_MAX_ORDER_UNHINTED;
>>>
>>>>
>>>>>
>>>>>  - what does "hink" mean??
>>>>      Sorry for the typo. It should be ANON_FOLIO_MAX_ORDER_UNHINTED.
>>>>
>>>>>
>>>>>>
>>>>>> I also find one strange behavior with this version. It's related with why
>>>>>> I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise".
>>>>>> If it's "never", the large folio is disabled either.
>>>>>> If it's "always", the THP will be active before large folio. So the system is
>>>>>> in the mixed mode. it's not suitable for this test.
>>>>>
>>>>> We had a discussion around this in the THP meeting yesterday. I'm going to write
>>>>> this up propoerly so we can have proper systematic discussion. The tentative
>>>>> conclusion is that MADV_NOHUGEPAGE must continue to mean "do not fault in more
>>>>> than is absolutely necessary". I would assume we need to extend that thinking to
>>>>> the process-wide and system-wide knobs (as is done in the patch), but we didn't
>>>>> explicitly say so in the meeting.
>>>> There are cases that THP is not appreciated because of the latency or memory
>>>> consumption. For these cases, large folio may fill the gap as less latency and
>>>> memory consumption.
>>>>
>>>>
>>>> So if disabling THP means large folio can't be used, we loose the chance to
>>>> benefit those cases with large folio.
>>>
>>> Yes, I appreciate that. But there are also real use cases that expect
>>> MADV_NOHUGEPAGE means "do not fault more than is absolutely necessary" and the
>>> use cases break if that's not obeyed (e.g. live migration w/ qemu). So I think
>>> we need to be conservitive to start. These apps that are explicitly forbidding
>>> THP today, should be updated in the long run to opt-in to large anon folios
>>> using some as-yet undefined control.
>> Fair enough.
>>
>>
>> Regards
>> Yin, Fengwei
>>
>>>
>>>>
>>>>
>>>> Regards
>>>> Yin, Fengwei
>>>>
>>>>>
>>>>> My intention is that if you have requested THP and your vma is big enough for
>>>>> PMD-size then you get that, else you fallback to large anon folios. And if you
>>>>> have neither opted in nor out, then you get large anon folios.
>>>>>
>>>>> We talked about the idea of adding a new knob that let's you set the max order,
>>>>> but that needs a lot more thought.
>>>>>
>>>>> Anyway, as I said, I'll write it up so we can all systematically discuss.
>>>>>
>>>>>>
>>>>>> So if it's "never", large folio is disabled. But why "madvise" enables large
>>>>>> folio unconditionly? Suppose it's only enabled for the VMA range which user
>>>>>> madvise large folio (or THP)?
>>>>>>
>>>>>> Specific for the hink setting, my understand is that we can't choose it only
>>>>>> by this testing. Other workloads may have different behavior with differnt
>>>>>> hink setting.
>>>>>>
>>>>>>
>>>>>> Regards
>>>>>> Yin, Fengwei
>>>>>>
>>>>>
>>>
> 
