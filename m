Return-Path: <linux-kernel+bounces-14664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03245822079
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386702834DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0165154B7;
	Tue,  2 Jan 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8bZ7fKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DCD1549F;
	Tue,  2 Jan 2024 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704217084; x=1735753084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=neOw+2/vnR8APr1dJYKidMD495QTA6ekpC5KNLYQF7k=;
  b=g8bZ7fKouANGOYDOVVOxXsxtDUElKFP0TXF00u5aHb7pr58naHaz8Dxr
   XgwghQPBRiz456zom+Y65Q5NmpGk4W/JoRB3yA/AkuXUTv6t4ew+AGnjZ
   5RkhhHHwG2VcGa663UI2ZClxNCG9xl3eLX2NfL+eIR4Mste8/Eg8z72HU
   J1OlF83uYrkTUYuss1/Qcp8kUVI6QQuan1Jj6+pugqQLT/Pa81ldz1VCz
   FPc4wle7cDU9+3hVo6O3NS35FFsySxZFVTYX+K64lXj+TqRV6N2FJ23Iy
   zVPsOCfV3aiMXvyRILDGRRD0AA6nZOALfEECN3ZSTaaVYyADnjLHDCnsm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4242072"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4242072"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:37:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="923275003"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="923275003"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 09:37:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:37:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:37:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 09:37:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 09:37:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTXwYorUpHnFNUoiJNB1OzLGErGBQIxZsMHSTeKDMXKuKSFgCx366PCsKG4BceN/DFtgVbzPqja2SNP/utvUGsU9onp+FgcuRtc6UUqNG6Se4XqZx/KpBb75FLP+HCQG8vfszQ5qEHATnYW6VcmZf1NcTTMQSb+zwkhbQP0W11pB05ztIzJUaJfhrsfihL87qYlOob4MOhkeyPgLbiKLbP6gQAm7fTjMbU1BbzzE+UMOLxwWvZ/FuBT7znuF6qabEvN0yCot0qZBQgzVeRsGAt0HvDI5ymHsMlttaBgRM54YAK8O72WeE2ydBLevnKidvVeybGRXFDSd30ligvmjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neOw+2/vnR8APr1dJYKidMD495QTA6ekpC5KNLYQF7k=;
 b=Nax+Q+RKIkhJiVmo1saSfU0nPaDKcOF8mFGrVsU1ejfRv8qQ8MCtQgvKacZPI/JXxcA2C6OYnNDzoD5eXJF6C8lttyuwLxKcKGRrMUk0OlhWNjCsFNOvOh6tgQaBBI6JDi6OaCoVh+Bqqsuvj9RGkYSPUAbwI40SNwLHDQoLTt+mmcoxNf89CPrKwQjUkutoqFV/P4NbUKhXtl9ASESud9c93szrAOQoxjnZFn5o80+xCdqt7VPPPoP7NKZwRQrTv3g2LQxXnSInwX5XUlHXu+goKFp6cFbbfAwOuH7OW+sxuMHtN2GtRkMUiW1Kt5tfRzOS+5qzPbmkEL7IzWgABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:37:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:37:20 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] EDAC/skx_common: Filter out the invalid address
