Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B407AAE99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjIVJps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjIVJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:45:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6818F;
        Fri, 22 Sep 2023 02:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOfFg+qsus5Ebbl85a2DFIaNqJxqpKyeSnTaK5M5tZ62hO8dyjq6yro60/QcO5BImJOGeus9JqkQa9K9NH5Deg3IkSWRRF6kwXgSKB76jHV4gVyC5087xXNyBoueQd9CJ2Xk9cLrstkaFKVglpazez+AuCCkRK2GVSL3tk+fghUXgP414foAUtW5xHhvEMLTz5Xo073sV1FaKJ2xQinH0r6rbqq3FDJCUS1ROUtJ79B0Ggy09SoieGvylka04L8UF+wnMWhy3c7cNLkvRA4duMRDXe97MSJDSjMLovrQus+RWZmmRn2/wq4MpeX91O7AQLxuXLhznVqs0TCwclvxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRoiacv9K3lI2bCpcZFdKqQFfreSL7ZBnp/e0l+Tv1Q=;
 b=Bf+vUqWGfY2jHlCw87YctutoUogbEfOrtOJq1wegUkN5dMlslyv5zOMlY9EioYcW4OW/qHeppsHxCVwgYeh064EAfcix+7ABQ4XwPlVdoNBTbKcekQw9TLmRq7HG00qjUNTKnWIZw9Zvhj2BZJtrHI5EU3sGfxf2Zm2AHGr3O47nmpbm3Tmnn6KZ7NS4/y5wiK+DGolflKzvzIc3yD8lIxbHekHhevuwkT0qvCUDsaZloubwtPKpLF31ShbTwh7BPF0Nnvpu8de0lgw19XlY3YspJrYnWhgxoMky/H7B84t7X0cl5p/MqnS104G1bhz+pGZdl/CsBueUNVsYixfJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRoiacv9K3lI2bCpcZFdKqQFfreSL7ZBnp/e0l+Tv1Q=;
 b=sH0xfaOPNIQ191A8BQgvzFr25RMvYcCWdy7O/eRkLknDyTErUgPpQbj+Smta3szQudzoIgqePqEN2boicmlXVGQV4gdxtRGJEt5bxgpHTL91NTaLiM8JpNztWTNdgHJoN/1bt//8VAphmlcFZ8qf5/ucu50LbO8PFZozkXQBSrPURBGHVsTCa7vzl17DQywu3sA4qQt8W6eQCCsOjd26qHk2Ga25Z72mvWactKFf1iSrh5OW2RU2/o8X8sfBkVN17HiF3CVzGJRj20r5UEWWRZDXaYEsgqfvk4bdzLCJsik5mgMuZnP3Z5apms4slmBx7VrWDsvzE1VJtizWjEia4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Fri, 22 Sep 2023 09:45:37 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 09:45:37 +0000
