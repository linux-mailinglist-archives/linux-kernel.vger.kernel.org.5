Return-Path: <linux-kernel+bounces-91514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31887127B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B83286390
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDD17C96;
	Tue,  5 Mar 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUUvAsMS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7517C72
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603418; cv=fail; b=aAahrh3Fnzze6Pg/+saXs29KKv6I4AH9qmK2tgVwSok3vuarcuiomKo0FJPDnV+rUOEwmMXZuHMOQvXbSfnKcXZGSIHnG5wMvcFNCdTm43hv27b6ZDxH5nEHHLCuI4Y97HWy4IWCax0n7ewdh+ugFBXF5Hv7DTJfhcwU0zr5xvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603418; c=relaxed/simple;
	bh=I76CABBfjMhzfFzN7FHmq0Ge0nHTqc4CiEViXdOjqdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rF0nnm0Vxgg4vi9NwUj99NSlVE0N+SV3/qNCzWvAOCfVVI8Ao5EOmknxKEr3wusncNLPQfeNA279JKnL4Ag2H+EMMnvu0Y01RSdK/wGd9x3lIBSoKjJbYlBU13/DW/Xz4IOR3R83cAfYS5cskINcaMwvAMti1a3/KxhE5CDK82E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUUvAsMS; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709603417; x=1741139417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I76CABBfjMhzfFzN7FHmq0Ge0nHTqc4CiEViXdOjqdo=;
  b=TUUvAsMSiKkvZ5buta9g5qu2wPNscEZo+6R0jaJWn3433q6CUPF1IMB9
   5WgieHtshaDV0JyWznnuMhAKHb/SSI7gfyb76Q5dRYeonP1xCiljQA+mg
   9TjSQbxKo5Yo/wdWeV2zuv/tQ1J95e85NxWhkNZJWXpZnePFyeY8BExdK
   WHCFPjRZAtwVMViAuPYN61Kouuga6M50hy/+hHIxZ0gyf5Nn7vJt1z8W1
   iO8Qhf3BjLHq1DiayNB6GnS+32ac6cf45GrXPp/eElXt/v7UBuJcPWfPq
   wDvP0eGyfS/58jfhUdh9/hkelRzXG/SnKI3dC+7puJDU9qKkew+LoTOKa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14850132"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14850132"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:50:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9156945"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 17:50:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:50:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:50:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 17:50:13 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 17:50:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ6Msd7sDrMVva+Gk7vZvQv9hjWNqRs8k0m3Z7veJxYkWMIsjqxDxszNxipaXYuxux9qChYytBFVKomNd0zD56mv6gl06DTaPBPk/w7/UtC/zh4iHKcPiPWhG+dqBZ9fOj+zVy3njEUTuHJZDXAS9BEZnJw8p7EWLBTHzhiDtdKdHNqD2+NRYQ5lDbU3Y3hcO8U6ymN4+Pdh7G6KlVXhqllzx5xwiWT9KQV5VqBF+JsF6hZz4bq19aUOdUbWfdpDuFHJi2ONKHn2J7YnTKzbZzlzfC3QeJjcQAmnWxF6PGOzrzK7gAFT5MIXhaZXOlEXNv3JmreaSWA8EOuGgN0dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I76CABBfjMhzfFzN7FHmq0Ge0nHTqc4CiEViXdOjqdo=;
 b=U+rNQ/Ihem5i8E1jpx/xCvYY7KWnVG8xbk0R0XYOQSHMYp1VzAP9bgUPeWbIoU1ikCj7qOebWyiAYLwS+YEihdyGAT4mZRVlUQVcFbuf5lx9HMS3+jZSivSq/U13J2bhSLOLzw9RmqCNfVv7edQQswp3+2yRDnG981LN8f+xMImdTqtHFMcRaMNPQT5E5xLZXwSKMBFudnNFa0HO9YkVQ8WvetDhDOIFL+N7kksUThsdVSICRB0VLBLtb04evbB6Mc0YcVw3uKS1fnRXKN7Pu+200R4YmJYUCxg7sr+WihDPrAQ32T/UhITv/qasBKHn1mRilkaTcowwMU05Ov1AWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 01:50:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 01:50:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Topic: [PATCH v3 3/5] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Index: AQHabp350YqpI+jb+kKA2bSryKFGQLEoYX2Q
