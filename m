Return-Path: <linux-kernel+bounces-105931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3561D87E691
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543B81C21816
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393802D047;
	Mon, 18 Mar 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6HGHxOw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EC2C694
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756033; cv=fail; b=ouDbNmFV+E8y0ph8VhK0CBB48ZeDIb3U99UsCB4WANY/uHoXZkCOS9DFPi4XIvdX/Y+7bWW8gp4bg5mdShhUchgzzqtY5Q/7LTuhQ8ftNYSH18DQayxpC1OVZb1ykFSJxheCRd73SksYhMRD9ODhl5dsxyQDNGMpt7Kv2hlT/dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756033; c=relaxed/simple;
	bh=qGr8T2xIdoBkIQ/IeHZ0GjJc7L/jKKIf8ylN4FnQDos=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u16Mn5/oGTxj366ZUTpJom5B7Or0z+vmxad00pOHNqBLUTTk4lBlEnqW3Dq8Ww+sTsEbY6j7ry48ck+ulULunhNxuli/LyioJIeTQnu1gsI8HgGlqSYmuVANRxiNpj7Yvf9yAdPxZ6PjpVhAYN8ZjiSM+9s3AYMFPrpgvfLy18I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6HGHxOw; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710756031; x=1742292031;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qGr8T2xIdoBkIQ/IeHZ0GjJc7L/jKKIf8ylN4FnQDos=;
  b=M6HGHxOwPPEEr2okcqVCSRcWujMZT9uw8uvTiO1N8mZ9uXe0qvcPYxnP
   moo1ZpK1gDRh2UdxJBF3Z3oOuPvY9YNIip5IqHC/6E3hCIXbSWR1CrSbc
   ha3iHvl+bn5cSrOtAF0MQ/sjgSfullMTzIW60g/ahctfA8bcpfEaBWhEh
   faGWHCJJEkIFVBck9yaPN3A2JcDmXdqASLSyJsJSs5YqEXooNXmf/kJvX
   ZPqrKyNCo7Oadmgm2qth6oIZVkE953kKheQiwE2mppZq8IqIxAlRbdpPQ
   Y0s3sCDhdnOi7Q6q9y9KL34Bv+o5VCAWrSF8Yttfa8Mm6ueWCpSQrJjrU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5418508"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5418508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:00:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="14057740"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 03:00:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 03:00:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 03:00:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 03:00:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 03:00:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKDxW0MteC5KfGUqOTsrEQeLRxtfaitNg2fhGifVTJzYmUGxCPMANbVZ9Ic2wjgacyOsQLfp2KRWYmjME9rQSF99io9fgysJF0Oc0ushn+uIILgbehditR8/qGfZnYZFVsn3kUG7q31vAUxiE9THveDEQl96oN/VXM/r06aNJVxqn+bSmU8kFdGyl9xMos59CK0a47+mI1ZcqYwT9AiBys41Ka4goQlLBXFbJsmKVsInnynQ8S/xtJZryvtVR1UYDqaLwsSNkBY12mKxwHAoEdD7f6vNCEnhTfrbTdYNeGkh0GpbCvE3zu10NYy7OJTT8mqJJQzU7Ev3+583cIc5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jh6EqESY8gSM30oPwOmyOJCxWZycTaH4WNTchQVkriY=;
 b=foKV+jmx1DqJo/jvPQhNKk//EWB2mWBAS2H5bGg9fz95R/oqp1NNQ5zxpts5kr28Z6aq06fHpVvc3oTtB+f6OBGVWeBkuttqQuxiWbp88ZmuI1Lc0IdWBooFczv3jU9RH0by6dWLBBqw36H9RwGAZLMLgg18QTEpAnAsNb1Iyzce3TiVVpFu1HQa71+da33oqCs+FcO5vFocUAMz1ywGiBO9AxzPjbs+j6sU0b7HqLJyyGcDefaGLljMZkY36qX3kozFvgAi3P+bQL+0NMz4Vp1MBjY5+Mgb82ylkUbqnFnohENTBCV2eeRLHkdQHEdK9arr3TUH+CASh/EnE4mkkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 10:00:25 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7386.016; Mon, 18 Mar 2024
 10:00:25 +0000
