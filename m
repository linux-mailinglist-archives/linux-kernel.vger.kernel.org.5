Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E0774E00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjHHWJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjHHWIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:08:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B64DE72;
        Tue,  8 Aug 2023 15:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPa+G4YXzABcILqS+nAsuCgUTYQcHSsWMRI888GMqwn1Fh9b+VbzI9ve3BKCi6QFS1YvCgvcieOr0hMEpFruJBRuJkQGy+l3ptknHsPH1MyHvkGF39PLbE4Sz9cQRjTQsw2+eDodoeOCkPcJTXS35NtzOY+Nzpd6rLd32PAraXi3aFvaYD5hoUewa4ZZYe2gQ+emeEtFcZp6qKVJlFsavIUGpQyCeCribCubX7OL74EFgXgY542eKlbiAPplF0JGWQqH3hMdBakuHT3fL7jFBqksCPJucs1z2PlRasiaMhkREikTJJWvUu7QTiI/Wg3dgdGCiH8AHIo7rmJMAD5IvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh75j7M5vUV6ksQqLdSM2ySPCzs+5xTywmD3orORUSk=;
 b=Or6g/PsldXip1jt/8WgaV4TyMW0RLjbKr13Db4MSf0lsGgsqYKJrFcRg5qFEHyVbr9wSSyUVjml+yQWwytBLyT1PWYCO2E//0EgXL1ctYAeDkhnOYIICTJiDJ+rhADVp/VPkvOVeBcrquNanfFv9lgYvLnLX6XzfS+CP30ZBGui2zXAlKspnZTjPMjebiyL2SgF71g5Ara4LVwUiIgtcN0oRmU7C9YASKDtYhh1JhGma5+W4XpxB/5nkGOiw2cWrOqydrQClXttKn/MxX5K5DS4UfJpDYjRpKORyuXvo0Jzifj1uQCfTTZrXrYQ9ngx1MQyBLby/eqiNM85x8mUk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh75j7M5vUV6ksQqLdSM2ySPCzs+5xTywmD3orORUSk=;
 b=fJnQIeDnhRiV6nNZt9NPS4f0DoEmhjcnV68kKu/ZSnTufICfkMT/2ZJL4DpJOk7JF9rlcRjbp4fIFXZr26tpNf5rYNtVQddsDkJVKLhy73g+8FbMoXRjVRYMtRHh/ezz+a7ImQU6KRCFJFhBKMHlSEmcG4lL7XTb16oVa9Fck5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 22:08:43 +0000
