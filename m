Return-Path: <linux-kernel+bounces-83094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4049E868E55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E35A1C21268
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9F11386D8;
	Tue, 27 Feb 2024 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6HlV9CQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1E31386CF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031964; cv=fail; b=jwNcih7eHbTw91WxX307g1C2LbVWcovl1JQI32a+1QCeQUbSyM5EVyEnlGBzew50EwhMtO9tjObnitZJEr8Er1NdwE9aEAVQ7f+05cp5zag2dAOhwqdAGCe4IzDnmZ99SLe/9yIjT4NBz2KoYoDPwSe+9A/SRaphRm26O0LOTZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031964; c=relaxed/simple;
	bh=CAEilS1igoJ0hb0rBbs05Rhuupkkc6EaeidrMLILZRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laNB3V+ke22Up8mOsFn/+XoL5hflda6mg9u2te50I4OaiNGw+Bx70Nj/XwNJIQwsXgxWuCaDZW9KSLZJ37Zo/2OLyhKEb8uk1HAWLE7YXAOZFtxwMPk53wqY7nneLl2PG6nRtMm651ZbpbbNKYwxEB3bs0e30inkiRxGoAXvXOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6HlV9CQ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709031963; x=1740567963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CAEilS1igoJ0hb0rBbs05Rhuupkkc6EaeidrMLILZRg=;
  b=C6HlV9CQGtnG2sEkWhlx3j5eXR30FDBLxXbVmzPnwsYJhuLfRlRpOHAs
   ByiB6BMISBQ2hSFIyzfLtUlpMdwBZLhV7/4/rVq9UsoshsWfvTrTO0pfU
   7G9W1k2HdM9xIdXz5mE/JjNdmIrgGzO4hZ4CUxvoYRe67eZ47vkDZfjN8
   NULzYtVYuNNlS1NYWnCj9OMNH8GIeFcwrdiRvT0U1HZVYvExfBkzDIM2F
   kSHGQ2st4QnykbP0Z5XBkOLV63Z15BWG96dUNoNwpcSw1oMxK3f7f9uDO
   ED8QgnGYFkAqDpn6s8udYRJgZSbMYrA2l1W7lx08Hu0E9U+11GVAgqw1g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3524788"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3524788"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 03:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11620329"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 03:06:01 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:06:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 03:06:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 03:06:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 03:06:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWJbmGNT6Zlf6UJN4mZK0mkwGzhou/FGb3lZMrbSqj/lbBCTbJmeq5Q7OcWnAVoouW4aVO1sbWT1gOTEXRXkHgUmzJPdnaXLqkCBGk7KHfB4ZKTQcVEJ4rAPq8CXtuHAUfdhVP5zPaC/IkAf9vBjDMJOH5vfwGOqPAOW7knj+MX+NzZcUMgF5QLA34INhV8VrBczTMKAqVHHG3w+PWcLCBZIaxXvq/0aX6vmGf6GnMv0XEAvJsPV44tIReXhP9vabSIEMM86zFoiHgK1iS7qENZofvQlMK7h36Ma9Oy4jTfKF76zkkyd8lFcKAYXqkJiPxNFhllm4artR2dfOr/MSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAEilS1igoJ0hb0rBbs05Rhuupkkc6EaeidrMLILZRg=;
 b=Z4TSM6ZOdRTPjDFoPGZgKN9dP+zuAAahBtYmBbplfoAmHd7M/SfYl0uj7X/kQqnjqa5GqhqGyMHbGD0mRboC50oM1xpNdbmQOD+EeioPrdN0SXtwT3rU6mroYTKpxryFyW25V8jWAfaEn4Pm8L6v2GGnA13BzgAywLCYyr7sgUOc9iupJ8H+ZtIODH1ZR2JsVuVuraTvftkYoISBAUVGhbG+iV+2irrHQsvgUoi8MsbKKMsSM4B6b0x6lFsqPA6E1gnDz4JuKgCyvkL+ln/pIu6nEQnzfdq9jksZnc/GrUnciz5xFafDGLWraRdU6JhnLfVk/gpVvphvJKbzPsTgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 11:05:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 11:05:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC][PATCH 05/34] x86/cpu: Move /proc per-cpu ->x86_phys_bits
 reference to global one
Thread-Topic: [RFC][PATCH 05/34] x86/cpu: Move /proc per-cpu ->x86_phys_bits
 reference to global one
