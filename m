Return-Path: <linux-kernel+bounces-94052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B787391F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197E92818F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB90132C2B;
	Wed,  6 Mar 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="II9I1FM6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="vExbuuyU"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCC132C16
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.149
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735406; cv=fail; b=KtCTz4B+VXZeuak2IKlvM/pG/mpKD6GhapBa6iRh7P6tS1oYK5J5rJdvck+BZBqNUuzFVFV+W+plMzv8r/5F3FAAjS1NyUZZdENutxHS3yGMX5oQezOtXS6FS5SiwXUiZWhVyL+Mkrp7+x1amB2qzKGH1WAf1gzlUp2eQmLy3Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735406; c=relaxed/simple;
	bh=K79x8ZPxBQl5tSdTehGaVHGO0PE/mW6wwteaDZXFzSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qsgdmf/ejV1hBtrmxDhF2e3okFdQMqkpSaFfoYl6hroX7oswz+hN3QSS5QfKXoV7Ey429IwmKCHgMp/4vrk2R0eVrgg63qFvylY2sG10jI1EW4ybNScEsx/TONIIrZjt7ViiQ3s72NeCxHS2z7pDUUB0ql65G8zfZTTLTiE9Nsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=II9I1FM6; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=vExbuuyU reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 96AD4349555
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1709735237;
	bh=K79x8ZPxBQl5tSdTehGaVHGO0PE/mW6wwteaDZXFzSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=II9I1FM6zMcbpmnlvEI6GCaMAjDLa/QnQ3/Yo1A6Rw+SDGbLfbqZCG7yVhojLtfuR
	 t/DOoYE5x3bchLC2QmC3Kc8mJGGwrtpAT4T+N4xq+9fVBW1AR673ow4beNWWNNxYZx
	 L4L/N60dRY/x4/iVVSTJ55Ohk5r/sIwndrBo55q0=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 3996234933F; Wed,  6 Mar
 2024 15:27:17 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 6C814349355; Wed,  6 Mar
 2024 15:27:16 +0100 (CET)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MRZP264MB1736.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 14:27:14 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5db1:b5a8:71ec:59eb]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5db1:b5a8:71ec:59eb%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 14:27:14 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <154b7.65e87d44.6ac2e.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4R7hp2BuoiHVpCEdZKqUoRrV58AmYLdgb0bNmIHSCYUTYrllfZQ43A8CQRp4RQboJoU2uBLLcV6yafJbo8wH8+MjF71Md44FiM0xi9l594HmhHv/2PtJz1Mz5zHUl7HE+1HuMpOrt490uILJ7Z+UCWq62Hk1R+nolLXyhv3qrycs9cAMR1wRV6A9CwibAgQ3E8YPiQ40pgYKrYMUtsPtyLOv+w8fd0wPGdAekDQmAWGS/5Vd3v3U+rkLr4/b4x2h6VI6QqngZAl9kEiDXA8e+syeHYCf0UlSbM6dLB3BOdTZH0+Vsq7eoL2hsaJHrT68P0j28rAU0JCxy06Z7AFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwmfbFXjL49noru/mm17MsFiPSZc7SOLPZIuJH1gmao=;
 b=REqIuNYNzB81tvZZ/N4hX2l2TbxjkulBnukibM0B3U+BnOLiqk+oM1d/jDJuaXrBNegEVDsZKv/9jh9I1NFhn1+TVObKIs5zOFbbcpeEonqhebQBYOt41sLlKV8CPCPsdE1anzd+DKLxugH5SfEvf1Yu1Z5n0Q1KZ1aHb2SjAmv9C56NHcJmrKWZ09AVaO72XB5j1HuPVmtrWhoQyYEQCOd8cBj1qHg1HdDidmDvJBXMmdWfLvRHPLQ0fP60wziQ5oMaA4/5j7Zi8JagwnYTFr8QUUFKRFsyf7ZjTdGvLdAsH7a4Ab0A+6rojw5H0a3LHf5oMBeqGEXeIio4HbyOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwmfbFXjL49noru/mm17MsFiPSZc7SOLPZIuJH1gmao=;
 b=vExbuuyUDhwXlBviDK9FLoEdG7kQz0oJADUK27/AR0KfTz6dWPn+NoYYhlIfsSFmHczTlbCC2o+pAiICCpntvxWKxe827FjKL9JyIaAF3jSWy77kGiOGWJo5BGAf5QiKa3gmvUQfhH1o/rMnT7StLBlDiMRTnHY1RIeWXwDMLTD/X8OPZp3pHYDnOCPcImhKizmIHvZliFaYEQRMgAHZetDQWoKm4xzrxLsYtlE4uX/o7OY7Xy/tnoB26KQMtCCATnYnNMtjvirAdlbcX4ow/7bL4uWzZrUc2bIMyFEEgYIpMOfSCH7UbA69p/B6Mf9YhRei909V/w5yOdPUnPnKOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <70c32bdb-eb3a-43f0-8698-b67d1b791542@kalrayinc.com>
