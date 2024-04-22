Return-Path: <linux-kernel+bounces-152930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8408AC647
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504A71C217D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92150279;
	Mon, 22 Apr 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbzxGauS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B524F207;
	Mon, 22 Apr 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773156; cv=fail; b=YsGeWFr5UFjNK5vCgFvwXH5qvTYmhW7Y9l/UUrrn8ImkA6H8rRUhHNdPhGEFmXIm91b+00Q94v/4dYiNyEOmsuiCcvKVN8te/2Jur9ih7rEsqe1PpLUuhBdd/GUhT5x0WdkKH30VCZg34tFhLuMv2aDe9qnVGFG6yM+KthzaqZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773156; c=relaxed/simple;
	bh=q+/PBdgVPGqr5p1yOl1/2gnDNM/8yksuNSA60q95sg0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=J7TfiFChEX/AGtCVywmtprN6jWoV3qeeCrrTf3RSSDOIKE1FcnE8WJW42Z1lLysRWIU8D4sA4bJJF4rGgYF9cCNY+hiQGPiJSHtfKuFfzpIjsjGgWeKiARMLsZY2XdDHjme4ui5rMFfjOxcPXL4IhNi+873qhoc4XdJUT+QzbIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbzxGauS; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713773152; x=1745309152;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q+/PBdgVPGqr5p1yOl1/2gnDNM/8yksuNSA60q95sg0=;
  b=MbzxGauSVyDByqD0pLCTQuCfPeyptQJjR3kFzdy58MfMoZF+nfS4tyyR
   yZ+nepHcKEJbQhkqccgVljoKu7vOniT3NsP4G6BAevUQc0Nb1T31eWL70
   0X/Z5UOK9FPrQYi3Swqxz6y+Xi+Twe8FU83ZenUt2WvhS3Bf5qLd/i9b4
   xAj4agDDBECpeyCmqCPyJ7pkKt8s5ijSOu67uwC4RbANu/mHSNWjP+FQV
   CrJldVpvbJ8d0/8srfFYlQB9gO78nyt9MOthgJG6Q50VnMsIVOXE8S1U1
   +/Pe+8AS0JnTrTjVk0ii9aDM6ROOv9tXdN2W5tSMcb+eo8j7MHlJ9bC3c
   A==;
X-CSE-ConnectionGUID: dGAfLeXuSHqvUyzAChMmhA==
X-CSE-MsgGUID: xxAEeGLKR/iNzm3zCr+v7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="31789009"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="31789009"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 01:05:47 -0700
X-CSE-ConnectionGUID: 1508oY9WRUe6iw72GCyPEQ==
X-CSE-MsgGUID: 5k+ALjabTle54oL4IEgCqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28755611"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 01:05:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:05:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 01:05:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 01:05:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 01:05:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g078EAdOAfG4KuY3nOB0MUy79/ghelvWcRC9kmtLYlaAmp3G5dbKJxGU/+KeK5vIxoqiOAj9LEWQ06dASocqdSZFMwb/bLg17zx298XP6WxxOAEXXSXfFslIMAOZW6AHn/sFJNu2Hsg7ZP5SZXNNNbJrm6djC3ayJBqKnpVrml8nESnTVzL2bxicV/tNtv5bYesIEQ5+OiDxjIqvB8a9SLWZVAJdi4Ucyi5H4GkKLlBRZwFumvHJoV5Z+dGgV9N2g+yirxxeTdlMtpAHCz36wAzZBWlmF4N03cL7pQtp4wwJfFQtm9z1laQzSPm+8wZHmgQ7rwoRB1sr7L9rYf2zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0LXNasN3j2tQsTb6JPRBTUw/QEtXLToBkNtQdDAes8=;
 b=RilGBDPsVngKWKl+AoR/5BYLpOHY7dZkB4rrWGLnyFH6ejYYXLIhxO/GkNikERWF1E/yDASSI7XiJ/EqvBFMz0uYqCl7IBQliM5v+hw/2/K95NKnQg21IjoBuYsEL9/+yXZECEpbFEjIRdjg5HuPetxuXuzEDgQMmWBA7hP/YVa/2by5ZyvKwWJRJMbKhZ22BAhshgof2HXU1RUUeR+RCV+e5QK/bfBjHhJyX6hmIJNKZsoeG1nRv3vC29lEi9kM3HeeiXaEJUl7NxFN0bd6vh/v/Db4N8vhvmedqnXMLKagBxzt3wvfaHaLOox4TVHMaFMaVVqZ7WzQdEnD3qc/vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Mon, 22 Apr
 2024 08:05:43 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 08:05:43 +0000
