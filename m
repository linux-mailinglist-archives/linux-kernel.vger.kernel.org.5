Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93567A4BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbjIRPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjIRPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:23:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D110D8;
        Mon, 18 Sep 2023 08:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAKIfFHDms5iSd/uDjlL1IkgYBv++kfDs+COYLes9iSPDnSQv+DAPuuaGtzvGy6Yg1xODGciWa/cU5Z5S8vBaf/zqt0YDVwv92Ioeikp9tjL22OpE6ZYqro4nYnDuc2pnphUr/TJQIAFeEpnfG4J7JK0mow7irjxu8GBmRBB+/o4ZHiA0NgvY2W5rwL2y08QzPkjDGXhvqD+is3BuS/WplkTdXf1Nv8GnOgwdLuQwnI0PnlStLPI942wffd3BH1a5poEgRQYkYtzrpQGHhbnJj7M9ZbdbUMQmnbGHH70C+epNXmvxpQnDyjKigo/Uj7Bveem53FT9CVwjuBQR/ImlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9J/kcn12pcwQxtwIeqY0dQuViN7dGtoTOrVIBuOQEI=;
 b=GohMkFBy7HcbPvAgqVBadOEtknsIkxQbUG6muvh+v2W1t7dJeu/fXclSNt6LA8igDAoDLX3e7DD9ZoXwKzJQxGf7d4riCD2TV27FobzNjfk/z8k+M9nTUn8aY/CE96V8X8DJQ0sKvYSWg5Vr+O6FG9fmP2T1PYGMDEEC1dUPMLyC5uqoGB4Q0PTk7fo22SLm1wayeCXO3F03EoORtIReNehSslQbbCa87jdpSJmB5WN0sglYDmgUTEAxPJTfRpjFX+y3+rE5Rl6WIxB7uQNiCt4u0UwIVK0+CX2059cd1r9Ki44ie/GmeqzZGFcudywXAKRrd4cG99B+PjggeLPm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9J/kcn12pcwQxtwIeqY0dQuViN7dGtoTOrVIBuOQEI=;
 b=VPyWJsGa0eikNqvw6QWT08XHzfhU4Q7E2AH2jJGizeuZyFs72lro0dvlGZDSohFBaKIyUHy9KaC4dsV5KccldfbE6hiAmJfMG75fqWjPrsAlgWnGSqFVmPJcRJLXCi1/d6u/Jw4eKHLwCdQAd6CZ6KqB+fPujIS24M4z51xKDzdBOIbHRJeo4VRaTj/k7GVx06wIBsYLf6gbfsbedfnVnRrFQzovXP9wJsP0nftni2wnPXGgdhUwXTMbdH9ivahRV4ypxxFQxR4cGbsNKbnClZQwk5KBpd6KrK1js6JKPtdGqXhuZswBKZ6QEZUo9YW+VrsPXLSiLpHERAu47PRUqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 13:04:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:04:36 +0000
