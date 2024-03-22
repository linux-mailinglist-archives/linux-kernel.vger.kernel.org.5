Return-Path: <linux-kernel+bounces-110929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D2E8865CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCD91F24556
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F04749F;
	Fri, 22 Mar 2024 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ci+Ujw+O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951C15BB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711082480; cv=fail; b=PQvWrcujzN35tHN7sIF7mZap3OFqnAPDSXwA4hpoUIL05kdX3mzpXl2o7c6Jz3KV1Ktj4JCV2LuWLDN/uQIBs6kiUyarVrBNzP23oAu/LWgWnixW3yllsXuI/oBXLrGOFTS7TB64RAQ74ZJFc+7XVLifqwaSkqgoQShqJ1rT6ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711082480; c=relaxed/simple;
	bh=35OgBrjj1Oq3RNRJkiQ+Og5/v83oaGWGvA3hFVhF6EI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b3mV6nzP9laEddzmj6/Kgk+T0UX8LYJ/qLks8ExQ4kDqN9fvXdRvwU/+pGtfT0iF8tpwENS1GIobFw0K3NHtTfoeMoNlOPhp8J5c+zJRfI5xoK3sNvWHYBUiydnLWHxy7pNMD1Hopdc4u8J+dUhGAN8Z1GFOOjCiFIA8IxqJIYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ci+Ujw+O; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711082478; x=1742618478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=35OgBrjj1Oq3RNRJkiQ+Og5/v83oaGWGvA3hFVhF6EI=;
  b=Ci+Ujw+OxCxKkUVUs9red4jkeFN4JLfg3+lHXwPLtMjOCaQAupL35Z/G
   h9i6D7gzalUF0XUa1XvHslDvl7c7L62YP4NDIrri30TDr60yBYH3lAr3j
   be5Ywc+WX1KEBR9WemIUDpdf/jNlIcbjdqo+CIq2gIBK48BwAYHEapqq0
   FIXDt759ZkGRcWljjazIcMAlCu6MW3Ml7ARkpEygt2nZBmKFYzRo/igoQ
   MI8ofcCZ4krEWLFo5Otb28Sf2mmvT1LJDnw0Pd2wZWX3HdN7bDfnCICk0
   XeveyQDLnNfXqeKfmm+eAN4I57kF78knRWL6KQVMXtf0fnaRCiP9qebfD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6228883"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6228883"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 21:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="45759373"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Mar 2024 21:41:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 21:41:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Mar 2024 21:41:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Mar 2024 21:41:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu/NCPHFmwX5ByUJksGhgCXpVdOk1NcjiUIww3821RaA6FcP1drOC4c0uJWi6P4bueYvz7vRMgohIpHT+aVYgYLWpkqjzr0EhUMCDhzuLasgOPLXcADWqTimLgZViP1gE2BGkyh3DZiGtrZvcRLiB6K5OFLCw8a/5PMpv5TYQwAGdpiRwdUpY1eFqkRfD+c4IFCDfovZt5V+yunLdspZU+jqOebYQ/DmHLt06hj70gEfUwLJsuFrn3VSXv4dgUr5OjuwEFR0vdCyW1zzRPbXwLM0FY+JWhvBW6Dvsz7M6FpdmleM2zW26a3j8UFi8nYT6mCeKq7MoGPNxlBYhB09Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82YBMogpTn7XtPAPZEjukgq7kYE7AUtRHC35JEqH++w=;
 b=RjiJsbK/nVfAYkbEOj/ciBRzSE3T3c3pH7p8JCbMdYaEKJNIilC91YBSXvGXWp247PYN79iULQtkPxka3Eu7baGiPerOKXkPhi69803uhcz1Td3BNRoXHie9hnzx3/mh+Jh1r9wXaoJX1XAlYVaU7CVgVEzvVdr35OfVIKZsBZFWyUhcc3SdQoLth2H5eeOL3cttHhSoCJcrO7ADotEp8MwoVdWR8XVwhi7Hp+gKrqA+rzY73GHscXs5t/uSir12U4lcoYKY8RHLnhiXsfEJ94OscYMJYbZe4ImJll1j63jJ/jGH+gSu1TzUkamLV3Woq9Tv3m8EdRvv89K0mpNOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 04:41:01 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::5d0:a6da:a53e:e990%6]) with mapi id 15.20.7409.010; Fri, 22 Mar 2024
 04:41:01 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Dimitri Sivanich <sivanich@hpe.com>, Thomas Gleixner <tglx@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, YueHaibing
	<yuehaibing@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steve Wahl
	<steve.wahl@hpe.com>, "Anderson, Russ" <russ.anderson@hpe.com>
