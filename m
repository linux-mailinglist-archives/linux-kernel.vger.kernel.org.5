Return-Path: <linux-kernel+bounces-111772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D388870C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0C5B23015
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285057878;
	Fri, 22 Mar 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2EDq+qf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BE954BF7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124509; cv=fail; b=flsTOetIvk+q0yvVRduINLHRCBCgIXlzOUbGB1kHyikVSNBX1KJAgyYBEPZflqsboJdrc7dtbBCP7wmZN5VR3gePTY/WvPnRvhc4xNnvUwQIoDQZ0WyScxfExnW+M5aVobLRst0jdoo7gO9izVORoSkdqz/qKPtnKNMlMtNAQH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124509; c=relaxed/simple;
	bh=MySIYdA8hk+NQUEbe414e5GYZ6il9d2Ifqs8E7xkMrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bUHgaSV74FcjK17WO1z7XG4BEAxl3Sk7wxj38I+MkylGZIdcR3FV5FJEbtX8qRcQ3I1d7RBD1Z3zvw+e/I9X8F7SdPgwjKiWQHDfUbJ/ftbo0AaN3KHT3gBds4n+Ai4KpG1RehDbohIlgqDtBnhSf2iVICssqr0SWtIiB1FKgd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2EDq+qf; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711124508; x=1742660508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MySIYdA8hk+NQUEbe414e5GYZ6il9d2Ifqs8E7xkMrg=;
  b=f2EDq+qf3pkdNDIt9t924hNLFsK0OnRfVB6IURlupYfrU8fWrNRxCvis
   Fmtf1XkAkKTOrmAiYT9w4+UJ2+6SKvuFIZh2t5jVSPEyGvordC0vMkjyx
   XsBZ4At8s3S0PtdoKwvbAlZW6QLyPtrK4kfwKkcl4pZ6oye+ZOYN1vyI6
   E+27bTKFBHJ4yyE+k1JbGiepZCQnxKVggG1pncoKNKdpnYH32rLBBfdj6
   g5hQXavRjsVnN8vRS8LJ2vGeOBKJso0/NUD/5v4VP86HNm+Y4UdDDUW/L
   owyeFtbq1VnibeGnPUj6krxC8SC8hAqyzKuLSwnSTuuAb2/XlDZKOPUn/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6292770"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="6292770"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15363741"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 09:21:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 09:21:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 09:21:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 09:21:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 09:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc+agS8aenwe1u06D2SkxL4PUE4GYqF/PslvaMrvC1Q7+g6yHAEav+nNLZOuwXGLhdCV4aeQRT0epy7c1shmdWioxq8RD9dszmNBDOS2EtiuFXFb7O9EaGt6Uk720iDiWV2pZA/FuV36nQIFjiQ6VxkKYZk+2bOu05ze8CFV5RTOwZFvWWi32F7UUH6Rjxz4zzUnrBLwcASkBj4sBgfz7L6PaYbsZMGPZS6ryaxGbBTxl7fHse9UF9YzWDPJVOLgcZpADcI7CFLpfOS0rJERtGCgiNeURxg3T4nHGBrYO+ViW6OmuWhp0RLGEEYTMZhLl4F4ij+661tZ6QPSDi36YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MySIYdA8hk+NQUEbe414e5GYZ6il9d2Ifqs8E7xkMrg=;
 b=VwBqqtYC7E+otwTDTRq5R3MmNcDqZTN8WM7uT8/MjpPVGtukH21s/wmTj0jQpNNA/pymn9dShiq8HutnifcBf4Sa9Lu+gooxgsZjpUxQruKADvCSLu2GAWlOT5Y0JrZIMc/eNcE4YMdx2kfAIdWHSBJ5T1oUBV7SgvqPrrmDTrvXUxwC8Wqi4y8/ii+REqsVes4DmbTPLeNhbcOz7U2DH36UHVDGGOkQm2nhg4+/gupRoNqvlMeJ9+q1vc94vOSZ1QQtPW+5I0yT/Va5hzpGc92Fcpl0T31Et6ykWpd3ADm6oBkgvDS+02qZjJGXM3QrQEJhFcJzCAyniBlhJuGojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 22 Mar
 2024 16:21:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 16:21:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Topic: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Index: AQHaduH6Cs7bYZFPJUuH5QAqHlZq5rE42gyAgAAD8gCACvjHAIAAEIUAgAAOdQCAAAKfgIAAA+oA
