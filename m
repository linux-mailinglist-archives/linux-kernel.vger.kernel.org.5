Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C41079D7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbjILRjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjILRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:39:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152CAE59;
        Tue, 12 Sep 2023 10:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kuuk0Myz9lWPScv1sPIT534zxvhYJ41Exg6M4sTMPBd9fOG5DROzaaHIKXXayql3qA6xxLMXcNf+Ez/YNYrNf78TZzlqdkWfVzOAYvZBla8VFFEgMyCcpEdSeU6LNSNnOrVVtc74EoMOVor+pReO7sTT1dqjXeMh75M72uFEod3lh1DWxO17mjEhAfEdydaFM3stb1fPt7x9W6f2taIBzR/LQCTS6r/tc0+/5Bfvk6Zw/VF0CVpt27hHJZruTvHTPyC86y9bW1jOVq/qchvAU58ZkuNX4S5AAgdqDTr9g/DJchPObjOsGQCmwqGjK28XMWQlxN5WkskydhEdOv1Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuyXbec8GPvK+I103pKRmFErb+n2qBINosDVeKghN1A=;
 b=FUyJSDyvjG9t6R3vzHAe8hUzHt/dTEXY+phdPfZow9LBBKLrVwXOZ8My3AgmkWBukPqBbjFOieF+9LIQ/2GQ4JX8FFeD98ypyVqlrCwBNKl2uFoUVsMBsbLV8xpD+0gWtol+naXFFYs1G0epurd08HZ/NMTjrJURLZ1lf9xcrK2L0hyoKHP3xKiFyFkpxCt0fM3E1Ue9CG8uHSyELmunRpT4FClHe4N5o7+5uEcPFAg3zK52Mb+fpwIIi8zW8trzX1VOlKwNxtNRB3MzOzeG3AtcsUMqU1Ay3e3kmy7+K+5jpvHRBb279bAM204yi+loYxeqzQcn38B8k9wG2hzdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuyXbec8GPvK+I103pKRmFErb+n2qBINosDVeKghN1A=;
 b=DgCPetAJW1ccRSSJz6P7XqLYRXkHM/ugHQUktoBH/4DQvTXKiEw47R/IqpWHQvX262DTx9EtHYK8ykZbmvuMMt7Zm0dq7oXZrEhC9sLtMcNdKYvs4bEIe6wurdGHMSaH0fRIuE0wDhFlqesehc+cJl7CsrI5IVIsKv41H9uIGSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 17:39:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 17:39:44 +0000
