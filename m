Return-Path: <linux-kernel+bounces-98895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ECF8780C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D941F221F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11713E46D;
	Mon, 11 Mar 2024 13:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFDxgS5F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6A22064;
	Mon, 11 Mar 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164556; cv=fail; b=J6P3yc+QGE2CQlKUAZd7QtOE83tiGc07gxZIF2q2O2rFXyo/wLCb+fxN525h0e2rBJ7nB0BqfY8EXH9Vn5t8ilM6RZWsZWH6B69xorD0ZPgn/59sTakt9xUYeTPnTpH5sdqtoknNpnbqkvKQUezFqIv9hPeRPfCPHnlrrEMk47s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164556; c=relaxed/simple;
	bh=YnvffqbltPrbJ+jEifZwuwOPgvGLXOtkv/wTn5tw0N8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6Cc+JV6TL8sbbJL83HaVwLpxi3+Nk1WjGVWibsTDQk2iuq/U0EvNUGNVKmdJMCNVpcvHcbviK50jlde2i3cdbVxW2xuTBXIA5DBlgx4Llt83tcBkcJsT2h02H9LKjaNIurRDwvLeEofNbiNFcqZ7JXcNFGieCVJTtGqZjPUTkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFDxgS5F; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710164555; x=1741700555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YnvffqbltPrbJ+jEifZwuwOPgvGLXOtkv/wTn5tw0N8=;
  b=hFDxgS5FxQ5ccRRN/43Qq0qpeeyo8Wj9yKeCSKwEF8OzSSXn0YjdnEe5
   miYlx3R1KkCsT2kdDS+TNocgWcxRIy5rigV/zZtFyqkjp5W2OITuBnYkb
   KmJ4k+QnorBO7Hka+OqVGvP/mSo+jrObydG31DdKpKn/6V1uxOvcTRump
   AbZcXsHcc5DWf+uUhjkkrtulaDGvNspizXbWoITcI0sBA10xUjlLXuYzK
   2fUa7fFq+wWlKt2xSqxWPW5XrzH1Z5DJqeg1AHeE05u6lrEfoGOGHLEQK
   qzyeORpMpMRQ7xLMMo2pv+TnOcdPU4pB7LaQkkpoMzShip5rVNf00z+nC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="8641300"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="8641300"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:42:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11594773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 06:42:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 06:42:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 06:42:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 06:42:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh2sZSgbfIZHRdCNlgjoL9AC0AyOxAwhBeqqfTu9EisNdUdhNpXQXnIqd9gQ+hjEBW5eS3AH/OUBCg7cUC0D8LDXgALcbMwL6r1dbFh4U0X1NCDrfBDUFttcEvIOpUsLTxRVBkh4WNG+iCv5zu+V6RpWTxTR0SSFSecRdyEQxTV2ZXSM+072HXoEQ/jVb5cAqxiAKFLX4hvFk6LEi1holnCeKaKx1SMyd015nzzzN4J77X9S/UME4aMupiGBqodPis9vZdiI1E2bF9tVaFeOVMdnFNHnmjpcBbt3JiptnnKFz8iIHpA32y8NL3IXrS9ghz7Rd13yPY2vCz1UFGTLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM+CVPbAEsqqreGTXW1gow2JpmS4LnRXejaQpXHQaJ0=;
 b=jOjuEpdKqlQeS+LMDVktsNeyxchmZafFZR7su0qM3/5RmR0luOJaGpxpmIJ5cC0FiZ0drnyLdrwj1l72Z//jJtwT5/T6WROhtmaYzIqJrXm7vSJfL8NIAidBYulCKGKynpWDdJHNDGAfYIR7wGD72h2sEZPyRVGAxTKLG50LRNMjmLYNXd2WL67x57clz3hR9awWV6H4sp293MJlvOuODWD34q3L6bh9vRHgkSi1TbFYCM9NVsVTLtbqgVvc30SncCqBVpYAKIGV2YNL5jUQn1hQS4TPTLAsYTeCzFs+byItUiPmW2vEMHMRp82fA5h1J6epmgkhW3+zdXNODfhcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB8210.namprd11.prod.outlook.com (2603:10b6:610:163::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 13:42:31 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::618b:b1ee:1f99:76ea%5]) with mapi id 15.20.7386.015; Mon, 11 Mar 2024
 13:42:31 +0000
