Return-Path: <linux-kernel+bounces-30284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8962831C97
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626C81F25713
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981B528DC9;
	Thu, 18 Jan 2024 15:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="S6hIinqw"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52E28DA0;
	Thu, 18 Jan 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591851; cv=none; b=cWidihGQL2gPAYVc5NlszCYfgy/9PH2sjp0POGbv6SR6hQL5fw6H5dWB8yxrIcgFAqYPborNtkfYK+MzAhucnt3IhzC4SPPg6VSuioO/3cN73O/K/qAX6vLJfB7HicQqLVW2VAr7i3EZeagZhIvzZWEiHQ6Xm1ZVZsWCpUNNdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591851; c=relaxed/simple;
	bh=G6k5QZJJQlG0bYerdGXeKjq4mkXORrlnudd79/X2LTk=;
	h=DKIM-Signature:Received:X-Originating-IP:Date:From:To:Cc:Subject:
	 X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=syJTaEOBFvPtcOT5VRc8DR/CXD4kRP5gW+mLjeS7QSRcbCC14LiIGscFsVp5w1n7TeCxdL22Z5RTbwqnAVusCfaTOO6yP7VPmHLTyopPKH0j6JEx5HGiZHXwMEMWuLnNj2emGaR2tiepTyBv0Y9Y9g6/eDNjM/xB7a5XyybiXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=S6hIinqw reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=k7Js3whNoafE8HpT3cEPOm4zEuKs34CQiNnMBORABp0=; b=S
	6hIinqw23jHFwxAKOAU5qGQHxOREw3W6X30NvNIYKsGmIk18Xwgkm+GHALicqGef
	5GnUPROJ8heXkUMMq9XC9JpIkjELInczRc27M+enynYc6n+bEZ/j8HS+gkwPaS+9
	HRGp9buQHrl55Q3ljuFXpTSirzWb1oNfvgsKlAyr/Q=
Received: from wangkeqi_chris$163.com ( [111.201.26.240] ) by
 ajax-webmail-wmsvr-40-112 (Coremail) ; Thu, 18 Jan 2024 23:14:38 +0800
 (CST)
Date: Thu, 18 Jan 2024 23:14:38 +0800 (CST)
From: wangkeqi  <wangkeqi_chris@163.com>
To: "Florian Westphal" <fw@strlen.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wangkeqi <wangkeqiwang@didiglobal.com>, 
	"kernel test robot" <oliver.sang@intel.com>, fengwei.yin@intel.com
Subject: Re:Re: [PATCH net v2] connector: Change the judgment conditions for
 clearing proc_event_num_listeners
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240117114713.GA11468@breakpoint.cc>
References: <20240116015753.209781-1-wangkeqi_chris@163.com>
 <20240117114713.GA11468@breakpoint.cc>
