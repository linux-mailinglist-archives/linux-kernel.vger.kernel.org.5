Return-Path: <linux-kernel+bounces-166471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B304E8B9B21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D28A1F227A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06325824A7;
	Thu,  2 May 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FSXAB47N"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3477F1B;
	Thu,  2 May 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714654440; cv=fail; b=TgyUNxh4yyOzF67D5QTr2zG2H6EsMUcoF05kQThXI2Bk8SfiGtNL1IpKKFlqayP+a6wnsGvSjyEz1k1yIwHFqtYlubABEFIuI+FZDA02RVlyjFDM2vZGaBQOSty0pkpyPnwis2+HmBOOxFYDgeAs1qpZQjny8tjztectqQPLWR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714654440; c=relaxed/simple;
	bh=lhIuKaos05BBzcCfPS4fuzQ8TNMsKhHJqErJeYYX30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nIy7hclhvTl1TDa3HuJTnGhs0Is8KIWFub9+mYhTxf7mTLUGGwaEMS7wqEJLKHzuWi5ibahxoLSW6/P0chiYs79GoNTEkFhUdCb4bpeRh+L0CnyTk6adH5b4qX7kaF7HvMwGcPAYRl7EjaV/o9zwluyvRZ18aIuS8O9aOKlEzdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FSXAB47N; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jB10KidqainV+AYRvl8JSeN0iPc7ydlARBIC3oPYv7LDqpyXC/5flOB/1w1AJvY7bSyAlAMkFwxSvv+FtdOQtAZ3xlYWNHL0+mnY9kvYboFIQXNwIN8tV61hSJNnUPB3W0H9ZDtlfQPVKa2ibP/TsS7tHknvD5iF2FZNF7pgFbjVhadLEWDdD9vVqfELtzh3imYIXc6LG3tpJZtfGmq3ih3RH7dnAvTbMv40NlNXt+IKuSVJTxTJIcV8fiUnPnGR19Lt5TkfRVn20JFSwSy+d4aGnoq/cUB57Qrra9v+B+CADXkMcK2v3ORSrI2XbArv1rVhlFwdsmfe2IJEHrlCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmDqsr9S2bhBW120buMuq+l5EFoN7706t7CxcYKo3fg=;
 b=RqIOtAlBF2hEb3bVguGvk/gSqdQxQcmiKlQPRaTAx1MXrvvTiJEbR3rYU70Gw+Ud+RjEQmhFpxrgLu/HCbYyPGj28vk4AGnimzfzfNtdLMxyGR/lpA5nJ5/FLv6IidDGfnLsRcs7SvenX0mzjd9NnokJReVASI4SQbUgWv3W/E2KJnNcOf4htPUZ6jYgbudVTn4gaGBx/ivcG5NY8k3BITTQyv28QwvJZ8gOxiCr13s2AUrL5+aTIiTJLZj4/7aK1+8sy0hJFgZNlkWZKpBpbfwwZXrwtx9dE1lYlgaNQ0EkAzfNiVM/cSWf/oo12+LbLbmalMEJYTJ7U4aGUAkc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmDqsr9S2bhBW120buMuq+l5EFoN7706t7CxcYKo3fg=;
 b=FSXAB47NRcnFRs04s6EVb8kJ/fmzGUaGgxQBAJMds/WKe67JnvzG6YJEjY3CY+TVENVZrz/hFjWqwSFuao1BYC0o67aORoTx96hGLcjtcsDMIiibFPTi/YffKE3wRzZTmvzOVs67t0NwoqNiEn0mTeXJldqb8/HEUUvpGmC+4BE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 12:53:55 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 12:53:54 +0000
