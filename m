Return-Path: <linux-kernel+bounces-7686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E070F81AB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BE0B24715
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACB6623;
	Thu, 21 Dec 2023 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4WrS0y5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306B10F5;
	Thu, 21 Dec 2023 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703118171; x=1734654171;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mdY1l42X8JBVaRlakT3crvMF2ZHjnHftkRuHy/+Iwrw=;
  b=n4WrS0y5Bb0cwEWzQr7NfqoBLVXPmdoLgDSOZIoGfaTPXKiogKCk0lAa
   c6DBrMgtlwdmxuVmxc9Tja9t+mZOi/HU0LqcH2heew4QhQIjIgWxRqgxh
   DWFWf7N8Gl8/hH6tNRTEN8ZMasTYWHWGtF0wAmYUTdyCpTOP/1gbzbYbZ
   LdSvnzmoRuQ76iCnnaPK+82PVXQcBvhEsHEVbKY25T7gEiR6K8VcaWZxK
   1qaQjB/k19AvcGxIFJjHTuyr6KSWY7Eq8UuuBxyiM3jfdajJliAmRIQMj
   r4YlqzpKHgaoctfTwlQr8Xj6nKiYFOOQsoDuF9/qIxzOowvbSN1LEOI/6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460232235"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="460232235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 16:22:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="752743328"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="752743328"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 16:22:51 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 16:22:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 16:22:50 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 16:22:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQyPKxfG7LqVggEvUH8y7FC6b4UdoL2BPb9+84+ksBVuMYBAaUMUPLgl0BtKgRaUTbsYfDhTWDVct650b33WAzW0Ko9r3icbPFY4HtIkVwQNiOWheTm6y8cD5UFNsq8pZdObb77NIMa6VO7AqfA+Ey1979gN0MgfvOMJICK9qTf7km4CCHUGysuEZycOiR4n5Deh3G69vZOgQMMauFQWHfLwG9FyQCbUxCuQMboaqdLmVr3fVqeg2/nt1L8fUz5Z0XS9p7NFN4Vcd5iSQJLIyFxdehtTaVe+lf51bcNaKOOOB+nXidzm0wj9yULZqzSgoNYq17uYNIS398APBdPEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gsaf45vGbGztUq0ezPS6LcRi7xoa2v3V/OefgXEDsA=;
 b=YC3QE3h8vTAZKYJ0VuDKm5JPGG3yEUHejJocGnpRoiYJTZaAAHVPp5t3nrOu1YuQVkWqTDfCfBu7G8fPZ+80sQXUgIS1P1O+h2GhgSxvN1TSFDGnBhaRM1xDeNtoiBgeB5PjUdgxapQMJao9McCPQQb1OjiqIncgFZvcm5KIeV8AmBZ3sRpl/oJ0rojkQAMPnAhjjorYDaXrcDS941oAGjfwSZnZdUsVXa4xan1m8+dQsK54gwtfonwylZ/X4ehFMjicqpmcvXnN2674JTzRtjbSlnYWedL6zNQiiqoLMFqROBMW3M8Hk90a2Kl6ChXzc4wynJq3bVVM7P/fSNKdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 00:22:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 00:22:48 +0000
