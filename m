Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD880810A78
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378631AbjLMGi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378615AbjLMGiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:38:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02260AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:38:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHeah2XeS5PttUvIaSyGByu8be7AAkjAJ3zXO6IGcqpSKvRq5TxdtcALbx0UE9WCvte8vHklDiEHzZ+RAOVws1Fu5kVHl9lmc/JMoJi/pShY7kD2d+T27avPkwWD7rRmuSo096dtODwJkVYIPlMCy0tkCI3jnJOTPGuH37tteDCpWiBWjbjttT6teIEPFDcb3ITK5HPoJmtSWxKnR8GAxSgPzP9fd1in6jZNpF19R/DY3PjuUOx5EjepY0yjeDpoDeYHT2Gh8ZIoOxl629Yykg+p3tWn+LVZljMdgmJN0IYF1kv0Q/kjQ0Si60NUiu1h8344DHJakrnedn3d0C2FHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PD3ZW9FqE6RJRUJKVOgp5L1MkR0NJo8tmw02BDMZyU=;
 b=akjyCYlxlmqj7T3BnVitMHy/Il/BrNYV+eWTJXELpZiSk5b+sQguU+uVVSeLWxVB/ISsK/uj+GurAL6eNRfm6ZOhZy7EfzF0ZgSL4A41M8WkBgjIu9FEg0/eS0UU4TJMmTm4kmw/u3NSPOVJK/eqz3g5QF/KOHH1ndwuHi1onOKl1cV9RcHxz28ybO8tJhdsHlQqH5TY+0KHoF0va10DHRPVhoCPEVzwPvloiRJe+MtpzsMUTvBTB8BmofE4X6/NEUqSlnxw8/YerMOLYfllc+tNt2dECN6u40yQiRbjHD2wAiwhwLrPNQjPn45wkGC8S2ycpxILs+I+LSqffPGRGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PD3ZW9FqE6RJRUJKVOgp5L1MkR0NJo8tmw02BDMZyU=;
 b=2ugevKReqyBEvHgPPRI5DjLRd4VuAoqABa/Lrh5BqafLTQLyoJFHlPFbwCG7Gj/PYnYiIaSmHfAJlHS4DUBtuI/7CnXw/RfqBIMn70MO635uqb9M/G/5gaDMqQEBWyCByZ1gxSakG2rm/rblKYM2zKY6ECPKxTC1zFLU+IEsH0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 06:38:28 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 06:38:28 +0000
Message-ID: <b236ff60-085b-460a-b1eb-ddcea1c79094@amd.com>
Date:   Wed, 13 Dec 2023 07:38:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: Prevent multiple debug error lines on
 suspend
