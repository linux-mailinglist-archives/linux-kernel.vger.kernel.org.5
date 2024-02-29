Return-Path: <linux-kernel+bounces-87071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2DF86CF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27CB1C22BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6604AEDA;
	Thu, 29 Feb 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="htLWrIwZ"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC73160623;
	Thu, 29 Feb 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223930; cv=fail; b=Z2ko+yu2qIr/N2TdkPcdNwN1bww6VUSFoARRSQfhcBsd9dZ7h6MfJRUMvEI2otVdMkXYIe2nLtqEt3D7wfx55gkZ/CcAImJuDQmxBcoSiGJp0S4Uoghe24Kb/6+hzpBPi9BkQixlqHdcCeQDI1q/49RdE9kfc4KNV1zsJXps1Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223930; c=relaxed/simple;
	bh=uKa9vXpVs4TD4cJEih5b/8YvjYCMoFzK3kAQMKA/9Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aM1FgFduUQNqmPcNQlbBJ+7ckqRcsEBE14xo9pnDNHFDVykN1VXU7tfYPPT5tWUIPxpuA5PIqvLjxKHjDBdm3Z9yUYGjW/QMCG3u1Swx6JXmXgmIeWN7PfDYCyOE8NGyOPv68vO/w8wli2MxP7MRtvfbFA0+zQ4vGJ6zrNu3QWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=htLWrIwZ; arc=fail smtp.client-ip=40.107.93.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ/HK4teKmyUugU2b/q77FYXsQXQCWu7BwKWEuddcVWW+aLEC/dhkG7lADntDWKWq92JtZcwdedGtKO62HQihHar6E10m27p8B4MJS+8GBxjdZ/hxj7Bg90FW4XGGXjj+wuSy+SdsO/YVXidP1oW9XYG+1JHToUM/D8z+sumNV8t7m9K1tPMq4jFZpR75vBGg7CD4VaWF3VggukM9WzMQnFp0Lmfb8ZR/PISHAPAP0GG7ypJhKE2L2DgAnQ6mrW2X0WWjiMI7p8Vmp32V7hH5OlYOcFqqgSdGszOhF0x5cJQvdjYNc0W2BStaNh0qzeVyk/HT6TQkYd7X+o2owBUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DddTvNmqE0s34/FYb9alowJvDHcGvA1EEc+eEcEle9A=;
 b=IBilPF6EXeyjeOqwHn2XCl2TotBnWR+j047uWFKM4TjmMofLzYdIyEXyPZPuKJOUwxSH9RHMuP1kxWOmk21JKLA75cFa0Ye8yp8Ox3Ze4IPf8MfGVNxpWXvQPCA1M6i7CmPjMSiV5XcMmr9TVfhIqBvkQadLXyXe7KWx75pJhXc3m2mLZ4iLnfaaWII777znKN36rD/Z+UcY9BaC4rNQr4ogn/NKQccGys5h8AvmgeaD89cLa7hwzpFazgnq1cIWF95u4ntay/rT2yoNZeNrWxicH5uuV3z/4Cg5lQvEzIhi6C+aAuhgu4jrh2UeqpXDGYdU/UbfcuXfyX598aJ5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DddTvNmqE0s34/FYb9alowJvDHcGvA1EEc+eEcEle9A=;
 b=htLWrIwZt9NjneOjc0flPWuMmTUirbWBaeNjBaKR842c9VkZgtXS7xYrNgUldwWb6yiGdR/gYsfmAh9Cz7Jn2yJJwKDCjhvKH7DPtJ3QUtoTAWnnHCbnPz+IBY/RksvZ/lev91nkl04KN43TzjDAy2JwR3fJV7yf15rOC1mNjnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 PH0PR01MB6666.prod.exchangelabs.com (2603:10b6:510:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.32; Thu, 29 Feb 2024 16:25:24 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56])
 by SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56%6]) with
 mapi id 15.20.7316.037; Thu, 29 Feb 2024 16:25:24 +0000
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Huisong Li <lihuisong@huawei.com>,
	Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	sumitg@nvidia.com,
	zengheng4@huawei.com,
	yang@os.amperecomputing.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	liuyonglong@huawei.com,
	zhanjie9@hisilicon.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: Use AMU counters for measuring CPU frequency
