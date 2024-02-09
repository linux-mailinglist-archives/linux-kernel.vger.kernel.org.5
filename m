Return-Path: <linux-kernel+bounces-60153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EE8500D7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC86A1C249BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3338DEA;
	Fri,  9 Feb 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XsD8+Dwi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FE36125;
	Fri,  9 Feb 2024 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522257; cv=fail; b=dx0OhmZg3HewxeVd+TOaylmn/xWUFF8NH0AiOM5MyRnwzqcWEJPQ/xhcJrfQPE7/PgHMlZgnZKxgEeXNWxx0a2KP6GPIdiDJmZxi0KjdfhQDe5Yu5egUAbWteT7tH8jLxCaxrbuZFn8SAa2H+SklkCuxLTyCVvH+Z/tIl/0iFOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522257; c=relaxed/simple;
	bh=tFGHLk+Y+8fuk5VCB8oH8nuvioJDYBRZfi1trwA0YNo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXWOP5H68SCee4zEl3N0pblHVnwwRnLJIWDicNOlWsLBcDYLFwtsNYH9c+TcXgLPitsilJG+vFvu/6HX6N9w7Z++teDhT6ijXc3PFxsF1t4PX0rJ9KU30ByeIonninrweNVlcp4nkiAgm6h5AUSvhAgYgdCqAcylI+FZsbt0VgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XsD8+Dwi; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707522255; x=1739058255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=tFGHLk+Y+8fuk5VCB8oH8nuvioJDYBRZfi1trwA0YNo=;
  b=XsD8+DwiuhXGXvENz9kMl4vobB+Q7bbe/eHE4k+AQBRGTDOWnGEkoz0h
   VRpJ6td75pF9sK1Uzj3S4FTQzvd7k2xHDRoKLczr16ssZmNl31eGE/rG8
   SNZbSPcp3ltIqFw99r36GD5Koxsg0JfKDf/qadA5691DCskpmhYi8kwGh
   9rOLEFR2tdwN3HO1bqNoePZlSGwc4w/vjUsAUoNQ9cSZqek7jSEC0ekGt
   QvLnlQ7J5c8cBXEkRUxyOv+8qrfYBj1JiewGjMl5O9H1wRHvN6xerZ7Qo
   bd45WlTnMQuc+PHI7FfN4rCJ6oikV0zyyy0LMLIlsiJSH/2PiOCxwLvUG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12252298"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="12252298"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 15:44:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2095529"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 15:44:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 15:44:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 15:44:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 15:44:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J94dgNcRNfroQvx4fXKDpyL0xzCYH7Sb8qeBUXFiv5R0uG1Ep+szVyXjpxNTH58FtLy1UquRwHdVQp5B8XZOJqDJPf5Uu20XU/fakPxnhMecatndjCq1mstHyxC52up8u11pE7mhbG95GXg68N79uq3HBD4xtoXw3rx6B4cjRVauPgs4zYOBjF9Gr7AUezWQi+KGkvFlzR6I1frCWxewv93qy7u6M2hEXpHQL2czz9QTn3rswpkNp0yUSeNGJNwqLsmnsyAcuVXG+BhA8z2IZTdu9x5PL7XfeRO4NwvOYDTFFUMDzgNKN4K0zk47k0sypI/66d8r4BlhrZD1RHS7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpO0R8kxmgp7HpMafhKhaoj2xkmPh4UwT7/YSJ/nXIo=;
 b=fPF8t2mhej7qoKReakisT0l1dYK3YHXVmN7VELzi0YOkIqyU6HwEPzNdx60lLOQX7TpVUegQRZi1szt5S41W8sEu3W2qvUlPUDXiskGtZJK7kkVRJSLyPjy1w8zr4cvVsdBMrlZmuWPzy7m+AcR/SQkSTNqunLROqhISIi/ZMDbMdgMJA9RN+ND9JZC5HyrA4ARCalqR/4pSxIJkJIUGgjqn3DsEVi0GV0RLRpX09BzdjQbebzlwVIMaEtHMgT+4glRIKPPd3KhGs8vk3Omhi2qdtSYufwCdvgJg1ekb5t8R4zanz9OrIi1mS9O6xOJL2+SpczJB54uYMADqDBfXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PR11MB8757.namprd11.prod.outlook.com (2603:10b6:8:1af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 23:44:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 23:44:12 +0000
Date: Fri, 9 Feb 2024 15:44:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Robert Richter
	<rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: Robert Richter <rrichter@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <65c6b8c9a42e4_d2d4294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:303:8d::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PR11MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 728ab557-15c9-4114-05a2-08dc29c9047f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJfYp0M/jG1FAlD4EtHPq1/ZH0rlU9OR1ys1wicU6QLQuwjhKzi4pXFcljayCnNs/lag3Kros48EHXU7cYpyC56Ymp5voyeeM/AMlPgBKvdIYvTjqPu/YVXqfWL6iEb3gzDp6Jl7bQUIOYKf+whCN6e58l8CIA/Ea51NWUXyCtdD9QC4D4k8Fwp9gq6SN6UWOyjfGGM/a8BCu8yGMHb0gWDJFCyQ6gdHl+MwEDoFJVm13N8LtONvJP8hMiOx9DyI+F+nkb/PiGGoMLRBOJRjLQlRfioQfUAGhgx/ub4+bmTAVwG+zmlg4+pEraFXkaB2hT45vtWJtAgGNeM2h54nVXRDdn8YE9pvFFAq529cK23CfyV1hbCpopZBCQMjoBkSQJ0UkGr3kb59R6lf3zdC1ShMFiDmHa/Z15enJGKLmcoYjX5df1tMcHf/inFIWZmFdV8H/IeG2AN6YjKgVzRMenG297VzYZDrmv38fyZdrVi76zHvbJUaJhtKpjDbnICkkSKHWSvFSiESNK0qZGTaxP49gaQJz9KLd7YLiWYg4W1czB+1zvfzUDD3TirHhbZ7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6666004)(2906002)(54906003)(110136005)(5660300002)(316002)(41300700001)(8676002)(6486002)(66476007)(66946007)(6506007)(478600001)(6512007)(9686003)(66556008)(6636002)(4326008)(8936002)(83380400001)(38100700002)(82960400001)(86362001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/D+fs2KCts1R/DssMhz7Z/cLitg/q4ffpvWmUWJ3WLdwd+S+tFu6NYUoPnGV?=
 =?us-ascii?Q?ReOq0bJyFDZzhFfcLAOX+KMbO/tW4zOrdzli4MvDEPH/7OeJ4YTpwiCkcQty?=
 =?us-ascii?Q?zibbZlg86DgugM18SUvP8g4OEWIayme0tC9c/Z1QtAZRO5FUSCDjwJXIDGwB?=
 =?us-ascii?Q?sfgOsIyX6mqiISgIqO8MeKhjjxayygBtGU6VJA+xaADOjlIP7pI6lkHm3YNM?=
 =?us-ascii?Q?FGaDZeD90/lNiZNym+GSkaed3N0Z8zg9UL0lnqS7WdM9PEvBjdE3eDWTTuIy?=
 =?us-ascii?Q?7dtsJWwCVXQ6rOMarZkcfeFx2JgRTI548GgPJWoJOpEogf8H9VH0V7jeWpdZ?=
 =?us-ascii?Q?QrdB6wBxEz98qL4Afe+OgL0V6YYeeJMV19bGWnZnARNM2M+PX+b3YEjgX0mV?=
 =?us-ascii?Q?wOJxkgDHTa7ph0usE2K+cpzSeaIxyO+ugPc8+i7crUsxaWur/Pz4dnCIWr+B?=
 =?us-ascii?Q?kkbq5PkCnbRcCuIJIipzGrhJrPh8Frlw+4ZGQK2/OKtqTi2GpTC72NQZYRdy?=
 =?us-ascii?Q?jKgnFWcYC4Kbc343QOZu3IVNqkCoSxVVFIGdqvIGtRWdSZtgq7+FaqeMR3Sp?=
 =?us-ascii?Q?bSoZFnQi7Is1/W6n4YigQI44NapzsKKuyGyirGBNFq86kOis7oOlMfYCA5yn?=
 =?us-ascii?Q?kEe1YkRbbnAtGFgfT1dtPKeS/4DgKjg+m//sTSN8FDghAFcvSWL+rczQ+xwB?=
 =?us-ascii?Q?AHo9G5eNw553vlU+YMaaFR3mE3EietjMwTYJsAicFQiLrbVf5+I3F2GtWCGA?=
 =?us-ascii?Q?CAcNpZFY9UkNwX/EIl5wR2yVJ+Pl1Nv+eusglxAuBKU+Wav9oIgg+5BFCUS5?=
 =?us-ascii?Q?WOR2A91mpAtR1Wfu49MlxXrjB3Klz6/f+BrneI2/RHopcQ6/T9az7ND5JV57?=
 =?us-ascii?Q?q3nllFQU8b4Cz5yxR1elLEBQwIpQahT0LNr90YQYSuVmdNdatYaGQ1KnMKuG?=
 =?us-ascii?Q?4BCvDVwYpHVJaDDeE667KSMXaDYPE98MVV0gR8UZh1jytAzprfdNacEE1U2N?=
 =?us-ascii?Q?yYzO+uxMoWY4m/ZrbMOXDIcWwb4y9CGz6/WYxyGzUT1yGQ6ivUJDKSeIA9Ln?=
 =?us-ascii?Q?2LnrwDt7t9IJ3TvZzQfA2KzSxDT6MueiWYC4w9AW3LWIHJxbauhGM5pYmEci?=
 =?us-ascii?Q?jPziGEVXTy7tqt65By3H6bIfOeappOvni3B0J0iVKvdg3XN6XLMGKmBOAgCa?=
 =?us-ascii?Q?kXSRyUOrLTaWTM7Aes1POws26ZjDTx4TIl8Uy9N/S9x/4p3f6iAHDwuTbCit?=
 =?us-ascii?Q?GFmiCXgEvBxIShjj1BChHLxFCLKwUiIDfYObVMBmy3+NRYy/eqaURfxE0vR3?=
 =?us-ascii?Q?KK1E/A+BSEalzFUX+8o3U3qA7md1xefuXvdbmPnDsWSXHdxUg5E86QGDLI1Q?=
 =?us-ascii?Q?93nZg3jdjpUotdPVPYxrd6yX6pbyJBIvakarEt7GgFCu85AFmioP4yiqtcB+?=
 =?us-ascii?Q?dVI9MOM5UytHGPQX1Aj5ns6+ks3KnaYH3421VRGBjNqROTlF7+2uZx4Apn8k?=
 =?us-ascii?Q?1xcML6FQlF/qWl+OSTr0Fi+vBQhWAd1SeOWtUpgVtRPJJTvcZpMU1NYR/78g?=
 =?us-ascii?Q?dtyk+gp3lCHpXXdszZiyG0hmU+zAVTRdrnZ02tuQcW615mQP54zUp66B2g1q?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 728ab557-15c9-4114-05a2-08dc29c9047f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 23:44:12.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/r+ZQIfelzRn56MWUsCItp30o5mOnoaNJbOcVVN/onfwHQqGIO1PAmmrrIsrrI5/oq8u/0S1GXIM0F3hP2fPHvfqoC02S8zS/6lqTPNnt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8757
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Robert Richter wrote:
> > Based on CPU implementation and architecture, the CXL memory address
> > decode per memory channel can be implemented as zero based address for
> > addressing the CXL attached memory. In such case, the CXL host
> > physical address may not match the system address. The CFMWS contains
> > CXL ranges that are based on the system address range for the host
> > physical address and may not match with the CXL decoders.
> > 
> > During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> > 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> > an HPA window that is described in a CFMWS structure of the CXL host
> > bridge (cxl-3.1, 9.18.1.3).
> > 
> > Now, if the range registers are programmed with zero-based addresses,
> > the ranges do not match the CFMWS windows and the CXL memory range
> > will be disabled. The HDM decoder stops working then which causes
> > system memory being disabled and further a kernel hang during HDM
> > decoder initialization, typically when a CXL enabled kernel boots.
> > 
> > If the decoder is programmed with a zero-based hardware address and
> > the range is enabled, the CXL memory range is then in use by the
> > system.
> > 
> > Fix a kernel hang due to disabling of CXL memory during HDM decoder
> > initialization by adding a check for zero-based address ranges, mark
> > such ranges as used which prevents the CXL memory from being disabled.
> > 
> > Note this patch only fixes HDM initialization for zero-based address
> > ranges and a kernel hang this may cause. Decoder setup still does not
> > enable the HPA ranges for zero-based address ranges, the HDM decoder
> > cannot be added then and the kernel shows a message like the
> > following:
> > 
> >  cxl decoder1.0: failed to add to region: 0x0-0x3ffffffff
> > 
> > However, support for this can be added in a later series.
> > 
> > Fix for stable, please add stable tag.
> > 
> > Fixes: 9de321e93c3b ("cxl/pci: Refactor cxl_hdm_decode_init()")
> > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 569354a5536f..3a36a2f0c94f 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> >  		struct device *cxld_dev;
> >  
> > +		/*
> > +		 * Handle zero-based hardware addresses
> > +		 */
> > +		if (!info->dvsec_range[i].start &&
> > +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> > +		    info->dvsec_range[i].end) {
> > +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> > +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> > +			allowed++;
> > +			continue;
> > +		}
> > +
> 
> I am not comfortable with this. It should be checking a platform
> specific quirk, or similar for the possibility of HPA != SPA. The
> entirety of the Linux CXL subsystem is built on the assumption that HPA
> == SPA, and if a platform wants to inject an offset between those Linux
> needs some way to enumerate that it is running in that new world. Yes,
> nothing in the CXL specification precludes HPA != SPA, but Linux has
> long since shipped the opposite assumption.

In other words, this nothing to do with "zero-based addressing", this is
about a missing platform translation that the CXL subsystem needs to
apply to the values it reads from hardware to correctly map them into
the HPA == SPA expectations of the Linux implementation. Something like
this (untested, not even compiled) where cxl_acpi picks up a quirk from
somewhere to identify the platform and replace default_cxl_xlat_hpa()
with what is needed:

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dcf2b39e1048..8543c9230484 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -312,8 +312,18 @@ static int cxl_acpi_qos_class(struct cxl_root *cxl_root,
 	return cxl_acpi_evaluate_qtg_dsm(handle, coord, entries, qos_class);
 }
 
+static resource_size_t default_xlat_hpa(struct pci_dev *pdev, resource_size_t dev_hpa)
+{
+	/*
+	 * default expectation is that device HPA values match host
+	 * physical address resource values
+	 */
+	return hpa;
+}
+
 static const struct cxl_root_ops acpi_root_ops = {
 	.qos_class = cxl_acpi_qos_class,
+	.xlat_hpa = default_cxl_xlat_hpa,
 };
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6c9c8d92f8f7..a945a0eccd6a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -322,7 +322,7 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
 
-int cxl_dvsec_rr_decode(struct device *dev, int d,
+int cxl_dvsec_rr_decode(struct cxl_root *cxl_root, struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -411,6 +411,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
+		base = cxl_root->ops->xlat_hpa(pdev, base);
 		info->dvsec_range[i] = (struct range) {
 			.start = base,
 			.end = base + size - 1
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..83fe7018d243 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -91,6 +91,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)
 {
+	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
 	struct cxl_endpoint_dvsec_info info = { .port = port };
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -98,7 +99,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	struct cxl_port *root;
 	int rc;
 
-	rc = cxl_dvsec_rr_decode(cxlds->dev, cxlds->cxl_dvsec, &info);
+	rc = cxl_dvsec_rr_decode(cxl_root, cxlds->dev, cxlds->cxl_dvsec, &info);
 	if (rc < 0)
 		return rc;
 