Date: Tue, 5 Mar 2024 01:50:11 +0000
Message-ID: <BN9PR11MB527698ADE41D00838D94C0A08C222@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240305013305.204605-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8059:EE_
x-ms-office365-filtering-correlation-id: 99f49cbc-c090-45c2-24e0-08dc3cb69810
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PB7TxY+itVDeGsVcNbXUZHbc5TLSISD3OQDMUO4KBcIQKcwvKGd9Z9zymb4HaCsT28Io7s8HGGYPw3oEmh3olF00DF1yCCDHbeKwCzjx7rJ4lLE32B0sbuvm7SRwdcJ9WoYNW2Y/+hyS3TZaKDgJwSwd3+mFald25cH0XLP/B1uVy2rg7PKKqTj1DghSb26ySHv4py0oDj7hxZrdq/u1Z6aa9S+fkcXPUs7NV39kPTBRpq9EWScFZSP6yWg3EZvWxwPTptqLX69ymw3qLOLloIaCyNpZdvXw79IwD3afNxa27czoRne00rmadB/u/Ab72aeFOgZ8BK27o0g18lv6gnftZH1XytZzfIaKCA4d1kXhv5TfmTqOHEe9+zqC3pB5Vmc85uU3edR1ub6I/on9wPTEwQYb5lb6f328csPVUIbS9Lx8Hrrerog8kRMIkaAogmXSO9lrTwNwMZF2T2TruY5jEpjr4yDLfR7Yoow88EJVeCYM30vC13qpTJDjDqMFjw1VZxMKVY8QmmGQhffG7m/V1BrQ9tgCb25T8RarJxNdXKrBtPBq3j3f8qcLZxRnAs5tQ9RX2qg6S2DvwvIntHDhywtDhQIK8XFbpRHz47/3K5PmNw761S+Hi3PatNaiEkSgYpWkL6RsVrNH/bcsmoLJQ/QXv81I7hhSasQRVPnFUmShcBPoglGTcD00YSMIRJTRV2yPX399GeMk7uJeW3bBEpYEx+O5LzHeihxkcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFT7LPs5a6eafUsrtuejHHzNGSTt79VsxfhFdYpGeBfqRPbJ+KLmKZhxH/62?=
 =?us-ascii?Q?mAvAjqmPRVeBJwdI5pyX7a5xiU+82l+w4T/oqcasGx4UvFOxYisuKrNh6aiT?=
 =?us-ascii?Q?k3Xl9Fa4YMZgUL/mTZF4JgNpKrO41O3YH2pFjaUmnnXa2Do/7jTQqY2dZuho?=
 =?us-ascii?Q?yMRdbXFx0KJoLwpZJZA9eC6N5c5EorTBhyzAhB4mksTxX5Aw6xc71N9HMoqh?=
 =?us-ascii?Q?IBHCVPadVOT0KyzRWojpWCT9my4ug5fRKDvnSAWPVz7GGNnBO/JU02TiEXPP?=
 =?us-ascii?Q?f+jWDBbUJuos2kR0rGlnlgFkDbLBGU+STvcHk+6W6cMexK5R6FpIycwpn3Dw?=
 =?us-ascii?Q?e1pcLeOJF2KcZytceB9mZh4u7b9T2SXOoremIL8GCO3kzIDgjkmxd+1ttUk7?=
 =?us-ascii?Q?krpS9+jDa0LZ3LxygKtJ7Ox6r5YRhamfemKRo8obcpWUfNLeB3960a8U/IlQ?=
 =?us-ascii?Q?C7BpEASTmHYWw87Al9e86UiceVaB0i3CDzi72Ln9rRLPh5lSS3U7FzQbBIZE?=
 =?us-ascii?Q?0+4OBXT/gNEs5KkisKRFYjLLCzzBxt/HRNUAdDxpKgkZ7kyjmj+rFEZ1WBuj?=
 =?us-ascii?Q?3IVKfd5vy0k3xBjhr+qH14fmD0F1eKEkZ779w4cfFzkFFJKogJc2OPnlC5S8?=
 =?us-ascii?Q?rTXa+BaUiugeDlZ/LmF0J1yINfjj3Hq4V3kWs5fVMMYhJstTaYZMmEXiHB9W?=
 =?us-ascii?Q?joQ4QAdlSxSKcih2ArjH98tazzrFeN4Fd+20xD7jW2xnLuX3iAkZQY77OwnP?=
 =?us-ascii?Q?OFSIXVOmIkWbWF5uifQIqknVI8dA3wcm34LZVPNbimTNgnY/Zs0NhnzcHgRi?=
 =?us-ascii?Q?FPPK4QjlkFgNy1b+KBWvakv9A7WPSfHWn13LJ7bNmfRkxvdrm5DPhb+OG94j?=
 =?us-ascii?Q?PhVUO0CevshTqcg5r8ixE4B40tRl0qN4Mx7zDQqi3yVJFzvSeWFEsvCbWCWn?=
 =?us-ascii?Q?GJlIzp51VRmkbFWw1C9wMf3HY7Coee1YDcq1PHh4a9+Dc3GhSuC/wyx32ebw?=
 =?us-ascii?Q?ef8J1LuvUXRH+Kn8NB68ONZ6YziwTQb+AhbQy7IfZE+uCa6kRxqKpU1THnL+?=
 =?us-ascii?Q?ujrkFEHD2uAJj+U+VuHwMtxAJBQ5oJ2oKz+1Qt0Ozcy0bpgL9PkESmiHiYS0?=
 =?us-ascii?Q?SQnM9VQkjH4H9yvzhdE9NKWWVzQuVDJ42JgQit+GTM3Emc+IZKUFtwzm8MFv?=
 =?us-ascii?Q?0PgfNMo1aFqEoueu8EMVWE3ghosRvY+oz12JaZcMaw8sknZda5UxUlKmffy1?=
 =?us-ascii?Q?JBIHiUoUh0RGvGdTUSdqeqDZzwQwAGyI6QbXPrNGSG/RLuekyp3HABd9km6Y?=
 =?us-ascii?Q?yeWnKUA4IHZwc6vOair3+XMYWgLm8qPBvZB7Wq+f3tk8mAqQSkPwUQm2W9WE?=
 =?us-ascii?Q?VYddnylY+mpA8qyeK2y8HTqiEClBU5YPXhbiWg/GCYE8V5Ng8meCXA15wMfV?=
 =?us-ascii?Q?nqR43sNMB/RNwbrg2xN9ddNUELjSN1WD1S9rPgjcFOewXb5aoFuiZOHveAL6?=
 =?us-ascii?Q?52HaPCHtRJLuoVRKZs4vkioTahIedejv97MQhIRt1KtWWCKz1zOhERxtzrTu?=
 =?us-ascii?Q?mxmNStEjwT1yZdPROEOiPpIamQdzjCk0ij/+md1Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f49cbc-c090-45c2-24e0-08dc3cb69810
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:50:11.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bPfhSuC2Tm6UfIk84cbQiSotSb5vkKcUjFfnlsgRD1h3HRCGqG3ZLmqOT39XKnZAoXT2M8N6MO0X+BrpDDVs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, March 5, 2024 9:33 AM
>=20
> In contrast to legacy mode, the DMA translation table is configured in
> the PASID table entry instead of the context entry for scalable mode.
> For this reason, it is more appropriate to set up the scalable mode
> context entry in the device_probe callback and direct it to the
> appropriate PASID table.
>=20
> The iommu domain attach/detach operations only affect the PASID table
> entry. Therefore, there is no need to modify the context entry when
> configuring the translation type and page table.
>=20
> The only exception is the kdump case, where context entry setup is
> postponed until the device driver invokes the first DMA interface.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

