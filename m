Return-Path: <linux-kernel+bounces-122108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D488F1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFD1C270EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF451534E8;
	Wed, 27 Mar 2024 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EINNQwoy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A410153802
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579047; cv=fail; b=temFTX/LeKlDJNXjHBKC3/xDMbA0BVV4EERwvs00nv7bWSugkZ2cQn5k3rAHJtzyjOuZnTmn89rDvzPo94EFhDd/KbZ/vVJZJPJBFM2UE1rAHFRHfQDCMlVPMdaOzZzkcNZDvXWYHKXbn3HHzbCeqnOItYtv/A/hyu3lnoUTqFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579047; c=relaxed/simple;
	bh=J+zOeIti2cop84KXRSwaz6mAi7xNp3CenvxTdyf0QvA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1rs0KAKO0gRYSvUG/W8G0zsAxBGuMYsNXARrZ4UMqEzIM9c7h/idCsfpEGPYKx/EWRxJktIW6XpCxqVLbf/x6oX/SDls/m3i4KHLZhZwtFui/a3NTOdhTQTZb/5clLDP9No+WfM9PUAQ732xZZlvLbR370eZiRzSP7Vn9vsAjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EINNQwoy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711579045; x=1743115045;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+zOeIti2cop84KXRSwaz6mAi7xNp3CenvxTdyf0QvA=;
  b=EINNQwoylCnY8CqfFwptXBiI6mfJMG7wXpLS13YMsO1Yn4p+zkG+3dbh
   eMouPAAzeZjSxNc8DO3qdJVFLay44B5quF1eKapnN8zPc0YZk2RZXuVcL
   EkgbxMESACtbl73gn8/TJl3vgn+MaXUwlPO1O+2JJ4CqkH9X6T3hBgkYN
   ZGa6ZeOtFIGnMc8ey1rADBOiydZC0zvH9PiuA6NVBD1REirWaNPRKnl47
   dF6hr8gbw6+TSeCUkhT4NzdxLplWDi+W6gdeeuiMDkgkfIMoFsIeNVmNY
   vsQZ+n+B54fPVexo6BmWBiiz67T5kN837m1WKjY6LPQu1T6rbGCX5coKz
   g==;
