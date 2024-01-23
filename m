Return-Path: <linux-kernel+bounces-35252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFEF838E99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EE8B24788
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1085EE6A;
	Tue, 23 Jan 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1RGCUa4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251725EE64;
	Tue, 23 Jan 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706013175; cv=fail; b=uYt0yx0xjn6OrNLIgGUFHwA8tg3I8mCq76ISuTIT+clVmhqx/1ozkpOgVJubQzW1403fvCPm5Mi4QnxanLR24XsqY1srbAITA00CIY3K8+3XGkRI7PCIvxz14P0Q+d4JiSw5XZ+kXu20zC3wpJP8oT+kYOlrdY9m79eyejDuSZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706013175; c=relaxed/simple;
	bh=LmNf7rFd5BQMGSAbRzoFRpJeuNKb822WxwYNN/iDDe0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPWivcL/hh/ruZk2qFOCWyIdkkHVG0ObWXC92xwdQGRMaAKiEHGLnONjAKUssZIG0iw3GhGlUENSgL+1cAnOZF1R/7HtjEk2jknDYTfRiS0tavdVmBO3Cwa8JVO8/og7y5/Ybbcw4K31ZInGyav4b/CJgR6CCE7qjX4BDLp6GKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1RGCUa4; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706013174; x=1737549174;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LmNf7rFd5BQMGSAbRzoFRpJeuNKb822WxwYNN/iDDe0=;
  b=G1RGCUa4S+SiezBGlJdErsxExU5wsVNcsgW0wqFWcu7Im1x59/+av9/Y
   e4mBNtLesWH6Wnyau49zvejikxsf+MVt+zuMxtQ/ALK5SqkhLSHX/9d2S
   KLBommJb/Z4phT6cizVRRXgeQfMN43rHAWdW7h2f9v44M+8RVEPV3vXnF
   volYSX5w4YLNcSso+j/gPDCoVUGnHtN5D36Sql8IGu7V1KaAJ/D9LlOdf
   TtKqt8iHAnHdq7I9yUAk7/yepLQE5QA/KSPQ1OAJ9f6Iu0rdgZH7HxWu/
   CvtxZHdeBUqfmwnmeF3dAQ5go1/VP7GulIYfbRvkIAbbhU0wOkXNVncOV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="15019057"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="15019057"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 04:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="735552723"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="735552723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 04:32:52 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 04:32:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 04:32:52 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 04:32:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSyHCV/vwpaUW2afe0ZaZhDJGI6u/4ErT+x7+uXtQMhrJb3GCd7zO1trskyeEO4wLI9ljQ5lxuX3+fjEZ2SmOr1bHC9IApUYg2tQ26aZ3QlnesnIwVqpAtpGXgdpxdklZ2zvVlewRCs8lBXU19OhF4xVyG8UV4X6j4dUN1szd+9NY1U6ahpMSYmId1JLg7L3K0ccM6oGoiwB+zJom32a7x+UwAhRAsB8sOxbm8yYKaXozTmBfKrj8CYF78vIh4vKuXZo+27RgEptHHRF3tP2tyz9KUxxbtB66qaECeFODGKc8xT0PHYsTvQTnncqX5IXn+Xf0wtQ3cmNUBf6QF1AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epiYRR5v9c0Yr5KpVdGdIqqxqoV0jhg9oQg8oikUxU4=;
 b=Ig2v6ksEDegxRKfqqS42mwP2/rmvsSy0Cvj3dH1ZgrdYBGdAU8q/0EY581T1I++LLfqMi3xq9sEchHuC/o89395Htm0tQQS9PqqaA6B+OI70gk0Ec3Y3Y9lQaQWxrWMTgh0ZhLjqAgwpobMSgQG9YWADqoRMCGEoHwgb6jjEu8gb+tYjr11rsv5U479dNO2Nm7TjnAqEFJxqiPfnCO79KPGtIhBff8FRtUxAKiC7eG+as/Hr7Tr68siRiWhoEXk4x8bMNU4FGWbxp2x23QS4QGI6KSgQ6tYiWBduFf4Ggmng7dsQSyz+G3SINlr7aOYqGF3zLAOeAxI+Dy/P7eJPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 12:32:50 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:32:50 +0000
