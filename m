Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B837FC2DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjK1PXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346750AbjK1PXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:23:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A810DF;
        Tue, 28 Nov 2023 07:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeEWbgTUODy7z6KOaVoEqyl3rgYM41eyr5afntL0Sy6Y6xmsagUfDcmPN8INYNCunzp40xo/h2GiUutyOT5K9P8oBnqBWf5OgnMeixIvcjZVOrRDpmbAFMPWobp2xmevTghV7UzLidXqayc1RhLL2dZDCI60JU9uBLuwNxub989qqliNzTsJAI4Edaj9gS5F3FtXQ6V8q40SEfuhLnCwGgOh0saF0vTO45kgHPkNy4DYHKauvqfvBbe1ayD5izvVFAi8DCn1i+Yem852psYxSpEQrZEN7Pkh6CAkJ84AZU42hqHavlmXX7SYF9lDfGtV/3Iy8qIvN8lFBrybMOUH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pL81f5NybrLDO2F/5v3x5zfV0vNGHXGx9zgJCIqNMOQ=;
 b=IIzGVQFy1YTF9BG7jSKFB9HBQUup5TPFdlr0xlvwNSQhT6Ru5jLoHFJhC/YPAZhLnRHe91ES49RQkxmCqsTHGpgW1ckCe/1eQt1AyRxCEbHuWLY3C1h5/UJc74ppI2lcCNdfq8KWQKcYW/0Owb6JQk9pjkFftAj9pBNOC+NOwgb0xLM5yFNbWJbsemnCvAbglngF4RbD7LoFyjV6kDsRookPvonG7Pr/JqUnYjBeY0PJHN+oI3UNGUmVGiznFAaQHsO6XtvsZwz/tGj3mZ1jP0JnCPhPLS0Ys5FdekW5znNjjOvHIldoL71JH0nCvooQRy8ACRIamEa4hH5T3sdTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pL81f5NybrLDO2F/5v3x5zfV0vNGHXGx9zgJCIqNMOQ=;
 b=g2cIX9aY8sKxN8R0Xr8CTQU5yA0ROxNhxqxLlRflWvDT2pp4EjJJWbC8Z0vQvLdCDiRruf7FvP5bhclcWoM/07Zva8SKuqPO5XItAI/VqF8+nHNckUuRC55/8blmyfYmwgS3rHQMvsbLg0otxGT4rWPk9VtdhCiQontOwAanHU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:23:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 15:23:23 +0000
