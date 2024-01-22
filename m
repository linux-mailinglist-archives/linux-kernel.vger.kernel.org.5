Return-Path: <linux-kernel+bounces-33164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD905836579
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D704283913
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BB83D56A;
	Mon, 22 Jan 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJauv7QT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63F3D55A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933969; cv=fail; b=dcIboaTifWD4l+iDk1MGyHtI0C2lo7RwLDa6xprvpRXEAG+wvXt2KHQcnapYLdO9SomS2n9LOUlhg05//n5+Nz+GlaWb1AXHjbDPSCnopzGAs4V6dOzz68TJXB/gkxhDnLYzcWsMq9imicag09V/WZtsQriO+Mc/sKmd07xFwbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933969; c=relaxed/simple;
	bh=DCi/Jb/jpJ3QRqxttBEwraDlwFNp4zTXIzBjIppWJkU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=qmafCXq84VAUNk7kS4sA3RzdrBygvdghroOf4eO5T0h1C6Tjdnluuq+bzdfLo1TIGXkfMk9eCeiYycsS/pDwEJysYkLvFtNGCwEJaSrZqMhi9AOkxl31ULXYtx9lK9lJfOlsD60S1l6BML6zJ5kPxVmBOyvrNRTOgcrKg9bdyhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJauv7QT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705933967; x=1737469967;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DCi/Jb/jpJ3QRqxttBEwraDlwFNp4zTXIzBjIppWJkU=;
  b=BJauv7QTZDSGn/U12W6vJNf07nNIyHmwl16BwObeHtC48FgxQtFlku+u
   NcBeSOhb/1AAjpsABmf6wNGfLuXFhKsBZbH2FuUZCPFCTTorDKuQLhon2
   pVo9vHwA9SUdDwwAhkqujlMtWj7wmx0fMQXzYr8QPrixIQX0PD/soEZ/6
   7BLXLDjwZMsng3UAtXqNHTV5s2yyHVIfcqiqyPRAeeF4Zvzq97AiziBdS
   hWIXzoboBOZOdtPDYKeYyBXniNsjdf2XZRbOfossyrZYevYAJFCAUsyAN
   zY9syk6bAZWYbc3zKeZDuV//kilX0+Vn9xn5Msfbu+B0zx+qR9K+xE8rE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14563360"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14563360"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 06:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1307649"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 06:32:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 06:32:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 06:32:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 06:32:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+VhSgm8qcIU0LVf84qeoVJipiAisCqwYcZ+yz8Vurx9p4LiZqwxT7s5ooMd91ClYNUGG0KHO6ZZQ0V9fm8ReTr0oc/zlAyeEJrGuvfiMuNVQJDZ13IpXE5ek/ny9uxOowiIgckiiWBQb1F91BtTlMLsxM3chLqp8KqnjfO3Wb2WQpV/XFi9kUCSqpvjb6lzfpGMwEm4b6SaqyeetFQ7NWVu/LlT9wGFc9wIDfDf/RCWW6ZPs23cFrCid96y5JI9/hPHhIROQLXMQjh7BXSrcOmG+F9+mw/0YdChyFvd7duwmtx1NQ5lM3I80rZcBBXdUkUxVvqQFadu3jnPDdFCqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqkYcZxfZJ5rJ1jin75o8ATzWD+Qlhj8l4gAwN0xizY=;
 b=RG4lOd311ZjC2r8KSymX1hZIbCCY/6w1qq6BlPIRcCayCMFEJwJiVnJYYUqudEwjRh83fR72eZwKk7G/3PqRm8SBwbkqWXrFdAEBHidBxr0FhHDHUcN38najoXHpn8skaROHmhVac4DbdZNNuSUOZiVQvhEIaLRTLNXdQvjisdPSItNIrkoRg6DfdnjdT3rXyJEa0teNCedH/lzM4b/ezKxE3+5t1xMkCUD/754hz1O1W+uRT9ltxkB5qIBext/dIGfNMdUvquPxkmphcd62N236bOAo1ttPcM5Egbeum3MyCf4qYFE2sJlDlLuyaxN5AN0k0d8Pburz34o2BD/t8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8414.namprd11.prod.outlook.com (2603:10b6:610:17e::19)
 by SN7PR11MB8067.namprd11.prod.outlook.com (2603:10b6:806:2e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:32:40 +0000
Received: from CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708]) by CH3PR11MB8414.namprd11.prod.outlook.com
 ([fe80::ed34:4cf2:df58:f708%4]) with mapi id 15.20.7202.034; Mon, 22 Jan 2024
 14:32:40 +0000
