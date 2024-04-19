Return-Path: <linux-kernel+bounces-150986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087768AA76B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0411C2375D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE69745015;
	Fri, 19 Apr 2024 03:46:03 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F553B185;
	Fri, 19 Apr 2024 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498363; cv=none; b=EfODMd2q9bPBc7sZl+m3WsagW7W9hktBnl45VRrz6+6fZPBavCyS4eGVc/E5/7x/2JqFph5e6VjUM7gq1PJHiPG9tNyyGwGCWjGelCRPcz2FcjasR6MWCRxt7pTYK8XAy1RnrpVxlWVmI1pAcOHG9q0QRXWal0TE++fLlLdpOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498363; c=relaxed/simple;
	bh=IT8uduegCu0pyKnOVU5z02VlYi8zOaezyknr3cufOiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GstqH07Oe1LPpWSqnG4p79xPo2JuLdGBjJ0wKkx8JJeAFXTgnSazaI5QK0dszaWaNlIbEdly1EjxHZMQOV7FmqODFy2AnHX84WLECyQ51B5Sf6VM74pLt+zEcbZvlJc9DSHoY742AzseI1SaWJyCZgKZBGNxE2WICkUIMejYEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLL870v9sz1N7wJ;
	Fri, 19 Apr 2024 11:43:03 +0800 (CST)