Message-ID: <6568ada1-7fee-457c-871f-b52ee3f7c820@intel.com>
Date: Mon, 11 Mar 2024 14:42:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] ptp: Move from simple ida to xarray
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>, Jakub Kicinski
	<kuba@kernel.org>, Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <thomas.petazzoni@bootlin.com>, Richard Cochran <richardcochran@gmail.com>
References: <20240311092101.1114687-1-kory.maincent@bootlin.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240311092101.1114687-1-kory.maincent@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB8210:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eb70e1-7941-4297-ea91-08dc41d11974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2bBt1ml8oruh4jlJsmiI4qkLpebXjhCxbAS4g9xhEUZyOeOLo7qNIEh6S9vQkfc9Bpl7PZhUu4EQB7V48VnLEO8ZeUpUOE5ERwvrO+LL0fg6XvIBcnb3kSu+ay6rH0a+K2OMvpEMDs5veOOOUVYoeRs1xckqw+bI7ggkLxKtu26g6tVo4nzJoaQBLjwL1Rb4arOg3JfRQyTsWSCR0A9spQUQnTRJVUwdmUQbGTeHAWupmf9RfHZGxKl6GxrujETMBZ1OpwDoi/2IBLJKUBQqpYxdbv1PKSd/HC/dzHgB3I0kH3tE75IAw9BpR8kwQaAt8p6z+BK5xU6ujUECAID/jfIy0W6cNQ8iEpjd9iJx/kaNJUU9EcXfG+TpQwk3bQQ5iW9EWQvwznkYrdWEH//t8HSJ+Po3t1ANVvSH1m7MEDZv2hy8N60CCVXHjmq05sBdPgZCrbhQg7WzWgPxF0BRrui7k3wEBuj0F0eC2zD4Pa06pG4kFn2F6KvBSwnZpsTwevDp/+UNM60G70KwR/AbCW1KoJNReLmAl1MRSY/hE8f291rqWWpKP/Vo6KsZe7HIrlCr1bEBHMv08S32MZYjWRF2UoQyQX0vXK5TqEOTnvAHKXL/nAcegz0RJFyrwUdCXsp6Bd5/3LBxmIsvMJRba46uSg/aBF/qdXEjrxzyWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpLWjBFS3dPNU5uUmdZcU9sSVVYQ1hzUWluZlB0aUJZNUc2a3RRSUIydFBp?=
 =?utf-8?B?dHN0bGNWdTFCbTVEVHpqcExSYzVJbCtkK0FydnA3QVFvY1lSeTVRam1kcytl?=
 =?utf-8?B?MWhIanY1blhud0xSTVBENmhOWjJLNUNaQWxEbGZWQnlnODgrbVBTalBtbElv?=
 =?utf-8?B?T1pHSkoySTdhL2luempUUTBxTzIwNWpqSXZhV2k3VHNlTXFCREdjcGhGaUFi?=
 =?utf-8?B?Q1lIUE56dGIwb0pxZVpRNVM0QWxMRE5uRmpST2hzZm14Tk9PQXlhWGZNN0F0?=
 =?utf-8?B?T00yQVlTMFk3WWFMN0FYQ3dKSExJTnJMUWRWd1JFL0tpN25SNmRRUHFrcFVx?=
 =?utf-8?B?MmtFN0d2bmY4dXYzNHFOSWxwZnFwd0wyNWlTY2NnbDBRL0xnTy9Rb1U4dG5N?=
 =?utf-8?B?T2ZIR09iVzNHbzFWZ2lkTGhETnc5L1NMczlQZGJ2Y2RWYlE4cHNxZEYycktX?=
 =?utf-8?B?T1NIUmh2aWRIam5DcDFmVEQ3K1RlU3VCQ1Q2T1RUdk5IQVVjbVJBWXJYVVdy?=
 =?utf-8?B?QUR1YVNFNmZzQmhGeFVwZ1B4cDhoTnBsSzJxa25XejQ2VS9NdWl3cndmb2xl?=
 =?utf-8?B?cVk1aE5PMjQxQWg3S0M3bFkwWXZOSWcwZm9IN2lWR3dWdllsaXRQMDM3L2wr?=
 =?utf-8?B?RUFhWDAxV2UvM2FWc251QktuTmFkK1RRY09hUEtzL0VxUUZxeEU1VUd5UHdi?=
 =?utf-8?B?b0t6a08zc0h4RGRGaThORTFXb2NEMFhKa3NjbHNkeUZPM2xVM1RmUUgvVzl3?=
 =?utf-8?B?blBLbFFqQXFJcDJ5UVhya2NRSGRkVlhyczIxc21MbHhwMmtZZGR0WUVWU01Y?=
 =?utf-8?B?U1B4ZXBaZXBaU2NPOHVJdXlET2kwZWpReVhVWlJFeEswenBHTTlpK0R3U292?=
 =?utf-8?B?ZEEwQlk4V0g5MjZWWExCSGw1RFJzTjVSLzhwV2tha1oydnRrdjZtSWw1WENR?=
 =?utf-8?B?TU03NFh5emJuTDhBS1Q3OTA2eXAyTGRtNHk1V0xLcEVvRWU0Q1Y0R3BaQTdv?=
 =?utf-8?B?bVp1cHJOdHR6WXp1VWJ0VEI1eWV6N1dJWlFsc3dqejltVEE3b1lXeTVRZ2ZO?=
 =?utf-8?B?SENiQ0pMYTZyQXhOMHRWNFo1dnEvSzRzZGpjem5DemxuemQyb053MlBiTit2?=
 =?utf-8?B?UUZsMkhKdEZ0YmRtRU1sSDBsVW5JK2dEbGRSOTUzVmxGVmwreS9lU2xDV0NE?=
 =?utf-8?B?Sy9oY0NsR0hKdW9KcVVERWtNQ1NqTENOZG4zcXIxdGlaSGlnd0lCOVpDUjgw?=
 =?utf-8?B?T0xpZFgvNkJsY25UU0dSeUhYNUhnMlBVeHM3T0wwUDBMZ1RQbi9WTXd2YlZS?=
 =?utf-8?B?ZjI1TENLWHJqb0xLRFpOR0NjYmI1WTFGajNBaUcyY29RSEg4S3NEWE5nNjQx?=
 =?utf-8?B?TEhWNGtKV2N3ekhtQ254NW5kYWZsaVFSdEszTFFTTS80Y3VXMzZQQnJXU1p1?=
 =?utf-8?B?MlNMMlNxc1dQcTJZVTNBT2pybFd0N3NzQS9lSHpzQVdJNlRDbzhSU3FBdFRl?=
 =?utf-8?B?T0NPRUJVc3JudTdJR3dFUkpDSld0T1pkcVJ1YkVqQlNibitMZ3RrTzRoYUgr?=
 =?utf-8?B?cjF6dkZOWDM5WGxnNzI4QkloMVZ5UVl4djFyM0I2SVVsQXFCckRuOG9EbTlv?=
 =?utf-8?B?b3BTNlNJUURXQmdUZ2hUNlduZkcxYzZIa2VPeER4dkRCMGJxOHF5ejR6SUlG?=
 =?utf-8?B?eUd0Nk0veCtWKzYyRHJNSmVNZ2RIWDNRUExYSGwxQ09uQXR2azNoWlA2VDls?=
 =?utf-8?B?U0dHS3hWdzh6cHB0T21jc0pFN3lhbzRGa1BzR3d3NnpKMG5FLzZWNVhXbU1t?=
 =?utf-8?B?aGRkclNxVytKWHBkVExvVVQwTk9xUFNZOUU5NmVxUVA5VzVWWklJRVB6VSto?=
 =?utf-8?B?THdhWDdzUno1WGZER1BScEp2UWpiYllZNHM4RlF4MmhsVnhSaEF3bUFOOFlF?=
 =?utf-8?B?MDJHdU5lTTZMTUhqTHN6cHpnbVZJSUkvSlZ2MmdPa1RlcVZYQ0QxT0Z3a1Rk?=
 =?utf-8?B?bThKanZsbUcrM2I3QzlvYXR2R0xvNVZYYUdDeTduNXdKdHhWT2lmdExUNVRY?=
 =?utf-8?B?VWNyb3loYU1nTkp6Zk8yVjBzcWJMUDNMV3hMYXg3NmdxZGZNazYrRWx6NG9D?=
 =?utf-8?B?NTlJTGxHaHBRMkYwT21TcWo0UHJURFlOUWx4NUdlZHArbFQvSC8xWlFuMXVt?=
 =?utf-8?Q?v+2aHAijVlFzwK0a1+TsnxY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb70e1-7941-4297-ea91-08dc41d11974
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 13:42:31.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Ecn58TRD5UMDq8r9sieV7RjMFfqXT2XgV58P4HMpuTjgtA8+KxLv3Zo0gk499gzSFMfcmluMejPsEGBArRUlA2T02vVgmjigK7t63xPjno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8210
X-OriginatorOrg: intel.com

