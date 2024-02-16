Return-Path: <linux-kernel+bounces-67954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DE85738B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B55286013
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDEDDC9;
	Fri, 16 Feb 2024 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gAilp9JJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548E9149DE2;
	Fri, 16 Feb 2024 01:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708048137; cv=fail; b=sNgGoItGll5ANiWIl9pJi64MTXtXNcrLcGwLmMMuS0eBxmZoOkH0cxXqiX1jPrP4A0lHTHMrSw9AJ4DEc8YfzT9lYSn9X1DuRVP0ITTccs0tVo7UoqC5IKfiCgMgT5fBv/aBFt7ITQMZ2Llo6aLY1Hjx72th8/0MtIOGh9c/63I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708048137; c=relaxed/simple;
	bh=HQBRHdaUE1cKEQZXytH2Hf6uy8f64hpt+Ogcprhin/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipNN02HiGSE9qDdbW955inU10iAunXfCZanW2j7/wuwXGec2QzrHMmCNAr5+QJuuXL/MEcSIK4WE7QudbXJuimpH8yZHEkQ8qtGE6o/YIKbFoutlBFlpleE5USWIhIpP6WrUYA4XIw4zI1peMf4JD4d3ZmFAIEorkUzOfZthts0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gAilp9JJ; arc=fail smtp.client-ip=40.107.8.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXSYe164HNfFXbfss9FpTtgQwTWjITlVAi4+iztsGsa9CeCVJx7aY8Pq2mK6NZN8j61b5EIjkDmmJVxyJR6hymo0PjbGfMKG6HtQxu40iPg/Mh0sno3naFezLYSSlNX7q7xhH8CADuzviaGw+/3sucD9SrPpxFnfyeiw4WPhs5djUCUdTNby9mu4eLgiDsagAEq4udKquPkSV442A5DD8uZst/jCGVbknr+KRMb03SLmBZy8XMuwb1fxTj8Xg4skfXYqNMg94kdOmSmNHJoIrHG6ZKigGnWBWxgalJflPQoipLEo1q5Uf6ya94HOU4CgVBVNna3bJbiQccPAEvLsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQBRHdaUE1cKEQZXytH2Hf6uy8f64hpt+Ogcprhin/s=;
 b=R+141zggMBS1SIJ4RWd1hoddOj1HDWzHsGlwjLPXknKqEmifBaRM4Jgf9wRIQXdwxINTBRRUxAsPEpsp+RdLfYSdbPJvEVRQG+kM4bhvLs7B/rx5MSYclXz/VwB3dp0h48mwx4OYaoLTyDN6VFT4HPwKl3leH4aE5VGXmarVypGU9tKVhl7IcIGmUwuB8/cnEBv+MDuT4wGuVaPl3NgT63H9/uMd941p+WwV42plHbbiWRU8nLSfrEq0mPlmbwhbwIPheBMOGXAPT/vAMOq34s2U/I5tOtjIeLZKCk8B4C50LU24+TAi16vN35h88Aapyb6vM1Cwo6TOx/od/Zw/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQBRHdaUE1cKEQZXytH2Hf6uy8f64hpt+Ogcprhin/s=;
 b=gAilp9JJtIgsJRfTBtXR/r/E7T0StSSJq5UmXYatGTnSyTss4wN0yG/GK0WxGL5sN9h6tHiD39BTMVxddI7eJo8yswncymdE4REXQHclwogQ6Y89CG2kQmrL22yugu1xYmUD033/KU/PI26hqhhlCktDPG8rxorpODJHRvYow+Y=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM9PR04MB8601.eurprd04.prod.outlook.com (2603:10a6:20b:438::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 16 Feb
 2024 01:48:51 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::4a4b:c89a:2ee2:ffb3%5]) with mapi id 15.20.7270.033; Fri, 16 Feb 2024
 01:48:51 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Rafael Beims <rafael@beims.me>, Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>, "kvalo@kernel.org"
	<kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHaSjEAO+HQnD/Ih0ixtnf/7VSxSLDyBCEwgA2BHICAAKZRgIAKoyiggACtD4CAAOEa0IAAAr8Q
