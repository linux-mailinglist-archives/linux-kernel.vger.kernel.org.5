Return-Path: <linux-kernel+bounces-168181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C50638BB4DF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1B9281C5A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EFE22F08;
	Fri,  3 May 2024 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngm3Yeap"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428637E;
	Fri,  3 May 2024 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768376; cv=none; b=J3HzGq31sVfzLNABSLVZBivZvUXOHhKFxIPXB0P7+vTLIZY3qgpXkCtVrVlsl6Py1IMv3RXI+Up5CJ+X8Rt9Zkbo1MTYwH99k6Ne+bn/PmmXu/9BFWGWNUY+PnxUFxMdbH8xG9bucX359OYOPCwX2smmd0J7HOYkVmCwtztr7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768376; c=relaxed/simple;
	bh=lLRSrEFOKeLd7wm/DXk6Glzr+B7ECHvb+9hKkMGORuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kkq0/g+cNDWVjHUT+VOaaOw7wFpCTWNtuEGzv1j3jwRz27kb9G4opB/nedO7Tc2v+LLcVmY3QstwWxKpE9F01ITC418rUYVITHeS1JSgGrrnl9/K1ocw7OYzCekZ+f/Ml82Nsuv1xKdYl5nJDDSianAnoq0N3QhBhq9RM4djicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngm3Yeap; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714768375; x=1746304375;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lLRSrEFOKeLd7wm/DXk6Glzr+B7ECHvb+9hKkMGORuA=;
  b=Ngm3YeapflW5N3uhfBQT7Z+VpR8M3EPT34NfkkAaHt5nK6hMHoIZRf+L
   ThnoQy4LJwffxifX9YRsiFIHSRpsltRYY76tTkXjhEDEPXZ6XiPxG6DwP
   ACJqBtA0W6jeMs9fWAGbZllMrqTw9rrPPnBOgPh6hKLg7GdZyC3sNZrqw
   9E5W6MqBWZlryqn8M3/IcLAmQvoCzHKFV2/V0nh3wYmPdGuuxJuEVhKOP
   tdyj2Q6Dq9soGL8uyzPK3yT4sAs5JcElrB8TuTBvVAJ0XAGaozNilSK0q
   XlIisD1ya0C4gdiq3bq8G44PiLXXfGqBADy/p14HmjHF+YP+lIa7hsAG/
   w==;
X-CSE-ConnectionGUID: SYqS9wqqT/aLeRxZG8id2w==
X-CSE-MsgGUID: FzqoMtDLSS+ciCYRxjzs2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28069040"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28069040"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:32:54 -0700
X-CSE-ConnectionGUID: 37gUMsnETu22TU2GxlUNnw==
X-CSE-MsgGUID: 1U/q5K/mTr2yZM/5yPcgjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="50748465"
Received: from eowusuan-mobl.amr.corp.intel.com ([10.209.164.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 13:32:53 -0700
Message-ID: <7da2bc1a966061aa11110f7e0304d82dfaa322e8.camel@linux.intel.com>
Subject: Re: [PATCH] crypto: iaa - Use kmemdup() instead of kzalloc() and
 memcpy()
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Herbert Xu
	 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 May 2024 15:32:52 -0500
In-Reply-To: <20240502153338.6945-2-thorsten.blum@toblux.com>
References: <20240502153338.6945-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgVGhvcnN0ZW4sCgpPbiBUaHUsIDIwMjQtMDUtMDIgYXQgMTc6MzMgKzAyMDAsIFRob3JzdGVu
IEJsdW0gd3JvdGU6Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyB0d28gQ29jY2luZWxsZS9jb2NjaWNo
ZWNrIHdhcm5pbmdzIHJlcG9ydGVkIGJ5Cj4gbWVtZHVwLmNvY2NpOgo+IAo+IMKgwqDCoMKgwqDC
oMKgwqBpYWFfY3J5cHRvX21haW4uYzozNTA6MTktMjY6IFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9y
IGttZW1kdXAKPiDCoMKgwqDCoMKgwqDCoMKgaWFhX2NyeXB0b19tYWluLmM6MzU4OjE4LTI1OiBX
QVJOSU5HIG9wcG9ydHVuaXR5IGZvciBrbWVtZHVwCj4gCj4gU2lnbmVkLW9mZi1ieTogVGhvcnN0
ZW4gQmx1bSA8dGhvcnN0ZW4uYmx1bUB0b2JsdXguY29tPgo+IC0tLQo+IMKgZHJpdmVycy9jcnlw
dG8vaW50ZWwvaWFhL2lhYV9jcnlwdG9fbWFpbi5jIHwgNiArKy0tLS0KPiDCoDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY3J5cHRvL2ludGVsL2lhYS9pYWFfY3J5cHRvX21haW4uYyBiL2RyaXZlcnMvY3J5cHRv
L2ludGVsL2lhYS9pYWFfY3J5cHRvX21haW4uYwo+IGluZGV4IGIyMTkxYWRlOTAxMS4uNzYzNWZi
ZWJlNTJmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL2ludGVsL2lhYS9pYWFfY3J5cHRv
X21haW4uYwo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2ludGVsL2lhYS9pYWFfY3J5cHRvX21haW4u
Ywo+IEBAIC0zNDcsMTggKzM0NywxNiBAQCBpbnQgYWRkX2lhYV9jb21wcmVzc2lvbl9tb2RlKGNv
bnN0IGNoYXIgKm5hbWUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGZy
ZWU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGxsX3RhYmxlKSB7Cj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoG1vZGUtPmxsX3RhYmxlID0ga3phbGxvYyhsbF90YWJsZV9zaXpl
LCBHRlBfS0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZS0+bGxf
dGFibGUgPSBrbWVtZHVwKGxsX3RhYmxlLCBsbF90YWJsZV9zaXplLCBHRlBfS0VSTkVMKTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghbW9kZS0+bGxfdGFibGUpCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmcmVlOwo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1jcHkobW9kZS0+bGxfdGFibGUsIGxs
X3RhYmxlLCBsbF90YWJsZV9zaXplKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG1vZGUtPmxsX3RhYmxlX3NpemUgPSBsbF90YWJsZV9zaXplOwo+IMKgwqDCoMKgwqDCoMKgwqB9
Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGRfdGFibGUpIHsKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbW9kZS0+ZF90YWJsZSA9IGt6YWxsb2MoZF90YWJsZV9zaXplLCBHRlBf
S0VSTkVMKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZS0+ZF90YWJsZSA9
IGttZW1kdXAoZF90YWJsZSwgZF90YWJsZV9zaXplLCBHRlBfS0VSTkVMKTsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghbW9kZS0+ZF90YWJsZSkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGZyZWU7Cj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbWNweShtb2RlLT5kX3RhYmxlLCBkX3RhYmxlLCBkX3Rh
YmxlX3NpemUpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9kZS0+ZF90YWJs
ZV9zaXplID0gZF90YWJsZV9zaXplOwo+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKCkxvb2tzIGdv
b2QsIHRoYW5rcyBmb3IgdGhlIGNsZWFudXAuCgpSZXZpZXdlZC1ieTogVG9tIFphbnVzc2kgPHRv
bS56YW51c3NpQGxpbnV4LmludGVsLmNvbT4KCg==


