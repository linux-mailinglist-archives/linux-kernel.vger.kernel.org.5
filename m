Return-Path: <linux-kernel+bounces-50937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D2848406
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 06:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E121C231B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF46111B0;
	Sat,  3 Feb 2024 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3MmF21l"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A701119F;
	Sat,  3 Feb 2024 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706938818; cv=fail; b=W5t6nm4h4XCd5gejTIzYU0yZpzi2kHv2OYMWk2Rhzg8DtmJYe43M4/wIuaavSrUTFpZpek03Z0bG/Gkd+6k3qWyxgGQz6Xu38X/sXPit7Ie/mj20nGpWWaTU7Opd0mSuSmswp1m33ERnYERAlVkSPii1HWxKA9PU4QIoFMcYRek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706938818; c=relaxed/simple;
	bh=wTOlIz/TuUXbBcjK3JR8R+2dxCdNvA4eWYoIpUedgNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKFYn487rFEQ7PW1hn/R1W6ug8z0wwPI2JCkT61MCF7DB0PNT67qTrdXSbvGH4e8E42IuS7fkt5bSy62LK4HRJ0RXKRBLCxxJTYuQjPDzS3kAVlrmlG7OduV9NgWQIV0sS65QgCNFsUQdBRqHcZa9z4osLE3zSjayH8HkKE8N+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3MmF21l; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706938816; x=1738474816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wTOlIz/TuUXbBcjK3JR8R+2dxCdNvA4eWYoIpUedgNo=;
  b=B3MmF21llTgqp+duZZK4VdzK0Y8X6vQVBUsZ0LZgACUfe319oiGR7eIv
   F59yrWBpX7FWiOn0dcHwopytYNThBJ1xis+iMqYOPTedXF8sWAlahkvfN
   3pWfhm9gw0ftrsFRI/zLLP4n+McYxGZxGX208Z7ccDABuU1Mgk7ez2W8Z
   h4XYIzUlKGLW9g+sMdbmBxqukYoAFJlOZQgD2pEtO3zzBy9R83yI6YN48
   fmPBL50ZFV5f8USdV5vcwiFFMwnx/aluIKKrPK9cfxzp1gj9a1/POUTDN
   jCCOOIObxAljlS7u6LVSU5BScqMwImJ1El6xqwe0tJ5DtknGEzdxBOccg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435432520"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="435432520"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 21:40:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="268036"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 21:40:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 21:40:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 21:40:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 21:40:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mF9fg5QHJmI+gAvth11vG9ApCFCtRd9t3JAqTmaHpNk5dK1WEGshylzb7/FeyBucQvXvLOKvJpjJB9bjoZExPbALEJS/q/4BeOpPp9Ql7CnUz8v8vmL/wAdj6f3G9TUNVqUJI2lPyJd+Mt+Ol80I/9rSUpZjaDmsWYv6IfdfMEI60fax1MLNbzdit5jUSeZH9/r5epqObeeSzwEo43IFrdabu+OBVdNd0VwHjMiyUI4fupigbVfK7jXxTPqhgvY7OM39OgV1cMFg8OR4iYEWpZKJuiQKibSI0mxoJeQP6j9MQUEt0rRQjQ1k0JDBBwUmjdMg5emFImk0mvnMkVBGTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTOlIz/TuUXbBcjK3JR8R+2dxCdNvA4eWYoIpUedgNo=;
 b=IQfjYxrepqdPe0rbz9CFmQWySNDCve5NryKMoDaRDT3Ff3O7xsh4JqQPqpK1nnthqqssEqyuRqu+MswCrvtzJscvI/fIuw7VitAUvqSRzIOISA9AXCrxegTTgfedO/xpY7+uXZ0ycunjd/QtsPRIc/EhAOFBw6buR6tSmNMpluLMOXbdZjmpSGfoaZv7jZvJc7i4FEjmcxLARsFZcA5Xc+BqgNyw/g4VmAwEw9PpPFogsGi/C5zl8ZVELl9a/Exh2kr5ShmTmJXq8yhQs8op6RVF0fwKiCNRe1G75ReCx2SuyOI/XUGSx4/ju4TOWA1DLfmMNhrckUrb56BonfeDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 05:40:10 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7228.029; Sat, 3 Feb 2024
 05:40:10 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "linux@roeck-us.net" <linux@roeck-us.net>, "jdelvare@suse.com"
	<jdelvare@suse.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 00/11] hwmon: (coretemp) Fixes, improvements and
 support for large core count
