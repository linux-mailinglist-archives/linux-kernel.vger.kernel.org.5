Return-Path: <linux-kernel+bounces-160555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51968B3F17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4542F1F2370C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3318171092;
	Fri, 26 Apr 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="euQvqvoX"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4316F839;
	Fri, 26 Apr 2024 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155300; cv=fail; b=p+yLYH9EnLzVM4ptYESPS2oFYJJh6P/o2UiZ7DMADt+lV7nWIlfyq8jcui/ealu2AtXzRsimJffpjxM53NPphW1rcMyzBGmPeFK6Dy0N/u9s8wYao8BaVo+veRWVKljMW3tvx+44Bjb9O4eSs6O+zPkRdgIyh2FKfKzWZtzVJPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155300; c=relaxed/simple;
	bh=wN2r9UW40KsDk0zacFT40egJ36R/+omMezZUVmSXPKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vGi4BazEv+qFxsPgzopE4KHBWv9OwlZkgfrZOvl0oUmwdmJnVkawzCtSCkExjXy3IMWNmi8n8GHEFcHLJx9viHJX4DJLpcB/yRGFh12FkRALFx3Qb1MTAJXqQxQ5Ffe+uZOWslP/foo0z7Yc/JdUwlSqbQWxALEU5BFQOzTqzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=euQvqvoX; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VakR30HaWR+7sSgLU287U80SMrZ3l9JZ/zVV3tQ1bTANAiA4vKMVxURTSP9asZBPaeLQXEr+O7LI/QtdXvxbDeUgg0QemiOBejYNAojv/apSoQNtL32F1P/cQ0AQlpQ2H84rQnObE7MxDTjCvstc+Cy1ChhdanFjc1qD0v1nJk5KSfn8cHIz50LeMqle7HxPci5Ruee2QKmr6oaI2TInive1mQTAce6zyyX1OUYlJcZ5JvCkWjo9r+a99ua8ANjap90e90NKaV2sP4ombLOuOSK8YZbEOlTYRVQbuMwRi3qvm8o89qCLaEstU/CasVNYk6PePNvgG8TeariJLSPieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5eKN2Ot6cxeHkAfYnli29110WrSyXyPiFazWuM+yfI=;
 b=lvXjiNeeifeboHcbFPDqASbtFEBubiIbVbdAk3nzEQifdrRCaezZCHSsM2Oic1+CxEVi4gs14WrPFky7I4X1ZxjekgjpLMa0qoG5yn2HXzlGB5PuAbkaCa0fJ1ZIwbnflmo/WDOOWuUbv+kr/cb/rQoh+No64i5jZIVC6/llmRlbzh5wdoBXjL4PRVDagLZa5vnuVhDVlJqw5SGam5YTrTDywB5z8jmcSKF1k4DM//epCnTtBgPBmcp0rUl2u+IWk3XUWt97x32pTUs1m3bRJL0eXugjCyYSYTpL7jELssft5fu55NoeTNXfgsUO87sIG0NVcO93FLYDSXAGvT2axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5eKN2Ot6cxeHkAfYnli29110WrSyXyPiFazWuM+yfI=;
 b=euQvqvoXBTLYycbRLRasHzArAr6MYVMC+diE81wHdw0UNstwMOYN+tZt2fOe+stuWeKqQ3vigJidGm7kF9zlXdv6R7H5s/yBh5/KYNzfqqJjdMKO7hiw7aKEh9a05D7mqmMoIwMTN/ZcDXuc3qSLDtLmwDoFlDd4svp/u1CDE4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 18:14:54 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 18:14:54 +0000
