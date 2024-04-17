Return-Path: <linux-kernel+bounces-147777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A88A8A798F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F17284B54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C796FA8;
	Wed, 17 Apr 2024 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uqHnMyBB"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2057.outbound.protection.outlook.com [40.92.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20D4685;
	Wed, 17 Apr 2024 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713312053; cv=fail; b=TOzDI8axHr5wbkEgUdQ80daEcR/NmKNuK0oMcE8Q83LoItW+sW54Zo4BvxdhUQXKMOvmJgkLPpcpNKWe7JF6ozTqIuPpPO2+VAXvZXULYslIXTgPX2MPvau70sfulajYuBVR/sBLh4mvgQ+fUK+fX3Jmw21lDSN3WPRsxo0U8Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713312053; c=relaxed/simple;
	bh=ueAbQ9/b1HVTFLtY06HmKX9nSz+NHnYPRR62+euzxmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSfSpnaRkogsrxqDfnyslNoDENzZlDb8LFk5c6S7ksIPEyfsqioxjhc0fyxm7q2VwBh5Arqo3rdNK/pngH0UW1M1XP4fD+2ges/7lmMTyXAppQcS+EW7Dm1T+ytZBQzvuVHZiSV6D/G8Y9fJl/tRgXhKU/PPjXbLT7bI5MngArk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uqHnMyBB; arc=fail smtp.client-ip=40.92.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsyKP5ishRLXZ7wVZeNAnVpUY4aSSVSRGDB6YljKWuVSgzBoucoDXz6VSJ9Zyd8e+phMcdM26WPOKFSKnn0Pw86QtQh5iUVQubkukYRmcPpok0oABe8DusN8Tt7c4BY3ry+Pbd+XCX2PJHI1hCdHc+0csjn3+fqGN+EZSfs4aosVh+xIzAl2OWUc2+s/FBTR4VvtlfPfXDBBHHPnX6r2oRZtvDH1b29g+Lvh608ZecQCo2yRBZ1l+61P+kwTjAH2wKIsBFknMJxVyyXGsmNMaNYws8WHEhOsJ5L3CQNO27AQt0QH1VYYx8y+nmtrC5t5Qm1MgJ9pR7jI/gDWhiDEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fA/JWBoybBau7SjbgcugZNDu/G5eQKw173HmHJdAhJY=;
 b=SimbWnTCqyxjLumkLX7HqFNfQjILDmEolEhHcwqaG/TPmGrlWtoGph9XyNenRUPmsV83+VzkS3Lzf1ntOWeo5diNIAezV65oGaHhY9p2W2kLTVlChu/kfpw+OrhZcFXKmT5HAnopszsB5hGJsHqzm9QGbPaHzIm6AZJ1YxMLliM2CrwAu9sOJ9Z+KxFArBTLzs0rAqSCReKZy8dT4ZENdFMpQTAwjRqjhenKCr9FQPoXjFKs6aWO7izbiaFI9JMPh+MCsmcwy5QEtBqmnRSje0RZTsxN0DXQ0SFP4hboSYtsJsjbBoEAVPDVX+4Dwx8VU0n8NVkKlGKlfv3XW8JtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fA/JWBoybBau7SjbgcugZNDu/G5eQKw173HmHJdAhJY=;
 b=uqHnMyBBIzyYjYp+g2eWRmkmjEYrw/hGBLprq/Xflw3KAStZy+QExEOh+m+C4TixkzJmG9s4+qz/tr0Q6Y5OyMu8O2QC0vAdEnvIQc58k+2fwAhVv5xeiOgQgSh3RLEg0n0FZw+jrmUyiwDEqwGuK9E+zbMDr8RybOcQzbY5z/9FraBTFaPrAzNleqe/zucFtCuZ0g8WIf9lrtoRsdwCrBViha23oYDSE7W3fY4ZGMcIWwbVprYq36ZJdjt5LQKwwD5+qNqI2nDOEo9tD5e/3yYeNuLIr1e3fNTh3ZjhhgR3G/daIolnxTd0CgyJj70GBgR4Yz58OaTVk7ATgjx2ag==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB1455.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 00:00:33 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 00:00:32 +0000
