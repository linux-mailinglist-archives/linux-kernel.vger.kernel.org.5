Return-Path: <linux-kernel+bounces-109190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51D78815ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FFA1C20E91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4A69DFA;
	Wed, 20 Mar 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X9ZjZzNr"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5B628;
	Wed, 20 Mar 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953576; cv=fail; b=MKKpPXPuj1C3YtG4zvmNJun2OR+sVUvzUXqr7zeoPUIBzQbDEolnpxDF8U0qTTvw4tDONT77epC0mtARpjI1IYCL7jX8kCnX7mVfmg9ma+6gfy40ueYapULWhbNX5LB4rqvbSdou2H8Mxbr6WU7HwcOz85rebyVnXY2MyQRS8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953576; c=relaxed/simple;
	bh=qIMB9kKGUdYDAzO46OnnMiIs8PIrxj2Xg6CbuQaCbtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u20VjsyzdWv9OunS00CALtmPHi9+giK4CZNQeI8FaHpkIdgPMKRY/LsybK38O0TYS022S1dOiAjBj5PxPy1HYAMTUw9NidJHAn9T/mZsHKMNo//mIZBXCvE2a+RU9WOO81DV9oGs+XcdvBsFmU5fSlxzn4b0ZkEe5I0XTCaEeQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X9ZjZzNr; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5f4ENyKK24T5T2nI+mMB0FeppQw0Cmz+4xp7MzcQjKukAjb8vqZOaSet08zb2BHZ3p91afwrTVTib6khtk4SBdFxa17mbN37Yx+VILnj9V2PmjBBktGhkLr31nU+3C9nzkGgSOk5wjylUPxAnSWvpNi6LXcv5jb0VdervMHCB/B9jd9mJplLOs78+5ZscN9yb31d82B9s1a61qTdTcZGwtYDc1z85gUgxyaJ2gpfLdfmKit+vxWx3z2kdFu4u6a2ah0bOXC5CXZp3J4PD5avRLq+HhmwXqWTUHmaRvHZxz+5a+++aVurbGx2fLhiqsGhJfTuClaa9PXfoN6mFuHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUkoY+NG5UYJ3Ys+CKZkxTajm/wCwW64rJl0zDseK5w=;
 b=c18LluaZmY4bY98CgpfPiozIVDMPlAqAZxZQzSTEFO2NvqQypQB8oXjptMOId0GzOv49TTb0BKOz2QpooH8JbvTVa9Pgx/8TjiJUqTQm/Q/uPGr/wXEMKyEYLeAZCfzrRaxgLd7po6W3JWsR3bCwgYFVW5NyVuZRlwP9UdWV/LeKFv0blA/XjXk9rJDPwKdlmhkOeUuGXKVeUqAP/QRNmMYcWD3xeo/RVhyOx0yYWncLfrcs/QgXRIfPwcGEO3jVfQ9AGhKYpvqI9fTHY8IWVZLf8vDKjtBy+fpecqO7Eq9tJ2oiLGNnyeNqwEaBPw+1Qaa/+SVAEcCgIBH9qiN9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUkoY+NG5UYJ3Ys+CKZkxTajm/wCwW64rJl0zDseK5w=;
 b=X9ZjZzNrw2Ji2RAzA02dx0eDPWGP/7ssvkinEd+0+CZYka+/MDZhmY4Unh8FIeiY/Uo8++CkkNpvYm75m5LKfJvJEhSZXsQWqnTjM4KRd9rG1qqVpHsD49gRGIkfDyjkA6dZfKlKUuv4gx7cO2+a0TR70NEG3Y41g4uKNwdIoTaE/XkXuYZoPlvAWnGVz+Zk7rtw63ECJOLrIYlDreV7+jUaM2X2R1JCMm1GdD1BwK/N6KuDKdsW5p0K7DsIlh08zi8GK9namm94GMNSvUmdCXA3je3reJh/cblZq1bC1kIXIPUarawzBEVBsFF4vAXiCMHvHG7huL718A2ZvMzWLw==
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 16:52:49 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::9f) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 16:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 16:52:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Mar
 2024 09:52:29 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 20 Mar
 2024 09:52:25 -0700
