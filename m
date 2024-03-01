Return-Path: <linux-kernel+bounces-88155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9386DDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D083289838
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42E6BB49;
	Fri,  1 Mar 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g10ZSAIN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC06A358
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284490; cv=fail; b=rGFGtB3uLTSrQxPi4gGnGOe5eiZWIMTnxuS5goi5GpYAKlXJWkH9r0Whi5NqOh/jNgJG227SsfxivWQ8eh8lqe60/dlOe0xJ/7MwMneV+hWkKUQdEPxNkZMNl8298vks+4DC4fWxvGM1VZG9pC5L9MZV3zS2MQ8wYOuyqk0Q9cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284490; c=relaxed/simple;
	bh=7N+YOnZFR0cdwmGUtQ8qffvQrxSASVQEYmJTzMPhi5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cVlg5B/Ap0cS9hhGWszj4Wlp4S1sTPnLK8mRgxt9J8nAlM4nszdti830bOp/nnLz76aMX4pu9l6dbNJ5iau95h/7C5pdvZP+ROyMiak7DJzSsuEtc3bqPQqW9Z/3/B6hFR1YIzQFjhbLKtMZU+KOvPeZnCWS+ahE4bky3ZG5mNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g10ZSAIN; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709284488; x=1740820488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7N+YOnZFR0cdwmGUtQ8qffvQrxSASVQEYmJTzMPhi5c=;
  b=g10ZSAINXzdEmUrss9ruigmkp8MUXzIHJLxbdIye9jDMl1ri9Tm4W0h6
   tjsXHgwiW+7C+Q2n9u4NFTsXktXzr+n2NwBRSF99cnrdFpsvQaVNzCtAx
   rAYWHcVgbcG5o4QUU0l1Xca1J9IWDd+ZT7dYnfyLeQMRFV2jl0OzcU35V
   N+ZqQ/M/qHRrDuTn3etmQquugx/mTXYKfreneVIupzSyXqfUkGRQweLyN
   biVZfK8VJDbv7Hiu7WAiH/DHpLSvujDmgV3mbjP+tqQAM8uJQ+QSsiymk
   I2FuW6cU4GUMy5rYPSD84A1L+SlJfcT8vjzTshhj1BmkWrnxH7ZM3XSuG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3666948"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="3666948"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 01:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; 
   d="scan'208";a="8562534"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 01:14:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 01:14:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 01:14:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 01:14:28 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 01:14:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXguGAsVF7MLpDSJMeDCgdRpuMPPvD8FnkJAF61gUvM5xkhlWYhKwdwCvDqWbeD6w3Wy1QYWoB0pYEsi+OWkrvxknJFRxKVLVNhXOxHSUZnTip4hSB6QfQ1hxkuxCQJtATUNZPNaJIZjMja56Ld0IlMWD1wlJ2tz778ls/0bWdZeUK5Sp/bK9DQHbetPSxliZv0rt8lP13aCd2BL9gtH74MRZrrFvX+2+yVjbmuEYeXrWh/PAnVAJDpe3b0j4BV1h+myYZQYMuwqOzsJORml+fb+P4Xx9/DvpOt119m40lopR6yp3SJSuCJP/0GXfzXXWe8tDL8Nexcl2dyIxr+2Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF7y5oe7FNHbaTmmGtjbbykKshJJWbrLzLSUNO0cEX4=;
 b=OU0ZCYxnuf+HwletilaAPPjOdPDcJo7IgXN7zHi/L74jO+TSs+kk2l+C4kBWYuQFWBN45lc7wQis0b62yFQvKfJKCWcKGWj3MtBw3/Qn1NgQIK7ZCsD/ngdIeN8lX7HG/PdEXlN8tJVIX7o+smtcKNz7dFvl4f7bgoZf/vCpFnQiqyuvWB/2BQXNVVlND5rhXwHcHV8JPkafBhbuqNCQCinn+Rgq203JA7xNqUlnPuBPsmne/oqBNGm1zbS5QFiObmOPCJSzHZTgQHYt10bKLpgrhn65h4UDL+leJGmXV3d2CGcmYwcaCeSE2+gPY08oe/oOLlgv3BU2SThoJI7mkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7747.namprd11.prod.outlook.com (2603:10b6:930:91::17)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.14; Fri, 1 Mar
 2024 09:14:26 +0000
Received: from CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::998f:772d:f011:b2a8]) by CY8PR11MB7747.namprd11.prod.outlook.com
 ([fe80::998f:772d:f011:b2a8%3]) with mapi id 15.20.7339.024; Fri, 1 Mar 2024
 09:14:26 +0000
