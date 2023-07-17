Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102407560E4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGQKtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGQKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:49:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164511F;
        Mon, 17 Jul 2023 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689590969; x=1721126969;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kdYQSm9uVDObrCIRFn6u6/QuAbXP+VWBAH3I8uY44Jo=;
  b=J5GHE9zhoXgIDYY8jsyCZy6eOs8l6rVPVnrDu/uXQO2ZBDlxKocnjoAT
   N1uCCF07lTi3Zo7wPXjjcMo+j2IEpQ26qShBNtPKggxdqClKd31xkLJqs
   1hEM+KqUPbr3nsjiGkTEboXv0iRWH1ZRW2vqZ1tC7yhuMAeX8zKr+Xi6N
   YLN/N99d7U/f1aaPs+SDiL0xQcGakjj+XMVGsE6uB3TbNfZDSwwP0UxfH
   l5t/fxnCTdBIyxrmje/ponvOKtfXcFzEfMW24ywnGq3Fp6CIm7lwLUoSm
   qiEj/bn2MWU8s87Is3ISbfs4rkhFwBsAaZcaCjImnSJdbwYxdti2MgHnH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="368541772"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368541772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 03:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="752844938"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="752844938"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2023 03:49:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 03:49:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 03:49:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 03:49:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 03:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiVK2gRM2mETDy1iE/En1PE25X4MuRs47kNi+Cu/S5lWHsNcucnZEGhUdy+6YxYlG+Gx3g1GEfViAfRqwcZ94sdEk9pF6oClKA0/Met8g97avl3aFcuFhsf04wqDZqL3XCYzXE2dYii3aQc4fAIFntS2VSdoYVc96Fbbs/TOvip6TPciqRoW2RDZKReyya5y/N5qGH7490VTDWlEisQI8peTP+GxqBLLXLXNF9GUqgfyURABGd9wrVe7v/jRrhXbvPJbeXN7+C6LifrWS5IQd6zAcr3kPawd9kjkmZCxzKeHMSyf5l+GRNQZJ1YUs2YRXejhi64ZnRT/KbDkCDYsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLcOOCIip63dUiRmrIRzBG5akEf1JmXt4nQTuza0wtA=;
 b=RFROLRSUEk1lumxRFUc5XBdp84vB3dPzCKlzkoVb39tEO+yeRwud3ry8QrvryqZed1fDnmJv7MmRH/PEaQX9OOwnFJzo8n4f168VpPdP1urzs7Sj7wSVacbBSdlf0ydDiKmRq9KIhH3pPZlMaUBdxL0dtrIO3i+qLd8GmKJJwt23lYCICnLQPu9+EVQiUiiyfXhlide8o3vy0zygZfBVG+weC1DuP2EtZdQRvDmDN9waujkcSIp1X4fcSrDkujC4fuahm8+N0NuDxiTaz6IwypqjVrzM51dwl190/Wx6sY9qrT0PQD5oRnDKcfqBDG95aRhZBBamDFSJ35BVsAD3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 10:49:23 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:49:23 +0000
