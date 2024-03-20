Return-Path: <linux-kernel+bounces-109123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D748814EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F841F22FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AC54FB1;
	Wed, 20 Mar 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mhelrzqa"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5EF53E09;
	Wed, 20 Mar 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949859; cv=fail; b=qpX+HQ7pTu/TSJ1iUY7SjHnKBrtNo8TmgAXmxyIVGdNCT/PYgGfUe8V9NrxyruHaYkMGKj0e3eP2Zn/7J8pHqdzDxLzF6lh5Y/uWRncPLlcVqvvwnGJes0rC84xpv4Acl7HXAGDB86Xw3aLOo2FyONR4SnCuG4E3Fn1Ar2vAvns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949859; c=relaxed/simple;
	bh=q6FAzkk/LxWM59ZeEoigkuW3dP1gJYGX6BrmJLA6ZKQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=loDHL8jEMShiTIO52CvGA+Li7FLa/Grlx5ZSarSZPGFvttV1XCPOtBtqlDXN0GVZjBpsT1+WH8n9gTt/1JFIGnU383VmZhNkLU8C+iHkKo2oyfByeebmV+9XD4wDARGU6oQCjzOI1XjG5zS3iL1J2cOI7uybBOgpfHLVpO+EPHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mhelrzqa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710949857; x=1742485857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q6FAzkk/LxWM59ZeEoigkuW3dP1gJYGX6BrmJLA6ZKQ=;
  b=MhelrzqaB4RvqAF/bY1r5gcpRaJoHZ5C/6K4tpvWLHXQgEtJ/7cspKPX
   qIPEfwd8wZ5jrheovuD6Msf2TnBRibaiIsicF3SWdgk7MjL3YQoK3B9WY
   7jdftYhDK7w4BVqXSEbX01wHpm5Bdmz6LtJtdNbN7MyrXUBhG2xwzU7Eu
   aOhYVnQC+Bvvx0MSZoSP3IjTZQ/2TCUFKZUiDDRdU0c6fmhpCxi60Jc2R
   8JXw1nPlqU/5Z+OCaWkIU1/2yumZ48pSaWTxSlC/c25mue1a7S2xau5Ab
   EdASzH86azwNga2WBf6JsI/mDEjr4eEOz5Q6N/FwuDgiRqAi53Rh6WkRc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5755475"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5755475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14204387"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 08:50:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:50:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:50:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:50:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhtsC7FOWWFZTSkirnRo+MvtnYIxx1Luyo91E73bidz5rVOcKJ0hLZvOEHZUVa/3v1R899YKmTq7tvxVVODiRoH9MC2zBjzOk3rlc+EyA+14yCsNMfHZxJFk7R/h3w8cFcDo5p53CXDOLHLjswymfCnI0Q2iq3DiKOkPjuvuzvj84oUl7BZKj7ZtQqNthQy+c7+NMlvMylGM3ggkGfzINvGW5VSOVTkQEzsAHevoW6lOpDIAMm/Scx4Q8pUL8fuRK+TqGepM8mAYeFMJTCS8Pjw4/oWCpsmbEbw0fIaTGbIH//ivZExWXG4JUi27b7b9+15cLOSR6SBy0RLEwJXWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OofYxcGrnL4vaGDJMBE0LAm22wp8jqwalFn32kIxXsk=;
 b=lJCmtbQ3LATTI7ot2RLWhbWOr0tJD1tm1QoiQ2rqwjsmBqDO7E3mGkculIyr/J4Jo+YdqYpCyvnO3efL31zUl+yLW3Tsz+DhAJN2hQG81/J0pCAwY73v4APIDcJeM0xl7OPGCD8U2b4XuYJGZNvumubZa4AhcyIKdq9EYSOYDYdTFi3shW/Dx7JKj6nM0LrDVUXTLrT9Y8Qqbb/MjcmBGfoiEkDOC46njC7YOx2Jj6Jrm2bTQbwda0mLzU8N7WE6CqvepZSSmSDeK/3ggToNlXW/jjE3Gn98MprZiWlS9Ots6LonCGGgmVSg+8nyrytTItQw2kz6vIVU0TB8NToHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 15:50:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7409.009; Wed, 20 Mar 2024
 15:50:53 +0000
