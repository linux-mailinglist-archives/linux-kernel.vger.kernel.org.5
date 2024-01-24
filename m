Return-Path: <linux-kernel+bounces-36256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24908839DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BA11C255E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC3B15A8;
	Wed, 24 Jan 2024 01:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qfZVfc2p"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500EA10E3;
	Wed, 24 Jan 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058833; cv=fail; b=Qg2vOvjvsKe6mtQX5ttRMDQswN0EkbWywVG8rI4Emnp1Y9dnHkvrhf6whkEO2KrKycF7RYkTYl1odnab+AD+dn20QxhGsIc3HEOGFSi/TYwu4LTmfIMcTolmw2GhDye+7uRYiE1ToI6TYCx65fBrrqkqQQ4WPnTGfpqPa6okXe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058833; c=relaxed/simple;
	bh=Sp1jFimPi2yfI+s6t5M7Br2KGiDDjvCH0Ph/r2TS2b4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbpqPYxYt1brf0E0f+wzYhgXpXRMxeQYPuyPYQ+Q+xGMSDb3SM/PMijXRwadQvY6pXAMkfPeDH5N8Ob4kFocwrBaxs8tnhoyz6qbVna3FuCK/0rMcMO3+XpZCOQQRUXA8jlfWXSFSfQXC0e3cWfIA1YfffG8dSDBfOg3J19KisA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qfZVfc2p; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2l5JZvOwW36MRuHgsZl3OMnnoW8QA0IN3u7J344Gkc1FWlvVGaCyNKyIMrdhV4ShbB0H/z4xySHer7z40MTVPneRcCAf/CILNgiys7Zh1MtbZZZScwaU+yNFlz2sMyyjrQcIWYpIV7zaLe3yD+3S1urJtXtY0mPdiLsSQMu+v0ynYtmVdJz2+XwU7YLPZQKa3eAFUIqMA0dS85IJxVblnZ4bnOZViDRE/CmOFMC5wIfHJOXsUjtbzSsHdU5lwlTq+WMYliTDzGaTfw9PL+i4rxfpg78S0DltekRxY6njVKwcUkUyUHIqxyGFnHsb1jR7KUGbfcaNsEcT0SxC8swWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp1jFimPi2yfI+s6t5M7Br2KGiDDjvCH0Ph/r2TS2b4=;
 b=axKgPLZMqOskZqFiNVC5/UifwyGMvokh8lDrmMKrTu2O2zKRcEAmuga9Cq2FQcDsRtNuI1oYPrfPp4dwtY3rku0FvbweWUJI6w9fuXJmWu4UpqcLk/z2u/RYPjxJsfbrctHIEDX4MldscSGrjlvhwbm1wexru0RFPDXAI18kzGgTiXwG7KSN714ob5hlC6gcNW0Qnitk2j8Psjm0ot7+ZKu+vbyZlDZhZIeFU1Rd5wfOetigotOEc+sr3Sjksq1987aedoTDGzG86h4fkmuEKrBIIibIkbDUISGwqdNTC3rY/GbNRPo+wHzxBgYmoVZ+XjDaZKzgTMN1Nf3XUtg6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp1jFimPi2yfI+s6t5M7Br2KGiDDjvCH0Ph/r2TS2b4=;
 b=qfZVfc2pgw1m9VYWY8Fmg//QJJVZJ4l9JpO2T1/y+g1wZWuCgbhwMzKrCmbCflG8XKfCYwNP27FeqbtAJt9SK5l3XDo810OcQYCk+ehDO6/+ARO+bjixjnxTiP3EF6lLpkqXJxoZVuittvucqnjX6YGYY1/dKqh9wfPxCrZsBeo=
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS4PR04MB9388.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 01:13:48 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::fd19:496c:4927:ac32%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 01:13:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Breno Leitao <leitao@debian.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Shenwei
 Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, dl-linux-imx
	<linux-imx@nxp.com>
