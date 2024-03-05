Return-Path: <linux-kernel+bounces-91608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BCE871434
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F03284677
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621AE2E653;
	Tue,  5 Mar 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CBL41u5n"
Received: from SG2PR03CU006.outbound.protection.outlook.com (mail-southeastasiaazolkn19010000.outbound.protection.outlook.com [52.103.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313C2F44;
	Tue,  5 Mar 2024 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609059; cv=fail; b=FJ1Q3j/Vh9GaJAjbDG+U97DrFkcVszD95q2gddplyXmnMlepe/9M+aum9ShhY4KtcSJEg0ravcQkJPuDW/j+rhjfDfc+6/4Dkg3hdINZmokLobdA23z9rSrViopZUqh3mHqn0SuEWPFlL8REYOHPIBPjKJXw9RjvWHJxPcH0ng8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609059; c=relaxed/simple;
	bh=YhE6rT35+o3xWcn7mm4jwLpLO3IjZh5WATHhkYcOGus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4DLPN7rlQpQgjaDy+Lt/wAv5svEHiwAKe79RcXqVw1kEYzV18WvOQZPNMlFarLnPe7ORfvGInPcG6486tpQwsZcle/mRfaw6y88oydgkaM2x02owwlda0C6eOOKdf0HWBeQ1AxB5AJgC1C3wSt3M03U4noud0KL7/NVf3E5dfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CBL41u5n; arc=fail smtp.client-ip=52.103.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6pWMP2fJtkDBK9vrG8a5UMtS8KXooHu9xfSU4ebOzAU7+ss2NPuJ4oRdLQNRo8SGagpr+pkeDnLv9osIZx3fGlkD0CnKBBXVDNC28LnnESVQJ5HKp3DYSDn2f4NIgwNwV3ep/z5vCmeFK8mE+lSOIYtf+uDMsjzzbAuht+/geFh8LwxfOdXC9b1rV5Icz14s50DISZmQrGsu0nLOAds12Qy35LzShYe2h50uJFmWKKtwWRsgjfaCX4DOCDxkDaqBxP6VUqrNc1pQdTlfO45+GcDbnGzQ/CCAwqIVmFfkgxTHLk08Xlhl+hbrFj7r/CtREk88AgWgFjAUreQONILqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F980M108OAUj73wFqugEdGKclkZb/eg3EE1BBKLoFLE=;
 b=NW4wbsVMq8DcZQsYjBqLg+YOml1B+hCn4iw0Uhe/GVAJXbYGyoNhnFI/s61PwVZFmuIdfJWoBmeS0rvsOSSe4DWjPVmHnw2LKtUzvc661I8A0DcV4mP6VzrRb1eqt8IY2J+oEBxOoawBMAvfT9qIW269mtlJh5J80gdMhvGPpegBgjwLu3RENlo97VBhnXNtHpZXl5O41zuhQ4P4bSEm7HsTuK0/VOydVSIEGKxN6IG2W2zOrXUiPBpBxKChwXwKDUOxbV4JrmMM7LJLyyMsMeiipLmNYk++trCBPf1lhe/P8xg7zDMG3HEoIvnVLZFC6VLSPBPUt2z/s5XxYA/TXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F980M108OAUj73wFqugEdGKclkZb/eg3EE1BBKLoFLE=;
 b=CBL41u5nz28z61LBRwk88iUvgOaXTpzEsLp6Jt6a+7HKLC4pt5iD4ncWOsZgaudgBADiiMeoYBX59NuW6PicaiONtGCPK9RFJSfzXfiNbjk1QLZLUEnC/s02guKl/LL2v2Z/mF4T9Pbp+R77SE6Dr78t4IgSpK7bn8CqPf5qZ8rBRJ50eUIAqQugrtSYTNWPDvuUuRcfi3yvyG5BhhFl+9wv2gH5YAwKYuie4WvWMlWyHxH9jvl3+BGfQBkIEpd27rvT3SR8Djo3MqSWnqRZBSoe+cmrsAchDD2APBiiPxra7uenGxB2Ibz2LPv4l9dbk8Ve2oTLYG7KyHAGVRMAMw==
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com (2603:1096:301:a3::11)
 by SEZPR06MB6665.apcprd06.prod.outlook.com (2603:1096:101:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 03:24:12 +0000
Received: from PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6]) by PSAPR06MB4952.apcprd06.prod.outlook.com
 ([fe80::1e13:cc11:3196:e0a6%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 03:24:12 +0000
Message-ID:
 <PSAPR06MB49526EEA505F752A2A1E1A97C9222@PSAPR06MB4952.apcprd06.prod.outlook.com>
Date: Tue, 5 Mar 2024 11:24:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_pnp: Support configurable reg shift property
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, albanhuang@tencent.com
References: <PSAPR06MB49522EB50BDE08A5D9D0DACEC95F2@PSAPR06MB4952.apcprd06.prod.outlook.com>
 <2024022916-captivate-state-0255@gregkh>
From: GuanBing Huang <albanhuang@outlook.com>
In-Reply-To: <2024022916-captivate-state-0255@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [n9n6glQbcjtYGk19Kw/cX/wAfvrjydUc]
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PSAPR06MB4952.apcprd06.prod.outlook.com
 (2603:1096:301:a3::11)
X-Microsoft-Original-Message-ID:
 <f94940d5-0814-4f2d-9ed4-9ae2dd720de0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4952:EE_|SEZPR06MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 685a4b12-0521-419e-6132-08dc3cc3ba2e
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCDe1aJ4BXPAzEJ1EUPoZ50Jkg/iayShqwR8Jz8gr/Y2J7y87qqVmVn2WL1LlyjcRZaVElMgzQNeis/O4en7VX6sVcnRxO0rZDQ6qQQXo7LWTrIaGkEAm1b67/GBMzNC+bT5jQWCg8Hkk8Fpzw6c11x5vvmMLfC47iwTyicgwVs+tlXgjePsbENPhV6E5jIWGggKS9K0SG89MQOxZVJLLwm0OeiXG09l9bvTj/RpaH04Bdwx5hMtrXuFV+2fOkXuehP+6tA3/3uGLuMGff3qUplH1O3FZHlI205G0jWE/+psAUNu1RctfdZ1Zf2o7A/Bm6r4XGq0V8+GnPuDRWbayObhz5u2uRoFaqrHhVWlZNqIl2tMFkzKNRwRK6/1tStGGUyEp7FdfU2MK43GzNjl84f2tBeE+IYacCj7GYEfnhA8S3rg3EtIJxN47RtRYdlsVIccZfNiDC49zGtpvja53XvZ7re1FgRgehAswpzEYHZ9tjvSWQUoWECkLyJboHZ4GOT+pHQtv8bFWXddC6RHgxPIWTIr3kNf4wptHuB6SkYjNNHzZKO0/cpJMpxkqX1mDBhQsx+7e+sbXuigs3MjsKjB8mcN2jlbrrQrZvbPG3rKmHFTvHLVGXsBEMigpwae+HxShj/hPfaIqVgfN9jihQRODXWpTT8kSMfJur8DplD8Qe33/R4gr1A9u/U3EZadEmk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+a7/UaonFcTCg77ojlyohXjVzTbUO9ES+V9CXiBHGq5ptxpBTEuCwOWo+Fgaso20or+lMRViNLT843Yv0NigA27yZ19Ti0fnQ4mb1AfPOhiZiVoY5hRb0KYgY5RguywlMdl4xpAlyJk0fQD5NmNCb4hV5hWDprMhfVbArUwkbCeuvcwBV+cIm+A1EeWrIGrzW/Mh0N16RhkQ9MYGjgvLu+syKL5ldMruWr6dr+VrLZZcs1jUytguB5rsQpCagvsnRpvRIg94z84Z7L9GtnjLpOCR8vHJYQ1QwRrYOwqNJ86VI19DWgoIMPmlL/I6z42TnTgMsF/beap9VIoVhvky3VhFkKs+S/NWlqMsleAXUwIdCu1opivVJuel2RFBO5p7yIJj6mNdL5S+8vM4AhXJkJjvtVceDy38YyKPdj7iFmRmscvOSR5Q51vJ6XdYBnNKhymtxw6sR8BAYoM8tKgDAS64ngVfwPTbW/V+uGkAfzptWKn915iGsIyxFMAH60+DtCWVkBrhN2fOQbV9he+eD8Kiwc0mYSk5+sigYMpciICJQ1dw8w37rEPWYHnwkTwU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNyVnJzdEozY1hCQmFJYWJhemM0d0NUUXNTekwzdlYrYStTdmcrOUtNYlFl?=
 =?utf-8?B?YWdKcm1rTll2bHNWeS9GeEVzVjZSaDE0WXA1ZWJHeEFwRm5EVTlwbXVpbDlK?=
 =?utf-8?B?SDA4d1lXUlQ4SzJXNWFQRXlEejIyZDg0enN4R1h3b2JZL3g4U2w1dE9zMmhi?=
 =?utf-8?B?T1pSOFpVUXpIRVFpWTZhOEhoR0lqSUp4WU1Kb0FxMVpaMXB1UEhZSGl5QTk1?=
 =?utf-8?B?cnBSTitwdVdmb0VuWGdtcFZFNWR2THEyUnNqczNGQkRUVktlUHllZURQUnhS?=
 =?utf-8?B?SjVqcDBYY1RKMnVVODZzbDN4WEtwSjhDL1JTU2FZOGw3Q1Q1UkJCMXFkZ0w5?=
 =?utf-8?B?WUk0Q3FpRUdKTHZjaEN3MnE5cmdvUm9ucG54TlZqZUNOYW5xaWJ4UkJOREl1?=
 =?utf-8?B?SlZEelN0bFhudHBhK1A4d3prYnYzOFdxSGo0c2pqWUluUUp2YWgrOGdvUHpr?=
 =?utf-8?B?bmRxSmJza25wR0VKU3JPRThvSDR4aUg5Vko2ZlRxVzFVWDVSN2V6UjVURHRN?=
 =?utf-8?B?NnM2VHVlV0M3ZzhTWGU2VCtUc1pkV0tkZ1dCRjhDdXFmbjZEZEhSblIycndC?=
 =?utf-8?B?Yzc4V3loQVVVMEpEemFUdys2aGF0YXkwaGYwd2hMOWVyUmFEajBMalR5N0JS?=
 =?utf-8?B?QlFHbFBuQ1pvb3c5SFJaMWlSTlZYRUF0TG1heTRnaU5kVmNjVlpmOWFtRUhQ?=
 =?utf-8?B?d2xna2lGVEtXOTlCdlhUUzNXejBVeHQ1NUxqS2lXdXFHblRIczk1T2JxZFhn?=
 =?utf-8?B?d1Q1ekpiVGJNQlY0OG1WL1RKczNieUt0bGkyL2JTL2tmMVd5dHN4d0NjRk9X?=
 =?utf-8?B?QkJTZmgydm8wWnFOSzVOaVI4WDZiZit2ZmN1MFRuTHM5SHU1a1NrcHFVaFA4?=
 =?utf-8?B?SVZac0RKNUltYmxvMzVMUFJMaGtTYml1MzNRL29UcFRTWXFCeVI5aWtVcDNB?=
 =?utf-8?B?b0R3MXBISG1KSnhrcDBJMC9nM2VVb2Q1bHYza1dYejl1OE9WVk5oSWc3U08z?=
 =?utf-8?B?L3VObnp4UW1DaGt0Q0pzRVRsbS9qSWxRcUxYTUtJamdmamRrMXgxMVhvZFlp?=
 =?utf-8?B?OGtxUVMyQkJiaHA0YzVVbm9KM3FkUFJlMlMxZ0pnUjZBemF3alpqSThhamIx?=
 =?utf-8?B?a1o1OEpVdklXTHR3NHBBc2c0anFyOU9FSjVnVUdCMnFEQmVXVDVzaGJ5YThJ?=
 =?utf-8?B?bHhjN1RlQnRHQ2dBTFdxVUdoSUIxT1U5UHZuVnRISDMzYi9WSUpudWYwQndl?=
 =?utf-8?B?bDJ5cm1aYkVZSWNXQzlHaGZ6VUR6cXg4cU45WWdGbE5USEt3QTg2dExWdEdR?=
 =?utf-8?B?QStqY09OT1FNYmpNZnAzV2c0YXE0ay91UTdpTHc5N1IxWnd5OEc3eHkyNWVC?=
 =?utf-8?B?MmhQcFpITTRTSmhGTEd5ZUlKcEVja05lS2tnckUxV1NPbDA0SXBkbWljcWda?=
 =?utf-8?B?NnhTU3BVcWhUR21JMTFIVERweHdYelQyR2ZDWDNjRGNlQzJEK1N1RStNTFIx?=
 =?utf-8?B?VGoveDYvMlF3ZDM4d3hubTh4WVhIbExLdmFHZzh2dW5xWXhzSlJHL2ljVjEz?=
 =?utf-8?B?NGNuUEc1ZGsyVUQ5VHhSY05lSzZWcmlreExmSEp3cmhSV3Z0UGt1WEpSRzFv?=
 =?utf-8?Q?kXXh0EkqjUl7aw+3qgwV36WnoY00HcmCMY89IItSowVo=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685a4b12-0521-419e-6132-08dc3cc3ba2e
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4952.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 03:24:12.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6665

在 2024/3/1 6:00, Greg KH 写道:

> On Thu, Feb 29, 2024 at 07:51:54PM +0800, GuanBing Huang wrote:
>> From: albanhuang <albanhuang@tencent.com>
>>
>> The 16550a serial port based on the ACPI table requires obtaining the
>> reg-shift attribute. In the ACPI scenario, If the reg-shift property
>> is not configured like in DTS, the 16550a serial driver cannot read or
>> write controller registers properly during initialization.
>>
>> Signed-off-by: albanhuang <albanhuang@tencent.com>
>> Signed-off-by: tombinfan <tombinfan@tencent.com>
>> Signed-off-by: dylanlhdu <dylanlhdu@tencent.com>
> "interesting" names, can you not just use your native encoding to make
> this easier?

> ->I'm sorry,this is my first time sending a patch.The names should be changed to the following. Do I need to resend a new patch?

Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
Signed-off-by: Bing Fan <tombinfan@tencent.com>
Signed-off-by: Linheng Du <dylanlhdu@tencent.com>

>> ---
>>   drivers/tty/serial/8250/8250_pnp.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
>> index 1974bbadc975..25b4e41e9745 100644
>> --- a/drivers/tty/serial/8250/8250_pnp.c
>> +++ b/drivers/tty/serial/8250/8250_pnp.c
>> @@ -473,6 +473,7 @@ serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
>>   		uart.port.flags |= UPF_SHARE_IRQ;
>>   	uart.port.uartclk = 1843200;
>>   	device_property_read_u32(&dev->dev, "clock-frequency", &uart.port.uartclk);
>> +	device_property_read_u8(&dev->dev, "reg-shift", &uart.port.regshift);
> Is this property documented somewhere?  What happens if the property
> isn't there?
> ->
> 1、In the DTS scenario, certain chips use the reg-shift property, such as:
>
> arch/riscv/boot/dts/microchip/mpfs.dtsi:
>
> 294                 mmuart0: serial@20000000 {
> 295                         compatible = "ns16550a";
> 296                         reg = <0x0 0x20000000 0x0 0x400>;
> 297                         reg-io-width = <4>;
> 298                         reg-shift = <2>;
> 299                         interrupt-parent = <&plic>;
> 300                         interrupts = <90>;
> 301                         current-speed = <115200>;
> 302                         clocks = <&clkcfg CLK_MMUART0>;
> 303                         status = "disabled"; /* Reserved for the HSS */
> 304                 };
>
> drivers/tty/serial/8250/8250_of.c:
>
> of_platform_serial_probe->of_platform_serial_setup:
>
> 150         /* Check for registers offset within the devices address range */
> 151         if (of_property_read_u32(np, "reg-shift", &prop) == 0)
> 152                 port->regshift = prop;
> 2、In the ACPI scenario, 16550a serial port initialization code execution process:
> ->serial_pnp_probe
> ->serial8250_register_8250_port
> ->uart_add_one_port
> ->serial_ctrl_register_port
> ->serial_core_register_port
> ->serial_core_add_one_port
> ->uart_configure_port
> ->serial8250_config_port
> ->autoconfig:
>
> 1194                 scratch = serial_in(up, UART_IER);
> 1195                 serial_out(up, UART_IER, 0);
> 1196 #ifdef __i386__
> 1197                 outb(0xff, 0x080);
> 1198 #endif
> 1199                 /*
> 1200                  * Mask out IER[7:4] bits for test as some UARTs (e.g. TL
> 1201                  * 16C754B) allow only to modify them if an EFR bit is set.
> 1202                  */
> 1203                 scratch2 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
> 1204                 serial_out(up, UART_IER, UART_IER_ALL_INTR);
> 1205 #ifdef __i386__
> 1206                 outb(0, 0x080);
> 1207 #endif
> 1208                 scratch3 = serial_in(up, UART_IER) & UART_IER_ALL_INTR;
> 1209                 serial_out(up, UART_IER, scratch);
> 1210                 if (scratch2 != 0 || scratch3 != UART_IER_ALL_INTR) {
> 1211                         /*
> 1212                          * We failed; there's nothing here
> 1213                          */
> 1214                         spin_unlock_irqrestore(&port->lock, flags);
> 1215                         DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
> 1216                                        scratch2, scratch3);
> 1217                         goto out;
> 1218                 }
>
> static unsigned int mem_serial_in(struct uart_port *p, int offset)
> {
>          offset = offset << p->regshift;
>          return readb(p->membase + offset);
> }
>
> static void mem_serial_out(struct uart_port *p, int offset, int value)
> {
>          offset = offset << p->regshift;
>          writeb(value, p->membase + offset);
> }
> The kernel will execute the serial_pnp_probe function to initialize the 16550a serial port during startup.
> When executing the autoconfig function, the serial_in/serial_out function failed to read and write to the UART_IER register,
> causing an abnormal branch entry at line 1210 and an abnormal exit at line 1217, preventing the subsequent 16550a initialization
> process from being executed properly.
> mem_serial_in/mem_serial_out will perform a regshift offset when reading and writing registers,
> because serial_pnp_probe does not have a configured regshift, which is 0 (regshift needs to be configured as 2),
> resulting in invalid register reading and writing.
> Without the reg-shift attribute, print the kernel boot log and identify the serial port as "unknown":
>
> [    1.458722] riscv-plic riscv-plic.0: mapped 64 interrupts with 1 handlers for 1 contexts.
> [    5.342472] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    6.038702] 00:02: ttyS0 at MMIO 0x310b0000 (irq = 12, base_baud = 3125000) is a unknown
> Configure the value of the reg-shift attribute to 2, print the kernel boot log, and correctly recognize 16550a:
>
> [    1.459948] riscv-plic riscv-plic.0: mapped 64 interrupts with 1 handlers for 1 contexts.
> [    5.317550] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    5.864828] 00:02: ttyS0 at MMIO 0x310b0000 (irq = 12, base_baud = 3125000) is a 16550A
> thanks,
> Guanbing Huang
> thanks,
>
> greg k-h

