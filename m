Return-Path: <linux-kernel+bounces-28018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC41A82F925
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0451C23DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F05CE5B;
	Tue, 16 Jan 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNBe+C8M"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759F1D69B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434916; cv=fail; b=ikDMfxOk0uo/fQa8e/92JrWsr0+/LsfLnYINuuR5ljTA/9U7bzYkLBJ8ehKc5/BAEQUEno82rVU32HkHFoZN55KCpcP+lQjJ1b02zfRIJLe5iwjJa5kLIXq1FxdG66x+4ofcrvLn8JDyZXWzV73y7SZ6Y5vdDqv3fZ2/pLtjxVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434916; c=relaxed/simple;
	bh=m5AKgwYUO/iY40g5eRs/Z6Ey6DI2KnLkOKBelVanqsg=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 Message-ID:Date:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=eE4h96uVNvrInZZAL4sANGl2ukwgSJLrxZjbOMiYZGuMNsZj8bYt1N9y4ilGMUoMuT8108u4qZM3y4J8d6CwKqRyQRoEfkPRzUuhGYrYURl6wxFn9YwR5CXQSyQVAICig9q0OKKFSXiO/xSi7hHeW8fLJ45fTNkajpocqh2y3Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNBe+C8M; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705434914; x=1736970914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m5AKgwYUO/iY40g5eRs/Z6Ey6DI2KnLkOKBelVanqsg=;
  b=VNBe+C8MGY3nn4OIRwoZngVOao+ORWQxmT07kOPES3ZzqqrN6qzFICA/
   dembrxksBCZD/sDiiqZ4GN59KERYDw/RluIklENFUv4sOebjEw68PUPcN
   s4vG7YSCaQrPERxvAnyuUngXelZnuEetlrNPkbuJDPVN8VyDlFm2gxEgB
   9by3U2ca5ooRWQYZkuxyBfZXcdHnuU6uz7W4F6jA0UILpwtgznzXxjJXC
   WwVZZYcaIBVxG+etIoRKSQ5mMBMHWWFRr7RbWn80/DIbsVKDGTYMcBB05
   Yr0Ph3T5O1yJ0TuQTl9rI/Sr/0TGCHZ62CgPknc4dBqqkdP6eHefekyKS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="390425089"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="390425089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:55:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="26243476"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 11:55:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:55:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:55:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 11:55:12 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 11:55:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsSUWpM/sxpsuXGtWWdOtSuITYihmp/T44hjC6UHcgX8SUpqPrfviEhHBrJ55ZPpMbmbuu/n71449KoQCzhN0nz6y1E5HPIxbB/EWmNP9OJV0hQxPJF8Z0oSzzwKnipiVxUJgZ7e6k5zaO4R6lMnPX7cLyb/92Cyyp88UGj8hVtGwHLqEvoC6NQWtx/YQCmuAFf4+BbV01jex9ojAfN2ALINBvbMJbqDTki56N2yOHWvi02mP6WdNlXFm0BbTXvtTaHu6wd5Krnh0+Z8zvVFHv8TZej/mpy2djD7QeMtcb03s2vA8XO0OpS/S7kKF9LAtK6LjaLbL6+UCqKa9Yfnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID6Qxdvjja2mH9jL1nQEwDXygihd0CNHJ8Vvs3+BCoQ=;
 b=dPRT9btWmYl5oZEmEYa4OH7ssJst7panMvmzzevzZBH2RllJdRnR2bB+O1qt9Wt+giqPcFO5vGDEz80//K0Tevd/WjBdA4KZSEg+CQGKUoU9PSuJrlbo2rKpY1oYLkHVz/dFoSUMjh5VltPXLzlVA/QKK9yW6YCY9/DwU0xpCUgaSCXeGQA7RKeEuqckNxUahFOzEeqtBZZMLzbqmBvRRw2oWjy62XM6/Dp9zTSAL51rXBvPS7seq9c7FKNKKa6jMlmKkkR3ppKGqfkzvFrjrjukrFKjcDh9d2vGW29kk3xCpK9KWypRzaQUvdNGkpzW4PmXcqDPupRbOx106awNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 19:55:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 19:55:10 +0000
