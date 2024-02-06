Return-Path: <linux-kernel+bounces-54452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE1484AF6F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807101F23A8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E8812A172;
	Tue,  6 Feb 2024 07:57:53 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A439AD5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206272; cv=none; b=O+YwFgTM7OiSNzitz+L8uDD2yGIQhyC2tTazvvVbDXcrAl0TfA2v87giPxKbdCqcdbzXpFF5c06qKQxZIExlIPXYLzElAWDhDBydDoQO1uc4kCh2PL0McGj542tfDhhmY+A2uPP5OWolpVo6NcTzo7cmC7mQ+oqAaQrDkY+ZRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206272; c=relaxed/simple;
	bh=c18OyalUZ1qVMoHke+pl1er7ELpFT/2Pv/C5wT8/3gw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+XaJWRTgu71l2zjhueQO3thdbfvEniVuMlYd9yrUEc2qTS5J5SJKWoMLPDqu4xvD2p0keyzLf+weIJKc1Ah/pFpxgg5CyEYEVGiyDxBTMrPzHOEmte/tmw6BADifKaWijNVgB+ONiWPJlw2Zzb4bbpSI1kkE3Ndrg7liin6H/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4167vVF0057752;
	Tue, 6 Feb 2024 15:57:31 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TTbFK0nMsz2SDHVM;
	Tue,  6 Feb 2024 15:57:25 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 6 Feb 2024
 15:57:29 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::f022:2a7c:e5bc:aacd]) by
 BJMBX02.spreadtrum.com ([fe80::f022:2a7c:e5bc:aacd%19]) with mapi id
 15.00.1497.023; Tue, 6 Feb 2024 15:57:29 +0800
From: =?utf-8?B?5byg5pa55q2jIChGYW5nemhlbmcgWmhhbmcp?=
	<fangzheng.zhang@unisoc.com>
To: "Christoph Lameter (Ampere)" <cl@linux.com>,
        Vlastimil Babka
	<vbabka@suse.cz>
CC: Greg KH <gregkh@linuxfoundation.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin
	<roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        =?utf-8?B?6Z+p546J5piOIChZdW1pbmcgSGFuKQ==?=
	<yuming.han@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1tL3NsYWI6IEFkZCBzbGFicmVjbGFpbSBmbGFn?=
 =?utf-8?Q?_to_slabinfo?=
Thread-Topic: [PATCH] mm/slab: Add slabreclaim flag to slabinfo
Thread-Index: AQHaVCouxTfACJupakedbzUjZG1LvLD5qEcAgAFJ8oCAAJgXAIABa2YQ
Date: Tue, 6 Feb 2024 07:57:28 +0000
Message-ID: <f6d4305ac88b440e801d24949aca357d@BJMBX02.spreadtrum.com>
References: <20240131094442.28834-1-fangzheng.zhang@unisoc.com>
 <2024020441-version-chihuahua-1067@gregkh>
 <2f43774a-16cf-412e-b4b7-840889bb796b@suse.cz>
 <202402060127.4161Ri2X082625@SHSPAM01.spreadtrum.com>
In-Reply-To: <202402060127.4161Ri2X082625@SHSPAM01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 4167vVF0057752

