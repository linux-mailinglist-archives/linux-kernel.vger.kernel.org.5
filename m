Return-Path: <linux-kernel+bounces-90733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8B870421
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B471C2324D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830145975;
	Mon,  4 Mar 2024 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZFk2t3F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0C4086B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562550; cv=fail; b=qNplEG+oGgltalG3mwDCnMEjr37hOrRSRKG3HIDDziKyh6ZDMwxFF4erkm6sPbauFxQ+aQbax2Usf0EIU0ckMidKeE+YPwDaIdptNn41TQyCYx4B7/uUJTq6GrqywxnBidtMMH9pOABU16BIBchry7TkAFIDhJAUluC8oljUSn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562550; c=relaxed/simple;
	bh=LSEtynGbo072M+Qny2sxWED6XzOjtqYMHUOxSo+1u9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqNOn5qQl5aaQU8tp5vhAzzlJL51cvOkeMxVCoCGR7gx3XzvIU46Cg42PTKdocYPgMcitjZyygI/CsAnQJ8D2uNcsjfPqfSzLAcx899z7TJoB31YgEt/8TEI6dNLl6V9FwMTIohB+YsM6CN/cDGcVTbEI+ovLMEhY4iqwIwQITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZFk2t3F; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709562548; x=1741098548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LSEtynGbo072M+Qny2sxWED6XzOjtqYMHUOxSo+1u9A=;
  b=BZFk2t3FeE6DIAuuPTzZVOnS+lYvqXCJ4XEHxSUS5MFgGSeut9ps2lEp
   mnWejXzFLF2QlGjZ8yc2MripfPA0QxW+QzJIC5uihYIr5X3aZHhDBLz/a
   wwOSWtpcT8teiy9f8w4sjv9OWc0fHfbj6DuRrlnZdadv4XrUCjG5Rp8Hc
   43wQafzd8jtx53ZerXam+XnRXqldNfxWvnhH+7zD5n+eLhSj4hUkZIGec
   /pZQmM8OOrUbZiEJGo4Y13kjLwGcJ0yAPrv5WO4eBYhFyYK7ocyW0ZuAn
   B155ECYD0NT4nJUM09RSIAXyd3HBWFIbQihQlq60N1CszcUBQEZmcNQJT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="15462970"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="15462970"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13697227"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 06:29:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 06:29:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 06:29:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 06:29:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqdQdgV6erRBtyjSK2OMZsv6E5fclkUMmC5IEz36lZnFnzk+/dHI1m6jsiZA0aXeWqvxaMb+uiBw2nL4EwXaSYKNrZQPEBnIwsMcPOfwqF9B0Wg6V6K7rX7V5ex486/3lh+KFV3xnGsVYOIJ4SI91+4nMpDamS0JwMtyZ2/VOHGG4IkoMtbbo46cMzms5iBWHwnkj3859+DAo/OZW/47xgwgAWA3G0JOz4sJlJZ5sZuM2LDiXV1UuRo6i7DH4f5lM3On0jJnOgaqEVn85ZqVurJiPUlIBSalWrablXV7c5cuHey0n22RCEmz7vgG+4nvvkbea2UIvPQZNvnIgVdkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSEtynGbo072M+Qny2sxWED6XzOjtqYMHUOxSo+1u9A=;
 b=HZAFn2VNFo28t+KqiUM9MBFiNDoUXLbRGstZOaggjVCTY+q5EvOhHnTAJT5yjXHUJjksST4RwhUzi27NbSXAwwrznvvpQA5gJ3vxeiA5kr0rreo7PRElgY7hSgjzl34wRCkwXStR1c5EM91r1TO2oU004mdbgSAMDogtVHSwJsRWFT0diopt40MS4tkLCsF6xjOjFvZabfz3wvM6EFZsfSjuXQJtp9O9Avp2S7M0h0fj7BnawZXLv+9Jko9Jlt+kpwpwr1lq8CtRHXNn6EiHCnA+qHdET4j0dtLe+bm66Vo18zZKmxfFHSt/8n9rXJVpfk1RX6s0wD6QGo1dv1GuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by SA0PR11MB4702.namprd11.prod.outlook.com (2603:10b6:806:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 14:29:03 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 14:29:03 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "quic_mojha@quicinc.com"
	<quic_mojha@quicinc.com>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Topic: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
Thread-Index: AQHaamc6S3UimQVv90Kct5lCKqBGwbEf+/WAgAAOAYCAAojygIAFGOOA
Date: Mon, 4 Mar 2024 14:29:03 +0000
Message-ID: <bdaf62020388d3dcf8d3a95ae465c0ae2db7eca1.camel@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
	 <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
	 <a27ac0d3bc52c2181852a25641b7020f50a50648.camel@intel.com>
	 <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
In-Reply-To: <0f4244ea6866f451f3f8a5b5e2db8be53de1f0c2.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|SA0PR11MB4702:EE_
x-ms-office365-filtering-correlation-id: 560012f8-b2a7-417e-31fc-08dc3c57711e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: obsVnKnyDtk5i7OJ/MJtz68ZwxCMSSzJNoOcE0442FiYOUfeW/AIo4+po+N2LdIni9VmKwEPy/iCsgCN8FQXIHF/gAiJxi1Av8zGKdDnGjJfGauGq7ui2BgGbIYrl93SXYuigb/6pecN1waV1O+XUDmhcHIeXdY8UlI79++ffi73kvspHFQ/K1Cb2EyKlVK1Vs6sx3VUYLzKrRghYt2g8DaIZ6JPQalZu8cFSvQGONBt4I0r81Ba7oIBaVQ5txV3zAcBhMt51XOaMYAkJB3C/7nsB3bixk3+saFaHJFA9j4tH/tnh4P5lrQHLUB0QVgJkISnSTwVl13Pua4x3crRdKoxvFI/uKK8faF4PRvdW88NQbGa4UtdGCosygzlD+5wsPFEvpRI6M/9sHEaa4ZoWfMNvu86uhnPqPc8xbaxq/1ESBa4iV5BnNwiSCtql2MpctxaOMJho0UV/DXh14thYTo1RbvUAd2j71WNEYA2iuzt30Ink6tGS0c2Y/DzIQKNclLaHeo7Kepl2KwOFt0HujxVzJfcTISqWZLkU5ntaYM5uGwNezl/C9lBu1o4NCru5F/YQBjbDJqlvLsKC1vsyP9gi3wZgv7Sk2WWD5cJ/R1YJueYWxClL+YhTvqt27VtxLyW8bIGQ9+mS9kmJ9IMSyTSCmBC+dS8TQoD6WiGrSw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDRaZlVNT1VNSzZUVVpxbFQ5SGNBaklWNUIwNlFDcWhVNEFTeVFuQVU2cFZi?=
 =?utf-8?B?OVJ6aUJGd0ZFalUzbHN3Zmp5OHRScnVVR0xiallxc1dIdUhneVlBdWVkYW0z?=
 =?utf-8?B?UGpaaGozZ3dlWTY3MXhib1p3Mm5mVVZSZUZtdDhVWkM4Q2JSRXNnOUVQVlRV?=
 =?utf-8?B?TmtYVzF3L3BkVzZOOVFqaFR3LzIrTTRQRWQ2Und0NWl3L3hXRzEra2pEM28x?=
 =?utf-8?B?MEhCdm1YeHJUVVlwQTB3R1dSeG5BYWY2UnFYbTdoTStlTGtKS2lLV255TjNQ?=
 =?utf-8?B?QWZCYXRHNUo5MzVmMTlOb3UyamtXUHhSd2lQZy9oRkNXTExhM3hsSy83cUpW?=
 =?utf-8?B?YnBYWUU4cVF1RHF4eUdBOWJyY3dPb0xGZDhKeFhmYWRWM3JlNkMzVWg0aGdl?=
 =?utf-8?B?djgyTzhLL0thYWljZFQrL294Vml0UHBBcnp2ZEpYODI2MmdvUzRJeEp6UXhm?=
 =?utf-8?B?dDhyd2NVWWY4RE1oR29ibk5RYmR5bitpb3cyZ0lmQVUrL29nRHBpVmtxOVFm?=
 =?utf-8?B?WXdneCs2YnV1YmV0cWpHeE5SUURhSDgwMEFoMlVDQ1piVmRZOVcySjBvaG8w?=
 =?utf-8?B?d1g5K3FoUnNNZGgybWdyUEhzMVkvR3RSOGdLL3dwRkJPWUJvQ0l1emQ5UllK?=
 =?utf-8?B?RERHTm5IQy9lQ0ZrbkNUQm82MTZrTERqMmZvemVwQlBRWk0zOHI4SVZ1ZTRu?=
 =?utf-8?B?WUJ1ZmF5QVVUQjdYWXBNUjAzci9UK01RY1dhQVBobE1XT3RLd2xwUHR0Y3Ix?=
 =?utf-8?B?T0NxWVBveENBcHovaFBwMXp3U0lUQUVKRjREeWVTWitHQXJCV1ZnSXJxL2xG?=
 =?utf-8?B?MmdsT0FVOUVTWHhnRGM5RHJkNGZFZjU1Q3pzNXVXSDdDcVVJZGxmS3lWcSsx?=
 =?utf-8?B?Ky82Z2lBMTdIVmx2MUpWWUdXZTJyQm5MVU1lRWpJa1VIaWMxdlZWSmtnV0hF?=
 =?utf-8?B?NHNhQUtWdkloOU9kRUNSbERvT2VnSVkxNVF4My9rQ0gvVkphQUVReHh0OElD?=
 =?utf-8?B?VWU5cVdkbWl3ZW82TVBjWHIzLzdNajB2UzU0aVB2TFUwV0sxR3lyWEY4ZnY5?=
 =?utf-8?B?YTdrSjdxdWd3RlVmMExOTU1sQWVJazZxWXNHbmw2T0VGeDMrcWR5V3daS2RY?=
 =?utf-8?B?M1ZCSEZoSUg4MjlxT3hpQzVpNXJ4V1RoazNuWkRscEM5STMzemRsTkNaS29B?=
 =?utf-8?B?TWFqTTFSbi82YWZDL3BzY3N4Wlk5STZhVUhtakZ6c1Z3QzZCQ2RSbWhxVXRY?=
 =?utf-8?B?NXJ4dm9VYmQrdEtTR1JYMlI3cElBUjQwd2p2cHEzbWdOQW5nVktSYko3QStH?=
 =?utf-8?B?alo2MHRXUWNQTjQ1SjVEcUFEZWtoL2l1dS9KRC9oRk1SdlduUzFrMEpDNU9U?=
 =?utf-8?B?WnVXdGtWNWp4Yy9UaWJWVUNuRzBPbDFzTXB6WndBemJUaUNKNGJFQWRkUHl2?=
 =?utf-8?B?UG1BYzFIb3U3dllJY2N1RzdmeTN2Y01vOGllbTFvRmtTaW9zbVBnZkx3b2JP?=
 =?utf-8?B?MEkySEpjL052Smx6eldjUXVWNXlUSm55YkI4YVZGVzFVbWkwc0F6RzBNUEEr?=
 =?utf-8?B?M2VPYlhJeUcyNzVLaUxvK0tXUVZIaXVNTXkwM3FMMWxZdDVtc1l0eGZSZS9R?=
 =?utf-8?B?a3YvNVg2YVpiUkhIZnpZWU11NmdDSklhRXgrNGwzbVZiYllYUlJ1dE1MSnV0?=
 =?utf-8?B?TVA0ZGVvSUtUeTJkaTVLZ0pzc21IV1NVT3NIZlR5K0ZjWFFRVTBXQTFpSzFK?=
 =?utf-8?B?YTYvWHNxbEhwbks2N3k3clYzY1VhWE9heVRiM2NTL0QxNGJUTTRUU1cxaVpy?=
 =?utf-8?B?TWRvcUhuWENXRTIxQnZMandTNVlDZzkrVDZEc0xubUNzSkdUZ09uTm5ZSXZx?=
 =?utf-8?B?Q2FXTENaV3hDYmJHVmxYWGxnR1g5ZndBa0tKM0hOWHkyWUY2Z2h6VlJSbXkr?=
 =?utf-8?B?Nml0dkRqLzB5MU92R3MwV1lseFRpVjRtaU1TSnJWV0ZudWd3S3IvUmRqbWNH?=
 =?utf-8?B?ejlkODRTbEQzV1VSRnlOdnp4TGtUcTBQZUFZZk9DVnByMVRVU0xnS1B0djA5?=
 =?utf-8?B?UTBNcWViZGo2SWdZK0N3UDFkb2U2MzdaL3NEL1QvTEozellvMDd5eFJIcWVJ?=
 =?utf-8?B?cmVJeHo5MHFGbFlFYlhNMTVVM3NMNUo4TEZITWh1QnkwRzBWS04yNWJieDVV?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3267868FE7C03542BA1C61022EBBDB52@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560012f8-b2a7-417e-31fc-08dc3c57711e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 14:29:03.6861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaiJkPnp8ux3mmO/noydM+lKKD7NIs92qu0g2VGXOerS4enFX2aV3lWiKl/RaVqucxnzPMUOZs2+Ixt0W7d9qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4702
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDA5OjM4ICswMTAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiA+IE9uIFdlZCwgMjAyNC0wMi0yOCBhdCAxNzo1NiArMDAwMCwgU291emEsIEpvc2Ugd3JvdGU6
DQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBteSBvcGluaW9uLCB0aGUgdGltZW91dCBzaG91bGQgZGVw
ZW5kIG9uIHRoZSB0eXBlIG9mIGRldmljZSBkcml2ZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiB0
aGUgY2FzZSBvZiBzZXJ2ZXItY2xhc3MgRXRoZXJuZXQgY2FyZHMsIHdoZXJlIGNvcnBvcmF0ZSB1
c2VycyBhdXRvbWF0ZSBtb3N0IHRhc2tzLCBmaXZlIG1pbnV0ZXMgbWlnaHQgZXZlbiBiZSBjb25z
aWRlcmVkIGV4Y2Vzc2l2ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEZvciBvdXIgY2FzZSwgR1BVcywg
dXNlcnMgbWlnaHQgZXhwZXJpZW5jZSBtaW5vciBnbGl0Y2hlcyBhbmQgb25seSBzZWFyY2ggZm9y
IHdoYXQgaGFwcGVuZWQgYWZ0ZXIgZmluaXNoaW5nIHRoZWlyIGN1cnJlbnQgdGFzayAod3JpdGlu
ZyBhbiBlbWFpbCwNCj4gPiA+ID4gZW5kaW5nIGEgZ2FtaW5nIG1hdGNoLCB3YXRjaGluZyBhIFlv
dVR1YmUgdmlkZW8sIGV0Yy4pLg0KPiA+ID4gPiBJZiB0aGV5IGxhbmQgb24gaHR0cHM6Ly9kcm0u
cGFnZXMuZnJlZWRlc2t0b3Aub3JnL2ludGVsLWRvY3MvaG93LXRvLWZpbGUtaTkxNS1idWdzLmh0
bWwgb3IgdGhlIGZ1dHVyZSBYZSB2ZXJzaW9uIG9mIHRoYXQgcGFnZSwgZm9sbG93aW5nIHRoZQ0K
PiA+ID4gPiBpbnN0cnVjdGlvbnMgYWxvbmUgbWF5IHRha2UgaW5leHBlcmllbmNlZCBMaW51eCB1
c2VycyBtb3JlIHRoYW4gZml2ZSBtaW51dGVzLg0KPiA+IA0KPiA+IFRoYXQncyBhbGwgbm90IHdy
b25nLCBidXQgSSBkb24ndCBzZWUgd2h5IHlvdSB3b3VsZG4ndCBhdXRvbWF0ZSB0aGlzDQo+ID4g
ZXZlbiBvbiBlbmQgdXNlciBtYWNoaW5lcz8gSSBmZWVsIHlvdSdyZSBib3hpbmcgdGhlIHByb2Js
ZW0gaW4gYnkNCj4gPiB3YW50aW5nIHRvIHNvbHZlIGl0IGVudGlyZWx5IGluIHRoZSBrZXJuZWw/
DQoNClRoZSBvdGhlciBwYXJ0IG9mIHRoZSBzdGFjayB0aGF0IHdlIHByb3ZpZGUgYXJlIHRoZSBs
aWJyYXJpZXMgaW1wbGVtZW50aW5nIFZ1bGthbiBhbmQgT3BlbkdMIEFQSXMsIEkgZG9uJ3QgdGhp
bmsgd2UgY291bGQgc2hpcCBzY3JpcHRzIHRoYXQgbmVlZHMNCmVsZXZhdGVkIHByaXZpbGVnZXMg
dG8gcmVhZCBhbmQgc3RvcmUgY29yZWR1bXAuDQoNCj4gPiANCj4gPiA+ID4gSSBoYXZlIHNldCB0
aGUgdGltZW91dCB0byBvbmUgaG91ciBpbiB0aGUgWGUgZHJpdmVyLCBidXQgdGhpcyBjb3VsZCBp
bmNyZWFzZSBpZiB3ZSBzdGFydCByZWNlaXZpbmcgdXNlciBjb21wbGFpbnRzLg0KPiA+IA0KPiA+
IEF0IGFuIGhvdXIgbm93LCBwZW9wbGUgd2lsbCBwcm9iYWJseSBzdGFydCBhcmd1aW5nIHRoYXQg
ImluZGVmaW5pdGVseSINCj4gPiBpcyBhYm91dCByaWdodD8gQnV0IGF0IHRoYXQgcG9pbnQgeW91
J3JlIHByb2JhYmx5IGJhY2sgdG8gcGVyc2lzdGluZw0KPiA+IHRoZW0gb24gZGlzayBhbnl3YXk/
IE9yIG1heWJlIGdsaXRjaGVzIGhhcHBlbiBkdXJpbmcgbG9nb3V0L3NodXRkb3duIC4uLg0KDQpp
OTE1IGRyaXZlciBkb24ndCB1c2UgY29yZWR1bXAgYW5kIGl0IHBlcnNpc3QgdGhlIGVycm9yIGR1
bXAgaW4gbWVtb3J5IHVudGlsIHVzZXIgZnJlZXMgaXQgb3IgcmVib290IGl0IGFuZCB3ZSBnb3Qg
bm8gY29tcGxhaW5zLg0KDQo+ID4gDQo+ID4gQW55d2F5LCBJIGRvbid0IHdhbnQgdG8gYmxvY2sg
dGhpcyBiZWNhdXNlIEkganVzdCBkb24ndCBjYXJlIGVub3VnaA0KPiA+IGFib3V0IGhvdyB5b3Ug
ZG8gdGhpbmdzLCBidXQgSSB0aGluayB0aGUga2VybmVsIGlzIHRoZSB3cm9uZyBwbGFjZSB0bw0K
PiA+IHNvbHZlIHRoaXMgcHJvYmxlbS4uLiBUaGUgaW50ZW50IGhlcmUgd2FzIHRvIGdpdmUgc29t
ZSB1c2Vyc3BhY2UgdGltZSB0bw0KPiA+IGdyYWIgaXQgKGFuZCB5ZXMgZm9yIHRoYXQgNSBtaW51
dGVzIGlzIGFscmVhZHkgd2F5IHRvbyBsb25nKSwgbm90IHRoZQ0KPiA+IHVzZXJzLiBUaGF0J3Mg
YWxzbyBwYXJ0IG9mIHRoZSByZWFzb24gd2Ugb25seSBob2xkIG9uIHRvIGEgc2luZ2xlDQo+ID4g
aW5zdGFuY2UsIHNpbmNlIEkgZGlkbid0IHdhbnQgaXQgdG8ga2VlcCBjb25zdW1pbmcgbW9yZSBh
bmQgbW9yZSBtZW1vcnkNCj4gPiBmb3IgaXQgaWYgaGFwcGVucyByZXBlYXRlZGx5Lg0KPiA+IA0K
DQpva2F5IHNvIHdpbGwgbW92ZSBmb3J3YXJkIHdpdGggb3RoZXIgdmVyc2lvbiBhcHBseWluZyB5
b3VyIHN1Z2dlc3Rpb24gdG8gbWFrZSBkZXZfY29yZWR1bXBtKCkgc3RhdGljIGlubGluZSBhbmQg
bW92ZSB0byB0aGUgaGVhZGVyLg0KDQp0aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjaw0KDQo+ID4g
am9oYW5uZXMNCg0K

