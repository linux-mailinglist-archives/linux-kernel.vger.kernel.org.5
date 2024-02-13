Return-Path: <linux-kernel+bounces-62888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67C852784
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4AE1F23721
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49023A0;
	Tue, 13 Feb 2024 02:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TV3Cx+Sn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652C80B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707791664; cv=fail; b=pOyzXYAfxR+ascNseWcokXWtZ19DiSzademfggsUGY953Uhf+ynHxDtk0r4Phk28l5DPVbViKxqKVUNBb5/VXgeGmhAXtrKtewIb3QBYX74eDWQaTjwrbdhCLuBN2MQ+nk07OTPT2cjDQBTW9GBSY3u025WY9mgyfw6kUCotEes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707791664; c=relaxed/simple;
	bh=toeBc0PkgPqL4so9DbuJRkcc1TQL/Um4MRfr6onKAtA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0HK4sPpnr4DEoc0wojR/7Jf5lR/E0IgM/GSDO1Sbxg9woknVzR7a3znN8WpQGcoqBZi9yttxOPUreQ2jv4lCuS1xPt4oCv6uAZyUiL52OX3RkRwQA3LOigIZiJZX6uc2R1bcQ4sHtUGuN7qeBNQYmQZ5dEvS5xLmmcYmLRu7AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TV3Cx+Sn; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707791662; x=1739327662;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=toeBc0PkgPqL4so9DbuJRkcc1TQL/Um4MRfr6onKAtA=;
  b=TV3Cx+SnLDCucHRlPzjV3muraeHoKkjEUGwrqy/5/IwIff5D0+kMpGdE
   7Mppv+6TyhKsphU9tkSKYyQDetJUAn/RFtj5DPrMITuYTyAJE9bClC9uw
   qii5AQ6Y/ECJb3lU3tvcbO06vqdcxjy47xO5a3WokLgHNZEb6qB6j2xJJ
   TuUBmio4m04VX0WiOYZea7la0gZTwur4RyuDq82nyfb8bfIWpoZsA0VD2
   9dooktLZbVVtfnCkT81k5GCz+kTfbHfW0LLIY5Ieh63QCEFGVPZWMgbjk
   1RmVHp3Dx4ux1MondNhbpl6ui9/uV4ZrRQzeLqtufrOVq8+K7KVJHeNam
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5570133"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="5570133"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 18:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2713435"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 18:34:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 18:34:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 18:34:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 18:34:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 18:34:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPYkZ1YhSb65OK+nW0Z+vUZL1hKmgfetpxVymTek/8a32BoWRd7flh5tqdljWX1/CnzPBywTVWu3hwCc7rh+6q3PjcXj/QV6a3JCEQgMDq2Cxae2Zbdq2OOYDTUeh/tPvH40potrjD3IOdYJYArN2/YOm2FwB67QinA/2BwGaymG84tjpcl96LnRKWDYDTkmJP2B1xwDZxAF5ZDuBKFva6jzdqanRSaSeaWjvI94eAJXvD3IU0mW/0MJuhfzxmO6wkFTqsiG1GkZtq8OoVX6z07iCAJN1vAP7Q7QVGP14ln+J3ao9ADAkifGKI6IHiJEIRhkx1FpbmBdJjCOt56Vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76zIncHMXs03e7+17z7NqP/ioaT2X8b4pfrI0BVBKPE=;
 b=Ulij7VuCo2AIn3rJlgt/wMcK9/tQFYp69mVw9eLz7MtgVKkVr5MRFCqPwFTv8JL12UtN2SgVYblZ6AO8SNmCW7IisvRzETuGmmTsItgdjNZW3wAWC1WHzu7cLarBy8mBsE5oMNhl7PS7h8FgXumMSnSc9f0mhNqUpZwPGtK7XVoJksOZoqvaDxJofK+MMX9n20bNyzevjsaXXVcwPOsWfQOMpGyqyHtIOt5P2Y8GV9bYgZVeBN/Z/NnfWAl1eleQvhByJPR3xrFb1fN+aJ2XTJ4xhtvmCBnAGlXMbnshZCLix0fhsCKptScGdGB+r8KP2qBys19QZ1ObZ8yWOWpeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6558.namprd11.prod.outlook.com (2603:10b6:806:26e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 13 Feb
 2024 02:34:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 02:34:17 +0000
Date: Mon, 12 Feb 2024 18:34:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 10/11] x86/sev: Extend the config-fs attestation support
 for an SVSM
