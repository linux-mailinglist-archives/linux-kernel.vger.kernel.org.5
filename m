Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317A75B60F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGTSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGTSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:03:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765C123;
        Thu, 20 Jul 2023 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689876213; x=1721412213;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Brv1gU5COB2l0wVlMA+O0siPMC9+awPhpou2eIUYsE=;
  b=QN2h0myCIDzBPgj5jOl3ZjNhAb73YH03PJJXja+98GVWa8qv8v05M+ci
   E0r56D0V/avBVrI5zakLe1v6E8Vk09VKkN0+gh68dMQY65T1p/DW5dtzI
   9XR+WxmAXxY6LB+yi3FDU4DzI9BG0nRnRw+R4nib4bpm6WXML5wnRKYd8
   E92oIYPec377KwMxRp9ODdY+ovsUwEukhCRYbEjlAjml26/6a5lUGAgeQ
   39BZQF0Y/faake8sRvQ2fVWFY6/gFrvby9V4viy9MsGVfd4ke9PGqcnUG
   UINf0Mjz4AakJVIPUnKPP+9HNzAPQMTzw9+aqvQeiRH3UiMUlQQpKUv0h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369494544"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="369494544"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 11:03:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="814613910"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="814613910"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2023 11:03:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 11:03:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 11:03:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 11:03:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 11:03:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nptoSKu9WCJVFTvBdgos28FiThOh9BUdhDauPKbP1EkcpkH0El0N0EljHHHGYMj+ToGebq89/dEUjQb5Lv4VgpfMPvAtNaq4ZCbtdPd2QzEhd4EFOpFL7N1Xu94BJJMEruiP53Hb7OP0FOpAneVKvKCMnqOhnJeki6sUvH7gjbiD+r3dtFlnjaCcbjTjcGjNqlPtJNRMwZeTyTj/ORsXaXRIDcf+Hcrb9892edlpEupz4YBJ4n5Ggk0muuUIG0YzA94SJ1P1EO6US4gBAE0CDJ4qiHhXuOUZ+j1okz9hrFFPA6Fp0/uir20BtcFpDMgOsxG9xEqZ1zapAWoFRwgJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjX+OKqLYWgE7nPkg6pM964VN4bqIpHEyQoswLuU1QY=;
 b=G6HWqZQ7/D2+GVImbhqZWVsopU4gG/dXbCwWn1SUYTNk+7sLB1blSQhZGjlp6t4B7LlaMfNLY3qkhBn9FOxvZMcSqFrz/0TgBznDRmgKGdU5GeWrXvkjDwbo91fCDlkLWyC3DCYFkAu0NcqKY5o2fuai/KxX0LtnloA6GTTi5MDgn+wlbOIm2xDUyo9wyc7RYgTr+GiFjBPxzdLHfy2a+zPBMuuSMnXaeTUFQsHdSt+VZGT3ans37+dmEDgHoAGGnheTAAruL9HSb2DHHrL6hzBx+s0413F8WI5AOhpCT6e8t5t+Lvk3d6rn2LixGH+oT21s+nX30RKkYpWCD9vN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 18:03:28 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 18:03:28 +0000
