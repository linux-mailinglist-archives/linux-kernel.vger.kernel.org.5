Return-Path: <linux-kernel+bounces-75513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF7B85E9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3B4284119
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E91272B3;
	Wed, 21 Feb 2024 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSMRNXxV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56867CF03;
	Wed, 21 Feb 2024 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550328; cv=none; b=fRZyPcBdfoCupn7T63iC5efLSI7RIfyOpCr691VqYc5L5ZOAXVC6qUyxH222Gz/ms3xu15DzHiYylPhMRmvv7qflH9rr+P2KXml3epfxHFyfy8OQIkGyOLx3ip5B6QxiWEgOW8IERwZiZFPK9l4Gs444cBA9WQBVxkwvWuEWsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550328; c=relaxed/simple;
	bh=DhCPdG9f8Kah1j1vo++kMiYvGYVWmU8eGfvXbTqXl0I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tkZINPReasSOpwCFv8ymbHveH6NjPMmrKRjUA4GWniyu4uYmkyPX+upIYC/oG92dy4DHglIzW9Wdx/1dr3noiJ7O/42qMGMZyLh6uOgt9r/Ar0GkMJOtIHFXmQHS5LVp6QpBZRJeXc4alF/qGZBpuTTt+giOWtt3YcK12FswXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSMRNXxV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708550327; x=1740086327;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DhCPdG9f8Kah1j1vo++kMiYvGYVWmU8eGfvXbTqXl0I=;
  b=kSMRNXxVnSRhKHCbE5JCeEDd6vLaJQeXUWZhcXcqM2VIXdGS1QIk4b3C
   wM4vn0pXlP/KJhBTmm0wPjx6/Lj1RVaXbGNvtNLsAt3ImJ64jXWwvWq1p
   XxA04z8oM5UVAC0JTooeQvauHCuFqYiWL/qJPGxeS+7Vc0y/ykSrxz1LT
   5KGtFwcUJTSE7dZl0zQ7NZNl8wotUHp1wgtcC496+yCjzYhBwSJbRerTc
   r25hTjlwXrtHyHbVmDQR6LB00Vg7i0RUZGTlaCb5CQyN7n4F5iNMfhzl/
   2JPjqj80SwIvopEHgyP04a+uXzuaYZIltqnHFCJJ3r0bIXZ++WG/Ind1k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14161362"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="14161362"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36052649"
Received: from allencha-mobl1.amr.corp.intel.com ([10.213.172.38])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:18:44 -0800
Message-ID: <d82015f3b373790e75dbf71e4f6d62cdbecb4bfc.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] crypto: iaa - fix the missing CRYPTO_ALG_ASYNC in
 cra_flags
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Barry Song <21cnbao@gmail.com>, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Date: Wed, 21 Feb 2024 15:18:43 -0600
In-Reply-To: <20240220044222.197614-2-v-songbaohua@oppo.com>
References: <20240220044222.197614-1-v-songbaohua@oppo.com>
	 <20240220044222.197614-2-v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQmFycnksCgpPbiBUdWUsIDIwMjQtMDItMjAgYXQgMTc6NDIgKzEzMDAsIEJhcnJ5IFNvbmcg
d3JvdGU6Cj4gQWRkIHRoZSBtaXNzaW5nIENSWVBUT19BTEdfQVNZTkMgZmxhZyBzaW5jZSBpbnRl
bCBpYWEgZHJpdmVyCj4gd29ya3MgYXN5bmNocm9ub3VzbHkuCj4gCj4gQ2M6IFRvbSBaYW51c3Np
IDx0b20uemFudXNzaUBsaW51eC5pbnRlbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQmFycnkgU29u
ZyA8di1zb25nYmFvaHVhQG9wcG8uY29tPgo+IC0tLQo+IMKgZHJpdmVycy9jcnlwdG8vaW50ZWwv
aWFhL2lhYV9jcnlwdG9fbWFpbi5jIHwgMSArCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vaW50ZWwvaWFhL2lhYV9jcnlw
dG9fbWFpbi5jCj4gYi9kcml2ZXJzL2NyeXB0by9pbnRlbC9pYWEvaWFhX2NyeXB0b19tYWluLmMK
PiBpbmRleCBkZmQzYmFmMGE4ZDguLjkxYWRmOWQ3NmEyZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2NyeXB0by9pbnRlbC9pYWEvaWFhX2NyeXB0b19tYWluLmMKPiArKysgYi9kcml2ZXJzL2NyeXB0
by9pbnRlbC9pYWEvaWFhX2NyeXB0b19tYWluLmMKPiBAQCAtMTkxNiw2ICsxOTE2LDcgQEAgc3Rh
dGljIHN0cnVjdCBhY29tcF9hbGcgaWFhX2Fjb21wX2ZpeGVkX2RlZmxhdGUKPiA9IHsKPiDCoMKg
wqDCoMKgwqDCoMKgLmJhc2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD0g
ewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmNyYV9uYW1lwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgPSAiZGVmbGF0ZSIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAuY3JhX2RyaXZlcl9uYW1lwqDCoMKgwqDCoMKgwqDCoD0gImRlZmxhdGUtaWFhIiwK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmNyYV9mbGFnc8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqA9IENSWVBUT19BTEdfQVNZTkMsCgpNYWtlcyBzZW5zZSwgdGhhbmtzIGZv
ciB0aGUgcGF0Y2guCgpBY2tlZC1ieTogVG9tIFphbnVzc2kgPHRvbS56YW51c3NpQGxpbnV4Lmlu
dGVsLmNvbT4KCgo=


