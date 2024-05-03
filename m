Return-Path: <linux-kernel+bounces-167168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6B8BA52A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB05B2293C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366AC14277;
	Fri,  3 May 2024 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KnOLduno"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2047.outbound.protection.outlook.com [40.92.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29312B89;
	Fri,  3 May 2024 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702103; cv=fail; b=BD+e8FBFrPdjLEgsI5j88k6WBelWp16AFuSTchs5sJixHEjc8Xm//eVHWymhAdOVR2jeXo16CrpJRuzyWoDk+HHKM7XwvhqLBYUhE0XJHfYjqhBDRt54BWHf+iZNHIZJsjQAPKRrsVuye+O0xor5yktgqzSc+wx4b4RRZILeQLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702103; c=relaxed/simple;
	bh=LPUT/3K/ZlKFpo1EPXVnXZXjmqnZW/xdhKY2Gx5otog=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hx11JHyHsQKn0IaAK0cFq3g442sHJA35mHUfY1viN01stY6hABQgw4zyDO6niGgAnnpFqJjdptWSprTN27wRmSFbgaUYBEmrjkMCQMpC+EeA43FZJKHFXZv5nfiJZo1etPJbRtcCLUErKf2ZlThUWtfCtNkutdWfbI/nhs+58Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KnOLduno; arc=fail smtp.client-ip=40.92.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO2CgsBMKVZRtcuD+E4X70yopjOo8MpAhrW61lwWSYHl7dg0fd6WkeFkF0ewwtKSVef2AnYXWeE0PfAKfXX4jSeYK5OQ24i3I2FaW578FX5ZMFK9EEV/Y4+LsyPAnyih63AKd3uAXGvn6eC4nnLs+4YdO3tTSs7OPO8Z76ZHsxRscUYsuxIXE+iFWpM2Ixa9CL0PNf1YImAMmNs+Hp4jLt1kfIqYqB2rIkcBvhw8MV+oEi7IKnFalnfDtokDpd43/15JKJwEZN68d6oRbkpKVBkso3iNGbzeujAqXeUCj327ano2CkzstDZFbeHvk2M0/QeiSQDz5j6cS0UEAj6ZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KqeIxjMWYA3fUINUIfyDkstw4tqGlltz4Js6LflWiY=;
 b=IOnzlAxJgus+KtlVVj1TzuDYIiF8MlRiaTEj4y1zrv8t01lWC72RUAqAgW/T0PDjUDJ3xnibgtxTonhqVJkXfOLltpaZrzdx4Ho6lJJGWLGE6gbI3N6zHG5WUfWZuFUMPIHY6neTTMREBql8v1wrSD8C9rWFgPOm269hWeVt7bO15Zo0dAtlVXLAuszaKt+iRXLKsEAYocd6u1ejE73J/mExLtW+qAjq8jgirX1RDamM7aLXj24oQHk4x3tNb0eEmQT1fsu/YovAlfhOAcvDI3xTItELnybEJ+5fNVoGAyW8almnwcFXO/FZ2OOSr1Qq3JLws2oBh7ZHvocC/RuBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KqeIxjMWYA3fUINUIfyDkstw4tqGlltz4Js6LflWiY=;
 b=KnOLdunouPhCYqZ+Rui9Il57X1eKR5I4c9imwDOxPcfTnqgHL68JErBseU/tdg/zD0VUuAAgTOM/o/z47IqCtVAaWc+BRB+IrM8h+Z8H3xHtyTlwWfOSJ47C4IE1UO01ud59V6k+MWhk3daHYV0XVO3bGGPsDCIiIxvU5pmrcWIetKr/Dqz8HiqMqsXDoh+Bj5R0kj1bhNnqohctu2yklIsmqV81c7JzEiy3WCy85JenBi6aL19VaF40NfT+sAO3ZidMXAlzLbixnjqFmS3X1zfr9en9iXN+KdKsvG7PlKwBJLzwBDvep/EDuFdE9vqz5sIuM5ntHLEaQDfY6XJfcw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB0025.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:8f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 02:08:15 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::664:2ecc:c36:1f2c%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 02:08:14 +0000
