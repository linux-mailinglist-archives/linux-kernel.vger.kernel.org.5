Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865A97FC352
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbjK1Sdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjK1Sdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:33:32 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978CDE;
        Tue, 28 Nov 2023 10:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLdvKv0qHNlSy8I0v8zNhdHqw6Ep4+zkibFqpm/S7A9C2xqbxoDvePfshBdndT6uWpdBPQEU5YXH+9w4/0Kz+b5dUYAC0v+QEg22f/jIiOOrLHdR5tHyYVVuZRC+kKvnrDs0cEsvGH1mUAtBNzc+OhB0+P7yK9xD7A7odJDk/dH2l/l2TMHhJdCaib99tWL/1PB0QojObQqSN0osAe7HxSTpmLhAKkxNZpQYzC9wl7Cea2D3AA3odywkvi4IAgxXjWBJkMr+xJ9fbO2cf+PwNCZGc89Rz2IAyGPV65K9RTVvwF5RaOfuwoQjKhaqQVJNuB0xSWuUl8igXZ4aPnkJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFvTVz1Uu6mbWIeOvnz2F3mxn8FRdBB7V6sDqLyeqFA=;
 b=GM1t5gfcVaLiYH2ZHu1QfAPnXXrKHB2iNwes7gaQ6YN4D1JpApzcwfNWWZYw3ObNU28bundctsH5DzSgFP7NWC5osjh3WPQHr54FsvGQIe3c2kbLBS6euyZiwqxpV+7UerGhxcnNCPtcgyRMZ+d2Br5BCrnjgtP0PDFblLAUZ+8o8da/XlVDH6vrciy1BlN5lV4qNCnEtLUwZiu6YvRUMPVMlv0OgEyqI0zqefMqXeVd/f5Xw4YNxtuBGiuigaQkLed6pvJ51srWiKihOSqSiIAewLh0bOHq5JO2nw5r4fFahhDgpe+l5QWcA9ae7JNdPONZTlZ5q2YsOzPla4YHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFvTVz1Uu6mbWIeOvnz2F3mxn8FRdBB7V6sDqLyeqFA=;
 b=gg0T7sLYhAFV6dfjZM1PF7VB1tTZeGMwtGpcuGe4lpcx22YlEcQppHS8Z7YcWRinzaWxtUUGilgWvOZ1fMGnWPoGKWBubAShTPIecww3oTiuDaGXJl/rRRH2Lz5UWd9JBXvTJzslE1Di5AHHluHy60ccPbeKdB7NkZwmraP6FVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by PH0PR12MB8149.namprd12.prod.outlook.com (2603:10b6:510:297::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 18:33:34 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:33:33 +0000
Message-ID: <05e44249-8686-4e0d-856d-46a344127589@amd.com>
Date:   Tue, 28 Nov 2023 12:33:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] x86/split_lock: Make life miserable for split
 lockers
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Joerg Roedel <jroedel@suse.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6bc08e77-812f-4e9e-938a-6a13263ce9d1@moroto.mountain>
 <ZWYl+ymwSRKzD+NL@agluck-desk3>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <ZWYl+ymwSRKzD+NL@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:806:121::32) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|PH0PR12MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f12181-741c-4ccd-83b0-08dbf0408716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3LNkHZfasWmxsRUgt82IjceAn4OfT9nZre5cr5tXv+pPUT4tRqAtQiUDu7JpbmhFX8YL5+UnKq/0409eJwYme5TgWpPvC8e+EwLZ+2lOS2AvS/3dpkfg74mE66CgZLyZy1wK2l0wnKs6QINX0m5af9vaJ9zRkVXGyUOLCB1fkbmwN1FK97MPVCfS7NfUfoxB8f7/4Ybf3u3wU21Gduk+8Ra43rE4l4bf47CxWtCnDYWlEhHBjUcNtYn1n2vKAYp/F4m3/wjt7XcXDBSFUia8SnEtsLZlI+VgLRw2MvnlL/FuUIJzTh7YyFFEbGqNzXKcsSYlG0onuo+6hf0um/KZmasJwUZReq6iPAN1ZS4dwbK3cTONWT1DqLCy+AWHpkJ1IS1DVdD6oi7RcwvkUoSUzhJ8bmi4Avo2MbxASXzd9cAUyW1xf+mfdkOY2272RG4PpoZGi2m6agjgzrLLDvZdkLFSylT6gYtotJF0Eol1RAW9aZmuYWJySQfvLxYd4vb9TzIzxOHfhNTVOZROtjflk6Dq9z/FSiu9DHBaCWzk14CAn5feg1ItxZpKtuD0Lt0tgbOPPBJ/e2ARh+0lDCdi0L+k2i+C32bmoL9DL3kdGnVaWypTvGVGwGhkBCH3iPgElp/KBRr+Y1Pn92iR0sYcT55ne9ReDHFMYUNoSqu5Oh/J6+HmY0lbAUGImfx/W7u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(38100700002)(31686004)(6512007)(6506007)(8936002)(4326008)(66946007)(110136005)(316002)(66556008)(53546011)(66476007)(5660300002)(31696002)(478600001)(8676002)(86362001)(6486002)(36756003)(2906002)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dCVWsyVlkyNVJ1b1JOZVAwTVNmaVpCcU5nUzhzd25BV2dzSlBQaS9pZEJ4?=
 =?utf-8?B?OTdsZVA0ekRSVVRERHR4Tk1EejM1ZlRDQVJxbnBWTitoZC9BZGE0TXFGVndQ?=
 =?utf-8?B?aXAvL1NOeGUrb2JSek4wd1NPN0IzcU9TMVd1ekkwdkVpalR2RWdGSFV0a0pT?=
 =?utf-8?B?c1dJQ0R4QVhpZEtqdkYyRkc4RXl5Z0NCQk5hVGc5bmxsQTE4TFFoODI0dzlo?=
 =?utf-8?B?Z3U0bnh2M0VhdHV5Z21nK2FSVUpJN3Y5T0UyZUE2ekgxbGdZRWNNcFk2alhG?=
 =?utf-8?B?M0JSVnFRcFBUSkdiV3MwK2l1L0lWNEpCUjNBR09VWFNmWGRQbERoYnpBZVNn?=
 =?utf-8?B?L212ZXpkYXdTclU2aUx3QXE3MlUzYzZsT1ZiMGRlZ3ZCVWJpeG1vK1F2SHdO?=
 =?utf-8?B?L0hqOWM2R1o0cFkrSGtHa3V5Z1pOZ2k1azlMK2VlbktNNEkyRlUxTWRUWnMr?=
 =?utf-8?B?dkwvNlQ2dXA1NkR5N016ODEzUUlNeXI2N05iOHJLVTI4dmdpUXVHNlU4Zm15?=
 =?utf-8?B?c2dQRDRhelk3a0ZDdTNPQlBwNWFUUXVRZjJMdHJET3lFQndISmtVWHZuT2pY?=
 =?utf-8?B?R3pyK2xHRmFYWkhPK0dXaEtnQVlsOStwc2VFb1l5ZTFEazZUcURUTlBVMlBo?=
 =?utf-8?B?bm1VOGlSV2tvQzN4b3dabitnSlZ4U1c2aTlKbXhrbkxhdE9QcHFUVjRGVDQ4?=
 =?utf-8?B?WFBaeUkweUdKY3hwZFRnRXpOUnhaQndmMk9qc0ZxdUZjTFVYaC9aYjFrQldS?=
 =?utf-8?B?VXdQYWkwU0p1bXpBSndqZ1pNWmg2bE5yejdnZlhYSFZtTUpVSFRLeFVGSHNz?=
 =?utf-8?B?NkNBTnozcVUvbVRSMmVsQVRmK3ZjVlhOSWZkK3NYSm1VbmpyTSs0WmRQRlU4?=
 =?utf-8?B?QlAyVmNKY2EvaGt0ZmptVlZuaVJZbkJZZ0kwbUlaKzhsOGprbktOekxodUd6?=
 =?utf-8?B?Nk9OVkJ3enl6NjJ6VHhwc2JIRXZ1M1JzV2cvelN2Y054SHVzOStIdkpIVGMy?=
 =?utf-8?B?RXlYTTR6RFlsSjhWKzZha1F5UWNZYytkUTJGTmJOTFBCc3hDT2JJd0JVMFMz?=
 =?utf-8?B?SVpqbWJaVkNaN1FUVGxlWjZIbXpaZWRGdXhWWFFsd1ZQM1g5YTRESEswMUsv?=
 =?utf-8?B?T0EzcUJMQjJqMEVUM1JVd25GcjVRNEVXcDJCdE0xYlZjeEZTcStQaklmM29C?=
 =?utf-8?B?YzhGVVliSGdweGRuOFd1YnJTT1dmSi9zUFAxeEp1ekhVQU85S3hDSnNMekNX?=
 =?utf-8?B?UlF6K3ljSERtZUw0TGVvRjAxODZYblJOMkdIK2hBeWpBcThuRkJxVXVmY09F?=
 =?utf-8?B?WEtRSW5IVTZjNVpsWi9lMUhIM0k3TVp6bnAxejBTb2NQNnYxQmtxSXZhU2Zh?=
 =?utf-8?B?N25TRjgzZ0FtQ0V2MmVmK2o0bFA1NGo0VjQ4N2oyeXc3WUduUGdzNHR4YWgr?=
 =?utf-8?B?aE1BSE9IaDRySlJ5eVB0SkI5Snp0UHNzTUNScDBRVmhUeDg5N2kwa1hTUlNX?=
 =?utf-8?B?ejNMdGJ6aFoxdnVsUG5ZOVVwM0dtRlExR2h4YkZYa0hUVklwMStESmhXSloy?=
 =?utf-8?B?QlR2WUVERHlZU3hVK1krSkRpWkcrK0NRNzFNcDZYbG5CeGpKRmpJOU5QbE1O?=
 =?utf-8?B?UVZGdXlGYTNrS3BRKzlMOHRYTDhKYjUrQ3cwZEU4UGVxeFFPdEtIZEU5b0Zl?=
 =?utf-8?B?WXRrOE1ZYVlIeGhBbzA5Q3N3N0hnV042VHBCK05FalRUREx1T09mM0d1M3g2?=
 =?utf-8?B?Mnk4L0YyaDVIRi93dW96UUltOE5JMWluN2ZicStDOG1tOW5FQ0ZtQmJoYnR2?=
 =?utf-8?B?T2l4QlZZYXh6Y0I2blFwa2tGWnlHNTVWSm5JSTlCMkRzajN4VDdTaXNMVENo?=
 =?utf-8?B?ZGh5YUlhU0JGRnRQRGQ0UVVabUdQbzRRL2pvUE8zKy9OcWN0Mkc5cGZ3cWZY?=
 =?utf-8?B?SFIxOFM5RUpUZ2hVRFBQV1FleU92c00yb29CUEM0bmc4WDRuQjBDRWhoc0hT?=
 =?utf-8?B?L3pMRUUxTFdKTlFoVTBodzVLYmxnaUF3V1haN01qU2kvYjQyR0JJWUJmd05I?=
 =?utf-8?B?VXFRakMwUkY5T3RkdEtmQUNLMkJRQWlSMWxqMFFSbVljb2s2dlUyNmZYSWVp?=
 =?utf-8?Q?KxP6wHqTGMwpWsCSjxi6LOHoz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f12181-741c-4ccd-83b0-08dbf0408716
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:33:33.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USmFNxBetaYw5SCP6tEfLz/R8xCT3VENvRm30cnv7U7OZo4q3Ah4Uu+5ClnhDlxeOeYpTOACSi2slSiLq7Zr+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Joerg