Date: Thu, 2 May 2024 14:53:48 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 7/7] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <ZjOM3CzLYY6jCpIn@rric.localdomain>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-8-rrichter@amd.com>
 <20240430172231.00002bd5@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430172231.00002bd5@Huawei.com>
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b799d20-42c0-41a8-a533-08dc6aa6ec6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gttjjhK4iBL5TVisjJ+3/JuQxHLCIZyl6OCRF9QjgEiq7pB3OpQDd9p8NGe?=
 =?us-ascii?Q?0Hbx7PeXX1c0OAdkXa87l3PNIMH+y/HUNIBBK7l2L4GINO3GnyrVTfk2GEf7?=
 =?us-ascii?Q?kl8kiasfFv9Q41AoZ3sEGxXV/RSrpxSvolsomfrLk1miXEDxOhL8Xe7wO0EZ?=
 =?us-ascii?Q?QP35xRwhWlA7yrg4cvzcMuvIxEYHUXVQSzr6N1gkoGknGKJvsz7h4YbtH7Gi?=
 =?us-ascii?Q?GZy2cOem2lEaXndYa3fmCjfsnTFa6zxn6dgvJJQHHezTmLmNXw+Ovx78UZVv?=
 =?us-ascii?Q?5jIX6317jAsh0wl/0/4lOdWFfeBv+kFrdQh8vIIbM0eufP4MGRUD6SoWCvVw?=
 =?us-ascii?Q?XJ8J6/nxHdBzMSaE8EOvTYa23dQ4ltA0suF/HRy9dbPRH5vkK1EdL6rm908V?=
 =?us-ascii?Q?H7Bdankf/lKYJDn8MrLvDYU4wuBecR15e0l57t/0HV6tNdeG2pGnBwfN6YG9?=
 =?us-ascii?Q?tp7+ZdfTiyJg+DpNvVKlbEAUvbG8iWkkfcwas6M+jlRBM/fgvGFfQptgKuN7?=
 =?us-ascii?Q?ZDJPsOSd3dOK0XkX8vj6OL+HEIJmxhcoKi+F+JE6W+Pz/kv4CnDxrbGlT2d8?=
 =?us-ascii?Q?rDfc9cJrd0ALxvWp5+h5K4h8uwfCconYrf5ioBOwhCFZxe5d7q7+Wk4KTgE9?=
 =?us-ascii?Q?5X1+QJqBb6k8LCjTxrBNTA8YV0DhV6lHcsjawTKEyr+9asrYB98I1q4yeJkQ?=
 =?us-ascii?Q?F0xH03EKQHgZyCE85JeSgCd/UskSF98hMQMYJb+MLPb3OTdU+0KF/Ba33DYY?=
 =?us-ascii?Q?odKTvCpi7WfpDlf+9LTtSw4vP1X/PH0QHiFw3NkkAVwpeRHiCSOMtNG5QSOa?=
 =?us-ascii?Q?mzgWB0Xv2RNOGYTUkIiZu7fJLU+wtSthrHJxMDegRKSkCbZX3cd91NUtWJrU?=
 =?us-ascii?Q?sPGK43qCK+C20ReLgMaIQlWzic8lrn0c3Va4FlPhM5IeQZ5MpgWeIvoyFpNS?=
 =?us-ascii?Q?1w3vsPJS8hiTcifIcVjoJl6jbV+ia8yDCoCZjvQ1+HLFHn+dv09c6bk2RXF7?=
 =?us-ascii?Q?c6jaXh9zJ/szaiEKw7y+w8R8zF4NPR1ViIjyRx7+nVRpYt2yKs9/vcpl1feo?=
 =?us-ascii?Q?pW9mUWZTb1B3+oGbZQMEpGdZsMoreP7ELqYR5eBpLHNayadHTGupxqwFwIem?=
 =?us-ascii?Q?xjjPDW3BxIeagW/YNyQ9Z6Nmk3u8T5OQKsND+fCJ/9vTahbteeVjWEAMadnp?=
 =?us-ascii?Q?Qz4bM/Pv6J/ZE7ylalobeQmpWrTPdPhbcxBVKPMs5k9TWWvEnr87dGCaz6hS?=
 =?us-ascii?Q?w0U9xub2bTRE2Rz2h9jhcqCYiWGEPX4Wh2DbQYqMUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55gVHuNVugGg+UiAY0uu+wpzYFb7tv5uPhozFet4vIe736lGugBwLCPqk+n/?=
 =?us-ascii?Q?56rqjxDdlU671iBVPD+M8kDsIUXIm7K0caswLN7+MuJD7+knLHpw4UVqTGmK?=
 =?us-ascii?Q?5eOub6TmGxZW6hQk7T4cJVjNjCx6XnATmV7UdbKEOtmB6US881qvFio0oXz+?=
 =?us-ascii?Q?J3P3j5mRewPSdfpiISS8RhbX3I/PUIfCmTv03igzTYbhXp3CGEtXzT0u/bvV?=
 =?us-ascii?Q?kOd6xXkdJrCs1/NldGUrOwgBNPiKJCl+cgjHrwbubiw38c7LLeNcZSK+fA7y?=
 =?us-ascii?Q?CKWAVI7VeGQU27L6qZWPiHSOzwpTVv6pmSFJ+KSfrDScvPg1TU00F4y876QM?=
 =?us-ascii?Q?2Kz6jdi2Lfx2x5zuENVno9wi9VU4CQfsHYG4xSBs/yNJFf8wLNvWMaZLGeOH?=
 =?us-ascii?Q?bhKkBmdhQsXzOPG463SSikleRPD+0Ei7tTkfWz2NpeE831WExaOMoJghGvaB?=
 =?us-ascii?Q?oPpCrGVNkPX75ubw734uaeHvsLXAvo+sryQQNjjGQQ2dIKzOVGat5UPfRZTq?=
 =?us-ascii?Q?98CIF5HBiLu+4DgKXpq8XBiadP50Zpu35UxkdBEJFsLvnx3hpbXWmFB8hetE?=
 =?us-ascii?Q?yS2SpNRXwbQWKeJZ2qXqJ8Jb9FW6GiItrT394+4TtK9DZdzUpDwqpw0YLROk?=
 =?us-ascii?Q?jgEDeh6OU9BYLWnIgrKVHLSkSkIgGdn//prYpqd9+YDBaqa5Vo9c9JIHMOaB?=
 =?us-ascii?Q?JUF51vcNja2gv8TaO3ZcDX3G0gQ7rElA5JpOlBamyruimlHD+7+LPzeL/Eiu?=
 =?us-ascii?Q?gthwdBG9ma3wynYrACc6jr3kfd9wqJdprNKB/5OW2jd+A4X929HubBmXk4/0?=
 =?us-ascii?Q?cmXVf9Z1Dmqch8AzYDlp0nWe2HZ54ganH2kqRlOY3msifSZOC3KvHYG7ZyZH?=
 =?us-ascii?Q?oTLsyK2xvCPh93/vAXEOqszTerdSUs2Yij5RWGUmo8HCK84QoOqYcrnBe4Tk?=
 =?us-ascii?Q?bRmijOSuMZE1odLKrZiKoi+8ocjm8hUFDYLFxD9tQUAaSuaWo2zKHCW+Y6n0?=
 =?us-ascii?Q?EVigfeo9L31iaT8fIyD7AMHkY70RZVr281JBtB9zN+Xv3cwOitTtwKwJu1ec?=
 =?us-ascii?Q?/MONS2bk4NqOUsnFOHxajc/NPv+PDm05JW8TrZiwBr3j83BIjeA3vsEYl7j8?=
 =?us-ascii?Q?7rpx2UD7dN5nnht4RTKKWxWrBDwf32HcwdGVJRE2fm3xSppFpPymIUZEwnE8?=
 =?us-ascii?Q?Posm1YJfzJB9I8FD++CmlAtq+eS39MiBXQlAwirLA2hxfu5I3n08t32BOO7W?=
 =?us-ascii?Q?FG8fRGaa1853dKk1oaDUVAlVh79n2tLb3K1dXQUYet2aexcxizDX9fn/ZcV0?=
 =?us-ascii?Q?GbwSppHdKyOmooDOJ/bo7bpNcLBrNuoVk2vVU1I3M7xzZzttxneu3Qa1fv6I?=
 =?us-ascii?Q?ucS+Itajd+O8XwiqVY9garl3VE1tVIr7sccurhxVEylV3fGzILfB3agqwJ2E?=
 =?us-ascii?Q?wKvZXUb5IRoCwQx0qg88vlZ9mQ2dEbivZtJyTcao3DrwWPFrFGcWeZwOE4O2?=
 =?us-ascii?Q?Iw8rpb0DjSZbilPuCtcQ1ZUF47SojLMOiIN71+2qwtxd5jMCFcKbuBcBp1nL?=
 =?us-ascii?Q?f6BGd4k3sl3ASdZI4cfQ+WU6PQmCVx3zJdDNvTFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b799d20-42c0-41a8-a533-08dc6aa6ec6d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:53:54.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhB6GTKoo7Ps7XmnJtjachFKxLI8qS79+d9NoUrYDrLVXtjOzpTrtNVVBMX5Tkj5vUmqM2ys4yLJeNGPnJO65g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

On 30.04.24 17:22:31, Jonathan Cameron wrote:
> On Tue, 30 Apr 2024 11:22:00 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The CEDT contains similar entries as the SRAT. For diagnostic reasons
> > print the CEDT same style as the SRAT.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> I'm fairly sure the interleave ways conversion is wrong.
> Otherwise all trivial stuff.

Yes, that's broken.

I will come up with an update of the last 3 patches of the series
after the merge window. Let's see we can also solve the arch dependend
issue we are facing in patch #6.

Thanks,

-Robert

