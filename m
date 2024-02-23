Return-Path: <linux-kernel+bounces-79282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B239862003
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBB1C22780
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E914DFD9;
	Fri, 23 Feb 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5X2nqjj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD13249F1;
	Fri, 23 Feb 2024 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728539; cv=fail; b=VXrFMNzPolh+5S7QTTuNdaIRUIMwR8EXHJifKrUmk1L+Jf0e2GaWH0UISIGNISEKn62X4vh7cJjzUr3L2ndSfs3MGXvh61YhLSKBPZ590D2EDj39j1/WpTifLsjxHlWZLwF/vk3avIT6LZiG3Z5P9YITVrvejEY3G2V++nME8Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728539; c=relaxed/simple;
	bh=WEb4pLclwP7b8e2QT8j5/roGXCyuN+PZEaiZngBkkBc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LR8h5sgezmihkYfGBfS29eskZoNVl1l3zQWJX1bZ3h9X8iYCi9qAsIZkhpVRlVlwTpJKTOqiwHKI7U7TOWbMJUsD2/GmvgDnsVnUFTO9i8Z+7T9RV8hsHudgvVt8Dfn1IVaVr7O92kzzWiSf5yESim4POLZuAhLry1w/PdbQzsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5X2nqjj; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708728538; x=1740264538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WEb4pLclwP7b8e2QT8j5/roGXCyuN+PZEaiZngBkkBc=;
  b=Y5X2nqjjhLJk2TYel6JW/0mbs7iCkaCsaeV1vREfHPaRJF7Ex13lbG5O
   juZ2Ge94J0nTj4FFhDZdLrQQ5Og7X4hkx1LW7FohN9QL6w1KjW52MPY73
   4PcBk7IL/YDT/eejuHSQL9DRJQKp125zB63uZp2yAyvx6uqOxvWyBjUTC
   X/en0MBl/P92GMHogy/2WQwHHXYBXRPSjomJQFLw+/ipoL86ZbFMpTG7/
   LMN4TcZBy9U13GsjUrQVPLllAXO5bV5p0PgQ/35l7pGMu6eew64WFQocz
   qff94dlVei6SPT/eFsEkkEUx2M0I38nnjH1ES7sUOVyo7httk+FtzMdbl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13630658"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13630658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 14:48:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10821866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 14:48:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 14:48:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 14:48:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 14:48:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HX8nTGPYZM5BPQ0C+a40oRLEAR+wElvgP5wD+69KB04zy1NCDlI8TDV9gxOW1xs9DUnGETWcdDzz5+ao+JxcOryErbkh3Vbf9F9akN+UeY7qfCgyVEC1aU+EWlb5Vec/f3O91XRZXHxiP+44t8oW2GiIg0Oj+oQfe2yznSMQLdvcTAQrH1L35DL7dZGRxYe8U/5Uag5LYYT/FnqjSlxufL7CTEPkzo4uVW1iIJBMwjjUGuMPUa0vYtw36l464QfqgyFaVummR6S3IfnMhgbdtE7xrD+WvHyvZzIMY715Khx8lM2Rqn7iDtJaxWYtkoS43Q+WYdT6HGC61etdD4cwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Zpchy2n3xScIOTPuLY9mjhHuQ7Vbnu1cjzPxFkSN3c=;
 b=iq+ZK9rqgQ+aJJ72wCS2OD1HP5JL/bd4odgq7bTagEqTB9KLDgwCxLL7sg3PIGuD0LOADHnQIcnqfdXA0hWRCO+PuYwntP++IYTW7xZTQJDrWtztSmfCpAeLTEWRKbyIOaBarwZz8Er8qlw1xbtGeSTYMZIEI1ejGrDFrGyqgY93DxN8rhX57ugsxdU9sZjE6dvQnlAbEYzeqUV+ScoU6BkSjHaoIJmwnomB7XyVvPo5tdQ6gtI/RzpbSfF6PazOvNJXIZMhb6RI9IMlkVaKz1d1cSotAlwTdxmDoOysL73wU/CAKirAYx819utXsckXoaieaxjUBTZgrx+Kwsu9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB6762.namprd11.prod.outlook.com (2603:10b6:303:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 22:48:54 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7339.007; Fri, 23 Feb 2024
 22:48:54 +0000
Message-ID: <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com>
Date: Fri, 23 Feb 2024 14:48:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
Content-Language: en-US
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com> <875xyex10q.fsf@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <875xyex10q.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bbd331-1a00-410c-7fc8-08dc34c19c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCmM6OntOi8gI/4AG3ZyBHqnu2w9UOdbxIlcY2Cbt8GoFKt2qcfoPShP77Ae1UBY+Jj1Q4c7qW/b/qNzVt/93WXgObwnxrcm3+wRQzM+rh2qkX3Hv+zcfRX+/WwFbu1YabTeywS4NdLqsm1pHTmbP9/KlNRgDF7Z5gFNl3HfiQ1Gq/mXNROBFm6LTBB40e4JKANUqrqQYnflX278HZf+GIQq6Xp41+NqUpbKcPcy2AFWwsccbavxAwoLNw6DTZDnObsWAcRnMUPY9Ys7odMvJxJkYneUd6oU5D8S6JUbybB/FgRVzg4zhz1w0rH8yAMg/taew3EnKbz2hukTLjx8SlhcFM+BDNMHpkWyKEglfddk36GduJmJfQjjO0IkdmNB5Hhv6GtcHy+aJ0AyHBJG8XK13+kGDRLjC3M4GUOE+Z31Z01BqFjaODpyMsXmVjv73fwCTrXkC5vg3CBRz5KLw5K4FFRuIu/SJ9Czoo/rW5gKVQh3ILtDBR0jswM4U6MVYYrXR13NJkScnSTZNI/wL0ccZFIrz9xkFCTq6Y0CTa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJHZyswaThOeDZNTlBXenpTbFBmKytjN2ZnWkVOdmhwREZuRXJZcFNHOHdW?=
 =?utf-8?B?bGVtTnMzTUxvajdHNWZKSjFVc2lyOThBeUJ3OExDM3A3aUs2eEhlK3J0cEJG?=
 =?utf-8?B?bmN4VzMxcVBmakR2ajRyVk92eEdQaHFNL2dPWGRrYXlxL0hpc0RacGxVUDlI?=
 =?utf-8?B?WlVueHNzMXhWcUpYWWFDN215OFRhOElwR21sY3pxejVMUHZMYngyU3lpM0lU?=
 =?utf-8?B?QnoveE85UTFEOHhlOWgrcFE3K1ZUN0JoRUYrNXA4NGNjZTdVaXpIY0FjYlo3?=
 =?utf-8?B?VzNha0l3bHl3aVM1TW5KT05saHErNkxJUkRTOVR3S0pLSVNQL24vUEU1anNN?=
 =?utf-8?B?a2picnRYRWozaDNqczVZLzRGL0RJSVZYM05ZVkd4Z09ENk10Wlo3UUY0SGgv?=
 =?utf-8?B?UjNrQ1BhMGYxbHNGTnRHbzd5bjAraUorREdadmFwRjZwSWlSdEdMTXIxYkdI?=
 =?utf-8?B?SXBJd2JTaUp4UFB4TS9adzl0bmJXM2plcXJobWpuQ0MvQUhHS1pVZFNtODl0?=
 =?utf-8?B?VTZIdEllUnhFSXhDZ09iaGI0NVZ6LzllSXhzSXZZSmR0cXpPamFjTDBoU081?=
 =?utf-8?B?Z2EybXNLOXladHo5THBBMmVhUXFOUUswK0lpenkrcmxWU3ZGS0tUTkkxNldC?=
 =?utf-8?B?bWRVYXZEck1rMEtrK0UxVXp5cHJGdlpEamxsb1h1VndVMjJqWkRCWEtUQ3h0?=
 =?utf-8?B?SWZyQnpUUzkzQkJ0L2FPZ1VoWllNVVorbUpNVmZ2RlpVTVhRR1RBU0J2QzNa?=
 =?utf-8?B?NE91M2s2UnBnZ0loc294eHRQZXJ2c0dMaWZ1S3NqbU9ockNjWGRSenRLZDY5?=
 =?utf-8?B?eUszdFp3MEc5aDdUT3kwdUEyd0pWRDBrWlFhazR6VC92Tkx4dXEvaExJWnBo?=
 =?utf-8?B?N2NET1grMEFGc0EzNzhNZnpLV1U3MDZJY2pVRFR1SDRPRzBqUFY0SFZPS2Qx?=
 =?utf-8?B?TVpLL2J3b1ZkcFdzVFRyWnRsMThoelVXVnFOV0dONFFzelZLMW5aejMxc2RF?=
 =?utf-8?B?TkxBeWIyN1NqME9tKzkrbzJBSXBlZXo1M2NpS3ZGR1BBS0lxNGc3MENuQXFy?=
 =?utf-8?B?ajZ0T2g1dk44YmZkVDFhVUtuVERoVUpxRUovaWFhUUJkR3BZSDlaMUV0VGE5?=
 =?utf-8?B?MUp2ODhLd1VYRzNmRVJKRml0bSt3VjZkM1VPYWpZc1BydklENzhyaXRRZ0Yv?=
 =?utf-8?B?cGdJK0JtNis2MjNib1dXNlhuNm1MN2h5Z01XNU52TEgraW92d0xSbzNIc2ZF?=
 =?utf-8?B?OUZKT2dtUTdQclh6UUE0YmJTbmVOeGhyWWVRWkx6T0Zkay9OU0tkMWR3eUZZ?=
 =?utf-8?B?WlBCUi91R1UyVjNzc1JkbGh1RDRnVVlKd0lrdWQyV2VSUU9RNnRVSTRXNXM1?=
 =?utf-8?B?RElIYXRhV3ZXWC9ycFU2b1RvcExsWGlEc1NtS1ZOSHRCVTB6dXlaWFlra1pR?=
 =?utf-8?B?S2d6WEkrUjU2alJYZ0lqaFBLR09zUXl0WVpYaENVemNwdHVsdENsNndpNnlI?=
 =?utf-8?B?dWUxSUZJeE0ybS9PUHFCampqSUxSQXdMc21VRTlKSERPUTdxaEpjWVRGWEl2?=
 =?utf-8?B?NU40V3dLdExMQm1BMUtDM0N1NDByMTlLbU5CMnJZV3Z5Mkw2RElHdlZTWTlO?=
 =?utf-8?B?eHEra29rTnVNUnFJandMQnR3YzdjZ09UR3p1QzVQR0dyM1Z5L09qdGZROGVR?=
 =?utf-8?B?MGFqcnh6a0hIckZFNW9PbmN1ZkdJTk5sWENHd2tDZmNqZ3g3RUNuOGFWTmJx?=
 =?utf-8?B?bXg1a1hoa3ZETWFIZEY5WmU3a2F3ZTNXOWN5dHY2NmMyUlNnQlJielRUdmZP?=
 =?utf-8?B?cjk5ZzA1YXB5V2xTK2dKQ3A5ckdEaFpQWHVMMnFFQnB1QWNyQUxLbTF0clNt?=
 =?utf-8?B?WE1ycnMvRExtSU82QjUxR3dEZFM3QzZVZHhBUk9tK1NhUS9iNlRvcmlRbjBR?=
 =?utf-8?B?dkIzUUkzRW5rQ2plQzI3YldjQytQQWpDYzN4MG1nd0pNbnFLUE5LQVYrYVQv?=
 =?utf-8?B?dWZEV1NBT0dsd09UY20wT2JoN0JadDBQVkV6NFVoSFRoa1R3alE0MzVNVXFV?=
 =?utf-8?B?ck54ZERzM3dGSFlXVXIzR1UvL2YzUU1JK2RHS1kyOXlrWlM3UGEyS2lXMDBz?=
 =?utf-8?B?U3AvUG9jSW01a0JiWGd0TWlVaWlPZlV3cGlhSTY3RW1kSnJjWkllTUovWlB5?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bbd331-1a00-410c-7fc8-08dc34c19c76
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 22:48:53.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SY45Ols9vFHM+fHq5Njivauz1UKpoU6cUeUv6NqwZkrbzSIhbikqZH84RiLsk4gw1g+F0Xr2rRKdT2pcgXssc+kYYiG40LRkb7xDn443YRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6762
X-OriginatorOrg: intel.com



On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>> The Intel ice drivers has the following Tx timestamp statistics:
>>
>> tx_hwtstamp_skipped - indicates when we get a Tx timestamp request but
>> are unable to fulfill it.
>> tx_hwtstamp_timeouts - indicates we had a Tx timestamp skb waiting for a
>> timestamp from hardware but it didn't get received within some internal
>> time limit.
> 
> This is interesting. In mlx5 land, the only case where we are unable to
> fulfill a hwtstamp is when the timestamp information is lost or late.
> 

For ice, the timestamps are captured in the PHY and stored in a block of
registers with limited slots. The driver tracks the available slots and
uses one when a Tx timestamp request comes in.

So we have "skipped" because its possible to request too many timestamps
at once and fill up all the slots before the first timestamp is reported
back.

> lost for us means that the timestamp never arrived within some internal
> time limit that our device will supposedly never be able to deliver
> timestamp information after that point.
> 

That is more or less the equivalent we have for timeout.

> late for us is that we got hardware timestamp information delivered
> after that internal time limit. We are able to track this by using
> identifiers in our completion events and we only release references to
> these identifiers upon delivery (never delivering leaks the references.
> Enough build up leads to a recovery flow). The theory for us is that
> late timestamp information arrival after that period of time should not
> happen. However the truth is that it does happen and we want our driver
> implementation to be resilient to this case rather than trusting the
> time interval.
> 

In our case, because of how the slots work, once we "timeout" a slot, it
could get re-used. We set the timeout to be pretty ridiculous (1 second)
to ensure that if we do timeout its almost certainly because hardware
never timestamped the packet.

> Do you have any example of a case of skipping timestamp information that
> is not related to lack of delivery over time? I am wondering if this
> case is more like a hardware error or not. Or is it more like something
> along the lines of being busy/would impact line rate of timestamp
> information must be recorded?
> 

The main example for skipped is the event where all our slots are full
at point of timestamp request.

There have been a few rare cases where things like a link event or
issues with the MAC dropping a packet where the PHY simply never gets
the packet and thus never timestamps it. This is typically the result of
a lost timestamp.

Flushed, for us, is when we reset the timestamp block while it has
timestamps oustanding. This can happen for example due to link changes,
where we ultimately

>> tx_hwtstamp_flushed - indicates that we flushed an outstanding timestamp
>> before it completed, such as if the link resets or similar.
>> tx_hwtstamp_discarded - indicates that we obtained a timestamp from
>> hardware but were unable to complete it due to invalid cached data used
>> for timestamp extension.
>>
>> I think these could be translated roughly to one of the lost, late, or
>> err stats. I am a bit confused as to how drivers could distinguish
>> between lost and late, but I guess that depends on the specific hardware
>> design.
>>
>> In theory we could keep some of these more detailed stats but I don't
>> think we strictly need to be as detailed as the ice driver is.
> 
> We also converged a statistic in the mlx5 driver to the simple error
> counter here. I think what makes sense is design specific counters
> should be exposed as driver specific counters and more common counters
> should be converged into the ethtool_ts_stats struct.
> 

Sure that seems reasonable.

>>
>> The only major addition I think is the skipped stat, which I would
>> prefer to have. Perhaps that could be tracked in the netdev layer by
>> checking whether the skb flags to see whether or not the driver actually
>> set the appropriate flag?
> 
> I guess the problem is how would the core stack know at what layer this
> was skipped at (I think Kory's patch series can be used to help with
> this since it's adding a common interface in ethtool to select the
> timestamping layer). As of today, mlx5 is the only driver I know of that
> supports selecting between the DMA and PHY layers for timestamp
> information.
> 

Well, the way the interface worked in my understanding was that the core
sets the SKBTX_HW_TSTAMP flag. The driver is supposed to then prepare
the packet for timestamp and set the SKBTX_IN_PROGRESS flag. I just
looked though, and it looks like ice doesn't actually set this flag...

If we fixed this, in theory the stack should be able to check after the
packet gets sent with SKBTX_HW_TSTAMP, if SKBTX_IN_PROGRESS isn't set
then it would be a skipped timestamp?

Its not really a huge deal, and this could just be lumped into either
lost or err.

