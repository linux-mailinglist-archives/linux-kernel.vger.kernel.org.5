Return-Path: <linux-kernel+bounces-105652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA59587E216
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9851F21EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37041E51F;
	Mon, 18 Mar 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sug61auT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276D1DFF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710728304; cv=none; b=MBG9MHdE8Gnl8y9rsqzvR/YYsyKSn+UfvY2SMKVdq1rD7iOqI3PggULrFZwJExayJkOVKWyqPjUVZtpgnkDMhgddlbqyOd5Mb+OGaTu+BE43nJOtxgjabPMZKvF328W1E3CSkCppt70xwbme/OgBXDEZNOq7YbmjKUEoZ0xtzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710728304; c=relaxed/simple;
	bh=gGLEoKWJmT1+xBK5u49KBD81j53Kl4NWlAVyvIPKFTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpKInOIAPSEEAXTkLNbsYYm9wGNfhU8KaNpqOA3I6coMlom2SbeMhl5hwuqHJbMB7/KzVjjLn22AmUcyJGJbKofVTob0JLx9gO0EgZVAEZlVgoEMnymP7sjlLQ0xSkRKPVPj0tZQy+tMx9kJumHzUfpJf09mqARQGd/abKP+smw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sug61auT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710728301; x=1742264301;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=gGLEoKWJmT1+xBK5u49KBD81j53Kl4NWlAVyvIPKFTs=;
  b=Sug61auTHXlCDN6NQwncbZ4TSMRCzMrTnaINiHPnx4wIhf0sXX0g07lh
   tU45CmMigIhs++O+XpEScI6yo+tmmzYpNNzuDWIlVneTCkRBXlT0d/XFx
   Xh/wp506QmqOgVFOjhKD4O1LJmV5kuf8d1PlujgkDnURbGv5kvIRkNuke
   LOAFgnZ05ZzKQRQS2/A7vdZb8elQQECg+qGikiWPtAhAIVxAmDSEbf7LE
   AP68uKZsleVk25zCKqHN7KFOXVIQJjonNByL5oEBuWP2LF3+BgetQZyXA
   DC9W5vuDq/aBmszR7RhIwQm+kkcVJoAlkOUak/ZDlyDSCGtZJ8GwSWG5s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="16245601"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="16245601"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 19:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13285397"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 19:18:05 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>,  Yin Fengwei <fengwei.yin@intel.com>,
  Andrew Morton <akpm@linux-foundation.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  Gao Xiang <xiang@kernel.org>,  Yu Zhao
 <yuzhao@google.com>,  Yang Shi <shy828301@gmail.com>,  Michal Hocko
 <mhocko@suse.com>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Barry Song
 <21cnbao@gmail.com>,  Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v4 5/6] mm: vmscan: Avoid split during shrink_folio_list()