Date: Fri, 16 Feb 2024 01:48:51 +0000
Message-ID:
 <PA4PR04MB963887774FBAF4E2E022C552D14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
 <PA4PR04MB963849A7E04ADEE5DE92002DD14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To:
 <PA4PR04MB963849A7E04ADEE5DE92002DD14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM9PR04MB8601:EE_
x-ms-office365-filtering-correlation-id: 1c8a45bc-5817-4e85-dc03-08dc2e916d1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7t3MjVBppelH8DVInZTZUhQBy+4XKis+RcAgTOsC8+xyMTwEkKdy/xaa9GC8Q+gWbWjepWxlD1Lu1QkcgHNJIZfWFBU12C8HlbNlUfhp2UqQkaMOt1qu8t5h8IAlKmxNf/HXfCTfiVv0olZZhIkGysGPBQt9RYQJGoNG/d+E+bRPitYFnhOwSOZjfdK/7M3O/l/tV8TGde5dic27Xf8p8QqmPXAPRLEssbJeAwwaOf3/ZsZnScydNg0tjqIU+mzuL+I99jaF9oFbfU94yHHVNXmmYp4VuNzdmcl+2bbqQ8bftHJwbV/J6yYtqxC8GjRJXUG7j7QiOg70A32P6HN2Lu/fsuSUCm8Dv82qazAQK93JbOujnlgWFnRRyP/ve8NtHQY5I1u8zlWOJdHNJaaMbM8tbdcOyw0uTj2824N6BJRUFWiapYEirfZ/oRgIdL4Zz/Q80lDIvO5UxWI42F+4L9OzZ0yrPO3Wzjl+T4uUwyFKbZpWBHByIIErkgQVero2mdWrVYhImOqK3P4EeVCK5y4iBVHAW/jlnLRZGXGPZ06KJ60xFhupUMfiXR7viIltbWSIEX6wF23pU+Eaa6kjvtz+DAR+MPv9ZK6UBRfnW94=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(966005)(38100700002)(122000001)(6506007)(86362001)(55016003)(41300700001)(64756008)(66946007)(66446008)(2906002)(2940100002)(478600001)(66476007)(71200400001)(54906003)(53546011)(26005)(9686003)(7696005)(83380400001)(5660300002)(38070700009)(8936002)(110136005)(33656002)(316002)(76116006)(66556008)(4326008)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXZBblZSaDZObHN5Ry8vOEEyWUs1VjdZd2Juc2xBWThoSkxIcjBrc1kyUHJ4?=
 =?utf-8?B?empGUTZZd2R2eTBnQkRNM0RJQisyMG9jT21UN0N5M2dobWFOMmgrMzBmanpO?=
 =?utf-8?B?Mi90V2owalV1T0lvZkIyYnJoc3ZqY20wUm5qKzJYaEZwVG1lb2NYeWtZaEVD?=
 =?utf-8?B?Y3U0NFJ2M2JKMXZwZUdSUnZyNDhKdkcvRm9ZTk1iaGVvdXo0ZFdldFc2MjIz?=
 =?utf-8?B?YTFnNDVMRjR4QXE4YkpXS21BcVU3SnNwYVlSRmhNV1c1Zm9MMFNTWnNGYy9o?=
 =?utf-8?B?WmVuaEQ2aktEdnJBMllubk9pNkcxaVpENGF2c20yZVdmcjJxV2tRWks4Z3cz?=
 =?utf-8?B?Y3IyUTBUalQvYm5hRTM2UXR4TTI3N1dUUERrSlV0YStmNXRuNEE1Q3dZYWE4?=
 =?utf-8?B?M0ZSVUlvTjloREJCMHF6WUtISnB5Q1pRZHVITytHZkRKSVRrK2dKTGdSUmx2?=
 =?utf-8?B?N1RvZ0lNL1hzK2ZRZlZCL3p6N3BMYUtZdlFRc3Y3OFE4TDMzR2hOcXVUdWJY?=
 =?utf-8?B?VU1SWnMrRWkrS0c0dXEzUTM2eVR6L29zeEQrTTQ4WFhITU1FN2ZpTmlTaXN2?=
 =?utf-8?B?Q1hPRVJrRmpPZ1lER0hzRTVPZUY1R3ErSWZBOWFFdFNmcDlzcUMrNE9lblo5?=
 =?utf-8?B?VmdERDJ5OHBCd1JvazA2c252N2tjeU10VTZFYUlRQ2xTU0o0STc5eTBqSFB2?=
 =?utf-8?B?bHIxcFdnd21zVUozWnhOWEZIc3l4Q2gwTEw1cytRTkQya0dSWFpvZmJxWWRL?=
 =?utf-8?B?MEZNaGVNMThsR2hZTXhHdFJoR0Y3WlRHaGJPKzNJRGR1ZkZYeVIvWldOS1JO?=
 =?utf-8?B?YU9DeWhkRTFWY2U1N2RjK3dlcThmNFRRWldmSVNEU2pscnhOUi9pVTQ4VE8r?=
 =?utf-8?B?SHF0YWozT2wwemRSdjczV1dHOUdqM3J0V0E2K1E5NDdndWV0ZVFlTWVkekNX?=
 =?utf-8?B?dFJHODdYdkErV1JLZmxmaUhrd3lBYkM3MEcwU052L29KR3BuSDljeUVKY1M4?=
 =?utf-8?B?TkRUd0ZxTlMvQ2ZyT0tUU0hhTXp1a0FlcGJ0TmJEa29RMkdkTTZLOTVxZThP?=
 =?utf-8?B?dTQxODVYeE9WbnV6dnpBWnZtcHRTMWxteDdsaVlSNFNwdzJSODBnNytkbktL?=
 =?utf-8?B?MG93ZEpiaElDSHoxYjRzRVoxWGg1VnBBZjI1bWZZRVd2TE94Z3Zvd0EwczJL?=
 =?utf-8?B?eFNLYmtUZnlQMDcwS0VDVDhJNUpNVGVxWW8rV1BzOEJMVzh2eGFkbjJGMXRV?=
 =?utf-8?B?TlBPMjRYRm04elNaVlcya3M3NURCU1BmM200c3JGUlVDUG9xL254TW11VGR2?=
 =?utf-8?B?L0JJYmVMZXdPbHJzZUR0M0hURE5oMVFwbEo3K2RnQUo2QjI2Mmk1NVZSZXJH?=
 =?utf-8?B?VXgzSnEzNjBybHlyUVBUTDRhZi9zNm9Dak80NFpQM2ZTcFhSNmhhYTMrYnFh?=
 =?utf-8?B?VjBwUmMycVVZK1BjaklKNEV0Q1pOOUgyKzNnQkx4aEFKT3pzNWlaeW1ObkM2?=
 =?utf-8?B?MmUrU0loSTFQNXcrRVlYTDU5M1hHc2tKeEFoY0lUek5iNENKbGpTc09QMnEy?=
 =?utf-8?B?NjJ2M2dyRDlCK0Nza3ErbnByY2Y0dXJtYXEwVWRESGdVbXpielBSQnJucU1O?=
 =?utf-8?B?K3VDZmo4MTBOWWdLWUgyS2I0a29BM2FnOG1Jcy9sRlVtS2NYRHZpOW1FYklQ?=
 =?utf-8?B?aUIvdmpUaHcvV0RtUDFZQXdTcDU3NmFQZ09xQjN2WGlGbUY3VWgwMDBhd2th?=
 =?utf-8?B?TE9keUVrV0xnSjFuTVpFb3pGMC90UXhjTXcrY0RETCsxczJjanNoQXFXRDVu?=
 =?utf-8?B?REFxRUtpN0xNMm51d2xNdFhwZDJSOXVvdUVvMGpYSitGU1QyM0dVeDFMOTZi?=
 =?utf-8?B?SlBIWjllMUloMHBrcVQrcmtEdC9EZ0lxNDZjRWI0bHQxZ2doOXMzSmE1Mk14?=
 =?utf-8?B?ZVhaejN5MHpMcmxzNXFvVU5kdS9QclZtMTBoamhzZThPY3EwRDJpa0dTZlVX?=
 =?utf-8?B?bm12VnArNlBZSCtIVFF2SUtnSUk1Nm9zeTBKNzRBckIvcHV1SS8xZjQvSDlo?=
 =?utf-8?B?bDFZK0JqSlVWUGZyL0JwZHExSjkvTVBETHNHSkY0RTJ5T3g2NHNZYndtWGV4?=
 =?utf-8?Q?LkdjYSPR7KsTDZQtb86/EHdcE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8a45bc-5817-4e85-dc03-08dc2e916d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 01:48:51.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEiK/AZ/NBDA8bZpVV/KK+KOhvi1XlFMkTNYvD5NaAZj2uzb79HplyILIa4wQX5dPMLa9ndSe/GprAK3WLJOkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8601

