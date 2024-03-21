Return-Path: <linux-kernel+bounces-109752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71D6885542
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C47282B14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23458AD6;
	Thu, 21 Mar 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZdDfj0nK"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155441E4E;
	Thu, 21 Mar 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008551; cv=fail; b=VPCrxPdDAONzE0KfSt+Kfmn0LWkIofz5nGjQK+xyDeHIMQhja368qTlXZE24wLbG+tKN2Gy9rtIwgcxccn1qpTwcL6T4w+tzDVPAXik3F46t6pkU5X2iwa+Nipaa2vqtBEjqQHS9CLceupFbRmTNsjyQwPbzLW2LEkNi3NZx1bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008551; c=relaxed/simple;
	bh=tIR11BiQA1JPgmJqUI8/swdWMVGIMLSrwojQmX0arSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tgLFbcD9qu8Hu2mj20verYbnY0h6OlM2Uvt3Rdn/AtucBwPo8uMQNr1CWdG9aABIFVNv3egTCZ+QdXPDlAK1QwfLY9i2VrEeIIuX10BTlugylcV1SQIdwYLW6vga4m9iHae9oFn3EGJ02DCTodzx5LKdvqXDSV7KJduRlKlAqaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZdDfj0nK; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH0weEdw80afpcWUp9IprszpDRV4QwphU0ZQtWbIZoiGgKVIIaBezHeeywtU77pdp/VAkbiAOyk6+eq8aQ+RMF92hQ8KZtirwPZOxeNbzd5FP+rWTapeoFPkjwSTfTioclr24twA+7tePmOJRPS5ZvL9pFJnkM5mSrz3rOnl0ZLoiijB5YyNNX6qWo3k8FyZaCLHVnc4+QXD5tBScByCDPkUodxUP6UE79n9SCHkhBIFHQIjOB3ckG8DDtb54HtdJJK+gnVCY4d/JjjGDbIaU3Ez55PlNxvL6G8hmzqk5hH9xgSta55jyMvwgX1I+OqcxEGupWYcobuK/9UFsUw+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cinKj7UNq02lP3lJF62PTbAMXOo8WE/KlV4HxlpCTqI=;
 b=Dh34uwiyJL4AqVYAHu4c4pr6S+8KIhQkbyd2C1rZZz5eLx79t7aqZUqX0JGuXl4oF4EZJIu07bBwUuGV+auyQd97ya9dHZuhhVl4u5/jm+yhfMRbrjEhh0Q9RiueqffGMSyBgq4cs7P/D7BTmx1XMBpTA0CAiu6v+HSwzbTAxhBsK1hQmW7dqGAOjGXB72YwNBqFUudvqm5oL2xvZ1Or6KLsd3iTh8GEnTPVMY2HdIWsW3QzFnpOQF1BOkBnW0m3bUjMIjs4NBjwkHEpyl8H0H29CF8mXhCmjlKMlTcgpsdpIyYMVvQ3dfg8MRTbB2kprYcctVnopJ1Yh34EwHHibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cinKj7UNq02lP3lJF62PTbAMXOo8WE/KlV4HxlpCTqI=;
 b=ZdDfj0nK2R8gMWp2nxD4vPohmSXfa0dbY3Kdwk6uONFZ0vghRxWZRHEetyohw4Fdwg0pa4n7S20h/ja6QxYJHBUymwKNJTXPBMVVzdz/5Y9dBpSTUuc5siXXosg69iCRpUWlTMxr+6A4u0bKFxNMfppMdRX0mcMh31xKEzDd62Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 08:09:07 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 08:09:07 +0000
