Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE587FAB18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjK0UO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0UOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:14:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D8D4D;
        Mon, 27 Nov 2023 12:14:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJM0RySW+VwuwPftSH/hrBj879GasnRqsRGZv7B4sEU7Adr5asDCmCgCwrBJn5R3T355M/A5cClQRev/w2th2S/JwcannILntjzA3uIoMoFoY/b42NdZaRiRhqxdzJvzOV+e2BaBU2NIrB0zVyEkqxLoB/HsBw3K2L9touUmIJnKFKCnsRvpo00gHdlnfY2E05dGo98l3XgD5J8wMr+JKGGI2VCFJWlgp7+bVMeb2XEYL2Ml7hgLCSFyLzwKg+KWQDsZLS+nsZj78gmUAt0PldluZ+g0IRDI8aFIDW6SPDXp6bNZpElvf+XlQ4bBwhIg2fQwB/Y/8k90FE3Ow6yZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqOYu2fZi8fFJA/y30B/oQaPX7cucOnfPcuUMkDXB/g=;
 b=NEH1x6hjmypJr3J+SL5Us6m7yqwnTQNCexscigyRm0PdcJdJIdCm7X4OKJaPG6njBf5QORqLdIswO2U4zVuT2aIq8096HPHootB7CeUmug2bFF6vp2MigbnYLET9OLsygUCE5E4VF/t6Qdd55VoAYrE8Ro4ans9/gXTOcNS689FnN6nCndvV99agGXybnLfSSq28OX8v8oAmZaRy4WEDeuhhj558vC8KV38qczXRE7E8naSpg1sCG3JlUwS6yIE0x/8XJwOgFai2zXtYf4Q4cckEZ8g2QH6cwmf6hyrAHRGAc0MfWTEx3q4vf8+PysTdNTXiNAy9D6/4iqE03KrKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqOYu2fZi8fFJA/y30B/oQaPX7cucOnfPcuUMkDXB/g=;
 b=ks9KiTkt+fpOqExcvFjOoImKqfHvJUP8LaLolPgzMZV2ah++wzm2RfEZYWrs8D35HTcCwyANPAX3NuIJ3/fll6tL8H1bW7w1s5TE9xsygnBjyYG0/hJZzRi0DUjdpSbmY9BxOlBVETx0po+qt3QHkHtShEIMr/wpQ6+bl3rd70c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 20:14:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 20:14:26 +0000
