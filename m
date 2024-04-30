Return-Path: <linux-kernel+bounces-164487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813C8B7E20
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54D11F24A90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA347172BC6;
	Tue, 30 Apr 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1RwCkVk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B417BB1B;
	Tue, 30 Apr 2024 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496748; cv=fail; b=eIB4nxQcoAlqMzrWLNUEvvo9KDs0u7eoDRz8rlu1QWDzDCVewN9J26ZtxrCxoOVKX5I02RgF/8D3wds/fj6HDZ2ybiUkGNdW6wsJ1i4Up9E1QfuaPZEyn7DDUOTnL1ADGjb8qAlU/L+ts97BfjriE8f5e1+BKntZQFY3btpjU8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496748; c=relaxed/simple;
	bh=3e13BgfU3kucjRwe5I/P2R8WbRtISrxNAN0ZL7T4pHQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uLqupLubONuLyqWRmba/ZAbuQffiGucnMoAO6q7rNXljLQFYi/oltBUDW+lWPmnhnYUf1Dk4yD/A16Z64RIik1ZG+sREqRdEJCwjhySYHuee1UIFnTz88fkiUGInWmicHljL3vHNZ9N5x0+HkXtRbXcVmKAkm09h8UltPLNx5oU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1RwCkVk; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714496747; x=1746032747;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3e13BgfU3kucjRwe5I/P2R8WbRtISrxNAN0ZL7T4pHQ=;
  b=j1RwCkVkhy7SDAx+/bWmC1rNkzBCJ5ttbk5Dto+MZcoS4WaY0ZgOZ1C8
   DiQOU4UAZNoe+UctSC9ickadsWDQSinmvVQ+1eCpdt6nc0hg8ogM9u6Xf
   twTgbVaU1XA7zSQO2kv4QIZLKOMHq1IQ3Aot95Cq/sWazTuT1QjT2adNO
   idEQluDfJ4qV822ZCygXh2Z827yYhlR3DrOoNd5xSRq5Ti33DkO3iMR7z
   tz8ORQMLMsEjmnEpqSdH3pX3pSuoeYv1QnkZHZOuSRR7nF2ZYGtVE2hnY
   VON75iWdqYAPJqsH5w3bgB3LmohG7vJ7XSZxel7z5hrxzfD0D6pAAvdtD
   g==;
X-CSE-ConnectionGUID: 7m3ZZzznSHy4ffUsVpFQ3Q==
X-CSE-MsgGUID: koDTxl6NQEatq1DpOgeJaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21367282"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="21367282"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:05:45 -0700
X-CSE-ConnectionGUID: FK0kbH0/RKWbUYGyoYs2Wg==
X-CSE-MsgGUID: z2JHT3GQSeKvRNjCbe1hXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57705703"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 10:05:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 10:05:44 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 10:05:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 10:05:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 10:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8BDTh3yt3ZzlPF45P1dManPyWpGKd3JT54uJ7fmoPltEhNfNqaHCPX3f0bQZSAFSnyiooH+epfNkrW2qdOO9qHAqC/6y9SPHNpQwgBvAq63OGVb4tE46z6c9xAvQHKLPsrLMkev/p0etz7IJhj61vjWw557HY0izeDVh30Tx4brDJWbr9k32TdmpSS94lSbqMG/twpGnI2u+pdbvvuUIBow39q2N+Nl2mY0jDqhH73nl0u8a/yYxovEHuuGryltQgGpOWxYCa6PDkpkdKkCgXrXyis7Y6PUiz1FLfigr6uC2bBoxQIgOEzR6q9MnPwJzOeoXhlbpZW/r1XHzUjuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3e13BgfU3kucjRwe5I/P2R8WbRtISrxNAN0ZL7T4pHQ=;
 b=QiMSMxCdAwUoBTxhbuhQKTDxyQ9ZRXyxB7ZfJcc77Q0P7eSRpaFyJm7munRQA7t3r1084Af6C/BLdnA9loIIA1YyzQtivDePZpvXNjycJTBBC2XYkelBWpKPRnhuAabalFd65yIs7VId8OuSkKwQXkHlREPsVZsh78pqm55cvVixrWYrBSqRg2eYFjUfj7v3w68pwHa9/VFVqWtGibsFRQhqVTHcS1nPNcnjPLTAOmdjPaODk2ijlNYplxB/e27io67xCO4ZFU8NHlJlj4aipRNvxSr9OGDb8uwloq2V4MxqDyGeokhoTSUk10ulhEsnnqReHq1N9gUq8RW92ok6Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 17:05:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 17:05:42 +0000
Date: Tue, 30 Apr 2024 10:05:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, <x86@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Robert Richter
	<rrichter@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: Re: [PATCH v6 5/7] ACPI/NUMA: Return memblk modification state from
 numa_fill_memblks()
