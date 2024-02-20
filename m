Return-Path: <linux-kernel+bounces-73843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 871EA85CC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08591F23032
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330171552E2;
	Tue, 20 Feb 2024 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsgGpWCt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708FE1552E0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473530; cv=fail; b=pZfQqVqqxLXFSQJWM2ndg9+IzO2bDvBiC2sq0adcXANmzj8JOOU+NzMXBQU2gNpKsGASdVzHo2rZpvaG0yt6Ut/AC2mCy2veLcIWR994MtutjF+hZxK+RqxB3sNCf14a4LiAaJusBt45vN4FWfL0WF7GzKa9/EAHm9jV07t3FRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473530; c=relaxed/simple;
	bh=96CG9wY7hEsAskVyKUIN3fp7X1nhsH6/g5oLV+LaMYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XC58RfJCSGonyAFnMa98n8niaoJW0a/9vjXQzlbb5V9xAusie2gjFmxza/IAZu4QYWvMhPdeZZjfzh0t50rXfm0JfNa3c7cSUP8zzlmjyzGNHXoxPrkY5hsdbt+AZNP1bUwGriadqs8uH2K9jf26diJbh9jXC4i52LefSdljjZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsgGpWCt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708473528; x=1740009528;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=96CG9wY7hEsAskVyKUIN3fp7X1nhsH6/g5oLV+LaMYA=;
  b=MsgGpWCtwTaCV12tztkBN8PUoLNwU6yxu09Yn8fz4RK7fp6gioO84RT9
   g2RXTMeeJ+/F0J6jHX4vAD37yAgdkGQDpEt76JbRGhgEUO+MAHzD8Pvpw
   0CC0Df6LeJW0onrMrCy1a6JqC+NlvC66E1aTmQBNKjxB9tT/D8i4XurTv
   Bt0V/MTkbTOs7fY0p/W90QeTrCf+XhoggkHKK3ePNNxdGuc+jNXN+qslR
   qN8K/iNoPEUXrAUsA7IGySUGRjS1d6tjffRkhzrj6vtkFjCvKWGaYfrZw
   A0DVBc1c5o+H+sgRVlDlP/VnOhaHQjCjH4ZZDna6fqeGIDCNaaqrBAZ3Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20144986"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20144986"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 15:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9596464"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 15:58:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:58:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 15:58:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 15:58:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 15:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbp/59olkxXdwDv0nNaX2icS6EXt/73+3WULIvg8aTmr264NUfWqLpzP9+G920O+uFNZXS/7ZgnUn/k/DuMwLypicTrLUDtxvKA22yzlybsCyU3zxCIvuwdu2DTSLk7OvaPUXerOow2RVUqGNy1OFc4vpnWeeM+7VTpg46POoIO3kmrI31JUFbRvBFdXlyDAhRCxpfbL8hCwGmII8Nxaz4nMZMEP0islIZG9e9U5SPGCgHXOtnVTK7shnkJ5oTYeDl0RJhBVuwBpaeXjabYcJvgMvodaBFIZ9R+NwCYOFfUIxTeEp6ucUX+6LHS6vTA4mI3gAsuKPJYiOA7orAlqqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96CG9wY7hEsAskVyKUIN3fp7X1nhsH6/g5oLV+LaMYA=;
 b=Kt/QhwcVAm1J/6RIxtusYaDnieaN9qx/TktQC3UERg2Avjzf9L8Y+5TbIyaErlYt1l31EmUCQCXpqBgC/vfWWnMqZ/9t5MTFIFYFrXlAnTWsUF/6ExrTqBVFKhUtP6nPtNtuRCUlUt+YLCq3Olt1JX9C87YQqwNZboygBahaAAuSj1PtBmnkAs3eSS8Fktq0Mq3lrWLFPSmu4g4p3u7EQLZ91gRynoMbvxJM3r87OtaPS4GrllV1IDxW+bARyYmpdDxycnx++hjNoMCh8T+/4e8yaaeqfK+yqkbQZoqoHMebsNK7419AiQa/vd7U/rFtG2z+Ndr6tz0NnvLpxu4w9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA2PR11MB4907.namprd11.prod.outlook.com (2603:10b6:806:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 23:58:40 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::2e1e:4cf0:f8ea:a9c7%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 23:58:40 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin"
	<kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit
	<mshavit@google.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: RE: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v10 5/6] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHaCGlssGjjzrsBKkGGlpOPTcfts7EUImoAgAB6i1A=
