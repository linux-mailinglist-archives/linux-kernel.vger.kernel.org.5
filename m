Return-Path: <linux-kernel+bounces-48976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD659846444
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48DCCB24B68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149EB47A73;
	Thu,  1 Feb 2024 23:05:13 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F13D960
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828712; cv=none; b=LMQVH/gzE0JI8EG5s1uRATJylNdyfJCzKIC4StyT5R90DQWBrJaZOG/dOHazVVCJfTftT6Kg+XfgdP2839hmssLASfVc0loTUKHpVhXazfF22ABURuFz72SHdC/wv9QTo2XKEQHd0HBisGIkTGGpX1sYS27OcTr0YuD4MNN0ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828712; c=relaxed/simple;
	bh=0E8DxCbsv9mGna4yrwg/N6hZd8TR2BJjNLr0nnrm2Mw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sR5o3J5E8+eoqNvlAR6KZwhKvFlzHp+bOshvl7WG4R9livBMQoN9HeYilXLaJb4KGIzAlqfbdxquWoQmo/L0mHXSHcd+FDLATtaVieXosO9OGGxToaj3A86Z6BpLEdZsCzvZOix/ow1wcrQUAUdCkjb4thsV8bm6RdQCmRv2SBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-zJi0fKrcMoSXVrrBEVhQ3A-1; Thu, 01 Feb 2024 23:05:06 +0000
X-MC-Unique: zJi0fKrcMoSXVrrBEVhQ3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 1 Feb
 2024 23:04:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 1 Feb 2024 23:04:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nick Kossifidis' <mick@ics.forth.gr>, Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matteo Croce
	<mcroce@microsoft.com>
Subject: RE: [PATCH 3/3] riscv: optimized memset
Thread-Topic: [PATCH 3/3] riscv: optimized memset
Thread-Index: AQHaU3UjqUWW/ham3UKhY4ir1PAI6bD2G17g
Date: Thu, 1 Feb 2024 23:04:48 +0000
Message-ID: <26a7af6f33fa440f986adb4d690f47dc@AcuMS.aculab.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-4-jszhang@kernel.org>
 <b7ae944c-2b7c-4c8d-8623-a8387b8d4e02@ics.forth.gr>
In-Reply-To: <b7ae944c-2b7c-4c8d-8623-a8387b8d4e02@ics.forth.gr>
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

Li4uDQo+ID4gKwkJLyogQ29tcG9zZSBhbiB1bG9uZyB3aXRoICdjJyByZXBlYXRlZCA0LzggdGlt
ZXMgKi8NCj4gPiArI2lmZGVmIENPTkZJR19BUkNIX0hBU19GQVNUX01VTFRJUExJRVINCj4gPiAr
CQljdSAqPSAweDAxMDEwMTAxMDEwMTAxMDFVTDsNCg0KVGhhdCBpdCBsaWtlbHkgdG8gZ2VuZXJh
dGUgYSBjb21waWxlIGVycm9yIG9uIDMyYml0Lg0KTWF5YmU6DQoJCWN1ICo9ICh1bnNpZ25lZCBs
b25nKTB4MDEwMTAxMDEwMTAxMDEwMVVMTDsNCj4gPiArI2Vsc2UNCj4gPiArCQljdSB8PSBjdSA8
PCA4Ow0KPiA+ICsJCWN1IHw9IGN1IDw8IDE2Ow0KPiA+ICsJCS8qIFN1cHByZXNzIHdhcm5pbmcg
b24gMzIgYml0IG1hY2hpbmVzICovDQo+ID4gKwkJY3UgfD0gKGN1IDw8IDE2KSA8PCAxNjsNCj4g
PiArI2VuZGlmDQo+IA0KPiBJIGd1ZXNzIHlvdSBjb3VsZCBjaGVjayBhZ2FpbnN0IF9fU0laRU9G
X0xPTkdfXyBoZXJlLg0KDQpPciBldmVuIHNpemVvZiAoY3UpLCBwb3NzaWJsZSBhczoNCgkJY3Ug
fD0gY3UgPDwgKHNpemVvZiAoY3UpID09IDggPyAzMiA6IDApOw0Kd2hpY2ggSSdtIHByZXR0eSBz
dXJlIG1vZGVybiBjb21waWxlciB3aWxsIHRocm93IGF3YXkgZm9yIDMyYml0Lg0KDQpJIGRvIHdv
bmRlciB3aGV0aGVyIENPTkZJR19BUkNIX0hBU19GQVNUX01VTFRJUExJRVIgaXMgd29ydGgNCnRl
c3RpbmcgLSB5b3UnZCByZWFsbHkgd2FudCB0byBrbm93IHRoZXJlIGlzIGEgcmlzYy12IGNwdQ0K
d2l0aCBhIG11bHRpcGx5IHRoYXQgaXMgc2xvd2VyIHRoYW4gdGhlIHNoaWZ0IGFuZCBvciB2ZXJz
aW9uLg0KSSBhY3R1YWxseSBkb3VidCBpdC4NCk11bHRpcGx5IGlzIHVzZWQgc28gb2Z0ZW4gKGFs
bCBhcnJheSBpbmRleGluZykgdGhhdCB5b3UNCnJlYWxseSBkbyBuZWVkIHNvbWV0aGluZyBiZXR0
ZXIgdGhhbiBhICcxIGJpdCBwZXIgY2xvY2snIGxvb3AuDQoNCkl0IGlzIHdvcnRoIHJlbWVtYmVy
aW5nIHRoYXQgeW91IGNhbiBpbXBsZW1lbnQgYW4gbipuIG11bHRpcGx5DQp3aXRoIG4qbiAnZnVs
bCBhZGRlcnMnICgzIGlucHV0IGJpdHMsIDIgb3V0cHV0IGJpdHMpIHdpdGggYQ0KbGF0ZW5jeSBv
ZiAyKm4gYWRkZXJzLg0KU28gdGhlIGxhdGVuY3kgaXMgb25seSB0d2ljZSB0aGF0IG9mIHRoZSBj
b3JyZXNwb25kaW5nIGFkZC4NCkZvciBhIG1vZGVybiBjaGlwIHRoYXQgaXMgbm90IG11Y2ggbG9n
aWMgYXQgYWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


