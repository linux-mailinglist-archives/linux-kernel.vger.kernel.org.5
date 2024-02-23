Return-Path: <linux-kernel+bounces-79044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D4861CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190D71F2558E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A54145B0A;
	Fri, 23 Feb 2024 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eex2Wt1p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38064143C67
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717317; cv=fail; b=pM8ZGhC7590wvIzFZFPnzIFukRVDQ9hwVqnOVn5+Zxc4nFICDOOQRBh3juoKo31dgdtFcLzfqYfKBe60Kv6M5rBEv9MJ1RmbL7QSi3mhr6HPY7M9guvEK+odtFenwstkswG15I8mHSZckxX336SV8wuG/wxlCdOVu1jioJlYGh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717317; c=relaxed/simple;
	bh=VDSTLtd1y8UJ1of3QshpUqrOkz4up19/ASzmkigp7Kc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LuMl4f6yfXDXsUIihja1d/R3qA6E7mvWjwvV90H5+fSB/FajygXwcVaCVQstUICKphksvCZt5KwbmlzmBCp4VDEamKtRyTwSlNOAlg/nFVx0bky174vzJnmJPoS3Q5IQCQnNgKdgZUMrzGNWoryO29BoCZtBerxPRtXm+ecSKQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eex2Wt1p; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708717316; x=1740253316;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VDSTLtd1y8UJ1of3QshpUqrOkz4up19/ASzmkigp7Kc=;
  b=eex2Wt1plpt7fpBHnLiVo7ts+NJdywa8f58EJ7xxscfYajwHXapCHVQD
   Et8DuZuxAQ4lcrhOB2PZM4YpTvPWFIvY36h0ckfL+jZrGAK7AQhzjuTup
   rcFbsjqNvR9qnfBzrXiT2hhyRFEKhplnkmUSX56hgQlYN9RAg3cubOfE0
   PwRe+JLCy5J2COveQ+NmTY5fMVMxZ2D2AHkhWUURYgwksMXw1ZvJUDwU5
   /OEtx9UGsLauy2vaEvMQQJfFiH52wyeLFM5gqnvixF7f9Loh0cM2lrLuf
   nCf5WZGVESaGZUEJ5SGffVSDFuCA8iMzieNAj0aQ+FLHjq7O47KYqUrE/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="14460724"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="14460724"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6008987"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 11:41:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 11:41:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 11:41:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 11:41:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 11:41:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRb38ssjNp0Y/d8GYCU50o3VtqQKQO9KmKaUje7Vn4rOgnyR0kKJkXoo4kXd6RyjYNMVZECGuvMD/mquTO4Hb121deM44wKAHBwRCxQTE1tCugcx1OiKxyPf3qPnA+phvYc+aTfHeN7IEp69TY+wiwQ2E+ZvkoRvvYm0kCaCcryi3vSZt5y/T0IGLYAVFAZT7MSJZwXrUQ5D2eLJgJ8JNncu8T5etlJjUZ41rMpmUrxSE4mQ/4EV3lRhOc0JZUGK4me1clE/e6+i9yrw76SCptY36Kz0T8qKW6U9GeGteNXls+snzur0ugF02pYXGgRExube3xOUGqGPUGy9qrm8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMiv+1uvbQUG+2sNo/29YPg5MWiUPcaPK910Mb/Z/ws=;
 b=ZY5VafvEbabdEkkfkcnUr+kyl+paIAOrvu2h3xZR1Z0awtcNFQPpmOCAhDe16nG78zVPWgHH0ed000nUIOk5np4MjL4gWy+CZqnI5Qq5iWmfJaLHv9b5yfWJ1Ivs/WUM2D0cevaXl+9tHJg9EM3u21RgIR3vieSEhbpKPDg9IXT6+dX0lKh5aKW1Jd+zQmNP4vPH0kuEIzl8D6DKQ1BF2FvjxrxwUAY2SPRNz++wh7ootywQ1GsScyfPNNrm1B2ujbP0bgASyZnCMsXVrm2/pkaE0B0GbiOlKhVDwewelUSrCjAyDIS09cq8/n5mcbdmN7y1FKeGCzDFgwrYGbFphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 19:41:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 19:41:50 +0000