Message-ID: <65cad52616ffa_29b129412@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
 <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
 <65bc95732df26_65b2629448@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afabdd17-7f1e-4d8c-a7c2-dbbbb230fccf@amd.com>
X-ClientProxiedBy: MW2PR2101CA0028.namprd21.prod.outlook.com
 (2603:10b6:302:1::41) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e392a68-d042-4758-3392-08dc2c3c4617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/QEoQPlzn+ZEmjg2h+uNoKKGrVwdgNE3VJY73DI5pBelMQUAHZ+CfdK981e/QFI7EnSbNcbjzY8Pbo/IhQegrstdDhzkL+Yvz9XnrQBR4U32CRo8GE7odXg0grRjd6Gmqh4hhH6LQmY8zW8Hs5YAPrlBKRT9C38L/qT/Btfegc12PKgnOyBO2FPChwZVrSou8WreWPzZbcYECtPZMp/ublr+vOeMbyezD3bnM0hCVMh34NJDcD7hneOh7TX4jN0ODxJCFgSNpt0RQuRUix20cI4jfC6oteQKd8aOPnNUL9Qym63evUpiik8VzbyXDOum7r6H/YFruo8oPTqSartumrxejrZudbWdyqnlfZgpSAnN1FUY6YRmgKge0Ilp/jyBLjt6XqWagmO0sRHgEz+pbSoC/3h1FWwytoQbXWzmDYw+bdhPJMyH2asc0TUq+1gZ247yyHZURMzgPWGEOjwQXGEJzOOC/aCFiYbd7sj0PwbzMvcFvnYXo2tMIYXSnBJzw28+HJ0EWl+u9/hOe67MEtpoD1rSp2hyY2lajBDKi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(86362001)(83380400001)(41300700001)(966005)(6486002)(4326008)(53546011)(9686003)(8936002)(478600001)(6512007)(38100700002)(6506007)(66946007)(110136005)(8676002)(66556008)(26005)(54906003)(66476007)(316002)(82960400001)(7416002)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GBnt9pbBdp/w6JEIFHNO3elPPOKXi307U0POi72kXoQ+ArMnn8H0qdBgj+WD?=
 =?us-ascii?Q?6HLF2HoOcpOr3NNz8ei6O9Hf5VPkAcoMnBb4OjRo0pCIoJrpi1VzEiNmqSor?=
 =?us-ascii?Q?OXUSiJmXyZ/HuMpZKPmD/2Ycbcz/tubQI18atazh6i41RGFhWso4kDviZ6ho?=
 =?us-ascii?Q?cdU//5XClRxx4Fl7Zl2gyza1tqEZfzkdkU7IYH5jt2D98jS4gyp8JFAe4/Rx?=
 =?us-ascii?Q?xeDJO9W1m1iqbiaum08n55CFf7RCA6Z9k3U2Itvsw5D+Ew8KxtgNSs6nt98S?=
 =?us-ascii?Q?BmrrYQbM7Zd5HBChFaJZO6IoHNTMiq71FiHHhqQuHAA09Gy7xgVp9lxtJqO4?=
 =?us-ascii?Q?KFbc/0Ws62Pm2BCibUKg4QItvUJuLKrjKA65LkgBISyi0qXEeWFVNiPCnbhQ?=
 =?us-ascii?Q?ud5Z8xtUhIGapjfF2DEBAdC3kIMrDALosQBiZyl4paY1tay21rMoq8HR8WOm?=
 =?us-ascii?Q?R3SzQqbDPzbsf/tXOnEkNzTemXwXJJkUEpcm9WECdzUAGb4xQtJAa58aC8gb?=
 =?us-ascii?Q?mmMcOElhQZciZTV8Q+NQjIwC3PHLtxNH2yoIzPjlSgnMdUYbq/0r4cnb6eAw?=
 =?us-ascii?Q?u7R1FQAYlkIqvr9C03CYoeQtzaHX3mKMaN5WEvQcm61MYq98MLFhyEjJ5Hr8?=
 =?us-ascii?Q?fQtm74aExUB0CrgKOD7fDhCTOyAuW9QSvPTbYJawOuSLlIlwxfCwhkuMcjnP?=
 =?us-ascii?Q?ExPY1ZsNUC2tHdsfPQZ2fysdXOdghJLsFqmnI9I+rGoYbZ6NJJ7ywL5lEXY+?=
 =?us-ascii?Q?GlmEyueUveJ9HcBrzEnIVVqES/CmK81xKa0tP9e90N5PFfEMD+c+fiZBc0a6?=
 =?us-ascii?Q?gedI6SAUOdBSDoMs7UOAjd85fhyrwXini4Ccgs3Ksg4IBiEA5pKUgjozwxpi?=
 =?us-ascii?Q?OTZOgnVXvW7loiY1cR0fJigZE16my+zOH/wTIG+d8DPVnkubUuex8ZM3dtxU?=
 =?us-ascii?Q?b5KSZ2aRp/xDZxNKbs7ucxJfVZnMyrxfn4RjQLVeEqY51bhHmpRmAOoAt+Ug?=
 =?us-ascii?Q?BWxvu0AItXE9HoXDsEphmdk+/bhiQbnds7ilKGVgCRI/u3QTo/gYLUCIHYVP?=
 =?us-ascii?Q?xVbXAWZqPN30Eig9rkp40OiBhNae50Q6DemNGarnwVsUKxkStkQMZT9g3I1r?=
 =?us-ascii?Q?VvrqVNbOpoKPE1SjP/rN6OL6E6YMkSf5gqvS9UJ5H9VzFmEv3rn5YkN8ydoa?=
 =?us-ascii?Q?QGzwWqvU0SFVmc0ejp+IdVrFkJUcOjl9YX8ctFu+4Q8Gv+3gezBY7Uq7yBin?=
 =?us-ascii?Q?HsK1IlVqpvCHZzvFPI4Sm3wl/jONWYYrzKqlCfjGiva9LbYcO5yf+XGfM2qW?=
 =?us-ascii?Q?sYCYjGwO4PePg7GcnxPa2G6vIGje56lPVGd3QaNQz7Gg8NxMpp8ryMh7pkd5?=
 =?us-ascii?Q?qi8sTw/GW2rchu1yAPV3Yy7o3DoxRHzNUmEzwQMKPzPgNOsUudidLU8aF5r/?=
 =?us-ascii?Q?PxRMfR+E2ulWYfHdQpC3ejdsJPd/tVPD1SwSwBAJep0pFtc7T1P++zzIeCwl?=
 =?us-ascii?Q?RoNpvnEWz+yQGDJHA0yjAlc0QXzsmbqLQnIn3se7DVWgfuE5ShNQg6aVgeFc?=
 =?us-ascii?Q?h+QfLY5BQOF8psuN4oxqccUdF2IvjvRtKCgdpmKeUOk3slg3wyGI+VuDNjGd?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e392a68-d042-4758-3392-08dc2c3c4617
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 02:34:16.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVxJ6H8ru+qiZqUXPxtdDvpDfQ85zD+1VEHii60R3Vc9V7nwt4LhgtAW0Qv+KgU8pVs8Z36L1GydIQUF1fXFppUHWTZWAtNN1OLQIlNv1RQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6558
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> On 2/2/24 01:10, Dan Williams wrote:
> > Tom Lendacky wrote:
> >> When an SVSM is present, the guest can also request attestation reports
> >> from the SVSM. These SVSM attestation reports can be used to attest the
> >> SVSM and any services running within the SVSM.
> >>
> >> Extend the config-fs attestation support to allow for an SVSM attestation
> >> report. This involves creating four (4) new config-fs attributes:
> >>
> >>    - 'svsm' (input)
> >>      This attribute is used to determine whether the attestation request
> >>      should be sent to the SVSM or to the SEV firmware.
> >>
> >>    - 'service_guid' (input)
> >>      Used for requesting the attestation of a single service within the
> >>      SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
> >>      be used to request the attestation report. A non-null GUID implies
> >>      that the SVSM_ATTEST_SINGLE_SERVICE call should be used.
> >>
> >>    - 'service_version' (input)
> >>      Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
> >>      represents a specific service manifest version be used for the
> >>      attestation report.
> >>
> >>    - 'manifestblob' (output)
> >>      Used to return the service manifest associated with the attestation
> >>      report.
> >>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> >> ---
> >>   Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
> >>   arch/x86/include/asm/sev.h              |  31 +++++-
> >>   arch/x86/kernel/sev.c                   |  50 +++++++++
> >>   drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
> >>   drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
> >>   include/linux/tsm.h                     |  11 ++
> >>   6 files changed, 376 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> >> index dd24202b5ba5..c5423987d323 100644
> >> --- a/Documentation/ABI/testing/configfs-tsm
> >> +++ b/Documentation/ABI/testing/configfs-tsm
> >> @@ -31,6 +31,21 @@ Description:
> >>   		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
> >>   		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
> >>   
> >> +What:		/sys/kernel/config/tsm/report/$name/manifestblob
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.9
> >> +Contact:	linux-coco@lists.linux.dev
> >> +Description:
> >> +		(RO) Optional supplemental data that a TSM may emit, visibility
> >> +		of this attribute depends on TSM, and may be empty if no
> >> +		manifest data is available.
> >> +
> >> +		When @provider is "sev_guest" and the "svsm" attribute is set
> >> +		this file contains the service manifest used for the SVSM
> >> +		attestation report from Secure VM Service Module for SEV-SNP
> >> +		Guests v1.00 Section 7.
> >> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> > 
> > I wish configfs had better dynamic visibility so that this could be
> > hidden when not active... oh well.
> 
> So do I. I played with the idea of having two different structs and 
> registering one or the other based on whether an SVSM was present. Thoughts?

