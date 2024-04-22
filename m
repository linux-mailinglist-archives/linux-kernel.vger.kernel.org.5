Return-Path: <linux-kernel+bounces-152664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F78AC26C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9831C20915
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA717C8;
	Mon, 22 Apr 2024 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eq2uVjLl"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2028.outbound.protection.outlook.com [40.92.42.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F225E81E;
	Mon, 22 Apr 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713745884; cv=fail; b=QF1h5Vayt5BP34FkXM1uLV1Iu8XZdqAXptxL8p7EacyNIfmscky99RAWyjQfBgrutggyGFHBYnCBD9dY0Gpeh3JR07boYr0T/pDogWVVci4OWhdkOGIg+NM25muoiliVWO9MkBs+ODM8YZLjbAdPoHmBY9/e7ROVpBEcfo6AG1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713745884; c=relaxed/simple;
	bh=Y8u64ortopvaBGepSVmWocUjhzy6+9apJo0ZB4hoxkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shNNKD47p84igNQccOJTO5K5uTh03WN3GP15IQk3JtoNSHT8INjdujUosUntYmUqOf7ExrvTLO9GIwfO3OjYdfIP6eaiudoBt32FnxsaulW0ecSH8AOlMIFWPNTJmB7y11yT6P9vltSyDMgX705o+Mb0cv2oVZDeIWtpnIoNNWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eq2uVjLl; arc=fail smtp.client-ip=40.92.42.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q36mW1YPwwI4VIo5HtB7bJ9jOqwiiZg6l/PjwZUAEF3IwDS5JG+aaVdnWt5Mc7SFJrelG6KEb51XjRLzt52QKh2N/TX4QLyBXMc+HrmMxQoWlCcwKZyoEXLNlDqR6Wx3r/eHTY+KxhKjabcHSU4eyyOa5M15GB1YoAxrwpffn0Lk3px5XGxaKFXJ41fGQyTO3moN6lmhjBLJuVeu7rkO+QGjVIgO2Ka6bWCHWRw86Mb66W6NKtvmXQVXKnb0iok/UhGtZT3laQT0+YrlMtk41cbxEX+PMWujkvS1p8Uyrha8q6allKvjFhfSpl20ajKBWuXDo9jWp43eBKVSI4hI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0xRZ8BrmlGVbFeid+npKTTGEYGC/q84JSmTeCULW4o=;
 b=R+1zTv2qEJ/mVo0NYJ2xg1YNlsv07E8P5bBEHXAzSHfOjTsDOWpdqysxwm2wQB+eOc5lc8O0dnHVsY492y2RRSF8AiDWRR3GIC2hF2P5LBwfgnDB3LB7WDQSQmuEVw4NVyKZQODcVMB8Rjzl5CzL0B/MCz8dj9Sh75JnqAbohSuehgSqDpKsSI7JcyScc2gEQQuNH0UrZJvZ1lSGDup4IxKe1/PGnfw4WVPXbj9lfYgkw2DGO7UJ+eBYCNfFyN/v6sRWYaQDJETobJeoKMuwQnuGE1bBIrMe5Hz96Klk4LQn9jRcZNAJP8H+cGK4Q+5PeBENoCCpYU5NdjE0NKQtVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0xRZ8BrmlGVbFeid+npKTTGEYGC/q84JSmTeCULW4o=;
 b=eq2uVjLlMwQW4WGHbSUzhPbmLJH/4OLcPAEbeXEKLvhk15IE8x3wCf4VHfOflYDcH8hCySryqSGhOarXkHevd0WAFBH/O6s8bLGrFUCgJVwuBV4Br0LTFSJdJC3DxXwv0sq0zCE0vWXwZ7DMkWpdd6hLl83qhdn1kqw6vMLGb6AuL7Mnfj1guZBMetsHumLpGbm4+7aw/iNmxpfg9lUyUDbAuVsv2rink01T+Af/Jywhf3/hKufg22cG+EK2f15ZgSiooxzFNioeXKOY/2JEyaJPwM+0brJA4F5rTiujEi3feM+7zEtg72YULjhnD2OLe+F15H0emDH0rwsYHt4wyQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4974.namprd20.prod.outlook.com (2603:10b6:930:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 00:31:21 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 00:31:20 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: use real clock for sdhci
Date: Mon, 22 Apr 2024 08:31:46 +0800
Message-ID:
 <IA1PR20MB49530361A95A5CF2453BFFE1BB122@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953CA5D46EA8913B130D502BB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [9s/7bB0ZkuNDwtK0GIDZXSuMGur5nXkdn2eL0OfR0tI=]
X-ClientProxiedBy: TYCP286CA0192.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::18) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <171374587875.63774.10181712288386461900.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 861b1e34-c6a3-40ae-1da7-08dc62638841
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4GjASG+DoXl0dNrMNeXyB0J8ymOCkj3d10UYBDqPPkCd1+cH2dLcAyXApuOerQQtncCA617o9xhlKe7X9U7piZwQOJHBxl1XGkPF1TovIBdRB3KVbFho7wOdWiaeqIJrLpVUarWDGbhyleK+SllJOMCxAtYy+o5rLUr+vvVde6A9l7C1ObvtPyZyWxgyzGjggDXgwHqGC0zaC+RZo64f5YY/am+jOwc8Z/rYbNH5my/aKTpkzVTYGu+nvPdJKJIlsMi6miqtTLeB1rvrMwNL3D/XDoZ8p0tvDjRhst34k7JHF0/R6lwZmH9O9sTdyQc6Van74f/nOldq5NVac/8fnr+3W+7dKKJlOKZM2rBbtspV4w1plHi5dvu9U3wGLaiQcvvNxs4mYbdEz847ADSndRXSgfT0CLFLbVp2s+i/8oeXaNlOVBECFEeERHAyTzwnVzErhjSdG2eUaUVwIWvefJ3w5EKj1De/Hja3EQOZ+86nXSL0mmBe22cmZUjW9T567mIgmnG7OWQwoYbSbIKX80KW9T5FbKJ/IcVZ/L3Kf7b47IYzlMJc8SPBJ+1AogeHAcWVRWTbFTSII0A0nFF+IRS9jE7DM3rOCqvaWxKVo/8MtcyrN94oZrDyiLJrbLhMqYSpyFB/8zZGMIsl7/nwU56pXBNVI2gJjRzsfaDv7+s/VIDkRFnVlkcj8MjEoqXn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU5mOUdGbk9JTDFXR1BOSW5PSFJsT3ZHMGhlYkxhWFZOL0lRZkNWQ1k4Mi9n?=
 =?utf-8?B?V0dWR3hVWVlndElPRVpwM3NzZ080QkJRdzd5dWdlUytuTG9JSk5RVzR1Tjlu?=
 =?utf-8?B?NzV3Nm5HdXlQQWxkU1EyakdFcUxJWWs5VVE0NERjOW5POG1mdGxndGIyRDky?=
 =?utf-8?B?ZFpwbituS3E2RmIzKzRHa3FCM2IrZjdOSXV1Rm1HUjVscHlibHorOC90Y0dP?=
 =?utf-8?B?blc1bzNNcEZQdlhaUXpjbVJxeXRXZTJ6UzdvM25yNHVjbmNPVVR3Y3Aycm50?=
 =?utf-8?B?ckZVcnNHVHFXcmJQcGdwenNpeFlPTmR5cGluM0FRN0VKMEJ0VFp2L3hqeWpt?=
 =?utf-8?B?Y1NFTktITUl5czZYUGpWdHQ3NHZpNHpZbG8wdnBaeldEN0hrTi8wM1VKdFdw?=
 =?utf-8?B?aURYdDUyWkRHMmF4L1FSTVpud2FwMDhENlVlQzJDeG9HOGY3VG0wVGcwUHFP?=
 =?utf-8?B?b3c1NnFBM240UGttUTZNajdVZy9rMUp0eWY2RVRqOUtXOW9aVjZZcGRZd0Zu?=
 =?utf-8?B?cmRualBmL3l4ZlRkRHVaNnAxOU5DZFBoWXRldi9xR014KzgyR1NHenhNNC9q?=
 =?utf-8?B?SCsreElMWDRBTUd0MzFsZ0lJNnVheVM5R2xSbEtubEw3RjZzRFp0bGpRUjJB?=
 =?utf-8?B?RkN6QkNhM1hoQk1GclplNTRHQlZUQUJIRWZnSkExeUhPQ1YzdVlaSzRCc2tK?=
 =?utf-8?B?LzBCa25JNkdXVmZ0dDF0QW14M1FoWHF1VUdLSkNrbVBtMFh3RHgrcEJpTmZq?=
 =?utf-8?B?d0YzdytrY21VZXRjK0tWdllWcWVDaUVnbmJJZFFoVk5VblBKMkppT1R3Ykh1?=
 =?utf-8?B?Y3FCNnI3dEdXNkUvL0hDdGJHM2Q5VWdMUTB2VnhMT1lRaEc0dGlIZ2JlQ3M0?=
 =?utf-8?B?UHk3d2Zib0s3akJUSEVTalFxRlN1WEFhbEtNa0lVZmhzaE4zRGl5K0k1Q0V1?=
 =?utf-8?B?bEdPQXJnUnFYckdRSWRFaDNGczArK2xJeDhhRFRvaExIQnVYd1NSZUVtdHYy?=
 =?utf-8?B?S3dSRkZwdTJZd0pRRWJlNnNtMUk0MDAvWlhRLzdadTdWa1Z6L0JOM0V3WDNK?=
 =?utf-8?B?cU1XS09ndnUxOHJ3UEkvUlpoS2JTQmJKcFlzTXJlZW1mUVJiVHp4a2tqdVVG?=
 =?utf-8?B?ck81R00ydjdXL25COW82anl0WWJiQmZGTkI5NmxqY05hbHlpQjE5TXJNbk05?=
 =?utf-8?B?Q0ZOcGt6TFgwMkE5R2x2MUErSU5MTFA3L294QWxPcWZNWFRBSTF0Sjd2bWo3?=
 =?utf-8?B?ME9Ga0NnVThhKzQ5eTJVS2lUSWlhRGZnNHVpaXJoUE9Demk5ZXArb3NNMHgw?=
 =?utf-8?B?SVJDNy83cUtUZy9MUHh1ajFyWXpUaFczUkVjay9lbmp2K0VUWnZIKzFLRDlm?=
 =?utf-8?B?L2tUQWhJT0QzdXU2NGhGZUx6SU5Ja1g4eEZZaGpwUHErWWhTalJHNkttUFpQ?=
 =?utf-8?B?VWlLdFd3enZaV3JvRllQRmRDSWRpTCtKVWc5NURtZVhhUmhTUFJlMU1YMFZt?=
 =?utf-8?B?NXB0TVJKRFAxL3lOT2xjeGx5MFFabVZQckM3YlpJVFJCZ25icW5IVVhJU1E5?=
 =?utf-8?B?VVFiTmpSOTlwNy80RVJUdzZGZit4eTNkNDc1ZXVuYjYzczdXOW9KL3MvOXlH?=
 =?utf-8?B?V09wQ3l2bGJhc0hyaEJ4ZVV4MmR3aTVBTkdENUZRTjNyM1pWekNRVVhzaTRv?=
 =?utf-8?Q?pGoPQXWOwgT07J5q0GVb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861b1e34-c6a3-40ae-1da7-08dc62638841
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 00:31:20.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4974

On Thu, 11 Apr 2024 20:21:35 +0800, Inochi Amaoto wrote:
> As the clk patch is merged, Use real clocks for sdhci0.
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] riscv: dts: sophgo: use real clock for sdhci
      https://github.com/sophgo/linux/commit/886776ca23f2433eb69c0f95e0abadb7dfffd789

Thanks,
Inochi


