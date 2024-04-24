Return-Path: <linux-kernel+bounces-157232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D148B0EDE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D291A1C22712
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A4165FC3;
	Wed, 24 Apr 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zhZIqDeT"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391D215F400;
	Wed, 24 Apr 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973291; cv=fail; b=DXLDDIOAbNTZpYf3rmrXnQfzMb1wDEbH9RRjS5L7xmtfxCyUgXVdUzTEcroyFA90oFsgU3W6LMujazWTG399cC6PObqONH8jyPCwfGSZngqcb2n5VSkdFiORBrPbecYgYMH79DmU7lDoQqf75+lrAuioguI8xOsFW1Wp0Jq6Exw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973291; c=relaxed/simple;
	bh=iVUjpaPj/rv72SP9avh8OPOWDtz5t/BNkUtIJN4u2hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n9d/HSQm+9qmDiytPY4/f7D83R9mnimZmotANiGqzNU4q1a8INp7oxnY+SQyO0dQ4ypG3Nc+f9UuZZBbrr+skA9HY6AfrBRg/6HNkZ9+Bx48N1c2Qd4Ykqt3d9xLD73/RGDg520S9KsFCv0bZ42SUj0wyxRwZ4QQDHjOGNQB4Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zhZIqDeT; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE53782Xdi5Yw7CnO1gV4dvFqkQ+UV2mOSGE9eG1AUDTFVdOMIq/ZQxXEcnNykl//0XJ/+UcHVNRzk+oFBlzjFHD/t5mh/xvJwYOYRWZrsUMxXafV1q4tqRQJInY38jrlzqcXJqn5W9O6OAaqxwBxKupDVBtllsXBL/W3GOpWfWlboEY18EpCY/iuUKYAjZyhar5JWoWWxBDpJH14CwpDy3o7QypTL58I29KxALp43eBIrh4FMjlgyr/t43P/YvQXMqk6hEjY0b8Yadw/DlUFokKTnayP/bCFSz1/QDeThtl4gW7ybTCptJMFTrvn6Ps8sO/dAayXlydQTG0BFIYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmTl0JLnWY42HQ1ata0PYJEYdNLp3A9tRmrrMPWxmcY=;
 b=OHGMEmp1O52YTX1OuP/ekCiYAbywd+pZPdS9CeZeYyinzwYNkH/a+iv0lLV7Jq5MNKSCrKeQdhF35l8/1361DwQJiE1HNTibdGHRuf1Jq7l0vb5M60NxmCEK4O76P8KeGZ58QkK+llE2ZOFpZrEWBehCt3FBso87pogUMYnx7lVAy/KSks5WvaN5aS+xz+xBaw4FkdJwSM26qHcyFGVelxhUJmicfagqcPQA+rlmNwNqUyqgIw9qOJLa6H2j5yECItuXVinWoTdzm9hIbfYehWiQJmaHKHB+0kJpgqxEUCqeZxEdgCVfpUkN38KT3pFNQlPl85+EXCsaTkgzQwmxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmTl0JLnWY42HQ1ata0PYJEYdNLp3A9tRmrrMPWxmcY=;
 b=zhZIqDeTHcrDPWHoP8M23LTBLMX+hMEVqBC+VCrbOYH+gdtHKSUbHns2XbZcBJ+GNo1HCNwiZW9TROls+pN8EvdZv6giGkMwFsF+UZQm5wL9SKyMtstNlANm0vXL4e5sbwV62GleupJNxTYr1Pd1RJFLxN7q5N5rAk0shx9EeA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:41:27 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 15:41:27 +0000