Thread-Topic: [PATCH V2 00/11] hwmon: (coretemp) Fixes, improvements and
 support for large core count
Thread-Index: AQHaVblqn8Y3rNp/X0CWFUQjSDoPs7D3XDkAgAC/OAA=
Date: Sat, 3 Feb 2024 05:40:10 +0000
Message-ID: <d7fd52e1a57c9861f2b70ce4ece9e6e466a6bbc9.camel@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
	 <d52049ee-81f3-4338-af7a-85aadc028c31@roeck-us.net>
In-Reply-To: <d52049ee-81f3-4338-af7a-85aadc028c31@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CYYPR11MB8432:EE_
x-ms-office365-filtering-correlation-id: f1b7c4d0-7038-484a-383d-08dc247a963c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hz0rSiq2Hjt6EvN4uk7Bi9Nt8jVorWMmV3iab4glDrA7ukwXGd/aqvpIxFec+NGnW+/0DuZp+tdyX+G8600pYq8uO5mCerr5w3Oh5caq7nrV6Bw1+OsHhi90+JsraN7ug9OyUsYQsIuOJ2qH1tvVlqscsf1lZD3qlVYJJmQa6xV3mUOl7Bpg7Ll4jRFxxdgLW8z0BAIw0L+7xxzce6W8YmBWFZ0tqfrVtxcs21KAYkTZ9qvZ4UlOpoL4/JKow3Zl5A5IdwTj1CAc3DXLIhNOA7OAps7eD79kxHcoOzFY5PKDOeCwdP/kNeJQHqxEURC4ZyUFDWjMxQpyBh25A+Jaqkpk6Zp41j8go2grlqsyfQPbZUGd00nsGU8KgyU/pfHfX2M+2NkzSZHqlXyLH7uzVwCHYIVTCNUEtkuJa1JEbfucc0rsv8rFz1SxMSlfSX6vWl6pfBUWtu2kmZJRuthNG8q1vqWfR/GhllYlI2jaKtbffFBQ1cBxRThA10wywZMiAqOkE3DDwLkMoAPjEH8qLp5MwNjmzQDTIgVCOTewl7gx76+7msbwTg3iHEUdWiw43NawB6+1GxUdXKK6VMfdnRxwm2yY7u1UNTQqyFyolJ62VNiFz0pdahzwdVkHmAmCd3GIBVgttEt754WZbviICg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(478600001)(53546011)(6486002)(86362001)(4326008)(966005)(71200400001)(64756008)(8676002)(66476007)(36756003)(54906003)(91956017)(6506007)(76116006)(66446008)(110136005)(316002)(66946007)(82960400001)(122000001)(38100700002)(26005)(2616005)(41300700001)(66556008)(8936002)(83380400001)(6512007)(38070700009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVUvMUFFNnhVN1NqR2NORTNEVVdPVm1qNHZIWmNDT0R5dEdkei9zejRIRFVV?=
 =?utf-8?B?Nkp4Sm9oT2liVGpMQ0R3RXdydXlnWmtKK0F4YTVxQ3E2T3EyM0RoVDdKNnBL?=
 =?utf-8?B?Q1I4dTFrbHNiZDdNRkswWmhqRnlJQmtVWXNWeGkwc1dvcU9ydXlneGN4QUp0?=
 =?utf-8?B?ekNKVGtrekRld3dOeGt6SVlTWS9zYVFmUDd4KzZYazh5SGNKTnh2TVVGR0x5?=
 =?utf-8?B?RFRlWEpzTW9GV0tNdzZrV2FUdS9oclhUVjh4TmNXQjQxUUh2SERnWXczSUNQ?=
 =?utf-8?B?ZWEwR3JUQ0IwUzVDZzZ6K2FTQ09NL0J1bE94NWh4ekt1c2dFRWFhVXFFbkNr?=
 =?utf-8?B?aXFKOHhEMU9JeFlmSHBCY2IvM1ZhcHFVaFhYa1VlOTdFU0FPMGhhU0RvZW1k?=
 =?utf-8?B?R3hjS09kRUZHMjNoOFQwc2grUThzUnRaYkF1am83NjlzQlhZeUpRRUdkdzg3?=
 =?utf-8?B?LzFWd2x6Q3pUU215N2tsQ2FvUzQzdEhLMFJ5OFdqUDR5b1k3TEd5SmM2L3Ru?=
 =?utf-8?B?QXVjeUt3ZzdBUW9ka3EvOVpjajFpWFdSNVdnM3h6dVdPeU1BRklqSzJ3YnNX?=
 =?utf-8?B?RWxreUJNRFU0OUtqUDNvY3NLSklVNFB2ejBaRis2UDcwSjlVMzJDTjRFR05V?=
 =?utf-8?B?T0ljeERTWUxiYTg0d21HQ1ZEOWNJcWlEcWRibEd6YWt5TkQ0TUozWHBnVHRY?=
 =?utf-8?B?cEtFSkRIeTM2VHNXYk1ZUFpxVlp5MXFvOWMwaG1wbXp0eVgrMUh6K3Z6ZW1m?=
 =?utf-8?B?b3kzaTM2cjA4YzF4dWJlWDZ4eGZEY1hqZm8ycWxNS2FreTR1ZjZYTDBxMGZy?=
 =?utf-8?B?OTFrOXJYVzByZjlpMjdaWDcrNzR2cVFpMWt0UnZZS2VCc0loWC9MUVROTWd4?=
 =?utf-8?B?NVFxMEpVNVRSbVM1UkI4TE9BUklOdHZWam9XbTFCWXRkbWNkWld4RmZKOGl4?=
 =?utf-8?B?VGZkRW5JeXp5NCtXbm5TU29zQWdJaVF4VDgxdk5uemhVakx3VmxFdWhWNnl4?=
 =?utf-8?B?Z0xGZHNicjdKQmFFZHdZMHRkVDkrZ0doaUVRL1NoWk90am9CTFJJa3VPU1A4?=
 =?utf-8?B?eGhoak1jOFVkRG5FZUFkU2dKUEVrbmpVNmZZZnR0eDMxSlVEc2thYVJOWVJS?=
 =?utf-8?B?aC84SjV0UGk1WWpJUXZUNWNsMWRNY29KRXlTWlNpV2E4Tk5uR0NsQVY0aVll?=
 =?utf-8?B?M0IrUUVJUlZvZnpWOGxGd3Z3NUtyUmFyM2VManZxblBob1l3MzJ3c3ArQlUz?=
 =?utf-8?B?KzJ6RXppZUgxY0hTOStOeitKZ2VMY3ArUlhjanVhSDJXcGViTEtvblJwc0FR?=
 =?utf-8?B?WktLY1IvWCthczVBcHVsYXFiWThPa0VmbGlWMmV2Y0ZlNWw4U0lLdXp1azZt?=
 =?utf-8?B?d0dGVlowRWI3UnJLd1IvYzNKa1pHUWxNK094V0dUdit6WGlNZ2lndW5hS0x2?=
 =?utf-8?B?a2R6YktlYXAyM082d2lRM2pDcHd3aU5NckJvTUlQY3NaQkNDeFcxTUlrcGky?=
 =?utf-8?B?dCtkRWJDQ0tZQ3V6WjV3cGVzQ1gyTVNrQlVMSllDUVY0SW56L2R6Y1dCZGVX?=
 =?utf-8?B?RllSeVN2YlVvNjlyZzZXVUdzK09vNjQyUnprVlBtQUw2cW5XWUZVLzhtclJa?=
 =?utf-8?B?K2ZWNnJHcDNpa0ZROUxPdTE3VVcwZUZwTFBqNmlWNlJkbjBXQklsQmxqZlIy?=
 =?utf-8?B?Q1BmUnQ1SUx2c3lwMmlIVEUvNExpTmZlSnhnRGVPR3d0QTlUeGcvd3h1WkZH?=
 =?utf-8?B?WWJjbmhnTHFPdlprN2xVSUlNOUF6bXNrN3lTK3M1S2p0NXBpSEFhaVUwWFJZ?=
 =?utf-8?B?QVlOOHJKNlkyaVp1ZWRucHI2WDljak9Kb203VmVRYjIvQUJDdFRMbEZsYWZR?=
 =?utf-8?B?am5hT2JuY3pGTE9tUmRyQmZ6QVpxN3krM2hVTzZGcE9XMkdCT2NTWlR1MDFG?=
 =?utf-8?B?OGJzRURTL09WZkdzSU13QTZyb05sMzV6ZWZKTHgxZkc1N0hMcjVQN21SZHVt?=
 =?utf-8?B?QVNVM21EYWJaQlJDUXBpdENyVGxVMDZvMVVNWFFyWEVERE1RQVZHbk1VcFlE?=
 =?utf-8?B?WlhyYjlOeGRIZk9CR3BEMVdtMUZ5OFNjblduMnJNQ0wwT1haOXlpM0Ura0o5?=
 =?utf-8?Q?HwL8SfL2wHQTE77gZTZSoGcOU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94B0215372964C47AAD10DBB3F4533B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b7c4d0-7038-484a-383d-08dc247a963c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 05:40:10.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9y1aM7TKSmhzUnbEdGk5gFeweP67jcRNfjaToHuqvoYQInhbH+n2730JHEHJR6ZxsDT5le2mF8q2s72TgjeeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTAyIGF0IDEwOjE1IC0wODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiAyLzIvMjQgMDE6MjEsIFpoYW5nIFJ1aSB3cm90ZToNCj4gPiBQYXRjaCAxLzExIGlzIGEg
YnVnIGZpeCB0aGF0IHNob3VsZCBiZSBjb25zaWRlcmVkIGFzIHN0YWJsZQ0KPiA+IG1hdGVyaWFs
Lg0KPiA+IFBhdGNoIDIvMTEgZml4ZXMgYSB1c2VyIHZpc2libGUgc3lzZnMgYXR0cmlidXRlIG5h
bWUgY2hhbmdlLg0KPiA+IFBhdGNoIDMvMTEgaXMgYSBxdWljayBmaXggdG8gYWxsb3cgY29yZXRl
bXAgZHJpdmVyIHRvIHByb2JlIG1vcmUNCj4gPiB0aGFuDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAxMjggY29yZXMuDQo+ID4gUGF0Y2ggNC8xMSAtIDEwLzExIGFyZSBhIHNlcmllcyBvZiBp
bXByb3ZlbWVudHMgYWltIHRvIHNpbXBsaWZ5IHRoZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY29kZSBsb2dpYyBhbmQgcmVtb3ZlIHVubmVjZXNzYXJ5IG1hY3JvcywgdmFyaWFibGVzIGFu
ZA0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0dXJlIGZpZWxkcywgYW5kIG1ha2Ug
aXQgZWFzaWVyIGZvciBwYXRjaCAxMS8xMS4NCj4gPiBQYXRjaCAxMS8xMSBjb252ZXJ0cyBjb3Jl
dGVtcCBkcml2ZXIgdG8gdXNlIGR5bmFtaWMgbWVtb3J5DQo+ID4gYWxsb2NhdGlvbg0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIGNvcmUgdGVtcF9kYXRhLCBzbyB0aGF0IGl0IGlzIGVh
c3kgdG8gcmVtb3ZlIHRoZQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFyZGNvZGVkIGNv
cmUgY291bnQgbGltaXRhdGlvbiB3aGVuDQo+ID4gX251bV9jb3Jlc19wZXJfcGFja2FnZQ0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmVjb21lIGF2YWlsYWJsZSBhbmQgcmVsaWFibGUsIHdo
aWNoIGlzIFdJUCBpbg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNDAxMTgxMjMxMjcuMDU1MzYxOTY0QGxpbnV0cm9uaXguZGUv
DQo+ID4gDQo+ID4gSSBjYW4gc3BsaXQgdGhlIGZpcnN0IHRocmVlIHBhdGNoZXMgaW50byBhIHNl
cGFyYXRlIHBhdGNoIHNldCBpZg0KPiA+IG5lZWRlZC4NCj4gPiANCj4gPiBQYXRjaCBzZXJpcyBW
MSBoYXMgYmVlbiBwb3N0ZWQgYXQNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MzExMjcxMzE2NTEuNDc2Nzk1LTEtcnVpLnpoYW5nQGludGVsLmNvbS8NCj4gPiANCj4gDQo+IENo
YW5nZSBsb2cgPw0KDQpDaGFuZ2VzIHNpbmNlIFYxOg0KIC0gQWRkIHR3byBuZXcgZml4ZXMgZm9y
IGlzc3VlcyBmb3VuZCBkdXJpbmcgY29kZSByZXdyaXRlLg0KIC0gUmVvcmRlciBlbnVtIGNvcmV0
ZW1wX2F0dHJfaW5kZXggdG8gYmV0dGVyIHJlcHJlc2VudMKgdGhlwqANCiAgIHJlbGF0aW9uc2hp
cCBiZXR3ZWVuIGVhY2ggZWxlbWVudCBhbmQga2VlcCB0aGVpciB2YWx1ZSBpbiBhc2NlbmRpbmcN
CiAgIG9yZGVyLiBTdWdnZXN0ZWQgYnkgQXNob2suDQogLSBSZXBsYWNlIHNlbnNvcl9kZXZpY2Vf
YXR0cmlidXRlIHdpdGggc2Vuc29yX2RldmljZV9hdHRyaWJ1dGUuDQogICBTdWdnZXN0ZWQgYnkg
QXNob2suDQogLSBVc2UgYSBkeW5hbWljIGFsbG9jYXRlZCBhcnJheSB0byBzYXZlIHRoZSBwZXIg
Y29yZSB0ZW1wZXJhdHVyZSBpbmZvDQogICBpbnN0ZWFkIG9mIGEgbGlzdC4gU3VnZ2VzdGVkIGJ5
IEd1ZW50ZXIuDQogLcKgU2ltcGxpZnkgdGhlIGxvZ2ljIGZvciBoYW5kbGluZyBwa2cgdGVtcF9k
YXRhIGFuZCBjb3JlIHRlbXBfZGF0YQ0KICAgYW5kwqByZW1vdmUgdW51c2VkIG1hcmNvcy4NCg0K
dGhhbmtzLA0KcnVpDQoNCj4gDQo+IEd1ZW50ZXINCj4gDQo+ID4gdGhhbmtzLA0KPiA+IHJ1aQ0K
PiA+IA0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBaaGFuZyBSdWkgKDExKToNCj4gPiDCoMKgwqDCoMKgwqAg
aHdtb246IChjb3JldGVtcCkgRml4IG91dC1vZi1ib3VuZHMgbWVtb3J5IGFjY2VzcyBpbg0KPiA+
IGNyZWF0ZV9jb3JlX2RhdGEoKQ0KPiA+IMKgwqDCoMKgwqDCoCBod21vbjogKGNvcmV0ZW1wKSBG
aXggYm9ndXMgY29yZSB0byBhdHRyIG1hcHBpbmcNCj4gPiDCoMKgwqDCoMKgwqAgaHdtb246IChj
b3JldGVtcCkgRW5sYXJnZSBwZXIgcGFja2FnZSBjb3JlIGNvdW50IGxpbWl0DQo+ID4gwqDCoMKg
wqDCoMKgIGh3bW9uOiAoY29yZXRlbXApIEludHJvZHVjZSBlbnVtIGZvciBhdHRyIGluZGV4DQo+
ID4gwqDCoMKgwqDCoMKgIGh3bW9uOiAoY29yZXRlbXApIFJlbW92ZSB1bm5lY2Vzc2FyeSBkZXBl
bmRlbmN5IG9mIGFycmF5DQo+ID4gaW5kZXgNCj4gPiDCoMKgwqDCoMKgwqAgaHdtb246IChjb3Jl
dGVtcCkgUmVwbGFjZSBzZW5zb3JfZGV2aWNlX2F0dHJpYnV0ZSB3aXRoDQo+ID4gZGV2aWNlX2F0
dHJpYnV0ZQ0KPiA+IMKgwqDCoMKgwqDCoCBod21vbjogKGNvcmV0ZW1wKSBSZW1vdmUgcmVkdW5k
YW50IHBkYXRhLT5jcHVfbWFwW10NCj4gPiDCoMKgwqDCoMKgwqAgaHdtb246IChjb3JldGVtcCkg
QWJzdHJhY3QgY29yZV90ZW1wIGhlbHBlcnMNCj4gPiDCoMKgwqDCoMKgwqAgaHdtb246IChjb3Jl
dGVtcCkgU3BsaXQgcGFja2FnZSB0ZW1wX2RhdGEgYW5kIGNvcmUgdGVtcF9kYXRhDQo+ID4gwqDC
oMKgwqDCoMKgIGh3bW9uOiAoY29yZXRlbXApIFJlbW92ZSByZWR1bmRhbnQgdGVtcF9kYXRhLT5p
c19wa2dfZGF0YQ0KPiA+IMKgwqDCoMKgwqDCoCBod21vbjogKGNvcmV0ZW1wKSBVc2UgZHluYW1p
YyBhbGxvY2F0ZWQgbWVtb3J5IGZvciBjb3JlDQo+ID4gdGVtcF9kYXRhDQo+ID4gDQo+ID4gwqAg
ZHJpdmVycy9od21vbi9jb3JldGVtcC5jIHwgMjE5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0NCj4gPiAtLS0tLS0tLS0tLS0tDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEyMCBp
bnNlcnRpb25zKCspLCA5OSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiANCj4gDQo+IA0KDQo=

