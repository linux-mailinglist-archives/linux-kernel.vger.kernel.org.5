Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD7880CF87
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbjLKP2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344056AbjLKP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:28:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032BD6;
        Mon, 11 Dec 2023 07:28:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERp2QNtrqzyJGvnc7WjIJeL0cYHNBkOhCC/FQ6P7ZBZ61oQSxklFN69jHjI8upwCf12SS7jrQVI9B9mPTZZozehKrJ1pst3h2uKcY3tjTMcFtVBV2HJoMJsDFGYfsRA+hxJws4nlaC9u/g5agTm/w9BmGo502LFqKc1ymH7XRtq6CLvwIGtl6asSd/qFJRTk2o7qdxl9i7bwPzmZRIhrj7i/KU55+Xp384SccvcrLHGX/tfNfFjaDaTo/cHDSgS99p5ONy2/Jfo4/gxZPnUfjM0/Bfh0GoK1P+LdOd5j81mpFROKQjvZyc0uRInis8xnXr2I00FB5/R9Wmlf/nL9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf474CfQzEatd1XD11s2zMEvecXr7Uxncf8kYgeMpYc=;
 b=W0LXteA0+rzwyM62Rd3jm1yBVtDE8lgvLcdiOKxwoLy/n5u6rak5tup69n4NhTlDLFq6Z8AsVNZjJS6DgKpSKMevL+RirXD1ylvMvLg4hzz2ilc708HXFoPwRXNXm+atSJAp3YgszXM6mduaQgtIZB7YfL9qxA7gXpLNXEn5nRqJJkO7IVobyG2dwNSgY2CUoO7e7bbbb+kzRt+JKYmhhHpXfa7mRkshzapnpzaz8fcD6ZrEXqJqEMourzlncCI+TOF2++qzhP2xffNMU0ImYMRBeTCDITayE3EdzOe6e7hoOmVQnlzi3+t0akZjW3UbfhvpQFqFWhC9kYB21adPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf474CfQzEatd1XD11s2zMEvecXr7Uxncf8kYgeMpYc=;
 b=4wePEfhZgmS2St5+ROQ3y2RKEsP4J9WbERze/3aXVY6xJzQcyu0p/wKpBqs9WvYXj9/QUmAWMDShshaUkhTai9Cwe1Dl1FYdwnX3wLINFgSoJvclCMtyhtN9NxMoP1lN2BQwujK/VQdsT3P2bq3TQQrHJdp8ov/ipyOknAS9V/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:28:22 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:28:22 +0000
