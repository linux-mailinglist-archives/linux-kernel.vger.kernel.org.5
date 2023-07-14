Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49DD753D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjGNOTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjGNOT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:19:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0C3595;
        Fri, 14 Jul 2023 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689344336; x=1720880336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oVNQUmnkozGnxivUEeB9qZV+0JgSQLIPEvKFNDn91xU=;
  b=KR6FSWKsNK1UKkMEBTCsfITrt5kdrbwiP1fESKBdHnSCn4kL0wTzjYy7
   NfF7DmPLTJSX+oXTFnuJmUW2IMgikpnT6cR13+6RDT1w4l8oViYSrSdeZ
   INU1b/EsEwE6iVo6LibitlSDDNZtKZsg2+jOAw2XiGe0xKv5hlYzoUKMs
   6ig3rXIajnDR6gzZ7AQSLB9ujjmwnAGBz8n9Ty6/HQ03t2DgQQ0LiH3v1
   6ivIjKsaDSeB7/atznzFpz5gVcf1P3Rrx47u+tjio3yrq7YW5JKUDbigD
   oXd+IY94etf4cklR0afqL5+vvgO4fwDYyUP3yXS6rgyf/DX+ajAtpf2+B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345080530"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="345080530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 07:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="969038399"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="969038399"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2023 07:18:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 07:18:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCRurBNDiEMLAMm8ErEb+PUsKkyuXN77DFl8bOQ9BMJoA2ADo6p+f5O2lbqS/iGX6Qv6M+qIqn3VDgmX2ZDQZr9J9T5cSxT/R4SPwibDCIPgoTquelgBMTpYezlDeiSKfzeitkgcZA2GnPYWSI8NZ6jNZj30J9d82Pi6Bl8DDJSUjDUh7yvvSlYNP2izhg6Ocqjdmmzg3hzIJpqa1Tq94LUUzciiP+jNuVyHM5k99Wcaz9hZItEpgt3WvX70Jfcbmzx2Q+J4+EiIWxbfmSwwTJtE15AOP4+SQUnXHP8DdAFdT2UEC8lNfJeX/7bhlWyU5kAgNyT81+OoSOM/KJ9d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cdik+XwK6pV1Wa7/G4iJyAy1pxFWtAxKgwLSrdtKVc=;
 b=LnVkLqJHVJfccNPbXSyGWE7jHuT82v+5QxAq/Fyks83XKJtCYHOiFb6FcI7iyhs+K863KfVupBHaSu5KK9BiLe3WettY/2jb6YYLmc9K/ZqqfJlRQFV51V3ZLSa0TY8ZQoD0Cj31tYu+Rd3C3fhd7oWAdE8s6xnMMt1yBrkrqL2SB3KDmiNRjrLu9c89hoJKRa24OC/EBtmJ/QHB1lfs3U6H6LriGnbakRvTugt/QJjJnP660NjY7Wk2PsxaqeTUG0UujG10eKqId2FChRC1QZeGsftS4BpBhGvoYiQB3oSnzuLZzq0liWMczr/xVHWQXlc8LRjFXEzYQEPNPyBHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 14:18:09 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::6cba:7ffb:4681:a38b]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::6cba:7ffb:4681:a38b%2]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 14:18:09 +0000
