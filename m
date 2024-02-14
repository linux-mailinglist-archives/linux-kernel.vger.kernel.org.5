Return-Path: <linux-kernel+bounces-64619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3081C8540EF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6700FB27E65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A67801;
	Wed, 14 Feb 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ht+WzOlI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68079D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871996; cv=fail; b=NVQeXSiiMeTD3Lq7yttTs193mWTWW9ddI87BxnncO5uc6sMeNiteiLFAdtOl3/QtEkPki37fStABBySPQm/4cNtbUbfebVZOMpDQJPS0JIn6RxmZGZjzLwVDal5Tr6GbZHU0TGwGKXnYDEEP6s/TBXfbRw46VcLw0aL7kcAGmDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871996; c=relaxed/simple;
	bh=xUk7ibPdM+HcQum47qpHjE1ltw95UoWAVvSgdsJ+BQU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AxwDSJDIAfNLaJdd859uQ+obmzPw2yHeVbAl9QijIsFlCOTIpVaqJhNObf+jzNj63jqfxT01Nv9SVX044meLK0zTSvs1m2oOIn+L+mpPDMYJEVU2BWju0cNPPyLFr6adOIzqgh5w69S0R0eFibNGgi8k/55u/43yn35VkQ1i914=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ht+WzOlI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707871994; x=1739407994;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUk7ibPdM+HcQum47qpHjE1ltw95UoWAVvSgdsJ+BQU=;
  b=ht+WzOlIMfAsiJF6koHEdZ16a7ukBwhm8fXv/3ltuacOWTm0aP0dFygv
   52rh9cT+saudJgii6AZukCDpjTZii9jGsLdzKFX76Ug1HRBD7449k1SVl
   5LiLa+2gPo6+/EEr3jaUvvJY7N5rl13LcojnvrWQbE3a7dt5tF2aPfOx+
   8+yuOXHwVxeLfQe9bh1+2BRIxg8uMNZxYBdG/iZgvpiTUxahMSoPo3Vu8
   l9RGvJF07xTXxiKgPHZ6pw20k1KdKBXbP/Usjwx7zuh3MyP3Tdp0K8sTH
   r0BsR3CeNQYbqVyJMmAVJbGkPmr0f58dWF8uR5A3WJ2LFvYGQejukkOdL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1757658"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="1757658"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 16:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="7796080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 16:53:13 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 16:53:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 16:53:12 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 16:53:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOZL+TzODG7DuTt+m4pdWK4Sv3qPwi/hmavcIH1oebSgcudelJVIyUYugcixwYCZ8MZKIZn9B/N8IlIXeFsMZZ9syxkeryaofrTxU9vIVgTTRG1fVpxxOjZA8t4H5I5fFQSa526A+RhqIoZ4w1vj7z8piRqL8+Wkt5lJT0tlxZ6BqXK5mqma9UNPUmx/NLkJ6WBv4fcAzuu9xdn8+RJ0Nv7a1xM7BfHd+UxDFTEDvu2Sk+Om3JPd8kKP5465BoVLPaG8N9btm1xBOGRnaN1+ONrdnXH56cRw2CKqUJ65sGFtpqlKg4NBR/e7bcaUJu/ER+j26QHebv2C6YsWNlMKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey/9nmrmenI2tJOJq8WUkMwQ6QMgmcHY5+o7WTD23+w=;
 b=Wsf2SolGtZgpgitsfCsQZLsYrGBP+EsUGhFzNgIQTkCnhru2wB20WDO4MzHI96SM/n7LCW1CIyPps3kw1pYMSarQ/uV9bAkmPAMf5dxlK7hlsVc6ge6JeNcclxYGBeUX0TsuZb60DB5Np2zS/x3niTJd7+cjNYGz9qnAmoW7yQAnbpv13UZp0S0ZJePN8MkE9kD0+TCY+qA1ruffE6oolriJBjFcqWMB0b4wQ0gaNcNSu0adGcGutw7BXd4bIRvd+MogPx9E9RwsvGMGe1jSgF+TERHhNWXRKeaebFMMoOtxxFxyhEHLFNIfOIBPgnghinGLDpCkksKkbg9M0CuJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 00:53:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 00:53:09 +0000
