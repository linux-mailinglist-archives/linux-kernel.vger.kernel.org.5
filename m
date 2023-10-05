Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73257BAAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJETvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJETvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:51:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9FDB;
        Thu,  5 Oct 2023 12:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/9ChjuUfAmkXx1Gako2bFoy4wf6fXoB9yu1X8uR5yF+Bc3IZQt0klVYt7LdawfxblxfqREkXzwKLjQJ5ohSKIib8DlydkUFCLthflMnRU11Ju4wGMGG7Ywa4zgFiitcPPQTXvrGNZ5z+2kwugmVBPCZvKX3Brn7PEP56gT9CR+yXTCQrNXtPikDIbWAdHNPGdcVkfWZouc0e9HPYsBZKKU+TR5+SUPZYUhWjbYjSseJhjH2lej/05LLzdRzHgAnL+J99/kw2JNaOzRXEj2gVjedtFQH6fClCeBwBT/OL3qrIMoQs2DqZ3Ku01OLUcz0oCLG40fUXaHR5bLryQrW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCh3OaiPiQPL56kHtsbVeclQ2AbG3CuN/xqBXmfV3cA=;
 b=c++728tetmu3q1GXpMvJPmvHROGPBMJVWlLGzBj1zpMl1Uh0JMXBFx0O9760+8EOIbphH/5l5iddKdihR/4WwLHIWVAjbC72U03TjxyzWiIGJsktzLdEB45fU+gveHXigdoJk7fM+78gSdnqHnCRA1mZoXkd29fRS3x8NvuvejCQbwAN/nH6PaCcMsbVOakxJU0o0y2b/e4D9+BCic9aLLY0BkBthf+aj7NH1F7sr77gh9tPqzlXBL7pe26OEak0Bx14lPUZ1R3f6OFTb+NLDxMlJEyDMfh1A8XiNscpA6eKFUy3CTqxzyBo2BqlfPFFUCEFMApYvMLfHHWpGCgXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCh3OaiPiQPL56kHtsbVeclQ2AbG3CuN/xqBXmfV3cA=;
 b=mwhLA0bTozB/qU52qLEjZMQczb7/0HCxkyDR4H88p0p00DBVejmJY2xrJiU0JcMxeLwDfwT7GS9WyIi9Fd86VIsn3Ity0fiUIcLk4Ir4e9fPPFH3a6vo8swerp+Nf3sBX0ibhJB7whRD6P+tW2hjenpiPLIM/NNcFWlAUTecQyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7877.namprd12.prod.outlook.com (2603:10b6:806:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Thu, 5 Oct
 2023 19:51:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 19:51:42 +0000
Message-ID: <3eae4aad-37ff-43ae-9d1d-20850ed8c3ca@amd.com>
Date:   Thu, 5 Oct 2023 14:51:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] power: supply: Don't count 'unknown' scope power
 supplies
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>
Cc:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ma, Jun" <Jun.Ma2@amd.com>
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <20230926225955.386553-3-mario.limonciello@amd.com>
 <20230930201826.biy27esyw4ttxt4p@mercury.elektranox.org>
 <8d4e4b74-4477-41e0-a690-8b9f38907a7b@amd.com>
 <20231004231003.z55btgajmixxadqo@mercury.elektranox.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231004231003.z55btgajmixxadqo@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:8:56::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: e929c40e-0155-4a58-0f46-08dbc5dc7f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWKr+dLh3FBopGNcmR9NT35vHZwqVfZq4OuNqPLeVCXGeJ5mU/qCahIB2TDy3BgkHzclzevHHptNNpzavUr3BctwVSnJSfItHD5dj1D1mTtBJ196DQH0UyCLSblPfROX1YlnaEbFpeRpApnL8zTeuGY7KQmgyluccF+jARCEajjee3pD6yivAfPyhgHN6YesxpzeIQ4rVQHx0iPE52OK6taK4hdaR5NWYa5C6rpQC1MzimiMDT1oJzuZ4vTEyZrUoswAUA4OqhmO7BQrmyYAlcuA6AX4AdddDF3XKJxK0APhz2Ah4fYx3VGEl/+cYBQxEJa7dU0dgtQ8UkrCAjPKqNP1KgijKxZHrmB8vC+B2H523uXHb9uBn19TF2vIR1kjbAEQiHdYVb2gSvJuFDG+YIjqLBrMxw6lHXHjVYXGP2bI9GkwoXRflBlO7lsv3pzF2SMP3UWqS6MEjzQse3fl6etxAGEIpKmLZntlXto5PgxY+m9juzhgUS1wzErrALCiC8v8Ekt6tjioUTEHP9kx9WwUIQLcqZpmPNq/RItxRWgX9+ZcwnCxSXstVQeaDLNSgXuY+kkQ0DIkXAvF79wu//oZqiMMPqbLjZHyru3qBOb5WHoaeiR4ZxZvTMYO3mZNEKqmM7GCsafEd0LOaQNIBgWCogmHElqk+AR0flWYlg3cAew1il7DjWV5pLcT9X9O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(54906003)(31686004)(66899024)(6486002)(6512007)(53546011)(2616005)(6506007)(6666004)(38100700002)(86362001)(36756003)(41300700001)(478600001)(2906002)(966005)(66476007)(83380400001)(4326008)(316002)(66556008)(8676002)(26005)(8936002)(6916009)(44832011)(66946007)(5660300002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJRVlhwTVViblhyNWxRdHJvaXJZV0UrbVpJSTRHZEplOVNiVEVUZE4zVGhT?=
 =?utf-8?B?THl1aDJzSkRIN3ZiTWQvUittNHoyQmxYUHZ1aG9NdDBOMGxlNk1iVTdNUWIr?=
 =?utf-8?B?WEx4MCtubktIRW13TGVZMjVaU0ZBbWFLWlZudEx4NW5rQXhYREszRS82S1oz?=
 =?utf-8?B?MVN3cFVRbzB4SWpWMHRyRmUwYWEzanhDUlZKZndEbFEzbmpYd3pMQWpjSXc5?=
 =?utf-8?B?dzNNeHRoakczS21BR2hVNElIcndrMElZTm10MVVUSWtUTlhhNk9COWJkcFJI?=
 =?utf-8?B?WFU4VlVic1hDcjNndzFjWTBiMEg2TWlRR1dPTWRaaHJMdG9wTnJpcmtZTCtS?=
 =?utf-8?B?bnNRTEc1aGYraXlqc2RObjRieUZRQXZ0Y2poK0VudW5sUzVXSmR1emJ5RGxw?=
 =?utf-8?B?OEs0VnRDZVQxaC9FdC9mdlJ6V1dBbzZ5aUMza2NWQjlsMGduTmN4N3NxUndH?=
 =?utf-8?B?YmY0cXFCSCtkSDZwRkVDODZhWDFvVWRuY1ErckJwaVZrc2RwTlpacUhFdGJF?=
 =?utf-8?B?OWVhZERIYkJmeVBDeU9mM0EvcHJ3ZWQzRk5Qa3dQYzZQSW1XMVlKWXozcDlv?=
 =?utf-8?B?RHBFaGJkU0VRdzRBVXNFR0R3aDdoTGgwdDFKRGEyaVhRVkJCejNFam5XaTdV?=
 =?utf-8?B?N1h6amE4L05hanRBUklTRkFEZlhETFoyajQwUTdkdTIzK0tCdmhyMjVTZUlQ?=
 =?utf-8?B?S1lMd0Q1UzVJWVN2R0dkUDN0d2JvUUJUZWZhV204UDAxdzQvNWVydXR2NStN?=
 =?utf-8?B?MWJ3VkNaN0VYZnVORkVTenhSNkVWY0lDcndZTkE3aUI0TTlKYm83TkgzNDZR?=
 =?utf-8?B?dkczbGdzbUJjZ1RwMGVQWitPQTRQaUUvVkQwc2MvZmhRbjlDd3JFc1NFVWV2?=
 =?utf-8?B?L3FjZTBsOHNiYkl3OWpaWCtLZ2NHeUd6ZnVmc3RONlQ1Y3NZWnJMOVJrTmNT?=
 =?utf-8?B?QzNoQnhuOEpjUmM3blUzNFhVMTRCdUVaRnMwNHpDTThTaXhoSVc2NlpTSjJX?=
 =?utf-8?B?eFBnM2ZIVGNlL29uYTU2UXRXaWswR2JQckthY0FZZnJDMy9pamFVSHpsVWxT?=
 =?utf-8?B?OG9hMTVWTlprcE1iVDIyL01TY0hIcHQ5cGwxRGY3NS9QRE5IUkIyUlVuMzFU?=
 =?utf-8?B?R1FvNkJiSjVMZERCM2hxbzFjeHZRMEhJTVZLTjRuait5MWQ2Mk1LUGZGaHI3?=
 =?utf-8?B?akhsNEZCSEZhS3ZrbmxyMWNxeUNpdFlROHorcXQyNlk5TzdLczdVZDAzc3lB?=
 =?utf-8?B?VnVmMjhnRU9jamdnYjNiaGE0WjhMN1BCUHBYc2FQb2c5RTJkcXhiSzZSYnFI?=
 =?utf-8?B?YVhTNFdjMzhZRXU4Q0wyQnBhNmdPeUo1dTlOV3pneksyanRhQnUxNkJISkVH?=
 =?utf-8?B?MVlFdzdjVHEraVg0SkNINTVoSFduMW1kYmRZbmFieGNRazZZcGd6UHVoMlBj?=
 =?utf-8?B?cHAzNVZibC9ncXVMaStrTzFzNWRKS1NyNWY2dnVodjBGSU5oUU94MHowOE9q?=
 =?utf-8?B?T1BJRENLdGd2WWs1VjMwMjJ5RytKVzRHbU9OK09YaVZlUGpmeDBKbHVtdnNB?=
 =?utf-8?B?YzdhaWNaV1BVcWxMMTZCMWZsNkRXa0pIT3luYzNhbm5NNm5ZclBlL1Y1QkZx?=
 =?utf-8?B?K3lubW1NZXNDNWwvLzFoN0NQSnpaVDA0SFNXMGVWOTNJcUVsUndOZzhOTGt3?=
 =?utf-8?B?cmNKUURINE5hRUJkb0psSnJMemYwQk5MdGIrNGRTaWtEWmx6Ry9YbTdZMmc3?=
 =?utf-8?B?ZGJ2K2ZSSjVYd2dsM2Q2R05BeG56YlJsZXR4S0l4NmhiUHpUbVRDWVdXeVVj?=
 =?utf-8?B?T1FZc1A3NlRDRDVFOFlCM1BuMEJISHpxMlY1cHFZSzdLQlR1dHJZeGpzN2I1?=
 =?utf-8?B?bHZUNkVhbjFSeDFDVTZoQUxSbDI4SVdtaVNoc3JrNUFzVG1lNzAzd2pmTjVT?=
 =?utf-8?B?LzdZVXVTcm5DYTFmOHI1T3Y4N1k4dFEvQnZCbU44UkNQRU1WcFdaYjUvRVBL?=
 =?utf-8?B?NjRsZkF0SDFBNDR2dUVBaFZ3RUdFOHhHQmpocW9PZU9Cbk5rZnFoQ3A2eTgx?=
 =?utf-8?B?YUlPcXErQTZldk1mTW5US1ZWUzRVRjBPeW9JZ0NvSzJjdWVGcWdmYmYxa3Zw?=
 =?utf-8?Q?GnKcu+ZEXIGe7KajYXqxIYymy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e929c40e-0155-4a58-0f46-08dbc5dc7f31
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:51:42.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMuW0Pv9cn7KxI7myYYTvUEkTV5k2crGzMKmAFl0lqVT0PKJg6jaAbCGCKM/n6WuSo/gqyd9WveJID033i/lBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7877
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/2023 18:10, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Oct 01, 2023 at 07:00:11PM -0500, Mario Limonciello wrote:
>> Let me try to add more detail.
>>
>> This is an OEM system that has 3 USB type C ports.  It's an Intel system,
>> but this doesn't matter for the issue.
>> * when ucsi_acpi is not loaded there are no power supplies in the system and
>> it reports power_supply_is_system_supplied() as AC.
>> * When ucsi_acpi is loaded 3 power supplies will be registered.
>> power_supply_is_system_supplied() reports as DC.
>>
>> Now when you add in a Navi3x AMD dGPU to the system the power supplies don't
>> change.  This particular dGPU model doesn't contain a USB-C port, so there
>> is no UCSI power supply registered.
>>
>> As amdgpu is loaded it looks at device initialization whether the system is
>> powered by AC or DC.  Here is how it looks:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c?h=linux-6.5.y#n3834
>>
>> On the OEM system if amdgpu loads before the ucsi_acpi driver (such as in
>> the initramfs) then the right value is returned for
>> power_supply_is_system_supplied() - AC.
>>
>> If amdgpu is loaded after the ucsi_acpi driver, the wrong value is returned
>> for power_supply_is_system_supplied() - DC.
>>
>> This value is very important to set up the dGPU properly.  If the wrong
>> value is returned, the wrong value will be notified to the hardware and the
>> hardware will not behave properly.  On the OEM system this is a "black
>> screen" at bootup along with RAS errors emitted by the dGPU.
>>
>> With no changes to a malfunctioning kernel or initramfs binaries I can add
>> modprobe.blacklist=ucsi_acpi to kernel command line avoid registering those
>> 3 power supplies and the system behaves properly.
>>
>> So I think it's inappropriate for "UNKNOWN" scope power supplies to be
>> registered and treated as system supplies, at least as it pertains to
>> power_supply_is_system_supplied().
> 
> So the main issue is, that the ucsi_acpi registers a bunch of
> power-supply chargers with unknown scope on a desktop systems
> and that results in the system assumed to be supplied from battery.
> 
> The problem with your change is, that many of the charger drivers
> don't set a scope at all (and thus report unknown scope). Those
> obviously should not be skipped. Probably most of these drivers
> could be changed to properly set the scope, but it needs to be
> checked on a case-by-case basis. With your current patch they would
> regress in the oposite direction of your use-case.
> 
> Ideally ucsi is changed to properly describe the scope, but I
> suppose this information is not available in ACPI?
> 
> Assuming that the above are not solvable easily, my idea would be to
> only count the number of POWER_SUPPLY_TYPE_BATTERY device, which have
> !POWER_SUPPLY_SCOPE_DEVICE and exit early if there are none.
> Basically change __power_supply_is_system_supplied(), so that it
> looks like this:
> 
> ...
> 	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
> 		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
> 			return 0;
> 
> 	if (psy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
> 			(*count)++;
>      else
> 		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
> 					&ret))
> 			return ret.intval;
> ...
> 
> That should work in both cases.
> 

I tested both your suggestion as well as modifying UCSI driver to set 
the scope.  Both worked.

I've sent out v2 modifying the scope for UCSI driver.  If for some 
reason that ends up not working out we can revert to your generic 
suggestion.

https://lore.kernel.org/linux-usb/20231005175230.232764-1-mario.limonciello@amd.com/T/#m9543f1f2c3767c0e88135c2e3f15ced65cfdf004

> -- Sebastian
> 
>>>>    drivers/power/supply/power_supply_core.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>>>> index d325e6dbc770..3de6e6d00815 100644
>>>> --- a/drivers/power/supply/power_supply_core.c
>>>> +++ b/drivers/power/supply/power_supply_core.c
>>>> @@ -349,7 +349,7 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
>>>>    	unsigned int *count = data;
>>>>    	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
>>>> -		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
>>>> +		if (ret.intval != POWER_SUPPLY_SCOPE_SYSTEM)
>>>>    			return 0;
>>>>    	(*count)++;
>>>> -- 
>>>> 2.34.1
>>>>
>>