Message-ID: <5ddaa55a-a979-447b-a12b-31a76eeba104@amd.com>
Date:   Tue, 28 Nov 2023 10:23:21 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Muralidhara M K <muralimk@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muralidhara M K <muralidhara.mk@amd.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::6) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: a47fea2e-66b6-4f45-4fe8-08dbf025f602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59dKVP+EkRK+iFoNjzUDAMTywpeW7MpvlNBst7Jvo8s2e20S3kUU1rK0QyCRBaGyryD055ak7U2agkvbUr8dlLeeZVf7L+m+MPi5ePg7ST/vWCFSTHo1VTRQjGBW0Pyg7gIpZsr2Bcc6y7M0mWe2qhg+NBuseIp3jFowa0IegTFrwiojZ3W2p1HrKg23t3KTs6T/UTn/kDpUgmXkEI+Xmq1EEECQy9M2OCmWqh1APymqHMGDgeafTbzgoSPWKt7aNFQJQQtu1wo/UvL27Lru5/HHgcI2a0E5J8MyGTa4gBYL4R90KGwJ294z9Q10jaDAJVgTD5zLXLjwqKd6lMfyjPtYaJpsBk1Y44OKVn/CMvQmRhx2+ATvVEkG8rKjBkj2/W1FjUwb+NKGsOzzJfz4cWoKcHRZ5ky/nxYg833HLgP5eB8fLU6Hq+vTTO7SPQDU8x49mVQPD1Wegvrb4+4MwaSIs0aKEQvNl0da6N5h1byB7SnPJ6GD1IocDVZprtmphumJLbDBep54qNr5YMMKxA3q6GcZ0CQvGPX/pszQY9aK8kXLCUt+kUotW4MWSw5nC2D3LYX+7wM3JbMwKblmt4c8dgAsn32wPQMmYVTqHcyUxluQiXeRfebqS3u28C099Xbufl3NEKviK4/wopga4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66946007)(110136005)(66556008)(66476007)(54906003)(316002)(26005)(6506007)(2616005)(36756003)(6512007)(478600001)(53546011)(6486002)(83380400001)(38100700002)(5660300002)(44832011)(2906002)(31686004)(41300700001)(86362001)(31696002)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEs0N09JeUJzdGRoajZ6WkRTczgrbFMzemVKWVFYTkxhYlBsYjh0c0FtcUhD?=
 =?utf-8?B?UFk4dTNwcEpGQlhDTFF0VmJ1L2NQK0pDT0FOSUs1Tzc1OHpGa2taQjNXVUhC?=
 =?utf-8?B?dzViVVV5N1BRUXZYRVg4NXZHYndjRC9jbk1QMGx0RkU4ckcxaW5tY2Q5R1pM?=
 =?utf-8?B?Qnk0NlpaT1gyWjVCdDk5K1N1Z0dtajJVZEg5aHkvLzBwZGM5OFp4OFd2aHhO?=
 =?utf-8?B?ckxIZHhPZnM0dkxMTHhhY1JHK1IrTmVBNXdxRzlSczNBb2lRY29LTkhNZTB5?=
 =?utf-8?B?djNseDZrbVhUTjFOa3c3ZnpxU1VabmRnbEVQZTJRVEQ1Wnd0dURMT2JLbTBG?=
 =?utf-8?B?ck5mVUxKcndxS1VpWW9BRFN0elNPS2VrV2phNU1NQ2l1SEVnMGhISnZTcmhG?=
 =?utf-8?B?elA4aERqUG1CUlRWc3FEUnNOOHlaTXVESXZLMXNGZmtLNG9CWnFNbi9qZlpa?=
 =?utf-8?B?aE9HTUhXMTVWTEVQejBrUWhjOHZzNk14SjhUbUIzK2p4ZXMvOUZseWtOaTUy?=
 =?utf-8?B?M1ZWdDZKd3UyTVBzMzFMRlhWMTQvSkttek44VFhvU1lZSVExTWpaWXhHZVpD?=
 =?utf-8?B?cTlRU2kyN0xtTlByQ0pzd2gzL0MxTVpSajBaU0U1YmIrSkU4dElBQ2ZESFVr?=
 =?utf-8?B?eENSMTRWOFNSckFPYVJtMjUzSWk0UHVxRVFSZFJ0R3NMaUJpTDFVODQ3eTc0?=
 =?utf-8?B?NlV3TWcrTzJISjB6UmNOV0ZOSG56TURMS05Vbjdtb1VmVlVISVlRY2M0TGd5?=
 =?utf-8?B?Vlo3UkRpMnhaOFp4ZHdYdjlQN2pWa3NqWmtZMllhWThqVU0rVzRlQ2w2Q3Rl?=
 =?utf-8?B?WG50c2Noc0JqN0MwSXo5dWJoZmVxZjU3NDlNaS91bDBFUHVPWmxKYmdSS2hG?=
 =?utf-8?B?QTVac25scU9HVTJaYzBDOTc1MnpuZGRnSStSRTM3VUhock9Fd010Q2ZFVkxM?=
 =?utf-8?B?bnBTeXNwdkFTbUlLTTdzQ3M4WndJL0tad2tkeElTS1NLbFdkbnVYQ0RLTGhz?=
 =?utf-8?B?MzdEbm1LL2xwajBpK1N4Rzl1QlRMM2VvU2lPNGtJN1RPY29KMFdrUEhzS1Z4?=
 =?utf-8?B?QTBEdHZ1SDFhRUNqREl5VW1zbTIvWlZFVjlYL2E2MjJCSElsbFVPbndvSWJF?=
 =?utf-8?B?WGpiRG82YUxNUGZPQjVwYkxZNGxEMGV2aUVEL1drQ3B5emhVZGZ5WDloemNO?=
 =?utf-8?B?bnkyYUYvOHhwaXNiWHhGMGRlOUV4eXB0MmtpUHViencrNnBIZ1BKZFNEZnZF?=
 =?utf-8?B?MjNyMXVjSXpZMjMvdFRLUkJjbHlhTGhNUGs2WU1VTmwyazJWUFBkK3FHUUo4?=
 =?utf-8?B?VTd5eWZ3aTc3RDhPNjdOQ3hTaDdmYWl0azNJTTk2TGgxeXJ5YXFDU3BnRzVH?=
 =?utf-8?B?aDlhTnloSUUwbVZkY2tXcEYzS2M2MFdSV0RtMmhQVnJaVFJhWCtWN3lTRHkv?=
 =?utf-8?B?QTZHcTlqNkhEb2JXRXZDc3h6eFAwVlk3YVQ4UVFqYkFzdnF4Nk0yanAzMnRP?=
 =?utf-8?B?NjNSMjFGc3M0UFhicUp3WEVhemNkcjRpQStveTgwOW5xc0Q5VmRPOXE3Vksx?=
 =?utf-8?B?UHJ4eUFkU2o1VWs4SEo0b3hHR0drNlNabDdSWEpwLzRkYUtsWk9zeGk0RlZa?=
 =?utf-8?B?dzc1bHlGVWIwckZIZEhmY0l0YmNLcllFd2c3QW95RTRaekhwdU9JcXpsMms2?=
 =?utf-8?B?OWdxUC9ZOXFEVDZmekFHaW1hcHRFeWduaTh0RWQySXBack9xenJHZXBVWUlX?=
 =?utf-8?B?RXFqVldvM1hpSm5aSjB6TE1QdFN2QUJ0bVc3KzljbDhxVFVXT0RqRG92ZjRs?=
 =?utf-8?B?TERzOVh1bTlOa05JWm0ycG1oUmFqOVV2SW5Fd0E2aURoTDlYWG9sbmUyZGlm?=
 =?utf-8?B?azNpS25SUHVGN2pxUUtkUXZJcHM4T2VmL3VUaSttYzNYQ2RCanZIY2NnVUlW?=
 =?utf-8?B?ejROaXZ4R0djaG5JTHdvQjRyajF0M2IrNW5Eb0hvTnd4ZDVjbHFuWmtVRlhy?=
 =?utf-8?B?OFJEbDNXa1JHVFlTdklldkt2bWxncDlQbDhwcjEwOHNJckM0T1FNdERvNURS?=
 =?utf-8?B?SnRGWnpibmk0VkRFbEg0b1hrUVhyOUpSRmFzaU41Wjd3TWNXeWphWFdCNG5V?=
 =?utf-8?Q?iA2roo/DExcBC8H1o8EipBzhw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47fea2e-66b6-4f45-4fe8-08dbf025f602
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:23:23.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUgPTNaj81BhKgDMqdvWSXgrrFm2F1Ya6zuNk9gjOnAAXBxT5JLMMwMntvT5D9TvwSrCm5d31R1CnQGyZubEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2023 9:20 AM, Borislav Petkov wrote:
> On Thu, Nov 02, 2023 at 11:42:22AM +0000, Muralidhara M K wrote:
>> From: Muralidhara M K <muralidhara.mk@amd.com>
>>
>> AMD systems with Scalable MCA, each machine check error of a SMCA bank
>> type has an associated bit position in the bank's control (CTL) register.
> 
> Ontop of this. It is long overdue:
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 28 Nov 2023 14:37:56 +0100
> 
> Add some initial RAS documentation. The expectation is for this to
> collect all the user-visible features for interacting with the RAS
> features of the kernel.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   Documentation/RAS/ras.rst | 26 ++++++++++++++++++++++++++
>   Documentation/index.rst   |  1 +
>   2 files changed, 27 insertions(+)
>   create mode 100644 Documentation/RAS/ras.rst
> 
> diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/ras.rst
> new file mode 100644
> index 000000000000..2556b397cd27
> --- /dev/null
> +++ b/Documentation/RAS/ras.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Reliability, Availability and Serviceability features
> +=====================================================
> +
> +This documents different aspects of the RAS functionality present in the
> +kernel.
> +
> +Error decoding
> +---------------
> +
> +* x86
> +
> +Error decoding on AMD systems should be done using the rasdaemon tool:
> +https://github.com/mchehab/rasdaemon/
> +
> +While the daemon is running, it would automatically log and decode
> +errors. If not, one can still decode such errors by supplying the
> +hardware information from the error::
> +
> +        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca
> +
> +Also, the user can pass particular family and model to decode the error
> +string::
> +
> +        $ rasdaemon -p --status <STATUS> --ipid <IPID> --smca --family <CPU Family> --model <CPU Model> --bank <BANK_NUM>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..36e61783437c 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -113,6 +113,7 @@ to ReStructured Text format, or are simply too old.
>      :maxdepth: 1
>   
>      staging/index
> +   RAS/ras
>   
>   
>   Translations

Thanks for starting this. I'll add some notes for the AMD Address 
Translation Library in the next revision.

Thanks,
Yazen
