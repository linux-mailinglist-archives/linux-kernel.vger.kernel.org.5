Return-Path: <linux-kernel+bounces-151194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93F8AAAF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340431F2218A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FB745EF;
	Fri, 19 Apr 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="kAKAc/6n"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54938D;
	Fri, 19 Apr 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516879; cv=fail; b=h6DM4l6vIfTUAxNef7GFuUOCtYoLUtGBhgvV/VOdHGanxWz/xwLb9Hru6679lC0+z4uSCJ7Eps51VPa86XHpx4zJHdXelSo5LceaVH6hs92gF07zkgRowlKTtAzzWgNRxHD1IvUsTAOJuuR8VnzKQ9aOtq7kXHFLJ9bQPmyecAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516879; c=relaxed/simple;
	bh=YGcBd+G7AO6dI7G80VBepobIaZHRYl6/0oQjN7SsSrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSm67VYoo/Xc2xKxvfuKbDQgjjXHdM6LGVuCL1HMxpW6tne+LaT8IbhLhoHnGmI4Z/o7RAgNjvUksQIpGnAevpkdn0HzlJLqN6424lz7Q2TvohlxXYe5ZERkFokc4Mz1NcLGylq415kQ4sjQDo5ksRJJksXgQOuIxaCMbSZXYCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=kAKAc/6n; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd8dWpmroCAuB3CwKXSDKUfq1QvbgatsPNbj9vrwdVC6WUC0pDDA8YtKrjb/j3osWAOFklnbVDbZX+YUYoYHveG7MivZ//HFftmmGsCHrCFRV1WERHxEUAqNTDOyWa6Z/U9iuRJOoI8z0ll5E+9QoGZyHmkfqZE0tfbkkxxkZJx50JOgqo9K8HBVE2UcZIEut1eTy1aYgAlAvME7mxXqlctrO9b33XhCa9+QZbmCqz+4X0Z947N+athBxhDXjdd3CaM1K8n5ZvWz9xpoFAeQe9ulQMR6r3+N1iaxjxIyRqHHKUx2GXawOwZuEy2w0zDw0ffRwGZchtT7hU4fW+Ew+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGcBd+G7AO6dI7G80VBepobIaZHRYl6/0oQjN7SsSrU=;
 b=XyfDlgxACfvyw+nMFhdhdi66K/Z26Vy4bGV2dYbDUuGDTLNuA6TNiucExSSh/M3q4oQhLfX8ltWs4nQc6MA2k/x2FIhT7jFQsc0X+QmEtzZoEJjwpH1iO80XwMfoYr7Th5l4BejX/hJ/1lpajmIDXdRnZO0DqI5zBo5ew4taw0t9MOzS9I6MORPE3Uw0didjFJsYNi9P0YG6TqIRhlFnuY6a2QlPE4EuMEf4FBXwBfgJ1AjJsWdbtXRjSta4Fw5qDLsuxtNXFa1z1e0lN+qnf6r4vZmI+5X6wyqX8qijBA+1WlpFt/2tIIU/UJMaXn05WveljuIqRiBc+g+k5gFoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGcBd+G7AO6dI7G80VBepobIaZHRYl6/0oQjN7SsSrU=;
 b=kAKAc/6n0M9nLG+1ZPHQ0QtLU6NTgi5XT0AQUh/nWakOJ9m64X80GIJJ7Ypg5hMItFG33BqwPWj5gZ/Kh0u/4BmexvbYYUbD0w2OY15mLOoGcwZXhJBmI6PJ3/OgvE8ThpWNmhLlcFia7ValSI429/j7yDvdrIZ3chh4g3vtBYJqSz4dJgy+iI2QZDQUgw6UzOJSevI+xzbH0Sbx+O8SKv19U2QEp4fHcboJNFZU8NxJfS1MCqhczzRyxhZhNEn+KkjtMzk7HvTQ58eImTD5PycYeYSayhZu/oo5RULat1gDZqscB5OS/46w0vGaPpjwn2ALl2m6G0ku+CJxL2j2+w==
