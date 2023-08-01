Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5763876B9B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjHAQfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjHAQfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:35:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104141BF9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHUta2eP/MSVGtRNj3cZnkP1ujvXPQYjxrSd+LVyFwtQ1TbnlbHr3ON5LpX2eSa0PWISQF0Fm6aSYi0xuUaSNUwIQtPBiqPQVsETGYoYgGwkrYjushn4kmvKLpD9TuvnQ6A1rVOTvwdTLGfG0NOnFPy8LEjXYVYWwuWzr7/1gW9uPhw6IWkaZpiYB120AFaRK05oENSnPTJj8XKSoGn3NoQHWoYZzm6haBVHbNb1l6NHKikqcjBjdQx/YmHNBsj/YR24dMEO7jb5UsS7xXMS9WUdDhgHUKM2S/btcRZT5MuNI/77p5KuvwQ8PYuA7mW0RdYSf4jGs7cIvsA+Rv51GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnbTWhJuV8pVukOX55Fhe3/Vr6XNsuV1X/1luR5/ctQ=;
 b=Y2saa3jXzM23SOaCwtnRuUjbY0slQiGE6a3JD7g7SDD6wLMrm5GnbtNAu7CfwppFghqz0tbN4y8vrHEQFk5Rrbh0VMzIoOMufACju4reJYedzcfAZQHT4LAfkAOkp5wUR29EZ8HDNpX1ONKPodo23F/PCfz9pwwvpeu5S1V24Tqo4Jb83/sBo/4+pZ8EHKa7/yaXqrUHTQSFDEQeAvMGJNnPwOOiuy3UJlgE49cgaEEU4H1X0evZVgaUIqAM7kbpE0kZ216N0Dmq9KxDRWSfz1uR1vthRZxDFvY35x+YO1wFAl2u5xDmEW1LpZuRQQNr7mLHL4IM2vDMuu0q1WSnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnbTWhJuV8pVukOX55Fhe3/Vr6XNsuV1X/1luR5/ctQ=;
 b=CJBBvsh65Pt4t2fcPxypSCbXGsd+FiYWjm3VIeScE+vZ0e1cgztC7aYq2fIzVhL8jklOLjTkaCtiuABVch4M++cBQWA0VKwCaOm+9EV1eK5p9zhgWa2aMWNcxwaqKOhBry3xzImCrD3/IBu6+UoY6HB1OAkLquNpK8sfGoLcLzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 16:35:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 16:35:00 +0000
