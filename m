Return-Path: <linux-kernel+bounces-121493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F288E8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB83307A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAF131E59;
	Wed, 27 Mar 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU00vwGH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639E12E1D0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552932; cv=fail; b=eBZydUeVrUevCba8/XR9yhnGLx2G+Fw+I6ycPqP4Qo64RImJbDf0hMTT3cOiPM/6a6lrEULnd1OiBF92/Rdk+eenDI8tWVqnP42hu4sd3x+xyqv8wkORhe5IyNEnACbahA5yzQSxTWQNAvW3hwuqJHo+3QDCSVKs+gB95JXctoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552932; c=relaxed/simple;
	bh=p/fMzqao/EBKFJN56hSgL3Euo/8Ut8KXsmb7UgmoH6Y=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UPbbFY/cIAc4gLvXWJF7Xau3dpE4URKNXfFoRa25ruSe4PivUj+6PK2+8dJH2kYjJcM33YyR8D+ahvUOYlhqhMYmq18dWicBXmsMb6cZ3Zh3PKYHyCucCXiugH8UabBOUAeHAV0cnMw2Qgkif9wBI8v+Nv1pBi5XEEL26yugTRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU00vwGH; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711552930; x=1743088930;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=p/fMzqao/EBKFJN56hSgL3Euo/8Ut8KXsmb7UgmoH6Y=;
  b=QU00vwGHcBJGL9ZqNzkwasZe5UFgeqvjbsgiZaqrAPJscBbkZH7dPkQP
   uqzLnyAK91V6ON3vsyvzkkJ+F+wTwoG83Dv0Ce/q4+rIQBqXdka7ldQeU
   PS0wDeVicsJveBMy2XaPS8oQQxLPXgWa4Ymj8ueTkTwEGmP8Srvpjp6X8
   7fBPlYaYHAlRfZy21gwYRe+cqhqKj3jPkgBLUl52f9SU/gtGaeESI11xL
   3YSI+EfEV6qZuqdm6pxENUdIPOMcEJpvkNL1IiteLSoHhLQCjaN/APf/T
   uz6nkUDD+ZsALFkaKrVBG3K+3lci1NvI27IxmHDppRu962RTxjMUDdHza
   w==;
X-CSE-ConnectionGUID: YqK1XyNsQIO6rBy0bDiSqQ==
X-CSE-MsgGUID: D9NOQlxURD+9pWmJya0jXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6523771"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6523771"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="39461033"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 08:22:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 08:22:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 08:22:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 08:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSEmFmzspk6K0FMdKDeZcaVY1EeSIP4qPjurU4fulM89Ivku3Q8s+yrzfCOo1A76a1SCEBGy/0Zb/av3FZ7iUQ4ihy4FeARA6ZnvhsL4yVAhieAWKVGQg1qq4xOhtxgEH7TBR7mWFklhvkAlU7jN+pCO1+w9/ehHTrJZpxVM+iPSxCQyz7uRMzcp45hsBkY/tDzr+T56mmizF2stBr/Wua+D3xxE7IUoYb0sbs7wfWNWIYF1fXa1ZV89IA4c7gi4K1FaTKMLoTycir21dPPio1Ec5xJE/5tl+pSPWFzi7ToOvKT7iuAAxgSpbwx2ISz3Sn6TNcVcrKOuczLkyqxL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoNgDrAh9tRaef74913rEKdOUjUj1jSOVeVRKLZvCH4=;
 b=Jcr1uWJDJExn7EjYPc7TgZwuBMyDFZRb2uq3ExonX5N+wMF1A9nbfbTx/d2BPHMlQnFGDGySC5TK0PWGjOrPPnMd/BSHDbTO2WSzQvqFe1+8FvnilQ1XSzBy0iYYOE7KdhDqDGksfNT6SeUDHWaBv2dOue71k0kCOpMfftYBCr3dXHayxVz6OH60+dNCwLzU3V+IdsBZzwM/5up3jPHX8XshDrGF5NiIOr0/SkU2OhKbm8xWXvkYvBlo0y6Bxrn36EgIYkMyG0ADlcI4RMbrAdZIsL33oaekw+b8A3LcIhxDpwZ7uIHy+0cO5qs3qVHbWhJ5vC5+Bkc6y6zK/WtxSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 15:22:01 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 15:21:59 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Kees Cook <keescook@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: __randomize_layout;
