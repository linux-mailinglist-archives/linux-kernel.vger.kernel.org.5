Return-Path: <linux-kernel+bounces-49463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CABE846AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F0F291428
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054B3FE27;
	Fri,  2 Feb 2024 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEssap0W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758C3FE3D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862121; cv=none; b=Lo3q+jodIsPjYeEOwiuXBzSjTe+yLXl0QzAD31gtNopjWNhtVrn+JfGDTxfbwM98KRj70A/EgD2oM0D8cNE+a308xB2z+GyudVgT4X52V6I476gbJIONgMlMDeN7r9D7bCOzWgN67cDI5/TMlT4qRbu1jq54MlQRdDtfbrW+bI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862121; c=relaxed/simple;
	bh=1yDUxSMBYmvMsKlPVD4etaFTkjVGrtKI7MMoR6XPmgw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eZD1FFWB3lOs7441VkdxIbWMzaB7Z6USCkJ0lgwWKNwTRbZH09dPmau97+c2OV4BW+C3Fb/YXfDzjYaZDeMcXjqLMHJFa56snvYbrcrMPwIheKUD7HAT8xOKHUXje4GTfMPR3ud9kjhWJ5oaiQy+l6yWRcrJeK4cFhJxg6Adf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEssap0W; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706862120; x=1738398120;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=1yDUxSMBYmvMsKlPVD4etaFTkjVGrtKI7MMoR6XPmgw=;
  b=GEssap0WOAAmMyYwCrwmJ16MLEDukzRWWxg5pTOXUhCTY3wxTNpkDfFI
   E1HY9KzXVpCAOX4c900xp2pTlU9JsrfEVbxQqc7XJK4EypGlDX7fABpAW
   kJeEAcNe9xXJ7XVAoyeMpxyt/QD/HHYF9wfjuLFlTUsxr/WsJroMCPadG
   5qGqMr6yi900JqZPs2GijoyDHiKY0xJbSsshqfsOmkJ6QGpW85hgb3Lz6
   liFeJQRBCtjueoBF+8Nqhk14k7/J3dUUOJ0QwqbtHABvlOOYqhYfpiQuF
   bZ7UchdJ7YJpm1fBiEz5YZmgpROCKRtoC1oEfq0VblMFYQkq9Km5aRPgf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="25558906"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="25558906"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="295397"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 00:21:53 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "rafael@kernel.org" <rafael@kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH RFC 1/4] drivers/base/node: Add demotion_nodes sys
 infterface
In-Reply-To: <797f9b10-5626-4511-af6f-6b90cd5c884c@fujitsu.com> (Zhijian Li's
	message of "Fri, 2 Feb 2024 07:43:11 +0000")
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
	<20231102025648.1285477-2-lizhijian@fujitsu.com>
	<878r7g3ktj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d1d5add8-8f4a-4578-8bf0-2cbe79b09989@fujitsu.com>
	<87fryegv9c.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<cc125e55-890e-4de8-876a-30d88e8438b0@fujitsu.com>
	<797f9b10-5626-4511-af6f-6b90cd5c884c@fujitsu.com>
Date: Fri, 02 Feb 2024 16:19:56 +0800
Message-ID: <87sf2bb7mb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

