Return-Path: <linux-kernel+bounces-154571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256948ADDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EEE1F22F32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1E824B26;
	Tue, 23 Apr 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ii3+B9Z2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B212556E;
	Tue, 23 Apr 2024 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854943; cv=fail; b=WTlR7m5Ajzzt5/DqFNMIFBanGZ+6RstUbQpfWawml26jnKPKpBLZhHFhFbJZjGXPjCoPRkgYwoVCom0a1wtHwavcJIe/IRCZbf4dCoOydzNBXGcC8P+uOgiXmq6DWnPMIAxb+RS5/laiNE6KmJJ3ldXIHumeqovY5ufCZ3euuAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854943; c=relaxed/simple;
	bh=aj72cyKHm2ggEXtQR1tc/pqvWAjNWYY23c93+Ffpz0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mbBIwtMNsAuS3fa52t/noOkkkV2voWfj41m6rTvv44ZBUgh+cYBCOfipj3Yq6qPCKBT7I/Hgb2/FbsA848E4dMapEgqxObV0VVpwrjM2sxKEOnWvVw9tLPQBbdEov/WDoJ0OlpbxcbXFkvJ7NNqVSGX2JbRWB1NB6hsx0NSCBkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ii3+B9Z2; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1mpN4yA2Ir9YZ8ww1ycRltHRh4oQMhLDdF7oAaCcN3dg8e/HbuxrVCJI6qmRgxXkkiMfxmyJPLaTqrk19gzXXtdWjVLbXWYUZSChAh87yb0apYsVnlcSXAYYOIviKkKwJrvqzl/YpfgmYnfXfHf4DkEHl+9ryBIgq5xq8YqF9EOnML5pDwnl/Dh8RO/fqT9XI4vboHHe3C6yE7SMg9EXkCz74yE62d4YNCvoqMwmWG8zyvxjLeWGJ29CQ9LEKZ3fdGY32r27HL7XRqrco962aYJ3LcbqnWIbkZ3DvoLPbdgDUmFs8ohfIT2ckI5hmrmteCxab+RBhxCKpP80SDiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+ADkMu/QiIhqtC/ejHdeeHdgr3WvgIvm6GL1GPDvgM=;
 b=GjwivDxoE8ZnX74OYM28h/XIwj20idQvUK0rfuxdjWOYdDHwqgU+ysATZR5ZGYkGyuRi7UM4z61t7nBBrXyILYermK1537o74x9tQEHKwc59cyyGnkDUE0DI6uQ0zy8gzbur1ZZh9rgggNuLnACtT9b0fyFtGkZxIj4J+njeTWDwJ71/a5CQhDjTvDAFFMST5Jd+WU9snIyTbMOXnusCN35npJel8UVocJhzqFBZQwBvLoTK2j/Y3XYnvu0SV3eCfCRRFkUN4q/G/3MyqS/2dClVkBZpPfc3zA4CuLXTh72/PwMR8HP3yGYvLfztwD6YN+E1ifDGJlkcfRuuiUwhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+ADkMu/QiIhqtC/ejHdeeHdgr3WvgIvm6GL1GPDvgM=;
 b=ii3+B9Z2HbXu6xRjXN/pqLcULzY9BwAwNxIZIJQUGjZR3RPmhUOK5C6O5V5s4YnXZYrNvO8Si+szCXxV48NisJwYLCTRS7L3Ac4yNrxCRodyN9+OkcNgf/6zhIxyMvN1s9j83YeLKNdC3qo8fX/S62l8HluzxugcTlkq3sCQ+Ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:48:58 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:48:58 +0000
Date: Tue, 23 Apr 2024 08:48:52 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 3/5] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <ZidZ1PUhQTKFlU4q@rric.localdomain>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-4-rrichter@amd.com>
 <66271ccd13e5c_691029471@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66271ccd13e5c_691029471@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed8a4e1-cf63-47f7-b5e0-08dc636173eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7R6YGJdDBgErwLS7pgDE7BMIAL/RZLwFJRykzz7Gv2Dqncqe3HrWJqHcr3Xi?=
 =?us-ascii?Q?FRNKOaNd5Dq57kuqj+NTm6A6JnC/oNFktSVM8ZpvKp4dKM3vVpRXqorAH7xs?=
 =?us-ascii?Q?CS6RM1HcYZ+xZzTyWRMDTXZsbOPDm74lYXMY0Dg51wVCu8mwgINakZKyH5Dp?=
 =?us-ascii?Q?0YGfRLhQ3uRTvOtI8d3osN2sAbTQ/6RWW68djOKyJEk3Dqc8BNSEgQyi7ciS?=
 =?us-ascii?Q?zR8kyVl5+wjs/zgqnTpCRjmKIIaem2soKSp9/uuRyO/Z14zD+lCOilkRUOqL?=
 =?us-ascii?Q?9DSXzuG1WJJbINXm2TsZeV2SZ4RY2a6dXab784g5yetQo0gXYMJSx1MChH+o?=
 =?us-ascii?Q?vrGu8tAEK5OVZUtPqy+qr0T9M8cosHVfSlfHLQW/YUKwPvfOMt8GJ6OI0avt?=
 =?us-ascii?Q?woGPNQNaMG5IxWG7CsrfxDpXH/RrHtLArXViy43H3sElKA1I0+Wx9dlCaaBn?=
 =?us-ascii?Q?x5Js90KkJlQs6wFyCtDpjCY2lBsyPtX6LWNPQoqqkHTjZBUdu9jmO1FLu+Jq?=
 =?us-ascii?Q?y8j49io9HsgW5hgpLJL7IxaYqLJM+3QFBdrNK4Suc+PlSiztdYygTXS4xAk+?=
 =?us-ascii?Q?bqkl2N39pE9+PKlfVvBaB+iiLjljxncYsvXGeODbjcAfX5IRjrwL1h6CbVui?=
 =?us-ascii?Q?frqqF3v+n2G2ggoIxSjoCbp93COzqZISf/CySJsL75ejZ0sWcnJj+J5cBQkf?=
 =?us-ascii?Q?3qOwQ/8TjtaLO/zr+GJVTxpKkVXnngaHY79Y0mSb21Jj9BhH8n7RgdJiBZHW?=
 =?us-ascii?Q?+fFeTTv+mGbxte94Aw3nPhWGzKtb4CEsSQtws/zCHJCkGSFaGGnNH5Fr/8dC?=
 =?us-ascii?Q?ZVl1rR262hazSBIhz4AM9hWhGEE/M/YI5qjHGtPn3m2BHkK+08CvulcwBg2b?=
 =?us-ascii?Q?Ir8isboh94UAmn2F73wCqK/DSvmfG8Ng0H440ZIeddXGIXE7IZ/NACw3MU7Q?=
 =?us-ascii?Q?6KBguK8iD6Z0+2cQ4njudoJ3Bs9JlEW3sVMw+MjxyH+Ah12Dd1FMmYxu3w8Z?=
 =?us-ascii?Q?9yg0B8dePzNL95iIPtu2qtGIOruWqof7p8qYuRODfji2GNpAGZ3VWZS8R0gR?=
 =?us-ascii?Q?g9Q9hnXsKEF535o1JwQOH4Z/Gj/LBAREJ+a9VlROQSTO5KyYsBPBhjzLt9Ir?=
 =?us-ascii?Q?B0ImFA5ThQu1faVKWXhkyp3Gwnpnk1KXoNGF7QuUu6Kklhz69YRmETzMhOra?=
 =?us-ascii?Q?vA8rjVMB9IHqKzGXvC4DMNlEvwyUGCWSoT3HXzTwntBtW82JoV5S5OqkNq5d?=
 =?us-ascii?Q?vJkx+/hw7AQkruORMIuFX/A4NaKLcEgVCBTmZe4QiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlrivH/bmzuFW/SkWfPAhBX/VpxpxvgaVAtzK/4lXbsxkET1Zm3oyjvgXxEl?=
 =?us-ascii?Q?sVaoaBN7d7QlR2sa6kxxa69VNdZ9nrewFvFFf26H5/jCFqMSuUMDegRXpIqy?=
 =?us-ascii?Q?vcz1/W4tEuM/QyjrNFmXCbNMGO9lLyj0aRl9cOR5cBvj/hl2vFqNPzY49u4G?=
 =?us-ascii?Q?bwmfKTGHTgqZ2rzZGNi6lkN3DZCcMD5gAZP3eCD5k9uKu4FMfnPZnOlmiBNx?=
 =?us-ascii?Q?7ySOT4Ye22AJPh9p6RXO/Xa3ecxhDgmniRvuDzaLX7MVH7TWwukqev8TBH0F?=
 =?us-ascii?Q?QV59AfCDDMjI1XofqtXAI5p3MpbRznbjw6mvcjb3l3CXO9UwdcVeg7idRKDv?=
 =?us-ascii?Q?PEZ234s4fJiDtx2iBy6C1iFPIycZIY46WVYLnnAKfhVf0muiM9ivDTfxp5Jr?=
 =?us-ascii?Q?50GEz8MD/RnmpP4b0quZKnENALM/riuQP8QRdoAOb57vhXXEA4GjqP6BN4kF?=
 =?us-ascii?Q?tkbOzwf0QjJyTRaXWMelmmm9CnYtwQ7qHZGKjZzrMrhfyiaENSnP4B5q0msA?=
 =?us-ascii?Q?XMkVQLUXbOvCmizm04u+iu/WgPOCD8taqObQbeWKllcq6ZCmdVYvlrKgIWjd?=
 =?us-ascii?Q?O0YL80oTbYNoGcGodS4yaazwN+UJjRK4hv3gRTnFy6mzS7qWmfPtamwIAxu/?=
 =?us-ascii?Q?COlhDWtgrBAq3wyOVm2daqMhAwvZoWGLD2Iojx6PN+zdzCsX+mCXToTV1wle?=
 =?us-ascii?Q?IJ/fNzvHvriaja4zP51NKWsa1tHlQexJaQHrXoSjDJbmGxZKTJjj2/dy27Kl?=
 =?us-ascii?Q?2vnCibq5ECxZmgxGc4IZqMeH68bbSHh3RJ/fGPVOhzr1cncvogEJf0avhhhn?=
 =?us-ascii?Q?yDY1SYwXkl4666Dvgd6Cs1g9nCYqfuQcYYK91R9rTHPs3B/gIoUhGkomRAnw?=
 =?us-ascii?Q?a0bDMmmdtDO3O6S5K4+PLxF7bz8D3Iup3gXDShKxRUQH/3vQn5jLqn52Og3s?=
 =?us-ascii?Q?RoSwYiQMyqPWY49Fxu773nsZM5zfLurlhwXnnvLk/ca6DEduQwpOrfD5ZvZf?=
 =?us-ascii?Q?uBGAGuBdo0rPzY+KbtmTaqYm2qhP1R9MVfAQ5P3zYPYHZSlHe+rfKftsLtol?=
 =?us-ascii?Q?ZucSrUkhgbs3Z+ccePB5XIa+WGpxTpLXhd0StE86fPkg1Hd2LfUDRQwtw0dw?=
 =?us-ascii?Q?3BsbJRRMyYPcPclvrZ+5di7/E8WfpkTn7UaW/Cw/0PWz8F4JMJip4QA9PfLq?=
 =?us-ascii?Q?aEnn15nEnPer4yKdRsdbqSXWWgcsRo0BrHJWDmMq2WuyOZopNugbf5TJZ1yA?=
 =?us-ascii?Q?8L2IoWaow7uhOK3H/vdeevwld4irpNIYBP1RcLKQsj7U8mwvoXtsqWFTyjGU?=
 =?us-ascii?Q?v7U2FCV1vLUpqmpXlSJ97XrFLcEOGu6vgOEPoOx8zL1thigg7kruaqxykbIU?=
 =?us-ascii?Q?SyxXCZB9tBTh05V1oChZ64U2OV4QlPtUcDHFaWmxeTdnJQXmq9A2edisypNZ?=
 =?us-ascii?Q?q8RZ4U8eSUlLMEDhRfyHrhOkEp4B2/v6ngZ84AhIURegcbhsUnOlDTPMTwKY?=
 =?us-ascii?Q?+nl8ICXcI6JWBXfBQcQNDrtESPX1KNgbeWHXfVBGLXJFAThAZ15pJNA3rPg3?=
 =?us-ascii?Q?M9bPKz18K6geDtBcRxWR41SSzjg07RBsvfDLBclP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed8a4e1-cf63-47f7-b5e0-08dc636173eb
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:48:58.8697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKmUqsXxAqMt+fkLVagAIh4dFuxI5t/t3PxyPP16Gg8ntNtv4hS4TjXE8MhI7cYRy9vd5CnTUwmLa0H9CzDrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708

On 22.04.24 19:28:29, Dan Williams wrote:
> Robert Richter wrote:
> > With the removal of the Itanium architecture [1] the last architecture
> > dependent functions:
> > 
> >  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> > 
> > were removed. Remove its remainings in the header files too an make
> > them static.
> > 
> > [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/acpi/numa/srat.c | 17 ++---------------
> >  include/linux/acpi.h     |  5 -----
> >  2 files changed, 2 insertions(+), 20 deletions(-)
> 
> Looks good,
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

I assume this is for 4/5?

Thanks for review.

-Robert

