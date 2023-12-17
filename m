Return-Path: <linux-kernel+bounces-2499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B3815DED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 09:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB34A2835F2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 08:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87B1876;
	Sun, 17 Dec 2023 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ1sQ+Yx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E81849;
	Sun, 17 Dec 2023 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702800367; x=1734336367;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LHNeeZRS8dX/Pr/N5EUJ2two42T4Yu+O/h2i0IJg9MY=;
  b=lJ1sQ+Yx7keA/gCgOhY+MG/YKp8ZSo3tG0oxcA5JeVrKi3c072gDJrGD
   Q7WNwtbR+oF0vx9srbvdzbiJMThcKOoxwOdrfOVu0BBYLAqJ7QTy6By13
   TBx6k8l6+Oxzod8fQANAKaN9Y9ZhvUuXhdafSmoO4Cof6z9r+FarkRLKI
   w1Wn8y/LyvGfcT9w0HU++OnvpEIXU9sBhjfYm/sTBOxAgW4/i7LneeYn+
   dyC6kMY/58XHSuX1fC4/p3kG93c69H6SiNlqfd6hCxqtlU2LTV2apZZol
   NGloqqn0RbuCUvYSZ8woIUbAx9WoOwGcM6nEov9zsZzPKBfiRDRzYWT0K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="14090376"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="14090376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 00:06:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="804185106"
X-IronPort-AV: E=Sophos;i="6.04,283,1695711600"; 
   d="scan'208";a="804185106"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 00:06:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 00:06:05 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 00:06:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 00:06:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMRUiQy0PZ8mpdTFCZFKYOmhbmKyoQA9rXCrBcxyPSZOBdzO0t9+isB5Pl+553ddwwkxFgEutmV6IUIY8u01oDHhzdO1Jw/KCtJ0U/dNfk4V5db7WRL8SaRYgozeZdmlDGJoW7P7JQUs/OOJxJb31rYgMxgho4YpHx+omQZvUWF6ecNKqzjqyYR+Ighlwct1vvP9b1JE/DCmXxvypy0UG/WGOo03Vqa6br2XiS2uww1cTwDUjIZPQYjEmEUk+bzOyJy+tHvwIAMhGOz3Y6aWiM2hV9p/RiT6G/pUzoror3OS61wElUNG2Q1v3d0fr6d8XGedfuh4crNXNi5PWGxVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcfNpm1sMZxStMX6QokPS9meZiSOj9B1SpSooMWdHBE=;
 b=R27UXQx8sz034NPdvdXiWQBYiNi/7I9R6bUyXsQmt5kGh6CKr44+zyN6QbJSWzoZOZQBM3ecafSBMs0THAgN0FdTRLcntXtQEeMJIdRrHtEeZJ/HleMQccb3ulyU6bzK7Gu5ZGfmVVrnzRktKpmlxRWRcmPCZKLX4RcD3AwnlpNM6xB94ZnTJ40YAz+tsL6QGu2OQnUzhngSXBopx5o/txEAsCEioLTFHyogf/uQTRZj8Dmt1amsXCOXRPvorBIFwiRHICZwq9ufianBxIRq0JIp7gCoauUmGcGegpO9pFioBZUbl1tvnsUH3mT3QYj+N8neE/SXl2p28J34a20xKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 08:06:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 08:06:02 +0000
