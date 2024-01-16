Return-Path: <linux-kernel+bounces-27255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47982ECCF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD336284E98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E013AC0;
	Tue, 16 Jan 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVwbgZsz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96617134DE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705401375; x=1736937375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d+hMVqIYPUqGkxmfsv545jRnbbM+wxvx/biOwAd1si8=;
  b=WVwbgZszVKhM1uzfYR4ozEBH92KRCbubTsDVzNkqujTyVS8VcmESaBfV
   sYE8YnmCn2YpdnTt4BFL/63OetmMSPPKBZMCyLgRb3nZw0rsMIePSGp9D
   ptuOGWCJpH5JdiZDeTFridwfzPuQ8v/PAyUQlGiuv2T0dzxgYxn+QX1d1
   56Csp43/Ag67vxkz+DTpGqm35H2KWvcFnm9rHMScD04VRFTBWzbv4r7BV
   YhES6jdAelipuymm1UAp+CRGQ4QR8A3npgya6Ep/RMkVHOetcde8EU+P6
   5MtvNTnwmETMA+pkIVjb5N3niu2YJRUlgEDTSPi497A6AxbtP3A9BCm2W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="13177496"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="13177496"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 02:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="784084842"
X-IronPort-AV: E=Sophos;i="6.04,198,1695711600"; 
   d="scan'208";a="784084842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 02:36:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:36:14 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 02:36:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 02:36:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 02:36:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2AnmGfWyAPSoaeWuDRWz/71xeI7JEMxS4A9npm/IIMtcQocMEvGq8YGrCYmcKsz3SyC8v0S3egYmpveu9J+PTDA3hpnPkXfshiBaYjR2F4aUx5BDx5MXr69ge/ABcSpkdGXhdZJZCvXdWcsEaUPnlelaECyNELCfrCS/EYBlCPrriohAXLxkoVzVYibz65LV4R9aI24re7oSSYE3Ew4j4oRXy3heocbQb/L8X2Lz+qvhgdXp4G1YSjHoN497ayuHqoWZs9mSf7ZZUOChrJhgUIYMHE60RpzSwXMEhZj8zpfs4TiiYaF97wUTguqT3YV1eHmubkZJZLTmAMSNBSprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+hMVqIYPUqGkxmfsv545jRnbbM+wxvx/biOwAd1si8=;
 b=VU2b5Fy8Yea1uHI5o4s9rQdQSQ7iNl0pIQioDUr2pumwElhdP928VhbR62mpk3xfH67FDZQWwIzVFhQCygMTUyeANtVc/5av5OObfosvtTNXTjQi4eHEIdKRa8e1WeH5dvMPKWWRCg4VYXhk4WjnnWKgjr8mfSzN3XBv1YDeojJDyDNgIgDsgmyLYnmVXIDtbeFQ2isDtYwvLqvlHCu76RzpexoLGlvWPh53zNR0elGomrBM9751seOqK6NZP1DjCKZsu6VB/J8n6QtOaOn2/dkABNiXU2Lkl1fJ3y2hT45X218OG3Q4CELg7rFrb+UgrJBpf4ML0vZYaUPB4EctZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 10:36:11 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 10:36:11 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jpiotrowski@linux.microsoft.com"
	<jpiotrowski@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Cui, Dexuan" <decui@microsoft.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Thread-Topic: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Thread-Index: AQHaRH8fDWK2kmMhZkC3EKr4wXoBC7DcRqMA
