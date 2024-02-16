Return-Path: <linux-kernel+bounces-67949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352885737E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282711C22A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2086FBEB;
	Fri, 16 Feb 2024 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sv44SSiK"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2048.outbound.protection.outlook.com [40.92.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1DBF9DF;
	Fri, 16 Feb 2024 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708047530; cv=fail; b=SMGep/1U+XEru1LOFfQxlV2mbmcQNhBNu3vnvXqGq8IoDVq3neoUv1nAzsuj6aZQju9vMlPko+l5UFmgsnY5/a4cuKObwEtguc73vqpQXnn1EkKvHn+0TWLArW1wFbgYX/uOyUM0G4K2KfGGe2/CdsoWFpiOYGS2EInnBvYNE5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708047530; c=relaxed/simple;
	bh=ordsXYuOA2K6dR73ixKhIuM5BAT4LEnfqWBR+mrsiyI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OpkWxEoy63h0y1AQxrgcZKaTwOc0C6BmYJnsec8JDvEp2GgRfs2x44wiAcAp3aRJPGOABbR08yNLNz1b3zSR+c1O/y99+VmLj0v4IGLut+UWys6uBz66xGn+4kWHS1t9MZGvk+DsjLxHNETrQWRip16zdx9WplNh4uC7o+7sHcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sv44SSiK; arc=fail smtp.client-ip=40.92.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCy85m/QQesTLWkUs4KlguK9EV1eMZEvmuE3MTXWxO4GzhekibJ36RNOOHrhcoDN1lTKOGVsdBawGn1WtI4ULk/NhEssLSJ3GkI4RCzrHWJypfYInjJ/cKfpgoWo2gFCE/2oSZo0bDOCT0E/shBXFhtsnPAp0Bffa5QMg6fCDdwy7/c77dV7UvRyrkx33FJ6WA8MPwvkxxrs20r1iYm4v9JGF6Io79zkd5Zv9LIme3Btj4ONhf7a8fQMHEVgHJUFeizXw5ZV/rVsfHLWkNIsGYb5xctyqs3wpD0uOk0YAE7Ofr9WWmavlld0LL7JQiykIP5xRBRMypbKeDGc5CyOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRqoCLF2qSRo7q6DwNV8Ak27VzeZxUtWgTazHqvXcLo=;
 b=amd2pnUT4MXnX+5g6gfvcU6snMh+SK9NhvOPtPKuVxJbp5ZmtRHyjWgp6PheremAH+/iolUkjZLv5YAoUAL1Zgfmr0zUkhyCTldMQvsHZula0l+oxsBPuii1cD8I4SoFWen11WYN3AHvam23iKMketHLDkgGS4ZNRAAE3NJC9kt5I6UEAcpfsz5DeJcSlsgO7kVhJMg08CCqZ4FEuZQBDIotxc8lC8OcbG/gd68QgordZ064oRwNzdCv/LOx6PBv2hNxmPfdWWAvZWGzOAvVcHiSLwN3jc0sNoPKF+h3LIx4ydYu085KcO5B1bvaqymJmOplDUjQFHcG3UP6uCus4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRqoCLF2qSRo7q6DwNV8Ak27VzeZxUtWgTazHqvXcLo=;
 b=sv44SSiKakliIYzicVDLMEOICh73uqfgij1njY6c8W1W2M2UDijoHM2sva6++jT1Qcbc3fwokHdFGtWlWE8HpDOlwkaXAmyT6g4RHJ3Fc82pHrl7p1QyYYhKVYTI8DQyVxlG69u8C5Cq7SPmZJPobsUgN/Id1ztm8dBnkSBViun2EivoJlYfVYqD4aqZ8G3s7V1mIj+kRUwOFdpYbtURWR9bwFiu5GhKy3V+ev/oUcSDXERMvRXfJKMsKFWdpVsJ2EXEhKFOptFYuw3skzo2+BKIcZRcVyBhyPOGKygosCLia8G8k3fL5Ukt7iFI+rnxUYs+OPi8fcm5iAbTmNSHAg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB2600.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:137::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 01:38:41 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::8473:67b4:9a2a:3a69%7]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 01:38:41 +0000
