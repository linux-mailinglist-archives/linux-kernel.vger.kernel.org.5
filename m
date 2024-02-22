Return-Path: <linux-kernel+bounces-75899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9E85F072
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CFC2849E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13431388;
	Thu, 22 Feb 2024 04:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAbIe6Ne"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D2382
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708576357; cv=fail; b=CtcLK/HDb3Rpt36jat74wWIsAUa7qc0eaVH0TU6lja79JBNNYRuNfWA9ANEmd/TduXhhLLYf3YJVoFc8SlQkNcGFVo5JhuKxxLVinW+DmaUe88W3crYSk7aMX9+jn1b9JdWgVFF5kFkdZtfJGREvwt8uVi6sJm4aqIIGb4twOjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708576357; c=relaxed/simple;
	bh=h1qFuApAuDWaztrp2kyiGUOrKSymz1+v2KI192TKYxc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J2tWFvAq4mRM2/yTimllrroRy/Fg+Lc+ZrrD642Krzg1nVG8ZpBsxbRvIUEIUSOCa23LO4300qi4RdOJyCVz6c6FVI+JnbHANo/K22amOH127eZwH5K8j9B31xRceayHZVmAzNfEBCiCBIgwp7R8hFJdUv0kIhRyVc2GmBF+6Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAbIe6Ne; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708576356; x=1740112356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h1qFuApAuDWaztrp2kyiGUOrKSymz1+v2KI192TKYxc=;
  b=LAbIe6NeSkQ55NENEZUQEjUekcU0Fwx2ZQkak65PStTHFsETvZM2njw9
   JMt8sNSBB+7PYHGmbxsOJ7NnYCn9BcmfA1mUIiTiO9VA1jzOD2gujaZdi
   i5pAyFBZKeIcOmP5Rx5FIXEMTL2RXeR/8w56ZxvG05bYLQy87N+OQd3vB
   wp9UxUTauoW11Swif+tnj7iiF61JQfhhlNpghCCpxNW7mMj7xO8gYQvgi
   FpM9hYodlRLgwGqYqs5bBYbAqJGk6N1SgyKcPBquhvR+KxUBdUEkdYFbB
   J+X4ehM2aLoEYVqBzRLmk6vl/c4RBL9Nv4CpALW5DV/VwsfAA7oKaD8P7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3270541"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="3270541"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 20:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10041769"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 20:32:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:32:34 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:32:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 20:32:34 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 20:32:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqZTFgh9wg3EttQffeKYHLJKVaWhx1AFYMOuXMI/MUcps+rozAmiWsr5dWhs5tAc0uL7gSK3x8IQKeenMZ2GeRSY66Go7R9GL+EPrRd/n9LQq0lFVB0eBFg5QjjihbtVldHCTlde+pLS5kG8zN0nYLE5RJjN4btC+oKCj3jW1DLY03hVn6gMZrOPdffjue/c4EgVpGrJS/elWgtelM+oSft/kxKBHAao32e+S0hl/JqH1nZFngeQBoccBpvOm/zvtXZhyQHrH8lzOeLUjeQYBE9botKdM+qgRPTuyVy1buq9e5X3JMKWKPuMgc4zMVbKGyxjih3XsEC+0rbHLGJ+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSCLkU5UYCNppZJK8nFD5Fjjdw4aaK4W9auafXicNyE=;
 b=d87SvuPb26ntMwbfBx5p4B9lVA6H8p33X56KMqRZW9toP8tTDAsJbe7LIuoGGLnGV7AuKODnz2BlIhYMJ7jZ274PH4+DLjAppdqgI8s454PCGxcse2IbWtweM5W5aTUrK0wbvPPcYU6VHbp4qiIvPplg9YyI+3nebFy/cjJs/8UMZBA51p1DbaxD9liANCzMdWstEp1Hwgg32tGFYV/8qjCv3XrpQaGQHmZbXXjnIPkwuCpRHGqS/q0UOnyLcLhgK/UOk0e2O/H4MNG+sHJoVmdI2B3JNKm+6wS2B+PijKbkyXOXeh6Y4bAXPqRn3A7gIrHfxDkv2sJBV8s1HpU8fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 04:32:31 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 04:32:31 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2 3/3] mei: vsc: Assign pinfo fields in variable
 declaration
Thread-Topic: [PATCH v2 3/3] mei: vsc: Assign pinfo fields in variable
 declaration
