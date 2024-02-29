Return-Path: <linux-kernel+bounces-87225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CA486D151
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4028B27C96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF787580B;
	Thu, 29 Feb 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IhMckZF+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2104.outbound.protection.outlook.com [40.107.243.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED03160657;
	Thu, 29 Feb 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229669; cv=fail; b=Xw9toHfPHUsyxr83aSbW80GTd69wHuu9VOLxz95P20MR0UXZt0UyUQFyx5RyWWVx7EPSfMB9wpSObwXlggSnkelAm+Ott5sQpXxLjWfXqoIU3K5QqOIx7g5kdeaf0NL4kKdb1XCval6xX01JTHYo4uILaZwdiOXB60sA9eumVVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229669; c=relaxed/simple;
	bh=R8kb7Me7alCtqknI8vb9zoqYWSfx3roDhNeHIP9Oszo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RctfS66aGfHpM9/UWYxnkO2fdbQzQk4lx6N0itoVWLz4Tq+KvIhY3bNjsEjd4RBXXJpr/1LsYqK2zJ4xEn8B7zLYQlo4JHVZl6Gw6GxjCYKxB03+LfJ5lJM7aWMo4Ak2ZslmoLO9h3xI9LHbmPtOLapKT64wcUx2O/T83IpHaHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IhMckZF+; arc=fail smtp.client-ip=40.107.243.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvcFDxikIv//8Za5xmSiTetJg8YT84FqXjP1EsGHI3PP8LMcOX1kbHQ0guZfvS4u2wqbtUBFT6YVFwhRgDPh68NmpvWeBvKVUA62iIAW9gi+Ank33Iep+lD9z1fQMb3AQ2nDnDm7+MseF3st00tX6XWqL2T2GNDopN9dpOH0bgprRGR4rU52CLC+4J0C8BxLQQCwc4MLd0bSbPvSxX5QgLOJRe+1zxKGqz4dVJpO53tf5riaGJf/UicEvvYX1O7xiPAig5pDRMeYPUiq21aYxsXB7gkOClzcpHXiJ8uZ8Fej8ZNK3qIgLv/Egx2AYBwfvzLr5N3pp/ODVDrXnAxsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai0PAqkqI951j91SKNEy0P5FZUrji7jcldCmB5nX6kE=;
 b=EaedalrYAMH/6ojRA3hbsdHaWnmsHttxxRXW/WJNxCbkZR5hF4taY6UFZHiZkzMCOCNS6ybz0x0vcVZDdGekZXQd2xfrn7ts2E/OPL/T7m2L9y0XexXjePYTX+v2vYlGSqsfrr7QFt47akNrbQPK3g0swcmpI19am/WaIj9q68MMHASZs2VVKcoGUgqpRTqh68INJSibFs0fHa8FOOctNBYugGS32iMoVZBguchtgrbuO6SPxT6fCG6fzfH06gAx3fwuBTOMtsIyZMB/k3dMUf7iuCi5K9pu3ITuKhePtlXsCFDlS6qHyFA1n3yoODILEs44Z4QUmK/SGePpu7sT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai0PAqkqI951j91SKNEy0P5FZUrji7jcldCmB5nX6kE=;
 b=IhMckZF+vIGXGXRqEVRjqjsHw1tfkwHz5A7FwVk5t1j6ruV7wf/YFlU+SHurzcw1QiHkG8fxL5ddmBqC/gWiO8AXD0j4b+xw3gcv7qDk3SLv+m47iG1a/rpoEDRTtb7X5qA11CUdRaCck0OvfnjjUHyhuUnz5/i7yYmWH5M7XT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB6509.prod.exchangelabs.com (2603:10b6:a03:294::17) by
 CYYPR01MB8602.prod.exchangelabs.com (2603:10b6:930:c9::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Thu, 29 Feb 2024 18:01:04 +0000
Received: from SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56])
 by SJ0PR01MB6509.prod.exchangelabs.com ([fe80::3bf9:56fb:dd12:56%6]) with
 mapi id 15.20.7316.037; Thu, 29 Feb 2024 18:01:04 +0000
