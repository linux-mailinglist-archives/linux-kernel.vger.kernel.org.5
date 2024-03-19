Return-Path: <linux-kernel+bounces-108129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E8880669
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521921C22162
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64753FB01;
	Tue, 19 Mar 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTu44ike"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBF3D3B9;
	Tue, 19 Mar 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882047; cv=fail; b=r3prJH0g5ZEelCDrU01MLpo5wwfUENeoIUk2fWG13gOAdHU8wyipGX6nyilrk0vwqwnWkzpskM8OhLNwX608yhnLoTr14QYM5wZ5QOKGSBqWx63o+6ub6IojEtVUiAvOoGToMR9lkVSqLD67EwdXTdYghpuQuRV0WiflLD4V3ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882047; c=relaxed/simple;
	bh=n3KEHqY0sct9fDyc8EB8nSm06ZUsfmquf7fdNUuampg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SgECak2L4oSDP//HXBl4OFN25amiowuINCTLYOhZsM3k9DUXMjKVLMfhxDh6j8KoiiPz4L8uMlUk/UtU+LXHjin+/1bG0/0q5CAHGKMETI4x8FB1uH4g7fY662Lzf6zet51FvGrXQTRKXwHXBstQ/DpW0lMM26iMUtkhIryFeHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTu44ike; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710882046; x=1742418046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n3KEHqY0sct9fDyc8EB8nSm06ZUsfmquf7fdNUuampg=;
  b=hTu44ikesdXnXkbku9NRiHzBubZIIk5OFe9GDd1/wFPZw14HloWL+/RA
   /hJUM2bBmUrVcKv2o5eVOZNdPIGRwNSS9DJky3xrZ6WKjYkdCYLkPKmLh
   E575tevLzkt3KzlJLMXFVtdWxhkMQ+n1OTNNu+g0io7RYxo9clyEiaD+7
   LHx8vUv0O52VF4jIHQwk0b6CjBpzX/15fQ/c5tiVPNl7KnwpJGVoDPV/A
   MiethgksAfthsNWOFbsILMNDLHvrFtYYnBufaaLh9kUGEB36Bhm1OcwTN
   mbylv1oZ1TN/0oJ1LqAIIFqnoEEIEKOwNiQRau5JRLDSRwE4gNFMH1aXv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5903577"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="5903577"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="51385149"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 14:00:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 14:00:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 14:00:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 14:00:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 14:00:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MusmC+6WBzFfT0rzoomvzuUZMicmu+DxDSdPJdcfR2pIQqiOuguUPQT6KDbnGErdSI7e10Jypiu593oq6tT7j1lmrnpU97olSZyt6o+2n3wp8D1UhKVsSRZnvhkMQd3VdUxhmj+Xu2ZI851Poz9xXmZ40Tu3sE4EWNTX4OOFrryEpNyIbiLIlfC30JoeSCijDx5SNS9iBO1h9fyBimCqQb4Hi+KQXquJmYnSW3eH4hYDLNzLALnwWqse5n4YY9pw3kEZroDOxMAAdYfvGYXvRKVSFzY8btsApk+K9b8m+lWEiuEitooUAWOg1r5WJrqC0jyIn0qQM5zF3Vk6/DbOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxtV45lE0crCnBXbO/C0eL+Z1dxwwx9gE2tbG0KaZQo=;
 b=BRyLehqlc7dpwAR7kSifuAg8WWNf9R6nXXYv35qQ1S/ZbdPttiC6ReUgQI6YczLH4a9thfWnCxRYtIL05myQld6/FBc1QzZMVn6us0EbsqMQ/hF/JMb7VPLE2md5avv4YuvAy1ewUyY5n/uy4tEKgwKVjht3B/hPZQm6Q1ksQaEMKWn+uD5MngghYBsrzuI0Y75p82vdPf83CaY6ka8Pe3tRD6W7DiisjPotjU3XAeyPmmdk0GllXZ3m6cka80RqsMSsnHIFrpbq/nsoIiHze6zlKxd6hPW5ihXzvQu+5WjLHwM9WEQt4oiJxlcvOMN2onq4pEj6RvRcPYbvpfu+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 21:00:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Tue, 19 Mar 2024
 21:00:41 +0000
