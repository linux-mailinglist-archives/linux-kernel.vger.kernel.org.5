Return-Path: <linux-kernel+bounces-135725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505789CA64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DD51C23FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279E143876;
	Mon,  8 Apr 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QnaR3weE"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2106.outbound.protection.outlook.com [40.107.92.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A3142E9D;
	Mon,  8 Apr 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595986; cv=fail; b=gCcmofzeue/AjFIcy6PkdSCi8NXKo+ieQuULGiybd9md0dyE2snvqu/980THquy2ipVM7eRzapqnqHOYoI/hUAFfSJhJ9cCA0IWv/txxPtUiB5vbl+a2/tgXn3Wow3dJxNbB7CtPcsvqY7eOGYNcCcNZR7irif1u/YXIm/kZnkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595986; c=relaxed/simple;
	bh=nNoKAkLTMmY0o12u40AwRpdsOAvrAdFonDmzHcuPgtE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=qGva3i9NQJ0UlAuV+voksK1fuEVavjQ8Uv4IqB0WWOv5bS7wJLLgAz+cMfQi+ZLAkRo1hDxvj+bzTTgdT5ZDt+qOjlHilP3gqjdDgcdk8+lXt9lTNffyEFABeyFWq7oPIG2wM1QdDwjl7mYrtBWEN5FQB3ZGUb6HwEz4L/qcA28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QnaR3weE; arc=fail smtp.client-ip=40.107.92.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKDwh2JRCc2m47RjWuQHDjJLTLDd1K/xJItduEjY8JPXQRaOlF2vzIByaWtfuDY0risCsdCMTfspLufRr9dPedLmYcugTZkd1lNQaIVqstLGJGyfzeSp+zV9IjBqy1+Kkseh74wvU6ddqt0DPXXzkJNU4svsI0Yaly1npOehIGgbD15pR8wbES9PK51lfm4JtEzBBJCn/iI9+2Ak2BuCq6fMQXKHifLctGn4wdLxzuI1SviW5TKdVVMZq/JlyEDf6xg+5XDhvNzs9yTb8dQfHtWRa5+BXZLWuL5hbk3n2Necb1SB+Cg/VqxRCDbR0FVTLEtTPTBOIbtPfKDBxRma7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNoKAkLTMmY0o12u40AwRpdsOAvrAdFonDmzHcuPgtE=;
 b=W017H8Fv0oeKDqfBgBGYk+2vIoRFtWoPEjpPfNHF8cZFlRRyUS5UA9ScipRU3MSM9nI59EC5QCxVA+o526n/aVNzHd/LneuHzGpfgQgZY+EoZ78JKvnqWd+snQZeMO1kDgUhD2KPCmjDTliErrZw0tAIdX/GppEPpRxHFs44FAMDKyiulmkPXWC6E25NLGDOIhFBAn9t75d8nuAX9TqcijroVOxowEGiaRDqUgHRUE964SaZG0vlW5E2X0DMO3CKDCo9G9hbmZCoHaj4ZIUoz5M2C0yOI4FORTsB7mkugWciCJcLwJCmjFbNaW+/lSOqOtFLpMUib3osjtbrqi993A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNoKAkLTMmY0o12u40AwRpdsOAvrAdFonDmzHcuPgtE=;
 b=QnaR3weE2Q0u+SoYxWNkHoFZ29DSRuz0ii+E8O7KjL/OC2RKiMa1hA7OFUuFsrQan70CVH0/TVnMkIlGTP1mYoWlWfMB8jqLeLK9fLCV41BAoCqWd23dfhEfYAMMxR/LyaBk53oq1pRf+UvI3i4n5VvwBfrpPFj50VqBjgPuGQ0=
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 PH7PR01MB8418.prod.exchangelabs.com (2603:10b6:510:2f3::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Mon, 8 Apr 2024 17:06:19 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::7ba2:4e8d:3bb:6e1b%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 17:06:19 +0000
Date: Mon, 8 Apr 2024 10:06:14 -0700 (PDT)
From: "Lameter, Christopher" <cl@os.amperecomputing.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Huang Shijie <shijie@os.amperecomputing.com>, gregkh@linuxfoundation.org, 
    patches@amperecomputing.com, rafael@kernel.org, paul.walmsley@sifive.com, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, yury.norov@gmail.com, 
    kuba@kernel.org, vschneid@redhat.com, mingo@kernel.org, vbabka@suse.cz, 
    rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org, 
    ndesaulniers@google.com, mikelley@microsoft.com, mhiramat@kernel.org, 
    arnd@arndb.de, linux-kernel@vger.kernel.org, 
    linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
    catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
    mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org, 
    jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org
Subject: Re: [PATCH v3] NUMA: Early use of cpu_to_node() returns 0 instead
 of the correct node id
In-Reply-To: <20240327111740.f8d3802b0eae15bcb8727e04@linux-foundation.org>
Message-ID: <1fee24cd-59ab-4843-6ae2-4e49424199f6@os.amperecomputing.com>
References: <20240126064451.5465-1-shijie@os.amperecomputing.com> <20240327111740.f8d3802b0eae15bcb8727e04@linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|PH7PR01MB8418:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VaWeO62N1sYtgQOBUbhczRAZL+HpgZdtaKcv39Zc/49NE8QbGpUSXtxSb/4JAoKUF15D2H7m7Ijm9/VoC/YXzeOwVZ8gWkyz50mX8mEzRC/4hXok7DSDmYhNbsQqYamrH52f0F//Am8uK0GWwf6NpfZFttR5Jzoj4uLWk7dGWz/xHqV8nWeXdQqkpbD1YOlUT7pFAG/M65lzDFXr3p53L0orAcmX1kpeWxsc3fTHY4kWcbQ52OpTjSfJ7SnjDtPugahuJbGx3DrDPh7TVe52vxvXGRNKBs67iOT+Cbjqi1iw5/qLcQJLwxAIs8VniHFuuVfhCHg0Kf1SGKF/+JyBKu5IBb2VSTTxf93QxLrf0NkeV6MWS7mFS67U5sCiCYcUCOQOGVjPRMgdJRTzismxnw5WstivwG4D2ZBB2Za7N4SZ+jbp+rERBLOfmIgSz+NVBa//EpEr0Rmh1rL9iIcBnI9ChZku/tzk4HNcav2bW2fVx9CLqOvtiU34r55xZa2+cVWfoZC6mHytov94cjy+bGgnRPfqXtb5/5NKuiT/wrDgSzYCIyDJlaMgvQe7niK+ygPCQTcOMqhrMI6Ypxn+jdAK+tMmpxLlG+8lRAre5snksLTDqY9/ffjG1VqsKEPnk7YXTM5u6Zx6jjZElSC3uxrON5OclerTD3NJ49mgtGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wqoEqaYevCIG+fPhWivk6K/K6xcO+vVUPqJoT0zcBYJAKL9bdGp8CiYMESP1?=
 =?us-ascii?Q?vw47pNsI8ysWiMAKx6eVBpf9D5Mk7z6OBt3yj5fjrQcqfu+PN2fiT5ASoa24?=
 =?us-ascii?Q?JL9K4/KBh5nZPFXKGXGqFGi0l6YBS9zla70Q04IE+iUm5c2/W5oZAhmMBMGE?=
 =?us-ascii?Q?EBt/mCatCiN67j/60HZMJJNO8vkjg2y3u+C+LhF0Pszzs/uZ7ceT4pBQc+LX?=
 =?us-ascii?Q?/Dpx7N+fyHtUocxs2HcGsCd1Lp9eXCDv0LH6e+IGrt3ZMfC6CKaRPzEEDArt?=
 =?us-ascii?Q?l4pDHHHHX6994TUv8+/Qq8XgC2SFZWMWDSNloLMJTWpa5LvE7C3sQZHFRrmL?=
 =?us-ascii?Q?z1jCtdYuThZ2IbeRBGM0xM1xzz7pgajaroBuaqThGoy8lmf6fwv6PagCQV4H?=
 =?us-ascii?Q?f4BZHuoBOaQ6JDny3BeX9BpnPxmPV2JOKep4jZv0wwcjrFi5DhfOmhYqkhuz?=
 =?us-ascii?Q?6Rifv0LtSWmpv0sbEbIQScTBiQo2e5FtyLVOZUg41Qe3AQr1JyrgYwyOFg9e?=
 =?us-ascii?Q?5h7fefnlss6jw2BkaN+9ZUizY1lstKg7pYjDa8HaRUEGdLnmfKK9uufjnUV6?=
 =?us-ascii?Q?m3LvpIxxsyhatUtuUV7MxHm+TcGLnOXUDkdzzXjgISKz5U5t83AOzImY9yPa?=
 =?us-ascii?Q?k9IKyLhydw9Mxl62vOx5nltMBxZ5rFSJm9hOJAQ7b8kdS0k14W9E/z7qBXrM?=
 =?us-ascii?Q?OsPPK0GPJZ322bvZ9q7BUAS6jy4p5Wn40TO8vUwSL7y/GyJZIZ2hR4/UZr6Q?=
 =?us-ascii?Q?9gt7nCVj8Y5Bw9k8kUj99zg6h9NhG5YhWqsMuznTgsMhliyFmurnRIjGWkkj?=
 =?us-ascii?Q?mpBVVceEedemNICy4PJoibfobI+wT0dwgqdA5LkNg2QNLM44CJXwtSedrdqv?=
 =?us-ascii?Q?yLVZClze38TQNPHBg8WZ4KItyE3fxBvaWfzRJk1X7gBpIurjzc32AG0qoLjQ?=
 =?us-ascii?Q?EPDzW7V88lIG3IPUtDGQpVHoMb2dtrK9OXYwCendFUWQQHKi1BjtL2V+a7sL?=
 =?us-ascii?Q?tNQYy4qLynmfdp9BLlsEaAzxDGBHDmxA/YEUTSsuVGupxIU6zLqMV3HDmVm7?=
 =?us-ascii?Q?nBxR2Gs5hAUTeNW1I2MUq+K5f88qSAc5tWfM5gYHoJtoAaIKJnTDyp9hgtnN?=
 =?us-ascii?Q?Bhh1zBaS4nGBX87UlXMcs1gQ1HpLbUTIrLIkvRZoquWv0VfPzJ/QRvT2iKLS?=
 =?us-ascii?Q?74n+OiJ04nc+KnJ6nECgPLqwJM37WSIcwwq07lQiT4lcwSjQhOREBNd952xa?=
 =?us-ascii?Q?Uat+OBJrLBRSV1GxZWn60b2JnM9GzKZrYoiAN999A/Poharcwwx9SKnBFydP?=
 =?us-ascii?Q?jgXyiZ2boDVDMocgYo8vw2ViItukGNZhkXcXsOi2cV98IzAGfBXdSW0dhhUL?=
 =?us-ascii?Q?7XwG/ydPyaU5Ct8kbYtC8X3a6o9Cepq2FjCGMxRaGlysnANhL11dVWZIwqBI?=
 =?us-ascii?Q?MerD+HCPdULHzY/jZWxlm7JoXmpQMwHFtxYlhUAsrY3DOmKlAWeE0LRiAhd1?=
 =?us-ascii?Q?dcjg36g32ir4afcbX8l+99q8qvUtFNx376DkA17ig2MEIMubDyehjbxlBe15?=
 =?us-ascii?Q?z+LqliEeHu1HVwIJ+FLz9AXacAc8SyNYTUxcvW/UF+uRyfmsAC3j4a4coDwi?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbccd8bf-1930-47b1-da78-08dc57ee3516
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 17:06:18.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybuCdCIoL4XveEY+r8vG1FGxhF0uFuZdFTpXdURxrQH2RcOJmrblZZFT60+a5JE2XNQ8hvhdfSHV3ScdWaxwYiUKyy30kguSCD0s+CS7Fik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8418

On Wed, 27 Mar 2024, Andrew Morton wrote:

>> In order to fix the bug, the patch introduces early_numa_node_init()
>> which is called after smp_prepare_boot_cpu() in start_kernel.
>> early_numa_node_init will initialize the "numa_node" as soon as
>> the early_cpu_to_node() is ready, before the cpu_to_node() is called
>> at the first time.
>
> What are the userspace-visible runtime effects of this bug?

Performance is reduced since there is increase in off node accesses.