From: "King, Colin" <colin.king@intel.com>
To: "Huang, Rulin" <rulin.huang@intel.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "bhe@redhat.com" <bhe@redhat.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hch@infradead.org" <hch@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "Li, Tianyou"
	<tianyou.li@intel.com>, "Chen, Tim C" <tim.c.chen@intel.com>, "Guo, Wangyang"
	<wangyang.guo@intel.com>, "Zhou, Zhiguo" <zhiguo.zhou@intel.com>
Subject: RE: [PATCH v6] mm/vmalloc: lock contention optimization under
 multi-threading
Thread-Topic: [PATCH v6] mm/vmalloc: lock contention optimization under
 multi-threading
Thread-Index: AQHaaukHInwQzo1rVU2AdZvWZpj8SbEim6pA
Date: Fri, 1 Mar 2024 09:14:25 +0000
Message-ID: <CY8PR11MB77473CF2A8F9BFBFE3B3A09E8D5E2@CY8PR11MB7747.namprd11.prod.outlook.com>
References: <20240229082611.4104839-1-rulin.huang@intel.com>
In-Reply-To: <20240229082611.4104839-1-rulin.huang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7747:EE_|PH8PR11MB7096:EE_
x-ms-office365-filtering-correlation-id: 36a904d3-b38b-4cc7-7c1c-08dc39cffde7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RSTx3GKUyRiy7CSeUaZ/VWmAbhg4Vy4aW194Fuyaq8ryOTLqTc2VbND0VK6bZSxNA2b+vSUE5syBYal1EMsoDtkxinCBV1kH/tWreYi68+xOXNoGeMARCMieLY7K9SPb2hFzRzrRSyPF68mbhrqCwH2hfP8wp2LoyboUbHillHjsrvfPQ1GcguACsnAFO25KRvUuoRvoxso5ATf6rcos0CHEoE/1xBYFUxJatSc95zzqpKc26khz/UOI7pMKAf4DpM3eX44UOKtf8wVIo3lS0082M9V49IQlNcIIpr5nF5BxcurdUq2bSwZvvugumSpFrhgmH1goiYICGLtZwV/mUHYbF8SZ1Ha6RgFF8YO7hYf97EsN8K29ya1RFya0wk18bIEi+2nUuOoueuL7zeaXXXavEJjrQUhfkHS06leu3fHMOfzBzqSzbHqAign85DRz63vO2ZSN5jgiZLtr9/zC88YKLDDFfqNJwZq/gjNCLBfszk/YL9kljjMNQF/apAIgmUjS2/EUXZGMjEGn2C58ifVOXbuu5T/LY+CT4GqyPr/SHFWIbTSpmCA42+cOZjoXdlKNbEVThSeYRd/e8LLlgsOBkAbPmjx6PriB/hqOoB3o7TdtA8OW+Cqru4ion2mhfwpTAJqmb3zNnywRdV/K+Qlz9dXsPrz7zU6v98f2Ug8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K49wzxi4+i39JwG/qekqvBGDkJgqE1mf2J+F4pVfA+yD4zZ4dVzynPU7ipYM?=
 =?us-ascii?Q?JTaQGWiNfkHqeCO2fsvfuLJY7sAdS05bJSDcdz9kA76YLz9TapS6DU5+gpvW?=
 =?us-ascii?Q?fd9UuVNnOA6czYtANig59ZBVrU/vNdSO96QSH5txvG73zV/pTkHhjq2i+/Jz?=
 =?us-ascii?Q?7Py1OQsKsDHkohvIJ2a8J+nXTN8YYkKizw0cvbC5l8Lr0iQMwbf8qrLAUhtk?=
 =?us-ascii?Q?0MRHc+TX2ANwFPXRCjxalAlIchSqXYYRPAOjahcKablOPsiN61VZ1Ny63EXq?=
 =?us-ascii?Q?IYSllziMEb5jNKOcgRCUJw8jZJp5hmI20o3s1p8hM4tU9scLrKkM9V/wgkH0?=
 =?us-ascii?Q?El1aah0u/jWR83q2DaC865s+c7S9M7VUT2cnbDDQftLHTjVAnTKPLyDp1gGA?=
 =?us-ascii?Q?BoxOkExmh4R1RotmQ0+QUshef+tzbx1otSlULTwiHenVL6rxv+qdpyFVhnA7?=
 =?us-ascii?Q?TTKN72W7dTNqDxE81FwmbopPFuCkoZar63fa5fOelPxEeLkW8UWKzLRtqFQn?=
 =?us-ascii?Q?bY9HVUjoD6FWeLKqhFJBNhq6S8h1MjILNWK7fJQPWcVwOD6xIRYm7LwbAFO/?=
 =?us-ascii?Q?yZeSepGktU+Ksc5x7HU4E8CY6oZ8U1s+9nFUGQ6OeTJ0ucWqEy/8kH3VP+zb?=
 =?us-ascii?Q?7jhyt/MviZs8h1Ci+1BsA4pvN6YPwosZexAwYNQUb5M/WgCuRRc+lworheLc?=
 =?us-ascii?Q?UcsceFB6H4tk6sb1sXPXAyo2bKr9T3kw9HF51b7mqAnR6AoKinSHk9YJz0ff?=
 =?us-ascii?Q?DyIaDT/h1y0nGOPEfsr7WEC6KpKmhGkkRDNgw7FR9GnAeokoPLYXWIKCeEBA?=
 =?us-ascii?Q?4FdyjzDkk2lcod5MvEt8nsEo9TeVUsdfNm4x3sQ7BKI9mBPoIXg6WJeF8agM?=
 =?us-ascii?Q?OgVVGq3AuCdO/og9r4cER4ZOb3lo5mM6frOoGPjl3v6TKh+BHdGLAHPDhtUe?=
 =?us-ascii?Q?aqHQhEJitggu+DENF1Gw3B/lc0AgjkmVYBNi4CuQiEgtJG8Hkjxdgp+NZrKu?=
 =?us-ascii?Q?3OMmhpSM/ldeaFCpgjwfRe+2Vg4LGyCU4/IRPwyr4fSpe70i4OEt3QW4hhrD?=
 =?us-ascii?Q?JdZ1GQnkkrYjCcq+Q1SOdXvM1JVW67CnyPYMl4js+GAz5v1uxUAHIl/X6HWN?=
 =?us-ascii?Q?zVjN19XYtOTBLJw8YuvCarx7IEmUf5AKbs2ibcHEt/upqeCbmUlEyJ63pBER?=
 =?us-ascii?Q?qiXLPR1A7+ET8gW2AmfY5TedUZrbP/8cNK4njiLGJd4+K+Viy0r997PTgkF1?=
 =?us-ascii?Q?ncW590b+Wm5WxrgCwxqjB4E8ZS1GE9+dW+S/UsO+bktFXgjKQEmjbLqo3yMy?=
 =?us-ascii?Q?Gflko+n7TZhYVaE0eQZsqWCT3vb4vfP7ZKtS7Clh0gt/MHKkPz6/a0sEEVcJ?=
 =?us-ascii?Q?cBd0k3PHX5Pk8JQWXTmUil27zyHbHafRUxOjdHTn3xpRvy0eoi0B5XXbWwcF?=
 =?us-ascii?Q?Mrfcgm/kofLQoXBuhfiiFDiBVoVQo5ZHEn3XsbWPac7724iGTfIq8Pit3fWf?=
 =?us-ascii?Q?u6k3QVA7VH5z817gEktmbAlbSSV2vSqXKN7Qp7EQRK3NkfAAa57a66KNPCIl?=
 =?us-ascii?Q?TY1MfYUt492HFJXAO8XxSHOpj13ltyOCTdiBqM+1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a904d3-b38b-4cc7-7c1c-08dc39cffde7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 09:14:26.0001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vgZ+ceZJcV4XViIh73MZhaucksA4Qn+2nYQOdc1kV5nXudCRAYmO+ub9GqI53mZzcF17exkuUUln88adhw0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
