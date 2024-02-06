Return-Path: <linux-kernel+bounces-55211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3047884B932
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548961C246BB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611BC134742;
	Tue,  6 Feb 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkKAflQg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5BF13399D;
	Tue,  6 Feb 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232354; cv=fail; b=nZDWZT27JMMPIX3H+cMWzsLFJwoRLYZoqxnZibLDWz4FcTgVdHsi33eQb3qCFXdgu8PDZm0psdpzBWiukbPQjlwJjVhKpboCf1ztjrwCyIqJVB8qK7xR8oxRwFTLU5vOByzwFC2avVEcXwGV0A8LCIzLawbsjKbMYTOEIvFK+Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232354; c=relaxed/simple;
	bh=zV1WHJwgDAXbqFSO0WYpO3ORYev/EuPUG3NfxQePLJE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKE0KuhK3TGieVM92S6tDILL+bdprAMgMR6ZtekW0W81wfHQoWmFHTmzIgr5GQK5agedro7sACNkxRlQSCi/Lx3QgJLFKjmhCUXv8CupjspVgGqRDW/eHAFSPNy+wiMFV4ermexMosF52Z1lDjHZOQ7GYA/A5RL+ZNhvRGX82Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AkKAflQg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707232353; x=1738768353;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zV1WHJwgDAXbqFSO0WYpO3ORYev/EuPUG3NfxQePLJE=;
  b=AkKAflQg2to/faB8TbLJUFiiew0gff8PvtSbLpjinzC1441b+Q+r75My
   tDXof5amNRfBQb/8RhYzQs2TbtT55E69jQJzYym6Z2nT8yctPTyNZ3MKc
   DgwRK8trDKjftYcDOAsTBpwAeUeP5HdEXxYD/F0QzuU/EIOUfT/5xmqtV
   sb38yg2wYRpyGs2y3WJDe9AhQTY9pgoVk6ZHsopvyW8Go5ToHZ6V79s5B
   wEKmcU7XA98/tzMwE5bdCnuWGasCh1pEtzCkQ9G0WyCl8JTbdE/yfXbe4
   NzToXat8724tURWqFelGpRsiT4tlG+a37L80DyIj3CEdoImJ03PFvB9MP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1037499"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1037499"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1360595"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 07:12:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 07:12:31 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 07:12:30 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 07:12:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYgyf3Ffhn8rQWAWAlBrOslFti7UVrponkQ+1wO5t1UfdaNScEaD/gOI0wJ6XCOR65GpAE0NvdcSdQ9uSjYa/4kqzEg5B3of4J3c9J6viYi8/4obuiBVPXEjkcgZzZucrbt83gRJawwceWzuonimN753+cV9G9Lz3pIcMAAoUGkH7K99bSxmDPqLB3JQ+EsYl1Do4kZAMzQ4jQKqqXPoaUt6nODD2VVpapsyAH1lzO3AkaVpDIn+PXO9gOjqRVZRkauMjn3bRSHSS0d6gqqg7meLBJ4YWpIqoqD1rri5GZ67ytbuo061rHqxRsOqBg0MCioYn+oh7XKIEzb/J97IIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvqrO9V+5VoQTaKeYsOWwrUQQjNDFns8bpPmpyGbiI0=;
 b=nbXnYzpIhHlkI7Szyr2TpgD8Kwmudsm2jj4O3Gkff1nVdw2w/HPfl0UilHz7Sk6POSyOO9/WreSlqK6FKXx6sYIG/XyUhEy4nKjaHQyaSNApBwKvM8uFEs/1NaqiF0z0okGheCXYX6EwW57PpmRH/wnmxkaNxvlcSIDABI3p3p8FsRgyvBT1qdvX/OwgHwKlE35lsgePsQ9mYo9gEyH2jGY9IOhS73cXNtHUQePRqfe1PWA45izphCz8FzkC5//QLA0IQVJbwe15uMMeAUrvdvWxuGmVDg8O2+e2gvS0YQmK4g76/MkuMaZ57uIkBqAMXnTQKIQRmAMYqdtizITmsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 15:12:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 15:12:29 +0000
