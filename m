Return-Path: <linux-kernel+bounces-529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFF814285
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608051F21FB7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E92107BB;
	Fri, 15 Dec 2023 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jh17dwpF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F5DDDD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702625721; x=1734161721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/+ijIgb4ca0TxZ5R85wwMNwpP5KHQfk6FeXD5B+EEEU=;
  b=Jh17dwpFHpMUi0N9meEQ+lJ6MONgobWAjezxYAKtkvkRFFOz1OwhQnMn
   GPhtXqdJUap+z9St2WPdIIZ6YNk7PW2gibgYILyfVlfbPnodkkJLR3eXh
   wBZI9M6ijrUR5y9II32ViVKPJgieLNxCyhTRaCyuA+IPfZxSE9GRcmGbu
   gucDmR1vxwqIZjK7Bssv4JJpclxN5OIimTTzjqWMWnp1dfdHCZm89wOKQ
   Bqm+nZGplFt7VPKwnlukOALazUm+q0hYqEaRZtJnLVWFWLsdFlsBiFq6Q
   MrVi/xm+ufmzU8sNGiTFG5M+OjDjmdDRnuQBHkOa3t9MUKuBFgyvDAlVM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385660133"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385660133"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 23:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808874530"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808874530"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 23:35:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 23:35:19 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 23:35:19 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 23:35:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbj8VDvIg/IJZK9nRwWme6AjAyHCrCTFydaqpf4oHnCz93SE8ntWKCY1GpWBau6zyLV6HZ2Ws81uBKKUeSaSY42D94efNP+KsRmlp6UqgifUgJqSFhMg7bwZ1fSWP2GWtBPnNKgOumlxMk+kEIXgJkWRBIk9aCUDsmMbJHVMFvMUaAJ2HKnf7aXh6s2jyVbSRoVmUnFPhm33TbPi343QDZ42d8Km98DY+SxjptM0xy60X/WI3trULnnuMaTzshVVMq0fFnIQ6zI2dNhxnvwNGVWbJ2v8ClhbMTg+G2D+QlWlbk6OZKQdrG4DQV8AEWJa3Q4wKBIHusmOaqfC0Eyb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+ijIgb4ca0TxZ5R85wwMNwpP5KHQfk6FeXD5B+EEEU=;
 b=HlLnsQ4Gt0KvEIy9Kwg8pUy2HXpLJ9k1u1MQGDeVxsbDA7krZm6t6FnWA0zOfTE5OpQoLqfgvWaZI3ywSmTCvR66OfewUvyLrhH55K845JB1c8dAIjyDImGcljxP8SLyabq1fbDHfNQdiYYdJPMtyP+1oQAG4S9my+OchbXVgnAOp0OU3CeM1LUMNz6dyTdwXV4zeNukNugbg9wcBk6TatVQI6icbWASrWAOck7fm4sXlVxbCuo/H1QWh2/QQx9LDT3FrwOjK7OhpA71SPRB3nJ3EPRFgIo3Bc8smCapgLdvX+XXcHPoIesWsKUCUbXLFO/P6j/X68skW+h6o2Cd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 07:35:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:35:13 +0000
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
Subject: RE: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct
 amd_iommu_vminfo
Thread-Topic: [RFC PATCH 3/6] iommu/amd: Introduce Guest-ID struct
 amd_iommu_vminfo
Thread-Index: AQHaLRSflYczFnutX0Sf93tfLirsb7Cp94qA
Date: Fri, 15 Dec 2023 07:35:13 +0000
Message-ID: <BN9PR11MB527634DAFBBACC20DD691DD58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231212160139.174229-1-suravee.suthikulpanit@amd.com>
 <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