Message-ID: <60a1eed0-7956-4f4b-8113-d5f2d44f3595@intel.com>
Date: Tue, 16 Jan 2024 11:55:07 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Implement new MBA_mbps throttling heuristic
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, <x86@kernel.org>
CC: James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>, Xiaochen Shen <xiaochen.shen@intel.com>,
	<linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20240109220003.29225-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240109220003.29225-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS7PR11MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: a734e7a3-d238-48c2-0620-08dc16cd0b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeWWUuaMDD8H6YKWEGwK26Al7lzzYVbjfmRlHBgFs5rPHNqSNBc0FWd6xiVRKMQ/y+LDDrs6/G+oBcigj7Mwkcq0HSjjBP2YML189b5duNioyW4+NsIaXmzNHjn+s9H4vcS2Kz5FCXotESVbmdAZxe26DYG8LjUDfyCGoFAmhJWhJnTxM+zzThwM9r54xlDx6QDMTfukUXGEKWxwaboDPQXqFHUtmPiSkrEfry+OmowN2cv0aYJDojMNkS2I8G3JJp3ITliWJffbJFjgnqYGjyDiZci/YahhagBALD9DOsDJjw0RI1iWt80txDHNrQRN0Y0lsKgK6a8tIaCWVAdZsIkLCM4lreSHXsCV3iENDM/pk7AuIPgVbcGsnNQv60/jSfIj3fVh+cjk0Y+WE56IK61prCy8L5QyKdglleu8GuA+VY6Htbw3nEEP/vh4cioOPL9/A2kSl9KRJ6ZtfUPpJ4NcSB7eTz7qkm4+1aE7Lc2odhu4e66VQVU8iejFqdCyvGGAqh9j9yVIYRDpstTjDGL7TyKAvwvNhZqlmKYcXSS+WyWQjN4uG7u9ngdG6Y42hUBwjN/GsVl7SxrMvVkkJPd0LL7dirXkC0HJyP2x9QvAOtDQhGvVeb+g7fmly+1fX+Wz74+7+0I3ZoZnyNiwcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(53546011)(2616005)(6666004)(66476007)(36756003)(6506007)(31696002)(478600001)(966005)(6486002)(26005)(41300700001)(6512007)(5660300002)(110136005)(2906002)(38100700002)(44832011)(8936002)(82960400001)(66556008)(66946007)(31686004)(54906003)(8676002)(4326008)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3o4WUE1WG1tRzdZY3dLZmVwdGZvVEpBd3FEQUFyRkFEZjFWd2hmSk9DSWFm?=
 =?utf-8?B?TE9zRCt1anZWSlFzbndISzV6TXJRcmpUQnVIcld4cHhTVU50ZnNlcTF1czB2?=
 =?utf-8?B?a0x6djZoUDVEZEVqMmpPSUpPeEVkTjRWdFFkUnhqMWdCMUNVSDlxNWZRNzVz?=
 =?utf-8?B?ellxa0dKN2pIQmVjRFVSM1k5YXhGczdTR2JmOGp5SldaWG5XLzc0VDRpRjUx?=
 =?utf-8?B?Yk82THlsT1htSGRRNnlRajlJNGJUNnYrY0NzZEpBSFErWlZVN3A0ZjRWYnVJ?=
 =?utf-8?B?VS85SGIwVVprUXUyQnV5TTZCVTZVY2RpMEs0VlU5eFI4SG5CTEV6UHpoNVg0?=
 =?utf-8?B?QmtjM3dXSjRsazc1eHNKSVZjMzJPZFNWTHRNZENOVGVIQjBLSWsya3J3WDlD?=
 =?utf-8?B?UXIvU2x1bXVDaURHYmpteHhvWmp5cXF3TjhkN3NobG9uL0E3T3B6S2RFQSt0?=
 =?utf-8?B?KzhPWllidW0zbXdNa0krdjArR2VaS204eVBoa1Y1RDNFNWhBZFpWYzZHaW8r?=
 =?utf-8?B?SzV6dmtSQWxGNEZFd2tjVzVzeXFuR3M4SDFyU29oMklyY0VwaURsK3RmVTJH?=
 =?utf-8?B?ZzRoRzJaTEd1WjJVTnpyZ1hmYnNUQ3NUcjRCNitQTFIrV1Z5VmZ2dkU2RHQx?=
 =?utf-8?B?Y1l2TVIzOXIwZFdtYTIvQTRQeGtJYjc1TzRBRFdoZ0dxUzRmVUt3QTRFV0FP?=
 =?utf-8?B?RUtQUlVVUTJybzIrbW45aG9tWFgvbUpvQ0tWdm5GWGpKMWRFclNtZFZTQjF5?=
 =?utf-8?B?KyttVjg1bEJLTjk2S0NOOWJITXJrRGxYUlQxYTludzNVRkFWYVlvRXI1MmJB?=
 =?utf-8?B?NEt1d3FsZTlTMjh4YWcwc1NXRlJjWWJuYk04ajhvTk1jWUZvZkVXeFdQeWhw?=
 =?utf-8?B?VW9YM0E1TEsvZDRlQWVVdlNxclh5ajBjYzN1aGNWckJWczBsZlBKY1lWOFpW?=
 =?utf-8?B?MDgzenhBUnErM3h2VEV1aGpvWEwxR3R6TjNGNUhtYXkwZWpXK2RlNkxmbUZn?=
 =?utf-8?B?WFpBeWptTVB5VG93N3FwZUpra3NZUGk4TFAzY3Q3SEFiQW41WFg1RDg0dG5X?=
 =?utf-8?B?MnNLY0dFNmZzOXNYWW5TdTVHVkNSdi9Fd2JGejFYMllQZ3lyQlZNL0tET282?=
 =?utf-8?B?anZNYUtoc1NLZGRUM2ZPQTNUSU5Ic1R0SUExNVdkNTVCVk95emYyaG8rV0h1?=
 =?utf-8?B?MWhsNjRKYkxON0JJTW1xNUltR1l2OC85YlJkdjdKVkhyVHlIdFhkNUJaZldw?=
 =?utf-8?B?QW5wWHBENnpLRllSb2xBbmhWS045RnFJOHBmbE8zWThpa3B2TlJrYTd1SW16?=
 =?utf-8?B?M21TTi9CS3dyaGl5SDJpSGUrYmpDeVQwM1RSS2pSM2QzbWJIbHg4bUtNa3Rs?=
 =?utf-8?B?MmozUUlIK3FXakpXTXB0SlJlczRkRm5QUDlCcnNlZUxFOVhqaXlKRHQxMy9C?=
 =?utf-8?B?dFd2VWNyejNOaGozMS9DcjFtT0ZmVmZzVDAwdHN1ZEJRQmN6YkpkUzZNQVJV?=
 =?utf-8?B?bzErZXFUTmtJaUR0RVlhbDhWanpTdkFyVUd3RnErRWpHa29SYm9PVlJOZkZW?=
 =?utf-8?B?aVlHc2cxRlJRcVhUR0NyeWtnWkErZG1QMkQwclRCcm5mUXhrL2NqN1FVU2xy?=
 =?utf-8?B?eWZ6STZ6WWlrdUQ1TmlvWnBmZmtGRHR6aEl0VmhLTTlidnB3Q0xOamdDZ1NU?=
 =?utf-8?B?UzZoWlA2QlhaSE5VU0xLWGx2ejQ2TktvRVkwejdlZFNtT204dWVnTTFqV1c4?=
 =?utf-8?B?OCsrZ3VoeEE5NmM5Y3ZiamRJMmMwZ0szNHlGQUk4QWc4Z2dmaVI0K0wyT2do?=
 =?utf-8?B?YjMwckQxc0JzVFZzSkFmM3ViamFtZGFMOTM5amxzcnlsWnk0cGpGWjl0cDlz?=
 =?utf-8?B?TUEvVzRjR29WcjNDbVpHbE5jTGRJaE02dENqRkFpS0l2UDZyeWdaNnlONFBE?=
 =?utf-8?B?RkFDNldYUUVUdkxhWXI3NjdoMHhPaC84bW8yUjdZUHBRQ2FjUEE1ckFIekQz?=
 =?utf-8?B?MDZYVFlUQ25hT3d2VnVrTnppMEhpT2k2Z29JaTdXMkJKS28za3hkRW9ac2VO?=
 =?utf-8?B?MTlWWWFYVVpWRHY3ekV4R3ZIVUdtVGs3V3ZIOS9aV0x2SXpGUGZSak8xWXNP?=
 =?utf-8?B?MVNBcS9qNFpsMEtjV1p6VDl1NURsSmh1TENBelAzRFlnaWNqckU4QW9EbU1o?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a734e7a3-d238-48c2-0620-08dc16cd0b98
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:55:09.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzZv3RnjnuJnoforHvNpJtPQW6biP9zOIqcATpVFkMtJn8t7QVEE621bfJmUsfnuu41EllVDjHw7WDyTclnhhYIMlGGutgjehMHbkhC0BZ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 1/9/2024 2:00 PM, Tony Luck wrote:
> The MBA_mbps feedback loop increases throttling when a group is using
> more bandwidth than the target set by the user in the schemata file, and
> decreases throttling when below target.
> 
> To avoid possibly stepping throttling up and down on every poll a
> flag "delta_comp" is set whenever throttling is changed to indicate
> that the actual change in bandwidth should be recorded on the next
> poll in "delta_bw". Throttling is only reduced if the current bandwidth
> plus delta_bw is below the user target.
> 
> This algorithm works well if the workload has steady bandwidth needs.
> But it can go badly wrong if the workload moves to a different phase
> just as the throttling level changed. E.g. if the workload becomes
> essentially idle right as throttling level is increased, the value
> calculated for delta_bw will be more or less the old bandwidth level.
> If the workload then resumes, Linux may never reduce throttling because
> current bandwidth plu delta_bw is above the target set by the user.
> 
> Implement a simpler heuristic by assuming that in the worst case the
> currently measured bandwidth is being controlled by the current level of
> throttling. Compute how much it may increase if throttling is relaxed to
> the next higher level. If that is still below the user target, then it
> is ok to reduce the amount of throttling.
> 
> Fixes: ba0f26d8529c ("x86/intel_rdt/mba_sc: Prepare for feedback loop")
> Reported-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> This patch was previously posted in:
> 
>   https://lore.kernel.org/lkml/ZVU+L92LRBbJXgXn@agluck-desk3/#t
> 
> as part of a proposal to allow the mba_MBps mount option to base its
> feedback loop input on total bandwidth instead of local bandwidth.
> Sending it now as a standalone patch because Xiaochen reported that
> real systems have experienced problems when delta_bw is incorrectly
> calculated.
> 

Does this new heuristic fix the problems you observe? If so, would you be
willing to provide a "Tested-by" tag?

Thank you.

Reinette