Received: from PH0PR22MB3789.namprd22.prod.outlook.com (2603:10b6:510:29c::11)
 by CO6PR22MB2916.namprd22.prod.outlook.com (2603:10b6:303:14f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 08:54:34 +0000
Received: from PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::ab96:139a:5601:de5a]) by PH0PR22MB3789.namprd22.prod.outlook.com
 ([fe80::ab96:139a:5601:de5a%3]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 08:54:34 +0000
From: FLAVIO SULIGOI <f.suligoi@asem.it>
To: 'Krzysztof Kozlowski' <krzk@kernel.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: EXTERNAL: Re: [PATCH v2 1/1] dt-bindings: net: snps,dwmac: remove
 tx-sched-sp property
Thread-Topic: EXTERNAL: Re: [PATCH v2 1/1] dt-bindings: net: snps,dwmac:
 remove tx-sched-sp property
Thread-Index: AQHakbHwPdGp0ZsorE+TRy4w2BL6zLFvSVdw
Date: Fri, 19 Apr 2024 08:54:34 +0000
Message-ID:
 <PH0PR22MB37893E5FB92FC956D9F7B87DFA0D2@PH0PR22MB3789.namprd22.prod.outlook.com>
References: <20240418091148.1968155-1-f.suligoi@asem.it>
 <20240418091148.1968155-2-f.suligoi@asem.it>
 <98f8a1a1-6455-4d73-84d9-76c089e9320f@kernel.org>
In-Reply-To: <98f8a1a1-6455-4d73-84d9-76c089e9320f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR22MB3789:EE_|CO6PR22MB2916:EE_
x-ms-office365-filtering-correlation-id: 76bcfd66-2466-4881-24a9-08dc604e55c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i8xhwiOk255zLQpypkb5lR2RC/IuzOkodGy+ro+R6jXEjTOFefbfMZmay67iSznV6RaX5TPrZVxcehYN9XjqW/QNH6vMA4RcflpB7fc3eIFnSdGRrQzmituwlmy/4FDR7RUNYjO6Q5oId1IBB5r4gybsQ18NEvntl22c3/cy+Jrh4c9k2oUI6DRFW/z5MXc0+arVfNet0Lx458NyUdFTRZBMkqxu8e4iWWvqoxFmKLlTShDYCXmkk5B585IlEGfSRiwmixluty6Mc1ZIbAg7aUm4Kt5pABIP0cn/rZTtqpJpfxcRiBEsxzmxaGZQnpIQEhlrX9pjaNgOePStsGjCiXTbXtlhI1z5VtsYFFXEyB5cWD9dxjA87PqLwlZ6BOvLENKvu7dBikkwG1kefEs4mf1vG1PsTbrYT6DzAM5afsNz9XrFfdYwnCiwBi9/N42NxmdNdoEHpfAbn15jbH5eCQPtDizjqw/lXaLFBnT5k8lrp8/G1YcC317I1DD/ve0dqlEALwB0h2PtEzGugIq3lrShDVApVUMy3KmgmfZL/dPnueNWQoUujOv4wob07r4dfCQSNA0Xd6CASH/7zi4lai/mDurWPMn9WxUM7xbpARX+476JGBkPtuIVgkVft4WeSeKoHLSVX9ncwrvJmG/ltQPcyY+9/CHnNoyBcHlMCcY4Styf2yItvVTG9z9IwPHK+Yajm/otwBVNpNfvfhKXEYNjn4dX3Khg1KxupP6xJGg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR22MB3789.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2h6Y0NjWVJBbm9IYmlTT3NEQ25ZM0tGVEl6Qlhza0FiS1A4b2xuVDhWMjJw?=
 =?utf-8?B?U1VheWFEb2JOYklVQzlGNjdVME9Ua0xoemxwc1JnZlNUTTdmK0U2ZHJLT1dI?=
 =?utf-8?B?cXF2VGI5VlRIY25JYjJGV1ZMOGdZSk13S1NzSW5xaGJFaFZubzFKQjBtdEUr?=
 =?utf-8?B?RXFvQUlzNGVRODNDa2Y3dG8xbWo0M1pPZDJOeDFXWXkrZ3AxcExIdXN5TFhT?=
 =?utf-8?B?bURDUTJ2Ylh4K2FjWVlSQ1kzb0I4eVhkZ1llQmZsYjRvUU90NFNYbVZOMlhh?=
 =?utf-8?B?Q012UDdySUZpUUU2RjJTbFUvRnhUblJqNllkOHZvT3M3ZGdhcGtsZDd3TlpF?=
 =?utf-8?B?TnQwRjdmVzlZUGNrZVJhYVFyY2RKbmZIeVZBcisrWlNkSW1HT2xWNkRhbGgw?=
 =?utf-8?B?ek1ISENwUjIrM3lVSTd1REF1R1R5VXJNMU0yeURuSXRic1daZ05RMFYwVFNz?=
 =?utf-8?B?cG1jYWpuRGNMdk13ZHN0UFVRbjZRQ1N1WktLQWt0SHdOYVhrWGZBdGh4YmRw?=
 =?utf-8?B?RGc4U2hUcll4eFpCc2JJak4wRmxmeHlWWjFDTDZOR1lJZmRNTmFPZzduR0JB?=
 =?utf-8?B?QWNEQlgzU29rOUJLam5BYUxNajdpNGxXSi9vbzVoUUdPWnVYaWFhcTVKWWNP?=
 =?utf-8?B?RFg3dU5aRFpSRWpveXJMVGRQWHMzbGRqMWM1dDhuK3pkeWloSkZKY2JnVTBN?=
 =?utf-8?B?TlBBT1RqYnhjeGRaQXFJYWpZTkpYL2JkenhVaDFrZHM4eVgrSk1pY0pBMmpq?=
 =?utf-8?B?VGx2a2pqZlF2UWxvL0hVQTRKdUpkTmlIcjVLODlYZUoxSGN4NXRJQ2xiMDN3?=
 =?utf-8?B?eGFsaWs4SmowNUJESGRUSE5kY1pPZldRTkRhb3VsRUJZZi8rTDdOaHVUMnVq?=
 =?utf-8?B?RkV2aWtCQVZScm0rcWZLdmtpTzJFVndtTG56T3czdUJnMU4rZWFrdHcxekgv?=
 =?utf-8?B?endnM29CRjg2UEFZNTZSbE5ieHhjT20wek1obmpwckNhais3bW1sN2NyOVZ4?=
 =?utf-8?B?YXdjcHZyKzJtYUdPYVBwVHBvNVBBZlRxc3kyQjRLT01Bd3JWK1NUV1dCa2x5?=
 =?utf-8?B?N3RiTTVEd3Q1MjNzbVhIdG5ad3A5QWk4YUcwQ01tTVRnV3pGd0FTMTh1REZK?=
 =?utf-8?B?TTRCK0NNd2thc29YeWpZY2dpM1hiclBwbzhFelZwOFVtM2ZUY1gvV1g0WXp4?=
 =?utf-8?B?dzQ2b1BuazFoMUhpQUpQR3E0WERCUWR3TTYzYmlwMVRUOTJiVXpVc1laRGYr?=
 =?utf-8?B?QlRMMU5IVjgvNWFmUVNlY2FQUXpiRllqU0NEcnY1NHhtRDM0WElMK0poYjRD?=
 =?utf-8?B?Q2NVMlhnWWFwUTlKMFdyd1g5dG96d2w2ZU0yNGdWUUVPQWJtUU9PQzFpcmVv?=
 =?utf-8?B?Z3RkSXhTbnZ5cHY1QVZPc0RUL1A0THhzU2t2OG9uTytWckRsRlpSbmZFOHJn?=
 =?utf-8?B?Q05CeDdVMGo4cG9CVEp2akR5VEZoRXFpRDZpQ0VUcVJTSmRGMW1wNEd3Z3pV?=
 =?utf-8?B?MHJuQ29iSEhhUTd6SVFka2FNRWMxeStUaXZiNGlLbHRzR1BXeUd0ZUlPOTl0?=
 =?utf-8?B?SmlDZk1rM1FmbS9vUkVFU1U0RFNxZkZ5QlVNV0ZNcjg2dU5weGpjUGU0dGcy?=
 =?utf-8?B?aVAvWE5ySWRBS0pwRE96Tyt5cFhLR2ZDZ2pRb0gzRDMzUWE5di9yZy9CcmxL?=
 =?utf-8?B?RWx0WXJyRzNVZXFrbzhDUUhFL1R2RklraUtNWmEzMEczV1UySWR5RFFpMzZl?=
 =?utf-8?B?cHlsallJUCtHaVI5UW4xeUdiSmVRY3RBQ09ldExjbkd4YUp1LzdCa2ozKzF1?=
 =?utf-8?B?eFlHSElrNW9GWnpVVHQ5bUhWb1V2Qzh5czNwSlRPYzQ4M1hhS09YU0I1bHlI?=
 =?utf-8?B?L3cxWXVGSThDdWtFcENUMmZRTU9xU3VXQk9sMkRsd04xRzQzcnVIaVBMeCtY?=
 =?utf-8?B?dWwwRUZ6L210c1ZWVForYjdsdjF2WUliMFIxK2J4Z1FLSXpncTBSa3QrdkRl?=
 =?utf-8?B?dUNGQXNEVzBQVFA1RURTdjUvVkRGYmluSUxYMDRsU0pqcVBBbW1KdHI0SWRT?=
 =?utf-8?B?OVZ2Tm0xNktSWXBKVnJFZlkxb2dmaXBHclN2b1Z4K3pjTkw0UVU0MjVIMm80?=
 =?utf-8?B?T2ZrTkx3K3d3SnFvNFo0VmQ5Sy80bDVrSW1GZlhoQXErdGVIWjRqL2tQUThv?=
 =?utf-8?Q?lpxuXbihOssemRClVFiALkI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bcfd66-2466-4881-24a9-08dc604e55c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 08:54:34.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZJoIzP4nob+D6uyIr0pV44V2rqrYQJFi4cCN14KsWXmTsz93dWVPcwVH/NDL9ozvofj+IbrhSfcC4dgGQky+EQvdwnciZY3weRJsfY/CSwFbgnBvrBvlrIj5LNwnLVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR22MB2916

SGkgS3J6eXN6dG9mLA0KDQouLi4NCiANCj4gT24gMTgvMDQvMjAyNCAxMToxMSwgRmxhdmlvIFN1
bGlnb2kgd3JvdGU6DQo+ID4gU3RyaWN0IHByaW9yaXR5IGZvciB0aGUgdHggc2NoZWR1bGVyIGlz
IGJ5IGRlZmF1bHQgaW4gTGludXggZHJpdmVyLCBzbw0KPiA+IHRoZSB0eC1zY2hlZC1zcCBwcm9w
ZXJ0eSB3YXMgcmVtb3ZlZCBpbiBjb21taXQgYWVkNjg2NDAzNWIxICgibmV0Og0KPiBzdG1tYWM6
DQo+ID4gcGxhdGZvcm06IERlbGV0ZSBhIHJlZHVuZGFudCBjb25kaXRpb24gYnJhbmNoIikuDQo+
ID4NCj4gPiBUaGlzIHByb3BlcnR5IGlzIHN0aWxsIGluIHVzZSBpbiB0aGUgZm9sbG93aW5nIERU
IChhbmQgaXQgd2lsbCBiZQ0KPiA+IHJlbW92ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBzZXJpZXMp
Og0KPiA+DQo+ID4gLSBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtYmVhY29u
LXNvbS5kdHNpDQo+ID4gLSBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZr
LmR0cw0KPiA+IC0gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLXZlcmRpbi5k
dHNpDQo+ID4gLSBhcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2E4NTQwcC1yaWRlLmR0cw0KPiA+
IC0gYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NhODc3NXAtcmlkZS5kdHMNCj4gPg0KPiA+IFRo
ZXJlIGlzIG5vIHByb2JsZW0gaWYgdGhhdCBwcm9wZXJ0eSBpcyBzdGlsbCB1c2VkIGluIHRoZSBE
VHMgYWJvdmUsDQo+ID4gc2luY2UsIGFzIHNlZW4gYWJvdmUsIGl0IGlzIGEgZGVmYXVsdCBwcm9w
ZXJ0eSBvZiB0aGUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRmxhdmlvIFN1bGln
b2kgPGYuc3VsaWdvaUBhc2VtLml0Pg0KPiA+IEFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+IA0KPiBQbGVhc2UgcHJvdmlkZSBjaGFuZ2Vs
b2cgZm9yIHlvdXIgcGF0Y2hlcyB1bmRlciAtLS0sIGV4cGxhaW5pbmcgd2hhdA0KPiBoYXBwZW5l
ZCB3aXRoIGl0Lg0KDQpPaywgcmlnaHQsIEknbGwgd2FpdCBhIHdoaWxlIHRvIGdldCBtb3JlIHN1
Z2dlc3Rpb25zIGZyb20gb3RoZXJzIGFuZA0KdGhlbiBJJ2xsIHN1Ym1pdCBhIHYzIHBhdGNoIHdp
dGggdGhlIGhpc3RvcnkuDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNClJl
Z2FyZHMgYW5kIHRoYW5rcyBmb3IgeW91ciBoZWxwIQ0KRmxhdmlvDQoNCg==

