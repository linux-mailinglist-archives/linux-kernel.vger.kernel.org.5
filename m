Return-Path: <linux-kernel+bounces-109165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79FA88159E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DB528350A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EA54BFD;
	Wed, 20 Mar 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0RU/nwe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADB4F1E5;
	Wed, 20 Mar 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952065; cv=fail; b=ne7qvuE94TJXe6iJYmYLvkBogefvRzj3X+z8If9m7rTN6f0qcPtQsSp4/iwuu+2MX808bDnBND5ICpIuKeMdDedZS0atJ/3JRq8gquf2bTLcb0y0DyWytLeG6uhSunaI5qwFkzvOyeSV4OI6hc8E3mqRI28Oy14Q20bkFpDD5ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952065; c=relaxed/simple;
	bh=7oJW7wmSBP7VEPEGNdfoKGZOzoAtRbDbWbcfnTjyaWI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AMXEL+BnL72TR3OE8/qFOkR7tKg6yCnDZSbBqk1iRsdvA10/229a6D5lt9cLo0an8Sj5t/vOSdHVSuS3/TlnMENPToyMQS3tsv/lJXGdLpgambsNkiSSMTJrOgMa6wIUZ3pvOxM27uy5lSBXoW2CJNt9ae7GnjMoI2+0f+fq5m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0RU/nwe; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710952063; x=1742488063;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7oJW7wmSBP7VEPEGNdfoKGZOzoAtRbDbWbcfnTjyaWI=;
  b=I0RU/nweDVvzOkffiSz45xdcU9/HcoCGQL5GSuY/yvQbJd7z6GUTHq1f
   CnELX2hoZDdWYfIRCEnWw2PoJ3v8IlSxoLtcRztiTxJfzmQqmf2q6W0FV
   Fw4Ok1GKDRcB+aKw1tuDAmUoPabq9oFtx65ZAhtHmdIsd3frVfJ9uXjeg
   I5vvvPyiM4QEQqJcwc9KtxcPYsxTOOpfhCnX15l53b5xuAXpo9gIMQ7hS
   4r8VBqZJgyejKJ7h/Lu8xxtw4BYlgxVhEoFrTQYLlNq6VqX7Xfkv918Uc
   HzubdQN9IRh2aDyHzPjzrBw/27SCf2gW2BgVZNSmnqfUNxZj2U7al67ka
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16528261"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="16528261"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 09:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="45185519"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2024 09:27:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 09:27:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 09:27:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 09:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/B85G+CpUpej8cIPZmp07SfuAzny3f4KZmH/4FJhnkUdIH8hN0UqPmzV5jwQnFvY+jXvyuejMF4hgtfuJJd8oPPP1fr7ojbBXOb4T9A7tdCrdQTVidmxdWOOF9/OJCkY0WNJ2FjTkKRo3/pCmT3hEeH3o71MbKAYLMsks39GG6wzAQpwiRB9NItPQYKXn0rXZ/33U0suV+QW0wsqjHTrgiaYAwN0F3Tu10+Z4Td4/rb3+UbdR5QZjmMhDv7KAyrnUFOlTDukeiarItE5IGhSQjnYh2HVQo4OBcOKs0xEe8FAvxH7oEU1DCwhESCJGd52r93osZsoudBwDO401EwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM4lFCIQuo6g9sxtdaGh0IpSL34Fqv7a3pOiGxX7ELo=;
 b=TzrI0/anenObfvwQJDC4LISykm6OpWyixJzb0VB7jXWBjvPltKJ5ZHui3pkp99QL23y/13f7JtRKijImZLTMLPlXWiJ9SYuDWXgHEHlTrr6DYV2DBZxX6n9rwt1at0RAn0seUC7/55W2k/K9SNccFuAFNGGoniVBcP1Jv3WjsUogmgovmijpojYDBvUcC1ZGLHDpyO6/ep6eacdpDCrmfMpPxG5hDJLTz/KT1tmEpE3NylJECnLaHtUM24hQ/Vcxlp4AAZo0EeLsuiKFnVZpMPSIaH+JR6xAaGaw9ZB3ukiLOKaioQvjbQGSXf68l2n0/zbERHBPFaNDYlyMhu94Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB7570.namprd11.prod.outlook.com (2603:10b6:510:27a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Wed, 20 Mar
 2024 16:27:39 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 16:27:39 +0000
Date: Wed, 20 Mar 2024 17:27:24 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Babu Moger <babu.moger@amd.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <uk4k6ayim6yfcquwl7wwc6mrfta23suefid2t7pxldlsm7zs2f@4yw6hm2m4z6p>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <8ee6f553-16c0-4097-b5d8-af1598d1b85a@intel.com>
 <5vnrboxpkrriiqcbwrxtbextu6pduqjfchlvsdn5nwe7lr7vou@dngffvu7a5fh>
 <7656a3fe-56d2-4a9f-9dfd-6f2666f38110@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7656a3fe-56d2-4a9f-9dfd-6f2666f38110@intel.com>
X-ClientProxiedBy: MI1P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::11) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: be0b40f4-692d-4c54-4c23-08dc48faa901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j0w5d2ipkwkXyTCEC2d47decupuisCM3Wj1KEaDQAZ6Cv7IGxB2ZI6yQgdFKqJcSe3Thc7a+dGvHMRh/VlSaKKZgqwMT8DJ4EtdDfXfDZblVe8nOPSL3eJF87YwbuTnsQ1ZTIf8XRzrnD3RRtvpp6plGR16CKpfa/wmURwNVWZh5XMwkyJz9vMpakUGhMU/oHIbexvuozmNH++6jD0+j+ZcwMZn3smeSVlHOsYuBDEURGioHwagH2QgWDSlbX2m15mboU/NLqDvJ8iJm7cLUgfR+YIchcsemBXsOeH7aAdpS8DV8/38bmOO72g0/gL45wiLzlkR4baPkJvupzKxzfd5melaRGytf9oU79qCAzyVRIXBg4A1OG/fTRAElRhXnWX6lrykE83UcggX86WtN1YxQg9A+ninbhey296IU3QVZs7sXLLqogXXfNAtAbJcmnTTtFcCh44GhqVUsZkO9aXCe4gvWPwntIPZifRnglXsWkUw0Kua5vaJ0F1uKhiITGi0h8S4dIdQjOutaLsqKKEi2nt4ZoS41GxOUyNJiUJAJttdT2V6qhqHYs23mYI5tSivr3buxb7f6XeKm++zHnwjl6Ev82YbCVnmdA5P3Xd7e09i9rsfkb4TUgFO7Bm+c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MHfLslfJGds7LeCQtBpEhv/XUNKDjUwd0Nqinph0/5PoxyrJmDrPVtQhkt?=
 =?iso-8859-1?Q?ix56hRxIVs2R7h0etSJ39MqnjY+a4PUxWsDXHwM4T2Gge9GzNZ4Fm9rz63?=
 =?iso-8859-1?Q?UEqlzeLeS9S94gldi0gINC9WhP8b3GE2Ood1N2Z4QUMXHYPhWdh0pDu9yS?=
 =?iso-8859-1?Q?QL03mpDkfajyDES8xG2IC5cfCFxkwUPBV38cHQV2sxl55tKixu3GbNl5zf?=
 =?iso-8859-1?Q?ImfDHhqetXNqHJC7ICkT71bBuX6woWwnfU8JlZ0jyDRmGCKkynYuyPF3OC?=
 =?iso-8859-1?Q?79TyOSleyoirzenI5EBlTwyNHrC3xHB5mD8+Jb/N6AgC7Le7TGM/u/58lZ?=
 =?iso-8859-1?Q?3Z4Xa6X0C4Zk8Gqi5M9GM65IY9jMY4139poGr7KX1CLdI4Zshn10LLOakj?=
 =?iso-8859-1?Q?cX7VauWTgX4hQ2UZ+pRF34vvpKTXiUu23MZ8oQKpr1ep/NYIBwFV2TzSWV?=
 =?iso-8859-1?Q?WtmJBardWcKRUhwyT3maWG/sm/cNRUPFUTjyUfWek0+md4zaeKxfVkOTQ8?=
 =?iso-8859-1?Q?2D/YXc9dLs9N7S25B+RZ8Wq/7xtiZ4nHAoFq8oTLe9rvKcB7laxZTvvJcq?=
 =?iso-8859-1?Q?+1Isl6hG1Gpjw1wkMnu4iPD4tFkFsB/hc8YFOC0XFpeNPo+bVhGSjn+QEt?=
 =?iso-8859-1?Q?k/hW1ySbnX7ALOaDb4LsL9UERy3VypNkcwrrajF9nAdISkPG6KDVerLSzy?=
 =?iso-8859-1?Q?XNDwIBD2YJDIuOh6oWLVA4Iad0zqs37Kyzk6EEouP3RYBTaceJK9RPG9Qf?=
 =?iso-8859-1?Q?xdXPm5asakccuWhsapwD0p71BRlrf7j4NF14c+OKz4AGFjNvDwK5YIBd/I?=
 =?iso-8859-1?Q?HWfe6FKXM4RruUmC331i0ZFzNUZQ6bApqY42A0rRt/g4iWtIJkExq88VpK?=
 =?iso-8859-1?Q?SHWNfvIoLiTWujXuwWAiuC67SWDjhcySlpzZUYBwAcqXRRj7sUfetiGy5y?=
 =?iso-8859-1?Q?4z+Iy6yR1MDy7k5uMR7rVcxnafrUnoVxT/QomSvMQ4EWiO/qTruLXhr2cE?=
 =?iso-8859-1?Q?wYu2Ac53WKN6W8BXsuFcKFlj7N1SAmB7lTVtN4Pq/EtpxJaDvh+6zAZuKK?=
 =?iso-8859-1?Q?R/6rYZZaXCCm9/+bLPIpt1SYbcDUSIIRq93y16kb0ABwXc52t3Vd1bSY15?=
 =?iso-8859-1?Q?Vyr11IDjDhNvGc7WO8ylvlAbQmTTFRklEBgrrev2GG7zHt8jBdv51hpP3+?=
 =?iso-8859-1?Q?TO4rEo9WWix5zDDd/xKgHyBly/sS+XqYTUdjucBYdNdqhmZL2K43ZJtByt?=
 =?iso-8859-1?Q?FwxqX8FrW/GSYPAKgbUllOk6K9mg0vDIl9mPO0IS4oeyY19hTHo8qWUnkt?=
 =?iso-8859-1?Q?yfeaP++Noz4XrRSv4d6i05gEkjVKDHvriLCN6rPQnYSz7dMquGntwdzN2j?=
 =?iso-8859-1?Q?XxCUuhiqtdGIGOfGaSEkAHB1oGefqRy43v10/tPQKhIKOq2MZtHBhrqEsg?=
 =?iso-8859-1?Q?v2bgRIln67/up73Suq8d4+bq8vne4NsBnXMi7nVFUGkDrwe98wCRG+n0VA?=
 =?iso-8859-1?Q?VTwQuawExR3DCbnBbokDiintk03sQ+V3O5SMYqetHB1T22MqiP4oCMw0Cm?=
 =?iso-8859-1?Q?mgcOOYt/0IemRiwtgbvBPeEuM1Cs0ph3/z1PYz9mJ39niuOceUVzL7Yv2o?=
 =?iso-8859-1?Q?shNO0WG94Mv9w7HMNgv5PijoCs8/wB5eWDSOERTUODb6ga3bIuus66HQnt?=
 =?iso-8859-1?Q?dY0qrSJsaOFIyBaTBiU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be0b40f4-692d-4c54-4c23-08dc48faa901
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 16:27:39.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+drX+V9rhDM5B//jjAHlhJB18Ob11xV3vEl/2aPfyTVYGRkwKeffWBs4c+djaT7gA/JpxYB+x76Pu7dPIqxbtibS3tKh6kS/iUQlU9xtEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7570
X-OriginatorOrg: intel.com

