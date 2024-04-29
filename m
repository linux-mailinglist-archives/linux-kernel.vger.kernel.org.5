Return-Path: <linux-kernel+bounces-161912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA58B5332
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51E91F21E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F24179A8;
	Mon, 29 Apr 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gF75SC2O"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2062.outbound.protection.outlook.com [40.92.103.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EB10F9;
	Mon, 29 Apr 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379517; cv=fail; b=UYRxiBFmowoOKY6GASOmWJUOBg8q0Mg/TzMs7AEpbm1LG8QV507+DNO+8kvgRINzmlgelUZ4Qtdg1puolrZYlqZlVQJ33jtCKaF0Pt2vn3guUS9db5TyypC1uy89MEb+x2qa6+z2/5r6P+x+OP9sdXWs9yfZVUUK9a0juXGAN+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379517; c=relaxed/simple;
	bh=TsbdTsQdSXnve6cLvczwd7XT4WT8beGbLcMkiBxOdis=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X3z4QvwRYkGpHaZybW0eBmcEcVyBlNo021OjWDD3fg3WCALcFNcWe21uf14lmgYlFVpisa14hfg5YK5fTppU8GPgyH/TYLdcWzn0YsQmESjwvRnIJ+NqpZEsG/hbrxbpyW6cVS8JQlQ8oUkwLkhB2prViU1MLJAV+kDusuRYST0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gF75SC2O; arc=fail smtp.client-ip=40.92.103.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpEjOCXn6CYJR+eQbNNvY5T0jDyuhdL0HCC/c77bv+zerN6w94A0iTLAb6sWz6/0Dhzt8zyLF7CrpjBYC5BMoE/lZB5ocVzXwp/TLcSnUqcXvlqgoDNw4UmlrQ+p0rxaTfh23Ng4IugeykS2CMoDE0D3wSpnylBKpD81FmqrezbWBqCJx3fTwjAwVLMjmXX6G2tRnO6vYjQvcWzO5K9sZkAoOVD2om/0rGxXjY8RPgfPpnAETaccR58TY8dWs02pw7dbNZpo/ycZ8Etr7MpRjpg0apqtdsRX6eb81aBXTiMOWKy+xZfOmQ+l4joyZSJGbDhChiH1RnURiJscL/phtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GL3J9NiLN2qFoH330fCipDH80wpkACQNdzREk8Z7bAY=;
 b=JSavV3ttsQff/3RBBor59YFHBJDzxcIptIzHfJSswyxzlAR34gVWGeJ7NCvOuJK2iZMBegPQ7IMQ8fLpMdfNmQ5y32jzyekq3AqLS2VP9fG+rpKo3zfB9k8VANbUp0l4oq+7e23PLoeZMQGhQO+Yax3QBtm/T3Xv0z8GgOgHDfil5gEnqXjQmw+0bDyrdtYHo+cE32ovnXDZoEi/1mlZdr/JE0Qf9stGhWocvFmGFPCMQ6cS1qow2jMMfRgVuHt0NIHoq03/GX6K3MXHOzGlvsv8BP1i1UzmxuMFSU97NqFYMX0rrqGvvBgrtTj8clQrGA1f/FbWdEk5ujxju584Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GL3J9NiLN2qFoH330fCipDH80wpkACQNdzREk8Z7bAY=;
 b=gF75SC2O62PkWtZD5AFQxXh1nJ8RpSDqA9JGEHjCTgV3RELx76TZMEKZoqankKR4N8X4g8m6zMvA/Bs6ttYLDPFSEU4o2vYqNR2E+KI+iFiaHL0U53kM2DkwGeMGnOUyROb917p1H0yQty82BZ6FdGRpGp2sXtp3l44M2NQ36tX5JJdJ0ntx8JjNZu5LYu3sQ9dhD2Q2DZ0zkjIgAYRr9jTipHbgla7Qeoah701cmhroDqRahvSDyAStlKiDpK2/7bsvB2572NKpx8+NDew01xXmHxrGmtIiVVtm4sGrhWE7GJ0Gvp1DwzJWicuRWxlzCnNbTzP1Xf8sJw6bLekaDQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0270.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 08:31:49 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 08:31:48 +0000
