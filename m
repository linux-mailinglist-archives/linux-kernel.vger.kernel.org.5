Return-Path: <linux-kernel+bounces-83350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45281869442
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D3C282C21
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7861420A5;
	Tue, 27 Feb 2024 13:51:30 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675313F01E;
	Tue, 27 Feb 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041889; cv=none; b=RTiR3QrJqHTqUFo6G0wiRlGrO2VE7DCNZP8siXdkaBk0x8x8B14GqfcZEbpVuH0CQrDK4hSU4/9NX6m13I/zEFu8FZn43JruAE/Jv3hnGOrLkfRjKu4H/f2IrIZLOJvArfTF+ZTeBBRukd3KScB83rzoggYJS7KvZeibpQicnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041889; c=relaxed/simple;
	bh=25KIikUSQM4AHnPVJzVUXiR8trFSdiqq3nXlzQll/2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cZwkL6WCkcNrbMjwl5TbOkdUoCCk/gBU/iqhuvDA14iQcWlMJexUUB58b5k+msQXLmb/1/VXLMxaHbA5SaI8DWVMPX0cEhbw5L1NTQwa4c8VMgSMncuhPNoP4k8SIe7Ub8CPa3iq3rXztRrbntWQUi6OSVYjn/uy2F9znUg/PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [124.236.128.238] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 27 Feb 2024 21:44:43 +0800
 (GMT+08:00)
Date: Tue, 27 Feb 2024 21:44:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Joe Perches" <joe@perches.com>
Cc: "Arend van Spriel" <arend.vanspriel@broadcom.com>,
	linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
	justinstitt@google.com, john@keeping.me.uk, quic_alokad@quicinc.com,
	marcan@marcan.st, johannes.berg@intel.com, linus.walleij@linaro.org,
	kvalo@kernel.org
Subject: Re: [PATCH] wifi: brcm80211: handle pmk_op allocation failure
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <b0a352781f58a829deadffbe2ef2085c97c6ab32.camel@perches.com>
References: <20240227080613.34001-1-duoming@zju.edu.cn>
 <87166784-79ab-4eb4-ad1e-af4bc31757b7@broadcom.com>
 <b0a352781f58a829deadffbe2ef2085c97c6ab32.camel@perches.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <62bf57d8.2291.18deacf80c6.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBHvTdM591lQACiAQ--.38834W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQEAWXc3dIZAwAAsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gVHVlLCAyNyBGZWIgMjAyNCAwMzo0MjoxMyAtMDgwMCBKb2UgUGVyY2hlcyB3cm90ZToKPiA+