On 2024-03-20 at 08:50:51 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 3/20/2024 8:21 AM, Maciej Wieczor-Retman wrote:
>> Hi Reinette,
>> 
>> On 2024-03-19 at 10:51:14 -0700, Reinette Chatre wrote:
>>> What remains is the user interface that continues to gather opinions [3]. These new
>>> discussions were prompted by user space needing a way to determine if resctrl supports
>>> SNC. This started by using the "size" file but thinking about it more user space could
>>> also look at whether the number of L3 control domains are different from the number
>>> of L3 monitoring domains? I am adding Maciej for his opinion (please also include him
>>> in future versions of this series). 
>> 
>> By this do you mean comparing the contents of main "schemata" file with the
>> number of mon_L3_* files?
>
>(assuming you mean mon_L3_* directories)
>
>Yes, the "schemata" file can be used. There is also the "bit_usage" file in
>the info directory that indicates how many control domains there are.

I just did a test on my IceLake server that has SNC enabled and you're right.
This can indicate kernel support for SNC. It also seems more reliable in
determining the ratio of nodes per socket (since the ratio of cpus per
cache/node can potentially fail with offline cpus).

>Do you think doing so also falls into the "not obvious text parsing and size
>comparison" category?

Ideally [1] seems just the most user friendly in my opinion. Comparing schemata
with mon_L3_* directories feels like a good next solution though.

