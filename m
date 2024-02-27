Return-Path: <linux-kernel+bounces-83525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ADD869B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A204B2975C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4C14690D;
	Tue, 27 Feb 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="WmgYdoGn"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DB9145B01;
	Tue, 27 Feb 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048645; cv=fail; b=TNFJZrdGBl08RgQ6EKWvoFTYWiYokjobW2+BSSogdXG6qw7oAXb7xuGJXRY3XJmpxUmNDwEyMb2zkIDNy3trZQJHni9OGH0WDSMT2/R0jpUn7Xd1hmL7wF/AY5r6eOoOJKHv0iEFozHUZbjJApfRggvh4SqFAcDfV8d3t0XN918=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048645; c=relaxed/simple;
	bh=gvW10nTrXwrNlASEP4xEDLcucADAhctp33iqE0ZAJQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYDa56GPihD1V9ebSUBEgHiNarQRRsFlbxN5XIFZFAVaimXGpODo+UH1CAs0mj1OuzjL/I8yblOCxwhNWu8mAs0Qf12nyuOccrSMJ0U0zwNiYMUte2NbsWdCoqiE/6nEER0XGmtvZmw+418CmOkBpH0pqN5qIwjhVaxHpIHmkkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=WmgYdoGn; arc=fail smtp.client-ip=40.107.117.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/eGgsZ+ham1lXyK392TZR7ORdglO5Fu9Fl8mv0yvcBhNGwqAL1GzhL2VzVL8N4yHPnKqgFiIYXy+jbkyCEFgi3y0W7vMfnKGWzS+ZU48aZ57AnUt4OrPux/XjZ2+47ipqGzeU4WkfKtgJ6tMoiz7I6SPxGlCK14lK+aop05Z+tyzW25ZlfU1rry27RXGv5djlHFR4pz0mWnq8CIEe82vsAv2pKtyywzbCqatd5MHFG+D07CL7bjd0NXfUIRtLOdtbtc2DN+mVx/yD2KPooRjaQf50sakGDuPXtT+pv7lf4RknZJffjGVMWzTBO28e5Qq59mfOyAcJ2fNQTNLlmdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvW10nTrXwrNlASEP4xEDLcucADAhctp33iqE0ZAJQk=;
 b=VEFVzEQ13mdczcNNi6ZS4A/i1ZlMxWvLPpP3MKRu/o+ofKyrVPMjJgynn79JgPAWHu5Rnluilpdln5Aw9xtiYXHsIKyt30ddvlGD2N5FMN+8u9YwhCcas7DRvOZlsa8r8+umMR4Fdq9pwiUp8UR8vaOeIFsMrG0WZoIP2mbtofDUpLSmO4TbCAH7fdrMuWyHsbILtVXFXTTLWaPrIx7xTU+HMzRWo2gbqYU7vkI1fdHTj+f5xrWo/rAAlfMdK5DoA6RhW2XBuXlifTr49FhT/Db0RazwwlT4M5+0SWxvuZFVge9rF/F4gBpKhjp9JCXQlmK7YReFolReyhOUtoYiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvW10nTrXwrNlASEP4xEDLcucADAhctp33iqE0ZAJQk=;
 b=WmgYdoGnHMjiUgLtF9/Ge9xKsjh8TBEsZFPmP5hDU3ZEaJSHDI2W2OnrVYEIyBsmNEJegMob45/iZ4+uA+MLYCDETdCZDwzFxlC7ntxhdsYi4dCd21sdS2p7uytFYgQFqfNRkedjWFeVMubb0fwWM0EXbHdyLD9iy00TSsdEvI8mWwMc2gAwRM+MT++u6zt0GFfU13OdAN10oOEO0HnqMwfgzRcVUJDIF5psUTSbprpW5v5UVtTDIX7YRKOQFES6GtElMS+kdpEIGacXhjGHBOPYKZwtrxeBuztWltXkmLmORRjbhKD+tn7Bj7zdoSVLevTgMD9gg68okaPJWqwJoQ==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 TYSPR04MB7523.apcprd04.prod.outlook.com (2603:1096:405:30::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Tue, 27 Feb 2024 15:44:00 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::d7ad:6be5:d8bf:6f92]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::d7ad:6be5:d8bf:6f92%4]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 15:44:00 +0000
From: =?utf-8?B?Sm9uZXMgU3l1ZSDolpvmh7flrpc=?= <jonessyue@qnap.com>
To: Hangbin Liu <liuhangbin@gmail.com>, "jiri@nvidia.com" <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jay.vosburgh@canonical.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andy@greyhouse.net"
	<andy@greyhouse.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, Jiri Pirko
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Thread-Topic: [PATCH net-next v3] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Thread-Index: AQHaaQW6oy9l+UHDLUqKxFSfovO8KLEeUytN
Date: Tue, 27 Feb 2024 15:44:00 +0000
Message-ID:
 <SI2PR04MB509754BA193576FECA74D5DBDC592@SI2PR04MB5097.apcprd04.prod.outlook.com>