Date: Fri, 26 Apr 2024 20:14:48 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <ZivvGJcXKPN_L5fn@rric.localdomain>
References: <20240424154846.2152750-1-rrichter@amd.com>
 <20240424154846.2152750-7-rrichter@amd.com>
 <6629474eab671_b6e0294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZioGhwNWQyFjRtZ-@rric.localdomain>
 <ZiqnbD0CB9WUL1zu@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiqnbD0CB9WUL1zu@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a7c89e-da41-45f2-31c9-08dc661cc5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TjLmiMSNAq+CZ8nwnz0L/n+BVtHOB8jlLW/7qjygr6i6Ff3vtEd72CP2iym?=
 =?us-ascii?Q?HN+yoSP6gxXzmpQalR4plUyWaGbM4EIbmUNKvGgal2ykgQCCq/tVivapAqoF?=
 =?us-ascii?Q?lzPtFShLuhyaIV0Pm8g/8dTfrM/SbjmxuskimygdBPcrIzEWDG2A5eHKZPGK?=
 =?us-ascii?Q?OBxLFQgLlUURQSapnR9K3IdXmytMZ2AJHE0gCW9BEwr8jy0SHo2mcoIK5AyT?=
 =?us-ascii?Q?PGT92ZoxgT0lg1LZN9Blx3CfhTpTqUKuv7FBlTEjNQEWkZF60i/RuRcfA/ke?=
 =?us-ascii?Q?cTFvIyohPB05fUTHVZZ/HhLndNf5RHsUdHST+IXe9qCglPweopXHsnO+DMEy?=
 =?us-ascii?Q?2A04TUayMkGM2+WSwl9guVYpYzoUzBDQb4HbaxLLNd/MPzBxZZDLgfhF8z3F?=
 =?us-ascii?Q?r7D9J8ZaOVGIY42UgwJTC5ih5G7zUdseZ4HnR+Cfy5xTqejaA6qy9jhZYYpH?=
 =?us-ascii?Q?PWF+qp9GSQLjib73+qcmxw0sbq7KYNfiIjLOnorZLHS9z9IzIDtkoJ/nh1s8?=
 =?us-ascii?Q?flufHNFqlfY6m5I6dqkwctbo41MdEHVGirGdhM4HAkFcUDSx1a+6HXo2y9F0?=
 =?us-ascii?Q?ut60dNHqScQC44XCynoq62DFnt21B650jgaJheFhOBB8FEzSe4QxEDCNf3aL?=
 =?us-ascii?Q?fSmccnUzPxoAJ6JJBof7ctUA3ia46zIcJjYE7as74eYvRn83TYDHu5ZkwqrU?=
 =?us-ascii?Q?9GuX1JJgWJDloPFgfZS3+vwuWzQRaMwGuXi7ZJzl+Q06Njz1POo02eQvHzwd?=
 =?us-ascii?Q?JKo8UD1VragqAxvgsZlM64VKARpavlo1Cz5rys3oSMhJQqdjDDgNiW4fmmJe?=
 =?us-ascii?Q?7UcD9hE33ugRU8QcGSEssfaWVXITwWRKN48gH4+xKxlMx2Ix9vUuz7D0Eemy?=
 =?us-ascii?Q?+MatlVu0qR42HdnjmgTWWHfExQqqRWwh9iZpf67Ba8c9JziaX0nzcZNZ3svg?=
 =?us-ascii?Q?Ov1zYeU4clQ+4Mi3HI717GVjM3We8JQAJ2Ob2AvxqTlOyy9PwVHTjRywTuZ+?=
 =?us-ascii?Q?4RXq1HAtFhIHqEovw6FGLqFQTiF07HezylJXTqiUBHng3gZWzNmdo+vpZ2IW?=
 =?us-ascii?Q?hS5EKQsn1TJf3x9ZomR4xaQuB0+wSBoTRgqAg6mVtqGOD5M+zYFVjWziE4kM?=
 =?us-ascii?Q?ZBNYBKMlekn96BNw6/gwjX0/6m52nHn77/MJeLmJEQbCaSKqeHvWYKh3xPYa?=
 =?us-ascii?Q?yyTIQNNtbDSSWb/HpDFRmJqMshizQvP1ytz8/grpdDa+1oBOS2YWVsbiL1Al?=
 =?us-ascii?Q?7soDKGC9nY82OIiuFDBz/OnoPnKO9grf+S2/E4UbYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EErnr3DKZ55sGKhr43I6sC7a9/59+xgHcQcG+FB0QRlp5D6ZmAraEoSZpGYU?=
 =?us-ascii?Q?XBEho68ejuwYircG/AYGkuHrTZFTX9oMTciLzBFMlFe4guDECpL2k2eXPrm6?=
 =?us-ascii?Q?xwTnlj61MAtk2KERcW0T0pvCcKLZyLsQvjPP0mMm87oYS4D4b2OngrHo1MiM?=
 =?us-ascii?Q?ASPx0TZjpzb/lrDQlTCjZcWJjfwffDxeipMo586ZYpm/y7E0mjn+l9KZ3CW4?=
 =?us-ascii?Q?U4yY2uATcR5v2ae5RF5i0pXbj7Jahi6xjVJYBiDi6gehLdeVDRepVIbcnwBC?=
 =?us-ascii?Q?Cz4zqXCi6Vw2RTV6P666gz0NlysCGjfSFH7t2099YrdKuvO+0E/Uhk5un1XE?=
 =?us-ascii?Q?cGFmB7ztj2m6Iclu/Deml+kj6OCyI50tXGkfeQrLByxymnucrn64P2H1Hosg?=
 =?us-ascii?Q?MuSo8UsCvxDTat3pXlcrVfB2UCH1A92/OVo5ZrswEesn7lzUPW0dEq7PJFs+?=
 =?us-ascii?Q?8CEqlu0T0ogr70eid3q954Cqnr8KKm5lr0aFO6gFtpS6x6eQPF/F3w1Smy6g?=
 =?us-ascii?Q?UwUgHnVOKFSPjtz5V9SI5h7akEhATbJTiS9i6TiojbPrGBZXg1adG2R+N07d?=
 =?us-ascii?Q?1wspCArvyhdTU82CILfG7wrvSfgghf7Ne6s+xQXqXuugcBGHH9sFdVMkLzaC?=
 =?us-ascii?Q?osA+Pni1YbQGwiOilTsKQm6F8oWolfaEKveMLifwOQ4UKfgETy8343itjDRg?=
 =?us-ascii?Q?z4dWnxcGK3swZnfrFGfYZWGwOUiaKiCcjjqrnk9ZUqc71raAZ4Zo1taqnF4k?=
 =?us-ascii?Q?7cKxJUyhspIzMpkFE1tcH1gNappWYAjdfR1AzRZf+MYcvPTjLMFfKHaafNg3?=
 =?us-ascii?Q?+xJ9iXTHwQem5sr+Y9MfvrYUP7qOPRdNJ8P3F/+VOfJY4CSxgWifJVpPlIJp?=
 =?us-ascii?Q?eNNAN3Y9ykXWwbzrxjXImC4aV9MzDFkwaeqSa/yv5MKNrvVv4PuvO6F8P4Cj?=
 =?us-ascii?Q?Tpkt1wWLnNnBOZDoN1co2ZzqtwQTBY7n3JM7vZ6wxknkUEvEEcwwbp3kjtOv?=
 =?us-ascii?Q?QEixVGzYG9gCU8Yxq4F2lvlJSeo/Oj2d5t2k6Ku1kglk6EYU3RA71Bjr/IAS?=
 =?us-ascii?Q?C4tatGQx0tXIngCPlP2qpqy3oihwsn2VFZO38dgJ/DCTOzH1ERuUHO8deom8?=
 =?us-ascii?Q?R5/tJ0zdXbItiL+IEkdMLJQCD/57HsA5EhKVQ3caebvo07Dx9WQKv0mV4dcn?=
 =?us-ascii?Q?vuhfX/K0tmETIvTKiaU5tQJlwvJLvAIsakbbMWle4QTGRxZbar9rOHZDIRNW?=
 =?us-ascii?Q?+dvryPI6O6y5kiD6Yg78vw08KDCC9ctKix8W112NfNGfNqep+kFXQCSnK5mj?=
 =?us-ascii?Q?6uxE7dFyeYMvJc3H1StL6ROksYiJFTwJsMyEYuCukxanLzl864jRXTNAYaFk?=
 =?us-ascii?Q?TsPKxVpqjDWdPqa3LavfthGhlxYeC61NdA1sy/0M8B98gXp9A89FTqqlePG1?=
 =?us-ascii?Q?05gIZQjlNJM9f/TBim04LdcgQp7Tyz/urR7Xj8qYD/yGVAY73ruIPgaff9Gp?=
 =?us-ascii?Q?Goi/YsaDnDfJuiQ4jd8Q/D2v/I0ShABRKiJzYZqWnPgR58GUObh0aVKYkk7O?=
 =?us-ascii?Q?6/GUd4hGDXWj2xYetUW89aK7qw0K/bReJIAZuAPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a7c89e-da41-45f2-31c9-08dc661cc5c0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:14:54.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jeg4t6dSqIPuwfFM1kYMZYSlvFr33tHvePmVMl1Rbu8Tg/GI/O8qsSgp5KIS/zXzeGdDlv/04tHYHD6qUxcIDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823

