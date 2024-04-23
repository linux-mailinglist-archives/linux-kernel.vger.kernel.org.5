Return-Path: <linux-kernel+bounces-154749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373328AE07F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811E0B22003
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A588956B95;
	Tue, 23 Apr 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbQZLIxG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60FB56B71
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862902; cv=fail; b=PIzpNgQ3Ll2xFR0le7NNCbzXs/g3Ap7xyLi9hrwB4Cp4oQRlrazqxtp6hfJWRO2Il8zVgaPg4Fbb68rNt0QywOUmwdR9IYpbu6HgULTzRvZur20HW0sSDr+byduurzpxLAEvExIoEKdw0qDqaS3WVHuWUf8U3b5YUFpiSEXaoZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862902; c=relaxed/simple;
	bh=8CLa1UmlHdYRPTnhZqtlE3UHl9AKF3ZnhWdU1NZ8hyg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tlYyKq3W1wgIKjaWjO0yQyD8Q2eimh+mwHDN/zKQPaSrb7j5GAxwpNiHCTFQH4yfP4N/XTHTH2//FkPm8mm1oV2Z1jIJi8hvcSsXyoMP9CoXEqs//RXxNBFQhdU8huQaSSxRUx4O7kgS+S4DgEpW2oFoGrfqTKOZt97lCOvbbnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbQZLIxG; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713862897; x=1745398897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8CLa1UmlHdYRPTnhZqtlE3UHl9AKF3ZnhWdU1NZ8hyg=;
  b=bbQZLIxGvR5PBVqrKpxG3AmmrcwPVrmd9JCiiG0hQI11NVNcoPnRNsLn
   TOULGUU2IubCc+39MSJzZ19GLq2YZulVmYP63kCIv1VcZZ1Y5hRxUxDea
   94a9HY8YIBG8/laprJlLeQQeXH/xANWpfghA+XSqWHJ2MRUd2uwRx8vrR
   w74gspujfxj4RTsbUa8jsJehmbHqo6XcWoSNBKmteVD6OSaoHye28bTCf
   MQRHANVTruTl48kUQnEH0vGtFltgnFQuslzLFLHGnF8/c3jBTS6tzow/E
   Lu0nxsc+mKY7u+hTRq17quZfYyU1s6OQq6Z+6/tc6d3fOkzQryWs+QuTQ
   A==;
X-CSE-ConnectionGUID: KlGit3zWQIm2yyIo3m0ozg==
X-CSE-MsgGUID: Ub5XXyC4Sta7d82KsVP9xQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26950818"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26950818"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 02:01:20 -0700
X-CSE-ConnectionGUID: Vcnj+caJQbO85Pr32MHGVw==
X-CSE-MsgGUID: +c/vDS8aSRmPESfnvBz2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="55503432"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 02:01:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:01:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 02:01:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 02:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDy/XIXHzMoLJzIgJZTGb2aCnDnM89OfAgrMH7WOp4TiY7io9eTbvTcrM8cpn4CL/X0ArSlZpjIhpTSmp4hKNUQ0BbBid946Ik3eMH6T5a9qMBlpVVbBvr7CGZvckbM34fWqmGcqaIVEA5g87hkiN08Fu6tttX8wpTbyDLfC5+VN+TWMYNXFpMMo1OmVFxraTv5Wtw/N3Smb2J1z6dyuez1cOwthkY3t8qsP9QKHxmE5QPRj4NtSkrYagYCQX/3FDw7NJjs+J4IkePuUw/Zlfk8RW+gcxIH3n8yHoIaMbhpahxa9Wi0VneOTEn95GE8ofN8lrhtspAv1P+vATgRO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebPmVRemIxLyCf/L3agV8zloVSrT8eQbcg9JDEBJcb4=;
 b=Eh9o5mgmOeaLwb14JvJ5HmanEzF9HfRGnMZX6SQCy0CkLKVcEpVgphTCzd7jQwANea82j7QWbTE6KgdLDkrtBUrgzye/+Y90kV52OiRkNrSYSyQEKH4EaiX1yimLttYw+72432mkAmMBQqOSBQ/x2JnSKTw6HyRQIAyIonAdObtHdNGL2yAtmowgQUBRAHD52QksNUyK5OUKKdMq/CzF8+jEYMPCSbG3RFrAZ8DuT+a4l2WB7GyyYFj7R5xuM9B/gxcurQv/cJXqaArBwEN1x2yI28Z8nnXaZ3thNlQBqgGhLHMPt+FQA4+vj8EgjaJRWz0yPZxQ6b/rbapGwGcMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 09:01:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 09:01:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Topic: [PATCH v3 01/12] iommu/vt-d: Add cache tag assignment interface
Thread-Index: AQHaj9VBHEr21xvfHkeP18PDMfcoLLF1mcCQ
Date: Tue, 23 Apr 2024 09:01:17 +0000
Message-ID: <BN9PR11MB5276A1920E24BE91CF1FD2098C112@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
 <20240416080656.60968-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240416080656.60968-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5197:EE_