Received: from CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582]) by CY5PR12MB6203.namprd12.prod.outlook.com
 ([fe80::48cb:8b61:d51e:3582%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:08:43 +0000
Message-ID: <2a8ece3c-76cb-c922-1ecc-3a4515aa406f@amd.com>
Date:   Tue, 8 Aug 2023 17:08:40 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v1 3/3] EDAC/amd64: Add support for AMD Family 1Ah Models
 00h-1Fh and 40h-4Fh
Content-Language: en-US
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        Avadhut Naik <avadhut.naik@amd.com>, bp@alien8.de,
        linux@roeck-us.net, x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230706171323.3722900-1-avadhut.naik@amd.com>
 <20230706171323.3722900-4-avadhut.naik@amd.com>
 <e5b0063a-ae41-41ab-b3a7-2084dfa7f816@amd.com>
 <1606f9f9-5d5a-788d-b058-ec218fb73712@amd.com>
 <36bff484-f41a-4eed-bcd6-a96539b905b8@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <36bff484-f41a-4eed-bcd6-a96539b905b8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:5:190::24) To CY5PR12MB6203.namprd12.prod.outlook.com
 (2603:10b6:930:24::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6203:EE_|BN9PR12MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: e0d54ad2-150f-4341-8624-08db985c0743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Wygd9e/eNZTzEZOC8pKbPsOciOyJ6tCLmQXZZ6fbWpTNnQXIHUqv5ci5Sdv7HyouaeZJ3ZToeWGYZwD92yyhSftrLKPX0U8r/cigD6ld07996uuYmWFvOftWLTPtwBmsWeYnxZFBHSEuyODD3ECc7rVz29msgjff6GHI6967JO9P0w4dU+n0ZiQLnNEUmdvvi3wnUvmUYBuEIVhhj6RBa5d2kwooYbDGm0gWUeX9As+EnZiuGeEcpV9sfVNTms0aKjhmgI7FhHApkrZ+oEdG0XWc1hieGbGIb7tuJEreFW1Nc6LthpP7ZMVplyBbgOQ/x0T0MDvnlpSjyMGyB64xegv2CAxOf+Kd4TOMedu2YMDA3br3B/tH2/kk2970yg8BXrKP5HIYVIsswK5YoGABspaQQZarwfHMG9IvrULtxO9i54/pl0pSjfRm7VyRGnuJgXEZncehKA2rlJ20Km2V8UFSxyinzwLaITrGt1wQkCJDosgUjEMsNHrsPmwERPk3gMRcK4ttUzWRV/uliuQUyjmtorrK5bWZTZpVX/dMgnNaVyxE/eg/LpIRQap8BulKGI/0BtIXVozCdMvSuQrqg6qIukt4Q3VNzAJ4l7WQ40xQ+DcdKqcxeHbNYDD7WiOlDN2sDOmsfj0gf1VSrAalQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6203.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(1800799003)(186006)(4744005)(2906002)(83380400001)(41300700001)(5660300002)(8676002)(8936002)(36756003)(31696002)(110136005)(478600001)(38100700002)(31686004)(6512007)(26005)(6486002)(53546011)(6506007)(66476007)(66556008)(66946007)(4326008)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHJ0UGNxR296Ui9RaXk4OHFwSW8xTCtReWUrWG5ZeG92ME9na0tKbDVMc296?=
 =?utf-8?B?SXJBdHdnUVN2ZmFBYzJUeWpmaU5DSHR0THNMdnRFdlpTUFZxalJ1emRUeXlw?=
 =?utf-8?B?UFUwd1QyaDZsdFY1VjdsVDAxOUtyMGthZnhxSVpFTFRtSXlqK3FqR0tZcHlp?=
 =?utf-8?B?M0VhdGtZQUtXZ3k1cU45VjlRSVV1dmxFYTQvUnl3RFVOYXoxeDhaWFZQQVNx?=
 =?utf-8?B?ODVVZ1U3eDVDY0hFblF2UkdXMVdVa2s4OGhQQVRPeCtnSnBmeExLanBJbDhX?=
 =?utf-8?B?aXRiNVBGclFrUTdmTHE3SVRNWXlvRml2SURwUTBjRkdVUUpmaWlYM1htOUM5?=
 =?utf-8?B?a1N2aFZBL1RYTWthTG5qUERUZmhTa2lrTWpLY1hyNHVoeGQ3QStnSWdhaWZk?=
 =?utf-8?B?cVo5cnkvQ1dneVdzUGlpRE52MU9rZmtCUEZyTVpJS1J6ZG5wSTVVWE9BbGtW?=
 =?utf-8?B?emtobGpSTVdacWdPUFhDR1pIS2x5Z2hORUNtbkYwZ3VJWit2SC9GMnZkbVky?=
 =?utf-8?B?U1p0QncrdXNFekhQWk5ZMW45aWJOZmhWTVBpcUVRSllVTXhxaDRVektmaUZz?=
 =?utf-8?B?Y2swRk4zWmg3NzVpNWI3Y0dYWmhKVDJFUERoMHBRRjIveTNnc3ZwZm5IRUs0?=
 =?utf-8?B?Zmp1TjVLRTEwOXJlaWJCNjFBK2g5cjNZN1M4QnVyWnUySy91YURuQldoTDN1?=
 =?utf-8?B?MGhUZG9XRUFCSk52KzgwMzRoeXFrTDY3akNOZ0E4YjFGQ1BxUzJVZEZ5R0ZY?=
 =?utf-8?B?NDVWMWxrNFA0R3ZhUEhoVTQwbUVJbFZ0YUZqditVLzNvT2Y0bWN4K05DdEh5?=
 =?utf-8?B?THYvQ2VrRDAyT2JFeC9XQ1RNcEd1TWpiclR5Q2dreEtMTkQwMHdCSTJCYVQx?=
 =?utf-8?B?aTZVZXJTM21nbm5WM1ExN3h4M2J4S0JoSENlMFdoTllaWVNjNEY2T2VON2Jo?=
 =?utf-8?B?a2dwUGFTWU4yQ0R6YmxkS3dEMVJUOEk4bWZQOHFwRXQyeWdiRFlxWmMzeHVB?=
 =?utf-8?B?WVZYUUVXaTVEdXEzV2U5RE0xUVpsVUxRZEhkRFVPUjZueFJyZVR1dDFwbFZj?=
 =?utf-8?B?a0o4UnE0NlAra2dQL0RrU0xmenJQSEFnUmJQMGhnYzYxdlBVd3NzaGQyNEMx?=
 =?utf-8?B?SWRhNWU0aExWT1dpN21OVlFlRXE0MWVQN0M0OEZhM3Z1UXIwL2RNWFBtM2la?=
 =?utf-8?B?cHppQUtUODBSdlhDbmErbGpUZ1hJQ09lcWNGbjVLZTUxeHl6WUpjZXE2UFZF?=
 =?utf-8?B?U3FPcTc2L0VpcmNsMlB6NzJESjFzTjYrNkFHUGdNNUdrK3lCZjZ2eUNhOVBS?=
 =?utf-8?B?S1Aya05CWS9XL2hBNlRkS05VejF4aDBmc2dBbEZWRURZdjN3cHlMVTBhd2U2?=
 =?utf-8?B?ZTM4K0dXWmFDMFgxMWVoTzM2TTZObDFlSFpiaENVRUowSitLVXhvUDl4cE9s?=
 =?utf-8?B?RUJqWlB3WUdoWWRkR0c2SVlrMk94RldBa1h0SWNCOXNYQ0hEWUZGb01QK0Js?=
 =?utf-8?B?T09xN05HY3BnYkFCK1k5UzR1OG1jM2NjU3R2UVV1VzdmM0c5cE05ckpVZVlK?=
 =?utf-8?B?cExtWXU1YTVkVmtKUWNob25odmJqTVFTVm1JbGV5L2xXRW5MRVdBRWZja3dz?=
 =?utf-8?B?QW1lcTdrMGdlSExScHExMGxMTnFUQ2ZuU2JucnphVHJsak0ranlYNElETzFh?=
 =?utf-8?B?VUQ1a2NHTWdrV1hxU0xmWFlsblRXWnhDSVNkZXRXV2xQL2ZDSTlhQjR5Y0Rs?=
 =?utf-8?B?dmVQeGVhYUYwcEJoNmhXRTMySTdqR0NaV0lpaE1xN2xFM3dIU2NTYXlRZHBM?=
 =?utf-8?B?amVPUklQZjR5MVovTjVZYlhJa3dRdHZmWHNTcmc1ZWpoT0pHc3dDTHE4UXAr?=
 =?utf-8?B?WFBoMS8zVlhtbVpwQ2dJYXVsNzRId2hyei91bzZIc01vZnNBSW5kSldobm9M?=
 =?utf-8?B?Nm85bC9iUFdQN2hYZU9vdXZLT2tLaGV0MVBjWlVETHUwalNqbnJVWk1XOHM1?=
 =?utf-8?B?UmRKb1dUNTFsZURISzR0MUJoZWk0QUZidG5GbklEeVhjNzVvRm9saFh2dkZL?=
 =?utf-8?B?dFdkRzdEWDY2dkJJc29LY0hxVEVDUk4xOVZOeUlrN2tpKzdxNUNZN0pqMEJz?=
 =?utf-8?Q?2WEnxpwinN4zk34czghKSV48M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d54ad2-150f-4341-8624-08db985c0743
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6203.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:08:43.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWp9SVIhSyVvDxM0I/VCGaygzgD5gr2jwC54WvFOv43S829V3lxZmdZO2hN5ovGgZrrHawL/8rlGBy8D3XE4kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/7/2023 08:48, Yazen Ghannam wrote:
> On 8/4/2023 12:03 PM, Limonciello, Mario wrote:
>>
>>
>> On 8/3/2023 7:25 PM, Yazen Ghannam wrote:
>>> On 7/6/2023 1:13 PM, Avadhut Naik wrote:
>>>> From: Avadhut Naik <Avadhut.Naik@amd.com>
>>>>
>>>> Add the necessary support in the module for AMD's new Family 1Ah-based
>>>> models 00h-1Fh and 40h-4Fh.
>>>>
>>>
>>> The first patch in this set adds PCI IDs for models starting at 20h. And this patch adds support for models 40h-4Fh.
>>>
>>> Can you please elaborate on the discrepancy?
>>>
>>> Thanks,
>>> Yazen
>>>
>>
>> Model 40h-4fh shares some of the same design as some other platforms.
>>
>> The root port ID PCI_DEVICE_ID_AMD_19H_M60H_ROOT and DF_F3 ID PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 covers it.
> 
> That's fair. Can these details be included in the commit message?
> 
	Sure thing! Will include these details in the commit message of the first patch where PCI IDs are being defined.
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik
