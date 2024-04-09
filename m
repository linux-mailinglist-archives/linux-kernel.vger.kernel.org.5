Return-Path: <linux-kernel+bounces-136196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F098489D0FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53CD281C54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AE56B60;
	Tue,  9 Apr 2024 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="adJem8DX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A70856455
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632896; cv=fail; b=CAbYl3fh2XGdgAKjBGJYprPfOd3iMWP6UlXxwZ9n81qLCoiBoCBemkwgZjYytxejvVEofpJnqLXI+ma/gtI+zU3YE72YzMZOQ4w0vKXvedIUJELyQQrOlY1zniov/AXbqKJx3qY2PDs5vYP5ZUBUtKT6peGPTVkq+SZNEwhbRLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632896; c=relaxed/simple;
	bh=CK2El8/W/QaFS0OJ97KaXk7sV2hxLC6YigXdiJ0LKC4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAldBype5nkr0Wu2zB1Re78Pk4RoT0IqnQ87OG7QT6C1l6iwvgjSYjbASxPYdi8CZpyNKA/LbWQ/x8qyjxuYxDotXq25ljdXVfRLFnOdupMKgQNBcfLotL7K4Dqy2EbR4i5VwLQRfVYa9CzG+Yu51E7u+HUToEjLUCWeC7x4lOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=adJem8DX; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632894; x=1744168894;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CK2El8/W/QaFS0OJ97KaXk7sV2hxLC6YigXdiJ0LKC4=;
  b=adJem8DXzJUM8dxAkzlwHo56FMqF7eDLhMVeV7WCjMnrbJkIyzNctRKZ
   8YNA6gXead257DwufWMiuW8l9vLpN2xdQi9WTgEn2wvezT3lQK9lcwRNB
   W0+2qVNROt0rClf1uLWqNxNF0T4dQl0NqDYBl6fhE7Hy4XZj1mF97s+QH
   h4RI3CW5pfOboIoyPk9sk/Ncv7V5Y0bxz2aVbfM591Kcv2TtezwH4W7NO
   LQEURhwxhlYkArWhXLJmgUWCSw9QI03ATEgVf5F0VD3fJO2SlT3lyOSP/
   BQELUQH2eJ3/k8yZB9EW5H8ucbsNo9bKdUTEkfXwHJRs/fPiMq4fhpwtY
   w==;
X-CSE-ConnectionGUID: fBL7ts5USBS/V9L+6wUing==
X-CSE-MsgGUID: g2ecfcEmS9i8lbgUG46cvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7847636"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7847636"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:21:33 -0700
X-CSE-ConnectionGUID: nOfdk7RzTC6vP5g5fA4qgg==
X-CSE-MsgGUID: DBuqZXCLQh66kRZJ2rIpzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24729751"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:21:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:21:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:21:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:21:32 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOT7junjPNaClh1t1nqDYnDQTCPI1v/9zPEBj8l1juJuwm4H8D9RBVhvHjiIaW5bAM9/mDn59jh1olwRHfROQMRhK3hEVUDeC/7JN8DjSl0vxpV+lXfqwutSCN+wFuDNuwb1nQlWVjPmkkxzP6sCvNpG3GoEgdeg/Tf78U7Q3cNC258HVjSuEieXsiTxQSICQnYhIZbok1NT4EZ4wx+6SWvHDsD6GIKG9jONMG2SX+UOOIEgk3I25rROZt8BLjjYaIygHkr3aUQ/WqpGqxnvQ5c871VdORpxNqGy8lNcOBkxiSRPpaDFaOlIDjShu5kdLO9jDDuheraRZeVP9xxGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzrhis0Lf0LdhLiRxwUqAQl+CgwSmtrC1UY61CXUb9E=;
 b=HlbbsFrDXhZrpNukr9Mc9pdsv6QuIIpWTCTUUheysnbYkg835RFjwjQ4IM6fnN7JOZR98HppBQI9FKKr/TUqnkxQhpKO0UXnTbsb7cN6ZCv+M0rw7v6rgK2LI1d8KoXphPN3nrwEPi4UMUK/H0zrFSBH1DfYdzjumnxIvtNfwEIRemTj9XibhIsgmUut7A/Iz5/XUrgiu1bfBosVaCQknZvtCxX8ce9MCAe05Z+i0fG5beBzANLdxhW4CmA3qbyIGS/AloW9ZjGiCvgoo3L+KwhFYwOrVyARfeaXT1Lm/wU51bJG8bdx6HJUwCOGI4m/jw752+voadtJGGoFcZSmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:21:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:21:31 +0000
