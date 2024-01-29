Return-Path: <linux-kernel+bounces-42861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73E8407E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14571C2223E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6ED65BAC;
	Mon, 29 Jan 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KR0cf3+w"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C265BA3;
	Mon, 29 Jan 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537389; cv=fail; b=qw4ZFOlOnQolP0S8s/K0JyDK/plEi4slDg2i3ukz+uc6AJ78hSAXrGZ305djlDIbIH2VTmRj565PKJCCLbqd3E3YSDFBv46Pxl+VkMXxYg+H5yL2xx4T6Xb61ucB6j0/kLYfXUM2BysDGxUKH89VTrj3eMDXNagXAGKWa1RgQH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537389; c=relaxed/simple;
	bh=6lVj7mdu8F5HvV6YzsaVzX6Dq6oa6LUkMg42EddzvM0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q+sBKui8xcTuDQqV/ED8MgXwoXSYhDNDNQYEtBU0QiiIPMqLbq/+Y+Fytv++aNp9kbOPTlVLfSCHh8L/JVKZgeo++gPYQuX/OywbPUgLdinE/PcHzlHk8LU9iJE7UI5vDWrmn91c3tYmToa6cDrEh1D48jPmZ0wLFDh9pOyT2Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KR0cf3+w; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706537387; x=1738073387;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=6lVj7mdu8F5HvV6YzsaVzX6Dq6oa6LUkMg42EddzvM0=;
  b=KR0cf3+w0RZy64HgbMHU06V6Qaybd4E13hTTdaTEYFUsmDw5+FBV1+Jc
   AtH1fAdJZtNPjuW06Xh9LoKFw9MpAwFRvsM3ZXOOm6MCsQapibx9+2Sj1
   mTxRzNoGmBx4Rn+WX++Jg72rS370hyCzXoldi9frqPVfZAhoik5T904Ir
   NsZtfFx06H5HODoo77uijPZxCmo9otKN64qUdAa7wI75dcGLpL72pTukz
   lNvpTyKDa8k2um/LdMaqzzPTB/2YnC45zECVY6EYj0OCZIiFFLQNUMMC/
   fxdpvfr6XPU3ZZsQ8AP0MBQ0GUzCoAOW7jQpcpzK0LdwEKaSQhuiA7gsz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="401827434"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="401827434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:08:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="931099613"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="931099613"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:08:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:08:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:08:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:08:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:08:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx4c16E+OFralUzkF1QtmbiPa0cVvE/d1NEr53ZozG/a75pnQn/FPqq9KEcDzbHfDyBunh9cYv4NfOX3Ewr59CaoxUsiuP6qXymZGRIBCJ2h+5Czn3vZiuZ/PNY8ASkXo/THq1GuEMSuumLyWOCVefw5J/M114Tf+Y5000fXs77p7VXOwAHMkZtXNL0NVtZeebr5CHwNz/RJQyQwIlt8p4oRInH5nGPsMRwhkap92QSeKr6F7CzsJM7xMXVvMiM20JRMiKMeeoiph7TeEG/4JcSaFNTaEhwjNyKnHo8ew1sHozycQE/iupgpaWlqvo5T9PgVyvvV8O2+eCZV89F4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBzFNgws+QcJLQWSEw5jVZn9lWPeFBVQv6NjDHpnheY=;
 b=hW/IhREu17TmXCJ+LPOTt/aTpabk3yj90b8VB6tm689A0lrE3gUAHSxBmYIVImLx1Z4KFTRgWN/J6MSjPMULsQzleRuz1HurPrgk/sePu+CnJh2vLE8AZ7zJDdE7Jl7GrYMoO49Rde6D7PzhEUOLCR9DTx158NAfjaeH46cSVEejW77GJRFGKHeiPxkL+ym2ndR3mCpXsE++WWn3OJcK9T6j1ZtAJXcTMv7bhH9UDXiMGnzk06ghPL8kxFtDD2v7MYyE/QBE2R6DjjKuFwiVA+siaUflYMXy9VVUoh9YoLkj/r8kowQW08GOMujdAdngVE/a2+4OUtNy9NVeDVqqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:08:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:08:42 +0000
