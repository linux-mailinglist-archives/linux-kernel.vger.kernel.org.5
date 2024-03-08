Return-Path: <linux-kernel+bounces-97504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADF3876B25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86237282E77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CB4779F;
	Fri,  8 Mar 2024 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ogb4CWqH"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2024.outbound.protection.outlook.com [40.92.40.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6173BBCE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925688; cv=fail; b=czQmMhgFzs2vLwFcAEtLfl/MlLetnkiMYPgOA/CswDdIlCYvXQq3kWc/BAzbK98bEe02o6IOfsg3hnu5qYnjIKCT7jwjJsaJaf8EL6pqugAIcaG212nNQE2povxuIyp5+RlGpo+UgfcAX1ym/4upfWj932xmfDhWQAhdNpnis7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925688; c=relaxed/simple;
	bh=GIj8puZjH5ZQMYAtSNzmkHIH1Dav9McpY0Jik7yBgEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIAHfyeMO3UnV2FWzjHKiTESp1vl02eluzYZcVhT3Q3iMGmK9ZvvEtEdlcp+hhwLO5aL2UbTg+njes0+ez3vbTWWm+pUHDA0EQ4zT5VANsefH3NPkDKIelEEAdDj1aWQhPxDIQha7o5aCoL+qAtx3PFSqeNZtPHsHfJD/A2j5EM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ogb4CWqH; arc=fail smtp.client-ip=40.92.40.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glvh5uByjZvLO1C8rgCy9yFfyIAn/xhWotzAUXchNOy15lel3aZCBA9I0wTrdEWTt748r59WKEY5fd5z5l5ywmQE2hPq0KnWARrCmnL5iN2hfr/7lYflR00c7bxYtZWIWg6RK05Xla1xLctg8272R/POZhwd2SWZNwGc5BbPr9m8uXZHWTR0oHolZytVxK0JofbCYoUp9GjVdO93LoGGt8mD8NpHISfhrfrpPzmhL8LkuP53f1Sx86IQ6kc+3AKpzlMH6Xh9aQTGbaSNDcr7YyKGBX03ubXKZ8qPIBIynXsrFKlpSdJpODZ+WK837MVyysFLr33o5f4DhxL3wRqe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va/VF07J3SNDOg6Kz5ztF/VnZWzioFSWPrAA/Dvpvb8=;
 b=LFf0cGraFwzGZQeePNb39TXWDVCkGqLn/fRMjiUayeAt0++4Xl0VhjuzyXTK28TFX9shoiKEv/1a4spgdsOMbZ62kHyNbxgzdV2ol4qvzbePumD+YYDqnNpzUIfpuo36+BkkBKsoxCO/KAGCLEEmrDxPHTqBl1EH155sXcS5y3RfADqFbOHi0b6k+1P8Le1orPesvv1RmWTO2HcaqqiP0qE8uehTeP9pIArV03fFcHBSKhwJ7/gdTX4j3XxmjXtcJhXioMd0Rmp8SNzxR7Whx94B7IeDHRqFXlsPGxV40hTLEUvIcKVd3KxdF2z5FrHvVP42QMbS2ZkwX/m4crFA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va/VF07J3SNDOg6Kz5ztF/VnZWzioFSWPrAA/Dvpvb8=;
 b=ogb4CWqHOwlgXUo2J1ETGUCe8NDMseccUt2O4VQ9BOO5nrODYZRKTBHiDmZLM5MW3ifFPTuwfi9f4jcO/Xubz/ZIdNohquoDLlBT0e/phGsB0t/B0k3kODTvSesLBVgQkZUyUG4jHFu+m55dVFA+SgutZKprtQZgTRSJvfzm4KwLAGq3Gjwf0wD7A+wASyVC2jSc1xwH4zSZqCUUTosFquqqNljtINtwx3RDyOwIhyMvlcKOWZPNuFs0jhrmXM6FOtAHa/hWdNs08tTDKdStr/iiWrkmcrU7rMO665dJSUGrYxqYJ9VxOM6AtbYkXgpmqOtFwW7s6om+cEZLHsTSpg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 19:21:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 19:21:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Thread-Topic: [PATCH v6 0/6] Fix double allocation in swiotlb_alloc()
Thread-Index: AQHacW1No1NKp7IpLU2beBr9mF1JxbEuM3Zg
Date: Fri, 8 Mar 2024 19:21:23 +0000
Message-ID:
 <SN6PR02MB4157A1A03F2F1EB5A006AF27D4272@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240308152829.25754-1-will@kernel.org>
