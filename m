Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2D80B006
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjLHW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjLHW6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:58:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1821173F;
        Fri,  8 Dec 2023 14:58:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7d4sVvNm0SpQ43UwyVCBSOi331wgQ65S0YOl0Bqip3os8acomHlurf+msbFgwfjwWuN3V1nLlZkneZkirJATu4xU1Bsobo0kJLhng6XsDgdwL+yDNsveQi5U2vRu1DhlQGFF9XpNVpyNy/8/CZdVouSXSusgbSMSOx4QFU9PM1b++SQdQmKU3UuSkT2J39KUU1nY/aH4YkQWO9d0UxFXTVQVX2LJ4X/DwNufqdGzbbEiXpsuuZISGIunoDaLs9e5m11CileEZZuqxfDnAf7ks9uTGrveiCymcYlePI6KzSoUfLfoO6ZtkXN+AEk8O09fhRvELz1hruKshHuCOT/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYTaAPu42FBSALVgmpzzY1MgSk+q3YL4Wsg5WklQ3Bk=;
 b=ZhLt5SKIeRpy8M7yztI/+b9FyIMIL8kpaZM/xAP3xJMpmVbUz5ZYlEmCQwYTtGr3T/S8VH+f+S6bfB4AWMQmjVj+75pJQwGpRTaEFtL49ZzZlYgg4j8jGhdE9fli1VA550eZOgiSzmo3LyabmkiMJkkAs4CjY0zmptsBgikoXkF6phg7PvQZJdNWnYHeYLVLS5Kuh1fu7l0HHLA9hci2LHsR+sRO2zx58r7yrYLB78ZgKDpJhee5i+127aOtjph6RTYjPAlZgv6UuN0TPG7SaEd1ko2L3cZuUbaui/KjLWxOXV7ey3+K70fYV0XokhfiRw47zdXgqbGyEBIMCHQNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYTaAPu42FBSALVgmpzzY1MgSk+q3YL4Wsg5WklQ3Bk=;
 b=HmdQLYcClgTv9JyzO+OsCe7g01w20jN6OXu0B/kcH1LTVwAi5nbg+Tf7PiP8/HS8rt3gNfxDUQYBctF2xgBkaYHGUO3Fzuk67EgNICD6AWMqJ6QlpVW+p9dSiubklDsGgeE92zOMBxLXQw5CtX/rGdHJuuDbWVc/Gc3U5GduexA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 22:58:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 22:58:39 +0000
