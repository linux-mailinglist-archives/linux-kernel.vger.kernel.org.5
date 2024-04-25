Return-Path: <linux-kernel+bounces-158128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDD8B1BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386CA286504
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C66D1A8;
	Thu, 25 Apr 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mvFO8R/e"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2075.outbound.protection.outlook.com [40.107.101.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD473A268;
	Thu, 25 Apr 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030225; cv=fail; b=aLNJiVYUNv4igXCRjjlUogXsoghtpmiHTxErsXcpQU5WlMBCStXkymugW1DDpSq1cyuKKreDnJGRXEMfS0BwjAR7F8w+LIJsU0XfLKespPzwHU1JDbJwWyh4nNN3q103b4BCX23A5gTPxOD8Zc1e7acUxT583xvskv1FP1q7sdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030225; c=relaxed/simple;
	bh=HgwuEx6nfRguAc2Id/ZCUVFrkFjtNUtqhZcU/Tm40q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T5Fiq+UBRpNcVGXaFZmvLecCby/4lk+4msp9QjabciP/qo83TvNtvKbvqtl9zcCFh5Ozl2BaQWrPbJ5IlvLbE4lW2RARg6SqPfSPJSigaykSLF5NXxeCRBiSnxOgiB3LBE6clnYcwN5kHmE2pSUfl4S7iW/cjcDpCXgrb77uhig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mvFO8R/e; arc=fail smtp.client-ip=40.107.101.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRvCcIR2lJmFkJhGNRYiph4o9LcBklvXNQhYDcSOQsj7QZKTWxmLesLdZtjG7zRR1PAXEF008OV1FH6UH+xKrkWqQeiZY507xyMgZ4NbA4JPvqEAZdJe4JcQXQCFoZ5yvH5cpER6t2cmsvJ3rcFGhS1AXGhRwUCEMDYpPmuXaFyr/5XidNnCf/jSpQHzeQbQEbG/VG0BVDpcYDO7o3ovS2Dcy9Xal7jFpRqXs1AIVeut8tN64QvikX/5ElvEy0TqoTe/KysbRX6FkW58HutX00pcmJt1ZKYULGxZyrb7Oo4FDn792NiY0ByOs2Tix5qsvxRwQbCoeODkg9KcQcAGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc/EDStv86+lbgcmbb0QjishdtrY/mC+G/6n0aM3r3I=;
 b=bXr3rO8e6qrgIBYhsFmB1VdEAB/yG6PJQ0wXMoXtKXs2Q1wF02JtaQb3S7PFSkKdgydCNtG/skNAibsReR2/dC29Y6gsQ7vHN06M/DnE3SGZ2mMQ2SVGcUyACFoFR+ZCu60ERCZgapxemuF1NEq9bQuNwAK47N9insFRyysE0bqZEPzQGfkN/DGyQyRfsmZSlj90gUT3AG+IYIZXRYTl0pLg+aOtTWZ9fx8eeLCcGMyoEzXKo+p11aug6fIYMQqZD9KqPgGZvzFCv5GaodlnOsYv++Pw2itLKxs6P4apBNc87/Jlp/wCI3cdYosrKObfIGeN9tXXHrORzJGB8E9oFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc/EDStv86+lbgcmbb0QjishdtrY/mC+G/6n0aM3r3I=;
 b=mvFO8R/epkGMsZW0M8NUVk87aZbLiBTacZg4YYZSLpRfvRgWSX2OZz8B/lVfHm7rCM5HyB0GwhbWUqbR7yEFr22DEVcMo1ZPMem86/Du1Eg5ihOWA6d6/2OnbWuiL45W/Bes1ogHED0x235qjXE9esAfHqNN1tpzns0lcugQuVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:30:21 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 07:30:21 +0000
Date: Thu, 25 Apr 2024 09:30:15 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4 6/7] ACPI/NUMA: Add log messages for memory ranges
 found in CEDT
