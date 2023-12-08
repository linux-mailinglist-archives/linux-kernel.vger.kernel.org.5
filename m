Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481BD80ABFC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574574AbjLHSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjLHSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:22:29 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0090;
        Fri,  8 Dec 2023 10:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGeOCVqat7p0Q6VmBYJN80BEmYjfE+rUCSWkXQBpOxczzMPQtPq2HCotCBt+ean0b9SVy2l2V//deFZs04B7C4wtbwFxlDpCkrbgVjBm2zdhESxuGYy91D5OAM6Qf+JoPH047dSu2Uxm97V6DwGMvDLaNSqSMvRGoY9h71cYwp2PotXTjM6VCu8r0679PoNhKIdAfBhJsQQYqAIGqh2tA+zdQcOR5AfVvUgpIsJaVYzXgFUuHruOrE3ZUENhPm1cKhNb6pZXlr1NFHj28IoM2iFAy0ou1la4kezeFaBbXxPl8rOTvRxkUQHBMUnL0J6f3dFRGC8K3a+NHWG5dtE3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9Whj5COiQFoeSINVnrPGl6eZGN0zGbvAadKVapN3AA=;
 b=bYNlcLQrDo/Tkpwft9nkXYCvGG1WH2xsIsj7JF5isZu0C26w/aYD70EkTbCRghJ4JKqfEpAaHMj9hCEkzeoDXd+alPP+HWVEK1TeRuixjYAEgeJIro9D7kkdawKppVOeQ7tTfFw475sS0FTH9gXz3Aiq2JMMsquL3++ywdNXGfD4MmWiIC8LY34E+dC6xBYcSObf/hiaTufC6GmdqEAjdxYyoEp4lqUdWjjueZ9dPpo+j7Oo12Pu4p9kTfGGlCHOzcOwh+csAHzdlJytNPmctY/3CNLGQyZvoG/Cx5KJEXj/wULibjwJ5dASVwnt6dSCvvioZJ0hyVQIAO1Eh0UU9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9Whj5COiQFoeSINVnrPGl6eZGN0zGbvAadKVapN3AA=;
 b=nJ9vp763cKUwq58Zb7DGKeBBt8+LNMMXFYX71M3qluvt+ZbrIMYnkpap8T8cA4eLzkyov6nHbaKYetHtACjSiHO3BwVVhZbam2i/iZetBxBYzSHeRctr3APk9UM9+diHzoOcYzlpSEEDTneQ7wx3+tJFF8ZkvFlHQ/45Ds3HU/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 18:22:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:22:27 +0000
