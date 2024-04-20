Return-Path: <linux-kernel+bounces-152346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECE8ABCB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49264B20CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3945F3F8D6;
	Sat, 20 Apr 2024 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gX8atNjs"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081503B299;
	Sat, 20 Apr 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713637731; cv=fail; b=o7SSzSCrShU0atop8G0meOxjc9EWwbvfZ+wgfW33PUA9y3HsHxndChyRfZQZrBZpnSoAUt0xMmxDaGzPD+XJs8ZPs3YDjHpGQpRiHU6QbfXdW3ingKgVZMFz2yXpRPE/LCsJul2ichrL1H6lse+GSpTmvtcdJJzjiNCWa7HsDQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713637731; c=relaxed/simple;
	bh=pnxIGrKR5wdCtZmcwUSpLwsbZasAJ2IzVsP37FsuVZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ufsg6AsyxCpakozpAiSTR0iDiS2750ivEA6FpCh9UO+OcyKXIiLZzSOAOPa+Rj9a7ZjwVvVtgoksSBrGU46/P2Y3Ojg4An/9Dx44IRKALNuwOenouIGOOd1yuRwkTFJaUMkGHDsMdWcx3eWSeHdr/GI1z/XjX6VSd9Y+88w2ZwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gX8atNjs; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKc5yxOMP4Iv2Kg5xFTw9B52i1RJQ1rcDlHXlGGGS2uDmeSxcYb4l8DKIY2fZ1gUpOJw0zZ6VMHM8/pdCvwF47QHAy1b3LO5JROQDYFPAq9eecf1HUYGeBuXs/WKxU2rvFP4wv4y4jZK/lok7ETAs4ghmOEpO270OXpUwnXlDajx3G1LkYqdNshLBSRumW1/V/sDCYN8zGV0eN+CphW+Wgz+eYL/yNKDLRr3R5/dlOPHl8cGNvTnstxjipA4ZSDTHVDt3M0jB9rV07xk+eCfSTUVZuMsj+2RQECryM5f7SK532A99a6qnrTetpQHd82rOw5MT4CgAWdYWBzKiDkEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZtHmHup4DzWyy5k8MC2tLXy6u+/oo6XijzNgiQ5phQ=;
 b=Pv9iKj3Yz94ZdY07WUoSchBsrTrTqzMVx4qbIR3foKeavI72Ctm++dOv5PHYJP0eGc0v/EP3pdWPI1Ctes+jX8clK0VdOwjxXGhu8EO4YCHa4GQvXBteTq27OTp878eh1YSC5sjsxtWVA7muUqDlZ2VUQgTqZncdcKff5B35r19HjX5YEowCi5zdxuciMzmNh7ssom8SOA7PyZMBem8YVU7eOj6fKAiwzZxyl6Ua23IiLPX9dg+G7/0z6IkrML0cRDmF1PY9yJtHsqA1LKQFZNvxTWQS/U26BSRKZ18kGI7OglqdjvTtBWEUJyCFpL6SWXJsusfuKfB0zzZ5rrknYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=e16-tech.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZtHmHup4DzWyy5k8MC2tLXy6u+/oo6XijzNgiQ5phQ=;
 b=gX8atNjsFYHHEhfM4BGn7vsWfit+G7uNo7pskqN902VE+9zydTL1gIsi8Alc/fvFuRaTLkldu+6gevW6dtjbk4KEKXVZbcFF5JOISwutG5qqKmmOdBWwwRxMhjNLABtuqFCpy+tYfPPxBhfvnsZbdVsoTB/XFHVdAxgN8Lx6fkgKMgu5cadEmRvqZkefvCBe2mzxU5DFTEX7LOCTM+Ieo+SxxqHTf08vEYRKI14woUNIL0f4M4M/nbM1xjEDh2zuTnRg5GJXg9D1DCbAcpyxTABpd5TpY//2FQisT+bJNmziKyo5d00SzCBofVInBDZ90iclRnCM50kErsAHixYqlA==
