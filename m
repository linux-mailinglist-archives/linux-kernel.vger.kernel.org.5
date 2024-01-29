Return-Path: <linux-kernel+bounces-42327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D232B83FFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033DD1C20E21
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F653E3D;
	Mon, 29 Jan 2024 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGC9XK8s"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A153E29
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515659; cv=fail; b=PnH16hjK5K9YDLKcVK8PQno+rZNHt/jjYyKzlvi7bvteelBzuJ3/tmGEBKw3Idu6iZLVlRtB+515zf822Q84IJrVjYSXDZd2ZMuP2Ccsq6aB+o7KKaK8f2rHf4m6b3++ZVH7EM/2kh4hZcldtEAZTPynvB8uh0h0bWHaIgjxuRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515659; c=relaxed/simple;
	bh=HFaVPp6G1tx/YZyPDTY8eKZvG1jM52IDsANYES24DTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=it7BKPB8SHPBdY3gHVA2FwuVHffDjkyaS71A3adEKNJhHl9TMhmvduzcc9Y7TqU72sg+g6gXJcfOVuvDN9OWiRwn6uig7TtQK4FfnXi+XTZ1kZqTr9HLo4ov13XOdm6U2E+tQ52THvCdA3XKAcNy3/ObPAuPfjgb9CGG9F+5GDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGC9XK8s; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706515658; x=1738051658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HFaVPp6G1tx/YZyPDTY8eKZvG1jM52IDsANYES24DTo=;
  b=FGC9XK8sk5PcD1I/zdrJ3Z7CVrpx4BlDxZlEh5va/KGNVOynPGcFvC96
   X8J7fXVsRI3ZTXjnLV6GCbgSwTyPOeoH6EKQ6GOe7cBzEQEm5ce124Sbq
   uglESV9UcQoP5qwje7+U4Cs45qo70bHmx0xgomCF7odu4ZXYhNjw0u//V
   TWb4cLAV2n7NN/3w0og5ATI4GAWnYRIJNxbz/eiIsnGLcCDZFVJNbg6Y5
   /kANSyykp8aC4H+GynN677lQi0tXnXSFqn/0LTTBm8ysD0LD/TAbf3Z5E
   wWbn3ATg1oly2L0RRGRj9TA//AIjz5xsQlWq+G+0xZD/ey/7b7EJU+NmW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="400029714"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="400029714"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:07:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="22024043"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:07:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:07:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:07:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:07:36 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:07:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM8lPScDFNNWx4uP74zJhl+b/8TOncQXspWnJv77kdB3dJX/FyTXRDtubDojKKmJcvqeR5LT5Uo5ZxdwlgM5CiMqlC6XDfiLvxkbW3It6OsGtMZL+ryh5Eil0MQvOeBlkHGA4OewRij/v1L5K2GsxIF9AulauCB0p4leY/G3+hBQ8Udy8WKmJlX9ftFHIKS7culmM5LctzoB//XJ1x1epo0HfZ0Cd6zmGijTJpOxrhD8GRNBBHKAJp8AH25Vys82BU3xW4PCdqVsxIIy6Qgt0zPaQLBtjgwUi/5PyeQZOgrJVqcDMI7M7DywSaqb+wLASAySpEyu/DmX8vKtGLyKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSmWSRKztonmMJBt7p17Nqw3I7Tb+RXbHKcGGILXgNk=;
 b=RCLxu8vbUKkJfcQeszAKXQhu0A5kTYp4pZiAQ/QIYvKM+vtO4rUUqz0dtS4m7R5Cs8NEdUx472bd+3aEew6PS9sogd+FQtLPmYyndP7rreSwgi9NBqGvUm10xY5xQzbZuhrLQhmxhFcZqWrapabpDAbF3igFboieMdh2QSqTbDWqVfFbgCblIlG7tugwZBMtOOSEp7umZdxQZc8GJJNZj+1BJAX1wEkehMiOZwPR042Bg/QhdS6dcvMFZ+MIJrqutatWfwUBckgumrRsAFLX6hFzZjPlc70DU/G3HR7EKw+TAkn2dgvQE8hCUjnl1QV50+ee+nYWZ/SDqTh7PMMiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Mon, 29 Jan
 2024 08:07:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:07:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Thread-Topic: [PATCH v2 2/2] iommu: Probe right iommu_ops for device
