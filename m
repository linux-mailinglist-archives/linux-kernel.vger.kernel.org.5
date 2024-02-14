Return-Path: <linux-kernel+bounces-64808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5F685430F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B411F250F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E30111CB6;
	Wed, 14 Feb 2024 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEYziLXC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46391170F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893336; cv=fail; b=f/NoxvuUMZ/cyX1TxTyUKm9s7PM0/Rge02Bz8fxZ7yX6wP1Sr+/RH+NzGX/b4u/U2NdHnl++lKO62J5il17pDEaJZGEcxhW86sBQe3nafWUpa6G1vxU9jzOat4d7icFrXsjL8BeKIdxkA3AY80hYKE56HS40/xUOnbCd8fsOq4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893336; c=relaxed/simple;
	bh=gj1OsezbVdUp465XskWF6w3o+vOwIRT6zex3dnHMMpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WWjfJrE6lmYCBuoDjWAep2H+V8Ck30rUIycuBLVNVMVdU+6NQvrPKOaZZyDYcDKXkHMspuKmxgSYjxsfDIcO+MW4h+vAiRiCdS0E9MQBWF1zPVyL5IodwGR6HPUpfO3rNVuVo7mnVFyYGxg4Wco9VxpUkMljTgB/EoyOqYJ2070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEYziLXC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707893335; x=1739429335;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gj1OsezbVdUp465XskWF6w3o+vOwIRT6zex3dnHMMpo=;
  b=UEYziLXCpi8pyx6msdcN/N3DNvxwL1jCTkKeczEnM+nE6rE2Zv644ZAW
   KW7FiuIwgg4QKD5tGFh96PAUSbWrnJyfe6bMhTSDXYgdGl6mbQecY5/4r
   lRENnig/g/seJvsZh/AWJXj1RZs0mop93YXHdnxbxkaQbSABq57k2puII
   KICxNV67lH74EwsaOYIOf1hPDI5qgNWulQ09Jzl6aVHGazddo1L0qsehh
   yrnBbrzoFdLOvrwUfyb7VPkzHP2pg7yCjotu+JevKXjdHrPivGtXTBOTD
   jnnB7ftn2fgvPKrN0lwbgYZDNqbVi7Cs3aQsO4J8YeBcUhVHUI63TM1os
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5747682"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5747682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 22:48:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="7758326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 22:48:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:48:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 22:48:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 22:48:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 22:48:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YABKSFHV2MIa/qyNHBnIlSAUo+J9BIfrlgRXksetxIFHzvGwU6EqIVag85WrFgmKI+kDB/iOVpxiIadfNzNZJ5TCvc7XoGBbI3uvWHWsIt9bLkvjLbuuNYt0XXXaoL5vBC9OIz9fBMFdT/oPJERb/dbOtmbeyn0ZEpf0+CDMKj+R/EV4kpXsy+cgvcT98NHQKiyQgYcc7EOoa1x0RhBKHpd32K1jympvPzAzMcQENeWS3nHwTVkQNslv25ICm45vr7JOwMmXG1tgXstVYyTJGZ4PVu86CcGSqhsM8+tnDACZHajNcvjGpep6wRr6L4a88PZQlXEbQG0ZMCrLAC65oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EcdzdEbquwRRTUB+Y25+8lKwrbS7Cu0OXADu3QuzWw=;
 b=G79kz1Z5RVOBCN57q0Z88Xpk7L+Tzl4GO4E+DaBs0zoOG6k9Ic3bLW6IfvKewUdCgs7r9tN/9Rud9c0T2y6ZM+YrKtntrf1kkOMxEMuTTw1820FhTg2lqbfd0cZ4KtBaEJIg+9bB3RleYYLUdKX+Nl1mheYnsWYQi+Fi8phQCLM+y79EaEXy12qpXVQkuzcxyNCOvf7D0VDm4z6N0c8xSIJMsrjsZt/WEkTdgU4zCpqm9+ZnuJc4qnbxPx6ZJwxDwRz1eFZtF/gzYXyzM/t24MzARHSza+3QYkUY8hnAZbsZ67APjKBSRbrN3MMjWTw3Z+o89b2kUmZod0G6icJ3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 06:48:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 06:48:51 +0000
Date: Tue, 13 Feb 2024 22:48:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Theodore Ts'o <tytso@mit.edu>, Dan Williams <dan.j.williams@intel.com>
CC: "Reshetova, Elena" <elena.reshetova@intel.com>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, "Sean Christopherson" <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <65cc625028bfc_5c7629490@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
 <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240213231341.GB394352@mit.edu>
 <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240214043245.GC394352@mit.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214043245.GC394352@mit.edu>
