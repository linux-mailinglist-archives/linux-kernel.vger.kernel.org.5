Return-Path: <linux-kernel+bounces-37070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1F83AB01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D09B2ACD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C177F17;
	Wed, 24 Jan 2024 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="BD8+Pxkt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bVWFWhNw"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797977F11
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706103305; cv=fail; b=iHSElC1RwMe50+kVIWV47qXFCOxV7tI2WMo7QQiU5+13cCT+/aV9FcOG1/rhgi/orJb/XuaTsnbnFo6G+Kz0Wi3JXPwXHw8KeCpm5uTNpY/iaYwag7FLLYe5ezMobuRHiJPhAmwjX5S/JsAkoIaYrz9gHsbPorwLOkOmfQWUQTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706103305; c=relaxed/simple;
	bh=ZCqp2AwOUnunr9E1XFUGvlIjtGAUpyXvdLwz00qmVOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GHl0TyhOPUlell17r3F6/iKuYF25cPqjQmOsWKpYkHnCMSXuelKvw96PwNh4z6YKf3HLnYsH3CruHstireEfcEtRoDWb0DAv1Vy29FEVs7KSuueZ81vIOsJWw9g0c41l/P2y/RV0jRbwzc78hKM6GsmT/ZCjNCFmC8x8n5wQkVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=BD8+Pxkt; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bVWFWhNw reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 246DF3227DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1706103140;
	bh=ZCqp2AwOUnunr9E1XFUGvlIjtGAUpyXvdLwz00qmVOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BD8+PxktyJmh1cpXc4F0ypdQcBudUKeS45OXIsBltRDJ4GuGHcBUho/jzTqTF4oa3
	 EodHGfF5AqbcqnQYNUEhx/b73H99Dr3RBVZhNq5wfCcm9YkMvWoqm5ufpQWLuVoFBT
	 SKfxyKAuxG99aADW3J9F6THNm5D7KElneXd04fNQ=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 6BB4B32247C; Wed, 24 Jan
 2024 14:32:19 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01lp0100.outbound.protection.outlook.com [104.47.24.100]) by
 fx408.security-mail.net (Postfix) with ESMTPS id DA1B0322396; Wed, 24 Jan
 2024 14:32:18 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MRZP264MB2652.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:19::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 13:32:17 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:32:17 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <40f2.65b11162.d92f9.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB3chNVEOHroLgLqFnAMcAL8ZgcdPq0Vni+0Qzm0v2Vwwe+oFPT1gPlR6Y88NRLLzqA3MjHpkSjb2XdEkwW2MDNfU01A7LDSjxHIyfPQFP1IEnZVXAYIXt/cB+ZtRf4xXdXT+L18VQQHIVzDiUyCAUalhZ8n/pXTfIj4ygce5xv/FJsP5la9uuLnv3GS97so6998bDcms2wdBTYXamOEkncI/vLOeMezuoppxv2V8+nKFsnvJYSljV20VMXjQDw42IJJZXYz9CytNzWjj9WymKpn5SVPgC2E4eJKn1Opj9DKaEK67fidsF+wyKfC6LjQ3AtK9luxIr/00mAaIKfKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JChuz+W0P+7tIEgQ7NyG6geqeN34jb3GV0pyrqIwzu8=;
 b=b5PeAOkbPXYLy9dr63PG5tWrZUK+dlFVF2+gN1A+8IIvVCGsvmSl6iOKuLM9nD0QBdjxN3V3G4TZuIT5/0gy0xHZ6nasxhDfSlYokW9Ft0y+gCjuVHWgmU9y68cwy+PIW5o4eJnGdZnDq+jynaqotJ4aKWbF9BwJzhtZjq0yKmfaLOtspjA3x3KR6QU7r8a3zLlGVVhG+BlvRvM4my4ZWk7ToLlpX3U8S+zJvNYM0j829WTJK0RqS8XLu/p1EzhIA/dacJg5EDBrjqfMlt1Vq38eTTmktWd6ZMo+P3mopHmTtEx11EFZ6n2f7ONIbkWsOHMZItK9qz3eAo+q4iWObw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JChuz+W0P+7tIEgQ7NyG6geqeN34jb3GV0pyrqIwzu8=;
 b=bVWFWhNw5zwZ16OYzE6FBapCsKuEIq02mHjoXyaFFy8tRpAWddHQbVALPi3WyzrAUvtMDlv6WX6p6ZFnt8K2ZBtReK6UXwYkbD35/+eWrCL5mQn/LCUQuX3sUNgJw5T0Rc3nXtZMChVQ1F+yV47qBk6isAAyXgKfAQ6XgFGsW/JAUgtBxKBDTGt+nyx3xoPeP9jFYRT/pkZrkLjClIjSD4C7E7pTKnu2BEFsqFdnQDVKt6B94xtz+jJQiAsdQzB5D0vam37TOmaxzZUgiGXR81TYvMZ7784MUX50PU8X9eYvyxCMUod57Q5guyXHpIPWZu0vV85Oiv65sJS3u71Q8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <c2632d31-f805-487b-b7e4-d4416e55f19e@kalrayinc.com>
