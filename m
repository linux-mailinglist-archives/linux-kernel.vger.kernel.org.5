Return-Path: <linux-kernel+bounces-58335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B421E84E4CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5FA28BE59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977FC7E578;
	Thu,  8 Feb 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="PpG4HieA"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2056.outbound.protection.outlook.com [40.107.241.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73147D3ED;
	Thu,  8 Feb 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707408904; cv=fail; b=uuIg68uevWsA2dEXgx9qgkWy0jOa6XkMskD1Ju18t2gukvzssGUIZyYBeU4uhTMjiraz81dhm66g4WsGzAIqrEND6/LGnLUzeRzKSE/4jLnmHAfBU/TVxR5QTbhjX885wJZ4DzClLIIuvfGZF9QAF9wIVbi2ZU4/vksuiy+XWxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707408904; c=relaxed/simple;
	bh=k0qdJD79PBD3ovf9rULG+MKLqZKSwPOjbtm8FcWNVlQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i2loJmIlkQCQ/C7LI6I6BqILkhp73BeJsiFJIOxgLv8B+CjzcwKajL1l9gGmnArE0RGJYonlEQmzp57v04Xqb3RzVhKCPpbYkQJr6/N+SzjgYUiY3RdJFAcToK0fn/TnWhrYmH49zjRrmMQBtIErCQK9vCrcTk/+qgP3iHn0MFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=PpG4HieA; arc=fail smtp.client-ip=40.107.241.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lInaDwjCKoa4ZaxzgGCceJCG4T+DmS7RJZu6vFICzy5PswdwRbt5wF71oYN/BRFQSSBCvExYbnJG5vykSEfYedP9MR1/ivj37kRcHq7dQ44IWpKqUI1JklagsJopgLP0LhhXCb2MtvZxjRce6bl1nKRUsieITGvoVJ6tVVJGAVJfcnofeA4YwvFebP/26FWBRQY56AEYKubgBvDXuQAglcFhmNfcC24G6t6jh7ujcSiLUvOXrn3PoEWFse7SwOTYzXBKP0DKsIqW2cFO+ARY1QRkf/EBM6iQa7AyYNPjMBlBDE03WIT63BViRj395PtIHQDbwdccuj6lXbQ1YPbueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0qdJD79PBD3ovf9rULG+MKLqZKSwPOjbtm8FcWNVlQ=;
 b=hymCc3vwNyXkyUn+ZgcTBGl+1KBia3ccobZj6UG8VZIQkZWQjs7A48GFSGSsMAfL/TLp7bCpy9Lu5z3L0AX2ZWoPD7jTLnLs9RuPk0KPTXS9mVTqUNaETLU27Ij8X7JSdzbAGXijXABxEmn0Tqiu2yjve4v6m0CDpkeLjh3MuYInwo6PyJtBTrHuS6+ZPvn+XVGswnzT46PXgIiMNmb8GakO7JanhYcGL7d1j8zZBHbIjBbdfAWW1zPxoWfAQoSy6fXf+5K9NiNIzHwQOkzjmu6wQneOLYmThXP5NBqVasqNh5AbdoUi09SxFRF2sVVDMHTZ3AmXi6GQr7Nz5SOiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0qdJD79PBD3ovf9rULG+MKLqZKSwPOjbtm8FcWNVlQ=;
 b=PpG4HieANj3n9H5V2D9UPLdb0pF3hR/ueiURgTKDRDOGQB17zBD6rg634StkEdHl87ApwGYbSTnIn9ONPESJq5wKRQ7tRDB8ro+dADoQmix2N3iDYqOwlVFpuM18iCbnAUluB21nJJEOsk9JzPWEPeLOyagt9q7kslW1SxJ2aYY=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by DBAPR06MB6870.eurprd06.prod.outlook.com (2603:10a6:10:1b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41; Thu, 8 Feb
 2024 16:14:59 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 16:14:58 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Topic: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Index: AQHaWe9Wo7eR3DxLokuTFbBUDe4Vo7D/NRCAgADw8ACAAFNggIAAJqwA
Date: Thu, 8 Feb 2024 16:14:58 +0000
Message-ID: <68f0b7ce-6c77-41b2-9749-1cd8f72c253d@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
 <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
 <f37e9df4-e1bd-4d40-bd99-3998cfd803f4@leica-geosystems.com>
 <145e1c28-af2b-4aca-9fd3-f9d7a272516c@lunn.ch>
In-Reply-To: <145e1c28-af2b-4aca-9fd3-f9d7a272516c@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|DBAPR06MB6870:EE_
x-ms-office365-filtering-correlation-id: a02d918f-bf37-4bbe-1a61-08dc28c118c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c8Tc60Rp1m8ohJyphSfbE/6l9ejY1igiYClxgF6QuZtyw3RWzzMVlH3Zd0hI3Qihg32GqzzbYy/szTfM+b+DffJsswG7jl/nD4hM+mt32kZUvjWdGm3ixGSHeJEEUUyEUdOYdfxIjldr5gdHijxy+JOqQqIvuzFJLyReOzyOTrLFBfKY9T0OpnyjXw6RVzFj9yEBfXWz1K2mp1DVoFwvSm/CNMs1gpYKZ8Vq9KPCzbNAYyAn6nL9Cpv/Lz9NJi4/L4WbyHjsIdxG61Kbyoacayi9Hbxay10/4idWzIecx7HvY18Pi4VpwhjNceBdPgEsb3aR+gtLQGvHiIKIDggAWKtTX0JKvrz5uAuk1DtHPG7WChwkkAliorxp/EKPdd162eTS7xnuJqqLrhMgXG7XBGPZ19vMnezwPzJ8fug49F7gmTa/YxJqm3bnKDl3Hw5XtAZyzhGk5+kSXdbiGoI/T+jxS6YWSo5/9iAFBRhXyQmG3CtP5nsQ27YQ+u76VayhNFQ8dVdX+vfyOm2nl1LEi6N7yBhIAfFh4CoSOOoBUVXSLlbDjg4D7dzCb0WvRQ91JDB0iW3DJXwbCuAi2rbKWrfQNsjPF59wlay2mdTl/Pr09oV86P4yX4SmB0mI7mBd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(41300700001)(53546011)(6506007)(71200400001)(45080400002)(6486002)(478600001)(966005)(6512007)(5660300002)(66946007)(76116006)(66556008)(7416002)(2906002)(2616005)(26005)(36756003)(91956017)(38070700009)(83380400001)(38100700002)(86362001)(6916009)(31696002)(66446008)(64756008)(4326008)(8936002)(316002)(54906003)(66476007)(8676002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFhKNHVWVnUrdWhNb1NDZFJ1U2N3RmR5cGpFdm1CeFdDb2dYQ2N2R3ZUUEwr?=
 =?utf-8?B?emU0NDZmRDJWemVWVkFMVHdQYVVJTlg5SG9aVjFlSmRBUk8zT0lFOEdXMXBn?=
 =?utf-8?B?UzYwMExRb09IQ2M1eldlUUhoUnQzREpHNmZtcG5jbk9qVkcyVDV1eHJsL0hx?=
 =?utf-8?B?MldmZXNzQjRocy80YzB4SitNWE5uTG1oMzNIa1NnU200QjlLZGp0d1lzUzdZ?=
 =?utf-8?B?cUQyWDN3WklydGc0Smpvd3FaNHp6YmxvR1Y2ZmpnUzJqOER3KzdVcnJKY1pl?=
 =?utf-8?B?RVFwSUtHTEMvck5SaDRuRmFlMU0vU1E0Q2cvakVLQWFwL3JMM01nMnRFcDJh?=
 =?utf-8?B?RXdnUEdIRStTOHNRUFp6N0xHKy9ZSUZxaHVOWHErTTN1dGRUK0hNOGxPZmwx?=
 =?utf-8?B?eVNZTEhUemxCVklhYUF3WnIwZXBjRENEdS9iaHNaYVVsaitrVEM2TUpQTUQw?=
 =?utf-8?B?dEFFQWtmb1RmcjI5ZGVSNVI2L1duV0R6dDNpcEJxMlZVa2N2ZklTOFRPYXVC?=
 =?utf-8?B?bDQ4VTZ5TE5zcEZCUWEya1IrQ2FiMlRTTTkyNVgwSWtjWDErNmMycEY5VVJE?=
 =?utf-8?B?bFBNdUV6cHdXN21NSXhrc0NOSjB0TGg3WDhtNUxvd0xhWlQ4VVZoYmxHVEtm?=
 =?utf-8?B?SSsxTERPVmMzbnFncU95ZUJlQVdmYmExZklFZ2Z3cElUbThYYS9xeHJHWEMr?=
 =?utf-8?B?QTlwU0FWaU5jWVB6b3FmYnlxbnAwdkRqejhuNVcyV29pMUtxSTZhL3djNnpp?=
 =?utf-8?B?SjBpaXdHbGJ5amVMVXREaXJjd2pzYStGak5uWUl2L0VHMGlkbldtRHZFZSsr?=
 =?utf-8?B?TzIzY0E4Y3prWnpiR2h3WExYZ0hTMisvclQ2QXl4YVArVURFS24rdERMS0dx?=
 =?utf-8?B?TDNwd1pOUTlYN1ZKRWJIcTMwdG4wbW9GK2lxdjFvajNIeXdKc0k2OEU3TWxS?=
 =?utf-8?B?Z3NQL25DUy8rWm04SU5KeEs3cmdHaVhPUzJ4STlrSFQ5WHBiMEFqTGhEQlNx?=
 =?utf-8?B?UTFPNkxHcFlJMWY3SGlzNGxVWmdreSs0aXNnc2lsZDljNGMyNjF4U3g4YVFW?=
 =?utf-8?B?WVI5QzRDazFHQWt1VUNhbFFBRE44Z3dwaFVpN2F0N3ZsWjVkdEJITXFDZGhX?=
 =?utf-8?B?RTdIajM1aWZDUWF2U1ZISlZEdC9ZS2cxSWx2UTc4RVBZS2FlWW14RTFTWVVS?=
 =?utf-8?B?UFRCWk0zMGhyVG4rbW5nejdGQmQ5eUJzejErdU0rNVBKc3ZKZXU2cXFUYzFz?=
 =?utf-8?B?RVhYbHppMk1MOW9la2dYNG9BZjFIRlpCc0Rlak1ndmE4SDNPYmw3M29EZlM0?=
 =?utf-8?B?eGYyRDgvZnBFUWtsZy81ZHhWN1YrYjlvMjZWZ2pQUWFKMzdmbmdRbnVsSCsx?=
 =?utf-8?B?RU1YUmVIdDlXazlrelpPcUxmSEFJTE5JVG9NMm1jemhqeVZSeFpkajdZamE4?=
 =?utf-8?B?ZVUxZDYxaE5aRmtidFRaZDRJYUV4Z3p2Q0Qwd0dLckszTC94V1Z0TXpycjJs?=
 =?utf-8?B?MDRFWFFlQVhHMG43YTgxOEZadktac3I4RE83cHVJb0NmN0NlSVdGL1hJNU10?=
 =?utf-8?B?N25rL1U4RUZ6TlFqN295NnFKR3FDWHFuazlNQlFSMHFFclA4QlVUWHAwVkZl?=
 =?utf-8?B?ZEhhYW1lQjdFalhFN2JqdW4rZzlyYTBTQ0cwOTM0U05DZkJWbU9lc2Via0lE?=
 =?utf-8?B?TFYvRVhGWllDUEFkUnVUZ0luNStpc2VvUk52L0FnOW1xVGozR3ZWamdrSlEx?=
 =?utf-8?B?OTVFK2dyNU00Q3hYR3VOMldEd2xpYi9MckVaUVhYMTZaU2U4UC9XeUJZbnNj?=
 =?utf-8?B?UkhIelRSd0RUWTM4Z2o4bXF1WHNsWHVqdVhML0V6dHdMTkxIZ0xwMFh4ZzJS?=
 =?utf-8?B?dTdyc3JzL1AwdldETTFZV0V0WjZwb2tjNlNXakRUVzBlZjVKWnpURjdmeURB?=
 =?utf-8?B?RUVJYk1qMnZscnV1VGgyMFFhUkJiVEYwaUFPNVVxaHZ6TzB6c3RtSHJvenNz?=
 =?utf-8?B?N2MxK1phRzNKc0FWTUNMeGVVVnNCaUEyR0lHQ2dmbG0xd1hXT3J6Y2t3ZTBs?=
 =?utf-8?B?UTBYOUt5b3U0cDlNcTZoUG0wZjJ1OXZzbzRJQWVKbzVheGsrRE1KUytBZVRv?=
 =?utf-8?B?Y1dHNjdFa0dPUC9aWXZieDRqSnFZeHZ6a3Yxd1dKcy9GK29vUXpaN0IvMUk4?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C11C9883B71AC9409D345A058E4732CA@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4705.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02d918f-bf37-4bbe-1a61-08dc28c118c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 16:14:58.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QkHsbaEQmMjlu+E0p+lunx8GqbyJ4Tas0oUiJzl15l/Mzl21x2/bsyFT6YseIV5HMI7PCTZDbPWYTvIdCgjrn/MMSh0fK0Mgh/YOnODdGojGD/quvXBzy5WmNIcHHF6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6870

U2luY2UgbXkgcHJldmlvdXMgbWVzc2FnZSBoYXMgYmVlbiByZWplY3RlZCBkdWUgdG8gSFRNTCBj
b250ZW50LCBJJ20gDQpyZXNlbmRpbmcgaXQuIFNvcnJ5LCBmb3IgdGhlIGluY29udmVuaWVuY2Uu
DQoNCk9uIDA4LjAyLjI0IDE0OjU2LCBBbmRyZXcgTHVubiB3cm90ZToNCj4gW1NvbWUgcGVvcGxl
IHdobyByZWNlaXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20gYW5k
cmV3QGx1bm4uY2guIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5t
cy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBUaGlzIGVtYWlsIGlzIG5v
dCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJlZnVs
IHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWluZyB0
byB0aGlzIGVtYWlsLg0KPg0KPg0KPj4+IEkgY291bGQgYmUgcmVhZGluZyB0aGlzIHdyb25nLCBi
dXQgaXQgbG9va3MgbGlrZQ0KPj4+IERQODM4MjZfQ0ZHX0RBQ19NSU5VU19ERUZBVUxUIGFjdHVh
bGx5IG1lYW5zIGxlYXZlIHRoZSB2YWx1ZQ0KPj4+IHVuY2hhbmdlZD8gSXMgdGhlcmUgYW55dGhp
bmcgZ3VhcmFudGVlaW5nIGl0IGRvZXMgaW4gZmFjdCBoYXZlIHRoZQ0KPj4+IGRlZmF1bHQgdmFs
dWUgaW4gdGhlIGhhcmR3YXJlPw0KPj4+DQo+Pj4gICAgICAgICAgIEFuZHJldw0KPj4gWWVzLCB0
aGUgZGF0YXNoZWV0IGNsZWFybHkgc3RhdGVzIHRoZSBkZWZhdWx0L3Jlc2V0IHZhbHVlcyBvZiBi
b3RoDQo+PiByZWdpc3RlcnMgVk9EX0NGRzEgJiBWT0RfQ0ZHMiB3aGljaCBhcmUgOg0KPj4gLSBj
ZmdfZGFjX21pbnVzIDogMzBoDQo+PiAtIGNmZ19kYWNfcGx1cyA6IDEwaA0KPiBBbmQgdGhlIGRl
dmljZSBpcyBhY3R1YWxseSBhbmQgYWx3YXlzIHJlc2V0IGJ5IExpbnV4IHdoZW4gdGhlIGRyaXZl
cg0KPiBsb2Fkcz8gQW55dGhpbmcgdGhlIGJvb3Rsb2FkZXIgaGFzIGRvbmUsIG9yIGEgcHJldmlv
dXMga2VybmVsLCB3aWxsIGJlDQo+IGNsZWFyZWQ/DQpOb3csIEkgdW5kZXJzdGFuZCB5b3VyIHF1
ZXN0aW9uIPCfmYINClRvIGFuc3dlciwgRFA4MzgyNl9DRkdfREFDX01JTlVTX0RFRkFVTFQgd2ls
bCBpbmRlZWQgbGVhdmUgdGhlIHJlZ2lzdGVyIA0KdW5jaGFuZ2VkLiBIb3dldmVyLCBkcDgzODIy
IGRyaXZlciBleHBvcnRzIGEgUEhZIGNhbGxiYWNrIHNvZnRfcmVzZXQgDQp3aGljaCBkb2VzIGEg
U1cgcmVzZXQgd2hpY2ggYWN0dWFsbHkgaGFzIHRoZSBzYW1lIGVmZmVjdCBhcyB0aGUgSFcgcmVz
ZXQgDQpwaW4gYWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQuIFNpbmNlIHRoZSBQQUwgZW5mb3Jj
ZXMgdGhlIGNhbGwgdG8gDQpzb2Z0X3Jlc2V0IGJlZm9yZSBjb25maWdfaW5pdCwgaW4gZHA4Mzgy
Nl9jb25maWdfaW5pdCB3ZSBjYW4gcmVseSBvbiB0aGUgDQpyZWdpc3RlcnMgcmVzZXQgdmFsdWUu
DQo+IFBsZWFzZSBhZGQgdGhpcyBleHBsYW5hdGlvbiB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+
DQo+IEknbSBiZWluZyBwZWRhbnRpYyBiZWNhdXNlIHdlIGhhdmUgaGFkIHByb2JsZW1zIGxpa2Ug
dGhpcyBpbiB0aGUgcGFzdC4NCj4gSWYgYSByZWdpc3RlciB3YXMgbm90IGFjdHVhbGx5IHNldCBi
YWNrIHRvIHRoZSBkZWZhdWx0IHZhbHVlLCB0aGUNCj4gYm9vdGxvYWRlciBzZXQgaXQgdG8gc29t
ZSBvdGhlciB2YWx1ZSwgdGhlIGJvYXJkIGNhbiB3b3JrIGZpbmUuIFRoZW4gYQ0KPiBib2FyZCBj
YW4gY2FtZSBhbG9uZyB3aGljaCB0aGUgYm9vdGxvYWRlciBzZXQgdGhlIHdyb25nIHZhbHVlLCBh
bmQgdGhlDQo+IGRlZmF1bHQgaXMgYWN0dWFsbHkgbmVlZGVkLiBGaXhpbmcgdGhlIGRyaXZlciB0
byBhY3R1YWxseSBlbmZvcmNlIHRoZQ0KPiBkZWZhdWx0IGJyZWFrcyBib2FyZHMuLi4NCj4NCj4g
ICAgICAgICAgIEFuZHJldw0KDQoNCg==

