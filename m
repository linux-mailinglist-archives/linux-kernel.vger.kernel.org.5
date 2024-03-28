Return-Path: <linux-kernel+bounces-122529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 478CF88F91A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45E82914D2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125D52F6D;
	Thu, 28 Mar 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LGzJbfoU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CF39FC6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612216; cv=fail; b=XGs4/vBVEOz91KwrDZOMowluum2Zp0vyju4Gc22/iR2ChQ377C5gptY08sDRPRcXA4JlaSuWuYNEYLcv9zq028WLQG0tRdzRnq9ATdcwipMgDIs+VuGM4kqe5e2SvihefyqnvgQYBNvd5NzID0o7U2eFwFfUxBABvwhSl+phLrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612216; c=relaxed/simple;
	bh=m0Dlv6CnaD4Lwwkab4PbEIlRITNP8FKpV/KFMIvIFOE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYziUutYuoAJhjDgqe+iC72hXsxgQ88zvgP/Y/2LiGLXMX0KB8FYM9WyFXI7Ng4wpMKA47tU1JUuXUGASDLIcKxklm4j29SyoeHdbf0Tm2rlZH0BlINTjpqBCK9VBe5Yob2LDXxOu0G7soC5ci9isMPpzigOb5f/J+OCJny72Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LGzJbfoU; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711612215; x=1743148215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m0Dlv6CnaD4Lwwkab4PbEIlRITNP8FKpV/KFMIvIFOE=;
  b=LGzJbfoUD+YPZr6mKjFo/lWBzl6jTtXm3XPO4L24UIvrLGmeOUsH4M9p
   uLLcW0pXvhGbpVN2fhRpzFPUU61B8mDzQr1nHWezTbmO1kLJVZlBSyZCN
   tFSBwr21tbm+ci19r+2mItdeX9bbT+vx5xiGcNZxpgeJJLcwKji9up6k0
   G8S6BCNSFPh56Ruysaa2SpRdEgL3f4Zv0TKs/SKCK1broRjk/JkggcwXE
   1K/ePD5IvTcpfmEDeq/EpfC4R83RfFT3R0LC2kzGPLzKLAs0riHBkgKfF
   RZT11pn3hK+9gI3fz3rWIYjLl4hryEedzLf3cw4A4wcOgVUBzlbJBjDcE
   w==;
