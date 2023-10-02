Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E467B4A61
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 02:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjJBAAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 20:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJBAAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 20:00:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24C6C6;
        Sun,  1 Oct 2023 17:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAQUK79gSVir564zNuLMGmE0KlrrHUg19T4Gb68/LIzSQJclgp7VKDXSflj7TeXUaY8Nrtp1t0UBw5z6VZudr2eYPl2LTZtZGZep6JKRxJCGfF+8yS+q39GGa3MOuQ6ymxnbk0tatsLZ99s8WfahIg8n5yPyMZ1xnARiHjB6UvdA8BvzaWJnwrCBELqJTyIQSkMVS72sFiaoLRBoEErx8i2do5XGqtLq7MP7UCoMZ2XAl0ejY5hdhnQlvVQ4xF/OH4WB+sR7JL8wWJaddpQwuBbNlf2ANE9zw0w7cyAaKny4udj7uS1kvIg2VWcVEx+lNctDNFfgUU1tR5mDn4ygXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKUW3s02mPKJ7Wb5ENh2D7hB0kI4wUgdb48v5V77sMc=;
 b=NIyn11GjHKm3+N99r2br7YFL/eQ31NWfcw5A+WZi2nXIyUC7FJ+YBYdYL9DPTh8JfyPdW/8kIQQFBKKCkDgwWcdSYeffNBQKZDNDOXgxFeHF7BKwTEDgXIY9ihnRgBlBNP+agnuFSl7zRoCoJornk8RR6Y/NhPtPgSYIVPfh0Jg1pYxKd6qLxMj/28SLkOlfIS8J2sVJ3SRzgh12wj/YNFRt4Kn/uosKMRHmx7kVppZ+GE07w6qsRn5ufwej5vWYlCwLwvxV5x0qoSr7fnJ4yTcTIXj1Vt8sonrjJ6nZRCZaC6199v5cKgbD3acsiiUnqZeIs6AHvztksq2R9fiEkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUW3s02mPKJ7Wb5ENh2D7hB0kI4wUgdb48v5V77sMc=;
 b=BlRm/UN5rthGlXC1s97hL+6l2PXUZ6s6ixvgBLRhupKFvakfEXZaoa61S8jwMABMkzvaFhkeRDVzOZqDcynbzhQZNOmzHzBij/45DUUDUFdnWZ0UENS+vAj7ROco/oiFPT2BeQ8O6ZXr+vMvy0EQffk18j8fuehyfnoYa7HSkGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8852.namprd12.prod.outlook.com (2603:10b6:610:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 00:00:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 00:00:13 +0000
Message-ID: <8d4e4b74-4477-41e0-a690-8b9f38907a7b@amd.com>
Date:   Sun, 1 Oct 2023 19:00:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] power: supply: Don't count 'unknown' scope power
 supplies
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun.ma2@amd.com
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <20230926225955.386553-3-mario.limonciello@amd.com>
 <20230930201826.biy27esyw4ttxt4p@mercury.elektranox.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230930201826.biy27esyw4ttxt4p@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0078.namprd12.prod.outlook.com
 (2603:10b6:802:20::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 26160414-e8b2-458e-b6e7-08dbc2da8d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhR06EJGH4mEDTnIbiHJuia64WauZyLrsKAL2pLHQlL53U+pBPf8fxIOCW1mVjgX6t6LKjRtIq5P6L5tsi1maYAup+1ZaCPeEXxpnFBWEFkgwiUWLx/8xgpjdZdzTudWuCey0+RHWJNn91RPYNTfWTLAA+pzzrklc7VWdiD7QJMIczpWVjndFdBWcWFj5z7eR74NhVRhCw+VBqUf+C/EXV6R5VK0OhIr8NJOGDzyQ8rbJIq/tgO0AvlI3Uxh1+/1X2elD3yUdhmPxmgmI4a82FzOBPbS/n0EckV/Cz40/BF5c9oXI4VcbCkTV+yc6jZLvjeXk3rOQbafvlPHjnq8Y55A4HvkaMi2ne2VVtfq+dhC//fyEEqt7SzwiXiUkYayzgkNEJSFNJY1SulkJsWWMmXD5ADJfu6bO+41/lRK3f5Q/qO4s5CV6Vi6ee24Bur9h72c40lyWIOz/YgUQmxZYxJFiGyAj5jVY7xUR7IJfssUlGV0Lza0kDE25unWxsMTg1iGunBfWbpb/MZXu5+L5vD5m9CeKT6RkDNInnPi5rwno11bREPyMvpit/PMQb23slzfRbjZQHNFWtKuUz8FB+7lsiTBkHec/H/pUE2LSrf+Au38YeiaVrTzxsuLhieVlyHIF2vQUzSQYJdFOXQdyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(31696002)(41300700001)(38100700002)(86362001)(44832011)(53546011)(66476007)(66946007)(316002)(66556008)(6916009)(6506007)(966005)(6486002)(6512007)(8676002)(5660300002)(4326008)(31686004)(8936002)(2906002)(478600001)(36756003)(2616005)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNWNlRWVXczaC9mYmo0ajQ1cFlJbVJUd2JCcTZTek1xdjN4ZktjWFkzMm5F?=
 =?utf-8?B?Yld5WHduZStka2pUa1FZaThtcHZvWDJZbHFqei8zeFB4aWhzVFZ4aE9LS0or?=
 =?utf-8?B?NWgwZzdmb0tiYW9WOHhsWndubGVMZ3lxL2tubFN5aEt6ZHBYMzZJREdmMkNP?=
 =?utf-8?B?QnM4dEphSnV6UTFSR1hwdTZOR0ozUHpiZFNSNHo4QVVBY2NpMExTVG5ZMUhH?=
 =?utf-8?B?ZEJabmlGR0FEaUttMGJ2OEJjd3FnZGZtdjlycEtFTzl6emcvMVFMM0dGVGdM?=
 =?utf-8?B?Y3cwU2xPNElaTWFpa2dWRDYwSk5Xc3VRMUlBY0FnMzlYUDBoK2tkMWxYdWNW?=
 =?utf-8?B?VUFSUzJYNFNlbGVFVEdWWHVoc1VBYzZ3aXp4R3c2Qk1uWEppMStuNHpRbGlq?=
 =?utf-8?B?emFiQ1RTY0RyeUlxSnJtRmZ4Q2w0SU9KTnNGb0RrRENQR2VLZ1lYRjYrWCth?=
 =?utf-8?B?TUpMOGU0b0VQb3dmZjdKazRPa3gvdGpHdks0UWZHVjBIcVptRHlUZFU3RUty?=
 =?utf-8?B?U0F0RDEvbTM5U21NdkdWa2ZKYXZzQlQzYWdNMDZXSldwSi9CNFc5UW13Yjl5?=
 =?utf-8?B?c2RSOGYxUnNmTjd6UWtBa2ZnYmZCQUZucUx0YjJVSU5vZzZreXRKM216ZzlV?=
 =?utf-8?B?ZzZiRFBwdWF5THlId2tTT1RUc1BqRGpldHQ1Rytwc3ltUklrMkdzTXpaVUFa?=
 =?utf-8?B?RGlER3RtbmdabE1wLzVjL0VCYmJDczhsNnJtcDJBcFlNNzllT2RJSW04UjNo?=
 =?utf-8?B?Q2RTd2pDUkNvZ1pwKzB3dzVFSXJkU3RqZWJFakJ0c0tINHZkeGp2YUEwelBI?=
 =?utf-8?B?R2hOZnZxKzdSaEplU3hUY0JhYUo0NlgrSXVodTZjei9DVXBkYWZrTkh4bm9Q?=
 =?utf-8?B?RFZzVzg3UndQcEZJVkxXaU1mTUFrRE1pMVd3ZWduUkdXSlRUWjg3M3NiLzRJ?=
 =?utf-8?B?N0x2cGN6NllFVjc1NWU0NGNxUjZyS1JTVDllN1ROZVZSUzJMTTZwbFBOTDRE?=
 =?utf-8?B?TlNoZ0NjOWhmbG5URjVIaEtET1ZpY21XRzVnTFl5SVJ1YXgrZ1B4amErY21Z?=
 =?utf-8?B?SkVDR0ppZFg5eUFQZ3ZkRnFBMUdhTCtGR2h5S0xOL3l1SDlPYTRIZTZvMEJy?=
 =?utf-8?B?UVdFd2ZoNnpEeTN4VFlTc2hyQkZET3ZicFJsTmRRUnQyUEdUTFdCQ00yZGE4?=
 =?utf-8?B?S0xybGNlaDBFbG0xU1dPcXpvdlUxZFhDRlJGNVlyY2swTDFGblMzOTlxR1VM?=
 =?utf-8?B?d0VyV0hYc0h1STZUbUFwSVJDcGNFMW5lUExSUFlydEVYQXFVOHMyQXN3Z2xW?=
 =?utf-8?B?NWVvSDJ0QUtPK0N4ek5yamxINjQ2MUlqN3pRdTFJTmsxSnNyUDBqNklENXR2?=
 =?utf-8?B?eDJ1NVd4QTNERnA4L0psa1RONHFLTlo2dmxYenpoTDNUL2k0T3ExdXN0bm0w?=
 =?utf-8?B?S21lcldYRlZkVzdTK3FaYkxWWEtLMzBVWm81SDJaUXpZYmhsLzZyR3BobDQr?=
 =?utf-8?B?MEhyUDl3MDBEQW9mTVJGa1ZSOGsyayt2OHBuVHJINzM0NUxmR2daU2tjcXBt?=
 =?utf-8?B?UytPaFdDZGNzSGszU1VCcjdvWWZwTFdJdUNscmt4K0dxbTNBcUczQ2JQNVJP?=
 =?utf-8?B?cnQ2NlFCVktFendlQThJd05zYzg0MVMyM1hWRjJ2aCtpb0E0c1g4bGpCSkx3?=
 =?utf-8?B?bW1ncis5S0JQckNmR0Y4VWpBM0pZZ3EyQUVYZEt2elJPbE1jUTI2Wi8zc0xv?=
 =?utf-8?B?TjhaZzQvcXpYNCt0OXBNbmpwNm9HQm5zZFVYMHYvNkxhaWRXMURCVXltNVF5?=
 =?utf-8?B?NjUyM01GaHJtV3BmeWZUTTdxcmtRQ1B1aHg3cS8yVmZHRCtaZXJYSitNTE1t?=
 =?utf-8?B?VzdvaWp6WWo2UVVCWHozQnNuRTdRdjByTDR6VVRQamxHbTNXY1BvZGszS0Fh?=
 =?utf-8?B?RjN6WkhQWXRhZ2tyUTFjQXRqRDV3bGJIcnNNUnU4cm5TNmtTdm1kRmZoZUZV?=
 =?utf-8?B?Q0dJUDVxMXQ5UHdFZjd3R0ZFS2h4dEEvMGxadFgwR0VJdGhLTEJqRWVidlNF?=
 =?utf-8?B?S0ZWTWM1VWZpN0JBd2dNZUdFNjRDamkzRDltemRSMm5pYWpENjNNVXk0VGxM?=
 =?utf-8?Q?ND9iOUWA0WFxsBgL/D1y+MnPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26160414-e8b2-458e-b6e7-08dbc2da8d7f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 00:00:13.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXv7VbqazAhtwJsXWo17OgEshcY/3hr5E2OdAeSomdibkGJTuBhHknP9GDrFj6i70P9a6TdiY1ifqLALtCw8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8852
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2023 15:18, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Sep 26, 2023 at 05:59:54PM -0500, Mario Limonciello wrote:
>> On some systems AMD Navi3x dGPU triggers RAS errors on startup; but
>> only if the amdgpu kernel module is not part of the initramfs.
>> This is because the hardware is not properly programmed for the
>> AC/DC state of the system when it is loaded later in boot.
> 
> I don't understand the last sentence. As far as I can see
> i2c_dw_pci_probe() either does not registers UCSI at all or
> with the dGPU properties (and thus scope) set.

I'll explain it better below.

> 
>> The AC/DC state of the system is incorrect specifically when UCSI power
>> supplies have been initialized.  These power supplies are marked as
>> POWER_SUPPLY_SCOPE_UNKNOWN scope. As they're 'offline' the power
>> supply count is increased but the resultant return value is
>> power_supply_is_system_supplied() 0.
>>
>> To fix this look explicitly for `POWER_SUPPLY_SCOPE_SYSTEM` power
>> supplies before incrementing the count. If no system power supply
>> is found then the system is assumed to be on AC.
>>
>> Cc: stable@vger.kernel.org
>> Tested-by: David Perry <David.Perry@amd.com>
>> Fixes: 95339f40a8b6 ("power: supply: Fix logic checking if system is running from battery")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> This effectively fully disables supply detection for UCSI, because
> it is never set to POWER_SUPPLY_SCOPE_SYSTEM. Please fix the amdgpu
> init part instead.

I don't think my commit message did a good job conveying why this is a 
core bug.  Let me try to add more detail.

This is an OEM system that has 3 USB type C ports.  It's an Intel 
system, but this doesn't matter for the issue.
* when ucsi_acpi is not loaded there are no power supplies in the system 
and it reports power_supply_is_system_supplied() as AC.
* When ucsi_acpi is loaded 3 power supplies will be registered.
power_supply_is_system_supplied() reports as DC.

Now when you add in a Navi3x AMD dGPU to the system the power supplies 
don't change.  This particular dGPU model doesn't contain a USB-C port, 
so there is no UCSI power supply registered.

As amdgpu is loaded it looks at device initialization whether the system 
is powered by AC or DC.  Here is how it looks:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c?h=linux-6.5.y#n3834

On the OEM system if amdgpu loads before the ucsi_acpi driver (such as 
in the initramfs) then the right value is returned for 
power_supply_is_system_supplied() - AC.

If amdgpu is loaded after the ucsi_acpi driver, the wrong value is 
returned for power_supply_is_system_supplied() - DC.

This value is very important to set up the dGPU properly.  If the wrong 
value is returned, the wrong value will be notified to the hardware and 
the hardware will not behave properly.  On the OEM system this is a 
"black screen" at bootup along with RAS errors emitted by the dGPU.

With no changes to a malfunctioning kernel or initramfs binaries I can 
add modprobe.blacklist=ucsi_acpi to kernel command line avoid 
registering those 3 power supplies and the system behaves properly.

So I think it's inappropriate for "UNKNOWN" scope power supplies to be 
registered and treated as system supplies, at least as it pertains to 
power_supply_is_system_supplied().

> 
> -- Sebastian
> 
>>   drivers/power/supply/power_supply_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index d325e6dbc770..3de6e6d00815 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -349,7 +349,7 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
>>   	unsigned int *count = data;
>>   
>>   	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
>> -		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
>> +		if (ret.intval != POWER_SUPPLY_SCOPE_SYSTEM)
>>   			return 0;
>>   
>>   	(*count)++;
>> -- 
>> 2.34.1
>>

