Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CEA75B5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjGTRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjGTRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:50:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CBB26B0;
        Thu, 20 Jul 2023 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689875412; x=1721411412;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MHhiQp4APbUqkW8VnNbctBwcWJMweUfenR4Se+w7JuY=;
  b=k+KIiCVljM92f1b00jk+ZRQJOmdGRe88MJvn76zea1Or0VA8swKouCW2
   xKqot/DVN+Y0UuntniKb0n/0BwNkoL+cr5I40iivb4SZyrjVk7/ny7Z31
   QSvQQSZ6x3loQHDuMX/DjJULzLVM4i0hC3Ha6DUNe+7SMdcKqq+gN+wFL
   tDzRZ7NCVlIaTucND2c8XIe50ETniiQiF8Vu8MirDd7XVKA25pTXQKAac
   yDp0nM8Go3xd/SJ9t5FbEQ0PRVn8rZGZMLrliCoqB3tKGl/WXJkDQF7EV
   AYcGICcCKeD3U1Pd4Tpyq1yyIWv+Lqj9Z0OJyKtq59hjj1hbzYJ9+Jsqt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346412132"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="346412132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 10:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="867929029"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2023 10:50:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:50:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:50:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 10:50:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 10:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXr4PYFBUy+CEIZAAy00wyIcjNnc5kZJsDF/TICwkImyjFcbRuEcTigxBhHN6Jgpd+FIXaZNy6DHBjp4xe14EQtsM/INo4xhgethFFJYUGSMpsdCk8y38vTffG+C17Ngte/WLY6993icayZrJfPcqv8vNOvh/V3FY5xkDHscpmkOBP5InwMrUTWPDy8hUSdUOoSmeEkBitRhTpQ4PPgIGOvFDYxe+t6eSZm/Rizx5jehG0iEcpIWXsFaulDI9F+PF7aHgKaWHEk3I+XJc74NcplPgTZio1ucs0eOqEnjwakfxmZgSk8fakPb1grfKZugPWm6ob32j4IKoYffCyF+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBElN/EhG6PmMGsddlCjJk05JS+t0+0gQiH0LWK1QnI=;
 b=awb4dUs2b3TNrLaeg7rsU2ATiccUX4K4OelfTi9RYOrw1bnvukyQaHHgdpiAPkSQiPQ8bitNE9PZGAJqPViUvEwP8QYfBTJ6Hi7+FCNSmp87O11hlVSyuotzfezDVwsYUJtQ9TRIZEz9itY7Qay8bRMnL4Q//sY0EwS2Tuem2nb3Q+kj2YoC6kxwnPERNg13S2190ScrUKtwhpzUYcHEprJiIk4BaHXL/djNejEorQFaEseMTPH/PbJdRikM9Y22X+vJdHt8/TEPiTk/TTaXDO0FPrQNLr9NVI+aXi5s2Yn3FmybUnSN49911Xa4oOR5rWf5wH7ojM7s3DoI+R8cJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB7496.namprd11.prod.outlook.com (2603:10b6:510:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 17:50:07 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 17:50:06 +0000
