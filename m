Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CCC77D6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbjHOX0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbjHOX0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:26:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B206210F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692141961; x=1723677961;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E28ofmg0U8enWw9UlRhRigKV6QOhE7U3hGUtc3CDcWo=;
  b=VUbhscA00McXotFxVp0RoQJptSX5CAFYJ4j+L0PQneW1pLnc4XloGluc
   jlyyFkBZpP4NrZ1i7OM/AIh9h2rsA4wpcTd5iC8CyAD5wZ2YlwS7Z7ppt
   N2O2J43dI7miDwhs3QWObq+mV8s4nbBLzWVDfaPdhwKJPhQ52ojJ7b0Ei
   /k1oYE0T8y8jLY8ROT90B52GjdX32cdOKZGFUSqPtKhD+QH50WlLuvq2H
   QmHA3O0si/5DnrsW6/DHPoI/6sI8kSoB+QLMKa347dOb8fZMvtEVbUIbc
   avhvSxtqhRQ7wEPNNGdHfkEJkzm62OuXRuOedN8lhOp4iE+4hB4jIc6eC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="351985785"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="351985785"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 16:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877539530"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 16:26:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 16:26:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 16:25:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 16:25:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 16:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcrRkG0eiCtyqzZUJR7XRmbSQ1DbIYFBXGkYIeRTIzLyH9KCNu1NV6EeGPGTWtFJudHklv5x5s+n3LusLZn17am6pF5WHCULkhg7b4c4QEQW9o8wcOcaeHqe90zFyjKz4KIdL/HhazEyHeGbnoWNKyXmN9XIjzcw7TRXuWEfjval272NYiK9QC7r6xw+VI1yEIPkQEjCGzIPEnmx/kBg62UGHh2pCZMh32KAPWJ2JnMqNtqKWNCbPC5ryc8YntPnrWGvH7RMh2BblreftexwQGVlZSvmK8HYXNTGQjUsRPsf3JFHZtyabykK6GYVsBvDVtJWSlDsErT4vSb4cXuS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6+5GJuSi4NVgRK6hD/kQEiWYQgg+ljH61IXHzXo3Fg=;
 b=IbZbOp2ogb0YxPlsPGPNob9v1VoaMb7Hnz93D+aOaI9WFiqcPvcztBL5rV70ltRDSYVocnj2IRv1VmobKYtLJgsDQxiCA0ZF6mc3a2obE7ssrg2y004TZak/zwaHM4KLW754e+z4D87lKJhSXWy6QUXZi13Yg+sa1v6jrWBKE6+nWvBivSnR7foCAYNhdm3ZAQWKJ/dqasakhDczTwWS9OES4hz9mN7vjBl941mUSVrEk8ICOnb+mOOGUjCI+IxbGblYGgfOWRkOr5kVFD9Q6IzfFqNrrMwtVKBVHcg8t+0kQfkNRLAYCDuQjTHuIlWvDypquwPSQvftJyB33dTsXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 23:25:53 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::663f:543f:a672:9ec8]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::663f:543f:a672:9ec8%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 23:25:53 +0000
Message-ID: <0a203998-d2de-ab68-fbf0-6f1b2da572a2@intel.com>
Date:   Wed, 16 Aug 2023 07:24:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] zswap: don't warn if none swapcache folio is passed to
 zswap_load