Message-ID:
 <MA0P287MB2822AE8021C7ED48BD9A6D12FE1F2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 3 May 2024 10:08:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] riscv: sophgo: add USB phy support for CV18XX
 series
To: Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB4953182B8EDB465430289400BB1B2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [jQ0SIiVbP2pdm/JmQrX62+5zU0Wr37OU]
X-ClientProxiedBy: TYCP286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::13) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <b30c9612-614f-4c63-8ed5-735d389525e1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB0025:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7f11bd-b4be-40e7-345c-08dc6b15e323
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info:
	6sqAT3BsHVc7ELVuJn9PqMbuB27/sEO5PiVmybLJzlCdCfCNEl8fovRz3goiqB+A3UevXU2XfS6p0Ygz0uBdZzt4h+4GJmF7aW1I6ubzWNYLibbqW0GxiA5+MxZlOsvkq9g+Tq4pn8bguHBfchcMPtYD+WR5IvDEkvxvb6hHLa1k/ryToSlLmix6asEN4BSU3BuvNhIElUTRRjhcsfbDptQz1dV09GUCtEJWaUQQhSpQD85ptalvJnin9gui5dHdTrBCxJU96QtZLsRF0gnYtzAKOv2VVOPnsXlMCND3QxvR4mNWUNht7VGrPjkkSzBdzA1dFbJql+Ys2jrQ7E81IGZf1sDG4VyXd+PIf9dJ67teX1JeqNHiBIDg2atbRAJsAau4k/S7lyc1GB/YxKU3JRchbrhMAaQPCdErzu+SglZDBLszW3+dN/8LzqE7vhpfd8zYyVk+CFUV1hCI6k2Bai4c0AzkL9u3UsA+ior67HST8Zg2nK8QG13tHBMSk7Adj3jGufF5AeSpLHcz2ykLl0xiCBooJX+gg4YnK6uFRDzeS5ql0cWW0EeSUAuBcxvd
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlNDdVlZeXc0cWo2VnNueHB1eE1UbDVibjhBNTJNNjhqTXZYbmd2K1FENFFB?=
 =?utf-8?B?cWdGVFR5NEZaL29Kak11UFNiVFk3QVFnN0JEbnJBWDU0a3BrMTl3T1VBQ0F2?=
 =?utf-8?B?Vmk4bFlmdXBzYWtXRVRCQjhIWUJxQ2ovMGtoY05vb2IrWW81ek1sS1NRcFph?=
 =?utf-8?B?dEFOTjBGQmxLdDRkSmJFRUw1a2JILzFtWHlJeElIZEFPT0dmdEZWY1lBNzNw?=
 =?utf-8?B?MERFS2gwSWJUUGFtOUpTbzVWM2QrT3ZDdGpxS254UWhvVnhONnRpS2lWWEdl?=
 =?utf-8?B?bHA2WWh4ZHQ0K0VwQTRFNjhQRGxKTTRSS2FnZ1FzMXhhVm1VZVkvOFNCbUhS?=
 =?utf-8?B?MzRKckRrQ0J2NytjNWI2WlBFbS9wSDAzUGNiQlpNdXpqZnYxNlF6RzNTT3J6?=
 =?utf-8?B?STdIMys5RGVGSzhLcFcvZUF0K3c3OWkxMDM5dHFMRFRkU3NaR1cvSkIrZWhP?=
 =?utf-8?B?SFRObmdRdVFBQzkxc1MzQkpIckR2eVEwamh6UEtBb1J5OExYTk41Y1JCRU00?=
 =?utf-8?B?ZWlDbWJ2NEVGaTh5U3h1RU13bXhyRWxkcWN5d1pqOS92ZHVhUHpQRWZxTjlk?=
 =?utf-8?B?QTVOYlJ6b0tXMlpGcmYwUFFIU0d3R2dNdEZUcTNkeFVWNmZHRXBNeHlSWXRu?=
 =?utf-8?B?UmF2VDB4ZGppNW9GVEc0ZG5udHl5VERSNHBZMG9hMDBIanVOQVZvMWVZK2R6?=
 =?utf-8?B?UEwzRFlWamhJVDEwblFHTSsxb29OcGQ2cjMweVVJQWdZQzVyQ2p1R01lMGRt?=
 =?utf-8?B?eWNxczdQZHBmaHNEY25oMDNsenVNaTNia3Q3TkRLbmM3clNrZmxOSHFnYzFJ?=
 =?utf-8?B?dGxsK2dIclJVZmhYQTRJNXdtd3Q3S2RlUGpHZVZuM1N4R2VUeUljdFVIZzR0?=
 =?utf-8?B?cng5QnBaUGw5ZncyL2FqOHNMRWVIZWpTMFdienBNdWxKVTdSUU8yTTFOakQv?=
 =?utf-8?B?a0t4MDNiUjV5dVZzVnhqc0FZSGxXQ3REWDZHRy9paFpPQ2JJUVN2bXRwNHFh?=
 =?utf-8?B?cTg2Q2ZSWU8vb0h1eFRaLzhBSG8rWEhYY3FKTzZLdmZDWGpjRDVRNXMxMnpP?=
 =?utf-8?B?THNWNFdlMlhYWGRubmVxajRpTzRtREV2N1RXRzBuc3VzcEJPeGdPVm9MeWo5?=
 =?utf-8?B?U3N1blYzeG8yb1FXL2hScUdvMnRQbW1sQzdFaC9MWFdLekhXTWFZcFpScDBa?=
 =?utf-8?B?UmhUdWZPVWwra1pGVnBudml1ZUR1RDdMQVpzWXhiVXFUazhvQmpoQXQzMG5V?=
 =?utf-8?B?SVhtT3NNaFRBc25SSHp2N3BKaE9QcjdxeHJyTWVRWmhXblRnb2hJRzg2QVFj?=
 =?utf-8?B?SzMvbnJ3QXBaTmtKMlVWMmFsUDMyN0JidUZEd3JGQWpKUEdWSmtjSTFOMERW?=
 =?utf-8?B?UlhoWkRWNm9ncGxvelQvaVhjclNUN0YycHM5Z1U1MlZrTWR2azJVYmVyd3NP?=
 =?utf-8?B?L04xN1JrT3Zvc1EySWoyRWlmU2JqRlF6UGZWek5qa0t0a3NvYTZSYTdLUVBs?=
 =?utf-8?B?YlFRd2QvL3FpbXZvUkVXa1NwdnlraU8zcGVsV3NYc0x4UnF1SXlZN2hEWjBv?=
 =?utf-8?B?elF5VHM4ckFyM2x1RWhGT0dIL1YyL3hQU0tkTHVpSXZ6SlVoREZkMnZrYVh1?=
 =?utf-8?B?NW5KWCt4YUEraldRNU5DeDMwcUNNMElsWGtsNHVWV1M5SUFpVGcrVkxHdnZz?=
 =?utf-8?Q?IhHv70CVPFu2jZwzmgwS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7f11bd-b4be-40e7-345c-08dc6b15e323
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 02:08:14.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0025

