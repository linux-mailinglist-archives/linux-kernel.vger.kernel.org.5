Return-Path: <linux-kernel+bounces-77805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE94860A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DFC2885C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4608F125C8;
	Fri, 23 Feb 2024 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqqKzJpN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CD125C3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667319; cv=fail; b=vCNx1lKcIDVHZ+mP9ppcbDn5qU5rviEm5UF9j7ug/6DNxg4HfAIdAKclJ073z+v/+cxJAk0Ygcv4xp5Nhk/mXRxJZE3Cdco84LWzz5SDg8GDMSIY+NZfvIPMX0a3fPDYIQnlom+yNsyAch5wA9yvg4AiUSQ5xNyDY9IUQSCvYAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667319; c=relaxed/simple;
	bh=mR45LYtj8QxSNj7Ym5FXotbV+ahPA1z4jnU72I0uuZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQmkGVIKCd3I5QV4YKLxM585/302lw3G68IRUxcQn2SVnesoEqhBYJnVKjqCDwCUWKQ5aMpblp+vH7g0ZgK+mje9yD7CeXhwiHZMzVWC1p0mTRyIOK/sZjDqJh0xOrkKDQGj7JS/oPcMVUowFvcSyrOUksKbXuFXeZ1u35H1c/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqqKzJpN; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708667318; x=1740203318;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mR45LYtj8QxSNj7Ym5FXotbV+ahPA1z4jnU72I0uuZM=;
  b=OqqKzJpNf38lG04oBvTK1Xuv6+sDsOMOuqRnVBIcegbvWc6mZLv5M2fu
   Wa8Ymv4kPGyEC8TdaCw6iFoJpvbYk1zrMKeMaEapKOuyMk3PrEvQoh++C
   BTiqyYL/YnefYoSOCMQOqIZzuH0ldjqLe1CwymJj6wAh90VN6TOut7F8R
   H8u15pvkLXXw5rd3rAlgi5YAc43Dg35QbFLeGT9eL9YgE6i3mzq9aoI/0
   Qj13qXz0/ZXsUD1TLKOr+3r+MOyzkd8fQq+emxWqYclQr0YQvYYCLHJp0
   AC8kikpZsihLAOqp1SxFbeAcewRNMXqcw0slQH/D9PK+r3WrYvrhniSsF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6751322"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6751322"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10496140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 21:48:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 21:48:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 21:48:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 21:48:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvAU/QnM782Zc8BFOLcLeEblsydmKXbCPLTIT4WJ2ytzoag70b088xN6/aQyx4nlD2QIDPcjDX3Frqa6CSmZoBb3f3a7s8Yb5Y7GoUcHXhVPImi3B/7arTe+nwlx3rOwRAsnzXRDGtk+SHlllMLu4yewMHiYTEbStBpE41L+Il9UEQIXziYuD+IUr5Mu0P+BkRMwob8DeUh7o5dVw2B5Ihi1RFqPEAn0ZhbkowzMwgHn0Zir7zX5Jf16kRQ/xkJeaDpgFTnerQ4hgUHal8PLtPvqNMZwqoFJCyCQuNu5bmbgANdK05upddgOVLlyAO0FlPCqm72ReSSpec9eKa5BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4el+rU7nUB+DGRXO++ujaqIQKr83foYN6ToRN66wTPo=;
 b=VbTxw0XfNsg4O3tSGreps9MGkrqXzaRlP/RUxFry4bhfEugT9sJ3uYXBMfH2WsxQhXz9EkIsiuNPgq3ic5E93h4QSK0T5W0zD0lQJUI3CuRy3iozQoGLHlx93wcvnJWheJXmkT/s0eNGZ1tP2+3bdhnnDAZXYkyD29s9Dm495RzbDC7iOqgLQYm5HPuJIaowbp9AAYl/PFjZ7Z5YWKzWE3u4amUbrXm0vB6vNnClxKnnVqbqW4vcc6KRxkN+WQRD7eyLLO1ZkJ9VH5SjQ2jUbv+A/sme+9Cf/T8SqFFz+HK2dlP1XQtObg7rK3bhXP6rJxiEx94pqaXU2fif+yzSgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 05:48:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::da43:97f6:814c:4dc%7]) with mapi id 15.20.7316.018; Fri, 23 Feb 2024
 05:48:32 +0000
