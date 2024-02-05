Return-Path: <linux-kernel+bounces-54072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD3684AA56
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70CEB28E1F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D7482FD;
	Mon,  5 Feb 2024 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tk2NPNQR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F44EB21;
	Mon,  5 Feb 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174689; cv=fail; b=LHPp+M4XH3iAAHLXENce5DcPnA4LNfpUQn/bRrCMDK/nNdADF4myBclT8C0SX1+TxogVVeSbDSV2/j1oIOojdIDLYp8awfmXOhjKtqvu0NwBWcFWLyPCfH/ySP5/jgq8QM929VefgZK8GXRvy6dxnC5VLIIdtUuj2rKbF/6A07E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174689; c=relaxed/simple;
	bh=v+1zpw0TX4iYwvioWVALKigHMf/J9zp8/whHxhwo97Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KWDHmkeNuSKh2WTOpiwhRuATRi9qJZi9n2/7A1Ob2NOs+4bRsp8/L5Bk+ZtnqJs38evobExodRtrpe4S8hZ/firvcOU+bYUp+VA6RojD8XnKpKZveeufuPFiaWtrcg9w2a+5WMLc/QBdjlqcGLtb+0HkApd27Z6bqGt57samR0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tk2NPNQR; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707174688; x=1738710688;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v+1zpw0TX4iYwvioWVALKigHMf/J9zp8/whHxhwo97Y=;
  b=Tk2NPNQR+vo/lLD0i45MCrzPi42qcl4R6pCGOka0ZseKGKxfBrU6f9s8
   dYQxA1TOI8JjKMIT5h0yFUigXGG0Toj42lL0Z5JlTJmwCUMsSmvy313mr
   Lg3Q7f9tMQVBLpQ/l4nSVu4JZ47Anb437T+trnUzKkMeSed2Wn7MyLI2A
   4gGc8k3w6uM0Xyy7+EoDdzcNYp3eDQ0NVqh5RTMHKu4Tx+gobBEL+HvhP
   8OlB5OTK1rJtQMYy3Xd8tRvhLpPXz33+x/M56jsBiFYSX9D2WSu0eNB9s
   ITitSJO/TCJCNSAnl3tadNtiBRa9mALDmdgExm2wBYYFY2Gb7o2pn7pyr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18051202"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="18051202"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 15:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="823992987"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="823992987"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 15:11:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:11:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 15:11:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 15:11:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 15:11:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCQxFZFCF/PM/z9v6Iugu+ZQoORJTmEZdPTwxFZCGY5FwItTjGZjIdxqmQuFFrYsmRmLv0d3Co1qs5FaHkMozbZ9YYK1SMJTs2vx0ZXUEbJGRjoVdfb/QIfS+5Zo+963W/E5JKD2VDPgSSa4/fmOJkHynT5RRh2qEvPl54/EpB1jNmXELbH2vVnNEdSC7CYqgkLngWXbDpe9exWBuCz5aXo9q3KJUhEUsFAhcPYAbc8jwx0S/XuN33XqTMwXkVf9ZyXpnOp81U/3omGt+ONb2m44y29LuBrnxOdCR+QfOI7szCSYrLT0CCDKaQZtMaQ6/BY2nkqVywV6TaRORTza4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6zl2EoSQFtbe+7rcJGw+6mLXtP02c285lmEZvG8gfo=;
 b=XCtcrPVYbFAx5bTYHUzjJG0Ka763Jp0e/XP4v+HqxHnrlHkn+k76RIufh7vYELDJDWycwqCHWXCeVDwKgK/yUvlpFGj9+JG92jis8uCqQVYFxKNnr6lNE+cFDIZ7uG0ANWvp+IIRBRQqFsU1urp+6DCxQZ8+Xs0zzuToQB4cgFWdGr8r0fpA/InUEk5EaMbqyTfUSxJJ2Ousq7Ys79NKv1YxvZVvxMrtADh9M8rLPRI8OOIIf55vkoWo7uInRae2leLCXduqMp1gDcNFcDQkSNjcjJbzvd4vNNFmZNpM/QuXAGvzz/IVllHSUmAeu2q10FSmS25TrphF1foM/XmYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:11:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:11:22 +0000
