Return-Path: <linux-kernel+bounces-152125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80E8AB97B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638B228101D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75DD524;
	Sat, 20 Apr 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKHpe9VH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9513883D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 04:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713586029; cv=fail; b=Uie7xhMppT3iCVqOdTEPWH/XTItLz0M9NmpME4skq9NxWCDjePwptTqoxs0o8vVx+8wM+vRVSHcZFKSsX5q/fiE6fl86yED5PE9sq5Y5QxRgqacikK2tYEOXuU0jCZynjMs8KrOmp77R3jwCd69+Z8eHA3yPnR8X7s0CQCQ8LF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713586029; c=relaxed/simple;
	bh=Ut1LZJUOr/mqZKjweXLsKr5TnOmhjqOjXNNf41uZKG0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpG/jMKyu1hWHkMHhDqyFBFK/Fy6AxhdQS0h+UmYX30aXKHf3ObpAkVHRSwo+5gepa10Dpc99Np3UNwckd6/l8kDkuNZBO2VasIwT6vagXYwgedvGLi3tMjLvqlUwOKyyLSJSXCBXqpoeOnpFmUJfOoBHovDbP6YrB7w1zS+Prg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKHpe9VH; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713586028; x=1745122028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ut1LZJUOr/mqZKjweXLsKr5TnOmhjqOjXNNf41uZKG0=;
  b=PKHpe9VHJcP9v++mF5YX/+MFkogCn6B5ucSe57q6Cb4PS2IaROf48Q96
   N+6lAcIEP34wMZ8RhJr7M6t3v2MXSjiUH/twA2L/QHzskeOpIAaXarkj4
   /CCXO2ayv3az2s6sNMwmiJStg5tZezPZea6cA5qMaY82dnTvipt/vzV2u
   FwdEFvCZkOwlorIudeMGKhdB8idzQMH00hue/LPJrHMNwU0h1FwHDHvOU
   Eg9F8Em+3VraPaMVZiILLQV4YrLWy7QukkMuz8iM9CF0irWU2DHiJzl4G
   4W0ZZrv39vON9OoBFpcBU6Y85MOkl0TZrRVlgX+uQKN6TMzpqydN5lQRF
   A==;
X-CSE-ConnectionGUID: wuKi58JsRxulMHQcEZEEFA==
X-CSE-MsgGUID: 4LZqAp03T9mlK1aFdO0EpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9033032"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9033032"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 21:07:07 -0700
X-CSE-ConnectionGUID: NBJSNFDAS7Gpj7qJxH9ihw==
X-CSE-MsgGUID: fXUu+uzmQlmhJraGt43kvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="28176749"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 21:07:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 21:07:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 21:07:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 21:07:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 21:07:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2eJo7jkedQWt0FK5KbL0muaEtgNkCmgTXdjfSrUYPU0cAgMMdp4eFnA96WtCSlFQoaHPQbdK+TRfCvIVG0bGAygbizoX1gJU/MYsY1U9Uu8nH+l64EQBHZ25W2mIYK2KA7cAM8Ue51fzlu7bkdKJG/nWipDQjgcPBHrxdh/vco4nN9Q5l6HADzDP7sPKBh04sNlxA/qYSFrLnMpXB9sJI6Rhv0hR+47Qb1sy1TU5mAKZJ0NiJc6JzXK6TQsFPut1aXCW+x1ZEiCaZDnbagv8FIQ/vi5qzwfNgmmcA6OQsFCaPE3ujS4el5Qs2d6uF8JQyAA2MMFC/S0ZGtUzpRT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMYIVQ6vudrziM9/3Ubkie3sMlPlshCNE6zq4W/zT/A=;
 b=KR740HPaHhlIsbA9gCINMsqL7wKEL2SvSLpTNcCCITqeQp8APCKrkbjIm9LFbyQvLW7z1zNsjewARM47zMFzBgaoJK9tpwh1YKmRoynTZl7T2tgT5snrQIFixCN42jsLRZ7rszB4ArFw+TtQ5u6A6BdX/JijV/IGiJgFz6yMRrbZjS6yG0KihhmOM3MNVySosC31xAN7jvzg9AicDF6JWxwDz+nN39vXogm6f7JdT9lDRCFbf6mHbrGy0i0WmZscP+3sV9J/UqYTFqY1W05s+OikWQMBk5Y4GCKBFxMbyK3fGDkaOAP9fUWrZoGVWoocRLUnL8EIjyQ3rMyCOpUccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sat, 20 Apr
 2024 04:07:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.010; Sat, 20 Apr 2024
 04:07:01 +0000
