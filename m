Return-Path: <linux-kernel+bounces-158238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B378B1D63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6031C2291A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D016EB4C;
	Thu, 25 Apr 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="VW/rVdra";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="nLCleP3T"
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF9811F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035908; cv=fail; b=Tt6hsaMZDOQUc5aiquBZ8OVOxccZzAcxcqML5kcvV2i2aSR5rvtM9KJZlCbIi3/iR2xyWQbu5bkRkhGkI3RLf0ZJZnyQFHmXxg4cOgqoSDKaalSYDNQgmD0S8mXJCu7JjXPYAoSGiyR5JPESpNxS+WG99im6/X+VZFrXDMQjN0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035908; c=relaxed/simple;
	bh=P2OgT4oiGhqV/evenJNDxeiw54qSxD2m6pl0rkrHjEo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQfYSMmvQi95RFPIiSGVB8DT35IN0d2yeWw/oU5d+/lrI354mpqwvLRkKVfr3iCoWiYLPiThIZH/10ZmFpkAznAoOMQzDjQ1vC3lYIfRZlnOwcZ2Hh3K62zcoat0qrZ/tikhuIsYBTxqzVqldJNzjXLHN76cvcf0iTps9Xv0KTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=VW/rVdra; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=nLCleP3T reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx306.security-mail.net [127.0.0.1])
	by fx306.security-mail.net (Postfix) with ESMTP id 0A22335D245
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:03:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1714035789;
	bh=P2OgT4oiGhqV/evenJNDxeiw54qSxD2m6pl0rkrHjEo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VW/rVdraLtn22TEJstKHnyA/m2bWi1jfW82muj7CNlQoFkzGuh5Y6r4VNkzv8IhF/
	 pS++N/2yMX9WF0ieKECiAAVlNNLex3ep83lrSoQZxxqLuTmncYvO9XHuyRbEKZq+D5
	 BhkbGY0IwVafdsYF/9ASbU327DcAj/RaxqtsHulc=
Received: from fx306 (fx306.security-mail.net [127.0.0.1]) by
 fx306.security-mail.net (Postfix) with ESMTP id A831035CC0B; Thu, 25 Apr
 2024 11:03:08 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012010.outbound.protection.outlook.com
 [40.93.76.10]) by fx306.security-mail.net (Postfix) with ESMTPS id
 641EF35D0D9; Thu, 25 Apr 2024 11:03:07 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MRZP264MB2216.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 09:03:06 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7519.021; Thu, 25 Apr
 2024 09:03:06 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <28e.662a1c4b.5f698.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrYtFbNOypP/h0+BmBDl8OGY6MJlq8etEBWi8ctOkb/ia4DikdI7KWv+3qRVENNpSs0dx6H+ACaEohfemaQKwxAmYSdwM1hQclA/P5dtcrOaxlLB6t0TSWQRMkQ68KJw7buC09vQkyItKg+Ye+cOaZ4elE9b98JLBugwyTIXDYxyHJDPSB0vkTyWXaONK00iM7aPt4r+FWTx/R0hU1lsUIfVY9fYwgWrqbCC43ttnFsYbHNpQmjL4h9VumTTTWhmJxLshbkLKM7XKtzOd8P37yoNUsWhaTiTe1gunVOjYJJdj7QOiV75MhrVlV8CVncsF82MA5k0Y/HHS22xIBrKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op295gJUkAK2D6d7yJPOvxMNJZ3cn6ZtJ4dPv04StSc=;
 b=GKFcIdolcjfpmdHjCg73WNausD0gN192NKA3oYRPVqBxGnIIo1yLKqaIjaM7yyyFZdOyysGUxx2hqRk4dtP7FY5Tp9EUrZ6pz7tNDfJu4uKJjQc1gNqoBtGMAtxNYmIXP4eEIUuar9QZ11vKX1+TMzZxAmF8PPX3XVaY4RAopcpYPYsCM5Xq1Xy5ZUUwcukb/Ghk7k1FmhoPkiPrea0nlhEvUpQFf3OR9xGAiECjMjcL7yG+xIdlvobOPIWdguc6oT7fIoyY5Pv+L9FCdTbd4jug+5C5cF/KUlhbVkwzKDRC8ZnLu3+pH+c5Yb42Kega/Mrtx3CUSWC2oE98ranBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op295gJUkAK2D6d7yJPOvxMNJZ3cn6ZtJ4dPv04StSc=;
 b=nLCleP3TN2aMfYs3uE7pEi8/Ai+uys8Bmb3JlBow+AG81TshmLDLUehhwD1I4Y/RWzeoiXgT7HLAWrDPkbzL55FBO2Xdi6vRpXnDwZzOc/LM5N8BoJhDA9LbomJm1BFBHt6YRdczB9bHePQ7+K5gP0S/MVB+0Ze0tUsyYfEnFk7JwnZoFRVwIy5BaCTFBUM45O+qyDDit4JpkqUBBOE/lqLZ5Bi7m8yqSxLsdwlEcqajgj0hI5T6UZRkj/YIdY1NUdfIqaxN/3oYjGLPikK0PwDe17Zb2Qr0JhyTlWEMsxJ+sGhb8v/W98yFWCWNCrNQjdpk6tvlZh7X/yvNBcUgaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <54706eff-da72-43aa-a91f-e31f0fb972fe@kalrayinc.com>
