Return-Path: <linux-kernel+bounces-46508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66F8440D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F66B2A8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A57BB03;
	Wed, 31 Jan 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wrL1PIsI"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5E7F46B;
	Wed, 31 Jan 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708293; cv=fail; b=CIMN/zPOmLHJbKwDVbJ/a4AKEiGahWPYZDIVehRsmm/Mx3APqreuG6+AQK4K4FHJw30/xdpuY8VBbKaycvAQVsorfYwCmxYoqrI60Or9EfbJZdLgr1tOk+VEU1VLezNWfXQim0n1cMAqFZJkeTf1AyaEG8NxrguWIajBTGmpvMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708293; c=relaxed/simple;
	bh=LgBk79e+KCq9k9x7okccwD2PPag/kXpWtS6c9NmrZPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFcPAbtUZ3ijLu57V9BRqZ9ZcfgILxG5aMOhl7RpB5unSKO5ut+LdlKGANO+zG4ywTHU6sbYFq5VCyf/nz9In3OPrAq0VOjQCbNr/PpHGuC7auwCnoKW5Dn74b5vnl/eBEU8vlZddarKOiitpZebKsaaFhIQ9x8+0KnFnr3KB3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wrL1PIsI; arc=fail smtp.client-ip=40.107.113.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL/LyrpJN8mMpv36Al2Nh2d96PRKvjszrAfE1G/Tgi8ROH+L7J5H0VPA3nM/MRa9GVRtdzsztOWJgqbMbhjn+JlBNbDa5BtWKFj1kyG7iH9MqUQFiBfuYrn919k9iie30aLREPLJPzyIT7lOigkpqYAjk/xCVLPgkeqDN0hDhk2HGQPvhC8HOZhPclN/ER7ldtxbZ9t76xxPEMl5qA5D8yd/LlwlvUrcUSGBo8Bx78DnhbbiFjoN5sJIH0FyRC/+vK4LW8XaTvh3DghPVP4/Wvx06+53WR+smJYicuIPelMZHVEEKs0Oq0QG16RsNO8M5fM2lqmSOVyISjtNtPolfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgBk79e+KCq9k9x7okccwD2PPag/kXpWtS6c9NmrZPQ=;
 b=VqIemBkQyJAO6pdIRssDLC2TwKSF1eJKNktzS8/mBlGRDPe98ATzHv+TzlV4KCwE34EmzUPll2ihQ2SjMCdl7Ly1SVpPoquGKNfDMwuZSS6xRzZjVVKVWEGAK79rw3Cu3l3b4vYJn4S80GcPpIAo2wzU/HCgS+LBh2XlvkoPOK7Aa/D/3pdBzAvo+dLcSOOd4rUsMLW+TFe3bbdIdjMdlLH9/TJTQOhW8d5qTzJu56CiIx8QSZsPWc8K9EHD3HHowUWdaQxZQ/FV8JDVDyuZYi/JebkWz7MR3Y/9KC5FXZ+S/vWPuWN6ZLCq9leOIuAZLx81KR8lfcuRZnDWpo7IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgBk79e+KCq9k9x7okccwD2PPag/kXpWtS6c9NmrZPQ=;
 b=wrL1PIsIgcYdR/0icH4PH/Sr7r50Jepjd5AxitgTskPUVMDYfAcXyJ23KAdZ60kBnkU8AWP0WD44KYVHRIQzxdd5NzKttILX4sN28nO3J8kq8ayHiBvXHdlciqbG6M3OGWOhxnJ3nJG8fRJFuCJIlowNbZ6v5X5ZuHXP2P5DR+U=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYWPR01MB8712.jpnprd01.prod.outlook.com
 (2603:1096:400:16b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 13:38:06 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 13:38:06 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Guenter Roeck <linux@roeck-us.net>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Topic: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of
 pm_runtime_put()
Thread-Index: AQHaVC8iXcXSbumPXUOI0ciCmgv5kLDzuJVQgAABkACAAADxcIAAK0oAgAADVxA=
Date: Wed, 31 Jan 2024 13:38:06 +0000
Message-ID:
 <TYCPR01MB112697112B71830F10C4EFED4867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB11269AD7463C9C7C0A09A43A9867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <ddc0b42c-bf88-4c0d-b938-8bd7ff7b329a@tuxon.dev>
 <TYCPR01MB11269BFC2DB457049A2B8C0C8867C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <247dcdfa-3761-4745-bdc8-88edf8cd06ea@roeck-us.net>
In-Reply-To: <247dcdfa-3761-4745-bdc8-88edf8cd06ea@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYWPR01MB8712:EE_
x-ms-office365-filtering-correlation-id: 28549728-e0ba-43e8-2561-08dc2261db26
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Xeml7E6BpF/+5EE/4rBWKx1Xy8LA1lSIIgnkRNS+PkbkOAzXgXSLoaSeP+nGHa8JIC0UZdCMmXMjQlipBqERnq/UgGXXaerWggMUj3gzHY65LomnD+9pwqVaFvt9hGn6lidvDhkbk0xwmfWOdlxuOwN1jbiaJIHxrgxyNQ5HFzQQH7ITT0+LBAX/MEJZcO/GKQbhf5FiJfAE2KTRd1YpGlgTFomtBGHfC9QOJTAsO1nlLEht/jX1AGdY3muvDsjDdwBCvJIhy2CQFq9HDt2YoEq6HA+E306U8toHXbBSHZDnBhrVkbPY5/xm26U9MHSW8dY83RSjfCZBJx6X6j+F9iwpd+e9VVQffpvA9BEYt8DApMQ2XSIqETtnheixncRk0NjZlZNSk9ZSu+AXhFcJnaUxPhwT9ZaclbyggIwFS4SGhAWGn+KYGlR+w1hd59LW0uLH3JH+JJ29jEakIk9v6la2xPYL7bAOhRk9Z5INrSjAGknr4up5UsrXNWF4/mikQXE5DEd/cWUR0sW3ibkPkUqKLe+BLAVKCUz4eSGfsXeBzXraW/w6+x2YuctD1Ky6mW1u2HYe0Sm20xbbCQqOouHTHdE7s3jbriMnNb9DwZKotMLx2D2rLy4nPMfAjNkm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(26005)(53546011)(83380400001)(6506007)(107886003)(64756008)(122000001)(9686003)(52536014)(8936002)(5660300002)(41300700001)(316002)(54906003)(7696005)(71200400001)(7416002)(2906002)(110136005)(66946007)(478600001)(8676002)(66446008)(4326008)(76116006)(66556008)(66476007)(921011)(38100700002)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3EzR0NlOWFyR0pieis5UDRDVTNzTTZQYlFrVXhxL2dwQUMyT3pWUGUwVENN?=
 =?utf-8?B?WWM1b1RMUHM0Qk5jdVVucVV6eUw0NUtDWlRHRWNZcXppZDh4eEExUlNRVWUx?=
 =?utf-8?B?ejBLN05DcVhtdTFTdkVTbGdQUFJGdlk5bkZDcWVxS3p2RmdxZGZDTE1qMGZB?=
 =?utf-8?B?VEJEMWZEZ0h2MlZ3NWM5YUFLSjdoZzRhM1NyanA2Z3ZVZytReTJWdXRqajZn?=
 =?utf-8?B?WUNHTWhlQnRFTklvd2JpOTZ0VlUvUVZFcWk5UDVGYmNVZStHV3UwQ2k1NHNi?=
 =?utf-8?B?YWNPSUNENEw3QkdVNGlVc0dIeWxuWDJzekNWZ0F5SjBhaDVPUk1reUVwLzNk?=
 =?utf-8?B?K2ZVZjg4TFM5b25BbER6MEI5Ylg2VTdjbTVYNTRsbks0bHJoSU5sc1pzdTNj?=
 =?utf-8?B?VDYrMHJxdEkvWk1kSWRHekZpQXl2Um9tNHFkdDRqeS9KV3Uxc3hVNnlJNmlO?=
 =?utf-8?B?YSt2SzVqdkl0K1hwRGZWSEU0elB3VzJlU2NUS05ET0doVStqSzlkUEpDWmpi?=
 =?utf-8?B?b21tYTZtZGt6SGhVQ0RLdWMyc2JET21mZmtZdzBkL2swbnlUWWN5NUxETklD?=
 =?utf-8?B?YmJqVityVTJkdHNlTCtBWjFGaFVsR0ROMEhpSGRUYWxtemk5aWZralk3M3FB?=
 =?utf-8?B?RUZaYXlKRm4rMVhPM1VKWDQzVHdxRTBlOHlOUG1Fajl0TTRmeExwd1dVMlcy?=
 =?utf-8?B?SEdHb2l6SzV2N0xNZEU1TnRNaXEzM0p0djFIYk5XK3p2RjBnZEVzNUNlWWto?=
 =?utf-8?B?YTlZUHVaeWN0OHIrdWk2SXo2dEF2ME14ZElDWVVEeklXZ3pHR0NudEFmcjN0?=
 =?utf-8?B?am5YK3BRYnN1a0JVK1V3a1oxRTlFaGlwOFJ1dVZrMmtJNDJyZjZEZEk3VHpv?=
 =?utf-8?B?Wm1uL0J0N1k0SENtSnQzUkx3Vm5UREVNZG1oZ0ZKUDFIQUpIc1FBZXZLL0d5?=
 =?utf-8?B?RmNVdEtreG93M0d5RGEyK0I1ZTArNmZ2cEVqN0NybHM1cU9xN2Y3YW9PUnZZ?=
 =?utf-8?B?UHpta2ptVytieFdZaVlHZXJNbkRaaitnVGtlSzJaQmxCT1pDWTk0UmNsRExp?=
 =?utf-8?B?ODFNQ3ROR1lBOTN3aHE0U2xRUGUwcFB0dkV1Ui9CVVluUnlvYUdFdmE2SEdT?=
 =?utf-8?B?bHZLLzVjaVFCaUF3c3NkQ0o5endyNlNpZHI1cFIrUjNMZ01hSnMzaVR6cExt?=
 =?utf-8?B?S3M4Sy8wTldVZ3pJTnJaNmdLQmZnSEpNbzRPNEozdW14OS9RRGkzTHh0cVVG?=
 =?utf-8?B?MkNlbVozZXpSUVZtT0lRTlN1YXI5cnI3WmJwQ29UTVNXcHVhOTBDK3ZPbmpE?=
 =?utf-8?B?bTM0ejdVSEFac1VRdVNUTTQwSVBlRytFcjAzRlpuU2phMmYvL2R6U1lTRjNU?=
 =?utf-8?B?TUswY0Q1Q2h6UUNtMXJaMUxGWkorRXJvUXppelAzMndHa01pZVZZZ1ZIQ0g0?=
 =?utf-8?B?d2U1aFM3WVJQcmxqVGhsZDJ0SUZ3U2M4d05hSUFzR1ZqbHdpbzRQZWZqME9G?=
 =?utf-8?B?eXQ4S0lkb1hTbW56UFdNc0Z3MGRoQ0wzTXJtTFkvT2tjTGh2VVlQbXhUZHoy?=
 =?utf-8?B?d0tSMVNDa2NaQis0eEFKYkg1YzhHVFpjS1JLMWQxWEVuRmYzczJTOGlHdmZq?=
 =?utf-8?B?aXZ5dFU0eHVNbXBkYlhxTzFJM1F0SHZ0YmtYUlpSaDJKM0lvczY5WGVHWEor?=
 =?utf-8?B?NHoyVlRpbnZGeEZOaldURUt6V3BBL0Fsa2JGZGZqWjFyOXFTZVFWM3ZiclNr?=
 =?utf-8?B?b1R1ZTVlb1lzY01ZQkVKWFVESHEvK2xScFFXSXREUHlLUjkrUExYNWorQ0V0?=
 =?utf-8?B?bURKbzJVZWVDb0NQYUVWMVdmRk55WGo4TGJsYkRIY3paR2M5Z2FHOWNObVJD?=
 =?utf-8?B?enhmK1ZKUTJIWm9RYVdKb2Uxa2RINk4vaTErVWJLSWwyUWU1RWVGYi9iUm0r?=
 =?utf-8?B?SmlpSnRrTmZvcFhCOVVESk0yeUEwY3ZhTHFQZUlNLzJ1TnBaR2RUYUpRWUM2?=
 =?utf-8?B?OWRneVZ3aFlRNE9kdWE5UUFJQWZvMk1DZkx1SzFRVWdwOHEydENEYVptSlJM?=
 =?utf-8?B?T3lFQldiVW1TdXBieUNpUER0UEZRNVhtMmJyZGpIQmlsMmlDbURSOHhWbWk0?=
 =?utf-8?B?S0Jvc1hiajU3UlBJdHZtbnR0V1JHRWJwdTlnOG5jdUZYMmxROGY5RW8wV1lk?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28549728-e0ba-43e8-2561-08dc2261db26
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 13:38:06.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +242J18CtyJzv03waEr/PYQqMbMZDwZkIub+6RdMNvreOiKsWSwFgR8AILIAmrZ6lMHBCqjJ/w9VVgaup3unl8v0gVZ1hjG/aBNf6fyYLs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8712

SGkgR3VlbnRlciBSb2VjaywNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8Z3JvZWNrN0BnbWFp
bC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFu
dWFyeSAzMSwgMjAyNCAxOjE0IFBNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDQvMTFdIHdh
dGNoZG9nOiByemcybF93ZHQ6IENoZWNrIHJldHVybiBzdGF0dXMgb2YNCj4gcG1fcnVudGltZV9w
dXQoKQ0KPiANCj4gT24gMS8zMS8yNCAwMjo0MSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgQ2xh
dWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBj
bGF1ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMzEsIDIwMjQgMTA6MzYgQU0NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAwNC8xMV0gd2F0Y2hkb2c6IHJ6ZzJsX3dkdDogQ2hlY2sgcmV0dXJuDQo+ID4+IHN0YXR1
cyBvZg0KPiA+PiBwbV9ydW50aW1lX3B1dCgpDQo+ID4+DQo+ID4+IEhpLCBCaWp1LA0KPiA+Pg0K
PiA+PiBPbiAzMS4wMS4yMDI0IDEyOjMyLCBCaWp1IERhcyB3cm90ZToNCj4gPj4+IEhpIENsYXVk
aXUsDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQo+ID4+Pg0KPiA+Pj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRp
dS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAzMSwg
MjAyNCAxMDoyMCBBTQ0KPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2MiAwNC8xMV0gd2F0Y2hkb2c6
IHJ6ZzJsX3dkdDogQ2hlY2sgcmV0dXJuIHN0YXR1cw0KPiA+Pj4+IG9mDQo+ID4+Pj4gcG1fcnVu
dGltZV9wdXQoKQ0KPiA+Pj4+DQo+ID4+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhLnVqQGJwLnJlbmVzYXMuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gcG1fcnVudGltZV9wdXQo
KSBtYXkgcmV0dXJuIGFuIGVycm9yIGNvZGUuIENoZWNrIGl0cyByZXR1cm4gc3RhdHVzLg0KPiA+
Pj4+DQo+ID4+Pj4gQWxvbmcgd2l0aCBpdCB0aGUgcnpnMmxfd2R0X3NldF90aW1lb3V0KCkgZnVu
Y3Rpb24gd2FzIHVwZGF0ZWQgdG8NCj4gPj4+PiBwcm9wYWdhdGUgdGhlIHJlc3VsdCBvZiByemcy
bF93ZHRfc3RvcCgpIHRvIGl0cyBjYWxsZXIuDQo+ID4+Pj4NCj4gPj4+PiBGaXhlczogMmNiYzVj
ZDBiNTVmICgid2F0Y2hkb2c6IEFkZCBXYXRjaGRvZyBUaW1lciBkcml2ZXIgZm9yDQo+ID4+Pj4g
UlovRzJMIikNCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5i
ZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4NCj4gPj4+PiBDaGFu
Z2VzIGluIHYyOg0KPiA+Pj4+IC0gcHJvcGFnYXRlIHRoZSByZXR1cm4gY29kZSBvZiByemcybF93
ZHRfc3RvcCgpIHRvIGl0J3MgY2FsbGVycw0KPiA+Pj4+DQo+ID4+Pj4gICBkcml2ZXJzL3dhdGNo
ZG9nL3J6ZzJsX3dkdC5jIHwgMTEgKysrKysrKysrLS0NCj4gPj4+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+Pj4NCj4gPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYw0KPiA+Pj4+IGIvZHJpdmVycy93YXRj
aGRvZy9yemcybF93ZHQuYyBpbmRleCBkODdkNGY1MDE4MGMuLjdiY2UwOTMzMTZjNA0KPiA+Pj4+
IDEwMDY0NA0KPiA+Pj4+IC0tLSBhL2RyaXZlcnMvd2F0Y2hkb2cvcnpnMmxfd2R0LmMNCj4gPj4+
PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+Pj4gQEAgLTE0NCw5ICsx
NDQsMTMgQEAgc3RhdGljIGludCByemcybF93ZHRfc3RhcnQoc3RydWN0DQo+ID4+Pj4gd2F0Y2hk
b2dfZGV2aWNlDQo+ID4+Pj4gKndkZXYpICBzdGF0aWMgaW50IHJ6ZzJsX3dkdF9zdG9wKHN0cnVj
dCB3YXRjaGRvZ19kZXZpY2UgKndkZXYpICB7DQo+ID4+Pj4gICAJc3RydWN0IHJ6ZzJsX3dkdF9w
cml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2Rldik7DQo+ID4+Pj4gKwlpbnQgcmV0
Ow0KPiA+Pj4+DQo+ID4+Pj4gICAJcnpnMmxfd2R0X3Jlc2V0KHByaXYpOw0KPiA+Pj4+IC0JcG1f
cnVudGltZV9wdXQod2Rldi0+cGFyZW50KTsNCj4gPj4+PiArDQo+ID4+Pj4gKwlyZXQgPSBwbV9y
dW50aW1lX3B1dCh3ZGV2LT5wYXJlbnQpOw0KPiA+Pj4+ICsJaWYgKHJldCA8IDApDQo+ID4+Pj4g
KwkJcmV0dXJuIHJldDsNCj4gPj4+DQo+ID4+PiBEbyB3ZSBuZWVkIHRvIGNoZWNrIHRoZSByZXR1
cm4gY29kZT8gU28gZmFyIHdlIGRpZG4ndCBoaXQgdGhpcw0KPiA+PiBjb25kaXRpb24uDQo+ID4+
PiBJZiB5b3UgYXJlIHBsYW5uaW5nIHRvIGRvIGl0LCB0aGVuIGp1c3QNCj4gPj4+DQo+ID4+PiBy
ZXR1cm4gcG1fcnVudGltZV9wdXQod2Rldi0+cGFyZW50KTsNCj4gPj4NCj4gPj4gcG1fcnVudGlt
ZV9wdXQoKSBtYXkgcmV0dXJuIDEgaWYgdGhlIGRldmljZSBpcyBzdXNwZW5kZWQgKHdoaWNoIGlz
DQo+ID4+IG5vdCBjb25zaWRlcmVkIGVycm9yKSBhcyBleHBsYWluZWQgaGVyZToNCj4gPg0KPiA+
IE9vcHMsIEkgbWlzc2VkIHRoYXQgZGlzY3Vzc2lvbi4gT3V0IG9mIGN1cmlvc2l0eSwgV2hhdCB3
YXRjaGRvZw0KPiA+IGZyYW1ld29yay9jb25zdW1lciBpcyBnb2luZyB0byBkbyB3aXRoIGEgTm9u
LWVycm9yIHJldHVybiB2YWx1ZSBvZiAxPw0KPiA+DQo+IA0KPiBZb3UgbWVhbiB3aGF0IHRoZSB3
YXRjaGRvZyBzdWJzeXN0ZW0gZG9lcyBpZiBhIGRyaXZlciB2aW9sYXRlcyBpdHMgQVBJID8NCj4g
VGhhdCBpcyB1bmRlZmluZWQuIFRoZSBBUEkgc2F5czoNCg0KVGhlIHJldHVybiB2YWx1ZSBvZiAx
IGZyb20gcG1fcnVudGltZV9wdXQoKSBpcyBub3QgYW4gZXJyb3INCklmIGl0IGlzIHByb3BhZ2F0
ZWQgdG8gZnJhbWV3b3JrLCBpdCByZXR1cm4gYXMgYW4gZXJyb3IuDQpTbyBhcyB5b3Ugc3VnZ2Vz
dGVkIGJlbG93LCB0aGUgZHJpdmVyIG5lZWRzIHRvIGVpdGhlciBwYXNzIHplcm8gb3IgZXJyb3Ig
Y29kZS4NCkJ1dCBtb3Qgbm9uLWVycm9yIHZhbHVlIHN1Y2ggYXMgMS4NCg0KU2VlIHdhdGNoZG9n
X3JlYm9vdF9ub3RpZmllcigpOg0KIA0KVGhlIGRyaXZlciBzdG9wKCkgY2FsbGJhY2sgbWF5IHJl
dHVybiAxIGFuZCByZWJvb3Qgd29uJ3Qgd29yaw0KYXMgaXQgaXMgcmV0dXJuaW5nIE5PVElGWV9C
QUQuDQoNCnJldCA9IHdkZC0+b3BzLT5zdG9wKHdkZCk7DQp0cmFjZV93YXRjaGRvZ19zdG9wKHdk
ZCwgcmV0KTsNCmlmIChyZXQpDQoJcmV0dXJuIE5PVElGWV9CQUQ7DQoNCj4gDQo+ICogc3RhcnQ6
IHRoaXMgaXMgYSBwb2ludGVyIHRvIHRoZSByb3V0aW5lIHRoYXQgc3RhcnRzIHRoZSB3YXRjaGRv
ZyB0aW1lcg0KPiAgICBkZXZpY2UuDQo+ICAgIFRoZSByb3V0aW5lIG5lZWRzIGEgcG9pbnRlciB0
byB0aGUgd2F0Y2hkb2cgdGltZXIgZGV2aWNlIHN0cnVjdHVyZSBhcyBhDQo+ICAgIHBhcmFtZXRl
ci4gSXQgcmV0dXJucyB6ZXJvIG9uIHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJubyBjb2RlIGZv
cg0KPiBmYWlsdXJlLg0KPiANCj4gXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXg0KPiANCj4gV2UgYXJlIG5vdCBnb2luZyB0byBj
aGFuZ2UgdGhlIEFQSSwgaWYgdGhhdCBpcyB3aGF0IHlvdSBhcmUgc3VnZ2VzdGluZy4NCg0KT0su
DQoNCkNoZWVycywNCkJpanUNCg==

