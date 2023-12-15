Return-Path: <linux-kernel+bounces-1413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCE814EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2791C24387
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA27405FF;
	Fri, 15 Dec 2023 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnUwmtzy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3AB405F3;
	Fri, 15 Dec 2023 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702660878; x=1734196878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lahRpdvxIxXPHBrxXqAdgxQKvCWN/6B2c5m182SfFv0=;
  b=XnUwmtzyRKF6mIRjn49mEMHJY3j5wyFSq0fu395P9drE/omIo6SMxs3D
   xReBWFXbjhYTNUDH0qKK/iAttj02TwmlFKIiyfxkPc32EOXKn9IjTSXXu
   7w2NKr3iPbi/7e4zmuj6Go+YIbE1IrD1V7T0pulI9BB9fDjEiqw4NAPhX
   MD6Z8ksAj3LONhAUKVOkX28hmMCFnd3tvX1Q3p/5BPZdHNp/SG0kBekFq
   98NwrcOu1TNuo5hYzMWDGpRBZdiO8Eud3PGAM6Eo407TuVqIu5fQlG84M
   93dBjLtt38FIUcOu+koXGcVKT38H38VNEn8UM8WDkxJFamLcKEsLUNj34
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="385721626"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="385721626"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="865471524"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="865471524"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:21:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:21:16 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:21:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:21:16 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:21:16 -0800
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:21:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%6]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 17:21:12 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>
CC: "Borislav Petkov (AMD)" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [tip: ras/core] x86/mce: Handle Intel threshold interrupt storms
Thread-Topic: [tip: ras/core] x86/mce: Handle Intel threshold interrupt storms
Thread-Index: AQHaL3E340pWXEx1wEiDWznZGGgX/LCqlvXA
Date: Fri, 15 Dec 2023 17:21:12 +0000
Message-ID: <SJ1PR11MB6083E1B502165AA27D685AB7FC93A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231115195450.12963-4-tony.luck@intel.com>
 <170265660288.398.1352223643373155784.tip-bot2@tip-bot2>
