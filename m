Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6177C565
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjHOBsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjHOBsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:48:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F00173B;
        Mon, 14 Aug 2023 18:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2iqlAZzoJ+0YtLhnPU38sEP1iq6kCCF0O2u2nRV5KeGj6HEmlknYeBJfMKcdsqdV52ktHYy25gTNCUEZ4LaWHV/O72vqYAXlpsPwbp1+W75cLNFMDjKYqtxIeqqZhNON3pjXB7h+4TA1WzX3RkXMXAHuu6GUPCDlNBX91WpwT1FBLLaZyW8xBt+r9nUN8qC0ONFYaYKfWA+i7R+B/wfj+PN0qQz3NzyMHc3s90a/nXv0y1JJs/G8XgpToLV7QXXYkYanTBJq6RC/+L+4Z7yGISxQ48CXaxvkK60lA0AkEFt/WdKP2tkzmhdJzIzucnQOfsdkQtC+58dWnFYox2bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6B8iCJ9P4JXFCvJpAqo7dEDlVr5maTZqGzFFoO5IPhI=;
 b=bNjl9yIm/TtrRLGBF6NWV6VK6H0Z8486H83EslPxEroDw3hIaMKS44EUGyTjwsDuGOd/RVg7evYP2fPIFPdMpujSETEJ8+i0uK+qkDioOPIKFGs8+r+1Wl0NeJXHC5sGH3N+z/viwCfJTzrpXPFb+Pmrr2AneOJnxaelucWSzbOYWaEbf5BJIKHE1Z5zlPRV9wTIDpC0x0mVi46SjBF3dKRGMgDo+EFlPDxuztGextUwXRIM6lO3iK4+V2f6pvu2kUmzE+KlWKUbrku7Bw/ChdBxTPUw4lrXE6/PNAwbVXrXDZdd116tycidd09OfybXVy67kTs9NHhtRSnQ313ogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B8iCJ9P4JXFCvJpAqo7dEDlVr5maTZqGzFFoO5IPhI=;
 b=Rgw/zzzVqtx1HmYkgERuL9bDp5r6uU30q1QcXGZQ/LWealtAWVJ7ltEBMW4SVy75Mb6USZOFsm32A0LpvMAGyftehm5vloh/h4clV3zahLYw3aDBQvpyHvwWvcEaDOhJf8aLh2L7eONODBuWaHPLFjN9xHkSx6piLlHUsoDXE20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 01:46:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:46:45 +0000