Date: Mon, 29 Jan 2024 22:08:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Vimal Kumar <vimal.kumar32@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Chinmoy Ghosh
	<chinmoyghosh2001@gmail.com>, Mintu Patel <mintupatel89@gmail.com>, "Vishal
 Badole" <badolevishal1116@gmail.com>, <linux-pm@vger.kernel.org>,
	<rui.zhang@intel.com>, <yu.c.chen@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Vimal Kumar <vimal.kumar32@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Message-ID: <202401292109.f115a688-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109130210.31938-1-vimal.kumar32@gmail.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7334cce9-3805-46d0-6ac4-08dc20d3ccc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtwZUAYJ9yJ5urfmIh0LkRTzP/BpkZ29hb+Fs5sKgPvJ+RVlV6wf6eTw+fP5HI07Qjh9kf/Te/vZ+IsLKLNTKUo7Uo5OJVmYclh3du/jxL2INc2gckLSq0B2hmjMUwhQyoSsssZm+29jJ1YVqi+/aHPh8yjwmCfjENnAAfMR1oe4iwAO/aHWK8I4nEJ5SHyJhXLfUxk/bA0OSZmVuo3Nbxaod0TJAB3zuvkN5fzQ85JnB9sGxBqI8SzfjSRoEvCvZeSAafgmv1t/A8nyzk5iVj279foXWCesiwnx7WG9wZ8CX7rRM7oJvyKmjgiRYXJ4KH75gkDlhNBc+AYjBm66W2frIgK81/M4k6tx6Srp80t+Fv3I4y0NzobpTnGN5G8c0fmwaPz8dtvSv1BNzGrHjIFo/YgjAbVrK3YgVXrowsh5kZmOqtx6WXBRvEQuong3p+kJdoDZyqbSgcJRMk3RaO2Rl0No7BvTDP5Vttdffy4FFQMqJME6MC9dC9651cqvAnouU4a5XzKABJNdvRLzSwyotQ2w/uds4Oi6CvK/5xmGINlPue4bEP1DWLM60Nvv8XTswaXXeIGmgwA6jLjxbIuYMu+QiUY+/sui51UQLdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(83380400001)(6666004)(6512007)(6506007)(26005)(36756003)(86362001)(82960400001)(15650500001)(7416002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(107886003)(2616005)(66946007)(38100700002)(54906003)(66476007)(6916009)(316002)(966005)(6486002)(2906002)(478600001)(66556008)(37363002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUvs1s9Ya+bk14T6dO6uky3o16swHL877+YAUl+WsdEAox+vF1XQZllB8OAv?=
 =?us-ascii?Q?Zq+zBqyzLTo8zGVUu/xqK3ShcMR9J7CBOEBDLFm5MFEGq19NBdskBJzbnowe?=
 =?us-ascii?Q?l9Xt7mRPLrDL69nBLW24hN4IsUddAkiknx1p6lVy5ux3MfsnlgD9nMhAvfnr?=
 =?us-ascii?Q?09Zx1Cv517AdfGpyk/zgYIc9M2JU/Q4susDXqrjC5u0M92mneXYE/dhrRfiJ?=
 =?us-ascii?Q?zO4g8sFHb9tsPIHq6Z7Qd1VyJRtHUfM1o8+2UHHD/xcTlQxftlDrD698VN7P?=
 =?us-ascii?Q?K0iLLpqxO4ZdRbLBvVTvTXZ4LacZYMxaBwLlrSe2pQ7QTFXBGbwcMYJdAWfg?=
 =?us-ascii?Q?F474GvVQJ82DDO/d7VhhiZwYbrrz4pcP+b0a++sEdFvWOzfskcJjMXVu/mQk?=
 =?us-ascii?Q?pdC40dHy/nvkr+j4CHAq+PkyLHaPV8gYPo43hjDS9i5k+W5x6g7+yIEH6wTf?=
 =?us-ascii?Q?BZ2OMVB+u7zUpWJ9yK5sUlWLetig1rchFYFVhadL/Ulm53BhzSdW5hWjWyt3?=
 =?us-ascii?Q?MZOYJIykGKFl3WBm08HR70R7UZPmsC3UDOivVEb4kthYYjhNekMxP/ZHcmp0?=
 =?us-ascii?Q?qc/xR5vDoiqyle5ulp1cskxuXthpufm4ZLEg6MpX4yh6RarhFEwBTmRMCtSI?=
 =?us-ascii?Q?SfzcUza5xmEPxMneBoQfmKWY+NpVeDGViWb6wsYVZ6QcdSpMqWyT7DlK3i57?=
 =?us-ascii?Q?kd3Tmz6VL5hwXXMOTUvinpB/VNQFZFaqqQ97vbwNDCk0RPN+eMBdAfWcRyaV?=
 =?us-ascii?Q?vs1G8Pwq/2w3nRiYq2+8kWfg74aak7HN6lCiG2tlVgXHG45WT33bzlADMj0/?=
 =?us-ascii?Q?6PzKbUlz/1SFcQsx4ODBUe8SklxW2p8aRCa4isH/CKGYDWBL0/8s4MOyTM2s?=
 =?us-ascii?Q?l+fdH421ZjLfP6koyGWeKxLwoJMTKTm2N6svFKH8YoYR1m/UbmdXl48JtdSH?=
 =?us-ascii?Q?tCS4mxmBD1dccHk5qEWZ5yWuVxdUIOcj2dGjDVnAZrn1kR5xpJx2zFHCUoC6?=
 =?us-ascii?Q?l76X29wJfKymvorFgao0Hf8j8GjswLguDz55RJ6M08umGDqr1SuvN9wmO97I?=
 =?us-ascii?Q?1TbWu5Bk0+bShervAa/5916U96jNnSIjE2Kn1fhVT2XPgPHzrXbDoyrV16id?=
 =?us-ascii?Q?p5OhxsIPovSB5uRo9NQomOqNjC9ok5RFSrL65W26ezK3fzYIt7dhBduliIYm?=
 =?us-ascii?Q?bclTz6ovUlD+eQJfkCIkDMnRFdzY9ZoOCcTSSv1jXRltFKqccl9ZTTN455JT?=
 =?us-ascii?Q?0o8/GvXiFd2xhvnqOR60JcLa96D+WUQVoPeIsRUKFZpcMNHD9q3r8AyDAdGk?=
 =?us-ascii?Q?vGR0JNWjYwAGxZdbzdJSFzIjhFSrKCIt4SAKisJ0ShLzCOo0AZ8pSMgiSlM/?=
 =?us-ascii?Q?0HXyoSxIVIhD/ty5/VMULcXaY/xPkXvsmLOTU4TgaN3vqABckCSRlYbaQ7gB?=
 =?us-ascii?Q?zn9rh4mKq/j98LWCyVgnwXR07JgDBOQ/QkwjdxMgwKF/Cu2aJ4/Wp6jer9G3?=
 =?us-ascii?Q?EtTKkrMkEAA9S53VZfybjmPOL87EldVVVgC2vSLHAYGIDI6v4me3cB2l7xya?=
 =?us-ascii?Q?Wd548ib4brX1HsINszuevkNQOvtlkSvTm7GUsWFAGDLeOsTkgrkeomoInUTt?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7334cce9-3805-46d0-6ac4-08dc20d3ccc6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:08:42.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHi0DGb3TUHyjJG3MrwU1u9o7ct+rtQb1aZrDJF4b90ZJ5AYSzFJY7e8TADvnLYCo5H4sm+rNrZggRUCz4laeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: e2d228456d500f3b00ad746b353fa85eee235b7a ("[PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition")
url: https://github.com/intel-lab-lkp/linux/commits/Vimal-Kumar/PM-sleep-Mechanism-to-find-source-aborting-kernel-suspend-transition/20240109-210519
base: https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git linux-next
patch link: https://lore.kernel.org/all/20240109130210.31938-1-vimal.kumar32@gmail.com/
patch subject: [PATCH v3] PM / sleep: Mechanism to find source aborting kernel suspend transition

in testcase: suspend-stress
version: 
with following parameters:

	mode: freeze
	iterations: 10



compiler: gcc-12
test machine: 4 threads (Broadwell) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401292109.f115a688-oliver.sang@intel.com


kern  :err   : [   97.935754] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
kern  :err   : [   97.935886] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
kern  :err   : [   97.936000] preempt_count: 10002, expected: 0
kern  :err   : [   97.936071] RCU nest depth: 0, expected: 0
kern  :warn  : [   97.936138] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.7.0-rc8-00169-ge2d228456d50 #1
kern  :warn  : [   97.936255] Hardware name:  /NUC5i3RYB, BIOS RYBDWi35.86A.0363.2017.0316.1028 03/16/2017
kern  :warn  : [   97.936371] Call Trace:
kern  :warn  : [   97.936419]  <IRQ>
kern :warn : [   97.936461] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
kern :warn : [   97.936529] __might_resched (kernel/sched/core.c:10152) 
kern :warn : [   97.936598] ? preempt_notifier_dec (kernel/sched/core.c:10106) 
kern :warn : [   97.936672] __kmem_cache_alloc_node (include/linux/kernel.h:107 include/linux/sched/mm.h:306 mm/slab.h:710 mm/slub.c:3460 mm/slub.c:3517) 
kern :warn : [   97.936750] ? kasprintf (lib/kasprintf.c:54) 
kern :warn : [   97.936812] ? pointer (lib/vsprintf.c:2755) 
kern :warn : [   97.936875] ? kasprintf (lib/kasprintf.c:54) 
kern :warn : [   97.936936] __kmalloc_node_track_caller (include/linux/kasan.h:198 mm/slab_common.c:1007 mm/slab_common.c:1027) 
kern :warn : [   97.937017] kvasprintf (lib/kasprintf.c:25) 
kern :warn : [   97.937079] ? bust_spinlocks (lib/kasprintf.c:16) 
kern :warn : [   97.937146] ? enqueue_hrtimer (kernel/time/hrtimer.c:1095 (discriminator 3)) 
kern :warn : [   97.937214] ? tick_nohz_highres_handler (kernel/time/tick-sched.c:1530) 
kern :warn : [   97.937295] kasprintf (lib/kasprintf.c:54) 
kern :warn : [   97.937354] ? kvasprintf_const (lib/kasprintf.c:54) 
kern :warn : [   97.937426] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
kern :warn : [   97.937501] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161) 
kern :warn : [   97.937581] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
kern :warn : [   97.937648] ? _raw_write_lock_irq (kernel/locking/spinlock.c:153) 
kern :warn : [   97.937719] ? irq_pm_check_wakeup (kernel/irq/pm.c:24) 
kern :warn : [   97.937793] pm_system_wakeup (drivers/base/power/wakeup.c:981) 
kern :warn : [   97.937862] irq_pm_check_wakeup (kernel/irq/pm.c:24) 
kern :warn : [   97.937933] handle_fasteoi_irq (kernel/irq/chip.c:518 kernel/irq/chip.c:502 kernel/irq/chip.c:698) 
kern :warn : [   97.938006] __common_interrupt (arch/x86/kernel/irq.c:271 (discriminator 22)) 
kern :warn : [   97.938078] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14)) 
kern  :warn  : [   97.938145]  </IRQ>
kern  :warn  : [   97.938187]  <TASK>
kern :warn : [   97.938230] asm_common_interrupt (arch/x86/include/asm/idtentry.h:640) 
kern :warn : [   97.938301] RIP: 0010:cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:78 drivers/cpuidle/cpuidle.c:199) 
kern :warn : [ 97.938384] Code: d9 75 83 85 d2 7f 11 48 83 c4 20 89 d0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 4c 89 c6 48 89 cf 89 14 24 e8 fb 64 9b 00 fb 8b 14 24 <eb> db 31 d2 eb d7 48 89 0c 24 48 89 74 24 08 e8 03 51 9f fe 4c 8b
All code
========
   0:	d9 75 83             	fnstenv -0x7d(%rbp)
   3:	85 d2                	test   %edx,%edx
   5:	7f 11                	jg     0x18
   7:	48 83 c4 20          	add    $0x20,%rsp
   b:	89 d0                	mov    %edx,%eax
   d:	5b                   	pop    %rbx
   e:	5d                   	pop    %rbp
   f:	41 5c                	pop    %r12
  11:	41 5d                	pop    %r13
  13:	41 5e                	pop    %r14
  15:	41 5f                	pop    %r15
  17:	c3                   	retq   
  18:	4c 89 c6             	mov    %r8,%rsi
  1b:	48 89 cf             	mov    %rcx,%rdi
  1e:	89 14 24             	mov    %edx,(%rsp)
  21:	e8 fb 64 9b 00       	callq  0x9b6521
  26:	fb                   	sti    
  27:	8b 14 24             	mov    (%rsp),%edx
  2a:*	eb db                	jmp    0x7		<-- trapping instruction
  2c:	31 d2                	xor    %edx,%edx
  2e:	eb d7                	jmp    0x7
  30:	48 89 0c 24          	mov    %rcx,(%rsp)
  34:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  39:	e8 03 51 9f fe       	callq  0xfffffffffe9f5141
  3e:	4c                   	rex.WR
  3f:	8b                   	.byte 0x8b

