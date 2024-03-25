Return-Path: <linux-kernel+bounces-117706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377D88AEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACB428CB59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44957DDBC;
	Mon, 25 Mar 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPxTcKyZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A33DAC12
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391290; cv=fail; b=qp5dlo35RXQR/18KFkEdo9Ai02Us77sb07h7IaK5qL1snXG+AVSpR9KB7HNqZgUfqP0kyd8Y5tRGttBjMOpBhesC0fHWTWHPgaVJr8FVG6uNa/vT8G7Px++21drHwxVQtZ0YPlsHWP7P15T8eM3ztZV+rZ7bc0VBZUhKqxECQUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391290; c=relaxed/simple;
	bh=t632YQx+unw82jU0bSQ6x9iZI+WWJ1VDKJoFA8wjVEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZrjUmCGHDfhuogCihni4DrFD1NGfcUasXREcVc0HSAwI5vVarBHDlrPFosIIsn69U69u98xNVvb/im/b4BPwI4OwfIAy/wj7MRIUu8r3ZZI1JLIR5wWUOSLxty0VBSz3rusbar8PeoWOfRTOQG/pErFkPH7WPfAf2vc88qBf+Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPxTcKyZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711391287; x=1742927287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t632YQx+unw82jU0bSQ6x9iZI+WWJ1VDKJoFA8wjVEY=;
  b=FPxTcKyZlkhBdIO5kU9E1DRTw4M0a6afTpZeli6UsLM7BM/meZ/hCDWN
   v0c6SgTMZicWTSM7ZmGrgJS6L3LQyIqrTOIJVS8ZHimKdOz3jJsskoCR1
   HeC56iv3COx+yHe+VRrJ16nC2qw9ZiaYUYBBInoHjhFfkQfZHMLJkY2k0
   Kb5HqtBq1cjKbPDQHD/l971EAcVuuljXY3rv2gfBlimIzazzAc7ojM/JI
   DrxbPUB1fCfa3dYpMC97iV2jjGkh3tVw74PGtFOnuVNEg/AyVKvFO1qc6
   BNq+DQd+KzjZ+SKAC4x4Ric3TEd286LPA9hOYEV24BR2qRxnGtbXlKB7Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6244255"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6244255"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:28:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20168447"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 11:28:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 11:28:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 11:28:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:28:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1X/LfKXym6Z6eg08VJifwK17YuoiARaJW6LjgOZoGqeI5jHbae0gOfbHTvfsOOVfTqYzek73OL5HQOrB/KsX6zpxZmnWDXRrpa8DdQIpSLMBUQAj9XUh8e4blfAeszOxCtUPdbrulgxikZ2d+lCtQ9EluuraMwOADijlc2mbQx8danHp5uMwiNxdzWrBIWRu/Hcr1fyuq3S0Epz49wHLGse9D35xh0kn3Dq3Luuc5PsYCwHBOvTj9aMHAzk3XhiNgY8Du3oCziB8yuhTqRc4NDwUI/0JZUGO+hKgEm39mIDxtXqKHNFCnjF2E03B05lrtbxeIv40Oa0aAzLL2E7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t632YQx+unw82jU0bSQ6x9iZI+WWJ1VDKJoFA8wjVEY=;
 b=JfXz2MIO+NzIeuXaTqSfaYInVB6SGzeQeJ+U5CPZ5QBsj8tHItsT/NkX2oXzzYi/wwWvSuWmCCDLYu4RvDM5gH58LR5sijfHoheMOgDBhv/D5VWFewKadDSVlJi7J4AK2woKtvA7Taiuct5fcftePuXUQQ2YoYqPQENvGucxPjUyXqJLRIiSsb4nWRjltrjvzLH9iMU9QaQ1gnwK2ktXAuTX+w+zr9btMIMIMm4GgHSx2CZwgXhEIVBFiu+CuNE80KHVRU7hGLJGu11GZR6Bz+IEvO3EyBoCr/6zpGE3qWy1DhbWvl8AkouVQMYQP99ApDDw1Snb6BD1UqomwGQjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 18:28:04 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 18:28:03 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>, "De
 Marchi, Lucas" <lucas.demarchi@intel.com>