Thread-Topic: __randomize_layout;
Thread-Index: AdqAWK/04TJgEIx0R828MwI3UxJ65w==
Date: Wed, 27 Mar 2024 15:21:59 +0000
Message-ID: <SJ1PR11MB608346DDA3F41ABB893C7860FC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|MN2PR11MB4679:EE_
x-ms-office365-filtering-correlation-id: 0c0d7459-ad77-4105-c2d8-08dc4e71a59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2N39zm4SKQPWNtioi5udPGLZ0p7QCyROfz+bjKaJfY6ynfFkYHwTFCOjbC0sAQe1mYTQnpWMXNkcWi1xRhDbBeEns5hVOrvxjdKn0ege1HbtuPY90RUHxYcN4p8bDewcYGH6Y62zzopIljjM2kWgae34J5ky2Ba4fomOe4xvuFQM0FnH2cHS8eARSqKRgGHdR3keMCcmLPqNVm/HLtp96Pxom9YWqEC9+cyLmi+t2+M/0tuySKZ8+4/1DU2vSZXlRc6S8aW73GEgfRs6szDJovO8qP0klLj69vsbRE2IJLV/Lf5Cc1ZOa8fnpX7ytKqnc6dmG4J9R7H24lQAQZYh5LIO2L1zBTEfj2pWZWM8KL8cgA34DfysMF4CVLaeEYEdVzrEjI4VZonEFI3ENHiGgovK6ulGvFIqbY2NpiY1TH51HLX8kgXCOXYJq74RU+ke5Wi9K6hXtLCiAEtbTXqXnKv/tw5Fi6auxpzgFv+/F+rli/6K/8VXpucuqUFSSL3MSjwpu7KAcsmuzpaL1A1CKL4xFl0SWdJdYyC92JeFnvZjYg042d1fOsWVNg4QMDX11V08CLVgmMSA9Id0OlGwQtQ+6lACweNCcMVHc+z4F6UxYU+xmyV/tj0F7rmLlHfzUVH7icLBzgc9+NLFiV9P4JO6EKOVnHcYIZa7fQ56MvstqtrJvcBFmnKg849XZSwL31DVPBL/xEjq1ezxSnraQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CrmeY+5+Wl9hZBNus7M1pC1S+uwbSfv3+I1LRWQqv/aBXBaRr9G325A46rR7?=
 =?us-ascii?Q?wdkyPoXYBLuONsPgcjRoKwOl9CjuE8EMEvGdZLeBLwX5dGco/N2mlryh9hL+?=
 =?us-ascii?Q?BeUkjTQSU9SJeM8R2lEv6SEUVVKLsszyc0mWpYHtQOhJzX5Tdmy0w/chcBxA?=
 =?us-ascii?Q?DQnSxnQ8KgxTGtmpYGJAtnq+hPjY7dIo4UTyXflxkR2mmAebjd5uHDYNmlIA?=
 =?us-ascii?Q?AZoWssdq+wkNZCzDPdsxUE543hK2rMYLUm8V/OemhJG+bLITA4jFeegMUbjS?=
 =?us-ascii?Q?AamMOZIPb/q51AyZmKC1XpYEA4g4ICBe2ppB5BypYPYb2mSHplDpQOKmb2AQ?=
 =?us-ascii?Q?D1FkzKLwtwx586CHbec3YJQZ8IdYarMM4zxzqYtbSHNbYTqdneL+tWHAGIxZ?=
 =?us-ascii?Q?ucHPNHPsANIoau77t+xOpudt5vQ01C0R2+eYiKPwZWfnmMTDDwH4Cvs3HBga?=
 =?us-ascii?Q?3pL47FuGHZv6+10Ozm29Pg2QVjSRKkDyKaxqdX9MZUju0kue45qeW5TsqRch?=
 =?us-ascii?Q?bv8KB1Lmica8HlRJW1rlxR3REcJ6s9lDhnWR9cAXxcv6deZ+tDla5umbhtvK?=
 =?us-ascii?Q?wtcIFrSg9Xd3kZy0Ry7olYZYid/IWGaAh3uHon+uciejOiPp6ksPFEuu6Pz+?=
 =?us-ascii?Q?e8tettNBRZdiIYw0oKjAGHlvJyHOtLS82UvrRt3RdfnEnj4pm+SRZ55ahaea?=
 =?us-ascii?Q?ucnT4B9Ru3b5+5T5dXXwUhX3uQQMrz17aN7ZJf9VBkY+CfV9p6pyy62jxAea?=
 =?us-ascii?Q?ihcEczVusOrAJlKYCnPfsMna5JZv+WmpqS6JC0bcDUD/olqrW4fEmf8tqwPR?=
 =?us-ascii?Q?czavlR9cjl5u05gY8aD23RrIXJA3Jfc+fjRKS1m4DPxZ3SNzJnohHIiBRCPl?=
 =?us-ascii?Q?CvgLTMs9wZbfKHPhOHDNRG0fjK1P7n9T5AIrDY+oG2LnlNhkviikVIp3LKl/?=
 =?us-ascii?Q?C1qoJmz80Zc68ZKAab2Mtl0tEKg3w1W4reaRPL14cYUcr1hX/QfUvzm8qD0n?=
 =?us-ascii?Q?un8yizrS1QJCJmNF2FyRgLdyhSx+k9v3oyVNKTrc8JQjVFjMOU2UJhR7EBMC?=
 =?us-ascii?Q?StlXO9e8IwfjXnM7pJILvu1UjCBrFZCOg8YG1bdv7d//0Xv8v8RsojjRoSXe?=
 =?us-ascii?Q?F/bY03SzPko1GRyA0POWsQwCu9lRnUi9/8tXiOzvw95Q7IxxI8GvXPVtGO87?=
 =?us-ascii?Q?1gsgzjmX6vy+RsD7QMiqaElppnznt+9xAPhgV0sATFbVJn3Y35caxl/cRlAG?=
 =?us-ascii?Q?aHRzUIESbA8e4DR5vOaxjtz98Tzjh3ZNrS7pzz7jtjYuJg1pzyOmAlpnH7mh?=
 =?us-ascii?Q?r1niXoppcKze+cDAjAEOAJ9xopFgUF6gSE2nJu8SF9K3m+P/Ll6BimjIb3vk?=
 =?us-ascii?Q?KV+BfurP2TrDln/MNLJi/HW0iHaMGAflS43Ulqg/6l2SHwlv9SZ+WiGjUOef?=
 =?us-ascii?Q?o8/z2/HtzinS6M6wKDhRdmPEZFR+2ICnXf0Fwuk0as8zPkPELxR+1HwAKmat?=
 =?us-ascii?Q?pZrMf1Dd592oYEGuCpkftBqF9rvlKlKgK6K3WCbhwct/Ca1HYI0ln8w7kB8e?=
 =?us-ascii?Q?09t/lHVYOsOf3o3TawLp+m1Th+LWCScya4FcQCf+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0d7459-ad77-4105-c2d8-08dc4e71a59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 15:21:59.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZBSmPkh5yQ4rSlgAf9sNLOtlgC//OlSXRf8rQ8twYA6FDS7mHdNKzO39sUuF9ECpKzoN2lLmRYcFspFXsEL1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com