In-Reply-To: <5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com> (Ryan Roberts's
	message of "Fri, 15 Mar 2024 11:38:37 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-6-ryan.roberts@arm.com>
	<d8086108-05e7-4765-a6f5-dfb85fb44b90@redhat.com>
	<1db242d3-5ff1-4ef5-b20a-578a317fa859@arm.com>
	<caafeabd-fb94-45de-9dcc-2451ddc0ef50@redhat.com>
	<5cc147fa-492e-46c3-963d-2f6e6680dce9@arm.com>
Date: Mon, 18 Mar 2024 10:16:11 +0800
Message-ID: <878r2gwahg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

UnlhbiBSb2JlcnRzIDxyeWFuLnJvYmVydHNAYXJtLmNvbT4gd3JpdGVzOg0KDQo+IEhpIFlpbiBG
ZW5nd2VpLA0KPg0KPiBPbiAxNS8wMy8yMDI0IDExOjEyLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4+IE9uIDE1LjAzLjI0IDExOjQ5LCBSeWFuIFJvYmVydHMgd3JvdGU6DQo+Pj4gT24gMTUv
MDMvMjAyNCAxMDo0MywgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4+IE9uIDExLjAzLjI0
IDE2OjAwLCBSeWFuIFJvYmVydHMgd3JvdGU6DQo+Pj4+PiBOb3cgdGhhdCBzd2FwIHN1cHBvcnRz
IHN0b3JpbmcgYWxsIG1USFAgc2l6ZXMsIGF2b2lkIHNwbGl0dGluZyBsYXJnZQ0KPj4+Pj4gZm9s
aW9zIGJlZm9yZSBzd2FwLW91dC4gVGhpcyBiZW5lZml0cyBwZXJmb3JtYW5jZSBvZiB0aGUgc3dh
cC1vdXQgcGF0aA0KPj4+Pj4gYnkgZWxpZGluZyBzcGxpdF9mb2xpb190b19saXN0KCksIHdoaWNo
IGlzIGV4cGVuc2l2ZSwgYW5kIGFsc28gc2V0cyB1cw0KPj4+Pj4gdXAgZm9yIHN3YXBwaW5nIGlu
IGxhcmdlIGZvbGlvcyBpbiBhIGZ1dHVyZSBzZXJpZXMuDQo+Pj4+Pg0KPj4+Pj4gSWYgdGhlIGZv
bGlvIGlzIHBhcnRpYWxseSBtYXBwZWQsIHdlIGNvbnRpbnVlIHRvIHNwbGl0IGl0IHNpbmNlIHdl
IHdhbnQNCj4+Pj4+IHRvIGF2b2lkIHRoZSBleHRyYSBJTyBvdmVyaGVhZCBhbmQgc3RvcmFnZSBv
ZiB3cml0aW5nIG91dCBwYWdlcw0KPj4+Pj4gdW5lY2Nlc3NhcmlseS4NCj4+Pj4+DQo+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBSeWFuIFJvYmVydHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPg0KPj4+Pj4g
LS0tDQo+Pj4+PiDCoMKgIG1tL3Ztc2Nhbi5jIHwgOSArKysrKy0tLS0NCj4+Pj4+IMKgwqAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+
PiBkaWZmIC0tZ2l0IGEvbW0vdm1zY2FuLmMgYi9tbS92bXNjYW4uYw0KPj4+Pj4gaW5kZXggY2Y3
ZDRjZjQ3ZjFhLi4wZWJlYzk5ZTA0YzYgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9tbS92bXNjYW4uYw0K
Pj4+Pj4gKysrIGIvbW0vdm1zY2FuLmMNCj4+Pj4+IEBAIC0xMjIyLDExICsxMjIyLDEyIEBAIHN0
YXRpYyB1bnNpZ25lZCBpbnQgc2hyaW5rX2ZvbGlvX2xpc3Qoc3RydWN0IGxpc3RfaGVhZA0KPj4+
Pj4gKmZvbGlvX2xpc3QsDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIWNhbl9zcGxpdF9mb2xpbyhmb2xpbywgTlVMTCkpDQo+Pj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gYWN0
aXZhdGVfbG9ja2VkOw0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgLyoNCj4+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogU3BsaXQgZm9saW9zIHdpdGhvdXQgYSBQTUQgbWFwIHJpZ2h0DQo+Pj4+PiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGF3YXkuIENoYW5jZXMgYXJlIHNv
bWUgb3IgYWxsIG9mIHRoZQ0KPj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKiB0YWlsIHBhZ2VzIGNhbiBiZSBmcmVlZCB3aXRob3V0IElPLg0KPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBTcGxpdCBwYXJ0aWFsbHkg
bWFwcGVkIGZvbGlvcyBtYXANCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogcmlnaHQgYXdheS4gQ2hhbmNlcyBhcmUgc29tZSBvciBhbGwNCj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogb2YgdGhlIHRhaWwgcGFn
ZXMgY2FuIGJlIGZyZWVkDQo+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAqIHdpdGhvdXQgSU8uDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICovDQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCFmb2xpb19lbnRpcmVfbWFwY291bnQoZm9saW8pICYmDQo+Pj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFsaXN0X2VtcHR5KCZm
b2xpby0+X2RlZmVycmVkX2xpc3QpICYmDQo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwbGl0X2ZvbGlvX3RvX2xpc3QoZm9saW8sDQo+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb2xpb19saXN0KSkNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBhY3RpdmF0ZV9sb2NrZWQ7DQo+
Pj4+DQo+Pj4+IE5vdCBzdXJlIGlmIHdlIG1pZ2h0IGhhdmUgdG8gYW5ub3RhdGUgdGhhdCB3aXRo
IGRhdGFfcmFjZSgpLg0KPj4+DQo+Pj4gSSBhc2tlZCB0aGF0IGV4YWN0IHF1ZXN0aW9uIHRvIE1h
dHRoZXcgaW4gYW5vdGhlciBjb250ZXh0IGJ0IGRpZG4ndCBnZXQgYQ0KPj4+IHJlc3BvbnNlLiBU
aGVyZSBhcmUgZXhhbXBsZXMgb2YgY2hlY2tpbmcgaWYgdGhlIGRlZmVycmVkIGxpc3QgaXMgZW1w
dHkgd2l0aCBhbmQNCj4+PiB3aXRob3V0IGRhdGFfcmFjZSgpIGluIHRoZSBjb2RlIGJhc2UuIEJ1
dCBsaXN0X2VtcHR5KCkgaXMgaW1wbGVtZW50ZWQgbGlrZSB0aGlzOg0KPj4+DQo+Pj4gc3RhdGlj
IGlubGluZSBpbnQgbGlzdF9lbXB0eShjb25zdCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFkKQ0KPj4+
IHsNCj4+PiDCoMKgwqDCoHJldHVybiBSRUFEX09OQ0UoaGVhZC0+bmV4dCkgPT0gaGVhZDsNCj4+
PiB9DQo+Pj4NCj4+PiBTbyBJIGFzc3VtZWQgdGhlIFJFQURfT05DRSgpIG1ha2VzIGV2ZXJ5dGhp
bmcgc2FmZSB3aXRob3V0IGEgbG9jaz8gUGVyaGFwcyBub3QNCj4+PiBzdWZmaWNpZW50IGZvciBL
Q1NBTj8NCj4+IA0KPj4gWWVhaCwgdGhlcmUgaXMgb25seSBvbmUgdXNlIG9mIGRhdGFfcmFjZSB3
aXRoIHRoYXQgbGlzdC4NCj4+IA0KPj4gSXQgd2FzIGFkZGVkIGluIGYzZWJkZjA0MmRmNCAoIlRI
UDogYXZvaWQgbG9jayB3aGVuIGNoZWNrIHdoZXRoZXIgVEhQIGlzIGluDQo+PiBkZWZlcnJlZCBs
aXN0IikuDQo+PiANCj4+IExvb2tzIGxpa2UgdGhhdCB3YXMgYWRkZWQgcmlnaHQgaW4gdjEgb2Yg
dGhhdCBjaGFuZ2UgWzFdLCBzbyBteSBiZXN0IGd1ZXNzIGlzDQo+PiB0aGF0IGl0IGlzIG5vdCBh
Y3R1YWxseSByZXF1aXJlZC4NCj4+IA0KPj4gSWYgbm90IHJlcXVpcmVkLCBsaWtlbHkgd2Ugc2hv
dWxkIGp1c3QgY2xlYW51cCB0aGUgc2luZ2xlIHVzZXIuDQo+PiANCj4+IFsxXQ0KPj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMzA0MTcwNzU2NDMuMzI4NzUxMy0yLWZlbmd3
ZWkueWluQGludGVsLmNvbS8NCj4NCj4gRG8geW91IGhhdmUgYW55IHJlY29sbGVjdGlvbiBvZiB3
aHkgeW91IGFkZGVkIHRoZSBkYXRhX3JhY2UoKSBtYXJrdXA/DQoNClBlciBteSB1bmRlcnN0YW5k
aW5nLCB0aGlzIGlzIHVzZWQgdG8gbWFyayB0aGF0IHRoZSBjb2RlIGFjY2Vzc2VzDQpmb2xpby0+
X2RlZmVycmVkX2xpc3Qgd2l0aG91dCBsb2NrIGludGVudGlvbmFsbHksIHdoaWxlDQpmb2xpby0+
X2RlZmVycmVkX2xpc3QgbWF5IGJlIGNoYW5nZWQgaW4gcGFyYWxsZWwuICBJSVVDLCB0aGlzIGlz
IHdoYXQNCmRhdGFfcmFjZSgpIGlzIHVzZWQgZm9yLiAgT3IsIG15IHVuZGVyc3RhbmRpbmcgaXMg
d3Jvbmc/DQoNCi0tDQpCZXN0IFJlZ2FyZHMsDQpIdWFuZywgWWluZw0K