Date: Wed, 24 Apr 2024 17:41:19 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/5] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZikoH0zIOEGtw2Mc@rric.localdomain>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-2-rrichter@amd.com>
 <66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 37468764-21ed-4f20-b0a4-08dc647500df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cQPGEd2VYtWvAWOfbRHBAAITFt6fz3Rc1+iFHdXeAb9kaFUTQpRmZUAH4PBq?=
 =?us-ascii?Q?FpLePW1r8ct177ExXqLNRGMAuHBQa8WgWuLonR0cAHGYFIKDIPpN0e43WT/h?=
 =?us-ascii?Q?/9Q0v2fsSzGs9zCmyBmoEY3DsQqAfmiqZo4RnhSdE6UWRaA+X0A7atLw8aFJ?=
 =?us-ascii?Q?AR2vza6SyOfQ5UXG/ZliI4amyHmddPwYzv/zjxSFlncWE+K5CVHWANYFUl76?=
 =?us-ascii?Q?78x/xevwD8v3GHe+xL8ESTUfQzkmrcQEC/UsUbarMEaQq9WGr7O/cU5AuUVV?=
 =?us-ascii?Q?UvSYhrKijdzzc7NkJQK5arMFlhRQgtj4SdV/fRj5SgXUSVsnApKCIEbK217O?=
 =?us-ascii?Q?nc+X9T2ILUJfUxIvhE+3ioTTKu9TMVzIfoolhV+IDdqHaV24GzOveinnEHpN?=
 =?us-ascii?Q?ujI801gfXO/+U3FYXphnMA5edp1anvi9aQbBZYvxD45ArYMsEf2qkuISsU6E?=
 =?us-ascii?Q?HE0JeDFPtIQfV27XDunMuhja8BjbmI/nrJTMQ0HLFinF6hYj6yW9HUpa8OnH?=
 =?us-ascii?Q?bhQTNA3bfngxA11x7eGJ7dGDxMde+yoOjoGpZMkzkp5MHw0YICNEDUrVlZHR?=
 =?us-ascii?Q?Ckh3IoNS2iXOT6U+oEpIbX4E1JE0bJ055TxfDN5F9VzJSyEpNP4jXC3t7sLt?=
 =?us-ascii?Q?eXzKe3GHSx9eCaEBqH93ezJHa31k4659B5FF66FyU8Jbzf8Q8ZlBbD1I12m6?=
 =?us-ascii?Q?3+CCbZ6I19ytA262wzjR50R/5U926Jw91qLf7MJ9vKJ/QZKWtF/rD3ILY945?=
 =?us-ascii?Q?qTAfiU1Th/5XsEdfuqOxQbyyp3B+U6btihZFCDKg9rd8LkM2BekZgo/7vb6x?=
 =?us-ascii?Q?y7EIGf2N7/lUk+Dxf3uEP9IJGDO1xGza4DpyAdwU5ZKeKSVivcerdZhdZsr3?=
 =?us-ascii?Q?Fcs/ZZ6ZbUJjFVtt+G/1al6O5ofoTqEkouOGZF1yjeCJiNCMUTeeOL6FgwD1?=
 =?us-ascii?Q?o4zo5QBdNUZs3Cl5Zd0phIZlB+KJg2VuUrcfy/Up10AKrv9dQ8g1fjEOl5Fp?=
 =?us-ascii?Q?K29/ThaGkHy/+0DKXmT3J5MrGyUCegSdIS3PwJ8CbGlQjyqW5j0obJ8CgtJo?=
 =?us-ascii?Q?0k50gbPiJlTxcJfDh5Wh7a59zCnCtob2aCGStm86x0qqTAUF3dfqdg8KJHeV?=
 =?us-ascii?Q?Ys5ZSMzWsbw7T+dQDNQx+gK+SmL/0Zt3TqBNxFsh/bA+ITNlb9AzsJM7yppN?=
 =?us-ascii?Q?tsSQLePlyKZIiZcIp/9LpegFBshdEkdzrTRyWSRyJqdHmZWZnxgmovYeps4G?=
 =?us-ascii?Q?AaNQpm4+0/9tN74ilkhRfFSkjUGto/rXKOAJFKR6Xw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gG0/TDn9Xo//dRuFh7n71+qKqAV19Rh+AFFHXfCOFJexd7lU5UP5keQ53gZS?=
 =?us-ascii?Q?9D47ODwjDo+wJWi9Wo59xrQDbMJwOrmVtcBgjck+XrkVt1w0WZvsq6rO3flZ?=
 =?us-ascii?Q?W+ojNRruLeQjuHJeYPFsPK5rdeNVqglpkNnWUB8Yc2mHTocrbYCTJ7f3kMGp?=
 =?us-ascii?Q?Nj0jTnasMnqRx1FpZHrxCFpo4Ur1SYjGwju/0T6ZUpcrvyX9GaK7VjxKiiuJ?=
 =?us-ascii?Q?SdJkYMJoAA6K0WtSD7ZhFoiOLYQZxzOinr77KGSd1mKPM35WH7plYiw/lfgK?=
 =?us-ascii?Q?rdOKpbXYUpDhqE5WhG8o60H7NBGbAs+FRlNuwJCCEYW9ApyKxfx3DAwOsnOW?=
 =?us-ascii?Q?u0CVZk/bGuSBQL0X00PHEegDWgEwH0GONyT8q044j/kN2iEO1883noGIJWcR?=
 =?us-ascii?Q?6VCZlioJnq2uWmWAT//6zndCjw2YRgO18qvNLNdzd+et4vAOGMNm7wNbkquW?=
 =?us-ascii?Q?JRTKcAXJ5TLFrwXnEbBgMqz1z1lJxRGV27zj+GCXpMvuP7RXEz3M4XdVGvzc?=
 =?us-ascii?Q?4UI1IbL7C1nTdLzszpx+izXi2dmn5zK43vTreOQv47hYYlpKDRHlDm/JCjJt?=
 =?us-ascii?Q?eGx3Fs4A0tkQDA63HwjI2OI837cgHOpt6nya6lAW7YBceSG/qxb3hkG7QQox?=
 =?us-ascii?Q?q7mR+km1vbO08NGJRDFog48VtlXNh+9Vj4hh6MRJh3U5tihpcu46Vn0VxaeS?=
 =?us-ascii?Q?jq5JLBLLYtL33SnJE7v96U8VEtE1CS+oNYkKoq8vXJ6p4uC2OH135a0stQQx?=
 =?us-ascii?Q?ItFLBaEqapmAV5vrT8jrWRJg8GhSc7mLvc93MUoUrrKeYsYgUK2WTJCjvQjA?=
 =?us-ascii?Q?BR6FHulklqbHNzM7lrJzW5eq7kXI8OlQZ8llPN4LtDdcgtMSlMEe5iS42pE7?=
 =?us-ascii?Q?QO4KwN9XOGjM/DiUqtJZcb8V3WhJrPzxuMWW2yPQwVg4tLn7pTKnH/z97Ahm?=
 =?us-ascii?Q?DO+aW147yCvDx7lkfn7NvFDXNu4FWG5F7GdQaGXpORl2F3yOEgqLFtBFqiLM?=
 =?us-ascii?Q?yA9ymFIrTxmjirSpMevNCH/A+xzA0P5U5j0qzE26YY8kNzmS1ZTxyqyaPr2m?=
 =?us-ascii?Q?/YC8zFHqrOLWW9aE78Aa+e/HWIypLOT6DiHTgZcloKuN6l0WdeM9Rx7O2NHs?=
 =?us-ascii?Q?+0ydSs8LdUHwPxFof4PjDeEGSwx662QIbdOIB4lpbm6HiEf2fS59LcIAxg3Y?=
 =?us-ascii?Q?BpxJ0oPQzO6x8SFCEYw5z9KUE5CAN398ffvd52FSdSwvLOpSP9aXubvTey0M?=
 =?us-ascii?Q?27gsPdbxO9VR7Z/tTVpmNlsaEtZjhxOyL23e+zt2EUbs/ze5dsBvKfQ9u53O?=
 =?us-ascii?Q?AQ+AgOD13L3qNsK8gI+mvBWrbmnXlmtniL27pdfhO51D8mKXxmw4wx3HlUiT?=
 =?us-ascii?Q?2w6ycRFLhQrgrfnRsVoWGKRlCOp8I9m/PF7rBk8Oq8sWBtA3+2iNlPBZ0v+3?=
 =?us-ascii?Q?ck/egCKcIc720ciM6q5CKgiUzJ1uVNZJq/eeJDgm/EYrV6qBjSqcYFzwNJdy?=
 =?us-ascii?Q?BxqNx6yxDW02OAoEXsXKfz+Xp1guP6uHAV3fMyide08st3cHMC/bo3Aiouv2?=
 =?us-ascii?Q?94HgyknUtlBx58sT7DDNgYn45D+DeDOlpm9Ok2Ok?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37468764-21ed-4f20-b0a4-08dc647500df
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:41:26.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XTfAfGzHzry7qisnLMKQi5lC4oS1l6SrKR4IR0V8pgt6HEBuKB9/MplHQRlusfXDs5ODrWJhmSinDp0NL2WgPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

