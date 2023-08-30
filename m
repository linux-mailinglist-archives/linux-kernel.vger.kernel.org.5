Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFF78DFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbjH3TRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245649AbjH3Pri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:47:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF15B122;
        Wed, 30 Aug 2023 08:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZN/AVinUn1qV8EbQMFy93kE3l5Hc/Epr25UgNUgUUMuqOQkasn6nGx4KWc9SyFS7u21SYkI/DZC+vC1qY20US9ac+GmiVPdpDZyvPSITbyaA2iNt8UZ1nOWwucIcM6W07YSRs5MOwIInNbZ2fNP8/CguNH4ckz0IRSdmXOHHZrQOlcA4thgU/TqJ7WSHsYXdS95gRUF1i6Jk/0Fgnd+/Q+KaBJffTzZD3m7KPw2ipbvtTQ4DzNFPKqjHCAv5H5yUU7f/mi/DfvXnhzRj4atM/Xrf0FN8FK5/3SPbE8n+SV4l6XagHzazPFO4nedIWMz7HCbOzuLuZiiu+WBxHp5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9ExJ8yE4v9Ksz7uydifjCz0uXxOl4r5RgPMLRw792U=;
 b=OIVUsmUjRdjfDot/0MByd37msNy/Z7sZL6KGzF1gD88oQbqQxtjfXO3RySDVlcmY3vvemhLJSO0jvmEHSVb+FT1CAdpotCozhSHDQ6b8qFT6yzM+bdun47XKHcsuDGFxxTyKKZtO4k7sli/8GNN9pZvWGTM8hpm2tZFOVjpDQj7Z4WexHGHiMSfXlic3Qu8acwbOaEqLi9Y9BtaFrwuuJ8tomzFaxBkKh8Oxx/j3R7dCQba1OnlXdCwp+jNRcZ+vOsETxL0f2dcMeEQWyYjlYjHbleE0GsyyD9qhwVhFymQIuDYAGcWn2GrKqEz12MzYUvGsQ6Fw++2bMdC+aP577w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9ExJ8yE4v9Ksz7uydifjCz0uXxOl4r5RgPMLRw792U=;
 b=o304/brYTHGgmq13NXkOTeBANWA6hzkM6Bb3nPDQCxDM/Uc8Cz7A2e1+RNcvZ5fJOhZemsrTP0wzwU/2wWF+ZdUvV0qAGvz4IgKsPFNY9tb6D+/lT0kO7s16Pxp396QAdmi04eVEvCAagVVVz7FncrQFPicgza+hYV1Ja9a34wQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 15:47:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:47:32 +0000
