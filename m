Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C48757EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjGROBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjGROBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:01:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3451FCD;
        Tue, 18 Jul 2023 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689688849; x=1721224849;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lBmMmPzpy3sCBZRZ3qvkDbczZs/L3W9/IfSCZHmrjDA=;
  b=TjUCoMYzSvddrjPHcxZVoxO1AA5PovL9g1VI51hgQyJ62M+TLpywuFIe
   DnbT5qigdH3OM63jGJStaOFT5QH2GP5Zp8JL1sMXNi3YUqBvAUq0PxaoP
   qIqXsTaOVCzSY2lykwL7UiueKuPn/mAO45lKTu2iaXZtp0/x1eTF9yc2a
   H9xVlQwcOntRViBKO+sgU6oeY8czvPUW5LTF1eslPvbkFrab18tYjH+jX
   wkNH6zKxcuWEI591rKkmuTP9bpHtchA3tMNc0UuBYeSOIR85wwFYNpR/t
   RVm70PHXk9rtXpf42WaEgW1TUoo/xSIQRdpNLJzmO1FK7413GjcyC0gnp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="365089427"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="365089427"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 06:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="673926142"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="673926142"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 06:58:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:58:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 06:58:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 06:58:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 06:58:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV2N8GRZbpZKSaBKlOW8SPoXoxUgasBrhPpyOk3MxmmZjtaCKhGyvhVKD4Vb4GHKiaevV3gnsxoUJEQIACzzZJyI8UeTLX58f77xkGyoJs7YLuxI61k9YKNEiyz8kIgXK9GTXI4ZpRPYdAigRDF+JBfxwEAa0hDpUTprtxzVeXLQLWW5RkLsPAjjL96krJIl1zmZnRIffFFW94e9ak3fMTcP+RYHzEKDOshVq/gwiFQaE0xWpUUxBdQmQRXQKdyK3uxhQSDFTLpy6nmTc42CMi96CB5ESFJk1Sm9grN5CmRJGmgCIz3n0IGn/KKuz/a7RRa8OOKYoh3VOjkd96NXgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAVa3rMgzkAhJYMd9+AuzlSLFmxvMjtmCXraz2aYvcs=;
 b=ab8ry4jYRUhHAhjgseOQpUS+WpJBhRChZUyQtZu+WSJCtT6HhnOC/oHP22/Xo/GuTIqNbBmBQSrVSEfLM64g3Iw4oQs/ItumCc3OegQIqP5FK/8JUvZ025Rlw42eLLtZuV+xFSJSFzXLaJ4dUf7jj7KvGEZh9OrZXAsgHjCkZauIXQ9BczqFWpUOmUh/4a7Mc3cXff4Pl5yXrtvOCU9TOQ3I6Mgba8n56fKxwFHsuyi4ppU+i7uzWrfUGmik3vQc/ZRhdVj48a+GoBROUS7eCoZN5l359j7unxty6LlQNfAEyBv7PgSGgCI7q/n8yUr3Z75zJDjehA29bn5s0SMf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 13:58:29 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 13:58:29 +0000
