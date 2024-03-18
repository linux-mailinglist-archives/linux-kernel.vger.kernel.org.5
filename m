Return-Path: <linux-kernel+bounces-106727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847D87F2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DE21C2125E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E459B71;
	Mon, 18 Mar 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vFLl9s9s"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2115.outbound.protection.outlook.com [40.107.220.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1759B53;
	Mon, 18 Mar 2024 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798944; cv=fail; b=eh+KMENBt+xejvSgDJ0AUzVkMuaJq+bBVAcC2kMKqc0+X5Db5h5XWahT3Ofgf4PKDoHi5BX4hS0WUJ7ph9M8GxO6TOWM/a99O3s7Rqlb4BWURoq9Dswpr/dF3E3LZWjtQNPGPmTI2tyKrnOtGiK0wvXZy/YZ3KHpIwEJTA8BqZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798944; c=relaxed/simple;
	bh=90gwNDxtX/y2O7oDs3Xoi6GShp+l2FPmFg9pRgr01Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qr7QKCipzzmMrn40RjmdZpc3K/wTeKWajPAOfWDWLaq9VC4G7Fb62wSjZ+GfwBV5qCGUNGVKWlp6pKpi6H2SU4B/XQ7Nt//It2ZhSfX7pZMnXnBA8jX/NTd/aJNXt1nojq1QBF8SYik/06ZFa8PQley4DSpqde+KdP+UZ7JwIXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vFLl9s9s; arc=fail smtp.client-ip=40.107.220.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOyZxSdmSDWnATXnhRL51TdrUAmyjRVqemb6V7685eQWGSrTYKWVZbYt3LanOS+NrWTZ8nFUfu79djqYy3yZyl85+choFx7h5TypbMRjCprNJ2IjjgQwhtVpPskB9IIR9p7d1SIxLfOICA3GMeZzQBG3oNMEwRd0LTnwVTa2MT9DDyuFCjocmxrN1jkL3beh/CYwf7oIkZkb0tG2LJzdIwgaMmAEA1ot7AN2UjMHl4hnrNN+xCXH4cH5QpuvlgdowVCyXX5Ogww3m8yYdHXooMMScCX0elEFGUd9a+POCOixDXctVKW4u4aO3rI6L02sfYYVpYY7KRQGfRUOVAhpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1U275pKEQ3RCgbex6ccvuALWyWpo0/IxDDSHAG4GYM=;
 b=F5ovpQsP3Eh5ywly61FeaFh3a02yv2d0KsU5vP+p/Z+hsKq4QoQX9D1MmqSAmUTCXikOvfsoyjN0VjHvBAgzVEdVjIobRB5I0nGJrhHRsz9lP4knyRRhdV/1v7fr/6U3hqjvIpvu47qwmc6jA4mFkF7dN4wBbpTLxaysyQ9FEQaNhQinEznYvy9QaW2n/MJ3cWCoENlyfqsvmfKnaewZYq7P6qGbfRzCgUoSxg0ypdTeMPwMLmLc/ebtC8OU2j72SZBWwETIm3aUSUq3IwzXIflUipMzX88yNMBsUbAGKMnR3qFgDy9k62/VCZdLnsIHEa7NF7cCIL74k2XxqQpjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1U275pKEQ3RCgbex6ccvuALWyWpo0/IxDDSHAG4GYM=;
 b=vFLl9s9syGT5Fbd3v4ehq2kAG5+EEydEyjvRC0Au18zv/q6M16bbsbHTd1qsWWEAcGv+a8PjucxU51FExGdaFlE/xi+YbI0RwewzCe+h0m9MIZP7hAQpHwvmmS3YPmRQ4GrIjCctCmu0BdJWjhZmPWAJ4XL3IHn8W3Nj/VzJ7Bw=
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Mon, 18 Mar
 2024 21:55:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 21:55:40 +0000