x-ms-office365-filtering-correlation-id: 893b4c9b-0a04-4537-e744-08dc6373efea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?BK1x9ZyVB7Ie5ffh2x7W5nCBQ42D1j1nMY54abpJGllTEyYMopso/zz2EfnW?=
 =?us-ascii?Q?b5hkmw2oEPX7Mknk+xwJM93YB6BSKszslkivWEC6cAGoaobIhlo7yVonGMFJ?=
 =?us-ascii?Q?r0gmXTBbDTqC6MkA5AzFn9tX7k1+gnpjQatlxXKOpRgSTuJzoJ4S3yahmMJt?=
 =?us-ascii?Q?a7Y5/H8mj2OEFFhTm4E3IGXV+ZroXMl7qrHnZAOYNTovo8w0db9Rh348xVEa?=
 =?us-ascii?Q?SQmFc1DiN8lYU1OCRCiS9T0WRXYtpI399CxhE4QkFrThv7KWWTTkeJ2HtNzN?=
 =?us-ascii?Q?bDP2s1HtGR1D26NqWsHThtiAWfsttda+geDxAw9Ep6c7B9JiRwke6y8RTszO?=
 =?us-ascii?Q?GAjLTKFajY1bt/NPlG+spNF0V8qJeOCd+1y9nm2ozeNJK6joRmkfdlKH3vMT?=
 =?us-ascii?Q?S1IWmqe2qrNIpyQk96TkAZwyFGHCzOfz6kuMBuNHiXBPsDTmO80SN5W2nnjs?=
 =?us-ascii?Q?L/LWIQX3YTUazxE3yiHE+N/lSpzE1QvnR87e6njBBYEruqL2mbM1VuPaJA1K?=
 =?us-ascii?Q?FX4Y0GkKxS8bdduKpHVdRTDr3Add93rUA3rUt1VMxc2gCiu32f5VGZSLGPLP?=
 =?us-ascii?Q?4lIcGZGd/24QXaJsIrLmxvdaCfZ9LSlpzCdco6vYXMpcopnn+0e3trH1ofv4?=
 =?us-ascii?Q?oTGxhRPp+/+QGXqAmWfPrj52jAZf+eF+2B/G3vnFVWZQt8iF7yyw4VtDwh62?=
 =?us-ascii?Q?UXXY+YmrJTYSZBtIabn0SgJantYdUFXSlUvDW6XBsHjVnH5VQi1R84rjyPaG?=
 =?us-ascii?Q?IMhyQdNapuF0fFdWKedH2wRB5wHapyZSL7yOHtzi0k+29LYMh1nPq+GmS9e4?=
 =?us-ascii?Q?oE/P/Z2B3reZTuqQAD9YHihobHJBm1dNxMHAA+e2ZiWB1hEOVqQWRghbbwrY?=
 =?us-ascii?Q?S1qN40PWWqQkI0wne7jUfMzOur7j1Tw8q9+zTVma6qMAHbx6Fsr6BS/09nU8?=
 =?us-ascii?Q?51hxDyhHsEka3b5CcSiu3cXL/B0JxXUop2JSBUPVmfgKTNziaVRYr2e8eVJ/?=
 =?us-ascii?Q?SP4S/3rwupTG8gD4XxKdCJqIHWpyZMNxs4f4fCJC0SreIjAKjH8lB57uQTeS?=
 =?us-ascii?Q?8J8+hF9pYoOODcRIKkFiU7WO39aUmu/wenGkhz2vat7KA4Xq5Vi7OkjiR5Fq?=
 =?us-ascii?Q?wO5dBuGjVr3f4Ey9QktFtnkw9ROqS7TCPH5VLmsLPGdZ2Il/IiemLK6k5FTF?=
 =?us-ascii?Q?V1itSvWT7L+BZG35owMeUaQ9iP9K+eQ2PDrIVw+6qBUE/k7VK7kL76goymVL?=
 =?us-ascii?Q?JpicXGn6aLrr2aGd6Ik6zmQYbV9V9MhqCYgzVbaOwxVqThkFdARsXj9soKbh?=
 =?us-ascii?Q?4/IQrcsByUNmsnchFulanYYnui3UrIbS+CBFuNMG1v6dKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oBg+FDixIvTtxkg8II1nbeHsHWDJIm0uAI3yC1HmEFtuR7y7+K0WO7NpE/a8?=
 =?us-ascii?Q?Zl/xDwJcOqH686u0WJ++y5y9/NhU/7RHIPLG50sZ9M9emo7iV0MbczSzCQzB?=
 =?us-ascii?Q?+hN6O3hjpZ4koRCKf0VUkSm5gdvS60LNLmC1HYZW8gE3nte8M7LBV/LI7qIn?=
 =?us-ascii?Q?0XBJDSo4Akyt01O/Ni90atwRBWOqlxqPejSBuyBTnULWM4dHxlF7DJFnz+5I?=
 =?us-ascii?Q?VgfwdE1f4WmC7oAwG2uWScE3g3hDDz9Idvzzfv/FlgmHLxC4ehB6m9jiZh4E?=
 =?us-ascii?Q?aTeC+l8nnpZLChb27IujNp1GbR/5uD5XpfMDZ6FYs9Xo+8CkR0FqdNGFngQG?=
 =?us-ascii?Q?Xxp14zY7+9Y15vrOnvERfPjePvnvPtpXJLguOi52Y23esuZR+Aza8eVZk/EX?=
 =?us-ascii?Q?PJlV/LMA3hcNRazq8HMDD5UtqeArdiwCsPQSniSpmMbZIArF60z7Bm0tKDWt?=
 =?us-ascii?Q?T3yAaVSoiZ6oO+cOyQn7wIR1LdtLbAk4FMgd9RC2d9fKN1TpIEuJu96dX//f?=
 =?us-ascii?Q?fiHc3BPvd528akP5dBuso3SVxKYTogN6Sa8cipX1WZmx5/P6LDDofG8WKuJf?=
 =?us-ascii?Q?ts9Zig9qar7wN34ktto76Y9bfTqs77MkEVCTZbIxEdwxiFbs/30WKX5q9eM6?=
 =?us-ascii?Q?lpCE+7TvUMF9VfbUlZBSa6H51YQdB6vFTLALzE8IyUKKy9x391pAV1CH+MAH?=
 =?us-ascii?Q?TI+Xc6BdO+KGj9u6gvEGg1si3VvDvy7GSFad12x3sSwK1hPCEOrOz/7d2ORf?=
 =?us-ascii?Q?TpsKOjLRFlEO9bfNTMYI2IvzWbiqDnfD2KLAH/M4ZFmS4Gg4usHfZ3wLQ8pM?=
 =?us-ascii?Q?Ix5gFAvJO5NQfI28KufpZXXiKYGOuTqdTCSFfykaJN5GdQP0MCMMg7Za1+/P?=
 =?us-ascii?Q?W22+gxsTBneiWpzI2SRF13Z059+yr1Yh4Bm8YmEhks8TPioWqaOc4UbiN1eX?=
 =?us-ascii?Q?2+GWr/PovwZ2u3YjSlL+HmGkzW292WWFuADPZ0oDEa3tkt5UYltqF/lpTxnA?=
 =?us-ascii?Q?u3RhVj3b+kW7ibuV/3IMtEXUj+w4X4owTPAOPtZKnWXYCbxsGEizil1unYix?=
 =?us-ascii?Q?vbRXLeljME5nUBT19/xYS8lU3Tm3xd827KOexDC5qEs4w4sNhKQE5XzqoSL+?=
 =?us-ascii?Q?7vKHTWREB7G5r+OZUOu8O5Xqgmci/+kSVPdUHLgXF9ze9jUG41AV0fTy7rVa?=
 =?us-ascii?Q?XdCfCqKSfVMV29g6oSo+hnXTypQUJhQ5MBoTU1uhCEJ+wtrgEhhI4SNTop05?=
 =?us-ascii?Q?syVBioddyXXZRN27vjww5MIHnJah2HQStnIbl0Ym0L6K7Wkkig0iMtPZWf+C?=
 =?us-ascii?Q?cnd0spTRrMLjtcc/ukinBWJRBpR+ZmOIIybK3/4CSorEPG8arRYpdl3kigqL?=
 =?us-ascii?Q?XhUR/p50q2+fWdRzTBJCltJjw/po1f/DgDHYECdrVclg2n4o6xLzVJFIYUpR?=
 =?us-ascii?Q?vLjIo0A8ev4xbJxgQAe8z1jpmwVswuQa+f1Gsej0fukFXoPG1Xat8NJBXQNJ?=
 =?us-ascii?Q?wY88IHgc8QQPStcs2uzxhkF0kQt1yNvUPlX5UY/EMgZfGZ3UwGQ87j7BaiEi?=
 =?us-ascii?Q?cYXD2OiZyCBIzR7R2YKi4imBIw9TSyQ6at6hZEbd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 893b4c9b-0a04-4537-e744-08dc6373efea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 09:01:17.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8L3NXzFSfMWpK3XYr/OWu8IexSf+CxsT6jU0Mz1qbWwlwOVgokQpU5n7Hm1cs7V2p7quJfyvZWLcyi3mO3t7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, April 16, 2024 4:07 PM
>
> @@ -1757,6 +1759,9 @@ int domain_attach_iommu(struct dmar_domain
> *domain, struct intel_iommu *iommu)
>  	unsigned long ndomains;
>  	int num, ret =3D -ENOSPC;
>=20
> +	if (domain->domain.type =3D=3D IOMMU_DOMAIN_SVA)
> +		return 0;
> +
>  	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> @@ -1804,6 +1809,9 @@ void domain_detach_iommu(struct dmar_domain
> *domain, struct intel_iommu *iommu)
>  {
>  	struct iommu_domain_info *info;
>=20
> +	if (domain->domain.type =3D=3D IOMMU_DOMAIN_SVA)
> +		return;
> +
>  	spin_lock(&iommu->lock);
>  	info =3D xa_load(&domain->iommu_array, iommu->seq_id);
>  	if (--info->refcnt =3D=3D 0) {

above two are not called for SVA. Why do they start checking
SVA type now?

