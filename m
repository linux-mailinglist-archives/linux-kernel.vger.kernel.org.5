Return-Path: <linux-kernel+bounces-70396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A1B859709
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D230E281F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F36BB44;
	Sun, 18 Feb 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GyR/RBlW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9637140
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261413; cv=fail; b=I8w8ALSx8LZKlQ3+2FgB6MGyITfVu1RA+5bEoU2ekHSYMmFyfFOjgzI4zyVacYqpJCgyZ+av/1eJoPuUwMr0X35TOTxBFCeSNVVwOwj3zB+GZ5/Z3kpu2L83odZGi6pUn4yUx0qwwZDf9uxBKil97iqcHbRzrvJU412Im8z5WXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261413; c=relaxed/simple;
	bh=uYAug3p0HMp3gITh4EOYBCjGNQ0nc2Htu6dPW7wi62M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/bsoyPKGjeXK3SCQmYVCKXmXHlc89OcTBwbOKKyCzlgqi77c8EqXdsJPSX6bFIzvBNk/bNkDdrI4eyQbPPEW3Gh66dFuSLcmekvxveBWy/mmHUCFGyb71P2NNx++SLNE5NFaqovYbHkXK3EuGrdwy1LKmirCDu0hr9yO6lXTSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GyR/RBlW; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708261412; x=1739797412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uYAug3p0HMp3gITh4EOYBCjGNQ0nc2Htu6dPW7wi62M=;
  b=GyR/RBlWS2ATkio6fxI03hurmZO9oWeERGnNY2hr8fqBNCTVused41wD
   H6rNjCA/L86AUdA4+YdvRiSfBj2odDwgLkAzbaAK1WkZhW0XjyUr7A43I
   kgCxY6jmTOkEGNHA21U0s9147t/CWezu147js+Hx6C6uCKxdBn/j5layR
   uvHlKNlilerGluTjVurRf3F4ympicnuZkcELnsYhD4N2IiqRVXR5ntGSV
   hjs25XfRz5PLW7URWV+p7gOR1ogwDO3o6GWmo98bZ5587OETOcTS3v2Ts
   ZJCnhB0voE2po9NnRonlaQ0ZkDJudJql+FKP9no7LFUslOkzRvkHiXDvp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="19869979"
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="19869979"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 05:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,168,1705392000"; 
   d="scan'208";a="4292005"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 05:02:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:02:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 05:02:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 05:02:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 05:02:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMJnCJ04HrGyc4d++jeJOmFR/3Z6MHeUodgxlFVjJfT2kS+dEN4pDdUuEfKCZzlk0l+sql6kjgCv8qI7wPgJAeUypenqquTA/XjStRyNjJ2t6vD3vq491eT22kDq+zw+5u5K9k5XoFLg2aR94IyUYE7R+b0UXjsKoPIFWiW25Z8RrV3/nG1S8AjSozTWfgt3Z7FkBoqWez07zxWXZ49KxOO6JDtg5wY3ttg3XtBuENzdh7XL/450Pl1AkCX4fF/ZLU0sbBmyIQv334rs33Lh/2mJhEVmyIXD5+q7NbgODsB44HOUgVZRcn87via0chJoEhaMYmgS9bn9bZLlneAbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg5m60A8VAjpgCNzdAHgGhcuCgjXAocW7NRsqHjFcgY=;
 b=QLFXu1L6o270QPuKaeksKSv7R0hVTDh+oRgpe/plDztryqBj4v5XeznBKtAngM8bwefpYHoG9g+FbU08geX/RFh1ijWBWpbZF4QFTf1cJm9CVFzPu//uHDuneAwtkuxAM01VAOYSoPLRo2Co7/dM1Hu3X9ZJQ7AouP6csls70lwOTQrH2yBgbWOyYd6hBhCTjiZ/RrH2FHUhar/z/kBgUpz6ai6lT/3xX26I8t6QjlbO2sPN0zHMmakRiujLemOEGf5CKsWgff14VADPoJrj2cbxA+mbWdqy7YFLT0W9IhdHsFWY37BIgrDtlijzVX1B+dFyQeR7SqIM44gfrfWhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sun, 18 Feb
 2024 13:02:14 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::a83c:a9dc:f30d:507%7]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 13:02:14 +0000
