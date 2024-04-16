Return-Path: <linux-kernel+bounces-146734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D8F8A6A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DE5282437
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6233C129E8A;
	Tue, 16 Apr 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="dDBlCKxT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="QZzg9Wyn"
Received: from smtpout42.security-mail.net (mxout.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276B129E64
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268806; cv=fail; b=rrTBOdnyG3hiJDrKmSc1DjQVDUDEiC897oUfFZNVVsBhWOupSzWrQ3PMVlJo70yuNnaBGPI+t6oTJPX1UR2U3dIwgIdwOO/b4H+OvZtHdCbOEUY8UMJ5zjF/6nMwQD2mQgAAO1QBrNFNa1bDCWM9Km2C1zE2x1/FvqJhJ0yb3+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268806; c=relaxed/simple;
	bh=StrGid2dBfOixfPa9P2MRP26amZHDOUthHHCkeBF848=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RBAQykolmPgUZsxSeB2l6hwDvKNB4QSfREnFeYAmvKVidwu+e2WkwvIs/HvzMMZP6/lFs75o8shwWe469c1T8a9/M1GYX3cXYFU2PRHFzN7NBLGtjhxduI6MiORiQKlEX2asX8Td6j5E3LfUdngdiU0FbszIX31QNCfxNAGrqoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=dDBlCKxT; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=QZzg9Wyn reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 183257C4738
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1713268555;
	bh=StrGid2dBfOixfPa9P2MRP26amZHDOUthHHCkeBF848=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dDBlCKxTdgPbKXREfaRG1d4FpITreAUPx7IfJPozghsnSU7r9dn7PPzJLjVFJko0k
	 uUBq4FYr4aUAFwzNRCJxH7eXDpHWvJuqaGoWJyneD84hT+r6xP+cXImjtSA1pq4tZL
	 IKp6Hvck1GKuwuRqzAaLMxnqzmlHYbFU/q+ampKk=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id E67997C43EA; Tue, 16 Apr 2024 13:55:54 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010000.outbound.protection.outlook.com [40.93.69.0])
 by fx302.security-mail.net (Postfix) with ESMTPS id 65D427C4375; Tue, 16 Apr
 2024 13:55:54 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PAZP264MB3245.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 11:55:51 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a%4]) with mapi id 15.20.7452.049; Tue, 16 Apr
 2024 11:55:51 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <eb52.661e674a.6493b.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW+bApLiskXP6XHLC5sRiTz85l+y9pxDh2ohMAYDEBvbBINIYY434o3tnOb7Wdl45iDDOe6x2WZLU5i+i6zyK+qeOw13ch46OAjqfaCNAbgPKeyoN3cRTZ37whh9QWmv4pW6eX9aD9tQi09+HgxZdN7tV2bDOOnBGpwQOHYq4uI4HU3sXBH/y6lTgtU9RGHcryk9PXs1BJ2TjWhFtnE0NceUtqVO5mDewtSGk/3bYu1l6prq3tj8w5J0PmezIxjOBqVN2gJIZS/qOoZWuIeu+8+EYXS/2Gb0OO1qL21/N5FuwZmI5iWJ7DE4k/F6/zfht8ehlueEQW5LCr0B+LgiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j35nNn33eL4zpEznZM9BCAUc3eIC8SYVU6BFRGeIAU=;
 b=LmPBR1bGWjoajgHgrjE6ShK7vNEqinVhtPNxJTS3Aii2tfo3mHOATB5Yh2IK+Y9/GeRtZRSfJTxlQ6hh7Y11v5ogBJZpE9eylZzkHl0IkX48HMezS18v+gc/S0vXLmVKRnS2yo/h6hrW4PNLNARh675QNvix5Nl8kpDPbnRiTpd9gWsT2EjNP453BaO0WjJxqB9Zx77EONSX3jU0prI14pqx6lJatkDMt+7kuJrt0O4f6KiEGNWqU81YNHtRLmWkSYp7Jt34dY6CAw+FjyZksSAL/5RFF+9BLgwqFFVjtFvz37h4Q3An6Bl+vdzAJCfVF2fdKcTpUuOCvmLvjeDupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j35nNn33eL4zpEznZM9BCAUc3eIC8SYVU6BFRGeIAU=;
 b=QZzg9WynEndJ8umZr6iWOvTrNp17XQ7q3i8Of5t1pBKVQJippXIvHFXFtjKbdszjAwaRYLElzBl8yr7I4zcHW0p1TRBnnSH+BXI9bubbRCmWY5kdPMUz7/ZjGhNDgCdpgOABSFC1HDcLMjj8x3BLP2rWYUN6k5ptDB/k7IevTLQAxTf/0i7rES5bB7XKgKZ5INOvWwV9TfvCAMijEVYISvjmzv6RFS2iqUf97XmzavaQ8dt+DGWgh54oTDrVNUe9ToU+r7eLtS12M+wldIYPOulrXGpVYkFpPfPu5d9hQnEWYDvXa3lEdKg86HRdFF2mC23X8MjXhveuurkLlu95vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <7ebb18ec-a7ac-4145-ab21-1d6d7f77234e@kalrayinc.com>