Message-ID: <8e65c3d3-c628-2176-2fc2-a1bc675ad607@intel.com>
Date:   Thu, 20 Jul 2023 19:48:06 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230720101231.7a5ff6cd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eecb66e-7c45-4fd5-d6fe-08db8949c0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 841ddnsS9Y639+dA8n8/3HBrc02Yhugdn4UwHN0E9XxOHxB6EMSCFBBZeScpLFOGblp5K/24GHAPdH3unzWVdGrLGyCMk8p/tk4rrsTBF06mVY/nIBUcCg7jwoPZsUWzIrT0r/obhvhWD9EqgEBo/d0OHol7tUuF26alq02qx3Sep+yQlQPNLm2GzXFjonTxrwICUHdgHjiJLOq2WCWUSzWoXAIbMqTMjlQTJMDnCmlTCiSdBG7sq0NFNGyX/ds+P82Au6TiLhpLtR4qEzkO/Bz3sqPufhA25hpnndTfaNO6PSRvh3riP7EPTiCeMr2trheRMNiEcBszEpkgT3/bJ2orh5jIS4atkArgKXwTzZmHIV1rC82K2pw8XwFx1vQBWij/jUBMqwGjIVNKP+ABBJVmFwoDO2Vzbr9C43wHgcl3r70BA+YxHjpioISeGCel46/4U1EMo7FiUkY5C1kk9Ktj8KONYml/ooDpk0ka8++mUqu4rFpJiWYM8gkYueUC8pEg7Epag4NHl1GxymMlqdfxtrA02wFO58qJqgY+SQBpAMz0SQJ4aNnvC4Ui+Zkw4pIjB39lRV7d2c6YZJ4god0s/+53+4ResmlGxMXsZA5uHW8ABpaW1vKqgTcczDkmNJxIs9Z2Vh0wBe0OCYoNiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(2906002)(83380400001)(2616005)(86362001)(31696002)(36756003)(82960400001)(38100700002)(4326008)(66476007)(6916009)(66946007)(66556008)(316002)(41300700001)(186003)(6506007)(26005)(478600001)(31686004)(6512007)(6486002)(54906003)(8936002)(8676002)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FMS3RTclVubUZPSlBGWkJoNmRIVWUvWHRYQ2dUdElQOFVEUVVPMWNFeWJN?=
 =?utf-8?B?ajJqS2oxbDZJS3BWNisrSnRpUjJMSlRZVjJCcVdiRk1tbGlLTjZvL05MNWU0?=
 =?utf-8?B?NHhnNEVnZ1ZyM282TWJRM3NzTXpYNTdiUHh5TmtrQzRkcGhiN1BzKy9ESnJa?=
 =?utf-8?B?czN3NTJmd2RaQ21YNkpsYVI5b280RE00RFVJOEU5Y29vS1lsR2VuUTNGOHNs?=
 =?utf-8?B?aHNFWWx5c0kxSHI3VEF3NVRRZXFmcUN4OS84MStrdzBaRWFseTZZVFNOUnZT?=
 =?utf-8?B?T2R0aENmVHFxcWluOXA3M3dZT0R1NXYrOXNuS0Y1V1A2akFiL3RiTXVLTzBm?=
 =?utf-8?B?NUsrQnEzbStKTkptQXZpNHhlcEp4TmpWbytrQ1pEUVMxMm5tUU05WWY5cnFB?=
 =?utf-8?B?SGNvMzVyZVVEdnlidEY5YU5nTHBNV3IyLzFPT0dDbHRHQ202WjJhNlZRVHJt?=
 =?utf-8?B?WHd0OWxpWjhXRlh3dTdDeXFmeUl5Y3lKWVYrenhwby9wZmRseVBaaGRrSkw3?=
 =?utf-8?B?ZlhlN3l5ekUwV3p6M1BIdU91UWVkUTFZMmZEMGlQTTB4NEdrb0JFb0lkQTBt?=
 =?utf-8?B?WmQwUWgyc0FxSlR3RitDUDBQMjZMR2dmSlBKSHlGbU0xNWdoaksyaVBYYmE5?=
 =?utf-8?B?ZWUyMm1NUzZoditPZ3lRR0NVOUNUejJGZDhVREtmVXkyTzRqVjFRUVJpQVla?=
 =?utf-8?B?MnJSUXQxVU4xQVpWYVRlRmNralJaTVpHbDBmUVpIMXI5U2ZDSE9yNGNNczJj?=
 =?utf-8?B?WjlINTBuQXJSZTdJZENTVHg0K1hnVGdoMVVjN0E3MGsyZ1dab08vZXY1Y01C?=
 =?utf-8?B?eG43cHVTRHo1c3FCYUdkZ1NUN0pNTFRhVUtDZFNSZVBzWHJURHpqOWRUSFJG?=
 =?utf-8?B?bWlLNWhUbzhKeFBGVHNEWG1kenAwbVIxL0RVcUxmY2w0OUpCSFZpU3BTS2Zl?=
 =?utf-8?B?UDlMWnd6YkdQaDZWTEZjTDRxOGdsdXluOEovWGFKTEJrdXdpVmtyUEVFeXBl?=
 =?utf-8?B?c25tL2g1WGVBUGZjbjFscE9tcXcwNjU4cVYvTG9QZE9yQ2VzN1ZGdk5rdjN6?=
 =?utf-8?B?alBOd2J1T2E4ck5HN3QyYmozekV4emkvNmdDOTlqbTV3R3JIMFJjNlp1Ymxh?=
 =?utf-8?B?ODJjT2djeDEvSkRSY1NBS1RTQ1phS3ZnWlBuM2d0bXN1MDBxc2ZhY1oydTdQ?=
 =?utf-8?B?dFcycjBRd2hDL0NPZUlhNFhGVVphS1VhZldRdlZXbW51SG1uQlpzblFjRVlC?=
 =?utf-8?B?WlFXbWVGcm1ZaVhqcWJCbDNGU2xoRGhnTXlyNkdEUWU5dTZ5dURVdUJmdTZ2?=
 =?utf-8?B?Qk92bzNSVVpXZFRTam53RGx5OC8wQUMyT3EyUFF3c0tVSGVQbUFVQk1aUmd6?=
 =?utf-8?B?VFJPbWR4R1kydFVMZktWU0lzQlZ5TU1wREdab01OSnVhbWJxV3YzWitSN1FG?=
 =?utf-8?B?MFI4eGdJTW0ydFltTy9RMGpnVkpHMno5RG83TU41UEJLNlYvNS83RGFkbTdy?=
 =?utf-8?B?U1hETkhVVGFPck1aWjRSd3lYMnZHaXgxMFkvVzkrZzlTUXJ6ZEZCRWl5Vmxl?=
 =?utf-8?B?ekU2Mm1Jc3Fqc0hWUnd6M2w5RVpqMHZjcWxWakpLbE5mdXRpQkU5UWJ0czhn?=
 =?utf-8?B?bHlzVGhLeFFGY1Y3aGY3RGsxOUx2SUdiQmZZMWNBTFExclMveHNmc1BDUkdY?=
 =?utf-8?B?SDg4VUtCZDdKSG5vd093RHhMK2lzekJHTDEzV25RQ2hJRzBzakFuK2UvVjNF?=
 =?utf-8?B?em0wTm9pYS9QQ0hyaU5YNFVxcHhhTWdaMkpBQWg5cWdSZmZBbExaQXM3bkRk?=
 =?utf-8?B?VkU4eExTV0FVZ1R0cEJLZFBKbkVTWVgzUkMwMVlaYUxmVHlWZzdKQ0x5SGlK?=
 =?utf-8?B?TXFaaEhNMGpIcSsvNkxMbkZ5SmRPeDhHbHV2WHJ3VWl5dGFwTnVxWlk2TjN6?=
 =?utf-8?B?U3lMZUtkbXllcFh1S1VhMzV1MEc5TVphUE1jSm1NUXpadGd6OTFzbHEwRDFZ?=
 =?utf-8?B?c3ZYemxDenVpRm5ySTRXYS8reTk0SG5LRU0rdVlYZlNJQm5KbEZBc1pMMkpp?=
 =?utf-8?B?YWFPNkRZNDdlZ29MTGxLZk5yOGxRWU5mbSsvSzh2akphS1VRQm9wamNuL25F?=
 =?utf-8?B?b1NveWs2dVluaEswb3RjNEJSOERaa3N4bXI4OTZwaC9pZU1Kb3hTVVBOOUlD?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eecb66e-7c45-4fd5-d6fe-08db8949c0a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 17:50:06.4412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBIGlJjkQLU4TjVe1cFFnGc2fQuJX0HqjJ5+vbG/W0AJapQNLajHCd4H/ctq/obvOQJirrRam//AWZT00DoeSbO7aNVtbXH5AlH4zD7EYHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7496
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 20 Jul 2023 10:12:31 -0700

