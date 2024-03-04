Return-Path: <linux-kernel+bounces-90157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215A86FB24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27319B21004
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C32168A9;
	Mon,  4 Mar 2024 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXJN7C9Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53F16436
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538844; cv=fail; b=raWxSeVCfRyL9tJOncjiYlXD566DP+eTK2h58Prb70OegY7XdEEAZSrVj/Upww6WkG5qeXj6xlZIJP+4/O0BUNuyb0h4dyAR+IJXNV+bsoBHbpA+SrYp3AowxG1scl2gN9L66lZqiM2xbhrWa/Mg2oOhpu54MWqNjXoMb14et6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538844; c=relaxed/simple;
	bh=CYQt8B9gr65gTBwEQhk7pA4DsqeDaAD0LI7gOiaA/lE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkaj0jxavzv6fyEGAvDgzeCQILjn3mjGEPXiPGP8x9bVoNcBoTpyuu5dmVDzYUadl6iMHPphVpYa3eZx2yUMhgy4X+VheTbuxJkq7jTxf0rp4+2h18ZrwYWP3x3rASq6BjPTg7xaU0824CVlDA+sTLdNE21NkFem2khvNkublys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXJN7C9Y; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709538843; x=1741074843;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CYQt8B9gr65gTBwEQhk7pA4DsqeDaAD0LI7gOiaA/lE=;
  b=JXJN7C9Yno0dF21V+PG5aTfPFIv57NXUjoL6CbmUuZh5ym/YH8bKXkxr
   dbU4Ker6rMljXFTRtE69Tvb+jYW129wIbN5iVjILuYvddoaS2jtTp+lzn
   vgSN7Gx4lLCirOkAQI+mrVZUpNPSm/wAdukYkz3XMUAt0qIjySscM92qG
   ZTee0sVvDGgoW0RUzaQQQJ2AnSxoqQR2r3GTZ7W99eMkj7It99OFH8iSm
   v19wg55WgHU7v6T5yXontwvKiUjJ3q5Y5TImpuAYr6PsK56hIaHszTAc7
   TS9Bpfxb4bLawKgD+mQA7wLkx6TiO7C7cf9h53JhEU3W3T1FoW5kmSV+N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14659077"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="14659077"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 23:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8973099"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Mar 2024 23:54:02 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 23:54:00 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 23:54:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 23:54:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsedQHBoO6YkYeuDFeuxjNNX1ArpRtYs/8AB4dYdfVitVXJ97e742RUX4zYZUG/8zUPg/85sQUU3V6Ggaq0SB/3/fUrM3ewOgkEDECQZdDjp/Ma6J7EkBZCS8F1HCr2vPYX4hj8Q0/ANYVGplqu13/ngtaBJac4LwOqSHhgg7E7j10as0dlw4q3uYq9MA5V2kl6JXMB9ZK69lW+MguKOjOyzrV+bVjdiTKJvRxAAPJnDvfFpKuQjdELMyseFOrYj+l0/y1P9MDGYhIG7URLVWq32UdRjV/rICIL7A4k0EA6cSzVk0apFmL38p0EC9TBd2zLYoDewdwzv4i5/b+j8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u0hflfSxjWn4RcZTye5/2a1FAWNr/zGBDbU+8GmLKo=;
 b=KRMUnfj3BcbmMtKt57WWNWNfTGtbfoiYTJxWyHKfI3qbOKFNN4Qa52F6vwyUgqioq1JyolYy/6l/SbBr4RugthzK7Uo+1MyJJ2tpPS3u4nTanVBh9HhemQoyj5k3apFejbuR9AcPwOqe5reksqnfQ6ZRm/W6oSCV8vEBSbVXuZl8DaRnwQ15fmyLHuTDUtelMXIBobGbPehF60r6CZPpnejoJHZmJtTMPg3aDLdK+i6nNmbpcbCq2RWGm9f+Q63BQV9OJdV3dI0l9/NEp8KKNOCnB76uCVA0/d0vPR0IqR5jjtvy/O6paa1yp/i+RitEzs8u+raRBSTAskXh6Fg1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Mon, 4 Mar
 2024 07:53:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 07:53:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] iommu/vt-d: Remove scalabe mode in
 domain_context_clear_one()