Date: Mon, 18 Mar 2024 22:55:35 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <Zfi4V1g8kvcgUx44@rric.localdomain>
References: <20240318210904.2188120-1-rrichter@amd.com>
 <20240318210904.2188120-4-rrichter@amd.com>
 <65f8b263bd757_aa2229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f8b263bd757_aa2229444@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MW4PR12MB7119:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YtOqqLc2N/sA1yMetZCU035PIU6Uql1XwI/2mWxPFr/BAhp34akv5Jb/oZ7L0OIVMupXBfMsbjmykHCAMGoOI8pJ0OwRGxxjj3jIve4LCJ1fuCy1YEzqKiBV8VVawXdc3D6l3uthR+259eo3/ETMV3+S3D+7RM9cKvjpjgUlnSPdAclDQajH/gNqZ0qs8GtKXy2W7qZuT2bpj8SzAD7MUqYZ95xKejvuVi6siElc0XNZkKgSqNYYzBvrxYHezux219fdfypFFYL5LMvzlDrJWcP1ARleiDUyONc+lu+LBL+hYSLKHJ9KoGKXEpH44isZJkjha3CNaRyV0lZPuF0rsgdiCaBZ8nRaVCFCcNsVsK58kng8iZHkvZQYj/F0NtrPBnho0H6iJsYYTX14bQZOqXWRyFU9diU+ZDerUAXiAk3CgSqpAiLywcEsafeS8xTVxB8+cPCeWtdxD4BuobfOTTcR4zHUFE01Lfx4WvCHs+hBf++QWoiwZNe9Vhf+++XPG9Lx0MvWtyWOgDc5m0y/tZprRejVhh5gM7ZQ3PpkopPyvWmTrZTOPRhHzk+gzdiK7BA/W9dv3aBaI30agT+mkFpkDDyz9/8KCtHZ2YKa4pnWZlTzaJaQ/oBlyyw/TvafhKAnnx1gmgF4sfmKXtYPdev5C3pEFNdm0sZkhYdAk7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NoEQECxZ8YiWjdhKHR4NsZpiiXm4q657TXx+nNwIP7YZd/ST6FNskr0aJWw?=
 =?us-ascii?Q?BeEDZdMgP3C1Xa38mjl8jIL7QeLBrjhxri1FarOS4Y5mTL6losJor6z4KZqj?=
 =?us-ascii?Q?D8M7bBbcWJgzA86NRnYsJVd+S17mt4H+vaI9h95LdCzQesurPyNJrCVsrNtx?=
 =?us-ascii?Q?40Zd27qU8Co3SlpsY7lfO5I0LmhtR/Boe7IlRhztI/oS+GRt1laqgoBOlfNv?=
 =?us-ascii?Q?SjBT3cD5/I7+p0IGIsSg8YJZObxRdEEKOBFQiup4JbcsFi7c9P7jBHAxe/al?=
 =?us-ascii?Q?3AvrZIJkw+rau7AmBzPfqmI19scJ9iDtZ2KecQII1uFlAc0OM8pJ66c/jYlH?=
 =?us-ascii?Q?rgK5OTcL2+pqT2nyYz3uGWrDNdAaXNj9HJIr43brHL0dfWXezhz2/xFliHyv?=
 =?us-ascii?Q?wbdnoBHszX18L/aYtkEasphd2Aqmx6WLfPoqwhxVozYRhsO2bZnM7Rz15X2/?=
 =?us-ascii?Q?RLpUu8tCey3GxNJMahnInGytxV9btcc6yAnegf3LrZSDns7tJU+6pNXpgt3j?=
 =?us-ascii?Q?L0RdK0vjbSZdepNc20XGI0OujNy1S1BI5C+WXevijXSapXlvyvLsskGAfpD1?=
 =?us-ascii?Q?TBQqNwlRLe3a8ArsXd0qU/4rrOUXliqIUvi/a6VLKUUEBbcGrESv97dQuHk1?=
 =?us-ascii?Q?2J1dXhGaHD8vLzQSR01AwbOK9KWS9Krf6N5/i+mOLXEq9QYI56FgxfGP0BS3?=
 =?us-ascii?Q?q0uX/lVNr1Z76AeRxnMmO/fyFFYAW+2FtLQEY/9SsMFKANGoEMs5kMwhzOZ7?=
 =?us-ascii?Q?ezgS06n9zYLsthcSkrqVr2TeZgg1CxC/XTGrswnnPm6DjLvZj5Lbmsp8RXDo?=
 =?us-ascii?Q?3aVBsdVQ9BlOYKRmjCjoaQhCrTVlAgtzvGyIOZdMqCEIpm8P/Pls04quF+HX?=
 =?us-ascii?Q?mt8PQVHjeqeU/lpQQMUytitEHv+usqFZTMuHRXbtKOlalSZDkjYKMp6aRiIL?=
 =?us-ascii?Q?mMZHYnBart2lvtxzsqaZEE64ccujRDC+mav/wgkFCHndrrKKS6lVC06DLCRq?=
 =?us-ascii?Q?lu1L4tBfB5obD0rqiwQHBeBdRFWvst9kXyDJeUgIoj8OF07dZbz6s7a8xYD5?=
 =?us-ascii?Q?46NxeW/h/pxEr7sPhgVnMLiieb5T/ol/z+oisYIi/vfPDRPsNTv8P8zTBPvU?=
 =?us-ascii?Q?XP7QBSXD7BtF199jRm7UlH9yn38eLZ/6ABYohgmPW3QuXcUPIF/vqIxBIdoD?=
 =?us-ascii?Q?zdJs8B88dmTQ+kHFwMybSIh8qVTmv2JhoKCqU/JzBveXxwt83CR0+0R/ze/+?=
 =?us-ascii?Q?XkSWdfgNG6TNl+++8F4CebjeKN19oPluypBuX/6PTKrHf5pfuCU5Wqi5ZMb5?=
 =?us-ascii?Q?2LAGU9jrOkqJg/PvoBdP1sU73txngg1iv0AuHSg0rjBo6IgPpf9TrwI+PZz6?=
 =?us-ascii?Q?eRgPISdxG6hgb4wUSGGD0xb87BypN0KxvAU2nf1bnM+fsfmLjuyOR1LuycQ8?=
 =?us-ascii?Q?7UaOitz3Qu52cH3tmviu/mvWprcGXc1mkPAyhe69Vmnc7h30ohF6qX8z+0BU?=
 =?us-ascii?Q?Vg+wweM1uOKOZJx9gBuNDNZ2Z+VY7RQLxnSx/J/ExNqIMO3EEFSvRpsX9sx4?=
 =?us-ascii?Q?RXCcEu0UxiyGtXH8jLt3uPZdvaBkTCT6PmqCqKuF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4869d91-168a-4bad-f428-08dc4796271c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:55:40.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 461MJEQJygeW3RA2C2pZKKeTGjlvZ2OcvnB0cQhBjpv038ePM2TWrAu3QqAv99sqyX83OyGGzOdZEOE7O4zpxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

On 18.03.24 14:30:11, Dan Williams wrote:
> Robert Richter wrote:
> > The CEDT contains similar entries as the SRAT. For diagnostic reasons
> > print the CEDT same style as the SRAT.
> 
> I will defer to Rafael here, but with acpica-tools, cxl-cli, and
> /proc/iomem is there much value to adding this to the boot-up logs by
> default?

Compared to the number of SRAT printks there are just a few CEDT
entries. I have added it as CEDT and SRAT entries have the similar
effect to NUMA, so diagnostics should be at the same level.

Thanks,

-Robert