Message-ID:
 <MA0P287MB282270D8DBF5F2B329221C6CFE1B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 29 Apr 2024 16:31:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
To: Drew Fustini <dfustini@tenstorrent.com>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jszhang@kernel.org,
 dfustini@baylibre.com, yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com, guoren@kernel.org, inochiama@outlook.com
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
 <Zi76efedrI6Uv3f3@x1>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <Zi76efedrI6Uv3f3@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ccTazVnQYD6IKYtPCMq5kfQL2mo2Z/VF]
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b81c78a9-23ff-4638-bb21-a5a1c50449a3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: 211cece6-4423-45e9-30db-08dc6826cfe2
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	dcroClaXyvDvsDIaRmJmOx6TALXfZnHeAJagupQOpD2QTkcWtT6xe/s31S+WC9916WCA84loz3TZAaUt1V0XFhfKmUZaSb5BfNZ22gIvLxoeTq5cNCTcPvqsIkBepGgDcW9tGVR+3C38TXQZJ+nn29wa0/APKKy/nVQx4NyUF8KhqmtbXFkNxAS7yMYncP061p7fT5OrLgn25n7fmmxylwKMZb1EwEI1qCGXgc0reqzwwBtZzvCPEThooWJ0p1nl5A+epVtANS1XVyR/hE5ZTdVxY4pLP37nT3CL1kgJyGV1yGOU49ucAK3kpwvBNEinf2Kt/v8TjLbtM1mRjI7ddtUfGh/CQMkGzq2wz9MBZUV4ql/D8Ogj8hpAUyp1JQaWrvatEIRGMynFW4XyDIs7q/co/fmV9swfcEWvsnLNnAM8TNM0PjPaP4TRAD9Bhk9tdRBRSrIUupNhCajZuW4KWRO9wHygBAA5J7YQi0o5F7vyM54eZ8ihEkDGqvTzThvvGC9xz+BcI2qjEJKRpywQbTPZWaeAU040bkkL8hNL/6Hai3/DaGtfbUU2LnKIWkud
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFZOK24ycUxUZHBXKzl3T09TcE1TRmdqcmM5TU9QNjBrdjdLRXlUWWZScUl6?=
 =?utf-8?B?T2xSVzhqY1BEMHJBdmt5UndXSVJzVmpLNVJBbUE3TGRPVWloeEo4M2w4ZGlK?=
 =?utf-8?B?azV3T3FqSTZvdXVUK3Y4dU9NTldmZVdQRXBucGdzVjFSSmczK3lqWEh2ZTkz?=
 =?utf-8?B?MXdIKy90RUk3STl3eDVOQXBRT0ZvY1N0cWpVSk1iQmYyQXdtWUtYOTJhNWcw?=
 =?utf-8?B?ZkhsSkZheC9QUDNMVnY0d3l1T1VSR2ZkY2pjWERnVFBPZDA0QU9Icko4bk5B?=
 =?utf-8?B?dHhYRTFHcWxMRnFuT0Fyems5aURUdUUwVWxoNmFZcnczTDFVQ0dQazViRjhr?=
 =?utf-8?B?KzhKeEx0Qko2Qk9UUXRGWlE1TUlJSEk3bVhOd21FZ0VmS3JUOWlkL1JVeFF4?=
 =?utf-8?B?dWZGSExPc2ZkMVZJUGpqN2s4anJXcFRnK2ZqcFBYWEhIdzBWdW1aTSt2YTE3?=
 =?utf-8?B?clZBNFIzMnJQdXN0dkY4K29PSlZpcHJUdEVvTlFFSEQ4WXU3Unk1K01UQ29D?=
 =?utf-8?B?eTE4MVRuZnlYRFZpSFBJaFc4VExubjdTOU9RK1JvV2I2OFFlUG82VDFrWkd6?=
 =?utf-8?B?MHhIdlZrMkh5bm5ZWUZPYWhVblRZelpyMUVodDJHb2l2YThRKytuZFBJcW1t?=
 =?utf-8?B?SHBVZjZuS0RrNytsTXpZQ2NxQ29oc2lyVWtkT01TM1d5YXozaXhCcmE4WHA4?=
 =?utf-8?B?ckxCM3hoa3Fwb1N0TWRZUWYyekcrcVpmVTVKZjQ0dWM3NFIyaW0zYnJjaW42?=
 =?utf-8?B?ai9uVlQrL0FkTnVNNFVUOEVBSG5TR2NEZDlwZkU3SS9keitocHQwSGdodVpG?=
 =?utf-8?B?bjdvU3lWeGdqbk5iSnhOV1ppNHlnK2VoL2ZPb2l1YnNWZnZyeGQ5eEIvdURN?=
 =?utf-8?B?ekRPK1B0VFVrc0dqRG80QURaNkZFWGpnWDdRMUJiRFIzVkJWbWZzeXVNNjV3?=
 =?utf-8?B?WVF5MUNGcCs3YmNkMEtZT0NzV1JMVm5wcUd0dnpHVys3UmsxL210MzhpdHVL?=
 =?utf-8?B?S2N3RHRIK0c1aEVWUUNQUXpua2tlbzFDb0x1ekx6dlprOEp4VkdLQ2o4RWx5?=
 =?utf-8?B?RnlUdUQ4NWZ0UGJNVTBoZi9TbmJ1MWpydUZRdlhDZjQraEJsN0ZUNk9Edlo4?=
 =?utf-8?B?S2pZcHQ3enRkMHhNNlJBVnNQUjJLNlVPZ3JVRzc4ZldXMTE5VHdDQzNNclFP?=
 =?utf-8?B?WGMwbkZLdllmRjRvRVZVZmppWUt3MWlBNThNUkRHVEc4RWs4NXBwQk5VNnZU?=
 =?utf-8?B?bDJMM1BaWndyTm9EZW14VlZLaUY3R254R2k0ZzJMMFpPaWhQblZDRElnTGR4?=
 =?utf-8?B?Ty9qL3dEK0pWbGhOOFdORVZKNktqY3FOWmYzUDVaQVFJWUtoM3MxTWtMeUd6?=
 =?utf-8?B?UFdmNit6OXI0SzJ5dnkyR0hLbFFXbHB1eXYxK1U3bnlidWJHTkxLOUhhRHpH?=
 =?utf-8?B?UDFpSVAyQUg5QklvUkNXWTZwbWl1d2d0VDFTUHlzNHdVcElRcDBsRG8xMFYv?=
 =?utf-8?B?YXNmRlNWd0hpeTJlVUI0Y2EyWXBsZ0hRdWM4bzlrajEySWthNUlPcm1NODdL?=
 =?utf-8?B?Y0ZBaTQyajVpR1h0dVRreUdWSzVuT3BDVEZoL1FJWlJ0ZmZnTTdrU2ZHMDFD?=
 =?utf-8?B?ZzAvTnkraGlJS2NUcE93K3U3U2JodWRQUFNaQnYyNythTUVoU2lDZnRjK3JH?=
 =?utf-8?Q?NO0DK3FsQiJ81RnlEghA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211cece6-4423-45e9-30db-08dc6826cfe2
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 08:31:48.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0270

Thank you Drew.

FYI, as per some inputs from Adrian, I will try to imrove the code and 
send a new patch.

On 2024/4/29 9:40, Drew Fustini wrote:
> On Sun, Apr 28, 2024 at 10:32:41AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> The current framework is not easily extended to support new SOCs.
>> For example, in the current code we see that the SOC-level
>> structure `rk35xx_priv` and related logic are distributed in
>> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
>> which is inappropriate.
>>
>> The solution is to abstract some possible common operations of soc
>> into virtual members of `dwcmshc_priv`. Each soc implements its own
>> corresponding callback function and registers it in init function.
>> dwcmshc framework is responsible for calling these callback functions
>> in those dwcmshc_xxx functions.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> I have tested this with the eMMC and microSD on the Lichee Pi 4a which
> has the T-Head TH1520 SoC.
>
> Tested-by: Drew Fustini <dfustini@tenstorrent.com> # TH1520
>
> Thanks,
> Drew

