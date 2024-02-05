Return-Path: <linux-kernel+bounces-52564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F96B8499BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A0F1C2254B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8F81BC31;
	Mon,  5 Feb 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFXYFcfn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B11C6A6
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134792; cv=fail; b=Pha7z9xfwKJ7V0Cvm46SSUdFVwVc+9qFZ8yi8qdExnkdB4oScXRsmu3lOFFScPTAKbyWxSXFBzpcvcnrgHpUKVozsy2uPDjXU06JMU7TXT9xauG1k8n9w270Kdhvvye4uhb6R27vXcmw2IEke2ZuXMKiMGkejIxC3fjpGwnbqqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134792; c=relaxed/simple;
	bh=opwaZ9t80++XA1juYSSUv+PFQKAJUEleajjLH6DiYcg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g02pHWWhvU7e9fMDeAG+cJIUfQBaF1Q1juMi/3roeUr/czs471W9UY3BkePWyWr4xGGeCCi86DAX+f6E9A5azJ9IIydo/DgHlwD+qGfk9Rim+EhY+CM/nOb0ei0Ycy0ddkJzHpuCG2d7iIgeBfwk/t1lmAvIr5mlBuJogv7jTjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFXYFcfn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707134790; x=1738670790;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=opwaZ9t80++XA1juYSSUv+PFQKAJUEleajjLH6DiYcg=;
  b=iFXYFcfnYePKkYazS9SO0eGceUSIUzJ39InpiNz/6IRgHFegFowtCVpS
   JXJJbP5gxSLMgEZFHmxUX0nXLBZ0Wtp9lx2Z/X2Deu+eJ59aN8gIK+ep5
   G6l29lnVSs6DfrlMI+U2LKU/CCDURZ6p7hawax7E4E0yC6oaJosmKPQ7C
   AUYIlKI5H8Q8giqKUgPqCtUGiOBRDe6eF2RgMQX4GzerwMjKYZC/jMfko
   cAZ3bjG32jtNbAD5JoE866QdA5cEsJZsIokFVEeUfxU540HnV4p4TV4Nu
   5Td/smuAFU9GK0owQbycYoW78iHMSZKZ5u7gQl5rEC/UEYItVFC97AGrZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11878806"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11878806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:06:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933138357"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933138357"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 04:06:29 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 04:06:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 04:06:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 04:06:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yj709E4HnzheGkpaIyzpIn/7yK7GQVpTIYdYB4/wbVTNtlit8Tx2DYKCbVGOWSEZNjP9wa6+qxvTyDRDQxtLmgn+KcRmO/sfle5vCizPvY+VRkWOkD9xqLE6CPaBhXIAXtzcJPK2zyyvr+HtRWpdJAdfBG6pu1vamqGSrWvV5eWbZczdtwVVsP4n2y9VVabHkL5Z6ZHGyjKsFwL8G7qJ2f58cmUi5qrLcrsWJ7JRGn4OYjO563RO3aH0fm0A782Yui3entsWJGM6brJtEEWV98gcMxHhq3b+jss8qdhxcsLFC4ijaXfMYgqmSuT2OeubnKcpmomID/+/7HHqEp+aZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xlAlvtL1a3QT2okPUkO8LP/3pQRjVmwl5nd0u8dPt8=;
 b=FfBwPz8FE32mtobaxUo8oVlrSRUW7zk447J8PbZ6BX+MB1Lp2TOGjTyC/ft+hl9D+oBzcXT5P2ZgaHk0M6o8FKedACaKw2/h473TY0yYhuAj7CB+D/KFnQXhI30nYcTV4w3A/hDwDXKNIPQBW973KdPQ2AILGF1e8mHN8h071JfDjSqjfC7N81w0c1TXCf9gxsAJiK59RdtXLHF8NTxcBmpnKahkLEo2NpBaZmOPhe/b8reo7mCttk4O90jSgGrtWwUbBfolHQYMsjSdxPtDsia3amFn2FM6RmqADM5FbUy/4idISt5yC30GBl0zdX4FtA3JTKMD7YzlBe9/t72qDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SJ0PR11MB5005.namprd11.prod.outlook.com (2603:10b6:a03:2d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 12:06:25 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 12:06:25 +0000
Date: Mon, 5 Feb 2024 20:06:16 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>
Subject: fbcon.c:undefined reference to `fb_is_primary_device'
Message-ID: <ZcDPOKDFJuvTXLHt@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SJ0PR11MB5005:EE_
X-MS-Office365-Filtering-Correlation-Id: c31c9f10-4810-4572-4818-08dc2642e058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRTUqN5mPvW9R7MfkAZtOapDfCie8XXBuRZF6kTbz2ReNIqHY5AqUhO25iYY9npJbW+CpxnrX/WM9yzw+yaKYlVowTsDyxSZ3vwNi32U9DbpYWdpgeUdRKIBCZ96/9SY1Ne4huc14+H2UCq/o3OBPWM4KV631h4AkgqWDjw+e9fndI3C1VYVZS8WDv1xq1THwmpDUkbZNmqbsRvfepdMkhHl+xRUDVmA+1XShPfLSSaMdUCi1z7cGsqR0H3Ifk7ur6aRGsSFEejLEt/ImRWlOBmNnLGEJepCj5A93411Y/0XMpOM38T9VARdI33CRtUNncfdBv/hhTIjbsaKezZVxKeyPEyNXziN55TRrDbHOoPxwwIdZZ1dmKuA7lszuDGYTsKdexRQeG/k2vlF8nzOYlCgPUH1UL0Mhoh5tVZthAYk28NizfXmkXVmBZAzdqnpDnmY9FQ1fq+NcKiJjFg3zsfXDG6g9C0EPEODkScM87WcIwy3ZL2UjbQQx5HjrEd1Dj9eOMv/+edjgcQCEm1so2hMNFEo/qANdme39WjuybNk1M6dgLmVI0tDbGqtmVaEouerEM4ywqsV6d+0s/41cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(41300700001)(82960400001)(2906002)(83380400001)(6506007)(6666004)(26005)(38100700002)(6512007)(9686003)(6486002)(966005)(478600001)(316002)(86362001)(66556008)(66476007)(66946007)(6916009)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6ocU09SHaDJGbRWsgvv0Z+RoGM6nOtHXVMahBqYnOVv4USZUHx4Hm9LGvE/?=
 =?us-ascii?Q?G1ghRRsZiExwddio4AyDc4aplAIYxj0VkYh8nOQ4+wkMtL/3gfVOM61ssORK?=
 =?us-ascii?Q?9Hcc6ow58rD8a08hWXVOytQUD997YtlCQztp9+XEEZcjicK4LDvKTxoOPoLp?=
 =?us-ascii?Q?pN2Jg9NNEjOg0DbZCcVUDOkPGNAFZv/dW7PeWvRCFahtj9gOB4T/DeXfLmQ2?=
 =?us-ascii?Q?nDoZwQUKcNDu13X3kc6YIzjBdDDFLdjc/SMl8PjyY5C3oZdKUdvZlFFE6Wvk?=
 =?us-ascii?Q?wJOAPRJ4RtnyOWSYNZJe14D2S5NfDNRAIffClP72fti3w4mMMr0o9yY4Ar3Y?=
 =?us-ascii?Q?VSm9rA6ghkd03BixOwS9c0MrRgWMRkhEUprzEse1FRxMHD+NXiwDgN40DBH9?=
 =?us-ascii?Q?KWoDbXyzaiDzQRfs5q8gwOTqPC2Qp4EjafxrF5njb8/aGu5ObZU0S6EF8FTo?=
 =?us-ascii?Q?Y676wib5FO77uW0UWLgkJI9VxZ5pSEOzHjKVOk03eslUdTbgML8iB0gjnVpa?=
 =?us-ascii?Q?1hAyl6ggj9EvO5y/K97+YOpvg/vVky8IfsZKEkK/iMIOWY/aUpX2Of56nWlZ?=
 =?us-ascii?Q?unKiUl5MpBxvSCJmi6hDEUqE67gkqF3QlqDbAjjHATTb31RFT2YNIDQFisXx?=
 =?us-ascii?Q?y+FLnKPzs1+lDMNxmyrkRiLnFmZwhSKOSehLJhTp9sphNKfE/Dw6F/mxW0x+?=
 =?us-ascii?Q?EiMWU0K0y2UYWexjEVZDkR9e4L46KniuOWoHF3qAL1tWBLTPHK+piyknZ+ry?=
 =?us-ascii?Q?8g0x1utPJkDdw3ybeTuu/WOiIQ508FxGhwonRiM/KwcNC0Ejzi+58HCfDLW9?=
 =?us-ascii?Q?R2cSiZZwa56MXpPNnbCdohfV4HysaHAisL78x3biJhDMSS3moIrFtgfWS2Zz?=
 =?us-ascii?Q?nTuLuE6dCez3FIxkbpXmAslsFTpJH+cebMDqXLf2mwVPDaa9SafF+ie7qwei?=
 =?us-ascii?Q?skyC7VUs6QThYFkhbXt1e8JcQLVD+nEiJ3oWpe26qE1/hXtOxS4Wc5Cvk9ar?=
 =?us-ascii?Q?SJx9G8T2/ejZr7qbyKmD/w302lAkVElWfZhCb+4uu7h8qBCIstdAGe01yaTq?=
 =?us-ascii?Q?chtrBZm1fC9iV424DYeXI+oYixKaGbXrW+aNCS6/xYhmKq3twDwBCiLrA+Z7?=
 =?us-ascii?Q?3eo98LW+kgajnjUKTrdpSPi/6GzMy6QtSe1Udz84DARQfQCh2Qf60qrq3AFD?=
 =?us-ascii?Q?T6rV7p2UL94adQng8YrL1wFT3HGo6ZrIOY02g6AZ6q3dUnucLpP19yFXp0Qt?=
 =?us-ascii?Q?YeArNVsCqj9z8yhNweZEVWTNGSOybAFti6/H/68DwcdAEgj/BxectjbxdJhM?=
 =?us-ascii?Q?9Jj7Q+Kc5mrfVKUYalCoWjMXQuClFYDQwhzietPMKQPEXcxWapSgjC4+DM21?=
 =?us-ascii?Q?83sy6/3NpjpGeBn3X9deQ0eYdMVfXLjz1aQEAZn5l5xsHdqy7T7sZdwWoRBI?=
 =?us-ascii?Q?f5FAucEgEMRcYb2S74PG3gR6fPGQrW212YBy8W9tIBV2bVpoD5cPpNt+I3Ch?=
 =?us-ascii?Q?ln7ld0BRKLA2LM3eSYCY3yfF+rC0HV/Ya7lr2c1qvPEjK4O7eWa/BHfgIVJn?=
 =?us-ascii?Q?NVPDWx2fguQ1u3Z/KPhGCuGUOw023lp26xmXXUhA0QN7htwnQJhk9asCyJ/N?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c31c9f10-4810-4572-4818-08dc2642e058
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:06:25.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RLqeJICHL+UtfmlzIuexIvkQW+4TMWnkYb8CSADfYMMwCdNo8rIxoojcGIxrlosT9z1sRqHAWldgEjt8Y7RdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5005
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a696a29c6905594e4abf78eaafcb62165ac61f1
commit: c242f48433e79ea8c8c9eb8d2b4a3ee340e635fb drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled
date:   6 months ago
:::::: branch date: 26 hours ago
:::::: commit date: 6 months ago
config: sparc64-randconfig-002-20240128 (https://download.01.org/0day-ci/archive/20240129/202401290306.IV8rhJ02-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401290306.IV8rhJ02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401290306.IV8rhJ02-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/video/fbdev/core/fbcon.o: in function `fbcon_fb_registered':
>> fbcon.c:(.text+0x4f60): undefined reference to `fb_is_primary_device'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