Date: Wed, 20 Dec 2023 16:22:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Ira Weiny <ira.weiny@intel.com>, Fan Ni <nifan.cxl@gmail.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
Message-ID: <6583855481d71_837462947@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
 <20231218123339.000024fc@Huawei.com>
 <6580d26a74294_1bbb129489@iweiny-mobl.notmuch>
 <6580d606467d1_715492946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20231219165845.0000100e@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219165845.0000100e@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: c51a2b89-a4e4-49e8-85ca-08dc01baf541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8ZvymaB59i2R7HzVBnAu/F+HidNyxDclFC4gew/CyFXfKLUJVliXV72FO3k/nMtSmg3cmz0LIJ2z5R9Y1pQKeEDMD3vn2ShPYktwk46uwtpnLI9VTacU/twU5waXFSu7ILM7bSHmgOFrsRqZoYZ2zxFuHGNjP5hhh9Fc3DnssIVCJyp/hkEC7eSE5oWzReETfEk9mdp6v+nMc6hk1ZJ2GO/9IKi1S//DpTWNl/RXmaBVC91uJ0BVutOwFhxLpIPDEXCCPG5jkY4Cz8g+6vUYwbRXNtwMorxnIAsjxNKwRTJyKoYIVtbuAPdcJlnH63bqF6CFZ8LOjcrQjIAQmAJOhV+hS/nkWdIDnY7IgWMZZf4xDbChEhiCw8GN05LWZLfrhJdgG8yYXwzSqAC0rbeuWjGnuSWSdwvtuF1iuPD04mAFt5DdMDP4SBJ5tv4G3+3+Xe19bINK6B5IUtT9ztA1FLtfkMQjgwLXifly74H68XzS9tbsrP+IIkAECmtSnxPmxIQhynUO1yFd5wqzq07vqcCkASud8aEwxxcuvylYO8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(9686003)(6512007)(41300700001)(6486002)(66476007)(316002)(66556008)(110136005)(66946007)(54906003)(966005)(83380400001)(478600001)(5660300002)(6506007)(6666004)(4326008)(26005)(2906002)(8676002)(8936002)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DeGKqRNMz2GrlTxfxci7TDMWDBNbCoSidjaA0sBVNkg7ySDY9yL0Ov4uvTDf?=
 =?us-ascii?Q?nLWzT8bX27zo2tNGOJmLxAG0NymSsidgT/6SfKpIN1WSrAwTg8WJ+B8wqnUW?=
 =?us-ascii?Q?IEGTjJTJxhj54mKrM/apC8qFqE7t+zI8XUMGTGjADn79pEvgoEe/gCLGG5HE?=
 =?us-ascii?Q?6ZRBbchGYYtWJ2UQfGTt3MsFAv0LEWDvuwPZ2k+dm6B07vYz4qH3fWnJYNjs?=
 =?us-ascii?Q?TgpgPAVnfNpvEyX3NkOrXx3QlncCT34qjHXXh6cSzW9L9XlowZ1iFz08tSOe?=
 =?us-ascii?Q?2xSVski51mr41YxKc4cfLQrB2sfGLXrytZ+bBNsqr2oUCmrGna/YhaNQbYQd?=
 =?us-ascii?Q?TgG8GpWxFMvl+1pfFG/BAkC4r4YLzAH4hND5UrRRcnoEHjKD/KweWHE83IAA?=
 =?us-ascii?Q?tcuh42NyjTFXg3byZax11sVnh6wiKUG3ZivwzZbi4lJzc1K/hP4+5teMk5nv?=
 =?us-ascii?Q?pq6ObEDpphaLfryZJ/oQCuCGZ4TLTTuVP0YiosqAA0vqm3kUC1aORavrWTkA?=
 =?us-ascii?Q?B4JfuSmKYglqEwYP3++XGJOkE9azebxHMjKxV3oG0EC551xzDeCAWfR/KMz6?=
 =?us-ascii?Q?eEw7MsQ1dkpcKuQtWmc+hevokAXIeVO+VGMPLQalO0FdS0F8y3nA7dZz4m2D?=
 =?us-ascii?Q?t/VtWd7Yuz4xelz+dvQiRymv8B7tSA1VeHFFKCi0dowtMUjB5wWWj34TrCtT?=
 =?us-ascii?Q?muf5f0B2g3VbRwu8xckTQZjhGXcOMCwOs4jTGsFSQnt8PWTJYdyvUdNnnupI?=
 =?us-ascii?Q?zFQnMGXX4ZJB7Nu7TN1iVvgSAVHDfg9xUzutjEGOPQqRoJzPxuT+ut9oLk93?=
 =?us-ascii?Q?c05gqpQGW3ClNs17Q2LIDjZyKKmj3RGq0ganKD3f1y/WrXl6rRlDqArSs2SD?=
 =?us-ascii?Q?J27cd9jpjQNvqH9til2zXLhnZu/tAQzjriFvWZ56Ktkl3Cx70PLGB+5rjsBt?=
 =?us-ascii?Q?8PUQQggfTvCl/kr4SVUX4MTWW9jqPtumD49i61QhhVzblvqLbsKG9cJkDdUw?=
 =?us-ascii?Q?8aDFGMHa/XL11BK4gVazp8eCIcNGj+hBqXQr+PpEp84EUBDi6gLF0fmNU2IS?=
 =?us-ascii?Q?fNXliTKp92223Uebk8G5gNla3RlSBXYQpsS2T4KMW+sonpmifbV+jz5Oo/2v?=
 =?us-ascii?Q?0zIsAbIbXqh3pVDdVHDk0ZuiEFhnpEfG11qBrOUYyknIcRPmQ8XcfSDx0ECw?=
 =?us-ascii?Q?9X0fKslEIqkwqgURNd2EGKK3taO+OyTIYOtbiarWITTnNYgZRgG/4MUloZ/D?=
 =?us-ascii?Q?IFEXSExw8w7yvF8Ece+xbAVEP1HH7BNi8wNxD9HnooNjnb8Pc+SrwkKaNVda?=
 =?us-ascii?Q?OCmof6rCZbzJZ2XOuN1aAmNxTUCqRZ6QAAT98pSCH56e02LsPJsuH+o8ia8Z?=
 =?us-ascii?Q?TqcsGFsvfcZcyHJmBOgDoF7dGNwOMGrfcxDlZez4O/XNWZUT68eHd36AdfIN?=
 =?us-ascii?Q?wNykRYcFlqcabx4TvcKPDPDbPYH8XT2mvf7Rbf6SmyoTz2/a0Qd/yLVz0Aj1?=
 =?us-ascii?Q?sQd0YkNZs5GdwaMIW6ingWqFiil9U9l600nNoeOH6vBs2hzuOdptrx4ybtiq?=
 =?us-ascii?Q?YLKRtnQ50BtVXsoOSGCXRvggCndzAoOjGREYLkMn77ukbAlrYio7Up+WfIYC?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a2b89-a4e4-49e8-85ca-08dc01baf541
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 00:22:47.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJx2vxZ2rWbtEqX64fRQKBq8IbnmEKFu6vBWVCve6J3n0GB7g5GjHECtW8a1XSiwo5tf/tMqLdBQs9F8NEDk/T96JepsnuSUJjzAUehOUSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 18 Dec 2023 15:30:14 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Ira Weiny wrote:
> > > Jonathan Cameron wrote:  
> > > > On Wed, 29 Nov 2023 17:33:04 -0800
> > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > >   
> > > 
> > > [snip]
> > >   
> > > > > [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> > > > > 
> > > > > Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> > > > > Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > > > 
> > > > This only becomes a problem with the addition of DCDs so I'm not going to rush it in.  
> > > 
> > > That makes sense.
> > >   
> > > > Btw cc qemu-devel on qemu patches!
> > > >   
> > > 
> > > Ah...  yea my bad.  
> > 
> > Might I also ask for a more prominent way to quickly identify kernel vs
> > qemu patches, like a "[QEMU PATCH]" prefix? I tend to look for "hw/" in
> > the diff path names, but the kernel vs qemu question is ambiguous when
> > looking at the linux-cxl Patchwork queue.
> I'm not sure if the QEMU maintainers would be that keen on a tag there.
> Maybe just stick qemu/cxl: in the cover letter naming as a prefix?
> [PATCH 0/4] qemu/cxl: Whatever the change is

+1 from me.

> > @Jonathan, what do you think of having the kernel patchwork-bot watch
> > your tree for updating patch state (if it is not happening already).
> My QEMU tree is a bit intermittent and frequently rebased as I'm juggling
> too many patches. Not sure we'd get a good match.  Mind you I've
> never tried the bot so not even sure how to configure it.

Here's the documentation:
https://korg.docs.kernel.org/patchwork/index.html

The basics are you just point the bot at kernel tree and whenever that
tree is updated it checks if any of the new commits match patchwork
patches by git-patch-id (or equivalent). Rebases are ok as it will just
"re-accept" the patch with new commit id. The main benefit it has is
transitioning patches to the Accepted state, or Mainline state depending
on what branch you tell it represents those states.

It does require a git.kernel.org tree to monitor, but we might already
get benefit from just pointing it to:

https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git/

...to automatically mark patches as "Accepted". The "Superseded" state
comes for free with the existing patchwork-bot monitoring of the
linux-cxl@ list.

