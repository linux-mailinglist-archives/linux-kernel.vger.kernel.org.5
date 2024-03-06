Return-Path: <linux-kernel+bounces-93423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91098872F88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829771C21886
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C35C60E;
	Wed,  6 Mar 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kzl3is/u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9245C5EB;
	Wed,  6 Mar 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709810; cv=fail; b=uf/V77qpumTAcBuToEysFPIMLTZZivolgqeRq3q4sqvdz1BPw8JUvtanpZVIfe8skOwqS0jQWFmEeN3O7NM6Rk9Ml5aC+XXnqHwSG0IwblPYufv2tH2Lvt9Dya9lLWf8+OZV8Vcc+ql+Yrtge/UGenVXhE6YzmGXQFy2viwOv1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709810; c=relaxed/simple;
	bh=uZ60qQz2YJlWM3Yz1HVdHUjBG28E/V5PeB1a8JlnQLM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GEfImIxv4WDGwJ9yoBC3sbicWo9k6uhFM97FMB8aLV2zDQh0/wg8WHhPSUB5dQpUUc4WQJeQlZW9GLBr5HPic/ImEq9zDmiMLt5kbUH1p8t5Ps7Fr6ZryG6eXPvVVJ9eUuZT+XMhI+GokQatwZGMQdoi2hUbFpnMX5I458RMl5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kzl3is/u; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709709809; x=1741245809;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=uZ60qQz2YJlWM3Yz1HVdHUjBG28E/V5PeB1a8JlnQLM=;
  b=Kzl3is/ufovqHodzTEQiljBkyGrHAPL0XeBPEWJweA3ZPG6dqQGdJ9oo
   wyM0c524BlqxHyISZntzQrS/zQkC1yrn6LP0DX+kqZnWXz6waEChRa8RM
   AjpINA/v4kOWpe3rAasnv6erEB1jRYWkDdvn8ModD/eYT7KkM7dlwK5Ye
   qLViV+NDCrJE69eVsxYtB5eK3S+yGxN81VFjG4VOMihShfIGyLp9bY52D
   hjSKLRV+xccpgpv3Llf+EIpIujWplg+A7HPna2XK50qP9NpWmnfAet4ao
   LQQ+ZINhNcR/t0c1mDl0tjNyQ2FEXcwAejw3e+L4rSnhuY69o0oe1xj1w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="15716633"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="15716633"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 23:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14219384"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 23:23:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:23:27 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 23:23:26 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 23:23:26 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 23:23:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azapQ22zLAJ3DRcM4qElLd2D/lMDuxRxxdttoceuYSUDxrGM0RdBD3CM2SE0NXXZdW3cPUfU4cdl4nfioWD1JvFmBvTB+ZLXV9rsGIe+8dVIwVgSjSEx92Hb0E2g4tLxBcY/IosQukPtcJ+mGAH9M+30OvXvpQXNri/sUAtrrSN3FiTNAtKbTufFPBdeMbNfRf/b4SGlGt+4t0tpkxmlEe+ZEWlbWV1cxGkIfq8ka8E9bIjywo4TUiWDYJ5IaYLG2Z58/6MF8VZFQYVcgeMB6RzgYMK0YDJdzq9SQU4DUAp8tf9AJzJj6oyot4rlfir/FWvWYZA0TiTHjJIN5GZZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMbft9B7XnakmyrcesWnDgSG7eJd/axuekA4By3WH5E=;
 b=FE5nLAS7Bo4YJDITN29Lx4kH9DHjao4mFlK3sU8SOR4S0Lys+9SJ8SsGllRwlzlFlOlOSIDxPpdyLGz1ziv5ZPlGolMOgTlRBmjQERC+McB2gPz8pC7E/IEPVhVd13qWE5B7DezYGahJm6SXsYn4bmSWjAlwsjs69MRMDxot6jJjzJNDvjWKdnYPZbq41gU4K0wf5XN1q8poouKRhVKe0siZvM4u75rW6fqMd1TbHx1OiLs2R7YAdx6+oEfrV0W8PtPoXA+Gxgzs8C0vAViX2oQZG23/17owoZi1NNHW5wPB9Uom8IiCdoSQUokXRwXCZvdNAcrbiSucU3cZoHs3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Wed, 6 Mar
 2024 07:23:25 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6440:4b82:c32c:9eb7%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 07:23:25 +0000