Message-ID: <7656a3fe-56d2-4a9f-9dfd-6f2666f38110@intel.com>
Date: Wed, 20 Mar 2024 08:50:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<patches@lists.linux.dev>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
 <5vnrboxpkrriiqcbwrxtbextu6pduqjfchlvsdn5nwe7lr7vou@dngffvu7a5fh>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5vnrboxpkrriiqcbwrxtbextu6pduqjfchlvsdn5nwe7lr7vou@dngffvu7a5fh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: c88a8c9d-8bc7-42c6-0101-08dc48f58659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C94aF3o1Iir/RV5UJQIY2MzdEqzF+EG4Caqi54RbVSWq4XiNjHK/imuytnPXIEFieV6O+t8GSOacWSETc6MsHZc1oJ2FCtT4pvQ6JjeTRB/5MoPZ3oXKV0Tzs60C+z01iSJMRzAugd052taU+JIiOpNiLeokLorzkNR7EVGQ/lA+A+EacQjhHU8auVM/RfwxsLCARZWBn2CI0KBv4XB3KgOA0cCPTtfaBNr5wL+nRRdHMN6Qyh1TCEVVFd55u8TVWnlmdgvBrctaIRlf9teM1bceJ3ZiIVTVATeek+AYaWzkIc8zgu3mz+m8UA6WIV4eo+zV942P9t1RNgpRZpFBBQQbbzVO0pJNRati+wCGYXFTGUjtskjvVljukTvNHTmeHqf2tV87JcbNZ/GKf5rMB/TCIa3whL6aVjrErrttmFmF/c/pbG/vHZf8ZTcxbKXtogyEyExPyWH/goxR3mNM+bz9kLZanemRARVYmti9im9tsbK9LxcCybuFjuWYmBKm7yaF2dBeJrBI5gChQM5/3WzuGQqmdplKKMKXPOTBDl1wVsl8lDNN66tKRmvDghH/DYFfQdlCZIPFkzXbJIa/Thu+fUEULoRCVznKNuAcJjDUp3H/l/xmH7SYegAr2j1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05uOHFmWU00UmpKK0w5eWxqY05zSjFwK1BYYlFPa1dTK1VBZzdiWGk0OU5r?=
 =?utf-8?B?WmYzejNQaHN0YS9aaWVxTVlSWTBOcjRIT05DVkFWWUN6LzBSb3crdmJ4aytR?=
 =?utf-8?B?eHVDWFBkT0NON0p4VFZpZmFOR3hWT1AwUmFXTnpBNXlLNGpoMVkzSU9MQU9Y?=
 =?utf-8?B?Rlh6Q00rMWVJMVZpelVUY0VmYWdBblVrUW1FQ2FSbWE4YzNsdzJtaXpYaEFv?=
 =?utf-8?B?ZG9JTm9PK3BYR0VyL0ZHWXBDMHcvWG4veHVMRERyc01OOVFPNFd4REFLcE8z?=
 =?utf-8?B?dWR6ek12c3hLVzJZRHArWXFMTnlnajh6a1ovaVVVdnZRMWZDcFhWS3g4cXFj?=
 =?utf-8?B?cmREc2VBbEphejQvSHAxa04xdktPeVhGOC85Y1NXTERpcVNVUVVIQ3N0ZUNO?=
 =?utf-8?B?cy9PSEhTbnFpSDdRbFB6cXcxQWFtTGE1bEFYb0VsaTdXN0FtRzBBVE9vM3VL?=
 =?utf-8?B?MENoZU9waGZrQkZXcHNtUDhCcTdzdEdESWhxZGZkVVRHbTRUTlZUOEdBVGpn?=
 =?utf-8?B?VzJEWllmbWRlbHpRZzRYSlJuVVFUWi9xZ0w4VVZmdWlzSVdYS251OFBsQnh0?=
 =?utf-8?B?dG9sZmdlV28xNG83OFlVaytjOGpULzhacmZtQnlXa3h5N2d3L3JreXhDazFo?=
 =?utf-8?B?aU5TVUdtTkg5Y0xuWlRjbEtnQitsd2JJSGh6YUxrYTJnN3dMT09jTzZISmpr?=
 =?utf-8?B?aDBKdmpEaHRkZWZTbU95M3RMcnBzWXh1Nyt2TW90M0RpK3hacm9KSnFOL3BD?=
 =?utf-8?B?ZjNwZUI1UEMzRjNPSUIraXR5SUJZTnI1dEdJcUhvbFJDVVRqdDY3Mi9Ya1NO?=
 =?utf-8?B?YXJHZGFZeVNrQlZBbmV1azBwVEp1ZElBRGhrN2F4UnJlcU5lWS85MDNLV1lS?=
 =?utf-8?B?aTZpTGNQeTNUM3ZLMll2Tm5yYXgzdmFuZFdYS29hRFpyLy9raHltbVFJSTQ4?=
 =?utf-8?B?OURLVzAwUlNuZkRpVXFQaXNhWE5lQXNjREFRRlFGU0M3bDJFOXFmcmtsNVQ2?=
 =?utf-8?B?KzJla2RXWlpjMTMxN1VrbHFtbHFHZGtkYW11TFNHbVNqV1p5SDZ6OW91UlRT?=
 =?utf-8?B?dVNUdXFzQ0doRi8reFdFUzlRY3d6dHQ5MWJkTk9LTm5jbnVjRUVRS2ZuRjQw?=
 =?utf-8?B?emhSZmlNVCs1NnppampwRGxOK2t3dW9LUGFJYU83c1ZUdzROUFdwekc5Y1Nm?=
 =?utf-8?B?R0RXbkRLUXhGRnpCYkxkK05QRWJoay80MTZpZ1dHM3QrOThGcjlsYXFxY3pt?=
 =?utf-8?B?bVYwdVhPY2RBZ0JmUHVBTkpVOUVpeU5JS1N2dzZQelpZZXhETUgvbnZnQ0d2?=
 =?utf-8?B?SzJUVm9FaEZTOFVjLzZMZmRRcUc0QmlsVjJqWkd3WTVnZkpyRGlkVGJ6L3gr?=
 =?utf-8?B?T0NzYnlmWkdDMEU4ODJOZTJpbkpMWjhaRDVzdUh6ZUNCeUgwNmxhTkN2bmFG?=
 =?utf-8?B?MVJjdW5TQ1NBSVBrakN6N045ZG9UOVdWTlJmQllxVkFmcmZOUEV2OU9ydVhF?=
 =?utf-8?B?U1cvbWZDV0M5UjhCZHg3LzgyVW42VXQzYkx3blY4eE94MHVKOXRlTHRvbzM0?=
 =?utf-8?B?bnU0cjVjR082VzloVlltOWFtOUxKbXVXQk9QRXpvNlJQUlNMUy9TM2hBeXJF?=
 =?utf-8?B?ekwvN05OWEhJMlJoRG1UcXc4ZVVvT3pvNWVIQjhNa2ZyMFh4RkRVMU9yZWZj?=
 =?utf-8?B?NUpLRTdQNGhrL3lzckxPa0QrQ3JNOFhXbWtPNEZRTndQWGhtdE0yVFNaSUpY?=
 =?utf-8?B?UkdJa21WRm5SY0lxZjFuZnhNbklBbnNRZ2x5ODR1bjR5M21JOWhzN0R1MGxF?=
 =?utf-8?B?M25OVVlFK1I0MjV3WWZuOVhLMy9qczNKM04yOEw3cGNmb3VUd1F2OFpvV3dy?=
 =?utf-8?B?UWN1VG9YQ2xoSUx6S2JDQnkzNnJYQ1ZxMXg0UFNXenpubUlxWEZPQWtiYmlB?=
 =?utf-8?B?dE82N21VQ3FISHNGdzZQWnVWdkxZNmJFd0lLTy9sY3lhdlpHM3pPSzVka3VD?=
 =?utf-8?B?cFdGYU9YRTVLblpjWjNuSll5TkFWdzA4dzZMajgzYno3cGhGRFVuLzlHZzJP?=
 =?utf-8?B?T3Bvc0oxRGVVRytsak9wMUFlV2NRV1JnaDVWWS9kMWhML1A2SmFSWkNSY3Iw?=
 =?utf-8?B?NFFYT3RLeXZsYzVqdHpkOFJ4M0dsUFpQa2xzdGtxWnhGYUNwaGFDSUx2VHRs?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c88a8c9d-8bc7-42c6-0101-08dc48f58659
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:50:53.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jv7ajCydS5XiEgoGxy5dm9wejGOv1aQ7EG0wj8WpaMsfqx3Mf9ITbX4aiBj7UCQXApmI2T3Y0Xtf5P3D8kT6iq52Tp4GlIJ6TKmtCaL3AxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7593
X-OriginatorOrg: intel.com

