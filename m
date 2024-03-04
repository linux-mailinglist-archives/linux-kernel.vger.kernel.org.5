Return-Path: <linux-kernel+bounces-90271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FE86FCAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DD62B215E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407001B5A0;
	Mon,  4 Mar 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGn2HT2Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90EC1A58B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543144; cv=fail; b=XKEFJx1pZDaJ2QVrcakDpdhfcAHTf8R7jjSTnoJCTPt8fLtQWzEFDQ4nbbO3A2zLDq7NeRidpuOWGHkEoXfj16XnKExpiYYExrvXaF8m9ZT53j08nmE+hOHrfxIkt8k95tAjIl2F/pUs6ncJO64PLIo4HAIm0NMqwGH2nHd673A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543144; c=relaxed/simple;
	bh=3D2vrS4SjS2zxvYkRk4gch/wnCD0VBKEGljXWVZwOBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiW5s6dHUB3eF+3Y90Sn5v6zHuVD01y5+W5OqnpQC9WPaY0Mq5ddpz7ILbJVNFthx9VyXCRL8XSVr9mSPhsxEb33DZwj1prcMQkBVx+vDuod5HUhtWgrISl+mvB0YPMeUUbEzYIGE4yjnX8rPZ7P2Z38fLepBQiwOnXjayfgHnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGn2HT2Y; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709543143; x=1741079143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3D2vrS4SjS2zxvYkRk4gch/wnCD0VBKEGljXWVZwOBA=;
  b=XGn2HT2YWH412XpyiRD9Z0l+jShEQLfi4VnqbPEdhstQ++o54eLuVn9z
   va2Mu/KysueR2JPGdyPjVuBH+nXe1+o4lt6taPaICqualGV5sqDG5IDke
   34C+IGsvOY80dePyB4EDVTT7wWbTcqcSSAduIgF2ywUofivtJ7LArtLG4
   7/DZ8EIMXSUVtOI0bssxaF89X9oNKohSMsHNkS8AuqsF+RTCC9JGlDpIY
   9mH5lMBqdk4YhAGHOUb+kLffW1Z5aK342FmjsALirt7VuHKC1lBoZ4XYC
   Orz1EYyH/PLG6nVyKZ9VyYHoowAr212Na566HdLuOsleV0XYHiHH4C+ni
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26487767"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26487767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9500934"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 01:05:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 01:05:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 01:05:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 01:05:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l27egLC+E/22JsYrK9dtCIc+YphnUKZBVYqvwETbbhXhhH1jpY+pSF/4tjF5cCZqWWVhEY3oLo1j5mZBwwsV89kPPJEas2pACgSl3LF2MDz/cpKdfA4P4F0yzJMHuvVSd30rw95EfdP6J2bFhk2VStuqcdsXdCS81MLRYvsd7O3g3s2VBDVaWstmS1nvIBGGK5ronepuaUoA5duttYzXEpUeruLd0oYkoVPKkAt55WpXwZmbilDV74yyLXZ4OPSUK5wkmTMVRjsMUvelW89aPBNkKWbc5h9NRjBDl91ghXkxWcpbBNGC6RYfQ4dKS8veNlA8g/N2G9CtMutNifczdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D2vrS4SjS2zxvYkRk4gch/wnCD0VBKEGljXWVZwOBA=;
 b=FyzLBJxX87kcX7YdASvoYLQJLQ8Xs2l75DSqfNcTHS+z2jXECWKFX33l4Kb7fGulQ7rhPOik5eB3WGWyNOUNzSc1kW9aE+R0OM6fsz3qPXJZOQXnrDygTndiIh0dGiKWE+MggtxG/54l13ckHA4clu9a6PEtw+Konj9R620Qqen5tsDRZMZh9NYdAkLT1V34eiGC4MV4AmPTdyTwy5S3Z+Qyb1CUO5CoCaT7r3K5yUxAUydn68IWjgUVg4C8ukd06kcm2N+aLa0NGODyonGOZfhRR0NUdiInpmEQD26eNZRN9s0N5wVV6i2DD0o8ks3MNBCe0p+T7cNrKO8bnZ/y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 09:05:37 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::ca67:e14d:c39b:5c01]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::ca67:e14d:c39b:5c01%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 09:05:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Topic: [PATCH 1/3] iommu/vt-d: Setup scalable mode context entry in
 probe path