Date: Tue, 16 Jan 2024 10:36:10 +0000
Message-ID: <2b171c78e3dbc33f6fcf015c14c9e84825776798.camel@intel.com>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8446:EE_
x-ms-office365-filtering-correlation-id: 77e3a48a-880f-4155-a1fa-08dc167ef4e3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HA6Xv9SobRUh9MUIFLPiMRXUPKi5wIwPXA0LYIwsR/8UhYb9+crrb/NGgxSVcMNUUHoyGMKtbSHZH9ZmETV5fXdfAGIfj5RuYLjxlr7bAhVosKdZz6JQsgFQq+y082mW1W49MAsz2DpY/MYsQXTKLuO7xGqxm6rOu/tgZrnO102a8iorTLYPIFwAFa/8NyVmonYGGdDrpNCDctdkSi7PnkzVXa0rE5Ylo12idAxo6qRUX0kyMzmOBwpPZxgufstKTMyTImscbMrJeeM+VQqH49NZA3R4vJSE9WzMZOuwvQPn52ajP9OfH13VX1QT2P6hLOjcw1nvFSyQve9JCWok2h41ukzcFujFp5u6XjF8RvJa2dLWXsFcON38ylxpyBWvZ1PaPWycVTurM16vEkMU6NiZmnM5V8MX4L838Zb2t27xrMZLRIbIS+Rv3R3bjuYGHFUxQXEThbg8xRliiVQ3cdv4Z6L6UZCUOxxjzaEAJa1mnPbJbaoW09mjpYugiRr6e6kykwqBSepkk5VDqIXm/cGQLFZWqmfSPuMNi6SLNRL8Fhux5HbPlUMerzCPMNnJ9FTp+PtfQGzEkANo8eWSitdtBEeGRZKy1INWTG8vnpcDBgYmWW2UL9JHKDMAsaJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(2906002)(5660300002)(7416002)(36756003)(122000001)(8936002)(316002)(8676002)(86362001)(4326008)(54906003)(41300700001)(38070700009)(64756008)(66446008)(83380400001)(26005)(478600001)(66476007)(6486002)(110136005)(91956017)(76116006)(66946007)(66556008)(6512007)(2616005)(71200400001)(6506007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhvcGJNdzZHcjlZdktOMkpycm5DNkhaZWlPaTVsQ3grakNkSklpSlJuQjJy?=
 =?utf-8?B?bU9JamlPUW1Gem1QcFpUeHF5ZDVFTkhLYlRNU3lYWGkxTmtCQzBoSnM4M0cz?=
 =?utf-8?B?RldtZ3kvSWNMbnA3bW5mY0hGS2JOd2dqZEdUL2xTNlBVS2dldWJJTHM1NkNJ?=
 =?utf-8?B?N2oxRXJLakdQd0dPbktnZ1h2UDFSV2UzbUxMMGFiK09LY05uQXlxd1pSZDRF?=
 =?utf-8?B?TVphYVRGQ1VIY04xUTFwUWZGSnJlWHlDeEFCOVFQSXM1SWY4WkJyMVlMczRy?=
 =?utf-8?B?YWZZT29sZUhid0xnVXF4eXB4cGNJcmNnT25aVTdjQTZxQnpoSE5TeEpMdUZ5?=
 =?utf-8?B?Sis2MlNGa3F6MVUwV3g0aGxORmZFdjRKbjBZVWxub0IvS0dpNi94cktBMG1X?=
 =?utf-8?B?QThRUVAvTTJ3aUVudVVkb0w0anNWZ094RFlQd0IzdjhZSXlHMEE1ekNpYTcy?=
 =?utf-8?B?endGdnllTHNUdVNLVjlkc2FNQlBPSzJNY2xENzJmcjVxRzl3VkkxQXQrVEND?=
 =?utf-8?B?ZzhlditBT0N1dFlmUUptelhxSG4vUHVvT1dWQ2Eyd0ZtaUNmU0dWb2JUU0VR?=
 =?utf-8?B?YmJwdGJtdkh4YjMxYnJtZ1diMWRYSUtlcmRzMUdXUitoVW9DYnFHMzNsd3Fl?=
 =?utf-8?B?VFJXVG55dFFZVlc3NVBQdi9IUS9kZ0UyNlkzNERkWEgwNlh3WFgzMW9COUpE?=
 =?utf-8?B?eDRRSi9MbmVjSFllME5oNTJCcThrTVhHY1REbFRINEd0YmNhM2cxTHpnZDYv?=
 =?utf-8?B?dlFGNDIzMjVqREVVbC9nSUxBM1I3VitqMDk0cFVUdFk0RVVlSUhwTm5LMkYx?=
 =?utf-8?B?Zm9CMFFHWmZpN0lHYjlOQjZvQ3REN0o1Sis3WEVZZFFMNVNiUFVRc1dXYUxs?=
 =?utf-8?B?Qi84Yk1vTE5ab0FnVXlmZVRiQTY5N3E5NjlXOXYxOGExd1FQWE53SDZxbVpt?=
 =?utf-8?B?Zkg0UVZnTmJVbEhlVnU1cm5sTUtTak5NbnBFRmRaVFBod2hnVWJxclVBWTRx?=
 =?utf-8?B?U1lYcjRyaFpiakVpY1pkMlhwODBGbEk2eEFtcmlIZEN0MGNWV1JOTkdMRHhW?=
 =?utf-8?B?ZjhLNDRwVWJlYU9WdlV4MWc1R1RpZ1lHWTByUzBKbUVmVzI4WEdKVGNmcUlz?=
 =?utf-8?B?b3NZVWRFWUpEYlg3ZGI2T29GZWFXVDkvNnpWVXhOK1FjdjZYSUxQZHJES0Zo?=
 =?utf-8?B?MHNBQk9lQmlTVDh5VVI2WFdOa25OdDRXU0JBQWJtRmlaMGpPWVArd3NUTFlp?=
 =?utf-8?B?TWxtREE4eUpXdHM1ZWhiNEVCdDVSazBVbmtBNHoxOFNkSjBFY282VHdvR2M2?=
 =?utf-8?B?VWRtYWcvNDZHZjQveGNvQVJmbWFLTlFPSUdPU2pIYkpMRHBWT0lDUXJQYjU4?=
 =?utf-8?B?em82SWJzVklma0pjd1JhUlJxOXlGdm5RNlk4NXZEV0JOaVFjRVQ3S0hMWm9z?=
 =?utf-8?B?UWN6WjhVWUtDeWJzb2NZZTFuWlpjQWRwM2lkekIzbXZMMEswcWxMVk5EeXlz?=
 =?utf-8?B?NUsrRm9QdlFMcFhrQ3Y2MDZXWWZOM0ZvSnlzL3BFVE1lK3dUNTZvb2d0RlJ0?=
 =?utf-8?B?ZUpsTTFucW45VitLZklhSEZ2K3oveHM2T2tzeWdmWHl1YVdadTlBVFl4cGR3?=
 =?utf-8?B?UGNUSFpVQk56aDBtZUk1WGlBSTVLeUZkM0R5L2x3cElBUnJiWUJWUzZ5WnM4?=
 =?utf-8?B?QmlTTnMvMVF0WVltUG9aTVMyMWxDaUxnQkFGalVWajZRblZ3MEgrWUNMekVE?=
 =?utf-8?B?T0JzdnhBU2RTUVVJUCtUVXRnWDA0ZWdvWlBHQ1IxZEg2aWZzbG5DRktqSjRU?=
 =?utf-8?B?bWNIZTFZM045c29mSjdxbXh3Q3lvbkhLWWF2YjVHK3J5TUhaMW9uRkJBczlp?=
 =?utf-8?B?TjRtbjJZODBCaVhYdWlsM1JHdkhiRHVGM3c4dTZHdTBpV0JNYjR3WHV2bllo?=
 =?utf-8?B?cUhtT3I0OHg1bWp0dXpMVWVpVkt3U1RhM0R0MzlGYXFoMytnblhCYytxbXRI?=
 =?utf-8?B?UnFmYjBxTTB1N1hid3VJSHA0OThwM1J5aEdMcGMzc0MxSWV4YlJDUzhMazFs?=
 =?utf-8?B?QkRTZnpKTTlqZENQNlNFR3JlZWZYTUhkaEhVUjdabEpoTnNDeTlZakV1emxp?=
 =?utf-8?B?Ykk5UGVpUkNvUE1kV3htL09zRjNubCtucTRNNjMrSjRnNkNQcnlqbkVVZkpj?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F2FDB31BDF1E446846B570708C70137@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e3a48a-880f-4155-a1fa-08dc167ef4e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 10:36:10.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QaiBzlHa5iKAbhyNZ88WVpbGRTIIZdoXfDMz1zJtMNunCzMjZvyhmDD/yACBvtZzD4eWoKr6m1vQT4mMYB4xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8446
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAxLTExIGF0IDE0OjEyICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFdoZW4gbWVtb3J5IGVuY3J5cHRpb24gaXMgZW5hYmxlZCwgdGhlIGtlcm5lbCBwcmlu
dHMgdGhlIGVuY3J5cHRpb24NCj4gZmxhdm9yIHRoYXQgdGhlIHN5c3RlbSBzdXBwb3J0cy4NCj4g
DQo+IFRoZSBjaGVjayBhc3N1bWVzIHRoYXQgZXZlcnl0aGluZyBpcyBBTUQgU01FL1NFViBpZiBp
dCBkb2Vzbid0IGhhdmUNCj4gdGhlIFREWCBDUFUgZmVhdHVyZSBzZXQuDQo+IA0KPiBIeXBlci1W
IHZUT00gc2V0cyBjY192ZW5kb3IgdG8gQ0NfVkVORE9SX0lOVEVMIHdoZW4gaXQgcnVucyBhcyBM
MiBndWVzdA0KPiBvbiB0b3Agb2YgVERYLCBidXQgbm90IFg4Nl9GRUFUVVJFX1REWF9HVUVTVC4g
SHlwZXItViBvbmx5IG5lZWRzIG1lbW9yeQ0KPiBlbmNyeXB0aW9uIGVuYWJsZWQgZm9yIEkvTyB3
aXRob3V0IHRoZSByZXN0IG9mIENvQ28gZW5hYmxpbmcuDQo+IA0KPiBUbyBhdm9pZCBjb25mdXNp
b24sIGNoZWNrIHRoZSBjY192ZW5kb3IgZGlyZWN0bHkuDQo+IA0KPiBQb3NzaWJsZSBhbHRlcm5h
dGl2ZSBpcyB0byBjb21wbGV0ZWx5IHJlbW92aW5nIHRoZSBwcmludCBzdGF0ZW1lbnQuDQo+IEZv
ciBhIHJlZ3VsYXIgVERYIGd1ZXN0LCB0aGUga2VybmVsIGFscmVhZHkgcHJpbnRzIGEgbWVzc2Fn
ZSBpbmRpY2F0aW5nDQo+IHRoYXQgaXQgaXMgYm9vdGluZyBvbiBURFguIFNpbWlsYXJseSwgQU1E
IGFuZCBIeXBlci1WIGNhbiBhbHNvIGRpc3BsYXkNCj4gYSBtZXNzYWdlIGR1cmluZyB0aGVpciBl
bnVtZXJhdGlvbiBwcm9jZXNzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRl
bW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBDYzogRGV4dWFuIEN1aSA8
ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IEplcmVtaSBQaW90cm93c2tpIDxqcGlvdHJvd3Nr
aUBsaW51eC5taWNyb3NvZnQuY29tPg0KDQpTZWVtcyB0aGlzIGZpeCBpcyBmb3IgdXNlcnNwYWNl
IHJ1bm5pbmcgaW4gaHlwZXJ2IGVudmlyb25tZW50IGJlaW5nIGFibGUgdG8gdXNlDQpzb21lIGVh
c3kgZ3JlcCB0byBnZXQgd2hpY2ggY29jbyB2ZW5kb3IgaXQgaXMgcnVubmluZyBvbj8NCg0KSWYg
c28gSSB0aGluayBpdCB3b3VsZCBiZSBuaWNlIHRvIG1lbnRpb24gaXQgdG9vLg0KDQpBY2tlZC1i
eTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYv
bW0vbWVtX2VuY3J5cHQuYyB8IDU2ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL21lbV9lbmNyeXB0LmMgYi9hcmNoL3g4
Ni9tbS9tZW1fZW5jcnlwdC5jDQo+IGluZGV4IGMyOTBjNTViNjMyYi4uZDAzNWJjZTNhMmIwIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9tbS9tZW1fZW5jcnlwdC5jDQo+ICsrKyBiL2FyY2gveDg2
L21tL21lbV9lbmNyeXB0LmMNCj4gQEAgLTQyLDM4ICs0Miw0MiBAQCBib29sIGZvcmNlX2RtYV91
bmVuY3J5cHRlZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICANCj4gIHN0YXRpYyB2b2lkIHByaW50
X21lbV9lbmNyeXB0X2ZlYXR1cmVfaW5mbyh2b2lkKQ0KPiAgew0KPiAtCXByX2luZm8oIk1lbW9y
eSBFbmNyeXB0aW9uIEZlYXR1cmVzIGFjdGl2ZToiKTsNCj4gKwlwcl9pbmZvKCJNZW1vcnkgRW5j
cnlwdGlvbiBGZWF0dXJlcyBhY3RpdmU6ICIpOw0KPiAgDQo+IC0JaWYgKGNwdV9mZWF0dXJlX2Vu
YWJsZWQoWDg2X0ZFQVRVUkVfVERYX0dVRVNUKSkgew0KPiAtCQlwcl9jb250KCIgSW50ZWwgVERY
XG4iKTsNCj4gLQkJcmV0dXJuOw0KPiAtCX0NCj4gKwlzd2l0Y2ggKGNjX3ZlbmRvcikgew0KPiAr
CWNhc2UgQ0NfVkVORE9SX0lOVEVMOg0KPiArCQlwcl9jb250KCJJbnRlbCBURFhcbiIpOw0KPiAr
CQlicmVhazsNCj4gKwljYXNlIENDX1ZFTkRPUl9BTUQ6DQo+ICsJCXByX2NvbnQoIkFNRCIpOw0K
PiAgDQo+IC0JcHJfY29udCgiIEFNRCIpOw0KPiAtDQo+IC0JLyogU2VjdXJlIE1lbW9yeSBFbmNy
eXB0aW9uICovDQo+IC0JaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0hPU1RfTUVNX0VOQ1JZ
UFQpKSB7DQo+ICsJCS8qIFNlY3VyZSBNZW1vcnkgRW5jcnlwdGlvbiAqLw0KPiArCQlpZiAoY2Nf
cGxhdGZvcm1faGFzKENDX0FUVFJfSE9TVF9NRU1fRU5DUllQVCkpIHsNCj4gIAkJLyoNCj4gIAkJ
ICogU01FIGlzIG11dHVhbGx5IGV4Y2x1c2l2ZSB3aXRoIGFueSBvZiB0aGUgU0VWDQo+ICAJCSAq
IGZlYXR1cmVzIGJlbG93Lg0KPiAtCQkgKi8NCj4gLQkJcHJfY29udCgiIFNNRVxuIik7DQo+IC0J
CXJldHVybjsNCj4gKwkJKi8NCj4gKwkJCXByX2NvbnQoIiBTTUVcbiIpOw0KPiArCQkJcmV0dXJu
Ow0KPiArCQl9DQo+ICsNCj4gKwkJLyogU2VjdXJlIEVuY3J5cHRlZCBWaXJ0dWFsaXphdGlvbiAq
Lw0KPiArCQlpZiAoY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfTUVNX0VOQ1JZUFQpKQ0K
PiArCQkJcHJfY29udCgiIFNFViIpOw0KPiArDQo+ICsJCS8qIEVuY3J5cHRlZCBSZWdpc3RlciBT
dGF0ZSAqLw0KPiArCQlpZiAoY2NfcGxhdGZvcm1faGFzKENDX0FUVFJfR1VFU1RfU1RBVEVfRU5D
UllQVCkpDQo+ICsJCQlwcl9jb250KCIgU0VWLUVTIik7DQo+ICsNCj4gKwkJLyogU2VjdXJlIE5l
c3RlZCBQYWdpbmcgKi8NCj4gKwkJaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX1NF
Vl9TTlApKQ0KPiArCQkJcHJfY29udCgiIFNFVi1TTlAiKTsNCj4gKw0KPiArCQlwcl9jb250KCJc
biIpOw0KPiArCQlicmVhazsNCj4gKwlkZWZhdWx0Og0KPiArCQlwcl9jb250KCJVbmtub3duXG4i
KTsNCj4gIAl9DQo+IC0NCj4gLQkvKiBTZWN1cmUgRW5jcnlwdGVkIFZpcnR1YWxpemF0aW9uICov
DQo+IC0JaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUKSkNCj4g
LQkJcHJfY29udCgiIFNFViIpOw0KPiAtDQo+IC0JLyogRW5jcnlwdGVkIFJlZ2lzdGVyIFN0YXRl
ICovDQo+IC0JaWYgKGNjX3BsYXRmb3JtX2hhcyhDQ19BVFRSX0dVRVNUX1NUQVRFX0VOQ1JZUFQp
KQ0KPiAtCQlwcl9jb250KCIgU0VWLUVTIik7DQo+IC0NCj4gLQkvKiBTZWN1cmUgTmVzdGVkIFBh
Z2luZyAqLw0KPiAtCWlmIChjY19wbGF0Zm9ybV9oYXMoQ0NfQVRUUl9HVUVTVF9TRVZfU05QKSkN
Cj4gLQkJcHJfY29udCgiIFNFVi1TTlAiKTsNCj4gLQ0KPiAtCXByX2NvbnQoIlxuIik7DQo+ICB9
DQo+ICANCj4gIC8qIEFyY2hpdGVjdHVyZSBfX3dlYWsgcmVwbGFjZW1lbnQgZnVuY3Rpb25zICov
DQoNCg==