Message-ID: <ZioGhwNWQyFjRtZ-@rric.localdomain>
References: <20240424154846.2152750-1-rrichter@amd.com>
 <20240424154846.2152750-7-rrichter@amd.com>
 <6629474eab671_b6e0294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6629474eab671_b6e0294e8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e83e008-6cf4-4719-581b-08dc64f9908b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lC6RgoqYKVq+GcgUppkE0BFx5T1KyPuE3scnmqIoNeAlK7/rNuAreH3yHicm?=
 =?us-ascii?Q?M7FXDQkDIBzsfhjoDLzfnrHVb6R0PwVn8JE2juXGyNG7bRpkQv2WGvBTUYlT?=
 =?us-ascii?Q?TvrauIfsdtKYND5g+E4nSxGE16SJ9iMcxrtmZzXIYW2ItGsEMexJ0c03Rq7l?=
 =?us-ascii?Q?5X5Oy0u/ZPEUPmTfmVrq226Tt7pzPmXTqhQiW9jsbnT+DOzsQnWzyUFmjflg?=
 =?us-ascii?Q?PddS7Wn1zR+LL3Wi++B+RSy+uaiH9/pStg1rmDVa9gZpJItM1342+YvT1jv0?=
 =?us-ascii?Q?jzSi2UWZ9hZSLdBSu0+jaB4XK2I3tdBCgnffvknZQJNmprnxMBIN6lU8Pfog?=
 =?us-ascii?Q?SN4UZg/SzMediuS5T8VQaFqlj4ehOL2/gQnn6A4LhFK+3b47X+noLjvw0yNx?=
 =?us-ascii?Q?/FOQJiz5qBL4rbQ8JjmwzHgKBqeDlkaeodgt0sGaZkoO1pz7fKRZInRIyl20?=
 =?us-ascii?Q?5bsja0zM/jWpxwK9LufydPEnM2RJZTH3g4vlGgayn4rxaJY5KONuulhqMnhP?=
 =?us-ascii?Q?h+4jYWRBet+rfQb1VHEqHlc+fAmPrPw4uusOAeFAx3kesbbyP2wEG6tP+cuX?=
 =?us-ascii?Q?T/E2QzIKOOJgsW73uOJo/pSvCioAzpFOZZKMzcMonz8cpPTNUZSOvy4cATLH?=
 =?us-ascii?Q?Xx2r7YQBvXSae+ZlmLT9kE56S7xEVVj+wOyCHLg6Ds8oqkhLE5TG8YeOjre9?=
 =?us-ascii?Q?gJfnGm9Jivk7TfWtmSzipxhZ0SXukwM2++t8gWnCOs+psGACuaafexDf4fyS?=
 =?us-ascii?Q?FY1GPdkE4CE9i0M/6MmshG6/CvBIAObE6SVhx1gre0BptYiLDVDQsajpa9lR?=
 =?us-ascii?Q?G5FIbj8CO7wIeSr8Sermm1kMajgR44qG8vsXZ9s6LUjSU+EM/Pl0V13IwhDf?=
 =?us-ascii?Q?3RS8boOwITP/4SzJvFPOcfCfaXjhn3PAnWLuH1Xxvu1kAupf1iyVQuL0Fmrh?=
 =?us-ascii?Q?Y32WxNhfWlZNXfX18anvbC+c67lsKfrJ8XKZwQA54Hb0lhHQheNQXnvsp2PQ?=
 =?us-ascii?Q?Em8OZZ4EoyennL8fljV4u541g0UsgdrF7GEp6xcOGhhASmCT0sClh9z/0iM2?=
 =?us-ascii?Q?oxFSpErCD/lHsEWPLFQfW1H4onFu3l0dDtU3VyJpw5fVwx/GN//nHUHTIQ0w?=
 =?us-ascii?Q?e8LMEyf0p7xI2+kx7oobcbsmCm5fd4H+Xzdhlbh9P46FQgkBJXOhRSFkNmqe?=
 =?us-ascii?Q?Z+Zt71OzB3036oPJTIRGB/wNT5ZO+FvlThDUtshLd6+I+AR1cdifQ8jnpYKt?=
 =?us-ascii?Q?Uo4+nQejZXjj1ERaj+i1batSxujFYl5uPskDevJSgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?20DIords1STceVkWHEoDRZvEaCU5i7wclHFeAKIM3TyeTuLBlxY3A0X3Va3T?=
 =?us-ascii?Q?anF5qsZuvNMN7o9vF9unjpawY8jbz2CFfm1JE1dIYZi59gltPluWAHvHaumt?=
 =?us-ascii?Q?nFd5MDlL3HESdATCz7jWbptxUMSYvQnfMvmjK9N82bK/kmQudw940iVgAfuS?=
 =?us-ascii?Q?KyvVdzD74jjp/cRuBYkV/c/JS1tJONtHyKEhC/ZQOn/uhAMTmkZshQGd7lyV?=
 =?us-ascii?Q?3DsqsTTalHBaCaMb2Q8+fewoL/CJANM8dzl9NAssW9INTwfuwZ3Y8veOs5Vw?=
 =?us-ascii?Q?x0RpeXqkrMW7xGNNbFj8zEBgppbaXLCCYPI3CX1OM6sXnudBI3NXzBJDHqny?=
 =?us-ascii?Q?4cPlUxhzWOJekRgINJuB2d9ZLvDYzVaoSr2BMTcDgU6cRJpr3FEWdntci8LD?=
 =?us-ascii?Q?iT68d0I1+lbxWLGDjZOQMAlYA99uEB5vvE1mkFUMeIUm+t14d5yaTHpcikb5?=
 =?us-ascii?Q?orJRijascnv4z2IKqE07kKim1HIzUwtCXspUQo6vyFxMr31g8vc6EHUxjUy7?=
 =?us-ascii?Q?PAjonn8CNi+U/c4FrSqgnl4nYHFIvkE3paodLQ0UuUwWmF5wLNa1nrpTU22A?=
 =?us-ascii?Q?faRTpH+VCBnIqQFhd2j6xUbg/q1VJfmNVP2t+ubEvUmaCdwqEKsLSNnP95Je?=
 =?us-ascii?Q?W/3Xn7rzvqNJZlIYoC/Z78koMQDgc9jmLl/KrLOWGds/9PqerSCRxDDXHtA1?=
 =?us-ascii?Q?7kWNNmSueCFa8o7y027eTlV0NgxhU84Z0dMtD6n36FZUUv39BsaO7ak/MSpQ?=
 =?us-ascii?Q?P+ytsbdYCf1WWsvn2xd2brT1bHCmR2ALktW52Z7qe/PbxbIzAFd3oTzTZZkN?=
 =?us-ascii?Q?rLmqwzN3a6uYtB1tlC0pV+l+PNJ4RBg0NWrnhNx1s7oVPX8wbYZr4Hc/VazW?=
 =?us-ascii?Q?qsR+D78DXmFk3ed0qtKxW+Em5WYq25ah8lsicD/R5RjQ4ST2XcdduWXNXaYu?=
 =?us-ascii?Q?HuqOrGFR0fNjWsGbTbdJ3fEetcWVAEAPcg6/zRfTLITtY/k0dQRbNgKEINba?=
 =?us-ascii?Q?WdryVm04WsFTUPi0L3IOoOWQJGpoYaRdZYafU4wrale4+zM/02d2x0N3E0ar?=
 =?us-ascii?Q?z5xp65mFpUagtXXqAzhFvnsxsO/M3wpBiDYBn7gWizDmoWYFPI16ItZtajc5?=
 =?us-ascii?Q?SZVU87KiCEsmefHkEEwCl7PB97+q/w6n/lFx8vi1sA43M6RYSEkCdRciu5bB?=
 =?us-ascii?Q?C9U1PeQUtY7HlKNEkbY66AkMJE6zZHp1fadsDnSGtmAXLnBbaeJ4Vgm2bRJk?=
 =?us-ascii?Q?ZspxmWswX3iRZ8ltNRSsWfUnAjuLMzQ2gcVUU5G3Aa14OPG113Xk6HHmBnUo?=
 =?us-ascii?Q?XGTsqnN8USqpxuNNopCSF6knOxuRRZVcBDtH6arHW/hQMO5aPBPxds/a9HTL?=
 =?us-ascii?Q?E/tyTyNf8GLE3Ndc9hDElXCy0nF/rsbZVe6y1ewyOh55vHxXa2gF0zXzeM4o?=
 =?us-ascii?Q?b/TgfNokBVA3hf/cBhn5loZeihkp0qzBZVvFRYJvDamO+1IgaY9wbEsqRRRg?=
 =?us-ascii?Q?z8HtpXw/VRkeFeJH0KEvcKWOE2mtDduZfhRplSqSFDWbCZn8KcOoqB93kfVG?=
 =?us-ascii?Q?U9HswDAeGJrwZwQGOzf1yZ4pyb/2F7V4f769b79b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e83e008-6cf4-4719-581b-08dc64f9908b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:30:21.5820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pfetLUK8AzuYuOM6iws4VaH085s7M7LrDfcfOu3vlt8RR54W+FQr5etvfZHdmRMxLlHhsVi60nKWdi8LJV51w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

