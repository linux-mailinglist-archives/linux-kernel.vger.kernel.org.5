Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93133805C64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345320AbjLERkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLERkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:40:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC45D3;
        Tue,  5 Dec 2023 09:40:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ+SoHO+fiXtlUFhaOVShhVQM6tzi7r59fcilJ0xeArUMyuemiYEwN1PjglxKszayLTzVEl7dDL7bK6lSPnL1jn5tAMeTG+rbH31XniUGmWb7yAJxRP1FQsmerGYypI4CtACHK5rRejme+A/Tx24tbc8DYkbAeUsCqL0QIyTs1pC/OBs4kb+I7MMgU2M+orwTsL28p5vL6nZvzGF3ob0g+Ej914nZ/aC50CPNJJ1spgM3b/GdeIRJwBalnnIcRRylrIB4TJyNlpXipiBBIPHPP+EqwDa80Vr7+rkNhJ7yCxZbJvL1mHS+xXnltxF6yzmW4xNpXjXHWhFYr4RJ3DH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3XcyhLGk6AMCBYppjyVD1YgtqJRktyRe1udqK3RRvM=;
 b=arqBqw8JjxIFOsub9+KcO4IIb1TrRJuTEydDUwSxnHYALgV5g1Ovk8tVGDd9vxQteZoa03uoApyceDN6GZpLzIxx2rXAulzHe3+8UFfqLgSWazB/5BRlH0BAtBjRk2d8o4A/iFb8i8yHxII04kGJatiVgyzchnJf+en842BPBQK8ypFr8/MgWcKh/X2zNqv0SLuTu6O1bJa9z+2uIOAUpmuKoBI/cCTqfnwQoshxhNEnO8YDUtOEoWsdkzndG3IwcMSWqBP0N3cqjlwMKQA9VQ3GCwuL1rU7jndAkycqUAbzQzl4w3a92UoSA3RzVfXNnEnhUskay0ZHGaoBw47Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3XcyhLGk6AMCBYppjyVD1YgtqJRktyRe1udqK3RRvM=;
 b=ll+M7TxYnvHKAqqVghbwgIAGzq9Q/fW7WlQSKuMiyZWf/OaMO9/aEiEGE5Iqx8hBI/VYEi1d0BcCXhW2zo9SJvBvIpHxm1S401il6vS0JEFoUtCm0qEi6dWOcTFT5K5FQXulj23IjjgiPdqHMRCn+FlJmZTLQhOJ55RLCSFY3bc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:40:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:40:05 +0000
