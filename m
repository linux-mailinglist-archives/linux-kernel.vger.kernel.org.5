Return-Path: <linux-kernel+bounces-142835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E58A30A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BEF287B91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9258615F;
	Fri, 12 Apr 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="BB8bamFC"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021011.outbound.protection.outlook.com [52.101.167.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215586151
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932047; cv=fail; b=LE2cHq9S7r7pIyhykKfwk5bDVTTpFdRL+azc29+39+eEXSmN2R50sN5Sw4IXYKBG+1sD3TsVoPeuv0n6jYdhJ3+aL8TEdCcdjdgwVxRZnjHzJLMFjLdoA5Pb9yxB/IAxiGFx7+jg4KCC3eOWxhRcHxyAqBE68GgxwyAIg0Kurac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932047; c=relaxed/simple;
	bh=JEU2SYiZMnf5CeVAx9Jp67Q6p3IzGP7fEYxXzYFUqAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=APfJ8B9ZmlmP5t8Qfh8N8mlvjJFiOA52IujMM9m7wunl1MBlxxaKL0jxKGnbg5ArC/yWHGqJ07GKBGQF1+YjASqsxBrxkpal9+XgvISC5j0nC+YNDwT29bpI8bEtGiF8W8jI5Gqy4GcfwveJh7bDqY7SUXZsLZ72zW+wpldvjNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=BB8bamFC; arc=fail smtp.client-ip=52.101.167.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L58zgh39INDfGoZvhtVaEX4sAGuX4yakotujxxJsvH49CaqWCxNpW0bBfT6T7xwQ3w8TWL2yrW7YQFTFX+6SacrOSEi81MUKlrAcinTUtP8QzTjKUVMZK2JwfnPH+4fEYb74u+g6H9Tnb3w8J4/ALKk/O7rw0sHh5IPJS+CBP6O9c8UK/C124aGgBDkMddTkci0EWtdytiQX1/zBuYHU2v+Zrpu1PrMKJgy5seXN4+zZR0gqJLLhFHpsHWxB6MNYIbdfA6OXaPAGJZ5ElJL5klb1/rFcknENg9mXI7Wc2zgKosYE2Rf+B1zheJtPH3vfIYXGZgwABdlspXnIzCrdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEU2SYiZMnf5CeVAx9Jp67Q6p3IzGP7fEYxXzYFUqAI=;
 b=EeUsbgvWoT5dHCsC0faAwEJQ8yBzoD4deqxj0em3dAWPJMXYQ6e0K5k9lhiN/FtIkoz0uSub+55AdjG+9q8D2OVY5bOeFHHcOtnmroIFdDCg8fowzW/uFOZF3bcOYOyXmr7bXjqMyzxEaFrKVil8Hi2jNCIgguHYADN2Rto4qEiB1I8PQY0cT76ID2q1eBPNi6HZVHrdtF+ONm21/vgNYssmt5qS1RNx8GFO86qkBGdpB3IhTHQHOsT84/rPttI8kj4jcrD2GDrO89rZagQZSM17BewLZtvG0y4GjO8MvquvYea7utOhw6Xkj0+Ttfiv7g8Bvp/Mj1FhpTW0wSzoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEU2SYiZMnf5CeVAx9Jp67Q6p3IzGP7fEYxXzYFUqAI=;
 b=BB8bamFC5KzwWmQVQPIh06vN0SuJF3b5PET9zDB/Xo9TLwq3Co94tSpPfwJtYoGUkrkbf3kaaNHR8RZdofnLrB5uhfJa4pV54GK51LGSJwtDi8wfKq0637iN+p6y9sfdFOiW4jxxS/rUmdTXb9tgB3eT4axlUORN5BUaMg/6K6BdxZ3mKTDLlIW4FmKjct4nPLkG/s/zih79qkmsC64hI6EaGqY9dQxb8pVWoke4wFNCFwoAwZjwc8AvmM0rWlIYFwf66E56wslAfIYb1LYm/ZgajBKBdWU2g/IksDPVvdZm2yQm7OUTdDT6kJ0FL11VQ7Hqi4ejK3sU8QQT+jdp6g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2110.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:192::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 14:27:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:27:22 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Peter Xu <peterx@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Yang Shi <shy828301@gmail.com>, John Hubbard
	<jhubbard@nvidia.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "Kirill A . Shutemov"
	<kirill@shutemov.name>, Andrew Jones <andrew.jones@linux.dev>, Vlastimil
 Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, Christoph
 Hellwig <hch@infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Mike Kravetz
	<mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 00/12] mm/gup: Unify hugetlb, part 2
