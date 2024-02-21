Return-Path: <linux-kernel+bounces-74249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E7185D197
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFBF52859B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BD3AC19;
	Wed, 21 Feb 2024 07:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjVrC2+E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A4B39FE4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501317; cv=fail; b=BEwS22zBMg6ThcHdN1zz4fxyv2X8Ir6JuUybSiw0lmirf5H0MpvUnbTJJEd+HN/PcKywsYWY4NV16xfkMZTkxbKASwYFbVGDN7FtS6u7B2q/IHZjYPcUSx3nz8T8d4EnRC/hxpuCBkvjSxFIprDmVnzdoPqcJoqkSyGPCYfz0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501317; c=relaxed/simple;
	bh=y+dTge0nwCee1C8MEKc4LoC1IdeLp5aMo/oWVAvYb5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xt6BdtrgZCNRDBzLkabShlwfzeEgvJcO8d85XNHQrgIdqqsmHQg41KJwrn6l+paNVTI3MMMkpZntI8SwC8KUJf2YZqhKujABjbPjEoAj6chu+VDnqyXjXZ39M+N1sWy/HM4dP9NggE8N2Hzw1t/79Gxu9k3y1YUMD8vb+A6Bxfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjVrC2+E; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501316; x=1740037316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y+dTge0nwCee1C8MEKc4LoC1IdeLp5aMo/oWVAvYb5I=;
  b=TjVrC2+E+H3bihBcYwra5JuDTIw/mdqeK6lwUMfxbdCKaTiDZeQfl+YA
   WlJLlGy9YBWSk3UvGvRG6r9eTXkTWzMeeoZ6bKGSvkkxW9MdO4/SEF2Og
   6NTiSLuMKE9IPfGrOAyGbX8MxcE1DiRFRkubXt/A0x8NjcMTZiabR2JGj
   Yolf4dkG0qEoNMWu1R8OWz7sVfeA1lsUCfSXvbSA1CmvzOzMKdBhcwhr5
   f01pE2GpXWj48A0F17s8w+axIniwDr2USl9MRKVzu1C5pmHDFAhJOC0xj
   /T+4+qbZZ3ymnyaVZ4Dnj7L6t3o0+fegqchh1UE7qrQFPFBhV3q9VP6vh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25108697"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25108697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9732021"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:41:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:41:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:41:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:41:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:41:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzJdv1f+xUUZHiEZ/QQWJ4MNJdAchZ8arPk9ECaOOOUWzIk8+A4etQ2Nm5wcjAg6lTT1u7bpNfWvr72STrdcsg1ttW5UkKDRWraweBdxhPzQ1RFF2jCOXGBLG26gFeVY7D18UYy6IFSzht5KmK/5g4ea52iTMLz/8QZxSbEEJnsXjN9fAmwx8jJBJPiN9eeeaSlC0e3qRxnV92+cR212HjfqhJyBrPt5m8b1srVLjp2VhU03nyTGDHZBRx21sPevUwFmZcz0THQ2KrLeMztoSxs8/Z7ShUxNLorNtlmkpFQ8qzQwLQmgebS4Wa2HFkw4EQPgB/UmigX0y7PhpxQuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+dTge0nwCee1C8MEKc4LoC1IdeLp5aMo/oWVAvYb5I=;
 b=cv+easPUlthFaWsZiLgRNPFMZvKEcvprb8gqDk99p8zq4cWg4VNuCKSrpmFmlQ3M0R6KHYhYkNvWnIokHjx4kEP5/6P5QtFkacQaEngX7dkXQSJ3nqDaNBhnKAtsSpqbItgVhdZeJJFiCBJNnRpNfOFFOgV1qR+aQu08cy6Wf7/XL566XcWUk/AFYx0S0vmilqzggWLJ3RjFstHuaIlooC8mI+4S72gj6pEZFmVdtMIUJheZSDEq3o00QxVo6wJL/cZhHrKd1nVuyfF5liK2vOGj7VejwmgzaMtbROkvbv6NFZ2xN3jei6otgie+Gc5eQNVNrXWOb1lETjlH9VyJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 07:41:49 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%5]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 07:41:49 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen
	<nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Hao Fang <fanghao11@huawei.com>
