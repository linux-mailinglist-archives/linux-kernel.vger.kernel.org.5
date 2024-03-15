Return-Path: <linux-kernel+bounces-103941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD3C87C6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 01:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9271F2206D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1117E9;
	Fri, 15 Mar 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHWAhJSv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6E10E4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710463921; cv=fail; b=E8FNh6ijFgLisXecVR+hZ9SH2pA5S1hGgZzypfOmIF5DwpLl0tRwXHsJk8Q6rYiSvnePH8yRAWVrz1l5ErJMvoI5G/Ij7HNOZ4DzLPAgyGqYmCa5bGSO7bjoNKS0Hfh45JqPjV5MUSsMrpHxoqVAwU3t5tOq1n7gUu9WHnyBv/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710463921; c=relaxed/simple;
	bh=qsBrAdAPBK6wzExAtXyZ2QviLdjaBZc0MwgLDTNLlGA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioZHeaukHWP0vjP1qpTj6ShQDj6EYTBt/+/r/b28sT6e5V2UIOspUtx4gZEdjognxUTen/nPRB+EndfhzH49116VdVzjKij66yLHH8C0k/5R/7JiwIDTlsY3TbhrU6Ns91BI6zFMpv2lSrZDw8i02KYIT1HYEEp/msIE7+KXqb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHWAhJSv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710463920; x=1741999920;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qsBrAdAPBK6wzExAtXyZ2QviLdjaBZc0MwgLDTNLlGA=;
  b=QHWAhJSv+ZKsWPnai+E9b0aCwlZESueuuA88C2dbiTuhpE3oGs42viUf
   LGTCzKgSnPeG7C6yR2+8/cp6FZ+R8McJp5/UrfjAKF0MpPRqyGcVSl78j
   aHt6efCjEoeq6R9CVXbnsi6AnRrpJvam/GYogjt6VePxuq3qeg2Kqvkik
   DVsCyFF13TwAOmWFYvPiSRiheGM7JkpGuqBOoL9yE1IwQ+4YxcPDkxSaL
   xStrBeIuNnKzcqIJe7FQVDKFtdNwcJ26ZjwLglYlydXE3zTXdxsN08/y+
   jYcQ4bSTn52k4a2XiHwbIxc3AX7eHI40KlzelwnwCHNpO3MGrt46HMVWY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16715603"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16715603"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="35617775"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 17:51:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 17:51:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 17:51:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 17:51:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 17:51:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edK9RaqwcogxG1xKpJSKC53udGuBNDuAB1nyvebjhdPVU6sm2BCTaEm8CnsytEXZ628KneZkrzjKscbeFKQ/OaDBqvmpht/NTEHBDR0csft2ZFMVilfaPhIMvcbj5AMmUif5UazH+aN1kdpbye7AS5yYdx/gz3eQtYQg8EghsyAGhMNLpoQwldl38xCUQEF1uOR3K9fqkHfasjWDVeyi+laxvK/xXzL17jP0zwTEHadbg2Vmk/lki2Xo4OGQocwxnq8ON5J3MuGuh9vl5tVRyklSIsCt7bOTggMiVIZvU0sXvGcbX0UkujYmEbT3yjFNJujiA3xMCrQuok5PKSQMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PheRwCa53MftdQ5oQT1ax7UO3CyfqAl531qAK8BTQE=;
 b=YoPEO+8eMKW5rruaRM6TySSw87eUClSsvwQRvS/4M6R0j1zYcmex0sKaCoLGXfoO9XC/p2VyaC7NjZmBMo62T5Sf/VXXf8KA51RNDGc/iAMBRngldqZicrCiwGis25e2jLfkXr7iE9P4zJbFb/0MVG1XdHN3AldScI7/6wTs9rCiTA+AjI3b69AaJJRU1dSlENDVGFIkL6M8ivEqQBXkTl/2TN05QW5zqt0wMY2vV2eiBQfpXrXXrYxdjFLyEJh/mNNLUwv3BnXzRXBYX/HDweJdkSJON4QZwLXQKJnuycfdWsItHMPO1NDjS1Dlbuiqip6OOuTmy6NjTF0EeKuBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.14; Fri, 15 Mar
 2024 00:51:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 00:51:55 +0000
