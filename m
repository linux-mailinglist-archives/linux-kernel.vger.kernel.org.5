Return-Path: <linux-kernel+bounces-73957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281FC85CE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63ACFB23FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BFE24B2F;
	Wed, 21 Feb 2024 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FO5yxcGO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE831DA32
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482772; cv=fail; b=FWvPNHU3sR8ZW4yZTo2v9D2UhgTvM2H5/6M9Wz+0PkuKZHrwzV4jnZfXQuD+TcIQ4cumQDPFX8r2TNBEaKoNmA4o7jKhGs0M79rH/METOsSgowwkzPpZ6rBSrVdU6LHw035oQdZFOyOoOv4gxuBxLGG5jUNHIBww3Ae4xLgeSG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482772; c=relaxed/simple;
	bh=WqCD4wUsrff2MN37fD+nR3Ocw9VVb8/b9IQ4sZ38iSg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=joRFlw65zoy/67rKn4CbHdW5q7oC7J+x4zsb6xjop9tv6bZ7gcfZP+AxRofGINXE80BU1Joldkz4O6ptjeXMnVYX29gdqARd5gyEtA+1OyX3hHQRrBgljI3S482O/cDX6FybaA9ZTEqTs0KALgKR5Vi2dca02vDK6GWx5mXC+hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FO5yxcGO; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708482770; x=1740018770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WqCD4wUsrff2MN37fD+nR3Ocw9VVb8/b9IQ4sZ38iSg=;
  b=FO5yxcGOQIn5cXx90/O7hs+NDK0qyP2Jx4kktqeK5cOAMFKEUfmWLQcl
   OtevWwGBd+sxd2O7w0cpR8gZ38xwhn6dtLEi3AcQ3+vKT3Hsd0+2fnx2Q
   trsBMeG9/x7G4npZ5S/ypq3umXs3/fN13kOQ/VkAA5Bja4x777j7awoOo
   cTVu6g1zWOVUVR/zDAcUKu6Ed2m/egx0+47JiqBcn1XYw+rKVKRwkdLms
   hq9cSHose1/d8BmA7yc1ZgXS8q+ZB6pV9Dn+Vz9J4cBA7L2tEfT4ApmiC
   MMaBKj10J1E6C+aKfOqlLU3AyAyjyEqyaOKgZpQfVkD09ZiRbKUesIzeA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2486828"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2486828"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:32:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4989228"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 18:32:46 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:32:45 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:32:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 18:32:44 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 18:32:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDciaJAFC9l6Xvl7vQ12c/fjjkeNLrpJOYhROF7JoTcGaghpsTVDR408cBNQ1ZhUT07gYWE5vYpffJlL0tmIgyT9H2eUa1mLURMLj4lzR+QnPvR1B22HeoTAu5bi/PuQNBFi7+l74HchFWS2QA4EqpzxmwJzgJCdJ89C45xoq09QeSI9Feh/Q5hPMt6yaLsrugvltqzMwaUi605+HQesgenWs29hKxut+kQGnajQhYSW4LCeNZNMA2+RFxVnoo5dfZS2y7/G6DvZnwvgOJ4xZenUZfjxgsujj0WN46PznRdm4+XsxiDNXLwcJYkymBzSbzHAkjvmLJaFu5Uj32WSKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiNu2KU4+cfkvO9/d1iH0Mq0oYxKIrOJI99MfHWfhqw=;
 b=MSVxvduhMfJ5riLQtQYZ4+sOXOOL/9f93KEgYXyMwHhsbn7ui0mR0EhA4AYhL8GInfYrf5s9Q9B/XcVaR1eIeEPOQ0MvQcfldRMiEL3MPNyc6yAqvZZTFzi3m6AUqA4Cetp8KyLDB1AUC2Lvhj+7B/eETWNlfYMxwlvl1OY03oign3hg8281zzR4ZcHp/iXHW8UE0UsfCJBGKS42ClrxdLC+b9av3Uo8RJpofhix3PTGMfeJhBQVdoiZ+sFfqRdpQ8S3QdBbBCvs7F9kEYr603hT+07H+35a9LQfGOpfJArkAJbJ8Sxtd1xunudxOgQhb/uXp5e9nMxfCsryyKAHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Wed, 21 Feb
 2024 02:32:42 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:32:42 +0000
Date: Wed, 21 Feb 2024 10:32:33 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: Abel Wu <wuyun.abel@bytedance.com>, "oe-lkp@lists.linux.dev"
	<oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>, Tiwei Bie
	<tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, "Lu,
 Aaron" <aaron.lu@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <ZdVgwZPB7f69TICP@xsang-OptiPlex-9020>
