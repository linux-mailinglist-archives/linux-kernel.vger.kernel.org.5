Return-Path: <linux-kernel+bounces-71581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDB85A74E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BD31C21652
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C63839B;
	Mon, 19 Feb 2024 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sL6Kpenn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AA38393;
	Mon, 19 Feb 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356253; cv=fail; b=ZxKdT0kYv0ufRxSWJXlSdBbIZJqPRsb29Ij93FnMRVd+x1Yhux1YXh4lP94oLyu+kODWHZvJi3k08oWphFq+ilM68aU4qwBoGKMb2pLnGuJ+FyjWbfgA9a3bz0/52HGNI3pbWSxpG8yC4CUIBY8meoetMTOAuLIbRp262Vk2M1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356253; c=relaxed/simple;
	bh=XPA+tLzrgpmhgiCn64SkIypgC/D1jO5mOtrruldg1Hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vBSfwBx7v/cFSt2vibJen79EJCbcTCFk6Rl8pNOLk01nvXfDDZ42aiPE6EyYApUWaVWrSshqL8nHDBhdfr62zewN9zM5uEvgkwi0U36kskyQanmNK/F1bAWfisCnyfPJuiAKppus8UUl51EgRDswtUC95ATNB/USfzVK5LHvSbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sL6Kpenn; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxw67wBm9kwcrw61olCd7DrCoS/7nq2OuMb/wDOhLLbJlURslwigs2BeBTHF3qnL8iyj+Dms5SVqlEvC15aCxM86vWTOWmEV9aRAmcdgtaY8ulk2HACV7kUU9uWjoCtHb9twJRw2FhggRPDvF61C/+L0igdSlIoy+pJ94dNQd4js4sJX14OWbub5gvM50DrKVyx3Nudb4aMYs2/LCOphXDvgu3zW1eQJDxvUE3WD5P6vQWDGSbNafwpZ15AhwQ1eJrvmOAjcuj4GwQgKpoeFlG0JaHZA7FCnxayj4CimGAsalRgWqWv4kMR+ZCnADN45JR/UT68RxDovHOx9MHS9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Shwao8wddiI10LjsSp4eDSxk1TbzAwLgOR4uaH9H/hI=;
 b=Wyb1BEH9RA6lUDrlWhL5Dpeidg/P4Zeb0ms8RATc09xckIuPbEsvVFOAh5+woHvZWqm0+hVMFDDDK8e43XjVmJxj81tK8q1boRB2bmt0DqzBt23N6kG2hKqoxXOUd1EgzMSg7LgQkuPxeOCTiYEyH0xspj20FXOlyulTiPbyG3N2jgQKKyetDT7cVC6ek0D8HblCGMdKJOChkWMvk3l/cwXWmhy8chs6pBhNaFmzx1uJtGluwYzdBft+JKBGyL3/Wc+66ANKQh+To9HvB2l5c8+DBdXAwzm0LbDrpKF4tONBj+GbjCddvvppdz6MmHVJ5/qK6bdRtsXHQB3uNYNolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Shwao8wddiI10LjsSp4eDSxk1TbzAwLgOR4uaH9H/hI=;
 b=sL6KpennkwCiOI5ZJ2+SUEogcyAd4FBRBYXwwaJiHXkWG7QgIq5l+v0QpCTmRbal8dG/5hH66WPMXE6UgjcDHkjEXCucSJfhip50ctGU8KqHlnfcINW/gM7z/Dnc2klOcgXeDm7H47hbiOAMqRyL73LYAj868vA6HIZFSGqY4iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Mon, 19 Feb
 2024 15:24:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a%7]) with mapi id 15.20.7316.016; Mon, 19 Feb 2024
 15:24:06 +0000
Message-ID: <67a6c770-8638-4d33-b2ee-faff1dffe3b4@amd.com>
Date: Mon, 19 Feb 2024 09:24:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Only update profile if
 successfully converted