>>> Apart from the user space requirement to know if SNC is supported by resctrl there
>>> is also the interface with which user space obtains the monitoring data.
>>> James highlighted [1] that the interface used in this series uses existing files to
>>> represent different content, and can thus be considered as "broken". It is not obvious
>>> to me how to "fix" this. Should we continue to explore interfaces like [2] that
>>> attempts to add SNC support into resctrl or should the message continue to be
>>> that SNC "plays havoc with the RDT monitoring features" and users wanting to use
>>> SNC and RDT at the same time are expected to adapt to the peculiar interface ...
>>> or is the preference that after this series "SNC and RDT are compatible" and
>>> thus presented with an intuitive interface?
>> 
>> I kind of liked this idea [1]. Hiding SNC related information behind some not
>> obvious text parsing and size comparisons might eliminate any ease of use for
>> userspace applications. But I agree with you [2] that it's hard to predict the
>> future for this interface and any potential problems with setting up this
>> file structure.
>
>Thanks to you for trying this out from user space side and highlighting the
>difficulty trying to do so.

I suppose it wasn't that difficult in execution but it required a lot of
thinking about what is a reliable way for checking kernel support, what can fail
in checking the ratio of nodes to sockets etc. Maybe once we have this figured
out all it will take is a good documentation and userspace applications won't
have a hard time with SNC.

>
>Reinette
>

[1] https://lore.kernel.org/all/SJ1PR11MB608309F47C00F964E16205D6FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com/
[2] https://lore.kernel.org/all/7f15a700-f23a-48f9-b335-13ea1735ad84@intel.com/

-- 
Kind regards
Maciej Wieczór-Retman