Date: Mon, 22 Apr 2024 16:05:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Biggers <ebiggers@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Karel Balej <balejk@matfyz.cz>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	<keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-modules@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [crypto]  203a6763ab:
 Kernel_panic-not_syncing:Certs_selftest#:pkcs7_verify()=
Message-ID: <202404221528.51d75177-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: efd62204-f2c6-4226-7699-08dc62a30225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2IB7oC0w1HT4Z49676Boqj2SlQsXKwyey2wEYmD1edrUjqgFkf3xPoHajBQ?=
 =?us-ascii?Q?eXoa3nTbCA9EV/ByAy8keYrrw6MXKQn3XnC+ZpuHtmOK1Q8N+41ycPhlicsP?=
 =?us-ascii?Q?mrxoPFSh6q59ftsx1KK/m5AjR9F/BN4sWiO8KgV14BiIF14uW1unHuISGoZh?=
 =?us-ascii?Q?ZdrAH3NcGXu26oyg+Qe0bQz0xzGLgfBV/jh63bl4Qpoo3WsvxuK6LWyx1ZCn?=
 =?us-ascii?Q?64AcGwj2+jbAAG2IyJlXb8AXMTC+5dYIW37E2plDtn4dEPXOBNBqHHIPYmX0?=
 =?us-ascii?Q?4gP7tx0V/NRv7DrSKSX/dzx7XNpnlo6qDihmgSCyE4Df8XYznlZNBjlq15SJ?=
 =?us-ascii?Q?+kCR4X1/7012i+NL5CyQE/KdBRGkdtsmod+MR02bpA6xLm0LeDXhUxAsfHTn?=
 =?us-ascii?Q?Lj+awz+H8yXrazTkPO9HpT9Qo9eQu2MsfoBsL4utQlXBGnF45ToIfEzyfX1h?=
 =?us-ascii?Q?QAAUPrUqYgEgt6Sk5pBaM3PhQsJIj3TmVzV/0YTN959+tT7D7CtXTGNdoZb+?=
 =?us-ascii?Q?Rem+tzzwKEFu3NBv9rJSKFxoUsCfDdkPfTFnbnbjN5aVFO8zMxk2TbUtPhfq?=
 =?us-ascii?Q?ghknF6pL775EFsTVvJXVMDwEtrPulLzA8Fn55iwkNxgYNpeILxNrhaTDl8Mw?=
 =?us-ascii?Q?L4qe0A36+w4ROz3YK2cYg7nwUJmTBi5YbTl3Z+ooU4YCavxQF3NX5c8LLF0Y?=
 =?us-ascii?Q?3YSG5oAADRaV66fuBMzFADUvue89/O4tR/Fsda8qRcKW4YRMv3CoL/vilZ0V?=
 =?us-ascii?Q?r6Ozg9qfRK+DI53icVobG6cQNNoTJayD461eLrB1WTMdWpWwXknqOC7Y5OOr?=
 =?us-ascii?Q?wJFIDSsn24X7fQer8YMC+N4gSIR9SYMNF+umNEONU80vJ4/Qo5xZcAMsDXHl?=
 =?us-ascii?Q?gSaoUHLGLB3RU2tCfTOjaf+NmMaYX2d4+72/U+v3ZuOMsry2qaHf9izp+wSD?=
 =?us-ascii?Q?q2f3n3L0sHA+vZwuq1dNh3t416YIeywPfd1jTiP75ULzbz2MmutVMDpW0nqj?=
 =?us-ascii?Q?QUrDp9WqxOQHUEYlG3PyYTDICSxSIHcNTEjmcoANaJ6nekuPuHCuqEcROAhx?=
 =?us-ascii?Q?1rh6B9BdwpVu31RbnT38r3c1ENK6GxEKBi67O/l5oaYpx5ENowf2ZfXqjht8?=
 =?us-ascii?Q?jRqfp0viJf5SQ/B2jRDeXfHezFKWPm5TDOKdJ/JUxQDj20CD91t0oEpO/Cn2?=
 =?us-ascii?Q?vNKwvSomhvuGQXNBhQhn0vgArKgATro4M2dm9/R9fGGwbLar7DdFmdQL/9k?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3pVzYhUFfztUXaU+trLJyQTf9eD4OTrqw5ESQJW9XCJL9Bm9smj8qn+QSCJ?=
 =?us-ascii?Q?6lDpfWJNynicl4nMtvsbOAcTwSPk9zShQtHtHGiFBasShtMz8GUmLma1QIaz?=
 =?us-ascii?Q?+aYeJuld5dq3d7QidZ0Pji+OZI93BCDWqNaDaos33k5CMmDhhInV52l831jI?=
 =?us-ascii?Q?XcmqZ85kvVbu5wyHLLMI5NkUROU4VUcHmx2bk/a9SBltHS91sY5BWtUz0bnj?=
 =?us-ascii?Q?gRQhs5FI4jk7D+XrKpJRxHB7NOt8XTBsRFXqWFWkDLxmda4mAzqUAqq5zZKw?=
 =?us-ascii?Q?/3x6jpIer4Cf9npaR9vkpJ4jdngCIqQ/Y78+t8O5CdjKQGX6SCl57+tDCb7W?=
 =?us-ascii?Q?BSBlvumZp2mDNNEbF+MVuLyWbrmVhzoCTU6KBTO8gLPBYoBAUmMZ70pXuZvw?=
 =?us-ascii?Q?UOV2fXnr5L3v7TVN4zkpUeb3tf4DGisG9VvkTii6V2NShve5F4nIS5QhCaxx?=
 =?us-ascii?Q?gQeo+LiyuWEbPQogkfhDpGOdon5NZp2R+Xs9WIJL5IghwK0DbN2OgZnLpSnO?=
 =?us-ascii?Q?5kDidt+ruonYIG9kKRRMsPXqAgKRbdVnHcS7N1wJH2q0T16K7TuqJ6KitSgv?=
 =?us-ascii?Q?WbuTtTLocWoI9Lm5c2Adpe/7cxaeuBNEinP1VQ5kN4E2qq1XpThpveqqyW1l?=
 =?us-ascii?Q?WcWnrMqmktaf3IAr6Zsa/6wP+laQA8uv8bsuzGHbDyRLadr9KnPXUAT2IzQO?=
 =?us-ascii?Q?yLhGykWlf6OVXZE/AVQ8Ywqchl89WairWEsGeL/kIhf6CvinO8OCxCuG+Vzh?=
 =?us-ascii?Q?iAuKHDLZgWMA+lEPI3EqIwTg5wF3AJ3rmSv4/uzFQgoVqSnLNN6NOwjbtVU8?=
 =?us-ascii?Q?AQDKT5RBqfHdPhpkRUQoy7I1A0E6f2Jd8onIZlESGlAE+/+JzrOaPTigJ89Q?=
 =?us-ascii?Q?mXeCvg6zgowD1BNo0fE+rsJKaX43rZqkzpcoHjaLHL7/q5SfysI0Gj9XPWZQ?=
 =?us-ascii?Q?ZuJ6sZTuVYp2PtKdFJLrFNgZraSTr9KeY+mIPy27z/tEKJQ1TJmKNzdYXkZJ?=
 =?us-ascii?Q?z7Gg5xvrf55Ps/WxNvyzGejrgPpmIM2wVz5zOq+zM8lJPP7A7sdLvNJpUQK6?=
 =?us-ascii?Q?NKnvJ/x53u/WsHVNZDauY71u/s3ojXWI7C3/X+PFLv9LrBSpF7H+y9Teu3I4?=
 =?us-ascii?Q?vTZO5CZyQqik3nI691rUu/aIeMJYC6ubCeETJ5psMBpZ0Kbe8Nldx83qeNgi?=
 =?us-ascii?Q?gmaHXb48mwNnJxBpJVwptbhlAkHSeR7fEYgjy41ILhGqec7xfL1kzIEFliZi?=
 =?us-ascii?Q?AFTZdnfy1NKJ6XbWHXgD8l8llXRZonLE04UEly++xAsKRjvrtMGsy0+PuYp1?=
 =?us-ascii?Q?F6za+DsueJiemOVlKQDSMJ2nmi+XacZYERLO3r8TFhVNVPAusWNAf2fD9jAV?=
 =?us-ascii?Q?IbfNpZg8XbWkDBJX2T4mIOUYfJkSu50FyI0NocNn5lSGsfNeMfj0UFtHqKLr?=
 =?us-ascii?Q?tI7IMEaPgAmwpFFUGAGbIDOz2ZcXVY8W8I6tDvpj/aKxWJkQ+5kkEUvvyMV/?=
 =?us-ascii?Q?kHcwMZOTA967+MxMjwjwZO/wdAfP/Vf8HgJ80Rk137j0th6FdOXsciabhH+G?=
 =?us-ascii?Q?NYzD70Eqs1OTQOMkNZtdVCu7OCsNweuaVd/KhXrB6q4VY91aUMVVD7VVns5N?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efd62204-f2c6-4226-7699-08dc62a30225
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 08:05:43.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8GrxO28bTqCQQrv02FkOAwDY1JGC6NtxdCdD9xQSoYGubmv8AROaFxC2uwy506n3TXOvcaQJwV0euFdwox8sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com



