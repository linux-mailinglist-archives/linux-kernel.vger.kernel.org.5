Return-Path: <linux-kernel+bounces-78959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0FE861B57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24326284364
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE81448C3;
	Fri, 23 Feb 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="QcmBH5/z"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2134.outbound.protection.outlook.com [40.107.9.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44326141987;
	Fri, 23 Feb 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712121; cv=fail; b=E2dRgXtyvqeE9WargSn3w1kPy3cAmdTyDYzACEIzYO5tCnO0Df9rovt6Cjr5d/GJeitC8Bifk5vKoVQ1aEKIbfmLVj02Gmm16c1y1x8AoMzPhYLoQrbHPO+X44K085pVbzBTY97hANQhT8ilnLREpBx9FFeOkXdATRYJAv//rNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712121; c=relaxed/simple;
	bh=+ajpyS1fzuRjD9F2la/oyMPYAF/CHhkdwTGryeOOPyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uphZUV04+I8ZeiTyVXD3GiAci94EgB9guf/RdgaJYm9wFZcWxAhx0Hw2gCJuemQpeHn22Wv4EjsAlMhkEgMOm57YyL6To94iAtDxgXjMwMerzrWXG7kIlseX9enFyf5os6Sba4/5UTJ9UjhAqMxxyZOZBvQehLwnZCghV9x4oOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=QcmBH5/z; arc=fail smtp.client-ip=40.107.9.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFi2mffOmIAcAMh6yurRMEvOOhYyG2wDsB4QuRQa2r/M7a6cDPl35LhZ4L+96GiQo8Jye1niO7m1kyRQ+tzB9YGQijTI/v/drr1+dIy5Jd8M3hpqwh0MbMX4rOipTSJCM0nxkadTPn7is7wCU6IZIVDzq+toZAwi4DlXFDeDwGVMfkG8ydPaBedzAdSQvm6BQpnykWSN1lSNBjuYMpmXZpqdTH0ICNUAep0pXu0s8RXsye74q8NT6JKLRPcf4UB8k3sgKFs9BhPsCxeEiwhWnsmwvwSUGrq53bkUWFZbPt7JddB4sjgHhKQfveoOkVOW/Yp3k5GG6O1hQZekQdapOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ajpyS1fzuRjD9F2la/oyMPYAF/CHhkdwTGryeOOPyY=;
 b=N9VBt7eAHRPtdiaXTIq2SxmG0b5WgVKXkO/VzMCG0rDHODTOL9oJxknuPVW9aSmJrnZXYjQXu1Ni8ubbjJiHUlls90XjuodAI+hYv2FIhGdO8CPQGFX4yWwRCMTCcryjRPomGUO2NPjhYxMqoSUh4dEYqCDZmFBAKmTUlYp3v2KKwlAeYRbrKXWmOhpzvPqYzheGPoHeHV7h/QSGDC3JMsEduIEA5miI4KzKZ5lpTLhVYYI19mR0UXTxiepdLkTKRaA+95dQ6RzYZkG+01zPGVr5/7rv/+Ogn18sasQTkijbJgiqB+fqcedV+Tw1sIGcAPrq6W131cvDlv+kP3eZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ajpyS1fzuRjD9F2la/oyMPYAF/CHhkdwTGryeOOPyY=;
 b=QcmBH5/zCdmneF0bX23WxZ9McsJZhN3maPqdxzLw0NL2BBPNopamVInLOyX2odqxfQR6bprq8/PJIMg2ic6Sw8TVROyiOcdHeayWqF1kwwiq4x6zmOZGn6QXtUx15EY8838cZKnEnPlNkmA39XrLXGA6b/Q8FH8L1SdN1o4PaiOnlau+9HSnC9M0zsE80wuYvHyrp7Ggji2LRhsy2l/JVE3AWQB0F2vyRSbUY6eKrS2zeqmhVehno2UXVPsxB9f4VxBhWrsovq/Ikda4u7lgWlAjs+ziM4I9HTRTF5ri1GNQgOCGAxWzYtYWnd58P9Ts1nzqOq0o757CcY8/vrxc8w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2668.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:19::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 18:15:16 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 18:15:16 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Erhard Furtner
	<erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Topic: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Index: AQHaZkTy9Xv+fOXXx0O2ApyFNqZzw7EYNxcAgAAE3wA=
Date: Fri, 23 Feb 2024 18:15:16 +0000
Message-ID: <66402663-98dd-42a2-aa04-5f04cb76b147@csgroup.eu>
References:
 <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
 <Zdjcnp324nIRuyUI@ghost>
In-Reply-To: <Zdjcnp324nIRuyUI@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2668:EE_
x-ms-office365-filtering-correlation-id: 927caf0e-f4e0-4301-2e20-08dc349b62ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2r0D6yNDpaaFIJV0r9EHG2CE93Is6u6gVMa+huMKoXAJrRkFiRbTKPeVgk+lm4o2b5mBnxwnoNiro4i8/R1cmLujMIjsM0KnqB2clEywhhf/Yq2RkN54azOAoI6gZR2x7llkm1rxE5vOPEjodmP1w2DSF8Nti2L5Eltk5ZAijvw8GXnAvEUGfHVB1idl1FyiqO30Q0aeLL2DCVrHj76Fu/o4puoUuiDyfC+kLQKsE07mkwNGoI8L1k6QuxsIC8ZKOL4xJhVmUS1XjiNi+9kibZz4BbgfxfEsC9DoYnUL56siHki5qgFsz6Wc5NVrfux02VmF5fn/fjHXWyDuA/YyvHxf4VeW3LCdaJCMhDvhwWAsoOEx5immZYyTRNNR0gEGyyjVRn/6Z4pOZFSsv4TIpM2OsIOatC9U8deAuv3g68n+0as67+ck+QDZY31yqko1WBH9gU2rTtYEiZQ/tK3YUX9mW76jT0yt3RFg15zV2axjPRtFUNPDREylYh89cmPcX2bt+k5cD/ISig1/kAC64cXYFAHPvnvYh8C1zlgdJezO23UYY8KYe9dATN07ft16/fm6DtZ8MQl28z2QKoHy0XiPmQOEmM//9ljJ28gd2Z8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VXhjdHBlMTlCRVVsM2o5KytzOWwydXc1UUdVUTlsVVN5elZTTG56bDJrNjcv?=
 =?utf-8?B?T3laQmRoVXd4SU9JaWN3WE9TSE5QVVc1dVpRakZXRzFVT1A0SlRpYzQrOEdK?=
 =?utf-8?B?OUVHejczUmM1dDNuazN4VXMvZHpuODdsY21TcEU4MlhjSHM2OTJGMURnVUhz?=
 =?utf-8?B?a3JFMGFUL0ZOWE5maS9oNnhxM1dQdU1LeFhLMWVQa3o2YkJtcXBFamI3QzBF?=
 =?utf-8?B?OU1lNldnYmo1VGRzVlVXb010NXkyeTl3b1QwS2ZpVHRsQSsxM2pJc3gzVldE?=
 =?utf-8?B?MW9pcjNyRUp4WHYvdDBkYUZ6YWRldFZkQWFTL1lWMkE3ZmVMWVBpamxxU0Yr?=
 =?utf-8?B?Q1c5L0Jnb25IZTJ2R25tUEZzYlV4b1MvVk8vdE1lcXhHUis1elN0amFkQzFa?=
 =?utf-8?B?M1l0OElBeE81OFVxZG9kWjgwMUp1dktEclU5dG5iT0pFTFM5TVhXNWtma2R3?=
 =?utf-8?B?SythMzRCVEVNek96N21ESW4wMkw2RW9hR0d1NUlYTzdQdzJLR1g0aFU5emp0?=
 =?utf-8?B?S29qMnYwRVM2N05rRW8rVGg5UEduQVFGMTMvOWhlcFM0VXMwK0M5Y0tETEZy?=
 =?utf-8?B?N0pPbkxGWjMyYUlqTU1UcEpRb3hNWmJmdFdTOGRseVFocHJFRzBkZ3hjSU9o?=
 =?utf-8?B?M0wyU2VINVZ0UkdZcGVTbU1hNUs2MllSM1RLbnNpODh5YmU2cFZXdHAvZXNj?=
 =?utf-8?B?b1JDZkdMZHlNeXlGdGUrOE1LbCt6YVQvc2xFUmltRXZmRUZaZkpCY0xURmFM?=
 =?utf-8?B?N1pkWExEV0h2QTdiMEZsMXp0UzF6U2FyUnJ6RHFGRDVUcHVTMjUzeHU0ZER6?=
 =?utf-8?B?S2pzTy9oVTQvckxvMFc2MXpYemlJR2w4RWtla0M5clNZRGlTcCs1U2JmNnpN?=
 =?utf-8?B?TnpQNmRVRHFHUTVweGlYNnNJQWRLN1ZIeXFETzdXTWFaais3ZlFyZm84NWRm?=
 =?utf-8?B?akRPZU00NFQ4emxGSTY4d3d6NUlSUVpveTNSakI0Mm1oVTVzRTlWR3o5VDYw?=
 =?utf-8?B?OGRJN0lrYXE0WGRqMkY2dVIyVnQ0R2lyeGpydTJBTkZjb2c1a2s4L05rUkpR?=
 =?utf-8?B?YlhIb3NwK0g5UFNuUldHTFVPMGVxNmVaTE9HcS9RYi8wSWNieERqQ0NMRy91?=
 =?utf-8?B?QTdSMUVESDlQd2dkQjJMZUMrTGtpaDhYaUZIZnMrNmhVZzJRUEQ4TlE5eHpX?=
 =?utf-8?B?Y29wMlpOR1VrN0NmOTJHTWNvNE5VZkwvZEpOSVpzMTRiZkROTkEzUGRZcFlY?=
 =?utf-8?B?MFVnWGdyS1pyOXk2YWwyTVMvOENrYUhybzBNc0hlaG1aZmt0TnpkRU9qN043?=
 =?utf-8?B?UDFEVCtSZDAvdkltVktEVnkwWUJQVjg4dWdTL0Fvd0U1VERYQk8wR1pmY002?=
 =?utf-8?B?NDhBMDFLeUZUSThnN01jK09zemJkVUsxcWpDclZJQW9oeU01eFRkeUllTVhR?=
 =?utf-8?B?TjlYRExPdnY0c3hWdUJJOWYrNldBVGlaTnNxeThFSHFhbEtwZ1d1YkR4L1dB?=
 =?utf-8?B?V29JSXlPQmJpRXVRL3JyRllhdWFCYTh3UDBpMTh1Zjd5eE51MFoybEhoTThI?=
 =?utf-8?B?cnJTeXA0c1dIbnI3NTZJSnRzZ1NvdmUyMExHZEgwRW54VG1sM3dLT2RBVG1X?=
 =?utf-8?B?TmtxWDIvZCtNdkFmVktteUZVN1ppaFRrOVN2WjY0RWsrM1hnRHk0WTRUbHVV?=
 =?utf-8?B?SjFNOHFrZ21VT1dNd05PaVp0SGxDdHhhZ3hvNWs5c3ovcEV1RUZSS3JkdVha?=
 =?utf-8?B?YldXL2o1Z1ptNE1DY0psanRFaVVOOUhma2NPckpuaDhGQ2RTYzFBcDYzU1pJ?=
 =?utf-8?B?UUY4SmZXL1o0ZldEYXJpT3lOcXlJVEJISVhtUHE5MCtjZWV1TGNKa0VsdzN3?=
 =?utf-8?B?enZHYmJhYnU2VURPc0xxeTVvN2Q3YVZPaXk5Q0hxWVpkNnNBQ2wveE5ZTjhE?=
 =?utf-8?B?RSsrTTBkSVdxei9OTGMrSCtRRHdnblpSNlZoYklRaFk4bnBuWHZGZGhWMi9U?=
 =?utf-8?B?SmJGbUdWUll5RWdsU1ptVTBSRWFCSXBJa053ZjBQcDFMOHVzbWZiSmhEaHo0?=
 =?utf-8?B?Ny9mSi9SdndDdzlaNDgxY25ZejMrV2lCdVZzbkVPNnNSKzRlQ0I2WDlnZ2k1?=
 =?utf-8?Q?J949jmcnfyQUFje/PwQcWJBzg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75B68E60AE434F46AD597BB99204595E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 927caf0e-f4e0-4301-2e20-08dc349b62ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 18:15:16.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDO+NBXSFIDXqUkuOiHUuRwqbWL/lRmwVw2H44bcTiZj7cgpRg05pe6qXmUwtYdiKtY3LAO+F8x3qlUk6m0BKcgIOTUEYucpbBRoR3ttn6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2668

DQoNCkxlIDIzLzAyLzIwMjQgw6AgMTg6NTcsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBGcmksIEZlYiAyMywgMjAyNCBhdCAxMTo0MTo1MkFNICswMTAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4gQ29tbWl0IGIzODQ2MGJjNDYzYyAoImt1bml0OiBGaXggY2hlY2tzdW0g
dGVzdHMgb24gYmlnIGVuZGlhbiBDUFVzIikNCj4+IGZpeGVkIGVuZGlhbm5lc3MgaXNzdWVzIHdp
dGgga3VuaXQgY2hlY2tzdW0gdGVzdHMsIGJ1dCB0aGVuDQo+PiBjb21taXQgNmY0YzQ1Y2JjYjAw
ICgia3VuaXQ6IEFkZCB0ZXN0cyBmb3IgY3N1bV9pcHY2X21hZ2ljIGFuZA0KPj4gaXBfZmFzdF9j
c3VtIikgaW50cm9kdWNlZCBuZXcgaXNzdWVzIG9uIGJpZyBlbmRpYW4gQ1BVcy4gVGhvc2UgaXNz
dWVzDQo+PiBhcmUgb25jZSBhZ2FpbiByZWZsZWN0ZWQgYnkgdGhlIHdhcm5pbmdzIHJlcG9ydGVk
IGJ5IHNwYXJzZS4NCj4+DQo+PiBTbywgZml4IHRoZW0gd2l0aCB0aGUgc2FtZSBhcHByb2FjaCwg
cGVyZm9ybSBwcm9wZXIgY29udmVyc2lvbiBpbg0KPj4gb3JkZXIgdG8gc3VwcG9ydCBib3RoIGxp
dHRsZSBhbmQgYmlnIGVuZGlhbiBDUFVzLiBPbmNlIHRoZSBjb252ZXJzaW9ucw0KPj4gYXJlIHBy
b3Blcmx5IGRvbmUgYW5kIHRoZSByaWdodCB0eXBlcyB1c2VkLCB0aGUgc3BhcnNlIHdhcm5pbmdz
IGFyZQ0KPj4gY2xlYXJlZCBhcyB3ZWxsLg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBFcmhhcmQgRnVy
dG5lciA8ZXJoYXJkX2ZAbWFpbGJveC5vcmc+DQo+PiBGaXhlczogNmY0YzQ1Y2JjYjAwICgia3Vu
aXQ6IEFkZCB0ZXN0cyBmb3IgY3N1bV9pcHY2X21hZ2ljIGFuZCBpcF9mYXN0X2NzdW0iKQ0KPj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3Vw
LmV1Pg0KPj4gLS0tDQo+PiAgIGxpYi9jaGVja3N1bV9rdW5pdC5jIHwgMTcgKysrKysrKysrLS0t
LS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbGliL2NoZWNrc3VtX2t1bml0LmMgYi9saWIvY2hlY2tz
dW1fa3VuaXQuYw0KPj4gaW5kZXggMjI1YmI3NzAxNDYwLi5iZjcwODUwMDM1YzcgMTAwNjQ0DQo+
PiAtLS0gYS9saWIvY2hlY2tzdW1fa3VuaXQuYw0KPj4gKysrIGIvbGliL2NoZWNrc3VtX2t1bml0
LmMNCj4+IEBAIC0yMTUsNyArMjE1LDcgQEAgc3RhdGljIGNvbnN0IHUzMiBpbml0X3N1bXNfbm9f
b3ZlcmZsb3dbXSA9IHsNCj4+ICAgCTB4ZmZmZjAwMDAsIDB4ZmZmZmZmZmIsDQo+PiAgIH07DQo+
PiAgIA0KPj4gLXN0YXRpYyBjb25zdCBfX3N1bTE2IGV4cGVjdGVkX2NzdW1faXB2Nl9tYWdpY1td
ID0gew0KPj4gK3N0YXRpYyBjb25zdCB1MTYgZXhwZWN0ZWRfY3N1bV9pcHY2X21hZ2ljW10gPSB7
DQo+PiAgIAkweDE4ZDQsIDB4MzA4NSwgMHgyZTRiLCAweGQ5ZjQsIDB4YmRjOCwgMHg3OGYsCTB4
MTAzNCwgMHg4NDIyLCAweDZmYzAsDQo+PiAgIAkweGQyZjYsIDB4YmViNSwgMHg5ZDMsCTB4N2Uy
YSwgMHgzMTJlLCAweDc3OGUsIDB4YzFiYiwgMHg3Y2YyLCAweDlkMWUsDQo+PiAgIAkweGNhMjEs
IDB4ZjNmZiwgMHg3NTY5LCAweGIwMmUsIDB4Y2E4NiwgMHg3ZTc2LCAweDQ1MzksIDB4NDVlMywg
MHhmMjhkLA0KPj4gQEAgLTI0MSw3ICsyNDEsNyBAQCBzdGF0aWMgY29uc3QgX19zdW0xNiBleHBl
Y3RlZF9jc3VtX2lwdjZfbWFnaWNbXSA9IHsNCj4+ICAgCTB4Mzg0NSwgMHgxMDE0DQo+PiAgIH07
DQo+PiAgIA0KPj4gLXN0YXRpYyBjb25zdCBfX3N1bTE2IGV4cGVjdGVkX2Zhc3RfY3N1bVtdID0g
ew0KPj4gK3N0YXRpYyBjb25zdCB1MTYgZXhwZWN0ZWRfZmFzdF9jc3VtW10gPSB7DQo+PiAgIAkw
eGRhODMsIDB4NDVkYSwgMHg0ZjQ2LCAweDRlNGYsIDB4MzRlLAkweGU5MDIsIDB4YTVlOSwgMHg4
N2E1LCAweDcxODcsDQo+PiAgIAkweDU2NzEsIDB4ZjU1NiwgMHg2ZGY1LCAweDgxNmQsIDB4OGY4
MSwgMHhiYjhmLCAweGZiYmEsIDB4NWFmYiwgMHhiZTVhLA0KPj4gICAJMHhlZGJlLCAweGFiZWUs
IDB4NmFhYywgMHhlNmIsCTB4ZWEwZCwgMHg2N2VhLCAweDdlNjgsIDB4OGE3ZSwgMHg2ZjhhLA0K
Pj4gQEAgLTU3Nyw3ICs1NzcsOCBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NzdW1fbm9fY2FycnlfaW5w
dXRzKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+ICAgDQo+PiAgIHN0YXRpYyB2b2lkIHRlc3RfaXBf
ZmFzdF9jc3VtKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+ICAgew0KPj4gLQlfX3N1bTE2IGNzdW1f
cmVzdWx0LCBleHBlY3RlZDsNCj4+ICsJX19zdW0xNiBjc3VtX3Jlc3VsdDsNCj4+ICsJdTE2IGV4
cGVjdGVkOw0KPj4gICANCj4+ICAgCWZvciAoaW50IGxlbiA9IElQdjRfTUlOX1dPUkRTOyBsZW4g
PCBJUHY0X01BWF9XT1JEUzsgbGVuKyspIHsNCj4+ICAgCQlmb3IgKGludCBpbmRleCA9IDA7IGlu
ZGV4IDwgTlVNX0lQX0ZBU1RfQ1NVTV9URVNUUzsgaW5kZXgrKykgew0KPj4gQEAgLTU4Niw3ICs1
ODcsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2lwX2Zhc3RfY3N1bShzdHJ1Y3Qga3VuaXQgKnRlc3Qp
DQo+PiAgIAkJCQlleHBlY3RlZF9mYXN0X2NzdW1bKGxlbiAtIElQdjRfTUlOX1dPUkRTKSAqDQo+
PiAgIAkJCQkJCSAgIE5VTV9JUF9GQVNUX0NTVU1fVEVTVFMgKw0KPj4gICAJCQkJCQkgICBpbmRl
eF07DQo+PiAtCQkJQ0hFQ0tfRVEoZXhwZWN0ZWQsIGNzdW1fcmVzdWx0KTsNCj4+ICsJCQlDSEVD
S19FUSh0b19zdW0xNihleHBlY3RlZCksIGNzdW1fcmVzdWx0KTsNCj4+ICAgCQl9DQo+PiAgIAl9
DQo+PiAgIH0NCj4+IEBAIC01OTgsNyArNTk5LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9jc3VtX2lw
djZfbWFnaWMoc3RydWN0IGt1bml0ICp0ZXN0KQ0KPj4gICAJY29uc3Qgc3RydWN0IGluNl9hZGRy
ICpkYWRkcjsNCj4+ICAgCXVuc2lnbmVkIGludCBsZW47DQo+PiAgIAl1bnNpZ25lZCBjaGFyIHBy
b3RvOw0KPj4gLQl1bnNpZ25lZCBpbnQgY3N1bTsNCj4+ICsJX193c3VtIGNzdW07DQo+PiAgIA0K
Pj4gICAJY29uc3QgaW50IGRhZGRyX29mZnNldCA9IHNpemVvZihzdHJ1Y3QgaW42X2FkZHIpOw0K
Pj4gICAJY29uc3QgaW50IGxlbl9vZmZzZXQgPSBzaXplb2Yoc3RydWN0IGluNl9hZGRyKSArIHNp
emVvZihzdHJ1Y3QgaW42X2FkZHIpOw0KPj4gQEAgLTYxMSwxMCArNjEyLDEwIEBAIHN0YXRpYyB2
b2lkIHRlc3RfY3N1bV9pcHY2X21hZ2ljKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+ICAgCQlzYWRk
ciA9IChjb25zdCBzdHJ1Y3QgaW42X2FkZHIgKikocmFuZG9tX2J1ZiArIGkpOw0KPj4gICAJCWRh
ZGRyID0gKGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqKShyYW5kb21fYnVmICsgaSArDQo+PiAgIAkJ
CQkJCSAgZGFkZHJfb2Zmc2V0KTsNCj4+IC0JCWxlbiA9ICoodW5zaWduZWQgaW50ICopKHJhbmRv
bV9idWYgKyBpICsgbGVuX29mZnNldCk7DQo+PiArCQlsZW4gPSBsZTMyX3RvX2NwdSgqKF9fbGUz
MiAqKShyYW5kb21fYnVmICsgaSArIGxlbl9vZmZzZXQpKTsNCj4+ICAgCQlwcm90byA9ICoocmFu
ZG9tX2J1ZiArIGkgKyBwcm90b19vZmZzZXQpOw0KPj4gLQkJY3N1bSA9ICoodW5zaWduZWQgaW50
ICopKHJhbmRvbV9idWYgKyBpICsgY3N1bV9vZmZzZXQpOw0KPj4gLQkJQ0hFQ0tfRVEoZXhwZWN0
ZWRfY3N1bV9pcHY2X21hZ2ljW2ldLA0KPj4gKwkJY3N1bSA9ICooX193c3VtICopKHJhbmRvbV9i
dWYgKyBpICsgY3N1bV9vZmZzZXQpOw0KPj4gKwkJQ0hFQ0tfRVEodG9fc3VtMTYoZXhwZWN0ZWRf
Y3N1bV9pcHY2X21hZ2ljW2ldKSwNCj4+ICAgCQkJIGNzdW1faXB2Nl9tYWdpYyhzYWRkciwgZGFk
ZHIsIGxlbiwgcHJvdG8sIGNzdW0pKTsNCj4+ICAgCX0NCj4+ICAgI2VuZGlmIC8qICFDT05GSUdf
TkVUICovDQo+PiAtLSANCj4+IDIuNDMuMA0KPj4NCj4gDQo+IFRoZXJlIGlzIG5vIG5lZWQgdG8g
ZHVwbGljYXRlIGVmZm9ydHMgaGVyZS4gVGhpcyBoYXMgYWxyZWFkeSBiZWVuDQo+IHJlc29sdmVk
IGJ5DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMjEtZml4X3NwYXJzZV9l
cnJvcnNfY2hlY2tzdW1fdGVzdHMtdjktMi1iZmY0ZDczYWI5ZDFAcml2b3NpbmMuY29tLy4NCj4g
DQoNClRoZSBpZGVhIGhlcmUgaXMgdG8gcHJvdmlkZSBhIGZpeCB3aGljaCBpcyBzaW1pbGFyIHRv
IHRoZSBvbmUgZG9uZSANCnByZXZpb3VzbHkgYW5kIHRoYXQgdXNlcyB0aGUgc2FtZSBhcHByb2Fj
aCBhbmQgcmV1c2VzIHRoZSBzYW1lIGhlbHBlcnMuDQoNClRoaXMgaXMgdG8ga2VlcCB0aGUgY29k
ZSBob21vZ2VuZW91cy4NCg0KQ2hyaXN0b3BoZQ0K

