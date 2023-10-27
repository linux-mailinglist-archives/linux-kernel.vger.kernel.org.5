Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC687D94CD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbjJ0KJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345691AbjJ0KJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:09:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8B191;
        Fri, 27 Oct 2023 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698401385; x=1729937385;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GXFM1MVhrp5LEHD7nkh7ZUg/frLwQTeiinYq+KhiTOk=;
  b=EzN4JSek9w2cl88OBEdwPPwNp3z7BJ1l/l4YI3oT6T6Pp5/RxtpgyHtw
   tcb/myCqWI52/yqci4dd65jVLfvdqgNk7HTlQWgx4UVAV3YdGEMz8eIJu
   0bnTCOh1eRaaVlvnX91H/oAQtUtx/Y0C9pLyaMLD8S/9d8k4FwW5Qn/AV
   V0uOmQmc40JfgbBM+xlRx/+djqt4sRfj+qges9ISac7N0cSg7g8kD/+0e
   wkq41LOfjW1d+ZUyUla6ikG4Ed2O62CPBPIFbITtFzOubaxqsc8dpSXIP
   MYi3j4NNzNrtpjShuNP1YNJOVLbOtEwgAeVVd1GykkLH6hqI0gXwkrtaK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451986587"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="451986587"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763169166"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="763169166"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 03:09:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:09:44 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:09:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 03:09:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 03:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkLGEA65OnDKZL1InABGN07u/feSAdGC179ipnAxvu4YS7P21iVGsi/OOyXyFbWj/WOMM5AruRUAXUex5eMRaYpeToy5HiUOh+aRQvbZK30L45Xmy6Li3irwXTVg5ZrQ9NVcp4h5Quemtb0+4BpfRlsCSM+9qBB+rw/P09mNeRwwuAlDuUsEbE+OR3Nov8+rx3pM7zH4NfoQDmuctP5iP+qbzGaJ3SD8D96SOE9Ba8pcqJkSeFQG+DBSYtLca2Asg9wBUWXWiPNePXABpXyIZGasoRDdGhbahUWmSkkCSyG7y6HQHSizaDkpDgE/kSU303un6KIEwbeEp0i6LdAtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UDGeImfrNIdaSrGQWHmdxrfRNC5BOa17blqViyeJXs=;
 b=OpcUs8QSdwd6JBhG/j9D6uUXXZ9rGA5t1stxj7dtryYZo7lOoOUFCNYZmUjFOo4KlQ8WJXG1O55xViFauEYAdN9tNLgB7p40xveKHt9XUKAIYKLFojU9J/Y3Tewsx+ai2T+OKsdWyp0BUWlv0l1/QOdxoXC639VpiWZDNFXbV3S9ch20Vz3dFsLELefuGJR+xML9YeTol+k5rSR0Y/QO6cL9hbXh8q8KXt1EepwoHnQ/WU6M2zAikGmmbf3Bo/wQpFUuercb4kVr40AJQx2eX62rrH5MyKm3BPUTrkzoucOIhdJ/1VSt8IAG+sF4Nf+bkmdhVW16pisuWM0n0WXh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 10:09:42 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 10:09:42 +0000
