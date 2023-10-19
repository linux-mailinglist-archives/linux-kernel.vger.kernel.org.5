Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823557D0430
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345256AbjJSVuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjJSVuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:50:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2A11B;
        Thu, 19 Oct 2023 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697752221; x=1729288221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PMfH+lDdJyoN9EgLqJ2YxeOjr/FnQjOBjnBfqJY1hXM=;
  b=QxGPSoBtgQWwCY1v0+34m0vfFMXSXe+tw9vw6CHng087r2m7v3LUdzbg
   YhYq4VqRe3HirXgz+6pHGzqNr8ilmCsTt2CjMDyea5ziHUg1POiG+tTih
   01uLOQme0DaHSTAofhPzgynS5jOxRAIkDBQS938epKb+oonP0mBTpxF9v
   L/7F+d0ekXKTvGgjjQ9GklHnze2nnaBOGkytKd/mvZS4cUF3W9Y0WPS+k
   H3mvXRer4DKdwF04Sw+fQLJ2fudHnPF9sYL1dQlx0c099DoSc96gzG5a/
   5lZTKteSKrcubUcl6IwIiG/67Y6FKdrScxhmLB1IllkCtaZJa5ie5xMPK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="365718264"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="365718264"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 14:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873649535"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873649535"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 14:50:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 14:50:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 14:50:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 14:50:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 14:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHQMrlkrVsBdSOjHeqp4PMXuM7vkCgcntAaBuj/tLsuuBUCPWr0d5gPbA37oFmY0dL4HSGsPhhJZQjIGIWms34292h6J5fEnmuIlBCPAWK2L3MQEfndyjY1alMbsn35ITzjKq+8/sUZxswFddeIOg0LIKb+GnoRpaC/Pg1lhphqDAqxc5h1rtJHwtcnXQR9+U4knYDhEfwFcIbde6sjCHyyqiE54QA1zeEclaMmNX6PUkbLwINHPvJKddVWC49RdkobBiwJOF2pUnWgkYucuozZK8EmLLnxywx7ilWkRtyXeBjTHKu6hJYoVn0vtnhHk/iwg/FbY4n45xrWPnoSywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOsKRr8vfoTDJZRemr1iNPtCItZhPvyDGqXG0QBDITQ=;
 b=fLjMI5ZgTvy1ywhJY8jB1GZYSsGLAyitOaDzd3wlEtPnnNiHzrvm50Ni6dw8iLMy+2C/uoytU9uiuHKRALkzdt9SQPxwMxG71YtmIPlaBbmaWymH5tjkcQt129w7r+IOZnBcqn5St+7mDmf7lzz2qzG4fBeE2M2ySfDZYIZyf6hHnj2o4+emeVhAASujYq/gmPG/Eb10kC880PIEtoMrQrKEZT2MygVGtUgvDLq8R2yasxBpxTez7aOEdazOdH/aTe0ViZWMgJJ2BJq83/lK/n+FMHp9fodaS/Eb2smVqC/7aIyOHqJM1wvzFhr5Gqn5l6sWfmVkq/04p26gG9hCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 21:50:16 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 21:50:16 +0000
Message-ID: <80d1bdb9-f037-24b4-647b-df982fa0c981@intel.com>
Date:   Thu, 19 Oct 2023 23:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 00/11] devlink: retain error in struct
 devlink_fmsg