Inochi,

Please also send this patchset to the linux-riscv mailinglist next time.

Thanks,

Chen

On 2024/4/29 8:30, Inochi Amaoto wrote:
> Add USB PHY support for CV18XX/SG200X series
>
> Changed from v1:
> 1. remove dr_mode property and use default mode instead.
> 2. improve the description of `vbus_det-gpios` and `sophgo,switch-gpios`
>
> Inochi Amaoto (2):
>    dt-bindings: phy: Add Sophgo CV1800 USB phy
>    phy: sophgo: Add USB 2.0 PHY driver for Sophgo CV18XX/SG200X
>
>   .../bindings/phy/sophgo,cv1800-usb-phy.yaml   |  68 ++++
>   drivers/phy/Kconfig                           |   1 +
>   drivers/phy/Makefile                          |   1 +
>   drivers/phy/sophgo/Kconfig                    |  19 +
>   drivers/phy/sophgo/Makefile                   |   2 +
>   drivers/phy/sophgo/phy-cv1800-usb.c           | 378 ++++++++++++++++++
>   6 files changed, 469 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/sophgo,cv1800-usb-phy.yaml
>   create mode 100644 drivers/phy/sophgo/Kconfig
>   create mode 100644 drivers/phy/sophgo/Makefile
>   create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c
>
> --
> 2.44.0
>

