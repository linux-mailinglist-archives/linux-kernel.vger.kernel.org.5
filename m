Return-Path: <linux-kernel+bounces-116513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCE88A046
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A20A2A5EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698813CF8D;
	Mon, 25 Mar 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b="C1JhwFkm"
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2155.outbound.protection.outlook.com [40.92.63.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A61B6FD1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711340882; cv=fail; b=bYCqbKVSO+v0yl7U07W8U2oGRAYCX3tC37SGC5hq/ZK+nQawu4ICrabmr2h31aIOBbd99Ux2SfyTaPCOzucUzLk+kYWgQEtUSOOGCnWt4Z1Tn2gV6qM4ziRyeK1CPqzRdTUG5XpvNIoInzKTRMHDHjfZZn7zBVgTii5cheQrQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711340882; c=relaxed/simple;
	bh=sBdH+zKfVHkHbA+paxIdyTnhAE+cEwLWyc+mpd/9p7Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qro3DDqKh7coDNy9/mOWvCySDVX+ze9a5hErbutqdXlHid9gMdLXbHcUTQ5VXNAh0fq4L+hXzqfGVeY8akQzPwtg2E4UBU9Dvb0Kz5HBDD83jxH1snvsIzN547pRNeKNQ5VUVd4V1HeBuuWQjlVTX8BOi1BPiRq3wuMudHyKZuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au; spf=pass smtp.mailfrom=outlook.com.au; dkim=pass (2048-bit key) header.d=OUTLOOK.COM.AU header.i=@OUTLOOK.COM.AU header.b=C1JhwFkm; arc=fail smtp.client-ip=40.92.63.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com.au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv7snWpClvp0mIoofpxA0JgKFIOPxWTDJ7VkBxxYqVhASO+p6uHD+ynxN/eXyS1ZALNK7V6jzIGUo3h5O8n0ZPaSa2XX9cAm+jmr4WaCDMss+t7oVTOb6pLhJDX08Op8/gowrjrtyIhTaEM0X991bsI5qvELYiS57dXhdkew71PQ3BnGJSTa4sot1q4rVvdxh0KXM109OwCIpUXdnWDR2PBJrMKTb1imud/Lr+Rj9fTdQ0lUCDG1Ns+MiwdJCgHGiD50qUJlizZROxqjzmvqH2Gc4FxpzWQ5rPTC1J1FDb37lRv1/6/QOe66skpn+rMcCgsmj2ROHS1xFA6Bic2FvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lpk/sA8/07SG+Tdl8LzGYjJ9zpc8O3DEhnMUBKqOVPM=;
 b=ZaAPJ2fjgcEGGCwVBqOwVKDJbUWr8p+64LuGKPk075n8thk1CYopynkn+pe11aHIuTaQ6d2OtQxgPZA8ZLeXKY/nPwrBGmSPBYSqB+aoreu+UTIJ6ia4JnlriP9S6vq4wKwG+KimWwIG3mSW2WnHvKUPdWv7nqiZ7sXiStIeFphA9Lh7WDO7Fh57oH4VK3ZXAkEU1jOpynNXenrfR6heehfK0KOBXqFqIcKIauA0m4sgJBKH6DKZzrT4BH7KRRnL1+mD4UKxwyZP75DtD2RR8Lta8Ahe1DGXR9+qwfx1AnOliMx5xpeI0CO5GMMGA2GwxUZdaguddyNcJp3bTjID5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lpk/sA8/07SG+Tdl8LzGYjJ9zpc8O3DEhnMUBKqOVPM=;
 b=C1JhwFkmyxCpgvw2ClPpi5+8+KbgbqZHJ4KvomFy+VHJDC9ROanOmd6X9xOZ+1B194crlopq8l5/7+sdzLsa7r8l7E/ptCtHbpdWvtg4Zrv2+rapkgi5C+/t7amK6LNlMb6cS7rYdkIALZpBn5Gf10gY5N16gpYpckmaNP7slCGTl7fydCc76jKZ54c/xyz1/+5jw6ONfpvOa+ydl+7BRc+Qm6dLtQX2JYK/dh58Y/p6jE0rhZqpQD0sNkaS7OnQwDqGohuQJIs5ggAd1jLWkoc1PM5skkv0N3RBBlIWkRcISwUL4iQ9FIHPdKspRkXPd/+qaPUflQHyNwfSqnW57Q==
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:159::9) by
 ME3P282MB1747.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:a1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 04:27:56 +0000
