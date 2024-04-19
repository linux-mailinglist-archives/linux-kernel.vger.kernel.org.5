Return-Path: <linux-kernel+bounces-150907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621CD8AA695
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8601A1C21456
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F97D17FD;
	Fri, 19 Apr 2024 01:38:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654C138E;
	Fri, 19 Apr 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490718; cv=none; b=itTRhCZwqsJuo89wH9UBMAtvW+dipMoYYBbYawjYLl7ud/xz48YW5FP0d+x0uB1w9hGbAIOPCdmveVAg26wvp9cv/cjlvFYoaHIVkgP2p+XJ0ovgDwOG8RZzlI8OZaJgdhnp/qLt6wgft4a6u7cqnGUZUMQ+WQiAWND7HOtNrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490718; c=relaxed/simple;
	bh=O0KLYIEzxMcIIttGgaRtxvAquHTK9nmonkyI4Cv0x3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JaaLXjGZBcVoPIHkmOfnqi25W7EF3V1agFXTbf8+RwL35Gsk7I7jDGqw8O1ejO60JwhhhhiEgmSDi5P+roBco80z7BkQG0YmZNchw7zEeEUQkKhNVLCSs+KEcYDkaoH4G8PWrQ6aTnbJwdz9+kRAv9w3x82eDLiGcXEOV3X330M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VLHMH3ZZHz1HBt5;
	Fri, 19 Apr 2024 09:37:31 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id F2A121A016C;
	Fri, 19 Apr 2024 09:38:26 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 09:38:26 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.028;
 Fri, 19 Apr 2024 09:38:26 +0800
From: duchangbin <changbin.du@huawei.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: duchangbin <changbin.du@huawei.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] perf trace beauty: Fix statx flags printing
Thread-Topic: [PATCH 1/4] perf trace beauty: Fix statx flags printing
Thread-Index: AQHakZIsrFTudbCQNUaYtvy2Kt0s7LFtkfSAgAE/Y4A=
Date: Fri, 19 Apr 2024 01:38:26 +0000
Message-ID: <9dee50c53fcc4dcb97722ddc22a5cdc5@huawei.com>
References: <20240418131304.3188385-1-changbin.du@huawei.com>
 <20240418131304.3188385-2-changbin.du@huawei.com> <ZiEvmabmIxTjDLeb@x1>
