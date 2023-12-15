Return-Path: <linux-kernel+bounces-561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754148142ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CB41F22E71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73115EBB;
	Fri, 15 Dec 2023 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFQaUKYh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA0171BB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702626361; x=1734162361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hE06mtxuNpriyO1n2h72aSmIJpoO7UhVtP7EgNidcYM=;
  b=DFQaUKYh4/TnpiEYPAqSGBMAASrMdpV3F3+K+YkGy4ysRJjAstWcwCVs
   oRqJX6w0aVglvgFsh3ThFcvfVpnPiiLnYFTz6h3BUwba41VEn4SokW8w0
   OYxt6gY9eTsokaz9q+eVWvkwEWxhyFnpdp3qgFz+K6iJ/saJMy0z0Zhih
   QjhMJkChwphZiE+eRaNarsX9cP5pIODojmxKUUqX1vD28IfkZ2cSG83I2
   BySjM+Q3FyPICiiNI/6XhH5qW+XL8tv6SO4ymZm+2nIwFA96qdRfuwozg
   Ld+1jW/IdEJ9SvdAC1Uw1S25P3sFENpqxxKOIS2pZB6xBuuqZRuusj0qE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394984802"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="394984802"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865309466"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="865309466"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 23:45:59 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:45:59 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:45:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 23:45:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 23:45:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fai+MgTtIJ402MTzd36sBCkw0pzeuh8Xr2WSE7eFLPj4bnqv1eWmkUcnswLSwYmGTYPozcw197D4py47a873oZ79PXBBuaHVgH7yjVqHbv5eP4yqaPe3bTFw6Fz4wXfzlYN2YtFef4/OUwKEdp35hdgTEdkPf9UdSrV7BFJG8VQMSVH2DkXZpRJPfPjtgr7iH5jAbZ6H3VNzwQSR7P29Tq8kFT9ZTOOHAcfGkKXfyhOlRfrK6TFgv7A3TCIIx3gOnrz6Z5vPktv6/2TbxrIXRyouB1F7rim581wSbawIRJZOY7zQoJKUUciNT9MN/Lk7qYHjQrav6fzYSBp/KK3b6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hE06mtxuNpriyO1n2h72aSmIJpoO7UhVtP7EgNidcYM=;
 b=eCI3rGVRXcohY2MTO0HBQBwCQqwJIwazRdxkqMX0NUUR5m6UnXgBZQFmnlpFh2NTdeTpYt3XSXOzrHRDnJC7r1IemjcCvYZNB31Jwr8/5wPnjqM8zF16s7hI14kZJPhUZwPk2n6ppT7Xc1aU59Xx5bESCKXW2t+FJdujJUyBOM32x0UjPurmdsAlFb9xiljsyAVelxuOwQMdSaFdGvMkUp8iV9FPRSmG423LCB+QtfcDIEDVFJg3Y6oc5XFNStuNSBFx2h/TmNofIwdc6JQi3PIu/NFkxNwFvsWZuGL0BUpdsUBMlmaeFiVGWycXt3soSMjPTc4pRGy8GwcSd1//aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 07:45:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:45:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "jon.grimm@amd.com"
	<jon.grimm@amd.com>, "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>, "pandoh@google.com"
	<pandoh@google.com>, "loganodell@google.com" <loganodell@google.com>
