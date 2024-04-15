Return-Path: <linux-kernel+bounces-144453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C648A4698
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB82B21CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00819D29E;
	Mon, 15 Apr 2024 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n4tWNA9C"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F399B4A24;
	Mon, 15 Apr 2024 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145049; cv=fail; b=Ttod4tNkLaIDRrLve0JJDcZSfRhnH3JRx37HAv/181HxBuU7vPiViLvUkvZcgLqLYNCBeqxhKfFABvFruzCCOFpU9RT65+Cm7X1TK9AN3Hy17WFO1rQ/r/TA+QgEmdM/3KJ8twGba+AWfx9INNwyDjgFBtyDHOpZcMKI7zeSNAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145049; c=relaxed/simple;
	bh=Q48MVyxUhRGkZ/DwxJAGwLPrjDAX6+eEmws6mPP/QhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tfEytiCA7RwYAXaWra+YIzzdyVMST0cYyH60rUwfTFR3+HXabu94IxasHdqxtDlgSbezhGRn2ApOiBuMizCM2Zi+4Oq93N4wUTBycIEcVhZfy+CF6b1/MDCQTc7uy6h2pj35zr0gqyK6qq2/DT6StSYsQSlxp/bw4skMpZEBGXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n4tWNA9C; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPms64NsA5n0n4uwMH4ci7FaXutKiDnTjOTBksjDXvEuMuBSfB+xDUI8Qjm2Kvd0Qt4qPvHXuMfLdvRkiiqnyn620fDeSPydpSeqCrapZ/fIK6djhNkYb5wbJcros+YXkaawz0DT8oNRJQdpibLzXc3Tmx3TYeSIkF9npfMF3AtyX6PP/9hlD7PWf+3cvxOwtNegaJrqsZOVFsvNqK6Mqm+rX5D6on04kHBBV4CLeOmwYw5i89GJYr96xPOx/uloIKHjt+WRVwbciatNm49Ol3iiXCVWyX1OKg9ly37DVDPu3gTivE0Y+JyOjU4+3Bk1iq6dj76heCCdhQ9asR3xog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2WNIijLFvvWRl+F8jnwWwluuapKuJf2WPiA/GDcjZA=;
 b=mQpYIARcX++9jd1G2GwnDcVrVUzbQ38aPdm/0j4A8wzA0XwqOMOd9Z56TnUlvuMQ7GkOQVx/eekfl7L4UKFobU6/Xt7w42Vm8XxcLYQ03LbpvjoIZvvKrNQ8tReyjsQlA1lizKjyGuLDufCl/yC0bcF4Iz9/CwX2LHMAlvlkTkrXXyakXbKW+Ck3qlZL+W5ImQcb1LOB32NpuvRC+vEYiCEilzx/KvzlbL/A+QXMOL7luHUHJ5bYMudsFrpFTO3IxWDYX4i7yxnV9kY0+Hmmr3NlUcELeYOsORdPHmvEQAvHP77oCeexbrwZ0vCuglFECkbm6wxgIhqRAzhoDJbe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2WNIijLFvvWRl+F8jnwWwluuapKuJf2WPiA/GDcjZA=;
 b=n4tWNA9CPvlqgUnAv2hxgM0VQY07B2nPRuNHOWiJMNQfR2704LJ/F/rKDms6HJzVUew/lGclQfS8rM2O9uU1RWiKhZynlcBHPJb4I/XSaNqCGdEhx0C151U0cSQGDeu9RnZ5SFCZWWl3orz8WfYb1F5+mlXSvFk2J0QEgIVTws4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 01:37:24 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::e7a:5022:4b7d:ade1%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 01:37:23 +0000
Date: Mon, 15 Apr 2024 09:37:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/8] cpufreq: amd-pstate: Document *_limit_* fields
 in struct amd_cpudata