Message-ID: <30293382-2287-45a2-9269-55d547432085@amd.com>
Date:   Mon, 27 Nov 2023 14:14:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: disable USB0 hub on ROG
 Ally before suspend
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>, hdegoede@redhat.com
Cc:     ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231126230521.125708-1-luke@ljones.dev>
 <20231126230521.125708-2-luke@ljones.dev>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231126230521.125708-2-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 41381b34-f264-4c5b-b110-08dbef8573eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxT64cmMp59R2qxhMvxHuVIt5GObyZmG+DXDuGShU1ul9FUqV2gpA1rOd6Qh4o2FGfL5oCDlh7JcarjlvhFp58xw9vHl+6jzQIx9YRsiQod7VxBVkTzAD0JuA6aFDR6wqZheRkHrzVEWHQQwL5817kPeR768+R9a9bZiEcwpQ1VJpe+xh/v6uFoKo3rXFK3pa6t3r8XMyZFDeIMfeYjqRXbxmj6r1GPHIeCjJLJA+TojTsSp19g2gYkgpHd+HsbPawNfMh20SRyjKEDD0y58aIy8c9JyVq2y/l+BiG/3Imeb4YgM8XW+Mro2hl1ErGnTWas58tvNpPlaCOtQbMbmym+VRX8CwHOYHKmQP1W1/i5puqzvgBS99V2wU55dyrzodcd1+WEYqN8rYtQwY7AgwKDE4B9vrSO7EympAzbv4JLZcJVW1I38GQid/dzeU/HaPhh4LX4EnsKUHFsbTHn4Wraez5x5TDqIqkAiugFHuEYAoYsxn4533jm8djH4Kq/QnqL5yX5CJPnEh/niuHHLp9EP5aYGv6FlULy6nG7Uup74fRWrYuVe/KArdm5hnPY5DVaXELHI3l0VYdna0eHkTYGRYvIdYlKDu4V4HCSqO8mfxWbG4NADZyNvKTmTAnfxjdz68cOV2CxIjcYsCWxZdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(36756003)(86362001)(31696002)(41300700001)(4326008)(8936002)(8676002)(316002)(66556008)(66476007)(66946007)(6666004)(6512007)(53546011)(6506007)(478600001)(45080400002)(6486002)(5660300002)(15650500001)(2906002)(44832011)(31686004)(2616005)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlRDaVg4c2dmK1k5L25YMzFvaG1zckNSYmJDd2Q5Ti83VEttOE8vdjRmVGpU?=
 =?utf-8?B?NFYwLzJvcUlCMjBxb2UwZTMrQlA2L1RQQm5iODFnaSs4ZHY0ZldhWjUxd0ha?=
 =?utf-8?B?YzEySVJzaHJzSTJvS2x1cWdOTURWc0R5RElnd2JCNnBHWFROSHBGRnNlYy9F?=
 =?utf-8?B?djQ3U1JKeVVQVVNZQXJHVWdQbWlvMzE2MVkrUDA3cEVtNC94dGhOVjBhUVhW?=
 =?utf-8?B?QWxzYy94dmFZaDJTRm5nRlE3ZFFqM1VqUEExWHE1UXRUTTZUc0xkK0xOc3V5?=
 =?utf-8?B?Yy8vTXdFd0pKVkFaeC9uemZMaXJaWm93QUJBVzN5ek10WnBvQlZPN1FLaWZt?=
 =?utf-8?B?OVN5Ym5FWXJ6U3Y1YkowL2Q0bVBsZUp6WmZiZXV0YllBc1l6blZhQ3Q4b0Q0?=
 =?utf-8?B?Ry9OM1BBMGsvTmJyRVlDakQxazZuSVVOY3F1d0czeUR5aXd6MHVVOGkyY2E0?=
 =?utf-8?B?UVh4VHJHNllmRHhmTG5HM1lPcjM4OVFnWGJmeWc0Z3ZwQUZ0MFp6NEZiSGdk?=
 =?utf-8?B?aHVhcE5rcEJkSUpRMkdHeitWVFJTY012REhJVmNaMXNQS2xXNHI3SkErckFG?=
 =?utf-8?B?NSs2ZXdvSDBLTlRNeUxralhYSUc5OG5WMGJud25XN2FrcmswbURmS3h3bmx1?=
 =?utf-8?B?THhVNFRuaEpIdXlpZzIzQ0VkYkg4dGkzdDlxdjVxc0NVRFhjU1RjWjJLb2oy?=
 =?utf-8?B?emF3RVY4dFBtSy9FWnYzZ05LbEZsRzRsbXdoS28vOXltM0JvOGdBWGp3Ylhs?=
 =?utf-8?B?UVFOVFdLNlZ0ZXJFbTRYWGI4eTV3MXBFT0JvUy9pcnZaQnZDZll3a0JOZWhF?=
 =?utf-8?B?SnFsY2Rack9DMElOdGNjVEdXZ3JsUVo1NDNMU2VMNnlXeDJCT3hMcW52MUgx?=
 =?utf-8?B?TkNpSEJjUE0wSFpCVnhoM1BqTFV6L0dIQi9wWktENzRIMndMUmMzVnY5VkV5?=
 =?utf-8?B?NjVHVWFLdHN2ZWRxQ0RtWExRVUgrcXNtMU9IcDV1N2ViZWt1ZnUyQTBHME9L?=
 =?utf-8?B?V1o2NnZsSmszT3NxcDFMejRlQWx3Q3VaR1RocGJEK0ZseFF0Y3BMR2FqdnV4?=
 =?utf-8?B?TTV5MHVMMUtBdE5zTkFlcXduUjRkUmU2WnlPdytleXVqK05DR25sRnNhUTFT?=
 =?utf-8?B?Zkl2Wkw2NVFiNUJiRmQxYXZwMzAvZ2ZIdS9vWlhodWEzY0FicEd1VzhBeHdi?=
 =?utf-8?B?dHp1eFg5YW8rcS9wV3J1bHR4Nm1KZ3ZwcVFjVzU4eVhGVTlKdXVkQXJNZEFo?=
 =?utf-8?B?V3FoTTNBYkFXdTZtRitHK2ludTFFTDVqaThKTktlRDJybU1YV1EveFcvSGJs?=
 =?utf-8?B?K1VSNVg1em84Wjh0OFpBRXpmeEhZRW9kN2VEZzZLRVZ0SEJWRVVqUUMwY1VD?=
 =?utf-8?B?VUxNZ2E0UnpmcHpaRXlEZWdRdjFINiszRlZTcUhJSzljZGdpUG11M0VNVHR4?=
 =?utf-8?B?eXlSK3VpVklLMHhpT1c0dXN3cUcxcVcvTVpFQlNCZTdDK2N0c2FOSTdSd1lL?=
 =?utf-8?B?WVhwV1FKWERBOW5keEdyWFpoVFNLRUtHb3k1MkhoOGxmWUZVVWF4dWJ4VEpE?=
 =?utf-8?B?bDBaaTdwc3dFQlhRa1pNUEttV3QzbmEyU0JHaW8vdlBQaFU5QThzVTVHZEQ3?=
 =?utf-8?B?L2xXcWFVQW1QYXU4dm15cE04Y0pzd3BYMXlTeVRMUVZ5K1l4dzdqZlljOVo2?=
 =?utf-8?B?RTRjS1Y1UDRlenlUS2tvRmVVeGlvTWx4NlRWV0p3Z3FBT3djRDRURGJrcGRh?=
 =?utf-8?B?UzRJM1RwU1A4MG5zM05CZHJ6NnViV29tTmNGeWVheTMwckZhZm51cTJPVVgw?=
 =?utf-8?B?aXZnN3hhQ0FPOFJWOW1wMkpxTWMxM0RSUHZmeDVIR2k1dzk1WmRYb3M4MXg2?=
 =?utf-8?B?MDdGemtzbEN2SGtTY3dzeDlCOCtlWXNaQTN1WURnUG1EMjZhU3U3TFlCTzhI?=
 =?utf-8?B?S1dQRWJGTHVTU2NOWmJMcTVmaFBBZVlyK0g1YThDR2F4T3RXeXY2cFd2Q3VX?=
 =?utf-8?B?d1NueGZMMHpIY1JaNmxuSnAvQ0xxRXQrSUo4dHBnRUxFTENpSkJqeFc0VWFv?=
 =?utf-8?B?K0dYNTYrNy85ak8zNytaa0dDYWxsanFQT3ViNEpQck9oZmJyR3JseEczUnZh?=
 =?utf-8?Q?zjtlE1Nkaku/djX4usjFvmxi7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41381b34-f264-4c5b-b110-08dbef8573eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 20:14:25.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdRwHoJ3JtetOmDULStjBj8Y4GCArCVCKuuXvQ+qDviYZNhZf8Z0/ZJJcSdZe90DLrhzS90OdaaLwQ0hk3WotA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/2023 17:05, Luke D. Jones wrote:
> ASUS have worked around an issue in XInput where it doesn't support USB
> selective suspend, which causes suspend issues in Windows. They worked
> around this by adjusting the MCU firmware to disable the USB0 hub when
> the screen is switched off during the Microsoft DSM suspend path in ACPI.
> 
> The issue we have with this however is one of timing - the call the tells
> the MCU to this isn't able to complete before suspend is done so we call
> this in a prepare() and add a small msleep() to ensure it is done. This
> must be done before the screen is switched off to prevent a variety of
> possible races.

Right now the way that Linux handles the LPS0 calls is that they're all 
back to back.  Luke did try to inject a delay after the LPS0 calls were 
done but before it went to sleep but this wasn't sufficient.

Another "potential" way to solve this problem from Linux may be to 
actually glue the LPS0 screen off call to when DRM actually has eDP 
turned off.

Making such a change would essentially push back the "screen off" LPS0 
command to when the user has run 'systemctl suspend' (or an action that 
did this) because the compositor usually turns it off with DPMS at this 
time.

This is a much bigger change though and *much more ripe for breakage*.

So I think in may be worth leaving a TODO comment to look into doing 
that in the future.

If that ever happens; it's possible that this change could be reverted too.

> 
> Further to this the MCU powersave option must also be disabled as it can
> cause a number of issues such as:
> - unreliable resume connection of N-Key
> - complete loss of N-Key if the power is plugged in while suspended
> Disabling the powersave option prevents this.
> 
> Without this the MCU is unable to initialise itself correctly on resume.

