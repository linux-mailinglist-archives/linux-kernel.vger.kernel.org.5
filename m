Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0E805DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjLESJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjLESJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:09:53 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB0B0;
        Tue,  5 Dec 2023 10:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex2P6hanc/nW0O1ArnPAdPb1ECS9Aslnpao+BxFHo+okOJVXQxGpfgEGyVQiiWa1BKUIiAPnFK6ywJBTHAMq7+dJ8jmM6c9NI9XgnfdfP1xF9fzxr1cOMSdJlTWN9qgKdEb4/L4jro3ZM+5PvlM+CYIwmQdlADXUpL/vK3r1QwWrp9UHS8B0oRzHwynAHXqg9udNwxnIowYiu3ug4pUh3qre9P/RCTjtAeQh7hqfHB71jH1OCmO0pmISssoPXVP8FZ7vC9WDbiAIaOb+oeIDTIrxNySltl1+arTxoMspFroBoFzp6dSrAQmLaHjM2asBrHuzhtbQWhnjkzHAQHubcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIYJQVlHwIOC/Ub1+20JNz83xBw1G7bQlktcYn9FGjU=;
 b=aUWus1iR5ApuyfPCzRwmckMe4i3jLinnFVqG3xLnWN9hyo1O0kezInlDZBDlwkB5tMXCihFbseADWHK9a+5PKgvah94llrXCNOJ94qaZ4qfypHy3wcHid2ckZkkDh651ow5Rv2ggO18sCR70B/XfCEHWfwQVBvopwD81MfYEtPqLAyE6wpuooowTDjUs5MCTvm1KKeKKw6OPpdce4SFpRqRYTvAK6F6HrttulBT6HOKGt5QVnm9oY7X3UT/7Yp8bZgQk4lzHzOgpGUxZAh9nkInk3OKVmGPrsqyNRD+p+ij1zaFuKMj63++cT7NNiucJgdG/wZ2OzVynHMMCiwwiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIYJQVlHwIOC/Ub1+20JNz83xBw1G7bQlktcYn9FGjU=;
 b=BmdoJ/YL0EdsHSpshusGk5+xccHefN/fpjd6wFgK7fsMLPzfln60twjY9ek3OvbOHh4a9ERwTc5e6iBLYlxzPWoDBEld12dkWrOHwhgccOK88kBL1Up9Jo28KzuaeWA1yRtJKLauZibjVe5fxcm/KCYnM8SwS23WvV9byNasnb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 18:09:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 18:09:52 +0000
Message-ID: <5adbb9a1-7163-4360-bd4f-e8c1f57746d0@amd.com>
Date:   Tue, 5 Dec 2023 12:09:48 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 14/15] x86/resctrl: Add interface unassign a ABMC counter
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, corbet@lwn.net,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     oe-kbuild-all@lists.linux.dev, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
        seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
        ilpo.jarvinen@linux.intel.com, jithu.joseph@intel.com,
        kan.liang@linux.intel.com, nikunj@amd.com,
        daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        peternewman@google.com