Subject: RE: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Topic: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
Thread-Index: AQHae9GquCYqZSMVD0a638cWhBmXNbFDLUYw
Date: Fri, 22 Mar 2024 04:41:01 +0000
Message-ID: <MW5PR11MB58815A2B9929D89F5B32371989312@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <Zfydpp2Hm+as16TY@hpe.com>
In-Reply-To: <Zfydpp2Hm+as16TY@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BL3PR11MB6531:EE_
x-ms-office365-filtering-correlation-id: 60fde1df-931b-4c61-2177-08dc4a2a46ac
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hTNmte8dxgZnZuFXYnkNHU1slxvOLpU0IK4enQf8hyVq9nl/2GV4Ea3orrNn+UXOebBYeaZExuEZodFxEVuvxspI3bewicND0bvZ1Se1MsTwX3bYSbMDWFtQLPzdVvx/eB9xeLryPFFo/bLVW89YXVyw3OwL6RvbEm2XINN5dj929vhB/q6VlyfatuP8+Y5VOVmyvcrVTfmbArR7ZobDV2wmgqalNAaZ3sI/xRaZ6HHxLEcslb67bo8+Ji7d3y+0XtAIJRhhcOotzjAM451GUrJAji5OcDzhTmn47E4lDJm7UnNKRpiGyhOCCf9/9vUZs9ZDdUnerj0XZWLN2Muw5rvKOWfQvRGLwp0Y5PRKCEgAHZFSey3LrMHmkBP0pwxqbKuS71LHJ9bjr226y0h2pU55WrExwhaid/A2N6Jq5jSsb1M8FiEYojOre4Rs8Z2ag8q1a2gOwTg0gDUQ7qmlmc5VL0PEeRsj9+kvi+JdLIfSwMX2kWVnm2pPsWV7odp3VM8SvKHm1Zww9976YnAUMkR6+nIWSq+aqwcJgM/EFNPhxvrP7mmNZNaM3AK7eHaoaj3BiZkJmzkoV58TYPaeNEorx7NYllyh2sRODFsj0gPwwCtNz370gsgNhMHUSgtOyTySdrAdrIwX5CSO8ppRNyHfY53hatTn85qJLK3F9P3Y6auKOUYxTjitXtXe8DoqkhCJAHz/JNrH7FFfSa5t2hfvxjxrRpXrpVgrDuKRB8Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6IXeyDPYVLEiUihMvkMpr56Yth5fxMphB4ZRHdP62SFdt308C5k0jXQrJ08?=
 =?us-ascii?Q?1IWa8R/VWUCVZXXcQz1Ncf4RmWg6F6hdMT5exnTv6MFOSLcdHnjEZsu9mj09?=
 =?us-ascii?Q?6+NULVUN72HrJQqVAFOWhxSGfW4bQ01Ys6U/WP24TwX4cnbVUlxYfmAP1At3?=
 =?us-ascii?Q?uYuwwIZnCXzVAqiSeex6qmiOV9O1o2ba4uT8Z+dLkWT+rW81NbwbFnA4hjBa?=
 =?us-ascii?Q?9ubuGP/bNzGHa0ULm2y+zcYv0LYerPrzI0AO6E5GqMtvJJ4LK7Eja+wW9msl?=
 =?us-ascii?Q?CynNmm7KzH1sZzC/4M5XA2D6lY/o28N6QrgKH/8gMVuh410VOa3vRyy/4HXq?=
 =?us-ascii?Q?TDoNH/qvjThbKt4Dv8RIg6AwIGGAsvklNCHARPOAVwL0LfCm9iygbJ7Xq+fV?=
 =?us-ascii?Q?tCT3kycCz1tXMET7V5Bq0Dppwuel2p2tXjVBmliVo/W6lqadKBCvxYJcgEfP?=
 =?us-ascii?Q?MEt49GD+GtbRREfStQQw1Y+xVFcAX5vHYUf3eG1/vAarydXQaa2PmpBPMdzz?=
 =?us-ascii?Q?s3bzuOxQt806VSQ4umuZrq5bSjdcPARa1Y4dubAtkBPpb0bE3atHzdhGb5EQ?=
 =?us-ascii?Q?2XzxMCISAuE9hW4nHARAtjyXJFURpudt9xvtrzcG1HFtevLVVtBNy5ZnVvhm?=
 =?us-ascii?Q?wAhl2y7x6MLztafRmMnb47j60U/lxZQM0wTrmFW62Z78qSZT0OOZmZtSjAfu?=
 =?us-ascii?Q?7eRc8wpQHTDXXjg1H4ru4WIlHPPo7HNXQ8cRtbbDRivxTD5YhL+cZGESzHEe?=
 =?us-ascii?Q?/UasET/lshAomQ6WMEJ3sXzlbQfVMWdrF53G8xg3KtYfGbkCmomhGHvieax8?=
 =?us-ascii?Q?nzkcCdbH3NdaeP1ISclAvZXkXBR8yhgTSmjOALjPz0a6VoCNVKFJ36Sd7SvE?=
 =?us-ascii?Q?usjIZtREH4sQ6De3pKY6dvUhRADU+tRQUvuLUP7u5zAYbVD6sHj5eFzFEvy9?=
 =?us-ascii?Q?iyewSEaAMwMrEq+4h4EGwDMRtEUy87KCxv97qHGb9IS67m4BnF/g/4pljOZK?=
 =?us-ascii?Q?aZwwJg7IA0SD9n70FN4WDBt/XRWmQr1DWRfR1OiuhJUHSPhMAKlEMwc40AWP?=
 =?us-ascii?Q?E8nNHuVTWeqT5pTfWV1XWRDFp4t6aMVrbwdKACycQF5VykgnkC/e+TabMBis?=
 =?us-ascii?Q?VlAxB6AZXEDgB24I3/tfTFSxqHGC8Qvt0gYQYZtHUoef2MNgOKEaTk2DPyf5?=
 =?us-ascii?Q?fxsXBuz6OILypRTfMfxxI5W5iQHeS5ufZGwH06Y5m93hNjrUR5NjrdTEQ9Av?=
 =?us-ascii?Q?dpUn6dqQMKN6LjrZ+/l0LyBTNswcIleLhaL/qf1l7OkrSvwRdDmQt7iPVh+d?=
 =?us-ascii?Q?Q1/Md/Z4vN1nTNjE/68tm1XAoJUhhf/oCO+t9LbmW5eVL1vu/WZHmGsS5+jw?=
 =?us-ascii?Q?yvIPqw0OkE00ZjbepyY7Bc84FwQfzypggNxi/xIUbvYWjKUtUp1REnkN6Yh0?=
 =?us-ascii?Q?pZLujFZhFgN5JNCbyQ5uY8tXqnRuRf+/eAY1MmxOyTcH0+5lXDbxpQmWSqY6?=
 =?us-ascii?Q?zkGXKKs5K8VBn8FN1zYm9UQUl+Va2jFgn92XxBgylTDCPFHn+wgUMKds+5us?=
 =?us-ascii?Q?cIFaKcfO01DzHt1PrGOtEzyoInWLphRmb09AWFzb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fde1df-931b-4c61-2177-08dc4a2a46ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 04:41:01.4395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ee0LZD0lg0htaQdjjepmxdjun4pOqpYz8fvEbNJfIzvcVIiwFruwGLpXNldrJsnywYJdrfxl3hHIgCg4Pfmpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-OriginatorOrg: intel.com

