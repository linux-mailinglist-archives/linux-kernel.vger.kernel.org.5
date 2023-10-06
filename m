Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5417BB46B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjJFJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjJFJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:40:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF74BE;
        Fri,  6 Oct 2023 02:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtO8LqsQ3uDSgkgBnc6kAEXlbttXy4KvjeCcc1XYh9HzVr7ns1BO+D52XpOHKWZCm2HvR1hXsN4KMROCDG1uTgN6/JKkE+cYduxHNB/PObsMrJei2Tr7eZem0XBkRaweGZpNo1nrZP4TSIQOSiKzOFvNn8wS5f+u9+kCPCeDAljYD04iB1mWWr+wzry3p58g6UspaTepoaqa1RB5lnG4KiJfEZReUpeX5DZ8EJkCaMMraOqyrKuwkjYaDPS9zrWNhLlTos4m2UEJn9oQZOCpQygizfEsd7PWzzwrJudbHsA/fhRq5GGsypiHOd+n4qHM810zaJmErYzeIg5WCgH11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swih1t0KKUAo10f+ElhLkPb3inrgqPQsrhxC7x6Zhb4=;
 b=Z8xTEwceWd9eYTZLqzpaxtMXSnaBXqJMRwGkTR/kudRbVysWUCUlNBaintR1ursDGeg4siUHrfCEbcNb+6h1kKNvh6xCS3VYS9iRecSARYHISsRUYsuW6f6F1dxCQveO0Jdoj9bTbLLFaRRD+vVqaiAexygliA/YK8ZQYf14DwKHnQqoEQWJUD/QcmTuuCSaeS4G0yKOUsP1i0T3g85JmCrJemQr/3nrCy/btXojIM5EdBwR0m3rq8Q4gmbikIm5ymPatRrXG8WCkmWKBhtekM8MGjlGe1ilLRjOIy1TSqWaLUnnrx6V93wD+i7V7hq2ko0VdfzExPWd9VN0e8aHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swih1t0KKUAo10f+ElhLkPb3inrgqPQsrhxC7x6Zhb4=;
 b=JsXaN5073n+M5XKS5nk0Npi42sAH7L//sce7flbbjjEVpQLLhhEjIiisAT5/AoXx9Xwnki4il6c+HYTvm57niBS2OC9no1YvP5NrJVU6lViPOajUEgTTLMuuPfmpQA0rDg3ztVPsrLmCIaseZCJaoRnEpGX2e+z25SvVyZWkzZ8skTWsqTrHfH8xKWcEUC97AG+b1SmAHtPZXyTVdk3Ui94TYSHNe54JzkTslY6COYU1bAiy4Upyj/c8QMdytjS2tAiAO6rDXDVm81VJo5vB5xuiMI8X9PVaTOB+E4lwXA2Hpgr4NO/0AYAmbtUT3txP2ASpegECCVqGclamTXyUdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Fri, 6 Oct
 2023 09:40:38 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3356:8104:bbc3:69fc]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::3356:8104:bbc3:69fc%7]) with mapi id 15.20.6813.027; Fri, 6 Oct 2023
 09:40:38 +0000
