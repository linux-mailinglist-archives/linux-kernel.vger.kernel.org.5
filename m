Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D040E7FA252
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjK0ORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjK0ORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:17:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DB259FF;
        Mon, 27 Nov 2023 06:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701094132; x=1732630132;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TvUtAm8rJxJMc5YnCuAFzmHJYOcg1xCB0fCtJzI1TwA=;
  b=gvckCwmtrdjRl7hbhVwxHlkU3+byvkuAKdaqVfCEdtdQbPB5ZX8DIsPp
   FvkmZCUju8xiApqPAYrqTKqQdKq+PviiXFb6h/bHr3r0ukK7SQ/pL53DM
   eD8SC/nRQflQ2qXpWXMr45N3GZ366jm/LbcF0KqDLiI2zuPLBsGh8Bbmz
   HFfEiOXhDWC26pKHNQyySWdv3EU05qup6Q/WqiPtTthQ/JrLghf83G7ML
   oQQ8kdyM3kLlw2SuUqqVdgUSYP7qWveEp7O/PQpEbpXTSt4iaITBjyAol
   Hv6ZR2TSVAY/rXlCTKg45xydF+m17ilINtvekRxDkTCsrQ4DLBHcbNY4V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391587210"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="391587210"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 06:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="16297284"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 06:08:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 06:08:38 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 06:08:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 06:08:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 06:08:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3gKloD2udnFh9xyMNtfs+d/SdordmgCuF9Br55BodTp0zb0gkWnWu9fqZqb2XNrO2FLFKEae+Us0NRyGCEoT69qtAK8jCL7K6rTvOCrmxrrWD+zcJW8g/dE29d98QV8+0XnNfBZXhQFrPNEzGL50tsm1eY/KYJ6oFk1nhhFx9sIL9LMxQCRFcP+cOotyHcXNgIw5gwhXE0zdAG9oewQj8S66/ssycgBU0/WZRQEQBnWhvRFMMQ7yno4teitvBd5GZUmdu8BXWcxqp+GIV4pVvow1KAVfFfzo6z8l97fofYtTDKir+9JLgLr4YP7/Te/jUaDZTG74NowkabYc0jVOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwlE/ORpTc1Grdkfh61Dxagc8D5P5tWpuW1ImBs31ZI=;
 b=h1IS+5i4nZt86cIB5Oc+6LvBFro1XWZ0gAJWvqsgSZN3VP3qnw+h2YzmFq+rvqaF8JoBidUtuG7/aLLP73MRQnYy4ZrzR1VB3SvtG/PQN1P6auJz3JGgDHx4KucilgYZSS/RpUqLvEjS9kLyJxc1daTkqKat7R6Tb1mNG0oVItSC+gevh8Rlc4zwgZ0RjQhs9gdsnb8AXzBRT4RiPnikw6X4TZpWarYKZnCVVHURfu/BxrMihfJ6aQ5v9pho8+H+mAdzRFJTRGEhb5ZkHQjCN29WgpHgKaE8d8EyqmDXM0dRdXFlaxycyiPxxR4UVLwNcqRuc82aa0IpUiPYqa3TGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO6PR11MB5570.namprd11.prod.outlook.com (2603:10b6:303:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 14:08:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:08:35 +0000
Message-ID: <5e6859d3-d3e7-44c1-acee-2c4ec568615d@intel.com>
Date:   Mon, 27 Nov 2023 15:08:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 01/14] page_pool: make sure frag API fields
 don't span between cachelines
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-2-aleksander.lobakin@intel.com>
 <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <9902d1c4-5e51-551a-3b66-c078c217c5ad@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO6PR11MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4d57c9-b2ec-4d14-cd18-08dbef525891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISdKQiBszRMsX8rdbNZLmQYSZ5xOQ2ovnVAJWKNm++oTfXAxEyQnOYcjB+IcOlPMmmxGrjZgsUcxKbX1/xlu2lCXviVl40qIokfox3Nza/44u7UQTjo8K8PSDin6ew2jBMDcalsK1TJgwEiKyxdX56pH6zFfE+aYL1Kmpss5qF+V/Xrj08EcDDFY33p8N3NphNFOuZj8KbbDxOtKQGJhwUDQRSopsjC9/KTWF1cE1/pcTA1lBGJfLhSWrWLqDG++ZJovFQoHEEw1Q6UAjtecbh3qHuznvKYqtZplA3A7bClVlL66Q+kGIDoZFNLEksPz+03Xinc4iEtngcsCY6k94cS8uxTDwHrLp9J9n85xG+la8EtObnv30DEMQq2p4BUS2FNuRhi0hTeewu6TW2vwTUEYGKe22EYOOeWZ0VtJ3KiG4FSEeYAftkPJ/51YjTl1FgIVRt2FEUVvzISD+l5wATAiT593C06zIPyv3SfiYzAInQtsR8aVlT65rwOQFvirjvjdAHVo8NYqMH3q3aArQNSKIKYo4xiWFY2cFk3LGYcnnpHjySoKCX5r8sLY2U0wkKHoLYrPCjZiI5JFIuuBf74GbBMlFtVLCjNRyvTA+oH9E0yCi9Ck3ZhNkypa206rMpT4lpxusdfViNJPmwjGQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(4326008)(31696002)(8936002)(8676002)(6512007)(53546011)(6506007)(6916009)(54906003)(66946007)(66556008)(66476007)(316002)(6486002)(478600001)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(2906002)(2616005)(83380400001)(5660300002)(82960400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG04Si9TdUZhVjZua1hXanNpdG9ZL2ROaThxUVNnQlJhVmlUQkNXVE83aXEv?=
 =?utf-8?B?a3I2UjFhMHNDSTFFYnY5ZnAxZHhCUFo0dDVHVVFldWdCMHN3NUw1MG80T3hD?=
 =?utf-8?B?cE9RSmlxTlM0R09kM2w1YlFUblNlUWFLeFlkV1hITWk1OHJ0RmpvZDQ2QXlX?=
 =?utf-8?B?eXNFMUcxNHpJNGJERzg0OGpkT2k0U2l3T3RsV3hZcUs0SWxQV2o1ZTVLbHAr?=
 =?utf-8?B?dXpVSzFhbitqcERRbFpNOVBoUFNTSFo0ZW1leTk2Z09pWG1OZlhlRjFPZkJH?=
 =?utf-8?B?Y25SV0lsWHdKcnc3MUxPT3V4ZDNnK0ZRQmJXVUFRNDBFdVJ3UkZ2NnJUS3Vk?=
 =?utf-8?B?T3E0VUs3SUhITWVCaytyNGMzdlNkaVRwZHYrRkljSno2UlgrR1NRampNYStW?=
 =?utf-8?B?dHJ1TFVKR1dzMkt2UEdnQXdpNkR0d0I1dlZWdkxTVE4xbWxGVzZRNW85VE1u?=
 =?utf-8?B?TFVxWmlXK0hvUjBUdnBlZXdBTTBvZTF5eGNJWFpmR0NrN1Q3eGwrQm81MEdu?=
 =?utf-8?B?ZThPdVVjY2Z4MVcrUzI1eldBTFlzOTlDek5TdVNVb01NK1hkTnRqL3BjVktK?=
 =?utf-8?B?ck91WUlOMTFnYTgwc1c5dGlON3Y3aXFyUlVjYnc3VGhhaXNmZyt2ZUFsSlJ4?=
 =?utf-8?B?NjJKZHkyVFRQL2hxczBCYTJDSm45elcxc3NzZDR6NlFlOHRpRXBLK2xBaUg2?=
 =?utf-8?B?c2ZyVlI4TjNjcGNVSE9xS2h6ejlvOGJONmVtamUraVZMbGczMXJXV2Vjb3VD?=
 =?utf-8?B?dStuT3YxUXFQS2VSaGVqRjMxVE8xZzIxQm1UUlQwZUsyU05nZVdaOUhOOGZJ?=
 =?utf-8?B?cEtkQ2lmOFNlZFQyVzJxV29ZTHNDVmNFczlpNjNDWGZDc0U3eDNpMkd6Y1k0?=
 =?utf-8?B?ckpZZlEzbzFlcmdxS1owVm9WekVPbFFIbHZrcU5QVjBpTVBydERhbXJGbFJO?=
 =?utf-8?B?dGtCdk51cU41KzBSUmZNWWNGdXdycVNHc0RwdzRjZ3lUdEowWldTUDVyeWVq?=
 =?utf-8?B?dzd1citIM1VvTzRCZ0pONmd4eTRJbHNjYXBPVGZsSkdINlk0N0xRUXRONHhO?=
 =?utf-8?B?a0dJeVZGU0xBeEswNjlOQTJ2M25HN2dtclpSUG9EanhpbVpLUU44NGZTbDUz?=
 =?utf-8?B?NXJQcTF2VTRNL0lScTJXaXNNVzB3WHRkR2g0WHBxb2hBN3JzcjNHdGdWUHRO?=
 =?utf-8?B?d1ZEMU8wSjNxamVqVGRqZXIvamtVVVNvMUkyWGNJdXlVNUd2NmdQSEhTc2Fy?=
 =?utf-8?B?KzE5amdXeHk5TGJnMFphbDJiaCtra2U3UmV2dkxNQytoSmx6aVE5VzgwMVRr?=
 =?utf-8?B?VjFEbnpZRncwWGdMZHdNd2FjTmdpLzh1Mld0alZBMlB0b0FKUmVIYUM1S1gx?=
 =?utf-8?B?VytheitNV0NLdmxKOFFGaFF1Wlp2Rm5GQU1XbU5GU3VsMVdRZldEV3dBaFRG?=
 =?utf-8?B?T1h1VFN1bDZvL2xiRHl1azVxSldIc0FCWWFHYzloSkJFOHZrMEYvTmJuMjcr?=
 =?utf-8?B?UmlIeFRuTGNiMmhNQ2pOOFhZUVg1VjZQOE9Zdjc0MnFtUGdkRStQWjlPRDhj?=
 =?utf-8?B?S2U4T0RtU0dzY2c3NmlxbGNHNUZic3R2NXBiN0hPTENpV3BhcUdGTmVJVDgy?=
 =?utf-8?B?M3p3K3M0K1kvL1RxRG42RVl3NkNvWDNnWk4zZitIblFhVUpabHpMTUlwa0Ev?=
 =?utf-8?B?dFhiQlYxUzNrRkRSRDlyUFRpdUNjMVphT0hPVTZySERSalo0MTM1UENSdnFN?=
 =?utf-8?B?ZnNxSlVQODlWS1lHdzNhRUhZakJ4aU11VnZzNXdXbmgrS3hMUzk1TnE0akVH?=
 =?utf-8?B?SzV1blBuYnh3SjZmNVVHSGZpTldHb0l2NHFzQWpyWjBFVWFDK3lLYldwQ1Ix?=
 =?utf-8?B?dlViY2xTdjdQNDFXdlVrdkd6RExEaTNyVU5EWGVGUXpUZjFMUk84SU54cmdl?=
 =?utf-8?B?ZlZ4L3NwcGpMdHdtZ21uUGp3dmlKT2hZdVV4ME8wZHo1VkpMenA5S3ZvQ1Mz?=
 =?utf-8?B?aGMyQTVvSWJpU0k4a3hHOTlvL0RFRUJITXBZc2EwdFV2ZWpaeU5HQnY0Zitn?=
 =?utf-8?B?RXlwQVU4bnpaUWU5NzNicmFKYldoaTZRc0RXNlZWZjFMTkRVV29oc0h4WmRT?=
 =?utf-8?B?b3JoZkpCbit4UlFQS2drSldkTmE0ZGx3WVgyM2REOHkrZWFqTTVjUVdZTzVl?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4d57c9-b2ec-4d14-cd18-08dbef525891
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:08:35.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6fm9WiaZnO6D9/oxdl21trncAURBFH/O8L69yXfETkw8xBZBSUb22Tge6jNyuw+EJx7tP/DjbsC/TKLtJBtMs+l63dwaO5F0p3DS93tv0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 25 Nov 2023 20:29:22 +0800

> On 2023/11/24 23:47, Alexander Lobakin wrote:
>> After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
>> into fast and slow") that made &page_pool contain only "hot" params at
>> the start, cacheline boundary chops frag API fields group in the middle
>> again.
>> To not bother with this each time fast params get expanded or shrunk,
>> let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
>> their actual size (2 longs + 2 ints). This ensures 16-byte alignment for
>> the 32-bit architectures and 32-byte alignment for the 64-bit ones,
>> excluding unnecessary false-sharing.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>> ---
>>  include/net/page_pool/types.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
>> index e1bb92c192de..989d07b831fc 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -127,7 +127,7 @@ struct page_pool {
>>  
>>  	bool has_init_callback;
> 
> It seems odd to have only a slow field between tow fast
> field group, isn't it better to move it to the end of
> page_pool or where is more appropriate?

1. There will be more in the subsequent patches.
2. ::has_init_callback happens each new page allocation, it's not slow.
   Jakub did put it here for purpose.

> 
>>  
>> -	long frag_users;
>> +	long frag_users __aligned(4 * sizeof(long));
> 
> If we need that, why not just use '____cacheline_aligned_in_smp'?

It can be an overkill. We don't need a full cacheline, but only these
fields to stay within one, no matter whether they are in the beginning
of it or at the end.

> 
>>  	struct page *frag_page;
>>  	unsigned int frag_offset;
>>  	u32 pages_state_hold_cnt;
>>

Thanks,
Olek