Date: Mon, 5 Feb 2024 15:11:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH 1/2 v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c16b16de625_d4122941c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240205142613.23914-1-fabio.maria.de.francesco@linux.intel.com>
 <20240205142613.23914-2-fabio.maria.de.francesco@linux.intel.com>
 <65c130d7c4c52_4e7f5294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <65c15b025484f_3744792942a@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65c15b025484f_3744792942a@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:303:8f::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c8139d-4b9c-4389-233b-08dc269fc496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5iEJqcIWuH8WWhoCpYiG/7MX+qHS2qJn3cxCTH3lphhvXtMDtAkKF322JJsgg5OJDnO2sau1o7LHSCBExOQ/yXvpUSSps/AMAqU5pprwW5Z6DYI8I8sdIOQuxnCZd5zCq0kBLOV1B5pGfjyI9LlRueit61cU2cd1p77+XWDjzZJY6sr5KIIcgqJm+0/Qicn5RCj+be1k9n5fe9ztJcPT89ex2lTOldC9Aexk4PVTEKt/vQ1BLZpoGH5O56aRhiL4qFO0rorRutKxyIGOzDBUdpBukcow5ibyvYjmRrAasgrgcX87PJmOp4ZdYA/xc3tg4hEiQCh0tyuzpR6vuWyXM5h8qnZC1UzdkqNQ/PE6Mc2u7qkBOClQZwVt/+pef3Eod8zVt0aumbJXnnt86VwWhUM3Zj2ci+JqfKlXmkezNOXzzW+LTOGAU/1/FXyXZoAUMvLeYbhqSeXzgAPpo3CpO/EBb4Go97g10LY6ZgNSB65XQZQnivk3DkQgOv0awt3mWhvwakAQ2ScuCEPQweqjRw+9WJbALcMWOpz0D6mcaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(316002)(66946007)(54906003)(110136005)(66556008)(82960400001)(66476007)(4326008)(2906002)(8676002)(5660300002)(83380400001)(8936002)(38100700002)(6506007)(86362001)(6666004)(478600001)(966005)(26005)(9686003)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e7/Pzkntzu+Enx346/PHvIi/ftOK+aFxFr/KtpeygtuOvsUqHKiSu7KZaLGO?=
 =?us-ascii?Q?O8k+ceJahXFPOVForRkzX53XGymGCCXBQCWZML3CHSZzgVmQ7BMji45BuJ8Q?=
 =?us-ascii?Q?GcTI7ZSArjzl6ZCGL01yWMsWb4STm6v1phwqTmM3Amib47wvHN9Yqoo0ympp?=
 =?us-ascii?Q?BkmdW0nlqCCKHjgmjS2g5UVU0kD4vDvp7PwagBvOFSD7I/gqChbrSbOd1mMF?=
 =?us-ascii?Q?UZ3PEPjldTsSUdMrlE+dC7nq80ey7x+kpTYqq8R+171nFW88iPnF3asW6Re2?=
 =?us-ascii?Q?jnZqys8XaHCPBBOeRx7QOCwEweXmy1ie+jwU/RkQwqo8Klh/Mv3BCzU6/0zU?=
 =?us-ascii?Q?6y61CVS5sCnM5DbWwy9Xk9ZnyybP5m5xiC5ML3uvE8F96nCYFUxE9D2iJg8+?=
 =?us-ascii?Q?/E4FnmDlkflFSG78r07LdHiO/UpqHi/piMM6CW5v5d1GtzsqrIBLKTmCMANm?=
 =?us-ascii?Q?ljArgvL94ZDOfX3ojjlSj8Xk1by9L83JsOxFlPkGaKJyHQ+z7Thpik4SRTwJ?=
 =?us-ascii?Q?ybzs4B/QDOOc4TPJxviam2N1DIU+0H8J6/wzsTFV7lpZrV+tgzfkN8npJAoN?=
 =?us-ascii?Q?Skbgowh7Kn3UZEAzOKZQ/zED60ZOXxnQua2yGXZrsSphkYoY4DhsRv9xxbP6?=
 =?us-ascii?Q?wruPLed01czQCXIJeeDFUmNK3pkXywXIGHQiX04nUxX/CFScJQkKJJB3J+15?=
 =?us-ascii?Q?EZuvTJ8hVnf8aj3yQEz8E1uuP68mb+kPvaXULxBWTIq16JHA9cNsHDyMjxZH?=
 =?us-ascii?Q?mQsu+gzstW92hii0Bw2zLNqPkiem3796cp1GIPRTvArhJKAz8wSU9QY62QeX?=
 =?us-ascii?Q?rEKXbRM/gVwprpsfOU2ljBKFvSWQUXUDsf458jIcG5IBn/ziPSsi4eyMSFWF?=
 =?us-ascii?Q?TlqF3V0rrjfTKtWHTM2AsKlhRDQhULE3KHRa8H5e+Vkcqd3bsWalZUtNAWaK?=
 =?us-ascii?Q?vupGhKeoJikC/MojUoTUJ0WjlyJFbKqHZEEKMrPPl+DsTLAXKsQMcOZqvAPU?=
 =?us-ascii?Q?/r0DWVXbuJDv+dl+QfB7NFUWx0R4R4GlzTgGd2HcpZspKfb0bXPbs1KD5Sm3?=
 =?us-ascii?Q?6ju9iEqnNFoAjodWC9TAcqiYLWlwaE6SaU3wugcl6wxbuRKlm8d6loeMpn17?=
 =?us-ascii?Q?3NR+0R9SwOrkbhKulUOkWzwEyyxUhgAuiCxVwC6pzkThim0Cln/2h7QqR+d5?=
 =?us-ascii?Q?HZHVsafN/JKpN55M8+2EcUeojc2dgNmVx7t/Ik63nd1Qo+KZLfb3xYRnK75J?=
 =?us-ascii?Q?syWz39PLr6SyI+SAHlOsqotGN/fDBDocsnWzMBT/M+f6VsoDMAn232t0ro9O?=
 =?us-ascii?Q?06KDX0BxkZo9IzKilFZ5sXp3pc2wZV7GMjE0yK7pTYzpw7CXF8znbjG5SbIF?=
 =?us-ascii?Q?y8esoeT2xJHM42NtFXcouoHykQKg/86b3dQByN6RfmCLAoaXpzgD81bBWbNM?=
 =?us-ascii?Q?jITL8CZ/YordhQjbzOMTWGWQv7fdZzwkyd/k/wzMcy5SVjp8aGjUmhGU/PxA?=
 =?us-ascii?Q?iKo2LEHT25g0r3dtUzn6O1zsvZGLFayLahSPr9wTwUmJazI7QqZx2vQ85n9x?=
 =?us-ascii?Q?2kecLcLrweWeTGKTR076yLDbY+qeu91wPRxRhiExMrHExPnfllgD3Z1HqwWi?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c8139d-4b9c-4389-233b-08dc269fc496
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:11:22.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6kDxUOFhu3wVHHsEx2ZjkbWXZXRgcLAQ9cThrrIrxGMM/LwoAGyYTnZt8Uq35wFxF5f1bElelq/Ga4drHfpvT0gJP6S6NkIH6AtZxb0074=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dan Williams wrote:
> > Fabio M. De Francesco wrote:
> > > Add cond_guard() macro to conditional guards.
> > > 
> > > cond_guard() is a guard to be used with the conditional variants of locks,
> > > like down_read_trylock() or mutex_lock_interruptible().
> > > 
> > > It takes a statement (or more statements in a block) that is passed to its
> > > second argument. That statement (or block) is executed if waiting for a
> > > lock is interrupted or if a _trylock() fails in case of contention.
> > > 
> > > Usage example:
> > > 
> > > 	cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > > 
> > > Consistently with the other guards, locks are unlocked at the exit of the
> > > scope where cond_guard() is called.
> > > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
> > > ---
> > >  include/linux/cleanup.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > > index c2d09bc4f976..88af56600325 100644
> > > --- a/include/linux/cleanup.h
> > > +++ b/include/linux/cleanup.h
> > > @@ -134,6 +134,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > >   *	an anonymous instance of the (guard) class, not recommended for
> > >   *	conditional locks.
> > >   *
> > > + * cond_guard(name, fail, args...):
> > > + *	a guard to be used with the conditional variants of locks, like
> > > + *	down_read_trylock() or mutex_lock_interruptible. 'fail' are one or more
> > > + *	statements that are executed when waiting for a lock is interrupted or
> > > + *	when a _trylock() fails in case of contention.
> > > + *
> > > + *	Example:
> > > + *
> > > + *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > 
> > That _fail argument likely needs to be a statement expression for the
> > multi-statement case.
> 
> You mean ({ ... }) as discussed here?
> 
> https://lore.kernel.org/all/65c1578c76def_37447929456@iweiny-mobl.notmuch/