Received: from CY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:930:8::30)
 by CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Sat, 20 Apr
 2024 18:28:47 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:8:cafe::40) by CY5PR03CA0029.outlook.office365.com
 (2603:10b6:930:8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Sat, 20 Apr 2024 18:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Sat, 20 Apr 2024 18:28:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 20 Apr
 2024 11:28:39 -0700
Received: from [172.27.21.38] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 20 Apr
 2024 11:28:36 -0700
Message-ID: <220e55df-a0a2-4272-b94f-c7c4c6fbf2b7@nvidia.com>
Date: Sat, 20 Apr 2024 21:28:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.6.28
To: Wang Yugui <wangyugui@e16-tech.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<torvalds@linux-foundation.org>, <stable@vger.kernel.org>, <lwn@lwn.net>,
	<jslaby@suse.cz>
References: <2024041758-unvaried-agreement-8d7b@gregkh>
 <20240420135914.2AD9.409509F4@e16-tech.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20240420135914.2AD9.409509F4@e16-tech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: af9fd48b-24cf-4eab-700d-08dc6167b751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG56R0ZMS2FOd2dEZWpLUXVBV05uUTA0M3BicGdmWlNWQXdDeTF4ODBQempY?=
 =?utf-8?B?dE9hV3ZOZHkzeEtmR0cwQ282cTR5RzYzaUE5RksxUTEwMGI5TS90STJzMkh4?=
 =?utf-8?B?RVZOaGk5cUNaZWNodDd6NXFWTUQxNEsxWGtRQW5lM1UyVUEvSmtPWU44MDAr?=
 =?utf-8?B?YkRrNDIxM2Ywai9qS1VuWHhnUFdVYWlzOFF5TGVOeUJUVjZ1dENlWUVOVG9Z?=
 =?utf-8?B?OHdBUkhqNWttZVZqNDE4SnE2RUpEdVBYaFNlTlJWc0IyRll0U1VMSHNwaGxG?=
 =?utf-8?B?MlBaT1RieFh2ZFJVdVVKUUV2OTMrQTJYZ095UVhtUS9sTThHZ0NGcW5uQ2Ni?=
 =?utf-8?B?Z1Bmakc1SHVldnJBNWYraXhVU2h2eVYxL1BsSmJtTmVtMkVJdmJRN1h3OWJY?=
 =?utf-8?B?Tm4xUU1Id01pRFlrZEx2c01kdW13WHQrNkl3YXBCR1NIbXg3Mld3YnRlK0Jr?=
 =?utf-8?B?ZDhEQm55VHVnbG1wQmlrZlAzZDFQRGhVaHMxRi9YY25uVndOU1BoZjFGTEEw?=
 =?utf-8?B?R2pUUjhSeVA3ZG1ZR285L3lFZnBWc29jaTRWUlNxZUE0b1JBK3FzVjVZUlFG?=
 =?utf-8?B?dEdwbDF1WjMwLzd3dzZEcTd1N3JydTZXTW9XUWVDbktFenRKYThHQ2NWV20r?=
 =?utf-8?B?aDh4RERRU1BBclZLRkt3MVhwZUdKOU4vbERIQU8xR3RNdXZsczhrMklseERi?=
 =?utf-8?B?N3VRM1piUU1tUXJ5ZGtsOWEySDlLRmlTVnhHYnRrRVBxK0ZNdVdxMzIrS243?=
 =?utf-8?B?VlFRUEpLekZZRlhjdXRMaUUyYk9tTUNGK2dRUTV4aktkYUYrVExNeXdwcmNz?=
 =?utf-8?B?eWFjWDVVVzJjRzd5NzZqSjRLTlduSE9LTlFiRGw3NTl3VXJuOVU4Uk92dHc3?=
 =?utf-8?B?SlVkQ05mUTRYSzM4NFpPOVVNWERTcWUyNXZ6MzdOZmhPMjdhTnBMcWpySEZ1?=
 =?utf-8?B?VTYrNzlnT3VkTjJ1QU01UjQyTzZ0N0hlSEZQWjZiTVJIcGMwUkRpTWRSRFhI?=
 =?utf-8?B?UGpOby9iMTRnbzVqVS85cDJvYXp2N2dLN2JmeGpMVjdtMU1rU01uRENJRkZZ?=
 =?utf-8?B?dzF2a2p0KzBiRWk0cWZYdGYvd0NMbGo1ekRvNVZuTGlwMDNGMThZQ0xpaUNU?=
 =?utf-8?B?ZkI5dkRNMC85SUZwNnMrdm1iTWJFby9KZldmSTdTNjRCV0Y2bWFJYjhTcnBi?=
 =?utf-8?B?T3BUd3l0bkQ3bTF4MldyS1dFeGF5THpORVVYY0hFUWZNMFgvQXQ1REJ5ZXhm?=
 =?utf-8?B?aHFjNFdQcC92MG14c3FnMmd0YzNtQzlPU3Zqd3pEZ21MeFhQTnJPeVdWbS9j?=
 =?utf-8?B?UDJRb21JOUNXTGwvbnhOaytBejFUYnhLUS92anJIS0dzR3A3ZmFNUlkyb0Zj?=
 =?utf-8?B?cWlSUUhtNTFETkU0cVA5Y2duemNoWWJIdk93eEpDZjE2M1phaTRrNkc3eFc0?=
 =?utf-8?B?L2JNaUY3aWFlbTJyeCtCN1VseVJjeXZUKzBjSG5KL0Q4TXI4M2EwVksxclFw?=
 =?utf-8?B?YUpUNGlrcGRRb2JEYXYrK2daRnlnR0R3S0pyLzlGSS9ITUJ3K0tVYkxiTlZD?=
 =?utf-8?B?SE9sMWRMcXRVK1dmMjdHSTByUlRpL3BVeVlDTjdya1lIaFNmU1Fab3dHYWt3?=
 =?utf-8?B?UXZabHQ0dmpsSGlJKzR6SDRhUEdzN3lCQlIzbi9Yb0ZrY0s1UE8rZGJwc0lQ?=
 =?utf-8?B?cXJWQ0lmSjlLQkZ2RnRhVk1VODVYUHpaMk5jUm5ObklxcmRwb2NJVG12cE1m?=
 =?utf-8?B?NVB2cmxnOFViMXRrWG1TNWpHUUdyTDZmc3ZNNFNpTDZzRnJJaUhOL2doQWo5?=
 =?utf-8?Q?sjaCDoDCNOXqw5QxsjmOaUXfW67yL/6BcdyaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 18:28:46.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9fd48b-24cf-4eab-700d-08dc6167b751
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621



On 20/04/2024 8:59, Wang Yugui wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi,
> 
>> I'm announcing the release of the 6.6.28 kernel.
>>
>> All users of the 6.6 kernel series must upgrade.
>>
>> The updated 6.6.y git tree can be found at:
>>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
>> and can be browsed at the normal kernel.org git web browser:
>>        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> Linux 6.6.28 failed to boot with the following panic *1 on a server with
> mellonax CX-6 VPI NIC, but 6.6.27/6.1.87 boot well.
> 
> After reverting 'net/mlx5: Restore mistakenly dropped parts in register devlink
> flow', linux boot well.
> 

there is a similar discussion in net-dev ML[1].
In short, it seems this patch is missing from stable, which is 
prerequisite for the bad patch:
0553e753ea9e
"net/mlx5: E-switch, store eswitch pointer before registering 
devlink_param".

Wang, can you test it out please?

thanks
Shay

[1]
https://lore.kernel.org/netdev/20240419162842.69433-1-oxana@cloudflare.com/T/#m9a8dd7f2e76d805baf2ea441137928a4dc6a11a7 


> There is already a patch(*2 ) in upstream, but yet not in queue-6.6(for the
> coming 6.6.29).
> 
> 
> *1 panic info:
> [   15.114364] BUG: unable to handle page fault for address: 0000000000001118
> [   15.114815] infiniband bnxt_re0: Device registered with IB successfully
> [   15.114822] #PF: supervisor read access in kernel mode
> [   15.134119] #PF: error_code(0x0000) - not-present page
> [   15.139652] PGD 0 P4D 0
> [   15.142553] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   15.143055] infiniband bnxt_re1: Device registered with IB successfully
> [   15.147233] CPU: 1 PID: 1253 Comm: kworker/1:4 Not tainted 6.6.28-1.el7.x86_64 #1
> [   15.147236] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.21.0 12/11/2023
> [   15.147238] Workqueue: events work_for_cpu_fn
> [   15.174498] RIP: 0010:esw_port_metadata_get+0x19/0x30 [mlx5_core]
> [   15.181056] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 d3 e8 ce 28 9a cc 48 8b 80 b0 09 00 00 <8b> 80 18 11 00 00 88 03 31 c0 80 23 01 5b c3 cc cc cc cc 0f 1f 40
> [   15.200401] RSP: 0000:ffff9ec05bf1fb98 EFLAGS: 00010286
> [   15.205930] RAX: 0000000000000000 RBX: ffff9ec05bf1fbe4 RCX: 0000000000000028
> [   15.213364] RDX: ffff9ec05bf1fbe4 RSI: 0000000000000013 RDI: ffff8bdd1d696000
> [   15.220801] RBP: ffffffffc1134c60 R08: 0000000000000000 R09: 0000000000000000
> [   15.228235] R10: ffff9ec05bf1fbf8 R11: 0000000000001000 R12: ffff8bdd1d696000
> [   15.235671] R13: ffff8bdd9541c720 R14: 0000000000000000 R15: 0000000000000000
> [   15.243098] FS:  0000000000000000(0000) GS:ffff8c3b7ea00000(0000) knlGS:0000000000000000
> [   15.251480] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.257520] CR2: 0000000000001118 CR3: 00000004f9220003 CR4: 00000000007706e0
> [   15.264955] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   15.272383] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   15.279800] PKRU: 55555554
> [   15.282790] Call Trace:
> [   15.285523]  <TASK>
> [   15.287905]  ? __die_body+0x1e/0x60
> [   15.291675]  ? page_fault_oops+0x151/0x490
> [   15.296050]  ? __update_idle_core+0x27/0xc0
> [   15.300505]  ? exc_page_fault+0x6b/0x150
> [   15.304700]  ? asm_exc_page_fault+0x26/0x30
> [   15.309149]  ? esw_port_metadata_get+0x19/0x30 [mlx5_core]
> [   15.315066]  ? esw_port_metadata_get+0x12/0x30 [mlx5_core]
> [   15.320940]  devlink_nl_param_fill.constprop.23+0x88/0x5d0
> [   15.326679]  ? __alloc_skb+0x87/0x190
> [   15.330594]  ? __kmalloc_node_track_caller+0x55/0x130
> [   15.335897]  ? __kmalloc_node_track_caller+0x55/0x130
> [   15.341196]  ? kmalloc_reserve+0x65/0xf0
> [   15.345370]  ? __alloc_skb+0xd9/0x190
> [   15.349280]  devlink_param_notify.constprop.20+0x72/0xd0
> [   15.354845]  devl_params_register+0x150/0x250
> [   15.359456]  esw_offloads_init+0x181/0x1a0 [mlx5_core]
> [   15.364967]  mlx5_eswitch_init+0x4be/0x6e0 [mlx5_core]
> [   15.370471]  mlx5_init_once+0xf0/0x550 [mlx5_core]
> [   15.375601]  mlx5_init_one_devl_locked+0x7a/0x1d0 [mlx5_core]
> [   15.381676]  mlx5_init_one+0x2e/0x60 [mlx5_core]
> [   15.386616]  probe_one+0x2b6/0x410 [mlx5_core]
> [   15.391382]  local_pci_probe+0x45/0xa0
> [   15.395367]  work_for_cpu_fn+0x17/0x30
> [   15.399345]  process_scheduled_works+0x8a/0x380
> [   15.404102]  worker_thread+0x165/0x2d0
> [   15.408082]  ? __pfx_worker_thread+0x10/0x10
> [   15.412578]  kthread+0xf2/0x120
> [   15.415952]  ? __pfx_kthread+0x10/0x10
> [   15.419928]  ret_from_fork+0x31/0x40
> [   15.423724]  ? __pfx_kthread+0x10/0x10
> [   15.427692]  ret_from_fork_asm+0x1b/0x30
> [   15.431827]  </TASK>
> [   15.434218] Modules linked in: xor bnxt_re zstd_compress raid6_pq ib_uverbs sd_mod ib_core t10_pi mlx5_core(+) pci_hyperv_intf mlxfw ahci libahci bnx2x mpi3mr psample i40e libata tls bnxt_en megaraid_sas scsi_transport_sas crc32c_intel mgag200 mdio i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod
> [   15.461684] CR2: 0000000000001118
> [   15.465213] ---[ end trace 0000000000000000 ]---
> [   15.476059] pstore: backend (erst) writing error (-28)
> [   15.481415] RIP: 0010:esw_port_metadata_get+0x19/0x30 [mlx5_core]
> [   15.487856] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 d3 e8 ce 28 9a cc 48 8b 80 b0 09 00 00 <8b> 80 18 11 00 00 88 03 31 c0 80 23 01 5b c3 cc cc cc cc 0f 1f 40
> [   15.507043] RSP: 0000:ffff9ec05bf1fb98 EFLAGS: 00010286
> [   15.512493] RAX: 0000000000000000 RBX: ffff9ec05bf1fbe4 RCX: 0000000000000028
> [   15.519852] RDX: ffff9ec05bf1fbe4 RSI: 0000000000000013 RDI: ffff8bdd1d696000
> [   15.527209] RBP: ffffffffc1134c60 R08: 0000000000000000 R09: 0000000000000000
> [   15.534568] R10: ffff9ec05bf1fbf8 R11: 0000000000001000 R12: ffff8bdd1d696000
> [   15.541934] R13: ffff8bdd9541c720 R14: 0000000000000000 R15: 0000000000000000
> [   15.549299] FS:  0000000000000000(0000) GS:ffff8c3b7ea00000(0000) knlGS:0000000000000000
> [   15.557618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.563607] CR2: 0000000000001118 CR3: 00000004f9220003 CR4: 00000000007706e0
> [   15.570981] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   15.578356] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   15.585733] PKRU: 55555554
> [   15.588679] Kernel panic - not syncing: Fatal exception
> [   15.594163] Kernel Offset: 0xbc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> 
> *2
>  From bf729988303a27833a86acb561f42b9a3cc12728 Mon Sep 17 00:00:00 2001
> From: Shay Drory <shayd@nvidia.com>
> Date: Thu, 11 Apr 2024 14:54:41 +0300
> Subject: [PATCH] net/mlx5: Restore mistakenly dropped parts in register
>   devlink flow
> 
> Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
> 
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2024/04/20
> 
> 
> 

