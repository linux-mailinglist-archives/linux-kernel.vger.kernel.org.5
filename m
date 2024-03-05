Return-Path: <linux-kernel+bounces-91494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD0487125A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED151C2127C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAB2F43;
	Tue,  5 Mar 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx0EuE1X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B617BA0;
	Tue,  5 Mar 2024 01:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602308; cv=fail; b=eUfCExbJFf5oqzAPKfsrRNFJN1PYvlKhrMjk5XzJjlseHzNFWy6qHeknwxecKcrFwGzn1lwZgRvfLQg1Pg5YhYDPivASUjv3ykFKYseSWWI42jcX1bmWXKGyCj2RFVziSm0Oc61u3xRUbqYFbJljMq8e9R1FA5sagPpvnnwJQGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602308; c=relaxed/simple;
	bh=NPis0i3mEbetZ/5l0Tj1LQGbRYYkRhqT0ZuSI2eFOGA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eZH1Q7oPRWSOTiQJbaUeZs+cSKNExqzmmxZq57SIxSmUMHTnWIC5yniN0/be4Nh/ztaNoJaxGuA0vcMH2Td4rAnOWl4a7qUS9zb0CJF8BVex5PXeuC83lVZ3xYOx/rpBjfVC6rX0hEt0dqtg66hktQxdD09RYPPXpc9za2FRhig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx0EuE1X; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602307; x=1741138307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NPis0i3mEbetZ/5l0Tj1LQGbRYYkRhqT0ZuSI2eFOGA=;
  b=Jx0EuE1XkeLI0yPSkA6p27PmhLScG8r5+gvgr0/xNRhIFOtiFN7M5qJL
   LzMJDTir+KN/t46zxVpSVfOSZ3JDMOKv12fXCQBiC0yNzYVVTaLaNERc4
   AztNrIdqmy1vWx9Zr9nSsOxNB7vzdJE3kDJKYPb69GkoeFk98J8JUug8Q
   UiAXmAouUP0xQmEI9YzNza8D6nm3MB+ycE5fP84KY4F/6apTHVtav1rHb
   aQlh9FSShlcxh4PQTnAB5chlxgUidbpha2AP/jfh9Mmv6fWExf7BkvVwJ
   BVCdnzPo9ntGKSged5Oho7P5BWdZ1AH8edjgoSVL8RLB/q1j9HrTAa+1H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4008398"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4008398"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9098070"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 17:31:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:31:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:31:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 17:31:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 17:31:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9EVA681UZ8bkJdCRM6SRdyEjrOmGylTgRtLEocLHpWRhWPy2mdiZWCS9xAXFlirMzxe5iOVkhRaAuB3qjGuKwF3ypWT8Z/BAgrp+NbD6+qMctYBvza18esFaFTZmibSu8TYvHqoA91xSvzehwbVv7Jvp3EhzrchZ0/TT+uy5qBcTii47uIyl4kxOdVmNCbZLrvSGp50+tSYCbDuUYcn0U8BN7bnlwNktn78RmoNEmQf4lnAy0XD8LvdIH+1KlBh8D1+Eg87QbaiPhGHxHMwvethEUraqQsmoBuGAv8tM1zgso2Qd9ZvyXZGW+IrpRFwaaswzRPvGjhbBkSXOp43Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot791j6gPWcEaJLOhADUSiO+EJ42c3KpYyVPfDF9Vo8=;
 b=jGHbc6P/nfqd5j/fWFw9f3IAXEhFBWV0SKru6NnxrnCxRiV82pP+jRtcAFJh+Nvk5jhPvhdQXuipjFuDvr1g9E6h+FKWKGjnIxzkCilJ5Vu5D/oOWOXgQ4lQKu8j5cSqvf3gttOCBpvqWKf52sKk7RXUZRl2Fs3w1K/X/G2pENry/vp3htJpV2LWGyXAgJE6gM6D8ARZ9Kv+bq9qYW0+TxANz0PXkHth3aOBC/OrvUiLxGYM2J+oNKXyoYCqC+iuhI3XN+KxZGQ1H6YpfvIIBlHdJGY1KMH5gszWoabV7KQbv8658GEUKLaldclbwhg97+T+xTntT6SmGFSUpO4l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by SN7PR11MB7568.namprd11.prod.outlook.com (2603:10b6:806:34e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 01:31:42 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 01:31:41 +0000
Message-ID: <428622f8-8dd9-40c8-8762-6bdef6d3a785@intel.com>
Date: Mon, 4 Mar 2024 17:31:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
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
	<patches@lists.linux.dev>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
 <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
 <SJ1PR11MB60839371908CDC17A01F2167FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB60839371908CDC17A01F2167FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0001.namprd21.prod.outlook.com
 (2603:10b6:302:1::14) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|SN7PR11MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f84a55-46f7-4a83-4d52-08dc3cb40295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMRZSc9rdJsboFhnQ6IOQKYo7hFNCCrMYaq97zf7y9Ti9Y9ixQTxdSezEXKEvcuW1WVB/Sx2vDNHGuteOzDEN1aMnOde+9ZSwUUm0o1QeDtioBxvHcn9ECpTcA5JPvi52G3s5m03IYSrpW80uOxJnDdmTQTseR1GjjVS06MCxFFSC76K7oWlg6IkJekk5/vftONP/zM/osGbl6DJaZh340Twutii9mJ85iOsyxpl3Hp5mMwL+DQJWDiwA3HKNAPZcQb9W1EKEWaW6PJ+BdxkQgLytVlxvy5QmV22dOtn/RflbeKBpe+YXWge0aqlREAnmkzSJ2sLYGEp4a+Spl+/j95kUpko7gehI7ksI0f7kj1lpxcvVJMAyqf4mjgOyd+JCb2CgKW7hwTCLFuGhPPmSgEoen4uWPJZnOjlRjFB39//ftvWivf9x5oGgCVFjRCOeUTGxArUw0WgINRx3sb7TTrpuytUcEPY3QBQZZIykrlR4BbZqk+ZaZUZy2BVTVIvm1KF7M/JHpqpF0xQ3Q5uXRCjhV1k1AzwuQZUCgs0sAwb7TZuRBOAZMCkLJd5xlNJsfKCZQpb9OG4Q/XqnpwamXQnnwu5FGO9AESSHffwaTnBGTDAgJL73hHQ+W0AvBv548cPVVdiFoe9Ur8EumA0jaz6r2LaMdXB7TirdyyO35o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXRHMUs0ZTh5TytlYjlpc0dXODM2b0pjVWxHT0hkNk9YemJqM2FNRG1CN0Rj?=
 =?utf-8?B?cEg1YTJKY0pWMGgwem1lNGNzWHpNb2Q3TWJLZk8vTUVoWlhhZzl6bWd0SnJI?=
 =?utf-8?B?UkhtNzdJWTlwRlBLVzJRWVk0Z2FNdENuMlVIdEJ5dW91eUxGNEE3VHJGeWpP?=
 =?utf-8?B?elFYRzB3R0xFMlpNczM1clpIN1BNT0ltNU9Ocjd1Vnpyekkxd0pidkVXb2lo?=
 =?utf-8?B?d1RYMTRzZ0RMTVZnbXhhd3NpTDZYZ0RJWDlBOE5pR2FDdU9nejc5T0tTR041?=
 =?utf-8?B?ME1zWjlyWDdKUDg5NnNYczFYb1BBbjNLTVZnelZnUWJWN0tyOGV4anB6Wk9a?=
 =?utf-8?B?ZWRyRjNVUk9MNkNtaDRPa1plUGdpMC9HQ2NEQ3B6bGtRSVhFejdVR1RpbU9O?=
 =?utf-8?B?YnVjZC9jTk9RR1JDb1NBQ0VhU1RDbmRxbEdBQXh4MmsxbFV6YW5hTEptaUdH?=
 =?utf-8?B?NlQwMWVkRmdmTTJHNmd0ZlkrR0hOQ3Y1YkJiNDBrc3ZtcjhMS2Q2eGc4RVp4?=
 =?utf-8?B?bTBzVDdLU3p4WlUxbjYrMkJyV0ZiN0pYMVVjMmVHT21oYUFWUEozMFlKWU9M?=
 =?utf-8?B?MG9pMnFKVWw1bHRJVHQzZUVjWnduL2FLV3o5VGVLckRiTTZQQVJ3aWducFVK?=
 =?utf-8?B?SkFNUEVSV0xBR1NsVVZxYXZuN1g5UjZNbWcyTGI3NHBqay9wTVYvM1duUFNs?=
 =?utf-8?B?MW5tcTYwUy9SWnpMRTltRUlsWm9lNW5JWXdQV2hUVUdpUVNTK0dvMkNnOUl3?=
 =?utf-8?B?K0V5YTdhblN4ZWd6Q2ZEbVdJTEFvR0RoellXY2hrNkxYYXF4TE5IWGVlUGRp?=
 =?utf-8?B?cGlITmlXMkZ2TlZYdU5JeGNRNENtMTRtQWpFZTBkR1lvMmJyTmNIU1FESzZ3?=
 =?utf-8?B?N05WT3pENE1yNlpaOWtmbDhtVVgxbGtKR2huWkxvTU94OVk2L1dqVW9PeStC?=
 =?utf-8?B?SVRyeFFFOThwdFluUnNvczd0UXRSbWZHaXB1WVZXcEM1WUhTaWRodVFYc0R5?=
 =?utf-8?B?SktvRUcweFI2QnovWk1ZamxScTFWVlE3SUVEay9qL2lYbkRQY3o3azRJTGEw?=
 =?utf-8?B?S2FRZSt0Q0ZITENJNzZnWllGTG9CZFVHMVJJUUpkV1VzTnM0emtDV240cmF0?=
 =?utf-8?B?UFEreHFPUEkwOXpqWWovSTlhM3B3WCtwaUw5dSsydnhEZ2RRUmhSb0VVcU1N?=
 =?utf-8?B?ejh6WkZSSWR4cnVmL3NoOGJSdWNlTEF0Ylo4U2dTcFdJdXhyTzZYdGVLbjlF?=
 =?utf-8?B?cEhaZ1VxdDhvUjdIc0hFZ0g4Y0xpZEQ3U1I5b3FmbGQ0N1MwU0c4ZzNTQ3FS?=
 =?utf-8?B?Y3I2QmMxSXpIenNMMlMwV3hmTXltWGp4NFRQMXJzbGVranpLQXNjd3gxaWlP?=
 =?utf-8?B?Z09XRm9TYjdrTXRLaUlndE9FeXViaStjMERyM2REbVRUYjBtR0sxRjczYzd2?=
 =?utf-8?B?TTV4cStxY0N6Y1BDYjZWYk5CRFVpSFJudUhkTFY2L0J2RGlybHlja1BXTEpO?=
 =?utf-8?B?cEllcHJTUkFPaWpYV3B3QWh0TnZQRVNIbmp0S1pGNTVIK2I4b0I1eHBFRWo5?=
 =?utf-8?B?VXY4UCtFM3p4SXZNZlBaVm0veEhLRWNOcTZjRDBaMFBrSlc1Y3ZIeGZ0ZmF1?=
 =?utf-8?B?Y041bDJGSE9pMTJGcUthalFSM2greml6eGlVM0JsS0g3V2lobVppWjlESjU5?=
 =?utf-8?B?NEwyZVNIRXZmZytsMGFmWStNTjc1dndkbzZibURzaTN2RzFibk5xMjgzdDhj?=
 =?utf-8?B?eHJXd2M3ZlAzYVhZeTB2czJJYlBtQStqNjNmelJoWkh1TEZRYnp6Y2o0UFRp?=
 =?utf-8?B?ZVZyZVJNbHRWUEdGL1prNVRHbXJaKzE4NHAyckh0QWRQWlRuS2U3SmZrQkh1?=
 =?utf-8?B?THpCZU1pejQxLzYwR0h0S1ZkQmUyS010djZqSXdidWlyc3QwNUZzZEs3cmJG?=
 =?utf-8?B?c2pmZzhscHVnYnZtTDZvRk1yRktjNDI5b3I4N0NSRkFOSDErMU9oV0tJaVJY?=
 =?utf-8?B?SjZBTGxUSEhmd3drM1JiRkdWYUVpNDdPWmJZaHRIZFlQQUk4QUx6L0ZjL2Rp?=
 =?utf-8?B?a2t4N1FqL241dmpVNzNJYkhtMmY4b1VFL2kzU3ZIWUF4M0cwdUFYRkpBSWp4?=
 =?utf-8?B?d0NMVEx0MkpQQU5zZFNXSy80THM2SkJUZDIrdGRyOENzb0pLL2NSNWxvK1E1?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f84a55-46f7-4a83-4d52-08dc3cb40295
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 01:31:41.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuRKb9V58sLkB5tZ52p/KT2NxKbb22qMRfNoaANfct3XMZRFHPo1FGf3rfQoOGn6Ze8FPwrguJ8kxul1kESXo7u9pgvrpnUder7Ugkp9vxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7568
X-OriginatorOrg: intel.com

Hi Tony,

On 3/4/2024 4:17 PM, Luck, Tony wrote:
>>> +                   cpu = cpumask_any(&d->cpu_mask);
>>>
>>
>> cpu only needs to be assigned once. How about initializing cpu to
>> nr_cpu_ids at the same time msr_param.res and msr_param.dom is
>> initialized and only assign it when msr_param.res is assigned?
>> I think that will be more robust.
>>
>> If you agree and do this then please feel free to add:
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette,
> 
> I agree. I'll move the assignment to "cpu" outside the CDP_NUM_TYPES
> loop.
> 

If I understand correctly that would always look for a valid "cpu"
even when none is needed. Not quite what I proposed but should
work. Just some wasted cycles in a non critical path. 

Reinette

