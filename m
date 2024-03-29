Return-Path: <linux-kernel+bounces-123934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A032890FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D101C224AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE01118E;
	Fri, 29 Mar 2024 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eq9XhPyu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6746A92F;
	Fri, 29 Mar 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674111; cv=fail; b=spZnvjXKVxKQMMbtCuNN7kY3SUHvWR7pbL9DUauGJ/d1Zh/PhtWeHkgafS+WLtjco32ED+2ezIwHt261SOU27qMEewDWWL84I6w+Vk0Vs9DbLmLadMW/o7H4jdnbEa+H+IsE0SWpK0iojNR3yJdrHY+Fs23F+s3rkakP9lmJrsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674111; c=relaxed/simple;
	bh=JpGSVaxTdfucNAXMncj/SI+ZXI3/NfFtMRIBiqwMbK0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hCgz64AxYvN6roIG8yn8wolZtnChjBcmBTX+YVIzjBPlUi5R030WFFw9zMCV3sUYhE+AVqklXfCF9G/zVTBWk9N9adnU2tECM+ney7yfkmsT/wAT4zFQQFlseEOpWwXXrjlrEYmuEQOHPi9WV1nhkHS88dIg4rDrVUFoiYFTQsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eq9XhPyu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711674110; x=1743210110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JpGSVaxTdfucNAXMncj/SI+ZXI3/NfFtMRIBiqwMbK0=;
  b=eq9XhPyuAuiqC+5DX1zrZnh5UFvZy1DC0lyN6sWHPogE6egwBGXToLHX
   KbE3PzHsZiLp0K3GqD6X+inTnz3Ful0sDUdOqTKtulRao8aDa151UGA5W
   AF3hhz/DJvIrrjF8VfpvdaGcsyeK05njJnIQwdL4tYbPA7LfW4fjCfclF
   dVGIvoEMZm6Rjv9diPY1ZI57UEKqa/TQ/w7jSKbEg5bW5ggrAvjBK/Anx
   1P92XtHlF2ZH7nixv5776dzOG+UfCieqcBCrgDh2psxgtQzp0m3jZN7U1
   EDRiJqSJ/fW0/6TGZSBjFHwjSUQglkLYZbxj1l7UBT+vmGSDIN1inNlD4
   g==;
X-CSE-ConnectionGUID: DTeDCt9hTvmh/MEvfuz3vA==
X-CSE-MsgGUID: Kk1mNhvtSD62r34CQHI6VQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755631"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6755631"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 18:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39984175"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 18:01:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:01:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 18:01:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 18:01:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 18:01:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGkUOf/809C24pFkhBi0XfqrllEEJCY+JTf97RBAE0xYQ6OraI4L44CJfcIneA/FQODy6gKqa+tGSRaxGruk9MAX9B3iVa2yaw+JSi1rERoyTJvGHUy981CYVgG9/Xw+bnv+WAKW9ClhbKwWv7Fks0MVH1/y3cTmU9AptoYUzpK7VJ+QJO4oFJ6tw4VxcSv3m73eIEnTz/cRb2FNLQZtZMeqP/oaf51SF4iFhCV9Ut1kFLxoSWBljW5CH482//t+79oxF8Kavlzy7H8fyDBVeR7Y+7S/eFHOENyl6ZqZa9F/UwPgJr+M76nffL7UNQPxfKgiVy9mWlUfIV6jzmzPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0Jlymicad04FIHG7PPbz2MhAsuruWXK1JVT1gqPCTk=;
 b=oQk0El4t3sHw5Lx25e36U/tu4OpGc8uFOrqegmkEic4Q4ANrUczWgCUNOYCU+5/gHq3/CyU82sVvnYkaDkaB2RUpU9HlBCHOGtNsLUTp+5/dykQLryFRwc9hfHL4AurhZruSsc9EMFFAckXhDo5WXM29M7Ln02/yU5iC/eNWx48HiwiOlDJTpCNjHaYUBC1nKKxWugcvBhH5p/SSaQ9tzHpVDiSKtGDovJtu76VcuNhxa/RcIlPyOj6x53QeT3RKthcUsltLnsyBaydMjBQocM+6AXLlqIZXugXhR+DfO3OEtMXk1BQv6Z39k00wF45n2hbQSBwUVzZtyMUZlZ40aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 01:01:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 01:01:36 +0000
