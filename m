Return-Path: <linux-kernel+bounces-30929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F1832625
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA7D1C22A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B77E1E535;
	Fri, 19 Jan 2024 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cINraWqb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bwxMVfTm"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA71E89A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655105; cv=fail; b=FZrMbB5ZRY0YlhzKXHXHKBK8SfLH2roDcf+SW209RlkhZr3RT7gGJh2KCZtqYrQRG1DGK0rpenEQJHh/kPEqNpNnLGzQ4O/r1+fZgfL3B9b2+8rURGrmrPvpqG6hKKNcBDfvpyC86/TjZUi31yRE9wD1HFLf/RLD4re3qINH1ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655105; c=relaxed/simple;
	bh=Ps889YvbYKLEBvlwatD18mbcUmmkvu+en5koGfiRmjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mnlqv+0HAv4NpebTELDLf+tZOWPGKoIkYFF7c35HKD0VXEf2+xN+7mPzKsAuvnTWbcGmJ0UO4L9AAy0EWmJAuCebwRYtJIPKfr/ImNof40aaMN9ZbwTnNYJF1bwxYAsQ3EYaNe8pBWfFZ6BF6S271EAkQPqc7rNYOZt7n5P2vto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cINraWqb; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bwxMVfTm reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id 68AC3AB267A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:59:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1705654765;
	bh=Ps889YvbYKLEBvlwatD18mbcUmmkvu+en5koGfiRmjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cINraWqbUU65/RDmZdZe79Jkdhli1xmZQhm11ny2pZ2ZBr4LU2ANxekxNS9tIvjlr
	 vCoglFqWH5mIcjvxsTnS86A2HFOqDzVxIy6DhuJ7cgs5UXNT5d8L/x94g4ewAuXzQQ
	 viV6/CWI4OKu67GN6vIYjIEQ671Sq801+bua/Ugg=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id 10E80AB2363; Fri, 19 Jan 2024 09:59:25 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx304.security-mail.net (Postfix) with ESMTPS id 37AB5AB3041; Fri, 19 Jan
 2024 09:59:24 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MRZP264MB1717.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 08:59:22 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 08:59:22 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <9aaf.65aa39ec.18f90.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmRbhN36L5gPY5mF2gGNnnlWblVAbc6WZmPi1j7uFKBGaCZKFLTz30Tw6Pw4WNaJLjOUPo6ecn+F+81lhqrYDuBao87YtOPNfEMbd5B4qmC572dLlXpMO4ydlYS3uxDp3CRu3NHjg50dAwgOE2SEaL4JcEhKdNTrmHGC5Xnmaj0xTeGTDmxpDXiJGZOop/H3Bs5oyJ1SAfu26Ktoqv9JrDzjiWnsfcW0KqAiZTOVRex0GQGY8J5PAuUCQYGR2EQ/F8QefEENJQe+QWz0Qa/ZJ+8z57ZGblZEH2NV4RlfCGf2nKwWNeZGKr/x2ocpnVYg6q107xQOnZFhNXrReAminA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRJGr761jbAaEFpKgUNYIQ8vOsHHBQMT55fvnNtACSQ=;
 b=YaVNpo8ABBoPeFRBBaVonq1/lsc0S+kG4cHwJnvOfiRbXUPeytXG6mvakd/sOVmqsKZLf0yEU6cLm2UXtFRF6uUMauln0zOCHY6LuQ5obVn7Fowi9aZS2/2rVkqvZKYTZ6ZQqxGsGJXNU04npFs/r2rWn6XrxUmPN1LNGUhw+457S0euqmHrSM14f/4ForHWSOGofU/C3c6QE13JRbUxVYse7hO4yK77jaJ5JZqW0/QNJ40N93tm7B3k10DuDYsdoxxU2LjODyoZsNUi9KhZwwTIxe35YG2JAfoZ4zLIMu9aM2ZRB21MYOrqQ0LWE7HIqadFj4YgMy9CjqC3WazF/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRJGr761jbAaEFpKgUNYIQ8vOsHHBQMT55fvnNtACSQ=;
 b=bwxMVfTmkApbhAS+7lr9lgaKm+sMJ8qh5FS9To321Sw/WYl/bXPcgndzOiQo62bYqTZMxiv9DYGslK0Eu2L5ce4VbbIogUa85XMqAvjJ+wM+T3qeE5pDx+vbv/kxebUzBUTrcYqSozyOcvL4Ecus0PWLLaQHcyMzK82ijpMlPU9HcnI4tp6cSs5gTeR2zDr0Qy8qFq7vTvts8GPr+n8Ypg19SDVlSntcifKU0KvST64yN+CftU+t3k2Of2yJLXdO99zyYMKjKnrhFEnTxub/VKECgfPV89vaLDFDXCR3l5oTfHrPsBnhYlDhMq4AhWLOCZcCNjkxCaimkAfs4NatZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <f98aad7d-ff1a-4607-b37b-c5ca9624f61b@kalrayinc.com>