On 24.04.24 10:54:22, Dan Williams wrote:
> Robert Richter wrote:
> > Adding a pr_info() when successfully adding a CFMWS memory range.
> > 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/acpi/numa/srat.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index e3f26e71637a..c62e4636e472 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -338,8 +338,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  	 * found for any portion of the window to cover the entire
> >  	 * window.
> >  	 */
> > -	if (!numa_fill_memblks(start, end))
> > +	if (!numa_fill_memblks(start, end)) {
> > +		pr_info("CEDT: memblk extended [mem %#010Lx-%#010Lx]\n",
> > +			(unsigned long long) start, (unsigned long long) end - 1);
> 
> This looks like pr_debug() material to me.

This should have the same log level as the message below and/or its
corresponding SRAT message. CEDT mem blocks wouldn't be reported
otherwise only because a smaller (overlapping) entry was registered
before. That is why I used pr_info here.

> 
> >  		return 0;
> > +	}
> >  
> >  	/* No SRAT description. Create a new node. */
> >  	node = acpi_map_pxm_to_node(*fake_pxm);
> > @@ -354,8 +357,13 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> >  			node, start, end);
> >  	}
> > +
> >  	node_set(node, numa_nodes_parsed);
> >  
> > +	pr_info("CEDT: Node %u PXM %u [mem %#010Lx-%#010Lx]\n",
> > +		node, *fake_pxm,
> > +		(unsigned long long) start, (unsigned long long) end - 1);
> > +
> 
> This makes sense to mirror the SRAT pr_info().

I evaluated this.

SRAT shows this:

	pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
		node, pxm,
		(unsigned long long) start, (unsigned long long) end - 1,
		hotpluggable ? " hotplug" : "",
		ma->flags & ACPI_SRAT_MEM_NON_VOLATILE ? " non-volatile" : "");

There is no direct mapping of SRAT memory affinity flags (acpi-6.5
spec, table 5.59) and something in the CFMWS entry (cxl-3.1, table
9-22). There is no "hotplug" flag and the "non-volatile" part would be
ambiguous, as some logic must be defined to handle the "volatile" and
"persistent" Window Restrictions. Since the CFMWS restrictions are not
used at all by the kernel my conclusion was to just dropped the flag
for the CEDT info.

Note there is a mapping defined for CDAT DSMAS and SRAT entries, see
CDAT 1.03 spec, Table 4.

-Robert

