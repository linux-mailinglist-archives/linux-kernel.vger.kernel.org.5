Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD27804B12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbjLEHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:22:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B174AAA;
        Mon,  4 Dec 2023 23:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4vTuCijQ/NnlVJ+Wh3WfNdzS+ax3vntxJuOUguQU4Cik00e8lZcPKu7spb0C1VVqF+UcqQE/OlQ26LNPFJq51L07bEApnq6dn3PqWE8IxGtoAgDXur6MPSCEoi+VOD5rK61QGSI/JDs6MC1S7w3ZmAPVuvLVgGwinxNHyCv0M9kRE2sWrQ3rMZYv/dRNXbwDG3C7wN3czzDpB9ZrBWyuDSmPQ/kAtXwSLafQgC7NAFNQcL273n92qycMJ4apzq0G9oLDMPq8IvFTESjEO9lZXYVbAbClJu8ohp22KBQgNAIKjKvBMaUuJAyjQlU35KPEYyvwq3rzCdhymhz2ksWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IujlPXLGAlVI6DhhUG8t6n7h1PeBtVYcUyz/Eec5P6g=;
 b=DdPlAmcEQjcO0Du4EQClsAnE4LtAdxondc5BRa7s+peDEB+1IteBkXIqlkSiScwkURyn5NVs1x0c1RdfF/swmtgbCYcLhFiv1fKcp6M8A+PfmUPYtLXvaxMDg4UtAsLZwfdHmwlVpKh6Eg7z1LOzUA2dr1on/ewPvH37ozfL73DgnaKnBdkFmhRWICytUlOMMcqlPwtQOsXE9y7nGf7CMh1ZEVtmz+vT7WxZhrkLhie1MrGmNQfvDxRbNnheh4M1EerDRPwXdmWcXJtSSvilfFI+6NuP5KtUayjWBDyGlfzq5AqVNPA58+6ZVEZuz87/nQpnqHq9Xi6SsJwIbz6aLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IujlPXLGAlVI6DhhUG8t6n7h1PeBtVYcUyz/Eec5P6g=;
 b=vAon/PrEgQbJqVnjxBCS0Bd5JyrhOAluLE3p/eyGFsHemoxFivr6HbvMItjE6OxIZoEtPkcsnmuA2ncs5K1lr2X4s/Rm4HS4AbIPjBnA6A5R3cy0TQzkXAOgARxiww061n5z6bapqUF75JMRaIjtoBIPW7YpqPwyNWg6gKtBRWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:22:20 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%4]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 07:22:20 +0000
Message-ID: <67fe48be-8e10-47f7-bf47-e819ed02e732@amd.com>
Date:   Tue, 5 Dec 2023 15:22:07 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com, Evan Quan <quanliangl@hotmail.com>
Subject: Re: [PATCH v14 2/9] platform/x86/amd: Add support for AMD ACPI based
 Wifi band RFI mitigation feature
To:     Hans de Goede <hdegoede@redhat.com>, Ma Jun <Jun.Ma2@amd.com>,
        amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
 <20231129091348.3972539-3-Jun.Ma2@amd.com>
 <99de0223-6d28-4379-ac2a-ef093ee0386c@redhat.com>
Content-Language: en-US
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <99de0223-6d28-4379-ac2a-ef093ee0386c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b29fc74-337c-4d8d-f8cf-08dbf562eae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsC0tE+n7kJlOFHx4M+Uu1qD2XOQVNsGVHyPA03a36/wbIYflT3iNfZ2BebPq4gfzvW8hd2o9nrW9+1tL/UOmPt+VyJGU3A3qcQbK1juSTMYvbJeoAg/gzdknPxN9WAbG+PWZTlRZapVEBo+I/mBY8CIEp2wAqksMH6B3VqWow0j9MbUlnFcE5kbOTJlXx/AO60PfnvJtvGm7Bt2oU2Zic3s+zYsTkwi8ogySF5jJO2bBQZVXD7HwI14DtCSUf5ZP80ZeXs4WL8+vREMAS8om1ItgQDEsIerFAqeqy3dL51bwwBXodfjMOz2TIZxOYdnWFYeCYMcJxfjPe2LQds3y1dWMaHL5f7RAJ8y4akZleNveZNMY1x0RQwA4UVU9bx8/J9mNvz7GXWgTXAJJUhKoTpSSBflHg7glAhs+qibIGGc4n/KamkfRthB/N3/syNJHvh1o34rI7DKfsWsqDQR9L1w553Lu5rXX5qN5NuRCfoXnMh/GSKIBSsw2BTSWDWwCZFg9QJdVy09TDEyhU2u7pztIemiJ5gjUFiGen8MSpvASb//L32YvEv+seuiCerLrmK/AyM2UaC09f7Xu5plRfFemaRun1DvO0AlgzPImpaVyqgPEUp/1frOgtOZIKQAnshralq+sNXIgBgYHuUFaqssYKydpd+982/zfxrShik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(921008)(6512007)(45080400002)(478600001)(6506007)(8676002)(6486002)(53546011)(2616005)(6666004)(26005)(110136005)(4326008)(66476007)(66556008)(66946007)(83380400001)(8936002)(316002)(38100700002)(7416002)(36756003)(41300700001)(5660300002)(31696002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk15T1h0Q2gyU2tleWZQbG9qaWZoUExHWCtacmdXTUMxN1d3eGFWVllnVnFO?=
 =?utf-8?B?ZUxUZGZwclY2aUUwYVh2bXhsZ09oZUdIS3p5ZGVSN1VuVDdza2RGaTVYOUoz?=
 =?utf-8?B?ZGRiVlZvdWE5UnN5L1IwOVg2eVBoa2E2N2tnUHBoTVE4cEx1UVJhZ2JxVXc3?=
 =?utf-8?B?TWwrMWJ6MmFNUDRrSzRUY0FRQWdYODlYQ0IzZFZac1YxU29tVFN3OE51OVRy?=
 =?utf-8?B?UlJwaUdYcGtWeXd4NjRrUE96MElialNGQysydEJCZ3JZNENWZ0Y3TG1wNTRy?=
 =?utf-8?B?UkNZUXRzTFlkMnVEa3dCVDYzRW5ERXVxVUdqQkI5V2MyWUtQYnBrdVYrMk1n?=
 =?utf-8?B?WkJmODNtcDF1MnNXWHl6Zy8zblRhUG1Ca0Y1UCtnVTBYNk1lVW9FOGV2bW4w?=
 =?utf-8?B?RUpORmRzMzBnZVEvbmpyUytxbnpGeWpHR2JXUDdCakJQWmtzMXNidi9LQkF0?=
 =?utf-8?B?TmZNbXVtZXhKZkcxSis0Z0FXdGRpb3RIYkVZY0M5cGZpQkY0Ynp1VVQvejBT?=
 =?utf-8?B?bUhpWmNjQ3FFYkpQdUZ6TVFHZm9xbmx2elJOQlg5LzA0V0ZkQmw4aWNiQlhE?=
 =?utf-8?B?ckNZZUgwM3RUYVdTMzFodUsySkNoRVRhbTBpUlJ0amxRNTMrYjcyY3ZTaE02?=
 =?utf-8?B?TE40R25nWHVBQ09iN0FLZG92UytzanRjRHkrNEtaNjJ5WEIxckRiSWZnSE9o?=
 =?utf-8?B?bmZMd3R0eDRPRGhWTnlkc3VXRlNhNk11YWgweVRtTFZYdUdNamdoUC9tSlRD?=
 =?utf-8?B?RnVJRWQzRCtIR3BnNFd6dGZrbmJpR1VuTDNrRXFaZ1dGYzMzbkRkVGY3cXpR?=
 =?utf-8?B?WEVDVno2alNRcHlyUmkzNkJiaVo5VHR1V1F5YUdiRzJwdkt1bUZ2WjRxUEdH?=
 =?utf-8?B?OUdLUDdqcFkvTnBNa1F4dms3RTQ2SExJNTlyeTZxc1dMSTNhOFZkc1FEVDlk?=
 =?utf-8?B?cE42aFBjUlNiUnVheDZZOEUrTWRCb1lkei95MlBXb1NzZjZTbGZoUU9ZMlJN?=
 =?utf-8?B?VlNUcUx5Ukw0ZDI1d2Qwekd2WVMzT1BFdE5zY2JvbTI2L0FXSVAxSFM4TXE3?=
 =?utf-8?B?REdhSmJPbHBJS2tlR256Zkp2ZThCeDg4bWoxOWdMVGdsdkN2NUlGcFYxM1h5?=
 =?utf-8?B?MFg0bE05UUlhbmkyWGNpYmxEZVd6M0xISlJoZXZnMEtnZHhEVURPckhCYlAv?=
 =?utf-8?B?U25wdEJzZGt5SHRBbXRndyt0QVhyeHJiMnV2Rzh2Y0lZK0NqdjJvckZnOTQ3?=
 =?utf-8?B?dDhYQlVTcVBrN05lU0k0OFc2VVZSZ1pnaW0rOFdLdytJVzAvVXEyMlhZMzBy?=
 =?utf-8?B?a2RML2EzV1FGZzEzcEMwclREN2NwakFxNDBUNTBiTUxZSkh3Y2RtMnhxdWxu?=
 =?utf-8?B?d1ppZjNLemhmWkRQWkk0R050eDNNL0k2Y2p4Qzg2TnEvL3ZBckZRYVFkRXZP?=
 =?utf-8?B?SXhOYU04K3o0OFpkRk5PNlhPRUE0RkdKTTNmOHFsRlpmZlA5WldpeDBZVDRk?=
 =?utf-8?B?d3B2RGZEWG1vVlZNakdGSWFvRWNqZmkyN0VOTEcxOWptd29ia0NMM255OEhS?=
 =?utf-8?B?cnEvbUJlOFNScCt3N1F0NGlwZUJ6a3lXSVQwYzBYMVBqSGd4VEZQMGliTGhk?=
 =?utf-8?B?NGlxWlBoOEdreXkyeEd0VjFvVnQzTmEvdjVIRWRpT2p3MlE5d2xycTJLNDdD?=
 =?utf-8?B?aFhKNndxUmJnUlA2NkI0N0U4c1F4S05pTVdKY2k0ZU53NE04cFVOTmVseWdO?=
 =?utf-8?B?cEZ0N3ZiSysrL0RnNGZQWWNheUNBMGIxQ0h2V2dLeWNYUEk5WTJOWE5uTlc1?=
 =?utf-8?B?Y2lMaGxjQ1dFTVNzNGNaenl3WENZS01tall6S2lSQzE1ZHp4M0ZqckVwRGwz?=
 =?utf-8?B?VXR1cW8rVUJEaEp3N1VrM3F2ZlExcjQvQTd0RzBoUUlNWnZOUnhlSkNOa3NQ?=
 =?utf-8?B?YVgwRlNqUUJUeW9MTjBTYThFem9hOTZQN0twSEpybmpvODVBU2k0ZFhKZ1VG?=
 =?utf-8?B?Q1hzK2VTbTl4T0t5VDl0TGFNWThnZG4vd0dhOVRzVTlSWEtJdHFqL3NBcTN1?=
 =?utf-8?B?UXhpWDlhUFg0V1M0bUVlOWprZkFtY053bVhjYjl1aDh5V0J4T09jMHhGd3gw?=
 =?utf-8?Q?b2oo8KXryhj0GBhXWSBTU5SJr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b29fc74-337c-4d8d-f8cf-08dbf562eae6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 07:22:20.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPndJ1BryngIR45G1rfY9+DLFRPMBmIB3oXXrrqY8GyVBOSuP0IDaPIYVD74g+J8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 12/4/2023 9:00 PM, Hans de Goede wrote:
> Hi,
> 
> On 11/29/23 10:13, Ma Jun wrote:
>> Due to electrical and mechanical constraints in certain platform designs
>> there may be likely interference of relatively high-powered harmonics of
>> the (G-)DDR memory clocks with local radio module frequency bands used
>> by Wifi 6/6e/7.
>>
>> To mitigate this, AMD has introduced a mechanism that devices can use to
>> notify active use of particular frequencies so that other devices can make
>> relative internal adjustments as necessary to avoid this resonance.
>>
>> Co-developed-by: Evan Quan <quanliangl@hotmail.com>
>> Signed-off-by: Evan Quan <quanliangl@hotmail.com>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>
>> --
>> v11:
>>  - fix typo(Simon)
>> v12:
>>  - Fix the code logic (Rafael)
>>  - Move amd_wbrf.c to drivers/platform/x86/amd/wbrf.c
>>  - Updated Evan's email because he's no longer at AMD.Thanks
>> for his work in earlier versions.
>> v13:
>>  - Fix the format issue (IIpo Jarvinen)
>>  - Add comment for some functions
>> v14:
>>  - Use the apci_check_dsm and acpi_evaluate_dsm (Hans de Goede)
> 
> Thank you this is much better.
> 
> I notice that the #define ACPI_AMD_WBRF_METHOD	"\\WBRF"
> still exists though and that this is still used in
> static bool acpi_amd_wbrf_supported_system(void).
> 
> I think it might be better to just remove
> these 2 all together.
> 
> Checking if a DSM with the expected GUID is present
> and if that has the correct bits set in its supported
> mask should be enough.
> 
> And on future systems the implementer may decide to
> not have a WBRF helper function at all and instead
> handle everything in the _DSM method.
> 
> So the "\\WBRF" check seems to be checking for
> what really is an implementation detail.
> 
Yes,you are right. I will fix these issues.
Thanks for your review and suggestion. 

Regards,
Ma Jun
> 2 other very small remark
> 
>> +/**
>> + * acpi_amd_wbrf_supported_producer - determine if the WBRF can be enabled
>> + *                                    for the device as a producer
>> + *
>> + * @dev: device pointer
>> + *
>> + * Check if the platform equipped with necessary implementations to
>> + * support WBRF for the device as a producer.
>> + *
>> + * Return:
>> + * true if WBRF is supported, otherwise returns false
>> + */
>> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	if (!acpi_amd_wbrf_supported_system())
>> +		return false;
>> +
>> +
>> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +			      WBRF_REVISION, BIT(WBRF_RECORD));
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_producer);
> 
> Please don't use double empty lines, one empty line to separate things
> is enough.
> 
>> +
>> +/**
>> + * acpi_amd_wbrf_supported_consumer - determine if the WBRF can be enabled
>> + *                                    for the device as a consumer
>> + *
>> + * @dev: device pointer
>> + *
>> + * Determine if the platform equipped with necessary implementations to
>> + * support WBRF for the device as a consumer.
>> + *
>> + * Return:
>> + * true if WBRF is supported, otherwise returns false.
>> + */
>> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
>> +{
>> +	struct acpi_device *adev;
>> +
>> +	adev = ACPI_COMPANION(dev);
>> +	if (!adev)
>> +		return false;
>> +
>> +	if (!acpi_amd_wbrf_supported_system())
>> +		return false;
>> +
>> +	return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
>> +			      WBRF_REVISION, BIT(WBRF_RETRIEVE));
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_amd_wbrf_supported_consumer);
>> +
>> +/**
>> + * amd_wbrf_retrieve_freq_band - retrieve current active frequency
>> + *                                     bands
> 
> You may go a bit over the 80 chars limit, please just make this
> a single line:
> 
>  * amd_wbrf_retrieve_freq_band - retrieve current active frequency bands
> 
>> + *
>> + * @dev: device pointer
>> + * @out: output structure containing all the active frequency bands
>> + *
>> + * Retrieve the current active frequency bands which were broadcasted
>> + * by other producers. The consumer who calls this API should take
>> + * proper actions if any of the frequency band may cause RFI with its
>> + * own frequency band used.
>> + *
>> + * Return:
>> + * 0 for getting wifi freq band successfully.
>> + * Returns a negative error code for failure.
>> + */
> 
> Regards,
> 
> Hans
> 