Message-ID: <33bc1cee-c909-4d54-a9aa-2b4c0257959c@amd.com>
Date:   Fri, 8 Dec 2023 16:58:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "jithu.joseph@intel.com" <jithu.joseph@intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "Dadhania, Nikunj" <nikunj.dadhania@amd.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "maciej.wieczor-retman@intel.com" <maciej.wieczor-retman@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eranian@google.com" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Giani, Dhaval" <Dhaval.Giani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
 <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
 <5ce67d8f-e207-4029-8fb3-0bc7deab1e9f@amd.com>
 <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <390bbb7b-e709-4290-9bef-eed373e469b2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: d35bcccf-66f5-45bf-b38e-08dbf84137dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76eMwHx8wis4xGfZvhTl7tP7EN+t25yBWOsEtwH3wYg9+ak83rs1UZNIrPDWAqMT3XNwtWzzK6Wv/SKBveJT4kl5Q/TmsgEWhdQZgrNV2ikygAuLeLASJ5WYbY0G4D2QTz7Dzw+ywFhACYyCXmObqKEfzSu/nnamIwjx40GI+V6utk5Oy9PWGD717RgjUdU+PhRR19+gh8JRWZzuRZmYKoySqyGmKwnRlB4+TUo8O3wNbIpBykdMY5zvUjEtMbAPUI2kyHSh4rvuas28foouVPN7za4VYyUtyzmiyKhCtq03qvfH3QK4GGzoTE0WZdapu9ONw2uRg+Ynk6WXNNla3aeOBNWjobRfPZQVIk8l/+wuJ18JwKqwJ+LphRsFmjJHXu5xBxWMx7mPx1dloG+N2h9ErRE2sLnesgSutKur0dCVfONEXv5+7aFmJsZqkwh8JMHirnkzeR9C5iArF2C2h274+Cn2fJSdU8Jz40sOJJDSuvn/uI1yfnZlztO7Hf3cI7Gkk4Gyq45vhWMkAYU0gfma4+b3sNTZ4XdGXuEdzRR/he5FpyZiBCJgjTsRje3bfFV9p0WCMC1zIVVLhtb5cgg+vSN7HnXaMa582UomCyb92kovfioXckfKfi6xYk4LFpawV5V1XSJdNQaYJUdHzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6666004)(8676002)(478600001)(26005)(6486002)(8936002)(2616005)(38100700002)(86362001)(4326008)(36756003)(6512007)(31696002)(5660300002)(53546011)(31686004)(6506007)(41300700001)(7416002)(316002)(66556008)(66476007)(66946007)(110136005)(54906003)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzYvdW9iV0RUQVBoL01NR2Z0WEhRMHZ2a1dHL0lUNDJXemMvakVGa1RKOHFN?=
 =?utf-8?B?YkVsdGhvMWI1UlBRZmtNSnpkOGtQQW8xWHpQUC9hT0ZSL25na282ZHVkS2N1?=
 =?utf-8?B?bTAzUVNpZlplSVU3Y2lhVU0yMmRXRkNEMnBpYncrRlE2NDBTY01NYkFrRDV3?=
 =?utf-8?B?QThhditIOGIxM0FJdVRvVFhMUWZQT0pyZkNJQ2FDcU8rU01IQ0hBaEVtYk8w?=
 =?utf-8?B?ZERPUFhFZFJIeU1WM2IwNTZVUWxXN1c4UEhuWEZlQnp2Tm1JVk1EMDVSS0pr?=
 =?utf-8?B?N1RzSTl5ZjdRejM3KzVocW50K1JEQVVZOHIzTFYyNVZWVnRaTTJlQTJIbDlz?=
 =?utf-8?B?UDJVQjFsNSt0bDJ4ZlNhelE2Ky8vb1hTZWhpMXFQbzliZTZvN214MS85aEpv?=
 =?utf-8?B?VVdSS2VkQ2ovOW9LV2diaDcydlRPSXJwdFhZYlRrZENNS2xoWUFYRDFhQWh1?=
 =?utf-8?B?WTlFakJLcnVyeE03NGZYbC9EYWc2YWMyL2V2RzdhV2NQRHlMSXlkWWh2TlRs?=
 =?utf-8?B?U2txSlo4akd6M3dUYUF4OTVHV0tQNnhhMFZudlhPZ0JnN2txVnVVajlYdG9D?=
 =?utf-8?B?Y0N3Q0Vic0lGalpRVVc4N283OUZVRkZMVytQZGRZNVZZMXRoRVdFMUd0NjBa?=
 =?utf-8?B?eHh3a3hsSlR2NWt5blNiQkR6bUN1Vk90bWNTOUJybDhGcHBCN3U5ZVNZdlp3?=
 =?utf-8?B?TEdQbnpQNEkvRndaQ1REaG8rUmRQcll5d0ZEMFNaVEZaMVVubTRVYzJicWZO?=
 =?utf-8?B?K3cyVEV5amhKblVTRWZMeHJwVTZsTFN1MFYzbURjMUY4NWdDT3VBdjBHQlJN?=
 =?utf-8?B?MThTM0YrYW1KRk9HR3RJazc0K1I4QkYwa2IzU3VBdWtYVXJoSDhPampUS2xC?=
 =?utf-8?B?aGFIUlNIYkRCeEp2VHY2ZnQxNFlpZnlYOWRTdzMxT3JvckI4bU1RUUVreFJG?=
 =?utf-8?B?RnZOL0NTS1VpOUdOVHh5SUNLdVZlbnBwUkdZWjRwN2dyVE9kaHkvODdhMVFZ?=
 =?utf-8?B?aXdaeEhxcUY0SXRWeGVZQjZZU1NmcklERHdYWGV0aGRRY2gvUkZjcFNHY2FH?=
 =?utf-8?B?dkhjZUs4WERPellOT3lZMVlxQXlxQzdZdWVtblQwQVB3Q2o3T0gvMkgvTTU3?=
 =?utf-8?B?SzBJTlo4TkZGeEhxVS9lcVE5bDRBZDdRSXZKcE9kYTVsYWdFZGhJa2owbmtq?=
 =?utf-8?B?aDROeU1uTVJQR2xkTUZibWpNZWR1SjR1U1hsSEFrME9PNDBhVm8wZFV6ellt?=
 =?utf-8?B?ZUZLdWZSc0lCMFFFM2hqUnhMdTNPd2dZOHVBeG5FOGlZdHJIdFZSMklCZmxC?=
 =?utf-8?B?cm9qQ0ZQMUYrLzlSV3ozU1pwUUVtUmttTks4ZWQ4YW40Q3VHQjBRMlNOYllh?=
 =?utf-8?B?dXRHbkxiR1hDdE9JT3BiZWswcmI2LzQrSlVPRHF5ak9jdGRmYkkwa2d5cUZJ?=
 =?utf-8?B?ZURYVTYveHF5cXJOVFdEczA1VUtiYnF3Z1g2eXA1dC9McHM1RVZhZi9KV1Nl?=
 =?utf-8?B?ZkdvalZldzZocVVubVUyV1NISllFbDZHODIyV2x1blRrWDBvTkZqRXVHTmpn?=
 =?utf-8?B?M1hSQ2cyTFdpcGZoa2R0bHFjWlVjZFdraWFVajc0eCt2cHBqaXhqeit1cDc1?=
 =?utf-8?B?RjgxTXpBamZBYThYbyt6Z3FmL29laU9nc0JaK0pNbFJMWjFtZE1ucEVQV1Jz?=
 =?utf-8?B?UWhTS0kxSUpRVEZRcjlDOXpremlOaGs2cURDV25zeko1K0lrNEo3bFJjQTRs?=
 =?utf-8?B?OVl3b0ZybmV3U2RMTmdCR1pVSU40aHRJRzZKOWNKOWowVDNQQXFyYXNrUno1?=
 =?utf-8?B?SlA2ekVpUy92UVhFK2p5VTdwMmN1eVE3MTBEMXBHbXZENzRFd3B1cmowaG5I?=
 =?utf-8?B?SlZHa0J1dXR4ZlJPNjFXZEpJb1pOQlR0M0pRTjJYWCsxcG45Tm1ZdlNhTDNi?=
 =?utf-8?B?ZjhGRnBKYnFpU2JVZmRMZzE2R01WRTlNcHkzSlEvd3NodDlvdTRjeERUSmdU?=
 =?utf-8?B?VnRQekYwemI2ZW9TRmFMUzExU2ZxOVREMW5FNjh1LzJvaWtMbjVVaGlaU2Zo?=
 =?utf-8?B?Ync2R1hMbW01cFR3T2t1d0x4SDRSZ296SkR2TkJqL1hRaU54RTk5RmU4VS9a?=
 =?utf-8?Q?spjk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35bcccf-66f5-45bf-b38e-08dbf84137dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:58:39.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgYJDs/zlDfY+Y3eKBJphWVvn1mccLYvr/iGQmC3niNDtB2sg52Ke+BOuoeHDZdi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette/Peter,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, December 7, 2023 1:29 PM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> fenghua.yu@intel.com; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; dave.hansen@linux.intel.com; James Morse