Message-ID: <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
Date:   Fri, 22 Sep 2023 10:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230920112835.549467415@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230920112835.549467415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: 544630f6-320d-4859-21a0-08dbbb50accb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22u3S43IMtFNrEzK7R6Yeh9jwMzoD072VgeAz5A68sjupUq1sLtlJU64JyVQssAg/jECAlClaPymf8j2cGvnzW29xwwasLV20WJeVfopFRrv6+GRNlxESgrvFZl/H0tSeYKeH1Kq6nyycazIWJNTjWUzxFIq5ba9lThSMR0hNRuwtzoeovia6Yjdm3/KDTJftpFc1GDde4fJKnMCZjqAxwaRgw7Txqyjka4xjhGmCZrOuMu2T3E+iEbOYjOS50vvmQKiCyM7KnIIpyc2XngWVQrmWRkIi8CwItbj+TmJTmzLhU97QO3+s2cd6meA3EN7ZfH8OkbMzT3Yf9tH7XilzjHkM2RrA5BnSKV6rrqxPCEfKe3LpN+1B7GyXeTZJB1DsRcB2WFu5uTMkyoe2H30BONoUJrT5vUl0Ecbi9j6Uo3sN4eDTbhn6iMc8koJzGrM/TEDZbMIVqvCGOkm5fA57PGobfr3Pw/Gi+9qaWsrhsRF/zeaiKkEv0ckW6uN+qF4ReunmXKiOGXuPLvFUp0JDoPFizO6cmqGf3hL/CjL6XKIPmsA9pjEziD3oMStkaShrmV1KNR6i8Cf6gNvWV7TWbw2swcPJUXOxkGFuvCxha9JlWCtH0qJG73P4lAka41NGlTASHSdIqz8GxqTR2q3J5AWeY7cJ3g7ijUzWmv10CB1kzSbCNReiBAbq/O0XqvI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199024)(1800799009)(186009)(31686004)(83380400001)(6506007)(53546011)(6512007)(5660300002)(4326008)(316002)(41300700001)(2906002)(36756003)(7416002)(8676002)(66556008)(8936002)(966005)(6666004)(31696002)(6486002)(66946007)(2616005)(86362001)(38100700002)(478600001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBSWGVybjczZkJmNUcxbU9lV3RvQXlDb3ZtSzl2ek4zaU8wa3NWcERURXhS?=
 =?utf-8?B?RytpWm1mTndQSUtCWlE5SEZHT1BJUjVqTVVQYUxEYTZlb1gwc29BOUtOdTQv?=
 =?utf-8?B?dzJkb1pDT01WS0M4eG1WZkdWSExJWmlOUWd4dlZCRmVtaGZGalg2MzBFVjlH?=
 =?utf-8?B?bGowdWNvRHFiZm9nNnB3RDN5OVlsYzN3U0YrbXUvSUVUSHlQbnFiRTZ0SVd0?=
 =?utf-8?B?YUFMcENFTlJySEZ4ZTF6TVhEdmtjL3M4b05KUGNtVXRwRkQ1MDE2cElEVi9h?=
 =?utf-8?B?ZERpWEFjVUdsR0IvYnpFVUZZT1JoZmozaUlWbDdPSnFzTjdabDdUVERqSnRw?=
 =?utf-8?B?c2hzT0pNdWF3UGFoR2wwU1FPaC9TdjVzZHhXUUZpU1J4QmVQVWFSczJ1Q0ty?=
 =?utf-8?B?K1EyNUxLd1NYbFlHQ1hoNzdWNkRMYjRLVStZa2Jrem1kVkI5NUdYMGxiMWls?=
 =?utf-8?B?U1FqeXRBblFkdkl3aWNjMXMrNENVZ1FZVXk3aVVVUFhvaGU1UWk4RUtROG1M?=
 =?utf-8?B?eVBHbUVnSmdYNTJoNmtZV3d3U3gyTUlUU1BmQ2FzZnhhSCtHcHVya21lSWdT?=
 =?utf-8?B?emgyelpSMFFURCs4WGcxOHg5Ym1OSGkzUFREc2prWnhSVG5RNDJrYW5UaFl4?=
 =?utf-8?B?M002Rlk4d1RLeHVySUhIc0pXNHArVmxrZkMrV2RzVzByMTFUWHV5MVNoN2lS?=
 =?utf-8?B?VUlsZC9rNG9KOVo1VnlYY0I4YlVKMjM2NytBRFdpeUVsY2ViOGNGMEN1VWo1?=
 =?utf-8?B?WW04Sk1ZUVc3V2VPS2l6R2pmZmNYZ0lUajZRZThMYzZmVnY3Ty84M29KaVdX?=
 =?utf-8?B?dHZnbENhUXp1Rm9ER0xGbFA0Z1NpYkp6YkI2L0NDVHV6aDgwSWxJVUdRZHYv?=
 =?utf-8?B?UHdDc0N4Qm5VdDh0bWlPbktEZ1lRcGplNEpYTnA1ZjlKb1lFZFdtb2dYWThP?=
 =?utf-8?B?ci82UVluMmhCK09jNXFuSVhwOUQwamZGMFoxWWVJTGhWTnZlS0ZqSGxsa2dM?=
 =?utf-8?B?V2EzVlBSOURFdW04clhWZXhJMXN0OVhzQWRjQVFKRU9ISGNHZVNTTTQ5TlNS?=
 =?utf-8?B?dHR4KzJuY3hZdHI0REZqeG0zdDVpUjA4WndRV0tSRnB3YVVTbVFxME55Q0gr?=
 =?utf-8?B?b29DSXJMb0drTHhJakpZS0V5N205cy9XMXg1UnNJQlhBQ3RZbVZ3MktqMm9h?=
 =?utf-8?B?c0preTdNRjliVDM2WFVQeG5XNTV5cmV5WU5PMEx4S0xOS29kbFlxL0NZSFRn?=
 =?utf-8?B?OURYdFV1TWNtdi8wdUI5ZlFBVFhMOFFBWDgvMGMzQUJ0aHhENkNIMHZmWEtP?=
 =?utf-8?B?M2tkdzVWZnh6bnRCVTVld09wR1pNVEp2VXFBZnBqWDNhaTFyTi9HeEtBYzdW?=
 =?utf-8?B?d08yb1JVMmd2a2J1SDJLMnpabnNJbGV0cnlRbXVlYWZQUW4xVnZSalVucTR1?=
 =?utf-8?B?aWllSmwxams1Q0tIZndoYzVNMHNKT20rNUwrTGo3bVNnUUNvM1RyU1FNTzN6?=
 =?utf-8?B?NTBuekoyK1B4L2JCdS9NZWlhblEyWGJkVENibHpUNGpMWGR5NW50aDZZY2pq?=
 =?utf-8?B?ZTVMMTBzUlQ0c3h1cENYVXh6N3ZFOTB1cDFUbzBackMyWlQ2a3lNRTgxTWE4?=
 =?utf-8?B?S1hBVFpvVHBWUCtKYm80K2pFY3paT3czVU52RzNkUk1DdGdOVEZJd0VtY0Jy?=
 =?utf-8?B?SkxadnFZWGF6eHVybHZNZDJxanl5OFdEcFlRUGcwZDJxTDQ5encyVUlEM3Iw?=
 =?utf-8?B?cXNjdkhxVWEwZnZqaHp1dERCTmZGRHZrWndxcXZ6bGdLM2ZxdGx5c1dVaXFj?=
 =?utf-8?B?Qzd6aWlKdS9mVHpBREU0VU13L3hGaEptdTdBSTdTdnNESTByVnA3ajJlUC9X?=
 =?utf-8?B?WnpsZnhFU3hNb2RpL2MrWDJFRVFCT3BlYXZBcVdmVy9HdVJMSWliZHB5Y3Vr?=
 =?utf-8?B?ckdET0ZpOXJkZnYzMTVKSmFrWkxMeC9GYXRGSnpLdjkwYm9BeXBHanlVODdh?=
 =?utf-8?B?NFBneUtIS1RTRzRZTi9HVUR2eE5scmM4aXBvdDc2MFRqUjRCYTE5OTczbkVx?=
 =?utf-8?B?K01VVGo0b1JXK2xkaGVDZDJXdUZpNEFkajgyWnZIOEdkTitheVZ0NlZxU2pY?=
 =?utf-8?B?TEgvdVNhWVFaOVpsZ2tScVRhSm9kOGVuWk9oSFF4cVBKTlZXVTRETHR4UGhF?=
 =?utf-8?Q?mlYHbRXYC3k1mB75052v79aV+tP8eMRRALMYwamRVGxK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544630f6-320d-4859-21a0-08dbbb50accb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:45:37.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfLhKulh3QGjlALECP70VS5x1Jm/sVmn3O6efrh1ycBtGXxxTxALQ0775jf/OSS588KdmSo9SHo4y76g0FgAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 20/09/2023 12:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.55 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I am seeing some suspend failures with this update ...

Test results for stable-v6.1:
     11 builds:	11 pass, 0 fail
     28 boots:	28 pass, 0 fail
     130 tests:	124 pass, 6 fail

Linux version:	6.1.55-rc1-gd5ace918366e
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra124-jetson-tk1: pm-system-suspend.sh
                 tegra186-p2771-0000: pm-system-suspend.sh
                 tegra20-ventana: pm-system-suspend.sh
                 tegra30-cardhu-a04: pm-system-suspend.sh

Bisect is underway.

Jon

-- 
nvpublic