Message-ID: <5581434e-92e6-4a67-a68b-1abb56bc0d99@amd.com>
Date:   Mon, 11 Dec 2023 10:28:19 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
To:     Borislav Petkov <bp@alien8.de>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
 <20231211142055.GHZXcax0W+WD5/YBgm@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231211142055.GHZXcax0W+WD5/YBgm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:408:f5::21) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9580a98f-16f0-4c40-dad0-08dbfa5dcf4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duGj4726WoWUirDoBqXlEV5QHG0E9loWEkqBQ2ZcQVYOh6SYrRiNRQJIBd+R6/QV+kCsuCrtr7HZOIAMNXZwwlHhte8xyU9NcS4YR4JeENXfnFXgoXg6clALdfuiKUBhDonesJqRDJ5B4G3yg7t0t3p4rjmMNEm1leKlPHzVktFYnPDZF7Gbd3NWBjzx8UJjYCthDZeiA6UDoWydtit39Z+sQlDj2q3m4wgq/EVJAd53kzBhgiP31i/+j1wfdDOWxwm9+3aQqSSuep6evtcXM/wBFG+ZKz/d2Ml1MCV+9kRCeQnag8kRtHFN82qQF6JJvwvxEkXGLtUbtjHFVV7PhCH9B9u2T8U4pyzACymbLj9TVPEagh/DS/wTU3Vc1g02jCn72UxYMUXwTwetmJpUaSDRba3OsacKtdsMS/Q3muRZ2hZxKJM3m88Lc6QExX4rf0/OyVTOlqKCpadindG9+FHFzA4fpuI4iC2gR6gSMVCQ1Nk0+VV5sZu4N3l3jjHRIRVNICEj6gI4qWCmgVqa1nv1qo/8LtQvf7sTHtDKLA4/CdqVvZON11njVkzKc9kC7Q0ACAwpJW2maMNKjgArsVXJFkoWiFO2hOJEd7ywRVMTkRL0a3l/2t4daVmLxnS0RlnnA92l3kdMQbJqpJFMLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(66899024)(26005)(2616005)(66556008)(36756003)(38100700002)(31696002)(86362001)(44832011)(5660300002)(6512007)(53546011)(6506007)(6666004)(8936002)(8676002)(6486002)(66946007)(66476007)(316002)(6916009)(2906002)(4326008)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTlCZEZJdXFvTTJDN3NZaENScm1YZ05OOS9BcUFUMmh1RjBmNUNQSWFmQkl2?=
 =?utf-8?B?cmhmdlBLN05HRnBzb0txTk41cjNwbnhSZEtQUktOVmphS2NPNGpWMHppSGRl?=
 =?utf-8?B?aGxWZ2E4eUI1d3ZoYXk1M01GWW1IWE1aRUV6RGMySU00Q2NBSWhYZzlJMk96?=
 =?utf-8?B?ZFhkTTFNRWRMS0hGandXU0JQS3ROUklVVFg5WG5yZTZaNVRGMFZwbmdrelQ2?=
 =?utf-8?B?K0Y0dnZDTERhSEJKY0MyMUg0emRIbmZVK25pT2dnMGV2SU9rdkRFQjdEZEx6?=
 =?utf-8?B?WlpzZVAvOTJJaGJpTTVvNURtakpEc3hmRWtWdjdkanJXNGdKaWx6aTVsdXU1?=
 =?utf-8?B?djFLTjRSWFduMkN6L0pFQ2ZxdG1TemZsOHVKOHA3K0hocTZEN3ZjTGpBczl5?=
 =?utf-8?B?TU1xSWRQN0lBeFVEZHdDZDFzVWh3RlNGTjRpNDRQMmJVM1cxYUZQZ1V3Vyto?=
 =?utf-8?B?dGdveCs3MmVoMjVKS2lWdFoweG1qSWtmTW5kTjNlTkFrR0hQYW5DZHdhNXMr?=
 =?utf-8?B?eEhKWFh6dnhCNG5YbUROZVpGZlkwby84emM2YWtnUG9jUmRUMUVkNGNNU3N5?=
 =?utf-8?B?Nmw5SDhBWjhlUlVWeFY0d00zRG5icERmdy9ac1hLYTVkVGtuWnpZVGRoMG14?=
 =?utf-8?B?YktDL2FCNlJIVzlPWU5wTmE0NjJmSjR6c3o1UWprKzVhYzhyTHF3dWtIdUQ2?=
 =?utf-8?B?WmQwQk0xVWVDWlM4eFhxOG9sc2l5UUc5WDJNbkcwcDMvSERPQUxycHBvRW5x?=
 =?utf-8?B?ZUhVQmlkRkJLbE10RW9OZnEzTXdFWDBGdUFaakMvNEgxS2ZURklJV1VNWjdX?=
 =?utf-8?B?RXorVXZtcTBXaUhLdXdPSGNaZ1B3ZjRSMFY1dWRJU3dwaWJSSFhxSFNzNjJ3?=
 =?utf-8?B?aXVjcUNYdkExSHdTMWxZbEp2U2Vyc0xac3QxUE5uMC8wTm40YTVrNGJpeXJs?=
 =?utf-8?B?NW4zc2NCUjNVV1hKTjJ4Z2VBRmFmczY1RDNMTzZOZ1U0d2xEVW53N2RoTVVp?=
 =?utf-8?B?V1dYa2d2VEVyeW1kQTJ0VTRUVXJ4b2NCKys4OE1xcTk1WGtra0FmbFlWYjUx?=
 =?utf-8?B?K3ZzRk53MXBzNGZXbHoxbU03WjdhKytFTDk4eTFLWmZteldjVDdtRHVLTGli?=
 =?utf-8?B?ZnRjcis3NXRvWHZlL2FLLzUrdE56MlhDb2I2VVIvRDVYdXVaM1lOdW5RQ20x?=
 =?utf-8?B?bWFnL0JlSGVCaGtyd2l6cCs4c1c5TmJmU2JRNk9PdXVodWpYbnJweHcrNTNL?=
 =?utf-8?B?cnFsWUIray9pVjY4MCtLZWV6Ri9WU2xSdWZIcVRDZkJRWStBNmtKM2wxMW5k?=
 =?utf-8?B?Rnh1WTlaeDlmTTQyRitndWEzS1l2SUpGSzZpVk00QVhtSDZ6OXFHcWR1SWpO?=
 =?utf-8?B?QXlxMXViQTRXODBneWE5UjZTaGkrcDl1WWR5U0VjSE90ZVZsSG9BVFRDV215?=
 =?utf-8?B?OU1KOHUxc01KdjNYSkJOMkZLODNESzVITUsydmJHTGJpSlZaNS9pTDg0b2tN?=
 =?utf-8?B?cDRUSWNmeUlqL0JVZndjNmxLVVhxUkU2TzJjWHgza1orRFlidXRWa3ljOGZz?=
 =?utf-8?B?V1pzaDI0bmhLZHhqMUFNbVBhZkl6bjFXK2RMN2tYWUs1eWZsR1Z0WTBzc1JT?=
 =?utf-8?B?YXRzVGZ3MlRRWlRoWklFYjdHb3k4MW1MT0FCWnBCaCtyWDNUWDdManZibkVo?=
 =?utf-8?B?a1FQVDdEYTZaR1F2cFd6ZGl4Y1dGRVIxdVRNeWNlZHI1WWltRmI2T0p4ZFkz?=
 =?utf-8?B?TCs5aEhYYmNmNFQ5VnBUNkNMNVNKNGNkaXJ4N3NNalByNzM5eVpzc1pwN093?=
 =?utf-8?B?Y3FBUHJRRXlEWjlvcFFGczVJYW1nV3MrYUcxazQ2cjFEU3E3THhlNXBURHE0?=
 =?utf-8?B?ckRmTHlFM1ppWHZ4NVc3ZVBXLzBUUEQ4SzJiV25NNzE0REVDOVViNDRHWGc2?=
 =?utf-8?B?WmV5a3IrVnVXUUpDRmpuaWh0R1N5WFdhMmRpclQ0TGJ2dFYzU3ZzOTFPaTBa?=
 =?utf-8?B?b3h0cGVJT3FYWXY2c25oSGt5N0lrbTZ4VUdIRmFPNlpzWWdFcnV0dy9kM1pz?=
 =?utf-8?B?NGVXcHVjVEtRZHBnQWFQOWFBczZaaTExbUVFMUwzODZhT01BMk9iZFRnVTIw?=
 =?utf-8?Q?UIQfxhNFmYLl8qCjRbEvNiXvy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9580a98f-16f0-4c40-dad0-08dbfa5dcf4a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:28:22.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZSG5KV0govBRgrozzYs3clq/YV5ohlz6THjLcnYcjHxCv+7U7QQBNSEO0CkPGbp858D5FTnzqw5Z4xVj+sPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2023 9:20 AM, Borislav Petkov wrote:
> On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
>> diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
>> new file mode 100644
>> index 000000000000..fcff387faa33
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/Kconfig
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# AMD Address Translation Library Kconfig
>> +#
>> +# Copyright (c) 2023, Advanced Micro Devices, Inc.
>> +# All Rights Reserved.
>> +#
>> +# Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> +
>> +config AMD_ATL
>> +	tristate "AMD Address Translation Library"
>> +	depends on AMD_NB
>> +	imply AMD_ATL_MOD
>> +	select AMD_ATL_STUB
>> +	default N
>> +	help
>> +	  This library includes support for implementation-specific
>> +	  address translation procedures needed for various error
>> +	  handling cases.
>> +
>> +	  Enable this option if using DRAM ECC on Zen-based systems
>> +	  and OS-based error handling.
>> +
>> +config AMD_ATL_MOD
>> +	tristate "AMD Address Translation Library module"
>> +	depends on X86_64
>> +	default N
>> +	help
>> +	  This option provides the module component of the AMD Address
>> +	  Translation Library. It will be selected automatically if
>> +	  building the library. Minimal dependencies are given to avoid
>> +	  build errors for modules using the library.
>> +
>> +config AMD_ATL_STUB
>> +	bool "AMD Address Translation Library stub"
>> +	default N
>> +	help
>> +	  This option provides minimal built-in code to support the
>> +	  AMD Address Translation Library module. It will be selected
>> +	  automatically if building the library. No dependencies are given
>> +	  to avoid build errors for modules using the library.
> 
> So, provided this stub thing even makes sense (I need to continue
> looking first since this is a huge diff), you don't need the help text
> and the bool prompt: a stub is prompt-less and is selected
> automatically.
> 
> IOW:
> 
> diff --git a/drivers/ras/amd/atl/Kconfig b/drivers/ras/amd/atl/Kconfig
> index fcff387faa33..348498d49b01 100644
> --- a/drivers/ras/amd/atl/Kconfig
> +++ b/drivers/ras/amd/atl/Kconfig
> @@ -32,10 +32,4 @@ config AMD_ATL_MOD
>   	  build errors for modules using the library.
>   
>   config AMD_ATL_STUB
> -	bool "AMD Address Translation Library stub"
> -	default N
> -	help
> -	  This option provides minimal built-in code to support the
> -	  AMD Address Translation Library module. It will be selected
> -	  automatically if building the library. No dependencies are given
> -	  to avoid build errors for modules using the library.
> +	def_bool N
> 

Ah good deal. Better than padding to meet a minimum length. :)

Thanks,
Yazen
