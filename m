Return-Path: <linux-kernel+bounces-84756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9686AB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCAD1F24746
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB93612E;
	Wed, 28 Feb 2024 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNBztQRa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5F36125
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112070; cv=fail; b=qqsDrAiR3a7sDFJlhCzaEKOtmdCMs6jzZkvj0jfHpaX/QiTgTzSV1HDjY2nhayQ85FFZAGxjb2cnQD9D6VpyPkq8DIgyItdTyWAxR8iIa3pxe8v1bJXJ85xvolkdBpwPqcX1XMXpBiJclHg6qkGmByKfHJpUcuervf0cJWuQngc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112070; c=relaxed/simple;
	bh=fbAQlcC71ikWdbJMgtIZDI8Xo72DbRSKeqyYs3f77ZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GC3MCc4+F/8TK0tbWHnNL0+vRfMQqR6McZY1hspsbl0kEt5Dzh7RgRsXnAcCYsS4lIVS/wPpwNi+8oNIDccZF1CLnWa85OFUUYIoU45vCs2Cjd+meYKANEAbY9fF1LFmLxpnEGd/UFeMvNkvoQfy48dxWb5GaP+/rcLDRYQIU9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNBztQRa; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709112065; x=1740648065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fbAQlcC71ikWdbJMgtIZDI8Xo72DbRSKeqyYs3f77ZI=;
  b=lNBztQRac7pzHmUbrjGHEVnXVnvEnOm2qGTzBPuF2rX0x3LIhMmZ5EgT
   J/qj0lzMono0z85fdZmXO6qtAX+s5EpX/3IqC1zlSySr7HLFTb69Hm3+I
   ZlSY3Uhl+oIVrFxhwhmLgOOWEtUummS3wjp8EuxEIs4aycWSKUIQacUyT
   7+IRtKde47wbJ/yqGw+3NVsOdLLETHUpitGZHZB1Rib62I08g4C1QCsDX
   F4qeiiNp4mclY2O/m1JYuAEDe9F7Y2n+y1imVpHGsAFlwDypQrsBfPMps
   LqpCRPwbWVsMJlGYPG0aUVIpt7fLCrHCicqIKdGliA/aSJpa2KNDVmGhe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7283446"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7283446"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 01:21:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7800618"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 01:21:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 01:21:03 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 01:21:02 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 01:21:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 01:21:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Upj9VdG9/WCTfodQ4MN3jzgukQyFqsZzq+h0ikrjWv99WRxZvmypFeI0UGaSjxiE+Z/Yav1fHqKOiubOrz+5p52cMPv8xmSnCZiSsfjW/ZNdyrSANCuivjyKHIQFcs59ZRwFkTYwbKdoocptis6/hoBxFqdYU26v+TL2/OI1YUHZDfZ9se3ur65CnmnLfoFqNxoSDCmb8LRw2sZC6oChFyp9UmdQ12b78ce5kqQ5CEDXbub9I0FllIQQkPOLsBo/GS35XIKuLXUaSobAsZayoy+HUjxVfLpuFeEBZxyqW2Q5qzRkzXd3Tr+vjLlFKUgoGCqmq8/tHvPLp+YchJBdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbAQlcC71ikWdbJMgtIZDI8Xo72DbRSKeqyYs3f77ZI=;
 b=oawSpxnNETsxRtMdrbkKqDCS6N2dOTnW6r82Qn+f7x494LsSjkucIZgyRgp2n2UuOKTRSqhA0edtOVXxBHpNK5cxNg3ZMN8kM0sdP1xAWykTSAjOElYYhAlLZmC0jnLSLr5u/qU4xhD2TldOwufalOg48u/0RBBcFaPFpPXsm9rcGMq8TaHEPXZP0UG3ED2onNOf/lCWtcojCQTY+YKkcKI0nSVxcN2aXVT/mo7aPSTEga171KhwB8ej7YU8m21mdovFlHUu376mRs8MRWOof0myAwP96w71d/9Lw0HT3w5aRMS5SVRJbHwqrWqOkJqVzqTC/GChIj0N12T4hLR8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5417.namprd11.prod.outlook.com (2603:10b6:408:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 09:21:00 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 09:21:00 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "dyoung@redhat.com" <dyoung@redhat.com>, "bp@alien8.de" <bp@alien8.de>
CC: "Gao, Chao" <chao.gao@intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"bhe@redhat.com" <bhe@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
Thread-Topic: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache
 flush during kexec
Thread-Index: AQHaVDdfcLjlgK8/xEqQPfvtDlVukLER9XiAgAA6hICAAA0QAIAAGziAgAERXgCAAAWBAIAAWS2AgAAn/oCAALgLAIADONsAgAdZOQCAAGwDgA==
Date: Wed, 28 Feb 2024 09:21:00 +0000
Message-ID: <8c3e3e8c32b50cf488413d965ac6730ce8814214.camel@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
	 <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
	 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local>
	 <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
	 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local>
	 <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
	 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local>
	 <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
	 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
	 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com>
	 <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
	 <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
	 <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
In-Reply-To: <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5417:EE_
x-ms-office365-filtering-correlation-id: d109ae61-13f1-43da-64c5-08dc383e9440
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAEZcoUxiqZpwd/31IJfaJhDSuMtgpxUaoV3eFxngBlwvAB19S/oujCIplj+Zs6I/YaUZpJVGAGBGjtm1iPMkdk0kwAQx/l+R/qA8CtouvX8diRSpPEOhplfOzT7v4tIEE06pXYGWnjmrV2KJj4309S6VpbtWDEiAQDjD+DaKOyfDB4E82nGb4DYROvHcPWn8T7UsS4GMlepcc31nH/1YcK+JkvnYS+W8l3+GOGknDDtC9Csa4eg1zu3q3Kug24N+yRe9nTv5zeC7Sz8ZIi7J1AUVCDF/p6gtoMIS3sqckHJ1cgCv1gWRDZ12KIV5GJb1w9y8pePsytE03FbjWCI9achHVWaPSV25HuRZp0L0RiFipn7sFK9frNPcGruqmYmJO9XDTq6tfTvnBHDMg6+a0xqw63737XCHZjP4Gdqmdg/+G4jrz4fZgJILDSbUqnPDa4Zi/CMOcLIXW516p84upS62K3mQsqwMj3HX0E0vfU1nvcxlHQJQar8hapCe6Bp4gb1oVTCueFpvQT2TIoxXoEGNDNxzFbxsa0aFAwq3xmiv/ribW/wZBwYiDrlRPgY7MU6cHWH0o1NNEN6kkH+ukUAqmsJjBDJjmHmQvYlbL35SfoLEfLzvPZ2prRkAdAN9wcCSGsV9nAUgQQUuYKiaQQ9DnIvMEZnlb9thNJe4yxnuPoBAZF7/GbJs1e6B/k19Wb34EOUgZqFRYo52yu52Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJNajBld3ovdXZ2ZFlrUzg0RWJ6TWJjR0lZTkE0dDRWRGtpdldwVEdFTVp0?=
 =?utf-8?B?UjJUSUIySzhpdmpac2FIa3VFNk0yY0RqRi80bHAzU0xUMGY3cW1QVmFpVXdU?=
 =?utf-8?B?UHN6L1hKcUtieDdiaUNOVmJ1RkIrUTdKTGZ5d0pwQ0NSeW14RytwOVVNQTFl?=
 =?utf-8?B?MXp6ZGJGYXRBVVI2a0ZhVzR3U1l3NFBBS0xDNnVidlY2czhkQm1pWEsvaXJl?=
 =?utf-8?B?ZkRpUnhicDdrNFVKTCtGeFJvc3NRa2JVOFUyOXdtWk0rdnd1WGpYcGJra1RQ?=
 =?utf-8?B?QTNhamxxRm5QbFRJZnJQRXg5UVpnTDlHaDlibFNMTjZWVWFZY3V2a3RFWURh?=
 =?utf-8?B?WWRhWDNQNGJRT2pYaWV6TEowNWZLSEhGS0FjVE02Zlg5ZVg5OXdKeGczOEx3?=
 =?utf-8?B?TkJhVnJieXVROGtUNitab1M0aklHS0JtSWoxZFEwSEFTNEE4ZXpuRWdsSWd0?=
 =?utf-8?B?MGZvZXh0Q3ZGWUl4Z3I2S0xiVVNvaTRTTFY3b1hqelNwZllOQUlmQmt4cWJE?=
 =?utf-8?B?MEpoMndrZVVPKysxQmZwZUNJZkR3Wk52NndKdmJRcHltdXVZTEVOV05jUnYx?=
 =?utf-8?B?bCsyQjc4QVpRSjZxZFRHU0hhMFV6MlcweTBYYWVHRnJYSG1HaGxDSmJDN1E4?=
 =?utf-8?B?Q2szSncraTNvMlo0Y1lHT3lmRk92bGNqN0h6OHA2TXpKZDlnSXBIclNpRmJy?=
 =?utf-8?B?Rm5SdWFmODNWNXlyQzlMb3BWdGM5NGRVK0kvbXpoNlBmU3ZJZDYvZjVrcUU5?=
 =?utf-8?B?VHhHdVZwYlJsQVl6Z1hwTCtWM05vaDVDNmFtZ0hsdEpqd2wxbnBJbzZYMmd6?=
 =?utf-8?B?aGtSUVp0TGFuRkpBLzdvQk5hRG9kUjg3THlkWXVRVzZjNG9hMEgrd3pkbUdz?=
 =?utf-8?B?YXBFcTU0dk1VekFpSnlrZmNHazUyYk5veDAwSXkrMDlOUjc1NTJUQjdBMkts?=
 =?utf-8?B?U1J6a0pSN0hWOGh2WXgzOUpYYlduWHp1aXhNaXpWOWhnZEFjODB4a2VxMDhm?=
 =?utf-8?B?K2xaenhZQ2ZocTJmNFpmTW84Ymc3VDVLb2ErcURUVnVTVTIrZDJnR1pMQTll?=
 =?utf-8?B?VjZKTzF1NURzcDZ0eXBGUnQvbjRRYkZyaHBRVmlzTlowdGkzVy9tWm5TSm5y?=
 =?utf-8?B?cVJiRzJheFd6R2MrQzQ5bng4dHFWcllqSE54NUpJQVBUYWZKVzFDaUxMdm12?=
 =?utf-8?B?T0NLaStNOTR2anhwc3hKWWRpdkgvdUtUTEMxNUpWbU9SUy9lalR0Z2pIUXEv?=
 =?utf-8?B?enBJUXRVWmRLK1hTT01JSUV2MnNMYml4OWZaUzFlM0Q5YkJWZllkdDhod294?=
 =?utf-8?B?R2VBbGtCWjBFcWNPY2xNbGZkeFNXOGRmOGdrZFk4c2R4RFY2UHEraWFzR2pT?=
 =?utf-8?B?UlIvV1R3enpmUU0rOWxsZ3ZETHUwUVRsSTQrUHpZZXZqdkwyVGdMY3JsRm9u?=
 =?utf-8?B?dHZMa1VhYU41SlgwWEtibXAwQXB5aXFFUUk1UXRJcC85a0NzUGhkSzVLVTEr?=
 =?utf-8?B?bUp1OGduSlFhZlR4MVJZSWg2Zzg5MXFLQjZIb1NuOEVncCt3ZEs3dkU3SWg1?=
 =?utf-8?B?WThpTWVuRmpSYWx6RmdyWjluRWZMU3htd3BGYzdvNFhramh0bTJaWTVJTnIx?=
 =?utf-8?B?OVFpNTNjM254OFRNdnkxZHlucnlSUTVEbnVKblFRby9jVGVXdFN6UmYzNHU4?=
 =?utf-8?B?c2F0VzJydVAwTURLa0hZbGw5NVFVWVQzZ1hnbzhlVzF4V1J2dVF6eFREbnoy?=
 =?utf-8?B?cm0xeWlDandJTktheGYrdXVVM0FYeW84U0hJWjVITmhnUDIxQmo4MFRMaTFj?=
 =?utf-8?B?cytlbUNSbHQzRDVvSmFrWW5XWlVBR1diOUdXN0lhbzJXb1NSRXErZ0tRREpI?=
 =?utf-8?B?aHpjejVzbDNvOVM2VVY1ditOd01HeXJ6cXVNVGgzRXp1RjJiY05pL0h4bit4?=
 =?utf-8?B?SXJSMmhleFFhWFhXalRWUG5IZkVPUkZkN3NLcWlOUHZrYkRzSEpWek5BV1U3?=
 =?utf-8?B?L0kySDF2NVgwNTNENFVYTVRSUHBNUVQzU1ZveFJJbUdUenBNOU9RRjlRVkJq?=
 =?utf-8?B?TDV2aHJBdEFDRDNta1FJc1hhWGJ1UWg3bUswWjZxOFdmemxxT1dyRWdvT0Nn?=
 =?utf-8?B?YzNQZHhWSWVUVXdhWHBkdW1XZzBhOTExL2pCcW1uOHFlT2VmVWZRUkNqNEhy?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BD5E68D62B9FF4CB4FD33539A9B1BC3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d109ae61-13f1-43da-64c5-08dc383e9440
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:21:00.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1jf8kvmLhgAaxGf1z1CRvv5Ug25k48FG7cWWGAIUvozqsKw/WbXyc+Nh6fJ23SCuPvRCKukXLNDJk4125BVtYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5417
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDEwOjU0ICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOg0KPiBP
biBGcmksIDIzIEZlYiAyMDI0IGF0IDE4OjQxLCBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMSBGZWIgMjAyNCBhdCAxNzozMywgQm9yaXNs
YXYgUGV0a292IDxicEBhbGllbjguZGU+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBUdWUsIEZl
YiAyMCwgMjAyNCBhdCAwNDozMDoxM1BNIC0wNjAwLCBUb20gTGVuZGFja3kgd3JvdGU6DQo+ID4g
PiA+IEkgYmVsaWV2ZSB0aGUgaXNzdWVzIHdlcmUgdGhhdCBkaWZmZXJlbnQgSW50ZWwgc3lzdGVt
cyB3b3VsZCBoYW5nIG9yIHJlc2V0DQo+ID4gPiA+IGFuZCBpdCB3YXMgYmlzZWN0ZWQgdG8gdGhh
dCBjb21taXQgdGhhdCBhZGRlZCB0aGUgV0JJTlZELiBJdCB3YXMgYSB3aGlsZQ0KPiA+ID4gPiBh
Z28sIGJ1dCBJIHJlbWVtYmVyIHRoYXQgdGhleSB3ZXJlIHNpbWlsYXIgdG8gd2hhdCB0aGUgMWY1
ZTdlYjc4NjhlIGNvbW1pdA0KPiA+ID4gPiBlbmRlZCB1cCBmaXhpbmcsIHdoaWNoIHdhcyBkZWJ1
Z2dlZCBiZWNhdXNlIHNvbWV0aW1lcyB0aGUgV0JJTlZEIHdhcyBzdGlsbA0KPiA+ID4gPiBvY2Nh
c2lvbmFsbHkgaXNzdWVkIHJlc3VsdGluZyBpbiB0aGUgZm9sbG93aW5nIHBhdGNoDQo+ID4gPiA+
IA0KPiA+ID4gPiAgIDliMDQwNDUzZDQ0NCAoIng4Ni9zbXA6IERvbnQgYWNjZXNzIG5vbi1leGlz
dGluZyBDUFVJRCBsZWFmIikNCj4gPiA+ID4gDQo+ID4gPiA+IEl0IGp1c3QgbWVhbnMgdGhhdCBp
ZiB3ZSBnbyB0byBhbiB1bmNvbmRpdGlvbmFsIFdCSU5WRCwgdGhlbiB3ZSBuZWVkIHRvIGJlDQo+
ID4gPiA+IGNhcmVmdWwuDQo+ID4gPiANCj4gPiA+IExldCdzIHRyeSBpdC4NCj4gPiA+IA0KPiA+
ID4gRGF2ZSwgZG8geW91IHJlbWVtYmVyIHdoYXQgaXNzdWVzDQo+ID4gPiANCj4gPiA+ICAgZjIz
ZDc0ZjZjNjZjICgieDg2L21tOiBSZXdvcmsgd2JpbnZkLCBobHQgb3BlcmF0aW9uIGluIHN0b3Bf
dGhpc19jcHUoKSIpDQo+ID4gPiANCj4gPiA+IGZpeGVkPw0KPiA+IA0KPiA+IEl0IHNob3VsZCBi
ZSBhIGtleGVjIHJlYm9vdCBmYWlsdXJlIGRlc2NyaWJlIGluIGJlbG93IHRocmVhZDoNCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgwMTE3MDcyMTIzLkdBMTg2NkBkaGNwLTEy
OC02NS5uYXkucmVkaGF0LmNvbS8NCj4gPiANCj4gPiA+IA0KPiA+ID4gSWYgc28sIGNhbiB5b3Ug
dHJ5IHRoZSBiZWxvdyBkaWZmIG9udG9wIG9mIGxhdGVzdCB0aXAvbWFzdGVyIHRvIHNlZSBpZg0K
PiA+ID4gdGhvc2UgaXNzdWVzIHdvdWxkIHJlYXBwZWFyPw0KPiA+IA0KPiA+IEl0IHdhcyByZXBy
b2R1Y2VkIG9uIGFuIG9sZCBsYXB0b3AgKFRoaW5rcGFkIHQ0NDBzIG9yIHQ0ODBzLCBJIGNhbiBu
b3QNCj4gPiByZW1lbWJlciksIGJ1dCBJIGhhdmUgcmVwbGFjZWQgdGhlbSB3aXRoIGEgbmV3IGRp
ZmZlcmVudCBvbmUuICBJIHRyaWVkDQo+ID4gdGhlIGxhdGVzdCB0aXAtbWFzdGVyIHdpdGggdGhl
IGlmIGNvbmRpdGlvbiBjb21tZW50ZWQgb3V0LCBrZXhlYw0KPiA+IHJlYm9vdCB3b3JrcyBmaW5l
Lg0KPiA+IA0KPiA+IExldCBtZSB0cnkgdG8gZmluZCBhbiBvbGQgbGFwdG9wIHRvIHNlZSBpZiBJ
IGNhbiBkbyBtb3JlIHRlc3RzLCB3aWxsDQo+ID4gZ2V0IGJhY2sgbGF0ZXIgbmV4dCB3ZWVrLg0K
PiANCj4gVXBkYXRlOiB0ZXN0ZWQgb24gYW4gb2xkIGxhcHRvcCBhcyB3ZWxsLCAgSSBkaWQgbm90
IGZpbmQgYW55IHByb2JsZW1zDQo+IHdpdGggdW5jb25kaXRpb25hbCBuYXRpdmVfd2JpbnZkKCks
IGtleGVjIGFuZCBrZHVtcCB3b3JrcyBmaW5lLg0KPiANCj4gDQoNCkhpIERhdmVZLA0KDQpUaGFu
a3MgZm9yIGdldHRpbmcgYmFjayBhbmQgSSBhcHByZWNpYXRlIHlvdXIgaGVscC4NCg0KSGkgQm9y
aXMvRGF2ZUgsDQoNCkJhc2VkIG9uIHRoaXMgSSdsbCBjaGFuZ2UgdG8gZG8gdW5jb25kaXRpb25h
bCBXQklOVkQgZHVyaW5nIGtleGVjKCkgZm9yIGluDQpzdG9wX3RoaXNfY3B1KCkgYW5kIHJlbG9j
YXRlX2tlcm5lbCgpLiAgUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFueQ0KY29tbWVu
dHMuDQoNClRoYW5rcyBhbGwhDQo=