Date: Thu, 29 Feb 2024 10:00:56 -0800
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Huisong Li <lihuisong@huawei.com>, 
	Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	sumitg@nvidia.com, zengheng4@huawei.com, yang@os.amperecomputing.com, 
	will@kernel.org, sudeep.holla@arm.com, liuyonglong@huawei.com, 
	zhanjie9@hisilicon.com, linux-acpi@vger.kernel.org
Subject: Re: Re: [PATCH v1 3/3] ACPI: CPPC: Read CPC FFH counters in a single
 IPI
Message-ID: <5paw5cvh7klhwasvldyl2coaihntkv4cvmogzyov7qwyohxmvl@lt3auiqhg2nv>
References: <20240229162520.970986-1-vanshikonda@os.amperecomputing.com>
 <20240229162520.970986-4-vanshikonda@os.amperecomputing.com>
 <CAJZ5v0j+qz0okToszmU=kBjZvD3GJKzwz-ZrweOkgw6A2e3pQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j+qz0okToszmU=kBjZvD3GJKzwz-ZrweOkgw6A2e3pQQ@mail.gmail.com>
X-ClientProxiedBy: CY5PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:930:5::25) To SJ0PR01MB6509.prod.exchangelabs.com
 (2603:10b6:a03:294::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6509:EE_|CYYPR01MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db573aa-9655-40ca-fbd8-08dc3950652d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QLNjI37hKRzW15k80cIROUWOGZIUEKSpXrGM/7dpx1aYwWophG8AqgjcO/SqVjWOTchF8H588gBTb1H0Lm74qULFTlJMN/Yyjp784uzKYkMoheydAfm5PsZMfsqCvUW7FQFijyEb511yft/qZzzoPhDtHBVmaPLFii0hjA8hku4wxDBCCgWGBVKocsJoikgpzv+CePeIo1XDfxa39/Ql4gPI0qcFs0lo0PFNZEwerrHOK0PFrOgFxQuJ4ww1910fd7OPdKHF1DSbXLEbSSKJrrd1EtdkcbZ9Ir/jago1nnGXMugbDJk/Rq0WQFhripGSPmMYQw/0UlgIpzfeQY+pLQFmsJvWrkqrk7RK2XtPCFztXvjP1tFeONVUNXd9mkfNOp6VXHoHPm+bH4EwiTJrEw7OqAZn4l2ZtUJQkszmTOHERB4TqaSjXwTlsYBOKJ0CE0zKOFlUtWXwlgcum2+CENq13zp5vcj6Q1s6ISWQ9tTbbzmXlP6e0uin91HlZ6ROpE3htLIn3SSOESoayK3EZjpbNmiSHArBGN0a4QXytm+V/pLSX9rAaVrN4EaZaO5679XuQKOEAJLqmTwjRu1FIQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6509.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkpLRWpsc1VKVFNvYjR4TjEzRFplNGJpaEZyZ2ZuQTV0UjBHcGQ5dzVQR05h?=
 =?utf-8?B?djhhK01obFZrQmMvOFBXL0cvVVBueWxCdmpOdDdKMzFFbUFuZHVLWkpIRGJG?=
 =?utf-8?B?VVRiNUVGSmlNRUl2b3cwVW5LMlFFTnNKbEVWZXZUZW5FUzlFcEZXbklVbEVJ?=
 =?utf-8?B?MXFkVGxsMENtS3VjR1pPOC9Ld2c5UzZDZVR5YXROT1prU2RJRFpGc1hpWldO?=
 =?utf-8?B?S2xzeUx3ZjRZblJOVWJyZHVUN3Y4VXI0SWp4cktPaTV2ZDR0WUtJbXlBTDBx?=
 =?utf-8?B?cGlMSWMzZTRaajRKZHVQbG10TlhNK2UvVkxIaFZaYStnay96dlIzT2RPNTB2?=
 =?utf-8?B?UjlENW0rQVNlZXVZS2xGSmtBT1ZUZDBIWjd2WUVjREduWnR3VGFReExVMGI5?=
 =?utf-8?B?SS93Q0I5M0lYdTFhQzFHTHRoN1BXd0lqLytnNlRLWVk4TEl5aHJLOVUzRXNM?=
 =?utf-8?B?Z2ZmcVNxL2lUdEphRmRzM3J2UE91ODdmUzdkYnVKV0g3NXN5dlpacWNVNTI3?=
 =?utf-8?B?S0UzMFJ5Nys4S0FieS9ucEJRbWJQNllIUUlObmRmRnMyU2RpUEEvZi9EZE13?=
 =?utf-8?B?WkdFK2Qxek9sa3BOMEMxZFRBdFR1b2cxQ0twdEp6UVpkOVZDT29Oa3B3RWpz?=
 =?utf-8?B?MUI5ZVVxNGxTak50Tm84enhtOTlhZkNjL0JlcE94RXJ1QWNpeTBTcmtSUjQ3?=
 =?utf-8?B?RG54NVpmMTIxVXIwSkZEVEdWSUNPdnpVTG9pM0hPY25hSk5WRG9XMk5zUTI2?=
 =?utf-8?B?OXZkMFk5bHNwd2pNcUZoL3VhTUVBV1ErVHJOMFlmL0FSMjY5RnhYUkNQK1U3?=
 =?utf-8?B?NXZ5NmRnQWVSN0o0SU9UZnZmaUVnQ0tWcUVQK2xzRElFdHh2VTNIQ3N1c2lQ?=
 =?utf-8?B?ZkhRSGc2aFZEMCs1dGVFUGNtenVrRkxnR1kzUnFjeFpaTStkcWVJV1ZnREJ6?=
 =?utf-8?B?U1Z6QVVDQ3JpcE5oVG40clVDR0FBeTUrT0Y5eVhIV3pCUWFCRk9jWm5BdytS?=
 =?utf-8?B?aDdGTVc3cHRKWGZaa28zTlFrZDdXNnl4YzR6RWFSNTFyeWxzbVZRaldjWksz?=
 =?utf-8?B?dys2cEw0TTdMSHliY0x4VWQza1BZaGdweHkrVW05clczeS9WdndrU01mLzRX?=
 =?utf-8?B?QUZCam5qYmRLUis2S2d5ZkdYdFlSUTkyTmxkakNMWXU1SDZkZ1dSUDk5SU4x?=
 =?utf-8?B?cTgvR0ovSkRkYXgvK3Jnb0JnbFBlZFlvMVhCdWIxb2RHaUkrN1dDZHJOUkgy?=
 =?utf-8?B?c2NpL0daUE1HbHVOc04wSFVyR1JOQUwvd2lIOGVxd0dwUmpvYnQ3azhnaXEy?=
 =?utf-8?B?MjNHaEh2QnVmQkRMQ0xoY2EzVEhLSk5mRVUxbVZ5OGNEdGFiS3ZEaVFPU1Uy?=
 =?utf-8?B?c01RTkJBRzhId0J1d00vM2FvU1cvYVFySkxYcEZtZkdBZkd4d1RHeWQ5NWZl?=
 =?utf-8?B?UnVJTVk0M3BZaC9ZUDlwK0p3VmNKWHlkMjRTRTVCTVFBbVlQTHhWT0xVMHRF?=
 =?utf-8?B?RHgwbXlNdkNCa2tGMFJtWEp1WnVxMjQ1OVhlUXlCTjh4TXF4S0htUVRVaHVF?=
 =?utf-8?B?ZWIzT0ZZS2FTcVNKQjNOVTAwM3ErQks0UXQ5SzQ5eGxwYWhwa0kvTlRkY29u?=
 =?utf-8?B?YkhoMzZnLy80MkJmd2tjWUVOQXNvUTNiT3J5M1NoY2NmU3FpUE5rZUorWXQ0?=
 =?utf-8?B?OGJiRXR3WUdzVVJoWDZnNVYwQXdwaFltbDVmRmlydXY3dVQvUXVNbkJvWVBJ?=
 =?utf-8?B?UkExQ250L3lWaDJnR01PRG5zVzduSDlXVlpHSFFMaCtXYVQvRXpNSHZBVG5M?=
 =?utf-8?B?MEJBdDNWN0ZOTWlkMHpveEtJdGhLUUc1NGFLbVpieWpOK25IM1AxTWJkVUtx?=
 =?utf-8?B?WDRURzN0R0hxQnR1dEFrRlpLS0ErckE1WUhxM1VERktlcThTY3dweEpZS3RU?=
 =?utf-8?B?akN1NXNZRGcxb28yMzU2NHUwaDNxRkY2WEFpcXV5QmlGRDN2a0h4K3NLdmJD?=
 =?utf-8?B?SnoxeWFwOTZHT3hxWFpiSU5mQU5JTUsvb1YybDhxMHdaUVJCQzhoNFF3ZTJD?=
 =?utf-8?B?bnFCRG5MZkxzU3NRcnM3K01oOW9STW9Tc3UwYytMa0RRTGhoSVFNWUVzYTd4?=
 =?utf-8?B?NDFPaGRoMUQzVWxkMzkyS0dNaFNmK20zSXBYeVZCbEt3WVo5V0tGbGNhalNV?=
 =?utf-8?Q?PdMV1eaSQdRfnEs/5OyEWBvf8fBk3+2tsyChrV2FkxZQ?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db573aa-9655-40ca-fbd8-08dc3950652d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6509.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:01:03.8886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnWTvp4G/F3A7yKzDKasNxk9AKDXXSTPCdi8436kPHyJbkPBcDMqgixkbyxHO+HcX0QbLbt8GsepBNL4zGSTnqMZncJ3HLtJNEDiZJ1xDDDie1MCiJ/YZj2rurfgupTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8602

On Thu, Feb 29, 2024 at 06:32:59PM +0100, Rafael J. Wysocki wrote:
>On Thu, Feb 29, 2024 at 5:25 PM Vanshidhar Konda
><vanshikonda@os.amperecomputing.com> wrote:
>>
>> The CPPC driver reads delivered and reference counters using cpc_read
>> one at a time. This leads to inaccurate measurement of CPU frequency
>> discussed in [1]. If the firmware indicates that both the registers are
>> in the FFH interface the kernel can read the registers together in a
>> single IPI. This has two benefits:
>> 1. Reduces the number of IPIs needed to read the two registers
>> 2. The two registers will be read in close proximity resulting in more
>>    accurate CPU frequency measurement
>>
>> [1]: https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>>
>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> ---
>>  arch/arm64/kernel/topology.c | 37 ++++++++++++++++++++++++++++++++++++
>>  drivers/acpi/cppc_acpi.c     | 32 +++++++++++++++++++++++++++----
>>  include/acpi/cppc_acpi.h     | 13 +++++++++++++
>>  3 files changed, 78 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 8905eb0c681f..8207565f43ee 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -421,6 +421,43 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>>         return ret;
>>  }
>>
>> +static void cpc_update_freq_counters(void *info)
>> +{
>> +       update_freq_counters_refs();
>> +}
>> +
>> +int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *ffh_regs)
>> +{
>> +       struct amu_counters *ctrs = per_cpu_ptr(&cpu_samples, cpu);
>> +       int idx;
>> +
>> +       if (!cpc_ffh_supported() || !freq_counters_valid(cpu))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (WARN_ON_ONCE(irqs_disabled()))
>> +               return -EPERM;
>> +
>> +       if (!idle_cpu(cpu))
>> +               smp_call_function_single(cpu, cpc_update_freq_counters, NULL, 1);
>> +
>> +       for (idx = 0; idx < MAX_NUM_CPC_REGS_FFH; idx++) {
>> +
>> +               if (!ffh_regs->regs[idx].reg)
>> +                       continue;
>> +
>> +               switch ((u64)(ffh_regs->regs[idx].reg->address)) {
>> +               case 0x0:
>> +                       ffh_regs->regs[idx].value = ctrs->core_cnt;
>> +                       break;
>> +               case 0x1:
>> +                       ffh_regs->regs[idx].value = ctrs->const_cnt;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>>  {
>>         return -EOPNOTSUPP;
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index d155a86a8614..55ffb1915e4f 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -113,6 +113,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>                                 (cpc)->cpc_entry.reg.space_id ==        \
>>                                 ACPI_ADR_SPACE_SYSTEM_IO)
>>
>> +#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&            \
>> +                               (cpc)->cpc_entry.reg.space_id ==        \
>> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
>> +
>>  /* Evaluates to True if reg is a NULL register descriptor */
>>  #define IS_NULL_REG(reg) ((reg)->space_id ==  ACPI_ADR_SPACE_SYSTEM_MEMORY && \
>>                                 (reg)->address == 0 &&                  \
>> @@ -974,6 +978,11 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>>         return -ENOTSUPP;
>>  }
>>
>> +int __weak cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs)
>> +{
>> +       return -ENOTSUPP;
>> +}
>
>This might return a bool value.
>
>Is there any case in which the caller would handle different error
>codes differently?
>
I kept this similar to cpc_read_ffh(). I didn't see any usage of the error
codes. The return value of cpc_read_ffh() is returned only from cpc_read(),
but I didn't see anyone consuming the return value of cpc_read().
Additionally, checkpatch complains about using -ENOTSUPP and suggests
replacing it with -EOPNOTSUPP. Does it make sense to update
cpc_read/write_ffh() as well to switch to return type bool?

>> +
>>  /*
>>   * Since cpc_read and cpc_write are called while holding pcc_lock, it should be
>>   * as fast as possible. We have already mapped the PCC subspace during init, so
>> @@ -1317,7 +1326,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>         int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
>>         struct cppc_pcc_data *pcc_ss_data = NULL;
>>         u64 delivered, reference, ref_perf, ctr_wrap_time;
>> -       int ret = 0, regs_in_pcc = 0;
>> +       int ret = 0, regs_in_pcc = 0, regs_read_in_ffh = 0;
>
>Please use bool as the type for boolean variables.
>
Thanks for pointing that out. I'll do that for the next version.

Thanks,
Vanshi

>>
>>         if (!cpc_desc) {
>>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
>> @@ -1353,8 +1362,23 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>                 }
>>         }
>>
>> -       cpc_read(cpunum, delivered_reg, &delivered);
>> -       cpc_read(cpunum, reference_reg, &reference);
>> +       if (CPC_IN_FFH(delivered_reg) && CPC_IN_FFH(reference_reg)) {
>> +               struct ffh_cpc_reg_values ffh_regs;
>> +
>> +               ffh_regs.regs[0].reg = &(delivered_reg->cpc_entry.reg);
>> +               ffh_regs.regs[1].reg = &(reference_reg->cpc_entry.reg);
>> +               ret = cpc_read_regs_ffh(cpunum, &ffh_regs);
>> +               if (!ret) {
>
>If cpc_read_regs_ffh() returned 'true' on success, the above could be written as
>
>if (cpc_read_regs_ffh(cpunum, &ffh_regs)) {
>
>> +                       delivered = ffh_regs.regs[0].value;
>> +                       reference = ffh_regs.regs[1].value;
>> +                       regs_read_in_ffh = 1;
>> +               }
>> +       }
>> +
>> +       if (!regs_read_in_ffh) {
>> +               cpc_read(cpunum, delivered_reg, &delivered);
>> +               cpc_read(cpunum, reference_reg, &reference);
>> +       }
>>         cpc_read(cpunum, ref_perf_reg, &ref_perf);
>>
>>         /*
>> @@ -1366,7 +1390,7 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>>         if (CPC_SUPPORTED(ctr_wrap_reg))
>>                 cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
>>
>> -       if (!delivered || !reference || !ref_perf) {
>> +       if (!delivered || !reference || !ref_perf) {
>>                 ret = -EFAULT;
>>                 goto out_err;
>>         }
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 3a0995f8bce8..0da614a50edd 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -137,6 +137,18 @@ struct cppc_cpudata {
>>  };
>>
>>  #ifdef CONFIG_ACPI_CPPC_LIB
>> +
>> +#define MAX_NUM_CPC_REGS_FFH 2
>> +
>> +struct ffh_cpc_reg {
>> +       struct cpc_reg *reg;
>> +       u64 value;
>> +};
>> +
>> +struct ffh_cpc_reg_values {
>> +       struct ffh_cpc_reg regs[MAX_NUM_CPC_REGS_FFH];
>> +};
>> +
>>  extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>  extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>>  extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>> @@ -153,6 +165,7 @@ extern unsigned int cppc_get_transition_latency(int cpu);
>>  extern bool cpc_ffh_supported(void);
>>  extern bool cpc_supported_by_cpu(void);
>>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>> +extern int cpc_read_regs_ffh(int cpu, struct ffh_cpc_reg_values *regs);
>>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>> --

