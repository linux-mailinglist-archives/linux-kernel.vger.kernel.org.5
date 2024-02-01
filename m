Return-Path: <linux-kernel+bounces-48711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4996846010
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A18328410B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA682C96;
	Thu,  1 Feb 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F837VsJT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9B12FB2C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812643; cv=fail; b=ud4Ye9Za+tWk9MD5+sI3kEwlCfoqwIucfn9dBdc5EacJcJXJ/5HLKrFO1/+uIEcztjLjOQzlqte66BszTUngFA5dcfmHGQ4JFtQqHuRZ/Y/3Ksd3QRNtyCdYvpO7F3Z9apeYwqSzlqNRLkaTgeZ6zI1yT65EPlvKYop7fwLniBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812643; c=relaxed/simple;
	bh=Qlk8WqqWaOr09B4uClI0KPIYvBv9Xf5ItAeCjilUpGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nVUo5bB5D98gosgcuWPjxUDBp5qP9QOVAgFtj1YleVUTCTA4N40diV8BEx33hdZjgVibuoZPJaI4JHWwDkZhZHCxLaBXegOJ5TGLnUaDqA8QaWBhYC4u8/7GsPIOt99kK7NZWNGQZGIPK04xtinXvjlKdjBqaUJNbVEjN0sg3zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F837VsJT; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706812641; x=1738348641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qlk8WqqWaOr09B4uClI0KPIYvBv9Xf5ItAeCjilUpGc=;
  b=F837VsJTpZ8p7fD12F1YUVFz2kiK8THdjV0vUQnkggB9oKu4ExmHUzwh
   sMai+8lxBAa7/+cMl8j2ZWKAiywRPDf9bBVblsShXb0fStjheblBTSirb
   ENFL5cljVZQFKHYsqF0Xfw5RXKZtg8QVHqutl28mO/2Ia3k19hfExj+I0
   qVas4Ziep9FIZdKM/BhGwuJVNdo3KacidZT5D/RECo5D5HAaE0librt7e
   Zv/6uiaruZo75TQKokpACXWqx7c/RTUQvmTv1o9F9LfW808MTfwKqsyY6
   N5JRszByEK6Yo+mbIztEy+aUlv6y3v8S16hiqch7pkfwRL1i5ME5Y5znv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11339583"
X-IronPort-AV: E=Sophos;i="6.05,235,1701158400"; 
   d="scan'208";a="11339583"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 10:36:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="789016165"
X-IronPort-AV: E=Sophos;i="6.05,235,1701158400"; 
   d="scan'208";a="789016165"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 10:36:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:36:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 10:36:46 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 10:36:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 10:36:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEE0UFwPLRDChvBTAoBlbK/0YZ5r4RCuHNQiYWj5xvk6wpW9wwILv/1vaHZWxMAL7gm3LtBh++J9WOMX+o3lM/YxmgdRMF/tQ3bRDlxRA0OnUOk5fJpKythoNg6F0lhZttbr8bYv9ETQo50psnAU6Ndg84aaUeRw+gQ2SwPrVOQfH41+Q0TD2Odawq4ITzOJYd5db3/nXWybVJFT/2aPboqxa4FqEVtljtJtA2OvZg9MQHGYZOozycS0rw5Qle1lBEWYW/df+L+YBsag//dff/pvXdCF0f1Zg+mQfuZjcf2dEayujsMN407jf8aw+3GP+qORxHMBuV8Gyk2cZi3ZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cS0wo2Ws/z2XBgKEXheEnARmgW5sFt7+VG+zxZyxCM=;
 b=cviLKxIKqm5g7BDhOd2T3U3UM6GSckXehoHF1YkODfxacPnZPGacuYVHxSN0BG2tntV+s/e/oHg7fl2yxVudhSK6F0CoFJ1h25xTTs2V/wwK7g+3/jAshdRw5cBErRTZrOKOsxj8++mU8X38L73qPDayFwPXVTJLt3zusCppuz3rks6tMtS7/8ef4I1yJQzORMuBOqnj4Zz37EFbs13l/x4esOWUMW3nX5r2ki/a6Fd1EXDQ+oDd4JuSCzplXy0G51KLI4/hV0tnQThSdM9gPTArxyLMLzCAppw602EyX6GhGg71crDgOaN+gj3sg4K4V73koq2wW8bLmZuOi02QKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH7PR11MB8009.namprd11.prod.outlook.com (2603:10b6:510:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 18:36:42 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::42b3:9892:db7f:5563%3]) with mapi id 15.20.7228.036; Thu, 1 Feb 2024
 18:36:41 +0000
