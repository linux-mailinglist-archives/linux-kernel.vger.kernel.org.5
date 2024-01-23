Return-Path: <linux-kernel+bounces-35974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B4839963
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C27B2DD71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E146A005;
	Tue, 23 Jan 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KjKEMglN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EADC50A64
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037281; cv=fail; b=ken0Hn2AmeL7tf4vzV3/PeDadtaKiX8tqqB7n08BN2BAtFcobj2gbdPn0iEE9qJbhahcttxPlys7VrdTckQLbELLBaHQIaTs0PieU2FHmxTqyNCy8lL/t3Rd/M5ca6atjy7Z8bYQJeBky0D19PdCP8pk8qWaiO4FSl7sYaYbZzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037281; c=relaxed/simple;
	bh=X81x54J3KgRrBOhq1QcTn+vWx44WOA6j4v24x7x59eU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PIpo25Sp8icD1lLfQy/CHzeOZHX6Bk1eK/9hpvKKfnl2CFf/d8VvzQ589Y2ZgZytVdSLwokfJI7zusuozjO7LYyxeWjJiBy8qt296+ByMxVpIum50l2VjzLjlLxA3DHtQQs1NPxLlsktfrD9+v80eCuDZieuoPdC9Em5fmKSrHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KjKEMglN; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706037279; x=1737573279;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X81x54J3KgRrBOhq1QcTn+vWx44WOA6j4v24x7x59eU=;
  b=KjKEMglNW4rOoTkn43FG9OfyvpFNX6iZtR8CPLl7xW7c/VDJeAZp4xgG
   VRJXerKv9WalHtMt9NRjANEu3MKhhavpiHkEVVlQqQaCNCWxNiOkF9pGw
   ixv9UOJEeqkfFEsXOyFJrRJUUBVYjl56X0ckvmiSGMkvNJJrhpWUpb+50
   M46+U7e9GbvOmfm2zd2tk0FDSfafkSaJNwXdHQhnZuHzOvJPLplGTgi1u
   Mo1zwSY4tbnPoxWTjM/VzjKne6y0oSRIKLP2pZs3jtxv8r6IzWBXbcyqx
   pVAeFxORMTXZHTRDVbbU/ORiCYhnVcR+b018MCkSt56wyh9/BHGwVqKwJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15142428"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="15142428"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 11:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929428217"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="929428217"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 11:14:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 11:14:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 11:14:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 11:14:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8teBktxZGLiUNN0/CqpUuR+MU6ejXk/gL0K1CfGWI/PTO7IO1NjKMME4iilp+F8JQQ+KTV+FaHf5ssgW+aAHJfzGe42g92Zqe0sk4Hl5xSkssY3UuE7Cvs1Z823JoXvInuUPbRvr5ruT2HnfA7PbQ5UyiTlp7bVKXYoS57nGi20hZWuSzH1xAMwx8o6EF3q4twVm0OPQrmd4T3+QEtYEPs55BEo5xw1IaJysYJhr2HDwgGSy6T3p46O2+5KW+4PHSWBf161O0VjJRTYjRznSr+sjox5P+uPZGNhKz80aUM30tDOpbG+EeR+W2QGcIR8c0eMscV/Outl2eNizL1Xug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4JWzwJnTDzmIOq/dzI1jaz8dI1KOBbPxf118mEcSB8=;
 b=AGufYGz5S6AfHPNsCImwW8ZuhH8P5mwJZHIb3q//rKk8jKqS61bR3vLLD4sUfjvyZ+JbC8eDwkyI9+xEKa2HcO1/Z/f87gtB9RXP+skJmr955ho0ZsVAkhHw8pGxzkEsSOVm8VtsAbmxDezJBphxqEY18xIGEdZZFT/DnLpH1AG4BKfqZbQbYwmDwc54chpDvsDalrmMIxZXzLTMHIixWumRav/gOnukMW+tE3gBEpvEjZEg8PZsUGOCKGLDrsIfuXMml7PoC26j8tE4Dm3OqIRakZ5stODrMKyGv9hf918SUXbGJ18vhciMsX0Ui/+eTTiafUg/KRygR7cf+vBMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 19:14:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 19:14:28 +0000
Date: Tue, 23 Jan 2024 11:14:26 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, Qinkun Bao
	<qinkun@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Lu, Ken"
	<ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <65b010121635d_37ad294f3@dwillia2-xfh.jf.intel.com.notmuch>