Message-ID: <e5a0e1cc-1360-23fe-408d-03f46dd76c5f@nvidia.com>
Date:   Mon, 18 Sep 2023 14:04:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
In-Reply-To: <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0324.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9fcbe0-1726-48e7-59f3-08dbb847cf59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B9YEXbPyCcoesxlGR4sK1YMc4yRZTgrYRVQ1FdMI1RdDaflnriXf4o9lC6iFvPLsIOATzYlbUzyxVDM9FlibOjq74x+F7sBlBd5nThO+hf77k3AK/A/yIfFfJDmqZDop+eMkiq29HlwHjoe7KPZKqDJf2/69w3dNCRi2xst9NtKS2kasUlrccAzTiw8fC99WWAx6/N28KkMdjF3wqnK+gAHp7qagRdh1QTxbv6ThEnTCI/C2iTfw7Fwmbs88/mCrYevi/6ksRRVctFUM9UE8Hj87yPqBVcnileeVWe1f7QN8KOSLz8lyK9X+oXbQ2xe4yBrqkkBVHKUZ8UIEkk3Ihxuviil1ygCiedGqUKRuWUxEci26jqsimyuKMXgPqzQuxvb7hy/rDaTw2fdmLuzBnJzVL2t6F1jZl0j5w/24K67+ujhH1LBofq1xY09YW2cuUGPX8qZorhjhKGHOr1pPtC9gB3HjCdb+HW+jRz4satkJN/c4fFZc824lUMtSoZ5xO2CQMJUnPmDCNjeFcL6P1P0le9FdcZhGurHrv0lwghOEmR/HrNTnpL1PzK+RIA6GtypET3RGsj7OT3luK5kDbJITRUQpYwgZHDkedD/qnWqBNPlTqYgau16doCphwFC1+POjUcNeiGIHcCjRnWAqvnrP/loeZdyPyoYG9+pgpU7nsCX3oBu3muHdOp0qucLA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(38100700002)(36756003)(86362001)(31696002)(478600001)(966005)(66946007)(66556008)(66476007)(54906003)(2906002)(6512007)(6666004)(53546011)(6506007)(6486002)(8676002)(8936002)(4326008)(5660300002)(31686004)(41300700001)(7416002)(316002)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1jMkh0aG9JTzRrZGZDdHVTSVJ4QThJMm53U3pBTmRhTlhza0xWcjBUNVBD?=
 =?utf-8?B?cUJrakRVYWZjUDZrSHo3bzdQb3ZKQ0dKVnErTTZzUnlmQm14ZUx6Umg5TS9C?=
 =?utf-8?B?ZTFweWpqZjB5ZVdjOVg3b1BTRTNJV2I0MG5xSTZaV1V0WnFscll4eCtxdDhL?=
 =?utf-8?B?a2xhTlpzdHg5b2tRQW1WSlcxV2lIY3lGaDI5VWxSd2doWWRwakt5cWgydVFE?=
 =?utf-8?B?T1VoSWthU1pNU3Z0RFdTSk8venhKNXg1Uk9OTTFPVW14dFFoK0VDSlYrbHQ3?=
 =?utf-8?B?VzJ5NHFRTU83eW9nVzExUTlqbkJ6UEN0TUgrVlp6YXVXUDhFT1R2YkQrSGJu?=
 =?utf-8?B?aitxc3YxSXNZU3QweG5hUk13UXlPRVBaa2dnK1RiOVFoTWhoUGU2RnhFZE91?=
 =?utf-8?B?UG9JbE02KzM4aDZRTGJqV1l2S1gxN2xHczBqcWJLRzAyY2tGK043SE8zK0NK?=
 =?utf-8?B?K3hLdWFnNkxkTE9KN2NPamQ3emZHR0RZWm1hL3k3Vkd4V2xoWjJhK2hubEpa?=
 =?utf-8?B?Y0xvZC8zb25yUFhZanhGcHQyZXpjSU83cEs1bGJ6dk5BWEQzUWI5dnArZFpn?=
 =?utf-8?B?NVV4c3lPUEV6OFd6NGVPREx0WDRwNGp3TUtlQ2lWR0pLcjJjZ2ZhbXJOc3NF?=
 =?utf-8?B?YWszRHVHYWtJOThqeWdlMVlRdXZmRWQ0czA0a013eGVBdnpVUnFPbTZFLzdk?=
 =?utf-8?B?cXRNMjdTYmZjWUFUTHFkVm5aZ21Nb2RuMEVZYnBqc3dqcTZ6MW9sOUYzVnRa?=
 =?utf-8?B?K3hwWjdEaGVTSWNTTnJzMXExUHpraXBRTUpIN243SWsvdjZxNmZVdVFWSHlE?=
 =?utf-8?B?dElWWGYvOXhyWThLQmtHZUVwYi9NYTdCUjJqMk9MWmUrQWx0TWZNWmE3TGZ6?=
 =?utf-8?B?V25qbjMrWXNrYWk1eEdoQkpUZDE2VkFSb3VZbExsQ3lqcDRyUW9HZWovUnJS?=
 =?utf-8?B?VkFsaTZyRDBaeE5lcEh6WnM0cHRpOC92V3FMTkFDU2hjd3VwNnV4NzI5Qllr?=
 =?utf-8?B?c0dmeFBMeFZ6NFovaVB6K2F5REEzczdkK0NxSlNTUUhWcW9wNzRMWXFCNmxp?=
 =?utf-8?B?Q01OSDhoODB6ZEZaMTdTVVRObllLRUR1S2ZDREF4Rko0eTJLS0NPdmRyWExJ?=
 =?utf-8?B?d3BTb0RRbUNkL1RqM29HWENaTzVtQ24vSUVCck04T0lNdmxhV2ZmSkEvK2FM?=
 =?utf-8?B?TkR3WkJiUTRFdTRpSEFkeTZvREQ0UFVLUi9xZTE5ZTh5empBTFpKUStRcm1u?=
 =?utf-8?B?YktJbk53b3FSQm5qamQ4aDRiVEt3am5CWllnV3M1OEM2UUpEejEzcjZVT3hm?=
 =?utf-8?B?b1VoSG9KNFg5VjV6N1BiZW13MmI0SjJUVXJIL2xBVjBCOXlUZ2VHTnFZRlBt?=
 =?utf-8?B?Y1dNbldaVVlUOXo5SDJma2pUTkxpSkZ6T3dCaHFCWXR5TC96dnNLTW1VWHVB?=
 =?utf-8?B?YU9BcVhsZWw3UG1FMDJoKzZQN3RISnAxR09GbkVDd29vYnNRQzNNQ2xRcTZv?=
 =?utf-8?B?L0pBbFNRQmxJTitsREI3QUZIQ043bUU1bjJvcEdXNXQvRUVJOFVnSlJCY29G?=
 =?utf-8?B?ZlQxcStUZWhYcXd6VlIxVUJHVjMvZmwrMUNQRFNWRTkrYk1zNlp4dWFIMElY?=
 =?utf-8?B?MGJzUlBhT1g2U0E0ZFZWRXIwMFVzQUdYYXpoYVJIZjR1VittZ2lOUTNyOGw1?=
 =?utf-8?B?QUdEYk5YczladXJaSWxiZ1hrcDlpTGwySndLbkl4bFdxU3REU0wrTm5zeVlG?=
 =?utf-8?B?RHI2U3FGT3phN3RYR3pXUkhVOWkybnAraXoyazhiQWRHMlNzc2NXejIzcGpI?=
 =?utf-8?B?ZzA5WGJjWU8rZEpuK2IvQkw2K3lMYnJzOE1laXlBRVFkSm5TSjF6dFFXaTB3?=
 =?utf-8?B?R0xRSzcvbUUvS2kzZDZTZnZOUXVaSlFMdlJmZlZBVGRBZVdVZkFaNlFreFdE?=
 =?utf-8?B?R0tjaEU4UHpSQTY3enF6cUtFNEpuUGM3MmczYmhzNUtjTVA4M3BpQUgrcXpQ?=
 =?utf-8?B?NHNVVnBEdDlUQm4xOVVab0NTS3J1Um5KZm93dllqbHlNeTlFeHc2NEg3akxJ?=
 =?utf-8?B?ZWhwN0xuQ2hYNGdhZVZvNlRRU2s3ZnBlWFcvU0tGWHVUbGV3M0lBTVFlYUlL?=
 =?utf-8?B?dzU5MXEranhuOHFob3h2TlpiNmNpTm95U2lFS1FPSVAzQXV4OWRGSTNRMk1D?=
 =?utf-8?B?WGRaOVpxSVRHOFVreE42aGVJaXBUeTB4b1ZxWGEzd2plYm9YaXlFRTR4Rk15?=
 =?utf-8?B?TzhGOWQ3dXZQZ3YvSGZnMTc2S1l3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9fcbe0-1726-48e7-59f3-08dbb847cf59
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 13:04:36.6349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yWrefq2ODcoNI+8XpvEvsNItdfR5SDr/b/hTkM3ttxZEZlbCrNfmquIhTkSLashMS6unuDCMW83zq5ITHOfQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/09/2023 13:52, Jon Hunter wrote:
> Hi Greg,
> 
> On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.5.4 release.
>> There are 285 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
>> -------------
>> Pseudo-Shortlog of commits:
> 
> ...
> 
>> Sameer Pujar <spujar@nvidia.com>
>>      arm64: tegra: Update AHUB clock parent and rate
> 
> 
> Unfortunately, the above change is causing a regression in one of our 
> audio tests and we are looking into why this is.
> 
> Can we drop this from stable for now?


An alternative to dropping this change is to pull in the following fixes ...

https://lore.kernel.org/linux-tegra/169447691068.2390116.10518505217580469969.b4-ty@kernel.org/T/#t

Thanks
Jon

-- 
nvpublic
