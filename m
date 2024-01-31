Return-Path: <linux-kernel+bounces-46438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932C843FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715291F2ABF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EA37A712;
	Wed, 31 Jan 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="N9bQTgtU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="JFT+D5/A"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B907A707
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705406; cv=fail; b=NVvBtAQadpqhqNHsBg5/GUoEz6De6uI7z8Z0ihzfix16O96ccjZH6KbfDX0AYqp5F9qX6z4sXE/I4t1Npi0kmeJFSpJJhvYZGDSzvtVQd0VCzgtrVKnAdIJQB0UpaQ1ADatpEKujGiYGmavO1bHItoR1iIPmmmvALKjO4g7DhJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705406; c=relaxed/simple;
	bh=dqrLgQ69Fk4P4iNXoImTxM27nbtBc2Y6b5KLKfpXyOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/fSSpfdxJczuzCUEYAuY6li5b8TNdX8wwsAEvY4u/bpfPoBpm6VF7UfZOUq4fYp8wQ5o8LgiIULb5kYpnjGKA5tJRgP42Bl192kZhc2MnxJxr4cUxtyk/++9N1E5AeH9CkrYQlRKrf4xBFzelhnZjPhf2w5qW1mMxet60gEkeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=N9bQTgtU; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=JFT+D5/A reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 47CC26961B6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:48:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1706705291;
	bh=dqrLgQ69Fk4P4iNXoImTxM27nbtBc2Y6b5KLKfpXyOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=N9bQTgtUNcg7UWJNFiTEeVTyDGsg9yLN5OtbpB+VHz8SQTVCWCda6vkJkJjsvIB++
	 9Qg+JCYE64tFVeWf/mzl9O8sxO6AXPNV3tp0MKmC4B/xSZgXocX4LoV744MpQbU3e0
	 DGTFYLetfjfxn7BVNzBDyYhZIkG3P8NZ3+pE4AOw=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 0005F696735; Wed, 31 Jan 2024 13:48:10 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx403.security-mail.net (Postfix) with ESMTPS id 5812B69614C; Wed, 31 Jan
 2024 13:48:10 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PAZP264MB2991.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 12:48:09 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 12:48:09 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <124e7.65ba418a.56c1d.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1tAWbFeBomG6oSvGEiSsqCvNePtsLazTgzJAW9UUnIdxa8TxOsXML0rJP5Xz0ARYmPuEPOb6MuNW3pzVD16c5orucm8igZiEQHI3suNNZ4xLJ2MsDThTEJ8oWddHRQw7rWXQUQymJOohl1Imxy1IGo3T4209dOhkUnmk1Gl2qEvRdeZ4s/xfo8TJeq6BFUJAq4IA5VbHhMecSEZUS2Gxr5MfdcQQfzOv0DswQw5gIsc7tlXSNZYMsPPRo6rAr5jCUaGMXDWZ9qjl81WOTomfoYk1DmXz9Mlozqkj8/EoytQaS82EG5y7Z+p6TOb16GP8eVEVG1cQ2WLRmBCtZcojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpcjZwta/o2mhWR48G4l0vCj9gvj+fTP2B/n9T17UvU=;
 b=f+jZ72QrrghWUqYWmgMIDbDVgEsdL9+oFgglHcXFfU8pOKJAUNn7+DWPfyLDR9ihmTUGhvK9AfI1JdJ9ahoan0kOUnLgtd9Mil26iUiuKgeqzvG6F1g09nL7ZtEqZi9RrHZpk458l/sW048Pv7riQ1LKxBUga9G4J4VKSLg5zusxOhfo7NzjVvUjd2G4RXo6wVKsxULOwNkXzefhE7ys11XrEXroXLA7/xv9CFbIJ6GQo1wiq03P31PMLas/bXgP/aiI3fgSgtB3Wy8RlolCbRTHC75DQNnG23bONRJ0Xf01fbARaAlhGNXk8KsbXHV1Uo9lRyBzvy4uENyXI8LaNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpcjZwta/o2mhWR48G4l0vCj9gvj+fTP2B/n9T17UvU=;
 b=JFT+D5/Aa/lCFfWfgZCQ5jjz4V7QZeX1zLXYKv1NImUFDJGbtCgp6kl11d8L3PBppFAtuz0Msr5x8HQRKBcN/SUa6mAn87PwhFJ0l0OuzmzufZbJURH3hGVX4nyIbym6ft/3xo3YqTtuOx/EZAu0juxh9wmWzF3WM2K9Wyj7SSu+/kHzdnMmFfGa6DBG92oMOiZCjrHxQOiMQNrqsyt4W19OkI1OUQqHL46mMducS8xFeErL/HtJI4mRL0j5+KxFoOn7pIHZSC0sF2sGU3Q9SGfOYGQa35asWHwv9JsJoHCOzcvz6eBCBvmRtYDHCjKBi5OS4Wp1upf0KOUcG7HeXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <0e198b3a-d05b-45d7-9603-bee6a234fb80@kalrayinc.com>
