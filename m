Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38701792ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbjIET0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjIET0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:26:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFFCF4;
        Tue,  5 Sep 2023 12:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvzzcL3BSbKrKPb6Xh9kOwDEnpMjiMgBbyp+NcDbyZAPtEzdq0FB4AvwUgWMh7ud69ctglQBp34EyiIw8TwBt094iEmxoZjyqf9+5U5wopFAJ1Fy0UHT6hoAWSvn+64SpvwV0okaULXmzbpF1oszGOzDKXHE6Yu3ksOiDWzZiQkqi1Z/ODNN25Yyhsd5Hlob11LNyyiEChxQD27+wNbYGeyR39Y9xeb8RtbG7SwaQYrfqy149EsCGgTEZl+H9vIeAxqbsI5JQFE41ce9tUWuVyOZFM5scPd/paSm8A0Hcs3pdGBEgGkpgFvXan7rDdt4O5tygWg153bKCCYpx+w4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bziITssiCEHuJBPh8qRvUXcdlpDZJdIW//u7eSCYTcQ=;
 b=KPpn41P4frAHv2YMaYyFbKAuvN4UOclZ7R8ulERe9aLEC7o9z7PizlYssdBn5pYkJFrE9/Kz0VWu1rkC6H5IcSb63ScRe69OIPsjZhONbOJczBPBzuerdE1WQCBJSnSS79LyYMX54o75RrY/ILeuT8AkbzStwCh28ThRuhlIbxcVYNtXuloj/QSE1iwTfNjwMapAgqdL+DufoyEOkw8G9dxXyvuQV/nmsfq3J4sgpPzd2SZet/ieKHw4duRHOoWJhBWWbkCHsGutk05Z3nSndkQPVRCBatcBN05ixmSnpOjFVPUah/blGdy+T9zk9CTCK50FFFfm+s5TRNNK9r5ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bziITssiCEHuJBPh8qRvUXcdlpDZJdIW//u7eSCYTcQ=;
 b=JOyjsGsWuDeJmVqSORWz3UEFGC4SN9OhGnH0qXvuLsvy9f4xw3yrEipGj1Fs/6kqqGoEW4fNa98fp2R69tAvOr2oqYhHYl9FnSIWHkW69a6F5gXag9RsqA428uF/s50re0fygVkOt8zS2qImoFSqSJuvIbObm0wxWubsTmc/zHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 19:25:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 19:25:38 +0000