Message-ID: <3849da12-c8b7-ff0b-77ac-48864009948a@intel.com>
Date:   Mon, 17 Jul 2023 12:49:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/9] Prefer using _OSC method over deprecated _PDC
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <andriy.shevchenko@intel.com>,
        <artem.bityutskiy@linux.intel.com>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <lenb@kernel.org>, <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
 <CAJZ5v0iZbX+pV7y=ioYA+OCN=09Ujmjri-JEhYdvUd9VB1BWgg@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0iZbX+pV7y=ioYA+OCN=09Ujmjri-JEhYdvUd9VB1BWgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::11) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SA1PR11MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: be4930f1-6295-4c7f-dc5b-08db86b37b81
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRKTBcwddaOjATbzMI2Gs9btkqho4WQVTbsvNHGsWW0Q3TgVQVb016u6ubQDXUmjY0gIMf9kR1fpklXTX3NEq/XpQ3NsU1BZ4YgslA1twpmi1hnMdYSMF8D5NCIYawrV8SyqknA1cedcIhQa+RvfSzzjwizox5qZx2McKy6YJ1LbQAu9tm+4Vl/JAH4xFZVVRk1nyLaNmtdo86P9pFl+bxR5HY4FVmVUCk2O1swd/AnwF4OzUVxJ59sbXObIxNOCfiOKrMPKNIAH+1Fa9Yvsap+/luAbRAUSuZnAdPgjQ9UvWqVv0tQJh/4S04NdKQ11jlOkDZuq7dfOqSP8gWFz35EBRGkqF72be00DKStUpw/LusxMhb2uYqYO3Jl0ERgEXoHTW+Nlgzmjr7WwiU82MyeRu52RiwG0d8kEiP6rfrxKplwKVV2xlXY7IRfye3mZQM0tfeKdxUt+W/ovJKyZiI3WjMYoubfauhwnuH6k+jHAfjosNRE/BUByzMxKMrP4HqCOlO/lfxLRgfUZRF0jTilN9NBtR/p4mfTGupHveCx/KTcj+26QNfZOCHh+Qabs2bC56anAPT+zDoxD3c6V3pUy1mnIPI0cw5pDjjQmM+g8nSoAGbK6roNM2mmSqHuOoqBSwmd4qBQe/UQ2PXp09w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(31686004)(31696002)(86362001)(2906002)(36756003)(7416002)(6512007)(186003)(83380400001)(53546011)(6506007)(26005)(38100700002)(82960400001)(6486002)(6666004)(316002)(66946007)(66556008)(66476007)(6916009)(2616005)(4326008)(41300700001)(478600001)(5660300002)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dUemh6cDQ2b2Q3aTBlRnJlTlRUWkZTRko2bm16VmduaXl0OWxlbzNpZW4y?=
 =?utf-8?B?YjFPM25LZlFhZ0EyRkpmN2hRK3RpWk1YajRVdHNac1JCaW1kUC92Q2VtREFQ?=
 =?utf-8?B?bGVQZVNWZzIyeVNTV0RySzNqSkx3K3NKcmVucjJ2MWxhYkNqbDduZzBoYVQ4?=
 =?utf-8?B?WXlJdDZCTUtXS0VLako2MUtSTkl1R3MxZVl0OHhVVzNNNUVmN3ZVdGtNR002?=
 =?utf-8?B?WjJ4UG9GOVJ2dE1rd3hCQVYrVXRPeUZXV3ZuR3dCTXAxcjZoMkl4WGRZckFS?=
 =?utf-8?B?UG55VG1vaGY4SVlNbXF3b1hCNGxZaUJOV29VNHpDdUw2ODg2UDhmRllRQnl0?=
 =?utf-8?B?c2FXbEYydVhjTHBUMTgwdDY2TVM3U1I0V3hJWXJVZ0NNc2ZJOGNGbE8rTWxt?=
 =?utf-8?B?SFRlNzVleUVVQlpya05NbU90UGtVcjdXcTNuWWM0bU5tUFhHSmptNnFnOVVl?=
 =?utf-8?B?ZmJWN0FncGxrUWZsbkRLamJ1cnA2ZHlCTDNMeXFMcmROSHZCOHd0d0F1Q2Z6?=
 =?utf-8?B?TVM4Z2JDUlFqMmFRUkpKS3ljNUN4dCtTbGhNdGx4a3VWT2JaQ0NaTm1UZ3VR?=
 =?utf-8?B?OTNORUowTzZKZytUcXNxWjRDdlRLM3BqQ3JtRUU3bVc0Qm1ram95TnhMa2dx?=
 =?utf-8?B?LzB0bUdhY0RpQ3IvV29KMWQ2aU9KdnVXOUVuVFBHaFdqeExSMlRQZDhodVZm?=
 =?utf-8?B?cVY2dXhvWW10ek5QWFN5cEZ1eWEzSHlreEVSeTVVNkxycjV3QjJ2TjFORFpt?=
 =?utf-8?B?UUxSVVJ3SXVRRExtOFZxamc5ZzkyMmpGMDhNN3ByOU1WejlJa0JGUytraUl2?=
 =?utf-8?B?d1RHYnM3RVNjb2Q2T3dKQ29HUjRMNnFwQzdZRGp5dGVTQmI2TXl5ZFJIc05X?=
 =?utf-8?B?VjZmeEQxWlhVZkRHOEhjQkVKMmJOWFRNelMxSFlMSkZiaThxRzYxdU5oMVZ4?=
 =?utf-8?B?OGFMeW1CN2hvTkVxUzkrMk05YitSVk1iQmNlNFExQzgrcHl2cHJQQ1QwcWd5?=
 =?utf-8?B?WmVYRzhGM2lrT29FOFBwWVV0V3BwVUNFKzI3cVM2Sm9HSjk3QWhEWnNBUUEx?=
 =?utf-8?B?RTdwMWhrMnlScjVFU1dWQUJPb2xhc3l5cldTVmFhQUFJSkF0MGY0a3gyNWg5?=
 =?utf-8?B?YWsyY3J1MnRsUStWWlF2TU4ydjM1aUsxZXhPR2lLeDYwNXkyVkJzNHpsdGpr?=
 =?utf-8?B?cnZScCtZNTE5QmpNMTNmNnF2THYyQUJZcFNoNHRkeTA2ZkJTRnVKdTh2OW1u?=
 =?utf-8?B?MHJKd2wzSERmRm03S25CRFhoRUxJV1V5YU40R2cvVzRPcjNzZDM0N1p5K2Vy?=
 =?utf-8?B?ZmdibzJMNGY1QVZEeTVwMExJUkJKSjdiZjdxUEhjZlFNdkxWa0llUTNKRjc0?=
 =?utf-8?B?VzY0YkMrQnNmQnRzSmhqaUR1STRHSTVZMU1NNzB2NXlUN0hCcjF5V3JYenls?=
 =?utf-8?B?SUM1d3NqVTBrS29ZNWNqQjAyaUl2UmZNUzJxR2dwUG1wa3lSaUM0T3lvNjRJ?=
 =?utf-8?B?OGlDKzFONktvMitabWFZVHVnS21maUxoTUREbGIycC9NY2gwOVJUVENUWFov?=
 =?utf-8?B?OThvSEMxOElUbStsSnBOUkNPdk14QXg3Q2l6NndIeWlLTU5lcG91M3NDMWJL?=
 =?utf-8?B?VUFKSkhpcGNFOWh5RVJFOU9ucWcyd0lvekR1WkRSTkpLZ0YzbVFCcjVFN3NO?=
 =?utf-8?B?bEd3enFtdzh2UzhVeHByRGZvd3VOeW9VZUlISnhlWGNBNFhIbEFEWnFVTkFZ?=
 =?utf-8?B?ZVc4NUgyVmpBYlg2N1NtSkNNNmhkSzl4UlB4YWpwV0haTEkvVGVxMkdVWlh2?=
 =?utf-8?B?eUN3VnFGTEMyS05jZGNSd3V5dkt1c0pKL0EwbXFCR0tJeGs3NnZ6Zk0vRmhI?=
 =?utf-8?B?NFI1VDNSRDJ2RlYwZC9vd0JrcTRjNXkxUE1IQzVYV1pNQ2F1MUxMc01TTUQz?=
 =?utf-8?B?dVJRVDRHMjlSQlNxVjE1SjY1OEtWSG83RlBvbmx2aTI3d1dReS80VjFVUmgy?=
 =?utf-8?B?OVJ1ZWVWYlB5MWhSbU1acVFRSzcxQy9ONmtPS2x2K0kzSnVJU0pEVStnYzdI?=
 =?utf-8?B?M0R4Sk9UWHJIaWlxQm1rOHJjQWkvdkpzZjBRTlZ1ZGh2ZjBXWWIrbkhBRHU1?=
 =?utf-8?B?RW5jWFRWdk1rNHY3SFNXUzZFdlU0bEV3RWx3UE0rYnBxOUpRZWdMWU5ONDM3?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be4930f1-6295-4c7f-dc5b-08db86b37b81
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:49:23.4763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25amEITlub7NhPONm8oXyAPaEUhnSN4yQViXncdXTGjmEgQQb+QzVPCTPyWS6czFB8nVch6e5kKblIIpBx1baA0GMRZoPuDg6bU6HGth+rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2023 6:12 PM, Rafael J. Wysocki wrote:
> On Mon, Jul 10, 2023 at 4:06 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> ACPI 3.0 introduced a new Operating System Capabilities _OSC control
>> method. This method is similar to _PDC, which was marked as deprecated
>> in ACPI 3.0.
>>
>> Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
>> case of the failure of the _OSC, try using _PDC as a fallback.
>>
>> Testing done:
>> Tested on physical server with BIOS implementing _OSC methods. In this
>> case acpi_processor_osc() was executed for each CPU core. acpi_run_osc()
>> returned success indicating that _OSC method succeeded.
>>
>> Tested on qemu VM to check whether the code would work on a SeaBios (the
>> default for qemu, doesn't support _OSC methods, or _PDC). This way I was
>> able to see how code behaves in case BIOS doesn't implement _OSC. In
>> that case the function
>> acpi_run_osc() returned failure, which propagated all the way up to
>> acpi_early_processor_osc(). The logic responsible for triggering _PDC
>> execution was triggered correctly.
>>
>> Tested this using debug messages with printk.
>>
>> v4:
>>  - move setting processor capabilities bits into arch code
>>  - move workaround for mwait to acpi/x86 directory
>>  - rename ACPI_PDC* constants to more generic ACPI_PROC_CAP*
>>  - introduce new function acpi_early_processor_control_setup()
>>
>> v3:
>>  - split into more commits to make review easier
>>  - changed "_UID" to METHOD_NAME_UID
>>  - changed hard-coded constant to ACPI_PDC_COLLAB_PROC_PERF
>>  - added Suggested-by tags
>>  - fixed style issues
>>  - fixed whitespaces
>>  - refactored code
>> v2:
>>  - fixed compilation issues on ia64 and arm
>>
>> Michal Wilczynski (9):
>>   acpi: Move mwait quirk out of acpi_processor.c
>>   acpi: Move processor_physically_present() to acpi_processor.c
>>   acpi: Refactor arch_acpi_set_pdc_bits()
>>   acpi: Rename ACPI_PDC constants
>>   acpi: Clear C_C2C3_FFH and C_C1_FFH in arch_acpi_set_proc_cap_bits()
>>   acpi: Move setting CAP_SMP_T_SWCOORD to arch_acpi_set_proc_cap_bits()
>>   acpi: Introduce acpi_processor_osc()
>>   acpi: Use _OSC method to convey processor OSPM capabilities
>>   acpi: Remove acpi_hwp_native_thermal_lvt_osc()
> I have made a number of changes to the patches (edited subjects,
> rewrote changelogs, fixed up whitespace in a few places, changed the
> return value of acpi_early_processor_osc() to bool and made it static
> etc.) and tentatively queued them up for 6.6.  Please see the
> bleeding-edge branch of linux-pm.git.
>
> I have made sure that the series will still compile at least on
> x86-64, but testing it again would be appreciated.
>
> Thanks!

Thanks, will re-test on linux-pm