Date: Mon, 22 Jan 2024 22:32:33 +0800
From: kernel test robot <lkp@intel.com>
To: ruanjinjie <ruanjinjie@huawei.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Lyude
 Paul" <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/dispnv50/disp.c:134:31: sparse: sparse:
 subtraction of different types can't work (different address spaces)
Message-ID: <Za58gfqV9jOmFRcg@rli9-mobl>
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
X-MS-TrafficTypeDiagnostic: CH3PR11MB8414:EE_|SN7PR11MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 468dc3b1-9772-4613-cca7-08dc1b56fcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfl9ppiEXhk9/eCcce12IBY7pK/UQA5RNwbSHtvVoLNMegaKHP68JUFK983J+BWzoWl49byk1bKTJOw6kZcsIlrefaM+9wW+PxNj1B2aYaASsdVoLT8Ne7SBGTdl7/nMiloMjiDNID0lM/Rdyo00JaFXp13gtp1WbJ30oaaG+toaehrvT9/go25S8XC0P6RUI7yfb70W/9w41jj1G8BVzy1IvZesjqrFNGCIkYzNRp2VRgyNfbyYurS2v5tOcb57L2leVcgs+IwhbGYFpS1JP7YRRWRICVVKUDsLxvoKYq93dQK8pWyedciIau7+lLyqnqI+jCnnglCFus/ro/psmfKyqePyY4J1b71dm65UCiXDhyrf6BcYpY23eA0w0gH9v7DrEpolwhgVSYxKW3EjqIvdQJXVrdjnvmFAzEzYIWblvY0SiTyh2OXmqqMaVhJYFm1Ad0oxIOdqMevtqn+bAi0nbmvOeucFlEmo7aVa6RPj2bxB7C3Crw8nxPkS4OMKHQUYWdq5G0N4uvonQWin/6WH+3dCnn/6AAl6jWWpBPG5E9la3xH2y/qtJxajs0Q5DlXkSxEbsFZia0kTrem+QjQTmdz9kNjzxuy14ADNcVYdxECzWgi+OJXboE16xxgKuvOFo9DkWwt3g4zd2LHmGx+p4wSvGL4H7vtXAH/ZQIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8414.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(26005)(6506007)(6512007)(9686003)(83380400001)(478600001)(5660300002)(2906002)(33716001)(41300700001)(966005)(66556008)(6486002)(8936002)(66476007)(8676002)(4326008)(316002)(6916009)(66946007)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3JSo9iVJ7mt4dGDobC9YgNUbrRudYNXkcL8lcUT8WDAeR9TOvSFpZcOOyW3J?=
 =?us-ascii?Q?Qcta21QdTu191olIRMF8FjCvlHD8wU4b7QTVUPml/JFMing/Cmtl1peOINxt?=
 =?us-ascii?Q?URSsBwCkeoi8wfKkMPtkkys3QQmvfcaUml0K7GMOfNvTYlZ+qPEy8Xs0q3YA?=
 =?us-ascii?Q?w+03e/uAWrGivnDjqy2c9kt3NlQZEhVVoKe48tVka4352HNp4dTbEE6t018R?=
 =?us-ascii?Q?ehfys/aWGQy+K0KADTQRsH0/oVkC3NE66jOHJgHQVHdh9/hg4/KDz3E6+S1M?=
 =?us-ascii?Q?RDwNLI+IkuwzqDFs9X9Q7JzrW95FbR6XUR5AWeOBzZEFTtjq0VsLP9Bhwgz3?=
 =?us-ascii?Q?trUtoaCA1++loah40mZb27hC2z8ZTxMJrtJoFtR7UkxGMn5/WctMIy8H0E9B?=
 =?us-ascii?Q?nyGV/DlAkLG/ypRbcmVNJ866obNz2pi+KxD78wSBXAZxJc+DDxRmTJ0GN9PG?=
 =?us-ascii?Q?dMsz5jYixuZgYfUfv2WDWWFLbq7hr4U4Kq//dXd9AiYPXy0mFThiJnNKNqEM?=
 =?us-ascii?Q?E2RE0lewQavz6HPiGwjxI/Vhlv+SeQinYcrRuvHl6+UrZhaN/MrfZpeA3Ok7?=
 =?us-ascii?Q?zg129AvJxeibLEd4RNlEEv89JDRkqAEfXigpbtcqE2X5v5R/dZ9gru3db9Zy?=
 =?us-ascii?Q?VxMzQdOLmG94DhrolzHnPn/uXjXLzoU+4Rcm1eFrLde1rtvQ/FAFsQsw7AuB?=
 =?us-ascii?Q?rjwC2keh4SXz3otamN35YRDS/n/p6Z1Tu1idCxF1En0ksf2LkGiuL3BBfot+?=
 =?us-ascii?Q?XdQfdYAm62mXp9K7ad+kcQmf5nON6wjM19YkBZo3EjZy49CKECKcm1hNFFlX?=
 =?us-ascii?Q?t8pHq26tp1O+YsECsLJLJMUk/M4r3/NTtrAg1hSFgMNDj8KNJB41tLIj/A7V?=
 =?us-ascii?Q?Hf3/hZK3zr8TN3yX1IejWqbOF/ywi9W8AJHKvFD6nNrOL4TdlTkwMihSgbe4?=
 =?us-ascii?Q?p/OKts4HxIdLSfhMGopqvadJl8AyM6gLD9yOZFmFsliaWldRYWSaB9KXKkDn?=
 =?us-ascii?Q?z5wh9Nnquz2tzJ3VWvLlWDsoUgK7jdbmUjDj8QlVI84XTgADy84POPbW94RE?=
 =?us-ascii?Q?+uXEHT5bfS58EN/4uYw2aG1KPFk+KuWt0ZoXdknBQMm51C5eWjT7l/t9VIHE?=
 =?us-ascii?Q?wS0KWqfvBS6X5kursQ0+Q6JF4UKYbCAIiJ6Y2SVEVgz4YCx46ebgCL9Ug7Ix?=
 =?us-ascii?Q?J65pxL/1RW7ILuOCG4ZhMlgw96RzDWzL1YGCVVahrSoosIXqVgrwmJBD+tKg?=
 =?us-ascii?Q?Rrd1sgFvIgC44B/tIoGviRl39uR5BRI70kVANUvE0hYnHKuQGqa0yKIw9BB4?=
 =?us-ascii?Q?1FdVu1dqhP8sWRzh2K00480oV0guxXlpsqUqc194g+IO8m1cjWGPqCJqB6ex?=
 =?us-ascii?Q?GV7avDt2B/hEjf3vQsqOkpYmH5bb3H7vMlh1YegTv/94ARd+yMH7yV01fldh?=
 =?us-ascii?Q?e7Uyl00ObYQ4teentUn+SIDY8darcJsvBoSV1DBoAWjUggfO9BxrAs8rNC68?=
 =?us-ascii?Q?Tee15/Df/zHvD5bbV+cWARM//nlAZ4NYrJNHUsmvP/ktFdnUUA6MwlHzsAIL?=
 =?us-ascii?Q?t10xvdqW6gKmO+s4CXke/KggeUQB3j8eVw0MFq8HRvckVX5lixphXdA1+sXY?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 468dc3b1-9772-4613-cca7-08dc1b56fcec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8414.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:32:40.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reAthBB6o+eIuWKzWGKc3zqTG8fz6EQKHsR63jVQeWIYCiTESb3ZztjO6In5kTX45sTep4ab2nsoRT66ZkH8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8067
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 9cf06d6ef7fd08adf51568b704ab7ba6007b6fe8 drm/nouveau/disp: fix cast removes address space of expression warnings
date:   1 year, 3 months ago
:::::: branch date: 7 hours ago
:::::: commit date: 1 year, 3 months ago
config: i386-randconfig-062-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071050.UrV4A3qz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071050.UrV4A3qz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202401071050.UrV4A3qz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/dispnv50/disp.c:134:31: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/gpu/drm/nouveau/dispnv50/disp.c:197:31: sparse: sparse: subtraction of different types can't work (different address spaces)
   drivers/gpu/drm/nouveau/dispnv50/disp.c:257:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *ptr @@     got void [noderef] __iomem *ptr @@
   drivers/gpu/drm/nouveau/dispnv50/disp.c:261:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned int [usertype] *bgn @@     got void [noderef] __iomem *ptr @@