Thread-Topic: [PATCH v3 00/12] mm/gup: Unify hugetlb, part 2
Thread-Index:
 AQHae9xDtU7RU0MVOUS5yg8mgl66VrFD7w8AgATmKACAAT+mAIAOpvSAgAFXPYCAADmbAIAGay+AgAEH9YCAABFUAIAAOiWAgALIEIA=
Date: Fri, 12 Apr 2024 14:27:22 +0000
Message-ID: <195306fe-bb13-47bc-b26a-e87b4a6383d9@csgroup.eu>
References: <20240321220802.679544-1-peterx@redhat.com>
 <20240322161000.GJ159172@nvidia.com> <ZgHJaJSpoeJVEccN@x1n>
 <20240326140252.GH6245@nvidia.com> <Zg8gEyE4o_VJsTmx@x1n>
 <20240405181633.GH5383@nvidia.com> <ZhBwVLyHr8WEKSx2@x1n>
 <20240409234355.GJ5383@nvidia.com> <ZhawJ-VD6DtLZ2Zm@x1n>
 <7b75c4db-9dbe-4ff1-b649-06a9218ae0aa@csgroup.eu> <Zhbvd9WZzWl3IA8Y@x1n>
In-Reply-To: <Zhbvd9WZzWl3IA8Y@x1n>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2110:EE_
x-ms-office365-filtering-correlation-id: 39a062f4-d517-4938-4878-08dc5afcaab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +WQ7T4Dlv288GEEnc/n+nFs+suYinjnKcXyjw3cGVNvTqlcnS22u0M3vlx6JcaeSdTW8OYtfSY7leCbGB9fZlNaMH9lCpMkVMG8actZOmR6hFjFXwAw7uFm67xbneX1c37o3wO8A8/zMJ9RXxAwWwLLs5HNWZ3q6dD7YSI9GbI2JmnlP/5J04b5rj+jg10ksUvK3d4Ta1af8V8aLuic9Zl7PUq71QnQaZ++qTmMO0AtMXNQrVL2yB+YTqxqcMoAMR1qrbJ9n+wExQ5U10talbkEQg+z6TBGz1G6IKaYtypqmmc9QwFJFH8o3pig1YTXcjbTrQVyfyz8ZthvIyDspRr1cUniHAkBA223MdxmePzxd3WEhdJQit1/VPF/ev7eH6OVmzck75JyloRWTIVnIaQumb1PA55AfsoMCRsnN8Ma9gtkTNflLXci2brRkyIe2VvkrDRLBudcW5FuCbJpJinpzYbwZHq9s+96SkpB+Zck9CF7Rvg9/6hOgJoIkB0B5rjmxmMVlTj8VCTWHD8GtJjQBUBN8gEjBDjgdVBNApAgo/U5vqRRLzgrsBUEdXv7OQhkeY5dD8BmaXckEuiGD0InWLbibqol9lbT4edunobHXehACBLCIHyAGEJhlU8i/2b1ZHQez8X/f0fYvCFQaUekEDyOcc6Cp5lUAH/wYyFc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UE5YM0JFOHVTK0hVVm8xbjhKS1JDZVRxOTA0VmRWRk5rR1NqMkVveGRFeGRy?=
 =?utf-8?B?aE9QZ3ZxRS8zRUZtbHRiNmdLbjdiTkdGekVxZUY2SFh0TXB1bmw2bk1CZ084?=
 =?utf-8?B?MHE2VnhheFlON0l0SVM5QVViaEFYMk44cFVOUHpIZXJyZW5oNWFFZ1FWay91?=
 =?utf-8?B?NitTdjZuVlBNdGVJdDZPc0RTMmdOdjdiNkU5UnFGVlRJWmloN1hoM2UrUUdE?=
 =?utf-8?B?TmR4Myt5blNob2RyNmxSajBJZklVbEdJUERJMHEyQWhRRmo0d3ZJdWFrb1po?=
 =?utf-8?B?VW5OR3g4M1VNUE43ai9QTHkycmo2TWpmVURUbnNVZkV4SU5GUEVxY3N6N1pz?=
 =?utf-8?B?dlZXQVlTbnZxSFJNYURHUU1IU2hvdFZrN0t0Z3Z2TDFSdHVFcTdFNHdGVkQ4?=
 =?utf-8?B?cDNackRBUE9jWENyd3ltcXdxOHBHeC9nWlMwUVlGYzJZUDZmbUpqN0UyUU5z?=
 =?utf-8?B?K3cwTTJ6WFcrL0dLVTJSb0RPMmQ0MGx6aVhkRDAyRUZWTkJNQXV2c0FqaWlK?=
 =?utf-8?B?djNBdXc2QXlNYzRnTGZlSS9MSUNacXlnS29wQWpxamNacUd3ZW5JWmhJSDR5?=
 =?utf-8?B?MUxLa0pOZVNwK2FzUG00UXBvMFV3V1ozNW5SZ2VjMlZMR3ZPWE9hWEdNTXJP?=
 =?utf-8?B?MWtCUmJPek5Lb3AySi9JNStuMGVZRnhEaHc2cEI5RHpaQUFnM0Q0dnNEUjBM?=
 =?utf-8?B?Vm05ME1DVDVSMTN0ZGJXem1HaytJOUJQZWNzNDIyTG5kVDY3dHMxWjByZmFh?=
 =?utf-8?B?dnZqck93ZWQxaHVjZURpcWlpNEh3cFZtWXBnQ2k2bEZDckhITFB5RHdpdE1j?=
 =?utf-8?B?NjUzYnhFVUg4SFVFa0hWWGZsbmtZQS9yMGxwOEZIdllEZVNpelpxS2hMMTIz?=
 =?utf-8?B?dTFJNUtmck1zcm5kYTYxaFJ0dWhXNjlOdmVTZVRGMkw3ZEJrMERVcURSYkkx?=
 =?utf-8?B?QmhWZ1ZlOXZLdFE2M2M5WGtJUFJpMjhNNlNxOUV1b3ZRckg3eFhJMW9sZEZt?=
 =?utf-8?B?ZUVVQlF2MUJzWUdoRm1ETFJPV2VHTzhjYXlieU9xNFRQemh5OTVrcTREQUYw?=
 =?utf-8?B?TUd2RlhzNGg5SEhsT0cxOS8yNmVGbEhVeSt4RmV4dWRHbjg0RU9EQmNXL1M1?=
 =?utf-8?B?Qk5SUGhFQkd2cDZxVWprdG5MMHdFUlZnd2NMMmhMRWNqUUhhUmg5ZUhIOGZ2?=
 =?utf-8?B?RFZDTDRLUkFPb3hYS00zRFQ0VWVlUEw2clUrRFExaDhTODNkZUF4SFUybDVn?=
 =?utf-8?B?SCs4WEFiQ0NWMm5JQzZKWU93TlBQL3N2K1RoUFgya1dDOWdzeS80eEF6OUFo?=
 =?utf-8?B?cktHUGwxQ09JQTUrdXF3dUcvcmp3U3huTkxkdURhMTlLT2tKbkowVXZuMXd2?=
 =?utf-8?B?WGE3M0Q3VCtEaEQ5Z0syWlBRTEpOdUhQZ1U3VTE3bTNIUmtBMm0wb0hsemhh?=
 =?utf-8?B?d2VyMnFWWmNRUnJ1UXorMG9SQkJSd0ZnYU5UOVN4V0NZQVUwVkF3Tll1K2VL?=
 =?utf-8?B?cVZ6SzcxVWlDTWx1YUFwTFdVQnFmVjN3ZVVNU2MvRXNDUmFEbzNLZ1dqMmpY?=
 =?utf-8?B?NjhFeVlnUWVKUlRaSzZpamNSZGQvWU5NdXY3Z1JWU3U4UXhUdUxUUlphSHVx?=
 =?utf-8?B?ZS9Ja254Lytoa3EzRldBemNRcHRIM1dBUHVDdVc5bUdvYnlNZklGNTloSndD?=
 =?utf-8?B?MG1DYWUwVGFMUk5MWEpOSWc3UzlibEVhTzNmNHZVVjJxNCthV2phdHQrWnpa?=
 =?utf-8?B?YzZjMEhEZE5CVHZIZnVyZEZyQjF4a0NNR0NxQXVCRzd5M0xSeC8xTFEvZFF5?=
 =?utf-8?B?MWxmUUExNldYNklPRGs2b1dZdE9jMm9uVTBLREF5bHVVZU5zVWU2c1lkZTls?=
 =?utf-8?B?dm1HZDBWanhsOVZLdmJ2STJpRFJINnJtRlorSjJiRkNhMUJyOExnSFBEaXlD?=
 =?utf-8?B?UTVyWVNwd251ZHV3QnVEQXhHdkc3RXhGR3ZMcVgrdGV4YzY2bEJJN3lNUWFl?=
 =?utf-8?B?L202aEhjTXZuZWlOZ2JCMjNqa3lXOEFjTlMvbTh1N3MwbEpUSlBWUkhmMFdL?=
 =?utf-8?B?OE81WVUyR3JjU040NmYxYithSXhEcFhVZ0FJVjc4Zk9vaERsWUFOa2duYmxB?=
 =?utf-8?B?VEFGcnN0WWVzdk1kOXhzcERwYTRXTW5leUxFUEIrZExodHRzSno4N2wxM0ln?=
 =?utf-8?B?NDVnYjNyenpheUIxS1ZkTkRZbXA2ZjdEWTgyNXQ5bnluSUpPcW5xYjR4Y0J2?=
 =?utf-8?B?aDczdWFrU29RZkxTRzd0VjdxN3FBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7162D2F5EF594C981F928FE618CC57@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a062f4-d517-4938-4878-08dc5afcaab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 14:27:22.1915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ie8qCzAwMgyFxCkNQr++n347LG4Fc11gwOLtbd69BWsYeWPe5fVlcdLnjQ8hJQRBUiSjGZiWwkiB+vT6p/JcHkDVboYkyUX5zmaQvAKwYP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2110

