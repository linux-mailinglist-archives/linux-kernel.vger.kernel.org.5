Return-Path: <linux-kernel+bounces-70320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C959859605
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10DEB2205C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0E14AAA;
	Sun, 18 Feb 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="DRqk9knw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D903149E02;
	Sun, 18 Feb 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708249001; cv=fail; b=hvTNR9ZXFm6eNZRTKJBRZpClCm8V+RFS4/3jNzU3QjZc0fjU54FfBFbOHY8OnLgyz34HvcxOYYa4F6QHnIIY8nFnMrCYZsREITzbpuUm76K2gux0bwinL6hJzuPaIiTKseJ+AEO/mu8sjXL7lYy1b1hbegSGuKAuolw0BoZitu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708249001; c=relaxed/simple;
	bh=fQkUePhmb/HQzPqsHlPKfiYkR8j30LAExlpH4TYuwL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TPMXuGiny1PpZVC4RE3iHpmlabRrlQ9YAuTOAudZmgA/FyRqGlSbDbpZQ4HE58HTJPAJOp2vtSdfT8qn8cDLoLOQKOmlA8pKTo53wWvsHCqKa8VUp2TCWBZQg8EsK1bPaqvL/TX5IXvOP/YBrvbo45ZO7a+KtOjcD5/yB3wK+cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=DRqk9knw; arc=fail smtp.client-ip=40.107.255.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOSpS+6Jo5ClWIRD8aL49bmYPYm1+MoB0dmOY5FPmLyV0A6CgYBiYp+P3FFN9dyVHVKLTMGgwTd8AOaXNctOKsqLOwunf062Z070TtCRNra1kd15JJvrCcfSPmy16xL5LDfL49OI3J2MfSi1xnrKD5/ugx+TsMMWc5DWDYuvjXTr2rwI+uAcgo8qxLItgiQD0lwkOPbCeentlPcL5aN7ENDj8Zp6W+3zaI7+IyxRpZZbGxuqvoEMFgsRN4z6qQcxsF33ENQnTlhM7omQTA5qIQ2ICgQxvrDdskXo+BpmxXEohmVnBL/X2ZeXoEpTKbtMjfuXi5bUqMpet/SuZakvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQkUePhmb/HQzPqsHlPKfiYkR8j30LAExlpH4TYuwL8=;
 b=mdA+rVRRbh+Fc0t+ZOA9Hsc812Y9pyvpomuLF1nQxpJJpOln3U5QNxTLqCbv8Bed+qcuh3cpVCoOXFPN3Sow8QJEH7kSNSG2LyyYLCA9pbfDLr1JMFII1eTrkXfcL8Hljt6WAVmvKMIL99MS2VypVG9eZA1NwClhSf2XF7fFh3BvEs7naTSKCQy/YWy9rfGHfHKwNiGYgPJi9RHtTIyj7frQoLML+kDLc8gk4nNvu826BcCxUPtpQetyG5yLMejQXdgEmCqSvIqv2SQa8p5Z5/D7v3uuJh2EXSGzqAK5a2eC45ikJ8RQz74j9D4uQiqOIDoZrMegBdlOXBhX4mw/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQkUePhmb/HQzPqsHlPKfiYkR8j30LAExlpH4TYuwL8=;
 b=DRqk9knw05OohoTyhLqp2KhhgGotz2fb+UHUnzyfCCzEFmkTy/3CkAU1pqTaNVsYZTM4knif0PAyounVJl1lszEkREb6MWQCQNpjJDhpEkSc4UuFLKOtYIFOwId7FO2D6HEIPIviOYVspqOrhg18TFaRiy/4rX1nmyrIIGKt8kccM2vLxlg3UhJPo6h3omtAGYjW2rFIwMkY1Cc6u4pEAAndKVWRO7JaYbjIkn0LjNyesRVF1/KohCAz8FnG5DfzBHjKRl2dLbkRJAqEfbv7TblvrkaBriimjjMoWAVYpVQMkGxhMM9R9pLKQ1EJHGv7ZuadT+vwZ2vNGlsArT9OSQ==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by KL1PR0601MB3971.apcprd06.prod.outlook.com (2603:1096:820:21::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 09:36:27 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::cd2c:f551:eb64:44ae]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::cd2c:f551:eb64:44ae%3]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 09:36:27 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Manojkiran Eda <manojkiran.eda@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, Patrick Rudolph
	<patrick.rudolph@9elements.com>, Ryan Chen <ryan_chen@aspeedtech.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "zev@bewilderbeest.net" <zev@bewilderbeest.net>
