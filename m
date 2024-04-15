Return-Path: <linux-kernel+bounces-144610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA78A4865
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A29D281A01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4822200D5;
	Mon, 15 Apr 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh/hL36L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DDC20317
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163969; cv=fail; b=DyQrTpKRue60fz/a7g8s9BPH3P2YmBMnMJFJPatOogJ+fJ3uQprhlM7gL5Lbq1qIGrcvf+9IaEZ9gr7rhymWqBFe4eDgJPwH4/Z/IJFXEEWq5mV8f0FiT8sp0X+V1zAvaVTA7K1uJ06kcyFMIfGDcByTAZpn8AEBwgjgWnECf7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163969; c=relaxed/simple;
	bh=y4P1z/2340BRg2DECk0HF0vXyq8knyBZQK8RVaqhPvM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c3kD3ReR7+mnpEfM8cPf68Ptq6YP5iwZ+xhAEepvyS8H69mfx+YUnoo3fOBrxQbMhbHHgRKU9JV9RcAsnPZo4jvyriDbk9lPxPG3pkVPWAkjLopuvhNlJ5pXbdDEQmIzp1dWZKN+w/WPIBn5ckIsPuM0ypIqH13zzphvpVIX79Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh/hL36L; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713163968; x=1744699968;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y4P1z/2340BRg2DECk0HF0vXyq8knyBZQK8RVaqhPvM=;
  b=Fh/hL36LK9PKsWF3pyRCF0LGsMD3yeWSrFDHE6G9xRrgt17FPlYyMDq2
   7y+Zn8pzH6+EG4T5yPzzT0MxwQ31M1dYhf8Dz63ukCN1pLStVbDjZuACY
   SMIKI9zGcFd7n/h7fliWhe0n5cJPFacg9mjWn/8TdXCQ1mspknSNbnMQs
   PdecmmhCbcclwHjqxIfWhQQTZOjJfxE9Pc9hjRrk1n7+i6Oi3VujIa31E
   wlIVXLtbSyOEx7gRxKrmeT59sVVDdvDzsvoNTFxJOKJdGLDiE+i0TOcB2
   Tk18YD15fEc4FcAcv5a1V/yt5XSp6Kn/cOPXIO3N/Q9yKR8ocHfk5LdoQ
   w==;
X-CSE-ConnectionGUID: PG+gNHIYR6im3TqWMT0JRw==
X-CSE-MsgGUID: NDMMnB7PRj+p1LCOPtNsMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="31015669"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="31015669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:52:47 -0700
X-CSE-ConnectionGUID: AfSSknZNR2eNIdbWTybfzQ==
X-CSE-MsgGUID: EtW8gwMpRcO+DrJoG3YGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26618357"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Apr 2024 23:52:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 23:52:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 23:52:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 23:52:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 23:52:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clqLKqh88wv9891/XUx3n0rriiX/oPHSKR9R7kHB/GYGbmtkEofs+D6lnsNvrj/DXNmXFds58VHPooLPy9VsuXRaukNrCoauruBu6ECRBXToeD8UuUaAx/qJNPY5cWQqJAKf1WdvQdlKuggmwg36KPjRmsYu8F3z/O9tLhAo7UG7Qm3R6VleO84ISJkYsb5SqHNE3OJnHzN4vedk9bEda8o+wT+edofZhK+mGnrF9/etU0cmZms0RS4U3LLaM1LF6E8xivS2MhmJ+u5mFz7Sj/5WV9Zs0FZjkCi5XUh1DlJuYUIeUYbvjA0KhURNRpaOGIIbQrXy7dbgoCUm+9nWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAbxduK5PAP+rr6u5xfG4nnabp5qm5AyZ3V87QhctbU=;
 b=ECxipPVfDafEJf2aj/CSeBz/qKYn3NgJJAvOr8Vl5t7Y8DGyQZ6b/aykgu6jhFmIDj/8CXMA35YLSaBX8v24X++Cz6Ci6wP7U0JAV9GyfZqsqQ9WbYICBvngMrMJSM++swpL/nz4ndxfDr48ivTYh2BPZ/iWRyDl+YnSOJXrEEG7xhsYCfS/UrGee1D22eiC6ElCY1/es6ZS1oqiSNLUjTAkgmwrf/hcaSsE1RAkvYzIY6FSqCKCD4W/7tay4o9+cpW5iJaW0aOIH5XXEkJAkoP28hVVZC0uSZzKuediew+uqYhJV1sDYTmkvDrZ8Ippsn7X6RlKuq7BR6QyLwb1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 06:52:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:52:44 +0000
