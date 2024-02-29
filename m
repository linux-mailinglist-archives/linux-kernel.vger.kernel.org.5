Return-Path: <linux-kernel+bounces-87383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232786D3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BAF1C21F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325613F421;
	Thu, 29 Feb 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIvW/O6/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52227D08C;
	Thu, 29 Feb 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236308; cv=fail; b=Cuj5ZMwekn+YUYx+fAMMOmWNb2cv3xPfuIKCXAQ3mU+uIQhSA+aBYluKBIjuT1MmCnEHqhf0gpamt660KRgzitw8yXzzHrnyV3xRBpW1cx8J5CsICoMvzG+Boymo1igFgb4K8qM223tFd5fhxPOB/6jDPh/Uaf/LrenC45kXXd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236308; c=relaxed/simple;
	bh=LPKIOzpughh1RCjXQCgbiUGQDmzL6ZHaVVu6o4PZZMk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BEjTkJNvkRNPs878yC9qmVnCMj3XPttOJbGIhpLsZG/CjJZP4M9ktQoRprN87uKR9tDa1gAlR2kG4wnJ6nSl7KSAZHziu1qvyO4ubjZYkY/1fcOyZxiBTbujDMnhZFCP2h+UYOUHsf2vfB2XZCpCdWqnYisMvG9Yl+X4iTrVfD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIvW/O6/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709236306; x=1740772306;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LPKIOzpughh1RCjXQCgbiUGQDmzL6ZHaVVu6o4PZZMk=;
  b=DIvW/O6/UwirftLGV9HSQ0DdR6RhlyI+uodgVAzZYo26tdFYRgrSF5dr
   h3hk8weTL35sWupLH7MmF3HKLn0pvX482trlYGLl4GVdkdDmE+w/U4KFy
   EXqkyM++N/fhOS6F9qfGgBNt6S5B8N+ILOBJlEWYDStBech4nSlANoQ6w
   p4JYdWJqL+JQ1Xj7hIUjS3CeDr2D+HC9jLeTI2I4N3RIp3zCf4juJVEun
   BRc8xzFZySAYkG0ncnsfrpmGHgWjr8LEXS3GATA+Q/7ciZpVpwU697msb
   3C3bfLBjhmj8XYgr6pdZIqs3ZLtmjVvhuJTeJA9/GJzrBcLgHQrQFpAzr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3854908"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3854908"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 11:51:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38782743"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 11:51:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 11:51:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 11:51:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 11:51:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:51:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl+mTx+SKJzW/erkPj0ELXhsAxnvjUeXP8EQpJVOkLwLyS7BasLXTNTzrvoepM0qhzGI4Z7z96lU7BVKImrJM+Bog8NuKxp36eESnO6c/ubE61/ZL/D+opUNXkpajuigPJ8ijhxnhO42T5aDBH1wfVApqBxw/RWL+HdGjp+KH6aSeimvTW59+PTo2xscooXDScJnUDqhbuciw0z+APKe9XXbdFrf0qGy762yPir3VcjI8Gl20LG72pqHLlQhhuyBxxTXJRgdU+HER3trb4qunYziKknLdmCmmAtRohyK08EseIE5hRDYlPnP8xahwt3Ha2UybT/5I0vrIBYvoy/iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDRAO8VMedyTCanryft3s7cVntI76hrglBnHFR7mRBA=;
 b=IWtj7zGmsn/ZhdehYIuSPUFIhhfHN3JJFulnhLESqNSvKnBCq61L4lxEEuDJIw8EfKb7hYXggb/bZnATkZppAPYJ1wgfGdcQ1RmqdXyGW1NT14cIKCSMX+pyylhTjrsvUxC4SosSmXzep/ZV6WZa/+kv8LKKoohxusWo7f6PmsXyUr/VfTpz7JWMdmpvevxH7S34VmuHwWqbFqbygibS0J3pz3wJoyNiz7bvt4b5G7PuctZvN06hiGEhJ4HmaRReii6MH+wFJ4TT3fKeyohKI077mXD0EZbHq/qu9v3CUld9GxnDqnuYHv9hxNbs9+k7LlncPFcjvcFFK0bm5/LczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8543.namprd11.prod.outlook.com (2603:10b6:806:3ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 19:51:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 19:51:39 +0000
Date: Thu, 29 Feb 2024 11:51:34 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Shiju Jose <shiju.jose@huawei.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <65e0e046a165e_ca001294bc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
 <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
 <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240226102944.000070a3@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240226102944.000070a3@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3eb87d-38a5-4e9a-eacc-08dc395fd80c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/9K+IEdbEcqDZg8pM+3B6yKp5+Agsg9KQ2MlP3Pxjfpe01J8YXmGe44oOtX4hH3nkvHPhdKRsu1A8T7X8OXG5WtK1HfXhw/rAZXxqRx8ZB6onHgSwYj90V4O4BEP8X3qHuPa5cK+SGRXcsvYrsY8vrOShhocgsSUFdVTs1K0MqVp8Y2M/3a0opawsd6Ui0fmtfnWT7/z60ZDGUwGgTWcEOGYZwhblNVADRaodrBPobJbS2H0lIqgMwEE/xG363P9vVmAncVo474K+PRivjvwRpW9hGqDgYcqc6F+j89L1FERNglqfgSqxwIMniBoF653dMd80lKN8F+WEewhU27he+iH5UgQLjU/R36xue0XB+lBBZFk92qgnogbjL8NF0pMF5bGoDaaCAYnMARnhaASosW6rG450x0YjsvUQnds+GH2rsyXzHpLbVz5n5lRBjW0UOpU4BmF8F+s2jngS2L6zTScusChkrH+OPRVps5m7+7U8oBXRLjG1sJZrogcRgjvpYRl1cb5zn5lX3YLuy7JByFPSEan1IZvOOVM8WBRU6oXPd9gCBut85E7CHW+pfG8PIq4wR/ah5p3AhzcIaHTdt3sgzPaxxjyKuGYDTnkps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yBptXpexZ2iH+Ll4OcpcPjRzvAbxfEeW8UffYlXYiTUL5U4Z+JBm7xClrMV+?=
 =?us-ascii?Q?0pkZYQsqeZj6u4Sx9lshdYAVVWMUYlKoSS+o+SkqozN3FA83tbfpIcavAQN/?=
 =?us-ascii?Q?ez8SqAibm1mCyNo5f80kf0+rSmHs/txj3Gtk56YISKo8yVBdXD8nt+S4m7jQ?=
 =?us-ascii?Q?Bv/wSgl0PoBBlz77CV/9ol34hegZ5syiYmASAzSERxyhjYVHJRSk7rvP5xKr?=
 =?us-ascii?Q?gg4TyAtw2lyCE6aEOe3HReazB+nA3SERmMnyiHQv/IIDLXAYxkQDoMaABvxq?=
 =?us-ascii?Q?lZy+JyVf3WtbrBrulPCG+9Dvm52nmXL1XMBs7HFRl6eLaFXIsMk74OeoshNz?=
 =?us-ascii?Q?eqg0/0UVUMKyhqoLOHGuvmhYEO9PwhpomOtR7/yvYFyTNZpg/kCeqoq6UZ3t?=
 =?us-ascii?Q?lxqbmITK4AGEV3MwNabYkU7PJCYSu/B6gKo9/2bxQimTRzRrLGCq+HIP7KPs?=
 =?us-ascii?Q?tE0FvpakzhJtcH8yQtDQUXCGW7TD/VwBXFWgeV3mHoyZ2qpFClC1JFz2DQLZ?=
 =?us-ascii?Q?B5Xa6BMIKboWhVzMLvX0ssKxIeFmUy4712worbQDjbrILgvlTm69GuaXqL/w?=
 =?us-ascii?Q?PdckgyflqyggddsrLcjQtQHwXI2jLOaWTTj/aYmpM7+5kNaaKuuWsYx5U09k?=
 =?us-ascii?Q?CcJeA4m6Y0tFdMcWd0Io7DsLEN2bywSUEq/yGJ0e4Tzo3SxgOLLuwYWWEz6e?=
 =?us-ascii?Q?nyL8mX0K8dCsTPywLXLDN/5ngBiLGRl67NqX/Xatad5+BZGb1MgBNI02ZhZI?=
 =?us-ascii?Q?x/xDRqe13KyjimEPs0EKjlo9Q1J+rHNYJBy1OKWoOb1FA6/SCiFFoBD+SDfH?=
 =?us-ascii?Q?9jJQlqq4h/qNUB85jNJsjF0bYNSNVlm/53PjDGM0R689lQxGSl+sBGZCAw3n?=
 =?us-ascii?Q?YreN4s6JhuBAjnqpvYMuC63GJ8jQ8I+VhltJbwNI1cOe1/a+JKkC4Sm57eYn?=
 =?us-ascii?Q?qY7osQR/TAZZ2T6rLn9yNAnYXo5g8MFzNrQc+9cJwB7MFRkjKyOCjH3yPeCE?=
 =?us-ascii?Q?DMqQiFtAtIvxi05dVYgYngPh0RijLO3r8qrYUxcHee0X38uar4hJ9QYutS7A?=
 =?us-ascii?Q?jl1uNLappDlzOrA2dppN4CsA1SejZZm+hr+MueBYv7+tZ4ZNdJplO5Tqa6Vm?=
 =?us-ascii?Q?nykW4XjNzzjb4NN4HluFewr+VWKxPjXBXIbRNqKNyWoPFUCcghFW9M0xoy5B?=
 =?us-ascii?Q?sYJ49sgMVvVcI1WtH02xCBbfSfkb62v/SYrR4EoCIGcjoibuTqD4NAfHu/A3?=
 =?us-ascii?Q?MIzLC+xZ1go8x05ksDjwSoxibkr+X8Q928zquXnfk4fExVrfhCIPxX2uKPkh?=
 =?us-ascii?Q?Snq1vNfmpCZ6Df3Y26LoQupK0+K/HAIHY0Z/vOIWLwahU6xjJ4whN/QrBcPE?=
 =?us-ascii?Q?eu3hpZmlBqVgVCm7ZEfHJlS2jIdkvxcHaJyOt5RXC1DzdtJaa8jhYUsCADos?=
 =?us-ascii?Q?63NgYeoBP9WWlaKXcCqNBZBp3Wo2pu4rtPH6Dpr9QxzTigT8vsTmO7S+syRQ?=
 =?us-ascii?Q?Qji0KZUNxrxe7K1lr3OFVoHtUf5ItPvyPw7nBpLpm90uYWtaycp+zJIfwaMk?=
 =?us-ascii?Q?By1I5+MZGrxHek6NvWkLtY6AwBkL+Tn8pyu/K95ZKU1+IgRh6PiXg0s+cCQ4?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3eb87d-38a5-4e9a-eacc-08dc395fd80c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 19:51:39.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFPuaxyGffnt0O9PGuQUTdCsie3d3JwYw+o/TG/wvbRdq0+CUfI9KH69C9YK+fyXq/FBaRAD0ZLka+e9x+11DKdQma3GGJUtsT3nw315q9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8543
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:

Thanks for taking the time Jonathan, this really helps.

[..]
> We can do analysis of whether the interfaces are suitable etc but
> have no access to test hardware or emulation. I guess I can hack something
> together easily enough. Today ndctl has some support. Interestingly the model
> is different from typical volatile scrubbing as it's all on demand - that
> could be easily wrapped up in a software scrub scheduler though, but we'd need
> input from you and other Intel people on how this is actually used. 
> 
> The use model is a lot less obvious than autonomous scrubbers - I assume because
> the persistence means you need to do this rarely if at all (though ARS does
> support scrubbing volatile memory on nvdimms)
> 
> So initial conclusion is it would need a few more controls or it needs
> some software handling of scan scheduling to map it to the interface type
> that is common to CXL and RAS2 scrub controls.
> 
> Intent of the comment was to keep scope somewhat confined, and to 
> invite others to get involved, not to rule out doing some light weight
> analysis of whether this feature would work for another potential user
> which we weren't even aware of until you mentioned it (thanks!).

Ok, Fair enough.

> > > Regarding RASF patrol scrub no one cared about it as it's useless and
> > > any new implementation should be RAS2.  
> > 
> > The assertion that "RASF patrol scrub no one cared about it as it's
> > useless and any new implementation should be RAS2" needs evidence.
> > 
> > For example, what platforms are going to ship with RAS2 support, what
> > are the implications of Linux not having RAS2 scrub support in a month,
> > or in year? There are parts of the ACPI spec that have never been
> > implemented what is the evidence that RAS2 is not going to suffer the
> > same fate as RASF? 
> 
> From discussions with various firmware folk we have a chicken and egg
> situation on RAS2. They will stick to their custom solutions unless there is
> plausible support in Linux for it - so right now it's a question mark
> on roadmaps. Trying to get rid of that question mark is why Shiju and I
> started looking at this in the first place. To get rid of that question
> mark we don't necessarily need to have it upstream, but we do need
> to be able to make the argument that there will be a solution ready
> soon after they release the BIOS image.  (Some distros will take years
> to catch up though).
> 
> If anyone else an speak up on this point please do. Discussions and
> feedback communicated to Shiju and I off list aren't going to
> convince people :(
> Negatives perhaps easier to give than positives given this is seen as
> a potential feature for future platforms so may be confidential.

So one of the observations from efforts like RAS API [1] is that CXL is
definining mechanisms that others are using for non-CXL use cases. I.e.
a CXL-like mailbox that supports events is a generic transport that can
be used for many RAS scenarios not just CXL endpoints. It supplants
building new ACPI interfaces for these things because the expectation is
that an OS just repurposes its CXL Type-3 infrastructure to also drive
event collection for RAS API compliant devices in the topology.

[1]: https://www.opencompute.org/w/index.php?title=RAS_API_Workstream

So when considering whether Linux should build support for ACPI RASF,
ACPI RAS2, and / or Open Compute RAS API it is worthwile to ask if one
of those can supplant the others.

Speaking only for myself with my Linux kernel maintainer hat on, I am
much more attracted to proposals like RAS API where native drivers can
be deployed vs ACPI which brings ACPI static definition baggage and a
3rd component to manage. RAS API is kernel driver + device-firmware
while I assume ACPI RAS* is kernel ACPI driver + BIOS firmware +
device-firmware.

In other words, this patch proposal enables both CXL memscrub and ACPI
RAS2 memscrub. It asserts that nobody cares about ACPI RASF memscrub,
and your clarification asserts that RAS2 is basically dead until Linux
adopts it. So then the question becomes why should Linux breath air into
the ACPI RAS2 memscrub proposal when initiatives like RAS API exist?

The RAS API example seems to indicate that one way to get scrub support
for non-CXL memory controllers would be to reuse CXL memscrub
infrastructure. In a world where there is kernel mechanism to understand
CXL-like scrub mechanisms, why not nudge the industry in that direction
instead of continuing to build new and different ACPI mechanisms?

> > There are parts of the CXL specification that have
> > never been implemented in mass market products.
> 
> Obviously can't talk about who was involved in this feature
> in it's definition, but I have strong confidence it will get implemented
> for reasons I can point at on a public list. 
> a) There will be scrubbing on devices.
> b) It will need control (evidence for this is the BIOS controls mentioned below
>    for equivalent main memory).
> c) Hotplug means that control must be done by OS driver (or via very fiddly
>    pre hotplug hacks that I think we can all agree should not be necessary
>    and aren't even an option on all platforms)
> d) No one likes custom solutions.
> This isn't a fancy feature with a high level of complexity which helps.

