Return-Path: <linux-kernel+bounces-48674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC7845FA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E989228AC55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37825127B59;
	Thu,  1 Feb 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLSlsr4o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA60127B48;
	Thu,  1 Feb 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811117; cv=none; b=kIfaNAiiuqSrcmKCoTXD+pwJfvLR95AspR8PdVpXxGPSsSgJOibjERrahaM7dVgjTtTtgTdrF8MhMBmdVTjaOdFQtORGpgW1MAQs0jy4FoWc4mC+vWe0HNh22+13Bz8e+6l+I0aqLRqsN6WD9eI9juxl2ssG1ptWeyd7el4LqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811117; c=relaxed/simple;
	bh=86vTRfPucmb5AYxZwhb9dFpu1vfbO62Ulmjm8wLUwNc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsSvT4OzpiPI0QHg9n4Lc1dUZ0Gcec3lhPm72fAVePAPoZfZhH37Y7H1/ITXyKSTCxdv/K3tiPAreYFZMFgeWsoFrT50+kkr0IG4qlGGyZzgIJ/kTkJIfzWf6dq0uX0xL7+QQ5UJV5gsJ5z6XSZ/fHnSEWqV4+pXYQ7+7KT78ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLSlsr4o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706811116; x=1738347116;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=86vTRfPucmb5AYxZwhb9dFpu1vfbO62Ulmjm8wLUwNc=;
  b=TLSlsr4omsO4YapeGczyqpdnDwqMIJA6KVfbcobXYnMgmZjUOcbL8HGX
   Y0yvwv75hnza4eDs6OKIDeP16+slHUO0tjafaTZ9zZjyWs4MMv0b9m5OK
   LWomMK38vRXb9vJUkldD5T1rr1YJhSmYqjG9W26Her9nzaRCizLmrKw1T
   BTxSrXahTj9OjW+tysDD0MGk78fK1roaFJvl9uCy7h7fqZMLPbmrfoxMS
   xnZx3mIi15EfqhFO37vA4ea1t/726TxZeRcr2tpBHxcEudNVXi5sBI04y
   6EIAdTqFJzb4JL++pT0GPRQbZcs7ejqjRLuZMZOmLo3dnjZWB7+TSQSDf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="2894281"
X-IronPort-AV: E=Sophos;i="6.05,235,1701158400"; 
   d="scan'208";a="2894281"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 10:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,235,1701158400"; 
   d="scan'208";a="4482906"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 10:11:54 -0800
Received: from ssigler-mobl.amr.corp.intel.com (unknown [10.209.41.165])
	by linux.intel.com (Postfix) with ESMTP id 5C0BA580DD4;
	Thu,  1 Feb 2024 10:11:54 -0800 (PST)
Message-ID: <47df451d2494243d73e9065202e50e022ae2792b.camel@linux.intel.com>
Subject: Re: [PATCH 2/8] platform/x86/intel/sdsi: Combine read and write
 mailbox flows
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
  netdev@vger.kernel.org, ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date: Thu, 01 Feb 2024 10:11:54 -0800
In-Reply-To: <6ee06c50-3782-4d50-9a01-f332d181d3fc@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
	 <20240201010747.471141-3-david.e.box@linux.intel.com>
	 <6ee06c50-3782-4d50-9a01-f332d181d3fc@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2F0aHlhLAoKT24gVGh1LCAyMDI0LTAyLTAxIGF0IDA5OjMxIC0wODAwLCBLdXBwdXN3YW15