Thread-Topic: [PATCH 1/1] EDAC/skx_common: Filter out the invalid address
Thread-Index: AQHaKK8WnppqJusOpUmiDU4JlvZxt7DG8wXA
Date: Tue, 2 Jan 2024 17:37:20 +0000
Message-ID: <SJ1PR11MB6083F4553DE16D2B7878C94FFC61A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231207014512.78564-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20231207014512.78564-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7729:EE_
x-ms-office365-filtering-correlation-id: 9c7de6cd-6917-4acb-9b0d-08dc0bb9791b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MKpcNWJkocMabxfAGvDMXrx/GcRFx1b4qjkEObCY4QELLcKJJLBCRwdek3ba9rj+5hK8TmERvlZ7U5t9HKBw0g4DoWbbDB4L8su9ygThHLNVAUYLH5E17hikPScQLYfXn8li0U/qgHZ/QLo1DfEMy9Pg5EuU6ZyIXmbctxDpdQEBUo3UiJ9wK+LOxy+8B+bbBCUiIG6wki2x0fW010LCC4R8tWFS0ox8W25nAgXoLuBAiPDil2DJYdaRZF5OT6ZPdrJsx/qnn6T1JovHnUHtp3KCo/Wucvk34D1BngZHnWEmHBdms2Meice3/BuYm6acuYfgJQ8wn5+J+RNM0rO2pKqLxdGKpD5B4T3ak0N+hX2m06NDSTBz0L6R+MM3hihatHiTDFeM0lDic291D3DmnZta/uBii6SB1VbmBINVu+vDgYm5IEt7xPW5GGkRNPTEz1eJSJXf/BgfZA1ryUg2nNGtnyHbiGd4T+FR1QBlhaNe8CFXMll2Z1TqN8uyskeV/J/l8CCYecW3vf9EVIHV7GFLbWRuxxlrOQxiHraDEvz+NrbWeg3aI+4VYoq3QijK96xFoQxwbXeLl2SgBylm2LEVjodPhv/X1EoAFd4CdAiyNGJ5wimLBmVPUPljvzH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(4744005)(2906002)(5660300002)(8676002)(8936002)(4326008)(6862004)(33656002)(52536014)(54906003)(316002)(64756008)(66446008)(66476007)(66556008)(478600001)(6636002)(86362001)(55016003)(9686003)(6506007)(7696005)(41300700001)(38070700009)(71200400001)(82960400001)(26005)(38100700002)(66946007)(76116006)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hpigLnMt4rwPPQT3ZnOeA0GLMrIQ+pYILLCyMc6uhiSUXJCjF4cmTFgrE1O7?=
 =?us-ascii?Q?uKtME3dxVxP94ObJkcKuSXqPpVqZA4tbN26LoNd8Ucq5ibbWwIWs52D5JnA4?=
 =?us-ascii?Q?+CZE6lLodLD4xQCuKsvxLtFV5AWkitu3F2HIh+0nFgZbjsKWgqgv4RXI6Stv?=
 =?us-ascii?Q?Cs21o3emCm/lCxLkQS2Gcl1L7uxHLEHGgHUwOmzLd77d0Q3Cfpim5BVtQS8e?=
 =?us-ascii?Q?5pQiacUnH4K9+zQARMWtdmR5My7fO+/OFod0c1Dmxug6cpt3w7EvQe7ZTNUH?=
 =?us-ascii?Q?A+LD12NpfDT+GbT7bR6cbSs0/b1XemjflNxDMy+zNHuhxwQk6vE7IeegPONb?=
 =?us-ascii?Q?7cRPTkf4VsPuUSDIAl8uIF1O9Za6s1JqfDFFb1qvKQUUhokd+xCImuhtaPiU?=
 =?us-ascii?Q?F9BcFzPaG6J4xWKtDp9610Rs8HeLKFfBR1iL+arNhK7K1FMzirW6o2Dj5f1l?=
 =?us-ascii?Q?y/LszQ3TExTLbdgvUgKE7HpIdmmY65eslNuKysmYTlPkCn79DrwLRQ80Zg/k?=
 =?us-ascii?Q?uDtt4etFttXsx4XM1rGNt1ObIWg1dib28IpjewN9EcmIc4w/jn2LNVSfykWx?=
 =?us-ascii?Q?RhDEau3cuRSUHVCXjM2waxaQDoFYVUT/zF0xsnrLhHUMz/7q+ma6Yr/fl3og?=
 =?us-ascii?Q?oMnjY92idW8aNeVnpfd2zxjqncK6nxp9NsKtspog2K5oAZWp98PAGfvWMfeG?=
 =?us-ascii?Q?IoP33MrQtrzBf37zpB3vQ/crmO1ETqxKycBnD7is4YqrPcAvM3KpaMccdwbR?=
 =?us-ascii?Q?5Ym89b2XbjqKELVP5SHsewK32pZXNNDNEE8cRuSx1nNyaln436NKcyt7WTek?=
 =?us-ascii?Q?x5KGSTyP99R2tzURu2ZG4EcbaVFEIB4Mt279/ZGgRz92P12fFUqdTfAhHloj?=
 =?us-ascii?Q?v5l32+siNx3FD72c4hIuAkrhobptPUqQxYac1HFxKDi0d3EsAGiHP0IE58ot?=
 =?us-ascii?Q?mybVuLVqAXpGNhbQzZ4cwBbzv7ktpUhwtTtJp1hLHAZ1LwtGDzI9ftl49PMs?=
 =?us-ascii?Q?+wv4HZssKQnFLFJMXTsIq5odJWivrX61Bz4yGNUbMsjUKcH/vj6UF83fa1n/?=
 =?us-ascii?Q?osKPu3/WGQIcUBrPTKi2d0pLwjtGqXzmj1Ui4G7wz01U4g0Ie0D2J9kb6hUZ?=
 =?us-ascii?Q?CyB3xXirb7x+9Ar1EFbdLYCqH92BjHM5WtEBaHW6oU1Z/y0VWIswW2MdYrr7?=
 =?us-ascii?Q?3nv1qXkC2HHb0z0MwiJXNcQ8OT8uHK84mKyOFySUeiYZ5Jy2/i7rIo1GvU3D?=
 =?us-ascii?Q?YY//rYBs5YvK5KIDGjOcuniKVX9Jzg1/qZqiePHZDHJcKFd8HJ8kI49KSsX5?=
 =?us-ascii?Q?zYUHYUoBpLLD8NWvrl4/aw4Qi6oLHo94P0Re67O/F0/LLWzvSoGcm6itoG7P?=
 =?us-ascii?Q?EjQxSqmMA+N6JMkOfKcCkECPefBCXEmaZ+z13RAZE45Bs3PjCH5D/qtELAzA?=
 =?us-ascii?Q?Z1NIVpgzbBhLRdhGm/4Vu+7eWRRMGnLfblnxuzeXSD/vYR5sInC24aVSEUyj?=
 =?us-ascii?Q?oXfGNbDgcCjflVVUXjT+8JYGfd+bBYFbrOb20VkEW3cMKvvaDzOSi7WW6kbO?=
 =?us-ascii?Q?PsuXw9f0IrkgbCleySvYSzYSvs5s2PLGIvOW6lDO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7de6cd-6917-4acb-9b0d-08dc0bb9791b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 17:37:20.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPB5nVUKcQTtdm22c504NUfCyaw6LUjZk1oGTsG2DosgVOvHMsk9IrSFUNtlsq0kbyOgFS60T96JAzJioTLheQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com

> Decoding an invalid address with certain firmware decoders could
> cause a #PF (Page Fault) in the EFI runtime context, which could
> subsequently hang the system. To make {i10nm,skx}_edac more robust
> against such bogus firmware decoders, filter out invalid addresses
> before allowing the firmware decoder to process them.

Applied. Thanks.

[Boris: This one with a "Link:" tag]

-Tony