Kees,

I'm working on some changes/cleanups to make supporting new x86 CPUID famil=
ies
easier and safer. The big picture is to make the Intel CPU model definition=
s in
<asm/intel_family.h> encode vendor, family and model so that code like:

  if (c->x86_vendor =3D=3D X86_VENDOR_INTEL && c->x86 =3D=3D 6 && c->x86_mo=
del =3D=3D INTEL_FAM6_ICELAKE_X)

can become:

  if (c->x86_vfm =3D=3D INTEL_ICELAKE_X)

Source and generated code are smaller. Safer too as it becomes impossible t=
o skip the
vendor and family checks.

To achieve this I want to make a union in struct cpuinfo_x86 that overlays =
vendor/family/model onto
a 32-bit "x86_vfm" field:

struct cpuinfo_x86 {
        union {
                struct {
                        __u8    x86_vendor;     /* CPU vendor */
                        __u8    x86;            /* CPU family */
                        __u8    x86_model;
                        __u8    x86_reserved;
                };
                __u32           x86_vfm;        /* combined vendor, family,=
 model */
        };
        __u8                    x86_stepping;

	... many other fields
} __randomize_layout;

This e-mail is to check you on whether that __randomize_layout can shuffle =
the
fields inside that nested union/structure. I tried some experiments, and in=
 a
few kernel builds I saw the whole block move to different offsets, but the =
order
of x86_vendor, x86, x86_model, and x86_reserved was preserved.

But experiments aren't proof. Nor defense against future versions of
scripts/gcc-plugins/randomize_layout_plugin.c becoming smarter or
more aggressive about changing layout.

Thanks

-Tony

