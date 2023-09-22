Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C137AB522
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjIVPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjIVPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:50:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819F122;
        Fri, 22 Sep 2023 08:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFnH+G0WMEzMdAPeWDeA/4JR/QdWsAjU/NNnL4/LIgZeB73gbhwbZqEgO8h12jtag7ujBGPBI/thDnMUi695msh8SsOeQORSOtE2/64Hq6DyJhzqTDfeNdZs6ZllGFstCOeNHn7PRHvACimVvhr2bEleCi9X1iv9/Hjd+6rmY0ejjbO8KQUzhJEtd05w8wRc5I31C629Kba5Yr/jWuXUVdx1v8HOKIK0XvkEwGlltiaUZdOVgI73D7n4gcgpcVNIyqcJwJlScB/xKvGnXhKfkMKT2Jayz1F2wOzxY9FeUXl/aGgsez6J4rGmrk0oSkus7EAaTPhgpE+6fNkJKSMAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiGHJdESJcBO19/1vuxeOg+jHN36hh1LOGeHV/zE9jg=;
 b=CHm08/avKHz/BmVoRI4QWQ0kdjMSXIAnCYEHdz7YjJQjcK09qF1BmnWGIlpupSEarnhv9Wd0a1IbF45no1ySXGyCkS6fKrFWJ3xdb+S48+PGzXB65PpjThvXmXpVkfjwCPUgqXtVNIMiFMlVKsQcHra/q/uE9j06tY8Z/Vm0AzwWRFnxUT+IJ5kQZBBVlBFuUMQYMaqV2+oorxPQNPJ2NsZzwik+NlOc3Kh9yXAdNvvklIKIQMaJGmSPAkmR/48XSn5CAN811ears9HpSPWOQG1MNFwafexdsrsKdPsIL2LNySCMedj/rpsX9rSChWskSC9YgNOpksA+IXSJEs7x0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiGHJdESJcBO19/1vuxeOg+jHN36hh1LOGeHV/zE9jg=;
 b=oQsBeqwCZFexbqPgl10nPirP2b5rLFtVxlUo07L35X+zOtj4Be7e1qQTOe2LSwzlcLgSy8Y5sLONapE1lGopkZbOPqnpeOgJ8He8FvK5nXcaDuR1AibVmC1MYYAxqbmawKXXeXXl62iyyUFHbWeTxE00+AQ5/JUjE0o4Q7l73U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5253.namprd12.prod.outlook.com (2603:10b6:208:30b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:50:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:50:04 +0000
Message-ID: <f28c872d-6087-030b-7897-5d530589991b@amd.com>
Date:   Fri, 22 Sep 2023 10:49:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-11-babu.moger@amd.com>
 <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 169d7f30-5c7b-40f5-98e9-08dbbb839685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTN1Blj3aelCRVTr+M1f8e2Ypan3M3cETCGwwu96c46Y6IkUDJJ2FeqEmEI7JWZA+cqGca1wrQskkTkS1nzkSpk7or544FecvdpRLPIIsNPokgLtIWOgaNFyWMD7Y4yWIeXzg1mJIFlMO28BYOx94rvLW4kKR02j9jZmi8743DtipC01jOz3JC2/IBqnTeJWPXeMjBJnzg5gR27IXpz/tDc0oc9L/UuH8VVw0E0fI6Nk9ub9WC+7Wmy5UVKk1f38Od4w3M037FVwFCxHmlyjPo7JQVZAjHu4x/G0m9P6s8CWm+//dIxMz1oq0QAc+vwkp4ccXkeD94sOVGavGPxUIWWb+yEcQklloCCLAZJhMkbZdZ9ItPwEGVAWgQEkmYZR95x6LWSdHbtIXr5ez9FwG6WBuo5a+VGtsQxgJ5t+pBQpYSpu+Is0AJGNHGSrFQgyQY8SRD1uKp5lBCAb/UA1UKEQuEXjgMj6ecexoybDuLOmT8l0BDYftgSExqlWWbWLK/uZJTGjqGg+EAuIQ+PmUNIzMrCsSMmSrYjg9dfUugwvG80oSjXXqxEr1Cs9qlUoFvu4MnslB6k2y0is2TMp+mW6So0jExg855EsIbWb9US8RHwPtoqJQf9+23MeQ72uDcg0N+Nizek1Z7Pu7d3FHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(1800799009)(451199024)(186009)(26005)(5660300002)(83380400001)(53546011)(36756003)(6506007)(6486002)(6512007)(31686004)(2616005)(31696002)(8936002)(4326008)(8676002)(478600001)(6666004)(2906002)(38100700002)(7406005)(41300700001)(110136005)(7416002)(66946007)(66476007)(316002)(6636002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWNUQ0lLa3NlTC9Ha3g0WXJabUtydE82NUdEMmd5YVZCNFR1TTYzNFlteVBs?=
 =?utf-8?B?RWlGQmJTSFJnNkFudEtLSHZGb2UxME55OG41YVNiYnNkZW5oVnc4eVpZZjcw?=
 =?utf-8?B?OWdySUYwdTZmS3VOb0RCNEtNOVpBMmtBQjRYeTluS0F5Q3FkT3NQWHdabFd2?=
 =?utf-8?B?WVR5RHpia04xb2kyVXJ4WnB4QUcxdnNZWkRKVG1wWUNtODJrbWFvZFJacVV1?=
 =?utf-8?B?K1V0enQzUmZDbDMrajVUSXlqRVRNQ3NmYlh1MTRxaU5NRDVpRVhRMEFlVy85?=
 =?utf-8?B?dlhIUXVmd1h3cWFiSG1pU1dSV2RtYmVYdm1NUk1XdVlSSVZ1NlNpODZLSFcx?=
 =?utf-8?B?Rm5weVB2Mkw3WU5lT0E1RGZrR2tvUVJIT21wbVZOUU1ZNE9xWUVqTktUczgr?=
 =?utf-8?B?Q1JyZ0Y2UTYwVlI1bXZOYjdmWnVXZzhSUTFKdHVKUlJJQ0FON0RwS3FrZm9R?=
 =?utf-8?B?cWM2MWtMZU9jeWx2WXF0WnN5R2F2aFU0L0tLM0cydnFoZElZRXhRdUd4cG5a?=
 =?utf-8?B?N1JrUWZHRGU5YVZZdXVrdGVZaFk5QzBPUGE2R2psVlIxNmdqb2pFeXlWTE1J?=
 =?utf-8?B?NlUwUTFCeU0zYlkzcjh3SXhxRmJGQ3JIcHhVU1ZUdW9BQ1N0R293d2FFaUlZ?=
 =?utf-8?B?eG5USHZQRVpUenRTVTVvNHR6d2xxQnBZenlUbWVLbUcvTEdjeFZza3FCS0ZG?=
 =?utf-8?B?MGJ2QWp3MThxc3p3aFRPZWNTaUFTbkpGaituaXZGZVRGWkdwWGM2Y1ZzMldI?=
 =?utf-8?B?QjYwVDdla3VDNkZLVktycDNDbE0vMmR6UktBVnJ2YTlZc05pRnFxSGw3MXhr?=
 =?utf-8?B?NGZMd0I2a0xQM1Qyc3VIS29yYU1SakNSVDU2UDJtcFgxYWZhZmRoazBvWE1k?=
 =?utf-8?B?bi8xSVV4K2oyR25xa3JIOFZGdkpnRmFmSEZkSlBCOWhiZllkZkZINXJUdlpL?=
 =?utf-8?B?dHBic3NIZUJEd0w1YWpVUmpCV3hLQzBrN1hPT00wbTFaU0V3QnpIZGFoZHo2?=
 =?utf-8?B?dTZ3cnNaZXFTVHh3OFdRK1RjN1dYd29RZFR4UTlIM2drRW5SY1RFZUlnVHEz?=
 =?utf-8?B?R3RrME5SZG1ISStCK0xQaFhNeW5SMzJVYVZKT29YWGtLbnIzQ1pKNlJJOE9J?=
 =?utf-8?B?U05EOVpMWHNIdTNPSzNINFZZTFZhLzg3Yjhpa0E2YS9LTUdiZGJWS3hsYWlN?=
 =?utf-8?B?a0ZpQlpRbnltK1VUb0hKQThpbmR4TnUrMDkvVWZNa3V3b2dYcFV6bVZzTDIr?=
 =?utf-8?B?OGRmTU1XbCthQ2tDR0Z2eVRCSVZMSGRwZGhDQzc0ZE5HMzJ2YkRMVnczRDdz?=
 =?utf-8?B?a1ZaZVBVQSs1c2NpM1NLVVBybEpBSzcybG01b1Z6Y1NYN1Bjb2R0NlJPTGs3?=
 =?utf-8?B?VGRBVmxmSGFlQnVOZ3JYZjBKbktkWWVBYkpBVVNxeFp6U1pPaDNxK0Y5UU1v?=
 =?utf-8?B?c3F2R3V4ZHRYWWtwZGZ4VGQ2MlprWVJENDM5OFRvdzZQYTNURTY0aXEzdVkz?=
 =?utf-8?B?Y1R0WmRSN2VPMXBwY2g2c05OaUR0eWNQRWJvUGhOdlJEK2xUVFc5RnRrU1pw?=
 =?utf-8?B?d05XOWl5bWJhNVNEWkZjZFNsb1JXT3JCRGRIYlRaMWgyZHkzdnVCWGMwOGdS?=
 =?utf-8?B?OW50aEJ6Wk5BYzVobXhqeTRhQ0R1eGJ3ZGN1ZVg4bXZ4QUk1SEMvQlhFbjNw?=
 =?utf-8?B?V3FNL0pyVzhPNXJ2bUZXdVNBRnEzRTVnSU1wZFVqcXYvQjFQa3ZVaGwxM1Q0?=
 =?utf-8?B?REVFc2JrcGxPMFJJaWVpQmdPWUduUVJ2UGlzV0p4Q01XVVlxeDQ4M0tXWDFD?=
 =?utf-8?B?ZzYvUWh6a09tNHhDb3J3ZTFEaEpVTXhqWXpZdzBxMGpDOFUydXVTOHdjV1BJ?=
 =?utf-8?B?Q01GUGc2WGMxNUg0bG1mRGIzVEZIaElxUUpnVmNkOEJWQjYyVGY4OUp4R29K?=
 =?utf-8?B?ekIrbW0xM0wzWmw3YXdjbnEwQ2lHKzRDZXdmR3hzV291MWptL1pzTkd1MWQ4?=
 =?utf-8?B?THBmeGNNSXJZTWdqSzF6Q1B3aEd5bG8zMTYrUFkyUDI3Tm5iUytkMFZ4LzhP?=
 =?utf-8?B?d0FxWXk1SS9HN0x6a3IxZXgwVTZTQVE2WXZmWlk3OVBlcWxnTUNXR3RmOXo0?=
 =?utf-8?Q?tb0k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d7f30-5c7b-40f5-98e9-08dbbb839685
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:50:04.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJykkdRZy3g3vIo5YttDBKYhEz6gZ2a8tXFiAGr6T6e9OPn9CWs/s6PnahvfjJqX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5253
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/22/2023 9:36 AM, Peter Newman wrote:
> Hi Babu,
>
> On Sat, Sep 16, 2023 at 12:42 AM Babu Moger <babu.moger@amd.com> wrote:
>> In x86, hardware uses RMID to identify a monitoring group. When a user
>> creates a monitor group these details are not visible. These details
>> can help resctrl debugging.
>>
>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>> Users can see these details when resctrl is mounted with "-o debug" option.
> When I reviewed this, I went through the whole series second-guessing
> the wording above and wondering whether "monitoring groups" applied to
> CTRL_MON groups.
>
> I was able to confirm that mon_hw_id did appear and had a believable
> value in CTRL_MON groups which had allocated monitors. (and I added
> some comma-separated PID lists to the tasks node)
>
> for the series:
> Tested-By: Peter Newman <peternewman@google.com>
Thank you.
>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a07fa4329b65..b4910892b0a6 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -296,6 +296,11 @@ struct rdtgroup {
>>    *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>    *         Files: cpus, cpus_list, tasks
>>    *
>> + *             --> RFTYPE_MON (Files only for MON group)
> If monitoring is supported, all groups are MON groups. I think the
> "only" above caused me to second guess whether this takes into account
> CTRL_MON groups getting the RFTYPE_MON flag set dynamically.
>
> However, I think the documentation above is still technically accurate.
Thanks. If there is another revision, I am open to remove "only" from 
this text.
>
> for the series:
> Reviewed-By: Peter Newman <peternewman@google.com>

Thanks

Babu