Message-ID:
 <MA0P287MB28223587A81D9C674B5B80B4FE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 16 Feb 2024 09:38:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] reset: simple: add support for Sophgo SG2042
To: Philipp Zabel <p.zabel@pengutronix.de>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com
References: <cover.1706577450.git.unicorn_wang@outlook.com>
 <1cfd7b3ba447942784c4f7aa595e962399e9f617.1706577450.git.unicorn_wang@outlook.com>
 <MA0P287MB2822E03B61DF33B4438833D9FE4D2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <4a1a0b142ca58e1c22ba246991d4ee657a4ee91f.camel@pengutronix.de>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <4a1a0b142ca58e1c22ba246991d4ee657a4ee91f.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [3btn846LVUzC4qqg2FIjQmfZeoeEIoyJ]
X-ClientProxiedBy: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <3f4476a6-61c1-48ef-b041-72ae70579d30@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB2600:EE_
X-MS-Office365-Filtering-Correlation-Id: 198f0178-c316-49cc-f4d0-08dc2e8fffa1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KBz3DsdpvzGJNmTRxtXdxbmo7q4azzS2B0WPMPwPuaPUk7/dRBGVfRFGtVszH77C9GRARqxBD4WD492RYmSOmyeY1ahKg/VvPAM0W5idnsMiWThE5a23QFK0Jcx3snsiSXPJGlbAQrBAh8Id3iyytTGtvjHvSLZ8kL1eod0uGntKg2mMGtSzcoekAtbKD+Zm/GAVxEKfZYVu2p3m454ODN9R9AgQgoRkenwu/FWm9INDYBjU71fPHzDDOAtFflSWltSePLulTwF5ynSnfcPiF7xmEcio2i9x+q0q0tirYOGQ2WuM3dsx2E2KiY+eQzZMu1t9RngBT32x3+8/A2TySk4vuNCYuI5m8MDQsD3uPeP8PP5/v5fEpWgw6I2es8D1qYPXxFEXdHsa95Pk2yAqZevT/VgQERUxTM9kqKvIvliSJXbfkpMI0SSJmiDqFyGAxHvpYKpeSd17d/gMlUaZsOjJXYCVEbbTJXjEhUH6vnvxq3uwnF8JZeNHQATD6ycdxT8R0ex6xmbqgAJClKFQqCdogQaGktnWiNZVcsQRCdZAfPIUIKg1t4aKP6kVKomy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akdXak1UQUkxTktPVlNZSmVTSXBmSFM5M1JBZTZpUUptdGFhRklzMGluLzZo?=
 =?utf-8?B?UHVmVVBFQkxvT0RtWU9Ic0d5VVhtSzRKbEgzTUp3R2FHTmZ1aWVRa3p2R1d2?=
 =?utf-8?B?cHl5V0ZuS28wY0d2Ym5IV04rZjBRcFIxVmczY3luV05ia3BpdDZzNS9vQytw?=
 =?utf-8?B?bnZDenNrTWR0elFJU0JiZVVRbG9nMFV6UjNDMTJuSUJSRlFQY3VzRGNMUEVk?=
 =?utf-8?B?aWx3ZEJ4UmUrVmtWcFNvUWVCa2QwUUI3SUEzWGRXRXRCZXBrQXFPSFMyczJi?=
 =?utf-8?B?aldJSWRwSVBUU3VranIxOEhzR1RXNEZMSTVybjJPUmh4enNCQlh6MC9IOXJ4?=
 =?utf-8?B?Wm5iOGhJelNXaTU3eksrT2xZL0N5ajZGMEVId28yVytuR1hsOTl2Q0c3a2gw?=
 =?utf-8?B?VkE1VUpDWXFFTHJNMGlWQnh2aWlLOGZ4NzNYRTRVTUo0SXE0SVAxU01NYktR?=
 =?utf-8?B?c2J0S0tndDZOSUFZYUhUSERKcDVqMzRyOVErK202MTB4azFQcVcwYjl4NGwy?=
 =?utf-8?B?QjBTdUJIajZpaW1rcHVIZDNwVTZ1L2V5TlZxTC80a1JRbGQ0SkEvTDRYRW1M?=
 =?utf-8?B?RXVkVlZKMDlzcW03QWJUSGR1bk55d1F0U28vakUzYTVzb0FMNjJheFVYVGk3?=
 =?utf-8?B?ekFxaXdoSEh4UU82Ym8xaXVNdkx5am1Nb3JCeml4eTBCRXg2Y2pLbFE5WG1i?=
 =?utf-8?B?U20rczAwcStkQWMrRk1FUS9venNncjR5cWlaUWZWNUI0YStnbEhvaUYxRExa?=
 =?utf-8?B?SWw5K0IzeVBSeDI4c3l1ZXdNbnlOdUh4SEJ3bmc5UmxHdFYvc1ozVDk2ZEFr?=
 =?utf-8?B?YW9rUUFPbDhNdCtJZ1RWa2twa1AyS3BhdWM1V3NUeVpiZmJFZVovbmlSaGVm?=
 =?utf-8?B?V3J2ekpMcWFIc015SkcrKytjNWgvL2dodDBFRStWYkRiWlBPRlBaUUFIVmRk?=
 =?utf-8?B?NTFZMGUyOFJRYndQaFRKbmVjSjZMSFh6SVFrbXExUm5peWFNaUMzSlFzeG0x?=
 =?utf-8?B?Mlo1S0tkUmFZM3pSWVVVMXpqUWtCSTRzSE95aHBERi9BL1d0RVVOYVlQRW1E?=
 =?utf-8?B?SGZkODhHdWRteVN4L3ZoTlNhWFU0bFdCSnEycFltcU56cW83cDN1QXFucUVj?=
 =?utf-8?B?UEI5ZTJpNThSZVMyWDkvc01QNDdWUEdXYW9OSkVadnk4MTE1dFpqMDZMWHZW?=
 =?utf-8?B?NzJFUFNwNUpGS0hiQ1JMWGhlSnlyeWR0OHV0bkdBMm9lQjUrYzZOdFN0MjhX?=
 =?utf-8?B?anJhbEovY0ZHL1lpeGo3Tlk1NUcxNWhlajdJU3F5ZVFBZWFWYjhlbGtHdWg5?=
 =?utf-8?B?NUxXaEcwTlFOOVFtZ25wbWJLdmthL3JtVHYyVThGb2R3MlZnZVd1Rmh4aW1z?=
 =?utf-8?B?aG96UFhqa3NQYXRkWGd6S0dUZlpHRmtHWlB6RGN1eWtUVTdGN3N2MmhwTDVO?=
 =?utf-8?B?aXVUOVpBU1h3VldVMTVjVGM1eUZKQzdlVDRQc3EyWi9MTFZ1Rm8vYTFaT2FE?=
 =?utf-8?B?VnQxVllWNzhxOUFFR2pZNHoweXBLQ0crZmN4L3RvbklITkljOTBRclFBdE5X?=
 =?utf-8?B?U3NzSTdsMHVRd1VnZHMxTW44ekdMNW42RDg2OGYyNTNSZ2ZXd1VpYzkrWnNI?=
 =?utf-8?B?UmtLMzhXUXZtZm1OMG9LSTBxVGpsY0J3eGZWd2VYNnBPeHM1ZHlROFBZNjBl?=
 =?utf-8?Q?LOhT7sY6MerKqzlzVEOP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f0178-c316-49cc-f4d0-08dc2e8fffa1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 01:38:40.1839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2600


On 2024/2/15 20:46, Philipp Zabel wrote:
> Hi Chen,
>
> On Do, 2024-02-15 at 16:59 +0800, Chen Wang wrote:
>> ping ~~~
>>
> [...]
>> hello,  Philipp,
>>
>> Can you please have a look of this, I have fixed the issue you raised in
>> last version, any question please feel free let me know.
>>
>> BTW, will you pick this for v6.9 if it is ok to you.
> Yes, I intend to do this tomorrow.
>
> regards
> Philipp
Thank you Philipp. One more question, when you pick this patch (I mean 
2/4), will you pick the bindings (1/4 of this patchset). I will hanlde 
other patches about dts.

