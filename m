Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27E5777ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjHJRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHJRLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:11:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956C2684;
        Thu, 10 Aug 2023 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691687484; x=1723223484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=anaIb1ds4Q9ihmz+46O2MkNo6FEBXInb0du5LPykorQ=;
  b=neC0tX99iea8pemZILFyetQS0cXteHU6xoIyyAXPECiW3s3VlZY7y32y
   kc7eWGQ/0gqk93/Q1ac2l4aeijx5wyY8tehLVQw+dw/0yRx0rRhR8k0EI
   4K7s5mdvNxEXGaUa+xdUpII8lb83IsXa0U16G5+D+9ofc/hhEdSFejY22
   pr7SvwmDW4Zn3qmQlTYEtgsUAYifdIf07U6iSjWXG9IlYHsR2cJAAlB+A
   phjVkDw/vIMH712p7xr/lg1O+C471ayAbVr94ocqRnJWkza+aZJp7yJ3A
   mlUG7kQUgH0uAAKPECRLMHT0OYwwwnG2ArSYG2bzWzoiAcAjmCA5ivUMB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="457840342"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="457840342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="797687678"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="797687678"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 10:10:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 10:10:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 10:10:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 10:10:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 10:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EN1/2rxzCdXjhsFYTzXI6IrF6MCCgiKRs3NAudkfP74CXzr/capEa3b8yi73m0Lci9/UN8oFQjiAI2xDBQNVA2w88gK16zOFD4yPr8gxP5qu5tDd+2SQL/OIddB9EZy7RgJedIXqzC8o+Tg2H5Vt8ajT041FetQvKFPXhF9tAo2WFGr0mh38oGiX4mZozL3UT5JRCDg/6HyPdsKvjTGl6mc0AQOLXzBesTHCKUcvFXRVrmHs7+RryJpRqjxEwSYbOJSdT2sMyTZAiYA83w5Mo9Wu3IqLSPuCtDLVd9ZH4Pr3WvF5jjReLSk9RofM0KyoV6/zaI38utc2YX7ygLqZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEkSk0gittB1/B2vm9nUo6YP+HQxSr1fpOUILj4FiWc=;
 b=FoTh6XWdfAHNmCG9mWCD2pgKGDiHe9TP6OYBGei9rDDFWh+mNTACBytDePX08GD71VZuZ4ucbBswUtw5Cl8U8zE7lslo6Traf7LA3OINmhUXvudR6WE67QtHiFOSweJUVLo+vuVLG0D35OEHemLpqH7n9H7eGLa5s6EwDiBmyrARRnoEuTuwhxV4y08uxHoR8K9Jcc/bAzSBrSz3d6jgpGP/xpCyj9gIjIhtwcQzLq0skS4JtD+HVEBZ0bfix/kcJL+66ZW111+tOKQZ/cg+dNrfFYboinfZ0epGGJ1sZTlc4/HV9Cfn3VRkCEWBhDoQTzgEJbo6cNsKgl7dMXmCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5679.namprd11.prod.outlook.com (2603:10b6:a03:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 17:10:17 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 17:10:17 +0000
Message-ID: <5e481c98-bf82-283f-e826-82802a2bd7d6@intel.com>
Date:   Thu, 10 Aug 2023 19:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] octeontx2-pf: Set page pool size
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <gakula@marvell.com>, <jerinj@marvell.com>, <hkelam@marvell.com>,
        <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20230810024422.1781312-1-rkannoth@marvell.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230810024422.1781312-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e62e76-e86d-4eb8-2bd9-08db99c4abbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvMruM049+xrAInubSC8/eNtosj3FzG0tn/0TQHqwE9NnfNgM8IwEOyBucIcCaTgpBYxrqOoOfV+D2onsJ5pK/AC1UuQB5Zo7F9ZroJgwJJ5Wz6nB1LnvAxY17o1UDtHIRZXYBshe5qPB43SvX+DhQTUZ+dhS0oj0hPvgH3E2kwATherhsslDotomYzB/ApgzRqt2PXwA+OirCq10+EYqqP1vtLhFU9CNxQH5IRtN64WnVjMJs0mSMIVKS4YnCJbiRL3zOr9UFUVlmhrsBSimwXSbk8HX4VqQ+ys+KuGjMKwrH9rB8GWWw5a2gSdQEolQde1klwM3yObk7NQt0ZlyV5axKle6FTwP3+nZ4bG+e2b9Lk6kbRx9bsX803gximpg/tMYsZ4I/NLQ2+6J6MEdJwmBYuspEbqk+tPV/v856A6X3iQ6Jde9d6XyYx/gKG7Of9nB+3fJLdhge6urUDAZAsmH4Gv6LbwvwK/+87Y0b7J4c/p4xB0ZTWZdOZAea8Y3eI30A1HJsTAJ0MuQLcGcg3kaaxqbHatFBy1pT3jRuz410eqMPMbqxZpx2tid3lyUt6dQQ9Geo57MyBpMG9yN8R+ZVhAhyRuGMaWoA0yGaH8D6rHK0L3YkWhC2IUmKTT2QoKHbQhoKfklQs7tqdjSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(6512007)(31686004)(966005)(4326008)(6916009)(66556008)(66476007)(66946007)(316002)(478600001)(5660300002)(6486002)(6666004)(41300700001)(8936002)(8676002)(6506007)(26005)(31696002)(86362001)(7416002)(36756003)(2616005)(82960400001)(83380400001)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkE4SENlZFJsWDAvR0xYYXpZV2FaUFJWZHV3Zzd3d1FKOStDMXZBYVBPdTRE?=
 =?utf-8?B?ZlkxUzRlZW1wazFKUHorZ21DSC9IcDR6QVZtbS9qUkduaGhKU1NUWVRYUCts?=
 =?utf-8?B?TXBnL2VxWWJlbS9LbUF0cjNPeEplZHZ0REZoaERMdG1zMVZZNER3d3NBZXVT?=
 =?utf-8?B?UTZWRVRaSTh2a3hlSEFGNjloYldVUTk5Z3d5cjM2YmlHV3REbytLZGUwYXFE?=
 =?utf-8?B?ZlhhYkptTGFJTHdaVWlsZlhrYlBsaXI3aVJpSXhKbENJMzVqU082V2swakVN?=
 =?utf-8?B?djFTeWc5Vm5uVmdMeSsydEtjamF6NHRuTWwyUFdEOFczWGJxUlovandldEhn?=
 =?utf-8?B?RnRuWm01UWhwdXBaeCt0a2F6RXFEd2NJdlN2aGQxeExQRmF6c2htLy85WlZq?=
 =?utf-8?B?eDNhaWRwWTFGWkU3OEhGaUxQeS85eUkzcnhwSDhWVlFDQTlXYm1CMm54RlFE?=
 =?utf-8?B?d0l6WXRSM3N6U1hVQjNqZW9Qck8waFo2TjlTU3Q0LzROTWgxS2tlQWo5VWRp?=
 =?utf-8?B?dlpEdjZScGVrRWFiQ3hocW5LYS9Uak1aZVQxL0VuZTVXaGh0REZ1eXJNVG5p?=
 =?utf-8?B?MUVpbGpUNExRZjRkZ3FFRzhMdDdacjJlUWxkakFzTG90MVRIdkhNOHhEOGpW?=
 =?utf-8?B?U3FiWmduMHF6VW5lQTBWdXhSNkt6UE13U3liTzBVTVI2NE1aMW5BODJRRExU?=
 =?utf-8?B?WUY1YmJwMWlxbU14VWZZbldjQytsU3JHL1lTV1ZoMndXRTR6UXRQRlFpSTR6?=
 =?utf-8?B?R3c4SDBGRDV4Q1ZsYlhMLzVjSU9Ob3FEanpJMUIydXBFajd3Q05BTmErcVFI?=
 =?utf-8?B?cGRUbkJ6bW84eFNRbTc2S3lEb3EzeDdkVEJ1ZFp2dFo3bEJNVFQ5d25uNDBq?=
 =?utf-8?B?VCt6TVpOZ2lWMmo0aHVQWitObSszVFFHRzJSMTNtQWxzUEduc3EwMjZ2R3Vu?=
 =?utf-8?B?ZEV5aGFKVmJLQndvbjJNUXB2cFBPaWVYelA4cGVFRU1zeUlzTUkxZ3lyQVJY?=
 =?utf-8?B?OW93ODB3ZER3RUg3OGVHVkZBZVJUa0M5SmJvUlVvczdXZStBZGU5OHd3WVNJ?=
 =?utf-8?B?RW55VW9aY0hYSlh6L3Z6Q0ptcXkwd0RESWIyTkV4dkRZbHgvT0hUVUlTY2JS?=
 =?utf-8?B?YlYwTytlRWVmU1daVm5uaWNhOUxOQjJ2UHNLVEhEVS9LdktabDUvbzlwbmdj?=
 =?utf-8?B?eWVpTGdja1lDc2N1RVRaSnZlNk1UNHBoanF2azNUVVFiem1VNWxUS3BQS21N?=
 =?utf-8?B?ZlY4eUthZDdRSjlROE5OWXZYa0lSeGExTE1qR3FWOGI4bXpQWlE3ZjJHYjNV?=
 =?utf-8?B?UC92OE83UXIxcTl6M1h4VjFnTmVRVEJsOEpWZWt5RWEzZWlkNmI0bWxGazdR?=
 =?utf-8?B?WTJmWWFwZVZKdVpuWkZ1TDRSdXMvOUJza2UxaW9tNzRQRmxLdUdrejhrU3Mv?=
 =?utf-8?B?QkU4Y1k3eDlNcjkrVnh4VmZvbmpUdm16TXFkNTJPcVNiM3FqSEhhSy9LUEN1?=
 =?utf-8?B?V2NmL0lBVzBBaFVrUytNT0FYdFhEMzRRdkZPUlpKaEpCNTY4Z1hIaE44SlZo?=
 =?utf-8?B?cXdPZEN6Z2NCZCtzeGFxZWp0V2ZxbitPZStJdS9Gdmt2OE9JM0oySnpyNVNY?=
 =?utf-8?B?RnNObFdlbEh1M0hDV2c3eDdlS1plVUZDUWRwRkZXenZWVXNOU0k0dkJQWXdx?=
 =?utf-8?B?TjZ4bTFYQ2xmb25kVzlIdkFHaTVQNkpNSXNKaGxvNURwWTNST3AyMXE0OTNS?=
 =?utf-8?B?K3l2amcxOXA0dEh1aTBQR2NJR0hlQ1BWTk5jb1NlcXZTYzgzeFJzV1RQTjVn?=
 =?utf-8?B?dUlXbHBOc3FVSVNoUUMreU1pazZ4aml5M1pTWXJlS3czOG5QYis0TW9GZmZI?=
 =?utf-8?B?SkRxZnA3SWp4eXZ4K0dHWnJwR0o5Qi9RcnIveWFGUkU1VjhhWkoxOWk5ZUl0?=
 =?utf-8?B?ZzRLTENZMGdhejFFb3czS3JWM2pOY1BBajlUZWlwZDlPWGExc2t6RFF6d0pM?=
 =?utf-8?B?NVpBNEZPV1pPRFlGc0c5ZXo1TitFS1BwdXVobFBYREFMQmkvTE1pR1hZT0o0?=
 =?utf-8?B?NjNyaStKam1nL1JETENiR1dpci9OSTZpalRjSmw5ZE1tZlhrU2paYkZEdFhB?=
 =?utf-8?B?MDh4cGw0aUJ0V1djS1Vmak5nZ1RBU1FWUkV1aERVSTE1SFhGcW0xaDZpeTZ2?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e62e76-e86d-4eb8-2bd9-08db99c4abbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:10:17.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbG4Vvd57qInkn8XHB5EcDGcFkv7Q2TRWUveihdZOU7148IhY8vgHmlJYfy17AxPHTdnqXcGKMuuFaxVUlyMG6+cx6NbHkbGLSOFNWs058Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5679
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>
Date: Thu, 10 Aug 2023 08:14:22 +0530

