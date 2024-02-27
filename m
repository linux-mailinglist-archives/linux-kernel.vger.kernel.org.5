Return-Path: <linux-kernel+bounces-84093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68D86A221
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFAE1F22D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33938153512;
	Tue, 27 Feb 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad50Uf+h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03381534EE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071524; cv=fail; b=Hx+cSY71R/Hd9kf/oOvoc867Op0+NrAuHVi8qW4FQjXm+K9zI6Cd/bA1AQdsKRNUBahs+ffY9YqoNX2+tz7dlCH9cJ+zm55JP15KF9qxYk1Z2S4uoKJPnDE6hICcvtc7pGDb5FQcK3xFbsOzAZLz7yD33RY0PglQOMZl4n9N4qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071524; c=relaxed/simple;
	bh=6vFgWtD9qNIGrHfSSSHx2E5LAk+/8NM1jZr7hxHWIjY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hsvglx5FkNbP7cckqWbXwEPHPzlE2a6fNjRVzJyy+RBwq2F3C5pAogwgzLrKcYu9cImCm+tjkBmv1b8XMfj79o/SB4HcGv64TgSLGRP8DgVsipqRSFE5JliJKRaMS3m2uqdk1puNSbEJNH35M+m0VO11+EPAUeDk6VLSl4EkVtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad50Uf+h; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709071522; x=1740607522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6vFgWtD9qNIGrHfSSSHx2E5LAk+/8NM1jZr7hxHWIjY=;
  b=Ad50Uf+h6X7G+t01tZagsZLjwR7TkxAhGsfJckZWiVVTpTr8wuHtPvK0
   +Jc1gRUlxcCqEmpTn3lfIynF6DPeLNMNjsj8qdpQPOi8hmb7OQk6NNp7Z
   OrJLo/cPHzzQxve67YqNbfB4zisZcaztUC4nv6KBHQdDzqNCeHg8ybEbE
   MNICJ0whiIH5nzZ/8DnMb2RlaI055Wau3C7bTDjQawHGeKMKwSJJCokHD
   E+KYZOMu/2eGaVLATk+8ow0k0zYWbJpM/ArnYDlkSYwfNKYOHc7wUGPbW
   4bZN62MwAaEWEGksonNgCNy4JvQAeVU361Y9eC5Vag7Baifs7zMbvPnTb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14884327"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14884327"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 14:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7633480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 14:05:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 14:05:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 14:05:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFPhS5CcArD7nZrp4RknGyol7m4MtdG43wt1M1oJUWdYmr2PlLuDWj2RXUo+PZRvtVBe9+XBbyHwVHv5r0qgDPX2e+EnYEMYrICR6kpVtaB5ydwzUVkVCvNPjNpiDong+2ESD29FwN6zenreojCxC1CX67W7Mx9AX2/OBUNNtIl6BhqQBGEmXPlwN4262ib+R2iW+1UgPrGqdldHW23a2e9B/18QpEVMsa9w+bTsz2HaKAasPJ/2vrM3Fk7K2DOastBH4XYUvqvcSouUgdQb2XGxQ1kPtlSqCRZMOcLehqFAx59fvNwW0pVCxAfXMdfAyjtyXMtahvX3PODyl6AuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxvx5Nolg+vN/KtSFUR+trhYRKTAHfqMPTbi08GPdPw=;
 b=KbiyK3SB8OweAbv0hfdUKMs57lAVfhR8Imk9YFpLETFhPen/+JMavtC69SIyanj+t/6CewS32Z6SWBEzV4giu/J7dtokcX0em/wZPSXdUUmSH13YOZsggxM1nKFzlBW6CqUxHEiXPQ4TUakaLquW4H5fIUDXo4DYptQN+QhK12FRIGZlXkbPsxEJ8cbi5lffV8UWhmmpxBlKiz0H7KJz1wCfAT55DBjES2UPqQ9qBqioHxAeD0z8tzXNFbj5OpAxvde8uNSR8zJNWCT1TI4qfnEwGbDn+N8EfjQFQPY4SMQqyrfFbYymcgDP1uK2D8uYuin4vvyTbZIi+65pzUahpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8589.namprd11.prod.outlook.com (2603:10b6:610:1ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 22:05:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 22:05:08 +0000
Message-ID: <be17b788-dda1-4671-a037-6d79d383fdc4@intel.com>
Date: Tue, 27 Feb 2024 14:05:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240222185039.72201-1-tony.luck@intel.com>
 <20240222185039.72201-2-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240222185039.72201-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:303:8d::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0a28f9-1dcf-4315-98c7-08dc37e0291e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iVb/WZSvsQpxveLRohNZFPiMxEA3Ojcq7wjD+MgYL3HsuNhmzlKojj/1Qub4ZFthESY3DNFGs3BmmNGLBYAYZTAn5Bl2A+QevzC1cZ+kjWJZ+/63qjz5kuBKdqUSZYNnCJwY4gQI4zFW+GN3292Gvaw0ohQ6oMyH9rIwr/oWuTq0GltydhUzflrUwZ8+tudMWG8LMoRmIDhdPvG4oartL6sHPu8wB3+3NPfzg73e5LEXVVvAg8rrKatZh3TJ1A+Yl9fyUsx9BWODmpPftFwqE9C154F44njfx15MctyS64WCsbGwnF1BfvzkImeTZwzS7UWE9y/bVZNyOjvTaRBkHjvXue7kfH3FMboOdozjeO+tXxIdhz5VZFpKbFQIemSLxoURXCQfcLlbSSqaoIrtr5sdD77KAVZCOg02yfHuVQuUWvZFvi9k1g9OTtfS+XB3Oxe/TOfw3Pmc+9g6N01QS2Y7sum7HdESvgU7NsdpMNB9EO3BV0oJKIvy0EopYPel9EJr6o04aOZmfoVIA60UgUIFTBl4jMuCqiQkck3lGFiEOfx7l/RkI1LfuD7i6th/AoGCrp20Z6pdjNJgeHqg89zTWq3XMQZ/FTvmB8EMC6w3nlj+oMsOtUGQbJwv3LHqF2qF00NI9G2Srb40synng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkp5STBJc2tlN1orOG9KWjZaSzBCN0hwendRc2dqcVp0b3ltZkVBTVlFa3Bx?=
 =?utf-8?B?a3FRRXJ1YlRkVVpJb3BnckFXOTlhOU1uQUJRck1iS3dSdDFKdm5DZVdrVUp4?=
 =?utf-8?B?VnNXNkR1VkppZmphUzZWWVloOGpEeGxkQUgrY29PWFNraHE3RWJMQXd1aTNP?=
 =?utf-8?B?SGdmU3ZBK1B1UlRiYnVJd0dHQ2hGeFptN2wyeU9vVWlYY3hxYmMwOVZIN25T?=
 =?utf-8?B?VmRRZG5xU1lmV2N0akw0K0JLcjl5bzg0WCsveHo0S01JVytKTWtMZldrcFdI?=
 =?utf-8?B?NC9GNXluS1E0UENNei9ieFBaeFpXUTRIaTJpdDV1d2xiTTgySjgvRE9QWlRI?=
 =?utf-8?B?SzE3WXlqcEcrRUpRRDNrMWNOc0k5ZVo2WUNDL2tTVjVtcVltZ1g1TFR1OVN4?=
 =?utf-8?B?WThFZHVaRXlIL1YxaHNaa0lvZWhhVzhWMkJxc3Zhdnc2VmxrNXNPQ1dYWGV1?=
 =?utf-8?B?VnF1Y1UwWmdXcy9ZcmlqK3VNZVVsVWVUdXNpaWJuRzlubjFMay92Mm4wcmFj?=
 =?utf-8?B?ZmYxc0NBVjZHY0RBS3ZwODRsTHlENk5rS3MrN1FqVktXWnpZZS9RVlRxdTdz?=
 =?utf-8?B?Ly8vL1B2TnlNaWwwQmpQUlFDSXpBNG9Dbmk4NXlBeWZPM0ViUWtQdmZrOEhj?=
 =?utf-8?B?L3ZzcWMwZ3lRUmhPOElHd2M0VktPaU8wQ2Y1Q2ZtMDdNWWRmaXlZTkxkYnNv?=
 =?utf-8?B?WkJEUGtIQXBFVzhBUWUzNDY5MTcvTEhNUGpPOGR6SlRnZFE1aXVyMXRHNnRj?=
 =?utf-8?B?S1NDbHF6WmRtWDFZWCt2Szh1NUJMZU1tdmJzek9TcW1KQncxV0tydGt1ZkpP?=
 =?utf-8?B?Z1RRY2hJMUw3K3A4b1NMaTB2Y25VYS90SmlSb0JaVElyYWtLb2tkYWh4YnBR?=
 =?utf-8?B?cHhhbVMxeG1INkRuWXFJVVRqVmw2YjJYcmd1dmVkUy9uNzZYSDJ4S3daeG0w?=
 =?utf-8?B?bkJ3aE5RMGUzVTJGS2h2MnpucnY4Q2c4c3UyZWJNbXUva3lrV0tFRW43cCtY?=
 =?utf-8?B?S2NRME5XL3VjZ3k0cWVEbHZjYW5tK3BrL3plM2o0UEt6N0pSL2FQREVtNyty?=
 =?utf-8?B?REFldFZnaDJJN0VzWklwMml5SkpRWnRXUnAvcUZPaDB3MWR1eEZzMkZWYXpi?=
 =?utf-8?B?VjNZTDVCaTBnNGxnWUY1dTRPOVNhRjZSQjBaeWsrNDlGK2pXRDBMSHoraGtZ?=
 =?utf-8?B?aGx6VTZiSUU5RDBRRG04ZU1oWTlBYVFpN2lrNS9BSE1qSU9CRWY4ZnJsUWRx?=
 =?utf-8?B?ektlNlE3RXJmZjlPdThtMnRJSFNwUHNnWWVaZ0pINC9QYzFUZmhQdmdQZHFS?=
 =?utf-8?B?VWFJblpXQnRtbEk2SDZBSjMxNytsY1VqTnB6RFRrZWk4cE90eFk1ZGRraGtJ?=
 =?utf-8?B?cUVaTmhtRDk2ZjA1T2dFV0RST0lGOXh3VWNCMGhEcEdqeWRGN1lGY3M5MmtI?=
 =?utf-8?B?UUQwaE1WS2tXM2pSQjBuU08zUmhkZllIUzU5Z05OOTBOMnRRaUlJTWVZc1d4?=
 =?utf-8?B?cVJKZDgxdXo0K1RpLzRjUjRNOGY4cy82WTlzSmxRc2VJcDJRRlM0ZnFmZnJl?=
 =?utf-8?B?R0dSTzFBTjVPTk8zQWxMaStsR1FaQm5GbXl0MWZDRVhrbDQzb1BGbTJxTjZO?=
 =?utf-8?B?M29zWFFwZEVGL29kUnJFaHBOdlJTcStZUWc2VmRXZStvQ0FpSnpCL2NOUmdx?=
 =?utf-8?B?ZmJzbUQ3MGFaVisyS1E2MXB1d1NjdkZoV2RKVW01VzhZV3lwcWpmTFV2aGN2?=
 =?utf-8?B?ZlVraTgrcUdyVDJtbUFCWFNGOWdTbGRPWWpIMkhTRk9Ta3h1WkhDMkpXVTVL?=
 =?utf-8?B?UGNrdHd6TGNYODBjS0hWd24zS2FnMm1ZdUxDenRIUnZ3d2lnTE9FaXJBd2U0?=
 =?utf-8?B?bFhUaklsOHl0bm5GMG9DUWUyZ1orck55ejNtdTNFaFpmOHYwMW1SY3lNNHJY?=
 =?utf-8?B?ckFQR2huWENhNVJXdVpBT2daVzZpOUtXVTd1d2NObU5uQ0pIVjRwOFhGZkFW?=
 =?utf-8?B?cmNXVFNyQnpsS2cwV2FEOXNkVzBMc0kyamR4WlJFT0RMSUVvWlVwZmNYTVUz?=
 =?utf-8?B?Y241a1dXRWZjMmErMVNuci9zUmVEZlZpNGkyNEtnaTZqeFlRODFTTmZob2d5?=
 =?utf-8?B?bWRRVzlhOXAxTThxYkZ4U2V5UXJLWnYwcDNreTYyS1EzZnZRVUhuQkYwc3VR?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0a28f9-1dcf-4315-98c7-08dc37e0291e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:05:08.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qX1yKJ3CHeGTGtadJG5XAVVug0x/RHf3Lu3t8xjQGCPmuJ5bu4B8WXiMvPWCz6aZqzx5OSUYl5BCnBFQOGMFsEM50/v0hznsspwpDtsCyl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8589
X-OriginatorOrg: intel.com

Hi Tony,

On 2/22/2024 10:50 AM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to apply
> changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do
> hold this lock, but there isn't a way for a function called on another
> CPU via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Adding the target domain to the msr_param structure, and calling
> for each domain separately using smp_call_function_single() means
> that rdt_ctrl_update() doesn't need to search for the domain.  Thus
> get_domain_from_cpu() can safely assert that the cpus_lock is held since
> the remaining callers do not use IPI.

Please stick to the imperative tone. Something like (please feel free to
improve):

	Add the target domain to the msr_param structure and call
	rdt_ctrl_update() for each domain separately using
	smp_call_function_single(). This means that rdt_ctrl_update()
	doesn't need to search for the domain and get_domain_from_cpu()
	can safely assert that the cpus_lock is held since
	the remaining callers do not use IPI.


..

> @@ -463,6 +457,8 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>  	hw_dom->ctrl_val = dc;
>  	setup_default_ctrlval(r, dc);
>  
> +	m.res = r;

This belongs in the next patch.

> +	m.dom = d;
>  	m.low = 0;
>  	m.high = hw_res->num_closid;
>  	hw_res->msr_update(d, &m, r);

The rest looks good to me and I think it is a good improvement.
Thank you very much.

Reinette