X-OriginatorOrg: intel.com

Just to confirm, looks good to me. Thanks Rulin.

Colin

-----Original Message-----
From: Huang, Rulin <rulin.huang@intel.com>=20
Sent: Thursday, February 29, 2024 8:26 AM
To: urezki@gmail.com; bhe@redhat.com
Cc: akpm@linux-foundation.org; King, Colin <colin.king@intel.com>; hch@infr=
adead.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org; lstoakes@gmail=
com; Huang, Rulin <rulin.huang@intel.com>; Li, Tianyou <tianyou.li@intel.c=
om>; Chen, Tim C <tim.c.chen@intel.com>; Guo, Wangyang <wangyang.guo@intel.=
com>; Zhou, Zhiguo <zhiguo.zhou@intel.com>
Subject: [PATCH v6] mm/vmalloc: lock contention optimization under multi-th=
reading

When allocating a new memory area where the mapping address range is known,=
 it is observed that the vmap_node->busy.lock is acquired twice.

The first acquisition occurs in the alloc_vmap_area() function when inserti=
ng the vm area into the vm mapping red-black tree. The second acquisition o=
ccurs in the setup_vmalloc_vm() function when updating the properties of th=
e vm, such as flags and address, etc.

Combine these two operations together in alloc_vmap_area(), which improves =
scalability when the vmap_node->busy.lock is contended.
By doing so, the need to acquire the lock twice can also be eliminated  to =
once.