DQoNCkxlIDEwLzA0LzIwMjQgw6AgMjE6NTgsIFBldGVyIFh1IGEgw6ljcml0wqA6DQo+Pg0KPj4g
ZTUwMCBoYXMgdHdvIG1vZGVzOiAzMiBiaXRzIGFuZCA2NCBiaXRzLg0KPj4NCj4+IEZvciAzMiBi
aXRzOg0KPj4NCj4+IDh4eCBpcyB0aGUgb25seSBvbmUgaGFuZGxpbmcgaXQgdGhyb3VnaCBIVy1h
c3Npc3RlZCBwYWdldGFibGUgd2FsayBoZW5jZQ0KPj4gcmVxdWlyaW5nIGEgMi1sZXZlbCB3aGF0
ZXZlciB0aGUgcGFnZXNpemUgaXMuDQo+IA0KPiBIbW0gSSB0aGluayBtYXliZSBmaW5hbGx5IEkg
Z2V0IGl0Li4NCj4gDQo+IEkgdGhpbmsgdGhlIGNvbmZ1c2lvbiBjYW1lIGZyb20gd2hlbiBJIHNh
dyB0aGVyZSdzIGFsd2F5cyBzdWNoIGxldmVsLTINCj4gdGFibGUgZGVzY3JpYmVkIGluIEZpZ3Vy
ZSA4LTUgb2YgdGhlIG1hbnVhbDoNCj4gDQo+IGh0dHBzOi8vd3d3Lm54cC5jb20vZG9jcy9lbi9y
ZWZlcmVuY2UtbWFudWFsL01QQzg2MFVNLnBkZg0KDQpZZXMgaW5kZWVkIHRoYXQgZmlndXJlIGlz
IGNvbmZ1c2luZy4NCg0KVGFibGUgOC0xIGdpdmVzIGEgcHJldHR5IGdvb2QgaWRlYSBvZiB3aGF0
IGlzIHJlcXVpcmVkLiBXZSBvbmx5IHVzZSANCk1EX0NUUltUV0FNXSA9IDENCg0KPiANCj4gU28g
SSBzdXBwb3NlIHlvdSBtZWFudCBmb3IgOE0sIHRoZSBQb3dlclBDIDh4eCBzeXN0ZW0gaGFyZHdh
cmUgd2lsbCBiZQ0KPiBhd2FyZSBvZiBzdWNoIDhNIHBndGFibGUgKGZyb20gbGV2ZWwtMSdzIGVu
dHJ5LCB3aGVyZSBpdCBoYXMgYml0IDI4LTI5IHNldA0KPiAwMTFiKSwgdGhlbiBpdCB3b24ndCBl
dmVyIHJlYWQgYW55dGhpbmcgc3RhcnRpbmcgZnJvbSAiTGV2ZWwtMiBEZXNjcmlwdG9yDQo+IDEi
IChidXQgb25seSByZWFkIHRoZSBvbmx5IGVudHJ5ICJMZXZlbC0yIERlc2NyaXB0b3IgMCIpLCBz
byBmdW5kYW1lbnRhbGx5DQo+IGh1Z2VwZCBmb3JtYXQgbXVzdCBsb29rIGxpa2Ugc3VjaCBmb3Ig
OHh4Pw0KPiANCj4gQnV0IHRoZW4gcGVyaGFwcyBpdCdzIHN0aWxsIGNvbXBhdGlibGUgd2l0aCBj
b250LXB0ZSBiZWNhdXNlIHRoZSByZXN0DQo+IGVudHJpZXMgKHB0ZSBpbmRleCAxKykgd2lsbCBz
aW1wbHkgYmUgaWdub3JlZCBieSB0aGUgaGFyZHdhcmU/DQoNClllcywgc3RpbGwgY29tcGF0aWJs
ZSB3aXRoIENPTlQtUFRFIGFsbHRob3VnaCB0aGluZ3MgYmVjb21lIHRyaWNreSANCmJlY2F1c2Ug
eW91IG5lZWQgdHdvIHBhZ2UgdGFibGVzIHRvIGdldCB0aGUgZnVsbCA4TSBzbyB0aGF0J3MgYSBr
aW5kIG9mIA0KY29udC1QTUQgZG93biB0byBQVEUgbGV2ZWwsIGFzIHlvdSBjYW4gc2VlIGluIG15
IFJGQyBzZXJpZXMuDQoNCj4gDQo+Pg0KPj4gT24gZTUwMCBpdCBpcyBhbGwgc29mdHdhcmUgc28g
cGFnZXMgMk0gYW5kIGxhcmdlciBzaG91bGQgYmUgY29udC1QR0QgKGJ5DQo+PiB0aGUgd2F5IEkn
bSBhIGJpdCBwdXp6bGVkIHRoYXQgb24gYXJjaGVzIHRoYXQgaGF2ZSBvbmx5IDIgbGV2ZWxzLCBp
ZSBQR0QNCj4+IGFuZCBQVEUsIHRoZSBQR0QgZW50cmllcyBhcmUgcG9wdWxhdGVkIGJ5IGEgZnVu
Y3Rpb24gY2FsbGVkIFBNRF9wb3B1bGF0ZSgpKS4NCj4gDQo+IFllYWguLiBJIGFtIGFsc28gd29u
ZGVyaW5nIHdoZXRoZXIgcGdkX3BvcHVsYXRlKCkgY291bGQgYWxzbyB3b3JrIHRoZXJlDQo+IChw
ZXJoYXBzIHdpdGggc29tZSB0cml2aWFsIGNoYW5nZXMsIG9yIG1heWJlIG5vdCBldmVuIG5lZWRl
ZC4uKSwgYXMgd2hlbg0KPiBwNGQvcHVkL3BtZCBsZXZlbHMgYXJlIG1pc3NpbmcsIGxpbnV4IHNo
b3VsZCBqdXN0IGRvIHNvbWV0aGluZyBsaWtlIGFuDQo+IGVuZm9yY2VkIGNhc3QgZnJvbSBwZ2Rf
dCogLT4gcG1kX3QqIGluIHRoaXMgY2FzZS4NCj4gDQo+IEkgdGhpbmsgY3VycmVudGx5IHRoZXkn
cmUgYWxyZWFkeSBub3QgcGdkLCBhcyBfX2ZpbmRfbGludXhfcHRlKCkgYWxyZWFkeQ0KPiBza2lw
cGVkIHBnZCB1bmNvbmRpdGlvbmFsbHk6DQo+IA0KPiAJcGdkcCA9IHBnZGlyICsgcGdkX2luZGV4
KGVhKTsNCj4gCXA0ZHAgPSBwNGRfb2Zmc2V0KHBnZHAsIGVhKTsNCj4gDQoNClllcyB0aGF0J3Mg
d2hhdCBpcyBjb25mdXNpbmcsIHNvbWUgcGFydHMgb2YgY29kZSBjb25zaWRlcnMgd2UgaGF2ZSBv
bmx5IA0KYSBQR0QgYW5kIGEgUFQgd2hpbGUgb3RoZXIgcGFydHMgY29uc2lkZXIgd2UgaGF2ZSBv
bmx5IGEgUE1EIGFuZCBhIFBUDQoNCj4+DQo+PiBDdXJyZW50IHNpdHVhdGlvbiBmb3IgOHh4IGlz
IGlsbHVzdHJhdGVkIGhlcmU6DQo+PiBodHRwczovL2dpdGh1Yi5jb20vbGludXhwcGMvd2lraS93
aWtpL0h1Z2UtcGFnZXMjOHh4DQo+Pg0KPj4gSSBhbHNvIHRyaWVkIHRvIGJldHRlciBpbGx1c3Ry
YXRlIGU1MDAvMzIgaGVyZToNCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eHBwYy93aWtpL3dp
a2kvSHVnZS1wYWdlcyNlNTAwDQo+Pg0KPj4gRm9yIDY0IGJpdHM6DQo+PiBXZSBoYXZlIFBURS9Q
TUQvUFVEL1BHRCwgbm8gUDREDQo+Pg0KPj4gU2VlIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9u
b2hhc2gvNjQvcGd0YWJsZS00ay5oDQo+IA0KPiBXZSBkb24ndCBoYXZlIGFueXRoaW5nIHRoYXQg
aXMgYWJvdmUgcHVkIGluIHRoaXMgY2F0ZWdvcnksIHJpZ2h0PyAgVGhhdCdzDQo+IHdoYXQgSSBy
ZWFkIGZyb20geW91ciB3aWtpIChhbmQgdGhhbmtzIGZvciBwcm92aWRpbmcgdGhhdCBpbiB0aGUg
Zmlyc3QNCj4gcGxhY2U7IGhlbHBzIGEgbG90IGZvciBtZSB0byB1bmRlcnN0YW5kIGhvdyBpdCB3
b3JrcyBvbiBQb3dlclBDKS4NCg0KWWVzIHRoYW5rcyB0byBNaWNoYWVsIGFuZCBBbmVlc2ggd2hv
IGluaXRpYXRlZCB0aGF0IFdpa2kgcGFnZS4NCg0KPiANCj4gSSB3YW50IHRvIG1ha2Ugc3VyZSBp
ZiBJIGNhbiBtb3ZlIG9uIHdpdGhvdXQgY2FyaW5nIG9uIHA0ZC9wZ2QgbGVhZnMgbGlrZQ0KPiB3
aGF0IHdlIGRvIHJpZ2h0IG5vdywgZXZlbiBhZnRlciBpZiB3ZSBjYW4gcmVtb3ZlIGh1Z2VwZCBm
b3IgZ29vZCwgaW4gdGhpcw0KPiBjYXNlIHNpbmNlIHA0ZCBhbHdheXMgbWlzc2luZywgdGhlbiBp
dCdzIGFib3V0IHdoZXRoZXIgInB1ZHxwbWR8cHRlX2xlYWYoKSINCj4gY2FuIGFsc28gY292ZXIg
dGhlIHBnZCBvbmVzIHdoZW4gdGhhdCBkYXkgY29tZXMsIGlpdWMuDQoNCkkgZ3Vlc3Mgc28gYnV0
IEknZCBsaWtlIEFuZWVzaCBhbmQvb3IgTWljaGFlbCB0byBjb25maXJtIGFzIEknbSBub3QgYW4g
DQpleHBlcnQgb24gUFBDNjQuDQoNCkNocmlzdG9waGUNCg==