Thread-Index: AQHaUEbD/g6CTWszfk2HvsRysB/6q7Dwcw3A
Date: Mon, 29 Jan 2024 08:07:34 +0000
Message-ID: <BN9PR11MB52765D2F1B8BCE5C47D37E8E8C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240126105341.78086-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7718:EE_
x-ms-office365-filtering-correlation-id: a6dbcb26-fd64-48e7-7919-08dc20a1595b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOvXq2vt6U1zZZ/PQLBgfqRO4VUKFNwG8BEFweD1Z9MHk/xylG7yQjaUhrm689LgvmZIpJLzyvsJjbW4vtYb72oKyDbWZHNiq/KJhGeY+oUjX4nCTGblJiqfNN1Ss6uM/JEQU423GguiFTNu5RhKRi2bJvKqCVHev0n/PwkqG2wyPhdm4rNqlptYUYfkRdRabTpQxMSxcqlH9mtrM1lMcTgKVOHbbwRpayyWtZjxQe19wAMfrlTihHP3j6As/XMpQEXwOpGNwvKvjHWHCKL5dSec1dofYM+lFp7ed0KT1ddnAcclY1w4fAysnwE7Fn9wQSxh3gsaslgrt1agmUg6CfJCmxuRU6kVo39lAQLhwN5nHjSt4pWRuTKmN5cekk72JMqyQpUtMpOvaz32s9ZVnUU7JD8tx8FvIgHPDaBUudUhgANRICLpXNSunA6v6FtCP/peXX21BckRdqMStafUFNDU2GFDUgJeB5QbbqHaPqa22ylCcjiXWTi2hXDKT8SpfAYQ6KSe5RhZQzBKih94QdG2g/LTtnyCypQc0gaRrnTbGq8r0Z3ssThn+EGo++WOM+GsSMK8PW2eQ2lsU2mgcGUL21ukx4IYh1xu1Ldq3Ct0oythQ/A3veEBw/mdNN5R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(122000001)(55016003)(38100700002)(66556008)(66446008)(76116006)(110136005)(7696005)(6506007)(316002)(54906003)(64756008)(66946007)(86362001)(66476007)(8676002)(8936002)(5660300002)(33656002)(9686003)(52536014)(478600001)(2906002)(4326008)(26005)(71200400001)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XwsmKlqOInGgaiu59zU55kbBBhoCsLPoR4jbWm5MNXdK4v97aBgZAiLUgjm3?=
 =?us-ascii?Q?HOfkbAc3c+qb4EcplRwMY74/oImtDT+YSQ5+rESXA9gRolxWGJu3gi8LW3Yy?=
 =?us-ascii?Q?tI51o7pnfrJ62+7ZlyYOFsFni4HIjsSnXO3ZpgGVQ/QDgra53c6gVGlyw52M?=
 =?us-ascii?Q?5feHuV9pr0V1Z7Zz5ivxJlDitkBZADV6NuixF3mKcthX8f7XUxef/LfabDBX?=
 =?us-ascii?Q?/SL/8XXNSW1K5kJT/8QB2ZW7hHJkbqceq7wJGsTFA45SFCFzO2jF6aLf0ctR?=
 =?us-ascii?Q?7yR14BEYYfOnKWilMftIEEhis+SiTXGjuh6nYkE8TihSSUPV51cdcbD7+t0v?=
 =?us-ascii?Q?JVbTKF2dd7ykgpRmsvabV6D/sT7LzRJxlpAAW86YSbqdwOXxm+/YStvD9PWp?=
 =?us-ascii?Q?7b0YdH1zbukkIbx41xtIPTZyK3H8s7+/36VrY8z06Dkk/u6/NvgMqd2vilO1?=
 =?us-ascii?Q?XNBXSyTFpw00tcJ6q39apX8bto4Eq9a6NOs7y9P4PB6fv2d1uf0q+FukaEzQ?=
 =?us-ascii?Q?Ccl2j8LDzsa03jUkiR/JKbJQKCjymQuO2BvayTr8jo2agCfFbk+SUZAs/1XJ?=
 =?us-ascii?Q?xnvUkpxgZXEZV92mfFb6eOeHOHAisTh1WxpqQI8aAwFW6D+BF0xtBjfy/WLt?=
 =?us-ascii?Q?frbyjNG1rae2JOwc9rdEWki1uhIDLU1QEkURLnhQliBT4gIsMOkGSgEUhpRa?=
 =?us-ascii?Q?F15ZrSrW3n1CP9pI8ZMjvbfLYQ7/7m5TNkLkx/MqNq29rWAXH34umPkvpibg?=
 =?us-ascii?Q?xOByPI3Zu784/GplnfPJaUq9dVt4A9IqEO8tA4dBj083t+SwpDhJNYaMDVcq?=
 =?us-ascii?Q?tCVzURKzeFPf+wKcs5AJHk5fzhk/JLy1gkKVwC/D5dinKdDSPiWB6DN72Iz6?=
 =?us-ascii?Q?2p/A3zvWs6/v2keJmBBKrWrSEUNeMhsk3q4qRMstg3FIXGkkF95NLteiffCo?=
 =?us-ascii?Q?TIshGRAoS1K/U3gsbkvkMfSQqk8UEG/1pHlfQCvdwPydnfrUpPS+h7RGy+xH?=
 =?us-ascii?Q?afIHPneQsg1sYumIXUtiJlFU/GxX65tpx2gJPZTldmMKEP4BLGIEyGhp42ss?=
 =?us-ascii?Q?O27XE0E0RvxH4m0NhqLm9glIDrDv8ws+xZlSEiws/aVCU8w48muM4mIx97Mr?=
 =?us-ascii?Q?1QP32sbIOJdKCQGlPII7imjtW7taJpIlT41+IsDpRpPvS+Hb5Adiz6cCraIT?=
 =?us-ascii?Q?1dp0fgNXkdsDmxXI6NdhE0gPz5dxonXEtwZWRFosu67NLWcsaqB/o996vZM+?=
 =?us-ascii?Q?IOk4PxlT5lX/SJpwQxg4pP1yYxRNNHVZf0dd2Cr/iH67weRhe78PAbAaMURg?=
 =?us-ascii?Q?XEOQ8SCQytxzU5+vyIjl3ane5hEh5jKJm/9jrRyBDElq76qMlpQJSv34W9Bg?=
 =?us-ascii?Q?FkmgKlhSCp7WGMwpsH0KOaVPVaS9wPPUNle9sDXEcNe6h/H9F9M3KMf3tMlk?=
 =?us-ascii?Q?6dr221josUItfnDA3ljgT6jRdE51TSpX0YCPk3jQ+Z9TzT/wAqEzK27Rk7GP?=
 =?us-ascii?Q?vxp/O5/ciH86ea3NrQqJulAi0tL7Ts8epfvCwWPk88OXP2NNtPvCfVY9BEJu?=
 =?us-ascii?Q?c+E3Mnc4eM73Vw8ioE0yMgJwv6x+XF32n3rjCa5x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dbcb26-fd64-48e7-7919-08dc20a1595b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:07:34.0401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K52BO349Amq7rgeEemmF+xwopQtJB3woARaFC5LD+/EcC0VwYn39m0ZHToMBSAdlxpyThd61P4qOVfm1SzqDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, January 26, 2024 6:54 PM
>=20
> Previously, in the iommu probe device path, __iommu_probe_device() gets
> the iommu_ops for the device from dev->iommu->fwspec if this field has
> been initialized before probing. Otherwise, it is assumed that only one
> of Intel, AMD, s390, PAMU or legacy SMMUv2 can be present, hence it's
> feasible to lookup the global iommu device list and use the iommu_ops of
> the first iommu device which has no dev->iommu->fwspec.
>=20
> The assumption mentioned above is no longer correct with the introduction
> of the IOMMUFD mock device on x86 platforms. There might be multiple
> instances of iommu drivers, none of which have the dev->iommu->fwspec
> field populated.
>=20
> Probe the right iommu_ops for device by iterating over all the global
> drivers and call their probe function to find a match.
>=20
> Fixes: 17de3f5fdd35 ("iommu: Retire bus ops")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>, with a nit:

> +
> +	mutex_lock(&iommu_device_lock);
> +	list_for_each_entry(iter, &iommu_device_list, list) {
> +		iommu_dev =3D __iommu_do_probe_device(dev, iter->ops);
> +		if (!IS_ERR(iommu_dev))
> +			break;
> +	}

here could skip iommu with a valid fwspec.

