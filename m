Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E87FF902
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346711AbjK3SDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:03:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E3131;
        Thu, 30 Nov 2023 10:03:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHeVNrcxon7TqT0IKJiaqJS6E3ZTxHfwiXHnDrbJU7scxHEkI2Fg/QNi+30CYaC1at6ClwV8iqiRgQ9giK9S+N4atwDhhzqlPjEXG1r0Gsf6w/uBt4GX5FHDJZtxljMpHY8JOd4nVlSKt05G4Wg/WRf5+pvLpMFpWo623LtF95L5+l1an3iGfErLxEA8WhNaGCrhDJu5bXTNB7JYt2wuMuo5cymTeFWWI5Nm3Zss0wNxKTg+7K3rpTGPPxshsW8CDIfDhtuXiOXzGO7/a0P7r+gZfMNJm+xdFDUk/HzTEP3ZFLGqzyRsnqQ6CBt20JyYeff99JKgj3Li4OOdqzmRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY+NnzQI1ruUvvZiLM9Tp+qDqtzHe6YhUYsBIienmDo=;
 b=bripsjPoa5lEmRLT3Y5cvyGVxcAAn4janUIztLu4Nuc9ubQ5enAFLzZuMPisXMdP4nsvmqA0tDRiY9bipr8/QTM44h1EPHzqND2dBfFoNaQEJp7o8TcbOCMHnscWzyV/zSy86NMCPXLOESHj76lLnLgGiZKy1tW7aTzR4d0iJh1qTjRNZnPzdylnaj4lDnzZ316ocPLcY/RBRrcSjy39IRdDruR9gADmmEEX19t/5Zm75s444ZpZr5wx9CkvM5vqthuHolDe5zFXt9PhR4uvQJ2xYaJvrY9n9ZTuXhmryyOaWGAeKBaQR7/J9JaGCU7h7wGuwzPXtHSjndLYsjhC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY+NnzQI1ruUvvZiLM9Tp+qDqtzHe6YhUYsBIienmDo=;
 b=3iA5p1cigI9z/remkAcADtHGE6TZ7zpDFUfBjkD3jM1+eb//9lYo0X+S78W4o0mlRzwU7hVa0g4KeiraAiHX6Q228Go83+4RqkSZJ1beik7kvnZPh/206Du0RjAJtjs75YeJRzS2PJYr7OjhsL7PKVTJ+Pg8bdJqwKUp3c2GgDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 18:03:41 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:03:41 +0000
