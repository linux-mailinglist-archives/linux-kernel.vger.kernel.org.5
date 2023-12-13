Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F34811EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442239AbjLMT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjLMT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:27:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564F6D0;
        Wed, 13 Dec 2023 11:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEB8HwFL3dtCUA0l/8UQ3ucWXH/jbm9IissBCy4vYtx/Y44Xg04CbGoh/Y+6nDPhsUSBVuyNSwx+ACs0Uxjc3MNymJbgDZZNLU4sDSPY2h2e0bgZwCCU0ywtT0MSalXZPAgLKgBi+VDgheahhVSel6PV8zlRPS/UmwkaiNvCTIIBEWTc0cL6JoBrf9WE1txMXnEYTFGzqV2JZMANeDtKA7xnbW390Yx3SPRBh74WOE/wTjhc2vBdAVYnPTNG7wRanxLjc1KOqYi6OXLkb72RonR3MZqqkmfexAKMUTkLL9Abm0BQQg8tA+GK0WOP/sC2O5usKVeUarGavzMGJejRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COzrvbIMoEJiE0++OECcORA1Sw65f9Vqk0EV2kS4fZI=;
 b=gN+jx+3m4npPc+d0LpYg/z4x0JfbOlNsOnnoZ8dTqJrf6BpYQOouW1/k1SC3U4mrb8zUjXGulu7BoKfj1bBQi7XWr+kI2rCueC6E14XISXrZhLl/+W4NMc9zixIln0udDwEEUDS8EpbDk6ewc0qGP3YpAB/Z8n0tIv34UQ3j+qfbsbRdDvHWyfSyNCdp1Rsj/2fPAe9umqMRDdmzNOFwHdrwAUymnHEjMrLxuZfDG0JNhaOJKD3CNeFajGmAf4tm29ho/KxYgGCGKrYK0l1r9FEgQh4zhLzrkLdxxT2tcZiMO6rHzKghUHfo50hRTNu22L9HUyHUKPrbP/IYoyLDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COzrvbIMoEJiE0++OECcORA1Sw65f9Vqk0EV2kS4fZI=;
 b=SZnR0UBdK4wjJI+agcuND5JrNSzVRGsz29SBlM0CWZC/ZG9axwRA7XS6w0+IK21HjHPz3f4yniqumLZAt4pekO30W7jE345k0PAFetcVp+cmwPXHrKEb5u+qfqZf0/bZgWVwYKfelzdehoHxfNyIaU+d6/oUOxbeC26gr/xfOBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 19:28:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 19:28:02 +0000