Received: from kwepemd500010.china.huawei.com (unknown [7.221.188.84])
	by mail.maildlp.com (Postfix) with ESMTPS id B2AE118007C;
	Fri, 19 Apr 2024 11:45:57 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (7.221.188.204) by
 kwepemd500010.china.huawei.com (7.221.188.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 19 Apr 2024 11:45:57 +0800
Received: from kwepemd100011.china.huawei.com ([7.221.188.204]) by
 kwepemd100011.china.huawei.com ([7.221.188.204]) with mapi id 15.02.1258.028;
 Fri, 19 Apr 2024 11:45:57 +0800
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
Thread-Index: AQHakZIsrFTudbCQNUaYtvy2Kt0s7LFtkfSAgAFjA4A=
Date: Fri, 19 Apr 2024 03:45:57 +0000
Message-ID: <d1509a28d4b94283a936528d117bbc8d@huawei.com>
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
Content-ID: <908E456F30C36D459F861E4113D0C65B@huawei.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksIEFybmFsZG8sDQoNCk9uIFRodSwgQXByIDE4LCAyMDI0IGF0IDExOjM1OjA1QU0gLTAzMDAs
IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyB3cm90ZToNCj4gT24gVGh1LCBBcHIgMTgsIDIwMjQg
YXQgMDk6MTM6MDFQTSArMDgwMCwgQ2hhbmdiaW4gRHUgd3JvdGU6DQo+ID4gTWlzc2VkIGEgc3Ry
aW5nIHNwZWNpZmllciAnJXMnIGluIGZvcm1hdCBzdHJpbmcuDQo+IA0KPiBIdW1tLCB3aGF0IGJy
YW5jaCBzaG91bGQgdGhpcyBiZSBhcHBsaWVkIHRvPyBJIGFzayBiZWNhdXNlOg0KPiANCj4g4qyi
W2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJCBnaXQgbG9nIC0tb25lbGluZSB0b29scy9w
ZXJmL3RyYWNlL2JlYXV0eS9zdGF0eC5jDQo+IGYxMjJiM2Q2ZDE3OTQ1NWUgcGVyZiBiZWF1dHk6
IEludHJvZHVjZSBzY3JhcGUgc2NyaXB0IGZvciB0aGUgJ3N0YXR4JyBzeXNjYWxsICdtYXNrJyBh
cmd1bWVudA0KPiAzZDZjZmJhZjI3OWRkZWM5IHBlcmYgYmVhdXR5OiBJbnRyb2R1Y2Ugc2NyYXBl
IHNjcmlwdCBmb3IgdmFyaW91cyBmcyBzeXNjYWxscyAnZmxhZ3MnIGFyZ3VtZW50cw0KPiBhNjcy
YWY5MTM5YTg0M2ViIHRvb2xzIGhlYWRlcnM6IFJlbW92ZSBhbG1vc3QgdW51c2VkIGNvcHkgb2Yg
dWFwaS9zdGF0LmgsIGFkZCBmZXcgY29uZGl0aW9uYWwgZGVmaW5lcw0KPiA2NjUyODMwYzg3YmU4
NDQ2IHBlcmYgYmVhdXR5OiBVc2UgdGhlIHN5c3RlbSBsaW51eC9mY250bC5oIGluc3RlYWQgb2Yg
YSBjb3B5IGZyb20gdGhlIGtlcm5lbA0KPiA2OTA4MTFmMDEyOGViNjAzIHRvb2xzIGhlYWRlcnMg
dWFwaTogU3luYyBsaW51eC9zdGF0Lmggd2l0aCB0aGUga2VybmVsIHNvdXJjZXMgdG8gcGljayBT
VEFUWF9NTlRfSURfVU5JUVVFDQo+IDQ5Yzc1ZDMwYjAwNzhkMzAgdG9vbHMgaGVhZGVycyB1YXBp
OiBTeW5jIGxpbnV4L3N0YXQuaCB3aXRoIHRoZSBrZXJuZWwgc291cmNlcw0KPiA1ZDMzY2JmZWRi
NTFmNzMyIHBlcmYgYmVhdXR5OiBBZGQgc3VwcG9ydCB0byBTVEFUWF9NTlRfSUQgaW4gdGhlICdz
dGF0eCcgc3lzY2FsbCAnbWFzaycgYXJndW1lbnQNCj4gYzY1YzgzZmZlOTA0NTkwMSBwZXJmIHRy
YWNlOiBBbGxvdyBhc2tpbmcgZm9yIG5vdCBzdXBwcmVzc2luZyBjb21tb24gc3RyaW5nIHByZWZp
eGVzDQo+IDc5NGY1OTRlMGMzYmU2MTkgcGVyZiBiZWF1dHk6IFN3aXRjaCBmcm9tIEdQTCB2Mi4w
IHRvIExHUEwgdjIuMQ0KPiBmZDVjZWFkMjNmNTQ2OTczICh0YWc6IHBlcmYtY29yZS1mb3ItbWlu
Z28tNC4xMi0yMDE3MDMzMSkgcGVyZiB0cmFjZTogQmVhdXRpZnkgc3RhdHggc3lzY2FsbCAnZmxh
ZycgYW5kICdtYXNrJyBhcmd1bWVudHMNCj4g4qyiW2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5l
eHRdJA0KPiANCj4g4qyiW2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJCB0b29scy9wZXJm
L3RyYWNlL2JlYXV0eS9zdGF0eF9tYXNrLnNoIA0KPiBzdGF0aWMgY29uc3QgY2hhciAqc3RhdHhf
bWFza1tdID0gew0KPiAJW2lsb2cyKDB4MDAwMDAwMDEpICsgMV0gPSAiVFlQRSIsDQo+IAlbaWxv
ZzIoMHgwMDAwMDAwMikgKyAxXSA9ICJNT0RFIiwNCj4gCVtpbG9nMigweDAwMDAwMDA0KSArIDFd
ID0gIk5MSU5LIiwNCj4gCVtpbG9nMigweDAwMDAwMDA4KSArIDFdID0gIlVJRCIsDQo+IAlbaWxv
ZzIoMHgwMDAwMDAxMCkgKyAxXSA9ICJHSUQiLA0KPiAJW2lsb2cyKDB4MDAwMDAwMjApICsgMV0g
PSAiQVRJTUUiLA0KPiAJW2lsb2cyKDB4MDAwMDAwNDApICsgMV0gPSAiTVRJTUUiLA0KPiAJW2ls
b2cyKDB4MDAwMDAwODApICsgMV0gPSAiQ1RJTUUiLA0KPiAJW2lsb2cyKDB4MDAwMDAxMDApICsg
MV0gPSAiSU5PIiwNCj4gCVtpbG9nMigweDAwMDAwMjAwKSArIDFdID0gIlNJWkUiLA0KPiAJW2ls
b2cyKDB4MDAwMDA0MDApICsgMV0gPSAiQkxPQ0tTIiwNCj4gCVtpbG9nMigweDAwMDAwODAwKSAr
IDFdID0gIkJUSU1FIiwNCj4gCVtpbG9nMigweDAwMDAxMDAwKSArIDFdID0gIk1OVF9JRCIsDQo+
IAlbaWxvZzIoMHgwMDAwMjAwMCkgKyAxXSA9ICJESU9BTElHTiIsDQo+IAlbaWxvZzIoMHgwMDAw
NDAwMCkgKyAxXSA9ICJNTlRfSURfVU5JUVVFIiwNCj4gfTsNCj4g4qyiW2FjbWVAdG9vbGJveCBw
ZXJmLXRvb2xzLW5leHRdJA0KPiANCj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IHdpdGggd2hhdCBpcyBp
bg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZXJm
L3BlcmYtdG9vbHMtbmV4dC5naXQsDQo+IGJyYW5jaCBwZXJmLXRvb2xzLW5leHQ/DQo+IA0KPiAt
IEFybmFsZG8NCj4NClRoaXMgY29kZSBoYXMgYmVlbiByZWZhY3RvcmVkIGFuZCB0aGUgb2xkIGJ1
ZyBpcyBnb25lLiBDb3VsZCB5b3UganVzdCBwaWNrIHVwDQp0aGUgbGFzdCB0d28gY2hhbmdlcz8N
Cg0KICBwZXJmIHRyYWNlIGJlYXV0eTogQWx3YXlzIHNob3cgcGFyYW0gaWYgc2hvd196ZXJvIGlz
IHNldA0KICBwZXJmIHRyYWNlIGJlYXV0eTogQWx3YXlzIHNob3cgbXByb3RlY3QgcHJvdCBldmVu
IHRob3VnaCBQUk9UX05PTkUNCg0KLS0gDQpDaGVlcnMsDQpDaGFuZ2JpbiBEdQ0K