Message-ID: <1b6d1121-00a8-5f30-26fd-d5137fe9d9c1@amd.com>
Date:   Tue, 12 Sep 2023 12:39:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 9/9] x86/resctrl: Display RMID of resource group
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-10-babu.moger@amd.com>
 <fbf1f7e5-1a82-303c-3802-2f246505c8a4@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <fbf1f7e5-1a82-303c-3802-2f246505c8a4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: a37cd486-9042-4b2f-83bd-08dbb3b74048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lAuT+hJ6wYSeFFO0thG1qlUVfL6JXIZwlr1IlgLook/s2qvvNbCvNEVEmPjku6hDTHrKJQfePcse4B/YveMNGBjE0AwwZZTTWGeYi2kamCscbSezXVbbSud3UExebcr1Gy3HgfXEp93dXhoyEqQTdB6gqFZ0XZF1TAGQgY58WU/2cMnZ2MoZwIocnrZP6QS+nqRBozes5cpxEAhpK4BJimemaSRz0nLmvqDIw3v3BtPqeZXMGctqu4kXMN/x72qR8udE8hZS3C0bONuY3Aj0vyuIB0FXahsqiWtizIezm3XU7wnsNeaHfoVf78LpydGwzUNrkSVeljr4HYniVH75Y9DaYwcZP+AkKLE7uJ5JEvO2DVAKZVSBL+YK4SFNZKxmKthQNDPzaWOsPa/6VDlKeWHiSaoNa33OBCDfRo6F8ujAOH09eg+WXe4zluxp6La+FmqIOxZbAmCglVD6tSK4IBF+0xRmZtiKH65lxRImjDh+jzfv5yf9Dyu2tXOgMB2hNX+SQwYEc2PI3z1w495hVmu/NstfFOFnB94G/9n789vT5kGXxcZBTMpDJpSOHhuMxVz62CWKnHC4IRIZd+tr/kB2uClkxXf7pTPXLHHvSHqJxOb7zG5LqdrJ8JksNRixM/nWCOkZPuw5Zq5GlzaSmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(451199024)(31686004)(53546011)(6512007)(66556008)(316002)(5660300002)(7416002)(2906002)(3450700001)(36756003)(7406005)(6666004)(66476007)(4326008)(8676002)(8936002)(66946007)(41300700001)(478600001)(31696002)(6486002)(38100700002)(2616005)(6506007)(86362001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlFmYk81eXVKV2lnanJSUnA0RUpQMzlmYjBNRkx1aTNtaHV5UVAweStvdlRh?=
 =?utf-8?B?QndHV0xPbFB0Y0dCVitvY3NpZ2Y4OStUemxYUjJZM24xYjNjQTU5eUlXc1dK?=
 =?utf-8?B?NUkvWEVndnI4UFZTVS8wU0FSZmFtM3pWLzNuUEpZdEF1Njl4bU5lVVF6WEcx?=
 =?utf-8?B?eDN6Y0w0N1VlcExzNUR5WnlabUhxMTc4TXlZbG5RM1NJR1F4ZnRxWnhqZVFN?=
 =?utf-8?B?bHowK1lhd2oyNUg1RUFiWHhZVXdodkgvZlE2Q0VrQko0aFliUE1KamFkd3ll?=
 =?utf-8?B?bE9pN2ZIMnowUElYd1BTN1RGWU9HSzZxZm5HNVJFb0hxRDBiVWtHblNjaG1P?=
 =?utf-8?B?aHpROXFaR0dZRG1XUXNjOXJaV1pRT1k5T3VsNDUzckV4aFJ6eUJXNEs0N3lJ?=
 =?utf-8?B?WHJjRkpJTWY4OUJHZjBwVW9NcTdqWVBpNEhic3ZHNjRQMHhqTGQ5N1MvZ0dM?=
 =?utf-8?B?bDJXN0ZjRmttelJZMC9ndWpOQ0M3UlFBZmQxZlVwOW1UWEVkR1prc1RRV1hB?=
 =?utf-8?B?d2tjVDFNOGt6b0FNNE8rYVZOS3VZQ1hqeVJTdEVNbzFpK1hFREticERIVXp5?=
 =?utf-8?B?aVl6SWM3TCtPd2tnUitYcXg2bndiVVdGNnNtV2E1VmswT3REVitkM2dhZXN1?=
 =?utf-8?B?SE1yOVpOcXdxaDdlZ25UanJjR0RRcUhuVTRzdmFucVFNbHJ4RGd1Qi9hSTQ0?=
 =?utf-8?B?NVRWMEFBZms1TEpuN1pKdVpLdjNOMHBZUDNWb1VjOUg2c3pvYWpjTEE4dHoz?=
 =?utf-8?B?Mkk5OTREL0RCSkFGaElPb0h4V1NqU2NFT1JGZkxudytvV3M3SmFSSFU0OWEx?=
 =?utf-8?B?OC9jdytGL1lvVUsyTlpMMldtMTNVMTBzbFEySm1wRlZMcDVUNW04blhmM3hY?=
 =?utf-8?B?NThGVlNEbURjY0F1ekQ5eW5CekNreGZKTkRMZTlPQjNBN21UM3hWM25vc1Ni?=
 =?utf-8?B?R284cERta1JvbEFHQTYvMGpIM0FVdWtNVG9FZ3J6TWwzaGdMaE90YTQ0NWgv?=
 =?utf-8?B?K2FsZ0ZZOWJaMXJ0MVBGR09td2FDdTQ0ZVpjME56b1BoN3N6QXFpU1ozSHpq?=
 =?utf-8?B?T25ISDFuTHJ0OUdIQ1RwaWUyY211TkxLcGE3SFVOMUxkcVFNc0lHRTNRQWJv?=
 =?utf-8?B?bWhuK2d0ZEF4UlB3cHZtQ2tndkV5eGkwZi9mbVZiVUlyNklMYkV2K2p1REg3?=
 =?utf-8?B?S3JMaFlnSE41cjFEZnNUWkh6ak9Db2ZnZmxDOVlidFNDbGZ3dG9nT3A1U2Z6?=
 =?utf-8?B?WUloN3N1VjBka2xweWVxejhSOC9WdmZOU3ROZW9zY1pIWkxqd0RYbXhqZ2RD?=
 =?utf-8?B?Q013WWwrMmpBeWp1MFNBdHJCV3ZBRlI3Z2VwZm1oQUhUWk1xZnJxbWZreEVt?=
 =?utf-8?B?ZmxuY3Q4N0E3T0hDcUNGNTk2UWcyMzRsOVRaK2FJOVlBeDNXem51MVM1QTE1?=
 =?utf-8?B?emhoYnUzbno0WFNSNmh0UXRrZktSbTdha2gza0NZTU1tMys1K3dHOSt1cEFF?=
 =?utf-8?B?Y0p3SGd3NHBNN3BXTkp0TFpTcmpuVjJYTUcwVjViUk1qUmJIWFNQdy9qc0Y0?=
 =?utf-8?B?ckdmd2dpZXc1SW5oSHRKWkRGdm9yWEFDVUJIZFpKaUwyVzYwRW5VaW9vVVdK?=
 =?utf-8?B?OGRtVm9SZ3BQL1VuR1YyT1FlbjhRb1ZESFVuRTdQK3lTQnhKR01UbVN0ZHV0?=
 =?utf-8?B?NWtFRG1teFhEQnBzTU82MzVWalJJRWg2SlBSTFBzd3JTZHRmVnZjd2ZwM0pQ?=
 =?utf-8?B?UzNIT0x3a3laTGxhV0o2OFJCd2R3dkRSalBZV1VXZVJsc051ei9MeGFzRE5D?=
 =?utf-8?B?LzJhWmJLdTFvUGRRSnJURTRmcTJYanFCbmVGS1M3bHFXWkZINzB3eUpsdVZQ?=
 =?utf-8?B?N3dlK0htbHVrVUdWeUwvQ2NyWmNVM0dTK2Z6T2hXYjluRHoyZVUzZVBkalNi?=
 =?utf-8?B?dys5YWZTYm5DSzFDQjdqOFlQVnovK3JMOEV6U3JUUkFNRzRYcE5nUjgvYTNU?=
 =?utf-8?B?dE5nR295WDN5MEVxLzJKQmlQdzQvRWpmOG5xZmVzRlpxVmFZYS9RbDhkdTJs?=
 =?utf-8?B?VW5lOTZqbHBDUWRSTHRBVDgyVU9XaVVwWXQyTTE1c3dUZUV6S0JxNDNvczNX?=
 =?utf-8?Q?lpWQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37cd486-9042-4b2f-83bd-08dbb3b74048
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:39:44.3675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnAX7Cb0i3vXLp1lkVekIdSRfK5iey2DrW7NFBZ6RhBOtfXyStBNbvG+VRHGCtqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,


On 9/11/23 18:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/7/2023 4:51 PM, Babu Moger wrote:
>> In x86, hardware uses RMID to identify a a monitoring group. When a
>> user creates a monitor group these details are not visible. These details
>> can help resctrl debugging.
>>
>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>> Users can see these details when resctrl is mounted with "-o debug" option.
>>
>> Other architectures do not use "RMID". Use the name mon_hw_id to refer
>> to "RMID" in an effort to keep the naming generic.
>>
>> Add the flag RFTYPE_MON_BASE, which contains the files required only
>> for the MON group.
> 
> As I mentioned in [1] I believe adding support for files with RFTYPE_MON flag
> to resctrl needs to be in a separate patch. With the core support added a file
> with this flag can be introduced separately. 

Yes. We discussed it. Thought it may not fit as a separate patch on its
own. So, i combined it.

Now, I split patch 9 into two. Let me know if it looks ok.

==========================================================================

Author: Babu Moger <babu.moger@amd.com>
Date:   Thu Sep 7 18:51:28 2023 -0500

    x86/resctrl: Add RFTYPE_MON_BASE for MON groups

    Add the flag RFTYPE_MON_BASE, which contains the files required only
    for the MON group. Files with these flags are only visible when
    monitoring is enabled.

    Signed-off-by: Babu Moger <babu.moger@amd.com>

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
b/arch/x86/kernel/cpu/resctrl/internal.h
index ccdbed615d41..72988e5c52a7 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -296,6 +296,8 @@ struct rdtgroup {
  *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
  *         Files: cpus, cpus_list, tasks
  *
+ *             --> RFTYPE_MON (Files only for MON group)
+ *
  *             --> RFTYPE_CTRL (Files only for CTRL group)
  *                 Files: mode, schemata, size
  *
@@ -315,6 +317,7 @@ struct rdtgroup {
 #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
 #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)

 /* List of all resource groups */
 extern struct list_head rdt_all_groups;

=============================================================================
Thanks
Babu Moger