In-Reply-To: <170265660288.398.1352223643373155784.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7268:EE_
x-ms-office365-filtering-correlation-id: 73f27394-4d0c-4414-d453-08dbfd923c4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tJK03XWFVCA3dqq5lr7T7fBz1n3JkPBC2fL8xIi8Fb1OydqtV+7NNTmnkxA6o86h90/uA26oflBS2QxsFvHf/sjmzf0UovZU+p37ODbHr6p5JC0Iu77BLUzo8viEc84SStY6f+UaWSfsWRqUVZnLdhDEEEgZvo1KaorMeBINnYne8oj3UKdEuEhAfhr5kaRRXo7Zw5IAK0Jn07gITQ0i90APd+9xSE5C0jKWqZC9YvZJNk/V1JlXMeguLFfRgL4LPfjhkNG4d1ZvUWYlCfaOq/W/aQN0xOp2Pdsiq/2LbyOPL4h1onsZlDoRZcNWV8p6lUJ6duao6dFgoIjVv4xM0YtRMtx019cN54waxsteU0zFD1QGXe7rCoF9UYWiDY2HXusM0dqYnXl8QOhoXSFwYdjgQBf+Lkvyi7UZibVKxjFRcBzR56V+pOtI3XdnpfBQ2nVIQJv13QBBp6TxqTK3DRowCOHgwSOVUA4ZwpjOOtZvfSTVEFpo9MhWpDEGjgY+SSN1UkaefP3r8D0ffwrqXtUuGyTzeiAnPwXtsF+Hc4fPEkyHNjzmkOcma7isk0b2oCbfli6I2vLFSeapqK62vwHK6NTEspdDUPIg/j4+wTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(55016003)(26005)(7696005)(6506007)(82960400001)(33656002)(38070700009)(86362001)(38100700002)(122000001)(5660300002)(4326008)(52536014)(9686003)(71200400001)(76116006)(316002)(66946007)(110136005)(8676002)(8936002)(54906003)(64756008)(66556008)(66476007)(66446008)(4744005)(2906002)(41300700001)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V252bWlNZWxZTlVXUUphcnBDRGpLYmYxMHZVU1dPeTNFdENDNmYrdW51YUlp?=
 =?utf-8?B?K2hVamRuV3NpOHVFZVpCQmFJeXp2V3lpUlVpdklTVFROd2I0MVVlVWFRWkhx?=
 =?utf-8?B?cGppd1V1UlNabkJid25oTnVTbnBVQnpFQ0x5ZVRsUCszdlM4R2VGTnRVNW1O?=
 =?utf-8?B?K1BUWWcxamdqNUc0NFQ3MnFtZlZKNWJQbGhPZ3hwR2pWLzNkQ2xvV0Y3amtS?=
 =?utf-8?B?YTZtNjNXWWVQMW1BTEZhTVFENk1nWWZiMHdFL0ZyS2RZcEZ4cGRoZjRkMjdM?=
 =?utf-8?B?eTZwYzJjcmhtdlNET2hUWnpLbXM1WXFPMk5FVkk2MTdPYm1RaUJRV3RDMVVj?=
 =?utf-8?B?YVNBZy82V2ZhOHpzam9maklNVU5oMUVSTjEybUk0YjRySi9vTDQ4Ynl5cFY3?=
 =?utf-8?B?MDlCS205eXM1NzZsN3hZeWYyRHVlSFhRNmZTVTUyUk9LaEM3bisxMnkrUkl2?=
 =?utf-8?B?REVhS2lIQWJuSm9hMm1td3JQOU82NFhJRTB4dXJzUkxPdFo4SjQ2V0dSVERX?=
 =?utf-8?B?ZFhXUTcrd2FtbEx3eWhVNjVHeTBMSElrMUF3bW1WTDZpVDR5S2tEYVFiOWR0?=
 =?utf-8?B?NmMybXhYZ29paWMvUE5MYTdyeDcxTldHQkh6T3pLTVAxOGJEaDhnNjF0b3N5?=
 =?utf-8?B?OGRzUVNrMFpLYnJ4SkRhRER6dGdiMTYvVXI0Q2Y5NXJaVTJjN0pON1hWY3p5?=
 =?utf-8?B?OThQNnhWdzk2cC9xdHMxWS9yUlhUc0phL2hDWDJlRlBlZklvNnNiNlplbDNZ?=
 =?utf-8?B?SXBzakdCbDVmV2FrNzZHWGRFTmZiWEhXczdYU2sxQnpzeUhGcWx3Mjk5V1Jh?=
 =?utf-8?B?SjkwYWZlNWtJeW0yaTl4cUFWd3pmREI1MkEza21EMktaZnlFS3RTZ1g4MzhJ?=
 =?utf-8?B?S2ovQXlMazFDN3BIQWFjdVVYSWI5aTJSSXFHVjJrWW4zMmgzUHNiVWVNbjNo?=
 =?utf-8?B?bUZjSDVTMWxFN0ZwaW4wYTBwaTBtTHhNMmh1NDZJVTd6RjZVME5wOTZ5V01J?=
 =?utf-8?B?M3dGYlNxQ1RIVVlsck9DMi9rWS9jN2ZrT01US2htb3Q3aDgwbkZhZCszd3F3?=
 =?utf-8?B?di9EdDExbzcrY0x4ODN4bk4vMUVSNEVEV3dGaDVDWkJVZEk4b1NRUElSZzdP?=
 =?utf-8?B?RzZqalNSQzhGRjVFTk9wNFYyZnJSQWE4YVZkS3ZJM0RkM3RwT3UrTlRLOUlS?=
 =?utf-8?B?SHBpOEZTc1lmVHRQWU4wYkhZNmJqL3RYT3VoR1VCbFIzdUpzWitwRTBIRVE4?=
 =?utf-8?B?VktIZHU2SjRBNTRCWmU4d1FiTGw4SWI4bSs5RUowVnlURWpld1hndThlN0Fp?=
 =?utf-8?B?NkhsaDZIN1R0SDlMRElkcVZtWVdORDQ4YzRiWm1FUExqMmw3LzU1MmhxZ2N5?=
 =?utf-8?B?dnpDelZoWXE1ZXJEemdLYzZ1NmlpdC9neG5ycng3R2FxV1gvZFc0T0tRd3Bn?=
 =?utf-8?B?SDlkbTlEYkpobDd5ckF1RFNNMXYrTUgveGpnTnAxdnRMWWZES3o3RlJTTVgw?=
 =?utf-8?B?Y2FPb21ndTRsRzRhYUZjZ201dHNxYkUrSnk2WjFvR2ZYVm4xV0tETnNUdjd2?=
 =?utf-8?B?RmExT2xoa3htUW5BMnhWRTZPZlBWbHEwdGc4cHNsL2JBZ09YSTk0aEFlT1U0?=
 =?utf-8?B?TVoyTmRkUi9vYzYwbldsVTg2NEJ4MVFZUW5pVUVpYjBNeE91Rmd3bEdxZTNF?=
 =?utf-8?B?SEplSWJGWHNKNnp6dVdRSlNzdVRuNURHQUVEZ2hTa1dadGZubDljMDlzaUpJ?=
 =?utf-8?B?M2dqMk1hTHROQTdjNnpocXlMZU95NkE1ZEtmRmg2RWw0elRFWXFhaHZDSC9V?=
 =?utf-8?B?S0d0UnMrREpqSml1Ly95V2ZkZ2tMVFl1TW01cFV6VDAwWXllV3pLYVB0SVhN?=
 =?utf-8?B?MEtNZysyQ3NTMFJEQXVTSExUUkZUL2YvNWJrc1hWWklNK2ZoNXhkY3c4Q000?=
 =?utf-8?B?YnJnbG9xcGI2T3RGNmhwaG9mRGFrRVFHMkJraVJ5T0NQRmloVUYrdHlrR3lr?=
 =?utf-8?B?a00wVTY5NUJCVGwzVEZ6Nk1FWmZBS1JPbk0yemhkVXJHSG5CMFF1SWl0M3Zr?=
 =?utf-8?B?QzFyN1o1MHp2MjZ3cDd0WU1sV1Fici9meHB2K1c0eU9KdzFQQVRxamZvdTdK?=
 =?utf-8?Q?VZ0EiK0WIUO7Hxd+3W05FgPSr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f27394-4d0c-4414-d453-08dbfd923c4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 17:21:12.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4p6jSNVEDeHHfSIoClVEa9qb+bagw7VtgpW8knwIKxXbb3czNy97HAsjippjZbkg3H7kV1/jJUjcSb6saDhKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com