Date: Fri, 22 Mar 2024 16:21:43 +0000
Message-ID: <4df8ad26255726619202eef517e0080ab75762a1.camel@intel.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
	 <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
	 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
	 <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
	 <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com>
	 <95a27fd1e3b263d2b002c47751b1b42b3d639bae.camel@intel.com>
	 <CAMe9rOpO7=KL5XuvtR=cCSVatEsT5eFn7nuknRnDDQk9PbCb9w@mail.gmail.com>
In-Reply-To: <CAMe9rOpO7=KL5XuvtR=cCSVatEsT5eFn7nuknRnDDQk9PbCb9w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB8665:EE_
x-ms-office365-filtering-correlation-id: 7754f5ec-71fd-4dce-8611-08dc4a8c29db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zm5iabfbfL2Qnt4WDPBsgG1DilJRLR9s/dVI9xjJbWOxtPoE20nNrXTpIGsBULo6/PlI7nBiybS2qEIaw4islZMQNDtkuK+rTAqTBCaQkggMiKBsSXEBkAbGFxT9Y5Wy/exVydbDgodHvTnQfZDrW7Sa5yGqjeu2JSs353Um5LGdZgMJ0P4rCYmwpF7XGypJEO4+cbI8TBOBthPDAwN9YH1G62Al4ddKX7njuAxtJ92Xanz6uP9d22Sxc4SCxMgJhLBR32Nm+CH4/I1P85VpAu1wdGWrpYSCrouQKG0Ae0/kI+n9T5OFduaCxhGEJ7UPOhZKj64+E0jPQD2QijCp3QT4gi1mEXJNo+Jh5957xn/4NNHRZr4uDviNGe5XihAy9bjvWYUIFCEZI9ZeWN1LHaKPaRvz266m9LQSDTTi766Nx94yvbmRx6pSrSH1Mi2347ylGptKmhS8LRX0pDomQPSQJ+lTFWTxKyIEZQ9GCfJkhSqiYtbyeER905TNVuwn0YXQrWLNXKdSFs56YWnZrdy7xYVWDh1QHDcAbTJFRxElflX7SSmM22fWSzA4nx9A0wosvoHzNxX3NtYPdr90VvXUcrmWkyO6vRzSRv0Q9Xpnn8zq66Ze2Lrf3hmzl77dmCvK8ZUFHnZxDDHiMzqKaE42ulJiaYncaxPR5UySX5qCrACSCocTjK6Uu0nZHUSHwSf3GcAXPsKVxfuDCts9WVMa3PA12LqrtzfuvhxANiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUVjcU1tS2VSdmFFVVV0b0p0eVQ3emZSYjdHWXlHaWNnY1pZUUErYWVXZWhh?=
 =?utf-8?B?RHdtRGhwWlY1RHJCY2hhWU0yVDJ3VTljb1FWa0FZNHZIeWR3aU14ZVIrZnlF?=
 =?utf-8?B?VVlrS2ZKZ2xHOEZCOHM3Qks1SFlZaElqaXNaWDZBWE80MHB2eVp6TTAwOEZ3?=
 =?utf-8?B?bFZFanVrdFg0cGhHVUFaUUZlYjhRQmRVV01tM251VEZuZ0JxVTZUWnZHNDFE?=
 =?utf-8?B?QUdhNHNLVXNFS0Q5RzdVSVVGNjA5R2puT0xrd2ZBUHovOW9od0pmSUVRRlB4?=
 =?utf-8?B?cnBWS2g3ZmpBZnNobEVWc1ZEalhMbkNFQ3VXeE1OQm8vSjk3dmhwcDBXVTNX?=
 =?utf-8?B?RnF6TlBDNlVnd2MzUWhKMGc1eDFubTRZdDAvWktqMmRxb3ZPcE9rRTJIb21I?=
 =?utf-8?B?R0NIc2lUdFJrS3dQaU1MM1hZZS91djJLbW1nTkVCL0VVM1R2aTZjbGJSbWhv?=
 =?utf-8?B?WlpFTEZENGZic2owVlFaWVdhbytnWVBUcXdCbGhpM0E1alFXTG1DQXFZQmk0?=
 =?utf-8?B?OVcxeU94ZU9TMWROdzRFWUQ1REZUQ0NSNlFwT2gza1dDelRoVStGWFAyMDdp?=
 =?utf-8?B?K2lVSy9nb2QzWVdNWTJNRFFVcVpPdXRiMW5sOWRGQ0hKYWxLcVg2S29aWU5j?=
 =?utf-8?B?RU5GQzFGeUVFVTVRSjJDL1VUZ1Q5ODU4Wmp3SHFJdDBKWGRDVHR5NW56VHQ3?=
 =?utf-8?B?Wit2K2pENzdyR2g1bGhOMEpLNEJDRk9rNHdJbzVSYnd2U25tZEhQaVh1WnU4?=
 =?utf-8?B?TlY2dnYzVVZoNTE2bWRJTysyamJqQVM1dFh4NERWTEZVOUFVWTFIMmo0TGI3?=
 =?utf-8?B?WmJsQkJQSkFJbG5zcFkrN2V6QWVjVzZFdXhxWFMxUFBwNk4vcVpsd1RGdFlE?=
 =?utf-8?B?WjBHc0c4TlAyNFdmdVNyT2J0ZGI4VWd6Umg1cG9UbFZORW5iNnQ5cGdTRkI2?=
 =?utf-8?B?Sm5nZ21HTGJwODUzV01GYTcybEcyeDRqMGQ1clR3bW55MDRrTWpWVGkxZWNO?=
 =?utf-8?B?YXNOZDBwalhCSlNFN1dkYWpOamh2MEg3VWdSNXVJYmxOUlJ2NWdlYUxhUG5x?=
 =?utf-8?B?Y1lYNnRjcE9IRDI5ZllpMmMrRFhrbjRsQ2JmdVJCSHcyTHFmc0RWbXhTZW1t?=
 =?utf-8?B?SWN4RjFIcHdCSndHbVByUzZIeDRQeEdTZHpqUDY5ekMybTRGcGRHbEJ5b0M1?=
 =?utf-8?B?aEhNa3ZySGV6MjV4MG5qd3FRM3FvU3QvMUtDTU5qSU5ZdEZ4WWl6YlJtYXd0?=
 =?utf-8?B?NWNjNXN4a0h5M0sybnd0UHplYVBGYmZLVnFvbEdiSXN0T0oxQzM1eXlrZFpP?=
 =?utf-8?B?TmVNODRJM1JXb3d4Um5TQyt4RVc0UE5DRGNJZ0UzVXhyOEYwblNFR2VERHEz?=
 =?utf-8?B?YksydzNEMVJybDl0QTJWTWIyei8yU3VUa25NWW9VUWk3VXgwaE83VEVTMm8v?=
 =?utf-8?B?SktObmp2ZFowQWRXNXRnYnJpdGtFcHBObGhiRTBGenRYZU1HVkxCdzQ1bHhU?=
 =?utf-8?B?Ynh6c3o2eHg4S2ZRVXUyb1dwRi9uVElIdDRRMGdhTXU2V2w2Z3ZRSjM2aFdQ?=
 =?utf-8?B?Mm1GaThJWDVoV2dyR0hwRm9qN0VVWWl6cFBNRkd0SlJ0aGpiZFRKRTJRQ2VC?=
 =?utf-8?B?Ylhlak5VMDFqRTQ0TjNyd0N3RTY2UjZsMWxVbk44NGw0SUVHekVtTFg1WVo0?=
 =?utf-8?B?c2dZTlp5U0VXM3pISGNVOGxWMUtHQVJsQ1BjZkpkaXlBcnNFKzIxVkpuVmxN?=
 =?utf-8?B?ZTRoY1UrWW94TG9uWDRLd1VOZWJjL2lvU2w4WFpsNFRJalNKRytQZjNGQVV6?=
 =?utf-8?B?K3I4RkYxcG9XcER5b2xSZjFsR2dHZnh0ZUFVdm9obURqalhtR3RZZzJyMy9J?=
 =?utf-8?B?WEFEL1R2TjJTMkd6WnNNSktiL1lqelBweGRTMzlMQUQ3RmQxK2QwaWxKN29R?=
 =?utf-8?B?UGZKUTdydm9WaE4zc2lSS1BmMzZPVXlybzB2M1FtRFFTVFpkVGF4RndxR0gy?=
 =?utf-8?B?T0hEbTNBT2ZJcTA5SjJOa3NaYm5QVGhCSnR0QmwyYU5ScTJ1WXhJQzVsa2Zq?=
 =?utf-8?B?VmE2UnFaQmdGaGpBVGFMSzVvdnFCMVhZY3FmalFtQWJ0cDZyOVczNkYwU1Bl?=
 =?utf-8?B?YUN4Skd6dW9WbTJCRDlQOGozalFUa29tSFBxem4yREFFS0p6QXBsaktnTnJ3?=
 =?utf-8?Q?RPXgiduk1RoLdl32lZtLdkA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D8A95DF0687AD46A1F65452572C06A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7754f5ec-71fd-4dce-8611-08dc4a8c29db
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 16:21:43.7650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eowt3pjp+nxq+bdBBVSHtWIfeFiCdU26yL6Fwsd74pfAKznvRFPLS+6oLir39FSfK7/eqRQHFNooQ6YNnzN7+4ZPhxUEFS9HPIcFJSLlRew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8665
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDA5OjA3IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+IEkg
bWVhbiBpdCB3aWxsIHJlcXVpcmUga2VybmVsIHdvcmsgaW4gdGhlIGZ1dHVyZSB0byBtYWludGFp
bg0KPiA+IHN1cHBvcnQuDQo+ID4gVGhhdCB3ZSB3aWxsIGhhdmUgdG8gdGhpbmsgYWJvdXQgeDMy
IGVmZmVjdHMgd2hlbiBtYWtpbmcgb3RoZXINCj4gPiBzaGFkb3cNCj4gPiBzdGFjayBjaGFuZ2Vz
Lg0KPiANCj4gSXQgaXMgd2F5IG1vcmUgdGhhbiBrZXJuZWwgU0hTVEsgc2VsZiB0ZXN0cy4NCj4g
DQo+ID4gSSdsbCBwYXN0ZSBteSBvdGhlciBjb21tZW50IGluIHRoaXMgdGhyZWFkOg0KPiA+IA0K
PiA+IFRoZSBtYWluIHVzYWdlIG9mIHNoYWRvdyBzdGFjayBpcyBzZWN1cml0eSwgYW5kIGNvbWVz
IHdpdGggc29tZQ0KPiA+IG92ZXJoZWFkLiBJSVVDIHRoZSBtYWluIHVzYWdlIG9mIHgzMiBpcyBw
ZXJmb3JtYW5jZSBiZW5jaG1hcmtpbmcNCj4gPiB0eXBlDQo+ID4gc3R1ZmYuIFdoeSB3b3VsZCBz
b21lb25lIHdhbnQgdG8gdXNlIHNoYWRvdyBzdGFjayBhbmQgeDMyIHRvZ2V0aGVyPw0KPiANCj4g
SW1wcm92ZSB4MzIgc2VjdXJpdHkgYW5kIHVzZXIgc3BhY2UgSUJUIHdpbGwgYWRkIG1vcmUgaW1w
cm92ZW1lbnQuDQoNClBsZWFzZSBlbGFib3JhdGUgb24gdGhlIHVzZXJzIHRoYXQgd2lsbCB1c2Ug
eDMyIGFuZCBzaGFkb3cgc3RhY2sNCnRvZ2V0aGVyLiBIb3cgbWFueSBwZW9wbGUgYXJlIHdlIHRh
bGtpbmcgYWJvdXQ/IFRoZXkgY2FyZSBlbm91Z2ggYWJvdXQNCnBlcmZvcm1hbmNlIHRvIHVzZSB4
MzIsIGJ1dCBhbHNvIGRvbid0IG1pbmQgb3ZlcmhlYWQgdG8gaW5jcmVhc2UNCnNlY3VyaXR5PyBQ
ZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZyBvbiB3aGF0IHgzMiBpcyB1c2VkIGZvciB0b2Rh
eS4NCg0KDQpbc25pcF0NCg0KPiA+IA0KPiA+IFRoZSBtYXBwaW5nIGFib3ZlIDRHIHdhcyBiZWNh
dXNlIFBldGVyeiByYWlzZWQgdGhlIHBvc3NpYmlsaXR5IHRoYXQNCj4gPiBhDQo+ID4gNjQgYml0
IHByb2Nlc3MgY291bGQgZmFyIGNhbGwgaW50byBhIDMyIGJpdCBzZWdtZW50IGFuZCBzdGFydCBk
b2luZw0KPiA+IHNpZ25hbCBzdHVmZiB0aGF0IHdvdWxkIGVuY291bnRlciB1bmRlZmluZWQgYmVo
YXZpb3IuIEhlIHdhbnRlZCBpdA0KPiA+IGNsZWFubHkgYmxvY2tlZC4gU28gYnkga2VlcGluZyB0
aGUgc2hhZG93IHN0YWNrIGFib3ZlIDRHQiwgZXhpc3RpbmcNCj4gPiBwcm9jZXNzZXMgdGhhdCB0
dXJuZWQgb24gc2hhZG93IHN0YWNrIHdvdWxkIGJlIHByZXZlbnRpbmcgZnJvbQ0KPiA+IHRyYW5z
aXRpb25pbmcgdG8gMzIgYml0IGFuZCBlbmNvdW50ZXJpbmcgdGhlIG1pc3NpbmcgMzIgYml0IHNp
Z25hbA0KPiA+IHN1cHBvcnQgKGJlY2F1c2UgdGhlIENQVSB3b3VsZCAjR1AgZHVyaW5nIHRoZSAz
MiBiaXQgdHJhbnNpdGlvbiBpZg0KPiA+IFNTUA0KPiA+IGlzIGFib3ZlIDRHQikuDQo+ID4gDQo+
ID4gUHJvYmFibHkgdGhlcmUgaXMgc29tZSBpbnRlcnBsYXkgYmV0d2VlbiB0aGUgeDMyIG1tYXAg
bG9naWMgYW5kDQo+ID4gc2hhZG93DQo+ID4gc3RhY2tzIG1hcHBpbmcsIHdoZXJlIGl0IHRoZW4g
YmVjb21lcyBwb3NzaWJsZSB0byBnZXQgYmVsb3cgNEdCLg0KPiA+IFNpbmNlDQo+ID4geDMyIG5l
ZWRzIHRoZSBzaGFkb3cgc3RhY2sgdG8gYmUgYmVsb3cgNEdCLCBpdCdzIGluY29tcGF0aWJsZSB3
aXRoDQo+ID4gdGhhdA0KPiA+IHNvbHV0aW9uLiBTbyB0aGlzIHBhdGNoIGlzIG5vdCBzdWZmaWNp
ZW50IHRvIGVuYWJsZSB4MzIgd2l0aG91dA0KPiA+IHNpZGUNCj4gPiBlZmZlY3RzIHRoYXQgd2Vy
ZSBwcmV2aW91c2x5IGNvbnNpZGVyZWQgYmFkLg0KPiANCj4gTWFwcGluZyBzaGFkb3cgc3RhY2sg
YmVsb3cgNEdCIG9uIHgzMiBzdGlsbCBwcm92aWRlcyBzZWN1cml0eQ0KPiBpbXByb3ZlbWVudHMN
Cj4gb3ZlciBubyBzaG93IHN0YWNrLg0KDQpBZ3JlZWQgb24gdGhpcyBwb2ludC4gSSBkb24ndCB0
aGluayB4MzIgc2hhZG93IHN0YWNrIGhhcyB0byBiZSBwZXJmZWN0DQp0byBpbXByb3ZlIHNlY3Vy
aXR5IG9mIHRoZSB4MzIgYXBwcy4NCg0KQnV0IFBldGVyeidzIGNvbmNlcm4gKEkgdGhpbmsgaXQg
Y291bGQgcHJvYmFibHkgYmUgcmUtb3BlbmVkKSB3YXMgdGhhdA0KdGhlIGlhMzIgc2lnbmFsIHN0
dWZmIHNob3VsZCBub3QgYmUganVzdCBkZWNsYXJlZCB1bnN1cHBvcnRlZCB3aXRoDQpzaGFkb3cg
c3RhY2ssIGJ1dCBibG9ja2VkIGZyb20gYmVpbmcgdXNlZCBzb21laG93LiBTbyBpdCB3YXMgcmVh
bGx5DQphYm91dCBiZWluZyBhYmxlIHRvIG5vdCBoYXZlIHRvIHRoaW5rIGFib3V0IHRoZSBpbXBs
aWNhdGlvbnMgb2YgdGhlDQp1bmRlZmluZWQgYmVoYXZpb3IuICh3YXMgbXkgdW5kZXJzdGFuZGlu
ZyBhdCBsZWFzdCkNCg0KVGhpcyBwYXRjaCBpcyBqdXN0IHR1cm5pbmcgdGhpbmdzIG9uIGFuZCBm
aW5kaW5nIHRoYXQgbm90aGluZyBjcmFzaGVzLg0KSXQgbmVlZHMgbW9yZSBhbmFseXNpcy4NCg0K