Date: Thu, 21 Mar 2024 09:09:00 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Derick Marks <derick.w.marks@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <ZfvrHAQ9GMQ9aJlk@rric.localdomain>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-2-rrichter@amd.com>
 <65f9f2741e607_7702a294f7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f9f2741e607_7702a294f7@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f86f83-22b7-4cb2-9fd4-08dc497e2e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nM/01/EmMklT7IGiRnJGghfiqsY6s6SbmRvm7jTb+XrugFINnye4qzbeH9wnvJRCFLnJQxqukKe+sY/KOYhdu1iU19qm599GWExdZz/m6XXQmheUAWXx5/1RZ9Iw/DQ3RZnSkA4ELHwUOv4F7/0NbEx2mqKryEVH05qmj7PQKOYMJMSCElsfi4wdKqSf1DXRr1rWCIqVvY2AeNIjb9RlPlppRHPXlDAAVOfXMiIRPG8ODqPHk0wCD51NTt3a4zq/KW/XE2ODxs7nXrhLZXTP81IV8YuaP5l8CRVMxudX9fTaRAp+C1wMPArdrCB3+3ksVtC3IuI5LUMrTk4iK1OFso1SbR/RwSxeSqoLV+XL3bpTXTJ1e/f9Hg2/JwPUefdDCJH3lddPacd2nbP6OspBwLMhcrzGElACd4/YOWXwxq+N5cMJSdrzqJAWsTFtYVy0XM7KknardqxYdDNvD5yvhAgkKS6VzNTGZYKhK7Pazi+GG8JmCvPwpeXo4fKO87lqy8fRv6nZxLlhw+QY3U61MZzpyDAejkuZe0dDrydiMKcqyDOG5bnt2BdycGr4witEfWsn7q9ziDnHEaGDhZnihtM4+M5Sp3dPn5t1t5Fewe08gbe+P1ucu3xNRSnl7opNhfsjDBNNJBpM1VN3cgs/At5LmBxFYGepxXNkEav6IAA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2KNd4ZaHc1lwaFbxm+b2U5kqWvqvZBRYavw3oUo3AOWiKUoFudcJbsBwGHs?=
 =?us-ascii?Q?lv5nGnwXnW6pPcrMx8w+0RKnUt+KkcYLlj0xEb21Fr3t1pa3fEOZtb/6HPDn?=
 =?us-ascii?Q?gAO+gZSaxIYGSjhIpCKJXzLelO+lKqCI3s4JmlyNlM+414teWvtvZ6PNH6UH?=
 =?us-ascii?Q?fq8gJGpIlalTmiibt366CI1oBOjVsUVDqguO0QpDlJXrx0FbHmm/DTYNW/ct?=
 =?us-ascii?Q?iPxa9G8K3w3RwtpPrIhWnDUgBfRGzaK/baz2YQfmcaYWbcCmqB57GMhgNPYy?=
 =?us-ascii?Q?L8VGUYqIHZjusatQYN+E+d/j5fpHXSuIbl4iaEFKUMMEoQnssaCkhtJrgchJ?=
 =?us-ascii?Q?IsE4d7RzLHUHHOg1fxYZcAcs7Dd73TNHcQkNYNWFWCkgrjIMaCLZNUkWwJ05?=
 =?us-ascii?Q?BINAfoPwGislVimdM61hHXlGO0PP0bh38D4p4t42cekS744wKJyPaaa5S2M+?=
 =?us-ascii?Q?9vwfIsRUaV917J9MzldjWLzKExxRc4/idpSSSXpd3l+BRqDaK212VbjcK4do?=
 =?us-ascii?Q?53v7sPuNHPnj1ZmtNd+RUdiUMIzB3qexKRzLzafqxDV0/jW+HuuhRLO69sJI?=
 =?us-ascii?Q?yN9MfMhF+4FuBsoRjnvEuoewJy+uGcrnI5P3Tvw2Cf0tSlSLPzUrz4dKD7vP?=
 =?us-ascii?Q?wC6We4xGkpN87UPV/Ktsn+oem4uX2n3NQDwA4Y4IeNjyjyRadKBNciFWIxz1?=
 =?us-ascii?Q?FTqLoYkY8x7EqdUoZg9t4MtrGCWtIsawfMcvrC2okyFXVUqkIGxE+Bntr1lf?=
 =?us-ascii?Q?xK+5sASH6I7X5PGPy+m1PvI9YOF/3B3qHVy16RFgZqnKyJm80YWNPiRD7Hor?=
 =?us-ascii?Q?FfRtMMA0nNYsJwAS/FfqTJpvUmYcWsK0k7pw/3emhtc0kvkVGP5Xj0ekQk3M?=
 =?us-ascii?Q?Zc74ogEcBTg+XoBWEdr9EgSA1gPOQRab+zvH6saNxcYe3eOPtyBynYLTCBXF?=
 =?us-ascii?Q?F/9zGISyUITbpLMEDW9sxyhGNL+7OgjbpqDsXr37ptgohKc8yBVo4nHs1PCb?=
 =?us-ascii?Q?CTOBrZ6eyAxNkXUFJ8Td+EQ5sbpJRojP+leQR+P3GfSdjQ3HbwASG91TqQGJ?=
 =?us-ascii?Q?ZfGR5e6XDpkMBe+NqH3pTwxNqrRhPKs/yNPmiem4gqTSf8EigVK4C+ZMqwc+?=
 =?us-ascii?Q?fsXElJgZcwztIpHYb00lXPRU0PROLCADoJdaeE7n1CUoyrO8z1idPcMXYne8?=
 =?us-ascii?Q?K8wYNGgyduqjOXGy9TPVwPr8pc52Iyyyl3O+hclX0E7jiZILfdaAHr1neC6y?=
 =?us-ascii?Q?WB2M0NcGTRgoMTEk8ptaeg9sLVdE159XbmyfIe5K9Dp5vcQXs8itb33jsyAs?=
 =?us-ascii?Q?BaqGiN+A6AXj0ByVUVjj525KnFwO4UDCtRzxnkIzbrXBaKOATb4GWt2DWxIg?=
 =?us-ascii?Q?Acep/RZ+ikxRk2pUzQ81wHKY2tJkPwO2BUsTTiP+rsBFmxlGf3v7qXawBmJ/?=
 =?us-ascii?Q?/8OqBxvczBOHq81UhqcjajcmRPEIxYl4jQxqTRC46TxUFnb5Mlp3cXts/QyD?=
 =?us-ascii?Q?2VIj6WeQ1R0Os4YQjtqTgmPmDgyTLeP1v2EK5pvQp+mUaDfyK5O34ocgcj2N?=
 =?us-ascii?Q?6XzuK4WZXdFGJzAxq/uQ07xC3N7MaJ8HX12hwlin?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f86f83-22b7-4cb2-9fd4-08dc497e2e6c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:09:07.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvEoLcDUEbTa/ttJHEADphskGi6D5oTE/p+gx5urxi7SRPpznbsVtvkmVmlv+w1BaOBthyjC1ndLE+PsdfvNnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

Dan,

On 19.03.24 13:15:48, Dan Williams wrote:
> Does this achieve the goal without an additional hunk like this?
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..1aaa447ef24b 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +#endif
>  extern int numa_fill_memblks(u64 start, u64 end);
>  #define numa_fill_memblks numa_fill_memblks
> -#endif
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_SPARSEMEM_H */

right, there are some build issues that need to be fixed in this
patch. Sorry for that.

Thanks,

-Robert