Hi Dimitri,


> -----Original Message-----
> From: Dimitri Sivanich <sivanich@hpe.com>
> Sent: Friday, March 22, 2024 4:51 AM
> To: Thomas Gleixner <tglx@linutronix.de>; Joerg Roedel <joro@8bytes.org>;
> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>; Will Deacon
> <will@kernel.org>; Robin Murphy <robin.murphy@arm.com>; David
> Woodhouse <dwmw2@infradead.org>; Lu Baolu <baolu.lu@linux.intel.com>;
> Mark Rutland <mark.rutland@arm.com>; Peter Zijlstra
> <peterz@infradead.org>; Arnd Bergmann <arnd@arndb.de>; YueHaibing
> <yuehaibing@huawei.com>; iommu@lists.linux.dev; Dimitri Sivanich
> <sivanich@hpe.com>
> Cc: linux-kernel@vger.kernel.org; Steve Wahl <steve.wahl@hpe.com>;
> Anderson, Russ <russ.anderson@hpe.com>
> Subject: [PATCH v2] iommu/vt-d: Allocate DMAR fault interrupts locally
>=20
> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> vectors on the boot cpu.  On large systems with high DMAR counts this
> results in vector exhaustion, and most of the vectors are not initially a=
llocated
> socket local.
>=20
> Instead, have a cpu on each node do the vector allocation for the DMARs o=
n
> that node.  The boot cpu still does the allocation for its node during it=
s boot
> sequence.
>=20
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> ---
>=20
> v2: per Thomas Gleixner, implement this from a DYN CPU hotplug state,
> though
>     this implementation runs in CPUHP_AP_ONLINE_DYN space rather than
>     CPUHP_BP_PREPARE_DYN space.
>=20
>  drivers/iommu/amd/amd_iommu.h | 2 +-
>  drivers/iommu/amd/init.c      | 2 +-
>  drivers/iommu/intel/dmar.c    | 9 +++++++--
>  drivers/iommu/irq_remapping.c | 5 ++++-  drivers/iommu/irq_remapping.h |
> 2 +-
>  include/linux/dmar.h          | 2 +-
>  6 files changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iommu/amd/amd_iommu.h
> b/drivers/iommu/amd/amd_iommu.h index f482aab420f7..410c360e7e24
> 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -33,7 +33,7 @@ int amd_iommu_prepare(void);  int
> amd_iommu_enable(void);  void amd_iommu_disable(void);  int
> amd_iommu_reenable(int mode); -int amd_iommu_enable_faulting(void);
> +int amd_iommu_enable_faulting(unsigned int cpu);
>  extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;  extern int
> amd_iommu_gpt_level; diff --git a/drivers/iommu/amd/init.c
> b/drivers/iommu/amd/init.c index e7a44929f0da..4782f690ed97 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3389,7 +3389,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>=20
> -int __init amd_iommu_enable_faulting(void)
> +int __init amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c inde=
x
> 36d7427b1202..7644a42f283c 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -2122,7 +2122,7 @@ int dmar_set_interrupt(struct intel_iommu
> *iommu)
>  	return ret;
>  }
>=20
> -int __init enable_drhd_fault_handling(void)
> +int enable_drhd_fault_handling(unsigned int cpu)
>  {
>  	struct dmar_drhd_unit *drhd;
>  	struct intel_iommu *iommu;
> @@ -2132,7 +2132,12 @@ int __init enable_drhd_fault_handling(void)
>  	 */
>  	for_each_iommu(iommu, drhd) {
>  		u32 fault_status;
> -		int ret =3D dmar_set_interrupt(iommu);
> +		int ret;
> +
> +		if (iommu->irq || iommu->node !=3D cpu_to_node(cpu))
> +			continue;
If iommu->irq is set, current logic will clear any previous faults by acces=
sing DMAR_FSTS_REG. However, the code change in this patch seems missing it=
.

The current logic:
int dmar_set_interrupt(struct intel_iommu *iommu)
{
        int irq, ret;

        /*
         * Check if the fault interrupt is already initialized.
         */
        if (iommu->irq)
                return 0;
        ...

int __init enable_drhd_fault_handling(void)
{
	...
        for_each_iommu(iommu, drhd) {
                u32 fault_status;
                int ret =3D dmar_set_interrupt(iommu);

                if (ret) {
                        pr_err("DRHD %Lx: failed to enable fault, interrupt=
, ret %d\n",
                               (unsigned long long)drhd->reg_base_addr, ret=
);
                        return -1;
                }

                /*
                 * Clear any previous faults.
                 */
                dmar_fault(iommu->irq, iommu);
                fault_status =3D readl(iommu->reg + DMAR_FSTS_REG);
                writel(fault_status, iommu->reg + DMAR_FSTS_REG);
        }
	...

Regards,

-Tina