With the above change, tested on intel sapphire rapids
platform(224 vcpu), a 4% performance improvement is gained on stress-ng/pth=
read(https://github.com/ColinIanKing/stress-ng),
which is the stress test of thread creations.

Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: "Chen, Tim C" <tim.c.chen@intel.com>
Reviewed-by: "King, Colin" <colin.king@intel.com>
Signed-off-by: rulinhuang <rulin.huang@intel.com>
---
V1 -> V2: Avoided the partial initialization issue of vm and separated inse=
rt_vmap_area() from alloc_vmap_area()
V2 -> V3: Rebased on 6.8-rc5
V3 -> V4: Rebased on mm-unstable branch
V4 -> V5: cancel the split of alloc_vmap_area() and keep insert_vmap_area()
V5 -> V6: add bug_on
---
 mm/vmalloc.c | 132 +++++++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 68 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c index 25a8df497255..5ae028b0d58d 1=
00644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1841,15 +1841,66 @@ node_alloc(unsigned long size, unsigned long align,
 	return va;
 }
=20
+/*** Per cpu kva allocator ***/
+
+/*
+ * vmap space is limited especially on 32 bit architectures. Ensure=20
+there is
+ * room for at least 16 percpu vmap blocks per CPU.
+ */
+/*
+ * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be abl=
e
+ * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
+ * instead (we just need a rough idea)
+ */
+#if BITS_PER_LONG =3D=3D 32
+#define VMALLOC_SPACE		(128UL*1024*1024)
+#else
+#define VMALLOC_SPACE		(128UL*1024*1024*1024)
+#endif
+
+#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
+#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
+#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
+#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
+#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
+#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
+#define VMAP_BBMAP_BITS		\
+		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
+		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
+			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
+
+#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
+
+/*
+ * Purge threshold to prevent overeager purging of fragmented blocks=20
+for
+ * regular operations: Purge if vb->free is less than 1/4 of the capacity.
+ */
+#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
+
+#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
+#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
+#define VMAP_FLAGS_MASK		0x3
+
+static inline void setup_vmalloc_vm(struct vm_struct *vm,
+	struct vmap_area *va, unsigned long flags, const void *caller) {
+	vm->flags =3D flags;
+	vm->addr =3D (void *)va->va_start;
+	vm->size =3D va->va_end - va->va_start;
+	vm->caller =3D caller;
+	va->vm =3D vm;
+}
+
 /*
  * Allocate a region of KVA of the specified size and alignment, within th=
e
- * vstart and vend.
+ * vstart and vend. If vm is passed in, the two will also be bound.
  */
 static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long align,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask,
-				unsigned long va_flags)
+				unsigned long va_flags, struct vm_struct *vm,
+				unsigned long flags, const void *caller)
 {
 	struct vmap_node *vn;
 	struct vmap_area *va;
@@ -1912,6 +1963,11 @@ static struct vmap_area *alloc_vmap_area(unsigned lo=
ng size,
 	va->vm =3D NULL;
 	va->flags =3D (va_flags | vn_id);
=20
+	if (vm) {
+		BUG_ON(va_flags & VMAP_RAM);
+		setup_vmalloc_vm(vm, va, flags, caller);
+	}
+
 	vn =3D addr_to_node(va->va_start);
=20
 	spin_lock(&vn->busy.lock);
@@ -2325,46 +2381,6 @@ static struct vmap_area *find_unlink_vmap_area(unsig=
ned long addr)
 	return NULL;
 }
=20
-/*** Per cpu kva allocator ***/
-
-/*
- * vmap space is limited especially on 32 bit architectures. Ensure there =
is
- * room for at least 16 percpu vmap blocks per CPU.
- */
-/*
- * If we had a constant VMALLOC_START and VMALLOC_END, we'd like to be abl=
e
- * to #define VMALLOC_SPACE		(VMALLOC_END-VMALLOC_START). Guess
- * instead (we just need a rough idea)
- */
-#if BITS_PER_LONG =3D=3D 32
-#define VMALLOC_SPACE		(128UL*1024*1024)
-#else
-#define VMALLOC_SPACE		(128UL*1024*1024*1024)
-#endif
-
-#define VMALLOC_PAGES		(VMALLOC_SPACE / PAGE_SIZE)
-#define VMAP_MAX_ALLOC		BITS_PER_LONG	/* 256K with 4K pages */
-#define VMAP_BBMAP_BITS_MAX	1024	/* 4MB with 4K pages */
-#define VMAP_BBMAP_BITS_MIN	(VMAP_MAX_ALLOC*2)
-#define VMAP_MIN(x, y)		((x) < (y) ? (x) : (y)) /* can't use min() */
-#define VMAP_MAX(x, y)		((x) > (y) ? (x) : (y)) /* can't use max() */
-#define VMAP_BBMAP_BITS		\
-		VMAP_MIN(VMAP_BBMAP_BITS_MAX,	\
-		VMAP_MAX(VMAP_BBMAP_BITS_MIN,	\
-			VMALLOC_PAGES / roundup_pow_of_two(NR_CPUS) / 16))
-
-#define VMAP_BLOCK_SIZE		(VMAP_BBMAP_BITS * PAGE_SIZE)
-
-/*
- * Purge threshold to prevent overeager purging of fragmented blocks for
- * regular operations: Purge if vb->free is less than 1/4 of the capacity.
- */
-#define VMAP_PURGE_THRESHOLD	(VMAP_BBMAP_BITS / 4)
-
-#define VMAP_RAM		0x1 /* indicates vm_map_ram area*/
-#define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
-#define VMAP_FLAGS_MASK		0x3
-
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
@@ -2486,7 +2502,8 @@ static void *new_vmap_block(unsigned int order, gfp_t=
 gfp_mask)
 	va =3D alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
 					VMALLOC_START, VMALLOC_END,
 					node, gfp_mask,
-					VMAP_RAM|VMAP_BLOCK);
+					VMAP_RAM|VMAP_BLOCK, NULL,
+					0, NULL);
 	if (IS_ERR(va)) {
 		kfree(vb);
 		return ERR_CAST(va);
@@ -2843,7 +2860,8 @@ void *vm_map_ram(struct page **pages, unsigned int co=
unt, int node)
 		struct vmap_area *va;
 		va =3D alloc_vmap_area(size, PAGE_SIZE,
 				VMALLOC_START, VMALLOC_END,
-				node, GFP_KERNEL, VMAP_RAM);
+				node, GFP_KERNEL, VMAP_RAM,
+				NULL, 0, NULL);
 		if (IS_ERR(va))
 			return NULL;