Code starting with the faulting instruction
===========================================
   0:	eb db                	jmp    0xffffffffffffffdd
   2:	31 d2                	xor    %edx,%edx
   4:	eb d7                	jmp    0xffffffffffffffdd
   6:	48 89 0c 24          	mov    %rcx,(%rsp)
   a:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
   f:	e8 03 51 9f fe       	callq  0xfffffffffe9f5117
  14:	4c                   	rex.WR
  15:	8b                   	.byte 0x8b
kern  :warn  : [   97.938632] RSP: 0018:ffffc90000177db8 EFLAGS: 00000286
kern  :warn  : [   97.938717] RAX: 00000000037a402c RBX: 0000000000000009 RCX: 0000000000000000
kern  :warn  : [   97.938823] RDX: 0000000000000008 RSI: 0000000937e23ad2 RDI: 0000000000000000
kern  :warn  : [   97.938927] RBP: ffffffff84f7f680 R08: 0000000000000000 R09: ffffed1021ad5530
kern  :warn  : [   97.939032] R10: ffff88810d6aa987 R11: 0000000000000000 R12: ffff88820decca10
kern  :warn  : [   97.939137] R13: dffffc0000000000 R14: 000000000027ac40 R15: 000000000027ac40
kern :warn : [   97.939244] ? cpuidle_enter_s2idle (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 drivers/cpuidle/cpuidle.c:199) 
kern :warn : [   97.939319] cpuidle_idle_call (kernel/sched/idle.c:190) 
kern :warn : [   97.939389] ? arch_cpu_idle_exit+0x40/0x40 
kern :warn : [   97.939459] ? mark_tsc_async_resets (arch/x86/kernel/tsc_sync.c:51) 
kern :warn : [   97.939536] do_idle (kernel/sched/idle.c:282) 
kern :warn : [   97.939594] cpu_startup_entry (kernel/sched/idle.c:379 (discriminator 1)) 
kern :warn : [   97.939662] start_secondary (arch/x86/kernel/smpboot.c:224 arch/x86/kernel/smpboot.c:304) 
kern :warn : [   97.939731] ? set_cpu_sibling_map (arch/x86/kernel/smpboot.c:254) 
kern :warn : [   97.939808] ? soft_restart_cpu (arch/x86/kernel/head_64.S:485) 
kern :warn : [   97.939878] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:448) 
kern  :warn  : [   97.939963]  </TASK>
kern :info : [   97.948803] bdw_uncore 0000:00:00.0: PM: calling pci_pm_resume_noirq+0x0/0x390 @ 85, parent: 00 
kern :info : [   97.948993] bdw_uncore 0000:00:00.0: PM: pci_pm_resume_noirq+0x0/0x390 returned 0 after 17 usecs 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240129/202401292109.f115a688-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


