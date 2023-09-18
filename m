Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00337A4A27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbjIRMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbjIRMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:52:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9294;
        Mon, 18 Sep 2023 05:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVpGUh/29gWXqYtde86sSyqB73i/19iZsDW7J25HfBHofCvziUzaqXlwh2ugE4Z67B72shoNljh+q7jQMNNLNIuf8QBBubjSV3Lv/zc7hGJivKePP18x4IxBe8kkAh5vUz4y+VFZamYLZspOPu/6hR6a4ZrIBciHKgoFn1wWVMq8oWHmwGV6nDlFNNHGACCJnTHrbW+7+N+y6/1VFdh3JV1s2NuJhu6QlTU844hVYxPeSDnnOZIF+0AlPjdNANB1Sdx1Ib7fa+CfdASnSKkJL7wD68wgeDl3gQPfpC3U7/7DkDQge97h88vTa/rxjImTMxX81i1KkctrTVNqqyLqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ+38kORx3YmNmsRzSPYVBL+swHCpAySr/jdjuqt17M=;
 b=EXHbvnO/t4RxpSC4irH6TRT1am+7PpdM6I5LGrCowFTOVr5hd5txhpA5+UTHH/qjX+WEpXSrG7loIEDbZB2k7vqqMKgEdPuHjlADQAkzHUW/W1zQkNLpJpvYujG2P3/bMFrS/XcaWDgwaTdU+LJpaAZ8nnGg4IoUkU1an0H8tfcf3vgjYWoagoMTxXZZPg5WZ5J9AkW6TtV4Nt91sMsE669rbCtd5v6el5YcJ8aohJb2o1p0wwH2FTsxF0SOB+aCNDuyckaGgSI8YOQ1dMJNSBeoMod8dSc3w3JVMNflOAsZ6/ixUBHZS/TGVis++4sfd1/NVY3q1oP6oXn1yiKLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ+38kORx3YmNmsRzSPYVBL+swHCpAySr/jdjuqt17M=;
 b=BJ1OLOuxL5MAYUjanpHT1jvRjk89gCa5LLkIs/UpfvWoi26lx/jNewVM8TR23wCI990jqnk+Y9nKaeJ+9IlXw5LqDO8S4BAL5jeJ+S5NgUlfQQZLZdXm6mohIUHD3syR9lpygv/oFroBa0r4H4zX+kvrpmFSTB8pOPKCPo8d/otbR12kMOpFSCTxUzepgNkfu1y4bU2rzWVhOByFv9lcPZEbWt9S6riJri8GJj/NnUlBUd1ey55BByBJL/UaC5u0hAb7ZaI+pvum8bXxLql7fMseO4LCDJ008yRVhJ4SkuEbFIC1nfr0kyOL49XXoMxnOijzcHvKngsIvVOx8cBfOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:52:20 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 12:52:20 +0000