=20
@@ -2946,26 +2964,6 @@ void __init vm_area_register_early(struct vm_struct =
*vm, size_t align)
 	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);  }
=20
-static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
-	struct vmap_area *va, unsigned long flags, const void *caller)
-{
-	vm->flags =3D flags;
-	vm->addr =3D (void *)va->va_start;
-	vm->size =3D va->va_end - va->va_start;
-	vm->caller =3D caller;
-	va->vm =3D vm;
-}
-
-static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
-			      unsigned long flags, const void *caller)
-{
-	struct vmap_node *vn =3D addr_to_node(va->va_start);
-
-	spin_lock(&vn->busy.lock);
-	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vn->busy.lock);
-}
-
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)  {
 	/*
@@ -3002,14 +3000,12 @@ static struct vm_struct *__get_vm_area_node(unsigne=
d long size,
 	if (!(flags & VM_NO_GUARD))
 		size +=3D PAGE_SIZE;
=20
-	va =3D alloc_vmap_area(size, align, start, end, node, gfp_mask, 0);
+	va =3D alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area,=
=20
+flags, caller);
 	if (IS_ERR(va)) {
 		kfree(area);
 		return NULL;
 	}
=20
-	setup_vmalloc_vm(area, va, flags, caller);
-
 	/*
 	 * Mark pages for non-VM_ALLOC mappings as accessible. Do it now as a
 	 * best-effort approach, as they can be mapped outside of vmalloc code.
@@ -4584,7 +4580,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned l=
ong *offsets,
=20
 		spin_lock(&vn->busy.lock);
 		insert_vmap_area(vas[area], &vn->busy.root, &vn->busy.head);
-		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
+		setup_vmalloc_vm(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
 		spin_unlock(&vn->busy.lock);
 	}

base-commit: 7e6ae2db7f319bf9613ec6db8fa3c9bc1de1b346
--
2.43.0