Date: Thu, 1 Feb 2024 10:36:37 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
CC: Mike Rapoport <rppt@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, LKML Mailing List
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>, "Ingo
 Molnar" <mingo@kernel.org>, Song Shuai <songshuaishuai@tinylab.org>, "Ashok
 Raj" <ashok.raj@intel.com>
Subject: Re: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not
 set")
Message-ID: <ZbvktYF7Oi53qpjx@a4bf019067fa.jf.intel.com>
References: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
 <ZZEXnl3w0K6avYR3@kernel.org>
 <07f1cb33-e908-48cb-85f9-83a040b2ca5a@leemhuis.info>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <07f1cb33-e908-48cb-85f9-83a040b2ca5a@leemhuis.info>
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH7PR11MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff1245a-5be1-4fdf-727c-08dc2354bb7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IQ/lwqA6tU4eicQBejAyr8iRuZC1XsUZe1RPfoUIu5FVx2xmD1E8xcGppZm/Kr2Pw0aBEetxSRWqDuM6p9eZk1B4zBcVyndQ2HyLD+qKH1n0HWcqOQMK4SMX/JuHuQNBcGhHjj3sBtCwYlhhdRHMLOvePqTdEDF3HSEPeWtO30VleXGhfIG09X+HTktFxvLNf0Pig4aBkJ4qd1i2XPlX4F8JEIFKToIMova5Ma/PUcdbJiDbQU7+skTIMemOs2v40P4lTJ7fAIVeLZaSrjYByi7b6HCd5eDB/LL5tZ5EESELZ4OaWwxiH2Ql2zcDlFbpKyQTJ1Ov1JrAdo8ZmdC4fbWJOwroHTmbqclazqDwRNSlcSfgQoxJQDbeNYRjGa3nTQpM+DbVPPTHoR37cgYk4xoo/oGejKpPLI/3lxe+glPB2cPlORZbDzZ0RA2bxzzHEY22ucisxpY/byNrFx799Oe8DbtBdCAylf1l9pHniNjJ9q+LyjncYSd4Jv/yaZ1XviDfW+S/X+mf0Z8OgFF6SdPVkLb+I0S0nsTfDjxeohqeISdtre7uYA5q+9MHa5R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(107886003)(41300700001)(8676002)(44832011)(2906002)(4326008)(5660300002)(86362001)(8936002)(54906003)(66476007)(66556008)(66946007)(83380400001)(38100700002)(6916009)(316002)(82960400001)(53546011)(6506007)(478600001)(6486002)(6512007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WyzRNQVVhnZoCSK6eC/C19UkYi2wzmq0BUVxtsAkJmjh7ptVINdTV28pNedx?=
 =?us-ascii?Q?ZDsSoo6cUwfCVeAcgjJANiQriAXuHeFQO6yGQ0cA8SB2d7ecdjAz0Ftg8bti?=
 =?us-ascii?Q?O7ztFP8ISbcwNDds304S6dkHAt4njBkqncNgXwh4yVG+JUgYf8musle/FjO9?=
 =?us-ascii?Q?UlhkXCjQZarYnKX4tTjoGesNPUfQzXQdbvTjGGSodFAq2v4BIBqI9msiiJQr?=
 =?us-ascii?Q?Vy/SBTrONBm3fWawBw4deCQLh0dKD6pcKIT8/4QMmXYVAebn/p/J6OfzSHqy?=
 =?us-ascii?Q?l+ffXSu+jEYxagNaQNlZNJPk32ytNYYgzHSI+52E7k8h0yv2C4AiHsySPhWs?=
 =?us-ascii?Q?51q+BXJswOhz6MQSVm+LxEpCjutQIeSBshNh5fUIt7zxoo374dKCvBmVUU23?=
 =?us-ascii?Q?OvOcL7MHn3K9VPY23UXkMaZrW5DH2dbuCeuvi6tHJYqN5K7VN4sPt2cCz60O?=
 =?us-ascii?Q?VSvm0zWEm755JpJUUe4MMAhS83gab0ZTynsjBXi7TQ5RJDJAnKgk2ABVXyo1?=
 =?us-ascii?Q?KDfUoM70i70cvoeWaRgqFlzWRJQ7INEgC0aoFnXnm8du+sLHQJqK+oH+VEtN?=
 =?us-ascii?Q?B2SGJuz/SQdJaIAfuNEHWF3QjOJOmHtUfqNKMHpPVcBBL3ddeuA26lQeHMgR?=
 =?us-ascii?Q?lQqw5GOXAQrAdq/nwtmC1JGbkyqpAXrRdZKdgiiD3LOM0WmrZ9htiYa7YOGM?=
 =?us-ascii?Q?fEvC7wkvoaaO3Ltz4bgCtSuPeeZ7TXn/DbemqZvOVrGytba5utfwuaD+vA2P?=
 =?us-ascii?Q?EAcbV2epIQA/OC75GPcT46rXWBRvkxm0azKShOfNKRgbcuydf9uO5oNRL4AO?=
 =?us-ascii?Q?JKp3vxuLUYQe1s8rxQYriqAmDTwwvS2lafWWIc8flU93tkvijeExuCXnLfWN?=
 =?us-ascii?Q?VKYelolJCgktcQXUAj4UYeNWy6wBGL99xkyrpKOZVsCGc9riSwPEvm2X1Vg7?=
 =?us-ascii?Q?CtCZyQTf29/TZM8gzLLpSG2H/ePp1Scq3Pg1BYhLWz9xyctqfTTo6KMOaC2k?=
 =?us-ascii?Q?L7HUwYCKGGC3wK5JSoNN3F6vckRndJGhWjifjnZfVEipYGajqN29YZ6Wi2wS?=
 =?us-ascii?Q?rVleEnBW0SfkcNviTrmXC0FaTlDo2or9IlPIowINf7sLDiJoRk4EJ5qXRMfQ?=
 =?us-ascii?Q?L1YjMhNMjiwYnv26IGGHHkRwm/bp16AVmvXozRFokVul8pZnZ1Jante2CM5P?=
 =?us-ascii?Q?Jli/22e6Lmli4Vz4sdcFkM3NjXp6aR+PwuM9YjYWJkM6vMZLMQvCY9vlqCkw?=
 =?us-ascii?Q?xHsE3hkv6ULx0e71PCaInuhvQSr4z6HpI6IdHdWdAuPcCMi56XCJlDvrNAci?=
 =?us-ascii?Q?rRANUmaAFHNeCoHjxchCRmSEONzzUTiMrLS9JiKuk8H8mX4s0pYsgOIKe6JE?=
 =?us-ascii?Q?lAMnwkplCGWBD9rRGJlx3MiWhJzIS/UMY8U0j8Ib2yeTG1bj7PFOS1yAOlyt?=
 =?us-ascii?Q?kWuXgxnW0Wzrh2Koq05tE63WSCQhRUmY5acrtT/uZdMWpOa1paImE5YPsysP?=
 =?us-ascii?Q?xgO1E47HoMR0yfm8GWfUxVXiyKoEkON07fZ7ifW5wrqbRxqmz1V4dryJUeIu?=
 =?us-ascii?Q?GkW30P/BF8qf5CLPHEAr4ru4foO4e9+lX9md939FHaJ5j/hv5kY0MLWfaD8o?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff1245a-5be1-4fdf-727c-08dc2354bb7f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:36:41.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32f8PoAtVnk23aPyt/AtQ35NLkY/I/z2F8jKTaRZO6WbpImVRKoZY4RdUu8FuIMcGQS4xWCq8iXs83QIuuPRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8009
X-OriginatorOrg: intel.com

Hi Mike,

On Thu, Feb 01, 2024 at 11:38:38AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 31.12.23 08:26, Mike Rapoport wrote:
> > On Thu, Dec 28, 2023 at 04:33:49PM -0800, Ashok Raj wrote:
> >> 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
> >>
> >> Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
> >> it appears to hang, possibly hung at the panic. Although I have the
> >> earlyprintk enabled, I don't see any console messages when new kernel
> >> boots. 
> >>
> >> Also tested turning off CONFIG_X86_SGX, the kernel with this commit
> >> included also kexec's fine.
> >>
> >> Booting from warm/cold reset has no issues. Only kexec to new kernel with
> >> this change included and CONFIG_X86_SGX=y causes the kexec failure.
> > 
> > Can you add memblock=debug to the kernel command line and send logs for
> > normal boot and kexec with CONFIG_X86_SGX=y and e96c6b8f212a reverted?
> 
> Ashok, you afaics never replied. Did you forget about it? Or was the
> issue resolved later or never a regression in the first place? I for now
> assume it's one of the latter and stop tracking this:

Sorry I went AWOL on this.. I did try the newer kernel's (6.8-rc1) and its not
happening any more, and kexec seems to work well. 

On the same problem kernel adding memblock=debug make it dissappear, and
even adding some code to that suspect area changed behavior.

I'm not able to reproduce it again. Sorry for the delay.

Cheers,
Ashok