Date: Tue, 16 Apr 2024 13:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141946.165870434@linuxfoundation.org>
Content-Language: en-us
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0012.eurprd03.prod.outlook.com
 (2603:10a6:205:2::25) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PAZP264MB3245:EE_
X-MS-Office365-Filtering-Correlation-Id: faf4bdc8-fd2e-4b5e-b459-08dc5e0c2979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APa/BdBdGDGJpK+y0nytTD65YtqAkd0gS1xbdXP1N4KoRi1LTYP9RKc5HllRjxce/wn4ZT1xnJ2mD1fah5EE+cLH3cN5ldNOBOP3DAWkUNZ7HJrfW0+rBx4eTb9EoQYUOE/lGlcroG/br8uYMM16AoG+Z4SH99CYLHNaRi5acUjBFofjzL/pCHfkN5jUsdhmYSC3A4Z4gbMI+berS9s53qA8JRR0lQb9TsacU4OVbbLRbi0STsB4kkkViaWPKoUtWMR1UuLewJAlTLj2IkK+E/vHKsPmYBq3h+bqsr8SiDwlGOXD3rnh4aK7FTsiBlGMAHnzPlQVROH+kghO2Z8+B66E2ia9qfaBE+F5HXhdQ8BEiQuAEjYfINe0aGGW/HNgT+1gEl2YnfjUM90cVIC+RrjO9bAa1HvbrQ9jhCY59QTxzufGC3qZbLUg9Mq+P1sfG2VFaTImIaB00ge8HRHfvbzSovTYDYq0hZ2ZN9fs+AaRrw4uqEhwaWiFM3TvqM/36N6YleWJG41y3L7bk2f1fUtFZBr1RWfw30Ank3Ru+D7Vy3YKMZd6dMf+KxNh0a/HEP9UA3b6DWtzFlrl/PQuBTozdLMCWwWHyTdRLJ305iNsLuKOOqKiXqLG/oQOIVpxOZmaoX/yBYNff5ul10CknlcBjgPkVtUZpENxduCH4S4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E1THdzdxoKb/U9uGh+6DBLrnx1x8dDiBsSnprSGROhkGWwBqQA67pY56fTdSxFuS/kp0UcfWfBNs+WdjmZ21rh8WwMJvNGGKIEtwkpFK8o6WK9mUI1HLsVf8vctgSQe+W7CMCSGjsvn1dEWGYUi0VdGQmoo1jtbzNFBNA1yiI/rtrbFfxrL5zMTpMUnqESh5PjJZThWgZ/KMd3ugD0GTcPxw6tRltJMR3OD5RLLYY0n//mY5PaTWonIM71lEwYW/667fK9swnv38WDjCLEV4wHx9BZ/rz2pmu7o2RGI+Jx01sBEHJ3d8IpiLWjP5+QJfkqtQDvWPraG4soQVl8zhG3D3oIlZW3exRaRWkk1eYQ/csMXuoF8nQTafHH+ehpQ/CdPS9EjQpZJFzzCi92qNnYzsfSAGaWadq3fMaesB4aEil8M52X5rm51Ps9PyRKB2smQaw+Oskdq8nHhqNw6Y6GKMvjYpaWBJYPn6UdEOUKQPEHMDsD4HzZkKDt9pPgClhfdobeVrxafA1W/Gw6VHtHrI1H6Gt37Z6DfMxDkDGmvR4l3Z9rCmpoS9LZLOeCQwQxc4kD3I+pbxlRpFvMXjHQqxaEAPz7bptOQNDD40bs8YnJuQSmEgV9jA+pCH7qZWxbEtUV9gZZwXEpKd0sXoa13dejSIh+8z9Vc8DX3XWVKuQ5de5/k2BYz1lc/u6r55vIZwI73/yViWH14z2zJVYZTf/MvLv3YaLz1DZQRNBHVnqp09uFRy0OfLO1NteIIr5ycVUuKamuk1w3ygMgOJzFmkCr+1liIYi+v/1zyqk2aYn2tS5AerUHQEFm2Udt4ln6W9C9IKw9n3nn9beH5zqCmDNipqjBWt+MeawWADBAy35eMWYf2GOW8NvJ8+0nERs+yGG5cUnKjYm1h3fXi7G1YYAUSpDf4xVgZ/RR4hJHutdN2s1+/06TK+jMpuyPUf
 fPSRuj8gEV5qo71wWL84mEVwlyYRLFUOs3/nHrK26pYt+ihvwr5YMJXDSI3szBMGIxEUJ4lEoiJ3//eXy5RVEWINgBU7zG260f2og+U+vUf4uCEoVa52LJqxzWthGVnZ979MwiwjovvKGR1KZJhbXnF5rZRO/Zajqf64HseNVkN9t3mrTpwd/wkzBEW1tjKhAWeMUIWIOrByHCbndoevB4E9PLbzzD1h9hxhry92h2dVJHmznEJSzvermRxIxV3oRJi0VXxtx0YpWJCrS20wDvlrGh74mjZrbf3jtsd3C57Rclgje70GURENXWWlc3Xp35Geg03ojcU5aiUHJoQoMjN8DHcghF8A926pzXtz0x8UvI8rYYP28Iw9dWOXpuMSzwlSrFB7ufS6AZoqg80zBFndv9li/GNrkiEe2WNgFZarsSOznb+/Fj3NvxilYrcCml6KiPNLHD+lHXMRNIX7m4BpLnvRq3rPxrqiTRQf0g3AZ341u7k/l2oY2mQ/Pv30X50ERkGnhA2ikrcYdg9gAOJ4g1e9FEEA9jaJcNiF385PZo2N1UDO6XNWRmi22ilPugkUKiL/vBuZvaIMGgWQo/QtIRanZOLP7AcSZQZMsTU47cn58Bvw/BzYdubj+4Io/uGLaj4H8wo5BSDpQAJPfA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf4bdc8-fd2e-4b5e-b459-08dc5e0c2979
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 11:55:51.2331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K25ckVWwF9hNMBKZNkTcXSgEWx9ZqVAxa7asHu6/4BUJ3OXDbAqXwBDJg3iABvJpDG+n5G8SG+KLxHze+Z9pfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3245
X-ALTERMIMEV2_out: done

Hi Greg,

On 4/15/24 16:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

I tested 6.1.87-rc1 (6745a5f2c806) on Kalray kvx arch (not upstream yet) and everything looks good!

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau<ysionneau@kalrayinc.com>

-- 
Yann






