Return-Path: <linux-kernel+bounces-111666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB722886F44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF491F23EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1473D524DD;
	Fri, 22 Mar 2024 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns5fNG1h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B14D135;
	Fri, 22 Mar 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119495; cv=fail; b=R+SwjgPJG0W+errna8OUeE1QHzZMN4hZRZbEtGfbjQ5NkL5JWy/fCoiwShr4fSPzTk6oS9+LSIrZGn3alYlbBkf2HEczzka4tdZ93oSSjLJ+8yH8PQYtdAegD026UtmC55NX6XYhprUA4uageCtzWq4VEcizkDtU9/xO9DgQaJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119495; c=relaxed/simple;
	bh=LMDfxFuhxbptA6UjNY6xQGEiL2tLZQVey516PjtazbY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=azagUYsJM0/zukyAR8BAS1biXuPeLbkah+JiWfxDpXIL/nadTWRFttgKXW2oyicbpC226mvJaRvVVj+iP8HsHizng/C7OhfkFElSXS7VVo4XUr7iLNP/plEY3Eu0eEcSyYF8OYYStX+vsJKwlUioMGqg0/PnYWpz5mzkLSWHRO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ns5fNG1h; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711119493; x=1742655493;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LMDfxFuhxbptA6UjNY6xQGEiL2tLZQVey516PjtazbY=;
  b=ns5fNG1hi6EdfV57UXvuwITdjQ0oxQuBiivgBkpwMp6G8MZ3etBuctXV
   fMF6ofQYN8Y1hWPKuhhKHQ5rpfyJG2VRnZu+0xTq4WacZ/w9tkx9mLoYi
   6nogdAE2PDpZUXl3UOnK4GZPJUmgCFhNjS0Ocz8yppQR7m/UpQed73EiE
   Fy1ln5ygHQJBMiLNTwxPAFhzegAU/oqO27X9uBMb7EB94S4QooC9Yq/80
   0w0EZr9yBnVAyB2ZKy0stDssjpHG+sutdyec1V9BNZ0Hd41vZw2J9XBic
   pP5BnQpwpmfyUt4K4kET3C59UrsZczQ+xAoOg9RpBuzTCa1/wLSHIesCt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6034366"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6034366"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15039481"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 07:58:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 07:58:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 07:58:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 07:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkkzUTLk2HQqwPL2hjUczMWrBuullbRLCAQjojXcayY9GUc0rEobeXjnWalYp4SO0hn9OlsmsGym4rQ5hNUQGk3HTS7zZy1Svp+RyEgOQcJpnxWN+zbkWbI+BmVzfUrXZOi6k/0YF8/lJ1GirwuN9FT7EzSc/OMPuM3qlcUl3UuU+SoFIZdaE5WGumliixaWwZaolOc1e1LHX3rvekjnOQzmhLgX9+bnp9uKJ8sjQGj1bxmInq1w4pg2sb3tnNrjzi6YzQ/B2XB6xYZO4KjdqpJVwDJlFNsMcpxNKROpc3m4eGmSsLZMff+DPF8GbOL0/50G0pllUpOYLAo+Jkb1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAuJFUaIqoeEO3airQGbF9IcZQWYsPSAfuO9SWl8710=;
 b=O/E5lSj+x/uVUW08k+CuUOxyH/kWDTFBFam/+I17vcEBTHa4UxlC9uEMBq0D8/DxpHNdeH83x4bQ7x4DhtfJFX0qsUxcIZaQq0suw54fIloG5ikuO0IEABx0vMj1uDN83990nCNYigZAppbvCzm5e5S54hgM2roJuNK7ifTVhShPE35+lILFOtbHYQ6aeJ+PQ2TWqQNgWGhkKgbPOua/Akds0xwnkhTmFLlOYIjWw3PiRTiUPJrm4p7WxSaYCoM9c9Ri4/Mlak1hPQ4xodE7G6+PPIzfIc+50WoS47PreJwZzsZw27obfodJNohd+pt33KlYQMzL5/EVmLi/pf+wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:58:09 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 14:58:09 +0000