References: <202401301012.2ed95df0-oliver.sang@intel.com>
 <23cbb613-c8a2-4f07-b83b-fa3104bef642@bytedance.com>
 <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZdNOb7fOLIoY5sgW@chenyu5-mobl2>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 195c0349-7129-4f4f-5a19-08dc3285613b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9V5scH0Wm56LEiRNlgoJw42rowsyGLbY7TvLFpDPclLAW/WmT2vONEDDb77uFBxBT6rGXFIdjAQ/NghNpA135IzHvPwfKliOa9TLTOCkJsWTRGw1hNcCJ6VRiGrqYf9L50nv/1gkIDPT7U0MLTShAHukpErT6kRbXRWcvx6u00B+Xa75lq3jkN5bN3hztob7IsqES1zvCbVaMOT13DWKueuUV5Tv9J/e4wONmCeNsuFS1+I9Y1JttSYVsDv8C6Dn7G8FKPgvXKZ3UHpNJQJopwLMvAuMfHrUO0oKPV/UGYOuVRc3tVvdmOGWpMIhwjNtMQL8YHe817EGEPPSvPHBUY7Yy0Vz2yX5F/w18o4vgbF6/uKCeXLrMG/mQ429kRQsnUxMhzzwYzzo3DgDAYL1cNrGpUlZ9dF5TJqo2YY4EbyWukChhzTAAGVb6tfzwWqJiRbtMaohwPaUIE3afjmE5j7XSYjOi8P8G7Dc76sgRSiAK/MLKa/GQ1uSqnLJMny6Q74Mbc8HA6kaMUh6fUhVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNUkLTTCBqZBabYs6nM418LZkUc4mOtNLDEmSlxBd8xxrBMX5dTc/MFxbrHd?=
 =?us-ascii?Q?ZzD/590FAON1xec1TTqzsKBqtZVh6uXjkFhDe8oC5ZcF91tX5Op1VaYco32w?=
 =?us-ascii?Q?9JJo37HDrqBBq9zytUBSCtaqvPnM5JpdyvoWO0H+3GJNEHxmiBB+1U6AF0jc?=
 =?us-ascii?Q?22zNKz6U++Z6gEVuET2TgkKk5N/rgwTn+892gpRF6K+JTOFyEbBB2hWmaDPJ?=
 =?us-ascii?Q?woouUWQOof2HTTUJ7K8em9e4TbSkjoK/Zg49dJGP9gcfIrLjh+BhO13waXiB?=
 =?us-ascii?Q?qmtN8sfeTyE4B0Gm4yl8CEgqB1Oub85wnPYQYtsSroPHMM0hhZIwqTJsvAs0?=
 =?us-ascii?Q?hFTk9FqnH9TNNXEq4as2u+o7/2PdmSuZTqnNoKbNJrWdLyJ9IxI5EVjSD78D?=
 =?us-ascii?Q?fidz4/QHub0+iRGeQd8rKRB50dzp4wYVDFOge1Eb4oTIfkyzg86a1JAvNAbD?=
 =?us-ascii?Q?7fmYo5bLbKxZ2xwFmze827VVLVR1l+L95wyYmbr56PCMPlACls8jUn3g5Dvw?=
 =?us-ascii?Q?o3SFuOoIG9jxXfHctbIZQ3WOAjzvo4iZs0qor3nbsBSaoNH+3dFiggXMmE5U?=
 =?us-ascii?Q?2mKcucMkVKb/7I24KdSLBgZhpUQoYDP40huHAdIuTng/B0ZP7jtPmKr9KWXW?=
 =?us-ascii?Q?HTp6E9MKWkhG8sVPhqE4NotGWony8umhePBPo+z75oSlXLnnXrpGnulbdrIe?=
 =?us-ascii?Q?UGltljkYNvgRvoJC0pfXPde3k/vMdcsDmVfQitQOEYGuELIWUFoFGb9kVa8h?=
 =?us-ascii?Q?0AK0mUYJu8XQbosJIaG/kwH7FvdqvmpqnhahLAScl8MxHMbpBmnWr6rYsmon?=
 =?us-ascii?Q?P24D3Sh3DcH9PJtgUpE48TmtDIHZ+P57ZgIpG8TjTJDPWd7/Ll4ZLAyJZEbA?=
 =?us-ascii?Q?cVnxUXnNGa5RoWU2lJkpLMQlMav1sywfJneE0RPurAhU3EMmeApxxkrYPgTh?=
 =?us-ascii?Q?dMrsYdbCfweDA9d3ryWDYUjwUS3LdcSN5u+KDr2TxVqYL/WSJUSKvzMjSEi8?=
 =?us-ascii?Q?B/nE2j14G657wjjhUsw9Foap086zT5fLkXQZRPc3TCsi9/tqyzFKXKU7ZYZZ?=
 =?us-ascii?Q?2NGAWejptdg2doHOmdnKSlqlc2AkWqTEA+O2J00SsOmAB70Jd1DBirGeoZfR?=
 =?us-ascii?Q?MxyY7pw2AAQF7RHtCYBBgWp9KEYSQ/kTxQKGzKHi0FK/95gVLbjtR0TufqQ4?=
 =?us-ascii?Q?Fe+cjongFA405nBBOO28TV9lpoGA4qpi6EGtmimXA1kQM3/CmxB1Y1ynjYlz?=
 =?us-ascii?Q?dy/tkj3S6gq2gPkS99/c1B3pWEWXGvZt/UyHlgOwLnrE3BYqtSLHNbAVP9li?=
 =?us-ascii?Q?IMQKnVRzyV1UjY6ulHV8rE/aImmPj1UGpHLaGrVR9pFzDziqVZzKXDidkQH1?=
 =?us-ascii?Q?iNVzkzlVMe/WTb5Bbf4+ul7Yrohtgakpp0L6claMO8XO28sIeM5A9WW71ZDI?=
 =?us-ascii?Q?hAt+wRfbbOufLMhQf4/01jVUydYG9iJ3y1vhk8LmlFErRcQUP9HNCKOXbXHo?=
 =?us-ascii?Q?XAOuGML4rc1A+ZrRhG8SUDfbTEtttoi+l5jGufiCyF9vyG/WJJdNloq1OThr?=
 =?us-ascii?Q?w9gLVS5uHP4GJ5tYUpnoSuTkW3eMxuIcHTJn4qRuz2G5mR/h9M45ft2eRBtr?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 195c0349-7129-4f4f-5a19-08dc3285613b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 02:32:42.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvmO2ZrqbuPQ6PKQKNawRUzbi3wcs91g0e+WwzK3Sv3zM4qiiNQVxLmmvsgebKhc/nWxnhrZlQ5RSXfu11a4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com

