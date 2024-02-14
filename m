Return-Path: <linux-kernel+bounces-65117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0C7854827
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EAFE1C21597
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570771947D;
	Wed, 14 Feb 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="i/PjkPvQ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CEB18EB0;
	Wed, 14 Feb 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707909724; cv=fail; b=eD1+R3O/dQa3CZZuCrM6NqVnnuSuf2tEXLTAKoTI+YrNdONhg5Kh+jcDg6PqYW6KuOi+tUtR3mOBHdBVZYl4FdEeDrgh4ibl+SNI8gzBqQxJXMoLNdVrEJUFEvf8cs9Kr10xd+1gdoocHLZQmkB+htpmT5gOKxMeRRLUPBhLlow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707909724; c=relaxed/simple;
	bh=FqGSslI0ZwgBhUGWNBRcOIMnVXDTfaDSCoD+3kLf0LQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M+DIBT6LL8Jv6ElTDskO4tz6vRgWn8CBBqEn+1uIQ75QLLauduh0YA/y6zEWdUOIrrSSJUFeGTaApEDkc0AaGZ8QefbB31uKrLOhwNmPp84cWGA7x2u/Tq0iis0umPnY0p2tiC9GUcQz/tX4sjqKscf7Sc4bRhL/M6zE9HqM1jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=i/PjkPvQ; arc=fail smtp.client-ip=40.107.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YovSyJi4rm1UgMz5IdayC9LtOKE95sYqvJH8i06z5e5b1g/KdEb4Hwe1sUg+nk6Cu/jBPjv+FF/cgJPr75JsFGqReoeyTK49ZmhhHibnNWiQl9gMbDvLbjidEfyZtX7wjhzX1oKBS22vUENrh7h09Nij9zl4Hcr4uBrzxEyE2XSStQH04GyRbCC4klfs9NY9mk+sgtjmR1IZrEvrimF8RVAwqUptTcUQCpQ7i3ue4eObaKbZJCVP9x+M+VYeHL7XggawFy86myjY5g8ZCGmJzIcysAu6BQ58b4XiXYjQIXhKyBhtjR+b/KzGQYcERUg5/Pf+tT95oM1G55XSn6wxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PtSN5ESxAqXb6uVbSMtjI8aaIh8/vNJyGGOFE/o+x4=;
 b=MUENn82Ab1emwtSqEof4zRLYlNRv+ERb2x/HS46Zxm1cqWfWLeRqEAWRVOSGHA1CwId8jQi9Is+VA8qlZQsuUyBoPZT9py86OYbmd4CygCZVK9ksULXnJ0AnS/rJqWl/AhUb870T0LHRzbnHQCWvBcElk9tnFSPttqNmkchJ/C1TfUrznkH6ie8fABW5NdhoIybgYSWAG9Yvcb6imy/pOAZg3DPFwC3t/BSjQKf3kBNG0RXnfctemBaimEEQjONKwGNdPMdOqkrhc4xTsT0AGcwtiBJ6v96AiwqMzvCuEGvb+nYydFNzl4U1UpFi29Yit5nALjz9A7nndXB9MDYbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PtSN5ESxAqXb6uVbSMtjI8aaIh8/vNJyGGOFE/o+x4=;
 b=i/PjkPvQChCCjq2d6owOQItwBQfuJZ5pdkMw9iQeofMTOO3khfOSMTtDuAhgwi7vZlxiLeDYK1IUUOKnc0ZyNsKl5E1yQUsm+VORX2cIU9nxnkcdHHnn2FGfYxvZNjODuqhvfZ5hb/OzMhCqHTmLyjtG4PYzThzEddseXLsHNHgdPdtTRWXyIEg0k9IR1KmBDdnmM8cbJwVR/LvHEEkEHqPekry6YaQjNwZ4oXiatvkPdwl8KMsJ3R6DSAbL7y33+EA2ngd3Y4m1Jn0APwTof3BbJvCkIMrobEuru5kx+FIZCgAEOMHbNumoVRIKRyXu098JPN0x07jiDhtMjoRoww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 11:21:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 11:21:55 +0000