Date: Tue, 13 Feb 2024 16:53:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Theodore Ts'o <tytso@mit.edu>, Dan Williams <dan.j.williams@intel.com>
CC: "Reshetova, Elena" <elena.reshetova@intel.com>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, Sean
 Christopherson <seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
 <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240213231341.GB394352@mit.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240213231341.GB394352@mit.edu>
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 792ab746-47a6-45c2-f993-08dc2cf74fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YQVky8T5Ll+J1GoTL5kKzpUlXKw4XHCFvGu4KBqaW+tBeNU0L06es5m3VFCK1Ednaw/qD/Ia/sphInxztrPH0l3htTAzQb8NsqIo8Q7xsl8jZ4C7qTrurvAeC+gB2vZoYQDbwg6ZV13bDJCW0yG+o6AMGLEqzYYffNYqVCB/ACaG/SoQhNNw7o2s+cRUV4LWwKHIrYf8lxNtmATR5zqcG4Z39Li+90nmK5mj6wM09yV3gYOsBfgrws1Yhp8UrPCNOFCtwioUPv5m+O8eXMi/FTv9q1BAGEJPYaDfdzJVtBOhXaBR48Mmh2kBGJPTZKoenS09p+s87MN0SWId5nzAktNLE3Wgn7LMwZud4C0YDElCBgF7WbRrd4wfIHTg18vJoFy9x2FijFYzKstk8v+iuYKlAvLaOiNv6XB+NP+kjMwP7WyyJsONScMXGVhRhtlSiJJ3LAXfhWg1bBwV+oB8HanGJSo2Q4Zf3dulAGUMZB86St3hD1VM6ODnpUyArfOuejCwJiZL81gL/fnLLfsaj7k4ylvLf+dyqQZ5TgcJg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(82960400001)(86362001)(38100700002)(966005)(6486002)(478600001)(54906003)(110136005)(316002)(6666004)(6506007)(26005)(6512007)(9686003)(66946007)(2906002)(5660300002)(4326008)(66476007)(66556008)(8936002)(8676002)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpqGlCTMWydgkI51pxgVYKX9j3uD+eY1JY3JRGl2iPqBfphqyoqyrDH/C53H?=
 =?us-ascii?Q?IFLioS3mPjVmLueqrUHgSMtRHR/5ZMQTziGyPaJf4/PYWZDfWsFqme/sLWzf?=
 =?us-ascii?Q?dWavig6IibcPn3eQnW6n5bZRKv5rF4I8WffNWmuJTFPVZdOXMvmYXeeJAmvr?=
 =?us-ascii?Q?DK+tZKcyfozjEuaX9X5DmZJIOL29wwLhMQmqT2Be1+JkwZ5laWV3lhI9/I1v?=
 =?us-ascii?Q?Dbk5kOJi0CL0BbQgq8tLyDANrKERuN55d1DI1qMD23f7B0jzj8Mg50h1Teer?=
 =?us-ascii?Q?Ty/P5qGLl9p3TlLxSH/QTaCAW2lUzXviYQuUDYR4os82Br2sTLq6upydylsC?=
 =?us-ascii?Q?c/4ha5R0krm2fiRFlWWan5U0RcFLwCHD+GclccXzfaJSXcsV9u1a/VraQt4l?=
 =?us-ascii?Q?4AzdBDNrL+DFYpmMBYrpiVw41nGDuK/TQ7qDjj9FJEhHTBXybrEPA+GU7azq?=
 =?us-ascii?Q?DGhmLnxJK8yqLQRcly90CWiWHhDyihvQMoNzlhJCsbd0J4LkywvLGTR2NyUM?=
 =?us-ascii?Q?n24wrYcEK8acN8FrkCGcmeLamCLqYwgi3MiC8cf5cKvu7Mr51fEt5ltWpIgY?=
 =?us-ascii?Q?kpuHDc8gvYNDYmz25UUXcEMuB1UtB9qbZYlJGIE4juzjxs0nQ8TjA3cVkqSF?=
 =?us-ascii?Q?FprYZKCqXXM/IypXkUiQZi830XEyFo0j9CpSA1XnEDJq/ZIvPH3QS1NUu0c9?=
 =?us-ascii?Q?A7GYsR7x3FhiaYnvBYQ6JsD93/BupKuTpTlKlRv1SQOieJcEX6mcWmlRLR+/?=
 =?us-ascii?Q?toMslAQdX0oCPnpXyxejxUOgbSSqfk/2tEvM73Ezbq8ZR6EPZUbNiZ4FX9+P?=
 =?us-ascii?Q?wNR7QgWcC6w0kTSxmybhKBM0u9LN1gi7J7pnt/5StvJvfRLE9cck8bG+gI9W?=
 =?us-ascii?Q?NqqoWCLgTv0mlaXfJVDdnUEQyHdNeVGwrkWNA0VMzy2ZYnPUYpdc9D7Q/o17?=
 =?us-ascii?Q?chh39epdKp5fZFo/2aKkOB+iI3+REDge0EokHnzSJA31otQDvfOv1nUntVPJ?=
 =?us-ascii?Q?BNC5YV1tKpucNNgH/VRf6t0LsreSl+K5xx6OhOAXt8LTOVZoSW0qnr5O9aRF?=
 =?us-ascii?Q?thvGazMxM7ExgCzQf+yzMPtZFOQ5g9HXBbMjDf+xuTi4qXMxw6PVg9TW5LI3?=
 =?us-ascii?Q?/u0XwERMNygDJGgyKQjssuOGmj5Q4qqFwXmwdEqAem54iD4glqjRDR+wmeEl?=
 =?us-ascii?Q?lSnQb35aaAWTm5tmTVSqnB/GMz2btiVtLlFSKryybyi95QWtX6k+LgnyWsDw?=
 =?us-ascii?Q?vg5aDCxa2PEHUFn4EJdSqG1NUxH/FtZtRkvXAHT/zf08ZZfC4Ehoo9qjOOPm?=
 =?us-ascii?Q?a4P2ZliUcB8FbldfJGA8WBGx1V21UwtzjquVP/9l4Q7lHlMMSPvu9wUMnTn7?=
 =?us-ascii?Q?Q3Ep/mYgJfC4+DUxD2kvIlcQebUpripq/F8xNs6KE/Ea8CDIJggwuqCBnHIS?=
 =?us-ascii?Q?V2wZHjFhEcuk3uAUAIByo0dVvC80j5QTwohG8GSPVPb7fGRDZN+U/Zg6u2+L?=
 =?us-ascii?Q?77JB3mO067ewWZqPMqVjVTYr9ZDai08nvIfFhwC6KLhLUW2ol+kqLHBgoPIr?=
 =?us-ascii?Q?hDgwWkeKyOzKw1gOhYihtUfypdxzcdtfwBKwDPJyI1qEV83xB7rAq2dBms19?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 792ab746-47a6-45c2-f993-08dc2cf74fcc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 00:53:08.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2UWZak2vqU49PnaU3RPZdbZaEK3I5XUrheH2ucU8iISlC+v5UoO9VHLxibGwHOCqTj5NmdHZrDmBizm9iow8IjSpRfPkwOGI9LwCrw4zLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