References: <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
 <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
 <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
 <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14dffda2-f413-4304-9932-3ac8ddfb30e4@intel.com>
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 38671d10-3f8b-45ca-a763-08dc1c478543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc445KXphlMxjmu3Tb0mI45R2rnZd5F6ioXyLilBy5iQgp6eHe86/YljPP4xdFdJhcDUDT1x0nY2Vccjn/jV9OBsofkvREml0nYHLupWD47Ey651i+TXeMvYkakh9NQPxuhzR4R7G1dLWtQU8JtCPC+oKln/jWw4izwvUc8qHxDfH1W7L7w+RvQhtQ6804T9dUH5XeUe2bBRPfklKmoahCN//Dl6fIRBDw8iR2UuvOm4aIzT6Is3QKKX4PiAGC/iuUWHspCEXXuxtkNC7zLhOKQUhBRdHxsH/QRA0wsrt9Abf3iQ6U6cIinTozqWFtCBKJk0EiT2qpS6FH8etTkj6gCugW+vY7bYYAPaSn9cBAu6MyxU+vvzRZ/rR38LCnBQyc648g8bkXgBoDhmYPATRLZnqpUATh9fqZ8qQtsjRj8Hpjpv+UkmV/iZRcTReSkyoSHGAX4HeDtE9VwQW/9+FByzeog1jDmkDHbXTU/st4S/MpK0H8x8um529cTdvCmgCoMoT2g67zscHNzTnkWiPzlvGGxjPtC7Bc1uSz4Bc1VGDpRxW8Sm1gyGCdaCmMM/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(66946007)(5660300002)(6512007)(9686003)(26005)(38100700002)(4326008)(8676002)(110136005)(8936002)(6506007)(53546011)(478600001)(54906003)(66556008)(6486002)(2906002)(66476007)(6636002)(316002)(41300700001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nE5xIiW1lfwLYmGVBfpAJ6P8dLbRxeX059O6I+c6DVQSvoQXwtuPacpkL6CG?=
 =?us-ascii?Q?l3EC/jUkRm9Fgex2iu9tw7ysJmVuuZZfCdMqe6J3Uz06E/g5sLbRTYFBhSzW?=
 =?us-ascii?Q?2CWjhN4dbjiDuEvzrqix6OQvxu27oNpdvVHTRiakmQd+ihLJBAEoTp86rVVc?=
 =?us-ascii?Q?8B0BkZ2BtlvHNxOUQPlE4nXEzO9EYUPMqg0GrhRDqdUNpifeGb7mQbT+939X?=
 =?us-ascii?Q?KKRZAxTvIbaA0iriqEexM7TtNaBTM0WIcVyXyBTiYmKuDoZkjRtNB3ANAPR1?=
 =?us-ascii?Q?S44EsoaNy+YYasGAqyn8HL33HTnEd0EbdpGBK9cHkguwWRq9ITJHquUyVHQ5?=
 =?us-ascii?Q?L8E/AWQ3Ye0Ukn53AVqNno0cjxRpVTkCKqJGjiBB2Icdnky/zTUIe+kgnzv2?=
 =?us-ascii?Q?tW8X+0RBmxy53qEUq/0IkDva6Xl7AUPgouw3gUe5sIY751QChQPuWyQUIDRV?=
 =?us-ascii?Q?HDoXfrMAVeAcQV8IUUOIw5h7QjGJI/zTvmZzfqNjN3puszeqzxVEq4RcSm+W?=
 =?us-ascii?Q?Cm9klBGV9SAFWjv8yhRrpoRjSAY6AJcXaw/XcWPS6Hu+RWujSftoxOEn4L7y?=
 =?us-ascii?Q?6IRfvftOTOzlKqX6D2ihpS5YHO6TE5wCF3599NfWIGR6V+BMgRik5/2y8XC2?=
 =?us-ascii?Q?k3f54951xAI4OZt7t8h967UJky2uJtxFXnIWU/EdZxaQ9aCa4f29hBdgr+Qg?=
 =?us-ascii?Q?F9lOdvk93XmDofnFFMOL/EDvFsNVjPo5xocYdzu/WvKqd90LEVgjUVVi0PTq?=
 =?us-ascii?Q?I7+0ZfLkhhBs7f9qCQUfGNp/lVrxB57H0tCzFNYefxc7Al9JY8UGqv8R2CZO?=
 =?us-ascii?Q?MkT+TsbXk4Jv/0ih0bdIbm5xYFospqAMAIlma5RpSir203hSEMJIkTuGwwk2?=
 =?us-ascii?Q?MMJeGSS6DRnwhou9sm3AbgCA+UPTZ6gj3F6lBuy4oPOUwEv/jZbOf0c+Gq27?=
 =?us-ascii?Q?fGu6QRDrM2dYsPWH4J11Fpd4WLxyYu5vESljfDgvnnBkZqTgeVF+rGyipNpZ?=
 =?us-ascii?Q?SRZGxxGiv7YnbYRloGIVtDi9MGGGZJzfQegDjrUTemowViz2A17LafkOCp77?=
 =?us-ascii?Q?FclG5D/krzSag4yhF6Sktjtb0zAVxsjCyHVGHXCfVdKkg35cyMWjy4Gw3Sn0?=
 =?us-ascii?Q?qbRJFtp94aVTel5/ZuOQpocRzDm/FS89GfI1Ov4uO4rwutRk50Ske7dK+iYU?=
 =?us-ascii?Q?EROEpimjwIumtfaVd6ufuwVGl6ELxxDaAuig8Kyq2wVVRSSLJlscfMPSI8ZS?=
 =?us-ascii?Q?Iw9X1afLYAjXmjVqmGtYQBtO5+Y3/A1u92vY+yHAdtGewDWA+L5M/RTyGoG5?=
 =?us-ascii?Q?gs3cRPS3qlnZ0aXYP2LizVyCvtW9/Hlff3PgZQuX/69sdVEWQIBTCHjuQtYO?=
 =?us-ascii?Q?PENkS3109WSRbvoTdBlA+g2Us81EUibjgrc5CrZg1hV3SgI2ZoeW92WL6vKT?=
 =?us-ascii?Q?SMAnuLzvHkDLPlXGBVKxuYr1bq33BQffonJgquqf2NChEzXXpGy64sEJNQxT?=
 =?us-ascii?Q?a9lvGRz2rSu4XRmCH5UzvOukKvTY4/SZNzNOXzNpDbGQZ59vOZHQxHDMNcbM?=
 =?us-ascii?Q?DvZG/WI8Ywm4UKFmi75AmKWX9hCI55yyHX7RBISGNJTN9kfTm7QUuxaMsRAi?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38671d10-3f8b-45ca-a763-08dc1c478543
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:14:28.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8m7k+neYmWh4M9d7YTDatSvUy7yVh1mOETtKo8UN5llE5nWoyhwiOrFZCyYniAUvZ605qTZcEYNs3eUlT+fuVSwYga+2bHFXUCAebot6Or0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com

