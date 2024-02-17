Return-Path: <linux-kernel+bounces-69667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8D858D0A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB92E1C2133F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D11BC2D;
	Sat, 17 Feb 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEl0RO+j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22C11CAB;
	Sat, 17 Feb 2024 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708139234; cv=fail; b=BU7Iqhkd5bVIev2kSN8rNmI6b+XxPAxe6feZ/lXkZsROGcXBN0sdRmMYNizl6Q1QufbPsx8ofuNwlnzGXNjrMZrLcg2prnBhSdTiJzRMQkXu2dTER8wKU+zQFQkKvrZVXZMA8u7qhw0FIXQdo8bbwxv/d28Vep1++3I5KBOyt2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708139234; c=relaxed/simple;
	bh=KOs5QoXOXv6Ck6XCWJgQyM7Z+0cH9wRIDhMxifK5LQg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bzWxxf571Ydv1gf6awqu752EJVwkS0Cw6knUeziBGB0e8kWFc6TVjk5ug+SpAztprTVVIv1VT3IFKlKnfSVXF15xDRgXji94tCYJW1FITAzwbuRqBCLnX7ujXDxiqNq1bSFijQz+Oczt9cR37R8iI2K6wyDjURoNKB/nk9X4VSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEl0RO+j; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708139232; x=1739675232;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KOs5QoXOXv6Ck6XCWJgQyM7Z+0cH9wRIDhMxifK5LQg=;
  b=KEl0RO+jb8OEKPkNaq88WW63+uXq1D576KB2GIDghFUQ26up+h1ecqhl
   fXEqU3l6Fph2Zl9yNb5Obcj35Q8vJEdy6p4QTAXC0BQi9M/b0wUC/r2YJ
   zTlG9s4tHrarXj1QWROkRSEDlxFG9XGJL6yHSWKasRqfIwwd6zk/pv61E
   hfY3HFpCkDbkyoaF8Hiq9vBQT929v/mFcSobT4HJo6pfEIYE9R/sqT1Ud
   GLdum7AFFMUSFk+eKQIvOwVUpRQIteTK+q7Y6u04btHihbmYdl/9ErYHe
   4cnWEB9gLV0X6uhBzd1/w+ZPcdDbHpQXZ7NlI2etzXXrIWM99v6dzlEKf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12996005"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12996005"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 19:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4293344"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 19:07:11 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 19:07:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 19:07:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 19:07:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH6ygMd2oLCl5b8UtJdTPOqZr60GPK3QH9tO+v7BtNQ8xY6MA0yT1/1ZS63TJHnd4C1gyuTABMFaaKuAvBUT2lUByc0gmJLKmrHQlUxnTDcZhxcje7tJGA/ZhsI0BNv1LLtFsZq5S40PWLOGAWHerjUelqjoBqteQrcbFw5pTV64IWOt6LddVemR5Y1R2Dk8z8Qa8brc8sxoxnuM7+lNKGzB/nvK1OWEC9vJRGWtjLAoKRxHup8Jc3+X1zxqMP5nJDqf8t6/0CUFF+SIVxOtHYXjEKn7ibwUkLq4IFxma9XWs8QatqmfjlRhZyLqJYiqqMRYnN46YJ0Uyl0hFw82nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQfSaZdddxJrsNWbDSARFAN3KrrklZRyqiyzwuo2TTI=;
 b=bS+Ta5GjiCBokQmb4dEhY9gikwNVQhXpBT65/0wVZZsgZd/l9RnBp1xJSjsSaVm3cNWgxuHaAU0WOyPYZV05OpwHit8oIhquk4RUmQG/qVh5rGPK1yLcVLbeVLO+2WwM+V7adUwvUs9YDWBRPU4sKHZVl7MKWTrwlanef+WqRCoN8eR/aloY4qhVwnR7DZ5km9xX+c4YUYbvqHsWIbLxytAsnVkN5uwyBlU/pL5G7Aqjd0NzxJVanjZbipBhvGnCL05irZNmFi8AErD2DM2Cahuu13QZDkxgF8lpel50HM4w4qUX4MxhQ3rg5wL8SFdzwTgEVhdAyb/A7ZaeU2HIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sat, 17 Feb
 2024 03:07:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Sat, 17 Feb 2024
 03:07:08 +0000
Date: Fri, 16 Feb 2024 19:07:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does
 not match a CFMWS window