Message-ID: <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
Date:   Mon, 18 Sep 2023 13:52:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Content-Language: en-US
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
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0424.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37d::24) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: d40e3377-e32d-431d-7b77-08dbb846185b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEVGHaqC8u0F/JVE62hEosgiCPJXdEIND8mjLbfCtIeNJo6lY4fqbmsfxdPSZ33n+ssY4Eg54I9FpUxrQ3UnKxTdNZEG6WZHOMXnOKqn7puDEyRgINPPipyod6q0ryF7aXw41uWgICq2kJW7z6i3mYhXBnYwt1qyChIMguVRJKQT/xeoB/UcnVsNsZUZkdB8qs3qKhWfBvwsZjGyb93Fcnb/vqqNvVi49v1FqG6tf7vU01Jr2qXLBrD9K8FCb0ZOx4rWlJGxmgYXlIYV9Dh26H+XKAARgo/yEcgskPcHn5p8hf621lNxY8l3VdZ+uO0XSsWahlnVAQCwMC75dnzfliNcV4ssA8yJRCSY3tLo809VMxTomM9VGqZbUaFJ9OJdH+SnCbNvD59iNSLf1UU83wRWut6v1z2ezMYa1e/kWMhcf8OuMp3BubfKAQJJEHgXIdXUs/kjBshYA/eXRZDEPouZWnqQNMX1/08O0XMMVVfWOX/wi1iAwA3+VEXvuEg8XRifFOTDUp9n6ZqKgefwTRcoHt9WWJVx71ZwfSY9RaI4jcWxZ0AkMvWqiKSsPxXnRECSU2XWVQgfGsCIHFpayFd1wqhJk0FMBZpIDVUaegl1vtrUj1mu1fQbWLuoCXQ2IQ9U0hvSCuLOGB9U13sj3m5Cvk+1+ZS7/y1KdBF2+vttQ03eOAXJT+7ib/wjofNw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(451199024)(1800799009)(186009)(36756003)(38100700002)(86362001)(31696002)(31686004)(6486002)(6506007)(53546011)(478600001)(5660300002)(66946007)(66556008)(54906003)(66476007)(2906002)(6666004)(8676002)(4326008)(8936002)(966005)(6512007)(83380400001)(41300700001)(7416002)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThxVEFBMlh1a1FnTWpSK2V0Q1VjTk9mVTVtNmkrdnhSZGRGY3QxbTZFUHNW?=
 =?utf-8?B?VnM2QXdsK1JJdWZuWDhhanZNeGlRRUVDaStqcGtwWm9VOXZCZXByRktkQ0VS?=
 =?utf-8?B?M3B0aXNrd1N6Mk9QOTFvVFp6K3d3MW93MmtRUjZtQm1LN1pGVkZyNUFMUXA3?=
 =?utf-8?B?Ly9STkYySFZ5dWZGTnU4ek9Vbis3dnlVSnpFMlNYcEpmQjVwVGMrc2s2dFNE?=
 =?utf-8?B?TTdxeWZDYnRlNUt4VWU0cnBTQVhiNkpBME1ialJld0h4VWdNSk5iSWZLeWZT?=
 =?utf-8?B?U1h5dmZlQTZ5cmNUNzR6TTZsTUxmOUZySEEzdDdKM1kzQXAwdEFmNDVueGYr?=
 =?utf-8?B?RlFOeHp0d0tNTXl5L3BhTUE3LzJUL2VlQU1oUHU1MDUremZDR1BlaitXYkZQ?=
 =?utf-8?B?dnptTTY5aGw1b1pqNzQyQkJBMFp6MnM2TVExLytVbTFtTXZQRUtwd0dCUitG?=
 =?utf-8?B?LzIvRTBNODBxdGVGc01QR2NpQ3ZsSHBHdXEreUZwSzZDclloZDQ3V2h6a0Vm?=
 =?utf-8?B?QjNVbzZRajNBOFNhM1krcms1SkhLRjRBMW44SWlmejFlZUZ1N25Hc2txV0pv?=
 =?utf-8?B?VmFHMlFPN0N6VHFjYWxpekl4REQra3V2M2hldGZtWUJacW1jVENFa214YW8r?=
 =?utf-8?B?eDk4OWNRMFJvQVpmMGd3QUNwenJJWjNHZk1vQjNuUnFRVkU2d3FCcWFQVERH?=
 =?utf-8?B?ZFpJVkE4WUw1ZDNrT295KzNTNGQ0ckRTWXNtQUdad3Q2eVpOMXZrK1B6ZVp5?=
 =?utf-8?B?OHdoS09LYkgya25mWVJlVnFyRURTRUhWWXJocUp0eUR6MEZibVBlcDBKeU1y?=
 =?utf-8?B?elhOa2VUdGRWMXkwSjFVT0xId2NSOUY5WVAxejd0d2hLRW1jK09KTUNTNVFz?=
 =?utf-8?B?Z0s0UXVWVFRiMkV1Qlh5MkNSL3dIWUlVdXIwbU5UQjhkdWp1K2lia0cyVU0y?=
 =?utf-8?B?Nk9DWk1rSXBwa1RkL1dCQVoxMU0rcUNFNVRsUTdUZmYxWk1NOVlFaTNlMkhD?=
 =?utf-8?B?eEZWYTdDNlBGVDhmT01rRko4RVNSTGhsUzRHNXIvMUp1NEV3OUwycTBiYlRT?=
 =?utf-8?B?SDlWUjVDMVZnRWxPRDlKTVZjOFZST1VHNU5Uamt4UzRITGo0TzdCbCt5MndR?=
 =?utf-8?B?bVJzODhtWlR6ZzVvaVJabmtsOFFYL25HMWlzK1BCbUtxTlBrNTd6c1pua1dX?=
 =?utf-8?B?VTlZZzVBMTB3cGtJVDFwYTdya3RxMnZ0VkdrOUVDaG1xcWk1enM2YXNSQzNX?=
 =?utf-8?B?YUVXRVo0T0J0WjNEYlV2RndpYVNRblB3K0RHZEdVTkQvaXV1dmdUZTF0b29N?=
 =?utf-8?B?VTRZQjdkeXlCTWJFY0prQUFBWm1Wa0hXdldnMzVhLzZwczdOSkQrTzE0NjJR?=
 =?utf-8?B?S2EyT0JKRFJ4QjBXNWN0aGg4ZEN0RC91S2MzT1RadGF3WE9pOXZpQjJEb2lo?=
 =?utf-8?B?MzRIMlJmdmtwQkFxK1hVWGViMnhmNFQzNUtYVVU2VkFpYzBDdXhzd3UwZTM2?=
 =?utf-8?B?d3VzTVB1SFNBOGFyVE4rZDhMRjdPRTEzNExSWUZIUDNLUUgrUlAzR3NhRTNn?=
 =?utf-8?B?Y2lNR2dGUWdoOUZyOTZaUkpwT3FybVJVSzlrSU9vaWYzOWN3ekNTY3lqYVc4?=
 =?utf-8?B?d01DcVpBa1NBYWJ4cTZzUS9yMFN6akYwMTRsQ2MxSWdoQXVOSFdFdnVPMHpY?=
 =?utf-8?B?ZG5XT0VKdmF5U2lScEVKeERHMllCYSt5V1ZEZis1a0FLTHdLWUVmU2FTNW5C?=
 =?utf-8?B?WkpmUFJnUUJIa1hDcXRZUkhpbG1NTTRoZCthU1lBSUcyS0UxOUhPeXJIN3pE?=
 =?utf-8?B?eVRwVVZIKzRtUGNRdDBZWmZTOStRbWNMc1hsdDRmdDd2MkpMY2t5MUxlVFVS?=
 =?utf-8?B?dUdWdHlNQW44cGpBSXhqOFUzWVByTE1Uekx6cUdyeVYyS3RDYlpmRWx1VzNL?=
 =?utf-8?B?eERCSy95eUxFS3RHOHlmNjBhK0VhRFByNXhjWXJ6RDQ0aUorTDRSNDVOR0Jr?=
 =?utf-8?B?WUFFNGlQMi9jRkxCcTMrdWpncnBWbC9WVXp2b3ZnMHhReGxtb2xWWDVaQUFR?=
 =?utf-8?B?dGJybDlCT1hHTlVTWk1aTFZSeHB0bjVlTm1DcHRrdGk1VG9jazB0SlNRSUhy?=
 =?utf-8?B?QXdtYlJoNmdCWnhzY3JFL0c3bTNaZzQ2NkNFcFdGc241MEJ6ZmZGZkQ3YkJU?=
 =?utf-8?B?WFM4UHZlRnpwWUY0L09xY0o1Sk9HdUhaMkd0emJXTCtHcmlNOWd6TE1pREMx?=
 =?utf-8?B?cVFiVSsyYUlWeEw2UlVJNXBTaWpnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40e3377-e32d-431d-7b77-08dbb846185b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:52:20.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apU6FqLFyLTO6cv/dkOSR1KQQXRmZTJZ+5VN+XGMQxZHOAABe+WmFMzL3ih8c4eGiJ6U9XCcFnNhguSOkvbpIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.4 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:

...

> Sameer Pujar <spujar@nvidia.com>
>      arm64: tegra: Update AHUB clock parent and rate


Unfortunately, the above change is causing a regression in one of our 
audio tests and we are looking into why this is.

Can we drop this from stable for now?

Sorry about this.

Jon

-- 
nvpublic
