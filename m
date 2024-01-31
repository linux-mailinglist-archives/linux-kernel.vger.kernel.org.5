Return-Path: <linux-kernel+bounces-46115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6E6843A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7598228ECDE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD06BB2E;
	Wed, 31 Jan 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Fu3X6kxZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="UIHvQvvn"
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639166A02F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692355; cv=fail; b=Sbz3S37iessIO6QGDlpAa6pDwlt1cvjM8uh/SSX/n4kYuj5fsHcD0pLBTE+ASLQeDru/ERKEO8f2cpP6nChoCNN02oEHLa9wg3+LvrxcCCKlvPWSr91GUKEzJJO6mMEwDSjUDLU8l6G+pb+Pqju8bFtwy9gYTObv+6sgJnFbOsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692355; c=relaxed/simple;
	bh=cgpiD5LUnpSimtut5bfdqlD64XFCMCGaCKENZe/HNQg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=irhISGmgkxe3rTGMH70jngQjY+p85HZ44W7pp55NEADXa/dUXDsyq9kwoks1ECi4VH/0RC3uHHABXyrReF5M2EoI2+1UQuosU9kYLWkPS0fTcfbRClSALjYfm3bf9eu7BRimAYf5g3OnGRtIg6Ywur+EIOLB0OxrCV5ry8GvKoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Fu3X6kxZ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=UIHvQvvn reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 6F6DE30FA30
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:12:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1706692344;
	bh=cgpiD5LUnpSimtut5bfdqlD64XFCMCGaCKENZe/HNQg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fu3X6kxZnEO0uQfe2HfRXQIUV4tsEWmOsrK4uKGCd8tBcp6Wh/Llf7hIu/9OYR937
	 uVfDfyMI0bqc2CFVTfGdZWVGpnCZEzI1iIwyGeKZsghtxYzeGvx49XWFAstg1n4MSC
	 G+3xLMVouHyetKzGWv3ND7uXx/weSxXUS/Ynxskc=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 0777A30F7DF; Wed, 31 Jan
 2024 10:12:24 +0100 (CET)
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
 (mail-pr2fra01on0101.outbound.protection.outlook.com [104.47.24.101]) by
 fx305.security-mail.net (Postfix) with ESMTPS id 3722630F35D; Wed, 31 Jan
 2024 10:12:22 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by PR1P264MB2222.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 09:12:21 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 09:12:20 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <3944.65ba0ef6.34ab8.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6dj8uwcCqadrpg74ucO+HSgOhDRy4jus3mI1OR0+KfmnuwxAAKqrvFALjIBhpzMPlV9sDY+NasTRYlsqL1+CnweslOhEO8Hz1viLKRQ5MN3ZkYWuwdnPWQaNVpE8is/P0dlYG5BdNRc4JxupNC+NUB8jzETye3CziXRLZBULOX1xiH54oVgSURXdZDVpnhH3Lv8hYtO2l3cioEVbqFbRknJSwu36MjAAU65LuivDQcAM1NTXEmkzwY1WAIWLb2j6j/QeDZdWcMIQclNZFgAS9z/VMIAbKzy89qGstiHekyH2qVDxZFqVXU0K4C+HjvhuCuK0ais2Eo3cFqRP9KrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teKgS69G/Bdmw9kTGk2Qtl+y8JLtYvv7ECoXX5E4YFU=;
 b=QfucHcKhrdJjjinu7o+oH08MoC2Y5E5IEfBqNjoNDL4cfgsDxUz7+jn05nGUoILFEE4fjesAjFx4h51TFxRnluZSMXrBX5PDIV8b4QnRbh3Z/8BYU9A7OblJDlwGuR5fmHvyEoF7b3/rX0Fm9NMAwdyCd4Xzogz5kUEnODClvZjN7PpZ09+7yo8AilQZd5FhJbFdfeCVHkJbZZISayzMYozTFNN6O7gv6MuUjy3Pq2YI7a+po+TRAHfder3/WYQvqLWzJP2MHd+JLOjAgZBkvFtBd7ASF3j9qy3WFbzdhCTj3HPbrAw5a8E5BvHVIHFgB8H/xCI1k3GrW8kPLlLgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teKgS69G/Bdmw9kTGk2Qtl+y8JLtYvv7ECoXX5E4YFU=;
 b=UIHvQvvntnBtjQvbIUTx0SzWpk3i8HL+NyyntmqvYk5invX1mvn2EkhdbkKzEvdbUrIlluz5Nzz5dwEM9Nvm2ob85ioYiwCClJuIfOWOVC6UHF6xCxHUE3cUQcsJ87yCyAp9wGyqoLIHwbPXbFVAeZIwIUOrvwuy/rokw6v3oRDxBnprGDn5ydXH6p64Pae8shB24bL6HZioWemUlPyNdDzIxzXPnVPWQT2LvOoyN77t1Wq9Zi+/j1a8UgjM1H853e0cGl1AForO7gpqp/O4E0I01dcE2MH5zhuHiGldyD3Rc+Y609AN08IHfsNy1uL8sHS/NTMnNjHERuc3AACPVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <c740e45a-495f-447c-98c9-ed984098f36a@kalrayinc.com>