Message-ID: <65d022d9b02f5_5c76294ed@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240216160113.407141-1-rrichter@amd.com>
 <65cfa34b741ea_5c762946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zc-k1TDk1hfvakQS@rric.localdomain>
 <Zc_b_F5TSRSBwrNZ@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zc_b_F5TSRSBwrNZ@rric.localdomain>
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd71501-5304-4859-b2f6-08dc2f6586b6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PFt0fgbfYjbNULwc5E0uGPJNDauUcJWISVtgVlREnAJflSlYjjMGK4iEhOLMdHwOPlYAUg4lnYhU6h3BUt2cIXWMZ6lacS32cTWUn01DvFRQNxCofGOPgMVMtKnmh9o0nA7tMVjK1n/3yD7cwEb/YFFTln3wCqlzBLheKo/dT3WJSOfQHROy32waHA5GAWe5Gmfg8hRpgSszsFYY3cWYRWrmIhiaWOeZHI2aKFa8oeQA3fQVJ6zwlxLiu/NAA8Px1YVVQtFZ6tDVpxIzcDRWY/kTH1/NmhH/Nk+xauHszY0EU9bAkiEcvH07ROagXnfKP+StrUc2AQWG6/k+jUhQAj6b7Ga74mnvn4QciKneww2yXJne4JJjoCTQ5e7BPuX48wQ5Hbf3Ey8J9910zITfCo4x48td1TICSoRbJWVZ7+a2kTcMm9xaUirUrc687bdQIb7afv/WERAiajMIjtmJ58p5M0aG7kgyFcQuHyLLj6r7ue+Vspr2tS8/hvTdxqlO3/so39QBM5XpljVFa126jYv2yh/zMklTDNr0yn1t73G/xa4h8GHu53KIYn5R5Kvu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(5660300002)(8936002)(26005)(478600001)(83380400001)(4326008)(110136005)(6666004)(8676002)(316002)(66476007)(41300700001)(54906003)(66556008)(66946007)(6512007)(6506007)(6486002)(9686003)(53546011)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Op1SWHIcKRE9+jEJ/9sKhlB7jXMQGzh+wnJdUCexIxN0CobJIkbqQtcWBqij?=
 =?us-ascii?Q?mcggMJfU+DFrdB/HQDc4vgFC7rJ8bYJNuseaI7S7iUet5ZLybMFoF036NgQi?=
 =?us-ascii?Q?MwWAuX8joNNf5QVHipPJ6Gr9r21N7hQsETNJap98aOq07fxnEe8DHx+8zgY1?=
 =?us-ascii?Q?1pKk45QgXBmUvglfPq7HIwj1K3ykNNtIxEINkptnb7ff2TbApVZaxkEU6mv9?=
 =?us-ascii?Q?/2sNAYe8H7GYr4GgmdK+xlwCic3MnB94N1PI6nk48JtoqVKofpfCJszsSDXA?=
 =?us-ascii?Q?ZNLVx1aiT4t1sIK+Q86RxGjSlFqhpyFG1agnKpTXK5w4CDNQiK8qBSZSuLbc?=
 =?us-ascii?Q?VFbegylWhsYmZ1Klm++S21zHPoYfDBmP5P7ZvbfmFrxeBXvhBqk/jIlmNOwm?=
 =?us-ascii?Q?+dRYIeEmCbmo/9AFStdczZF9dGyK6w9UVF+ny1JF0csUle8Z/ZwqfjcGab5n?=
 =?us-ascii?Q?mKgVNfqTqEjvLiogMCfMDP2UT+L7OlweyVgc9pIQohSQJLTzQHMzKxsql3Jj?=
 =?us-ascii?Q?KIVcSVwqRaQtnax0cS+wZOep7KIbt9M2PTRMQyKVAzJHerSetfQAz5NytCXP?=
 =?us-ascii?Q?bxTo/veu9LCVL04cKibQj/G8TFgcEWDkUMK2FcwnfSRLTCCUQ31rqDCPZ224?=
 =?us-ascii?Q?lTs0vBY7+rinGCNsti4VfJht9L9QPtQFyRufUOSMFzlP/wuwIbIB6g179eNn?=
 =?us-ascii?Q?S6ljKQIj8ujhWfd5/qtE0tnjh1n6/mvoP5ypUe7dQ2DEa77cBPWWOR2Eigp8?=
 =?us-ascii?Q?juFWXfrzy7gqF7p1upTWO/fKS7PH6uddi6r+xsDcAQoqjGIem72u1O5KM+iy?=
 =?us-ascii?Q?hOPZyN/+eVJn8Y5zknL1nJJ/qpqRKERRQrNTudE8Ku6o6dsOPnNKIsYJZkkt?=
 =?us-ascii?Q?4Q/ZCKjxsFqHg4jvb5WxP60InYclvo+92fKvTB9T1GqfR2CmvFnroE1Nz3hs?=
 =?us-ascii?Q?svevRrNLoQHWCqOv/QzECpqxmumHYca/QrNs+rtqTky8XnW4JxMfDpkzeHR3?=
 =?us-ascii?Q?Vlr17x/AQRWJyDlGsN9+qy1bfbeZIXNKLerIzhm5sFWKvSuckD8/kpjdJ+tp?=
 =?us-ascii?Q?upU5gymom2hCJC/KmEoFXPNTrTyphXLtOVKVAQmf/uMT0AsnWQUrtp8lbYOt?=
 =?us-ascii?Q?w8rhuEvleqsiSwA/NibM0QBego+fikqz9XEjnvJdmou2/89mBuA5Ym5D35Ge?=
 =?us-ascii?Q?GrzJegsN8uK36ERxPfF5t1wsPlqNAnrbTxx+80V5tGbtL/g8fqhEOAA0TqTC?=
 =?us-ascii?Q?9yOdW4E2FMS4meXB4nHFwNiAlq6X41jKCOTkd2zSYMPE+Q1vPzkKSZd5rR4Q?=
 =?us-ascii?Q?br8kTfrLiLCJ2U/b5KsKtcuvB/So9Ma06utVD0m0OahNGFXleMLVOoPGzj7o?=
 =?us-ascii?Q?kDzs282+vcqp5XKjfEYhbQfGv1BD4Rlm1Yf3Ljsf4bGBvK2bnxi1ZzXLsAXY?=
 =?us-ascii?Q?JaPlnsKO3oTqLIbQOxbEtnI4lThsFUTaqs/feUXadKyHvl/99tNGsZOGGFKz?=
 =?us-ascii?Q?zAY9A50ji0s6as2d+yryZMBczRMiPwEcja2SJUGadE4ixkvhGLguChfP7fHw?=
 =?us-ascii?Q?rn9KgwJJJNLsgEKxThqAEfjP2N2LII2qGHD9ohtBlSMczhP4SqjM+/ALgL37?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd71501-5304-4859-b2f6-08dc2f6586b6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 03:07:07.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1knkt/xFRhbn8HEKuHl4oNlw+dS2aLaUaa8kO5qLAcUyMbRZAB/99aVVZRygrIlmXJB6SKIglLhwcuyuZXNjTs8VBZI8G/koDdhj241/GwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com

