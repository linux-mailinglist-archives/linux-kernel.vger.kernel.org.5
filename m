Return-Path: <linux-kernel+bounces-166424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B288B9A76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31741F21C8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669BC768F0;
	Thu,  2 May 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMrnKBk2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9916341B;
	Thu,  2 May 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651882; cv=fail; b=LSEKxWBszAAlnWlW5l5yXLsB6ie/mg7kOc/nsDHbDo3ITN7wPfJJAWFwdLhHnxKn7RvBuFOh4rv7SQqM2sC+YVtg0mUdQ7CfXExLGRkwtB1r+OQX+/mMNf84DesxlXCoqHot5oVPtp2mqeXXyimnwQu4DonIJ38VTdfOta+CZrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651882; c=relaxed/simple;
	bh=Axx5VC8pFtYF0pz4BVfKURoeN+yPtt4rOyRj8K2UUGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X35gIdObwURu5PNJZMztY9+VHWXuj8+EmQBRmnJcrvuwjKROaQUpacFNur3wMgLDbc5FxB9+JH7H+73xm5thBTkDuPv3Nen2nobWzn3cQqBPGXSvs0sREAe+i5+QPXX6Bm1S1rYhXNIfFn5XtdEg3pXjtKpkpYxCIZxK/WI3ISs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMrnKBk2; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLt+JPqr+edGJG0+a7hOFF5FNGfDGpdxElFQBPIkYdme+ezKqtkm73m8w+tSFFNfULoJydeMjSwRZWiDeCrj0r/ShHkLi4o96+dC/+4IMdabmqWiKSOB7ooNKjHSPdkmbwKk3bcH3QVWPHKS/CNzni2ANtqYztsLlE+M4MSi+D1oPUQpCFkniterT5539aefvDZh84vbkPCnAo/zQ7imikuFQi+EZXM+MTQOvR3bqWHbm86GwPZSHamX5/vwKKg67d0RyhOdCZMzXFhG7jLtaXdb+5Mc3Qkf/T1yZOQGnCdIekyOMFFUy9shignlT9cCphuJv+DCxubOeICCSyGl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPqGDiP0U96FhEeZTYMvrjOIzoax6UocW7QQ8RSkpCA=;
 b=SDbGtfhaVQXkC1yGi1OjMmQrL79qM7kPjnVcaN+KlvDEwgfMXYfiTmGr3NxAqyDsh2VZ8imNY7yKbHo8/yqJWLL1IzuwrIKuQ/W97ZXOsTrg7hAY6WgzqFJYbM1H2QP+x5vhrST/Eah/PVk9UA3bzGDiOkmc+dUlqKQN6w8RYG7fPsKXOkIWsiZd7SC27WftkQwzT+K5u/+VEU3kSTPe/XpxfFwk8NXU63PUni243l00RrCLM4R7LZr8p57eCyN9j9ucyAi4rraOljMQG2Mikryv/rdo80t443kPKJWTLmPf4DAe37ygoK6dc8u/dHuDyRtBOWxmJW0hFj6msMQZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPqGDiP0U96FhEeZTYMvrjOIzoax6UocW7QQ8RSkpCA=;
 b=vMrnKBk26zz/J6JaoMiTiZrtnkhY9OOaLH9rGUZXiwJzib/zrPIUr5EhqY9s/jefhbutye3dEYffsRhm7jXXilo2nOThod74Sunrg9ux68UKAzIbctc0Zrel5hta8frcStoCQqWLgxhayIiYGpn0cLmkY0GWYuZ2E6PSM22Nwvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 12:11:15 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 12:11:12 +0000