Subject: RE: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Thread-Topic: [RFC PATCH 6/6] iommu/amd: Introduce nested translation support
Thread-Index: AQHaLRSotAlXhvqd00euR6r6ebkny7Cp+q5w
Date: Fri, 15 Dec 2023 07:45:55 +0000
Message-ID: <BN9PR11MB5276BA85118EECCCD89681EB8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
In-Reply-To: <20231212160139.174229-7-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6700:EE_
x-ms-office365-filtering-correlation-id: 902bfdc7-789b-40a5-4fb1-08dbfd41de90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBV65lnRD/40ht9wL6LqTx5psBspIUBZqpQbY530EnqhIse+2fEw1ojzc05uT9uHYzNwLLb+VszJuI+gG8RPJ9QeQXMFipjb+ssR1+YIt/j7VLwuhTjn472cPsnGYb8SdmWY9gNHlsugTOWxZwudWw4w2yWZ7unx3aviYGA44iK7W1I1qeBMa/K47dOubknnskF2G3ncmvvjgMxlZZSaIH+U36oIDpLsmSX7epXm7+agkYWOFfIFY9khNEKjfn8sY9a7fQcWsGAqVa/eO5KJowbfICKHUPKYwPxJ1XTCQcjKLTqkjT8KmeUrjUniSsFDz20AYivAIHeRlP02VpGpwjSJeHMK+g1QajdsBILs/q9b7lgQDJmc4OlSr/qkuJ4p0xB5HR7rUT8PqG31z24u6eYM/wDtde7EQtNcJGY7nYpL2D1ME67kxqJcRx6lyV6qaGMQc0Uw3UiAx29c/mdOb/mUTuF9jn1mrO19xTA9pSiC5Z9TluRkuVGuzJ/birnazu4q+ODNqO3bHNZzArxe5SEVWVcUhqxGhki4TSj+WwMhkt5bSa7AAbBPIhpKrcaD2bVjHIzkJsQkPIzbkPCRUpJk+BY37VpZjsr9F0vsT5OyjZVC6AMk5bIbKhLhnJNZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4744005)(2906002)(33656002)(4326008)(8676002)(8936002)(52536014)(86362001)(5660300002)(7416002)(38070700009)(41300700001)(478600001)(71200400001)(26005)(6506007)(7696005)(9686003)(82960400001)(55016003)(122000001)(76116006)(110136005)(316002)(66476007)(66446008)(66946007)(66556008)(38100700002)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIVdlC/yCIe0uoLRQtS0wYf01k5PdH/n09T7W1iURhevfSN7fARHhec+cpLb?=
 =?us-ascii?Q?P+WJV1TcMa+q23fOeEuyCu9YX/o7KZT+ZsORdrGqjhwVepFMcfQKyIYaM/k2?=
 =?us-ascii?Q?phpy9/ZF0iKbJPtTLm2yXAPp5z70wjOAFS/iItpLQU9AQVAupRLaIjvv6scE?=
 =?us-ascii?Q?aidRcb36nCLPrxEvBBvcAbU2ZnAa2TvWjTr3A3CEZqgPxDPzvcK6TScO14OI?=
 =?us-ascii?Q?lZYMJoPzSlI8Kqj19sSsLq8ViP1J+OWK4N8MZTBG9L/a0wL8baT4e6sEapP8?=
 =?us-ascii?Q?EcVbRB/QsUDGKYrz6y65F5tUdtMKnU36ZFFmaCjt7VQDumGCW+PhgEIwwCX7?=
 =?us-ascii?Q?wRF+1EWF10MqT+FJD+6C9iy9BFAnb1+Cbbv61e6Lc6wjJc54JSCROSCGzgr9?=
 =?us-ascii?Q?yn1JqLHQMCE4Y9bqnAB6+uARn1FAy4HrDPa2yryGsLeT+JwjarkHiJScqVyw?=
 =?us-ascii?Q?4/EvKOSyTT7aO1AjD7QtxRWFJytOPa7qQ7HfMy9pyd8WP+e//GBM1iO0ii8X?=
 =?us-ascii?Q?JqVR7UOWR4Z/1CRpGItyax+30F9FsziQeqfOf3raHWDJi2eX4PGjOv675EP9?=
 =?us-ascii?Q?p81jWJN34+hBxNuF+YPzq18k8iV8Xk7CBdWHnxzKBY3migVqlfNixaQRUCvp?=
 =?us-ascii?Q?HEYofA89BY2PBS9d4JZ1LXAwQd/f/w25Mqvq0dRpkC7nAduZFEOSX1g5B0yC?=
 =?us-ascii?Q?KR2eioySykAAs7tt+pqBfP4qCWl78gIHO+H5p56Gj5jGg2pJ0Z854QSI3/jC?=
 =?us-ascii?Q?mkzL0l4CZvKujjMJSRvLH/9AAnCZwnpCJ7xcEYlJhqB7E5spm2ZUfJrZ96D2?=
 =?us-ascii?Q?BoNcXl/9yUFYIR3xRf1as0pPAXbGXTAZiznBrWXqsjYYlgaZ4sBiubR8IPuL?=
 =?us-ascii?Q?Z50ryw2afI7yVUejN4y/RY77NBNrQ9A1esVx7AYSLJO8jWvH73wkTW3duQLY?=
 =?us-ascii?Q?sRTYcHInOla+WaGm+Gz5mcjVPKBHLAN5kzu9V7Wx1jDjqNrOcF3HMiOO79ST?=
 =?us-ascii?Q?LN6tEW306/qTqNewPpSeycaTrxlxfGGjZ9edoSP/gekmgW+MNlL6bca5ldfp?=
 =?us-ascii?Q?m50IIBWzwNU1tkXCRxG+1/Z+c7Tzw5cge18wyWjnR9hiuY84T+XXpJLznx5b?=
 =?us-ascii?Q?cRdxon23dwL1HkmDMdRAs3ameKmwg5qYwAAOCkEitM9bxWqAHpNZyw/9ZHKr?=
 =?us-ascii?Q?zPIEqgddW6GiS8kEivE4mCNflWlah6JIrHPOg90WsNyLcCoOlYKO0anBKzbD?=
 =?us-ascii?Q?T6FBLt0znXSTwfnfNGCUrDcGcz2IAIJQuei1DAvRC14qvmb0DUoxYNPTdUCC?=
 =?us-ascii?Q?DvaXKYrFPCpE9u+Z43GpwGkuqd7jRzCypuBLZsSl3j7rfW8otRBg7qkqA6Sr?=
 =?us-ascii?Q?XOSbJEoh78f9F6iZgwXhiUlPoSSk8xVNI640wcd5+x2RrJ6UbmGgMptXNzR4?=
 =?us-ascii?Q?M0LQlvp8HLAo2+4LgD+h/l/anp6S7oCi9hkngOWxVl9MP327XlgY8D6ZMOWl?=
 =?us-ascii?Q?EGKiNLhR/28d0i1jLBPfCxKOBXljvZzJTdrOfB2cIKcLLM/bgvTYyZdBYNoK?=
 =?us-ascii?Q?joDXTh4gT1rYHk/pOuNPW3NqfKxthLgE4c9oQuOs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 902bfdc7-789b-40a5-4fb1-08dbfd41de90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:45:55.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6Ck1OsUrhbzG+B0V61i67uQGH6hHliRjoNnw905v3Fi7LTpoud5za6GdfhKYk4puuJt4iDPS7e3mSccs2FcnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Wednesday, December 13, 2023 12:02 AM
>=20
> To support nested translation on AMD IOMMU, the driver needs to
> program DTE[GCR3 Table Root Pointer] with the address provided by
> the guest via struct iommu_hwpt_amd_v2, which is passed as a parameter
> of the struct iommu_ops.domain_alloc_user() with the flag
> IOMMU_HWPT_ALLOC_NEST_PARENT.
>=20
> Note that current implementation only support GCR3TRPMode for
> nested translation, which uses GPA to program GCR3 Table Root Pointer.
>=20

means there is a plan to support another mode in the future or
actually the nested translation requires GCR3TRPMode as a
functional requirement? imho the point of GPA is assumed
in the nested configuration in concept...