IlpoaWppYW4gTGkgKEZ1aml0c3UpIiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cml0ZXM6DQoN
Cj4gT24gMzEvMDEvMjAyNCAxMToxNywgTGkgWmhpamlhbiB3cm90ZToNCj4+Pj4gbm9kZVswXS5w
cmVmZXJyZWTCoD3CoDINCj4+Pj4gbm9kZVswXS5kZW1vdGlvbl90YXJnZXRzwqA9wqAyLTUNCj4+
Pj4gbm9kZVsxXS5wcmVmZXJyZWTCoD3CoDUNCj4+Pj4gbm9kZVsxXS5kZW1vdGlvbl90YXJnZXRz
wqA9wqAyLTUNCj4+Pj4gbm9kZVsyXS5wcmVmZXJyZWTCoD3CoDQNCj4+Pj4gbm9kZVsyXS5kZW1v
dGlvbl90YXJnZXRzwqA9wqAzLTQNCj4+Pj4gbm9kZVszXS5wcmVmZXJyZWTCoD3CoDxlbXB0eT4N
Cj4+Pj4gbm9kZVszXS5kZW1vdGlvbl90YXJnZXRzwqA9wqA8ZW1wdHk+DQo+Pj4+IG5vZGVbNF0u
cHJlZmVycmVkwqA9wqA8ZW1wdHk+DQo+Pj4+IG5vZGVbNF0uZGVtb3Rpb25fdGFyZ2V0c8KgPcKg
PGVtcHR5Pg0KPj4+PiBub2RlWzVdLnByZWZlcnJlZMKgPcKgMw0KPj4+PiBub2RlWzVdLmRlbW90
aW9uX3RhcmdldHPCoD3CoDMtNA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgQnV0DQo+Pj4+IHRoaXPCoGRlbW90aW9uwqBwYXRowqBpc8Kgbm90wqBleHBsaWNpdGx5wqBr
bm93bsKgdG/CoGFkbWluaXN0cmF0b3IuwqBBbmTCoHdpdGgNCj4+Pj4gdGhlDQo+Pj4+IGZlZWRi
YWNrwqBmcm9twqBvdXLCoGN1c3RvbWVycyzCoHRoZXnCoGFsc2/CoHRoaW5rwqBpdMKgaXPCoGhl
bHBmdWzCoHRvwqBrbm93wqBkZW1vdGlvbg0KPj4+PiBwYXRowqBidWlsdMKgYnnCoGtlcm5lbMKg
dG/CoHVuZGVyc3RhbmTCoHRoZcKgZGVtb3Rpb27CoGJlaGF2aW9ycy4NCj4+Pj4NCj4+Pj4gU2/C
oGnCoHRoaW5rwqB3ZcKgc2hvdWxkwqBoYXZlwqAywqBuZXfCoGludGVyZmFjZXPCoGZvcsKgZWFj
aMKgbm9kZToNCj4+Pj4NCj4NCj4+Pj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGVOL2Rl
bW90aW9uX2FsbG93ZWRfbm9kZXMNCj4+Pj4gL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGVO
L2RlbW90aW9uX3ByZWZlcnJlZF9ub2Rlcw0KPj4+Pg0KPj4+PiBJwqB2YWx1ZcKgeW91csKgb3Bp
bmlvbizCoGFuZMKgSSdkwqBsaWtlwqB0b8Kga25vd8Kgd2hhdMKgeW91wqB0aGlua8KgYWJvdXQu
Li4NCj4+Pg0KPj4+IFBlcsKgbXnCoHVuZGVyc3RhbmRpbmcswqB3ZcKgd2lsbMKgbm90wqBleHBv
c2XCoGV2ZXJ5dGhpbmfCoGluc2lkZcKga2VybmVswqB0bw0KPj4+IHVzZXLCoHNwYWNlLsKgwqBG
b3LCoHBhZ2XCoHBsYWNlbWVudMKgaW7CoGHCoHRpZXJlZMKgbWVtb3J5wqBzeXN0ZW0swqBkZW1v
dGlvbsKgaXMNCj4+PiBqdXN0wqBhwqBwYXJ0wqBvZsKgdGhlwqBzdG9yeS7CoMKgRm9ywqBleGFt
cGxlLMKgaWbCoHRoZcKgRFJBTcKgb2bCoGHCoHN5c3RlbcKgYmVjb21lcw0KPj4+IGZ1bGwswqBu
ZXfCoHBhZ2XCoGFsbG9jYXRpb27CoHdpbGzCoGZhbGzCoGJhY2vCoHRvwqB0aGXCoENYTMKgbWVt
b3J5LsKgwqBIYXZlwqB3ZQ0KPj4+IGV4cG9zZWTCoHRoZcKgZGVmYXVsdMKgcGFnZcKgYWxsb2Nh
dGlvbsKgZmFsbGJhY2vCoG9yZGVywqB0b8KgdXNlcsKgc3BhY2U/DQo+DQo+DQo+IEJhY2sgdG8g
b3VyIGluaXRpYWwgcmVxdWlyZW1lbnQ6DQo+IFdoZW4gZGVtb3Rpb24gaXMgZW5hYmxlZCwgd2hh
dCdzIHRoZSBkZW1vdGlvbiBwYXRoLCBlc3BlY2lhbGx5IHRoZSBwcmVmZXJyZWQgbm9kZT8NCj4g
YXJlIHRoZXkgY29uc2lzdGVudCB3aXRoIGFkbWluaXN0cmF0b3IncyBleHBlY3RhdGlvbnM/Ig0K
Pg0KPiBJdCBzZWVtcyB0aGVyZSBpcyBubyBhIGRpcmVjdCBhbnN3ZXIuIEJ1dCBhY3R1YWxseSwg
a2VybmVsIGhhdmUgYWxyZWFkeSBrbm93bg0KPiB0aGlzIGluZm9ybWF0aW9uLCBJTUhPLCBleHBv
c2luZyB0aGVtIHRvIHVzZXJzIGlzIG5vdCBhIGJhZCBjaG9pY2UuDQo+DQo+IFRoaXMgaW5mb3Jt
YXRpb24gaXMgYWJsZSB0byBoZWxwIHRoZW0gYWRqdXN0L3R1bmUgdGhlIG1hY2hpbmUgYmVmb3Jl
IHJlYWxseQ0KPiBkZXBsb3kgdGhlaXIgd29ya2xvYWRzLg0KPg0KPiBJZiB0aGUgc3lzZnMgYXBw
cm9hY2ggaXNuJ3QgYmV0dGVyIGVub3VnaCwgaXMgaXQgcG9zc2libGUgdG8gaGF2ZSBhbm90aGVy
IG1vcmUNCj4gdXNlci1mcmllbmRseSB3YXkgdG8gY29udmV5IHRoaXMgaW5mb3JtYXRpb24/IGxp
a2UgdGhlIGFsbG9jYXRpb24gZmFsbGJhY2sgb3JkZXIgZG9lcywNCj4gc2ltcGx5IHByaW50IHRo
ZW0gdG8gZG1lc2c/DQoNCkkgaGF2ZSBubyBvYmplY3QgdG8gcHJpbnQgc29tZSBkZW1vdGlvbiBp
bmZvcm1hdGlvbiBpbiBkbWVzZy4NCg0KLS0NCkJlc3QgUmVnYXJkcywNCkh1YW5nLCBZaW5nDQoN
Cj4NCj4+IA0KPj4gR29vZMKgcXVlc3Rpb24swqBJwqBoYXZlwqBub8KgYW5zd2VywqB5ZXQswqBi
dXTCoEnCoHRoaW5rwqB3ZcKgY2FuwqBnZXTCoHRoZcKgZmFsbGJhY2vCoG9yZGVyDQo+PiBmcm9t
wqB0aGXCoGRtZXNnwqBub3cuDQo+PiANCj4+IFRoZcKgZnVydGhlcsKgYWN0aW9uwqBmb3LCoHVz
wqBpc8KgdGhhdMKgd2XCoHdpbGzCoGFsc2/CoHRyecKgaW1wcm92ZcKgdGhlwqB1c2XCoHNwYWNl
wqB0b29sLA0KPj4gc3VjaMKgYXPCoG51bWFjdGzCoHRvwqBzaG93wqB0aGXCoGRlbW90aW9uwqBw
YXRowqB3aXRowqB0aGXCoGhlbHDCoG9mwqB0aGlzwqBleHBvc2VkwqBpbmZvcm1hdGlvbi4NCg==