vim +134 drivers/gpu/drm/nouveau/dispnv50/disp.c

2853ccf09255aa Ben Skeggs 2020-06-20  128  
2853ccf09255aa Ben Skeggs 2020-06-20  129  static void
2853ccf09255aa Ben Skeggs 2020-06-20  130  nv50_dmac_kick(struct nvif_push *push)
2853ccf09255aa Ben Skeggs 2020-06-20  131  {
2853ccf09255aa Ben Skeggs 2020-06-20  132  	struct nv50_dmac *dmac = container_of(push, typeof(*dmac), _push);
0a96099691c8cd Ben Skeggs 2020-07-21  133  
9cf06d6ef7fd08 ruanjinjie 2022-09-24 @134  	dmac->cur = push->cur - (u32 __iomem *)dmac->_push.mem.object.map.ptr;
0a96099691c8cd Ben Skeggs 2020-07-21  135  	if (dmac->put != dmac->cur) {
0a96099691c8cd Ben Skeggs 2020-07-21  136  		/* Push buffer fetches are not coherent with BAR1, we need to ensure
0a96099691c8cd Ben Skeggs 2020-07-21  137  		 * writes have been flushed right through to VRAM before writing PUT.
0a96099691c8cd Ben Skeggs 2020-07-21  138  		 */
0a96099691c8cd Ben Skeggs 2020-07-21  139  		if (dmac->push->mem.type & NVIF_MEM_VRAM) {
0a96099691c8cd Ben Skeggs 2020-07-21  140  			struct nvif_device *device = dmac->base.device;
0a96099691c8cd Ben Skeggs 2020-07-21  141  			nvif_wr32(&device->object, 0x070000, 0x00000001);
0a96099691c8cd Ben Skeggs 2020-07-21  142  			nvif_msec(device, 2000,
0a96099691c8cd Ben Skeggs 2020-07-21  143  				if (!(nvif_rd32(&device->object, 0x070000) & 0x00000002))
0a96099691c8cd Ben Skeggs 2020-07-21  144  					break;
0a96099691c8cd Ben Skeggs 2020-07-21  145  			);
0a96099691c8cd Ben Skeggs 2020-07-21  146  		}
0a96099691c8cd Ben Skeggs 2020-07-21  147  
0a96099691c8cd Ben Skeggs 2020-07-21  148  		NVIF_WV32(&dmac->base.user, NV507C, PUT, PTR, dmac->cur);
0a96099691c8cd Ben Skeggs 2020-07-21  149  		dmac->put = dmac->cur;
0a96099691c8cd Ben Skeggs 2020-07-21  150  	}
0a96099691c8cd Ben Skeggs 2020-07-21  151  
0a96099691c8cd Ben Skeggs 2020-07-21  152  	push->bgn = push->cur;
0a96099691c8cd Ben Skeggs 2020-07-21  153  }
0a96099691c8cd Ben Skeggs 2020-07-21  154  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


