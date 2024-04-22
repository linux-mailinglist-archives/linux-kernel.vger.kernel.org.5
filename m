Return-Path: <linux-kernel+bounces-154037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8E8AD674
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F7628326E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129351CABF;
	Mon, 22 Apr 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0sImOoRN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEBF1D545;
	Mon, 22 Apr 2024 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820679; cv=fail; b=s1atXPrRMC71NZyk0ITu5CG920saq3HJtm6fB0NTZ3l6Zl1LyyVATjSfQOX74phxeGgBbBChgNENUtSxwyH43Tg+b0W7NtCaBud24gR/jQtcPjIH+ZBWc+CbURwlFRd8r7fQvNaOV4yrR1ikDCWKA7YJdkkhxBZmS7JiI8rQnzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820679; c=relaxed/simple;
	bh=QmwKNEOa9jqza95qBdLqSzcqhLhCd/DVuVr0Pql4nOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eapQE1O82PIDUQFTkH//FAV7LV7XZheAZMXfUeQS4hFLEYV1+iu/62D1z54KatK4hbXFWpLyDXXhkkv9Sj/wqmc7iow+yyJJulxBmWrySCvpwuDZ6DeqVFDvopLYfmLufz44hcSn47/U58ATEPIaYQV3D3fg8e+EhET3FDOwLpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0sImOoRN; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJfeYWiIPWZQqpCuD70p3yyi8sZD5qlF6SK3pWibsjxSRRJxKR2OR2uGcJ26AL5EAFcaWc/h2EHyWdAEjCDxN7gOypOqNxg3dOn5CSmc+JBQZJl+KItsPoPgxxy2gHy8X0CvgPLrFOc7mZv2vLQfaeKECk+hjQmYc5p1WE7S7j3OKTIJaJ9Dm5MZ8eeqFZFeZVOOvq5k+MtWjAnHw/zRMnxki4eWMhJd98VRprc5LXO2cksAMxzE5a01CsCBUyHViOutT2LlfTO4rLXvkrEFP/Fh5I4vG/m0/Z6VbwXmYN8soDC7w1u6v1m7ORRj5oSvXBwoQZXs0OvfigUHpIEBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUB5KTQkky2tCWoAjbbtkoXEuvkD3JTOh/VstGZODSw=;
 b=UeP+W824w90hFpcDRc1k9XxI6Q1y9BomoEfMxm7SF0Khi/n+F063QSE3cmBOWDkcBVsxOS8+CCRGK6jCiXc2TSoXaHePwkM6aN+oyLz1RDMnixDHvzmfzH9kAMVYHoAl3xpqojjxiSNaOINIctX8hZvGyYUl0SL7qO38yOWCLy4NfrgTSn+wTMb1B410H0NVJfuc+tJV7I6JHFIR7Iej6a/RKosEVgRlLAcmCJKpnXPlgmfIycMrGqW9+dFCDweNZvE6tHqQFrbgI2uhr6Ro5PhMRUc2wjnI1iuVjmEOVw+mdEEsOZR33GVnf0F3Rm7fpt/mYZa7YQq6OY29dhjDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUB5KTQkky2tCWoAjbbtkoXEuvkD3JTOh/VstGZODSw=;
 b=0sImOoRNcjGsa9/KHvo9TPSxtSpeKDmYpsm+4MmiLThzNxHxiLLg34Bttps649/bMcGe39ZzC62DXwy0Q0uo2cXla1QH8NP+1SLNGDp0DJ0BXy76H1eMI1lR1bvErkzDWwdM3va6GdUGCOphBxw+Am6ylU2KzTtXvC5PDG75tM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 21:17:53 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 21:17:53 +0000
Date: Mon, 22 Apr 2024 23:17:47 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 2/5] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <ZibT-38ZfEkIZrtG@rric.localdomain>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-3-rrichter@amd.com>
 <ZibO4C7bGb4tsXuJ@aschofie-mobl2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZibO4C7bGb4tsXuJ@aschofie-mobl2>
