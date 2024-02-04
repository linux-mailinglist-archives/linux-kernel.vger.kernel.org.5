Return-Path: <linux-kernel+bounces-51689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F6848E43
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E46B21804
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B93225A9;
	Sun,  4 Feb 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RUaBlkRT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="SXCWr2pw"
Received: from smtpout36.security-mail.net (smtpout36.security-mail.net [85.31.212.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F02224FA
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707055507; cv=fail; b=FvIppmlMoCbfnHiybThgoAmmwYV8vdIQKEI1oCWm9HRWT25zXm9qx1bjM9VXn/HlgDW10aXM9OestrDSDerUWAA9cTwKtvfETkFFZPHjfsbKrurC7V8kyNwlOWP+3ZwR4T9jaekvUGOp3BePYan7x49WQtu6rdvibw5veC8/wa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707055507; c=relaxed/simple;
	bh=4k+tyaoPVHaqiO02rYFJwRXyYFQjxBIUQOOUe59iVD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LE6EL5ALVFLrcPRpiFzU9zmWHGjMgxA2O8jCF/V7UBCO2vnPV2tOx5Liv69uNLoqL65nH8FlngZ1n9vW6fUPfBhrDBAcDJCWG5bELd3oat622NsOCrT/yhKYqZuuV2ImSUIEiKKKDxlLbPMkSkOaAY0Qmq8hqowHIpXeWG/5V2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RUaBlkRT; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=SXCWr2pw reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx306.security-mail.net [127.0.0.1])
	by fx306.security-mail.net (Postfix) with ESMTP id 2433D35CF56
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 15:01:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1707055272;
	bh=4k+tyaoPVHaqiO02rYFJwRXyYFQjxBIUQOOUe59iVD8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RUaBlkRTWA6J/YOvddm6lq3Ei4H8AgrWNR+9mfgiRE2eFFp3QaBdBGblg4f/NsjxU
	 slA44H75KxJHavse7t4mAD2gapERTI4Xd/SX1w65CpQy4rOI9mWT9X6NEJPrA3v+gX
	 x90W7A7mJItS1s6op9DDzfucu3rx7+wXj4oqrzak=
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id EB40235CED6; Sun,  4 Feb
 2024 15:01:11 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx306.security-mail.net (Postfix) with ESMTPS id 64B5435CDAB; Sun,  4 Feb
 2024 15:01:11 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PR1P264MB2000.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 14:01:10 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 14:01:10 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <2080.65bf98a7.63124.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1/N9UVhcBsz63cOA4T+SDu1ztZOFPoIJKHAG9BKgqG2rofJ7d0GH0r7Lq7/ZkFIkIRlvWyD5KtWlejd0YJZCMV0DO4Mt/6IaVmphGYeBnisN3ULVpKNNf/bxNKm6/seYAZOOp1HGUjNcnjIWAt0mbdT8CsTP/hxTZlTcJWtzOMcn0ZoICCjWrlgIU62+Rnlc6jRuU5Y/N3xwZUTs07vW430gaNO/Vp7bvlD+XLI1aKfiboao9Dzb2qYVFywQpsTkwHEXN2HYKy4lk9JSDXVhxFQo5W4dqEGp7mcnbAEzZ/I5nqNwJA4iIr3rXvRJmVHLd18zMRudi3RQhe1VfPyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWpJXDzgfEPPih4yjZyW9jSp/aOsjvGNhs7yKM1pwLI=;
 b=Iq8ZA5iNOHXYT+v+CIxNFCB/PPrysCZ2A9WL/SQNugWwvr7/Xnmuzw5wsTtoKeZtBB3+kSovjxUX2hMrxhx8xtHPIRzbUFvY8T/NpDUSz0Vp/vF6vXLTGYU0VOR4OP2No3eE2Yv55HXqN4jplZb6cclarWIRkiWJYon1RqEoKEJYsvQa0DJPXDISN9eUPkCfqOabM8EDQ8BWil/iOEnRsOq+9dQEOa0999A4HYA4IxCKGaCeuukm/og858++Qz3cIXYaGZ8vcjj5UX0qmQRpJIKHsizume7r8HSuKszt6MFE4KD7D20BpXW34OTLzvpPwSK+9Qi/gToio7icB/yMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWpJXDzgfEPPih4yjZyW9jSp/aOsjvGNhs7yKM1pwLI=;
 b=SXCWr2pwG/ZE6/3EMS39nLsofY/PE8GcHewbzDUWjFuutO6Valww8jBTegaAkS35hiec9X2EH0ZJnsD3ORGGAyzdo+bXVRpJ0OXxXYxvhvGNoYEWSPfoH9qqL84pB81C6hAboBwEqcWUhYGKPWjo+4AgsgiaYqXV69SfH+UCQynDb9tpEa9ZNhefdpiJm4S9JC+NgXAZbeON349xkFCP3GY8+mGgqEKwtL1n7B92g+cozJEBTIzxc7pcL0wvL9/sQYn7PPX8/LASTJ+4ZBVMjgp9x1Cl5OC1pQF+EgDOMiv5hV83mv2Kr51jS1syEnoKzkeic//DEf9uvY5wQl7ZtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <67ee1b23-7a73-4eed-aff0-fdf34a0275aa@kalrayinc.com>
Date: Sun, 4 Feb 2024 15:01:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203174756.358721205@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::7) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PR1P264MB2000:EE_
X-MS-Office365-Filtering-Correlation-Id: a886af82-ec2d-4f09-62f5-08dc2589bd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdUS08H4LbPY7YB5rOVkq6rsWV1IEYJpS+ce3l1ak2oyu3Ef1vxwVClMEdZ3tBwDHYXmGHi/VvHSGST0v2QyAw7AxWgmpjT9+kdlvQtLct8FAdejAgZERoRv2B8eyG+yaBKgWKFtk9XMMlNAuDPUm9246107c5y7BB9fEJCM97UVQFrqyCw1po2EphMGqVWnCJgDadHJvxkdWP2pvgSj2fMCLLcV6UY5ivX6B+YhIkDYhRVknmfKWs3MvhLdevxGnxlRn4uAxK9fUYBej2EWVlK4uSSE0GKgYLb7imfqUIrum4hm5zLtxeg2dCyW0TtmHAE/Qyl/Hk/egZKhR9lCmCx3p04L2KDygaCRuGUDJlqnZl00DVqjs1DyT2CdpHKp5kfKDsdcckGwfy9+OgYXCL9ZEW0d8kpB/NXjfVSkEj5q4xjciY0ZGqmM7dZj9sKU2H1/6lOc2YpfBfMQuIZSt4+0PsnH2KDhUSonP82C5gzTeoymfApuo/pRLeB0JifEugFUxwwCJ+23K5/MK8KrJ0MGnrxWnNNBKXaF522oi4Ub+7Qp80qAL+s1MID+ef8lmeWCJoXiyALMUF8+cZPOAsCZQru2bhs3y/E/oz4g1UM9P3mmEgBoBqkRXAxX0WVnK3lk2lY0+6rYC09b63TXNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39850400004)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(478600001)(6512007)(6486002)(53546011)(966005)(31696002)(36756003)(86362001)(2616005)(26005)(2906002)(5660300002)(316002)(66946007)(66476007)(7416002)(6506007)(6666004)(66556008)(8936002)(8676002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C2jh5uLsJ9JKlGuDs2bWIpHmhnUWsQnbKuo8SZfTfHayiLJjveEY7kp61BQOhh+rigC4+jJQWDe8/F9NzmqgobMNUiHJ5yoIq4c93JnmBj9OCRckAaOOfH3XR0z2T3Sy7mYSl8g70ZfUQLb1H88/ETIfIRLlz3PoG8eIUIQYv3UZHdIiVznK7D4fxObodiuOczSRjJ4fGwC3BhkDbFnoE88zWBJZhrJYm5Qyy05qa5Th2buoLiv53dA5qZWzNxPLF0WBO454vSRs+pJb5LeKOHdt+QzzqsJHmOGeqL28V0ESCkSYmeTHZmhRiPlCPk7k5hCmFAW3wp27nYCAE7JWq76YfUGYOpLpWH/+JdYSnyVGQWte8ImB18CRngEbGRr1FBGzSdGHXcongT/letdTyjJqm7z/g+kjxXfaiSgJQK9jdm/wmNCLVmJEkL9y0Q4FS8CsfvOmsaMIpOuYjwNJmMw6545ClLAE8NweBMguke6a0/jzMU5s9nEsflfT35h8VVYEb2/7ZDAkSulCknUCj39MZHqESJ8IpuEYs6VGF1HOXWY/Niy8YMLedmYOicoaL9Am60+RI6BjepdAvwOuDTr/e/N6b8+c+7gBeQE4I8+CAs7J/h9KE/mxjfm5jvvirsbZMFe/9zabtviOHDpJCpJvSy/rK4cmOAPd1Kfa1KqQuVkMppK5eLVCh47Wqha3LNHxSxaUafpR4E2Oe6fcnl6IjVd8PS/S1bTiLmHct70S4bVR31SVwR76IyAYs0/KRi3izHKr2y/0SenLELb8lePOjieHRvvREZYCpG8M0alWaoolJDXv6xelfxNX3TYrXl73XxYaE3Mlz/n6ZncPDdsjVWYWsYNEPBhBpNAuPpcEcea6kEC2fLDzvWRATWHMWsitgFX9TsQ5dAeJ+HTC8cGxdNuqWTPUhxYhbhWXXm7ANbvSSaaYq4YqiHcKRiNc
 77hFG07+bfBPdmJ1tdED8C3ZRQMm6ZmTi/779CBvqNKqE8vkiSfGM9KJUG22hTj38AjZ4UxrUGkh/O6WovXCWFF0jgvPylk4sUNrmi5AXyVB+uF8Az4H6TIl0ML+ZyipiyWekKsH1VKe+2Jti8UrjvFqaqRRI0MUY8uOfN22Ok9tytWO2+FtorZH0eAXsYOp7y8noY5A/zJCLLOZHvtrri0teNeqpo80ewqaqtgk36XGn0wV9gZpSgEcHN9MAilhpePkyhGBdK+jboYm2qO3HWWN69bKdnsRPc9n6WdKKTRjoQP7eSnNoT/CsSTqsk9n3xJ3tNi49e2L06fD4syvfLJHk2KKVv1oP5FB9vmVpV4dk1D13J2Lg78iX3LnEjq6jsEU9DpEVqjQcQT6HAYBSldAqvlSSIfmAbGtpL+OAchyJ3wrAsb1hzznfOP9Oz58XhbLkwlnh2kf9z+7J7rP6oMxTPkSIp7sTH5u9nWXPQSuwmD7u/raQUAJIf33cISPzLiSFCaIu4epC6u6hULhJbNyUv156A2KwdCyd5Ky8h00SUjwAe0uOmHC+S4G6es0itQ5DW6AOnlwuFEDL2beY/Qe4g6esm/cWWDptCDbOwkxYMX7bi11fELKsOAqLc6b
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a886af82-ec2d-4f09-62f5-08dc2589bd11
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 14:01:10.2560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ng3mGz3T4Ts2yYBtcwa3iTtbcUiAsULBoxutftbmKtOjo/crVyQ6lWzdaQYXJbrpZRtuP9Yp0sFuZNWUuAEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2000
X-ALTERMIMEV2_out: done

Hi Greg,

On 03/02/2024 18:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.77-rc2 (eccceff25f82) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






