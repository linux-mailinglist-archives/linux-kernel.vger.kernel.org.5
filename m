Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5787DA148
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjJ0T3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjJ0T3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:29:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3AE5;
        Fri, 27 Oct 2023 12:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1X9hoisDyGuKMd1jesGW8vcnMJ7o/s/nAzH2nxZ0GKVQ8Dsd6J1x9JZWsL+krV8HZ9UodlKfqpiIs3NavhEOnJD6e+keubDM6VdYlpkOZiGMu74mof+oNjfWr+5X4RT5m6NJZVL/KQHbvoZ+7+d800dyggMihlAsQULC7xR52KW9Sj7AMOA7supAN/AoYJHuMkc5fcqFGXP3WRSdN7A2XgfdpG4iQiGdWFXUrolAXgp8ROxSqcagh54xXbzrk++467w2ys1DRMDdtqLFWiehkRddoY0Nw3+eG3g3XRw0XETnNnLPq90/uNTPOBSqHq7pXK2fUJVFoDhKbhfzVlnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoVizyMtY2Ru5f5wUScmsX3uS1X1zDrwbb4DoOMZnw0=;
 b=hf4kgwznm5iDkjuU9wysfQrA2L1iA95ZZIPkEwgsnqkymhPf1LmnyRTkftioxLamQI5VD8YyE6xGA51rEKA7tNJZaNS7L3lRRCvCdqtGtU8qReNVqp1NhbVDZ85UeBOQg6j6FTSDVjuWG05aEN8hZCDX4LseuW/b8Jl2UqCFpDucK/WExSsaWZzmSS2m8OPGH/T2ODgkQ8580JsJ0HkObUhmVJJMhnewoohk9C+CrclPej4dGIMmByhNBV4W+XK7upr8F+6hZ9MHuNemzQi3S0IzKSTq2GGtbTCf2pQEsv836FSTSiF31QUPjyl7/8/2zm0RxLrGllAkoBb7GuJ0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoVizyMtY2Ru5f5wUScmsX3uS1X1zDrwbb4DoOMZnw0=;
 b=T2GoiDfUR6VojzxkS83NIyOm+gTA3SUzpxy3RhWLESKxKvuVfT2ElGohMU53HN6ak0ccafELY2G99qxbBq5izwGA8LnrmOKyu9SCbr0gG7LpWiQi3XBRiA0RvBJTj9GLpHDtPpkFpTF8aGH6ZNom6z3ujTXzs2X+Al7CFdky8nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Fri, 27 Oct
 2023 19:29:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 19:29:28 +0000
Message-ID: <de56ddad-ee57-4ff0-b384-522c05e88c91@amd.com>
Date:   Fri, 27 Oct 2023 14:29:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fixes for s3 with parallel bootup
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
References: <20231026170330.4657-1-mario.limonciello@amd.com>
 <87zg0327i4.ffs@tglx>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87zg0327i4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:5:40::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6247f3-c09b-454d-9ae7-08dbd723091a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgnB5Id12XBw9iRaNkPZQe0dbZu28flyG5wWPZgB017MH+blTSHQscbf4rEnidgEdm2Mt1iKsgTpyvJAaftLJVtAWP4huROBn/rmP5uZXGRE8Av2XL+gccqLWgs7/aBniL/TliPU+E425KwkYpnmWYrQengKliNGA3diK/ZXfKzme3rlmW0wIzHqrq7lMMkIsfvUqwFYsp1jl2BDoCZjGtQRBN27skTxMbDHP6QGDB+oZZ/Sgqncl6sv5URGPDDMyUrjGmBqiaUXH8frw/D89TswnlFQxV1eM2+WblVZyjd73ttWd28rvmGnX5IVxUzBVqZewdENu5f6sjpReu1qxBfI7PwAw7EqbUJnlmhyYBx6UI3bYG4ArNEuMSZiZCfupcqV/5ILsQ8+sDcwaWyDMSiBtnLi6JggO5GLN9WW7aYWGEWwNXCKFooFsu4VtcXEoPqKnvY+1zUwAcvcV8JbH+mIiGNLaxrapBGeiTDpAR8xUuxoSDQVkfb5JuboV/LtlH3Fnjkri/a5HHY3YghHEMGF/C0mN5yCRk3SpcOMI8Yj01B64BjHOEFJ+z+AgKLF5ZLXw09B3ZxTzvq3xP5H+nuRcFhJhILGcAA7cdhm9fJMvP8InjB6tb3JrlXak4TXzMz5NYgDxtp30jT0Bhoe3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(44832011)(8676002)(2906002)(41300700001)(4326008)(4744005)(7416002)(5660300002)(6486002)(26005)(2616005)(6666004)(36756003)(53546011)(6512007)(6506007)(38100700002)(31686004)(83380400001)(66946007)(31696002)(54906003)(316002)(110136005)(66476007)(86362001)(66556008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXE1RGRmaXB0eERRWEU0djhiL3JMRWFXV09GLzlzSUwzMS9uWDhuVkNOTWV1?=
 =?utf-8?B?U1pXT0tVd2dJaW00aFZsQmpNbnJBQTcxUUIwNGRuMVJmYTR0UkZXMkhwT0FY?=
 =?utf-8?B?V1E2UmxhOEFKQkdoOEd5aU14U2M4Z05GZmNvZlAzMEJWWkxwdTBQYjRYWDQ3?=
 =?utf-8?B?Q0ZTRUlBS0VSdFoxbkltZkhPL2VTYnJYdUo0dHA2dElvQS8wR1FicHBHNXE4?=
 =?utf-8?B?Y1hQdWhFS0ZjMTZHT3VDYWtRVFQ5bFVQRm5nR2I0dm9yeUxRbDZFYWdad3pw?=
 =?utf-8?B?MGlZQ01pWFpDeUJ2MFhkbTIxczlpL05zSzNGblo3d0dFYXpQTEdmNFhJSzdI?=
 =?utf-8?B?QnVHYlErMUFrRDJZWFZoOG1YVkUwQ2VtMVlYUEo5d2NkZXBUYzl4NlA2dVFD?=
 =?utf-8?B?QUlqcDQzOVdCUXY1T2pHRWhzeUZZMXpSeWwyS1lMYnJLbEN2TGJJaEpJYTdB?=
 =?utf-8?B?T1k3Z2I1Yko1NWlZdnVxa3ZkZUhFNHNGcFFHTHlhU1ROd3NMMlAxV2dHQnN2?=
 =?utf-8?B?OVplU1FRaEpQeE5mMC84S293YUZLN1l4SEIxYjAycjJjblZJNDB3VG9hVWJT?=
 =?utf-8?B?WkZyc2RTbjdBaUdvQzBqdms0SUR4R29oakkwVEVxNXQyVFJWSmNMc1J3b2Vu?=
 =?utf-8?B?TXJpSGcwWkRkSjZZODNhKzZ0OThCNlRIdy92cURiMndYL3J2b0pXU3pLUXBV?=
 =?utf-8?B?Y0czY1RkUUJEQzVKMTJmZm1YU0doWXBwQkdiTWh4QktsQnVTWnNub3Z6YjZj?=
 =?utf-8?B?NmpObFZDVVRaVW8zcUNxQUVQWVZqYm1tOXpwR2t1SU9vdFlvUDM2NFNUUDNm?=
 =?utf-8?B?LzBlVmd5MXFMcXZ3TUx3TTF2ZFovRE5PSkdmUElEMFRsVVBrRlJiWUpKMGli?=
 =?utf-8?B?Q25xV00rZUtEOTRqSktlUXpMa1Jpc0hDVTgzUGpycEJBRjdEbEUva0h4aGU5?=
 =?utf-8?B?NTJOSEphanh0RUlRdkY4R1A2K1JlWUUyT3hwV0R1d3RwMzdSV1ZMNWNyUWRX?=
 =?utf-8?B?bmk2dXVpS1JWSGx3TVdzTXRHKzE0MUF4VjQ2UVVhTkxiZEdveVhTbTFZUGJJ?=
 =?utf-8?B?c0VpUWQzeFVQNXRMMVdOMGJXQ3JTMjgzRi9WYlNNTGd1a0RDN2RvQlJOL0lk?=
 =?utf-8?B?elYzVDJmdVNXOFpKc2tFQzRpWUsyeFRENU9MMkhCUkRKbExOT2dQeEM4Mkhn?=
 =?utf-8?B?Qlp4QWpiaG5OdE5LWHUxd0swaFhOdDgzTkpOckx5QkhuV2JlcDhCanJ5VFRy?=
 =?utf-8?B?NjJCeExTUkhkYVA4Yzc2a1Z5Vlg5SFg0UjZvdy9VUlNkY2tPbWRRT2czT1pJ?=
 =?utf-8?B?ZHk1Mk1UazIvT1IyV3hpTTJRMThZSVc1YU5aenpnMVA2NUVJcThwaFBBam0w?=
 =?utf-8?B?b3Zsb3kzOGFqK2RzQjU5WmVieEVNRjF0dlY0TDhNbzhtMVA1dHQzTUI2TWNJ?=
 =?utf-8?B?OFVqMVRZMDMvbU5UR2RreUY4T1FoenFTOWpCbXpvbEtHUzQ3UlJocUxMSUdx?=
 =?utf-8?B?cGtKQWoyTGFWVU5CbFpWRzBmVkVaM0d6ZldVYkRjMmFvZ2RoSWp2cDRMYlp0?=
 =?utf-8?B?NjkrOW9LQVZOdUw2eUJ2cjNPKzJZUTNlMUtYd3M5bUJCZjZCT3Q5NXFUeW82?=
 =?utf-8?B?M1R1ZWRJS1ZlSzhSTCt0QlFnaGxZcThENkxMaW9Vd2FaTVpCRkdpdDh1RXlH?=
 =?utf-8?B?Vmc2c2hlSVhFMUFYTFVPOVZyK2N5b0RjQ1ZieDBtT24vSFRJcjFhMWNuLzVN?=
 =?utf-8?B?S3Q5SENEajRwUUhwWExVWUFDYVBXQTY0VkFBblhNNk85c2lZQk1QT3FwR0NV?=
 =?utf-8?B?bUFCeWZYeEZ4dHd4RHdOVU9TWWRDSUFaenAveEZ4TGdyWkhLTUNEZUp0anE3?=
 =?utf-8?B?RVMvSlBQcFFOd25XZ0pXS0UydmxtYWZrMElQUzZNQ2x2czBNVUZLTmFYdFJD?=
 =?utf-8?B?c1JaK0ZsNC9EQWlPWjJ0VDlCNmd4Z1NHUHQ0Mk13SGF4cmFKcy9rTURHUmY1?=
 =?utf-8?B?S3dlSnFMOTQvdXdoVmNaU0dUVVFIV01IOWpYOUc5SVVrVThwM2JSaWpERmR2?=
 =?utf-8?B?TmFsTzFoMGlkRU9NRUNwenJUeFMzYW9FR1lpZVllS1Zha05lZm94dWR4N3F2?=
 =?utf-8?Q?N5Q8VIDipS9dNMp1k+f8ypUEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6247f3-c09b-454d-9ae7-08dbd723091a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 19:29:28.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hEhsVnVAd1/rfxa5mBaUxxcfeAw3lEPr8i/k/FGNSJuxDXV+hMF30ISLmUx97gGerbO4sPzwa3y3DEDDI/H4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 14:24, Thomas Gleixner wrote:
> On Thu, Oct 26 2023 at 12:03, Mario Limonciello wrote:
>> Parallel bootup on systems that use x2apic broke suspend to ram.
>> This series ensures x2apic is re-enabled at startup and fixes an exposed
>> pre-emption issue.
> 
> The PMU issue has absolutely nothing to do with parallel bootup.
> 
> Can you please describe stuff coherently?

They are both issues found with S3 testing.
The PMU issue wasn't being observed with cpuhp.parallel=0.
