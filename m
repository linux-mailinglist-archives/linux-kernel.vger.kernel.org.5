Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4875B4F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGTQsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGTQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:48:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055FC123;
        Thu, 20 Jul 2023 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871712; x=1721407712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OFjwrEzlOZj1WnZ4Ft5TFRFUZcDv5FKS1nZaHuvYc78=;
  b=SmIWj7q9Yztnxtt2MU55D7FarNbqJW/RVk5ayGuU6lYfe186fnaG6DUF
   lAi4SjVhrNvcEpl8RkGnqTROzwkcwsYp9RMp9ewCue+vxhAmBs+0WpdD/
   x5N3mGIONkrMP00h0w3zt0m0i8G30HUdNVzGjMuW+wr/uPsi24F5ItMfy
   To3yXkikL5z2bEI9uUR5OSX9RVK20Tcl8G25G2eRSwvPkJUv+TS2L8FGE
   DfvXf65wxV/2Xb9rPI1jJWQ/bZm9UpmpLRB+XJ2V8Tp+StGLXc49CAvY2
   WiZEXwSTbOZ2EG1mtbb6YZBcCiaPdIqbInOsoyGfUIJwjkrHzXgTFagYM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="351681755"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="351681755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:48:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055260682"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="1055260682"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jul 2023 09:48:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:48:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 09:48:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 09:48:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 09:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj9t2NN2ptfB8bzt5G0eNBnJegy2DoNvd5+HzHJqDeZr+ivNgJOdMraDWlwPq6XTlJ/Pd/DvPW0WMwFDZdPXOViZZ1DB5x1+Ia01dvbc5NGfZtokdscT++aC4ChITy1nC+szXnsEYIzs69kvATSUjxROP1I59MLRXI5VO2pJLYbxG2R38d5ArQnL0DEbov5rGy6ymRkNOPnnBh6naMm3mZqjKXe9FERS+JKmG7ZtPqe0HxwrVfFR/1WZRIoMk4d/EI1mxIfGVpQZccF84FFlAuEugEhDjhlAcgTqfZNbP31I7bI8jVD2XUhH3wNNka3JqY73YhAn1HeuO3Lg7pLwmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6vfHte8CftXBD9EX44oS7rSt+wCtfdM4v648b7N0Ak=;
 b=FD9wxGLhb7E10raxSURHARUD0uU4UgFFcPcejzQifsTuzyak5KAIfbzhrguTUQJNFDx2N1ceyrNPkW1cR9mX4uABFqgJFJBOe/icwyhhPN3PFusfQ1wx3k5qUppNw6+yTwr6EYL1NmyBc/Pkzt9SKy8uErR0CnjgvBkNM+FxWKt+z6NWlW0JGt0M7sStY93EXdV2T8vM1c+juYOIoc/J9iFF0ixEzNadog6TZsa3mB82lfENUtqm4GUhnh4gWGRqa1JNI+edFU1dtSC4vr+4+1JwU0c912iNsWlbGxT1c0FwxRsM6RdDYzOGqg+XcqbHHd+ABFMNS5g748+nXZfwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MN0PR11MB6158.namprd11.prod.outlook.com (2603:10b6:208:3ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 16:48:01 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 16:48:01 +0000
Message-ID: <48c1d70b-d4bd-04c0-ab46-d04eaeaf4af0@intel.com>
Date:   Thu, 20 Jul 2023 18:46:02 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230719135150.4da2f0ff@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MN0PR11MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: d35493c4-4651-49d7-0bdb-08db89411427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0OYFeS2ynP+Log60ReBqVXWg/IJq4o79rRtphs555F3XoBxX09vUjDPHkUKUfuZcdgWEJ2XIca4ZnvbrZpAxiAr7eD9bB8q77GY92KNj0uxjU/p7iWhOSinShgDfeP4yfzSaH3JjgYxZfSuOCAMwI+ISEZemz/oCL9VtbNj67wPXtZLN/oK/E3tqcTmgIgk+VRkb1Oy3Z2pCZTj5Q66BlcuvBtxPi7fZgTgkPuh1o7PZwkPlRIbPsHPggnyVF8JTGCh8zTvPyLecXv0AubdFBoIOdhumYnC9pPlQgDy2IC4CEVhGbKwFBzQ0zVcoqMR6+/UJUQKPpawunwJnxOz7FCIrkokOrS5jLlbYOOk6q9POVcTf282AoMh289i0fmGN3Ht7NkhcFCgd2Z/MguID6wJhRgWoc8umDET8rZRNvWtl057Tf/Njbz38VSGZ8owML6uTSgW5dL2WFzXyGQyIcuJmn1lINriuwnezbucLLz5puCp9zYI2gTmyVEHVnAArxuizt5EHPtZTGcV6g5p4+s5xBXRdPMJey9eChUy30FXd76RhPECNAcOKcjZ47rhg03LnAOJlM4eqtJ1sE5zhK0qQsY3Bv1NBiWTtpdiEBDcivipb4PcJHbT5cQE36PGvpDZbbM5L+4hYgX03JIlTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(31686004)(4326008)(6512007)(316002)(41300700001)(26005)(6506007)(186003)(54906003)(5660300002)(6486002)(66556008)(66946007)(66476007)(8676002)(7416002)(8936002)(6916009)(478600001)(2616005)(2906002)(38100700002)(82960400001)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3V4ZmlnYTB6SSs5Q1pXOFR1em01ckZtdXBONTVmNnNEblNJdnJHRTJKNndn?=
 =?utf-8?B?eE13bWNTekFuc3B1aFEzMjNSa1p6Z2NDUG1rMmwwUEdoc1huUURtVWZnSzVh?=
 =?utf-8?B?UXZrYmU4b1lLK1ErWWhZOVRIZ3lyakFtWHNybGtCNmM1S2pxQkZxR2pPcEox?=
 =?utf-8?B?Y01KM2NSdHNoQmJwMC9oYXUwZmhXSnZlZ3JFSjhaSm8yRGlMNUF5eEVBT1NR?=
 =?utf-8?B?aFlZMmE5TVQ2cE94cDVldW9Mczhhci9obnE2UXVSVmNTZGQvRjhFRDIrODBW?=
 =?utf-8?B?WEJTckNCUlcrN3VqckJ3MEpHaWpuZkM5Qis5ejZhZ1JXVTd3RzRXeng2OGRW?=
 =?utf-8?B?Tmk0UUFPdHFCdzNwemFTRDQ3b1M3cnBPQWZXbi9iNXY1UFV0SHBiekpjOEtO?=
 =?utf-8?B?OXZzZE5Ldm90eTR4WHVTZ1lCdDlkcTNvZkEzTDFWVWZvK0pjTEx5QWhtTXgv?=
 =?utf-8?B?SGJqWXQvYUlncjQxemplUklPVkJlbGRpVlZBTHA5TU9lb0M3R3I4VGNmSTJq?=
 =?utf-8?B?QWIvNmlwU0pWOGs3eWhLeTdIT01qVkxUa1NFQmdIcXk2aUhlZkgrV2xXc0Rn?=
 =?utf-8?B?eWNzcHdWdTBNSGJuMUtzU3RUbVdzekRQT3FXUERrMkhIeWtrY09uQW9kMitH?=
 =?utf-8?B?b2FzdjM2MVZvTTczSjBXWERBYzExdFVmdXY0cERxMWJ2ZDNIY25DdUJ3Q2M2?=
 =?utf-8?B?eXRXV1FsNWpBUjdsMDFKOWFzWFRWY1RVNUwwVGloSmVIUktzTWczK1dETkpu?=
 =?utf-8?B?QnhFMUkxYkduWS9aVVNwdUMwR25jWDI2U0JGM0pHT0kvNEJmcGsrUVVka3dn?=
 =?utf-8?B?S2p5UU5CTFJPS213S09zWmVaQ01vaVNoZzVzeVdCbHdyblB3MmR5L0IwWUY3?=
 =?utf-8?B?ZGlSN3dkTjRoeUYxZWZFZEdZQzhRd1hTTEExTnkrbHB6VWRwd0dKYWNOT3Nj?=
 =?utf-8?B?SlZROWVqT2k5R3FwQWc2WHBVNnB5aU1KR3haTk9oNUttMS82bUNpYWUxL2lq?=
 =?utf-8?B?WmtPRDlVQWphWE9nSWpnZWoxNmpEL2pISmtmTWVCcHFIdFduamgvV2FaUXM5?=
 =?utf-8?B?dVJPbk9jM2VVcGJEWTJBb0VzY3l3M05leWJsNDdQZ3pnT05wVDd6VEpBZ1FF?=
 =?utf-8?B?cGZmeFdkcFU2Y0VTTm9RRE1UZjd2ZmpSK3E5MXM4Q211OHFvSlJlcnRESWly?=
 =?utf-8?B?WUlyczJkbHRqbDZlLzg0VUJSVFVBaFdQYUZSRkdCY2J0T2FFemlsS1FiQlkx?=
 =?utf-8?B?K0lwNjVqazdMaGFlSnhqZzdrYU4xNXhYNWdBRUR3cHdIM1NoS3h5dnlkeW54?=
 =?utf-8?B?TFhDM1lIeDdWUERFYThZTjdYZmh1K3c1eDNuRjd4R1N2SjVDcDM4MDF2cXNy?=
 =?utf-8?B?RU1wRktMY2RPSFJsU2pSQ29YV05UV1p2MXdxbGlwRnM5dHdFSVUxWGwxV2h1?=
 =?utf-8?B?TTZ0UlhTdXdMSDVYY3hOSUFpeVlkeFBVU1Bhb3R4WW5tSWFGTVRaalBTbnJt?=
 =?utf-8?B?RGU1R1Rhd3Q4UHR0b1dNdWRaNW90bDAySW1vblFiUU9VNlQ5eFVGVTFNVXNQ?=
 =?utf-8?B?YlFaK2NTZVU4QXFrTkNvMnJKUW9xSEt0ODFWamlkTmlNU05pblFpZmQ5Tjlp?=
 =?utf-8?B?Wlc4YVU3MkUzVmwyUEhiZGlTa0RzZUFPWWJkaXBzdk9hdWNvRmNKQnhFWWJY?=
 =?utf-8?B?K3lhSmVWTFk2bHNFMyt0NjVPQlYyZFAwVTZvUkhEUlhaWko5eWZZTTZLRDNp?=
 =?utf-8?B?ejBGQ3I0QWFSZUc1VGtZM09rVU50cVp1bWN3VzFWWVozQXVRU1Q2cGd4eWlB?=
 =?utf-8?B?M0xHWjQvOFk4QWlmYk4wUnB4RHNIYjZldlBjT08zbFlLcUR1QnUxQjZWaFhP?=
 =?utf-8?B?ZDJJWittajhtaUgzcXlUMXQzNkRxU2svaTRWNlBJL1dSbDJrdUlKWHJkSk1F?=
 =?utf-8?B?elhvbWEzRzdrQVEvU2Vwd2F4c0NOVnZ0WjZzNWN2UzZOMTBuR3o2UTJiYXkz?=
 =?utf-8?B?anQzQi8wVU1xbS91ZDBSYWw3SDlWQnpHdk04Q0tJVEpzVVJ4ZWdSR3hYLzVT?=
 =?utf-8?B?N3QxNmtSUmEyOFNsbUhPa1Z6RXNDL2JKZTliVG13TThDSHVLa2pZaEYzNHIz?=
 =?utf-8?B?aVdCN20yMllJekNJa0JQUDIrNXhVMHJhL2RIUkFVZDM5V0ZQZFY2ZVNUQ1JV?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d35493c4-4651-49d7-0bdb-08db89411427
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:48:01.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAAQsrtj92JXO0N41ncvwoMdpCkWkXZrhMfJvwx9hw8BYBcgs3mufCDUi9s+870MBoCYmctYgP++Io9PpX7sRQaMhD1+E8VDaM9CjIoUhOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6158
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 19 Jul 2023 13:51:50 -0700

> On Wed, 19 Jul 2023 18:34:46 +0200 Alexander Lobakin wrote:
>>> What if we got here from netpoll? napi budget was 0, so napi_safe is
>>> false, but in_softirq() can be true or false.  
>>
>> If we're on the same CPU where the NAPI would run and in the same
>> context, i.e. softirq, in which the NAPI would run, what is the problem?
>> If there really is a good one, I can handle it here.
> 
> #define SOFTIRQ_BITS		8
> #define SOFTIRQ_MASK		(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
> # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> #define in_softirq()		(softirq_count())

I do remember those, don't worry :)

> 
> I don't know what else to add beyond that and the earlier explanation.

My question was "how can two things race on one CPU in one context if it
implies they won't ever happen simultaneously", but maybe my zero
knowledge of netcons hides something from me.

> 
> AFAIK pages as allocated by page pool do not benefit from the usual
> KASAN / KMSAN checkers, so if we were to double-recycle a page once
> a day because of a netcons race - it's going to be a month long debug
> for those of us using Linux in production.

if (!test_bit(&napi->state, NPSVC))

? It would mean we're not netpolling.
Otherwise, if this still is not enough, I'do go back to my v1 approach
with having a NAPI flag, which would tell for sure we're good to go. I
got confused by your "wouldn't just checking for softirq be enough"! T.T
Joking :D

Thanks,
Olek