Message-ID: <66c09ac9-0107-4b86-993b-70ab6907fc21@intel.com>
Date: Mon, 15 Apr 2024 14:56:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
 device TLB flush
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240415013835.9527-1-baolu.lu@linux.intel.com>
 <MW5PR11MB58818970CB8E9A37A6AF563889092@MW5PR11MB5881.namprd11.prod.outlook.com>
 <f3502244-5f37-4f44-94a5-39939ba20eec@intel.com>
 <a5c4b57b-c1f8-4f75-95e4-9a462f4673c9@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <a5c4b57b-c1f8-4f75-95e4-9a462f4673c9@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 938bc54b-1a4c-4bab-0ba2-08dc5d18a6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWEclh0Lg4oOrYMXYCFslLdcM/Fr0epDUgPcdxFBGV5Iccp+B9Q25t2AOQW550wBAQPEMi4wFUDlXCvEhOe12lakjRkzMzKUw0EcVWGEzJnyT21KgLvK4l5nGqpD8UOi1mH4f4oS3oik5k32KUfGeRD+m3fz7pNFAbluBm4aGBNvvXuki6n435SFcppAoUi5+Z+fbE0FdolM/VbNvaOywtY6qSLsfeq0jaKtI44A59M5X/Ucwk/IYNosia9680nCiHV+c2cVBSvZBkOZwIxCMngUiqNiuqLxxDWmktrGEHgyaKzfPI8J0vspUjb7MoMmfDI1AZi4cov/vHo2DJxcGPtVQUzk59IBt/OLHJZ1U1oiL5yDQ57JjteRNvxrgZGHHaeeAB5tUUrtrXkRa6oH2qaB7Pf57eI2TO7UNZT4/gATcIM8smDP6zv76O9QIiwc0jjuOeJ9OPzx15GSf2vCIt/oCHn82Qg1VZCPcLNunjK29atM9uOpDbgm2J1FIV60OOWkoymdIoj3mVIj5WbzJhaPBLlbqOEJOcRUtFqL7n/5QhElWKU5hQSckW543MQGEWcOVSQaOId4NrgC/IlXC6eCmfiXhVC1DrqNv4uuajlxLXRQ90+8+eSjT9WP+LAaTiS4O+4EAY7S5NIKt8SxlP+KtrGJpJO9ESdSko63u2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NllmeVR2eUtaYmludVNpWUNtV2FMdHpnU3pNU1dBMHUvZXZBT2ZRMEtYU1Rn?=
 =?utf-8?B?cWUrRk53dUMycHhmQjlSS213YTBSR1F6NUxFRk9nU2FaR01aV1BGbU1LZE1Q?=
 =?utf-8?B?eE5xeGZmMTNzZ2l5NllRYnRiUDFZMHg0dlJRWXJIYko1VVVsUHR5Sk0wdnZ0?=
 =?utf-8?B?aEFWMExCY3JIYlNudGhGaXhxUzkyNVdSVHgrVzFsbjFjWFFQMmt3THJ6aVR3?=
 =?utf-8?B?UHEybXVBWDVsY20wWnBPNms2ZmxibkNzL1lDYW9MT1FOY3ZrakhIMFF0V2RN?=
 =?utf-8?B?Y21TcXRoN0U3M2piTEZPV1A1ZXFPL0JtQkZSZyt4dzRDVFRoS0hhWlQwc2p6?=
 =?utf-8?B?QUsvZG9uWVlpTTM5bmY2cUhITTFHU2ZzMHVUeGkxU2JVbzhZOTd6TzhodFky?=
 =?utf-8?B?UWx1TGVXcnR6Mkh5dzVYUWpMazBNdVdJYlUySzV5aU9pMFhUeXR4K1JzZlZl?=
 =?utf-8?B?V0thTktKTW9TclZaSXd5SWNoSFVwQXdsNllxb3BFNUptNjlvS3JWa0VFNElO?=
 =?utf-8?B?bUdNdS9yaDhlTDlkZkJwSENCR1VXYjdoSGdaY3ZtZEp1U1ZKWHVtVjlKSm5I?=
 =?utf-8?B?cEVrMTUrYzE3UU4ySlRYSUhrN1lSaTd0ckVsbGhIYWs2anJ5MGhsZUQrcUZ0?=
 =?utf-8?B?T2JDbnZQQU5NL1EyYWNXSjQ5Q2pubkxUNFpVcktycEJNcjEyUEdkMFFjcTN0?=
 =?utf-8?B?enVRcTc5cUxxbG1qMXNXOGkyWUp1V3BqcytyeHA4Q2UvSmVSWDJpKzlpK0tp?=
 =?utf-8?B?UmN6ZC9kd3RGRnBsNVYwQWFmeDZPK0VLQjI4TU5FQWZ5alRjOXpBbERWRjVn?=
 =?utf-8?B?YjFtS1RxbEtqVER5Ny9sVVVFWkJSbm9KWGhPck1IL2tNVlBiQTFlYUhYY0Zh?=
 =?utf-8?B?YkNQRzRET05IZ1h6MlpMTzhhZi94MUlleklPQUdRYW9xRndxZzRsdTZtTWw3?=
 =?utf-8?B?MmZJSXM0OFRRekgrRVJRU3RMZE9zTW8ybHdQSVYvUlNxejRzaDR2bUhyUU0z?=
 =?utf-8?B?Y2xEVzNFbWFudDRYNkw1TjFUYTY1cEtpOWZRQWh0RUxHbnZlaXRISTVLUkFN?=
 =?utf-8?B?UHZ0UDk2bllQUVRZcmZESWNoV3FpNFNCaXZVa05nMXM5QXQ1QnBheFAydy83?=
 =?utf-8?B?UnU0bms3dEgrVXlsVVkrZFBjdkhrR2RvZWJoT1lMTkFkWUlaRHQ4bDIvM1hG?=
 =?utf-8?B?cTRBcU5pZUh3WHMxVFAzYjMrdllMSVFQMURuWll3WWkveGhScGN0dXNlL1A3?=
 =?utf-8?B?WGJUU1owMVFEcEJtNkFBaC84UzNjaktYQTdQaGdmUDAxcGRZOEtiVzMrUFA2?=
 =?utf-8?B?VlhIemdLK2V3bURvMDFwZ21LZE5IZjJtUytnWS84ODJFNTNHVXpTZEwyUE5K?=
 =?utf-8?B?RXBxQm5VMWovSUxKQ252d1BhTlpUSG5nUzVFRVM0V1VEcnNWaVM4SGE1c3Rr?=
 =?utf-8?B?OGNDcTZ2MHN5eFV0c1l1STRtR0ZQZ0xWV0s2czBMdG9GZmE5cit4TTRIUHJi?=
 =?utf-8?B?UVV5TktWS0hwUDlSSE5KRmZXL2JRcnpGVDFlYnd6Tk8vS2lIUTR3UW5xay9P?=
 =?utf-8?B?bnhtdFJnb2kzVE9GMXVyZXgrem9JL09qMTNFTWtVdkkwWFYrTGRUS2N1ZnNz?=
 =?utf-8?B?Z0dRaVdjdmdjV2o4aUFmVHpTMmtWZzhoM3BuMHVNcUpqcmt6dUQ5SEdxZWZP?=
 =?utf-8?B?RWY2cGh1VTJSdHgyLzFUckJvTlhndkRQRit3TDVmeXhpRWNoVG5xZk93YzZM?=
 =?utf-8?B?ekM0VWRibHdVSXF3VlhNNXZ6K2IzZmlYQndBekdYWGhqbTI5dE5BUnZxQXNn?=
 =?utf-8?B?QWdpVXN5QmtLazdPK0IzNUhTT2EvZ00zYlA4cmVHN0l3ZERMWUI4aktOYXRh?=
 =?utf-8?B?Zm1xN2hwYzVIdGVxNG0wVWhocmNiYUNPRHk1V0RDSTJuT0R2VzIra2dqWkg0?=
 =?utf-8?B?VDVpZmRsUWt0RXpKWnVXVmMwMHlCYUI0dktQbStISXAvZ1FMQ28vd3BwOGpo?=
 =?utf-8?B?a0tIS3FRdERUZjdQTlg4NVJQM2lOUFVXaDJJK3NYeU9pQ2R6OW9oa0sxKzY2?=
 =?utf-8?B?Ulh3UmRGZGtKWG9qODlsODlLU054cHJhRFdaUkt5aUVvVjRPYnR5aXZWQ3RW?=
 =?utf-8?Q?Ia6L5QZp+jyFdflQ63joz/BS9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 938bc54b-1a4c-4bab-0ba2-08dc5d18a6b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:52:44.0231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gA8KTlsJth3PPiLya61EDu6Du7DMpuK0/rG4WxUk8k/gZ0eHruWizRZFWlBu8gHyGlFvHcnrJWMnIgKA1C+3IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