Content-Language: en-US
To:     Woody Suwalski <terraluna977@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>
References: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 95fe94b7-2722-467d-81b8-08dbfba61c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XRUeqQ8LMy2RCkMV4hPCp/yc1FSYCy7rh1Xsveom/scUCDLppQ6CdcFSeNP9RNimfkAxt09Y8CF9GmmQ9229f6hI6e6CWhnpdbgQS2j15MqJPoJvzf9YmjXo55Pidw1USHLCHZPMXiAlbLd74UJ4Ej5ixWthB/TNo7gVcAJkXXZOA6Fg3Na2d+pK66cR77HII2J7S7zo0Y6RPYompTOoTwvgAIKMLmfPd5YHsTsxgsuqv9Qjcnhd2R974FITFdIccpaipuBqv5fQMTR8qS4ZaRCHBT3XcXibrbcTIJp00K9MrAQXFWkpz8HFbitTbJD4ocUnTTeoe8FWREwyB+oPed5UHDmkw6HypTIiUTNe0U3XhcHbF1eO73iH752Ai3DKa5pmxnWltNE/+HiU1zTJM5eF2jUhXYglVmlWGmssNWSKik2TlzKLgMLglsSbBIwYS7UoW/rQ0iQj+h4+CIKL/oJdbcaU3pLZ2Yfi7jf6BmKWQ3lP4wGsospfXOwyOdfwOmOwbZblKgwMgQq31jVu9gJngV46lez+h+XXtCHspjtaYXsltvFRwxsyh4LY8z0ZJnauT0f2Uu/zOSi1LK0D0Q4qfp5T9yHlPKCrAg4qfNU7yKCN9U1Wz2KfQz3ZxazncvcHHIq/ic2IWcGtNJqLcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(66476007)(66556008)(86362001)(36756003)(66946007)(83380400001)(6506007)(66574015)(31696002)(2616005)(6512007)(8676002)(15650500001)(2906002)(38100700002)(110136005)(6666004)(316002)(6486002)(478600001)(26005)(5660300002)(41300700001)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0RJUjRkdVVyMTJVbmpQM1c4RFZ0TlZ5dEJwNEtWZGFiUDNnb3dMbEpqUFRn?=
 =?utf-8?B?SGRsM0tLN2UvNkcrR2ltdENuR1BGbzhvSUM0NHp3S3hGRDVDTWxPaWVEZzFu?=
 =?utf-8?B?M0JscXo4eEJGZU5waGFJVG52eVNYeE45NEZwYWdBMnY0cGF5aTIyck45TlpP?=
 =?utf-8?B?SytFWEJQMlhPN0l3N3daejJQM0w4MzQ2NEdwWkhzc3dQZHlaYy9vRGt4M0VX?=
 =?utf-8?B?eHQwa1lQTHpRNjgxbStwdzduRDVyangwM29mN3crMFZ4NWdLZ3BGbXhHZ1Nk?=
 =?utf-8?B?UUIwRGdvcVhNcjlvOTljWnU2MloycHBuamFLR0dKZWtIYzA1SU0xdldtVUFT?=
 =?utf-8?B?alpQQ2wvUkF2RWdlckRZRlBkV3VrV3g1eTEvWVloMjJuQlFYYjR1ZnY5Skxz?=
 =?utf-8?B?OHd0dkZqSHpsK0dlbGRPSlRmUUdNcU4wZTlNL21IMWIxWG1JYXNvQWdpeTVl?=
 =?utf-8?B?K1Vsc1hDZGpDOWp1S3NBOVJmbVQvY3d1SDlhUlhvbFB5bnYxdVlTZVZzSE5v?=
 =?utf-8?B?RTFNOEdqNGpZZEt6MUpqSldoZmV1MDlhcnBHSG5QS2pjSjNSNXE2WFJ2R3hT?=
 =?utf-8?B?UUhBdTZLVDNLYm5oTmxXd1g0L2h4dlM2bHlZVDZNS2Uxa2daL0FiOERITzRu?=
 =?utf-8?B?a2FzVEVUdG1ZUzQ5d2NzcDFBVm9aTFAvUGdwSjFFZXE3UW0vQTk5TWNPbmNX?=
 =?utf-8?B?TGpCM3E0UGZCQm9oS1NZa29lQzVEZCs0NEwxaWVuWDVrWm83YWx1NVRxaHJY?=
 =?utf-8?B?am1iU20vMS8xTmR4MW5tUnMxZ0dGNXJudWpmZkREQzVSR3YzNTVWR28waWpG?=
 =?utf-8?B?NnlGUW1CaGUxVDVkdWdybE5ORnV5cHJLSm1id0VnRzRrSHhGR3liQmhOWDN5?=
 =?utf-8?B?T2JJMTl1Zm10SkIybnVJTFBBY0JRWkdFM21VUkptR0JrdXQ5ZHdibFBGN2Ft?=
 =?utf-8?B?QWVWeFhjdExQUFplZ1NGem9RSXBDdkN4OWxpZ3R1VEtrM0ZaOTloc3dHZVVJ?=
 =?utf-8?B?RGZvL0lPT25CdFNvdlJ1ellVaWdUdWxNR3VnQi9OenRQMVRWN0dwa2t6N3Bi?=
 =?utf-8?B?R0psU3c5UzI5UTBoSldCWThtMGxnWGRmdm1HVGJXYU0wU21tTmUrOHRtVEhK?=
 =?utf-8?B?NnFVYjZHNjlYSFRWbTFkNjFPUHRTbmd6czBneUxPRStaWWZqRy9DdFpRd0ZQ?=
 =?utf-8?B?QWlLZEh1TjVKUGF0bFFpN282V1BxbmFpdjVjYXhGbllSbHBySjhyUjhyZkMw?=
 =?utf-8?B?Y3luN0ZpTUVDdXpMTkdrNEpmdHZ6c1ZFaWh3NTQ4Y0tCZHhrVXpQeGtOcHNs?=
 =?utf-8?B?bXVjUGZFajR1bHJ5NmY5OGs3SnhwOEhYL3FiTnU4SktLSjdRWWZacFliVGFM?=
 =?utf-8?B?bklMUjVvaXBhMEFIN0dueWNlS09SUFhONExRWGVpandqTVE3MmR6VG8vOS9I?=
 =?utf-8?B?blE4SDlPU1NZa0FtczZOQzZnbkRhKzlEaXJQMTJvYWtNWFZXbVdVdzAzelVQ?=
 =?utf-8?B?L3pURVJicVVrMzNaM0dRUkpxMDB0WUp5SHI3SVpMNnA4WUs5OEZCYmNQVkk2?=
 =?utf-8?B?bnBtekh2MFk5Slg2NjYvZndpU0RZTTNsUHNKYmhwdzFzRjdNcHJIVWpMekpz?=
 =?utf-8?B?a20rM2w1NEJIeFg3MjlTYy8vbG93ejhzUGZJbWlTellKc21vTWxjdWEvZ2N1?=
 =?utf-8?B?YVFRUlFOUStUQXlHNmJSOVNEbXYzRHM5ZkF6SzkrdUNySzdqa3VwN2tha1BV?=
 =?utf-8?B?K0NTMDl0TGZpaHlsVFFqMUExd1JXa1R5ckhYYW1kTEZ3bGpiMTNjSHlkVHAw?=
 =?utf-8?B?dXZnc0d3ZHNiNThINDkrMU5pTVFYSVg5TXZXdWF5NjEwdmVLRlZWWGROaFVk?=
 =?utf-8?B?OW0zR0JmYzlhMFNXa2hnZi9hekcwV2FzMG1pd2NvcjIrTkVLQ1lnQkNFdFBn?=
 =?utf-8?B?WkN3OU8ra3VaYS96cVNaS3lFYmRqTi9IYVA3VldZNHhRUWJCbThlR09zUkZK?=
 =?utf-8?B?YVpxTnNpNVlTd3lGSkNmT214dnA2b3JkZnhBczE4emFDK2NJMC9WRnd5RVZ5?=
 =?utf-8?B?WWtGVHV1UFoxWTk4T1I4azQxSUI5R3hCS0dxS29ZOTZJY1BMUkJoN1VtWHJn?=
 =?utf-8?Q?hyDM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95fe94b7-2722-467d-81b8-08dbfba61c9b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:38:28.3936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtWrD/hmMLveFQZogx7uOJmwypZxN3qxrGMby/VHpS/GAMZS7fd/Yv7Iv2ZFlZhX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.12.23 um 00:31 schrieb Woody Suwalski:
> Fix to avoid multiple debug error lines printed on every suspend by 
> Radeon driver's debugfs.
>
> radeon_debugfs_init() calls debugfs_create_file() for every ring.
>
> This results in printing multiple error lines to the screen and dmesg 
> similar to this:
>
> [   92.378726] debugfs: File 'radeon_ring_gfx' in directory 
> '0000:00:01.0' already present!
> [   92.378732] debugfs: File 'radeon_ring_cp1' in directory 
> '0000:00:01.0' already present!
> [   92.378734] debugfs: File 'radeon_ring_cp2' in directory 
> '0000:00:01.0' already present!
> [   92.378737] debugfs: File 'radeon_ring_dma1' in directory 
> '0000:00:01.0' already present!
> [   92.378739] debugfs: File 'radeon_ring_dma2' in directory 
> '0000:00:01.0' already present!
> [   92.380775] debugfs: File 'radeon_ring_uvd' in directory 
> '0000:00:01.0' already present!
> [   92.406620] debugfs: File 'radeon_ring_vce1' in directory 
> '0000:00:01.0' already present!
> [   92.406624] debugfs: File 'radeon_ring_vce2' in directory 
> '0000:00:01.0' already present!
>
>
> Patch v1: The fix was to run lookup() for the file before trying to 
> (re)create that debug file.
> Patch v2: Call the radeon_debugfs_init() only once when radeon ring is 
> initialized (as suggested  by Christian K. - thanks)
>
> Signed-off-by: Woody Suwalski <terraluna977@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks for the help,
Christian.

>
> diff --git a/drivers/gpu/drm/radeon/radeon_ring.c 
> b/drivers/gpu/drm/radeon/radeon_ring.c
> index e6534fa9f1fb..38048593bb4a 100644
> --- a/drivers/gpu/drm/radeon/radeon_ring.c
> +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> @@ -413,6 +413,7 @@ int radeon_ring_init(struct radeon_device *rdev, 
> struct radeon_ring *ring, unsig
>              dev_err(rdev->dev, "(%d) ring map failed\n", r);
>              return r;
>          }
> +        radeon_debugfs_ring_init(rdev, ring);
>      }
>      ring->ptr_mask = (ring->ring_size / 4) - 1;
>      ring->ring_free_dw = ring->ring_size / 4;
> @@ -421,7 +422,6 @@ int radeon_ring_init(struct radeon_device *rdev, 
> struct radeon_ring *ring, unsig
>          ring->next_rptr_gpu_addr = rdev->wb.gpu_addr + index;
>          ring->next_rptr_cpu_addr = &rdev->wb.wb[index/4];
>      }
> -    radeon_debugfs_ring_init(rdev, ring);
>      radeon_ring_lockup_update(rdev, ring);
>      return 0;
>  }
>

