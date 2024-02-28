Return-Path: <linux-kernel+bounces-84701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4FA86AA70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DED71C21DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE612D605;
	Wed, 28 Feb 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="dd1bLmPp"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540862D056
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110222; cv=fail; b=V4UsNpS5Q/wCLem0OU2gnwIFzIldNuXuZ4EOKjOXMXPP8TuDzdPiX6juHjdDf2+JVCE0JYnTkTkYzlz9QzImMZZgkaoV5IpVwlyt9q225/GVQIvT6yaC7qz59cGbLUYtGUQfN6tkl2ICTikqmD6BYruglvdSIVkiPFNshLTe1Ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110222; c=relaxed/simple;
	bh=5N7FqwmmZvqN09JjQRn6vDNUpQVIPMwU9aMA0Nx77NI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=C+8Dm38u9rDJ0ro8wSWFovmek27Wf656bXwpPNXsWX9IJIElqt+EHFnlDjYSoq5fSrRl8mmfiRE/7/F7ijM4/cI3FduuX/iaA7oLcqR9IREQcMMM1YQ8jfWRf7nIgVFCJShliATo1k1nUq++88hwiLzxcaFi5tj28pxa1JEhib4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=dd1bLmPp; arc=fail smtp.client-ip=40.107.255.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8Qum3/p14PBnh5u4JO9Uv5f41Wz09I8I+57dmfuRg8+aQYcH2wxbPELGv+x4oUrEMsB1jdd1YuP2jfB3uuMituLmYWcVA2S8SsjWawscCNHceAqeLtXxeSTM1EiEvmUuNjSOHshXx+hoxXx3SvrVPyvvsSYXoTJSj7PKBl2QtNiIlBjhYAzXN/5G0L3Q4I6h2WmYAGn6Br+9dMae3bOm2lZEibK73rg9I2pWMAsTCy7dDgYYj1kLRTtxtTugAE+PBRNP9jArTl2medBCiNDy7hLcqLvEXG+Zk25lrjjJTv7g9TZkElvKisUUqMbtcHG94QVMVpIcJH6zrk3TdqFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N7FqwmmZvqN09JjQRn6vDNUpQVIPMwU9aMA0Nx77NI=;
 b=l8VuzxG4t49IePNw3TyZsV6PoPmTtr/LrDPhs8+kJJ7GfV1S1biUnLQwNe8/moiaxashjyLJdGY3Oir/Rz9oWVz6waGexJgb+G1/qJWfPIQTivesP0xM/FpsFipqLQIMlP/PBCDYYsAH6XaNyxdGk3bPfFifROneqhZ1ywrBh1jmTYpdgpcSpG12FH4uDAoSjweL/d7l0lqhSXQiddxTm4XaRKnHcxy8jCZ3wJLV4N/zOha6CfOREkb6tRM7+8S4XVuDYcDd4ZqTLAuVI0tPf9EuxoprYDVFLgfzWcAryXvBuFfzcmZIkvRoZ3S3vZyCsI+P6rNi7KNMux+d+TU4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N7FqwmmZvqN09JjQRn6vDNUpQVIPMwU9aMA0Nx77NI=;
 b=dd1bLmPpIYvZ33DHrP2ECD9I8TFY58qkVhZ8xS1LMw+edJkEVXrh3qdSXSUNcmUVWe0EY4oRMQEXVcDE87jhHbRuSqFaFrRN+Y74KVvg1pQX030pQNL2IvEzaNgPw5iLSEWLJuPeOXMp1Qr2eN5bSu43+S4ZIZmLlLAR7TGafOk=
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com (2603:1096:101:194::8)
 by SEZPR02MB7073.apcprd02.prod.outlook.com (2603:1096:101:19e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 28 Feb
 2024 08:50:14 +0000
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::c54f:7115:e36a:591d]) by SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::c54f:7115:e36a:591d%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 08:50:14 +0000
From: =?utf-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"urezki@gmail.com" <urezki@gmail.com>, "hch@infradead.org"
	<hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
