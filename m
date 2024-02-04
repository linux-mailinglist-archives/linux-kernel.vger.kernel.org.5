Return-Path: <linux-kernel+bounces-51562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37186848C85
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9671F220F4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D39418AF9;
	Sun,  4 Feb 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="EEB78dE2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oRBclVnn"
Received: from smtpout146.security-mail.net (smtpout146.security-mail.net [85.31.212.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F418EB1
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039607; cv=fail; b=QBTK/blOw8oPEHWvnoSSpdbtLSiAL2Ik+6r6UiP5lZNE+b71yqKX1wJamQr7v1RWxuaq/TjVCJbqmi20qrcEB+4r/8254QZk1MpoJ4vqQcT+MVO13s1b4m9CORIg3PxDv/L9bzXhUcRtQlcxkTnS3c2CaHX0O/jlvQKa/IF2qgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039607; c=relaxed/simple;
	bh=LZ8MVG7NFwIT2i+Ch/p5nEFS8qoVRWSIwq4OFoxLNic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NQd2TgVLjOGhoTnRvp5AtXuTlHuqPT7D0FonIESfuyvUkcWrAtNgHUC2Yi7Wo9PO0VeOwiTnpzu3IOdT6Bx88+sS2VUAwVJO2caPp/54UoIG1d3+YjLZrNKJGyV/8EEpDYUkJwb1zRnUqK8ikQ/Wst3PgB/3VJSoSiP5HIC1uQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=EEB78dE2; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=oRBclVnn reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 3D7AC3497AD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 10:34:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1707039271;
	bh=LZ8MVG7NFwIT2i+Ch/p5nEFS8qoVRWSIwq4OFoxLNic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EEB78dE2nb2/PqHS+eL2XhdiiudXOdjnDcG7rCHGj1UPJ57arVUZmRHzNiYjtPinH
	 luOY699/CU92sETfygHBo2AtOffx0nrfQ5K4Rh/cPnKA1NEUoIL6pIANtMkr3ZYN5t
	 vT++rGJQRXE1Ocw7USxmW2C4PZ0MqDQNT+1h23IA=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 1EF1B3497BF; Sun,  4 Feb
 2024 10:34:30 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0101.outbound.protection.outlook.com [104.47.25.101]) by
 fx601.security-mail.net (Postfix) with ESMTPS id CD0DA34A35D; Sun,  4 Feb
 2024 10:34:28 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MR1P264MB2817.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Sun, 4 Feb
 2024 09:34:27 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 09:34:27 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <45ef.65bf5a24.c8eb0.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKXNoOZZ8jiphrOpUhT6X10JkGcr1qOEtZU/vh2hatPZ50KDF5Y530pdqEyiMlIkrIk0rj5k6k9/IZt47MFj+BKGT8vQL/Mbnjr5RAd0d6kvFUA1wKwgyBktuIbaWNC8Fma3pvEcgRJN6cykN5Iy6P+EhweZkOlpUPGR63gh+CPeUncwkZJP4WuRU2PqxBkD3C+qNZ5TMs9pQAbG1u3S3lfy+pv6iZWVhEwnqH+9ZqGNfjeNcSLoWk00b3GHIgY7v070FgHS/8z+DKiv+2vQrZxagJoGh6XFXms00UcHzfRtqjT2vUOt4sg9JsEqOirZ9yyjz8EOkDECdNwudZ5cIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx2f7IlTCMT7CCew3II4pqqOOOGs8ZhxnIqDF8rHiZE=;
 b=TUOumusHezbnVUWPckr2opOUhPgRO2B5VLp+3KO7kE5iHB3dlKX3jbxFa1qTF50tf8X+0oKP6/imgYMWl9CmX9oP14FtSgN/jZbne4Uo9IVcArxvkmibLlihsjby3/zscGrg94fqBeFy4RFQ3fJ+fi+QUAQ08xttzt1aYp8K4v033Rauo20/q+4JrON6aZDxNFV1BP3GXu54BEG+TEZuJKUojpurXPTJVTSy+qM3I8OZVz5lYnPO54ylwhAbAiGEtS0XrLdOH1df2JJAyqZb+A0p40mQtng1PRt6I6tHhOzs7yyhc5tRChkbOIg/ZrEDyRmlGM8vF6jGKEXwsgO5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx2f7IlTCMT7CCew3II4pqqOOOGs8ZhxnIqDF8rHiZE=;
 b=oRBclVnnsK6Xj05rYMrpwwDP5gNARq9lR1QhQ0wSZvI+38jZTyBCwi6BMZdeL2+r4xwvPC0i3yVM9el58fd7twNJMVuBIHdogBnHB/RLwYWNnyPtmxEiZEcpyUeWb2e1Ev20sThwUrSRxqaTaBCVuWuqAZKC7vnXLt5oyPNZ0ZN80XFgtS5Rj3qc3VFUP2TXeHIkcvHElycM5B/ApXJNa01czx+jjL6Zq1YlqOf3IK4Ik+DkuA7bkGW37lr2GJalwpcmVvpTHMzKcggLZQmjQvhMd5v8najZV6GwyORDacg2BuiLUI2A9/cPC69iQeuiJVX8UEYHz7flifPPYDnHbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <a4ffccd2-e89e-4ec3-93bd-07411344d200@kalrayinc.com>
Date: Sun, 4 Feb 2024 10:34:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203035317.354186483@linuxfoundation.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::9) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MR1P264MB2817:EE_
X-MS-Office365-Filtering-Correlation-Id: 58523d48-2935-47e5-59a7-08dc256479be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mtmI6Clt1bj8m/pIqtEt7+Kj0+UFSk80gCIr2RZcl059F2eJQMAxgGIRUKcSbKmdYRtd/e0QWhubL9/3ijfmpMaPS2myfQsHFBys8imM85BhneLwmauUbs0qSVm8+nokVGKfA/YqJ/ao6LlC0jOiuYnTWyQS8bKy08WkyJTdoif4VxkttksCzcVNg+JB6a/QDYb6Dlk10SmsY6UqWIqbtGKy2A/1eTg4fJqBB+3S9SYNxu1xmWjcjdIFXy5O7PdpONTHh5TBwcsy6xv4FkLsJ00MInavocZMsT/wqJEgiEDwstq1KpIQnBCxsRB2WKnvuFk38hVLDft3hNRWprNIUNsSm2LahpDPpk6YgtAwfRR7O7o/HojCr3bv5HXtAIwaKwLQ8c4nlvLMV05cWAQYZ/p7Pfp0s74BewqzV7Bv119SNsTmFa5bZm+yDl5QxHsbknhN9Vvaf3eROfUazV/Xy8LPEh7ntCM/mPKVt5SqFOJl5nhTdqsm61ZHEQikNct3WIgyYlE5wPeqT4EkpYeVZxEBbxge1a53UUh/hqO9l7p6tpsKaR1QxPIgyZCKPqqW0PdmLalyBwkHDs1+m6XbBi+pq1ks7h9WRRw8lCvbNEcimKKMj3rGrH/YTthrK1RKYbWZPIJ/v2a2kzxK59H4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39850400004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(36756003)(6512007)(6666004)(53546011)(6506007)(31696002)(86362001)(38100700002)(41300700001)(478600001)(6486002)(966005)(4326008)(8936002)(8676002)(7416002)(31686004)(2906002)(5660300002)(316002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7/YxVARPwcLK0qzeeWs6p2wQQIr9mbNDDAkWl/UMS8r56upyUDw+pgfOgvmC678sw5K0+c5aLfeba373JJtcT9UIC1dGUu1E/OXGV+tz5YrqEYFx5yqe7J0QD5kapJNJFPB0LUl/j/Qm8p+1/ZCZ9pHg1Ld/x/lTNZ32/AVFOdMzQci+EnJfbGvqu3InX144WsqkA+Vq4XgWGTX0vGEmsIBea7P2+K0mD33VK6Fy8LwhpfJt/GzpgfIIyTflcjx1aqNrNY+Fa4dBtsiYPMM/5mMPA5LZcGRq+/ryw8R8BA05aYnt0CCRlGug9zc3ai09s6gOWSqkY8mZzIuA6ze+vRuVT92NgbC+WavOHS0d+wAogL/3LLPtq1Bc3Zy3+1IkNKZbGufrt/aGPO7sNvDyensciH/oaiaFSSbTrxHruoKflwlTHQEflB0IejQ8LA7dMu4/NsykRWmcnqwk6vFnX4MHSKLvD7fJwnWagBRqh2Q/s41UeGiTQGEqChPjjNH9VdMfVp0FLOwrKUE3ZYVzLwvBgYndWqNCmvwnvwtgm12f/wVn2avNMyE2SblarOUmwhQ5/yqZHS1asWkVTS3hKTJmbhKYFDVvrNBqn15aP/KHHOYCGzqnY55pwnzZ8h5nmoPlx9BD8Urgh6g+D2oaEfbaUOhtuA97T77C7XS7R2mQw+2innMgrGDiGTXSIu/pyS9lk1YUKcCBRNiNBnvc3NX+ZYFUMfDHrLCbaV56/o/QbY95LiDufnzBmSygX8uO/f8Q70W9ZK0kRRLlvyLsZaYPNdAKRgGDPHy4OByFXprrD+kq4ylNMRwRiCXCENODOZmlS65O7FnBfN5x/kHP6IJS1BNQFkhY9nZThR+Uc+gz6z+YQvre8d/C2YURDxdGRjkfotwnmdGmEs1bnO4kimlRdGSj7St/HUd3M0NZhxbxnChBAKVR9b1Q/EDIlPij
 YkRQHHkV45aIzc3nv91La1JschL+e2l351DjVd0ssTdHHyF+meu50o7znnpe9BuEATWW2geRaF1jtxqNjdyxQjs9KsaF3o9i/blC2m5w53d1XPuEuj8ha4WDHrNRlUPsDK5wPYeuJQf8SuGMFHUyPKa6I6dar3U+Snc48RU3ozU4cuUiKNwV2kr8HaITfCY2P+ovRegxepwIl51bvXWcJgjrsYaxbSXlOBZGb94cZ2/UZdPbmI026SQZmTRfESzQEWe6JvMKq3aRDmI3094pVlH+RemlPYFHA9whIVPDHWa2j3PCxgkE8rIb3ljPK52IsRzt8aN6JBLCU1oUMcnDm258lxnIwLckXcsLwSfbiAbQIJzIq1lSK9YFLkRMasfnZBp5hOQYDJXaIh72VpYQyNZo3iAXhm2IWncrC5NzgaJ5el1rhS/YZDQKviT+Y2nGFXnfgqqRQds2X1XFQfyNurZmDCHrQpWDfZpIt6j46FtgumPibJm9/N9OLduP0afqzIrluw1te3Xy3UqnrMnnNqbeoCAg6n9okLKhWFUdpRPHcOYyFk4UGKbWakEeXOyOkXEkZ/TdRBkC5lURZhNJSTB/Brsq+y+XsGs5Hg53kKX3LKNe40Z2SGtzsweEuHJZYznpHARL4GP1QE79Ot281Ju5IaxsfHFkDfmFIfqA0AVbyemrppjTrzKh1jueusnTM6fs5KNl7+5bfnv52/3fcA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58523d48-2935-47e5-59a7-08dc256479be
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 09:34:27.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kdp1XboeoDWxoGWp340z6Sdue5vME0fAIE8RTFIu8xY9hSbQLQZUDRDGHn3ni1PZgnwvxKUgl00VA24DRlz6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2817
X-ALTERMIMEV2_out: done

Hi Greg,

On 03/02/2024 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,

I tested 6.1.77-rc1 (4f7472958779) on Kalray kvx arch (not upstream yet), just to let you know everything works in our CI.

It ran on real hw (k200, k200lp and k300 boards), on qemu as well as on our internal instruction set simulator (ISS).

Tests were run on several interfaces/drivers (usb, qsfp ethernet, eMMC, PCIe endpoint+RC, SPI, remoteproc, uart, iommu). LTP and uClibc-ng testsuites are also run without any regression.

Everything looks fine to us.

Tested-by: Yann Sionneau <ysionneau@kalrayinc.com>

Thanks a lot!

-- 

Yann






