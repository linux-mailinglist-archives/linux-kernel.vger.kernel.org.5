Return-Path: <linux-kernel+bounces-85184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75E386B1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DE11C23FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425654F9C;
	Wed, 28 Feb 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="l+kmlhWD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="T6iMBxD1"
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE015958B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130606; cv=fail; b=bQuVnBQT6m6nWjHNBA3aWpVi2Cqh9itWyAofc71sISUE2qZUAuN9NZ1e6Hh6LiFSmLU6iJXT6rFygBrH7xCm04Amw2mAigfLZNIwdUhJeYheyhxx0FW8g8CQq0ifhxEYC7UbcxQxlai34jjOh5eMtimpeEwhQ5vYjnFwdU8XeLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130606; c=relaxed/simple;
	bh=eNGrV+nhiIltPpCPO5tY6Qja2z5LVYDK3bDG1QJWR44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VwLIfWwLEAu/K5GVlfCJBN2eKZRm5vOj9BVyLKHM8iFMnSQ4r7IeO0x6AsTDMAOsHrswwQh0GfxyJ+NbF1bjY5CnS2aRx66PgDDzCMFtdnvMSLtiOc34NBPzGs0MinjYhR8uh4+ose3iYt+SRobWDab3s1gzmPAxZoR1BK8Vbz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=l+kmlhWD; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=T6iMBxD1 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 828A15290DE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:24:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1709130264;
	bh=eNGrV+nhiIltPpCPO5tY6Qja2z5LVYDK3bDG1QJWR44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l+kmlhWDxQH+2b/UxuoNOxLGFK5WFnaVomA/Xy3V+fY3eEtFro7MBz1QbO1OTeiLb
	 GAOEYGxT6acRkWNAgj/zfW/7WXlJyZiLHOqI5JKWF76I0I9eoNhPKZt1I/ABJGZQUH
	 gI/gxbkfgBJvKnOV1H5c+D/1KJ6uscepOiy4hu0c=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 2A065529D55; Wed, 28 Feb 2024 15:24:24 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx403.security-mail.net (Postfix) with ESMTPS id 64165529C60; Wed, 28 Feb
 2024 15:24:23 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PR1P264MB3847.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:252::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 14:24:21 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9c5c:2fbf:64c6:1dac]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9c5c:2fbf:64c6:1dac%6]) with mapi id 15.20.7316.039; Wed, 28 Feb
 2024 14:24:21 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <10be8.65df4217.62e77.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXvRBCcmTSsP8YFWHxUH+7Qd7p6JA3ugRPjrgaRBmFf7mNHeYwD9qtCq6A7mg1Tf5GvVMuiFHQGciciPjhSqLpVXGLa4eF/g0Ru2fLgkGoMTfijscxDfHZy6dyLWmuaNSoQQahz0s4ZsRFBc6HhJVBmouFiEanmNcts08tCV10DM2CHYLyg1NGU/uqzdnLe+NIT7uMLhWV3rr2Et/Y2s3bEEyb8UY0GwXmdoLIaYD4FFAC+ieZwrUTIy9bxV7GKBgv2kEpvN+TdK0UdARjaLHH1IKEK1NsZhtRYtFOmkaTsS8dTAsVeVdP9B5jjdXQ1h2PvSaks6uRbMG6vrIP08Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTLTZqOv3UZW/INnUNdfcBE14GunzMfW8KhiPMp2mzk=;
 b=c1pc2qov4vubvOhV1W0G8aCKl5yx0DTPf5UvUA62H1DJwgDuRoYTSgQYBId3N6a8zzeRgmRjmCZWVK3+IGUl9sE9sLEbs9lRR2+GAOA4lep9nnttbskTB2aaUPh+dZufdMDv76NwpkT5M3pTE26pqo1E/1CJ0KppxX5IdlJ9X2K2tY1bKs8OBIclCfxNqIuK+IByjisllDze1MM3F7TG4WTZBcuNqoMAE9EWqNc79I+1oY2eFcmxE26zKGbrb4Yt0+QsAtFc8LsKRuuqPjWu3ddnwyFxlrBrTwjlY7wRmnnLyuGyPd8axTizT8xa2gihxpgdyVl3bi0JJ3q9+hEiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTLTZqOv3UZW/INnUNdfcBE14GunzMfW8KhiPMp2mzk=;
 b=T6iMBxD1SkzKNVuVdC8Kc9MfEbFrV3mg5Ihh25Z0i7i2S5lz8lgjXrv/T3S9yuE/QdkKt3RA9G7SbeAtesgrqXEeYoSp/wr2So8Rc5NKYBicWbGb6pw0cdbTqx1Eeh7bhXOUeb4fnIpWQAfa4OUxUo0FwBIMIoPaY6BamrDA4bb9Ur5F1TFjm5E8mrR9GLqVIffR1UTEg4VE0f4CGlHgRO1EvQjzMsRReRb3wSifLdQbmhlDsuvAx49zll6Oya/JP6wcHOph5qf5Wqyndy0cLK9mIu0b1vkfckXTeMVSRYVz8EYjWreZlWNPqpokq2LPikdkmvlWaPHJCPMFXWS0vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <9be431cc-7300-479e-af22-e02c1d1460cc@kalrayinc.com>