Thread-Index: AQHaY24Bk28kLcAL10ONhEVbO4aOPrEVyROw
Date: Thu, 22 Feb 2024 04:32:31 +0000
Message-ID: <MW5PR11MB5787B67F0BAD9FA6162042578D562@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-4-sakari.ailus@linux.intel.com>
In-Reply-To: <20240219195807.517742-4-sakari.ailus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: 79ecbdd6-aa2f-4c66-5bd7-08dc335f48b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plns68fkJEzB4l4d8zDRV0VElhjaHq/8YcXZjcXoKPVPpT6pu9ojiEzJPzo9xtsjha1s09xnWmZTzcLyMpRoHdsyTYEpytuGXSxQWYT6ACzl2s+8mzHPF9GRrcKhyUIn0onQJCKZjm6LRE/dbUjF7Isgv0UmwPdPJyHhvOuKyoOKkOMPTrVySRfw/SEuPA9PSat58jotSD/cOpPT4GQtjUl6Bt8rvRA9LW1/qg0zn61D9TCOhYyTSf1TyMefhYTCQ8krRBNV77cd0kyOq6Tq34ueSl1Qc7+8LROgXmAg4kou44s/jejOjSbs8Xh5R9aAZxajr/4iaC93VEv9Hup+AqsVvnFPwZbE4hgeu801Dnth/gpR0ILO58fDa7Xv8/Ma6zt6SiCZzsRUYOSrd8pfFENh8KooHQNGPx+CgkA1Rai4fGs6EjY7OvREZPBiRYOY/+VTig90iLg3dXaWFCnMIGpXS2VM1n4r82ecRI8mBCaffd5sL/Q2zyvwX+vmOwxwFGB21ZR8WV9dr4kADB0728HoUsIpRoZg0qfsty5rCWnjcKQnlSGE7Sg8M760MTQtdLpCwACIUNR9LfFRg822gzjt8HNcNjCMdhBABhRNyJs5FM+Cd/JQAz0/EF58gtao
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YVlzI5uwbG0WClUtp7wIRxQdl60z7TuW24BKxQREFu98/2bNceNoWm4ioM82?=
 =?us-ascii?Q?NC3dIz2mGsTTW7SQwpIuFAnZNkGnRRImF9UgUD5B3eZk+HpTLq0CyLos5DX3?=
 =?us-ascii?Q?AVzG9Icxu0BcaC7uQhp9HPexyluFYuEBDiduLPCc2aYjg2S4lqFLwpshf6yD?=
 =?us-ascii?Q?JBEAT5853nWJapSYv7UnYGyUt0uO/wQP1c4XIX9Nxi5/OHSWk1kC2sGkoLn+?=
 =?us-ascii?Q?IrSfuWg/wQ7KSwfrKCbhRvHF5rMu1/J0YT5mDua1XMoXR1jjRgsfPaGkFbYb?=
 =?us-ascii?Q?v52c9UpmGgYkQxdGNp6rFkpVyQd+R7XbSJ02gqK0ceLXl0mX1Q1EP+lW/miH?=
 =?us-ascii?Q?UWzVIhopfIJVHqr2dcduGaKPtcWSeSQLaid6mGx5pLnJQcwqd+tab8qgcDDW?=
 =?us-ascii?Q?aNjs3A6bNYxdzBLgzFRdYxHkL6eeZtuD2z9mmmZC3gPCP7CZINa0pqLiJiNc?=
 =?us-ascii?Q?aBEHNPFxQ8rnkHCLh6YS0OIxryNdn5oV2mOwmgzms3E8bdkctA93mgvIiqDe?=
 =?us-ascii?Q?EyOQtkWV4rOnWEccdXf5zjuNG1uMiABHTqilAGaOHAzsvI7Z8beHYDKpu4ji?=
 =?us-ascii?Q?ZBQOSOZZu7lqX6u9ErLQRRJMkJxF1Njg/iEwoJ+iY0DjZlcjH9PKGp/XX8ka?=
 =?us-ascii?Q?d/YbObCIE7SNX6NC/BS0dKRYxVFiXXu8/ICZXEWW0XkjDPSOF2BYcrzMYxEo?=
 =?us-ascii?Q?S9k+GIeb8gDlux6aZwnyPnD7J4na08s5pdMr7/6k7QeQQJxgjFdfkerwzx28?=
 =?us-ascii?Q?9ddfavQKKmhVFCYJ/pIVcbqAIB+HlZChODF06245WQS+STEduZbPWBB6Fb1a?=
 =?us-ascii?Q?hMpe/etlGVh39VjoLTZ3dF91st0HmxsS3odS14IUTZ6hnPjhh60vZ/7WMbVQ?=
 =?us-ascii?Q?M7u3LhUA3Rm67R7WuRjGF7QH4EhPj1qaebUQCQ5LcbPreGQgJbW1sULx4V2V?=
 =?us-ascii?Q?q3H7FrrLo9Fxkq4gmS499CMstVsVdDYGeQsfplcg0K+FEIOTypMCtvdOt7aj?=
 =?us-ascii?Q?uJYVF0yRoiHgm8zL4X5ysAflOTS0dXcQR8pI+LrqYwGsYbDXLe9hnv5GY0lL?=
 =?us-ascii?Q?MoRVEcXDOoW5w6uwspJ47RdKeZLpA+r5Gzqc8/iz3nAP2NH7udPZbCaojjH2?=
 =?us-ascii?Q?oBeG3w9UrF2ZMcKeNe2V42LUUsEVIa3a8uBydccz0UtYDjw/p/YdPqY+a6Ak?=
 =?us-ascii?Q?Sx9ofimSyFox7dhlwehsTAXlStvrg0jLDK4AN0IIaVo8dt+no2s0uHrX+Dd8?=
 =?us-ascii?Q?h8RbrSNaxTayzQColzIX2pevrBmgQF/xX/3DDcrgSX3PmPM130hvCLivA+s7?=
 =?us-ascii?Q?TMJegYdJzWur7mO56aVM1OiW+nF5bx701NxFdJysqNC9E0xx4lgEwiXt75jE?=
 =?us-ascii?Q?cbWl/TEbhcCk8GXaOtvo8v/Tt/QkQSZTebqSUP7Qj/gbYiPazuvHxiCqC0Yq?=
 =?us-ascii?Q?2pIw8gXdXElpIaiV3OtUkeiMBEjN1TWLRr3aYoBXSZgVqRt8bVlsi492v9iy?=
 =?us-ascii?Q?mR5NrnWLZbALkcUNGn+mYCFuPlu61Yql2Wh2mcCOz7ip0gGYwE1nQ32Sgdih?=
 =?us-ascii?Q?TpXC3qjIdDUeMFfYQ2dLxhb86OQKPzCIHCGoYpsH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecbdd6-aa2f-4c66-5bd7-08dc335f48b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 04:32:31.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JRuF3rVJvc7xDrYvOgEyf5y10Q7t76haHKeIMavi9VjFmcMe4c7BG0gv5ocSTl8+Fa9Pa0CXMQ9eFcAgCh8tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>=20