Date: Wed, 6 Mar 2024 15:27:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240304211556.993132804@linuxfoundation.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::19) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MRZP264MB1736:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d97aca-2f3e-4ded-dde6-08dc3de984be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99D3bbHS8hk40zRmVM27V5mVzsN9jSF3PMq4dGnunyLolk74Mer/x5xAm8gBQaUHOcRe8cTfhdwheWFZ9zhlenmCKJon4GtWSuQlq5gXfAL3582mIheVEE76BjVJLGF/ZeiMTpsg2b1s/FKVVUI/5GwiG+W35Zb6FeJsFSFu43iujx7D0N5UHFNJ7pmSDZ9xjYb4dKV1ZQ92t74tfMQvsYHeRun7aw3RStvsuKPKYVv1QohooFXoOIuFc4CI/g+NaZv34+ay0LTAikK28rtrOorlBV6To3vF1jNmN9cBAUSLSZ9srqhIoAknzyh8OA6/VkBCDFl/92HmkML3F8hcSioNavBo1kfPU0/lnpD4TKgT3/j/cl37VJ6LKjOOJn2I0SYNcf57np/KOEmxh07ax4teUzwBFaygGOd/eYVbnqBJt/LA2AgVaamrF/gV4pElmXsL7QLNVSdDBYFdQcZfI0iOlG5BqJivsdYMByz3OJPJij7GOODrZFlACPLooUHi2eQLxXpJYXFKyJfi68WxEMe4xg6AvkvrKaniogYJjmEcv3w5preCKl4yF5O5/4uW45NSX0nHjMoJYkZ9+OVJKghro1aWXMQkbRRct2VIvcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qL4KvmvQ03PpGafrXJoSAZhuOdvnq6TFxGXxwztZVgLcf+Xt3+N5p+emQyi+08eZoAD+GbmVbtBDTNUpgWkdIVWchdSna5NVPYwIH3QT1mpu3CKx9i3Z6OeIZ9ukSVK0LMvfu4ofkd8XpOSaynos8paQseAgA2IiZa4CqANY+1WtyY8KSo7QfDxq8zecRMrrl8nc6gAGFHlL+mgDNBFBCyqWrmTnYrKuRNA13AdGziykqhaPdnAr77//WHX+PLka50Lz5UQcDEmer6BUE/PDtj8T1TqTzbO4J4cYCGV6arGqYxcEV0Cwo8LlGmze9KQ7gtAeM8X4+LUTDQsv3CAplAoExiW9XqM/4g2i4R2j4Mzmv8/wgellxiWNNvkYqASAN3OiMJd7JSgG46uUo8xMnhjTHhf+7x3ZAtJ8bSOSWsvQFNR/tipPwbBSXiXW9oBysUhPOcCLCINr0n5rZg0TMNya85znJq/CrM4aJXzwJrbJtFLgg0R1tcrf1/MKSSCHI4MJCmqM06tv6LP+Cx26hmzsQSY2V+JeXc8+huxSnegI9/k+vHu4SbZaQMLCQS41diMygt0vz+s/CW5Je/qBN6XNfFX+d0COHXkVl9OXSZct104lcRc5ZT60tXaG39FHVe016S/BzH8f/JplO5caA83mzZkjuFebySJEMErLm+dPD72iksuLzO9Fl0+jz24rkfh9Pge+bbgxnXgYivGoOaDnznTm4GkfU2VKbgCve6LWzQMUbSwq1G8XgmsxfyukgU9WjSCwhUpwH+bMm9D3NY+jdM5SYo6YmR4ZOX+oP8eDpgMn/eOvXG02Htm3ApSsw6XnKCxy9Ys342ghV/8pv3vzJ5ucgc76s+7ZiWTpW6aqLuNEQsc0tsotPixfiWx0GiowQx/b84ZrKDcEH3XzcricBUcUpFd8tZlVj8JOsQMYmB1SXN6B9/gtdg2Zd0mE
 ppI4JS83/alxlDlz1wIpTuoWvcBdsaumS6L/dOuM8BA4SNxe8sNWBLVZ7CEt5/3o/mQzXReGjS4duSa36a7EPPyRAywP5DdnRPesczD+yfeeswAP2F4JSl3vI0+hX+erxLAm9pogvmBGzYHJu+IMlpFx5pmpa9c4kUTW7jEW59iWmdy832N4NNGfxmSvOoooKAxoqDRv1RkMgWAwC+lBiPbN0X4SYuChGXmt4UTH8mDYK+gYYHi1VsVnJ2e2NyfpJWxQiMfL7F1I/GluCvkdH8wHkihw8GFr6NSxzQ31+hHs2PkhUqtFuTyYBZ8kyPK+WOBrYXPuC8TjPj4XeW0FjPuLmbymyInuURgGHb2/iq7LB0fNPwLKXqUPug0a2lUQITRnR5TiO9G4CjtVrvCH2++cQ1UKqwWeMjBJ/+l4CxLUPpu/LwdAlPjQBOQADjqx2+nh7pPopzfePWyZ7VKkDFRLOw7UkZc0zRn387IYv11gAopUX1vD7TEk06l3r/H3TTbSDw5yKZkeJaj+mDl5vyqFSM3zHYgTzhqUtrKDdKqAt6Q69ZBs8o0SKk4GNQGOTOm9y6aIR5FW4Y3ylbJpTRTvFsKfkAxPm3fcoACTwoxkC/MvOqaNBwngVHqKHUoiSQA/czPHJY3O/6pmGdbs2KZzIGCTBwOte9xzvD7YEA2Kz/KrvrCrN5sX7I+kEt3da0XjGYWXKWnm2QpYP1L0VA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d97aca-2f3e-4ded-dde6-08dc3de984be
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 14:27:14.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A+S9Hwf+P3JRoicStIl7xqhl9fNWi+9QcZ0WDJo5AOVrH+0VJsgEIHf2xHzC8z3K+MijaqR55wKktOtLvAvpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1736
X-ALTERMIMEV2_out: done

Hi Greg,

On 04/03/2024 22:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.81-rc1 (cf578ac947cb) on Kalray kvx arch (not upstream yet) and everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>