References:
 <SI2PR04MB5097BCA8FF2A2F03D9A5A3EEDC5A2@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <16063.1708987620@famine>
In-Reply-To: <16063.1708987620@famine>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|TYSPR04MB7523:EE_
x-ms-office365-filtering-correlation-id: d1099f73-66e9-4989-979d-08dc37aaeae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rAAh2ZIZgDxspPl4cFBq5EfTirGQb5m5NH4vOlQms2uRzx7d73dHAqCEgpbP9EyWdoOeOWRqCwaHM+xgm+q+YxFQAU6TpKHPecQuf1eIfeacQFzzfulbPm0+aOCMeiuILb9IwPSs8P3VACue+lifPgI+lY0j8jiH2mRhX0ABCene7mux1FN6LEH7HOkzkDfHLMS01h0dK1TclHPWwM1LnUaQSUUTnm8Cgb/I/hi2dzZMeDzRDBaHP6/yuAjDL5pZ5gezrMAjo/MaMfAzcZ2WL2n5OPol+wqlBECDCDa4GzKZqP0xur8LA7yM8cD4/nzY8m4+igE8XG7OlWTGlBOPzL+YQg3wKyrDbojD+D4jdGt+RT7VMIJ1rswry7XIdUaetvxzxzvz8ZFY71O1tgJcN6YjaQe9r8uT5JqDAFymVKx4JC8/gKuSiYqL5dfipr2TCbnmc+u46O9srqR31jQ4cxGygVO4770uiJTjbmWgCV3f5/p7Nvoy7FBkp1I1C0ju53u/6oi7xlXF18vt5ruF2s4wz0N/PV/Ox1dxpkVx/K4rNbtSfghYkLzaNTP1TnLoxhR6dA3tKAMpvmSHCHkefJpfCObrMxtLEfYmj8KhelVD6eRo1i04/PCgpVyBiSL3Bhl/agfIVgPnFkgguFXLcb6mDpkT+qrjg0d8sJdzSqyY56Q6sTO1JEHozAZ9P1pe7WFVIoXMHb0n8rIEOdbJ/g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UncrR0RNd2pnRGFaY1pvc3FLVUVmSWNVR1ZPTE84MEMwNGxzRmMrbWxKY21t?=
 =?utf-8?B?anN2TW82YmhtdzdQOEpqdkdUS0g3aTEvbDlDdERtSktJZkpBM0g5a2JjejB2?=
 =?utf-8?B?RTJiTzNQUU5nMlE2U09lRWtmMkpNaStJQVFlWmpKQUlXZ2Y5UjZDTFg5YzJZ?=
 =?utf-8?B?TVdkNDY2NWExaEVRa25sUml2Z2NsMVpER002bHozcDdCaDdaZXV4djNHZkdL?=
 =?utf-8?B?ODM0dzdPaVlybnpzRnJqUkh2dWRVSFIwS25PWUVEWXREbWUwVUJtR3hFcWFC?=
 =?utf-8?B?TkhBYjVsd0dSOFg5SFZKUVJrREtKTzQvanh2MWxCTmF3QytZbDk4NHNnQWFn?=
 =?utf-8?B?WXZyR1pEQTZYVStnOEVtUjNUWmNqNnF5QzB1ME90M1FQclNhWW8vUTFXZGxu?=
 =?utf-8?B?TlVtdW9sR1EvU0V1ZUhRVWthMG5CUUJrOWNJRis5MjdLSWwyV04yeHVra0p6?=
 =?utf-8?B?dG83aVdsdE5OVld6SHQvWW5Gdk1nVnI2OE80RENQT1JJT3dRd1VIbFdPbFpl?=
 =?utf-8?B?VWwrNWZsSFJUNmJuZExLM0ljNURCWWpZT3hQVWhCR0U1SndnRUpoV2RyeHIy?=
 =?utf-8?B?Nzg0dm5WTTZHQlZzVTRoeW9yTFp1bEQ5SkxSQVBQN0Q0eFZPTjRyaEdQRGxL?=
 =?utf-8?B?aEo5MnpHZGEzc3ZwVnlZOUUxU3Z2Uzdnb3RvbEZPTmNOZ1BrMXRnd3BUWUo1?=
 =?utf-8?B?WXZtdVk5a0xaOXVoeUgxK2lrNDBXRWNleEwxYWdlYVlrQjlRRXhSYmVva251?=
 =?utf-8?B?OEV5SmwyQlptcFc1TStmRXN1VXRZTDcrZHpqcUM1YThNVHpwNW52R2lsWklJ?=
 =?utf-8?B?QjJyZVY5M0ZKQklrM0RTanB3b2ltTWV1QnlzZ05hbVNDWDJ3elRiTmxsVFNU?=
 =?utf-8?B?eDVaYy9Ka0E2VlA4N0poZlhCaC93ZGZISm5sQ29xTng2UFI2aURrTlFQckgw?=
 =?utf-8?B?b3ZvVXEyUGQwbmRqNURDVFhnMEpTRERtb3N6TmtMNDU4dGtEUFhMMjFFWEs2?=
 =?utf-8?B?Wm5HeVB3ZWVONmJEejFOd1RiQkJ5TFVGZGQySzk3TlgrU000dVVNS0hCVmk5?=
 =?utf-8?B?WFRNQ3JWdTN0U2RKMW1ySXovU2pSOTcxdG9vNVU5L3pIM2FET2tmT2VBOTlZ?=
 =?utf-8?B?ZGlIV3ZDZDQ5K3krYVUyZFlwME1xaHZBdE1VK0IvN1JyM3lSZ2VqUGEwWXRy?=
 =?utf-8?B?SExvbWFLcVh5Ny85aStHemd6bUpYTGw3Z0V6SEcyc2lKUXlWcFJ4ZHRlSkpG?=
 =?utf-8?B?QzhSb3BTYUliQzE1cE5aMVpPWXljY3UrdytoMEpwNGkvRWJLbjBOdCtCS3lT?=
 =?utf-8?B?T3E1KzFTdTh3TGdNdElsVE40RG05VDM4VXJVd0ZnWmlpdHMxN2RZUzBTVlRk?=
 =?utf-8?B?ZmpzOWhjaENQUmFueVJSci9TNkpyMFJPcFdLZXo5UHYwWG1xZVN5UjJSUDdm?=
 =?utf-8?B?dk5EYXUyd2Z0bzVwUUpBZ2pxdWhkb0xnQU4zU0hBYjl3dUNSdDNJZVpRNkpH?=
 =?utf-8?B?OUhLUTJJbUIrVFdIOCtrdmZxUUhOMWpMK2d3L0pRTHpIVVQwN0dMa01HSk1q?=
 =?utf-8?B?MmRuZ05NZmZOd3M2ZmhncThkVzJUSFhKanZncXQvc2JENGpCMzVLZnZWa3lt?=
 =?utf-8?B?ZDZMVW9FUFJma1lYeW4wbEZnK3lmNFJqNEY0RVR6dmZRMFYrNFNjOUVaamdJ?=
 =?utf-8?B?R0NFZWhwTGVNSkFjdkJ0S0JIQkYxbWRTbHl0TkNrTDJGMWg2SnJKK2oxRDlU?=
 =?utf-8?B?akJScHUvbHl3SEtDcjFINFJ0MHBRWDJhbnBtbmRRYnhob1M3SnBtdnFnS0Mx?=
 =?utf-8?B?dTlUU1dZS0pFcDFvRitqYWhtakpTQ1piWHd6V3NYZGhRKzZIOVk5b1ZNL0s4?=
 =?utf-8?B?WUdZaVVyMXEvYUxiQ2NhQ2dzbEhyQUJKMkNZTmlWOHlzTHB2QWJ6bE5mbUZL?=
 =?utf-8?B?S21NRTZCdXNBa1RFZENpTlZBWE0wWGVCRWsybmhVbEJvdVg0bTFxaFB3SUpZ?=
 =?utf-8?B?ZzRCNXI2b2lZdFM1NlJkdm1LR2x6MStsaXduM0ovTVpXbE1rVnJ3bXlOWmN4?=
 =?utf-8?B?US9IbzJrMjB5TXE2UUw2RE8wd0JtakdETWNHU0hkWVNDQkp1MVVPdTRUUWVr?=
 =?utf-8?Q?Z74s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1099f73-66e9-4989-979d-08dc37aaeae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 15:44:00.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++3pscQ93/hC+I/y6+ifICpaZBB28/I2G5HI0H8we/aqDuUUWesTHP7fwU+YHib8205IYB4/cNW5H1ktlIm+cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7523

VGhhbmsgeW91IGZvciBraW5kIGZlZWRiYWNrISBIYW5nYmluLCBKaXJpLCBKYWt1YiwgYW5kIEph
eS4KCj7CoCDCoMKgwqDCoMKgwqAgT2ssIEkgbWlzc2VkIHRoaXMgYml0IHdoZW4gSSByZWFkIHRo
ZSBwYXRjaCB0aGlzIG1vcm5pbmcsIHNvIHlvdQo+IGNhbiBpZ25vcmUgbXkgZWFybGllciBlbWFp
bCdzIHF1ZXN0aW9uLsKgIFBhdGNoIGxvb2tzIGdvb2QgdG8gbWUsIGdsYWQgdG8KPiBzZWUgbnVs
bF9tYWNfYWRkciBnZXQgdGhlIGJvb3QuCj4gQWNrZWQtYnk6IEpheSBWb3NidXJnaCA8amF5LnZv
c2J1cmdoQGNhbm9uaWNhbC5jb20+CgotLQpSZWdhcmRzLApKb25lcyBTeXVlIHwg6Jab5oe35a6X
ClFOQVAgU3lzdGVtcywgSW5jLgoK