Message-ID: <9275b613-3a9d-2de3-2f21-407e56c09622@intel.com>
Date:   Tue, 18 Jul 2023 15:56:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Yunsheng Lin <yunshenglin0825@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        David Christensen <drc@linux.vnet.ibm.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
 <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
 <bc495d87-3968-495f-c672-bf1bab38524a@intel.com>
 <4946b9df-66ea-d184-b97c-0ba687e41df8@gmail.com>
 <95c5ba92-bccd-6a9a-5373-606a482e36a3@intel.com>
 <558849ff-6b68-7547-cf99-36801ff24c25@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <558849ff-6b68-7547-cf99-36801ff24c25@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA2PR11MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b9fa14-7e2f-4754-4574-08db87971024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OCh3gEifIqGbQghZ9OBc/CEPvo5W6j8tx2PrpTE1j90FG8Rm9tb9e6J0P761JAfeTW8NzVZSCX29EYFWh5zJZ39MU5WXtErATLeNKk6qGSaFlmZxBgLpNRPfScsM2etddQzahQc6XmKfwmJhiGYfMgKJdRA20d7S0HHnyWn3NMWczsczuibW+B79AXiVdxIgrcrllmuNcp7Gm+pX5WAtRpjqErmLTmd9qh3611yJDkNIqovqi3h/sS9XNV8LlmMK8QR8X7mwJrMB6p2aCNJbrRYKUaBC2prSsARIk0edA+D8n7dC56ZkgiKomEdAmVXNeg3exkzMiTwH+4xdeSgNV5L7B6EHAaUgKQQFt7E3Bk8EZzy0WbzU/CVB565+aQhe3kABA80GKMLqZxHY7N9+v/42H/tcfagLPskpo5RqihQX/HloCZIfcIHViggweNBA2gA2z/EECC1S7KG4zOhmt0IIW6GAGwjDxMywRY2t23SJoh8qZ5++uYfTnAAjH2haIBTOuyKWhMua58x0flZZ3LNDP40TPjAMRvFOnhuA519mWFHLJvEMPuD85uSlhxWOGRZ8SVsXhvlJPwBwu6WuJZa6Cua53jJm8LdDQfz3ddKtZJbysZdDAsby3vKOvWHPFlcMMIncQTRuH5CRhMF3tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(31686004)(6486002)(54906003)(6666004)(478600001)(2616005)(83380400001)(31696002)(86362001)(2906002)(186003)(6506007)(53546011)(6512007)(26005)(38100700002)(82960400001)(66476007)(66556008)(41300700001)(66946007)(4326008)(316002)(6916009)(8676002)(5660300002)(8936002)(36756003)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxOelBXWWhWZG1VYWl0NFdaNysvY1dJRlNLREFyU2tTT0RNd3RwbktuYzNl?=
 =?utf-8?B?V29nNkRnVW9NNHFEd3FKcXpMT3c3VFRES1ZrQ2VCYzd4QWlJZ01yMDBPN1A3?=
 =?utf-8?B?V1ZKRzIzZDZUY1NvbEdKRXRoY1ZRMFBlNjZhMHkwb3RtMG4vMWU1NUg4dkZp?=
 =?utf-8?B?V2NNTUxrOGx3NmJjUjlmTkRpZXFINnFycU10cXJEa2tSOTlRK3YwanRTZjVD?=
 =?utf-8?B?LzZZRXBxMTlXNXU1RXNhbHdkek4xd2xnOSthUWVybXVtU0pqNVlDeXBVQXFx?=
 =?utf-8?B?Zm1YZ3ZBa1NhaWxoZTVQZlRwazlzWlQ1WFNDY2kxNU5CTmZXUmx2anU3Y0lU?=
 =?utf-8?B?bDZTcUk2YVJUUEVNSkZQQjRWcjZSSkszN3IydXVWZlFjVjVxaWxpV01IWW5a?=
 =?utf-8?B?WVBlc3JnVlZCL3Z0SW9XM0YwWWJrWEpON1Zad05HTzB0SEFQeHFBZUlMRXNC?=
 =?utf-8?B?OUwrT3VkNGliZG1CNDM4TTFXbXBPd2pFaGFrYVNlZXJwNDlFTHUvSisyTTJi?=
 =?utf-8?B?cWhlSWFwS2Q1RWYyWUxNWGtNNWNVSFJqdUdWM0Y3SitXblZZZkhLNlQ2QXps?=
 =?utf-8?B?ZG5uUVVnUjZXZWNOK3lsUUxCZ2Z1U2tsVGE2WnpLbHRMVXIwWll0NW9YMXRy?=
 =?utf-8?B?TnBJTWcyaTZ2QWpBNS9JNjMvSmFoL0FJak9aOHRBd3k1TThrNThRUWQvdFRq?=
 =?utf-8?B?bHRQTmtzVU12T200L0lIalZVUkRJcFZvMk9mQUVZdWpFM0VoeDliMWRnUENx?=
 =?utf-8?B?M2E1VTRka3h4Y3RsWEMrejBrZXg1WkEvcjJLU3lvSHoxK1A0NVpGMXVNSW5H?=
 =?utf-8?B?SjEvMElOYVdFazN0VzJPVnFMTlRxckVPOTR1cWxrV0Q0bUpZaFhKNXh0ckd6?=
 =?utf-8?B?WDZPbXk3L2VXdEJzQ2NVNmlBZVdDWGJIYVFGMDBvSzJjR2RHdW4vcW9qUndW?=
 =?utf-8?B?RktUNzU3UEg2K0hsNklMaTJGTDdFd0QrQTQ1RFMzRllVVHJ0NWhTNEc5eGhC?=
 =?utf-8?B?TWlpTkpHMlNMS2dJcWVHdmVuVzhxc2hNRmNsU0J5ejR1dHhYakZTR3dNdnFJ?=
 =?utf-8?B?TkUwNnRWVDhGdFN6dGZHR05RN2xaRzd2MlQ3UTZpVzRXQjJGeDN6K2gvekNE?=
 =?utf-8?B?WnlVZGhaUUZSSzNKVDlJZ3NEK2hTaFlXN1o4NW1hZlJoWTg1WmYzV1ZLWmlG?=
 =?utf-8?B?QXpvenpJdjhlbjkxK1Q1bHlTSm52WHphVkJaMkhqSFRFcGFKUHQ3QlJhM2Zq?=
 =?utf-8?B?KzVsQmJwNFBscGp6VWs0Z0VyTkNXMG9wY2N1Y01aeUpiL1BaOThSWERTRTBh?=
 =?utf-8?B?Nmw0MVhMSUVCc01pSGhtZ1JiTEJMMmJMRWhZYWpkaTRnQzFhTVd4ZEhxdml4?=
 =?utf-8?B?d3YxaktTTmVnWmpiQWh6dHJ2OUlzM1JTZUxDeDdJMW54bEFPYWluWHFPb0JN?=
 =?utf-8?B?ek8vV1JlVGNyVFY1cDVMdWR1WkZiT0VoaGVOSVpiclZGdmUydGc3elBCdXJP?=
 =?utf-8?B?SUpWWUtVVENWMk9zVlRqay91REpCVjZhWXZ6MTNFMnltZUZrRUNzVEt1YUVD?=
 =?utf-8?B?SXQwRmhiTmRrRXlKTzZEUnNOUnpoTGpNeWFkRFZvaVEwRXBMMEx2ckJlUW0z?=
 =?utf-8?B?RVhWK2hhMk05alhxQkVGeHJxQW5YcVBBWnF1UWxHU1RTbU1JU3JJQWc1eFN3?=
 =?utf-8?B?RFROZGt2S0ZIZlEvQzZ1dTIzWDZJa0lGQlpxTHJFYllEbnBWZ2VqNjY4NklU?=
 =?utf-8?B?bHBkazNEME5IdGJFeVlMRS9IUGg1NWhLZ0xLUUhCb3I0RUVTY0hFT0NOZTBM?=
 =?utf-8?B?YzJ6RXlJVitBNUhNSzBtcGtiV2NBd3g2UlptNURWYmlBMk9uRU1DeHMxenNw?=
 =?utf-8?B?ZjJkVUhHYVBtb2YvSG45MVNjdE1abTMrUHdndDIxdyswSkMwK0hWWURkdFk3?=
 =?utf-8?B?QzJadUp5VkN2UHliczFsRW5ycWU3bnlPdysrSjY5cnNXbmZZZVZ3OTlxakg1?=
 =?utf-8?B?QWJBRjZrejkrNGxoTy8zcVlkbmZYcEJNRWJLWmI4aHZiNjdFTDJvVTZTWGdj?=
 =?utf-8?B?UnhORnRLeE5HRFo2U1N4L1NTNWFjRzQwY2c5S0k5T00zc05paE9LT0lKUzNO?=
 =?utf-8?B?Ungvd0pBNCtlc2ViNVNvSlZqNmVCWTFnN25MWW96UzNWRy92NGsrTFFUbXFH?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b9fa14-7e2f-4754-4574-08db87971024
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 13:58:28.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sVuaYZVmm4bmc4HCjx2uWoAwqyI8h5tj/Fi1Xh+i8600npBS+uH305AB76zPAdRnfIwKFJlnzE96oT6Sv5XM5G0pDzoLBUQBXUGTfGXCJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 11 Jul 2023 19:47:14 +0800