Message-ID:
 <MA0P287MB2822D66AFB826428DB13E527FE0F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 17 Apr 2024 08:00:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042
 support
To: Conor Dooley <conor@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1713258948.git.unicorn_wang@outlook.com>
 <032c06642b01f06c86ba8bcd2108d18c005b57eb.1713258948.git.unicorn_wang@outlook.com>
 <20240416-pretext-cognitive-295526072596@spud>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240416-pretext-cognitive-295526072596@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [8YyUbG5YfFeNjWhzcYu+9xbHjs8TDo1H]
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <553df95a-8b6d-4486-b047-0d5f8af91ff8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB1455:EE_
X-MS-Office365-Filtering-Correlation-Id: d57cae31-fcdb-4ecf-c60c-08dc5e716694
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8sudoPhejsCiyen+dYIAbGqKo5shvPfSQORoUbvOMDqlhR2id/n62a3p70de1+47w1KkAfdTDGjo1PqJ47YOwCJNi2R8P8t22TzUcPQIXPNtmWXm8GKgWdUpqwKnxVlFVi1HQdFBugZbYr0KOgUTC3+XGS0W5gmmB/37IjPgHVXxcvX6Vlqj2O4Iu+F97NezI0pqod6V6fHcL/ewMinI35bo147UFBNNpRkJCqhrGgJUuu7HWnF8lVl7coJ+5CoJOTEPjiaIEQJO8RoQGqUtLpsxmPI8S2TVxRKhG0EHm/u95aKZN9e00ETm3kaJXak/zEgPs5SH32ey4OJhQad6lZrbo5DtbE+dwpP71clczH2EizK1+M3JgT+4f2MsIBZDqTU55R3jXL2vM9RzFkAtdX5EDxn1Rg1rmwunsnY1uKQQAY0eIZJ0KeLyRonztOuD5aVMBOD5TQmI6mHLu8LlU06hg5k/AAEMwJvAoTr2yap1PE6XkxIbfbkYHebLqXPzZp/SL2Fne6GIiwrrI9ejIDir03x1GDB/1lwes1Bl17jWBos+pmjSPYEjKMEX5cw9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkN1eWd5azJ1TGxtWnppL1ZuQ3hSNXZVSXgzQlNmRjlWQjQzeXdxRGxRMDQx?=
 =?utf-8?B?TGpESmxQVjExYkczOTBhS3h4UVlla0xZaDlQdGFBZUFiUlhQOCtvMmNkazlN?=
 =?utf-8?B?TFZ4Q2RXaHU1QjcvOUdoTEdVR0dBTk9xZ1NjZVVyeTBrRU5xZzh4cURjbUdW?=
 =?utf-8?B?M3lBMmNlQkV6RXhKRWNwS2RwR3BDSnljdXU2VGdiU0RBU3l1cVZlVnZJWXoz?=
 =?utf-8?B?VDE4R2EzVXFWYklZUHk4TE13TEg1WUw3cUFveU91RUF3ZXJuVHlQNmlrQ1hi?=
 =?utf-8?B?U3JLWlh6VUs3TkhnVXh4SnhlNjY2QklGWjRXTWMzS1AxUTY5SGpyT0hWcCtS?=
 =?utf-8?B?YXlVOHJ5MVYwdWRySUF3MnFyLzU5SU40Vjk1Z1VQVkxIbjNhQlRyNkh3TFh6?=
 =?utf-8?B?MFdTbXZNNEpwdFpqQzhCN1JuQ1ViWFZqWEZFcUF5NmQ1bEJnL2tZa3NpVGJK?=
 =?utf-8?B?NDRSSFRhUXl0c0VINHBZVlFhcTB3WGNENlRXbEd2ZXNKbFA1WC8zcitnS1Av?=
 =?utf-8?B?N3VpbkkydlNnZ3pSenNMZXB1dlhBdzBHMVQ3SEQ3Zm90YnhiQnN2SklsQmlE?=
 =?utf-8?B?S3BzWHpjS2hHTU12NVV0M0ZpamRsSmtSSFFuUWpzL2pRNWxFeGFodk13TUxo?=
 =?utf-8?B?Y0hkQXlRTDdRc0FYWVJvZmtCa0cybmg5bGNPekhacm9ORktsWGxJVE0zQnpB?=
 =?utf-8?B?RXdBZlQ1QklKMmZPU1Q4aUpXWGc0UkREQ3JKd1pZTHFSUlVieU1wTVEwdHJU?=
 =?utf-8?B?TnI2dE1sSjhPSUYvOXhwK1Jod3pGZTNZbEdpUTJlK3ZmQk82TXhpUlNTQjJ0?=
 =?utf-8?B?cUZWeEQ3Nysrc0ZRQVJERW5ITmROa1ZINHdHMDk2d3dKM014d202K2k1RWtE?=
 =?utf-8?B?d2E5angzc3V5a211RzlkckloblNUL1pHRUc5OUswSjFqQjhOMXJzMG1mOHA3?=
 =?utf-8?B?TVBUQTVkN0tqdGxqYlVMNEMyMStNa1RWM0RMYWwyYi94UWd5YVhGTyt5V1hR?=
 =?utf-8?B?VFFEclBiYTkzZ1JYRFFGVERUT1JFRGVYL0Uvd0xrZFV5czVPOXdpU0I3SVp0?=
 =?utf-8?B?WkJiaFNFek1qTDhvVW04ZXNMQ05TT3BremNZdEFuOCtaV1BHMmZ4Ym8yZENk?=
 =?utf-8?B?WktMTW5wN0FMbWlYeVp6NjQ1c3l0cDRRWkJvT0xoeXlzNWMzaUlMSm8wcVdH?=
 =?utf-8?B?SGJBUUhVZE1lQ2JqRWg4Qm04WklXSWJqeThqVnJiMjBnZjBmQm1xMFpZTHUy?=
 =?utf-8?B?UmVscFR0WkIxWThzZm44TTJZVTNQWWt6ZXZ3TTQrNDdybE0wLy9vQzBzWXJH?=
 =?utf-8?B?RlpuVjBSNHIvMEVzV2tBaWhHZU5jM0IyKzZTV2JabzRvL2QzeWtsdHE5bytX?=
 =?utf-8?B?WGNDZXNydjMyZm9Ud1JtRkNSdGt4dlErY1doeEdaTXBYMmlqN0tvVUhZb0xw?=
 =?utf-8?B?a0ljbU1ZR3drRzhaMTBpdWdCVWVxb1VCTkxad0NjMTF2T3d0c2QzWHhtb01j?=
 =?utf-8?B?dENEQkRuSW1nK2RiWGNOVDA3cFprdlVpdzZPTFc3a1VRVm9FTkltZU1uVVN3?=
 =?utf-8?B?MVpwYmNHbFdrMCs1STlFMDFuNXpWdUZaRW00Y0ZDTHhiZEQ5QzJsNnVXM0lt?=
 =?utf-8?B?bXR3eGVYb0duaFhKRmpJc3hVRnFIVzBuU24xQmhlRVhYbEZTeXNHNy9DNk1M?=
 =?utf-8?Q?UkWHycfN7INId+w8xLbh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57cae31-fcdb-4ecf-c60c-08dc5e716694
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 00:00:32.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1455


On 2024/4/17 0:44, Conor Dooley wrote:
> On Tue, Apr 16, 2024 at 05:50:37PM +0800, Chen Wang wrote:
[......]
>> +    anyOf:
>> +      - minItems: 1
>> +        items:
>> +          - description: core clock
>> +          - description: bus clock for optional
>> +          - description: axi clock for rockchip specified
>> +          - description: block clock for rockchip specified
>> +          - description: timer clock for rockchip specified
>> +
>> +      - minItems: 1
> I don't think this minItems is needed, this is for one device which has
> all 3, no?
Yes, SG2042 requires all the 3 clocks presented,  I will remove this 
minItems.
> I also think this combination should only be permitted for the sg2042,
> since it is not valid for the existing devices.
Yes, I will add condition to allow this combination only for sg2042, 
thanks.
> Cheers,
> Conor.

[......]