Xing, Cedric wrote:
> On 1/22/2024 2:32 PM, Dan Williams wrote:
> > Xing, Cedric wrote:
> > [..]
> >>> So, yes, the mapping should be allowed to specified by the low-level
> >>> driver, but at the same time every vendor should not reinvent their own
> >>> enumeration method when we have EFI for that.
> >>
> >> Given PCR->RTMR mapping is static, I just wonder why it needs to be kept
> >> in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that
> >> TDX quotes are never TPM quotes, applications used to extend PCRs would
> >> have to be changed/recompiled. Then wouldn't it suffice to define the
> >> mappings as macros in an architecture specific header file?
> > 
> > I think something is wrong if applications are exposed to the PCR->RTMR
> > mapping thrash. I would hope / expect that detail is hidden behind a TPM
> > proxy layer sitting in front of this mapping on behalf of TPM-client
> > applications.
> 
> Hi Dan,
> 
> My apology for the confusion! I think we are talking about 2 different 
> scenarios - (1) this patch alone; and (2) this patch + vTPM.
> 
> Scenario 1: This patch provides RTMR access only. My assumption is, 
> there are existing application (and/or kernel modules) that extend to 
> PCRs today and would like to work in TDs where only RTMRs are available. 
> Changes are of course necessary in those applications as TPMs/PCRs are 
> no longer available, but from security perspective they would like to 
> keep the same activity log and just change to use RTMRs (in lieu of 
> PCRs) as the secure storage. Hence a PCR->RTMR mapping is necessary and 
> must be agreed upon by all those applications and relying parties. IIUC, 
> this is the intention of having PCR->RTMR mapping config maintained by 
> the kernel, as proposed by Sam O. originally.
> 
> Scenario 2: A vTPM is implemented on top of this patch, in which case 
> the existing applications don't have to change as they can continue 
> extending to the same PCRs, which will then be emulated by the 
> underlying vTPM implementation. PCR->RTMR mapping in this scenario is 
> obviously internal to the vTPM and I agree with you completely that it 
> should be hidden inside the vTPM.
> 
> My comment in my previous email was regarding Scenario 1. I hope the 
> clarification above helps.

Got it, yes, makes sense.

I think the only use cases in scenario 1 are either kernel internal or
the backend of the vTPM implementation.

Even though RTMR is cross-platform it is not universal, so vTPM remains
the universal solution for most applications.