That's the status quo for the differences between TDX vs SEV
(tsm_report_default_type vs tsm_report_extra_type). I think a
"tsm_report_service_type " can be a new superset of
tsm_report_extra_type. That that just starts to get messy if
implementations start to pick and choose on a finer granularity what
they support. For example, what if TDX supports these new service
attributes, but not privlevel.

It seems straightforward to add an is_visible() callback to
'struct configfs_item_operations'. Then a common superset of all the
attributes could be specified, but with an is_visible() implementation
that consults with data registered with tsm_register() rather than the
@type argument directly.

[..]
> >> +What:		/sys/kernel/config/tsm/report/$name/svsm
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.9
> >> +Contact:	linux-coco@lists.linux.dev
> >> +Description:
> >> +		(WO) Attribute is visible if a TSM implementation provider
> >> +		supports the concept of attestation reports for TVMs running
> >> +		under an SVSM, like SEV-SNP. Specifying any non-zero value
> > 
> > Just use kstrtobool just to have a bit more form to it, and who knows
> > maybe keeping some non-zero numbers reserved turns out useful someday.
> > 
> > ...or see below, maybe this shouldn't be an "svsm" flag.
> > 
> >> +		implies that the attestation report should come from the SVSM.
> >> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
> >> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> > 
> > So this affects the output format of outblob? I think @outblob should
> > probably document the fact that it depends on @provider, @privlevel, and
> > now @svsm. Probably all of the format links should live under @outblob
> > not @provider.
> 
> It doesn't change the output format, it is still a standard SNP 
> attestation report. What changes is that a SHA-512 hash of the nonce and 
> the manifest are taken and passed as report data as opposed to just the 
> nonce value.