Date: Wed, 24 Jan 2024 14:32:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240123174510.372863442@linuxfoundation.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:237::24) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MRZP264MB2652:EE_
X-MS-Office365-Filtering-Correlation-Id: faf1c58c-41e2-4abf-9d94-08dc1ce0e1dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqYDXe3g1t1nzbGzoriNzgG/LChfuCb1kQvB0mr++AuajV/ThPFgsvubYXkrMVOwhxIbEDqS2pTdDlDnIgpm8aoQy4k9LwgUzfNJxp0wFZs4DlQPd6Lmt2u0yRUfwasjBaGs0XHfmgN+T3TzpASFjXrE5nNhqdYEsXBBDYh7On0xZnO7Yka9iN7DN2zgjs2T1YcqYsX4MeXYjX68HRnKNv+zWjJg/74ndtmdA9ONzYnsYpjFOg/L4qjbkoG6Mqnde038GnEcPNXlmDdk5oWihv6BQj1mavxpZD0+uLO2Wlq/kSMiKyWCd2AdERhAd6ER4VrXHXFYHA6tyeugoxrfhKniMmQ4xXZlFIq87iowXrt3afRSFiBaRQwkL+QsfoHUKHXytsHix6Q755dZ6+9+XnVHItoJlpXPfFWWf9m5AsRyJcK896EuS+AxOrbXLUEtiy2xs6s48WmPz8fENM7mir84+EIwB/wPRrTVPbUBCzR3uTWdgDTGf2Sslg4grUuPPWVW5x52QTuihhuzzvJ3jocuz0ns/7YBxu0YUZvGAb+ZhvGCXVkG0UUAMlL+yivWMPEfPKNt2LF5LaDJqsGp+b2j9ffsqlOV4OOJTNqa0VtLpjn83PgKlr0bAd5tFtNo20EktINz5OASLQyISoo8RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(6512007)(478600001)(31696002)(6486002)(966005)(41300700001)(6506007)(53546011)(8676002)(6666004)(5660300002)(7416002)(36756003)(4326008)(8936002)(2906002)(31686004)(38100700002)(66946007)(66476007)(66556008)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tdBglUqtDlZgOWp8J/S/RaF3HFq4PTFpFSUFciberSdp7I4/1d410oUFVnnx4hNM5wtSpYXgwJgMPRbq1BIFzKLA1PmPt41c76z1D8qI4RUfjIUgwEJ7y2SNzeOHh064PrfzFiTGVnOUSxRAKTWn+jvSj3vtJfzqa+daHUY4tv6yTuEYWTrvJDoBXJvquc6egApZfFmLpKRpmyMs+wn+lokp+vtJJVGVNqkyGaYj9kzYLk2JOfhwJkt2uD8yDYAGgGG8gxKhHNjHp7Mst0ww/1g+ffDVnTSzIwZzCyoR4VFcGDxZvCsriMof3XFfpamR6EQtkfBuC4W2Cp8mNm+/jnrOvVw1QeJh0/VcmA3Ke34VHYLt8uuLJc8sOtW+OJmORg/ZuYPeMaetRfVizvcK30CoblONEV96454KNUAo7O47ojdV+sRkF7Gh9vm0ujNfC6gRYcjnfGZ07KYDWutRVj2Sko0jUorBT36OJt+XtOAB8973VsptHMXUm2qrIfIIAHQcKk4JDRgnA/B7lARoYUw8x7g94OMHtlNEItjXgxsEY/uMrU14yiBOdGiqGZ10EZ4hoOhD0EAaq1fbp5OIIOsWL9n+2iv3TAvBBWFuoX6fV0fd/cTPUcqyKmXwQ39PIuWPbK3KjoDj3oyBXvIbgmUj5R/Pgik95kUTuvVjz/uAnVZme0rjxAEWVJfwk1uQ9rw8EXVT4NTPFuRHfOjUWtlwnlVcJ0YItU+CUibutLRrb1br4en6K57a1phA4V953PwjeW5GnvQUerGmcIx6D46OsKZ88nCRh0q7xhMwHITdFdoZVl77FN+nqXwhUA2GIEF4g4V1GVz0c3U1a2xxGlXd11LulJ/mcYI+VvfPjeopAMVIUYlxa/4rpifZOmi/8J+6sP8/xgoNXjz3fI/WczHkA4gu8dpFCsq82NJKsupK2H6fHoPcJgVHmX8/8H4B
 +zUcCKTtQQc7PeY9hnUfo9f8M4GGauUv+W7vEtTz3wJt1sBWXviKi9mS+HVjuWPd/K2kFyOpzfd3nEs/X22c4IalMW+62BdvJg+Hq2l/MWiOteDGmlKmxz2c0/0T1YdzdRTJ3UjczWYE/Uw/PG//VIaeldnrFryYmL5qF0lXXZHP9cgUQX93hKv6f4GDew2ZwF07DhvDYVwoz3XiqRDs5pYvV9DEK+ABHOvO0+edH1XoZO6lcJoxDOSh9HTuT809H3UlFR4JaoI3wHGdQc8CwG58dLQMYvhm7JVfCcfg0bN97InO3kF4IDORp1lw99KdyCrNmU4Mv2s+wFS9u5P0IpGITbf6oi0aqh+S9DEgxnNf8RRr3fF5K5k12DmIaZrv8dHYEjV0N9PBCUQ80MirB+fMRA7bCojN7v6HrkSMFzJsus+xNBwjrrcsIBRxxoJxSkuzmuopQZg8fy/o7xgkE8MVqK3+CfKm1dy8+lC8T6pXNJhrcxOKwkMSjj4TinpJ7Ju2kogIoa6LPX+COxo7yjVe97b0FvNxxXjtzBtoVd/YVi8dT8uEBedCzMrABA/J7wxuogShRGrbNFUYx9ickSOjQhU/v6CrE/QP1X189PMQhJ/pGO1LvXH0RGP500EdQwATs5G0r25g57Uqnp0+/g0tx0L7GLIF5VGNmBCQaPO7cvCN2Wur1tf+2XVkWfeM
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf1c58c-41e2-4abf-9d94-08dc1ce0e1dd
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:32:17.3965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrjayeKRBXnmoGxwGFBUaLcrYls+RhpdlYaQVsYPTclU3a3sY1XRMbgx++6KW/LM8GA3Tv6x5OOrsL+sClCmRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2652
X-ALTERMIMEV2_out: done

Hi Greg,

On 23/01/2024 18:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.75-rc2 (a7fd791e5c51) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200 and k200lp boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






