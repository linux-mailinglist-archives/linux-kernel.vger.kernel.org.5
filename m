Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8159774C6E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbjHHVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjHHVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:08:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419EFA146;
        Tue,  8 Aug 2023 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691528111; x=1723064111;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3zMyz2/nzWIOsu7qzewAbMuRPRFkCqSCEjHdHesulJo=;
  b=gHFlAMdWFHoCIm73aDduaPsPV/1U9q4l72ruo1M8bXy5Rlt/UaKbo+cU
   1wHW3S/uT4TsqGe6cWWbEDYIJ6HflFrQbuudq3XlO99ecGKgjxdi9/ws/
   KCBf74hUvDDYAipeITYoJ0A5+bOnC6WBgDnRjjt5DVmgcE+z1scbzV+pb
   w7H1+aVaciNak7yJ8s+wUR+M9ndbt1zOZtwY7mx1vziE2BJG48mgmAjD6
   p1P1jCRAKHleAT1l0fShBvby3NEGXaW4+azoSjgvXlw96p0fIRc0zQjMp
   qORa5AUpD3vP9hccuV8/mtPbPs/7dGEzmEVg3RcgIVJ+l339I9tc/E8tU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351260352"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="351260352"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 13:55:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801472101"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="801472101"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 13:55:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 13:55:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 13:55:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 13:55:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 13:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nltswD6y2gpdPPYLQWpOubh4cktZZhZsbeDsdGEns6U8+V0hsuVHKSR8/r1+M1VN3M8IjDfATh9+gtZgtXNmT1HOY+MBV2l7fD3nVG5wgfjbnxA74t3dj+KenAwFLpEFz23oMLd+jsS06+MaGzdzEhzz8CH3xkzacwjLE42zGkU1YrOFa7o+qx+GpQG54x0s92S0DEDY0GM0vw0LbH9BZiAOi/tiTYuCcNw+1CQOGBUWoZpjx4BNxDDyKbSqBE4vkxi6Kf+IPHEmsICOkAzFJ2B8fMJHJKTmsjFy0l7y+sg3PudEY24OTj/cBOB91DO/VPtJIGdefBxqF9hqY2zYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zMyz2/nzWIOsu7qzewAbMuRPRFkCqSCEjHdHesulJo=;
 b=RTveazuVx+hOa+oMGnCeseG0NDv7Lxb4PaBZ79n4+2tpDmCDdZUJFo0samLqIZWeBxMSWZA4FoxurSTlTPQXLkRtyQoXR8VMUVTSyiuI28KnwmImoqeolK2xhAxIvliumsmuoO48c45272Ap0KNBtqyKl/eTsSH3fbI6gPjy827keo95Ame6oVHkzMOVp549vkSvZs2mmMiPVDzuAWkfW9hz1JPVSMHntTYbLoDVBZx1r7ovS4lcdkc1Tq2gxySvWd2bz+jaqDfPunub3l/aBWohZsYHXR1g7vcYuaCCzUN1uhAEosZIxEsz8zda7htk7XTEqVwLEDYl17HmhQxz1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 20:55:05 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 20:55:05 +0000
Message-ID: <7cf9f840-f47c-bc79-6c14-9f1997a21c5a@intel.com>
Date:   Tue, 8 Aug 2023 22:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net 2/2] ice: Fix NULL pointer deref
 during VF reset
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <slawomirx.laba@intel.com>, <przemyslawx.patynowski@intel.com>,
        <kamil.maziarz@intel.com>, <jesse.brandeburg@intel.com>,
        <norbertx.zulinski@intel.com>, <dawidx.wesierski@intel.com>,
        <edumazet@google.com>, <anthony.l.nguyen@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