Content-Language: en-US
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Hans de Goede <hdegoede@redhat.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20240217022311.113879-1-mario.limonciello@amd.com>
 <b37b5e6f-c719-4ff2-b16d-96716e681ca9@app.fastmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b37b5e6f-c719-4ff2-b16d-96716e681ca9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 1402b40a-c58f-4df9-e5ed-08dc315ecfce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mccUX80D9N7TMWqHdL5vAnfYrxYLdqhx5hAndhsvDLNbfzr8/5cw3wh7ojlRgKr0bgXi5YZTpBG/2o09VCn5Ggn9njy4fQdxLqemH9EojuEUrMNHLxVZMZZYY1s28rLbXkwTQpgTY06EsLUJ/i9FrIYnozGxaZzcUAp2LkvY2+877z2lWKFJi1qF0c0UlOe7X8SiNv+/WwUat8skonOo/Lcj3aLm0rdzqPpgzKDTaxukLzZ4ZtjE2XEG95Kn7RBscPB+ib5qrZBFKHunkoYmaZmC6bIinYEUT/GqJBfTmy3hx4V4uysqKoxRrrDB7wyoVudbciJHgjiba3UGGD6gt+08VqEF63aCKJZv9nkj3v/qALLfAMw7jcVWsHH6ZgC9P40/+4SUbTrQ47nY2mClygdZsoz2PT0ydHT0woqmh1m5b6O9yhR9i9gwiFEqKlN0sN6dbumPfygUK+NpPTYBLyRTTK6QZrJAGtD0BXAg86lxd2bdbtBMAOftu9/f6CWixd2o8UbHSF7/oCAuEOTpkxEn0K/4MnV57qVih0xOflknGbSFs+3tefuHiC/LDAl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHlWMnYwSysxTGxPRVpHbTlzMTZqdExVQ3JHNEtUMXJ0NHpCaVFyRk9HT2JK?=
 =?utf-8?B?d3cvbXVPb2ZkVmRNd2c4S21zVER4Y2dCL1hRQWhBK21ZTTNZTHkvaDRBWEVS?=
 =?utf-8?B?VWFubjBobXFtbUFoT3BNWnRyK2R0dzRiVzdRdVY1Vk1YN3l2cjhvamxiQ25o?=
 =?utf-8?B?UzBVZERoUjllaUlLRUxKL2JzMzNoSTgzdEZzbWFnUGZSbTJIV0ZoY04xT3hy?=
 =?utf-8?B?WEp4Vm9Ka3V1V3JmMVVwSFVyM0dIV2dFai9uYTc5czRQT3kvR25sOWw0OG9o?=
 =?utf-8?B?OHpYRlFwU21mdDI2U3lBRDlOL3FjOVBLZ3FoNHBEWmhIcVAxVGtHOFhBbWI3?=
 =?utf-8?B?VGhPZi9peUhTT2VJOFlmeG8vai8yMFpZUmJrdkgyV2RkekwxQThFSGE0NUVY?=
 =?utf-8?B?UlkvNjl6Wm05WnZsYVZRV0JSVjAyOSsvKzBEREpXbUJ0VXNrSm9KQUViRjJ4?=
 =?utf-8?B?NExUcXdGZXFycGNvdWxrcnhpM242R1pGamtXTWkzdS9SWFNuWVZHc05yWWhL?=
 =?utf-8?B?SHk3R1FqZ09rT01xZUpWR2lWTVMxM3BRNlZXRnRZbDFieU5xa0JuTzZwQmQx?=
 =?utf-8?B?UXVxSWljbmxDM2lmeXlYblI1K2s3c09OZWxHRlNkOU9pVCswV09yOVhEOFlY?=
 =?utf-8?B?QTVFK3huUXFRL0dxTUhsRWNHamZ1RFNVVFZHRHk2aHMrNWFUeFVjMUpxZU1E?=
 =?utf-8?B?LzVsS2Jmb1NEaTJZcTBtdjBsNU9rZnpqaVM2bXl0WTBINWU4MStNcnJ4RTRk?=
 =?utf-8?B?YUUvYVBmMzNKVXlscVVFMk1wWXdQcnFwMkE5OUdNS1dtT0dQOWR4cTFVbVh6?=
 =?utf-8?B?L1dPdnNydk8zRzVEYUhodnhMbXp6MWF3WXQ4aFhMWkR4ZnBxMHlNM0lrSmZR?=
 =?utf-8?B?dUFDbEFVSnFBRkRGUmNuZDR6ZEJEWnl0b2duaXcrTmtoMGtFTzRkcUN5ek1z?=
 =?utf-8?B?S0JTOEg2bG16RDZXdG5kVFhUeFRXSUZRTVlHREZmUkNFWm1sOGk5bkN2bzlx?=
 =?utf-8?B?Mi9sTW8xeWlOS2ZJRE0yTll6SXVHTDBTU2tZUkdtU0NiR1AvbFVUS3dGaHlz?=
 =?utf-8?B?eG9vbHpmNUU1QjZzb3I5YnZVbWEwZHdCczhEeDNNcG5lTjhVMmJPZnJlNFRJ?=
 =?utf-8?B?OG85RVN2R29uR0JJNGl1eHdnM1lnSWppbjdJdHF3UXo3VkVLZ21OTDNBREpO?=
 =?utf-8?B?UWFQMFZhamJ3cCtva2g4NEpjWlkyaDhkTHRyYU9xRktTT2dwQmlqenErVi9B?=
 =?utf-8?B?VnZlNTUvRHZwQ2t1TGxLOHN6aGpPUzNGaDVxK2ZoYWJ0dXFadUpLUUNVZzF1?=
 =?utf-8?B?N0JWdVV2TGtXNkpCeUpmTm9JbkVQRkVmeDJMeGNxTHZsNS9KTzlEelRRNXoy?=
 =?utf-8?B?b0xCdHQyRTVERHQ4bzU4eERZMjF2elo3VzdRWWZ1SVVSSzlsMXFIK3h2RCto?=
 =?utf-8?B?dUFmQ2k5ZGp0NHNFRDFLQ1QrblY3NWdNeENWVG9KWm1HZ0pqSFhlODJ5RFlS?=
 =?utf-8?B?ZDU5ZFJJL2doOFdsVnpYZ25GdS9BY0RmV2F3U1VSNzRZUXZ4M2VHbWhYMi9o?=
 =?utf-8?B?WkVPOE5rRWpuUlV2MjJQWW9XNjZJUlpmTys2VndiUCtFTnpoZFF4Y0VhV1lp?=
 =?utf-8?B?emdjV0sxS3pDT3FpdlF0RGFMM2ttMDFNdFh3ZFRrVmxPNWRtSnE5Sk9oc2hI?=
 =?utf-8?B?NEZMbWpyTUFoSjFpdkJqK1A0M1FzWHRTcE5xN2d2VmREdmRKNy8wbnFoYno1?=
 =?utf-8?B?Y09zNzZEeHd1dkhGZlFtajVSOGE2b002NWdxNVFIa0J0MlpnTlJrRGJRK2pL?=
 =?utf-8?B?Q1BCOEI5a3c1dEFpTWFRdHFkaThkaUpldXFEaVRHUkd0SXBVMnh4a3MvdzlC?=
 =?utf-8?B?K1hBRlVrNEplamRwa2lpaytJSjM4SW5sanJsZ1YvcC9kU2ppM3J3Q2ludUtH?=
 =?utf-8?B?MWJnRVJpUHdCMVpjVlF5ZUFBOHRqd1hmSEpMMDRqOWVWM2xZVDJJR09ZM1JG?=
 =?utf-8?B?cFNpOGxiQUxEREtjdzZWRzNTWWRUMk9Mek96NStRQTAxaFhaUGtEVVlCc1Zm?=
 =?utf-8?B?RndOM3M2RWpkb004ZWNjY2J5OWtNYUV2MnJWY2Z3enlGNFNtNGIzTWUyd2Rl?=
 =?utf-8?Q?hfDMUH4K+ASSupO40NwWS8pA0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1402b40a-c58f-4df9-e5ed-08dc315ecfce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 15:24:06.4550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFzLujW+LEzl1x7Bg/RAKL8WTAknkhbzfsYV7EbEWSBFELlfTCFqf2MlC5KVszjJnfZuV7T2dlMxPLCCzgdvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829