In-Reply-To: <20231212160139.174229-4-suravee.suthikulpanit@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 67c0cf1d-33e4-44d5-c3bb-08dbfd406021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lEhzqyraVbJlwVVlCYvqO2I5KTJLpu4TrI1VNmcpXbY3oehnmlg80JcTbW3goqZphoCcWIJe1Y7Bi8fMn+P6Vpohubl5SjESaksvI1jRP7pb0VWkSR61aGlZ2tfTyjc5vnWoC2u7ObFb61+EShxt8FPgn+Qg83As1i+kwtnHhcuycMjK529HPz9STB6dnqkTPkjiZVsGxpk34Wg8b7+4VQNIeTtIgJ5yeHZbaSIFWEV6NzrNnNavpX4wPcDvagMe5g44CIOi35L7qOkkAFM67YV36LeDMqnL1QYwp9pJEWDa4LNuKy/UlfWlWhhtvZQyygg5+BlswSSM3nNZ85QHYh/wQfaAivEyupEF6FirWREFWVwri3p+TA1r38PHhFHP/xE0hTN0YeS5KXoCaOUjh0BEQXfSDeYvy8d9ghqW2hFmayJK8GCPl5/P6JwB7gQNzQwyDjUMuQcLL8BmsKXtodUIv8V+ts2C0Of666RqM9Ubko/tquLxdaWR3FV3rreDHWg2CsvgvfbEuJF/8j0PH219KW/QIw+FSCUdFo0izG0GNmKmwO/sPKrKarVaVzkQcutCpwOIdks6I2MuM/iPulBSIdyLFZ/Igz7P52BhQ1SZpBWz37dsVKwCONRUZUIE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(122000001)(86362001)(82960400001)(38070700009)(55016003)(6506007)(478600001)(7696005)(26005)(71200400001)(66556008)(64756008)(52536014)(4326008)(54906003)(76116006)(110136005)(66946007)(66446008)(66476007)(9686003)(316002)(8936002)(8676002)(41300700001)(33656002)(5660300002)(7416002)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5LmIfLIs+pKWD7QPKqTp82NI7J8yqWF8e6E+0WOPyQN6qFisgcFU1H51vyns?=
 =?us-ascii?Q?t0lpR1n57uov324M8ykpKuyuqzvyYQo0tn4xKc+aWwYJzcnQgTjZcEstiTL+?=
 =?us-ascii?Q?JuExzXbaEmWRpskI9+XSh6mYWWjC5bAoTPbHY+nHPAoE32eXpnDI+Gp4YRuu?=
 =?us-ascii?Q?pb+iD03J6MYV0AuIzCNhMsjN9N2XBePqvQqiUB+Vwbx3Pm5Ry3woT2LQ8F8V?=
 =?us-ascii?Q?6C+BBbyILDvFisfPtBhyIlD9j0XDlII0b45CDLqQdxgN5kfzo6Fd/LTE4xJX?=
 =?us-ascii?Q?bafwkwsb3YHgsDnn4aEkq9UWijw5gJf/Gx785wAq1NfqD40xQGxrFtaxsRdD?=
 =?us-ascii?Q?4o3goDexERzj5YRMxDAhtLlPxlqr0ZD5WAxqIShXC3zJyW+trK4DfqfGEFTT?=
 =?us-ascii?Q?v+2dudnA9Qw6nhTcbg3pbI/kgLVf/e1eIQIPqE5tkO0ZVSe86/efKg/y0tkp?=
 =?us-ascii?Q?hQfZ1ZhWEASas2nbfaf0bZ8XDyYERZRhJSoo0DB1BKwvAcAZ87Ums3zj1e++?=
 =?us-ascii?Q?oIvV8cOCjKeDyV0F3X2Qf8LP5sxa9phfL3Qkyf9ky/Gkyq410Kz5PbYmk1pG?=
 =?us-ascii?Q?l0It+KeDxSEi3DPb6q+oyf7diAPyS7SYsMQgDR2qnQ0MIP7662POfGB1OBw7?=
 =?us-ascii?Q?qvykI1NCpv9S223+pmOiKwAv9PwoUX4KXdLBZicYaC09hrtOBzJVkPDnxfiG?=
 =?us-ascii?Q?pX4D5jk86DuNO43c0xqIO5P1yLRPWamBuHYjJLqoeWPWAjsVNS1i69QyhMkH?=
 =?us-ascii?Q?pYKy1lJ9Hw9F9wk27M1p0zbKfG3ZUrca7lQqzaDYPsh8nFQ/Vb9OW1rehpYA?=
 =?us-ascii?Q?StHMvV96QYbIXczgCuclLFRTjB9isV50rWm0ERyn8FbYENtaGG8o1NFrySOt?=
 =?us-ascii?Q?fpIHETiaEj7/gmzsqhybsh7ryYhSCw0QXDoofR86srMa6VAq9biSwq/5iWX7?=
 =?us-ascii?Q?GT8PA4MFNk7jrp3jDkmc0uXx8CWEJ+wiYlx9Uoh/kzKd8CsBQbCIO2QlbqCR?=
 =?us-ascii?Q?X/TjT7n21GC+kA0DuvbjBI4AK/dpvIiqiPns9REGeQ2cOy8wekJPdVzhBx9n?=
 =?us-ascii?Q?5uj10ki6ZeB8H5PMl+9+mPBIKYoTAk707V27xigA3mv/BlibIXDVuhuZRFeJ?=
 =?us-ascii?Q?X0ZN5QwDV3yvvf6XRIbot+/p/V+H/paB+7AnCp98XK3dAg7JV9TwhXddixHu?=
 =?us-ascii?Q?JDXCM9gcKei3mrgnA5AIe8HTbWGdPqbwKxK7TzTL4MaQk8htBoyetRsKCiqW?=
 =?us-ascii?Q?W0ug12Y0rjJTRyc2KAgxTnUz1cbiOlZfBw/0w5MZOycxR4sI8IZCjWw7Yldj?=
 =?us-ascii?Q?awXPqnzsCUTZZkYbcsYQhKq6sbmViN5Cb2K4uvNxb3EzNzxAVWglIDR2jiIL?=
 =?us-ascii?Q?4MgI0Ye+8opGe7z6W7qUFUiaf3GVQIAEl1yUUSca89jxUfIdRxoAVB2tpk7Z?=
 =?us-ascii?Q?IQetSPb+D4VJGtMSkKgGH2qWbtGVWC3jQHB1njf4/4KKGtqyQjItiiyFY58S?=
 =?us-ascii?Q?AkLPnUrnK0HGJt4d2vQAgpmQikGTrMXDPSZKpKHa6FHBorBEDYnHd3pgtCkR?=
 =?us-ascii?Q?wDFSnpkFUNrWgoJzmgeIbGv4ZyIIUB8PWuPlr2UB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c0cf1d-33e4-44d5-c3bb-08dbfd406021
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:35:13.5058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiMbR56WAFq3AG6gaYaZh6MA9kPXODNbNZo6+0GJM2jAhU/OI2UOIYHVGmVKbhRnYs8N+2/dDU4I+2u0Sbuc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Wednesday, December 13, 2023 12:02 AM
>=20
> AMD HW-vIOMMU feature requires IOMMU driver to specify a unique 16-bit
> Guest ID (GID) for each VM. This ID is used to index into various
> data structures for configuring the hardware.
>=20
> Introduce amd_iommu_vminfo_hash hashtable to store per-vm
> configuration,
> which uses 16-bit GID as a hash key along with helper functions.
>=20

somehow it's unclear to me whether this series is only for hw
supporting vf or broader hw supporting nested capability. for
the latter case is GID still necessary?

