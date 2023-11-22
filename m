Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A37F4055
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbjKVIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjKVIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:39:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7CEF9;
        Wed, 22 Nov 2023 00:39:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9EXGmhApC/NIVpLuqihvVMGGfkDpuwKaAOvytdLtgk7t1HCzh4mubO82F43sEHyE0aP4NQsbwfp22DMmhp2xjZpIL5YMONkXvy0Oizu7BU32j9eEGwQuMy1iQRqkWnVKctMk6FowONXsJ5qjTSI4r/xbkGvDSrpaGWSmm/A/2WScbKlMntqvAgZdqR7GP5lR82IQenJO7I8/WqEI6DB5USb4MH9bxjAP8I+EH9vlgLMOklnGRgC/mcGWu9OkTyqC07gBWsuzPOg0tj23tRf8NGTVTZWjcdEnfRLLKPe9YxlO7plgSaslQk/R7cdGIcFybGwc9RkezHibKVmHINEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm8kc0hXva3yTSaG3A/aJHPSGqllWm0KfbYujHwMKO4=;
 b=HTLCuUnehrYx6/+yrNoCDJ4XJ3HZHNY1wJAqPU5j0/dDlMUD67Juq/aebMLsjrrQPcGkr5Tb9lY2c7Gm3/safZhGkOze96jchEnkbDxp8ypvYrU98mEO0FN5pkdTL4MrAL41KA4UYNq7R6+Rvw1xPetJYJFMbh8qQqu91V3k3Nk7N+1WL5ydL/V2tEhmi/1EOkESEMgYDGWc/GG6dSREGJGiaqp4g1Zt7nLiTE6ae5sGyd5LPxm9J3L+QEJeUEWlI3hc5zOi6OEH+6mFInBCreqdtEejo7zL7o1zXwfxx6Mf5QudFVnZacj8xQ7PcVG9uGYgj+UhvWaPYaUkqhnUaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm8kc0hXva3yTSaG3A/aJHPSGqllWm0KfbYujHwMKO4=;
 b=BvEFUI1ZD85trbMNuTKS+UThw8wTKbs+L8A9oJqSAqc0tkGxJjZPuR2bSukUs2ZQpunxZrnju3cv/1AHEvnbpw9WIbici/ijpwtoU/gSmZZdhE553oTOwlGR4XQePFNjDM2c5L8A9D3Esm3Z00kp6wjatWbU/uhhniNZ1FIbvrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Wed, 22 Nov 2023 08:39:31 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 08:39:31 +0000