Message-ID: <5740a4d2-4402-451a-83bd-875331b5de11@amd.com>
Date:   Tue, 5 Sep 2023 14:25:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: ucsi debugfs oops (current Linus pre-6.6-rc1)
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wayne Chang <waynec@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-usb@vger.kernel.org
References: <700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <700df3c4-2f6c-85f9-6c61-065bc5b2db3a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 737c9a53-ea4d-4bc7-7647-08dbae45e297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/MzoQsh5fDJTwkRAPIdcISiabEexom9eM/KrYoLR44kmIbPo4UEN32Rx+cf0zqyVgRNx3vAIPLVnJhBnZLkF4uL0nyT2Qm08pk2ukr9sbnEKdAJu0chjUXa3+jTjmtMJpZ1mCcpRx7tHboVXu8FK2NB8XI1wpU31UFM+BOTae0uM5uRnG/dLLojDRnFLPz82BNQtzXUuY7VzcCCqz3f1ckXBLIlRY4iALhIB3GO6XKgk2BNuSz3HtiagHUSu7bvajwteAECorT082zbY0sa0aAUkAM7MnqTtrMC6eG+EFWXaJZLdEImrr+DeofqkpGKP+vRO78cmEc5PM2m4lLrIVUwu0bpg1eqgQq05SLlYsxtKOqdhKV0ATelLHzrr74tFICtCEvdXUmL4Nzu3DblUWkYk7sVT/lFj1inqQ99GaL9qWItAOaF0Y41jKQ0NsbjZ9B/Aq7r5CawugshmKJnuQLlqUOpfT57R113ZElaR+U+ph0yyaSR2ua9NyU2WeG4VfJIciLgAhrVaWzkd4p/f7XY601tBiLfeQdC1SddRjMpHxneHmYuJBF02IRbfojVWQEYN8LLz7B+1sZ+bIqg+m2FElxeiCoGTAqocydo6fNcANsnrhQAdRDxfPafMclEZ4v2z8ciSEuqM0CQHY0+XbNDaeIyjkWeHpcG2nx/dTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(478600001)(5660300002)(44832011)(38100700002)(966005)(6666004)(921005)(66946007)(316002)(66556008)(66476007)(110136005)(41300700001)(8936002)(8676002)(83380400001)(31686004)(31696002)(2906002)(26005)(86362001)(36756003)(7416002)(53546011)(6512007)(2616005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FNTklldXo3UjcyOHRrTFpocEx1azVWUzhYN0h2b2psbEE0MmltVGRyQWQw?=
 =?utf-8?B?d2pzQnlyK3BMSG5sUWNLeS9qb0RmNVovc0U0WnV3WG9XRFZ6RWg4YjN6dkFv?=
 =?utf-8?B?ZEwyWFVJc1dlRVFOOTdMSjJ1N3F5cGpIWFVFbnhGU0VQS01OR3FxVktnVisz?=
 =?utf-8?B?WTlTN29iVi9oLzZKL3hhNVlIeFdaZUdIWGR1aU1DMG16VXNBK1YvZ2Q3K1gr?=
 =?utf-8?B?eWJDUGFtMERFOVlHZVNJYS9lWkJOaU85dEliQ3ZHZDlQMzRuMlREL0M4N2Iz?=
 =?utf-8?B?aGpJSE4yOFVWRnFZcGo0YmVRaTk4bDluMUxXQjU3blFmaHZqSlFIcTFnZGM5?=
 =?utf-8?B?RTJBUEpaaDNZdE41RWJjYXorR3Fpdk4wYXYyRy9aYzdOcm1TMmRwc01DRUZ4?=
 =?utf-8?B?MWpwWkNjWVB4cEJiMExRSDdOUDdvbU5IY01xelpkUFB3MDNCMk5Da21EWUZW?=
 =?utf-8?B?TklmZVBIU054WlBBSzdINEZHNE83VHF4ei9yRDBSaFp4UCt3MVdCZjhHMHhD?=
 =?utf-8?B?dUxJbU5LdzBrbCtaQmdNWVFwd0lwa1BndElzQStaUzBPRnpwczJlRzZQTTZt?=
 =?utf-8?B?Nm12YkNKTTZzK2xrNUxJUHBoNmcxUUJlbU5ZN0JIR2M1bzh0M2dYaXN1OW1r?=
 =?utf-8?B?bjFLZG85Lyt0MmJpTjVtNE5zR2hoV0pESUg1ZE5wZmhWRHZBQ2lDaVJKckNQ?=
 =?utf-8?B?ZmhxUWNRaFFCcnV5Rld4WGZabG1DVVRHeW80aUR1VnJiRzJLZDhyQmE1NExJ?=
 =?utf-8?B?amhSWmM1aFo4cS9vZ2tuSVY2c1hzSjFXd1RHVjlPTTEyRnBFeGs3ODRjc3Ns?=
 =?utf-8?B?NC9XNTRReXZDUkVvR2JuWElEdjhOeTBxdnB3dXUyNGhvWXJWWFlHTWRWeGp0?=
 =?utf-8?B?SWRRQ2hJRlZ0YjJnMGxGZUk4ZHB1NDk5K05FMTVRQkIwSXVGcy9qTFRRZUE5?=
 =?utf-8?B?V0ZMQUU4dk4xL1puOFY3QXAxQjFMdXNicEorTFV4VE9JTXpRNHliL0hPWGY1?=
 =?utf-8?B?NlQrcllDcHhWVlp5ZEozNC81czV6b0EvbXVPbzdwaVBWeEk0TUZya2g3STBU?=
 =?utf-8?B?V0tmbHFLbmN6alBERUNncEFXM2lVNXdkK3hPTmZTejEvQ1RBdGt4L3p6Mk83?=
 =?utf-8?B?aE9YZVBOUFRvaC9GNnBHR3lMeThXbG5WZWpJUzJ2YjE0ZVNQc3VXOEFLcktp?=
 =?utf-8?B?QWx3V0NWdGRtdmxKM1lrNzFidWFqWXdxMGFxcXM2V0hYUlAwSTBvTzNvMy9T?=
 =?utf-8?B?a1VmMlpCSzRIcFgvVGJBSVdFSnFwWVg3b1hzMy8xQzN2cjIxVWJ5Z0x1NGJX?=
 =?utf-8?B?ZDBXQlJoN084OEJvUTVYcDF0L3RXSjlxWkZ1VjYzWXJHbmJZdkNKYkZ5ZmRW?=
 =?utf-8?B?blcybWxIZUtVRTR5dHZEN3NxeDFHOER3cm1YRy9Kck0xTi9zdFpobWRmTVBs?=
 =?utf-8?B?Sy8zMWJVOS95dUFoOCtESVZKanArdmUvamtTRHEza2ZVMHA5dGEvVlJ3NlN3?=
 =?utf-8?B?eDdhQXRkWk9WZGNVNVp1QzJoVWRaQ0l0VStWUmlNQjd5amUzSWxWVWxMTC92?=
 =?utf-8?B?Sk5uWE96UzJhbG1weE45TlErREYwZnFKQzdWSjU3cXNBRkMyTGluTFZNVEds?=
 =?utf-8?B?VGJRaDg0cGExK05PYWNEQTB5anAzRmdaeHJMZDIwN0NOeVBvQ21WbzFjNVVN?=
 =?utf-8?B?UnI2d0ZjQng0dHFtN2FUd3RBMlh2ZTc4dEVLaXFOQTZyKzF3dnhXR0JJTDFL?=
 =?utf-8?B?THpxMVVvMG9mT3kvZmlUa045MStiQmNXbHUrTDNZNm9mbEl0enNFbTdvempF?=
 =?utf-8?B?ZlZrM3lpNGVwQ1FEN1A1LzYzT1FJcFN6cnZ4RDh4ckJaUmUzQXVXbDhiY0FJ?=
 =?utf-8?B?TmpjSkZCM0lNZnVLcmFQTXV2QUczQ2JINHVlQ1JQd1pjek9KQkcxTlQ3WTk2?=
 =?utf-8?B?QjBtOHpnMEhrUWpxYThCVThEMHhqNW9ib29ReFQxdnJmWEZXSDBQMXh3dHhY?=
 =?utf-8?B?d2NSTXlsVVlPTXBrSUVOMDVDVXVPY2hNOWR5ODV3aUxwSTBleVprVlhtV3hW?=
 =?utf-8?B?ZGhSVzBla3NJc2FBcmVCQ3RUdDFudlhYc2NJYTVqQ2FNVGlHMGh3TDJjNHRD?=
 =?utf-8?Q?CC/YZqVO3IkpLPDB/wgmzuXe1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737c9a53-ea4d-4bc7-7647-08dbae45e297
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 19:25:38.3369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEEuuscuiezALl7WvotaiJVLSIc93OoSH53I4ndq9SAFkYj9KiFb8HtRg6O5fklU1olz7Z7TEtQv0CW8jHZaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5518
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/2023 14:10, Dave Hansen wrote:
> I'm having some problems booting Linus's current tree.  It seems to have
> happened in some content between commit 3f86ed6ec0b3 and df0383ffad.
> 
> I'm suspecting this commit:
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df0383ffad64dc09954a60873c1e202b47f08d90
> 
> I'm seeing a null pointer oops on this line:
> 
> void ucsi_debugfs_unregister(struct ucsi *ucsi)
> {
> ===>    debugfs_remove_recursive(ucsi->debugfs->dentry);
>          kfree(ucsi->debugfs);
> }
> 
> on this instruction:
> 
>      66 0f 1f 00             nop    WORD PTR [rax]
>      0f 1f 44 00 00          nop    DWORD PTR [rax+rax*1+0x0]
>      53                      push   rbx
>      48 8b 47 38             mov    rax,QWORD PTR [rdi+0x38]
>      48 89 fb                mov    rbx,rdi
> =>  48 8b 78 20             mov    rdi,QWORD PTR [rax+0x20]
>      e8 36 16 26 e1          call   0xffffffffe1261669
>      48 8b 7b 38             mov    rdi,QWORD PTR [rbx+0x38]
>      5b                      pop    rbx
>      e9 5c 79 03 e1          jmp    0xffffffffe1037999
> 
> That's the second dereference in the function, so I assume this is
> trying to dereference 'debugfs' above.  It appears that this is some
> failure/error path out of ucsi_acpi_probe() that's not handled correctly.
> 
> Probably this:
> 
>>          if (ACPI_FAILURE(status)) {
>>                  dev_err(&pdev->dev, "failed to install notify handler\n");
>>                  ucsi_destroy(ua->ucsi);
>>                  return -ENODEV;
>>          }
>>
>>          ret = ucsi_register(ua->ucsi);
> 
> where ucsi_destroy() is called before ucsi_register().  Although I do
> _not_ see the dev_err() message anywhere.

If your theory is right could it be that the printk handler was racing 
and that's why it didn't come up?

In any case I'd think you can add this to ucsi_debugfs_unregister() to 
avoid it.

if (!ucsi->debugfs)
	return;

> 
> Full oops is below.
> 
> I'll try putting some hacks in place to avoid the null pointer.  Also,
> please forgive the lack of a bisect for the moment.  This is happening
> on my main laptop and it's a mild pain to do bisects on here.
> 
>> [    4.903493] BUG: kernel NULL pointer dereference, address: 0000000000000020^M
>> [    4.905624] #PF: supervisor read access in kernel mode^M
>> [    4.907326] #PF: error_code(0x0000) - not-present page^M
>> [    4.908993] PGD 0 P4D 0 ^M
>> [    4.910998] Oops: 0000 [#1] PREEMPT SMP NOPTI^M
>> [    4.913077] CPU: 6 PID: 150 Comm: systemd-udevd Not tainted 6.5.0-11704-g3f86ed6ec0b3 #138^M
>> [    4.915211] Hardware name: Framework Laptop/FRANBMCP0B, BIOS 03.10 07/19/2022^M
>> [    4.917355] RIP: 0010:ucsi_debugfs_unregister+0x11/0x30 [typec_ucsi]^M
>> [    4.919705] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 0f 1f 44 00 00 53 48 8b 47 38 48 89 fb <48> 8b 78 20 e8 36 16 26 e1 48 8b 7b 38 5b e9 5c 79 03 e1 66 66 2e^M
>> [    4.921982] RSP: 0018:ffffc900007e7bb8 EFLAGS: 00010246^M
>> [    4.924227] RAX: 0000000000000000 RBX: ffff888101b2be00 RCX: 0000000000009a06^M
>> [    4.926752] RDX: 0000000000000000 RSI: ffff888104491798 RDI: ffff888101b2be00^M
>> [    4.929312] RBP: ffff888101b2be00 R08: 0000000000009906 R09: 00000000000333f0^M
>> [    4.931887] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffed^M
>> [    4.934451] R13: ffff888102594810 R14: ffff888100653600 R15: ffff888101fa7f78^M
>> [    4.937115] FS:  00007f5dd0fb48c0(0000) GS:ffff88906fb80000(0000) knlGS:0000000000000000^M
>> [    4.939581] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
>> [    4.941308] CR2: 0000000000000020 CR3: 0000000105070005 CR4: 0000000000f70ee0^M
>> [    4.943022] PKRU: 55555554^M
>> [    4.944731] Call Trace:^M
>> [    4.946438]  <TASK>^M
>> [    4.948167]  ? __die+0x24/0x70^M
>> [    4.949864]  ? page_fault_oops+0x15b/0x440^M
>> [    4.951563]  ? acpi_evaluate_object+0x190/0x2f0^M
>> [    4.953201]  ? _raw_spin_lock_irqsave+0x28/0x50^M
>> [    4.954841]  ? exc_page_fault+0x6e/0x160^M
>> [    4.956461]  ? asm_exc_page_fault+0x26/0x30^M
>> [    4.958067]  ? ucsi_debugfs_unregister+0x11/0x30 [typec_ucsi]^M
>> [    4.959677]  ucsi_destroy+0x12/0x20 [typec_ucsi]^M
>> [    4.961298]  ucsi_acpi_probe+0x1cc/0x230 [ucsi_acpi]^M
>> [    4.962908]  platform_probe+0x40/0xb0^M
>> [    4.964522]  really_probe+0x1a2/0x410^M
>> [    4.966110]  __driver_probe_device+0x78/0x160^M
>> [    4.967735]  driver_probe_device+0x1e/0x90^M
>> [    4.969306]  __driver_attach+0xd6/0x1d0^M
>> [    4.970874]  ? __pfx___driver_attach+0x10/0x10^M
>> [    4.972449]  bus_for_each_dev+0x79/0xd0^M
>> [    4.974022]  bus_add_driver+0x116/0x220^M
>> [    4.975600]  driver_register+0x60/0x120^M
>> [    4.977169]  ? __pfx_ucsi_acpi_platform_driver_init+0x10/0x10 [ucsi_acpi]^M
>> [    4.978762]  do_one_initcall+0x45/0x220^M
>> [    4.980367]  ? kmalloc_trace+0x29/0x90^M
>> [    4.981952]  do_init_module+0x90/0x260^M
>> [    4.983530]  init_module_from_file+0x8b/0xd0^M
>> [    4.985087]  idempotent_init_module+0x181/0x240^M
>> [    4.986639]  __x64_sys_finit_module+0x5e/0xb0^M
>> [    4.988198]  do_syscall_64+0x3c/0x90^M
>> [    4.989739]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8^M
>> [    4.991290] RIP: 0033:0x7f5dd16aaa3d^M