On 25.04.24 11:56:44, Alison Schofield wrote:
> On Thu, Apr 25, 2024 at 09:30:15AM +0200, Robert Richter wrote:
> > On 24.04.24 10:54:22, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > Adding a pr_info() when successfully adding a CFMWS memory range.
> > > > 
> > > > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/acpi/numa/srat.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > > index e3f26e71637a..c62e4636e472 100644
> > > > --- a/drivers/acpi/numa/srat.c
> > > > +++ b/drivers/acpi/numa/srat.c
> > > > @@ -338,8 +338,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > > >  	 * found for any portion of the window to cover the entire
> > > >  	 * window.
> > > >  	 */
> > > > -	if (!numa_fill_memblks(start, end))
> > > > +	if (!numa_fill_memblks(start, end)) {
> > > > +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> > > > +			(unsigned long long) start, (unsigned long long) end - 1);
> > > 
> > > This looks like pr_debug() material to me.
> > 
> > This should have the same log level as the message below and/or its
> > corresponding SRAT message. CEDT mem blocks wouldn't be reported
> > otherwise only because a smaller (overlapping) entry was registered
> > before. That is why I used pr_info here.
> 
> It does feel like this message belongs but maybe it should also 
> mimic the SRAT define message and emit what node maps this range
> if memblocks were extended.
> 
> But...seems this will emit a message for every CFMWS range, even those
> where no memblk needed to be extended - ie the range was fully described
> in the SRAT.
> 
> Sadly, numa_fill_memblks() return of 'success' has double meaning.
> It can mean memblks were extended, or that (start, end) was found fully
> described. I don't see an good place to insert the message in
> numa_fill_memblks(). 
> 
> Sorry, just stirring the pot here, with no clear suggestion on how
> to emit info.

Ok, I have changed numa_fill_memblks() to also return if memblks have
been modified. That information is used to print the message.

> 
> > 
> > > 
> > > >  		return 0;
> > > > +	}
> > > >  
> > > >  	/* No SRAT description. Create a new node. */
> > > >  	node = acpi_map_pxm_to_node(*fake_pxm);
> > > > @@ -354,8 +357,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > > >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> > > >  			node, start, end);
> > > >  	}
> > > > +
> > > >  	node_set(node, numa_nodes_parsed);
> > > >  
> > > > +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> > > > +		node, *fake_pxm,
> > > > +		(unsigned long long) start, (unsigned long long) end - 1);
> > > > +
> > > 
> > > This makes sense to mirror the SRAT pr_info().
> > 
> > I evaluated this.
> > 
> 
> I read Dan's comment as simple acceptance. Like, yeah this one is good
> because it mimics the SRAT pr_info.

Ah, I misread this, thanks for clarification.

-Robert