> On Thu, 20 Jul 2023 18:46:02 +0200 Alexander Lobakin wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>> Date: Wed, 19 Jul 2023 13:51:50 -0700
>>
>>> On Wed, 19 Jul 2023 18:34:46 +0200 Alexander Lobakin wrote:  
>>  [...]  
>>>>
>>>> If we're on the same CPU where the NAPI would run and in the same
>>>> context, i.e. softirq, in which the NAPI would run, what is the problem?
>>>> If there really is a good one, I can handle it here.  
>>>
>>> #define SOFTIRQ_BITS		8
>>> #define SOFTIRQ_MASK		(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
>>> # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
>>> #define in_softirq()		(softirq_count())  
>>
>> I do remember those, don't worry :)
>>
>>> I don't know what else to add beyond that and the earlier explanation.  
>>
>> My question was "how can two things race on one CPU in one context if it
>> implies they won't ever happen simultaneously", but maybe my zero
>> knowledge of netcons hides something from me.
> 
> One of them is in hardirq.

If I got your message correctly, that means softirq_count() can return
`true` even if we're in hardirq context, but there are some softirqs
pending? I.e. if I call local_irq_save() inside NAPI poll loop,
in_softirq() will still return `true`? (I'll check it myself in a bit,
but why not ask).
Isn't checking for `interrupt_context_level() == 1` more appropriate
then? Page Pool core code also uses in_softirq(), as well as a hellaton
of other networking-related places.


> 
>>> AFAIK pages as allocated by page pool do not benefit from the usual
>>> KASAN / KMSAN checkers, so if we were to double-recycle a page once
>>> a day because of a netcons race - it's going to be a month long debug
>>> for those of us using Linux in production.  
>>
>> if (!test_bit(&napi->state, NPSVC))
> 
> if you have to the right check is !in_hardirq()
> 
>> ? It would mean we're not netpolling.
>> Otherwise, if this still is not enough, I'do go back to my v1 approach
>> with having a NAPI flag, which would tell for sure we're good to go. I
>> got confused by your "wouldn't just checking for softirq be enough"! T.T
>> Joking :D
> 
> I guess the problem I'm concerned about can already happen.
> I'll send a lockdep annotation shortly.

Interesten.

Thanks,
Olek