On 2024/4/15 13:00, Baolu Lu wrote:
> On 4/15/24 10:43 AM, Yi Liu wrote:
>> On 2024/4/15 10:22, Zhang, Tina wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, April 15, 2024 9:39 AM
>>>> To: iommu@lists.linux.dev
>>>> Cc: Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; 
>>>> Jacob
>>>> Pan <jacob.jun.pan@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; Will
>>>> Deacon <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; linux-
>>>> kernel@vger.kernel.org; Lu Baolu <baolu.lu@linux.intel.com>
>>>> Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before
>>>> device TLB flush
>>>>
>>>> The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
>>>> implementation caches not-present or erroneous translation-structure 
>>>> entries
>>>> except for the first-stage translation. The caching mode is irrelevant 
>>>> to the
>>>> device TLB, therefore there is no need to check it before a device TLB
>>>> invalidation operation.
>>>>
>>>> Remove two caching mode checks before device TLB invalidation in the 
>>>> driver.
>>>> The removal of these checks doesn't change the driver's behavior in 
>>>> critical
>>>> map/unmap paths. Hence, there is no functionality or performance impact,
>>>> especially since commit <29b32839725f> ("iommu/vt-d:
>>>> Do not use flush-queue when caching-mode is on") has already disabled
>>>> flush-queue for caching mode. Therefore, caching mode will never call
>>>> intel_flush_iotlb_all().
>>> The current logic is if the caching mode is being used and a domain 
>>> isn't using first level I/O page table, then flush-queue won't be used. 
>>> Otherwise, the flush-queue can be enabled.
>>> See https://github.com/torvalds/linux/commit/257ec29074
>>>
>>> In other words, if the caching mode is being used and a domain is using 
>>> first level I/O page table, the flush-queue can be used for this domain 
>>> to flush iotlb. Could the code change in this patch bring any 
>>> performance impact to this case?
>>
>> This seems to have performance deduction in the nested translation case.
>> The iommufd nested support bas been merged in 6.8, while the Qemu side
>> is wip. So this performance deduction does not happen until Qemu is
>> done. Should this also be considered as a performance regression? TBH.
> 
> Caching mode is irrelevant to first-stage and nesting translations. If
> the QEMU implementation still relies on caching mode for nesting
> support, it's already broken.

For first-stage, yes, caching mode is irrelevant. But for nesting, still
be relevant. Because it relies on caching mode to capture the mofifications
of the pasid entry. Without caching mode, vIOMMU device model within QEMU 
will miss the newly setup pasid entries, hence no way to setup nested
translation at all.

-- 
Regards,
Yi Liu