Date: Tue, 20 Feb 2024 23:58:40 +0000
Message-ID: <MW5PR11MB5881C5CC15452017867B412889502@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-6-tina.zhang@intel.com>
 <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
In-Reply-To: <CABQgh9GWcqUeBkHQCpj5tzu6FnEgpOp3KOQ6s9c0X0KU7Ov1qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA2PR11MB4907:EE_
x-ms-office365-filtering-correlation-id: 65c0a8d6-d7c8-4114-9765-08dc326fdc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFLHXc2KoMxFkE/c4F/nxchki+DM/zojw8QemPxlqK5I3o+eSLaPvD8JofOkNo9xNJQm+j9cTGLHx9boLWSNnkIfjbe3YzejEQHxjYZ1Z1Z0T2iTa2CLHISmvsO/cf6og5hIUca//yBFqldez3NoydhtO9hg96owrPkh1Qi97N4whk7lFEk7TmeB8jq1jAUQjTIC1+L1mIDFsI4kRWDfoaOzCEQVw14/ud2RxsnJT9SWMefVWxBAyw0p/Lw7sGYV3oIh9x0QAQLBfpBwBrlPMnSLzJGPT18jZWhE5XFcTHF1prpQyPBhbkFnQizvXa7ShKTren8crkSTCdVtAoAEL3mfrZbsTO3umu2ESy5DB4DcsHe8LWYA2oX4bGHzceRRxoEjcOq2pIvsUSEZBkmbUDyVont6ms5pPUsA+74BDK3s6k8KT3r5WLl3qRQSftcrBPIT1p0QLN0euhvFyK55gkrqykdxgT0+NiAh9PVNf0+6fuXO08ndJvS87pojmF3MMz7w9NEKK8pLvdnmDWcTcU478bMso8eaojYto8a8yReRn0UxwRnDFHkGsiCyk4njbe4PJxLBHfGiDUdkSJqsTkmzyXsfb5KTTDiCvQsoDXuCStVDIS9M9LvvXlhVAH1D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEMzUjc5OEwwNVV3enMyemR0UE5ZM2FvOXFOZ2VJNEZJVld3eUVpbUw0NGpq?=
 =?utf-8?B?aFAyTTR6UENqOFI0Nml1OFM5Rmt1Y3phWE5uMzc5RHBBclBVWVpSbmxaT0pR?=
 =?utf-8?B?Zll0T0RMQ016S2RMODFhd2JaRENORE00bmFtZEhQdklrV005anZ1YlJ3NC9q?=
 =?utf-8?B?VzdhUlFrN2l5bGhlN2U5MlNSV2tlZGpabC9MNE5NZGcyWjVFc0R6b0xkeDFW?=
 =?utf-8?B?dFM1Q1RZTk81ZEJGeWF2bGt6Ynd3MUl4dE51UDhFak9vem1vNlArTzR2Z2Q0?=
 =?utf-8?B?MDhyZTA4SWRnVzN3TFNreDBrSzZ6WmlMUnJEN0JtNG9jT0E4ZnoxTFJpUzRG?=
 =?utf-8?B?NXRHejlpbWw5YlZ2cWhRZkc2QXk2QUR3NzVTUk1kNmNaVk9iZTFhOHlZUFlM?=
 =?utf-8?B?dmQ4ZHJnQ29HTWdsV3FIZFdxcVNETmRGWnY5UmFsc1pzYldqNWJHZ3diTTRO?=
 =?utf-8?B?Qi83RlMvOEd3Q2ExUVBCLzJPRkFpZ1lWck9pemhOWnRvVmRCS2NvKzZtS2lU?=
 =?utf-8?B?VFIyendHeHVyMUc4WjM1RFBvSGgxMnAvayt5UFJsT0FpYUVXRFJkUkVLUEZ5?=
 =?utf-8?B?RVc5UUZVdnIxdjZ1UGNRNEp6YjVBUis0YmcrcmlZZzNNY1E5WWl0M1ZyRkd2?=
 =?utf-8?B?MEQ3YzlGeTduRy9rRXEvdEpIc002Wk1reTZpYkQ4VnRCLy9YSDhaN0JVc1d2?=
 =?utf-8?B?YXBCY2Nhak01eDI2TG5Ya1RjMmwyeXp0OXd4UTZ1SmRON1JiSWhMOVQwU1FO?=
 =?utf-8?B?YkZSbmFlam1RYTlVdE84WFRBU0hPMEdPZzF4S2wwS08wR1JaSExIRXh0R1hE?=
 =?utf-8?B?T1Y2K0dJQ29SWjlod214ejNCWDI1MkRVdmJOSVlPM0JTK0ZybGM1UEt5UGxQ?=
 =?utf-8?B?K0M4aDdqYTkrZnNIVUgvcmZsVEFIQzBJbXArZ2JPL0JyLzA4b24vQUZhZW1y?=
 =?utf-8?B?WklURG44Tk9pRFZFM0N0UUZRb25mdkEreFA4cUJBSjhGTTZvN2NYQkcyblFX?=
 =?utf-8?B?TWFDTzl5V2lVYWRXZXdZZFBDaWpOT0w5bXg5c0xGNXRKV2E4cXVnUnp6cHdq?=
 =?utf-8?B?NE9qVnhPYUQ2d0tvVlY1bzNTbndaeWkvZnpHM2NrODJ1NzhZUWFKYWpCSWJX?=
 =?utf-8?B?ejdxQmRUeUtKOWVYbDhjL08zNmNvV09mYkNDUDZOL29ySE8rZjc0eUlqYS9Y?=
 =?utf-8?B?dnhydnhQWHViQk5SLzB3ZkpkeUtHcTVQanJkMGtITjFKMExzcmswQzMveDdt?=
 =?utf-8?B?SSt6R3FJclVmcVoyMW5DTW44UVpIcUt5YndIUXNpcGJVSkFTR05sU2ZHcTE2?=
 =?utf-8?B?OWtNcUx1VGgweG5NV2tVWnpUa1hMbUc5U3dSUkhGR2wvQzVMWWZXL3g4bnkv?=
 =?utf-8?B?blU4R0Z3UjBYNStLVEFsSWx6ZUdjUVYzbU16bTA2azNwdnRCWk1UTW1uREVG?=
 =?utf-8?B?VEtaUjF1WUpxcS9yYUhHRU91TUVDZ1VCK3ZuRWlkaEdUZVpjNjYyTitYWnpq?=
 =?utf-8?B?S3dEWktEVVIxQkhTdHlRa1VibUlCd3AxNHNuL2NMS1JmblNVSkhIS1I2N2Nn?=
 =?utf-8?B?Um5VSEpzVjhDdTZSVUh1M3AzYktnNk1IdFhROU9GeGxINUlHR1dSYjJaUFY0?=
 =?utf-8?B?SitEWUpWaE9vbU1YRWRmMml6UEU0b1ArYitmVHc4MXNlL29ZVFRsMHREQXUy?=
 =?utf-8?B?TzRQYXR1RVZ1SUpCVW5PUktxQS9pcUxaZ3kxM3FyTTJ0QlVpZ1JEUmFJNkI3?=
 =?utf-8?B?eWUyZjhWSmxaY2FyZENtdE9BclZ5RCtlT2xPZUFGVDdrR1lqcHR6elVXME0r?=
 =?utf-8?B?UUdBdGxUdjI3K05VOXpXUTNVaGJZVWYrVUdzNVg1bmN5dHEvalBLNEdxT2hU?=
 =?utf-8?B?eWhyd214WUJDMytrWko2U0NkTXcvaXJqRUs5WHFWSUV3eWpwVGdaRlpya25w?=
 =?utf-8?B?bjNnbDd0Y0Vrb1JmTEpnWFg3UnhpT1VhS0VaNVJESVkraGNKMG5oM3hRVkUv?=
 =?utf-8?B?c29HdUg2QmIyK3BzSU1TM2Q4S2VuOWRXd1ljZzdxNFBoUmd5czNvemlVKzlv?=
 =?utf-8?B?SWV6bjh5b1h5cmpVcXN2R2ZVUHl1c04rVmhjMnJpdGJvR0NrNnpsOHJkdGds?=
 =?utf-8?Q?rINBgzN7J7KCZnQENcPioc+gc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c0a8d6-d7c8-4114-9765-08dc326fdc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 23:58:40.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkos7G1vZaKbSsOVIYX80+oi15uPsoANGSFipDRXNisTk1Ts+Ee5/BSca23LLoHRWHJoTD3at6r6fSIJMDvpTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4907