> Assign all possible fields of pinfo in variable declaration, instead of j=
ust
> zeroing it there.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Tested-and-Reviewed-by: Wentong Wu <wentong.wu@intel.com>

> ---
>  drivers/misc/mei/vsc-tp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c index
> 7b678005652b..9b4584d67a1b 100644
> --- a/drivers/misc/mei/vsc-tp.c
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -445,11 +445,16 @@ static int vsc_tp_match_any(struct acpi_device
> *adev, void *data)
>=20
>  static int vsc_tp_probe(struct spi_device *spi)  {
> -	struct platform_device_info pinfo =3D { 0 };
> +	struct vsc_tp *tp;
> +	struct platform_device_info pinfo =3D {
> +		.name =3D "intel_vsc",
> +		.data =3D &tp,
> +		.size_data =3D sizeof(tp),
> +		.id =3D PLATFORM_DEVID_NONE,
> +	};
>  	struct device *dev =3D &spi->dev;
>  	struct platform_device *pdev;
>  	struct acpi_device *adev;
> -	struct vsc_tp *tp;
>  	int ret;
>=20
>  	tp =3D devm_kzalloc(dev, sizeof(*tp), GFP_KERNEL); @@ -501,13 +506,8
> @@ static int vsc_tp_probe(struct spi_device *spi)
>  		ret =3D -ENODEV;
>  		goto err_destroy_lock;
>  	}
> -	pinfo.fwnode =3D acpi_fwnode_handle(adev);
> -
> -	pinfo.name =3D "intel_vsc";
> -	pinfo.data =3D &tp;
> -	pinfo.size_data =3D sizeof(tp);
> -	pinfo.id =3D PLATFORM_DEVID_NONE;
>=20
> +	pinfo.fwnode =3D acpi_fwnode_handle(adev);
>  	pdev =3D platform_device_register_full(&pinfo);
>  	if (IS_ERR(pdev)) {
>  		ret =3D PTR_ERR(pdev);
> --
> 2.39.2


