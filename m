Return-Path: <linux-kernel+bounces-145090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A388A4F60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9950B1C203BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670A6FE16;
	Mon, 15 Apr 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="SJ5QoSJB"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28D6BFAF;
	Mon, 15 Apr 2024 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185047; cv=fail; b=F9kBi7FSB8p5/KKxAn1uidHFCu2X5V04l9e36Zu76XoqeNi51/eg5LF84bx6HQvwF+kKKG099WLR0hEZw7DBcuugZO78ZSBpRHecOPHutyi9t6G5gUOeG4kgrxfGnYkYy5sCxmiGYpb6QnsgpxWUrcnTnEYgzxrcBaESkuqpHX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185047; c=relaxed/simple;
	bh=Oso8kWC6mNHfaxv4NPwqfbxAqnTvyA22HQnfZ9eZdR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYxLFN9MT65Fr9tqe/mED5Ir+tdR2MYI+ZGLEu7oiXq3eRg2VNMR9daclaMEEqLUhUOGQF3/BWYjUN98NfyUqCNdv0Kr2CKYuAFaZJY4wkzjPdeY5QbJXnOQw5C7wFkDh1UlBQn3HDyPk2Sc+Z+dfni8cyESWDK9GrbUpK1kwkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=SJ5QoSJB; arc=fail smtp.client-ip=40.107.14.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5hRdU/IhD8bDwUD/b5j8RZGH1YOyswIdqZTS+LHTmD9vnh+3anp6BZKy7W1lLrFKRidshFyS/1QbHvSJkj4WaPV9KH5X6Bp08neyOeAmnDUL2i3YyvrbEX3YsBYrtrjXZBvs/XyHXn0jwKL31Yv1HrsVV5o6FP1t7pKwPbwM2ds4P/wYOWDICLLqNfunvOKeWNKI7VjpwUTKC3WDBwCiKbURF8l3mAyfq3dDifJhh9ftk+j7fv2+T4j1oVn8nCHzcRuYPh0ekv8KTpVl807hkuOnx8OWXZDMdUT9IDdsbrAvOj/6JNAEMCiBQNGQWBjHBGtlFfN3jlflnYR+dbhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oso8kWC6mNHfaxv4NPwqfbxAqnTvyA22HQnfZ9eZdR4=;
 b=kb9BfC3vUrtwrGf1eRVyXz/VTk9bhT4QveBWUTO5cLSlBNffIZjpj6DA0lkOfQQwuDMlLqW4RONO7iKQ98ceJ/AKuKiH4A20Enj4v172j25iul6tC80DNDU/u/DqL4ZGxPhEh9bgjaA6SfmZMK6k+BiNd7sieEW14NME/YhCyYxg5wBanS0+9E/B0XE7zceyxB3E9Vj4KP+eM2YZLQHzCF5xuzJSd8SBQ8/2sGmIXnQBD8KaFw0yuTgCvMDz6J4E+ooiNa49i5rz3D0w0Gfdf4FckgBOmDKBkHUb3nEhDlRxgWQawjg7nU8fC4q0T6LDhiU+L6VWxh2BeSyYVUeKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oso8kWC6mNHfaxv4NPwqfbxAqnTvyA22HQnfZ9eZdR4=;
 b=SJ5QoSJB/tkkNRVJybYyeKHNKXMAyOTLNAjeDT3sO2WbAPTM9aIJmkm4NO+xzJlOX6o0Fu0czbukydPSWkb/0L0C0z0HePyyZMVwcpql34HJrujfn2aUwg5GZMQqluKYXd4GiX0aPN29JzbQdp2hcHFp3ubxhRekcNz8m6O9UE4=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by AS8PR06MB8305.eurprd06.prod.outlook.com (2603:10a6:20b:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Mon, 15 Apr
 2024 12:44:02 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 12:44:02 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "marex@denx.de" <marex@denx.de>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
	"marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH] clk: rs9: fix wrong default value for clock amplitude
Thread-Topic: [PATCH] clk: rs9: fix wrong default value for clock amplitude
Thread-Index: AQHajzJdY1FB4QpsokqVy2Ad3EaKaLFpRssA
Date: Mon, 15 Apr 2024 12:44:02 +0000
Message-ID: <128516ff-f499-4784-b899-841e7e5a9ec1@leica-geosystems.com>
References: <20240415124219.604339-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20240415124219.604339-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|AS8PR06MB8305:EE_
x-ms-office365-filtering-correlation-id: d7a7c007-590f-4256-cb6e-08dc5d49baa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TvzpKpNzXynwDGyap+SO4YwR5U9JPZKfa7uWc7280yXxuA5M2dQxYgqeBOOJ0+sFjiu+qsQLJalJr90pJ0pg+lGELJbTMUi6ZhNePa9Mjs42x4TlK2MGNeIIsTZQt/4OjgFUf5GSxaidDAQjCWqg+hhgf/JtXKG8dIjUsbvV6uASmnQKLhC92i5U5Eswt6OOYHnXRc8KrTXk/KtFBcjuy3sZf+yrwI99pKUnyvj/9fcBepalsoH9UI3ppVcBawCqPGSIMmwLs9ClUi56TpAp4/q3A+ncTgTjbuXqhoF1lzRb+3ZMxNzDAluu0+wnJbidHmJswc2acYQzZsolZg+Mu85KZv5FnT73yh0ZLZzZ1S6b1bC2Wsfzic3QSlnc+A5R2fmUBghKAq9K0FbyczEtPAHvPKEd/mn2kmQAchqxLBSAUOkOTj8260NMFJfhuCCDbdVeWyyGnXssevZb3eL5UuDCTrSvvSpAtPbzExG8E8JrA1D2m4s7FYq+x80CLMz9MwC2dwqfkjmENOnmSBkgMnzIDzg7RnMXqb4N4dlizVwz1dhCJpG4ULpAw1SHxCwvDaE7+NnGGiG57jp2STrJh8U5x4nbWJOsPAXt6mzVMyHQep6CaJ4mDKEh6tz9vovGzejAA9wTZlj46q0UbHXGP6BuQ/g8bXFP4fntqxMH7BrNy5jBE6DIvjIUdRbnjGaRA94dOBRO1HcmD+C/foe/H71yji1gH43fjMIUvCUb7xY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VG9WTytWY3MzTnV1TXZPSWxoWjY3UGp4K01SS1gwQ0lJSDR6ZjN4cTBEKzJJ?=
 =?utf-8?B?UlJLY2ZoME8zNVdCME5Yb3gvMmoxTkdiNW8yWUtPc0hBd3kvRnVxS1YwRVkz?=
 =?utf-8?B?MTV2bmR0Rnl2WC9id2Q0WFl0M09JL0ZVNmU1ZS9tZm1GYjArQjRLRVR1ZG9y?=
 =?utf-8?B?anFtak1aSG1zWEFNK0VYdDh4NXUzU1RqallmRnNZNThLNnU1cG1OM0dXTjVJ?=
 =?utf-8?B?RjZNS3NLTXV0MUFyWDJZRk55SmdEckI2ZjUwNUFnbkNxWG02S3dqd0d2YjIx?=
 =?utf-8?B?NThFUzlOVlpXbkZSWkRCY25oOGlvUFdod284YzNVU2xzUTBLQUQ2MnBwY280?=
 =?utf-8?B?aDhnS2xYMWpRc1NjeGhrY2VOcThFWDVFejFxWnVvemVXYmxuK0dKVVdsQzZH?=
 =?utf-8?B?MmduNDd2NG1oYjFwZXduWFVvcDBZZ0VPcXg0UEhjU1JiTmtDS1NaQ1RuTzIw?=
 =?utf-8?B?aXJkeVByUWpYcUY2a1NLRUtDZU50SEtJZ2JveWhmRVUxanFEbHk2dlA3Nzg3?=
 =?utf-8?B?WERhQUhlekdjMERuTEs1TkRObjZnaXQzS0o5V1pEUVlXME1zcG1yaldlVmth?=
 =?utf-8?B?cGEyeEswWVp0NFpuRUVXUXpMWW1mYnhqbEEwaWREN3B6M3R0cTlLcXVLTmpH?=
 =?utf-8?B?bXlOMjF6SEQwRmt5eEZkRWtvekkrMkxJRUh2VUVMZEZ6Qjk3Z0NIME5COWNy?=
 =?utf-8?B?dnVzcWMvRStZbU5zS1ZMM2ZpRGRWRWxUNTBIdlh5T0hKVmlNVDJNeFV4MEJW?=
 =?utf-8?B?U282U2JHZDdRYzBzb2VNU28vZU1uL3ZleXIwUVoxekdNcElkL2hVUDYySXkr?=
 =?utf-8?B?QURRalM0ZlpBQ0FuRlJrZG1TU1lVUjliejRoMDB5ZS8zVkFRWDVydmNyOWU2?=
 =?utf-8?B?bEYzSjVFQmdJbExoNXdIUzJRQWlEVU9zM0NOZjJBeTNCcE83ZlBua2xaSnpI?=
 =?utf-8?B?QXV1aEZLNXhJcHN1SHRKb04xQWZ2WXR0OWV2MHFwUkFNbnBOZVBCN2VqU0Iv?=
 =?utf-8?B?QnU2bmxBTnNYZXlUWldKVUNuelVvbkNJSHUvd1E5VWJLb2M4Yk1obm5QTXBy?=
 =?utf-8?B?eXFvanlzYi9jeXZPUXg4Mm9ya3NjZUJXVUVSUUNncW9PVGFSVno5WUlEdXBx?=
 =?utf-8?B?ekJveTBqU3ZpQlRKNkpERGdMU2x0SjJJZ2M5dGh3VFFiemtvSXpOMmgwMVEw?=
 =?utf-8?B?S1lTNGR5T010ZTUwcjBuZVNpNExTTjA2a09yV0w1cThQbHhvOU1JeGI1ZTlK?=
 =?utf-8?B?bnBkNUtmbE4wU3phWGlvN2hmMVgyRlJJN0o4NjhIVFlPK1kzWmVPNmprVUF0?=
 =?utf-8?B?L3YxTG5xdHFjdy9INFdJd1c0NGU4dmYrVzljVDhiSHBsanpnYnlxL204czVG?=
 =?utf-8?B?Y09RSzdJL1FPN2hLMlloNnZTaFdSam1MSXJpL2tsazJySnZ4MFI1V2tQQ0t2?=
 =?utf-8?B?b2tEamUyZk1WRkxRWHMxb0N6YmtiWFc1TUVOa29uWkdxR1puK3liVWJLOXJi?=
 =?utf-8?B?aFJsNDRVcGFaaC9PSU5FaTE5MGN6RklhbXhmT2hXbk5rZUtZdHZqczdLR3Vj?=
 =?utf-8?B?aG14Zm9ydW93MXh3NDUzSGRhZ3pENXdLTVEwWDlmQkoyNDBzVHY2dFZEbTd3?=
 =?utf-8?B?UCtuRE9aNWNjRFErSTZiY3VkQ2RJaXBkL3RuZjFPeUZ2cFhnanB2ZkRwbDJu?=
 =?utf-8?B?VStoZTJ3NXFJWC9WT1FSZ1o0cmtxeDhxSDJ0djNucGdQb1p4RkxjeWNxeUVk?=
 =?utf-8?B?RmlqbnNVeU95U09XVUY3dlREbyttQWNCOVAycjlMOHF4WmdQeWQrQ3I3Y1dz?=
 =?utf-8?B?eCtTUG8vakV6bk1nY2E5Y2RLMjYwSWVVY1pySHI3cXFpOFBNQjhJMGs0YkJL?=
 =?utf-8?B?WHRjN05TNFZSY0UrcDlRTG9aUUZQd0Z4LzRsei9mUVdSNnlBVElFZnZScVdL?=
 =?utf-8?B?WktmUlMxL3NHVVZhd3NGbndpUE1iWmh1THJFK2MrOFpIY1czV1hKZ0JsK1ND?=
 =?utf-8?B?dkNkMzR4REZXbXBBZkpPVVptVWpMVlBaR09ETndZekRwK0J5TVJSYWFYRTda?=
 =?utf-8?B?YVU3UFh6QytaekJENHBwamlHcmM2dVltMWlJSVk1Z0VYRFpXYmhMUWR1V0Za?=
 =?utf-8?B?bTdCWng1R2tLeG4rdUJOcUFzSGpiNG9hRGc1TUxYeDZyY2VpbXNUblVxOXRV?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <958D5FE9AE2A6B49B849E0E55F423891@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB6911.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a7c007-590f-4256-cb6e-08dc5d49baa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:44:02.4811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HPA+dqbgODJN0qTXYSWPZ0RQvN1nWWqwQZW92Ubj9GeOapnqSvfhkM7KobskS2NKi+ZAuVoJy8/JlAqjPSi7C0/aKYdMQZP7wb0UBMUBTdbT+moBbIpwJ7ZbuKtp2lhc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8305

SSdtIHNvcnJ5LCBJIGZvcmdvdCB0byBhZGQgdjIgaW4gdGhlIHRpdGxlLg0KDQpPbiAxNS8wNC8y
MDI0IDE0OjQyLCBDYXRhbGluIFBvcGVzY3Ugd3JvdGU6DQo+IEFjY29yZGluZyB0byA5RkdWMDI0
MSwgOUZHVjA0NDEgJiA5RkdWMDg0MSBkYXRhc2hlZXRzLCB0aGUgZGVmYXVsdA0KPiB2YWx1ZSBm
b3IgdGhlIGNsb2NrIGFtcGxpdHVkZSBpcyAwLjhWLCB3aGlsZSB0aGUgZHJpdmVyIGFzc3VtZXMg
MC43Vi4NCj4NCj4gQWRkaXRpb25hbGx5LCBkZWZpbmUgY29uc3RhbnRzIGZvciBkZWZhdWx0IHZh
bHVlcyBmb3IgYm90aCBjbG9jaw0KPiBhbXBsaXR1ZGUgYW5kIHNwcmVhZCBzcGVjdHJ1bSBhbmQg
dXNlIHRoZW0uDQo+DQo+IEZpeGVzOiA4OTJlMGRkZWExYWEgKCJjbGs6IHJzOTogQWRkIFJlbmVz
YXMgOS1zZXJpZXMgUENJZSBjbG9jayBnZW5lcmF0b3IgZHJpdmVyIikNCj4NCj4gU2lnbmVkLW9m
Zi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5j
b20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gdXBkYXRlIGNvbW1pdCBtZXNzYWdl
IHdpdGggIjlGR1YwODQxIiwgZG9jdW1lbnQgY2hhbmdlIGFib3V0IHNwcmVhZA0KPiAgICAgc3Bl
Y3RydW0gYW5kIGFkZCBGaXhlcyB0YWcuDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY2xrL2Nsay1yZW5l
c2FzLXBjaWUuYyB8IDEwICsrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xr
LXJlbmVzYXMtcGNpZS5jIGIvZHJpdmVycy9jbGsvY2xrLXJlbmVzYXMtcGNpZS5jDQo+IGluZGV4
IDUzZTIxYWMzMDJlNi4uNGMzYTVlNGViNzdhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9j
bGstcmVuZXNhcy1wY2llLmMNCj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXJlbmVzYXMtcGNpZS5j
DQo+IEBAIC0yNSwxMCArMjUsMTIgQEANCj4gICAjZGVmaW5lIFJTOV9SRUdfU1NfQU1QXzBWNwkJ
CTB4MQ0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19BTVBfMFY4CQkJMHgyDQo+ICAgI2RlZmluZSBS
UzlfUkVHX1NTX0FNUF8wVjkJCQkweDMNCj4gKyNkZWZpbmUgUlM5X1JFR19TU19BTVBfREVGQVVM
VAkJCVJTOV9SRUdfU1NfQU1QXzBWOA0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19BTVBfTUFTSwkJ
CTB4Mw0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19TU0NfMTAwCQkJMA0KPiAgICNkZWZpbmUgUlM5
X1JFR19TU19TU0NfTTAyNQkJCSgxIDw8IDMpDQo+ICAgI2RlZmluZSBSUzlfUkVHX1NTX1NTQ19N
MDUwCQkJKDMgPDwgMykNCj4gKyNkZWZpbmUgUlM5X1JFR19TU19TU0NfREVGQVVMVAkJCVJTOV9S
RUdfU1NfU1NDXzEwMA0KPiAgICNkZWZpbmUgUlM5X1JFR19TU19TU0NfTUFTSwkJCSgzIDw8IDMp
DQo+ICAgI2RlZmluZSBSUzlfUkVHX1NTX1NTQ19MT0NLCQkJQklUKDUpDQo+ICAgI2RlZmluZSBS
UzlfUkVHX1NSCQkJCTB4Mg0KPiBAQCAtMjA1LDggKzIwNyw4IEBAIHN0YXRpYyBpbnQgcnM5X2dl
dF9jb21tb25fY29uZmlnKHN0cnVjdCByczlfZHJpdmVyX2RhdGEgKnJzOSkNCj4gICAJaW50IHJl
dDsNCj4gICANCj4gICAJLyogU2V0IGRlZmF1bHRzICovDQo+IC0JcnM5LT5wbGxfYW1wbGl0dWRl
ID0gUlM5X1JFR19TU19BTVBfMFY3Ow0KPiAtCXJzOS0+cGxsX3NzYyA9IFJTOV9SRUdfU1NfU1ND
XzEwMDsNCj4gKwlyczktPnBsbF9hbXBsaXR1ZGUgPSBSUzlfUkVHX1NTX0FNUF9ERUZBVUxUOw0K
PiArCXJzOS0+cGxsX3NzYyA9IFJTOV9SRUdfU1NfU1NDX0RFRkFVTFQ7DQo+ICAgDQo+ICAgCS8q
IE91dHB1dCBjbG9jayBhbXBsaXR1ZGUgKi8NCj4gICAJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91
MzIobnAsICJyZW5lc2FzLG91dC1hbXBsaXR1ZGUtbWljcm92b2x0IiwNCj4gQEAgLTI0NywxMyAr
MjQ5LDEzIEBAIHN0YXRpYyB2b2lkIHJzOV91cGRhdGVfY29uZmlnKHN0cnVjdCByczlfZHJpdmVy
X2RhdGEgKnJzOSkNCj4gICAJaW50IGk7DQo+ICAgDQo+ICAgCS8qIElmIGFtcGxpdHVkZSBpcyBu
b24tZGVmYXVsdCwgdXBkYXRlIGl0LiAqLw0KPiAtCWlmIChyczktPnBsbF9hbXBsaXR1ZGUgIT0g
UlM5X1JFR19TU19BTVBfMFY3KSB7DQo+ICsJaWYgKHJzOS0+cGxsX2FtcGxpdHVkZSAhPSBSUzlf
UkVHX1NTX0FNUF9ERUZBVUxUKSB7DQo+ICAgCQlyZWdtYXBfdXBkYXRlX2JpdHMocnM5LT5yZWdt
YXAsIFJTOV9SRUdfU1MsIFJTOV9SRUdfU1NfQU1QX01BU0ssDQo+ICAgCQkJCSAgIHJzOS0+cGxs
X2FtcGxpdHVkZSk7DQo+ICAgCX0NCj4gICANCj4gICAJLyogSWYgU1NDIGlzIG5vbi1kZWZhdWx0
LCB1cGRhdGUgaXQuICovDQo+IC0JaWYgKHJzOS0+cGxsX3NzYyAhPSBSUzlfUkVHX1NTX1NTQ18x
MDApIHsNCj4gKwlpZiAocnM5LT5wbGxfc3NjICE9IFJTOV9SRUdfU1NfU1NDX0RFRkFVTFQpIHsN
Cj4gICAJCXJlZ21hcF91cGRhdGVfYml0cyhyczktPnJlZ21hcCwgUlM5X1JFR19TUywgUlM5X1JF
R19TU19TU0NfTUFTSywNCj4gICAJCQkJICAgcnM5LT5wbGxfc3NjKTsNCj4gICAJfQ0KPg0KPiBi
YXNlLWNvbW1pdDogNmJkMzQzNTM3NDYxYjU3ZjNlZmU1ZGZjNWZjMTkzYTIzMmRmZWYxZQ0KPiBw
cmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDANCg0KDQo=

