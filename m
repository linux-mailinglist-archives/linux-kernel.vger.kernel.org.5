Return-Path: <linux-kernel+bounces-108294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01A8808D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBB9283C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FE517D2;
	Wed, 20 Mar 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sRJzntPn"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C5610EB;
	Wed, 20 Mar 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896387; cv=fail; b=ltFlLYcs280tNGh8kGkyzo73rD0/K4THTngqdTLqGi3Bpe8JYZy2S8AXqGl+nNbwoct2m4xTxR9aIPiBnKcvz9Cyhy1rUIihBJetbDhUWuoV6daolVyMKb0mz9ttVxpJ9bCUSRsOuPhx3vWxNf5Vn/Dh3F33IPvG9MfJko2Hfak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896387; c=relaxed/simple;
	bh=dhMkTEasPyqRpSLRAwjQ1LmM65m/D9fIbRP5eorevng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLOsWqoyYmJs4W8LrOIvAUYrzCtrOvzI0WBSCSfrHcKKZTdqtQmSYv3Guf2mnuHziIAB0WL5f7wYcPcsp26GeEFRQCpshaPxnt7iP2gmjMPzGLoqToNVXP3qAVo/GR6ZbFKCZ301PX+zRKuvW5g32aGR/RPmODxdY5xnSUHI7Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sRJzntPn; arc=fail smtp.client-ip=40.107.21.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpBMC+8YNHI8twWrXJ5wvgTH3wNdpBgTaBMdcgS1gR4wHvXNmY7rPbNntiY5wj0u1jBkeoL1wWn8Guv0gtvPmspQYr0tt0q8qaXhVUaCNY3YbDl+IGgJwCK1ARddFuTkYUVekyP70RidsoE/sgDTy8trHcwu4UfDPtMPQOWYF2TyczzfGUvl9ta61ph5jRDBTboXrJxR1deEst5ijrbLdJxEtMbpqoHU+9tSQJy5/9FOaQBWK6RBTVW6qHMJQVADT+uNSABJsuhORPp3+tCbIYDx7kGHyzD8dxQjJqS63CFpJQd7nCz9Zi0AK6HT6uSnIGyZs2G7sTtmZMEBbTD69A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhMkTEasPyqRpSLRAwjQ1LmM65m/D9fIbRP5eorevng=;
 b=NAAjeZ+nAD4Ui0RXLaL58tXbCMgbEx+WCCpc04lY9E8ihqRxoOofwuI7l+WuVMxsAyuRcqHdLQMLsOA5NF8/8+t5D4uQBHI3CfY/IyRkf2/whTkEQXmKTPwkoDL0hQYs16vsB0dwE/DSkFRyTuUywxmNZoGGW0rAW4yAjBCnEYz52bEWJo4rqa+YFGYqHBPq51JdRtTkTMwS3fbw+weg09E2MbVjrqzc7illjZnIgFJflUWufdZSt+KiXakvdaAIujwU7AtHxec1IKzVUsTHqVq9QD1gG9sKMuu4V74ZkU9CSlQV4funeSc8hqAmcjTZh18wjr6Oq+gAA+ggD78+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhMkTEasPyqRpSLRAwjQ1LmM65m/D9fIbRP5eorevng=;
 b=sRJzntPn0S3kaxg813I1HUBh0/pPceXN7axAr3l2GChGLImPda2l0AIzHTA4IINE7bmozTkxJPmvyZqT0llN7+4ZHsXXcUBkBNNLB8VBu1JVuehjvSkIdi64RH/wK3yGxJQEUOrxeW+KUoLI21qQr3jC/f//rCoEpuPp/XXSyUc=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM7PR04MB6918.eurprd04.prod.outlook.com (2603:10a6:20b:10c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.29; Wed, 20 Mar
 2024 00:59:42 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 00:59:41 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
	<briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
CC: "kvalo@kernel.org" <kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index: AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEA
Date: Wed, 20 Mar 2024 00:59:41 +0000
Message-ID:
 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
