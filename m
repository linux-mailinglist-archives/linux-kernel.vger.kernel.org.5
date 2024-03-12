Return-Path: <linux-kernel+bounces-99929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FC8878F51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5FE1F22245
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FAA6997A;
	Tue, 12 Mar 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0rIPTBe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C616996C;
	Tue, 12 Mar 2024 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230181; cv=fail; b=blZ/PK3aDco1+CX7Wp1fjC460JCBVlOLy7RYtDw69sfYLv42Ny7GfT2Czns5RwqMomYjhQyVBqnqRXTM+6WcKdydOCageNqLwGJ4pVcifyllw8J/XQM+8BM4cwQUNFU2jdB64mKaDq+0JefBAghm1uxLSTdrLvBU45F1zTvRRck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230181; c=relaxed/simple;
	bh=rafoqpCxO8LrS8YmrXis8PDNxGsvD/wgl/J5kl/Eucc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIQFvEdgBFG2IWTc1gUCY3L96gxC6fYJhXHWp07kO5tSdhMQus2YLb51rt6eCBfrseW/3jFvB7s6UkBx+MPDZKGHwKSkXxHUdgUCdRAuEYINulc+XiYdHYimP+3Fvzlx5diaGKMVIufHIc+VH48ODcqoGxqUEfY2lQlKsILxtdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0rIPTBe; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710230180; x=1741766180;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=rafoqpCxO8LrS8YmrXis8PDNxGsvD/wgl/J5kl/Eucc=;
  b=L0rIPTBeh8ma/rsbdviWHaeqdf9+PvfwhSRSGQG3imBSpnYug+VRbRUF
   jdgCnmO8k4HQi6yccGgtzEruZSd03+rTZHVYD45365V+TKPzXcFu8CGHT
   0tXwKs5rm2ew3KnoQMYJUCVmV8v0NN6Xu/k7+RINAHp5chskpXk81fK27
   OQmFH+dbmr9D9FikVpwGJkrcyCIdI18z+R7auPzSoSa0ucabwFYsIwk+R
   dYYDBOYf+38p/oLgF7+YUZSl+7dsxsrUU1I6LiBoGFKkAfj4TS7XdYmgf
   RaF+xak9MN6jxKVoK/AiD4MaLlh1SkVMA8NsRfNa1CvcmhYxn8z3r4/Dl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16067645"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16067645"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 00:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="42373323"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 00:56:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 00:56:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 00:56:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 00:56:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 00:56:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhL+ZvBS+JkN7DBYYDVBfWTNqzjMfrnMf60kGUdQZCqkNX0icScYhr3WEEBeOzJuyduk3kM8mLG92DKQT4tvWDoUE3TpTR3gC9SxeGoto/4Ms39t3bHjyFUH6LcaHUQRgqqun2N3z3u7YLU7Gw59aak2HpsU3704N5fesAQYiJ96OwKkgl1k6OQewyEgLCkJJj4dzx5eiMczY3DCWAdNC0xvi4+4YuTvgyqrWuOaN9brf8sGGMYp/ZpUTeZqx+Ret5FqGpwRKJ9J/yfLqzP/NtGjd5K0vFAL0EcaUz+lRW78CoOGLZpM6If7xoC0Kx5tPi2+ORUIK+BwdQJzysfxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5Zne8ogH/ezc5kAzjiDHeoybC6mVFuQyUdp3rDX7CU=;
 b=atAfKxxIFtmw9JoFd1guAwHvxaMEGxVCH78VD3NSzssSXHvdHNfdie/5LU5chOoFIS3Lps4lkFyugTMxu+SHEMWbGTgX6vr4g8JOIhjWxHOMzu/RPYaRCMkpwQSqoNKh67CGO1kcckjnFF1CHgyy7Fkxx2ahFoJIr78OnwTi/HIoASSNTKqc6WQ99ttdHddrIfbwRW4OVTbuiGhtK/6pbA4qzCSqyL/AgGFhtz2R16JWU8p3wsgcY2NY25ry8FW8xRF1XNwsqNSZ/azmkc48XjI6iWJ+oV7RUxOp25ecI3zk/R07kZoYODKA8GeiQ1EZACs1NFv1EbZkteFXV3hjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6569.namprd11.prod.outlook.com (2603:10b6:303:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.15; Tue, 12 Mar
 2024 07:56:16 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 07:56:10 +0000
Date: Tue, 12 Mar 2024 15:49:23 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile()
 falls through to next function ovl_create_index.cold()
Message-ID: <ZfAJA75rk5qPLWBM@yujie-X299>
References: <202402260556.0rujs05e-lkp@intel.com>
 <CAOQ4uxj-PaBHNjYYVAVc=an3BZTt-C9p9etWAmhZc1udU7PN5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj-PaBHNjYYVAVc=an3BZTt-C9p9etWAmhZc1udU7PN5A@mail.gmail.com>
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: f72bb2ba-940d-4460-cd0c-08dc4269e131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3jpJublXg8gu8Zr9mes5pk1f0M6mexAz96ApgZO3ccVmp/DW7aJ1PFp/k1qmeL4LYzbwHsFUhd6VNQZ6T8bdegW0CDYIPJwppU2U2wv4h1Rgdp/A0+jvDORwVLRK5tkkppQtekSSTFS8gnQdwpQqZeI6ZM7aiWGICWH8/UhNQHCkNV9Auhevpvsnqtu4mzethujIJ9Vty6n1DgouQmG/l+qJ02q7Lap4OTM93zKRpbVAEO83t3vCrZ5dVljGTe0YOTvGi/5kEbb0G980Ld9bF9NNud7BLXt7APCPm4P3jQY9N7mJulAqi5+jz1K2Tsz00IYiXpXIuxO2Du4whxR7TSMkdjj6aCK9nX56ItdsQpvTVh8tjbLbQcXY3+GmhcQY+vOzlgvzf/DzTAUGFFdt8X2go9T/h4FC/vS+zr3+bUr0hjr5XS9atLeDO2TSSXUc2DOAoBRtXRGHRMIe44qh/2TrzQeXmpPEoQaCx8D0mEdNlzaB38neNX4oFwtmk4Qc2svHshuf76FPkA/5iKoJX6WGVrMJUmA02qVSp4ukTlUj8uf0lhPXmk/W9NBsqL1lpfL0YG0pTbZw5oSuCpEM2QcfI1lve1zUlrrsTyLVcuAcwgz+Ly4/pnUc0O0DbFu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFDcTEvWlRtZXFsSlhaVEdpL281VysyZ0ZyU1Zkbm1wOENFRTR5TWNNcFNB?=
 =?utf-8?B?SGFJVWhjYnlkKzdLMEN0RWpjZ1NNZ3FSUHAxWDU5K3NYWHA2RWV4NVUzQWRG?=
 =?utf-8?B?anVKS1A0ZzJ1UjFSOWdNOVd2MlFhWHhYV0xHcWg2eEp6N1VuOXNSSHQvMEdi?=
 =?utf-8?B?T3hCU0pYNHVoanlJMitIRlZLZ3RBdWlyOUVFcENJV0FuVkVjNWFpVXo1ajlJ?=
 =?utf-8?B?Q1M2YTRnVkx2RWswSlpVcFg0OWhlTXdyUzJIRVZBcUg2eEhoRmhnVnVNd0Vu?=
 =?utf-8?B?Qy9BTjdEb2puNWxRVDQ0K05zODJZWFl1MHp0ZEpUb0lXaGxmLzh3NVdHSGdE?=
 =?utf-8?B?akRFelI4eE82NnQyQjlNTjh0VXU3WURNazNKd3FCQmlwWVJZUlhQeEpXa0F1?=
 =?utf-8?B?UEcyUE5MTXc3VzZSZ3l0Zm1zcEpwSmJIbnpUZGdDS0pGdnVXd0xOcHBTOTRI?=
 =?utf-8?B?dVZSZHc2dXJlUFB6Yk1WVEVOQ3BaNmYxNFJkUmx6UEl2Y3V2cWhqS05OYitR?=
 =?utf-8?B?MHl6TTUzRkd1N3dJMXhSQlYrWWRDNnFrMkRBMyt2YXVjbGlLL1VvNFRMN2FJ?=
 =?utf-8?B?Z3lHRUJrNjQ2cmxxaTVQZGdVR3pJeGlwMGZyL2hNcnBJMmVJaisvVnc1bS95?=
 =?utf-8?B?WFppUW9oS1htb0V1dmJaNHhBTE5yWXJCRUxVaUlpaUl0Y3N6QzdQUDFhSytO?=
 =?utf-8?B?aER3S1hxUENTa2U4cTVaU0pZd3N3NFZVSmlyYWxSWUZCaXZqTkFYdlVrU295?=
 =?utf-8?B?L3NJOHR2NEtzaXpsSkVoZmtkYmRxOTJNVlA1c0xtSDhaVlloVmFWdzBFVGx6?=
 =?utf-8?B?RnlFN0xOYjEzS1hIS1VtdHJwNkpMOUpiSk80OUNFWDBPODFNMDd1LzduWXF2?=
 =?utf-8?B?bWp2K2NVZGRhWjhMLzZwTW9LQmRvQ1g1ZmoxeFVXMHNpT1Z4UUwxeDFoaWlF?=
 =?utf-8?B?cnhLdkdIMW94NWcwK3RicXBuL1h4NFlXelJoVWJzdVhYWlBLNHpqeGpLbG95?=
 =?utf-8?B?RUFwWE1xR0p0eUFNYTVZVFBtVmN4YXVpY2xVY1RKVXFmcm5GV3A4R09JbG13?=
 =?utf-8?B?WVJ6aDB0TU1ZelVUd0tTN1MvU1hSaGpFM2VoT3BQMk1lNVl2T2ZoR3Vld0N0?=
 =?utf-8?B?Y09NbnVZRnh1NEtwWXRWSlNqVklKQzA5WUVhTjMyS21jbjF4WURqYjc4Wkdp?=
 =?utf-8?B?azFDWFVwdDFsbWtnQ1FXa3FsVSs3NmtOZFd3MlpIWndPWmswNnQ2MUM5dHFm?=
 =?utf-8?B?RmtKQlhyTTBPZmpJYlBUYTI5Mjg1QzhvcVRPUlFBZUVXZFAwVFlML0RjQzVK?=
 =?utf-8?B?WjhqcWJMWGEvV2V6WUVNa1NpUkVlNnVRb3Z0dnFwNGtQZys5Vzl5T0dRU2F1?=
 =?utf-8?B?SmdYSllhL3N5M3lwSmlJZCtMT2wwdHBUM0g5QzB4N2RxSGpCNUVEaFYwRlF5?=
 =?utf-8?B?WEpucmxCaitJUi8xU1h2SE9YYWpCcGNRMlRMSDFFQ2hQMjIwWEFhbm90UWtN?=
 =?utf-8?B?QzY5SkZzMjVNUWlBbmpnckdZNkxXU2w1aTcyOElMM0Vpc21ZQzVOMmcvQnA1?=
 =?utf-8?B?OVR5SDBZWkxqY2NuaUFQOFJzUUdNRlBESnlhUFEzT1drbDhwVFlNaWwyQzVU?=
 =?utf-8?B?eC8xL0tRYUhWNk84MFdNVnEwN0V3dkVGSVBMcTAvU2tZVHlySVMyR3hFQ25w?=
 =?utf-8?B?dnlsR1FJVFZUNFh4VjJ0ckgvRVB6OWpRcWRlRXBuVjhqY0QvYWVaOHg4NVI0?=
 =?utf-8?B?eEZrMjJ0SXZUT0taaGFHZzFoclNDY0wwdnhtU21adFFMRFRuSk4vK3ZYT09r?=
 =?utf-8?B?VGtMeWlPaWFROUlQcnMybjZwajJBY1NEcU1iRnBReVRXMWx6WU10L3JHTnpo?=
 =?utf-8?B?ZTY4ck8wRWRZTHNPbTZTcWRxQW9UZ0NENFZFeFZCSHdXOWFTMk0yWG1Ra3kw?=
 =?utf-8?B?aU9qczY2UkoxVnFxcXd1QS9obDBlTVBwQ2dCQjdzRHVGK3RlcXJKODJEdDJL?=
 =?utf-8?B?NUVxZDBSQ3pzanY5bkxyUG4xNkYzM0tPaHpqMXBNNW04OEpuTms1RURmR2tp?=
 =?utf-8?B?RGRxQzMrT2g0b3RoR0dSd25melR6YndndFA1S2JTNzZ2aGNLdnFQTUxZd2dN?=
 =?utf-8?Q?UC9xPNIro0JpO4JvHCrSisAXN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f72bb2ba-940d-4460-cd0c-08dc4269e131
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 07:56:10.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DClb8/JKjP7rlb9WtiMVSFdrs0B4TK9GWc5PfagECA6LleqMH34HMq2PSPHLkZuCaxMBiAFpH+ksC8W7+UrsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6569
X-OriginatorOrg: intel.com

Hi Amir,

On Tue, Feb 27, 2024 at 03:56:53PM +0200, Amir Goldstein wrote:
> On Sun, Feb 25, 2024 at 11:25 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   70ff1fe626a166dcaadb5a81bfe75e22c91f5dbf
> > commit: 5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77 ovl: do not encode lower fh with upper sb_writers held
> > date:   4 months ago
> > config: x86_64-buildonly-randconfig-r001-20230616 (https://download.01.org/0day-ci/archive/20240226/202402260556.0rujs05e-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240226/202402260556.0rujs05e-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202402260556.0rujs05e-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> fs/overlayfs/copy_up.o: warning: objtool: ovl_copy_up_tmpfile() falls through to next function ovl_create_index.cold()
> >
> 
> I have no idea what this is about.
> Does not seem related to the regressing commit.
> This:
> https://lore.kernel.org/lkml/caa4ec6c687931db805e692d4e4bf06cd87d33e6.1460729697.git.jpoimboe@redhat.com/
> suggest that it might be a compiler bug?

Sorry for our late reply. We rechecked this case and found that this can
only be reproduced by a specific version of gcc. gcc-12.2.0 can
reproduce it while gcc-11.3.0 and gcc-13.2.0 cannot. This may indeed be
a flaw in gcc-12. Attached part of the disassembly of the object file
built by gcc-12. We will configure the bot to ignore this warning to
avoid false positives.

Disassembly of section .text.unlikely:
..

00000000000000e6 <ovl_copy_up_metadata.cold>:
..
 155:   e8 00 00 00 00          call   15a <ovl_copy_up_metadata.cold+0x74>
 15a:   80 fb 01                cmp    $0x1,%bl
 15d:   0f 86 00 00 00 00       jbe    163 <ovl_copy_up_metadata.cold+0x7d>
 163:   e8 00 00 00 00          call   168 <ovl_copy_up_metadata.cold+0x82>
 168:   0f b6 f3                movzbl %bl,%esi
 16b:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 172:   e8 00 00 00 00          call   177 <ovl_copy_up_metadata.cold+0x91>
 177:   e9 00 00 00 00          jmp    17c <ovl_copy_up_tmpfile.cold>

000000000000017c <ovl_copy_up_tmpfile.cold>:
 17c:   e8 00 00 00 00          call   181 <ovl_create_index.cold>  <--

0000000000000181 <ovl_create_index.cold>:
 181:   e8 00 00 00 00          call   186 <ovl_create_index.cold+0x5>
 186:   0f b6 f3                movzbl %bl,%esi
 189:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
 190:   e8 00 00 00 00          call   195 <ovl_create_index.cold+0x14>
 195:   e9 00 00 00 00          jmp    19a <ovl_copy_up_workdir.cold>


Best Regards,
Yujie

