Return-Path: <linux-kernel+bounces-32152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF60835751
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C62B21771
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02F38392;
	Sun, 21 Jan 2024 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4R1eft+"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C7C38385
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705864518; cv=fail; b=jKnsaawc61R/4a63w99pwRNbzT2J3Fn/Iz1fUmdsQs4nKP1PfRBXuT+sv3ffboBr00L4sixujpSH+Cs5T3E0jAmkwTA1R03XwmvBoGqe4cxCv1AfrDVjP+TQhlfBsWLVpJJRo+ugn/Nh/p9mdJL6Ecj7kEbNrsOWWnZNZ3NvOwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705864518; c=relaxed/simple;
	bh=nnz3+14Y7BFOR99HMts2IdfK5ZGIIXaMov8xu/QGEuU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qjgKNzMtOkv+5GbNOYfDfcjz/TASdjkffs9me5m3xZ9tNt1CX72cCBXmw66hgg+CetTcDbWIopnRjT/atIicrzksHi1TRY/hiDu+tSBu+OFXlxvvN1wsZF1BOgSUoRj+NvAj0SPSiixFRF1AKfUKAPzp5MKxUKhtuOBn+laxcvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4R1eft+; arc=fail smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705864516; x=1737400516;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nnz3+14Y7BFOR99HMts2IdfK5ZGIIXaMov8xu/QGEuU=;
  b=g4R1eft+RFdAOoEKwMjQJHjLRJKKlpffu8yYnWcHfpu5BQDSAk8Ri7H7
   wD9jO7nrvPiRyJtbaolwcFbe6N7E2Dovc92h14dWu0Rs+b0qL+rwhtcO1
   lheLLDZchw9DdaXh7u0KAIpE7DxZq0w9ss1ExLbUgTsV0K3amU4Y1Mdxd
   NdHDrJiRXFus6rPLBF3rGU0VhGQ69mNyBdxlOP2Xf+1hWbhAEyxXSqMwU
   gbHFMDj993W4bPFCqdPOS/OPiHgak6dkeJxkeAnEd+3StgmMhGGgObYj9
   e3RPECwAX8B3GLveGQZMFULQEGG8JITmKzHFAMNDCCqMObjA8BETG1I9x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="400705864"
X-IronPort-AV: E=Sophos;i="6.05,210,1701158400"; 
   d="scan'208";a="400705864"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 11:15:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778410195"