Message-ID: <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
Date:   Wed, 30 Aug 2023 10:47:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, linus.walleij@linaro.org
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: bcca1bcf-1c71-4cbf-e4e8-08dba9706c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GP9ORYvreJ3waWFciyipy/A/b3JdFItGJ6tmYTvtleS7GYkrzRPloOgHfDOPr0VLRrSg7GOoMY+8SPWpiakrsBx/92HOr7XN1aTleJTrDN52BGwQMT+qHwuga7Vya577vXsRg+EE0GfotSwdwUuAxcPuhkheHelCUGgvTLBsrT9zfNr5z/YRH/IZGOL5sCqqR7KIVJJoOUfLOmhlj3pK0EG9thVUnrVN09nj9f2uPrmW0GkkN8KM+M6GaRWJ3Zf9rMQTaN0dY0fOxVeJYafvUIYXlmvGWAD2SdD8qVey6QEoVWFiJi5mAXfnxNMyqgVF8FwAYY80CA06Qrxr0Q1BTPUtitQvCA6vLDHgM1OvTkR5BYYHoIpFwAy7KGnh3teluvy4+4HyTA4ckQbodbcl42hmbv7KPU1/w+q74TkIvNlhptotFQ2gfavaJJc0lOvvO4InF6SFcMfQT6b6ovpA+iOgj2p2DnWaXjLDrNEAoVuYcs2+sUIFufe9+Tvcq0OwioaPRDbdzdnM8Q27A3khu9NictYy0IiEhx9210xU74QkQx7GYHVsQhHy09VRJg9C0WkHEOj/6Hkk9HXUNYue6PWf1JUOTFOMmEZPuuOHnQxHJXbEnIzm/Ol+RsYnqVxnoV+VV2Jb5FVUZ3f9qXQ7ft1bCHAc+cLbz9GmAPK0Gw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(5660300002)(2906002)(44832011)(4326008)(31696002)(38100700002)(478600001)(86362001)(966005)(83380400001)(2616005)(26005)(36756003)(53546011)(6666004)(66476007)(6506007)(6486002)(6512007)(316002)(41300700001)(31686004)(66946007)(66556008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0w2S1dtbHBSQkcyREdBOFRwQllyU29PMU1nOEFWMjlSQzFuemJ4Umd4M2Mz?=
 =?utf-8?B?NVJvSDNlNkpUNUErVEVoMzI5SXc3dEZ2bVpOUXhaYWxNckNKQ0thRXQ1dTIv?=
 =?utf-8?B?czRQVjJzNCtiTHhyYlgxMGtIcWxhL0Q4aCtkdDEySmdwTkRKOHE3ZisxUVUz?=
 =?utf-8?B?ZHM2WFZVQW5YVnJxb1V1TnhVVnNXSXEvQlMzRFdCUDkyMXd6cTJJeUZRYmRs?=
 =?utf-8?B?dGxQQWZJcmpNK2FkMk1RV3FHSEY3Vk5BbmwzbHZxaGJsWUgwdHJ0WE5hb0RH?=
 =?utf-8?B?S2J6cDU2dlZUM2s0YTkzY1UydDZmeDhsRFNocGlHbGJTY0NKRWhKVGI5UEFr?=
 =?utf-8?B?UjdENk5CQ3JUdm9IbGFLLzBReVlVaHpNUmRCcGN1clZmczZ2Wkc5alZtbEli?=
 =?utf-8?B?WTB3dHpBVi9xK0Y1b24rdWlxZDNLZjdnelh2Mi9KVktKMURvaFdQSTVaYVNs?=
 =?utf-8?B?aFZaU3hxaG8vK3JKQmFSSDZEVGpQcUJQQXB4a09vall0YWsrUlp4SzhNWE5a?=
 =?utf-8?B?U0gwUlNZempabU80UlAwbGRVZjhYZWhuWkJiV1NkV0ZSUEF5MGtIVzE3aEo3?=
 =?utf-8?B?MCs1VVBkVVVvS3RQdjBLaVNlNTF3K0J6c28yUitWZEs5ZE5aYWdQU0E3bSty?=
 =?utf-8?B?cW1jQXZkWitnLzZYdUtuYjZ2NkpIem5UTEo4MkZjUSs5Z3dMWTIrU1pvYTdW?=
 =?utf-8?B?N25oVGlMZTFnKzNYVmI0aERDNWdBT0RBTS8xOTVTdE5rRWpORzFBaFptZ3VL?=
 =?utf-8?B?ZmV0UHZOZDlrbUNIdmIwVzNrcUtXZmJFOTkyQ0h5czJTRktreFl5NDJnNk02?=
 =?utf-8?B?WEZlRnJKTC9SYlZNSTlEM0Vnb1dHc3BlN1dMN01HNkNkdDV1bXU0a1N1ZnBI?=
 =?utf-8?B?NkM1eUsxZStoVFQ4cHBHOTVlRHBucXhVQmJhUWJCeVV6Y3BaRUFQVFovc2ZT?=
 =?utf-8?B?Rk5JN2k1akNEVGVWK1AzeVNEYkpBOVRIa0IwbDFvcUN1d1Z4Q2FvdjR3YU5u?=
 =?utf-8?B?NnkvUjhCNnFUQ1VhdGV6WU05RGY1R3lHMWtBZUpTb2xxUXNPRmhTZGVyTE8z?=
 =?utf-8?B?NWFkZ3BCNFovemtCMjRreXRoQ0R0alNpRklERWVJNVQ0YkhhZk5QamxaaGc3?=
 =?utf-8?B?b0lwbGo2L0M0Sy9qTW16bE5keHQ3YWxSMkJZQ1VzYmtzdUw1YmFBOFpqNmEw?=
 =?utf-8?B?WWhrcW1FUlV0V1VxbVVPc2NUT09GQWZHQU0zSmp3NHhFbUhVeEx1d0taTGhl?=
 =?utf-8?B?ZFNQdm1NQmJJa3pyeXY1dHpKRU82UkJ3QlBsVzd1TGJqaHJ3ei85cW1SdVlJ?=
 =?utf-8?B?b0crK3podzByY0hMR3RpL0JkL3AvKy93akx6T3hib2xNY2hhL0Q4UnoxcTdE?=
 =?utf-8?B?TTRiaVFFWTROVzlBbng4RmdwZkxIUTE1ZnNodzdmVXc2b0FJVGhFMm5HaVFv?=
 =?utf-8?B?UHlRVFhtbGJkaXprMk5uWHNyVVppUGVWR2hlV2xWMG9tN0JJamlBRFg0SU1D?=
 =?utf-8?B?MnhiRDdjRW0vcEtOMlUvSG1Wb2tPbGFnMkRMWjloQzEyQkRFc2FnYlRuMHlT?=
 =?utf-8?B?Nlo4Nk5sYUZmUC8vdkF3bkp2NUVBOXo1ek1wTjZJNWorOW5kZ1JrMFhzQTRh?=
 =?utf-8?B?cDZuNUc1Y2FWd1JOOTc3TjFscmF2VUZteU9pdzlTT2t1bk5rcE8wZy9JYjlL?=
 =?utf-8?B?UXdpUW80c09pTDJSZWpCZkdTRnFoVXhQOGJuRVVMTWs3eTBPMkFXM01xU21u?=
 =?utf-8?B?MjRNK1pHeFEwcDc2aDVVY1FjOGJpcjBYaE1hU3U1ekdqcnlhRHROc2pUL1g3?=
 =?utf-8?B?RDk0RDRWZUdLNHlKcEtsREZBZWMzTnUzUWRFZ09JaXZXS0xNd0hjZTZBaW82?=
 =?utf-8?B?dEJ3bGN0Q2ZhYlFRazlDcVhVUWliLy8ydGxQUDkrRmtWV0dYUVRVU0tRc0J2?=
 =?utf-8?B?bDFqK2orYlBmaFZXUDFxcXVNVkVaUVFSY1o3MmtuaURLbzNGRTU5TEVHTWdC?=
 =?utf-8?B?YXdNcjc0aFZXYUxtWDBaMmI4UmNweHIxMjNBcWZJQmhVN1hDTEtoV0w4cUlH?=
 =?utf-8?B?Y0kzZjVlYzBDUnZMQ3JGZDZraUxSZzRpbndwRWg5RnNtaFgxMWNQbXBXVXoy?=
 =?utf-8?Q?GuQrGXzVRxkccxlkhEkWW5DIf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca1bcf-1c71-4cbf-e4e8-08dba9706c1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:47:32.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KtUAIEVL+xlzUv4qMVBdVJGTmCJawdMfFy0Iksi3gbCs5wIhpXiA7INMTpDd0ASPAY9geStymsZdWW/Ev1FGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 10:37, Hans de Goede wrote:
> Hi,
> 
> On 8/29/23 23:37, Mario Limonciello wrote:
>> On 8/29/2023 14:54, Hans de Goede wrote:
>>> Hi Mario,
>>>
>>> On 8/29/23 18:56, Mario Limonciello wrote:
>>>> Lenovo ideapad 5 doesn't use interrupts for GPIO 0, and so internally
>>>> debouncing with WinBlue debounce behavior means that the GPIO doesn't
>>>> clear until a separate GPIO is used (such as touchpad).
>>>>
>>>> Prefer to use legacy debouncing to avoid problems.
>>>>
>>>> Reported-by: Luca Pigliacampo <lucapgl2001@gmail.com>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217833
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> I'm not happy to see yet another DMI quirk solution here.
>>>
>>> and I guess you're not happy with this either...
>>
>> Yeah I was really hoping the first patch was enough for the issue.
>>
>> If we can't come up with anything else we can potentially drop patches 2 and 3. Even patch 1 alone will "significantly" improve the situation.
>>
>> The other option I considered is to hardcode WinBlue debounce behavior "off" in Linux.
>>
>> I don't think this is a good idea though though because we will likely trade bugs because the debounce values in the AML for systems using _AEI aren't actually used in Windows and might not have good values.
> 
> What if we turn off the WinBlue debounce behavior for GPIO0 and then just hardcode some sane debounce values for it, overriding whatever the DSDT _AEI entries contain ?
> 

I don't think this is a good idea.

Some vendors GPIO0 doesn't connect to the power button but instead to 
the EC.  If it's connected to the EC, the EC might instead trigger GPIO0 
for lid or power button or whatever they decided for a design specific way.

I'd worry that we're going to end up with inconsistent results if they 
have their own debouncing put in place in the EC *because* they were 
relying upon the Winblue debounce behavior.

After all - this was fixed because of 
https://bugzilla.kernel.org/show_bug.cgi?id=217315

>>> Are we sure there is no other way? Did you check an acpidump
>>> for the laptop and specifically for its ACPI powerbutton handling?
>>
>> I'm not sure there is another way or not, but yes there is an acpidump attached to the bug in case you or anyone else has some ideas.
>>
>>>
>>> I would expect the ACPI powerbutton handler to somehow clear
>>> the bit, like how patch 1/3 clears it from the GPIO chip's
>>> own IRQ handler.
>>>
>>> I see that drivers/acpi/button.c does:
>>>
>>> static u32 acpi_button_event(void *data)
>>> {
>>>           acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_button_notify_run, data);
>>>           return ACPI_INTERRUPT_HANDLED;
>>> }
>>>
>>> So unless I'm misreading something here, there is some AML being
>>> executed on power-button events. So maybe there is something wrong
>>> with how Linux interprets that AML ?
>>>
>> The relevant ACPI spec section is here:
>>
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/04_ACPI_Hardware_Specification/ACPI_Hardware_Specification.html#control-method-power-button
>>
>> I did look at the acpidump.  GPE 08 notifies \_SB.PWRB (a PNP0C0C device) with 0x2.  According to the spec this is specifically for letting the system know the power button is waking up the system from G1.
> 
> Sorry, the acpi_os_execute() function name gave me the impression that this would actually call some ACPI defined function, since normally in acpi speak execute refers to an ACPI table defined method.
> 
> But that is not the case here it is just a wrapper to deferred-exec the passed in function pointer.
> 
> To be clear I was hoping that there was an ACPI defined (AML code) function which would maybe clear the GPIO for us and that that was maybe not working due to e.g. some opregion not being implemented by Linux. But no AML code is being executed at all, so this is all a red herring.
> 
> Regards,
> 
> Hans
> 
> 

Something we could do is add an extra callback for ACPI button driver to 
call the GPIO controller IRQ handler.  Worst case the IRQ handler does 
nothing, best case it fixes this issue.
I'm not sure how we'd tie it to something spec compliant.
