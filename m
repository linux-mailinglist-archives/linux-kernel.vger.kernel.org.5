Return-Path: <linux-kernel+bounces-153395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED18ACD92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03108B259BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112714A4C4;
	Mon, 22 Apr 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qhkzo3FX"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2068.outbound.protection.outlook.com [40.92.102.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DF14A4C6;
	Mon, 22 Apr 2024 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790391; cv=fail; b=ZBYwHsmMM/4W/05qizMULDJa72HGRq01X4yF7kiiBIJxK+tVmUT7d2buYUxFqN3Z+IuMVqPpuOzI3oOPTUK1Af9w6+4zp/gDIOnJ8PnBIkqwPVYGfv2CBOrHlDNRWmiof0cXn2vUQiT51UaO0UjxGMCHyFek2PT21Kv8ZqU70+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790391; c=relaxed/simple;
	bh=aa1N4gkq5dVcIJLJx4M6AIi+YSbAaKcE/lKrV67/o1s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h3jstR+Hw83EGyiqlSAUUl5lAhXaUXXf4v1WPJPcVJVMesKxMPFuTy5slo+x7F3WuwbZWuuShP2EUzyxkLU/ic3C4xFSh0tnEgUkZxvpquSU922ohlD5ZwtaotweG/ShbHthnxyHSPvKjrA5gRjAqBO0pgltUWcFSXr9qYSL7X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qhkzo3FX; arc=fail smtp.client-ip=40.92.102.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNdFjSfNRBEmm4CSNRZu5KxEkZl7PwE2r2WEMYEFpbBj7TlBKOA+kpc050CiAogs73V/jtGgcm8ZqNFVILDSri2BOqIysndRm1MB0qPoYs52rKZ+FVDRR7ohyc7vP6kbsKZ+R6Pk+BISWB9GuEaEQ2dRlW/sMu7u7VafOm0IETi5o1bWASSDU++uLeuGedUecFCATFdBE8TCRqgQYOvxN20jmjI4vsCgiJqpm70ZPLLNTxghGAMVcKpB2iehBEqd314sYCHbv15FHRflGtUkxa3Ch5TPEYAdvAiCeqW7v5fzCW+HiW97otYFZPIJBgkz0SPIB4VkwDAs1IGg8mODsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaMNNUhN4dSzA3vRwBMboWXc91HlLIAIfzErRNbAYrE=;
 b=aR627ze/7U5JBAqtSIAlUfpPSqr0Cu+9ECZ7y83oFkFdrn7rVHtqHJYgBxh1DHHX0QCVnvBelsRl0/5hBrwjDwVdY8CP+gz5rF3Ql4AWc2clyGJBxXidyvSdTiCb20cuKroT5f/NiESYf0u/CwcstXOsy78DcAbWNrwTzaeltZGQx2dG7x/0J0QODBX820+1G2LZyNwGDmTIYdKrPHuVs3vhz8vsXoLydqWnnEMQrbiMl/kzD/y3XsG1nm3CRUCPCG70a/+9GlqLDmxeIbbeum5DAlfFljowOLOQBA3RDHQbD1BFZLlTE6k/Y2PT+nIllTtnbgD4psl+1UjZFwONiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaMNNUhN4dSzA3vRwBMboWXc91HlLIAIfzErRNbAYrE=;
 b=qhkzo3FXruihOy6l0/QIcvXgAvmzn5DHSmHGh1duK1usb3BeOZIGrk9ZWymwyFDKNCZK9KgTJPIePfhtyeVW17WP+gdJZ7+3iYAphMQmANuY4+l9jZUZE9xjwwOfVteBe7DuEfkhZKfNr5UXzgmvjglTmwz8ZjMkBRX2sMWgTQULsoVBnuIPLjni8DmUqkQlJTezMi+KbeR6k5zOzrscRrhtsEQfgNe9OZrpA/vAsturaXp7SJNCuPTLdJkTMwq0VG9qPOp3wBOvqE3QeEV+PnwY6fXV+IeJtfaVXlWpH2dqXIctXaAVwUtH8H/1SR2MhfSxxKXvpaJ7tz5jqzBF5A==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0366.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 12:52:58 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 12:52:58 +0000
Message-ID:
 <MA0P287MB2822A7ECF08B587C2842A9D9FE122@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 22 Apr 2024 20:52:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] mmc: sdhci-of-dwcmshc: enhance framework
