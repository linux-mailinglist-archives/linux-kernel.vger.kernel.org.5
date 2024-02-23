Return-Path: <linux-kernel+bounces-78350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38586124C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8981C211C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B217E786;
	Fri, 23 Feb 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="f5RjaxiE"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DA651A2;
	Fri, 23 Feb 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693824; cv=fail; b=SAuvzyt1ghzeKmQKvJEu/3gLKPPvRERrVPkEC9sWzWHxeGh8V1rBDuSEIDV+LPcE7ht16mfTqTDS7i4lKnrGm43ZRkjXzIx44HKl6/Cflrb9Wgs/iL8oJpaHAxoQTLoPJVkRCRnZO88MLF0dOTdCdq+33OUwtdMzOx4X/JLVCXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693824; c=relaxed/simple;
	bh=0kcWSeb5OU0M+gQ883HPl1++WCoYXsYfxBWY6d8pn/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FxlOlphVdJfR06oVYdw9IrhkJMiAF33MkiWK2LtbIMfuq9c3Ksr7DbRYcVOiF+MREhEBQ8UFChuaOgCJkGrJ8SndHq2onN7uZRzpX4vmbdJ7an4LLvAah852PawKDNuyMtDQvZCa1ZkKcfb/yUa9af/EAmYyD/kLnj/Hmefe0rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=f5RjaxiE; arc=fail smtp.client-ip=40.107.8.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQUzh88AvFtrD6njhuDnl8RDaBDZmDDVcGwdK5kCbE9R7X124rGJyC6TV/pIy6zKq/cq/o6/KwcxyF9VfJvYCgtr2TvxJYDuZbKJt26+54v3oypxtO93n0TqVu2H326vMNMZ8wRaLio7t5DLL4/TOMBaPvMUPkKNaD+T3I1xr7SaXjPGFx3iC4jeYMW+iSXbsXAdtE8JiGmsAbLvLqUUNk/mB2skQdEh6UV5pG1e0A3HHJraCU2TC4I99HpQ+nFQJ/rgCxoE0bdxGa+xS3UgpHea+LdazyhMqgdY1zVps8zHIWdCJjsQf7MOezqzHPQN6FIJeqkqzqIUNROEisiWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3kOLtuoNtwSoEE/BpxFI3fM08A5Vd+Wc2BwQF0qxc8=;
 b=G+oWsMRr7C6AL24y7Wf4zb+N+VmtQwhuZc2Zjo2ogq/i5stZNPl2h4K8h6B3DMb8mQ6LIQuAUl1z2rP0CGVWGL+yNpekzYl9JxNk5X96t2ylO6puzyE1PQTy2IuN6MrgZLBpW+vMOtPKAtZ06GVzbJ7hkEw6ZSuvTtjoYm5i8KRUVfNJ1G4EuuLYVD5LCNXyYKfWZAQHgBDtOu2zv/WvNaH3SZ3DiNNwGwGlcMfJwm/ge/dcs+AoH2GARVKzaJS3IVfpeRetqxzqu41CUtVu1g6VxJG2ENcp/ZG5A1r8IrYe9ukvRDxjBWumm+Dg2gCeAUbE9eG4unLfYCcRMfYsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3kOLtuoNtwSoEE/BpxFI3fM08A5Vd+Wc2BwQF0qxc8=;
 b=f5RjaxiEHUgKt9xQLQ/l37pyHQ2gljzftT7b8wlMIKhkxQO0tvTZ0jh3+m/IaH42BEaEaX07KU0Eli2MBwE7oThbZ/UBJxRqAD/nUpURZAY82bKaGKcu/F22NVWFfWICdHvlYIS1yutcKhOmWfYJH67QMlb+rrNdPX6Ov/Qun/B28dHSPaNbs0sgIflnvNmytGov6F/U3srBoMl6TXlHwnhqrWPvFd+j9jy4t/C+ED8pZhHsqcV000vzxTP+WFfz2ZYZkk2r4G5cOLuBCokNKsYPI/w0wcgkyNxdUtmnf9lDE1t5oI2uarzSsCvE0GsziRVigZlOp84wVrRiPK8ElQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8102.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:10:18 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 13:10:18 +0000
