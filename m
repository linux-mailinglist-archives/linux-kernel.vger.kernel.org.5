Return-Path: <linux-kernel+bounces-112827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AED887EBD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D11A1C20A90
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D41DF49;
	Sun, 24 Mar 2024 19:42:45 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE3D2F0
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711309364; cv=none; b=jk17Xvo5tTmBzp6+Z0r5mwk0E6l0VUfRMHDQF6oYJGReRhYLUU7q+R4VnYfjKunZrc+PqvXXEaNMgJynbefS5IhP7acvcrS40dlgSl+BVJWBgwmpVzEDvhBEo2Igf/XvxgQYGrq3x0kzLtvCJTpq2eEsJFYS2E30T4sqhZIcrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711309364; c=relaxed/simple;
	bh=g9m7dqjRragZ2LXLmicF4jS3fSntPHPxFqJlJMPfl5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Baqn5BcvL9Fb8KRwEg4mHQMpJRdS22XPSHp+3PluRKzLs6m11LZbElfiNXiwaR9Yddo6niu+ZpNu5ftvSZuVRxqT4xwz/SuoR5y7heMv/mug/nVzYh+9ZQBTf6gQNiEzd0oj+R5iSwyVXl5szAre/ORsVVSAIELHYUxmAa8rT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-167-cBerPzxMMvq7r4HSCZcRYg-1; Sun, 24 Mar 2024 19:42:32 +0000
X-MC-Unique: cBerPzxMMvq7r4HSCZcRYg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Mar
 2024 19:42:01 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Mar 2024 19:42:01 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexandre Ghiti' <alex@ghiti.fr>, Samuel Holland
	<samuel.holland@sifive.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, "Andrew
 Morton" <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Kemeng Shi
	<shikemeng@huaweicloud.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>, Yangyu Chen
	<cyy@cyyself.name>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Topic: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Index: AQHaeh3F9DUQSIkEB0u5Xt52XMTyX7FHT0cA
Date: Sun, 24 Mar 2024 19:42:01 +0000
Message-ID: <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
In-Reply-To: <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
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

Li4uDQo+IFRoZSB1c2Ugb2YgYWx0ZXJuYXRpdmVzIGFsbG93cyB0byByZXR1cm4gcmlnaHQgYXdh
eSBpZiB0aGUgYnVmZmVyIGlzDQo+IGJleW9uZCB0aGUgdXNhYmxlIHVzZXIgYWRkcmVzcyBzcGFj
ZSwgYW5kIGl0J3Mgbm90IGp1c3QgInNsaWdodGx5DQo+IGZhc3RlciIgZm9yIHNvbWUgY2FzZXMg
KGEgdmVyeSBsYXJnZSBidWZmZXIgd2l0aCBvbmx5IGEgZmV3IGJ5dGVzIGJlaW5nDQo+IGJleW9u
ZCB0aGUgbGltaXQgb3Igc29tZW9uZSBjb3VsZCBmYXVsdC1pbiBhbGwgdGhlIHVzZXIgcGFnZXMg
YW5kIGZhaWwNCj4gdmVyeSBsYXRlLi4uZXRjKS4gYWNjZXNzX29rKCkgaXMgaGVyZSB0byBndWFy
YW50ZWUgdGhhdCBzdWNoIHNpdHVhdGlvbnMNCj4gZG9uJ3QgaGFwcGVuLCBzbyBhY3R1YWxseSBp
dCBtYWtlcyBtb3JlIHNlbnNlIHRvIHVzZSBhbiBhbHRlcm5hdGl2ZSB0bw0KPiBhdm9pZCB0aGF0
Lg0KDQpJcyBpdCByZWFsbHkgd29ydGggZG9pbmcgQU5ZIG9wdGltaXNhdGlvbnMgZm9yIHRoZSAt
RUZBVUxUIHBhdGg/DQpUaGV5IHJlYWxseSBkb24ndCBoYXBwZW4uDQoNClRoZSBvbmx5IGZhdWx0
IHBhdGggdGhhdCBtYXR0ZXJzIGlzIHRoZSBvbmUgdGhhdCBoYXMgdG8gcGFnZSBpbg0KZGF0YSBm
cm9tIHNvbWV3aGVyZS4NCg0KUHJvdmlkZWQgdGhlcmUgaXMgYSBnYXAgYmV0d2VlbiB0aGUgaGln
aGVzdCB2YWxpZCB1c2VyIGFkZHJlc3MgYW5kIHRoZQ0KbG93ZXN0IHZhbGlkIGtlcm5lbCBhZGRy
ZXNzIChtYXkgbm90IGJlIHRydWUgb24gc29tZSAzMmJpdCBzeXN0ZW1zKQ0KYW5kIGNvcHlfdG8v
ZnJvbV91c2VyKCkgZG8gJ2luY3JlYXNpbmcgYWRkcmVzcycgY29waWVzIHRoZW4gdGhlDQphY2Nl
c3Nfb2soKSBjaGVjayB0aGV5IGRvIGNhbiBhbG1vc3QgY2VydGFpbmx5IGlnbm9yZSB0aGUgbGVu
Z3RoLg0KDQpUaGlzIG1heSBiZSB0cnVlIGZvciBwcmV0dHkgbXVjaCBhbGwgYWNjZXNzX29rKCkg
dGVzdHM/DQpJdCB3b3VsZCBjZXJ0YWlubHkgc2ltcGxpZnkgdGhlIHRlc3QuDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=