RnJpc3QsIHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgY29tbWVudHMgYW5kIEkgd291bGQg
bGlrZSB0byBzYXksIHdoZW4gcGVyZm9ybWluZyBzbGFiIG1lbW9yeSBpbmZvcm1hdGlvbiBtYWlu
dGVuYW5jZSwgcGVvcGxlIG9mdGVuIGhvcGUgdG8gc2VlIG1vcmUgZGV0YWlsZWQgaW5mb3JtYXRp
b24gdGhyb3VnaCBhIHNpbXBsZSBzbGFiaW5mbyBjb21tYW5kLiBBcyBWbGFzdGltaWwgbWVudGlv
bmVkIHRoZSBtZXRob2QsIGJ1dCBpdCBpcyB2ZXJ5IHVuaW50dWl0aXZlIHRvIHRoZSBzdGF0dXMg
b2YgdGhlIGVudGlyZSBzbGFiLCBzbyB3ZSBhZGQgdGhlIHNsYWJyZWNsYWltIGNvbHVtbiB0byBz
bGFiaW5mbyBhbmQgZGlyZWN0bHkgb3V0cHV0IGl0IHVzaW5nIGNtZGxpbmUgJyA+IGNhdCBwcm9j
L3NsYWJpbmZvJy4gQW5kIEkgdGhpbmsgdGhpcyBhcHByb2FjaCB3aWxsIGFsc28gYmUgaGVscGZ1
bCBmb3IgZnV0dXJlIHdvcmsgb24gbWVtb3J5IHN0YXRpc3RpY3MuIEFuZCBJIGZvdW5kIHRoYXQg
dGhlcmUgaXMgbm8gY29ycmVzcG9uZGluZyBzbGFiaW5mbyBvdXRwdXQgZXhhbXBsZSBpbiB0aGUg
cHJvYy5yc3QgZG9jdW1lbnQuIENhbiB3ZSBhZGQgYSBvdXRwdXQgZXhhbXBsZSBzbyB0aGF0IHVz
ZXJzcGFjZSBrbm93cyBhYm91dCBpdD8gDQoNCkR1ZSB0byBpbnN1ZmZpY2llbnQgdW5kZXJzdGFu
ZGluZyBvZiB0aGUgY29kZSBmcmFtZXdvcmsgdXNlZCBieSB0aGUgc2xhYmluZm8gdG9vbCwgdGhp
cyBwYXRjaCB3YXMgbm90IGNvbnNpZGVyZWQuIE9mIGNvdXJzZSwgSSB0aGluayBpbiB0aGUgbmV4
dCB3ZSB3aWxsIGNvbnNpZGVyIG1hcmtpbmcgL3Byb2Mvc2xhYmluZm8gYXMgZGVwcmVjYXRlZCwg
YW5kIHRoZW4gdXNlIHRoZSAic2xhYmluZm8iIHRvb2wgdG8gaW1wbGVtZW50IHRoZSBjb3JyZXNw
b25kaW5nIHByb2Mvc2xhYmluZm8gZnVuY3Rpb25zLg0KDQpUaGFua3MgYWdhaW4hDQotLS0tLemC
ruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IENocmlzdG9waCBMYW1ldGVyIChBbXBlcmUpIDxj
bEBsaW51eC5jb20+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0MuaciDbml6UgMTo1NQ0K5pS25Lu2
5Lq6OiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNlLmN6Pg0K5oqE6YCBOiBHcmVnIEtIIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IOW8oOaWueatoyAoRmFuZ3poZW5nIFpoYW5nKSA8
ZmFuZ3poZW5nLnpoYW5nQHVuaXNvYy5jb20+OyBQZWtrYSBFbmJlcmcgPHBlbmJlcmdAa2VybmVs
Lm9yZz47IERhdmlkIFJpZW50amVzIDxyaWVudGplc0Bnb29nbGUuY29tPjsgSm9vbnNvbyBLaW0g
PGlhbWpvb25zb28ua2ltQGxnZS5jb20+OyBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5k
YXRpb24ub3JnPjsgUm9tYW4gR3VzaGNoaW4gPHJvbWFuLmd1c2hjaGluQGxpbnV4LmRldj47IEh5
ZW9uZ2dvbiBZb28gPDQyLmh5ZXlvb0BnbWFpbC5jb20+OyBsaW51eC1tbUBrdmFjay5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEZhbmd6aGVuZyBaaGFuZyA8ZmFuZ3poZW5nLnpo
YW5nMTAwM0BnbWFpbC5jb20+OyDpn6nnjonmmI4gKFl1bWluZyBIYW4pIDx5dW1pbmcuaGFuQHVu
aXNvYy5jb20+OyBDaHVueWFuIFpoYW5nIDx6aGFuZy5seXJhQGdtYWlsLmNvbT4NCuS4u+mimDog
UmU6IFtQQVRDSF0gbW0vc2xhYjogQWRkIHNsYWJyZWNsYWltIGZsYWcgdG8gc2xhYmluZm8NCg0K
DQrms6jmhI86IOi/meWwgemCruS7tuadpeiHquS6juWklumDqOOAgumZpOmdnuS9oOehruWumumC
ruS7tuWGheWuueWuieWFqO+8jOWQpuWImeS4jeimgeeCueWHu+S7u+S9lemTvuaOpeWSjOmZhOS7
tuOAgg0KQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUg
b3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUu
DQoNCg0KDQpPbiBNb24sIDUgRmViIDIwMjQsIFZsYXN0aW1pbCBCYWJrYSB3cm90ZToNCg0KPiBP
biAyLzQvMjQgMTQ6MDksIEdyZWcgS0ggd3JvdGU6DQo+PiBPbiBXZWQsIEphbiAzMSwgMjAyNCBh
dCAwNTo0NDo0MlBNICswODAwLCBGYW5nemhlbmcgWmhhbmcgd3JvdGU6DQo+Pj4gSW4gb3JkZXIg
dG8gZW5oYW5jZSBzbGFiIGRlYnVnZ2luZywgd2UgYWRkIHNsYWJyZWNsYWltIGZsYWcgdG8gDQo+
Pj4gc2xhYmluZm8uIFNsYWIgdHlwZSBpcyBhbHNvIGFuIGltcG9ydGFudCBhbmFseXNpcyBwb2lu
dCBpbiBzbGFiaW5mbyANCj4+PiBmb3IgcGVyIHNsYWIsIHdoZW4gdmFyaW91cyBwcm9ibGVtcyBz
dWNoIGFzIG1lbW9yeSBsZWFrcyBvciBtZW1vcnkgDQo+Pj4gc3RhdGlzdGljcyBvY2N1ci4NCj4+
Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEZhbmd6aGVuZyBaaGFuZyA8ZmFuZ3poZW5nLnpoYW5nQHVu
aXNvYy5jb20+DQo+Pj4gLS0tDQo+Pj4gIG1tL3NsYWJfY29tbW9uLmMgfCA3ICsrKystLS0NCj4+
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9tbS9zbGFiX2NvbW1vbi5jIGIvbW0vc2xhYl9jb21tb24uYyBpbmRl
eCANCj4+PiAyMzgyOTNiMWRiZTEuLmFlZWIyYmZlNmRkYSAxMDA2NDQNCj4+PiAtLS0gYS9tbS9z
bGFiX2NvbW1vbi5jDQo+Pj4gKysrIGIvbW0vc2xhYl9jb21tb24uYw0KPj4+IEBAIC0xMDM4LDcg
KzEwMzgsNyBAQCBzdGF0aWMgdm9pZCBwcmludF9zbGFiaW5mb19oZWFkZXIoc3RydWN0IHNlcV9m
aWxlICptKQ0KPj4+ICAgICBzZXFfcHV0cyhtLCAic2xhYmluZm8gLSB2ZXJzaW9uOiAyLjFcbiIp
Ow0KPj4+ICAgICBzZXFfcHV0cyhtLCAiIyBuYW1lICAgICAgICAgICAgPGFjdGl2ZV9vYmpzPiA8
bnVtX29ianM+IDxvYmpzaXplPiA8b2JqcGVyc2xhYj4gPHBhZ2VzcGVyc2xhYj4iKTsNCj4+PiAg
ICAgc2VxX3B1dHMobSwgIiA6IHR1bmFibGVzIDxsaW1pdD4gPGJhdGNoY291bnQ+IDxzaGFyZWRm
YWN0b3I+Iik7DQo+Pj4gLSAgIHNlcV9wdXRzKG0sICIgOiBzbGFiZGF0YSA8YWN0aXZlX3NsYWJz
PiA8bnVtX3NsYWJzPiA8c2hhcmVkYXZhaWw+Iik7DQo+Pj4gKyAgIHNlcV9wdXRzKG0sICIgOiBz
bGFiZGF0YSA8YWN0aXZlX3NsYWJzPiA8bnVtX3NsYWJzPiANCj4+PiArIDxzaGFyZWRhdmFpbD4g
PHNsYWJyZWNsYWltPiIpOw0KPj4NCj4+IERvZXNuJ3QgdGhpcyBjaGFuZ2UgdGhlIHNsYWJpbmZv
IHZlcnNpb24gbnVtYmVyIGFib3ZlPyAgV2hlcmUgaXMgdGhpcyANCj4+IGNoYW5nZSBkb2N1bWVu
dGVkIHNvIHRoYXQgdXNlcnNwYWNlIGtub3dzIGFib3V0IGl0Pw0KDQpJIGhhdmUgbmV2ZXIgc2Vl
biBzdWNoIGEgZG9jdW1lbnQuIEkgd291bGQgc3VnZ2VzdCBpbmNyZW1lbnRpbmcgdGhlIHZlcnNp
b24gdG8gMi4yIHNpbmNlIHRoZXJlIGlzIGEgbWlub3IgZXh0ZW5zaW9uIG9mIHRoZSBmb3JtYXQu
DQoNCkkgdHJpZWQgdG8gcmVtb3ZlIC9wcm9jL3NsYWJpbmZvIGluIHRoZSBwYXN0IGFuZCBoYXZl
IHBlb3BsZSB1c2UgdGhlIG1vcmUgdmVyc2F0aWxlIC9zeXMva2VybmVsL3NsYWIgaW50ZXJmYWNl
LiBCdXQgL3Byb2Mvc2xhYmluZm8gaGFzIGEgbG9uZyBsZWdhY3kuDQoNCkNvdWxkIHdlIG1hcmsg
L3Byb2Mvc2xhYmluZm8gYXMgZGVwcmVjYXRlZCBhbmQgcmVjb21tZW5kIHRoZSB1c2Ugb2YgZWl0
aGVyIHN5c2ZzIGRpcmVjdGx5IG9yIHVzZSBvZiB0aGUgInNsYWJpbmZvIiB0b29sIHRoYXQgd2Ug
aGF2ZSBiZWVuIHByb3ZpZGluZyBpbiBsaW51eC90b29scy9tbSBmb3IgYSBsb25nIHRpbWU/DQoN
Cg==

