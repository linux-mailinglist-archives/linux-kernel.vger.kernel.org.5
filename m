Return-Path: <linux-kernel+bounces-74680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990AB85D7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52841281162
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2614D9F9;
	Wed, 21 Feb 2024 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bgTCUzn9"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2044.outbound.protection.outlook.com [40.92.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E54D58E;
	Wed, 21 Feb 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517093; cv=fail; b=rLvzkJOcpu64KJvtVDLTyih7I5SGCShE85lvcqcLzqNZAEQsD9Td83TDPoUR0FoLgw/iPpoYgihSKB4+7EePu6Da1/1gUtJOI5DJVu5bYsCMAW9FxngsV/3sTPDyP0LcrhsSxaoZqve9islMAKbyvdyZAteAo7k8iZB59LTG9VY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517093; c=relaxed/simple;
	bh=+OXVROfovaZ1YM05bxeGmzMbIfgc4dc3B9xOS44tqpI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVXmtY3vJh+aajJkgwT8clvmbJZm1FaZSu/SkbBq5aj4VEfcxLnGz0TrCQwjNDT0htzIleVeS0ewQd/kTFBmzXa08dxtROoO8VFIxBUFnFO4y+vkmVLvW7UejdrAcamhhRaJ5WbhtCpQ9XPRujP453KW18WOdM95tN4M6uwjUqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bgTCUzn9; arc=fail smtp.client-ip=40.92.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mox/WSRf0Vqy2AQVf+wkxBKxq6DKBnmNUVTV7KZTVFvsfChdR1eQKVf07U671Y/FrL6FU5RDEcOyFEMB3BUWrdhkp/GNsH0nFUep+iNOa4fAvvseHsKAuRr6aYC/mQNSzwyNiSYJzOsUEOKGJBJnjKsfJZbEmeoc+tgL62+XhDgnuXFhHHmmGUTpeNNXbCGRIrypOQGWP2v5akYbUwsOoY30dL9FdQQatUn4vIrwUn2Q4QO3UcnVH/VLWbM3Z90d7tfjfG889fmMopN465aBFiAynNpVRAMDZbhBG/YOqmDTTFCoggEb0cQG5eeyU9GnZBczaN5ndjW344U3D5ROYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+O0qDKFHwYAauWvigIs+9N8AaDr6RSZfIfR7+cu1YA=;
 b=UaLKnW1FpB4TeqxqrGFeQGBtr3s7Lwwep+FrHpF68rKrzpmtUr50aUrrsdGfqt3C+XEwzKT5Q80A0oipfrXymY9E6qph1F8quR9Z9pbL6uSE1V59X3zrO+9BpKJeZLO4St6bzJ0+MBSKhzlAm0zZUxfkNhFqBiT7I7iH2b2n+MUznzrOkxsXp4l2SSW+KLN2SaHp3B5FRBnfpFiNCjCoHh+Jar9K6fsha36hQx+ivNVTGubVNQk86SaokbWiu5KACIBD2LaO53JH6qvkgu6cEQ3FP07KdHdxiWVmRgQu/zRxf9mR2Zkm89ITdGqWsFg++TXGUTxqsVnZEqv0Gbk1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+O0qDKFHwYAauWvigIs+9N8AaDr6RSZfIfR7+cu1YA=;
 b=bgTCUzn92Bu1Be5/LYUQHKAhcBWPmObrh3RheNwW9QyY6KFkFjR+P6jyXRl2lGwm8ebg8af+YMrZUfz5reZWAkKFvGxx68fBjw2e8Qp57vnNtARfSpr95dnw8/hA/tjaTJ0vxrf5fEYbeHGi5HePwWFdD4va8+RnFrinCSmxnkG+u6XDeaFUfPQx1sInIPdywni1tTNiaJX6pBYyI3KkDD9YXZNtgxd3NwZFfaqpghXbxESoF61vqtIXKdhmTSCfa0uSM2P3tN5MZdujNo9x257QPemDdljKt0lFAGe7xaeQbA+b7DHBfRsSfjNbRYwlADlX40tTbTA0XHKFg/eHng==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB2090.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 12:04:44 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 12:04:43 +0000
