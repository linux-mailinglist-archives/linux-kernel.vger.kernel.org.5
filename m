Return-Path: <linux-kernel+bounces-82540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C107868608
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD38B1F23C11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305B610D;
	Tue, 27 Feb 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aWd1KhR7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A13525D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997775; cv=fail; b=KDH4eCTFspDwHmwN2yODPpnctHycixiytZHR9I9J0gxHKkoY7flpC4WrXa/Kpg/VDuIPvFNJddtkZGItvswwbeR13mC4tMaU0LPKLOKDUMLeFDFwO3lQHisuTG+2Hvu4EOxPq0ZgNqksk86o/nMCJbwLv1Dhb7dcC0KN6EO2j74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997775; c=relaxed/simple;
	bh=AhaO69Tx9XZIpVPmycIj9vJGcdK2WD7MfMF9JXZRQ5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWW+XkKB8u+baiG+vrE4QPrtnzYRtbwV+Xd6ge0mCEKiFOxYv9xndCztkSDhwqHMFaAWQ1ddPXbSX6CEwr+mkkhaAg0ppaFWD9CRiieE4bOPjwb6wnmwE89ph37gZ4edrppe6hCifSXEWRdDh+/r3sJhiGB5jYnoS8D7kC0ZW2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aWd1KhR7; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708997773; x=1740533773;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AhaO69Tx9XZIpVPmycIj9vJGcdK2WD7MfMF9JXZRQ5g=;
  b=aWd1KhR792DN+p9qqP1CFVIctR4stWxq06YjtE08IHbcDMKT0de/EvXY
   TwBQeeRbUpxu9E5Tp3n1pyKE+APSca9RMjBWV6Lxe575JVF9A785okIRE
   TzKTRbDjM7gXsDz/V8wCS6ZZdcBt3OME8flHFApGm7CZbrfdC740RBt8A
   kAjAagrcgDfOmrzjqAEq7oNs2irBzn9HEMVpg4sCMq8zYnf38LvsQ6sf/
   GfUwj7bZobY3gsZofppk4pZl7c5ZGMl5bD6yUBOqs1Owd5v8LvTbyqCH1
   UMhyPXWFRN6kLQPVNlG5ZC82aDfRDmKgQxPVySZ8tUxGNHHb5PjsMZSYf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20762219"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="20762219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 17:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6798361"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 17:36:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 17:36:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 17:36:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 17:36:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0GI6Xa5sJcbsaOpTxbZSYcvq7DMg3L6rTk+B+sfI88BBfOzktyC1pcQ4w++GeyPINa5hUUlmPyOw1cQXwLKcMFSODi2ACP7prYqL6wWLL/DyhuOw+pO0kH6DIfNeq8nG6coq7N57qj5vDGNf5YdZ993zk6UyuIry0FM+3AJihOdeNeogbvJdCbRxKhkRorEyTblIeAmizEqUeIjtAzmeWD7V4I3vsXuiiQTic5LwGl4ioZy8JjQqyVh+LTdQsyIXWHqDe1P4nMcZmHAu4Iqmao9U5GYwXb5AMwlXj203svomUxiOQ650sHFT7btRqtRMJkY3v3AbSYg4zkd+kI+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjVRMUhYdNbCJoHIBtohnOVQMy7rlk1VZG9x4ZFeC9Y=;
 b=ZjUtn7j7QODRehrTz69wTcm7Eh7yNGemYiHVZFu7bPuHtbh5B9vNNPI1po5/HdAPY26oqAEZeaX7TqNqbuCm8OWSVwV6A2DxMTTUlmq6ccR7xsOsg7hFo9bzeV3/jio+y3NyVHNHHWoJJEBOvi8BNhRGTI5M5XUtA3vDODC8iSaJgPmYdHRb7baphPG2HptYNF+cl60udgVBOBrRFqJ9sOOXekrDSh2JWV5cMQVPzcxQjdYD5W1hfgkC1Qo0WclPt8IUO4qDUnXmJT8uVcypuJUjp92NZA2/Z3iUhbjvhhbFH4nDLZuwKu6Po6hZiRPh76RHDvVQL0759J7nv/DnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV3PR11MB8482.namprd11.prod.outlook.com (2603:10b6:408:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 01:36:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Tue, 27 Feb 2024
 01:36:09 +0000
Date: Mon, 26 Feb 2024 17:36:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, <x86@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: RE: [PATCH v3] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <65dd3c87680e7_1138c729433@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240225224244.2072245-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240225224244.2072245-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:303:b8::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV3PR11MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ba5a1c-12e3-48ae-bd59-08dc3734797a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKl0x3N6EVcpGUcViYh/AEN9jQujJ2+ODW3p0pyYk/GibckeH9nJiydyED/OsfAcTMtjlIeeU+ZF2jPRcvV3kisrbJq1yIO22mh525HnFvKmMF12u2huVznisJcTruJdaphlsnk45z3BedgCHfu6GvMcukxOemFvWAI2WV+pMxppu08clTz08Uykgv0gg3F3NCLviR0U6jeqM0dXoO2ZjNVJ1HHgRJYWk3euz6Es7jqRRGC0IQ0Gt997e1JMmKceDz/0DGhrYCs3R8zDKmoILTFia9FelM82i7C6BJKh8NljMSyvE/TZ1i/SeSizQ56D2AzMGQLE++hQ2/FJJp2W0buNT3De3wekVW79zxmVBfGEQA60hfLFSHrNalSRdPKm/JdPqFlndUS8XkbDLSZnyP0ExweyiaNTryCBrL8RO38bVjwGblvsXKr3neep8zRfT0ddvMXrFkNMTPybMHw+DXAxHCNEZPHrjmjqy4S8v7LjmGxjDu57RpCGss4SvemTTZhIIexk45aiZtbWhwDnnhy3EO4xgm5+q5Banjj/E8HwXLzjjUukdR7UxNrNFg2PO9su8Rcke9D4K2vbbvfUJIOCktOnH8GDbHXuLtMTFrxWMi6WQ0JHQlo5LUzIjyiZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UltDEvAza9Na9ZvXq9mGKkXO+uIXFL9oovNdmTQq41XS72trhC/vrK1r37+h?=
 =?us-ascii?Q?2H6cqYpbKE/uehQU27jRwl+6Gr6Zvqt97GvEnwCbAANq7s4zW1Yw/EDaLoa1?=
 =?us-ascii?Q?1GD31D9Ka/6vwSQipp97A0zijQw79yLB472Ho5aF4pJOs3orEpYfF0QT9kbr?=
 =?us-ascii?Q?2mUTy/OwncldqR8BFAAndrVAngMftwD2e6dZ+Y0JU+btpsqk39BFtwtkSb8f?=
 =?us-ascii?Q?UlRUyd21erUj6gQ/e7oDJSCCK/Ju+3Eug8fxKmomHlEK6kBQXDellNlIlSwM?=
 =?us-ascii?Q?h/u6QlFfqMOX+j80104RrcKjhWrDJVFMCPQDkIWiEWTivhryPVsVG2WBWDK2?=
 =?us-ascii?Q?lLm8GtHTxE6svZP7NX6IsSCQI4f3U3sxIsv2zm1PiJLQnx2TjebJgMGmgfrE?=
 =?us-ascii?Q?EGCOeyw3TRzod33AMoLK75Wp68ZddOE7mjO1HUg7iCz6krr/dd56CXMlZVDo?=
 =?us-ascii?Q?+AGG7L6oEHjIziV6NtcHkQe+6JsZMT+x6UZ3fVwo7D2T2iAWBwCav/Kzio3F?=
 =?us-ascii?Q?Zchz7e2MHEDZ5bFS6m9pHBB7YzXWhgWPQ67aKPSvgDHZgvomiCPizyaXtsnw?=
 =?us-ascii?Q?9fASO7NZVhBKW6NL9Ne+2rXr5ogKA2N7fmt0mRBXEHchCU/VeWk6tyLYtD5H?=
 =?us-ascii?Q?xa+XVTBuZX7k8XSQp9YDYMKit/9sWEfESTnawmlMpsO9+ybtcU+cs4Oguf8S?=
 =?us-ascii?Q?Zak2KghF0UqFS2EHQbwMygvN/Oq67jthRKSOYQDNR469TAdbI4lYMs2kTHpv?=
 =?us-ascii?Q?ndWIjR/7vZjMWhogXjgiLkQ9gE4OcdKIGL5PUoLwTKGihJkKPyf/NYaRP2R3?=
 =?us-ascii?Q?GMdkl3Dn5U60D2JDmWAQtplPX1SR9vfGOA5dSLV7ujjxbC6W7Egaz28yeVFr?=
 =?us-ascii?Q?3t/hcL24SAwoes2QsP+9yZZ5KCOtaUR/a9j8FyxIYAj/RYssAL4oVx0q/R9U?=
 =?us-ascii?Q?v569M3Cp2NX0MJNUBYSs8Ddx22Dw+nuxf42Ctn9pX/yj5DoxqLvuLQOMDbRg?=
 =?us-ascii?Q?HJr3f/62C3g8QzhYbCj55A1l8Fj4GBAnRHpS3zs14mS9r1kEt2Yt6fMUX8gH?=
 =?us-ascii?Q?Da1GLl0WdPUk1zF398V42DUuOz56WyPl+42LaNKJxCLLBRFFOqduqmdFsG+H?=
 =?us-ascii?Q?V5sEf2s7mO1TkVEky3n1sTymm0zv/vhW7DedKUAvWt9E7EgHrWMNfkTQl5z4?=
 =?us-ascii?Q?6L2UeRPeB/a7oqzPXQgvXKPJZiclO/TXaJ7JMD/CgXfX3mXEnhn1Oh7rXEzg?=
 =?us-ascii?Q?z9CsrfICKI1SowWO6Nd/2BWigxlIz5ice9WLRPlCp2L+E0lolgyaeoHaslPx?=
 =?us-ascii?Q?dXaOr+5ANFMHpbq6GZA6Hr/5p3soUhNqw1teA5ZrZLEIlaR0Ni9CCcSiZyn+?=
 =?us-ascii?Q?y/RcZ9xRMoLkNL5l587tWQhZafQm+8gCHxTqujoqNTdeY1Qo8uChIHFjmd0l?=
 =?us-ascii?Q?ofiQjsTyOtnrDEHgL8Gd69aziRmOBMsDduvR2qcjoSgA/01hVJU1p/bdY3Jx?=
 =?us-ascii?Q?ppdzyNLAvPtuQfkc/0Yphn6wQtNRPLUgHWmDHaXvrkBYKnCG7acH5mcCnPXe?=
 =?us-ascii?Q?NxMWoE2vtrfJdDckoJD6a7Ck7I5JUXXX0b+UlawnJGSMzmGwDndIfv3a7s3V?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ba5a1c-12e3-48ae-bd59-08dc3734797a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 01:36:09.7391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seJuGJgh/XA8UzABpwucd+MP/3ujD+TgwpvM6jzM4Djghy1JYBvIEmUXnEDDQsyOP2mR8Z5IoDP+6avFh8Y43m6Zq/5AuJvmjrFbO5uf9Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8482
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
> The tdx-guest driver marshals quote requests via hypercall to have a
> quoting enclave sign attestation evidence about the current state of
> the TD. There are 2 possible failures, a transport failure (failure
> to communicate with the quoting agent) and payload failure (a failed
> quote). The driver only checks the former, update it to consider the
> latter payload errors as well.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

..if you decide you need a debug print here, or to differentiate the
error codes based on transport vs payload error that can be a follow-on
change.