Message-ID: <03937694-03bd-4ce7-8104-ee41f7ba23ea@amd.com>
Date:   Wed, 22 Nov 2023 16:39:17 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12 0/9] Enable Wifi RFI interference mitigation feature
 support
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Ma Jun <Jun.Ma2@amd.com>,
        amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <5f85eb72-3f34-4006-85ca-2a2181113008@amd.com>
 <76d4f18e-a349-4337-a301-ffebb8f1c5e8@redhat.com>
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <76d4f18e-a349-4337-a301-ffebb8f1c5e8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cbbf16-b4b5-4747-2da7-08dbeb368bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZSEL28KRBVoi3t9oqMMhr2j3bFGXjY0Zh1wRhTCJJRMWg+jMZmpXqGpkhqL6SUnelLK2u87P05QoPgbbe3cXtTHNjb0qntQKDCblJ0nmLDiV+tgak46GCJDegWKKQ0iMcfn27X4TRS3TzH2MZQ2ZQKLPvEF8uDiMPsiBVQvtqdAPT+LACwsPuN6RR3fuLmMCVG5qJQI7K7LJ+6ftBIlrz+Qm+BEE5/bDyzmqS4OZQkzXE4wpcwijVXOjKCOnGd3DaVIxRNsjG0eQlVBTC0SGflGOEjFMcZNWucCHOFVcj/vxsYJD/DMz2trI58PnaY9RQ4cpXveObP32cbWk9u1bDKQJemdg+OcUb5TNzIZBn6nypfm5gw6L1CqlZDF06oZKH/N6bDBWBqyXM8R7EuREzyqgfMZTJJCZ/DpLUgG2KfKDpcoDMWDJmZ5g62X0bcspoTaA++Rqy++N/y0sBbrqlTJ8x5JlL8wkYTw4laPhxUyDO4AtM0M1vT+25+CraQDMgaTmN92+UUUe+UP2xJVUODaYEpZd2IZh9ga55KuhM/e3sglaDevzwD5ie9MeI23OJNEaJeOhmGyhdRf85O8LfcmkAFFFCaXpzuSYzFLyWJeVei+msvtQHtYXSLS+G81qQUhGzubHUqrHAKfluMjgVKOqlv9ftq+6SyYLxyzBTY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(53546011)(7416002)(26005)(38100700002)(6512007)(4326008)(8676002)(41300700001)(5660300002)(2906002)(478600001)(8936002)(6506007)(6486002)(6636002)(316002)(110136005)(66946007)(66556008)(66476007)(6666004)(36756003)(921008)(31696002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkNCUkNqVnZ0bk81czhQTmxYdzVER3N3anNQU0lTV3pSMlkycnJyZTRqUDlh?=
 =?utf-8?B?QnphNEJlMWdNSGNRZitodGZzN2N1anJaL0NTOVRUOWxBdUZZSkJJcEJPdWhD?=
 =?utf-8?B?MElvdWduZmRpejRxRFRtUkJEQTA2dlpTVFRGMUI5dUE3R3hSZW5RVmZhK2lX?=
 =?utf-8?B?YkpzQnR1OGRGNUg2SXFUZ215NUpsYTF0eDdsWXlHN3Bqd1hpQk5JWEJPYzRT?=
 =?utf-8?B?c3FIL0tFS29nRUlFVUlxMmVrdkFIbTRHMC9RQ3RYS2V4SHVsTjRMTVErN1Fk?=
 =?utf-8?B?U0xISm5zd04wL0JKckJnaUlOM2JKR1FvUDJROXJWZ0FDMGsyQ0tValhDZ2FR?=
 =?utf-8?B?Q0pxcTNoRm1RMHpmeDg2dy9zbWZEdlc1N0tsRzA2RHc1VFZmOC9VWkJERC9i?=
 =?utf-8?B?bFQ4a3B4QUZ0WlhhWjhEVlhOaVlGamhWRCtPakxlSmtIVUZadjQzMEl0ejNo?=
 =?utf-8?B?ZHFFais5RE1yTUd3NWRkSkM0SDNEUFdlc0R5dVh3QlJzMzdST3QwZDVqTHZm?=
 =?utf-8?B?NzZlSjdOSWZrK1pJTzJoTnFzOVJ1MTRQcWV0ZnZQSUo5R1Y2cm94eHpwSUhR?=
 =?utf-8?B?QWRTTjE0UjZIS0hUMEt3ZjJUeTEwMVBobFZOaEFTTWVTT21mRFdNZ3RzK0p5?=
 =?utf-8?B?YnBUemF2cVY5dXFNUit5eE9VQ2RMZXZQQVM2amZQSWxvQkU0WSs1QXFkNC9Q?=
 =?utf-8?B?Y3dFY0NWY2EwTGwwZkRNV01vSWZOVlptaU9TZ1d5Y2puTjREQUJ1Vm92MVdC?=
 =?utf-8?B?S1NrdHNqclVkK1Jwd0hvcG1NZndkTE1tRUM4NjB6TXYzS3R0alo4a0x0ZEVP?=
 =?utf-8?B?bS8wWmZseHVHeGI5YmcyUk5rYkV5MDJaTWxKMWRaLzZ5bWRnQnhjK0doNG1G?=
 =?utf-8?B?OXJYYnFOV2E3UTFGNS9lYzEwNTQzcFFlZXh6YnpRUjZrcXZhY3lBNFVCTklX?=
 =?utf-8?B?UVJkKzdYUmVmYndzOWZQZGI1MFQ4c2ozS1Mxd0xjZlUrZE5CcFdQTU1UaWl2?=
 =?utf-8?B?NWY3UFF2Mm92SG5YWnlVSGd6dW12YU96WmdHWjkwT0VNKzJXdUFYVXhsblJu?=
 =?utf-8?B?c3EvQ1NzQkRiMmovREZpaFZySGJ5bC9qZU5OSUVaRzNnanRXRTJRVG1BN1hH?=
 =?utf-8?B?U2NIZkdCNjhybUhSS0FtTzh4d2U2UEJhb0xjSkFSQ2hobTJRUlVjb3dnaU9R?=
 =?utf-8?B?b25FaGhPejZ4VUlENHBZOCt6T2I4aU5XclRCR2ZVYklMNGpuRDc0MjZPUFoy?=
 =?utf-8?B?TzZSck12Z28rVUtialpEVmZxdjFjOW9JRElEMVRROG1xamM3T2FYejJkNlFK?=
 =?utf-8?B?ZS9rdDVJeDk1eWZFdS9IZWM3UDNmRCtBVVFlUVh4VklpRmFsTmFIUmkweGg1?=
 =?utf-8?B?NGpQc3dISmZiYTkwd2FoS3YrN0JXSHNveE9NU2lrTFlTM3YvRFgwSlMxY0Zx?=
 =?utf-8?B?elFhV3FwdUlOTWVhb3dJb3lMS2Z1aFVHaldBc1l1am5WTVpNdzFmWUJWcHVl?=
 =?utf-8?B?UHJnSmJBWmNZanc2eVR2d3hYNTJNMmJmMFpDLzdkZDJJYmViSlFLUXZiSTBa?=
 =?utf-8?B?MElDNllZaEVxZWw0MEVIYnpPUG9ua21rSTUweGdnMERqcHY2dGpnV3ExaWM3?=
 =?utf-8?B?UnZ3R28xeG9HNjM5ZGc4T2ZTdlNrTy9EYkFtM1NXamVrQnJoYXdPZWwxa0tj?=
 =?utf-8?B?YXhEQ0REWjZUcDkzUjBlU3Y2NS90S3IvTTA0MGlZMGx0RTdqSjFCRjRaQzFC?=
 =?utf-8?B?SW9VOEs2Q0gxY1FVRzFzNXZiTDBzTDMvcDRiQ3JIc3JWSHB0K0lzckFmbmJH?=
 =?utf-8?B?MWh3dUsxK2NIWnpRNVZKT2VzdnJFWmM5akYybWtnMkFZMmZhWmpDVFUzelNR?=
 =?utf-8?B?WkF1d29EeTc3bUFxT0dLZW1FNjFsS0hXM0JPMXJMc3Z3M3NhY0w2Nmw5YUFS?=
 =?utf-8?B?eUJZVWNvNjlwNktRbmdmdmIxY1NNeXVkdVNOV281OW5QQUh6azhWV0gzRzNT?=
 =?utf-8?B?NkEwdFhucUUzZ2RkNUQwc2FheGFES1cybCtSTlF3UG11N3FrZkpGV2VJVTJH?=
 =?utf-8?B?a09uSkVEQlo2SGNvMk8ySzlZOHJSc2ljSGZwWTNFcE5VeXZtTlhFYk9IRTdr?=
 =?utf-8?Q?0o+Kpi6SiLrndjjMURMx7zI3M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cbbf16-b4b5-4747-2da7-08dbeb368bca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:39:31.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/SO/oIy6ZKQQiyi+oXKHz1CewsNruz/PByX9dHWlqc7DAAGAtpQD1ZwjTXW0XF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Thanks for review and your suggestion.
I'll check and fix the _DSM calling issue in the next version.

Regards,
Ma Jun

On 11/20/2023 6:54 PM, Hans de Goede wrote:
> Hi,
> 
> On 10/19/23 08:17, Ma, Jun wrote:
>> ping...
>> Any other comments?
> 
> Patches 1/9 and 2/9 look reasonable, once the questions about
> use of the _DSM vs directly calling the WBRF ACPI method are
> resolved I can merge patches 1/9 and 2/9 and create an immutable
> feature branch based on 6.7-rc1 + these 2 patches.
> 
> I'll then also send a pull-request to the wifi /resp amdgpu
> maintainers from this branch.
> 
> I see no acks / reviews from the wifi folks yet,
> so once that immutable feature branch is ready the first
> thing to do is try to get the wifi folks to review + merge WBRF
> support.
> 
> Note I plan to not actually merge the feature branch
> into for-next until the wifi folks are happy with the code.
> 
> This way if changes are necessary I can do a v2 feature branch
> and the wifi folks can merge that instead.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
>> On 10/17/2023 10:53 AM, Ma Jun wrote:
>>> Due to electrical and mechanical constraints in certain platform designs there
>>> may be likely interference of relatively high-powered harmonics of the (G-)DDR
>>> memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
>>> mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
>>> Producers can advertise the frequencies in use and consumers can use this information
>>> to avoid using these frequencies for sensitive features.
>>>
>>> The whole patch set is based on Linux 6.5.0. With some brief introductions
>>> as below:
>>> Patch1:      Document about WBRF
>>> Patch2:      Core functionality setup for WBRF feature support
>>> Patch3 - 4:  Bring WBRF support to wifi subsystem.
>>> Patch5 - 9:  Bring WBRF support to AMD graphics driver.
>>>
>>> Evan Quan (7):
>>>   cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
>>>   wifi: mac80211: Add support for WBRF features
>>>   drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
>>>   drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
>>>   drm/amd/pm: add flood detection for wbrf events
>>>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
>>>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
>>>
>>> Ma Jun (2):
>>>   Documentation/driver-api: Add document about WBRF mechanism
>>>   platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
>>>     mitigation feature
>>>
>>>  Documentation/driver-api/wbrf.rst             |  71 +++
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
>>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 214 +++++++++
>>>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  33 ++
>>>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  14 +-
>>>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  14 +-
>>>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   3 +-
>>>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
>>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>>>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +
>>>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   9 +
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  60 +++
>>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  59 +++
>>>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>>>  drivers/platform/x86/amd/Kconfig              |  15 +
>>>  drivers/platform/x86/amd/Makefile             |   1 +
>>>  drivers/platform/x86/amd/wbrf.c               | 422 ++++++++++++++++++
>>>  include/linux/acpi_amd_wbrf.h                 | 101 +++++
>>>  include/linux/ieee80211.h                     |   1 +
>>>  include/net/cfg80211.h                        |   8 +
>>>  net/mac80211/Makefile                         |   2 +
>>>  net/mac80211/chan.c                           |   9 +
>>>  net/mac80211/ieee80211_i.h                    |   9 +
>>>  net/mac80211/main.c                           |   2 +
>>>  net/mac80211/wbrf.c                           | 105 +++++
>>>  net/wireless/chan.c                           |   3 +-
>>>  27 files changed, 1180 insertions(+), 6 deletions(-)
>>>  create mode 100644 Documentation/driver-api/wbrf.rst
>>>  create mode 100644 drivers/platform/x86/amd/wbrf.c
>>>  create mode 100644 include/linux/acpi_amd_wbrf.h
>>>  create mode 100644 net/mac80211/wbrf.c
>>>
>>
> 
