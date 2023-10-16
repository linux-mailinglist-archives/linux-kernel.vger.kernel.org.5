Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B97CAB28
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjJPOOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjJPOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:14:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E784107;
        Mon, 16 Oct 2023 07:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqeVSUQgAZGQBC+s4ai9D7dD6N/8PYwbQKqkruzgkcCBHEXw+JjODsK43daEQ2O9/Fu51vqFoaJFqUMmgi6jso/sjcmUZpaxXjgjLpbQme5v2wJiH3zZDOpLmucepVv/2uliJ/oGtNrRtGofzjD4NQzSBasgF7FyVjt6B6v563jm8/WYxHIPWrnNv7hGyGbxKJweMsm+RWxkurUdDRiJmYGl7A9GpFeU04NfE+SqWsGJ7E/kpRVtFczO7KuaAQPqcNlLgMCiDGIGe1WXV0EdXwhsD/KJYr2atNih7iFonGBNohzpVST8u2F39QyUxJ2bwOdD7G2EruHB7WJqLvbISA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zbxOVzHRp9bRR/MGtsjKTdQpADJzCajgzS/8CT4XFY=;
 b=iV9fH4MpbcBfZy+jXANKJ94ZGAGIaA9IVZ8Qb0Q8CiLDp7bsVF7CoUQM2HgUS2Swwirfon43WulQ6p8fdLu0yK6Pf0Ln2jTn9isph0OyotzgiQ5mZWAlBGanQ556DErK4xAzXu06//jPV6i+mPChZwC85auLH+dZ6QdqmYngZaznU6S8DiKbrIvGYVPddQR8pifxJHW4ranfHdBrRgJRy0GFB+aKWPFaH9ppZYfC6f0TE8vMIis6ldgvnGlH+Jlks8XRHRLbTxAXZ+meiADVKFt6IUMll9yNFPATM8I9gCnNlf0nZ/pMoN7LbnEvZIR71byQHpJnbIV04oS8tl7QLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zbxOVzHRp9bRR/MGtsjKTdQpADJzCajgzS/8CT4XFY=;
 b=d+N1ea+TN8rLk0t+4c+ryY4UCn+Zmo7zExHXzL8aBHH4OEN2I+TrV45PuOAh9xLG4KtoAvmCewrn9Ey3I3R8Og66LUlJU5pDdQCs5r8ExhL/DKcBUAhM1cTrO9hsDeYB49INVj8NjoHCmYPReCjfnt3R8dyTklH8oZ7qV6I9c+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:14:08 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 14:14:08 +0000
Message-ID: <1c598798-5b28-4a17-bf86-042781808021@amd.com>
Date:   Mon, 16 Oct 2023 10:14:05 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Increase the size of the MCE pool from 2 to 8
 pages
