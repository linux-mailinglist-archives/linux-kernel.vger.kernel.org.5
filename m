Return-Path: <linux-kernel+bounces-9675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DF981C96A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0AB2B22A73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DE118026;
	Fri, 22 Dec 2023 11:52:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F21802F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-xeT26KtROmq9ThAudnAjmA-1; Fri, 22 Dec 2023 11:52:54 +0000
X-MC-Unique: xeT26KtROmq9ThAudnAjmA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 11:52:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 11:52:39 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guo Ren' <guoren@kernel.org>, Leonardo Bras <leobras@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	"charlie@rivosinc.com" <charlie@rivosinc.com>, "xiao.w.wang@intel.com"
	<xiao.w.wang@intel.com>, "david@redhat.com" <david@redhat.com>,
	"panqinglin2020@iscas.ac.cn" <panqinglin2020@iscas.ac.cn>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"willy@infradead.org" <willy@infradead.org>, "bjorn@rivosinc.com"
	<bjorn@rivosinc.com>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Guo Ren
	<guoren@linux.alibaba.com>
Subject: RE: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Thread-Topic: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Thread-Index: AQHaNMmXQnV6P1CryUOzF1IfQQ8rsbC1Lv+w
Date: Fri, 22 Dec 2023 11:52:39 +0000
Message-ID: <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-5-guoren@kernel.org> <ZYUZ8QUJxCL93Fgv@LeoBras>
 <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
In-Reply-To: <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAyMiBEZWNlbWJlciAyMDIzIDExOjI1DQouLi4NCj4gPiA+
ICsjZGVmaW5lIFRBU0tfU0laRSAgICAoaXNfY29tcGF0X3Rhc2soKSA/IFwNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgVEFTS19TSVpFXzMyIDogVEFTS19TSVpFXzY0KQ0KPiBJIHdvdWxk
IHJlbW92ZSBpc19jb21wYXRfdGFzaygpIGluIHRoZSBuZXh0IHZlcnNpb24gYmVjYXVzZSB5b3Vy
IHBhdGNoDQo+IGNvbnRhaW5zIHRoYXQuDQoNCkRvZXMgVEFTS19TSVpFIGdldCB1c2VkIGluIGFj
Y2Vzc19vaygpID8NCklmIHNvIHRoZSByZXBlYXRlZCBleHBhbnNpb24gb2YgdGhhdCAnbWVzcycg
d2lsbCBzbG93IHRoaW5ncyBkb3duLg0KDQpPVE9IIGFjY2Vzc19vayhwdHIsIGxlbikgY2FuIGp1
c3QgY2hlY2sgKHB0ciB8IChwdHIgKyBsZW4pKSA8IDApDQphbmQgcmVseSBvbiB0aGUgcGFnZSBm
YXVsdHMgZm9yIGV2ZXJ5dGhpbmcgZWxzZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