Date: Sun, 17 Dec 2023 00:05:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <torvalds@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.7-rc6
Message-ID: <657eabe7624f7_715492941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: MW2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:907:1::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 255cfab3-7cb7-4bf0-d6fe-08dbfed70265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF3bzuHgvTSdKKKHRkVeCIG7bn5zJVsuk6qsGGbj7Rq/oapx3VNgnbeZit14kSPTFjHVxDg3qgTLYDr5xxCtE4X0vnaMN8FhLNYTD4Wk80G52iJtUtCTUrWOPQzM/tivYiZLDqlixlSXrv0qATLX/zlCGdWMraSao2LmTwKr4bdmc7zub3f92zp93EvVQMPVX7OK5jwic5g3CleHCEnxRD/lFo0rHOcm3RV15cqamo2SS4s3r5baxT1mD6ZrF16tyfahiRt+Qn/mps6kH61klZ0hD2OoN0PDaIS1ROt30uaocsHE0hEe6ByyELBwCWGoQ1ek3/dc5Br63yDdpVdbT3IpLc0piPPavio1T+z3TpahKp7h1RNoTG8p1+J9IZO2V7L9zVOurWRvQ6eK/A7rmBF1E7p26hb+pCs+7ur/75zD9eBWcYSEz4TEayvmYvc9TLankmcCcnjGclyHRqrJ+FvmY4b83f9Pu4P6Y5QhtDfy3MP+lXVY/d8v3HGTklmsAK5r40THhPn0wR/hgiB9hSgV+V3Zp1je/2YzEjF5frhAeQA5yyxR0ZfI6/mIcWYm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(2906002)(86362001)(4001150100001)(6506007)(9686003)(6512007)(6486002)(478600001)(83380400001)(38100700002)(82960400001)(26005)(41300700001)(5660300002)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(6916009)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i60UNTg/fNynjtQW0A7rXa0Jh8XYMlwxrRpWiohHfvp+Q0BjkCrLa1tZEXOI?=
 =?us-ascii?Q?YEt31XV8jApcqUQBM7anfciJLKi6vQpkj+xGp51YkoLWlsYhejZrLsgRAbfX?=
 =?us-ascii?Q?qeNxUNAJE6iUcNeEGD/ksscPhMmA5Oo1mxbMQ+enZrSLRLnHOOJ/2Vg8NNrO?=
 =?us-ascii?Q?TG4U2II4rZJ1MBZrFBx0B8OT+VM/mT/ylCeVAPfJ16ft4wY4JsfC3PZ9UI6w?=
 =?us-ascii?Q?D3TO4J4C8c571d3cKjHoi8rO2HqDkcPUURi0nNYYOi5LD1Pnw/o+ldM+oV5L?=
 =?us-ascii?Q?amddlPhssgWL+Xk6/v1WCVsWFyn2BoHe1oLoTPVwjzggnQor5xBmlrJGFx3u?=
 =?us-ascii?Q?3hXlqdc+fL3S98L3q9B+uki3H1VoovHiyyocHmvi1097A6qj3+4qHiA+X4Gt?=
 =?us-ascii?Q?0ttfyd1V+55AHwWEIWvhD+KdMLbmR4V5ulJAlYIWpsFoh6nSw7Fxyu6F9Pqv?=
 =?us-ascii?Q?Ew5Zpc2zkx7fgMoSVoTyKgjWa1XLeSr5YuNNJCBWR1zrOSMmxB8VkfyhjLOL?=
 =?us-ascii?Q?7EWR6ZLqjvPB+iEoMiRprtoKGjMDra2QVkIhD7z/g1lbaSy9Qf1GZTmxEvFk?=
 =?us-ascii?Q?tR2IH+WpBNd/pqEUZI6HM5R2c0SyBnbnR3GCLqdTGjgqFmQu4jAn8ps+x3GL?=
 =?us-ascii?Q?7ASlwUB+cLgonxXnvQNwSHycs/zHbMJ1laidEEz2ea+TtT5xxsFXhDZ4FZOp?=
 =?us-ascii?Q?oNgB8E/XZy32MXtIoixaleLRUKW0pPxjBswl+tQrWRH7LLIM2sfsSSi46e7D?=
 =?us-ascii?Q?DgJCgABxzC6bRUiadKmYrJI0VclCuLf99FbR3Lqp01fgffbkOJEkZjEYiUqj?=
 =?us-ascii?Q?9FF2LtZq927FQONHFap1AX7Bj/B7++y1/ybZw3s+ZN8IvYYyNXxTo1AG8Wlo?=
 =?us-ascii?Q?4gCedFTTbVV3TiE1zugkTDlcF3KQFjHHReWp1cI7f475HOBwBStC54fMAi5y?=
 =?us-ascii?Q?omYniUXX2u0RthdEo0n30f8S19qbL37inoNfxNno7Pe+yBYHStqvVGoZ1OVw?=
 =?us-ascii?Q?+KxN6NJk1AXVPAPIGkIZT/PIhGOz8dAHUjNPR22fp95WcPfM3JkH3ArsGCIW?=
 =?us-ascii?Q?V778yv3G12mTG5PJTIEOutNC5XnHz5K2hIT3FrlIN7SLY8rXOHJC/iQjXbhk?=
 =?us-ascii?Q?tfnQk2L8vmX0nJEurbVS5joZB/FZWROceIIldcnFtQeTwGr1ZZIjIFxbDs4/?=
 =?us-ascii?Q?PIH+HzfDS9v7Mnv99nckUEU4cQa5Us8B7r3mdfJBNudgzYO8yXLQO9/yK/rt?=
 =?us-ascii?Q?N6hb5Ag3LQdk0lNxTV1mWYrVEokVzraaGx30AssfUifOA805f1r2s5kfwE/4?=
 =?us-ascii?Q?W4Z/U4yC1EuS1I1zIEQ9KLMAEYqfbw77yG/UlCWFKEDMw4GixSGeIDUpnSpp?=
 =?us-ascii?Q?GvAduzJGnCsqBsHg2blaopIRum+ul8kdVz69DUUpMF70EK8ujtMtGK8QQtd4?=
 =?us-ascii?Q?QQ0g9WRLBs6J3gESy87YdaADpXyEGH2LGa5/a+q50bk1XsQ8sMDgbFUl2lFy?=
 =?us-ascii?Q?xycXiAYnu2dX0/IJQSOspLe1muUc+3iunpOvV8dkePDV3wSBNLNA8z5kd3O4?=
 =?us-ascii?Q?WWRZZh1T3qNleXIZd3SV4YAKluXwu7ueMCUO+nsip1FPPoYaiuqo6x2fz/Xd?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 255cfab3-7cb7-4bf0-d6fe-08dbfed70265
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 08:06:01.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Th3qOSglzjGBZBZ5qukMk3w2MkMnuVYHtqJL5FIjfD0ur3Ay70y0OX8i1ETSYAne+UzjmoQD/Pk5k0YuyP+UV2Eu6YsNpQIJBR6z5BKYfzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.7-rc6

