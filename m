Return-Path: <linux-kernel+bounces-65121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04527854838
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56E5AB21649
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65F18EB1;
	Wed, 14 Feb 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="mbcyOHw3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="IrkVKLKr"
Received: from smtpout39.security-mail.net (smtpout39.security-mail.net [85.31.212.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A66C18EB9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909910; cv=fail; b=fbu0If0zTbkAIC1UX3+mSDEhiIkx6hTq1vZFMulQ69ocyJ0R10kCq1Lbh4JO8sJQke3v8T+pe5wASyD4p/JbrzQuBho47cYs1aWSaFobRwhJ6DlsD1uo4XYT7wV5EVq8DetgYyAXwDB6bSwClSf/9D9dOmvvBuNSkl/7eAdcYvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909910; c=relaxed/simple;
	bh=rodBFnauBKkzzUOSkDDq9hjz/O0BbkzgvGHsphon4Fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LIHV+zpDp9gHQd16iVJIMh4d9QvO9gHtG2quDQONDhysq97XsiVz9BrH3ILv/vYZsePuG6UlcxFV79mK70/lM2uhmDEySQlSUJuQbOC9QSvXKwh0zIKVR4WB0ACM8jjx+VubOOvrMMehv7ZED4WAA9ZTjeqe9AiwMWwMBTDkVtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=mbcyOHw3; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=IrkVKLKr reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id 6529975DD71
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 12:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1707909778;
	bh=rodBFnauBKkzzUOSkDDq9hjz/O0BbkzgvGHsphon4Fo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mbcyOHw3SAJQsvmzax61NY1vnggnXsR7ryvJ2LuJSF/fj9aAqEECPUhHB2so3nPAF
	 Eo0Dpirm8rBtJEX0JDoKgkzeegZmYRxgwAXOOx+ihObWC+udtB4O2M9sDuyz5LBedO
	 YnSuTOl6cFjCzLKJ2zDgt+abRWjBqTKjF2TpizhA=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 1FEB375EB2C; Wed, 14 Feb 2024 12:22:58 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0101.outbound.protection.outlook.com [104.47.25.101]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 94FAD75E4EA; Wed, 14 Feb
 2024 12:22:57 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PR0P264MB2936.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 11:22:56 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::93d5:e45b:12c4:a835]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::93d5:e45b:12c4:a835%4]) with mapi id 15.20.7292.026; Wed, 14 Feb
 2024 11:22:56 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <582f.65cca291.92daa.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEt6HrKhaD7F9A/gmtqYE5v64oy5t6CqssO0X6FkD/L05c8D5qZu7kpr/+QrkuQDn1SPjpEOnEbZuqfSqMxGgciBavMWj5HTnaz9sJ+KYvXEylpAuh24LiGgkvWvaREMudeW24DAFIrUMDHgoiRnTRhyTdfv4CMLzIyfYAqsbpvc/yG/gHgVJeSOBTz6DsSVK+STWqnuSMJClEWMOCHkhEzVwl2iQiuKZLd/wEuPLfnoc8kRLF1QLaeAIzveaarmKfWN2yREWy8mPXUg7Zjlyknaukg24L9eKQMPRgAcdEh0OsMIKCqgJIb/MOgKQxeYWMtNnjl07ja4fslNUCSaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GprOen5lM/BJOFvh6fOJnlZRRMI2NOJfX55qwDxXbWM=;
 b=jip2btKBRyGzhpimX+itz4l6rspdbHZPvFEXTL61rx1zxyM1W+TGfiIUqvUGoxy5uJiUe06pavJlDLnZebLh3fHM+OJkPHWYaeiLdWusnKwmhoxOftiaSfRES2VdmlLlw7KP4OMsqKlIgPfdFFIqvBvu3NpcTergz6UPOB/0088x9y/NGeo6BJgiQOYyi9i/lJ2X1v4AV/vcLohXTWhn/1bGzMO+KwxFwJK556Uu7Q4Woah3q92uHwCS3oxydGJ7lNhACBh895Lj/ScFX6xWdeSDZJAhwwX2UoDUyKRTNN8OIAFihX/C+bslLfO4E0GpvA3q07eytQ9bx5VMFM8xRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GprOen5lM/BJOFvh6fOJnlZRRMI2NOJfX55qwDxXbWM=;
 b=IrkVKLKrNUKMC76dnnrTffQ/0HDAEZCMvEvENalNKhCGC5dz3puE0W+jZQUJ8JkxDzbmxeihWtJ01cXDCd9YmWoDVMTR4HYIilyLL2U/Qk+j6AUit7VfmcAFddWOmwarNBq3FCfzfay4kNgdnBZ4wlLFxWIjeW/oxnpyx4cfNaqV/QkC8x2zyqwN/norkd7AdvCG1AOwYSZInsDXGpVxYapBpewLXpE+qC8AJpgN/hi0KtAsuNSopXReAGsFXJzVdM20vsGjqfDAZppbcwwwYhtq8oZ4l6efRMrk7f/Uidco1eNpXngfFOVVPHgJGHQZFlmKIWN17oupuX+pZCiSDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <e1a4c9cd-445c-42b2-8d95-4bbf924c3d19@kalrayinc.com>
