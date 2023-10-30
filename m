Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB84E7DBD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJ3QSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjJ3QSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:18:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E5CC;
        Mon, 30 Oct 2023 09:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNKMaqqkHgtOOumkxIY9hN3Xx/gfSRbH39BAWD5DzNPFc7Dmz176GMtXJdu65lZxkMVpbtvAmG6DxY0+EKHs0CG42FGtnJamDadZ3yQIWe0RggDqUujIsGa/TcSXCC/acdgdL/FvlF2HVVsfVWYKZ2EH2GEUt0STou4G/oqnKcA9PldLnFG65Vr9zy6+S2I/w69ZiWqEhOPvn6EWkDuR0u2D0aPpomTt4VIeo95rSXKeY1+w4FfMH5Q7dbL+1lsPVm0O8SBboBZyG1uAhQ52NxRBGu/Kewj0jMzn2b8cYes+u7OftU4i9U9yhtqr3eIBa5d7MwDBcpU4M9G68hsz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N61C/TFUXYoqDXJY7DKkGSYstSr3HQIOA5kzey45l9s=;
 b=VRns7HyLZpSEIf2MPvTl84cnGvfnlfhn+tqnmhlyZN3p9hB2b/th7KyHIfYAkFAkiwUgQJDxkYmAxQZHsHVoiE8NLzVClYzdTajUf44cJmb8fVVBF6TNm/CZnSfYlrJkqRg8WybywYnjy9ADOQmOgM5TUW5e8Z6dfb4Fz74P/pij5atNg4Bi2/Y+vdx8pH5kyCTT0pZv5YUZUibq3PfCHTPhtTRgl1gdJnt0LmjvbiBMuH4E+p6JElEwFT+WBKFv+GSbX9KyNByoiYJ4F8aYHQMl1lRBzFitrrGxucfL3ccYZzXDXXsbSHRFtFbUXK+X4YZD251MS+ivDidb5l0M0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N61C/TFUXYoqDXJY7DKkGSYstSr3HQIOA5kzey45l9s=;
 b=pmAxqae1wXjQTP7QrGVJnKPqpD/yHm9ctxQQlff6sFZwbIxuBX0g1Ow9xcSc++kpooXWwtHFrUlN25m5wMPmPUsMOROseLJTWCoLHObHF0ymisbv37/oJVmHvM2Q3D2gU/HCv1CpEZs2Bd2HDuge5xYYTSd75Zv5mRhT7akNDss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 16:17:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 16:17:55 +0000
Message-ID: <bd018335-3b2c-4233-aae3-407e239fd393@amd.com>
Date:   Mon, 30 Oct 2023 11:17:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading
 dram size
