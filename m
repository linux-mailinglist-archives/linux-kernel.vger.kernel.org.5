Return-Path: <linux-kernel+bounces-146221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C18A6257
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB11C2146F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BAC2232B;
	Tue, 16 Apr 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="iBQO5Ac+"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696520B0E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713241404; cv=fail; b=HFliG9J0q4wspYwNQJmayaxVgTUiuQ5tAOAKBSVXcxeRQtordOHOHDXPaiwsqaOKJ+V2m07QNUCcUzC40xym0A8TvWUxZ0n2ONEKkUU5ffZdO+ZSox1dRFVjtCOM+bol6kRLp5ZLHlGcW7z6egvYv7J/8hJ/UAXhHDRlqywQQSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713241404; c=relaxed/simple;
	bh=EpuAu2AyWhpODw25s62NJv9dsXMmUgPa8Nl211bOPpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hOhJcsUBdUCMhfQshdRrIAlkVzo9R0Wu7734Nc3SmFnLq6EvyEMqyFHfz7UADN43WYRkI2/aB6KCWnpQMMnKgKqIa4NpeKH1ARYQTv5DXxXKbDgLyuusy8Bf+JKf8eyA9faqPYflwJiJaYOeU/uSpjXtpILy9qufMyGiSnk33u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=iBQO5Ac+; arc=fail smtp.client-ip=40.107.244.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOWOD49bxkAkVNDFVuasnkkMTMMlOmMwU8sJ5hx8m1JJqkSlpBFRdWts9RiD6ZwvI9uzW5kQ1iae9BtP8eoS5SYQqZ0EAmK1bg9Y8itjo9N6vAi7SdRtV4GxdDLhd9ZJW+0RnGtCXnmIXrj6aDervhjR9XvOM34bNP6KrSx0744eiXVJevUISHowkS6BwJ1kcHtuCrxaXkKUeKDJuCMFbG4b0zZ3M27uGyin4XkyEV9JOWcxi0RMPTgyY0aM8CdtPCWsO7YBmixkRECr8FoAuLAVv/ylFrfe/L4X9FYPGNNEP/nXRyH5ewbMabLbAZxy2gaE94FTtf01j0Ib2QppWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qn7I3z0E5bRx9ojd0l8kIykTDOQ4g95uFxQfv47OQgI=;
 b=LmEVcHFjM2lGgYlF0BJiEIa1Ehs/uxZ+lfBvex0b+lBo8hC6Z8KNSwRq/H2rumuFYPFJ7hf+Ti3Y0sRVdokKPhWIp8xWETIbegWQkw48SDORiJIYpeT1LMtR5VTZH+JCY7hZopqlFzdwhTjvCMcEpNoTvqMp8AJCC937ViyU7g3oUqxG6iaYTgS6yIk/63S+joH2SQhgCU7lfWhKN1J+EPdKM1uNo+i/Y7PB9JP3GLcHocNeKF7er0mDy3LJvmYa7AaELlPdRqD+Uv87yJt4dwQwjYIi9vwwMCkdWPul864mxu3APueZLG71r3x5+C6n4o+QO0h4VyXzc3+tZxdsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qn7I3z0E5bRx9ojd0l8kIykTDOQ4g95uFxQfv47OQgI=;
 b=iBQO5Ac+v1S+Qd1/jhTcS26uavvmOJYpkILPxs/jryDMC/ufHXHdUP3BpX98YZpEWOCcne8OzcAzyj6GPKwZTCJXN6Fq1lUS/0o1oyJBTpBkJTTgk21VlKoKy2HYu816Bk4t4+b4GRCtbnBebeTKjw1jN4PXs5vM9vU/tdXPNns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6498.prod.exchangelabs.com (2603:10b6:303:79::19) by
 LV2PR01MB7742.prod.exchangelabs.com (2603:10b6:408:174::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 04:23:19 +0000
Received: from MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b]) by MW4PR01MB6498.prod.exchangelabs.com
 ([fe80::4fc3:132:87ac:c13b%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 04:23:13 +0000
Date: Mon, 15 Apr 2024 21:23:10 -0700
From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com, 
	vincent.guittot@linaro.org, sumitg@nvidia.com, yang@os.amperecomputing.com, 
	lihuisong@huawei.com
Subject: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240405133319.859813-5-beata.michalska@arm.com>
X-ClientProxiedBy: CH0PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:610:e4::11) To MW4PR01MB6498.prod.exchangelabs.com
 (2603:10b6:303:79::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6498:EE_|LV2PR01MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e23f762-c9fc-4208-eeb1-08dc5dccee69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K/aedHvAzkXsD2e5fS4m99//r9/M/wUfJHnnyFFOkZSa8RfmtuSXS+TCknngus4IXdMsrFlRVq1LXHPhSi64Shsp9Pp3p7ouAHX7uN9bHDQz3yUHZpIFRYmm7eqiJbl1FEvIscs3hNyqV+IYinXPGDxWoTdTR/8PQxU089CPyJImg6RvxU1EwIKJCg1/n+G9ogCrE136HQ560iEf7Y3uIu0CCGoX4Hf3hONYuPYxWSdWbYjM4lfE0uQcrLs80OnAX8yow347FH4hmOXD1hVAQR+i2Hsa7/i4qnY7gM26xpl8I6IjmAn1bCixGZOh2i35RwaEly6FXZ5/SYWFEfwdDoulnXjn7N4xdym1g9d+vyCOildbVWmOZ1oG18zvb4VXoyf+3dcupGyFQu6Z3aoW7zv4bJ7COCfD52ybCi+hqN1K2ZxX5Vp/9CqLmGspmxw7Cc+iv3m3+JUda3KIGh0Xq/kcjOAqRiC1vUnjiUw5fk9TadS1+xHKUSm5XyBdpEb5qzdxRonVQQsoprfZq2536W4eF7GLBs+aEQ8OxqUX9DGbcZ2s1IJYB6hnwkHh624Xcqg/zcuiwf93PfSzlvuqHrpQO/FcOVPxO4dfG/A3dmK1k/1tax3G269Ax14l0kurtn4FUd5AXcuJszTJ4FPNsgnHtD/4boaY9SLUQYF+794=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6498.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1+KBZ/zVpoYNaLzIEzXap0eCvED9WqZQG8TlKwTgoqjR21cRCvXqPiI11r9?=
 =?us-ascii?Q?l6PBGwqwPKWbJ1+j7CrcXBvVPAEkTMnvwQZ469XMVVaJXHRH5U8WjDv+MsJx?=
 =?us-ascii?Q?IM0t04YGM9l8y3QnzgWLY66WwSNX/tZWZtGid0nzxiRJi3jEgl9xNW4yc9Ga?=
 =?us-ascii?Q?6JddPyk+LANUKmT6X+95uklmwQmAljo1D+B8aQ5tNUEDflkJziKqDvgPTNRB?=
 =?us-ascii?Q?Ib2OVYIc1TJQkbFMgJILmMJjfr4ZwGmNo0FmWCTVIds3nZPwE875x8KSAlzE?=
 =?us-ascii?Q?gDfhwvwikPczJWhGdkzHSwjcUM+M6qwffIzPAzpISYwUS8t02/kxKCSUl3Iz?=
 =?us-ascii?Q?f0iOyQLmkkNNUhcIgJ8m003KbyMxn96CSPlO0eD8BEa+V/chp0CrJz4jm3pq?=
 =?us-ascii?Q?ppAdxEY/9oRUfBjUqNqTaVj3hx+lot6rZrVP1uYJIabD2woFZhTAjYvgMGgF?=
 =?us-ascii?Q?/p5q3Y0Y6Qj8Gr0jUBl1LZr4nSzniy7jKTv7idcS+mzncVma1/vNGa0f5p8J?=
 =?us-ascii?Q?kXE07wFMWSikRvZ6z2GdfHVMBlZo+R4N+Z+r5L0EJC6TOYeRH8Zizap1V8Ai?=
 =?us-ascii?Q?LVj1GwTAduNm9ZYJcttC9UmKkMNSd8QOfbFZEAUDI/ATD3KJxGT5j6ohxXFu?=
 =?us-ascii?Q?RwCgSqn0Ah+/LgmPC9RHjDOMySAOm/Qh9CuM1GF5aSfR7yUU9mQNCn58Ua1U?=
 =?us-ascii?Q?15n2vn6GU2ux9/9zSn8FM7R1p99N6/e7XYZcuQPNAKodFRAvxth6NRHtfWRI?=
 =?us-ascii?Q?Y+PySNfeLUJlKTh2NHwVrBLU2k19Ph83Mttnp7YY8PlnW5MRhPvm59hqYWPL?=
 =?us-ascii?Q?8g8ykeMUA5JE9A8KgVvL3kfgeoK6g6DAKNjDZ27HNueY76Jj8SLE6G1onY8N?=
 =?us-ascii?Q?HydoD9rKKJ3dAuS8FZMOkpw2i3UVAGKIwOV3rMY22YU4RSRrtSxv+tZWJdR/?=
 =?us-ascii?Q?NlQoK3ep8kjmtgjbkJ9YxfA67nMECWYpeuWgIswmU+gOmkjoa71isprbQGKn?=
 =?us-ascii?Q?VEKaxf+/qzf5Y0qJN/vL3mdMIzQKFDMyFpE8Q+23mTNfEoNZVcghXSUArSx6?=
 =?us-ascii?Q?THLutaCcfVWOIjOt8XLzpAupxE10soiMC8eROHlpAiszWdhNQyr6xfNoV9mP?=
 =?us-ascii?Q?fZiNGYAETTDoTMgd7Do4OhKY5scEbhnnjzY8uvvwo1EFRc0SsA/6bY+0OYtS?=
 =?us-ascii?Q?fnJ9SdoXDcNzer+msPE3m0S23LG5s8SOxcRfDAGG6d+eg9v6t8XfunIItVVX?=
 =?us-ascii?Q?XYCVO7JddtE8a9ixyLFazVOHWOn3Lud7RoUtjrgrn0MlahRsSiX/WRfOK0dF?=
 =?us-ascii?Q?nlJC9a00unyGlsfuB3kiwPhHBYOy0tjCao/QKOakh9D0q1gIvtO9kSbdkaUJ?=
 =?us-ascii?Q?0ZPHCHevAU7Ae7rrHygtMWS9nk6i4uIBXscPmh4h4GyYqvK7TFrqcDvwFjvn?=
 =?us-ascii?Q?NRb024SSU+r8BI0oEeDwKDpxduABBPe9OR5OoxMoakt2Ibdnp05H6TVJiq5W?=
 =?us-ascii?Q?GMy4Vc58SWg0elc5O8Dy/yjhw1S7MKZRTdylOFg3qgknwb4wmeAgpFhiUgtu?=
 =?us-ascii?Q?HKQPCPfGmKveew7BXNh7jTczyvjX228xRcyR96aWO8ksHJs3z76nH2N50Hm5?=
 =?us-ascii?Q?RqyT4VTrqkQUJ10bYHrn2gw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23f762-c9fc-4208-eeb1-08dc5dccee69
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6498.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:23:13.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxZrgJ7pXUUIyEACKu+52WcyVNlkkUM4BZpBFTNVMNYoBCWIQCkMxg6PRy3m6478ZxQ36e3AeFz8EByD5aoE5jnXHxUkbnDJ9f2qxBgH4nLgofIej4JBy/qcG57thL+j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7742

On Fri, Apr 05, 2024 at 02:33:19PM +0100, Beata Michalska wrote:
>Some architectures provide a way to determine an average frequency over
>a certain period of time based on available performance monitors (AMU on
>ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on_cpu
>into cpuinfo_cur_freq policy sysfs attribute handler, which is expected to
>represent the current frequency of a given CPU, as obtained by the hardware.
>This is the type of feedback that counters do provide.
>

--- snip ---

While testing this patch series on AmpereOne system, I simulated CPU
frequency throttling when the system is under power or thermal
constraints.

In this scenario, based on the user guilde, I expect scaling_cur_freq
is the frequency the kernel requests from the hardware; cpuinfo_cur_freq
is the actual frequency that the hardware is able to run at during the
power or thermal constraints.

The AmpereOne system I'm testing on has the following configuration:
- Max frequency is 3000000
- Support for AMU registers
- ACPI CPPC feedback counters use PCC register space
- Fedora 39 with 6.7.5 kernel
- Fedora 39 with 6.9.0-rc3 + this patch series

With 6.7.5 kernel:
Core        scaling_cur_freq        cpuinfo_cur_freq
----        ----------------        ----------------
0             3000000                 2593000
1             3000000                 2613000
2             3000000                 2625000
3             3000000                 2632000

With 6.9.0-rc3 + this patch series:
Core        scaling_cur_freq        cpuinfo_cur_freq
----        ----------------        ----------------
0             2671875                 2671875
1             2589632                 2589632
2             2648437                 2648437
3             2698242                 2698242

In the second case we can't identify that the CPU frequency is
being throttled by the hardware. I noticed this behavior with
or without this patch.

Thanks,
Vanshi