Hi Maciej,

On 3/20/2024 8:21 AM, Maciej Wieczor-Retman wrote:
> Hi Reinette,
> 
> On 2024-03-19 at 10:51:14 -0700, Reinette Chatre wrote:
>> What remains is the user interface that continues to gather opinions [3]. These new
>> discussions were prompted by user space needing a way to determine if resctrl supports
>> SNC. This started by using the "size" file but thinking about it more user space could
>> also look at whether the number of L3 control domains are different from the number
>> of L3 monitoring domains? I am adding Maciej for his opinion (please also include him
>> in future versions of this series). 
> 
> By this do you mean comparing the contents of main "schemata" file with the
> number of mon_L3_* files?

(assuming you mean mon_L3_* directories)

Yes, the "schemata" file can be used. There is also the "bit_usage" file in
the info directory that indicates how many control domains there are.
Do you think doing so also falls into the "not obvious text parsing and size
comparison" category?

> 
>> Apart from the user space requirement to know if SNC is supported by resctrl there
>> is also the interface with which user space obtains the monitoring data.
>> James highlighted [1] that the interface used in this series uses existing files to
>> represent different content, and can thus be considered as "broken". It is not obvious
>> to me how to "fix" this. Should we continue to explore interfaces like [2] that
>> attempts to add SNC support into resctrl or should the message continue to be
>> that SNC "plays havoc with the RDT monitoring features" and users wanting to use
>> SNC and RDT at the same time are expected to adapt to the peculiar interface ...
>> or is the preference that after this series "SNC and RDT are compatible" and
>> thus presented with an intuitive interface?
> 
> I kind of liked this idea [1]. Hiding SNC related information behind some not
> obvious text parsing and size comparisons might eliminate any ease of use for
> userspace applications. But I agree with you [2] that it's hard to predict the
> future for this interface and any potential problems with setting up this
> file structure.

Thanks to you for trying this out from user space side and highlighting the
difficulty trying to do so.

Reinette

> 
> [1] https://lore.kernel.org/all/SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com/
> [2] https://lore.kernel.org/all/7f15a700-f23a-48f9-b335-13ea1735ad84@intel.com/
> 