PiBGcm9tOiBEYXZpZCBMaW4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxNiwgMjAyNCA5OjQx
IEFNDQo+IFRvOiBSYWZhZWwgQmVpbXMgPHJhZmFlbEBiZWltcy5tZT47IEZyYW5jZXNjbyBEb2xj
aW5pDQo+IDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYnJpYW5ub3JyaXNA
Y2hyb21pdW0ub3JnOyBrdmFsb0BrZXJuZWwub3JnOyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2ll
bi5oc2llaEBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW0VYVF0gUmU6IFtQQVRDSCB2OCAwLzJd
IHdpZmk6IG13aWZpZXg6IGFkZCBjb2RlIHRvIHN1cHBvcnQgaG9zdA0KPiBtbG1lDQo+IA0KPiA+
IEZyb206IFJhZmFlbCBCZWltcyA8cmFmYWVsQGJlaW1zLm1lPg0KPiA+IFNlbnQ6IFRodXJzZGF5
LCBGZWJydWFyeSAxNSwgMjAyNCA4OjExIFBNDQo+ID4gVG86IERhdmlkIExpbiA8eXUtaGFvLmxp
bkBueHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPiA8ZnJhbmNlc2NvQGRvbGNpbmkuaXQ+
DQo+ID4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gPiBicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc7IGt2YWxvQGtlcm5l
bC5vcmc7IFBldGUgSHNpZWgNCj4gPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT4NCj4gPiBT
dWJqZWN0OiBSZTogW0VYVF0gUmU6IFtQQVRDSCB2OCAwLzJdIHdpZmk6IG13aWZpZXg6IGFkZCBj
b2RlIHRvDQo+ID4gc3VwcG9ydCBob3N0IG1sbWUNCj4gPg0KPiA+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZw0KPiA+IGxp
bmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVz
c2FnZSB1c2luZw0KPiA+IHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiA+DQo+ID4N
Cj4gPiBPbiAxNC8wMi8yMDI0IDIzOjA3LCBEYXZpZCBMaW4gd3JvdGU6DQo+ID4gPj4gRnJvbTog
RnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pg0KPiA+ID4+IFNlbnQ6IFRo
dXJzZGF5LCBGZWJydWFyeSA4LCAyMDI0IDM6MjUgUE0NCj4gPiA+PiBUbzogUmFmYWVsIEJlaW1z
IDxyYWZhZWxAYmVpbXMubWU+DQo+ID4gPj4gQ2M6IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAu
Y29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGJyaWFubm9ycmlzQGNocm9taXVtLm9yZzsNCj4gPiA+PiBrdmFs
b0BrZXJuZWwub3JnOyBmcmFuY2VzY29AZG9sY2luaS5pdDsgUGV0ZSBIc2llaA0KPiA+ID4+IDx0
c3VuZy1oc2llbi5oc2llaEBueHAuY29tPg0KPiA+ID4+IFN1YmplY3Q6IFJlOiBbRVhUXSBSZTog
W1BBVENIIHY4IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8NCj4gPiA+PiBzdXBwb3J0
IGhvc3QgbWxtZQ0KPiA+ID4+DQo+ID4gPj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nDQo+ID4gPj4gbGlua3Mgb3Igb3Bl
bmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlDQo+ID4g
Pj4gdXNpbmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+ID4gPj4NCj4gPiA+Pg0K
PiA+ID4+IE9uIFdlZCwgRmViIDA3LCAyMDI0IGF0IDA2OjMwOjAzUE0gLTAzMDAsIFJhZmFlbCBC
ZWltcyB3cm90ZToNCj4gPiA+Pj4gT24gMzAvMDEvMjAyNCAwNDoxOSwgRGF2aWQgTGluIHdyb3Rl
Og0KPiA+ID4+Pj4+IEZyb206IFJhZmFlbCBCZWltcyA8cmFmYWVsQGJlaW1zLm1lPiBPbiAyMi8x
Mi8yMDIzIDAwOjIxLCBEYXZpZA0KPiA+ID4+Pj4+IExpbiB3cm90ZToNCj4gPiA+Pj4+Pj4gVGhp
cyBzZXJpZXMgYWRkIGhvc3QgYmFzZWQgTUxNRSBzdXBwb3J0IHRvIHRoZSBtd2lmaWV4IGRyaXZl
ciwNCj4gPiA+Pj4+Pj4gdGhpcyBlbmFibGVzIFdQQTMgc3VwcG9ydCBpbiBib3RoIGNsaWVudCBh
bmQgQVAgbW9kZS4NCj4gPiA+Pj4+Pj4gVG8gZW5hYmxlIFdQQTMsIGEgZmlybXdhcmUgd2l0aCBj
b3JyZXNwb25kaW5nIFYyIEtleSBBUEkNCj4gPiA+Pj4+Pj4gc3VwcG9ydCBpcyByZXF1aXJlZC4N
Cj4gPiA+Pj4+Pj4gVGhlIGZlYXR1cmUgaXMgY3VycmVudGx5IG9ubHkgZW5hYmxlZCBvbiBOWFAg
SVc0MTYgKFNEODk3OCksDQo+ID4gPj4+Pj4+IGFuZCBpdCB3YXMgaW50ZXJuYWxseSB2YWxpZGF0
ZWQgYnkgdGhlIE5YUCBRQSB0ZWFtLiBPdGhlciBOWFANCj4gPiA+Pj4+Pj4gV2ktRmkgY2hpcHMg
c3VwcG9ydGVkIGluIGN1cnJlbnQgbXdpZmlleCBhcmUgbm90IGFmZmVjdGVkIGJ5IHRoaXMNCj4g
Y2hhbmdlLg0KPiA+ID4+IC4uLg0KPiA+ID4+DQo+ID4gPj4+Pj4+IERhdmlkIExpbiAoMik6DQo+
ID4gPj4+Pj4+ICAgICAgd2lmaTogbXdpZmlleDogYWRkIGhvc3QgbWxtZSBmb3IgY2xpZW50IG1v
ZGUNCj4gPiA+Pj4+Pj4gICAgICB3aWZpOiBtd2lmaWV4OiBhZGQgaG9zdCBtbG1lIGZvciBBUCBt
b2RlDQo+ID4gPj4gLi4uDQo+ID4gPj4NCj4gPiA+Pj4+PiBJIGFwcGxpZWQgdGhlIHR3byBjb21t
aXRzIG9mIHRoaXMgc2VyaWVzIG9uIHRvcCBvZiB2Ni43IGJ1dA0KPiA+ID4+Pj4+IHVuZm9ydHVu
YXRlbHkgdGhlIEFQIGlzIGZhaWxpbmcgdG8gc3RhcnQgd2l0aCB0aGUgcGF0Y2hlcy4gSSBnZXQN
Cj4gPiA+Pj4+PiB0aGlzIG91dHB1dCBmcm9tICJob3N0YXBkIC1kIiAocnVubmluZyBvbiBhIFZl
cmRpbiBBTTYyIHdpdGggSVc0MTYpOg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gbmw4MDIxMToga2Vy
bmVsIHJlcG9ydHM6IE1hdGNoIGFscmVhZHkgY29uZmlndXJlZA0KPiA+ID4+Pj4+IG5sODAyMTE6
IFJlZ2lzdGVyIGZyYW1lIGNvbW1hbmQgZmFpbGVkICh0eXBlPTE3Nik6IHJldD0tMTE0DQo+ID4g
Pj4+Pj4gKE9wZXJhdGlvbiBhbHJlYWR5IGluIHByb2dyZXNzKQ0KPiA+ID4+Pj4+IG5sODAyMTE6
IFJlZ2lzdGVyIGZyYW1lIG1hdGNoIC0gaGV4ZHVtcChsZW49MCk6IFtOVUxMXQ0KPiA+ID4+Pj4+
DQo+ID4gPj4+Pj4gSWYgSSBydW4gdGhlIHNhbWUgaG9zdGFwZCBvbiB2Ni43IHdpdGhvdXQgdGhl
IHBhdGNoZXMsIHRoZSBBUCBpcw0KPiA+ID4+Pj4+IHN0YXJ0ZWQgd2l0aCBubyBpc3N1ZXMuDQo+
ID4gPj4+Pj4NCj4gPiA+Pj4+PiBJcyB0aGVyZSBhbnl0aGluZyBlbHNlIHRoYXQgc2hvdWxkIGJl
IGRvbmUgaW4gb3JkZXIgdG8gdGVzdCB0aGlzPw0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4NCj4gPiA+
Pj4+IEkgYXBwbGllZCBwYXRjaCB2OCAobWJveCBmcm9tIHBhdGNoIHdvcmspIHRvIExpbnV4IHN0
YWJsZQ0KPiA+ID4+Pj4gcmVwb3NpdG9yeSAodGFnDQo+ID4gPj4gdjYuNy4yKS4NCj4gPiA+Pj4+
IEJvdGggY2xpZW50IGFuZCBBUCBtb2RlIGNhbiB3b3JrIHdpdGggYW5kIHdpdGhvdXQgV1BBMy4N
Cj4gPiA+Pj4+DQo+ID4gPj4+IEkgd2VudCBiYWNrIGFuZCBleGVjdXRlZCB0aGUgdGVzdHMgYWdh
aW4uIEkgcmUtYXBwbGllZCB0aGUgcGFjaCBvbg0KPiA+ID4+PiB0b3Agb2YgdGFnIHY2LjcuMiB0
byBtYWtlIHN1cmUgd2UncmUgc2VlaW5nIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcuDQo+ID4gPj4+
DQo+ID4gPj4+IEF0IGZpcnN0LCB0aGUgYmVoYXZpb3IgSSB3YXMgc2VlaW5nIHdhcyBleGFjdGx5
IHRoZSBzYW1lIEkgcmVwb3J0ZWQNCj4gYmVmb3JlLg0KPiA+ID4+PiBVcG9uIHN0YXJ0aW5nIGhv
c3RhcGQgd2l0aCBvdXIgYmFzaWMgZXhhbXBsZSBjb25maWd1cmF0aW9uLCBpdA0KPiA+ID4+PiB3
b3VsZCBmYWlsIHRvIHN0YXJ0IHRoZSBBUCB3aXRoIHRoZSBlcnJvcjoNCj4gPiA+Pj4NCj4gPiA+
Pj4gbmw4MDIxMToga2VybmVsIHJlcG9ydHM6IE1hdGNoIGFscmVhZHkgY29uZmlndXJlZA0KPiA+
ID4+PiBubDgwMjExOiBDb3VsZCBub3QgY29uZmlndXJlIGRyaXZlciBtb2RlDQo+ID4gPj4+DQo+
ID4gPj4+IEFmdGVyIHNvbWUgaW52ZXN0aWdhdGlvbiBvZiB3aGF0IGNvdWxkIGNhdXNlIHRoaXMg
ZXJyb3IsIEkgZm91bmQNCj4gPiA+Pj4gb3V0IHRoYXQgaXQgd2FzIGNvbm5tYW4gdGhhdCB3YXMg
aW50ZXJmZXJpbmcgd2l0aCB0aGlzIHNvbWVob3cuDQo+ID4gPj4+IEFmdGVyIGtpbGxpbmcgdGhl
IGNvbm5tYW4gc2VydmljZSwgdGhlIEFQIHdvdWxkIHN0YXJ0IGNvcnJlY3RseS4NCj4gPiA+Pj4N
Cj4gPiA+Pj4gSSB3YW50IHRvIHBvaW50IG91dCB0aGF0IHRoaXMgYmVoYXZpb3IgaXMgZGlmZmVy
ZW50IGZyb20gdGhlDQo+ID4gPj4+IHVucGF0Y2hlZCBkcml2ZXIuIFdpdGggdGhhdCBvbmUgd2Ug
ZG9uJ3QgbmVlZCB0byBraWxsIGNvbm5tYW4gaW4NCj4gPiA+Pj4gb3JkZXIgdG8gc3RhcnQgdGhl
IEFQIHdpdGggaG9zdGFwZC4NCj4gPiA+PiBBbnkgaWRlYSB3aGF0J3MgZ29pbmcgb24gaW4gdGhp
cyByZWdhcmQ/IElzIHN1Y2ggYSBjaGFuZ2UgaW4NCj4gPiA+PiBiZWhhdmlvcg0KPiA+IGV4cGVj
dGVkPw0KPiA+ID4+DQo+ID4gPj4gRnJhbmNlc2NvDQo+ID4gPiBXaGVuIEkgdHJpZWQgdG8gdGVz
dCB2Ni43LjIrICh3aXRoIHBhdGNoIHY4KSBvbiBOQiArIFNESU8gSVc0MTYsIGl0DQo+ID4gPiBu
ZWVkcyB0bw0KPiA+IGlzc3VlICJzdWRvIHN5c3RlbWN0bCBzdG9wIE5ldHdvcmtNYW5hZ2VyIiBp
biBvcmRlciB0byB0ZXN0IEFQIG1vZGUuDQo+ID4NCj4gPiBUaGUgaXNzdWUgSSByZXBvcnRlZCBp
cyB0aGF0IHRoZSBrZXJuZWwgd2l0aCB0aGUgcGF0Y2ggaXMgYmVoYXZpbmcNCj4gPiBkaWZmZXJl
bnRseSB3aGVuIGNvbXBhcmVkIHRvIHRoZSBrZXJuZWwgd2l0aG91dCB0aGUgcGF0Y2guIEkga2Vw
dCBhbGwNCj4gPiB0aGUgdGVzdCBjb25kaXRpb25zIHRoZSBzYW1lLCBqdXN0IHJlcGxhY2luZyB0
aGUga2VybmVsLiBJdCBzZWVtcyB0aGF0DQo+ID4geW91IGNhbiByZXByb2R1Y2UgdGhpcyBvbiB5
b3VyIGVuZCB1c2luZyBOZXR3b3JrTWFuYWdlci4NCj4gPg0KPiA+IFRoaXMgaXMgYSBjaGFuZ2Ug
aW4gYmVoYXZpb3Igb24gdXNlcnNwYWNlIHRoYXQncyBub3QgY3VycmVudGx5IGV4cGxhaW5lZC4N
Cj4gPg0KPiA+ID4gRm9yIGkuTVggKyBTRElPIElXNDE2LCBpdCBuZWVkcyB0byBpbnN0YWxsIGZv
bGxvd2luZyB0d28gZmlsZXMgZm9yDQo+ID4gPiBjbGllbnQgYW5kDQo+ID4gQVAgbW9kZSB0byAi
L2xpYi9zeXN0ZW1kL25ldHdvcmsiIGZvciBzeXN0ZW1kLW5ldHdvcmtkOg0KPiA+ID4NCj4gPiA+
IDw8Q2xpZW50IG1vZGU6IDgwLXdpZmktc3RhdGlvbi5uZXR3b3JrPj4NCj4gPiA+DQo+ID4gPiBb
TWF0Y2hdDQo+ID4gPiBUeXBlPXdsYW4NCj4gPiA+IFdMQU5JbnRlcmZhY2VUeXBlPXN0YXRpb24N
Cj4gPiA+DQo+ID4gPiBbTmV0d29ya10NCj4gPiA+IERIQ1A9eWVzDQo+ID4gPg0KPiA+ID4gPDxB
UCBtb2RlOiA4MC13aWZpLWFwLm5ldHdvcms+Pg0KPiA+ID4NCj4gPiA+IFtNYXRjaF0NCj4gPiA+
IFR5cGU9d2xhbg0KPiA+ID4gV0xBTkludGVyZmFjZVR5cGU9YXANCj4gPiA+DQo+ID4gPiBbTmV0
d29ya10NCj4gPiA+IEFkZHJlc3M9MTkyLjE2OC4xMDAuMS8yNA0KPiA+ID4gREhDUFNlcnZlcj15
ZXMNCj4gPiA+DQo+ID4gPiBbREhDUFNlcnZlcl0NCj4gPiA+IFBvb2xPZmZzZXQ9MTAwDQo+ID4g
PiBQb29sU2l6ZT0yMA0KPiA+ID4NCj4gPiA+IEkgdGhpbmsgdGhpcyBpcyBub3QgcmVsYXRlZCB0
byBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gRGF2aWQNCj4gPg0KPiA+IEkgZGlkbid0IHJlYWxseSB1
bmRlcnN0YW5kIHdoYXQgc3lzdGVtZC1uZXR3b3JrZCBoYXMgdG8gZG8gd2l0aA0KPiA+IGFueXRo
aW5nIGJlaW5nIGRpc2N1c3NlZCBoZXJlLiBXZSBjb3VsZCB1c2UgaXQgdG8gY3JlYXRlIGFuIEFQ
LCBidXQNCj4gPiB0aGF0J3Mgbm90IHRoZSB0ZXN0IEkgZGlkLiBJbiBteSBjYXNlIEkgdXNlZCBo
b3N0YXBkIGRpcmVjdGx5Lg0KPiA+DQo+ID4NCj4gPiBSYWZhZWwNCj4gDQo+IEkgdGhpbmsgdGhl
IGRpZmZlcmVuY2UgYmV0d2VlbiBwcmV2aW91cyBkcml2ZXIgaXMgaG9zdCBtbG1lLiBTeXN0ZW1k
LW5ldHdvcmtkDQo+IGlzIG9ubHkgZm9yIGFkZHJlc3MgYXNzaWdubWVudCwgc28gaXQgd29uJ3Qg
YWZmZWN0IHRoZSB0ZXN0IG9mIEFQIG1vZGUuIEhvd2V2ZXIsDQo+IFVidW50dSBOZXR3b3JrIE1h
bmFnZXIgd2lsbCBhZmZlY3QgQVAgbW9kZSB0ZXN0LCBzbyBpdCBuZWVkcyB0byBzdG9wIGl0IGJl
Zm9yZQ0KPiBydW5uaW5nIGhvc3RhcGQuDQo+IA0KPiBEYXZpZA0KDQpJIGZvdW5kIGh0dHBzOi8v
Z3JvdXBzLmdvb2dsZS5jb20vZy9iZWFnbGVib2FyZC9jLzNVbTJYcWEyTUhVIHRvIHNldHVwIGNv
bW1tYW4gd2l0aCBob3N0YXBkLiBDYW4geW91IGdpdmUgbWUgeW91ciBzZXR0aW5nIGZvciBjb21t
bWFuPyBUaGFua3MuDQoNCkRhdmlkDQoNCg==