References: <20230807094831.696626-1-poros@redhat.com>
 <20230807094831.696626-3-poros@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230807094831.696626-3-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|IA1PR11MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 81303107-2284-4542-c3c0-08db9851bdfd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXKuGymJl5xxmTCVEMYuNxCr+i+zHFWipzwCUH9Izc6lh5NKJHFXczN9j88wvbvnGKfqg8laIl3o4xD/rqkAJgBTsCcb+K1qXa/4DJUxKKGI7WrTL7J5BQ+bJl+DRAF82Yy8jaSlwKYCaE2l/kEB2GzSdqqP6xIyE+Fz8fzPXMrFtjNJgO8M3kjSZRw95nWzq4H0yvLrlWWwSpq6CC2J4LV+cmm3S2HA8c6tZRP7OZrxZeVaaIOoL1tSclvzLHiHl+3qXxO7+B2lW2cy34U2VAvh8p+uzxW+iA7lcmAXVMr9BlSktzSVmxyeHzam1TMCyjfZUbuZ5ieIeEQI0sAt2uyFft0cLatWC6xOCkvXzjnXIRnJd5BlKShdXxnS5e+5qvZvp+grPuKODx3UuS5utXoL2xbYsv7BSL1WWbaBk0TOMYiFRjvgu7vzzLYkIQ6A7psVN4a05TzvW+vwXmA70JLukbfChPK1aRZTbPpbuhLnE5nzuE2rMb1qShbdEBNBKGtrWAPL4Qfmt/uSRFqowHv07TbJ5V4FcHq/aAReTt7cEpzB8bLylV8FB0NoVG/8fiJ/7246f/8Re4UWOEu0qWR1Qa4qxcuQT+VKGkmAsdIiGZsKab94QNxkla+LxbyqWCYRlvwEuhm5E4ZesuoImw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(186006)(1800799003)(2616005)(6486002)(6666004)(6512007)(478600001)(82960400001)(31696002)(45080400002)(26005)(6506007)(36756003)(53546011)(86362001)(41300700001)(316002)(8936002)(8676002)(2906002)(4326008)(66556008)(66946007)(38100700002)(5660300002)(66476007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0xrNWZwbkEzUmVVcHcrUkJsUFdxSlVXUG03UGM3Z3VaWFBJeVJEdWwybzJG?=
 =?utf-8?B?dG4yM2EvWmIzaEltZDU4Y0p1dHQ5bWFHQzRCTk00WnFHbTVRSTBBcDE4Skto?=
 =?utf-8?B?RHhWWld6RWlsazF3djlkdHRTQWYxbUo1WVhWTlVWZ0NlSmNlSTI5NXVwNVFp?=
 =?utf-8?B?QVlmWHhaRi9rclIraktqaVlwdWdiZnRmRElsTXhaVWl3NGxuOFhLdklGd3cz?=
 =?utf-8?B?V3NMN3plSk9iUndMK29LSTY4MjZ2SDhtWWdBNEdDTjc3ZEVDcHAvYmhpbUhy?=
 =?utf-8?B?UlVNdFBWa2h0VmF4T0hHVGZyREZJZjFEZTZadVQ4bzFzd3I0dWZ0bk90dnFW?=
 =?utf-8?B?UiswdEI1bFdQMUM0S3JiSjVFcVJhK2cvdDF6OEFqMU1yb0tsNUZHUnJGM1h2?=
 =?utf-8?B?UU1NcEdrdVpKU29ad3ZUdW0xNFBCb0JrZmVBdS8wOW9Ha3dwM2NtcXA1eFh5?=
 =?utf-8?B?eW5xcThLNUR3YVRGMVFFd0Y4VkU5bFNwdHRrdUxXZ1UvN0dMVk5rSnRqdUpr?=
 =?utf-8?B?ZEd0bG4yaTNmN1d5MFRUYjk0MlNiYmVVdTFFSTVwUVh1YzZMZFpOdVBlQUF0?=
 =?utf-8?B?azJYWUIyWHVvSExjbzZZbGI4QXVSc2dZU0VXbDd5TDl2TndvYWNWOFFEZlVi?=
 =?utf-8?B?TnZxa3NvNTZnZWxHdHlWL0JoQVRrM3RRY0NOOE4xUmIyVyticDZjbXh3VUtQ?=
 =?utf-8?B?M1FMMEF6dGRrZ3BYeXJISWs5V0VJNFdSRTJwenY5ZkVNM2pkQXBWcTY0cFhh?=
 =?utf-8?B?Sy9RR05xUU5FZ3haQlBLS1E4bmFmaE55T2tRcm1xb0tMZ04rUG9HWkJ0UzVL?=
 =?utf-8?B?M2p0Uk0zMUlIcEQ1NkdWaDE5MFZ5ZlFORStxc0pDaXpCU2dpdzhiNkorWGRX?=
 =?utf-8?B?Tmt6dnlUK0ZIaFRxYjhQaDFvSkdNam0vTWV3MXk2MHlwZ1JpN3ZnaVpQU2Ru?=
 =?utf-8?B?UVA2em1oaEZRbUFwMzBMc1haS1V2Z2krTXpKMzlFMGpGMFNwM1JtNWM5L0pY?=
 =?utf-8?B?UWhWRmpjQlYrY1IrQytEL1JHTFZYblBiK0tOc2VrZFFFd1g1aEdWUWppRy96?=
 =?utf-8?B?dXR5ZjMyOWxVNnFnUVZZdG1tL21iaU82ZkZOREEzRXlvUGR1SFdzMENxN0l5?=
 =?utf-8?B?YUU1QzNReTZCb2t6VWlIaTNZRDlEQ2NqWkR2amFIWmNjYldjejIzNU1MWVhy?=
 =?utf-8?B?aDBhVmhUdkFyUTVDM2JNTzc5Z2NjN3EzMS9aTmNmWi9WWHNPUXM4YU9oUitz?=
 =?utf-8?B?VmlyVEtDeER0QXd1Qmt1MHZBODV2YVVzRDc4bDRGNDhsVlgxcFR5dTZDdVJU?=
 =?utf-8?B?dEY4VXJJSlFJODI2aVh2NCtJeCtlbUpXMHhtOFQwNWQrMkFOSFE0RDI0aVpQ?=
 =?utf-8?B?QXZNSS9zd1V5bE9PZ2ZUQW5nUU1JdDd0L0IrYVlvNlcvd3R2cTUrMDQ4WlI0?=
 =?utf-8?B?S2xBRjRqeC9EMDJHT2ZSR0tJQTNMbVJqWU5MVGd5a1ZmZ1RSSWF0eFI1c25x?=
 =?utf-8?B?SWc4bEY0YzBzdjZiVkduTnJqS244SDdKeFV0UmQrZ0NRQm1uNkFKcThoSEg5?=
 =?utf-8?B?YVNmck8rcFBkSjAzTW1HYjFTdG15MUF3NmZVa2Yrb242VmRBUW0wVUVmcXF3?=
 =?utf-8?B?akRhenJIR2l6Mi9paDFBQ2IwVmR5c3M2ajNJS09oVkFrWk1lODR0bEN2T05t?=
 =?utf-8?B?ZUt5b01Td01DSkNSdk1ybTQ1OWE2ZlE1S1lRekN0M01VVzlna3dLMC9adHJZ?=
 =?utf-8?B?bVYyVnFacE5RWWNpd0dzbkhwZTdsYi8xOVJTYnpuVjMvYTRtZkhnTzB2QzR4?=
 =?utf-8?B?Mk9tMVdsQ1MxKzZlbks0dnBXQVhyVDllQkhkYzhQU3NKWGlCbWRHNVpzaVM0?=
 =?utf-8?B?aXhsTUpTVlBLNUt3cGRhSUt6L3VCaWdGQmZ6TXN3NllLQUticVRYdkRqRE93?=
 =?utf-8?B?SzZhNDhzU1VwSTA2OUVYUW03ektzTXBxRCtZM1hFUEZRd1BnSHZPQUZqSXRN?=
 =?utf-8?B?bmI4NTJYeEJwZklFNW5uYmtKcE8zNGdaaWlmS2xEZlllcGc5K1RmTVhvbUgv?=
 =?utf-8?B?cUgyMGd1Y3MwVTBBKzA3Q09Vbk5WVDc3U1I0NmpDQkhxU0Rta01yMS9Qdko4?=
 =?utf-8?B?bThLSnlGS05BeFRUaHBIeDh2bVBQMy9mblFGd0RpelMyTkhaT0Ewb282NDRJ?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81303107-2284-4542-c3c0-08db9851bdfd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:55:05.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXMTyKbbUgHNnFu2HxzPFSfuJvZpmN9BxavMYTcIvvGk8+vJKxofZBVXPWLKK9rMTBAnFEkjzFil+HtIxxiK0mXwe77//MuNHEzp9MbcRcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC83LzIzIDExOjQ4LCBQZXRyIE9yb3Mgd3JvdGU6DQo+IER1cmluZyBzdHJlc3MgdGVzdCB3
aXRoIGF0dGFjaGluZyBhbmQgZGV0YWNoaW5nIFZGIGZyb20gS1ZNIGFuZA0KPiBzaW11bHRhbmVv
dXNseSBjaGFuZ2luZyBWRnMgc3Bvb2ZjaGVjayBhbmQgdHJ1c3QgdGhlcmUgd2FzIGENCj4gTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGljZV9yZXNldF92ZiB0aGF0IFZGJ3MgVlNJIGlzIG51
bGwuDQo+IA0KPiBNb3JlIHRoYW4gb25lIGluc3RhbmNlIG9mIGljZV9yZXNldF92ZigpIGNhbiBi
ZSBydW5uaW5nIGF0IGEgZ2l2ZW4NCj4gdGltZS4gV2hlbiB3ZSByZWJ1aWxkIHRoZSBWU0kgaW4g
aWNlX3Jlc2V0X3ZmLCBhbm90aGVyIHJlc2V0IGNhbiBiZQ0KPiB0cmlhZ2VkIGZyb20gaWNlX3Nl
cnZpY2VfdGFzay4gSW4gdGhpcyBjYXNlIHdlIGNhbiBhY2Nlc3MgdGhlIGN1cnJlbnRseQ0KPiB1
bmluaXRpYWxpemVkIFZTSSBhbmQgY291c2UgcGFuaWMuIFRoZSB3aW5kb3cgZm9yIHRoaXMgcmFj
aW5nIGNvbmRpdGlvbg0KPiBoYXMgYmVlbiBhcm91bmQgZm9yIGEgbG9uZyB0aW1lIGJ1dCBpdCdz
IG11Y2ggd29yc2UgYWZ0ZXIgY29tbWl0DQo+IDIyN2JmNDUwMGFhYSAoImljZTogbW92ZSBWU0kg
ZGVsZXRlIG91dHNpZGUgZGVjb25maWciKSBiZWNhdXNlDQo+IHRoZSByZXNldCBydW5zIGZhc3Rl
ci4gaWNlX3Jlc2V0X3ZmKCkgdXNpbmcgdmYtPmNmZ19sb2NrIGFuZCB3aGVuDQo+IHdlIG1vdmUg
dGhpcyBsb2NrIGJlZm9yZSBhY2Nlc3NpbmcgdG8gdGhlIFZGIFZTSSwgd2UgY2FuIGZpeA0KPiBC
VUcgZm9yIGFsbCBjYXNlcy4NCj4gDQo+IFBhbmljIG9jY3VycyBzb21ldGltZXMgaW4gaWNlX3Zz
aV9pc19yeF9xdWV1ZV9hY3RpdmUoKSBhbmQgc29tZXRpbWVzDQo+IGluIGljZV92c2lfc3RvcF9h
bGxfcnhfcmluZ3MoKQ0KPiANCj4gV2l0aCBvdXIgcmVwcm9kdWNlciwgd2UgY2FuIGhpbnQgQlVH
Og0KDQpzL2hpbnQvaGl0Lw0KDQo+IH44aCBiZWZvcmUgY29tbWl0IDIyN2JmNDUwMGFhYSAoImlj
ZTogbW92ZSBWU0kgZGVsZXRlIG91dHNpZGUgZGVjb25maWciKS4NCj4gfjIwbSBhZnRlciBjb21t
aXQgMjI3YmY0NTAwYWFhICgiaWNlOiBtb3ZlIFZTSSBkZWxldGUgb3V0c2lkZSBkZWNvbmZpZyIp
Lg0KPiBBZnRlciB0aGlzIGZpeCB3ZSBhcmUgbm90IGFibGUgdG8gcmVwcm9kdWNlIGl0IGFmdGVy
IH40OGgNCj4gDQo+IFRoZXJlIHdhcyBjb21taXQgY2Y5MGI3NDM0MWVlICgiaWNlOiBGaXggY2Fs
bCB0cmFjZSB3aXRoIG51bGwgVlNJIGR1cmluZw0KPiBWRiByZXNldCIpIHdoaWNoIGFsc28gdHJp
ZWQgdG8gZml4IHRoaXMgaXNzdWUsIGJ1dCBpdCB3YXMgb25seQ0KPiBwYXJ0aWFsbHkgcmVzb2x2
ZWQgYW5kIHRoZSBidWcgc3RpbGwgZXhpc3RzLg0KPiANCj4gWyA2NDIwLjY1ODQxNV0gQlVHOiBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAwMDAwMDAwMDAwMDAwMDAw
DQo+IFsgNjQyMC42NjUzODJdICNQRjogc3VwZXJ2aXNvciByZWFkIGFjY2VzcyBpbiBrZXJuZWwg
bW9kZQ0KPiBbIDY0MjAuNjcwNTIxXSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVz
ZW50IHBhZ2UNCj4gWyA2NDIwLjY3NTY1OV0gUEdEIDANCj4gWyA2NDIwLjY3NzY3OV0gT29wczog
MDAwMCBbIzFdIFBSRUVNUFQgU01QIE5PUFRJDQo+IFsgNjQyMC42ODIwMzhdIENQVTogNTMgUElE
OiAzMjY0NzIgQ29tbToga3dvcmtlci81MzowIEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQgNS4x
NC4wLTMxNy5lbDkueDg2XzY0ICMxDQo+IFsgNjQyMC42OTEyNTBdIEhhcmR3YXJlIG5hbWU6IERl
bGwgSW5jLiBQb3dlckVkZ2UgUjc1MC8wNFY1MjgsIEJJT1MgMS42LjUgMDQvMTUvMjAyMg0KPiBb
IDY0MjAuNjk4NzI5XSBXb3JrcXVldWU6IGljZSBpY2Vfc2VydmljZV90YXNrIFtpY2VdDQo+IFsg
NjQyMC43MDM0NjJdIFJJUDogMDAxMDppY2VfdnNpX2lzX3J4X3F1ZXVlX2FjdGl2ZSsweDJkLzB4
NjAgW2ljZV0NCj4gWyA2NDIwLjcwNTg2MF0gaWNlIDAwMDA6Y2E6MDAuMDogVkYgMCBpcyBub3cg
dW50cnVzdGVkDQo+IFsgNjQyMC43MDk0OTRdIENvZGU6IDAwIDAwIDY2IDgzIGJmIDc2IDA0IDAw
IDAwIDAwIDQ4IDhiIDc3IDEwIDc0IDNlIDMxIGMwIGViIDBmIDBmIGI3IDk3IDc2IDA0IDAwIDAw
IDQ4IDgzIGMwIDAxIDM5IGMyIDdlIDJiIDQ4IDhiIDk3IDY4IDA0IDAwIDAwIDwwZj4gYjcgMGMg
NDIgNDggOGIgOTYgMjAgMTMgMDAgMDAgNDggOGQgOTQgOGEgMDAgMDAgMTIgMDAgOGIgMTIgODMN
Cj4gWyA2NDIwLjcxNDQyNl0gaWNlIDAwMDA6Y2E6MDAuMCBlbnM3ZjA6IFNldHRpbmcgTUFDIDIy
OjIyOjIyOjIyOjIyOjAwIG9uIFZGIDAuIFZGIGRyaXZlciB3aWxsIGJlIHJlaW5pdGlhbGl6ZWQN
Cj4gWyA2NDIwLjczMzEyMF0gUlNQOiAwMDE4OmZmNzc4ZDJmZjM4M2ZkZDggRUZMQUdTOiAwMDAx
MDI0Ng0KPiBbIDY0MjAuNzMzMTIzXSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZjJhY2Yx
OTE2Mjk0MDAwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KPiBbIDY0MjAuNzMzMTI1XSBSRFg6IDAw
MDAwMDAwMDAwMDAwMDAgUlNJOiBmZjJhY2YxZjJjNjQwMWEwIFJESTogZmYyYWNmMWEyNzMwMTgy
OA0KPiBbIDY0MjAuNzYyMzQ2XSBSQlA6IGZmMmFjZjFhMjczMDE4MjggUjA4OiAwMDAwMDAwMDAw
MDAwMDEwIFIwOTogMDAwMDAwMDAwMDAwMTAwMA0KPiBbIDY0MjAuNzY5NDc2XSBSMTA6IGZmMmFj
ZjE5MTYyODYwMDAgUjExOiAwMDAwMDAwMDAxOWViYTNmIFIxMjogZmYyYWNmMTkwNjY0NjBkMA0K
PiBbIDY0MjAuNzc2NjExXSBSMTM6IGZmMmFjZjFmMmM2NDAxYTAgUjE0OiBmZjJhY2YxZjJjNjQw
MWEwIFIxNTogMDAwMDAwMDBmZmZmZmZmZg0KPiBbIDY0MjAuNzgzNzQyXSBGUzogIDAwMDAwMDAw
MDAwMDAwMDAoMDAwMCkgR1M6ZmYyYWNmMjhmZmE4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAw
MDAwMDAwDQo+IFsgNjQyMC43OTE4MjldIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6
IDAwMDAwMDAwODAwNTAwMzMNCj4gWyA2NDIwLjc5NzU3NV0gQ1IyOiAwMDAwMDAwMDAwMDAwMDAw
IENSMzogMDAwMDAwMTZhZDQxMDAwMyBDUjQ6IDAwMDAwMDAwMDA3NzNlZTANCj4gWyA2NDIwLjgw
NDcwOF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAw
MDAwMDAwMDAwMDAwMDANCj4gWyA2NDIwLjgxMTAzNF0gdmZpby1wY2kgMDAwMDpjYTowMS4wOiBl
bmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikNCj4gWyA2NDIwLjgxMTg0MF0gRFIzOiAwMDAw
MDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAN
Cj4gWyA2NDIwLjgxMTg0MV0gUEtSVTogNTU1NTU1NTQNCj4gWyA2NDIwLjgxMTg0Ml0gQ2FsbCBU
cmFjZToNCj4gWyA2NDIwLjgxMTg0M10gIDxUQVNLPg0KPiBbIDY0MjAuODExODQ0XSAgaWNlX3Jl
c2V0X3ZmKzB4OWEvMHg0NTAgW2ljZV0NCj4gWyA2NDIwLjgxMTg3Nl0gIGljZV9wcm9jZXNzX3Zm
bHJfZXZlbnQrMHg4Zi8weGMwIFtpY2VdDQo+IFsgNjQyMC44NDEzNDNdICBpY2Vfc2VydmljZV90
YXNrKzB4MjNiLzB4NjAwIFtpY2VdDQo+IFsgNjQyMC44NDU4ODRdICA/IF9fc2NoZWR1bGUrMHgy
MTIvMHg1NTANCj4gWyA2NDIwLjg0OTU1MF0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxZTIvMHgzYjAN
Cj4gWyA2NDIwLjg1MzU2M10gID8gcmVzY3Vlcl90aHJlYWQrMHgzOTAvMHgzOTANCj4gWyA2NDIw
Ljg1NzU3N10gIHdvcmtlcl90aHJlYWQrMHg1MC8weDNhMA0KPiBbIDY0MjAuODYxMjQyXSAgPyBy
ZXNjdWVyX3RocmVhZCsweDM5MC8weDM5MA0KPiBbIDY0MjAuODY1MjUzXSAga3RocmVhZCsweGRk
LzB4MTAwDQo+IFsgNjQyMC44Njg0MDBdICA/IGt0aHJlYWRfY29tcGxldGVfYW5kX2V4aXQrMHgy
MC8weDIwDQo+IFsgNjQyMC44NzMxOTRdICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiBbIDY0
MjAuODc2Nzc0XSAgPC9UQVNLPg0KPiBbIDY0MjAuODc4OTY3XSBNb2R1bGVzIGxpbmtlZCBpbjog
dmZpb19wY2kgdmZpb19wY2lfY29yZSB2ZmlvX2lvbW11X3R5cGUxIHZmaW8gaWF2ZiB2aG9zdF9u
ZXQgdmhvc3Qgdmhvc3RfaW90bGIgdGFwIHR1biB4dF9DSEVDS1NVTSB4dF9NQVNRVUVSQURFIHh0
X2Nvbm50cmFjayBpcHRfUkVKRUNUIG5mX3JlamVjdF9pcHY0IG5mdF9jb21wYXQgbmZ0X2NoYWlu
X25hdCBuZl9uYXQgbmZfY29ubnRyYWNrIG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0IG5m
dF9jb3VudGVyIG5mX3RhYmxlcyBicmlkZ2Ugc3RwIGxsYyBzY3RwIGlwNl91ZHBfdHVubmVsIHVk
cF90dW5uZWwgbmZwIHRscyBuZm5ldGxpbmsgYmx1ZXRvb3RoIG1seDRfZW4gbWx4NF9jb3JlIHJw
Y3NlY19nc3Nfa3JiNSBhdXRoX3JwY2dzcyBuZnN2NCBkbnNfcmVzb2x2ZXIgbmZzIGxvY2tkIGdy
YWNlIGZzY2FjaGUgbmV0ZnMgcmZraWxsIHN1bnJwYyBpbnRlbF9yYXBsX21zciBpbnRlbF9yYXBs
X2NvbW1vbiBpMTBubV9lZGFjIG5maXQgbGlibnZkaW1tIGlwbWlfc3NpZiB4ODZfcGtnX3RlbXBf
dGhlcm1hbCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1wIGlyZG1hIGt2bV9pbnRlbCBpNDBlIGt2
bSBpVENPX3dkdCBkY2RiYXMgaWJfdXZlcmJzIGlycWJ5cGFzcyBpVENPX3ZlbmRvcl9zdXBwb3J0
IG1nYWcyMDAgbWVpX21lIGliX2NvcmUgZGVsbF9zbWJpb3MgaXNzdF9pZl9tbWlvIGlzc3RfaWZf
bWJveF9wY2kgcmFwbCBpMmNfYWxnb19iaXQgZHJtX3NobWVtX2hlbHBlciBpbnRlbF9jc3RhdGUg
ZHJtX2ttc19oZWxwZXIgc3lzY29weWFyZWEgc3lzZmlsbHJlY3QgaXNzdF9pZl9jb21tb24gc3lz
aW1nYmx0IGludGVsX3VuY29yZSBmYl9zeXNfZm9wcyBkZWxsX3dtaV9kZXNjcmlwdG9yIHdtaV9i
bW9mIGludGVsX3ZzZWMgbWVpIGkyY19pODAxIGFjcGlfaXBtaSBpcG1pX3NpIGkyY19zbWJ1cyBp
cG1pX2RldmludGYgaW50ZWxfcGNoX3RoZXJtYWwgYWNwaV9wb3dlcl9tZXRlciBwY3Nwaw0KPiAg
IHINCj4gDQo+IEZpeGVzOiBlZmU0MTg2MDAwOGUgKCJpY2U6IEZpeCBtZW1vcnkgY29ycnVwdGlv
biBpbiBWRiBkcml2ZXIiKQ0KPiBGaXhlczogZjIzZGY1MjIwZDJiICgiaWNlOiBGaXggc3B1cmlv
dXMgaW50ZXJydXB0IGR1cmluZyByZW1vdmFsIG9mIHRydXN0ZWQgVkYiKQ0KPiBTaWduZWQtb2Zm
LWJ5OiBQZXRyIE9yb3MgPHBvcm9zQHJlZGhhdC5jb20+DQoNClRoYW5rIHlvdSBmb3IgYWxsIG9m
IHlvdXIgdGVzdGluZyBlZmZvcnRzLCBkZXRhaWxlZCBleHBsYW5hdGlvbiwNCmFuZCB0aGUgZml4
IQ0KDQpJcyB0aGVyZSBhbnl0aGluZyBpbnRlcmVzdGluZyBhYm91dCB5b3VyIHNldHVwL21ldGhv
ZG9sb2d5Pw0KKEFza2luZyByYXRoZXIgdG8gZXhwbG9yZSBhbmQgZXh0ZW5kIG91ciB0ZXN0cywg
bm8gZG91YnRzIGhlcmUgOikNCg0KPiAtLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pY2UvaWNlX3ZmX2xpYi5jIHwgMTUgKysrKysrKystLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3ZmX2xpYi5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV92Zl9saWIuYw0KPiBpbmRleCAyOTRlOTFjMzQ1M2NjZC4u
ZWEzMzEwYmU4MzU0Y2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVs
L2ljZS9pY2VfdmZfbGliLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNl
L2ljZV92Zl9saWIuYw0KPiBAQCAtNjEyLDExICs2MTIsMTcgQEAgaW50IGljZV9yZXNldF92Zihz
dHJ1Y3QgaWNlX3ZmICp2ZiwgdTMyIGZsYWdzKQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgCX0NCj4g
ICANCj4gKwlpZiAoZmxhZ3MgJiBJQ0VfVkZfUkVTRVRfTE9DSykNCj4gKwkJbXV0ZXhfbG9jaygm
dmYtPmNmZ19sb2NrKTsNCj4gKwllbHNlDQo+ICsJCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJnZmLT5j
ZmdfbG9jayk7DQo+ICsNCj4gICAJaWYgKGljZV9pc192Zl9kaXNhYmxlZCh2ZikpIHsNCj4gICAJ
CXZzaSA9IGljZV9nZXRfdmZfdnNpKHZmKTsNCj4gICAJCWlmICghdnNpKSB7DQo+ICAgCQkJZGV2
X2RiZyhkZXYsICJWRiBpcyBhbHJlYWR5IHJlbW92ZWRcbiIpOw0KPiAtCQkJcmV0dXJuIC1FSU5W
QUw7DQo+ICsJCQllcnIgPSAtRUlOVkFMOw0KPiArCQkJZ290byBvdXRfdW5sb2NrOw0KPiAgIAkJ
fQ0KPiAgIAkJaWNlX3ZzaV9zdG9wX2xhbl90eF9yaW5ncyh2c2ksIElDRV9OT19SRVNFVCwgdmYt
PnZmX2lkKTsNCj4gICANCj4gQEAgLTYyNSwxNCArNjMxLDkgQEAgaW50IGljZV9yZXNldF92Zihz
dHJ1Y3QgaWNlX3ZmICp2ZiwgdTMyIGZsYWdzKQ0KPiAgIA0KPiAgIAkJZGV2X2RiZyhkZXYsICJW
RiBpcyBhbHJlYWR5IGRpc2FibGVkLCB0aGVyZSBpcyBubyBuZWVkIGZvciByZXNldHRpbmcgaXQs
IHRlbGxpbmcgVk0sIGFsbCBpcyBmaW5lICVkXG4iLA0KPiAgIAkJCXZmLT52Zl9pZCk7DQo+IC0J
CXJldHVybiAwOw0KPiArCQlnb3RvIG91dF91bmxvY2s7DQo+ICAgCX0NCj4gICANCj4gLQlpZiAo
ZmxhZ3MgJiBJQ0VfVkZfUkVTRVRfTE9DSykNCj4gLQkJbXV0ZXhfbG9jaygmdmYtPmNmZ19sb2Nr
KTsNCj4gLQllbHNlDQo+IC0JCWxvY2tkZXBfYXNzZXJ0X2hlbGQoJnZmLT5jZmdfbG9jayk7DQo+
IC0NCj4gICAJLyogU2V0IFZGIGRpc2FibGUgYml0IHN0YXRlIGhlcmUsIGJlZm9yZSB0cmlnZ2Vy
aW5nIHJlc2V0ICovDQo+ICAgCXNldF9iaXQoSUNFX1ZGX1NUQVRFX0RJUywgdmYtPnZmX3N0YXRl
cyk7DQo+ICAgCWljZV90cmlnZ2VyX3ZmX3Jlc2V0KHZmLCBmbGFncyAmIElDRV9WRl9SRVNFVF9W
RkxSLCBmYWxzZSk7DQoNCg==