initialize

> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

I think it would be good to add a Closes: tag to the AMD Gitlab issue 
that this was discussed within as well as any other public references 
you know about.

Additionally as Phoenix APU support goes back as far as kernel 6.1 and 
this is well contained to only run on the ROG I suggest to CC stable so 
that people can use the ROG on that LTS kernel or later.

> ---
>   drivers/platform/x86/asus-wmi.c            | 50 ++++++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |  3 ++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 6a79f16233ab..4ba33dfebfd4 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -16,6 +16,7 @@
>   #include <linux/acpi.h>
>   #include <linux/backlight.h>
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/dmi.h>
>   #include <linux/fb.h>
>   #include <linux/hwmon.h>
> @@ -132,6 +133,11 @@ module_param(fnlock_default, bool, 0444);
>   #define ASUS_SCREENPAD_BRIGHT_MAX 255
>   #define ASUS_SCREENPAD_BRIGHT_DEFAULT 60
>   
> +/* Controls the power state of the USB0 hub on ROG Ally which input is on */
> +#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
> +/* 300ms so far seems to produce a reliable result on AC and battery */
> +#define ASUS_USB0_PWR_EC0_CSEE_WAIT 300
> +
>   static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
>   
>   static int throttle_thermal_policy_write(struct asus_wmi *);
> @@ -300,6 +306,9 @@ struct asus_wmi {
>   
>   	bool fnlock_locked;
>   
> +	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
> +	bool ally_mcu_usb_switch;
> +
>   	struct asus_wmi_debug debug;
>   
>   	struct asus_wmi_driver *driver;
> @@ -4488,6 +4497,8 @@ static int asus_wmi_add(struct platform_device *pdev)
>   	asus->nv_temp_tgt_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_NV_THERM_TARGET);
>   	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
>   	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> +	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
> +						&& dmi_match(DMI_BOARD_NAME, "RC71L");
>   
>   	err = fan_boost_mode_check_present(asus);
>   	if (err)
> @@ -4654,6 +4665,43 @@ static int asus_hotk_resume(struct device *device)
>   		asus_wmi_fnlock_update(asus);
>   
>   	asus_wmi_tablet_mode_get_state(asus);
> +
> +	return 0;
> +}
> +
> +static int asus_hotk_resume_early(struct device *device)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +
> +	if (asus->ally_mcu_usb_switch) {
> +		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
> +			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
> +		else
> +			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
> +	}
> +	return 0;
> +}
> +
> +static int asus_hotk_prepare(struct device *device)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(device);
> +	int result, err;
> +
> +	if (asus->ally_mcu_usb_switch) {
> +		/* When powersave is enabled it causes many issues with resume of USB hub */
> +		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MCU_POWERSAVE);
> +		if (result == 1) {
> +			dev_warn(device, "MCU powersave enabled, disabling to prevent resume issues");
> +			err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MCU_POWERSAVE, 0, &result);
> +			if (err || result != 1)
> +				dev_err(device, "Failed to set MCU powersave mode: %d\n", err);
> +		}
> +		/* sleep required to ensure USB0 is disabled before sleep continues */
> +		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
> +			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
> +		else
> +			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
> +	}
>   	return 0;
>   }
>   
> @@ -4701,6 +4749,8 @@ static const struct dev_pm_ops asus_pm_ops = {
>   	.thaw = asus_hotk_thaw,
>   	.restore = asus_hotk_restore,
>   	.resume = asus_hotk_resume,
> +	.resume_early = asus_hotk_resume_early,
> +	.prepare = asus_hotk_prepare,

Have you experimented with only using the prepare() call or only the 
resume_early() call?  Are both really needed?

>   };
>   
>   /* Registration ***************************************************************/
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 63e630276499..ab1c7deff118 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -114,6 +114,9 @@
>   /* Charging mode - 1=Barrel, 2=USB */
>   #define ASUS_WMI_DEVID_CHARGE_MODE	0x0012006C
>   
> +/* MCU powersave mode */
> +#define ASUS_WMI_DEVID_MCU_POWERSAVE   0x001200E2
> +
>   /* epu is connected? 1 == true */
>   #define ASUS_WMI_DEVID_EGPU_CONNECTED	0x00090018
>   /* egpu on/off */