Date: Thu, 25 Apr 2024 11:03:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213853.356988651@linuxfoundation.org>
Content-Language: fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0203.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::10) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MRZP264MB2216:EE_
X-MS-Office365-Filtering-Correlation-Id: 554aeafc-9111-4eef-4d85-08dc650684f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYHYJFztUCXQBf3xA9o6h3PyGZdfLw6YNkpt2yBS+trPKUlJISdvvG1rK00s4WV8GtmSaEUCctJ3dCzwmiRmlaBl4T0ItYgzoXHbrPO2Bng/hdp78TPNZ0xcRvL2MWPAFa9Knz7RZJU3UMTF0T43zQzi2PtCSeq3ClXIqdO5ScOcrsD8QnSDkW7DsbhftA69d33croCttwWYaTO/hCmyVcZLVCQZg1t7DzBbACDgsm0EP5QPsTU/cjJVQhIvyS7znsRmkyggDTGL7sK1MoG+HQa19LyRZ6BnxreKp9sNc20Z4GY2p0GR1diJw+0yq4sGgeRxTTrEToQqwSUXRU4Nu7NqN5zINwx6ulBIdqAm9gKAmvXhNmsnOO7mt+BGJnTECpBF/iJb4pIFAJFM49qoRPbGJgPZOHI6Ub6gLdIwXZMQ7DY19SyWo36/xgCIVOaE6J8QYFwastFOifAflu/OnTVawFlMwBD1Odlb5skaPsen/AFbOqqwg8XbEXIEP+S4pWNvzt57LqYdCWXbo6TjJuKj/NGnAo7D6klvXf1Rnu5gAgBHvEYiOH0KN2SvJfe0KMSJMyz8n7JsIdClQ1DuPxWg+DcheY9ID75r7CGas/eVM7BSCiGYy/tscj2PKzvwqo2E7q0h2snbGfgdxegcB8KAbIxLGU1GLkpJ5l7S0cZ6D4VSQz1plUxkBgMp7uaRd2Scu9bWTETH1lC+sY5xr5Zu6EV+1mIZ5bwsYPFRm7cMFhYIXgzhkxG7ukuDwBv/8mAa7ejSfnqsmtDS5jwcr4Psda6Gb7vKSkchPzeEReR10t9ev8NK1eQWbiQdEuBHXl4X+HLcpIEbetOv4r7Fo2XxRZwGYuuv7j3wLfigQlzL1nIOBA8yt6mQMDlqXGu2cySmHsUZmfANQOiNDY+qpapTQpiio6HOYKjcTTm4qNAINgGKICRpJaaA2gtlgr15AWp
 YE2LYO3mGRPhdpIKOpQq/ArfUXdS8UydR6qtWR/ST54sOiw3xb38QdhRVgdbZ/5fCby0Hsg+hY9yLEe7Ei77BeiuHpuK/W33NlnZrspAVALG1E/z05tcwjrqvry59eu19IIs6LBImoQhCQUjOs8XxBLeTnOI65iht6Ep+D6U5sIk+selNAkRd3rCkp9/f4TN8KMcT0KyYfybcazSWytaxOKRiD0iV+aoczbzqMr0gQQZS9gmsUmQlgKWiuj+DpezSuyxf8zlqNDrVbEAJlJg2ZK1Z0OssU1IITbrck9NpWs1Wg9dHKHpWOwW320Rh6/lT+eRFoZG058G4L12vHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2V2ys4e+nS+AVpGMK2COs/A4VHIemAp1E4wLj/K+iEwoOn/qFup/UOiuq0U5XxLT7ynlOh1jp0fo/Gg0PJUNPQ2Q/suOsJI5sVobZTlvhj16rd0NluIYhwRsgzrMs3+Uwcpp2YfleDCC+8o9yoHuQ9UNHXRc4pDsg2A4jOSZyGDn5olHpLakyGEnOnlRRe2JYB3VKDzJd1aurydCPjaNg040e6G/O2TaEifVEbSbgaaT82S83x7AfuIx9BiiqBYPtwXWwxl+6xScNHbBSEueC+TWzE24dJKfJGLo0hN5wc2im33JE6oS5TgV+SWGCjA1s/jOmiFBuuqf+oKFw3RQ0qdupLydIqwtCFe2RKN/iou6+L/RpxL09jyisxuH0SeRkpKWvJsX3FVLG3PhkULehtK4zRCVpveLqBAMEtX06lmGBwBo5N1C5AvZz/8zOLFc8z7pMQR8zaAS9FBUwL1olOIkv6+6u1ilSPgtcsDOxYqbJa24FvWCbeD2qzycY6la2TclchmNbB7+ozyrZ3wuAgNi8zxg53lGnVGBtVtLT2Xdj+G/Gw/aKYSXisf2eH/ZduXSvNp/+nsufWv/rksurFEqnYmPZW0AKI3IFg7V1O0qwM/R4qIg8K3QOc2Z97qDAXwqU+zj5B9BRk1/FbB1qj0nJQ2jHXOT/rewf5lOVi4HptqKItMvUA77P9ScR4KCeiTPven1sz3zdEQvBhCSp+UQdzTsxMnwhlbe5vPr6m69Ueb+chN1X7Tt0GwKs1a25KngsRMG0sA448YkxAJ3MFXXxLnf3szsHs2PkKrYMjkPayRJfqnspn9t+n3SBpVVSNqVBOu9QgPA6gjyHK2oLhWrsLpF9tQlcwVvHv2J2mwCVPiKE83hiekHmbZVuAjS36OWlLyBurLU1DcFZ1f+ECPy/i6wf35NPBSfVrD8PE6pp3DZNh9K32xAhZ94qI+m
 mmleeiZfaxtkT5iCKpM/6IctrGmgqC1mPsFzzWbHdvdQ+bbfCIbZYnZMQL6vRLAMNzBrMUX0ZAW51R2I6i6eUV3oSo+AQy3hIAEwYh3256J3w3Zm0tSGK7csDn3AkbZyxhWUT6yq7mHfWI9R6L4fjEjVruHtvjfJ0DgiBgXZDTDofhtS8mwihPdxYpUNvBu11KegG9/PzqjeF24jWuV9n70YBGLjkmNP7RmsVFR9XONwUNRhMy7UE4STmmXsv43b3vko1xp8UVmtIEXztgEZykZudGuERsymXNn5+9hx+osv8I1rAoRE0t19ptZbd1Fw2Wg7ndSslFpAcPzwlfEDrYv3JAufacru3Thvp4CJGOy4aT/xULnaqk71i5bc9/l+bGqaJCFet2i30/XwMd0ceaL1AjTjf2Z4pfME7ua65TLLYEy5Ful4LFudkOORLaizzpJxPkfxoHpw32WeNHhwN/6NFZ2uDvjPgnmP/aqVrTPAmwZJeoPtiHkloJoRVXRlMWe93I9OfqPLAK2t/CEiiziMTPH3KuK+SW6bdXVNQygpDdU7Upn22NYWgkN4O/ZiQ0BMV/Y3hG/FqdqBrbmWp9ahXWJdKAiDCCsSs3m+2OkZRbHCbG0PhODOkaRHL7Cy4tshcLue+X6D53rcwuUfSQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554aeafc-9111-4eef-4d85-08dc650684f8
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:03:06.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHNbeUESGQDv/efLHemOJDRniI4Ta8USQrrxfOUZQC0pW6Cp47bwbPhoC3H6epFzvDHq6UcjlJ/RTiBGf/ETIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2216
X-ALTERMIMEV2_out: done

Hi Greg,

Le 4/23/24 à 23:37, Greg Kroah-Hartman a écrit :
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

I tested 6.1.88-rc1 (cde450ef0f2f5) on Kalray kvx arch (not upstream 
yet) and everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on 
our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, 
PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng 
testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

-- 
Yann