Message-ID: <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
Date: Thu, 28 Mar 2024 18:01:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
To: Tony Luck <tony.luck@intel.com>, <linux-doc@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240322182016.196544-1-tony.luck@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240322182016.196544-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:303:16d::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLifrCgRYwSXwx9KC00Dx4lDvUVscOLMBcGoZHomueY7oukP9IBRsvnR64LhbR6VKOTmdktFCUWi0r/hOYuwZf1SmuOkpnb+eZImZfKjeL2zsinOAApVhpnK6H3lyaNUujKuPtjTYH0D+RmL75IGboEz3tZF8EEjQUBF0yf6kz2N96C12Sy9Bvned+ulEB+i9Q9lXvdC+1ej9gnjmXgM37vhqAiDvLnUI9F7xuKrXUGnb6P3v70JovzXjbyxEIs9eOfmktV7fmG/CEFMpad9dGFlBldfk1RLHAO2xbIb3liiT0tTCK0mk7RZjHPw0f23GIh4H/V1J8dYyZxRJRMAK6m11JROCWw0G96fJGIH/XYDgKeGL0o0HNr9GcKiX8nhENrEzYLnL4RDhUYl4IrYaObkeq/Hu12mDJW9NGY5z5YbJCH5rvin4BzZYOH/z/N8et73prz02wEv1U8lVhFCuouWOG34ByhGkhnawPAAg3hai1jbj0nn/eFEJBijadNVo9msyI9WMJCcRdOqliRDwLR1Te8zr6dA+q3N+9OtlqUWheA1JNKh6hCwHt1JqxRgaZH5T6pjlufMbxIBCGzhh+Z/VZrav5YTgWJsdALtf1c8evU/Wa2/QNGWVLE30FSgjfmQ7TZpC1FU/Ux14WmGcM0mR9A0SHvQWJmZnl3X/Vs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVkZUVjdm1BbWp5SHNqcXZWK0FYTUhiOURwSG9WSGpPWk1BRnNWOEx3Yzhw?=
 =?utf-8?B?a3RoUFVoc0tNcmZtb0FmR1hlY2JPYUZSSHZvNmhiTkE5eEJXRkpNNDZLZ3lo?=
 =?utf-8?B?akJ1NW5tYXh4d3loWHI1MU9TcFkrN3dXV24zeTc3eWRncUxqWTdydTU1WjBa?=
 =?utf-8?B?dUJGYUJ5RUN2UGx0N2JqclNyb1FIUXRPdFh5UEZ6M25DWDV5YWtxYW9TQjQz?=
 =?utf-8?B?aTMrbWVlQk90UmhrWnhGZytkbnZTbVh3bVVtU1RsMFh0ZWN3NitrcGkyUXRC?=
 =?utf-8?B?aWJyUkVuUGwyYTRmaGdNNzV2aVdCVXc1Y1ViT3VWQ2RRNzNyTDhJbGpRNzZI?=
 =?utf-8?B?NFdyZDJsTml6Tk1FZHI1WXV3eHBRbWwxMHIwZDVvVE9zdG1JWFpwMnlweGJq?=
 =?utf-8?B?ZEUvNHFqUWMxWWNPOFhQVWI3UWh5a29sajBnMTZzaUlEY0FBQk04Z0FYVWFU?=
 =?utf-8?B?Yi9IdU04Rzk4M2RXSmV2bFdNY0Z1eU1VMlB4MklXekNqQkh4ejJUdVc2NWc5?=
 =?utf-8?B?ZFJzczVqTGNXdE12S3loWUhvRUpGMUg2YmZxR3VoRlN0Q1ZCaEc1Yytyc2Nu?=
 =?utf-8?B?c1RjWXREUHRLd0lNdytneHFYSmNTYzJDMUJNV0U5bmRDMEpBTGdEVnVoZ2N3?=
 =?utf-8?B?cWN4SUNYRjI4bVo2b1NGU3JnMkIzME05eHE3MU5IOTZMb1hTQkNCRklnODNN?=
 =?utf-8?B?YUxSYk9SOVdFYkEvenp0YkZQMWx5MlBYbDNtMDV5MFNxYUZrN2NJT0ZrVjBS?=
 =?utf-8?B?YWFkdldJeTJ4aHVmMG9KejJjWEJDRnRYcHgwYjNyWnhpV2Y4SVVUZUdqNGZt?=
 =?utf-8?B?bkVKbGl3RXlQSk5jN0JwbWN4b1ZHM3RScEw1SHZ6S3RSbjNIUVJFN0U1OE1i?=
 =?utf-8?B?MHdOQkM3djB1MGkra2pEdThINmU3Mi9CWVAvUXo1ejhPRnZ6eUVNNk44akNv?=
 =?utf-8?B?SzRrajRaNDlwOWhzS25hbGQrUWNXN0E2dnMzT09GRm1OVllQT0M5ODJtRU5k?=
 =?utf-8?B?T1REbjZ3OHAwYnZZTXZmNFVwUzJxeU9WVVBFeFJoTnpBejVjRWlvNmEyMFVo?=
 =?utf-8?B?KzhvZzRWR3NVVm1wUmorWld2Sk9SdUpOenE0UlI4cTdDMCtqWGYvVEdxYTNX?=
 =?utf-8?B?N09mTVBMNUdxWGUxYW1xclYyblBDVG42V1JGaUZYWlY1Uy80WGRTakFwMm9G?=
 =?utf-8?B?NDNTNzhkS0xtMFVnSFIrb1pWZDBDUlhPOE9TMEdxREU2NExwbDV4bkVTZWNk?=
 =?utf-8?B?UlgrQXgwV0NEUDY1RFc2T3N2M3Y1MysxMDN5WTRMTGM2SXdzdnl5MFFWc082?=
 =?utf-8?B?elQrQ1RLc1h5MnRoTUw4RkM0a2NFK1RTaEdhOG5WU3VhRW5lNy9RcXdVQmo5?=
 =?utf-8?B?MFFRY3hteXZSSnlpTG5RWHFsbkprOWJrR0dRVFRac0NrQkcvc3MyVU55U0xk?=
 =?utf-8?B?V3hmQXJxbi9NZmdub3B4QzUzSTAvTDAyYjdLZkdFUkNFSzdJaXExcGljZDBV?=
 =?utf-8?B?dHpiNXpQNUZmQm40T1VBWlJBQzNGLzRWbS9OdVgxZkZwdW1MK1ZIbWpXdm1S?=
 =?utf-8?B?M0E1M2pRay9Ea2NwQ1I5WGFOMTlzTThvQ0FkUm9VRnpiVC93T1F2TVR6Z3JR?=
 =?utf-8?B?Q0FxYUdWMHNDWEpoVzIyWEVZMnFxQVBVOWF3czZNN2VOQjJxdDZ0NnpVMWtH?=
 =?utf-8?B?eGEzQXE3WlNadzFJNXdDdDBrR29aK3ZOZ1FzeDhwTThKUXFTQ2wrWFNmZVlC?=
 =?utf-8?B?VUk2OGlraU1lQWFIN005bFJTWG5Kc3ZTQTMybHI4NU5BUVJwK1hzQjFpZTB1?=
 =?utf-8?B?WVFENU93RnV5TXB5L0hCd0xJaTZyZ0VFc2JkbGNMWHVTZ2dtQnJ4MUhGenJF?=
 =?utf-8?B?V09BZGdxT1hoYWtMY1BLaWpOUG5NYjE2YnBzdUFzOUhRVndWNlEvblBBdWZ4?=
 =?utf-8?B?SG1vZmhheVZVTVBZMGdtSTVUT3dmdzVEbXpjMWdNTjRKUE95K2VpcVBmSm56?=
 =?utf-8?B?Wm9mdGI0WkZLSnZ6RVhXUEZQanRRdVJ3R0N1eU9OTHJNKzZFTS9yVkFSeWZh?=
 =?utf-8?B?MnU3SW5RY1V6OVFFU3VQZUN2enhSVUNkdnJFRVNQZHIrWlJkbEtxdHZNR0tp?=
 =?utf-8?B?Q3J3ZU52bFhaNi9QWWt1NERSWlRwcnpWNVVUNHpMQmZKS0NhK2xJdU51Q1NL?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a78bfada-5f46-412d-e693-08dc4f8bc853
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:01:36.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTBfKV5izHaPMaxbxLoFM72ldAegq63kEhK/tSNrgiG8XNNMztuT9nvQQ66JooZWo8YTCoLsjHCrmSCYf6v3GP/33gLUnKoDXuyrDhKA3CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