Message-ID: <a75ea34a-7512-4169-b987-95f11a7f3dd0@intel.com>
Date: Mon, 18 Mar 2024 18:00:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
To: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: David Hildenbrand <david@redhat.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>, Yu Zhao
	<yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko
	<mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song
	<21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-6-ryan.roberts@arm.com>
 <d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
 <1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
 <caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
 <5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com>
 <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3694da-91db-47b4-bf17-08dc47323bbc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIxfMRsh2QRN/dhHf/8pd+Ac8WSGq7ZdXk8Y8IN7kwTWmlvz3uzlqWfLBY1Vwah3QByZ1lsTtRWQTn1BJPHMbFkz8Y8p8y/IQ0R1TIqVU7zXvajlnhL/YX4Y578hY+GZZaFjIjzuFBpj4ExZquuGL0SY7PnxnziqpUEeGzrn+jsbtRTTCf8mIh33EeMZZ+oGLuDP0KS3IsgfF3yATGjICFPYlF/px2NMaCilDhEavrz5q2B8MD+kmXQaMahN/YSDOwP0RPqGeF8ZJHHKwGEGjYm9i/YQ4CmZr6SMgMBzMi7jupU087m3NJBE72SvH45jr5x68BOtZf0JKbGZLbZIMQum0DbRGeE9kieElVo5WFyd2Fs285sjHJ9vtmaJUg1hQTt4A+zpw8WDsBPcrULSsbDt5fWQo6DOJCtMYHl71jzfzQKiaL4HdYUWJT9mX8qzb1CW2bFmSpiw5CmXkf0swyc0l98KXOIEfqMRuyNiLYqJwAlsqj4z4SGwJlyRDJF3hxkMdQrS4IEh3Vw5pmQ0cRiTtLF9bx7PjiYDEMNoo7+lrn8bv2Y92m7uwq4fRY0H7CiW7dNkhVPNXiOqnDddkrjP6qx0MVBrsy2s+qJ7rAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhjUnloSS8xeGZWcHhjaDlsSlBGU0paYy9LZW9BUVB2aUFPOFpsRVV6ZU9E?=
 =?utf-8?B?ZU9ESjE0S2k0N05oZWhzODdQejFjVG5ZWXc2UFNOQjhzZG1QOHVBMjJaZURt?=
 =?utf-8?B?UW1nZ09Nay9Mck5vd1NVYmR2Q2dkdVVKWVRtc1VaTWptYTRXM0Zsa2pZUDlv?=
 =?utf-8?B?bEpDT3hMRmRFSG9JMHk0RTl0MWt3UG0vUWxJNG5Vd1UyYmtZMGVjamYyVEtH?=
 =?utf-8?B?SHc4YWFmN1NjR3hTTVpjOFBqS3hxTzdsb0s4ZnpNVE1tdnErVGVkMUxhTGEx?=
 =?utf-8?B?RmJ0YW9NNFFUaFQxV1Y1OGhqL1lCVTlxT1BaMEYwK29qd3ZFd25VMUQvalJp?=
 =?utf-8?B?L3ZucnZBb3dUUjFpSHFaZWtTWDg3dFRCVGJPVENNL1BiSENGMjZiWHhuSzNo?=
 =?utf-8?B?bVZZNFZ1a1pkbnRIVmZ0bGJjQzhUREVGSEFnN256MjdnNXp6VUkvdFVTV0Qx?=
 =?utf-8?B?U2daRE5idnJDcGlsVHNocTRZVU1xZy9kVldKQ05jTFNOY1RycmJueElsZVNy?=
 =?utf-8?B?RXNmQmhTc2tLOU8wVVNFSGE1dEVJSVZXSVFVUmJXSWlISFZwSGk5TTE2YXZ2?=
 =?utf-8?B?aEFPNFZBN0Y3cXFxVGhBek1UV1Z6M0I2bnpGTTdIOHdjbG9TOExxUjFMUGU4?=
 =?utf-8?B?NEhobWV5Wmx2UGVuWnRSSkJ2b1JnT3dzMVEwMmpyQ0o1QTR1anYrbGh0UmJQ?=
 =?utf-8?B?QWZ6dUNVNjJ2WjdJVGhPQUZXS2d4Rkh6djlyeUFBRHE3Y2l3NmZ1VGU2MGtE?=
 =?utf-8?B?eHVvcjFycExhSUNuc215ZExMYWRkN0ptd1BIUitFejZKaUJBSFI1UmhKNita?=
 =?utf-8?B?cEdBWHJCcy9kcHlROFJHZjY3NzdPWU5HK045MXV3RGlVck50WW9XYTFUZzM5?=
 =?utf-8?B?TnZrRzlsT3R2b0M3amFENXF4c1FDWUsraEpnazBDakdTTkszTkZKZ2NIQkFE?=
 =?utf-8?B?MWUxeERiVGNQVm84cXBJM2g2bHRLWml2d1dxV3BJMjZETTFVU0d5bnA1bURS?=
 =?utf-8?B?R1hWQzk0Q0lHd0lWTDFWb2VlNUwvdGpSSUZjblR4bFpRV25PMDRLQnFKeXBn?=
 =?utf-8?B?T0hrd2JvbW5ySmkzMkxqVzJCUDNzWmJJQjI4c01TUUE2S3Z2b1p0eGtrR28w?=
 =?utf-8?B?RjB2SmlrNVFkUW04b2tQSzNCbXdRSUgxUXIxWkJXTVZQVXExUS91bkNiRHVU?=
 =?utf-8?B?LytnWU1PV2kwL1hpZTYrd25wM1FnNEZOOW4vbGNtMG9SaVlwMjJyOXJHNHpw?=
 =?utf-8?B?aWs1b1NRZDREalFoRkpNeHFqeENPSlMzRWdxWFE1dXZPTmpxQ0M3eGpDZGM5?=
 =?utf-8?B?d2U0L0dtdXNTMm50VVZNRVh1ZWlYRmozb2NRL1g1L3RVaUFKMGJyUFdmVkFK?=
 =?utf-8?B?UnM0V3dKQlN6aUhBY2VCeGFwbU1EaVVYbHdKZW1WWHkrSFJvdXdhVks0ZFRa?=
 =?utf-8?B?bXlERWIyUytvclNXMURBMy95azFoTmZmQW1ZSTlEZFB6dEs1OTgxcW5yelJy?=
 =?utf-8?B?NGRCMUljTnVYL0ZvRUhFZGExSGF1bk9PdlpVTC8veHd1MGhkamFHRG5idkpD?=
 =?utf-8?B?SUJ6bG00T2RPMndTMWFzYSs1VDBJMkNrUU5mYlphSGJicFhGYjdKcWJ3SVZH?=
 =?utf-8?B?OFE0UVFjZ1VWWVBOOGFKVmVmM0RmZUEweGc5dGRYbVBiNlQ1K3pyK1dqMHdN?=
 =?utf-8?B?K1kwekFnN0lLM3VHdjAycGJ4MEZhRTllWk83WEtnRWc0TFhCTGs0Tkh2WXJH?=
 =?utf-8?B?MEhRNDNROUZDdnl5WXF5WEtWVkQ4YmpCLzNsR2FQYU9oakVJTTNtbWlZYUd1?=
 =?utf-8?B?VE90Ty8vZ05UVGpMM0RHdEdnVHdQVHI4Z3pnTS82TnZjR25kQ0UrajE5NjZs?=
 =?utf-8?B?MHFEVE1qZXozb1FpSE5lN0E5UTVFVVdBQ2tUWlltVTZwb2pFWjRYVUk3YTQy?=
 =?utf-8?B?ZmE3bm5hZzlvcGVrOVd2RVZCdHdZQmpwNldRbE01RmxySExiTDAzc0FrOXcw?=
 =?utf-8?B?cFVTYVBuUGpzUVBSOW5tbFFabUc1RWVTN2ExUFRQVUx6Y3lmZDNWd1VOVVlG?=
 =?utf-8?B?bXJiajZHd0hPcXJWdTVSM1Z6ajc3aHVGcmlSL1QvVzhlVXdjcG93WDJtbXRU?=
 =?utf-8?Q?xEUew2Li6ivanTmJUIz1GYfAS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3694da-91db-47b4-bf17-08dc47323bbc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:00:25.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecT1A38vLe6pCAKPfiRiDjqsUDUnPGDJlp5qW8PN7gUdNyL2gjESNZmNcBmkEQyxc+MsbAkw3hDloRdnEuAsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com



