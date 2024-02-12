Return-Path: <linux-kernel+bounces-61585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9D8513EF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131B01C21C58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00C33A269;
	Mon, 12 Feb 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYk2gq/v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D93A1D4;
	Mon, 12 Feb 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742780; cv=fail; b=LBniBJuAcuF6CmQWSKZ3/B6uqDAzou2/ZfhfF5fq0CUw8CuPQNPjiiddWpZSZ6pCYO0cX4W+5jshgyGH8Oxs0KKC1LuNjSv3TPHGkZBm5pCceeVBD60Jv0LbP7wZreG8bwn3Ejsu/Dpmy78Yh1YDndJUrjdvgYJXU2gQi7bSewE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742780; c=relaxed/simple;
	bh=IwBxGp8n5SowOW/rp3jN/B9uNcdA4E4bnjl7D7vRGfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d9kfkZmgTePzS4k4dzJIYLaPxU1c3WJSZyr812X2YvJubMnL2C9c8u/ZiwKaeWsMXPGk6r+L7/KlZbKJ2WM5h55qx5WDPElITbPGgLtNRXDY9tDmsahre3Y7x1VpddRfoIDQxYVqsDfWSY1OL7QXko82jD4sXP8pYyAia7jqvxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYk2gq/v; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742779; x=1739278779;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IwBxGp8n5SowOW/rp3jN/B9uNcdA4E4bnjl7D7vRGfU=;
  b=TYk2gq/vc2HSTWBIJPERRCKQYB/LOtHTum2nGPx5fwoG6mQPu51K8CtH
   BQs1lgDsZGgEzr23oBl3fAC/lFoqEgpkXGxifcN/6zn3SapP7asxC7cCn
   Ihsrf0V4P0petH4inTAjVItmzRbWzs43GZG4750aXBo3NVbNz20cbFXRE
   9F78u0nx2QRzpMl/OTQoKdxmS+MvemSuogRRvSVVNlwC3r5rlefHVnFtr
   /ks7dCg9nYJ/GNqgUnlVpkIsnZ+FaUKhhny7aTZybzhu+INyDvdy4rYEf
   Bf3S0yRc8RJvoYqRWY9+cA1lYW0gCb4UDFBFfFS10fAj8iXv/QT6SN+t6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1839317"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1839317"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="7240172"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 04:59:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:59:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 04:59:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 04:59:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 04:59:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd73/ksJ2sN4PzqNLS6lJppfkP+zPkJYBYgz9DPF5cyVLS1+eueHyO1Rh1FyfHZWAt8do6J+FOF9aa+FmpRQZVo9sDwTAX7Mgg6/+jNi08UdlQKg34xC5upquW8/qr8ZQhje9r6nwEwgLUJKWkmKuZzrY8mFUHC8QPANhWehTHZoNvxlLDATG0qhY0uCBaL0xG/E5ZnKaRWWvym0uqh2daRkyVmU39akhltQlUOeJh7l7ch1JN38ol6NNlIbGerQK3rRiIDjUDl8mZG/UQzioMGaAZiR7Gm1EyF4p0n5UkmPe5B3zNZ/v47Bk8N0HEW6sD1xBQCIpBJF/EAfPu5nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbgmqKFkYIVVvLheWaTOarzHxA+BG8NfBHWeioqpcMw=;
 b=GBq/RRUmA0XXHr0YQcNORMKR+Zcmoyqnnh0OIcL9bEZ6UhucbPpCPOSHiZVscQ28zIex5chpKUtJFRUi7s9TR84TsPfN+Rsw/ySbAQ2vtvoctunSCTm0u+PtrinL0DkW7qBB3bHbpyRQ9XzbNp3SUfYyzf1UJacohBRiw6n0RlnEqBuJdu7d7cywTHwjclWK80r2tPG1P+z9augdgtz6DrO3d0xuQYsq54Y9PiAu6Sl0FSYhPYlB6/nHJGzEWMSBzBfTqeHUC4Dszf+49rUNv5i/t/Yk4WYSe6KRf/32pJg9yjmlmiiVBbLrBqTw1exYKo1ljIa9+aCViC2YXQGe3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ1PR11MB6081.namprd11.prod.outlook.com (2603:10b6:a03:48c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Mon, 12 Feb
 2024 12:59:34 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d%4]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 12:59:34 +0000