Date: Thu, 29 Feb 2024 08:25:12 -0800
Message-ID: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|PH0PR01MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca82c62-2c9a-4081-e85e-08dc3943082b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEMrQEUvfAp0I2AJ1HUIZt0nWbpLnJsHCr8IoR7bEsOzO3A2bysqpZDoHWTP7BxtnL3MPQSj7x7HNAqEwiMl9ctn9PhOoqqh+io9BrGCATtrg96cIjH8aRwMhtzq1YBkdpc850QL9ESU4L6eLHxxjxeTb46tpiZGDKXHGyvRI+GEe/DTLjl0mvUB9BSZO8MIvDYeeB87Lpwn2XhfIB84Z+W1SCcJJHAeY88hrn0vb5EYxeqxlTkoVPuAKl1Vh6x8zWSBZl8qiN6k5X+Gi4FkhVY2oRrbl1ijbz78t3Y9Z0C8oBtC4nDdifQtmGPgxovRnKU14O61d1G5KIypgLd3ex4Mhsc31Ry8jKUJsRzaM4LYzFvzeUJZ7eJDtoDogCJO2eSQakdTPggLJJWBh1+WAzlMBoZTDTOii6eSyHAdda39JMZKmTnZ0YEu1rkzLFffnjCBzbr6jWGMsyWrvh6XpJeo7NngGj9flOBvQh2XFNZWNySXpbdpmNfz1ifd0XItbm8m4r/dQH6byvJM9lcDtOCzPeVkEEWwh8F78JHd34KgKHNVa7hGdvNnZAj1AD7da7Jtwinlt8UfTeaG/VwGyouvSEFnCqDuFpbRxQkh/cA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iU4DX11m0SOQ73tSMUKnHW2wR3S0SH5TR3XzGlyR9MEB8fMWN5IskrJ/6+UN?=
 =?us-ascii?Q?iVb24wf7LjN+WSMnm+3gzvoLI07BoBVGqIZGO3jj/9duzIK1FYkLidX6g5Qm?=
 =?us-ascii?Q?RIh3tg6KYgmWtWBo9r/zUb7JSev4BpB7YsTFP9ju/g8I5kYhoZ5Vzawxf4fE?=
 =?us-ascii?Q?cWrngpC44y1DxMSDk/I8IjFYdsvehpygYITrcylHa6aY8pfQ1Cv6eH9oDW7/?=
 =?us-ascii?Q?QHHBPx3ORfuFJ5XSVcb37VOS6aTAvZtWORz6Bx3qQ62/RrdNr/KaHMSfCUfL?=
 =?us-ascii?Q?wsvKMMERZlZzyI97av5HM4EKDSL2k1PkUqXM4aHDYrv3LLyiIil3icexWMfG?=
 =?us-ascii?Q?0izmW5IGyNUNWJl/BmaAf4LJKHeJjJXO2kMNpY3brvS/Ew5zft3lGznvtfvz?=
 =?us-ascii?Q?rNL5IIIAd8RYrUvGD9GiciSw4GsxpAg2GerKJs8ki7cpjByIugrWLGudxiMp?=
 =?us-ascii?Q?+rZ3mbImTxrh/NDHZubRQitg4QhYfvxCVpsx9i+YYa5z+JvTExqgaEvc2FUu?=
 =?us-ascii?Q?21eFFtZJvO8XCXTDYlcj9s7XcvDyhiOht8vSf2UdRdSJkV+Rxr6eKGOLtdfj?=
 =?us-ascii?Q?cZXojWE64Vt4CneJXsQw7qDEgNVjT720yLBuZUlD/Q3tREunzHKv7whwbcVz?=
 =?us-ascii?Q?QTnGv2TBqmMRBeGGNGmFlnew/u1jKegTRNZJ9O1wSl+DFENW7zH7n3mZwHLP?=
 =?us-ascii?Q?PyDIguE56/o2R4rN1k6RsM/lOa5atwghflQ3bxSdN5u2KlnaZbcnN3/8Da7L?=
 =?us-ascii?Q?avGZeyfxeqKwAO1HAy7vLHyEL5hiAjgDxM1QY0S+wA5M2WBxKKwSS/OXjkye?=
 =?us-ascii?Q?/6AdIE5Tzei3sgPbwPTHA8uMOWBU8CLBeL0WV2pruM7QDA/KIUt7OL3uX7qn?=
 =?us-ascii?Q?M/FeNsRSA021UGJAaFLjdMGPc4LXgGPXqsmSVCAAJqiiuFELF4hHABK9m09M?=
 =?us-ascii?Q?wjMnpd1ZEmGllq3kkqsCwhNjq+CPVH7W6bYjFbN4cevO7xvrg2K3/eBmt16X?=
 =?us-ascii?Q?i9KTKYlczc8Q2eE9+tRu5zD/vWNDDjYlsMV9XdiAwDbHAIs0EvkXpvK0XWGo?=
 =?us-ascii?Q?T7qrSBkX+xKkTnKbab2cutrhlYQRMeutn51WTFKAPgPW2tPT/W9HL0D9sNLF?=
 =?us-ascii?Q?QS5xN5+hh2RTpTLWtM4sLX3GnMexE8PCxD/o+a2XZYZJyiTOI5BzPzEnflXE?=
 =?us-ascii?Q?C4VB4MuRxr9c6Xp+ihZ+5S8PeHXQmiN18VV0jbLF2I4DJz898MLqqIIjZocq?=
 =?us-ascii?Q?Clj2Wn0h0uFFDJdMdb6xzf8O08cFlqLWIlBpd61jpJBrnSeVg2AhGMn6rIDR?=
 =?us-ascii?Q?hnYCx1mC2gfmBYSS061g353lDCLFP22SAHWxz4g++fj+9CjAAqTasInS/LUN?=
 =?us-ascii?Q?6WRbNF6zqW0hCXA8miFVW3tCcA4rO7KDbS2UZAy9JqrXKGFvaNi3tVeIUrCJ?=
 =?us-ascii?Q?AbvTs+UgT4DkKuj89DXhbxUDxNnEy/9MD0Eto5v18SF8e4mGmEl117ZLEK1j?=
 =?us-ascii?Q?uke2+3pQqSU+ZQhNdwI2d0rvtSj8jknGo1R5onvA6dICX+hFHJ5e0mKpu/wn?=
 =?us-ascii?Q?ERm/l/zPCwbsoYCf1hE81nSOzw4SKOlVFEI+cITcKVHXRHPmypZld8jh75Uy?=
 =?us-ascii?Q?C2FV3wJm+jGCdgGbgoNQhBXjcDXCvs1ej/J6fRzIDhUq?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca82c62-2c9a-4081-e85e-08dc3943082b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:25:24.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EscQ1b6CjbVnLXUOWFYoB18XBsAE66TktUs9/EyFCGOB4EnKx+zkoLA0nOX0JS9ZaE1nz2ond/iXUVUCZ2TisSU0tiqlMUmY5dqKf34ERE5CZBd/v+fPnO12oJqc12y3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6666

