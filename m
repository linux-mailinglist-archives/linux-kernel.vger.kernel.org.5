Return-Path: <linux-kernel+bounces-117723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4188AECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B141FA4308
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6624A28;
	Mon, 25 Mar 2024 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uc5occMq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24983DABE2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391809; cv=fail; b=TUe4VYCh5Nr2yKiQaSX26QBIyBASwidyp7Y/gc6TqC9oT/eXsvzQogZCs1Ysm8ShEQjUfbqfcT49mHIYH2V4JALZ46SyyFaAZ/VxsbEsytXt64V2HJpmoakxPR2X3wi7tp3JI4t0jQEDww0lk4If/2MbFL557TtjCMsQaWh7NFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391809; c=relaxed/simple;
	bh=t5BhucRgln/qf25RR/77tpYQa+YfRxS5v/H3VHiZZLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uUgoVYJwPlWMx+mTDmQLYFgnpAbekUy3w8FO1Kjls0vjQ+tTd/qF/qoW0DR20pBOsFG3A0O2LP577QcUU++AguRmewxRFvadQ2IGwrHLf70dFnV961QEfdDSh6NS47KPWBVFonO5VS9xbpR/uw73NaDCETesQl9IBeKBU4NiSNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uc5occMq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711391806; x=1742927806;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t5BhucRgln/qf25RR/77tpYQa+YfRxS5v/H3VHiZZLs=;
  b=Uc5occMqR6SHblB5YTSRRsB07umUVDV1Zq8ePK9Se7i0znsYUhhM/luV
   uFiGp55ZPgD6WtPeXFxatq3MuNh4iVYUMP0qY69pO9ItHRIKPIIFg4riP
   sOhPc2Kizsd3CU7GLREuf/y/xJRaPCHs57KFYT6lq5V/fkDLgWe+keTUP
   EgvfltkvSEokxEw/vAQNciCcpis9QwstFd6+PFVFHVUrOrvwUlADBvEZa
   J1gigl/7RAq4YhhF5fWSPdddh4nFKnfri6wYJDzk3li+0bvJgc7RmWGb3
   5+GSSu5ilUlZAlwKszaehyd1vX+/IuoXGBWKgU3x+bOjHbc2X2PKv8DCb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="7009060"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="7009060"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="46701079"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 11:36:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 11:36:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 11:36:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 11:36:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmezvEIg3tCE858kRxm0VBNkuqxNGF86HwkKL0OWbk8vU30kf+hzoIhE3N7BKnSVgGePpe7nCEHYqLvf6PIQsjZRx6fCCKM7PijML8Cs+sBC7f3RrYKlcVhfnSkp89X9xmCn5q9rLZKr7TUdpofa5mFUWsRA0iwx7vOAes18WYNKlczPR7H86kxzzlRK19YeMuFPG1e1jmAwMgfKcy4xNpX5M1deEoGAXJE3vecD8XwMpOSS87AZTule92KH+Eh0hPInwUPSB7R3FrUWe0+OVgfmButAC3LaicATqmAGWcSNry+q8Lg3iwmcD+UTAYV3ZMdVTOfzUOEyOfqZwjESWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5BhucRgln/qf25RR/77tpYQa+YfRxS5v/H3VHiZZLs=;
 b=kSy51PjxA0HnrSpw6PgbpEI7mMdV8xo8wm3jd50VJlUwABvmQSnxFim4t5wQP1gGponB2MLumLEdt+PfiLHTxt3g9b6+9+ixqNBmXbvkfi4LK8ctDq7TDQqUPQO9wwFJ5cmnhYJu1ah7UEtapzGwl5lZ21/TacSrtfSIA18742yFyL8fjg6i6rSzTIcNb+Mi7ua+L6FUpdcyNnI0Ylqkg8+2VJ7Kf6ZJFS9l6gxUq1Wa0lAejtuXorky4NjzxfbqAdRus+AXAGeZJV7AiBHDEvSr5ohxy/oezqyv/9KVIdh+UdKRRP7XlBcowlZL0sQBYQdIb5qu6rOdBpt0+LOXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SJ0PR11MB6768.namprd11.prod.outlook.com (2603:10b6:a03:47f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 18:36:41 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 18:36:41 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
Thread-Topic: [PATCH v3 1/4] devcoredump: Add dev_coredump_put()
Thread-Index: AQHabkHCwrYydZ1LA0ergAesrf2yc7FIy+uAgAAeTwA=
Date: Mon, 25 Mar 2024 18:36:41 +0000
Message-ID: <2bab25ec4edd587442a3c14505760d47fa649636.camel@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
	 <4aa1f6ae3ac72a5eb3303740242d53d46a338d6b.camel@sipsolutions.net>
In-Reply-To: <4aa1f6ae3ac72a5eb3303740242d53d46a338d6b.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SJ0PR11MB6768:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jD4MQ13Mho4ttP7KPuFYsmVFPi/qrmLmeagmjhpF4xA/p/aHflR/SA7R8EjwZI+gzOdeNjsHCxKixabtMta1lmF18G2EgarGiFoju4ExM/9ykBw5JaMiTv+sfcjW8ppHZhHCMVNwr8MGGBVzPyzVpccW4CRMAtfpVAa0fiicEStUZoTWfl3TocCYRNb34TQNbELjt3i3FyI+1XkLqIKUuMx1wL/QwyC9ASSMcSXWRP1hLeMR/Lj7t9420BqtffoAxyMbqJ3zZpySIZChLxEu1dSwrNFn6BPWJ/STzvxCP+8aT5HO146zU3c//99P8+1M4zXZ0Ef9hXTFdq0Noxtt44E41MwiZfzlEEzUrciqJMZsBdDmAmnC9ZPzayhkVl6gzAU+mMxdl2r2HoYJ5CDeF+9+DQfquShlXTtlU+ngIxfcDe1sffci2iXVqZQdKbabM0SCfWWCsbF4vq6XOgLhg0vhwzJ5D+P2DlHJipRYVMu6yuRtt421fpMN8Kv7LGbQNVHYZLY90R7vNziFMQhOWFLMxVGxxqae/Eji82IinuBAGELaD6QhGl9maBtBnJp016+96QSieb0Po8QteSq+5zjoWBDYILLHaUJvxvPG4L8vAdgNHd909zNzBJ3ACywU8GnlZQDLdTnXrn2cA8Y9jaGNXMDVkpjDIvEgYjSIRqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmU4Und5bDJZeHE0RXkvNzY3RUpTaG9QV3dQRWMvRTg1R1dFSkp6dTBpNThx?=
 =?utf-8?B?ZGlBMjFpempSZTZ0ekcwZXE1dWJlSHd5UkFXRGZWWUc5TmhtTHZ6ejJuOS83?=
 =?utf-8?B?cFNyOUZNOEx0L1Y0MlcyVmxEZnBKU3lTR2pUeCthWEttOFg5dGVLMWhmVW5Y?=
 =?utf-8?B?SkhlOUJuUWhUL3NUYjVRVmVuTHF4OVRSRVhlbE9EOHNkYnJDNHJ5bkE5SXhV?=
 =?utf-8?B?R2tLb1hmWEw4MlIwVFovV3E0bjVGZ2ppejBHMkROREFnamtrWU5VMnRhRE1w?=
 =?utf-8?B?Z1lZTmUvUEdKRjZEaTcvN3hTL2ZMZmdMM2dWSFRHQVNFa1c0Qk1uM2JFWFBQ?=
 =?utf-8?B?UnEvOXFMazVVcVNtazI2cGkvZE9VcVFWS0swVEtWb1FNVFpCS2JxSkM5cTgw?=
 =?utf-8?B?c0gyeGEyWWtCdk54V25zYkZTSEw3TFhGdzN1eW5pTE1VTjRQa21JeXMrSm00?=
 =?utf-8?B?YUJZd3NJOTBRbjB6TEZHUTNMbEMycjl2aTNMZVNGY29MeThXR3h2eTZQWDZw?=
 =?utf-8?B?bGZPYzN0RjdOVit3NWcxaG8wRjhGY2M0SkFTdzNnU1YzVEJaUWNNcytsZEFM?=
 =?utf-8?B?NnpRbEtnNko2V0ZpUERHeXJHK3VmcXE1eUl6OFlraGllcW94TXpiOXd4dHNG?=
 =?utf-8?B?VkZkL1YyS0RPMjUzZjRZQit6dHlUb1dVQUdkNE1MRGJ2citLV2ppRkdkOVZ2?=
 =?utf-8?B?Y0FTU2E2Y3FVbCtGVEh2NU9PT3pRVmZxa2tsMkR0cG1MQkZVRkhYNCs3Wld5?=
 =?utf-8?B?bDJ1VkpudDVCR1lTb2pTT3RRczc3b1I4Zk1jbUZ6VGdBQ3pIQ05BSmJkK2xz?=
 =?utf-8?B?dHJyU211VDFpNWMrVHpRSGZySmhmQW9SeGhhTGdsR3NRZzJhRXdjaDhka0hw?=
 =?utf-8?B?VVFjVGtzSFUvRm85Y1lHdmxUaFBUN3haUW0zMmZ5UFFrZi84RVUzN1JJN0Ur?=
 =?utf-8?B?Q2dOQU9wdEVwdEJITkhNNnJBdHJBUFZrRUNTSnZpZXZEY3VDNHN4ZnUvVmZU?=
 =?utf-8?B?UFlkd3FsZWNOejJpa1FXa0hKVjh0eWE4Si9GTk42RnpnTnhOZ1IyZE5zMHZt?=
 =?utf-8?B?R1RFVExFUDFSSDVFaWxWYitqRkw2ckdXK3A5QWsrM2RXSzczdTFjSEJjTlBs?=
 =?utf-8?B?VHVqcVBDcU5XTlFrNk1aMFVkSXFxM1NENi8zSzZUbHJIR2RYQzlYQmtsYkJx?=
 =?utf-8?B?b2dYOXI3R0NsVm5DbXFXK2Y4dUVYbmVpOEFyczk2dlQ5NjYwNEViTFdMSFBD?=
 =?utf-8?B?bkwxc012TUpkd3RwNnM3VFV1RWYvZXJSZ05LMUdIRVBIVy9uRzZxYkFEclY0?=
 =?utf-8?B?YnpXMWoyVEhmN3VZSVJOTTg0UGtQRnZZNXY3OEF1S2hDUXRLbFdvNDJwU2Ny?=
 =?utf-8?B?Q2RPV1JheGlzSEZ2aUd5STZsUjdyRFczV2hjTzIxcDVsdkZEZURjU3k2NkZp?=
 =?utf-8?B?bU1KQU1BOVErRkNaV0Z1Q2RuTi9JRUk1Ui8vVUo4bmMwaWoxemc1ai9lbU95?=
 =?utf-8?B?NTFxOFUrTUZZNmdTNUg3TGZsTzNyV0dnODZRbzRhKzdGdStGYnlHYko0Sm5x?=
 =?utf-8?B?WWdZSFVEUFhrT1FvUituc1VadVI3ZTFneVhtNC8xMm1uL0VLdjZhSjhIdkU0?=
 =?utf-8?B?aVFPZUdJaFpmR3o4VXFpemlmMnlMWE13eWxtVGlsTnZpM3FtMnlKOUtCN2Fi?=
 =?utf-8?B?NC9HSFNnR2s4c1pITWQ2NExYam5Ib0JoY2pDY1R3bTl0M3RGbXBjL3pzOVZ4?=
 =?utf-8?B?cnFMUjR5b3QyVUhjc2hNekprbXRSdFVZcVkxeDJlU1hYTTZZRG4vMEZqMVpH?=
 =?utf-8?B?QXNIN3hTY2RTQUVHWFQxWEJRQWsvYys0K2lKdkhsQnV0a1R6T3Y0cVcxL3kr?=
 =?utf-8?B?TDcxYlI1Qko5cVQ4ekZEcFlkc0pKKzlOZFhaNkNsb28zVkRYdlllUmVhSTdK?=
 =?utf-8?B?QktDTDl0bVdFSDlvQW1WWWZoTlQvTEhZSVR6ZDhkTGJWUzkxaGtiR28yOGVM?=
 =?utf-8?B?S05qY0Z5QU9lT3dzU0NrTzBzbm15akUwLzR3RmI1dVJwQ1ZyYWU0UFdMdHAr?=
 =?utf-8?B?eGZHcHZlVEVMcy9aU2t4TFVuc3pGVWg5dXRFTkNoZFZWVWJVeXZqQ0xpMzR0?=
 =?utf-8?B?OS9xV2lPc0JnYmVmbDVyM0IwdFpYSWFoRGdpMTNMMGw5VXB1ZjNqUjlTSkNE?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0CC3E3E733D964784135974B08B453A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec47cd-b676-498c-0f71-08dc4cfa839c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 18:36:41.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ByW/P7/yrbIV5KTu4sThw41xFk7MsdvfOGlZiYQgVsq7GGd/q2x/IeY2KKIz5X7LTCl+UPjfJzoxnrpYwEwnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6768
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDE3OjQ4ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBNb24sIDIwMjQtMDMtMDQgYXQgMDY6MzkgLTA4MDAsIEpvc8OpIFJvYmVydG8gZGUgU291
emEgd3JvdGU6DQo+ID4gSXQgaXMgdXNlZnVsIGZvciBtb2R1bGVzIHRoYXQgZG8gbm90IHdhbnQg
dG8ga2VlcCBjb3JlZHVtcCBhdmFpbGFibGUNCj4gPiBhZnRlciBpdHMgdW5sb2FkLg0KPiANCj4g
V2h5IG5vdCB0aG91Z2g/IE1heWJlIGlmIHRoaXMgaXMgYSBjb21tb24gY2FzZSB3ZSBzaG91bGQg
aGF2ZSBkZXZtXy4uLg0KPiBjb3JlZHVtcCBmdW5jdGlvbnM/IER1bm5vLg0KPiANCj4gQW55d2F5
LCBJJ20gZmluZSB3aXRoIHRoaXMsIGV2ZW4gdGhvdWdoIEknZCBsaWtlIHRvIHNlZSBhIGJpdCBt
b3JlDQo+IGRpc2N1c3Npb24gdGhhbiAiZG8gbm90IHdhbnQiLiBDb2RlIGxvb2tzIGdvb2QuDQo+
IA0KPiBSZXZpZXdlZC1ieTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5l
dD4NCg0KVGhhbmsgeW91LCBjYW4geW91IHBsZWFzZSBhZGQgdGhpcyBwYXRjaCB0byB5b3VyIG5l
eHQgcHVsbCByZXF1ZXN0PyBPciBzaG91bGQgdXMgYWRkIGl0IHRvIHRoZSBuZXh0IGRybS9pbnRl
bC1kcm0gcHVsbCByZXF1ZXN0Pw0KDQpBZ2FpbiB0aGFuayB5b3UsIGp1c3QgdGhpcyBwYXRjaCB3
aWxsIGFscmVhZHkgdW5ibG9jayBzb21lIHdvcmsgZm9yIHVzLg0KDQo+IA0KPiBqb2hhbm5lcw0K
DQo=