Message-ID: <c13f3ab8-eaf6-4efa-b06c-96dd2237165d@amd.com>
Date:   Mon, 14 Aug 2023 20:46:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
 <ZNmqQkOK7CLa7TNl@amd.com>
 <dcb720bc-113f-e467-01bd-3d19869e13ac@linuxfoundation.org>
 <696c34d0-3de0-4f56-8003-eac872298605@amd.com>
 <62da8b7c-3a90-cffc-4750-532c2b440764@linuxfoundation.org>
 <764c49f6-0dd4-4bc0-8d7a-3054a5d75999@amd.com>
 <c5a9f8ad-35f1-fc89-7904-1eb42b48ef58@linuxfoundation.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <c5a9f8ad-35f1-fc89-7904-1eb42b48ef58@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:806:a7::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f0b09a-4a98-420f-57b1-08db9d317b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku0y9SwKh51rKeBpWvQiN980ukf2Bl1ZlIdMq1ZNFvnvs/ydTpKHQ65B/oG4diDhcVm4SQeEKcrxV/wkUEyOBlgkFKYce7uFFa5YUQE9pEJAJwwKm2i1c3BoYmD19C89l0YzBMjF66Bki/VOWVRDztKQo47sZEIDfFiov8dGsNYO+CUNqn0KAL7XQoBFT9urLrF6vhi3Zxf19GiRVZxsF943JzqIiv3CFIRLjcCTdf6SaNswo/B2iJPmtnJlaJAuIOdSDeoOTCvcRALNxEBGmiw+prIEfEwreFhs2isWxINuIHAHI0FmGQhOOIuxUEOb0MnBO92+710SwSPhWdnyKwYWCuDv8OMO5uoQ/NlZvs0GT1mdD+MX+kRkgUssCzqQHWy/XrxLcxaf86Ud968T7zhc5+D7xne9u5dcN82ADl3E+YbMXXVNT3cJG6tpaP6+fsouS7VLxl8qv1lOlqrwaHzUKRx2l1vSdUIROMlFBRIPryyZ14pFpg0EmrsM40r+22N6DQw60K8z9zTDyE9PINdPbwSCAHjG0dtV25QFgjSzTHKwoiWOLJTr52j8Ln749ai9o7pkVolNjcGzrEXGIozNw4TpOtho9Ei+99UbvEgz8XdXS2E2wpEh20BLYoZtYPbQ02CYs41LY+zjFZzcyuuvV1IF7qO+BEeHRLq7hmrRJdb0ITaEOU41+2W6ATH5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(186006)(1800799006)(38100700002)(110136005)(54906003)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(31696002)(6636002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(83380400001)(2616005)(53546011)(26005)(6506007)(966005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzFmMGNZdUZRZlROZWVMVmtraVJRUVJubUJ1Ym1oSG5Na3E1NHgza2g3VHJ0?=
 =?utf-8?B?cjV5alQxKzFSNUxvUGdkWlRJNXByU1hFeEszYURUWTRUT2lxNDVWZnBEajMy?=
 =?utf-8?B?dERIY0EvaGd2V3Y2dHJXWDJFMTA5VUlOd0FoYXpPemgwaGFrUnl1aFJJNFI4?=
 =?utf-8?B?M0RQei9FMUQzeXFmMVF0R0R0YWNpb1BFZmZjQlhSVFYrcUJHWUVvZ21MRVhY?=
 =?utf-8?B?WlVzQ0ZrcHJEMkxOTTFMMUpuaEpYTGlPSjNxUnRwNkxLNDdVMHcrOWg4dzFG?=
 =?utf-8?B?ck0vNHF2elBWV090RkFNVkQveHhwbm9CYVB0aDJkazFVU01adWMrUnlQdXQ5?=
 =?utf-8?B?alVkTFFzTXhHekRyS3h1NHFyVWxCeW1nUFUyL2Iza2JEOTFVVE5GQmRWVHpQ?=
 =?utf-8?B?VGpza0IzMVA3RVhCMktwdXM4QkxvSVIwYVRKWFNrMnBoT0xzWWZmMHBhRkF4?=
 =?utf-8?B?dTJITjQ5eHdRbzBTN2Q0cVVRUEd1M0g4ZEJiOTZVYVBxSjhVS3k3eTJxdTg2?=
 =?utf-8?B?RUNMS1A4eWd2UXlQN3lIY095cFd1L2NvMUd1cVBsNmYxamZ2cDhtWVJEdkdw?=
 =?utf-8?B?VW5sRWUvVjVhMnFCd1VQVU91blcrOW5vakRiYVIwN2hGT05wZGdUTFluN1Bw?=
 =?utf-8?B?WGN2ZlM4VHJ2amdYRVlVQk4wc3J4RUt0UzBhNXZRS2kvTUtTWGdCUVJjQUZv?=
 =?utf-8?B?bVo2c2c1NSt5UVd3Ti9DbmNEQWJBNDBOYVFEQjFyaFFOWHZpOXZpT25LTnpN?=
 =?utf-8?B?a1J1YlVNbjN1S3RsamZVMFRyS3BmY2txK0t1V3FmL1BqY2FQMW90cUprRFJY?=
 =?utf-8?B?SFVUMjkzdWczZFV2L2VFT1BDQ0Y3K0loOTE2TTNQQmVyYjF2S0hkc3ZIK0Vt?=
 =?utf-8?B?aVRaQUpEVjFsSkR6aVUyTC9GV2M1Y1o1VCtIYUdJNHdRa1JQSERMT0ZyU1pC?=
 =?utf-8?B?TTV4d1p1aHNCenBmek55bVRxeWdXQko0S0Q3QXB1TWFpc2Jha3o0M3ZPaGZS?=
 =?utf-8?B?MWNGVUxkb3JxR0NxZkludmNTSjVhTE9xaUJlUGRhOXFwVjAxTUJvQ0h2WGFv?=
 =?utf-8?B?TEtCZ01qVGdRRlg2elk3emRVdUlNcUhsKy8wUC9ZaWdJYXc4elNQSW9tVlg2?=
 =?utf-8?B?RlNtc1pUcm85Q3hzcEtYS1lQZVdqZEl2c3VmNHdLSjBIZWVFamE3R3BPd3hs?=
 =?utf-8?B?a2ZvZkFpUlNmdy9uRW94bXZKN1IvcEUyS1VocUtoVEw4eXZBRVRqanIzLzNM?=
 =?utf-8?B?OHNMdmNOanRxekJoY1dwQTNJaHBRald5NW5nMFRGK1VXVkhGQTI5cG43VFdQ?=
 =?utf-8?B?UmJqazdQN1BLa2M1MWpEMWxRZzFjbE1FWE1JdkFKN1VTTFVHOWswbGY0dFFq?=
 =?utf-8?B?NnFSWW1PV3pKb3hYNVNrNkx1N1JydEJ6MFdRM1NUT2EyK0FMYllHWUl3VEM2?=
 =?utf-8?B?K0NMeHlySU52UzhaUVNaRHdKdkY2MnBQc3FkY1ZEeUJlSzJCLzRRclEvUUlU?=
 =?utf-8?B?TVFXR1R6RzFvTGVjVXdLT1VBczhuMHhEWjdpZFB1T1NBTWtLYmk4UmxhZVha?=
 =?utf-8?B?ZHlNVHlJTHpaQW0xbzBJZnl1RzZoN0I2Uk5BV1pQMk1jSk5EMG5BZkhWd0FL?=
 =?utf-8?B?dmFOcEl5RzBmdjR1d1VyWm9NVk0reVE4YVBaYVA5UWV0eEFuMG41eVJlTUZl?=
 =?utf-8?B?cHh3b3pPdXNrcWRoeklXbEgvRFJ0ZSttVHBxbkZwUHk1VnNKZWhoK2VNOWpx?=
 =?utf-8?B?c2plT0NWVDE1c1U3Z2EzUVg5K1lPRDhGV0wyT0tUVW03UXVKMlRFYzNPdG5B?=
 =?utf-8?B?bVJUT2JoRGE0K2cwMk93K1h6VFQ0ZUpySkw0dStzcWQzK3lqS3dXNmo5Z1Jh?=
 =?utf-8?B?VzZscGs0NjlOMXdCd2EyLzZWbGxVRkFhdkZwVmpiUkNwTEcxaVZKaExhbFph?=
 =?utf-8?B?Y2RUQ3VEK1FFZG10LzZ2VFpManNFV2VqaHQ0SkdoajhMRUVTTkhSaE9qaVRp?=
 =?utf-8?B?UG1tYUVlN1Y0MExBb3hkeDJPN093MEdmOUN3YjIyd2pIVUJKZnNyazRZVEMz?=
 =?utf-8?B?R01oS0srNGRwWURIZHZSc0NxS3d3aGRiY2tiYmZCV0QrbnJJV2Y4THYvRS96?=
 =?utf-8?Q?JLhgckQ4pTucRvwyIhyRSpHIk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f0b09a-4a98-420f-57b1-08db9d317b4a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:46:45.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpT6HjrHhNQzJ6Jr2tC8AqEX5XFZB4NYcz20rF++RLt8HhDYBBqI9Tqz+CTaQKmcrwrWPtMKjOtegfCqIuL5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/14/2023 7:03 PM, Shuah Khan wrote:
> On 8/14/23 17:33, Limonciello, Mario wrote:
>>
>>
>> On 8/14/2023 6:22 PM, Shuah Khan wrote:
>>> On 8/14/23 15:50, Limonciello, Mario wrote:
>>>>
>>>>
>>>> On 8/14/2023 4:28 PM, Shuah Khan wrote:
>>>>> On 8/13/23 22:14, Huang Rui wrote:
>>>>>> On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
>>>>>>> When running in active mode the driver for amd-pstate has -epp 
>>>>>>> appended.
>>>>>>> This throws off amd-pstate detection.
>>>>>>>
>>>>>>> To detect amd-pstate look for the prefix instead.
>>>>>>>
>>>>>>> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP 
>>>>>>> support for the AMD processors")
>>>>>>> Reported-by: chenhq2005@gmail.com
>>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> Acked-by: Huang Rui <ray.huang@amd.com>
>>>>>>
>>>>>
>>>>> This patch doesn't apply on top of cpupower latest:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git 
>>>>> coupower
>>>>>
>>>>> Please rebase and send it.
>>>>>
>>>>> thanks,
>>>>> -- Shuah
>>>>>
>>>>
>>>> It looks like a variation of it is already in your tree as:
>>>>
>>>> a1cf97c2d43ae ("cpupower: Recognise amd-pstate active mode driver")
>>>>
>>>> Considering it was also reported to a kernel bugzilla, perhaps this 
>>>> should be considered for fixes?
>>>
>>> If it is already fixed, there is no need to revert and apply your fix.
>>> Please close the bugzilla bug as fixed with the above commit.
>>
>> Sorry I was unclear. My suggestion was that perhaps a1cf97c2d43ae 
>> should be considered alone for 6.5-rc7 instead of waiting for 6.6-rc1 
>> as it fixes the Bugzilla issue.  Otherwise we should wait until it's 
>> in Linus' tree for 6.6-rc1 to close the Bugzilla.
> 
> Got it. There isn't enough time now to get this to flow through
> my workflow and then into pm workflow. Since the bug is fixed
> in linux-next, it will go inot Linux 6.6-rc1. Then it can go into
> stables.
> 

Got it.  In that case can you add the Fixes and CC: 
stable@vger.kernel.org tags to the correct commit in your branch so that 
all that happens automatically during 6.6's merge window?