Date: Fri, 19 Jan 2024 09:59:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240118104310.892180084@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0022.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::9) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MRZP264MB1717:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cdaaa2-3e07-4d2c-44ce-08dc18cce769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1eDqOA7Wo58iZvPpGqu8TArR+isqB9FQzgECGpWL9Y7yoQyDaqyhKG183lobYem1AmZ2tKt3z/G8j54QTue0ENzLaYLdq64QygJiuSprGm4QiqFuD14FWLX58IlFnZPj7votHzxxS4xXvH7nj7LEqXSgBUa7xj7a+7CO6AEm/8fa2uWiMDvLYq72mM8iCOETEwX4fHLFSzapM3lXdZ6E2oI4tldu30ql3W82tBW5ego45P+X8rCkqVlAxpL03huFFUULic0wTiqwfGducSlfIUjcWym+wN9EDZWMmlAT0oNPY7YXXcet2y5hEPYcSwCJQ4r9ez+0jxdj+s4IBSn5ofg62Cc/xvgZ9qe9AxpIbJ0i5ieJVvE5zGHOUFMUzuxGVB4e8qrpxZHBVs5VkptsaWdOiwsBLE+GMBsy3lLeYRdtpOpLNBtU8Co+BuP/tNHiI+nhn60W7LwXiXgYlZvxbNt46el1HLhqjh4NWWsc4dPuAUqN05G6m2D1jOya3QjlVQG5klXnDwcG4eKH9/T/w0dgn3ywDOFBFuTHxiGRQa+7UD0mzrTremQUIxQ1R2+jcn1eqW3sYT7aJ4iVmheyESjrPFKUMa9+aascH/gNJofNEhcsGdIZ6XWf1ps7xu9BUMs9IzWTj/RbfbY/t4L69g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(2906002)(7416002)(5660300002)(41300700001)(36756003)(6506007)(966005)(478600001)(86362001)(6486002)(2616005)(53546011)(6512007)(6666004)(8676002)(31696002)(316002)(8936002)(66556008)(66946007)(66476007)(4326008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c0Elw7ldT5zx0PuLnb0dNmqcuy+2pJKDLKSi2uO5zxmlfJ7X7/rFRYqkKKida3AQEijNPCF3pphIuM6H2oGhj2/etyv8RfhZY0p3gKGsJsvh70REYNvqtluqAdTb/d4R7ZHLnDfnaClpm4/u58r6yWmqKLYM/61TV251V266Z4UjmBzDkO8riQRr0g17myIXoqMommeN7PnMRsHVF3HQJwxf30ZOavrfgZLcwVLiNIXIAgPcFWXiXsMgftTLa7b2h9gAYVl0DvnR4838q9IwjyEwxLFqgYDC6BXbBXQcYib0EYP4FoT+Mr6hBFtWMn+xsyjSz14g8nK9QXVDfxpnDLjHIprVyzkQfb5sLs/Lc4gHeEuPqa4+FGWf1sjxazp4QntcxHt/VbFVhxUiivbrCsaX96FOntpnDwNFq14ksvYahJ0tNQ/Y93nq3YblZH44W0hZ1JcV2C9SENmUBJ2EJ4wVhu2b9GT7WQHzZ6Q6xGWfF3fBsGODtzAPaWmBEZvZBviQREU9YGsmVXhqnV14443lRM6TNP1LWWi/hPyZcHJ11qobYrVVCvWwDqyLjzK/9sEo+OkvgdUSWVlnUAugvEoPq0laE8ZRbFOA+qvcsJKgXCc5sZibZM2EITYlxwj23mWbjvT3HiiS0KC4pLNkyozjYEpRuhJC0T9GMc8Sl0lK0vNFuRug2AH0TOfL8hAYr2eMcB6huhTBX6tmRApH86LZeFyp8dj+faaavHgOh726B7v5/wDjjEiMB1oT/5Z72VT8UmWTqA8oU1QHEyrdYWYTvBquMy2AIBZ7esF44JHpSWNkNqw4cs0ILHn2B69o8xdN90XS7ELrwJwOVOI6j08MKUOTvs2ydrEofE/s1KnKc77UMrwVUtApGVuMiWkUFyLzi0p1AlTeo4/KUN+vVdi7tkTVP6T5Ba1zgk6dwKDr1tpdaxNGBb42VzNjvMH0
 Y+jGNiWHP9pEg5zCOD21zOpUq1UuMBsA2pmcRr1RQ+A45ix6lZIp0JF1EAX03LtPvW7vNCA8X53dxru9gzQ31FvoeCyArOrslD6HNf3qQ3tmIvXYvHRb9dxHxDBG0JNqAcQJ3H/Z0zR4BM5aFYPGJOb73N+pdnLTgX08D7DKXjiyE6naFEQi2GpAfafy1Xvt/gOINy9hFhKBjEHAarLTmJVioxNSBC5oW9uoan9+vqD0sor5Z29o/wbBoIpJ3ngIi3VzPYgX7s3RDdH9wMzVYgIhnj5iJWYandVlxuBa61yK7vUiDfqfVmjAuV9BHcMzdCIxbiwEUlINsmA4W2OwO/iNxig4LqAnYPdjytYGFI5BAY3/IJLUFUW1f7HUt2Y+DB9pxsny1wE4bfmjiFZO8YVp+943+E4c0ns21BKU+4bR5vnSaMDMkwMctrsbu7UIA9Q2Q6beJFvEknVhWoM71Aqkb6WWrfAjuXSZsaK330p2Ke3bn7StjKTwgtdAjKtGupa9j9Pdc7DmhUNmpmeFw1lpILPJkykfbcwPH0a1PoGDskxJnh0u9OAkozDKd6qz+uJdrgWPR1YDpQMhposuKWWDByEIksQ14k+VqAo25UZtPv09+et6xEnIcjHQtVt09hez35YX5M3+0J21YjJ7k3RO9q9KkecZrMFfb3rBqr6JdAZ4sv2FO0lWtoduA4O4zyKqOHFipF2x0vcRps2XeQ==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cdaaa2-3e07-4d2c-44ce-08dc18cce769
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 08:59:22.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNaLLM/X9tkzkcjsYl1a8NlQDmNyQx8Jtuu4swuTJU8KwgIA2bgljIUHB6tkatXX1CAErlp1ql6uXPO7J+BdtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1717
X-ALTERMIMEV2_out: done

Hi Greg,

On 18/01/2024 11:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.74 release.
> There are 100 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.74-rc1 (1ffea4b3e361) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200 and k200lp boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






