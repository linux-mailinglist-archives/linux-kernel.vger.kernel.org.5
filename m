Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DEA7C59AF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjJKQ5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJKQ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:57:11 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA78F;
        Wed, 11 Oct 2023 09:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hopeBAyBb3PVS8A0DpqflJ7xlNLUm9UylZCgfOM//Mazf+d7BZF6R6OzURSkkAwXU95UP6ghKdM7AMCMvR1kw83NaFyoBkKCCmSKcMS8HwepylrOZ/z3ycGz+DdBn16l+eBoUPy92w+H+y0Mx/1F9xI+gus4XhKzgZHu9EjS7JXZdLjcwsqFzjw/YlK4wFBMrVe5uf6apSlyPoeJiZmkxC/lBW7qkWOB6i5SXR9mYuRl7zvbIJJoDHCINj5EcLfHuVLAGnMpFIUZnVz2VCTd7FL007XX2+d1c3LAhhA9i7T9zRl/3q/k0VMfLQf8ijs5hD2ASeziKh5eiqGTXRaUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nuGilboOe5KfHSrajVvM3VRfw/kRTrzvHcJHWvSCYI=;
 b=ik82Z4SMApFSnadvzLQZoV8c52TYQGnL61TXABGioBKG5hPxXv+LWKZ/nvG4VrKPQUxQlzRY97O4pctqoH04jez0ND6kVaxIPaX5Q6PmvsfgtJdLMf7mDk2TxSHUikfSaBiwsiccfpmUaEbUD8qLg7x+WPcME0yatQkaJvlzyDFx8RNFZBjSmiW1N7C/XcpncoKtVxeD7+Nq5ua05MwgHubCP5+dAPMN0XDwgIwxDEUVdHHYEUXXpW25moMJc7pczsNS3YqgBwuFEbo6zrm/0JVq5kP9cAXSH2jMHc9d8t2dH4NLMsrRIQOUz/cMU5+HaMWhyUU4Hw7NHJlqX0wlfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nuGilboOe5KfHSrajVvM3VRfw/kRTrzvHcJHWvSCYI=;
 b=nANs9grhUFwd/cqc20LvEsqTCJMbm56XOHNtG0pHIBzkKclrYqifMHe06S6wenHC4iaN6X0FZv4n8z2+24rVEtHT/ecfrRcanRR11yUu3mmfyex/zbtOvO1ngChnRlqSQoq/CI3xVCdYmxRD4VVG/L6i/5HctnbT8gz3vFBfg+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 16:57:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 16:57:06 +0000