Message-ID: <18ac2a1f-733c-4586-b9d8-d16bb9bfa2fe@intel.com>
Date: Tue, 19 Mar 2024 14:00:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
 <SJ1PR11MB6083B59F32F33C0FFBFCA1BCFC2C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083B59F32F33C0FFBFCA1BCFC2C2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: b28d8069-b075-4203-aad4-08dc4857a2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4q0OOhHKKLIt0hN/HKS+Ly4rWSj/85D+v6tEyFl9pKvFN5QMnUxlBbnh9YVfSC7ODie9H0CafoYZpUMY78M1oBpqeRd3xuNpg19WIccbOwiSI22w7H1bUusWX8hV5Z4OBPT4J5S2dwdBPRuedJ8ylGEPSV8MXamOL9//Q1+6/0mY0xu9iDkLBlr2fHqnByfRzpprTa6ewWHDe2DIAbAsP1RqWoD5Kakb0ANN2FFUddSXZzPI+pMgxOtaDUQ0eRKRhfGGNbzotSIMWCagfdXRR3m8NZ04qcjogNrcVpM61WvgW1WkkLfMURUW9LPY1Nsm6eEkRwyxiYX5/afFd0tNDoyN2NmkuHSPF+58AMyfuBUtIrrQgdwV9Oewafy9xVu3DjUkP5YSWXUVgNrSWRIg3ytSu9U0MpDMrd6ztclzxK8W+tr3dj3ivVw+OaDOtxDDdXJmfu4Y9jOi+cOOvEzkhhWjcKiwkiBIYPAHkbe4bCwecsnDCNw5N4znMGu/gMZnOT4gDDhG1lgB8aaBqmqbjaI358CvLqaC4VmhzLOIUetjGjiQql8/8CW4YZm05TEH7DPKDdhaGKau1GAM0qpi2UuPTHmp5CRsKBZ5RRhyOAoqEk85AKA2ujH3KzSKq7oZ8d69Y8dyipOGfz95W5g4PTRnMuK/uzYIjpdbpGRGnNA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZKUjQ5Q0JkeExRNnRXTHlybC9pMmNwQW9LR2NseDloRHZFaWZzdlpBN1I5?=
 =?utf-8?B?VFlxR05tbGlxaDJnQkQxL3prZTVkbmMzdEx2NVRMM05wZHhoRWd1TW5Rd2d0?=
 =?utf-8?B?eFJEczRkdFRibDBycUEzYTZ3OEFxRXRLVWQ4OTdoSnduUUlFZUFsdjZ4bHND?=
 =?utf-8?B?M1NIa2VWYXFOTlAyR08rZ1UwbGNwNVJYNVJkNWdFVHRxQkdIYURLSDFmM3JV?=
 =?utf-8?B?L2ZDTS9lNktFVXV6UnFQNzdWbVgwQnJSbmw1UDl3T0t1MEdTQXRMa2ZWMGN5?=
 =?utf-8?B?TzlGMU9kQm1ocmhwcDdPVmdQeXA3Mng1L1l5bkJoRnl3T0hFR0ZQR1Uwd01D?=
 =?utf-8?B?eFZzSk1sMXZ5K1N6SFpWM1hsTFl5UEpCY1F3Q1hUZEgxeWZUT2x0cHZhZHBM?=
 =?utf-8?B?cDVsUmJIbCsyK1cwU0pvVlM4WUpwLzlVZDVlYkQ4bXBCdTFoYjdZeE5kWjdz?=
 =?utf-8?B?a2FmUFBaZzU3S3BscFN1bkxWUzFsUERmVHYraU04RkxaOTlyZEJmVVo4WXh2?=
 =?utf-8?B?bS9PSVFCUTJsSVh3cDR5cEtlWjhYclljVlFrYzIwejZGUk9BVDZiNFVUMm50?=
 =?utf-8?B?c1lDZWJmK09ybGNsYzJ2YUF6ZWxqSjl0Ni8xbXBPalVYcnRiSktTTHJSVWdq?=
 =?utf-8?B?eU5RK2hUeSs2ME1mSnVBTnRGSy9Xbk83NS9BdGpFVlU2M1RGNE9jNFlPc0ty?=
 =?utf-8?B?Z1dkNTRhSFdlcm1kdFYrL2dsWHVuWmdGODBjKzQ5aWpMb1ZRd1lKQWt3Mmcz?=
 =?utf-8?B?czBBTjRsMGV5a1pLY0Vud0g0M1ZYV2NqcTFMTldTMEk3RkQyWDBmMklsRTlM?=
 =?utf-8?B?WXhQZkVNNFROS3FLemtBajlIenRrYjB0SnBEUzA5WDRObm5meEttYlhZd0tR?=
 =?utf-8?B?cHZncWRwUTJhTFM4azVRMDlLU2dQdC9vMWtTS1RHTVpqUGsySmhpY2liS2Nn?=
 =?utf-8?B?NmNOdmQvK29PLzJsZXFwMnNLNmNXU3pPcXc5NGRzc0JEZFBzTFZ6d1hiMWdu?=
 =?utf-8?B?dElzQVhHcWt2NDd3alMxeEJUY0R4QVYwZUtiTDZJNDExR1hTMmJBSDNRYzBu?=
 =?utf-8?B?L05Qc2FIaUhJZHdTUjNVZktvU3BPZzRJNTNyY090NzU2RVM1TWY3WjgvbW5r?=
 =?utf-8?B?ZWtZWHFITVZuUVU5NDFrUWJVZXBOMVVTZ1RUdCtrK2dlQmRhdlo1cCtXV0Jv?=
 =?utf-8?B?cUhsVjJkMWd5RHd6VXpWU1loME44NlpFN0Jmcm9oWjEzeUp2MG9UME9aWndP?=
 =?utf-8?B?MEo1RWJ6SXBQZ2dtVUxzbDR5YlNDZlBxN2Q2Y2xDZlFzcGk5Q2FaT2xIcUUy?=
 =?utf-8?B?dFhnemhvSzA5MXM3YjBOV25Pa1hsMXdUVG9wcURrT0p1ay9WV3pjelYwOTZx?=
 =?utf-8?B?ckJuUG5CYWdTZVFQaXNWeVRzMXFzYzl1cGpjeUhkYkcwbU9qSHRYUnU4WlhD?=
 =?utf-8?B?OFh2UHM5OXlwcDN5cTVkOHRWdk13Y0Izcjd3QTR1MWpGQnBUUWVmRUpRdmhU?=
 =?utf-8?B?RFdmdDcwaU1EWkNJWVZQN2xTM09uVDRXUkJWUWhPYzBNc0xLMWpZaE1NY0pU?=
 =?utf-8?B?bW0rZ1R2Nkp4QzhJTnMxcEhhelhJWjg1SFN5SGgvNGozK2NBZ0FYbGhaTktu?=
 =?utf-8?B?L3JlenNTSjJNVTZHbk9RbXBVbHUxbHlqdWFBMjgwWTlYK0ZMK09HamJxTXpX?=
 =?utf-8?B?S0liZHFtcmU5ckhTakk0UTExc0xnTXNzWDhNaTJsUEJ0WjREdUM0V0J0cm12?=
 =?utf-8?B?cWNtM29LdVhjUUxueTA2c01sSEp5RnAvak9iRnVxTFBvbnJDRkdIRXJqVXZH?=
 =?utf-8?B?alRHWkNaMXpIMTc0bVpGNWlKT011ZEJIbVZuNEpsODB5L2d0RXVHTkQrU3g2?=
 =?utf-8?B?YU5GMC9hOHVBYTNMOUpDbWhIYVQ2R0xkTnRGTGNUK3BWdDZqRFRDbEJOMlA5?=
 =?utf-8?B?RG41K0U3TnU2RGltOUZJeXowZkg4UkYxTFF5WllKSkU4b0h0emRMOWQvOTBm?=
 =?utf-8?B?VlhHVEZBT2hJRXVTUUV0bnFKckp0aFVOR2VBUnJoK2ZtTHpHRGpId0dFYkV1?=
 =?utf-8?B?ZVp5Vy8xUVhwUnJ4NTNOZ0poOFdYbHFERnh5NSs2d0krUDlkWXZMYmdhdU9J?=
 =?utf-8?B?K0NXbVFqb21KYjVOVTFHeWx5ZWlJNWtDejdqV2dCV0d5RHJYM3VUR1Q2eXlF?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d8069-b075-4203-aad4-08dc4857a2c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 21:00:41.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zaVkIs5l2kvpIod+cxD/8J4jAJDwC9exiul9DVdG+n+8Ft8AHkV/hyTg+r1+LRkGt8MPzQtqIvBCNwW1ahCZ6GBYnHGLb1Nq6MESaegEfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

