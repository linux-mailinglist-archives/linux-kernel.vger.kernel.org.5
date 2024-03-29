Return-Path: <linux-kernel+bounces-125511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FCA89279B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64C81C211D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 23:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB28713E88D;
	Fri, 29 Mar 2024 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJApnC5c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017D4B5DA;
	Fri, 29 Mar 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753581; cv=fail; b=g97BusxY4tnvlY/JMs1ecvm/GaCtqvxujKIoS3XCJhNevK4/91tW3G4rvOcnHmWBFpZKSGjOM9wll0VZnJkEvr7hriI7rRdZKRMrlpiTFT9/Ytf087diHJ+5v5wxxh3Pby1lRenroY4oI8tJeXdrC5VxJjhG61gfkFT+Mzx4CrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753581; c=relaxed/simple;
	bh=1mD8NzAf4z32EC/eR8hXpY/W9fVCcqr13ccDRsM1L24=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxqMXRfik5DrX/o6zrPF6imJPyz8MePpfkSAJupqTSgiodCsIAPYf+H3tabXfOIhHTy2i9hwKYDL6H6sKtUUVMJOU9JgGwYjtf0C0JpxSBeFRe91N+nfR9R3IRmHgFYqypBdtpZZVJ7Vzgh35+J7mWSbCXJ8FYFkKgJwGFbTSN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJApnC5c; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711753579; x=1743289579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1mD8NzAf4z32EC/eR8hXpY/W9fVCcqr13ccDRsM1L24=;
  b=eJApnC5cxh/8YY4ULo6CWqkR/QqdmsNft6bQWCYbH8gSjG0OiCUIGNcA
   xNkHtf+iisXxaVVZzs+1LkdO9UnwbZlI+9iGP0Hzj1enyZtiEb5XHUj3c
   BaIDjtgkOFmieKri1L1Gy7m6aKof911hKdqAO6VbmSf5/6BxvnCY1E+SQ
   CcAyprWoyJZTT6e2Gzli7/pDNRYj3mgWv/DTnJkc3i/HJp2KBxv636s76
   m0aLqm2l08K3q0ULMubPRX/FBDsZ1ypAMGaNtpgTSs7EeCjYIr2ERfvtZ
   YGZ8stg5ivdcBumnzSp6m4r2Qx8IBLtPN6g4CBW9zmXCNZ6dXsp7d3m+o
   w==;
X-CSE-ConnectionGUID: QBwHL/MBQVWe0/TKOSzutg==
X-CSE-MsgGUID: tphD7gNZTRa6osZRoGn2eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7071879"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="7071879"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 16:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="21751795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Mar 2024 16:06:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 16:06:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 16:06:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 16:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsustbtE2lZ8f1JeVt8dxmQZqa8LD0zchqlwgODUeqx4lxqadENNnYYcADh8C29mWrDgf+ICROW49x0g5VrU0tx3D0xLHYO3kYVJY0WgVllJiMiDMgamd/eCJyEW9RuiRO3I775ClOI4+ai01LeC3mB+uKMsxCGLOtjQ4QMAjzoxIySF40O4iOuF/cGJLTStG9x70MtJtGY/GytZ/cFPCJcDNorSSFnAtd0J7cWWl4+RbgnebtaQVV5oOadVtorg7wQJbfPBYMwfgEgSWYFAdRsIHVZSKXMsl45N5PYniBTp89oOe/gMDCV0CSeD7ox7Gy2du5qBCcHZksrgDoKqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFAsf/6gdpK4/XZaM6LSOOKWDti8PRaf03VIK1xLeJI=;
 b=XbpKbbH05teBQQ4cJXx4vbI/IDaJ6E0JL+xduBpxwBJ8aQWisOP4fOoEpW/E6RP1hmEQ0R7po3z8vK+tDFYANpaWAwqfjzRmGTIghNVLC9paCtm+rGud8L+GP+CVOhGgExH0jxrvxEUGhmTkzrWiFJYiner7GXaMLd2L6c+f9gqP95wORa86gzw36iDjVnM4y17mmO50Qrn26VOjanVKLBL9qG4+ZznTvV77eRCoAyoTW9JnBvg/+2ky7I2W4LujlmjksAfN2Ak1TQBUEL044PMnIeFsSn0f6pX7HXt8TgBcabRPpH9JXOjrCmTZMPhrYWP0bbLmKpc8u9yXWJsbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Fri, 29 Mar
 2024 23:06:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 23:06:14 +0000
Message-ID: <4244b729-2eec-4999-9427-00b5c9f3e6fc@intel.com>
Date: Fri, 29 Mar 2024 16:06:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo
 list