Subject:
 =?utf-8?B?UkU6IOWbnuimhjogW1BBVENIXSBBZGQgZVNQSSBkZXZpY2UgZHJpdmVyIChm?=
 =?utf-8?Q?lash_channel)?=
Thread-Topic:
 =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIEFkZCBlU1BJIGRldmljZSBkcml2ZXIgKGZsYXNo?=
 =?utf-8?Q?_channel)?=
Thread-Index: AQHaXooDcj/dRKED5EijCru7OZnLmbEJqwsogAB/zICAAHchIIABBVwAgAQgEJA=
Date: Sun, 18 Feb 2024 09:36:27 +0000
Message-ID:
 <KL1PR06MB6652F1A2D8652B727D5F581A91522@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240213-espi_driver-v1-1-92741c812843@gmail.com>
 <KL1PR06MB665234A65DB334B3BDF6AFA6914E2@KL1PR06MB6652.apcprd06.prod.outlook.com>
 <20240214-yoyo-platinum-dcd0e7e16a22@spud>
 <TYZPR06MB6640F82C539F0B17BCDCC55E914D2@TYZPR06MB6640.apcprd06.prod.outlook.com>
 <20240215-probable-gimmick-83d5dcbc4729@spud>
In-Reply-To: <20240215-probable-gimmick-83d5dcbc4729@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|KL1PR0601MB3971:EE_
x-ms-office365-filtering-correlation-id: 4bd73df6-c209-4058-96de-08dc3065148d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BERrzqTCq7F1ITfixUkKdshswwbLysJbVL5ZHUSI/BjgO3nLRixIAabddhJ7zG5hMdDmgl9r2zJCZ0s5AyhqAmVB0s5eGTWW70I/pXqg2dAeHsP5HOBIJsYX2GknumZjMvLQtCPVy65CO5wP6yjP45ZDdaU6JxsKXl3zw+hJQXOlGUZTSwNTvz3tA9V+jNJvrQUMqkA1xba9aLSWhK8eTEzRQaJ8i30gghijLmOtOkT+YzIx7BveyCfVPw2avj+0fXbUB3AY8xx+JOEOstWwDTz6RWg/DzJ7UWztcrhMY1Aeqg9VY7+g7OCw0rB8u7Anag9UTiYI1lJ+dkV2IEosCTmRM2b0andunndLew94ukrRQnkxjbrFT8ALm+PPpdeurp86bwfWGVkUUKqjtNqxLYLWyVZBVPG75gOKHLiAPTPubZo5ZWba48QkZUyYOJVpKX9Dvwmd8qXO/FlBWSeqZ4Zud+VM1dNl18pnfhinwd3YyEX0bl1nmjmd+QkmV7eKRgElCmhEfOuHT29jyOcr/4CJ5qS0dztFQN23pif1wHV9f7T0DUuz8xWUn2WfZBbUWs4KmUIRnWeRHQgri+7dtaWYksuUXTe3W/w4a1agM0xixPJeyz/4VAYiXlHavK10
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6652.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(4326008)(52536014)(8936002)(2906002)(7416002)(5660300002)(33656002)(83380400001)(26005)(86362001)(38100700002)(76116006)(122000001)(66946007)(6916009)(66446008)(64756008)(54906003)(66556008)(66476007)(316002)(71200400001)(38070700009)(224303003)(9686003)(6506007)(7696005)(478600001)(55016003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUcwZ1JnQWw1NFVHQ2U4TGRXS25TdUNYVmQrSzgzN0NXNVFyajE2c1B3a1RN?=
 =?utf-8?B?ZUNQd3JyNmhFSWpiZjlzSUdYdi9Jak4vZjB3M003bXRTanlRQnVNczR4TStU?=
 =?utf-8?B?d29DclFVK3AzNUtnb21kTkRyeHhoWFFaM0RHT3hvWWpZMWg1Rm9EYVlqUXI1?=
 =?utf-8?B?TDhoekZHWHQ0UGJHVXB4Qk5Ka0pTekVVZTZuOUo0K29YMW1lL0szdXhtb2Z1?=
 =?utf-8?B?VHFsRmVpU2hySGZFOXYrQUhocW1OanpteFlqaDdXQ3Y5SWRmcVJHSmh1bnhQ?=
 =?utf-8?B?MXpBQmROTG5HZm1kNzQ0THRBZjhxZlF2NGlCb0tNdDkvV3pzemdTNXcyVm5J?=
 =?utf-8?B?Sm9aQXVhbzBaakY5S2FqRTZZR1lsNG1RK2lma085S0ZWNmlBTFZqN2Z6OVAv?=
 =?utf-8?B?WjhtTi9QZURHUmY4N1FDa2g2Nng4VzMxWUZqbk9Xek1TdklTNEFGVTVHNVBQ?=
 =?utf-8?B?S3BsbFk4cFBPdGNWc2xta1VscG5HVG80N1V1bXNxa0RUOWtlam5QWE9sRE5l?=
 =?utf-8?B?T0ZrNWN6Q3RsM3JoR01Td2VkclhjU1hqV3JJL25iMEZXMTAvTm1tSkp2d3pM?=
 =?utf-8?B?cGl0N2x3U01kM0V2d3NhMHZkN1hFVSs5TWdGcXF0SWQrc3dUcDUwU1pMODBy?=
 =?utf-8?B?UmNwSGlHeVN3SWM2Vlc3M2FDSHA4eXlQUW1vVGVZOXQ1N1lleHFJL2I5bUhw?=
 =?utf-8?B?Z0Q2UXh0K1ZGLzVLcTF4WjVPT1NTbGV2cXJBYm5TSWhZQndNZzV4bXVKWUhG?=
 =?utf-8?B?cFNPWkp2VFI1MnY0ckpYbGtqbWRENExycFcxdW9ZcktvK0NZTXJ6WDZrUGFF?=
 =?utf-8?B?R1g1bFBjNHlNRWVVUHVUc0UrbU9hUktiKy9VejdUVTB6SGhuRG9zMjl0Yk9F?=
 =?utf-8?B?Q2hHVFU1TzJiaUVNL0FXR0lkdDIzODNJbkhFeXIvT2htUlNONGdCUlBiQmsw?=
 =?utf-8?B?aE14MzUyY0cwNHR5L1NZcmpyUDhYQStVbHF4aXRTZHZHTGhHZnFPNGMrQkd5?=
 =?utf-8?B?V2c2SnBNZld6ZFlWUkpFcURRNEFVTjJvUVNRbEpscW9laUVHUUpqQzRoaytn?=
 =?utf-8?B?eW1IRXRORk15T1JnbmFCMXE3N1VzSitYZDlVNUZNbVNFcE9GdGV4TUUvbFE0?=
 =?utf-8?B?UEorRDMrMmVxVXVsNE8xY0NkZ3VkdlBFWEplaHZCV3Zwb1lrUENXKzN1RnVs?=
 =?utf-8?B?THp0dk1OdFVCT201REtaRzlJUXA5cG5zcTk2YjRMeTlpUXEyRTlrYmxYeWZ0?=
 =?utf-8?B?WXZGRGJXN3BTZUZCaUl3eWF0YWx3K3FmWDUwZlNGV21iZkVXZml2Qk1qUVFq?=
 =?utf-8?B?ajhqWnRPSVhsbE1QeHViTS9RejB4bU1RcFgxRnFHMTBuNzRCQnZ0c3VSR0V6?=
 =?utf-8?B?YzdLelNUeHlacTRZMEZWdVhNaWp2M3Z5Y0J6MFZWWWZCNi91S0luWXE4T01H?=
 =?utf-8?B?V0MxeHAyTVQyUzUyU0hMQTVnZmk1ZVk3VkdxTm85THhOeXlEUkhpaytEUUZn?=
 =?utf-8?B?Z1FCT0t4YmpiY2w3SjBCbHNURE9SdWxuVEdJYWtOR0NMMWo1ZDJVTWVyVldN?=
 =?utf-8?B?UVo2WGdlSHBLU1dUa2JaNE8rMy9GaEMvSHdlSDBQK3k5ampUVW01MC82c2Fn?=
 =?utf-8?B?c1NUZmZJejRrZ0lUWUEyZTNlWGQ0eXRrMEVUaEpyTTE0NTFuR1ZWNmloYlpQ?=
 =?utf-8?B?cUl6MVVWWlMybG92ZlU2ZzJUdjVubStLNFJySUsrR0ZtZWxiQUYwSjVlYjA4?=
 =?utf-8?B?ZjFIVktiVHZUNm1KQ2U4R2V5SnQvUUNIS1lmbnZKWVhYaDFVK3N6TWRJVkli?=
 =?utf-8?B?WWtzVG90UkVGVVlUb1F5RW16ZmhqVEVqMTZ0NlRwbWlibk9Pc0x0VWRYRklm?=
 =?utf-8?B?dWJxb3NMMGN6UHVwNVF5VzFuOEJ0Qmt0ZUEzZGk3VnZ2S0Q5ZWYyL0tMVDFl?=
 =?utf-8?B?YmlvMXRKenVQaURjcHF4TjVxM1dqaGFtMEU3R21YdnhqN3RCUVNHcGo1Rk1w?=
 =?utf-8?B?VEdNRVcyZThzbEJ2K0ppcEJ1ekE1ZXg0d2VDRWpRRERFVUM3YlhhN2R1UG1o?=
 =?utf-8?B?ZUtMNlJwWUx0TnJsVWJ4MkxvRWw3c081ckdyMG85MXNoMFY2ZVU1QzIwKzdH?=
 =?utf-8?B?ancrWjJVK1FZY3VBaUZFcnloOTEySElOVDN2dFdvT2VJMmVVeGxMcWpFampt?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd73df6-c209-4058-96de-08dc3065148d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 09:36:27.3994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLd3THHcxBOfj17qbg7GiW1+h+Dcaky9YeSSMpYBY9EDrQpkvj6jWVksemWQANhIburyGHrovwbzlfogD5SBzG0Gi4/BDGs9HNg5IyoNCCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3971

PiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwg
RmVicnVhcnkgMTYsIDIwMjQgMToxMyBBTQ0KPiANCj4gT24gVGh1LCBGZWIgMTUsIDIwMjQgYXQg
MDE6NTY6MDBBTSArMDAwMCwgQ2hpYVdlaSBXYW5nIHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgRmViIDE0LCAyMDI0IGF0IDExOjM0OjMxQU0gKzAwMDAsIENoaWFXZWkgV2FuZyB3cm90ZToN
Cj4gPiA+ID4gV2UgYXBwcmVjaWF0ZSB0aGF0IHlvdSBhcmUgd2lsbGluZyB0byBoZWxwIG9uIHRo
ZSBvcGVuIHNvdXJjZQ0KPiBjb250cmlidXRpb24uDQo+ID4gPiA+IEhvd2V2ZXIsIHBsZWFzZSBj
by13b3JrIHdpdGggQXNwZWVkIGJlZm9yZSBzdWJtaXR0aW5nIGRyaXZlcnMgb2YNCj4gPiA+ID4g
QXNwZWVkDQo+ID4gPiBIVy4NCj4gPiA+ID4gT3RoZXJ3aXNlLCBhIG1pc2xlYWRpbmcgZHJpdmVy
IG9uIHRoZSBjb21tdW5pdHkgYXJlIGdvaW5nIHRvIGJyaW5nDQo+ID4gPiA+IHRvbnMgb2YNCj4g
PiA+IGN1c3RvbWVyIGlzc3VlcyB0byBBc3BlZWQuDQo+ID4gPg0KPiA+ID4gSXQgbWF5IG5vdCBh
cHBseSBpbiB0aGlzIHBhcnRpY3VsYXIgY2FzZSBhcyBBc3BlZWQgZGlkIHdyaXRlIHRoZQ0KPiA+
ID4gb3JpZ2luYWwgZHJpdmVyIGFuZCBpdCBpcyBwb2xpdGUgdG8gd29yayB3aXRoIHByZXZpb3Vz
IGF1dGhvcnMgd2hlbg0KPiA+ID4gcmVzcGlubmluZyBhIHBhdGNoc2V0LCBidXQgaW4gZ2VuZXJh
bCB0aGVyZSBpcyBubyBuZWVkIHRvIHdvcmsgd2l0aA0KPiA+ID4gYSBoYXJkd2FyZSB2ZW5kb3Ig
YmVmb3JlIHdyaXRpbmcgZHJpdmVycyBmb3IgdGhlaXIgaGFyZHdhcmUuDQo+ID4gPg0KPiA+ID4g
QmxvY2tpbmcgYSBkcml2ZXIgYmVjYXVzZSB0aGF0IGNvbXBhbnkgbWlnaHQgcmVjZWl2ZSBtb3Jl
IHN1cHBvcnQNCj4gPiA+IHJlcXVlc3RzIGlzIG5vdCB0aGUga2VybmVsJ3MgcHJvYmxlbS4NCj4g
Pg0KPiA+IEkgYWdyZWUgd2l0aCB0aGF0IGFuZCBBc3BlZWQgd2lsbCBub3QgcmVmdXNlIHRvIHN1
cHBvcnQuDQo+ID4NCj4gPiBIb3dldmVyLCBpbiB0aGlzIGNhc2UsIHRoZSBhdXRob3JzLCBJQk0s
IGFuZCBBc3BlZWQgYWxyZWFkeSBoYXZlIGRpc2N1c3Npb24NCj4gKGF0IGxlYXN0IDQgdGltZXMp
IGJlZm9yZSBhbmQgZm9yZXNlZSAiaXNzdWVzIiBvbiBwcmFjdGljYWwgZVNQSSBTQUZTIHVzZS4N
Cj4gPiBJZiB0aGVyZSBpcyBhbHJlYWR5IGEga25vd24gaXNzdWUgb2YgdGhlIGRyaXZlciwgd2h5
IGlnbm9yaW5nIHRoZSBwcmV2aW91cw0KPiBkaXNjdXNzaW9uIGFuZCBwdXNoIGl0Pw0KPiA+IEEg
Y29tcHJvbWlzZSBpcyB0byBhc2sgZm9yIGRyaXZlciByZW5hbWluZyB0byBlc3BpLW1hZnMgdG8g
YXZvaWQgY29uZnVzaW9uLg0KPiA+IE90aGVyd2lzZSB3ZSBuZWVkIHRvIGV4cGxhaW4sIGFnYWlu
LCB3aHkgdGhlIGRyaXZlciBkb2VzIG5vdCBmdWxmaWxsIHRoZSBTQUZTDQo+IGV4cGVjdGF0aW9u
Lg0KPiANCj4gVG8gYmUgY2xlYXIsIGluIGNhc2UgeW91IG1pc3VuZGVyc3Rvb2QsIEkgd2FzIG1h
a2luZyBhIGdlbmVyYWwgcG9pbnQgYW5kIG5vdA0KPiBhYm91dCB0aGlzIHBhcnRpY3VsYXIgcGF0
Y2hzZXQuDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24gYW5kIEkgdW5kZXJzdGFuZCB5
b3VyIHBvaW50Lg0KDQpNb3N0IEFzcGVlZC1yZWxhdGVkIGRyaXZlcnMgYXJlIGZyb20gdGhlIEFz
cGVlZCBTREsuDQpBbmQgd2Uga2VlcCByZXZpc2luZyB0aGUgU0RLIGJhc2VkIG9uIG91ciBjdXN0
b21lcnMnIGZlZWRiYWNrIGFuZCBpc3N1ZXMgcmVwb3J0ZWQuDQpXZSBvbmx5IHdpc2ggdGhhdCB0
aGUgdmVyc2lvbiBzdWJtaXR0ZWQgdG8gdGhlIGNvbW11bml0eSB3aWxsIG5vdCByZXN1bHQgaW4g
dW5uZWNlc3NhcnkgbWlzdW5kZXJzdGFuZGluZyBhbmQgdGh1cyBtb3JlIGN1c3RvbWVyIGlzc3Vl
cy4NCg0KUmVnYXJkcywNCkNoaWF3ZWkNCg==

