Return-Path: <linux-kernel+bounces-69810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D78858ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1B82821C2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DE655C36;
	Sat, 17 Feb 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ptSS6jaU"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2082.outbound.protection.outlook.com [40.92.52.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA854F9D;
	Sat, 17 Feb 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167304; cv=fail; b=f7ComsWpZG/LRhzX0dsmmrLFydVunx26EoZfX/3WuFy/humU3q/kQYS+w3CJoud04UanJyTTyn1Q/qZ6vEVT5uU8orJ7CwB8tsH133OGkfTojaxbXNE3km8qarS2FkCJo465yrq1kaFRNuDr6oH3Xucev+J7Tuf2ZzynLmTGVzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167304; c=relaxed/simple;
	bh=s+fs2toF5ydGuZi4ZrJO8t0VlRUkWNDNASFhajJNVII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7Pvx0uuksLK5+P89SbQXaG685ZNi6533CAe8CdR/0RPTmfcIiiGTXH2cBy6AVCSD7bMMcdtdTg7C89TFbI0O2wTRiTjkt6LRUPHJRVN4Ev4IiqWidqWcE+Xe3ivqqEdC1lbDXpXi8+1DJI3mSPSpJ8heRrC06BE4uwdt6N490Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ptSS6jaU; arc=fail smtp.client-ip=40.92.52.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIUk6WyP7AW+g5NXPtIDjikkdv8ALa+wh5OZYtw7RfgTMJkRKxsjWZtNAKPRgVhfu5xLG2EoKk05InRrJapDkhLDaiesJgP0Jf8cD3XDunE6lJWVQocfubXkFajxeNe+GywNmd/F++BSSlYy6y/miRSeOTcfBiO0VlrJRpkvK0gddhkJmM2y40GDfg9yWEpsTpGd8SsY7MxJ+tXRm3U876Shdmg1/BRZ8zfenikp5P8G+pn0i+EhxYFXZ5/ymK6O3y0ZUu4haoXKqJ4CKtYt2fzCX5rpc9hChXo8zOFFgQpQEy4n8eQk6KrO1Ny7O3GK6OrkjlTwd/2YRAJ999+w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=006XMk2+JqPsh4jUaxhbYljxwjoQO/qVRZkWLQqI11I=;
 b=aBYbo6Yj1X68JRtJSAKCwlfBxK3Gan9p9yO0C1zpZB4Nor2zOGOOEzA17bUwJQ7U/7JbPHQyhslGZtz9GG5Y+bkjwzJtfAaFacmdSh2HdrzTU0UWjMujKUVLJ+X62S2mq6pZLhJWQqRG39IXuOAGAO43fJEmDVt9B9o8oUOv2m/Mv+hhAunolR6WMhVBVsj4/AzOqIxmwdTUUUy6J+WiQp7qGwGEfS3d5DWncNyQ5njSUq9DS4EIAWI1Hc8acVXTXbYlBICuNXx7h+0xvWOtXLcjgu6tw9Y3rdv4bubmLXwo+MJqEGecCM3HwHhgA7VzTo0y8nPMVUifkxRVycopRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=006XMk2+JqPsh4jUaxhbYljxwjoQO/qVRZkWLQqI11I=;
 b=ptSS6jaUUHs+bS4gRqTzs8yQqmRURM8M7SCvo+iioau9oHcubOrw3S5GuncwsDK3661qOS1bpEDTktWA0TsP4KJoCdiwCUwJZK1MO8U0OljYLBn+gh/ruqjFaGZaTkOe5Q3DQihYanLOJ5HRR57WKkbwvNh63glRQ4ipAW2lhGwPdgRcBzKoIvbmkrH4XsqipzJHQCCQcLVqGYrRIEU9oCviegJUYeXTCxS/SmacCs6nx22iogRC7fTsB+CVCMW5o1A8QTcyRyAaTOEpRtISMVydtns24zUpy0e6LHc6tK7SiC9A/Ld31gw52CXvhmH+gmi8Jkf3CSzPw6P6YtKH9A==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB4015.apcprd06.prod.outlook.com (2603:1096:400:28::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Sat, 17 Feb
 2024 10:54:57 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 10:54:57 +0000
Message-ID:
 <SEZPR06MB695983231D04A2E1947AF61896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Sat, 17 Feb 2024 18:54:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] dt-binding: phy: hisi-inno-usb2: convert to YAML
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
 <20240216-inno-phy-v1-1-1ab912f0533f@outlook.com>
 <63b3eff6-49eb-46f3-a6d9-878eddf6de53@linaro.org>
 <SEZPR06MB69593B898A42192D134B01A896532@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <dfecd473-dcc1-4977-901d-6c7bb615bc97@linaro.org>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <dfecd473-dcc1-4977-901d-6c7bb615bc97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:
 [IqiqGNqid1tLkGOdQaN89cEQ+BVwRyXWxYGJWuFu39eBYuhhmOCnso1iRMEoOhw8TFh7fGiPPK0=]