Date: Thu, 2 May 2024 14:11:05 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZjOC2bTWMO6NnSOk@rric.localdomain>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-2-rrichter@amd.com>
 <ZjEZeHOlCSUMvMoD@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEZeHOlCSUMvMoD@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bb8949-8423-423d-57dc-08dc6aa0f566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8OY/PXem2RK+7yy/HoAUkVggEY2gg2zy265ijJIbW/20+eD7GqBaBi62hEuW?=
 =?us-ascii?Q?cBe/CZY+gXZWZ3jkwZSOLA+jV5vXSZP2IiiUUE59TtzqBOwTxpPegRAAnJne?=
 =?us-ascii?Q?mvUgaOwARKg9o8NMMxIxmA8X/SUsv6K6dq55SIv8V26EoPOLOi6JNimitHuR?=
 =?us-ascii?Q?Gg7OxGwmiZUmPCH+e086OsukldP2UCXNcrb+kSO4DwV664bnu1ex5RxB6KmA?=
 =?us-ascii?Q?KF0TNwCyg7nKvZXKZq/GyLpaR+hbpEl8Cvs7JXKORd/IVQSfSgArx8vMgcXp?=
 =?us-ascii?Q?25iCjiaNBLNYPpnMbma8fbPAL7CrMmFv3K7K9QWBuX9Rh5cf2ZziVoLIZMdu?=
 =?us-ascii?Q?oNTnMY83UvOfAnIdmbkA1eEJba+0lkgXyFFKBDPxNNjVhUM6CWxRU5/XgkNO?=
 =?us-ascii?Q?ULR2SQ+pYUwoeNy3blDdR29pVdCIg+IQf2j90B8bbElW/kJIpxtJE3BSWL0R?=
 =?us-ascii?Q?Wqu+nXa3QUrixv5oV3DwzaQBvp30cvj15hBLAuIyVk+8Vije8sTt+O6ge4kJ?=
 =?us-ascii?Q?nAXL4QLdk4PeIYNWa75OrvwzkeQAtpMXPRQjlnigQ2WObEjyJR9p5P36R+jP?=
 =?us-ascii?Q?Dc8p4pQ8k3UDcuyGUGeWk0sB8rq7SqBx1Z9t2y73hIEhiMsdUQHbHosLYgVr?=
 =?us-ascii?Q?9RuIEiEhLwdjP458zvttdjx9i0nj2L4/fvbPB4HqQb4R08Y+zBFV/NpXOyhS?=
 =?us-ascii?Q?v8NKuHDryNNKKkeUk3kZmz7QvXjn1R+fku1qBjAPt+r6H1pC/xpguNv0tv4V?=
 =?us-ascii?Q?hzba/apxMOn8ypqnqDK/jXGH20jAKNS/zLgrZec5R2R3T7jazYg5lkO1bOVw?=
 =?us-ascii?Q?TqKmiCkd3H4F8F7O+qzKICZvL9pwPrnj6KvbikswHJxCVd2l8SCWVv3k1aPR?=
 =?us-ascii?Q?sY6kQoZSPcnyw+wRbuLU9KzUU3NQ3zg12GViCvv/CXVs6St2PHOBVkuo/RC6?=
 =?us-ascii?Q?TX2jkkMIFn5L4BWpIfflR9nESJvLFEEaX1c7DHV61NrZ4hvtEcMYGa+/sfrC?=
 =?us-ascii?Q?lN9uB9t9RlLPVWxECQBEQo/TKDJ2QRS5MiOezCAKw+QQiXz+f5uCOK8HEj/o?=
 =?us-ascii?Q?+rh6Bh08cNfaCSJzn8S+ifDMJ6qg4wZP4xqsnlEvw9lthHsn3PdprOBzdcsM?=
 =?us-ascii?Q?If+cMKhra5YhlsTxyeA65uike2dEMUlqz4R7zRvUttk9HyNg9r6QE5MM9W84?=
 =?us-ascii?Q?F1XATlYOdio1lsVXGpgvjJCGSjq1FDuvdGWDSLfx7nMqWrcx0Nwa/8Vpk+c/?=
 =?us-ascii?Q?0Z6/N6tedxzLIxkXu7j6i5qRn7/iHqJtwf+ri5wOMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RRIDWrkCOMZ0FVeAb8105tdLwCUTkCXUXMBFoqZU3zZDa1C10trcszphwvMm?=
 =?us-ascii?Q?MSp7R0oc3iY7WyoSDP7AFQpixTAwcidMytsir40N3PxLxM/mmNTXBHRCKKXp?=
 =?us-ascii?Q?dYcCbuZXDAQHemjeY979fly9DHqATjRWrAhEaaBj9z+ghvJaCA4c8EXgL3MH?=
 =?us-ascii?Q?asSNIFsOO5kL0giFxOfm5nRKQox6NHRxRF4n7l8yCRrJCBBSc3hKBKN71Pzh?=
 =?us-ascii?Q?lmzBjho3FFtzUR3vjYuoW7QTwm1uGhS8Rbu8eGm9w3dqz6Gxdnr6ReWy/zEc?=
 =?us-ascii?Q?ENDSjt3rG+wAlkwFneRfnBCIixy4CHpw8YpPTAZVQ8ST/8F0YR7c4HsczaXC?=
 =?us-ascii?Q?Tf/QSdKGOO0pN6RwL+lMA6JwnzoLTM4+T4PuIT5AGTmT5FBc4sMpS4mE73kF?=
 =?us-ascii?Q?FAkSSQMltgMb07PrFY3LhUT8U7b1ap/y7s0rGoAormF2Dy70tpvpOhb6yzSe?=
 =?us-ascii?Q?NlHzBt4zdvG+FbRXf41tmvusf6tj4LTQetJXSr5MRu3Em4lKD/1JGgUjeHbD?=
 =?us-ascii?Q?oJQgV+FB4oDoswV/Cl1wHoSzgqXZlj2RIVt4AOhPjBSjYb9j4DBWcvfzUoSC?=
 =?us-ascii?Q?0RY3AdXAtVaS8+aT9u8EMn8kOlhXU3o7yBzR2Quc7EHSo/yP++XE7MVGDIMF?=
 =?us-ascii?Q?c0INj6lvEkS9mR8c+nzQyPVckLvvRleLG+Qi2I8/HvkdcZWQgxkGb5So6fEm?=
 =?us-ascii?Q?OExS6z1wyuysXz5hiekQ3X+zNT5dzoUgEnyXBmL1uRSjHcPn1LCrw5MiicCJ?=
 =?us-ascii?Q?CZSnDd/ktnlabEly5KXMpQ/NAQqkLX3rEYpjt0/MWUBPhjUaMka6LJkG3jRe?=
 =?us-ascii?Q?53QR68Ah+gvATHWf3U7rAw6laa2kYQRSI8nX5DAGm7kiZ+spHSmoU42mw/GD?=
 =?us-ascii?Q?4mdOsHvN4GX5MNLHxdwt8VmgA9o0sRdGcA6Ll5cH8WsDyCSyzU8XVX77nBXs?=
 =?us-ascii?Q?KQPcZY2HuR233ePWu81EGce6XnYyQVM59O5vN/IYpQDwmipoYpxtraHfLRiE?=
 =?us-ascii?Q?HAcFrytupfuZM7yFsH2NA+LEclHN/sYORTQNmmdEeAQlAPWWxRKbSSfimFO8?=
 =?us-ascii?Q?wGs2P7Mf7aKl5Epp39roNlqJ+QJ/M5zViid9srvEm052jnZyzUkw7kVOmqSB?=
 =?us-ascii?Q?tr3io6vqWGU5fdpGp45Ljo9eQe9/oEaOUpWM+3QDrEKpXexTzklQNn7msTEX?=
 =?us-ascii?Q?qGwz2ap5PrlQRoIclRyTwQiThWri9lEPeQ8VptGWNvp64UQv7fdDxvjfP0Ob?=
 =?us-ascii?Q?Bx16NVQNmV9CAPB6Hld8icCBao3oXGMh9fuf1sNqckgrKucdLEbvjqT5QqLJ?=
 =?us-ascii?Q?0PzUKkoGKAa/50Fa8NKCP2Z8F+pyUm5HKGUSr5Xv6zLzG2TQwu4xjt8jPmjr?=
 =?us-ascii?Q?zbQn0uuboD4InJ1OzjeLRNH/AAeVTH7up6puo6vKyNk5s20F+rf56rC/Lhii?=
 =?us-ascii?Q?cLhaTVWAsgSM5dApM14u29Pe+m56jXNcpTGsGairw0+2yTIrLzDiuS+90wU8?=
 =?us-ascii?Q?2HrgxsGR2Lp1B5KFiIfN8AhNadOCx8Rd7afIzj0BbNkfnY9yZFzDLad4+vyg?=
 =?us-ascii?Q?nKDKSIGMVgu4LQUFMOi9xtYbyAQ6gXJlGIk8o5bx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb8949-8423-423d-57dc-08dc6aa0f566
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:11:12.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZ6LS36JvsyhTufiCTrZwEGDEqZqJTn7wa/UVgFGGM1tFSLFuA54C0/nYVDbg5OH2tBLgGZ1aSk7MOQl9cJCvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