Thread-Index: AQHaavVCLTBatnZFXkG2swhnu2ybRrEnN6mAgAAM7ICAAAoXsA==
Date: Mon, 4 Mar 2024 09:05:37 +0000
Message-ID: <BL1PR11MB52719E06919ECFF95A91EC028C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20240229094804.121610-1-baolu.lu@linux.intel.com>
 <20240229094804.121610-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52762BCC8AC154A601B6EBCA8C232@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ad0e349-0ba4-4a89-a664-800c5615ef77@linux.intel.com>
In-Reply-To: <3ad0e349-0ba4-4a89-a664-800c5615ef77@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SN7PR11MB7115:EE_
x-ms-office365-filtering-correlation-id: 499b6626-e0cc-4965-6eb1-08dc3c2a4235
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: COk3AeKZOBJqbTVNLF0xWfySAK6uM7LSYJjQz+VDMhba3JZ4s+VYfAhnB2RFFIZ/CruntuSK/9zPdOupWhfHhFLVhAu/AVb6t0xiHMHUfYU4uVdGzeGOY6zloDHGdXgATo476hrbkwsLM+cxtB4wfESzc4EuveIyxCwH5P+k8Vgy1M8D1ar1K1tZn0ZHDOz8MDao6L+czVbcXELobAs3W+MxcNjk5v09BzdJH7Azsnt2OibmKXpbeKuXDacUGnqqyuTzIRmRQ6DlB0DPUdinL+TjgiSkS5PPjdNemTsH07++4DRLbvwqy08OQND0rKgMKxgtdB+CLzyFQOdgBuKtI08N7QDrzBlH/+KU95/t/k2JhX7tqeeFexpH3Zmx3kStrGZLBZ0hBg/dwOezRZAadNw4lKyM5YcX+Rf11Dvwl/gSFewaruA8VZT5zOwopgbeA86GSncShow55k3PaG3LYzmRRxFsv/XwP6UMsj9d9liGHYn59iBE5OxSDIYHEZDZM6hHK6HDuynemtU47oBM7LEDdOh37WGYKphbqR+DfUnrOJVS5W0B7YFCdKU+dnoc6f8D40/JOoxQlbT5ly+OfNfq4BpSuxOAeVfCMQC1EKArubbwG+XM1EC6UTmAV8t7r7BTvMlEN2nYWxZslKrTqPdryuS+7I3lnUmyUxua46rW902iUIuTPkfk2/OexBuHxRSYDw8/DwkiC8J1E2vd8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm5wTVd4WVhoR1NHYXB1MHp0VjNKbmxqQ0gyQlh3S3k3TnpuWURGSXhHYStt?=
 =?utf-8?B?NDN1OEJNZWtORmhwaElXNE8wZjBpbVk0R3RBUnA2MGJrZnJGaytwV0U2ZGFL?=
 =?utf-8?B?QlZPQjAvNlhRWEdpWUtGRDhiN3J1QWdoTXpSTkRmRy9uVk1XaXB2OGxnMGhy?=
 =?utf-8?B?Z285Qy9VREE0UjIwSVJwUzJ3UW5ENTkxWHorTG53cTVMSDJoVmZndTdZQUI3?=
 =?utf-8?B?dC9YQzdIRkpwUVdtS25lZE1mTk8zS0JXUGtsRGJUTVZTdDZPMDVqWWQyazZx?=
 =?utf-8?B?K2Y4a2RBMUhhZHI1ams2VnNvMEltUGNuK0R3dlhldi9tb2VuV3JET3ZlMFd6?=
 =?utf-8?B?S1lDRzJJWmM3RnBQUUFtV282MzBMOWEyeTc4emp4THd4MURFTFZjYlZiK001?=
 =?utf-8?B?Njc4Y2FJSzcyeXdBU0RJcVZBSlYwRmllNWg2YjNxb2Q5RjR6eTBodlF2WWtX?=
 =?utf-8?B?RVkwUm1zeXNnODBQUXhQR0ZBdnY3S1lIUmx3Tk44a2t0dmpyZHlOM3BYaHpv?=
 =?utf-8?B?K2ZBM0lOQUMzQkQza1lBYTlPeEFGSjhheW1ndDJROUVib3VkMTRwaVNCYUsv?=
 =?utf-8?B?OVp3M2hCL1U2bGpSVkVZcmgyYkpNS0dGdVJ0QnBHalQyNFU2MXZoUlBJdDRI?=
 =?utf-8?B?VGtWS0t2SDlWV094bjNSdDNVZ1YxSlE4MjRUS2dWM1d6RVYxNjJNL3BWSmNw?=
 =?utf-8?B?TWRseTZQQ013eGJUNzFLdnRnUmMzRi82VjdzZWQveWNLWTgwa3dQN2V0dVZu?=
 =?utf-8?B?NnhhTDNZdnBSd2hVUW4yUHppTEhZQzNleDU4b2RYL1k0Q2VFeFBaWFVwU0Zp?=
 =?utf-8?B?T0owdGpJLzJEZnNyczQzbVJYM2d0bDMxU1h6OHlMa3ZDb00zamxTa2pVTzhP?=
 =?utf-8?B?TW9hY1dZYWpweERSejl4MThuQVR1QlZub1ZCMXZIb2JITjdHeDZNd3E3ZHY1?=
 =?utf-8?B?OEgzRlhha0dZRjZ3QUxCckpQcmhSaGVjWEZveHpCbXN1S1N5Q091S1hYeGF5?=
 =?utf-8?B?d0xNc1F5azJiL3VEaDdmL1BVS1ROMWovaEJWbUNHZlFCRkFiMmgrZWRHSUEw?=
 =?utf-8?B?b2sycHd2MTh6V1lpU1Z3SXRFT2ZIS3ROU0lIMncxSllnQkkyZWp3VE9oYlUx?=
 =?utf-8?B?QlRXK1hITndXbjVhK3libVBGZ0xtZzlmWjVBT2xVSFJkaDZnb1E1U3pNTHZT?=
 =?utf-8?B?ZlB1OWFzZ2lDWUNHbmhnNzJ5WUh6UkNzQ0pvMDdDQ2xlSnkxTVBra1hocHBu?=
 =?utf-8?B?RE0zTGFEdzdmR1RjNnFRakhqMmZBR3ZGbFN3SDY2dG1WYk5ZWVA5TlB4bVpW?=
 =?utf-8?B?MzVJL2tXcTNIejd0QnJiOWNNRGt2cUZjTHhCLzdWT2I0SjFJM2RaMVlHanJW?=
 =?utf-8?B?SGduQS92UWU2N29lMC9JeHNjYnpPeXl1Z2xidnFmak1ZWUFlUU1DS0NzeGJw?=
 =?utf-8?B?ZVR3OFZyMHhFMmZGWE5RQmUyMEZqY2wxb0RycGtMZ2ZUVzdreEs5ZTNOUnQ0?=
 =?utf-8?B?dGdiTWYwMS9YL21mTDRPZTJwRDQ3VTRWWE5GSkpXMU8zZzBHZ0JmQzVweHRw?=
 =?utf-8?B?SHAyQXM0bk9lQW92VWRnUEE4SFVDYzFRcjV0bExGQkhDM1llaGh6bmxrVEd1?=
 =?utf-8?B?ZW9TczZBNURtVnB3d1lHdm5QR2VwZFo3NHdxUHBENnJDM0k2OWtKbzl3cTFG?=
 =?utf-8?B?d1pyT3dyWStVdXdwQlptTVZPUzg2NmdDWUVnUG96MHppdHcyNFJuQk9va0FJ?=
 =?utf-8?B?dDJ6WllCVU9nNzRTTFBFdlRnOGZQM2pzN0ttdUpKbDdjZi8xbnR0cEFIUDBm?=
 =?utf-8?B?KzZiaXRpV3d4Y2lZeHNBQkRDYW9NUW5uUHE1OXpGeFNtRXRKVGNuYm9jREQ1?=
 =?utf-8?B?Sk5jVlFja3V3OUc3N2MvWjJ1WGo3TDBSeWZ5RDd5UFNkQW83YXk0UlJHczIy?=
 =?utf-8?B?dk5OVnVGaWw4ak5OVUNMTG41MkVBZnB1N21XbTM5RDdpOW1jbTVjclhrNWkw?=
 =?utf-8?B?Lzh5SnkxZWx1NVFMREdkWG9aSG9USmd3c3A1eUFnbDhrS3hVMGJlOXpJODNx?=
 =?utf-8?B?eElLOHdjZE9IVjhLcFBkckMzYStBMHl2c25PSEhqNGgrTTlyblJjckVVa1Rz?=
 =?utf-8?Q?O/6pZ8wQqOW0H6kmQai9t6q7G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499b6626-e0cc-4965-6eb1-08dc3c2a4235
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 09:05:37.6522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7Hiz13aKHt6MiWxrBgpap1Zl34ljKOlkLfVATSmvXuLZ1bO1jvCksQvnnyjstgfS9uYBfiEdzgzFMRynwO49w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDQsIDIwMjQgNDoyNCBQTQ0KPiANCj4gT24gMjAyNC8zLzQgMTU6NDgsIFRpYW4s
IEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwu
Y29tPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgRmVicnVhcnkgMjksIDIwMjQgNTo0OCBQTQ0KPiA+
Pg0KPiA+PiArCS8qDQo+ID4+ICsJICogRm9yIGtkdW1wIGNhc2UsIGF0IHRoaXMgcG9pbnQsIHRo
ZSBkZXZpY2UgaXMgc3VwcG9zZWQgdG8gZmluaXNoDQo+ID4+ICsJICogcmVzZXQgYXQgaXRzIGRy
aXZlciBwcm9iZSBzdGFnZSwgc28gbm8gaW4tZmxpZ2h0IERNQSB3aWxsIGV4aXN0LA0KPiA+PiAr
CSAqIGFuZCB3ZSBkb24ndCBuZWVkIHRvIHdvcnJ5IGFueW1vcmUgaGVyZWFmdGVyLg0KPiA+PiAr
CSAqLw0KPiA+PiArCWlmIChjb250ZXh0X2NvcGllZChpb21tdSwgYnVzLCBkZXZmbikpIHsNCj4g
Pj4gKwkJY29udGV4dF9jbGVhcl9lbnRyeShjb250ZXh0KTsNCj4gPj4gKwkJaWYgKCFlY2FwX2Nv
aGVyZW50KGlvbW11LT5lY2FwKSkNCj4gPj4gKwkJCWNsZmx1c2hfY2FjaGVfcmFuZ2UoY29udGV4
dCwgc2l6ZW9mKCpjb250ZXh0KSk7DQo+ID4+ICsJCXNtX2NvbnRleHRfZmx1c2hfY2FjaGVzKGRl
dik7DQo+ID4+ICsJCWNsZWFyX2NvbnRleHRfY29waWVkKGlvbW11LCBidXMsIGRldmZuKTsNCj4g
Pj4gKwl9DQo+ID4NCj4gPiBpdCdzIHVuY2xlYXIgdG8gbWUgd2h5IHRoaXMgZG9lc24ndCBuZWVk
IHJlZmVyIHRvIG9sZCBkaWQgYXMgZG9uZSBpbiB0aGUNCj4gPiBleGlzdGluZyBjb2RlLiBJZiBz
Y2FsYWJsZSBtb2RlIG1ha2VzIGFueSBkaWZmZXJlbmNlIGNvdWxkIHlvdSBleHRlbmQNCj4gPiB0
aGUgY29tbWVudCB0byBleHBsYWluIHNvIHBlb3BsZSBjYW4gYXZvaWQgc2ltaWxhciBjb25mdXNp
b24gd2hlbg0KPiA+IGNvbXBhcmluZyB0aGUgZGlmZmVyZW50IHBhdGhzIGJldHdlZW4gbGVnYWN5
IGFuZCBzbT8NCj4gDQo+IFRoZSBwcmV2aW91cyBjb2RlIGdldHMgdGhlIGRvbWFpbiBJRCBmcm9t
IHRoZSBjb3BpZWQgY29udGV4dCBlbnRyeToNCj4gDQo+IHUxNiBkaWRfb2xkID0gY29udGV4dF9k
b21haW5faWQoY29udGV4dCk7DQo+IA0KPiBUaGlzIG1ha2VzIG5vIHNlbnNlIGZvciBzY2FsYWJs
ZSBtb2RlLCBhcyB0aGUgZG9tYWluIElEIGhhcyBiZWVuIG1vdmVkDQo+IHRvIHRoZSBQQVNJRCBl
bnRyeSBpbiBzY2FsYWJsZSBtb2RlLiBBcyB0aGUgcmVzdWx0LCBkaWRfb2xkIGFsd2F5cyBnZXRz
DQo+IDAuDQoNClRoZSBwb2ludCBpcyB3aGV0aGVyIHRoZSBkcml2ZXIgcmVxdWlyZXMgdG8gaW52
YWxpZGF0ZSBjYWNoZSBmb3Igb2xkIGRpZA0Kd2hpY2ggaXMgb3J0aG9nb25hbCB0byB1c2luZyBs
ZWdhY3kgb3Igc20uIElmIHllcywgdGhlbiB3ZSBzaG91bGQgZml4IHRoZQ0KY29kZSB0byBmaW5k
IHRoZSByaWdodCBkaWQgaW5zdGVhZCBvZiBpZ25vcmluZyBpdC4gSWYgbm8gdGhlbiB0aGUgbGVn
YWN5IHBhdGgNCnNob3VsZCBiZSBjbGVhcmVkIHRvbyB0byBhdm9pZCB1bm5lY2Vzc2FyeSBidXJk
ZW4uDQoNCj4gDQo+ID4gYW55d2F5IGl0J3Mga2luZCBvZiBhIHNlbWFudGljcyBjaGFuZ2UgcHJv
YmFibHkgd29ydGggYSBzZXBhcmF0ZSBwYXRjaA0KPiA+IHRvIHNwZWNpYWwgY2FzZSBzbSBmb3Ig
YmlzZWN0IGFuZCB0aGVuIGRvaW5nIGNsZWFudXAuLi4NCj4gDQo+IFRoaXMgY2hhbmdlIGRvZXNu
J3QgaW1wYWN0IGFueXRoaW5nIGFzIHRoZSBoYXJkd2FyZSB3aWxsIHNraXAgZG9tYWluIGlkDQo+
IGZpZWxkIGluIHRoZSBDb250ZXh0LWNhY2hlIEludmFsaWRhdGUgRGVzY3JpcHRvciBpbiBzY2Fs
YWJsZSBtb2RlLg0KPiANCg0Kbm8gc2VtYW50aWNzIGNoYW5nZSBidXQgaWYgb2xkIGNvZGUgaGFz
IGJ1ZyB3ZSBzaG91bGQgZml4IGl0IGluc3RlYWQNCm9mIGNhcnJ5aW5nIHRoZSBiZWhhdmlvci4g
8J+Yig0K