Thread-Topic: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
Thread-Index: AQHaaiMl/BXt6+jxSE2MrtR/YdMwFg==
Date: Wed, 28 Feb 2024 08:50:14 +0000
Message-ID: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7164:EE_|SEZPR02MB7073:EE_
x-ms-office365-filtering-correlation-id: 11cdcb2c-3f9a-4b03-2476-08dc383a47c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k2qcM6jbBYiAX8Zod+9UsL3BSA3sFqd69s3vk4inmpY69HPSzhCxj7DhmZIr6viTAQ3YyGLrRxujnY70dBDUqtKWkml4jmCRRp4vanzNDO+Mrlk1h1PhNXrloMZAoACrKtD1rc3GjxEiJeN1AMXTxB/dACZzjNyUlssJ4o20n89Wr5Rn0UqVT2lTr5JoyuGPPw8oHRUtp7EJG2z4kiKDGILQDeVp6X0kXpVsWf+YiPtlwEbPDbdxQn8U2ITMkmLIfT+oXdowtBF4acsv08/3nTP3prX0EZjRmzPFNBd4KblVyRKzU9xThzEwfChs5Dswway0e6BpIBaaFr7KYseDC/MhuGyix7G5n3RKHvLmP54CZEbd7XZhgD9WqJkiwFuwxmqRmzClODNLAgMoM9q97qiisMKxevWH4XlX/ExznDAKRz5Cpb6ibCa+i0FcxJFH94M/EC8Ww5mHDqZ+KR3ROZJV37/T5WyTwRl3m6+OvEUK0MJEBysfS0ncKUOOiV+Fd8RgqD1oS6sO75zJqNA8SzaKNS6FKISPot3pv97MIDkD/Uj4elzoH/mQ9duZo7pg4CvyQAo083B+TE6h/mn50IueWUICEDf1TTZhsy8YqSQHCWIhOXMDgVE6hrHZsHtcaidQ1U3/iYZUxzy+vDWoySRBVK2+mVVoRqjcVVa7K85N3h1nHbGHHs5kzSWcjW4KZGGFhGosy5opl8qekk6lUqLXy9r3cX/cDciLF82Ckk8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7164.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MytHVWRSdW1IR2Z1RGtHVk11VTN3NHhaLzEyOGdiL3Q5WEhnTWJYWE4zOVlY?=
 =?utf-8?B?ME5Bbmh2OFVLVVBPbzE4NzlIREtzTVZVc3p5bDkydXBDRnNPU2h1L3NZRFll?=
 =?utf-8?B?ZWhpSEpTeW5hQnkzcm9QTHZuWjhGZ0J5ZGxwWllDc2lub3lOMUVXMXo1WVFE?=
 =?utf-8?B?QnRDa29PekltcVZYdkUxdjFvZ0Q0SEhJRDdtay80TWhLZnZpMzRyeUlVYkl3?=
 =?utf-8?B?SmNCVlFWQ1huaGJIQ2YwR0owS2QxTFg3c2JDRUdBRzh1YVM2S0x4WTAxZGFO?=
 =?utf-8?B?bmNiU05NZVFtaTE0Y2U0aWdGUFdzQnA1c0FuSTE0Yk00SU84WFpac3VQbS9E?=
 =?utf-8?B?R1VneVdEQzJTN2NOZ3ovb2ZyMVVmTVltbHhZZENDdUlrYkFSUDR1OEZOM0I3?=
 =?utf-8?B?VUZoQjFXdW41ZmpkbkE5MVhNM1Jhd3lxa0t2UXB5VjBLT1JVQ2RaOFZnK3BT?=
 =?utf-8?B?enlyRC9hNWpIZ2FzVzRqdTUydGNmdW1pUGRNZlJjWGpzZVVOUk1aZHpWV2xF?=
 =?utf-8?B?VEtaTzVDSUtTRW8rUmxrenBNY1NNL1lONUsvcS9vc3d4SU52Mk5lemc1T2lV?=
 =?utf-8?B?bzA2NGFvb0VTTzlXOWtiVWhUVkU0cDVjbWdhZFV6dS93U1BLd3liZGFoUDRV?=
 =?utf-8?B?M241cUEvWVBEdGF2VG1TWDd1N04zV3ZCWEZzMy9NekhxbEVKOU15ekFlWS9H?=
 =?utf-8?B?T2lHUjd0dVRLYkFGTGZvYzdtc3Q4Z1FPNERldEkrVGdSdEcrelQ5YXNVMWNW?=
 =?utf-8?B?RTRRakpnR0dXWGRuVXBNbCtGZWlCTWZvSTVET2hJZGlqcmFTZU1PZHUvM05R?=
 =?utf-8?B?MUdJeGFvZXNBRFpnQWpIYkhwbDFwNU4zU05sQ2daanU2VlU4SnlNa2VJdHhZ?=
 =?utf-8?B?c3V1YUp1KzA5UnV0ZVc3bjI3Y1U3TzY3ZFZ1Z2xQVkRMUFpjSFYwb2RWOG1F?=
 =?utf-8?B?YmIrQ3BVNGNKNHlNVVdLTUxMV1ZvVjdLTHJkVDBpMnp6bVM3VlY2d00yditi?=
 =?utf-8?B?blJwVTA1WUFQUDNFVTk3YkU4a2lBR2F0WjBqK1RnNHE3QnZETUZzOGJXMXVY?=
 =?utf-8?B?YWQvOGxjbmo1ZWpjMG5meXhkcTVsZ0g3bkNlZXZoMVpueW4zRnQ2Q0dHU3pX?=
 =?utf-8?B?U010UFVMVGVSUlVLemdJcXYwc0NtV2g3eGJ1SXhDREo1dHU2STgwTk9zS3Rj?=
 =?utf-8?B?Y2RqWnN1c28zZUhwZDg0dmNSN3F1MjRERkVpd2szd1NML3ROMUNkK3FnNFl4?=
 =?utf-8?B?ZktyMlJPeG1hUmVqTTVwbUN0cXZQZ3ZyT0FoYm1uN1FXT1ZCak1YQllYa3Vp?=
 =?utf-8?B?MkNQMElwVjE0U3R6Mm04WFpIdXJRUjBnR0MvaHVzSUhVTlYzc0t2RTA1T2hl?=
 =?utf-8?B?MmVIMnFoUTkwQWlqUmJUZjFWSUV4aDBrSHRwc0pUYU15V3VZMFhoUHlVUlVV?=
 =?utf-8?B?Z295K01qZHJEOWk2bWJzUUNiQW9LN0hUdEthZ08yY1c3NUo3ckYrbFFuZ3Vo?=
 =?utf-8?B?N2lXTmN0RTVLSVF5aGtJdmwxOHhJdlExMXJIdWUwdlgxWGw1SzNod3dZejQ5?=
 =?utf-8?B?VUdHemE0VXlINzJId0J2T3l1cUdIWHVqWGlJM0IwNEt4MU1GdEh4Qkp3N2t5?=
 =?utf-8?B?VW5KS016WlZIOHJHWGdCSnlpYjRuTkhlU0FmV05yb2NtZFBDVEZzek5wc1B6?=
 =?utf-8?B?bnF5dFNNd1ZjSEZWbXl3MDNXUFNzdVRaN1BSZ0wrQUJRQ25zY3JBZnhSZXo1?=
 =?utf-8?B?eDVLTU9XSEhDUE13RmxJLzY4VkJZUXd4d2E3U3VjSWNXTEhBaThCUEhha0dh?=
 =?utf-8?B?cldaRDNyWlBUMUhWM0k5M3dIVEZlRmFDN043TjJVWXNZZGNUTGJkMEMyNFVO?=
 =?utf-8?B?RExIL0ZRS1VIeGhFNzhYSUlwcG14VkpJS3hVZkdnOGJDellHVGtXVlBCZmpp?=
 =?utf-8?B?YTZVYTJvOVJGY2V6VTVVMU9UQmVGN3pvTUorTGJUYzBzWFp5eXdvNXB0dE5D?=
 =?utf-8?B?Lzg3d2RxOFIraFQ3OU1MTFBFcmVGY1IxS3VZeVFXVEh0QU1kdnRkdVVPMEw3?=
 =?utf-8?B?MllzN0RIOCtjWHlienJXci9NOFBUWmJxL3NtNVd6MlgwTjNEQXVNeTN0ck9G?=
 =?utf-8?Q?SFQVgM4CgTFiVE/3/1274ZbP5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0ABAA4C1D45EF4FAF85C1B8F1DFCCD1@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7164.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cdcb2c-3f9a-4b03-2476-08dc383a47c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:50:14.3095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TOJVvBilI0oBwEmmdSu/o68AvRPTQb23YBjAl9kqetDzkWoyPUrwipK7oGPPEH2oxpbor7/NksL1qFVfXRmBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7073