In-Reply-To: <20240308152829.25754-1-will@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [gyhjEOirfm862V8uAT4Bku19e4wY6stJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: 19fecae1-0aae-4e7c-3a05-08dc3fa4f18c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SF85ui1505WmAspij3lD2maCwnxhnlFnQ57t1Hgn1FSzYCFpPe4g4Xq2KRMMxmVD4dL1nlpp4XqrVEbg/A60o7SznLV1rryrprWHBgDRbXpAj6XWp3SMIsvJz3GtuJupkysXemRt8zjhWUMK5QSYi4SCIHwkFydB11mDnl8XsPtLtrN/8fZuICckVcroRXgvh4vYhawVSWtoUNtv+NGVVBN4cydiUTRXq/vFZf74NWSCTG9MRv3ZokdbfP5rfAB72MoeIsG7oj+KBQMRPr8aLVJi2cuhVHdpMdN2MgoLTVh5SeswGZJR/uALPVlT8eYzWzBI4o/adsjO0xifRUYRcPSnB619nbK1DCoySG/rdx9iLthS46bqnTYlD+x7T7DpZa4kzFZYFwqSwteR58XWIAsoLDkhqVdPpvDWpKQKIEihqoB9rXrecKsUPc6eKT0msME7jUDyl2cm4iEqV19OzIWldtoZz3qUyVHcTEvyhaYpQr2uox8IV1rVUDtKMPnwh0M8lRhmni4s3jOuwHFnOJsrrlbUH2APS2Jw7F1VmYnJJGZ/aC60fN3r6Kg+UFYQ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s/SHTnRy90TtaSioQb+IWg/+/cF7cUqbYQ2EIxoxiuvcuhRNkbIBlRnRzq01?=
 =?us-ascii?Q?XWJIRKxUDUeiGRHXaXIOnEYTCBGlxFxburhcf60wpujk6Wx46RuS4ByOsY/b?=
 =?us-ascii?Q?iHWXAOMmbyA+uU8EXUQ4nPcxNX/otdfOlkR3jJGG23CbjYf0KH2s5gJlIpWJ?=
 =?us-ascii?Q?T58SGPNIFVpavDtvuIu7JZOOMBlI9jIBvALFRknVIDKEw6IyEMoCZB+uqJXU?=
 =?us-ascii?Q?Vn5uVy1axC4VX/4Dne/veYnr/y9stqjpq8fzzVSQRGiPsV5hRIYXPYpSOwVT?=
 =?us-ascii?Q?x2pnseeTnZRy8OO6LIqfU8hh4FT6lr6+LP8YNhXj30TwhG5/NVhzbJ0mdRW4?=
 =?us-ascii?Q?gX3lO1Q8XYDdddmMtyxu6+gEXZ2B2uOx3SDGJjb+6SJQG69rjPvxjBnGQSfu?=
 =?us-ascii?Q?yJaRCDeioMjSRhuVPJKv1ApOgGyanBR4RuKL4vyY1cH8zGs4CMxDFv/o14xY?=
 =?us-ascii?Q?m83yGjIH1ljq5Wn5eybVvIbycBvZpqQ7yGsTjRX7xhxNhVPT/G7k9DEklmEY?=
 =?us-ascii?Q?yHL65JHYU2legR6qVC/jsDZwank2KaX2bSs1kpIro2TX7luj5jk8LtFo5YiY?=
 =?us-ascii?Q?PcnaENbaDc4tVntTdJdI+fdyhHgjukC6Pb+oCv24hOCiyD10LI+MOMa4+eVK?=
 =?us-ascii?Q?j9g2UG+Fs/sJ9JMbrPfapD0lyFyKlwFpfvGSk5nX4bAOLlWx5h/vhonpC4F0?=
 =?us-ascii?Q?qTSL5n1JtbgA9wxnmjsAKtlKFD7b83axEz96wxsgsmNovz3xy7NWSBLEyjX1?=
 =?us-ascii?Q?MjL8H8iSUwe48euvmVUVZC9pQyviUsjroahCixk7allzX1o9ej96XLYuN3Gc?=
 =?us-ascii?Q?29OjXxzl4ET+ucFcosK5cqGx5epW5Q6gR9pquzbL4RSrKSEFRSi7MSBNdfp/?=
 =?us-ascii?Q?9K0bukGdg1d6ZmAhgQVvE/veyjUj2g4m2olxluVY3yBWoHiqfGQfQ+reRdKP?=
 =?us-ascii?Q?Dr2O0mfF9S4pwwNCQPvvInI/qjzkriM33bBSljL6LSSuGgVP4nelySdjaC0L?=
 =?us-ascii?Q?LZMlf5770FcHuecyZslLuYnGhbtV1VllMryqf3FELF6r/J7WnIqzEyx4sN38?=
 =?us-ascii?Q?k6heXbQ9l4TNSWtbQLAY5b4g1E78Q5Skq0Ks3H7EBXU2tZnqll9O4TSuS+cO?=
 =?us-ascii?Q?+HDDfl2PcpIgyVln43dJLM7zacErRyKbM9LojyW+qu/Sjj0N/B6ZP6OxT1JD?=
 =?us-ascii?Q?l6Ya7IYO/VAY/77S1Df8VvMqoO6CBxxmoYnavg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fecae1-0aae-4e7c-3a05-08dc3fa4f18c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 19:21:23.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249

From: Will Deacon <will@kernel.org> Sent: Friday, March 8, 2024 7:28 AM
>=20

[snip]

>=20
> Changes since v5 include:
>=20
>   - Rework the final patch to preserve page-alignment for streaming
>     requests without a DMA alignment mask
>=20
>   - Added Reviewed-by tags from Michael
>=20
> Cheers,
>=20
> Will
>=20

I've tested the full v6 of this series on an ARM64 VM in the Azure
public cloud with 64K page size, and swiotlb=3Dforce on the kernel
boot line.  The path exercised is the DMA Direct path on a synthetic
SCSI disk device with min_align_mask =3D 0xFFF.  I have a standalone
user-space test program using writev() to generate direct disk
I/Os with a variety of memory buffer alignments and physically
contiguous extents.  It's designed to test the paths through the
iovec level, scatter/gather lists, and the driver DMA descriptors
to make sure all is working correctly.

Prior to this patch series, some tests were failing with 64K page
size when swiotlb=3Dforce, but they are all working now.

Tested-by: Michael Kelley <mhklinux@outlook.com>