Message-ID: <c6262fd1-c416-4f54-b021-b25fd381561b@amd.com>
Date:   Tue, 5 Dec 2023 11:40:01 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 07/15] x86/resctrl: Add support to enable/disable ABMC
 feature
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
References: <20231201005720.235639-8-babu.moger@amd.com>
 <202312060033.DCTZ5iG9-lkp@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <202312060033.DCTZ5iG9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f48b162-4846-4f59-b8df-08dbf5b9377d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSGDIBHOL1dVvEM7mAG2E5CakM4mOdydwidYIWOJ4Pej84OatTZ/vli1++LSiMZ0R0FFTf4zkvVatlZwo2VBIqNwjMV868fYBYpvXTsZnagh2MSszkZwkG+FhWpCz54QkJp/F7ei3cZZl1HK7VISiIFk4nsfFuXErbTmUB9sJN25RSl9m246VhVrQqltbkpbZW04+BXrGrzF28h/fbLG6To9dv9+mpCQdFzNO1o+U9sgdssVs1yS+tBp3ItGXFk64TJtxaAnluNxf+jY4g/VNikEHv0X75TxmbhNf62T/egPEKPy0YCKb8MRvsWf90Z4jELEXIgkQ50C+BCR1FfD2FSnbMYBJ4OUYSoMrcjtOaKuDTf5YIyxBFhyhZU05Y4Bve3kCmAqgps8Q3XXN1oIb+O7EjOUo13M4mNS/CYTh09GXjVPTv/Q6cSw5IzOyXyQENVV/0AyOfoUN+Q/4lOZx2q3l+7aS2oetqwkz8ATYmqOyB7juchLI2qj82MbSqqjZ5E0W2uuU8qlQ5u5gjqTv8KkZAvgpJ9zEkEKGQ+AZAdn6+Zreq/0+HNHaRY9M3pspRmCiIRBndtvpJRRk8+w8X4ayZkfZMoZKEnsakM7wgSEx2TgRof/AXXYVFeClslhbReMec9LG8C27PWlqSYjivuc+pFoOndXtN/RetgKEAg7Q/KItIclefDXecBQleI9EXCO7QiGsw8immHYVywusB4vXPlsWTWDXWy7C8jbc04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(38100700002)(41300700001)(36756003)(2906002)(6512007)(26005)(31686004)(2616005)(3450700001)(7416002)(6666004)(53546011)(478600001)(6486002)(966005)(5660300002)(31696002)(86362001)(66556008)(66476007)(66946007)(316002)(8936002)(4326008)(6506007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2NZd1k4RDhtZ0MwM0hzdTZhL01WUXVHRjluYlpxenJMSkxPUFFPZ0hIRzY3?=
 =?utf-8?B?ekw1bXRJRmcxUkF3ZXJKaXR2SGl1UUVDcituZUxFYkNWbHVxQ25Pa0cyNlFP?=
 =?utf-8?B?bndyMExaYjUxYnUyYW45TUZ6WS9iVkNLYWdNM0lpWnREbDVDUjNMeXN0SFZO?=
 =?utf-8?B?emxmcDh0UGVQSVoxVTAvazhlZDdyTkZTSW93Y09mVzFBVWpWMlZRd09HN0tY?=
 =?utf-8?B?WVdVcXFIY2Q2Q0xEbFZjME9PSUFJUGRGbW9YRHIvYWxnTmdMUnN3Q0VZNkdL?=
 =?utf-8?B?dTljTkVaSmg0WU1laEpVcXBva0lzSzhzNzlkTmJTNDI1c0tuYWJkeHdxb2dt?=
 =?utf-8?B?WnVpS3kzYThPZmNwMjl5U25DZURpVGJTSW5GTlVYWmRxL3IxbGFnd2MyV1Zt?=
 =?utf-8?B?RWdNL2F1V1g4YzlGcDNwZG5TS1FwUmdTckE5VFZZbWtOWVNZcWNsTmdTSjMr?=
 =?utf-8?B?WVBlYWVzbU1ReDJJZUQySnNVNnRiQjBpUG9rWW5qN1MyVWhMdWxYRS9ZK2Jw?=
 =?utf-8?B?eWFERzM2SHljbExVL041VzFHdm9GUnZWL0s2blRJMFQwVG1PUzg5dEhwdFdZ?=
 =?utf-8?B?bkJKUFhvNDh1TitaenJ3NVM3cEFURmpnQkJjaGR1NnFOWkhWUFZRQTN0SE4z?=
 =?utf-8?B?QXN2M0RZckQ4ZzlaQlZHeDcwUytqSHhQYWRwbjdHOXBWSUMvbldqams3aEsz?=
 =?utf-8?B?TXpNY1RXVWdpNExJcnljVVU3TXArS1FENW9NaHN3bW0vRlB4OGRDWTdqU0I1?=
 =?utf-8?B?UmtqQ085WXl2QjVkQ3R5WTVid1pROThVcE03N08xZTNuWldDR3VqMlRYOGhY?=
 =?utf-8?B?MnN5QTZZSEZsZVZVRDAyc3dVRlpCSHFPUTJzUklIMEJrRzFBditHNkh6YklQ?=
 =?utf-8?B?WjhzR2NkVmRrOXBSdXRoQVdnM3FCdzUzV29TTGwydDNNZy9VQXBNMC9zTVVV?=
 =?utf-8?B?dHh3OXRpRjdaZUQvc1pIeEEyZ2NpaTJ6a3pHSmtwditVMXM1dXlDbUhFRVZt?=
 =?utf-8?B?aVo4bS9Qd0hNcllvalNpd2NkVXJUNmNLWEZlV2owSWtkcjV2QVBvTVdxM3lh?=
 =?utf-8?B?WkllRThTMG1ZUUhaazRna2FjczY4TnJFcUQ1bElpQzAxUi90ZUNWcTJubTRT?=
 =?utf-8?B?UkpKYURpY040cjFiYVZyVEJUSkY0NnIrSWtidjBPcnE4UXd1RXYxVnJIa0Vu?=
 =?utf-8?B?a2xQS2VWNXZFK0VWamVzTm9pWjQ3WFFtRVE2T0d2VWxmZk1rM2FzbWRYOEc2?=
 =?utf-8?B?bXlwc2lMbWVSdnA0L2wwQVF1dnI0RHg2TDhYZ2haTE9BM0lRc3ZHTnVlNUpq?=
 =?utf-8?B?V0Z6TVoyZ2F3TmE2WFJQZVV3VS9nZTg0UE4xYlkvLzlTRjRreHdTRGd4VkJW?=
 =?utf-8?B?bnM0aTBKWUV1OXB2bHpKOVJwU3hRZmZtajZEd1I0a3l0cnhtMk1SK09oVjZl?=
 =?utf-8?B?b0gxbkZEUFFCWEZkVTJDNVZQYlNyNmMyc1RVbC80NEcvNGdLbVlvcjlHVlpH?=
 =?utf-8?B?TDBxTGhVSVlUUjNVSUFiQUZLWEs3L3QrZkNNQnJFbjZNeTgzQ0NoQ1JSeGZF?=
 =?utf-8?B?UTlsWWZWMUIxY0pjTGZ2K25LOWtLRFEwM2xEaHF3ZGlOREY4TCtVdVNCNGhh?=
 =?utf-8?B?dnJ1d1ZoVlNXN0FpbU9QVXBqcktPRFZYaXNQaW1SSlRiVDVreE9BRHowcit3?=
 =?utf-8?B?T0ttRm54TTFmclhJOUF6bTlha1IzK2FlcVQ1L0owdXhZRDJDRDljWmdqV0xC?=
 =?utf-8?B?NzcrWjFCNVlYa0lFM1cvYnc3M2RtLzlrMWNSbW5MMDlPSy9vREMzN05NeS9t?=
 =?utf-8?B?bDhQd2ovY3NLODdMQ042TEZ3NGpSa3hiMnpHTGJxK1lHY25ITm95YnM4SjdI?=
 =?utf-8?B?SmtTN01CSFk2alZ2SklObUJwZlNBUVBZV3A2dDg5N0h2OUZiOUNid1cxNVVU?=
 =?utf-8?B?SktIRlNvcVM2OU1uUnBlbGIwWksweFZER3J6Q3hNaHUydUtyL3RBVWxROW9w?=
 =?utf-8?B?b2QxaWxhVkFmMnJXM2ZmMHBZakFzZUpOb2JZb2RZOW1sT1FDaTEzcXRENjRh?=
 =?utf-8?B?YWZnK1NpRkNObC9YN0F5cjMrKzVIeHo0TlVVZHZuTXpTV3JXbEtuMkdxT1dZ?=
 =?utf-8?Q?ZUN0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f48b162-4846-4f59-b8df-08dbf5b9377d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:40:05.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xroBWhat8r6XAMRV8oeqW78GXJ8peWvaxtSfVR+N/IlR4qTCR5fhyWt6AK85cstE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 10:48, kernel test robot wrote:
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
> patch link:    https://lore.kernel.org/r/20231201005720.235639-8-babu.moger%40amd.com
> patch subject: [PATCH 07/15] x86/resctrl: Add support to enable/disable ABMC feature
> config: i386-randconfig-013-20231202 (https://download.01.org/0day-ci/archive/20231206/202312060033.DCTZ5iG9-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060033.DCTZ5iG9-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312060033.DCTZ5iG9-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:2419:5: warning: no previous prototype for 'resctrl_arch_set_abmc_enabled' [-Wmissing-prototypes]
>     2419 | int resctrl_arch_set_abmc_enabled(enum resctrl_res_level l, bool enable)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 

Yes. Got it.  This function requires a prototype in
arch/x86/kernel/cpu/resctrl/internal.h.

Will add it in the next revision after the other comments.

Thanks
Babu Moger