Hello,

we noticed this is a revert patch, but we observed issues in below detail report
that does not happen on parent.

the config has below diff with parent which seems expected.

@@ -720,13 +720,14 @@ CONFIG_MODULE_UNLOAD_TAINT_TRACKING=y
 CONFIG_MODULE_SIG=y
 # CONFIG_MODULE_SIG_FORCE is not set
 CONFIG_MODULE_SIG_ALL=y
-CONFIG_MODULE_SIG_SHA256=y
+CONFIG_MODULE_SIG_SHA1=y
+# CONFIG_MODULE_SIG_SHA256 is not set
 # CONFIG_MODULE_SIG_SHA384 is not set
 # CONFIG_MODULE_SIG_SHA512 is not set
 # CONFIG_MODULE_SIG_SHA3_256 is not set
 # CONFIG_MODULE_SIG_SHA3_384 is not set
 # CONFIG_MODULE_SIG_SHA3_512 is not set
-CONFIG_MODULE_SIG_HASH="sha256"
+CONFIG_MODULE_SIG_HASH="sha1"
 CONFIG_MODULE_COMPRESS_NONE=y
 # CONFIG_MODULE_COMPRESS_GZIP is not set
 # CONFIG_MODULE_COMPRESS_XZ is not set
@@ -6064,7 +6065,7 @@ CONFIG_CRYPTO_MICHAEL_MIC=y
 CONFIG_CRYPTO_POLY1305=m
 # CONFIG_CRYPTO_RMD160 is not set
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_SHA3=y
 CONFIG_CRYPTO_SM3=y

