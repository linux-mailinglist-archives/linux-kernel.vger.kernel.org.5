Return-Path: <linux-kernel+bounces-32549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA7835CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B86B250B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3118239FCF;
	Mon, 22 Jan 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMd/dklJ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882939AF8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913183; cv=fail; b=IWF+7ShfgCD3h7OFADCdk68N4S3JvHje2S7nKeX3I33h57+VK+JaULye4PUCp1MikIa5tVeVwSO3icrQZ1wKrhRfGyJA0VfPVvEZpTiNBKTgc5gBDNfkI/2EpiDM2vnOHgi0hTz1GQa2Wjq9nWoUfBshz3nlMQ7PgO6xskyB370=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913183; c=relaxed/simple;
	bh=xYfCVoKYShVB7AwL37e64w4Wa1tSTNG6RKNLfz4ePH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ulE1TPBFlpDhh2hnqKz45E2NnXqSF6rY5NSm7RUQEPBZsOVO8mLzrf7Dm59/6XRl4ti8VAHUVW0QPsS/ZDt9mU//t3gCW2D8utLt6aIcOgz17A+SkLvQsQK/v8jPmWE9iMoY5nGnj8MCeb+42vW1UCozVlSzSX5C9ZRT2XcKSVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMd/dklJ; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705913181; x=1737449181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xYfCVoKYShVB7AwL37e64w4Wa1tSTNG6RKNLfz4ePH0=;
  b=KMd/dklJlIbjdBUYpx2HyaWtBTggUX+LNae/a8MXEUj4++4Uayv/WBUp
   MUFkcvVaF8WTopxwlevI9eKFk9GC6QUzRnv+WAFjzxV4NDrsc+foor0VE
   J/pQi5Mr5LLl6x6yF5bFHWa8vFMmAknpfau+uG2dVQo0+m1psTI/XR6xn
   cIAZqUioIwAkuXVHJedrE3IfEBd54simD/caEUZglQRMvuS69Gzu+S7ZU
   AK+GCFvgxa9CnIgOe1ywZfZPSYd+ZtJSQZ1wRDXzKaP6mwi3tNv7sNWwM
   gSMBpxO+ehcN3vRcecQOvhw3jefTYbraKA5BuK4bNDhaXkkAbvHrwM0mU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="404902073"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="404902073"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 00:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="908875145"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="908875145"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 00:46:18 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 00:46:17 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 00:46:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 00:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW22OWUPBncWZYg5cAN8kHYTjTgSdWPog6awku3OmUlqqQtdWXqtho8ClvWX9nQYtv7SSVzVBG8AlmV3pWWQwMu7lR9TOSLl35raoyc3TtW8NakzbF1lhq9pWIdsyEH5GY07d4WSUSBtu6m/MDsNRu7sR1q5gig+Q+4L3/DIwZHUamcdVcBxtcVWPn9ig0Sr9t2vltkcQl6TKKsuD/tTPMaAt9VTWXRMde280aaCvZoQy/7i/rZreJw20rI7yBIIGRZmaovjbmgZQuqOQemVMN6jJewatiF47bl0ORg++RgYpddhytq/Hpu9CK8UwefHxyhgLUoaNF0L5enJPXwhWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eps0o8kkpaoNPR8Sr63vGH7exlraZo/hz2gNz+dIopE=;
 b=bqUobPt7517Hiym5mCBkdS3obFnkTGdpv61uybe/SmlrFtoSl7563lp7y08+WiJ57+lAksfL9HeM1uPtHk0IiiKB6QjLoAPBsOWCdzk+Rkx4wmpu+CecPrZIOC5Fn+s0JBSsLNN7bApHdSbG1oob7u/78dIO0x9pb++k1rlmcuZmU+MQAPwdU8LB1G40UXqMUo4Ke3GzH/AK+3r7KzAsx1gg9a0BhVJLZc+T0kFe0T8L/Rl6fpeSdc4yC1jTxfVoZaI9Oe1jvTD+emoxTL5D7awO33Pr4dAFbjOjuvUWrmigTQjgcUCODf6NYygEVtIZZbHk2A2vHZubrbSQvrXWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6912.namprd11.prod.outlook.com (2603:10b6:303:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:46:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:46:15 +0000
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
Subject: RE: [RFCv2 PATCH 5/7] iommufd: Introduce data struct for AMD nested
 domain allocation
Thread-Topic: [RFCv2 PATCH 5/7] iommufd: Introduce data struct for AMD nested
 domain allocation
Thread-Index: AQHaROtZDmd79pU1RUa4//VsDeeCg7Dlk3kg
Date: Mon, 22 Jan 2024 08:46:14 +0000
Message-ID: <BN9PR11MB52761131F227732B7D635DAD8C752@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-6-suravee.suthikulpanit@amd.com>
In-Reply-To: <20240112000646.98001-6-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6912:EE_
x-ms-office365-filtering-correlation-id: 9a8a7480-723a-4b9e-bfff-08dc1b2697db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: laMSsTAuwFo2wtu3rvJMzBpHrCnh9eafYery4/46PC0QJun5ywOz2TR1m8BRHBQHwoJtUOCJ7VOOz/wHXb/4Ugf1E7Ex7KTJzc+g9kah0wT8U4rtuzUIgYJzR6r10k0YLXld1dWDYE/CGJ698FlSMjLVf/gEv559HtF5dzeClYIeyEfytp4+oK8idvQW+RwcJHBd3kcZrlckqpWPr6i5DMP0/y8+hnT4ht/uHWKFqo0Ks5VzOU9VRzBWmg4TXwS65S4MgXHAWROegqkMqupMs1r8nNDoqmZPyt+DC/Cl1JeaHltKSypmLq+dLM2WHSirHSEwkFX06NO8qT0lsL95d7FmjKskegfWI7tYIUObR1oTki/uV1d8pSxO1vYOgfoeUDfo2r4hS9LRKMnILAKk/fUPojSisjPuB6eiJdb6C4ti3tM5C6aFwmGg8DqvpXXy2qt9onsD1lizKdetOvdLQVnzykYa0qgAQwgx8PkyKeMvBCsv5ZezDVPvl7+swHUDgu7wZ0YlRiYqNf9hNlb+dTOUnhLjN7qRdZJ+SQIjqhGO1Ow4WxsxM1r0sWP15nnBhYJUApcM4ES1MnxdUtTVw7mEEIWQJEpwd6REZhbUKJhWT91FO/L2QPR8eQvkUg2Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(55016003)(6506007)(7696005)(71200400001)(9686003)(26005)(122000001)(86362001)(38070700009)(38100700002)(33656002)(82960400001)(41300700001)(52536014)(83380400001)(5660300002)(7416002)(2906002)(4744005)(8676002)(66476007)(8936002)(66446008)(66556008)(110136005)(64756008)(4326008)(66946007)(316002)(478600001)(76116006)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VCARr8HaYAVH9noumUYj/o9dc0LkvSWKjUqH2UJXBnomoTs7a/Ia++XCVQMN?=
 =?us-ascii?Q?JDN7QL9q46+9e1U3EcaiSyhA64hHiM81V8GAgRRsGnef70h6dnFNnUYA1UKH?=
 =?us-ascii?Q?6XxkJHtWBmd0stxfGjUeb5vDWDp/F+VjN13s7AZaobIyHqRnW/339UQijx/p?=
 =?us-ascii?Q?SK2wkY35q0LzjtEbnZBUGwpg0fxZXsaBztz+jnvYFVJ4oBKGTbNlneO2Xlpr?=
 =?us-ascii?Q?3a9oz+LjKuXUs3HcbV5cV+sk/+J5UujmoFrRK4gzopkRWaq52WozK4D3/Z7R?=
 =?us-ascii?Q?9kknyFhGHxHGeRU2Qa95Z3feXNY/ZwB7a/MWkIcu0D5QCgg50eo1O8WMs2Ko?=
 =?us-ascii?Q?kefuu/2UfGQM1IXcBJ6rbTBZ4iPn+4S+V2Inx7qR0JOSwpU+WAeeG1yH6dqb?=
 =?us-ascii?Q?RGxuef3dQh5QXayh+RuwSIZC2ezHobo5dyerm0+3sh9BZH1fFWSeVidwAXfQ?=
 =?us-ascii?Q?mZWvYlQ8BxK3LCRxrEJ55awEm3DKEgRgvXiFNtcp6cV02Ya0BJAZKlALJNME?=
 =?us-ascii?Q?2tvj1rBQR27GIgtsAYN93xnmVLWS/LBM595OPQ2mXfKpPXwUfcWU471YoXRX?=
 =?us-ascii?Q?BsS1/nLbe8wKyQfgdVoWhHqrn5rtZsn+JSvANGL6LO0+4BXHxNAT+RpkASXg?=
 =?us-ascii?Q?fhrKA8zhC/cQTSq0BSnCTcIa2XpA/upPIfYHT0jvCeZKRaEi/bBlZkYyw4UK?=
 =?us-ascii?Q?SxPI0tnJnqYKJLfXe767juNEcxRVNCULBICB6I6UimIDIJfDbm6hmuCB+5yy?=
 =?us-ascii?Q?N9cMmcfxFQHePjIRKRI3mToo+YC7zVVEHDvHx7ylvJkJzW6giNpUQDVZqOM7?=
 =?us-ascii?Q?oiBJ+682CQ6Ox40ncjsZO3r9eJBlr4CTsAqEQOcbSUoFlc5GdaaFojcFh1b2?=
 =?us-ascii?Q?hON5raxOZADE+0STDD+XLLkIi3B0MvFb6YT1C+ZIxchY5bTOZE+4SQ1KV3yY?=
 =?us-ascii?Q?IBwGXi+KiT010W8DeHsPebdrik9RXFa0vba07Zx/hJenGrT2qnyWHkpvGr0K?=
 =?us-ascii?Q?kHojiQS0/6JMnVekCX53Z7wJH9vfQrlRZs1RucDZXPiiejZj8rtz87BodsVx?=
 =?us-ascii?Q?I2gaqukUrbwRf64tU/XRltG/czw5voswyiOs4RhUt0pYxxfkrOpgpUcgqA97?=
 =?us-ascii?Q?IMrKjO7C75MdNy7KAT7k3C6CNC4o90/NmC2M9mPoXiX1yiNbyidUGnesiAKI?=
 =?us-ascii?Q?GkEGW8PLJNzRv4+vxMBlvvNWkPgXy+9/TBl2GxIMQP/U7xJ09o9/UPSTCHDh?=
 =?us-ascii?Q?arcrLryqn1anOgcKZnXAGm3AnwPwcbj0mmjSBNn74SrPEpqrcnw7DHEgtjql?=
 =?us-ascii?Q?uRH/Wzt/fjcs+iWmJPxADEZYKpY6h3kDtJGZ1eKmw4hO8qXyue1T9kGMplJF?=
 =?us-ascii?Q?byj7JFNlRqVQ6t/h/P0eegtoWunUcGqOJL4BolLXyEJJ5R3FSvQm5HDN+3rI?=
 =?us-ascii?Q?eEzQArWS+ZJg7ewXuywpzIuI99AkU1+6JHC1wFLlWutfwXl7jVuqv2qwxgIt?=
 =?us-ascii?Q?9J+HnqNVesg/JAirVv+a6TTGGrOYXUQZe0eGgmhTcYZy7h/3fd9Rdl7EPbeW?=
 =?us-ascii?Q?/xKaUpq9P6To59rc16QPeVTHv35vdTvT2ZZ+s9ZW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8a7480-723a-4b9e-bfff-08dc1b2697db
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:46:14.9934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MtbVKCP53Hu4phBCE519T8RrPLo90pA75Qt1M61r8FIFKoiGMSTGKHX7mGRmgcweCaqZwCaWyC6uV1gkZrysg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6912
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, January 12, 2024 8:07 AM
>=20
> +/**
> + * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
> + *                            v2 I/O page table data
> + * @gcr3: GCR3 guest physical ddress
> + * @flags.glx: GCR3 table levels
> + * @flags.giov: GIOV mode
> + * @flags.guest_paging_mode: Guest v2 page table paging mode
> + * @flags.reserved : Must be 0
> + * @gdom_id: Guest domain ID
> + * @__reserved: Must be 0
> + */
> +struct iommu_hwpt_amd_v2 {
> +	__aligned_u64 gcr3;
> +	struct {
> +		__aligned_u64 glx  : 1,
> +			      giov : 1,

My impression was that giov allows non-PASID requests to be treated
as if tagged with pasid#0. kind of a prerequisite for enabling nested
translation? how does it work if guest disables it?

> +			      guest_paging_mode : 2,
> +			      reserved : 60;
> +	} flags;
> +	__u32 gdom_id;

this is not used in this series.