Content-Language: en-US
To:     Chris Li <chrisl@kernel.org>
CC:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <hannes@cmpxchg.org>
References: <20230810095652.3905184-1-fengwei.yin@intel.com>
 <CAOUHufYb2LiZYqhyk7GZ2roUbHUEUf3iKkvmSThHBS21EewHiw@mail.gmail.com>
 <26949c92-95a0-414f-918a-8b8cc11e3e9c@intel.com>
 <CAJD7tkZRjSKrGBhBQmFsc+45TNAcii2QRMwwhnsgP3_3o8Jxug@mail.gmail.com>
 <3732dd16-148d-4ac6-8295-86a12f89365b@intel.com>
 <CAOUHufZWReio1bwzLFeJhi1YVko=kjxcfHo1sS8cfnBZuPaHFQ@mail.gmail.com>
 <CAJD7tka17GHTgu9JZNW8-CCsH2OR67oj31h53oa-oPTTVnkQQQ@mail.gmail.com>
 <CAOUHufYk7ZV=YPk6uGE1+ysgTKRXdwV8T3s7qvEkpGYbGNKwEw@mail.gmail.com>
 <CAJD7tkZoE5is2_pBHs5w7-4Am8HuWdbkBn89OYoHfbRv5rSKsQ@mail.gmail.com>
 <c98b1c02-4a3e-4b69-ad36-e07100a67398@intel.com>
 <ZNuKBfNc8mygBjJf@google.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ZNuKBfNc8mygBjJf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|PH0PR11MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 894b7122-70f7-4111-aa6f-08db9de6f804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+Nqb72Jo39GxSwBSGv8Saim/zl6AJi7mJu7740NIzSfQDVMZdcULKBuqnm9VWaC/rYRRwbRP5TbdsLul1Gtpx1hwQ3RfZLES7XXoCCkO6zb2t07If6UBArM/sGeqsGH8dggTwRWCpxKmUZOzW2J2+mu0C/01iD/UDPY85Lo+w2izS1bfKL+G8b0JqbhP/DpvFgT/UArAmF9WzRjMxDPJxIUwJEd/xQwaevosS8RjIumIaT7oaR6khjPms7sNkT3SpwwuLeLVjdp31nLqn11bKwlBMCHO7Zg9HVnkqWuYiaoijYChzCuubrgVJ36kwJxECQMl2LzGOvjC61C/crDe+jv+5b8/vBpfGs9TOT3hU+GYLB+TrQUtaivUKL16h9XHDQEAaOh3SZvzN68ohO5cB9WSRirnT91WYA+IbcoKxCCPWZ2fPM0Iu4OSTk+OxFl0jmlFyw12+vHvyFen9YzG0fpPXDaF+JfTupZuu+zD3jnw1W3GsxeRtPcYynvgg/oeQqVaBxTl6KtSPL7EzoMaZK126iPoKysqc2t2+KAIc/ds9C+1/UN7qHK0PgC4ufqtlWtggK6y1uBKpLV2WxmPQSpASgsgVF4WwKTJKa4zNJQMOaOCZLUmMRQIcY1WxtFeTzdlcNnlRBdaeKybuoQNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(478600001)(86362001)(6486002)(82960400001)(2616005)(36756003)(31686004)(31696002)(6506007)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(6916009)(4744005)(53546011)(26005)(6666004)(38100700002)(83380400001)(54906003)(4326008)(2906002)(8936002)(8676002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBPK2hjbTROTWErN0tVa3d4eXZMV0V5dkZkVXFBWGJSK3VzS05YU1cwQmJn?=
 =?utf-8?B?Z2pkN3ByU1NrbUI0UWthK3R0NzMxckVZRFdPYTBtK3o5RkVOazFoOEx1aEp0?=
 =?utf-8?B?Um82Rko1WnMwY3BLcGkrSFZvLy95WkZtbk9SaEh2cEoydWhtOFp6cityK1Vu?=
 =?utf-8?B?VmRaNUtkTGpQc0hpRVVOZmplRXhOT1lNM2w2MGMvSGJXOHV6bjlxVUNlN1I2?=
 =?utf-8?B?WVVVM1NhTi8ydmRLM1NnRU1iU3ZVa1ZPeE9tMHpQQjdqOVF4eXpqUWRXelRp?=
 =?utf-8?B?c2RxNEljRXEwT3VyWGhYdHo0Nm1UY29UZmNaVDFRWDhZdGMrbWpSUmdnOFRU?=
 =?utf-8?B?Y2dpcUJab1FmeUY0RW9zSEdqRE42UEdsZXZaSThva3RSS25GSHBrYVhBQmYx?=
 =?utf-8?B?UE5KRmVTaG5vNDlHWFhPRXhvVk94aTNWUkR3TVpxeGF1UmsvaldBcEVReENp?=
 =?utf-8?B?YXByS1NZclNVbk9BbUhkUFlnNnhTdVNhcFhBZFhQOCtJZ1NNZFFGWFU1OEJN?=
 =?utf-8?B?MUg5akoxenhPWkk0QVNRaXNiTlVDNDUxNVdML0M2RDFYMnVPVm0zcE1GUmtl?=
 =?utf-8?B?aXdadjdseEM4a2M0YTlkYjcyUmhLVHJuN01SdjMxRVA5ZUZRdDd4dkEvMUJ0?=
 =?utf-8?B?TTVkZWR0aE9iK215N2k2M1FoRzdpMGg1Kzk2bmljWGZFdDdjdFNQVmdDY2sr?=
 =?utf-8?B?YXB0bHBwUjJqdnNMdy8zeTFEZll0QjhMeGl5OFdhbHM4NC9ycnJUV3AvLzJ1?=
 =?utf-8?B?TTgxaU9QNTlzemRnNjF6aHd5YklST0FXcXR0T3hjdkRnWFlyNXlNMkVQUVlq?=
 =?utf-8?B?SnYyVHhHUldXdEs3WjgwVjVsTTFBZ1lPRGN0V05xd1Zpa0lyUy9mWXdObEJr?=
 =?utf-8?B?QmtqOW5yRkY4Z0NRZWlzVDZFY2RTKzhNVUtkb1QzenpnekpxTzdYc0RFNFFw?=
 =?utf-8?B?YWd0U242aStuVXZNNVAzYVkydy93RnNrMEF1WWZKSktRNUt2WVZDZ0ZDMUJT?=
 =?utf-8?B?VksxbzdYMzJLNFhydjFlbVB0dE5PV3lmRzhiazcvaUJkVGFjRERZVE9sTmRW?=
 =?utf-8?B?Vk5ZVWNYRENMODFUUVo4YWtIK3ZaeFcvSXJqL3Z2MnNGdnZnWnhxVm5PS0FL?=
 =?utf-8?B?NTRJSGlNT0poOXR5czFydDArNTA2UnZvcGs5VHZUYkozazJVYk0xUVJZbXNu?=
 =?utf-8?B?dW53bVlxaWtJOCsxc1lzMTZvYXNxbnF4WXVpWU96VGQ5V2lTYTN6cXluZlBw?=
 =?utf-8?B?VDRqZmdMMW5zcndreU16QkxPZFd3ejN5UURKQUNFN092WDArVTFHVW1OdVlS?=
 =?utf-8?B?M2JTWGhKcUpRdTYyZUFkZjBDdEZkRXBjbWhvNjhSVGZmdlhFRFoyREhRV2Zu?=
 =?utf-8?B?c1IrcTcyM2xJQXhSLzVZZ01semJ1VGNqLzNkcW9PMVVjaDhVWHhWcXNsdXMw?=
 =?utf-8?B?UnlVcjc4UWluelhLYWt5R2ZPSzlhaGROdGZ3K3VFSHhIOEpPQlZ1Z2dZRmkv?=
 =?utf-8?B?Z29XV2N3WSs2VFZEVmpibVFhMVdyd0oyUEFjMnBJYitaSVlzK1hXRXVuWEZz?=
 =?utf-8?B?Y2VwWHZ1Lzd3ZUVGRW1YcGl5Zi9TUmFkelNJbTZzaTFJcUJYNGthdzJVamFY?=
 =?utf-8?B?VDl1QzNIckdEd3VyN3I3aXZQSkdBaHRoc093YmgwcUFtSmkxMFJFRFFUMzlw?=
 =?utf-8?B?eC80OUF0MEV3aFlvZ3lYUzNTYWJPZTNrY0FUcEt2VlVZbm51c2ZOYU5obElF?=
 =?utf-8?B?Uko5UWl2ai93YnJlWmN4M2hZNXFTU3BtUnlROE1nMnoxRHVDVTk2bHFlZ25Z?=
 =?utf-8?B?OSsyckdHV0ZFMndITEd6bEFFMlJaUDQxcXNaYVZCY0thaVNzeFNaNEk0TG5Y?=
 =?utf-8?B?cnJoT3lWc01oWkYvV0dDb3pEd0ZiR0doV2NaVGZxYWJlUCtTalFBa3Ivb21y?=
 =?utf-8?B?TmxaaGdsRUNNN3dLK0NtZG5uUVRFT1ZGYkd5ajBKeXhoOGtTRU53bVkrL0Vu?=
 =?utf-8?B?YlpsK1h2SGFQejBMVllFMGVWSnluNkJKZnZPQm5XWGkwczJNSHhDYWVEMkNW?=
 =?utf-8?B?N3dlNWllU3dndkdGQXZ5T3lSaTVieVJzcXVoVi9QN2lZeXRSRmdNbHVWOXds?=
 =?utf-8?B?SVdDVFlGMVF3VW1sTEphTjNGZVl6UVdIZzMwaU83R2UydGRjKzd6WElmeEUx?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894b7122-70f7-4111-aa6f-08db9de6f804
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 23:25:53.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NRaUdorSZZCcMt69gaWRI0djak9azl+6RjcxslHFZqzn4NZKcgkSrj/72fNji7P2KdPZAB2wHqgBEwWeDhu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 22:21, Chris Li wrote:
> Hi Yin,
> 
> On Fri, Aug 11, 2023 at 01:21:21PM +0800, Yin, Fengwei wrote:
>> OK. I will stick to the current patch.
> 
> I think remove that warning is fine.
> 
> Feel free to add:
> 
> Reviewed-by: Chris Li (Google) <chrisl@kernel.org>
Thanks a lot for reviewing.


Regards
Yin, Fengwei

> 
> Chris
> 