Message-ID: <371242fb-dce2-4de0-bba9-4d85475d5d9a@intel.com>
Date: Fri, 23 Feb 2024 11:41:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/resctrl: Add tracepoint for llc_occupancy
 tracking
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>, James Morse <james.morse@arm.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
 <20240221092101.90740-3-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240221092101.90740-3-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 644cea91-9081-4291-780b-08dc34a77ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUjqlSJcxNVrDX36RbrYX9ZdQIIC5QNTQysyexHtSJfMqNWp7pRebLnlRu+nbaCttjwNrH9KNbb4S6zKnumCtSGQNJ3q8AEnevYdWYI07rBDBHBjN2cB15amFCfNDkSoO9HqKmGjPec98BB6d1OrBRVUXhhOsj2wmf3UAJzwfBZjXezEnyeLIfb1b52lR6UClblthUZn2hUoa+UHVv5I31A9JV8TX/cGwtdPwiyELPmeOizQSXfSsl4PUYBbncJq1JQ2E+RPqMS8NXgzeViJRLXqZatEqUFZXBLJG0Fdx+rZfRwTEbbOfrtNwlmh/pEdrZRsF7MPYtvQhy7Hhc8yBLpfHABmpWrlxqPWXJVRvTG3u28o31PI1KuRNSCzmLJlIASWUcldwsHPsN6cQbPWdpnTl0WpE/82C8rmAkVQKtSg15WH5y0ZckjKwCPDlOQlIU+QICzKvFF6jQh3fq9b8Czz5qXQlFl4qDjNnaRrv5w2sEdV40g5ygTO2+6KIQaWZH6aVBtmYG0rh7t15CAsvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjF3cnVhWFJzT2QxZ1hKTTlmU2dUR05QWnJVMDBCejBoMGhxSGlvU08xdVlR?=
 =?utf-8?B?UXhhZmV6M0txdHRybTBBckRRc3YzNmN3OWh0S1lwYTZkWENaVUExTzVzSkVo?=
 =?utf-8?B?UE85RlN0LzA0aiswL09xaC8rUWM3L09uYk9rVjE5eGxqOWdXTnhaRHVmQXMr?=
 =?utf-8?B?dXlSbEQwNzU4cmdHR21WU01TQ2kvZnh4WE53eFIyWDluTXBISHc0aU9wOXVS?=
 =?utf-8?B?VW1rRUlOUW5XQW1IVGQwamtubTVLL1VTanYzZkpSY0ZETmU4Uk9JbnJQYWNL?=
 =?utf-8?B?UW1PZXFySURoOTBSVWVhc2VpUVZKOGdYdzNsekVVNWNTcVIwUWpJckJMeExM?=
 =?utf-8?B?RldIbFJkMmo3aGRNaHhmUjhabUNHd0JKVGp5aGh0OGM3Sk43SE5PUHlBOVFw?=
 =?utf-8?B?Mys5eWR1UlhNOGhyK2VGYmlya0ZUc2RkZFhDRm1FaUZqTDdub0JUUm8zZ1VS?=
 =?utf-8?B?akQ2ajJzRnF4ZXhDNlFER1I3QzJsWHl0SldDdEwvRDhva01Jeisvc21tU2pM?=
 =?utf-8?B?TnpWY2pFdmpoeEZOUXV2MnQzQVhqYWlSSk5qQ0EyTzltSjZoVWh3ZUduUHdk?=
 =?utf-8?B?WlVhRk1DQm1BeFdmbXJsY2M4NHhJL2xDejQ2SVJYVFZTZ3JNU29Wci9ncjMz?=
 =?utf-8?B?aVpXTWlzL1RCeUZFM0UrSEJFMk9LNUdMYk82Ym9KWSszd2QrTldXdG1MVjVC?=
 =?utf-8?B?RUNrNDBtRmV3b0dSTm5Fb3laTXY1YVNmMkxzL1oyaTcrZnJZUHVDTVg4TUE0?=
 =?utf-8?B?NHUzQWo2blh0R0RPV2t1eG03V1p5WjUzZExheTNWSWVVZUo5ZjFldElXeHVU?=
 =?utf-8?B?OE5KaEprdFBDa2tETVA2QURDYnduMmpnR211Sjd4Q1Q0NDYzc3lObkpxVnNi?=
 =?utf-8?B?WjZORWRHN09uV1Y0YktWdEhSZ0hqL1lZQm9CU2RObW9zWE9kUG1VWndFMVNU?=
 =?utf-8?B?ODJHakpjbU52SHE0UHdCcVZXdDNGNDcwVktUN1ZSRnN1MkNhbjJxV2EvK29p?=
 =?utf-8?B?UGRkSEhJcDNwemI5bVlzUzhlNkNyZC82VXNqcERFVjZsbE00OUx2ZXhDWHRK?=
 =?utf-8?B?THFYQUovRTc4V2p3dXZxMjJuWkw4bE8wOXU2QUN3aW1hMjNkY0hvUUNnTkpX?=
 =?utf-8?B?MHNxWG1SUjFSL1J5MldFRGNCcjArRTlmRjhLckZOSnVtQ3BZc1BxTk5Md0Ur?=
 =?utf-8?B?d2N2aTBXaTVKeXhwcmhYcUF6a2pQUlNIekdFRUpwUytMYmdqeVFmZ3ZtVGk0?=
 =?utf-8?B?NVhyMzBPRjRxNkFzUEhBbWVFYXpJY2FpL3dOck5rU1dFR0szUTFlN0lJUHh5?=
 =?utf-8?B?MG4xL1ZwUUQvVHk0Z0ZUWlpJaTV4Y053dWphTDljeWpOR2I3YkZDTkYzS0FR?=
 =?utf-8?B?d2QwYzBhRmJhRVNEMGtZamc0ekVwSGVvS0FWZmtWemlCM0FobXNZeW9CV1FI?=
 =?utf-8?B?NUNpNjBxcGd2UW5BRHo3bnZaY2ZCcEthSjJPdmh6eEQrZDNRTVFkd0xNTkNt?=
 =?utf-8?B?ck9yODFyRWw2cEVKQTNOa1RKWFBLVURXWmQrbElPK3NNNWRONmFBRXl3TzNz?=
 =?utf-8?B?NTZ4NVJZQmJiQmpHYWhmRjdDWXNNRkg1UWNPM25tTHhXL3RNSTk4bTFxeC9o?=
 =?utf-8?B?NjkydkdlRDNSaytic2tFem16TEFCa2FRYVRFSEFzTXkzRGFzQ0xaZ3hlZUQ4?=
 =?utf-8?B?QzVCaGg1NWd2OUJsclo0dFlhd0tITEVKQnQzK1dycnplMExRYnMrNFdaRW5Q?=
 =?utf-8?B?bTNUWlI3cUV4ZXpOM3Y3V1o4RWpheEFtYitieDB5MFFDYmVsMHlzVnJ3K3lu?=
 =?utf-8?B?bVlicitLVTVwVEVkQW1ORTgzVGdqOHAySXNXVVcxUjNJWit2TVJOU0ppc2Jn?=
 =?utf-8?B?c3BTSFRwYVN2eXYvSUtWb3hHdjV3Y0NFVlIyMjRjbjRnc3pCSENBdGQzU3dB?=
 =?utf-8?B?WkNXUE1CdG51MFhrdkVHRWNVd2p2NFE0Y25vbkMzU2lOR3RRTmY0NEZ0OHRO?=
 =?utf-8?B?d0JhUk5RNHJrM2FKRFJWWW1Ldmk2amNHbTgwTTZWZktXMDJnKzFTc3BIQTY4?=
 =?utf-8?B?L1A0VVkvLzVHZjdoMzZET3cycENOcW5WQzYrS3AvaG5tVmxRbVRjYzFUM29s?=
 =?utf-8?B?d1Zpd1p1eTZuZG1HMjBkc2JpcUp4L2NrbTFjSklqL0FXYlJjSUdxd1pEdUpw?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 644cea91-9081-4291-780b-08dc34a77ad6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:41:50.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVm+7HzckROd0V3nyJpNNHd1wJJSacUtBYUcaAyVMiTBZFpfJIBU4d//f5GIJg0/dmzePkYMgpG6IK2BGZP9ieWH24BV4FglUyNjW42gYTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com