Message-ID: <f1511443-c220-1012-c6b3-595285ec338c@intel.com>
Date:   Fri, 14 Jul 2023 16:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 1/9] net: intel:
 introduce Intel Ethernet common library
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        "David Christensen" <drc@linux.vnet.ibm.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-2-aleksander.lobakin@intel.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230705155551.1317583-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d70035-a835-456c-cb45-08db847525e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5MBr161JIgQr+2IibChe6ew/6XNAObnGMOAAevmDIk2h2tS284qagKBIqNfSoz3qrGTDT3lJbVrwuVDOCUmHlNLtHXqVjeOjjd7ARSPM58TJ4EoxW1KrWk188MOsxWhirgOvo+ae6W3HLMLKDY+JO+ESpdZu4YEf9m2PghUajTHoRaouFGxHCxOZvurh1ZjtE2fdrTcfCs3Y0SJX/91XvUvEPJN0p1SJjIGNUNFjVVLfjv6PAIZiLZ5GEpYnkbLRcKKoH1Cd/pFX54jq9c6LehSpGs2ClmOJLoiPvZktR3pWzzckq9/IwD0HMWZXmU/WSqjeqNLXkff5QafnhujHT4BrKQbCIyfIShwrZKcAd0xa/dvXKFOO+K190b2jUJPXYp5ZoOja3SdEiInOx6gy5W77HHvojFQmoZjUD0kCHJojOZU2v6KYXu8Iv7jTq6V2SLycUF6/R6C2Wszvjgu9SmFPx2MAoIpA2WXBA00Q7V3Po/gG3vMlnnB6giVBZJByPUvNeY3KjpkLIe1GneDShtGRo06DhRz2TcHkHChTRy0XmF21XqEVNhvlXTnuaw0jAN9Wf7WFbWQ8T60hke1Qd7B1GcnnA27luZjZNl8YQb70rl03ozoiCHLcKONH5RpAlLCJt4I81qhXLGeiihanA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(316002)(41300700001)(5660300002)(82960400001)(38100700002)(8676002)(8936002)(7416002)(86362001)(31696002)(36756003)(2906002)(6486002)(6666004)(6512007)(478600001)(2616005)(83380400001)(186003)(26005)(6506007)(53546011)(31686004)(4326008)(66556008)(66476007)(66946007)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9sYUZVanVGUXlibDhXUXpaVUFobkRML0RvM2kzREp0RHVFR3BzcHFKRk5Q?=
 =?utf-8?B?eUthWktrT1NiZ2RjaEROMXdaYU9KL2ZSSTNIQmw1aDVmNkovMzFXMzVoSWs3?=
 =?utf-8?B?TFMrbG9PaEhDUmhCd2piQmwxYkpPckpzbzZVTUdwd1VOQlA1QWoxUTlocy9r?=
 =?utf-8?B?MlNSaFJvb2ZYOVRpOWZLNGRpa0FBOWJpSjF0blJyUHh6VFBoZmx4d1oyZmky?=
 =?utf-8?B?QTNzR1pVVWEvREh2VHUvdHZ4ZWhMNmFMUUR6ZXMzM214VFdvSzFqZHVYWS9N?=
 =?utf-8?B?MUJjNWhaRVgzT0RucmZrc1FpWWhSSHd3MWpkV1JqOERFYXNWcVlyQjZzU1Vj?=
 =?utf-8?B?TGNCMDR0eERSYVZBYzdvMzZlZWhmbDlRNjBpbUhvREpkcE5rV1BaazZsUnhT?=
 =?utf-8?B?aVJYQWh5VXIrWDVnTWowN2lMWklLNzBNbGJoS1VXQmpMOEl6N0RaWkErSCtP?=
 =?utf-8?B?MC9TUjVWaXlRbXE2bWpjeEdNbkYwaG9aRW5saDhDVEp1UjNzVG4yV1BPa2hG?=
 =?utf-8?B?NjhYR0lpMVhUejZrSjk0c1ZwaGdUbkh4NlRSN2RoSFdLTTRrSFExSnNEenhQ?=
 =?utf-8?B?Yk9vZUllOXpwbVR5S2dCOEVjSDVtc3VDRXhuVXl6M0syalptMU9FUk83Vk9E?=
 =?utf-8?B?eFNFanZPU3NKRm9mdjVVejhhYWlCbmdESi9lMTRGTWxzVEZnZGxhVG5ZMkJw?=
 =?utf-8?B?TjdoY3VDdFo0bHpXeWl6VDZyOFRUdW9sMHFoQXZsSlExdTBGakQxYm1GRVlm?=
 =?utf-8?B?VWptaFY5ZkRjL3U2aDd3ZVRmS2RBbXlBbktTWVdFeW1sajAzbzY2eTY1L2tX?=
 =?utf-8?B?SHFWVkxHMURZTWgvcmFra3NYSUFuSVh6eU8wZ2RONEdYaUFPTkJJUHpRQjNR?=
 =?utf-8?B?M0IwY1pTMlBCK1ljMEhjUVJGQzB4VmZoWHRSNm5QbitKWDF5dFZOQzlYSHRW?=
 =?utf-8?B?SzFDbGlVU2RwOTVZNUVPU0RMWmtsaGpXTlp5M0pLblA3alBua2NRb0wyMUdC?=
 =?utf-8?B?bWcyaXErNDMxVUdReXgyS2Y5SlNGQmU3Y3lqTnZ3WGZUVzhXWmdhWXJ0dE5w?=
 =?utf-8?B?Zkgva0IxcGZpVUZXTTJudGU0RyswQXFuRWI4RkxMWDljeHhoRURyVTBkWlFN?=
 =?utf-8?B?TzkwSEdyM3ZRVlk2UHBTanpOL1BNSUtZWElvU085R0U0TnBwdnNSUlgxV2Jy?=
 =?utf-8?B?bDhYUlpLNUUxcXJDYVRwNGdodFZ6Z1F3Wkk0YlQ2SDA1QlFtTDdMcEhuYmtm?=
 =?utf-8?B?RUhkVFYraTlmc3c2bVdubno0d2pqUWlwS2FKZlZJRGppdjJXd2tzV2FMd3Bl?=
 =?utf-8?B?K3hMYlRKUXZEVDVnb3FOVDZhSlZSYkJrWEpPOTVlUG16SnJjM1dpdWtQMk0r?=
 =?utf-8?B?YlJHWGJ5blpVQTBWOHV5VDdRdGM2NzVXaklMTUFtNlFpZ2N2dzU2a2tHNlIz?=
 =?utf-8?B?cTE4aDRyc2JNMzhpbEY5VVlhQ2RXeG5mclpYYjJnUG9COGVTTForVStxMkxz?=
 =?utf-8?B?VDNrK2ZPUytLNnh2NFZ4QWNyaVk2Rjh1eHQzcDBCM1BNejJjcFhqWXczTVBj?=
 =?utf-8?B?OWVZZHFlSWFjNkhmK3YwYUtwcEg4SDBvOTlQTWxJcXZqUnE5VFVYbzA5SDRv?=
 =?utf-8?B?ZWlwMlFhVWhYOUsyZmFSOFJ5akNZeDZsVTN5TFBUbzZtelgzdFd1NmpqVFBZ?=
 =?utf-8?B?cERaenFieXQ0YWQ1OTNMMWhUUHJSVmtPZWVKcCtQWE5ZZ1lQMmlZUTlMQ2x3?=
 =?utf-8?B?VVJHenpaSXMvblhvbHorTjZYZ21kR0o4bUtzNm9JQWFpRTZ2Y1psOWEvdXJE?=
 =?utf-8?B?RUFQL3BhaFJ3RFhLOUs3VjcvZHN4V2k3Z00rMlRKTE1xZWpUL3BkVVBxS00w?=
 =?utf-8?B?OHJPVVh2bWsvVDJFUUlKY1VxWGxHQlFTemVSK0M0bHhDTzU3Lzl1MzVxLzgr?=
 =?utf-8?B?SzI1RWhydkFIaS85ZG1jZ1dwS3BsWXZRS0VhN05heEVnZEV0MnJ6aGR4VFRh?=
 =?utf-8?B?U0t3UlY0V0hwWkJBaEU0K3RuTHFobXIyZjJueUdlYW0wNlFpbEVQSnlFUWFS?=
 =?utf-8?B?b28rTjlDSmRNaEFTSSs3UnlIVEhIaWlTUW9qRXNYQ1MrUzNPL3BkSzM2OUlX?=
 =?utf-8?B?N0J5NUh0OWJDUXhKa3NKenNGTmpaTEx2OEFQREcwRE9zK2hMc1BSVnZnMDhS?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d70035-a835-456c-cb45-08db847525e8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 14:18:08.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n9eS4MswLbKRDczEnFE9/uPdQY4LCkeH80wti2WwXn7K/93mtuKJeS/ncqqi/xZoJC3AnOuIOZnTL2l2uH5R2hl0UDzbUVNMqebjlBSNco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 17:55, Alexander Lobakin wrote:
> Not a secret there's a ton of code duplication between two and more Intel
> ethernet modules.
> Before introducing new changes, which would need to be copied over again,
> start decoupling the already existing duplicate functionality into a new
> module, which will be shared between several Intel Ethernet drivers.
> Add the lookup table which converts 8/10-bit hardware packet type into
> a parsed bitfield structure for easy checking packet format parameters,
> such as payload level, IP version, etc. This is currently used by i40e,
> ice and iavf and it's all the same in all three drivers.
> The only difference introduced in this implementation is that instead of
> defining a 256 (or 1024 in case of ice) element array, add unlikely()
> condition to limit the input to 154 (current maximum non-reserved packet
> type). There's no reason to waste 600 (or even 3600) bytes only to not
> hurt very unlikely exception packets.
> The hash computation function now takes payload level directly as a
> pkt_hash_type. There's a couple cases when non-IP ptypes are marked as
> L3 payload and in the previous versions their hash level would be 2, not
> 3. But skb_set_hash() only sees difference between L4 and non-L4, thus
> this won't change anything at all.
> The module is behind the hidden Kconfig symbol, which the drivers will
> select when needed. The exports are behind 'LIBIE' namespace to limit
> the scope of the functions.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   MAINTAINERS                                   |   3 +-
>   drivers/net/ethernet/intel/Kconfig            |  10 +
>   drivers/net/ethernet/intel/Makefile           |   1 +
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 253 --------------
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 +
>   .../net/ethernet/intel/i40e/i40e_prototype.h  |   7 -
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  74 +---
>   drivers/net/ethernet/intel/i40e/i40e_type.h   |  88 -----
>   drivers/net/ethernet/intel/iavf/iavf_common.c | 253 --------------
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |   1 +
>   .../net/ethernet/intel/iavf/iavf_prototype.h  |   7 -
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  70 +---
>   drivers/net/ethernet/intel/iavf/iavf_type.h   |  88 -----
>   .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 316 ------------------
>   drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
>   drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  74 +---
>   drivers/net/ethernet/intel/libie/Makefile     |   6 +
>   drivers/net/ethernet/intel/libie/rx.c         | 110 ++++++
>   include/linux/net/intel/libie/rx.h            | 128 +++++++
>   19 files changed, 312 insertions(+), 1179 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/libie/Makefile
>   create mode 100644 drivers/net/ethernet/intel/libie/rx.c
>   create mode 100644 include/linux/net/intel/libie/rx.h


Thanks a lot for whole effort on this series, it's refreshing to see a 
move in that direction.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