Hi Tony,

On 3/22/2024 11:20 AM, Tony Luck wrote:
> The memory bandwidth software controller uses 2^20 units rather than
> 10^6. See mbm_bw_count() which computes bandwidth using the "SZ_1M"
> Linux define for 0x00100000.
> 
> Update the documentation to use MiB when describing this feature.
> It's too late to fix the mount option "mba_MBps" as that is now an
> established user interface.

I see that this is merged already but I do not think this is correct.
Shouldn't the implementation be fixed instead? Looking at the implementation
the intent appears to be clear that the goal is to have bandwidth be
MBps .... that is when looking from documentation to the define
(MBA_MAX_MBPS) to the comments of the function you reference above
mbm_bw_count(). For example, "...and delta bandwidth in MBps ..."
and "...maintain values in MBps..."

To me this change creates significant confusion since it now contradicts
with the source code and comments I reference above. Not to mention the
discrepancy with user documentation.

If you believe that this should be MiB then should the
source and comments not also be changed to reflect that? Or alternatively,
why not just fix mbm_bw_count() to support the documentation and what
it appears to be intended to do. If users have been using the interface
expecting MBps then this seems more like a needed bugfix than 
a needed documentation change.

Finally, if you make documentation changes, please do build the
documentation afterwards. This change introduces a warning:

Memory bandwidth Allocation specified in MiBps
---------------------------------------------
../linux/Documentation/arch/x86/resctrl.rst:583: WARNING: Title underline too short.

Reinette

