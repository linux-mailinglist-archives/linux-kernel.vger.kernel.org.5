Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355827CD23F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjJRCZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjJRCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:25:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD4FFA;
        Tue, 17 Oct 2023 19:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEB8rIHJy73mFJq5y+zkPR7kLtT+q2ZLioQ8ht/61Ghnyhvv4voorbvPQBvgj6N2ihUjLZOqtWac1dPi5x2oZqkpqQLp4sfn8lhibOafAH9JnQ8Segegi2xvQ0BOBkKDyULhjhM/YrmJcKiTcMQvjJG9zwg3gqEce+50gWHpXuNoJ+Dpxn8EOdMOBUbnOx7Bq6Oyq7DsWfeYGULco8n59Q2T3x91Q9/U7wcoxmpDIGSRhK6KkZwvfPnAWdolG40G/t9vZsigL80UZsNoCgBVm+SCPQhqQdidyPzBxph1rT2PmzCU2NHirOKJzjB8TV6BB02gG8V1sWt3QtujcAelEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9JK+HVkroSYzk3UIVHNJneXM1qKAcMfOjjKlabeNoI=;
 b=UvM6B9Ys/IdBjjY5HsP7tz/oUeZ/VlSSj/8YOEQ/UymnhgQeKtrsQi09OTci76FZIM9nDtcuV08Ajj3R0AWbhyR7xGqwpsGA5ib/gU7ZT5YeFizM+3RpJ5saNjmAc1WFZu+NMvhqawrUiUIzaPcWcoTRpViX/fy5yRzaI9wup37mMw26mdoRSn/KVuD63SDrVH671lEBvAvN1n2+ugsCNlQ2Jhxph5zNQJHAzoU8U+lB5sUqdJJACa0Mmskx0E9k9YlOYpI8rE/L4GLu1R3Gj7y6f7BtmO+3yD52O1II/ciY748XnACPMr/1+gM7VMblicj9gDA2MwH16Fj1CVuzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9JK+HVkroSYzk3UIVHNJneXM1qKAcMfOjjKlabeNoI=;
 b=hrbuIx8mP1gnlh5BeHH2Qn9sklxL31pHJXBAh4aOJYC6su3xtlG16nGXbPNJ3Y6Uma072Mopujd6aGnVu0mzoJEsUGN5P8PntOQEPoazpAimaMOF435dVtNuVCf3jUsdanfNIjhRXmvI6DNgTcRYdpm3+heWMT9BjqpnT/Vt9y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37; Wed, 18 Oct
 2023 02:25:07 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 02:25:07 +0000
Message-ID: <7372315b-cec9-b951-daa6-d63dc00b5fe1@amd.com>
Date:   Wed, 18 Oct 2023 10:24:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     majun@amd.com, amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12 1/9] Documentation/driver-api: Add document about WBRF
 mechanism
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ma Jun <Jun.Ma2@amd.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-2-Jun.Ma2@amd.com>
 <f3c89e85-a683-eedf-9c3-ed54173bc12@linux.intel.com>
