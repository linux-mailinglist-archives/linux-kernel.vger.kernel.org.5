Return-Path: <linux-kernel+bounces-45595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7DF8432CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD021C24AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C731847;
	Wed, 31 Jan 2024 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oH66zG7r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B090139B;
	Wed, 31 Jan 2024 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664875; cv=fail; b=UFQwFkKW5zGiQg1QOVvKxOF0HsK49K9scfrLPKwyXYA/5gpchE74BG+s0ibclMoyzhMo8SSjqVmduRQxxYPL/oPsMW11prTefV7ga4YCHesjUtOPWp8Y9vVLO/LcUHwkDBCH3wxq4nFnKT8DiV2IwGmmSJHq4OvyeujFafPjKT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664875; c=relaxed/simple;
	bh=Zd0hU0l58pBFyYIUB7zZocfNBKhyxM8qcD7FyiHjRQ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DoSVGfmhXEYOfQgudfvsG9ZFnG9lDqiii++hB1zNPnwdU2FjP71vVCCwygIyMA1Hc4eV1J/CfGrHJMAk4KtCO/gjjQzCCMQyGoE3fPfQFm6JvJqK1qSXku2GxCD3uXAGHCg9TrXJEOTalCVveLfT/TT06Vpu9qQ7H2ltSYzlV7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oH66zG7r; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706664873; x=1738200873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Zd0hU0l58pBFyYIUB7zZocfNBKhyxM8qcD7FyiHjRQ8=;
  b=oH66zG7rUV6NXcpFl2GK4vaMZQks11QUxqR4IbWUNwcNKqHrrbEvgY4I
   FmzHVQudXHLADMQ1AoVDq9yPqAwfNjXS1Drl+IR03HmMFLxtuiDRXPTeA
   PMV0vS7egNq4CCHBWOydyOsUu12qzt1iaaLez2dLwgrfvybqN8/QeALtV
   n2rS7oz9Q4VhBxf+FTeaKeFCC6WQZq7YtJ6zDNlhkgE+yDRWV7sZLtuFt
   17dx/WB1LWcCAdJMPl++7bcWNVymp6Ngd/ftaA7K3D7Q+LszXPPtfVYBf
   6Q2dpGxRB2FkjYPd0mEor7NmTiBfEmIblv4zNup2bm7bxzzYF0W2baztU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16984002"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16984002"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 17:34:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3930301"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 17:34:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 17:34:32 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 17:34:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 17:34:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 17:34:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA7DnSNBJZYnrrLtj6DTM4bqw53w3tqOsVVJ1jBPwoIy1eZub3TeTsDWvg/1mDtROh+Z//vbxyDyM7lfhUVKO6BD0TWx79yXJa8ehee35IK4TFiUVOqgcZ/w4JMjSZYXKUyAXcBfJMKfWN8zmnJfhl1Kb2nBxSpML7a3lb09tshDHJo/8cYYRlfY0aUHVp8kcdI19tfSqY4WJuEhYJeE1820Sln/5OsJCtNTRVj1tY2Et7CdWWfP2I6M+Kg/k2oZS6qRyeElI4IF52E100eaZ8vLqsMZpYx5Dj2/asni0s4nEhCqQXuAApX/CmhC/8LkMsKrD5vw0ch4eAVu9MsoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzMuGCuPQ+cfKaQSJ1wmAtl/jrlV/VVg3ga3dF39fdg=;
 b=U6NlsE1EQoNY/Z4Xzu1+eGv17/yfleSyWgqWq/NcqMnKs++1Oxu0CuDTpkdJKcOctMTa8qx6aIePaXPJHwSbWWhzzTPGVHwxXnFig1DdBAWQj4lifbLBxsH74Nb8Huamy4jlGGfVBhLElARJTTzDYuvu15epC7yl3EHULNLuIfo+LxWpSCcpBsB16IW5rPDv4s+Jr1rxxl3nOuuvNMkhKbCQCtY9J7wEhK0dDAbQWEG0pxnren6Ub2AJw7kqM0KmTup1N0onsJ1kQ6lRSYwiUFEh5MWUK7m3dkC6T3R1dOOQYoO8k+2FfNSXAs6Foymw5eNFpP7cVstL0BDpcTkZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5428.namprd11.prod.outlook.com (2603:10b6:610:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 01:34:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 01:34:29 +0000
Date: Wed, 31 Jan 2024 09:34:19 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Justin Stitt
	<justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Marco Elver <elver@google.com>, Hao Luo
	<haoluo@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<workflows@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kbuild@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [kees:devel/overflow/sanitizers] [overflow] 660787b56e:
 UBSAN:signed-integer-overflow_in_lib/test_memcat_p.c
Message-ID: <ZbmjmyoGGmGNaLbN@xsang-OptiPlex-9020>
References: <202401302219.db90a6d5-oliver.sang@intel.com>
 <202401301604.7B7BD5664@keescook>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202401301604.7B7BD5664@keescook>
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3bd7c6-120d-414a-915c-08dc21fcc46d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9T11oNFtyOifUWlfwsKSaUWZiNjUc3TzmExUUqHuZAlQ5Q4Ssqy7rJQ3uo5cCY4TlBe9JaNp+LNw5d+L4JPQxUpOF+5Q/Fms20re/q96l5/CjlAkh/WysIDgxXE2qPhyS/LAKf5MszLwUQOMWfx+SYCh0fZnXkRgGViQVGp+BimjJk/Z9ZlkKbN0Ts0DbVLpJIrxNxKVjQd6uRblbBd0QUOQ6w+e8jB31l60QMz4RbA+dXu44jXSptQORqns7/bo6MxsnU6pzWCuzP+q9iMqawUOM76sdnAM+oknTt5hB5xdBS8ckT2+GK+EdLlm6Igu354afQ1Fy+OEHynVEbD++d8kJpK6U/P9xtUUoPFuv22bQqAwpantjNN8y3kNQIThqKXIXqNJopWYZD/9ssU0GZjD6WF5j+vaFoGmRKIbpSU4X5h4YGEd2gMZ+Etstpq7YaFrrIXlhUx/ZirvslT7QBHuAw9Cfgxmhjej7z/4fjGSuTbpwNdtrUEUepeoGweRkk0KZeGl4KeNhKO6yQKCEjGLURaC64uKpKg4sam/0jhyoGAZzUlhh5Sdo1NMzW8O445+oEFKkhxVogdRi79nTH2J/6XlZYHOw21or2d60go+dc3BkBDL0stVqh21I90
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(6666004)(966005)(478600001)(6486002)(107886003)(9686003)(6506007)(6512007)(83380400001)(26005)(66476007)(66946007)(6916009)(54906003)(66556008)(316002)(38100700002)(44832011)(7416002)(82960400001)(2906002)(5660300002)(8676002)(8936002)(4326008)(33716001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqsyxbP9YS9XJmQ1U0RzGkhbWwI4q1fvGUp8QsdLKotvF9w9AgoRPVqjMEV1?=
 =?us-ascii?Q?5dmxZpx3j9W0H+lZPDGuVMxCrAqvFLL1QdPnnnq/qrUkB7wfA4+OFsk3JqeL?=
 =?us-ascii?Q?w0uJMph52qtVdn/n/ggBT5u0wiAV8vZBugY8hut9t0K2EXu3+7+AYxJ/8VLT?=
 =?us-ascii?Q?d5fPRnb+FN4/vFX1bVufGdF2+xC4AJllFshfnBs0r+Q3YYtL8JHdKZB76P2O?=
 =?us-ascii?Q?55nRBaYiHduKgf13kNZmvWaX3uFdiWUhOUhqKpKtjS5K1dlBXKUMHCFPtrWn?=
 =?us-ascii?Q?gq/+5j1kigCv5ufX5JO1ctbuHKe5aUahFVJoAbtX1hT6nDl75G5ygXnw6mHO?=
 =?us-ascii?Q?NW/+ze1NhzTdESZfk+gSirDGwL29K4psSrUpc9QbnXTlFXa8QNPXYPAFOLV/?=
 =?us-ascii?Q?u0R5YRQJieAwMc6X3NbmrcOoZ0rwUH5/gy2nu9p+LV212tpBoUUcOw68KcZe?=
 =?us-ascii?Q?hkgRD4BxrKm65WNujgcah7gQ4TnLLg+zUxZkVH5N1d+kso25RWw2xSglZC1A?=
 =?us-ascii?Q?WmhLNNQYvjoQJCGGbpZuJEq+R2Zprj6B8HNrkrfhCVGelamAD4EGYMPbHtND?=
 =?us-ascii?Q?kYBLiGVUqPiZ+oZeWqOxYPp+6JESME6l1A5O9HgK+JMxzjXQvUM1tyGqhdAh?=
 =?us-ascii?Q?4f+MXGhZetsctxWtGWw+0zLiGdndQdheqQWuJ36pXdfOOMIevABFZrTD01IQ?=
 =?us-ascii?Q?rvHZu0n0AcbJB3ECVRM++a6XQVTkrEBpZr3Q8s/2I0ZwkqXaSI6xsp0RdEdG?=
 =?us-ascii?Q?w2LcNrrgEgt6YG/hBzEmNTn5IX3UNAWqOQT+f4+MPZJi+hjfma5owiwM/9Ak?=
 =?us-ascii?Q?2Uy8qv/nqwjczx0hBO8VTOAuLAvEgtK/Q+pHVn9ds7ND+prDWO0l0mIx+fm+?=
 =?us-ascii?Q?wBdj9UbqzjKBnXVo2PCvMif+F3NnOdtdw31v+kDQTbPex7cWr3Mhopo3q6Tr?=
 =?us-ascii?Q?mZdD6G7b4vpo0s1uHLjlJQP+Onm2RJv1Z5b8aYpz9MDoLV1hA8N6Anbq3BHS?=
 =?us-ascii?Q?VXYSC66aCD/7c0tmLDTt3vygpvZjqY4ZAN7XGsCfSejKgxv104+H2k+QGr6F?=
 =?us-ascii?Q?qFsRiXbY5ZNP+R9dkxZeLUn0t6S/emREl1w7k3RQSNjdI/nwcwV4ES0fuGMu?=
 =?us-ascii?Q?pl3SZ5kcJwsTpkaLqXMbu1RDEmvPv1RVVH5Cbw2YvnMCF0hvoTrWc5h2zjjK?=
 =?us-ascii?Q?3sT95QTODSgIF2J7ZEdLQGrpCbfNlzuj5YNZqLhywIvIFkDI/eGmhrmXaoer?=
 =?us-ascii?Q?SGMfdNxOl+T0yvFYlRnkC+bDCsloiLOEutfh4BFHDG1b9qBhEo9XMj/+dJgE?=
 =?us-ascii?Q?9YGne0QaE9Pdm0taE7XmuIjKY6X4xKOARoYchtJd83iUUq+GIYux5E/8nBLV?=
 =?us-ascii?Q?Gv1pQXDIx9C+DZh0rxOG7l0qZ4xOJ99DaFpdBGNi5pSE6H6ewT8uK7QHYqPH?=
 =?us-ascii?Q?7UAM1LlS4JJfhLIu64yuZaErn3KjfEkGUTEl4KmG5X7DuqDzPcz65fqff6Y2?=
 =?us-ascii?Q?i2hDN/zUPx2VTLSus6NhzPJwaYJ8WNuzZi+Zy0LpqLPuyyRGuMmOYAVWhQoA?=
 =?us-ascii?Q?nCN0B0rMxIRysCywPLrxV+lKb6mSeaKNZcpF+yvDwr3ADOnMn2fix/f6VBGG?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3bd7c6-120d-414a-915c-08dc21fcc46d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 01:34:29.1875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAF0+HuvRuq8TENy8691ZfK+iNpYiuQMD58OJAJkt0DwRcG2o10nbqAD14M4czwkkHGsXvZ0lUHlN01xe0jtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5428
X-OriginatorOrg: intel.com

hi, Kees,

On Tue, Jan 30, 2024 at 04:23:06PM -0800, Kees Cook wrote:
> On Tue, Jan 30, 2024 at 10:52:56PM +0800, kernel test robot wrote:
> > 

..
 
> > while testing, we observed below different (and same part) between parent and
> > this commit:
> > 
> > ea804316c9db5148 660787b56e6e97ddc34c7882cbe
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_arch/x86/kernel/cpu/intel.c
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_arch/x86/kernel/cpu/topology.c
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_fs/namespace.c
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_fs/read_write.c
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_include/linux/rhashtable.h
> >           6:6            0%           6:6     dmesg.UBSAN:shift-out-of-bounds_in_include/net/tcp.h
> 
> Are these shift-out-of-bounds warnings new?

no, they also happen on parent commit.

thanks a lot for all guildance!

> 
> >            :6          100%           6:6     dmesg.UBSAN:signed-integer-overflow_in_lib/test_memcat_p.c
> 
> This is new for sure, catching an issue you show below...
> 
> > this looks like the commit uncovered issue. but since it's hard for us to back
> > port this commit to each commit while bisecting, we cannot capture the real
> > first bad commit. not sure if this report could help somebody to investigate
> > the real issue?
> 
> Yeah, I think there is an unexpected wrap-around in test_memcat_p.c:
> 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202401302219.db90a6d5-oliver.sang@intel.com
> > 
> > 
> > [   42.894536][    T1] ------------[ cut here ]------------
> > [   42.895474][    T1] UBSAN: signed-integer-overflow in lib/test_memcat_p.c:47:10
> > [   42.897128][    T1] 6570 * 725861 cannot be represented in type 'int'
> 
> I'm surprised to see the sanitizer catching anything here since the
> kernel is built with -fno-strict-overflow, but regardless, I'll send a
> patch...
> 
> -Kees
> 
> -- 
> Kees Cook