Message-ID: <21a78951-2d4a-1d6e-0cd8-6a4a75ccb142@nvidia.com>
Date: Wed, 20 Mar 2024 22:22:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/3] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Content-Language: en-US
To: Beata Michalska <beata.michalska@arm.com>, Ionela Voinescu
	<ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<vanshikonda@os.amperecomputing.com>, <sudeep.holla@arm.com>,
	<will@kernel.org>, <catalin.marinas@arm.com>, <vincent.guittot@linaro.org>,
	<yang@os.amperecomputing.com>, <lihuisong@huawei.com>, linux-tegra
	<linux-tegra@vger.kernel.org>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
 <ZfGbyfBl35cyACAc@arm.com> <ZfI7pQtXgXAG7RBH@arm.com>
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <ZfI7pQtXgXAG7RBH@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e381b3-37eb-4b4c-ba21-08dc48fe2c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J9Z7c7j91sD0O35DbQ37f+ias4TTHTgQJjzC+tKxSmPY/rPlwsGK3+nGOBQd1YfLVAOEcTHs5susNAwhHxC0UE08Br/tvDjcjyJ/xF0Ji1nJz3E4tEbYB+AFd+sQApsqNujTRVQymPvbFXrUO7TjnOhwX+4yTIj3fhW0YOJ4PnjZnYlz8xjPJLqB3LzuaGYQ7W1P4qRvdTN0mhuHkP2GBz2zfIolbesCVlSVhN4JVWiC8IG755URaMcjL0eZAL4GLopPoJ7w6SfTxscv0EoODi+VBEB6c+u4fLvH2/d0sltefIXYI1yXWcWAForTPqbP7fo6ib9sJZprbdoU7Du5prOUtooTC4QVzoaPf9aYCQfZxquV+/+/gOEM8qhvTmJsBaxZQZ5i7sFzEzkvQ5k0Y4QZmOJ7qRFx5P4qgzYPbpV8u9szGMPGUkCZqtLfso+ynVaCtrOvatPBCTEDyUMXahTzTUPZCPEvZLqMkPr0KlboCtRmCCRjvuEuX2LopB3ZtyP2oA7mw6EuaTbpJX7GInNyliJ+8mWhjOp02a3qAWZitr00VHUfllcGXQs9LGhLB8XQ27Ebj2lejWMf/iVIdqu0/B7v4NgDu6E+N16DDS4DJBW6Ux8MVKrdEXt/WTuH6HVSeiwl7S6BLvrFWqPnq8bDEYQL9wNlOmIHF1l8wWIJxNx7EZk4SWXo5727vv3ZJ/fYbFrIDH3l4KcYDgFN00w8tsxG57LjDjGpaEigSy1e6YN1dH0ghTJgwztg4DcP
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 16:52:48.5436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e381b3-37eb-4b4c-ba21-08dc48fe2c9a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

Hi Beata,

>> On Tuesday 12 Mar 2024 at 08:34:28 (+0000), Beata Michalska wrote:
>>> Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
>>> existing implementation for FIE and AMUv1 support: the frequency scale
>>> factor, updated on each sched tick, serves as a base for retrieving
>>> the frequency for a given CPU, representing an average frequency
>>> reported between the ticks - thus its accuracy is limited.
>>>
>>> The changes have been rather lightly (due to some limitations) tested on
>>> an FVP model.
>>>
>>> Relevant discussions:
>>> [1] https://lore.kernel.org/all/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/
>>> [2] https://lore.kernel.org/all/7eozim2xnepacnnkzxlbx34hib4otycnbn4dqymfziqou5lw5u@5xzpv3t7sxo3/
>>> [3] https://lore.kernel.org/all/20231212072617.14756-1-lihuisong@huawei.com/
>>> [4] https://lore.kernel.org/lkml/ZIHpd6unkOtYVEqP@e120325.cambridge.arm.com/T/#m4e74cb5a0aaa353c60fedc6cfb95ab7a6e381e3c
>>>
>>> v3:
>>> - dropping changes to cpufreq_verify_current_freq
>>> - pulling in changes from Ionela initializing capacity_freq_ref to 0
>>>    (thanks for that!)  and applying suggestions made by her during last review:
>>>      - switching to arch_scale_freq_capacity and arch_scale_freq_ref when
>>>        reversing freq scale factor computation
>>>      - swapping shift with multiplication
>>> - adding time limit for considering last scale update as valid
>>> - updating frequency scale factor upon entering idle
>>>
>>> v2:
>>> - Splitting the patches
>>> - Adding comment for full dyntick mode
>>> - Plugging arch_freq_get_on_cpu into cpufreq_verify_current_freq instead
>>>    of in show_cpuinfo_cur_freq to allow the framework to stay more in sync
>>>    with potential freq changes
>>>
>>> Beata Michalska (2):
>>>    arm64: Provide an AMU-based version of arch_freq_get_on_cpu
>>>    arm64: Update AMU-based frequency scale factor on entering idle
>>>
>>> Ionela Voinescu (1):
>>>    arch_topology: init capacity_freq_ref to 0
>>>
>>
>> Should there have been a patch that adds a call to
>> arch_freq_get_on_cpu() from show_cpuinfo_cur_freq() as well?
>>
>> My understanding from this [1] thread and others referenced there is
>> that was something we wanted.
>>
> Right, so I must have missunderstood that, as the way I did read it was that
> it is acceptable to keep things as they are wrt cpufreq sysfs entries.
> 
> ---
> BR
> Beata
>> [1] https://lore.kernel.org/lkml/2cfbc633-1e94-d741-2337-e1b0cf48b81b@nvidia.com/
>>
>> Thanks,
>> Ionela.
>>

Yes, the change to show_cpuinfo_cur_freq from [1] is needed.

[1] 
https://lore.kernel.org/lkml/20230606155754.245998-1-beata.michalska@arm.com/

Thank you,
Sumit Gupta