Date: Mon, 12 Feb 2024 12:59:27 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Damian Muszynski
	<damian.muszynski@intel.com>, Mun Chun Yep <mun.chun.yep@intel.com>, "Linux
 Crypto List" <linux-crypto@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the crypto tree
Message-ID: <ZcoWL8VbbQhHQWWr@gcabiddu-mobl.ger.corp.intel.com>
References: <20240212144830.70495d07@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240212144830.70495d07@canb.auug.org.au>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DUZPR01CA0337.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::10) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|SJ1PR11MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: c23658d6-6ceb-4ae7-d1b4-08dc2bca75c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zT3dfr+HZjHe8+dthg1/r/2j9KPkvxPKJfWHr0xBMsTB4LrrdoloeKXutS4al8Z/fhJbpsADco44MDvFYvtMaCTnJtfDYGZNhfVuvIzt8itiaHqG4e6TvYGaGlEtFt4ipu6Dr9fmo6P2b9HUv0F2z8JYyipmtFfv2l+r3ZLQOP1GKX2tgd6WErLq62M5CsEEWp0AdYQxDOTpLBYVQ7UuSeYbqgvPyT73DVYo00gs3naLuEaSjxZUz1rfHRtiiwfWIhOwqB/jvRJ0jbk5ccrs6uzNhR4VF81e/Bh/btAubzOk5LpIBu9IcSN3M9IdK1kTQL/d+gA7NVOnIWfo8/UrJY+6vwoI9fdgXk3AaJVr793X9eehnK+OzH2nIJ49CYz8QuV73CHWArDKI4SOjWRWLvY1inQmrAk1li5P/JOsleRjWJzyOcUX50so/PwZt1ANRa9Ie+tH/frsTWcQ7U0UwOj6B/syejY6SZePt6HytnjfEn8N2eCR9B5sqiFKSLiGnSgXIEY0Fk1nCJeVLYOUh4ukjNosvpzcQKtpRs/IMuGsi7oiAahV5BLyuHWNWeh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(4744005)(66476007)(8936002)(66556008)(4326008)(8676002)(66946007)(5660300002)(82960400001)(86362001)(38100700002)(83380400001)(6666004)(6486002)(478600001)(6506007)(36916002)(316002)(54906003)(6512007)(41300700001)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G/GGGrgwDmcxYl+UuFjyEd7ByZEP9kbxZRY7JX4oq5yMSPs9qPo1IrpX6aaI?=
 =?us-ascii?Q?+/oShPq8Op1BIartnvPLYrLyyfpCW8fYkakmvtzRnU2t2rdHzfXamHm9dRwM?=
 =?us-ascii?Q?h4jdXD4LnIfo5ycQHcIH6IHuMRAUAR1+z3eAwBtabKx709CyuQe0NWnKfRO/?=
 =?us-ascii?Q?iyVDImPnmUt4vRXFfELy8H8oze3402UWX8iHvO1aRQQUdPlPPoaRhhDhxiXi?=
 =?us-ascii?Q?10Lj5q2Sy+rbMT51Bl6K4Sk7+wOKMxdl76WuMaahk+iiEb+GFw2tKnFHSgyp?=
 =?us-ascii?Q?yno0tAo6CEoCUlhIxJPDhcKZmFCnlAVbrpiM9eMcm2To6LaFetlkjfTGnB1x?=
 =?us-ascii?Q?Abi5UoEUGMlJRVdCsYInb41a/RBfJ81Aw1trqdu9i4FXSt/rwu+NymVhk7Zp?=
 =?us-ascii?Q?xXMAXNDmSCqhsP/Qaofa7brH3CPgGPhl8aMsh5+WQB8arGqGem4jgmyiZ0Fn?=
 =?us-ascii?Q?wNEE5Q4CEGc/J3IT9kFWINVWUPwKKoy98ac48/J4HN3lfIf2bGwBUZ1bIQ5a?=
 =?us-ascii?Q?riMBzMSsAfTgdBh9XpA99QAdf7+ocZwWZuFGTDjd2l9K6WrjSjdI9/pZrNsj?=
 =?us-ascii?Q?wQh1pFnWJVaEt3afsVzXcYcps9jjzHXCxMUyf970agGwSe9G511AJ6ynZ6+B?=
 =?us-ascii?Q?JmKpz/sRUAY9twp4E4g9MCMw5xA5T2759DYf27Z162oKz9QyIGyFP1pDqVx2?=
 =?us-ascii?Q?Tqu8uwI1LYY4xyrj73LJ+FDqRR8kwqNqxz4K661bLJyi9qT1Q6hwuMlhOjxk?=
 =?us-ascii?Q?StGAVDmpBnrD/632CqlxYm+4e294kNVmti52U8BKp4/LOvI7LsWpI4I8OWep?=
 =?us-ascii?Q?19pchE6nY+9Fx+MjGv1MrzcE/nPIkwWuldfPN7bhgY7bcBeRn8Wbfg+vVL2j?=
 =?us-ascii?Q?DRMXhfW8cmTSosq3G2R0x1V25rBU5AeYVrfgPX4em6rUgROTCF/1u1rqvYZC?=
 =?us-ascii?Q?O/FbeJOmH4HpDGLBfkXXKVLqwF2Ba62XOtur/cLhR7qt+W4+CnPP1sTKUKOy?=
 =?us-ascii?Q?hucnpV7OM7qSVxX8bXC8/fndZpJCYROgkScyQOZqOtkIVA3zyck6MrRq2eV7?=
 =?us-ascii?Q?/g1ItRfwYZv+tHim9JLBN1Z+qm7lDeKJq7jTCL4IXD20FygTHVB9s3Zy+ySl?=
 =?us-ascii?Q?1/JyEqHF8fCT3pdeXYQYSm4Dp6td7jnGh5acQqPC92oH0dwRI2GSnIxj7zFP?=
 =?us-ascii?Q?PGLJFHV1peIoJYa4fIBB6bgeuAaoJq7vLKvnqjkvIw3px7mQ/dJMrnZZrck5?=
 =?us-ascii?Q?kyUg6rT2QF5BZw9WEpy08z+KikSOwCuVm356mlLLZMn1cqhGpaFSiHcMgqe0?=
 =?us-ascii?Q?xQcvIEVzGysvxkEtCATZ6BGJpwZYnJ+C+ODTrWHuAHKPrSNNGvta3ZxiV2NM?=
 =?us-ascii?Q?pdYAmDWnCfQVViw+zBdtvVnJgsccFawTxAIHoqTXle4WYb4mrAP8IkgL1VER?=
 =?us-ascii?Q?V4bb3oYg0cmj/TiivA0/+t9rbxLhbiL/eecCkMP+3zG9hpioQhhhcB2jrGaJ?=
 =?us-ascii?Q?qJrYZD/QiQ/c7P1KQwlTdCTFh5aoLYQia3qtZ+w3PE8TkophFeSZsHTrdV+X?=
 =?us-ascii?Q?HYviJJ9E3byu3pLi/anrraI64pwhkTBh59kPeNnsavHT+Xf7TW3FS7IrEnaW?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c23658d6-6ceb-4ae7-d1b4-08dc2bca75c0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 12:59:34.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99LV7EOqZtek46ozf67fyh3WnDqtOqgayMJggDsVxGGiDYKW3osJFVkFxYTkmx6CsQqDFPqDOYGrEA/UXg7Fuf+ntWVNjnHZ+067HIIaFQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6081
X-OriginatorOrg: intel.com

On Mon, Feb 12, 2024 at 02:48:30PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the crypto tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/ABI/testing/sysfs-driver-qat:146: ERROR: Unexpected indentation.
> Documentation/ABI/testing/sysfs-driver-qat:146: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Introduced by commit
> 
>   f5419a4239af ("crypto: qat - add auto reset on error")
Thanks Stephen. I'm sending a fix.

Regards,

-- 
Giovanni

