Return-Path: <linux-kernel+bounces-154757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B36488AE096
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8562B259F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556C59154;
	Tue, 23 Apr 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLMiNgGF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176158213
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863204; cv=fail; b=mSBpVYS4kfX8vXtyFflNLFFC97ulCHmOakNvfmXTFkkjoMntPH2+9X4kPGxJl3OZGwdBeFG5zFpmwzxcaFoPcY2YEPcKJSbJP3QdaH0TeZoHLyOZVlSCMFQ2yHjOJ8fSpvaaXdCN0N03NDqHqRvGjw94fzEB7lSVOpyBWAdsS1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863204; c=relaxed/simple;
	bh=tO/mPms7UZ6JzdIZKIBAGRIa1isdiozysoZwewF13Uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txxCDCBMgfDIC3KOQqBTvWBtlWJbEXI5ckY5KHZUOPmPHIpWeID5M/VbgCyVqwSt2/7kuR3vlI/DYwB+wN2yRNSGnPVIKIO9R2HhiANE3KQ/ZEyRJCSqKpVmDsCKxFTdEWwGzVE9sE/VDbe2EcHGvtGs5lOqXZK9kJU15fDrtXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLMiNgGF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713863202; x=1745399202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tO/mPms7UZ6JzdIZKIBAGRIa1isdiozysoZwewF13Uc=;
  b=PLMiNgGF/d/PsnuCaoFBzU/vmUouZ9c8dxzIO31Z2eFXPsxWosz1odIy
   lM8bMm3zAjkBaGGlrkjg5SNZDlyHFHeHefFgsSZiNl9RYmhaArL783yKQ
   uEpI7AIo+dqKLwWBMyNRHdNHRh1j2NpffZAxMPnvxSwmcdgDEG1liazO6
   48SzBi9jjJ8bM5Nn90qf+H4zhdGRSGCgihkpqDKqu/NbZjg+xs0n9QPiR
   gNQPkWEWG3M88fD3G/Bxhj6eDlzrtTjPua1FLqSVo1OpeT2LqzwTgHxkx
   ZRNSdr575VoPiIe0KO9ZBpqDB/JHlkBpEhiIGFEbYnWbidiORQ5jTJ8/P
   A==;
X-CSE-ConnectionGUID: rBuryzBFSYuERRj1u/wgzg==
X-CSE-MsgGUID: IijqbqbDQHmAxFzY1XvVvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="34834652"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34834652"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 02:06:41 -0700
X-CSE-ConnectionGUID: WXE4QiePQjay0WHaF6gvDw==
X-CSE-MsgGUID: VI0WpPN3TBifzc/LnOQGPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28808684"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 02:06:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:06:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:06:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 02:06:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 02:06:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIE7R7et2+LNqV4J4LA6OQv/g4k98Ixe+kmlooiLHJNAQnVvKV8cpvk54PeFz5FafXxnmAiZwmONuhvHDVb5hsH35DWjRqWPAMyFoy7oMEW6C6irzyZqkfExByTaI2taYJB65NQisWr9k04/Vldv/UEkyFeEQHjFVSKrV74ToklRut4YT1zMjWroKwzPpG6QWwz8UCn8PlKvqqHkArPdprFSIc7d4p7C13QQb0R45eYZraXx0A9kguLkjgUdZ0mzL5geTcEbhLQR9e7xJNW96v7Pntd5ANoUtLA3+X7GS2o8aIu+5IMnHyiKz77o37CakkA6juQNU+sQjtyuLleeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk7z5j/WOeSA1yd6SIjOqCB9eCDz1OfJposF94yTGeQ=;
 b=AOmDRzmrWb4pT26X5UPuBjC3/8QWnh5fwwx3rk2Oh9C+xWrp3wZJwDOhpgsi3LbbHMJwqNKjg1lqoaxBCOgDlo1RzLdfVDXei7CY2H/EUeI5gcjJ7OECkdjrMRtivcn9g7SRHbgZoRl461IHQ05B0CgctyUfpv8GWTQK/Ng3AvPg+DgCtlSu2XYLAd1RvJ8tBHIjLavXNA4/1dTjSbSOQZyUl287J8AlFGwkzKmWcWrEtQEXG8Ke9C+GZ6zZjUTzh7vt05C4oYgXSi7QuizQvL4Wk5PirtMqurQVVhFHmhREkLucCmRguc0lMYBARgK4e3//c9JbFHJwQ7d7GSEWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 09:06:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 09:06:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 00/12] Consolidate domain cache invalidation
