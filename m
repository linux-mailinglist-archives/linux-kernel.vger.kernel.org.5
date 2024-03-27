Return-Path: <linux-kernel+bounces-120446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90188D797
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C432972C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB524C7C;
	Wed, 27 Mar 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hQKIS1qe"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2034.outbound.protection.outlook.com [40.92.41.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4502D606;
	Wed, 27 Mar 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711525492; cv=fail; b=mQyIcMXhFb3FGj8Q4SlQ1A/pMY9XXAd9rp3sfvgapXnFjwDng1YS+no+fDxVyUSTNEodnn1tJw1AbYIE4jmzLhBC1x7Lwz8jw9WQXWpRcu7Mhwsm1qT1LiKCQQ9UYUm5Q2dHXvFtXhDH6BSKEdv64m4QkOQ247GKKvbuX/fpRes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711525492; c=relaxed/simple;
	bh=qtQZ/5R02Ef7lt9bNIsst/al1pL5VxL5r+X3zwKAAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aEfER8/4GqLpxdE4h/0gjc1u69AQN+j2LWMXuYnpbIcaeRkk8dA+oX6lmHIpX7EM1tSIfUOC56o3LwXkR7HimSTUEU+TqEcYzpotBaL6KnazwLX7SKUwZV5FCRmXpLNKLUIC/DaoGf1hWjj8RY0pEKHfksH/mEIQ5XIhQViC268=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hQKIS1qe; arc=fail smtp.client-ip=40.92.41.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1IfJvglFeTdBYaQQFgTO5X4lAdBFueLEljDKLJyFQdZoEVpwxLJhSApsdesLQm35CVeCJXPu/Xo1G0AtcdPjuArLxN/15TIRkTwcQpTYnkWOp+wDTBtMh+3kxvRSG+CIyhE1OcslSFw0PxrSjQCO7eOaj+duTOrwtOITZN0UobDLEdZ9qJGS8T8aPc6LlotFnUe2hg3amTl4ucGTtCHAAbxAYBZGW+jSfSpCnEt8RGbFHi5X7o1kRpGp5eI/IRUpt64VVLJHps3Rw2WDshepb8vlpPyiT/xxL4LUDYjjVDKi+unfw8EOtAKAYXxSNjWXDnPUXoFd+UdHKn1E/8HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUCn0x4ILGUNIkbBmqKlextH6ZrTLFd+PaEcZ+WLomE=;
 b=SM/Q56go08skQ3KvZ3S1cmXweBaonRsN4yn7AIYuE8vlFwmOUT//sTvf7GhkJmNpShHdjHG67n/io7Ev8JSTRbCOzcsJnf2kUuTmXUME5Mw2Icw8Oa8u63De63PPsKeyE/5742HUA20LtIpZmN/crOUsmG5utylwtkUG+4v5Ex3YJWRj+wwcaXRw1gQZzhbB3muYdfms+h6yEM9pq6rCyjGzO67VmoIVw/ZKa9MXOH/N0JqW5amJkxAdCACRLS0sinCrNvXbytsESQmLXYqzJKjzTLzKpTSnpFQUgqaIOTsF+SHT4VBdBy9CPMGock7ehU22hFdNpjAgUlI8ujNuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUCn0x4ILGUNIkbBmqKlextH6ZrTLFd+PaEcZ+WLomE=;
 b=hQKIS1qehzEDf/q6G6owtFaDYuJib9eoWwAp7BhxKD1iFzyjXPRD+DqFre4ifVaP3iwE6Fe7BpBI9GWiDBdaUGY3thZdXLm++rMi6XXFQnjymXJc7dbtOGjUJCy2AZSQ0kMpqXXvxHRFX9qPaRd7zHa2j6oSnt4H6ELQhkXUYPsIpF5giBp0/Tla66v8SBmDWcGHtl4a7VhAl6Qcw2YjPL8YvUyhFMZC6XA53zyHdHBcdAlMmK4K9RrHA7s41m3klMfAwsYKyuDPQCkDLCjMyGaVYYF9OSNmcuzs0oMttjnWCad5LCo5MUsyylxtVTb3HetA/3A0CprwQ8rS9Uvb4A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB4875.namprd20.prod.outlook.com (2603:10b6:208:3e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Wed, 27 Mar
 2024 07:44:48 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Wed, 27 Mar 2024
 07:44:48 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC] riscv: dts: sophgo: add sdcard support for milkv duo