Date: Wed, 31 Jan 2024 10:12:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/185] 6.1.76-rc1 review
Content-Language: en-us, fr
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240129165958.589924174@linuxfoundation.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240129165958.589924174@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::24) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|PR1P264MB2222:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ce32ed-8cda-40c1-0bf5-08dc223cba47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzZhYhAvpz85E/iDY0u2GXuXN9xXuJw5FwxIvJBQnoTeozZyNO6bsCh6NbOb9rWB7g2PsNOCj9f07Nfh6Zlj1HppTav3IU8haobAJNXRXxkk1Xfhsb3Ztos2Q1+vZ27fyVW15bw4D1b9JM2m9b3U0c2NAWyg/H404tACqsW6ZACRgS4nOvRQqd3OXfuICyNHP50Ld1hmBM2W1v9PS/xGNuuSf8I+eVI6iBH0g7RhX5ZIQVFVfUROgilf2JIvvFjIdB5VhqibSkWV1ZK5eTuGbIisuW/V4OfMPDUQ8gWGPjZ/GAuRE5wMshaB7vcZ/RTVmBqf8reHd9fZGeqVz1LA+1hV3vZbF/JJuMFC5Je57QlfABWlEJ6gJZyuRpHANr9uhjUXQfiHGBA6aGlNdxZE89Zs9+ETCNpe4qjmsiDZiONpk+F/oa1cM9ql1Rf5GHLVtoTeo1/GF4MBZT4dACTyqpRe/bK3dwt7k3qOHmJeEV0NZ4mub2F63/Sf8c4VsntXzehehPFh8zeiN3Ag5C++GlCrAbXJJH0h44OsOgMlYu2XFy3lWskT1vp7TBx0dMwTa0fl1LCqqpGzgGrP0hJaG69qXwvWGRH7WRX2s7FKXgHpQtIFYjpNpZbKVVpUy6Cz7znwGc0zu7zgB9BKxH/CxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(2616005)(41300700001)(966005)(316002)(66476007)(66556008)(36756003)(6512007)(478600001)(53546011)(6506007)(6486002)(38100700002)(66946007)(31696002)(8936002)(5660300002)(7416002)(2906002)(86362001)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sx/UoTINuc4h7SdlRTFcGd/8f/kjcGeEJ0hf2MPoOYF4BQCWXJlFWrNl8alASMAARGknuAj+mGEBgwpoCZrMLI208b019DWxaNMvUEcF6HEE5aSweEy1nnGV+8Vkpf6nyA72ZjFvBX2VOA8J81mshc4DyABROvQWfDpzjJqcVgPIb/I58z8CwVHDglt+57Ivsc4TOSlhZUdzjROy4usqKhVrGn2dH0RZomg5L1Dwnot/flXFoInmrVzFabNk2g89GmNrcEj76PybTdg6og2DOGtaBPAmOX3rDe0BfCrZFXoximRc14e6H1nZ7567QDnJ6/okHAp8uRLeLZSB6E+pAHAlcKufbSSBMQvwXOmH9Ib6OYwraD4UMPOHvg7+smgZ21HfJqOHzCimakM1HUttVhSqlpOElhQMecrpoY8Qiy4QZaZnosfWWLCB/NsX4uECynrD3Uvna5dUpH+e6vOYf2p+XOcdevPmMzd5NwDj2PtkiEUWm7a7052DglZIJDDMXvn5OZX57yXi5AOnfymwr38Qjz8gaX/hsyD3CdDMx6dj2KyvXzo05RDfpwyHj3VYXeYTFBnJ5lKzqoZSWaYgew6s/AdQpFo3jkLgJmd2vBJ7H0jGPrY5/Ssnm5XCFd7arkdzHiEMR6kckpX8iH4JYjhocSu9t6pUEAfkW3TMFtvTBIMsjZwgMr5a9l+tXR2wegyVHprP8qLqJAZn+FhdvM2GvA6kN2LEb64hf3yLDfghgcXMJOQ7A3PkulADXMc41PnJzM5HnQ8hUznIPFLQa5q+MHotKky6rQd2BTH6tjRVnsVzJplyaIoQk4MuJNJVuhxL+HL6PT+jHxBrWh8QiZBNitPyVRgmPoMSMygLxiMfFsnkp6E5CNiLAJhEMUlwbp5R5yjj7ygLU5hLuVJNukdxq6WlDf8DFsR2F2dgF4RdtSlpa1w1WzCtBuZK90/E
 zLzVJ/Mw9b8DvAM+P+fIswtBR50KUQIyCR42J70x0tSpxw5GY4mugikUf1wwcTrC7jQD8DRkZm3OHuApb2cZO/bt07zg8/FyBEngNuOV9O7/nj+829NGMRG1lbv1MvQxyjK+vYr5DY9eRiPvcqtjexEdi4GvKGMA0PzkWen6026MoTiPkJu0eEKweatU43DC9tZlTBNFqhq1BwY1DIAfCJJaimQEAX00/pcvrPZLYbrSQod+sh7wacXykGUrFPCzNLFbLgY53UPHH871GB9ZJJruRupP8lFjUDw6JNp1ruZG2rOSVUzrDAuHHB4N9wESo9YbcEqnhaEvwZtBibn/noQ5TdxsUenS4NtaRT6xybWYNRmXazqPt7oo2WhYZqGnYVkXKSNV8odDP9wsk2GEQHRhK67GRTiAS37Eye2UJELYbUzwz0qlm31fGCZXDiPudoz9N8IgStxgD0404RCvJtusodLmgAdpqOQAGjiSHCatgsI+GtA1xDY6x/1UHkWdetq09Q3n9B0Hz7/JLPE6vLPxALOUbnLYnUfdzCYHGwTVsBupzTtMZpKug/eG1D/6cPZevhX0LoenyS9Xr8p71pF/wm95vcwEYw1WNSCUvduDOQR5GSEMBaG+DMMXtMpxbkgGnkOoLkFvMEJRTjcDaT1pdzoar4UXDmqeKOU0dHPzgm8kHnFLq0CVBXwmKJuz
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ce32ed-8cda-40c1-0bf5-08dc223cba47
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:12:20.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/CtJLj8+JqF4/BC9p87bnmMzjl1gdkn9XtubXzjF0BnvkhOVGDr/Exh+qYRwPzyav1ZAaPrQBJX+iz3Dqj8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2222
X-ALTERMIMEV2_out: done

Hi Greg,

On 29/01/2024 18:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.76-rc1 (1f00d9fd963e) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






