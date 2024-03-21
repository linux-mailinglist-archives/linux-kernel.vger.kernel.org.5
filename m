Return-Path: <linux-kernel+bounces-110424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14A885EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9D21F22F73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921813A276;
	Thu, 21 Mar 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7Wx0OWS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860213A256;
	Thu, 21 Mar 2024 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039917; cv=fail; b=ZeqyKM2CbzaZTWhaNdz40hRa6Mw3uX+7N1aoiQuKSEM8xhuYxsKvjzciEX3kADDSgWUEgd2s9vF0SY/fN4Qu9J+t0i4DypDqUana2lhhDzjhUUhAArja/f1Tz6paPZckDm0D1gKi/8VyHQ21t3JcG8nTt0QodG0qq7I2tHkk2zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039917; c=relaxed/simple;
	bh=JkYQkDFyo3+XwZwUUmSSzUVMVbwMXnii5X2RHA8o1KA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTUpjc+GTMzg09u6vtIX4blNpZ6f435/hWwtKlM9WpGXL+/Lg+6/jv7+9ceB5FDdWpCBU06xv9V3FtynjZyyQh6gzx057cjnkTZJ7P+gohEx4v6Dou13TWZzZK5B0m2zJrXvAfmcwtgQVoyJIVdm49Uk7ZTkZ4PCKNofR7xqmu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7Wx0OWS; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711039915; x=1742575915;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JkYQkDFyo3+XwZwUUmSSzUVMVbwMXnii5X2RHA8o1KA=;
  b=N7Wx0OWSRUXpELaGaxVwN7cEUZ0Vb1kAUmwg/Nh4YIgO85E/fyXuj5MU
   KskQjWBx1s1ousgdirc7aypZ1lK9qMuxiAaQrEgLfw92IQrT/UQiO0W0c
   bfKsGn9hftCJcHtDo7I1GcqRLRBZiRz0t6BlPOJ0t8RT0Ga6lX3YOy51G
   wexXQXSQvFUS86EGjYGxO2hrfixL3w8FlrdrWPJcqNeK9Zc8PTHcPgIh+
   1RKau3N17yg2yowksY/e95zs9iQbQRbWsCksSXCyGQui/1Raa9BfFu+h4
   0oT3tUWo7YZAkgzzeFdtPNrm+9aRhAZJ645UPLT/gKEFGO2i4LJOpVDUm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6165547"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="6165547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 09:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="45574059"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 09:51:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 09:51:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 09:51:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 09:51:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 09:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKtFsNL3PaHD4yqPqBHn9xWzTfGlKlN1NnU9ihnp8sksI5kbIbfJvUzP5jE1cl94V8l6sGLOc1H7ueZW23HKuNj+pBMCiVEklAR0zEXu+CkMj553dXqZh2g19iR2Q5b/JcLtkQV7JZUrIpdRyIt45iGH9Eb/fUdZx0hS9cFC5FCqQoEFH7nc8SDtx+3t8CiTbNVEtlOZTYDDNvKFFdRLP1VNZX0VBQZ9hJr5e4RfbxJDmu2gvWTxV2QbtV34OOJiMeocwdQD0m2LSJyeFIyd6H/d9y8N1oTT6huhMgUaJU1CT6NepGZL2a82TgHYlBT57Wh9BTpowC4vceqaSfXEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkYQkDFyo3+XwZwUUmSSzUVMVbwMXnii5X2RHA8o1KA=;
 b=jXIjBROC7K/e3C6M5OzujudqCS/CvGU5BViTOFzojDXHCjI6Nd/mCa6NizLsxQoFHYW1kZw6Cgr4HZXBkayM976KKamdU7gvZnfoenxsOd8WM61KJOYDb6JkLjolqm03QcrKtRTbof29WofDW/vAYwWnYo1Eu0hjsbojT1fAoezYqxlxhe2fHW3EDJ/zOarmCOHhuIi0trGx+IRdCKJBSeGWjXmSFsVLVUyhaDtAz8PhHe2mdse1/cErUkdH+65shhQINIfNJBKr5+757PVgWkrkODJi5yOcnq6xl4rNNbVHp5lZ4khYnHeBKnu79sdmQVOrWWGKEf3e01niMq/vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB4844.namprd11.prod.outlook.com (2603:10b6:806:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 16:51:51 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 16:51:51 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
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
Subject: RE: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Thread-Topic: [PATCH v16 0/9] Add support for Sub-NUMA cluster (SNC) systems
Thread-Index: AQHadMZAfvOnE4EV7EqwgV4w9PIDb7FB36oAgACVVRA=
Date: Thu, 21 Mar 2024 16:51:51 +0000
Message-ID: <SJ1PR11MB6083C9DD405BF4CB986822F5FC322@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240312214247.91772-1-tony.luck@intel.com>
 <bn4wtfyec4mfoztcr35rctgcbibypjh5gmxdr3fro72glh2y3n@vmqsuxgjlonw>
In-Reply-To: <bn4wtfyec4mfoztcr35rctgcbibypjh5gmxdr3fro72glh2y3n@vmqsuxgjlonw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB4844:EE_
x-ms-office365-filtering-correlation-id: ff5878e6-d45b-4757-acfd-08dc49c734d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5w8UbaritdIDbBUVex/CV2O1/91LJxE29kD3B9Bv7pBFg6xSfMEb3rfxVYISNnAEJMQ4N9vB5PA9ChhOBTeMq51IilDmcOktiHavOr3tSMpTLMKnCO7Yt7b5zODP7wQv/Td8NLXkEIYdpM3eu+H8bDHU+nyvFVFii51gqiRV6u/Vz6yc4sr3klYVr2x+PzLYCdvzy9eJYnR5YXzHlWsTEFR7fwc6qO7aozUPxo1UK70HRHWZJztXJ8kubnzfWBaFwUvs1MM2BucNI8DbJqEXKkz2ru9saLtfUxQPtmWnDHXfQOkE/2UYIXBjJUcITh+5zKCwUgKLfIUkNVvmFbTEC211svq78uUaZwVOepu52S7zBsVvFyIQS7tYh6YfctP0vkYpP3ud1epxPwxTdhWKOrZN3ts6dwpoP1CUsbTVIVv/hdiA5pWzhj4F7tSgdlbY8DrH1WvpmF4ImzUzqmu5/s+SI29Dg1eLau4zAuBt1mYCt7YUY8eswv2tczdfBBuc7O+TFnAZEvyfIj8E1qpWFtTcZZJvHu7kr8YL90bglZlXOTK4jJ5yivtowQ7n02i+YitEOuDtL2Shger1G2T/4HEK8TW29uLeWCrqkIcRTlKbuzv/5CWIofqRpVqcWV4aMLmVKckzuUyA/hx7V41aH+lDhrRF5wYqHr7skr3ByzJnD+YeTsXiaCJ2POSUEusnfhJNcbr4QwPLjRg8stXgdSqUi8bujb2ky3CQZpb07Po=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ImQHT0AGYmlFtNDvwqZlLxYZdC+Fgu1A7z07d4nfXGjTwFpBDym/0R75qzHI?=
 =?us-ascii?Q?fpbJaf4VWqtmucHmt9b6o6mZHCqb5tWUhF/Tvo133UPIxp7KhSuZYviqPP9G?=
 =?us-ascii?Q?yHv42YpMybVwP/5BzQMtOIJ1bHN2NaKE3EYmIFqNHZpa+yip5oB74gLYsDcL?=
 =?us-ascii?Q?dm4ZNCVwLAeIZcxM+exL3xg7MVYf7FWP0Tkivo9cu9vYr9EyEIeoyy65r18M?=
 =?us-ascii?Q?kcC0zvmrIdNoWnfLMbdmQYIbjCO6/tJeNZrET1t81pAqlGif7yyuRTqKMMfo?=
 =?us-ascii?Q?T3AY5TOQbPvTsR0Wk3Zp/WD1CUHNxoIiehIfLpwSdz3hgiBVxCapG4F06zn9?=
 =?us-ascii?Q?0QoDY6QvNru2hA00020sonmwtn04QEdLp6AFHfeOx/OblcwqbVMMilqBTNxO?=
 =?us-ascii?Q?IyPzXlJf37evgzByd3JVhI5yJ6P4ZOiYwHQMU6CViUbNM84zLuyiCAn2a2Ks?=
 =?us-ascii?Q?hEFuM9VQLjhvEs6sJCu2FuRrb5JOCArWsvoFRLFmGCdTAQxSrCwDx+lT8tF7?=
 =?us-ascii?Q?DV4+H4W9VlhOJdzJsuIXIqd6kHzP7cpKB8mDGb5/8XUipZNyVT0tBbS6CP3Z?=
 =?us-ascii?Q?9X0M5eLphgC9y0/1mpU12du5DqDDbG/frWVjHO45+Bi5x9okaG16UHsOSPJK?=
 =?us-ascii?Q?wq2Y1KDKha1YsdnMP4Wg9SlT0+KHKdU+hujINyXEuNcvFMLLfszFfIRBuS69?=
 =?us-ascii?Q?QHdpE+qkaVbcmN3ASQINJRMTaTHthHIe+2iMVYzUug07114TvqP7Pw7RHp3B?=
 =?us-ascii?Q?ygIhqXtLGNwTKyTAZG5l1noHsPIC3M+wbSx1KCxaD16XS6h6k1PXiD9AKBaP?=
 =?us-ascii?Q?54meGI4QmfCK6tHpeKDqlZKEBHjS0xYs39Xh6mVSt6n0NLBzUY4ezIRyUSzL?=
 =?us-ascii?Q?1ygZ+uqnUO8WBGPFi+yTyHSFIMpWw1crMODcBi2/G0MJfgGw+Bt02F4JcgSK?=
 =?us-ascii?Q?WH8oJb/DGgA/8yAzg/RYJyxCCr+pxWilXRAnplMYQAHIhm/SQPJYpPFhPumx?=
 =?us-ascii?Q?lgguxcaiIb5LPDn8Q3Hrb8XMCEGuDJA8kpP1jprV8ajrfEOBfAsgw/UjBNNe?=
 =?us-ascii?Q?snscMy8fWeFXSTdwcFhPv8XAuY0NzxtPsx148rnh7UHtOelcbu7LqAxu7STj?=
 =?us-ascii?Q?/NMHSJYKWq0LKaQHO4OChinLEd5vcJOM2rPQtPx3m7e7Q8f8UU7kfrrJ/g9k?=
 =?us-ascii?Q?r1xub2z6HMo25JI+WIHsKZlPp+SN9dVEOv6syiuCQEJE56I2uu5zNKonagos?=
 =?us-ascii?Q?gqGiNteJCBTo6yh9OVX2S1I36gFt2gFP2YTHSjQBHI6YcAZk66Mov75wtJs3?=
 =?us-ascii?Q?I/nMQudYc33Hg4SOFuXsWlnLWWuXqw2sldc4n2fdeDJPM09QLLfWSCw4xCMG?=
 =?us-ascii?Q?JVDwtQUj9tKO/dWAtljzWrp2tMNRngewQ4BfB3Lnu/WWZJbj+bkXq6WEoxRH?=
 =?us-ascii?Q?KsZQj3+iSe8agS3G8lblhRCYXxLMvYu1tX/YXTDKG7X1lRNJj8rHaWUxwg22?=
 =?us-ascii?Q?5N4Zt/ayh4eBSoQCToVYwCSKTAictgeLsz490uFf5c4VQ1CWSncNP6DQ3EIl?=
 =?us-ascii?Q?lveEu7nr5uKbydzWtD57G6qnxoW8Drev2RMpZqn4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5878e6-d45b-4757-acfd-08dc49c734d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 16:51:51.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erxjw712SdqkjMnYVNuJHypd+MEaulmPqYLAUQs0ZC9n3SvabjJE11QYN0TUhzMp+WwuMq2CNHO0/jkuiLBdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4844
X-OriginatorOrg: intel.com

> I wanted to find what causes the conflict so I can give more details but =
three
> way merging doesn't seem to work and git am doesn't leave any conflict ma=
rkers,
> just fails.

Maybe there's something else touching resctrl in either TIP or now in upstr=
eam?

In my local tree I built on upstream after Linus pulled TIP x86/cache (and =
a bunch
or other stuff). So my base commit is:

b29f377119f6 Merge tag 'x86-boot-2024-03-12' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tip/ti

Then the two patch cleanup:

b0eebe2ee45d x86/resctrl: Simplify call convention for MSR update functions
edf14f3a6093 x86/resctrl: Pass domain to target CPU

Then this v16 SNC series.

Reinette pointed out a couple of things to fix in v16, I'll handle those an=
d post
v17 next week (based on Linus v6.9-rc1). I'll fix up any additional merge i=
ssues
while rebasing.

-Tony