Message-ID: <dfc24ec8-4741-4c11-bd50-d5cc8d60447e@amd.com>
Date:   Wed, 13 Dec 2023 13:28:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Content-Language: en-US
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
References: <20231212090852.162787-1-mario.limonciello@amd.com>
 <9da16cfc-d0e4-4e9f-91b0-42b0bf4141cc@nbd.name>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9da16cfc-d0e4-4e9f-91b0-42b0bf4141cc@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:8:55::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e67b802-7339-4350-85d8-08dbfc119f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/UpLD+ygiF5ys5umHFiXXabtO/U+WdnPh7FpcfKEAxQ5CrZLO/wR2s5S+8YY38TEGay4wJpRioqdA0gBZv7CxjxbYvUcxZPAes9ySpfeLim6LqZHaxX/aU3E6ieMB+wrxgQWiJcCh/ep8X0vih1XFO1pxSkDBkUtbRPQCBrSzyAf3KQbzCCK0olL0+M2OVZxuWAiffeNzkaN6St0/DLfccO+vLdmHwXfy0/5C1eGDp1TTaq1+47R9zeau/TKSID8P6/gq76TQzWISIgBLiQbQZRQomBU5sHgmuaf0oT7PBLW30xpGmrRIKmkXpOb4UG1qZFV0VWcYLRR5kaLdS2kAx7yprMVJcymutWs2ExLPsIglmcVRLpU1yOpCF0aAnG1TgKT7BKt4uojks3uGI6CIqHgUKxAE9ne+iQ8aDKnuXguclg/jIKwxUyx5VlAy1RAbfFcTRV/tFRzjIZWIs7FCAOYQet6XTA8VJ0406nWc01JK6eicM9sGI3n0qJfAndGphO/uz57u33lQ/1yducywsbwR5GBnDr5dD997o8WlwdI2RP8hh+dcfobseaimDS2bsEaIH+RDt7+Nb2aQCzYQgVWh2ollyI7msHkjr4gd67TDHK00hRX7e6sg2lemoa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(2616005)(26005)(6512007)(6506007)(31696002)(86362001)(36756003)(38100700002)(5660300002)(8676002)(8936002)(7416002)(44832011)(4326008)(966005)(83380400001)(66476007)(54906003)(66556008)(110136005)(66946007)(41300700001)(2906002)(316002)(6486002)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDcrYXZiaTdmZGNQUjJveWgySzNQd1Z3MC9wYmtzK3BwYUhLMytnRHRVWHhr?=
 =?utf-8?B?ZVhWZ0JncktUSStRSjc3UzZRL0hpUWZtYW5JcTBodFNvNHpyaE95Wit3STZY?=
 =?utf-8?B?NFl4dXd6QmdObHYySTNzLzcrNThJcy9ENVQ2ckpJTXhhekR2YmhQblBYYWJi?=
 =?utf-8?B?WXJQbjNqNEMyZ01xdURUc0Y4MlRiTXRiOUZjcXhITERRUEtLT3JoR2Nrckhp?=
 =?utf-8?B?TnZzTG5UOEJwTTBwT0E5NHhBU21mQitIcmxEdXp6RU4yRDZiZ3NIVExJNzVp?=
 =?utf-8?B?TkxPbm9SQWY1Vmh0T1JwRzBneVNwYUFadGtLZzB6dTA1TmIvWmQ5TmxOS2Na?=
 =?utf-8?B?M2JJNnYySFFNbll2QWNKRWt6eDN3V3o4SzRsZmpPTEpvUG1PS3IxaVhWUnha?=
 =?utf-8?B?Qk1OL3lVbjlMYUVFZ014bjZWQUE1YW1lelRNVklleUU0TStLN0FlQ0FlY2g1?=
 =?utf-8?B?RVZ6a2g1emYxT09kazgrQkU3WHZpWG1BVEhjVU1JSkNUU1hFWlBsN0hVbDdH?=
 =?utf-8?B?WFBjMGF2Y0FLTUVkVERlbGZBMjF3a3o1NVVFK3Z4T1FBMVZKMUtYeVNYSXUz?=
 =?utf-8?B?MVhBVHZqd2pmd2dqKzZwWXJ3U2R2QStRa3lQOE95NDVTWkRFUnY2OGVOdTVP?=
 =?utf-8?B?RlhIZmI5RXpGU2hiZ2VhYjJVUkdheklGYmZ2cmtiWWVkT1dBQ0hVNDNlSk5X?=
 =?utf-8?B?aEFpN0YydEJDeCt4b0VtM21HTnR2ZjZIa1pESk4rYjZXRGdWN0w5a0RpZjcv?=
 =?utf-8?B?YjZRRGFkRnkrMlEvK3dYbFEwYVYrWks1TUtFL3F1MEhJeisyWmwzektoZEM0?=
 =?utf-8?B?eVpJcVlRa2NhOThlaElRSHVBL0o3Z1ZOOHFBejVibDZaaEUzWjBKY2VMdnBG?=
 =?utf-8?B?MHg2Uk1sNGRySjZLUVdwVzAyK1ZmSjgwVkxQYnVjTnVYcEt6dGJHT1JRU3RQ?=
 =?utf-8?B?UlNJMVNITTdiQTl6VXFCMlZUdVN5RXNBMUJhQkZrNWNDK2UzZytLdlNCc0JH?=
 =?utf-8?B?S2R1SEUxdDJjTDRwd3IxWXpOSHZsYWh2Y0k4L0xldk1WRXM0czFQeU1SdjdK?=
 =?utf-8?B?THhGeWdOZmxsKzdNLzBjWmlDWkFxWFhFMkJsNnh4RWRHaWdRS0hQTVRnOWpI?=
 =?utf-8?B?Q29FSFdxNWMwd05saXRlVUZ2R2ZmSUVtU3MwYytPR1FGL20yTjJZcURGQndV?=
 =?utf-8?B?OHRZODN6ZnRsOHA5amxJUmFwT1Z1S2FhZzR6TllNOW56czJIb0thSGZZbjlS?=
 =?utf-8?B?aEltVWVMSmR2UzN6d0RqNVZPc3IvMTdJMkNsMlZmQXhvdW45SkFyRUJJdEFI?=
 =?utf-8?B?U3VOd25oWTBlaXJVWVJFdHdHYnJTMlBpRnVpR2dtMExoVjNwUDFsUzdaRncw?=
 =?utf-8?B?UGZMTENUc1orZjJSWnN2bFN6T0RrWUxFMVo3SnhpOVljSXJ1aVR4QUxxY2lj?=
 =?utf-8?B?dFVSSlFiWkcxVzNrdlVUUzVpblRoSnhVWHZUeW5DWStnQmk3OG1OK1ZpRnp0?=
 =?utf-8?B?eEF1YzFqSnlreEYxY2xxS3BKeDZ1WHRvNWJ5UUhZckVmRkJLOGthS0JiMWlL?=
 =?utf-8?B?cmFKSHlzRWYzckxQWVNTa0tFak4rWVhVbWViTDBqeFovTjk3QzFBbDRGZWRW?=
 =?utf-8?B?cTk5aW95am12bGNTS3pTNi84a2hmNWVvajVEdWtuZk9yd0lBOVlsSUV4TERL?=
 =?utf-8?B?bk5IUE5pYzltdGVscG1JTnJZcTZuaU8vY3Y4elpUWGtvZVErbzU2WjVDU2cr?=
 =?utf-8?B?YW5oR0hIRkN0SG8ydXZsZDVsR0ozRGpOUHpFeHcybSs2RS9pNDY5MnZPZUMv?=
 =?utf-8?B?d1lYTm1ZaVoyT2tnVUtsOU1NaTVVdWNIaW1yU2xZV0RMck5jMExxWjhkeFZ3?=
 =?utf-8?B?ejlzZVlxYXlTN3VEMDRJT0xvK3JFL015NjUzcW5JWjExNS8xUkdzZGJ2dnp3?=
 =?utf-8?B?U0krQ0RKem82L0RlajI3VjJZTUs4WURtY2tGOGN3NGt5L3RhQWVSU3BlNDNt?=
 =?utf-8?B?OVd1U0JmMEVKaWo5KzlOb0NqeWlQQ04xRk05alVXS2FPOCtqYkhkdlk2L0Jo?=
 =?utf-8?B?dlFDei9uZzZNekE4eXdnUXhSZnM4aGJtSkNlSjQ1NnlxcENJSXhRdmh4Qndp?=
 =?utf-8?Q?88HBSoxF2HcUqBdj64sf1j4uc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e67b802-7339-4350-85d8-08dbfc119f70
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:28:02.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5Fu3llq+HexAjaxzS4K19e16aLj8zuzTlqUCBKnbvBCYstRPlbrGobhQ3r5P2f/DnPeZiUOQEnl2Y32Zn5GoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2023 07:35, Felix Fietkau wrote:
> On 12.12.23 10:08, Mario Limonciello wrote:
>> Several users have reported awful latency when powersaving is enabled
>> with certain access point combinations. It's also reported that the
>> powersaving feature doesn't provide an ample enough savings to justify
>> being enabled by default with these issues.
>>
>> Introduce a module parameter that would control the power saving
>> behavior.  Set it to default as disabled. This mirrors what some other
>> WLAN drivers like iwlwifi do.
>>
>> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
>> Link: 
>> https://codeberg.org/Hybrid-Project-Developers/linux-tkg/blame/branch/master/mt76:-mt7921:-Disable-powersave-features-by-default.mypatch
>> Link: 
>> https://aur.archlinux.org/cgit/aur.git/tree/0027-mt76_-mt7921_-Disable-powersave-features-by-default.patch?h=linux-g14
>> Link: 
>> https://community.frame.work/t/responded-strange-wlan-problems-with-kernel-branch-6-2/41868/4
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> This patch is disabling two different things at the same time:
> - Wifi powersaving
> - Device hardware powersaving
> 
> Have you tried simply disabling 802.11 powersave via nl80211 to mitigate 
> the issues with affected APs?
> 
> - Felix

Kalle suggested this as well, I will experiment, thanks.