Date: Thu, 22 Feb 2024 21:48:29 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, <x86@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <65d831adaf58c_2509b2943@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:303:8c::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 5716acca-dca9-4651-a586-08dc3433117c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISgWwU3PBytn/jlXZkJbclOARvLcVkBEPJbu26jZQp1mwrwQP7LEycmiNVpoLc2KPhvaVebabd4dq8HZMsBQYkKnVgXugiarDU1erqtuieUuhxXRjrDEoqaDD/Bvs1s8TAHALhyZccQjBfi9oXlCcfesKrWhVqklcTL+S00T5PwNsI3/tAjCHAIjS+6ylVCbFQSg+sYmdXmMb7qfqaR+cTPqlHj4tuvAxkH+Od5xjpK5FWNAREOrrenWH7RBamC260IAwuY5Ystj3xq3n1LIkrcY2z5SJAwaeX1yL90e1m/0O4YOqlz5wSMYL3hLeFPhWsdIuRkwpMj0PxTa8TxvbhcpH/Hq7a7FPSoXUDf7G/a5Gs6fEJVXKwJD58q/MHVEIZVi06UgtHVizvXTnlTB1nPCbFY+tPi1YMGehDEgKujiIAdupQsX0ROlQBxw3xslTxcb7vpippSzV8iMIcp0FrXtrLpd17kk3rn+l1oZvzYaZZoknNyO4iwHQkibn7o5+fKN4TxL/fuXf8+B8GphMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WCro24ovQjxU75/KAlaVF4atYzfv3rQzH2HaxefYSs6AenL1bxjvxYzwPUHv?=
 =?us-ascii?Q?vl3WvMFWMD0vfROj04G++8BKL86MsMBfq+Kml77pk7rmMEQMblFRZXJoiDcO?=
 =?us-ascii?Q?5IlE7dwRBGRgqwl3HEcL1teIFIARbb19Z9JawhjrW9UOklQUP4wrQwGbRZcm?=
 =?us-ascii?Q?wEX2Lk1X7hsmA6Ves7w2EqYzN8PQM19CvLOe4alDpEYEWks00sjysqubqYku?=
 =?us-ascii?Q?MA1k5SuCPfzZbJZryvJL0nOMK/nIyHoM9TvNrBjKWzzV9qEFH3O0cTCF0vN+?=
 =?us-ascii?Q?2q/u9w0F96nWKnVpxEy1ohBLvc3EDY0A/CqG3ZkO04sqWtARH4ozXrw5ICj7?=
 =?us-ascii?Q?hV/I9Zj69HOtg8/Tp4XOvojzi7Pz4pMWssuSO/HO+fvIKStrFbBZRjJ0aoi7?=
 =?us-ascii?Q?w18Psw1c/HLHbUII0KJXBr6JOsp2nZzsXABpwEa3JPK23mbccwznGtrSF8ah?=
 =?us-ascii?Q?TlmRmhnG507tGAaAIk4LwU3NyRI+RZxpzPeImFMSV00ssYCImA7GOWzqhBo9?=
 =?us-ascii?Q?0XGEcMYYXR5oUPAuuAfdzTC0F1fDqZWIIUOpmvBD6yruWXpwAUKpjYDltzdx?=
 =?us-ascii?Q?RjuigNoTb+RZnxhXPQMY7S3rkIr2xDF+A7vko6RxIIrr+OVP4wXUlpxO3dis?=
 =?us-ascii?Q?AgL7nxFiwXOxwJxqV7CXq/OaGvE3ytS9InJqpU+M/wD2B09kwBQOdoo1fay9?=
 =?us-ascii?Q?2FkBmLS217JN3nDUM6DoV78umCjZqur96fDBzfSH07olByzrMsmTCG/jVzvz?=
 =?us-ascii?Q?nEFTe03AZPsL9/B6r9hXRDmVI0+tB/2UICFIUL9Vw2X7I3i/6D9hPJAzFrj5?=
 =?us-ascii?Q?p4B3RBdToHkFRgdZE1y6aANR8Cvvf8vZxjxf7URsAVx6Ox3qEFjCxr7mhfHt?=
 =?us-ascii?Q?Py0A0uO2V7aH8WLoY4d+Gitu8Np043Vfzu8xdmNGpJ7uMZJ/rMuJFlpPQYl2?=
 =?us-ascii?Q?VrqCSVarpXIOzNV6iyAKqMjIWc5j9lsFOy423Pz2QQsB6UVDuOEPTdyNoG96?=
 =?us-ascii?Q?h53etiJSPqFmXmJNgrPwjltmpew9swMyX1hGEBkB6IRRj4uZSkUbE44Fq/Iu?=
 =?us-ascii?Q?T3yGFBqAtRE5KcPcbwACf8V4oR7oYwvYjEOafy9pWEcAJsgpufLP13Z1HKmF?=
 =?us-ascii?Q?YcnO+59S9Ihdg/xkdaO9F6oXh8rAUlmoEo0/q4MOwxr4Oah4c+6OBodK0EdO?=
 =?us-ascii?Q?kQCAzZMpXQIq3buYBhSXsORtknPdFVw7hTUsH20tQ3aiWdHDoaeuz5di0ufa?=
 =?us-ascii?Q?gkX+xVSfl0UtvWvJBMxqryKmyBdxoCTv5Bzc3NkZy4OutHrbhoJNsQ1NqDih?=
 =?us-ascii?Q?JHmZDMYgaryhTdkcAZB8iZfGZBW10RNk2Q4DvnPoKdQwpc6YYp00D9XG1ovX?=
 =?us-ascii?Q?KFwcRK9yf5TDW5XH3a0MbNZ77nrWYYu39koC+k/AjKcjunm0pzKqGgpv1Is0?=
 =?us-ascii?Q?xn6KhTBSy3NKAgI1Xbl8jn0/i26Jghmi9nT01BMGEDxwAYgAs6s0/9KR+8ST?=
 =?us-ascii?Q?9bu1Chy+mpe/s8DSU6oiuXuZt3GWaJ2uvCyNP5QX0oJG29goAS600KjgXT1g?=
 =?us-ascii?Q?FfCwe6R7Kw53sUcu8aQv4J2goACPRVJc8wMAR4INcB6L3d6v3TT5DpqNQ4AM?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5716acca-dca9-4651-a586-08dc3433117c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 05:48:32.3678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1CmR8od9NkrOuChrGHz0vOo15VsVl86a7WZCF43gzbS82TG3CJgtMLQ1O5A4cvan9NmbOY79wWf7j1MPlXPOELnpCJBhiauqb/pQUbaPdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com