SWYgdm1fbWFwX3JhbShwYWdlLCAwLCAwKSB3b3VsZCBjYXVzZSBwYW5pYyBieSB2bWFwX3BhZ2Vz
X3JhbmdlX25vZmx1c2gsIHNvDQpjaGFuZ2UgSVNfRVJSIHRvIElTX0VSUl9PUl9OVUxMIHRvIGZp
eCB0aGlzLg0KDQpTaWduZWQtb2ZmLWJ5OiBIYWlsb25nLkxpdSA8bGl1aGFpbG9uZ0BvcHBvLmNv
bT4NCi0tLQ0KIG1tL3ZtYWxsb2MuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL21tL3ZtYWxsb2MuYyBiL21tL3Zt
YWxsb2MuYw0KaW5kZXggZDEyYTE3ZmMwYzE3Li4xMDk3MzIwMDZjZjcgMTAwNjQ0DQotLS0gYS9t
bS92bWFsbG9jLmMNCisrKyBiL21tL3ZtYWxsb2MuYw0KQEAgLTIzODcsNyArMjM4Nyw3IEBAIHZv
aWQgKnZtX21hcF9yYW0oc3RydWN0IHBhZ2UgKipwYWdlcywgdW5zaWduZWQgaW50DQpjb3VudCwg
aW50IG5vZGUpDQoNCiAgICAgICAgaWYgKGxpa2VseShjb3VudCA8PSBWTUFQX01BWF9BTExPQykp
IHsNCiAgICAgICAgICAgICAgICBtZW0gPSB2Yl9hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsNCi0g
ICAgICAgICAgICAgICBpZiAoSVNfRVJSKG1lbSkpDQorICAgICAgICAgICAgICAgaWYgKElTX0VS
Ul9PUl9OVUxMKG1lbSkpDQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCiAg
ICAgICAgICAgICAgICBhZGRyID0gKHVuc2lnbmVkIGxvbmcpbWVtOw0KICAgICAgICB9IGVsc2Ug
ew0KLS0NCjIuMzQuMQ0K