To:     Mark Hasemeyer <markhas@chromium.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
References: <20231027212916.1035991-1-markhas@chromium.org>
 <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com>
 <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0173.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1b027a-abae-48a3-0dd4-08dbd963c609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0AjzxUn/FtCXGKapvmifgqx0IVqTJ/V2MNug2XzCVRXiKyjdwjNI4IMFbg3s6VX/MfsDM4nc29urGWbkNQIJl3BqcfygGj6vyl2bi42SYw+3BytWJqFt7nyjZXCrZwvq/jMiqw21hg9W296xgyw1sv767qbjDswihip7IIpEllLCiDvNgreEm56BncBOQvDSsakWXeaYI5JaHQJHV2s5g/kpLVKnhc7bP3ik5MvT71aMgMk8+zHn6WkuT98ymQDc7aBieb/BsLC0rfCEBl1w7Oo6Smjx1lli9/TYROvXHQ+W4c/Tj+Oxoo4YceoaU2Ps3PJR7Vv2hN2A+heZndE5MHJkwAPaB2lOVKrxYRWI/0gZfdt6c6tq8M7wFsleZ8oa7LrY4v8vbpGmttPcaqt83b+FH4oeSeNX+fiqJWToy4NayjoIgEHlV7VhMERXatcDQ3KpsjLPrkK/fFVGslkqhbPE5QIT+Y5AAx5aD72LJQjYXeS4fiBM+h44edvFH+74E79TJ6VYqwiH5ASOgicHTvwSTpK/n44R98gpZzeSd4HW9ooKbmX66ABBF8+OV2BOS7+E4CvR9lQoet/9lN2i0UH2DuqownZSK21NAugOMVpyHtCL3ml3wjpHJjjv4tX08RWuQZMO7XDjMzIa1FzgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(38100700002)(2906002)(66556008)(6666004)(66476007)(54906003)(66946007)(316002)(6506007)(53546011)(966005)(6512007)(6486002)(478600001)(83380400001)(110136005)(2616005)(26005)(41300700001)(5660300002)(44832011)(8936002)(8676002)(4326008)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R25teGc4SzJHNVhNZDdxbXByckJNbVdMd2RoQUExUnp4NGZzdlFCb2FMWWVm?=
 =?utf-8?B?UG8vU3VnbkFkNkJycGtEektFOGhmZVNXQllGQ0NFcXNhVE0wSTZKWFB4RW5C?=
 =?utf-8?B?eDdnT3pCZzJ3Vk5GbmtjQkx4bWlUNXE5c3pRYm16TW9yb3VXSFNWaTN1SUgw?=
 =?utf-8?B?aWYrTzNtdjNhd2Uwc25jY1Z5TEVjc1NRR2RPTnBmNE56a2dwZmxuTGltaDNP?=
 =?utf-8?B?YS9URWVocFZ6L0pVSTJYRlIzREVlODBXYmdyY3lrODdkVkdPQzdRNENBeHl5?=
 =?utf-8?B?elJ4bk5OU3JqVEtrUTNGT0JwMFJGWU00Sm5ZdER5YWZDNGw2TGg3WDdIR0RQ?=
 =?utf-8?B?V0FMdmxQbkhxaGhmMU82N2V5ZGtpeVNOODlOOVQ5UHpKeS9CS3V6N0pvL29C?=
 =?utf-8?B?S24xa2IyM0llQ2ZhTWFGQWVONHNobnNYWjIzdXk0dk9lSzlUN1pUQUtOSnUv?=
 =?utf-8?B?a0ZGQXYwUDRjRWhyT0pJK00rMmR0c0IrUUtwbDVUb1cyT3NIRWhDWlQyeXlQ?=
 =?utf-8?B?bGdnMWlKYThrdUY4OVl1R1FaOG9Tcy9HYzBkL3pCbjZJQzFZVEFRL1pOZG5P?=
 =?utf-8?B?c3lCd1E5SDdRYVRiRFhFVFM2QytGOVcyUFE5RzRJc2FZSkdOS3p4TG1mazIx?=
 =?utf-8?B?TytYVSs4LzdoeFFFeDZnYVdUUzAvdU82TEhpUWRybUJYYkFZMHhZWXlwSzRF?=
 =?utf-8?B?bVQwUTVFMTJjKzNTSDJZNmY0RmVBSGMvc0RjTUxEU3MzSU41QzdDMTNjK2NP?=
 =?utf-8?B?YURNK3NBelpqNmh1MUl1TklvOFRqU293L04rTHR0eTJGVnQ4WW0xL3lndWkv?=
 =?utf-8?B?ZzhVUzhSdlpySU50Sm15TDZYbnJIS094Z0JPWjlJZDUxYkZ4clpFbEFNUFZ6?=
 =?utf-8?B?SXQrQ1BRdHNpa2hRUm1kREFkeE5jU2pYZTFhNnRyYVZJdlJpQXhRajZGblBL?=
 =?utf-8?B?bUhqblVReDVicVdBWkRIakxidVZxRUZxZTZ3aGZPUFpzYWVJaXdnSUY4bitH?=
 =?utf-8?B?ZmYxa29iT0lTRDNVbm9UMCtoQjlNK2tjVGZuWDRpSlAxYVFIU3pLQlk3eGpV?=
 =?utf-8?B?M0xORDlMT3QwdTRFTzBGR3lBVkUxajd0d2h3QW5KL01nbURwaFJUOXFhTzhp?=
 =?utf-8?B?clBtN0JDRXYvakZLQzRvdWlJSkgwb3NiL1JVa2grMExrNzluZDJyMytrT1JW?=
 =?utf-8?B?N1BodEd5Sk5KbElHNWxLdTRwQ1RRTzNIUWRaMzJvVkdaRG4wYlBqT3JRSFRF?=
 =?utf-8?B?NzI3amxNTzkzbEVmOS96YkcrdTV0cXVoa1BSNjlmYVZpeXFLMjdXOFlxTFp6?=
 =?utf-8?B?c0pRTHNWb1puY1BCY2tvOGFENXRkWW5NWXlGdW5tQTBRbndKUjhyTXo3VXhR?=
 =?utf-8?B?M3VnejlwUzk4bldBS0IxNTd2VnpmcUxRWkdIdEptendIWDNrTERvT2dZUUtF?=
 =?utf-8?B?ajZ0NU1sd21YMGdYM0NLdEZ0c0ZURGtrYnlyWUpyY21FaGYzZkpJUWY2Snly?=
 =?utf-8?B?MnVHWlo4UE1FNnhUR2JzbHVRL3YrWXg5SEtlMVYvTklFVTJFWmpEMFNJdXN5?=
 =?utf-8?B?eW8wZC9yU2QwNW9MSkZqZGRMbCtTTml5QTlwMi9hUmhwQ2FwbzAxc2l4eC9u?=
 =?utf-8?B?NnJHdXoyTDFDM1RSWkNBT2poZkIzYlc2ZURVTkxKZzhXNURtRkZHQUg3YVJo?=
 =?utf-8?B?YkZhb2xLOGh1RlBTRURwVWxkNGsrdmxqT3grSnZ0VE1sZVhLVU1BNEloYnAv?=
 =?utf-8?B?L1N2YlJWRm9UaUY1MElkUXAwL0dzRzJhZk5jcGlLZUtFckd5L2hYMjUvM3ph?=
 =?utf-8?B?RFdhVTVXOEkvL0tadnp5Ukl4YXFtTmlZSkhDZzlNUy9jWmFzNlp2Z1k5N3pq?=
 =?utf-8?B?cVYzR09wMHl6blRzWlVJbVdFTXVSRGsxK1pPUHlXbCtlYUZDTUtNUzhVUk9h?=
 =?utf-8?B?TFlvUnk4YWpZM21mdFkybk5pNTZiRTNvd010WEYvQlVIaFdTZmhsNEZPM1ZL?=
 =?utf-8?B?VWtMeXg2NmNVMDBLekdQckpMdHdZd2ZhdTZyUVBRSkt6eXhOZE1RTkZ5NVhE?=
 =?utf-8?B?emMzZTlxRkM3R3YrUnQ1S1pIYzM2Si9NdkRLbFhRMGt1ajdtVnJPbkdCenNk?=
 =?utf-8?Q?CB7lA5WRSb3Bq+htqOHtm9qv2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1b027a-abae-48a3-0dd4-08dbd963c609
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:17:55.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frH6f6cCwGpdciPRrasLCHP4lH2laBSdYUWfId6SW5UL5bOpoVaXZwIfEWTX+jkIUKtgjYK0IRmn5dYKEgtIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2023 11:09, Mark Hasemeyer wrote:
>> Hi,
>>
>> Thank you for your patch. This has already come up but no acceptable patch
>> has emerged since. Please see this thread for what needs to be done if you
>> want to provide one (or maybe Shyam already has one which has just not
>> been sent out yet):
>>
>> https://lore.kernel.org/platform-driver-x86/3b224c62-a1d8-41bd-aced-5825f5f20e66@amd.com/
>>
>> (Since this dram size is on an init path that always needs SMU version,
>> the SMU version can just be called by the init unconditonally rather than
>> adding more of this lazy initialization everywhere).
> 
> Thanks for pointing me to that thread. I think Shyam/AMD can come up
> with a better long term solution, but it may be worth pushing this
> patch through for a couple reasons:
> 1. Probing of the driver currently fails on STB enabled systems with a
> Mendocino SoC. A slower boot time is better than the driver failing to
> load IMO.
> 2. This patch only affects Mendocino SoCs, and was a suggested
> solution from Mario in the thread you mentioned.
> 
> That said, I can also just disable STB for now...

It's debugfs.  The vast majority of people won't need to access it even 
if STB is turned on by default.  It should only really be needed in 
error cases.

So how about if the STB init is pushed into the lazy init path as well? 
You can make the files at probe, and then check in their first access if 
init was done.