To:     Dave Hansen <dave.hansen@intel.com>,
        "Sironi, Filippo" <sironi@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231011163320.79732-1-sironi@amazon.de>
 <afaef377-25e0-49f6-a99f-3e5bd4b44f87@intel.com>
 <EDD08AA3-C404-4DB6-96BA-2B25519B2496@amazon.de>
 <6591377b-7911-444b-abf9-cfc978472d76@intel.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <6591377b-7911-444b-abf9-cfc978472d76@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0746.namprd03.prod.outlook.com
 (2603:10b6:408:110::31) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: ca2895ec-a0dd-42de-5413-08dbce52295a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T4yY9NxvHD/tOZc3DvGEpWEJ0FsIxEZluN+JShRyIRVvHbji5qhRnN5C7IRPKhy+yHxCGQAuZg3F2rMcq/skN6+MrksujK3NSIhsEfLX6bQVBjg20iZ6Pu7wSkcvfxScWis4lHI8na5xPa69SZBBOBffVvJqZrWrn1t5bqdkMp3E7pziZQp1hIhD0ZF7stRLub9CHcBnz2DMvsvKvpoqbOoAhD5ZTDMtvMYxf0sLREs9zi0fB/L2VMmFivhWbQqdkwkv2AnKm5OECmbyOnm5BRs7954KGrLTcLEMYwATSPyqV6N3w1efi79yshqF2j8srRs0w89W9VP9brvAdoc9PylkgVypNYwQPshZn+FxOBf0Uf1vhursYQ1gukO4MCua8GJx1l3k/uJpAta7vMGeUzvnuArPSGTue5MW9kh364qfygfxbDOD3/FHPT1+QudbUxzukiC/woL9oqHi5PR4Pqx1KA8YsU4WUkxPGzZLIUFkHmeqBkpUWBoX1MakTbGQtkTDQ7Z/idvFXcHzUCVlYmmI5w4VlWqWidt0efmKBsunu8TONAHQho/uZAtc92Ow9PxgvRVU67QTT1zs6mX3wrRdMw847kaaGMiPSF5bHpo9x1IjajSvDP7rI8sX+xcx/NhDAux72tLoYe+9vnGjaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(2616005)(66476007)(54906003)(66556008)(66946007)(478600001)(316002)(110136005)(53546011)(26005)(6512007)(6506007)(5660300002)(8676002)(8936002)(4326008)(44832011)(2906002)(7416002)(41300700001)(31696002)(86362001)(6666004)(36756003)(38100700002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5kUllhNlpPTzA1emVqVndxK1UxRml6SnlZV29La0hRUmFTY1NpcWpDcFAv?=
 =?utf-8?B?R1lzM1VJLzNxajlObnV1Y2VHQkpwRGlSbUNkOW8zYW9QTHBOTE45OGgzUWJz?=
 =?utf-8?B?YXdwVFh5cEZlaXB0K0N0MldYZklMbFZmRFEzS3NJWFJBWFg1TkxJYnlRUUZw?=
 =?utf-8?B?Q3dqeExDZ0F3MkJ2L0hiZnM1TTZBOWQyZ1JZQ1dkdFZFWGNrWDdMTytOYldm?=
 =?utf-8?B?VDlIYWY0L0I5cVM4bWoyeHQ2eEFyVTlMMGRsc2J5UkphSi9ucmVDY041U3lF?=
 =?utf-8?B?Z2FGUENsVjk1TVhLUmlxbkl2dHMzYmttSVArYjRoN0o0RlJoMmpFRTNtTjhq?=
 =?utf-8?B?SFU4Y0tmREpiVURvYVE4MExJVWdtKzdIaWtBZHJDSnU1M2JVMTdIbnQzYXpn?=
 =?utf-8?B?cnlMSHhkRFN3WXpXQmhiRno3RDJkSm1ONGg0RnkwdjFMa3B1VFNZT3hOekFs?=
 =?utf-8?B?UnNxeFBmUXF5ODJCbFdwaXZMTUtld3ZoaXBjSlhpWnZORC8wU2JsbVBRelFV?=
 =?utf-8?B?UXNsdm1Gb1lyQ0ZBVGEvM2tuaWx2RW9ScGNQZ1pUeDhYNWtSdG91amhVazFT?=
 =?utf-8?B?Z3FKdEw2ZjB2M1FNRVF2VFlML1JXMEhZdnFkSXZjRlpIdHJlRnduY1NKbmU3?=
 =?utf-8?B?WmlSdmJMTndLRXZoSk4veGZWWUtsblR0MHR4cStoWU01ZXZpbEJrQzA0azM5?=
 =?utf-8?B?TVFNSy9PRDhkZDZZb0tzL1JCaGtrdlB0aHZybk1KT1dVbDY2dnhnMlhtaGt5?=
 =?utf-8?B?WTUwYmpna2REU2VEbHVURTdNNmpCajMvblZHQy9TZDJnZVFPc0dzZ2VNSVBp?=
 =?utf-8?B?VW5hR2hnU0xPQ3dJU3V0eWFySW9IaW1HTk1nRzJTTXZLMmk4Z2cxM2JjRlF2?=
 =?utf-8?B?SGJOR3N5RkZZTml5NXZRNDhYaTZxNXp4cXh3YXpOQ3BieVBCdUNqSm1hblpz?=
 =?utf-8?B?ZmpoL0RhZDlxanZzRjhUS1RjdFNRL0pzWGwxVUh2OXkyeTlDRG1UcitvTUxu?=
 =?utf-8?B?aFVLY3BGbW0zV2FZblI2SUh1TG1SMDlNQm0wVTZzUXhtOFZ2TkhyTzRHb2FP?=
 =?utf-8?B?SzJmSTArbE1kSlAvcjU0b1VTR2FmRXBVeTcwSmdZa3J4SDVtdGFzcG9QekM5?=
 =?utf-8?B?VWp4T0Q4RWlyeXpXaDFNSklCSWlkZEpZL2pZUHNJMVJ2RWNKUGxWekQ5dVhj?=
 =?utf-8?B?Um1JT3E0SVkzTzUyaENVMStJUHd4VjQ2NWlMUlA0aklTbHQwemE2NU1DdlBT?=
 =?utf-8?B?YXoyeFd3dGZyakRpTFYyeXR0ekRkcituTjIyeUUrWko2TzVZVGgxU0dQQVhU?=
 =?utf-8?B?R0lJZHZ1NUZjUHNTZkdtaTFzM2NTSjc3R2kwaGx1R2wyUnZTOUZwTGN2T1RU?=
 =?utf-8?B?b2pJMUQ3L3prYTRHekNBUjJCS2J3VFZnNitkZG56T3RQWTBkaGNNOUFtNGhv?=
 =?utf-8?B?SXovRHpXUWdiTTJRWStqaUhUUElrbDNxMFRTZUhCSzVVZlR2L0Z1dHIycklH?=
 =?utf-8?B?dWEyWWJPZ1ZjamxqbitJUkhlVVNabUVFemVRRlpUdzdQOU00Ujl0ZXZqekEw?=
 =?utf-8?B?UEhySzlKMExNeUdYUnFqNWZJSWdhbjhwTmJ2eVBYdTJuV3M1N01zY0JxVjdw?=
 =?utf-8?B?T1R5YTlrRVVjWHorSVVLdmc0ejJ6WDhKdjdURWg2OGlDb0FFc3ZiUCtjT1Jp?=
 =?utf-8?B?NkFUd3pReWFDT0kvQXFnaEFIWEY5TE04UXFCU3ZxRG9nL3VZMEQwaTJmOFc3?=
 =?utf-8?B?ckhKWFVienVkS3pkNGFpT0pLdWNvbXI2aW5PT3RxbGNsN0NFVUVyMldESGth?=
 =?utf-8?B?VDBQcnIwMUFab0RWdnZ5eDhwZnZmSkJWK3dMdERjUjN0U0JCMVAvZVpLK3FI?=
 =?utf-8?B?djBIWEJFZmx5TzlES2kwWEZVY2lJN2JyS0RGdWRCRUxKZlFVSWVrVEdsZTZZ?=
 =?utf-8?B?dSs2UjVvaEJPWnF5MEZNcGl3emM2eVc0dW41MXRyUGR2MDhXejdCWnVXVFdE?=
 =?utf-8?B?YmJuM3ArZTRTbjlvZi9oUm42Y2RKcjhrR28rOFBxNHliWWFpWXk3dS9zcHJC?=
 =?utf-8?B?LzByKzVma25NV1I5ZTVNVnNSVzl1dE84Y051RmNTQ1lyOFR0WWJvanY2anN1?=
 =?utf-8?Q?nO1qnBKM2shS7hM53+aSdETFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2895ec-a0dd-42de-5413-08dbce52295a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:14:08.6657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PKB6D2dOObjZ8bxXfBsJ9IMGZjGOnwU/FgqLPTXWjMASfDNQREiBIXHXpquPKlCgk/OP7Zkq55dEAmu7uFwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 11:49 AM, Dave Hansen wrote:
> On 10/12/23 04:46, Sironi, Filippo wrote:
>> There's correlation across the errors that we're seeing, indeed,
>> we're looking at the same row being responsible for multiple CPUs
>> tripping and running into #MC. I still don't like the full lack of
>> visibility; it's not uncommon in a large fleet to see to take a
>> server out of production, replace a DIMM and shortly after taking it
>> out of production again to replace another DIMM just because some of
>> the errors weren't properly logged.
> 
> So you had two nearly simultaneous DIMM failures.  The first failed,
> filled up the buffer and then the second failed, but there was no room.
> The second failed *SO* soon after the first that there was no
> opportunity to empty the buffer between.
> 
> Right?
> 
> How do you know that storing 8 pages of records will catch this case as
> opposed to storing 2?
> 
>>> Is there any way that the size of the pool can be more automatically
>>> determined? Is the likelihood of a bunch errors proportional to the
>>> number of CPUs or amount of RAM or some other aspect of the hardware?
>>>
>>> Could the pool be emptied more aggressively so that it does not fill up?
> 
> You didn't really address the additional questions I posed there.
> 
> I'll add one more: how many of the messages are duplicates or
> *effectively* duplicates?  Or is that hard to determine at the time that
> the entries are being made that they are duplicates?
> 
> It _should_ also be fairly easy to enlarge the buffer on demand, say, if
> it got half full.  What's the time scale over which the buffer filled
> up?  Did a single #MC fill it up?
> 
> I really think we need to understand what the problem is and have _some_
> confidence that the proposed solution will fix that, even if we're just
> talking about a new config option.

I've seen a similar issue, and it's not just related to memory errors.
In my experience it was MCA errors from a variety of hardware blocks.
For example, a bad link internal to an SoC could spew MCA errors
regardless of the scale of RAM or CPUs. Same thing is possible for a bad
cache, etc.

These were during pre-production testing, and the easy workaround is to
increase the MCE genpool size at build time.

I don't think this needs to be the default though.

How about this to start?

1) Keep the current config size for boot time.
2) Add a kernel parameter and/or sysfs file to allow users to request
additional genpool capacity.
3) Use gen_pool_add(), or whichever, to add the capacity based on user
input.

Maybe this can be expanded later to be automatic. But I think it simpler
to start with explicit user input.

Thanks,
Yazen