On 3/11/24 10:21, Kory Maincent wrote:
> Move from simple ida to xarray for storing and loading the ptp_clock
> pointer. This prepares support for future hardware timestamp selection by
> being able to link the ptp clock index to its pointer.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Change in v2:
> - Update an err value missing
> ---
>   drivers/ptp/ptp_clock.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 3aaf1a3430c5..9339fd475df0 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -31,7 +31,7 @@ struct class *ptp_class;
>   
>   static dev_t ptp_devt;
>   
> -static DEFINE_IDA(ptp_clocks_map);
> +static DEFINE_XARRAY_ALLOC(ptp_clocks_map);
>   
>   /* time stamp event queue operations */
>   
> @@ -201,7 +201,7 @@ static void ptp_clock_release(struct device *dev)
>   	bitmap_free(tsevq->mask);
>   	kfree(tsevq);
>   	debugfs_remove(ptp->debugfs_root);
> -	ida_free(&ptp_clocks_map, ptp->index);
> +	xa_erase(&ptp_clocks_map, ptp->index);
>   	kfree(ptp);
>   }
>   
> @@ -246,12 +246,12 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	if (ptp == NULL)
>   		goto no_memory;
>   
> -	index = ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
> -	if (index < 0) {
> -		err = index;
> +	err = xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
> +		       GFP_KERNEL);
> +	if (err)
>   		goto no_slot;
> -	}
>   
> +	err = -ENOMEM;

here it looks weird (even if technically correct),
I would either move the err assignement down, just above next kzalloc()
call, or refactor function to use the following idiom:
   ptr = kzalloc(...)
   if (!ptr) {
       err = -ENOMEM;
       goto somewhere;
   }

(it's already is for @vclock_index field init)

Otherwise context is too small to tell what is the reason.

>   	ptp->clock.ops = ptp_clock_ops;
>   	ptp->info = info;
>   	ptp->devid = MKDEV(major, index);
> @@ -378,7 +378,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	list_del(&queue->qlist);
>   	kfree(queue);
>   no_memory_queue:
> -	ida_free(&ptp_clocks_map, index);
> +	xa_erase(&ptp_clocks_map, index);
>   no_slot:
>   	kfree(ptp);
>   no_memory:
> @@ -511,7 +511,7 @@ static void __exit ptp_exit(void)
>   {
>   	class_destroy(ptp_class);
>   	unregister_chrdev_region(ptp_devt, MINORMASK + 1);
> -	ida_destroy(&ptp_clocks_map);
> +	xa_destroy(&ptp_clocks_map);
>   }
>   
>   static int __init ptp_init(void)