Message-ID: <ZhyEwE3Hr8Waf620@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <6b8432f302165e686a01ffe7d1d98852d5e88609.1711335714.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8432f302165e686a01ffe7d1d98852d5e88609.1711335714.git.perry.yuan@amd.com>
X-ClientProxiedBy: TYCP286CA0074.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::19) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8264d88d-8b79-42e5-1b43-08dc5cec9948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PvwhC/0WI/uz/6fAto5agxiNkgg45O9Wl/OTPhvDzrR/Uz0I3lp650Kxj57uH89dY5OZrfx9p0akjmru2Dpe+HCsqtcMGidnfo3YMl8rLDH/0t+CaOZXFZ5/EtQp9kfF2LuiGNjo4/KQbmQbPBYh6GLiHaXe08yNBJNEv5yKN6coPy1b0M1pF4TpXovNz3Su7s4894eEMStX2OSmdQqu7mj9yKFYjjQmOnp+n2iPtEdntlzunWFtMpqwtbY7BS9FXRX1930dnJunho+RmkYiLf4JvxvjIBP8Q6Fx6C/UC1okVDYhxgD9C4qM2ZzZ8A1YOAJi0W6DOQRsvsO0YgHnSoPN4dtxyR7Ytpd1zfjg614dhEu4aHqw0ASeg8li+yYFTpAJuxsW+4qzkgHBLrmbORXhs2Q/0hSNDEs1xS+uRUuHvQ4KDPIFW6xmvlqThQXlfIz22ogPm6G1UPDOFIMhBOvJsNXWkoClPqO93DHe27UOHutG81OQwJUr0VYENB6WlWSJAJxQL3SLK3RnA6A59oK+YebEa8QUxJYf7N4jvZJVLWEjzJanl9Jo8fE4lV2vOOTl+t1IrMgEoXCX36Fk8Y3SEIBLxNLzbQOc8ViyJ5H8xwSzh8HS0H2ktwGemz6kOridlIp66QF7UZQiJQH8c1C/hufyDGOCm675Ncr/4wo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tOVt2nUr663nR6sIScdyzOhmT5hJcYOj2Jttw+Ke7nRHbzuz0qMiGswCTmw+?=
 =?us-ascii?Q?WbPfg10e9OCD7Fn5eDRHgjCLeGVTFzKMcBm3nSz94bA2FqAXuzqePOXjQKmK?=
 =?us-ascii?Q?A9b024pZGjZWaS4QseS00KJGZUq79kYs0RSnJ/tcclRIKssu3dWodSRyKMnA?=
 =?us-ascii?Q?fS/Rgor2mS/0JIyoWiEVNU+NyVu+2psuHwpHVH+LRxQjr54qb0PK06abG2+8?=
 =?us-ascii?Q?9u/VqG14IEa1M9eyK4B66G2Od6oXJPrk7SV7wb9qh5jFX68fJpCxuks3CtMx?=
 =?us-ascii?Q?b8vDQZMJnB4F6AiVMNjTTzkWQwJ6+ciB7ZJeBh0aS3JkxHXipDVO1LK3KPCJ?=
 =?us-ascii?Q?8G/1C/3mtpt2JnrN0lX/4Yp8DtEXC+dxraOpQ7CTFZmJ7OHn+PrLuNPkEiry?=
 =?us-ascii?Q?bAHPU5CCalqEVAngDcfwrH0Njg6BjPA3lyZxG86AWsk53no0nSnfPnVuGKK8?=
 =?us-ascii?Q?wWGUCItpSEvrMVeRYI5JWIg1811AKN3HaC9E6ZvF5XkQ0oqA5zRmegkEtR++?=
 =?us-ascii?Q?d/VsA4kE0ozXg30snUr7we/2mknToBjTQzvBdzo5r2hJbQlVICkCWxBzlfhx?=
 =?us-ascii?Q?X3A0xniFNBzAFla2mHfNbWkLkUE0Jlkqs7za4RM+2jf3uPcK3GMiR6dSArjh?=
 =?us-ascii?Q?5UKriuYWaezAzmWW+QNPGdzV2ISQtXUgs8+OZZhAAtgRjJ4mjZqwj0U5sEzh?=
 =?us-ascii?Q?JadW0VapkY+dhCDST9cBwdUAqKxarIFHL9dIpEZe8tQlUKhdn2PJqXuHBvQa?=
 =?us-ascii?Q?DpccSxDIXBA68zVEADPU+MwPjygb6Mq3NRvROjhxODjhjRefvO14iImyiKbq?=
 =?us-ascii?Q?kPci5j+9m+o12Ngc0XOQC03lvVEDZxJ8BCTwSrpObOUg333riak7ClmxpFyC?=
 =?us-ascii?Q?05gnBMaFiM8L1jShN05cOeie5E5FeJYxalipmkn+ZSDxt3KjnS/MOBEcXOF/?=
 =?us-ascii?Q?M3/FCawKz+RTkOWly2L3gVYHZftVzMpzb6bIoZWTCU0NHH0jpUSqOIMjaB4t?=
 =?us-ascii?Q?ZFKGaETR6+2k+vLM+WQv+RebCvKvVlXAH4bDdWUImSK2mS6o2hxK8M6zRVKE?=
 =?us-ascii?Q?h5hwZFh53Y0UK8azshWD7hBp7muQWpjL7MdOr+DTk+7NQxkNxbmgQOWY2cUH?=
 =?us-ascii?Q?D6rcx/Etm9umfTje9afB9SnqyXOUGM40gOjwnCkJlk4Qxyf9Q9YmBS1BAo4H?=
 =?us-ascii?Q?Vq9WmHjfZ3OeYdm93saSeXwitEhWePRjn06LP0e7PTt4x4aTMviqj/OBVRfM?=
 =?us-ascii?Q?x1fdS1b6KFgQUwylyXWLGKP4g9BcEqOzUhTmlyzZScUqgX9IEq4wpxDESfYY?=
 =?us-ascii?Q?5EAqKlRbP0jipY6wBE931AWBnMpnvpQJzBDfkwiyVMoMn3cBWM1gTgJ1gKdS?=
 =?us-ascii?Q?0v4i70gMZ+uPNotw04E2+ru8Vz5YKdRvfoiq1YECi1Pd5jf4ETfh9KTfDncU?=
 =?us-ascii?Q?BwQQj+mt2C7WBSy7bxMguW7djIacDO8jbJVrEjkUybenxYfC3E0+tCbUkMC3?=
 =?us-ascii?Q?zUbVHQCX2+WiRoJuCWRWor3rlqcC6FFRuILsiqocdvgny0qhXu9TKLmunWd3?=
 =?us-ascii?Q?YS3QFGn/DY5eyYsx/2Xcz1ScnQsaO5hwbIpATfup?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8264d88d-8b79-42e5-1b43-08dc5cec9948
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 01:37:23.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWW4Zy4Lnh7RJl0kTbl4GYUJQT7e4INSPoLOMklKL5piWDmC4WmBxvNIrwNKGDFoHQSQJVVbKEIWtBxtQOKVIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342

On Mon, Mar 25, 2024 at 11:03:21AM +0800, Yuan, Perry wrote:
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> 
> The four fields of struct cpudata namely min_limit_perf,
> max_limit_perf, min_limit_freq, max_limit_freq introduced in the
> commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> scaling_max_freq update") are currently undocumented
> 
> Add comments describing these fields
> 
> Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
> Reviewed-by: Li Meng <li.meng@amd.com>
> Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  include/linux/amd-pstate.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index d21838835abd..212f377d615b 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -49,6 +49,10 @@ struct amd_aperf_mperf {
>   * @lowest_perf: the absolute lowest performance level of the processor
>   * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
>   * 		  priority.
> + * @min_limit_perf: Cached value of the perf corresponding to policy->min
> + * @max_limit_perf: Cached value of the perf corresponding to policy->max

I think we should use "performance" instead of "perf" in the comments.

With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>

Thanks,
Ray

> + * @min_limit_freq: Cached value of policy->min
> + * @max_limit_freq: Cached value of policy->max
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> -- 
> 2.34.1
> 