Message-ID: <fa03a5ca-fb16-47bb-a2c8-5cc4d96e54a9@amd.com>
Date:   Wed, 11 Oct 2023 11:57:02 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v12 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231010233335.998475-1-babu.moger@amd.com>
 <20231010233335.998475-5-babu.moger@amd.com>
 <71539687-13cf-405d-bf7c-27480e49e872@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <71539687-13cf-405d-bf7c-27480e49e872@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:4:ad::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b72016a-8aff-48a9-e12a-08dbca7b19c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGZ/ldv/XOvjGIXTVyOuGSbSjzgYCtLbTVG9nlq/2QdnGYok1TzFxnIw633yh/pMCCCDWVw3sCycDNmPCnEAt13y33cSKxP3eAnW4Kvmcj1VoiqFQfCmff0Zx2zclSChdAR5le+ROilw3hRn0vqm8sD9Y7Z9nYZS0dEg0ZHgfl4h3ulHi+BOKwxnAvZNAEQyediAqU7+zTT83FCCJS1opKxzCYt7Tb61zzIjE857AD5xduY1rOtm/4gAutRlj7jdvjq0ksFZBffgwa7PwZ0puY0XZ+avxue9+vGpRlZBZ4C6Fzu/qi9Y3ieSS7RM4YvhiQyXpSKb2Z3iNDqZ/RxwkbUwI05qCgn470DVjMUf4QSxMEopUMmIMWPwjKLA2knRKuq6R0xAZyhUIs+fo8+lXXbTmcLnNJE6Zv1ablLppWaeHItjh67i15H1JNbTLpw07B80LKTTxFAquXlMS+iiGoPoD53AMemRPP4aLKYs2YRPFj1oqJ9iAxTapJBIcVisRpXLRrVCMfrNhswWWeIWWWmI7bHcw6Vm7ggF7nf6OoSr8P6aiXTCGqpLAUfL+rmw/dAjqw8HRx8oKqyYsZBBfvfQT9++Fup+UIi4HOf8JLX8l4Vj4HDhPbGpkMy/nxTYrHGFMkhAbk83B9CuL/Tc7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(66574015)(478600001)(86362001)(31696002)(6486002)(316002)(66556008)(66476007)(26005)(66946007)(36756003)(83380400001)(41300700001)(31686004)(4326008)(8936002)(8676002)(5660300002)(6666004)(6512007)(7406005)(7416002)(3450700001)(6506007)(38100700002)(53546011)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUV6SGgrZXJ6V3lZaGFwZUlKT0VHK1RGY1RYc3dUZ1RjaTdwa3N0d3hYcm1r?=
 =?utf-8?B?TittajdyT3R1ejZCTStwUFh2Z3doaVMrWVJvQkkvQWk4bVZsN09mQVZQRHMw?=
 =?utf-8?B?MkdnRWdmOUpXM1pyMzVaTnlCOUZUK2lQMDlZbFFDbXU4dndHQWhCWnFIcldH?=
 =?utf-8?B?NlFIc1prTVRGWUNkYW8vd0g4dWVQRnV0RmxPT2MyQXE0ODQ4S0Z0MXgzakRS?=
 =?utf-8?B?bDVYQTZwajdKZDRlNHpuZ281Q2ZoNnVLejlxRWJ0eGUwRUdQdWRUL1JESnoz?=
 =?utf-8?B?VnRWMUkyQitQQ0Q2aE1WdWpHL0N5a1RjbFJ5bThuRmJlVzJVMFdnUVBGODFi?=
 =?utf-8?B?SjZ1R05PZ0I1NUxOUTZsTWZPTWVVc2ZvMjkwbFJSNlVheUtwRnVNNFVvSFM2?=
 =?utf-8?B?a1pNUU5Ia3lrNGhoVHBISzFrdEFzVERMZVNxWkNXSjJYTkUrRmduL1VzbmZl?=
 =?utf-8?B?cTQ3VWZWdG1WVWZlR2pPUXloTUY0Y0d5cVZ1ejRGT3dydDM1ZHpud09nWEtx?=
 =?utf-8?B?b2tEcXptd1JGMU05dDNnazlLSGd0ckRZbDFCTEE4WEFnS2lxcFhhZDgvUDJr?=
 =?utf-8?B?VmhKdStYZXNZdU5qZkJFdkM1akdReGlHclJHeGh4cjZma3JTZVJUbnJLUjBQ?=
 =?utf-8?B?V25OSmFiakVVQUtvTURLSXJTOTRhaUptdlNHNDA5cVpXMU9PT0tnR3hyNlNs?=
 =?utf-8?B?Rlh2SXNWaXFsSnByQmwyem5la0MzWmo2R2VLdG1QcU9TK3NPR3NsY3pyK1NG?=
 =?utf-8?B?WStvbTVlT1Z4MXFhOTgyelhLYkdEbGc1SzEwcE80Vm5EN0xraFFna3YzUURk?=
 =?utf-8?B?QVVIMFZaUTVveStWbmd3cnpQU0lhd0Mzd3dpNnBxS2Q1cGhKOS92UXFkQ2s4?=
 =?utf-8?B?a2sxU1VxL1hDSElpNmw4Q1FYMFVIaFZ4WVNJUG1DanVRZktTMGQwQlU5VmxM?=
 =?utf-8?B?RUN5c3I5Zys3cDY3NVQ5N3JiMlF0aUllcnlXSmxjZFJabUM0Ujl1T3NHZ1Zs?=
 =?utf-8?B?eUZSeEtZS2dNU1RXNWR6Ty8rM3VkdmczYkwxR2pTd0trb0dPUUhabHU0TW90?=
 =?utf-8?B?NXhaUlJsKzVRaEY4VlB4L1lVdEZqQndUaVpsc3lwdTRUeHRjZ2IwN09nc0JE?=
 =?utf-8?B?V0lIcVhsNEREVHR3a3RXeDkzb2Q2WXVMSDM1Z0lTY040ZmFiTTR1c25laGVG?=
 =?utf-8?B?ajNnTzZiRE5VT0lqRkZpZXpseHhFSmI5WVRZcDBWU0g5UHRNMExvQ25VSStp?=
 =?utf-8?B?dVdqODdFUzZSQm84Q0NpMFV5UExBbFZSSUt6bmNkN3FnYWExNmh3dS90M0o4?=
 =?utf-8?B?YmNLOVpSTnlnQlV2ZnptbEg2TWFWa1dEMjhEV1VZTVU0UVBLbW9NQXRmKzNJ?=
 =?utf-8?B?cXkyUlBXWGJkSmQ1bGdWV0o2WjRoS3J2SDVHdU11ZG40ak5UOXJoV1RFSC9i?=
 =?utf-8?B?Qm0vQlE4TjBQdmhlL1lUL0U2Q283Y1VoN0IzR2pSTUllcHVVQ1lJTWJDOWdK?=
 =?utf-8?B?a3lqdHhkZHhNTHJDL2RqVEpqZDRESllCVDg3U3ZnUHpvMzhqMEtBbW15OU9h?=
 =?utf-8?B?ZkF5eHpRMlVKWExQZUVXVU11OUlzSm4zVm12aUFHT1Z3Y0ZXbXVRc3JreFVl?=
 =?utf-8?B?UUErR1FtakkzSlNGZkx1QmJmZUhIVHlCRSs1OUtRMEd0djhPbFRuMno5V04y?=
 =?utf-8?B?VW5XWFFxd3RiSmRpUjBMSlo1OW1kQXk5WjNCaVVFNStrNFpadUpmcSthNWdM?=
 =?utf-8?B?aWs5WTk4di9sVGFjNklRcm5uWklDQUtKN0dScnhDVHp0MEttZmc3Zi9DWFIx?=
 =?utf-8?B?b041T2F3a2UxdW1kWDUwcmxrQUJpaVduTW9yZm1EQW1kbFB3UEF6MFNhbnoy?=
 =?utf-8?B?Z3d1elpmM3cyZm52QUhOZHdra1JKWGkzU1ZxVkhuVCtVdm5JS3hNSE1IQStW?=
 =?utf-8?B?Mk1BK1Zwb2pUOXluWkU1emZERitzV2cvSSs4RXpEV1l3aVk5VGo4KzI1cFcv?=
 =?utf-8?B?Z0VxRzhPQ3FIY0FMWGJINnNUTUFhd09Vdlp1eEppalNQV0ZWbHc1WU51dHcx?=
 =?utf-8?B?T2tGRkVvRWFMcmdvQTVrb3FWUnYwOXJCVGlJMlFEV1FiZ0hJdk03WGliZndv?=
 =?utf-8?Q?udJw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b72016a-8aff-48a9-e12a-08dbca7b19c5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:57:06.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dYSdTq6TtCSp17bs9B2yNywVs117lDRQe+sqi54yJCqr2mD9X7iDNHvhhlsbPPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 10/10/23 19:56, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/10/2023 4:33 PM, Babu Moger wrote:
>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>
>> Definitions and directory structures are not documented. Add
>> comments to improve the readability and help future additions.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Reviewed-by: Peter Newman <peternewman@google.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> ---
>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>      to Documentation/arch/x86/resctrl.rst. (Boris)
>> ---
> 
> It seems like you just copied the text to the documentation without
> taking into account the destination's use of reST syntax.
> 
> I tried a "make htmldocs" to see how this looks but encountered:
> docutils.utils.SystemMessage: [snip]/linux/Documentation/arch/x86/resctrl.rst:398: (SEVERE/4) Unexpected section title.

My bad. Just tested the format by opening using the browser. Forgot about
make htmldocs. Will fix it now.
> 
> Please remove my Reviewed-by.

Sure. Will remove Reviewed-by on this patch. Please let me know about
other patches when you get a chance.
-- 
Thanks
Babu Moger
