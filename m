Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8A778DD92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbjH3Sv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243466AbjH3LHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:07:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA41BF;
        Wed, 30 Aug 2023 04:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOLUKVhWMHRlKTDRdf+Aa3ae+rBnvDrjd46Gy7Y5HUhsBT0fv5B9Tm1xpOSopdHUZnuhJMEuYMqbP79kZDvPuQVaz9fPmHB0psh5dKtvSL+eyqr0DBPlBC15EV1ZPm/iTseHYHD5vrZIKnB2hQmNxEZB2ous2Y62odjNWdhfMG1HqTubRRG6GY0CvQKP3fBRJl1nfgbQJb0FnIkA5RiklWf4CVD8BIDktwy43MeYYTIW0vYWa38BN3Gywt0iv2u+y+drCbC6t5getS94PzmtLOpMNtVI/mT0Wskbm3r0UkCZowcPROBCf0vdbZpiEurViFFoKoSg9rS66x+OOuMOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FZyxkndTsFwNtE4mF3Bsn7zW5ubTF4teOW+DY5a2OU=;
 b=HY5wFU6ZNwNLsSO82WPeAwOH5lmyiSZE1q1mQphO6oBEALlE+ateWoE0ISmVyTwOc9b05aEgczRyJlejhXZt81RW5UNFCJiwRGFKcZz2rnhZUP9SKTzOydSUKO/kcMfQErchwl2J6RX6Hk2GmFQAq/XqHP5yX/KUR4aHnYqtt9mZuxo4tsLR6yKBoqiMVOc8mnrp6jFzk9YScd/LAeKUrmoVXGUUYLr9u6YWJMObBAgh/5VAH4cX4bFOp5Ok2ahS4A2TfOqFLu5lZ89YU1ohc2ZNDis4JJznASWb9OXrRJylo5Vi4ur6OI+l4/AfIlF7dzlwf64waViGRMPCtRt5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FZyxkndTsFwNtE4mF3Bsn7zW5ubTF4teOW+DY5a2OU=;
 b=aOC+CMgTrd0VygjIF7arSh5SF8/KoFb/94FMMT8MURUmUA+6PGcMhTj+VH17kzhqFXVwB5B7WqY03P9JFDcC4NmwbDaF8XXr9hScuvh6lBpTfa1zXAT7WjBTk9ZQsxRAE4LQmLZGNjf2aOXv8iFfr1rIAFIFoCit32P3FA2f6k80p+m4LF1aBKYEVvjhgnOYmsUkSFNMARGf04JgPQCtKCKb98DTieoCeuxy1aqoFIatKbEc0LIACrlmAKn58mutK9iBtiGqVUdwB8UdcRSsJADOXFJk2uXsjmQ6FNUC89TK5uAlUI5BRlc1xfclI7yGp9FFQ7HymbVScgVGcjk5Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 11:06:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 11:06:58 +0000
Message-ID: <947f4170-f8ca-11db-15bc-aafdd1670fe9@nvidia.com>
Date:   Wed, 30 Aug 2023 12:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, linux-tegra@vger.kernel.org,
        stable@vger.kernel.org