Thread-Topic: [PATCH 3/3] iommu/vt-d: Remove scalabe mode in
 domain_context_clear_one()
Thread-Index: AQHaavVG9VITS5BA3k+dWXZ9bE9UH7EnO5Jw
Date: Mon, 4 Mar 2024 07:53:57 +0000
Message-ID: <BN9PR11MB527694903CD8E8FBC6C1FB168C232@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-4-baolu.lu@linux.intel.com>
In-Reply-To: <20240229094804.121610-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7600:EE_
x-ms-office365-filtering-correlation-id: 095b3fd0-9b5f-4a97-0a17-08dc3c203f37
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejyvIexRej1dDQxLgtWqqPhsGgEcP9uoB9/ZUqBbWossUcUt2zVvuCGQ5UjRkL3oOksY3Oh6fk9cbZcPgWGwgPM2hlWqRDiPTJe23arq/Z4f8kvSpwTvfYz9jzbJsdAKhP7X3YEnGlLL+S0dPxY/omYotUAwY0pFJhxf9CSeXWljWwElcXYRG9Dex70bK/Gmzyw7EJ2pmNAjdNlvHDYJ1soge6zel0laab5cEZD71Jz7bn+Q5iV95ruD50lU87PFDqpCb9zkNkIu+OuxaojWaIcOPgRKTc9KEI8y1jzs/g3PzvNlrfpkc3u/T+cUoj22Wrty0R8uEOCyfM0JVaUTUx1XdvA9dNWqHibmIdrvf71cXXVN21HcQUKIYLApS9BlsivOCyyGQuE1V2DPVGMsC4OFeKL5PwUgdIINmZ2Ttq878YU2HyhlVnzu9hfEssT5LIXIWbO/O/qqS6BxBrTKuvUETuYRYTGrYhOU55HOUKZUdfbbSkD2CXovVGMe930MoernDFsomxpvW6p7/TVaSE9H5p8H55yrAePOi1+Tju7QHU3get7hOjSH/YdovSgiBPegh1UA02vpX2g9js4tT91sJOeA9YMe2RinFdffrmsAl7wzVkV3tNhiyjaWU9M5WPNnToZukRXJhOShSLg/vH6a//El2uFezxm6Wir+lQiLVQ2x7XRvdtjlpJr4VoFuXXyeA1OPKZtAZHSuAw0b8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iru7UgvDNm5E5x5ZCM5BlfnAoLFXc20LZXdLqchrGiXZdR8eoUCPpqbkY9JN?=
 =?us-ascii?Q?TcHoVjCMFkQhycMs9GY8JfLNixiwUFN3kKDnNbLXptZRFKjxVpC0+tGIQM38?=
 =?us-ascii?Q?EJQqknM2hxfX+antE11xEgYneKkUd/AgoKUKsj/3746FqP48s1T0UXrUQOI1?=
 =?us-ascii?Q?Cuc6P+vNIQfVP2OphJSx8hkNVW/9gmZ+bF4fY+r0BA8JQkSQxB1NOFOdjTWl?=
 =?us-ascii?Q?0sBNVw0JievwtJShzuKOdxyiKq+pFEOHpr15kUTIuBwGGK85wXU5bZKqlX/D?=
 =?us-ascii?Q?unCYDgpKe2tNG2p0AoP78ivWLA0A6RUZgVQF4PrH4a0ddGHlpNRM0YQehGzJ?=
 =?us-ascii?Q?ylAvHELxkYQ/uBSv3acLEPUblyr4vZ2TyZ/A8WQ/ZxjmYMymK0xd74xSRmUq?=
 =?us-ascii?Q?7IGjPLWssHB/YhMvaZLkN4BFgIqxqTyxm/47EPtO9lIfhAqcM+8r2dj7Mqeg?=
 =?us-ascii?Q?NixyU7inMnMnF6XsIagEKdDTJaln/S5SzTT6aoNm7Dz4M/F9J0Iz/zUFniqQ?=
 =?us-ascii?Q?iEdlrh4t7RlDPP6aTAnk7AHXnEKL+4yE5tBxvMzH8HR0hM4RpP8Ua3WPA/zz?=
 =?us-ascii?Q?N+3SUYPssehkq6sPpoN9cCurEIPCVktVKCoujyC9pYSbfQY1p9UIuJlGyzNA?=
 =?us-ascii?Q?BaYlRIKM8Nz42VCULlUPUDIz8Ae8A9k5xebi3J6c5EKbwNywQf5A1JLKR5lA?=
 =?us-ascii?Q?H/Sy2+MvvPikLl5U050psJ07cVl/MgjhO62N73kqZ7GGQA2xLwMkTdChPON2?=
 =?us-ascii?Q?hipmVrJIJMfYEzB4tyAPnd19qfVcr43C0ytbKq8pvzMynINmxAZDZgMTDPXX?=
 =?us-ascii?Q?KSmorNTwX4ljnYwZJa8SX3IbBufUdASnCikDh2xo2zVeTeg3eSWRmbm+FgM/?=
 =?us-ascii?Q?98bR9pEDwxpL4g9oFjGQBriX+5GOYnFN/p3Zx5TIOaMZ3iydFfGTuxB5Lvnq?=
 =?us-ascii?Q?exwh9FFzrrHv2VsOcazA/1QqONWc2BGRAXNSsy2iiPtA5fs/S+73sRMpJyAx?=
 =?us-ascii?Q?7m9WAJDMkJY1OtrdAU4YU89FzDViHB4/yRQzwpvzXHaBhrIFi3qTfaO3FBEF?=
 =?us-ascii?Q?6UmbC4dyVE6mo9JHjlz/sLSpxZU/fuXagX/6St87T5lOKgc9qbChjbT0BkkX?=
 =?us-ascii?Q?9UGBTBJ56lG6jagUit8AfXwOLRC/mP9y23k3bJbOmpYmZe5Y3KJLs+K10+YT?=
 =?us-ascii?Q?mzDo1HUDSFWIJOjPFvuSoGLufXj0sZlrOJGiaLxdWF26n/culdVB3EH07VAB?=
 =?us-ascii?Q?U+rhQsGyu3KlwvrdRrUN0XcTc7xIzA/S1pO0jWvRIAymXYSDRlaTri1yAtZI?=
 =?us-ascii?Q?DwANI7POIZaHqGgiABWVcbFDWffuSBM8Aj0jOh/HVjl/uvxoUAFcLzw/fqvd?=
 =?us-ascii?Q?BTFaQYVbNC5DGeb7B/NJBElBlMDkKgJNoaq1lv2B1oR9Wk4rJJUQG1tWqhLu?=
 =?us-ascii?Q?BtPfRmgH9HZZ3RWXehEU3RaUkD8fJRHm0kA/VuyQi4xKfDxShTS8e2Xn+Lyq?=
 =?us-ascii?Q?Ay2IwQ4Xg6Iegfo3qj3eM1a4vvY8EXVyxJDvLDMWfYlVnmfc1YDx5CeEjVkM?=
 =?us-ascii?Q?B2ndDGhCaTdJzwN8+4sgiL2Szaw0KDgMipATFAgb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 095b3fd0-9b5f-4a97-0a17-08dc3c203f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:53:57.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cITSSgFxedM+HHcEXboi800yzZFi3Fh0tl9XzPVLf5jLOaEfzD8K3w/W3Z576oziAXm22b9a3T1yZYWmUSyGnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7600
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, February 29, 2024 5:48 PM
>=20
> @@ -2175,9 +2175,6 @@ static void domain_context_clear_one(struct
> device_domain_info *info, u8 bus, u8
>  	struct context_entry *context;
>  	u16 did_old;
>=20
> -	if (!iommu)
> -		return;
> -

is this check only relevant to sm mode or should it be removed for
both legacy/sm? If the latter please add a note in the commit msg.

otherwise,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