To: Adrian Hunter <adrian.hunter@intel.com>, Chen Wang <unicornxw@gmail.com>,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com
References: <cover.1713257181.git.unicorn_wang@outlook.com>
 <MA0P287MB28226B9C954F3DBD9B5E29A5FE122@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <d39ab4b9-ad43-4d4a-9fc6-3133d761c79b@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <d39ab4b9-ad43-4d4a-9fc6-3133d761c79b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [b+H84ra4AIaBB9msZUeG104FKJ8k/sAa]
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <7295eb07-f6f7-4c29-a682-e389abb4a375@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0366:EE_
X-MS-Office365-Filtering-Correlation-Id: 630e37fe-a9d4-4cda-287e-08dc62cb2315
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w25C1FtJ6nspUWr3Cb0W1RUJzvGnEsvcfWW37aw/69STHalV7Bkgu8FKelYH1s51No64M6kodRO4wItvDNqTQqG4Z0EawZt1RMNLSINLsEeUGmBUPSx81fvkfBFkfhPmghLC6QrE5N1QGOQqf9xl1yD8FdC3hSCELdHcywU6lTKWJuD+LXSRqEKMfAxPHGNlUGd7fRxuJhxB4YWR6FZ0CUcM2RHrSxs3YJ37+QPlz7js9vv3CXj9/f99P0jfZglu18TDHzgb1vHZOCY0+WwEjAwXe9tNg/gfw/guszsxZCbmxnjNO60sTeL0rNdtvLVbnIjHxBLFs2dxJu9af/ia1tcGdQ3b74CKcheteRLwkwf8hdHzzR4ssCP1tAWgClmfaizbwJ4cmZFrw+mBQdmForG60LuqZpQPacjF/9BeEdg8o87vMdQ96XaKE13hZjbTzTlmaNoasS+5is2EOQGjH/IPf02933tSiQ02mEgCd5CD5KbPi3XB/+n6zTpTL42nkrLncRPb/hiUi81Cbv0Ai0x77hqY+yP57LT/e4gbrfu+PclL701I0wv1FWHVMe5YOaWPhaG9MRzLIYTQnTv5O+1jP9LORSX/74tHGBRYpShVZtLUAWZ4LWjeZWAmduKxNBidQ7HYCiSdlvA3zB8uSkY6hBMu0e2PU++k8ciLlcAFIqW8qcQSjo0CjwKCRTYJlFJ761Uc3qNL9GAFdgmI5g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3g5NThTVWhoci9XTFpXUkx5eWNTcVF4TlZnUHRqTkpxWTZBbTNoV081c0J5?=
 =?utf-8?B?Q0VHM0lETUxiRmh2VVpKcks5aHZEQVFMVk8xTE9xZzh5cnlqRklrTmpJclB1?=
 =?utf-8?B?eFdrZkZJaXJvbFhlSEtiekZZRS9TSnMxQUd1MWVZWEdjMHJxa3FLRGc2OG1h?=
 =?utf-8?B?SUNPR3pXRkdWMlF5K0tGQU44cjh3UVR2c1ZYMTlXNFNGemx4WG4zTzdWU3ll?=
 =?utf-8?B?KzNmWEFXZlNVeENDdnFlMTNIQTBmaTQ5SU9zbDAzNGVvOG1YNlJKMUo3S2x2?=
 =?utf-8?B?bWwrWDB5Vm9tOE5Xa0tJSzhZUFVZMnQvdXIvNS83R1RYemR6OGhrKzQ4TXNo?=
 =?utf-8?B?dHluaVhSdjl6dm5TK2J5bndvQTlic3cvb1d3SVplVjIvUENQVkY0aEpUSUYx?=
 =?utf-8?B?NitHd1MyWFluZ0NVN1VtZGRKakpiMkp0c2FOdk5GZjNhUHpac2ZhYlBWUi9i?=
 =?utf-8?B?dnEvREpKcmhwSm1ZbVlJcDFNK3hUYWhmRVJnRHcyN0V6TUJoVGptZWpmS2FQ?=
 =?utf-8?B?TlZBTmt4Y0R0OTBpODFyb3dkMXdsbWYxY3BKZmdyeWJ3eVVNY2tWNUlzWVhS?=
 =?utf-8?B?RGZCS3dBVnlOSktwMEU2U1RUNzVoYVdtanhXU3FyREpnZjBSYWo1UGEzQ3Nx?=
 =?utf-8?B?OWkwOG9rWmpOQ2ZJL3AvTXFIUmxncU5IbFpwTG1xYmhXK2xVbHV3dnFwVkYw?=
 =?utf-8?B?NWZocWRHZUJQVjVCVFBCWTFObC81ZXRsSDFMbnZzc1dwVG1XQnVtOHVXNllB?=
 =?utf-8?B?dGRURDloajJRMklVc1pWSjJaL1F3cDc4ZVhnTjVWQnpvQTBPdXVtSDl0UlB1?=
 =?utf-8?B?ZEtWMmJxeERrYkZGNlV3VGl6aWNwc1FUNlZtMHV3aG55Z2wza1BDWmtpYTh3?=
 =?utf-8?B?dVp4VUJYaEN0WW1lcTZJVi9nVG1CM08zYnQ5bms3ZnVpTVd1NXk5M3Bkc2hv?=
 =?utf-8?B?WEh0VklYZUQwR01Ea0pGNjExOFEvOWtFcEMwU2llWXVxaTRIZU9vVWZQRFdD?=
 =?utf-8?B?TXJsd2Z3c0t6UmNtY1N4ZUNVTVlUQlRVelgxUTY5UlllZXNYUkZZTmFBbTVa?=
 =?utf-8?B?N1l2WlJ6bGpJeEI3c2QxRnJlcndLV1MrOGZPYUQ4S0FxTnlDSlB4RVRrUjg2?=
 =?utf-8?B?VUk3aW0xZlc0NHZuUktEL1cyUlEvMHVKMnNpUGQvak94b2ttRUFGZW9tUDQ4?=
 =?utf-8?B?Mm8vbnMxaTNoYXRQeXVEYkNjMFhLalRyVmNMZXNCZUpuYjJPaFBSVTYxam9K?=
 =?utf-8?B?bnRINVBHM2pjU3NVZi9lY3YwR0hhN0lkMFk2T0JTWkZCdmd5cVYwSU9KVGMv?=
 =?utf-8?B?SXVvWlFQQkV2SmZTMkJOL0YwZCsvSTZORnJ4Ni8zSlFHc29TdWIxSXRTR2Iy?=
 =?utf-8?B?SmFlSkFmd0w4VmdzWkx6NUlPTm0zcnQ0SDVKcUZxZkhVT0p2bjJVK00yU0lH?=
 =?utf-8?B?SFYyYlVQNVRMcmZuYVA5d2ZVcWdzR2V2eGR6YXdMU1hhbjRzT3JiVFJMSW1Z?=
 =?utf-8?B?TzhoRGk3K3lwRkNNbnFVWm1DazV6b1pBcWNXNzRSK2FidFlwSkhCb3pIeFcr?=
 =?utf-8?B?bWFBaU9QME5xU2J2L1FLTmdjbU5pMzR6UjZUcUJ2VTRHNUVyUDVwUmtCUUxW?=
 =?utf-8?B?KzFoaEJ5cFVTQVNqNjNMMjk2cVNqRWtXWkpNSHpqVnBhU2FubWhKcFVjckRU?=
 =?utf-8?Q?MML1/6TJDIx9JcIV+ZJg?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e37fe-a9d4-4cda-287e-08dc62cb2315
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 12:52:58.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0366


On 2024/4/22 18:44, Adrian Hunter wrote:
> On 22/04/24 12:01, Chen Wang wrote:
>> hi， any comments on this patch?
>>
>> Another patch [1] has dependency on this one, so I would hope someone can review and comment this one first, thanks.
> Does not apply.  Please re-base on mmc 'next' branch of:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
ok
>> Link：https://lore.kernel.org/linux-riscv/cover.1713258948.git.unicorn_wang@outlook.com/ [1]
>>
>> On 2024/4/16 17:43, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> When I tried to add a new soc to sdhci-of-dwcmshc, I found that the
>>> existing driver code could be optimized to facilitate expansion for
>>> the new soc.
>>>
>>> Thanks,
>>> Chen
>>>
>>> ---
>>>
>>> Chen Wang (1):
>>>     mmc: sdhci-of-dwcmshc: add callback framework for expansion
>>>
>>>    drivers/mmc/host/sdhci-of-dwcmshc.c | 185 ++++++++++++++++------------
>>>    1 file changed, 107 insertions(+), 78 deletions(-)
>>>
>>>
>>> base-commit: 4cece764965020c22cff7665b18a012006359095