That does help, it would help even more if the maintenance burden of CXL
scrub precludes needing to carry the burden of other implementations.

[..]
> > 
> > > Previous discussions in the community about RASF and scrub could be find here.
> > > https://lore.kernel.org/lkml/20230915172818.761-1-shiju.jose@huawei.com/#r
> > > and some old ones,
> > > https://patchwork.kernel.org/project/linux-arm-kernel/patch/CS1PR84MB0038718F49DBC0FF03919E1184390@CS1PR84MB0038.NAMPRD84.PROD.OUTLOOK.COM/
> > >   
> > 
> > Do not make people hunt for old discussions, if there are useful points
> > in that discussion that make the case for the patch set include those in
> > the next submission, don't make people hunt for the latest state of the
> > story.
> 
> Sure, more of an essay needed along with links given we are talking
> about the views of others.
> 
> Quick summary from a reread of the linked threads.
> AMD not implemented RASF/RAS2 yet - looking at it last year, but worried
> about inflexibility of RAS2 spec today. They were looking at some spec
> changes to improve this + other functions to be added to RAS2.
> I agree with it being limited, but think extending with backwards
> compatibility isn't a problem (and ACPI spec rules in theory guarantee
> it won't break).  I'm keen on working with current version
> so that we can ensure the ABI design for CXL encompasses it.
> 
> Intel folk were cc'd but not said anything on that thread, but Tony Luck
> did comment in Jiaqi Yan's software scrubbing discussion linked below.
> He observed that a hardware implementation can be complex if doing range
> based scrubbing due to interleave etc. RAS2 and CXL both side step this
> somewhat by making it someone elses problem. In RAS2 the firmware gets
> to program multiple scrubbers to cover the range requested. In CXL
> for now this leaves the problem for userspace, but we can definitely
> consider a region interface if it makes sense.
> 
> I'd also like to see inputs from a wider range of systems folk + other
> CPU companies.  How easy this is to implement is heavily dependent on
> what entity in your system is responsible for this sort of runtime
> service and that varies a lot.

This answers my main question of whether RAS2 is a done deal with
shipping platforms making it awkward for Linux to *not* support RAS2, or
if this is the start of an industry conversation that wants some Linux
ecosystem feedback. It sounds more like the latter.

> > > https://lore.kernel.org/all/20221103155029.2451105-1-jiaqiyan@google.com/  
> > 
> > Yes, now that is a useful changelog, thank you for highlighting it,
> > please follow its example.
> 
> It's not a changelog as such but a RFC in text only form.
> However indeed lots of good info in there.
> 
> Jonathan

Thanks again for taking the time Jonathan.