CC: "dsahern@kernel.org" <dsahern@kernel.org>, "weiwan@google.com"
	<weiwan@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 07/10] net: fill in MODULE_DESCRIPTION()s for fec
Thread-Topic: [PATCH net v2 07/10] net: fill in MODULE_DESCRIPTION()s for fec
Thread-Index: AQHaTi761NDYocmOP0ysHmlNYt2Nk7DoKGHA
Date: Wed, 24 Jan 2024 01:13:48 +0000
Message-ID:
 <AM5PR04MB31390E462C92EC60E2CAE0DE887B2@AM5PR04MB3139.eurprd04.prod.outlook.com>
References: <20240123190332.677489-1-leitao@debian.org>
 <20240123190332.677489-8-leitao@debian.org>
In-Reply-To: <20240123190332.677489-8-leitao@debian.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR04MB3139:EE_|AS4PR04MB9388:EE_
x-ms-office365-filtering-correlation-id: 8b797f8a-f993-47e8-6c66-08dc1c79b805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EZnlEKT3XOhkSjmdw0sBiffuqMs2MWblLt2qNWKuO3IQej5tWlIErltKcSs+/rBNfEw7ORluQOJtiJexYKXWZ1AxedHOCWC1J3sBOOS2XvuuBBWvSMdKDACzmSEkgKi6VR+Eiq1gcCPwHwpLmQc98bA8iACMI2YZ4n4AgDV/Z6e5fI8lvact6HxiTJZtCK57ZZEqWVdDTtSRoObAXMqLH7kgBWp3NlKItH+V1jkzUdjrpJujsftO5A9QvKVJ8aGF1Z3suBIfmROw5OqHEhTGCcluqnJmUmJSC9uRnRPH7XtDDJEMZqaM8XyzrzdW5aQtrFdbLKZ2DNUYoE/S9lyHtqn6T7jZ7u0yvpni8drxk9QtI/BVaCLq4lWy54aLBayVEt5wU8+ED1tK4ZSHu/Bwr77/JBCxFE5EXrmpZLFNwHaP6odVJzTfC+EAoCTsBnv+E0p1a3iQrmUuxmVGL/RAcytP/9ZlOBNXEB24JL1ELZ5ndVJwXTDzbLTMM18NQhQX6n+xYJaV5tO9Rc0XFA3rcl3Q4th0nYD/MKkEdjc8XD5OJQq4R8dy2KuyPz5tybHbWCqKY6eqTkHLkApGUjAcjF3/fq+5PJiefKchYUZpR7cNsYW4AEccldXUbA/ujgZD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(76116006)(26005)(83380400001)(9686003)(478600001)(38100700002)(2906002)(64756008)(6636002)(54906003)(122000001)(8936002)(8676002)(52536014)(71200400001)(66556008)(5660300002)(316002)(66446008)(44832011)(110136005)(66946007)(4326008)(66476007)(6506007)(7696005)(41300700001)(53546011)(38070700009)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K09KMklaMEJjaWd0Z0ZCYnFYaThFcXpDWXBqWk9ZR0x0akV0cmphTUdjRG81?=
 =?gb2312?B?aU5GbGRRL25aQ25acnJRS0NzYkFqN1kvQXdlVEk4TnI1K2ZMWXdvZG1ibmlT?=
 =?gb2312?B?ZGxhZmhlMHdHc09RbXkvNUpCaTV1MU80aHlOSnZPdTlwWEJFcnNCcG5pTHA0?=
 =?gb2312?B?Y2E0VFFqODF4OSt1eWtabUQrNmVNRTJsQndVL1k3aTJLRmlCOW5RYlhEWGlq?=
 =?gb2312?B?OXhpd0lLYWQxaE9WczhzcW1pY0g1Z2o2RTZLemVHVXFicUhlcXZhTTZlcHdI?=
 =?gb2312?B?MGk1cWMwRk5YTXNVd2RvaHJKOU5qdE5tUEx4NjNlWHZ3aTNMRldNSXI4SCs2?=
 =?gb2312?B?K2taQVdZb2Q1Yk5MTXpydVBVWi9uY09PS0l4NkRic0dvbC9YbXQzK3RaYlkx?=
 =?gb2312?B?THE3RlcrVXdCREFwZGJVZlJDeGo2V0FOUTJJYVJUM1p0MzBtR2tOQ01lWnRa?=
 =?gb2312?B?dmVTSzl3a3hTMlZEYjhZK0w1aHVYRTlvVUQrOTRJSXJVVkEzd1llRzNGZ24z?=
 =?gb2312?B?ZDA1NWhUMjhCWGM1Sm9iOHlFNExtUzE2VEJvWXdXRG4rL0RhcEJCN3NHZkE0?=
 =?gb2312?B?bEZDUHFIQkl3SE81a2JEWGY4eHRFYldOMHlNS2IrL21OamhzT0VWdXEweHZo?=
 =?gb2312?B?ZmRrV1hzTGhselRKei8vbHE3R0Q3TG93VVIrTFBMZkttZ1hsTnF5QktpQ2JT?=
 =?gb2312?B?ZkRjYXY4ZWdSQkZVT2tTOU5nRDVrRkU4b2pvUkRNNEFQbWtLaTZRankzRDRU?=
 =?gb2312?B?MnBia0FPVVRYMm9sZ0NIYUQvRDY1K01yRk9wTk1kL2JBaTUrTkkzNmVRWmp4?=
 =?gb2312?B?dVhRZmVYcVVHdjVrTDl2VUZiWFdRLzdIR0paUHRVWkc0eFJhYW5OR0MvREEr?=
 =?gb2312?B?Vlp5TDdJTW9SQ0Q3RlF2Lzd1ay9XaENwKzY1a2txbHdKVU92UWp1V3FoMm80?=
 =?gb2312?B?ZzlyejRiaGhubDM5Wlh3MEJxOGUxUVR3a2FpOHhqNnFqRUF2azdvQ3UxZUtI?=
 =?gb2312?B?d08zYzJpblo2MEtjUEpPR0VZeHoxeW1vU0c4VWJ3OWJFdlhZNkdCb0J2ckFM?=
 =?gb2312?B?V2JNb05maEI4ODNBeFVSSzlxNFpvajZHOGdvQ1hGMFhTZUpHUzdjK1lDNXg0?=
 =?gb2312?B?YXVROTJKN0ZJb0ZBeTlSYjlWeTRPRTZZMURrejBZNGNGSmJjRFlaelMxTW82?=
 =?gb2312?B?SmdWbE9zY2J3T2Y1VDYyWmtWd2JYVDA5K1hDU2pIUmdFcnBaUXhEOXBKVWR0?=
 =?gb2312?B?citMUHBZZFdQUTNMMVM1STE4SXAyQmt2bTlKQkgxYUJtZTYwNGRaTExqM05U?=
 =?gb2312?B?SmhjN1hrVnpvTnFjaXE4eWFQYU5oVG5Zeml6U2VUTWpOa2s0a2YxNy8xdkJY?=
 =?gb2312?B?djU3WU1xcFRNWkM4cWZKV3VLMTdTMjJBcGo3RTJ4bG1SbWt5NVlNSUpNb2Er?=
 =?gb2312?B?NDFKakZQdkhqT1hpOUxJdE9kaDZMamlkOE1ZM29DNVY0dk1uejhuMC95NHls?=
 =?gb2312?B?NjFqNWVpbTY0MVNxaGdTTWF2eDRZVCtIck5QMTZHVVVYSmxOYi95WldGdGN6?=
 =?gb2312?B?Sm5QdVVlQkVSOS9hT2N6dHBtMUZZamdoWEpPRXQzKzVUN0hRRTcrclNDbFRC?=
 =?gb2312?B?MnZQRmdnL1QzbFczYThLeXZrcURvWE9ZdWtmZEhDZkE3RUJhMWdXRVNsQ1VR?=
 =?gb2312?B?VzFHcWtvdVdwWUV3V3lhVkMwZlpYUFFWblUycGZ0SVlUTUJRYVVJTXRsekF5?=
 =?gb2312?B?aHZYbjNmcHdKTWJneVdSZU12UWhhU0xGNDBqSTQ3VVJYTFJhTGc0d0h3VnBG?=
 =?gb2312?B?ejlFSmxWWGdrc01iNnFVbExQVVFqME5CNzZFdEVpSlRHYkVPREk3WmtBTE44?=
 =?gb2312?B?bVdNTjRONytIeHFXNG90T3NtM2pnSnRSOHBmcEV2eW8wa1ZOV0ZqVW5kbEhh?=
 =?gb2312?B?MUsvUi8zQitBOXBMenVQa2V6ZUlzcnVLTkw3ZURvZUxGM29Hdlc0dmh5WlJ1?=
 =?gb2312?B?c1poTnFkelloM05nOEc0OGtXdXZ4UDZnQUhBL3JTMEFRY3N4TFpmYzdERm5V?=
 =?gb2312?B?M3N6OSs3MDdIbkxoVzUxNEF0WlNtZlQzMkVrekk3N0NtMjhNZ3c1UldBZXRE?=
 =?gb2312?Q?jX6w=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b797f8a-f993-47e8-6c66-08dc1c79b805
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 01:13:48.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: woBoUiEDueROn66I73ZeRjMEX1EYP4ANqxXV2Jg+gTqYChHk0ejH0ebtqY/clV7H49oQ4M+3TA8gn6VFdhnn3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9388

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmVubyBMZWl0YW8gPGxlaXRh
b0BkZWJpYW4ub3JnPg0KPiBTZW50OiAyMDI0xOox1MIyNMjVIDM6MDMNCj4gVG86IGt1YmFAa2Vy
bmVsLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGVkdW1h
emV0QGdvb2dsZS5jb207IFdlaSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgU2hlbndlaSBXYW5n
DQo+IDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhw
LmNvbT47DQo+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IENjOiBkc2FoZXJu
QGtlcm5lbC5vcmc7IHdlaXdhbkBnb29nbGUuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSCBuZXQgdjIg
MDcvMTBdIG5ldDogZmlsbCBpbiBNT0RVTEVfREVTQ1JJUFRJT04oKXMgZm9yIGZlYw0KPiANCj4g
Vz0xIGJ1aWxkcyBub3cgd2FybiBpZiBtb2R1bGUgaXMgYnVpbHQgd2l0aG91dCBhIE1PRFVMRV9E
RVNDUklQVElPTigpLg0KPiBBZGQgZGVzY3JpcHRpb25zIHRvIHRoZSBGRUMgKE1QQzh4eCkgRXRo
ZXJuZXQgY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJyZW5vIExlaXRhbyA8bGVp
dGFvQGRlYmlhbi5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L2ZlY19tYWluLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5j
DQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19tYWluLmMNCj4gaW5kZXgg
ZDQyNTk0ZjMyMjc1Li40YjAyNTllOTI2OWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0
aGVybmV0L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfbWFpbi5jDQo+IEBAIC00NzY5LDQgKzQ3NjksNSBAQCBzdGF0aWMgc3Ry
dWN0IHBsYXRmb3JtX2RyaXZlciBmZWNfZHJpdmVyID0gew0KPiANCj4gIG1vZHVsZV9wbGF0Zm9y
bV9kcml2ZXIoZmVjX2RyaXZlcik7DQo+IA0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJOWFAgRmFz
dCBFdGhlcm5ldCBDb250cm9sbGVyIChGRUMpIGRyaXZlciIpOw0KPiAgTU9EVUxFX0xJQ0VOU0Uo
IkdQTCIpOw0KPiAtLQ0KPiAyLjM5LjMNCg0KVGhhbmtzIQ0KUmV2aWV3ZWQtYnk6IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0K