...to receive a collection of CXL fixes. The touch outside of
drivers/cxl/ is for a helper that allocates physical address space.
Device hotplug tests showed that the driver failed to utilize (skipped
over) valid capacity when allocating a new memory region. Outside of
that, new tests uncovered a small crop of lockdep reports. There is also
some miscellaneous error path and leak fixups that are not urgent, but
useful to cleanup now.

This has been available for the bots to chew on for a few days, but I do
not see it in linux-next. I will need to follow up with Stephen to see
why it missed the 12/15 linux-next. I do not foresee any issues.

---

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.7-rc6

for you to fetch changes up to ef3d5cf9c59cccb012aa6b93d99f4c6eb5d6648e:

  cxl/pmu: Ensure put_device on pmu devices (2023-12-14 21:54:45 -0800)

----------------------------------------------------------------
cxl fixes for 6.7-rc6

- Fix alloc_free_mem_region()'s scan for address space, prevent false
  negative out-of-space events

- Fix sleeping lock acquisition from CXL trace event (atomic context)

- Fix put_device() like for the new CXL PMU driver

- Fix wrong pointer freed on error path

- Fixup several lockdep reports (missing lock hold) from new assertion
  in cxl_num_decoders_committed() and new tests

----------------------------------------------------------------
Alison Schofield (3):
      cxl/core: Always hold region_rwsem while reading poison lists
      cxl/memdev: Hold region_rwsem during inject and clear poison ops
      kernel/resource: Increment by align value in get_free_mem_region()

Dan Williams (1):
      cxl/hdm: Fix dpa translation locking

Dave Jiang (2):
      cxl/hdm: Fix a benign lockdep splat
      cxl: Add cxl_num_decoders_committed() usage to cxl_test

Ira Weiny (2):
      cxl/cdat: Free correct buffer on checksum error
      cxl/pmu: Ensure put_device on pmu devices

 drivers/cxl/core/hdm.c               |  5 +++--
 drivers/cxl/core/memdev.c            | 27 ++++++++++++++++++++++++---
 drivers/cxl/core/pci.c               | 13 ++++++-------
 drivers/cxl/core/pmu.c               |  2 +-
 drivers/cxl/core/port.c              |  4 ++--
 drivers/cxl/core/region.c            |  5 -----
 kernel/resource.c                    |  4 ++--
 tools/testing/cxl/Kbuild             |  1 +
 tools/testing/cxl/cxl_core_exports.c |  7 +++++++
 tools/testing/cxl/test/cxl.c         |  5 +++--
 10 files changed, 49 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/cxl/cxl_core_exports.c