On 30.04.24 09:16:56, Alison Schofield wrote:
> On Tue, Apr 30, 2024 at 11:21:54AM +0200, Robert Richter wrote:
> > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
> > SRAT lookup fails then because an existing SRAT memory range cannot be
> > found for a CFMWS address range. This causes the addition of a
> > duplicate numa_memblk with a different node id and a subsequent page
> > fault and kernel crash during boot.
> > 
> > Fix this by making numa_fill_memblks() always available regardless of
> > NUMA_KEEP_MEMINFO.
> > 
> > The fix also removes numa_fill_memblks() from sparsemem.h using
> > __weak.
> > 
> > From Dan:
> > 
> > """
> > It just feels like numa_fill_memblks() has absolutely no business being
> > defined in arch/x86/include/asm/sparsemem.h.
> > 
> > The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> > applied to memory ranges hot-onlined by the CXL driver.
> > 
> > It belongs right next to numa_add_memblk(), and I suspect
> > arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> > what to do about the fact that linux/numa.h does not include asm/numa.h
> > and that all implementations either provide numa_add_memblk() or select
> > the generic implementation.
> > 
> > So I would prefer that this do the proper fix and get
> > numa_fill_memblks() completely out of the sparsemem.h path.
> > 
> > Something like the following which boots for me.
> > """
> > 
> > Note that the issue was initially introduced with [1]. But since
> > phys_to_target_node() was originally used that returned the valid node
> > 0, an additional numa_memblk was not added. Though, the node id was
> > wrong too, a message is seen then in the logs:
> > 
> >  kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
> > 
> > [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
> >     CFMWS not in SRAT")
> > 
> 
> For the commit log above -
> Perhaps the Dan quote can be reduced to a note about the implementation
> choice. Folks can look up the Lore thread if history is needed.
> 
> For the code -
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Adjusted description, thanks.

-Robert

