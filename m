Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75F7F4042
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjKVIhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjKVIhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:37:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5EC1A8;
        Wed, 22 Nov 2023 00:37:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy7HXgGKiu5PHGt/lRu7enMMMadvKNVcB8ccEOdrUL+0PeYO8By+TNP35bEVCT0nuiUmD5vqlqxH7JjanhyKesqF1rVCZjcW0rapGILkaSybndGqW0crn0zSxwEvNKU4TxidmfLYof+b+DcBFtDFDSamZozV7B3KekZtqXj0g+Cb8ujBe4uY45OnulGjC5P9+HyxHaXW3Ry2DVr9YTKbpZapWbWfHToyljn1PD9JVp1tJbHGt/+aRpNXDQcsGv/3ysKsavOZsDNBbgUGI4/DD40DKhdzNFaCgou6Vuw/3JDr5dqIShr0vRKDABLxZLAe7hp51Ivp7Gt92gqNx/TFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7257h+R0o/o6ytyI4blx00DiIxKkZCHIKnHK+3OHe4=;
 b=AOncMu9JgF2kj2pt9GtBdt49B+KfzwvQfA3HPdP+oD8yBJwtLmXpQWjsSOIy3/kRGDYaU2kZ0gPggEpsyAVD7ttPX3ThKXdxnXSPp6dNSUgBJM2BjeeefNtnR3xdZaHXv2ETgny6yOpdD5YiDFgqeHu5Z1bFZFKw14STVPw9561n51X6a7E2onFaeYxAh/y0EzMzzQyPrBVX/pH2AkuaOtUiY62kZZ/Q8Dup7DYMB/pg2DWVKO7PNuze9+KesFWa+d+HMB7DTac+hgtijhu1QYkqY189ugnI4NyhRX3kNL3Br5vPp6oLBYF6xlPniEFppXqj0xYwlZg73MSApHuHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7257h+R0o/o6ytyI4blx00DiIxKkZCHIKnHK+3OHe4=;
 b=slRkge7aCCeqkPu5yDNlHzdlW4TJ8actLvPPg6TL/AXaDD/HunI/dWAcOUSHeWOlnnn1oSybIvj1l9s/nxPkskWZhRM9ToYHVN0t4/e1HsA4HMsGppCx3bhqibVPtwPYgueyetgBFqpfjHNNih7zbSTTTRmiS5ZIkKw2IicHUpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.28; Wed, 22 Nov 2023 08:37:03 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 08:37:03 +0000
Message-ID: <9608a9aa-26d2-4d27-b9b7-31f643307d2d@amd.com>
Date:   Wed, 22 Nov 2023 16:36:47 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com, amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, Netdev <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [Patch v13 1/9] Documentation/driver-api: Add document about WBRF
 mechanism
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Ma Jun <Jun.Ma2@amd.com>
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
 <20231030071832.2217118-2-Jun.Ma2@amd.com>
 <3e18c716-4c1b-ea3-ede3-5a67555f5e72@linux.intel.com>