AMU extension was added to Armv8.4 as an optional extension. The
extension provides architectural counters that can be used to measure
CPU frequency - CPU_CYCLES and CNT_CYCLES.

In the kernel FIE uses these counters to compute frequency scale on
every tick. The counters are also be used in the CPPC driver if the
firmware publishes support for registered & delivered registers using
ACPI FFH.

In the current implementation using these counters in the CPPC driver
results in inaccurate measurement in some cases. This has been discussed
in [1] and [2].

In the current implementation, CPPC delivered register and reference
register are read in two different cpc_read calls(). There could be
significant latency between the CPU reading these two registers due to
the core being interrupted - leading to an inaccurate result. Also, when
these registers are in FFH region, reading each register using cpc_read
will result in 2 IPI interrpts to the core whose registers are being read.
It will also wake up any core in idle to read the AMU counters.

In this patch series, there are two changes:
- Implement arch_freq_get_on_cpu() for arm64 to record AMU counters on
  every clock tick
- CPPC driver reads delivered and reference registers in a single IPI
  while avoiding a wake up on idle core to read AMU counters; also
    allows measuring CPU frequency of isolated CPUs

Results on an AmpereOne system with 128 cores after the patch:

When system is idle:
core   scaling_cur_freq  cpuinfo_cur_freq
[0]:   3068518           3000000
[1]:   1030869           1000000
[2]:   1031296           1000000
[3]:   1032224           1000000
[4]:   1032469           1000000
[5]:   1030987           1000000
..
..
isolcpus = 122-127
[122]: 1030724           1000000
[123]: 1030667           1000000
[124]: 1031888           1000000
[125]: 1031047           1000000
[126]: 1031683           1000000
[127]: 1030794           1000000

With stress applied to core 122-126:
core   scaling_cur_freq  cpuinfo_cur_freq
[0]:   3050000           3000000
[1]:   1031068           1000000
[2]:   1030699           1000000
[3]:   1031818           1000000
[4]:   1032251           1000000
[5]:   1031282           1000000
..
..
isolcpus = 122-127
[122]: 3000061           3012000
[123]: 3000041           3008000
[124]: 3000038           2998000
[125]: 3000062           2995000
[126]: 3000035           3004000
[127]: 1031440           1000000

[1]: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
[2]: https://lore.kernel.org/linux-arm-kernel/20231212072617.14756-1-lihuisong@huawei.com/

Vanshidhar Konda (3):
  arm64: topology: Add arch_freq_get_on_cpu() support
  arm64: idle: Cache AMU counters before entering idle
  ACPI: CPPC: Read CPC FFH counters in a single IPI

 arch/arm64/kernel/idle.c     |  10 +++
 arch/arm64/kernel/topology.c | 153 ++++++++++++++++++++++++++++++-----
 drivers/acpi/cppc_acpi.c     |  32 +++++++-
 include/acpi/cppc_acpi.h     |  13 +++
 4 files changed, 186 insertions(+), 22 deletions(-)

-- 
2.43.1