Message-ID: <018d458a-2d99-40ae-b8e7-e832b44a6478@nvidia.com>
Date:   Fri, 6 Oct 2023 10:40:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.5 000/321] 6.5.6-rc1 review
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
References: <20231004175229.211487444@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0005.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::17)
 To CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: a0738846-1a6d-4567-2df6-08dbc6504c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFtE39OGeQWW+aNECROB8Mf0Su1ALmznGVIFIuZlN3u2C8VnFzKoSoT1s4WeKyL6jvx+9KDfBq8OYFdmvQiEDfPAc03aCvZLE6CHrhvL6Cky7uA5jukkqi2RTLf6Ke5t06DTp1CRf1/oHEXdC0Ko+NKpCBYXCp71pd6tbgWb7zzIdLcTH+KBblitkRW50VGLsEL9jh8632zhJcb+sqL2zLzHCMJ+O7VDk2/BQI2QIDcO3PN/sTlLJzOuR3vasKtHwwv7S+a1y0WhmjSZc4ZSLss46fwaSrGqtTMfktcNZfUIdk97CJ6s56YB8Kky2YapD+vf138M1en+awQXBIzAZ4h6mVqCXkmbDQUR2EhrNs+PGeAIgpZlYqdT+byLaoi6EIdtC0+Oju0m8gJkvI5L3ngUKXrusP5rnXsu1hv8C529xD10WwFGwLWrcRnYf74BUzHrjG8MtOZLPYV/OX0YNgKiNiYEQQODXCUEoX+rujUFzt7Iu+i2rvNaVTwLd/hr9LIZz0ZF7f85eNsyLD/XEdQzAsKQ+lpk60aehPBAK+Lw5FMCtmlKX2mBUm5RBmLQxWdO3gokwoS66TxggXAN0sDatZSuvMVcqT9xe/N9oi9uOubR2HdJ7NXy9ZtQTHExiSZHmRDK1FltXdn298BcQIk5WvpNnQJckPs/ruHqaF/Kd5I9BCPkDii9uzku8ubs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6666004)(6512007)(6506007)(53546011)(6486002)(478600001)(966005)(83380400001)(2616005)(7416002)(2906002)(316002)(41300700001)(66476007)(66556008)(66946007)(5660300002)(8936002)(8676002)(4326008)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V01ZY1kwYjc0dWowWGFVTkhPTGtVRFlzNnFmUmdyUE9MV3N4cWdwaUt4blFD?=
 =?utf-8?B?OERycEpIeXNPeWc3a3lNNGNYdUZiaytDblZhN3BpSTN4WnlIdHZ3L2daeHVs?=
 =?utf-8?B?WTRHdzV2aUczc1h1NmFMR1FPTkVBcGw2U2kxbTd0Y0JtS012QnR6Q21SYzZN?=
 =?utf-8?B?YXd5SjFEUXdaSDFaaFZzOWhwNzNKM3N5TUNQeUdVUmY2dkQ2T2NyOVNyYVIv?=
 =?utf-8?B?aEp2Z2Nxd2dIYlQyZnBPenpXTnJJcmVBUGpMZEU2NHUwNXBxZnFvS2h6c1BM?=
 =?utf-8?B?QWo3YzRDZGtpeHZVRk4xY2F1eWZvYjZpODJFQ01XQUM0UkFqam5UR0FSS0d3?=
 =?utf-8?B?OUZlMDU0cFpIZUdWVXlBSndqVjJudjJDV1hpN0NRUkE3amUrUVhRQUxoR2Mv?=
 =?utf-8?B?QTJPM1diYjFHbkc5MkhMUndvT2M1YjRpMmtQcmgzWVpScEtITWNrTms2U0hQ?=
 =?utf-8?B?T0t4T0pacitLWWQydHNrQmF6aUZraktqNmRNdmw3Z0xqeGV3d2YzbG12TGhI?=
 =?utf-8?B?cXZwNmZhRDZnTXRKLzJNdWNpeU9DWi9xVk44Z0VML0hYbzZnZ3dJei9mWFpp?=
 =?utf-8?B?ellndXU2TGl3c2RtVkhPL3R6MlhnMVgrRnRQdncyeXNFSE1KaGgyWEhBK1RP?=
 =?utf-8?B?KzRqWEZ2cG92WnFYRFpLRnJsdE5nS1Jic0NkV2d6WnJoNTlqZ1ROdFdHejRw?=
 =?utf-8?B?TGgzQ1g4TjdTajhGQTFNV0lyRmQ5WC9sRVFlZ2F5RzEyMTdRZXVyNlpsWU1t?=
 =?utf-8?B?L0hNSHlSbFFnOG5sbkZ3NUpxYVZ1MXZoY25FQThLRkZYU1JhcTRxZDIzZUhL?=
 =?utf-8?B?K2xISHA1WGlWUE9FamkzRGxiUGhPMXdNbnNMN2tBTnhITlhQN0txYW5WeFl2?=
 =?utf-8?B?MUt1WWxrblNsUS9QNFNUQVNsL1YwM2E0Q3dmSEVONEY5dTMxVm0ycC9rWmRD?=
 =?utf-8?B?SGtmSXdVcmtYOFZjd3FkbERmUVE4VUZveVg4T1Q5ZnVVNjJOcjAwQ1cvQWpD?=
 =?utf-8?B?Q094M0ZxdGVTL2sxc0NQM3NhR0ttdHg5S2o2MUhCcmlrZHBpTUN1Sno1azd0?=
 =?utf-8?B?WjFVVWk1ejA5WUtSd3NnOEpreC9uSGlSS1FScndVSjVNRGM0blMrbUQ1b1ZW?=
 =?utf-8?B?YWFVaHR2Y2RhdGZsTmtqdVB2b0gvN3NNK0hsOWE1YzVCMG1zWFJrZ1R2WTE3?=
 =?utf-8?B?MkJMOGUxZ3ZnVFdzU1ovVGx1ZW9oZzdJY2pvZUxiWEhZRVZvS285OFB4b3NO?=
 =?utf-8?B?NXRvUTJEYUdsQitMQ01odSsxWEVHM3FWQ2NxWGpPOEpVOW9HM0E3Mit0WFJV?=
 =?utf-8?B?bGMybDk5a1VvTlRKVlY2SGRzdWo4ZnRiUWpVYS9maWNBYzhYSUlLVnJFcGw3?=
 =?utf-8?B?LzhVNHEwa2tIRlZXbTExL3pQTVBSbkxOVkdFTjlNd3V2RFdnQ0NvcWtMOElh?=
 =?utf-8?B?M25ETVZEdzlDeXpRd0JsbVh1UHBhZndZMnVQdWVVY284aGZoRFRycndTeW9M?=
 =?utf-8?B?THg0ZW82dVloWGxQdnVhb0hmK2NQd1hsVkZNdmNQT09tZy9PbzNnelRQWTF5?=
 =?utf-8?B?d1dUWTlvZWsxU2g2NkN2cjNCSC9IRlp5bkRKNEFhVlVKVlJPTGFMLzVRRWtG?=
 =?utf-8?B?azhla0w5T2t5OHdvZ1BTKzJ4akdwNXVwTE5BajBOK1piaWgwckJHMTV2NS8w?=
 =?utf-8?B?ck9OWkNUSGxDa0FTQUJTQUVjK05zbUJzOUFNRjEwSmlUNFg2N3BjbklYY05N?=
 =?utf-8?B?RVAyeGc5WGluNUJkMU0yMlh0YXNaamR6VEx2Sm1iRkIxTXk3MGZ4NUI5UVhG?=
 =?utf-8?B?MVdnR0h5bE9yT2d4RHVhenlIcTlOUDhBZFU5VDBMQTRPcjdHbjdydXp2aEFH?=
 =?utf-8?B?VzB5RGdGYlpMOURCOVNPd1FBbExSSXhsMzROR0RPcmtObXh1OUNxTXdxbzRr?=
 =?utf-8?B?ZVRLRkVETUUybzdnOFFkQWo1K3NaOFd4Z0tPbDlrSklpSFlJRGJnY2JDK1JI?=
 =?utf-8?B?bWN5aUJpMnU1dHlyV1hoZzUvQXlqTkFuWTMzM2c3TlJid0dIOXAwQmJITVl5?=
 =?utf-8?B?T2Qrc3pKTmtxSFVLaFNtY0pjQ0VNL1Y3WkpUYVJZNk1WQUIxNDlJTFVmc001?=
 =?utf-8?B?cmJoUnBFRWpKTXNJV0JnNE13YXhTVkpBYWpVcnUxYzIwdFBhN0FscnhObjBD?=
 =?utf-8?B?eUtIb2VEa2QrMDlvN3AxTnZuMUlNaWJsMDI2bmRjaHhibkUwZDZrNy9DbEZW?=
 =?utf-8?B?MTk1UUpRL09pUVUwUXhpVGUyUHFnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0738846-1a6d-4567-2df6-08dbc6504c3a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 09:40:38.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIazXB1HNAhjCykE4nuJSuUErCYczj6UvpkKndcsuZLYAj50D3j5POUR4fSONPpUy0ldGQRD0TUgwVB0XHJlBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/2023 18:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.6 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


We have one test failure for Tegra, but this is expected at the moment [0].


Test results for stable-v6.5:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     116 tests:	115 pass, 1 fail

Linux version:	6.5.6-rc1-g9327d0db36be
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra186-p2771-0000: tegra-audio-dmic-capture.sh


The fixes are now in the mainline, so would be good to pull these when 
possible.

e765886249c5 ASoC: tegra: Fix redundant PLLA and PLLA_OUT0 updates
f101583fa9f8 ASoC: soc-utils: Export snd_soc_dai_is_dummy() symbol

Otherwise ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

[0] 
https://lore.kernel.org/lkml/dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com/

-- 
nvpublic