Message-ID: <3ce123c2-3e04-4ff0-99f3-bd402a47ecb8@intel.com>
Date: Thu, 14 Mar 2024 17:51:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: 32bit resctrl? (was Re: [PATCH v2] fs/resctrl: fix domid loss
 precision issue)
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, Rex Nie <rex.nie@jaguarmicro.com>
CC: <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, Borislav Petkov
	<bp@alien8.de>, <fenghua.yu@intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240312075349.977-1-rex.nie@jaguarmicro.com>
 <fed6affb-c7f4-4992-8646-8f5a52c33966@intel.com>
 <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChnAt9+2=iVzpownX-bN+mb3Ujn_C=_QS2qsAph=LPSiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0347.namprd04.prod.outlook.com
 (2603:10b6:303:8a::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: e28808b3-1d48-47a6-b07c-08dc448a1c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syOXW6ogZl6fcAZQu/FRuxA3SByRlOHxjqqG+PiBLGc1u9k+p1ak6SK9kajwergUxDZAzw36+PiOu+PUS2lkG0HRncletMGMeSbv62bqpJPO5g8nr3C+a3frstK+dE/b8U189CoaMu7J1vFFr47/mHu1kVmWnEktdYTa3ngIMM9jAc1gOIyM5XYx5KSvEzXC6YS0fJ359NxzX+78aKYOUJe7kHs4ElO3tKzVlnTsjgH5WL+qBqk/pS2GuK3Gfkcy162go0px8pDbsvXSl7uoHbWDQT6/M6nCNJ5pRjIWo0aJAiHqRS/2jqZEO4Mfv0LnreQxivmrjSNVtu5wouAEDXN6By8Ap6/DtRZ4fSzbTzkl0EtO6hb8096KDVAaOeXO4/nwOOZ0+aRWB8g21JcnSY6TcdR/ZMokmd6Aq1rF822J/DF3KxWJ1LVXv+EZDHN8TFv/lxOduexO3XfzoL4prr5Nls7nivwtzXEhiuIy2aQwdAqyDo8DNI8lDWcyMJGjIh6WrKkZNEQ2K1xsGRYmDjt6rBGKqgZ8FPzV3XgT0Ib3mfgLTPmsUNuMOcsIud/+Xqet5v6nx+Syt8fd+ZO5sVEPezkCL8jNrLzp9gKh3kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTlRUnNwZ0JrcjFXTkZqM0FudDdZUWNhNHE5MmJkSzVyUDA4czNRUWJOYlJy?=
 =?utf-8?B?aytTUVp3VExZaWxBNTk0Z2owdzNqVmlCb0hTYTJLa3FGVnI0ampTeTdsYll4?=
 =?utf-8?B?dG9hZTNZTkd4NXZhTStrWmRBTUh5M0xuOGYrYU50NEx0NUNpaCtBTFNHZDFw?=
 =?utf-8?B?TW5RUUVQYjR2WlYxalFCc0c1MGRTekgyb1NSNEZXT2lMYlREOUR3RkJXVWx1?=
 =?utf-8?B?eWFjU0FRNUdOTW9GdVI2NFIrNHZYcWVUVndUTUVHbHY4VWpOR3cwMG52b1VX?=
 =?utf-8?B?OGJVMUFYay8xU3V1V2dxM200OTIrQzZHaEdXQUtlRThKUVJGdkp4Z0ViWHZF?=
 =?utf-8?B?a3daQjZLYVNYblVvQWRUeFp3Zk9LdzhJMEtuanB3a0xVQ0hvMEFpV1E2Qnd1?=
 =?utf-8?B?K3g2eGNGT0hDMUkxV01MS1NvaDBwejc3WjY1WFhRUW1uWGRnekVmZGIxYXEr?=
 =?utf-8?B?b0dyZUh0RFlLMlQvK2w2ZFJueFFNekd2NFhsb1QxNjQ2dmg5QURmN2JKUnJ1?=
 =?utf-8?B?b0xpWmhwSkM2aGRqdDNEaXQ4dzBLblV2VTg4TzFyZ1BmWTUvZk1NT0h5UFRr?=
 =?utf-8?B?L3Z2c2FTL1pnSmtTK0YzY3NsV0VwTnNxRHoxWkpVUFVKMDkvRGlrdFNiRDJh?=
 =?utf-8?B?d1dRZGN4a0RHNDZKNmZ2NC9VN1ZaclZqK0hQQ21NaUdtYVZvYUhlTVhxb2NY?=
 =?utf-8?B?MDRtZm02MWdCR2luTkF0ZFFXWjMvaktPdmJNTVpsQk4xaXo2LzF2UlUxTk0v?=
 =?utf-8?B?Wnp3UytsOS9ENmU0K2xZUFgzU3hDRnN5NW5ZQjB3WHljOWlvazZxam1hUlA4?=
 =?utf-8?B?U2V6MlE5UUYxME1sN2FneWVWZkhYOTVaK0V4ektGWlBrSkVNZFp5MmFFb2ps?=
 =?utf-8?B?alF2Z21pVU5HYzR6STJBRG5jTlkxcjM0Mm94YkoxSlFjY3F1cUV3OVpLTHRH?=
 =?utf-8?B?bUpLemIrT0xabGsxdGJ2Tk9oK0lMN0xiYzhGRHM4SjhIZm1rSU1ON2c5Wk5X?=
 =?utf-8?B?NlNGV0ZzMUNvdXc2ajRjTDBic2cxQzlqSlhzbTJNOVdYaGhVbjVtWUw4Ly9H?=
 =?utf-8?B?UU5JMEl6c1JiUXVmcFBtcWY3ZzdjcHdjWmtFd3BIV0xMYzNraXMyQ09BWldZ?=
 =?utf-8?B?OUFVS2ZNNHBjcGUzT1BTaUZLSmI0cXNDdCtlQTNYbnY5ZlI5SFZpZjBPMDdq?=
 =?utf-8?B?cUE0c0ZndUxlRFNnOWdZa1NmRUpnTS9sbGduTU1KQzFxZlVsWmJ5NTRIYkpU?=
 =?utf-8?B?Q1NMWnBqcVhnN04zeldnWWVEZzIwSHBXZEZlMHk2TnNKU0E1bmJzRjlIYjc4?=
 =?utf-8?B?a0R4cjZIcExwRlNONXNwOWlBOG9LMUYvRTIxd0Q5WHVhTWlzODYrWXpqeWJR?=
 =?utf-8?B?cTZVTklFTzU5VGtrSkJUa2ZSdGJ1YVhXU2owck1SZzZwYWJEMk90YTYwd0R3?=
 =?utf-8?B?MStuTkJtbGtYdUVyeUNxYit6L0pKeC92OWp4ZEJudWh6dnhqN1JaY05oa2Nq?=
 =?utf-8?B?QkVUWmE1MHRKalI3UTRQQ0E2Z1lpTkRqY014KzNnTzRQVUdMWVU5QzI0OTFj?=
 =?utf-8?B?M2hGNGlYdXM3ZFRSbDhVZEZEcHR6d2hlUDRzaFlJWWUyMzhXdlNWQzBNMExN?=
 =?utf-8?B?Y2ZDakFoZUFMdURWYWptWkNVVHR4aG81RkJ3amFrVmVWLzlJNWcxcGM1OW5n?=
 =?utf-8?B?L0JmTUJhNGMwWkh4RTFxS1Z0RGVSTXNYT0pqcVBBN0Fqc1VjbWhEc0JQajNE?=
 =?utf-8?B?WHl0akNNdVRMbFhRZWlQcE1tUFFnSlE0TURHd1pOS3luTmlaaVZBTFpyM0JX?=
 =?utf-8?B?NWxON25SVEgxYjJ2NzBTb0FkeXAvZVpxNzF0MGQ2amd6N2hkcnZKbUw5ZXZK?=
 =?utf-8?B?Q2RFbThFNytTSFdobjRIU0ZlY3ZDekRBOE1aaVE5d3I0SmZMdUtjaEhjYzhV?=
 =?utf-8?B?R2JYdGIzSTNLRTJjeHgzL1RDVEc4cmtzTUN0WGRnLzdMWW5qR1N2TnVROTY3?=
 =?utf-8?B?NWphV2RWakU1amZ3T3JTcmlNajJYUkNVNG9jb1NyM293YXg4YlhGY2NNT0hV?=
 =?utf-8?B?b1BCeFhYcVJWU3lERzJwNzJkMnlEOVJ5dUlaaUFMOSs0TmExems4KzhMKzM0?=
 =?utf-8?B?czVVeE1yM0h6L1VRQ0Y4V3lvTkFMdG5CdUlqZjcrbGRvS09JYjFMZ2VMa0lC?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e28808b3-1d48-47a6-b07c-08dc448a1c3d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 00:51:55.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IuxAv3V5FIdKXKpikFlx6RRAN1wrkF1v3bqsRv7hfD2obcefeGgudajDhovm7t9Tkp1XJr1J9yBWpm6dAqhGXRhqEr96XssfsI7lZXzcIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com



On 3/14/2024 5:04 PM, Peter Newman wrote:
> On Thu, Mar 14, 2024 at 8:25 AM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> +x86 maintainers, Tony, Babu, Peter
>>
>> Hi Everybody,
>>
>> On 3/12/2024 12:53 AM, Rex Nie wrote:
>>> Below statement from mkdir_mondata_subdir function will loss precision,
>>> because it assigns int to 14 bits bitfield.
>>>       priv.u.domid = d->id;
>>>
>>> On some platforms(e.g.,x86), the max cache_id is the amount of L3 caches,
>>> so it is not in the range of 0x3fff. But some platforms use higher
>>> cache_id, e.g., arm uses cache_id as locator for cache MSC. This will
>>> cause below issue if cache_id > 0x3fff likes:
>>> /sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat llc_occupancy
> 
> This domain ID seems unreadable in decimal and I'm wondering whether
> it's the best value to use to identify the domain. Does this system
> have over 1 million L3 domains?

I propose that Rex includes the information about Arm's cache IDs [1]
in future changelogs.

Reinette


[1] https://lore.kernel.org/lkml/KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com/