Thread-Index: AQHaZb8k0jVV+ooEyEO9btprfbiVGLEeDl2A
Date: Tue, 27 Feb 2024 11:05:57 +0000
Message-ID: <6b88518ef6bd886faa5c65b6860b65eceb130cfe.camel@intel.com>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
	 <20240222183933.953C8BFF@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183933.953C8BFF@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: 666f63fe-e5b8-43ca-acf5-08dc37841369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+9q5Re1JH6O2QBc3WgPoWXFnWGeSPi5/b579SKKJhZadNumdsg5Aw87+la4ho4ycGLGg/owUb9BwUqU0/OvICedDNUsSDQPuy9GcHdOc+5cEfdIaYxQR2MdDIPPz5f2v7+C7pKsL0nWTzMQFA5AujRsydG1BEw5XfwqTwz3AjiMgUuc8beDi9jlg5KuhPv18IaLw9F4NFhP2a7eO9hUu7jkLti1ksy6YOHd99NZ10uo1hbCSORLKgP6ytqDlNuLbcvvfkBb5gYbAecMTukM91Tb50T5t8C7Bwdfnc0BdA2IZEI85GgdN0UbWrG3qzObYUUOjwgtKo1UTWWdZOiviaDhAG9igqGkI9mnmOvTTcqmC8YqFQirfd/sYD01GZrBWmwZjwO68EPnruTj0P0h4RV0Ml+n0Gs9bN3s7VJBA4VTmTqzLpesr/LPQRyt+9KHy5pwaySe8pruFqljN/edIdgQsvQf6rnToD6CYqAC/OiuT3p45UAnTiJmLPAieAIyHCKQk6o0pA0M2mEY891oO6C6zs63ld147eNjbxnvoUtjhjJElpVlcsXYr0mzJ1l7udeB9i8hXe/hU70VnX2Sbc5ufums66zWhDNxq1Bo5gFoJ9SkT2UiDd4PCOZgzycUc71a98PCPQ/47N9Pges3b+5HqF2PXSX7jgW2jbnDCVwNU7EaePZoWxtqxXjtFVA2FxLif1ECQLH0Km7m17iJe1h02/Eyr2zzkDYzyIMgLFU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1ltWXRHcGNpM1hMWHE4TWJ5eWtHNkpKdFVjZWhpR2hnN2FNaUdRSHh3Rzdn?=
 =?utf-8?B?dHNZOTdualA0TkJicXFFSGdha0c3amgxVEFOU01rOXlRNk1CT3FhckhPOWE4?=
 =?utf-8?B?Y084ZVBQVCtBRkMzRjVkaFl5NFY3TWRZRzg0dEVzNndQVk5CK1J4bkxKaGJv?=
 =?utf-8?B?cll0VW5FZjdQOENOVzVpN0h4Z3pBOWtTeC8vaVRtK2JPL2JyZjY5ay93ckRK?=
 =?utf-8?B?OURvQ3RucDA2dmQ2dGRDZHpKSXRWMFhQSFp3REJCOEJWQzdxMEZvRVlrMXBU?=
 =?utf-8?B?QUpUNmpXSS9NcHJLS3Q4Y2liRUx3L2JxSTdQcmZBcTJSMDU0WmRTZFd6bGZT?=
 =?utf-8?B?anBPNktZaVJDaG82MmlxQ20wc3BWNTJKS1YxUmU3SVQvK2VLWURobjQrRExn?=
 =?utf-8?B?T09OM2hZOWh0WXYrNnVCS09GUThaUFR3RnhDeTFsTURjSjdubElWdG5ZOWpo?=
 =?utf-8?B?TFFQazl2aWJzN2VEWnNhaFE3T2R1SERMZldSdXVuK09zb2J0ckhEMWpmUU9I?=
 =?utf-8?B?WUJoMkZLZkJoYzJGVGN4OTBhTklJb0xPck5GcjllMjBYMU8yUUsrbXBDTlMz?=
 =?utf-8?B?UzhKK1krVTVFSzJZZUthV0tNb284ZVNwSUlUbmowQVYzck9uOTlRSjdHQ0JH?=
 =?utf-8?B?MWVyWXgzRkFQMGpCOGF6SFN3ck9oRHpTcmZSaWZoTzVkcFJtM0wzd1Z5SHBa?=
 =?utf-8?B?NEtRK1c1YUZiS2lXbnpmaTVPckNQNk94cThURHJQM3lpMFFQVXQ5d3dWYWpF?=
 =?utf-8?B?czBqcVVEMG9KblkzTndrYnlEMnhQWHZkU2piNXZvSVQvbE5hZ1VCUXlYUlp5?=
 =?utf-8?B?ZEw3WTVpMlcwQnFEOVJjRlFUSktERW1CSzZhMmtqalVudWhvS0lyT2RFbGRU?=
 =?utf-8?B?cU1PZjdrQlJLY3lkQ1RnMVZvK1l6NVl3NlRtQTlFMCtMU1lYR0czUXVNMmZU?=
 =?utf-8?B?cFNJbjErWGhPZW4wSGo1RkZqanFFSVFqMU4yQ3JxQ2FEN0MwVXI4WHJPcTEz?=
 =?utf-8?B?QjZjU2k0Yms5eXN5OFhkdjJUNXpORldyNW1uL1lXTUJqRUtScS9lM1NlSDgw?=
 =?utf-8?B?UzhNZjFGOTE4cGI0ZVZrNUpMK1BodkdBbUxlRVVVNEhudDFuckc5WUtoNFhH?=
 =?utf-8?B?ZDVoSndKQnZBRWhuSm9Jb2VLOEVkTnB3Y29XeE8ycStPc1dqZHlZQ28xdkdB?=
 =?utf-8?B?c3dQNlVkY2c5N2FtUE1MV3l0NzNubTYzWk44RTgxK1JqR0xESmMrSmJMNE9u?=
 =?utf-8?B?bjdQT29rang2OUxCQ0IwTVM5b2cxV0ZmbHZIK3pDK3lFRHE2VXJoYnFNSVlE?=
 =?utf-8?B?SVlNc0N2V0VDcytER0RZYVpYazhhSW1JT1RwVkpDR0Y5NGxOazJ1YitQbjFp?=
 =?utf-8?B?VEhxcDVvZ04rOWl0RzVobDRyUUk2aWdnL09GNXdUVkZRSzBYSW9kazBXVGI2?=
 =?utf-8?B?aVY3ZStVc2hkV1dyQWh3Q0NOd2dWdnhEVDVYTUNBUkZaOUFXSW5LOUZPalor?=
 =?utf-8?B?Nk9sWWw1NG4rSGZVcmdOenZRbXFjTkUzbE1tTXNVT01JV3BPM1RNSFNYZzVx?=
 =?utf-8?B?ZnA3OXJYNVVFSUlWTmlVK1BhWUNwWldIL0ZKK0lpL25KMC9HZEVTVjRsbVEz?=
 =?utf-8?B?QkNRUEpGSTFUU2ZyV2tGbUlka3d2QVpwUWF1dUZDbzNUNGgvTU44VWVlb0Uz?=
 =?utf-8?B?eXhYa0VtZFhBOE5FZ1lTbnl6ZGRPSkxuNzIwRnBmQ09kdDlKQzB5WFlTK2o5?=
 =?utf-8?B?TVpVRHU0d3Zuc0g1K0RjaDZqbkk3Nk5nSmg2ZmZqUCs2YXZ3NE0rVlBERU10?=
 =?utf-8?B?RVVvd1VPRW03YW5jOVRTMmI0UFNvTlJMcGRvYTlxUDZHemJxT29BcXlmWU5m?=
 =?utf-8?B?OUF0cXZqeE9uYnhLMTVlQWVsUDNCVEVEa3lEb0lPZEpJd3N0SXRPSEVYN044?=
 =?utf-8?B?UXl0a1FGeWFsYmRLRlU5NC9wL3FqK24zeTA0dDI5bTF0MlhLa0c1bzZMbnFF?=
 =?utf-8?B?KzZDNWdCOGRmQW9zNXozM244NGVhcFVrTU9hR3FQYjllcGV1MklDN3lYdWhH?=
 =?utf-8?B?UTNZNkhIY1l6ekIvdnV6OVcwUnE3RTFtblE4dmcyWEdaSCtCRm9kenFUbUFK?=
 =?utf-8?B?VnRFYWJEaUVFTytVQU1TeUp5L3BNZGZWbFd6RTBHL1JpVDZjZzRlSGtvNkd1?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF2DD38011E1446AF2C8D49F2044B6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f63fe-e5b8-43ca-acf5-08dc37841369
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 11:05:58.0290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmCPCZLKXv5LT/SWJQWGgbz1xXOrLG1Bq2HyVUfsdbdoKdDMFoQ8XQ45UGRB3brn7DcJ4MEgy5MXMxhLkTYAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEwOjM5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRo
aXMgaXMgb25lIG9mIHRoZSBmZXcgcmVmZXJlbmNlcyB0byB0aGUgcGVyLWNwdSB2ZXJzaW9uIG9m
DQo+IC0+eDg2X3BoeXNfYml0cy4gIEl0IGlzIHRoZW9yZXRpY2FsbHkgcG9zc2libGUgdG8gaGF2
ZSB0aGlzIHZhbHVlIHZhcnkNCj4gZnJvbSBDUFUgdG8gQ1BVLiAgQnV0IGluIHByYWN0aWNlIG5v
Ym9keSBidWlsZHMgc3lzdGVtcyB0aGF0IHdheS4NCj4gDQo+IENvbnRpbnVlIG91dHB1dHRpbmcg
dGhlIHZhbHVlIGluIC9wcm9jLCBidXQgcmVhZCBpdCBmcm9tIHRoZSBnbG9iYWwNCj4gY29uZmln
dXJhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiANCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2Fp
Lmh1YW5nQGludGVsLmNvbT4NCg==

