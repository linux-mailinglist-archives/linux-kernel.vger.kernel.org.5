Return-Path: <linux-kernel+bounces-17277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E00824AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC800B21BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819AD2C866;
	Thu,  4 Jan 2024 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUHRuZ5b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A162C851;
	Thu,  4 Jan 2024 22:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704406462; x=1735942462;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=S8nGz5D5EnmfGdUcV5R8GGnaveoFVKW31SAWVCjtgng=;
  b=mUHRuZ5bp43oomya0IVPlsUC63ZbJYmP17oY+6nhP23Yewg1tWl7JJoQ
   bLCkva6jYS/ehaeDXHwM4mPt3FMZyZeHitufdlLVnLT7VSR5k1tL6q5j8
   QCarhRLwxLOPcmEW+ajllXjm7jNtVoeoVmmzJD4vfETI4b3OupabtcnuW
   UrQ7RW97HLDiyjCnKOtoZvOVM4hw0zeKdaEh59zuRGgFo9KgHtogdS6QE
   Trg6xCqJjSte9eKY02QkIEW8/cNqqRwuxpKlOWqgQJLT0xI26/tJ1xywW
   rDij5Piw2VAHH8EWidcF67XRRwFGxhDdgOujpFgq6yid7uy9AHmsWx391
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="428545902"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="428545902"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 14:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="899444377"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="899444377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 14:14:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 14:14:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 14:14:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 14:14:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXtgxImJ9TKv3mc3rvEEodgyvM6Tmsu8F3i1PTnKl5bv2xUqhHEiv7dqqLPRfXT9dp2IZ4Jw/9l7zycAPq03EqgUNgUTbooELavFawl4LQnjw5vLMKInX1o6yYyIvp9kmmkDHIoZf8SSH5i3eTGxUuD3YjuNk/p6fqiWOMBdTQzMzCY4C/aVYWB72hu2+tlDSBnoi3T6RzoHwQ1O82eHGdPEiKjMninfUnuY1DKENJjuMIG1EtXliMHHV2TR0WtKKb6cMhUJ8gPq2KjN0u0HTDbCnejXsGS9LuChITlFS9IdFxehu+Ws2BMnxo+wM62dk29rXIHSOcRoD6silX6PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L04z/wyFf2D8pUxE/F0qF2jWip0a4sR10lo/Xu5UE0I=;
 b=dPUzYcKdIheWAVVq6LuqJRXRiML1X8f3PGSdjixARL9Rj6JaqpL8nfODuk97J2gCaCIDClh3f1PUsQ5BLdGNFKxRtGWVmVftjzsKQjM24ayHT7w4BvbFjwyiuLlSFShtlWSfCtPBhMrIlVcrweReUOy5Fmeih/25v3CftBDcEKnrobZ2aPjj8w/mUXmAGjeISs6xre41DauTIaHPkUdZHNQT0sw6SD+tNgeqCVELB5JC+d0RE9EFx3IPbBStDNo+iPao+DW8hEFnwFiYDkZuv2vO0a7Tz0Ge/LmHMkV3+cKETQBRxayQ5hEI0zXbS9FJ1fu1rIjAJOXmgdkNGNWOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6441.namprd11.prod.outlook.com (2603:10b6:208:3aa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 22:14:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 22:14:09 +0000
Date: Thu, 4 Jan 2024 14:14:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <65972daf5c889_8dc68294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240102023218.3cd3e4ea@canb.auug.org.au>
 <20240105085306.60979082@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240105085306.60979082@canb.auug.org.au>
X-ClientProxiedBy: MW4PR04CA0213.namprd04.prod.outlook.com
 (2603:10b6:303:87::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: b36b6c77-c2fa-403b-2635-08dc0d72796e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ACPgl35oizQwPXASeEKYmy/xz6IfsWTIdgQA/4QiSMJERQVuKoIqVELTDtE/zXp0mzbCxR7RKp1lra9MNbwaNF1xWQqSV00K33ngzQFuf/BXEAYGwh/KTqfbhvulOy45mXMt1aaXfC2IEB1AuF7LJbUqRU9ZVfoE4HGKW9BZM+pzqPnd+YWPIeaNWGlt1aw8va7lQAGmuoDRVMBHHjJO9z505z5CQ/SJ2/ePCDBYTR0dU2Pj9AWjQ0OUmy1oX3kKq5QC2cF3vZeaB4nnnTbCW6VqeXrBIFB75xnMz7fih/l3UzoQvqxqZ+pBPr8iU1dg64BtSRfNmeATP7P1Nr/1idbrT1JBYCpPVU48JpW9opJ06iZ77Or/MoBqd3vvav0tDhvgVjfkKpWk8sOlTbsnmXl7EcFeUUav3vKf0CEzL4KopwghUSr56hoYoVcxxEtjGQBv0ck7F3CuXLzhfG9XCchBE6Mskm8+xZYC9kFeuI1ArCzYUVMdJN3EYz4bTXQZEvYIpEcB+49AlvExE6Lcwzaxb5c0fVcKw8fdxIOigoGhyL48A7eXEaOEgE9OrBOwSaPMHzGnfRkIEeTZwWJ0pbMF3aAb6l+TNPyHBsA93IOEtQallbxrRd4ABIPt9kWV5duMom7bs0s240KQhawuplSgkxE4Kvy5Cr7qGH/F2M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(451199024)(1800799012)(26005)(83380400001)(110136005)(41300700001)(8676002)(54906003)(966005)(9686003)(2906002)(66556008)(6512007)(6486002)(8936002)(478600001)(316002)(66946007)(66476007)(4326008)(6506007)(86362001)(5660300002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XcNgl/ynQYxjMih1+ZC4KDHJFKGiYhMn5yzdlhim4CkGkdt0tldd1aDP+GRt?=
 =?us-ascii?Q?1nwDPV7W7iC6qETaJKKG5nBOYOLk9/D5RO/OZWQ5w3tKxtppX1MgTG4LXz7G?=
 =?us-ascii?Q?o2mOBFC9pEGX1yGX89m8zbhTyTHd58RspRMhve/8pVCFXUalGbNquWoz1V8z?=
 =?us-ascii?Q?ApSDvQoheyGGatXU33WpZGvdrRbNiml5ypoYDlDg0o3o04+Fn1sBdGj5AJ1t?=
 =?us-ascii?Q?RSjNmaXAq43f1zpQtWOSCb+9qFjlZ2RJJJsLsjC9NJhshLDIvQnZtd3PtrTd?=
 =?us-ascii?Q?zmBxiVMbe8mvef7JC/ggGp5qO0GeMaejRdxrmz/EuiPtTvS0kA3MVBkwYXx6?=
 =?us-ascii?Q?BWho/dOlST62GXt788kw67jfnZE7GayFpn1AbRBskidfimOWKnf3z0Vi0TUl?=
 =?us-ascii?Q?DxDwg2KzehPzXae0UnuJGi5RkGKAfdFbYWMfKhm2JrK3XB+DniNrHFHLbzxL?=
 =?us-ascii?Q?JmrbPakKdgwk21G9VE61PDFiQD2Flf4R0nsNGoWdSsQIN0JOPOHa5w5MWGzr?=
 =?us-ascii?Q?8YORXqaURAlic1URKxl+OikXgqXYiP0tNpuwQGssASWnhOirwtou3v30VxqV?=
 =?us-ascii?Q?HxXLjEs0jR0ugBc0ALuTr+0iPrHWFGeY7lZZh8ZRLWrLrRsjng/JePMcQXyS?=
 =?us-ascii?Q?UkgWeAhutI2qORfEl5cPxWPmrNt4irWKLFioaGPMO6xhHlh+XAk/fyqcwiV6?=
 =?us-ascii?Q?5fLIf3+/YKlD8VyErWT+G1irge3FFQDzty6e0iVF91BxniI6TAyXEpKdiMwl?=
 =?us-ascii?Q?uVeXgfLbkfT+LxDNDsb+bhiUU4pC56YLAlFM7307GeiYcyfqCqGMu2caNSFi?=
 =?us-ascii?Q?OwQ/vT2M+gybdp+EJrP8ACeOcI/2/MOZHZBzO3wVBY69QT3RydyqIFd09OTe?=
 =?us-ascii?Q?xr8wYUT8yzK3QLVx0XU0vp9XZuEZEIGmyg7f422NnGJjxzakju2P55FyO5Ws?=
 =?us-ascii?Q?sMMDLG/bmoOYKftvvu8H+c6rB/HCXcQVV6rOEiXie/tyFixedmDDs3dY4m9p?=
 =?us-ascii?Q?g0M2s8PHgCKyTNF/31s63BwusPxnL4JJN2fPp3vMUO4v12XJ+ybdKzbXInfQ?=
 =?us-ascii?Q?q6jnni5Anrmv/IK3vSBKLWw/3FLQ1R9PpFW5ufKEiV5qO3ixvuR+N+6EYypN?=
 =?us-ascii?Q?wXLwJnaqMHBqy7tcep0WfamF2zoRHTYhAG3xVeNxuV4Yay8W7Qfv5UxLYVf2?=
 =?us-ascii?Q?qc6LKdubfanD7QSSp34mb7uX0peBe29wa6VwhHrH7behLwZUZ9/FulHl2TBb?=
 =?us-ascii?Q?Rasw82Qb4cWr/kHXORG4CZys0wLKAB/SMAHoF+e5H36Ru66DNHYiw8EuZzlz?=
 =?us-ascii?Q?E1wnZE2RYfpsUARk9LjR23VbZNq0h7VYvFAchgw8cla1hb7CyPQ5UHKRCyDM?=
 =?us-ascii?Q?fWbpQ6UoKHojBGMFyoL65fScTnQtv5aWxUQrm+bnMBu23ExguIokgIccIMZ1?=
 =?us-ascii?Q?raJxW+klgJKCHe2wWgaAnDCrga3NZB4K9DA6VxQ4CalFgEKX6rQURfBiGVSU?=
 =?us-ascii?Q?J3P6FFteQ7etl38y6kveoTsCpflxygQJkwqqsLEjxfD0DEXUSEIjxuzLO+5Q?=
 =?us-ascii?Q?Ceq9yvoNTxpkOuVGoVv8ZRgdPNAzdkIGKC4juVQvYlZ3XNOm8P1SOR9x++xQ?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b36b6c77-c2fa-403b-2635-08dc0d72796e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 22:14:09.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqXvks4lRBCPdoqGw+uQyZkYB4MMUcmJaRTmkdXl9n5iUM1FLrEM2/Y2RxBnOo5XTydlPuGy0WTEH6oQ5ENMdSn/1hR7FR7k/thV1KTMVEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6441
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi Dan,
> 
> On Tue, 2 Jan 2024 02:32:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > A large number of commits in the cxl-fixes tree are also in Linus
> > Torvalds' tree as different commits (but the same patches).
> > 
> > A bad rebase onto v6.7-rc6 has been done.  I cannot use this tree as
> > it is.
> 
> Can this be fixed up, please?
> 
> $ git rebase --onto v6.7-rc6 251c56533a2c
> 
> should do it

Now fixed, but the divergence is just odd. Most of the commits were
identical but below ones were different (trimmed git range-diff
cef295b57778...5459e186a5c9). Not even sure where I would pick up a
bunch of commits with edited changelogs.

  7:  6eb467e165fc !   7:  f40f939917b2 platform/x86: hp-bioscfg: Fix error handling in hp_add_other_attributes()
    @@ Commit message
         used by all the error paths after kobject_init_and_add().
     
         Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
    -    Cc: stable@vger.kernel.org # 6.6.x: acfff1760745: platform/x86: hp-bioscfg: Simplify return check in hp_add_other_attributes()
    -    Cc: stable@vger.kernel.org # 6.6.x: 9950a86160a1: platform/x86: hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
    +    Cc: stable@vger.kernel.org # 6.6.x: c5dbf0416000: platform/x86: hp-bioscfg: Simplify return check in hp_add_other_attributes()
    +    Cc: stable@vger.kernel.org # 6.6.x: 5736aa9537c9: platform/x86: hp-bioscfg: move mutex_lock() down in hp_add_other_attributes()
         Reported-by: kernel test robot <lkp@intel.com>
         Reported-by: Dan Carpenter <error27@gmail.com>
         Closes: https://lore.kernel.org/r/202309201412.on0VXJGo-lkp@intel.com/
237:  4087f4734f48 ! 237:  a0575b4add21 ASoC: hdac_hda: Conditionally register dais for HDMI and Analog
    @@ Commit message
         for HDMI hdev only register the dais needed for HDMI
         for non HDMI hdev do not  register the HDMI dais.
     
    -    Depends-on: 36c7ac1c277f ("ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available")
    +    Depends-on: 3d1dc8b1030d ("ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available")
         Link: https://github.com/thesofproject/linux/issues/4509
         Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
         Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
293:  7517f209328d ! 293:  fcc9b50e5517 Revert "greybus: gb-beagleplay: Ensure le for values in transport"
    @@ Metadata
      ## Commit message ##
         Revert "greybus: gb-beagleplay: Ensure le for values in transport"
     
    -    This reverts commit 360c237fe6a6dc0e3b4c59ad158c3cfa3ceaa3e6.
    +    This reverts commit 52eb67861ebeb2110318bd9fe33d85ddcf92aac7.
     
         Turns out to not be correct, a new version will be generated later.
375:  31043eadf2fd ! 375:  5b750b22530f drm/amd/display: Increase frame warning limit with KASAN or KCSAN in dml
    @@ Commit message
         Reviewed-by: Harry Wentland <harry.wentland@amd.com>
         Reported-by: kernel test robot <lkp@intel.com>
         Closes: https://lore.kernel.org/oe-kbuild-all/202311302107.hUDXVyWT-lkp@intel.com/
    -    Fixes: 1a2bd2c77933 ("drm/amd/display: Increase num voltage states to 40")
    +    Fixes: 67e38874b85b ("drm/amd/display: Increase num voltage states to 40")
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
         Cc: Alvin Lee <alvin.lee2@amd.com>
         Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
446:  82d5522cdc1c ! 446:  6e455f5dcdd1 drm/crtc: fix uninitialized variable use
    @@ Metadata
      ## Commit message ##
         drm/crtc: fix uninitialized variable use
     
    -    Commit 5d7d3616cec9 ("drm/crtc: Fix uninit-value bug in
    +    Commit 3823119b9c2b ("drm/crtc: Fix uninit-value bug in
         drm_mode_setcrtc") was supposed to fix use of an uninitialized variable,
         but introduced another.
     
         num_connectors is only initialized if crtc_req->count_connectors > 0,
         but it's used regardless. Fix it.
     
    -    Fixes: 5d7d3616cec9 ("drm/crtc: Fix uninit-value bug in drm_mode_setcrtc")
    +    Fixes: 3823119b9c2b ("drm/crtc: Fix uninit-value bug in drm_mode_setcrtc")
         Cc: syzbot+4fad2e57beb6397ab2fc@syzkaller.appspotmail.com
         Cc: Ziqi Zhao <astrajoan@yahoo.com>
         Cc: Maxime Ripard <mripard@kernel.org>
495:  75857788dedc ! 495:  1f721a93a528 drm/i915: Use internal class when counting engine resets
    @@ Metadata
      ## Commit message ##
         drm/i915: Use internal class when counting engine resets
     
    -    Commit 94ac2100d07a ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
    +    Commit 503579448db9 ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
         made the GSC0 engine not have a valid uabi class and so broke the engine
         reset counting, which in turn was made class based in cb823ed9915b ("drm/i915/gt: Use intel_gt as the primary object for handling resets").
     
    @@ Commit message
         igt_live_test_end.
     
         Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    -    Fixes: 94ac2100d07a ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
    +    Fixes: 503579448db9 ("drm/i915/gsc: Mark internal GSC engine with reserved uabi class")
         [tursulin: fixed Fixes tag]
         Reported-by: Alan Previn Teres Alexis <alan.previn.teres.alexis@intel.com>
         Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
502:  000c070ec631 ! 502:  9fd2fbaabdb9 drm/amdgpu: fix buffer funcs setting order on suspend harder
    @@ Metadata
      ## Commit message ##
         drm/amdgpu: fix buffer funcs setting order on suspend harder
     
    -    Part of commit 4b9c2bd29761 ("drm/amdgpu: fix buffer funcs setting order on suspend")
    +    Part of commit dab96d8b61aa ("drm/amdgpu: fix buffer funcs setting order on suspend")
         got dropped accidently.  Add it back.
     
    -    Fixes: 4b9c2bd29761 ("drm/amdgpu: fix buffer funcs setting order on suspend")
    +    Fixes: dab96d8b61aa ("drm/amdgpu: fix buffer funcs setting order on suspend")
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
     
      ## drivers/gpu/drm/amd/amdgpu/amdgpu_device.c ##
505:  6eda23feb3cd ! 505:  b96ab339ee50 drm/amd/display: Restore guard against default backlight value < 1 nit
    @@ Commit message
     
         Mark reports that brightness is not restored after Xorg dpms screen blank.
     
    -    This behavior was introduced by commit 413900a95bc2 ("drm/amd/display:
    +    This behavior was introduced by commit d9e865826c20 ("drm/amd/display:
         Simplify brightness initialization") which dropped the cached backlight
         value in display code, but also removed code for when the default value
         read back was less than 1 nit.
    @@ Commit message
         Cc: Camille Cho <camille.cho@amd.com>
         Cc: Krunoslav Kovac <krunoslav.kovac@amd.com>
         Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
    -    Fixes: 413900a95bc2 ("drm/amd/display: Simplify brightness initialization")
    +    Fixes: d9e865826c20 ("drm/amd/display: Simplify brightness initialization")
         Acked-by: Alex Deucher <alexander.deucher@amd.com>
         Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
551:  4fabcdf1bfc0 ! 551:  9702817384aa Revert "tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set"
    @@ Metadata
      ## Commit message ##
         Revert "tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set"
     
    -    This reverts commit e15d5eff889895c78f01bdc16cea04025ce3d882.
    +    This reverts commit f3f32a356c0d2379d4431364e74f101f8f075ce3.
     
         Paolo reports that the change disables autocorking even after
         the userspace sets TCP_CORK.
     
    -    Fixes: e15d5eff8898 ("tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set")
    +    Fixes: f3f32a356c0d ("tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set")
         Link: https://lore.kernel.org/r/0d30d5a41d3ac990573016308aaeacb40a9dc79f.camel@redhat.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
569:  33f1d5856a46 ! 569:  7e2c1e4b34f0 perf: Fix perf_event_validate_size() lockdep splat
    @@ Commit message
         Avoid the splat by bailing out early when the new event is its own
         group_leader.
     
    -    Fixes: 97a5538a6b154429 ("perf: Fix perf_event_validate_size()")
    +    Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
         Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
         Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
         Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>