If it is the same format, and the input is user controlled then I am
confused what the new ABI is selecting? Could it not be inferred by
privlevel?

[..]
> >> +
> >> +What:		/sys/kernel/config/tsm/report/$name/service_version
> >> +Date:		January, 2024
> >> +KernelVersion:	v6.9
> >> +Contact:	linux-coco@lists.linux.dev
> >> +Description:
> >> +		(WO) Attribute is visible if a TSM implementation provider
> >> +		supports the concept of attestation reports for TVMs running
> >> +		under an SVSM, like SEV-SNP. Indicates the service manifest
> >> +		version requested for the attestation report.
> >> +		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
> >> +		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> > 
> > Perhaps document that version 1 is assumed and is always compatible?
> 
> Can do.
> 
> > 
> > What prompts new versions and how does that discovered by guest software?
> 
> New versions will depend on the service that is running. Changes or 
> updates to that service would document the new versions manifest output.
> There isn't currently a discoverable way other than calling with the 
> requested version and seeing if an error is returned.
> 
> A possible extension to the SVSM attestation protocol could create a 
> version query call.

Can the version be made to not matter, or be inferred by the presence of
a new enumerated service capability? For example, make the same compat
guarantees that ACPI methods do between versions where extensions are
optional and software can always use v1 without breaking? Otherwise, I
am not grokking what software should do with this version. 

Separately, is this a version for the service protocol or a version of
the manifest format? The description makes it sound like the latter, but
the "service_version" name makes it sound like the former.

