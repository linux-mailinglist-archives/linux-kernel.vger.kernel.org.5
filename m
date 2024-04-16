Return-Path: <linux-kernel+bounces-146244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DC8A62A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FA6284FAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB6381DA;
	Tue, 16 Apr 2024 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+ZtnO5/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EDE381B8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243297; cv=fail; b=BmRf4AcBlN07OySAzN0KI8i/RbYK/FtgvybGuF0fiN1RSF/7lBAkD3QWgWgPoG5eHhyRSXtMXUkioMF/WnVJY5lNl8M6KWcSidQLfd35vJXp6qXuQAt9XgGkKHk+WbAOK982dVct0ToNZpMqOGCHSjvasm6S2pEr8WD5uex69eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243297; c=relaxed/simple;
	bh=x5klNPA8BU9PwtfUNxjByF+KaIvJnCHlkr6Njz0E0Zg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uORrpFntrc7o7s+px88swH3l7vh89W82ZxDpfLVNZpOOTPQUMdJ6SUKkABQhCz6zp99Z0u0dmJGVJKxLsk+8wdntTKqOwxqlEtLWuQi2c7qL1AAe1pYwHGOD/ZWeyE12bPunUC/hwqpF0PZ3dd1Fb3/i7gnOASy1zKbCFdU0YjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+ZtnO5/; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713243296; x=1744779296;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x5klNPA8BU9PwtfUNxjByF+KaIvJnCHlkr6Njz0E0Zg=;
  b=L+ZtnO5/CwbuMkqboku4RrIIZS8gp5gtzzksHkMblIh4814yqYG5l7Zy
   eG0JZq6ErjriAONDgEtf7x9ta7i7oXB3jElJc9pe4rZsz3kh2cGGBAf6m
   rySGnGsAG6xT8grFsA2VHvp0250QbVZ5kK0ciqUDMhdrYIntyJG/GzXa8
   Ju9F0kkpUmugMWCfkgLBCGxCovKDfvdlId3uWVpPaIC//Q4zhXix4JG4L
   WH/1Y4XfjDSZH7H6SqsjJbu+yw+Vjm8LZI0kq+9X14YmP9DgZBLoJMrfH
   Z+iEA2M/dPRCHdUm5XBIzYi7ROsLCqq0beg8OC3WwbtrQpwf5SRtw16/C
   A==;
X-CSE-ConnectionGUID: xJfEJ3CrSRm+DPd0MiZzMg==
X-CSE-MsgGUID: NYMjqBrsSsWAAS9qdSmaXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8770343"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8770343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 21:54:55 -0700
X-CSE-ConnectionGUID: DaqvsVHcS+6+/j9AnKlZwQ==
X-CSE-MsgGUID: HFSJo0jtSr+rTO79DAmdpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="59585581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 21:54:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:54:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:54:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 21:54:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=of1Z5CHbLSL+tODgwnnLPZwhaWt7DTPHNwUzpV+8nCjNQiuYK7BadXPvu1iinEzMdWCd6Z5wk9owaGcJ6iH+uWCnXQ6DqJ/tyvsQjIEIlQRZwFdHEh44ukUsig6dL03P/STUChD83mSCjdn10n1mbrRQVVe9S0X6I/Ipe9CtmcidaqfrhXJYupgx0E3GlAxOfHLaGEugk2qIgSDi8pejy4023u+HCRh24QlhO0tNqe1dasn3G0w2/na++8URO8wg5XqwOHibM6nHyZk0mCnv1kMXe3jtRdEQwv76qFQtItURz1SWAA+rHUydcyFa+6OQdxNWjlkKp+9aOzEtg+hHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5klNPA8BU9PwtfUNxjByF+KaIvJnCHlkr6Njz0E0Zg=;
 b=Kydi6WnsFzqSdml4XJhwxT40s9sQd9KYuqB1JRIznVI5w89IR0L/BNdSguNRK081HB7/tfCFrZ3o6P8ePPpcB9Ys85QrmCopGEisJTNXVWGLSaii092y+cNYMjuy+eSVH2MG7Er3YG++5Oc2NhqOaAx3B+8cbCsKBBdPwiFRjtmA/g7DroMlWqbMqdbFTQq2CMYQaKH08zAEfovDoond8F6rFRHhzTy3+VpdJFcIRxjaA8mJfoo0ke6A10rfwNeRtQq6v58aSZcTLdWwfnyZLPLv3HoiJgWpIde+FljHmBSmgpuJS2r3PoAApF0nTavIgSCSBxEL4nais7cbiFeRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 04:54:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 04:54:52 +0000