Theodore Ts'o wrote:
> On Mon, Feb 12, 2024 at 11:28:31PM -0800, Dan Williams wrote:
> > Sure there is, that is what, for example, PCI TDISP (TEE Device
> > Interface Security Protocol) is about. Set aside the difficulty of doing
> > the PCI TDISP flow early in boot, and validating the device certficate
> > and measurements based on golden values without talking to a remote
> > verifier etc..., but if such a device has been accepted and its driver
> > calls hwrng_register() it should be added as an entropy source.
> 
> How real is TDISP?  What hardware exists today and how much of this
> support is ready to land in the kernel?  Looking at the news articles,
> it appears to me like bleeding edge technology, and what an unkind
> person might call "vaporware"?  Is that an unfair characterization?

Indeed it is. Typically when you have x86, riscv, arm, and s390 folks
all show up at a Linux Plumbers session [1] to talk about their approach
to handling a new platform paradigm, that is a decent indication that
the technology is more real than not. Point taken that it is not here
today, but it is also not multiple hardware generations away as the
Plumbers participation indicated.

> There have plenty of things that have squirted out of standards
> bodies, like for example, "objected base storage", which has turned
> out to be a complete commercial failure and was never actually
> deployed in any real numbers, other than sample hardare being provided
> to academic researchers.  How can we be sure that PCI TDISP won't end
> up going down that route?

Of course, that is always a risk. History is littered with obsolesence,
some of it before seeing any commercial uptake, some after.

> In any case, if we are going to go down this path, we will need to
> have some kind of policy engine hwrng_register() reject
> non-authenticated hardware if Confidential Compute is enabled (and
> possibly in other cases).

Sounds reasonable, that recognition is all I wanted from mentioning PCI
TDISP.

[1]: https://lpc.events/event/17/contributions/1633/