Date: Wed, 27 Mar 2024 15:44:29 +0800
Message-ID:
 <IA1PR20MB4953436EB1E28CB565BD3F36BB342@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240217144826.3944-1-jszhang@kernel.org>
References: <20240217144826.3944-1-jszhang@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TMN: [h47+O4QdPLnBmwit97l1meqlj3SspzrH7IPqtSEKeps=]
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <171152545132.1459004.12521619420853775227.b4-ty@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a28d98-bb20-4eac-14fd-08dc4e31c740
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XLbpndB91SV6jhdom/SPB1VT+3tbp/oQ61sLHcLuR8+TsXsbPlnF3xvANQloCPLA/fYK3BYf++yxjWCLSsjl7MK4xZyKMBthO+kgCE4AjnlkAoYK6YLislEK9YSSqvtEraLFjYua+vAl5xnfivq+YiijC+eNO9GgXoGqU1VymN/MpxVnMZLSJpwlxnpcUBICViOvjpjNx8YdMvuzmLhX3ECSI8RnNwN5+Rma2/idqE8zBU7kB0hONr4sf3jd64w5JOSVbvCieOQfiFDt67PEWbpDUwlCsBSiPEnRHznrF5sXBtPfbotNOR6ttOtDFX3tH7lWfZRfKBWXTuLZ9FsEHWmyqSqX51LrwtovlAYh2Zb6p1/7nKf4NDK7Ni51n0BvCTwcFbN+urnKGV/L0oHORM7x2uYLUapCtrjIKO2tNCkFfZ/AwTgKfvWoUc+Zp5XzH7khgwBa06YqZ+YjwFN0loPgqpCFDfwaLOwaD7gJGk5o0nGRv9JetCSmMcfK1JUDxKQby7aNwqgIpFxrM5BBTggPuTlPBd2bzDHssgSShTjW3C5Xq/mRxEWMubbytTZ5vL1lWP7o/ycJqwVRRdE+fiAqingtmuMkfRg36JEMdYo3AD7E+FroqJ2jlzOueYAuc6rH+oNrE/FNtn10n13Tjdgs2H962OlVEpNHwtacqS+PO3jwNsH9sRhHSFESDz52
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVOYyt0OVYxcms5ZEtXOXV5N3QrRTF2dmx2QjBkdUgrczhlUHNVdGV4NDIr?=
 =?utf-8?B?cU4wUXZwQWF5RnordXdYZEJrOTJmVmVvL0YvSi9PZWZHSmpDT3BUZWFEdVV0?=
 =?utf-8?B?SVRBWEtiSHQ5aDZ1RFhoT1oyNm1UNm9VM0thNHlnTWtXOGpjYzJUd0EwWDUv?=
 =?utf-8?B?Q2F4bGpNNWI5OVU3OWhpQkxaVnMrRnNzTlpRMDlWYTF1aVRpZk9nenpXSHRq?=
 =?utf-8?B?ZDNiYnJlblZReHlUSUovRGtUZXJvZ3hZRnNxWGFZRGVNYTRmL25vN1d3d2c1?=
 =?utf-8?B?ZFdyTGdaUDU2QldpL0xsTmV5d3QxMXVQSVRiWXVHcURCY0dZdHJLR0kxQ1ZF?=
 =?utf-8?B?QmU5MjlFeEhkV0QrTEplVGk4bDNkZ0Q5bFdtQ1Q2M3VZZ3NrdXdnOTV3dm1N?=
 =?utf-8?B?K2Y0NjFpVmtWVjE4RmRaWmhKU1VDeCtCM0R4cHJXb1ovVzFXdU0yUVZGSjIy?=
 =?utf-8?B?NEwzWm1pYkZiNnZxUndyTGFoSU5QNG9hWkZmaiswNURqMTQ5VDFqdG41RnFs?=
 =?utf-8?B?S2g4ZXNFcnFJTlF6cjltNWZwZ3R2SjlOSnZTNmFwTFJVUXFYbldKVnIxQm5O?=
 =?utf-8?B?cjlKTmxLU1hhVm5HMmpZOHFrNStBSnlUVnhCZVd4M0hORHVkZzVCdllWSFls?=
 =?utf-8?B?Qnk1MWkzaEhuRVltczVKbXhobmZtL0NGbWl6dGphcCsvenpLK3J4U0pydk5Y?=
 =?utf-8?B?V0ZWZ0wxdzR0d0pybUxFdTBVb1poN0F5T0I3cmhRMlFLMi83TmZwcjJMSERj?=
 =?utf-8?B?TlRQNmtqMFlRcWlGT0Z5ZzZDdGgrYU13c3BvTUZJNEFqK3lnTW9jMHZISWhL?=
 =?utf-8?B?RkNWOU9aM2hsYWVYYncyd1RETmE5dGRtRWJkL1duMHYzak9Ya0d5eWpJdmVk?=
 =?utf-8?B?MVZLeTUzVDhkdXhRYmVwTGNiSWtBR3pYamlVWDFnaUJjOTBKSGtUbCtIak1z?=
 =?utf-8?B?NXRRam9PcmZYNFZPU0xNWk5uS1FYZXJZNXg0WCtUWDNLZEo3WGFQb0pJRkVH?=
 =?utf-8?B?YW1ZR25EaHNURlhTcnBVMEN2WFIzYXpYdFpwRUhzT2szY2ZkeHBOamNteGVT?=
 =?utf-8?B?TGNBMHg1WkQ3U0p5T2xsNHQ4VXRhdHpDQmc0SkQ3RVpkYzF6OHRNZ0M0cGpY?=
 =?utf-8?B?YTJ4YzFsbm5UMGx0d3paeUVaOFoxRzN0U3Vlc3lWZmxUbmNIZnRGSHdud1Qx?=
 =?utf-8?B?b2xyQXRjVlZsUVB1K05Ga2xxRDNXN1FrbkFFTUZSdG4vc3A5TnFTWjMyT3k0?=
 =?utf-8?B?VFNpYngyeGFpZEZtUG41ZVJrbW5FS2pxc05SaHlZZmlqSDZsYkJCTmxBNUtQ?=
 =?utf-8?B?RlhveThXeU5xcXQ2bGZIdFJRTXhqV0tCRU9NZGRGUXlqQVVtNWx0Qm1YdHE1?=
 =?utf-8?B?V0w2Y0N1Ynhqa3RrN2ZtdXRCdGpZUkZBcmxFVVB1YjBNdlJTZnRKV3JBT1Jv?=
 =?utf-8?B?ZFZjNG9NOGlHRmF0d0xBRzJDMjBqRUY1bUtYYVpLL1NpdFRSRjZ3TXNZbGcw?=
 =?utf-8?B?QXZWWEpqd1ZDUzBlSU1sbldrVnZkMDBaNUJVTnNsNGJLdS9IRWtaZzB0c21C?=
 =?utf-8?B?cTNBVVZSUTZTczRhZ0VNNGtWVWZLc0RpdXdNQXh1cDFoVHdFaC9mczRDOC9S?=
 =?utf-8?B?QmdmeEpMNlRtVmdrdzNzcy9uUFh1ODRVUGhWcHpJVm5KRk1rVjQzYkZzbWVl?=
 =?utf-8?Q?gxb7uYzH/4GepsFwq8HH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a28d98-bb20-4eac-14fd-08dc4e31c740
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 07:44:48.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4875

On Sat, 17 Feb 2024 22:48:26 +0800, Jisheng Zhang wrote:
> Add sdhci dt node in SoC dtsi and enable it in milkv duo dts.
> 
> 

Applied to sophgo/for-next, thanks!

[1/1] riscv: dts: sophgo: add sdcard support for milkv duo
      https://github.com/sophgo/linux/commit/89a7056ed4f771e689729f7992ef5351e64e26c6

Thanks,
Inochi