To: Haifeng Xu <haifeng.xu@shopee.com>, <james.morse@arm.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <bp@alien8.de>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <peternewman@google.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20240319083039.223088-1-haifeng.xu@shopee.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240319083039.223088-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sxg3kSqOz2TJ+P8PVJltgowzs83oKIvf6fO1pt1GQrbvW7UOvapAQv9Bxc10H9uZi3c5or0rtvjSsxbGR2YM4iYCLjhj0HlmGM2aGsM+6TxtLYp9S+CXAYhp7fd7VXNxjy+Za32c/Y4SPC0oTrc0bmNEP5Tp96Vi1HoZH7ApfO2yS3pCssfLmSJCdvUmukNh60DqUi+SGRUSIwJMeSLXMhm/sydFVuhpBfWLg5qrOgjX8t6PzTj68CxObG/F7aJKmaTmnFfajljmtNy5gpZo/FSS8OiMiR3RrvKwFw2sR+wIW6c06nMpB0GdAtJwbiRJP8EIA06QJ8WGxmWTdq9eDjUd4DTrT9bE5/HvGA6MCC9wDMwboZhgPZBQ6SC518MJPE0LZw5oVKLnCJDr5vWbmZtNpCjtpCZL1HbyB0AV+0At3m4COYHavfXEGgLimJ0ZxE6dGZRBHK6xLRBp7kMiQ8QkY4irXoM5ZXY6LJhKahp1AiMnflvwl0Po/iSSF7OorqqTHgkJx1lRZvO2z9bZ7Uje1iF42CYTwKqny1B3C/vn16qgNTV3cbpvx8yfahSh3LRkXiC1EfqCEjOOvKwdLCJ3ra2l5I9P0hngcIJB9Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDUxTkU5WE5jZWkwSXExaTZUQXVaSFJuWCtpOFUvV0JmVlRUckJ6R2x0enQx?=
 =?utf-8?B?cEpBdERaM0xZVkpmcE5Ycld1VVZaNVVjLy8wZ0ZveUtCOE9RTWZzZi9kRWl6?=
 =?utf-8?B?MFhSTEdvOWVYdW9UYWtJYzBnU1NEQlBkOTRqdEEvMXNxeEJQTnp2TGN3WW94?=
 =?utf-8?B?SFJsTUF4cmM3VW1uVTNUZVNaNmJqYmozM1FsckR4M0tJc1IwdmtpR1I5SXhm?=
 =?utf-8?B?TW5mZmU3V2liYzVwMlZORkE0U1U2bG13QUVwWXl1dHoxaUl3Rm8xMGtybTJt?=
 =?utf-8?B?dEwrS2tYNmRNWEZEblF6ZHAwamtrR1hzMUl6UmgwbGEzZ2wyNmVzUVdKRnZQ?=
 =?utf-8?B?SGZENGF5NTZucEN0UXRoNDYyejNmejMwTjJ2b2FzcW9vbzZOSzluR1VOOERF?=
 =?utf-8?B?aS91WW53YUUwajBlSHVBT1BTTklHY3liZ01uRExBMlBJVDJibTZIRmt2WUdo?=
 =?utf-8?B?NlZaaUhkeUVZbDNXWVY0MDAyQVQwVysrTG50L0YyTEtvQzJBdVdaRkJyY3Ni?=
 =?utf-8?B?UHd0SXA3dmV3eklnRmJyUW83eU80bGxjUGdjWHI2Nm1CTk5vQ1JCKzhyNGVp?=
 =?utf-8?B?WkVvY2pySGpmdVNYRU1xZnhhT1FVdGZSdnpEeXpUaWtqMHJJRmF3UFBtV2hj?=
 =?utf-8?B?eEtzMi9lS3NadUxXYlI1NFdjNGRiVmp2ZnFDTHp0c25hb1RlajVXTktnZE1P?=
 =?utf-8?B?T1V1WitxaVFwWEo4TjZSbTJWUGhvSjZmUFB2ays2ZWZwSy9pZGM4cTFFS2M4?=
 =?utf-8?B?aUZWYU5OZC9vTGtpRlZGN3ZiaEhQWWxpUFY5S0poQmVUdDB2UWZTZkFmeW5i?=
 =?utf-8?B?R2pEcWZXdVlrY0tEbXdFSis4Zk9jV3dqRUNCL0xJdnFMWjBpc3UwMUpsVndU?=
 =?utf-8?B?MUx5ZlpwdHRpWkdSMng3TzE0K2xrMTEzZ0RjdDJrY01aT0U0cm9uNlR2NU5S?=
 =?utf-8?B?bzRFaHF2K0lVVkhGN0VHQWU0T2NKN2p4Q2x5VVFMZGtLNjVuSXVDTDNCMVIv?=
 =?utf-8?B?bStvcTZSc0ErUUgvQUVNZHhUdTBsZVhuSGVDQVFPcmt4dGpZUTBVS2ZCTnIy?=
 =?utf-8?B?eUlJaHppNnlhaWdLWjE4bytub2xLYnZVY2QvekdGZGVYY0tBT01tUVY1TFBN?=
 =?utf-8?B?dnpBVDlsZGdRd1UzNC81UzUrSHQxeWpYTEZUNXN0aDhYc3U3WkZlZ2lLSXk4?=
 =?utf-8?B?ZlZxMkFCOUV2dEJDOS9GU2xrYWdNY3dNOXZkSEFzWSt3Z1BsNStaaEpTUlA5?=
 =?utf-8?B?WDNPNVBpT1B4c2ppZWl3Y3NVRWg0SXpadG16MXpRdHRLOHdPeDVFQTBFemJv?=
 =?utf-8?B?VXQyUHRFN0huR3BaeG5PTFZINXlveFF4b3ZRckhPK2htU2JoY3I0V01VdGpp?=
 =?utf-8?B?WWVXMHM5Wk9YMTNNa1d4aC9TMXE5WDNPTDNjOVh0OXFwRVpEbkFXZzJxaTBK?=
 =?utf-8?B?UkpUNHBLTW44K0hhL2kwbjUyd1F6d2VsbWV0V0ZkUUdUMUtEMzlwa3NPSGtK?=
 =?utf-8?B?ckN3M1NISURoeFBtYUk1bHZ6SXAyTTVhSGpFNG1za0VVbTQ3TmtBYlRwOWQw?=
 =?utf-8?B?MXZxVE03U3VtdkxIbGJxSnNqaUZIUmV6cnRwbkhXdVlQKytNSkJZSWU2azJl?=
 =?utf-8?B?SUw4MWN1am1nUGRxdEV2blh3Y2I2MmE3WmgzbjBBN2cvMXBFR3hCdC9NL1VD?=
 =?utf-8?B?NkJsZmI2Ym1mVjR0MzJUeUUwVjQ0Uy9WdUkxTGJzMFFnRHZVd1R3MTd3M2ow?=
 =?utf-8?B?anFvYkE1aHE2a3dCRnJpdjdTQnFMb2YzRmRmZ0daTWsybkcrbFUxVDE2Ymp6?=
 =?utf-8?B?eUk4WTcrc28zMXdReWl1cVNEUlgrMk9MSmpWMDhxbXVVSitqYXByMnFwak5T?=
 =?utf-8?B?emdDckRLZy9RQU1DZlhjbFpoRzMzUm5KWlY4M0tVeVExbkJuTUJ4QzRQWjdU?=
 =?utf-8?B?M2dxTjVzQ1Q0OHV1NlEyQnZ1c2s3c1VjTDkyUWlGemxZOXFnbUJaMWF0U0xB?=
 =?utf-8?B?VE94SWIyK1JUY1hLZ2FLYjZ5dlFIQy9wbXJmcEoyNytJZjc4M0JhRmxmSUlx?=
 =?utf-8?B?L1VsOWp5UTBROUwybTg4TTN3ODU5YisyOXlMMWdMYXJLSFpuc2ZEZ2Vkc3dt?=
 =?utf-8?B?YUljc0xqbUlmUzV1a0FtelZVemN3c0xlZlpVWVNmSTBpMVBOWVdZU3Z6YXJT?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbebdd7-fbea-4f64-ebe6-08dc5044d54d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 23:06:14.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CCDWKH5ZAKF4wTu1bXpRkBaFwO3N7P4nYn+KRn4kwTU7hAiCoBkb26uNswWrzz005M9L/LkeYH0MhwttQoJC6QdkQu5cc4wgFcEXEZDSqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com

Hi Haifeng,

On 3/19/2024 1:30 AM, Haifeng Xu wrote:
> After removing a monitor group, its RMID may not be freed immediately
> unless its llc_occupancy is less than the re-allocation threshold. If
> turning up the threshold, the RMID can be reused. In order to know how
> much the threshold should be, it's necessary to acquire the llc_occupancy.
> 
> The patch series provides a new tracepoint to track the llc_occupancy.

There seems to be a problem with the DKIM attestation. Here is what I see
when I download this series:

    $ b4 am -Q 20240319083039.223088-1-haifeng.xu@shopee.com
    Grabbing thread from lore.kernel.org/all/20240319083039.223088-1-haifeng.xu@shopee.com/t.mbox.gz
    Analyzing 3 messages in the thread
    Looking for additional code-review trailers on lore.kernel.org
    Checking attestation on all messages, may take a moment...
    ---
      ✗ [PATCH v6 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
      ✗ [PATCH v6 2/2] x86/resctrl: Add tracepoint for llc_occupancy tracking
    ---
      ✗ BADSIG: DKIM/shopee.com
    ---
    Total patches: 2
    ---

The patches look good to me. Thank you very much for adding this.
Please resubmit with the DKIM attestation fixed and then you can add:

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