On 3/18/2024 10:16 AM, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Hi Yin Fengwei,
>>
>> On 15/03/2024 11:12, David Hildenbrand wrote:
>>> On 15.03.24 11:49, Ryan Roberts wrote:
>>>> On 15/03/2024 10:43, David Hildenbrand wrote:
>>>>> On 11.03.24 16:00, Ryan Roberts wrote:
>>>>>> Now that swap supports storing all mTHP sizes, avoid splitting large
>>>>>> folios before swap-out. This benefits performance of the swap-out path
>>>>>> by eliding split_folio_to_list(), which is expensive, and also sets us
>>>>>> up for swapping in large folios in a future series.
>>>>>>
>>>>>> If the folio is partially mapped, we continue to split it since we want
>>>>>> to avoid the extra IO overhead and storage of writing out pages
>>>>>> uneccessarily.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>> ---
>>>>>>     mm/vmscan.c | 9 +++++----
>>>>>>     1 file changed, 5 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>> index cf7d4cf47f1a..0ebec99e04c6 100644
>>>>>> --- a/mm/vmscan.c
>>>>>> +++ b/mm/vmscan.c
>>>>>> @@ -1222,11 +1222,12 @@ static unsigned int shrink_folio_list(struct list_head
>>>>>> *folio_list,
>>>>>>                         if (!can_split_folio(folio, NULL))
>>>>>>                             goto activate_locked;
>>>>>>                         /*
>>>>>> -                     * Split folios without a PMD map right
>>>>>> -                     * away. Chances are some or all of the
>>>>>> -                     * tail pages can be freed without IO.
>>>>>> +                     * Split partially mapped folios map
>>>>>> +                     * right away. Chances are some or all
>>>>>> +                     * of the tail pages can be freed
>>>>>> +                     * without IO.
>>>>>>                          */
>>>>>> -                    if (!folio_entire_mapcount(folio) &&
>>>>>> +                    if (!list_empty(&folio->_deferred_list) &&
>>>>>>                             split_folio_to_list(folio,
>>>>>>                                     folio_list))
>>>>>>                             goto activate_locked;
>>>>>
>>>>> Not sure if we might have to annotate that with data_race().
>>>>
>>>> I asked that exact question to Matthew in another context bt didn't get a
>>>> response. There are examples of checking if the deferred list is empty with and
>>>> without data_race() in the code base. But list_empty() is implemented like this:
>>>>
>>>> static inline int list_empty(const struct list_head *head)
>>>> {
>>>>      return READ_ONCE(head->next) == head;
>>>> }
>>>>
>>>> So I assumed the READ_ONCE() makes everything safe without a lock? Perhaps not
>>>> sufficient for KCSAN?
I don't think READ_ONCE() can replace the lock.

>>>
>>> Yeah, there is only one use of data_race with that list.
>>>
>>> It was added in f3ebdf042df4 ("THP: avoid lock when check whether THP is in
>>> deferred list").
>>>
>>> Looks like that was added right in v1 of that change [1], so my best guess is
>>> that it is not actually required.
>>>
>>> If not required, likely we should just cleanup the single user.
>>>
>>> [1]
>>> https://lore.kernel.org/linux-mm/20230417075643.3287513-2-fengwei.yin@intel.com/
>>
>> Do you have any recollection of why you added the data_race() markup?
> 
> Per my understanding, this is used to mark that the code accesses
> folio->_deferred_list without lock intentionally, while
> folio->_deferred_list may be changed in parallel.  IIUC, this is what
> data_race() is used for.  Or, my understanding is wrong?
Yes. This is my understanding also.


Regards
Yin, Fengwei

> 
> --
> Best Regards,
> Huang, Ying