Hi Tony,

On 3/19/2024 1:31 PM, Luck, Tony wrote:
>> I agree to drop patch #9.
>>
>> The core support for SNC continue to look good to me (I just had a few nitpicks).
>>
>> What remains is the user interface that continues to gather opinions [3]. These new
>> discussions were prompted by user space needing a way to determine if resctrl supports
>> SNC. This started by using the "size" file but thinking about it more user space could
>> also look at whether the number of L3 control domains are different from the number
>> of L3 monitoring domains? I am adding Maciej for his opinion (please also include him
>> in future versions of this series).
> 
> Implementing the revised user interface will make significant changes to the
> patches needed to support SNC. Working on them now.
> 
> Minor stuff is the that "size" file won't need to change (because summing across
> all SNC domains mean that all of the cache is counted in mon_data/mon_L3_xx/llc_occupancy.
> The new mon_data/mon_L3_xx/mon_NODE_xxllc_occupancy files are the ones limited
> to 1/snc_ways of L3 capacity.

If the "size" file is impacted by this change then I think there is something
wrong with the current series because "size" is intended to mirror the schemata
file that represents the size in bytes that correspond to the bits from schemata -
this monitoring change does not change this relationship.

> 
> Major stuff is that we now need both the L3-scoped domain list as well as the NODE
> scoped domain list. So no longer just changing the "mon_scope" field in the L3
> rdt_resource from one value to another.

Here may be opportunity to isolate the SNC layout from the customs. For example, the
extra layers of files only need to be added when knowing SNC is active and the
cache<->node relationships can be determined dynamically on file create and
read instead of creating new lists and data structures to try and describe it
as part of the architecture.

> 
> I'll maybe have a draft set of patches in a day or two.

I was actually hoping to get a discussion started about what folks really want
to see instead of you implementing yet another new feature that folks may
disagree with.

Reinette

