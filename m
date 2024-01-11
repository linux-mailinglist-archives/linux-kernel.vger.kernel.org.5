Return-Path: <linux-kernel+bounces-24151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF4282B84E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F751F264EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD4F59B7E;
	Thu, 11 Jan 2024 23:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwbnNftG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5765A0E1;
	Thu, 11 Jan 2024 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705017311; x=1736553311;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FJ0h8qSjJ0rmJwf8YXi/y9KVfGd3NhHnJ+YpFv5ny+Q=;
  b=RwbnNftG0uMZkSbnSMdp/Rux334HhKaWVpGyiAdinfz/G9bl1jhvJdR6
   WQd4Nrvlk7liKLqW2WuNAuCrQXMgdtrLWwkB1JcaceTOVLxRnOMKN1l4j
   1Vj8RLKhbFGzgT17cSLvQ0HKoUrxsNZfqV5FuDhF5CDfT9KsuAAzK0ifh
   9eyqUOByg9M6sMCVCIWlfGCQ3e2sImd9BWBxJq97BDiHEVEEvGRBdWYGh
   PxMINCvFrsNf4BirPdwdkZDG1XoG97Bv8AG5PGMpr5DQayvoPQYyVcmJ9
   9oTA3HGHL5zK+zfhdEx3oP87snqDvXXvNZ4RiR///RHI+yXMsOruo8e/S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="12518308"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="12518308"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 15:54:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="853117576"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="853117576"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jan 2024 15:54:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 15:54:57 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 15:54:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Jan 2024 15:54:56 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Jan 2024 15:54:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2959k700yvuiYr+41Gm2iuMRiQ4X8m9wp0YZnvGBkofUnlMavx0Wjn2fLY6vuUFDMYIo84BPBeiVorSkWNlzbFHArQuaePxC/sv5POf/Swra+BfyOv0wU7fGd8Omi2bpSVNVeXjx9xMWd4eItIUdc4NCKWeEJBXv0foz6LN2c5fxcHLZC7HZdNmc5h981fZfsqMAyHVcGh55MXXeaQcd0q0bF9uFPHdgOgSeF/+GBdDm292VsYRLqXL5SMrFxWW4Np/T1MAcOYol4/HIn+gImPWLEL9PZoH45bWljMrlwQlemBBm0q78e9VI0+kXmL5PviCfri7zxNLRXU+ybA9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fikKo3TBA8qMda5zTzbLlVtKK5GARKjWT1N8QFWNMJk=;
 b=YHs6pjlDC7aKWgIOhcATfHXRC3mDs1c5ylQjT7dWR0TAtAxUsLFlu87N1PpQX+bzGjA45ZSM9Thi7fx16OKFg3NrTtwSkc781uPpoALKQydinoVyfcDR2ytAbZI3oK+Gzpd9ZYs+8EbxTONcx121NRMJMj1R/jhrPs8XcsuyHLAj0nOcxl3RO3EOMKFJbJc20U51aBja02YK+iWsBhSaxx3hUwhs+shNoqVJyTogS1NIHkGhjbKYhR5FmSP/2odskFcPErMu/1gxXwFKunrsJnQBPC24fjXZ+ZS/axl4WYnBPLLz884BgXmcm8NpyzUWTWPY42hpBSHn2OanGU7GYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB8285.namprd11.prod.outlook.com (2603:10b6:510:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 23:54:49 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 23:54:49 +0000
Message-ID: <3d74f069-b760-45ab-8d62-5d7d143e27e5@intel.com>
Date: Thu, 11 Jan 2024 16:54:45 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH -next] cxl: Remove duplicated include in cdat.c
To: Yang Li <yang.lee@linux.alibaba.com>, <jonathan.cameron@huawei.com>,
	<dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 63272b0f-2a65-4fcf-8a69-08dc1300b233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/Z40kDyPsVlh8C5dkkl/7x+aHcbV7Wov4q6TDCMckwqDQcFoUshVBKxS5tod3wX6G5W2EVU3ku46NKfXAPj2WOiDxIXqgnJoeUUm04l2ko2D2DowsUSZy1uTez0lADyFHwT3FfldSkxG01QTHF5omgsDmuxp6IOhhQhDJOglLRV8taZqQvS4cNcLTiBC43VbgvJY8xalhCwIan5c8C+nKHn2ngEVGnMD9WpV1mIut61AeXCRV14j4rC87nfMelNappUbMDAnOOym6uI7WoBRDIILeJkw1mjZcpwFrUBbAiYg87wAF+atXyN+RISozwXfCaHWyfgRPiEbIASuHUKTjyf9PVoYzZQZtC8UDlKKZUhJ5fchVZ9n5tuD2aL/FLiZV6VHUfmIUAbLHi7gQQMVKKFlC6AT95szUk+9VMgDhRg0WDMWP7f4FSaTXSox+O1TY3EaVlFEATUB7SN0iT5BBaA1AMjbFVouq+HNuDeVNHvpU4l3SrbpbEkARWdk8AYltAHWnjrm0PT+rg9qK8Q57WGh+0MW0tKwTprP27SJ6oynZcFXgYRPneSmkX6CVCPzwel66SBpQvk+HWLKp67yuRA8s1scsyH1AhKfjlNMI74MDZdScc1TQaSrbuV90iR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(83380400001)(66946007)(66556008)(82960400001)(316002)(31696002)(86362001)(36756003)(41300700001)(38100700002)(6512007)(2616005)(6506007)(26005)(8676002)(66476007)(6486002)(478600001)(6666004)(5660300002)(53546011)(2906002)(4326008)(8936002)(44832011)(4744005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3E5MzUyQjJRQi9aZnpmeDZHclBVcFdnRy9yREVMUXlOYkhrWExYdk96cXZR?=
 =?utf-8?B?TjhyMkc1L1EzUmN5TVFOcVV4KzZmcjJKMytGWVcwMTRBMkVLM0w1bW5qTWd5?=
 =?utf-8?B?NkQvMXdFYXIzd2lXbDlzN3JaaXFETVlXUVc0ZFFUL25abnlsTWNqTkVicFBJ?=
 =?utf-8?B?L3h6UUFJNExVOW90UkpNSmRwOUVldm1MN0Qwemsvd0ZVTUthOE9sa1EvSUd0?=
 =?utf-8?B?SENzaktucWpKbzZxWFcxT25URkJ0QVN5Nm9VSTJFVXVBTXNTRTd4NThKMWtE?=
 =?utf-8?B?MVMzN1djY1IzMS9xTm82cWptSHU1YlIySzZxK0ZTa3BHWVkrTWxwSHlWRUFP?=
 =?utf-8?B?UGFjM1FXK2l1Y0N6TlVFZzlyaWxpWWFpU3N1UXArWFJOVWNjTk9VUmJJQTZv?=
 =?utf-8?B?dGZBdkFCZFphSUU2b2xmVS9XQW9qTE5DMitoWHVZcDhEc1hHWmVVcFROWGE0?=
 =?utf-8?B?ZkIyY1RKYjNPc2FEUCtuMlkzczY5UkhsbGpVenNqblZDOGhCL3h1enBMNFpB?=
 =?utf-8?B?eXlCeXFnZUdLT3NOK2t2RldtMjBwVW0rUzJKQWpQbGg4RFBZQ2ZiZGNtVFNh?=
 =?utf-8?B?YjFZMUdQcTE0dnNuK2NLV0pSUTFNdVplMXMzVWFMOGxSSjdvOUI2THM4Vmdn?=
 =?utf-8?B?ZWx1cHl0NUhYeGU4elRYcStheHhkaVRGWmtialdJMzJxSVhTT1FsZEpiemdF?=
 =?utf-8?B?dldWdm5jY2REQkdFS2hWSEcvSUI0elJ6V3Rvd3hkYWErekptUHU1OTJUeFYr?=
 =?utf-8?B?LzJVemdsWHVQd0tzWmJBb2txSTJvR2lMUk5EMXE5aUlLUEwvOHhIcnMrajVi?=
 =?utf-8?B?UXZiK2piaW5LVGovRzN4bTRiQmR3WEhlVlQ0UE5qcHdZZHFqYjNLc3lnTWRG?=
 =?utf-8?B?U1VlbDRlck1DRmZNblRJckRlUUh4Ykl5bjZvZTB2bTluZUk5dnh1emhyNUZH?=
 =?utf-8?B?c1MwOFMzRFVJUDJ2czJ6eE5Sc3REUjVlWWpwTkQxRDQ2elRkWW9rQ1NteTBo?=
 =?utf-8?B?T3RObnluVU42OGJvVWlGWjk2c3hqemhONWFXMnYrWlcwdHkzRW9pZzVnMnlk?=
 =?utf-8?B?eTMralVJYTBEd0pNMC9BaDh3akdhTEZjL1BxdWNqRWxOU0M4bGRGajNnYnR6?=
 =?utf-8?B?WkZLbWk2TWZVVGg5bkgzMWhTUUdXa3BHVFpJQ2xjN3I0Rzc2cEZNaFZSdGFk?=
 =?utf-8?B?ZitoU3NvejdPbENaei9wcEl6aW4xeW95TlVDUWtwYnhhK0txa21IRWxLS2JU?=
 =?utf-8?B?SkVpZFNGZ0M3blJOcE9DL3JpRWVTbitIdFphYWNybUEvbWtYdm15ZVpmTFR2?=
 =?utf-8?B?RG1QQzdjT2Y4azU1SEdVdHlWa1NRQUhvV0JYZTBYL2pxNWlXd2tmVnJpdWE5?=
 =?utf-8?B?czVKcFFYdXlnUWIxcU1rc0ZpZTNDZUxvUWV1bkhnVFc2eVllV0VGMUIxVVkz?=
 =?utf-8?B?UklJR0gwSFh5T0QyVVNCcVpQc0NLb3lETWQzKzNwUExuT2J4b0h2a0FwTHE1?=
 =?utf-8?B?bGNJeko4OURJMUMrYUJETEpCZnRpRmdtMlRsbXIyMW1UdUZpOXEvYWFaNXN6?=
 =?utf-8?B?NGNQTDVnUWpjSnBBVzdMdGRvZ0VrR3BLTjc5ckRwUjVZTTNWUTVYcE5NZjhK?=
 =?utf-8?B?cGFCbG9mbmV3RDN3VnpCNitIcHJjbXh6V2V1WVplSEd4WDNFL0kxYWNUY0M5?=
 =?utf-8?B?U1daV1FsWVBVOHlTemlYVVIwY1J3ay83VDJwdDBoaGQyaHlIWFdrZU1XTzEr?=
 =?utf-8?B?NzQzT2dkTnRlSmYyOFdlMGsvQW1OM0Q3ME83aktVME9UdGdEbjd5T3FxY1Iz?=
 =?utf-8?B?OVJxTEQ1NTNIMTBvcGxxNlNwdDYyWndRT3lYdzFMd09ITWZtZmloTkxmblNV?=
 =?utf-8?B?T041VE5kY2c1SXlMQzh5VzFCRkRQVUNobkpxamRBd201UjI5amlVT3plMHdx?=
 =?utf-8?B?QUZLZmNwNUdPcEhzNkhJVVpVcGkyWW1TKzBtVHo1enRoMzVVLzhQS0wxZDVK?=
 =?utf-8?B?Q3hKbTNsNFpqQ2JINUZWazh1MENVN0lJZXBjUFZDUE5vc3BKQ3NQcmllb0t2?=
 =?utf-8?B?cmxxd29qalg2cmJTQ1ZaQ1Vqc0dMQmVRNlgwUGdGUHIvbzdCSWRJdjFvS1Zm?=
 =?utf-8?Q?AK/4MjtLxDMWqSXJK5VNIOUIV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63272b0f-2a65-4fcf-8a69-08dc1300b233
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 23:54:49.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wF6otex6N0WLcwceZHbhFjZ/Z2SEob07MVAJQdT/R6MfkBA0olm0p4stUuSaW+l+4YaX/zg7nqzqmAzAghPklQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8285
X-OriginatorOrg: intel.com



On 1/8/24 17:47, Yang Li wrote:
> The header files core.h is included twice in cdat.c,
> so one inclusion can be removed.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f5e649407b8b..6fe11546889f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -9,7 +9,6 @@
>  #include "cxlmem.h"
>  #include "core.h"
>  #include "cxl.h"
> -#include "core.h"
>  
>  struct dsmas_entry {
>  	struct range dpa_range;

