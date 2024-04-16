Return-Path: <linux-kernel+bounces-146245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58F8A62AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD3C1C210A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8127D38385;
	Tue, 16 Apr 2024 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvKOpLNX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4452381BD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713243349; cv=fail; b=KPAHih2hzLD1GNBe7R7gHTQAJoB9WySBDmWccM+o9xdDYNH6gY8SWlRKDIMYISGx1/GTf9DjPs3aJtWHMlh0xwouAUwiytpk5CaVJXW+eZfq7pJnEwzARTXZbHSHKu/Fuew+AM0FXEdfBPX/R8io+4z5oWwq1fO24v7ro6I/5+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713243349; c=relaxed/simple;
	bh=xZBHvCmHDKbDDxNz7HBBQdfpRVfsNbBX9Uij9qkv5xw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXoR5bWwoQWtyhxKF4VV8c5hhJlqmVXs2rw2dXuQAcqFH+RsCDnZBOyouLNzNKPNTxPY8Z7LmsEmZyWD4+zXbWv7p0qYK3o/Z1wObiRhmoaITCAyPoJjo52sMVSvxuVwl//jZ42LAWb4tnyHFz4xRjJJ+6TIK93f+B2WrSVwXuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvKOpLNX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713243347; x=1744779347;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xZBHvCmHDKbDDxNz7HBBQdfpRVfsNbBX9Uij9qkv5xw=;
  b=LvKOpLNX8VJjMiqU6Xb6WxSaxhGtl4T+8Oe/PiSQCebpsGEQl2aMIdm/
   +g79mljsT0UaamDAJBHh7REVN0Ol7DUteoqJyqcKozm5nG/kGs29Pq4Oq
   Wm1jWBm4kYAotEcMFm5viiESayvg5qMSxdZTFvpAnhevTqh8dWaD0mD1r
   TXr8skBE2Q3ac3hm2Yvu9nQZRO08ixvDwBV0NZqMNRcIibYqGIBZMOzrT
   mPX7SdWBWAHgn2Lu8ra6XywWLgnPlJR986AxgHvJD/Dycs5JtvltxEoKy
   TKx+mLN2sxCQggm4gL80+iQLSpu5LIEZXCb5ogjtLMZFOfZ9r2pUKvFrt
   g==;
