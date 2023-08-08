Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB80A7740DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjHHRL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjHHRK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:10:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A6FBD;
        Tue,  8 Aug 2023 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510671; x=1723046671;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eZYgb/gaHj762lcPoShvEXuQLM526lyXaKd8kiUrwi8=;
  b=Uk5l3aQ0/Yco4GlVEM9esAs2RO966FdsNI98zkQdNkT9yPQBMCA24R61
   eonmdcSEiRd1mCCRUz33KalOelmIJ1KBw1U3L0cs7I0/4iW1reSqmdlB7
   7bmlbhv6eJmb2shqWiBe3NjlHdGGErlR1Yzl21chdFTrFvwzU1X73F5H5
   w3L354oe9tHGxKxROjWiotxT8UXI5IYoRTL9SiQDbP/OkLejUqcrHupcd
   IVNt5+U6Mo8i0RSD9huufCR69ZqibOaEXNfW4FT+iuDgKgNlBxzpZBKcJ
   VHBKxSqQ9xolThyvd2muJmUey+y1Hu9st2jqt25VzRWphJ9W1Ay0D/Kwp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368266464"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="368266464"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801322090"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801322090"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 06:16:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:16:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:16:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 06:16:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 06:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0Kei0qe0+djUv9WYj8oMPz7DT/e3Qc17M5tWgW8hLXMwA03/wDKhGgmqaXwAbpmZKEDYvHMuKfZd69zWPDoj1SditVeChMVKLt92HMNcKsib8KxIMpzsv4rEhLn34aSOJbz2waIj/Zw49LruU9aTb6ZDKpePnKQf4i5/zhrczTdcZqcQRvJHgRyN3JlWWHGVgv3Fa+6NMEJpmTW0ruYQ/NBYXKSj+1O/o+L8x6NgdA0/wmLWgoAe47DQnGeZ1GoDO2enKf9gd9JmStGvec6zq9ytbpJ+zeZNbdVXS9yTG++xS9CvJhZ1zcDgdNbppqVTosd85viQLmw/7Fg9R+X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtcW3qcxcxkmUEjdoFgzxptmCE0zAQLKsOUFEwiK8Kg=;
 b=FiBhEK3CAFb6ZyMGkrWOe9oEzPi4o1Hi0HEj27kMI+uIsA6rlnRW7hVJOhH1u6eDH42bbdz4oLjCT95fDF1jBnqNpUnNF69pjC7Fgk975gjB9rfEvRlET6GboVlYBtqRH/J/+b6HbghNNp7OUPUr676YiwjSCauDWI0D5Cx2HNs9isqHqOANoUgZCxA6HkGYSvvzyh10KLhtyV/mwOsSr3hhmODOXgHnt5dqCuHYAmmOWISlC2H2WzYD9cM1OTFGJJ71AbD1hQ/Hm3audJYuhcoU9YXMtvjE2+n2+hMdDn3CsEg9Ic6BFocEgSqSDrpdkUriWlRo+qpaCcb/rekm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB8259.namprd11.prod.outlook.com (2603:10b6:510:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Tue, 8 Aug
 2023 13:16:41 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:16:40 +0000
Message-ID: <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com>
Date:   Tue, 8 Aug 2023 15:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
Content-Language: en-US
To:     Alexander H Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com>
 <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: e457b603-2dfd-43de-29f7-08db9811b40f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2qXX7mGVSVvUpuT7ghIE6d9MO/I1XUlbTnoIlR9SE1JYw3hNrAIUTRA4JIZBQICmJ+wv+45t3dm98wnzOXooM7nmO75Guw9wXkOBQq43+GiHs616ysOaH29kX8fZGkIVdHnsUQg1pvujCRvRFRZmNEcdyoMBYQzkxBRDEmYBQq5yangF5Owaq9WKPMrfBW465lhfd4ShZhlD8Kf699Zhtc2sWEXuXLPEEsAVmdl5G6Ev7E1mt1qa9lgiblxCkS/X3XviseJklw4EkNKrTS9OiZxfi8Dk0XxbXeXjQuk4dEdOFyDZANcbiUmjUf9dnjq6dRRAfvys7Wk6z1aaLkWC8ZNhZMFqOlLt9ib2DzpYInk1dgXLDzqfkoCTCeAzEmYuqGbeen+kKJcxUCKsWm3UHcTDf4WyPXmkdtHmIQssod10784xNfvd4u04ksz58XHXtlxSGwLF/rFmZlrIabSd5pMM9EfAVFNX57xnzkza+w9agS9mrDvnPaOttNKZl1zGx1BaCoos8MJ4ZA+gSGDlQ/ws7gz9xYmyIoESZJDhlfbMmxUVk6GgZnHFFS9VrDOUHza6SYuwhJZXcH6W37EwJatfsGQfg77YMBQaJpnVI9UgJAEq91tvRVJRDWz0Slbv5oQB9CJ0IV4TtWBlL5FAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(1800799003)(186006)(2616005)(86362001)(6486002)(31696002)(82960400001)(478600001)(6512007)(26005)(6506007)(36756003)(41300700001)(316002)(5660300002)(7416002)(54906003)(8676002)(2906002)(4326008)(6916009)(38100700002)(66556008)(66476007)(66946007)(8936002)(6666004)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2dCVlhTSmN3L2NuTUJWVXJXU0ludU51SDRJNTFqUm44UG5NMS9nMTVIZ0hG?=
 =?utf-8?B?Q2VQc3YxamVnRjFidkVqNy9nL1RFNUxyOXRwQnJUUXdQanM1dHVsblFVTVBQ?=
 =?utf-8?B?WnBiQTJwS2owU2xRSXdhZkdHemxKZHUvSXZqazRTcnBMR2g0K21BTnI5THBF?=
 =?utf-8?B?eVFwakkrTWs2UW5tRXFzMUNYaWFocy9jNmFMZkNEcUJTWW9DMGozNEdIbysx?=
 =?utf-8?B?bnRVdUFSamRlV2xwSmdTUnVBUTh3UUhMdWFHQ2hsWWVUOGprTmJBSE9rZDEy?=
 =?utf-8?B?UDVGblJ4ZkRaQ0QrVjg3OGVrbWdoZzV5R1IwbVN1T2lKQU90M2RoUnZ5Qk9y?=
 =?utf-8?B?RTJ6K2lXdkhDTThCbDhpZGlTTVBodmJWaHRTVzBCNHdZMk1xa1hIN0FOZWNk?=
 =?utf-8?B?TVFHRW42TEp6bVRXT0VhK29oTVljZG9OVGpqeHVRNW83aUlubnpNdGdnNXEy?=
 =?utf-8?B?bG51eEtOZnNwdWNpZ3NzdUNVTkNBa1pjb2NzclRiUWNoMk96RmdneTVLQ0lW?=
 =?utf-8?B?SlJadnpMYSt3SkQ5Ni9ncVlmamlwQW9RQXRSOXNSLzR6eEFRUWtCMlJuZEVm?=
 =?utf-8?B?OU9xUGRwdUVkZXJScnpKS25LemUvVjZOa0E4ZUpqK2p0YVkwTlNiV2FsSnBJ?=
 =?utf-8?B?a09URENWWVp3bEd1b2sxY0JYcnRRaE00S0M3WDNucHNOdE1rcENqOGhFTGd1?=
 =?utf-8?B?SGp0U01xWHdCVFdEdVlzRzJEMlZYbWQxbkk4QTBXUGhzeDdueXlMS3ZMaEJi?=
 =?utf-8?B?eVZTT2tVRG1rNUVCcVJqVmpncWRvR082cmpBZmRmTkNFeXM3dGZvUkdEMkN1?=
 =?utf-8?B?RlVnOHQyZEJuUVhQcVRUbERBMExhRlRPcEtyMXZNcWY5RVdIa1BJa3VoQ20w?=
 =?utf-8?B?NWo4dE9PVVlKWW45c3k0OUExamMwNytwcjlqc1ZLelVsUWcvWS8xSHBwSWt4?=
 =?utf-8?B?SGZLS2xsYkJwVmNCelJMWGZtNDZQTWNQUzJ0WGZvam4ybFJTaThuVjBzYm5Q?=
 =?utf-8?B?SCtFbHFYMGppN2lXYXRRL2hnRGlIWlJJTjNLWHJqWjB3eUEyVkQvQ3ExQm41?=
 =?utf-8?B?VEVGeFhPRFFkZU4zMVllMVNmcGpsUE9NODZWeHZ0RGo3UFViSlFHV09LUGhO?=
 =?utf-8?B?MjRaanRmb2NiekF3SGROeFBySWlUaTdlbmJTKzBQSjNMQ2krbXc4TFRjME1Z?=
 =?utf-8?B?SWJhbHNkcmEwTFFyOGI3b1RRbmpoTUc3RXUrNWZYNnc1b3p4aHljWXUwU3Fj?=
 =?utf-8?B?MUsvR0FINnZHR3dDMmU2TWlVcUZYMlhTb2k0cWltNk5Wd09LOHdDZTJUNGxD?=
 =?utf-8?B?dTZ1MnpTYTJ0K2tpSWh3aWRmMmNHTjZ0SURreFdxdjhFQUgvN1E2ZEdyUUM2?=
 =?utf-8?B?NzI3MEpTdGc4U1RFbXZTenJkTWRaeWdVdnpOUmNUZmFiZTVuRXU5SGp1R2Yw?=
 =?utf-8?B?S3E1Nk52dzhCWHZSdUhFN0d1U2Q5dlhGdTBTNldTOVRGeWx6YnI4SlhVVklD?=
 =?utf-8?B?T2NsWmJSZW96NjBSb1VQb3R1ajZrdG15czR0Y3RJclQ0RDRPejN0dUlVZHZY?=
 =?utf-8?B?cXQrM2paMllVcnExMk10aWlQOWxkZGovTjE3cUt6YnRhZVlJNzRYcFNZRFpF?=
 =?utf-8?B?ZmN0YzNRMXlwWHQyRXdzak1CcDNxMWx0a2FvYmwzTWlZaXRXMU56Qm9PUm9z?=
 =?utf-8?B?TXczZzQwSVJYd0dMazd1SzhIUlNTNE1XQW5lZGNoNWhIdHRNU2VKZWErTGpl?=
 =?utf-8?B?RXFKSWFmeDZmY0d1SERGYkZscThCdmNOZncwaWdEMmdHa0VGZktyRStreXha?=
 =?utf-8?B?dldVd08wT1o0eXFLajNrdmlqbmo1WDR4Z1FiY3NwRitsTkI5WlFYSEVxT2M1?=
 =?utf-8?B?RzZoQ09GV2w1emtuVEdocmY1RExtNGIyYWpJOTAza0xRaXQwd2Y2azNFenFm?=
 =?utf-8?B?WGp1bzRpSExVM2lmQ0NLa2tQRCtENnNPcHRCNVJMd2F4Y3JFZXhLU2xYbXkv?=
 =?utf-8?B?WGFEbXBFekQ4blU1UzE4U0NFUjVzNUpjQ3h1TjBZWFdnaEpmN0NTRVJid2xO?=
 =?utf-8?B?UStoSFN2dGR6Y05mMkxHU2NueG95enZRWGR1TGF2NERKYnd2WDQrS2h2Wngv?=
 =?utf-8?B?dlpRSFh5d0w0REtsaVUvb2NBOVZtbXhJTkRBNjJHNG9uSHdBOGQrUHBNbWd4?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e457b603-2dfd-43de-29f7-08db9811b40f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:16:40.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzaGlm+dpv1eYaGjJP3jSmoJ1n7KzTrzgkAW6ggfcrxdjLAuJr4qEFHlQcYVGXW3aftTJ08sE0Ll4lXoigTmmPgf8Q/HC7XZuy/gkkHWjlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander H Duyck <alexander.duyck@gmail.com>
Date: Mon, 07 Aug 2023 07:48:54 -0700

> On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> Page pool use in hardirq is prohibited, add debug checks
>> to catch misuses. IIRC we previously discussed using
>> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
>> that people will have DEBUG_NET enabled in perf testing.
>> I don't think anyone enables lockdep in perf testing,
>> so use lockdep to avoid pushback and arguing :)
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/linux/lockdep.h | 7 +++++++
>>  net/core/page_pool.c    | 2 ++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
>> index 310f85903c91..dc2844b071c2 100644
>> --- a/include/linux/lockdep.h
>> +++ b/include/linux/lockdep.h
>> @@ -625,6 +625,12 @@ do {									\
>>  	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
>>  } while (0)
>>  
>> +#define lockdep_assert_no_hardirq()					\
>> +do {									\
>> +	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
>> +					   !this_cpu_read(hardirqs_enabled))); \
>> +} while (0)
>> +
>>  #define lockdep_assert_preemption_enabled()				\
>>  do {									\
>>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
>> @@ -659,6 +665,7 @@ do {									\
>>  # define lockdep_assert_irqs_enabled() do { } while (0)
>>  # define lockdep_assert_irqs_disabled() do { } while (0)
>>  # define lockdep_assert_in_irq() do { } while (0)
>> +# define lockdep_assert_no_hardirq() do { } while (0)
>>  
>>  # define lockdep_assert_preemption_enabled() do { } while (0)
>>  # define lockdep_assert_preemption_disabled() do { } while (0)
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 03ad74d25959..77cb75e63aca 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -587,6 +587,8 @@ static __always_inline struct page *
>>  __page_pool_put_page(struct page_pool *pool, struct page *page,
>>  		     unsigned int dma_sync_size, bool allow_direct)
>>  {
>> +	lockdep_assert_no_hardirq();
>> +
>>  	/* This allocator is optimized for the XDP mode that uses
>>  	 * one-frame-per-page, but have fallbacks that act like the
>>  	 * regular page allocator APIs.
> 
> So two points.
> 
> First could we look at moving this inside the if statement just before
> we return the page, as there isn't a risk until we get into that path
> of needing a lock.
> 
> Secondly rather than returning an error is there any reason why we
> couldn't just look at not returning page and instead just drop into the
> release path which wouldn't take the locks in the first place? Either

That is exception path to quickly catch broken drivers and fix them, why
bother? It's not something we have to live with.

> that or I would even be good with some combination of the two where we
> threw a warning, but still just dropped the page so we reduce our risk
> further of actually locking things up.

Thanks,
Olek