X-ClientProxiedBy: TYAPR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::20) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID:
 <23cbbf47-6234-4883-9660-15a667ac725f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB4015:EE_
X-MS-Office365-Filtering-Correlation-Id: b170a110-85f4-404d-fc6f-08dc2fa6e16c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mnC3LzyfC8RN6UcZpQih9Oac3G8F+bKOaXAqZqTrdsvFbnzrWuPe8Pmf0DwW56X4Z3ccKqJVb4C1JvoAz1tx3JeVhK8VBHD6BWrf5lQEj9Ls2I7AMglYHxCFgwAPk9qXOZUQps0urXQiZBE0tAbFwS6QuvKXBuauV8tGslKFccjWokOWpQHhztOxFV2vajrJn66LzQFoF1DVkikzkEUM59EDAfHxW03udOLC3bwu52VBvIIemS4fk2YUIPjg0Fvu6myVFjZDD/jC8Sxv1jVoSZsMbUVEr2Mw+L6GLVhxMGsij90fU4FSsmBXHz4pElXd/qUIn8X0TENSAUIcGZD3tIpAiVaevTOEJaD9D3ZUfIGx7ERXOTrAExr6bOKKTakBHO91ebd1rQy6o9Pw4Xx+kqDZ35u2XU/XLXpHYqnzLkEpWZYKCNuupFpv7GMIH5o28F9S+KY1uvmsXUC/9CUqHUMmnkkYKblfk6pgUtdXxCvbsM2EVUX1TkMQg0AfcB7zBmnSANPlEUvUyCvGDO2/g5238yozXxRkzwqB5487kc611WhqIgm8KuA0kaQSUl+I
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2doS1hqU2t5bnR4eWNXalBtMGlKWmVFVjVZdkJUbkg3T2huZU9nWTBORHNq?=
 =?utf-8?B?aU9ZZGFTYmlhTTdsTzhqQ0RxT1RxWFVxd3VGQTRpOVFydC8zaXZIVWRiN1ow?=
 =?utf-8?B?WnhCbVpvU0duNGhMVVVDdFJpOHVGblhKWmpRZ2VybHlKYkc1V1Y3U2FtUlRS?=
 =?utf-8?B?SUNsYXJsU2UxbDEyTzA1OXcrdFZqZ2c3SGdTK3VCYThuTXFsMzU3SDhFUWQ1?=
 =?utf-8?B?K3pON0dmeWlzc3ZrVklYblVJcjBuS3gxNjBEYTBXSE9XazFYK01oYW0rKzA5?=
 =?utf-8?B?SjlKNGFBUVlsWVMyWE1vTlZvaXZjd3ZBb1FlUTVPaEM4dHU1d3hvSnNkQ2ds?=
 =?utf-8?B?RmJiY3pyK0FoTjZmT1A4MzlWbi9Tc3lOZldrSWJyNXhXU09IbTdWeXlHNUN5?=
 =?utf-8?B?R1k1WC9CbWFSQ1ZVd0VDTlRUTEFlSDIxblRvTlJuU2RuaTI3d0RyL20rbHh4?=
 =?utf-8?B?TVZqd3Mzcy8xYWY0dUR0eCtOc2ZHTE9zaTI5RDF4eW05ZFRIWWUrTHova2E2?=
 =?utf-8?B?dlk4bWdLQStvUkNEMkkwaU0vaXRiTjQ4ZlU3ZkRpR3BPV0pYeU1YQzVIU1o2?=
 =?utf-8?B?R096SWpYSGM4THRHMTlMUWNwVGZHR0FOTjNSMENQY2Nqc3Nxd3Z2L1A0aUxJ?=
 =?utf-8?B?R2hPbEp3UlUyc0RpeGt1RFZaYm93azF3aGNPRmlEZFlIM1RiaXA2Mjg2WkQr?=
 =?utf-8?B?NXM2ZVZwNkZTYVB5UENmcGpHT3Iyb2VseWx2b0VaOFhOdWMwWFZockxVbUJp?=
 =?utf-8?B?U05EKzdFcXRnNjNZTHdUc2tYdUxmejZ6SnFpdTJjV1YrSHR0NDR2QXk2SXVQ?=
 =?utf-8?B?TmV6dUs5djBOaEtXamUzVWwrcE04eHV5R1YvLzVadHJYQXA2SDdZQVg0enQr?=
 =?utf-8?B?eUZSOU03dVZTSkk1bGpRMXh6a2VHZTRxZzUyQS9ER1p0NWJVVmVoWG5HWkNR?=
 =?utf-8?B?dkFzQlRSOFZoVDNXSUFIeS9DV3BOVksySHFNVHBMamVGUGFacTI3ckxTSU8v?=
 =?utf-8?B?d0JGd0lNU0QrMW5McC9KWjYveG95M2lHanJUb3NKYitxb1lYZkRpM29RRlpy?=
 =?utf-8?B?YmJkU1hlSUdqZEppRjhXdUl2ejI1SmRidzN1THlRaXV1OEFXSmhwdmFGaWs1?=
 =?utf-8?B?UFJmUjlGOHZMNWxyeTV6SGV5VENVVjVQajNGRE1Tc0t3N2Z2dGo1UjJwdlBp?=
 =?utf-8?B?QnpqZEo4em5vR0tDb0p0eFJkdTlrZG50QWNMU1RXQmJab2hka3JUcjVOZEd4?=
 =?utf-8?B?QU1YakQycWdrUzNZYXl2cElqdmdNMFBJNjgvVlJrUnFiZzJkaUtDNnhPNWRC?=
 =?utf-8?B?MUNOZ2UvR3QrRWZLN0V4amRjRjJiWTZZOG9SZlBLMDk2RTlJZ09WWkZzTmt6?=
 =?utf-8?B?T0szR0k0SmFIYjdLZkx6dkU5TzkwUmFaQnNnb3FDRDg3bTJGdisxbU5qZ2Jv?=
 =?utf-8?B?L040UkJ4WWZQNXllbjRFZ1kvYmg4TlhGY3dUWHlpQTdOTjlDY05YdERiNUxT?=
 =?utf-8?B?TytpaUNxU2FhR0laemRtTXRwWTgzS1hYUFc5ejh4SFNuVlQ1YSs4RWd4Tk9Q?=
 =?utf-8?B?eG1SSUhtQUxPR1hpclM1OGdRb3VOR0MxRzlrc2xIZkM4VzRBQmMzVTJuaERE?=
 =?utf-8?B?VHd5ZFVmV1FOVktJdXF2ajg3bTBKSUlPWnNDMDRtZjZGUS9wa3N4UkdPT1NF?=
 =?utf-8?B?WklmanlQQndyanlIbjMvS0NldHlwUG50WkphbGhaVGFYQ2VzanhFSXdiTkIz?=
 =?utf-8?Q?jUiCErj9dUDk+FGeySDmHKnjiSwUWSoRa1Wu49m?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b170a110-85f4-404d-fc6f-08dc2fa6e16c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 10:54:57.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4015