Yes.

> > > + *
> > >   * scoped_guard (name, args...) { }:
> > >   *	similar to CLASS(name, scope)(args), except the variable (with the
> > >   *	explicit name 'scope') is declard in a for-loop such that its scope is
> > > @@ -165,6 +175,10 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> > >  
> > >  #define __guard_ptr(_name) class_##_name##_lock_ptr
> > >  
> > > +#define cond_guard(_name, _fail, args...) \
> > > +	CLASS(_name, scope)(args); \
> > > +	if (!__guard_ptr(_name)(&scope)) _fail
> > 
> > No, as I stated before this is broken for usages of:
> > 
> >     if () cond_guard() else if ()
> > 
> > The 'else' in the definition is critical, this builds for me (untested):
> 
> I did not test Fabios work directly but I don't understand this example.
> It seems like your suggestion does nothing useful.  The cond_guard()
> becomes a single statement like...
> 
> 	if ()
> 		cond_guard();
> 	else ...
> 
> ... And can't protect anything.

A sequence to acquire and drop a lock is sometimes a barrier semantic.
Is it typical, no, is it possible, yes. I otherwise do not understand
the need to include the subtle side effect.

> cond_guard() as defined, the ';' must be used as part of cond_guard() and
> should complete the internal macro 'if' statement.
> 
> I think this would work:
> 
> 	if () {
> 		cond_guard();
> 		... do locked stuff ...
> 	} else ...
> 
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index 88af56600325..665407498781 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -142,7 +142,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >   *
> >   *	Example:
> >   *
> > - *		cond_guard(rwsem_read_try, { printk(...); return 0; }, &semaphore);
> > + *		cond_guard(rwsem_read_try, ({ printk(...); return 0; }), &semaphore);
> >   *
> >   * scoped_guard (name, args...) { }:
> >   *	similar to CLASS(name, scope)(args), except the variable (with the
> > @@ -177,7 +177,8 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >  
> >  #define cond_guard(_name, _fail, args...) \
> >  	CLASS(_name, scope)(args); \
> > -	if (!__guard_ptr(_name)(&scope)) _fail
> > +	if (!__guard_ptr(_name)(&scope)) _fail; \
> 
> Building on what I found for scoped_cond_guard() this should be
> 
> > +	if (!__guard_ptr(_name)(&scope)) { _fail; }

That's still a dangling if () statement.

> 
> And drop the else.  The else needs to clearly be part of an outside if in
> your example.

Please just rely on a statement-expression for the odd multi-statement _fail
use case and include the else in the definition to remove any room for
confusion.