Date: Fri, 22 Mar 2024 15:57:34 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, "Babu
 Moger" <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "Drew
 Fustini" <dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <upoalex6pznr3aqsp7yvayt3ecdcqaoghlggctuov5domv24lo@k3d364ny3j5i>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <bn4wtfyec4mfoztcr35rctgcbibypjh5gmxdr3fro72glh2y3n@vmqsuxgjlonw>
 <SJ1PR11MB6083C9DD405BF4CB986822F5FC322@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB6083C9DD405BF4CB986822F5FC322@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d735011-17dc-4493-cba9-08dc4a807d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H23FPb/fajPHX+tZzXXFARKT1Nl6vX59Her4E9yd/ECs9OtvJK76laKFy69NRQw6BOazzg67XCTHdxymhjYvQkD6msU6GZvuXY5Ug7sySknyBAAzhwBlW6d+n3NbrQdafYL74V9ky7Uk1decc1s7lzi38P2QTrHDuqISS1lXUO0POkXu5kVzLyKMRh9HLMU2Pth4T+O4RI0Hz1TrdIo60yI3++owU7FH9h4Wcn6gL1fr/V9LH/sTfMMvr7tuwO0CphlJMDdCsdcbQAX7heSUlgvOkfbsxeOK+++5T4weX0Rc5UEzkOmd0Q9solwt2SKm2DJixAaJIJDFT8VyA0gjaOOjagdzwvWEWKJi/++RyOXzT3Qr3LlNLE928vxdXwDspNWUhanJvSE/gjoKkDPZ3OulJpw+QdUfza2VZbuIVrjp1JxvCwaysxWbEU1frFZS/+lSKULLeEIj64bNKm+9C5HD6/JlKfDCSH2PY0TQdQKSthKCgQrE0gPtsTzQZQ6Ii6WILp+dOdhR8df3Re8D6Do6ZtSwGFsdVoI6GAMCAcGz3rgiEwSlDWjSK4vwqPQqOFcLqCqjqudodCJ62kjV0A/tWMsawG3qvvaJQPBRW9/PbMd2XtNqjjEidvUPoBfxQH3eihe81qV0/uzyReStcpPiMG8lQKGA7uBcjD9gEXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kPIR9KL+vUZqDIDuvPqoz6eLchiieCqkAazI78c+ExtE2aKZJoKFUJOeA3?=
 =?iso-8859-1?Q?HH8uyGNQbrgyaL1DxUsPJpZZow50Y3HsED9AOsh1ADxjJNjvMAQB7X+d6u?=
 =?iso-8859-1?Q?0UovN/TWd6G0PcBpL6/66qWQyqTek7Gk28e133vZEqwMp7ItD8r4GH29Nb?=
 =?iso-8859-1?Q?PaHMp1I9TAH0oL07yZU9Auv4ApFd5agj2C6vCCC1vgk5aJRK+2uXN83CuZ?=
 =?iso-8859-1?Q?LziN1RyUScccT4i3mVMnsz9ETJse3i5WV9T2GUjLvjQ0qr125SQOvfYkm6?=
 =?iso-8859-1?Q?kGVkQDEyx+SS+B/cgOjyX6yvcVPDkGiz0jAIQEitlD1pISVnVfXeYGsp2c?=
 =?iso-8859-1?Q?grJ/mvR40jhjuiYa8vMJMkO7CobkRCbbclinpzZM4SIpobPfOtvF4tvAa5?=
 =?iso-8859-1?Q?uH9hFGP1smHRUm6xIvJjA81k6sw0Sxbcs2YYHYebI7gdDPkSW2tYnZlKGW?=
 =?iso-8859-1?Q?u3eQgO0fNHDSnMHOj2IuSrZU3zig6v/6kg7YCa+hGmrfDEfIJ+wxo6gPEV?=
 =?iso-8859-1?Q?CFKH/bZmgQJzfkw9g3FGBze3EzIjdU3UdPZ4jvkuRLZKVRs9oYUd19nHoG?=
 =?iso-8859-1?Q?Hyym0I4rdMatwYcsVXHLdh7j+IsV9eTXoEkxWAQQ/IaPElFpk9+P2ttpkU?=
 =?iso-8859-1?Q?XWVJ09M1Axx4n6fu0Y1Rk/UF7vpIudfMBmvQHYTSUymYgusOj2GXtxRP/Y?=
 =?iso-8859-1?Q?OSIXZ+HS2D41ZiKJTgpJ+b7YfCIixFmDq3xdKXEDAGwijVQAsQevX/zTTl?=
 =?iso-8859-1?Q?N1tDAs4xxYbcEcGxkr969ss2MkbuUdPSx5/a/EfJdBv7Q6e1k0+IO6rpks?=
 =?iso-8859-1?Q?SFGv8wKLBzjAyi1bj2XvH1cPh80KjVrS8FmBLwYzcMPF6HRIbnXsy5ZkUp?=
 =?iso-8859-1?Q?G4csUYvfqC5pn/VXgq3meT0RqvoxWTt5Jiga/V7qDLXSspOBEixFQEHWBe?=
 =?iso-8859-1?Q?L6IB7UP1PZKqdKvsduSZF2Yngi3oTgmua9Xamc8PPsGT++4ZXCfTddGh7P?=
 =?iso-8859-1?Q?IST0Ky/8dZPyqjvqAYANDpIp6E3SguK75spPOReYfBS/CUjH74d0WBNp+w?=
 =?iso-8859-1?Q?N89POUJaxVOaLAgeh4v3asUbOaxxZJDOsKMwMwuDD9uuSC/PE4uBPZE9BL?=
 =?iso-8859-1?Q?shBLVzeyRkzzOGOMI2QIguKc7Ev7iuT8+ms7+L8ND7OD7Z+d7XV1vVEfPQ?=
 =?iso-8859-1?Q?DBg1RNPhDj1gG3jmROrNX/ey8pKDum8go/kRPJsR3WyRIMA5o/AihJLbSZ?=
 =?iso-8859-1?Q?wOpiCkzUH/EeZOT/02NPXEBa5KgMeYf1OdYMFynvFbM5Hq2xbvO7gAJXkd?=
 =?iso-8859-1?Q?L3aTNrrbV/MMn3stwyQ+TQPcHjtGpDw/jhZzp1Sbopw2jx5GNHNTq1+yXA?=
 =?iso-8859-1?Q?mdDcurP1rLbHwgKTVwoBHCQSFmUGRqlTtwTaJoSB5/kR4T3sQBKyB6iK6w?=
 =?iso-8859-1?Q?zPkIQOviRdgmorio6z/lb31hTduCe9ZGuCDS0ni2oMNEkWmrnbaGqKhZFS?=
 =?iso-8859-1?Q?n6vFx5vhTDQMNPQnWaE+FgKWLLqSICkrIO64yMPgrYlHQaeEUCc5wRe+LU?=
 =?iso-8859-1?Q?OcJit0DsQahQmzady75wB9l9sqQWdxVEsJkfD5aJQUyiLjb283CYSCU3M9?=
 =?iso-8859-1?Q?lZV+xciXhCIjliHjkQKJsf6wRSTVjb0I6nzUsDat6JGBrsjjdvgVGSLbGw?=
 =?iso-8859-1?Q?izjLTJMUc9/GXfYtyl8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d735011-17dc-4493-cba9-08dc4a807d21
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 14:58:09.7657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbBKyTJi2I8Ne9c5y9CwzRgjYsO1T8IiYnaxE5zvStJP1PlUb2BJwZ26/wevYHPmv2CJdHziPExBcoBboQ+rjAYS7FAle/3qBuwaWKfIPsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
X-OriginatorOrg: intel.com

On 2024-03-21 at 16:51:51 +0000, Luck, Tony wrote:
>> I wanted to find what causes the conflict so I can give more details but three
>> way merging doesn't seem to work and git am doesn't leave any conflict markers,
>> just fails.
>
>Maybe there's something else touching resctrl in either TIP or now in upstream?
>
>In my local tree I built on upstream after Linus pulled TIP x86/cache (and a bunch
>or other stuff). So my base commit is:
>
>b29f377119f6 Merge tag 'x86-boot-2024-03-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/ti

Thanks, I'll try using this one.

>
>Then the two patch cleanup:
>
>b0eebe2ee45d x86/resctrl: Simplify call convention for MSR update functions
>edf14f3a6093 x86/resctrl: Pass domain to target CPU
>
>Then this v16 SNC series.
>
>Reinette pointed out a couple of things to fix in v16, I'll handle those and post
>v17 next week (based on Linus v6.9-rc1). I'll fix up any additional merge issues
>while rebasing.
>
>-Tony

-- 
Kind regards
Maciej Wieczór-Retman

