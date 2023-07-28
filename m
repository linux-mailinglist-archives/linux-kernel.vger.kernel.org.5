Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77292766EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbjG1N5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjG1N5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:57:37 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901372D61;
        Fri, 28 Jul 2023 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690552654; x=1722088654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2TmwocSayjWFUfzlzHRRKcTFPEkNFNw4w817ZZ9LCvo=;
  b=JinvEEYDYc+8G1sDTJoMJMn0A8kQejH3q+TM0yOZsvPnh0FnPdNqGSAa
   00qBWs9PEkoRr6FQws5aXs+MIlRNviK8xLU7ONQ5fX6vCPvV6VKGJ2j3R
   /UyVgJTy0k1rSsgP2p+scnvmybicL4L9OcIRrF3hNSw4bHKVTLdXVTYHF
   tuzU+8W1UrVUdkcc6D/NRTryg6ytIlPC9kP5KTiyYanisdZcj08+bHTDD
   wkWJ97albwaFMHUtZBG17RzDopZNJehG5/7N8SrYFMy53CzGfe4akAZz/
   KqhZi1VBuNeaNAfxVNJBENlH65AJYHRrQ5CS00aevl4exKIoFjsp3Lv9+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432408208"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="432408208"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 06:57:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="841315871"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="841315871"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 06:57:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 06:57:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 06:57:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 06:57:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 06:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWyDjQF7T+CYTFRnnlQ0SB3/JbuA34h/b6NJ2ff2INB1a+fjGyrD49EkuY+xqHoelr3Fe5mZToGhQoG9kezUlQtuNLH0SCw8OxDdi9uHRbaI0S4NalHEFOb0mhHiJDtL9EUjGjrOJqz4pJqoyKQmEpv7LKyC0fsF4DioPLM+NLxwEzAVxF845gQEqGk4PjgjPGRHGAWNhsUyqejBRvOxNk7ZgpD91IU3woXHGCmWEPXkonBKzPGf6EqyUH29hBd2sPEo57acZmEXiP8HYS9ygF4w5SWd7BaaCVm4xj4IRoEP+dQSoki+X2fkzKCcc0GYsV8QATER0YfiLy6MaWknXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpSFUJNJKX8WHR8n9k33M/FOjucuVXMMlkhZ8VjSojY=;
 b=BTptQRPzXHu0Xexaw9HBQ9zcouqn0LzoXi/n3MMxUTla0ti8DfqgTBB+JxkVsnEMCJ9yHcHMFeUYb4cRZIoejLkS+4XOAXSRijiAFM2SxKQ0201hqDjGxNr89rGN6KvTfQVAPfA8kiZACOo29L5ZrcagM5CGZbnmohC1CRwuSFJLUpEyespRDkap4Sar9Fdnbi44jOLiJRDhrcDanFPq7FTZRSP2nRy+FAWjtSropLMF62vHslkYJu5Kn/PJcqOIByVcaFbqG5ISr7xYSj05RlUigzP6QL6eWgIKqIGv05N+WNCr0Tn9Qa1y5ya/13Ew5jbXGjiDk2DW4+AGmp+7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB6565.namprd11.prod.outlook.com (2603:10b6:806:250::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 13:57:31 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 13:57:31 +0000
Message-ID: <db90161a-a6c0-2078-1a22-0f629d72c38a@intel.com>
Date:   Fri, 28 Jul 2023 15:55:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 1/9] page_pool: split types and declarations from
 page_pool.h
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-2-aleksander.lobakin@intel.com>
 <fb6330ef-5e74-01a4-a418-0b33748932ff@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <fb6330ef-5e74-01a4-a418-0b33748932ff@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e829c6-f3a9-4d9a-1189-08db8f7295e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVd5+enTujylOLpVAAySna5vSsVUdhr8bm79O2k4jWr1IZwsDR50GaESEsCMZ7PEpH5yNT0nbve+oKCnsdb0K0jZS405atEXyhWP6Iunid/1pWAoU9Z6rKECcfbJ+5nuJv3By4P3rX0TB05qkhhQe0ZE46jdbks2f+MLyMhyQ73+7RxmwddbLXDyKlUe4Ph5/oIPoaBPaN8e/4EhJMaEgEjTxsD95pvj5rg3dVylG7lY7qo987/VQOUFcs4uXUhqkNeciG/d9HgjHgyKVJ5j+865aJcx5JDuUIZDKakKZIHnyXJMHjlX76H9rCdM/2lozTZ3G3n7aCUcK3DFHz0ZWzF4MyqMG2+prP80JlYDnF88doifovmtczrLVoPyZv7RJfdih4G037z6fqkWaBTVPpGYrTHe7y3fZGNslso+21kc5eMHEv4FmdubLG3JEkKtwQY2MaaYPppR0hAeNd7fBelflU21ylr3/AMcxM+bFLu+HBLNGeCmFITU7vH3LWsvoVjEiQ8RBAfqfPl0UGZ1mBFE8v9+Oxz/AeAUsCmYCuUmoT1AIwwAKYC1BbX2HhL2l5RMchQZCJ4Xkyb8pmokwncy62nfJ70GdgbEQGyuTWDHudoXMDZGuDKl3P/0dtTZ6uGweQfbF3uOHPuykdUt7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(86362001)(31696002)(36756003)(31686004)(2906002)(4744005)(478600001)(54906003)(38100700002)(82960400001)(26005)(53546011)(2616005)(186003)(6506007)(41300700001)(8676002)(6666004)(66946007)(6486002)(6512007)(316002)(6916009)(66556008)(66476007)(5660300002)(7416002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlZbzRIZGMzQUhMZ25JRWZqNUViUTNmcUZCZTlYR3ErdWpBYXAyWm4vdUho?=
 =?utf-8?B?eVFyMzVlSGlXZnVTQU9KRjhCVjlmYnJTSDd3OHlNWWEyNDU5eXpRSVBVbTlN?=
 =?utf-8?B?ZXRSajJSNWh2a1FLbU45Z21aOU5idGhod3k2NjNyTXhZc2tPYWpSQ0pxcmlw?=
 =?utf-8?B?cHVJeDlzR255VGNmMDUyVFFhZWw5SWtXMnZoWE55eUJTWnZYUmx2NWxLZHdI?=
 =?utf-8?B?bXRxazFWbEZudE1JZWJrYktsVUFleDZsQ2toNDRyZTVtU2xxMnNKbmZVVmg4?=
 =?utf-8?B?Z1FTa3NZN3p0MDdWNCsxaC82VkFVM1hiWVpWbFJaWTRqRDlmbS9lditZVENR?=
 =?utf-8?B?UVR3c01aQTlSalVURitpTThjeDZDSk81alRpbVYyVG44cVNKYVdtK2YwZkZz?=
 =?utf-8?B?NEswL0JZVVRwSVdhNHEwN3FCeU1hYThrVCs4bGwvdk5DK25PWGV2STZqdnFj?=
 =?utf-8?B?Rnk5em5ldFh3OUVreElnMjhYNzEvVG4yaEVBdkxWbENwM2owdFh0U3U4ZXly?=
 =?utf-8?B?NHd2bUNYbDFpbkpQY29JQWl6R0V2c2ZMbWlPQ0V2WklGVm5lbXc2dFhwVlRB?=
 =?utf-8?B?bGFCL2haNmcrMy9aMWt0ZFNyNWpvQWpuYjRWRnFqa2h0eTRpcUVyZVl6c2dI?=
 =?utf-8?B?M3FQVTZabDZyb3NBTis0K0ZBdmhPZ3NUKzREV1l0R3FyejdhTmV1MUlEbFll?=
 =?utf-8?B?cWlIeXNGM0x4OHpYYk9xVmhxVzd6Y3A2VGZCK1dRNFczQnM1bnE4YWF1L1FH?=
 =?utf-8?B?MTZJdllyR3lEWml4OU1DYzFBN0NDeFhydXZVWDllNkJyYWRTZ1VOQjhqVUZT?=
 =?utf-8?B?aWk1TDFicThwQmUwSGx1bmlmaFNseGVORm5kb1VvZVhXWG1kbXhTWjBWLzRh?=
 =?utf-8?B?dFRaU3JrcFRkQXlMd0E4OWFRQnhrY0xKVWR2TnRBSmMrbHVsZ3VvR2N2RVFQ?=
 =?utf-8?B?UTcrbWp3czJJTFRwNG9aOE11L0psS01yUnpKTHE4TkFKNVdLTDNZWlJ4VnBk?=
 =?utf-8?B?U1N0WGpQalF3L0VQd0tacnVPYkRtckYyNHRVSVMrZFJDS1hRMlpwM2RNakJR?=
 =?utf-8?B?MGd3TVAxczVmQndVRXMwc2ZiQzR1SE90djBScUtVQ20xVzhEOGlsejNEanl5?=
 =?utf-8?B?TTdrYVFKUVlLUVhmTG1tMlUzdDAwa2pnenJaOUh2Vmorb1dsWHdBbHlabUVs?=
 =?utf-8?B?WUs3bjJmamlzaXJicnRWUkFXK3BzamE5NVI5R0tacTllS0x3Y1J1ZDJjaDZU?=
 =?utf-8?B?c293cnhVMThHRXVrZWJjY1F2QTJ5d1h4N0lJazZrYjZldURkRjIrY3ZUOEg4?=
 =?utf-8?B?U0lmUk5TWGZmaWI5Q1M3ZXRwTTZzOGJpVFRocjJ6T0R6bGwwZWJvWHZIYnRj?=
 =?utf-8?B?RTFmQXR3aENlM2I5ZmpEV1JsVVcxSDVGVU9MWEZUYm5ZWTc4QUJpeU5FTE5r?=
 =?utf-8?B?a0tRYzZPci9wT3loUTUyb1Y0bFNQbENxYmJnTXBIOVhiSmZ6amtta1NEUTBt?=
 =?utf-8?B?eTY3VTlRWStqcmphalpmdEFDdVZrTWJYbzFmbXNwN0RYVWZGTU9VcHVVaFBC?=
 =?utf-8?B?dnIyeVVIcjQ4NTVISWdPV3BJWVlzNURadzNCamtCYnlrUVdtQ3NKYUp6N2tQ?=
 =?utf-8?B?YkpUYVd3alg2a3NDUGsvMzZrWU12L081R0JGVTQ3QnNrSmFWOTZ3ZDk3VXM4?=
 =?utf-8?B?TWs5NVdVTitDKzdaREhIRk5tUzFCTC9YM0hIang1dnd0K3RXc2NvdEhocEM2?=
 =?utf-8?B?cnpFYlBiVnpXSjFab0N2MS93aDhZZ2pNdWsrbjVaSEJGTTZ2LzNkdDFLTjBR?=
 =?utf-8?B?ZjBMWlJMZGJPUzdVV1RWSXB1Y1lQeTZSWnRQb1oyY05UclFNSHN4Nml5aytO?=
 =?utf-8?B?dWJaZFg4c3h3UkZFZ1BJWE1wWmZ5cDZnWjJUSDI3UW0vR3cxNVVDd09NQWlp?=
 =?utf-8?B?TGlydDBXaGlDTjdLRGxXRGt2R3BRSVl6MEM3eWpXWlhwQmJPaWpYdjVzMWtZ?=
 =?utf-8?B?eFN0aUFBSVE1dDFKYnJnbTNoQUNFVGZkUW1qQmR3QUpKMUpKbU4wQjdyWENB?=
 =?utf-8?B?N1k0eDJqcjRaclhWRkxlSlNaYVZFQ3B3ellxY1RKSjFmZm1BTHVGLy9MZkth?=
 =?utf-8?B?MU5QNFkwVVRvK05xQko1blpFcElpclVOdnlyZGQ0TjQ3MEo3Mks0ekZBSWM3?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e829c6-f3a9-4d9a-1189-08db8f7295e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 13:57:30.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AojW6bBqDdj505OWm86VuIe1DUq7HubsM0LL9zoN7EX38iraBcDYbEKSh96Nkkqdp2t7KNf2dIK7IGsCPn3R2+7U5sdfMFGoKbzp6nq4wyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6565
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 28 Jul 2023 19:58:01 +0800

> On 2023/7/27 22:43, Alexander Lobakin wrote:
> 
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d0553ad37865..30037d39b82d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16015,8 +16015,7 @@ M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>  L:	netdev@vger.kernel.org
>>  S:	Supported
>>  F:	Documentation/networking/page_pool.rst
>> -F:	include/net/page_pool.h
>> -F:	include/trace/events/page_pool.h
> 
> Is there any reason to remove the above?

Breh, that was accidental >_<

> 
>> +F:	include/net/page_pool/*.h
> 
> It seems more common to use 'include/net/page_pool/' in
> MAINTAINERS.

I see now, looks like it. Will fix ._.

> 
>>  F:	net/core/page_pool.c
>>  

Thanks,
Olek
