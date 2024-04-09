Return-Path: <linux-kernel+bounces-137027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0489DB4C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11861F2220D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2E13664D;
	Tue,  9 Apr 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="Ww55y2+r"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2094.outbound.protection.outlook.com [40.107.244.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988667F7CF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670630; cv=fail; b=JIKZhY+BF9LdZiqvtRLXBjvlg1ZCIJFJBstv8pryuBacLFkDJ34CeCLSGOtexPvykWHAbRG5EXE+mQe0iV0vB2B0nqK9xkoVf0xg92bhAttsrPJcvMMLQ1E9ybSd/NKbVVge3cUU9/OOEhi3wwO1kCzMWReYI3QIuDxALyDZ2SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670630; c=relaxed/simple;
	bh=F2FUaoNtSE43XrKdE9df+wCqjlplwYXe3geMQD9kbmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OSrlY+Nis0017AdayBlhnibmdih3nW1Q1TqMQbKhg5bbPiTrDFYRjrulHYFXWGG6SywpJHGe9xOBHYQpj9X6HkAHdD0Hh7A0xurTZg4u3HG7BAgAfMCP3RxCDmb1qn7A8alsDrl9I+Xz5npFwfR/p60/dTFV0lZ5pFyw+l7HNOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=Ww55y2+r; arc=fail smtp.client-ip=40.107.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG4kQ8mc+JBvi2yHo0zS738xRJTzz1EIDclwoGLiMca3aNdZgE25fyCo6xFE3Gwh7Q60cXb8yXOrpYdr8T9FTzsHou3s9jf/Kw/ZAU6GspJ+9kNa0BUwJy9OYKNeNTI0q/6L+GWoFz+ILXrTBjSAeKFiFHOvhGYFgl28wGaOtue1JE0ExjlwsriVnBWi1P7/z92YEqbnS6lISdLrpBlHb61XChcxJD+WJwTFlZmWjaiYkdUCDabkpVqP/id86Q8TYGUMl/3JLGN0gPxd2Xb9uByKylP7H2dW5YtjkrMNJjPW6Dqu8QuHbt+WgcMLDaahaLV+YTIdc3Oq/nfLYRFMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2FUaoNtSE43XrKdE9df+wCqjlplwYXe3geMQD9kbmU=;
 b=mGr8h0NkWy4YEzaOns712zjJPkEejzwpj9QYzOT3uSDAfFdJEKKcwCjI13WfQKVsBCGt34EOf8u8y/fGi5+QPlXlLIjQzoZRpFxVuRNHmR38aBSnOTx8OsUgLCBWUFU7iBf7ng+e6EtjNVF/8OFR7nMwTq7gqEVRfO1hRRNmi5bQV57AUBlZyBfJLqmFGdukM8HuN1ZXqGTqYY7kJS9ooV0N2gDTVdpmxNl/HGqhrVeG6OcfdgujAFo35QGGV2mz6sr2HrSxyVwYgcXz1lfaQGKpn2akEvHzAEGOB4CkRjg9a1k5R6grR1UTKkUvuq8+5gBGAwZIA/3uXfUrcxCGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2FUaoNtSE43XrKdE9df+wCqjlplwYXe3geMQD9kbmU=;
 b=Ww55y2+rREjfkCTkw9onVjeQRPzxgvtc0MYnCUAhrGEoBYrjnyTYlVc5eip2IRUJwdoBfev+4pKIawQMzHRaCO/NN8MlX9ekCJfwC3T0PLUni+t8h8S+uP+Ea2La8M89CwXIaRdLaKN33RG/gEQV91OzR/9BEh9OQHE56xuT6GrChbiBi/Cf0ihVduJPwQ38DIMO6RO1iEdCB54w4nH7fg4bCui86x6bA6VOnXE+9wfnRi3gJ2SOX6mD0ziwJn6LIf+vFoRS3Y9Js4xnl1uGs8UGMNo0Qjn59EWfZyR4XmRJiAsW7c0RAoPDryIFycMTfm95TNmeQf43Lcyg/ydtsQ==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by SN7PR22MB4126.namprd22.prod.outlook.com (2603:10b6:806:2ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:50:23 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::35ce:ff48:fa8b:d4a7%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 13:50:23 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Michael Walle' <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
CC: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Topic: EXTERNAL: Re: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb
 entry
Thread-Index: AQHah2eFH/UzLpYvwkmv+sCIpITisLFf3RJ1gAAWLHGAAAdcwA==
Date: Tue, 9 Apr 2024 13:50:23 +0000
Message-ID:
 <PH0PR22MB378981BBC77992E4EBE090B4F9072@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240405100104.480779-1-f.suligoi@asem.it>
 <20240405100104.480779-2-f.suligoi@asem.it>
 <D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.org>
 <PH0PR22MB3789719A62A1EE483C9FDF76F9072@PH0PR22MB3789.namprd22.prod.outlook.com>
 <D0FMGOEWQC1O.30D61WTXL4087@kernel.org>
In-Reply-To: <D0FMGOEWQC1O.30D61WTXL4087@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|SN7PR22MB4126:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IajFq39/2Rd1VWDfJQ84Q4gqXwUaVuKI6dHKwIC39nEmVP4eQN0qBlwSQDaJDdWyzzm8IIYSSmdy5Id/A6Mm+Q69GkokaA7RcEIffbrYc3WzC/IYZRDCPIoyDb+62PZ92WH9UXqbB+b3yW3sL43trdCnO419iAcJda59RdKnJazDPdwmf/MUkozFgYipcNNLtxSM/e/OE/PUQolLhiz/Mk+ks4Nejhqc1VM2hfmV6EmcJcl085bVe7M3+zBS0lq6NmT9AO43aZ03php4DCpt8BYO2Es2uzO6Y3XPwkoQ8k9AdDceOKnUVAV60Sh8RWjGVJAbzloKTzatMFajbNZYcbuEZOQ23NJOWAGXBK0FYBabBSWgCb4ooWFAy+QpeKP4vAy20pVh0Rc12HPaCvqS1Ehi+H2XZClVlpzZ/l3rqdgWSJBgx7z3HthAKSGHUZG8qr+6uwnZlzzck2FBWKAtg24nuO0CUxbpYdP/l1nqreLkrUju0+C1IYx3fOf6jfTdY2AiMahMRCWdpoourxS2spp7Ye5SaKkcYARhL/44qMIqjmIfBlkx38LXjwXa2WMKN0i3mXAFqc08uYVDzgpqln9TWBigHwIV+HyKmk6F+6Zexyu39Paq5qROufCE3UHllOXD/fF8pUMNthPF+fl0P3QegWYXh9RPuMSyoXJFnKs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDk3dGp2REo1VHFBREREV2VoSm02cTBYVUo2SXpTWmNDNzRZTW1MRzZESHYr?=
 =?utf-8?B?akpNL2RHOW5CS2RrbnRqcWJWelQ1bUFMMHhqa1FHVWsvRW5SSXJ5RTdXYnFk?=
 =?utf-8?B?bysyWWpkcW85eWk5MzJwZk9mWHlhQzgrRHBBOFE0NVB6VEtJMWZQeThkaGk1?=
 =?utf-8?B?SUdIM2VJZVJ6NDVSSXc1aGhaaHl1U2lRQ0orS2pUVi9qZk9JWWR2SVFRdTdv?=
 =?utf-8?B?MnJVbkxMSFRubmFMWG85Y3J3MG1vTkQ1dy9xMVphUkRpYkZMQ3BNWTRKbGRw?=
 =?utf-8?B?enVGdk9NRXROc0x2d2hPSXlRYkphTGtHMXVsbmZtYWdXNWtRKzBTV2tHZ0Y3?=
 =?utf-8?B?cUMrdEZ4aVQ3QlU0TTJ0OHJSL2ppK2QrZm9MYWNQakZucjlIYVdPTXZ2UnBz?=
 =?utf-8?B?NVRGTnUzRHA4QWNVNWNVQjZ1a0RubWx0WDZnT3BtMEgwYTBGTWdZdzJoQ05h?=
 =?utf-8?B?eEtIdlVOaVVNUnpBVEtRMllWS0M0K0JwUEVaMUs2NGlnV1VQYy81TGdWZll2?=
 =?utf-8?B?a0RJRUpQRHNORlgvNzRwSnRsd3czYlZXMWUyeEVYS2VFbFcvREhJZWRMVmMr?=
 =?utf-8?B?bnFTWXhOUVBrWWJwWWhqTnAzUldhQVlrQ2h2Z1Nsbkxmc29NcU5RZ2k0UW5S?=
 =?utf-8?B?YWJUUnRkMHNUWnZyUlp4RENrRkthZTZTRmgzYnJqbU8yT2ttL1JhbG5oc0lT?=
 =?utf-8?B?MW1LQ2VtU2xWeHNjYXpmcEV2dDZ4LzF4emhFY1ZsOUVVOEp6UkNJTXZBZ2ti?=
 =?utf-8?B?cDVHdnpIQWtQV2djU2FNUTFkS2xtZWNjWjJzYXlQeXpnSS9CaFlVdG8wdjBJ?=
 =?utf-8?B?SERRSWlNcVFja05GWC9uU1ZRZU84UHp4MWxyTW1sT2xwZFRzSW5lSjdGTjc0?=
 =?utf-8?B?cXptbUM5aUpOREJtMFRVekorVnp0VEF0anBJL2twNlNMdnl1TDlvaDF4Y09t?=
 =?utf-8?B?TERwZUJJZkhtWkVpdXNJaUdTOWxCZzFGYjNvM2hOMVJvUDZuN2QrMmNxaWQx?=
 =?utf-8?B?czVXcG5UN3F4NHRpOUZkMkhxRkZmTlVVWmVIQ21YQnJnREhURWRITEMwVHM1?=
 =?utf-8?B?VGs2R1JjT3FoTk8yUExLZTV2ODhIeUZSZ2I2VjVBbkNuVXVBZlNRcndQNjEy?=
 =?utf-8?B?SW13T2hKekpmUHNLL0tDMFJPZjVickE5TnI1T0RKbGpjUXNQMmpxRWQwNHM0?=
 =?utf-8?B?KzNlVXY3UVNJMDJtM1dta3pqVmVJNVFCbG5KQjBtdnZYTG82bG94aWJ4M0pK?=
 =?utf-8?B?ZE5LV0F4MnQzenZXaUhCc29kSVhnNUJrVUlOY2RmYzNsSTBRazZYZ0x5OEZJ?=
 =?utf-8?B?ejNScC9pb0F2L3I1MTd3b0xKQkZhU3pCQm1mVWZ6dEltRFdzVTkxdjdSK2VT?=
 =?utf-8?B?eVpwaUZacFVOT09ob1Q4SHdzS205S3BWaDd4aE1QbTdpM1RjN1NaQ1hla3ll?=
 =?utf-8?B?eTZ3REgvUXAwdWI4SWFEZGlxWktPUVhXc0pPN1lCQ0pWUnVUYm93ZGg1bmJs?=
 =?utf-8?B?YzN5YjZDR0lycytNN2R2VnFUbVRhamZWZkVsVXh4T3pqVlN6UDkvYThSRE5q?=
 =?utf-8?B?VEROMmt3aVRJdVlvT2FTWGZRZUhBY1FwenB0ZWZjbDBLRUNNbFNQMTQ2V2px?=
 =?utf-8?B?em9CMUlhYk0xYXphVXhldkt2TVJxY3p1U1hyR25oNjlxZno0UjZrWHlnSk1G?=
 =?utf-8?B?ZzI1c2NIbTA2bi9xYXlwMTI3UFpZU1lIZTdXaTZCNlFEM2tDSGJQS1c2SzFh?=
 =?utf-8?B?TDhBUWRUOW0vTWpxNld5QWhjYXdZZGpHbHZVeWl3ZzlGckZEc2ZIbGt5NS9N?=
 =?utf-8?B?NUppMGZTSU1sN3dUaXFjVmhkOEEyekZTc3ZQQ1EvQ0FLeExoYnRzL21qeEI3?=
 =?utf-8?B?bVYwSzZTUURXV3ZWcXB1dFBLMXRveS9mVS9tbWsrTTNXM2NCYUlXZkZhbCtm?=
 =?utf-8?B?NlUxNXNKV0FzK1M0eWFyd1Qyc0Z3Zm9lNUMzMmpHN2xMT2xRb2VrRytpYmlW?=
 =?utf-8?B?azlZbjBrVDBqQkIyZUYvZU44N1FYQWRwNkl4MkVPTGR3OHZIZ21CQXlacTAx?=
 =?utf-8?B?L1pnUWdFRVgrZVh4UWlJSmhXMFBEQ1BSVlRNVlF2SWxpVHVwUXUwWmVJcTRh?=
 =?utf-8?B?MUdIZUpvaU42K1FWRUFEQWVLQ2lNb213M2FUUG10REk4L2VDVTNuR255QWZS?=
 =?utf-8?Q?kVjqqwCazRKSjVNqaJc4XrE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR22MB3789.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fc3ada-f25e-4453-aafc-08dc589c0116
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 13:50:23.5607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/7lUAVS1PYAeWBhOU8Ep+SB5YUc3xL8iVjDzpC2mijWSlXysB62bUus7RbuJ3UqlHvtexDCYNv2iT0d/Yx2zXeNcVTjBr1dKze7RFcMcty64h7zl/nPSyR6dRs4GCy1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB4126

SGkgTWljaGFlbCwNCg0KLi4uDQo+IE9uIFR1ZSBBcHIgOSwgMjAyNCBhdCAyOjA3IFBNIENFU1Qs
IEZMQVZJTyBTVUxJR09JIHdyb3RlOg0KPiA+ID4gT24gRnJpIEFwciA1LCAyMDI0IGF0IDEyOjAx
IFBNIENFU1QsIEZsYXZpbyBTdWxpZ29pIHdyb3RlOg0KPiA+ID4gPiBBZGQgdGhlIEV2ZXJzcGlu
IEVNMDAwNExYQiA0TWIgKDUxMktCKSBJbmR1c3RyaWFsIFNUVC1NUkFNDQo+ID4gPiA+IFBlcnNp
c3RlbnQgTWVtb3J5Lg0KPiA+ID4gPiBUaGlzIGRldmljZSBpcyBKRURFQyBjb21wYXRpYmxlIChK
RVNEMjUxIGFuZCBKRVNEMjUxLTEpLCBidXQgaXQgaXMNCj4gPiA+ID4gbm90IGFibGUgdG8gcHJv
dmlkZSBTRkRQIGluZm9ybWF0aW9uLg0KPiA+ID4NCj4gPiA+IERpZCB5b3UgdHJ5IHRoZSBhdDI1
IGRyaXZlciBpZiBpdCB3aWxsIGZpdCB5b3VyIHVzZWNhc2U/IEp1ZGdpbmcNCj4gPiA+IGZyb20g
eW91ciBsYXN0IHJlc3BvbnNlLCBpdCBzb3VuZHMgbGlrZSBpdCB3aWxsIGRvLg0KPiA+DQo+ID4g
WWVzLCB5b3UgYXJlIHJpZ2h0LCBpdCB3b3JrcyB3aXRoIGF0MjUgZHJpdmVyIQ0KPiA+IFRoYW5r
cyENCj4gDQo+IEdvb2QgbmV3cyA6KQ0KPiANCj4gPiBBdCB0aGUgbW9tZW50IEkgaGF2ZSB0byB1
c2UgYSBwYWdlIHNpemUgb2YgMjU2IGJ5dGVzLCB1c2luZw0KPiAiYXRtZWwsYXQyNSIuDQo+ID4g
U2luY2UgdGhlIEV2ZXJzcGluIEVNMDAwNExYQiBNUkFNIGRvZXNuJ3QgaGF2ZSBwcm9ibGVtIHdp
dGggYW55IHBhZ2UNCj4gPiBzaXplICh0aGVvcmV0aWNhbGx5IEkgY291bGQgdXNlIGEgc2luZ2xl
IHBhZ2Ugc2l6ZSBvZiA1MTJLQiksIGNhbiBJDQo+ID4gdXBkYXRlIHRoZSBhdDI1LmMgZHJpdmVy
IHdpdGggYSBzdXBwb3J0IGZvciB0aGUgRU0wMDA0TFhCIE1SQU0sIGFzDQo+ID4gYWxyZWFkeSBk
b25lIGZvciB0aGUgQ3lwcmVzcyBmbTI1IEYtUkFNPw0KPiANCj4gRmVlbCBmcmVlIHRvIHByb3Bv
c2UgYSBwYXRjaC4gS2VlcCBpbiBtaW5kIHRoYXQgaXQgaXMgYW5vdGhlciBNTCBhbmQNCj4gbWFp
bnRhaW5lci4gSnVzdCB1c2UgZ2V0X21haW50YWluZXIucGwuIEtlZXAgbWUgb24gQ0MgaWYgeW91
IGxpa2UuDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb25zIQ0KDQouLi4NCg0KQmVzdCByZWdh
cmRzLA0KRmxhdmlvDQo=