Date: Wed, 31 Jan 2024 13:48:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240130183318.454044155@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::8) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PAZP264MB2991:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fb4b14-6d94-4762-e838-08dc225ae046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPNPbWYCvOMD9jaoGVUalL/zuG8ikmV3tiPWcRTYh5zZXM/PRYJTrL5KX7cbAe2UhuLj66bAZMXsOVNTCZ400BiZ+wK33KVLpNhD1pnd9bblWF9fQu/O04W5k6k6yIKf7cbq/zrF1UKLQptqojd22e4laDu/mNxUnkJ7Wo5DktevJVD3nchXUYNxUofVJvTCFZ6oT3eScujAUFk3SbwIxrwVOdXIzcEhH6p8YY0T0/5ceG4IYIFvuE1EHSzaCi6Mie+SQaH+PgUbQ62kxt7r995KaW3N1STF6q/C98gfblAGX7rP75pz3q3WHmcuyBb6F8kadPJfJlMP3MiqSYkHP3HcPqyPZ91ghCU/KCnVbjuL9HpW2uw1mMCs187eJVly7x9H3OEbyUldfYisDr5QbwFJOkuBsE5GgfLj74GjSHwSzA8ayB3Jfo0mvOYDGrFRKIc+Bd4dSW/W7QKV78scaIlvzRy2ry+3uD5oihIKWKAD+szbW2TdEbOlgo8ZP7CfYNKMkGL+D5cVd0rsIbUIZbsrXLNKMTiu3DYp7hk46ANZMYmHMo/3T9DF5AeW+OEpwdo5ve1YI/TbBOh8/zHGUyLphFPFU9jepyChLqPUpSBRghhxzbX1WfQkFGLCdLIr2hVNkwaA3IH6CiPomQQLrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(41300700001)(966005)(316002)(66556008)(66476007)(478600001)(36756003)(6512007)(53546011)(6506007)(6486002)(38100700002)(66946007)(31696002)(5660300002)(8936002)(2906002)(7416002)(86362001)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WDWRAgI+FXIpecdJUqGx1M/eNvOksbbDVmQtEPc54RmaZfkaQZM7kP0wKZShjNP0bq0bYDHcxQz3Qw2rfmsSwWKFJt05D3hzd61aBtpSAV9hHFUYD3cB/E4WEFF4fOgHGuKSBe2sxnGL4zYw7l3wzJK+EMrQQN84U1kLSWNnKoIwQ9tqinRpPOJjBLE7e+SYKDHV1TP0qbMKOGOCK6gjF3vq15Is1EGBkOCOvrFHQvQQhPNsj+YKOAWmSfOPszCWT6PxMr9HmRDAoqb0v6NWslvV6YBkuWza9J31EA8lTPPfdUbhxgTr94d5QYn/p7sBQiMvrVXA99v9LCFxiaTnEQa8yDpCI78ma081WyY9dniLmGm27hmlMJEWZd+RFygTNODTB8qTB03wM9vtjEl6+I3hM8bjkojPyn5RS0WEPEdV9TncFm6asQSI+DL0ptwDCaDx/B0+SfhkYWLXWbS3rU57g24S73SZutVfHmjcaT8G29WEgP/kPNXQeJPF1ttaTopoLFeIPfDYd8SgujS9dOWTNovIxiw6OagWNW+qdnqUBE1455SPoZMRjxR0lbMpXvauriA6ZeF+h3LedmIFQzv2o0/bQzwvcuuH8zF0cKM5XVaSJF2uZ0u62qVu+n5D5/3YhOFQibuD8oas04G0q1QP5Zs/W3MEk+KP3vsgsMNBDx/rpE1mgbf7S6CRjHFBIlokHxmvmOigOanl9BIEyckns377GKMKZQ7hDM4VI9QpP4VNzVgH1ZLFLxqKrDqe7X8puYHrf/f7EKQwy5ItfKu/B2RXzBqoeXaZZCOGCwSr1u8Rz3DpBZQTFrvKIY+Cyi+XiZPVGfqhrHJIlogWO3FdK+jFV8wYkhqq3ta76CFxqTnmPdrxqRz0IVu43pOcnKdDR02S7GdRhHOrFvPARDmmuMbJhwmj5p/sNrpJQSBNA29DK1GI+YgtnRMkoqp0
 Hd5mzxu/Wtnu+flDyUbBiV1Kg6ZnkcK14awD/LrwOD6kVuKXGqtztplOT2R6GiH2FwWcE3CFRvRvtwapx8OZBKpywhfg6LTGVznrjv4JwznJOpkYPO+iUNb2iI4B56urHSnEiX2ZcVCWDg8oY8KHELj5eYg/sluQxQIuaUBGbGhJZPRqc3yGCg+YvfDAkRaiduePG0tKtj01gnsY6ugAKHfk5tqpxv0uLebd1d+UsoYHN1bHYf8JN8e0uvwtOCmbrs40Mof9LbjgJSlJnlWDqm3IpxNqpdXSFodRcaKtmV8otecZmxcOw8RxfdfWB+jJH08Y2qdKCz8z17aSXVBbxS1a6yf8+ttULGsd+nAYpjmYRZO9SwKB9E342k7LzSU9DDNEICvbzsKovAW/e/LK051FcbixbPCMIl1oohF3vw3zr3+TwSb8yszBE4ziUVx35iIgDpbohfBFfnti9nK1jVkXAoLdvmZW1CdRK6VPwFeh/b71gIv+6uFnV9ohvW/hMW884lQI2Wv3MN1P8SHK3sT/3SQW+ktxeiRsmvwugJjcyJ11gQ+E72nd0j/T/QpgEcI9+6qC68uTAiQn+W2sBzWPKzBpLnRuPvtYoYn/6efGQ2zDMMH/QdhfVt+GFo7U+LWH8N9cQ3jIkCqOttUub7xkJvyqNmWkyCRyJ6QoFcFkocFBraMXFqTzhIVMxa4U
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fb4b14-6d94-4762-e838-08dc225ae046
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 12:48:08.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkV4LgGbmnVfkSHTRt/ZnxuMyBfQR0dfP3zUQI9RusdncDnDvwqYqbGut3jmfM58lFfWP4HWirSj8m8uTEc4tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2991
X-ALTERMIMEV2_out: done

Hi Greg,

On 30/01/2024 19:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

I tested 6.1.76-rc2 (ce3f6cd9e4cd) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