X-CSE-ConnectionGUID: shXVeiZFRkOl5mfblQxfmw==
X-CSE-MsgGUID: g8eABIvJQNqdxgYEC2dNlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17478101"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17478101"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21226887"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:50:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:50:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:50:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:50:13 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQpYmRAY/ce2+xL55tF/uO0dlkl8j9B85CPRzwBuWozw+9dCl9F6FKV3ClnJku6LgsBH16KQUxKEMFhYEX6wCnnvS5TQvqT2d2tO0evrIFdHkMeEah+aFRPIM4kmL4QvxeCrEFNS0ly0Q7Zmll+WvWM2oZdg+CeFaEL+aJNS28feuLsw23SBPaNY0dv4TxebaI57zyMR8yuNnytq3uVifjiFPIth/VheQehm8zoaYd/B+WNU2UoP2WAPnXROtMU6pG64b4IVm/KyycZHP+vu+wjll09iTE8vLpOOj16zPEdiaxO4Sg/Xsed5X+2oHcuwzrtRgGeqlsYq+GXLKwYmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0Dlv6CnaD4Lwwkab4PbEIlRITNP8FKpV/KFMIvIFOE=;
 b=AGdjmPbWZGve30aWHaZBom+j5hVX6ZGe5AeIe52jBNhjYeJnDK/0fpg/afxKKWhtUfHD9ULzwnAnHk7RxRtAEk4bnNCBkfEMIFdgy+QOm8Vu15Pdp4DYJRXbh1zOIUs8YBaZmhJE1b7+x9F1dXu5U/ney+87zsoZvbiTEYizDEXQIFGKq1RuWNuQ/snPfCKEOlC9DK6fUQIJe734rtlTCS382RWmLHovbr7RRPBrUYSoEsXwRFbj382shTg5Rzu0GOSudbQAFxkzcU8YBtaDMhPtQi2ZVz5ekA/tdtmufIIL2GWyKdBZCTGrkMifYU6O8sFDsDlnEqa7LUhkWn3O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 07:50:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:50:11 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Thread-Topic: [PATCH 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Thread-Index: AQHafltsByQh7ckHwEyzV3jciVckfLFMzEuQ
Date: Thu, 28 Mar 2024 07:50:10 +0000
Message-ID: <BN9PR11MB52762CD9DB4CB9DFA3C26A6C8C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: 5eb4d9fd-7bc0-4ec8-3fa1-08dc4efbb1f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECZx07Ox/GN6wB+/jur5X2SVgx6vmQCs2XmkMD+U4347MkmYPQPaaS+SH7gyYAARdNdXGb3E6ycIIvKfoDMXKo7f+4OJtRYN2r467x4SYuWq//Up7Agx/Lk4CEEBRSK2XxNv5VgqXUxf7TI0G3DYOVVytM8DPLULsgxNR4A2/hm+LQmoDj7Hog6Hs/EFmGsYlG27SbLByvD/sYI4EXjrhGHgarkTPqb37ZT82ZpINL1M5FN4Kpz9SzS1GCCq05zHoJJ2zOn+2tvw/hZFcCr1DPpPBDu4cj8aY4f62eVlJ4mbCv9jBe0kBsdjNiX8riQKDbu6dkmhLRU/dsg6Jfqul1JA5t3JeLCuVBiLSDcGEfovAY/8s20BYR4AyXOKkTx36QksNQUnOQKVHYuvUXg+ya94f8QJEDrS5dxXwXQPpY6Dl3cKjuGSZLzG9zGcFzaCGUSLWrJq45TFU30YIV3NpDx3WOGJQ5NlkfE6FHDXuGYmbap7Uyxc0Dr1D3nbm6+eiN7RVJSBifwP0JLJBaLfhjiOzPabhfwIgF688+kULMj0PuhV6r+qoKZlRe/bV/GnQApDtwhtPL9vg/iPULGsABztD9PMCxf3Wv7v4vST1L0wsS8URS3kHvvHHRNxSTHHiW/TBoCDXXxRZvKpuKFH750MZgrwdYTzHtY+twJfVnUJfJXPPdKpdp5xFXV4z9Byu7vhOocP6dtdR7tjaejtKpb8+vRuqssbu0fuKBGeSNg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jD9yKKAGIs26knkLCnOVR3CFTmuZLbGKW9JNRblETW1SHQx6Jr1esnQCBjy1?=
 =?us-ascii?Q?CPZvvygovKKjhp0UF0jQer2eRTWJygffYi7D9KjbxZ4aSPM5YkxC9ny5K/rj?=
 =?us-ascii?Q?ZZe7YGBVcqG0G47CZ4dY1UgEJrQ6IBWciulptcRftIr/li8EEFGgJuJSfXl6?=
 =?us-ascii?Q?z/gS5Pcn49SSyVXjHYaXo49na6vQ8A8h7u21qEOCVzguKo57bhfsPUZrbZU5?=
 =?us-ascii?Q?op224cSAOCv0AXyQln9s/EfyQyZsJULSxZ5EhgEDfvprk0NYwLLiGtIF2qfi?=
 =?us-ascii?Q?eQIz23PeNXePzvM4zgQAVj92axfx+KhMxbkXZkn2OMsaMaMmcdjP/4TKcj+q?=
 =?us-ascii?Q?p+rKfFdnnDVWxBmGk4fEW9G0j9I1cn/dzHBoO4KJqDFTQ63n1Q6bpxxSndnc?=
 =?us-ascii?Q?4d/ht8jULT65loKyhlsIG7Jgydjnvny8/QGlu5JJBcUqDjypIbuU+l3QqMv+?=
 =?us-ascii?Q?BdUmhSslBkNPr5ZK+AROBZRdGic9nwBNrk4SOItEQqOd+IQDa6H56E6leCkH?=
 =?us-ascii?Q?EN6v7EcfsgDpsR/gb5drWv725JfBpeZBzyW03oXiAnnGI9E1OCIvNgcEuvIn?=
 =?us-ascii?Q?dbrpH+1qHOHxhWOPK9l56OYXDkzKJz39IReXgGL/NMTUbDwyeBOpH1Cpbcem?=
 =?us-ascii?Q?Lkvvu7mb60aDezjBRwlGS2E2UzDXCvcV9aUIyuTDUeQGtZS4M4vG7gr8gWlG?=
 =?us-ascii?Q?B71rnnoA8aPoooJlseuLVSFQosyqBLsMIyFIZRlyUGVnDuWpEziu/7GqrnR5?=
 =?us-ascii?Q?uPYC9V/5OQP1shOhS3D8GUL9mikT64yRCTWDUHMfiSzv3kukWIq9AjPQ2+Cw?=
 =?us-ascii?Q?2W0/XXb3p7GMkeNG6hpNBuZpsycgbzG2vEYS04FIICI3SWl34aYFEuCHHOP4?=
 =?us-ascii?Q?HDeYJ++B65Qd+klsCzUF2yFtHWfjtFJQ0IAlDa72CMPmSLR8/4NH/gTpXp7z?=
 =?us-ascii?Q?laojEfzHZ1/dQadbe+WMAchJri5+48sy8BCVj9KQdKqo2sXs+QJp5GEOj0Xu?=
 =?us-ascii?Q?7tAsDhZF2xWtMWWp3DvDH04lCneHivuaF6dzoj1YS0D31TwFGwy+i66FbWGP?=
 =?us-ascii?Q?OGDr4HmTPEhXqLsbhl6ribDUja3P7Kgo1dNoLTyAbV3IcaxPS19ax/ycFnE0?=
 =?us-ascii?Q?up5gv2sr8GtA2eHYHLdni+Melc0vmYrsJV5a8jhKvKj0IC+HatOPfkARx5hY?=
 =?us-ascii?Q?5gUmQG0399YdsCkLTMtgvLkLP/iZGoDLibTZKwC3ZK5OIeG/VZ39LEag//Zs?=
 =?us-ascii?Q?i8QpJvb6dOpup+l00FamKOCF3iOjcANLWRqf8zk+9xGB0t2Cky6b7qd+VFy7?=
 =?us-ascii?Q?6wiR1Amp/1lg5AejL8+Hu5ZA0u41Vt9lMH6uf3jMIVFp+orxQchqEHExgGVK?=
 =?us-ascii?Q?rPAube73qRxy/p65LNno9kA9N6glAH5QD4W4IWYqDs5lnfr4e13oj1v/gC2H?=
 =?us-ascii?Q?cWGUAkOHCjBVPi6fQ4DhzmfMgwhPY6zjC2zx2q0c9Ga9MAwsfudqXpoiYO++?=
 =?us-ascii?Q?lGuU5QNnukSl4U+lpk8JBp46B9qYj+KlwuNYji30PXbfRGQgLE7UbCOjLC7g?=
 =?us-ascii?Q?6Sx8QfXbJ45qSK/yErrrTj3amCsj/4uj8Wn0SerT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb4d9fd-7bc0-4ec8-3fa1-08dc4efbb1f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:50:10.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +s7QAZ1+m6oN5czDEH7OUSMcWHletyIyZ/RJCkp9j+dM0bOEeMmk8v+2Hol17Ev5PwPiJwpTLPVUrnd7FvfuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>=20
> Use cache_tag_flush_range() in switch_to_super_page() to invalidate the
> necessary caches when switching mappings from normal to super pages. The
> iommu_flush_iotlb_psi() call in intel_iommu_memory_notifier() is
> unnecessary since there should be no cache invalidation for the identity
> domain.
>=20

what about a software identity domain?