(+James)

Hi Haifeng and James,

On 2/21/2024 1:21 AM, Haifeng Xu wrote:
> In our production environment, after removing monitor groups, those unused
> RMIDs get stuck in the limbo list forever because their llc_occupancy are
> always larger than the threshold. But the unused RMIDs can be successfully
> freed by turning up the threshold.
> 
> In order to know how much the threshold should be, the following steps can
> be taken to acquire the llc_occupancy of RMIDs in each rdt domain:
> 
> 1) perf probe -a '__rmid_read eventid rmid'
>    perf probe -a '__rmid_read%return $retval'
> 2) perf record -e probe:__rmid_read -e probe:__rmid_read__return -aR sleep 10
> 3) perf script > __rmid_read.txt
> 4) cat __rmid_read.txt | grep "eventid=0x1 " -A 1 | grep "kworker" > llc_occupnacy.txt
> 

The details on how perf can be used was useful during the discussion of this
work but can be omitted from this changelog.

> Instead of using perf tool to track llc_occupancy and filter the log manually,
> it is more convenient for users to use tracepoint to do this work. So add a new
> tracepoint that shows the llc_occupancy of busy RMIDs when scanning the limbo
> list.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c |  2 ++
>  arch/x86/kernel/cpu/resctrl/trace.h   | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..1533b1932b49 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -23,6 +23,7 @@
>  #include <asm/resctrl.h>
>  
>  #include "internal.h"
> +#include "trace.h"
>  
>  struct rmid_entry {
>  	u32				rmid;
> @@ -302,6 +303,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  			}
>  		}
>  		crmid = nrmid + 1;
> +		trace_mon_llc_occupancy_limbo(nrmid, d->id, val);

This area recently received some changes (you can find the latest on the
x86/cache branch of the tip repo). Please see [1] for a good
description of the new "index". For this tracing to be useful to MPAM
I thus expect that the tracepoint will need to print the MPAM equivalent
to CLOSID, the PARTID. We can refer to this CLOSID/PARTID value as
"ctrl_hw_id".

This snippet can then change to use the new resctrl_arch_rmid_idx_decode()
to learn the "ctrl_hw_id" and "mon_hw_id" and print it as part of
tracepoint:
"ctrl_hw_id=%u mon_hw_id=%u domain=%d llc_occupancy=%llu"

This will be filesystem code so it cannot know how an architecture
treats these numbers. Consequently, this may look strange to x86 users
when ctrl_hw_id will always be X86_RESCTRL_EMPTY_CLOSID ... but it should
be clear that it is invalid? 

James, what do you think? Any thoughts on how MPAM will use the limbo handler
to understand what information can be useful to the user here?

Reinette

[1] https://lore.kernel.org/lkml/20240213184438.16675-7-james.morse@arm.com/