Subject: Re: [PATCH v3 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v3 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHabkHHanzUOwR7gE2NE9Rgc7qov7FIz2EAgAAYcYA=
Date: Mon, 25 Mar 2024 18:28:03 +0000
Message-ID: <c9c5436eb51f181aa78d63e0842457dc0c4da887.camel@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
	 <20240304143905.52740-2-jose.souza@intel.com>
	 <50c40ce746f1497cbc36ad82d6d0d3ca3ac28547.camel@sipsolutions.net>
In-Reply-To: <50c40ce746f1497cbc36ad82d6d0d3ca3ac28547.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|PH0PR11MB5176:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sZxawz5jQmRezp1/YQ1FJ/E+B1NLl06PuBNrf8oDy6itRwLlMEkqw/HzHFTK8rG4vx+Gn6zS0v4Evt59Ov5WROFd8bi7InPAJnI3g/navTBbCwKM9HUesIJ6mBJstjZyqgcEZ0PyjSCShXo8vBt4EsaI/ohId7OGbl7D1Em/R2iOXtU698EH306NfbmQlvZIOV12vbjNrBNZo2QLRENNvZ+BKdvstOugu/zeNe6c2hRReje6fj8Ms5DKuWjLIeJMrd/TZAVTCSgmkWKhksLiiv3b0+ABHclsavG08OKfVPH6xcoEX4iBpCJJBs1qe2FsKH8dZO2MhozF2INwAq4/v3L3cwoL4D9h+LfDpmpYC8Vcyt5JCGqJk/g3x2mtozjsAc1L8OcISDGUwl2TLNKRM9+FMQSGjQCYwQYBDBhYnTktJcVVo7bs7kF3X0k6NmTuK2CbuFlOtJM643WYfMNhOFLGvwJv9zIY288ZKYl1Cv0NYnRoawDBIysDCXEYroWp1oqhh5jLsKDKp6E+QgT+SQVDrgYoYfC5MRwnmArzcA4wgiafohG38PUbPKGFl7BzyT5kZVfqyK814NkS2ew6IPPKceQxNlRfwN9TmtsDI1tWxSwcv/kmQqn+E6U/kuM4L0zb1m5Hcnz6PScI4HJLLw+Dir+eY+FwUnC1YVa//8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RRSUg0TDQxRlE4YnIrbjNBYldQcDg2K2VlRE41QjFKajZuMkFsdUtqOEEy?=
 =?utf-8?B?dWdHcDR1TGVWQ0MvY1N3OFQrOFJKSEpkMHpVZEhvekVMOStUV1hCOFczdCts?=
 =?utf-8?B?WnZLd2tWT0xoSHFLQ0FrUUZlQlpBTlZzNFN0RzgvT1lDMkUrMDI4dXRhb3hh?=
 =?utf-8?B?REdzUWZiVHJ2N2IzYWxNTU51WGR2V0o4UXpDTmNNbHZMNjJLcUtOSjZ1VStV?=
 =?utf-8?B?SDByNzVyUi9kMWUvbUYvS2RxR2dGUjl4czNsS0xYWURvSElqaXNMb3dpVStN?=
 =?utf-8?B?OElqbFVhZ29hRU1qcjROVWEvSlBzYnF4b1hlNFZZVDRFNVltdlpZUHArSWJP?=
 =?utf-8?B?em1CckJxUVpiYXdnbm5rVDc1YmJrZzhKZkVsb28yN3Z2MzFwZFJPT0UwN0xm?=
 =?utf-8?B?R3FNeHcxekg2OWRaKzZFeVlIaTFyZFdON2hCT0lSV3pTYjRDMmkxM2VMR0kz?=
 =?utf-8?B?UkxHYXZrQmJ1SFM5UkxTNHp3WGVHRWRESjRvWjdKQ2M2N1R4MUNTc1NVL01k?=
 =?utf-8?B?d24xVTJIc3hXbWl3cUMvaU4wKzNLV2RYcmIxcSszcUF6SmlDVHovaytsUUZz?=
 =?utf-8?B?MTNwaVBHUk5KZnhqTUE4dTZyaFlLU09mV09EM0I4R1pBZDFBTUlEYXlNbEl1?=
 =?utf-8?B?QzM0cHJUUzUxRWwwL29DaFVzd1ZadytBR3pZbXRHemZGaWc5c2kyZ0VYUzUx?=
 =?utf-8?B?RTFwQTNKVmVlUzQ3cWZzblhzbFRUM3ZuRjFLMGxrd1dFN0NtMEYvNzdzajlu?=
 =?utf-8?B?ODI1OHMrSFZEaEhQd1dZZGxjUEEwT1VqdnFvaHk4TVJHRzlTWWJHTnl1SWI4?=
 =?utf-8?B?Y3FkWU1lVTEyU2NBbU9IbHlXdldxWVdpYytsVDhrYU1CV041N1JMZ1Rtd2t0?=
 =?utf-8?B?S1g3YXkrSU5Rbi9WU3J3ZnR2bHYzOHN1TGovZzRYdDE5Q3hudkYwL1FnOER4?=
 =?utf-8?B?b3k5OXp1QkZ0RGtUeUN5U3g3aWNUeC92MHF6VTdncDFPc1NkNk5VYlRXdzds?=
 =?utf-8?B?L2ZlNHdPUW02RjFtVWd4RG94L2RBVnB4ejM4YmdvaDFlVnhnUXFTaTgxZVZr?=
 =?utf-8?B?WFJScVFjSTFCL21qUGdrbTU0RDR6djRBMUpON3ozbVJFWXlwMkVLcVp2NEVH?=
 =?utf-8?B?alVnVUJaMXZaOTVZei9COFhKbkhCcDlieVJ0UThkcnphUHI4b1RSa2FSa3Zr?=
 =?utf-8?B?M3hpVkptaWxGVVdONnlhd2V4Q2NVRjNRL3dCVEJjUDRrSTVPaWR4VHg3QXk0?=
 =?utf-8?B?aDhxZzFBbVBENU9HalcrSG9NbmhDd1Q1dE5ZVU00ckJ6NHNUUG4vMmJzNlBF?=
 =?utf-8?B?QVRBanNNU05ZdVU0RWErZWRHS0wybDdvdzJOUERIcGRQRDAxU3FZQ1NJYnhI?=
 =?utf-8?B?Y2ZDQXI4UmhaS2F3Q29DdG45MjUzOHQ4dWJGcjdLTGtLYmsva3h0ckQxQ2ZE?=
 =?utf-8?B?OUhDS1F4WXc5OXdwTUJ3TWxlRFNidkFmUDJ3cWJCWWx0Y2hIdVE4VkQ1eW5X?=
 =?utf-8?B?elNiYWhaSEpBcEpOOEg4K2JHdGFiNXphTnVRZFNCZGRLTUFaWXdxcGVjSzVq?=
 =?utf-8?B?YjlkMHJ1MkJKa3dxRC8rN3d1Y3ZRZHlqc3J0RnU3SW10MWtVRE0vTnBoaWFh?=
 =?utf-8?B?am11NHd0Z21hV3pzLzNNSlRYUnpuUFVVNysrZnNHNUJwT3JaRldld25TUDVS?=
 =?utf-8?B?cnFJRkhzOG5ibE9QRkJUK0FjZEZyNmQwdTVkdWdxamhyTGJLOWthVTB5ckE0?=
 =?utf-8?B?U0NuQnp4ekhRVkZQTUprcmJyT1FXaU1KZ3VoYUlUSkowMFFBQmk4WWRCKzdr?=
 =?utf-8?B?WWszUzZJdFcwL1laNWRYbytucldUWkR4cnJ4SUhOTi83RktVbk1UaUlra3ZU?=
 =?utf-8?B?TG5ST25Wa3p1Z3dxV3lDOG14V3JrSnFvaHMwWlVNZmF1ckZVb2o0NHFUUlN4?=
 =?utf-8?B?aHhFbmJ1MTJ4dVNYSEcrcWxzdUhYQnFqTDRPL1luZitPRko5T2Z5NXBma0Ru?=
 =?utf-8?B?Q0RWekRiSk9XV21NUU5ETXFFMXlTUUpiM3lCVGFSZDhSd2ludXlDWk03b3NE?=
 =?utf-8?B?ZlRYd2VwSEF3SmVXUWs3eWpVTmZwNmJNdEdqS25Ibnk4Y1F4c0UwZ0I3ZmVZ?=
 =?utf-8?B?RkZ1M3pIdW1TeElmUU5lYms0QUxqWVVnZkl4YlJnZUJIQWsxd3BSTS95STl3?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00A3ACD542F5EB47AC9FCAA5C16626F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967a8325-42c4-403e-d49c-08dc4cf94f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 18:28:03.8397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +erLGsCS2tRZHpxX35+lSgJmYjh5yrIsLxwylUYsvpqKNiDXs9ut6CzmrhhxygQvFuTYBw9jBwOCRaaM5KfdKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5176
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDE4OjAwICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjQtMDMtMDQgYXQgMDY6MzkgLTA4MDAsIEpvc8OpIFJvYmVydG8gZGUgU291
emEgd3JvdGU6DQo+ID4gQWRkIGZ1bmN0aW9uIHRvIHNldCBhIGN1c3RvbSBjb3JlZHVtcCB0aW1l
b3V0Lg0KPiA+IA0KPiA+IEN1cnJlbnQgNS1taW51dGUgdGltZW91dCBtYXkgYmUgdG9vIHNob3J0
IGZvciB1c2VycyB0byBzZWFyY2ggYW5kDQo+ID4gdW5kZXJzdGFuZCB3aGF0IG5lZWRzIHRvIGJl
IGRvbmUgdG8gY2FwdHVyZSBjb3JlZHVtcCB0byByZXBvcnQgYnVncy4NCj4gDQo+ID4gKyAqLw0K
PiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wbShzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KPiA+ICsJCQkJIHZvaWQgKmRhdGEsIHNpemVfdCBkYXRh
bGVuLCBnZnBfdCBnZnAsDQo+ID4gKwkJCQkgc3NpemVfdCAoKnJlYWQpKGNoYXIgKmJ1ZmZlciwg
bG9mZl90IG9mZnNldCwgc2l6ZV90IGNvdW50LA0KPiA+ICsJCQkJCQkgdm9pZCAqZGF0YSwgc2l6
ZV90IGRhdGFsZW4pLA0KPiA+ICsJCQkJdm9pZCAoKmZyZWUpKHZvaWQgKmRhdGEpKQ0KPiANCj4g
bml0OiBsb29rcyBsaWtlIHlvdSBtaXNzZWQgYSBzcGFjZSBvbiB0aGUgJ2ZyZWUnIGxpbmUNCj4g
DQo+IEkgZG9uJ3QgdGhpbmsgd2UnbGwgYWN0dWFsbHkgX3NvbHZlXyB0aGUgZGlzY3Vzc2lvbiBv
ZiB3aGV0aGVyIG9yIG5vdA0KPiB0aGlzIG1ha2VzIHNlbnNlLg0KPiANCj4gSSBzdGlsbCB0aGlu
ayBpdCdzIGEgYmFkIGlkZWEgdG8gaGFuZyBvbiB0byB0aGUgZHVtcHMgaW4gY29yZSBrZXJuZWwN
Cj4gbWVtb3J5IHNpbmNlIHRoZXkgY2FuIGJlIGJpZyAoSSB3b3VsZCd2ZSBzYWlkIGF0aDEyayBp
cyBiaWcgd2l0aCA1NU1CLA0KPiBidXQgUm9kcmlnbyBzYWlkIGdyYXBoaWNzIGNvdWxkIGJlIHVw
IHRvIDJHQiEpLCB3aXRob3V0IGJlaW5nIGFibGUgdG8NCj4gcGFnZSBpdCBvdXQsIGV0Yy4gVGhh
dCdzIGp1c3QgYSB3YXN0ZSBvZiBtZW1vcnksIGZvciB3aGF0IEkgZG9uJ3QgdGhpbmsNCj4gaXMg
ZXZlbiBhIGdvb2QgcmVhc29uLg0KPiANCg0KVGhlcmUgaXMgYSBkaXNjdXNzaW9uIHRvIGhhdmUg
YSB1ZGV2IHNjcmlwdCB0byBjb3B5IGR1bXAgZnJvbSBtZW1vcnkgdG8gZGlzayBhbmQgdGhlbiB0
aGUgc2NyaXB0IGNhbiB3cml0ZSAwIHRvIGNvcmVkdW1wL2RhdGEgYW5kIGVyYXNlIGl0IGZyb20N
Cm1lbW9yeS4gQnV0IGlmIGRpc3RybyBkb24ndCBoYXZlIHRoaXMgdWRldiBzY3JpcHQgaXQgaXMg
c3RpbGwgZ29vZCB0byBoYXZlIGxhcmdlciB0aW1lb3V0IHRvIGFsbG93IHVzZXIgdG8gY2FwdHVy
ZSBpdC4NCg0KVGhlIDJHQiB1c2FnZSBhcmUgZm9yIGNhc2VzIHdoZW4gVU1EIGRldmVsb3BlcnMg
ZW5hYmxlcyB0aGUgY2FwdHVyZSBvZiBldmVyeSBzaW5nbGUgYnVmZmVyLCByZWd1bGFyIGNhcHR1
cmUgc2l6ZSBkZXBlbmRzIG9uIHRoZSBjb21wbGV4aXR5IG9mIHRoZQ0KYXBwbGljYXRpb24gYnV0
IGl0IGlzIGdlbmVyYWxseSByb3VuZCAyTUIuDQoNCj4gU28gZHVubm8uDQo+IA0KPiBIb3dldmVy
LCBJIGFsc28gZG9uJ3QgbGlrZSB0byBleGVyY2lzZSBhbnkgcG93ZXIgdGhhdCBJIG1pZ2h0IHJh
bmRvbWx5DQo+IGhvbGQganVzdCBiZWNhdXNlIEkgaGFwcGVuZWQgdG8gd3JpdGUgdGhlIGNvZGUg
aW4gdGhlIGZpcnN0IHBsYWNlLi4uIEFuZA0KPiBpZiB5b3Ugd2FudCB0byBzaG9vdCB5b3Vyc2Vs
dmVzIGluIHRoZSBmb290IHdpdGggYW55IG9mIHRoaXMsIHNob3VsZCBJDQo+IHJlYWxseSBkaXNh
Z3JlZT8gSSBmZWVsIEkndmUgdm9pY2VkIG15IG9iamVjdGlvbnMgZW5vdWdoLCBhbmQgTHVjYXMg
aGFzDQo+IGFsc28gdHJpZWQgdG8gZmluZCB3YXlzIG9mIG1ha2luZyBhIHVzZXJzcGFjZSBpbXBs
ZW1lbnRhdGlvbiB3b3JrIGZvcg0KPiB5b3UuDQo+IA0KPiBJJ2QgcGVyaGFwcyBhcmd1ZSB0aGF0
IHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgZnVuY3Rpb25zIHNob3VsZCBiZQ0KPiBtb3JlIG9w
aW5pb25hdGVkIGFuZCBhY3R1YWxseSByZWNvbW1lbmQgYWdhaW5zdCB1c2luZyBhIGxhcmdlIHRp
bWVvdXQNCj4gKGxpa2UgeW91IHdhbnQpIGZvciBhbGwgdGhlc2UgcmVhc29ucywgYnV0IG90aGVy
IHRoYW4gdGhhdCwgdGhlIGNvZGUNCj4gbG9va3MgZmluZSB0byBtZS4NCg0KQHRpbWVvdXQ6IHRp
bWUgaW4gamlmZmllcyB0byByZW1vdmUgY29yZWR1bXAuIERFVkNPUkVEVU1QX1RJTUVPVVQgaXMg
dGhlIHZhbHVlIGZvciBkZXZfY29yZWR1bXBtKCkgYW5kIGl0IHNob3VsZCBiZSB1c2VkIHVubGVz
cyBpdCBpcyBhYnNvbHV0ZWx5DQpuZWNlc3NhcnkgYSBsYXJnZXIgdGltZW91dC4NCg0KT3IgZG8g
eW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbj8NCg0KPiANCj4gam9oYW5uZXMNCg0K

