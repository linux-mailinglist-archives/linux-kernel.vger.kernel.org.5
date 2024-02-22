Return-Path: <linux-kernel+bounces-75787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745585EEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70CCD1F225FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8414296;
	Thu, 22 Feb 2024 02:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkArgNoI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB4125D7;
	Thu, 22 Feb 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567653; cv=fail; b=Rk7+PUP6b4ORrYTbH+siRSZrg3cDivcGcVkUm4ce/Ej1ZTgn0NayV3mYQMBzA/AsBt10dagQ/5LPk5SM9CzlCdR94OjaxRXTfwAHAvwoqVXlVpjQlRjKT4Oa+lc5EevB32V/UIBJrLfzzb3ZXaM+/Pg+bwejZZ8cxIAQY1RgQ74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567653; c=relaxed/simple;
	bh=0ycEKiEGE8JChPz+GxJA4Xe/DMBc8y01Dijz3bx0MGI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=H9h3T5hwQpifBLK2kzF0v1mB4igKlM74aL0XMYePOSP4UlHLVF6TCldtE5eRWtQc65YUTrI0Yd6sHkLYu5FHof/6A+vBDxQRSdP1VAQz9aJgWu5qgpkhueew3oJ2bZ/lIlmOKowgBpqV3pwZXKMuv4Ib8KZ8yChF5NAj7rkoRXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkArgNoI; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567651; x=1740103651;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=0ycEKiEGE8JChPz+GxJA4Xe/DMBc8y01Dijz3bx0MGI=;
  b=HkArgNoIelZYyrrNiDeUNol7wWwtqSx8BC/5pL/RVd9TuKpwQuHycjhX
   z76g3THNznUY2voPS+EnTNUHNGl7+v5SA/HiMcWmPZmxIDEUJ3jT2AJxa
   zPObSidwFOddJmP4AX7zGvVkeTv12Enlnf2PZT/mfpSorHa0J4cXjpjkW
   akY+NCPGcfm+qiFIsH/Aqc3kgm5xsFwRHs92aMMzdwLLzEYK0X02ksRH+
   PlRPva1VMRByXLoP4AuapZkOlcLXoqmW0TF+u/lYh1wHgz09HYm/dxYeW
   iknCVvhLssVohp8sMEdhmN4aJ7+1ou/i0nDALx4DEf41aSvIIgf56BWxC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2893250"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2893250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:07:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5639449"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 18:07:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 18:07:31 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 18:07:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 18:07:30 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 18:07:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBEFZD+64V8lZXDRFnRn1x4y2pf9QbSTY+IdjYQBqEDlvNS15yU+5/COu5KRLIZ9AzuRCZwuXu1dPeNc5G3ZtNzHPCF+HMrbf11uLOxGpgF7VERzK4+fpAk16zC7pKNjW+CRVsrnzR84se5MFp0qI1s143JJh8pNBYtA6t4hS2GrUdELUr3IkpXGalBzluExbkD1Dr/JoRe2UUUnCNPHpn9WNLTIyh3A7s/cNChaI8lVaQNOKIhLgqte8EcLstkxsbSey2L0AJN7qaYTosj6ED4/hV2g7YwqF4woEiJKP3Q2xYgR9wk4H9gl12S1ag9eqiUmmQ1iLwDloR7Mii3TvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM0ai0bWeRI5Rb5f9FE5WAeSuuQHk3FWFeVYcYc4tng=;
 b=IMF90MTejhobn00cWjiQ9bX3EpjvxQNXmT2f4YUgiQQk076xUduD8AkAP2Dd+RrGRkKsx08AcqSQeoI+tZnzf6VFJwPI5zHrrsZ7kLQP5sdufA0rNP/IqylB8hFLcE19F7mDTSgPY5r0eNW/5oUa5+9MKwP9PcUOEOqq82aeoimEnm5WhoOjly6gBN9MxSJGBBX6JBxHup1PfR5mbGznOAsToHpCbCK4UqUijCc0Hr8Z5xexYCy7ng/t3owZ5PsdYQzHTUH1gTUVoKMB1JxWKGN1lCM+90yMB2tEbA4zU0soBd+2ejN82ISS5f6gickg7BNWosxLmAU6dzWrVhyZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5308.namprd11.prod.outlook.com (2603:10b6:408:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 02:07:28 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 02:07:27 +0000
Date: Thu, 22 Feb 2024 10:07:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Paulo Alcantara <pc@manguebit.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Steve French <stfrench@microsoft.com>, <linux-cifs@vger.kernel.org>,
	<samba-technical@lists.samba.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [smb]  55c7788c37:  filebench.sum_operations/s -5.8%
 regression
Message-ID: <202402220939.82e05c80-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 220d9d78-ca26-43a8-4999-08dc334b04a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6k8A6ISPUeAI0KcclPBTKMziKZ8cnEuqTjc841kIsci3LuHcsmMLqFiR3B23rmjjwIyy5yIzH6E7mqDWek9/R3E3FVDrxIPaLgj5sYxKXLwvlgP1yuFJ9HHAt1NZ43x0Sv336dzBB6ohvIbyvHL34e2MXtUqDZCbRdsJX2H4IHNglnkLuRWPNGHz1LmZ9OGWF4tXSbTiI1UvfOl0QMwJcRZyMRZgyCcb7QDQGDr9eXscbNaqHJXRRKPiaFtne/pImPY+vrmVVyPhF6DE+MmVCOVjTYGm5gYT6Wk8+TDY6dtt8iykITlc/FmI6Qp9B7ZfeZ5K6jp5CQhjtVOL+XNarm1EDlUihQZh+hNtIC6/Q9/jCSf/82TaGmQ9Suaa7wujVuAgo9Z/vKjBu+may1nmJRseopNII3drA2Utr9dHyijqfgo5O5t0hPFuxixN9ZQhfC5leOHrjuUAIR33x2zp85YffQxlHD+yZwWa/4mp8O7DvXW8L/HvBt8zwu22B5HCbB56nGQxmgtlvHThybI1rsWKJ4n5B9vgxsRr1hiBwxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230473577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q2qwdzQFApY70O1FVoS6MvbEQpUTbTHcqcO2MDPTOa5G5/sACjYmPFnz2f?=
 =?iso-8859-1?Q?XfbBpNIZ17xpTDUq3TRDsFwFibIrRMJe65eWDkVTZ/2pcI4Txx7WY5PUDZ?=
 =?iso-8859-1?Q?OMZjSiKX/R75xy34XiV+qBk3Ckb+yEJBskfwa1PLAxAv/d2nFYgQrSHZA7?=
 =?iso-8859-1?Q?r9sx8BJn6K+4jF7cS+tutjMwCGXC6AeoWi9w/hUTQymBMPqoHn7SlsTVHU?=
 =?iso-8859-1?Q?GBm6cSEE8tDybaKgD1WqFppg81GlCkNAW3JZANjsCr6C6qPTTrZH5vV8G2?=
 =?iso-8859-1?Q?I23yVIUfkxP48p9Hr5sL8gnJBKnloLVDZWrdsDVH/eeFDfyW7KW7Nto+kv?=
 =?iso-8859-1?Q?C20J8VcsNE3eJT6HEsYZiMFm3/3CgqUHC5wUV8zk1Z8/nJvJP4YSVnOeuq?=
 =?iso-8859-1?Q?hF1IPAjqaCHi5NSpsRy0YJe04OCUROEkHiG99jraQOjHwt25UofsbCjEtR?=
 =?iso-8859-1?Q?TliS2yAMfcqyohdBnDS2Tu1SbLxLVnHS4Jwd4D0bO/izN0UeEIGq2O7TNQ?=
 =?iso-8859-1?Q?k4Tbns6tOunlRZZ6w4LqveKNCUAIynpV1bQd1C6sNLcteV1BQgKhfpt90E?=
 =?iso-8859-1?Q?e13QwaL+q0MLq7WeBSOgOQKVfziNEnsK7ZA1uSADBjYNdx3pl9KRtTnkyt?=
 =?iso-8859-1?Q?GNA9dQwpIF/DwOe2kGFRW7tVBf+7RuFB2MAbFvYw1ggJB1qpuNSf6IKMGx?=
 =?iso-8859-1?Q?7abR8xecQUf2nAzKz4qeFHLVQyjZTNCqdBi/IvMArIVIhCUmzKn1K8FOIj?=
 =?iso-8859-1?Q?QKtk7XyLV4ihiNK58QIXMrLVX110TWhP+z3hSkS8o+I+SkOFdpTQWtXZhI?=
 =?iso-8859-1?Q?NmbgPidtlSv/wLbng0LPJ3NgCdyIK+HE/7N8dtskvYHjllL5VQKkZiwv5B?=
 =?iso-8859-1?Q?sNZeGBoxLSoxOye+66jNybJVbb0ivEvz6ZxEiRczefol4eOkHvBSrcpLdt?=
 =?iso-8859-1?Q?P33BTnuLfJWoa9Q6FzECxnOXYBzU9NWzA2yiKfgc7mDAhs3Gcb6MmQ8LXL?=
 =?iso-8859-1?Q?RFI7dz8OPGaIR5twhazshW/FeN8S4UFbLnh1rv0tO10VmLQeiPvZWxm9gM?=
 =?iso-8859-1?Q?KEn0HBdjkdV1gfrt7Q5WhrBKTbH5HrXYgmzY7SgW80le9ByMiwHR0a728p?=
 =?iso-8859-1?Q?j6XN60/Z/lOAOKHjr6q3UkN1GIM4jLDFWeuJRHU9ECj2+M33BKqvVKsPV4?=
 =?iso-8859-1?Q?A30OeG6y3UbxznYseIKc5CMzIr6UQgTBFgT+/bZ4BWXww6D2VzQlOKOaxQ?=
 =?iso-8859-1?Q?wiq8EH/1hB07abMfVBQkt7Gid5dfPNPn1WT2AxUFT3sWoScyik4FJiMRkr?=
 =?iso-8859-1?Q?Y/LQEV8HY5wleQpfP3koqvPtUh/UvTEBnNpPe6XEKHAEKrHS7p1Uuzq8+r?=
 =?iso-8859-1?Q?eaglgWvzvc947z3GvJgIRW2TgyX7OAkmy/7L6oYJnM7SOjbfDjzW/PHGiw?=
 =?iso-8859-1?Q?X/ogfwvhYs/q+4Sy6WkgruCgWJiXI13DDah+pZ1WhroE847U5AtpP/KJCD?=
 =?iso-8859-1?Q?r03NnGaHnCfgzdujV3ktVujig9AlvuAn4tDkq++pQ0foCkheFLjIuqjOpl?=
 =?iso-8859-1?Q?zeDT1gDXdyS9Aq8DeO/5vyKYoI0oS7Ug/FCbmxLgARmWobMyRiaA4MuRar?=
 =?iso-8859-1?Q?lv3jiK5AkuALV9R43f9h3Ef9yGp0w+sLpxuFobVnlOl/1bW9jD9lQVkA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 220d9d78-ca26-43a8-4999-08dc334b04a1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 02:07:27.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USrznuaWTKhH4mSbqV2L2Udy8PZNOv35hPiBkVbZfoPa12FiUpKEa/1J0JDOTnj2EReWmnoJCE+3GPZE8OY5RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5308
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -5.8% regression of filebench.sum_operations/s on:


commit: 55c7788c37242702868bfac7861cdf0c358d6c3d ("smb: client: set correct d_type for reparse points under DFS mounts")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: filebench
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	disk: 1HDD
	fs: xfs
	fs2: cifs
	test: listdirs.f
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402220939.82e05c80-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240222/202402220939.82e05c80-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/testcase:
  gcc-12/performance/1HDD/cifs/xfs/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp6/listdirs.f/filebench

commit: 
  45be0882c5 ("smb3: add missing null server pointer check")
  55c7788c37 ("smb: client: set correct d_type for reparse points under DFS mounts")

45be0882c5f91e1b 55c7788c37242702868bfac7861 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.52            -0.1        2.42        turbostat.C1E%
     37127            -4.2%      35586        vmstat.system.cs
     37311            -4.3%      35707        perf-stat.i.context-switches
     37139            -4.3%      35545        perf-stat.ps.context-switches
    883301            -1.0%     874098        proc-vmstat.numa_local
   2284791            -2.7%    2222575        proc-vmstat.pgalloc_normal
   2193531            -2.7%    2135398        proc-vmstat.pgfree
      9.95            -5.6%       9.39        filebench.sum_bytes_mb/s
    294200            -5.8%     277276        filebench.sum_operations
      4903            -5.8%       4620        filebench.sum_operations/s
      3.26            +6.1%       3.45        filebench.sum_time_ms/op
   1685851            -5.0%    1601112        filebench.time.voluntary_context_switches
      0.00            +0.7        0.68 ± 19%  perf-profile.calltrace.cycles-pp.listxattr
      0.00            +0.1        0.08 ± 27%  perf-profile.children.cycles-pp.strcasecmp_m_handle
      0.00            +0.1        0.08 ± 33%  perf-profile.children.cycles-pp.next_codepoint_handle
      0.11 ± 31%      +0.1        0.20 ± 25%  perf-profile.children.cycles-pp.next_codepoint_handle_ext
      0.00            +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.xfs_attr_list
      0.00            +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.xfs_vn_listxattr
      0.93 ± 20%      +0.5        1.40 ± 16%  perf-profile.children.cycles-pp.user_path_at_empty
      0.00            +0.6        0.63 ± 21%  perf-profile.children.cycles-pp.path_listxattr
      0.01 ±212%      +0.9        0.90 ± 21%  perf-profile.children.cycles-pp.listxattr
      0.10 ± 31%      +0.1        0.17 ± 27%  perf-profile.self.cycles-pp.next_codepoint_handle_ext




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