In-Reply-To: <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM7PR04MB6918:EE_
x-ms-office365-filtering-correlation-id: 8f9b43dd-696c-413d-dd9c-08dc487906a2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c/dAG0PuKYXOqskj4Uttz9DBFqrk1UBG8qJ/qHNKSlI4RWksB+zEsOFy8vVKc/SbKiDDRXjndO+8a/dAMwK9cc30dc956KTxvBEpZ7lUn05vhpd1B+un894DT3lPdr55c/m86Rnf6FtWOZW7dqkWfvlWNe+wZtsxxu8VRbwDrT4akY4x99XP/iTszU0ksQcrpaTgPNA9Z/Uv24w9x13FTPFGRgTPhu69xjKTWOESccBk6Goa+OmqwfpC4qMzCbzpFtweS5meWHYbK+fWGADNKgo2gqEkVM4rmo9+HE3VieEa86C7zz98nLyGFOoP3DNi8KHUdGkp5ps7YfuP9p4WOw67JuqdnVWl2DI4tEeGOXI33KEGn1eVSw+QLGeA3VO6WzRTDDSDAtJi0FqIJqXoaXS/Thp+RcwGydcwVRImPaBPKWK81hX4JoOu1ALWUJ7MxrDDLB3SyIYxF876nCIqrH9tsghcgLc2xHD2tYN98ZKPXNqU6u+EYiV8ucrWbEJc389PgRuMwLb/EhM/5Fg8lK2sk2YvApp3vwzbWkvcod8ig+74u4x6+7Q/me5DiIJmrg75EsR9JIQtfHOFYSKIn/mcI6owXPVD52/D1N4SIC2eaC8Lqcl91fJoNR4B2tjbl/Jl96AXtByifmATOOS947grElr1oAQiwck8b4kXTWpx3dBBJPbnkwdTrLPjEiuJwyiwaxvXDeegTP8hWEa8x6TQo2sGNDlydHosSj7GyTM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjkwSGx1TGFlTTZVblhyVEt4YjY4M0ZrZkxjWm9uQTNpVGYzcngwTFgya01X?=
 =?utf-8?B?TDZtaGx3QUloVVlxNWhMVEFhakNCYzVLUjRMYkF4ZXpCb2VxVmRRcWtsWWlR?=
 =?utf-8?B?L0RpcG53ZnJGTSs5QnpqbzBwbXVsdUcyNm9PRXBUYkRXR05BZVQ5ZmxTQU16?=
 =?utf-8?B?b3kxN3BsdkhzTHRSM2ZHMk9XRm9YV1VQdkphbVhmZFl3VzRUNTh0TUV2VFZZ?=
 =?utf-8?B?ZFhqU1NSTWs2MFFCbFU4NnpGcWM2Vmt5UWd4cnBjTHVWNmtKcXJIcUFGQnMr?=
 =?utf-8?B?c0lFMkd3WnhzcFF0Z3crWnBWYncrWmYvUi9qdlNIN2dQK29LVW5iRW51SkNW?=
 =?utf-8?B?UHFZYmNXL280VFR3YWRNNk1RbkJCOHN3VnAvN0VSdTA1RE05dUVnMndwSlgy?=
 =?utf-8?B?c3VKNkZtVEJtM3h0SFVoTFpUZUk0YUJNWXR4M0ZBR0tad3pWMmFHQ3hBOERp?=
 =?utf-8?B?a0FmWGR1Y09BR0xycFZlMTZrR3RaQjVoanVRZHVwTXlNQ0t5YUZIR0VHNEpp?=
 =?utf-8?B?c3NQaFBjUEw3TlNKa2k0cVczVHJmN3VaOGs3VytINWErdStHbVk1b3VNTlVo?=
 =?utf-8?B?UzBYN1ZXQzNaVllNREI2VEp1cUJZeWFkQk9saVR3YWtncjFiLzk4aHFlbFNE?=
 =?utf-8?B?R3hmVzIwaWkzSWRrNjdPZzBBTm5ObTFPaGtkYU1SWEZTcVYzZ09KYUpMSWEx?=
 =?utf-8?B?SmR0OHNaOWtZVHpRbjlublkzc0UvOUVRV3VXL2xCYUNEeDd4SmZkSTIrYkJ3?=
 =?utf-8?B?dW80WXI5QWMzYklJK3QyOHIvWXZVWTE1SnRjWWhBU0MrZmxXaU84YXk0SUxy?=
 =?utf-8?B?N0tob2h2bG1NdGlmSkI4VG15OVVIb1Qrc21ZY3YzWXFCSFc0YjVwaXhwUW0z?=
 =?utf-8?B?S3BiU2M5cW1YcVVpdElMOGZCNk5ldnRmT3c5STFOeDJ6NlVjWnNjZFhzczR4?=
 =?utf-8?B?eGtIcVpjaTBnRHJTSUxRaTVLc1ZqU0doa1VLQUU5a3p1aGU0ZytlbHdiT0RW?=
 =?utf-8?B?RkFNV1hTZXhINHhkbTRhcGNTSWNTdFREK0svaTZTSnExNmVnc1liTDFQTEdO?=
 =?utf-8?B?N2tRQ1ZBTjJodU5BWWJQaVdxN3ZIQjBtb1pBdkxSMEdabFF4bENvVklMblV5?=
 =?utf-8?B?Vk9WUFp6dzU2d2w0MFFwcVkwQkdIc2lmMHJuTHpYaEdPa3lFaFB0NzkwVGVt?=
 =?utf-8?B?cHFyUXY0V1B6RXBtTHlpV01KVGFKNEpTbzdTNENEcFlYamUzTnU5azFqMzNV?=
 =?utf-8?B?MTRoc2VDOEdwRmVSSG5CUDlIbmcxL2hoa3AvVVdvZHc0QURrYWpzck9BQUpp?=
 =?utf-8?B?VGk5bUZmRnR1eWdPT1hnMGNTeFNpckk3ejMwUUhLTEFUT2txYnZmS29sRGtU?=
 =?utf-8?B?L3c4dkFrTm41OU01aDEyOFN3UjN0VTVxYms0VTBsc24ycElVbElrbVdiRHVi?=
 =?utf-8?B?Sy8xTkdEVVVoQVlGNk1OS1AxdWVsMjU3d1pGR0E5bU1JckFFb1dSK3hUbENm?=
 =?utf-8?B?RjF6MndQbnM1K0pEeHYwdEVGL3RYdlVrUkt1MXhrWVJLMVpiRkFoc3NDbVI4?=
 =?utf-8?B?SzllV1M4R1dIaGthSHBtRlh1V2tTNVYzNFB2Vi9IK29GK28rTFNHdCt3b3Jh?=
 =?utf-8?B?ZjVBbUYxWk56RGYyVXczS3QzVzFSVUJqR1RTOForbFhBc3ViVCtGZ0NWR0JP?=
 =?utf-8?B?Mmhvb20yTEV4dFViWWZtdEIxNm92MDhGeFkxU3cyT0ZFaER1VTJWQWppQU9Y?=
 =?utf-8?B?dXNxQWw1YkNPT0dRY2oxbUJHVm1DZGgxZHVsdGpTZHBzczRZRHJZVG13Z0JT?=
 =?utf-8?B?REFUVU9pWG9LMUcyYWIyUnMxNTBESXEvaUxONTlLWEorUkFnemRNWXJsc0xJ?=
 =?utf-8?B?ZjlyeWpLVHlIYTJYUTE0SzliV2RTVUVQRExRQXRlNXZJWTdzcmI5WkV2TWo2?=
 =?utf-8?B?aHAzMHJSTG5ZZ0VjeGdqRi83by9TdzJFZ0pVYi9DdUZSYkU0c1VJeTEvY2Rh?=
 =?utf-8?B?M3NSZTZRTTN3bXltL0gxNHlPeWY4Qmo2d3VjVUdPMjJ1L2ZMa0FSVHgxSTdN?=
 =?utf-8?B?ZXlUSlJickVnMFF6L2h3Mk53WnNlVnhMS2gyaU5uWWNHZVhDZXpOc2FRYUdQ?=
 =?utf-8?Q?aX0VXztjdAK0hkWlJAoh50eHh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b43dd-696c-413d-dd9c-08dc487906a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 00:59:41.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JiYb0ExRLVCgdjb5MWjsR26RC18mtlaqdQ7itKG4xr6zoAqP0XA88oScR4Dgw6jLLwcmiSRHiPzSoIgWqVqrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6918

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCAxOSwgMjAyNCA4OjEzIFBNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJy
aWFubm9ycmlzQGNocm9taXVtLm9yZz47IEZyYW5jZXNjbyBEb2xjaW5pDQo+IDxmcmFuY2VzY29A
ZG9sY2luaS5pdD4NCj4gQ2M6IGt2YWxvQGtlcm5lbC5vcmc7IGxpbnV4LXdpcmVsZXNzQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgTGluIDx5
dS1oYW8ubGluQG54cC5jb20+OyBQZXRlIEhzaWVoDQo+IDx0c3VuZy1oc2llbi5oc2llaEBueHAu
Y29tPjsgcmFmYWVsLmJlaW1zIDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+Ow0KPiBGcmFuY2Vz
Y28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1YmplY3Q6IFtF
WFRdIFJlOiBbUEFUQ0ggdjkgMC8yXSB3aWZpOiBtd2lmaWV4OiBhZGQgY29kZSB0byBzdXBwb3J0
IGhvc3QgbWxtZQ0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxl
YXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVu
dHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0K
PiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiBGcmksIDIwMjQtMDMtMTUgYXQgMTc6
NDkgLTA3MDAsIEJyaWFuIE5vcnJpcyB3cm90ZToNCj4gPg0KPiA+IE5vdyB0aGF0IEkndmUgbG9v
a2VkIGEgYml0IGNsb3NlciB0b2RheTogSSdtIHJlYWxpemluZyB0aGlzIG1heSg/KSBiZQ0KPiA+
IG9uZSBvZiB0aGUgZmlyc3QgImZ1bGwgTUFDIiBkcml2ZXJzIHRyeWluZyB0byBpbXBsZW1lbnQg
aXRzIG93biBNTE1FDQo+ID4gLS0gb3IgYXQgbGVhc3QsIHRoZSBhdXRoL2Fzc29jIGJpdHMuDQo+
IA0KPiBIbW0sIHllYWgsIHdoeSBfaXNfIHRoYXQ/IG13aWZpZXggd2FzIG9yaWdpbmFsbHkgInNv
bGQiIGFzIGEgImZ1bGwgTUFDIg0KPiBkcml2ZXIsIGkuZS4gZG9pbmcgdGhpbmdzIGluIHRoZSBm
aXJtd2FyZS4NCj4gDQo+IFdlJ3ZlIHNhaWQgdGhhdCAic29mdCBNQUMiIGRyaXZlcnMgc2hvdWxk
IGJlIHVzaW5nIG1hYzgwMjExLCBidXQgdGhpcyB0aGluZw0KPiBjYW4ndCBzZWVtIHRvIGRlY2lk
ZT8NCj4gDQo+IEFsc28gZGVjbC5oIHNob3VsZCBwcm9iYWJseSBfc2hyaW5rXyByYXRoZXIgdGhh
biBncm93LCBhIG51bWJlciBvZiB0aGluZ3MganVzdA0KPiByZXBsaWNhdGUgaWVlZTgwMjExLmgg
KHN1Y2ggYXMgTVdJRklFWF9NR01UX0hFQURFUl9MRU4gcmVhbGx5IGlzIGp1c3QNCj4gc2l6ZW9m
KGllZWU4MDIxMV9tZ210KSBvciBzbz8gTm90IHF1aXRlIGNvcnJlY3RseS4pDQo+IA0KDQpUaGlz
IGNhbiBiZSBkb25lIGZvciBmZWF0dXJlIHBhdGNoZXMuDQoNCj4gU28geWVhaCwgYWdyZWUgd2l0
aCBCcmlhbiwgbm90IG9ubHkgd291bGQgdGhpcyBiZSB0aGUgZmlyc3QsIGJ1dCBpdCdzIGFsc28N
Cj4gc29tZXRoaW5nIHdlIGRvbid0IHJlYWxseSBfd2FudF8uIEFsbCBvdGhlciBkcml2ZXJzIHRo
YXQgd2FudCBzdHVmZiBsaWtlIHRoaXMgYXJlDQo+IHN0dWNrIGluIHN0YWdpbmcgLi4uDQo+IA0K
PiBTbyB3aHkgaXMgdGhpcyBuZWVkZWQgZm9yIGEgc3VwcG9zZWRseSAiZmlybXdhcmUgZG9lcyBp
dCBhbGwiIGRyaXZlciwgYW5kIHdoeQ0KPiBjYW4gaXQgbm90IGJlIGludGVncmF0ZWQgd2l0aCBt
YWM4MDIxMSBpZiBpdCdzIG5vIGxvbmdlciAiZmlybXdhcmUgZG9lcyBpdCBhbGwiPw0KPiANCj4g
Sm9oYW5uZXMNCg0KT3VyIHByb3ByaWV0YXJ5IGRyaXZlciBpcyBjZmc4MDIxMSBkcml2ZXIsIGl0
IGlzIHZlcnkgaGFyZCB0byBjcmVhdGUgYSBicmFuZCBuZXcgbWFjODAyMTEgZHJpdmVyIGFuZCBz
dGlsbCBjYW4gcG9ydCBhbGwgdGVzdGVkIHN0dWZmcyBmcm9tIG91ciBwcm9wcmlldGFyeSBkcml2
ZXIuDQoNClRoYW5rcywNCkRhdmlkDQoNCg==