Content-Language: en-US
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <3e18c716-4c1b-ea3-ede3-5a67555f5e72@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0040.apcprd03.prod.outlook.com
 (2603:1096:802:19::28) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|DM6PR12MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: f67f7244-989b-48a4-95b3-08dbeb363390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwQrJIteUGFwIDktNL6QEG349gWTk/m3Rbiz6Gna+tES/9VFUwDzJ6b8Q7bRoNcWkGecqiVDfjbsghdB65UIc2TINnW1GNegSOwZ6HYG36rNzUwgOtIwwRTjONUWS08ht73Ezd+cMkFZbu58c/fjIPwBpjuxxaAvDGdamhxc30lC9+AA/SanA7RriO+Qg4sLncgbGjatTyzqBOCOy2bsQjoytSCJXBsPoHgWxD5OmrT5ty/MM9FmVFoI2ZbMonCazJcM0i06UA+M28MKj4b6Y3reTXqn5RiTAtqOtD8TtRswT4+3inVddTNSjW6HB0l+MNSusKv2XLL8e4/Ds9Raan7sITAtl2nMexdjBoBrGbYuBRIaP0P8Gl9vvnmXcswYs83QhDphD4CMsCZd1WugCgC7CZr355x2T+mmkQxw4acSzPm7Pxns+7EgXVYyUFP2QsVtpi5QiPjQdahgggHRVIWd0qkuCCt5/O8HeOffSc53vUzXdW2vxszpCQpi5mILh1e62p08rE2SwSivIAuFUKNupe/3hwOq8KzgB+liV2JwatGpRK9Ms+mdc90gXDjjsiXwrO1qHwIveLjEzMPvKb/ViAVvYoVKEa8qqm7mZWQ8NpC9Fo2cTbQ6M71vK3CA/YqkBkXlVIQCKMHQEplxHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(66574015)(53546011)(7416002)(26005)(38100700002)(6512007)(4326008)(8676002)(41300700001)(5660300002)(2906002)(478600001)(8936002)(6506007)(6486002)(54906003)(6636002)(316002)(110136005)(66946007)(66556008)(66476007)(6666004)(36756003)(31696002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3loc2JSeDFuVEI3VlhwT0hLSnIzTmswRWhOcEx3SndJdk1EckVIaWlERUNv?=
 =?utf-8?B?RWtWU0tyVGQ4Zmo2Zm1mcTZzcUpLZE1rcCt3bnRFSlF5ajEvL252clUxdFR6?=
 =?utf-8?B?RjN5TTc3R0tQaUVuVzlnZDg3VndGRUlpS1FvZkVVd05SMG1IUmlCL0JnZjNZ?=
 =?utf-8?B?WkFPUnpxSnIxamVMUUg4WjY1Ym5XL2Q1WXlwc0JaaEFjMGJUWDZMek1tc01r?=
 =?utf-8?B?SHRxYjR0TjNBdjFkOEVLTjMvak84eldMT2ZKd3BRejM5eGhOa1Z6L2lGTUJR?=
 =?utf-8?B?YjFVaVlYa1NaUmMyWi9LdUR2QnkvWTd6ZVZyL1NQTURQS1NYTklHVjN1bm1U?=
 =?utf-8?B?enVwR3IvS1JHTUo4ZS9KUWdEU2phd08zTkNYaGZjV014NHVXRzFhK2tQek8x?=
 =?utf-8?B?eTdaMmFDdUh6OVRYeUc0VnYvMXBhSnpLNUNLLzlkdFBvdTJWVGVNVzRLY2hP?=
 =?utf-8?B?cFhDUXYySUxOeS9YSHF1aDZxcjFZTEZkY0cvTy9lM3BOVW1kTGtvZ3VxVnFD?=
 =?utf-8?B?ZWdQcTFkWXVhaDdQRzlmRDVRdFBYNU5CTm80MUlPYkltTW1RMU1yeVlGOXE0?=
 =?utf-8?B?RXBVRVNCQlRxWThYbEFaSW4zTmY3bVgzeTJCdXBDZFpOcTE1ejdFeXdablY5?=
 =?utf-8?B?dHlCdjRxSkFjRjdncXYrRXdiQ1hORjd2bGtsR3ZsUys3dnB3TDR4aDhFa1ly?=
 =?utf-8?B?RzVLQ2pwZEhSR1BjNmw5Qm4veW9vZllLR1JEMnJBL2Nmb2E1aW8yNU9mSkVm?=
 =?utf-8?B?SVZWZ2ZtVXlaMCtvUENXSHQwV2VNT0szOHpWZjlCWjE4alA5bkVGbmpSN0hY?=
 =?utf-8?B?Yk9OR0FCUCsrQTIyRmhqQk9OdHh2SzZCNFRHbGxUWVh2NzB1OTVwZG03S2ZE?=
 =?utf-8?B?RHB1cEJVOWh1SkVqRXNabXA2ODZiRk1OSlQrczhsb3V1S0hvY1c3UEJoVTZ1?=
 =?utf-8?B?UkpCenV5TUFZejJJcVVRc2lpUGxwTDdtOHp6OUx2SDlmdWk1cWZVeXRCeTd4?=
 =?utf-8?B?K2RLYlo3TkFhdHRmcmRWTmNTNTBNUHRKZFc1TCtqWUxpTyt2Z25YS0g2VUgz?=
 =?utf-8?B?ZE9qa0NhQSsvNGlQRjJ2NFhWOUFpd0FCTWVnNm01WXlGMnNNVzhlVDN6d0Np?=
 =?utf-8?B?YWxFVS82cTFkNzEwWXZxQ0hmZExlYjJrOERJandSZE1rK0p0NVdzcVVOQ0pu?=
 =?utf-8?B?VkdYQWhjazRmbnVySE9PcUttYVRzS3BMQTNLRHFTWG1OdlVYTHIzUXhPRzJo?=
 =?utf-8?B?OER3c2o2QjZYQjVSa2dQUWVQT3RvdkwvYyszZW4yV3laTTVrTVJWN2tNQ1B5?=
 =?utf-8?B?WTZNZVNic2IxWW5qaHRJMEtYMGNqUlZ3ZXZIYkFJWmhITVhXSGlKczJVYzJE?=
 =?utf-8?B?Q0ppazY3OXlsUUJtTGhKbURldlZaL0diR3cvcmVLdWN6cFpFZ3V4dGJRSFNv?=
 =?utf-8?B?L1dOcXh4WERLTTJkUHdROEYwNXdVdnh3RHJJL2h3aGdQUFpXNFlCSkV1NGpG?=
 =?utf-8?B?NlNTNE5PY0RlUWI4elMxWkRyejdUSUI3RFZsQ3RnS2RJSU5lSDBrWWRxV3cv?=
 =?utf-8?B?bXBqZThuaUxWZ3lBWWxPak5iZ2QxQlF3THpTeURGMWZQbHRUQlYwV3hyOEFv?=
 =?utf-8?B?NU1ydGo2Y1pIaEVIOWNJV0RvcVFqbTE2TlJobWNvdkZuWDkraUZZWDFzUEtu?=
 =?utf-8?B?V2EwM1h2ZXg4K0s2MmtheW1qNE04UFQ0ckpLVXhzQUpCOVEzZjlvZ1hrc00x?=
 =?utf-8?B?RmFSYkw4dG16T1ZjTFNIUjhCci8zU1FuTHV1RElTSm5XSUhvaDRBYm1VWG5k?=
 =?utf-8?B?UldaK3I0aWpvRy93WDgxUEJPL1RnbUNNQ3hyYWxXN25GamhacjU2T1VXL2Ri?=
 =?utf-8?B?QUMvK1EvaG9tZW5nQmEwRkZDTGhySXgrSnFiWkxsODFMOW40cVd3bDY4QzV0?=
 =?utf-8?B?aFJ0a1V1WjhHV2xGZHJHSDNxZ0YwNEVaNVB4MlA4dlNHMDY3T3N1NjJJMWY4?=
 =?utf-8?B?bmVjbUQ3bWVBSm9tMTdvR2M5T09qYndLY0pjajNXSW5RamdiSUpiYVFMRkxh?=
 =?utf-8?B?WllzZDNsS0E2TzUxU1NSWlc1OUVKanA5Z2gwYXVnbEE2TzM2WnIyUTNiSEox?=
 =?utf-8?Q?dA3E3d2TnkTDQHlAmFQeMrljn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67f7244-989b-48a4-95b3-08dbeb363390
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:37:03.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agl4SkjmmP/r/Hela79FNAXVgg8PKMqBFbv0SAoKVStV+/02cZSmItJSnePaYPqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi llpo,

Thanks for review, I'll fix the format issue in
the next version.

Regards,
Ma Jun

On 11/20/2023 7:59 PM, Ilpo Järvinen wrote:
> On Mon, 30 Oct 2023, Ma Jun wrote:
> 
>> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
>> explaining the theory and how it is used.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  Documentation/driver-api/wbrf.rst | 76 +++++++++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>  create mode 100644 Documentation/driver-api/wbrf.rst
>>
>> +Driver programming interface
>> +============================
>> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
>> +
>> +Sample Usage
>> +=============
> 
> A lot better but you missed adding newlines here for this and previous 
> section title.
> 
>> +The expected flow for the producers:
>> +1). During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
>> +    can be enabled for the device.
>> +2). On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
>> +    param to get other consumers properly notified.
>> +3). Or on stopping using some frequency band, call
>> +    `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
>> +
>> +The expected flow for the consumers:
>> +1). During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
>> +    can be enabled for the device.
>> +2). Call `amd_wbrf_register_notifier` to register for notification
>> +    of frequency band change(add or remove) from other producers.
>> +3). Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
>> +    current active frequency bands considering some producers may broadcast
>> +    such information before the consumer is up.
>> +4). On receiving a notification for frequency band change, run
>> +    `amd_wbrf_retrieve_freq_band` again to retrieve the latest
>> +    active frequency bands.
>> +5). During driver cleanup, call `amd_wbrf_unregister_notifier` to
>> +    unregister the notifier.
> 
> The correct kerneldoc format should be without the closing parenthesis:
> 
> 1. Text here that
>    spills to second line.
> 2. Second entry.
> 
