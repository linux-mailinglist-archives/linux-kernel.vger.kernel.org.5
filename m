Return-Path: <linux-kernel+bounces-166418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21F8B9A62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDAD1C20831
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541B7442A;
	Thu,  2 May 2024 12:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G33EW+Ty"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108517D3E6;
	Thu,  2 May 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651205; cv=fail; b=BEfP+4l1VFvIlRm7Tu6pBctyLZacbswuTA+zP5OyPncxK65OB1sQ/f8MOrjpm5KjK+TO+dOkuaivvumn6ooZ0Hlyb4nS3rF46ALA5L8G1A6L4imdoaX/T/t35KfLOLjS0M8qFSH61lnj3Aae1b8QuR+DfCTmg3OtU2wptrd0vPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651205; c=relaxed/simple;
	bh=VKM1OTM/Hu4NmTWlbVkbhoW3smmZFxAYw5gYt33B3cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eWeY1ArpathJ+SSeU29xwi1qdgMzp5raqOhJhzuNUAo2kEjz8DjiBksRQjwoSMcbxI2OhGblOC02LWmSrhN0sxGtjyZDNAK/xFeKf/qRlEWo+qBDYhlldMk3lzz1ScHcNyfRwRsAQ5XYzPYiTijgSmSda0jz45OlRPLpFI7qr3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G33EW+Ty; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feEWScMTB8SkqxrQytX4x1gvNv2dTSWltWt7mFp+r/YOaHRcF2vxGqvbV6VNr2ytFPwQfLbcYcOQzZvK6uZ6J3biPHZl9Qwn/devZks7g/MDNKaTUMtBWq/f5CAcKZSGrjM1aWmqzyE3Wvf9Y/ovzvbGesI/Znue9y1AegNBGM+8ud/nT/0T6IZiumqgsOMmaJ3KLa6RBf0mNH+NsCz4CarodAtxEDm5G/acOKUsN1jQdh8pPBGaVBLW46q0fbbpWzmF5hRN1z5PR0XIPdNRCAz1JOmxuooryqJUsWCNUagP1MQCTy7wzAhe+HdthvFmnRVEp6Wc/D30vG0Pe1QCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKrz8hQt2a5bh7DR3KlhBUuo7wiJ2+dyFEmCN6ydn6k=;
 b=ZPnwAmeyw+/dlzliDFXQhmXl72N7Qhz0GIbkVgPIogoxlOcAyOsq+bQ3+Tt+NaLi7Fkd+gT/EfTMRUC2ygGK/ft49Wp58/49FWepsBveuCbHgfv6JseLeLL/xbX5MT3SvcSKZdYvNO10QH8Qr5v9v6QWUZ6tCta+hs2n92B7pPeyVxvXdTRCmHaW5BkaiwV/LAq293j1bNpvXAAVMzYVeFXpoY+HFwWFSTgxapALJm+wIET/dTKZhrsibwgdVfEhNkHdCJRut29Bpu1P/Rl8eZae39xilqvtp6imtAOBWaZGSzDRUXAiZiHpJ77ISSD95042sp/+ByB8Mptu/KiypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKrz8hQt2a5bh7DR3KlhBUuo7wiJ2+dyFEmCN6ydn6k=;
 b=G33EW+Ty2h/FPns3ZYW0tLp3XH3M+vt9oYRGDUe/tvECWaUlKQSfW9nCCjKlV4zPcoGKrsf5Hxog1Rv0ElgWqHJ0KR+5gjPp0PfUVIghP1U3BuUxRVIsg680wgMU5MUiM9JFOuCdfzX5H3iMzSs28u/ZALWFuUeiO7HCAhg0aFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 12:00:00 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 12:00:00 +0000