X-ClientProxiedBy: FR0P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c45ed-e39b-4b52-773f-08dc6311ac15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vq0U7qsCJTVkaDTqRrjYOcNeU0XUA7h3mhE1JX4rNBYPGR/zlThjQgx1mmu5?=
 =?us-ascii?Q?79FoVNFlxw7OVi3e98QwU3UODUZfGn4g4X9s9g4clfJ1OQlw9gGJUlOhuju0?=
 =?us-ascii?Q?PxLcshVKRlcCZyDI40juehGmPIw3lpl2DLmW+dG/NCZkV/pWIHToPXQRGsad?=
 =?us-ascii?Q?bZp/SIXEIcCRFvYmD9941wOctbp+tbJeRWXS5oGXGtVNYvIOkUgWR07eyQmB?=
 =?us-ascii?Q?Et1gQjpR5yDAy1UMdFPxpcD0o0Mjpte3as24wZ8Jo/ntH70mCuG5iv3rhoWV?=
 =?us-ascii?Q?lRfNh8hbbn/O/wFmg57/m+qPi6ZQncIp9vrnL0WkOrKaPXKed3Vf4XwFUPZ4?=
 =?us-ascii?Q?CPsguO1EeWEAhPlD8t72cPIxB9dnzbz4vmyCGgGEWC5dRx7zClZQ5vbZxgmC?=
 =?us-ascii?Q?+g4FWaMwVyOjAH9dnQUS2N5ipQyKg9ZnZAc11s2FUc0ipqpyItRxqFyLB8sR?=
 =?us-ascii?Q?83tM250VMpxUNUH7SGMtVMD4Oy+sDOJQY2oHFjlSsIfVPpPy0PREo+OEFb96?=
 =?us-ascii?Q?scZrj5og/pZZwEYUEDnvOZwqGoGVY8SVM2rTv8b6kAFC34yJm9H4Lot8nfSE?=
 =?us-ascii?Q?G4qIcLitk7dMSVPraO2BPNUxSN5O0CF9lDkbl9kS6GN8sfGiMYJLGXkO0p1o?=
 =?us-ascii?Q?Yz0yUekHewtQOp44A6Hv4Ymk++MbFqGUYpFHesi4+PWxxyQzKhNlxJz0KMTq?=
 =?us-ascii?Q?j04r0KEhsABnKtEzzRrByUVvmaR9xdYrgdd9GSXEl9kPTni6OQVY5B9eKht6?=
 =?us-ascii?Q?Yi0h6XkWtV0121Z75REXq0xeqBbuXswER8581C6jENthQXQFaC2Xx1sYeUMt?=
 =?us-ascii?Q?99cuma68Y9mJ7SZmAlw+UiCNXOPcrhsoDir4+O+01SdCSu/v8XoqiJINTO8M?=
 =?us-ascii?Q?jfPDwEnelQuk68NJmqjxZ0TeFJpZpAFXvuJVp4p+KFTB3ijttiwsTdqUtnma?=
 =?us-ascii?Q?cIsNfEm0vD1bc+ajk2o/k1FKJycaWCPsDUYpeA1CzbX1BDx8hrPsCA8UmelR?=
 =?us-ascii?Q?A+xMF27Ro7ZhczTI+g29T/oVuFa6K3UloqPCvaR2eXGLJJBATo9rwgnNHhC5?=
 =?us-ascii?Q?vi/aKD4MR01e8w1KBfH2bFpE+CKJjiU0K9XU0X1sn/5Ckse5FpLesaTjnSEi?=
 =?us-ascii?Q?338LGp0MQnq/hh60jzFUM52T1VT5Cq3Qk8rBNnlcOXr+QRU7l3047QXlQdSy?=
 =?us-ascii?Q?lP/leiTWh7J7xlh3+wpNS8sNzATqP2sqMQyWrXdNsOeaX1EM3qT1YNGJwqTG?=
 =?us-ascii?Q?/t2/bkPHT2XRBB6hJTNYF3+iMfc8b/fVuxgz6y/IEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LnH3TMEhvYM9tWShMnegAW+WbjHjoJ/XjJc3/6C4YQjg/yreQd/pgfKFI9B7?=
 =?us-ascii?Q?dTKQ8HuSu9wRtlsDWzDbMGTYNuYiEbWtSJhmDIu+RJifbffVdj+48LSzXa/T?=
 =?us-ascii?Q?u0pzRMcaBDiUH+p3NaRJmXs89sqiZR5GE9TvOgN8+It4vUw7E8DaWL+/riv1?=
 =?us-ascii?Q?Wmna6oDj6NoaWQciYHZZXyXcJUr4CQ+8jTH3EB+q4c34GGSPL4I9vpz+rSpw?=
 =?us-ascii?Q?H/D+7LyiusnKZJu5FKdIRArGx97jzJ3WjZKUXYXMQqf79v4h8I7d0oNydXIc?=
 =?us-ascii?Q?OKPZhXMwgUbzI/iJGxaUg5ikq2QlShOtkLz2PrwwGtFAZM/8Gdk2CgG5R0h/?=
 =?us-ascii?Q?kPEF/ev3p/hI0jbvz2gRRFAHJ2C8FIT6n+D4luUgIQ0I5IS+3pNupTPCbsom?=
 =?us-ascii?Q?Mtqw6UNfwCLiFNfRQ49EXHtrSJVQ2oERg5HMLJlt5yeEU9pzcr6uOTV2yL8y?=
 =?us-ascii?Q?Aj4y1te93MM9aX0J2x9qCj6StJj5hZvZjeULEhQY/tYI009FFKuDUpy938to?=
 =?us-ascii?Q?lfpUZPbFQkST8hVl+0NuiIfWE8fCISPdoogVjS/8HXOq48pPyhRxS1uqmGEf?=
 =?us-ascii?Q?tIw5mt0JSBbeyVdosccdVt+5mAyXAQ+m8eL322nqte1D0PeNbcyaeH6HTFNO?=
 =?us-ascii?Q?8NQq2+OT1nevIrnTQ/BaipSqGzhcwrHkn7Z0Q7+JFvsVujW/hvOdxVwoS/Vu?=
 =?us-ascii?Q?NO2bO/Q5AlTeAtU3c1aTtzf2n9cweZbrryJMsaOFGhDtmlBc2qYZ7XzweNRb?=
 =?us-ascii?Q?R4iaVqQRAgiD6KkuTdshHi23vVSQ2ctul6rR7u6C9A7aTX7oQ8mocp4qW/yS?=
 =?us-ascii?Q?Nbnlta4smU6avOrKwwtcXHjng8JqDWiNg1McUaKxMUCL8wU7DH9xzbGRgKIh?=
 =?us-ascii?Q?sOmpeYagsCJgFeMavpLWa7t0bbgEx2YbO+/iKZfVvYuXedRX7mW//HR5kjlw?=
 =?us-ascii?Q?GxlPawlsqmCAAQWCU3sVbN1ZoR5BA5MEN1xMpPEevxnBQILj8i0ocQiUNrnb?=
 =?us-ascii?Q?cdRaFkQySdgaieCtm6oSlvsYzjVrhKZHkDPGeiFxZqOYMWOfXtHuPY/ZuK7A?=
 =?us-ascii?Q?uk9tJ6EXMBGqsRXhlOt9d4J4TVGsVCvusCL0zNtJ+KRyg4nJZF0ayynglD6Y?=
 =?us-ascii?Q?LSv/AYSGB0zZmRUtP7p9+Ti0T0/Hc0XrDQMDgTUaGxjG23SpMHkjAD8pX1+y?=
 =?us-ascii?Q?D3nI5sXwXxTad4PnWKdh6QnzLOglKuirzgvItq5AmJKMi6vC8J/6A3R4FjO4?=
 =?us-ascii?Q?2dNnboW1WqfyMQBG7qF9tYdquADCl/wDOb8P/bp0jODz3sAaxCME/K2f19h0?=
 =?us-ascii?Q?JPEZ7QbTdaQKs8evDuilcHL+EP4Co1PaJvPwul5YWUptZOV00W+6nHOlg94R?=
 =?us-ascii?Q?patbLdxZi57Pa45zuBLPZ9iU9mtEjTq/YzuoiliChSdwBHyqdOAXAdyGO4d+?=
 =?us-ascii?Q?Wy8MpOVNcyFaX6SPHtPSdppiu6BrC7LSFBuiCRhYHcC5C+XVrpwA/ljas5Ha?=
 =?us-ascii?Q?VqXg12RjicPlyzLWNNQV/xowNgyoCXFiFbTG6l5GV/WokFovRBe58sj0Ph2y?=
 =?us-ascii?Q?xslv8utk7qRELjivJvS6bi9BdBXp1//VGG6t2FHJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c45ed-e39b-4b52-773f-08dc6311ac15
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 21:17:53.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT1aCyNOOcY9wnWsPvEWX2hzqKrc5EqDP06uwmeZEA3kHv0lqCqvV+VvhPUgNGGlFUs7I6KrSOXlIm3r9N3bJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607

On 22.04.24 13:56:00, Alison Schofield wrote:
> On Fri, Apr 19, 2024 at 04:02:00PM +0200, Robert Richter wrote:
> > The CEDT contains similar entries as the SRAT. For diagnostic reasons
> > print the CEDT same style as the SRAT.
> > 
> > Adding also a pr_info() when successfully adding a CFMWS memory range.
> > 
> > Suggested-by: Alison Schofield <alison.schofield@intel.com> # CEDT node info
> 
> Ah, I see you annotated the Suggested-by. I did suggest the pr_info
> when we extend or add a node during CFMWS parsing.

That's what I meant here and what I have added to this patch with this
update.

> 
> There is an update in acpitools for CEDT decode and dump[1] offering
> pretty dumps of this info. Is this printing for convenience or for
> something else?

No, this helped early boot debugging of kernel and ACPI issues since
CEDT entries are important for this. For acpitools you need the
machine to be up already. If it is not part of the kernel log there
would be a 2nd step needed to get this information from. The patch
also lifts CEDT logging to the same level as for SRAT.

I hope that makes sense?

Thanks,

-Robert

> 
> [1] https://github.com/acpica/acpica/pull/939
> 
> -- Alison

