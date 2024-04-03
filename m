Return-Path: <linux-kernel+bounces-129239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471389677D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2311D1F24902
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96962A02;
	Wed,  3 Apr 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="J52q90kk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="H7VuWW3m"
Received: from smtpout37.security-mail.net (smtpout37.security-mail.net [85.31.212.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1C5D8F8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131506; cv=fail; b=GQx/pFBal1CSb2Ep3fsUQuCx+5DbqLz2AuVfSOXMDpZQzOBJo5BOFx8xBFH6/ZWJEPYgThQpKb8RhBWT8ysDw0EWJOClOoyg/95uSQZgi7ZxknxSELvz9R5zUWfkKYMUx+x8IuZ9stvdueJ5WhhCHppyyf/lfRkZ9dB0WfqhaQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131506; c=relaxed/simple;
	bh=hAggP2dES65cZkvZMNTRKparKSy1QGctnNvQBsr0N5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YMTkPpF513lCElMTysWdDak1LgOmLsdGCFONMaDtsBL1qi5kQapOLJ34SqEjObtc4Qze/B9/JdDQ4DWmOzg9JiLjnX3Kb05JlJUEW67y/1VrkhxYZzFS/IeNNIiM2pT/RrDdDYjMmSlvR1F7mBOBBZ3bwBQPxHTRcwbRh7qkoZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=J52q90kk; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=H7VuWW3m reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id A78FD931E0
	for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1712131328;
	bh=hAggP2dES65cZkvZMNTRKparKSy1QGctnNvQBsr0N5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J52q90kkxtFoFRw/M/0CGU07H2Pc0a7Z2lV+8cegxK8/yOQxWU9PXUoeJrC2vS8vd
	 q+UblkFiTboKGBhmEkVL81DcL0BynUxiWRC+WKBHhNP/Dojtflhy+Uu4cBwtoYllng
	 lx4EJNIH9o8AQOIPKr43CXdar4UntREJE7ykezPQ=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id 791B192F58; Wed, 03 Apr 2024 10:02:08 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010003.outbound.protection.outlook.com [40.93.69.3])
 by fx301.security-mail.net (Postfix) with ESMTPS id E01C193485; Wed, 03 Apr
 2024 10:02:07 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by MRZP264MB2858.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:02:06 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:02:06 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <10cdb.660d0cff.ded37.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhCaHE3bRjmfeZ4e+XcI9KCFmctXF/zNJ13OE6onIbyYtwI7OrFT/3NUn7iaLz/QR0b9j/v+K3zKZxO9a28616jjKgvht4zfXFfyjxj9m3uotayiJC/ypJQE2EH5l2IDMcTcBtvjJIofJGRUmSopZ8snL+6IivE+VWDHP+xMayZcGOBC9uY+dguCCUFiItqGZQpLd16kyBVdVZ2WFaUP4IapSy96FvbXN+E57iX32Tpu3RlUKiTbsi58pZ+QN6RuGoOAEx8SfrsoprUEALVOiewuWOINTz7hSNgVe+Kep9LsbfkcDNUht3obcyyAfh3ZQbGH5QJ961NxglnzMVUJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgztjVHU7EJTnXUi1jKikwX0Nk24XfdvAfWfnAykViM=;
 b=b7+y5+pMqWpJT2Ea3mu1PNFXi1C27io0aub+k2M6Dakpy8hBa96aTuBuOd1R0kW9w3epXDTJ6oxxZlXE0KDZQCziVbO5Ju0mKkAkQQurDPs08ISkovDKheb0MgV6XCk/pP0VywbSPhAqHqZHuw7KnNmIbqqIEanyO7cGl6BFH2t/fLVUGI4pZJ5GD7UYUjb62uP91OqAplZ8WQwn3yCggjr3n4roZEiN4ALuFpJq1++u78QUCMRYzPnAGb9uVTx3Hi6zLfUrUYGf7tAep91zSiD45pQDA2gwAQrAyWyis2I+ykrInrIKsmPM/qbBLHyvna564DIRQnHd0Un4MITm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgztjVHU7EJTnXUi1jKikwX0Nk24XfdvAfWfnAykViM=;
 b=H7VuWW3mrRhnm0k1EmlJZ1WPpyN8rKx5vKOrngGBaP1MEMtCRbeMron6MO6Z45ur0QRDWoxn8ACR5dOP6++feSNKjQ2ijJXthdWVGXNuuW+JdHXUJWeg+djCUktEbhWm+ExMRr1kRcyw4JeydjjqMISuNQXqgPvsgOaYCsKgNi1WFUQ8osqUyCk52v54bwpjX6B8dgR+OrbHJ3uAVe0UCt+f2ES04eQ1W8fAY/2ZIfutVFkuSiMPk1k3TUwFSmsEVWs3wkm41tnMs0ykHGoxUtq3WPqhGxR12OWFqQLSFHYL0UquIXZ0cHbOCepHGIEsCgh3C/8Xst+PS4N1Ym4Rxg==
Message-ID: <94f32c69-13b8-41cf-95e7-83a866e95c9d@kalrayinc.com>
Date: Wed, 3 Apr 2024 10:02:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152530.237785232@linuxfoundation.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0372.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::29) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|MRZP264MB2858:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9XzuXlIP+Jij/HaDhIXV+gOW7OgsydN7coOhlSLBey6VNwjUhOaYC9ucX251rKBqHiyeWbCJXFpw4ysPoVw2XWS810DKo13N6LwwBd3WhnhriZM9Gtfje8FjttWsytnT5uNJWLB1pdqVwkgGH+8V2eDHtZd99C3HSOureyFXrATfF0U0fcw9KEyt7DD+YadpASz/UCO8/6W1hVvvD/ychkuhdaUT6WQxFiiJWagfInrFNsLhRjJu3n3fXs818N5HANM0VkODUhExmj0C2B3woUNCEWN3jlR0m69RzVEDx6sWqhxFNbr3pR1/FjX5gvnqIX5IxIYIly0pdIT7KCo5E0lKPd+gs2ChIwGDFMbAmK+qx8Qb7jHYXHmrf5S/Oyru46kKPY6rhQ0MHu3xBwdrp0ukhNxy+//c/JrPrq1gMHgUTZtrXjbwI4KDkPsVvsoO7nGrJL5C0X7H/g5XIVies++xYF+ih2kZN3bUxNSienJqLGdDW/uvZc+Dm7YpV9qU6A7F/EkHp+4MTNMwWtSRCkEzwSWvCAJQ+CXt3D3lb6COyJbaH6/bY+AreAONiKE2rWexBzec9pH6V8Obxt9ugzVXhfbk6GmzQQTjthlt7m7KDQVgKcSDjQXfUrjFAq096McSQ+ZzQpbRU9wOFfa6IlxO2UY/M6j1aLiKXgmglJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wSk/sVoeCf10vZE9K8ls1vKpo8oNgkBi+x1IdAwnJn/6KLTlk28Hb+9V7t2X7IunE3Jgrf95Ecya8MeUTlOc67NGo5Qx01Bz3zg7WQCFn6WriITUoIk9RvQMiFm5eyMVriL9jzh1afhUhKnfSTK+9P5EAhU6GmWRpWMkduxUpfuBIeoSsNvz+JeVMXf+GKL4TWV3rQ7a+2lcLRlmZvOhNrWQD0HCgzpwQ8D1dGagevrqCvXcpmWGIj8b/lKesX8wPQ9yU17aZtZK+Rf4fsoiEoT+kH2YdudRlwY5LBtUMOOsUIuM0OY8txjtvP7pbJrh/CLKls9lLuoan0pP7nv/RiqrZP99Ck5qlbxyYQcEpBJ10w6SBgMw72ie8M5sYBH4vTd7lXf7acrLv6Ubi8aVq5f/FRAEP+fo1tuH/nkzuXiti1KFoXKlbjsbrXxV8YNPKeqTy8a2fLcPLagB3p1hObqzNiEcQYVFudgQk0HhNvOJ/SjSrIHTHOYSdIBRfLIG+Q5K6QuHzObc5Z9/LP9vGYEjmV75PZPU5NQ8cUBPWZabHLT61EnVRlJnk/OLFuSO3Py+I9uim1Z43CJp6jxMscJttoLENxOGaHFdneOp/qrFCTlLONc4FmJOcl6xyhfwuNatWXipGxPYeD2uAz37RtG0w1mezeT6mgXSkLILQobV4aV1ZSstj87utYH4UeJrCULgx5ZjxbkFE98zNtUD3JnMbWxyXJyZObpfYH7ZFRO/XiRzbg+xhblP6bMTYhE0c0Ey0oMR+uXJZkwf2kTcAQaA6s5cl8YIVYJcAGssY/BMZTKR/FdN0Ga/k6VS31mHtinSUs0yzz1QrUKfn53+jRSGgi8yU7/G87cEMYxl15LLA1k6+P0IrOzSsCPrVe2i9gO4E4D1lKARuEFG0NSbCq3dgrDF5Ps6xRHB/5Ca00nvgdbZyEFocy/m5LyVKL9R
 D1tssLEBXbTu0OXvysrFJ1fjgPQ8NxKCkAg/2GOl1JVg2Ki1zIFhkkHFiQ1FmSIysCa2qIENMU+5ivt7sEcfEVFaNBujwhCOZWe4+A1ZLACdXCRrIWvVcu7XyWFvTAQiCgeDydI7fqKEvHQLk0mtTMiTOipWx0jDe11yPjT3Y/xUCgdCMgYgaTnNkL2fPiVMsUUKhwKOkM13AOTvcHRbk7MldDldbQpgWpGFDVyZPdReNBtu/dn7aIGCjqtWK3I4qwykKJi4HZpVjjE9URB+SX5+1/quh2cgqmPLSmMnmUiE5dY7xRRZtGzvPNu6Meyw9miAXZIqbTFVGmas+BjJoLZD9VoY7eH+BwTjB3RG8Obs9QIMU0wjaGIEt3bNGS5vhgd2VGNCRjYGjIXsxTOW7z9bjGDve+6nKenQdhCsq0nx106bXGb69ii3hkh8hZ/AQtZdvptw36zXpuFhkuZ09tPrOtMvddIjWxkv4fACpVLS0WFggZ45eiLO7aQ/OBNOZkyToc3j7jD/L0PZuoC5t0AEdCOJ2MNa7gPuJ5FMzm1KVWOxbiSi4Ctul+XOrJ8scjJBzJaHPNX/TKQVxvuI400Xku60j6QR8MTjipqBMCvPm5EE24ju37oPfhgazwXjgdupnWVUqm5Z1thAAw9CF/W71YwlyjEA4RHFDR7tjbq1MrlA6Ey9OeJg3xSAMtus+6nV7dcN+GZt+YjOql0D1g==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffe9958-5eb5-4d28-bf2d-08dc53b45a7b
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:02:06.6128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3S4co+y5RFy09fsQTAFyqu3Oxs0Vf1P0l7sReo0JtMwtBkVrmVLAvmMme4FTzSUSnGvztJSFUbO1h749sEyVnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2858
X-ALTERMIMEV2_out: done

Hi Greg,

On 01/04/2024 17:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.84-rc1 (aa2042702765) on Kalray kvx arch (not upstream yet) and everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

-- 
Yann






