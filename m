Return-Path: <linux-kernel+bounces-158134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F828B1BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EBEB241A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1556E605;
	Thu, 25 Apr 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1BZQmmrT"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9CD5A7AB;
	Thu, 25 Apr 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030461; cv=fail; b=MX6d/edWmwXicl81urGx62E+9sjJjZEFEkAOj+bC6gx7bYNibh4o7xjH3yYry5RySRq6DizmrrDeqlttm4Gy4iTU932eMDN45HtAqHRaNlQah6FtseaRe+I+ZmFmqq8T57nnkZNmK7NK+7qNVktEHkYhsxhJ0AQKxv3bfYn7XgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030461; c=relaxed/simple;
	bh=ZuEGHPcuH0rhFOsItc/io4sxxAJ7I6Vn1sOWOAxn3vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jpAxKVOHcaKPCii8THgprBEsTGFpkEAIZdB+nlEOVLRo8VwCOzeSDtmUttjw/Wastgz7yE2A+qAUcdmwKres+7GSBvD/kIS+NkMo8er9zXFoGwppAvVvCgXhXD+BZ3KzABAUPdd8s04KgRE8BXKnXff95kqHy6UJthkiNxoQeV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1BZQmmrT; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkCjc8fLRcDyXlK/v1x6PZpiBPjHtBeNg7nM25TYGfjJyNgkgXtKjUZezBmfCACq69jzNlRckB/E3gdjlumN3FEZEGvih8Qip4REwFkjHnf8UmmNhexpt3PiwQ0aP6MkpjKgkuFdbrrfh2argD9xYXA4rHA074qeP5+KKkGT1ZZ0bHKMaynjoC2jcbg66citQqy3gdXMSS+bo7VgKsShXbOf3nn1zgNQNWPhTmaD2HoQI+DDz1+MZ234pk+4C4OKztMbelrFGIRnlOutNMbYHARJJ8irrbXR4gAT8SXR7cY/ojqsP1aYLXXFwSyJ/f9FQacGDFka9autVKKmJImYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crdiQNhWVvR4MwiPX99kRfdpxdiklO/JdrU5iCS81Pc=;
 b=GfKTcZk6UE/LkstjKJkwNjfAAhjF2pUBj17tBVhAspc69Ylns9G+U2/XsPWsHB6MdYYnuvZXH0ecfO3OsiVt7lsnSEUnDgBNh0QvMt7JCMlHTC5LFjaUM0kqFpWFW85Pdje2lMqXwZ2INpF0h/XfuWI0BLfUo3o+428j5E8/NudcBccmWpYFWwrq1lR98VG7DMmp3IxKClzkCt79o76goc0sGuZPbKw3hLaeaLfgE+XoGXetxjwKsupAEWTxTM/thIP3eFW8QFhlnlwGI6jvPYrKq6m8+Se0CcEExRgftG/8n4Ds+Zzw6cCHpbgqcM8euucJtWHVxdlNWb+zSAOe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crdiQNhWVvR4MwiPX99kRfdpxdiklO/JdrU5iCS81Pc=;
 b=1BZQmmrTAXj/T1x5w6sAuPcoqbwr6L1uD6HoKl0YkCAUVGCzWe6kMeMGqplEoC/WwWk0sFl8fgKLgqv77+jZuokVla5A2ej0x8rGa+TJvw0dGXNQwzt1eVMDhQIYb852sHGYtrPNJcjOkEDdI/dAD5s9as25oz8tiiB7pngiM6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:34:17 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 07:34:17 +0000