On 2/17/2024 6:29 PM, Krzysztof Kozlowski wrote:
> On 17/02/2024 11:24, Yang Xiwen wrote:
>
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/clock/histb-clock.h>
>>>> +
>>>> +    peripheral-controller@8a20000 {
>>>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>>>> +        reg = <0x8a20000 0x1000>;
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <1>;
>>>> +        ranges = <0x0 0x8a20000 0x1000>;
>>> Drop the node, not related to this binding. If this binding is supposed
>>> to be part of other device in case of MFD devices or some tightly
>>> coupled ones, then could be included in the example there.
>> For CV200, this binding is supposed to be always inside the perictrl
>> device. The PHY address space are accessed from a bus implemented by
>> perictrl.
> Every node is supposes to be somewhere in something, so with this logic
> you would start from soc@. What's wrong in putting it in parent schema?

When the ports reg property only has an dummy address (no size), it must 
be inside the perictrl node, accessed from the bus implemented by perictrl.

But when the ports has its own MMIO address space (mv200), it should be 
located under a simple-bus node instead.

So it's either:

perictrl@8a20000 {

     usb2-phy@120: {

         reg = <0x120 0x4>; // this is the register that controls writes 
and reads to the phy, implemented by perictrl. (just like SPI/I2C)

         phy@0: {

             reg = <0>; // the reg is used as an index

         };

     };

};

or:

soc@0 {

     usb2-phy@f9865000 { // MMIO

         reg = <0xf9865000 0x1000>

         port0@0 {

             reg = <0x0 0x400>; // used as MMIO address space

         };

     };

};

So here is why i include perictrl node in the example. If the ports are 
not mmio, the phy must be under a perictrl node. Or if the ports has its 
own address space, it should not be under a perictrl node, but rather an 
simple-bus node.

>
> Best regards,
> Krzysztof
>

-- 
Regards,
Yang Xiwen