Date: Wed, 28 Feb 2024 15:24:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240227131610.391465389@linuxfoundation.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0531.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::12) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PR1P264MB3847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2920cc40-331c-42b2-d4df-08dc3868f475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqrH1eRxqVdYXMIeOfZ3a+gZwAKm9hpYbKWNT/b8c+73n4lS0Yyjch9OfPMySvdzx1gS+9sz/FbfFFsWMsGk2tsX/8PhRg5LqueeesWGZVxxMRxsjKr5YEAIx/f2bFq8hSHfYt3I6ny24aLmbfQ77vTSjy/8hHec+cAa72hpsKu6AHoAroUyZlqkUbo+I/oO+lkyQo2jgxbin7fwk+n6dqwR5TKnF9qPUbQQUTy74X6QeZLnhNj5ATlX6p7Xarnf0XLQVRcnGL3zm7wNdqiC1H05dIs1kJVF4mqNmpvSwuZpKvVS40veBUzMeO+ZXryr3Wi+O1lurZTf28c/t8lk5SCcke65hDmuzeH+/UdhBWxLhyXMishfPxJfHyqv45w8cLAg9Eo1ZinuGHmxuE2niDtCp6uXlK9V+9qvD+wzoh0cutzk8FCffjBe4PTMoWNIDJABA/Ebgh5WO8l1sQjfgbaAvD6suzT8EyHThu7kicByWdW6YS0UuvZGYqVtG6m4JJZLwlTbDEec3t41wop3Yc4PjMHajnWrNahywPf7ZkIgzW0mm1bOyCq4uXzz8tzTVeEyvZRZPqvViQhjo6y72A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z3/dqlsK91zfPiiGfGDVrN6geWRTX0IY7JaZn4gUn4hwA+EiRfon3sPa9eb7viFhkWFpAhP08FTEKMyYB06eDJZBxpUr7J17sg7vxtcRdPHAXUj2Y0pBJn4+L+JUlUnzh3IUPapF7VEjgaIOucEsImTfi1ip8TohYM0nXMbEaoEfdeMqRdpRpMAxGAExedgZTM0Ok18vtOua4ICzK05LcvaKGS1q0DWS+RRZ3yjZebETGkL+SI7sP5dFmsOdvIw3NNLczlnOl/hlgOtXWQ8+X9RSYXR3XL3BB/NwLegp1nqw5dh0lJvKYZdae5s7OX5q6EGQjK6mu6vtWwBImxog5NTgHyB0g4fbQ8k58ovwYPllMiHEIFyABDEvIeFTdl9UdtV8nZpRJANQXAwFYeEcERvtuwCMNT+LxpDRlhNVCq2RGqmouXsHg1zV18AKKTH2rz+saNsq1eefukorP6zFFlzlKacLdHedhtDVGwvFTQgURgkBAz5PCQ4WbI4+5OPQFCbecUHe8+YE1wXH72GE9QI2XivgoWTMlsch0JCMXsY9Kq6k5y7bO7EjVGU7aTOB3bW2waeNlI07usCTNVJ/MwMhgrLJSe/JT3OKIZ+/NT1rpuCHWFDOmIFg+KCy5uq0XuYhrFTaeCg3VNq1VBt/I3fHSh3wMW7nHes5LqwGFs0YtipoYTiKHiY2i9v0y8J9CtrKBe9z+mqDsx+eqcpmucEIaS6NTkfSb1N1QvvM7vwFdn2oMFjXb1rZgd+P5RzT3b7t4JkNQfh1TscrNKm6HwaRpQZFgb+7zsYK/7e+gg7cJNf3sqH1lzhP1d0jc+Ei9+5bIXxupA0oG6YTMd8fTv7PQDrwKRvkygfYzGlX6p8uUte2mSE/xJmg4QzQr+jmBH7gWu0zMi3YYlJG/Wu+dW18PcExYSFVaI7zb3pGkY+C71s2bB+hHmj+ZOtyDkIO
 YARjJPGA3XMLQjrSGgfTnDsAyk87NdGfPtxsUqRcryV2tVKVpxikDxsCptYTVFHaRn8qBVTOIke3rVs7QpBdUQJHjkovHUF2Ro1N96AFZdizi2a1ueaTh/g70PnIay0iH9J7EqTC9DH6OxZE94cEEaLadtKLBlGPmRiQlt59OeWyTm9EE+XOCwnOzqo6GzmNK1ZpJSQPofUDjaZXYHvsSgHAxcyFCQ/u6Oz/zM4bqihe1EmQmsECLeUzs2O4RY519mN/VkY4royp3KnTYkWlF6ogOjjWwdV6oiHuwMBpYmKxq013rcQwZsGwEiYLOQWonqs1vv51W/tgTreQRTuhNaWO3EG08yw5aOy288fTDHdYIss80M/ITrg1DvLO5Ra/mOzZMLq6T04xpVrYhZsN4wFc1Pon5eSmhCdcP8wGeubUR+2I18Dxm4xzGfv3KGzPaIX5hxWbhTcf5yMHjrY0nbNP/07ydxuEz+CICx3ypNZ7mf8TxHW/d/kEt7f06ZOjFFyU/Czzs8Gv1nhchnHKTAdoCXy+Y0Kr/Av1rkKcZrqIwTku4mClKNJR1lfs1zwdwSdipKVmvlQNhW31N41QxABlKFZZxIU9L5LJmPZPFM9Cv+oFHTuiBO8TA9P/Z7cejZLrrPg0/ywW7MydBwTDaXpWI/onSkd1ORrppC7z9PpYB139zDyfZce5oA3/VST7a4ZeTNwWWB4MGjzj+iPNxw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2920cc40-331c-42b2-d4df-08dc3868f475
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:24:21.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbHV9ugXP5sVQINIBbz+EhAUEZcHRAdBjBqpRrPmqNWSqSCOp5rheJAH30QGkz/Wa5JdTE3Mf7OSVNl2/U7POg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3847
X-ALTERMIMEV2_out: done

Hi Greg,

On 27/02/2024 14:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
I tested 6.1.80-rc1 (8b73abf80c8e) on Kalray kvx arch (not upstream yet) and everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 
Yann