X-ClientProxiedBy: MW4PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:303:dd::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 82661994-c511-48c6-655c-08dc2d2900dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bS09OvFvlurhJ9fp/Heg3Uw4skh7LnkuUqOXQo6lZzFz8fTHOfGH/G/Jzz9j1iVCMIKfhZ+yAJCFmYlxmfdZ6AJs9Yi/d6UaCpHriy7k0jb9EO9o4zldAf0iWV+BYffpcQQuBy3H1IyzkObPtUdO2abT0Xyj9ridiYobwL+vMWkgmS1XtmReC7iU7kz4Yv5Zefgu+42hMLUOqeOsoquPZ2yUi1gqlRp/F6gtSL4VvXbGRNrm/iWxzClCBkxuwgnHav85QktR1zuRLn9KA+z0LyLhJNkDeobSSOb9+BeAtwYSM+uuI7ZbuNxLG3bRHK9ZIDe4NUAXLJ7E0X7fTSVVWFB+mIZKT/uhkGy4gi5YD2TnGqwF8Nn25d/9R9Y+DIT2vLrW+VB4SptBECSGOuyTqhbD6NS4lmF90ffsKv6FPrT1C4RvXecstD/69536OsbzGXu6iOyK28BAfgNw4SLf+TxkYb6r2sPK+TBgc+GcGYEtJnvRRhGCI2vKrddexCOM1zNZBPWyeMAjU/dkhiz449bMj1ha8MRFKcUp/zAc4DUA2xUlSnWPmVMblj02PTgw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(6666004)(110136005)(54906003)(6506007)(6512007)(8936002)(6486002)(8676002)(66476007)(66946007)(66556008)(4326008)(9686003)(82960400001)(38100700002)(41300700001)(86362001)(26005)(478600001)(83380400001)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DkIYrQ+C2cOPVwg2sqHipfnRlIGRjubGeKsT7vQWq85xBfYBGHNH/X7t8+91?=
 =?us-ascii?Q?iLQqjRgG5fH5o+Xf2Gv2zCpzglDZbJ+1n7sEF9YV9kRedth9L3Sas5gulK1o?=
 =?us-ascii?Q?Q+v08wMlpZohWTCYCoVd2eF+rCD+LAlS12DnBZu4p9Sz3gr0ZyxWBOq9WrBk?=
 =?us-ascii?Q?+hMO8bgQhcqOxM+uUgj4J8DadvyANqEX/ITsDLx51cKTn/kVmV68POpOlUT+?=
 =?us-ascii?Q?oxXSRf3i7qVnu3lwsSFccwaRis1Z5SIHa7dGrz1UwmB2v8LaHOKYINxslGET?=
 =?us-ascii?Q?hCp+BuxEXEeYAF5Gi87DcmdMV1dHWn82p6NKHfhR+mcnmfQzRF+adVwjI/XQ?=
 =?us-ascii?Q?YEzsgnasefNpFbSfRARu58s2iyGOSz2h1CEY6SCukyBiky6ymcIeTwF+Edbc?=
 =?us-ascii?Q?mn5j7ntCmy7Q96RvSNgOhqVJOmIZdeGY0J2lVH5hG0C+ea0jeg96PiCujMFB?=
 =?us-ascii?Q?jf5ZqoRGHpjkiqD5gPqg0zLPowatqnshpj9X/8hHnrAez8H8dMmkY7bfTi6v?=
 =?us-ascii?Q?5NtlDs13Z4FRoBmzbUqSxY/T+6RgDDmONDDcVGMsT7eZbjGQGXo+RR4QkRm8?=
 =?us-ascii?Q?XMEf0wZpiuWkMD9opYNqeEynFjwSivay04KsNxWiZ2FNACck7qZS2cz2Fv0M?=
 =?us-ascii?Q?p18OyG9j3Ha048avwr8xED2kU96HcR2dvpdbbXXqvnaWoPYvswNHNoJuM7jh?=
 =?us-ascii?Q?cMnoku5iibHZ4DYKaPcLHR3/W3f9/GS2vdOEggCU5Y/iZppAV+/Srf9R8Z4T?=
 =?us-ascii?Q?bZ0+0dBLQGBRnjgcnh/Rts6zWu5xbe9S/WycYZXfrjykiPzn1CTl3gJNsM1Z?=
 =?us-ascii?Q?U5RRerSCrEpil8POYsVndTQtN/o7HsdMWp606zXLlNVsnRMOeg+o/PUhAzMw?=
 =?us-ascii?Q?5XElY2Ms3CbeYfxXjWDQWUbpuYXTlZz2gbT9tvrTgyN8toduSdd7hmTb+0Yl?=
 =?us-ascii?Q?/IL3Vmkr8nS2RnF/sNTnQpuaAiH3lR4fHqh/YG1dCFGBLSv9S2cLPMJ4Bwl3?=
 =?us-ascii?Q?jcxQhEL8AAvyaRQem19w150QWzXh8h7snUzZAPBh4zUIlfTrtDizWcsrHTsL?=
 =?us-ascii?Q?xzUJYESVIKExO1jXEZXVBbJ6puRaKePtjyeZR7jbTdhwh2+tzmRkmSDrIOsM?=
 =?us-ascii?Q?vGC0ANke8uWawG9EuGOUgfm/j/iU0B1WR8lg3GQxhg0bFVL5DLeDcHGjEJaT?=
 =?us-ascii?Q?RY6xR2qDboKFl7BAEb1xTCQfp8RWzuDn0Env1TX8pv6PFxiQIf07FwKuL60c?=
 =?us-ascii?Q?26Wf3YUyVhtV65pNQOMKSrNrVBuCrr7n193vSwq7s4aHN06hDcX1ucw9MrUQ?=
 =?us-ascii?Q?CjcBfLYJZRnL6OS3ZKSkCnK5Tyd/5D4hM29wUEx/owDbsuumeDX79CyPKngi?=
 =?us-ascii?Q?KPqnBoGJGovqN1ruk9JbiPlPPvLoshfJebOi6qIzfHeG/AHm1+tIxfOLfd7G?=
 =?us-ascii?Q?amtkjP6yC9ED48q4Sjd0Di/H1MVGIVI7frEm0tmz5Rv1anSI0QVlpTljPwVs?=
 =?us-ascii?Q?ybfQnxat5Fz/CYDxj1K1Tax/lD2fSc7hZkvecMysqyyMMclmHzuSvsUaWgbR?=
 =?us-ascii?Q?5nVCXJPgb2dzgbPfEFlr49Gh16JJ4THBkM6NzPeZxZkoSjbMnl92rGuWvoRE?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82661994-c511-48c6-655c-08dc2d2900dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 06:48:51.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8djypRIf7NBFZUjjgYkCDkxC4uQki+awcnT7hsxxJQRUGhb/dI4a2Nc0xcQwzSCOFzfH5WSB7UwFCxs3z5ULe7NmsGy5T8jP3Ynf5pkhn4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com

