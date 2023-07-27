Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAF765CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjG0UHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjG0UHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:07:03 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4B2D9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690488423; x=1722024423;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lO55ZJ/CrevQUy74hmnrO1rcQ8wyjetmGNcDLdQPpWo=;
  b=IqFE0SLBajlOg8Mf3Nu/MvGu6hNavehtLeAnvHuWw2nKB7H3S6rBeIZr
   HfrQRyEyevszGXZT+P07DeCHMx+cdEkAPpm2C6/5b4xcVSmkOJlyeRLPS
   2f7VkrXbrsofueWuifZ567eAQSQrpFlSO6HepG/3/RxaoAxlJhos5btfw
   FvK3eCcrFMBt0rkhT9ad9ST1XAe/lFgUjze+hopRYhlZ070xlIDhcTv5u
   xhAi7fyvtBT+lQXp0sq4SwoR+Iz06XYPWBAnOkMjoAmKqjVGGmQZw1rtk
   p1kpaRa9r2hhf6fZrFvN6hn3q9y9znVoWedDh1KTEJP/cUGmMW0YUdbqt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="365880059"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="365880059"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 13:07:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727147324"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="727147324"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 27 Jul 2023 13:07:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 13:07:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 13:07:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 13:07:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 13:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6hTR2CZsdhDoVqu5o3bxPFA3+/NBITfAezYM3MYe15YHz4TnZwER28/qRE1FfS6QixZBpJzOJVrba/n0lWUyG781RrXrzq7c1HUVW2tYRrrXmxlzHPQ6o949QmkUm4vIuUBVGC/LU1eRHNMA54S+Bg0OtcGO1P9dj/eAgAuoDlZkw/uikH2PmWWcs2UJVRAD95wwyCjOsvwoT9gwAMuVtqYDhfvN3Zj05CsADtnn8r5b85X8xRBgD7g7csxc58gNXzkyURFQN3zE6nre4ayyYO3fKVmeUWel4k/8S2S9fyFVv2dpoDIMTDA811w+OGoaGGHHhvGenz/ho1LlXgKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl1mdL3/77X7JmAeDT2mRQo/P7ezCI4sJxHwsEXbtDw=;
 b=XzUGrDYl9M7rg32qr9y0qdDm4vkXaBGcT1l5RRTikwlEaFcJeZZw9VlQvbKlygJjSTD/TAG8wTQh4sjvME7+JUBddL85g3t1dx2N26Pw2KIUD4+VIUfHW/FiglneluHYjuFj2xcpnnNTwA9vbq7/WrCPc8SeLraEAnaS7cCMo2S6ScNqQAe3iaFOXEMSru/gr5YsD+TPa4Y90d/C21yYPh1TeK6w5P4UZQBH+qzSxJoitYYm/N9CBpYn93eoRzUkJbrUAU9///OiqHHrMsxY0F6ku2ug6tGn849ussJnAd+yNWinIm6Y03CeULvjvDDpv6/70kaA+wJFS7MTrTQFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:06:59 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 20:06:58 +0000