Message-ID:
 <MA0P287MB28227AAD9D0E84EF39C8DBABFE572@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 21 Feb 2024 20:04:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
To: Philipp Zabel <p.zabel@pengutronix.de>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1706577450.git.unicorn_wang@outlook.com>
 <6aeef5bcc9ce007bdd3312f6b96ffb06655ae909.camel@pengutronix.de>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <6aeef5bcc9ce007bdd3312f6b96ffb06655ae909.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [orMDvOVkHA32lvfiom+TGLGBxDeBZk9R]
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <50532f60-240e-4d39-9cad-5a9fde5b84a5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB2090:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb58e51-ec01-472a-978d-08dc32d54a49
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ziweUDKR8nsDrhau5tJ3cSMpXSglXVtbh+hBmqiqMhGQErDt9AHPOS1465ZnvHVIaNyXeFc5EMMCiLxFF5uCWhZS0AkXeO11s1+X6qIoytKCQQCN0wODSkYyLJSOp04CV71nd0Tt2z+xu0e0HIw+jdAFWEZ+83+1TPAInRdY0NzlyFKmJ+CcDhmf8PYuxd0XCxdT77TuqTVJrcWwz53BRvmIPVhEumsSLvvAs5hm65AONeo0DjFP+svun7C8UtI0iNqSUhkpt7+q9zS0rPUtvqoJ6/2O6GuEaGK7Do07c7c25ZL5SnMYxW/0nsA7uF/gwC4LN6g/Gjwm+5+jZ2nKcHuux6MBgg60DR8hyKkRF+A5TB3ye7/y85p/58oFm9EJnXJGmbkF6TVmtGTzELw1EE2jnIdKVCyPjWaPeaZ/+fr556Z9lQAzeKA0kTPToxGPY62OCAWgAO8X03zB8hwrLj95gCPCD0qt6xgqhAnCZN92/eINnYMhXfNAsLKMoIQ2CqvI106hVqBXab1XQ7HTfKhr/ScN+wYfeIFHILiSNwlX81JiA/37YK4Yv+qkWUoknE4atXbScvtnKgTxi/minYGlGYEZlJHUhQtHr5bf4jA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHd3MFI2ZHFDUWhOWXEwVGQrZkdWWXg4c2FzTTdIeEkrSXhrdXp2dFRqMnB4?=
 =?utf-8?B?Q0ZrSzBqWThsbDhoT0xLck5vR1VuTytRTVhBQXU4YkFVN0VMMWtoY3lQNnk4?=
 =?utf-8?B?N2kwYnFuaU9MOGkvaXFqZEJwdXRoeXQ1ei9paitKVmFaQkcvd0dmK1QzNW80?=
 =?utf-8?B?cVQyVHJSeXRnUC9NUk5NVnFEVTRxZE51QS9kbVd2ZGNGUVRWZUxER0RSSHRN?=
 =?utf-8?B?SjNhMmxicnluNEhPUGlVbEowb2l5VTJlTmR4WkwweEFQQmZUN3hUK05Za014?=
 =?utf-8?B?M2t0R0N2RTFhUGppQmp6Q3IrVEZ4ZUIwRkQrNXUrNVlGRFFrcjB4MkNib3Fi?=
 =?utf-8?B?Ylp4ZFNjcFZKbG1KSW9NS1g0YlRzdWNhT2VSZFR1SjZEZEJzQ0x6RHBSRW5J?=
 =?utf-8?B?aFQzaERFVG5BTmYxZXJZT3krRGxGSk95dnY3aGljYnRaZm5EL05NVlB4V2lr?=
 =?utf-8?B?LzYyOXRJaU9QUlc5Y08ybFRyN09kM3JPNnFnV3dadng5S0RSYk10bzRwVWpH?=
 =?utf-8?B?dC8rQzJOZzJ5ZEZLSGRpSFpJUklCblBWeEpkYVg1STRwSjFwcERhNEpESXlD?=
 =?utf-8?B?Y01aUkNKbTlIK2o2RUtpUFY4SWI2RVRHcyttK3JQZTFpWFEreFlKUzBnSGhm?=
 =?utf-8?B?ajU0U0YwaXNOZUxVc3pZc3hTUzlJejZnSTFGb1lZQXBrN1pxV2VvRVd3a1hw?=
 =?utf-8?B?akwxL2lFek8xazVpVVlsSGZRQ3JXYkc0MVUvekVtN0QweWl4akNyM3AvYTNr?=
 =?utf-8?B?TnZIR3BveGhRbWI4bk8wS0hoOWVZTDVMdXdIRHZLYXZ3Uk9nTDU2c3B6aHQ5?=
 =?utf-8?B?ZTN2YmxKdk0vTk9BTXRZbnkxa1pmZjRhOFZSMTRaMzV1MzNtbnhyeFNDdUVO?=
 =?utf-8?B?c2NpWmRVQTYvazkyeGFWZ0hqZkVGNElpL21ybmNEOE1nNlF1b291NHhVc2F2?=
 =?utf-8?B?YzlOWkEzZ1JJUlROeExOS0h2TXJqOEZXTHBUYjdjTmNlL3g2Wmc2MG5GaUdq?=
 =?utf-8?B?L1V4OC9PZnJxSDB3WkwzUGNaZ215VmQwdTRZOElJZ0E4MTRLb2ordk5QNXZk?=
 =?utf-8?B?c0pjNGRLelV2ekk2YWxUUG5EMzFkS0d2NDkveXRvV2JwbU9jQTU2NElIWUJp?=
 =?utf-8?B?MjVPWS9pSTg4NzJZWHpRVTFKS0ZnQUE4MFBKbEtuYWJaYTdLK0t5NEo5RzBV?=
 =?utf-8?B?V1QweXFpYy9PVlgzK3lZNjgwV01RL2d6YlRtd2ZBUmxTdXBIWG5CT2w0NEow?=
 =?utf-8?B?aG1pVnhIYWtNTzBkQmZvTFpLSElPWDdPYXdSVDU2OFlxYjlMbDJsNTROS3pE?=
 =?utf-8?B?VUZmelNyUjlScERneFBVc0ZLQzgrUVpxcG1ydWwvYnkxSW5uSUpUejlOcHF3?=
 =?utf-8?B?eGU4QmRWTkxmK1RHK3YyR2dEblhXeFh0MFlybE42YzhPZjV5VTFTTExJaUdU?=
 =?utf-8?B?U1VlOTdCVFFhSDhCbHdxdC8zLzBoallTalI3b0pwMGwxY0J4YjdvNGFXRmZF?=
 =?utf-8?B?YXZnSi9TS2IvT1oycm9sQWExa1Q0YmF1TjkwWEFMaEFGd1pSVEJUSjBkVVQv?=
 =?utf-8?B?aC9ocmhSNnFRL05OSlE3M3pBRlRkcnMxRmFPUG81dmNYMldIaC93Qm9ZTlBh?=
 =?utf-8?B?ZDhQUkR0Mm05bWRhU2pIRXF0cm54ZDlrTkZZMVlDUkoyYXluZHpFZG9Va1lJ?=
 =?utf-8?Q?xquYEOhKRMOFp9h5jgoQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb58e51-ec01-472a-978d-08dc32d54a49
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 12:04:43.8000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2090


On 2024/2/21 19:14, Philipp Zabel wrote:
> On Tue, 30 Jan 2024 09:49:08 +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> This series adds reset controller support for Sophgo SG2042 using
>> reset-simple driver.
>>
>> Thanks,
>> Chen
>>
>> [...]
> Applied patches 1-2 to reset/next, thanks!
>
> [1/4] dt-bindings: reset: sophgo: support SG2042
>        https://git.pengutronix.de/cgit/pza/linux/commit/?id=41197eb5f993
> [2/4] reset: simple: add support for Sophgo SG2042
>        https://git.pengutronix.de/cgit/pza/linux/commit/?id=a6166a4da5e4
>
> regards
> Philipp
>
Thank you Philipp.