Message-ID: <0f1b9e43-61be-40a0-881d-69b0164b1926@amd.com>
Date:   Fri, 8 Dec 2023 12:22:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Input: i8042: Add a quirk for Framework 16" laptop
Content-Language: en-US
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231206212140.7458-1-mario.limonciello@amd.com>
 <20231206212140.7458-2-mario.limonciello@amd.com>
 <ZXNY8a_Zja9rSupQ@google.com> <87y1e4o9ce.fsf@nvidia.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87y1e4o9ce.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0036.namprd05.prod.outlook.com
 (2603:10b6:803:40::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: de55c0f5-330c-4e3b-e6e6-08dbf81aa224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fz0yRZbRmXuiWw1rPtiv1q8lGG6BPMJYY+Lg/h1kQtLWlPtodvtzyh+vtJq4wOONvtbLMW/ZjCvHabOn/Wie0VBS6l+m/I3w2pRIF6fobuZXof7IotiIRurlc+GaDuYqA/+4ddrRHRkkV+lUGBOg5zWlO5A9ZE1K8HXu/jwRhAAO0zW78wMeW4DspRE/PMhbqAScBzPjpag88EWR2Liw47tfomMlH/A3mE/UVt1F6Ea+gaIrMGVGdhuBrkdNdQPVTObJ42MFpZeLj0plujUGhE/dh08ibItwcLha3QXlida+a0VOKsuNfG8t04b9VfXbFGVQh5Oc5DsjBUInLqKEADHNV09c/j05hQKNOMLSdi/4DYeyBzYXoFcAlhKPDkYH5JWTAkXkAdcGLT5C+nsNooVm+qhdUpf6prQ2YIDWUOUj9QGoJz9jAVqUJNtG+KXWZiZIEPz9GLW+bhcZLLZRMSpofNuvkZm8/zbwq/YOjwUnDXxzVujuuUumy8WjcXZqscBcY/yFg00ipFpSkTiZtBcIDDOxN+ZKQ+sPS8/iKKXwr/cN5OxoE3oux9McOr702Q/IbQrW28RjBnmgeTk8/3NyjyG4kannaFjct0G0d4fgeTXHnH/gtugJnRheDAJUQvW/FHWzJyrs7Ul2sJUgZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(53546011)(6512007)(6486002)(26005)(966005)(2616005)(478600001)(6506007)(83380400001)(2906002)(44832011)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEE5Z2FQYzJ2R3lBcXJ1NW5MTEt4NXlXNTgzeHZIUUd1VGp1aXVsU3FaTW83?=
 =?utf-8?B?YmxmbWdKMkVQbkV6ekJDRExuYmFCdUQveXh2ZWZjUHh3TGJqU2Q4ODhJc2Jj?=
 =?utf-8?B?TFM2YmRVUlRhaWJXcktabGRvakdCVElmOFUvK0pXYXdzN1U1Um9NMUpxWHkz?=
 =?utf-8?B?ekNyR1BVano5dzBUSndqY3ZUd3BNM3d4ZnFRbkl5cGZRZGJnMTZMTWw3Wlp0?=
 =?utf-8?B?SUJRbTdxMzBFSloyWTZrM2d2VnZjK2QvWFJrSm9sU3ZGZ0R1VjlDcEo5bUNy?=
 =?utf-8?B?Z0RnWHFISGlkcnd6M1Y4cHFjM1B4S1d3dFBIS2hLZVRRS0FVZmxOQUdjRTA5?=
 =?utf-8?B?bThOaWxBcmwxR2k3NWgyTlRqbXhCa1FOTlllM0VpNitKUzZ5empHaVAvZGdJ?=
 =?utf-8?B?UWFZNTdpUmVwd201ZTZTY1Jubko3QldqVFdoSEtiWnJzMHE0V1U0VCszYWNF?=
 =?utf-8?B?WVM1MWc2YVFYS1UzZ2VUUXhNZ211L0phMmF6UDBnMlpXZFVXcngxaWNFcm9M?=
 =?utf-8?B?RnlMcXVuZVN0NjZLN2pBRDdjMW5Rd2FoY083ODM3YjFNbEFkbFpQQnlhekZQ?=
 =?utf-8?B?M1ducGFKOFJnUEJWWHZMdk12L25wbStxSUk3WE5LcmVGNmN6c0VKaVdqN1hE?=
 =?utf-8?B?K0x2QmQ3QUFZREdzbVRFSDlSNExUQzJxeGc3K2xJdTByM0VRckVwNm1kTlZh?=
 =?utf-8?B?KzBWZE5SWXJUOEFZTGlOWFNQTloyRmRydUc0dUozRWtPODR0dXh0UjRtY3c3?=
 =?utf-8?B?ZzdPSDVNclNobW8zbitIQnpSRS9sV1E0ZnZMSVhlemlMNWlQdnhGek5EUm9Z?=
 =?utf-8?B?amxCU0x4WDR4WldNdlV3RTA5bFFuZHhBR25vaE4vNHpKeWJYTTlGbERFUktN?=
 =?utf-8?B?dGc4Q3FlV2t2T3ZTaEdjR2VIT2lQVk1FTEVFZE9xa2dtRy9EZVFaOGNRaEM2?=
 =?utf-8?B?S2c2TjEraFh4bm1VODhrUzNqUy9PVGN1eUowTHBNeXhpV04ycy8wUDYwQXl2?=
 =?utf-8?B?NlJtaThRK0lHVWhQY0lvdEY4d3FFTGpIazg3MW00am95TmFJY0V5RExOWUkr?=
 =?utf-8?B?QlhLcUdBc0dDSGVUU2tBN1dCZjVzcmM3N2VUVkN3TWJlbkQ3RUZrZGZQWVBL?=
 =?utf-8?B?OFh0OFM0RHFqTkordG1GZ1RZMzZobElNbjFVYnFhV0wvU294a2ZuMU1BZlZX?=
 =?utf-8?B?cE1hUXVJNEtBYjdsRVBsVmtYZS9jSVZiNENLRkxvajRlOHpHV3hiSDhTNDAv?=
 =?utf-8?B?Z1p1NXZjeVVGRDVUR2VOK2tlTUVEOGFpUmdZUTg0SmlwMGk2NnBBbXBGcVBs?=
 =?utf-8?B?TzN3YTJEU3NESjlQNE1Oc0VNMDNlMFU3SEpJay96bzl3djZHWlFZR1prak4x?=
 =?utf-8?B?TzlSK3ZncWh3Y3gvWW5XMGV1aUVOT1Y3L2RmditMQWtQOFNwdmJhclNHVjZX?=
 =?utf-8?B?aW51UEVkUlJpM0Nia2xyWEhMeVZVSzRHWlB3VGhkcVVabHdJMEkxZW9od2Zv?=
 =?utf-8?B?ZDZyVDFmWklNekFtT25IWHdacSt5Nk5vZllVRm9DVDFWaVZGS2NZSVI1V2VB?=
 =?utf-8?B?UnNVWFlBNDh6SXlsamZOMUlXdmR5ajN1RHRsVnlnK05kSkEyOHRTY3VJNTk2?=
 =?utf-8?B?U3crYzhqSVoxTmNRWGdKVXdXOVJVRWFjODhiaTFGejVEbVh5eXVHSHF0WlhJ?=
 =?utf-8?B?cXUzVXJjSTRVTDVxZ3hMUE1CT3RQM1Bra0xKZXpQQi95dW50aisrdll3Nkdo?=
 =?utf-8?B?NXN6T0c1MFVOcU1NTUYzSGdUdnBNQ2VtTE9xTTZFS3BzMVA4WlJSaTJyZmVi?=
 =?utf-8?B?emxwNGJBNkdFVHBYNHh3Wk5PQ2srT0VkSVZJb0UzUmNGMmwybGtXK3RiSlkx?=
 =?utf-8?B?VTAwYnRZamdmREttNzhRSVNHTTJjVDVkaHkzRExkWm56b1VqOW9FREcyRzZU?=
 =?utf-8?B?Wkk1eDlod2FnajZwY05qc2RpYmthREhhMUZMU0gyeXpQc29qRVZCV3dzTEY0?=
 =?utf-8?B?NVVGY3EvbHdzRjhpT1R5YzFpTzZKcTJuTlhPVTcvSjZEVFJBQzRPeDdDUG53?=
 =?utf-8?B?UEd5cytJVS9VWjlxb0lZdWdBVS9rMWFLQjcrbGNEWUVIM09sRWV5dTlLdlEy?=
 =?utf-8?Q?jgotWLIIYJR1yt5uQcjEZAqrB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de55c0f5-330c-4e3b-e6e6-08dbf81aa224
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:22:27.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efJMXoLV8eAM7ENV2UkwrvH7+KhZ07j255N+q4HCs1vZT/8YDckEfz216z3uvbMPnj7ZGoZFb/SGje5iLoS0LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2023 12:08, Rahul Rameshbabu wrote:
> On Fri, 08 Dec, 2023 17:57:05 +0000 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>> On Wed, Dec 06, 2023 at 03:21:40PM -0600, Mario Limonciello wrote:
>>> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
>>> following messages are emitted:
>>>
>>> i8042: PNP: No PS/2 controller found.
>>> i8042: PNP: Probing ports directly.
>>> i8042: Can't read CTR while initializing i8042
>>> i8042: probe of i8042 failed with error -5
>>>
>>> There are no PNP devices as those listed in `pnp_kbd_devids` but
>>> i8042_pnp_init() ignores this and still runs and will continue to
>>> try to probe.
>>>
>>> As there is no PS/2 keyboard or mouse in this laptop, set a quirk
>>> to avoid this behavior.
>>
>> I believe the proper fix for this is for the firmware not report i8042
>> as present by properly setting up FADT. Please take a look at
>> arch/x86/kernel/acpi/boot.c::acpi_parse_fadt() and how it sets flag
>> X86_LEGACY_I8042_FIRMWARE_ABSENT.
> 
> This is along the lines of a point I brought up in the v1 of this patch.
> 
>    https://lore.kernel.org/linux-input/87v89bgl7a.fsf@nvidia.com/
> 
> This means that Framework as a manufacturer will need to provide the
> appropriate fix for what's advertised over ACPI by the device. I think
> that makes sense instead of creating quirk combinations to avoid
> resolving the issue at the ACPI level. I guess the only de-merit is that
> means folks need to depend on vendors with no way to suppress this if a
> vendor does not correct set up FADT.

Got it, thanks guys.  I'll raise this with them.

> 
>>
>> It will still say "PNP: No PS/2 controller found" which is an
>> "informational" message, but should not try to probe ports directly and
>> report errors.
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