Message-ID: <fbfe27c0-1635-434f-a1ab-71a10c9d6f38@amd.com>
Date:   Thu, 30 Nov 2023 12:03:38 -0600
User-Agent: Mozilla Thunderbird
Subject: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
 <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
 <ZWeId332wmrdLycH@agluck-desk3>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <ZWeId332wmrdLycH@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:805:66::43) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df4d153-8b28-4c33-dede-08dbf1ceaf89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dceThIEmjHMkO4+4Kets+vl31cRfijryBYrRVm6dtiwg0DLhm9dOrGSeoehVDThfG3qYs1ejCtLak+tjvQ1aL4BTnpQR6eUdZLX3OVq6+YS5MmBPhz9FcBVZZSZKcA9oM/g0QjJKrZRTDEtDbyRL5VoKORmMljjODApcX5CF6NUPv9Qq/+4lKE5hxQ94MEAiUtBfPwMiUwg2gChpmeLGns9lXz2JrXmTVTcHKcFLdfv8zhEI8uUeIAC3cWAh7zrf/59oS5Y/Do8UblYmIP+tnSblIKwqeSXoZ2AOj9hBtSQqx4J51K0fGzuKkjMspMFTG5MoqGZgot+HSQT5JIive0RQu56utIiFEaE8K7YzascBIsAJHhI85czdEowWXS/gDVmyQTjEO6jcUMtRYrcGE21MiuVYAP7qckA74vvbWjO+7zaCofcK2mVjXwD4r4CVrarLm1AdEP22Q6O2UMHo2/a5lmlKxvbR/R5+Spyx5fjByDzyxEFhBUbWBH16o1jrTVawRTU9xu0p2vqV6CKk5+TSTLA6P0xKbG4PFiX2Pl/DPrrqPYDTTrK7D7nDpDE2Dy/NljknEK7nBNhPXhwP1apRkKSvAYwaGIikmK01IO2+Wl0370qIB7fTF4Pfjs/5DGa9rnT+TiuWUC2XqeMK8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(31686004)(38100700002)(5660300002)(2906002)(53546011)(83380400001)(6666004)(6512007)(6506007)(2616005)(478600001)(6486002)(36756003)(41300700001)(66946007)(316002)(8936002)(6916009)(66556008)(66476007)(31696002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmhPQ2NyZHRldzl6WEFtWFZFVHR2dkJpM2UwdkkrQWV0VGdtbzVlZlJENHlZ?=
 =?utf-8?B?OTEzek5ZNUhRWlNScWVtcytucVRGV1VwK2pEZndBTmFsZThrcGtrWFEzelUz?=
 =?utf-8?B?WGliKzBOTVFzUU91ZktMcFBLSnhJeDRvMjBTZTRDUHVucWxzS2h0elliS1o2?=
 =?utf-8?B?d2NJeHdZOWlEWUJCU20wUTBwMTMzakV4TXVWOWk3OE15SW52OUxNeXFFYnJB?=
 =?utf-8?B?bTZQNVhvY1p3ZTZHNUhObFR5TlFGNHgzN1FrVXJjUXRSMmFrdm1mVzJISnV0?=
 =?utf-8?B?TkVQUE9HNmJ0NzZiTS8ydmdqTVBmVTdwZllUZEkvWmptVkJ6TklrOUNFL0ZM?=
 =?utf-8?B?RUVqeXhDQ0I0RTFrYkM4ejVwdkJvVU5wQ0lHTC9oODNBdll5bHVvRWl0UlNR?=
 =?utf-8?B?UGk0U3h0SFFxaEMydGRtaXFrdXZ3VUxrMmNlOHlTWmppUkVBSmZWbVo4WHRp?=
 =?utf-8?B?eG8wV2M3d1dPT0NmSkpnWTFaUktqakIyVi9WNExhVFIrbDRpRGlJY1ZRZDBp?=
 =?utf-8?B?Q1lMTG1UZXNaUlc2TGphRVByQTB1S1diWGZwS3hVaFFUNk1sM1VyM2p0dkx5?=
 =?utf-8?B?VTQ0WVUxenRTVXFxcWdUbWt5VHNJTTNIMnFFdzVsSnc0QzF1QlVlZ3ptbm9T?=
 =?utf-8?B?YU5lSSsyNS8wTkhmMnZhelFqT2oyY0VKZWFRdmMvSmVZUWFLUmwyUjRqanA2?=
 =?utf-8?B?ZWdON0c2VlJZQmQvNzRoRVZrd2IxVDRSbjFVSFFsWkNkREpNUU1QMU1Pd2lj?=
 =?utf-8?B?N0lUczg1cUk1QTJIYVFjRzFTdGYyZE0zZUZlZjJ2Z09CNVo1TUpYeVZWWVNE?=
 =?utf-8?B?T1ZLSFVUQmlPbG9mUnZxd0Y5aTkxdWtDS3ZlaTZ6ODNMWG1FaXdmVWlFNjlD?=
 =?utf-8?B?TkNJR2w1UkRiQUlET2ErTnY3TnQraGtuQlZkRGRYUXZNcWFNd3VFaittbHJn?=
 =?utf-8?B?Y0tMMUQwdHM2T0RVRTZWNm9oUC9kN1BuWGVSaDUvd1pGQU14emNrN3FUUndL?=
 =?utf-8?B?U0F6RUhnK3JjbnJRaUMxRVhqY3ZPNlRPMndTUWt0cmxSL3pEY0VIdGR2V1N0?=
 =?utf-8?B?VWNpbzRlS3k5aDdiaGRCY0tZSFdWcC9SMjlWREFRVFlNZzN0TTA4MnJtRmZu?=
 =?utf-8?B?RjRJaDFKS0czMjcxUEtwVGQ5MXRzVVFCZDV2ZklqQ2hITnV3enQ3aGRxNENG?=
 =?utf-8?B?MzhtT1Z4cGlHWnZHenRydXl1QkxzMERVNktiSWp3MU8rSHBJZmpPeEJOYThM?=
 =?utf-8?B?WnpjMjUvOUNzYUk5OGZsNFdlOXFKMzd6Qjc0azdyQWg2UXMyemFiOWFGSFk2?=
 =?utf-8?B?d1pyNlkwcjRTc0Z4OU8yU0YyYTZkemozRFA0aUxOVE4rYUJULy9xSDB1Q1lX?=
 =?utf-8?B?eGZWTzkzREdhMkdTdldqblh6M1NGR3dpQ1FaUm9vcXdaNC92MXZZWWJ4R2Fp?=
 =?utf-8?B?U05ES2M3OTMvdEVWWjNSR3lzejhzSGd0ODhGb0ovV25ZZzg4czZXOEp2dnFC?=
 =?utf-8?B?ZG0yNFA1UVI2QkpxUlptQ0Y5OVhUQit2Qk4vTUhubWJrb3NscGxKak1TKzhP?=
 =?utf-8?B?UC9KUVBpK0djcjQzSnlQTjlHNjEzcStqUjJFK2w1NEhGRE45T1EzZWlvMFp0?=
 =?utf-8?B?S0hFM0hOSkJCaHVTOXg3NDhDcjVOaW9VUEJQM2czUFdjWS92UEZ0SnZSS2Vt?=
 =?utf-8?B?bkcvSVBNT2NvM2xrTmRuSE9UUmJIK0dYRFFlK0tqWnl0bHI4R0lYa3AyOEZs?=
 =?utf-8?B?VEtQeUkyN3BIbGhDRi9leng1TVdPa2lBVVR4d2RGVEQrNnpoZDBpMm5ydzlo?=
 =?utf-8?B?eSs0UVl1ZnNiRFJWMEZiSlNtNjVRZ3dab3V6ZDBNUjg3WVZrRzJneis0U2d1?=
 =?utf-8?B?NW5zK2xZb0FKdERqNjIyb0dpekxxbjRMV0ZWaCtOY28zNkRSdEQwbi9rUmJs?=
 =?utf-8?B?Z1diZ2kzSVAydHZONW9Lak9kRlUrWU93eTFheVRPYXorZDFpSmwzaGFrZ3Vp?=
 =?utf-8?B?VUcwU0xnZlpRZzhZNFlrOFo1L1diYVVzcEhCS0tPZm1kUU1sZldNaDBFQjZP?=
 =?utf-8?B?RC9HV2xtWURWZGl0VWZzdFdzaWV1ZDdUVkl5QXNtb3hxNjQ1OVh6TkRsbzR6?=
 =?utf-8?Q?Xp7bDYIFNOlafkEdxf9VIKlg2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df4d153-8b28-4c33-dede-08dbf1ceaf89
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:03:41.6060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/pGTLp/yjI4VGVYUcWxGKU5ymLorwAy0qUuTf/Z686gJYKdevKtqR1DzSAn5pv1TIbHhctxNbx8cLuKULIYEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/2023 12:52, Tony Luck wrote:
> On Wed, Nov 29, 2023 at 12:29:16PM -0600, Avadhut Naik wrote:
>> Hi,
>>
>> Any further feedback on this patch?
> 
> Yes. See below.
>>
>> On 11/6/2023 14:13, Avadhut Naik wrote:
>>> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
>>> a set of GHES structures is provided by the system firmware for each MCA
>>> error source. Each of these sets consists of a GHES structure for each MCA
>>> bank on each logical CPU, with all structures of a set sharing a common
>>> Related Source ID, equal to the Source ID of one of the MCA error source
>>> structures.[1] On SOCs with large core counts, this typically equates to
>>> tens of thousands of GHES_ASSIST structures for MCA under
>>> "/sys/bus/platform/drivers/GHES".
>>>
>>> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
>>> such, the information provided through these structures is not consumed by
>>> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
>>> to provide supplemental information in context of an error reported by
>>> hardware, are setup as independent error sources by the kernel during HEST
>>> initialization.
>>>
>>> Additionally, if the Type field of the Notification structure, associated
>>> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
>>> sets up a timer for each individual structure. The duration of the timer
>>> is derived from the Poll Interval field of the Notification structure. On
>>> SOCs with high core counts, this will result in tens of thousands of
>>> timers expiring periodically causing unnecessary preemptions and wastage
>>> of CPU cycles. The problem will particularly intensify if Poll Interval
>>> duration is not sufficiently high.
>>>
>>> Since GHES_ASSIST support is not present in kernel, skip initialization
>>> of GHES_ASSIST structures for MCA to eliminate their performance impact.
>>>
>>> [1] ACPI specification 6.5, section 18.7
>>>
>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>> Changes in v2:
>>> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
>>> if-else-if chain is redundant. Replace it with just if statements.
>>> 2.	Fix formatting errors.
>>> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>> ---
>>>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
>>> index 6aef1ee5e1bd..99db7621adb7 100644
>>> --- a/drivers/acpi/apei/hest.c
>>> +++ b/drivers/acpi/apei/hest.c
>>> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>>>  
>>>  static struct acpi_table_hest *__read_mostly hest_tab;
>>>  
>>> +/*
>>> + * Since GHES_ASSIST is not supported, skip initialization
>>> + * of GHES_ASSIST structures for MCA.
>>> + * During HEST parsing, detected MCA error sources are cached.
>>> + * Flags and Source Id fields from these cached values are
>>> + * then referred to determine if the encountered GHES_ASSIST
>>> + * structure should be initialized.
>>> + */
>>> +static struct {
>>> +	struct acpi_hest_ia_corrected *cmc;
>>> +	struct acpi_hest_ia_machine_check *mc;
>>> +	struct acpi_hest_ia_deferred_check *dmc;
>>> +} mces;
> 
> You are using this static structure to save values while computing
> the length of the HEST structure in hest_esrc_len() to be used later
> when is_ghes_assist_struct() checks to see if it should be skipped.
> 
> But you don't clear it between iterations in apei_hest_parse(). So if
> the assist structure was early in the array of HEST structures, your
> is_ghes_assist_struct() will keep looking at stale mces.{cmc,mc,dmc}
> values.
> 
> It may not break because the related_source_id in the subsequent
> structures won't match the one you saved. But this seems wrong.
> 
> On the other hand, if this caching of values from some structures
> to be compared against values in later structures is intended. Then
> you need a comment on this structure to say that's what you are
> doing.
> 

Yes, the static structure is being used to cache detected MCA error sources
in the HEST. Per ACPI spec 6.5, each MCA error source i.e. machine check,
correctable machine check and deferred machine check will only have one entry
in the HEST and the pointers in the static structure will be initialized to
point to those entries when they are detected.

Later, if and when GHES structres are encountered in the HEST, is_ghes_assist_struct()
will check if the cached error sources have GHES_ASSIST flag set. If they do, the
related_source_id field of the GHES structure will be compared against the source_id
field of the error sources. If there is a match, initialization of that GHES
structure will be skipped (since it is a GHES_ASSIST structure for MCA) and we move on
to the next entry in the HEST.

Thus, clearing the cached error sources between iterations in apei_hest_parse() might
defeat the purpose of the patch. We need the error sources, specifically thier flags
and source_id fields to determine if the initialization of a GHES structure should be
skipped.

> the assist structure was early in the array of HEST structures, your
> is_ghes_assist_struct() will keep looking at stale mces.{cmc,mc,dmc}
> values.

Didnt really understand what you meant by this. Can you please elaborate more?
IIUC, GHES_ASSIST structure will not occur before its corresponding error source
in the HEST.

Actually, caching of values from an earlier structure to be compared against values
in a later structure is what we intend to do here i.e. comparing cached source_id
from an earlier structure with related_source_id in a later structure. To hint
towards the same, I had added the below comment on top of the static structure's
declaration:

>>> + * Since GHES_ASSIST is not supported, skip initialization
>>> + * of GHES_ASSIST structures for MCA.
>>> + * During HEST parsing, detected MCA error sources are cached.
>>> + * Flags and Source Id fields from these cached values are
>>> + * then referred to determine if the encountered GHES_ASSIST
>>> + * structure should be initialized.
>>> + */

Is this not good enough? Should I make it more explicit?


>>> +
>>>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>>>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>>>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
>>> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>>>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>>>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>> +		mces.cmc = cmc;
>>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>>>  		struct acpi_hest_ia_machine_check *mc;
>>>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>> +		mces.mc = mc;
>>>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>>>  		struct acpi_hest_ia_deferred_check *mc;
>>>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>>>  		len = sizeof(*mc) + mc->num_hardware_banks *
>>>  			sizeof(struct acpi_hest_ia_error_bank);
>>> +		mces.dmc = mc;
>>>  	}
>>>  	BUG_ON(len == -1);
>>>  
>>>  	return len;
>>>  };
>>>  
>>> +/*
>>> + * GHES and GHESv2 structures share the same format, starting from
>>> + * Source Id and ending in Error Status Block Length (inclusive).
>>> + */
>>> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
>>> +{
>>> +	struct acpi_hest_generic *ghes;
>>> +	u16 related_source_id;
>>> +
>>> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
>>> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
>>> +		return false;
>>> +
>>> +	ghes = (struct acpi_hest_generic *)hest_hdr;
>>> +	related_source_id = ghes->related_source_id;
>>> +
>>> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
>>> +	    related_source_id == mces.cmc->header.source_id)
>>> +		return true;
>>> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
>>> +	    related_source_id == mces.mc->header.source_id)
>>> +		return true;
>>> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
>>> +	    related_source_id == mces.dmc->header.source_id)
>>> +		return true;
>>> +
>>> +	return false;
>>> +}
>>> +
>>>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>>>  
>>>  static int apei_hest_parse(apei_hest_func_t func, void *data)
>>> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>>>  			return -EINVAL;
>>>  		}
>>>  
>>> +		if (is_ghes_assist_struct(hest_hdr)) {
>>> +			hest_hdr = (void *)hest_hdr + len;
>>> +			continue;
>>> +		}
>>> +
>>>  		rc = func(hest_hdr, data);
>>>  		if (rc)
>>>  			return rc;
>>
>> -- 
>> Thanks,
>> Avadhut Naik
> 
> -Tony

-- 
Thanks,
Avadhut Naik