Theodore Ts'o wrote:
> On Tue, Feb 13, 2024 at 04:53:06PM -0800, Dan Williams wrote:
> > 
> > Indeed it is. Typically when you have x86, riscv, arm, and s390 folks
> > all show up at a Linux Plumbers session [1] to talk about their approach
> > to handling a new platform paradigm, that is a decent indication that
> > the technology is more real than not. Point taken that it is not here
> > today, but it is also not multiple hardware generations away as the
> > Plumbers participation indicated.
> 
> My big concerns with TDISP which make me believe it may not be a
> silver bullet is that (a) it's hyper-complex (although to be fair
> Confidential Compute isn't exactly simple, and (b) it's one thing to
> digitally sign software so you know that it comes from a trusted
> source; but it's a **lot** harder to prove that hardware hasn't been
> tampered with --- a digital siganture can't tell you much about
> whether or not the hardware is in an as-built state coming from the
> factory --- this requires things like wrapping the device with
> resistive wire in multiple directions with a whetstone bridge to
> detect if the wire has gotten cut or shorted, then dunking the whole
> thing in epoxy, so that any attempt to tamper with the hardware will
> result it self-destructing (via a thermite charge or equivalent :-)
> 
> Remember, the whole conceit of Confidential Compute is that you don't
> trust the cloud provider --- but if that entity controls the PCI cards
> installed in their servers, and and that entity has the ability to
> *modify* the PCI cards in the server, all of the digital signatures
> and fancy-schmancy TDISP complexity isn't necessarily going to save
> you.
>
> The final concern is that it may take quite a while before these
> devices become real, and then for cloud providers like Amazon, Azure,
> to actually deploy them.  And in the meantime, Confidential Compute
> VM's are already something which are available for customers to
> purchase *today*.  So we need some kind of solution right now, and
> preferably, something which is simple enough that it is likely to be
> back-portable to RHEL.
> 
> (And I fear that even if TDISP hardware existed today, it is so
> complicated that it may be a heavy lift to get it backported into
> enterprise distro kernels.)

No lies detected.

Something is broken if you need to rely on TDISP to get a reliable
random number in a guest. All it can enforce is that the VMM is not
emulating a HWRNG. Also, VMM denial of service is outside of the TDISP
threat model, so if VMM can steal all the entropy, or DoS RDSEED, you
are back at square one. The only reason for jumping in on this tangent
was to counterpoint the implication that the RNG core must always hard
code a dependency on CPU HWRNG for confidential computing.

However, yes, given the timelines for TDISP Linux could hard code that
choice in the near term for expediency and leave it to the TDISP folks
to unwind it later.

> Ultimately, if CPU's can actually have an architectgural RNG ala
> RDRAND/RDSEED that actually can do the right thing in the face of
> entropy draining attacks, that seems to be a **much** simpler
> solution.  And even if it requires waiting for the next generation of
> CPU's, this might be faster than waiting for the TDISP ecosystem
> mature.

Yes, please. I am happy if TDISP flies below the hype cycle so that its
implications can be considered carefullly. At the same time I will keep
an eye out for discussions like this where guest attestation of hardware
provenance is raised.