On 2/19/2024 09:13, Mark Pearson wrote:
> Hi Mario
> 
> On Fri, Feb 16, 2024, at 9:23 PM, Mario Limonciello wrote:
>> Randomly a Lenovo Z13 will trigger a kernel warning traceback from this
>> condition:
>>
>> ```
>> if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
>> ```
>>
>> This happens because thinkpad-acpi always assumes that
>> convert_dytc_to_profile() successfully updated the profile. On the
>> contrary a condition can occur that when dytc_profile_refresh() is called
>> the profile doesn't get updated as there is a -EOPNOTSUPP branch.
>>
>> Catch this situation and avoid updating the profile. Also log this into
>> dynamic debugging in case any other modes should be added in the future.
>>
>> Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile
>> support")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> BTW - This isn't new.  I've been seeing this a long time, but I just
>> finally
>> got annoyed enough by it to find the code that triggered the sequence.
> 
> I've never seen this on my systems - is there anything in particular that can be used to reproduce the issue? I'll follow up with the FW team as setting the profile shouldn't (to my knowledge) fail. Agreed it should be handled if it does fail though.

I think it's mostly at bootup I've seen it.

With dynamic debug turned on I can see the "Unknown function" prints 0x0.

> 
>>
>>   drivers/platform/x86/thinkpad_acpi.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/thinkpad_acpi.c
>> b/drivers/platform/x86/thinkpad_acpi.c
>> index c4895e9bc714..5ecd9d33250d 100644
>> --- a/drivers/platform/x86/thinkpad_acpi.c
>> +++ b/drivers/platform/x86/thinkpad_acpi.c
>> @@ -10308,6 +10308,7 @@ static int convert_dytc_to_profile(int
>> funcmode, int dytcmode,
>>   		return 0;
>>   	default:
>>   		/* Unknown function */
>> +		pr_debug("unknown function 0x%x\n", funcmode);
>>   		return -EOPNOTSUPP;
>>   	}
>>   	return 0;
>> @@ -10493,8 +10494,8 @@ static void dytc_profile_refresh(void)
>>   		return;
>>
>>   	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
>> -	convert_dytc_to_profile(funcmode, perfmode, &profile);
>> -	if (profile != dytc_current_profile) {
>> +	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
>> +	if (!err && profile != dytc_current_profile) {
>>   		dytc_current_profile = profile;
>>   		platform_profile_notify();
>>   	}
>> -- 
>> 2.34.1
> 
> Looks good to me. Thank you!
> Reviewed-by Mark Pearson <mpearson-lenovo@squebb.ca>
> 
> Mark