On 11/28/23 11:40, Tony Luck wrote:
> On Tue, Nov 28, 2023 at 04:12:24PM +0300, Dan Carpenter wrote:
>> Hello Tony Luck,
>>
>> The patch b041b525dab9: "x86/split_lock: Make life miserable for
>> split lockers" from Mar 10, 2022 (linux-next), leads to the following
>> Smatch static checker warning:
>>
>> 	arch/x86/kernel/cpu/intel.c:1179 split_lock_warn()
>> 	warn: sleeping in atomic context
>>
>> arch/x86/kernel/cpu/intel.c
>>      1158 static void split_lock_warn(unsigned long ip)
>>      1159 {
>>      1160         struct delayed_work *work;
>>      1161         int cpu;
>>      1162
>>      1163         if (!current->reported_split_lock)
>>      1164                 pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
>>      1165                                     current->comm, current->pid, ip);
>>      1166         current->reported_split_lock = 1;
>>      1167
>>      1168         if (sysctl_sld_mitigate) {
>>      1169                 /*
>>      1170                  * misery factor #1:
>>      1171                  * sleep 10ms before trying to execute split lock.
>>      1172                  */
>>      1173                 if (msleep_interruptible(10) > 0)
>>      1174                         return;
>>      1175                 /*
>>      1176                  * Misery factor #2:
>>      1177                  * only allow one buslocked disabled core at a time.
>>      1178                  */
>> --> 1179                 if (down_interruptible(&buslock_sem) == -EINTR)
>>      1180                         return;
>>      1181                 work = &sl_reenable_unlock;
>>      1182         } else {
>>      1183                 work = &sl_reenable;
>>      1184         }
>>      1185
>>      1186         cpu = get_cpu();
>>      1187         schedule_delayed_work_on(cpu, work, 2);
>>      1188
>>      1189         /* Disable split lock detection on this CPU to make progress */
>>      1190         sld_update_msr(false);
>>      1191         put_cpu();
>>      1192 }
>>
>> The call tree is:
>>
>> kernel_exc_vmm_communication() <- disables preempt
>> -> vc_raw_handle_exception()
>>     -> vc_forward_exception()
>>        -> exc_alignment_check()
>>           -> __exc_alignment_check()
>>              -> handle_user_split_lock()
>>                 -> split_lock_warn()
>>
>> I think maybe the mismatch is that kernel_exc_vmm_communication() calls
>> irqentry_nmi_enter(regs); which disable preemption but exc_alignment_check()
>> does local_irq_enable() which doesn't enable it.
> 
> I think we need some arch/x86/kernel/sev.c expertise to explain the
> preemption requirements in that stack trace. Adding Tom Lendacky.

Adding Joerg as the original developer of this code.

I believe that irqentry_nmi_enter() is used so that we are ensured that 
the kernel can't be interrupted while using the per-CPU GHCB when entered 
from kernel-mode in order to avoid nested #VCs (except for an NMI). Joerg 
might have further insights since there was a lot of discussion around 
these changes.

I'm not sure if is possible, but I wonder if irqentry_nmi_exit() can be 
issued before forwarding the exception - or even delay forwarding the 
exception until after irqentry_nmi_exit().

Thanks,
Tom

> 
>> Also why does arch/x86 not have a dedicated mailing list?
> 
> Good question. X86 was once the default architecture. So everything went to
> linux-kernel@vger.kernel.org. I'll add that to Cc: for this. But maybe
> it's time for an x86 specific list?
> 
>> regards,
>> dan carpenter
> 
> -Tony