> page pool infra does direct recycling aggressively.
> This would often keep ptr_ring left unused. Save
> memory by configuring ptr_ring to a constant value(2K).
> 
> Please find discussion at
> https://lore.kernel.org/netdev/
> 	15d32b22-22b0-64e3-a49e-88d780c24616@kernel.org/T/
> 
> Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")

Now the commit message doesn't explain why this is a fix.
The subject is also ambigous.
In the subject, you need to say clearly what you're fixing. E.g. "fix
page_pool creation fail for rings > 32k".
In the commitmsg, provide the actual kernel warning/error and explain
some implementation details, like: "instead of clamping page_pool size
to 32k at most, limit it even more to 2k to avoid wasting memory on much
less used now ptr_ring".

> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index 77c8f650f7ac..123348a9e19e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -1432,7 +1432,8 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
>  	}
>  
>  	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
> -	pp_params.pool_size = numptrs;
> +#define OTX2_PAGE_POOL_SZ 2048
> +	pp_params.pool_size = OTX2_PAGE_POOL_SZ;

And if the ring size is e.g. 256 or 512 or even 1024, why have Page Pool
with 2048 elements? Should be something like

min(numptrs, OTX2_PAGE_POOL_MAX_SZ)

And please place the definition somewhere next to other definitions at
the top of the file or in some header, dunno. Placing it inside the
function almost guarantees you won't be able to find it one day.

>  	pp_params.nid = NUMA_NO_NODE;
>  	pp_params.dev = pfvf->dev;
>  	pp_params.dma_dir = DMA_FROM_DEVICE;

Thanks,
Olek