Date: Wed, 6 Mar 2024 08:22:51 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Luck, Tony" <tony.luck@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, "Babu
 Moger" <babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, "Drew
 Fustini" <dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: Cover-cover letter for two resctrl patch sets
Message-ID: <etisznuzysepwoqe5wi5jworgnska2imdg6tmwqpddcrxzhkam@44k6y26rirqs>
References: <20240228112215.8044-tony.luck@intel.com>
 <zhfckkyc7yr57kdcru3x4d2btuqq5dp3x5qdv26agfq2tlai4d@ice7se7vfctp>
 <SJ1PR11MB60835E98D52C2A0A90C2BFB1FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB60835E98D52C2A0A90C2BFB1FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e63e41-e14c-48fb-25c1-08dc3dae4f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fr3Vg5pWRwO7qUZe34yRrew5AKU6jeyVcxFSh6aNajBX20RDg2ToiLYrgudmbMqpsegZ0S/Oc75C2eTgg8dsUgJ7aSBc7XRsnwCg2wU23pkcpyylpEBiyq0QNWp1lIQeX4r9CDjh41XxQT7wdJK1AraLy3b5pFjxXqqoceM2jUwIwllsl8atAmcnimY5hPxtVlbSadEHhOUYG1TlN+EXxtl7TeKyQycXWXmTniUj9T6bmT9pUlP/92Y406PchvVqy2/LCadxlxHma0CjkAGT4s5CPIZgyr22McbQ4puHFlLCgWbIwF/TIsZb0w2BtMhoxWi/NlAlcUekz93U+rXIdGBkANA2U1mWTPLCQAEB2Sm7yhsk00+dy70UGS1hJ3qv+limlpMyL24wrAy/AtesnCkK1p+LwWDGHq4fwk1WiqLu4aFqGN9VE2vmBwFPPQ6rYvNYcTLHRR/W06jq+2n1YaRkv7F2cHW3IhBB9+uffZCg9ejJUzWnTBOeku4cGEVRgeji/tsbl3S+znaf4KQrL8ZPZJslm7Uq8J7YOCMHgJ1QIWvubHRrxhXK+HbN5KklgRR1FQz3m+jEVQKqu3F6KfPQlD4LcaIceMrfD7pdgxzvmZt4WGWUyyLCP7s9qXotHyuXjlZROPkOkbKOorKLYAcz9dSUPsQDOvj+/S+AjA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0S5k8Kd8tgMHR0ZgsLXR4y+YNwEKpjBnfpncxhiYGukNWxjqsY5ZesK93w?=
 =?iso-8859-1?Q?ZuDWESe5iTKAWqBoNhb96JNFY4GxGEb3rsEwIOQz9sfJBBcMlGmmme0Is7?=
 =?iso-8859-1?Q?KWawSpNX0NK0eiI7LWaSg0S/TBDcdOrEpO4P1OCJcKb891vGqxixIZXUy4?=
 =?iso-8859-1?Q?B4YMVlIR94BQ5O7qs2VT4VsvXK4tmjwI2x6G5jrVQpEM2st+StAbeBVtWe?=
 =?iso-8859-1?Q?ZRLwhRs35F7Ua1yEH5YJt9ZzfoClZ/usFwHvcij7uWVIZYBpsyydjQuk94?=
 =?iso-8859-1?Q?ou7pLPpfeUEB7P54D4yQukPZ9aMC2ETC8bS3St87y4RKzbk7548gPNdfWt?=
 =?iso-8859-1?Q?crnfZO9V1kU5GVERx0NmviZO0vW6hzxI6yQp+9f9eoucTYxzlhfqwJWj5W?=
 =?iso-8859-1?Q?2eHiDamWoz/q1ld7UXCzaGbj4aE0FPtAgssW6iKYQNCKpaiiZR3rzHfKXO?=
 =?iso-8859-1?Q?0QuNZ80VkSCoBjuKxl5/nEfCCyPxT+3dUC/3cy5fLde4rI+joHwm9OQGjJ?=
 =?iso-8859-1?Q?eCVdrummOFZO8eSH6/hWahlvKBy3W5fOF/eFsyQTIBmznvgWvIute4d3Wj?=
 =?iso-8859-1?Q?s8nkpx90JuRoF9hYyGeLyYom93DSzxBSQFm3//NKXd/PqxQrFJFi7EVmsg?=
 =?iso-8859-1?Q?ct4dVkzplBvO5+NnVG50hlrrwy6Ym9WADTI27iHF3ytoATxufEpB4Nwzmf?=
 =?iso-8859-1?Q?Z7Qi+M9lojCn3aifaM2NtGPhVWv8XPA4wDGifxHzXGo9/6ji+WyST314c7?=
 =?iso-8859-1?Q?S5yBJdVp6ZLqwBIBvuKqpDvmy5JbV2/0bfEA81hSiJ73XgoSgZcDQSndku?=
 =?iso-8859-1?Q?z54xo23YBkTg8c5T4nH5W2aQoEPiBSVqy7BZJ4gNu8JytgidAQCwex16at?=
 =?iso-8859-1?Q?xV2Q0SKOYqWlT8lDhjZSqfXO2eeNCjpGHH6k1AaMD2I5Dy7It0ifX+JeeS?=
 =?iso-8859-1?Q?3EVIbLaoRAdgGTTvfDmlioMfJdeurLqyX1N+qSi3tju99F51zN07BqyZFM?=
 =?iso-8859-1?Q?CcK/G2dekrhUupmf84CrrJAJYspRV2udY5bJN6M7aqEWKWhoRCtj0MXJDy?=
 =?iso-8859-1?Q?lI+bLKIYroP24c3nycy6E3wDdX8+pbOuoQWb2AWwD5k77imbb16KIRQVxZ?=
 =?iso-8859-1?Q?QZa81MIbV3jfIaU4Bg9rLOOtCIYrriCX3xvM4mFwEdNFhuoBwItc61s4NC?=
 =?iso-8859-1?Q?FPx5zbe6ZgBWj/joyhI/L67edhHeV+20opIQsNK2oLW345ra5DeK0Jyo4Q?=
 =?iso-8859-1?Q?FWeCB0mfDyL7Nz+4gLFxz1eBDvxMtj+PkSz+Sqj3MnFGHOeeLXsFBqdl53?=
 =?iso-8859-1?Q?2KQSHQZEzUdl0bzEJonxOId5pcM7rC6KcqB7fBrajKGaZ3HrpffcgWxras?=
 =?iso-8859-1?Q?CXjgYjFkjjlqw9KHJE2GAR1kfrus8qj6XNsYBaJT/LOYBEU8C6CLyorNan?=
 =?iso-8859-1?Q?P9uVIyS74DOsZgGkfZlYoZSn1SCfcswMNytwVh1pZXPb80ZOj2McVV6zCn?=
 =?iso-8859-1?Q?7lywQ6HIoKuIWik8sMy3hVa3tUJMoknqvLt6aX7GbyRO7Dcc1nE+VYjWmo?=
 =?iso-8859-1?Q?jGhNC8X3JPyKI78FOewhSbFhvEzgzzhS0zxtG63iOLGPE3I5SJJzv8QuiI?=
 =?iso-8859-1?Q?2ScfsleT1sf4qJ9vLGbPXNgOe1vkeSjkq75tPKiB4Kh1YXFMQXKYEni8uM?=
 =?iso-8859-1?Q?eW0cJfCfhMb6OCwsCjE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e63e41-e14c-48fb-25c1-08dc3dae4f7b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 07:23:24.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APlsz0gC8MqmRGWugCDwO2wiBoG8c4c6+e3EhpXONe8wBPFEALUAc9YXTwIA1IIQjm9Yo60PypAjuCqiG7j4rdLkiW/vavaSSp5p2d3uN2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On 2024-03-05 at 18:51:55 +0100, Luck, Tony wrote:
>> Hi, I wanted to ask a mailing technical question.
>>
>> My mailing setup with b4 is capable of downloading series by their message id.
>> With these two series tied together it for some reason doesn't want to download
>> the smaller series (even when I pass the smaller series ID it ignores it and
>> fetches the SNC one).
>>
>> Do you have some trick or method to download a series with this type of
>> formatting easier than manually saving emails?
>
>The cover-cover letter seemed like a neat idea, but since it is breaking other
>tools and workflows I'm not going to do that again.

I just made my setup with the assumption that the cover letter is the root of
the thread but that's easy to correct for cases such as this. And this
cover-cover letter is easy to browse on the lore page.

>
>I tried asking b4 to specifically pick up version 4:
>
>$ b4 am -v4 20240228112952.8090-tony.luck@intel.com

Thanks, this worked! I don't know why it didn't before.

>
>which worked for me (though it did apply Reinette's conditional
>"Reviewed-by" tag without the suggested change).
>
>-Tony

-- 
Kind regards
Maciej Wieczór-Retman