Message-ID: <78aac8b5-4ae0-4a0d-9b74-35bf88e3cbf2@siemens.com>
Date: Wed, 14 Feb 2024 12:21:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm64: dts: ti: iot2050: Factor out arduino
 connector bits
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1707463401.git.jan.kiszka@siemens.com>
 <3366367dc9f190c9e21027b9a810886791e99245.1707463401.git.jan.kiszka@siemens.com>
 <4f122f5d-e430-4299-b6c5-bbe778aad736@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4f122f5d-e430-4299-b6c5-bbe778aad736@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d00958b-e953-41e3-3d66-08dc2d4f26c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	colz3LPg53LcDUnFeoY2JHM2/Jf1KxjjFpliOM/N+l+u0MIwPUw/CfDKCudgMs/EEZF7REbrO7YBUc4+pZMkFZ01Iqiz/cUSm9nybDqrci1OpZCHE9dNJ04tkWfU0By10BA8E/xxJCcCajd1AoGN6vsG1GqO0CAqAMI3cjU2sIEMfSfAQP60EmSWYbPFDIBZ8O4xOhyfn6XNqljQMpxbfJPqgZlUmASXFdUE75Y/Aw+il4J22EqpZ2QN5WQu5trnG1KquBTXR+IrFyLWnsX47Vjl8f7Ujv8oeBXts8xBeOJfivzpit1WPukeHmLJ9T0klFuvP4JTse9grXaRAFf+CCKCIVaPFGnju542sYXGSpPlAgMrShjkxU0Io9mwKKyh0EzmjCm2NtYPTGBkv/BOTCrFEZ311olu/zwqLa6MzvEUPXIslzKFWjmqD2CQ7onaYEWo3m9FqxWZ4D6DtmtvGO68i1Ukon4F5cGt9HfnsiB6nh3bxDUPv6vL7sXN53Ozgbq/I12mEXdwyufjjvmrVMU6UEWOE+CZ/NjB7ZbDJ1U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(82960400001)(86362001)(31696002)(38100700002)(478600001)(966005)(6486002)(110136005)(316002)(2616005)(107886003)(6506007)(53546011)(6512007)(26005)(36756003)(31686004)(66946007)(2906002)(5660300002)(4326008)(66476007)(8676002)(66556008)(8936002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2U0MllBQ0pVc1NlNkZiNUEvRnVPOWlNSGl2emV2TjJvakFHajNWdmd1ZHp2?=
 =?utf-8?B?Yk5taXNrOVRQVk9pN0NZc2NPT3F1cHFDRlcxZWVoYi82L1h6K3JnRTI0UFF2?=
 =?utf-8?B?N1V0V0g0bG9sbEZGbU4vWnJ5U2IrTFQ0dHZkM2VXaEtUYVMwWG9tRlQ3bWwx?=
 =?utf-8?B?MjFpaWkzbWR5K21yQlRoUnZhaGFYbFA0MUhwdW1jZkNneEZ5UjlmWVZuaGxa?=
 =?utf-8?B?ajZvRktjU2FHRWdvejRZT0xzbVBvaWlCaUpPMHZGODhEQ3VGU2czMHVrS3k1?=
 =?utf-8?B?djhCMWpmRDA3bXU4SVA5OVN0UTJrRjVRRXhiN0lCWW1tTGZ0VmNjdlAyQUdP?=
 =?utf-8?B?YkNkZlpHSXJzanQzdjF3c2prOFljRFd5OUtlWTA3d2MrTmQ2c0JkNi9HQXEy?=
 =?utf-8?B?ckd0R1c0V2JFUmJGMHFTeHNiZE1xMG1RcEhzOVRDNEtGVWNBVTJTTCtXQUY3?=
 =?utf-8?B?VXd1TzM1S0Y4R1ZBak9mMU1yRFhzaDU3cmVTQ3BhOVRLcnAwSjM4SzNFOFZ6?=
 =?utf-8?B?MHhOcmRjWlBsWWtTZ1h4eFd4cC9ZSFA4L29majFxRk8vLzhRUnZvREY5UGth?=
 =?utf-8?B?WkNmc3FKS0x6a0lNTytSbmdnU21URjI3cFNvZ2kyU1JZanJveXJoNUhUdmJs?=
 =?utf-8?B?ZE1zb0EyWUliUTNjZmM2b2Y4VDVRQjNaREg1MWNxNkxTY0I0cWlBTHJ3TmdO?=
 =?utf-8?B?NlR3dkJQOTBjQUhZU3ZDNUtmeEo3SnNMZkhwdnJpRGRhZEtiTjkzVnJ1OHZN?=
 =?utf-8?B?QVdhNTY1WDJtalAzOXd5ZytxeUJod1lqSEZDT2c1Y29XTUVTbkVyaVRlanVo?=
 =?utf-8?B?bUh2djBYTmVDTXZOU0t1YVhjNHJrd3dXbGxFZ29KK3JXRTdiZmJNR2pRNk10?=
 =?utf-8?B?b1NrMUxLcndPSmFHV05pTkIxUko0K3hFZCtpOWZJZFBQaHhrYjBkVERkV1Bw?=
 =?utf-8?B?R2N2bzRNTHhwRmFqQkVjZWNRTVU2VWVabmpDVTZVR1ViVkpmWjd6KzQrOEs1?=
 =?utf-8?B?RUNGdTB6VUJDWVkycUlIQU94YkhTWFpMVzhhOEVwMmh1WHY5dzI5bFdkcmd2?=
 =?utf-8?B?cXFuNU1oZ3lmTHRNTmU3aHBPRnpiSC94ak1iZ1czYlVucW10TThwQ0ZnYVZI?=
 =?utf-8?B?TkttT1F5V1RSakJ4c05NNGpSRHA5QmpUTWUwV3hzUjc3V2xGOTVqWHVPb25s?=
 =?utf-8?B?elZxb1IxZlo3SzlrcG1PNEtpM2FqeGgzcmdHcGt6ZDhsbzBEM05OSGpSaUhy?=
 =?utf-8?B?WFdvUXZGbHJRd3NKTWEyRXNKU1hnSUtaaG5oRWx5UDZHTEs0aEMvSHZCRVla?=
 =?utf-8?B?ZHg5VCtNTzhXZ2VBR0FsallkdEJWbDZYc1MrZmlvZjN6aUZhSEl5NzBNemZZ?=
 =?utf-8?B?Uy9teHk2WmQwMFFMRmcxWXpzS28xdjdVaHZxZS9idklOMCtESzJCN3NKS3hK?=
 =?utf-8?B?TFBiUGNSWDQxSm5KZ0tHTHJVNWJ4TFhJd25MWGdhanNVRFdEd2Y5TFduTnpD?=
 =?utf-8?B?eHdnWlkrdndVR3Y4S2F3bGlLejAyK3Z5bk02Z0RnQi9rQ1p6emhqNUMxdktX?=
 =?utf-8?B?WDlWTkFCUW5jNWgwQnJMbW5pTXBFa1hCTEhPcEthcHY0SGhoQjhIbnowZjhZ?=
 =?utf-8?B?SmRKTXoyS1E0T25NeHNwRWF4UThNRlpweHpnUm5Fb1h4SzA0clh2N1VsOUYr?=
 =?utf-8?B?YmM5QlJrUWhzNnAwM2pjcXVtVGladGttRnFHTkswOWZLVkd4MXd5NUNNWEJ2?=
 =?utf-8?B?NUFGWlpOeW9CZk5uTFVVN0ZxL1dkcDZtdEhBS1llc2V1Z0xzK2kwWEh6WUpl?=
 =?utf-8?B?c0RFaU1lQkkwNnJLaWNrNm5vY2c2VWw1V2lBR0VLSGo1a1BCaE9SUEtnQnZx?=
 =?utf-8?B?UTZlWUlGdFlCSnZBUitSdkpYUmJyaHNjTjNvckhGekJjNFM3NXZQaW5WYjJK?=
 =?utf-8?B?YVpHZHhqRk5HaG1TVU03TVFEVWo1YWpmNUM0akVLWnl1Z09ZOVhUMDNuR0Rh?=
 =?utf-8?B?WDBxMFExRVRFUDRRLzRCUGd2bHpkVHJ1K0ExdEJVeEQxZWxpNkhtaGc0ZGJM?=
 =?utf-8?B?VWpoRW5FQ1p6VWxnME1RRWNsY3VTR0tZM2VzdjlYZm5nM0VXMjIwTnFJWjBv?=
 =?utf-8?B?WEhkRDFLTTBlaHpOaktESlFDWC9EWlRKQ2oramNJSFprNW5WU3NETmI4S1Yz?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d00958b-e953-41e3-3d66-08dc2d4f26c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:21:55.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hipKgctiCKUeIWHFOzlyPNpR3X4fCKQnL/NQwTikg3Itykqq/RqLdKJHsfTch2lCEoLa9Zk4LJhkM3hMePGyzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7882

On 14.02.24 11:13, Vignesh Raghavendra wrote:
> 
> 
> On 09/02/24 12:53, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> A new variant is to be added which will not have a arduino connector
>> like the existing ones. Factor out all bits that are specific to this
>> connector.
>>
>> The split is not perfect because wkup_gpio0 is defined based on what is
>> common to all variants having the connector, thus containing also
>> connector-unrelated information. But this is still cleaner than
>> replicating this node into all 4 variants.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
>>  .../ti/k3-am6528-iot2050-basic-common.dtsi    |   1 +
>>  .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   1 +
>>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |   1 +
>>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
>>  6 files changed, 772 insertions(+), 753 deletions(-)
>>  create mode 100644 
>> arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
>>
>> diff --git 
>> a/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
>> new file mode 100644
>> index 000000000000..cd86f412b837
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
>> @@ -0,0 +1,768 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> This and elsewhere in the series should be
> 
> // SPDX-License-Identifier: GPL-2.0-only
> 
> as fixed up by Nishanth in [0]. I can fix that locally, let me know.
> 

Yes, please.

> [0] https://lore.kernel.org/r/20240122145539.194512-16-nm@ti.com
> 

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