Date: Thu, 2 May 2024 13:59:52 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZjOAOGInZDO65b_T@rric.localdomain>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-2-rrichter@amd.com>
 <20240430154856.00006d15@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430154856.00006d15@Huawei.com>
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d63c0a3-3984-4770-c664-08dc6a9f64f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+8JsrNCbuGPGhfSK387YmI1Km2ZLTVCDC/wEcl1a3pyoNlemU2usqWY/bAl9?=
 =?us-ascii?Q?zUFXjzd76RRkPMaYRPyWTmc/qSC/39rT5ZhDh4P49iA+t9cQBq7fjFNUE/MZ?=
 =?us-ascii?Q?RfiRbCuer8smr7iSsLifFNJHi3FonQnvH3f6pIrNLZsjypk4u/B3pCux/cL3?=
 =?us-ascii?Q?em7vJE5AlA41OUSiS/OY4nM2S9qOqDgMwN3vvMPMW7MJJYrVME+vZzROxZSM?=
 =?us-ascii?Q?V5GeCQzW/a2AKbYRebyXNlcVXxZOMlXiMGZOoRRuyllHZFP31+7kSItWDx23?=
 =?us-ascii?Q?zFeo3PEVTwN69LyadETleowqJsDg60FhCWvMTueoEnQwUX7zxhNbOgvQAa/c?=
 =?us-ascii?Q?Q29rQFJnf9JE0vG0bBCLw3vdEsRG1z3xCVxwSlkQbXVbt35t/Z9iWe1qd4Wb?=
 =?us-ascii?Q?lqV5sjv+To17quchtbvQ5EXwRUJSUK9ZgFDy2Cprd/cz9nu+GpXvRn3/ShYd?=
 =?us-ascii?Q?yiM2JNEs3xYMXKezM7zQ3KfiKZvsMX8ZO/U0NFWsg1BDTLw06PJpeC77Yzh/?=
 =?us-ascii?Q?ElYxCxw68NxhrILWLN6uSF5y0R5Hnew+xBgV+IRvMyF0Otrkz8TlXzozifiZ?=
 =?us-ascii?Q?H/zyeEtSE7s+PXDkqjga4e4jN+OKZa5yCBBqyWVmH7CtDOKAQhXOYXmyMxCG?=
 =?us-ascii?Q?6j6loxEZHZpg8+u5bpGniRwc9T8D5Oq8J+J6riQl3SHXxynGPGiqbSMwEINA?=
 =?us-ascii?Q?ecX5YD9DTrnYTDGnhbjTtVGZ+k0Ch7D0NpfwWvC+YRW2MZDBlz1QSlXnE0/f?=
 =?us-ascii?Q?BYPcnzaLQeWiDLrhdHxovuma4uuVsbv66LEK09eDSdydl9aWcYIqDDVbGP2V?=
 =?us-ascii?Q?8xK524hvfa+O3ggzCn8SntIJ8bRViV6bqANeoA8NHPjZ26+g/aemS0xodDMX?=
 =?us-ascii?Q?zr+7qVCSJCzl9KzkC1YI0Wte1zbaB1Zg13pWC9EdHPxd9m4jGxSoRN6pGeqk?=
 =?us-ascii?Q?OTvA9tYcj2MdVT4+teXMGhGhtCseSfWuiGoPjtvz7Pixk5hiWSJLJW4a4vLy?=
 =?us-ascii?Q?5CRNqby40cfIEmbgMsdSNnoxCl9iZSbKZw4xfZnhUWcB9vY9XVCLbizLfL6A?=
 =?us-ascii?Q?zwsj7FQ8d6Wjyzm/f8pAay/6Jj8IxgqNvgcTGzgnQ2iEJLsvpmW4T7G5NhFz?=
 =?us-ascii?Q?saCSEC+BGekyk6fjGJnzGH3/BA782cYbYkgpX7lXORLGvVM5wlnjBKy6ouq1?=
 =?us-ascii?Q?ZYAuezjBgbytftilHDYG3Ul6ntzDJqmwU5k4WQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Vrh4rn0exeAhm4lYZTajKIurXEn8S8vxmwraKDEpWTMzR/fEZ7Jt1mF7+BV?=
 =?us-ascii?Q?Nmbk0q8rA8ov1T588piJ4uWGu0YFNowPjgecNSDJW1Zfyz6HHsKOtna8elBp?=
 =?us-ascii?Q?x6eNYybV3ARNJ3tOHBcL0IuGpMdQkeeoapiCDF5cTvtH/hHnNw90NUcIgfP1?=
 =?us-ascii?Q?csyREaVXHFtp/a8ZSME51+tEm4RtaluVs9E8D7ACsyI0zAF53ALhUhyWga0d?=
 =?us-ascii?Q?a3qEFE4ZkEi56Lu9AqDcM5wnzlCRCxFsgxzIb6cwATJPwPRg7hcpeGajENSa?=
 =?us-ascii?Q?n+2s+LSmhpLmXmprYe3rmCex3qaHKlzyEC9tYdBYeTNycYbPvXMuI9yNqFXm?=
 =?us-ascii?Q?2/LhYdm9bWjvneKzZma1SHij9udQXHaD40XDJ96pVWhgAds2LaKO9MtNrn0i?=
 =?us-ascii?Q?j++oR8Y0gqO+kDHZny1tx6A2tWSzFlNPSUdsPLpewCqvJCM6YOUlogRZYU5Z?=
 =?us-ascii?Q?aLhyjz0EXQEJyJ+rXH5OQGOvr7M9u1sUOJx12RA9bCBsKA8neI1c8JG/ziqm?=
 =?us-ascii?Q?cYN7CqYPfj4o7bzRlYC0sPTx1wDqRnrhB+ap0LGNxnn2U7pfB3mQsnmzOxw4?=
 =?us-ascii?Q?/UX6awOSV4Tv/nWO6zJQUTlqKbay6AlA308az4CNFMUl+LbhWu0erHY3YEd+?=
 =?us-ascii?Q?VNXtzfZXForNxRehF7UrRkItimgFylnk1b2greIyNsvf3NFJuS3TziDbuwHV?=
 =?us-ascii?Q?X5ywmVp8I4W4zhiUP6G0X0mTP3Sb4M3P8JIibfO/t8ud+dfCbgJzDMVBGknu?=
 =?us-ascii?Q?VnpLVKLyn8B8ESKiCZVfpno9GwMX9D+AJIJW0y4tbqno8U9KMrA/cwihHRIF?=
 =?us-ascii?Q?eqvhlaQ16qMmFC2M9htImWoXjYJWyodaMgz39i11jW7IM+rA0LX3oCh9gEy9?=
 =?us-ascii?Q?eWjLDmtdqyhEJvUyRqaiqfqmxK3SiM2QGH6VF5ZkwivHK2Y/DG7EBUJ4J92Z?=
 =?us-ascii?Q?IQrO1XiXQanFij1tbZkQ//r5FZzWLFYmIXswLK8ePx2SqiT8uRHGx0kOZkvq?=
 =?us-ascii?Q?YqRkwkM0QrhbpoUX9hR9/LZkh0pkaXxiaNRvWkA8F4B2XQTVL4zqdnd+6hj8?=
 =?us-ascii?Q?9YHhYbUK2wTVA6jwTUyf1SQaYAeUBuFP3bb+XD4wUdRXw3sFvSC/Oq56eq5h?=
 =?us-ascii?Q?xaeKzFCdy995U1J83C3NXYn6EboAvSKV2zXDEawA93+a7hXRYqK2ZsaufM8i?=
 =?us-ascii?Q?EmiSKfpVS9hXhlW5QdiF+73S4EuqVR5RdZIR+a+B2Ta7Qd9ixPLjMNYaSx4J?=
 =?us-ascii?Q?GbzLlhpwADVADiZIqBzpObpMAMd82qu0eIMc5qEmbtfEym328S2a2VxG5it9?=
 =?us-ascii?Q?PQodnPY8L9Qa3HIt+V3IR61TPZtRCAZ7lVFsvf3J3g0TRdHZPmt6Q+Gh8hK0?=
 =?us-ascii?Q?muDnnRRBbbIUUY2lcF/lwf32eh4I/oya9EI8/Kc8Zigt7UlyZiLBTUUN7lPu?=
 =?us-ascii?Q?mwe4oGl6U5gAWEoEVP9dGCEjaLbrzWCFjlGpNvnMCnPMQNRtVbG+oLHgNxf+?=
 =?us-ascii?Q?UdyIAiKtewezVPXMhhMwjUsKFzVXnhetJoSr2lkf3u1go3gZagXpFONLlZAl?=
 =?us-ascii?Q?DtUk46rPmrykNHsGWCJzn5J/M3yzUgXSzoAwpD0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d63c0a3-3984-4770-c664-08dc6a9f64f1
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:00:00.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2kDDO24ksAHCKju1MdL3HNDGaedRRJs1/ceo4lhQt6iQJNvwhNgu34QBXbszJ7es9+5y+LlbLAeywdwixjbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

On 30.04.24 15:48:56, Jonathan Cameron wrote:
> On Tue, 30 Apr 2024 11:21:54 +0200
> Robert Richter <rrichter@amd.com> wrote:
> 
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
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Cc: Derick Marks <derick.w.marks@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Whilst I'm not particularly keen on an arch specific solution for this
> and the stub is effectively pointless beyond making the build work, I guess
> this works well enough for now.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I was aiming to post the ARM64 handling this cycle but it hasn't quite happened yet :(
> Maybe we can look at whether there is a better level share at than
> the whole function once that is done.

Thanks for review.

It seems better to change x86 to use the generic implementation of
numa_add_memblk() in drivers/base/arch_numa.c. That already contains
code to deal with and merge overlapping blocks, it also checks memory
attributes. But that is not scope of this patch.

-Robert