Message-ID: <525af2f8-f090-37be-df21-78f7d9ca48f6@amd.com>
Date:   Tue, 1 Aug 2023 11:34:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/14] x86/sev: Cache the secrets page address
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-7-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230722111909.15166-7-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: e653db3c-d906-462b-37bc-08db92ad3f9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhh7tPlF0kmGccgGCBVmdx+EiUmlQ2GKGZCb109oTRl4V8meTGzSuLkGy7MmJnPhRqEKmFYWH0QodlDEFfOmLqc6UlAa+FWIP3Vx1UOZ2HkXoGjnQX+eETd56sb3giv3yzV/1O52mE8lwqrIPvZllays/Pqz85PV4zCbwF/lhmp550gBUd0Qo4GcYbZcWorrIxhrXtoAT3Nyz/JEAua3E0LTviRT34Jd9V4A0wpNRI1KDdSh0EYv89gvHkSF0PUw+ZnwCXD9Ro8smfia53afchIz0oE5Sr0eGXnUNMOrP6felIGioBErIahVvl3Ol1ovHtqqOS1/i7Uhsdm/Qq+WpguZ9IBBp9WAR73abU6b4ntXRwMEWdcts1AqMmIEvYuG3zwAAqW1alAPuVQ+SBlzeQqSP20ovxzSYtgd4Z899VjXXJPRuLwLDEgiaTkviRlJ4OswnkiF6doa07M73udW5yEr5W5iYm7yaASedr+e0DQ12cbqgqtWOUkDPKYTezMJuFe4mlmtbPUiNdaShhej4ylHOLv4aSkx3dNAEQBZau4sasaG4uQSUh9CaqhrjgCB++t7nVZ0U/rxs+1Yh31GG0tcXlOku/8tMH6MNalNRF5TEu05N4hf4rqEEHZkC9njUk2wGajHCQGbze7ShrWFXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(38100700002)(53546011)(26005)(6506007)(186003)(83380400001)(4744005)(2906002)(2616005)(8936002)(36756003)(5660300002)(8676002)(31696002)(86362001)(478600001)(6486002)(6512007)(4326008)(316002)(66476007)(66556008)(66946007)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEZVSEhIRTB1aHprL2tZM0tUN1ZwcklTYlhrWVRjVzA0Vm9sVXFxc2Zpeklt?=
 =?utf-8?B?K1Mrdy9yNmdOd2FGMGt4ZHlKMW9SQ21Td3VXTTBscit5QndRcE9peUFvVnpH?=
 =?utf-8?B?U3RSZjI1VFhXNllhdGZpVlErQkNVR2VpZDNHM041RG1JYTdldzJWR2NpWmV6?=
 =?utf-8?B?TFhhSnFSZ09kckRHWGpHS3VyZVVKUkNqam12RXdvQW1SN25JY1REYVJEQThK?=
 =?utf-8?B?WU9xeHQ5OEozMk5QS3NycGhZYk15NmNTbjJnMDIwcEtERExueUhCckdzNFNj?=
 =?utf-8?B?VTI0U0l1MXVJVjRxZDRyODgvQWtJZk5lRVkwbVg4V01jTWNXZzdBN2x1bXdj?=
 =?utf-8?B?QjdTUUFkQnRRc2w1NUFnTkVINmN0ZjJVNnN2dG1uMDl0Yk1RaXBPVlEvdUpZ?=
 =?utf-8?B?cmI5VjNiN0xKN2RRbDBCSGx1RVlVbWZNV01NRW41UnFHYTlYb0xiK3hieHlo?=
 =?utf-8?B?OFJOdUlDbWNoWnRHZzFwc0ttaFdMd3NrNFpFaVoxQmptM1NjMXVPcnM0cTNn?=
 =?utf-8?B?TVZkcTdkU0VyYXkyamtFM1lWdXZYclROYmtWTytnUDBDQVNQQVdKY0xsSTIr?=
 =?utf-8?B?c0swQStEMnJTYXkycUlVSmpxYytvdHZBUjFncGZhSDBNazNRSzBMM1l2czQy?=
 =?utf-8?B?SWVibjQ5bElKZGJNYS9PemRabkhoSnJDWlg0Z2VYbjBJcnhhVndpeHBtd1A3?=
 =?utf-8?B?Y2d1bHY2eHlucHlYVTJvMUx1UHh2Tnh1OWFCbnhnUjVrdUl2MlJ1dnY0Z2c3?=
 =?utf-8?B?clNMNDhKVEx1U0xlU2NDd1YrU1kxVDFQenNENG1WanBHcUNQYThaeDdVTHBu?=
 =?utf-8?B?UDdaVm42QVFjNVdCUnlDNkFGVmQzL1dvT2Q1UVZnSzEreUVQY2d2T2l1RUxO?=
 =?utf-8?B?Um1qOUFQOXYyaHl2eXVmd3dQNmNuQTQvemhpQ3N0WG5FUGo3VEpLZDF2QnQx?=
 =?utf-8?B?L3prd3hLTjBmbnR3UllSeWVlQzFITG9ualBZQS9pcTZMaGRqWCttL0dxOXBu?=
 =?utf-8?B?TW5aUW1yQ2dnNUxWclJCL1BYRW45akl1Mjh5czJGVmxwWm84bXRPakJidUxK?=
 =?utf-8?B?TmF4czBSV2pSNUsvR25IaWVUZzYyN0pCaTVCY3gySGViNGZJQzRRNXFZdkhx?=
 =?utf-8?B?aURqZ3kxQ2orSlFzZmRSM2NobjUxWkp0V3cyYXFhV0lYY3V1ampadjRXT2sz?=
 =?utf-8?B?UldaWWlmSXdsc0JHbUEyZU5PRDlrd3ZDbTBwUFVONlZoenhCOE84YTZod0Vp?=
 =?utf-8?B?ajNRMmt0ZjFvTnU4TVNOYVMrMHFKeFRnSnpjbXp4cUNKS1kvQ0lmOWRJWjhm?=
 =?utf-8?B?eEg5dzVnV01zL1JYY01vazJuV3lDWEJBWmhNa3A0SGFjeTdtOHJzamVxdzlQ?=
 =?utf-8?B?NG52cWUwejdFalBiZHpEbEFnYU4yeEhjTnRqd0w1d0J2WmhwYmk3K2o5ajFJ?=
 =?utf-8?B?SXp3dW80ZTZ2U0VuSWk1NVhybmEyaHZ6YUs1cUQrMkJOOUtScGp5UGNaSWFW?=
 =?utf-8?B?eDhaUG1CbXBKYmpYUmU1S3JNcXFpWjlwWGs1N1hvc0NWWFEzV0NBTElJUWdQ?=
 =?utf-8?B?VURnRXNHSEJUTGNPWHI3TEFUaDJDcXB1bVhxYnFUNjNIRjZKY2d2NmtQS0wv?=
 =?utf-8?B?Z3pWREFjNXBpOW1aRlNMOFZiWWRTdW5KOXJVK2xzYXU2ZllZMmtTenBJMXJR?=
 =?utf-8?B?U0dKOHZZMDhlRlRxWEpPOXNQWDhSQlZ4VXpzdVQ5YmZUUnNqR3J0MlFvd2Qw?=
 =?utf-8?B?dXRkcWFySGo0L1ppb3RrUU5WZHJSOGhmcHI2dWIwbms4VXZmWGpCaVpjYW1j?=
 =?utf-8?B?dHBwSEJqTUFodXNLSWN0MFVLdWtzV3F1dWtmTld2YlBRSkFjNEdrRFRjZ2sv?=
 =?utf-8?B?Z2ZVU3hrKzhPdzJDQzdZWkJuaWlTK3gveitNT3RZdkxibjhsSUNjN0NxRDBT?=
 =?utf-8?B?bUZkNTM2S282SUQrRUc3S3dqZjNmMDdqRnpNU09SQ0VMQ1VJZnp4TUhFZXpM?=
 =?utf-8?B?aHZmWE1IeUdUbDRqL2xGYjg3RWtnTTNjZFpSTWNVV3Y5L2tUd0RtVWhaU01K?=
 =?utf-8?B?dFkxZ2duKy9QenA1cWRtV0xQZ3BWTmgyU0ppY3NEYWw2NmNycmM2ZGsxYlNP?=
 =?utf-8?Q?zQLGKIuHGjO0feUo8XPBwf4U8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e653db3c-d906-462b-37bc-08db92ad3f9a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 16:34:59.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/fBxr1TNyrmwqGQvkvEMLVY+62wvq1TD0iIWJHWbCsGRJaKe+YVprOan24p39c4EPqSL3Yce2Wih49r3Xj4yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/23 06:19, Nikunj A Dadhania wrote:
> Save the secrets page address during snp_init() from the CC blob. Use
> secrets_pa instead of calling get_secrets_page() that remaps the CC
> blob for getting the secrets page every time.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   arch/x86/kernel/sev.c | 52 +++++++++++++------------------------------
>   1 file changed, 16 insertions(+), 36 deletions(-)
> 