Message-ID: <663124e36ecc5_10c21294b6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240430092200.2335887-1-rrichter@amd.com>
 <20240430092200.2335887-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430092200.2335887-6-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0333.namprd04.prod.outlook.com
 (2603:10b6:303:8a::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d0cdc8-2441-41af-a107-08dc6937c483
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lzaVV3li58nzWcVj43pJF1OmWMIwUiWkXxfEVX+smPSzTTP4qLBsbTn6/Sjm?=
 =?us-ascii?Q?2mS2PoMyNwEC+08Dm2xCFqZ0A1v9+G0zeaqw9rRPHAKrfVoE5GqQt7AH1kBj?=
 =?us-ascii?Q?gTbpXVwYHQZemdT6ItR/gtMSq6BMoARe8wXzOdnAdEtf3vyLtKk5fMkJZTJq?=
 =?us-ascii?Q?rs9SlTJlb1XGHIQ75GtDAObHnSRb3JvfdC27FrHThK0/0WPG3ywJos9vR0KP?=
 =?us-ascii?Q?Ck9rs8A/nJ8N46XN/a/vWGYNk5XURVUwEGEjEFaNP3DhLj4MoNkqe8bn9rbt?=
 =?us-ascii?Q?paSEUzeSN5XvOAHjV14WLywdSQ1IOoVaVw7dZyREHqARw8QKLAQEW0o2uelJ?=
 =?us-ascii?Q?HQHqM3mUdjv6uj0z5iE0wIVMbx1s078Jfhdn3HVfjatES87P5gP43HdAUuV1?=
 =?us-ascii?Q?DB6dbwOP1e5avIXIctoeSXVjsH91BUGSlg21pyN3TUi6mj+0gv6wxXuzhEVM?=
 =?us-ascii?Q?7iZk0W4tU7Q3cJkyZ8ZK3cWyVv7lI9VfDG1HVho5ZlYZbVMuX6JFbyp5THbK?=
 =?us-ascii?Q?dnllYPCXCxMHRgbP15RxlCNVwUg01kLzFxtxe1QEtgpuPVH4yBjCTgosQJe3?=
 =?us-ascii?Q?DuysaufdbzPEsyAtC3q5HUJcvMpn9ORYdR1hVz77HUNdQkAiFzZj4LAL809V?=
 =?us-ascii?Q?wVg4d6QlYJM4DjWG+r+Yc8+CVQWPz0WflocDW5/zgdXJRgPQAieCbJuNya11?=
 =?us-ascii?Q?OAFJBqvql11bhRV1Beg0ol28yrnjfq+tL5mN00RhxFz6bbZ4kTx2PlbBNS5q?=
 =?us-ascii?Q?N6oKmJdP3y9IpUCSILSLcsdgNjpX/UhDmOyARu6qjyh1vHe17HACtEwpBCSn?=
 =?us-ascii?Q?BwrSTaV2EinI5cI0U7klOVaZTMeq8Hx7f4XufVewH6rMj3uWor8IrH7hrqYZ?=
 =?us-ascii?Q?8RxD58isRACGLRvPahu0GBFg7f+FMtEoydbxNRfxWtIIOzYd3lqf3g5zbh5o?=
 =?us-ascii?Q?nN5VMjHCap4M4iHwPIDSW/XjsAtcWrparzqzunQMxZCFsPSt6PqDbAlQVtxG?=
 =?us-ascii?Q?UXiCk0eXO5KdAbI1Aoh2FhvNxnz9bk/AVL0BNBvFm1sWxYjGvZ5bOBXuGHK7?=
 =?us-ascii?Q?b1Mtj+3qQlpiTwpmvKtNUuRcf0f9yWJkJ//9YweA+Vm5cKMZtVDLK9TsaI4s?=
 =?us-ascii?Q?vA68OmiTdvPWhVgd9fWYMpJwkO1+fOx74SO6fc0odPHvrecqfnen1fsi0spf?=
 =?us-ascii?Q?dfFjwcyc9+NjIwlg4tB6umvQFm3zzmfg+yOjCqJBinAEo+qDTE0Xm/Gg+c2F?=
 =?us-ascii?Q?4X+nBSb+aZnF0e8MCiheFvjq8t28fen6FPfgRaroAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GA4i0OHxJK+KHgQfRG4QdjZVxnfcnszD9fki04DhodRlOfCZcI5hOIUwJS//?=
 =?us-ascii?Q?GjbV37pFEso6HtmFf6HuRzH43OZCtH8a82m2M03C2X5iC7lAb35NGFip6O8a?=
 =?us-ascii?Q?RuqBNZftugSwMdq3B0omnXR5x1RLC0C78AUSQQg/W3tv0OvOZaM9p0Gqre71?=
 =?us-ascii?Q?88IufxTB1s+3ASlC7+yLE2gE3Irc5veFuWHWcD/mI0jZ9p3NPWdUE7WwuFgJ?=
 =?us-ascii?Q?LoJ3S27DIEzgXeaFZlEwYstBvpRWicZBQqxHaX05cyRf6aCdUiPeBHHCiXz7?=
 =?us-ascii?Q?ImAqVj1fy4zYlGgf/ibJ5knJImVbYMKPqA2eQ4uJ8mNvzIG5X+38v/xqsiVb?=
 =?us-ascii?Q?s14KtTtfWoLyDn/29CNVlPDnq1gSrcPXJ6vHhoLcSpX/XJZIarzKDp6mN9u9?=
 =?us-ascii?Q?hF5Yqm8iM4T4GC4T+d2YSSGKbb5Yri4FF7LORApxsM1MygXTopalWFaqfBIu?=
 =?us-ascii?Q?yxbp5IFR26+qscnZ7QNQpEqE/DzUio8RKKO8KU4RnE60sbiDC22WG5i8DBGS?=
 =?us-ascii?Q?RlwjUmeZkwPkwXKjxDniY8LKo1+Liej/dNNxjS7gNJx/CpC73lksKDMkGEOc?=
 =?us-ascii?Q?Z9qP2vfDHWxF+3f0IL3wyqjBXiKT5nSEeZwuxcZhaXqjGnP+K0KarMEEqQJh?=
 =?us-ascii?Q?XkhPHgFZ9P9S8Bnbzgw2slaTL8zzmcLkm7rPm+baVzcLTGOV8d89GH2v8+lr?=
 =?us-ascii?Q?xJR0laB3AXR5LzbrHEjo3+K9RMuKpJmaiU1jgFAdiyIyDbCJ3in9Bgk5GLcS?=
 =?us-ascii?Q?rp7jx8AGM/88mHucCUsqAUnjMMKIt6s8Tjlk8RcoWp3haab+WSpKCgzbTelz?=
 =?us-ascii?Q?Idt6gRWEr2F572r/V/JxM1OAO/T1dODbaRW42w0Xd2KUkbSfg9w43PMe3alK?=
 =?us-ascii?Q?ztqDn66/mED50gJJKQj/KiIOCQniyXPYiXJSKGtD7Z66Fzxn7anRcFUX7o2E?=
 =?us-ascii?Q?Iq0ya+XXZRvcuOEe2mL+uhpfmO9c4VJLGIUoIDMdK7E9VgGf1qSnXZJmJ1Y7?=
 =?us-ascii?Q?RhEgccXJgXbQDZsOM3E5VIDityiwjeG+2RyF2udqcLmSmjF4xD8OFP5bdfls?=
 =?us-ascii?Q?dfzlQmKtFzSQ62x9kcrd7jq6zGJU7rspXQjIMOqYhPY6IweWx7b9Gz/kvvn2?=
 =?us-ascii?Q?5YAimoL2ozrY41bcHjRxsGLxW2aT18SU1uoAn+40Sryyyh+4a7lDNChy5qQQ?=
 =?us-ascii?Q?7/gU25UGQcqvcrl9Wb/L1Zr2ABxPkmM4s874KpKlwqWHxai0qCbuCww5brux?=
 =?us-ascii?Q?r3iY9Xi1aN6J6LoKnZBtApdOyV7TXIbG8wwZtAYGtJ8AeWY7ZQbGOF84ndfm?=
 =?us-ascii?Q?GV1ztwPLv++k1d8SrVRXICkEit2wDyEYHUWde5p8dtZvUwHPCv8N6jSmprvK?=
 =?us-ascii?Q?l7NlSQKmYuNPxXDzELphOzrscXT8dm5jcbz23YLRzG/Q860cWSI88dEfcEpE?=
 =?us-ascii?Q?8g20SO3ODTtmjIwPEhDlQlDlat9+9Vqpax+nvcRXDODptQekxVDiHPg9qcO9?=
 =?us-ascii?Q?tCORAymwVrOmA2UIgsTDsnJ/uNmrUOWNVGv+MpkRMJyIdWsZ2lWZcVCu38XH?=
 =?us-ascii?Q?sf8F+CrUVlIrY2Ku40EeLSaKTriL7AHKTjTFeeoD9mqPdJ3hEL9vMWQErooH?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d0cdc8-2441-41af-a107-08dc6937c483
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 17:05:42.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIuGoBfoggDEVLt/SNdKu6ZUlANSQVOIWiiBnF5uHKUNGPafCyc76ZnWsdvTLD84pmDwN2cdjZ92eXdFzqqEF1LPcVWsL4aVQ/eDbIkAe4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com

Robert Richter wrote:
> When registering a memory range a possibly overlapping memory block
> will be extended instead of creating a new one. If both ranges exactly
> overlap, the blocks remain unchanged and are just reused. The
> information if a memblock was extended is useful for diagnostics.

What diagnostic flow is this useful for?

I feel like this post-hoc debug prints for problems we never expect to
have again, or is there an enduring need for this?

