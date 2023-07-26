Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58B763C92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGZQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGZQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:34:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B18B121
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690389289; x=1721925289;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2v25SuQnfXNRswjoabtFG3SwM+rwuck40aKdAaA9zOs=;
  b=P6EkGewfNENlE3+UJN3IJlk3PeR1yaIkoXV49shpUIRknp7fGaazQxt1
   F8byBMVidTZRYzy4XutU5LANiPksXjYpsGRTgn6Wmx4DrOx+Yo3W2mRCG
   qpZW9rAft7+ZNYU6V68u517I32XH9vKelT0sfSBTubaTiCoqnizRsbKhv
   5Jh1lVMokEfLHJEnj7omDy3RikZmW5WyzD4tZbYQqtVil8kEs2vui6+u2
   dl0VIbW5YCKy/ihpKVVIP1BYmcLmZTob5kKLvD2KPOFNqugvOMvjAX1NT
   iNqdD7ZeUrN7dnrlksJDueieHWQOpRuG+jtpM731PaEvPtV0U6tnlfo/R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371680238"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371680238"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 09:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726605450"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="726605450"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 09:34:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 09:34:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 09:34:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 09:34:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 09:34:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdDGuagBS/M4QIZ+GILYgOj9mIWIxfHduqHSjg2utQje1MJcQqWvNNciVxpL8G0NCqPxBCs9Z3N4d98zMv4l6rPRHR74Muz5PeMzGdFXgtCwRGb3HsRdSnKJ1h0a/hqNt0+9NpnUOofEBycBHF13IqKx3o6Q9ONtGzTv2NfKVQTEVGM7ipemiWlP4PzXvjgO9YnII7LLmODaQK8/bvW9NJbaPMeC3MN0eRq8fjwOawxG8TaS//D0x8q43g9R2CBrYgm9Nl9MWz/evO6jtnWhriLWk+Us/shyuBKpayBavn9q3CEY6CDk/o28DJyQ+riS2E5znpoaUaGs/HZlufajbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDJwQAMQB5FYJ+buN6XQcNVWd/P/ZV7rFCvXkyswE7U=;
 b=UrSGwOBMwf3mKmbEyzKB4xT63oKO4yK5FXnuGDpJ8zAhOK/YYA1DTq4278B8YBvfbBiBygleXl/PXs1CmceBuoX9f1XL03eJn3XfDzQFaS+aUH+FGb9Qj5vWYNDIkomJKntxaO0Bkvcr6t6cVe/SarbIUfuvloFKlQ8c6icuB8UXVDcI66lw9hBjRLWCLf+d9m7AQrVhD/JUYmgoTEX4HjDzoFZQB+N9vLeyLeiMP/G29Fzf1BLXo3Wdv18lOsfq93fiKor0YC1M8p6c7cMnLd2TKI3/a+2bzpJ5xpnJVcl5M6XentMX1u1SwlaHX3h8hEULUtHqVu+GQ3X/dhPv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB6623.namprd11.prod.outlook.com (2603:10b6:a03:479::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 16:34:45 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:34:45 +0000
Message-ID: <36f996d5-bb64-85d0-0aff-4d6c31c45567@intel.com>
Date:   Wed, 26 Jul 2023 09:34:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] parport: mfc3: avoid empty-body warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
References: <20230726150944.2265044-1-arnd@kernel.org>
 <20230726150944.2265044-2-arnd@kernel.org>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230726150944.2265044-2-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: e3cce752-d091-4843-f48c-08db8df638c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIT8aD/Db/w6dNdoekukO3TK38xwsxyagTrvvsPxOOF5cecZiEufGLWvayzUeBMO+nfnPySLdM3V8GuJyNqGFxpIP9Yu6Eqzgcq6hQBlJUyL52JtXNk0y4IFYxfeJw/fsovYRP1d1do5xBzBexulwEUNdIDO+OYl2wweiyQMfWPbalTb/xb5ljegNRxfqPqTMAcCBZojFA1cCCdxPhgZFnFp2RRhVcO1HPkAmmE/CCGGrowSEvL0Wx40i7VTrzzT+Wz0zJuAZo8i3SlCYhQYWF23WhI02N3DKgnFzXFRRWSECPeqGFbo05tDi/1V1NSALO+FL+t9YndicClBtkybctLNzWB3+EFyRuqb8QU8wJIaoRV8bDnVK920Az63EjYaPMngAQT7dFDH4/OhavpBE+pKk/eNW0n5CInlp2N/DtXrBbWuRI6BJelETmxHBYgGE21gyjB4DRp/osom8Ok9V8NDXSvblNfYlf1PCyG1R1W/XiNheWJJ9zGMjmJPlbXuuhd6hH7nJoiPbDaNHZvcaoYnsenC3ux6gIATigeWqMRkZ3B17G5ixvBd8G+XK9Oh6kqmePMxdaAtlWUeAhkEni2kAa6fmZOGzJiI7DGxdYrhdX5d6ZPzEihyyxUSejPxd9BjT5FT4iQxubXDE5bKLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199021)(26005)(6506007)(41300700001)(186003)(316002)(4326008)(53546011)(2906002)(36756003)(44832011)(5660300002)(8676002)(8936002)(2616005)(6486002)(6512007)(86362001)(31696002)(31686004)(110136005)(478600001)(38100700002)(82960400001)(558084003)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RktDNnUvc0RvMUlidnZGSGNoN2ZWY0VrVmxVaWhza29EVjVxU1RZVW5CWWky?=
 =?utf-8?B?SjRjU2dLYmtHc3NuS09PSytaNW52UTlqNVJnUEl2WFU4SWlOdFhUMU1qRFJa?=
 =?utf-8?B?SUVlT2dqNGtyMU9wR2haMjRBZkpsM1QrK1ZvVTg1dzYwUlMva1dqZjVWTEtQ?=
 =?utf-8?B?dUFOZjQ2cDFYdXBZK0tiaEIyRm52ZGNVTjB2eEZMYUFKa0NhUUVrUjNUOFo3?=
 =?utf-8?B?cEJHSUpkTmE5L280MXhpdmtaQzZsTlQ3Y1ZkbmxjVmtPQTJ1MmEyOVZua2lO?=
 =?utf-8?B?M2xHblFXZGNQbXAxY0lmQWVUdG94NHZ5SmlIN2tXU0tFYmhjYVpVbEJrWUt0?=
 =?utf-8?B?WXNNTHpXQmtPOElDQXhKbStKUU9Za1RFdWdFZmJ2c2ZSbk9ocFlrZjFLVzNF?=
 =?utf-8?B?bVFjNmpFemtzOSszZUMzNFYrOVk0WGVBc2VHeXJ4dTdubW9iUTB6Y0p5enZZ?=
 =?utf-8?B?YTRVOUJUdng3LzlMUVVyUUhVd0dtZkNveEdqUFZLZzh2K2hZZlkwejBmMHo0?=
 =?utf-8?B?RVBpeGZHSmdRWlRVc3hURWNVM01saGdjaEMxQVdYTXRBMGVnK3RyTXZ5QlRu?=
 =?utf-8?B?WTgrZnNidHVYcGtMcnpMR1hCL3I4VWpUR2I5UnZEMklMNHVIUHQ2WXQwdzQ0?=
 =?utf-8?B?UWpHMFNleUc0djNWcXRremttVTJLRit4TjJvSjBTY1VBeEZuckdXZHRKWlZI?=
 =?utf-8?B?YzljU2NyNFhsY1l2V2FxNzlET1J2WjBCaVNVSll3ekNXSEZ1UG9taHhzcGVY?=
 =?utf-8?B?T3hrZ1NHTVFjaHhiczFQekRFeVkzMEUwcnRRbkUrK21wa01UZTBqbERYM1cw?=
 =?utf-8?B?WmZkVVo4NGJQRHJXV3VVQTJwNldKVTJ3ZDJJK0JFRVR0eFcwaWZJM0c2MlZj?=
 =?utf-8?B?cUw3OHdpUXVubTJMZUpEalJUWFkxQU9tZjY1ZmlVd0hRUmx5S3Z4ZzRqeVk1?=
 =?utf-8?B?M1VBOCtOVzA4S0s0RFNMVHJjT2Q3VlhUdlc2cEpwdENCeDhpMGNkL2Y0NS9S?=
 =?utf-8?B?SithcEVjeFBNRWM2V0JXTTlvSTVKYVg4SEN3dElHalFEdVpyNDV1RFFoc2tZ?=
 =?utf-8?B?NzAvaG9xY2hhdm5iZ0dWRGN5NS8zWFd3UTVRU0V2c1A2RjNpZTBTbmNzeUZG?=
 =?utf-8?B?OFdOcW5MNUtTT25oVFM2bUhjaWNGNm95aUtWVzlKbDhzK1VyWGxJcVZsS1Nr?=
 =?utf-8?B?KzM5Uk01WXk3RFFlVXJReTZJUld5UUN1OVF2MDcvR3BpVGRTN0VCODBESjlU?=
 =?utf-8?B?NGhrYjJyaFlJcGxrZ013K2ltNlBGd3JYU1FUcXFyL09OUEpQKzF3R1NTdnhP?=
 =?utf-8?B?VDNKMVBGNm50UUhobGVhMVprdGRuOHFDYjdkd1A5ZFI5enlBWmJSTm1ZWXl3?=
 =?utf-8?B?WTkyNDNzUFBnNG9ocUZPM3dQVjRnYlZPMG1DMGJidUowTnZNUGJUejhLN3Zx?=
 =?utf-8?B?dUNlQWwvNlJhS1BIZWFqVkVZV1I3Q1NNS0lsckQ1RE5odytQYTJtaG9acHlo?=
 =?utf-8?B?emg5U0NYVUNwQlFnZU91VXZETmRjSDg0VFN1Q0w5NlJRZnJoZjdycG5rUWw3?=
 =?utf-8?B?djllTGY0aUFwMVdaUjRuSkVQNGYrTUd5aGR0alNnY295TUZWRU4wWEFXL2pC?=
 =?utf-8?B?ckI3QkttN2doSk1CYlJScVB0ZHRzZGpEdmthaEpYaDFrMUlST011ZitsV216?=
 =?utf-8?B?emhjVTFkVWQ5Z2R1VUwxbkJjNFo2OWFJeWM0OEUvVU5QMDdiTk1CanQzaDdG?=
 =?utf-8?B?T3UvOCtWcDJHemh6dDFSV2tvUEpFemQrRjZxcmZqaDNpYVRQbVBWRkV3UHhQ?=
 =?utf-8?B?WE9LdjNoQUk3QnJsZUkvQ2lGNHZHRzQzYUlzR1BJdnBkcG40NG9YQndJdDVn?=
 =?utf-8?B?TGs4WmdZT2ZVUEZteHZrT3FrSEJlYlRlQkZGWm8zUEhWaCtZR0RTcVdES0Vj?=
 =?utf-8?B?YXBxVzVZYjBVa3pwbTd4UlFNckpVSlRrandaUDFPS2x0RkhNK2VqNzNSb0xE?=
 =?utf-8?B?RlFwNXlWdmNJQzZ4cWpJSXp6MnZLbTFzMVFkWVJwYUErL040OThxTlNxYUQ3?=
 =?utf-8?B?a2RrVFJqRlFROEJDeFFld1lwMUZCNnlOUHRTeUpHbUNaemVRTWk4ZXp2V01P?=
 =?utf-8?Q?wQh4LQpc9hOhC+TAqLxodt270?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cce752-d091-4843-f48c-08db8df638c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:34:45.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTeW+v9dMIyokc4r34xXNdjZWWJSZzTdCbOP8qNdNat7gRlNT05DA3ezeBylUlWyTQ5LMSldhG2OVxqTMYn/GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6623
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

On 7/26/2023 8:09 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>

> +	/* PARPORT_CONTROL_STROBE handled directly by hardware *t/

Is there a typo with the *t/ in the end?

-Sohil