Kuppuswamy Sathyanarayanan wrote:
> During the TDX guest attestation process, TSM ConfigFS ABI is used by
> the user attestation agent to get the signed VM measurement data (a.k.a
> Quote), which can be used by a remote verifier to validate the
> trustworthiness of the guest. When a user requests for the Quote data
> via the ConfigFS ABI, the TDX Quote generation handler
> (tdx_report_new()) forwards the request to VMM (or QE) via a hypercall,
> and then shares the output with the user.
> 
> Currently, when handling the Quote generation request, tdx_report_new()
> handler only checks whether the VMM successfully processed the request
> and if it is true it returns success and shares the output to the user
> without actually validating the output data. Since the VMM can return
> error even after processing the Quote request, always returning success
> for the processed requests is incorrect and will create confusion to
> the user. Although for the failed request, output buffer length will
> be zero and can also be used by the user to identify the failure case,
> it will be more clear to return error for all failed cases.

This is a lot of text. More is not necessarily better.

---
The tdx-guest driver marshals requests via hypercall to have a quoting
enclave sign attestation evidence about the current state of the TD.
There are 2 possible failures, a transport failure (failure to
communicate with the quoting agent) and payload failure (a failed
quote). The driver only checks the former, update it to consider the
latter payload errors as well.
---


> 
> Validate the Quote data output status and return error code for all
> failed cases.
> 
> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v1:
>  * Updated the commit log (Kirill)
> 
>  drivers/virt/coco/tdx-guest/tdx-guest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
> index 1253bf76b570..61368318fa39 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
> @@ -228,6 +228,12 @@ static int tdx_report_new(struct tsm_report *report, void *data)
>  		goto done;
>  	}
>  
> +	if (quote_buf->status != GET_QUOTE_SUCCESS) {
> +		pr_err("GetQuote request failed, ret %llx\n", quote_buf->status);

Do you really want to spam the log on every error? I would expect
pr_err() for events that are fatal to driver operation that might
indicate conditions where maybe the TD should give up on the host.

Yes, there are other pr_err() in this function and I am kicking myself
for not scrutinizing those more closely. It is likely enough to
distinguish transport errors vs payload / quote errors with ENXIO and
EIO.

Otherwise if there is an exceedingly good reason to keep this driver
chirping into the kernel log then these likely also want to be
rate-limited. If they are "just in case" debug messages, then move them
to pr_debug().