Message-ID: <46cbc7d8-7d1b-4307-95b2-d8f62dd57824@intel.com>
Date:   Fri, 27 Oct 2023 12:09:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] octeontx2-pf: Fix holes in error code
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20231027021953.1819959-1-rkannoth@marvell.com>
 <20231027021953.1819959-2-rkannoth@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231027021953.1819959-2-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 435d1a40-fc53-4076-f32d-08dbd6d4d673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImNcRUnYVznY3L4nS35CPm0gnUqWQkkYaLrvdb+GhZ3szppdpdZYWcL+Yt5mkr+DZmuZx3kYkocKBIpbYpuiaHSGLkdFmw8DEN1OezW0hKD0qIeCNq873luTGoGPo/dnKmrUur6h8QtoqU2Bh4l/38cZ146+nCPh0x5UCe9sg1kgf85ewSnr8SmGW7d/xDijoMZNgS/gahT6vMIQkuV2PHFOPOy0mmiiSjIrjKKMNNdLp0qO7k2M3LGSa5cYnm79uMYGHz8s5INhycatlrm1RtX67whgO8uNEDpynT0G1RDzETOs6uA9qzkiigJ8yCk0hIp0PFXf3vHzo5xK4zskgxrGvxSF4GcXC6U1c/LNWslJd9695NOVZKAaX2EsKu2Wi/awa4AfEqNotRZPlLFEFslFmsrf+6nMARFKst6oPeG2NrAWkf3JLBpDzmHWJ3i5zZGFjLaTGQepK/toZP7XKOyo6p7HGaJoDwqrQ+9mvkdtDdD1WlSbspqiIfTE0u2jc7GkNcfKvyfIQjX2YfaLIWlHWap4SvSnBlp1iT4Xw4I3WQspC5Y5AcHig46fJSlfGuCENlN3RSQswFgjS4Nf5ycwEXD6F/3eHMYq8OvNl5BH5wSLhVYchMcxrFRqQDPl6tyh6sULox7+rGFYgrbANA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(86362001)(31696002)(31686004)(6486002)(2906002)(478600001)(6512007)(8676002)(8936002)(41300700001)(6666004)(4326008)(6506007)(53546011)(44832011)(83380400001)(2616005)(26005)(66556008)(7416002)(5660300002)(316002)(66946007)(66476007)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ako0L3JWODVMNUFYS0R4Z0FWREdTaERqbUpZdUtWNDBVNCs5K2lXMUhEYUZH?=
 =?utf-8?B?TnZkOHdzWk11QncvSEUrUE1qWVJqVXNoeWdYWXRRaTNlcHhxQ21FeWxmWkNB?=
 =?utf-8?B?NDBnOUtDaEcyL3VEaEFxVWNrNHBlVXpnY3BaMC81VzluMS9FOWF2SEs2cDdC?=
 =?utf-8?B?OXZha0Fsb3FlSVFzd0FHMEFzTTR5ZU5JMklzRWVxcTNnVFRZZWhkZlRnZHkz?=
 =?utf-8?B?aGlqTlppYXdjaTBvOCtVa2Mxam1vQjIwSnAyU0pHOXV2Q2d2UFMxalJFNjc1?=
 =?utf-8?B?RFlobkJoSkF0UGM3UkpYMFhiQzE0SWxqSDdwMTF3S0RLY3ZRT0VUdEYyQk9M?=
 =?utf-8?B?blZyVndBd3c0ZHRoZWdqSjNyWHVxRTc4Mlc3OVdaa3o0Tm5yRTNmeEs5S1Fs?=
 =?utf-8?B?ck1kNnNGaUFpZ3ZQTXFlYnQrWSt2NGp0YklNbTNYTmNZOEZaQ3BVMFRHNUZM?=
 =?utf-8?B?Ym5CRUVvcC8yS3hqVXBOWVNWczd3ZklwUUVXQmlhdzJaQkk0dGtYRVJBZlFF?=
 =?utf-8?B?blpRaEZRT0lBQWJJNzFqeDloM1B6MnVNVHJLZ1d1dnBCY1ZhbzlOMlcyTDJh?=
 =?utf-8?B?V1l5OVA5VTUyTVVqMlpBcldZOEc3VHNoVERQbjdnUm0wSDBDaE5jdUY3NmlO?=
 =?utf-8?B?ZSs2Y0VxQWFxUWlTcmUydmxsZTdyc0o1eC8vMEIvMnEvVjZ4eCtTUHd4cFhI?=
 =?utf-8?B?N1JyQW1FN05MR2IwTE9veng0TmF2b01jZGJBQ1pMNHZoRlhmellUeHNiQjNr?=
 =?utf-8?B?SDBMRkZJeFAyN1lYRGlUY2oxeUdEbkVISnpieGViTGZSSzcyWmpxTTBIM0tq?=
 =?utf-8?B?SGg3ZnN1R1VHZkV5QjYvb3d1b2pqWlpqZGNBdTFNMkU5OEVpcGovekpUMk9w?=
 =?utf-8?B?VitIUEhPd1M0Nzl6SnczNGl3MGFLVVhhczk4M2wwd3ZnQWRqek5WVmF2djJp?=
 =?utf-8?B?bmdua1hycDZheXNKUXJRYTc4cEF4aXpZUnZiRFZVRVh0ZlJ0MVBjUHhBSURx?=
 =?utf-8?B?cWU5WkdlSnpHcEh5ODBXZGYya3NKeG5OK3gvbjBreERUQlVNNTdFRkpEc0NT?=
 =?utf-8?B?YVc2blNDcTZpcEd3dC9HdVNxVlVEeENoZzZ2dzBBcHRRK0JOMi9yZTFGL3pk?=
 =?utf-8?B?elUrS0xZUHBUMEwyRWRmNmxKcXRQNDQxQWlObzYzM3pKc04yQzdXRThXaC81?=
 =?utf-8?B?RzRlcUx4R1V6WkRuemVKRitBbWpYNzFRSUtRdUVuRUF6SVpLNE9wMTJaVlZa?=
 =?utf-8?B?djNlZmtWT0Q2Sjgxa2t2akM4V21Oc3JZVWd5c3g0ODJDOTFqOVhVbkI0a2Zn?=
 =?utf-8?B?emhJQU1aL2hqd0N4R1V5elZXR2dlTmt6TlRMSUFVUWRJdUJTRHFTVzNLcmtE?=
 =?utf-8?B?bG80VnE2aGRHMjI2cmRYK0R0VndGUDFZVFVJZzhDck1Wb2YyZUJhUUorVk45?=
 =?utf-8?B?ZVFrWG1nU050RTZ3WmVWMXBsSG9IL3l4dHBXeURPUlNwSFVJYzg2N0h0MUF6?=
 =?utf-8?B?OTViSWJGTTdoYVRvamRBZW16d3A5cFJrUkk3YVJWeUMwSjFOeUw0SDg0WEZY?=
 =?utf-8?B?U0RYWkJQSzVGQ0QrN2prT21EeERRSjhzMk9DMEpUbVFFeWRicWNmVk9Oc3lm?=
 =?utf-8?B?YS91ejl0Y0UvN2FtbDExbUtWMG5yUFdNemhoT2xYUEpZRmhJd0ZoNTZFMC9I?=
 =?utf-8?B?ZlNwVnViVEhudUVhVmY3c3JEQlZ2YW1jdEdWTFZLMlRqcjI1V2haRU5NMVBF?=
 =?utf-8?B?aGo3SnhkWWVpMUozQ3RtUG1vQTR4MDZzRWJxSUJRMnNBOVJLL3d2ZHJiQzR6?=
 =?utf-8?B?djJ6dGt4U0szTmVWaDgvSlY3Y0c3b3hvT2ZHb3MvWW9xWDZLamJ0cUdYTGVI?=
 =?utf-8?B?WEE3VWFsSDUzNTJGSEJqV0hWckpqdFpEZVVpVXpRZElLUWNhU0hXeGdoalNP?=
 =?utf-8?B?dFVvcUxtOWxxREswU3dRbDlBZXFCL3p5Y3VQSW1MN0Y3LzBQQ0ZvZ0RmYmFT?=
 =?utf-8?B?Uk9MMmpFRlJ4MmowQVRBdmNSbzFGNkJ4OS9qOHlCTWp6TjVmVTdENExDWGlo?=
 =?utf-8?B?TlY3WkZTbEdlbXJQRzhwV1orUkVFeE9iM2JsdzUvN1R4RHJqNjNLK2RNeCto?=
 =?utf-8?B?dG5KZldnVDZ1T21zaHBNeHVGSEEyUklvWmNQUVY4a2dUZXpoTGd0dFcvUmVP?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 435d1a40-fc53-4076-f32d-08dbd6d4d673
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:09:42.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWzKHMQ7d0a9bfgEjLzlc5nN5cPdo85JwBih6BcERiDJaSpqfAmWnRO/J6vo//LXG4N6Gy6UbZ+VyP+s/xHs0WZWSKsFHzjWJpkpA/OqmU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 04:19, Ratheesh Kannoth wrote:
> Error code strings are not getting printed properly
> due to holes. Print error code as well.
> 
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> ---
> ChangeLog:
> 
> v0 -> v1: Splitted patch into two
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 80 +++++++++++--------
>  1 file changed, 46 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 6daf4d58c25d..125fe231702a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1193,31 +1193,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] = {
>  };
>  
>  static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
> -	"NIX_SND_STATUS_GOOD",
> -	"NIX_SND_STATUS_SQ_CTX_FAULT",
> -	"NIX_SND_STATUS_SQ_CTX_POISON",
> -	"NIX_SND_STATUS_SQB_FAULT",
> -	"NIX_SND_STATUS_SQB_POISON",
> -	"NIX_SND_STATUS_HDR_ERR",
> -	"NIX_SND_STATUS_EXT_ERR",
> -	"NIX_SND_STATUS_JUMP_FAULT",
> -	"NIX_SND_STATUS_JUMP_POISON",
> -	"NIX_SND_STATUS_CRC_ERR",
> -	"NIX_SND_STATUS_IMM_ERR",
> -	"NIX_SND_STATUS_SG_ERR",
> -	"NIX_SND_STATUS_MEM_ERR",
> -	"NIX_SND_STATUS_INVALID_SUBDC",
> -	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
> -	"NIX_SND_STATUS_DATA_FAULT",
> -	"NIX_SND_STATUS_DATA_POISON",
> -	"NIX_SND_STATUS_NPC_DROP_ACTION",
> -	"NIX_SND_STATUS_LOCK_VIOL",
> -	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_ABORT",
> -	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> -	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> -	"NIX_SND_STATUS_SEND_STATS_ERR",
> +	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
> +	[NIX_SND_STATUS_SQ_CTX_FAULT] = "NIX_SND_STATUS_SQ_CTX_FAULT",
> +	[NIX_SND_STATUS_SQ_CTX_POISON] = "NIX_SND_STATUS_SQ_CTX_POISON",
> +	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
> +	[NIX_SND_STATUS_SQB_POISON] = "NIX_SND_STATUS_SQB_POISON",
> +	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
> +	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
> +	[NIX_SND_STATUS_JUMP_FAULT] = "NIX_SND_STATUS_JUMP_FAULT",
> +	[NIX_SND_STATUS_JUMP_POISON] = "NIX_SND_STATUS_JUMP_POISON",
> +	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
> +	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
> +	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
> +	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
> +	[NIX_SND_STATUS_INVALID_SUBDC] = "NIX_SND_STATUS_INVALID_SUBDC",
> +	[NIX_SND_STATUS_SUBDC_ORDER_ERR] = "NIX_SND_STATUS_SUBDC_ORDER_ERR",
> +	[NIX_SND_STATUS_DATA_FAULT] = "NIX_SND_STATUS_DATA_FAULT",
> +	[NIX_SND_STATUS_DATA_POISON] = "NIX_SND_STATUS_DATA_POISON",
> +	[NIX_SND_STATUS_NPC_DROP_ACTION] = "NIX_SND_STATUS_NPC_DROP_ACTION",
> +	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
> +	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_UCAST_CHAN_ERR",
> +	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] = "NIX_SND_STAT_NPC_MCAST_CHAN_ERR",
> +	[NIX_SND_STATUS_NPC_MCAST_ABORT] = "NIX_SND_STATUS_NPC_MCAST_ABORT",
> +	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] = "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> +	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] = "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> +	[NIX_SND_STATUS_SEND_MEM_FAULT] = "NIX_SND_STATUS_SEND_MEM_FAULT",
> +	[NIX_SND_STATUS_SEND_STATS_ERR] = "NIX_SND_STATUS_SEND_STATS_ERR",
>  };
>  
>  static irqreturn_t otx2_q_intr_handler(int irq, void *data)
> @@ -1238,14 +1239,16 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			continue;
>  
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "CQ%lld: error reading NIX_LF_CQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  		} else {
>  			if (val & BIT_ULL(NIX_CQERRINT_DOOR_ERR))
>  				netdev_err(pf->netdev, "CQ%lld: Doorbell error",
>  					   qidx);
>  			if (val & BIT_ULL(NIX_CQERRINT_CQE_FAULT))
> -				netdev_err(pf->netdev, "CQ%lld: Memory fault on CQE write to LLC/DRAM",
> +				netdev_err(pf->netdev,
> +					   "CQ%lld: Memory fault on CQE write to LLC/DRAM",
>  					   qidx);
>  		}
>  
> @@ -1272,7 +1275,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			     (val & NIX_SQINT_BITS));
>  
>  		if (val & BIT_ULL(42)) {
> -			netdev_err(pf->netdev, "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: error reading NIX_LF_SQ_OP_INT, NIX_LF_ERR_INT 0x%llx\n",
>  				   qidx, otx2_read64(pf, NIX_LF_ERR_INT));
>  			goto done;
>  		}
> @@ -1282,8 +1286,11 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			goto chk_mnq_err_dbg;
>  
>  		sq_op_err_code = FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=%s\n",
> -			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=%s(%#x)\n",
> +			   qidx, sq_op_err_dbg,
> +			   nix_sqoperr_e_str[sq_op_err_code],
> +			   sq_op_err_code);
>  
>  		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
>  
> @@ -1300,16 +1307,21 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			goto chk_snd_err_dbg;
>  
>  		mnq_err_code = FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=%s\n",
> -			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
> +		netdev_err(pf->netdev,
> +			   "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=%s(%#x)\n",
> +			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code],
> +			   mnq_err_code);
>  		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
>  
>  chk_snd_err_dbg:
>  		snd_err_dbg = otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
>  		if (snd_err_dbg & BIT(44)) {
>  			snd_err_code = FIELD_GET(GENMASK(7, 0), snd_err_dbg);
> -			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s\n",
> -				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s(%#x)\n",
> +				   qidx, snd_err_dbg,
> +				   nix_snd_status_e_str[snd_err_code],
> +				   snd_err_code);
>  			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
>  		}
>  