Subject: RE: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHaCGlssGjjzrsBKkGGlpOPTcfts7EUImoAgAB6i1CAABypgIAACqiAgAAK1ACAAE6UUA==
Date: Wed, 21 Feb 2024 07:41:49 +0000
Message-ID: <MW5PR11MB5881B3EA808820BCBCFAF72589572@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com>
 <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
 <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
 <CABQgh9GxQmGU2HR73bSoZLuf4XZFhThXwUs_HJx6KwxDmXrXgg@mail.gmail.com>
 <b05958ba-0c47-45ba-8159-372779f9cc8b@linux.intel.com>
 <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
In-Reply-To: <CABQgh9FFpL=mEZ-7PqRRVg1eniYV176B7USbGP5MLPvhJaGo9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA0PR11MB4576:EE_
x-ms-office365-filtering-correlation-id: 91fce194-a6af-44aa-45a0-08dc32b09004
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fx8hOfXsHWH9HtfGUv38UwtUnTP50/rWR9yyawqS5zvd99nKlVt5lQ0jv+F9nc9eLKspXQlOew4dGJdAuu5ZBdcXo5uZXbCP/d+QcHxgnX8xMA1QAD6Ezfo7tYJFBAyds/D4ISOXLFsAG+vtQdnr9vhdBh5eUrP9cmbcduGd+QHYGKlxmpe2QV0VCAOz7t9Jh7c6+uVKpoQVDp4+Y6wpyLukX3OWDptfrypyHKURPaq/OUfv8rXMHcFx7FobJQJKQdAMNL9W+v477WsGXwTB2R0tD5BhmOcNUu5Kbmcz5wxlfEgyAN3LsqpHDqG52CEkEbx7Id7sBPj9OWF1In7CQp5hQTP4dY/XN0xTMM836K5p12rq0mFVPb5Byc6jhfNknE5Nmz7cmAkNVCPyJNc+HCz+Pb2d8X8SaXkLVZALO8l3un8sWBe7DXgWgMfRPv4fohne3bUx0VR93Z197+e+CzROpPQob0TXedMbFANKmE6JlJDpWVH2MKRbmvc0R6ekGXWJz1VR2gvCLPTrRod8YZA3JnzgLofQLEWmK4KXaBYe29bjpC7e+ys3Cry0PEZ3B5x9zc5jAAAF6kM6SiAp4DlEKguhvOaY2owMuiWrQ9WXoJDj2i/Eysz+2NN4loTT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eElnWm10TWtoR20ybUNYb0RMNWhOTmZDZVRYVksycFdEcURuaGlyTXVwUkp4?=
 =?utf-8?B?Z0ZYR0k1aldUcWMvTk5BUXNQUXBEOElRaWVnWk9LUzZnT0ZQT0RhS1pYN09L?=
 =?utf-8?B?VFBMZ0lORG8xOUI5RTU3N2JoSVFJWHBEUUtEUEZGR3gySHFnVytncmlNSkVB?=
 =?utf-8?B?SndkRTJtUkFSa3IvL0xYVUlpeU1Nb2htVUViS0pNWHhpMUp5WHplSW9jWUpI?=
 =?utf-8?B?WEt6UG5sRVROVWpGQm5VbEZ4MStrMFFYYXpYT2pycUlETTFURmx5MnhRQ3dW?=
 =?utf-8?B?SUQ5R3VNbHVuTzJQNnRjVGpaRWdtS1RjbEhUaVhESlZnUllHblh4dXJBeC9Y?=
 =?utf-8?B?RzV1MmRqbFloTEpURHA1RDZNdjlhWmFZZXlPWXYyWCt5SGFzTEk4S1owL2c2?=
 =?utf-8?B?enQ1dk00ek5nR0lLTUFmTWdWZ1pwaVA4Y3k0TWI1TlQxYzR4ZUExUjNPcnNH?=
 =?utf-8?B?MWt4MEJ1UlpJKzc4S1hSY1ZBSU9NaGFEdVM2dDc0Y091alUvK3d0dEQ2c3R5?=
 =?utf-8?B?SzBCOVlUMFJ2RjNEUW1vUkxkbStBMkFEVnhVMzV4YkFnNURsYURJOWlrNVBZ?=
 =?utf-8?B?NTF3RWVkL3NWZFVUWlFZd1dydDVIVENFNGp3MlpPYTlNc1I5eGFzVjFJVnhT?=
 =?utf-8?B?NU53di9jQ21EU0lxREN1eXVyZXdRUDRlY1g4WXZ4MGJuR3ViSWZHbFo2cm5F?=
 =?utf-8?B?NWFzZkJSaHhhTUtDODBNOXU2Rlo4V1lZdGJ6eHkxRjJqS0E0dmJsbGRZTita?=
 =?utf-8?B?MFBuN1FKb2hFUkNvR01qNlJmQ1U2K0RjT2dMeGJIaG1lVngrUkZEMEpURmcr?=
 =?utf-8?B?QTVnMmJUTU1YZkROTktGNmNhY3dscXBjMVZjcFBHMnFJblh2Uysvc3NNT0xU?=
 =?utf-8?B?MzZ4QXlwdzRZYjJzQllKai9QVzMzWno0T3RBclV1cHIrWnB0K01rejRwRW1H?=
 =?utf-8?B?RitEWnIxM0ZwN1lTUUhmcnVYdWExclo3RmNBblIzNUpRZW1hc2F3cC9ZeHlX?=
 =?utf-8?B?cnlEdk5hVzgzTXNkeHZEV2tnSU9WTDhGczJUM1VnZ0RWVUxkbmdqa0tMeFZ1?=
 =?utf-8?B?ckZYVmVidTBXRlhOVjJhR2VCZ05Id0l4eEV5UktqV2ZlcFQwVUlYU24yakZJ?=
 =?utf-8?B?UytCcS8wdkRXSmxsQkZuU3pOTitOSHExejd4ck5GZ3E1cHFkTjRHMVVWVkNn?=
 =?utf-8?B?MWtUYkRLbXBEMXllTDJSQVJjQ2M1NGt1RzZLTUtoMk9HMEUzajZmdTkyV1hX?=
 =?utf-8?B?WlBTMkxQK2RjL0FpemFSdVlNdk1va0tMd2xKd3cxeG4rTE8zdXd5TFVOSVJo?=
 =?utf-8?B?Nlo0QUlNR3lTUU10S1BoTDRXSVR1c0Qyck1JR2x3bXJHSWd4Qmt0eFp2YWM1?=
 =?utf-8?B?cDFySnkyV294UXRVRWpIQlBVQVBOU1NhOFJWME02b0dyaDhYejJmUVhuVnBB?=
 =?utf-8?B?VW41UW1PQmRlYWZCd1pPWWY2REk2VUFrQWdCTkY4WFNLZFd2YTJPZldmL2ZQ?=
 =?utf-8?B?OXdUQkFGT2NCQTJxL05nZGd4d3BudUQwV0d2TFZIRDF2V3hVY1lQTVhjd3pF?=
 =?utf-8?B?OTJLSVVacVYrSjVYVEJ4d29KdnBmdXdpQUJYa1RqaWQyeEVqYk8rYkt3ZEdv?=
 =?utf-8?B?S2VQSnV3US9GdHBMbG94UXk2Q3dHQVFvMHVLMXNMOEJ2WVV3SEpKRUxMMUt2?=
 =?utf-8?B?dGRzYm9BeEQ3SFZJOTB0Y3BVM1J1Y0FGSGFWeUcxZGF1dWIyNVdwYW14M1Zy?=
 =?utf-8?B?a0VWdEc0M2tBNVJkVUI0c3ptNm1yMzFPZGo1NGhPakg5c2JJeDNtYlczV1N2?=
 =?utf-8?B?WnpQNTVGOVZEZlpuNWg0d3FtSWRzZE1XTTZTeW11aURHVVpMb1lHc0d2VFJH?=
 =?utf-8?B?elRrazdkZEZJWjViSzFrY3hzWkxxbDI0UzV4cG05TUNsTC9INlpETTVxTStL?=
 =?utf-8?B?cDR2d1ZVWENZa1RndGl5L2JOd2VkOHVBWERVejV0bzFpRWlWTGZmd2hoUWpP?=
 =?utf-8?B?cy9ERjJCTm5UYi9aM2Rlb2owenRPMEtRT2NFVkZuZTZ2dDlzWk0yMFQ0aW5B?=
 =?utf-8?B?WHlEdHhnM3BsSjFER0ZGQUIrVUI1K3VkK1kzMjd2VnhteU45YzVRYjNYVTdI?=
 =?utf-8?Q?JNcEfdnyZFn5DmPj58f9WtKo8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fce194-a6af-44aa-45a0-08dc32b09004
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:41:49.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J2bFQEMJTFPKu4NTyW2Jo1ySamLVd0sJ2BTTD5AWddQRAfMLSb7ab4nLtPV5fdvGYA7mdA5GP46a2eHymQrtqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
MSwgMjAyNCAxMDo0NSBBTQ0KPiBUbzogQmFvbHUgTHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4NCj4gQ2M6IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT47IGlvbW11QGxpc3Rz
LmxpbnV4LmRldjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFdvb2Ro
b3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47IEpvZXJnDQo+IFJvZWRlbCA8am9yb0A4Ynl0ZXMu
b3JnPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47IFJvYmluIE11cnBoeQ0KPiA8cm9i
aW4ubXVycGh5QGFybS5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IFRpYW4s
IEtldmluDQo+IDxrZXZpbi50aWFuQGludGVsLmNvbT47IE5pY29saW4gQ2hlbiA8bmljb2xpbmNA
bnZpZGlhLmNvbT47IE1pY2hhZWwgU2hhdml0DQo+IDxtc2hhdml0QGdvb2dsZS5jb20+OyBWYXNh
bnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPjsgSmFzb24NCj4gR3VudGhvcnBlIDxqZ2dA
bnZpZGlhLmNvbT47IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi0NCj4gcGhpbGlwcGVAbGlu
YXJvLm9yZz47IEhhbyBGYW5nIDxmYW5naGFvMTFAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MTAgNS82XSBpb21tdTogU3VwcG9ydCBtbSBQQVNJRCAxOm4gd2l0aCBzdmENCj4g
ZG9tYWlucw0KPiANCj4gT24gV2VkLCAyMSBGZWIgMjAyNCBhdCAxMDowNiwgQmFvbHUgTHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiAyMDI0LzIvMjEgOToy
OCwgWmhhbmdmZWkgR2FvIHdyb3RlOg0KPiA+ID4gT24gV2VkLCAyMSBGZWIgMjAyNCBhdCAwNzo1
OCwgWmhhbmcsIFRpbmE8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+Pj4+ICAgc3RydWN0IGlvbW11X3N2YSAqaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKHN0cnVjdCBk
ZXZpY2UgKmRldiwNCj4gPiA+Pj4+IHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKSAgew0KPiA+ID4+Pj4g
KyAgICAgICBzdHJ1Y3QgaW9tbXVfbW1fZGF0YSAqaW9tbXVfbW07DQo+ID4gPj4+PiAgICAgICAg
ICBzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47DQo+ID4gPj4+PiAgICAgICAgICBzdHJ1Y3Qg
aW9tbXVfc3ZhICpoYW5kbGU7DQo+ID4gPj4+PiAgICAgICAgICBpbnQgcmV0Ow0KPiA+ID4+Pj4N
Cj4gPiA+Pj4+ICsgICAgICAgbXV0ZXhfbG9jaygmaW9tbXVfc3ZhX2xvY2spOw0KPiA+ID4+Pj4g
Kw0KPiA+ID4+Pj4gICAgICAgICAgLyogQWxsb2NhdGUgbW0tPnBhc2lkIGlmIG5lY2Vzc2FyeS4g
Ki8NCj4gPiA+Pj4+IC0gICAgICAgcmV0ID0gaW9tbXVfc3ZhX2FsbG9jX3Bhc2lkKG1tLCBkZXYp
Ow0KPiA+ID4+Pj4gLSAgICAgICBpZiAocmV0KQ0KPiA+ID4+Pj4gLSAgICAgICAgICAgICAgIHJl
dHVybiBFUlJfUFRSKHJldCk7DQo+ID4gPj4+PiArICAgICAgIGlvbW11X21tID0gaW9tbXVfYWxs
b2NfbW1fZGF0YShtbSwgZGV2KTsNCj4gPiA+Pj4+ICsgICAgICAgaWYgKElTX0VSUihpb21tdV9t
bSkpIHsNCj4gPiA+Pj4+ICsgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGlvbW11X21tKTsN
Cj4gPiA+Pj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dF91bmxvY2s7DQo+ID4gPj4+PiArICAg
ICAgIH0NCj4gPiA+Pj4+DQo+ID4gPj4+PiAgICAgICAgICBoYW5kbGUgPSBremFsbG9jKHNpemVv
ZigqaGFuZGxlKSwgR0ZQX0tFUk5FTCk7DQo+ID4gPj4+PiAtICAgICAgIGlmICghaGFuZGxlKQ0K
PiA+ID4+Pj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ID4+
Pj4gLQ0KPiA+ID4+Pj4gLSAgICAgICBtdXRleF9sb2NrKCZpb21tdV9zdmFfbG9jayk7DQo+ID4g
Pj4+PiAtICAgICAgIC8qIFNlYXJjaCBmb3IgYW4gZXhpc3RpbmcgZG9tYWluLiAqLw0KPiA+ID4+
Pj4gLSAgICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXZfcGFzaWQoZGV2LCBt
bS0+cGFzaWQsDQo+ID4gPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBJT01NVV9ET01BSU5fU1ZBKTsNCj4gPiA+Pj4+IC0gICAgICAgaWYgKElTX0VS
Uihkb21haW4pKSB7DQo+ID4gPj4+PiAtICAgICAgICAgICAgICAgcmV0ID0gUFRSX0VSUihkb21h
aW4pOw0KPiA+ID4+Pj4gKyAgICAgICBpZiAoIWhhbmRsZSkgew0KPiA+ID4+Pj4gKyAgICAgICAg
ICAgICAgIHJldCA9IC1FTk9NRU07DQo+ID4gPj4+PiAgICAgICAgICAgICAgICAgIGdvdG8gb3V0
X3VubG9jazsNCj4gPiA+Pj4+ICAgICAgICAgIH0NCj4gPiA+Pj4+DQo+ID4gPj4+PiAtICAgICAg
IGlmIChkb21haW4pIHsNCj4gPiA+Pj4+IC0gICAgICAgICAgICAgICBkb21haW4tPnVzZXJzKys7
DQo+ID4gPj4+PiAtICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gPj4+IE91ciBtdWx0aSBi
aW5kIHRlc3QgY2FzZSBicm9rZSBzaW5jZSA2LjgtcmMxLg0KPiA+ID4+PiBUaGUgdGVzdCBjYXNl
IGNhbiB1c2Ugc2FtZSBkb21haW4gJiBwYXNpZCwgcmV0dXJuIGRpZmZlcmVudA0KPiA+ID4+PiBo
YW5kbGUsDQo+ID4gPj4+IDYuNyBzaW1wbHkgIGRvbWFpbi0+dXNlcnMgKysgYW5kIHJldHVybi4N
Cj4gPiA+Pj4NCj4gPiA+Pj4+ICsgICAgICAgLyogU2VhcmNoIGZvciBhbiBleGlzdGluZyBkb21h
aW4uICovDQo+ID4gPj4+PiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoZG9tYWluLCAmbW0t
PmlvbW11X21tLT5zdmFfZG9tYWlucywNCj4gPiA+Pj4+ICsgbmV4dCkNCj4gPiA+Pj4gew0KPiA+
ID4+Pj4gKyAgICAgICAgICAgICAgIHJldCA9IGlvbW11X2F0dGFjaF9kZXZpY2VfcGFzaWQoZG9t
YWluLCBkZXYsDQo+ID4gPj4+PiArIGlvbW11X21tLT5wYXNpZCk7DQo+ID4gPj4+IE5vdyBpb21t
dV9hdHRhY2hfZGV2aWNlX3Bhc2lkIHJldHVybiBCVVNZIHNpbmNlIHRoZSBzYW1lIHBhc2lkLg0K
PiA+ID4+PiBBbmQgdGhlbiBpb21tdV9zdmFfYmluZF9kZXZpY2UgYXR0YWNoIHJldD0tMTYNCj4g
PiA+PiBTb3VuZHMgbGlrZSB0aGUgdGVzdCBjYXNlIHRyaWVzIHRvIGJpbmQgYSBkZXZpY2UgdG8g
YSBzYW1lIG1tIG11bHRpcGxlDQo+IHRpbWVzIHdpdGhvdXQgdW5iaW5kaW5nIHRoZSBkZXZpY2Ug
YW5kIHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IGl0IGNhbiBhbHdheXMNCj4gcmV0dXJuIGEgdmFs
aWQgaGFuZGxlIHRvIHBhc3MgdGhlIHRlc3QuIFJpZ2h0Pw0KPiA+ID4gWWVzDQo+ID4gPg0KPiA+
ID4gVGhlIGRldmljZSBjYW4gYmluZCB0byB0aGUgc2FtZSBtbSBtdWx0aS10aW1lcyBhbmQgcmV0
dXJuIGRpZmZlcmVudA0KPiA+ID4gaGFuZGxlLCBTaW5jZSB0aGUgcmVmY291bnQsIG5vIG5lZWQg
dG8gdW5iaW5kIGFuZCBiaW5kIHNlcXVlbnRseSwNCj4gPiA+IFRoZSB1bmJpbmQgY2FuIGhhcHBl
biBsYXRlciB3aXRoIHRoZSBoYW5kbGUuDQo+ID4NCj4gPiBJcyB0aGVyZSBhbnkgcmVhbCB1c2Ug
Y2FzZSB0byBiaW5kIGFuIG1tIHRvIHRoZSBwYXNpZCBvZiBhIGRldmljZQ0KPiA+IG11bHRpcGxl
IHRpbWVzPyBJZiB0aGVyZSBhcmUgY2FzZXMsIGlzIGl0IGJldHRlciB0byBoYW5kbGUgdGhpcyBp
biB0aGUNCj4gPiB1YWNjZSBkcml2ZXI/DQo+IA0KPiBZZXMsIGl0IGlzIHJlcXVpcmVkIGZvciBt
dWx0aS10aHJlYWQsIHRoZSBkZXZpY2UgY2FuIHByb3ZpZGUgbXVsdGktcXVldWUgdG8NCj4gc3Bl
ZWQgdXAuDQo+IA0KPiA+DQo+ID4gIEZyb20gaW9tbXUgY29yZSdzIHBlcnNwZWN0aXZlLCBpdCBk
b2Vzbid0IG1ha2Ugc2Vuc2UgdG8gYXR0YWNoIHRoZQ0KPiA+IHNhbWUgZG9tYWluIHRvIHRoZSBz
YW1lIGRldmljZSAob3IgcGFzaWQpIG11bHRpcGxlIHRpbWVzLg0KPiANCj4gQnV0IGlzIGl0IHRo
ZSByZWZjb3VudCBkb21haW4tPnVzZXIrKyB1c2VkIGZvcj8NCj4gSXMgdGhlcmUgYW55IHJlYXNv
biBub3QgZG9pbmcgdGhpcy4NClRoZSBkb21haW4tPnVzZXIgaXMgYSByZWZjb3VudCBvZiB0aGUg
ZGV2aWNlcyAob3IgaW9tbXUgZ3JvdXApIGF0dGFjaGVkIHRvIHRoZSBkb21haW4uICBJT01NVSBj
b3JlIG5lZWRzIHRvIGtlZXAgdGhpcyByZWZjb3VudCB0byBlbnN1cmUgdGhhdCBhIHN2YSBkb21h
aW4gd2lsbCBiZSByZWxlYXNlZCB3aGVuIG5vIGRldmljZSB1c2VzIGl0Lg0KDQpSZWdhcmRzLA0K
LVRpbmENCg0KPiANCj4gVGhhbmtzDQo=