> <james.morse@arm.com>
> Cc: x86@kernel.org; hpa@zytor.com; paulmck@kernel.org;
> rdunlap@infradead.org; tj@kernel.org; peterz@infradead.org;
> seanjc@google.com; Phillips, Kim <kim.phillips@amd.com>;
> jmattson@google.com; ilpo.jarvinen@linux.intel.com;
> jithu.joseph@intel.com; kan.liang@linux.intel.com; Dadhania, Nikunj
> <nikunj.dadhania@amd.com>; daniel.sneddon@linux.intel.com;
> pbonzini@redhat.com; rick.p.edgecombe@intel.com; rppt@kernel.org;
> maciej.wieczor-retman@intel.com; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; eranian@google.com; peternewman@google.com;
> Giani, Dhaval <Dhaval.Giani@amd.com>
> Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning
> feature
> 
> Hi Babu,
> 
> On 12/7/2023 8:12 AM, Moger, Babu wrote:
> > On 12/6/23 12:49, Reinette Chatre wrote:
> >> On 12/6/2023 7:40 AM, Moger, Babu wrote:
> >>> On 12/5/23 17:17, Reinette Chatre wrote:
> >>>> On 11/30/2023 4:57 PM, Babu Moger wrote:
> 
> 
> >>>>> b. Mount with ABMC support
> >>>>> 	#umount /sys/fs/resctrl/
> >>>>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
> >>>>>
> >>>>
> >>>> hmmm ... so this requires the user to mount resctrl, determine if
> >>>> the feature is supported, unmount resctrl, remount resctrl with feature
> enabled.
> >>>> Could you please elaborate what prevents this feature from being
> >>>> enabled without needing to remount resctrl?
> >>>
> >>> Spec says
> >>> "Enabling ABMC: ABMC is enabled by setting
> L3_QOS_EXT_CFG.ABMC_En=1
> >>> (see Figure 19-7). When the state of ABMC_En is changed, it must be
> >>> changed to the updated value on all logical processors in the QOS Domain.
> >>> Upon transitions of the ABMC_En the following actions take place:
> >>> All ABMC assignable bandwidth counters are reset to 0.
> >>> The L3 default mode bandwidth counters are reset to 0.
> >>> The L3_QOS_ABMC_CFG MSR is reset to 0."
> >>>
> >>> So, all the monitoring group counters will be reset.
> >>>
> >>> It is technically possible to enable without remount. But ABMC mode
> >>> requires few new files(in each group) which I added when mounted
> >>> with "-o abmc". Thought it is a better option.
> >>>
> >>> Otherwise we need to add these files when ABMC is supported(not when
> >>> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
> >>> enable the feature on the fly.
> >>>
> >>> Both are acceptable options. Any thoughts?

I think we didn’t conclude on this yet.  I will remove the requirement to
remount the filesystem to use ABMC.  That way users can move back and
forth between the modes without having to remount. We need to take care of
extra cleanup of states(data structure) when user moves back and forth.
Hopefully, I should be able to take care of that.

Thanks
Babu