Date: Mon, 15 Apr 2024 21:54:46 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 09/14] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Message-ID: <661e04966c622_4d5612946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <9615e6055e5b262a22bf312608647223517595b5.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9615e6055e5b262a22bf312608647223517595b5.1711405593.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: BN9PR03CA0954.namprd03.prod.outlook.com
 (2603:10b6:408:108::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 03de31bb-75b1-451a-ecb2-08dc5dd15a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZoUd5nQGtRuTXA+BQioWVxlCnwY+/MUN3DtNMP+KVb5oY67wtIdKq628M0r6NSA43kv2LKTN/kXTomxghC15R9KzDhKcu74juaEopdTd18mVprFOUUvBUdSXeGP9akC9hB0DYQy2CBAG++4s0ytBKOkFHN4uqME1LbBfu8XAF3/fqo7/OnpJS3L677kf+58mk7c/o4j3/os5fo/AStEHV5MduUhZu+d7Mfz02rEhh7Y9+upuVZp4Rfp+rhWEDIUBb92qTzx2TDxGcwLxTCnTx5gVp6RwJdfwXU0Mg/6EkQ50VVHpmZj1k+vaGIpbvvUzNG+T6782sRk+gwLxk5K8O9df+ui4Z18RdqR2pR3donieqlRQXFmZdVm2jxlwlW9nWH5xUZ2mC+GRy+A/2T7xiWufQbQd+MC7hswbUv8qPtn15ywOfrXjjMWK11I5lehD/2ytofGvVvS58gMZPO//LRLgELsc4byhypKrqOMLEGUmnk7rw7TUidhDYQcpRVOVWTCHFPSPEGOgpzilobz/mqpEgZmzzYbGIR6i8UfVk4KiKVHZr0vat+7xgV6zW6KHHyiVgHuYVu1ueNRBn1TJtGtG0Tx2s/Y95Hdqww5nfmxlWdx4dqqbeKPZBwGGcWd0wZSnkQ3dogkn9J+3e2MdLBoezjiU9mg0JlDqa9SMwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hp/T/nXenlGnKuaNqBaCsKPlr8vYxH8hlDZZVzXkIjVEObIA6H+8yVf1O4Sq?=
 =?us-ascii?Q?HWwFRYiJ7yfIygnWJE3iQEidxOJXFhhyzpgZLlTcbvHJ3KWAwr3qDH01HWqE?=
 =?us-ascii?Q?S5vCujQpZdlcnJlxLEvZBwH0ZfPCPEUdtHcGt53xydG4S4aOv6nEBPIBfu/1?=
 =?us-ascii?Q?EY7h09NYxSLM9jKi27PI4TnbOE6k5p5lf/TiXvkSqq7vIQmHLfB6ks+ynAIg?=
 =?us-ascii?Q?XorkX+k7DtpGWGr4mrpAZpt81RkYNIUG/vEI2pWsKbf/BN7NG1a8Qf56pGC4?=
 =?us-ascii?Q?y1Q1yf4kvOl/K7rueNeBSbumION8LII4mvkXP7A3UtkwDBsPQs0JS7HhOiWG?=
 =?us-ascii?Q?oAHsCAHK5M1iUgRB9uSmW8GjOcemTOU2GVVZQqrIXI93Qi3/R4soTsQYXTfK?=
 =?us-ascii?Q?Yl8doTCgV03W2QByxf/d74xSzHKO7jXmuhsQcvFPp95ln+ET16oXwaeFz9Nm?=
 =?us-ascii?Q?w2pwI1Q1u2DQDgD1U0pjDlXh/6PUkRUuLqKCM0KkM1QdC+JeHs2xi0FvmZZm?=
 =?us-ascii?Q?2HAKznYOTuYcI7QTScL0CPPgtZBw4J3GrBz9TxtUj/t1xOfJtwR8QgCu0n9K?=
 =?us-ascii?Q?IF1lzWjtBgw7GzwrF70GGOCYHUD1S2gUbae8Ojfg7XdQCqFs4CbfKqWTb8zI?=
 =?us-ascii?Q?jc44vqsRkEAjk8M5tl5FG9uwchQa31G+BqhvRgXLqAYN6BVyycpoynVYyMU3?=
 =?us-ascii?Q?iqBI8LjhTw7g7dI/ytXopKOY2Inv5zqScMITpHeAGmmYe0FSR2nhonJEzzYz?=
 =?us-ascii?Q?B1znFXclkJn+ViK8X2TCQpIsI1Mt+NrbUjt1fCI5YZbfu5GAJ7HUebgI7IgX?=
 =?us-ascii?Q?E0TtE1IOD1RR5F110PiaJaj1MkNkMgyoinrGoB88nId133yUdPk05biSRwH4?=
 =?us-ascii?Q?B00FR+kh0hVEEKny4zMYwhJZJsVzW5EzvUqY0neOWIvRBcCUDbQeDJ5IRObP?=
 =?us-ascii?Q?khnoaYCXU779e3SVFQLjDavE0Ll2gIrgHBF6DzifurJVYyoLPDOfBoS+RNi3?=
 =?us-ascii?Q?whke5T2Q6jzTFasUXJUEks/MwR/C2wNqqW2LaPh65oyFCqGQul7P2fuTgclp?=
 =?us-ascii?Q?5XPX0G88+RknUM6rbF/8ZCksQOIP2XofY8Ws3vE9aduN1EwAiVKXFbXxjXOb?=
 =?us-ascii?Q?pmSjRQQBQDVmloSyFWDxl0cZHNapkQFKmYRrPgmwQeFb0QaFruKOFLptuKtG?=
 =?us-ascii?Q?5sapWorLVwr5f7y4Xr14i8ZZO806ouo6HrmQ+MfvCpRStwwaXbVq+0BfP7Rw?=
 =?us-ascii?Q?TH8HU3yhcQYLLZGgfw/aojMFl9iHaraTvI7Np1HuDz8d3ShRoY66o9pDmf15?=
 =?us-ascii?Q?vcFt8MXsk9HUfYHtL7dn9gVbD10oYJNGYa/xpkxNh+BD3d3LjTRukthDdOlq?=
 =?us-ascii?Q?g12B7Ps49SwFjUz2028UFZJiOiJvX6UkGc4tOSDMP3qbz8tlNZnqbAGK5h5U?=
 =?us-ascii?Q?V14R6To1b8XXKKyn8/i6ePbZNZzpJYzLewvtVkvuJ+B3rMxNJ4f0ddDZQXLG?=
 =?us-ascii?Q?foAnnwFj0pq7cdRhPMq/J2yyYVBZnmLFJX+PxQsj/rFha9uFCm0nT9H9vIgo?=
 =?us-ascii?Q?suYe+6/QrrB9Xrn2WwiypoW2fJt8A8G6ckDLLiXkmxgMjXqIxQbRE90lB06Z?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03de31bb-75b1-451a-ecb2-08dc5dd15a24
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:54:52.2952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vF+DiAQnzrm+iFWAwg5AcswMyQciPteYysM6Hc9PqTX2O4ARyotWuk3YYT9Xe9/fphz5nV2io2G9UzLKLu/MU9EZdKhSJ45ayBGQbfVOcC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com

Hey, Tom, came looking to review the tsm_report changes and noticed
this...

Tom Lendacky wrote:
> Currently, the sev-guest driver uses the vmpck-0 key by default. When an
> SVSM is present the kernel is running at a VMPL other than 0 and the
> vmpck-0 key is no longer available. So choose the vmpck key based on the
> active VMPL level.

The module parameter is not mentioned in the changelog. Is it not
sufficient to always use snp_get_vmpl(), and if not should there be some
documentation about when to specify vmpck_id?

Do users know that "vmpl" and "vmpck_id" are interchangeable?