Message-ID: <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
Date: Mon, 8 Apr 2024 20:21:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-18-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6357:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VicSGk9HJX+58s6DFnLjkUYqCPzOggQPo86Ki0nRPupLfhuz+pc1nNnANErAXSdbiIjlPilB1qf2UwyT6GoyshI6nPU2pyFOmrBgktv0DWRVHoQYHwWCFgCJ+yALDs/MDcY8Rwh3qw4LIoUwxWXWcU8Mm2K2KDa13YCOPqzi9/S/jhvHeDgwxP0Cy/70v94Tm2pRt3AvApaumlXNyW3v05Ogf1uZuXUZhSP8qQkMRx04lT89O3hQBcjJlFGaTPbixtK0wF/Rb3TKWYaKmgjqAibQC03I7SAnDErihyDZo4Ok0Q0su7RM35fGqYn1xVnyrbxaHZJ3ZM91dQyZirw9JxaUtcRiGlwggnjyI+vCkZdxDiyyvqfMmato1mW4WRCQqu5GZNYq6r+l2vGoMYSmDMEcExgH1Ya/lXQyrQRbon/8IsgPZXXinYmSYD4bG7J4E83QCWPaiXPDguSYJdb2YJ62osrnTC8oib33/4v79v4QC1ztOT7G4FkJ7x9EegPrMSNtjw9gnIt/ph5KDPy/kxduBcziBbWG7RZB5OvzhWG2eGM00zUF5kvoYf5RAYVVxkt6yc0YZjBK1UsxwNU5IRt6gGBAjqz0/ikKcCSppuGdW4FzPX+DmDYHbW928ciHu46wylDTiOnvtDlzlocDIQlqT6bFJfE6NYZqatLaWS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RklBc3JEcG5XNUtZWG4rQzRheGdkd2JyL0R2S29LdXRQczJicnJVcXAwTkpI?=
 =?utf-8?B?b3ZQL2Y4UHZ6K3BnRmE0amY1NmlYTVo4YTNWVjBHejJOS1JnRXZ3WmQya3Vy?=
 =?utf-8?B?ZFlwNm8xWDQ2MVZ4dnJxYVVpeUJKV3h5VER0RkVkUEFwdDJWNEtwUmt1NjRs?=
 =?utf-8?B?bFppdWU5VmNUbFZ0N0lBVmVDdmx1RTQzYkU3a2Z5TG5XOXFWbFBFZ2U3YUN4?=
 =?utf-8?B?NG9pck1YYTFKd2lWcDlid2g0S25IaHF3Vi9QTjVYYnFyNWJkRnBPMFhFRHdl?=
 =?utf-8?B?a2NITzdwMW92YklPandwZGp5RU91ampWa2RVbTRpb1pHWlJ3UlRxanZsUnlH?=
 =?utf-8?B?V283bG51cjhMc1JSbTIxeHJZRWdFRll0WTdQeFFhQUJWRWJteGd2WDlyNVQ0?=
 =?utf-8?B?M2JCeW85UnhsNUxXbjRTRmhNajJ0UDRlMG1XRUdyNi9uK1FGM1RSbTFNakNL?=
 =?utf-8?B?a2pqUlc0Z1V6cFB0a09nQXQ2MXJTd0dGc3BTeFlUbHVORGx4SENMUnNTamxn?=
 =?utf-8?B?eFJMRTUxNithN1liekJTYzRCWWJLV3U5Yms4b3pBdmFpQllZTG9OYmNzN3c3?=
 =?utf-8?B?ZTQvRGdUMTkrQnMwandIWXp1b2dscjV4VngzZDNreFhaMmx3T1dkc1M2TFdF?=
 =?utf-8?B?TFp1c0l5WG1ISG0xNjBVWE84S3FGcThYdjB4U0Vqdjl5SVBHU2NoSWlTNHRz?=
 =?utf-8?B?YmxMUXpiZ2JjRVJEUVh1YXBySVdTa0ZhZ1A4d1cyTlJMd0lBQ2NvcnBYWFI3?=
 =?utf-8?B?Yk96MGN1SEhUQU1uRk5rVXhOeHkvaDJBbXRWVFJjS0J3SlRvUU8vajRHMTRq?=
 =?utf-8?B?MUl6R1FMUDFOaEtmQXFXWkQ0dmFZTlJrRFJTR2haYk4yajFpMmZRVWFReDJ3?=
 =?utf-8?B?R29pRWpLTkdyL0UwRHZzMkliMVZUR1FUcXJZcERDOTBYQmpLZ2NQOGtBQnJ0?=
 =?utf-8?B?YmE3RjZYRENKQ3h2cDJ1bkYvZ2QzZkdIVGI5Nm93TDcvODlkQjF4b29hVzdJ?=
 =?utf-8?B?eFUybHB2TUJIak9McldoTGtzS2FhamhpKzZpSUFNeVVEVlB4V2owdlBTSFBw?=
 =?utf-8?B?V3kwZzl0VWhOeFRaaUlkS1gvYjZ0YnpTUTJxb1lXczRFdnZrclUzd0NycUNW?=
 =?utf-8?B?QmMxMjAvZ0ZGeGx6VXZ1YUgrRjNnNzFzZ2p6UDJKdXMwNW9iZW9rWkxVdUV4?=
 =?utf-8?B?NWxmUmRFUjdnaGp5aGlacEttTTMzQXcrTDFjcFFOQm0wS0YwZ3orSUMzSnlO?=
 =?utf-8?B?aWpGK3JJOXpBd1FRRkZsR055Z242VU1ONTJCVnpXZG9CWUQ3VnBYZkNvYUhL?=
 =?utf-8?B?WWk0elhXUWorVDFGeXB0aVZCVHlDNlVaMHJhdy9pZ0xCTXArckh2eTJxaDM5?=
 =?utf-8?B?SDViMk9qZ05IMDJxb0w4ekNhTkxjRlB5MkxQOUkwOXcwL2I4MTRoamprTDFk?=
 =?utf-8?B?MFgrNHdJZlJFNmd6UzRyanZGb2Jzb2UrVzd4MzZPSTc1NnZmMXR0UjRIOTI4?=
 =?utf-8?B?WGZ3WXdFVVNCaWF0amFid3pwSUFRSTErYTF0NklmM2RNZFgxQ3djQk9na3Ro?=
 =?utf-8?B?RjVjeEorRWc4dVpjU2FkMHdnRUF1WUllRWhRTThHdndtb1dFcXI3c1poMEhp?=
 =?utf-8?B?cngwTzhyU2R2TUFLVzRCRDdaVThnM2dIbmFmRXhPT2c1NmVCVE5ndlU5bkt2?=
 =?utf-8?B?d3lEZmFDRFk5cmJxYXUzcHRxa2xKbnU4NkhvNUZheEptaE8xTzR1QlJVWUVk?=
 =?utf-8?B?bGpYWU40NDNiRDVWSVJmUWlaMGJWZ1RSOUlObjhYQTh5WjJFQWxOR09FbmJ4?=
 =?utf-8?B?YUFSWU9iNVlqWEZmY2Y4SnVhNWVFMWg1OGlaOThab3FhaHZYRWdhVUdVNmNm?=
 =?utf-8?B?QkRxU0ZhUndVaVEwV1h6c3lNU00zemdScERpTUVHREF1cHdiMVFKYVNSSEU1?=
 =?utf-8?B?ZkJLUXJ6KytaM2VkUWp4VU5tSzR4UTJJaDYydHQ3WUljNDJPL3ZDeE1yVmda?=
 =?utf-8?B?dUxBY1BOOHljNzk2ZWRzOW5PbTJEWGhGNUNNSk1nalJOL1NIdDJhQzNKU0Jl?=
 =?utf-8?B?RTl5aXQvYldYT1hpQXhWZm5KalRqN3JHKzdGZUt2dzN3T0xIZjRXL3VVNlpp?=
 =?utf-8?B?Z3h5NFU0Sy9RMER2TmNOUHJOWUlDYVJPc2ozOXpkYWovbHhvYmJjU3dRblVL?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99657219-c10c-4aef-2347-08dc584426a4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:21:31.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct6zAhA1eP+zE7D8uAA8AUamHYSOy2DRixrCs/LRNpzv7/Go7QzpRFteEv6m/W9mV/eMdY73vxcMnKf3cvK2TeSecS+c1d35irNP3f3Th3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> The mbm_cfg_mask field lists the bits that user-space can set when
> configuring an event. This value is output via the last_cmd_status
> file.
> 
> Once the filesystem parts of resctrl are moved to live in /fs/, the
> struct rdt_hw_resource is inaccessible to the filesystem code. Because
> this value is output to user-space, it has to be accessible to the
> filesystem code.
> 
> Move it to struct rdt_resource.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

..

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 975b80102fbe..8a7367d1ce45 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -140,6 +140,8 @@ struct resctrl_membw {
>   * @format_str:		Per resource format string to show domain value
>   * @evt_list:		List of monitoring events
>   * @fflags:		flags to choose base and info files
> + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> + *			Monitoring Event Configuration (BMEC) is supported.

BMEC is an AMD term. If MPAM is planning to use this member then this comment
should be made generic.

>   * @cdp_capable:	Is the CDP feature available on this resource
>   */
>  struct rdt_resource {
> @@ -157,6 +159,7 @@ struct rdt_resource {
>  	const char		*format_str;
>  	struct list_head	evt_list;
>  	unsigned long		fflags;
> +	unsigned int		mbm_cfg_mask;
>  	bool			cdp_capable;
>  };
>  

Reinette

