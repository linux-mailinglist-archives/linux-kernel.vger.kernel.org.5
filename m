Return-Path: <linux-kernel+bounces-20297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03695827CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E7B23271
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40628FE;
	Tue,  9 Jan 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtU7RoiV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7423D5;
	Tue,  9 Jan 2024 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704768546; x=1736304546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2sXiHNI+UNOMLjlArSxxfDUTD+AZbT5Z4pK8rjztu8g=;
  b=OtU7RoiV3awPal+kTrCKgIlNUXrnF7zqkiyhZo5F4PFCeK+7E6UbbhcR
   ymPO2KNhy/+UHY+BphoeFOEW+hAUabp3CUI22oKn80rPUhhe3EuuSVgqZ
   2/2dqeh/WP5bVC+tjF0hiteDySDZWXno6oLn2kns8t3V6CSv1sOcZi09G
   lEaUtrE5ZSzE8EBznQbXw9YwDJjlXj8zQA0eGDHouR7RgHZoOlsEIUvUS
   oW1Lx84bIKHAg0EK1pPQmfvcmTX2P5paMSlIXM/Gz8UIPOr7LCSjpl4LN
   tPJXtkq/7f/mxg73X7J9T/drt6WOP5W6Wa7+Duohik/VO8d8yhpVoiIQW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4844130"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4844130"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 18:49:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905001917"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="905001917"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 18:49:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:49:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 18:49:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 18:49:04 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 18:49:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNbeaALFcPz0Xf4T4JxHPdjhX0c8cIKlpuCVBL0Jef58Wp8OWCfchBYqJu2DwnqjBNgpNZNrJskPpkqECDNf6mbI9X8BQRxU7Fth3w3wgYET2NC2LLqGtmzywu1HbxmAyYJiLy8L0I0IX1NDzg0w3fcxPMdjupiCccbUx7BWs5VeSdq59e0DKyeIWJoS+ZPv8HDzJwbfF9A4leHgxC5xW+fBUt/DoPsxDQ9iEpiZBW9wVr8JGHkgjYyQs0o9yY/78ZsacqZBYfm6K+HTN9M06nyfqwqtatWpPU37cTKidZqF7zrxx3kBwJ9AV5fh4UDgPvR07bwR0mhT8PYefZfKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvgNI2l69wFxmN03S1cnf1RI69fYiF/mPTvYfOWbIow=;
 b=Gk5hvMG+qrWsCTLivPzp2HXfDK2c0rYISFlF6D9M+u7CnlNeclf224hg00P+IRBt+cBSoTbTqbuiHSdWNZCYHzfdrDELpLHqZGT9lNqBGyg85yd4F9tfzL7Z2AeSDE+XxyolHGGDy5rYJyCKqjz3rtzbQVusJNnUgEmZ16iC3kFBjtFucVgnaG/LS7vI1KlJyfMAUEg1OLObakA3rNtNeoqjkfSEvfZNzR3iVF7hZdGTwqsORbMusyD941DTJcz8jVaMofc7eeAWtrrmh6peM4LxChprkfBL/wCDYD5NBPWsn5yeNh0v04R2Pp+HfyV13t1Iuna7NNSdBY25Al8cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM8PR11MB5701.namprd11.prod.outlook.com (2603:10b6:8:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 02:48:53 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 02:48:53 +0000
Date: Mon, 8 Jan 2024 18:48:48 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: fan <nifan.cxl@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 1/2] cxl/cdat: Handle cdat table build errors
Message-ID: <659cb410470dc_8dbbe29426@iweiny-mobl.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-1-715399976d4d@intel.com>
 <ZYHWZjsnQwcBEDpd@debian>
 <658346b553a01_34d57294d4@iweiny-mobl.notmuch>
 <20240108150318.00006eba@Huawei.com>
 <659c1d888a5fc_8737f29495@iweiny-mobl.notmuch>
 <20240108180042.00005443@Huawei.com>
 <20240108180553.00001577@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108180553.00001577@Huawei.com>
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM8PR11MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: b1bec5b6-2b99-4041-557b-08dc10bd83f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RipgNWWZFyH/ZGQB4gB2+trQjzv4djxvwdE/Xg3vtHO4pHRpVLUXsWhhBxCboXypRZfJgEZkZa72pFIgIYBeJNUTW4XuEnl8wMvoOY2H7Rstc5C3HM2brXUGw2xjh79qeIS4T4jnXWdkPOAeXDR54rLOTe9YGukymIRhSos3UqWHNyhkmo1ZkAC6o8+VBt7qmLxJe0SOd/plJzmTTCyPwKqdBLhcEAR+b1OSGzztDB8I8iKEAS+C9giw4rdBUQviE5RVg+VGcG4o3MqjXgye7g2W2DBBm9UW83n+lQPBXS+/LnRwrRU5EI4aHk+6APSYjvwBMWgt6PGZW9sgIFUxUlWVDpwnYLZvr8pKPQvoXirVxFkQgBhT1JmXKmf3DJjiGLh4AXWvU9K4jBo0/xSeyAtv6/MPIg6sA607yACo7jUyMQJHNqXWPjTyIoQxIypSSfU93xdCuTiY88Uy+EpnDg9yfm/8mBKlB/QFKBkvl4egVZMRCYH419WigrZW2xOpKtFTtOStcRQKh0xdJCyLwV8UtT25EEX19BFPdM+Jtn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(110136005)(66946007)(66556008)(66476007)(66899024)(2906002)(4001150100001)(5660300002)(44832011)(316002)(6666004)(8676002)(8936002)(54906003)(41300700001)(4326008)(478600001)(82960400001)(86362001)(38100700002)(966005)(9686003)(6486002)(6506007)(83380400001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0fsw+/KmDyhlXpL7C5ipJgBMvGkcfp+taL3zERKLpuKyBrvRmV8AdXhj9QJ2?=
 =?us-ascii?Q?qNvfYHeomA4gGnvhV7w/uze9En4Oaaca2Rg00RJNzUdbWomNufCDXUj5NcAZ?=
 =?us-ascii?Q?5nRkSvZfSVjazQyqRvYzxVUPJmLCVhaRBIk9yCVo6I/bQkjXAvhaYpcuFXpT?=
 =?us-ascii?Q?1/08TMo+VibbP+0wDoafWaUHdt2IUSZ22aD6D3eWykf4/hUdOcOSbJhM83OO?=
 =?us-ascii?Q?6o6oy7wxJxp6Cq+s54K+bAK4HnOVu/7WawinswM8f2y2A0G6DpQxaDW4LVel?=
 =?us-ascii?Q?9zsdibmhAqOa9fI93yz9194mt0jO/FMRyIDBqERtRM7UKDCeNrZEvUEHyoxi?=
 =?us-ascii?Q?tQRz2TmD7dy+XmSkEgdmDyd87uR8vnHYB7CT3yw8rHyzKEdE8U+ilx87IyL/?=
 =?us-ascii?Q?PWZt+CMqckPfYIDv3ZHaTJCXHNCkNONvfde27hQpdg6OcuOmhb7WC6D/sdE6?=
 =?us-ascii?Q?HJiudEwYPxe/z/U5N6MaSLeC3lXTUHuMvRN+CGNiY3Y8TQRcjRN8NW0gjQAq?=
 =?us-ascii?Q?tLw+eAZpkSnXOzF5bhjNE09XYtGQiUnUgtnvLr1nIpCqSaP8RLhfmcJq01p9?=
 =?us-ascii?Q?dUOCl/JrYk/AxIAMJEPP/6nyrr8DCx7znuRAT/L6Au2CdVLCVJV0nk7YUJuK?=
 =?us-ascii?Q?0u+ui3NuOGrgpznEdfB1Zs5xg7ozYzyukn+OTDOVNxYPPEtNKDbGqyEwduY+?=
 =?us-ascii?Q?wQYISTqBYvx0L95jRL2F5FWR17wYSQOTLIkb/1Piyl2TLEKZpdBA799vGwqf?=
 =?us-ascii?Q?5kcWSmt8MSJuBxEovPlItaG3zZj/23/2beV7Qj4UDSDoCA+R8y4qA2FXN88p?=
 =?us-ascii?Q?VxHZsZlRKztfoxDZAPNak/XAkLnL9gds/TCBY2WqO6i2Zj/fwMznOIpBK2Fy?=
 =?us-ascii?Q?AM/M1LeCMXmDhLJAn55KhtKHIdIt4C8Drl+gadW/mI9u2D0dwDnNe6+Pf0O1?=
 =?us-ascii?Q?Zi8kiDL1ZmVXN810C1BbbpQCvJW8gvuV/bp1aArmhGZi7G3tJkQExjEZEVNi?=
 =?us-ascii?Q?jXu48b6yr+tKMU75s9uCLtp4ijBYADWeDYojBot39GsrtvueKdbI3T2Ptj0o?=
 =?us-ascii?Q?01D4P61WC9/6XxEm7BctucGLwfknEUuxPGGtMi3DY78xRlqGVvZmoUwR8krI?=
 =?us-ascii?Q?kUColzLxkdDFxvT5EJSKt4s0JSUwBj/fu/cd9mNajTimEHjt9AoRoR7mwasc?=
 =?us-ascii?Q?/f8+gmwJ412iHNn1jpZyI2RuAjZxrjoxtz1cQuWWD9uF0SIzzaQfZc9VDzMs?=
 =?us-ascii?Q?jsnLXrRA66CWdHphaaUWAFPpYxzTgb669PsSWbKZw2gYp+l9Yzd5KErT9aVa?=
 =?us-ascii?Q?CWhBOimqBf/5uM/d01As5hRHdpYbTgRQu8I5wg+Gcg8ZGZuXmcSJkO8v9QHC?=
 =?us-ascii?Q?0Utz/OtVSI460qta5Xbb/bZ1ZJSMJV5f6+p+yoa33jjaI9AdgvixPr26cVL3?=
 =?us-ascii?Q?JZA/m/8FzxwSeUmfSSjKSQmnyl9uwhGCZLh9xdsNJSYN/DcnhsvBy+Aya257?=
 =?us-ascii?Q?yjLl6T9qxDfKXZbwdcoqfRq6vYw7tEG30kwV09MGQxecvji1neYiNpCqepV+?=
 =?us-ascii?Q?P1uzJGZgw79aRvQJv9SvGHf86g6tnCfDU8DnOOsNst3nd1CDT2+BqQSCgUOQ?=
 =?us-ascii?Q?bwG+z4A7PzYNAiQBkXM6NTbNVMhwhQ4MMXtmg+7V2dbL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bec5b6-2b99-4041-557b-08dc10bd83f4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 02:48:53.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WcSH9J0xbWKSTrhd+d61OFfu9zx7k2HR3Ovob46xl6QmUxt0SjruMWxeryM8YQMBXvYjTqeEN1373ErvLh9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5701
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:

[snip]

> > > > > 
> > > > > I did not go that far as I am unsure as well.    
> > > > Memory allocations in qemu don't fail (well if they do it crashes)
> > > > Side effect of using glib which makes for simpler cases.
> > > > https://docs.gtk.org/glib/func.malloc.html
> > > > 
> > > > There shouldn't even be any checks :(  I'll fix that up at somepoint
> > > > across all the CXL emulation.  Sometimes reviewers noticed and
> > > > we dropped it at earlier stages, but clearly didn't catch them all.
> > > > 
> > > > Which come to think of it is why this error condition is in practice
> > > > not actually buggy as the code won't ever manage to return -ENOMEM and
> > > > I don't think there are other error codes.    
> > > 
> > > Ah.  Ok but in that case I would say that build_cdat_table() should never
> > > return < 0 to be clear at this level what can happen.
> > > 
> > > Would you like a patch for that?  (/me assumes you dropped this patch)  
> > 
> > Probably needs to first rip out all the -ENOMEM returns that got into
> > the CXL code in general, then tidy up the return type to be unsigned.
> > 
> > If you want to do that it would be welcome!
> Actually.  Build_cdat_table() can return errors just not for this reason.
> 
> host_memory_backend_get_memory() can fail for example.

I must be on a different version because I don't see that.

>
> So original patch is good
> as is, just that the discussion of memory allocation failure threw me
> off and should be cleaned up separately.
> 

I did this testing on Fan's DCD version...  :-/  ... probably very out of
date.

Fan do you have a newer version than your 2023-11-16 branch?

Ira