X-NTES-SC: AL_Qu2bB/mSv0As7iWRZOkXnEoUgeo7WMqyv/km3YVWOJ80oSTg6zo7YmB+JmrtwMeALyS9rweaXBxhwcd4ZrhcW4ElP3INjEFyUfe1Gu3jlwAj
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1adb8c68.a950.18d1d237182.Coremail.wangkeqi_chris@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f7ZeQKll52NNAA--.2272W
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/xtbBzxBo3GV4Ha1t0wAEs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CklmIGNuX25ldGxpbmtfaGFzX2xpc3RlbmVycygpIGlzIHVzZWQgaW5zdGVhZCBvZiBwcm9jX2V2
ZW50X251bV9saXN0ZW5lcnMsIEkgdGhpbmsgcHJvY19ldmVudF9udW1fbGlzdGVuZXJzIHdpbGwg
YmUgY29tcGxldGVseSBtZWFuaW5nbGVzcy7CoApJIHJlYWQgdGhlIGNvZGUgYW5kIGZvdW5kIHRo
YXQgdGhlcmUgaXMgbm90aGluZyB3cm9uZyB3aXRoIGNuX25ldGxpbmtfaGFzX2xpc3RlbmVycyBh
cyBhIGp1ZGdtZW50IG9mIHdoZXRoZXIgdG8gc2VuZCBtc2cuwqAKc29ja19jbG9zZSB3aWxsIHVw
ZGF0ZSB0aGUgbGlzdGVuZXJzLsKgVGhlIHByZXZpb3VzIHByb2NfZXZlbnRfbnVtX2xpc3RlbmVy
cyBjb3VudCB3YXMgd3JvbmcsIG1ha2luZyBpdCBtZWFuaW5nbGVzcy7CoApCdXQgaWYgSSBjaGFu
Z2UgaXQgdG8gY25fbmV0bGlua19oYXNfbGlzdGVuZXJzLCB3aWxsIGl0IGFmZmVjdCBzb21lIGxv
dy1wcm9iYWJpbGl0eSBzY2VuYXJpb3M/CgoKQXQgMjAyNC0wMS0xNyAxOTo0NzoxMywgIkZsb3Jp
YW4gV2VzdHBoYWwiIDxmd0BzdHJsZW4uZGU+IHdyb3RlOgo+d2FuZ2tlcWkgPHdhbmdrZXFpX2No
cmlzQDE2My5jb20+IHdyb3RlOgo+PiBGcm9tOiB3YW5na2VxaSA8d2FuZ2tlcWl3YW5nQGRpZGln
bG9iYWwuY29tPgo+PiAKPj4gSXQgaXMgaW5hY2N1cmF0ZSB0byBqdWRnZSB3aGV0aGVyIHByb2Nf
ZXZlbnRfbnVtX2xpc3RlbmVycyBpcwo+PiBjbGVhcmVkIGJ5IGNuX25ldGxpbmtfc2VuZF9tdWx0
IHJldHVybmluZyAtRVNSQ0guCj4+IEluIHRoZSBjYXNlIG9mIHN0cmVzcy1uZyBuZXRsaW5rLXBy
b2MsIC1FU1JDSCB3aWxsIGFsd2F5cyBiZSByZXR1cm5lZCwKPj4gYmVjYXVzZSBuZXRsaW5rX2Jy
b2FkY2FzdF9maWx0ZXJlZCB3aWxsIHJldHVybiAtRVNSQ0gsCj4+IHdoaWNoIG1heSBjYXVzZSBz
dHJlc3MtbmcgbmV0bGluay1wcm9jIHBlcmZvcm1hbmNlIGRlZ3JhZGF0aW9uLgo+PiBUaGVyZWZv
cmUsIHRoZSBqdWRnbWVudCBjb25kaXRpb24gaXMgbW9kaWZpZWQgdG8gd2hldGhlcgo+PiB0aGVy
ZSBpcyBhIGxpc3RlbmVyLgo+PiAKPj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxv
bGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2UtbGtwLzIwMjQwMTExMjI1OS5iMjNhMTU2Ny1vbGl2ZXIuc2FuZ0BpbnRlbC5jb20KPj4gRml4
ZXM6IGM0NmJmYmExMzMgKCJjb25uZWN0b3I6IEZpeCBwcm9jX2V2ZW50X251bV9saXN0ZW5lcnMg
Y291bnQgbm90IGNsZWFyZWQiKQo+PiBTaWduZWQtb2ZmLWJ5OiB3YW5na2VxaSA8d2FuZ2tlcWl3
YW5nQGRpZGlnbG9iYWwuY29tPgo+PiBDYzogZmVuZ3dlaS55aW5AaW50ZWwuY29tCj4+IC0tLQo+
PiAgZHJpdmVycy9jb25uZWN0b3IvY25fcHJvYy5jICAgfCA2ICsrKystLQo+PiAgZHJpdmVycy9j
b25uZWN0b3IvY29ubmVjdG9yLmMgfCA2ICsrKysrKwo+PiAgaW5jbHVkZS9saW51eC9jb25uZWN0
b3IuaCAgICAgfCAxICsKPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nvbm5lY3Rvci9jbl9wcm9j
LmMgYi9kcml2ZXJzL2Nvbm5lY3Rvci9jbl9wcm9jLmMKPj4gaW5kZXggM2Q1ZTZkNzA1Li5iMDlm
NzRlZDMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvY29ubmVjdG9yL2NuX3Byb2MuYwo+PiArKysg
Yi9kcml2ZXJzL2Nvbm5lY3Rvci9jbl9wcm9jLmMKPj4gQEAgLTEwOCw4ICsxMDgsMTAgQEAgc3Rh
dGljIGlubGluZSB2b2lkIHNlbmRfbXNnKHN0cnVjdCBjbl9tc2cgKm1zZykKPj4gIAkJZmlsdGVy
X2RhdGFbMV0gPSAwOwo+PiAgCX0KPj4gIAo+PiAtCWlmIChjbl9uZXRsaW5rX3NlbmRfbXVsdCht
c2csIG1zZy0+bGVuLCAwLCBDTl9JRFhfUFJPQywgR0ZQX05PV0FJVCwKPj4gLQkJCSAgICAgY25f
ZmlsdGVyLCAodm9pZCAqKWZpbHRlcl9kYXRhKSA9PSAtRVNSQ0gpCj4+ICsJaWYgKG5ldGxpbmtf
aGFzX2xpc3RlbmVycyhnZXRfY2Rldl9ubHMoKSwgQ05fSURYX1BST0MpKQo+PiArCQljbl9uZXRs
aW5rX3NlbmRfbXVsdChtc2csIG1zZy0+bGVuLCAwLCBDTl9JRFhfUFJPQywgR0ZQX05PV0FJVCwK
Pj4gKwkJCSAgICAgY25fZmlsdGVyLCAodm9pZCAqKWZpbHRlcl9kYXRhKTsKPj4gKwllbHNlCj4+
ICAJCWF0b21pY19zZXQoJnByb2NfZXZlbnRfbnVtX2xpc3RlbmVycywgMCk7Cj4KPkhvdyBpcyB0
aGF0IHNlcmlhbGl6ZWQgdnMuIGNuX3Byb2NfbWNhc3RfY3RsPwo+Cj4xLiBuZXRsaW5rX2hhc19s
aXN0ZW5lcnMoKSByZXR1cm5zIGZhbHNlCj4yLiAgb3RoZXIgY29yZSBoYW5kbGVzIFBST0NfQ05f
TUNBU1RfTElTVEVOLCBhdG9taWNfaW5jIGNhbGxlZAo+My4gVGhpcyBjb3JlIChyZSlzZXRzIGNv
dW50ZXIgdG8gMCwgYnV0IHRoZXJlIGFyZSBsaXN0ZW5lcnMsIHNvCj4gICAgYWxsIGZ1bmN0aW9u
cyB0aGF0IGRvCj4KPiBpZiAoYXRvbWljX3JlYWQoJnByb2NfZXZlbnRfbnVtX2xpc3RlbmVycykg
PCAxKQo+ICAgIHJldHVybjsKPgo+d2lsbCBub3QgZ2V0IGVuYWJsZWQvcmVtYWluIGRpc2FibGVk
Lgo+Cj5Qcm9iYWJseSBiZXR0ZXIgdG8gYWRkIGNuX25ldGxpbmtfaGFzX2xpc3RlbmVycygpIGZ1
bmN0aW9uCj5hbmQgdXNlIHRoYXQgaW5zdGVhZCBvZiB0aGUgKGluYWNjdXJhdGUpIGNvdW50ZXI/
Cg==