Message-ID: <6f76ffab-69fe-4afb-9d7e-d3cdfe37c28c@theobroma-systems.com>
Date: Fri, 23 Feb 2024 14:10:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: rockchip_saradc: replace custom logic with
 devm_reset_control_get_optional_exclusive
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Quentin Schulz <foss+kernel@0leil.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shreeya Patel <shreeya.patel@collabora.com>, Simon Xue <xxm@rock-chips.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240223-saradcv2-chan-mask-v1-0-84b06a0f623a@theobroma-systems.com>
 <20240223-saradcv2-chan-mask-v1-3-84b06a0f623a@theobroma-systems.com>
 <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <CAHp75VfVTJsQDwaPoPgGiT6jnymXAR3WpETqaKai8rXAC70iLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ea6fa1-6e14-4bc1-a350-08dc3470c845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	36ZRWF0wG6ixhqHKzc/oJYMbXHIXCbB9Q3p/SoRNus9uJtlNotxLvVMxSKyijobJkoYCyDMOAqi+VR4zE7QZI5yJV9I4SjS8QebzHGN4+INIGnPcD5uWIK2J8S71pLgziMQn0VYGBQQMh5j3+iAeMcCQIgf5qA/vpy12CJo9U9CCARd3zq2LQxu6mKCjMbxjRWAkxnXZr17ivyG8RZ4DkjvEKAs+7OhzFa+jV9WgKHPWxhqAi6KS5rIJsgdKykceILcX/fYqO5cr9t+IP+hViS4DIAj3pTM+uLuN8svWZhtPPpUMMCsDFpuLpgjrASL3uvDBvwexNx69BqdlLJTWnzZc4zRxoglO+mJVKPatP6nNPLSe0Be1u23jAjZ0ZEGZxw+nc5HJo+BbxZFFIcJSxwOnl87Ms0wgMfiiJlxMM6rf7W27W5EhTq1vHs5YATTYYZyJKzbPqjRshkRWZu+6YJkml6xOxvZE6j0n1xn1ei/lpmFTin93ndDwvvZn9KmS88mxHpLJRVFPJ1BLbnVPM3fhfasembdCzfvZ5BZ4mpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlaaERwZXRwQ3Y3bnk1cTdiWGp1MjNUcW14QjcxSUJLTTVkcW5EQ0pnV0dG?=
 =?utf-8?B?QU5jaGlucnZraHpadzBlK1krT1BGbjRNRFZCeElrMUpaSWNralJXeTNiOHd3?=
 =?utf-8?B?eFk3a0tuL3NWQXFUVnRjTWhKaVQ4UnVTTExCamVWT2ZGWFR1Y0Z1UTN3SDVM?=
 =?utf-8?B?RFZ2d1pZcHJWMjNDYkhidTM4R3ZSZmZRM1FwcmJ6V3hDMU9zaDZSb2NMZVNC?=
 =?utf-8?B?UXRMZlkveHNlZnZ6WXV1NXladTFVMHlHUzhsWjI5TlpVMGE0RjU1WHVRQllk?=
 =?utf-8?B?WjRud2MvcTc1bjJpVWk3aVFPM1JrekFtdnB4eHphRlE2RTFXMXdBTGlCWURi?=
 =?utf-8?B?anBaMzYwY2RjcXRSNGtlT3ZTQjNRNEd1QzJuS0MxRVpjaDNtTUovREE0OXov?=
 =?utf-8?B?Z1BQRlNBaktLNnZQS2lTZENOMmUwd3hDc2xiK1ZuTVRGZy9QV09uZ3ZwWDda?=
 =?utf-8?B?d2h3dk0rMVZwNDU0N0FreHk2M0poemU2QVFua3dFcExwNEZobGpZajUveWN2?=
 =?utf-8?B?cGxwSzlxdlNJa3lFWHhiVnVuUk8zQ2Q5b2dLL3RURmF4ai9NT1RxUnFxTHVS?=
 =?utf-8?B?Wkc1bGtTRnlUZDViUWQySUhwUVBUUmNONm5Ma0taMmpSTjlGVlhOK2NkZkZj?=
 =?utf-8?B?MHUrV01wS0ZFdUxCMnpZdFBtc0d1RW1MT0E5ZXVNYnVVR0xOMXdIU3ZOUjRW?=
 =?utf-8?B?Z1pZdVJubGM4cUtQWU95ZEVRZUxEeUg5cEFMOWw3UnV1Q0IzYkMxSzF3UEpr?=
 =?utf-8?B?K1QyQmRzeTZBRDNlMkFVaTZ5SnN3dmd2QTBodVIvOVgwa2N2bTMzSnFFT0V0?=
 =?utf-8?B?TnpQK1IzVUlTV1hyNVFmL001aVNqQ2h4S3RnUTV6d2Z6dFpKMFZYR1hkTUR3?=
 =?utf-8?B?eVEvTmd3dHorS0JWYUQrY25JV2YvamVRQ1o3ejBJNXJDMTBnNkVUeWo4S0ZU?=
 =?utf-8?B?VXIwM2ZLOUZXUmFnMmxrOFd6QUVhODExTE5MMVJBWGcwb2dIMlltbDFLams0?=
 =?utf-8?B?aHF4ZStXNGE1Y3pxUmtCUTJrQlZpSDdzbmt4NUhQTTRrM05SM2FxSmJrM1BE?=
 =?utf-8?B?VURLeTd4ekRrcGNFMDJkdkpNUXBDMkhMcnZYTGd3T0JBUE1CWnIrRU15azBU?=
 =?utf-8?B?WmJqS2ZjbWc3WUpSSDZydnNlaWxTMWN5NHN1cUZKVkttUHF6NzJjYlZCN3Bw?=
 =?utf-8?B?YnJXV3pkTWFmV2NzTUl1V2JNZTAzT3V4a1FWUms0ZTBROEdEaU1DUXQrbDc1?=
 =?utf-8?B?STZzYWhSMzJiVDcyT0JiUmVWc0ZqR01KYWluUnVKOGdmcXdPTm1XRG5Xa1Ix?=
 =?utf-8?B?ZFFoSUVZK25LaEV2aG5seDdKWXZ5WER6M3NMcE9XVjA0V1BDRDdYdlZlNkFQ?=
 =?utf-8?B?Um1BcGp6NnVyUVl3UFNVc1JVd0RnaFVKZFY3NWVmNHdpLzdOZzZmU2wyR21u?=
 =?utf-8?B?UmhUcHNYWHUzNjd4Yis0ZlhQWTYyYVR5ZFFneFVDUUZVck5Na1ZXSGhtMTEw?=
 =?utf-8?B?S1E3Rm5FRDNad0swMEZqUENWeENMYmRYVFdlTHE0d0Y3Yk1Qdk90aXJhckhP?=
 =?utf-8?B?a0hGNGJKL010dElEVmpINE05c1U0eHBwVFZ5dFVZVGVVeUhDTmFlMzBxWDk2?=
 =?utf-8?B?dCtxYkJTUkNsN052bEhrYzRibm44Z0xTTUNIOVZ5bjlIdk9XdlM0Z2g0WEc3?=
 =?utf-8?B?eGNBb0s4NjhLaG82UnN1Tmp5eTJVUm5lSnJNaVp0YjM1TmhoRzh0SGVNc2ps?=
 =?utf-8?B?RTRLblcxa2xkYWYvK1FPZmFNeFRrK0thZlFoRHNxREEvbWJMUTV3U2tNZmJ3?=
 =?utf-8?B?UHlrMWk2Q085Z1JXWFI0MXJqWXVHbGo1SzNFVUkrWENZWXRxbDZGSDFGVmxP?=
 =?utf-8?B?WTJJeGZaRU93RXYvaS9aTy9EKzBEN2cvRDdWM0lvbEg0WnJXYng4VEhMZURp?=
 =?utf-8?B?UGs0YUtqUDBxNlNmV2xBQUFlM1o2ZlhlWVdraTdsVXFvem8xcGxpMW1VdDE5?=
 =?utf-8?B?QmxxbERMVDhRa1NnK0lnTFZBMXFnRkxzUXZMdVo2aTRJRXRuT0c0eU5VZE1E?=
 =?utf-8?B?QzJUUDdiV2IrMkdPWWcydDVNU2hvcWFhRkxENW1jWHQyZUZEYjVBZXFMa3Na?=
 =?utf-8?B?dW9ScGpHL2R3REJPMWpFZWVUTzdFem9YYVZHSFBMbjJLQU1VT2V5RU9NaU9J?=
 =?utf-8?Q?ri3g6KjuuVmF3g1IYdSes/Y=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ea6fa1-6e14-4bc1-a350-08dc3470c845
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:10:18.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjsRtn2kFDvwwEHPcVkMBqgtsJs/mA8YmRuecK6os2tdOGuGObnx0iSsx5posME7jE2fQ/i+g4XuaKQmXPoCpNoz148h3KugqEh3SHp5SpMPoB9S8suiA5/JxodiIXLY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8102

Hi Andy,

Thanks for the prompt feedback on the whole series.

On 2/23/24 14:00, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 2:46 PM Quentin Schulz <foss+kernel@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> devm_reset_control_get_optional_exclusive does what this driver is
> 
> devm_reset_control_get_optional_exclusive()
> 
>> trying to do in its probe function, therefore let's switch over to that
> 
> do it in
> 
>> subsystem function.
> 
>> Cc: Quentin Schulz <foss+kernel@0leil.net>
> 
> You may use the --cc option to `git send-email` instead of polluting
> commit messages, or move this after the '---' cutter line.
> 

The whole point is that my SoB and authorship is from my professional 
mail address which is likely to change over time, the Cc is my personal 
one for development. Basically, in the event that I change my employer, 
I would still be reachable at that Cc address without having to modify 
the .mailmap after the fact (which won't make it to an earlier version 
of the kernel for example). Some maintainers don't really like this, 
some don't mind, we'll see in which category the IIO maintainer(s) fall 
in :) (I don't mind either way just to be clear).

Cheers,
Quentin