PiBUaGUgZm9sbG93aW5nIGNvbW1pdCBoYXMgYmVlbiBtZXJnZWQgaW50byB0aGUgcmFzL2NvcmUg
YnJhbmNoIG9mIHRpcDoNCj4NCj4gQ29tbWl0LUlEOiAgICAgMWY2OGNlMmEwMjcyNTBhZWViMTc1
NjM5MTExMGNkYzRkYzk3Yzc5Nw0KPiBHaXR3ZWI6ICAgICAgICBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3RpcC8xZjY4Y2UyYTAyNzI1MGFlZWIxNzU2MzkxMTEwY2RjNGRjOTdjNzk3DQo+IEF1dGhv
cjogICAgICAgIFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gQXV0aG9yRGF0ZTog
ICAgV2VkLCAxNSBOb3YgMjAyMyAxMTo1NDo1MCAtMDg6MDANCj4gQ29tbWl0dGVyOiAgICAgQm9y
aXNsYXYgUGV0a292IChBTUQpIDxicEBhbGllbjguZGU+DQo+IENvbW1pdHRlckRhdGU6IEZyaSwg
MTUgRGVjIDIwMjMgMTQ6NTM6NDIgKzAxOjAwDQoNCkVhcmx5IFgtTWFzIHByZXNlbnQgZm9yIG1l
ISAgVGhhbmtzIEJvcmlzLg0KDQotVG9ueQ0K