ID4gVGhlIGt6YWxsb2MoKSBpbiBicmNtZl9wbWtzYV92M19vcCgpIHdpbGwgcmV0dXJuIG51bGwg
aWYgdGhlCj4gPiA+IHBoeXNpY2FsIG1lbW9yeSBoYXMgcnVuIG91dC4gQXMgYSByZXN1bHQsIGlm
IHdlIGRlcmVmZXJlbmNlCj4gPiA+IHRoZSBudWxsIHZhbHVlLCB0aGUgbnVsbCBwb2ludGVyIGRl
cmVmZXJlbmNlIGJ1ZyB3aWxsIGhhcHBlbi4KPiA+ID4gCj4gPiA+IFJldHVybiAtRU5PTUVNIGZy
b20gYnJjbWZfcG1rc2FfdjNfb3AoKSBpZiBremFsbG9jKCkgZmFpbHMKPiA+ID4gZm9yIHBta19v
cC4KPiA+IAo+ID4gTkFLIChzZWUgYmVsb3cpCj4gPiAKPiA+IEFsc28gdGhpcyBpc3N1ZSB3YXMg
cmVwb3J0ZWQgZWFybGllciBieSBKb2UgUGVyY2hlcy4gTm90IHN1cmUgaWYgaGUgCj4gPiB3YW50
cyB0byBiZSBtZW50aW9uZWQgYXMgc3VjaC4KPiAKPiBJIHRoaW5rIGl0J3MgdW5pbXBvcnRhbnQg
dG8gYmUgbWVudGlvbmVkLgo+IAo+IEkgdGhpbmsgaXQncyBtb3JlIGltcG9ydGFudCB0aGF0IHRo
ZSBjb2RlIGJlIHJlc2VhcmNoZWQKPiB0aGF0IHRoZSBzaW1wbGUgcmV0dXJuIG9mIC1FTk9NRU0g
dGhlIGFwcHJvcHJpYXRlIGZpeAo+IGFuZCBpcyBoYW5kbGVkIGJ5IGFsbCBwb3NzaWJsZSBjYWxs
ZXJzIG9mIHRoZSBmdW5jdGlvbi4KClRoZXJlIGFyZSB0aHJlZSBmdW5jdGlvbnMgdGhhdCBjYWxs
IHRoZSBicmNtZl9wbWtzYV92M19vcCgpLAppbmNsdWRpbmcgYnJjbWZfY2ZnODAyMTFfc2V0X3Bt
a3NhKCksIGJyY21mX2NmZzgwMjExX2RlbF9wbWtzYSgpCmFuZCBicmNtZl9jZmc4MDIxMV9mbHVz
aF9wbWtzYSgpLiBUaGUgcmV0dXJuIHR5cGUgb2YgdGhlIGFib3ZlCnRocmVlIGZ1bmN0aW9ucyBp
cyBzMzIuIElmIGJyY21mX3Bta3NhX3YzX29wKCkgcmV0dXJucyAtRU5PTUVNLAp0aGUgYWJvdmUg
dGhyZWUgZnVuY3Rpb25zIHdpbGwgYWxzbyByZXR1cm4gLUVOT01FTS4gSXQgY291bGQgYmUKaGFu
ZGxlZCBhcHByb3ByaWF0ZWx5IGJ5IHRoZSBjYWxsZXJzIG9mIHRoZSBmdW5jdGlvbi4gU28gSSB0
aGluawp0aGUgc2ltcGxlIHJldHVybiBvZiAtRU5PTUVNIGlzIGFwcHJvcHJpYXRlLgoKPiA+ID4g
Rml4ZXM6IGE5NjIwMmFjYWVhNCAoIndpZmk6IGJyY21mbWFjOiBjZmc4MDIxMTogQWRkIHN1cHBv
cnQgZm9yIFBNS0lEX1YzIG9wZXJhdGlvbnMiKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5n
IFpob3UgPGR1b21pbmdAemp1LmVkdS5jbj4KPiA+ID4gLS0tCj4gPiA+ICAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmMgfCA1ICsrKysr
Cj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4gPiAKPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1h
Yy9jZmc4MDIxMS5jcSBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9i
cmNtZm1hYy9jZmc4MDIxMS5jCj4gPiA+IGluZGV4IDI4ZDZhMzBjYzAxLi4zYjQyMGIzMzE4OCAx
MDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjEx
L2JyY21mbWFjL2NmZzgwMjExLmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJv
YWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2NmZzgwMjExLmMKPiA+ID4gQEAgLTQzMjIsNiArNDMy
MiwxMCBAQCBicmNtZl9wbWtzYV92M19vcChzdHJ1Y3QgYnJjbWZfaWYgKmlmcCwgc3RydWN0IGNm
ZzgwMjExX3Bta3NhICpwbWtzYSwKPiA+ID4gICAJaW50IHJldDsKPiA+ID4gICAKPiA+ID4gICAJ
cG1rX29wID0ga3phbGxvYyhzaXplb2YoKnBta19vcCksIEdGUF9LRVJORUwpOwo+ID4gPiArCWlm
ICghcG1rX29wKSB7Cj4gPiA+ICsJCXJldCA9IC1FTk9NRU07Cj4gPiA+ICsJCWdvdG8gb3V0Owo+
ID4gPiArCX0KPiA+IAo+ID4gVGhlcmUgaXMgcmVhbGx5IG5vIG5lZWQgdG8gaW50cm9kdWNlIGEg
bmV3IGxhYmVsIGZvciB0aGlzLiBBbHRob3VnaCB5b3UgCj4gPiBjYW4ga2ZyZWUoKSBhIE5VTEwg
cG9pbnRlciB0aGVyZSBpcyBubyBuZWVkIHRvIGRvIHNvIHdoZW4geW91IGtub3cgCj4gPiBhbHJl
YWR5IGl0IGlzIE5VTEwuIEp1c3QgcmV0dXJuIC1FTk9NRU0gYW5kIGJlIGRvbmUgd2l0aCBpdC4K
PiA+IAo+ID4gUmVnYXJkcywKPiA+IEFyZW5kCj4gPiAKPiA+ID4gICAJcG1rX29wLT52ZXJzaW9u
ID0gY3B1X3RvX2xlMTYoQlJDTUZfUE1LU0FfVkVSXzMpOwo+ID4gPiAgIAo+ID4gPiAgIAlpZiAo
IXBta3NhKSB7Cj4gPiA+IEBAIC00MzQwLDYgKzQzNDQsNyBAQCBicmNtZl9wbWtzYV92M19vcChz
dHJ1Y3QgYnJjbWZfaWYgKmlmcCwgc3RydWN0IGNmZzgwMjExX3Bta3NhICpwbWtzYSwKPiA+ID4g
ICAJcG1rX29wLT5sZW5ndGggPSBjcHVfdG9fbGUxNihsZW5ndGgpOwo+ID4gPiAgIAo+ID4gPiAg
IAlyZXQgPSBicmNtZl9maWxfaW92YXJfZGF0YV9zZXQoaWZwLCAicG1raWRfaW5mbyIsIHBta19v
cCwgc2l6ZW9mKCpwbWtfb3ApKTsKPiA+ID4gK291dDoKPiA+ID4gICAJa2ZyZWUocG1rX29wKTsK
PiA+ID4gICAJcmV0dXJuIHJldDsKPiA+ID4gICB9CgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhv
dQo=

