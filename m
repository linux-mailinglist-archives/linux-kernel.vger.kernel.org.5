Return-Path: <linux-kernel+bounces-99854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CF878E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5561E1C22219
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B971EF12;
	Tue, 12 Mar 2024 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdt/g/wn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFFD1CD33
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 06:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710223240; cv=fail; b=XIbWWZxHXLjPlxS1L3T/MJ9IQix+RnUNPr+OIScTX9Po3ggBIM6BrrC2zkN79Hx6MblGvPEbtFv1USvIPuJldKSquasrCHSjwpDlGNmO9ryCca+iWpGJx2mZnRwZfYs+aV3otjl6fSznaDukLJUTbFo6xdEgHLpDX0GOiWgGc4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710223240; c=relaxed/simple;
	bh=NY3q18MsjVTdAQ1CMEVYLj4iJRV6T+4nUuVU9/AK7lc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=inIae52vJFnAOV0G6XTxyombT4QfOh9ohCIra4KQ2we7+rXkX9qDqcEser6DGdA/EE8EvlpqzX+x5YT5UaFukXFy/MRsq06y10+IJrZO8+XTCYFlcJOUbQfld9h6b6fiD0aT5/ct1RkFoEeEKc5BJzdgvWWxo6JikSZiudFTF2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mdt/g/wn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710223237; x=1741759237;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NY3q18MsjVTdAQ1CMEVYLj4iJRV6T+4nUuVU9/AK7lc=;
  b=mdt/g/wn4Y6+KTHE0u8Avn7gUp4UsRCkIULuiw3quq/X8TD7Nor66jRS
   QFBbJqHpkR1l9JV9xXHYeY88mwK7ihVNvoQV8Y4OR2RPHKKuV6c0N9MXo
   H6IBrDXvoTVUtF3vqP8gtYnF43Dhz+W3kiWKoAYTPae7cTQwo4n2dGWGl
   MR094EVsYFdgwpyJ04PlAl982P+RGXMEHCVt4uahmuvGXdwzgWsN4zRuh
   WphFH1oSz5XsfsuDDmiAbiktNkocTyEF9pS966i4e/HsfcfImDBIXM+pG
   liujbwuZGilNbge23Aio+4CJ01+6eGy7t3ktzfX2bykV12PtXTWRjos/S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4786948"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4786948"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 23:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11868956"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 23:00:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 23:00:27 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 23:00:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 23:00:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 23:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPjlpfXz2AcI0dFXfotIPGkQfBCqe2T88E1+0cMo3Zny17B8CBVmLcwwb+PN4nwICCnLhRIbeI73R8NUaQUgwvi6kD3rfblBjgfpBrAWwvpAgzzfMose8of6eXNNmSFLR80XkPErT/ls0D8BGppmyP+xbfPzkQu7T+AdpCsFZ6vFxIzQHnAsU0EOPc4FOndI+OtZtXRleXzURtMfqe8tWIeVT2T3FfH9X+u8CDFWDZZ9iV85PhZh32g79XQrEOxL1RupeFb8bdERxf2crRF/E1mIvsDlr2DAuhJ7zBq5FNvvveMsQNp6SeDfgjtH4wbyRob7bOmNLPiXvIrH0UhEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+iSWjS+11OzBRZj+fNY3f925cXTWTfpf5QSEHHeBXk=;
 b=eEDrLwF7r7VoZSvAbqyU6L+fyZpT3fDDpPWeo/4Vt7aJJY+GZetSU63AzX/RgX9tLel4zZwDVbk0b6t0U8kw6hxiH5McOuy5Vw8N4YG0X48XEBVUovpedEx/s7LdpQqYuWd+JuSkj0FLPbK7wIq+zbmFXrwHLF54T8sAA2Sz7KfA8hkdEZVrxsxowk+E0mLjqYebUkjYV8Phzr2y2PVJK6E93G6dWXib7uTcRsrQziCwCfbCyUb7e/tMgQaas+9qHl9Gt9cMDX0ITwmgWXKF+NNY7Qsq0py3GjF6GuZKLQqkvh8CT/e4czz+sgNk24tkKFNkF6Q+tUjZhm28ANUOPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ2PR11MB7548.namprd11.prod.outlook.com (2603:10b6:a03:4cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 06:00:25 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 06:00:24 +0000
Date: Tue, 12 Mar 2024 13:53:36 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
CC: kernel test robot <lkp@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>,
	<oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Luis
 Chamberlain" <mcgrof@kernel.org>
Subject: Re: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references
 kallsyms_seqs_of_names
Message-ID: <Ze/t4Ks0VfCBCXP0@yujie-X299>
References: <202402061302.HkByW9x0-lkp@intel.com>
 <bd30f81c-9e6a-578e-d496-6b7f355a3b79@huaweicloud.com>
 <efdec661-628f-2f6e-cd3e-c66a915d3aa2@huaweicloud.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efdec661-628f-2f6e-cd3e-c66a915d3aa2@huaweicloud.com>
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ2PR11MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 4735bff7-4d80-47cd-f36a-08dc4259b542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVlh1ut/3htQ9SV13ZCpfwAeti9vPBZsgSuRct7dv/Rt8gWVzT07wlrbppoWbbrWP9Yu9EsES8nkCHq10tjuGnfvrjvwFGQ4qSJoFn/cDBtvVr0eB7J+c3s2Q31WZJsq34fYXFuEWao9692jL0sGUcOK6Dvt4RpQlBP+mNQzjHOHE+3dTgRFpD1H+psFPC5BLV4hnnZb0U5KREcZ2zxUJkuRjOIGxVC+AqSvEWjC3BlmtdVlwviWaszCaCUgwR3qcSFjpXU4CiT4xwD9aB4vDOJFCosHMLbhdFgE2QZvDz+fU2/JxSTKYd07zVp+A7h9mAvXgW5o+EFg0K1Z2APsRbOdRJOB1l2e+NiSZjCDvD7g4M9OQVxk8+QS9IAWVnv9dJrKTwZElqKsyhmSWYo1gLNewvev5eywJsXiVGQqWkq0E4QNDjnOFN+D3GrBmWbvk/YM8jcyi0YBkWKf1n0WD8+ZhTrzpc1ayM8MDpfzvjNzAGcotS0vhJfqE5T+pr7j/CzXVZIXBD9abcpJepHrpVsSpCHyBLzlPF1X610UPvCEzsrgKfxg1V+xNkMiqqXAD4oWYf8BFxKh6xllAGqKeX1dCP1fxaJyrV5pfTY7MLUw27x3fSg0Y6V3ZY6TQx2+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2m1bvlBHZgJa2LeBf0l9HJsUomij/u1KOGElDlt6tMTMb2wXITMtmt7JVyqp?=
 =?us-ascii?Q?NX0ky9odrjiVQOn76Q8pEUne0cT8FY3D1mysjnS+U7lUblhmrvY2GIOh3D9n?=
 =?us-ascii?Q?r5Tq7dayVIteAvhPjIxosDWaLa9EACLwsgq8MPbvAAUtEwkQyDITrxbadsyQ?=
 =?us-ascii?Q?jKSPA5MlUDAZd2lz8TkdwOC/DMijUqmWwjyKqXGWRgg8UW4pYay6y7mxfWPr?=
 =?us-ascii?Q?t43dnZXuLPPiVRYzCvSrVO/LuRLOibK2fsxP1rebpAhw7sXop4sXpsctvEf0?=
 =?us-ascii?Q?BYv5VxjN5c/7kMLGYbC1Bw+VLplK1a+y/iMDdObzbpmRgSv+prch7pFkl0nr?=
 =?us-ascii?Q?OE0QXEEO3FRmJP6YEXLDtcYj+LS1FXzbKKJJkagczWTo47Nv36U5/7uTpdoa?=
 =?us-ascii?Q?bSJo4NHfgkQIJy/i74HbVXdaXm3Yjy7mokTc9eJyH0IR/RxWNgfcueUMnlkY?=
 =?us-ascii?Q?5chYXCqU+as5peRoA1OPMA77yW9iTjeSs9NFaNSnkGM2iwCbfnk2fRoNe8YW?=
 =?us-ascii?Q?x11rTbQwmmxJ4ujjCggFolySVrDcQLBEDnPjocluf0fx9KKHAx9fsypy8g8K?=
 =?us-ascii?Q?1GcxB3JIh0L9z/z4S5/eb82ZgEoF08ZAgu3MVgp1bs6L6992JKclSv76cVed?=
 =?us-ascii?Q?xssqTYgXhASfxSkJ+qKAYEikPp1tZ7WEFDLlMklcu/vYuwf32eXyQoiivhVC?=
 =?us-ascii?Q?ZvMSUQa8WC07jQJp76lMSo2gghcUhnn3D5NYU6S/jOu6oZL+zWu9dFbvRiPy?=
 =?us-ascii?Q?wEZFvUprlFILqxR0WLBo3u572kOCGCacbhRUDHqq7nPbIQVDxFQyibiGvduT?=
 =?us-ascii?Q?xg3e6816UruXcPOAqCrNBwQIoNr0XB3gAjmSr1mc8q3xP321qzi0ZhThwVU4?=
 =?us-ascii?Q?p1UnPV4ogxGkuW39HJwSzVZSt+yC4t6+T9IBtLDhvSZeZmG3Nh4RsuKWvfEW?=
 =?us-ascii?Q?S3fXQpznXwDUNCBRXD7K1aT6xJ175tt1cTNpWcnmdgD2Bxiz1UzUu0ShNMY3?=
 =?us-ascii?Q?R+Hb15xHO5Gbphnwz3JVg5xlxOm5/3IYJdpne78xCIVgN0s3J0t9IwUsx07s?=
 =?us-ascii?Q?aOFoR0GGadfsd3DDBYzmuh0NWg8pMzIRbxA8KtLxn+cxApB/6sBpFIQb/KiB?=
 =?us-ascii?Q?18ZoHzCgvCQ0yXRpELPZjP8QTIp12brrsP6j4htESr/Ewe5UybmIR12elKF+?=
 =?us-ascii?Q?VoGnhjq6hjbWdUSidmkB6LwPlfPx5YCmdr8F0B9g6u2xpTZXGalN/2i6FU/n?=
 =?us-ascii?Q?fzQ3tKTu2stLaa2Ktt5N5i12NRdjumhrBbGrptls5IZLAHBQrTjFspjXLwww?=
 =?us-ascii?Q?xrLq4leR1lVweTNdk5aSGAg70rSKXuc7vY+zplGfAUnfUvwrt1aMuv9Y8o8h?=
 =?us-ascii?Q?Nnlrd29eJo23cjVvczy/V4BpBX3fCrb7LqLv15OUXLTQQHP3iPw69CW34boM?=
 =?us-ascii?Q?b31VwszkPXQBCa3YuEniXjXPRSqUUbbhgMPRiRBzHCvBEmYYSpv43Y7BMzlz?=
 =?us-ascii?Q?xYbhyryovQ3sRVGgo17AIAQbJddvwigNbo+kW8fTZqLbuPfhrUMRevyLZPni?=
 =?us-ascii?Q?qmLMpuPDA7bTVFExx+od6TD/khgXIaOpC/1Ya+X4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4735bff7-4d80-47cd-f36a-08dc4259b542
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 06:00:24.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vku0xgXnyOyyedO5oi1c+TD8VsjBjpK1nF9txJoKsMnToDD7Mvg1bOzKvY3G47SqI6cjvCOF2gCtGpU9qH7f3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7548
X-OriginatorOrg: intel.com

Hi Zhen,

On Tue, Feb 20, 2024 at 08:27:15PM +0800, Leizhen (ThunderTown) wrote:
> > On 2024/2/6 13:19, kernel test robot wrote:
> >> Hi Zhen,
> >>
> >> FYI, the error/warning still remains.
> > 
> > I'm trying to reproduce it. But I'm having a little trouble getting
> > the environment ready.
> 
> Sorry, I tried but it was not reproduced. I made the following two changes
> to the steps in the 'reproduce' link:
> 1. Put linux and lkp-tests in two directories of the same level. Because:
>    $ git fetch --no-tags linus master
>    error: RPC failed; HTTP 403 curl 22 The requested URL returned error: 403
>    fatal: error reading section header 'acknowledgments'
> 2. Compiler was specified by following the prompts.
>    COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>    COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-17 ~/lkp-tests/kbuild/make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Sorry for our late reply. We rechecked this case and noticed that this
issue can be reproduced by clang-15, but can't be reproduced by newer
version of clang. Not sure if this is a flaw in old version of LLVM
toolchain, just for your information.

$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang-15 ~/lkp-tests/kbuild/make.cross W=1 ARCH=riscv
..
  LD      .tmp_vmlinux.kallsyms1
ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x70): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_num_syms
>>> referenced by kallsyms.c
>>> defined in vmlinux.a(kernel/kallsyms.o)

ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
>>> referenced by kallsyms.c
>>> defined in vmlinux.a(kernel/kallsyms.o)
..

Thanks,
Yujie

> 
> Image is finally generated, so there should be no problem with the above steps being adjusted:
> $ ls build_dir/arch/riscv/boot/
> dts  Image  loader  loader.bin  loader.lds  loader.o
> 
> By the way, all the symbols to be reported "relocation R_RISCV_PCREL_HI20 out of range" is
> generated by the tool kallsyms (scripts/kallsyms.c). So, it seems that the tool kallsyms
> have not been executed. And this error is not caused by my patches.
> 
> > 
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> >> commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
> >> date:   1 year, 3 months ago
> >> config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/config)
> >> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> >> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/reproduce)
> >>
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <lkp@intel.com>
> >> | Closes: https://lore.kernel.org/oe-kbuild-all/202402061302.HkByW9x0-lkp@intel.com/
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
> >>    >>> referenced by kallsyms.c
> >>    >>> defined in vmlinux.a(kernel/kallsyms.o)
> >>
> > 