Date: Tue, 23 Jan 2024 12:16:13 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Erick Archer <erick.archer@gmx.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Tero Kristo <tero.kristo@linux.intel.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Damian Muszynski
	<damian.muszynski@intel.com>, Shashank Gupta <shashank.gupta@intel.com>, "Tom
 Zanussi" <tom.zanussi@linux.intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <qat-linux@intel.com>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - use kcalloc_node() instead of
 kzalloc_node()
Message-ID: <Za+uDX8DyggIGs9V@gcabiddu-mobl.ger.corp.intel.com>
References: <20240121164043.11222-1-erick.archer@gmx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240121164043.11222-1-erick.archer@gmx.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0209.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::22) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|MW4PR11MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 5348781f-e3b4-4e50-b6f8-08dc1c0f693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfMkChAloa+Oih+13vIFeEgflWeqP6zuxX2OHof55MR6iJScYYBLsVX4hXylFikxd69hl/hVU8iuY6Q1DafBEw4wRUp9/+gPewMYloQ3SbZsADnOsMpG+iW1z/VL2/z8p0lg4cdHZ49YhoN/Lep83ggRsQgl61D94cfNqGXR3Zuw/Swz7lxHpa1CBoCmOZQWL4oHFCAXASFqm6Bhb5f3GdJsUVO0GMozQGrKkugyZKsw/JLFq6yLZwpT33gJmSLdL6POlaKh/lRY23xlo0pVNS3bBU+EHeRGa/LOZeTomr/yT5u1gzfAHapDhgFKOeg9naowbB02eDkd1c2VLIzydNnY7pKEgWeLWtf+FVi3izI6GrOgVYXUjrH6tq6269G40cUvcrEUlkwURIBxYzhiX6DB7zuwevuyxquZt93+83FKSSaI1ivxGv15dOfZuUqs4Fe8wOJiNIvd9a5nioTU+7FqKgrP2/nr9aU4VRrji5OxAhkELOLLmj6QsEKAazaBvhzXactPRHzl3p6N54N35Fnq5KeME08e7D691ZLwGeWHdVXwFaO6OsL2h50w3ODSt6TVWU1xjSqaqh30qcJ5Ah6bO3/udOgavIjkxI0w64GtudpOqSrLB6fk16e5xgQjnEkFR4L+T7nqJBE9PuVcNRi2kzD3iyu49WRg6DPQSDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82960400001)(6506007)(6666004)(36916002)(6512007)(2906002)(83380400001)(7416002)(5660300002)(4744005)(41300700001)(966005)(6486002)(66556008)(66476007)(4326008)(8936002)(8676002)(54906003)(66946007)(316002)(478600001)(6916009)(86362001)(38100700002)(26005)(518174003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p8cCPugSMf+8nRtY3f5NF5FigE1n8yuiAtB/toqiIpId04SPSP6Dtd+S1BjL?=
 =?us-ascii?Q?iD9CZ4HkpLPvljiGGN9d4kSYXxWu/mvRlZmUADCaERGhMWscJzMou13RHk5b?=
 =?us-ascii?Q?wDmW9cCp/t/fzew0zaLWKPshJRbQjX4+08UCi8ZpqkPN+9ldFK3i7nvwOERo?=
 =?us-ascii?Q?+j4QlnMlgaF4HdXVAZawEcGcDDZtaS2+5WgMk/hWfbPQ8ekk0NiEPbRVPose?=
 =?us-ascii?Q?RfFUbGbFqBotPnPgPXQgbP3obPw5YyZSBXuFjzwAxuPoxeRJYm3khc2HKDG6?=
 =?us-ascii?Q?y4mvBrryu/+NgmqHvnueoZV34pM0olvFqVzIDabiBryZHlJskeHddaAiHG2U?=
 =?us-ascii?Q?s8SEnQLLAcMahoK5qbVMjZMdbDVnlVuN218d4bv+uzv2Ab2+0zazK2lF07Iy?=
 =?us-ascii?Q?UBFKNRivm4la03akKoxj+wjMYMPI7ayYvp7Chi+/Q2z+rGEEUn5VUk03Iee8?=
 =?us-ascii?Q?ZzrRjmkR0+ZUYclCnJhC/AgRP+t1eDY2q395PMbYhS+kJUBvxdxWYrSNFBiZ?=
 =?us-ascii?Q?cESMFUqlfFnCZrMCccgxpBL8O3wf9yf1CuQtRyPNGLyL6UajqU/wqyDK5Yam?=
 =?us-ascii?Q?CbGm7dREWQAhbiKVJblf3euLGEeGvk8j/TcZT5fEDZTQiosEs/Y9d4F5ltEW?=
 =?us-ascii?Q?k8Jyvj0blXSuxd1qsdih2KiVTP9jT5iwULOUvWx0SngXVS7g91rNjBor+Mgi?=
 =?us-ascii?Q?2STxc6yn53oh36wNOpl/7P66WJgdX31LoMuXypVQOEKr0NFIZTBUqj8QVGI1?=
 =?us-ascii?Q?nI0pNfvasqpomWpeqdfm0elVZBLc9lov2+wUCK1y33H35tpfr02trxucXICv?=
 =?us-ascii?Q?FUG4uojkaAaxG991BFDLXi4Lu7I/WGnywImKd1J5jwaXjM/0Lebhp6ILDTVt?=
 =?us-ascii?Q?AUHzFPITa5N99pszzgtUD5ookg2ZreDnhZIU3GEWg5qXuNsbjKd/DadDWRGA?=
 =?us-ascii?Q?lNUV6kGWDEh8+z+iBK4nvuZIORI+yHoOJDAvGn91Ci6EI0Dnbkhw2Prhdhuv?=
 =?us-ascii?Q?HwJ/WPp5Tq/mxizWQ6q5yz1ME64LHwFz6w0LboLatHMGytVgHOMs7NYT7/iF?=
 =?us-ascii?Q?mRs5u/82VTQIBovBQQT22Sk/Pr4YnA3PfRDJBMOT0WBeJ157ZKR7Cka7nr70?=
 =?us-ascii?Q?kFiqWOhNt+r1B4n/93v/LEpBO8YVvlEfbYjsXIIYFscaBraaeb4nrgnjY5yS?=
 =?us-ascii?Q?yfxC5yQE8ZwjkmLRercFv5DXPg/5a5NEHR2Krl5uHGFnHTPYuW42Bk8eZi7H?=
 =?us-ascii?Q?yJvuH1laHOzdlPDwtI5NLOrrdfwd0rJ2cXSyGmJ2ozdbsG3WFw1q4FWsZqeE?=
 =?us-ascii?Q?IKXG17kbcxeM0fG71Yf9fqJUfmFWnIoJJp191IHRbgN5F3cgr4a6lYCN5tGG?=
 =?us-ascii?Q?1eZpE7GHhLY5VSpiFL9e67gwHNZMD3pzC0mALfGnBQ31xNzaM/aKmFtV62UU?=
 =?us-ascii?Q?KAarIo4Q/DZRdDcARnrsoiZA7cxSubysKPrRj0mdvIIpmJ0KaXrR81XQeImn?=
 =?us-ascii?Q?lXHLRZe8uM3nzCoryZH1mLwEMnnE9JkCu879UMN+enMxgc8SW2uZPJd8Mc/d?=
 =?us-ascii?Q?ZMhST8H7X4pnypog5b7OiKjSq35yzH70MWlOZdSeoPa3DyxTsdmHuOR4TOq1?=
 =?us-ascii?Q?Hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5348781f-e3b4-4e50-b6f8-08dc1c0f693c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:32:49.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiVkebhrGU/udbBzm97K9Mv832zSGWVYHRgd44F5bX30WGuYFsqhldIy7TCS19JJtY/NuCaxOij7CKs4t9iOXLnOvYTF15okw9sH7Kg0tUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
X-OriginatorOrg: intel.com

On Sun, Jan 21, 2024 at 05:40:43PM +0100, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc_node() function instead of the
> argument count * size in the kzalloc_node() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