hi, Chen Yu,

On Mon, Feb 19, 2024 at 08:49:51PM +0800, Chen, Yu C wrote:
> On 2024-01-30 at 18:13:32 +0800, Abel Wu wrote:
> > On 1/30/24 3:24 PM, kernel test robot Wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > (besides a previous performance report),
> > > kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> > > 
> > > commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
> > > [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
> > > 
> > > in testcase: trinity
> > > version: trinity-i386-abe9de86-1_20230429
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	group: group-03
> > > 	nr_groups: 5
> > > 
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > > 
> > > 
> > > compiler: clang-17
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > 
> > > we found this issue happens in very random way (23 out of 999 runs).
> > > but keeps clean on parent.
> > 
> > Thanks for reporting, I will try to reproduce the issue. Does the 'parent'
> > mean the same code branch without this commit?
> > 
> > > 
> > > 84db47ca7146d7bd 2227a957e1d5b1941be4e420787
> > > ---------------- ---------------------------
> > >         fail:runs  %reproduction    fail:runs
> > >             |             |             |
> > >             :999          2%          23:999   dmesg.BUG:kernel_NULL_pointer_dereference,address
> > >             :999          2%          23:999   dmesg.Kernel_panic-not_syncing:Fatal_exception
> > >             :999          2%          23:999   dmesg.Oops:#[##]
> > > 
> > > 
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202401301012.2ed95df0-oliver.sang@intel.com
> > > 
> > > 
> > > sorry for below parse failure which caused no real line numbers.
> > > we will follow further. the orgial dmesg could be fetch from below link.
> > > 
> > > 
> > > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address: 0000002c
> > > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > > [  512.082337][ T8305] *pde = 00000000
> > > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G        W        N 6.7.0-rc1-00006-g2227a957e1d5 #1 819e6d1a8b887f5f97adb4aed77d98b15504c836
> > > [  512.084986][ T8305] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > > [ 512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> > 
> > There was actually a NULL-test in pick_eevdf() before this commit,
> > but I removed it by intent as I found it impossible to be NULL after
> > examining 'all' the cases.
> > 
> > Also cc Tiwei who once proposed to add this check back.
> > https://lore.kernel.org/all/20231208112100.18141-1-tiwei.btw@antgroup.com/
> > 
> > Thanks,
> > 	Abel
> >
> 
> While looking at pick_eevdf(), I have a thought.

I applied below patch upon v6.8-rc5. in 999 runs, we cannot reproduce previous
issues which still exists on v6.8-rc5.

commit 32dff117ae985799019211b78b3f2d26f7d30109
Author: Chen Yu <yu.c.chen@intel.com>
Date:   Wed Feb 14 19:32:11 2024 +0800

    sched/eevdf: Sort the entity by both deadline and eligibility


        v6.8-rc5 32dff117ae985799019211b78b3
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
         45:999         -5%            :999   dmesg.BUG:kernel_NULL_pointer_dereference,address



> Currently the sched entity is sorted by their deadline. During task
> pickup, the pick_eevdf() scans for an candidate sched entity with the
> smallest deadline. Meanwhile this candidate sched entity must also be
> eligible.
> 
> The scan is O(lgn) on average, and O(1) at best case. How about making the
> average scan even faster by sorting the sched entity not only by deadline,
> but also the eligibility? The idea is that, the eligible sched entity with
> smaller deadline is sorted at the front the tree. Otherwise, if the entity
> is not eligible, even if it has a smaller deadline, it should be sorted
> at the end of the tree.
> 
> After the change, pick_eevdf() get the leftmost sched entity at O(1) on
> average. Besides, it is guaranteed to return non-NULL sched entity in
> pick_eevdf(), which prevents suspicious NULL pointer exception in pick_eevdf().
> 
> For example, suppose there are two sched entities to be queued, se_a and se_b.
> Consider their eligibility and deadline, there are 6 combination:
> 
> 1. se_a is eligible, se_b is eligible, se_a.deadline < se_b.deadline
> 2. se_a is eligible, se_b is eligible, se_a.deadline >= se_b.deadline
> 3. se_a is eligible, se_b is not eligible
> 4. se_a is not eligible, se_b is eligible
> 5. se_a is not eligible, se_b is not eligible, se_a.deadline < se_b.deadline
> 6. se_a is not eligible, se_b is not eligible, se_a.deadline >= se_b.deadline
> 
> In scenario 1, 3, 5, sched_entity se_a should be sorted before se_b,
> so pick_eevdf() would pick se_a first.
> 
> When enqueuing a new sched entity, it is regarded as eligible if its
> vlag is positive. In theory later in pick_eevdf(), the eligibility
> of this sched entity should be re-checked via entity_eligible(). But
> consider if the sched entity is eliglble when enqueued, it is very
> likely the same sched entity remains eligible when pick_eevdf(), because
> the V keeps moving forward but the vruntime of this sched entity remain
> unchanged - the vlag could get larger.
> 
> Something like this untested:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 533547e3c90a..831043cc1432 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -551,11 +551,19 @@ static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
>  static inline bool entity_before(const struct sched_entity *a,
>  				 const struct sched_entity *b)
>  {
> -	/*
> -	 * Tiebreak on vruntime seems unnecessary since it can
> -	 * hardly happen.
> -	 */
> -	return (s64)(a->deadline - b->deadline) < 0;
> +	bool eli_a, eli_b;
> +
> +	eli_a = (a->vlag >= 0) ? true : false;
> +	eli_b = (b->vlag >= 0) ? true : false;
> +
> +	if ((eli_a && eli_b) || (!eli_a && !eli_b))
> +		/*
> +		 * Tiebreak on vruntime seems unnecessary since it can
> +		 * hardly happen.
> +		 */
> +		return (s64)(a->deadline - b->deadline) < 0;
> +
> +	return eli_a ? 1 : 0;
>  }
>  
>  static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
> @@ -877,10 +885,8 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>   */
>  static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  {
> -	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>  	struct sched_entity *se = __pick_first_entity(cfs_rq);
>  	struct sched_entity *curr = cfs_rq->curr;
> -	struct sched_entity *best = NULL;
>  
>  	/*
>  	 * We can safely skip eligibility check if there is only one entity
> @@ -899,45 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
>  		return curr;
>  
> -	/* Pick the leftmost entity if it's eligible */
> -	if (se && entity_eligible(cfs_rq, se)) {
> -		best = se;
> -		goto found;
> -	}
> -
> -	/* Heap search for the EEVD entity */
> -	while (node) {
> -		struct rb_node *left = node->rb_left;
> -
> -		/*
> -		 * Eligible entities in left subtree are always better
> -		 * choices, since they have earlier deadlines.
> -		 */
> -		if (left && vruntime_eligible(cfs_rq,
> -					__node_2_se(left)->min_vruntime)) {
> -			node = left;
> -			continue;
> -		}
> -
> -		se = __node_2_se(node);
> -
> -		/*
> -		 * The left subtree either is empty or has no eligible
> -		 * entity, so check the current node since it is the one
> -		 * with earliest deadline that might be eligible.
> -		 */
> -		if (entity_eligible(cfs_rq, se)) {
> -			best = se;
> -			break;
> -		}
> -
> -		node = node->rb_right;
> -	}
> -found:
> -	if (!best || (curr && entity_before(curr, best)))
> -		best = curr;
> -
> -	return best;
> +	/* Pick the leftmost entity */
> +	return se;
>  }
>  
>  #ifdef CONFIG_SCHED_DEBUG
> -- 
> 2.25.1
> 