Robert Richter wrote:
> On 16.02.24 19:09:30, Robert Richter wrote:
> > On 16.02.24 10:02:51, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > The Linux CXL subsystem is built on the assumption that HPA == SPA.
> > > > That is, the host physical address (HPA) the HDM decoder registers are
> > > > programmed with are system physical addresses (SPA).
> > > > 
> > > > During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> > > > 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> > > > a HPA window that is described in a CFMWS structure of the CXL host
> > > > bridge (cxl-3.1, 9.18.1.3).
> > > > 
> > > > Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> > > > window and the CXL memory range will be disabled then. The HDM decoder
> > > > stops working which causes system memory being disabled and further a
> > > > system hang during HDM decoder initialization, typically when a CXL
> > > > enabled kernel boots.
> > > > 
> > > > Prevent a system hang and do not disable the HDM decoder if the
> > > > decoder's CXL range is not found in a CFMWS window.
> > > > 
> > > > Note the change only fixes a hardware hang, but does not implement
> > > > HPA/SPA translation. Support for this can be added in a follow on
> > > > patch series.
> > > > 
> 
> Fixes: 9de321e93c3b ("cxl/pci: Refactor cxl_hdm_decode_init()")

This patch just moves the memory-disable call from one place to another.

> Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating DVSEC Ranges")

This is the proper Fixes tag.

> Cc: stable@vger.kernel.org

Added.

