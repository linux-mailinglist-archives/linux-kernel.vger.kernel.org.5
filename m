Return-Path: <linux-kernel+bounces-65566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3AB854ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606261F218F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478995FB8A;
	Wed, 14 Feb 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghA4ahvj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A835DF03;
	Wed, 14 Feb 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928867; cv=fail; b=NpLThdslzcEKJCds/MTL6aI5CtlN/Y7DjFfaZ2vexRnDMMgLPdH04OIQ4QlPkCctPB+ZN8NqG/s5pJ8ZKOQglzlp1igtTdVFOv0TKWu2aXhrxKGtK/hfO704tBhdBDH6Fj8MgylW1GIVlsS9WT3KA7jGHweaK3aGsdP8MtFhZJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928867; c=relaxed/simple;
	bh=ljK90fFx8YQAZ7eJsMTMXcIQrRLdfXGcvKbWVVLZJY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SWcRbATlbgPhs95ElEybVoXqfgA9vD7LglxrJwy/c3pSUau7pA1z68p5/rsyAEPtQ2NL+jUZwnTNIB2P9gfubsCd8QWIkktRhPikfcWHnQJP2XmTegmYHLw68n/3DI17GhYz8Sq2n1C55ub/3NBgJUk80WKL1GDXDjGVyyBUgU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghA4ahvj; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707928864; x=1739464864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ljK90fFx8YQAZ7eJsMTMXcIQrRLdfXGcvKbWVVLZJY4=;
  b=ghA4ahvjpXDWThgJVvtrAE2V3faTOzPB10CHU/dJ8rPJDqudXgQNHICw
   hEIr5ndE9b1EIKltBZ0VBh+T3kRZ2eZLI/tIbL8DJjoILr0/uVZdRA8Va
   ildkyI6gk43FUlQI9CWL2PIbM9PilcwLMLU7bn5rTJPdH0MeTOaCoBlgm
   6ma5Bo+0ipTuAy3M6c4NeLH8thfb5AN7oFV1DGFSPM6iekuhigLFwyMjh
   lshy14JJe1xB0zLBIY67CQErXgb2RRt3foOa0b6Ib1WtvBoGGDweJPdTl
   iDq71M1h542fkG29Ttv5msO85MWSrSy542/wZ0VfLI23jfNLwgz9By98Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2103380"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2103380"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3225907"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 08:41:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 08:41:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 08:41:01 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 08:41:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMHv/phGdaQkQgJXXbfIt+h8fETMAnBu4wlUrexA3YE32jxdYUq/mAlnaHqT+cc/UEQ6dpbuzEKhqpIOF0jh0B4szTGc4PjpULAjlg2aC13X0fahEiVCk7vxPUaEvwjsejhj7d0CFq2WOAFUbLe6ubdpEXwlx31iczccPegwzIqU9eQtu46OHZmY5EXu7ZHyvrjuBx48Bj3Hg/SvZeMEN8h0nuyYEfw7vIi2meb3IxsgksCCNI9XiA6sjDuEsH+7njRmHfU1xUBEqQmw5mMi9fykyNBialS7p1hrsULrPvF+kx3hy8uoU5CglflYya5GDMtnYfDpSOphZVoYy82Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Edi1HYOZyyRdmE5A+b2N5lRCJoFaYigjJQAtEmYqGOU=;
 b=m45jEqhZ0ErrJQ94RIYZ23dxOotfr4OZEJ+4hOVrY+IbOvIUBiZyYGprYUTApNbkTQH6JxtBW7PNxCUFZvk37GdHMBM/1/Vx7+uwjI8CKmfklhnf8wsxJnB/fobPISsoBtIeWCfFRaN2XDBxPOg2ILke3Dm9VUy3f/wsumd9VQKkVv+gFGawY3ZYIGiinHkxSxzBte+TzUxYwchNHlmaLqArLrBH1iX6WuxcpwCD5p2jyb0/JvQLTRinjwJRC8cyTSw40zKqDseWYCjIgFMuFVK4Z1urn00AuCfzCbIsjY8LiHEJbbMiXt9KLOJz0QsUS1Cj7kDpEOPPpSvux3aqOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5568.namprd11.prod.outlook.com (2603:10b6:5:388::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Wed, 14 Feb
 2024 16:40:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 16:40:59 +0000
Date: Wed, 14 Feb 2024 08:40:55 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65cced1753256_cbc9b29490@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214121153.00005c97@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5568:EE_
X-MS-Office365-Filtering-Correlation-Id: a694e886-8e9d-481d-3ddd-08dc2d7bb90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiRYC1ClucdK9CQI0Vx1IiEFwYt4zGuESPHmcg4XEEozPIrq2dr7pld/D3s4AZYlpugE+yhZADOy+Keh/QivQGpcZ4PmYhPheoTDJUdn1U9NEMH2B39gS/4h0ndI8JjZu0vOFdOffrueBasDcNVtH36fQFPThHGlhZYylqa+UUATVOmjMSuePqReofsYQWBgeRnjQ1xwapoPrAs/3IawubwzJB11aRwuW+mbHZUEMVoqetDhmH9pN30AfxxHI1ygV/fRpdQxSU+TJmIVwg5l362TwuVf/kPcgdEWkDu/5NqStKiNqUEdlSE0B5y6AZKyIv7//El6rlnO3tGHQWC4RT/IkFgiayXN2yeqAny63kVk7VXQVcJEeluAZHmJG78eBd0FUUi+nIx79yMqmBmz7typUQQw9TmB71xztgSvMIYEFX9A+PwLzI0PB0+V33IB3IT7fI/v2Xa7hJPcYqAfh30rYSLLK0Tkku0/asAE9SoE1msO7ohsY4is216j1US96EoWiekpmnfwe64YKOduNerFoRDStjP7eCCJqPtJXnmLO1ZSol94lh0oCmb5ofZPi5f7pp+tkGasvfDE7OS2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(7416002)(5660300002)(316002)(110136005)(54906003)(44832011)(41300700001)(2906002)(83380400001)(26005)(38100700002)(86362001)(82960400001)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(478600001)(6666004)(966005)(9686003)(6506007)(6486002)(6512007)(84970400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Olkt0EwxFcYP+DR+gzAgY5KGP6WLomfuTl7W2z3j7y53POMGCF7Ovbp9KbDk?=
 =?us-ascii?Q?g7q0hg72sTfzZ/fzxoHGJfqLQ3HYwXg5pyhFYc7MElDdkG7jDyv1Dp6sovg3?=
 =?us-ascii?Q?0fg2QtYV9F3Xlz6qkezX68mtWVIWUkdfwzGmfa9saSgpABkZrDp/hhTY946e?=
 =?us-ascii?Q?9grS0PsdGUS7o0/twbnsO0/6kW4592RYL4lgJDvTRrNutTlp/Eves4Gwis2v?=
 =?us-ascii?Q?myXcE8xmLN5I93H786BdRpX4blKoh7+k1mHN8rx5dM3fZsFA7fF6TEY6MOTu?=
 =?us-ascii?Q?EltCZ+oDWgjtPqkZxrMcGYwDeekgYgLFL4E8NGZaDhvpnd6ZS40KOPIiI5i3?=
 =?us-ascii?Q?UanCIZxQVazAGBNuezdTF7hy8spucHVJuV5Z15gTFmwwTJjr3ZST+QZg72Ac?=
 =?us-ascii?Q?sxn7rD7r9/xf4c+mgxk1XzJQN3nMdHMpDKrwJ8tN4OEj7e3VwgQwpmLDpEtr?=
 =?us-ascii?Q?hb8LdGw2/VqGaa5a7jF6T+76U6djx+YSBiyyelxQE6wDYO1eA8upZi05p+Dn?=
 =?us-ascii?Q?W1mt2qCpCdgwLAgKWuAFTeMpmaBYXJ5WOljSsZ6fXw4yJQZMp6j8Kxk/MHLf?=
 =?us-ascii?Q?Z1cU5SXzx7iQgFR7jBw3wwc5FAcGBYpyZftz7i/5NROcnifJb3weWKtAVE/h?=
 =?us-ascii?Q?NdhDDArkUSE2mIqpfk5IN7pmjU/GUxZtPo0qEg33hcpmaHi924ljL/O6CSuD?=
 =?us-ascii?Q?iUoS0s8t3kvesspTSql9Hv0LZvTQG10gYxuGW1jRoiLk2kD+jG3w7dQoHQ11?=
 =?us-ascii?Q?XPpNYmLY7UFUOz03mu1FEq6tioDlenD+kve3zcXH4Vgt0lSYv8EdqvuMEdis?=
 =?us-ascii?Q?/o74bTKLSmfzW5igwLPPxMq8j5TlkQ/xVRz+n/FVeA3ne48incZwsI5nOOfR?=
 =?us-ascii?Q?qJY+GRkrE4VqH/ZAEqxTIrzzvbLEwOu/r074SwOkSV2UFR7YbLo1/wm1hkCf?=
 =?us-ascii?Q?TXkwaRwh7VUj/hv5oH5ZKCtdX3QbMgJzeTixrob2TogsAprlY9ELY2Hr0tbb?=
 =?us-ascii?Q?TR2sz4SJdCQglo88VFCQqDKFx33/pRxvzjX+i515cfSixq0UsVmzhReIdGc2?=
 =?us-ascii?Q?3zdNqmsZlwf85J4WBg0oi3vofKy9p9MDvsSMmfs8leO4FrhWuhk8luax66xA?=
 =?us-ascii?Q?UVuHJ7NMgkQPjxH/AsFwa6JotrJekJ7bL2ZWcK7m4U3RNg3b3Bp/q6sqxivM?=
 =?us-ascii?Q?Zf0nkN7LQVJ8UZ6jX2TtQiZ3vZLpQTXHOjlNYquDKpKt7rWEoQ31NUrYujjP?=
 =?us-ascii?Q?uXErKiDuzw1P46AFMkh375qMvmrV7DNxDEXY+AJ3g/4LmATd+Lc43iTo3yCx?=
 =?us-ascii?Q?k77g0GgGC1LOloL00lL0h99uVmvuUja16mF7fvFa3CMtPFLd73Q4YSExnrXS?=
 =?us-ascii?Q?XqXuXpeE6oVRZIUPet619rm0Szzvqe727kDDOG/isHDpQIPyHFEZC89MGNex?=
 =?us-ascii?Q?fzFRMJVxC5fsujKHDMmmSgGeVRU/2QvqejpSCx/PWXIj1OeXXzU8pfKyAH1R?=
 =?us-ascii?Q?sNYkhUQevWfADkvyXKyy1bbYhmXcKjqe5mv+6MxrFyw2HpEPkyYnrMPvwlUL?=
 =?us-ascii?Q?C5K2h+G4kBZJEtUZvRicdGKXB1OPorLS3G11lgye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a694e886-8e9d-481d-3ddd-08dc2d7bb90c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 16:40:59.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bu+7TOm7WHfBq6bbeDtx/G4TJOXZhfcKezFyEeQfzIqTsabZnJjiLxWjYrxCYYsaJ9q2b0KWCvw/Tpmz+VPptQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5568
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Tue, 06 Feb 2024 14:15:32 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Smatch caught that cxl_cper_post_event() is called with a spinlock held
> > or preemption disabled.[1]  The callback takes the device lock to
> > perform address translation and therefore might sleep.  The record data
> > is released back to BIOS in ghes_clear_estatus() which requires it to be
> > copied for use in the workqueue.
> > 
> > Copy the record to a lockless list and schedule a work item to process
> > the record outside of atomic context.
> > 
> > [1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> +CC tracing folk for the splat below (the second one as first one is fixed!)
> 
> Lock debugging is slow (on an emulated machine) :(
> Testing with my gitlab.com/jic23/qemu cxl-2024-02-05-draft branch
> which is only one I've put out with the FW first injection patches so far
> 
> For reference without this patch I got a nice spat identifying the original bug.
> So far so good.
> 
> With this patch (and tp_printk in command line and trace points enabled)
> [  193.048229] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [  193.049636] {1}[Hardware Error]: event severity: recoverable
> [  193.050472] {1}[Hardware Error]:  Error 0, type: recoverable
> [  193.051337] {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> [  193.052270] {1}[Hardware Error]:   section length: 0x90
> [  193.053402] {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> [  193.055036] {1}[Hardware Error]:   00000010: 000e0000 00000000 00000005 00000000  ................
> [  193.058592] {1}[Hardware Error]:   00000020: 00000180 00000000 1626fa24 17b3b158  ........$.&.X...
> [  193.062289] {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> [  193.065959] {1}[Hardware Error]:   00000040: 000007d0 00000000 0fc00307 05210300  ..............!.
> [  193.069782] {1}[Hardware Error]:   00000050: 72690000 6d207361 00326d65 00000000  ..iras mem2.....
> [  193.072760] {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> [  193.074062] {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> [  193.075346] {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> 
> I rebased after this so now we get the smaller print - but that's not really relevant here.
> 
> [  193.086589] cxl_general_media: memdev=mem1 host=0000:0e:00.0 serial=5 log=Warning : time=1707903675590441508 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=128 flags='0x1' handle=0 related_handle=0 maint_op_class=0 : dpa=7c0 dpa_flags='0x10' descriptor='UNCORRECTABLE_EVENT|THRESHOLD_EVENT|POISON_LIST_OVERFLOW' type='0x3' transaction_type='0xc0' channel=3 rank=33 device=5 comp_id=69 72 61 73 20 6d 65 6d 32 00 00 00 00 00 00 00 validity_flags='CHANNEL|RANK|DEVICE|COMPONENT'
> [  193.087181]                                                                                                                                                                                                                                                      
> [  193.087361] =============================
> [  193.087399] [ BUG: Invalid wait context ]
> [  193.087504] 6.8.0-rc3 #1200 Not tainted
> [  193.087660] -----------------------------
> [  193.087858] kworker/3:0/31 is trying to lock:
> [  193.087966] ffff0000c0ce1898 (&port_lock_key){-.-.}-{3:3}, at: pl011_console_write+0x148/0x1c8
> [  193.089754] other info that might help us debug this:
> [  193.089820] context-{5:5}[  193.089900] 8 locks held by kworker/3:0/31:
> [  193.089990]  #0: ffff0000c0018738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x154/0x500
> [  193.090439]  #1: ffff800083793de0 (cxl_cper_work){+.+.}-{0:0}, at: process_one_work+0x154/0x500
> [  193.090718]  #2: ffff800082883310 (cxl_cper_rw_sem){++++}-{4:4}, at: cxl_cper_work_fn+0x2c/0xb0
> [  193.091019]  #3: ffff0000c0a7b1a8 (&dev->mutex){....}-{4:4}, at: pci_dev_lock+0x28/0x48
> [  193.091431]  #4: ffff800082738f18 (tracepoint_iter_lock){....}-{2:2}, at: trace_event_buffer_commit+0xd8/0x2c8
> [  193.091772]  #5: ffff8000826b3ce8 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x124/0x398
> [  193.092031]  #6: ffff8000826b3d40 (console_srcu){....}-{0:0}, at: console_flush_all+0x88/0x4b0
> [  193.092363]  #7: ffff8000826b3ef8 (console_owner){....}-{0:0}, at: console_flush_all+0x1bc/0x4b0
> [  193.092799] stack backtrace:
> [  193.092973] CPU: 3 PID: 31 Comm: kworker/3:0 Not tainted 6.8.0-rc3 #1200
> [  193.093118] Hardware name: QEMU QEMU Virtual Machine, BIOS unknown unknown
> [  193.093468] Workqueue: events cxl_cper_work_fn
> [  193.093782] Call trace:
> [  193.094004]  dump_backtrace+0xa4/0x130
> [  193.094145]  show_stack+0x20/0x38
> [  193.094231]  dump_stack_lvl+0x60/0xb0
> [  193.094315]  dump_stack+0x18/0x28
> [  193.094395]  __lock_acquire+0x9e8/0x1ee8
> [  193.094477]  lock_acquire+0x118/0x2e8
> [  193.094557]  _raw_spin_lock+0x50/0x70
> [  193.094820]  pl011_console_write+0x148/0x1c8
> [  193.094904]  console_flush_all+0x218/0x4b0
> [  193.094985]  console_unlock+0x74/0x140
> [  193.095066]  vprintk_emit+0x230/0x398
> [  193.095146]  vprintk_default+0x40/0x58
> [  193.095226]  vprintk+0x98/0xb0
> [  193.095306]  _printk+0x64/0x98
> [  193.095385]  trace_event_buffer_commit+0x138/0x2c8
> [  193.095467]  trace_event_raw_event_cxl_general_media+0x1a8/0x280 [cxl_core]
> [  193.096191]  __traceiter_cxl_general_media+0x50/0x78 [cxl_core]
> [  193.096359]  cxl_event_trace_record+0x204/0x2d0 [cxl_core]
> [  193.096520]  cxl_cper_event_call+0xb0/0xe0 [cxl_pci]
> 
> The rw_sem is held to protect the callback pointer.
> 
> [  193.096713]  cxl_cper_work_fn+0x7c/0xb0
> [  193.096808]  process_one_work+0x1f4/0x500
> [  193.096891]  worker_thread+0x1f0/0x3f0
> [  193.096971]  kthread+0x110/0x120
> [  193.097052]  ret_from_fork+0x10/0x20
> 
> So I'm not sure how to fix this or if we even want to.
> 
> We could try and release locks before calling the tracepoint but that looks
> very fiddly and would require ghes.c to be able to see more of the
> CXL tracepoint infrastructure which isn't great.
> 
> Just because I was feeling cheeky I did a quick test with following.
> I have a sneaky suspicion this won't got down well even though it 'fixes'
> our issue...  My google fu / lore search terms are failing to find
> much previous discussion of this.
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 9ff8a439d674..7ee45f22f56f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2957,7 +2957,7 @@ static void output_printk(struct trace_event_buffer *fbuffer)
>         iter->ent = fbuffer->entry;
>         event_call->event.funcs->trace(iter, 0, event);
>         trace_seq_putc(&iter->seq, 0);
> -       printk("%s", iter->seq.buffer);
> +       printk_deferred("%s", iter->seq.buffer);
> 
>         raw_spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
>  }
> 
> My assumption is similar views will apply here to Peter Zijlstra's comment on
> not using printk_deferred.
> 
> https://lore.kernel.org/all/20231010141244.GM377@noisy.programming.kicks-ass.net/
> 
> Note I also tried the hacks Peter links to from there. They trip issues in the initial
> CPER print - so I assume not appropriate here.
> 
> So I'm thinking this is a won't fix - wait for the printk rework to land and
> assume this will be resolved as well?
> 

Or could we avoid the situation entirely by using a static call?

The work queue still needs to be created because of the atomicness of
ghes_do_proc() but it avoids cxl_cper_rw_sem.

I think the hardest thing may be writing the commit message to explain all
this.  :-(

Ira