IFNhdGh5YW5hcmF5YW5hbiB3cm90ZToKPiAKPiBPbiAxLzMxLzI0IDU6MDcgUE0sIERhdmlkIEUu
IEJveCB3cm90ZToKPiA+IFRoZSBjdXJyZW50IG1haWxib3ggY29tbWFuZHMgYXJlIGVpdGhlciBy
ZWFkLW9ubHkgb3Igd3JpdGUtb25seSBhbmQgdGhlCj4gPiBmbG93IGlzIGRpZmZlcmVudCBmb3Ig
ZWFjaC4gTmV3IGNvbW1hbmRzIHdpbGwgbmVlZCB0byBzZW5kIGFuZCByZWNlaXZlCj4gPiBkYXRh
LiBJbiBwcmVwYXJhdGlvbiBmb3IgdGhlc2UgY29tbWFuZHMsIGNyZWF0ZSBhIGNvbW1vbiBwb2xs
aW5nIGZ1bmN0aW9uCj4gPiB0byBoYW5kbGUgc2VuZGluZyBkYXRhIGFuZCByZWNlaXZpbmcgaW4g
dGhlIHNhbWUgdHJhbnNhY3Rpb24uCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEUuIEJv
eCA8ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPgo+ID4gLS0tCj4gPiDCoGRyaXZlcnMvcGxh
dGZvcm0veDg2L2ludGVsL3Nkc2kuYyB8IDc5ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygt
KQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvc2RzaS5j
Cj4gPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Nkc2kuYwo+ID4gaW5kZXggYTcwYzA3
MWRlNmUyLi4wNWEzNWYyZjg1YjYgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4
Ni9pbnRlbC9zZHNpLmMKPiA+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3Nkc2ku
Ywo+ID4gQEAgLTE1LDYgKzE1LDcgQEAKPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPgo+
ID4gwqAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvb3ZlcmZsb3cuaD4KPiA+IMKgI2luY2x1ZGUgPGxp
bnV4L3BjaS5oPgo+ID4gwqAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgo+ID4gwqAjaW5jbHVkZSA8
bGludXgvc3lzZnMuaD4KPiA+IEBAIC0xNTYsOCArMTU3LDggQEAgc3RhdGljIGludCBzZHNpX3N0
YXR1c190b19lcnJubyh1MzIgc3RhdHVzKQo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgfQo+
ID4gwqAKPiA+IC1zdGF0aWMgaW50IHNkc2lfbWJveF9jbWRfcmVhZChzdHJ1Y3Qgc2RzaV9wcml2
ICpwcml2LCBzdHJ1Y3Qgc2RzaV9tYm94X2luZm8KPiA+ICppbmZvLAo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCAqZGF0
YV9zaXplKQo+ID4gK3N0YXRpYyBpbnQgc2RzaV9tYm94X3BvbGwoc3RydWN0IHNkc2lfcHJpdiAq
cHJpdiwgc3RydWN0IHNkc2lfbWJveF9pbmZvCj4gPiAqaW5mbywKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZV90ICpkYXRhX3NpemUpCj4g
PiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwcml2LT5kZXY7
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdTMyIHRvdGFsLCBsb29wLCBlb20sIHN0YXR1cywgbWVzc2Fn
ZV9zaXplOwo+ID4gQEAgLTE2NiwxOCArMTY3LDEwIEBAIHN0YXRpYyBpbnQgc2RzaV9tYm94X2Nt
ZF9yZWFkKHN0cnVjdCBzZHNpX3ByaXYgKnByaXYsCj4gPiBzdHJ1Y3Qgc2RzaV9tYm94X2luZm8g
KmluZgo+ID4gwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqBsb2NrZGVwX2Fzc2VydF9oZWxkKCZwcml2
LT5tYl9sb2NrKTsKPiA+IMKgCj4gPiAtwqDCoMKgwqDCoMKgwqAvKiBGb3JtYXQgYW5kIHNlbmQg
dGhlIHJlYWQgY29tbWFuZCAqLwo+ID4gLcKgwqDCoMKgwqDCoMKgY29udHJvbCA9IEZJRUxEX1BS
RVAoQ1RSTF9FT00sIDEpIHwKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBG
SUVMRF9QUkVQKENUUkxfU09NLCAxKSB8Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgRklFTERfUFJFUChDVFJMX1JVTl9CVVNZLCAxKSB8Cj4gPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgRklFTERfUFJFUChDVFJMX1BBQ0tFVF9TSVpFLCBpbmZvLT5zaXpl
KTsKPiA+IC3CoMKgwqDCoMKgwqDCoHdyaXRlcShjb250cm9sLCBwcml2LT5jb250cm9sX2FkZHIp
Owo+ID4gLQo+ID4gwqDCoMKgwqDCoMKgwqDCoC8qIEZvciByZWFkcywgZGF0YSBzaXplcyB0aGF0
IGFyZSBsYXJnZXIgdGhhbiB0aGUgbWFpbGJveCBzaXplIGFyZQo+ID4gcmVhZCBpbiBwYWNrZXRz
LiAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoHRvdGFsID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBs
b29wID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqBkbyB7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgdm9pZCAqYnVmID0gaW5mby0+YnVmZmVyICsgKFNEU0lfU0laRV9NQUlMQk9Y
ICogbG9vcCk7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBwYWNrZXRf
c2l6ZTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFBvbGwg
b24gcmVhZHkgYml0ICovCj4gPiBAQCAtMTk1LDYgKzE4OCwxMSBAQCBzdGF0aWMgaW50IHNkc2lf
bWJveF9jbWRfcmVhZChzdHJ1Y3Qgc2RzaV9wcml2ICpwcml2LAo+ID4gc3RydWN0IHNkc2lfbWJv
eF9pbmZvICppbmYKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFr
Owo+ID4gwqAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBhY2tldF9z
aXplKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHNkc2lfY29tcGxldGVfdHJhbnNhY3Rpb24ocHJpdik7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoH0KPiA+ICsKPiAKPiBJdCBzZWVtcyB0byBiZSBhIGdlbmVyaWMgY2hlY2su
IElzIHRoaXMgcmVsYXRlZCB0byBjb252ZXJ0aW5nIHRvIGEgcmVhZC93cml0ZQo+IGZ1bmN0aW9u
IG9yCj4gYSBjb21tb24gZml4IHlvdSBhZGRlZCB0b2dldGhlciBpbiB0aGlzIHBhdGNoLgoKWWVz
LCBpdCdzIHJlbGF0ZWQuIFRoZSBjb2RlIHRoYXQgZm9sbG93cyB0aGlzIG9ubHkgYXBwbGllcyB0
byByZWFkcy4gVGhpcyBjaGVjawp3b3VsZCBiZSB0cnVlIG9ubHkgZm9yIHdyaXRlcyB3aGljaCBv
bmx5IG5lZWQgdG8gcG9sbCBvbmNlIHRvIGNvbmZpcm0gdGhlIHdyaXRlCndhcyBzdWNjZXNzZnVs
LiBJJ2xsIGFkZCBhIGNvbW1lbnQgdG8gbWFrZSBpdCBjbGVhci4K