Content-Language: en-US
To:     Jiri Pirko <jiri@resnulli.us>
CC:     <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "George Cherian" <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <ZTEyzpat4we6f4kE@nanopsycho>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZTEyzpat4we6f4kE@nanopsycho>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MN0PR11MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc205d8-e1f2-4c04-cdd9-08dbd0ed618b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZBEpaSIq14uWklF78aNlEmLrbiP6f6z3yh5neLxCMeit80VSQe0WX/KOaSbHQEFdp2RITlWeZQXHidVUdAVw254Bxwod4CAkTWrDMoJ0vJd9Wm+cz2+9RRcYW7DPpnuSANvxy6A44EJDG3IHH2FlHGxaLXjMvJOovCeQ5R+jV7Be0bPRJ/wcQYjyVVVplxpbe9AIeylOmJcKgC9/4eNLFZ/m2GHfjB7z79rJI8pw6pOmnL0Wz7SxwwNiHAt29tAbs5k2XoiE0C1KSv+JrZZmnrIljoqZOc0101XztNPgMo/qkrCRzhlgxmiC+A2HWATEHf0WDR7Q9+zc5HcY0l7y7phdhLqobGcRkx9s26nmXtwuP9XUxyjjrKYWFx533yUb8aeyqpx1dzMR3hUWU9bgZ8qanKFWa5q5uqbsCo8NJNbz+q/ZalfIhN//OK53buYIFxgszWJYHnZMl5E17s3YU40vls2yHzTrL8fOjn65cifNuDsLYjTzWo5Df6r65w98skogOvgTkAJhjNCel68LHMqpxu+9mSIgaUzUwaHJb2w1hWl5tIgurQONe13+VGexGYyq+kFmRp2+YzIkmrLV/s6MVi8Qnu5ptTWACLxepUwsOYUz5kMJo4Dnq3BZbsr+kNtiXBTKcNssxJ0/V5Fqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(5660300002)(7406005)(7416002)(6506007)(6666004)(31686004)(2906002)(4326008)(8936002)(8676002)(6512007)(41300700001)(66476007)(54906003)(66946007)(66556008)(6916009)(316002)(6486002)(478600001)(53546011)(36756003)(83380400001)(38100700002)(2616005)(31696002)(86362001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGlQbXFKNksySzNzUDhxRDNYeFh2UWZPdE0zaUdyQnhOOTJkenFFbG9DTUdC?=
 =?utf-8?B?V01HbTRLVlhOR3pxWk1Sek5TZ2tUREQ5SXdvSmNGakM4eFM2eThoMjdQaUp0?=
 =?utf-8?B?SWhTVWxDejdreGJnbys4VUJ6UmxPUWl2blAxNlJpVzAyNDBRQmsrMnNyU0Jz?=
 =?utf-8?B?TWtiTnpnSUR6c2NacUwzQUlXUzNNdnBQSzlhUTdyNFRLbmRqdTJYa1ViUHkv?=
 =?utf-8?B?czVtNzdHT1NwT3dRSUYxdFhSSDJZaDRvbGRTYzNiRmVidVFLTk5MT0tEWlZT?=
 =?utf-8?B?Qlc5aVNaQnBxSTNDekRUSDlrbkNtZExKbFQvMDBhbFlhTTJRMnlab2hrUmoz?=
 =?utf-8?B?ZGRmeWszd1F2TnBnSmpRN2k5Mm1NK3NZMU5hWHExNGNSbzJJcWNXUGMwZytW?=
 =?utf-8?B?NG1aaW9RdHhVT2NQT3Q1Rno5MnkwdmRXb0hGVnFwWm9yQ2xnNGNyRG9pSHRC?=
 =?utf-8?B?Rmh2U2dMREdINmpUUlM0UEJOVjhkWmVIaGZLRG0waVZtOGlROFVZNlZleDdK?=
 =?utf-8?B?RmFjcWxBK2JzUFl1Wi9Oc2hWemZxYkJndmp5MGtObHpiN1IvTTYzN0R5S0gr?=
 =?utf-8?B?anZSaEZjV3RHenMwSHN5c210L0tKbWlvcmplWE5oTGZncjlnaHNCaXFPa1hl?=
 =?utf-8?B?RkUyOCttNDlyRTFxZU1Fdy83V0ErRUlDajh0VHRiaDM3REJKU1JZZFVWb1Ex?=
 =?utf-8?B?V0t6QW5KaU5GRlROM2VUNmhmM1o5YnMrYXdKQlB2M04xZXNWSkxMZTA1OE1J?=
 =?utf-8?B?d3VHdzRCMzhkZUNVbnpGV2szSmhYN08zaVNlOFZvbk5icU80cEZGZ3BCZkxw?=
 =?utf-8?B?Ky9QYkdEUmNzeGdjd0N4V012MmZhaUI0bW8vOTRRdlU1dFJNcVE0VDNKWkFr?=
 =?utf-8?B?VlMvcDErSHA1cHBvQkpGRlozUnpmdmN4TkF4OUE2THVlWUlBbXpoZWRvY0JB?=
 =?utf-8?B?VkpZNnNPS2x1UFBLQmkxckowd1FOWnJRMm1iVDhxcFZTUkVONTV0Yks1VFNu?=
 =?utf-8?B?V3AxSlpKT1RmaStiZW9oUXV3ckpLWExPZ09lQmRHQVhINUlIekU1YVduVG1B?=
 =?utf-8?B?VS9WQ1JoRHM1MjdDYXVOMXE3cjRGNHZnUXF2a1ZCZjcrWVRpOHp6TGdZRTg1?=
 =?utf-8?B?eVltZWx4UkZyaEtHWDFPcFdXNk5BRC90VVA5L2paUU1Dd0VOSUNaczhzd2dE?=
 =?utf-8?B?VE1oSHkvU2pqYzJZYS8zVklVSCt0ZE1SWUZhT09LbjFnRGt5Q2Z4bjlDajVK?=
 =?utf-8?B?Tmx2YzFYM1F3ZXp2a1c5WmhEeUxlODRiOUpRVW9EeVBwVUhHa2xFT1Zlcy93?=
 =?utf-8?B?MXNMRnc5SDhYWGVpZ2FFMFlsRFBwL1k4djhxV3UrMlhnRzhVc2praldWZUhs?=
 =?utf-8?B?Ty9QNXdIMWlnSldDZGpMcnJRY2owQkNXVnBXaHZoTWpMWXgzMUdjM1NMZGY1?=
 =?utf-8?B?K2xNaEk1N2hVMExMQ3lYNWZlcjFjMDlNVExubnpxdWUxWGlvMXM4S3hmZURF?=
 =?utf-8?B?UmVnRTJSeTJNUy9ZSFdxZUdlVHZQTHhHaUYvb2xra2dKY3lhYVZkd01ZckQy?=
 =?utf-8?B?VmdtWjVWL1M3Ri9SWHdBY2lHWEhBNTRYVXg3MUZWZXBCN01ibEs3bnhYVmpZ?=
 =?utf-8?B?MkQreTNIVW5oc1dMKzMyUVRjU3hDUTFiZVBXeUxra2ZGU3puOFhkWVQ2Rmtw?=
 =?utf-8?B?RHg2Um9OVVlNOVFLS2lVdEVmbzJWT2NDeWV5OGdLZzg0UVlKa0ZyV2ZVbXE2?=
 =?utf-8?B?dkEyM2d6Wlllem5YWTdWc2VHWE5vM1pSTTNXSlh4VzNLYm5LZ2JoNGxyR2lK?=
 =?utf-8?B?VTUvL3B3Mmd4RzVEY1B5VHR0VGQvZTBPYU9HYlIxbnFiUzVCNk4xMCtCVENq?=
 =?utf-8?B?N0QvZXJ0N3cyMHRxRjM2Y2c0cE1MWXo5cGtWclhqampoRzV2NFd6dkFpcThU?=
 =?utf-8?B?U0ovQXFGck9Ob1ZxWkMxeHFSUmg0dDRBLzJCbG5WNWZCaU9heGNJQXV4RWJZ?=
 =?utf-8?B?YmhvZGVWK2dsajU3TzBZQWpGWEdQRzRCNkhRLzFNTEVxcENpeVJpa1BQYXc2?=
 =?utf-8?B?U3BVa3AzVDNZSWhKMUVyR0wrV21qb2dUdE0vZzFDKzlzOE14bTlYcDI3VjVJ?=
 =?utf-8?B?dmVFWVN3MTgxdXY0LzJWbklmdEc0Y1doQ0NhemtqOVFUaFVBeHdoUXBONTJT?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc205d8-e1f2-4c04-cdd9-08dbd0ed618b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:50:16.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLkEHFnLa9WBNsx6pBHzg/zD9kzj5qkWk4MDfMy1lenubcrUZ+rhbJijhA1g8Oe9rcAgLCOCDjG1Egu4E/YQZp3xJIkvyId/VtloZh5E9Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 15:44, Jiri Pirko wrote:
> Wed, Oct 18, 2023 at 10:26:36PM CEST, przemyslaw.kitszel@intel.com wrote:
>> Extend devlink fmsg to retain error (patch 1),
>> so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
>> and finally enforce future uses to follow this practice by change to
>> return void (patch 11)
>>
>> Note that it was compile tested only.
>>
>> bloat-o-meter for whole series:
>> add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)
>>
>> changelog:
>> v3: set err to correct value, thanks to Simon and smatch
>>     (mlx5 patch, final patch);
> 
> 2 nits:
> - always better to have per-patch changelog so it is clear for the
>    reviewers what exactly did you change and where.

agree that adding changelog also to patches would be better

> - if you do any change in a patch, you should drop the
>    acked/reviewed/signedoff tags and get them again from people.

Here opinions differ widely, and my understanding was "it depends".
Noted to always drop yours.

On one side you have just rebased patches (different context of review),
then with trivial conflict fixed, then with minor change (as here,
0-init to retval, those are things that I believe most reviewers don't
want to look again at.
Then patches with some improvement that somebody suggested (as reviewer,
I want to see what could have been done better and I didn't notice).

In the above cases there is both time to react and no much harm keeping
RB. Things I think that most reviewers and maintainers would like to
drop RB start at "significant changes such as 'business' logic change",
which is of course a fuzzy line.

Always dropping is an easy solution, perhaps too easy ;)

> 
> that being said:
> set-
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 

Thank you!