Content-Language: en-US
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <f3c89e85-a683-eedf-9c3-ed54173bc12@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b21ba89-a14a-4a3d-f768-08dbcf8171c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIOGcLIiK9GtsLIVODFegMibLWL6Fa+zRTOTcu+EBtMpFU3WIWurQnn/aMUjfm2AstLMX91c/QXU+aMJLYn7Z56cWej/DBDS/1anVjMvspiuM9urkpwkw9B0ee5NopCutrhVJhETGoUaewX1r53KwfQFHe9WMV9Ge6+9qVXDPU3lEbPO8nI13zlms7XQ19uwzdsCwtH/dAUQ2W1ydVddcAcc9YOI2mIA0HwxJ/+V2UZOeuyqiAqjXjnTdHrGvm57FEYYWghtB6prKDPSdrF2I5vJm0M5l5JOYZqL1rjjcjOZS4QUiJNdJDwZ7NJD1kkj4RSA1UXsJUQc9ShOB8cJmpt8vio4Lk8lTf7XKr7tqReVVIG6J+BgYqdlQe802lZ/yYHlgw77I5o8qwK+4ESZmoKrYmtfeboSYbTmwLHFLktbRLScue7A3nWS1wzkAeI/Pzn/gVtPpW5ZJytOPy6hQICRlD88O1evGHL84GEUsjS/pcH9/iTkAnuqkly14SzBl9q1ApLanBJtfQpoxDuXJcMz74fQHLyqbRsYV7tJKfdg0IXk0pOx0uxwLs26R81YyNoeaXSOBxhsfh2oZ5uVvesvpY5gU+d8/5HNVIy+JAhmTLnxYzl9SXtpTjtxP5wS3MzhyDPuVRW15Opd6SIsSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31686004)(6512007)(6506007)(66574015)(2616005)(53546011)(26005)(6666004)(478600001)(6486002)(36756003)(41300700001)(38100700002)(8936002)(31696002)(8676002)(83380400001)(5660300002)(4326008)(2906002)(6636002)(7416002)(110136005)(66476007)(316002)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJMb1VmTEMvS3FoR2xWZzdPMjZDcFZibmZ6cDd3OEhwYVg5Ny9RZTVMV01U?=
 =?utf-8?B?YnVxQXJaS1F2Tlp4emx4YXdHWitQZEdJSGFtMC80MmswRURsQjBOaklLUGlZ?=
 =?utf-8?B?QkFBUmhXNVpXMXBsRnlXU1Y4Zk15NTZPVnRxbWxLMVFaaHV4dmdTUkJONy8r?=
 =?utf-8?B?ZW16NjVsVXc3WXl4WU1VY0hZVVdCWWc0a01MMUZ4ckY1UHJManZTZ2xoNFpa?=
 =?utf-8?B?VEF3akxwUk93aUlPNTJ6TTVTbnVSM1BvTlhaWXFHeEphUzkzbEtuMXFubWI0?=
 =?utf-8?B?ODF3dmhOTmNUazNTMFlBclRHbFAvTWx5Wjh3TkRrKzZwcHJySzJHVCtRWS93?=
 =?utf-8?B?SVk3eW5Lb3dhMUo2UDcrN01UbGxDdmNvS1NMY0RKVXhXUmxhQmRqWGMxcjJv?=
 =?utf-8?B?SlNWRTZFSWgrVWNzQ3dhdGJTVmhacGpaaWc0cDlmOXJ0OEFCUS9pdUttRXl5?=
 =?utf-8?B?QkV2YVZPeXFRKzZDQVFDclFHREw0RjZ4UkJhMStMc1FLYVdpVGQ3MTRYNS9v?=
 =?utf-8?B?WXFpUlpKZ096R1JleGM5c3ExSDJmdzkzL3JQK2tuKzF3Q2dWOXBHbHROOHhy?=
 =?utf-8?B?YTBJTkQrTFBPMTZMQUY3cUdBWXByVnl1eXNaV2JUWFYxQmlnb1YrY2ZIdnZ6?=
 =?utf-8?B?QzRTbWRSdTIxK0pyYTZKVlUxeHMrdXVXTGZLZWM4RnNwaU1lZjFvUGIvQnlG?=
 =?utf-8?B?MWxLZjk1UzlBS01Zb3pFQ0R2cDludHdGa0s1Mlkra0gvOGlrS1NiTWV0U3Y0?=
 =?utf-8?B?elBqRDQ2azJmbFZPQ3FVZ3FZakI0Q0d2dFN0ZUtZWGYyLzBDUFU2VXg5MmZI?=
 =?utf-8?B?U3ZzYmkxN21KeTU4MS9HUG5vVTZmMFdJMGtMa1pJZFdEeGJXZjFxRGN5bVFK?=
 =?utf-8?B?NE1OcVRScHpQSkltNVkyYkQyTFRqdUk5UFVsVk1CcDc4OFloZUVSSHpka0N1?=
 =?utf-8?B?UUhWY0ZtK2RiMmVvYlIxVzl5SlQ3M3R2RkZzVkFDWnMzYXhta05maDhFbXZi?=
 =?utf-8?B?M292SEQ5S3l4aHNXWmJ0cURvbTFLNEUzMno3MFVUSjFQK1ptK1kwYVRCYnkr?=
 =?utf-8?B?cm9SQnc0UmJoTzgwTzdEZ3ZoRUQzNDBTZEpYcU8zQjMzUkpMemQyZ2VFekxw?=
 =?utf-8?B?cFE4Y3NUOVR4UTZpYWptUkpuL3VDUTZBWTB1MVJZSEJPVHJOUjcwaGVBYWly?=
 =?utf-8?B?K1M2aUMzSzdKWVpEVGkzbFNxbEdEeHk1MHpIRTFFRlViOXBpZ1pVR2F4TUVo?=
 =?utf-8?B?MDlXd2ZZTXlFbzJyVTNyRVFrNmU4aXdaTzMzTkhMYTFNOUJxU3BvMXlLQjlz?=
 =?utf-8?B?V0hwbllWZkt5OUQzc3hwK0dGb1hOOVpUNDYyNnlBRGNjM3JNc0hWc1ZqTjJJ?=
 =?utf-8?B?czJ5WnBsbTdzM3pUc2pVSUllZjNJWEg4eEVwZHR6UEZCcUppOGw4b3BqT0dk?=
 =?utf-8?B?aXFJb1hBWEhIS2FDeVUwYmZzSjh2UEpuZHVBVjlLQ3l4NS9yV29ncnZEa3Ix?=
 =?utf-8?B?QTlncXZ0aHpNZkdxdXJERGhkZzRFSWdUa3VJaWRtNGxJbDRzc25NeVU5d2I2?=
 =?utf-8?B?WHdaZGZWV0M1S3hjMGhVVzlvNlo5WXdSdTV2M2VEOTdJdVdwVnh6L2hKTGNP?=
 =?utf-8?B?eUxuMmtLNk1FLzZjWFNLblR0YjNFdHNpWlJ3bmJuekprYmxnZDB0WTN6d21F?=
 =?utf-8?B?NW1aeW0rdUN4NnVDYmVvY2VhNmdQaXpyZjh4TEhuejIwQm40YXNnNVpkYzUx?=
 =?utf-8?B?ZHJXZUJha3B3Zk5YS0FRL1ppZFJlYnd2KzY2Q3RrT3NwM0RsK1Z1eG4zbkdr?=
 =?utf-8?B?a09wS3FMV2p6dGdzSmUyaHgrbVN1akhWeVdWRnE3RHo5VjJLYkh4S0ZuV0FP?=
 =?utf-8?B?UHdTWGNVNElyOGZZYStxbnpZQitMcHpHSWtTZXp3ckxlQzN4OFRPL3VMNU5T?=
 =?utf-8?B?RFZ4MGVXWVVwakRzbTNJNjlNbVJmTnVPUFhXNTJoZjQ5S0JwOGlPUnN4bHcw?=
 =?utf-8?B?VGhGUWU0RUtqMGVHOHRUZEQ5eFdZYXN2RFBiZVlrdC9aZHlvSis5Q2Z2NVk1?=
 =?utf-8?B?U2NWTmZMTFNpMEFOVklCcDJ3LzBXczd0dFJBdnE3VTMralVucjZBUFJ4U1ZN?=
 =?utf-8?Q?sGoaHnJfp3/stsKLsXz/c1xiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b21ba89-a14a-4a3d-f768-08dbcf8171c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 02:25:07.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNuInD5Fkx7d3Hd96T7Sv4z2p7XVS7FcaXzhCcodfRLBggsSB5kaeh3s4F2IUt6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi llpo,