Message-ID: <acce93e6-4c8e-472d-a2bc-5cbad2950661@intel.com>
Date: Fri, 19 Apr 2024 21:06:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <ed23454e-16df-48e9-a344-a6d8baf902a5@intel.com>
 <ZiE8/oXyjBef2qTy@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZiE8/oXyjBef2qTy@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:a03:100::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: ab66b8ed-98cd-4a5b-960c-08dc60ef5454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVUzcnBnODZWQXFuS3FROTB0eldid1NScTNIRkl0R2tPb1czanNiV2FCWVdM?=
 =?utf-8?B?VENiK0FJK1BTNnlHRG5FajBXN3BjcTFKL3FKMFkvcHpyL3JVVXViQ28wbFVx?=
 =?utf-8?B?Nm5pSTVOOFRZRU5zVWRIa3JRMExBdlpVdGltUzc2Uit4Y2p2U3dXQ1JNdjEy?=
 =?utf-8?B?aXcxempMMTVkdklVaDNueHdDblhPOXBMVmIrZEdaK21EeHJ3dE5SRERwSVJi?=
 =?utf-8?B?TWdNaEMra21DSXBldkdCaVZBeFFHQUlwY2R5OUhzeUNNc1EyUTAyNVN0cGN5?=
 =?utf-8?B?MTBMUG1Pd0pZaWh4R1ZXUlY0Q29MZDRGQ0U1SVdxQ3RmQ0owejhyYklBdC9h?=
 =?utf-8?B?amdBaFZUck1Dd1V3SHFKZG5JL2hGVGk2WmhRZThjOFNZdzB4amdYdEZtUllY?=
 =?utf-8?B?SVZmeXpLYTl2MzNQekt4eW5tTCsyajltdHlTZlJlWCtDTDZ2UDRMTXJuQ250?=
 =?utf-8?B?VmJSMmh2WmhyRmlEcERSUnFiQzJLQkdBRG1TbThtZXJkVUJic2w5dlZrdk1w?=
 =?utf-8?B?UnZ6NXV6dmY2NUlIeU52RjNUWnlsTWdDM3NDVGl5ZFdzZHBNMmtyZGJZcysx?=
 =?utf-8?B?aS9ON1VpZTRFbFRjMk9yOTNCT202dGE3ek84L3pDWWtVR1pIUnlTSWc2TDFR?=
 =?utf-8?B?VDlLeEpOQVArdXcyYUUxa0Q0b1AzbkJPUm9mdVdSU29QNnhIRDd6N2FCT3ds?=
 =?utf-8?B?alhVc1ZXTWVOdk82b1Z1dkV1ZFVGa0MzWk9VVXBHL3ZsT042UHdIdXNaWGNU?=
 =?utf-8?B?TUhJSlVkYWNyZVpqNmUwOGdFYmlNb25KdDUzR3pNMlBlSkR5cmNxUFFFbzZS?=
 =?utf-8?B?R3Bndm1PYzlRT2JYNFVjT1pQdEd1U1BSM0g2UDBUMXFHMzNpdkNSSEpvQ3Ry?=
 =?utf-8?B?UVpUMkRFUFlmN2tSNkNFekFnais0T1FTOERaT3FLNlFLdWZFb3U1Z3JYZUdZ?=
 =?utf-8?B?SnpuRFRDeE5tQUlOUlZNYWlVc1BMN0ZjcVQrL2RGWjZUVlI5dnJqbDU1S3gz?=
 =?utf-8?B?QTdtL3VlSDltRWZ0QW9BUXFudTkxNHh1TUtqYmh5ZTJNRUoxNVRHbjlkTGcz?=
 =?utf-8?B?Njl5QlE1bmdTVFlFWVM5WGNMR2ZCNjRkZ0doWTlvSXQ2Wng4VGY2S1puRzA4?=
 =?utf-8?B?WUZLNFRTaFFwWGs4RlVkV1lBcjVNbW5Ubmo1akZRaGxYTytxbUd4dW80aisr?=
 =?utf-8?B?Z1ArUVp5MCtTK094c21QUE1sUmR6OXlWN0h5YklhMEZ1WmxtbkNHRnRaZlRG?=
 =?utf-8?B?Z1FlTTNua1FrQzlxTHFFZ2RQLzg1NmN5M3pTTUd5YjU4dWhoMEQ4a2xEMXlo?=
 =?utf-8?B?L0VYWVZZeFlJVFgvSFNVcGs2L1NnTk04SEdINVZhS3JCUWRtQ1VvZFBZeDZK?=
 =?utf-8?B?Zk9VbksrakhmZ25pcGFjU0hDaU96WHVKVnEzYjczWjZqUjBBcWRqVVNVL2xs?=
 =?utf-8?B?Nko5bkpiamE4L213VzRpNWpCMVh5UjE5MlFaRUpUTnZGOXpCdURsbzl6ejdk?=
 =?utf-8?B?NXNsaGVieVp2MzdxUlFZZ3hzTGhVWUU5U2N0U0dmbzZXTTNIMmIzS3hjemZh?=
 =?utf-8?B?ZjZsVklCYlNtR29YU2tKMmVDbWQ3NjFHMjRHNS9nSFJRTlEwSE5MbCtKN0lX?=
 =?utf-8?B?emVwcStkQmRSbkl2SW1DbnBUbmNpdGxOQ1h0OHoxRmlnY3g1ME5DZFA3bk1O?=
 =?utf-8?B?WTVkam5DamFRd2I1SElaazdGNXBUdGsxaFplM244c3hEN2FqdEdUMXNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF6RUNuZTF4eU5sQ0xiNGRFSTMvcExRdEVFN0YvTTFlYnJlZ2dpWlhHcTVR?=
 =?utf-8?B?Vkd3R0lSS0szSThiRTVvalJpMXVqRThKb2xZL2FrWDFQdXNTWkRCQlpvb2hl?=
 =?utf-8?B?SE5wTmk2dTJrWVhkMkh5ZG5TT0J0eS9TWE9IcUVwazdFakV4ZVh4NmsyWi9H?=
 =?utf-8?B?Q1FBbXllVjFFM2wyL3NhMitDbkJJemNmVERrd1JrUHY1U1F6djdGcW9wOUV1?=
 =?utf-8?B?SDRiMXVMMGhCaC9oN29JTnd2RjY5STcwWmhQKzZ6L1pNRS9uVU9XNGNPTzVq?=
 =?utf-8?B?YlVVWkg5N1JKRXgvV3dDUng4Wk9yanZpL3l0TTd1dUx2V0p0K3EwRm5EU3RZ?=
 =?utf-8?B?ZWlHTXQ4ZDVRbmlER0p3WjF6YTFINThpNXZlcEpXWjBGY1cvV2ZSSUJWRllH?=
 =?utf-8?B?OU1LVFJNQUtJSW4zdVUwMG9VM0ZWUFp0K3hwb3BSYVI5Q0gvYVBPNFFPVTZM?=
 =?utf-8?B?SE9zckk0Q0tFZHNMNkhncDM0dXVVYnlkaDI4WHhKK0Z3Nk44YjdBbEsxS0dP?=
 =?utf-8?B?QXFwSUx4bUFaeUZ2VjIveUNSTzU1NkJwV21IY2QvdVNuZ2lqTVZMRFl6aWpn?=
 =?utf-8?B?Wi9naWxRMDZUSkg5NklrVnFkYVU2em82YTA3bWdPaTFFckV3VkZTRjF0QXo1?=
 =?utf-8?B?ZitYNkZqSU5qT1FSRHFpZG01d0VOWlNUSk84NkJMZmdkcFNaMWVrbnh1VGxK?=
 =?utf-8?B?R1dzZWFTUTQyQTFUMEJ1YjJKQjVHL1dkNG00cjBVbXFxSWdWOWlUck9Hd3Mx?=
 =?utf-8?B?WkpObmc2TE4yTWRWeTdVNjYvZnFKNStsbWRVWExicmQ3SXN0dVRZS09aM2Nj?=
 =?utf-8?B?S1d3YnVNSGtKWHFuQTZLMEwweU1aR1d0OG5VejduT1hWQVFxWUVDK0VRd3V4?=
 =?utf-8?B?VTV0NElsbnZTVkJKbXBEZlYwemgwRnZRTy80cDNtWVhjUk9ldzBRQmY3WXVh?=
 =?utf-8?B?MmJQTDFScmhrTzhsQTMxWVNvZktLK2tLRUE0cEdoQzdiL1lPSnArVkJ1Nnk5?=
 =?utf-8?B?anRBNktkN1JEc0Jvd2MwSDcvVHdzcWJvd1EwY0hqUUtVSUpjYm5mRTZuc296?=
 =?utf-8?B?RVNmMElXUnpRMWhvY2tCN05JMVpreTBmSXg0dC9ia1l5Vzk2cVB4K2pFbFFZ?=
 =?utf-8?B?ejZ2RGlKY2VScFg3L2pmVnBnbzhtTTBNVjUzaW1OcU9wZGVjRTh4Sm0rTFZj?=
 =?utf-8?B?eHRhVVlOd29MdWZvOWRQdkY3bVk1QTVFbmRPZHJpUXZNSXYwaEdlc2N2czZH?=
 =?utf-8?B?SCtzcnNOWmJVS2JYRE0xQlBDMkF4SWtQa1VhTUVMSHdmTG1aYUdhd054NmpT?=
 =?utf-8?B?cnhEY2tYcnhZVERxRExUVmx4MlFVMzM5SVM3QmZhRUZKNEN3ck5SSU9JWUZu?=
 =?utf-8?B?WEwvSUE4Z2ZVM2tESmR1V0MwRERCTkdOdGZ4MEVlbFdFenVvZTlCWlpaMFUy?=
 =?utf-8?B?Ym4rWU9jb2U0U0RrVlRITnJUckQ3L21aVExpTlBtWnY2L0x2blk0Y2hWYmNG?=
 =?utf-8?B?YkdSekZSdEU2dDRTSGlXZDg4OHpEbnlWZ25UWlIrQm9HcUR6UzVtVk1oMVd3?=
 =?utf-8?B?ZmZpQXZzMEhtZm9PWko2dUtKYWVMcHA3dnBiRE9QOFlLRjFUdUJSOUdYVzZx?=
 =?utf-8?B?Nm1zK1ptejFlcVBZR1d6dVBXY2ZhVnFwMGFYL0lraTFOTGZTak5Bc1FabUpI?=
 =?utf-8?B?L0luUjdzb0d3WElWNWNNUlhwNUlDT3pDRWZ4cGRVcFZ5SFF5Vis2WlUxZDJC?=
 =?utf-8?B?ay93YnJYeWprblBwSWdtaytKd2w2R2FGcEpoS3Z2TFdzOHpOYnFtdmcyc3JM?=
 =?utf-8?B?ZHZIVGpFb2U1VU5WRytGbk1ac0pOQWhMV3BiK2RQUGhrdkdqQmNqQk80RVRm?=
 =?utf-8?B?RnJjWFZoYktUKzFVeWo4Zml3Y045SGhtNGd0d0JlUzNHZlZ2dGR1RXYrR0d6?=
 =?utf-8?B?MmNIT0s0OHNxU1RkbVV5eU56SE15NHF4T2J2clF6Z3piYW05TG80ak93ZXZL?=
 =?utf-8?B?WTBiY0ppV2lmempxb1Q4dTNNVEJ0ZnprMVcxSm96MlNTWmYrM29Vd0lSUFpy?=
 =?utf-8?B?WjJ2SldWTUsxZ1Z2WmljQTJuVzNnWkpwVmlkbmc2Y0w3Q0hTcUtBMi9pYXBS?=
 =?utf-8?B?QUJvUUlkcGNNQ3FiUzhaUkwybUZaWEZUQm9oMWRGeUhwQm9xb2tuUUZ2Qzhi?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab66b8ed-98cd-4a5b-960c-08dc60ef5454
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 04:07:00.9110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPVN4R0HNRSCXb0kSUb9APgD4RmHU5VaHaxRuylZCyxn/nGLkY71bncGj6qyAfGW4IR4D046deZLKDMdjDYltBTaVM0/u0ErcaNDPEvHtnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com

Hi Dave,

On 4/18/2024 8:32 AM, Dave Martin wrote:
> Since we seem to be getting to the end of the outstanding discussion on
> this series, what's your preference for moving this forward?
> 
> James will be back towards the end of next week AIUI, so it should be
> possible to apply most of the changes that have been discussed and post
> a v2 for review fairly quickly after that.
> 
> I'm happy to apply my fixups branch and post an untested "v1.1" for
> review if you think it would be useful to see the de-noised output of
> the review so far, but I don't want to fork the discussion or create
> unnecessary work.  This interim respin would be subject to what James
> wants to pick up.

Please post v2 with discussions complete and feedback addressed
(unless there are some discussions that need to see how other changes turn out
before they can complete but I do not think this applies to this series).

To create some expectations, when you submit a new series it will go to the back of
my review queue and at this time there are three other resctrl pieces of work
waiting for review (btw ... one of them, [1], is waiting for feedback from Arm). 
 
> Alternatively, I can try to follow up on the string parsing discussion
> from patch #3 with some real code if you'd prefer to get a clean
> interface in place for that.

We can keep discussing that, sure.

Reinette

[1] https://lore.kernel.org/lkml/cover.1711674410.git.babu.moger@amd.com/