Date: Sun, 18 Feb 2024 21:01:57 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC: Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZdH/xcC+l9Hisi80@chenyu5-mobl2>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <31622970-62e2-020a-b802-9b961a7db03d@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31622970-62e2-020a-b802-9b961a7db03d@linux.ibm.com>
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: adf5346a-1bec-4324-535f-08dc3081d3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6c49sKHRXGpMSjNYAtAS+rK9QbYESBmyl3y00T3nF1kYlC1tF9/i47LX1CQJjge11npgmzpBQOdsaYTPwhjhc4/488W2aTkraEAQW3xbgQZ62tzFJl2T6ZYIWc0UBzsO43THAxGbl9gJJZGL0t5kmttZgAYYeh48fK35wBh6YqgYtG7XwJzDuiMYtiWXpwNpBNKBnAnRFHshhpOSyPy54JpYDH7aADlD1Z/d2VWmk1ROmxj4J+W0/BoRAV+NXofDlQnq9FSZcDIUqr37JJR/DEJvkB0wFUd1+Yht1XQOo4pkKz8xOpR1OhNirqa8HBKUzvCBfKiKWdDsF9Gz+nqz4sjWvaCIvaBaOlkBrjeItgRnTFGFq4OVIizyaCWnXbccChfUlotXvsJLwPe4UdTzatRXurFKQYocso+g2mcZoj1HgC1+kwn5fq2bSab08FU6cL1gGVDQrrXMYPsTujPj+WzLRAkNxeisVUyaNM4fnMYD5k7US9YI80mwtjDu2MTCvhHb06bdSAQlrLAMz9K5LnDlOm1aIgghxQzH989Jv8FcR2OKnrcPbmlYS0RnIplc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66476007)(4326008)(66946007)(6916009)(4744005)(8676002)(7416002)(66556008)(2906002)(8936002)(86362001)(38100700002)(83380400001)(82960400001)(478600001)(6506007)(6666004)(6486002)(53546011)(54906003)(316002)(9686003)(6512007)(26005)(33716001)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZkC/urHlT/ZYdPkDkj1ABdDvGvb18oFUYDcpweKeEpObt5UVe8eTpZSk6ueU?=
 =?us-ascii?Q?omrcI6D7cQVdjevjY6qHC3aUt28g187DvLttiWnyDHV6OFS2P5lh2DuTuWji?=
 =?us-ascii?Q?XAcMq2Z8I0CVfC9tYsLEM2jTP+lHlpNqy6Ar9zblYBqcbPFLTvHuR4iuGWpV?=
 =?us-ascii?Q?cLmQLY1GulF7KgqOO0v6GUsHxuhrK88QFgNDzX0mvsgY00FJC1aGBzK/Ch24?=
 =?us-ascii?Q?nct/o/obXCaO+uP+ZjVClAubamxHEd6YjbGfk1EzUEJqtGklFF6DB2vyLRRt?=
 =?us-ascii?Q?5/c4BY/y+tR3keYcITdBwu5IfmEtjGgmIqxXrMYuVkU6bXend1r+J0DieHrM?=
 =?us-ascii?Q?Tp9y7PeQel1JMRoxRNsAQ19Ds+4d1UnMgoR4Y8H+E17cwX2b2jCRJ7zl73Ze?=
 =?us-ascii?Q?mK/9iMN9MbAK8ioV417hobb0Q8PISsz0GhQnEOaUkTumxFtFRtGpKwdD8eLJ?=
 =?us-ascii?Q?SSNc18z0ZaOsIU7PWugUBqMRdMFPjIaf7dSVKjtf1jGjoaiNuSuQuyQERf+w?=
 =?us-ascii?Q?AmS2XWldWfXyilBXV6XBZI0Z31ioZ0xnbFcxMxOCrNcoNGyn3VfjKOIWG8P1?=
 =?us-ascii?Q?ASSx7hKeiQA53buISGsVq+XuFEfQh8peHOR961rHzf9tsB45zmBsXap3OcPP?=
 =?us-ascii?Q?WvfDnsz3Ugr/h2Ca1gCYP3gYUpgVVkEn2KVh09FVYOKyvECXaV9TbtmVupKF?=
 =?us-ascii?Q?hUJet6w8kTcPdtULwOAR3OBS5ma6kminbZcArbVvUSBlinE+YHG8rqL1hfP0?=
 =?us-ascii?Q?UnCKx/LvD5k2mt2vLhWwA6Z9q6GA6rvBmxPa4KDedihI+oGxUTzlNEhR8uUi?=
 =?us-ascii?Q?GzaSYiIid+I+AmiNPT6LVxg+UNy9DHp6tgLYCXreJ3qlCDop2VcsCa71ovR1?=
 =?us-ascii?Q?dd2585Wv9BYFMVG821qygIsdFPXhMqR30puUHBPAbVwpPUAIbyGFZmrNOUru?=
 =?us-ascii?Q?3uHP/UlL29ULPwtKQgZI4M8MybcQvOpYmfNn7w6XvMx9gHzf7fqgV9Ds0ji0?=
 =?us-ascii?Q?xwsmlW8Ztmwo0rUyN4SY68b9pQ5QvXKoeXDIKbRmh7FHYv3LoVl6/sv3DGN+?=
 =?us-ascii?Q?19f5uNgJwpfgkOYGAsADmUfA2xDWa6DVxq/i9yt1IfbfRE89y5yLfyD8A2HI?=
 =?us-ascii?Q?1XGwII2TPdgD5bLjHv/ckIdkANc1BBbWZCBYPKaX6mao7qc/eGJ/2hMyLaiL?=
 =?us-ascii?Q?r0IAoMKcsToaCoE4Zg62HodeGpFdXx03mFik6k5JS8aM/Aj9j57zTVRjaYuy?=
 =?us-ascii?Q?NhTOFidvH5kpFYQxD1zdhgtzD7uvvOYAOK3z2IafdFANDBQrtEj23pkaq6hr?=
 =?us-ascii?Q?TXBWV+PRgapxjyI8YQlcUd9xVVsRIyKGcH1dhakMWITjlcUM27RiYVdpKVRl?=
 =?us-ascii?Q?ZCO1xPOZQ3trlNOWeJ8jmk1jNuZjtFELTnJ6T0CKt7iqSp7b5pcTk4J9R/ZB?=
 =?us-ascii?Q?vgUw4KpYzksFxAT8MtaN/YSMJBVdUZAx3XEZDqLCHrzHlpcJM5CSHTPqFBrd?=
 =?us-ascii?Q?tP8mmKacnNBSyA7+Fzo1/SLYFbQOeJV3Guy4fWreH3DnKTy8aBwUSrtfTWXr?=
 =?us-ascii?Q?kJCTEPRo1s2vcjRoTeR0ucpfqOz9FTsvCSp41FQT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adf5346a-1bec-4324-535f-08dc3081d3e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 13:02:14.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ih/racjDXyeo343Asf2WfJdbzyY6AVRffjxu1JweygFAdJB0EVI/ZIT0gDVAVNWb0NHPz7+wpQRb2VLDKqUm3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

Hi Madadi,

On 2024-02-18 at 14:57:17 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 21/11/23 13:09, Chen Yu wrote:
> 
> Any update or progress regarding this patch?
> 
> I was working on a patch that improves scheduler performance in power10 by making changes
> to the order in which domains are accessed for cpu selection during wakeup. It turns out
> that this patch is helpful in that regard and my patch is giving better performance on top
> of this patch.
> 
> So, looking forward to know the progress/status of this patch.
>

Thank you for your continuous interest in this proposal. Glad to hear
that with your patch applied on top of this can get better performance.
Let me rebase the patch on the latest kernel/do some code cleanup and
send the new version out.

thanks,
Chenyu  