X-OriginatorOrg: intel.com

SGkgWmhhbmdmZWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhh
bmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSAyMSwgMjAyNCAxMjoyNyBBTQ0KPiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdA
aW50ZWwuY29tPg0KPiBDYzogaW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBEYXZpZCBXb29kaG91c2UNCj4gPGR3bXcyQGluZnJhZGVhZC5vcmc+OyBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgSm9lcmcNCj4gUm9lZGVsIDxqb3Jv
QDhieXRlcy5vcmc+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgUm9iaW4gTXVycGh5
DQo+IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNh
PjsgVGlhbiwgS2V2aW4NCj4gPGtldmluLnRpYW5AaW50ZWwuY29tPjsgTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPjsgTWljaGFlbCBTaGF2aXQNCj4gPG1zaGF2aXRAZ29vZ2xlLmNv
bT47IFZhc2FudCBIZWdkZSA8dmFzYW50LmhlZ2RlQGFtZC5jb20+OyBKYXNvbg0KPiBHdW50aG9y
cGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCA1LzZdIGlvbW11
OiBTdXBwb3J0IG1tIFBBU0lEIDE6biB3aXRoIHN2YQ0KPiBkb21haW5zDQo+IA0KPiBIaSwgVGlu
YQ0KPiANCj4gT24gRnJpLCAyNyBPY3QgMjAyMyBhdCAwODowNiwgVGluYSBaaGFuZyA8dGluYS56
aGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRWFjaCBtbSBib3VuZCB0byBkZXZpY2Vz
IGdldHMgYSBQQVNJRCBhbmQgY29ycmVzcG9uZGluZyBzdmEgZG9tYWlucw0KPiA+IGFsbG9jYXRl
ZCBpbiBpb21tdV9zdmFfYmluZF9kZXZpY2UoKSwgd2hpY2ggYXJlIHJlZmVyZW5jZWQgYnkNCj4g
aW9tbXVfbW0NCj4gPiBmaWVsZCBvZiB0aGUgbW0uIFRoZSBQQVNJRCBpcyByZWxlYXNlZCBpbiBf
X21tZHJvcCgpLCB3aGlsZSBhIHN2YQ0KPiA+IGRvbWFpbiBpcyByZWxlYXNlZCB3aGVuIG5vIG9u
ZSBpcyB1c2luZyBpdCAodGhlIHJlZmVyZW5jZSBjb3VudCBpcw0KPiA+IGRlY3JlbWVudGVkIGlu
IGlvbW11X3N2YV91bmJpbmRfZGV2aWNlKCkpLiBIb3dldmVyLCBhbHRob3VnaCBzdmENCj4gPiBk
b21haW5zIGFuZCB0aGVpciBQQVNJRCBhcmUgc2VwYXJhdGUgb2JqZWN0cyBzdWNoIHRoYXQgdGhl
aXIgb3duIGxpZmUNCj4gPiBjeWNsZXMgY291bGQgYmUgaGFuZGxlZCBpbmRlcGVuZGVudGx5LCBh
biBlbnFjbWQgdXNlIGNhc2UgbWF5IHJlcXVpcmUNCj4gPiByZWxlYXNpbmcgdGhlIFBBU0lEIGlu
IHJlbGVhc2luZyB0aGUgbW0gKGkuZS4sIG9uY2UgYSBQQVNJRCBpcw0KPiA+IGFsbG9jYXRlZCBm
b3IgYSBtbSwgaXQgd2lsbCBiZSBwZXJtYW5lbnRseSB1c2VkIGJ5IHRoZSBtbSBhbmQgd29uJ3Qg
YmUNCj4gPiByZWxlYXNlZCB1bnRpbCB0aGUgZW5kIG9mIG1tKSBhbmQgb25seSBhbGxvd3MgdG8g
ZHJvcCB0aGUgUEFTSUQgYWZ0ZXINCj4gPiB0aGUgc3ZhIGRvbWFpbnMgYXJlIHJlbGVhc2VkLiBU
byB0aGlzIGVuZCwgbW1ncmFiKCkgaXMgY2FsbGVkIGluDQo+ID4gaW9tbXVfc3ZhX2RvbWFpbl9h
bGxvYygpIHRvIGluY3JlbWVudCB0aGUgbW0gcmVmZXJlbmNlIGNvdW50IGFuZA0KPiA+IG1tZHJv
cCgpIGlzIGludm9rZWQgaW4NCj4gPiBpb21tdV9kb21haW5fZnJlZSgpIHRvIGRlY3JlbWVudCB0
aGUgbW0gcmVmZXJlbmNlIGNvdW50Lg0KPiA+DQo+ID4gU2luY2UgdGhlIHJlcXVpcmVkIGluZm8g
b2YgUEFTSUQgYW5kIHN2YSBkb21haW5zIGlzIGtlcHQgaW4gc3RydWN0DQo+ID4gaW9tbXVfbW1f
ZGF0YSBvZiBhIG1tLCB1c2UgbW0tPmlvbW11X21tIGZpZWxkIGluc3RlYWQgb2YgdGhlIG9sZA0K
PiBwYXNpZA0KPiA+IGZpZWxkIGluIG1tIHN0cnVjdC4gVGhlIHN2YSBkb21haW4gbGlzdCBpcyBw
cm90ZWN0ZWQgYnkgaW9tbXVfc3ZhX2xvY2suDQo+ID4NCj4gPiBCZXNpZGVzLCB0aGlzIHBhdGNo
IHJlbW92ZXMgbW1fcGFzaWRfaW5pdCgpLCBhcyB3aXRoIHRoZSBpbnRyb2R1Y2VkDQo+ID4gaW9t
bXVfbW0gc3RydWN0dXJlLCBpbml0aWFsaXppbmcgbW0gcGFzaWQgaW4gbW1faW5pdCgpIGlzIHVu
bmVjZXNzYXJ5Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51
eC5pbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFZhc2FudCBIZWdkZSA8dmFzYW50LmhlZ2Rl
QGFtZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5j
b20+DQo+ID4gVGVzdGVkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZyA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9pb21tdS9pb21tdS1zdmEuYyB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgIHwgMjMg
KysrKysrKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDc0IGluc2VydGlvbnMoKyksIDQxIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUtc3Zh
LmMgYi9kcml2ZXJzL2lvbW11L2lvbW11LXN2YS5jDQo+ID4gaW5kZXggNGEyZjU2OTk3NDdmLi41
MTc1ZThkODUyNDcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS1zdmEuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUtc3ZhLmMNCj4gPiBAQCAtMTIsMzIgKzEyLDQy
IEBADQo+ID4gIHN0YXRpYyBERUZJTkVfTVVURVgoaW9tbXVfc3ZhX2xvY2spOw0KPiA+DQo+ID4g
IC8qIEFsbG9jYXRlIGEgUEFTSUQgZm9yIHRoZSBtbSB3aXRoaW4gcmFuZ2UgKGluY2x1c2l2ZSkg
Ki8gLXN0YXRpYw0KPiA+IGludCBpb21tdV9zdmFfYWxsb2NfcGFzaWQoc3RydWN0IG1tX3N0cnVj
dCAqbW0sIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArc3RhdGljIHN0cnVjdCBpb21tdV9tbV9k
YXRhICppb21tdV9hbGxvY19tbV9kYXRhKHN0cnVjdCBtbV9zdHJ1Y3QNCj4gPiArKm1tLCBzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiArICAgICAgIHN0cnVjdCBpb21tdV9tbV9kYXRh
ICppb21tdV9tbTsNCj4gPiAgICAgICAgIGlvYXNpZF90IHBhc2lkOw0KPiA+IC0gICAgICAgaW50
IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgbG9ja2RlcF9hc3NlcnRfaGVsZCgmaW9tbXVf
c3ZhX2xvY2spOw0KPiA+DQo+ID4gICAgICAgICBpZiAoIWFyY2hfcGd0YWJsZV9kbWFfY29tcGF0
KG1tKSkNCj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPiArICAgICAgICAg
ICAgICAgcmV0dXJuIEVSUl9QVFIoLUVCVVNZKTsNCj4gPg0KPiA+IC0gICAgICAgbXV0ZXhfbG9j
aygmaW9tbXVfc3ZhX2xvY2spOw0KPiA+ICsgICAgICAgaW9tbXVfbW0gPSBtbS0+aW9tbXVfbW07
DQo+ID4gICAgICAgICAvKiBJcyBhIFBBU0lEIGFscmVhZHkgYXNzb2NpYXRlZCB3aXRoIHRoaXMg
bW0/ICovDQo+ID4gLSAgICAgICBpZiAobW1fdmFsaWRfcGFzaWQobW0pKSB7DQo+ID4gLSAgICAg
ICAgICAgICAgIGlmIChtbS0+cGFzaWQgPj0gZGV2LT5pb21tdS0+bWF4X3Bhc2lkcykNCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU9WRVJGTE9XOw0KPiA+IC0gICAgICAgICAg
ICAgICBnb3RvIG91dDsNCj4gPiArICAgICAgIGlmIChpb21tdV9tbSkgew0KPiA+ICsgICAgICAg
ICAgICAgICBpZiAoaW9tbXVfbW0tPnBhc2lkID49IGRldi0+aW9tbXUtPm1heF9wYXNpZHMpDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVPVkVSRkxPVyk7DQo+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiBpb21tdV9tbTsNCj4gPiAgICAgICAgIH0NCj4gPg0K
PiA+ICsgICAgICAgaW9tbXVfbW0gPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaW9tbXVfbW1fZGF0
YSksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgICAgaWYgKCFpb21tdV9tbSkNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gKw0KPiA+ICAgICAgICAgcGFz
aWQgPSBpb21tdV9hbGxvY19nbG9iYWxfcGFzaWQoZGV2KTsNCj4gPiAgICAgICAgIGlmIChwYXNp
ZCA9PSBJT01NVV9QQVNJRF9JTlZBTElEKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHJldCA9IC1F
Tk9TUEM7DQo+ID4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgICAgICAg
ICBrZnJlZShpb21tdV9tbSk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1F
Tk9TUEMpOw0KPiA+ICAgICAgICAgfQ0KPiA+IC0gICAgICAgbW0tPnBhc2lkID0gcGFzaWQ7DQo+
ID4gLSAgICAgICByZXQgPSAwOw0KPiA+IC1vdXQ6DQo+ID4gLSAgICAgICBtdXRleF91bmxvY2so
JmlvbW11X3N2YV9sb2NrKTsNCj4gPiAtICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICBp
b21tdV9tbS0+cGFzaWQgPSBwYXNpZDsNCj4gPiArICAgICAgIElOSVRfTElTVF9IRUFEKCZpb21t
dV9tbS0+c3ZhX2RvbWFpbnMpOw0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIE1ha2Ug
c3VyZSB0aGUgd3JpdGUgdG8gbW0tPmlvbW11X21tIGlzIG5vdCByZW9yZGVyZWQgaW4gZnJvbnQN
Cj4gb2YNCj4gPiArICAgICAgICAqIGluaXRpYWxpemF0aW9uIHRvIGlvbW11X21tIGZpZWxkcy4g
SWYgaXQgZG9lcywgcmVhZGVycyBtYXkgc2VlIGENCj4gPiArICAgICAgICAqIHZhbGlkIGlvbW11
X21tIHdpdGggdW5pbml0aWFsaXplZCB2YWx1ZXMuDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAg
ICAgIHNtcF9zdG9yZV9yZWxlYXNlKCZtbS0+aW9tbXVfbW0sIGlvbW11X21tKTsNCj4gPiArICAg
ICAgIHJldHVybiBpb21tdV9tbTsNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qKg0KPiA+IEBAIC01OCwz
MSArNjgsMzMgQEAgc3RhdGljIGludCBpb21tdV9zdmFfYWxsb2NfcGFzaWQoc3RydWN0IG1tX3N0
cnVjdA0KPiAqbW0sIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgICovDQo+ID4gIHN0cnVjdCBp
b21tdV9zdmEgKmlvbW11X3N2YV9iaW5kX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVj
dA0KPiA+IG1tX3N0cnVjdCAqbW0pICB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgaW9tbXVfbW1fZGF0
YSAqaW9tbXVfbW07DQo+ID4gICAgICAgICBzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47DQo+
ID4gICAgICAgICBzdHJ1Y3QgaW9tbXVfc3ZhICpoYW5kbGU7DQo+ID4gICAgICAgICBpbnQgcmV0
Ow0KPiA+DQo+ID4gKyAgICAgICBtdXRleF9sb2NrKCZpb21tdV9zdmFfbG9jayk7DQo+ID4gKw0K
PiA+ICAgICAgICAgLyogQWxsb2NhdGUgbW0tPnBhc2lkIGlmIG5lY2Vzc2FyeS4gKi8NCj4gPiAt
ICAgICAgIHJldCA9IGlvbW11X3N2YV9hbGxvY19wYXNpZChtbSwgZGV2KTsNCj4gPiAtICAgICAg
IGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKHJldCk7DQo+ID4g
KyAgICAgICBpb21tdV9tbSA9IGlvbW11X2FsbG9jX21tX2RhdGEobW0sIGRldik7DQo+ID4gKyAg
ICAgICBpZiAoSVNfRVJSKGlvbW11X21tKSkgew0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSBQ
VFJfRVJSKGlvbW11X21tKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOw0K
PiA+ICsgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBoYW5kbGUgPSBremFsbG9jKHNpemVvZigq
aGFuZGxlKSwgR0ZQX0tFUk5FTCk7DQo+ID4gLSAgICAgICBpZiAoIWhhbmRsZSkNCj4gPiAtICAg
ICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+ID4gLQ0KPiA+IC0gICAgICAg
bXV0ZXhfbG9jaygmaW9tbXVfc3ZhX2xvY2spOw0KPiA+IC0gICAgICAgLyogU2VhcmNoIGZvciBh
biBleGlzdGluZyBkb21haW4uICovDQo+ID4gLSAgICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9t
YWluX2Zvcl9kZXZfcGFzaWQoZGV2LCBtbS0+cGFzaWQsDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfRE9NQUlOX1NWQSk7DQo+ID4gLSAg
ICAgICBpZiAoSVNfRVJSKGRvbWFpbikpIHsNCj4gPiAtICAgICAgICAgICAgICAgcmV0ID0gUFRS
X0VSUihkb21haW4pOw0KPiA+ICsgICAgICAgaWYgKCFoYW5kbGUpIHsNCj4gPiArICAgICAgICAg
ICAgICAgcmV0ID0gLUVOT01FTTsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2Nr
Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICBpZiAoZG9tYWluKSB7DQo+ID4gLSAg
ICAgICAgICAgICAgIGRvbWFpbi0+dXNlcnMrKzsNCj4gPiAtICAgICAgICAgICAgICAgZ290byBv
dXQ7DQo+IA0KPiBPdXIgbXVsdGkgYmluZCB0ZXN0IGNhc2UgYnJva2Ugc2luY2UgNi44LXJjMS4N
Cj4gVGhlIHRlc3QgY2FzZSBjYW4gdXNlIHNhbWUgZG9tYWluICYgcGFzaWQsIHJldHVybiBkaWZm
ZXJlbnQgaGFuZGxlLA0KPiA2Ljcgc2ltcGx5ICBkb21haW4tPnVzZXJzICsrIGFuZCByZXR1cm4u
DQo+IA0KPiA+ICsgICAgICAgLyogU2VhcmNoIGZvciBhbiBleGlzdGluZyBkb21haW4uICovDQo+
ID4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGRvbWFpbiwgJm1tLT5pb21tdV9tbS0+c3Zh
X2RvbWFpbnMsIG5leHQpDQo+IHsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gaW9tbXVfYXR0
YWNoX2RldmljZV9wYXNpZChkb21haW4sIGRldiwNCj4gPiArIGlvbW11X21tLT5wYXNpZCk7DQo+
IA0KPiBOb3cgaW9tbXVfYXR0YWNoX2RldmljZV9wYXNpZCByZXR1cm4gQlVTWSBzaW5jZSB0aGUg
c2FtZSBwYXNpZC4NCj4gQW5kIHRoZW4gaW9tbXVfc3ZhX2JpbmRfZGV2aWNlIGF0dGFjaCByZXQ9
LTE2DQpTb3VuZHMgbGlrZSB0aGUgdGVzdCBjYXNlIHRyaWVzIHRvIGJpbmQgYSBkZXZpY2UgdG8g
YSBzYW1lIG1tIG11bHRpcGxlIHRpbWVzIHdpdGhvdXQgdW5iaW5kaW5nIHRoZSBkZXZpY2UgYW5k
IHRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IGl0IGNhbiBhbHdheXMgcmV0dXJuIGEgdmFsaWQgaGFu
ZGxlIHRvIHBhc3MgdGhlIHRlc3QuIFJpZ2h0Pw0KDQpSZWdhcmRzLA0KLVRpbmENCj4gDQo+ID4g
KyAgICAgICAgICAgICAgIGlmICghcmV0KSB7DQo+IA0KPiBTaW1wbHkgdHJpZWQgaWYgKCFyZXQg
fHwgcmV0ID09IC1FQlVTWSkNCj4gVGhlIHRlc3QgcGFzc2VzLCBidXQgcmVwb3J0IHdhcmluZw0K
PiBXQVJOSU5HOiBDUFU6IDEyIFBJRDogMjk5MiBhdCBkcml2ZXJzL2lvbW11L2lvbW11LmM6MzU5
MQ0KPiBpb21tdV9kZXRhY2hfZGV2aWNlX3Bhc2lkKzB4YTQvMHhkMA0KPiANCj4gV2lsbCBjaGVj
ayBtb3JlIHRvbW9ycm93Lg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkb21haW4t
PnVzZXJzKys7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ID4gKyAg
ICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiANCj4gVGhhbmtzDQo=