Date: Wed, 14 Feb 2024 12:22:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240213171844.702064831@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::7) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PR0P264MB2936:EE_
X-MS-Office365-Filtering-Correlation-Id: cabcbe80-a1ac-45bb-8ada-08dc2d4f4b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzQ0pjGhrCz40qa7fe3dvfgP6LH4FYbSr0LlrdzVuvQo+Czsvxx2mM7yOquGKO5CgSHLAxAbe+PvAAHDaa4aZNsVLx5ngZTItR115wC2NsJFHjqRyuO3BVT/Ou4NNMASIasfgoWlyydP3ZFSYTVDccy5kVWQg3ldURzc36+TNtREcMFMawYMMjKhAnel1/jDNZZQDDeV5ju3/8EYlRy6YzBKq8gJ4aQQr9iQ04raHC/MuhrqacOXn5KbizDrvdJpNaDByNAq+4o2X7XnohJed6PgR1vDOP64dxGf3WNx5kBXC6ZM7aDU08YnqNB/iTIJdO3h8uWjwtLE69xInciC3osu88Y5x3a+XBWdmimwibocmbsTOT/77ICDGLKjvw/zexHqc2iN/+50v41vdtDk0XudTca3jqnPTC/ShOwph3YmyctbA300QAbdsf8tAzyBo7G9qxeAqo4z54VfGRv7FVecFYnR109xLszcgWIab/+aERwzHT4ckN953QkIAoS2ruzwhdmkqNNpRkWcWiHnP+3kJ9rQLE8mMBIKpsXxCJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39850400004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(478600001)(6512007)(966005)(6486002)(41300700001)(31686004)(8676002)(8936002)(2906002)(7416002)(4326008)(5660300002)(53546011)(6506007)(66476007)(66556008)(316002)(66946007)(2616005)(31696002)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aT0FI99nM5lvWYqV1oyxfzUB7AW0UvgPxUMRCeJNxFnX3CTGp1VEtu0zRU/mo4TQchUHKC8A1wAc0mGMRIJuCvlzULg5E+uBW8RAHqhYP5V6Bl+Yuj+5srAdKCvpDcH0mJrI2CohlvJfUVUpdGg4CgsUUXb/K7Z05WISe3czoICJjwtwC4sceE7HF/LrVsg6imuqwZlCQgt0N3GT8xHFxyKeHin6KjIGkaEf0vdSmyUBJeG1Sak17npLKWyUeaK89/C096nEGc1NWBNopFGoYzUWrj2GkAx4NQy/y4anWBm/1lKNUF7sSPI63Y0gqtrZNmfpMvEfXZR7vD1yd/ysHAqERs/u8a5yLnTpUcX52MiJQfUu2kzL72wRdlEIUf8px/xrmAA2c52VlUbQRM0Bbl31oDL1vWKKQMJDcnjxE92FAAYopn+4K4GgJjfZ4K9gfcxQ73c7gkQaIKyTAFYlJ1ZnxFnDOWOSI2n6CdBTFYFduvXxXB4NRtdiiQ/HCSXlVuTSAOE49EUr972+DHdQ5LMVW05fU+UNEM6yAY2+F1SspI3N1tAQ5+PEiR6EGA7y0e5X8wJVGNYd6WjHc/zp8uMAqhy2FU+bBlpGjgSPHulRGzwLXAVs8GCx0SCUcHq/q+31Lu1v9q2XFuCFepuSUh4l3ssA3wo19KCgVQxWCRNvR9oZJfCH0JXWdOLsCAW7GsxsVs7bi6vp7fbZ0XsdIn72Dg9e5ssDrq6rdcTXMSY7V4/NquebILWMGzhjrC7F4Mb1Dj1CjkQMBWpj/nb0hL9n6Ro8aovl2IIcWo+SdzxvwkVDdrJhDkdRdDMu82evkU/ytdcTP9RgBT/eUoJJ4JB/gosF7fB6+7ygaptwDJz6yY513g0TOKNUbeMahEcIQ/phVVaoDQ0prTBGHLY2STqGaaiHjWJ2xQPnXRfiZjT739t5s6wWmgnygh/0XfLB
 DiGREH9IHMyWjXUlKuELiHRpuVe5SaHyV7StS5GnLh/9Vbn5DZSENUQitD3tg3ZaGQkNxx8VZgO+U4R4ZvaC1Qu6h0rzGnS5HMT971csLQbKxcZl03ohUXA/EvDilkXun4RomoJzGdv2++87KR9bsNToXYuxkid+Kls0ocKLJMXDM9nYwy/mwfJBHkM9889vDVTPNUJ+ZDWTI7jKMh9e5eV4+pQx5xbNG7Xu8wbSuYDObjetufnYKyXVg3s8JaJuJR7ENcZ0DikTP/9i+zuT6QTY6FJYzJocFnZ/psPXzKfadp7ZqQwgwWZor/jgRmouhj+UItCgEMhHyA9EItogsLAOgSufPTyzgJWHqtksuoVHWawwSoJLHONE1wNfS2lQungg1pnXZGyIhGupDhqSIiRwk6y94XHcYjGxi1B5McvlF1uJ+zx2td4CuO4bUEbfiywQLgWPGhS0Ga6wwdC9GoPwqio+7Zu0fPsOy7MFEH785ExwVaPCgOaJzGrUkkrE/1KymdwFsFMX5qrWIzjSabJF6DbclfOsBNpM8tattkksktJqYrdNZ0BOhM0gLBj9BgG+6T6EO1ig9ko+2vkWXdcveZVMbpHwxoLoDo0njrUtpEZ7qAjmcQY199RnZtI7JOMiaeu8i/tQjzV8ES5hJp1AAdz41yV/xEZHSRdp0t4d0gArqzYWww/F4WPgKCXn4tzTm0RzpVG7hLQKMwdmKQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabcbe80-a1ac-45bb-8ada-08dc2d4f4b00
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:22:56.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+4N2RTtGQjl/kXPRcmuG76lj6RSYtk5UnnAuzl0sIHLO5bwY8KbqElUzoJ1ql4rg8EYyfpHbSNjfkG67MW1Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2936
X-ALTERMIMEV2_out: done

Hi Greg,

On 13/02/2024 18:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.78-rc1 (b29c5b14893f) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