Date: Tue, 6 Feb 2024 07:12:25 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, Ira Weiny
	<ira.weiny@intel.com>
Subject: Re: [PATCH 1/2 v3] cleanup: Add cond_guard() to conditional guards
Message-ID: <65c24c5915370_38985a294d3@iweiny-mobl.notmuch>
References: <20240206121301.7225-1-fabio.maria.de.francesco@linux.intel.com>
 <20240206121301.7225-2-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206121301.7225-2-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB8384:EE_
X-MS-Office365-Filtering-Correlation-Id: f126414a-da03-40a0-258f-08dc272608c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGEM+tiR8NZ+PeixBuG/7WFjdc0PWPZaTpUo8LWDHHP/8W42U5o2roilzDN8UNl25fKK85KRjMGQB8DimMlgzAfjeLhCYfyWVNp6ipK1ZDNLPmy8qiRnE2xrmDn0eIw/CCpswn4bKrTQhBfTSYUg9wtxtG0NFwQv6u/+Zd61YW3LLKEj8O2MB1GF6JdOO74YwSpzZUEiOVYhZDN9fjtoxz0IRJoqJBPnG+Su/+TwZIsqS3kqsyGNiKVUgDV9NBfiC3f682Os+xEd0VJnuqR7iT0dN4xgBgVYqBzkBxCzQqACuDTljZmg8ZC2eiKKypr2VNL72tkkVw/WIVfOlyYEa1KEar+rjE89Ugx1tozaQPk7upExb0gbHuRODZ2FePreO/qzFNd8zFQbDcoPej5XEXoDDkGIJqXgKyROGZ37641dh2aU29ixl9Ech2PHkbUSNC2hVj/BolUhHqqtw1t0PIcHddSJ8wo7L+doO81Fhwv8jrIu0OJAhmT55SljIaL+f8n31rQcZeQfgobiB8QCaqG/QW96oGylOR5KsH3vRs2CTwo891FIpEAB+fbTz4/P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(110136005)(66476007)(66946007)(66556008)(316002)(54906003)(5660300002)(8936002)(4744005)(4326008)(8676002)(2906002)(44832011)(83380400001)(82960400001)(38100700002)(6512007)(9686003)(6666004)(6506007)(6486002)(86362001)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKGn4sAlvNH+NSNwPK3Rt8C7ChnYGq46XZLC+Ca5RBTl4Su0EIDbNdcuGhFg?=
 =?us-ascii?Q?VI7UTK40V02r3jsYMdPheX/iZFGBpu+DbXLMGDuUORlJsml0MO4u2G7qxvDJ?=
 =?us-ascii?Q?N2J1pCbfK9v1eVirfwa9up2e14cKEmiwki5prJvwIYjFHPH8Ee6ruFsBOYQ/?=
 =?us-ascii?Q?GxwmB1XNi1z/AbVhG7LEnKTmGVaR7lEYetANnhYepOvlfOyq7TXkmMlVk6Hz?=
 =?us-ascii?Q?rVIxImBSOQPIsgArU5iLomo3AFiitToPHvOzb/ipmbDKnQMUjVEc7wUM0dVd?=
 =?us-ascii?Q?5m06SSP9LNQc2ffbbMaOeJBD9RIki3K96y5mFJGbYrB+RvDY+ioKq12FTROw?=
 =?us-ascii?Q?pprjGBSx8iDRq2UPAzcAQORN+oKsImd+LYnVzkAgYfjk/Zs9upYSTkZx1EyM?=
 =?us-ascii?Q?GrTKDHKADZGi+wfGTreQBNpZrvDaAVZuAoCe2jTNmJ/3Pp190QHAEZRD2vXa?=
 =?us-ascii?Q?ukwbts28hMHrk7iHepS8Q1u6UTjF4XEGqC3aH5C/7Brt0angsqsg5zjPfdWD?=
 =?us-ascii?Q?QMatUeg9/3fxW2ZH0Clm3V4AFGdwQAP2IKjOY93ve0M+iIgJpbneVP/VmRQR?=
 =?us-ascii?Q?dK4ftbFX3wtcggn6eJVVgk9jbjiHwPkRJ83USs/dy4MINF1BSdSKJuZWqrWv?=
 =?us-ascii?Q?12/3hxRiCIKh8UUuBb22/2SCeBb03g9yckCqPAC3m1vD89pns2IUQbnLj+8k?=
 =?us-ascii?Q?YiYnaS76j3IK7qlvXhGEmvPUXwmq5+wJ/9/LOYM11vDK3txxj6d5emVFKNDA?=
 =?us-ascii?Q?VNRXuTQieax/7nfiM/ocWh0Z8C/bMvDpTJM6Jh+nOcUBf4A/eOgSy/VNclax?=
 =?us-ascii?Q?oKSSLl4B8B9+R6hef+AfewwmuCl2KmW4qRff3ZqFR99jc659qHwRcsPw7u+4?=
 =?us-ascii?Q?9q7+JIrOnFZaXD4kzVZFbH4o6hbNsZ13sywoYEHjeiTP8oo6N1QHNQWwWqPW?=
 =?us-ascii?Q?XUzRQGJISMDX5SHdbs5h5XHdjdnIGtWTRyqaHz/5djQqhjoIEqDWl3gE0663?=
 =?us-ascii?Q?eMtzAYe5CIuUWnwYH0oiU6jbI4lrhUZhyYUnO9/A1vxSFH02X28gTperrm7D?=
 =?us-ascii?Q?A65Hx5FCAUtdDaQI+x5pdJA1Xgv8XohBHlJtE6d04bgXa+HKpsE5dUhpLnt6?=
 =?us-ascii?Q?j95Xr8p128uewDcYDYQuDLdkIKniooSV7e4oOwJ4oU0lRRtt6ieIo0x7L+F6?=
 =?us-ascii?Q?BKIexqbHDe49ODZUwLNdNVL0KYkNvN/D345LQd1McEPEAa3jaIQa7NgNjy5f?=
 =?us-ascii?Q?tmhkqG9SKBoh7K8pnP9PX6xpZ2DO9H2FvGfXtA2hKxxdXmVXRG0hWkAvP/YD?=
 =?us-ascii?Q?zjdP+mee130qKgBka8/dsNi05SvVaEjb544cRtu1i43n6lkpOBNpfLo3b+Wg?=
 =?us-ascii?Q?A5Zml8nes6Nvp4tCIlwM1mQ8GhuikyX6TISySZOxEAwEp/Y+V7thI/5rxfnk?=
 =?us-ascii?Q?roc4GKo+4YWaSyGKC7Pa7VqQykN8g+qOnqdAyrwujwYBqmMv/MNF9JykmdhR?=
 =?us-ascii?Q?1J9QzjzUStX41qL4bwDMjWUWB6q1qTmiKzbhk02d3b8Z1zoR+/rFUYrpuWma?=
 =?us-ascii?Q?uEOal4cFVg4Y0vzuVksafVUMPjhEiWEkAiWZRBO2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f126414a-da03-40a0-258f-08dc272608c5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:12:29.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2lh+5Ej549lhWi683MAA2G8k9K8uY4HjcrZsXFrE8mv9jhwR6FekR5PCshTvQ8fUfPwC6jCm8XHKYND3DH3lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Add cond_guard() macro to conditional guards.
> 
> cond_guard() is a guard to be used with the conditional variants of locks,
> like down_read_trylock() or mutex_lock_interruptible().
> 
> It takes a statement (or statement-expression) that is passed as its
> second argument. That statement (or statement-expression) is executed if
> waiting for a lock is interrupted or if a _trylock() fails in case of
> contention.
> 
> Usage example:
> 
> 	cond_guard(mutex_intr, return -EINTR, &mutex);
> 
> Consistent with other usage of _guard(), locks are unlocked at the exit of the
> scope where cond_guard() is called.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Thanks for the revisions!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