X-IronPort-AV: E=Sophos;i="6.05,210,1701158400"; 
   d="scan'208";a="778410195"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jan 2024 11:15:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 21 Jan 2024 11:15:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 21 Jan 2024 11:15:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 21 Jan 2024 11:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj+QdQQkd5A79Hh1bZXWMIOt+VlgTbm/Pbk8XWM6L+AFvDuxJklrTnDq0YCM0s4pPie/EBw/tOMLwZo+dZHUdH/8HV6Kx0wvwA12qvK9e/WN0gZIGOICOdOYz4t45eJVrB5fbCJRlCnh47wDvCCr7tfMFCiBkvZIKZkTzLFx3ZYs3sqauPH4KEX+OOJkcXdzr0TGw0DLOmtrxDfxlxR0mnPf54z1CcxSsL11GSoL4kgweqgla9Vuhk2jDGBG6XKONeG3Ml9RHosMrV4V+azBtypE/+V7TkoK2hfAQ/wZ6Vf+uev+z0WfGyOPxuxwrocclXXuDPA512OCEwYPYfnHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZD6RqtHkuVkVbnT4eAW2q07OsNAA9NjCJYJhYFs6y0=;
 b=Y8Q9i0QAiQ2FbWCvrDfLSEac6I+vVeYsFk+vO2kbgJok8WmCWnNLTL70aaM6JFjN8mTmGD0D0f+Sr6OU8lQlHDM0FpUqc2bOFOXAr2Z3U0+nEv/WCe+SnkvK1QlQtOScuFhIjSbyLMLfChHN55KSUIC3s9x1VYN11xfd2fzH/CZLGeKDpKNCEnxfcEncwvkf4GUPSXSIqL5uu9Q5HjZdndeXukFs5p4jTKHFM0bKgHNGYxLtAZWb7u7mmwN3enIVcL55LY45geTnMvflkeQeIcL1ffEdevqFPQIdlytq07YK723YoC9n0qmivVRRkBeBo/OeIZdf+fhHTAAdutj06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5775.namprd11.prod.outlook.com (2603:10b6:303:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Sun, 21 Jan
 2024 19:15:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.031; Sun, 21 Jan 2024
 19:15:11 +0000
Date: Sun, 21 Jan 2024 11:15:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Samuel Ortiz <sameo@rivosinc.com>, <biao.lu@intel.com>
CC: <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65ad6d3db040d_107423294de@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240118033515.2293149-1-biao.lu@intel.com>
 <Za1eXWiKPQp//1CO@vermeer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Za1eXWiKPQp//1CO@vermeer>
X-ClientProxiedBy: MW4PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:303:dc::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a88a9ed-2cc2-4a51-ef5c-08dc1ab54a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ph+ttGDA8orC+kebH9E0tgEX4xvNvvIy0snpdU6L2hJOKudl9CBGyUi9rAXj17px5u1kTVhkijirn3ZoNjFTG6X58a9ZIXpAgh5ryrddv5CHOhskdkjdUAcPW+rlpl4D9LOVY6107d21OwVwzCFlooeyVKxxZEeSggTXRFW3/TjQ879gc01/SMendJpTwtw73CPNjRPEoNJfxfiehauUM7gh6gKqzjNJX9FVmSxRqMmfhAnZpGl5uSXnysc5RhYVKSST3Jul/qFnbxOdDAaGSYKjycdTLR+fuCJSsPkPpK42ku7q3AS8dYoRju829lmVYSFJCKQb380YTsBQI4rluwjdtBEsPpWWUs9Uy/VEPyQhzup6VRbfGwvIcvEuPIkRnUi9GH5lgy+nCyii+czTaY0BLBTDTkeIcbEeQm2Yl/JrFKWBYcuRW2sHTLs9vNZStgeL1ckEl2eL4hCVNYgEFiIPu1rtBq+vPHJ+kd7aSHFAHtd/E0EGVSI5CBN37MVlX5/iUiCMiGDKI21Bb6qFkj/k0JbUtG4TgQn0TcI/LeX0EWE9J+ZqsB37HpxWC/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(5660300002)(41300700001)(86362001)(38100700002)(82960400001)(83380400001)(478600001)(8676002)(6506007)(4326008)(8936002)(6512007)(316002)(6486002)(6636002)(66556008)(66946007)(66476007)(26005)(2906002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mFCBYtJI1t8edombRi1dMrq5pSVy67xos1CG88vm29ygJ6LAwOgNyOwK2YVd?=
 =?us-ascii?Q?7NXoJvwdnRPTwfXWMOlLQPwPtaknk9nMm0tq52md8Q+4DMTpHJokRgKgSj1w?=
 =?us-ascii?Q?ED7f/gdWXVU0f8qoA8i2uIwWxMdK7GR744rl1rCaHiNkTMuGyHFLwSd4TCIa?=
 =?us-ascii?Q?3pxdGtJ9eOq0+whcRYTLNf7Qjx2kQJMfo3NdTQ9wmr6RC9fy69Rjf4Jirkwx?=
 =?us-ascii?Q?LIG1ecS1AyBn3UrAZ4ZdmWcAb679Ny/kWOFnKsP4IOP5m/CyFb+DJLO0FhFC?=
 =?us-ascii?Q?Ww5PIxcqAgQbaG850Mqu2F+1/PNV+ToVaNyqYscmgv5RMwUjAlY5NrYVlQtm?=
 =?us-ascii?Q?hh6oUuBj8+s/OfloLESHZ+SYboNJiUkZwlZXrRFostlAnXkLZQqaLecm9EQ9?=
 =?us-ascii?Q?Q4hP2GIo2a6f+wj+YP5MvxU6TgRp0e3FPkZ9eMssW75o2FJ4TpFBzHobgYgO?=
 =?us-ascii?Q?381FHnyqy3TCU1ge/MZs01CoqFt8LahnDbNUnCmWa1JfGOr8Rfu2ONI0i6hv?=
 =?us-ascii?Q?EoqxkTAnOcBA7dZo6kD4dM2g/E2JzY0TWCFVGNhj4F7WJzvVWKzkBjkk1k90?=
 =?us-ascii?Q?4aUqd8farYlJmw9UoxCbG8iWJrO8IZvIMpGV8es7CvRMpbCmcjkfE69aBpN4?=
 =?us-ascii?Q?mAlnu2M6LYWaZnWp4l4DUL5t2xYRhmoFdTpVugISfjlM+XVtlocpXNmxRQAb?=
 =?us-ascii?Q?lIB9JDNzvchDqc6VV7rMsFuhJC0qcNs3hU2VsDQsrHNoYM8z29kcPe/caD7o?=
 =?us-ascii?Q?lL1hsMPMDg1DyH5vQCIG/cXkeofsFeBs76v9Id28pGIRNlEo4K1tYw0P64rf?=
 =?us-ascii?Q?0CbDK+vXFULcqJfPyWu3Mh0ixVjHOBZIMEVqudkLkZYQA+kHrNnLULoo+JRn?=
 =?us-ascii?Q?QhSA22U+2TcQ7Yt9N+IIzgVLTZIaR/Q+9JZ93EFAgPBhEhVVvv6HVLTLZZc1?=
 =?us-ascii?Q?LtCrxVOH8iFqdHrpKPoF43OuwdHK4zR81EngHsUK0y3C5FikCplmCN4JqV1Y?=
 =?us-ascii?Q?vjqFc12tLppMeZ/4cYjy/ClLBI87JPqlBFHA8ZC4AxH7Ct5fjLku1EKg4N3O?=
 =?us-ascii?Q?2EiK9lO/j926kfX+by+ICTFLalqHchrnKv1+nrgywU2VHPA/L7UTFxAgb1oY?=
 =?us-ascii?Q?elkIEniU4UcYER28ZO9jpsCfgnaEKNdGkm6GsY+g8TGE1L5PPVCIrkuINNhX?=
 =?us-ascii?Q?QZNEvOhHoipBltqGo3hXtvejF8fy2fYNokgnfcW0DKcz5HEZa6MPc156vk17?=
 =?us-ascii?Q?1nllN8eDmoZtzfBVWZUnPVOnfTdZHtlVWLFaKoaf/drLSfnQRKzxEBJYlFJK?=
 =?us-ascii?Q?F1Lb9An6ADEQWN9fbepQXA82EvMD/MPFA8nPuQ4axU00sGAYnymqA2TINjRT?=
 =?us-ascii?Q?QjysrP/eNn+wJ6PiQM+GHH0HuystYFdYHmsO8126s2OP6tDOLQ+C70zBheeD?=
 =?us-ascii?Q?lkupI41bQROg0vCP+8RX/nl0wGSLZ98Ov6RPHc1TFGcWunz6IJzfFNBPrEiE?=
 =?us-ascii?Q?mlvXHfr6n7zwCHeA9kx4sJWGSH8Iw/QVy2LPLEe/dDS/fjfDPN7TwLuI9arx?=
 =?us-ascii?Q?eYGblWAZ6DhgxCjDhYdUOGljMstCSpZTppcsLFvOfwRurW9gwvUkrg1U6SxJ?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a88a9ed-2cc2-4a51-ef5c-08dc1ab54a35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 19:15:11.7632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBoe0g+g1v1jokyxCkdO2lWjR+lNWJrMhtS77FZesofeSrUchkO3qw6SFNe7CalEi4py5sxgK0O5shQWJQDvBpVV8hrzNpg45azO6t49Zk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5775
X-OriginatorOrg: intel.com

Samuel Ortiz wrote:
> On Thu, Jan 18, 2024 at 11:35:15AM +0800, biao.lu@intel.com wrote:
> > Samuel Ortiz wrote:
> > > Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> > > CoVE) provide their guests with a set of measurements registers that can
> > > be extended at runtime, i.e. after the initial, host-initiated
> > > measurements of the TVM are finalized. Those runtime measurement
> > > registers (RTMR) are isolated from the host accessible ones but TSMs
> > > include them in their signed attestation reports.
> > >
> > > All architectures supporting RTMRs expose a similar interface to their
> > > TVMs: An extension command/call that takes a measurement value and an
> > > RTMR index to extend it with, and a readback command for reading an RTMR
> > > value back (taking an RTMR index as an argument as well). This patch series
> > > builds an architecture agnostic, configfs-based ABI for userspace to extend
> > > and read RTMR values back. It extends the current TSM ops structure and
> > > each confidential computing architecture can implement this extension to
> > > provide RTMR support.
> > 
> > Hi, Samuel
> > The ABI does not include eventlog, but eventlog is usually used with RTMR.
> > What do you think about how to implement eventlog?
> 
> Since the event log is typically maintained in the firmware and not in
> the TSM itself, I don't think we should expose e.g. an event log
> extension ABI through the config-tsm one.
> We could decide to check for an EFI CC protocol availability and extend
> the event log when any RTMR gets extended, and that would be an
> internal, not userspace visible operation. I'm not sure that this
> would scale well with e.g. IMA (a lot more events than pre-OS boot
> afaik).

Another observation after chatting with my colleague Cedric is that the 
TPM layer that builds on RTMR can maintain an event log that forks from
the RTMR log. I.e. instead of the TPM event log containig pre-OS events
starting from 0, it would start from a golden point in the RTMR
measurements.