Message-ID: <988fc62d-2329-1560-983a-79ff5653a6a6@intel.com>
Date:   Thu, 20 Jul 2023 20:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC net-next v2 7/7] net: skbuff: always try to recycle PP
 pages directly when in softirq
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714170853.866018-1-aleksander.lobakin@intel.com>
 <20230714170853.866018-10-aleksander.lobakin@intel.com>
 <20230718174042.67c02449@kernel.org>
 <d7cd1903-de0e-0fe3-eb15-0146b589c7b0@intel.com>
 <20230719135150.4da2f0ff@kernel.org>
 <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
 <20230720101231.7a5ff6cd@kernel.org>
 <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
 <20230720110027.4bd43ee7@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230720110027.4bd43ee7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d34234-1e88-4053-f48e-08db894b9e87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0HM/twcjQJ/n6cyYDX5D0si08FHEXLXExI87BJwwXiXwCGBOvQtcaerwbeVUIJGlE1T0h5Fz3wNubQ0/ydDX92uG6QhvEAKp3HygnQkPWB0c2EZ7Jz50l875z43+DwyYjYOYC8ZVvrAFKZnNFICdTzqjEVvfpwduCdY2YdNvYxpfNFkq6yaxuVnkXcTarx6yMS1iPfirWtaozRoiWL8epNacjRY2f4XLOy+KrM+sxQ68bLpMcQ5Ol7dbNDUMT4JAiwTUNKUV1iA3oACkfh9aVQwTur415W7qEzm79IbVDfZnmg+hfnhwjeqlacEiY7D6aMw0T+YYDTw0QXfFfo5qCjpzqGf1G9SDI0m+y51I0eFF990K+eQgh6ufEB7umRQjwtK6UtEuFbINmjTQ3BhPXx/lQ3+hd78kPzn0b6BlDjukha70KbEgNyMLpDpRCfe2J8Bv+oOLqFbzFdVs0Efuvufzn7zjysv0tHfN1BDFQWGItKHtpUPUSbZ88CFFQHGFkIBXPrSM+EgZORdBAtYeaWMmchNZn7qfdac3QNw9YSKNAxpC3Y72MnDycQanqLQ1wJ0JxdunAJlksXvw6jY93Gs9fyMsWON3FXl7d2qCkrR0Dyy1iT26VRR9WcBs5YUyV4d/JvJI+2RLes4tOeJag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(478600001)(6486002)(54906003)(186003)(6512007)(26005)(6506007)(2906002)(41300700001)(8936002)(36756003)(5660300002)(66556008)(7416002)(8676002)(66946007)(6916009)(38100700002)(82960400001)(66476007)(86362001)(31696002)(83380400001)(2616005)(316002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNPNWxmSzZFTGM1UFcrNlZ3M3gwc0oyS1FpMXAzbmVwRGJBRDBzV01teHhr?=
 =?utf-8?B?WkdDdiswN2VNSEdNbHNZK3E5dWl0dVJnZU9aUUF3RENyQjU4Z0VLTzg0VEFw?=
 =?utf-8?B?V09EMnIzVmlGclBTRUt4cGFWckNRNEt6a2luVStVSHQwbFhSQWUydnFjRWcy?=
 =?utf-8?B?SlFhY2NiNkxzc1pWb1UyLzNKTVlwbHcwSFdJSG81dTF1UTE2MndGODdwK2w1?=
 =?utf-8?B?K0RsVXFKcWp4NUdaUDJXZjN2Vk5mSUtUNVdjVUdKQ1NoRXo4djBGblF0VXN6?=
 =?utf-8?B?UGFIZ1JFeWkycUNpTFBjTllYeFdYbHBRWmR4NDAwVkFhN2pjVGh5OEc5VTkw?=
 =?utf-8?B?UmtiNm92MW9vZndVN01INHVxeGhWU3ZOcTFybCtjcjVXaE1XRHh6cUx6Zjd0?=
 =?utf-8?B?dTZUZ1UwNFlJOVVPRzVsSUhlMWpFQXZDclpSK3NrOWdwbWM1M1dNNHVBZ2lQ?=
 =?utf-8?B?bklSUzJyV2hhem5zak1zNUpYLzI4RmxQT1grOTQwRnB3M2xUa0pwbXIzRHdh?=
 =?utf-8?B?YkZHaXh1SWx6OGM5VjUyUzdQaUh1RmttZ0dkQitMMU9UdUliQ3BmTTNjTXFP?=
 =?utf-8?B?aHhkNnY1RlVIaXJoaHlLUll5UW02NnBUMHZHUTJya3FPcjZVSktQOGtTQTVG?=
 =?utf-8?B?VDBEaDZwWDRrNXdGU0RkYVQ3dXdXRFFPSXVDdWlhSUQ3U3BQbyszWkNEaE8r?=
 =?utf-8?B?OVZxdExwbUk2cWNTdy9TNStTZjJDRzIyTGZGN3gvdStQYi9za0xjTGJnSk05?=
 =?utf-8?B?SWxHaUdSRm41NWRvWU5YSndrQVJLaTJrNWtSczY1MlU0YUVpOTNSNWNOdys2?=
 =?utf-8?B?VURPaU1RZ09EMW1BQTZOSUkzOE0wME1GNC8rdDVPWmZBa1p2R1lJMzBxV0tj?=
 =?utf-8?B?eXBzNFlsQVdWYTJZOHVKZUlFTEdON0RPc1VWOGc1THAzNFBWbmVHb29NR01m?=
 =?utf-8?B?OERiN0k2cmJ1WkhMQ0RlTURKQ0VUYlI3VGRiQW4wZEdZVTRKeG1qMDZ5eG5y?=
 =?utf-8?B?S1ZObnFWclhIbmVmRTFjSGV1dGpQK2N0bktrenE4b09HRjZOcVJoL2dSNnBS?=
 =?utf-8?B?RWVpUXVVcytJTmsxVVV6LzFZcFNYbnMzaVFRZVpocklONytaUEM5SlFXNGFH?=
 =?utf-8?B?cytHQS9oTHlwbXRYWDk5OG5wV0pDRXh6aytLK1ozM0pIMkhuVUptSTVWOWNr?=
 =?utf-8?B?YkJLeFZuYVMzUVZmNWExNUp4WjhNTitVeTlqTkNEYTFxK2l6K3BRazRXN1Ns?=
 =?utf-8?B?MUdtbjZVekpiWVVpZFptNmtNYi8wNGlCNHg2clFZRGVLQnB1ZHZLdU5XMUVn?=
 =?utf-8?B?UGpKRWQxbzBRMnFPMi9Nd3NON1BwSHVkUWRUVnIxL2VqVXlJRVc4bTg5cHlp?=
 =?utf-8?B?ZE5JamRvdVhjc2ZWelJwL0tEcUNVMUc4b2JMamZ0TU5xNmNpZmNScUoyenhH?=
 =?utf-8?B?L25rcXc4NDl5M0I5QndvNjBmV1hXUldxN2xQaS9UQXQxZ3pwRVg5VHQ0M2RR?=
 =?utf-8?B?MTBqWXh6VUtTa1BUdkNEN1ptb1VadUxjWlN0dnFYeUJia0M4MjAxSnR3Yy92?=
 =?utf-8?B?WHp5YmtqRXdmSGcxZGJTdmpPR1lkdVgzaVJIWlJacW9xSXFBdkM3dDZDQkpC?=
 =?utf-8?B?VHYrR3lkOW1xNmJmSzlWOVJOd2JXdjM1NmswbXRwZWRwMk5LYXVqUmxBQWl0?=
 =?utf-8?B?dFU2dVZBQmlyTXdTdDEwM2RYYzNGNVVlNm9adGszOC8vVm9XQmw5eWhDY3hI?=
 =?utf-8?B?NVEvMTluTWZFSysyUENwRTVJSTN4cXhnTkVKTFFXSCtUczdjQkxxWGZpQXZN?=
 =?utf-8?B?MFhUUDJmRUZEMDFySFdEelBpRTJ5Mk5XZEt0UTVTeTE0SFVJVk40M0tWK1hS?=
 =?utf-8?B?L2VXNjh5SmpPVkhJR1ZDblhiMGVtVkovcXZaZ25xVmxZSFlYWlpHdS85cUZI?=
 =?utf-8?B?dVhSa2VGWkhYY0FGcmI3YTZPd0FZSm1qaDZVOXhQK1NDeTJaZXQyaTBlbFI1?=
 =?utf-8?B?dnJFeUV5dWpJMGNLdmhCZk5tOTJONGdxU3Vha053L2hEOXZ5RnhwK0gxUmZk?=
 =?utf-8?B?WS9NcEx5RS9ETnA2cWtvNXkrVlUzWG1CMGhVemVpRlk3TUNJdDgwRVNWeXBw?=
 =?utf-8?B?WkdYamRjTjBJUnJXSFRkRFdzRkhsSkkzeTBIZi9VeUZtdnNBRHBmV0ZnQW9M?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d34234-1e88-4053-f48e-08db894b9e87
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:03:28.1374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33TqzNNurs0SkkmR5FYjLNUouYId2KMlWtpMZfNFUlPiXyS2ojL5sF/q7aP+QuNwo+0p0LqphaT+9R9DoxDk+KH+MNXhNoWfyf0VDb3NXgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7608
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 20 Jul 2023 11:00:27 -0700

> On Thu, 20 Jul 2023 19:48:06 +0200 Alexander Lobakin wrote:
>>>> My question was "how can two things race on one CPU in one context if it
>>>> implies they won't ever happen simultaneously", but maybe my zero
>>>> knowledge of netcons hides something from me.  
>>>
>>> One of them is in hardirq.  
>>
>> If I got your message correctly, that means softirq_count() can return
>> `true` even if we're in hardirq context, but there are some softirqs
>> pending? 
> 
> Not pending, being executed. Hardirq can come during softirq.
> 
>> I.e. if I call local_irq_save() inside NAPI poll loop,
>> in_softirq() will still return `true`? (I'll check it myself in a bit,
>> but why not ask).
> 
> Yes.
> 
>> Isn't checking for `interrupt_context_level() == 1` more appropriate
>> then? Page Pool core code also uses in_softirq(), as well as a hellaton
>> of other networking-related places.
> 
> Right now page pool only supports BH and process contexts. IOW the
> "else" branch of if (in_softirq()) in page pool is expecting to be
> in process context.
> 
> Supporting hard irq would mean we need to switch to _irqsave() locking.
> That's likely way too costly.
> 
> Or stash the freed pages away and free them lazily.
> 
> Or add a lockdep warning and hope nobody will ever free a page-pool
> backed skb from hard IRQ context :)

I told you under the previous version that this function is not supposed
to be called under hardirq context, so we don't need to check for it :D
But I was assuming nobody would try to do that. Seems like not really
(netcons) if you want to sanitize this...

Thanks,
Olek