Thanks for these comments on format issues, I'll
fix it in the next version.

Regards,
Ma Jun

On 10/17/2023 5:20 PM, Ilpo Järvinen wrote:
> On Tue, 17 Oct 2023, Ma Jun wrote:
> 
>> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
>> explaining the theory and how it is used.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 Documentation/driver-api/wbrf.rst
>>
>> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
>> new file mode 100644
>> index 000000000000..8561840263b3
>> --- /dev/null
>> +++ b/Documentation/driver-api/wbrf.rst
>> @@ -0,0 +1,73 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +=================================
>> +WBRF - Wifi Band RFI Mitigations
>> +=================================
>> +Due to electrical and mechanical constraints in certain platform designs
> 
> Add empty line before starting the content of a section.
> 
>> +there may be likely interference of relatively high-powered harmonics of
>> +the GPU memory clocks with local radio module frequency bands used by
>> +certain Wifi bands.
>> +
>> +To mitigate possible RFI interference producers can advertise the
>> +frequencies in use and consumers can use this information to avoid using
>> +these frequencies for sensitive features.
>> +
>> +When a platform is known to have this issue with any contained devices,
>> +the platform designer will advertise the availability of this feature via
>> +ACPI devices with a device specific method (_DSM).
>> +* Producers with this _DSM will be able to advertise the frequencies in use.
>> +* Consumers with this _DSM will be able to register for notifications of
>> +frequencies in use.
>> +
>> +Some general terms
>> +==================
>> +Producer: such component who can produce high-powered radio frequency
>> +Consumer: such component who can adjust its in-use frequency in
>> +           response to the radio frequencies of other components to
>> +           mitigate the possible RFI.
>> +
>> +To make the mechanism function, those producers should notify active use
>> +of their particular frequencies so that other consumers can make relative
>> +internal adjustments as necessary to avoid this resonance.
>> +
>> +ACPI interface
>> +==============
>> +Although initially used by for wifi + dGPU use cases, the ACPI interface
>> +can be scaled to any type of device that a platform designer discovers
>> +can cause interference.
>> +
>> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
>> +
>> +3 functions are available in this _DSM:
>> +
>> +* 0: discover # of functions available
>> +* 1: record RF bands in use
>> +* 2: retrieve RF bands in use
>> +
>> +Driver programming interface
>> +============================
>> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
>> +
>> +Sample Usage
>> +=============
>> +The expected flow for the producers:
>> +1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
>> +can be enabled for the device.
>> +2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
>> +param to get other consumers properly notified.
>> +3) Or on stopping using some frequency band, call
>> +`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
>> +
>> +The expected flow for the consumers:
>> +1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
>> +can be enabled for the device.
>> +2) Call `amd_wbrf_register_notifier` to register for notification
>> +of frequency band change(add or remove) from other producers.
>> +3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
>> +current active frequency bands considering some producers may broadcast
>> +such information before the consumer is up.
>> +4) On receiving a notification for frequency band change, run
>> +`amd_wbrf_retrieve_freq_band` again to retrieve the latest
>> +active frequency bands.
>> +5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
>> +unregister the notifier.
> 
> Align these so that only the numbers start from first column. I think the 
> proper markup for numbered lists is 1. not 1).
> 
> 