References: <20230828101153.030066927@linuxfoundation.org>
 <20604021-9f6c-4c11-9335-cc9fa10d7c63@rnnvmail204.nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20604021-9f6c-4c11-9335-cc9fa10d7c63@rnnvmail204.nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0592.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6a684d-1c6d-4bea-4a4e-08dba9493a60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tyEgvyjYfeP9at1WJIuxxQy1GhJje0GyzXOkJNlefqU/5leO51u86RPTrNf4n8imk1OiMKfCNdSFyKUNzVZ2XFVRLOm9Hp59MbWghRQf3HuozJkp11/KJdiPBqsS70iIk+kqISobvnvx1N6LC8zEqREQXn1xFeMgn/8SibtSgmzDHiP9ebNsqR1IYBtf24AXhL9Y36xkOO+cF8NUlLWpJUxi55Fcsd3T/0qDwxpIHMnMgxd5jS02CsLVkN+mhqiumZ9zbgjGE8UycnfRJayq/AM+rrvNoeOp1Bx3N4Seo8CTV0RTKq/nMNkWCsZMLFgOzaYMtGe9EqdFDEv0xypt5+zI5P03f7HRMhij/2XidnrGeEri23SK1Lj7UcMlJqN7iCR4F5b1bitaHolt2OSMziKGFGohqtulBkUb1OUHhDoHAFY+vRka4DBpbG6lmDc+DGGkXPfJD+cn6PdFKE5XXROM2DzK9Dwln40D+HWyzCofTHNoBLjvjyXP4ljaN8YG+K4WPT12kge5f5J3ygxEAHSD8ZQDclsnpb/Em0TqfV9iTXYBxns/BiU/wR2p5ISGva4qMk3L2ikY5hseFfirWbHx0+aS6/0RB7u/vKPUJBbgPcVKKvUxBpqUhziqVMrU3+qOMKbokoPj9OKZAuFU5/rsVT60wDdXe3RrWrjDlwg2kx/xU3NAZvpo363pFmi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(31686004)(2906002)(5660300002)(7416002)(31696002)(86362001)(36756003)(38100700002)(8676002)(4326008)(41300700001)(8936002)(83380400001)(66556008)(26005)(316002)(2616005)(6512007)(6916009)(55236004)(6506007)(53546011)(6486002)(6666004)(966005)(66476007)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktJU1QrTDJ0V1dFSFRzeXdLN2tieERJTEFFczZweGZSMUtKRlNWMW5BOUI5?=
 =?utf-8?B?ZzFGRHhpOU5FbjZVWjVqanpXKzZmNnEvNUdtK2hsM1dUbFhmejJkUUhtbXlj?=
 =?utf-8?B?Ym1qeWpYdDlxMmVJck03djdKQ21HQlNrMnRtRjNta2J4ZnhEang2ZHJsY0p1?=
 =?utf-8?B?b201SVhoSnVoRE1UMkEzZktkZGl1TWoySSt2dStoS2VTQytCL08yNWRWZnhr?=
 =?utf-8?B?eUdRYklVRExpcERWU0RrK3Z6ZmtnbzdwYTZwTWNoVlAxZG5lcUEvT1lpUFYr?=
 =?utf-8?B?SlBWTmZ3eExnVFZtZVJUQlNRU2FaenN0N1VITzdSOWt1NDVoOHJTVEl1dzYr?=
 =?utf-8?B?OUx5MVhQNW8vcTBPUlNQaFdQUG4yOE9zUCtNRi9LTDRERmJsQWM3WFM0WkZO?=
 =?utf-8?B?UUdWd08wdmVNcHpQN0ZzV3hRSkFNY2wyaExVR3dmWGw2WGFWZHM0NTZxNFRq?=
 =?utf-8?B?bHovY2dXMVZLMkMwY3hmRDZXZnFwVDUxVGJRd1ExaFU0Vk5YbWNkcVh0dGhK?=
 =?utf-8?B?SEcyalJVMHRGbElRbFhLOGF6K0RxakYxOTBCMk5CVVVLVnRtbmRTTkxhSjZk?=
 =?utf-8?B?dXo3bzVBM2w0a2UvSlVXMFhLdU8yQTc0ZVFYbG41QlRBdmJKajR5ZlowcHdz?=
 =?utf-8?B?czI2YkJpc2ZVa1o2bXdGL09oem9RWmVXa2d4N2creDRTdkNndXlWRFVOcVVm?=
 =?utf-8?B?a2xmMXVUbmdYZThQMTFMYWZub1dNSVNqdGZNMWk5bWg1RHlJMS9NNUJ1RTl3?=
 =?utf-8?B?Uk9Sc1B6M2NneCtQczh6UzNZZFRnY3NlMEhhS0dJRUk2UnZQLzBnM0Y3emFq?=
 =?utf-8?B?ckRibUlrempoRWUxQmtqcjNiSVIvb3dXdERoVm01M3VxVGhpTTJqNWRJZm56?=
 =?utf-8?B?TlN5Wm41VnNCUjNWbXlaa1F2M0xvWjBOZTB5M3ZjQ3FnTGRJZ1E1OSs1Um4r?=
 =?utf-8?B?NnkxQ2k1QTdOTnpXb2cyMmhDZkp0TzJCeXY2Y2xwcnU0YXlRRWt4bDlhV3pj?=
 =?utf-8?B?QWkyb3BCRHVNQ0xFQ29PTWZGSWxoMEtjaHpieHJYTDJyTTc5RGRZWVJMUTRl?=
 =?utf-8?B?M2NPb2pTSitlWDk5S244OFpHdHFKWk1jSVBlbSs3dXh5WGRLaUtQUjQzMit6?=
 =?utf-8?B?SlBDTkpsei9PQW1YTFRHSEt6UW9zMFV4MU1tQ0QrR2ZhNjdzeEVKUEhVY3lD?=
 =?utf-8?B?ZjVlYWNUZk9IWVc1RmJUNkNERE5DMVBwN3dMVEFhZzdMdXdPZ1laWU5DSFJi?=
 =?utf-8?B?anZOYmV0SkhDRUZrVzlReFZMS05pMjZhQklmdnM5RW5UWkpwSWlyMkRvQ0No?=
 =?utf-8?B?L3ZaM2xldjIrQWsxblJTc0tPUWpzb0N4S1BKaC96Ry80WENhNjZ5OGlxS29N?=
 =?utf-8?B?V0xQdXVhMlo0UFNPVjJweHRveGhLV3NIYWllVjR0TzJBbjR5ckJ4Rk5vVVhU?=
 =?utf-8?B?VDVVWkZZbmhadHFLamVidzZQbStWZ1FoSFlPVkxEZm1OK2tGdGtyRHo5cy9z?=
 =?utf-8?B?QUlzWTJYTDlVdERCNkZHL25vUkEybG9vY3J1SkFybnh0SUE3TDFjRWFkWVJS?=
 =?utf-8?B?S2ZZUXNOWXJYdXZ4clBjaEZFUTFFTmo4eVRxellPWFZ5K0orcVZOdjBxSmdB?=
 =?utf-8?B?cHFVaXlXWFBlcWV1aUQvY3RMaG5NNlpMZEJJUjlpZFJaM1RscHNJdVBpS0hn?=
 =?utf-8?B?VWtIcVNMcHBvN2FVakVrRk01Sm5zUDF0a3lDbEk1dmFwVW5XdU1idmJVdUhF?=
 =?utf-8?B?eldlbkZ4MVVDM2pSOENMZitvN3NkMk1pQzVPQXUwY1MzS3JKKzJlVXFFWXpB?=
 =?utf-8?B?VzE0M2NKTWxPTUdWN2EyNVFydVpJdW12bWZyVk9MNzQxR3dnUURXNDRqVm1N?=
 =?utf-8?B?MnMySC8zRVhoc2IzZ0E1THhEOExHVFFzV0dVeWdpWXFKYS9sei9CMHVSZUxN?=
 =?utf-8?B?UFYzZXhlckNrNm5hRFhBNWpMM1RCeUp4bWhiS1pGbUNJNG01cUI1N3ltZFkw?=
 =?utf-8?B?Q2ZpTVpIT1NWWjNWMWs2REFDWjRzelcxcDRQVkIySXpKMU5jNWYyREhsZ2FQ?=
 =?utf-8?B?MVZlZjNDMVR6aEVmbHNlQ3p5bU5Zc1Rzbm5rVlVPbzg4THl3a2dOMGM4M0hx?=
 =?utf-8?B?RlZxbGp4bUE5ajRIUHNyUFI5UUFaS01uY1kzck5HcUI2K204blRzbkZ2ZWEz?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6a684d-1c6d-4bea-4a4e-08dba9493a60
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 11:06:58.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pusiTWZMzekJupUh0KJCYA+CyB3s7P4iUEBbP3F6iVvGI8qX4JHUh8YgnEgjl1ENDxrf+XiPXN27xdhkQo49MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2023 12:04, Jon Hunter wrote:
> On Mon, 28 Aug 2023 12:11:34 +0200, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.19.293 release.
>> There are 129 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.293-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> Failures detected for Tegra ...
> 
> Test results for stable-v4.19:
>      11 builds:	6 pass, 5 fail
>      14 boots:	14 pass, 0 fail
>      24 tests:	24 pass, 0 fail
> 
> Linux version:	4.19.293-rc1-ga291d82603f3
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                  tegra194-p2972-0000, tegra20-ventana,
>                  tegra210-p2371-2180, tegra30-cardhu-a04
> 
> Builds failed:	aarch64+defconfig+jetson, arm+multi_v7


It is the same build issue everyone is reporting ...

  kernel/drivers/bus/ti-sysc.c: In function ‘sysc_reset’:
  kernel/drivers/bus/ti-sysc.c:982:8: error: implicit declaration of function ‘sysc_read_sysconfig’; did you mean ‘sysc_read_revision’? [-Werror=implicit-function-declaration]
   val = sysc_read_sysconfig(ddata);
         ^~~~~~~~~~~~~~~~~~~

Jon

-- 
nvpublic
