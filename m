Return-Path: <linux-kernel+bounces-139998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24598A0A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B81285FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA213E413;
	Thu, 11 Apr 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qWSEX+77"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2081.outbound.protection.outlook.com [40.92.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8A13E051;
	Thu, 11 Apr 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821123; cv=fail; b=WDoqXRUsUwGKDOG3OH4A9WJudEWI48j3bT/D2WOmoYpB8GHFj/kcDQfsZSiVEBRNiiXTvTv/tWqMZKaLiE+JG7zoBPxrVtnuqqu4ArZSCbAIvYoSyqdbxd4sYZ/LKGrvlW3SjlCwzJb377SMxUdExN4fXBsySeOtF40pcA48ons=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821123; c=relaxed/simple;
	bh=VZjcUvfqSrsUxAejDXbi43M9YbfSdAkT3wTyesH36T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Em7NaOH+QuA2eUcx1KEGD03aoY0DbixWSiNBEErOOKL6y64JEoyXI5bzENDUornyVUwBULpHqpiKzM0G5MF3OGhuPzJPkInj1NSw0J1AuFfuS+jNPg1EOB0TMeNaJltat7JBDxUBu/FE82BvBBE7JmDBZveUXIKF4yLvDgHqfQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qWSEX+77; arc=fail smtp.client-ip=40.92.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n33ped5ohpkz4oo5OhWyrwRlVEiAeUzVPVWNFBVKBAGUTj9lifMRNNFZW/fzlMdbYoXXIEp5qk8U9WiDZkYH7Hk1iHnoo6CfKwcyOfUErsw952xuOCQ+aG06/cuwaB+0KJka8LLyYwWJcHuGupiNwRSPuUXuqGG5s0Asr3SankcTnG9LflwQBCyiwJY+7WkQ7SFEB61fHTjJlEK0KctdHYOTbioF7pfuGNhjb8xI2wjHm3u2pwPyqsUqbZggLM78HBpjRWBCChCrnce3f1dWxdZUVmS6eWy4LMS2HT66F2Aduck3dlTJyyzH2Zns3RJXB27IET8XBv7Mo7szHbXS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEQqN+W+wKuKybelqNiTnJZCWU0PpTbjgDYNvqxYRCs=;
 b=ZgY4l5kefGqTPftFKykN+Yw+g6tnJ3ObaPou0rHl3rSsi8hf71CMViQkVdWr9XB5YDw+LHwlRin3FsaG4/68ngNV4vnduQIfqt3skqRjTPs8HQYY2NFGUqwaDE8SyaGV/NJz2CuCBoTtfjo48smLRzUqbuK0Oc+iOZhnOlhgGINVGjIoEf5iP6NbBQlOIgsubBIucgwoxrN7tr0ptBfiRSYoly39ZH0gtbZy6GAVhe1ZKHSZMW0Uwl5BkTwo8VrWdBII+YMKH7ZEY+iSB325q6K7lqNjx96azk7DBXQOjPALwlUrGPjcfxhwTNoPtJ67b+aYzUyi8ro/6EcPSZJKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEQqN+W+wKuKybelqNiTnJZCWU0PpTbjgDYNvqxYRCs=;
 b=qWSEX+77gjB6mRcU9HNIRauybXS8+iBsH/tZ5wh9/e8ZdwGBqQfrV5+QuAg/RbAWMJa0iipDJJOEsce+2p7Yxc8RKTc2H5BrFAwVjtUp2au7Oh/N62yVU+hv67LFMyUBSzASRYwOlcj8wsmLWFn9F2hZAJxiJD/EeRfyxS1FgCUV9ZkKOzuUAsmljiwX7rHZ+exjqKCERtnLCP2iuHMnxIgi+9uVO3XuunUG6RU9uOOt7Q0kv7AlJwvANLhgol3C6uK/2zjbyoI3sswHnTdzSZuPp/ZnKPl2+aXUQgkiICUDVKNSIEHDTFe4Qx1AIZs13FOUiM6ek5SezSvOAEaUXA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH7PR20MB5308.namprd20.prod.outlook.com (2603:10b6:510:1ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 07:38:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 07:38:36 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: (subset) [PATCH v9 0/6] riscv: sophgo: add clock support for Sophgo CV1800/SG2000 SoCs
Date: Thu, 11 Apr 2024 15:38:53 +0800
Message-ID:
 <IA1PR20MB4953E5E78F930EE25A86EE1CBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [iDtaGmXGwD/g9EANelqzXZc6pF8UbrUjRKGkiBcA1ns=]
X-ClientProxiedBy: TYWPR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::14) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <171282109234.564827.16346291400943800204.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH7PR20MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 467fae24-5bed-4ab3-e657-08dc59fa64da
X-MS-Exchange-SLBlob-MailProps:
	ymJijV9pwJm+jY4Q11pAguX0vq6mPxhXIgrpc7SQiJT9YZkbhQJ5aHyogEsH3iMpBbkF3jw+LwZa/NUQMOQYlYj0M6UCteUSubOjP992e5LfphLHKlxhhSlN4tzmSk9HE37jIqVzDgjYZNCA+3pipxukj+8Fk/DUAqnchD/Blh5enseCcgSsspEAjSZU9jyoEdPf/RpMB+N22q+hloze1bwhVbo8rEmCKZ3oBR9t2Y/x7MfJDSlcWaWHLD4f6GwMfEPZUs8Xp3U3T0yV9mCr4mlgI7FfKEnrrVibHURDhXlI4f3LvXRHDt0LetBoP25qBdNERzI9yG0vyIFo+rTBgC1y9TTmrif5uIoql/qZEIQSQU1EkBEOQdi/a5hZVBua7VpKB8x2NsSvg3vTWEVtLsrkZZ65aPsaCCit6s1IVyh2MnrbHh4gkT/s0KfEUq8rMmzcvdnsn23mmV8PMoid/tmT1uY+CNRtazRpN8AIDrG7zFLOmuuPoYalrF9o/SELZA7kioRr+10E8Tui7jSlrArcAVl4aLMs2YYg3P7zI3XoMCAVlbSo944/RDh6fa9AngWcz4q1yfhY0DUpgZpywlhCBWuNVUg5CO3eybpk0rzZt13aHigIVU++MehKqlp4Es+cBN5rk6LXZ5jjyPNtG3G7b0yxdwKxAhb2EgC/LSE8bCQB2C/HkBnF4kCOiBPf1j++rsIdHjYNrc0i7BEJ1jjVjHKjxAC/8VTMjFBi5t2gOes8bmLkGC6CxY/13ZUhrlDWPpfDcrOn9hSxVudUTYSMlLi2Ql4nNfxmdP2Yiga/HK9Q++OLF7eB4On5K90r
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qs5wmL5YaVfmncpW98DQam8SuxW/sphW15/lw+6HNtM3NVb4YoDy+nTfVx/Xr9duS3zFSwzBWSowxTpuQqTTiCdFZGmwVsfyhIBnXJWFH8EsuAIJGaPy1fSmoUO5Ou+lTog24MwZi8bIVcRqvXpG3ac/t64iSC1PbgwN3L72+ibE4E7MHIhtcOgaB9nh30nLJJA+FQRhmkUQGNuLp89SJD5gq04JFN4jnKXO88SdNLVJTzl38g2rL6QD7n/nmzvlZ3aN4CC//wzgO7ztOpTB6wM1m2J4GlSZcUZjw2S9dLQVVjhcx390B3T7TXQ4XyjyunT0IpMGVNgleZApi6yfZ2nrKWnebNqEd0JI20VCnpRxlt2pExzDkZd6AcofTxLkDZwTnePlr7xJCPYoyHZy6mtREn8Q68n/hXUjOS6xPA1bE+JyC9aNbNUyeU3Z2iEn/1WE4ZQDutcOyK6oKKhAFsAjCy6iDm2DzibVdO9eOB0SgeGzCXOQJZMhAxFytj4Dfd2Wj62VX+aYJM1lxJLuaxFgyRf73eQVilk9eNuzrr4HlR7ouuWmRGSsmDpvPMZbfndp6yfC60DuW/DeaCbQuB3PEmvpn9kI2ffSL56xch3xhoRQzHzEjX2JWUF+TmWkipnVO1KXvMgq+OMXRO1vFT9PyB9EBgeRKrmYYjSVjg+j3rzF+J6s38YjJue9yn4uJ8ep4JS7fKAHdZ2aeNmFQA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUM4VEF5YlEvc1dDSGRYdXE0RHAvdUs0Mk9uY3p2MTdzWGRwUTNJVGFsM3ll?=
 =?utf-8?B?bDJacGlpNGd1YjA0dmw0VVVLaEFkUGswQWdSVm10TDBSWXd6ZWtOS2txM1pL?=
 =?utf-8?B?eGZ1bWMyMGFoQ0JHRVhtZ2hRRklscGM2UTVaTmx3eXlmU0ZrQ0xoUVBMWmhl?=
 =?utf-8?B?a2E1ZElFanQyMCsrcXA4bGcySzRQNS9rbUlBVU9mT25lZHRjTE1CTFlKQjRz?=
 =?utf-8?B?WWVhVlNXMVc0dTRaZ0svK0pyNWY3Q1lnUWJ3RkhiL1BITzhxeTVNVExMQlMr?=
 =?utf-8?B?NURRdUM3RnpRNlc2QTdBWTd3Zlh5VWFyTzhHNWx4VnIrUWVNczhIYkI4Z05u?=
 =?utf-8?B?OW8ydFNuR0tXMzBzQzZseGN5VTBqYkN4d1VyVXR2bXBINldqTGRFYjQzL21M?=
 =?utf-8?B?anp2WkxuL1JLcFY5bjNBRzJseGRxK1FCeDBteldyTG1oUlVhTFZFdFZUYU5s?=
 =?utf-8?B?MllCUUczTzhSRUxvWmk4OEpDVGF4N3pRUlcwQUJIVkRaU29BL3d1RnVtRmlq?=
 =?utf-8?B?cHJ6SnE1R3l0MGVWQVFsYnBJdk1Vb2pmV2xqWnhvVUVPaU1qNktZdDFQK3cv?=
 =?utf-8?B?dXZSckxXbW5YSytIeUw1eHd1SG1WWWpTTFRySTliUHd4MDRwTU9Qeld4amFm?=
 =?utf-8?B?SDRhWXNKWGVWbG50Q1lUWjBmdHNFLzI2N090VWZ1VzlvUjZnV3BseGlCV1cr?=
 =?utf-8?B?QldRcXdMQmkrRk11M1MwalZXeEx1NFkwY05KV2xXUGJLSlFzRHVsRm5Ra3FK?=
 =?utf-8?B?TFlhMTdzMDBaUWZ4WE5qeXJBVEZOK3ZObDJ1R0JBTGRxRWp6LzF6ekpHYWkz?=
 =?utf-8?B?NlgxUXgrUXVNb1poOU9RYmVlRzkyWHRmU3BRaDlVcjR6enBqKzRpOGVVay9B?=
 =?utf-8?B?SmhXWEhrQzRmbVkzY0Y0WUVhU1NnNTZGWUdyUUs0ai9iUkNFMnUzT1Vyd2V2?=
 =?utf-8?B?TDJRRXpQZUJicXZldk5KQTdFRmVBZ1dyWk1yQ21nU2xjYjk4cmNKKzZLVGRh?=
 =?utf-8?B?NjQ2aGZ6U3IycnBkblNkUTNwY0NxT3czQzJNejFqYXE4dWc3eGNSNGxSb2N6?=
 =?utf-8?B?TzhqeDhlY3N0cDNyMnZwOTU3MUdieFpBUmV3WDBwYkFOVGhIUExPMTQwUDNj?=
 =?utf-8?B?NFV1KzBhaUZOaTNjRDQ0UndsSGZXZ0ZPTWR0cXN5U3hWTGxxZzk0VGN0RHZF?=
 =?utf-8?B?MGpGTnVqd2FISzdVUWtVdEdiV3JTakdRTWcxOGZ1VWtsUDE5aHhHdlhFTS9R?=
 =?utf-8?B?REV2MGYvRG1nMkRJM1FRbHJFMHpWM0ptV1NpTmNMT0taMkRFTldsaDcyb1FV?=
 =?utf-8?B?M0tVdkRYTWp6Q0tHY1QvM3dEYnhKY0x5WXN2VVFBczh5RUtRcTlPUlRIRXlo?=
 =?utf-8?B?aUdwVkxmTCtLL2JEZFdFQTROUWhBY2crV2E5NkozYzFiYndhZ202ODkraThI?=
 =?utf-8?B?ZjZxYUJRK1EzSjgxcFhQVXlmQ3phVHAyOWlMU2UzR0ovT2RXby9QLzZuSjhv?=
 =?utf-8?B?dTFLaW9Ya1orWmtaTDdqdmQwbVhKeFhLTVBoSmJsRllkSTJoUk0zeDUxSGlj?=
 =?utf-8?B?VlVZa3ZZTUIyRXRFYXR1UTlhUWI1K0FTQjZlSkZHaW1PYWxHczcybEJrOEth?=
 =?utf-8?B?Mm94Nk9USDBLQUNCNnFreWpTNTVXUkllN1hZZTBsNG1RaUpYNGlKNWg0Nnp3?=
 =?utf-8?Q?/Srgtl4aNOLY1jSK59v4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467fae24-5bed-4ab3-e657-08dc59fa64da
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 07:38:35.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR20MB5308

On Sat, 9 Mar 2024 17:01:21 +0800, Inochi Amaoto wrote:
> Add clock controller support for the Sophgo CV1800B, CV1812H and SG2000.
> 
> Changed from v8:
> 1. improve code.
> 2. remove default config in Kconfig.
> 3. merge patch 2-4 of v8 into one.
> 
> [...]

Applied to sophgo/for-next, thanks!

[5/6] riscv: dts: sophgo: add clock generator for Sophgo CV1800 series SoC
      https://github.com/sophgo/linux/commit/bb7b3419627eb34f3466022d1f4b3c942c09712d
[6/6] riscv: dts: sophgo: add uart clock for Sophgo CV1800 series SoC
      https://github.com/sophgo/linux/commit/18e8c6d2cced6c57d62813f49b57eeb8ee02f984

Thanks,
Inochi