> On 2023/7/10 21:34, Alexander Lobakin wrote:
>> From: Yunsheng Lin <yunshenglin0825@gmail.com>
>> Date: Sun, 9 Jul 2023 13:16:39 +0800
>>
>>> On 2023/7/7 0:38, Alexander Lobakin wrote:
>>>
>>> ...
>>>  
>>>>>
>>>>>>  /**
>>>>>> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>>>>>>   **/
>>>>>>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>>>>>>  {
>>>>>> -	struct device *dev = rx_ring->dev;
>>>>>> -	int bi_size;
>>>>>> +	struct page_pool *pool;
>>>>>> +
>>>>>> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
>>>>>> +					 rx_ring->count);
>>>>>
>>>>> If a page is able to be spilt between more than one desc, perhaps the
>>>>> prt_ring size does not need to be as big as rx_ring->count.
>>>>
>>>> But we doesn't know in advance, right? Esp. given that it's hidden in
>>>> the lib. But anyway, you can only assume that in regular cases if you
>>>> always allocate frags of the same size, PP will split pages when 2+
>>>> frags can fit there or return the whole page otherwise, but who knows
>>>> what might happen.
>>>
>>> It seems intel driver is able to know the size of memory it needs when
>>> creating the ring/queue/napi/pp, maybe the driver only tell the libie
>>> how many descs does it use for queue, and libie can adjust it accordingly?
>>
>> But libie can't say for sure how PP will split pages for it, right?
>>
>>>
>>>> BTW, with recent recycling optimization, most of recycling is done
>>>> directly through cache, not ptr_ring. So I'd even say it's safe to start
>>>> creating smaller ptr_rings in the drivers.
>>>
>>> The problem is that we may use more memory than before for certain case
>>> if we don't limit the size of ptr_ring, unless we can ensure all of
>>> recycling is done directly through cache, not ptr_ring.
>> Also not sure I'm following =\
> 
> Before adding page pool support, the max memory used in the driver is as
> below:
> rx_ring->count * PAGE_SIZE;
> 
> After adding page pool support, the max memory used in the driver is as
> below:
> 
> ptr_ring->size * PAGE_SIZE +
> PP_ALLOC_CACHE_SIZE * PAGE_SIZE +
> rx_ring->count * PAGE_SIZE / pp.init_arg

I know. I was wondering how your message connects with what I said
regarding that using direct recycling more aggressively allows us to
reduce ptr_ring sizes, as e.g. on my setup ptr_ring is not used at all
(it still will be in other cases, but a lot less often than before).

> 
>>
>> [...]
>>
>> Thanks,
>> Olek
>>
>> .
>>

Thanks,
Olek