X-CSE-ConnectionGUID: qeZPF/OzRoKP0ktAe5T1Yw==
X-CSE-MsgGUID: fJPUw1uXR1+oWwYlzdsEBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19264101"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="19264101"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 21:55:47 -0700
X-CSE-ConnectionGUID: 4o2qnGdgRISpNvhSX13KAg==
X-CSE-MsgGUID: GgCz6q8uQPK41oVG6fADcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="22157741"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 21:55:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 21:55:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 21:55:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:55:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSqrzhHpNLjTXEpr/5lfznO2IYUuww8/R9f5T0ujWfokc+JSBmFYAuukVMRABDErGi70qRgdCV6Vmg8JYDVmNRRYWxgkpakNlyH54tMrYLFpv+KRh9VWX57eAaTXc7zRHYbySMOsiAZkg7bD7QGbgyaAMmUPcvUwPFphPuGB4tEsTqwOwbDqvw/YyDH3N4UtLJS+4PWPAnSMAheL6+aOb3XUDPyw6RjmncFOyWjSOBmctmGDU28I7tq8LW67LSDAdt9NyaLZ64Gkc9Hwb9b1xY4BkwoM281wuD4Z1ufGdYnhbauWwSYto8UaR86oHmgLqRtfTX3tgf3XSEFQ76qWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRJaykjJE3JA9pfkAcPG2hjDwaitfiKEWPtO8u4fxL8=;
 b=XOWsRMwN70GAr/y5ifsjOhRa1B1fK9bRkIF1jNq2gbi9wr5Aun2SWpMY5hYdvrMr6ECRbfcf3VoyoOXLPkW+UkNw3MDlbmgegght8O8/fAY04VmZmCV5ZYyr5ZpLC7llU6UVdn32VKLCFuU4ckwXhbJDuLkty11OZa3UCSEAtFP8ygJuLL4jNpnODftJxSFYWl1qeFiGg5YlIWR5zAr1obH8etZemW4dr8yJzKqvn8ZWj2icljD5+xtErvhuy3DfxtgHjIDeojZWuSJaQcQ0hfkGnfgYCcvqcm0NgpNcFsEK6wMog7zlYEQqHiSNu6B4NIkoOMInPluoOry/alYNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL3PR11MB6436.namprd11.prod.outlook.com (2603:10b6:208:3bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 04:55:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 16 Apr 2024
 04:55:44 +0000
Date: Mon, 15 Apr 2024 21:55:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 10/14] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Message-ID: <661e04cd345af_4d56129468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL3PR11MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: c0eb621f-f781-4d86-981f-08dc5dd17907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpWDPlNSzUpBpyUkW+G1gkff2ERLdmXlGm+dMUJxexqOkoApd05iKlbfAdVK9e90I2SMqzyF3ZrarIFOL4YPO4n9pW7eQFnbO3oKREhToxC9866wUk+0JU6pNo9PVB0OP/vMuZiVWPXNX6uwL+4SbIApZ/2VdmvPbkbRgGfA8FQg7tmw8owBg6GOMg95mtld8BoF6ECycKHZ1yTMlE2giIxY8TkF4xORn4H9bFzb2gc3NWp+4QqYGhtEmF+0ldw4A5TjqSc74aSyXIAYtAR8m8Z/U31I+f3cKvPmwBLTkGO8XuM3VZ09PKnvtBvHUQQvXUAtM22kEEqviuugXJGl8w5cf+XrqfPDERqDIqFgKNo9CSvnLsSsxhc1SMfuVCcaVFLpVd75GZdz0vyKhNux1U23KdR6vS6gg0rFwloSGmkw9jtiMnMCb1nPBwR6LG/uICr69iuTbFb//1EeCWOPDcZzarGEqnnTzoSZFg8Gx8CqJrj6oUgLAVjbzj4snSY1vrgrX0lVcEGyoOsyXn7mSph8O9Ej4Mjymb/ssChDvtosJK6Bhw8+6ljCZqFjZQ1uANAp9UkNd6WzNqZkfUf8Xj/EOWEosrimXnE0KcN41OxtckUehuw+pS8Af11A24CcFWdUktsH8fo4tAiFMWRhwEhdIHGZwJ3E6BckGJeA4vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LkDl5qxC0uXOl9Z/D39v4khjjrMtx0BJhMgipHTyP0KmYHv+kk+I+3y/uiFk?=
 =?us-ascii?Q?K0wWkwD+PLhrjZCwKqKvqWHyujyNcpgtWLriwjOLrV48BcqKGgtjp+0LbZjf?=
 =?us-ascii?Q?XqLUfkF9DV4Ny3AWbXFr9H9mYXKf6tiH1P1nGiMflDUlaupgr/m4JcCpXJXx?=
 =?us-ascii?Q?3OOlTPbtuZx7/qOeK7u6AGWJw0YWxvedxXYkUy2j/2TBFUArZJZXlMo12c1f?=
 =?us-ascii?Q?2JsC0IRe3U3oPA3JHzyTViyw8yLDS52hPEsNzWatMBgn4ClqSIwRHIDT4meT?=
 =?us-ascii?Q?r3CG00w19E9JnzGINqUVpJg5v63LcqgVNOBCpQc/Aow946mDhZ0Z8SAKPnc9?=
 =?us-ascii?Q?0jaF40pMVxbLzMPE/vie7i/8DpzwewPJomj3bxUWDqegjFNJy4SiSxE4x3k1?=
 =?us-ascii?Q?0bEFy360yLKL9H5EXfSNUcNBGX8DVa1Vw2ZKXUH6NADRZMTJD6Fbh/VqMlBJ?=
 =?us-ascii?Q?91a5kCsKXwqQhARecGM2F/On0Knv77GgM1VB2yn4Y7HHVvIxseNl/HzDvz1C?=
 =?us-ascii?Q?6JxdDWNQuacoh8Gx5IGTjYBscXaDiB5TMVhZqn2KQGV4XILC92SUTxjpoYJ9?=
 =?us-ascii?Q?n2BMENx1iy9/VpwNWd7xGd3ttrFcnlj2vpVxFpAWGtPizv5YgNfCtESR4pVm?=
 =?us-ascii?Q?CwtBQ90sBCZ1hHKX4VYJqMOqn1ecnDkxnlgNTJzMPCYkkTRd5LBOFiqqM2hk?=
 =?us-ascii?Q?0XQUvnZe+P/nZ0af1u44GUVOR9eEazmel0taL25cIFJ5mVPFFWlzk/RcIaIq?=
 =?us-ascii?Q?8vAaGk0BRZ1LNdcBu8BLmn1lMgdPo0L3gKEcmw8ySjLA3toPmL+COnqOclJF?=
 =?us-ascii?Q?nxSntRrcDRstnZTV+trg6FWShK+O7Hbusq+95laYokaDfeXgjg+SGayuL9Jj?=
 =?us-ascii?Q?w0j2FPK+6/z2rJYtuhYT9UXyvasdlpUwePnN1hsq1Z3EDy0UibNaEZEia79w?=
 =?us-ascii?Q?GAwIaSy2oGhQmP6zRQ9hRKobOrBkoXX4kwxU8kyR+jhNOUpulYX97lHUayi+?=
 =?us-ascii?Q?JGxHFlI+c1mHpAifdcRTVymugOUcXZwTxCWZJMx72/g+xDmvHGhA87wWZagy?=
 =?us-ascii?Q?F9NLAD0sQSgPInZ0qxZbEdLqVPXb+8q2PD4YiqjYKQl/KoQOGSpZYOdCA4Gz?=
 =?us-ascii?Q?bdPVklRP6CaxGAG9+ejl4qKHDvllPaJo2LuPoiGIURCKH9aeVy+n5qt1UnNH?=
 =?us-ascii?Q?O6oIOjygDP2CEOlGfMtG17Nzy2qwHX6rFZ4Hy3/eW6uEtq6bDclGUKn85oHH?=
 =?us-ascii?Q?XumbBOogmMi+LCI4LvK7dG6YLen6iXzf1BRO19p1UC1wkMh1UDvqA5Hky/Q5?=
 =?us-ascii?Q?3qQvgFC1MolCYc4mpEPeAi7XSg+5beNUI8aR4PGpBqb07pA8YzzA9y/ROjis?=
 =?us-ascii?Q?3bx9YltyoMcQ7O8IJpSCnP6DcXzjV91oKG+wwRMd5fvMwQJ8HAQelcEtlAtp?=
 =?us-ascii?Q?w2zH495WS5RyLvhFrwV50500Ln0SIGs2OtDtFL59G16ewH9FcpOjWdwXwdro?=
 =?us-ascii?Q?e1QDEk+0d9k1YPLMZCRnX1LsV9yaRZ5I8aYDQmHP2O8ml5AohJlIkQ+cEpzk?=
 =?us-ascii?Q?pKKl4Tf388W1myjuv+Zvpyc4f8z7L65b8A3hRFEwvrlP/cDaSoeJT55/P/bo?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0eb621f-f781-4d86-981f-08dc5dd17907
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 04:55:44.0674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7j3e3PFte61Z6+eSdXolQ6yDBx1xoSHyOD5ZHhUU0eDOdYxUOpYR5tGJvnAqzAMJLn8wIxKVoKsnHGtxld3E5QQmIEAVHILt/sQoYUpPOiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6436
X-OriginatorOrg: intel.com

Tom Lendacky wrote:
> With the introduction of an SVSM, Linux will be running at a non-zero
> VMPL. Any request for an attestation report at a higher priviledge VMPL
> than what Linux is currently running will result in an error. Allow for
> the privlevel_floor attribute to be updated dynamically so that the
> attribute may be set dynamically.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
>  include/linux/tsm.h                     | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 1ff897913bf4..bba6531cb606 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
>  	return 0;
>  }
>  
> -static const struct tsm_ops sev_tsm_ops = {
> +static struct tsm_ops sev_tsm_ops = {
>  	.name = KBUILD_MODNAME,
>  	.report_new = sev_report_new,
>  };
> @@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>  	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>  	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>  
> +	/* Set the privlevel_floor attribute based on the current VMPL */
> +	sev_tsm_ops.privlevel_floor = snp_get_vmpl();

Why is this not vmpck_id?