below details just FYI.


kernel test robot noticed "Kernel_panic-not_syncing:Certs_selftest#:pkcs7_verify()=" on:

commit: 203a6763ab699da0568fd2b76303d03bb121abd4 ("Revert "crypto: pkcs7 - remove sha1 support"")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 46b28503cdf35e1c34d9d135d91da91d3649ebaf]
[test failed on linux-next/master a35e92ef04c07bd473404b9b73d489aea19a60a8]

in testcase: boot

compiler: clang-17
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------+------------+------------+
|                                                          | 6a8dbd71a7 | 203a6763ab |
+----------------------------------------------------------+------------+------------+
| Kernel_panic-not_syncing:Certs_selftest#:pkcs7_verify()= | 0          | 18         |
+----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202404221528.51d75177-lkp@intel.com



[  235.982707][ T3437] kmemleak: Automatic memory scanning thread started
[  235.986822][    T1] Key type .fscrypt registered
[  235.987472][    T1] Key type fscrypt-provisioning registered
[  235.988407][    T1] Running certificate verification selftests
[  235.994542][    T1] Loaded X.509 cert 'Certificate verification self-testing key: f58703bb33ce1b73ee02eccdee5b8817518fe3db'
[  235.998172][    T1] Kernel panic - not syncing: Certs selftest 0: pkcs7_verify() = -65
[  235.999259][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G        W        N 6.8.0-rc1-00082-g203a6763ab69 #1 adf66a20b24f10d450d01d16f8c396f953580a9a
[  236.000960][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  236.002277][    T1] Call Trace:
[ 236.002737][ T1] dump_stack_lvl (kbuild/src/consumer/lib/dump_stack.c:?) 
[ 236.003344][ T1] dump_stack (kbuild/src/consumer/lib/dump_stack.c:113) 
[ 236.003893][ T1] panic (kbuild/src/consumer/kernel/panic.c:284) 
[ 236.004415][ T1] ? pkcs7_parse_message (kbuild/src/consumer/crypto/asymmetric_keys/pkcs7_parser.c:168) 
[ 236.005101][ T1] fips_signature_selftest (kbuild/src/consumer/crypto/asymmetric_keys/selftest.c:214) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240422/202404221528.51d75177-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