In-Reply-To: <ZiEvmabmIxTjDLeb@x1>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: kwepemd100011.china.huawei.com (15.02.1258.028)
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCC7FB01A6968A4194ABE0EAEEFC94F5@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCBBcHIgMTgsIDIwMjQgYXQgMTE6MzU6MDVBTSAtMDMwMCwgQXJuYWxkbyBDYXJ2YWxo
byBkZSBNZWxvIHdyb3RlOg0KPiBPbiBUaHUsIEFwciAxOCwgMjAyNCBhdCAwOToxMzowMVBNICsw
ODAwLCBDaGFuZ2JpbiBEdSB3cm90ZToNCj4gPiBNaXNzZWQgYSBzdHJpbmcgc3BlY2lmaWVyICcl
cycgaW4gZm9ybWF0IHN0cmluZy4NCj4gDQo+IEh1bW0sIHdoYXQgYnJhbmNoIHNob3VsZCB0aGlz
IGJlIGFwcGxpZWQgdG8/IEkgYXNrIGJlY2F1c2U6DQo+IA0KPiDirKJbYWNtZUB0b29sYm94IHBl
cmYtdG9vbHMtbmV4dF0kIGdpdCBsb2cgLS1vbmVsaW5lIHRvb2xzL3BlcmYvdHJhY2UvYmVhdXR5
L3N0YXR4LmMNCj4gZjEyMmIzZDZkMTc5NDU1ZSBwZXJmIGJlYXV0eTogSW50cm9kdWNlIHNjcmFw
ZSBzY3JpcHQgZm9yIHRoZSAnc3RhdHgnIHN5c2NhbGwgJ21hc2snIGFyZ3VtZW50DQo+IDNkNmNm
YmFmMjc5ZGRlYzkgcGVyZiBiZWF1dHk6IEludHJvZHVjZSBzY3JhcGUgc2NyaXB0IGZvciB2YXJp
b3VzIGZzIHN5c2NhbGxzICdmbGFncycgYXJndW1lbnRzDQo+IGE2NzJhZjkxMzlhODQzZWIgdG9v
bHMgaGVhZGVyczogUmVtb3ZlIGFsbW9zdCB1bnVzZWQgY29weSBvZiB1YXBpL3N0YXQuaCwgYWRk
IGZldyBjb25kaXRpb25hbCBkZWZpbmVzDQo+IDY2NTI4MzBjODdiZTg0NDYgcGVyZiBiZWF1dHk6
IFVzZSB0aGUgc3lzdGVtIGxpbnV4L2ZjbnRsLmggaW5zdGVhZCBvZiBhIGNvcHkgZnJvbSB0aGUg
a2VybmVsDQo+IDY5MDgxMWYwMTI4ZWI2MDMgdG9vbHMgaGVhZGVycyB1YXBpOiBTeW5jIGxpbnV4
L3N0YXQuaCB3aXRoIHRoZSBrZXJuZWwgc291cmNlcyB0byBwaWNrIFNUQVRYX01OVF9JRF9VTklR
VUUNCj4gNDljNzVkMzBiMDA3OGQzMCB0b29scyBoZWFkZXJzIHVhcGk6IFN5bmMgbGludXgvc3Rh
dC5oIHdpdGggdGhlIGtlcm5lbCBzb3VyY2VzDQo+IDVkMzNjYmZlZGI1MWY3MzIgcGVyZiBiZWF1
dHk6IEFkZCBzdXBwb3J0IHRvIFNUQVRYX01OVF9JRCBpbiB0aGUgJ3N0YXR4JyBzeXNjYWxsICdt
YXNrJyBhcmd1bWVudA0KPiBjNjVjODNmZmU5MDQ1OTAxIHBlcmYgdHJhY2U6IEFsbG93IGFza2lu
ZyBmb3Igbm90IHN1cHByZXNzaW5nIGNvbW1vbiBzdHJpbmcgcHJlZml4ZXMNCj4gNzk0ZjU5NGUw
YzNiZTYxOSBwZXJmIGJlYXV0eTogU3dpdGNoIGZyb20gR1BMIHYyLjAgdG8gTEdQTCB2Mi4xDQo+
IGZkNWNlYWQyM2Y1NDY5NzMgKHRhZzogcGVyZi1jb3JlLWZvci1taW5nby00LjEyLTIwMTcwMzMx
KSBwZXJmIHRyYWNlOiBCZWF1dGlmeSBzdGF0eCBzeXNjYWxsICdmbGFnJyBhbmQgJ21hc2snIGFy
Z3VtZW50cw0KPiDirKJbYWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0kDQo+IA0KPiDirKJb
YWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0kIHRvb2xzL3BlcmYvdHJhY2UvYmVhdXR5L3N0
YXR4X21hc2suc2ggDQo+IHN0YXRpYyBjb25zdCBjaGFyICpzdGF0eF9tYXNrW10gPSB7DQo+IAlb
aWxvZzIoMHgwMDAwMDAwMSkgKyAxXSA9ICJUWVBFIiwNCj4gCVtpbG9nMigweDAwMDAwMDAyKSAr
IDFdID0gIk1PREUiLA0KPiAJW2lsb2cyKDB4MDAwMDAwMDQpICsgMV0gPSAiTkxJTksiLA0KPiAJ
W2lsb2cyKDB4MDAwMDAwMDgpICsgMV0gPSAiVUlEIiwNCj4gCVtpbG9nMigweDAwMDAwMDEwKSAr
IDFdID0gIkdJRCIsDQo+IAlbaWxvZzIoMHgwMDAwMDAyMCkgKyAxXSA9ICJBVElNRSIsDQo+IAlb
aWxvZzIoMHgwMDAwMDA0MCkgKyAxXSA9ICJNVElNRSIsDQo+IAlbaWxvZzIoMHgwMDAwMDA4MCkg
KyAxXSA9ICJDVElNRSIsDQo+IAlbaWxvZzIoMHgwMDAwMDEwMCkgKyAxXSA9ICJJTk8iLA0KPiAJ
W2lsb2cyKDB4MDAwMDAyMDApICsgMV0gPSAiU0laRSIsDQo+IAlbaWxvZzIoMHgwMDAwMDQwMCkg
KyAxXSA9ICJCTE9DS1MiLA0KPiAJW2lsb2cyKDB4MDAwMDA4MDApICsgMV0gPSAiQlRJTUUiLA0K
PiAJW2lsb2cyKDB4MDAwMDEwMDApICsgMV0gPSAiTU5UX0lEIiwNCj4gCVtpbG9nMigweDAwMDAy
MDAwKSArIDFdID0gIkRJT0FMSUdOIiwNCj4gCVtpbG9nMigweDAwMDA0MDAwKSArIDFdID0gIk1O
VF9JRF9VTklRVUUiLA0KPiB9Ow0KPiDirKJbYWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0k
DQo+IA0KPiBDYW4geW91IHBsZWFzZSB0cnkgd2l0aCB3aGF0IGlzIGluDQo+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3BlcmYvcGVyZi10b29scy1uZXh0
LmdpdCwNCj4gYnJhbmNoIHBlcmYtdG9vbHMtbmV4dD8NCj4gDQpObyBwcm9ibGVtLCBsZXQgbWUg
cmViYXNlIG9uIHBlcmYtdG9vbHMtbmV4dC4gVGhpcyBwYXRjaHNldCB3YXMgY3JlYXRlZCBvbg0K
bWFpbmxpbmUuDQoNCj4gLSBBcm5hbGRvDQo+ICANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ2Jp
biBEdSA8Y2hhbmdiaW4uZHVAaHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgdG9vbHMvcGVyZi90
cmFjZS9iZWF1dHkvc3RhdHguYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYv
dHJhY2UvYmVhdXR5L3N0YXR4LmMgYi90b29scy9wZXJmL3RyYWNlL2JlYXV0eS9zdGF0eC5jDQo+
ID4gaW5kZXggZGM1OTQzYTYzNTJkLi5jNjFmMmJlNTNiZGEgMTAwNjQ0DQo+ID4gLS0tIGEvdG9v
bHMvcGVyZi90cmFjZS9iZWF1dHkvc3RhdHguYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdHJhY2Uv
YmVhdXR5L3N0YXR4LmMNCj4gPiBAQCAtMjEsNyArMjEsNyBAQCBzaXplX3Qgc3lzY2FsbF9hcmdf
X3NjbnByaW50Zl9zdGF0eF9mbGFncyhjaGFyICpiZiwgc2l6ZV90IHNpemUsIHN0cnVjdCBzeXNj
YWxsXw0KPiA+ICAJCXJldHVybiBzY25wcmludGYoYmYsIHNpemUsICIlcyVzIiwgc2hvd19wcmVm
aXggPyAiQVRfU1RBVFhfIiA6ICIiLCAiU1lOQ19BU19TVEFUIik7DQo+ID4gICNkZWZpbmUJUF9G
TEFHKG4pIFwNCj4gPiAgCWlmIChmbGFncyAmIEFUXyMjbikgeyBcDQo+ID4gLQkJcHJpbnRlZCAr
PSBzY25wcmludGYoYmYgKyBwcmludGVkLCBzaXplIC0gcHJpbnRlZCwgIiVzJXMiLCBwcmludGVk
ID8gInwiIDogIiIsIHNob3dfcHJlZml4ID8gcHJlZml4IDogIiIsICNuKTsgXA0KPiA+ICsJCXBy
aW50ZWQgKz0gc2NucHJpbnRmKGJmICsgcHJpbnRlZCwgc2l6ZSAtIHByaW50ZWQsICIlcyVzJXMi
LCBwcmludGVkID8gInwiIDogIiIsIHNob3dfcHJlZml4ID8gcHJlZml4IDogIiIsICNuKTsgXA0K
PiA+ICAJCWZsYWdzICY9IH5BVF8jI247IFwNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLS0gDQo+ID4g
Mi4zNC4xDQo+IA0KDQotLSANCkNoZWVycywNCkNoYW5nYmluIER1DQo=