X-CSE-ConnectionGUID: +ZDOzBPDQKWuImicbRWCKA==
X-CSE-MsgGUID: RWFCXNLHQn6UPgCFWAThJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6539370"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6539370"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 15:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16522175"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 15:37:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:37:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:37:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 15:37:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 15:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD4jbRN2QpNhjwpk/0ZOBXC9H0yxHKZmo3b0m4dp1yrkMNz8d0su1FEz+IH36dAbT4tOEQZQUCe5iVi9Q4XS2HYTU34L5snTGMu1Z98ZfRY8R7iXlMPJRso6PEVUXX/N7caZTlVMaJB4OJYBjTnlMDoz+IURLKYbhTYtdpsNhRUxUSoBdEwvz7rWLBLhCDUaoojoi/5xGcBNTZAGbS8O6HHDbGtyQM2UMtLERcYX/zKWxNF7wD4VL8EAh9voVaMMiZXI54T1kwFpdOtmZIc5J9mwDTQ0t3M/A53Fh6/xBNAH0XB7VWsTws/gZnt7cD5rmLxylNFNm66aPbWD4f0TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLbfJ9F3VhhQyBI1164u6/SpslAyKNgce3aetuS4lEY=;
 b=Q5+RL3YiMMSRrfPZOW/b4zsRqKERcXAd+zFCdhm9/ceWIIt3ao8RebEKU6YpNMX6s+tf5yU7ZyzY/igUuA4TW73v+XyvJoR3DYybTQo0ZkhPN1V6OUCIZkCT7einLW/07dQKKQDJkp66ZG+nXhzzRUB+vcEmPybB1QNiEl3SFxKztdn5P/AB9EK6/uGP+JN4J77YjlwGl+6bmAuiQIUiRRHHkl9x77Q8rBr40MzZJWW/bpg0HkK/LBux4NfA5Tj3P0U9Ic4TfombHtZlwBGy71FW2qObgofGI8PjmsyXkfc0QWXZfc1RXdO8T8wi1ZcsKSq3NyFo1jsnP1fAmmPMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7411.namprd11.prod.outlook.com (2603:10b6:8:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 22:37:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 22:37:21 +0000
Message-ID: <c53d6abd-5dbe-4edf-89c0-abbea0df1f1c@intel.com>
Date: Wed, 27 Mar 2024 15:37:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix mbm_setup_overflow_handler() when last
 CPU goes offline
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC: Fenghua Yu <fenghua.yu@intel.com>, Maciej Wieczor-Retman
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240327184619.236057-1-tony.luck@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240327184619.236057-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: ead30f95-f2cf-497a-5cff-08dc4eae775a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvR7zmQDRVr6chYU4/+8xCJMJmFhPtEuJohswOco+d3A1JAn7JxRXJb1RU2J6+9BcdwxNlctomOjAa2nNPHo97yKpap4vZed1SKZUdHgSWSOk8NrcxAydqgPi5MENPSGm36/DhbQdxSFESDNsQ8EXk1RgCx6cXMjM62PwV4x5ljS1CqN3haqBTYQZaiqqTqrWHdrkrN1oVd/1nUdFWOtYj14SGiBf1LVIDaZjVsePlMavQ9F8obPKJsG5Q2G1fOrs5i8DZmsxK0VR3/Wcpg0K2/wCIQkYUGwSumtrXcrPQRNdsij9USWo3/+SVDihtiaZj+2o8GzfzF5x2HwkXGERQg0BLnhVP5ZetZQjXfjW2gzIYp6pJxdtTb3hyR17+CzTR/PVUipu/atBfhCuFAT60Tv+uts/jlgcvjx6LKbpubY3CI8bvQlVXh4ab4SNF05PzFW6vkkGPR5j0JjhTFU6nvVinSCz8uLZw4ZxtSd7IBekUHYJb/qvFt22I8W9CQ4mkTXibrBdABmw+kW79QuUgrQyAy+/Q9PyuZRhQNSf6TQuSbmw4Cn7462imjcIA30TI23eihXDi0mXVCAaQ5oyxubQ1in84/gNlS2jMyTjZd8ie5RzeRpnqPWsHzz3F+MalE1LooDJ2NaKJgyr6RitWW3+pP/7SwCaHTJWbLQ8k4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGxsa0tlNDM4SHVyTjBxT1lMT3ZteHdONUlIOG9RaDdpM3ExbGx3bU53M2lq?=
 =?utf-8?B?TDBCVXVKMys0K0ZoaE1DdjNjVGZCY29aanlmOVE5M1Bja1V3bzVzV1FneDVC?=
 =?utf-8?B?eitxSXEwbjY4ektCNkZxMGdRNFh3ZFVLLzRHYjJod3lkWll1WVZBcUlpLzRE?=
 =?utf-8?B?K0VVUTlGOXRvbTZvTE44MHhudFlpelh1UlRXdHI4Zm9oQXRjVzlISlNtbGpj?=
 =?utf-8?B?R21qZHZ6L29RMDRCaTJDRkNtRUcwak5JV2lpT0VTNlN3U2ZmR3RLT3htbUtU?=
 =?utf-8?B?WjNDV3RGODZlcE5hWkNIOUZEZG5qVmVIMDBmbnFpWjh2Mm9scnFaYUQ5TXJX?=
 =?utf-8?B?dnF1L0c5MFVSeGlTd2UrUWMrLzZKOEtnelk5SVEzK2tSb0oydStaZW9qekd2?=
 =?utf-8?B?UlV0TitrbVRvUmk4ZXpWWG1QMmJzQmltUDh3SFFqODF1MDZBNk1xbHFnYVl2?=
 =?utf-8?B?dmdCWm1vaUNqVHZyMFR4L0lEemt6Q2NWTDY2WVh2TmNMdjh4NDFUWFJIMXJF?=
 =?utf-8?B?ejA1Si9OUlJhcHFBa2JTS0YvVmVza1U0UDhENmo0WlJHaWp1RVpoMVFVMmZu?=
 =?utf-8?B?N2ZFV3Zra3ZRUzFTbGNLN1dVcHd4dEJpOEorQ1pUcDZ5L1A0bG03MW1LNDFo?=
 =?utf-8?B?bFlsdG1lL3ByaXRLOC9sYlJsZzVkdmZSdlNaQkFQRVQ5VTdaYy9mM1VkaHBu?=
 =?utf-8?B?dVFraFZXWjNNTVFRK251QVIzSkNGelhpS2hUcWkra1JxTXkwWlQ0ZnprNWZR?=
 =?utf-8?B?TjE5UDIyV3RpbmZ1Yjh6Qnc1YTdINWhMd01qS3dQeGp2dW8yaTJ3dC9wOHNh?=
 =?utf-8?B?RVpKeFpNSHJ1Rk5adGJkWHZDcTRYaG1lZ1F3SHJNT21RclhhenFFZUxmOFE1?=
 =?utf-8?B?dVNCUUJ0Wkk5d084YXJ5eWZWRlQ1b1IzMWxMczlQTG1KWWdpSjFOdXdlYVBZ?=
 =?utf-8?B?RmFES0JuVjFpUDFiVVB4SGEzUEFkTkkvN3NmYnRmVjFXcWtRbTFDQmxjQmo1?=
 =?utf-8?B?dTNqNmI4RHc2Mmtwd0ZwaFdiL0F2eGlLdEgzcCs2Mk95VlZiUWZyUHR2UXND?=
 =?utf-8?B?NG1rZEdqazdJdnhob0pvaVljNDRZb215VHlGMStCUWtmOWV0VHJ6d1ViUXRz?=
 =?utf-8?B?ckx5bG9aZmF2LzZZRTg0dkdlMURwNldOam5mYVFHMGYrQlhSUmZ4aXEwK1V2?=
 =?utf-8?B?eHZMVXNmOFJMeWtILzg4MUhSdHlXeW42VDdkSUdncmZqZDNMS3NVM0xCMWYr?=
 =?utf-8?B?SnRFRzVQdlJNZDNUUGc5NFpTcmJIU0E2N1k1S3ROTnlQUmY3dklHU3oxdTlj?=
 =?utf-8?B?VVZvZDNtenhvTkNJWnozREx0czRVbEZ0WjREazQzYkY0MW9pOEt1WWFYYjVK?=
 =?utf-8?B?QzF0NTYrZ1diQnRxbzFzcTlCSEkybkQzNW05bzhWb3l3NDNPbWtOQVBRTCtV?=
 =?utf-8?B?RDZDc2NpWGg1em9zQXVQMkc3d09DYXE0NXVPVHMxMlNLTXJaaEtqMGFOVG43?=
 =?utf-8?B?SFU1Rjlsa0dBTWovbVlsQis5b0NiMFYzT2lOZlV6Q3ZkYjRwMDBqYTlVR2g4?=
 =?utf-8?B?VHptaDJpNEtmdzZTM2ZKTUMwT3FqL0x2VmMvcmlrQWtBbkRQWGh5SFhjaVdK?=
 =?utf-8?B?N0RsaXQ2UW5xRTM2c0k4cGJ6MzJhbnY4VmU5ZUVJZC83em1OTGJDUXpBYzd6?=
 =?utf-8?B?Zy9yK0RSTGp6UkxFakJWUHEzdUMrcDlnZmxweXo1ZGhNaXlNb2dnL1dOcDVs?=
 =?utf-8?B?T29XcG9iV2RVdUowUTZuVkx6SFc5ZWVDK29lbnFmdG5VeW9qNVBBRFdoUS9T?=
 =?utf-8?B?cWI4cGl0MGl2Tmk0YkRzL1pTaEhzV3lTc3RMaHhRUXFLSHhVWnJIWnhZNVoy?=
 =?utf-8?B?UUN1RWNzcTl4YXRjK0JVM1F4ZXdmdCtIdUM3SUZ3WXR2aGg4WnRNbllVZGlB?=
 =?utf-8?B?cTdpaXFBN0xMMmltY0FMYy9YbnZpK3pBL2RiMmc4d3lvVmFOTW5Ccm9vdlZl?=
 =?utf-8?B?ODI4NThTbEtSOEd0K1M3TnRiNTNWWDZEcktuWWJRTWZBWWw5U0ExZklNb1k1?=
 =?utf-8?B?YUpvK21LOUMyR0tlUWZFdUhsSHdUc2NsWWZDUG56NzY4TGNOZWJyQmtxZjhC?=
 =?utf-8?B?Zy9IdE1jZnJrb3FQempaSDV0SjZVbEQwNmpweFdhWHMvcWlLclhVK3RvcDlZ?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ead30f95-f2cf-497a-5cff-08dc4eae775a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 22:37:21.4949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2LwbqUbXglXlQilUYo31Cbdt0tBsO0Ly+uXuhw4JF0GRwM2jwKnjOxqQ0h2kYdRaRlTJecgDLReuGYirGwrx0ez3FuSBrjlxQxtECMIa2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7411
X-OriginatorOrg: intel.com

Hi Tony,

Thank you very much for taking a closer look at this.

On 3/27/2024 11:46 AM, Tony Luck wrote:
> Don't bother looking for another CPU to take over MBM overflow duties
> when the last CPU in a domain goes offline. Doing so results in this
> Oops:
> 
> [   97.166136] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   97.173118] #PF: supervisor read access in kernel mode
> [   97.178263] #PF: error_code(0x0000) - not-present page
> [   97.183410] PGD 0
> [   97.185438] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   97.189805] CPU: 36 PID: 235 Comm: cpuhp/36 Tainted: G                T  6.9.0-rc1 #356
> [   97.208322] RIP: 0010:__find_nth_andnot_bit+0x66/0x110
> 
> Fixes: 978fcca954cb ("x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but CPU")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 757d475158a3..4d9987acffd6 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -929,6 +929,10 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> +	/* Nothing to do if this is the last CPU in a domain going offline */
> +	if (!delay_ms && bitmap_weight(cpumask_bits(&dom->cpu_mask), nr_cpu_ids) == 1)
> +		return;
> +
>  	/*
>  	 * When a domain comes online there is no guarantee the filesystem is
>  	 * mounted. If not, there is no need to catch counter overflow.

While this addresses the scenario you tested I do not think that this solves the
underlying problem and thus I believe that there remains other scenarios in which this
same OOPS can be encountered.

For example, I think you will encounter the same OOPS a few lines later within 
cqm_setup_limbo_handler() if the system happened to have some busy RMIDs. Another
example would be if the tick_nohz_full_mask contains all but the exclude CPU.
In this scenario a bitmap_weight() test will not be sufficient since it does
not give insight into how many CPUs remain after taking into account
tick_nohz_full_mask.

There seems to be two issues here (although I am not familiar with these flows). First,
it seems that tick_nohz_full_mask is not actually allocated unless the user boots
with a "nohz_full=". This means that any attempt to access bits within tick_nohz_full_mask
will cause this OOPS. If that is allocated then the second issue seems that the  
buried __ffs() call requires that it not be called with 0 and this checking is not done.

To me it seems most appropriate to fix this at the central place to ensure all scenarios
are handled instead of scattering checks.

To that end, what do you think of something like below? It uses tick_nohz_full_enabled() check
to ensure that tick_nohz_full_mask is actually allocated while the other changes aim to
avoid __ffs() on 0.

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8f40fb35db78..61337f32830c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -72,6 +72,7 @@ static inline unsigned int
 cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 {
 	unsigned int cpu, hk_cpu;
+	cpumask_var_t cpu_remain;
 
 	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
 		cpu = cpumask_any(mask);
@@ -85,14 +86,26 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
 		return cpu;
 
-	/* Try to find a CPU that isn't nohz_full to use in preference */
-	hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
-	if (hk_cpu == exclude_cpu)
-		hk_cpu = cpumask_nth_andnot(1, mask, tick_nohz_full_mask);
+	/* Do not try to access tick_nohz_full_mask if it has not been allocated. */
+	if (!tick_nohz_full_enabled())
+		return cpu;
+
+	if (!zalloc_cpumask_var(&cpu_remain, GFP_KERNEL))
+		return cpu;
 
+	if (!cpumask_andnot(cpu_remain, mask, tick_nohz_full_mask)) {
+		free_cpumask_var(cpu_remain);
+		return cpu;
+	}
+
+	cpumask_clear_cpu(exclude_cpu, cpu_remain);
+
+	hk_cpu = cpumask_any(cpu_remain);
 	if (hk_cpu < nr_cpu_ids)
 		cpu = hk_cpu;
 
+	free_cpumask_var(cpu_remain);
+
 	return cpu;
 }
 

Reinette

