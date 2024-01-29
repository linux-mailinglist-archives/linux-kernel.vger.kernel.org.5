Return-Path: <linux-kernel+bounces-42321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115DF83FF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD636282C22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E033524D5;
	Mon, 29 Jan 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9dqcRGE"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D09524C0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515482; cv=fail; b=MjM/uYDebJs/OUqkyZea803CKhwV2PlVe1Z5Ybc66EpuIPG3Pre+7hqsdcf3Hnz0+gvqo5Es9uiWzqXMANACPYTJPz6jEGIKWPMUCl7zOMBdMNW1yt0eSkYMbrfSOJKOESD0EcsnB7T18uhgdX3EgYezk89bVfHE4KWHijcnshY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515482; c=relaxed/simple;
	bh=0Ozv+dAT/EcnE6702UMLJVFoi3nVa4wBzVPmb+0CK/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X13xmVYJ0XE1oJytO1h7J+yOJWxpM74PN+If9dy4jqcv5en1r24u58bMElYsoOp6pupUvChjyvF3p9BVE6VoZ6DZDOQyR3doXgV+KL9PDp1gMNj8OxCOI3SmhqE42/bItoe0eX5dsFVME/QxuDVlylcQgp7J58/u7sJUQAsWkM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9dqcRGE; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706515480; x=1738051480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Ozv+dAT/EcnE6702UMLJVFoi3nVa4wBzVPmb+0CK/8=;
  b=S9dqcRGEQ5Gvojq6OBSfKFf8fVr3lcGNsNKoZAj9iLZLeLNgzazMFgRD
   lBez7qEjz4dGJQyfo/1P2hib5RCnA5o5oDVGh+DYjcw3nskoxJI1ujohd
   U1SxUTZ28KfjVuxLFYWPjMdkGPCG2qn4CW9PkffdHeMMdMA74SLThvUkR
   E9ZVp4KCApusvHQJB5Ow5Hyf55OrxU6Z2mtM569zjoagXecVCJ5Cvodp0
   MQ/yvHsYrn5iktlBXBEXEd15QUl4L6yq+bmaBE7RoODvLKaWmsoeuj3Ri
   yZRWrr5ht6VN0gBh4yuxE6TW4+VxUlonBmiIOP3t93sKpCoQmImrQolQ5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="406605848"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="406605848"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 00:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="29696401"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 00:04:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 00:04:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 00:04:37 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 00:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcLB1+Pu5jemqmQuRxw108JN84f4/Ka4XKEpnqr+Ie0y2ancEI6jE3SCAcxKSlJTu9vtNAO4Tp85ELyac7GsCwx/hvsef3pbJrAHd3/pWzp0RnxyRguS5VWPnCpef90K3nxeGPKSh30qfqQn6p8WqKz7bDp7dYE/9uTsqJUMNqaDgMz/G28hhCX/g24ImWaOjOs0Y9uQKFYVPC0Z+VMGOAgbOm0olltY99yyS9Y7Leo8V6iSsRXsgqSmkxVH/jeE4uA4Lmq84IsplUDzWOQ2SPEii6uMhgn7Ave0DXuATwtrXXC36gWN2J/2OpnbTUXNc3/8/6ZiTesUhnW4gUi3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ozv+dAT/EcnE6702UMLJVFoi3nVa4wBzVPmb+0CK/8=;
 b=feuOHCtdsw4JzriPe3ESa/q6s7t1p+A4hBav2tPZxZFMn7FlcXOSzUxgmAAowUgBxXinn/+FslEjHGSUFAV8uYDWWhBdHHR/RVpFEYBI3bUmVyk3DCsLtwzB4vM4JLzAIY8DsJbJSMeI89P/SwkI/5gr6djyXpBfp/DPgZCDaq5tbckpR/v0NKkFcaHEGOMzPfcyzuXBnSLESNMB+UGqRyT16NcLP46BrfuBtR/dGR499qzLWt0FisWaLbcuBvWdEn0Yuk9rQkYmc7ZncYbmtfDwKsTiJItUG3Yben2laziJggA/8IUC8gUenHOA5qAHYj+amBrZnh+Vr5dBj0JqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB7718.namprd11.prod.outlook.com (2603:10b6:510:2b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Mon, 29 Jan
 2024 08:04:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 08:04:35 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for
 iommu_device_list
Thread-Topic: [PATCH v2 1/2] iommu: Use mutex instead of spinlock for
 iommu_device_list
Thread-Index: AQHaUEa4n2VcxiKwZEe1FQQfY6w7hrDwcgFw
Date: Mon, 29 Jan 2024 08:04:35 +0000
Message-ID: <BN9PR11MB5276E9618612DCF4DAE0CAE68C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240126105341.78086-1-baolu.lu@linux.intel.com>
 <20240126105341.78086-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240126105341.78086-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB7718:EE_
x-ms-office365-filtering-correlation-id: 93600879-83f7-4a75-1557-08dc20a0eefc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlAP7E5fx9s3Kl07BRdY2u68qZAUc1d6hBXF+U7oUz7oaH2e+SgTGZwTwNR2D3/wBKX1VGqkWPRXwdJRJ7OyatQaG0HxTrCGyVuIN85B3sOiKw6BI5oREPsM8GHkYofT7qzPC1zXLhMhWYaSfDwYYmeThrrH8OPTdOiwbkH3jboDkIu+2pr+s98+wKedHr51bZuoIkxUkMUutiGAfRyOLczULbTUmGJXy8GZatxqiaZv1KvMY29YaYma1/JnB/GCkQSRlDfpiNxuzKS/KCF/zkltFkuTK2wk3e0n4TvztajuxlWw/keuJ1qGvu754q+i0pXzcCAVH6QuO9nUT4/8bp3QfdlRZil7ELhxgHvil/VjL7KV1jZIvZsOb2NE+358iGJZpdUiYTuEwK0NBeHtGM7X2IWPxm7J4QMZnfCpSk4RXbNomDjtm0TntT+4MJWVTgWNLMZzTU3kgxcB6y24XRDt3AvuYPY1UwesaD4UukdJ2DJNtzVLqa7weEUSCYYFspOogTit2dW+X1P0Q+pbqm2SqnL4/alUEVj1D9Z4rgBSs3clngWwnGVed3XGRz3OC1YNdk6bq4PE9KHbdbAPTfbd2VIt01hRTyIGiZMLgr6JeHoVACZ5vNDTWBKOCvGz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(82960400001)(122000001)(55016003)(38100700002)(66556008)(66446008)(76116006)(110136005)(7696005)(6506007)(316002)(54906003)(64756008)(66946007)(86362001)(66476007)(8676002)(8936002)(5660300002)(33656002)(9686003)(52536014)(478600001)(2906002)(4744005)(4326008)(26005)(71200400001)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vjh7J4xaLDUUkVJQTID4aqZ0pq09lSasns1CvG4wJ2r2H9LD9H5yxxc5oTL3?=
 =?us-ascii?Q?YjvytzyvqGQmtWbHGQD87DoLi2NOZpMTsxuQ6b8gNHcYoH0YrdBUflHDwTDw?=
 =?us-ascii?Q?qxGLkCuFlcL+XN9qQ1vLC9f0V/9GFU2CEAzU68OCb8kXSwmeSyXEJxNvNPQ7?=
 =?us-ascii?Q?dJydD5eOjayAQ0p/TjQ6mYQ1t5LHd+kb4fKyGxDmp1sNwpik6MWnMUknVyeG?=
 =?us-ascii?Q?qlGHetijKbIXR/rN+W3g7zoas2KNTb5ybYB3NihsdVGDCXisLabuUH4em1Wi?=
 =?us-ascii?Q?OyOBhmXhrCyR38M30s03wBnH35K00acABNS13EcZi+IzXRCH2zlIvzefLdKr?=
 =?us-ascii?Q?mUax66lylVv7hmtSCleZe/BZcEbGqKkQtspOddWFinHp1w8UgA/wxIXC//5R?=
 =?us-ascii?Q?YO5x4uOS8GVR9ztwxcNZxeBEIpoH6HSfQfhDvGL8xShSRJnPdQ8+DQ5toMon?=
 =?us-ascii?Q?x0U2xi3SbE8jz7EcBhmToZA1uwsrmrVbBRAC6Y+NYV1cLZ8CtHbDnnYAKrul?=
 =?us-ascii?Q?UudoWl3WYK/d7OO/3iTdqBcG1BI8EHZu7v9j8EL4AhiDz05QSRmajt2wf48g?=
 =?us-ascii?Q?TWIHyDXWqVMLAk9VbEIGLI+7HUmlvKad+iWCt2Ln/rV7X2IBelSo0PvA5DHH?=
 =?us-ascii?Q?njEP6VIdoR1jEGdskyi2+iZ71bOQiHrQcnhj8bWho1KiHXm2VObUAmU7lP6o?=
 =?us-ascii?Q?oAAqxNB8eVqid8TMErV/otvfB64S86zy5pOyhpRI/UjYavFwsftnK9W0ytrP?=
 =?us-ascii?Q?fZkC3gIYEJKmTmEGQc2nV/s8Ben0sZa3EfFX19Gxwp6NEXzo2SJlUonTFIV7?=
 =?us-ascii?Q?tjM52TPzhlpuNZTCmzhHE1ZD8a6Y6vvmKKDfrFOCU8gI2YSP2gmIcJJ8lH70?=
 =?us-ascii?Q?GGSrzIVnQz8eNO9qLvpOLHlA5+hEYLgdgJhUVvxjGjSPFgCqXUbTqY2t1Zmg?=
 =?us-ascii?Q?9lgIdoeraysTCn9Nb9O8j9nBWFJ2UYt/6DRxBjnFKTvQlZVjuIGLnDTB2vI4?=
 =?us-ascii?Q?bx/gorSJUi1u5M5xT7RcmtyxtYx4lDuTaCQvNzxXQEcp0oeQxR4i5+AHNfVo?=
 =?us-ascii?Q?B8ZgD5FQi6tWnxNbh7jcab/LNXedcIny8x1Mm0pY4X0au4A0mpQCfpucvld+?=
 =?us-ascii?Q?YAOGvxqIhn0zXj4AJOt8YYjEUz158I9Rx1BjBpjUxlB03iLUbhaoLGq8bEyw?=
 =?us-ascii?Q?cUT9c5UNp6BjxB0jkyF9HPO7QxQ+gAfHcYRb8QsIs8XybC8VPQjAAgu0j8j0?=
 =?us-ascii?Q?mPxaHVE7i+8nWy3zdnHKQ5gHIsdOvy3U4NcSGdeVMWrnnDm6dpCC03CtbtzP?=
 =?us-ascii?Q?f6JejPOL6xBB79TpLebEHUN8SRsCHT51nrb+0g1DGfdB4om0mlGBdjzK2/SR?=
 =?us-ascii?Q?f4pbn+J8gTxLECY6dxZ1lZ5/XwvQV/XFHzn5iw+9oExlsHXYtbJj5xCIH6Sk?=
 =?us-ascii?Q?t3BB6eWub42fL+ObihhZYUDZihLKZJYlFZ9QzYW1j2Ggv1+dzFhiqfNj4wRc?=
 =?us-ascii?Q?sIKSY0psyO6/uXDShtXPwk4o0BDlYwa0JKRKGutK2CBcgTWXIWi5AoEeSyKm?=
 =?us-ascii?Q?v0o6cf0SM6SydMjJBl6cLBrD3+UCHAfDoXDgVqbT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93600879-83f7-4a75-1557-08dc20a0eefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 08:04:35.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xZALkAUmJdof8fu8yXhjdHyymUpKmkeVuYrRvqzPbunEBPE/jPKverWS27wykpcEN1rwJeTXOLybqF4ETOVlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7718
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, January 26, 2024 6:54 PM
>=20
> The iommu_device_lock spinlock was used to protect the iommu device
> list. However, there is no requirement to access the iommu device
> list in interrupt context. Therefore, a mutex is sufficient.

I don't think that interrupt is the reason for spinlock otherwise
spin_lock_irqsave() should be used instead.

>=20
> This also prepares for the next change, which will iterate the iommu
> device list and call the probe callback within the locking area.
>=20

Given the touched paths are all slow paths:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