On 22.04.24 19:20:48, Dan Williams wrote:
> Robert Richter wrote:
> > For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> > disabled, the SRAT lookup done with numa_fill_memblks() fails
> > returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> > found for a CFMWS address range. This causes the addition of a
> > duplicate numa_memblk with a different node id and a subsequent page
> > fault and kernel crash during boot.
> > 
> > numa_fill_memblks() is implemented and used in the init section only.
> > The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> > be used outside of init. So fix the SRAT lookup by moving
> > numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> > always available in the init section.
> > 
> > Note that the issue was initially introduced with [1]. But since
> > phys_to_target_node() was originally used that returned the valid node
> > 0, an additional numa_memblk was not added. Though, the node id was
> > wrong too.
> 
> Wrong node seems worth notifying and we can figure out on the backend
> where the backport makes sense.

Updating the description here.

> 
> > 
> > [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
> >     CFMWS not in SRAT")
> > 
> > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> > Cc: Derick Marks <derick.w.marks@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  arch/x86/include/asm/sparsemem.h | 2 +-
> >  arch/x86/mm/numa.c               | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> > index 1be13b2dfe8b..1aaa447ef24b 100644
> > --- a/arch/x86/include/asm/sparsemem.h
> > +++ b/arch/x86/include/asm/sparsemem.h
> > @@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
> >  #define phys_to_target_node phys_to_target_node
> >  extern int memory_add_physaddr_to_nid(u64 start);
> >  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> > +#endif
> >  extern int numa_fill_memblks(u64 start, u64 end);
> >  #define numa_fill_memblks numa_fill_memblks
> 
> It just feels like numa_fill_memblks() has absolutely no business being
> defined in arch/x86/include/asm/sparsemem.h.
> 
> The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
> applied to memory ranges hot-onlined by the CXL driver.
> 
> It belongs right next to numa_add_memblk(), and I suspect
> arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
> what to do about the fact that linux/numa.h does not include asm/numa.h
> and that all implementations either provide numa_add_memblk() or select
> the generic implementation.
> 
> So I would prefer that this do the proper fix and get
> numa_fill_memblks() completely out of the sparsemem.h path.
> 
> Something like the following which boots for me:

I have kept this patch as a stable change but took your patch on top.

Thanks,

-Robert