Date: Thu, 25 Apr 2024 09:34:11 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 0/7] SRAT/CEDT fixes and updates
Message-ID: <ZioHc_L5PxvrMNaP@rric.localdomain>
References: <20240424154846.2152750-1-rrichter@amd.com>
 <66294584e3869_b6e0294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66294584e3869_b6e0294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH8PR12MB6675:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f295082-d324-4626-f7e8-08dc64fa1cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L0+JnxAYV9ejjPabMG9EclIXRG05BFb8BT8qzZyk70iFropAp2JV4izMLA8w?=
 =?us-ascii?Q?6CHb1BxbVNugn8+b6yDoqfZp9CGBB/IursEqUf/j3JYW5vLY8MHGCtBHMjR9?=
 =?us-ascii?Q?/+GHLX7llS+5hAr9H66eboDAPITsRRCZG5btNpg++/NPIU20+WVBS8yh6ljw?=
 =?us-ascii?Q?FY2Pdgo+sqi1XLIXgMuL8yx+mSVaRdkehuDatFuF4KB6IHla5qu/AxPqexyu?=
 =?us-ascii?Q?azCoQQshIoCHQYEA3aCV0UnTpzl9VY67zQyomu3JqCp2vJEWbEzC3HoezQEZ?=
 =?us-ascii?Q?Y8YfpBGBoW6QupBBauDxu6tCcXjNpswthPF3eETLpxM+IiA1yTs41LXjv5a0?=
 =?us-ascii?Q?gjv3uALYnjlbtu1VnoTpIt/oF/L1LIvg8psRMwAMeF4IcN44UQHiY3ba9Fiq?=
 =?us-ascii?Q?JAOjpkw3SPHNScaCp1CRFs5S3oFbbkqr8l98x58pclCVT9eK+6OXw0m2vB9O?=
 =?us-ascii?Q?vfCsukSAB1glHgeoabySrGz2JoEhBizUDlKWlrJ9EZKY+x6TPHwRvF4Fmv2B?=
 =?us-ascii?Q?+GLqD1e1qOGZeNif2cXvijKPNGKmI/6sZG+TRnI4WumUyo48DmOqEjq0m339?=
 =?us-ascii?Q?5MN38KGsVv7HVdEU+moq0Ws+WaDNwmWMRIcIq7BuysR6bf1p0mvcebCVkikt?=
 =?us-ascii?Q?8ZaQUt4eCvdNRcCPJK4hevcZhGFI33FTnKRpVHGzcmL0qrph6xmJq+MK2EJU?=
 =?us-ascii?Q?9URpqhyznhaiAD52+k+YdlR5k4u52d0NLz0a1l70iOROFG20UzHjBQ6FGK6y?=
 =?us-ascii?Q?0FECiYEppSkSjXbIn1p2CaSuqdVGpDc0e3mBmeKftjm4Lo+e9CnGGdlG8/5i?=
 =?us-ascii?Q?ddzhxsS0qLI1V/YkPNXxfBBNVl/tJdaDhupzA9V8vcHfaRAH+z8AT8hR98nM?=
 =?us-ascii?Q?+JCOU5KAAyu+jBB5gMOWoZR1+xG2dMhbKSR2UFZ1GI17bFAbtjgfr5r2pMPZ?=
 =?us-ascii?Q?cpMLNB/HC3tJc9E+pzKLUSaTT+dOYLHDdeF6kUdB5q1EDiOCEMYbZflIpbrd?=
 =?us-ascii?Q?IuXHojfPA4ljFw36UYDkAglt6p81cpyp4KW6S8dBuLnM1kTr5X8j4pzXR1td?=
 =?us-ascii?Q?CMq8CK42VaWIvDy04huw5Ub74ttdxlqrwLXRYB4qQmflpTWdEKag5tNLNpLs?=
 =?us-ascii?Q?L3iaEcAUd9dPWNzVXfQlWihoGHZI3qbwQwufqBQNOrAcxE9B0zsUMV/V2JHg?=
 =?us-ascii?Q?+STJ2sBCjpIYXqeKY39tqYNY2rMyjBzZ8Q3cby3iOFnaZyT31LPEZ+8LVJmt?=
 =?us-ascii?Q?S9I9fn8JAFrVdqUHyLswcVqvdanvH66h9jgQRACDfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZIrkvbulsJ10EeKyHCWDdLMFm0n56+lymEKSh0qXfMUezTnzQr73lt8sy/1?=
 =?us-ascii?Q?XXAAiLO44XkFcAnyQrvyEbPPGOrSQpid+0FB8TQB1hQkZN1stNf4uoqqdO+Y?=
 =?us-ascii?Q?tyhqr3WA6jatydwNQrAebc3PtkFwBJUJ1vsGVvLUKs53TbzQGC/fF5TS3hPJ?=
 =?us-ascii?Q?LTZuDX8014k91T91bBKKfs0OqYsa3tFp+Fr8xxuHKcDlWwIMRqsUteghgnos?=
 =?us-ascii?Q?uUc5h6PA0/t6xHLKo+0wJ7zkb7NjuCmg5WflkQfpwxgN42jddX+Kuak3b8Xx?=
 =?us-ascii?Q?KGHK58As1UvWZLnljSen6ERaarzNaJ0YG5RvHlpzhIezVQfAfb8tvnsawBei?=
 =?us-ascii?Q?FqEjxvsnScHRnAE8Ehqyiu0VIFuEEMsDWtVfltCWRwUz55Tv7oBJjKXDaeNy?=
 =?us-ascii?Q?p5WuxOuu8ZWtDNmddWzKy+Kms3N5WocGBPuweNQXsVDK3CtkiL1r6xlXdksv?=
 =?us-ascii?Q?Kxcn9qhJYnkwCoY6JmggH+lMIvOKgYa+DBn4+wcVb4C3GBvtG8dLi7l5Y3mQ?=
 =?us-ascii?Q?xavp+11Dn0RSQvT1ko4swu8BUuabxLMVfY5B3vUAc0hzo2zvrMcNjdOFCcsq?=
 =?us-ascii?Q?RJuQCknW+pOjTR3wSCSEeGIfyo0pdbDIsgjZ/GFFsHxXWOgvcogUbZ3iNA8j?=
 =?us-ascii?Q?paoqGuxm4xYsQZIa4RQbmnta99pvsVtDHer5/lxzSCKtazpPoc/UEjf4qhlR?=
 =?us-ascii?Q?k6MoZsqoKAUizMANtFZULzfUEbKwjna7v8d0qVPJnFUbiogBHjqOcvf7RI/Z?=
 =?us-ascii?Q?UUpItAXGXjbtdVPeMTl8ifZZPueJxLjLIWBLSOuDwyBtp4syPtLJ01vsRqyR?=
 =?us-ascii?Q?O1GUbzn7EARZxxyP7TsD07hPxdbEz7BPijAnnNG3Eo04XjxonFIb/AdgbVwy?=
 =?us-ascii?Q?B3VoY9aSLcGra8bgt1YMb1HO9P1jmw0kLpfcHIMCU/Ojat1K5G+phwzPH0PG?=
 =?us-ascii?Q?AZvi9AMks+HoEx7fs0hbFcntcGQvBfhVmtB4LAk6F6wwYcszYNJXx56NbVK6?=
 =?us-ascii?Q?jmFLZ2jFT63GberXQpLcZK/SJg9Df5Sg0Zf8N72sP9IOH3wbTfckqVDAvKiW?=
 =?us-ascii?Q?PpJohbuyXOAotBtu0Hd26qgJeq3dGgDSkcqwXKUIwnFhxQ6NY6g7cppkaheD?=
 =?us-ascii?Q?O03NnN3SoSiqkZrREx/7Mr9N5PJpblzTP4uuhwoqq4N1+Tl2k5wNizNcHm1o?=
 =?us-ascii?Q?y7/MoMkvkn5aOKExzsw/1PtK2jEpd+w82FCo3kvLge4Jfu0hMOcvVWEmeB/O?=
 =?us-ascii?Q?4KnEseElC2wE1BwYnCRX2x137VgFHpGitiwzCYAL1rEdsdr/HsDP+oP9uaHy?=
 =?us-ascii?Q?y2PS0vN4vqugAmPt2rlMVeopJjLcgWohCrsVadJjeaqBW85yIy7hnVYgC0Pq?=
 =?us-ascii?Q?g3SEHK/dwtqD8ULOqoPEcBANLFZeBARQqkxDQB8fZKPsaAcy/uQotZJJ9QqR?=
 =?us-ascii?Q?tCy+KfpNPNmHvXoT6QjUeOCz6lEtjBdTUkhKBI6U3FPHw9THwC5lXczkqrXz?=
 =?us-ascii?Q?KjVH+fyAr27j3jupSUU/HJQyOrqASPGlAa3pOiaoXhdnKKhZrkM3k1l3lhqq?=
 =?us-ascii?Q?MtMiraM+rcC3hvO3ZqiJPy2Rt2a1l0M9Smhxx8vY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f295082-d324-4626-f7e8-08dc64fa1cfe
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:34:17.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0G+9pPnkX/OJhDqFZa4dyDaL+jh3ObAic8Nl/ph0IGmtms2+H/GmwIrZJYJl3BvK/b2N0cn3FcoSW7g7dQfoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6675

On 24.04.24 10:46:44, Dan Williams wrote:
> Robert Richter wrote:
> > Some fixes and updates for SRAT/CEDT parsing code. Patches can be
> > applied individually and are independent.
> > 
> > First patch fixes a page fault during boot. It should be marked
> > stable.
> > 
> > 2nd patch reworks the code around numa_fill_memblks() (Dan's
> > suggestion).
> 
> Just squash these 2 together. The -stable maintainers continue to assert
> that fixes should do the right thing by mainline mainline standards and
> let the -stable backport process decide if a different change needs to
> be made for older kernels. I see no benefit for tracking 2 changes for
> how numa_fill_memblks() is defined.

Ok, will drop #1 in a v5.

Thanks,

-Robert