Message-ID: <c4410ce3-e38d-a935-0e5f-6773cdbfe11b@intel.com>
Date:   Thu, 27 Jul 2023 13:06:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/APM: drop the duplicate APM_MINOR_DEV macro
To:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jiri Kosina <jikos@kernel.org>, <x86@kernel.org>
References: <20230726234910.14775-1-rdunlap@infradead.org>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230726234910.14775-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 58953e12-0f90-4b67-fae0-08db8edd08a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDPHJIVLuKqvcPd6U6lKNQrk32F/Qrbxu+4lc42LE15M1A1B0rJSw69sCD8f/xN5LQxdZH3iSA4Iqwbj4/r7Sr1FAGLVUR0dyCdwzFbvVOeDtEQwvDcC+0K9FjHolMh6pMkdgnFzsAxiOSFQJMScKzrZ9JysAPuQU+dk3PKzOjXRPqkBDaafBQH+YN7LJhJJMLPWqlYKfNtq8RB+8VOFWdLXOkXsUX1K2jOx6W2Wb+rVtp/mzsw4ySqnsOXwt2wrNYZ8Dqit0BOEIn1IAaei2pse5V/emcUogf5bm3HAXP5/M2SNqLT6hFKzJzoDmA3cniT5G/B3kdKpM8RIMxPoKSnSbB/VmywKYeP5/5oVQkCjfvly4HoEnGCToRC8K+xc7qDJhwZmpJrcutMdlAR3onSIgPA73TXsP+qhCicqZx/Jw8pZfc9nQGlPveyiGRd0OIKgqbGI3vESrDpR+49g2iDADo4XTC4VnPnalyWVGH8LZCxtLpbBEDbKxd7Q2UxQhfDgqQsbUMo2y0Gb4lo1AlSrKQPgP/RINyg7pzIiRtwKTaTQ6w+i8wqnWW5z1qInLCbh3M5Cb0UXIoH76/qvcy3XhLcNaHQge7fQhoikB35KurYxEiz0Z84k0+BuAnPDt/76UoNLiv7MYhgDyX39Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(2906002)(4744005)(316002)(8936002)(8676002)(5660300002)(86362001)(44832011)(41300700001)(36756003)(31696002)(53546011)(6512007)(6506007)(26005)(82960400001)(478600001)(6486002)(186003)(31686004)(2616005)(4326008)(38100700002)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxUQTJBSlpwVmRqNVFzU1BsMDUrbmlraDA0MGN3aGhXUWVOQXMxdjQzdElt?=
 =?utf-8?B?NHBLb3lNRFMxZHZ5ZjRZbTcvTExvWWR4Um5yR2FyK1pldGVoTGIxVUNIa3FG?=
 =?utf-8?B?WkY1RWQ2bWVvTy8vLzd3NGNiVERqMnVFYkFOVFJpTjVWQ0hnN3ZzbHBmYWtH?=
 =?utf-8?B?ODJsSk1zOUpXa2JBdnJicXozYlMwNzlBN2VvNHBzdnp3TGF4bGcyVXdISU9k?=
 =?utf-8?B?M0tRSHV1Wk5lcVZmM09vZjc4bVhMV3ZFQVNSWVJXTFB5ekhvWmd5WVcxRXB4?=
 =?utf-8?B?UUcvTG1UWGpFVGhyclRDSW5Sd1VJVUFuRHRnR005NDl1L0JWZTNKdjBuRzJ5?=
 =?utf-8?B?a3RkTmlpaFB2YXk5dHZJMXptNkJyODJZM2dGdHU1RC9YdnlBWFV0WUx1MmN2?=
 =?utf-8?B?bGZsSEd3ZVhqaXdPTVdEZlZzMVl5Ti9OMUdOVU1TMUI2dlA4ckdFaEN6YzNp?=
 =?utf-8?B?ZnZjYjBSS2Q2M2lFNDBpVGVBWVpKekVtZVRBbktPMXRybDE4b1g3U2JSWGsv?=
 =?utf-8?B?OFQ2Tk1Qd05QMkNPa25VWTZGSUVDbjJuK2RqT2pyMkFORUgwNjJMTDF1ZEF6?=
 =?utf-8?B?K0lZRDVHL1VaTUIzN2JzRGVWYklKQXlsdkJRd3g2VXY1MVpaZ09sdW5BdDBv?=
 =?utf-8?B?VmtYaStKUm5XblBjT3hzREdGWjBXbDE5OXB5K0E2a2tkdXhsNFB2bE80MFRh?=
 =?utf-8?B?RGs4bURpMUN3ZE5mNmtIdzFaRUFiNWJIRWtzVytZMUJuSHpwRGxqMU1jT0dW?=
 =?utf-8?B?QWhieEN2V3paWHJFREtJV3drY1BxT0FpdjJhT1c2L1llT2J0SG00dmQ0bTY1?=
 =?utf-8?B?dDBkMS9Qb1ZsSzFlODFPYmJKTnU2aVVzQTJLaHIwdDhPNUZNSEx1RnFjSGlB?=
 =?utf-8?B?SmF1ekMzU2xvR1k0RDl1OGJLTWVqb1FOVGxFZ1lRQmE1MmZNQW1oSWUrWTlD?=
 =?utf-8?B?SDZxcDBGU0lyT05qMzMxb29XYlRIYkpBengreXJXM0h1b2hmeTFHdXU5VzdY?=
 =?utf-8?B?eDJUSXU4OEo0dFFCdE0xV3g1b2xXOTF4ZTRxZFJTZS9HQzBzUW0vN2w2eW1Z?=
 =?utf-8?B?UXpjZXUwTjJFdXozVmNzSWtVbTJubmx2MGhORURFSGVuNklxQ1NuTkJkK25y?=
 =?utf-8?B?clhDRlZDenVLai9zRGFycmhVRndYMU4vMmpYRVJKOENzYWJSRDlPRllCdHJ0?=
 =?utf-8?B?U3F0bk5NZStFMHhvWnkwRVlVOUIySVdDTmZZcDc0NTJrNDlJTzBYTHA3OUc2?=
 =?utf-8?B?ejRjQWI1UjNSMjlEbXBjQ2NTQmUzRUdBdEFhUEx2bC9uamxQS2JpdjQyZFZm?=
 =?utf-8?B?cjNyZ3NTang2RWRQUUYzTGtodEhuc3ZrWkZjR3lJS1daeEZwMHQ0Nk5TN0xy?=
 =?utf-8?B?cWdNNjVUcW9jbWRoeXFWRDk5SE5lT24vb3RZdjloRXlncXBqUlNYSTVFcHBu?=
 =?utf-8?B?SURpYUJxVlpwcjVlZlFmWGg5aTFaUmZkdk1UUEViekFPbG8wSzB2YkUzYysx?=
 =?utf-8?B?RHl4Y0svY09NZWwvVlI4Vnp6RDc5cG04RnRibU83Q0pQMVJxNXU2cmZEb3ox?=
 =?utf-8?B?d3NPOUdQOUkxM2QxNGhEK21zU0Urc1lSZTRQQ2Y4bGNBd28xcUJCV3lzOXB5?=
 =?utf-8?B?TVZuc0NibzRKUTUzREMrb3AwOGtkcG9uVit4R01WZ0Z4Q3llRkcyMkpnQUFF?=
 =?utf-8?B?QWZadG5WVjN6VnJhWFUxb1VJQ1ROa3hocmpsYUMxQXVzL1dEd0N4ZS9JRHZl?=
 =?utf-8?B?NXhUTnhQdnE3anl3cnliUEhpcCtEcHAwZ1Z2eEZOVkFBQUVVKzVwWG9vbDJn?=
 =?utf-8?B?Um9Pc0dhRXJaWUdCdUlQdldtYlY3UzZBSVVySE11cVF1L2FkWGgvOURKai9o?=
 =?utf-8?B?bytqUnpsSkl0Mk90c2gxaGNUc2hsRmQyRkt2S1doTWN5QnJhMmV6dExYcGNE?=
 =?utf-8?B?ZFlrOVBxaGszR20xMjFYcG56QnhJeWIwUWRZQlVEdDNXSXZZS1kvRkRIVnVT?=
 =?utf-8?B?YkxETnd6ak9OelBTek56VUZ4TEdKWTBPUE5xM09EWldaZEV6alhjbjNLSTJn?=
 =?utf-8?B?UWpYcHhYTXV1QWt5dFhzdHJFM2F6Z3EvOTNTU0grTHdYZzBIL1dkMkRkVDBC?=
 =?utf-8?Q?KdOZxXD9RGlz3jP+Na0mjtAub?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58953e12-0f90-4b67-fae0-08db8edd08a8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:06:58.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwK+nlmFZYGBWw8vxY8k9ealOpsjsaEPptNR6Ypwl7ID7wb1Rg26y8Gq7lbLHVIuY+nKKrNbSiuJxKEw6y/F6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/drop/Drop

On 7/26/2023 4:49 PM, Randy Dunlap wrote:
> This source file already includes <linux/miscdevice.h>, which contains
> the same macro. It doesn't need to be defined here again.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: x86@kernel.org
> ---

I am not sure if a Fixes tag is really needed for a redundant macro
definition. If at all, shouldn't it be 874bcd00f520c ("apm-emulation:
move APM_MINOR_DEV to include/linux/miscdevice.h") ?

Either way,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