Thread-Topic: [PATCH v3 00/12] Consolidate domain cache invalidation
Thread-Index: AQHaj9VAILsDRhFBN02eOZFRgygSFLF1mx7w
Date: Tue, 23 Apr 2024 09:06:33 +0000
Message-ID: <BN9PR11MB52765F34E1168B538C7CEDFD8C112@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240416080656.60968-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5197:EE_
x-ms-office365-filtering-correlation-id: cc4f29ac-5851-4326-2b2f-08dc6374ac40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?mqVlJcXku4hFLskTqymlfFwsk3DXMvA5YAEgYO7xbjBFJcz+RmfiPSV80+yD?=
 =?us-ascii?Q?41jg2XDnk4rqV0BOeaVtpYltV4GKfvvBe8G+fM9gkbtJn1CSrqfl9o8sFuLj?=
 =?us-ascii?Q?IYJ5yoWoc4z6tc5VGibwiJk32dDC7DDMKSjcTq9nCYoXtVtaz3qBabqw8RoD?=
 =?us-ascii?Q?1Dh7On9eWhNxXx7qScyN/sYOPD1IuNLQgG1JoEVTYJ6IfrBDb6ftLlcmmwWH?=
 =?us-ascii?Q?KVxVFD/dF9XE8atfvfEioAyUqElZeceo2ACacNw/YxsdvhNr0YoIsNSGdGIJ?=
 =?us-ascii?Q?HO4DMUBaOmegyHsSvKkBp4i9TOx9cTARe8rtXQH/LfLH693K4Ipmw0Ep4O0Y?=
 =?us-ascii?Q?mbYLyrMZohiWN3IOOSvFEFkogk1AryaHg5b49U51t0VtU2NGLa15UFsLszsD?=
 =?us-ascii?Q?+YsLvpSOlRb+eftitC57LrARH1gXKhnvwJ8DGKVqGAAbHvuEnZkLt7fkVfwx?=
 =?us-ascii?Q?n1yebv69EEnk68+QEL9WbBn3dl/9e+L7oIbJjoHX2vcsDQ958XqSe6Kch3Dk?=
 =?us-ascii?Q?t0gtDuiaIS/0HIhK8QWV/ENeKAIKHvCEtoTtmfLkDqRNta3ByDw5lcYx5d4C?=
 =?us-ascii?Q?OGywww/flAAmuWoiN9g4/0xf3EL6fCjLD8MCmlvxICA6pzUZqRHc5uOljT7i?=
 =?us-ascii?Q?I0Hbb/86MdXwO6Yco6p9s/sEFDxkDis5gi1pnx79FNIhrHewIv819mxcurhH?=
 =?us-ascii?Q?Ds8w5f6EMfJZhjtYHyvfj+eGW6HaDx7ys6AEF+4Zq+aFS1nD9kR8VUKvfBw9?=
 =?us-ascii?Q?4Vli+K9NdmK79OkuGvYMRb0BqLHCkPb9DQHysyZTvzM2Eq3YKEfuBj+GC0wo?=
 =?us-ascii?Q?GGd6VAicJ4IGNm2e4ZE0ZvkZodqGku4ZKY5YlpV0D5caF+D1M73ccIXKu8Zd?=
 =?us-ascii?Q?reZ2486yvpbzOzYvM8t1JkQA3lak0ENBmz1GmY0/ORSB93udD7r+Z6c70m7Z?=
 =?us-ascii?Q?08G82Zvr1IPO2DTvyskP3Dn2Wtvk8GUDPuqJ5a64836RF56Bo1lrM2Rtx6+v?=
 =?us-ascii?Q?9RJ3dKNG6e0CFLcWoPZuWiV+o+J3xaqGWmHhQ2vdUwFOw7i1WaCWEBcvDsyS?=
 =?us-ascii?Q?mNDQrFblbfyfHVkcGq2u2eyjATaAHBl1OBJYW/GQHWWqAO7FgrQfadrdmmq2?=
 =?us-ascii?Q?NIp/ZFaHjNLPKhewFHtezaI1LIiLa27SrKVYy1I3eruWwbRFKccIY+W8EYvg?=
 =?us-ascii?Q?vNo/varf3cTDAJqt3PTiW3Dsqdc6uZqFUA8Hy/CDo4kEKExQSePWiS0jMCNV?=
 =?us-ascii?Q?kdeKALvRBlzClz3L1bKbdQfP20q8l1tp8clv00uO6rN04syJes7FuldAAIk3?=
 =?us-ascii?Q?3/9EbLZZmQscWrlK2tuPbhhQhiNlZ8Nbf/fZmfaLcqqARw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/a8CHntON1kJEYvO3FA/ML969mj+tu+0N4jaLJmEdiFMWdbla1bskvSDFrIB?=
 =?us-ascii?Q?o0Q7alwhtdTldSGhLPAwWAdFNbCh7p49IjW6dX0pNBYOAyP0pp5LaU+BsSg5?=
 =?us-ascii?Q?F9jyOfvFHIekrKTP6cYH9fB+nS8dSr0RWTOeonTJjSXokBPfUwI17bAZvgjH?=
 =?us-ascii?Q?gqLj/5C3y0nVqkTO9kGxYp/RPCN+UlVlM8d7DVFkFWMTIBsgruBIrrEOJ3Qs?=
 =?us-ascii?Q?cXhmgJAKD/h2Pm21Ab3b4G/d1XUZIRjZyZGkSbivH0lwxiy2uBBJcodfa2KR?=
 =?us-ascii?Q?svNHro1givpJFxPrT649LDs+OdCeSV9PJQLaM4zzofLCQerZCCoTBwpab1/d?=
 =?us-ascii?Q?sCg/G66HydWmGVREj0D3T3LWAFIZJL1lwqgDCQEgJ5WAPOe1z+60HM/z+qW7?=
 =?us-ascii?Q?TYPNm/pCMgwkqxYRzTt97kqSv/T+YTNz5n/FoGTyAdbuA1ZjCJepHQ62+DjN?=
 =?us-ascii?Q?Ix48nJtWgRYyWCZjNhgUDoDBamB4qcFXgnh2PYKfVea2Hvg0gsuBhR9mCPZh?=
 =?us-ascii?Q?Fvgn9BOSeeEmbeLXbdy+9qkQyCSSV0TWD6Emql4TbUkorXLgR6YEwsjhXXST?=
 =?us-ascii?Q?Hza2RMY3d23HXLqBurYm13mg6guNBZTdFFyjvMP2ffwmA0chLj/+mvA1CXAD?=
 =?us-ascii?Q?zDFgfGHVXMkPnmSLxO4+5/pFvah5Q0prKYs7LfxtFpA7Pai4eH6hiv3aft1T?=
 =?us-ascii?Q?EFu5V9pLqIfV8IVYOaMm/ckxfya/rOXBlRLtJyWz3dOGR0GlnBOFLEposR+4?=
 =?us-ascii?Q?v1LCBwa5kiBWHAbKPOG8JHbqKULSbfxGqgYkOAy957TzjdL9OVSJdqnGnJv0?=
 =?us-ascii?Q?o5ToonXcEpMbQX0bdVZv7EKiuCRxI26o/oieAkR70p8D+MUSgTl6u7614FJP?=
 =?us-ascii?Q?o0XOsKwSacXko+P6SxQCkxoeMHqlgOxszWhgNunihPUiUsU6yiBK3y078CqP?=
 =?us-ascii?Q?kDumAhQR4ZfP2tUU5z4qPbqR5cdvUyA8zZw/6jQzRhyNOeNuKPWnr6w5M30o?=
 =?us-ascii?Q?TWA8IYFq4njhmO7hG0j0blj82ARyLlIenbnxjEp7VUOSO52nB96190HUyE12?=
 =?us-ascii?Q?8lSzg+gIFU7Dv5HJI1IGLOKitGPoJnwB7ZGbewonYDRbItUDGQr2ibnM3dry?=
 =?us-ascii?Q?3mn3k6YYrSTfqXh66Cxf4PrP3CM+7YqG193dYDKUY1H+3MPZtJ7/RfnVuEu6?=
 =?us-ascii?Q?ql0Ch87qTmUp0eIUKSCFE6FVmjq4iKA+K/EPxKv6tSNCnc2es+Qvym1Kuoac?=
 =?us-ascii?Q?D7NeFWt+cJ0gnuPTH0biITYKX1LqZUGKuqy2L18RvSb+LvM+RlSVTpD9ZX+w?=
 =?us-ascii?Q?2+POJRvfy/EaE/VcbC6XuGTcd5D5WH/+L/4J4fqtwqeMz3jc/3oqcLP7s30L?=
 =?us-ascii?Q?f/6F8aCtvCjTWy6U9KRhaBUmCIsFLdRXk246do60LetTcvah58DyhO4sm3Ex?=
 =?us-ascii?Q?cJO/xpCIDnA8O9Gg7TfJZFBjKSUrNPcfr1YzdDFQMAk2fPPxBc6fGFcWoKiF?=
 =?us-ascii?Q?cu107LTpvGWzvkqDtlHniH9pbewakktiTUs5V6qnrU8jqZqna9xiY+OQ2j5R?=
 =?us-ascii?Q?0R8Bv5k2+jmRbIQ+xV7JpZqmifgwTuQ7Mn/aSSkb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4f29ac-5851-4326-2b2f-08dc6374ac40
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 09:06:33.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: diuGkVWVCzA42gQlcXfQ0B4BxJli6AM6/QeMjo6xl0b9EPSgFTcddjfw+oNKHkKYrI2fH0llLPpOJYUWhDPe2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 16, 2024 4:07 PM
>=20
> The IOMMU hardware cache needs to be invalidated whenever the
> mappings
> in the domain are changed. Currently, domain cache invalidation is
> scattered across different places, causing several issues:
>=20
> - IOMMU IOTLB Invalidation: This is done by iterating through the domain
>   IDs of each domain using the following code:
>=20
>         xa_for_each(&dmar_domain->iommu_array, i, info)
>                 iommu_flush_iotlb_psi(info->iommu, dmar_domain,
>                                       start_pfn, nrpages,
>                                       list_empty(&gather->freelist), 0);
>=20
>   This code could theoretically cause a use-after-free problem because
>   there's no lock to protect the "info" pointer within the loop.
>=20
> - Inconsistent Invalidation Methods: Different domain types implement
>   their own cache invalidation methods, making the code difficult to
>   maintain. For example, the DMA domain, SVA domain, and nested domain
>   have similar cache invalidation code scattered across different files.
>=20
> - SVA Domain Inconsistency: The SVA domain implementation uses a
>   completely different data structure to track attached devices compared
>   to other domains. This creates unnecessary differences and, even
>   worse, leads to duplicate IOTLB invalidation when an SVA domain is
>   attached to devices belonging to a same IOMMU.
>=20
> - Nested Domain Dependency: The special overlap between a nested domain
>   and its parent domain requires a dedicated parent_domain_flush()
>   helper function to be called everywhere the parent domain's mapping
>   changes.
>=20
> - Limited Debugging Support: There are currently no debugging aids
>   available for domain cache invalidation.
>=20
> By consolidating domain cache invalidation into a common location, we
> can address the issues mentioned above and improve the code's
> maintainability and debuggability.
>=20

There are several small nits but overall this series looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