Received: from SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d]) by SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 ([fe80::22c8:76c8:58ad:f00d%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:27:56 +0000
Message-ID:
 <SY4P282MB30638B59AF7677462C051518C5362@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
Date: Mon, 25 Mar 2024 14:27:54 +1000
User-Agent: Mozilla Thunderbird
From: Stephen Horvath <s.horvath@outlook.com.au>
Subject: Re: [PATCH 1/2] platform/chrome: cros_kbd_led_backlight:
 Automatically enable keyboard backlight control if feature present in EC
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
 <SY4P282MB306333469B31348E4A25A1A5C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <ZgDuiEYcgMTuZAeA@google.com>
Content-Language: en-AU, en-US, en-GB
In-Reply-To: <ZgDuiEYcgMTuZAeA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:
 [amIU3wDL79bUWg7JZcEtbqGJp5H04I+/P2n1+OJ2qSohczgXRYdcC/1MKEpajdWQzt2f4g9FPuI=]
X-ClientProxiedBy: SY4P282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::20) To SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:159::9)
X-Microsoft-Original-Message-ID:
 <a12a00a2-5874-494e-9b51-8203cfb9d82a@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3063:EE_|ME3P282MB1747:EE_
X-MS-Office365-Filtering-Correlation-Id: 1347cb5e-d267-4cf9-603c-08dc4c83f1d1
X-MS-Exchange-SLBlob-MailProps:
	7qh87CJt6y28mnXrYaz3TbdiDbghv9xw0CB7WsKaKNjE19jLC1uofT5Tcsq7Li+hDHHS09RxIgZhDhlPodWk6r+ENudonLFfukQ7QeF0DDnzTtXCLHxZiO5H435q2tIhg2oUMXmzqs/RY6eYzpXsQgFzGm2CTxe+XLNjRO7W4N+LIEU2R+NUIXOVz/dG1efiIvSfIpoX6XTMVgqcUVUrSmtb6KXpi6Yg5MymgSwi6lJgLB7G7WxZXljZi/+whMM2U6BM3uuZ3ffhsHZt+KvWlvKQ2FayZN3KhOXNspWlUhIOLpAGwzIg/lAP4BDTl1S1onUUYOQ1lTXqVnVCe4bNPG0HfR0HTQyoLLxNqhyhwaIFxlR7IwaL+jS3UN5QhdUmT4ij8aV1Ceia8zmR7bWzB4zE4iCxzLJEwXpAHwyN3I9J8Z+bwc8FD28ZhMA1EkTQ9C2uUtLcv3grQsAxTblBaJEw94FGkF3r1s85LC7POXfNvAgsq57lyVcWCKPom6Z+S3YKPGPItEa3bwdDrG/LfXjs6lyMigQScNM6A9arR97Y7w71p3Q9uhvAsOpweJSXFdHo/nUgAX7x5T0Yt7Cg7CamczFxclj9NkxzEHh17TUn0W1yWyC/Feq/7ojX/nE+t/imjkl1oJY3DqnCMNICTtJkYhCqXb5EkxfVPbv54DA58ptTPmxFoXua7KsoNYPHIqHlSeeDLEbewWNigXmpT5TYmmMPsnAEi7SyqZB1wYVc7vMgXWpOXhj4QnY9LNXE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4aQaXrk2QPjbjpb9CVUTRgY1+vE+ilo9W0Nc1KMND2Eo+69cBe0nJwDYKJEi9EFlxUsXgvrSFSFGC9fx36WvZ10mHTAraIZI/quPlwlfTl3CBAZBY3vVJ3c1iSDPauvsYa8tBb6NUquhWpSJvWCyAmYc2sOA/ty5zHoE4KAfG39RDWQrpnVJeCk1Txz8oPKCglzdwpqxdY7apeQSxY+uz/OMbigjzd6+yjEV3XT1J8ar+CW7i73dyQy7UOuTS0geDyBl+mexmWlVcVbKYzJdvjVhCmB332idErPeFxZy/TzoVX4cqIr8Wq/JF9SfTtyJbwUqOQyK4pKW42BgXEF9M5QwUIi+hj/3KIADx5688laSzif55pPd/mlWehpf19Qb/9ceNGJA1oxBsCJvQfFlI5RVKsG2n1/nvNfrT8Q3y73NXKBCGXNTX7h87G0FVu288YTuHcG1BMoVsJa9E0uP39YBf7BIwLzSWQlpQXqCuXcUoQY4PQ3+BwJlTbqZjpVNb0IF31eMv2B8X5lAwtSXNDjSid9OaHcFVXCbbDIYmNJ1/cMIVA3fx6NiuWSqghmZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm9VTjRrR0JjYlhwd3F5TzlWZ1RPNThHZjFuV2hCczZzS3JWdDdBeUh2ZjZL?=
 =?utf-8?B?MGNwTVpGUk5FNEZvZE5Nc0dsanVkUm83VmZpMXJtMXNsVE55K0xnOHovNTlS?=
 =?utf-8?B?Qk5QY3piZzQ0WUg4Qi9ld1E0NXBQcitLRHZUa1J5c0FmSkdId2dhT3kyaXMy?=
 =?utf-8?B?WHh1aS8wc2lGbVlZTWNmSDlES0FKNEVkMys2V2NVbWxCWGdZQjc3elJOeGVI?=
 =?utf-8?B?REpCMEY5ZHNYNUYyR0oycVVaK3Z6R2NuY1FONThCaS9NZ0w4TzlTaEdSTTF3?=
 =?utf-8?B?bTZDdHNLQ0xwbkJYSTdzdjl2aHdmOW84K01VTjBhcENPSU1QWTNmNklrL1BG?=
 =?utf-8?B?Y2J3aFE0OGM0NnBlOUJ6YytaYitBWXQyV1Zpc0F0SjBvRE1mV1pHeTBQa3Iw?=
 =?utf-8?B?RDNyRkVmUmZIUjRWVWpwVDdNNkVDeGdGWnQyZ09EVUcrSXY3dkFDRGYydEs2?=
 =?utf-8?B?RHlwbC9Lck9xRGh6SS9HRVFEZUdzZ2hIOFBLVmZxclcrOE1Md2lBYW9HUUdZ?=
 =?utf-8?B?bkVvN29kTUVsWjd3YVlBTWtkV2RDTG1KRnYwNHluZTc3WXRXZGxhNUxWeWNX?=
 =?utf-8?B?QXlPN3MwNU1pc0tDbVRNcUlaYnlpbHQxTGVkbWo2RWRaNjJQNDRDaDNXRTMy?=
 =?utf-8?B?Y2FNNElybUJJYld2YXM3a2ZIbXFOaWpCWlVuMlRJY0RDVjVQOG9CUnZYTEt6?=
 =?utf-8?B?c2ZXYWE1V3k4N25XWEMxajh1S0lnSkpTNlB3dDhNcVJXRThGcDkrWE1TNTFI?=
 =?utf-8?B?WFh3S0lZOTBDRGRLNXRhUXZMZzNBTml3T2ZmSGtjajUzU29NMWpCUU5LamlP?=
 =?utf-8?B?bnRiNWFsL0d5REdhWU1iRVphSUl3T29LN1RvcDV1UE1RVGgrK3dXU2pYeDVj?=
 =?utf-8?B?OENGT0FKVSsrOCtveE8vWGM4cDExc0xRSXZRK1BmaEtIa0ptTmx0REZzTEUw?=
 =?utf-8?B?R0w1RmF4VzZCaXExa0ZWbVdxb01nR2k1ZmZGbkFnZ3R3V2ZJUGczTkRNam9v?=
 =?utf-8?B?eVl6NjBRa2hEWWlyNWQ2MHc3N0pvelhDYUNHTGJhOWJxbmVmV0l3Snc3T3hr?=
 =?utf-8?B?VFJMUWNURmV5bC92bG1aSHNjNE1kRnBweFcxbk1xb2VDTnZYMEF4ZkJGeExl?=
 =?utf-8?B?STJjanJkQnhQRjhWdmtnTHcrZzA5eUNhdEE1akowMVoxY1hOeHFlQWlXUnBI?=
 =?utf-8?B?K1pHTWRhMkxPY0lxRG5tQTMxSE9JWHlIdVlvWlR1ZHRqMmpTbjNBalp2ZC9z?=
 =?utf-8?B?Z3hMazVjMkRnMmt5R0Z6QnhiRXRsQ1NEYklJZmltdU14bEFnbTRMMDBOaVhZ?=
 =?utf-8?B?VHZRRmhmSkNwUFlvSFlDT0tvcWxDU3htMWxtMjBuUnV6UUl5NTJQb0xxNE1D?=
 =?utf-8?B?bnJYVHk4SzJvUHlvckNENVNzbktNWldJRysvN0cySXgwYWdTL291V3ZHazVr?=
 =?utf-8?B?MFBPMzh4OHM4L0hSUkd5YnhSNEp5NGlLMVN2ZXcwUmdrbVp2L3hsdmJrU0Vi?=
 =?utf-8?B?QzJaRXQySEF5anJoZUlkc3hFdzhUYnE5UFVwZmJJd1NHU0JOVnJJZFFGa2Vv?=
 =?utf-8?B?TFRXd09sUXp3UlpRQ09sM2FuZVBxU21mQy9ZKzd4MmV4VDJsOTlOWkpJRnE3?=
 =?utf-8?B?N2UrT1h3dXZsUS9jYmY1bU5Kcmc2MmZic2Rhd2t3M2crVnpkVWZ1THMvSUUy?=
 =?utf-8?B?Z3BnVm5PbmVFZHhaQTMzY3h5WWw0bkR5SEdwRTdkclNsanVWZ0wxVnNGUita?=
 =?utf-8?Q?jtTBAXk2YIUlGO1SiCeBylRXguRAVHH+ejfyPrw?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1347cb5e-d267-4cf9-603c-08dc4c83f1d1
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 04:27:56.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1747

On 25/3/24 13:24, Tzung-Bi Shih wrote:
> If they aren't part of commit message, please put them after "---". Please
> separate to an independent patch if they fix different things.

Alright thanks, the separation thing did kinda occur to me after I'd 
send it, but I will do it next time.

> I'm not sure if it really fixes anything.  See [1] or [2].

Ahh okay, I guess it was probably a side effect of me breaking something 
else then, since the module only seemed to crash without that change. 
But I was also mildly confused how it seemed to work fine like that 
elsewhere though.

> By current design, the `drvdata` should be provided by either ACPI or OF match.

Yeah sorry, I didn't really know of a simpler way to do it, since it 
gets started from `mfd_add_hotplug_devices` in cros_ec_dev.c in this 
patch. I'll try and find a better way if I decide to make a v2.

> The patch is ruining the use cases in OF world (e.g. [3]).

I was kinda worried that the module would somehow launch twice, but I 
have a feeling that wouldn't be possible anyway.

Thanks for your feedback!
Steve