References: <20231201005720.235639-15-babu.moger@amd.com>
 <202312060120.q62q2ha7-lkp@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <202312060120.q62q2ha7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:805:106::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0c7aaa-e78b-48bc-a72b-08dbf5bd60bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEeDO0u3KZJ3Ecb3TxKgqgd1MqhYaNcDsoUOF6MbbTu2hFsqx0KrVu9x4nGZULkxFjv0dqx/RWAJEchr5vrp0kwPHpGwq9J/RdmuyRnEBGjG1mEGG84d6PfR402GKoQqkWDLVA0nqUvIIGiHR32MrwHEBdCCBEMYw5ONf2QKrZ6P5thbP/T8mVSVjDTNVxSXU6s1DhRjpCvXU4/wOodvUAVg3r5bEEUiLNvi/JUMMveu13MaDHwPYzWavoEJ8VpwUnavajaiCdCPFkYuy4sECOZqWdw/vEOZmnR06tLbvjJ9hNCGYASofd7W+Dcaf+6kydPYOadfxpbU9wXpoonRq0pT1avwhpWGiiP4aWTZYAX5Y8l+Dt7C9+DKePHceGhuF9RLiVQdrhsk6TbM/+LZtYQkBVVR4BvwRhhribP4lej0tUqiN3Tcid8Xly+Q9mO05+rbuej874QfBteA03vGO70iSyfvmJIW6Wvo//ra6xEBaTLGrIoPnvdpHQQxuSnlyzwxD2BgyLeoC8La+Ft4i9awIYnA9dRLUl5j8sEl9WCemwDV3mnDqouVb5ro4slCQS1LjMT4W52i0bv0aFoKFgMRklUP41lUU/+J5bx7cn+vt2DvSB85L2AKxIIG2sgzZSyrfA6e+DwUvcyEPx8KHX7u7RPb3IpLK06T1uZFKdrv6HjvbKqqM1X6yULtoAr+SF4HxG/uGeTchkHsW3TJYOFJhBOqymXHnwVC6cued30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(5660300002)(7416002)(31686004)(316002)(4326008)(66946007)(66556008)(66476007)(41300700001)(2616005)(26005)(83380400001)(38100700002)(31696002)(86362001)(8936002)(36756003)(8676002)(6666004)(6486002)(2906002)(966005)(6512007)(53546011)(3450700001)(478600001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnA5WFN4bnJCSEpWdW9lRTNZZGt3Mmc4S1BKd2FESzhBS0hFM3NTMlVPWThh?=
 =?utf-8?B?L3ZLeDlUQ0lNSG1lL0sxbWlyaVhxYU45Y3UvUnhsYk9UN1JmSFlSVHQ2UHFB?=
 =?utf-8?B?QTZTVGdaVEVJZHFQUnhzaCtRVUVVaEwxWCtJcjNvSVM2SGNRbk0wTGEvSjR6?=
 =?utf-8?B?ZGZ1VkZOMDhHY2RWdUE5NFdOMXRxNzFhbHh2U2RzM2ROUndYbnFBTkd0SnlY?=
 =?utf-8?B?TDNTTGVhQ0hxNEs3UVAwV05FbFM5L0FYM0EwVlF6VVRFZ0w5dXZoL09sV2Na?=
 =?utf-8?B?QUwwc3pvWXFpakplM1NPZ3o0SERkVWFXTjJRZmVvUmtReEx2SkJUZnVtNTd6?=
 =?utf-8?B?VnBmVEZHZnlvaW9MTlNDT2VBUjBTN2pZRThaUHQySE5oNXFCZG1MSVIwSWJ6?=
 =?utf-8?B?QlhEOGhwUllnTGNITlU4ek1WM0dweTFpcGMxTC83VHNPWklzODFpZ2lqeUZq?=
 =?utf-8?B?TW1qUWtEOEZCSFI3MThYOFFpc0VKQmtWM1ZQZFl6ZDNBNk94cVh0c2VUMEt6?=
 =?utf-8?B?d1JSSmdIZ2FKM080T3QyVkxKVVZja2c1YkhVWVQvL0w0QWJEVHFNNjcrVkh0?=
 =?utf-8?B?SGFzY1B2UjJESmFmYXFObG9FZ2J6VnpDT08vYUhLV3lHREF5TU9UODlvVUE1?=
 =?utf-8?B?R0FhZm4xWnU5bnZRdlpra3ZGaUZQNU1EVDNIeDJlT04vSXJFQ01iUXBrNWxu?=
 =?utf-8?B?T1MwOTJyQkJQb1UreEJ5RjFjZTV1ZFFGY0pIM0I2bTV6dWsyeVdNb0dJbU1H?=
 =?utf-8?B?ZGEzWFJNejhXL1lqVjZPNlZDdjRVOHB5WDV4S1FZS3NVRWN1c3VpQUZEaFRW?=
 =?utf-8?B?Y2JvMFRMUHRpTTI1VXJHbDdGaDJlcnpNNm0xSkJZaHlDUDJsSXkvRVRORDRj?=
 =?utf-8?B?Mm81Q0FDaTVvL0RlOEZnNDcvVE9qRFVQcU1jZFlZcWhPcVRZWnZUV0xlOVRr?=
 =?utf-8?B?TWFsRm5ZWTFHVEZCV1VCL2RNbTQ1bnZTMnN5T0UwaHlrSzhVMnNmeW5Nc0Ro?=
 =?utf-8?B?OWdlclJMbnNudG92STduank2YzJ4bm9EZmlVMUlVRDNUSEZyVVdPM2NLTnFV?=
 =?utf-8?B?eG1NRHJUNkgwZGVCMnNvZWxrdnFFSFhBREFCQkFkSkhqQkJSdCtOSngwckR2?=
 =?utf-8?B?bXlyZnZQTGFDdGlkTkV2emhvcFVONkZGV1pKQ1lIbUpVRU81Z2d1RHdDMFdZ?=
 =?utf-8?B?VFFuRDVpN1RwY0JSako3cEFVNTdhMHB1eWxjU1lQSzY5TndIV2Vzakhzckw4?=
 =?utf-8?B?anYrVTZtY2VEcGh6QmNVSytVTzhnSlJ3aTJUN3N2UUxSSGpaT2prV1dobXJo?=
 =?utf-8?B?NUg1N1QvN0lXSTBaNGI1aHVJQVlKWnluM05tZE1LdUUyU1RHWU9aUmNpWnUx?=
 =?utf-8?B?YS9vNUIxSzRYb29TcHBhRUx0OW9KaWtHWDJQdUFrckx0dWFGeWRRRnJ0Y1kr?=
 =?utf-8?B?YUhzN09Za1d0d1lvMEVNMkpkcVl4MXRVT0x3UnFnd01ZQjRmUFRLNko2N3g1?=
 =?utf-8?B?dVlSZEc2aEhzOG5BTHlaVW80VWRDeEczMVFyZDE5ei9ObGdlQkphN2NXQjNY?=
 =?utf-8?B?UWlIQUxkaGJZSCswS1pGT0Vnc1lucU9QTFc3NXk1anJ2OWY4YkpwNHM5OHpn?=
 =?utf-8?B?a0JtZ29RaDlIVmRLUzhSREVIZDEvOUt4cElIQjcxc3NJcElBSEw2dFpkWUd4?=
 =?utf-8?B?U1BodlBQTGZDNGZGY1NKS296K3o4TVFXd0dhYjhFMUNDS25PNHQ2Mmg1dkNG?=
 =?utf-8?B?aTFNUUtSeVhIK0RPUFkva1h3ZUNEbzhRU29SR2Q3QWpQWnJ4TTgyYlMxTWR6?=
 =?utf-8?B?SzN0aHd2N1F1MHo1cUFsQ2FPbUEzSWxBNlkwRE1mL09pRUdNaU9hQjlEaEhU?=
 =?utf-8?B?SlRLWjlqanNyOTBtTXZXNERYZnVnTXdrS3cyZFZCc0RhUkFiWEF6L0FEZng2?=
 =?utf-8?B?bk9WMXN4em1zMDk4VU1jV3ZHUGpzdElhTE1IMTB5ODNVM05Fb3RHQ2lVSDBH?=
 =?utf-8?B?a20vY1NaYXpSYnE5bnc3MU1qMFFWbGYzMVNjWUN2M24xRHExWXpXalNDTzRh?=
 =?utf-8?B?OEI3UzNQMEpEdkkvU1VVWHBDeTlsUVNvdUtTNjF6Z25UcHhQdFdRaHV1b0xG?=
 =?utf-8?Q?rPJgbX6/djtet7hbi2EAEeagf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0c7aaa-e78b-48bc-a72b-08dbf5bd60bb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 18:09:52.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbthrmADU8gA3u/E0Uh7MuKO8cytABAUi4XbgoB8HcAw9Tpkv/3DfSSUFbGl+9wF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 11:55, kernel test robot wrote:
> Hi Babu,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on next-20231130]
> [cannot apply to tip/x86/core linus/master v6.7-rc3 v6.7-rc2 v6.7-rc1 v6.7-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Babu-Moger/x86-resctrl-Remove-hard-coded-memory-bandwidth-limit/20231201-090621
> base:   next-20231130
> patch link:    https://lore.kernel.org/r/20231201005720.235639-15-babu.moger%40amd.com
> patch subject: [PATCH 14/15] x86/resctrl: Add interface unassign a ABMC counter
> config: i386-randconfig-013-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060120.q62q2ha7-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060120.q62q2ha7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312060120.q62q2ha7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:195:6: warning: no previous prototype for 'abmc_counters_free' [-Wmissing-prototypes]
>      195 | void abmc_counters_free(int counterid)

Yes. Got it.  This function requires a prototype in
arch/x86/kernel/cpu/resctrl/internal.h.

Will add it in the next revision after the other comments.
-- 
Thanks
Babu Moger
